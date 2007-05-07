Message-ID: <463F1468.8010403@domain.hid>
Date: Mon, 07 May 2007 13:58:32 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <4639D724.5010702@domain.hid>	<1178198991.29605.54.camel@domain.hid>
	<463AE79E.2090901@domain.hid>
	<1178281926.29093.93.camel@domain.hid> <463B2A69.7080704@domain.hid>
	<463EE376.9030702@domain.hid> <463EEA4A.1070405@domain.hid>
In-Reply-To: <463EEA4A.1070405@domain.hid>
Content-Type: multipart/mixed; boundary="------------020501010400020009070906"
Subject: Re: [Xenomai-help] Latency calculation and test
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
Cc: Xenomai-help@domain.hid

This is a multi-part message in MIME format.
--------------020501010400020009070906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> I don't see anything suspicious right now, so please consider capturing
> a trace with the latency as I suggested. That should give a full picture
> of what is happening when latency detects that huge delay.
>
> Jan
To get the tracing to work I had to set CONFIG_IPIPE_TRACE_VMALLOC, as 
my system did not boot when this was not set. I also set 
CONFIG_IPIPE_TRACE_SHIFT to 16. I attached the logfile of a latency session.

This is the log of the cyclictest-session:
bash-3.00# ./cyclictest-Xenomai -q -h
#T: 0 P:80 I:10000 O:   0 C: 100 Min: -5.151 Avg: -0.013 Max:    
6.645        
#T: 1 P:79 I:10000 O:   0 C: 100 Min: -4.334 Avg: 11.177 Max: 
1118.283        
#T: 2 P:78 I:10000 O:   0 C: 100 Min: -6.304 Avg:  3.983 Max:  
399.461        
#T: 3 P:77 I:10000 O:   0 C: 100 Min: -5.296 Avg:  0.005 Max:    
7.245        
#T: 4 P:76 I:10000 O:   0 C: 100 Min: -3.541 Avg:  0.050 Max:    
7.077        
#T: 5 P:75 I:10000 O:   0 C: 100 Min: -5.848 Avg: -0.001 Max:    
6.549        
#T: 6 P:74 I:10000 O:   0 C: 100 Min: -4.431 Avg: -0.004 Max:    
6.620        
#T: 7 P:73 I:10000 O:   0 C: 100 Min: -5.319 Avg: -0.009 Max:    
7.414        
#T: 8 P:72 I:10000 O:   0 C: 100 Min: -4.647 Avg: -0.011 Max:    
7.341        
#T: 9 P:71 I:10000 O:   0 C: 100 Min: -4.598 Avg: -0.009 Max:    
7.101        

Kind regards,
    Johan Borkhuis




--------------020501010400020009070906
Content-Type: text/x-log;
 name="xenomai.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai.log"

