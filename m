Message-ID: <504EC598.7050005@ebus.com>
Date: Mon, 10 Sep 2012 22:01:12 -0700
From: Doug Brunner <dbrunner@ebus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: [Xenomai] Interpreting I-pipe trace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

While running my latency testing earlier I saw some rather high =

worst-case latencies (~70us) compared to average case (~14us), so I ran =

again with I-pipe tracing enabled. However, I'm not sure what to make of =

the results.

My worst case involves an IRQ (common_interrupt appears in the trace =

with user value 0xFFFFFFC4) and the wiki page talks about being able to =

translate the user value 0xFFFFFFF4 into IRQ 11 but doesn't elaborate on =

how this correspondence works. I'm not horribly concerned since it's a =

delay of 53 us on a rather slow processor (Geode LX800) but it would be =

nice to know what interrupt is taking so long.

The trace is attached.

Thanks,

-- =

     Doug Brunner

-------------- next part --------------
I-pipe frozen back-tracing service on 3.2.21rtipc-ipipe-small-5-ipd/ipipe r=
elease #1
------------------------------------------------------------
CPU: 0, Freeze: 684744353683 cycles, Trace Points: 100 (+10)
Calibrated minimum trace-point overhead: 0.446 us

 +----- Hard IRQs ('|': locked)
 |+-- Xenomai
 ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||                          +---------- Delay flag ('+': > 1 us, '!': > 1=
0 us)
 |||                          |        +- NMI noise ('N')
 |||                          |        |
      Type    User Val.   Time    Delay  Function (Parent)
:|  + begin   0x80000001  -138+   1.922  __ipipe_syscall_root+0x95 (sysente=
r_past_esp+0x55)
:   + func                -136    0.706  __ipipe_syscall_root+0x9 (sysenter=
_past_esp+0x55)
:   + func                -135    0.612  __ipipe_notify_syscall+0x9 (__ipip=
e_syscall_root+0x2e)
:|  + begin   0x80000001  -135    0.526  __ipipe_notify_syscall+0x127 (__ip=
ipe_syscall_root+0x2e)
:|  + end     0x80000001  -134    0.702  __ipipe_notify_syscall+0xc9 (__ipi=
pe_syscall_root+0x2e)
:   + func                -134    0.698  ipipe_syscall_hook+0x4 (__ipipe_no=
tify_syscall+0x49)
:   + func                -133    0.914  hisyscall_event+0x9 (ipipe_syscall=
_hook+0x24)
:   + func                -132    0.520  __rt_task_wait_period+0x8 (hisysca=
ll_event+0x16a)
:   + func                -132    0.634  rt_task_wait_period+0x3 (__rt_task=
_wait_period+0x17)
:   + func                -131    0.594  xnpod_wait_thread_period+0x8 (rt_t=
ask_wait_period+0x37)
:|  + begin   0x80000000  -130    0.902  xnpod_wait_thread_period+0xec (rt_=
task_wait_period+0x37)
:|  # func                -129    0.732  xnpod_suspend_thread+0x9 (xnpod_wa=
it_thread_period+0x86)
:|  # func                -129    0.676  __xnpod_schedule+0x9 (xnpod_suspen=
d_thread+0x22e)
:|  # [ 1588] samplin 99  -128    0.628  __xnpod_schedule+0x6b (xnpod_suspe=
nd_thread+0x22e)
:|  # func                -127+   1.534  xnsched_pick_next+0x6 (__xnpod_sch=
edule+0xcc)
:|  # [    0] -<?>-   -1  -126    0.872  __xnpod_schedule+0x356 (xnintr_clo=
ck_handler+0xeb)
:|   +func                -125    0.744  __ipipe_do_sync_pipeline+0x4 (__ip=
ipe_dispatch_irq_fast+0x79)
:|   +end     0xffffffcf  -124    0.870  common_interrupt+0x40 (__ipipe_hal=
t_root+0x2d)
:    +func                -123    0.582  local_touch_nmi+0x3 (cpu_idle+0x35)
:    #func                -123    0.608  cpuidle_idle_call+0x9 (cpu_idle+0x=
42)
:    #func                -122    0.692  cpuidle_get_driver+0x3 (cpuidle_id=
le_call+0x19)
:    #func                -121    0.642  default_idle+0x8 (cpu_idle+0x4c)
:    #func                -121    0.562  __ipipe_halt_root+0x3 (default_idl=
e+0x55)
:|   #begin   0x80000000  -120    0.738  __ipipe_halt_root+0x3a (default_id=
le+0x55)
:|   +end     0x8000000e  -120!  53.132  __ipipe_halt_root+0x2b (default_id=
le+0x55)
:|   +begin   0xffffffcf   -66    0.838  common_interrupt+0x2f (__ipipe_hal=
t_root+0x2d)
:|   +func                 -66    0.574  __ipipe_handle_irq+0x5 (common_int=
errupt+0x36)
:|   +func                 -65    0.486  __ipipe_dispatch_irq+0x9 (__ipipe_=
handle_irq+0x31)
:|   +func                 -64    0.622  irq_to_desc+0x3 (__ipipe_dispatch_=
irq+0x10d)
:|   +func                 -64    0.662  irq_to_desc+0x3 (__ipipe_dispatch_=
irq+0x118)
:|   +func                 -63    0.518  __ipipe_ack_hrtimer_irq+0x6 (__ipi=
pe_dispatch_irq+0x56)
:|   +func                 -63    0.508  __ipipe_ack_level_irq+0x7 (__ipipe=
_ack_hrtimer_irq+0x1c)
:|   +func                 -62    0.494  mask_and_ack_8259A+0x8 (__ipipe_ac=
k_level_irq+0x1d)
:|   +func                 -62+   1.828  __ipipe_spin_lock_irqsave+0x6 (mas=
k_and_ack_8259A+0x23)
:|   #func                 -60    0.734  __ipipe_spin_unlock_irqrestore+0x6=
 (mask_and_ack_8259A+0xcf)
