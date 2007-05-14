From: CAMUS Benoit <benoit.camus@domain.hid>
In-Reply-To: <463B5E27.7050408@domain.hid>
References: <1178268043.5391.47.camel@domain.hid>
	<463B086B.6060402@domain.hid>  <463B5E27.7050408@domain.hid>
Content-Type: multipart/mixed; boundary="=-d1pDg3nIqSSLfPCqd1vU"
Date: Mon, 14 May 2007 12:09:44 +0200
Message-Id: <1179137384.4820.31.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-help] Latencies while ethernet access
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org


--=-d1pDg3nIqSSLfPCqd1vU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Before all thanks for your advices

I did some more researches, especially using ipipe tracer.

First thing that takes me on is IRQ canals:
/ # cat /proc/interrupts 
           CPU0
 11:         13          SC  pxa2xx-i2c
 15:       1143          SC  FFUART
 18:          0          SC  DMA
 19:     430054          SC  PXA Timer Tick
 27:       7335        GPIO  eth0
Err:          0

The tick timer seems to have IRQ's level lower than Ethernet once ?
I saw in ipipe code that IRQ from timer doesn't have same process than
others (_ipipe_ack_timerirq and __ipipe_ack_irq). I'm still reading code
to understand this.

Second is ipipe's trace of max latency path (see file attached), you can
see that shceduling in Linux domain have NMI noise, does it mean taht
it's a non-preempt part ? 
That could explain a part of latency during http access (ie fork that
infers scheduling).

So i'm searching for a way in better case, to reduce this latency, in
worst to bound it.
For now i'm looking at interrupt handling code both in Linux, Adeos and
Smc driver to determine if timer IRQ is well masked by Ethernet once and
how to hack it.

Any suggestions would be wellcome...


Ben

> Gilles Chanteperdrix wrote:
> > CAMUS Benoit wrote:
> >> Hi,
> >>
> >> I'm using Xenomai 2.3.1 with a 2.6.19.2 kernel (from ELDK) on a custom
> >> board based on Xscale PXA processor and with smc91c111 ethernet chip. 
> >> I did modifications on Linux kernel to port it on board and then just
> >> applied Adeos's patch following Xenomai's proceedings.
> >> Http and telnet servers are running on and i notice that latencies get
> >> really worse while i access any of them (see traces below).
> >>
> >> I understood that Adeos might avoid that kind of behavior due to its
> >> architecture. So i infer that the ethernet driver might access the
> >> hardware by-passing Adeos ?
> > 
> > Despite Adeos architecture, latency with Xenomai is known to depend on
> > the non real-time workload, because there are some low-level ressources
> > such as busses and processor cache that the real-time and non real-time
> > processes need to share.
> 
> Such effects can often be analysed with... the latency tracer [1]!
> 
> When some hardware interaction shows up right before the delayed timer
> (or whatever RT-)IRQ, Xenomai cannot help. But if there is something
> else, more fishy going on, you will see long interrupts-off sections,
> weird scheduling decisions, etc. Then our job starts again.
> 
> Jan
> 
> [1] http://www.xenomai.org/index.php/I-pipe:Tracer
> 

--=-d1pDg3nIqSSLfPCqd1vU
Content-Disposition: attachment; filename=ipipe_trace.txt
Content-Type: text/plain; name=ipipe_trace.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit


/ # latency -p 1000 -f 
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|     236.545|     246.310|     397.949|       0|     236.545|     397.949
RTD|     236.273|     247.124|     472.547|       0|     236.273|     472.547
RTD|     236.273|     240.342|     307.888|       0|     236.273|     472.547
RTD|     236.002|     240.614|     324.978|       0|     236.002|     472.547
RTD|     236.545|     240.614|     330.132|       0|     236.002|     472.547
RTD|     236.273|     240.885|     326.605|       0|     236.002|     472.547
RTD|     236.273|     240.885|     327.148|       0|     236.002|     472.547
RTD|     145.941|     238.986|     333.116|       0|     145.941|     472.547
RTD|     185.546|     265.028|     660.536|       0|     145.941|     660.536
RTD|     237.358|     496.961|     678.439|       0|     145.941|     678.439 ----> Http Access
RTD|     238.444|     510.525|     700.141|       0|     145.941|     700.141
RTD|     239.800|     516.221|     745.985|       0|     145.941|     745.985
RTD|     240.071|     514.594|     726.725|       0|     145.941|     745.985
RTD|     237.630|     493.435|     658.365|       0|     145.941|     745.985
RTD|     238.444|     494.520|     831.434|       0|     145.941|     831.434
RTD|     245.225|     493.977|     661.621|       0|     145.941|     831.434
RTD|     237.630|     492.350|     663.248|       0|     145.941|     831.434
RTD|     237.630|     494.520|     669.487|       0|     145.941|     831.434
RTD|     237.901|     498.860|     670.030|       0|     145.941|     831.434
RTD|     240.614|     509.168|     705.023|       0|     145.941|     831.434
RTD|     239.800|     518.391|     748.155|       0|     145.941|     831.434



