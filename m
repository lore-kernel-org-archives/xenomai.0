Message-ID: <4926E494.8000602@domain.hid>
Date: Fri, 21 Nov 2008 17:40:52 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <49268B11.5090105@domain.hid>
	<49269929.5010804@domain.hid>	<49269FF8.9000209@domain.hid>
	<4926CCEF.8050106@domain.hid> <4926CDB3.2000601@domain.hid>
	<4926D25C.6060506@domain.hid>
In-Reply-To: <4926D25C.6060506@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Catch multiple xnshadow_map attempts
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> Jan Kiszka wrote:
>>>>>> My customer managed to find another hidden door to Xenomai's hell:
>>>>>> Trying to create a Xenomai POSIX thread from within a native thread. A
>>>>>> think the other way around would "work" as well. The precise scenario
>>>>>> was native thread -> dlopen(libs that's linked against libpthread_rt) ->
>>>>>> __init_posix_interface -> __wrap_pthread_setschedparam -> oops. That
>>>>>> scenario revealed two more issues in fact.
>>>>>>
>>>>>> Here is a patch to remove this hell gate by catching xnshadow_map
>>>>>> invocations from withing already mapped shadow thread.
>>>>>>
>>>>> Any reason why the XNMAPPED predicate did not work in your case?
>>>> Sorry, which one? Keep in mind that the thread thrown at the second
>>>> xnshadow_map is a virgin one, just allocated from scratch.
>>>>
>>> Ok, got it, it's the converse case, so let's deal for that:
>>>
>>> --- ksrc/nucleus/shadow.c	(revision 4411)
>>> +++ ksrc/nucleus/shadow.c	(working copy)
>>> @@ -1331,7 +1331,7 @@
>>>   * case, the real-time mapping operation has failed globally, and no
>>>   * Xenomai resource remains attached to it.
>>>   *
>>> - * - -EINVAL is returned if the thread control block does not bear the
>>> + * - -EBUSY is returned if the thread control block does not bear the
>>>   * XNSHADOW bit, or if the thread has already been mapped.
>>>   *
>>>   * Environments:
>>> @@ -1354,8 +1354,8 @@
>>>  	if (!xnthread_test_state(thread, XNSHADOW))
>>>  		return -EINVAL;
>>>
>>> -	if (xnthread_test_state(thread, XNMAPPED))
>>> -		return -EINVAL;
>>> +	if (xnshadow_thread(current) || xnthread_test_state(thread, XNMAPPED))
>>> +		return -EBUSY;
>>>
>>>  	if (!access_wok(u_mode, sizeof(*u_mode)))
>>>  		return -EFAULT;
>>>
>> --- ksrc/nucleus/shadow.c	(revision 4411)
>> +++ ksrc/nucleus/shadow.c	(working copy)
>> @@ -1332,8 +1332,10 @@
>>   * Xenomai resource remains attached to it.
>>   *
>>   * - -EINVAL is returned if the thread control block does not bear the
>> - * XNSHADOW bit, or if the thread has already been mapped.
>> + * XNSHADOW bit.
>>   *
>> + * - -EBUSY is returned if the thread has already been mapped.
>> + *
>>   * Environments:
> 
> The code now returns -EBUSY if someone passes down an already touched
> xnthread object - for me a clear case of EINVAL (the object should be a
> virgin one).

That's precisely a case for EBUSY; someone is attempting to reuse a TCB.

 EBUSY should be dedicated to the case that the current
> _Linux_task_ is already mapped (to some other xnthread object). I think
> my patch is clearer in this respect.
>

My intent regarding XNMAPPED was precisely to catch that case on the xnthread
struct, returning -EINVAL was a bad idea: this did not convey the right
information. Your addition completes that test by checking the task_struct side
as well. EINVAL should be kept for out-of-bound / badly specified input param;
in the XNMAPPED case, the xnthread struct is ok, but in the wrong state. This is
what EBUSY is supposed to say.

> Jan
> 


-- 
Philippe.

