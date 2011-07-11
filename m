Message-ID: <4E1B542B.2010906@domain.hid>
Date: Mon, 11 Jul 2011 21:51:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1QfDvt-0003TN-G7@domain.hid> <4E1B469A.8000703@domain.hid>
	<4E1B4AC0.80506@domain.hid> <4E1B4C19.2070205@domain.hid>
In-Reply-To: <4E1B4C19.2070205@domain.hid>
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

On 07/11/2011 09:16 PM, Jan Kiszka wrote:
> On 2011-07-11 21:10, Jan Kiszka wrote:
>> On 2011-07-11 20:53, Gilles Chanteperdrix wrote:
>>> On 07/08/2011 06:29 PM, GIT version control wrote:
>>>> @@ -2528,6 +2534,22 @@ static inline void do_taskexit_event(struct task_struct *p)
>>>>  	magic = xnthread_get_magic(thread);
>>>>  
>>>>  	xnlock_get_irqsave(&nklock, s);
>>>> +
>>>> +	gksched = thread->gksched;
>>>> +	if (gksched) {
>>>> +		xnlock_put_irqrestore(&nklock, s);
>>>
>>> Are we sure irqs are on here? Are you sure that what is needed is not an
>>> xnlock_clear_irqon?
>>
>> We are in the context of do_exit. Not only IRQs are on, also preemption.
>> And surely no nklock is held.
>>
>>> Furthermore, I do not understand how we
>>> "synchronize" with the gatekeeper, how is the gatekeeper garanteed to
>>> wait for this assignment?
>>
>> The gatekeeper holds the gksync token while it's active. We request it,
>> thus we wait for the gatekeeper to become idle again. While it is idle,
>> we reset the queued reference - but I just realized that this may tramp
>> on other tasks' values. I need to add a check that the value to be
>> null'ified is actually still ours.
> 
> Thinking again, that's actually not a problem: gktarget is only needed
> while gksync is zero - but then we won't get hold of it anyway and,
> thus, can't cause any damage.

Well, you make it look like it does not work. From what I understand,
what you want is to set gktarget to null if a task being hardened is
destroyed. But by waiting for the semaphore, you actually wait for the
harden to be complete, so setting to NULL is useless. Or am I missing
something else?

-- 
                                                                Gilles.

