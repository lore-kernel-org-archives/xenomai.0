Message-ID: <4E1C2912.9050605@domain.hid>
Date: Tue, 12 Jul 2011 12:59:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1QfDvt-0003TN-G7@domain.hid> <4E1B469A.8000703@domain.hid>
	<4E1B4AC0.80506@domain.hid> <4E1B4C19.2070205@domain.hid>
	<4E1B542B.2010906@domain.hid> <4E1B5638.1050005@domain.hid>
	<4E1B56E0.20109@domain.hid> <4E1B57D1.1070401@domain.hid>
	<4E1B5860.1000309@domain.hid> <4E1B5944.5030408@domain.hid>
	<4E1BEC9F.1020404@domain.hid> <4E1BF619.6010609@domain.hid>
In-Reply-To: <4E1BF619.6010609@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix race
 between gatekeeper and	thread deletion
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 07/12/2011 09:22 AM, Jan Kiszka wrote:
> On 2011-07-12 08:41, Gilles Chanteperdrix wrote:
>> On 07/11/2011 10:12 PM, Jan Kiszka wrote:
>>> On 2011-07-11 22:09, Gilles Chanteperdrix wrote:
>>>> On 07/11/2011 10:06 PM, Jan Kiszka wrote:
>>>>> On 2011-07-11 22:02, Gilles Chanteperdrix wrote:
>>>>>> On 07/11/2011 09:59 PM, Jan Kiszka wrote:
>>>>>>> On 2011-07-11 21:51, Gilles Chanteperdrix wrote:
>>>>>>>> On 07/11/2011 09:16 PM, Jan Kiszka wrote:
>>>>>>>>> On 2011-07-11 21:10, Jan Kiszka wrote:
>>>>>>>>>> On 2011-07-11 20:53, Gilles Chanteperdrix wrote:
>>>>>>>>>>> On 07/08/2011 06:29 PM, GIT version control wrote:
>>>>>>>>>>>> @@ -2528,6 +2534,22 @@ static inline void do_taskexit_event(struct task_struct *p)
>>>>>>>>>>>>  	magic = xnthread_get_magic(thread);
>>>>>>>>>>>>  
>>>>>>>>>>>>  	xnlock_get_irqsave(&nklock, s);
>>>>>>>>>>>> +
>>>>>>>>>>>> +	gksched = thread->gksched;
>>>>>>>>>>>> +	if (gksched) {
>>>>>>>>>>>> +		xnlock_put_irqrestore(&nklock, s);
>>>>>>>>>>>
>>>>>>>>>>> Are we sure irqs are on here? Are you sure that what is needed is not an
>>>>>>>>>>> xnlock_clear_irqon?
>>>>>>>>>>
>>>>>>>>>> We are in the context of do_exit. Not only IRQs are on, also preemption.
>>>>>>>>>> And surely no nklock is held.
>>>>>>>>>>
>>>>>>>>>>> Furthermore, I do not understand how we
>>>>>>>>>>> "synchronize" with the gatekeeper, how is the gatekeeper garanteed to
>>>>>>>>>>> wait for this assignment?
>>>>>>>>>>
>>>>>>>>>> The gatekeeper holds the gksync token while it's active. We request it,
>>>>>>>>>> thus we wait for the gatekeeper to become idle again. While it is idle,
>>>>>>>>>> we reset the queued reference - but I just realized that this may tramp
>>>>>>>>>> on other tasks' values. I need to add a check that the value to be
>>>>>>>>>> null'ified is actually still ours.
>>>>>>>>>
>>>>>>>>> Thinking again, that's actually not a problem: gktarget is only needed
>>>>>>>>> while gksync is zero - but then we won't get hold of it anyway and,
>>>>>>>>> thus, can't cause any damage.
>>>>>>>>
>>>>>>>> Well, you make it look like it does not work. From what I understand,
>>>>>>>> what you want is to set gktarget to null if a task being hardened is
>>>>>>>> destroyed. But by waiting for the semaphore, you actually wait for the
>>>>>>>> harden to be complete, so setting to NULL is useless. Or am I missing
>>>>>>>> something else?
>>>>>>>
>>>>>>> Setting to NULL is probably unneeded but still better than rely on the
>>>>>>> gatekeeper never waking up spuriously and then dereferencing a stale
>>>>>>> pointer.
>>>>>>>
>>>>>>> The key element of this fix is waitng on gksync, thus on the completion
>>>>>>> of the non-RT part of the hardening. Actually, this part usually fails
>>>>>>> as the target task received a termination signal at this point.
>>>>>>
>>>>>> Yes, but since you wait on the completion of the hardening, the test
>>>>>> if (target &&...) in the gatekeeper code will always be true, because at
>>>>>> this point the cleanup code will still be waiting for the semaphore.
>>>>>
>>>>> Yes, except we will ever wake up the gatekeeper later on without an
>>>>> updated gktarget, ie. spuriously. Better safe than sorry, this is hairy
>>>>> code anyway (hopefully obsolete one day).
>>>>
>>>> The gatekeeper is not woken up by posting the semaphore, the gatekeeper
>>>> is woken up by the thread which is going to be hardened (and this thread
>>>> is the one which waits for the semaphore).
>>>
>>> All true. And what is the point?
>>
>> The point being, would not something like this patch be sufficient?
>>
>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
>> index 01f4200..4742c02 100644
>> --- a/ksrc/nucleus/shadow.c
>> +++ b/ksrc/nucleus/shadow.c
>> @@ -2527,6 +2527,18 @@ static inline void do_taskexit_event(struct
>> task_struct *p)
>>  	magic = xnthread_get_magic(thread);
>>
>>  	xnlock_get_irqsave(&nklock, s);
>> +	if (xnthread_test_info(thread, XNATOMIC)) {
>> +		struct xnsched *gksched = xnpod_sched_slot(task_cpu(p));
> 
> That's not reliable, the task might have been migrated by Linux in the
> meantime. We must use the stored gksched.
> 
>> +		xnlock_put_irqrestore(&nklock, s);
>> +
>> +		/* Thread is in flight to primary mode, wait for the
>> +		   gatekeeper to be done with it. */
>> +		down(&gksched->gksync);
>> +		up(&gksched->gksync);
>> +
>> +		xnlock_get_irqsave(&nklock, s);
>> +	}
>> +
>>  	/* Prevent wakeup call from xnshadow_unmap(). */
>>  	xnshadow_thrptd(p) = NULL;
>>  	xnthread_archtcb(thread)->user_task = NULL;
>>
> 
> Again, setting gktarget to NULL and testing for NULL is simply safer,
> and I see no gain in skipping that. But if you prefer the
> micro-optimization, I'll drop it.

Could not we use an info bit instead of adding a pointer?

-- 
                                                                Gilles.