:|   +func                 -59    0.490  __ipipe_end_level_irq+0x3 (__ipipe=
_ack_hrtimer_irq+0x30)
:|   +func                 -59    0.494  enable_8259A_irq+0x3 (__ipipe_end_=
level_irq+0x10)
:|   +func                 -58    0.496  unmask_8259A_irq+0x7 (enable_8259A=
_irq+0xf)
:|   +func                 -58    0.554  __ipipe_spin_lock_irqsave+0x6 (unm=
ask_8259A_irq+0x22)
:|   #func                 -57    0.716  __ipipe_spin_unlock_irqrestore+0x6=
 (unmask_8259A_irq+0x63)
:|   +func                 -56    0.686  irq_to_desc+0x3 (__ipipe_dispatch_=
irq+0x61)
:|   +func                 -56    0.542  __ipipe_dispatch_irq_fast+0x9 (__i=
pipe_dispatch_irq+0xa0)
:|  # func                 -55    0.794  xnintr_clock_handler+0x4 (__ipipe_=
dispatch_irq_fast+0x5f)
:|  # func                 -54    0.880  xntimer_tick_aperiodic+0x9 (xnintr=
_clock_handler+0x61)
:|  # func                 -53    0.632  xnthread_periodic_handler+0x3 (xnt=
imer_tick_aperiodic+0x21e)
:|  # func                 -53    0.654  xnpod_resume_thread+0x9 (xnthread_=
periodic_handler+0x22)
:|  # [ 1588] samplin 99   -52+   1.132  xnpod_resume_thread+0x4f (xnthread=
_periodic_handler+0x22)
:|  # func                 -51    0.622  xntimer_next_local_shot+0x9 (xntim=
er_tick_aperiodic+0x63)
:|  # event   tick@-44     -50    0.732  xntimer_next_local_shot+0x7d (xnti=
mer_tick_aperiodic+0x63)
:|  # func                 -50    0.664  ipipe_timer_set+0x4 (xntimer_next_=
local_shot+0xb2)
:|  # func                 -49+   3.302  pit_next_event+0x3 (ipipe_timer_se=
t+0x1a)
:|  # func                 -46    0.584  __xnpod_schedule+0x9 (xnintr_clock=
_handler+0xeb)
:|  # [    0] -<?>-   -1   -45    0.638  __xnpod_schedule+0x6b (xnintr_cloc=
k_handler+0xeb)
:|  # func                 -45+   1.826  xnsched_pick_next+0x6 (__xnpod_sch=
edule+0xcc)
:|  # [ 1588] samplin 99   -43+   1.028  __xnpod_schedule+0x356 (xnpod_susp=
end_thread+0x22e)
:|  # func                 -42    0.670  xntimer_get_overruns+0x9 (xnpod_wa=
it_thread_period+0xac)
:|  # func                 -41    0.604  __ipipe_restore_head+0x6 (xnpod_wa=
it_thread_period+0xd8)
:|  + end     0x80000000   -40    0.980  __ipipe_restore_head+0x4b (xnpod_w=
ait_thread_period+0xd8)
:|  + begin   0x80000001   -39    0.932  __ipipe_notify_syscall+0xdc (__ipi=
pe_syscall_root+0x2e)
:|  + end     0x80000001   -38+   2.364  __ipipe_notify_syscall+0xf8 (__ipi=
pe_syscall_root+0x2e)
:|  + begin   0xffffffcf   -36    0.784  common_interrupt+0x2f (__ipipe_not=
ify_syscall+0xff)
:|  + func                 -35    0.688  __ipipe_handle_irq+0x5 (common_int=
errupt+0x36)
:|  + func                 -35    0.600  __ipipe_dispatch_irq+0x9 (__ipipe_=
handle_irq+0x31)
:|  + func                 -34    0.638  irq_to_desc+0x3 (__ipipe_dispatch_=
irq+0x10d)
:|  + func                 -33    0.764  irq_to_desc+0x3 (__ipipe_dispatch_=
irq+0x118)
:|  + func                 -33    0.634  __ipipe_ack_hrtimer_irq+0x6 (__ipi=
pe_dispatch_irq+0x56)
:|  + func                 -32    0.616  __ipipe_ack_level_irq+0x7 (__ipipe=
_ack_hrtimer_irq+0x1c)
:|  + func                 -31    0.516  mask_and_ack_8259A+0x8 (__ipipe_ac=
k_level_irq+0x1d)
:|  + func                 -31+   1.944  __ipipe_spin_lock_irqsave+0x6 (mas=
k_and_ack_8259A+0x23)
:|  # func                 -29    0.774  __ipipe_spin_unlock_irqrestore+0x6=
 (mask_and_ack_8259A+0xcf)
