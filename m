Message-ID: <45DF04F2.4020002@domain.hid>
Date: Fri, 23 Feb 2007 16:14:58 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
References: <45DECFAF.60304@domain.hid>
In-Reply-To: <45DECFAF.60304@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
Cc: Xenomai-core@domain.hid

Hi all,

> I am running 2.6.19 + adeos-ipipe-2.6.19-arm-1.6-02.patch + xenomai-svn-2007-02-22
> on an AT91RM9200 (160MHz/80MHz).
> 
> When starting "latency -p 200" it runs for a while printing
> 
> RTT|  00:05:37  (periodic user-mode task, 200 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
> RTD|      11.200|     139.200|     236.800|       1|      10.800|     280.800
> RTD|      11.200|     146.400|     253.200|       1|      10.800|     280.800
> RTD|      11.200|     144.400|     240.400|       1|      10.800|     280.800
> 
> but then hangs. The timer LED stops blinking. No "soft lockup detected" appears.

After patching kernel/sched.c

 #ifdef CONFIG_IPIPE
-       if (unlikely(!ipipe_root_domain_p))
-               return;
+       if (unlikely(!ipipe_root_domain_p)) {
+               ipipe_set_printk_sync(ipipe_current_domain);
+               ipipe_trace_panic_freeze();
+               ipipe_trace_panic_dump();
+               BUG();
+       }
 #endif /* CONFIG_IPIPE */

~ # cat /dev/zero > /dev/null &
~ # latency -p 400
== Sampling period: 400 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 400 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|     146.000|     187.200|     258.000|       0|     146.000|     258.000
...
RTD|      72.400|     188.800|    3793.600|      97|      68.800|    4746.800
RTD|      70.800|     188.800|    3256.400|     107|      68.800|    4746.800
I-pipe tracer log (30 points):
func                    0 ipipe_trace_panic_freeze+0x10 (schedule+0x54)
func                   -2 schedule+0x14 (ret_slow_syscall+0x0)
func                   -6 __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x190)
[  183] display- 0    -11 xnpod_schedule+0x60c (xnintr_irq_handler+0x128)
[  184] samplin 99    -14 xnpod_schedule+0xb4 (xnpod_suspend_thread+0x178)
func                  -16 xnpod_schedule+0x14 (xnpod_suspend_thread+0x178)
func                  -18 xnpod_suspend_thread+0x14 (xnpod_wait_thread_period+0xb0)
func                  -21 xnpod_wait_thread_period+0x14 (rt_task_wait_period+0x4c)
func                  -23 rt_task_wait_period+0x10 (__rt_task_wait_period+0x54)
func                  -25 __rt_task_wait_period+0x14 (hisyscall_event+0x160)
func                  -27 hisyscall_event+0x14 (__ipipe_dispatch_event+0xc0)
func                  -29 __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0x88)
func                  -31 __ipipe_syscall_root+0x10 (vector_swi+0x68)
func                  -35 rt_timer_tsc+0x10 (__rt_timer_tsc+0x1c)
func                  -36 __rt_timer_tsc+0x14 (hisyscall_event+0x160)
func                  -39 hisyscall_event+0x14 (__ipipe_dispatch_event+0xc0)
func                  -40 __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0x88)
func                  -42 __ipipe_syscall_root+0x10 (vector_swi+0x68)
func                  -46 __ipipe_restore_pipeline_head+0x10 (xnpod_wait_thread_period+0x1b4)
[  184] samplin 99    -49 xnpod_schedule+0x60c (xnpod_suspend_thread+0x178)
[  183] display- 0    -53 xnpod_schedule+0xb4 (xnintr_irq_handler+0x128)
func                  -55 xnpod_schedule+0x14 (xnintr_irq_handler+0x128)
func                  -60 __ipipe_mach_set_dec+0x10 (xntimer_tick_aperiodic+0x2fc)
[  184] samplin 99    -69 xnpod_resume_thread+0x5c (xnthread_periodic_handler+0x30)
func                  -71 xnpod_resume_thread+0x10 (xnthread_periodic_handler+0x30)
func                  -73 xnthread_periodic_handler+0x10 (xntimer_tick_aperiodic+0xcc)
func                  -77 xntimer_tick_aperiodic+0x14 (xnpod_announce_tick+0x14)
func                  -79 xnpod_announce_tick+0x10 (xnintr_irq_handler+0x54)
func                  -82 xnintr_irq_handler+0x14 (xnintr_clock_handler+0x20)
func                  -84 xnintr_clock_handler+0x10 (__ipipe_dispatch_wired+0xe4)
kernel BUG at kernel/sched.c:3337!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c1a44000
[00000000] *pgd=21a1a031, *pte=00000000, *ppte=00000000
Internal error: Oops: 817 [#1]
Modules linked in:
CPU: 0
PC is at __bug+0x44/0x58
LR is at __ipipe_sync_stage+0x10/0x294
pc : [<c001ed08>]    lr : [<c0051414>]    Not tainted
sp : c1e8ff64  ip : 00000000  fp : c1e8ff74
r10: 003a5b10  r9 : c1e8e000  r8 : 00000000
r7 : 33333333  r6 : 00000000  r5 : c01ba860  r4 : 00000000
r3 : 00000000  r2 : c01ba880  r1 : 00000000  r0 : 00000001
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: C000717F
Table: 21A44000  DAC: 00000015
Process display-181 (pid: 183, stack limit = 0xc1e8e250)
Stack: (0xc1e8ff64 to 0xc1e90000)
ff60:          ffffffff c1e8ffac c1e8ff78 c0181588 c001ecd4 c1e8ff84 c0020340
ff80: c002007c ffffffff fefff000 00000000 33333333 00000000 c1e8e000 003a5b10
ffa0: 00000000 c1e8ffb0 c001ae04 c0181530 0011b333 33000000 07d00000 00000000
ffc0: 20280000 03200000 00000000 33333333 0000b714 0002e180 003a5b10 00011490
ffe0: 00800000 be7ffa4c fb500000 0000ace0 80000010 ffffffff d1208a16 010582a6
Backtrace:
[<c001ecc4>] (__bug+0x0/0x58) from [<c0181588>] (schedule+0x68/0x86c)
 r4 = FFFFFFFF
[<c0181520>] (schedule+0x0/0x86c) from [<c001ae04>] (ret_slow_syscall+0x0/0x10)
Code: 1b0048fa e59f0014 eb0048f8 e3a03000 (e5833000)


Hope this helps!!!

--
Steven

