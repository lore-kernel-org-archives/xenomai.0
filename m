Date: Fri, 12 Oct 2007 15:19:38 +0200
From: Stelian Pop <stelian@domain.hid>
Message-ID: <20071012131938.GA31893@domain.hid>
References: <470E8BFE.4070804@domain.hid> <1192179524.5149.23.camel@domain.hid>
	<470F3B03.1040501@domain.hid>
	<20071012110054.GA26325@domain.hid>
	<470F5753.5020809@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470F5753.5020809@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

On Fri, Oct 12, 2007 at 01:15:31PM +0200, Jan Kiszka wrote:

> > root@domain.hid# cat /proc/ipipe/trace/max
> 
> /frozen holds the result. Also, a bit more post_trace_points may help to
> see what goes on after that function is called.

Ah, sorry. Here it comes, with post_trace_points set to 100:

root@domain.hid:~# echo 1 > /proc/ipipe/trace/enable 
root@domain.hid:~# echo 100 > /proc/ipipe/trace/post_trace_points 
root@domain.hid:~# echo rthal_timer_request > /proc/ipipe/trace/trigger
root@domain.hid:~# modprobe xeno_native
root@domain.hid:~# cat /proc/ipipe/trace/frozen 
I-pipe frozen back-tracing service on 2.6.22.9-xeno/ipipe-1.10-07
------------------------------------------------------------
CPU: 0, Freeze: 533994599352 cycles, Trace Points: 100 (+100)
Calibrated minimum trace-point overhead: 0.094 us

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- <unused>
 |||+-- Xenomai
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
:|   #begin   0x80000000   -37    0.094  __ipipe_unstall_root+0x4d (__ipipe_restore_root+0x27)
:|   +end     0x80000000   -37    0.184  __ipipe_unstall_root+0x3f (__ipipe_restore_root+0x27)
:    +func                 -37    0.089  ipipe_check_context+0xc (cache_alloc_refill+0x406)
:    #func                 -37    0.094  ipipe_check_context+0xc (cache_alloc_refill+0x418)
:    #func                 -37    0.094  ipipe_check_context+0xc (cache_alloc_refill+0x441)
:    #func                 -37    0.139  ipipe_check_context+0xc (cache_alloc_refill+0x66)
:    #func                 -36    0.109  ipipe_check_context+0xc (cache_alloc_refill+0x165)
:    #func                 -36    0.099  __ipipe_restore_root+0x8 (__kmalloc+0x90)
:    #func                 -36    0.099  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x27)
:|   #begin   0x80000000   -36    0.094  __ipipe_unstall_root+0x4d (__ipipe_restore_root+0x27)
:|   +end     0x80000000   -36    0.209  __ipipe_unstall_root+0x3f (__ipipe_restore_root+0x27)
:    +func                 -36    0.384  xnheap_init+0xe (xnpod_init+0x243)
:    +func                 -35+   7.850  init_extent+0xe (xnheap_init+0x111)
:    +func                 -28    0.144  xnthread_init+0xe (xnpod_init+0x2af)
:    +func                 -27    0.119  __xntimer_init+0xe (xnthread_init+0x53)
:    +func                 -27    0.084  snprintf+0xb (__xntimer_init+0x96)
:    +func                 -27    0.159  vsnprintf+0xe (snprintf+0x22)
:    +func                 -27    0.259  number+0xe (vsnprintf+0x2d8)
:|   +begin   0x80000000   -27    0.129  __xntimer_init+0x14b (xnthread_init+0x53)
:|  *+func                 -27    0.134  __ipipe_restore_pipeline_head+0xd (__xntimer_init+0x117)
:|   +end     0x80000000   -27    0.159  __ipipe_restore_pipeline_head+0x9e (__xntimer_init+0x117)
:    +func                 -26    0.094  __xntimer_init+0xe (xnthread_init+0x9b)
:    +func                 -26    0.074  snprintf+0xb (__xntimer_init+0x96)
:    +func                 -26    0.104  vsnprintf+0xe (snprintf+0x22)
:    +func                 -26    0.219  number+0xe (vsnprintf+0x2d8)
:|   +begin   0x80000000   -26    0.129  __xntimer_init+0x14b (xnthread_init+0x9b)
:|  *+func                 -26    0.084  __ipipe_restore_pipeline_head+0xd (__xntimer_init+0x117)
:|   +end     0x80000000   -26    0.443  __ipipe_restore_pipeline_head+0x9e (__xntimer_init+0x117)
:    +func                 -25    0.234  xnregistry_init+0xb (xnpod_init+0x359)
:    +func                 -25    0.094  rthal_apc_alloc+0xe (xnregistry_init+0x1c)
:|   +begin   0x80000000   -25    0.129  rthal_apc_alloc+0xbb (xnregistry_init+0x1c)
:|  *+func                 -25    0.124  __ipipe_restore_pipeline_head+0xd (rthal_apc_alloc+0xa7)
:|   +end     0x80000000   -25    0.239  __ipipe_restore_pipeline_head+0x9e (rthal_apc_alloc+0xa7)
:    +func                 -24    0.229  create_proc_entry+0xd (xnregistry_init+0x3e)
:    +func                 -24    0.219  proc_create+0xe (create_proc_entry+0x54)
:    +func                 -24    0.099  __kmalloc+0xe (proc_create+0x8f)
:    +func                 -24    0.089  ipipe_check_context+0xc (__kmalloc+0xb4)
:    +func                 -24    0.104  ipipe_check_context+0xc (__kmalloc+0x5c)
:    #func                 -24    0.074  __ipipe_restore_root+0x8 (__kmalloc+0x90)
:    #func                 -24    0.089  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x27)
:|   #begin   0x80000000   -24    0.094  __ipipe_unstall_root+0x4d (__ipipe_restore_root+0x27)
:|   +end     0x80000000   -23    0.144  __ipipe_unstall_root+0x3f (__ipipe_restore_root+0x27)
:    +func                 -23    0.209  proc_register+0xe (create_proc_entry+0x72)
:    +func                 -23    0.129  idr_pre_get+0xa (proc_register+0x2f)
:    +func                 -23    0.204  ipipe_check_context+0xc (proc_register+0x3d)
:    +func                 -23    0.169  idr_get_new+0x9 (proc_register+0x4c)
:    +func                 -23    0.274  idr_get_new_above_int+0xe (idr_get_new+0x12)
:    +func                 -22    0.234  find_next_bit+0xe (idr_get_new_above_int+0xd6)
:    +func                 -22    0.214  find_next_bit+0xe (idr_get_new_above_int+0xd6)
:    +func                 -22    0.099  ipipe_check_context+0xc (proc_register+0x58)
:    +func                 -22    0.129  ipipe_check_context+0xc (proc_register+0x87)
:    +func                 -22+   9.970  ipipe_check_context+0xc (proc_register+0x9d)
:    +func                 -12    0.189  kmem_cache_alloc+0xe (xnregistry_init+0x141)
:    +func                 -11    0.084  ipipe_check_context+0xc (kmem_cache_alloc+0x8a)
:    +func                 -11    0.089  ipipe_check_context+0xc (kmem_cache_alloc+0x21)
:    #func                 -11    0.084  __ipipe_restore_root+0x8 (kmem_cache_alloc+0x55)
:    #func                 -11    0.089  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x27)
:|   #begin   0x80000000   -11    0.094  __ipipe_unstall_root+0x4d (__ipipe_restore_root+0x27)
:|   +end     0x80000000   -11    0.758  __ipipe_unstall_root+0x3f (__ipipe_restore_root+0x27)
:    +func                 -10    0.389  xnsynch_init+0x8 (xnregistry_init+0x16e)
:    +func                 -10    0.094  xnshadow_grab_events+0x8 (xnpod_init+0x365)
:    +func                 -10    0.139  ipipe_catch_event+0xe (xnshadow_grab_events+0x1c)
:    +func                 -10    0.094  ipipe_critical_enter+0x9 (ipipe_catch_event+0x47)
:|   +begin   0x80000001   -10    0.234  ipipe_critical_enter+0x1b (ipipe_catch_event+0x47)
:|   +func                  -9    0.089  ipipe_critical_exit+0x9 (ipipe_catch_event+0xc8)
:|   +end     0x80000001    -9    0.109  ipipe_critical_exit+0x1a (ipipe_catch_event+0xc8)
:    +func                  -9    0.109  ipipe_catch_event+0xe (xnshadow_grab_events+0x30)
:    +func                  -9    0.089  ipipe_critical_enter+0x9 (ipipe_catch_event+0x47)
:|   +begin   0x80000001    -9    0.119  ipipe_critical_enter+0x1b (ipipe_catch_event+0x47)
:|   +func                  -9    0.074  ipipe_critical_exit+0x9 (ipipe_catch_event+0xc8)
:|   +end     0x80000001    -9    0.094  ipipe_critical_exit+0x1a (ipipe_catch_event+0xc8)
:    +func                  -9    0.079  ipipe_catch_event+0xe (xnshadow_grab_events+0x44)
:    +func                  -9    0.084  ipipe_critical_enter+0x9 (ipipe_catch_event+0x47)
:|   +begin   0x80000001    -8    0.104  ipipe_critical_enter+0x1b (ipipe_catch_event+0x47)
:|   +func                  -8    0.074  ipipe_critical_exit+0x9 (ipipe_catch_event+0xc8)
:|   +end     0x80000001    -8    0.094  ipipe_critical_exit+0x1a (ipipe_catch_event+0xc8)
:    +func                  -8    0.079  ipipe_catch_event+0xe (xnshadow_grab_events+0x58)
:    +func                  -8    0.084  ipipe_critical_enter+0x9 (ipipe_catch_event+0x47)
:|   +begin   0x80000001    -8    0.114  ipipe_critical_enter+0x1b (ipipe_catch_event+0x47)
:|   +func                  -8    0.074  ipipe_critical_exit+0x9 (ipipe_catch_event+0xc8)
:|   +end     0x80000001    -8    0.094  ipipe_critical_exit+0x1a (ipipe_catch_event+0xc8)
:    +func                  -8    0.109  ipipe_catch_event+0xe (xnshadow_grab_events+0x6c)
:    +func                  -8    0.084  ipipe_critical_enter+0x9 (ipipe_catch_event+0x47)
:|   +begin   0x80000001    -8    0.109  ipipe_critical_enter+0x1b (ipipe_catch_event+0x47)
:|   +func                  -7    0.074  ipipe_critical_exit+0x9 (ipipe_catch_event+0xc8)
:|   +end     0x80000001    -7    0.204  ipipe_critical_exit+0x1a (ipipe_catch_event+0xc8)
:    +func                  -7    0.164  xnpod_enable_timesource+0xd (xnpod_init+0x36a)
:|   +begin   0x80000000    -7    0.189  xnpod_enable_timesource+0x16b (xnpod_init+0x36a)
:|  *+func                  -7    0.099  xnintr_init+0x9 (xnpod_enable_timesource+0x69)
:|  *+func                  -7    0.124  __ipipe_restore_pipeline_head+0xd (xnpod_enable_timesource+0x179)
:|   +end     0x80000000    -7    0.214  __ipipe_restore_pipeline_head+0x9e (xnpod_enable_timesource+0x179)
:    +func                  -6    0.174  xnarch_get_host_time+0xd (xnpod_enable_timesource+0x97)
:    +func                  -6    0.109  do_gettimeofday+0xe (xnarch_get_host_time+0x15)
:    +func                  -6    0.239  read_tsc+0x8 (do_gettimeofday+0x42)
:    +func                  -6    0.209  xnarch_get_cpu_time+0x8 (xnpod_enable_timesource+0xa0)
:    +func                  -6    0.094  rthal_get_8254_tsc+0xe (xnarch_get_cpu_time+0xd)
:|   +begin   0x80000001    -6+   5.770  rthal_get_8254_tsc+0x9b (xnarch_get_cpu_time+0xd)
:|   +end     0x80000001     0    0.109  rthal_get_8254_tsc+0x77 (xnarch_get_cpu_time+0xd)
:    +func                   0    0.159  xnarch_tsc_to_ns+0xa (xnarch_get_cpu_time+0x12)
<    +func                   0    0.219  rthal_timer_request+0xe (xnpod_enable_timesource+0xcb)
     +func                   0    0.089  ipipe_request_tickdev+0xe (rthal_timer_request+0x21)
     +func                   0    0.084  ipipe_critical_enter+0x9 (ipipe_request_tickdev+0x1d)
 |   +begin   0x80000001     0    0.224  ipipe_critical_enter+0x1b (ipipe_request_tickdev+0x1d)
 |   +func                   0    0.099  __ipipe_check_tickdev+0x8 (ipipe_request_tickdev+0xb1)
 |   +func                   0    0.074  ipipe_critical_exit+0x9 (ipipe_request_tickdev+0x36)
 |   +end     0x80000001     0    0.244  ipipe_critical_exit+0x1a (ipipe_request_tickdev+0x36)
 |   +begin   0x80000001     1   11.102  rthal_timer_request+0x14b (xnpod_enable_timesource+0xcb)
 |   +func                  12    0.089  __const_udelay+0x8 (rthal_timer_request+0xb7)
 |   +func                  12    0.094  __delay+0x8 (__const_udelay+0x23)
 |   +func                  12   16.832  delay_tsc+0x9 (__delay+0xe)
 |   +end     0x80000001    29    0.119  rthal_timer_request+0x15a (xnpod_enable_timesource+0xcb)
     +func                  29    0.119  rthal_irq_request+0xc (rthal_timer_request+0xe5)
     +func                  29    0.204  ipipe_virtualize_irq+0xe (rthal_irq_request+0x45)
     +func                  29    0.094  __ipipe_spin_lock_irqsave+0x9 (ipipe_virtualize_irq+0x65)
 |   +begin   0x80000001    29    0.174  __ipipe_spin_lock_irqsave+0x4b (ipipe_virtualize_irq+0x65)
 |   #func                  29    0.104  __ipipe_enable_irqdesc+0x8 (ipipe_virtualize_irq+0x111)
 |   #func                  29    0.099  __ipipe_spin_unlock_irqrestore+0x9 (ipipe_virtualize_irq+0x97)
 |   +end     0x80000001    30    0.129  __ipipe_spin_unlock_irqrestore+0x36 (ipipe_virtualize_irq+0x97)
 |   +begin   0x80000000    30    0.109  xnpod_enable_timesource+0x18b (xnpod_init+0x36a)
 |  *+func                  30    0.109  xntimer_start_aperiodic+0xe (xnpod_enable_timesource+0x1b5)
 |  *+func                  30    5.870  rthal_get_8254_tsc+0xe (xntimer_start_aperiodic+0x38)
 |  *+func                  36    0.314  xnarch_ns_to_tsc+0xe (xntimer_start_aperiodic+0x11d)
 |  *+func                  36    0.124  xntimer_next_local_shot+0xe (xntimer_start_aperiodic+0x13a)
 |  *+func                  36    5.780  rthal_get_8254_tsc+0xe (xntimer_next_local_shot+0x35)
 |  *+func                  42    0.139  ipipe_trigger_irq+0xe (xntimer_next_local_shot+0x97)
 |  *+func                  42    0.134  __ipipe_handle_irq+0xe (ipipe_trigger_irq+0x8f)
 |  *+func                  42    0.119  __ipipe_dispatch_wired+0xb (__ipipe_handle_irq+0x51)
 |  *+func                  42    0.169  __ipipe_set_irq_pending+0xb (__ipipe_dispatch_wired+0xc9)
 |  *+func                  43    0.129  __ipipe_restore_pipeline_head+0xd (xnpod_enable_timesource+0x159)
 |   +func                  43    0.119  __ipipe_walk_pipeline+0xa (__ipipe_restore_pipeline_head+0xdc)
 |  + func                  43    0.104  ipipe_suspend_domain+0xe (__ipipe_walk_pipeline+0x78)
 |  + func                  43    0.249  __ipipe_sync_stage+0xe (ipipe_suspend_domain+0x84)
 |  # func                  43    0.134  xnintr_clock_handler+0xe (__ipipe_sync_stage+0x105)
 |  # func                  43    5.740  rthal_get_8254_tsc+0xe (xnintr_clock_handler+0x1b)
 |  # func                  49    0.099  xntimer_tick_aperiodic+0xe (xnintr_clock_handler+0x2f)
 |  # func                  49    5.785  rthal_get_8254_tsc+0xe (xntimer_tick_aperiodic+0x1d)
 |  # func                  55    0.408  xntimer_next_local_shot+0xe (xntimer_tick_aperiodic+0x164)
 |  # func                  55    0.199  rthal_irq_host_pend+0x8 (xnintr_clock_handler+0xa2)
 |  # func                  56    0.129  __ipipe_schedule_irq+0xe (rthal_irq_host_pend+0x16)
 |  # func                  56    0.109  __ipipe_set_irq_pending+0xb (__ipipe_schedule_irq+0x68)
 |  # func                  56    5.735  rthal_get_8254_tsc+0xe (xnintr_clock_handler+0xb3)
 |  # func                  62    5.805  rthal_get_8254_tsc+0xe (xnintr_clock_handler+0xce)
 |   +func                  67    0.124  __ipipe_sync_stage+0xe (ipipe_suspend_domain+0x84)
 |   #end     0x80000000    67    0.144  __ipipe_sync_stage+0x192 (ipipe_suspend_domain+0x84)
     #func                  68    0.099  do_IRQ+0xe (__ipipe_sync_stage+0x1dd)
     #func                  68    0.094  irq_enter+0x8 (do_IRQ+0x35)
     #func                  68    0.094  handle_level_irq+0xb (do_IRQ+0x3c)
     #func                  68    0.124  ipipe_check_context+0xc (handle_level_irq+0x19)
     #func                  68    0.079  ipipe_check_context+0xc (handle_level_irq+0x50)
     #func                  68    0.104  handle_IRQ_event+0xe (handle_level_irq+0x59)
     #func                  68    0.099  timer_interrupt+0x8 (handle_IRQ_event+0x31)
     #func                  68    0.074  tick_handle_periodic+0xe (timer_interrupt+0x13)
     #func                  68    0.079  tick_periodic+0x8 (tick_handle_periodic+0x17)
     #func                  68    0.089  ipipe_check_context+0xc (tick_periodic+0x4a)
     #func                  69    0.079  do_timer+0xe (tick_periodic+0x71)
     #func                  69    0.094  update_wall_time+0xe (do_timer+0x23)
     #func                  69    0.184  read_tsc+0x8 (update_wall_time+0x24)
     #func                  69    0.089  clocksource_get_next+0xa (update_wall_time+0x220)
     #func                  69    0.084  ipipe_check_context+0xc (clocksource_get_next+0x14)
     #func                  69    0.099  ipipe_check_context+0xc (clocksource_get_next+0x2e)
     #func                  69    0.089  __ipipe_restore_root+0x8 (clocksource_get_next+0x48)
     #func                  69    0.089  ipipe_check_context+0xc (clocksource_get_next+0x52)
     #func                  69    0.094  ipipe_check_context+0xc (tick_periodic+0x81)
     #func                  69    0.089  update_process_times+0xa (tick_periodic+0x2b)
     #func                  70    0.114  account_system_time+0xb (update_process_times+0x61)
     #func                  70    0.099  run_local_timers+0x8 (update_process_times+0x27)
     #func                  70    0.089  raise_softirq+0xb (run_local_timers+0x12)
     #func                  70    0.089  ipipe_check_context+0xc (raise_softirq+0x17)
     #func                  70    0.114  __ipipe_restore_root+0x8 (raise_softirq+0x67)
     #func                  70    0.099  softlockup_tick+0xe (run_local_timers+0x17)
     #func                  70    0.084  rcu_pending+0x8 (update_process_times+0x2e)
     #func                  70    0.094  __rcu_pending+0x8 (rcu_pending+0x17)
     #func                  70    0.104  __rcu_pending+0x8 (rcu_pending+0x3f)
     #func                  70    0.099  scheduler_tick+0xb (update_process_times+0x40)
     #func                  71    0.124  sched_clock+0xa (scheduler_tick+0x10)
     #func                  71    0.099  idle_cpu+0x8 (scheduler_tick+0x21)
     #func                  71    0.114  task_running_tick+0xe (scheduler_tick+0x53)
     #func                  71    0.154  ipipe_check_context+0xc (task_running_tick+0x34)
     #func                  71    0.124  dequeue_task+0xa (task_running_tick+0x13a)
     #func                  71    0.124  effective_prio+0x8 (task_running_tick+0x149)
     #func                  71    0.154  static_prio_timeslice+0x8 (task_running_tick+0x156)
     #func                  71    0.099  enqueue_task+0xa (task_running_tick+0x1d1)
     #func                  72    0.114  ipipe_check_context+0xc (task_running_tick+0x89)
     #func                  72    0.114  run_posix_cpu_timers+0xe (update_process_times+0x47)
     #func                  72    0.089  profile_tick+0xa (tick_periodic+0x35)
     #func                  72    0.124  profile_pc+0x8 (profile_tick+0x37)
     #func                  72    0.109  ipipe_check_context+0xc (handle_IRQ_event+0x67)
     #func                  72    0.099  note_interrupt+0xe (handle_level_irq+0xab)
     #func                  72    0.099  ipipe_check_context+0xc (handle_level_irq+0x6d)
     #func                  72    0.084  enable_8259A_irq+0xb (handle_level_irq+0x8b)
     #func                  72    0.094  __ipipe_spin_lock_irqsave+0x9 (enable_8259A_irq+0x20)
 |   #begin   0x80000001    72    0.109  __ipipe_spin_lock_irqsave+0x4b (enable_8259A_irq+0x20)
 |   #func                  73    0.104  __ipipe_spin_unlock_irqrestore+0x9 (enable_8259A_irq+0x61)
 |   #end     0x80000001    73    0.114  __ipipe_spin_unlock_irqrestore+0x36 (enable_8259A_irq+0x61)
     #func                  73    0.104  ipipe_check_context+0xc (handle_level_irq+0x95)
     #func                  73    0.124  irq_exit+0x8 (do_IRQ+0x41)
     #func                  73    0.079  do_softirq+0xa (irq_exit+0x45)
     #func                  73    0.104  ipipe_check_context+0xc (do_softirq+0x2a)
     #func                  73    0.089  __do_softirq+0xb (do_softirq+0x65)
     #func                  73    0.000  __ipipe_unstall_root+0x8 (__do_softirq+0x3f)
root@domain.hid:~#

> 
> > 
> >> BTW, does the latency test of Xenomai work?
> > 
> > No. It hangs after "warming up". I'm able to interrupt with ^C and then
> > it prints a single line showing a max latency of 208983.492 ms (same value
> > on several invocations).
> 
> Ah, then we may fail to program the APIC appropriately.

root@domain.hid:# zgrep APIC /proc/config.gz
# CONFIG_X86_UP_APIC is not set

Do you mean the PIT ?

> That would need
> a closer look if you want to dig into this.

I'm not sure how much time I have to investigate this, but yes, I can take a
look if you tell me what I should look for.

> /me is going to be
> distracted from this for now.

Thanks,

Stelian.
-- 
Stelian Pop <stelian@domain.hid>    

