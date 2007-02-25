From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-core] x86_64 - Initial results.
Date: Sun, 25 Feb 2007 22:38:29 +0000
References: <200702241526.22786.paul_c@domain.hid>
	<200702251842.25248.paul_c@domain.hid>
	<1172440830.12230.56.camel@domain.hid>
In-Reply-To: <1172440830.12230.56.camel@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_l/g4Fnktglh/6vQ"
Message-Id: <200702252238.29928.paul_c@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

--Boundary-00=_l/g4Fnktglh/6vQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi Philippe

On Sunday 25 February 2007 22:00, Philippe Gerum wrote:
> > Results are still the same - Latency goes to pot and hangs as soon as X
> > starts up. Quite likely the offending trace isn't getting logged..
>
> Just for the purpose of digging the issue further, does this particular
> problem persist when MTRRs are switched off from the kernel config?

I'd just finished compiling yet another kernel with CONFIG_MTRR disabled and 
was about to run another test..
Logs attached - Even with ipipe-trace enabled, latencies are acceptable when 
firing up X/KDE.. 


Regards, Paul.

--Boundary-00=_l/g4Fnktglh/6vQ
Content-Type: text/plain;
  charset="us-ascii";
  name="frozen"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="frozen"

I-pipe frozen back-tracing service on 2.6.19.3-xenomai/ipipe-1.0-04
------------------------------------------------------------
Freeze: 970774923862 cycles, Trace Points: 30 (+100)
Calibrated minimum trace-point overhead: 0.037 us

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- <unused>
 |||+-- Xenomai
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
:|  # func                  -3    0.067  xnpod_schedule+0x16 (xnintr_irq_handler+0x116)
:|  # [ 3008] Xorg    -1    -3    0.231  xnpod_schedule+0xa8 (xnintr_irq_handler+0x116)
:|  # func                  -2    0.343  __switch_to+0x16 (xnpod_schedule+0x80b)
:|  # [ 2716] samplin 99    -2    0.134  xnpod_schedule+0x848 (xnpod_suspend_thread+0x154)
:|  # func                  -2    0.065  __ipipe_restore_pipeline_head+0x16 (xnpod_wait_thread_period+0x11e)
:|  + end     0x80000000    -2    0.163  __ipipe_restore_pipeline_head+0xb1 (xnpod_wait_thread_period+0x11e)
:|  + begin   0x80000001    -2    0.073  __ipipe_dispatch_event+0xe9 (__ipipe_syscall_root+0x8d)
:|  + end     0x80000001    -2    0.088  __ipipe_dispatch_event+0x191 (__ipipe_syscall_root+0x8d)
:|  + begin   0x80000000    -2    0.326  __ipipe_syscall_root+0x14b (__ipipe_syscall_root_thunk+0x35)
:   + func                  -1    0.076  __ipipe_syscall_root+0xc (__ipipe_syscall_root_thunk+0x35)
:   + func                  -1    0.071  __ipipe_dispatch_event+0x16 (__ipipe_syscall_root+0x8d)
:|  + begin   0x80000001    -1    0.048  __ipipe_dispatch_event+0x37 (__ipipe_syscall_root+0x8d)
:|  + end     0x80000001    -1    0.070  __ipipe_dispatch_event+0xb6 (__ipipe_syscall_root+0x8d)
:   + func                  -1    0.098  hisyscall_event+0x21 (__ipipe_dispatch_event+0xc7)
:   + func                  -1    0.077  __rt_timer_tsc2ns+0xe [xeno_native] (hisyscall_event+0x1bb)
:   + func                  -1    0.144  rt_timer_tsc2ns+0x9 [xeno_native] (__rt_timer_tsc2ns+0x2c [xeno_native])
:|  + begin   0x80000001    -1    0.072  __ipipe_dispatch_event+0xe9 (__ipipe_syscall_root+0x8d)
:|  + end     0x80000001    -1    0.078  __ipipe_dispatch_event+0x191 (__ipipe_syscall_root+0x8d)
:|  + begin   0x80000000     0    0.139  __ipipe_syscall_root+0x14b (__ipipe_syscall_root_thunk+0x35)
:   + func                   0    0.063  __ipipe_syscall_root+0xc (__ipipe_syscall_root_thunk+0x35)
:   + func                   0    0.064  __ipipe_dispatch_event+0x16 (__ipipe_syscall_root+0x8d)
:|  + begin   0x80000001     0    0.056  __ipipe_dispatch_event+0x37 (__ipipe_syscall_root+0x8d)
:|  + end     0x80000001     0    0.061  __ipipe_dispatch_event+0xb6 (__ipipe_syscall_root+0x8d)
:   + func                   0    0.151  hisyscall_event+0x21 (__ipipe_dispatch_event+0xc7)
:   + func                   0    0.059  xnshadow_sys_trace+0x16 (hisyscall_event+0x1bb)
:   + func                   0    0.127  ipipe_trace_frozen_reset+0xa (xnshadow_sys_trace+0x8a)
:   + func                   0    0.051  __ipipe_global_path_lock+0xa (ipipe_trace_frozen_reset+0x14)
:|  + begin   0x80000001     0    0.120  __ipipe_global_path_lock+0x1c (ipipe_trace_frozen_reset+0x14)
:|  + end     0x80000001     0    0.066  __ipipe_global_path_unlock+0x62 (ipipe_trace_frozen_reset+0x61)
<   + freeze  0x0000543e     0    0.084  xnshadow_sys_trace+0x94 (hisyscall_event+0x1bb)
 |  + begin   0x80000001     0    0.062  __ipipe_dispatch_event+0xe9 (__ipipe_syscall_root+0x8d)
 |  + end     0x80000001     0    0.083  __ipipe_dispatch_event+0x191 (__ipipe_syscall_root+0x8d)
 |  + begin   0x80000000     0    0.131  __ipipe_syscall_root+0x14b (__ipipe_syscall_root_thunk+0x35)
    + func                   0    0.066  __ipipe_syscall_root+0xc (__ipipe_syscall_root_thunk+0x35)
    + func                   0    0.064  __ipipe_dispatch_event+0x16 (__ipipe_syscall_root+0x8d)
 |  + begin   0x80000001     0    0.057  __ipipe_dispatch_event+0x37 (__ipipe_syscall_root+0x8d)
 |  + end     0x80000001     0    0.071  __ipipe_dispatch_event+0xb6 (__ipipe_syscall_root+0x8d)
    + func                   0    0.083  hisyscall_event+0x21 (__ipipe_dispatch_event+0xc7)
    + func                   0    0.048  __rt_task_wait_period+0x19 [xeno_native] (hisyscall_event+0x1bb)
    + func                   0    0.052  rt_task_wait_period+0x9 [xeno_native] (__rt_task_wait_period+0x4f [xeno_native])
    + func                   0    0.047  xnpod_wait_thread_period+0x20 (rt_task_wait_period+0x35 [xeno_native])
 |  + begin   0x80000000     0    0.062  xnpod_wait_thread_period+0x40 (rt_task_wait_period+0x35 [xeno_native])
 |  # func                   0    0.076  xnpod_suspend_thread+0x21 (xnpod_wait_thread_period+0x99)
 |  # func                   0    0.069  xnpod_schedule+0x16 (xnpod_suspend_thread+0x154)
 |  # [ 2716] samplin 99     1    0.367  xnpod_schedule+0xa8 (xnpod_suspend_thread+0x154)
 |  # func                   1    0.267  __switch_to+0x16 (xnpod_schedule+0x80b)
 |  # [ 3008] Xorg    -1     1    0.231  xnpod_schedule+0x848 (xnintr_irq_handler+0x116)
 |   +func                   1    0.084  __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x1d2)
 |   +end     0x00000128     2    0.073  __ipipe_handle_irq+0x1da (common_interrupt+0x78)
 |   +begin   0x80000000     2   79.580  __ipipe_trace_irqs_off+0xe (__ipipe_trace_irqs_off_thunk+0x35)
 |   +begin   0x000000f7    81    0.071  ipipe_trace_begin_thunk+0x35 (__memcpy_fromio+0x12)
 |   +begin   0x80000000    81    0.049  __ipipe_trace_irqs_off+0xe (__ipipe_trace_irqs_off_thunk+0x35)
 |   +func                  81    0.066  __ipipe_handle_irq+0x21 (common_interrupt+0x78)
 |   +func                  81    0.070  __ipipe_ack_apic+0x9 (__ipipe_handle_irq+0x87)
 |   +func                  81    0.058  __ipipe_dispatch_wired+0xc (__ipipe_handle_irq+0x91)
 |  # func                  81    0.051  xnintr_clock_handler+0x9 (__ipipe_dispatch_wired+0x94)
 |  # func                  82    0.057  xnintr_irq_handler+0x21 (xnintr_clock_handler+0x1b)
 |  # func                  82    0.060  xnpod_announce_tick+0x9 (xnintr_irq_handler+0x53)
 |  # func                  82    0.065  xntimer_tick_aperiodic+0x12 (xnpod_announce_tick+0xe)
 |  # func                  82    0.064  xnthread_periodic_handler+0x9 (xntimer_tick_aperiodic+0x88)
 |  # func                  82    0.052  xnpod_resume_thread+0x10 (xnthread_periodic_handler+0x2d)
 |  # [ 2716] samplin 99    82    0.188  xnpod_resume_thread+0x5f (xnthread_periodic_handler+0x2d)
 |  # func                  82    0.068  xnpod_schedule+0x16 (xnintr_irq_handler+0x116)
 |  # [ 3008] Xorg    -1    82    0.233  xnpod_schedule+0xa8 (xnintr_irq_handler+0x116)
 |  # func                  82    0.286  __switch_to+0x16 (xnpod_schedule+0x80b)
 |  # [ 2716] samplin 99    83    0.152  xnpod_schedule+0x848 (xnpod_suspend_thread+0x154)
 |  # func                  83    0.055  __ipipe_restore_pipeline_head+0x16 (xnpod_wait_thread_period+0x11e)
 |  + end     0x80000000    83    0.161  __ipipe_restore_pipeline_head+0xb1 (xnpod_wait_thread_period+0x11e)
 |  + begin   0x80000001    83    0.066  __ipipe_dispatch_event+0xe9 (__ipipe_syscall_root+0x8d)
 |  + end     0x80000001    83    0.074  __ipipe_dispatch_event+0x191 (__ipipe_syscall_root+0x8d)
 |  + begin   0x80000000    83    0.293  __ipipe_syscall_root+0x14b (__ipipe_syscall_root_thunk+0x35)
    + func                  83    0.066  __ipipe_syscall_root+0xc (__ipipe_syscall_root_thunk+0x35)
    + func                  83    0.059  __ipipe_dispatch_event+0x16 (__ipipe_syscall_root+0x8d)
 |  + begin   0x80000001    84    0.069  __ipipe_dispatch_event+0x37 (__ipipe_syscall_root+0x8d)
 |  + end     0x80000001    84    0.065  __ipipe_dispatch_event+0xb6 (__ipipe_syscall_root+0x8d)
    + func                  84    0.078  hisyscall_event+0x21 (__ipipe_dispatch_event+0xc7)
    + func                  84    0.052  __rt_task_wait_period+0x19 [xeno_native] (hisyscall_event+0x1bb)
    + func                  84    0.048  rt_task_wait_period+0x9 [xeno_native] (__rt_task_wait_period+0x4f [xeno_native])
    + func                  84    0.048  xnpod_wait_thread_period+0x20 (rt_task_wait_period+0x35 [xeno_native])
 |  + begin   0x80000000    84    0.063  xnpod_wait_thread_period+0x40 (rt_task_wait_period+0x35 [xeno_native])
 |  # func                  84    0.057  xnpod_suspend_thread+0x21 (xnpod_wait_thread_period+0x99)
 |  # func                  84    0.065  xnpod_schedule+0x16 (xnpod_suspend_thread+0x154)
 |  # [ 2716] samplin 99    84    0.218  xnpod_schedule+0xa8 (xnpod_suspend_thread+0x154)
 |  # func                  84    0.247  __switch_to+0x16 (xnpod_schedule+0x80b)
 |  # [ 3008] Xorg    -1    85    0.222  xnpod_schedule+0x848 (xnintr_irq_handler+0x116)
 |   +func                  85    0.062  __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x1d2)
 |   +end     0x00000128    85    0.073  __ipipe_handle_irq+0x1da (common_interrupt+0x78)
 |   +begin   0x80000000    85   92.741  __ipipe_trace_irqs_off+0xe (__ipipe_trace_irqs_off_thunk+0x35)
 |   +begin   0x000000f7   178    0.059  ipipe_trace_begin_thunk+0x35 (__memcpy_fromio+0x12)
 |   +begin   0x80000000   178    0.054  __ipipe_trace_irqs_off+0xe (__ipipe_trace_irqs_off_thunk+0x35)
 |   +func                 178    0.066  __ipipe_handle_irq+0x21 (common_interrupt+0x78)
 |   +func                 178    0.070  __ipipe_ack_apic+0x9 (__ipipe_handle_irq+0x87)
 |   +func                 178    0.061  __ipipe_dispatch_wired+0xc (__ipipe_handle_irq+0x91)
 |  # func                 178    0.047  xnintr_clock_handler+0x9 (__ipipe_dispatch_wired+0x94)
 |  # func                 178    0.057  xnintr_irq_handler+0x21 (xnintr_clock_handler+0x1b)
 |  # func                 178    0.059  xnpod_announce_tick+0x9 (xnintr_irq_handler+0x53)
 |  # func                 178    0.059  xntimer_tick_aperiodic+0x12 (xnpod_announce_tick+0xe)
 |  # func                 178    0.069  xnthread_periodic_handler+0x9 (xntimer_tick_aperiodic+0x88)
 |  # func                 178    0.051  xnpod_resume_thread+0x10 (xnthread_periodic_handler+0x2d)
 |  # [ 2716] samplin 99   178    0.188  xnpod_resume_thread+0x5f (xnthread_periodic_handler+0x2d)
 |  # func                 179    0.072  xnpod_schedule+0x16 (xnintr_irq_handler+0x116)
 |  # [ 3008] Xorg    -1   179    0.228  xnpod_schedule+0xa8 (xnintr_irq_handler+0x116)
 |  # func                 179    0.310  __switch_to+0x16 (xnpod_schedule+0x80b)
 |  # [ 2716] samplin 99   179    0.153  xnpod_schedule+0x848 (xnpod_suspend_thread+0x154)
 |  # func                 179    0.052  __ipipe_restore_pipeline_head+0x16 (xnpod_wait_thread_period+0x11e)
 |  + end     0x80000000   179    0.167  __ipipe_restore_pipeline_head+0xb1 (xnpod_wait_thread_period+0x11e)
 |  + begin   0x80000001   179    0.065  __ipipe_dispatch_event+0xe9 (__ipipe_syscall_root+0x8d)
 |  + end     0x80000001   180    0.074  __ipipe_dispatch_event+0x191 (__ipipe_syscall_root+0x8d)
 |  + begin   0x80000000   180    0.298  __ipipe_syscall_root+0x14b (__ipipe_syscall_root_thunk+0x35)
    + func                 180    0.063  __ipipe_syscall_root+0xc (__ipipe_syscall_root_thunk+0x35)
    + func                 180    0.060  __ipipe_dispatch_event+0x16 (__ipipe_syscall_root+0x8d)
 |  + begin   0x80000001   180    0.069  __ipipe_dispatch_event+0x37 (__ipipe_syscall_root+0x8d)
 |  + end     0x80000001   180    0.061  __ipipe_dispatch_event+0xb6 (__ipipe_syscall_root+0x8d)
    + func                 180    0.084  hisyscall_event+0x21 (__ipipe_dispatch_event+0xc7)
    + func                 180    0.052  __rt_task_wait_period+0x19 [xeno_native] (hisyscall_event+0x1bb)
    + func                 180    0.047  rt_task_wait_period+0x9 [xeno_native] (__rt_task_wait_period+0x4f [xeno_native])
    + func                 180    0.052  xnpod_wait_thread_period+0x20 (rt_task_wait_period+0x35 [xeno_native])
 |  + begin   0x80000000   180    0.059  xnpod_wait_thread_period+0x40 (rt_task_wait_period+0x35 [xeno_native])
 |  # func                 180    0.057  xnpod_suspend_thread+0x21 (xnpod_wait_thread_period+0x99)
 |  # func                 181    0.068  xnpod_schedule+0x16 (xnpod_suspend_thread+0x154)
 |  # [ 2716] samplin 99   181    0.221  xnpod_schedule+0xa8 (xnpod_suspend_thread+0x154)
 |  # func                 181    0.234  __switch_to+0x16 (xnpod_schedule+0x80b)
 |  # [ 3008] Xorg    -1   181    0.235  xnpod_schedule+0x848 (xnintr_irq_handler+0x116)
 |   +func                 181    0.062  __ipipe_walk_pipeline+0x10 (__ipipe_handle_irq+0x1d2)
 |   +end     0x00000128   181    0.072  __ipipe_handle_irq+0x1da (common_interrupt+0x78)
 |   +begin   0x80000000   181  105.875  __ipipe_trace_irqs_off+0xe (__ipipe_trace_irqs_off_thunk+0x35)
 |   +begin   0x000000f7   287    0.059  ipipe_trace_begin_thunk+0x35 (__memcpy_fromio+0x12)
 |   +begin   0x80000000   287    0.114  __ipipe_trace_irqs_off+0xe (__ipipe_trace_irqs_off_thunk+0x35)
 |   +func                 287    0.062  __ipipe_handle_irq+0x21 (common_interrupt+0x78)
 |   +func                 288    0.000  __ipipe_ack_apic+0x9 (__ipipe_handle_irq+0x87)

