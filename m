Message-ID: <445656F0.2020800@domain.hid>
Date: Mon, 01 May 2006 20:44:00 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] I-pipe latency tracer for ppc
References: <444FF092.2010002@domain.hid>
In-Reply-To: <444FF092.2010002@domain.hid>
Content-Type: multipart/mixed; boundary="------------050108000006070506040607"
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
Cc: adeos-main@gna.org, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------050108000006070506040607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> 
> As promised, the I-pipe tracer has been ported to ppc. People working on 
> this architecture are invited to give it a try, it's a great tool to 
> find out where the cycles are actually going.
> 
> Just apply the tracer patch on top of the Adeos patch bearing the same 
> revision number, and select the feature from the kernel configuration. 
> If you happen to have some issue while booting the instrumented kernel 
> on embedded setups (e.g. freeze after kernel decompression), try 
> reducing the size of the trace log (CONFIG_IPIPE_TRACE_SHIFT).
> 
> http://download.gna.org/adeos/patches/v2.6/ppc/tracer/

I gave it a try on a rather low-end PowerPC Walnut board (AMCC PowerPC 
405GP, Rev. E at 200 MHz, 16 kB I-Cache 8 kB D-Cache). A nice tool, 
indeed, and it works fine. I have attached the results from running the 
Xenomai latency "-t0" test with some load showing latencies up to 140 
us. The trace seems not to show any obvious problems, I think.

Thanks.

Wolfgang.


--------------050108000006070506040607
Content-Type: text/x-log;
 name="walnut-latency-trace.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="walnut-latency-trace.log"


bash-3.00# cat /proc/ipipe/version
1.3-00

bash-3.00# ./latency -p500
== Sampling period: 500 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
...
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTS|      59.020|      67.260|     138.910|       0|    00:54:31/00:54:31

bash-3.00# cat /proc/ipipe/trace/max
I-pipe worst-case tracing service on 2.6.14/ipipe-1.3-00
------------------------------------------------------------
Begin: 182095500 cycles, Trace Points: 192 (-10/+3), Length: 265 us
 
 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- <unused>
 |||+-- Xenomai
 ||||+- Linux ('*': domain stalled)
 |||||                       +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||||                       |        +- NMI noise ('N')
 |||||                       |        |
      Type   User Val.   Time    Delay  Function (Parent)
     *fn                  -30    3.465  timer_interrupt+0x14 (__ipipe_do_timer+0x30)
     *fn                  -26    2.430  profile_tick+0x14 (timer_interrupt+0x130)
     *fn                  -24    1.865  profile_hit+0x14 (profile_tick+0x78)
     *fn                  -22    1.700  update_process_times+0x14 (timer_interrupt+0x13c)
     *fn                  -20    3.505  account_system_time+0x14 (update_process_times+0xac)
     *fn                  -17    2.195  update_mem_hiwater+0x14 (account_system_time+0x78)
     *fn                  -15    1.200  run_local_timers+0x14 (update_process_times+0xb0)
     *fn                  -14   11.905  raise_softirq+0x14 (run_local_timers+0x30)
     *fn                   -2    1.200  __ipipe_restore_root+0x14 (raise_softirq+0x84)
     *fn                   -1    1.095  __ipipe_stall_root+0x14 (__ipipe_restore_root+0x34)
