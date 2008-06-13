Message-ID: <485227E2.3030603@domain.hid>
Date: Fri, 13 Jun 2008 09:55:14 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <4850DC9D.4010607@domain.hid>	<2ff1a98a0806120208n48d15ed6m4e67b582dced1ba3@domain.hid>
	<48510808.9020304@domain.hid> <485174A7.7040505@domain.hid>
In-Reply-To: <485174A7.7040505@domain.hid>
Content-Type: multipart/mixed; boundary="------------060601010107080104050702"
Subject: Re: [Xenomai-help] High latencies on Core2Duo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: philippe.gerum@domain.hid
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------060601010107080104050702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Could you run another trace with that patch applied? TIA,


Here it comes.

-- 
Sebastian

--------------060601010107080104050702
Content-Type: text/plain;
 name="ipipe_trace_4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe_trace_4"

I-pipe frozen back-tracing service on 2.6.25/ipipe-2.0-08
------------------------------------------------------------
CPU: 0, Freeze: 1123934938236 cycles, Trace Points: 100 (+10)
Calibrated minimum trace-point overhead: 0.130 us

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- <unused>
 |||+-- Xenomai
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
:    #func                -300    0.170  ipipe_check_context+0x9 (_spin_lock+0x15)
:    #func                -299    0.135  __update_rq_clock+0xe (scheduler_tick+0x55)
:    #func                -299    0.225  native_sched_clock+0xe (__update_rq_clock+0x22)
:    #func                -299    0.165  native_read_tsc+0x8 (native_sched_clock+0x4f)
:    #func                -299    0.170  ipipe_check_context+0x9 (native_sched_clock+0x5d)
:    #func                -299    0.300  __ipipe_restore_root+0x8 (native_sched_clock+0xc5)
:    #func                -298    0.225  task_tick_fair+0xb (scheduler_tick+0xeb)
:    #func                -298    0.165  update_curr+0xd (task_tick_fair+0x1c)
:    #func                -298    0.160  update_curr+0xd (task_tick_fair+0x1c)
:    #func                -298    0.125  _spin_unlock+0x8 (scheduler_tick+0x1c5)
:    #func                -298    0.115  ipipe_check_context+0x9 (_spin_unlock+0x14)
:    #func                -298    0.190  idle_cpu+0x8 (scheduler_tick+0x1cd)
:    #func                -297    0.240  run_posix_cpu_timers+0xe (update_process_times+0x49)
:    #func                -297    0.160  profile_tick+0xa (tick_sched_timer+0x78)
:    #func                -297    0.160  hrtimer_forward+0xe (tick_sched_timer+0x97)
:    #func                -297    0.160  ktime_add_safe+0xb (hrtimer_forward+0xdb)
:    #func                -297    0.110  _spin_lock+0x9 (__run_hrtimer+0x48)
:    #func                -297    0.170  ipipe_check_context+0x9 (_spin_lock+0x15)
:    #func                -296    0.155  enqueue_hrtimer+0xe (__run_hrtimer+0x69)
:    #func                -296    0.185  rb_insert_color+0xe (enqueue_hrtimer+0xe0)
:    #func                -296    0.120  _spin_unlock+0x8 (hrtimer_interrupt+0xf9)
:    #func                -296    0.160  ipipe_check_context+0x9 (_spin_unlock+0x14)
:    #func                -296    0.120  tick_program_event+0xe (hrtimer_interrupt+0x12e)
:    #func                -296    0.110  ktime_get+0xc (tick_program_event+0x29)
:    #func                -295    0.105  ktime_get_ts+0xa (ktime_get+0x16)
:    #func                -295    0.120  getnstimeofday+0xe (ktime_get_ts+0x19)
:    #func                -295    0.110  read_tsc+0x8 (getnstimeofday+0x34)
:    #func                -295    0.175  native_read_tsc+0x8 (read_tsc+0xd)
:    #func                -295    0.150  set_normalized_timespec+0x8 (ktime_get_ts+0x40)
:    #func                -295    0.265  clockevents_program_event+0xe (tick_program_event+0x36)
:    #func                -295    0.130  xnarch_next_htick_shot+0xa (clockevents_program_event+0xc5)
:|   #begin   0x80000000  -294    0.165  xnarch_next_htick_shot+0x1e (clockevents_program_event+0xc5)
:|  *#func                -294    0.190  xntimer_start_aperiodic+0xe (xnarch_next_htick_shot+0x90)
:|  *#func                -294    0.245  xnarch_ns_to_tsc+0xe (xntimer_start_aperiodic+0x63)
:|  *#func                -294    0.120  __ipipe_restore_pipeline_head+0x9 (xnarch_next_htick_shot+0xdb)
:|   #end     0x80000000  -294    0.205  __ipipe_restore_pipeline_head+0x94 (xnarch_next_htick_shot+0xdb)
:    #func                -294    0.155  irq_exit+0x8 (smp_apic_timer_interrupt+0x66)
:    #func                -293    0.125  ipipe_check_context+0x9 (irq_exit+0x12)
:    #func                -293    0.135  do_softirq+0x9 (irq_exit+0x47)
:    #func                -293    0.160  ipipe_check_context+0x9 (do_softirq+0x23)
:    #func                -293    0.115  __do_softirq+0xe (do_softirq+0x62)
:    #func                -293    0.130  ipipe_check_context+0x9 (__do_softirq+0x2e)
:    #func                -293    0.120  __ipipe_unstall_root+0x8 (__do_softirq+0x69)
:|   #begin   0x80000000  -293    0.160  __ipipe_unstall_root+0x1a (__do_softirq+0x69)
:|   +end     0x80000000  -292    0.340  __ipipe_unstall_root+0x54 (__do_softirq+0x69)
:    +func                -292    0.160  run_timer_softirq+0xe (__do_softirq+0x77)
:    +func                -292    0.275  hrtimer_run_pending+0xe (run_timer_softirq+0x22)
:    +func                -292    0.120  _spin_lock_irq+0x9 (run_timer_softirq+0x37)
:    +func                -292    0.170  ipipe_check_context+0x9 (_spin_lock_irq+0x15)
:    #func                -291    0.290  ipipe_check_context+0x9 (_spin_lock_irq+0x33)
:    #func                -291    0.140  _spin_unlock_irq+0x8 (run_timer_softirq+0x155)
:    #func                -291    0.130  __ipipe_unstall_root+0x8 (_spin_unlock_irq+0xf)
:|   #begin   0x80000000  -291    0.145  __ipipe_unstall_root+0x1a (_spin_unlock_irq+0xf)
:|   +end     0x80000000  -291    0.130  __ipipe_unstall_root+0x54 (_spin_unlock_irq+0xf)
:    +func                -291    0.145  ipipe_check_context+0x9 (_spin_unlock_irq+0x19)
:    +func                -290    0.170  ipipe_check_context+0x9 (__do_softirq+0xa1)
:    #func                -290    0.195  _local_bh_enable+0x8 (__do_softirq+0xfb)
:    #func                -290    0.160  ipipe_check_context+0x9 (_local_bh_enable+0x89)
:    #func                -290    0.165  __ipipe_restore_root+0x8 (do_softirq+0x75)
:    #func                -290    0.145  idle_cpu+0x8 (irq_exit+0x62)
:    #func                -290    0.185  ipipe_check_context+0x9 (irq_exit+0x82)
:|   #func                -289    0.150  __ipipe_unstall_iret_root+0x9 (restore_nocheck_notrace+0x0)
:|   +end     0x8000000d  -289    0.360  __ipipe_unstall_iret_root+0x6f (restore_nocheck_notrace+0x0)
:|   #end     0xffffff16  -289    0.220  ipipe_ipi3+0x3d (<080fabb8>)
:    #func                -289    0.160  __ipipe_unstall_iret_root+0x9 (restore_nocheck_notrace+0x0)
:|   #begin   0x80000000  -288    0.135  __ipipe_unstall_iret_root+0x1e (restore_nocheck_notrace+0x0)
:|   +end     0x8000000d  -288! 277.195  __ipipe_unstall_iret_root+0x6f (restore_nocheck_notrace+0x0)
:|   +begin   0xffffff16   -11    0.240  ipipe_ipi3+0x2e (<080c81c5>)
:|   +func                 -11    0.195  __ipipe_handle_irq+0xe (ipipe_ipi3+0x33)
:|   +func                 -11    0.280  __ipipe_ack_apic+0x8 (__ipipe_handle_irq+0x76)
:|   +func                 -10    0.200  __ipipe_dispatch_wired+0xe (__ipipe_handle_irq+0x7f)
:|  # func                 -10    0.205  xnintr_clock_handler+0xe (__ipipe_dispatch_wired+0xe0)
:|  # func                 -10    0.185  xntimer_tick_aperiodic+0xe (xnintr_clock_handler+0x65)
:|  # func                 -10    0.165  xnthread_periodic_handler+0x8 (xntimer_tick_aperiodic+0x96)
:|  # func                 -10    0.175  xnpod_resume_thread+0xe (xnthread_periodic_handler+0x28)
:|  # [ 5564] -<?>-   99    -9    0.355  xnpod_resume_thread+0x99 (xnthread_periodic_handler+0x28)
:|  # func                  -9    0.290  xntimer_next_local_shot+0xe (xntimer_tick_aperiodic+0x1af)
:|  # func                  -9    0.706  xnpod_schedule+0xe (xnintr_clock_handler+0x108)
:|  # [13831] -<?>-   -1    -8    0.435  xnpod_schedule+0xe2 (xnintr_clock_handler+0x108)
:|  # func                  -8    0.456  xnarch_switch_to+0xe (xnpod_schedule+0x492)
:|  # func                  -7    0.571  __switch_to+0xe (xnarch_switch_to+0x270)
:|  # [ 5564] -<?>-   99    -7    0.415  xnpod_schedule+0x4cd (xnpod_suspend_thread+0x18a)
:|  # func                  -6    0.170  xntimer_get_overruns+0xe (xnpod_wait_thread_period+0xe5)
:|  # func                  -6    0.135  __ipipe_restore_pipeline_head+0x9 (xnpod_wait_thread_period+0x145)
:|  + end     0x80000000    -6    0.395  __ipipe_restore_pipeline_head+0x94 (xnpod_wait_thread_period+0x145)
:|  + begin   0x80000001    -6    0.260  __ipipe_dispatch_event+0x109 (__ipipe_syscall_root+0x8d)
:|  + end     0x80000001    -5+   1.533  __ipipe_dispatch_event+0x1db (__ipipe_syscall_root+0x8d)
:   + func                  -4    0.155  __ipipe_syscall_root+0xa (system_call+0x29)
:   + func                  -4    0.130  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x8d)
:|  + begin   0x80000001    -3    0.170  __ipipe_dispatch_event+0x2c (__ipipe_syscall_root+0x8d)
:|  + end     0x80000001    -3    0.165  __ipipe_dispatch_event+0xd6 (__ipipe_syscall_root+0x8d)
:   + func                  -3    0.531  hisyscall_event+0xe (__ipipe_dispatch_event+0xe6)
:   + func                  -3    0.435  xnshadow_sys_trace+0xb (hisyscall_event+0x13b)
:   + func                  -2    0.230  ipipe_trace_frozen_reset+0xa (xnshadow_sys_trace+0x62)
:   + func                  -2    0.290  __ipipe_global_path_lock+0xb (ipipe_trace_frozen_reset+0xf)
:   + func                  -2    0.115  __ipipe_spin_lock_irqsave+0xa (__ipipe_global_path_lock+0x15)
:|  + begin   0x80000001    -2+   1.678  __ipipe_spin_lock_irqsave+0x21 (__ipipe_global_path_lock+0x15)
:|  # func                   0    0.170  __ipipe_spin_unlock_irqcomplete+0xa (__ipipe_global_path_unlock+0x61)
:|  + end     0x80000001     0    0.165  __ipipe_spin_unlock_irqcomplete+0x49 (__ipipe_global_path_unlock+0x61)
<   + freeze  0x00033eae     0    0.145  xnshadow_sys_trace+0x6b (hisyscall_event+0x13b)
 |  + begin   0x80000001     0    0.150  __ipipe_dispatch_event+0x109 (__ipipe_syscall_root+0x8d)
 |  + end     0x80000001     0    0.531  __ipipe_dispatch_event+0x1db (__ipipe_syscall_root+0x8d)
    + func                   0    0.135  __ipipe_syscall_root+0xa (system_call+0x29)
    + func                   0    0.125  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x8d)
 |  + begin   0x80000001     1    0.120  __ipipe_dispatch_event+0x2c (__ipipe_syscall_root+0x8d)
 |  + end     0x80000001     1    0.140  __ipipe_dispatch_event+0xd6 (__ipipe_syscall_root+0x8d)
    + func                   1    0.185  hisyscall_event+0xe (__ipipe_dispatch_event+0xe6)
    + func                   1    0.135  __rt_task_wait_period+0xd (hisyscall_event+0x13b)
    + func                   1    0.125  rt_task_wait_period+0x8 (__rt_task_wait_period+0x34)
    + func                   1    0.000N xnpod_wait_thread_period+0xe (rt_task_wait_period+0x42)

--------------060601010107080104050702--