/ # cat /proc/ipipe/trace/max 
I-pipe worst-case tracing service on 2.6.19.2/ipipe-1.6-04
------------------------------------------------------------
Begin: 9131170742 cycles, Trace Points: 14 (-10/+10), Length: 189 us
Calibrated minimum trace-point overhead: 3.000 us

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- Xenomai
 |||+-- IShield
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
 |   +end     0x80000000   -65    5.500N __ipipe_unstall_root+0x68 (sys_rt_sigsuspend+0xd4)
     +func                 -60    6.500N schedule+0x14 (sys_rt_sigsuspend+0x128)
     +func                 -53    6.750N profile_hit+0x10 (schedule+0x90)
     +func                 -47    7.000N sched_clock+0x10 (schedule+0x124)
     +func                 -40    6.500N __ipipe_stall_root+0x10 (schedule+0x1c0)
     #func                 -33    4.750N deactivate_task+0x10 (schedule+0x25c)
     #func                 -28   13.500N dequeue_task+0x10 (deactivate_task+0x38)
     #func                 -15    4.500N __ipipe_unstall_root+0x10 (schedule+0x530)
 |   #begin   0x80000000   -10    4.500  __ipipe_unstall_root+0x30 (schedule+0x530)
 |   +end     0x80000000    -6    6.250N __ipipe_unstall_root+0x68 (schedule+0x530)
>|   +begin   0x80000000     0+   7.750  schedule+0x5fc (sys_rt_sigsuspend+0x128)
:|   +func                   7+   6.500N atomic_notifier_call_chain+0x10 (__switch_to+0x44)
:|   +func                  14+   5.750N notifier_call_chain+0x10 (atomic_notifier_call_chain+0x3c)
:|   +func                  20+   9.250N nwfpe_notify+0x10 (notifier_call_chain+0x30)
:    +func                  29! 119.000N schedule_tail+0x10 (ret_from_fork+0x8)
:    +func                 148+   5.250N __ipipe_syscall_root+0x10 (vector_swi+0x70)
:    +func                 153+   6.000N sys_rt_sigprocmask+0x14 (ret_fast_syscall+0x0)
:    +func                 159+   4.750N sigprocmask+0x10 (sys_rt_sigprocmask+0xa0)
:    +func                 164+   7.000N __ipipe_stall_root+0x10 (sigprocmask+0x20)
:    #func                 171+   4.500N recalc_sigpending+0x10 (sigprocmask+0x114)
:    #func                 175+   5.000N recalc_sigpending_tsk+0x10 (recalc_sigpending+0x20)
:    #func                 180+   4.250N __ipipe_unstall_root+0x10 (sigprocmask+0x118)
:|   #begin   0x80000000   185+   4.500N __ipipe_unstall_root+0x30 (sigprocmask+0x118)
<|   +end     0x80000000   189   10.750N __ipipe_unstall_root+0x68 (sigprocmask+0x118)
     +func                 200    4.500N __ipipe_syscall_root+0x10 (vector_swi+0x70)
     +func                 204    4.250N sys_read+0x14 (ret_fast_syscall+0x0)
     +func                 209    6.500N fget_light+0x14 (sys_read+0x24)
     +func                 215    5.750N vfs_read+0x14 (sys_read+0x50)
     +func                 221    8.250N rw_verify_area+0x14 (vfs_read+0x8c)
     +func                 229    8.250N do_sync_read+0x14 (vfs_read+0xb8)
     +func                 237    5.500N pipe_read+0x18 (do_sync_read+0xc4)
     +func                 243    5.750N mutex_lock+0x10 (pipe_read+0x90)
     +func                 249    6.750N generic_pipe_buf_pin+0x10 (pipe_read+0xf4)
     +func                 255    0.000N generic_pipe_buf_map+0x10 (pipe_read+0x1b0)