>|   *begin  0x80000000     0+   3.950  __ipipe_stall_root+0x98 (__ipipe_restore_root+0x34)
:|   *fn                    3+   1.500  scheduler_tick+0x14 (update_process_times+0x7c)
:|   *fn                    5+   4.040  sched_clock+0x14 (scheduler_tick+0x34)
:|   *fn                    9+   1.160  run_posix_cpu_timers+0x14 (update_process_times+0x84)
:|   *fn                   10+   3.120  __ipipe_test_root+0x14 (run_posix_cpu_timers+0x44)
:|   *fn                   13+   2.920  do_timer+0x14 (timer_interrupt+0x154)
:|   *fn                   16+   1.500  profile_tick+0x14 (timer_interrupt+0x130)
:|   *fn                   18+   1.140  profile_hit+0x14 (profile_tick+0x78)
:|   *fn                   19+   1.270  update_process_times+0x14 (timer_interrupt+0x13c)
:|   *fn                   20+   1.370  account_system_time+0x14 (update_process_times+0xac)
:|   *fn                   21+   1.325  update_mem_hiwater+0x14 (account_system_time+0x78)
:|   *fn                   23    0.995  run_local_timers+0x14 (update_process_times+0xb0)
:|   *fn                   24+   1.140  raise_softirq+0x14 (run_local_timers+0x30)
:|   *fn                   25+   1.350  __ipipe_test_and_stall_root+0x14 (raise_softirq+0x30)
:|   *fn                   26+   1.205  __ipipe_restore_root+0x14 (raise_softirq+0x84)
:|   *fn                   27+   1.735  __ipipe_stall_root+0x14 (__ipipe_restore_root+0x34)
:|   *fn                   29+   1.160  scheduler_tick+0x14 (update_process_times+0x7c)
:|   *fn                   30+   1.565  sched_clock+0x14 (scheduler_tick+0x34)
:|   *fn                   32+   1.285  run_posix_cpu_timers+0x14 (update_process_times+0x84)
:|   *fn                   33+   1.560  __ipipe_test_root+0x14 (run_posix_cpu_timers+0x44)
:|   *fn                   35+   3.075  do_timer+0x14 (timer_interrupt+0x154)
:|   *fn                   38+   1.460  profile_tick+0x14 (timer_interrupt+0x130)
:|   *fn                   39+   1.300  profile_hit+0x14 (profile_tick+0x78)
:|   *fn                   40+   1.035  update_process_times+0x14 (timer_interrupt+0x13c)
:|   *fn                   41+   1.350  account_system_time+0x14 (update_process_times+0xac)
:|   *fn                   43+   1.275  update_mem_hiwater+0x14 (account_system_time+0x78)
:|   *fn                   44+   1.195  run_local_timers+0x14 (update_process_times+0xb0)
:|   *fn                   45    1.000  raise_softirq+0x14 (run_local_timers+0x30)
:|   *fn                   46+   1.330  __ipipe_test_and_stall_root+0x14 (raise_softirq+0x30)
:|   *fn                   48+   1.155  __ipipe_restore_root+0x14 (raise_softirq+0x84)
:|   *fn                   49+   1.940  __ipipe_stall_root+0x14 (__ipipe_restore_root+0x34)
:|   *fn                   51+   1.025  scheduler_tick+0x14 (update_process_times+0x7c)
:|   *fn                   52+   1.525  sched_clock+0x14 (scheduler_tick+0x34)
:|   *fn                   53+   1.245  run_posix_cpu_timers+0x14 (update_process_times+0x84)
:|   *fn                   54+   1.595  __ipipe_test_root+0x14 (run_posix_cpu_timers+0x44)
:|   *fn                   56+   1.635  do_timer+0x14 (timer_interrupt+0x154)
:|   *fn                   58+   1.445  profile_tick+0x14 (timer_interrupt+0x130)
:|   *fn                   59+   1.300  profile_hit+0x14 (profile_tick+0x78)
:|   *fn                   60+   1.235  update_process_times+0x14 (timer_interrupt+0x13c)
:|   *fn                   62+   1.210  account_system_time+0x14 (update_process_times+0xac)
:|   *fn                   63+   1.255  update_mem_hiwater+0x14 (account_system_time+0x78)
:|   *fn                   64+   1.155  run_local_timers+0x14 (update_process_times+0xb0)
:|   *fn                   65+   1.235  raise_softirq+0x14 (run_local_timers+0x30)
:|   *fn                   66+   1.195  __ipipe_test_and_stall_root+0x14 (raise_softirq+0x30)
:|   *fn                   68+   1.095  __ipipe_restore_root+0x14 (raise_softirq+0x84)
:|   *fn                   69+   1.900  __ipipe_stall_root+0x14 (__ipipe_restore_root+0x34)
:|   *fn                   71+   1.225  scheduler_tick+0x14 (update_process_times+0x7c)
:|   *fn                   72+   1.420  sched_clock+0x14 (scheduler_tick+0x34)
:|   *fn                   73+   1.220  run_posix_cpu_timers+0x14 (update_process_times+0x84)
:|   *fn                   74+   1.545  __ipipe_test_root+0x14 (run_posix_cpu_timers+0x44)
:|   *fn                   76+   1.835  do_timer+0x14 (timer_interrupt+0x154)
:|   *fn                   78+   1.140  profile_tick+0x14 (timer_interrupt+0x130)
:|   *fn                   79+   1.275  profile_hit+0x14 (profile_tick+0x78)
:|   *fn                   80+   1.195  update_process_times+0x14 (timer_interrupt+0x13c)
:|   *fn                   81+   1.400  account_system_time+0x14 (update_process_times+0xac)
:|   *fn                   83+   1.120  update_mem_hiwater+0x14 (account_system_time+0x78)
:|   *fn                   84+   1.130  run_local_timers+0x14 (update_process_times+0xb0)
:|   *fn                   85+   1.160  raise_softirq+0x14 (run_local_timers+0x30)
:|   *fn                   86+   1.400  __ipipe_test_and_stall_root+0x14 (raise_softirq+0x30)
:|   *fn                   88    1.000  __ipipe_restore_root+0x14 (raise_softirq+0x84)
:|   *fn                   89+   1.875  __ipipe_stall_root+0x14 (__ipipe_restore_root+0x34)
:|   *fn                   90+   1.185  scheduler_tick+0x14 (update_process_times+0x7c)
:|   *fn                   92+   1.615  sched_clock+0x14 (scheduler_tick+0x34)
:|   *fn                   93+   1.085  run_posix_cpu_timers+0x14 (update_process_times+0x84)
:|   *fn                   94+   1.525  __ipipe_test_root+0x14 (run_posix_cpu_timers+0x44)
:|   *fn                   96+   1.795  do_timer+0x14 (timer_interrupt+0x154)
:|   *fn                   98+   1.320  profile_tick+0x14 (timer_interrupt+0x130)
:|   *fn                   99+   1.140  profile_hit+0x14 (profile_tick+0x78)
:|   *fn                  100+   1.130  update_process_times+0x14 (timer_interrupt+0x13c)
:|   *fn                  101+   1.370  account_system_time+0x14 (update_process_times+0xac)
:|   *fn                  103+   1.325  update_mem_hiwater+0x14 (account_system_time+0x78)
:|   *fn                  104    0.995  run_local_timers+0x14 (update_process_times+0xb0)
:|   *fn                  105+   1.140  raise_softirq+0x14 (run_local_timers+0x30)
:|   *fn                  106+   1.345  __ipipe_test_and_stall_root+0x14 (raise_softirq+0x30)
:|   *fn                  107+   1.160  __ipipe_restore_root+0x14 (raise_softirq+0x84)
:|   *fn                  108+   1.735  __ipipe_stall_root+0x14 (__ipipe_restore_root+0x34)
:|   *fn                  110+   1.160  scheduler_tick+0x14 (update_process_times+0x7c)
:|   *fn                  111+   1.565  sched_clock+0x14 (scheduler_tick+0x34)
:|   *fn                  113+   1.265  run_posix_cpu_timers+0x14 (update_process_times+0x84)
:|   *fn                  114+   1.390  __ipipe_test_root+0x14 (run_posix_cpu_timers+0x44)
:|   *fn                  116+   1.770  do_timer+0x14 (timer_interrupt+0x154)
:|   *fn                  117+   1.295  profile_tick+0x14 (timer_interrupt+0x130)
:|   *fn                  119+   1.340  profile_hit+0x14 (profile_tick+0x78)
:|   *fn                  120+   1.035  update_process_times+0x14 (timer_interrupt+0x13c)
:|   *fn                  121+   1.350  account_system_time+0x14 (update_process_times+0xac)
:|   *fn                  122+   1.275  update_mem_hiwater+0x14 (account_system_time+0x78)
:|   *fn                  124+   1.195  run_local_timers+0x14 (update_process_times+0xb0)
:|   *fn                  125    1.000  raise_softirq+0x14 (run_local_timers+0x30)
:|   *fn                  126+   1.325  __ipipe_test_and_stall_root+0x14 (raise_softirq+0x30)
:|   *fn                  127+   1.120  __ipipe_restore_root+0x14 (raise_softirq+0x84)
:|   *fn                  128+   1.920  __ipipe_stall_root+0x14 (__ipipe_restore_root+0x34)
:|   *fn                  130+   1.025  scheduler_tick+0x14 (update_process_times+0x7c)
:|   *fn                  131+   1.545  sched_clock+0x14 (scheduler_tick+0x34)
:|   *fn                  133+   1.245  run_posix_cpu_timers+0x14 (update_process_times+0x84)
:|   *fn                  134+   1.595  __ipipe_test_root+0x14 (run_posix_cpu_timers+0x44)
:|   *fn                  135+   1.635  do_timer+0x14 (timer_interrupt+0x154)
:|   *fn                  137+   1.275  profile_tick+0x14 (timer_interrupt+0x130)
:|   *fn                  138+   1.300  profile_hit+0x14 (profile_tick+0x78)
:|   *fn                  140+   1.235  update_process_times+0x14 (timer_interrupt+0x13c)
:|   *fn                  141+   1.210  account_system_time+0x14 (update_process_times+0xac)
:|   *fn                  142+   1.255  update_mem_hiwater+0x14 (account_system_time+0x78)
:|   *fn                  143+   1.135  run_local_timers+0x14 (update_process_times+0xb0)
:|   *fn                  144+   1.210  raise_softirq+0x14 (run_local_timers+0x30)
:|   *fn                  146+   1.190  __ipipe_test_and_stall_root+0x14 (raise_softirq+0x30)
:|   *fn                  147+   1.135  __ipipe_restore_root+0x14 (raise_softirq+0x84)
:|   *fn                  148+   1.900  __ipipe_stall_root+0x14 (__ipipe_restore_root+0x34)
:|   *fn                  150+   1.225  scheduler_tick+0x14 (update_process_times+0x7c)
:|   *fn                  151+   1.410  sched_clock+0x14 (scheduler_tick+0x34)
:|   *fn                  153+   1.220  run_posix_cpu_timers+0x14 (update_process_times+0x84)
:|   *fn                  154+   1.525  __ipipe_test_root+0x14 (run_posix_cpu_timers+0x44)
:|   *fn                  155+   1.830  do_timer+0x14 (timer_interrupt+0x154)
:|   *fn                  157+   1.135  profile_tick+0x14 (timer_interrupt+0x130)
:|   *fn                  158+   1.230  profile_hit+0x14 (profile_tick+0x78)
:|   *fn                  159+   1.165  update_process_times+0x14 (timer_interrupt+0x13c)
:|   *fn                  161+   1.370  account_system_time+0x14 (update_process_times+0xac)
:|   *fn                  162+   1.115  update_mem_hiwater+0x14 (account_system_time+0x78)
:|   *fn                  163+   1.090  run_local_timers+0x14 (update_process_times+0xb0)
:|   *fn                  164+   1.160  raise_softirq+0x14 (run_local_timers+0x30)
:|   *fn                  165+   1.400  __ipipe_test_and_stall_root+0x14 (raise_softirq+0x30)
:|   *fn                  167    1.000  __ipipe_restore_root+0x14 (raise_softirq+0x84)
:|   *fn                  168+   2.215  __ipipe_stall_root+0x14 (__ipipe_restore_root+0x34)
:|   *fn                  170+   1.185  scheduler_tick+0x14 (update_process_times+0x7c)
:|   *fn                  171+   1.615  sched_clock+0x14 (scheduler_tick+0x34)
:|   *fn                  173+   1.085  run_posix_cpu_timers+0x14 (update_process_times+0x84)
:|   *fn                  174+   1.525  __ipipe_test_root+0x14 (run_posix_cpu_timers+0x44)
:|   *fn                  175+   2.090  do_timer+0x14 (timer_interrupt+0x154)
:|   *fn                  177+   1.300  profile_tick+0x14 (timer_interrupt+0x130)
:|   *fn                  179+   1.135  profile_hit+0x14 (profile_tick+0x78)
:|   *fn                  180+   1.170  update_process_times+0x14 (timer_interrupt+0x13c)
:|   *fn                  181+   1.370  account_system_time+0x14 (update_process_times+0xac)
:|   *fn                  182+   1.325  update_mem_hiwater+0x14 (account_system_time+0x78)
:|   *fn                  184    0.995  run_local_timers+0x14 (update_process_times+0xb0)
:|   *fn                  185+   1.140  raise_softirq+0x14 (run_local_timers+0x30)
:|   *fn                  186+   1.350  __ipipe_test_and_stall_root+0x14 (raise_softirq+0x30)
:|   *fn                  187+   1.205  __ipipe_restore_root+0x14 (raise_softirq+0x84)
:|   *fn                  188+   1.735  __ipipe_stall_root+0x14 (__ipipe_restore_root+0x34)
:|   *fn                  190+   1.140  scheduler_tick+0x14 (update_process_times+0x7c)
:|   *fn                  191+   1.565  sched_clock+0x14 (scheduler_tick+0x34)
:|   *fn                  193+   1.285  run_posix_cpu_timers+0x14 (update_process_times+0x84)
:|   *fn                  194+   1.390  __ipipe_test_root+0x14 (run_posix_cpu_timers+0x44)
:|   *fn                  195+   1.770  do_timer+0x14 (timer_interrupt+0x154)
:|   *fn                  197+   1.295  profile_tick+0x14 (timer_interrupt+0x130)
:|   *fn                  198+   1.340  profile_hit+0x14 (profile_tick+0x78)
:|   *fn                  200+   1.035  update_process_times+0x14 (timer_interrupt+0x13c)
:|   *fn                  201+   1.350  account_system_time+0x14 (update_process_times+0xac)
:|   *fn                  202+   1.275  update_mem_hiwater+0x14 (account_system_time+0x78)
:|   *fn                  203+   1.195  run_local_timers+0x14 (update_process_times+0xb0)
:|   *fn                  205    1.000  raise_softirq+0x14 (run_local_timers+0x30)
:|   *fn                  206+   1.310  __ipipe_test_and_stall_root+0x14 (raise_softirq+0x30)
:|   *fn                  207+   1.155  __ipipe_restore_root+0x14 (raise_softirq+0x84)
:|   *fn                  208+   1.940  __ipipe_stall_root+0x14 (__ipipe_restore_root+0x34)
:|   *fn                  210+   1.025  scheduler_tick+0x14 (update_process_times+0x7c)
:|   *fn                  211+   1.525  sched_clock+0x14 (scheduler_tick+0x34)
:|   *fn                  213+   1.245  run_posix_cpu_timers+0x14 (update_process_times+0x84)
:|   *fn                  214+   1.590  __ipipe_test_root+0x14 (run_posix_cpu_timers+0x44)
:|   *fn                  215+   1.630  do_timer+0x14 (timer_interrupt+0x154)
:|   *fn                  217+   1.235  profile_tick+0x14 (timer_interrupt+0x130)
:|   *fn                  218+   1.300  profile_hit+0x14 (profile_tick+0x78)
:|   *fn                  219+   1.235  update_process_times+0x14 (timer_interrupt+0x13c)
:|   *fn                  221+   1.360  account_system_time+0x14 (update_process_times+0xac)
:|   *fn                  222+   1.215  update_mem_hiwater+0x14 (account_system_time+0x78)
:|   *fn                  223+   1.155  run_local_timers+0x14 (update_process_times+0xb0)
:|   *fn                  224+   1.205  raise_softirq+0x14 (run_local_timers+0x30)
:|   *fn                  226+   1.195  __ipipe_test_and_stall_root+0x14 (raise_softirq+0x30)
:|   *fn                  227+   1.090  __ipipe_restore_root+0x14 (raise_softirq+0x84)
:|   *fn                  228+   1.855  __ipipe_stall_root+0x14 (__ipipe_restore_root+0x34)
:|   *fn                  230+   1.220  scheduler_tick+0x14 (update_process_times+0x7c)
:|   *fn                  231+   1.405  sched_clock+0x14 (scheduler_tick+0x34)
:|   *fn                  232+   1.180  run_posix_cpu_timers+0x14 (update_process_times+0x84)
:|   *fn                  234+   1.545  __ipipe_test_root+0x14 (run_posix_cpu_timers+0x44)
:|   *fn                  235+   1.835  do_timer+0x14 (timer_interrupt+0x154)
:|   *fn                  237+   1.140  profile_tick+0x14 (timer_interrupt+0x130)
:|   *fn                  238+   1.255  profile_hit+0x14 (profile_tick+0x78)
:|   *fn                  239+   1.195  update_process_times+0x14 (timer_interrupt+0x13c)
:|   *fn                  240+   1.420  account_system_time+0x14 (update_process_times+0xac)
:|   *fn                  242+   1.120  update_mem_hiwater+0x14 (account_system_time+0x78)
:|   *fn                  243+   1.130  run_local_timers+0x14 (update_process_times+0xb0)
:|   *fn                  244+   1.155  raise_softirq+0x14 (run_local_timers+0x30)
:|   *fn                  245+   1.350  __ipipe_test_and_stall_root+0x14 (raise_softirq+0x30)
:|   *fn                  247    0.995  __ipipe_restore_root+0x14 (raise_softirq+0x84)
:|   *fn                  248+   1.835  __ipipe_stall_root+0x14 (__ipipe_restore_root+0x34)
:|   *fn                  249+   1.185  scheduler_tick+0x14 (update_process_times+0x7c)
:|   *fn                  251+   1.615  sched_clock+0x14 (scheduler_tick+0x34)
:|   *fn                  252+   1.085  run_posix_cpu_timers+0x14 (update_process_times+0x84)
:|   *fn                  253+   1.670  __ipipe_test_root+0x14 (run_posix_cpu_timers+0x44)
:|   *fn                  255+   2.260  do_timer+0x14 (timer_interrupt+0x154)
:|   *fn                  257+   1.920  irq_exit+0x14 (timer_interrupt+0xa4)
:|   *fn                  259+   1.240  do_softirq+0x14 (irq_exit+0x6c)
:|   *fn                  260+   1.660  __ipipe_test_and_stall_root+0x14 (do_softirq+0x54)
:|   *fn                  262+   1.810  __do_softirq+0x14 (do_softirq+0x90)
:|   *fn                  264+   1.565  __ipipe_unstall_root+0x14 (__do_softirq+0x64)
<|    end    0x80000000   265    1.795  __ipipe_unstall_root+0x70 (__do_softirq+0x64)
      fn                  267    1.755  run_timer_softirq+0x14 (__do_softirq+0x90)
      fn                  269    1.310  __ipipe_stall_root+0x14 (run_timer_softirq+0x50)
 |   *begin  0x80000000   270    0.000  __ipipe_stall_root+0x98 (run_timer_softirq+0x50)
bash-3.00#
bash-3.00#
bash-3.00#


--------------050108000006070506040607--

