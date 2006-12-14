From: Sebastian Smolorz <ssm@domain.hid>
Date: Thu, 14 Dec 2006 17:11:20 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oeXgFcektdwV8Bz"
Message-Id: <E1GutB2-0005VT-Vb@domain.hid>
Subject: [Adeos-main] Latency trace on ARM
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

--Boundary-00=_oeXgFcektdwV8Bz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

we all know that the latency test should not be run with a period of 100 us 
because it easily gets locked up. The attached trace illustrates this problem 
in detail. It shows that a timer interrupt needs about 50 us to be processed. 
Furthermore, there is not enough time between two timer interrupts for the 
latency task to get all its work done.

The current I-pipe tracer patch for ARM is available at 
http://opensource.emlix.com/ipipe-s3c24xx/download/ipipe-tracer-arm.patch_v4

Comments welcome.

--
Sebastian

--Boundary-00=_oeXgFcektdwV8Bz
Content-Type: text/plain;
  charset="us-ascii";
  name="ipipe-latency-trace"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ipipe-latency-trace"

# /testsuite/latency/latency -f -p 150
== Sampling period: 150 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 150 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      59.294|      89.882|     246.823|       1|      59.294|     252.941
RTD|      60.235|      90.705|     252.941|       2|      59.294|     252.941
RTD|      60.588|      90.117|     224.823|       2|      59.294|     252.941
RTD|      60.352|      90.352|     235.882|       2|      59.294|     252.941
RTD|      60.823|      90.235|     223.058|       2|      59.294|     252.941
RTD|      58.588|      90.352|     232.941|       2|      58.588|     252.941
RTD|      58.705|      90.235|     234.941|       2|      58.588|     252.941
RTD|      60.470|      90.352|     220.470|       2|      58.588|     252.941
RTD|      61.176|      90.117|     236.117|       2|      58.588|     252.941
RTD|      59.176|      90.352|     230.000|       2|      58.588|     252.941
RTD|      59.882|      90.235|     222.235|       2|      58.588|     252.941
RTD|      60.235|      90.352|     224.470|       2|      58.588|     252.941
RTD|      62.705|      90.235|     222.705|       2|      58.588|     252.941
---|------------|------------|------------|--------|-------------------------
RTS|      58.588|      90.235|     252.941|       2|    00:00:14/00:00:14