--Boundary-00=_l/g4Fnktglh/6vQ
Content-Type: text/x-log;
  charset="us-ascii";
  name="latency.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="latency.log"

*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       2.015|       2.141|       3.223|       0|       2.015|       3.223
RTD|       1.942|       2.163|       6.166|       0|       1.942|       6.166
RTD|       1.848|       2.059|       5.935|       0|       1.848|       6.166
RTD|       1.899|       2.137|       5.901|       0|       1.848|       6.166
RTD|       1.937|       2.085|       5.990|       0|       1.848|       6.166
RTD|       1.924|       2.100|       5.822|       0|       1.848|       6.166
RTD|       1.875|       2.106|       6.086|       0|       1.848|       6.166
RTD|       1.812|       2.101|       3.423|       0|       1.812|       6.166
RTD|       1.842|       2.056|       3.969|       0|       1.812|       6.166
RTD|       1.877|       2.124|       3.717|       0|       1.812|       6.166
RTD|       1.925|       2.087|       3.004|       0|       1.812|       6.166
RTD|       1.698|       2.153|       3.455|       0|       1.698|       6.166
RTD|       1.916|       2.054|       3.091|       0|       1.698|       6.166
RTD|       1.834|       2.114|       3.277|       0|       1.698|       6.166
RTD|       1.862|       2.076|       3.120|       0|       1.698|       6.166
RTD|       1.919|       2.108|       2.633|       0|       1.698|       6.166
RTD|       1.756|       2.083|       2.950|       0|       1.698|       6.166
RTD|       1.927|       2.077|       2.901|       0|       1.698|       6.166
RTD|       1.788|       2.051|       3.148|       0|       1.698|       6.166
RTD|       1.927|       2.091|       7.752|       0|       1.698|       7.752
RTD|       1.744|       2.053|       3.045|       0|       1.698|       7.752
RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.916|       2.114|       4.340|       0|       1.698|       7.752
RTD|       1.768|       2.203|       3.566|       0|       1.698|       7.752
RTD|       1.801|       2.215|       6.171|       0|       1.698|       7.752
RTD|       1.823|       2.075|       3.254|       0|       1.698|       7.752
RTD|       1.931|       2.082|       7.030|       0|       1.698|       7.752
RTD|       1.920|       2.075|       3.191|       0|       1.698|       7.752
RTD|       1.919|       2.078|       5.899|       0|       1.698|       7.752
RTD|       1.902|       2.071|       2.736|       0|       1.698|       7.752
RTD|       1.766|       2.064|       6.381|       0|       1.698|       7.752
RTD|       1.893|       2.072|       2.978|       0|       1.698|       7.752
RTD|       1.924|       2.075|       3.174|       0|       1.698|       7.752
RTD|       1.916|       2.067|       3.130|       0|       1.698|       7.752
RTD|       1.913|       2.063|       3.229|       0|       1.698|       7.752
RTD|       1.774|       2.068|       6.941|       0|       1.698|       7.752
RTD|       1.814|       2.074|       6.614|       0|       1.698|       7.752
RTD|       1.921|       2.076|       5.925|       0|       1.698|       7.752
RTD|       1.682|       2.073|       3.331|       0|       1.682|       7.752
RTD|       1.922|       2.079|       3.648|       0|       1.682|       7.752
RTD|       1.808|       2.063|       3.492|       0|       1.682|       7.752
RTD|       1.802|       2.043|       3.495|       0|       1.682|       7.752
RTD|       1.909|       2.050|       3.232|       0|       1.682|       7.752
RTT|  00:00:43  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.676|       2.058|       8.308|       0|       1.676|       8.308
RTD|       1.919|       2.072|       3.004|       0|       1.676|       8.308
RTD|       1.712|       2.058|       3.034|       0|       1.676|       8.308
RTD|       1.803|       2.084|       3.140|       0|       1.676|       8.308
RTD|       1.903|       2.073|       2.878|       0|       1.676|       8.308
RTD|       1.912|       2.055|       6.437|       0|       1.676|       8.308
RTD|       1.922|       2.053|       3.610|       0|       1.676|       8.308
RTD|       1.617|       2.280|       6.609|       0|       1.617|       8.308
RTD|       1.713|       2.062|       3.261|       0|       1.617|       8.308
RTD|       1.682|       2.204|       4.791|       0|       1.617|       8.308
RTD|       1.625|       2.058|       3.502|       0|       1.617|       8.308
RTD|       1.631|       2.124|       4.134|       0|       1.617|       8.308
RTD|       1.599|       2.107|       4.538|       0|       1.599|       8.308
RTD|       1.633|       2.101|       4.716|       0|       1.599|       8.308
RTD|       1.621|       2.193|       5.189|       0|       1.599|       8.308
RTD|       1.606|       2.155|       4.737|       0|       1.599|       8.308
RTD|       1.679|       2.305|       6.208|       0|       1.599|       8.308
RTD|       1.623|       2.168|       5.856|       0|       1.599|       8.308
RTD|       1.670|       2.207|       5.904|       0|       1.599|       8.308
RTD|       1.636|       2.157|       5.905|       0|       1.599|       8.308
RTD|       1.623|       2.222|       5.900|       0|       1.599|       8.308
RTT|  00:01:04  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.609|       2.172|       5.915|       0|       1.599|       8.308
RTD|       1.713|       2.374|       5.917|       0|       1.599|       8.308
RTD|       1.666|       2.356|       5.992|       0|       1.599|       8.308
RTD|       1.612|       2.311|       5.906|       0|       1.599|       8.308
RTD|       1.687|       2.365|       5.923|       0|       1.599|       8.308
RTD|       1.761|       2.490|       7.308|       0|       1.599|       8.308
RTD|       1.694|       2.430|       5.816|       0|       1.599|       8.308
RTD|       1.696|       2.326|       5.771|       0|       1.599|       8.308
RTD|       1.644|       2.417|       5.791|       0|       1.599|       8.308
RTD|       1.691|       2.468|       5.977|       0|       1.599|       8.308
RTD|       1.570|       2.212|       5.866|       0|       1.570|       8.308
RTD|       1.599|       2.186|       5.820|       0|       1.570|       8.308
RTD|       1.577|       2.211|       5.844|       0|       1.570|       8.308
RTD|       1.665|       2.436|       4.977|       0|       1.570|       8.308
RTD|       1.601|       2.428|       4.898|       0|       1.570|       8.308
RTD|       1.678|       2.559|       5.656|       0|       1.570|       8.308
RTD|       1.672|       2.438|       6.141|       0|       1.570|       8.308
RTD|       1.719|       2.099|       6.009|       0|       1.570|       8.308
RTD|       1.876|       2.030|       3.197|       0|       1.570|       8.308
RTD|       1.876|       2.060|       4.906|       0|       1.570|       8.308
RTD|       1.873|       2.041|       3.078|       0|       1.570|       8.308
RTT|  00:01:25  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.667|       2.026|       3.791|       0|       1.570|       8.308
RTD|       1.671|       2.051|       3.725|       0|       1.570|       8.308
RTD|       1.868|       2.043|       3.510|       0|       1.570|       8.308
RTD|       1.881|       2.043|       3.365|       0|       1.570|       8.308
RTD|       1.867|       2.059|       5.233|       0|       1.570|       8.308
RTD|       1.862|       2.048|       3.453|       0|       1.570|       8.308
RTD|       1.754|       2.030|       3.919|       0|       1.570|       8.308
RTD|       1.875|       2.056|       4.476|       0|       1.570|       8.308
RTD|       1.869|       2.035|       3.290|       0|       1.570|       8.308
RTD|       1.872|       2.050|       3.589|       0|       1.570|       8.308
RTD|       1.865|       2.044|       2.553|       0|       1.570|       8.308
RTD|       1.736|       2.067|       3.365|       0|       1.570|       8.308
RTD|       1.743|       2.010|       3.538|       0|       1.570|       8.308
RTD|       1.876|       2.048|       3.787|       0|       1.570|       8.308
RTD|       1.868|       2.013|       3.321|       0|       1.570|       8.308
RTD|       1.875|       2.058|       3.872|       0|       1.570|       8.308
RTD|       1.724|       2.085|       4.367|       0|       1.570|       8.308
RTD|       1.763|       2.060|       6.154|       0|       1.570|       8.308
RTD|       1.876|       2.055|       3.211|       0|       1.570|       8.308
RTD|       1.871|       2.056|       3.011|       0|       1.570|       8.308
RTD|       1.865|       2.036|       4.059|       0|       1.570|       8.308
RTT|  00:01:46  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.797|       2.082|       3.794|       0|       1.570|       8.308
RTD|       1.822|       2.043|       3.135|       0|       1.570|       8.308
RTD|       1.857|       2.055|       3.136|       0|       1.570|       8.308
RTD|       1.872|       2.056|       3.230|       0|       1.570|       8.308
RTD|       1.871|       2.067|       2.873|       0|       1.570|       8.308
RTD|       1.731|       2.021|       3.684|       0|       1.570|       8.308
RTD|       1.759|       2.041|       3.558|       0|       1.570|       8.308
RTD|       1.753|       2.072|       4.259|       0|       1.570|       8.308
RTD|       1.863|       2.036|       2.929|       0|       1.570|       8.308
RTD|       1.818|       2.028|       6.158|       0|       1.570|       8.308
RTD|       1.730|       2.177|       6.150|       0|       1.570|       8.308
RTD|       1.626|       2.284|       6.654|       0|       1.570|       8.308
RTD|       1.709|       3.281|      21.566|       0|       1.570|      21.566
RTD|       1.692|       2.110|       4.207|       0|       1.570|      21.566
RTD|       1.724|       1.983|       3.821|       0|       1.570|      21.566
RTD|       1.738|       2.404|       4.199|       0|       1.570|      21.566
RTD|       1.691|       2.078|       7.196|       0|       1.570|      21.566
RTD|       1.679|       2.313|      11.929|       0|       1.570|      21.566
RTD|       1.727|       2.404|       4.928|       0|       1.570|      21.566
RTD|       1.674|       2.357|       5.103|       0|       1.570|      21.566
RTD|       1.795|       3.956|      12.373|       0|       1.570|      21.566
RTT|  00:02:07  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.755|       2.777|      12.352|       0|       1.570|      21.566
RTD|       1.727|       2.562|       6.069|       0|       1.570|      21.566
RTD|       1.768|       2.395|       4.747|       0|       1.570|      21.566
RTD|       1.753|       2.409|       6.043|       0|       1.570|      21.566
RTD|       1.774|       2.451|       5.765|       0|       1.570|      21.566
RTD|       1.739|       2.449|       5.907|       0|       1.570|      21.566
RTD|       1.770|       2.491|       5.948|       0|       1.570|      21.566
RTD|       1.729|       2.522|       6.056|       0|       1.570|      21.566
RTD|       1.694|       2.452|       5.957|       0|       1.570|      21.566
RTD|       1.714|       2.465|       5.783|       0|       1.570|      21.566
RTD|       1.748|       2.509|       5.732|       0|       1.570|      21.566
RTD|       1.743|       2.538|       5.984|       0|       1.570|      21.566
RTD|       1.641|       2.441|       6.032|       0|       1.570|      21.566
RTD|       1.676|       2.529|       7.417|       0|       1.570|      21.566
RTD|       1.756|       2.180|       5.913|       0|       1.570|      21.566
RTD|       1.788|       2.171|       5.742|       0|       1.570|      21.566
RTD|       1.786|       2.118|       5.832|       0|       1.570|      21.566
RTD|       1.831|       2.137|       5.771|       0|       1.570|      21.566
RTD|       1.725|       2.349|       5.670|       0|       1.570|      21.566
RTD|       1.751|       2.515|       6.032|       0|       1.570|      21.566
RTD|       1.835|       2.075|       5.974|       0|       1.570|      21.566
RTT|  00:02:28  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.713|       2.163|       6.361|       0|       1.570|      21.566
RTD|       1.809|       2.080|       6.156|       0|       1.570|      21.566
RTD|       1.756|       2.120|       4.048|       0|       1.570|      21.566
RTD|       1.868|       2.104|       3.857|       0|       1.570|      21.566
RTD|       1.864|       2.140|       4.273|       0|       1.570|      21.566
RTD|       1.685|       2.093|       4.134|       0|       1.570|      21.566
RTD|       1.805|       2.151|       7.236|       0|       1.570|      21.566
RTD|       1.845|       2.091|       4.294|       0|       1.570|      21.566
RTD|       1.865|       2.151|       4.065|       0|       1.570|      21.566
RTD|       1.827|       2.105|       5.938|       0|       1.570|      21.566
RTD|       1.776|       2.217|       6.184|       0|       1.570|      21.566
RTD|       1.824|       2.130|       7.182|       0|       1.570|      21.566
RTD|       1.863|       2.154|       6.199|       0|       1.570|      21.566
RTD|       1.832|       2.156|       6.159|       0|       1.570|      21.566
RTD|       1.852|       2.147|       4.335|       0|       1.570|      21.566
RTD|       1.871|       2.083|       4.203|       0|       1.570|      21.566
RTD|       1.846|       2.141|       4.405|       0|       1.570|      21.566
RTD|       1.814|       2.095|       4.158|       0|       1.570|      21.566
RTD|       1.875|       2.156|       5.009|       0|       1.570|      21.566
RTD|       1.793|       2.097|       4.256|       0|       1.570|      21.566
RTD|       1.871|       2.140|       4.132|       0|       1.570|      21.566
RTT|  00:02:49  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.873|       2.089|       4.424|       0|       1.570|      21.566
RTD|       1.718|       2.141|       4.516|       0|       1.570|      21.566
RTD|       1.787|       2.416|       7.701|       0|       1.570|      21.566
RTD|       1.798|       2.510|       6.349|       0|       1.570|      21.566
RTD|       1.844|       2.514|       6.178|       0|       1.570|      21.566
RTD|       1.852|       2.205|       6.224|       0|       1.570|      21.566
RTD|       1.872|       2.096|       4.504|       0|       1.570|      21.566
RTD|       1.780|       2.152|       4.245|       0|       1.570|      21.566
RTD|       1.767|       2.105|       4.046|       0|       1.570|      21.566
RTD|       1.701|       2.288|      11.913|       0|       1.570|      21.566
RTD|       1.881|       2.093|       4.067|       0|       1.570|      21.566
RTD|       1.710|       2.844|      12.436|       0|       1.570|      21.566
RTD|       1.678|       2.116|       4.871|       0|       1.570|      21.566
RTD|       1.753|       2.214|      11.535|       0|       1.570|      21.566
RTD|       1.773|       2.073|       5.255|       0|       1.570|      21.566
RTD|       1.724|       2.225|      11.945|       0|       1.570|      21.566
RTD|       1.744|       2.079|       4.350|       0|       1.570|      21.566
RTD|       1.761|       2.182|      11.545|       0|       1.570|      21.566
RTD|       1.828|       2.081|       4.408|       0|       1.570|      21.566
RTD|       1.826|       2.172|      11.558|       0|       1.570|      21.566
RTD|       1.758|       2.076|       4.773|       0|       1.570|      21.566
RTT|  00:03:10  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.665|       2.364|      11.444|       0|       1.570|      21.566
RTD|       1.659|       2.557|      22.120|       0|       1.570|      22.120
RTD|       1.694|       2.696|      12.049|       0|       1.570|      22.120
RTD|       1.716|       2.713|      12.376|       0|       1.570|      22.120
RTD|       1.616|       2.481|      12.543|       0|       1.570|      22.120
RTD|       1.639|       2.491|      12.788|       0|       1.570|      22.120
RTD|       1.695|       2.218|      12.009|       0|       1.570|      22.120
RTD|       1.698|       2.107|      11.148|       0|       1.570|      22.120
RTD|       1.718|       2.274|      11.525|       0|       1.570|      22.120
RTD|       1.693|       2.078|       5.220|       0|       1.570|      22.120
RTD|       1.597|       2.191|      12.006|       0|       1.570|      22.120
RTD|       1.577|       2.217|       4.695|       0|       1.570|      22.120
RTD|       1.650|       2.270|      11.710|       0|       1.570|      22.120
RTD|       1.628|       2.403|       5.244|       0|       1.570|      22.120
RTD|       1.601|       2.425|      11.724|       0|       1.570|      22.120
RTD|       1.673|       2.277|       5.441|       0|       1.570|      22.120
RTD|       1.773|       2.157|      11.724|       0|       1.570|      22.120
RTD|       1.868|       2.028|       7.122|       0|       1.570|      22.120
RTD|       1.754|       2.150|      11.879|       0|       1.570|      22.120
RTD|       1.743|       2.036|       4.671|       0|       1.570|      22.120
RTD|       1.699|       2.159|      11.780|       0|       1.570|      22.120
RTT|  00:03:31  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.842|       2.020|       4.209|       0|       1.570|      22.120
RTD|       1.860|       2.128|      11.603|       0|       1.570|      22.120
RTD|       1.760|       2.031|       5.170|       0|       1.570|      22.120
RTD|       1.753|       2.172|      11.558|       0|       1.570|      22.120
RTD|       1.765|       2.034|       4.635|       0|       1.570|      22.120
RTD|       1.730|       2.166|      11.474|       0|       1.570|      22.120
RTD|       1.697|       2.114|       5.179|       0|       1.570|      22.120
RTD|       1.736|       2.254|      11.634|       0|       1.570|      22.120
RTD|       1.864|       2.029|       7.594|       0|       1.570|      22.120
RTD|       1.789|       2.193|      12.025|       0|       1.570|      22.120
RTD|       1.625|       2.239|       4.873|       0|       1.570|      22.120
RTD|       1.694|       2.265|      11.780|       0|       1.570|      22.120
RTD|       1.705|       2.244|       5.209|       0|       1.570|      22.120
RTD|       1.792|       2.199|      11.976|       0|       1.570|      22.120
RTD|       1.870|       2.038|       4.269|       0|       1.570|      22.120
RTD|       1.650|       2.212|      11.969|       0|       1.570|      22.120
RTD|       1.736|       2.094|      10.304|       0|       1.570|      22.120
RTD|       1.799|       2.168|      11.668|       0|       1.570|      22.120
RTD|       1.842|       2.032|       4.939|       0|       1.570|      22.120
RTD|       1.779|       2.163|      11.556|       0|       1.570|      22.120
RTD|       1.838|       2.032|       4.913|       0|       1.570|      22.120
RTT|  00:03:52  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.771|       2.145|      11.610|       0|       1.570|      22.120
RTD|       1.805|       2.085|       6.561|       0|       1.570|      22.120
RTD|       1.808|       2.150|      11.695|       0|       1.570|      22.120
RTD|       1.859|       2.043|       4.982|       0|       1.570|      22.120
RTD|       1.752|       2.224|      11.749|       0|       1.570|      22.120
RTD|       1.761|       2.017|       4.243|       0|       1.570|      22.120
RTD|       1.819|       2.136|      11.759|       0|       1.570|      22.120
RTD|       1.852|       2.027|       4.335|       0|       1.570|      22.120
RTD|       1.796|       2.167|      11.515|       0|       1.570|      22.120
RTD|       1.853|       2.030|       4.762|       0|       1.570|      22.120
RTD|       1.863|       2.140|      11.600|       0|       1.570|      22.120
RTD|       1.743|       2.026|       6.575|       0|       1.570|      22.120
RTD|       1.859|       2.135|      11.757|       0|       1.570|      22.120
RTD|       1.859|       2.031|       3.786|       0|       1.570|      22.120
RTD|       1.854|       2.142|      11.513|       0|       1.570|      22.120
RTD|       1.860|       2.030|       4.695|       0|       1.570|      22.120
RTD|       1.768|       2.129|      11.479|       0|       1.570|      22.120
RTD|       1.854|       2.030|       4.598|       0|       1.570|      22.120
RTD|       1.840|       2.134|      11.659|       0|       1.570|      22.120
RTD|       1.858|       2.032|       4.282|       0|       1.570|      22.120
RTD|       1.869|       2.143|      11.589|       0|       1.570|      22.120
RTT|  00:04:13  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.792|       2.031|       4.127|       0|       1.570|      22.120
RTD|       1.793|       2.132|      11.629|       0|       1.570|      22.120
RTD|       1.855|       2.029|       4.063|       0|       1.570|      22.120
RTD|       1.853|       2.142|      11.508|       0|       1.570|      22.120
RTD|       1.769|       2.053|      11.174|       0|       1.570|      22.120
RTD|       1.854|       2.131|      11.468|       0|       1.570|      22.120
RTD|       1.754|       2.033|       4.174|       0|       1.570|      22.120
RTD|       1.854|       2.138|      12.161|       0|       1.570|      22.120
RTD|       1.843|       2.029|       3.936|       0|       1.570|      22.120
RTD|       1.725|       2.141|      11.992|       0|       1.570|      22.120
RTD|       1.819|       2.040|       4.995|       0|       1.570|      22.120
RTD|       1.791|       2.163|      11.940|       0|       1.570|      22.120
RTD|       1.793|       2.030|       4.209|       0|       1.570|      22.120
RTD|       1.804|       2.159|      12.040|       0|       1.570|      22.120
RTD|       1.841|       2.049|       4.976|       0|       1.570|      22.120
RTD|       1.832|       2.180|      11.927|       0|       1.570|      22.120
RTD|       1.801|       2.088|       5.067|       0|       1.570|      22.120
RTD|       1.790|       2.161|      11.618|       0|       1.570|      22.120
RTD|       1.869|       2.076|       5.127|       0|       1.570|      22.120
RTD|       1.870|       2.188|      11.690|       0|       1.570|      22.120
RTD|       1.872|       2.043|       5.926|       0|       1.570|      22.120
RTT|  00:04:34  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.781|       2.177|      11.484|       0|       1.570|      22.120
RTD|       1.741|       2.069|       5.063|       0|       1.570|      22.120
RTD|       1.876|       2.149|      12.025|       0|       1.570|      22.120
RTD|       1.877|       2.071|       4.675|       0|       1.570|      22.120
RTD|       1.813|       2.172|      12.223|       0|       1.570|      22.120
RTD|       1.820|       2.092|       5.183|       0|       1.570|      22.120
RTD|       1.736|       2.163|      11.976|       0|       1.570|      22.120
RTD|       1.807|       2.062|       5.037|       0|       1.570|      22.120
RTD|       1.854|       2.156|      12.131|       0|       1.570|      22.120
RTD|       1.827|       2.065|       4.695|       0|       1.570|      22.120
RTD|       1.807|       2.156|      11.570|       0|       1.570|      22.120
RTD|       1.854|       2.035|       5.944|       0|       1.570|      22.120
RTD|       1.808|       2.157|      11.785|       0|       1.570|      22.120
RTD|       1.766|       2.079|      10.637|       0|       1.570|      22.120
RTD|       1.732|       2.143|      11.529|       0|       1.570|      22.120
RTD|       1.852|       2.063|       4.836|       0|       1.570|      22.120
RTD|       1.866|       2.154|      11.827|       0|       1.570|      22.120
RTD|       1.749|       2.047|       4.910|       0|       1.570|      22.120
RTD|       1.772|       2.169|      11.716|       0|       1.570|      22.120
RTD|       1.712|       2.085|      11.020|       0|       1.570|      22.120
RTD|       1.668|       2.786|      11.903|       0|       1.570|      22.120
RTT|  00:04:55  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.700|       2.223|      12.513|       0|       1.570|      22.120
RTD|       1.717|       2.577|      12.269|       0|       1.570|      22.120
RTD|       1.661|       2.024|       4.668|       0|       1.570|      22.120
RTD|       1.743|       2.148|      12.019|       0|       1.570|      22.120
RTD|       1.858|       2.021|       4.004|       0|       1.570|      22.120
RTD|       1.759|       2.096|      11.669|       0|       1.570|      22.120
RTD|       1.749|       2.027|       4.243|       0|       1.570|      22.120
RTD|       1.656|       2.094|      11.651|       0|       1.570|      22.120
RTD|       1.856|       2.026|       4.207|       0|       1.570|      22.120
RTD|       1.756|       2.124|      12.742|       0|       1.570|      22.120
RTD|       1.852|       2.044|       4.472|       0|       1.570|      22.120
RTD|       1.864|       2.104|      11.010|       0|       1.570|      22.120
RTD|       1.690|       2.056|      10.986|       0|       1.570|      22.120
RTD|       1.731|       2.120|      11.568|       0|       1.570|      22.120
RTD|       1.733|       2.040|       4.668|       0|       1.570|      22.120
RTD|       1.732|       2.105|      11.527|       0|       1.570|      22.120
RTD|       1.661|       2.018|       4.220|       0|       1.570|      22.120
RTD|       1.737|       2.078|      11.456|       0|       1.570|      22.120
RTD|       1.772|       2.015|       4.147|       0|       1.570|      22.120
RTD|       1.843|       2.092|      11.469|       0|       1.570|      22.120
RTD|       1.814|       2.021|       4.356|       0|       1.570|      22.120