/ # cat /proc/ipipe/trace/frozen 
I-pipe frozen back-tracing service on 2.6.19.2/ipipe-1.6-04
------------------------------------------------------------
Freeze: 9187269471 cycles, Trace Points: 30 (+10)
Calibrated minimum trace-point overhead: 3.000 us

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- Xenomai
 |||+-- IShield
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
:| #  begin   0x80000001  -190+   4.250N __ipipe_mach_get_tsc+0x48 (xntimer_do_tick_aperiodic+0x40)
:| #  end     0x80000001  -186+   7.750N __ipipe_mach_get_tsc+0x88 (xntimer_do_tick_aperiodic+0x40)
:| #  begin   0x80000001  -178+   5.250  __ipipe_mach_get_tsc+0x48 (xntimer_do_tick_aperiodic+0x40)
:| #  end     0x80000001  -173+   5.000N __ipipe_mach_get_tsc+0x88 (xntimer_do_tick_aperiodic+0x40)
:| #  begin   0x80000001  -168+   4.750  __ipipe_mach_get_tsc+0x48 (xntimer_do_tick_aperiodic+0x200)
:| #  end     0x80000001  -163!  10.250N __ipipe_mach_get_tsc+0x88 (xntimer_do_tick_aperiodic+0x200)
:| #  func                -153+   4.750N __ipipe_mach_set_dec+0x10 (xntimer_do_tick_aperiodic+0x2a8)
:| #  begin   0x80000001  -148+   5.500  __ipipe_mach_set_dec+0x44 (xntimer_do_tick_aperiodic+0x2a8)
:| #  end     0x80000001  -143+   7.500N __ipipe_mach_set_dec+0x68 (xntimer_do_tick_aperiodic+0x2a8)
:| #  func                -135+   5.000N rthal_irq_host_pend+0x10 (xnintr_irq_handler+0xe8)
:| #  func                -130+   5.500N __ipipe_schedule_irq+0x10 (rthal_irq_host_pend+0x20)
:| #  begin   0x80000001  -125+   7.750  __ipipe_schedule_irq+0x78 (rthal_irq_host_pend+0x20)
:| #  end     0x80000001  -117+   6.000N __ipipe_schedule_irq+0x118 (rthal_irq_host_pend+0x20)
:| +  func                -111+   6.000N __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x1dc)
:| +  end     0xffffffff  -105+   7.250N __ipipe_grab_irq+0xcc (__irq_svc+0x30)
:  +  func                 -98+   9.250N hisyscall_event+0x14 (__ipipe_dispatch_event+0xd8)
:  +  func                 -88+   4.250N __rt_timer_tsc+0x14 (hisyscall_event+0x160)
:  +  func                 -84!  15.250N rt_timer_tsc+0x10 (__rt_timer_tsc+0x1c)
:  +  func                 -69+   4.250N __ipipe_syscall_root+0x10 (vector_swi+0x70)
:  +  func                 -65+   4.500N __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0x88)
:  +  func                 -60+   5.250N hisyscall_event+0x14 (__ipipe_dispatch_event+0xd8)
:  +  func                 -55+   8.500N __rt_timer_tsc2ns+0x14 (hisyscall_event+0x160)
:  +  func                 -46!  11.000  rt_timer_tsc2ns+0x14 (__rt_timer_tsc2ns+0x34)
:  +  func                 -35+   4.250N __ipipe_syscall_root+0x10 (vector_swi+0x70)
:  +  func                 -31+   4.250N __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0x88)
:  +  func                 -27+   5.750N hisyscall_event+0x14 (__ipipe_dispatch_event+0xd8)
:  +  func                 -21+   5.750N xnshadow_sys_trace+0x10 (hisyscall_event+0x160)
:  +  func                 -15+   4.000N ipipe_trace_frozen_reset+0x10 (xnshadow_sys_trace+0x9c)
:  +  func                 -11!  11.750N __ipipe_global_path_lock+0x10 (ipipe_trace_frozen_reset+0x14)
<  +  freeze  0x000cafca     0    9.500N xnshadow_sys_trace+0xa8 (hisyscall_event+0x160)
   +  func                   9    4.250N __ipipe_syscall_root+0x10 (vector_swi+0x70)
   +  func                  13    4.500N __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0x88)
   +  func                  18    5.000N hisyscall_event+0x14 (__ipipe_dispatch_event+0xd8)
   +  func                  23    5.000N __rt_task_wait_period+0x14 (hisyscall_event+0x160)
   +  func                  28    5.000N rt_task_wait_period+0x10 (__rt_task_wait_period+0x54)
   +  func                  33    4.750N xnpod_wait_thread_period+0x14 (rt_task_wait_period+0x48)
 | +  begin   0x80000000    38    4.500N xnpod_wait_thread_period+0x44 (rt_task_wait_period+0x48)
 | #  func                  42    4.500N xntimer_get_raw_clock_aperiodic+0x10 (xnpod_wait_thread_period+0x7c)
 | #  begin   0x80000001    47    4.750N __ipipe_mach_get_tsc+0x48 (xntimer_get_raw_clock_aperiodic+0x14)
 | #  end     0x80000001    51    0.000N __ipipe_mach_get_tsc+0x88 (xntimer_get_raw_clock_aperiodic+0x14)

--=-d1pDg3nIqSSLfPCqd1vU--


