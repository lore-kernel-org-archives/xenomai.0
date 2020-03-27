Subject: =?UTF-8?Q?Re=3a_Hello=ef=bc=8cEveryone=ef=bc=81when_I_using_I-pipe_?=
 =?UTF-8?Q?trace=ef=bc=8c_I_have_some_problems_about_it=ef=bc=8cPlease_give_?=
 =?UTF-8?Q?me_some_suggestions=e3=80=82In_addition=2c_how_is_the_frozen_tool?=
 =?UTF-8?Q?_used=3f_Why_does_the_data_obtained_by_cat_frozen_not_change_when?=
 =?UTF-8?Q?_I_run_the_intensity_demo=3f?=
References: <fa4c5ace-5702-4f17-b6e9-7c13fa059bd7@BGY-SDEX05.countrygarden.com.cn>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <ec884898-f272-ebb4-79f5-06276ccd6734@web.de>
Date: Fri, 27 Mar 2020 10:07:18 +0100
MIME-Version: 1.0
In-Reply-To: <fa4c5ace-5702-4f17-b6e9-7c13fa059bd7@BGY-SDEX05.countrygarden.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: songqianyu <songqianyu@countrygarden.com.cn>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 25.03.20 10:06, songqianyu via Xenomai wrote:
> When I use the max tool, the maximum value of cat is always in the funct=
ion ipipe_test_root + 0x0. I don't think the demo on the wiki website is l=
ike this. What's the matter?
>
> 1=E3=80=81              Type    User Val.   Time    Delay  Function (Par=
ent)
>
> 2=E3=80=81             #func                  -1    0.098  ipipe_unstall=
_root+0x0 (ipipe_restore_root+0x1c)
>
> 3=E3=80=81           | #begin   0x80000000    -1    0.109  ipipe_unstall=
_root+0x51 (ipipe_restore_root+0x1c)
>
> 4=E3=80=81           | #func                   0    0.147  ipipe_root_on=
ly+0x0 (ipipe_unstall_root+0x16)
>
> 5=E3=80=81           | +end     0x80000000     0    0.107  ipipe_trace_e=
nd+0x14 (ipipe_unstall_root+0x42)
>
> 6=E3=80=81             +func                   0    0.122  mutex_unlock+=
0x0 (n_tty_read+0x2fb)
>
> 7=E3=80=81             +func                   0    0.107  tty_ldisc_der=
ef+0x0 (tty_read+0xa4)
>
> 8=E3=80=81             +func                   0    0.108  ldsem_up_read=
+0x0 (tty_ldisc_deref+0x16)
>
> 9=E3=80=81             +func                   0    0.110  ktime_get_rea=
l_seconds+0x0 (tty_read+0xae)
>
> 10=E3=80=81          +func                   0    0.109  __fsnotify_pare=
nt+0x0 (vfs_read+0x10a)
>
> 11=E3=80=81          +func                   0    0.112  fsnotify+0x0 (v=
fs_read+0x123)
>
> 12=E3=80=81       >| +begin   0x80000000     0    0.460  do_syscall_64+0=
x2c7 (entry_SYSCALL_64_after_hwframe+0x49)
>
> 13=E3=80=81       :| +func                   0!  55.409  ipipe_test_root=
+0x0 (trace_hardirqs_on_virt_caller+0x79)
>
> 14=E3=80=81       :| +func                  55    0.127  __ipipe_handle_=
irq+0x0 (apic_timer_interrupt+0x12)
>
> 15=E3=80=81       :| +begin   0x00001103    55    0.136  <7f9e5eee38c4> =
(apic_timer_interrupt+0x12)
>

This pattern looks to me like we are missing an "interrupts enable"
("end") instrumentation.

What is your configuration, which versions are you using?

> 16=E3=80=81       :| +func                  56    0.116  __ipipe_dispatc=
h_irq+0x0 (__ipipe_handle_irq+0xa6)
>
> 17=E3=80=81       :| +func                  56    0.139  irq_to_desc+0x0=
 (__ipipe_dispatch_irq+0x35)
