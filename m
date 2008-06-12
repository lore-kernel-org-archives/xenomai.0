Message-ID: <4850DC9D.4010607@domain.hid>
Date: Thu, 12 Jun 2008 10:21:49 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040301020300000205020006"
Subject: [Xenomai-help] High latencies on Core2Duo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------040301020300000205020006
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm observing high latencies when running the latency test on a 
Core2Duo. They appear sporadically and are mostly between 100 and 300 
us. Sometimes they are about 800 us. I have attached two I-pipe trace 
outputs.

Kernel is 2.6.25, Xenomai is 2.4.4, I-pipe is 2.0-08. ACPI, APM and CPU 
frequency scaling are all of, SMI workaround is enabled.

Any idea anyone?

-- 
Sebastian

--------------040301020300000205020006
Content-Type: text/plain;
 name="ipipe_trace_1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe_trace_1"

I-pipe frozen back-tracing service on 2.6.25/ipipe-2.0-08
------------------------------------------------------------
CPU: 0, Freeze: 911549394675 cycles, Trace Points: 100 (+10)
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
:|   #func                -928    0.160  __ipipe_unstall_iret_root+0x9 (restore_nocheck_notrace+0x0)
:|   +end     0x8000000d  -927    0.290  __ipipe_unstall_iret_root+0x6f (restore_nocheck_notrace+0x0)
:    +func                -927    0.155  down_read_trylock+0x9 (do_page_fault+0x175)
:    +func                -927    0.290  find_vma+0xa (do_page_fault+0x1a4)
:    +func                -927    0.135  handle_mm_fault+0xe (do_page_fault+0x220)
:    +func                -927    0.150  ipipe_check_context+0x9 (handle_mm_fault+0x2d)
:    +func                -926    0.160  ipipe_check_context+0x9 (handle_mm_fault+0x56)
:    +func                -926    0.180  page_address+0xe (handle_mm_fault+0xd4)
:    +func                -926    0.170  __do_fault+0xe (handle_mm_fault+0x277)
:    +func                -926    0.230  filemap_fault+0xe (__do_fault+0x56)
:    +func                -926    0.150  find_lock_page+0xb (filemap_fault+0x88)
:    +func                -926    0.130  _read_lock_irq+0x9 (find_lock_page+0x17)
:    +func                -925    0.210  ipipe_check_context+0x9 (_read_lock_irq+0x15)
:    #func                -925    0.220  ipipe_check_context+0x9 (_read_lock_irq+0x33)
:    #func                -925    0.435  radix_tree_lookup+0xb (find_lock_page+0x21)
:    #func                -925    0.150  _read_unlock_irq+0x8 (find_lock_page+0x75)
:    #func                -924    0.135  __ipipe_unstall_root+0x8 (_read_unlock_irq+0x10)
:|   #begin   0x80000000  -924    0.155  __ipipe_unstall_root+0x1a (_read_unlock_irq+0x10)
:|   +end     0x80000000  -924    0.175  __ipipe_unstall_root+0x54 (_read_unlock_irq+0x10)
:    +func                -924    0.245  ipipe_check_context+0x9 (_read_unlock_irq+0x1a)
:    +func                -924    0.195  mark_page_accessed+0x9 (filemap_fault+0x20e)
:    +func                -923    0.135  page_address+0xe (__do_fault+0x201)
:    +func                -923    0.120  _spin_lock+0x9 (__do_fault+0x217)
:    +func                -923    0.195  ipipe_check_context+0x9 (_spin_lock+0x15)
:    +func                -923    0.170  page_add_file_rmap+0x8 (__do_fault+0x28a)
:    +func                -923    0.125  _spin_unlock+0x8 (__do_fault+0x2ca)
:    +func                -923    0.160  ipipe_check_context+0x9 (_spin_unlock+0x14)
:    +func                -923    0.140  unlock_page+0x9 (__do_fault+0x2d2)
:    +func                -922    0.170  page_waitqueue+0x8 (unlock_page+0x21)
:    +func                -922    0.195  __wake_up_bit+0xc (unlock_page+0x2a)
:    +func                -922    0.175  up_read+0x8 (do_page_fault+0x277)
:|   +begin   0x80000000  -922    0.145  __ipipe_handle_exception+0x17d (error_code+0x77)
:|   +func                -922    0.135  __ipipe_restore_root+0x8 (__ipipe_handle_exception+0x194)
:|   +func                -922    0.150  __ipipe_unstall_root+0x8 (__ipipe_restore_root+0x27)
:|   +end     0x80000000  -921    0.230  __ipipe_unstall_root+0x54 (__ipipe_restore_root+0x27)
:    #func                -921    0.180  __ipipe_unstall_iret_root+0x9 (restore_nocheck_notrace+0x0)
:|   #begin   0x80000000  -921    0.175  __ipipe_unstall_iret_root+0x1e (restore_nocheck_notrace+0x0)
:|   +end     0x8000000d  -921+   2.079  __ipipe_unstall_iret_root+0x6f (restore_nocheck_notrace+0x0)
:|   +func                -919    0.220  __ipipe_handle_exception+0xe (error_code+0x77)
:|   #func                -919    0.145  do_page_fault+0xe (__ipipe_handle_exception+0x16b)
:|   #end     0x80000000  -918    0.170  do_page_fault+0x3d (__ipipe_handle_exception+0x16b)
:    #func                -918    0.150  __ipipe_unstall_root+0x8 (do_page_fault+0x14f)
:|   #begin   0x80000000  -918    0.155  __ipipe_unstall_root+0x1a (do_page_fault+0x14f)
:|   +end     0x80000000  -918    0.140  __ipipe_unstall_root+0x54 (do_page_fault+0x14f)
:    +func                -918    0.175  down_read_trylock+0x9 (do_page_fault+0x175)
:    +func                -918    0.155  find_vma+0xa (do_page_fault+0x1a4)
:    +func                -917    0.120  handle_mm_fault+0xe (do_page_fault+0x220)
:    +func                -917    0.115  ipipe_check_context+0x9 (handle_mm_fault+0x2d)
:    +func                -917    0.140  ipipe_check_context+0x9 (handle_mm_fault+0x56)
:    +func                -917    0.140  page_address+0xe (handle_mm_fault+0xd4)
:    +func                -917    0.125  __do_fault+0xe (handle_mm_fault+0x277)
:    +func                -917    0.125  filemap_fault+0xe (__do_fault+0x56)
:    +func                -917    0.125  find_lock_page+0xb (filemap_fault+0x88)
:    +func                -917    0.150  _read_lock_irq+0x9 (find_lock_page+0x17)
:    +func                -916    0.165  ipipe_check_context+0x9 (_read_lock_irq+0x15)
:    #func                -916    0.180  ipipe_check_context+0x9 (_read_lock_irq+0x33)
:    #func                -916    0.260  radix_tree_lookup+0xb (find_lock_page+0x21)
:    #func                -916    0.145  _read_unlock_irq+0x8 (find_lock_page+0x75)
:    #func                -916    0.130  __ipipe_unstall_root+0x8 (_read_unlock_irq+0x10)
:|   #begin   0x80000000  -916    0.140  __ipipe_unstall_root+0x1a (_read_unlock_irq+0x10)
:|   +end     0x80000000  -915    0.125  __ipipe_unstall_root+0x54 (_read_unlock_irq+0x10)
:    +func                -915    0.145  ipipe_check_context+0x9 (_read_unlock_irq+0x1a)
:    +func                -915    0.130  mark_page_accessed+0x9 (filemap_fault+0x20e)
:    +func                -915    0.120  page_address+0xe (__do_fault+0x201)
:    +func                -915    0.115  _spin_lock+0x9 (__do_fault+0x217)
:    +func                -915    0.145  ipipe_check_context+0x9 (_spin_lock+0x15)
:    +func                -915! 904.855  page_add_file_rmap+0x8 (__do_fault+0x28a)
:    +func                 -10    0.360  _spin_unlock+0x8 (__do_fault+0x2ca)
:|   +begin   0xffffff16    -9    0.165  ipipe_ipi3+0x2e (__ipipe_trace+0x460)
:|   +func                  -9    0.140  __ipipe_handle_irq+0xe (ipipe_ipi3+0x33)
:|   +func                  -9    0.145  __ipipe_ack_apic+0x8 (__ipipe_handle_irq+0x76)
:|   +func                  -9    0.140  __ipipe_dispatch_wired+0xe (__ipipe_handle_irq+0x7f)
:|  # func                  -9    0.170  xnintr_clock_handler+0xe (__ipipe_dispatch_wired+0xe0)
:|  # func                  -9    0.205  xntimer_tick_aperiodic+0xe (xnintr_clock_handler+0x65)
:|  # func                  -8    0.135  xnthread_periodic_handler+0x8 (xntimer_tick_aperiodic+0x96)
:|  # func                  -8    0.170  xnpod_resume_thread+0xe (xnthread_periodic_handler+0x28)
:|  # [ 4827] -<?>-   99    -8    0.410  xnpod_resume_thread+0x99 (xnthread_periodic_handler+0x28)
:|  # func                  -8    0.265  xntimer_next_local_shot+0xe (xntimer_tick_aperiodic+0x1af)
:|  # func                  -7    0.671  xnpod_schedule+0xe (xnintr_clock_handler+0x108)
:|  # [ 6420] -<?>-   -1    -7    0.676  xnpod_schedule+0xe2 (xnintr_clock_handler+0x108)
:|  # func                  -6    0.541  __switch_to+0xe (xnpod_schedule+0xa24)
:|  # [ 4827] -<?>-   99    -6    0.340  xnpod_schedule+0xb2e (xnpod_suspend_thread+0x18a)
:|  # func                  -5    0.190  xntimer_get_overruns+0xe (xnpod_wait_thread_period+0xe5)
:|  # func                  -5    0.130  __ipipe_restore_pipeline_head+0x9 (xnpod_wait_thread_period+0x145)
:|  + end     0x80000000    -5    0.245  __ipipe_restore_pipeline_head+0x94 (xnpod_wait_thread_period+0x145)
:|  + begin   0x80000001    -5    0.170  __ipipe_dispatch_event+0x109 (__ipipe_syscall_root+0x8d)
:|  + end     0x80000001    -5+   1.157  __ipipe_dispatch_event+0x1db (__ipipe_syscall_root+0x8d)
:   + func                  -3    0.140  __ipipe_syscall_root+0xa (system_call+0x29)
:   + func                  -3    0.120  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x8d)
:|  + begin   0x80000001    -3    0.160  __ipipe_dispatch_event+0x2c (__ipipe_syscall_root+0x8d)
:|  + end     0x80000001    -3    0.155  __ipipe_dispatch_event+0xd6 (__ipipe_syscall_root+0x8d)
:   + func                  -3    0.561  hisyscall_event+0xe (__ipipe_dispatch_event+0xe6)
:   + func                  -2    0.511  xnshadow_sys_trace+0xb (hisyscall_event+0x13b)
:   + func                  -2    0.245  ipipe_trace_frozen_reset+0xa (xnshadow_sys_trace+0x62)
:   + func                  -1    0.320  __ipipe_global_path_lock+0xb (ipipe_trace_frozen_reset+0xf)
:   + func                  -1    0.130  __ipipe_spin_lock_irqsave+0xa (__ipipe_global_path_lock+0x15)
:|  + begin   0x80000001    -1+   1.137  __ipipe_spin_lock_irqsave+0x21 (__ipipe_global_path_lock+0x15)
:|  # func                   0    0.190  __ipipe_spin_unlock_irqcomplete+0xa (__ipipe_global_path_unlock+0x61)
:|  + end     0x80000001     0    0.170  __ipipe_spin_unlock_irqcomplete+0x49 (__ipipe_global_path_unlock+0x61)
<   + freeze  0x000cb262     0    0.160  xnshadow_sys_trace+0x6b (hisyscall_event+0x13b)
 |  + begin   0x80000001     0    0.150  __ipipe_dispatch_event+0x109 (__ipipe_syscall_root+0x8d)
 |  + end     0x80000001     0    0.486  __ipipe_dispatch_event+0x1db (__ipipe_syscall_root+0x8d)
    + func                   0    0.130  __ipipe_syscall_root+0xa (system_call+0x29)
    + func                   0    0.120  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x8d)
 |  + begin   0x80000001     1    0.140  __ipipe_dispatch_event+0x2c (__ipipe_syscall_root+0x8d)
 |  + end     0x80000001     1    0.135  __ipipe_dispatch_event+0xd6 (__ipipe_syscall_root+0x8d)
    + func                   1    0.150  hisyscall_event+0xe (__ipipe_dispatch_event+0xe6)
    + func                   1    0.110  __rt_task_wait_period+0xd (hisyscall_event+0x13b)
    + func                   1    0.135  rt_task_wait_period+0x8 (__rt_task_wait_period+0x34)
    + func                   1    0.000N xnpod_wait_thread_period+0xe (rt_task_wait_period+0x42)

