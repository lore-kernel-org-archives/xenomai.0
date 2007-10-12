Date: Fri, 12 Oct 2007 16:26:12 +0200
From: Stelian Pop <stelian@domain.hid>
Message-ID: <20071012142612.GB31893@domain.hid>
References: <470E8BFE.4070804@domain.hid> <1192179524.5149.23.camel@domain.hid>
	<470F3B03.1040501@domain.hid>
	<20071012110054.GA26325@domain.hid>
	<470F5753.5020809@domain.hid>
	<20071012131938.GA31893@domain.hid>
	<1192196479.6499.118.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1192196479.6499.118.camel@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] fix hw-timer setup/cleanup for i386
Reply-To: Stelian Pop <stelian@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai-core@domain.hid

On Fri, Oct 12, 2007 at 03:41:19PM +0200, Philippe Gerum wrote:

> It looks like we are still using the TSC emulation over the 8254; I
> don't ever recall if it's supposed to work actually. Now that the
> remaining known issues have been fixed by Jan's latest patch, could you
> switch your CPU config to CORE2, instead of 486? Maybe we'll get lucky.

You won't get away so easy. CPU switched back to CORE2, same behaviour.

New trace:

root@domain.hid:~# cat /proc/ipipe/trace/frozen
I-pipe frozen back-tracing service on 2.6.22.9-xeno/ipipe-1.10-07
------------------------------------------------------------
CPU: 0, Freeze: 224810852352 cycles, Trace Points: 100 (+100)
Calibrated minimum trace-point overhead: 0.090 us

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- <unused>
 |||+-- Xenomai
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
:    +func                 -32    0.090  ipipe_check_context+0xc (kmem_cache_alloc+0x27)
:    #func                 -32    0.070  __ipipe_restore_root+0x8 (kmem_cache_alloc+0x68)
:    #func                 -31    0.085  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x27)
:|   #begin   0x80000000   -31    0.085  __ipipe_unstall_root+0x4d (__ipipe_restore_root+0x27)
:|   +end     0x80000000   -31    0.170  __ipipe_unstall_root+0x3f (__ipipe_restore_root+0x27)
:    +func                 -31    0.090  ipipe_check_context+0xc (cache_alloc_refill+0x48e)
:    #func                 -31    0.100  ipipe_check_context+0xc (cache_alloc_refill+0x4a0)
:    #func                 -31    0.095  ipipe_check_context+0xc (cache_alloc_refill+0x4c9)
:    #func                 -31    0.120  ipipe_check_context+0xc (cache_alloc_refill+0x6b)
:    #func                 -31    0.140  ipipe_check_context+0xc (cache_alloc_refill+0x162)
:    #func                 -31    0.080  __ipipe_restore_root+0x8 (__kmalloc+0x8a)
:    #func                 -31    0.085  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x27)
:|   #begin   0x80000000   -30    0.085  __ipipe_unstall_root+0x4d (__ipipe_restore_root+0x27)
:|   +end     0x80000000   -30    0.220  __ipipe_unstall_root+0x3f (__ipipe_restore_root+0x27)
:    +func                 -30    0.390  xnheap_init+0x14 (xnpod_init+0x24b)
:    +func                 -30+   7.836  init_extent+0xe (xnheap_init+0x118)
:    +func                 -22    0.320  xnthread_init+0xe (xnpod_init+0x2b5)
:    +func                 -22    0.145  __xntimer_init+0xe (xnthread_init+0x58)
:    +func                 -21    0.090  snprintf+0xb (__xntimer_init+0x96)
:    +func                 -21    0.120  vsnprintf+0xe (snprintf+0x22)
:    +func                 -21    0.220  number+0xe (vsnprintf+0x2f9)
:|   +begin   0x80000000   -21    0.115  __xntimer_init+0x14b (xnthread_init+0x58)
:|  *+func                 -21    0.130  __ipipe_restore_pipeline_head+0x11 (__xntimer_init+0x119)
:|   +end     0x80000000   -21    0.175  __ipipe_restore_pipeline_head+0x9e (__xntimer_init+0x119)
:    +func                 -21    0.110  __xntimer_init+0xe (xnthread_init+0x9f)
:    +func                 -20    0.075  snprintf+0xb (__xntimer_init+0x96)
:    +func                 -20    0.140  vsnprintf+0xe (snprintf+0x22)
:    +func                 -20    0.240  number+0xe (vsnprintf+0x2f9)
:|   +begin   0x80000000   -20    0.125  __xntimer_init+0x14b (xnthread_init+0x9f)
:|  *+func                 -20    0.085  __ipipe_restore_pipeline_head+0x11 (__xntimer_init+0x119)
:|   +end     0x80000000   -20    0.475  __ipipe_restore_pipeline_head+0x9e (__xntimer_init+0x119)
:    +func                 -19    0.205  xnregistry_init+0xb (xnpod_init+0x360)
:    +func                 -19    0.095  rthal_apc_alloc+0x14 (xnregistry_init+0x1c)
:|   +begin   0x80000000   -19    0.175  rthal_apc_alloc+0xbc (xnregistry_init+0x1c)
:|  *+func                 -19    0.120  __ipipe_restore_pipeline_head+0x11 (rthal_apc_alloc+0xaf)
:|   +end     0x80000000   -19    0.125  __ipipe_restore_pipeline_head+0x9e (rthal_apc_alloc+0xaf)
:    +func                 -19    0.205  create_proc_entry+0xd (xnregistry_init+0x3e)
:    +func                 -18    0.215  proc_create+0x14 (create_proc_entry+0x43)
:    +func                 -18    0.095  __kmalloc+0xe (proc_create+0x95)
:    +func                 -18    0.090  ipipe_check_context+0xc (__kmalloc+0xb2)
:    +func                 -18    0.080  ipipe_check_context+0xc (__kmalloc+0x4e)
:    #func                 -18    0.080  __ipipe_restore_root+0x8 (__kmalloc+0x8a)
:    #func                 -18    0.095  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x27)
:|   #begin   0x80000000   -18    0.090  __ipipe_unstall_root+0x4d (__ipipe_restore_root+0x27)
:|   +end     0x80000000   -18    0.155  __ipipe_unstall_root+0x3f (__ipipe_restore_root+0x27)
:    +func                 -17    0.215  proc_register+0xe (create_proc_entry+0x61)
:    +func                 -17    0.205  idr_pre_get+0xa (proc_register+0x21)
:    +func                 -17    0.165  ipipe_check_context+0xc (proc_register+0x2f)
:    +func                 -17    0.170  idr_get_new+0x9 (proc_register+0x3e)
:    +func                 -17    0.285  idr_get_new_above_int+0xe (idr_get_new+0x12)
:    +func                 -16    0.360  find_next_bit+0xe (idr_get_new_above_int+0xcd)
:    +func                 -16    0.185  find_next_bit+0xe (idr_get_new_above_int+0xcd)
:    +func                 -16    0.100  ipipe_check_context+0xc (proc_register+0x4a)
:    +func                 -16    0.130  ipipe_check_context+0xc (proc_register+0x7b)
:    +func                 -16!  10.241  ipipe_check_context+0xc (proc_register+0x91)
:    +func                  -5    0.205  kmem_cache_alloc+0x14 (xnregistry_init+0x13a)
:    +func                  -5    0.080  ipipe_check_context+0xc (kmem_cache_alloc+0x8a)
:    +func                  -5    0.090  ipipe_check_context+0xc (kmem_cache_alloc+0x27)
:    #func                  -5    0.090  __ipipe_restore_root+0x8 (kmem_cache_alloc+0x68)
:    #func                  -5    0.095  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x27)
:|   #begin   0x80000000    -5    0.095  __ipipe_unstall_root+0x4d (__ipipe_restore_root+0x27)
:|   +end     0x80000000    -5    0.776  __ipipe_unstall_root+0x3f (__ipipe_restore_root+0x27)
:    +func                  -4    0.240  xnsynch_init+0x8 (xnregistry_init+0x169)
:    +func                  -4    0.105  xnshadow_grab_events+0x8 (xnpod_init+0x36c)
:    +func                  -4    0.140  ipipe_catch_event+0x14 (xnshadow_grab_events+0x1c)
:    +func                  -4    0.085  ipipe_critical_enter+0x9 (ipipe_catch_event+0x4d)
:|   +begin   0x80000001    -3    0.135  ipipe_critical_enter+0x1b (ipipe_catch_event+0x4d)
:|   +func                  -3    0.080  ipipe_critical_exit+0x9 (ipipe_catch_event+0xc8)
:|   +end     0x80000001    -3    0.110  ipipe_critical_exit+0x1a (ipipe_catch_event+0xc8)
:    +func                  -3    0.105  ipipe_catch_event+0x14 (xnshadow_grab_events+0x30)
:    +func                  -3    0.085  ipipe_critical_enter+0x9 (ipipe_catch_event+0x4d)
:|   +begin   0x80000001    -3    0.125  ipipe_critical_enter+0x1b (ipipe_catch_event+0x4d)
:|   +func                  -3    0.070  ipipe_critical_exit+0x9 (ipipe_catch_event+0xc8)
:|   +end     0x80000001    -3    0.125  ipipe_critical_exit+0x1a (ipipe_catch_event+0xc8)
:    +func                  -3    0.090  ipipe_catch_event+0x14 (xnshadow_grab_events+0x44)
:    +func                  -3    0.085  ipipe_critical_enter+0x9 (ipipe_catch_event+0x4d)
:|   +begin   0x80000001    -2    0.110  ipipe_critical_enter+0x1b (ipipe_catch_event+0x4d)
:|   +func                  -2    0.070  ipipe_critical_exit+0x9 (ipipe_catch_event+0xc8)
:|   +end     0x80000001    -2    0.105  ipipe_critical_exit+0x1a (ipipe_catch_event+0xc8)
:    +func                  -2    0.085  ipipe_catch_event+0x14 (xnshadow_grab_events+0x58)
:    +func                  -2    0.085  ipipe_critical_enter+0x9 (ipipe_catch_event+0x4d)
:|   +begin   0x80000001    -2    0.110  ipipe_critical_enter+0x1b (ipipe_catch_event+0x4d)
:|   +func                  -2    0.075  ipipe_critical_exit+0x9 (ipipe_catch_event+0xc8)
:|   +end     0x80000001    -2    0.090  ipipe_critical_exit+0x1a (ipipe_catch_event+0xc8)
:    +func                  -2    0.080  ipipe_catch_event+0x14 (xnshadow_grab_events+0x6c)
:    +func                  -2    0.085  ipipe_critical_enter+0x9 (ipipe_catch_event+0x4d)
:|   +begin   0x80000001    -2    0.105  ipipe_critical_enter+0x1b (ipipe_catch_event+0x4d)
:|   +func                  -1    0.075  ipipe_critical_exit+0x9 (ipipe_catch_event+0xc8)
:|   +end     0x80000001    -1    0.200  ipipe_critical_exit+0x1a (ipipe_catch_event+0xc8)
:    +func                  -1    0.180  xnpod_enable_timesource+0xd (xnpod_init+0x371)
:|   +begin   0x80000000    -1    0.255  xnpod_enable_timesource+0x15b (xnpod_init+0x371)
:|  *+func                  -1    0.110  xnintr_init+0x9 (xnpod_enable_timesource+0x69)
:|  *+func                  -1    0.125  __ipipe_restore_pipeline_head+0x11 (xnpod_enable_timesource+0x169)
:|   +end     0x80000000     0    0.095  __ipipe_restore_pipeline_head+0x9e (xnpod_enable_timesource+0x169)
:    +func                   0    0.085  xnarch_get_host_time+0xc (xnpod_enable_timesource+0x97)
:    +func                   0    0.115  do_gettimeofday+0xe (xnarch_get_host_time+0x14)
:    +func                   0    0.220  read_tsc+0x8 (do_gettimeofday+0x33)
:    +func                   0    0.195  xnarch_get_cpu_time+0x8 (xnpod_enable_timesource+0xa0)
:    +func                   0    0.260  xnarch_tsc_to_ns+0x12 (xnarch_get_cpu_time+0xf)
<    +func                   0    0.135  rthal_timer_request+0x14 (xnpod_enable_timesource+0xcb)
     +func                   0    0.090  ipipe_request_tickdev+0x14 (rthal_timer_request+0x27)
     +func                   0    0.085  ipipe_critical_enter+0x9 (ipipe_request_tickdev+0x28)
 |   +begin   0x80000001     0    0.220  ipipe_critical_enter+0x1b (ipipe_request_tickdev+0x28)
 |   +func                   0    0.105  __ipipe_check_tickdev+0x8 (ipipe_request_tickdev+0xc4)
 |   +func                   0    0.070  ipipe_critical_exit+0x9 (ipipe_request_tickdev+0x3c)
 |   +end     0x80000001     0    0.190  ipipe_critical_exit+0x1a (ipipe_request_tickdev+0x3c)
 |   +begin   0x80000001     0   11.123  rthal_timer_request+0x12b (xnpod_enable_timesource+0xcb)
 |   +func                  12    0.085  __const_udelay+0x8 (rthal_timer_request+0xbe)
 |   +func                  12    0.090  __delay+0x8 (__const_udelay+0x1c)
 |   +func                  12   16.920  delay_tsc+0x9 (__delay+0xe)
 |   +end     0x80000001    29    0.135  rthal_timer_request+0x13a (xnpod_enable_timesource+0xcb)
     +func                  29    0.105  rthal_irq_request+0xc (rthal_timer_request+0xeb)
     +func                  29    0.205  ipipe_virtualize_irq+0x14 (rthal_irq_request+0x42)
     +func                  29    0.095  __ipipe_spin_lock_irqsave+0x9 (ipipe_virtualize_irq+0x76)
 |   +begin   0x80000001    29    0.170  __ipipe_spin_lock_irqsave+0x4b (ipipe_virtualize_irq+0x76)
 |   #func                  29    0.120  __ipipe_enable_irqdesc+0x8 (ipipe_virtualize_irq+0x141)
 |   #func                  29    0.095  __ipipe_spin_unlock_irqrestore+0x9 (ipipe_virtualize_irq+0xac)
 |   +end     0x80000001    30    0.120  __ipipe_spin_unlock_irqrestore+0x36 (ipipe_virtualize_irq+0xac)
 |   +begin   0x80000000    30    0.205  xnpod_enable_timesource+0x18f (xnpod_init+0x371)
 |  *+func                  30    0.175  xntimer_start_aperiodic+0xe (xnpod_enable_timesource+0x1b9)
 |  *+func                  30    0.320  xnarch_ns_to_tsc+0x14 (xntimer_start_aperiodic+0x12d)
 |  *+func                  30    0.190  xntimer_next_local_shot+0x12 (xntimer_start_aperiodic+0x10d)
 |  *+func                  31    0.135  ipipe_trigger_irq+0xd (xntimer_next_local_shot+0x82)
 |  *+func                  31    0.115  __ipipe_handle_irq+0x14 (ipipe_trigger_irq+0x14c)
 |  *+func                  31    0.130  __ipipe_dispatch_wired+0x16 (__ipipe_handle_irq+0x4f)
 |  *+func                  31    0.160  __ipipe_set_irq_pending+0x16 (__ipipe_dispatch_wired+0xd9)
 |  *+func                  31    0.120  __ipipe_restore_pipeline_head+0x11 (xnpod_enable_timesource+0x179)
 |   +func                  31    0.130  __ipipe_walk_pipeline+0xa (__ipipe_restore_pipeline_head+0xdc)
 |  + func                  31    0.130  ipipe_suspend_domain+0xe (__ipipe_walk_pipeline+0x78)
 |  + func                  31    0.285  __ipipe_sync_stage+0xe (ipipe_suspend_domain+0x84)
 |  # func                  32    0.140  xnintr_clock_handler+0x16 (__ipipe_sync_stage+0x105)
 |  # func                  32    0.185  xntimer_tick_aperiodic+0xe (xnintr_clock_handler+0x34)
 |  # func                  32    0.205  xntimer_next_local_shot+0x12 (xntimer_tick_aperiodic+0x15c)
 |  # func                  32    0.260  rthal_irq_host_pend+0x8 (xnintr_clock_handler+0xaa)
 |  # func                  33    0.145  __ipipe_schedule_irq+0xe (rthal_irq_host_pend+0x16)
 |  # func                  33    0.240  __ipipe_set_irq_pending+0x16 (__ipipe_schedule_irq+0x68)
 |   +func                  33    0.125  __ipipe_sync_stage+0xe (ipipe_suspend_domain+0x84)
 |   #end     0x80000000    33    0.125  __ipipe_sync_stage+0x192 (ipipe_suspend_domain+0x84)
     #func                  33    0.090  do_IRQ+0xe (__ipipe_sync_stage+0x1dd)
     #func                  33    0.095  irq_enter+0x8 (do_IRQ+0x2b)
     #func                  33    0.075  handle_level_irq+0x16 (do_IRQ+0x38)
     #func                  33    0.085  ipipe_check_context+0xc (handle_level_irq+0x24)
     #func                  34    0.080  ipipe_check_context+0xc (handle_level_irq+0x5c)
     #func                  34    0.090  handle_IRQ_event+0xe (handle_level_irq+0x65)
     #func                  34    0.100  timer_interrupt+0x8 (handle_IRQ_event+0x31)
     #func                  34    0.070  tick_handle_periodic+0xe (timer_interrupt+0x13)
     #func                  34    0.080  tick_periodic+0x8 (tick_handle_periodic+0x17)
     #func                  34    0.090  ipipe_check_context+0xc (tick_periodic+0x3f)
     #func                  34    0.110  do_timer+0x14 (tick_periodic+0x67)
     #func                  34    0.110  update_wall_time+0xe (do_timer+0x29)
     #func                  34    0.175  read_tsc+0x8 (update_wall_time+0x24)
     #func                  34    0.090  clocksource_get_next+0xa (update_wall_time+0x212)
     #func                  35    0.095  ipipe_check_context+0xc (clocksource_get_next+0x14)
     #func                  35    0.085  ipipe_check_context+0xc (clocksource_get_next+0x30)
     #func                  35    0.090  __ipipe_restore_root+0x8 (clocksource_get_next+0x4a)
     #func                  35    0.120  ipipe_check_context+0xc (clocksource_get_next+0x54)
     #func                  35    0.100  ipipe_check_context+0xc (tick_periodic+0x78)
     #func                  35    0.095  update_process_times+0x12 (tick_periodic+0x29)
     #func                  35    0.105  account_system_time+0x16 (update_process_times+0x71)
     #func                  35    0.090  run_local_timers+0x8 (update_process_times+0x2f)
     #func                  35    0.080  raise_softirq+0x16 (run_local_timers+0x12)
     #func                  35    0.085  ipipe_check_context+0xc (raise_softirq+0x22)
     #func                  35    0.100  __ipipe_restore_root+0x8 (raise_softirq+0x6c)
     #func                  36    0.110  softlockup_tick+0x14 (run_local_timers+0x17)
     #func                  36    0.075  rcu_pending+0x8 (update_process_times+0x36)
     #func                  36    0.110  __rcu_pending+0x8 (rcu_pending+0x17)
     #func                  36    0.085  rcu_check_callbacks+0x8 (update_process_times+0x43)
     #func                  36    0.120  idle_cpu+0x8 (rcu_check_callbacks+0x45)
     #func                  36    0.080  __tasklet_schedule+0x16 (rcu_check_callbacks+0x3a)
     #func                  36    0.080  ipipe_check_context+0xc (__tasklet_schedule+0x22)
     #func                  36    0.115  __ipipe_restore_root+0x8 (__tasklet_schedule+0x77)
     #func                  36    0.090  scheduler_tick+0x16 (update_process_times+0x48)
     #func                  36    0.110  sched_clock+0x12 (scheduler_tick+0x1b)
     #func                  37    0.095  idle_cpu+0x8 (scheduler_tick+0x2c)
     #func                  37    0.075  task_running_tick+0x14 (scheduler_tick+0x5e)
     #func                  37    0.090  ipipe_check_context+0xc (task_running_tick+0x3f)
     #func                  37    0.090  ipipe_check_context+0xc (task_running_tick+0x95)
     #func                  37    0.115  run_posix_cpu_timers+0xe (update_process_times+0x4f)
     #func                  37    0.090  profile_tick+0x12 (tick_periodic+0x33)
     #func                  37    0.120  profile_pc+0x8 (profile_tick+0x47)
     #func                  37    0.125  ipipe_check_context+0xc (handle_IRQ_event+0x59)
     #func                  37    0.120  note_interrupt+0xe (handle_level_irq+0xbb)
     #func                  37    0.125  ipipe_check_context+0xc (handle_level_irq+0x79)
     #func                  38    0.100  enable_8259A_irq+0x16 (handle_level_irq+0x97)
     #func                  38    0.100  __ipipe_spin_lock_irqsave+0x9 (enable_8259A_irq+0x2b)
 |   #begin   0x80000001    38    0.105  __ipipe_spin_lock_irqsave+0x4b (enable_8259A_irq+0x2b)
 |   #func                  38    0.105  __ipipe_spin_unlock_irqrestore+0x9 (enable_8259A_irq+0x6c)
 |   #end     0x80000001    38    0.140  __ipipe_spin_unlock_irqrestore+0x36 (enable_8259A_irq+0x6c)
     #func                  38    0.110  ipipe_check_context+0xc (handle_level_irq+0xa1)
     #func                  38    0.115  irq_exit+0x8 (do_IRQ+0x3d)
     #func                  38    0.095  do_softirq+0x12 (irq_exit+0x39)
     #func                  38    0.120  ipipe_check_context+0xc (do_softirq+0x3a)
     #func                  39    0.110  __do_softirq+0xb (do_softirq+0x6d)
     #func                  39    0.090  __ipipe_unstall_root+0x8 (__do_softirq+0x33)
 |   #begin   0x80000000    39    0.090  __ipipe_unstall_root+0x4d (__do_softirq+0x33)
 |   +end     0x80000000    39    0.135  __ipipe_unstall_root+0x3f (__do_softirq+0x33)
     +func                  39    0.110  run_timer_softirq+0xe (__do_softirq+0x52)
     +func                  39    0.120  hrtimer_run_queues+0xe (run_timer_softirq+0x19)
     +func                  39    0.095  ipipe_check_context+0xc (hrtimer_run_queues+0xc5)
     #func                  39    0.000  ipipe_check_context+0xc (hrtimer_run_queues+0xd7)


-- 
Stelian Pop <stelian@domain.hid>    

