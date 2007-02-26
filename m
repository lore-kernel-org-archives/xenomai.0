Message-ID: <45E2B3A1.8070102@domain.hid>
Date: Mon, 26 Feb 2007 11:17:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
References: <45DECFAF.60304@domain.hid> <45DF04F2.4020002@domain.hid>
	<45DF192C.6020505@domain.hid>
In-Reply-To: <45DF192C.6020505@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

Gilles Chanteperdrix wrote:
> Steven Scholz wrote:
> 
>>Hi all,
>>
>>
>>
>>>I am running 2.6.19 + adeos-ipipe-2.6.19-arm-1.6-02.patch + xenomai-svn-2007-02-22
>>>on an AT91RM9200 (160MHz/80MHz).
>>>
>>>When starting "latency -p 200" it runs for a while printing
>>>
>>>RTT|  00:05:37  (periodic user-mode task, 200 us period, priority 99)
>>>RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
>>>RTD|      11.200|     139.200|     236.800|       1|      10.800|     280.800
>>>RTD|      11.200|     146.400|     253.200|       1|      10.800|     280.800
>>>RTD|      11.200|     144.400|     240.400|       1|      10.800|     280.800
>>>
>>>but then hangs. The timer LED stops blinking. No "soft lockup detected" appears.
>>
>>
>>After patching kernel/sched.c
>>
>> #ifdef CONFIG_IPIPE
>>-       if (unlikely(!ipipe_root_domain_p))
>>-               return;
>>+       if (unlikely(!ipipe_root_domain_p)) {
>>+               ipipe_set_printk_sync(ipipe_current_domain);
>>+               ipipe_trace_panic_freeze();
>>+               ipipe_trace_panic_dump();
>>+               BUG();
>>+       }
>> #endif /* CONFIG_IPIPE */
>>
>>~ # cat /dev/zero > /dev/null &
>>~ # latency -p 400
>>== Sampling period: 400 us
>>== Test mode: periodic user-mode task
>>== All results in microseconds
>>warming up...
>>RTT|  00:00:01  (periodic user-mode task, 400 us period, priority 99)
>>RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
>>RTD|     146.000|     187.200|     258.000|       0|     146.000|     258.000
>>...
>>RTD|      72.400|     188.800|    3793.600|      97|      68.800|    4746.800
>>RTD|      70.800|     188.800|    3256.400|     107|      68.800|    4746.800
>>I-pipe tracer log (30 points):
>>func                    0 ipipe_trace_panic_freeze+0x10 (schedule+0x54)
>>func                   -2 schedule+0x14 (ret_slow_syscall+0x0)
>>func                   -6 __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x190)
>>[  183] display- 0    -11 xnpod_schedule+0x60c (xnintr_irq_handler+0x128)
>>[  184] samplin 99    -14 xnpod_schedule+0xb4 (xnpod_suspend_thread+0x178)
>>func                  -16 xnpod_schedule+0x14 (xnpod_suspend_thread+0x178)
>>func                  -18 xnpod_suspend_thread+0x14 (xnpod_wait_thread_period+0xb0)
>>func                  -21 xnpod_wait_thread_period+0x14 (rt_task_wait_period+0x4c)
>>func                  -23 rt_task_wait_period+0x10 (__rt_task_wait_period+0x54)
>>func                  -25 __rt_task_wait_period+0x14 (hisyscall_event+0x160)
>>func                  -27 hisyscall_event+0x14 (__ipipe_dispatch_event+0xc0)
>>func                  -29 __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0x88)
>>func                  -31 __ipipe_syscall_root+0x10 (vector_swi+0x68)
>>func                  -35 rt_timer_tsc+0x10 (__rt_timer_tsc+0x1c)
>>func                  -36 __rt_timer_tsc+0x14 (hisyscall_event+0x160)
>>func                  -39 hisyscall_event+0x14 (__ipipe_dispatch_event+0xc0)
>>func                  -40 __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0x88)
>>func                  -42 __ipipe_syscall_root+0x10 (vector_swi+0x68)
>>func                  -46 __ipipe_restore_pipeline_head+0x10 (xnpod_wait_thread_period+0x1b4)
>>[  184] samplin 99    -49 xnpod_schedule+0x60c (xnpod_suspend_thread+0x178)
>>[  183] display- 0    -53 xnpod_schedule+0xb4 (xnintr_irq_handler+0x128)
>>func                  -55 xnpod_schedule+0x14 (xnintr_irq_handler+0x128)
>>func                  -60 __ipipe_mach_set_dec+0x10 (xntimer_tick_aperiodic+0x2fc)
>>[  184] samplin 99    -69 xnpod_resume_thread+0x5c (xnthread_periodic_handler+0x30)
>>func                  -71 xnpod_resume_thread+0x10 (xnthread_periodic_handler+0x30)
>>func                  -73 xnthread_periodic_handler+0x10 (xntimer_tick_aperiodic+0xcc)
>>func                  -77 xntimer_tick_aperiodic+0x14 (xnpod_announce_tick+0x14)
>>func                  -79 xnpod_announce_tick+0x10 (xnintr_irq_handler+0x54)
>>func                  -82 xnintr_irq_handler+0x14 (xnintr_clock_handler+0x20)
>>func                  -84 xnintr_clock_handler+0x10 (__ipipe_dispatch_wired+0xe4)
>>kernel BUG at kernel/sched.c:3337!
>>Unable to handle kernel NULL pointer dereference at virtual address 00000000
>>pgd = c1a44000
>>[00000000] *pgd=21a1a031, *pte=00000000, *ppte=00000000
>>Internal error: Oops: 817 [#1]
>>Modules linked in:
>>CPU: 0
>>PC is at __bug+0x44/0x58
>>LR is at __ipipe_sync_stage+0x10/0x294
>>pc : [<c001ed08>]    lr : [<c0051414>]    Not tainted
>>sp : c1e8ff64  ip : 00000000  fp : c1e8ff74
>>r10: 003a5b10  r9 : c1e8e000  r8 : 00000000
>>r7 : 33333333  r6 : 00000000  r5 : c01ba860  r4 : 00000000
>>r3 : 00000000  r2 : c01ba880  r1 : 00000000  r0 : 00000001
>>Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
>>Control: C000717F
>>Table: 21A44000  DAC: 00000015
>>Process display-181 (pid: 183, stack limit = 0xc1e8e250)
>>Stack: (0xc1e8ff64 to 0xc1e90000)
>>ff60:          ffffffff c1e8ffac c1e8ff78 c0181588 c001ecd4 c1e8ff84 c0020340
>>ff80: c002007c ffffffff fefff000 00000000 33333333 00000000 c1e8e000 003a5b10
>>ffa0: 00000000 c1e8ffb0 c001ae04 c0181530 0011b333 33000000 07d00000 00000000
>>ffc0: 20280000 03200000 00000000 33333333 0000b714 0002e180 003a5b10 00011490
>>ffe0: 00800000 be7ffa4c fb500000 0000ace0 80000010 ffffffff d1208a16 010582a6
>>Backtrace:
>>[<c001ecc4>] (__bug+0x0/0x58) from [<c0181588>] (schedule+0x68/0x86c)
>> r4 = FFFFFFFF
>>[<c0181520>] (schedule+0x0/0x86c) from [<c001ae04>] (ret_slow_syscall+0x0/0x10)
>>Code: 1b0048fa e59f0014 eb0048f8 e3a03000 (e5833000)
>>
>>
>>Hope this helps!!!
> 
> 
> Just quoting the relevant part of the log you sent:
> I-pipe tracer log (16000 points):
>  |  +*func                    0 ipipe_trace_panic_freeze+0x10
> (schedule+0x74)
>  |  +*end     0x80000001     -3 schedule+0x6c (ret_slow_syscall+0x0)
>  |  +*begin   0x80000001     -7 schedule+0x54 (ret_slow_syscall+0x0)
>  |  +*func                  -11 schedule+0x14 (ret_slow_syscall+0x0)
>  |  +*end     0xffffffff    -15 __ipipe_grab_irq+0xd0 (__irq_usr+0x40)
>  |  +*func                  -19 __ipipe_walk_pipeline+0x10
> (__ipipe_handle_irq+0x190)
>  |  #*end     0x80000001    -23 __ipipe_mach_get_tsc+0x9c
> (xnintr_irq_handler+0x180)
>  |  #*begin   0x80000001    -26 __ipipe_mach_get_tsc+0x3c
> (xnintr_irq_handler+0x180)
>  |  #*end     0x80000001    -30 __ipipe_mach_get_tsc+0x9c
> (xnintr_irq_handler+0x14c)
>  |  #*begin   0x80000001    -34 __ipipe_mach_get_tsc+0x3c
> (xnintr_irq_handler+0x14c)
>  |  #*[  177] display- 0    -38 xnpod_schedule+0x740
> (xnintr_irq_handler+0x128)
>  |  #*end     0x80000001    -42 __ipipe_mach_get_tsc+0x9c
> (xnpod_schedule+0x5c0)
>  |  #*begin   0x80000001    -45 __ipipe_mach_get_tsc+0x3c
> (xnpod_schedule+0x5c0)
>  |  #*end     0x80000001    -49 __ipipe_mach_get_tsc+0x9c
> (xnpod_schedule+0x590)
>  |  #*begin   0x80000001    -52 __ipipe_mach_get_tsc+0x3c
> (xnpod_schedule+0x590)
>  |  #*end     0x80000001    -56 xnpod_schedule+0x104
> (xnpod_suspend_thread+0x1b4)
>  |  #*begin   0x80000001    -60 xnpod_schedule+0xec
> (xnpod_suspend_thread+0x1b4)
>  |  #*[  178] samplin 99    -63 xnpod_schedule+0xc8
> (xnpod_suspend_thread+0x1b4)
>  |  #*func                  -67 xnpod_schedule+0x14
> (xnpod_suspend_thread+0x1b4)
>  |  #*end     0x80000001    -70 xnpod_suspend_thread+0xb0
> (xnpod_wait_thread_period+0xc4)
>  |  #*begin   0x80000001    -74 xnpod_suspend_thread+0x98
> (xnpod_wait_thread_period+0xc4)
>  |  #*func                  -78 xnpod_suspend_thread+0x14
> (xnpod_wait_thread_period+0xc4)
>  |  #*end     0x80000001    -81 __ipipe_mach_get_tsc+0x9c
> (xnpod_wait_thread_period+0x84)
>  |  #*begin   0x80000001    -84 __ipipe_mach_get_tsc+0x3c
> (xnpod_wait_thread_period+0x84)
>  |  +*begin   0x80000000    -88 xnpod_wait_thread_period+0x50
> (rt_task_wait_period+0x4c)
>     +*func                  -91 xnpod_wait_thread_period+0x14
> (rt_task_wait_period+0x4c)
>     +*func                  -94 rt_task_wait_period+0x10
> (__rt_task_wait_period+0x54)
>     +*func                  -98 __rt_task_wait_period+0x14
> (hisyscall_event+0x160)
>     +*func                 -102 hisyscall_event+0x14
> (__ipipe_dispatch_event+0xe4)
>     +*func                 -105 __ipipe_dispatch_event+0x14
> (__ipipe_syscall_root+0x88)
>     +*func                 -109 __ipipe_syscall_root+0x10 (vector_swi+0x68)
>     +*func                 -115 rt_timer_tsc+0x10 (__rt_timer_tsc+0x1c)
>     +*func                 -118 __rt_timer_tsc+0x14 (hisyscall_event+0x160)
>     +*func                 -122 hisyscall_event+0x14
> (__ipipe_dispatch_event+0xe4)
>     +*func                 -126 __ipipe_dispatch_event+0x14
> (__ipipe_syscall_root+0x88)
>     +*func                 -130 __ipipe_syscall_root+0x10 (vector_swi+0x68)
>  |  +*end     0x80000000   -139 __ipipe_restore_pipeline_head+0x100
> (xnpod_wait_thread_period+0x1c8)
>  |  #*func                 -142 __ipipe_restore_pipeline_head+0x10
> (xnpod_wait_thread_period+0x1c8)
>  |  #*end     0x80000001   -146 __ipipe_mach_get_tsc+0x9c
> (xnpod_wait_thread_period+0xdc)
>  |  #*begin   0x80000001   -150 __ipipe_mach_get_tsc+0x3c
> (xnpod_wait_thread_period+0xdc)
>  |  #*[  178] samplin 99   -155 xnpod_schedule+0x740
> (xnpod_suspend_thread+0x1b4)
>  |  #*end     0x80000001   -159 __ipipe_mach_get_tsc+0x9c
> (xnpod_schedule+0x5c0)
>  |  #*begin   0x80000001   -163 __ipipe_mach_get_tsc+0x3c
> (xnpod_schedule+0x5c0)
>  |  #*end     0x80000001   -167 __ipipe_mach_get_tsc+0x9c
> (xnpod_schedule+0x590)
>  |  #*begin   0x80000001   -170 __ipipe_mach_get_tsc+0x3c
> (xnpod_schedule+0x590)
>  |  #*end     0x80000001   -175 xnpod_schedule+0x104
> (xnintr_irq_handler+0x128)
>  |  #*begin   0x80000001   -179 xnpod_schedule+0xec
> (xnintr_irq_handler+0x128)
>  |  #*[  177] display- 0   -182 xnpod_schedule+0xc8
> (xnintr_irq_handler+0x128)
>  |  #*func                 -186 xnpod_schedule+0x14
> (xnintr_irq_handler+0x128)
>  |  #*end     0x80000001   -190 __ipipe_mach_set_dec+0x64
> (xntimer_tick_aperiodic+0x2fc)
>  |  #*begin   0x80000001   -194 __ipipe_mach_set_dec+0x40
> (xntimer_tick_aperiodic+0x2fc)
>  |  #*func                 -197 __ipipe_mach_set_dec+0x10
> (xntimer_tick_aperiodic+0x2fc)
>  |  #*end     0x80000001   -203 __ipipe_mach_get_tsc+0x9c
> (xntimer_tick_aperiodic+0x248)
>  |  #*begin   0x80000001   -207 __ipipe_mach_get_tsc+0x3c
> (xntimer_tick_aperiodic+0x248)
>  |  #*end     0x80000001   -211 __ipipe_mach_get_tsc+0x9c
> (xntimer_tick_aperiodic+0xd0)
>  |  #*begin   0x80000001   -215 __ipipe_mach_get_tsc+0x3c
> (xntimer_tick_aperiodic+0xd0)
>  |  #*end     0x80000001   -219 xnpod_resume_thread+0x278
> (xnthread_periodic_handler+0x30)
>  |  #*begin   0x80000001   -223 xnpod_resume_thread+0x260
> (xnthread_periodic_handler+0x30)
>  |  #*[  178] samplin 99   -227 xnpod_resume_thread+0x70
> (xnthread_periodic_handler+0x30)
>  |  #*func                 -231 xnpod_resume_thread+0x10
> (xnthread_periodic_handler+0x30)
>  |  #*func                 -234 xnthread_periodic_handler+0x10
> (xntimer_tick_aperiodic+0xcc)
>  |  #*end     0x80000001   -238 __ipipe_mach_get_tsc+0x9c
> (xntimer_tick_aperiodic+0x2c)
>  |  #*begin   0x80000001   -242 __ipipe_mach_get_tsc+0x3c
> (xntimer_tick_aperiodic+0x2c)
>  |  #*func                 -245 xntimer_tick_aperiodic+0x14
> (xnpod_announce_tick+0x14)
>  |  #*func                 -248 xnpod_announce_tick+0x10
> (xnintr_irq_handler+0x54)
>  |  #*end     0x80000001   -252 __ipipe_mach_get_tsc+0x9c
> (xnintr_irq_handler+0x34)
>  |  #*begin   0x80000001   -255 __ipipe_mach_get_tsc+0x3c
> (xnintr_irq_handler+0x34)
>  |  #*func                 -259 xnintr_irq_handler+0x14
> (xnintr_clock_handler+0x20)
>  |  #*func                 -262 xnintr_clock_handler+0x10
> (__ipipe_dispatch_wired+0xe4)
>  |  +*func                 -266 __ipipe_dispatch_wired+0x10
> (__ipipe_handle_irq+0x9c)
>  |  +*func                 -269 at91_aic_unmask_irq+0x10
> (__ipipe_end_level_irq+0x28)
>  |  +*func                 -273 __ipipe_end_level_irq+0x10
> (__ipipe_ack_timerirq+0x4c)
>  |  +*func                 -276 __ipipe_mach_acktimer+0x10
> (__ipipe_ack_timerirq+0x30)
>  |  +*func                 -279 at91_aic_mask_irq+0x10
> (__ipipe_ack_level_irq+0x4c)
>  |  +*func                 -283 at91_aic_mask_irq+0x10
> (__ipipe_ack_level_irq+0x3c)
>  |  +*func                 -286 __ipipe_ack_level_irq+0x10
> (__ipipe_ack_timerirq+0x2c)
>  |  +*func                 -289 __ipipe_ack_timerirq+0x10
> (__ipipe_handle_irq+0x90)
>  |  +*func                 -293 __ipipe_handle_irq+0x14
> (__ipipe_grab_irq+0xc8)
>  |  +*begin   0xffffffff   -296 __ipipe_grab_irq+0x98 (__irq_usr+0x40)
>  |  +*func                 -300 __ipipe_grab_irq+0x10 (__irq_usr+0x40)
> 
> 
> It looks like schedule() is invoked upon return from a primary domain
> irq through ret_slow_syscall. Philippe, any idea ?
> 

Ok, found the bug (actually, Philippe did), as almost expected, the way
it is related to the latency program period is not really obvious. The
bug is that in the macro "irq_handler" in entry-armv.S, the return value
(in r0) of __ipipe_grab_irq is overriden by the subsequent call to
get_irqnr_and_base.

-- 
                                                 Gilles Chanteperdrix