>
> 18=E3=80=81       :| +func                  56    0.144  __ipipe_ack_hrt=
imer_irq+0x0 (__ipipe_dispatch_irq+0x102)
>
> 19=E3=80=81       :| +func                  56    0.187  lapic_itimer_ac=
k+0x0 (__ipipe_ack_hrtimer_irq+0x5f)
>
> 20=E3=80=81       :| +func                  56    0.163  dispatch_irq_he=
ad+0x0 (__ipipe_dispatch_irq+0xb6)
>
> 21=E3=80=81       :|# func                  56    0.160  xnintr_core_clo=
ck_handler+0x0 (dispatch_irq_head+0x9d)
>
> 22=E3=80=81       :|# func                  57    0.134  xnlock_dbg_prep=
are_acquire+0x0 (xnintr_core_clock_handler+0x296)
>
> 23=E3=80=81       :|# func                  57    0.107  xnlock_dbg_acqu=
ired+0x0 (xnintr_core_clock_handler+0x2df)
>
> 24=E3=80=81       :|# func                  57    0.171  xnclock_tick+0x=
0 (xnintr_core_clock_handler+0xf1)
>
> 25=E3=80=81       :|# func                  57    0.107  cobalt_timer_ha=
ndler+0x0 (xnclock_tick+0xc5)
>
> 26=E3=80=81       :|# func                  57    0.106  cobalt_signal_s=
end_pid+0x0 (cobalt_timer_handler+0x2a)
>
> 27=E3=80=81       :|# func                  57    0.117  cobalt_thread_f=
ind+0x0 (cobalt_signal_send_pid+0x12)
>
> 28=E3=80=81       :|# func                  57    0.119  cobalt_signal_s=
end+0x0 (cobalt_signal_send_pid+0x24)
>
> 29=E3=80=81       :|# func                  57    0.125  xnsynch_wakeup_=
one_sleeper+0x0 (cobalt_signal_send+0xa6)
>
> 30=E3=80=81       :|# func                  58    0.139  xnthread_resume=
+0x0 (xnsynch_wakeup_one_sleeper+0xda)
>
> 31=E3=80=81       :|# [ 7092] alt-sam 99    58    0.178  xnthread_resume=
+0xa9 (xnsynch_wakeup_one_sleeper+0xda)
>
> 32=E3=80=81       :|# func                  58    0.117  xntimerq_insert=
+0x0 (xnclock_tick+0x21c)
>
> 33=E3=80=81       :|# func                  58    0.098  xnclock_core_lo=
cal_shot+0x0 (xnclock_tick+0x245)
>
> 34=E3=80=81       :|# event   tick@155      58    0.102  xnclock_core_lo=
cal_shot+0x67 (xnclock_tick+0x245)
>
> 35=E3=80=81       :|# func                  58    0.150  ipipe_timer_set=
+0x0 (xnclock_core_local_shot+0x6f)
>
> 36=E3=80=81       :|# func                  58    0.177  lapic_next_dead=
line+0x0 (ipipe_timer_set+0x79)
>
> 37=E3=80=81       :|# func                  59    0.127  xnlock_dbg_rele=
ase+0x0 (xnintr_core_clock_handler+0x110)
>
> 38=E3=80=81       :|# func                  59    0.157  ___xnsched_run+=
0x0 (xnintr_core_clock_handler+0x336)
>
> 39=E3=80=81       :|# func                  59    0.122  xnlock_dbg_prep=
are_acquire+0x0 (___xnsched_run+0x3fc)
>
> 40=E3=80=81       :|# func                  59    0.105  xnlock_dbg_acqu=
ired+0x0 (___xnsched_run+0x444)
>
> 41=E3=80=81       :|# [ 7053] bash    -1    59    0.105  ___xnsched_run+=
0xe3 (xnintr_core_clock_handler+0x336)
>
> 42=E3=80=81       :|# func                  59    0.109  xnsched_pick_ne=
xt+0x0 (___xnsched_run+0x124)
>
> 43=E3=80=81       :|# func                  59    0.135  __ipipe_notify_=
vm_preemption+0x0 (___xnsched_run+0x517)
>
> 44=E3=80=81       :|# func                  59    0.110  xnarch_leave_ro=
ot+0x0 (___xnsched_run+0x54c)
>
> 45=E3=80=81       :|# func                  59    0.109  xntimer_start+0=
x0 (___xnsched_run+0x56f)
>
> 46=E3=80=81       :|# func                  60    0.108  xnclock_core_ns=
_to_ticks+0x0 (xntimer_start+0x1b8)
>
> 47=E3=80=81       :|# func                  60    0.104  xntimer_enqueue=
_and_program+0x0 (xntimer_start+0xfe)
>
> 48=E3=80=81       :|# func                  60    0.110  xntimerq_insert=
+0x0 (xntimer_enqueue_and_program+0x18)
>
> 49=E3=80=81       :|# func                  60    0.132  xntimer_heading=
_p+0x0 (xntimer_enqueue_and_program+0x2d)
>
> 50=E3=80=81       :|# func                  60    0.115  xnarch_switch_t=
o+0x0 (___xnsched_run+0x1da)
>
> 51=E3=80=81       :|# func                  60    0.158  switch_mm_irqs_=
off+0x0 (xnarch_switch_to+0x2f)
>
> 52=E3=80=81       :|# func                  60    0.445  load_new_mm_cr3=
+0x0 (switch_mm_irqs_off+0x326)
>
> 53=E3=80=81       :|# func                  61    0.145  xnthread_switch=
_fpu+0x0 (___xnsched_run+0x22d)
>
> 54=E3=80=81       :|# func                  61    0.095  xnarch_switch_f=
pu+0x0 (xnthread_switch_fpu+0x2d)
>
> 55=E3=80=81       :|# [ 7092] alt-sam 99    61    0.225  ___xnsched_run+=
0x24d (xnthread_suspend+0x497)
>
> 56=E3=80=81       :|# func                  61    0.111  cobalt_timer_de=
liver+0x0 (signal_wait+0x556)
>
> 57=E3=80=81       :|# func                  61    0.106  xntimer_get_ove=
rruns+0x0 (cobalt_timer_deliver+0x6d)
>
> 58=E3=80=81       :|# func                  61    0.110  xnclock_core_ns=
_to_ticks+0x0 (xntimer_get_overruns+0x35)
>
> 59=E3=80=81       :|# func                  62    0.128  xnlock_dbg_rele=
ase+0x0 (signal_wait+0x528)
>
> 60=E3=80=81       :|# func                  62    0.110  __ipipe_restore=
_head+0x0 (signal_wait+0x294)
>
> 61=E3=80=81       <|+ end     0x80000000    62    0.278  ipipe_trace_end=
+0x14 (__ipipe_restore_head+0x5b)
>
> 62=E3=80=81        |+ begin   0x80000000    62    0.000  do_syscall_64+0=
x71 (entry_SYSCALL_64_after_hwframe+0x49)
>
>
>
> In addition, how is the frozen tool used? Why does the data obtained by =
cat frozen not change when I run the intensity demo?
> I-pipe frozen back-tracing service on 4.19.84-bros-debug/ipipe release #=
8
> ------------------------------------------------------------
> CPU: 0, Freeze: 245367883938480 cycles, Trace Points: 30 (+10)
> Calibrated minimum trace-point overhead: 0.064 us
>
> +----- Hard IRQs ('|': locked)
> |+-- Xenomai
> ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
> |||                        +---------- Delay flag ('+': > 1 us, '!': > 1=
0 us)
> |||                        |        +- NMI noise ('N')
> |||                        |        |
>      Type    User Val.   Time    Delay  Function (Parent)
> :  +func                  -5    0.120  vfs_write+0x0 (ksys_write+0x5c)
> :  +func                  -5    0.134  rw_verify_area+0x0 (vfs_write+0x7=
7)
> :  +func                  -5    0.163  security_file_permission+0x0 (rw_=
verify_area+0x4e)
> :  +func                  -5    0.110  apparmor_file_permission+0x0 (sec=
urity_file_permission+0x3b)
> :  +func                  -5    0.136  common_file_perm+0x0 (apparmor_fi=
le_permission+0x1a)
> :  +func                  -4    0.160  aa_file_perm+0x0 (common_file_per=
m+0x4d)
> :  +func                  -4    0.105  __sb_start_write+0x0 (vfs_write+0=
x195)
> :  +func                  -4    0.099  ipipe_root_only+0x0 (__sb_start_w=
rite+0x3f)
> :| +begin   0x80000001    -4    0.119  ipipe_root_only+0x79 (__sb_start_=
write+0x3f)
> :| +end     0x80000001    -4    0.113  ipipe_trace_end+0x14 (ipipe_root_=
only+0x63)
> :  +func                  -4    0.106  _cond_resched+0x0 (__sb_start_wri=
te+0x44)
> :  +func                  -4    0.107  rcu_all_qs+0x0 (_cond_resched+0x1=
9)
> :  +func                  -4    0.138  __vfs_write+0x0 (vfs_write+0xb8)
> :  +func                  -3    0.183  proc_reg_write+0x0 (__vfs_write+0=
x3a)
> :  +func                  -3    0.121  __ipipe_frozen_ctrl+0x0 (proc_reg=
_write+0x45)
> :  +func                  -3    0.108  __check_object_size+0x0 (__ipipe_=
frozen_ctrl+0x42)
> :  +func                  -3    0.614  check_stack_object+0x0 (__check_o=
bject_size+0x45)
> :  +func                  -2    0.115  mutex_lock+0x0 (__ipipe_frozen_ct=
rl+0x92)
> :  +func                  -2    0.100  ipipe_root_only+0x0 (mutex_lock+0=
x12)
> :| +begin   0x80000001    -2    0.134  ipipe_root_only+0x79 (mutex_lock+=
0x12)
> :| +end     0x80000001    -2    0.122  ipipe_trace_end+0x14 (ipipe_root_=
only+0x63)
> :  +func                  -2    0.117  _cond_resched+0x0 (mutex_lock+0x1=
7)
> :  +func                  -2    0.133  rcu_all_qs+0x0 (_cond_resched+0x1=
9)
> :  +func                  -2    0.110  ipipe_trace_frozen_reset+0x0 (__i=
pipe_frozen_ctrl+0x97)
> :  +func                  -2    0.104  __ipipe_global_path_lock+0x0 (ipi=
pe_trace_frozen_reset+0x21)
> :  +func                  -2    0.110  __ipipe_spin_lock_irqsave+0x0 (__=
ipipe_global_path_lock+0x15)
> :| +begin   0x80000001    -1+   1.644  __ipipe_spin_lock_irqsave+0x72 (_=
_ipipe_global_path_lock+0x15)
> :| #func                   0    0.151  __ipipe_spin_unlock_irqcomplete+0=
x0 (__ipipe_global_path_unlock+0x73)
> :| +end     0x80000001     0    0.113  ipipe_trace_end+0x14 (__ipipe_spi=
n_unlock_irqcomplete+0x37)
> <  +freeze  0xffffffffffffffff     0    0.139  proc_reg_write+0x45 (__vf=
s_write+0x3a)
>     +func                   0    0.122  mutex_unlock+0x0 (__ipipe_frozen=
_ctrl+0xb1)
>     +func                   0    0.110  unuse_pde+0x0 (proc_reg_write+0x=
50)
>     +func                   0    0.110  __fsnotify_parent+0x0 (vfs_write=
+0x141)
>     +func                   0    0.127  fsnotify+0x0 (vfs_write+0x15a)
>     +func                   0    0.115  __sb_end_write+0x0 (vfs_write+0x=
16e)
> | +begin   0x80000000     0    0.483  do_syscall_64+0x2c7 (entry_SYSCALL=
_64_after_hwframe+0x49)
> | +func                   1    1.109  ipipe_test_root+0x0 (trace_hardirq=
s_on_virt_caller+0x79)
> | +func                   2    0.139  do_syscall_64+0x0 (entry_SYSCALL_6=
4_after_hwframe+0x49)
> | +end     0x80000000     2    0.113  ipipe_trace_end+0x14 (do_syscall_6=
4+0x7d)
>     +func                   2    0.000  ipipe_handle_syscall+0x0 (do_sys=
call_64+0x46)
> Can you tell me what the information reflects?

Did you study
https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Using_The_I_Pipe_Tracer
already?

Jan