--------------040301020300000205020006
Content-Type: text/plain;
 name="ipipe_trace_2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe_trace_2"

I-pipe frozen back-tracing service on 2.6.25/ipipe-2.0-08
------------------------------------------------------------
CPU: 0, Freeze: 231398316423 cycles, Trace Points: 100 (+10)
Calibrated minimum trace-point overhead: 0.125 us

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- <unused>
 |||+-- Xenomai
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
:|  # [    0] -<?>-   -1  -302    0.506  xnpod_schedule+0xe2 (xnintr_clock_handler+0x108)
:|  # func                -301    0.330  __switch_to+0xe (xnpod_schedule+0xa24)
:|  # [ 4836] samplin 99  -301    0.325  xnpod_schedule+0xb2e (xnpod_suspend_thread+0x18a)
:|  # func                -301    0.150  xntimer_get_overruns+0xe (xnpod_wait_thread_period+0xe5)
:|  # func                -300    0.130  __ipipe_restore_pipeline_head+0x9 (xnpod_wait_thread_period+0x145)
:|  + end     0x80000000  -300    0.205  __ipipe_restore_pipeline_head+0x94 (xnpod_wait_thread_period+0x145)
:|  + begin   0x80000001  -300    0.165  __ipipe_dispatch_event+0x109 (__ipipe_syscall_root+0x8d)
:|  + end     0x80000001  -300    0.626  __ipipe_dispatch_event+0x1db (__ipipe_syscall_root+0x8d)
:   + func                -299    0.135  __ipipe_syscall_root+0xa (system_call+0x29)
:   + func                -299    0.120  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x8d)
:|  + begin   0x80000001  -299    0.170  __ipipe_dispatch_event+0x2c (__ipipe_syscall_root+0x8d)
:|  + end     0x80000001  -299    0.150  __ipipe_dispatch_event+0xd6 (__ipipe_syscall_root+0x8d)
:   + func                -299    0.150  hisyscall_event+0xe (__ipipe_dispatch_event+0xe6)
:   + func                -299    0.110  __rt_task_wait_period+0xd (hisyscall_event+0x13b)
:   + func                -298    0.135  rt_task_wait_period+0x8 (__rt_task_wait_period+0x34)
:   + func                -298    0.145  xnpod_wait_thread_period+0xe (rt_task_wait_period+0x42)
:|  + begin   0x80000000  -298    0.220  xnpod_wait_thread_period+0x35 (rt_task_wait_period+0x42)
:|  # func                -298    0.160  xnpod_suspend_thread+0xe (xnpod_wait_thread_period+0xc4)
:|  # func                -298    0.140  xnpod_schedule+0xe (xnpod_suspend_thread+0x18a)
:|  # [ 4836] samplin 99  -298    0.481  xnpod_schedule+0xe2 (xnpod_suspend_thread+0x18a)
:|  # func                -297    0.260  __switch_to+0xe (xnpod_schedule+0xa24)
:|  # [    0] -<?>-   -1  -297    0.400  xnpod_schedule+0xb2e (xnintr_clock_handler+0x108)
:|   +func                -297    0.135  __ipipe_walk_pipeline+0xe (__ipipe_handle_irq+0x12b)
:|   #end     0xffffff16  -296    0.140  ipipe_ipi3+0x3d (default_idle+0x68)
:|   #func                -296    0.130  __ipipe_unstall_iret_root+0x9 (restore_nocheck_notrace+0x0)
:|   +end     0x8000000d  -296    0.260  __ipipe_unstall_iret_root+0x6f (restore_nocheck_notrace+0x0)
:    +func                -296    0.170  ipipe_check_context+0x9 (default_idle+0x72)
:    #func                -296    0.110  ktime_get+0xc (default_idle+0x8b)
:    #func                -296    0.125  ktime_get_ts+0xa (ktime_get+0x16)
:    #func                -295    0.130  getnstimeofday+0xe (ktime_get_ts+0x19)
:    #func                -295    0.130  jiffies_read+0x8 (getnstimeofday+0x34)
:    #func                -295    0.125  set_normalized_timespec+0x8 (ktime_get_ts+0x40)
:    #func                -295    0.110  sched_clock_idle_wakeup_event+0xe (default_idle+0x94)
:    #func                -295    0.130  native_sched_clock+0xe (sched_clock_idle_wakeup_event+0x2b)
:    #func                -295    0.170  native_read_tsc+0x8 (native_sched_clock+0x4f)
:    #func                -295    0.170  ipipe_check_context+0x9 (native_sched_clock+0x5d)
:    #func                -294    0.160  __ipipe_restore_root+0x8 (native_sched_clock+0xc5)
:    #func                -294    0.115  _spin_lock+0x9 (sched_clock_idle_wakeup_event+0x48)
:    #func                -294    0.140  ipipe_check_context+0x9 (_spin_lock+0x15)
:    #func                -294    0.110  _spin_unlock+0x8 (sched_clock_idle_wakeup_event+0x6d)
:    #func                -294    0.120  ipipe_check_context+0x9 (_spin_unlock+0x14)
:    #func                -294    0.120  __ipipe_unstall_root+0x8 (default_idle+0x99)
:|   #begin   0x80000000  -294    0.135  __ipipe_unstall_root+0x1a (default_idle+0x99)
:|   +end     0x80000000  -294    0.150  __ipipe_unstall_root+0x54 (default_idle+0x99)
:    +func                -293    0.115  rcu_pending+0x9 (cpu_idle+0x38)
:    +func                -293    0.125  __rcu_pending+0x8 (rcu_pending+0x21)
:    +func                -293    0.120  __rcu_pending+0x8 (rcu_pending+0x3b)
:    +func                -293    0.120  ipipe_suspend_domain+0xe (cpu_idle+0xb7)
:|   +begin   0x80000001  -293    0.195  ipipe_suspend_domain+0x2a (cpu_idle+0xb7)
:|   +end     0x80000001  -293    0.150  ipipe_suspend_domain+0xdf (cpu_idle+0xb7)
:    +func                -293    0.125  default_idle+0xa (cpu_idle+0xb9)
:|   +begin   0x80000000  -292    0.150  default_idle+0x46 (cpu_idle+0xb9)
:|   +func                -292    0.115  ktime_get+0xc (default_idle+0x58)
:|   +func                -292    0.115  ktime_get_ts+0xa (ktime_get+0x16)
:|   +func                -292    0.115  getnstimeofday+0xe (ktime_get_ts+0x19)
:|   +func                -292    0.135  jiffies_read+0x8 (getnstimeofday+0x34)
:|   +func                -292    0.115  set_normalized_timespec+0x8 (ktime_get_ts+0x40)
:|   +end     0x8000000e  -292! 282.688  default_idle+0x66 (cpu_idle+0xb9)
:|   +begin   0xffffff16    -9    0.150  ipipe_ipi3+0x2e (default_idle+0x68)
:|   +func                  -9    0.115  __ipipe_handle_irq+0xe (ipipe_ipi3+0x33)
:|   +func                  -9    0.135  __ipipe_ack_apic+0x8 (__ipipe_handle_irq+0x76)
:|   +func                  -9    0.125  __ipipe_dispatch_wired+0xe (__ipipe_handle_irq+0x7f)
:|  # func                  -9    0.175  xnintr_clock_handler+0xe (__ipipe_dispatch_wired+0xe0)
:|  # func                  -8    0.185  xntimer_tick_aperiodic+0xe (xnintr_clock_handler+0x65)
:|  # func                  -8    0.115  xnthread_periodic_handler+0x8 (xntimer_tick_aperiodic+0x96)
:|  # func                  -8    0.135  xnpod_resume_thread+0xe (xnthread_periodic_handler+0x28)
:|  # [ 4836] samplin 99    -8    0.235  xnpod_resume_thread+0x99 (xnthread_periodic_handler+0x28)
:|  # func                  -8    0.250  xntimer_next_local_shot+0xe (xntimer_tick_aperiodic+0x1af)
:|  # func                  -7    0.150  xnpod_schedule+0xe (xnintr_clock_handler+0x108)
:|  # [    0] -<?>-   -1    -7    0.716  xnpod_schedule+0xe2 (xnintr_clock_handler+0x108)
:|  # func                  -7    0.330  __switch_to+0xe (xnpod_schedule+0xa24)
:|  # [ 4836] samplin 99    -6    0.325  xnpod_schedule+0xb2e (xnpod_suspend_thread+0x18a)
:|  # func                  -6    0.260  xntimer_get_overruns+0xe (xnpod_wait_thread_period+0xe5)
:|  # func                  -6    0.130  __ipipe_restore_pipeline_head+0x9 (xnpod_wait_thread_period+0x145)
:|  + end     0x80000000    -6    0.225  __ipipe_restore_pipeline_head+0x94 (xnpod_wait_thread_period+0x145)
:|  + begin   0x80000001    -5    0.165  __ipipe_dispatch_event+0x109 (__ipipe_syscall_root+0x8d)
:|  + end     0x80000001    -5    0.771  __ipipe_dispatch_event+0x1db (__ipipe_syscall_root+0x8d)
:   + func                  -4    0.135  __ipipe_syscall_root+0xa (system_call+0x29)
:   + func                  -4    0.125  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x8d)
:|  + begin   0x80000001    -4    0.170  __ipipe_dispatch_event+0x2c (__ipipe_syscall_root+0x8d)
:|  + end     0x80000001    -4    0.390  __ipipe_dispatch_event+0xd6 (__ipipe_syscall_root+0x8d)
:|  + begin   0xffffff16    -4    0.160  ipipe_ipi3+0x2e (__ipipe_dispatch_event+0xda)
:|  + func                  -3    0.155  __ipipe_handle_irq+0xe (ipipe_ipi3+0x33)
:|  + func                  -3    0.135  __ipipe_ack_apic+0x8 (__ipipe_handle_irq+0x76)
:|  + func                  -3    0.135  __ipipe_dispatch_wired+0xe (__ipipe_handle_irq+0x7f)
:|  # func                  -3    0.165  xnintr_clock_handler+0xe (__ipipe_dispatch_wired+0xe0)
:|  # func                  -3    0.155  xntimer_tick_aperiodic+0xe (xnintr_clock_handler+0x65)
:|  # func                  -3    0.215  xnthread_periodic_handler+0x8 (xntimer_tick_aperiodic+0x96)
:|  # func                  -2    0.395  xntimer_next_local_shot+0xe (xntimer_tick_aperiodic+0x1af)
:|  + func                  -2    0.170  __ipipe_walk_pipeline+0xe (__ipipe_handle_irq+0x12b)
:|  + end     0xffffff16    -2    0.275  ipipe_ipi3+0x3d (__ipipe_dispatch_event+0xda)
:   + func                  -2    0.215  hisyscall_event+0xe (__ipipe_dispatch_event+0xe6)
:   + func                  -1    0.160  xnshadow_sys_trace+0xb (hisyscall_event+0x13b)
:   + func                  -1    0.125  ipipe_trace_frozen_reset+0xa (xnshadow_sys_trace+0x62)
:   + func                  -1    0.125  __ipipe_global_path_lock+0xb (ipipe_trace_frozen_reset+0xf)
:   + func                  -1    0.180  __ipipe_spin_lock_irqsave+0xa (__ipipe_global_path_lock+0x15)
:|  + begin   0x80000001    -1    0.896  __ipipe_spin_lock_irqsave+0x21 (__ipipe_global_path_lock+0x15)
:|  # func                   0    0.185  __ipipe_spin_unlock_irqcomplete+0xa (__ipipe_global_path_unlock+0x61)
:|  + end     0x80000001     0    0.175  __ipipe_spin_unlock_irqcomplete+0x49 (__ipipe_global_path_unlock+0x61)
<   + freeze  0x00030627     0    0.160  xnshadow_sys_trace+0x6b (hisyscall_event+0x13b)
 |  + begin   0x80000001     0    0.175  __ipipe_dispatch_event+0x109 (__ipipe_syscall_root+0x8d)
 |  + end     0x80000001     0    0.501  __ipipe_dispatch_event+0x1db (__ipipe_syscall_root+0x8d)
    + func                   0    0.130  __ipipe_syscall_root+0xa (system_call+0x29)
    + func                   0    0.120  __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x8d)
 |  + begin   0x80000001     1    0.155  __ipipe_dispatch_event+0x2c (__ipipe_syscall_root+0x8d)
 |  + end     0x80000001     1    0.175  __ipipe_dispatch_event+0xd6 (__ipipe_syscall_root+0x8d)
    + func                   1    0.135  hisyscall_event+0xe (__ipipe_dispatch_event+0xe6)
    + func                   1    0.110  __rt_task_wait_period+0xd (hisyscall_event+0x13b)
    + func                   1    0.145  rt_task_wait_period+0x8 (__rt_task_wait_period+0x34)
    + func                   1    0.000N xnpod_wait_thread_period+0xe (rt_task_wait_period+0x42)

--------------040301020300000205020006--