# cat frozen
I-pipe frozen back-tracing service on 2.6.15/ipipe-1.5-03
------------------------------------------------------------
Freeze: 1606645685 cycles, Trace Points: 110 (+10)

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- <unused>
 |||+-- Xenomai
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
:|  +*end     0x80000001  -310+   2.000N __ipipe_dispatch_event+0xc4 (__ipipe_syscall_root+0x88)
:   +*func                -308+   5.625N hisyscall_event+0x14 [xeno_nucleus] (__ipipe_dispatch_event+0xe0)
:   +*func                -303+   5.125N __rt_sem_v+0x14 [xeno_native] (hisyscall_event+0x160 [xeno_nucleus])
:   +*func                -297+   1.875N xnregistry_fetch+0x10 [xeno_nucleus] (__rt_sem_v+0x50 [xeno_native])
:|  +*begin   0x80000001  -296+   6.750  xnregistry_fetch+0x34 [xeno_nucleus] (__rt_sem_v+0x50 [xeno_native])
:|  #*func                -289+   3.000N __ipipe_restore_pipeline_head+0x10 (xnregistry_fetch+0xec [xeno_nucleus])
:|  +*end     0x80000000  -286+   2.750N __ipipe_restore_pipeline_head+0x104 (xnregistry_fetch+0xec [xeno_nucleus])
:   +*func                -283+   1.875N rt_sem_v+0x10 [xeno_native] (__rt_sem_v+0x60 [xeno_native])
:|  +*begin   0x80000001  -281+   4.625  rt_sem_v+0x38 [xeno_native] (__rt_sem_v+0x60 [xeno_native])
:|  #*func                -277+   5.875N xnsynch_wakeup_one_sleeper+0x10 [xeno_nucleus] (rt_sem_v+0x80 [xeno_native])
:|  #*func                -271+   3.875N xnpod_resume_thread+0x10 [xeno_nucleus] (xnsynch_wakeup_one_sleeper+0xc4 [xeno_nucleus])
:|  #*[  749] -<?>-    0  -267+   5.500N xnpod_resume_thread+0x70 [xeno_nucleus] (xnsynch_wakeup_one_sleeper+0xc4 [xeno_nucleus])
:|  #*func                -261+   3.125N xnpod_schedule+0x14 [xeno_nucleus] (rt_sem_v+0x8c [xeno_native])
:|  #*[  750] -<?>-   99  -258+   3.750N xnpod_schedule+0xc8 [xeno_nucleus] (rt_sem_v+0x8c [xeno_native])
:|  #*func                -254+   2.000N __ipipe_restore_pipeline_head+0x10 (rt_sem_v+0xbc [xeno_native])
:|  +*end     0x80000000  -252+   3.375N __ipipe_restore_pipeline_head+0x104 (rt_sem_v+0xbc [xeno_native])
:|  +*begin   0x80000001  -249+   2.625  __ipipe_dispatch_event+0x10c (__ipipe_syscall_root+0x88)
:|  +*end     0x80000001  -246+   7.500N __ipipe_dispatch_event+0x1b0 (__ipipe_syscall_root+0x88)
:   +*func                -239+   2.500N __ipipe_syscall_root+0x10 (vector_swi+0x64)
:   +*func                -236+   1.875N __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0x88)
:|  +*begin   0x80000001  -235+   2.500  __ipipe_dispatch_event+0x44 (__ipipe_syscall_root+0x88)
:|  +*end     0x80000001  -232+   1.875N __ipipe_dispatch_event+0xc4 (__ipipe_syscall_root+0x88)
:   +*func                -230+   4.875N hisyscall_event+0x14 [xeno_nucleus] (__ipipe_dispatch_event+0xe0)
:|  +*func                -225+   2.125N __ipipe_grab_irq+0x10 (__irq_svc+0x24)
:|  +*begin   0xffffffff  -223+   2.625  __ipipe_grab_irq+0x98 (__irq_svc+0x24)
:|  +*func                -221+   2.750N __ipipe_handle_irq+0x10 (__ipipe_grab_irq+0xd0)
:|  +*func                -218+   2.125N __ipipe_ack_timerirq+0x10 (__ipipe_handle_irq+0x8c)
:|  +*func                -216+   1.625N ipipe_test_and_stall_pipeline_from+0x10 (__ipipe_ack_timerirq+0x20)
:|  #*func                -214+   2.250N __ipipe_mach_acktimer+0x10 (__ipipe_ack_timerirq+0x28)
:|  #*func                -212+   2.125N s3c_irq_ack+0x10 (__ipipe_ack_timerirq+0x44)
:|  #*func                -210+   2.375N s3c_irq_unmask+0x10 (__ipipe_ack_timerirq+0x50)
:|  +*func                -207+   1.875N __ipipe_dispatch_wired+0x10 (__ipipe_handle_irq+0x98)
:|  #*func                -205+   2.375N xnintr_clock_handler+0x10 [xeno_nucleus] (__ipipe_dispatch_wired+0xe0)
:|  #*func                -203+   2.125N xnintr_irq_handler+0x14 [xeno_nucleus] (xnintr_clock_handler+0x20 [xeno_nucleus])
:|  #*func                -201+   2.750N __ipipe_mach_get_tsc+0x10 (xnintr_irq_handler+0x34 [xeno_nucleus])
:|  #*func                -198+   1.875N xnpod_announce_tick+0x10 [xeno_nucleus] (xnintr_irq_handler+0x54 [xeno_nucleus])
:|  #*func                -196+   2.875N xntimer_do_tick_aperiodic+0x14 [xeno_nucleus] (xnpod_announce_tick+0x20 [xeno_nucleus])
:|  #*func                -193+   2.375N __ipipe_mach_get_tsc+0x10 (xntimer_do_tick_aperiodic+0x48 [xeno_nucleus])
:|  #*func                -191+   2.500N xnthread_periodic_handler+0x10 [xeno_nucleus] (xntimer_do_tick_aperiodic+0xc0 [xeno_nucleus])
:|  #*func                -189+   2.125N __ipipe_mach_get_tsc+0x10 (xntimer_do_tick_aperiodic+0x48 [xeno_nucleus])
:|  #*func                -186+   4.000N __ipipe_mach_get_tsc+0x10 (xntimer_do_tick_aperiodic+0x204 [xeno_nucleus])
:|  #*func                -182+   5.000N __ipipe_mach_set_dec+0x14 (xntimer_do_tick_aperiodic+0x2b8 [xeno_nucleus])
:|  #*func                -177+   2.375N __ipipe_mach_get_tsc+0x10 (xnintr_irq_handler+0x14c [xeno_nucleus])
:|  #*func                -175+   2.250N __ipipe_mach_get_tsc+0x10 (xnintr_irq_handler+0x180 [xeno_nucleus])
:|  +*func                -173+   2.250N __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x1a8)
:|  +*end     0xffffffff  -171+   3.000N __ipipe_grab_irq+0xd8 (__irq_svc+0x24)
:   +*func                -168+   2.125N __rt_task_wait_period+0x14 [xeno_native] (hisyscall_event+0x160 [xeno_nucleus])
:   +*func                -165+   2.125N rt_task_wait_period+0x10 [xeno_native] (__rt_task_wait_period+0x54 [xeno_native])
:   +*func                -163+   2.250N xnpod_wait_thread_period+0x14 [xeno_nucleus] (rt_task_wait_period+0x54 [xeno_native])
:|  +*begin   0x80000001  -161+   2.625  xnpod_wait_thread_period+0x50 [xeno_nucleus] (rt_task_wait_period+0x54 [xeno_native])
:|  #*func                -158+   4.375N __ipipe_mach_get_tsc+0x10 (xnpod_wait_thread_period+0x84 [xeno_nucleus])
:|  #*func                -154+   1.750N __ipipe_restore_pipeline_head+0x10 (xnpod_wait_thread_period+0x1c4 [xeno_nucleus])
:|  +*end     0x80000000  -152+   3.000N __ipipe_restore_pipeline_head+0x104 (xnpod_wait_thread_period+0x1c4 [xeno_nucleus])
:|  +*begin   0x80000001  -149+   2.750  __ipipe_dispatch_event+0x10c (__ipipe_syscall_root+0x88)
:|  +*end     0x80000001  -147+   4.500N __ipipe_dispatch_event+0x1b0 (__ipipe_syscall_root+0x88)
:   +*func                -142+   1.750N __ipipe_syscall_root+0x10 (vector_swi+0x64)
:   +*func                -140+   1.875N __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0x88)
:|  +*begin   0x80000001  -138+   2.875  __ipipe_dispatch_event+0x44 (__ipipe_syscall_root+0x88)
:|  +*end     0x80000001  -136+   1.750N __ipipe_dispatch_event+0xc4 (__ipipe_syscall_root+0x88)
:   +*func                -134+   2.500N hisyscall_event+0x14 [xeno_nucleus] (__ipipe_dispatch_event+0xe0)
:   +*func                -131+   2.000N __rt_timer_tsc+0x14 [xeno_native] (hisyscall_event+0x160 [xeno_nucleus])
:   +*func                -129+   1.875N rt_timer_tsc+0x10 [xeno_native] (__rt_timer_tsc+0x1c [xeno_native])
:   +*func                -127+   1.875N __ipipe_mach_get_tsc+0x10 (rt_timer_tsc+0x14 [xeno_native])
:|  +*begin   0x80000001  -126+   2.000  __ipipe_mach_get_tsc+0x30 (rt_timer_tsc+0x14 [xeno_native])
:|  +*end     0x80000001  -124+   2.625N __ipipe_mach_get_tsc+0x6c (rt_timer_tsc+0x14 [xeno_native])
:|  +*begin   0x80000001  -121+   2.375  __ipipe_dispatch_event+0x10c (__ipipe_syscall_root+0x88)
:|  +*end     0x80000001  -119+   7.750N __ipipe_dispatch_event+0x1b0 (__ipipe_syscall_root+0x88)
:   +*func                -111+   2.250N __ipipe_syscall_root+0x10 (vector_swi+0x64)
:   +*func                -109+   2.125N __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0x88)
:|  +*begin   0x80000001  -106+   2.250  __ipipe_dispatch_event+0x44 (__ipipe_syscall_root+0x88)
:|  +*end     0x80000001  -104+   1.875N __ipipe_dispatch_event+0xc4 (__ipipe_syscall_root+0x88)
:   +*func                -102+   2.500N hisyscall_event+0x14 [xeno_nucleus] (__ipipe_dispatch_event+0xe0)
:   +*func                -100+   4.000N __rt_timer_tsc2ns+0x14 [xeno_native] (hisyscall_event+0x160 [xeno_nucleus])
:   +*func                 -96+   7.125N rt_timer_tsc2ns+0x14 [xeno_native] (__rt_timer_tsc2ns+0x38 [xeno_native])
:|  +*begin   0x80000001   -89+   2.500  __ipipe_dispatch_event+0x10c (__ipipe_syscall_root+0x88)
:|  +*end     0x80000001   -86+   2.875N __ipipe_dispatch_event+0x1b0 (__ipipe_syscall_root+0x88)
:   +*func                 -83+   1.875N __ipipe_syscall_root+0x10 (vector_swi+0x64)
:   +*func                 -81+   2.000N __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0x88)
:|  +*begin   0x80000001   -79+   2.250  __ipipe_dispatch_event+0x44 (__ipipe_syscall_root+0x88)
:|  +*end     0x80000001   -77+   1.500N __ipipe_dispatch_event+0xc4 (__ipipe_syscall_root+0x88)
:   +*func                 -76+   3.250N hisyscall_event+0x14 [xeno_nucleus] (__ipipe_dispatch_event+0xe0)
:   +*func                 -72+   3.875N xnshadow_sys_trace+0x10 [xeno_nucleus] (hisyscall_event+0x160 [xeno_nucleus])
:   +*func                 -69+   2.625N ipipe_trace_frozen_reset+0x10 (xnshadow_sys_trace+0x98 [xeno_nucleus])
:|  +*func                 -66+   2.625N __ipipe_grab_irq+0x10 (__irq_svc+0x24)
:|  +*begin   0xffffffff   -63+   2.000  __ipipe_grab_irq+0x98 (__irq_svc+0x24)
:|  +*func                 -61+   2.000N __ipipe_handle_irq+0x10 (__ipipe_grab_irq+0xd0)
:|  +*func                 -59+   1.750N __ipipe_ack_timerirq+0x10 (__ipipe_handle_irq+0x8c)
:|  +*func                 -58+   1.875N ipipe_test_and_stall_pipeline_from+0x10 (__ipipe_ack_timerirq+0x20)
:|  #*func                 -56+   2.000N __ipipe_mach_acktimer+0x10 (__ipipe_ack_timerirq+0x28)
:|  #*func                 -54+   2.625N s3c_irq_ack+0x10 (__ipipe_ack_timerirq+0x44)
:|  #*func                 -51+   2.375N s3c_irq_unmask+0x10 (__ipipe_ack_timerirq+0x50)
:|  +*func                 -49+   1.625N __ipipe_dispatch_wired+0x10 (__ipipe_handle_irq+0x98)
:|  #*func                 -47+   1.750N xnintr_clock_handler+0x10 [xeno_nucleus] (__ipipe_dispatch_wired+0xe0)
:|  #*func                 -45+   3.000N xnintr_irq_handler+0x14 [xeno_nucleus] (xnintr_clock_handler+0x20 [xeno_nucleus])
:|  #*func                 -42+   2.625N __ipipe_mach_get_tsc+0x10 (xnintr_irq_handler+0x34 [xeno_nucleus])
:|  #*func                 -40+   1.500N xnpod_announce_tick+0x10 [xeno_nucleus] (xnintr_irq_handler+0x54 [xeno_nucleus])
:|  #*func                 -38+   3.250N xntimer_do_tick_aperiodic+0x14 [xeno_nucleus] (xnpod_announce_tick+0x20 [xeno_nucleus])
:|  #*func                 -35+   3.000N __ipipe_mach_get_tsc+0x10 (xntimer_do_tick_aperiodic+0x48 [xeno_nucleus])
:|  #*func                 -32+   2.875N xnthread_periodic_handler+0x10 [xeno_nucleus] (xntimer_do_tick_aperiodic+0xc0 [xeno_nucleus])
:|  #*func                 -29+   1.750N __ipipe_mach_get_tsc+0x10 (xntimer_do_tick_aperiodic+0x48 [xeno_nucleus])
:|  #*func                 -27+   3.625N __ipipe_mach_get_tsc+0x10 (xntimer_do_tick_aperiodic+0x204 [xeno_nucleus])
:|  #*func                 -24+   4.000N __ipipe_mach_set_dec+0x14 (xntimer_do_tick_aperiodic+0x2b8 [xeno_nucleus])
:|  #*func                 -20+   2.125N __ipipe_mach_get_tsc+0x10 (xnintr_irq_handler+0x14c [xeno_nucleus])
:|  #*func                 -18+   1.875N __ipipe_mach_get_tsc+0x10 (xnintr_irq_handler+0x180 [xeno_nucleus])
:|  +*func                 -16+   2.000N __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x1a8)
:|  +*end     0xffffffff   -14+   2.625N __ipipe_grab_irq+0xd8 (__irq_svc+0x24)
:   +*func                 -11+   2.125N __ipipe_global_path_lock+0x10 (ipipe_trace_frozen_reset+0x14)
:|  +*begin   0x80000001    -9+   6.125  __ipipe_global_path_lock+0x30 (ipipe_trace_frozen_reset+0x14)
:|  +*end     0x80000001    -3+   3.250N __ipipe_global_path_unlock+0x68 (ipipe_trace_frozen_reset+0x68)
<   +*freeze  0x0003dc0d     0    3.000N xnshadow_sys_trace+0xa4 [xeno_nucleus] (hisyscall_event+0x160 [xeno_nucleus])
 |  +*begin   0x80000001     3    2.000N __ipipe_dispatch_event+0x10c (__ipipe_syscall_root+0x88)
 |  +*end     0x80000001     5    5.625N __ipipe_dispatch_event+0x1b0 (__ipipe_syscall_root+0x88)
    +*func                  10    1.875N __ipipe_syscall_root+0x10 (vector_swi+0x64)
    +*func                  12    1.875N __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0x88)
 |  +*begin   0x80000001    14    2.375N __ipipe_dispatch_event+0x44 (__ipipe_syscall_root+0x88)
 |  +*end     0x80000001    16    1.625N __ipipe_dispatch_event+0xc4 (__ipipe_syscall_root+0x88)
    +*func                  18    3.375N hisyscall_event+0x14 [xeno_nucleus] (__ipipe_dispatch_event+0xe0)
    +*func                  21    1.750N __rt_task_wait_period+0x14 [xeno_native] (hisyscall_event+0x160 [xeno_nucleus])
    +*func                  23    2.125N rt_task_wait_period+0x10 [xeno_native] (__rt_task_wait_period+0x54 [xeno_native])
    +*func                  25    0.000N xnpod_wait_thread_period+0x14 [xeno_nucleus] (rt_task_wait_period+0x54 [xeno_native])

--Boundary-00=_oeXgFcektdwV8Bz--

