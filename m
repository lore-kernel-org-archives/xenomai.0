Subject: Re: [Xenomai-core] [BUG] rt_task_delete kills caller
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44C0F36F.8040608@domain.hid>
References: <44C09BC0.4030307@domain.hid> <44C0A083.6000101@domain.hid>
	<44C0CD07.4070708@domain.hid>  <44C0F36F.8040608@domain.hid>
Content-Type: text/plain
Date: Fri, 21 Jul 2006 18:08:06 +0200
Message-Id: <1153498087.5019.57.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Fri, 2006-07-21 at 17:31 +0200, Jan Kiszka wrote:
> Jan Kiszka wrote:
> 
> > Jan Kiszka wrote:
> >   
> >> Jan Kiszka wrote:
> >>     
> >>> Hi,
> >>>
> >>> I stumbled over a strange behaviour of rt_task_delete for a created, set
> >>> periodic, but non-started task. The process gets killed on invocation,
> >>>       
> >> More precisely:
> >>
> >> (gdb) cont
> >> Program received signal SIG32, Real-time event 32.
> >>
> >> Weird. No kernel oops BTW.
> >>
> >>     
> >>> but only if rt_task_set_periodic was called with a non-zero start time.
> >>> Here is the demo code:
> >>>
> >>> #include <stdio.h>
> >>> #include <sys/mman.h>
> >>> #include <native/task.h>
> >>>
> >>> main()
> >>> {
> >>> 	RT_TASK task;
> >>>
> >>> 	mlockall(MCL_CURRENT|MCL_FUTURE);
> >>>
> >>> 	printf("rt_task_create=%d\n",
> >>> 		rt_task_create(&task, "task", 8192*4, 10, 0));
> >>>
> >>> 	printf("rt_task_set_periodic=%d\n",
> >>> 		rt_task_set_periodic(&task, rt_timer_read()+1, 100000));
> >>>
> >>> 	printf("rt_task_delete=%d\n",
> >>> 		rt_task_delete(&task));
> >>> }
> >>>
> >>> Once you skip rt_task_set_periodic or call it like this
> >>> rt_task_set_periodic(&task, TM_NOW, 100000), everything is fine. Tested
> >>> over trunk, but I guess over versions should suffer as well.
> >>>
> >>> I noticed that the difference seems to be related to the
> >>> xnpod_suspend_thread in xnpod_set_thread_periodic. That suspend is not
> >>> called on idate == XN_INFINITE. What is it for then, specifically if you
> >>> would call xnpod_suspend_thread(thread, xnpod_get_time()+period, period)
> >>> which should have the same effect like xnpod_suspend_thread(thread, 0,
> >>> period)?
> >>>       
> >
> > That difference is clear to me now: set_periodic with a start date !=
> > XN_INFINITE means "suspend the task immediately until the provided
> > release date" (RTFM...) while date == XN_INFINITE means "keep the task
> > running and schedule the first release on now+period".
> >
> > The actual problem seems to be related to sending SIGKILL on
> > rt_task_delete to the dying thread. This happens only in the failing
> > case. When xnpod_suspend_thread was not called, the thread seems to
> > self-terminate first so that rt_task_delete becomes a nop (no more task
> > registered at that point). I think we had this issue before. Was it
> > solved? [/me querying the archive now...]
> >
> >   
> The termination may be just a symptom. There is more likely a bug in the
> cross-task-set-periodic code. I just ran this code with XENO_OPT_DEBUG on:
> 
> #include <stdio.h>
> #include <sys/mman.h>
> #include <native/task.h>
> 
> void thread(void *arg)
> {
> 	printf("thread started\n");
> 	while (1) {
> 		rt_task_wait_period(NULL);
> 	}
> }
> 
> main()
> {
> 	RT_TASK task;
> 
> 	mlockall(MCL_CURRENT|MCL_FUTURE);
> 
> 	printf("rt_task_create=%d\n",
> 		rt_task_create(&task, "task", 0, 10, 0));
> 
> 	printf("rt_task_set_periodic=%d\n",
> 		rt_task_set_periodic(&task, rt_timer_read()+1000000,
> 				     1000000));
> 
> 	printf("rt_task_start=%d\n",
> 		rt_task_start(&task, thread, NULL));
> 
> 	printf("rt_task_delete=%d\n",
> 		rt_task_delete(&task));
> }
> 
> 
> The result (trunk rev. #1369):
> 
> root@domain.hid :/root# /tmp/task-delete 
> rt_task_create=0
> rt_task_set_periodic=0
>        c1187f38 c01335c2 00000004 c75116a8 c75115a0 5704ea7c 00000006 0008ca33 
>        00000001 00000001 002176c4 00000000 c1186000 c11c3360 c75115a0 c1187f4c 
>        c013e530 00000010 00000000 00000010 c1187f54 c013e9ad c1187f74 c013e68c 
> Call Trace:
>  <c013e530> xnshadow_harden+0x94/0x14a 
> Xenomai: fatal: Hardened thread task[989] running in Linux domain?! (status=0xc00084, sig=0, prev=task-delete[987])
>  CPU  PID    PRI      TIMEOUT  STAT      NAME
> >  0  0       10      0        01400080  ROOT
>    0  0        0      0        00000082  timsPipeReceiver
>    0  989     10      0        00c00180  task
> Timer: oneshot [tickval=1 ns, elapsed=27273167087]
> 
>        c116df04 c02aa242 c02bcd0a c116df40 c013da60 00000000 00000000 c02af4d3 
>        c1144000 ffffffff 00c00084 c7511090 c02de300 c02de300 00000282 c116df74 
>        c0133938 00000022 c02de300 c75115a0 c75115a0 00000022 c02de288 00000001 
> Call Trace:
>  <c0103835> show_stack_log_lvl+0x86/0x91  <c0103862> show_stack+0x22/0x27
>  <c013da60> schedule_event+0x1aa/0x2ee  <c0133938> __ipipe_dispatch_event+0x5e/0xdd
>  <c02998e0> schedule+0x426/0x632  <c01030c7> work_resched+0x6/0x1c
> I-pipe tracer log (30 points):
> func                    0 ipipe_trace_panic_freeze+0x8 (schedule_event+0x143)
> func                   -4 schedule_event+0xe (__ipipe_dispatch_event+0x5e)
> func                   -6 __ipipe_dispatch_event+0xe (schedule+0x426)
> func                   -9 __ipipe_stall_root+0x8 (schedule+0x197)
> func                  -11 sched_clock+0xa (schedule+0x112)
> func                  -12 profile_hit+0x9 (schedule+0x69)
> func                  -13 schedule+0xe (work_resched+0x6)
> func                  -15 __ipipe_stall_root+0x8 (syscall_exit+0x5)
> func                  -17 irq_exit+0x8 (__ipipe_sync_stage+0x107)
> func                  -19 __ipipe_unstall_iret_root+0x8 (restore_raw+0x0)
> func                  -25 preempt_schedule+0xb (try_to_wake_up+0x12d)
> func                  -26 __ipipe_restore_root+0x8 (try_to_wake_up+0xf6)
> func                  -28 enqueue_task+0xa (__activate_task+0x22)
> func                  -29 __activate_task+0x9 (try_to_wake_up+0xbd)
> func                  -31 sched_clock+0xa (try_to_wake_up+0x6c)
> func                  -33 __ipipe_test_and_stall_root+0x8 (try_to_wake_up+0x16)
> func                  -34 try_to_wake_up+0xe (wake_up_process+0x12)
> func                  -36 wake_up_process+0x8 (lostage_handler+0xac)
> func                  -41 lostage_handler+0xa (rthal_apc_handler+0x2c)
> func                  -42 rthal_apc_handler+0x8 (__ipipe_sync_stage+0xfa)
> func                  -44 __ipipe_sync_stage+0xe (__ipipe_syscall_root+0xa8)
> func                  -55 __ipipe_restore_pipeline_head+0x8 (rt_task_start+0x8c)
> [  982] sh      -1    -66 xnpod_schedule+0x80 (xnpod_start_thread+0x1e9)
> func                  -68 xnpod_schedule+0xe (xnpod_start_thread+0x1e9)
> func                  -77 __ipipe_schedule_irq+0xa (rthal_apc_schedule+0x34)
> func                  -78 rthal_apc_schedule+0x8 (schedule_linux_call+0xb4)
> func                  -81 schedule_linux_call+0xb (xnshadow_start+0x59)
> [  989] task    10    -91 xnpod_resume_thread+0x4a (xnshadow_start+0x29)
> func                  -93 xnpod_resume_thread+0xe (xnshadow_start+0x29)
> func                 -100 xnshadow_start+0xa (xnpod_start_thread+0x1e4)
> 
> 
> Don't think this is related to damn heat here, puh. ;)
> 
> It's more likely that the xnpod_suspend_thread in xnpod_set_thread_periodic on a
> not-yet-started thread has something to do with this, right?
> 

Yep. Wild guess for now, since xnpod_suspend_thread() sends a secondary
mode thread a SIGCHLD so that it calls back to switch to primary, I tend
to think that there is an expected situation encountered by
xnshadow_harden(). This condition would be raised by the sigwake handler
resuming a killed/next-to-be-killed Linux task. Well, I don't now yet.

> Jan
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



