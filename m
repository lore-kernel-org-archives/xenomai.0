Message-ID: <4F0C9FCD.8040603@domain.hid>
Date: Tue, 10 Jan 2012 21:30:05 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4F0B530A.80905@domain.hid>	<4F0C5524.9020501@domain.hid>	<4F0C58B7.1080602@domain.hid>	<4F0C5C00.3060508@domain.hid>	<4F0C5C02.50308@domain.hid>	<4F0C5C63.40105@domain.hid>	<4F0C5E85.5080004@domain.hid>	<4F0C7EAE.8080209@domain.hid>	<4F0C85E2.1070109@domain.hid>
	<4F0C8D0F.3080207@domain.hid>
In-Reply-To: <4F0C8D0F.3080207@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Issue with Auto relax and nested mutexes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Makarand Pradhan <makarandpradhan@domain.hid>
Cc: xenomai@xenomai.org

On 01/10/2012 08:10 PM, Makarand Pradhan wrote:
> The patch does work. Thanks.
>
> Will it be available in the next release of xenomai?
>

This needs more testing, but this bug is a must fix for 2.6.1 for sure. 
Your test code does help a lot in this respect. Thanks for the heads up.

> Rgds,
> Mak
>
> root@domain.hid:~# ./relax 0 1
> Spawning: tasks
> bP: 0, cp: 0, mode: 0
> Acquire complete
> Release complete
> bP: 0, cp: 0, mode: 0
> Acquire complete
> Release complete
> bP: 0, cp: 0, mode: 0
> Acquire complete
> Release complete
> bP: 0, cp: 0, mode: 0
> Acquire complete
> Grabbing mux in HP
> Mux held by Task2
> Release complete
> bP: 0, cp: 0, mode: 0
> Acquire complete
> Release complete
> bP: 0, cp: 0, mode: 0
> Acquire complete
> ^C
> root@domain.hid:~#
>
>
> On 10/01/12 01:39 PM, Makarand Pradhan wrote:
>> Hi Phillipe,
>>
>> A bit surprised to see a change in sched-rt.h. I had another problem
>> earlier where the XNOTHER was not getting set after a priority change. I
>> had to look at the code that you have modified. Although I had
>> temporarily worked around it by setting the XNOTHER in
>> rt_task_set_priority. I think this would fix that problem as well.
>>
>> Will test the patch and get back with the results.
>>
>> Thanks and Rgds,
>> Mak.
>>
>> On 10/01/12 01:08 PM, Philippe Gerum wrote:
>>> On 01/10/2012 04:51 PM, Makarand Pradhan wrote:
>>>> Based on my testing, it is noted that the rescnt is not released when
>>>> task1 gets a priority boost and starts running with priority 1. That's
>>>> when the rescnt is not decremented.
>>>>
>>>> It would imply that we may be checking the current priority while
>>>> testing if we want to invoke rt_mutex_release in kernel. Will try to
>>>> check it out.
>>> Does this help in your case?
>>>
>>> diff --git a/include/nucleus/sched-rt.h b/include/nucleus/sched-rt.h
>>> index cc1cefa..6ac8fd7 100644
>>> --- a/include/nucleus/sched-rt.h
>>> +++ b/include/nucleus/sched-rt.h
>>> @@ -87,7 +87,7 @@ static inline void __xnsched_rt_setparam(struct
>>> xnthread *thread,
>>> {
>>> thread->cprio = p->rt.prio;
>>> if (xnthread_test_state(thread, XNSHADOW)) {
>>> - if (thread->cprio)
>>> + if (thread->bprio || !xnthread_test_state(thread, XNBOOST))
>>> xnthread_clear_state(thread, XNOTHER);
>>> else
>>> xnthread_set_state(thread, XNOTHER);
>>>> Rgds,
>>>> Mak.
>>>>
>>>> On 10/01/12 10:42 AM, Philippe Gerum wrote:
>>>>> On 01/10/2012 04:40 PM, Philippe Gerum wrote:
>>>>>> On 01/10/2012 04:40 PM, Makarand Pradhan wrote:
>>>>>>> Another point:
>>>>>>>
>>>>>>> "These are fast mutexes, the thread does not have to jump to kernel
>>>>>>> space
>>>>>>> unless the released mutex was actually contented."
>>>>>>>
>>>>>>> When the first task is started with prio 0, I always see that
>>>>>>> rt_mutex_release is invoked in the kernel. even when there is no
>>>>>>> contention.
>>>>>> I should have added: "unless there is no contention ... or the
>>>>>> caller is
>>>>>> a non-rt thread". This is because we have to jump to kernel space to
>>>>>> track rescnt.
>>>>>>
>>>>> Ok, next try: "unless the mutex was contented ... or the caller is
>>>>> a non-rt thread".
>>>>>
>>>>>>> I have an instrumented kernel. The kernel trace is given below.
>>>>>>> In this
>>>>>>> trace only task1 is running at prio 0. It should be easy to follow:
>>>>>>>
>>>>>>> Jan 10 10:36:59 ruggedcom kernel: lo: rescnt: 0, switched: 0
>>>>>>> Jan 10 10:36:59 ruggedcom kernel: hi: rescnt: 0, switched: 0
>>>>>>> Jan 10 10:36:59 ruggedcom kernel: lo: rescnt: 1, switched: 1
>>>>>>> Jan 10 10:36:59 ruggedcom kernel: hi: rescnt: 2, switched: 0
>>>>>>> Jan 10 10:36:59 ruggedcom kernel: hi: rescnt: 3, switched: 0
>>>>>>> Jan 10 10:37:01 ruggedcom kernel: hi: rescnt: 3, switched: 0
>>>>>>> Jan 10 10:37:01 ruggedcom kernel: __rt_mutex_release
>>>>>>> Jan 10 10:37:01 ruggedcom kernel: RML
>>>>>>> Jan 10 10:37:01 ruggedcom kernel: rt_mutex_release: lockcnt: 1
>>>>>>> Jan 10 10:37:01 ruggedcom kernel: xnsynch_release_thread: BP: 0
>>>>>>> Jan 10 10:37:01 ruggedcom kernel: hi: rescnt: 2, switched: 0
>>>>>>> Jan 10 10:37:01 ruggedcom kernel: __rt_mutex_release
>>>>>>> Jan 10 10:37:01 ruggedcom kernel: RML
>>>>>>> Jan 10 10:37:01 ruggedcom kernel: rt_mutex_release: lockcnt: 1
>>>>>>> Jan 10 10:37:01 ruggedcom kernel: xnsynch_release_thread: BP: 0
>>>>>>> Jan 10 10:37:01 ruggedcom kernel: hi: rescnt: 1, switched: 0
>>>>>>> Jan 10 10:37:01 ruggedcom kernel: __rt_mutex_release
>>>>>>> Jan 10 10:37:01 ruggedcom kernel: RML
>>>>>>> Jan 10 10:37:01 ruggedcom kernel: rt_mutex_release: lockcnt: 1
>>>>>>> Jan 10 10:37:01 ruggedcom kernel: xnsynch_release_thread: BP: 0
>>>>>>> Jan 10 10:37:01 ruggedcom kernel: hi: rescnt: 0, switched: 0
>>>>>>> Jan 10 10:37:01 ruggedcom kernel: lo: rescnt: 1, switched: 1
>>>>>>> Jan 10 10:37:01 ruggedcom kernel: hi: rescnt: 2, switched: 0
>>>>>>> Jan 10 10:37:01 ruggedcom kernel: hi: rescnt: 3, switched: 0
>>>>>>> Jan 10 10:37:03 ruggedcom kernel: hi: rescnt: 3, switched: 0
>>>>>>> Jan 10 10:37:03 ruggedcom kernel: __rt_mutex_release
>>>>>>> Jan 10 10:37:03 ruggedcom kernel: RML
>>>>>>> Jan 10 10:37:03 ruggedcom kernel: rt_mutex_release: lockcnt: 1
>>>>>>> Jan 10 10:37:03 ruggedcom kernel: xnsynch_release_thread: BP: 0
>>>>>>> Jan 10 10:37:03 ruggedcom kernel: hi: rescnt: 2, switched: 0
>>>>>>> Jan 10 10:37:03 ruggedcom kernel: __rt_mutex_release
>>>>>>> Jan 10 10:37:03 ruggedcom kernel: RML
>>>>>>> Jan 10 10:37:03 ruggedcom kernel: rt_mutex_release: lockcnt: 1
>>>>>>> Jan 10 10:37:03 ruggedcom kernel: xnsynch_release_thread: BP: 0
>>>>>>> Jan 10 10:37:03 ruggedcom kernel: hi: rescnt: 1, switched: 0
>>>>>>> Jan 10 10:37:03 ruggedcom kernel: __rt_mutex_release
>>>>>>> Jan 10 10:37:03 ruggedcom kernel: RML
>>>>>>> Jan 10 10:37:03 ruggedcom kernel: rt_mutex_release: lockcnt: 1
>>>>>>> Jan 10 10:37:03 ruggedcom kernel: xnsynch_release_thread: BP: 0
>>>>>>> Jan 10 10:37:03 ruggedcom kernel: hi: rescnt: 0, switched: 0
>>>>>>> Jan 10 10:37:03 ruggedcom kernel: lo: rescnt: 1, switched: 1
>>>>>>> Jan 10 10:37:03 ruggedcom kernel: hi: rescnt: 2, switched: 0
>>>>>>> Jan 10 10:37:03 ruggedcom kernel: hi: rescnt: 3, switched: 0
>>>>>>> Jan 10 10:37:04 ruggedcom kernel: hi: rescnt: 3, switched: 0
>>>>>>>
>>>>>>>
>>>>>>> root@domain.hid:~# ./a.out 0 1
>>>>>>> Spawning: tasks
>>>>>>> bP: 0, cp: 0, mode: 0
>>>>>>> Acquire complete
>>>>>>> Release complete
>>>>>>> bP: 0, cp: 0, mode: 0
>>>>>>> Acquire complete
>>>>>>> Release complete
>>>>>>> bP: 0, cp: 0, mode: 0
>>>>>>> Acquire complete
>>>>>>> ^C
>>>>>>>
>>>>>>>
>>>>>>> Rgds,
>>>>>>> Mak.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 10/01/12 10:26 AM, Makarand Pradhan wrote:
>>>>>>>> Hi Phillippe,
>>>>>>>>
>>>>>>>> You are right. Task 1 requires to be started with prio 0. I start
>>>>>>>> seeing
>>>>>>>> the problem after task2 grabs the mutex and releases them. The
>>>>>>>> first
>>>>>>>> task never jumps back to seconodary. Here is my output. The mode
>>>>>>>> never
>>>>>>>> goes back to 0 after "Grabbing mux in HP" and the rescnt stays
>>>>>>>> stuck at
>>>>>>>> 1 in the kernel.
>>>>>>>>
>>>>>>>> root@domain.hid:~# ./relax 0 1
>>>>>>>> Spawning: tasks
>>>>>>>> bP: 0, cp: 0, mode: 0
>>>>>>>> Acquire complete
>>>>>>>> Release complete
>>>>>>>> bP: 0, cp: 0, mode: 0
>>>>>>>> Acquire complete
>>>>>>>> Release complete
>>>>>>>> bP: 0, cp: 0, mode: 0
>>>>>>>> Acquire complete
>>>>>>>> Release complete
>>>>>>>> bP: 0, cp: 0, mode: 0
>>>>>>>> Acquire complete
>>>>>>>> Grabbing mux in HP
>>>>>>>> Mux held by Task2
>>>>>>>> Release complete
>>>>>>>> bP: 0, cp: 0, mode: 1
>>>>>>>> Acquire complete
>>>>>>>> Release complete
>>>>>>>> bP: 0, cp: 0, mode: 1
>>>>>>>> Acquire complete
>>>>>>>>
>>>>>>>> Rgds,
>>>>>>>> Mak.
>>>>>>>>
>>>>>>>>
>>>>>>>> On 10/01/12 10:11 AM, Philippe Gerum wrote:
>>>>>>>>> On 01/09/2012 09:50 PM, Makarand Pradhan wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> I am running kernel 3.0.0, xenomai: 2.6, powerpc 8360.
>>>>>>>>>>
>>>>>>>>>> I am noticing an issue while using the auto relax feature
>>>>>>>>>> related to
>>>>>>>>>> mutexes. I am using nested mutexes. The code is attached to this
>>>>>>>>>> email.
>>>>>>>>>>
>>>>>>>>>> The problem is that I am not relaxing after a RT thread grabs and
>>>>>>>>>> releases a mutex. On further investigation, it was noted that the
>>>>>>>>>> rescnt
>>>>>>>>>> is not going down to 0.
>>>>>>>>> From your code, task1 would auto-relax only if started with
>>>>>>>>> priority 0,
>>>>>>>>> which is what I get here:
>>>>>>>>>
>>>>>>>>> -bash-3.2# ./relax 0 1
>>>>>>>>> Spawning: tasks
>>>>>>>>> bP: 0, cp: 0, mode: 0
>>>>>>>>> Acquire complete
>>>>>>>>> Release complete
>>>>>>>>> bP: 0, cp: 0, mode: 0
>>>>>>>>> Acquire complete
>>>>>>>>> Release complete
>>>>>>>>> bP: 0, cp: 0, mode: 0
>>>>>>>>> Acquire complete
>>>>>>>>> Release complete
>>>>>>>>> ...
>>>>>>>>>
>>>>>>>>> Conversely, I get the right behavior if setting a non-zero
>>>>>>>>> priority to
>>>>>>>>> task1:
>>>>>>>>>
>>>>>>>>> -bash-3.2# ./relax 1 0
>>>>>>>>> Spawning: tasks
>>>>>>>>> bP: 1, cp: 1, mode: 1
>>>>>>>>> Acquire complete
>>>>>>>>> Release complete
>>>>>>>>> bP: 1, cp: 1, mode: 1
>>>>>>>>> Acquire complete
>>>>>>>>> Release complete
>>>>>>>>> bP: 1, cp: 1, mode: 1
>>>>>>>>> Acquire complete
>>>>>>>>> ...
>>>>>>>>>
>>>>>>>>> In any case, the priority of task2 should have no impact on the
>>>>>>>>> result.
>>>>>>>>>
>>>>>>>>> I'm running current 2.6 HEAD commit (168da46de), kernel
>>>>>>>>> 3.1.5/powerpc32
>>>>>>>>> (52xx), pipeline 2.13-06.
>>>>>>>>>
>>>>>>>>> Which priority arguments are you passing to your test program?
>>>>>>>>>
>>>>>>>>>> Another observation is that I do not hit
>>>>>>>>>> rt_mutex_release in the kernel in the problem scenario, I believe
>>>>>>>>>> when
>>>>>>>>>> the thread undergoes a priority inversion.This may be a problem
>>>>>>>>>> as the
>>>>>>>>>> rescnt would not get decremented. Not sure how the mutex is
>>>>>>>>>> releasing
>>>>>>>>>> wiithout hitting rt_mutex_relase or am I missing anything?
>>>>>>>>>>
>>>>>>>>> These are fast mutexes, the thread does not have to jump to kernel
>>>>>>>>> space
>>>>>>>>> unless the released mutex was actually contented.
>>>>>>>>>
>>>>>>>>>> If I have both the tasks running at priority 0, I stay in the
>>>>>>>>>> secondary
>>>>>>>>>> domain, rt_mutex_release is invoked as expected, the rescnt goes
>>>>>>>>>> down to
>>>>>>>>>> 0 when all the mutexes are released.
>>>>>>>>>>
>>>>>>>>>> Has anyone faced this problem?
>>>>>>>>>>
>>>>>>>>> I'm unsure there is any yet. Auto-relax applies to non -rt Xenomai
>>>>>>>>> threads only (i.e. prio == 0).
>>>>>>>>>
>>>>>>>>>> Rgds,
>>>>>>>>>> Makarand
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> _______________________________________________
>>>>>>>>>> Xenomai-help mailing list
>>>>>>>>>> Xenomai-help@domain.hid
>>>>>>>>>> https://mail.gna.org/listinfo/xenomai-help
>>
>> --
>> ___________________________________________________________________________
>>
>> NOTICE OF CONFIDENTIALITY:
>> This e-mail and any attachments may contain confidential and
>> privileged information. If you are
>> not the intended recipient, please notify the sender immediately by
>> return e-mail and delete this
>> e-mail and any copies. Any dissemination or use of this information by
>> a person other than the
>> intended recipient is unauthorized and may be illegal.
>> _____________________________________________________________________
>>
>>
>>
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>
>


-- 
Philippe.