bash-3.00# modprobe xeno_native
xeno_nucleus: no version for "per_cpu__ipipe_percpu_domain" found: kernel tainted.
I-pipe: Domain Xenomai registered.
bash-3.00# echo 1 > /proc/ipipe/trace/enable
bash-3.00# echo 50 > /proc/ipipe/trace/back_trace_points
bash-3.00# echo 50 > /proc/ipipe/trace/pre_trace_points
bash-3.00# echo 50 > /proc/ipipe/trace/post_trace_points
bash-3.00# echo 1 > /proc/ipipe/trace/verbose
bash-3.00# echo 0 > /proc/ipipe/trace/frozen
bash-3.00# cat /proc/ipipe/trace/frozen
bash-3.00# ./latency -f -P 60
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 60)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -2.210|       0.840|       6.438|       0|      -2.210|       6.438
RTD|      -2.450|       0.744|      15.255|       0|      -2.450|      15.255
RTD|      -2.162|       0.792|       7.015|       0|      -2.450|      15.255
RTD|      -2.210|       0.864|       9.009|       0|      -2.450|      15.255
RTD|      -2.258|       0.840|       8.576|       0|      -2.450|      15.255
RTD|      -2.186|       0.840|       9.249|       0|      -2.450|      15.255
RTD|      -2.330|       0.792|       8.408|       0|      -2.450|      15.255
RTD|      -2.354|       0.792|       6.942|       0|      -2.450|      15.255
RTD|      -2.258|       0.864|       9.465|       0|      -2.450|      15.255
RTD|      -2.138|       0.792|       8.696|       0|      -2.450|      15.255
RTD|      -2.258|       0.864|      11.723|       0|      -2.450|      15.255
RTD|      -2.306|       0.864|      10.786|       0|      -2.450|      15.255
RTD|      -2.138|       0.816|      11.123|       0|      -2.450|      15.255
RTD|      -2.018|       0.864|      16.168|       0|      -2.450|      16.168
RTD|      -2.378|       0.768|      10.618|       0|      -2.450|      16.168
RTD|      -1.993|       0.816|       8.648|       0|      -2.450|      16.168
RTD|      -2.330|       0.816|      13.717|       0|      -2.450|      16.168
RTD|      -2.258|       0.816|      12.612|       0|      -2.450|      16.168
RTD|      -2.234|       0.816|      10.978|       0|      -2.450|      16.168
RTD|      -1.993|       1.633|      92.540|       0|      -2.450|      92.540
RTD|      -2.186|       1.201|    1855.807|      20|      -2.450|    1855.807
RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 60)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -2.282|       0.744|      10.762|      20|      -2.450|    1855.807
RTD|      -2.306|       0.792|      14.198|      20|      -2.450|    1855.807
RTD|      -2.354|       0.744|       6.294|      20|      -2.450|    1855.807
RTD|      -1.633|       0.816|       6.486|      20|      -2.450|    1855.807
RTD|      -2.018|       0.840|       8.888|      20|      -2.450|    1855.807
---|------------|------------|------------|--------|-------------------------
RTS|      -2.450|       0.840|    1855.807|      20|    00:00:27/00:00:27
bash-3.00# cat /proc/ipipe/trace/frozen
I-pipe frozen back-tracing service on 2.6.14.Xenomai/ipipe-1.5-01
------------------------------------------------------------

******** WARNING ********
The following debugging options will increase the observed latencies:
 o CONFIG_XENO_OPT_DEBUG

