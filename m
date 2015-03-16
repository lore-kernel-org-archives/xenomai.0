Message-ID: <550731D5.1090706@xenomai.org>
Date: Mon, 16 Mar 2015 20:41:09 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <55005580.6050702@siemens.com> <5506EC14.9070302@xenomai.org>
 <5506F73B.5020103@siemens.com> <5506FE23.60408@siemens.com>
 <55070020.70002@xenomai.org> <550707E7.1000107@siemens.com>
 <55070FE3.9050803@siemens.com> <55072DDE.1070103@xenomai.org>
 <55073099.9000208@siemens.com>
In-Reply-To: <55073099.9000208@siemens.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3: smokey test sched_tp causes oops when run
	in gdb
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 03/16/2015 08:35 PM, Jan Kiszka wrote:
> On 2015-03-16 20:24, Philippe Gerum wrote:
>> On 03/16/2015 06:16 PM, Jan Kiszka wrote:
>>> On 2015-03-16 17:42, Jan Kiszka wrote:
>>>> On 2015-03-16 17:09, Philippe Gerum wrote:
>>>>> On 03/16/2015 05:00 PM, Jan Kiszka wrote:
>>>>>> On 2015-03-16 16:31, Jan Kiszka wrote:
>>>>>>> On 2015-03-16 15:43, Philippe Gerum wrote:
>>>>>>>> On 03/11/2015 03:47 PM, Jan Kiszka wrote:
>>>>>>>>> Hi Philippe,
>>>>>>>>>
>>>>>>>>> just happened to trigger the oops below by running
>>>>>>>>>
>>>>>>>>> gdb --args smokey --run=8
>>>>>>>>>
>>>>>>>>> That run already has troubles and generates different output than
>>>>>>>>> running the test without gdb surveillance, probably due to unexpected
>>>>>>>>> mode switches.
>>>>>>>>
>>>>>>>> Clearly, yes. GDB causes the test program to leave primary mode, which
>>>>>>>> changes the scheduling order, and therefore the output which depends on it.
>>>>>>>>
>>>>>>>>  But the real problem is that running the test again
>>>>>>>>> afterwards, with or without gdb, causes the oops. Registers contain
>>>>>>>>> suspicious "dead" patterns, thus we access invalid list elements. Do we
>>>>>>>>> miss a cleanup when terminating smokey in the gdb session?
>>>>>>>>>
>>>>>>>>
>>>>>>>> I could not reproduce this bug yet.
>>>>>>>>
>>>>>>>> There is no reason for ptracing the application to have any impact on
>>>>>>>> the housekeeping chores when it exits. The backtrace shows that
>>>>>>>> xnsched_tp_set_schedule() is walking through tp->threads, which seems to
>>>>>>>> link to a stale tcb. xnsched_tp_forget() would then be called twice,
>>>>>>>> leading to the fault.
>>>>>>>>
>>>>>>>> Normally, a thread that undergoes TP scheduling should be automatically
>>>>>>>> removed from tp->threads upon exit after this sequence took place:
>>>>>>>>
>>>>>>>> handle_taskexit_event -> __xnthread_cleanup -> cleanup_tcb ->
>>>>>>>> xnsched_forget -> xnsched_tp_forget
>>>>>>>>
>>>>>>>> For that bug to happen, either this assumption has to be wrong, or
>>>>>>>> xnsched_set_policy() is being silly at some point.
>>>>>>>>
>>>>>>>> Is this 100% reproducible on your end, and does this require the initial
>>>>>>>> gdb run to show up, or would that break even when running the sched_tp
>>>>>>>> twice without gdb?
>>>>>>>
>>>>>>> It is always reproducible, also with current next branch. And you need
>>>>>>> to run gdb beforehand, yes.
>>>>>>>
>>>>>>> I'll see if I can look into details.
>>>>>>
>>>>>> During cleanup of the first run under gdb, I get this one as expected
>>>>>> (and two more hits for thread and C):
>>>>>>
>>>>>> Breakpoint 1, xnsched_tp_forget (thread=0xffff88003ad07040) at ../kernel/xenomai/sched-tp.c:175
>>>>>> 175     {
>>>>>> (gdb) p thread->name
>>>>>> $3 = "threadA", '\000' <repeats 24 times>
>>>>>> (gdb) bt
>>>>>> #0  xnsched_tp_forget (thread=0xffff88003ad07040) at ../kernel/xenomai/sched-tp.c:175
>>>>>> #1  0xffffffff8114b19f in xnsched_forget (thread=<optimized out>) at ../include/xenomai/cobalt/kernel/sched.h:603
>>>>>> #2  cleanup_tcb (thread=<optimized out>) at ../kernel/xenomai/thread.c:467
>>>>>> #3  __xnthread_cleanup (curr=0xffff88003ad07040) at ../kernel/xenomai/thread.c:486
>>>>>> #4  0xffffffff811794fd in handle_taskexit_event (p=<optimized out>) at ../kernel/xenomai/posix/process.c:1028
>>>>>> #5  0xffffffff8117b49d in ipipe_kevent_hook (kevent=<optimized out>, data=0xffff88003cfcb870) at ../kernel/xenomai/posix/process.c:1228
>>>>>> #6  0xffffffff810fc6d1 in __ipipe_notify_kevent (kevent=<optimized out>, data=0xffff88003cfcb870) at ../kernel/ipipe/core.c:1092
>>>>>> #7  0xffffffff81050702 in do_exit (code=0) at ../kernel/exit.c:717
>>>>>> #8  0xffffffff810518a7 in SYSC_exit (error_code=<optimized out>) at ../kernel/exit.c:855
>>>>>> #9  SyS_exit (error_code=<optimized out>) at ../kernel/exit.c:853
>>>>>> #10 <signal handler called>
>>>>>> #11 0x00007ffff7354146 in ?? ()
>>>>>> #12 0xffff88003cfcde10 in ?? ()
>>>>>> #13 0xffffffff81a09260 in ?? ()
>>>>>> #14 0x0000000000000000 in ?? ()
>>>>>> (gdb) c
>>>>>> Continuing.
>>>>>>
>>>>>>
>>>>>> But then, when I start the test again (with or without gdb), I also get
>>>>>> this right at the beginning:
>>>>>>
>>>>>>
>>>>>> Breakpoint 1, xnsched_tp_forget (thread=0xffff88003ad07040) at ../kernel/xenomai/sched-tp.c:175
>>>>>> 175     {
>>>>>> (gdb) bt
>>>>>> #0  xnsched_tp_forget (thread=0xffff88003ad07040) at ../kernel/xenomai/sched-tp.c:175
>>>>>> #1  0xffffffff8113ebae in xnsched_forget (thread=<optimized out>) at ../include/xenomai/cobalt/kernel/sched.h:603
>>>>>> #2  xnsched_set_policy (thread=0xffff88003ad07040, sched_class=0xffffffff81a2bbe0 <xnsched_class_rt>, p=0xffff88003b813e00) at ../kernel/xenomai/sched.c:403
>>>>>> #3  0xffffffff8115184f in xnsched_tp_set_schedule (sched=0xffff88003ad07040, gps=0xffff88003ad08080) at ../kernel/xenomai/sched-tp.c:260
>>>>>> #4  0xffffffff8117c5df in set_tp_config (len=<optimized out>, config=<optimized out>, cpu=<optimized out>) at ../kernel/xenomai/posix/sched.c:284
>>>>>
>>>>> Yes, this one is the weird one. Normally, we should not find any TCB
>>>>> lingering in tp->threads, once threads A, B and C have exited and
>>>>> unlinked from it via xnsched_forget().
>>>>>
>>>>> That call on behalf of xnsched_tp_set_schedule() is aimed at moving all
>>>>> threads currently undergoing a TP schedule to the RT class, since we are
>>>>> about to change the scheduling data (i.e. time windows and partitions).
>>>>> Why tp->threads is not empty when running xnsched_tp_set_schedule() at
>>>>> the next program invocation is what needs to be explained.
>>>>
>>>> Under gdb supervision, some threads are added to the tp pool multiple
>>>> times:
>>>>
>>>> Breakpoint 1, xnsched_tp_declare (thread=0xffff88003ad07040, p=0xffff88003a7b7e20) at ../kernel/xenomai/sched-tp.c:160
>>>> 160     {
>>>> (gdb) bt
>>>> #0  xnsched_tp_declare (thread=0xffff88003ad07040, p=0xffff88003a7b7e20) at ../kernel/xenomai/sched-tp.c:160
>>>> #1  0xffffffff8113eb45 in xnsched_declare (p=<optimized out>, thread=<optimized out>, sched_class=<optimized out>) at ../include/xenomai/cobalt/kernel/sched.h:540
>>>> #2  xnsched_set_policy (thread=0xffff88003ad07040, sched_class=0xffff88003a7b7e20, p=0xffff88003a7b7e20) at ../kernel/xenomai/sched.c:390
>>>> #3  0xffffffff8114b7cf in __xnthread_set_schedparam (thread=0xffff88003ad07040, sched_class=<optimized out>, sched_param=<optimized out>) at ../kernel/xenomai/thread.c:1802
>>>> #4  0xffffffff8114b8cc in xnthread_set_schedparam (thread=0xffff88003ad07040, sched_class=0xffffffff81a2e400 <xnsched_class_tp>, sched_param=0xffff88003a7b7e20) at ../kernel/xenomai/thread.c:1772
>>>> #5  0xffffffff8118c2c3 in pthread_setschedparam_ex (param_ex=<optimized out>, policy=<optimized out>, thread=<optimized out>) at ../kernel/xenomai/posix/thread.c:271
>>>> #6  __cobalt_thread_setschedparam_ex (pth=<optimized out>, policy=<optimized out>, param_ex=<optimized out>, u_winoff=<optimized out>, u_promoted=<optimized out>) at ../kernel/xenomai/posix/thread.c:481
>>>> #7  0xffffffff8118c614 in cobalt_thread_setschedparam_ex (pth=140737352652544, policy=11, u_param=<optimized out>, u_winoff=0x7ffff7e94bec, u_promoted=0x7ffff7e94be8) at ../kernel/xenomai/posix/thread.c:509
>>>> #8  0xffffffff8118475a in handle_root_syscall (ipd=<optimized out>, regs=<optimized out>) at ../kernel/xenomai/posix/syscall.c:1058
>>>> #9  ipipe_syscall_hook (ipd=<optimized out>, regs=0xffff88003a7b7f58) at ../kernel/xenomai/posix/syscall.c:1107
>>>> #10 0xffffffff810fde9f in __ipipe_notify_syscall (regs=<optimized out>) at ../kernel/ipipe/core.c:1006
>>>> #11 <signal handler called>
>>>> #12 0x00007ffff77b7d25 in ?? ()
>>>> #13 0x5a5a5a5a00000001 in ?? ()
>>>> #14 0x0000000000000000 in ?? ()
>>>> (gdb) c
>>>> Continuing.
>>>>
>>>> Breakpoint 1, xnsched_tp_declare (thread=0xffff88003ad07040, p=0xffff88003a7b7e20) at ../kernel/xenomai/sched-tp.c:160
>>>> 160     {
>>>> (gdb) bt
>>>> #0  xnsched_tp_declare (thread=0xffff88003ad07040, p=0xffff88003a7b7e20) at ../kernel/xenomai/sched-tp.c:160
>>>> #1  0xffffffff8113eb45 in xnsched_declare (p=<optimized out>, thread=<optimized out>, sched_class=<optimized out>) at ../include/xenomai/cobalt/kernel/sched.h:540
>>>> #2  xnsched_set_policy (thread=0xffff88003ad07040, sched_class=0xffff88003a7b7e20, p=0xffff88003a7b7e20) at ../kernel/xenomai/sched.c:390
>>>> #3  0xffffffff8114b7cf in __xnthread_set_schedparam (thread=0xffff88003ad07040, sched_class=<optimized out>, sched_param=<optimized out>) at ../kernel/xenomai/thread.c:1802
>>>> #4  0xffffffff8114b8cc in xnthread_set_schedparam (thread=0xffff88003ad07040, sched_class=0xffffffff81a2e400 <xnsched_class_tp>, sched_param=0xffff88003a7b7e20) at ../kernel/xenomai/thread.c:1772
>>>> #5  0xffffffff8118c2c3 in pthread_setschedparam_ex (param_ex=<optimized out>, policy=<optimized out>, thread=<optimized out>) at ../kernel/xenomai/posix/thread.c:271
>>>> #6  __cobalt_thread_setschedparam_ex (pth=<optimized out>, policy=<optimized out>, param_ex=<optimized out>, u_winoff=<optimized out>, u_promoted=<optimized out>) at ../kernel/xenomai/posix/thread.c:481
>>>> #7  0xffffffff8118c614 in cobalt_thread_setschedparam_ex (pth=140737352652544, policy=11, u_param=<optimized out>, u_winoff=0x7ffff7e94bec, u_promoted=0x7ffff7e94be8) at ../kernel/xenomai/posix/thread.c:509
>>>> #8  0xffffffff8118475a in handle_root_syscall (ipd=<optimized out>, regs=<optimized out>) at ../kernel/xenomai/posix/syscall.c:1058
>>>> #9  ipipe_syscall_hook (ipd=<optimized out>, regs=0xffff88003a7b7f58) at ../kernel/xenomai/posix/syscall.c:1107
>>>> #10 0xffffffff810fde9f in __ipipe_notify_syscall (regs=<optimized out>) at ../kernel/ipipe/core.c:1006
>>>> #11 <signal handler called>
>>>> #12 0x00007ffff77b7d25 in ?? ()
>>>> #13 0x5a5a5a5a00000001 in ?? ()
>>>> #14 0x0000000000000000 in ?? ()
>>>>
>>>>
>>>> Could it be that some syscall is restarted after being interrupted by
>>>> ptrace?
>>>
>>> Don't understand the reason for this multiple calls in details yet, but
>>> you can also trigger the bug by invoking pthread_setschedparam_ex twice
>>> in smokey's sched-tp.c. Fix pushed to for-forge.
>>>
>>
>> This is what has to be fixed, because guarding would only paper over the
>> issue for TP, but the latter would bite the same way with other existing
>> or future policies.
> 
> You mean push the guard into xnsched_set_policy, e.g.?
> 

Or fix what might be a signal restart issue so that we don't end up
twice in xnsched_set_policy().

-- 
Philippe.

