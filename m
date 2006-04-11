Message-ID: <443C148C.1060504@domain.hid>
Date: Tue, 11 Apr 2006 22:41:48 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Fixs doxygen doc
	on	rt_queue_read	in	ksrc/native/queue.c (for SVN version)
References: <200604101640.04255.lbocseg@domain.hid>	<443BA12F.9020505@domain.hid>
	<443BB6B3.8060601@domain.hid> <443C109F.5080208@domain.hid>
In-Reply-To: <443C109F.5080208@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
> 
>> [a few interruptions later]
>>
>> Jan Kiszka wrote:
>>
>>> Rodrigo Rosenfeld Rosas wrote:
>>>
>>>> BTW, please, could someone confirm the rt_task_delete(NULL) bug in SVN?
>>>
>>>
>>> Half-confirmed, there is something fishy. I'm struggling with the
>>> debugger ATM, not sure yet who's wrong ;). It tells me rt_task_delete of
>>> the skin module is entered with task != NULL...
>>
>>
>>
>> ...which turns out to be fine, just appears redundant to me when
>> comparing __rt_task_delete and rt_task_delete for the task=NULL case.
>>
>> Anyway, leaving a native task with rt_task_delete(NULL) raises SIGKILL
>> to the whole process instead of just the task (pthread). This lets your
>> program terminate unexpectedly - I would say: a bug. And this doesn't
>> happen with 2.1?
>>
> 
> It's a side-effect of a recent bug fix in ksrc/nucleus/shadow.c; now 
> killing

Er, "deleting" is the right word here. Sending a thread a termination 
signal must kill the entire process as per POSIX, and will continue to 
do so. Calling rt_task_delete() to explicitely delete a single thread 
from within the containing process is another story. The current issue 
is due to the fact that no distinction is made on the caller: 
rt_task_delete() targeting a thread from another process should wipe out 
the entire target process; otherwise, only the local target thread 
should be deleted. It's not clear whether we should still wipe out the 
entire process when the target thread is not the current one, regardless 
of the fact such thread is a member of the same process or not.
I'm open to suggestions.

  a thread raises a group signal wiping out the entire process.
> Ok, it's a bit drastic, will fix.
> 
>> I guess the easiest way to solve this is to catch NULL in userspace and
>> call pthread_exit() in favour of the skin service (the POSIX skin uses
>> pthread_exit anyway), see attached patch. Someone just has to confirm
>> that there will be no problem hidden by this approach.
> 
> 
> Passing NULL needs to work including from user-space; the kernel-space 
> is ok with this, and the API must behave the same way regardless of the 
> execution space. Should fix as needed.
> 
>>
>> Jan
>>
>>
>> PS: What's the reason for "if (err == -ESRCH) return 0" in
>> src/skins/native/task.c, rt_task_delete? Why is that error generate in
>> the first place if it is zeroed out here?
>>
>>
>> ------------------------------------------------------------------------
>>
>> Index: src/skins/native/task.c
>> ===================================================================
>> --- src/skins/native/task.c    (revision 923)
>> +++ src/skins/native/task.c    (working copy)
>> @@ -212,7 +212,10 @@ int rt_task_delete (RT_TASK *task)
>>  {
>>      int err;
>>  
>> -    if (task && task->opaque2) {
>> +    if (!task)
>> +    pthread_exit(NULL);
>> +
>> +    if (task->opaque2) {
>>      err = pthread_cancel((pthread_t)task->opaque2);
>>      if (err)
>>          return -err;
> 
> 
> 


-- 

Philippe.