Freeze: 7245009537 cycles, Trace Points: 50 (+50)

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- <unused>
 |||+-- Xenomai
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
:|   #func                 -30    0.414  __ipipe_walk_pipeline+0x14 (__ipipe_handle_irq+0xd4)
:|   #end     0x80000001   -29    0.536  ipipe_trigger_irq+0xf4 (xnpod_schedule+0x5a4 [xeno_nucleus])
:|   #begin   0x80000001   -29    0.390  lostage_handler+0x1f4 [xeno_nucleus] (rthal_apc_handler+0xb8)
:|  *#func                 -29    0.341  xnpod_schedule_runnable+0x14 [xeno_nucleus] (lostage_handler+0x13c [xeno_nucleus])
:|  *#[ 1110] -<?>-   -1   -28    0.439  xnpod_schedule_runnable+0x54 [xeno_nucleus] (lostage_handler+0x13c [xeno_nucleus])
:|  *#func                 -28    0.365  __ipipe_restore_pipeline_head+0x14 (lostage_handler+0x158 [xeno_nucleus])
:|   #end     0x80000000   -27    0.414  __ipipe_restore_pipeline_head+0xd4 (lostage_handler+0x158 [xeno_nucleus])
:    #func                 -27    0.341  wake_up_process+0x14 (lostage_handler+0x94 [xeno_nucleus])
:    #func                 -27    0.487  try_to_wake_up+0x14 (wake_up_process+0x34)
:    #func                 -26    0.585  __ipipe_test_and_stall_root+0x14 (try_to_wake_up+0x38)
:    #func                 -26    0.414  sched_clock+0x14 (try_to_wake_up+0xd0)
:    #func                 -25    0.487  recalc_task_prio+0x14 (try_to_wake_up+0xe8)
:    #func                 -25    0.585  effective_prio+0x14 (recalc_task_prio+0x17c)
:    #func                 -24    0.585  enqueue_task+0x14 (try_to_wake_up+0x128)
:    #func                 -24    0.365  __ipipe_restore_root+0x14 (try_to_wake_up+0x74)
:    #func                 -23    0.487  __ipipe_stall_root+0x14 (__ipipe_restore_root+0x34)
:    #func                 -23    0.390  xnpod_schedule+0x14 [xeno_nucleus] (lostage_handler+0xa8 [xeno_nucleus])
:    #func                 -22    0.390  ipipe_trigger_irq+0x14 (xnpod_schedule+0x5a4 [xeno_nucleus])
:|   #begin   0x80000001   -22    0.390  ipipe_trigger_irq+0xfc (xnpod_schedule+0x5a4 [xeno_nucleus])
:|   #func                 -22    0.390  __ipipe_handle_irq+0x14 (ipipe_trigger_irq+0x108)
:|   #func                 -21    0.463  __ipipe_dispatch_wired+0x14 (__ipipe_handle_irq+0xc0)
:|  #*func                 -21    0.317  xnpod_schedule_handler+0x14 [xeno_nucleus] (__ipipe_dispatch_wired+0x148)
:|  #*func                 -21    0.365  xnpod_schedule+0x14 [xeno_nucleus] (xnpod_schedule_handler+0x4c [xeno_nucleus])
:|  #*[ 1110] -<?>-   -1   -20+   1.951  xnpod_schedule+0xb8 [xeno_nucleus] (xnpod_schedule_handler+0x4c [xeno_nucleus])
:|  #*[ 1107] -<?>-   60   -18    0.439  xnpod_schedule+0x420 [xeno_nucleus] (xnpod_suspend_thread+0x20c [xeno_nucleus])
:|  #*func                 -18    0.682  xntimer_get_raw_clock_aperiodic+0x14 [xeno_nucleus] (xnpod_wait_thread_period+0xd0 [xeno_nucleus])
:|  #*func                 -17    0.317  __ipipe_restore_pipeline_head+0x14 (xnpod_wait_thread_period+0x130 [xeno_nucleus])
:|  +*end     0x80000000   -17+   2.000  __ipipe_restore_pipeline_head+0xd4 (xnpod_wait_thread_period+0x130 [xeno_nucleus])
:|  +*begin   0x80000001   -15    0.414  __ipipe_dispatch_event+0x1e4 (__ipipe_syscall_root+0x64)
:|  +*end     0x80000001   -15+   3.243  __ipipe_dispatch_event+0x204 (__ipipe_syscall_root+0x64)
:   +*func                 -11    0.341  __ipipe_syscall_root+0x14 (DoSyscall+0x24)
:   +*func                 -11    0.341  __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0x64)
:|  +*begin   0x80000001   -11    0.439  __ipipe_dispatch_event+0x27c (__ipipe_syscall_root+0x64)
:|  +*end     0x80000001   -10    0.341  __ipipe_dispatch_event+0x1a4 (__ipipe_syscall_root+0x64)
:   +*func                 -10+   1.170  hisyscall_event+0x14 [xeno_nucleus] (__ipipe_dispatch_event+0x1bc)
:   +*func                  -9    0.682  __rt_timer_tsc2ns+0x14 [xeno_native] (hisyscall_event+0x20c [xeno_nucleus])
:   +*func                  -8+   1.560  rt_timer_tsc2ns+0x14 [xeno_native] (__rt_timer_tsc2ns+0x48 [xeno_native])
:|  +*begin   0x80000001    -7    0.390  __ipipe_dispatch_event+0x1e4 (__ipipe_syscall_root+0x64)
:|  +*end     0x80000001    -6    0.658  __ipipe_dispatch_event+0x204 (__ipipe_syscall_root+0x64)
:   +*func                  -6    0.317  __ipipe_syscall_root+0x14 (DoSyscall+0x24)
:   +*func                  -5    0.341  __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0x64)
:|  +*begin   0x80000001    -5    0.390  __ipipe_dispatch_event+0x27c (__ipipe_syscall_root+0x64)
:|  +*end     0x80000001    -5    0.341  __ipipe_dispatch_event+0x1a4 (__ipipe_syscall_root+0x64)
:   +*func                  -4    0.658  hisyscall_event+0x14 [xeno_nucleus] (__ipipe_dispatch_event+0x1bc)
:   +*func                  -4    0.829  xnshadow_sys_trace+0x14 [xeno_nucleus] (hisyscall_event+0x20c [xeno_nucleus])
:   +*func                  -3    0.341  ipipe_trace_frozen_reset+0x14 (xnshadow_sys_trace+0x128 [xeno_nucleus])
:   +*func                  -2    0.560  __ipipe_global_path_lock+0x14 (ipipe_trace_frozen_reset+0x2c)
:|  +*begin   0x80000001    -2+   1.609  __ipipe_global_path_lock+0x104 (ipipe_trace_frozen_reset+0x2c)
:|  +*end     0x80000001     0    0.804  __ipipe_global_path_unlock+0x84 (ipipe_trace_frozen_reset+0x8c)
<   +*freeze  0x001c513f     0    0.756  xnshadow_sys_trace+0x134 [xeno_nucleus] (hisyscall_event+0x20c [xeno_nucleus])
 |  +*begin   0x80000001     0    0.341  __ipipe_dispatch_event+0x1e4 (__ipipe_syscall_root+0x64)
 |  +*end     0x80000001     1    0.756  __ipipe_dispatch_event+0x204 (__ipipe_syscall_root+0x64)
    +*func                   1    0.341  __ipipe_syscall_root+0x14 (DoSyscall+0x24)
    +*func                   2    0.341  __ipipe_dispatch_event+0x14 (__ipipe_syscall_root+0x64)
 |  +*begin   0x80000001     2    0.317  __ipipe_dispatch_event+0x27c (__ipipe_syscall_root+0x64)
 |  +*end     0x80000001     2    0.317  __ipipe_dispatch_event+0x1a4 (__ipipe_syscall_root+0x64)
    +*func                   3    0.731  hisyscall_event+0x14 [xeno_nucleus] (__ipipe_dispatch_event+0x1bc)
    +*func                   3    0.463  __rt_task_wait_period+0x14 [xeno_native] (hisyscall_event+0x20c [xeno_nucleus])
    +*func                   4    0.390  rt_task_wait_period+0x14 [xeno_native] (__rt_task_wait_period+0x44 [xeno_native])
    +*func                   4    0.365  xnpod_wait_thread_period+0x14 [xeno_nucleus] (rt_task_wait_period+0x80 [xeno_native])
 |  +*begin   0x80000001     5    0.512  xnpod_wait_thread_period+0x158 [xeno_nucleus] (rt_task_wait_period+0x80 [xeno_native])
 |  #*func                   5    0.365  xntimer_get_raw_clock_aperiodic+0x14 [xeno_nucleus] (xnpod_wait_thread_period+0x88 [xeno_nucleus])
 |  #*func                   5    0.439  xnpod_suspend_thread+0x14 [xeno_nucleus] (xnpod_wait_thread_period+0xb4 [xeno_nucleus])
 |  #*func                   6    0.365  xnpod_schedule+0x14 [xeno_nucleus] (xnpod_suspend_thread+0x20c [xeno_nucleus])
 |  #*[ 1107] -<?>-   60     6    0.756  xnpod_schedule+0xb8 [xeno_nucleus] (xnpod_suspend_thread+0x20c [xeno_nucleus])
 |  #*[ 1110] -<?>-   -1     7    0.365  xnpod_schedule+0x420 [xeno_nucleus] (xnpod_schedule_handler+0x4c [xeno_nucleus])
 |   #func                   7    0.390  __ipipe_walk_pipeline+0x14 (__ipipe_handle_irq+0xd4)
 |   #end     0x80000001     8    0.487  ipipe_trigger_irq+0xf4 (xnpod_schedule+0x5a4 [xeno_nucleus])
     #func                   8    0.585  lostage_handler+0x14 [xeno_nucleus] (rthal_apc_handler+0xb8)
 |   #begin   0x80000000     9    0.536  __ipipe_sync_stage+0x260 (__ipipe_walk_pipeline+0x110)
 |   #end     0x80000000     9    0.512  __ipipe_sync_stage+0x220 (__ipipe_walk_pipeline+0x110)
     #func                  10    0.439  __ipipe_do_timer+0x14 (__ipipe_sync_stage+0x248)
     #func                  10    0.780  timer_interrupt+0x14 (__ipipe_do_timer+0x30)
     #func                  11    0.682  profile_tick+0x14 (timer_interrupt+0x144)
     #func                  12    0.682  update_process_times+0x14 (timer_interrupt+0x150)
     #func                  12    0.804  account_user_time+0x14 (update_process_times+0x40)
     #func                  13    0.463  run_local_timers+0x14 (update_process_times+0x44)
     #func                  13    0.365  raise_softirq+0x14 (run_local_timers+0x30)
     #func                  14    0.414  __ipipe_test_and_stall_root+0x14 (raise_softirq+0x30)
     #func                  14    0.365  __ipipe_restore_root+0x14 (raise_softirq+0x84)
     #func                  15    0.853  __ipipe_stall_root+0x14 (__ipipe_restore_root+0x34)
     #func                  15    0.585  rcu_check_callbacks+0x14 (update_process_times+0x78)
     #func                  16    0.317  __tasklet_schedule+0x14 (rcu_check_callbacks+0x70)
     #func                  16    0.609  __ipipe_test_and_stall_root+0x14 (__tasklet_schedule+0x30)
     #func                  17    0.292  __ipipe_restore_root+0x14 (__tasklet_schedule+0x8c)
     #func                  17    0.609  __ipipe_stall_root+0x14 (__ipipe_restore_root+0x34)
     #func                  18    0.317  scheduler_tick+0x14 (update_process_times+0x7c)
     #func                  18    0.829  sched_clock+0x14 (scheduler_tick+0x34)
     #func                  19    0.341  run_posix_cpu_timers+0x14 (update_process_times+0x84)
     #func                  19    0.731  __ipipe_test_root+0x14 (run_posix_cpu_timers+0x44)
     #func                  20    1.121  do_timer+0x14 (timer_interrupt+0x168)
     #func                  21    0.902  softlockup_tick+0x14 (do_timer+0x2ac)
     #func                  22    0.439  irq_exit+0x14 (timer_interrupt+0xb8)
     #func                  22    0.341  do_softirq+0x14 (irq_exit+0x6c)
     #func                  23    0.609  __ipipe_test_and_stall_root+0x14 (do_softirq+0x54)
 |   #func                  23    0.292  __ipipe_grab_timer+0x14 (__ipipe_ret_from_except+0x0)
 |   #begin   0x00000080    24    0.365  __ipipe_grab_timer+0x34 (__ipipe_ret_from_except+0x0)
 |   #func                  24    0.414  __ipipe_handle_irq+0x14 (__ipipe_grab_timer+0xbc)
 |   #func                  24    0.536  __ipipe_dispatch_wired+0x14 (__ipipe_handle_irq+0xc0)
 |  #*func                  25    0.000  xnintr_clock_handler+0x14 [xeno_nucleus] (__ipipe_dispatch_wired+0x148)
bash-3.00#

--------------020501010400020009070906--