:|  + func                 -28    0.626  __ipipe_end_level_irq+0x3 (__ipipe=
_ack_hrtimer_irq+0x30)
:|  + func                 -28    0.510  enable_8259A_irq+0x3 (__ipipe_end_=
level_irq+0x10)
:|  + func                 -27    0.596  unmask_8259A_irq+0x7 (enable_8259A=
_irq+0xf)
:|  + func                 -26    0.658  __ipipe_spin_lock_irqsave+0x6 (unm=
ask_8259A_irq+0x22)
:|  # func                 -26    0.754  __ipipe_spin_unlock_irqrestore+0x6=
 (unmask_8259A_irq+0x63)
:|  + func                 -25    0.700  irq_to_desc+0x3 (__ipipe_dispatch_=
irq+0x61)
:|  + func                 -24    0.646  __ipipe_dispatch_irq_fast+0x9 (__i=
pipe_dispatch_irq+0xa0)
:|  # func                 -24    0.802  xnintr_clock_handler+0x4 (__ipipe_=
dispatch_irq_fast+0x5f)
:|  # func                 -23+   1.130  xntimer_tick_aperiodic+0x9 (xnintr=
_clock_handler+0x61)
:|  # func                 -22+   1.102  xnsched_watchdog_handler+0x7 (xnti=
mer_tick_aperiodic+0x21e)
:|  # func                 -21    0.718  xntimer_next_local_shot+0x9 (xntim=
er_tick_aperiodic+0x63)
:|  # event   tick@24      -20    0.746  xntimer_next_local_shot+0x7d (xnti=
mer_tick_aperiodic+0x63)
:|  # func                 -19    0.658  ipipe_timer_set+0x4 (xntimer_next_=
local_shot+0xb2)
:|  # func                 -18+   3.530  pit_next_event+0x3 (ipipe_timer_se=
t+0x1a)
:|  + end     0xffffffcf   -15    0.872  common_interrupt+0x40 (__ipipe_not=
ify_syscall+0xff)
:|  + begin   0x80000001   -14+   3.120  __ipipe_syscall_root+0x95 (sysente=
r_past_esp+0x55)
:   + func                 -11    0.736  __ipipe_syscall_root+0x9 (sysenter=
_past_esp+0x55)
:   + func                 -10    0.498  __ipipe_notify_syscall+0x9 (__ipip=
e_syscall_root+0x2e)
:|  + begin   0x80000001   -10    0.618  __ipipe_notify_syscall+0x127 (__ip=
ipe_syscall_root+0x2e)
:|  + end     0x80000001    -9    0.706  __ipipe_notify_syscall+0xc9 (__ipi=
pe_syscall_root+0x2e)
:   + func                  -8    0.748  ipipe_syscall_hook+0x4 (__ipipe_no=
tify_syscall+0x49)
:   + func                  -8+   1.210  hisyscall_event+0x9 (ipipe_syscall=
_hook+0x24)
:   + func                  -6+   1.296  xnshadow_sys_trace+0x6 (hisyscall_=
event+0x16a)
:   + func                  -5    0.706  ipipe_trace_frozen_reset+0x4 (xnsh=
adow_sys_trace+0xcb)
:   + func                  -4    0.614  __ipipe_global_path_lock+0x7 (ipip=
e_trace_frozen_reset+0xe)
:   + func                  -4    0.512  __ipipe_spin_lock_irqsave+0x6 (__i=
pipe_global_path_lock+0x16)
:|  + begin   0x80000001    -3+   2.214  __ipipe_spin_lock_irqsave+0x47 (__=
ipipe_global_path_lock+0x16)
:|  # func                  -1    0.698  __ipipe_spin_unlock_irqcomplete+0x=
6 (__ipipe_global_path_unlock+0x61)
:|  + end     0x80000001     0    0.920  __ipipe_spin_unlock_irqcomplete+0x=
36 (__ipipe_global_path_unlock+0x61)
<   + freeze  0x0000d5ef     0    0.812  xnshadow_sys_trace+0xbf (hisyscall=
_event+0x16a)
 |  + begin   0x80000001     0    0.738  __ipipe_notify_syscall+0xdc (__ipi=
pe_syscall_root+0x2e)
 |  + end     0x80000001     1    0.702  __ipipe_notify_syscall+0xf8 (__ipi=
pe_syscall_root+0x2e)
 |  + begin   0x80000001     2    1.514  __ipipe_syscall_root+0x95 (sysente=
r_past_esp+0x55)
    + func                   3    0.638  __ipipe_syscall_root+0x9 (sysenter=
_past_esp+0x55)
    + func                   4    0.512  __ipipe_notify_syscall+0x9 (__ipip=
e_syscall_root+0x2e)
 |  + begin   0x80000001     4    0.658  __ipipe_notify_syscall+0x127 (__ip=
ipe_syscall_root+0x2e)
 |  + end     0x80000001     5    0.686  __ipipe_notify_syscall+0xc9 (__ipi=
pe_syscall_root+0x2e)
    + func                   6    0.580  ipipe_syscall_hook+0x4 (__ipipe_no=
tify_syscall+0x49)
    + func                   6    0.902  hisyscall_event+0x9 (ipipe_syscall=
_hook+0x24)
    + func                   7    0.000  __rt_task_wait_period+0x8 (hisysca=
ll_event+0x16a)
