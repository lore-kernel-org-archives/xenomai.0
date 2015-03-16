Message-ID: <5506FE23.60408@siemens.com>
Date: Mon, 16 Mar 2015 17:00:35 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <55005580.6050702@siemens.com> <5506EC14.9070302@xenomai.org>
 <5506F73B.5020103@siemens.com>
In-Reply-To: <5506F73B.5020103@siemens.com>
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
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 2015-03-16 16:31, Jan Kiszka wrote:
> On 2015-03-16 15:43, Philippe Gerum wrote:
>> On 03/11/2015 03:47 PM, Jan Kiszka wrote:
>>> Hi Philippe,
>>>
>>> just happened to trigger the oops below by running
>>>
>>> gdb --args smokey --run=8
>>>
>>> That run already has troubles and generates different output than
>>> running the test without gdb surveillance, probably due to unexpected
>>> mode switches.
>>
>> Clearly, yes. GDB causes the test program to leave primary mode, which
>> changes the scheduling order, and therefore the output which depends on it.
>>
>>  But the real problem is that running the test again
>>> afterwards, with or without gdb, causes the oops. Registers contain
>>> suspicious "dead" patterns, thus we access invalid list elements. Do we
>>> miss a cleanup when terminating smokey in the gdb session?
>>>
>>
>> I could not reproduce this bug yet.
>>
>> There is no reason for ptracing the application to have any impact on
>> the housekeeping chores when it exits. The backtrace shows that
>> xnsched_tp_set_schedule() is walking through tp->threads, which seems to
>> link to a stale tcb. xnsched_tp_forget() would then be called twice,
>> leading to the fault.
>>
>> Normally, a thread that undergoes TP scheduling should be automatically
>> removed from tp->threads upon exit after this sequence took place:
>>
>> handle_taskexit_event -> __xnthread_cleanup -> cleanup_tcb ->
>> xnsched_forget -> xnsched_tp_forget
>>
>> For that bug to happen, either this assumption has to be wrong, or
>> xnsched_set_policy() is being silly at some point.
>>
>> Is this 100% reproducible on your end, and does this require the initial
>> gdb run to show up, or would that break even when running the sched_tp
>> twice without gdb?
> 
> It is always reproducible, also with current next branch. And you need
> to run gdb beforehand, yes.
> 
> I'll see if I can look into details.

During cleanup of the first run under gdb, I get this one as expected
(and two more hits for thread and C):

Breakpoint 1, xnsched_tp_forget (thread=0xffff88003ad07040) at ../kernel/xenomai/sched-tp.c:175
175     {
(gdb) p thread->name
$3 = "threadA", '\000' <repeats 24 times>
(gdb) bt
#0  xnsched_tp_forget (thread=0xffff88003ad07040) at ../kernel/xenomai/sched-tp.c:175
#1  0xffffffff8114b19f in xnsched_forget (thread=<optimized out>) at ../include/xenomai/cobalt/kernel/sched.h:603
#2  cleanup_tcb (thread=<optimized out>) at ../kernel/xenomai/thread.c:467
#3  __xnthread_cleanup (curr=0xffff88003ad07040) at ../kernel/xenomai/thread.c:486
#4  0xffffffff811794fd in handle_taskexit_event (p=<optimized out>) at ../kernel/xenomai/posix/process.c:1028
#5  0xffffffff8117b49d in ipipe_kevent_hook (kevent=<optimized out>, data=0xffff88003cfcb870) at ../kernel/xenomai/posix/process.c:1228
#6  0xffffffff810fc6d1 in __ipipe_notify_kevent (kevent=<optimized out>, data=0xffff88003cfcb870) at ../kernel/ipipe/core.c:1092
#7  0xffffffff81050702 in do_exit (code=0) at ../kernel/exit.c:717
#8  0xffffffff810518a7 in SYSC_exit (error_code=<optimized out>) at ../kernel/exit.c:855
#9  SyS_exit (error_code=<optimized out>) at ../kernel/exit.c:853
#10 <signal handler called>
#11 0x00007ffff7354146 in ?? ()
#12 0xffff88003cfcde10 in ?? ()
#13 0xffffffff81a09260 in ?? ()
#14 0x0000000000000000 in ?? ()
(gdb) c
Continuing.


But then, when I start the test again (with or without gdb), I also get
this right at the beginning:


Breakpoint 1, xnsched_tp_forget (thread=0xffff88003ad07040) at ../kernel/xenomai/sched-tp.c:175
175     {
(gdb) bt
#0  xnsched_tp_forget (thread=0xffff88003ad07040) at ../kernel/xenomai/sched-tp.c:175
#1  0xffffffff8113ebae in xnsched_forget (thread=<optimized out>) at ../include/xenomai/cobalt/kernel/sched.h:603
#2  xnsched_set_policy (thread=0xffff88003ad07040, sched_class=0xffffffff81a2bbe0 <xnsched_class_rt>, p=0xffff88003b813e00) at ../kernel/xenomai/sched.c:403
#3  0xffffffff8115184f in xnsched_tp_set_schedule (sched=0xffff88003ad07040, gps=0xffff88003ad08080) at ../kernel/xenomai/sched-tp.c:260
#4  0xffffffff8117c5df in set_tp_config (len=<optimized out>, config=<optimized out>, cpu=<optimized out>) at ../kernel/xenomai/posix/sched.c:284
#5  __cobalt_sched_setconfig_np (cpu=<optimized out>, policy=11, u_config=<optimized out>, len=168, fetch_config=<optimized out>, ack_config=<optimized out>) at ../kernel/xenomai/posix/sched.c:617
#6  0xffffffff8117d31c in cobalt_sched_setconfig_np (cpu=<optimized out>, policy=<optimized out>, u_config=<optimized out>, len=<optimized out>) at ../kernel/xenomai/posix/sched.c:639
#7  0xffffffff8118475a in handle_root_syscall (ipd=<optimized out>, regs=<optimized out>) at ../kernel/xenomai/posix/syscall.c:1058
#8  ipipe_syscall_hook (ipd=<optimized out>, regs=0xffff88003b813f58) at ../kernel/xenomai/posix/syscall.c:1107
#9  0xffffffff810fde9f in __ipipe_notify_syscall (regs=<optimized out>) at ../kernel/ipipe/core.c:1006
#10 <signal handler called>
#11 0x00007f8d2f9d12c0 in ?? ()
Backtrace stopped: Cannot access memory at address 0x20040


Any bell ringing on your side?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