--Boundary-00=_l/g4Fnktglh/6vQ
Content-Type: text/plain;
  charset="us-ascii";
  name="max"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="max"

I-pipe worst-case tracing service on 2.6.19.3-xenomai/ipipe-1.0-04
------------------------------------------------------------
Begin: 685320908515 cycles, Trace Points: 6 (-10/+1), Length: 4001 us
Calibrated minimum trace-point overhead: 0.037 us

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- <unused>
 |||+-- Xenomai
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
 |  *+func                  -2    0.390  xnintr_init+0x9 (xnpod_enable_timesource+0x97)
 |  *+func                  -2    0.070  __ipipe_restore_pipeline_head+0x16 (xnpod_enable_timesource+0xbc)
 |   +end     0x80000000    -1    0.246  __ipipe_restore_pipeline_head+0xb1 (xnpod_enable_timesource+0xbc)
     +func                  -1    0.249  rthal_timer_request+0xc (xnpod_enable_timesource+0xc8)
     +func                  -1    0.158  rthal_irq_release+0x9 (rthal_timer_request+0x19)
     +func                  -1    0.394  ipipe_virtualize_irq+0x21 (rthal_irq_release+0x31)
 |   +begin   0x80000001     0    0.361  ipipe_virtualize_irq+0xa1 (rthal_irq_release+0x31)
 |   +end     0x80000001     0    0.423  ipipe_virtualize_irq+0x1cc (rthal_irq_release+0x31)
     +func                   0    0.054  rthal_critical_enter+0x16 (rthal_timer_request+0x32)
     +func                   0    0.047  ipipe_critical_enter+0xe (rthal_critical_enter+0x1e)
>|   +begin   0x80000001     0! 4000.972  ipipe_critical_enter+0x20 (rthal_critical_enter+0x1e)
:|   +func                4000    0.064  rthal_irq_request+0x9 (rthal_timer_request+0xe0)
:|   +func                4001    0.126  ipipe_virtualize_irq+0x21 (rthal_irq_request+0x3f)
:|   +func                4001    0.061  rthal_critical_exit+0x9 (rthal_timer_request+0xe8)
:|   +func                4001    0.047  ipipe_critical_exit+0xe (rthal_critical_exit+0x14)
<|   +end     0x80000001  4001    0.723  ipipe_critical_exit+0x20 (rthal_critical_exit+0x14)
 |   +begin   0x000000ef  4001    0.000  ipipe_trace_begin_thunk+0x35 (ipipe_critical_exit+0x22)

--Boundary-00=_l/g4Fnktglh/6vQ--

