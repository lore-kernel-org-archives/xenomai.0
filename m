MIME-Version: 1.0
From: songqianyu <songqianyu@countrygarden.com.cn>
Subject: =?utf-8?Q?=E5=9B=9E=E5=A4=8D:_Xenomai_Digest,_Vol_95,_Issue_29?=
Date: Mon, 30 Mar 2020 19:44:12 +0800
In-Reply-To: <mailman.72.1585300052.1004.xenomai@xenomai.org>
References: <mailman.72.1585300052.1004.xenomai@xenomai.org>
Message-ID: <ca8f2c7f-b58d-4754-840e-abf24dcc3f9b@BGY-SDEX05.countrygarden.com.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I do this test by : first run altency and cyclictest xenomai examples, the =
second echo 1 > enable , echo 1 > max, cat max;  or  echo 1 > frozen, then =
cat frozen, if have problem, please tell me which is the right steps for me=
 to do these test? Thank you.

=E5=8F=91=E9=80=81=E8=87=AA Windows 10 =E7=89=88=E9=82=AE=E4=BB=B6<https://=
go.microsoft.com/fwlink/?LinkId=3D550986>=E5=BA=94=E7=94=A8

=E5=8F=91=E4=BB=B6=E4=BA=BA: xenomai-request@xenomai.org<mailto:xenomai-req=
uest@xenomai.org>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2020=E5=B9=B43=E6=9C=8827=E6=97=A5 17=
:07
=E6=94=B6=E4=BB=B6=E4=BA=BA: xenomai@xenomai.org<mailto:xenomai@xenomai.org=
>
=E4=B8=BB=E9=A2=98: Xenomai Digest, Vol 95, Issue 29

Send Xenomai mailing list submissions to
       xenomai@xenomai.org

To subscribe or unsubscribe via the World Wide Web, visit
       https://xenomai.org/mailman/listinfo/xenomai
or, via email, send a message with subject or body 'help' to
       xenomai-request@xenomai.org

You can reach the person managing the list at
       xenomai-owner@xenomai.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Xenomai digest..."


Today's Topics:

   1. RE: Hello=EF=BC=8CEveryone=EF=BC=81when I using I-pipe trace=EF=BC=8C=
 I have
      some problems about it=EF=BC=8CPlease give me some suggestions=E3=80=
=82In
      addition, how is the frozen tool used? Why does the data obtained
      by cat frozen not change when I run the intensity demo? (Meng, Fino)
   2. Re: Directory /proc/xenomai/registry/rtipc/xddp does not
      exist (Jan Kiszka)
   3. Re: Hello=EF=BC=8CEveryone=EF=BC=81when I using I-pipe trace=EF=BC=8C=
 I have
      some problems about it=EF=BC=8CPlease give me some suggestions=E3=80=
=82In
      addition, how is the frozen tool used? Why does the data obtained
      by cat frozen not change when I run the intensity demo? (Jan Kiszka)


----------------------------------------------------------------------

Message: 1
Date: Fri, 27 Mar 2020 00:27:03 +0000
From: "Meng, Fino" <fino.meng@intel.com>
To: songqianyu <songqianyu@countrygarden.com.cn>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>
Subject: RE: Hello=EF=BC=8CEveryone=EF=BC=81when I using I-pipe trace=EF=BC=
=8C I have
       some problems about it=EF=BC=8CPlease give me some suggestions=E3=80=
=82In
       addition, how is the frozen tool used? Why does the data obtained by
       cat frozen not change when I run the intensity demo?
Message-ID: <f9f60fd4adf34e8d9987fa8c7e27b3fa@intel.com>
Content-Type: text/plain; charset=3D"utf-8"

Hello Qianyu,

Would you pls provide more details on the steps how did u do the test,
assume other people not familiar with what u doing and , can repeat your te=
st from your description easily,
thanks!

BR / Fino (=E5=AD=9F=E7=A5=A5=E5=A4=AB)
Intel =E2=80=93 IOTG Developer Enabling

-----Original Message-----
From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of songqianyu via Xen=
omai
Sent: Wednesday, March 25, 2020 5:07 PM
To: xenomai@xenomai.org
Subject: Hello=EF=BC=8CEveryone=EF=BC=81when I using I-pipe trace=EF=BC=8C =
I have some problems about it=EF=BC=8CPlease give me some suggestions=E3=80=
=82In addition, how is the frozen tool used? Why does the data obtained by =
cat frozen not change when I run the intensity demo?

When I use the max tool, the maximum value of cat is always in the function=
 ipipe_test_root + 0x0. I don't think the demo on the wiki website is like =
this. What's the matter?

1=E3=80=81              Type    User Val.   Time    Delay  Function (Parent=
)

2=E3=80=81             #func                  -1    0.098  ipipe_unstall_ro=
ot+0x0 (ipipe_restore_root+0x1c)

3=E3=80=81           | #begin   0x80000000    -1    0.109  ipipe_unstall_ro=
ot+0x51 (ipipe_restore_root+0x1c)

4=E3=80=81           | #func                   0    0.147  ipipe_root_only+=
0x0 (ipipe_unstall_root+0x16)

5=E3=80=81           | +end     0x80000000     0    0.107  ipipe_trace_end+=
0x14 (ipipe_unstall_root+0x42)

6=E3=80=81             +func                   0    0.122  mutex_unlock+0x0=
 (n_tty_read+0x2fb)

7=E3=80=81             +func                   0    0.107  tty_ldisc_deref+=
0x0 (tty_read+0xa4)

8=E3=80=81             +func                   0    0.108  ldsem_up_read+0x=
0 (tty_ldisc_deref+0x16)

9=E3=80=81             +func                   0    0.110  ktime_get_real_s=
econds+0x0 (tty_read+0xae)

10=E3=80=81          +func                   0    0.109  __fsnotify_parent+=
0x0 (vfs_read+0x10a)

11=E3=80=81          +func                   0    0.112  fsnotify+0x0 (vfs_=
read+0x123)

12=E3=80=81       >| +begin   0x80000000     0    0.460  do_syscall_64+0x2c=
7 (entry_SYSCALL_64_after_hwframe+0x49)

13=E3=80=81       :| +func                   0!  55.409  ipipe_test_root+0x=
0 (trace_hardirqs_on_virt_caller+0x79)

14=E3=80=81       :| +func                  55    0.127  __ipipe_handle_irq=
+0x0 (apic_timer_interrupt+0x12)

15=E3=80=81       :| +begin   0x00001103    55    0.136  <7f9e5eee38c4> (ap=
ic_timer_interrupt+0x12)

16=E3=80=81       :| +func                  56    0.116  __ipipe_dispatch_i=
rq+0x0 (__ipipe_handle_irq+0xa6)

17=E3=80=81       :| +func                  56    0.139  irq_to_desc+0x0 (_=
_ipipe_dispatch_irq+0x35)

18=E3=80=81       :| +func                  56    0.144  __ipipe_ack_hrtime=
r_irq+0x0 (__ipipe_dispatch_irq+0x102)

19=E3=80=81       :| +func                  56    0.187  lapic_itimer_ack+0=
x0 (__ipipe_ack_hrtimer_irq+0x5f)

20=E3=80=81       :| +func                  56    0.163  dispatch_irq_head+=
0x0 (__ipipe_dispatch_irq+0xb6)

21=E3=80=81       :|# func                  56    0.160  xnintr_core_clock_=
handler+0x0 (dispatch_irq_head+0x9d)

22=E3=80=81       :|# func                  57    0.134  xnlock_dbg_prepare=
_acquire+0x0 (xnintr_core_clock_handler+0x296)

23=E3=80=81       :|# func                  57    0.107  xnlock_dbg_acquire=
d+0x0 (xnintr_core_clock_handler+0x2df)

24=E3=80=81       :|# func                  57    0.171  xnclock_tick+0x0 (=
xnintr_core_clock_handler+0xf1)

25=E3=80=81       :|# func                  57    0.107  cobalt_timer_handl=
er+0x0 (xnclock_tick+0xc5)

26=E3=80=81       :|# func                  57    0.106  cobalt_signal_send=
_pid+0x0 (cobalt_timer_handler+0x2a)

27=E3=80=81       :|# func                  57    0.117  cobalt_thread_find=
+0x0 (cobalt_signal_send_pid+0x12)

28=E3=80=81       :|# func                  57    0.119  cobalt_signal_send=
+0x0 (cobalt_signal_send_pid+0x24)

29=E3=80=81       :|# func                  57    0.125  xnsynch_wakeup_one=
_sleeper+0x0 (cobalt_signal_send+0xa6)

30=E3=80=81       :|# func                  58    0.139  xnthread_resume+0x=
0 (xnsynch_wakeup_one_sleeper+0xda)

31=E3=80=81       :|# [ 7092] alt-sam 99    58    0.178  xnthread_resume+0x=
a9 (xnsynch_wakeup_one_sleeper+0xda)

32=E3=80=81       :|# func                  58    0.117  xntimerq_insert+0x=
0 (xnclock_tick+0x21c)

33=E3=80=81       :|# func                  58    0.098  xnclock_core_local=
_shot+0x0 (xnclock_tick+0x245)

34=E3=80=81       :|# event   tick@155      58    0.102  xnclock_core_local=
_shot+0x67 (xnclock_tick+0x245)

35=E3=80=81       :|# func                  58    0.150  ipipe_timer_set+0x=
0 (xnclock_core_local_shot+0x6f)

36=E3=80=81       :|# func                  58    0.177  lapic_next_deadlin=
e+0x0 (ipipe_timer_set+0x79)

37=E3=80=81       :|# func                  59    0.127  xnlock_dbg_release=
+0x0 (xnintr_core_clock_handler+0x110)

38=E3=80=81       :|# func                  59    0.157  ___xnsched_run+0x0=
 (xnintr_core_clock_handler+0x336)

39=E3=80=81       :|# func                  59    0.122  xnlock_dbg_prepare=
_acquire+0x0 (___xnsched_run+0x3fc)

40=E3=80=81       :|# func                  59    0.105  xnlock_dbg_acquire=
d+0x0 (___xnsched_run+0x444)

41=E3=80=81       :|# [ 7053] bash    -1    59    0.105  ___xnsched_run+0xe=
3 (xnintr_core_clock_handler+0x336)

42=E3=80=81       :|# func                  59    0.109  xnsched_pick_next+=
0x0 (___xnsched_run+0x124)

43=E3=80=81       :|# func                  59    0.135  __ipipe_notify_vm_=
preemption+0x0 (___xnsched_run+0x517)

44=E3=80=81       :|# func                  59    0.110  xnarch_leave_root+=
0x0 (___xnsched_run+0x54c)

45=E3=80=81       :|# func                  59    0.109  xntimer_start+0x0 =
(___xnsched_run+0x56f)

46=E3=80=81       :|# func                  60    0.108  xnclock_core_ns_to=
_ticks+0x0 (xntimer_start+0x1b8)

47=E3=80=81       :|# func                  60    0.104  xntimer_enqueue_an=
d_program+0x0 (xntimer_start+0xfe)

48=E3=80=81       :|# func                  60    0.110  xntimerq_insert+0x=
0 (xntimer_enqueue_and_program+0x18)

49=E3=80=81       :|# func                  60    0.132  xntimer_heading_p+=
0x0 (xntimer_enqueue_and_program+0x2d)

50=E3=80=81       :|# func                  60    0.115  xnarch_switch_to+0=
x0 (___xnsched_run+0x1da)

51=E3=80=81       :|# func                  60    0.158  switch_mm_irqs_off=
+0x0 (xnarch_switch_to+0x2f)

52=E3=80=81       :|# func                  60    0.445  load_new_mm_cr3+0x=
0 (switch_mm_irqs_off+0x326)

53=E3=80=81       :|# func                  61    0.145  xnthread_switch_fp=
u+0x0 (___xnsched_run+0x22d)

54=E3=80=81       :|# func                  61    0.095  xnarch_switch_fpu+=
0x0 (xnthread_switch_fpu+0x2d)

55=E3=80=81       :|# [ 7092] alt-sam 99    61    0.225  ___xnsched_run+0x2=
4d (xnthread_suspend+0x497)

56=E3=80=81       :|# func                  61    0.111  cobalt_timer_deliv=
er+0x0 (signal_wait+0x556)

57=E3=80=81       :|# func                  61    0.106  xntimer_get_overru=
ns+0x0 (cobalt_timer_deliver+0x6d)

58=E3=80=81       :|# func                  61    0.110  xnclock_core_ns_to=
_ticks+0x0 (xntimer_get_overruns+0x35)

59=E3=80=81       :|# func                  62    0.128  xnlock_dbg_release=
+0x0 (signal_wait+0x528)

60=E3=80=81       :|# func                  62    0.110  __ipipe_restore_he=
ad+0x0 (signal_wait+0x294)

61=E3=80=81       <|+ end     0x80000000    62    0.278  ipipe_trace_end+0x=
14 (__ipipe_restore_head+0x5b)

62=E3=80=81        |+ begin   0x80000000    62    0.000  do_syscall_64+0x71=
 (entry_SYSCALL_64_after_hwframe+0x49)



In addition, how is the frozen tool used? Why does the data obtained by cat=
 frozen not change when I run the intensity demo?
I-pipe frozen back-tracing service on 4.19.84-bros-debug/ipipe release #8
------------------------------------------------------------
CPU: 0, Freeze: 245367883938480 cycles, Trace Points: 30 (+10) Calibrated m=
inimum trace-point overhead: 0.064 us

+----- Hard IRQs ('|': locked)
|+-- Xenomai
||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
|||                        +---------- Delay flag ('+': > 1 us, '!': > 10 u=
s)
|||                        |        +- NMI noise ('N')
|||                        |        |
    Type    User Val.   Time    Delay  Function (Parent)
:  +func                  -5    0.120  vfs_write+0x0 (ksys_write+0x5c)
:  +func                  -5    0.134  rw_verify_area+0x0 (vfs_write+0x77)
:  +func                  -5    0.163  security_file_permission+0x0 (rw_ver=
ify_area+0x4e)
:  +func                  -5    0.110  apparmor_file_permission+0x0 (securi=
ty_file_permission+0x3b)
:  +func                  -5    0.136  common_file_perm+0x0 (apparmor_file_=
permission+0x1a)
:  +func                  -4    0.160  aa_file_perm+0x0 (common_file_perm+0=
x4d)
:  +func                  -4    0.105  __sb_start_write+0x0 (vfs_write+0x19=
5)
:  +func                  -4    0.099  ipipe_root_only+0x0 (__sb_start_writ=
e+0x3f)
:| +begin   0x80000001    -4    0.119  ipipe_root_only+0x79 (__sb_start_wri=
te+0x3f)
:| +end     0x80000001    -4    0.113  ipipe_trace_end+0x14 (ipipe_root_onl=
y+0x63)
:  +func                  -4    0.106  _cond_resched+0x0 (__sb_start_write+=
0x44)
:  +func                  -4    0.107  rcu_all_qs+0x0 (_cond_resched+0x19)
:  +func                  -4    0.138  __vfs_write+0x0 (vfs_write+0xb8)
:  +func                  -3    0.183  proc_reg_write+0x0 (__vfs_write+0x3a=
)
:  +func                  -3    0.121  __ipipe_frozen_ctrl+0x0 (proc_reg_wr=
ite+0x45)
:  +func                  -3    0.108  __check_object_size+0x0 (__ipipe_fro=
zen_ctrl+0x42)
:  +func                  -3    0.614  check_stack_object+0x0 (__check_obje=
ct_size+0x45)
:  +func                  -2    0.115  mutex_lock+0x0 (__ipipe_frozen_ctrl+=
0x92)
:  +func                  -2    0.100  ipipe_root_only+0x0 (mutex_lock+0x12=
)
:| +begin   0x80000001    -2    0.134  ipipe_root_only+0x79 (mutex_lock+0x1=
2)
:| +end     0x80000001    -2    0.122  ipipe_trace_end+0x14 (ipipe_root_onl=
y+0x63)
:  +func                  -2    0.117  _cond_resched+0x0 (mutex_lock+0x17)
:  +func                  -2    0.133  rcu_all_qs+0x0 (_cond_resched+0x19)
:  +func                  -2    0.110  ipipe_trace_frozen_reset+0x0 (__ipip=
e_frozen_ctrl+0x97)
:  +func                  -2    0.104  __ipipe_global_path_lock+0x0 (ipipe_=
trace_frozen_reset+0x21)
:  +func                  -2    0.110  __ipipe_spin_lock_irqsave+0x0 (__ipi=
pe_global_path_lock+0x15)
:| +begin   0x80000001    -1+   1.644  __ipipe_spin_lock_irqsave+0x72 (__ip=
ipe_global_path_lock+0x15)
:| #func                   0    0.151  __ipipe_spin_unlock_irqcomplete+0x0 =
(__ipipe_global_path_unlock+0x73)
:| +end     0x80000001     0    0.113  ipipe_trace_end+0x14 (__ipipe_spin_u=
nlock_irqcomplete+0x37)
<  +freeze  0xffffffffffffffff     0    0.139  proc_reg_write+0x45 (__vfs_w=
rite+0x3a)
   +func                   0    0.122  mutex_unlock+0x0 (__ipipe_frozen_ctr=
l+0xb1)
   +func                   0    0.110  unuse_pde+0x0 (proc_reg_write+0x50)
   +func                   0    0.110  __fsnotify_parent+0x0 (vfs_write+0x1=
41)
   +func                   0    0.127  fsnotify+0x0 (vfs_write+0x15a)
   +func                   0    0.115  __sb_end_write+0x0 (vfs_write+0x16e)
| +begin   0x80000000     0    0.483  do_syscall_64+0x2c7 (entry_SYSCALL_64=
_after_hwframe+0x49)
| +func                   1    1.109  ipipe_test_root+0x0 (trace_hardirqs_o=
n_virt_caller+0x79)
| +func                   2    0.139  do_syscall_64+0x0 (entry_SYSCALL_64_a=
fter_hwframe+0x49)
| +end     0x80000000     2    0.113  ipipe_trace_end+0x14 (do_syscall_64+0=
x7d)
   +func                   2    0.000  ipipe_handle_syscall+0x0 (do_syscall=
_64+0x46)
Can you tell me what the information reflects?
=E5=8F=91=E9=80=81=E8=87=AA Windows 10 =E7=89=88=E9=82=AE=E4=BB=B6<https://=
go.microsoft.com/fwlink/?LinkId=3D550986>=E5=BA=94=E7=94=A8

________________________________
This information may contain confidential and/or privileged material and is=
 only transmitted for the intended recipient. Any review, retransmission, c=
onversion to hard copy, copying, reproduction, circulation, publication, di=
ssemination or other use of, or taking of any action, or omission to take a=
ction, in reliance upon this information by persons or entities other than =
the intended recipient is prohibited. If you have received this message in =
error, please contact the sender and delete the material from any computer,=
 disk drive, diskette, or other storage device or media.
=E6=9C=AC=E4=BF=A1=E6=81=AF=E5=8F=AF=E8=83=BD=E5=8C=85=E6=8B=AC=E6=9F=90=E4=
=BA=9B=E4=BF=9D=E5=AF=86=E7=9A=84=E8=B3=87=E6=96=99=EF=BC=8C=E4=B8=A6=E4=B8=
=94=E5=8F=AA=E7=99=BC=E9=80=81=E7=B5=A6=E7=89=B9=E5=AE=9A=E7=9A=84=E6=94=B6=
=E4=BF=A1=E4=BA=BA=E3=80=82=E7=A6=81=E6=AD=A2=E9=99=A4=E7=89=B9=E5=AE=9A=E6=
=94=B6=E4=BF=A1=E4=BA=BA=E4=BB=A5=E5=A4=96=E7=9A=84=E5=85=B6=E4=BB=96=E4=BB=
=BB=E4=BD=95=E4=BA=BA=E5=A3=AB=E6=88=96=E6=A9=9F=E6=A7=8B=E9=96=B1=E8=AE=80=
=E3=80=81=E8=BD=89=E7=99=BC=E3=80=81=E5=88=97=E5=8D=B0=E3=80=81=E8=A4=87=E8=
=A3=BD=E3=80=81=E5=82=B3=E9=96=B1=E3=80=81=E5=87=BA=E7=89=88=E3=80=81=E6=95=
=A3=E6=92=AD=E6=88=96=E4=BB=A5=E5=85=B6=E5=AE=83=E6=96=B9=E5=BC=8F=E4=BD=BF=
=E7=94=A8=E6=9C=AC=E4=BF=A1=E6=81=AF=EF=BC=8C=E6=88=96=E4=BE=9D=E8=B3=B4=E6=
=9C=AC=E4=BF=A1=E6=81=AF=E4=BD=9C=E5=87=BA=E6=88=96=E4=B8=8D=E4=BD=9C=E5=87=
=BA=E4=BB=BB=E4=BD=95=E8=A1=8C=E7=82=BA=E3=80=82=E5=A6=82=E6=9E=9C=E9=96=A3=
=E4=B8=8B=E9=8C=AF=E8=AA=A4=E5=9C=B0=E6=94=B6=E5=88=B0=E6=9C=AC=E4=BF=A1=E6=
=81=AF=EF=BC=8C=E8=AB=8B=E8=81=AF=E7=B5=A1=E7=99=BC=E4=BF=A1=E4=BA=BA=E4=B8=
=A6=E5=BE=9E=E4=BB=BB=E4=BD=95=E9=9B=BB=E8=85=A6=E3=80=81=E7=A3=81=E7=89=87=
=E3=80=81=E7=A3=81=E7=A2=9F=E6=88=96=E5=85=B6=E5=AE=83=E5=AD=98=E5=84=B2=E8=
=A3=9D=E7=BD=AE=E6=88=96=E5=AA=92=E9=AB=94=E4=B8=AD=E5=88=AA=E9=99=A4=E6=9C=
=AC=E4=BF=A1=E6=81=AF=E3=80=82

------------------------------

Message: 2
Date: Fri, 27 Mar 2020 10:07:25 +0100
From: Jan Kiszka <jan.kiszka@web.de>
To: Jona Ostermann <Jona.Ostermann@janztec.com>, "xenomai@xenomai.org"
       <xenomai@xenomai.org>
Subject: Re: Directory /proc/xenomai/registry/rtipc/xddp does not
       exist
Message-ID: <4426b307-184f-0422-afe8-2d9d41625608@web.de>
Content-Type: text/plain; charset=3Dutf-8; format=3Dflowed

On 26.03.20 11:12, Jona Ostermann via Xenomai wrote:
> Hello,
>
> one of our customers hast he problem that he needs a registry link in the=
 directory /proc/xenomai/registry/rtipc/xddp.
> But the directory does not exist, only /proc/xenomai/registry/ exists.
>
> What could be the problem?
> Is a special kernel configuration required or does a special kernel modul=
e need to be loaded?
>

The links show up once xddp is being used. You can check that via
smokey's xddp test.

If that is not the case, compare configuration and versions of the
reference xenomai-images against your setup and share your findings.

Jan



------------------------------

Message: 3
Date: Fri, 27 Mar 2020 10:07:18 +0100
From: Jan Kiszka <jan.kiszka@web.de>
To: songqianyu <songqianyu@countrygarden.com.cn>,
       "xenomai@xenomai.org" <xenomai@xenomai.org>
Subject: Re: Hello=EF=BC=8CEveryone=EF=BC=81when I using I-pipe trace=EF=BC=
=8C I have
       some problems about it=EF=BC=8CPlease give me some suggestions=E3=80=
=82In
       addition, how is the frozen tool used? Why does the data obtained by
       cat frozen not change when I run the intensity demo?
Message-ID: <ec884898-f272-ebb4-79f5-06276ccd6734@web.de>
Content-Type: text/plain; charset=3Dutf-8; format=3Dflowed

On 25.03.20 10:06, songqianyu via Xenomai wrote:
> When I use the max tool, the maximum value of cat is always in the functi=
on ipipe_test_root + 0x0. I don't think the demo on the wiki website is lik=
e this. What's the matter?
>
> 1=E3=80=81              Type    User Val.   Time    Delay  Function (Pare=
nt)
>
> 2=E3=80=81             #func                  -1    0.098  ipipe_unstall_=
root+0x0 (ipipe_restore_root+0x1c)
>
> 3=E3=80=81           | #begin   0x80000000    -1    0.109  ipipe_unstall_=
root+0x51 (ipipe_restore_root+0x1c)
>
> 4=E3=80=81           | #func                   0    0.147  ipipe_root_onl=
y+0x0 (ipipe_unstall_root+0x16)
>
> 5=E3=80=81           | +end     0x80000000     0    0.107  ipipe_trace_en=
d+0x14 (ipipe_unstall_root+0x42)
>
> 6=E3=80=81             +func                   0    0.122  mutex_unlock+0=
x0 (n_tty_read+0x2fb)
>
> 7=E3=80=81             +func                   0    0.107  tty_ldisc_dere=
f+0x0 (tty_read+0xa4)
>
> 8=E3=80=81             +func                   0    0.108  ldsem_up_read+=
0x0 (tty_ldisc_deref+0x16)
>
> 9=E3=80=81             +func                   0    0.110  ktime_get_real=
_seconds+0x0 (tty_read+0xae)
>
> 10=E3=80=81          +func                   0    0.109  __fsnotify_paren=
t+0x0 (vfs_read+0x10a)
>
> 11=E3=80=81          +func                   0    0.112  fsnotify+0x0 (vf=
s_read+0x123)
>
> 12=E3=80=81       >| +begin   0x80000000     0    0.460  do_syscall_64+0x=
2c7 (entry_SYSCALL_64_after_hwframe+0x49)
>
> 13=E3=80=81       :| +func                   0!  55.409  ipipe_test_root+=
0x0 (trace_hardirqs_on_virt_caller+0x79)
>
> 14=E3=80=81       :| +func                  55    0.127  __ipipe_handle_i=
rq+0x0 (apic_timer_interrupt+0x12)
>
> 15=E3=80=81       :| +begin   0x00001103    55    0.136  <7f9e5eee38c4> (=
apic_timer_interrupt+0x12)
>

This pattern looks to me like we are missing an "interrupts enable"
("end") instrumentation.

What is your configuration, which versions are you using?

> 16=E3=80=81       :| +func                  56    0.116  __ipipe_dispatch=
_irq+0x0 (__ipipe_handle_irq+0xa6)
>
> 17=E3=80=81       :| +func                  56    0.139  irq_to_desc+0x0 =
(__ipipe_dispatch_irq+0x35)
>
> 18=E3=80=81       :| +func                  56    0.144  __ipipe_ack_hrti=
mer_irq+0x0 (__ipipe_dispatch_irq+0x102)
>
> 19=E3=80=81       :| +func                  56    0.187  lapic_itimer_ack=
+0x0 (__ipipe_ack_hrtimer_irq+0x5f)
>
> 20=E3=80=81       :| +func                  56    0.163  dispatch_irq_hea=
d+0x0 (__ipipe_dispatch_irq+0xb6)
>
> 21=E3=80=81       :|# func                  56    0.160  xnintr_core_cloc=
k_handler+0x0 (dispatch_irq_head+0x9d)
>
> 22=E3=80=81       :|# func                  57    0.134  xnlock_dbg_prepa=
re_acquire+0x0 (xnintr_core_clock_handler+0x296)
>
> 23=E3=80=81       :|# func                  57    0.107  xnlock_dbg_acqui=
red+0x0 (xnintr_core_clock_handler+0x2df)
>
> 24=E3=80=81       :|# func                  57    0.171  xnclock_tick+0x0=
 (xnintr_core_clock_handler+0xf1)
>
> 25=E3=80=81       :|# func                  57    0.107  cobalt_timer_han=
dler+0x0 (xnclock_tick+0xc5)
>
> 26=E3=80=81       :|# func                  57    0.106  cobalt_signal_se=
nd_pid+0x0 (cobalt_timer_handler+0x2a)
>
> 27=E3=80=81       :|# func                  57    0.117  cobalt_thread_fi=
nd+0x0 (cobalt_signal_send_pid+0x12)
>
> 28=E3=80=81       :|# func                  57    0.119  cobalt_signal_se=
nd+0x0 (cobalt_signal_send_pid+0x24)
>
> 29=E3=80=81       :|# func                  57    0.125  xnsynch_wakeup_o=
ne_sleeper+0x0 (cobalt_signal_send+0xa6)
>
> 30=E3=80=81       :|# func                  58    0.139  xnthread_resume+=
0x0 (xnsynch_wakeup_one_sleeper+0xda)
>
> 31=E3=80=81       :|# [ 7092] alt-sam 99    58    0.178  xnthread_resume+=
0xa9 (xnsynch_wakeup_one_sleeper+0xda)
>
> 32=E3=80=81       :|# func                  58    0.117  xntimerq_insert+=
0x0 (xnclock_tick+0x21c)
>
> 33=E3=80=81       :|# func                  58    0.098  xnclock_core_loc=
al_shot+0x0 (xnclock_tick+0x245)
>
> 34=E3=80=81       :|# event   tick@155      58    0.102  xnclock_core_loc=
al_shot+0x67 (xnclock_tick+0x245)
>
> 35=E3=80=81       :|# func                  58    0.150  ipipe_timer_set+=
0x0 (xnclock_core_local_shot+0x6f)
>
> 36=E3=80=81       :|# func                  58    0.177  lapic_next_deadl=
ine+0x0 (ipipe_timer_set+0x79)
>
> 37=E3=80=81       :|# func                  59    0.127  xnlock_dbg_relea=
se+0x0 (xnintr_core_clock_handler+0x110)
>
> 38=E3=80=81       :|# func                  59    0.157  ___xnsched_run+0=
x0 (xnintr_core_clock_handler+0x336)
>
> 39=E3=80=81       :|# func                  59    0.122  xnlock_dbg_prepa=
re_acquire+0x0 (___xnsched_run+0x3fc)
>
> 40=E3=80=81       :|# func                  59    0.105  xnlock_dbg_acqui=
red+0x0 (___xnsched_run+0x444)
>
> 41=E3=80=81       :|# [ 7053] bash    -1    59    0.105  ___xnsched_run+0=
xe3 (xnintr_core_clock_handler+0x336)
>
> 42=E3=80=81       :|# func                  59    0.109  xnsched_pick_nex=
t+0x0 (___xnsched_run+0x124)
>
> 43=E3=80=81       :|# func                  59    0.135  __ipipe_notify_v=
m_preemption+0x0 (___xnsched_run+0x517)
>
> 44=E3=80=81       :|# func                  59    0.110  xnarch_leave_roo=
t+0x0 (___xnsched_run+0x54c)
>
> 45=E3=80=81       :|# func                  59    0.109  xntimer_start+0x=
0 (___xnsched_run+0x56f)
>
> 46=E3=80=81       :|# func                  60    0.108  xnclock_core_ns_=
to_ticks+0x0 (xntimer_start+0x1b8)
>
> 47=E3=80=81       :|# func                  60    0.104  xntimer_enqueue_=
and_program+0x0 (xntimer_start+0xfe)
>
> 48=E3=80=81       :|# func                  60    0.110  xntimerq_insert+=
0x0 (xntimer_enqueue_and_program+0x18)
>
> 49=E3=80=81       :|# func                  60    0.132  xntimer_heading_=
p+0x0 (xntimer_enqueue_and_program+0x2d)
>
> 50=E3=80=81       :|# func                  60    0.115  xnarch_switch_to=
+0x0 (___xnsched_run+0x1da)
>
> 51=E3=80=81       :|# func                  60    0.158  switch_mm_irqs_o=
ff+0x0 (xnarch_switch_to+0x2f)
>
> 52=E3=80=81       :|# func                  60    0.445  load_new_mm_cr3+=
0x0 (switch_mm_irqs_off+0x326)
>
> 53=E3=80=81       :|# func                  61    0.145  xnthread_switch_=
fpu+0x0 (___xnsched_run+0x22d)
>
> 54=E3=80=81       :|# func                  61    0.095  xnarch_switch_fp=
u+0x0 (xnthread_switch_fpu+0x2d)
>
> 55=E3=80=81       :|# [ 7092] alt-sam 99    61    0.225  ___xnsched_run+0=
x24d (xnthread_suspend+0x497)
>
> 56=E3=80=81       :|# func                  61    0.111  cobalt_timer_del=
iver+0x0 (signal_wait+0x556)
>
> 57=E3=80=81       :|# func                  61    0.106  xntimer_get_over=
runs+0x0 (cobalt_timer_deliver+0x6d)
>
> 58=E3=80=81       :|# func                  61    0.110  xnclock_core_ns_=
to_ticks+0x0 (xntimer_get_overruns+0x35)
>
> 59=E3=80=81       :|# func                  62    0.128  xnlock_dbg_relea=
se+0x0 (signal_wait+0x528)
>
> 60=E3=80=81       :|# func                  62    0.110  __ipipe_restore_=
head+0x0 (signal_wait+0x294)
>
> 61=E3=80=81       <|+ end     0x80000000    62    0.278  ipipe_trace_end+=
0x14 (__ipipe_restore_head+0x5b)
>
> 62=E3=80=81        |+ begin   0x80000000    62    0.000  do_syscall_64+0x=
71 (entry_SYSCALL_64_after_hwframe+0x49)
>
>
>
> In addition, how is the frozen tool used? Why does the data obtained by c=
at frozen not change when I run the intensity demo?
> I-pipe frozen back-tracing service on 4.19.84-bros-debug/ipipe release #8
> ------------------------------------------------------------
> CPU: 0, Freeze: 245367883938480 cycles, Trace Points: 30 (+10)
> Calibrated minimum trace-point overhead: 0.064 us
>
> +----- Hard IRQs ('|': locked)
> |+-- Xenomai
> ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
> |||                        +---------- Delay flag ('+': > 1 us, '!': > 10=
 us)
> |||                        |        +- NMI noise ('N')
> |||                        |        |
>      Type    User Val.   Time    Delay  Function (Parent)
> :  +func                  -5    0.120  vfs_write+0x0 (ksys_write+0x5c)
> :  +func                  -5    0.134  rw_verify_area+0x0 (vfs_write+0x77=
)
> :  +func                  -5    0.163  security_file_permission+0x0 (rw_v=
erify_area+0x4e)
> :  +func                  -5    0.110  apparmor_file_permission+0x0 (secu=
rity_file_permission+0x3b)
> :  +func                  -5    0.136  common_file_perm+0x0 (apparmor_fil=
e_permission+0x1a)
> :  +func                  -4    0.160  aa_file_perm+0x0 (common_file_perm=
+0x4d)
> :  +func                  -4    0.105  __sb_start_write+0x0 (vfs_write+0x=
195)
> :  +func                  -4    0.099  ipipe_root_only+0x0 (__sb_start_wr=
ite+0x3f)
> :| +begin   0x80000001    -4    0.119  ipipe_root_only+0x79 (__sb_start_w=
rite+0x3f)
> :| +end     0x80000001    -4    0.113  ipipe_trace_end+0x14 (ipipe_root_o=
nly+0x63)
> :  +func                  -4    0.106  _cond_resched+0x0 (__sb_start_writ=
e+0x44)
> :  +func                  -4    0.107  rcu_all_qs+0x0 (_cond_resched+0x19=
)
> :  +func                  -4    0.138  __vfs_write+0x0 (vfs_write+0xb8)
> :  +func                  -3    0.183  proc_reg_write+0x0 (__vfs_write+0x=
3a)
> :  +func                  -3    0.121  __ipipe_frozen_ctrl+0x0 (proc_reg_=
write+0x45)
> :  +func                  -3    0.108  __check_object_size+0x0 (__ipipe_f=
rozen_ctrl+0x42)
> :  +func                  -3    0.614  check_stack_object+0x0 (__check_ob=
ject_size+0x45)
> :  +func                  -2    0.115  mutex_lock+0x0 (__ipipe_frozen_ctr=
l+0x92)
> :  +func                  -2    0.100  ipipe_root_only+0x0 (mutex_lock+0x=
12)
> :| +begin   0x80000001    -2    0.134  ipipe_root_only+0x79 (mutex_lock+0=
x12)
> :| +end     0x80000001    -2    0.122  ipipe_trace_end+0x14 (ipipe_root_o=
nly+0x63)
> :  +func                  -2    0.117  _cond_resched+0x0 (mutex_lock+0x17=
)
> :  +func                  -2    0.133  rcu_all_qs+0x0 (_cond_resched+0x19=
)
> :  +func                  -2    0.110  ipipe_trace_frozen_reset+0x0 (__ip=
ipe_frozen_ctrl+0x97)
> :  +func                  -2    0.104  __ipipe_global_path_lock+0x0 (ipip=
e_trace_frozen_reset+0x21)
> :  +func                  -2    0.110  __ipipe_spin_lock_irqsave+0x0 (__i=
pipe_global_path_lock+0x15)
> :| +begin   0x80000001    -1+   1.644  __ipipe_spin_lock_irqsave+0x72 (__=
ipipe_global_path_lock+0x15)
> :| #func                   0    0.151  __ipipe_spin_unlock_irqcomplete+0x=
0 (__ipipe_global_path_unlock+0x73)
> :| +end     0x80000001     0    0.113  ipipe_trace_end+0x14 (__ipipe_spin=
_unlock_irqcomplete+0x37)
> <  +freeze  0xffffffffffffffff     0    0.139  proc_reg_write+0x45 (__vfs=
_write+0x3a)
>     +func                   0    0.122  mutex_unlock+0x0 (__ipipe_frozen_=
ctrl+0xb1)
>     +func                   0    0.110  unuse_pde+0x0 (proc_reg_write+0x5=
0)
>     +func                   0    0.110  __fsnotify_parent+0x0 (vfs_write+=
0x141)
>     +func                   0    0.127  fsnotify+0x0 (vfs_write+0x15a)
>     +func                   0    0.115  __sb_end_write+0x0 (vfs_write+0x1=
6e)
> | +begin   0x80000000     0    0.483  do_syscall_64+0x2c7 (entry_SYSCALL_=
64_after_hwframe+0x49)
> | +func                   1    1.109  ipipe_test_root+0x0 (trace_hardirqs=
_on_virt_caller+0x79)
> | +func                   2    0.139  do_syscall_64+0x0 (entry_SYSCALL_64=
_after_hwframe+0x49)
> | +end     0x80000000     2    0.113  ipipe_trace_end+0x14 (do_syscall_64=
+0x7d)
>     +func                   2    0.000  ipipe_handle_syscall+0x0 (do_sysc=
all_64+0x46)
> Can you tell me what the information reflects?

Did you study
https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Using_The_I_Pipe_Tracer
already?

Jan



------------------------------

Subject: Digest Footer




------------------------------

End of Xenomai Digest, Vol 95, Issue 29
***************************************

________________________________
This information may contain confidential and/or privileged material and is=
 only transmitted for the intended recipient. Any review, retransmission, c=
onversion to hard copy, copying, reproduction, circulation, publication, di=
ssemination or other use of, or taking of any action, or omission to take a=
ction, in reliance upon this information by persons or entities other than =
the intended recipient is prohibited. If you have received this message in =
error, please contact the sender and delete the material from any computer,=
 disk drive, diskette, or other storage device or media.
=E6=9C=AC=E4=BF=A1=E6=81=AF=E5=8F=AF=E8=83=BD=E5=8C=85=E6=8B=AC=E6=9F=90=E4=
=BA=9B=E4=BF=9D=E5=AF=86=E7=9A=84=E8=B3=87=E6=96=99=EF=BC=8C=E4=B8=A6=E4=B8=
=94=E5=8F=AA=E7=99=BC=E9=80=81=E7=B5=A6=E7=89=B9=E5=AE=9A=E7=9A=84=E6=94=B6=
=E4=BF=A1=E4=BA=BA=E3=80=82=E7=A6=81=E6=AD=A2=E9=99=A4=E7=89=B9=E5=AE=9A=E6=
=94=B6=E4=BF=A1=E4=BA=BA=E4=BB=A5=E5=A4=96=E7=9A=84=E5=85=B6=E4=BB=96=E4=BB=
=BB=E4=BD=95=E4=BA=BA=E5=A3=AB=E6=88=96=E6=A9=9F=E6=A7=8B=E9=96=B1=E8=AE=80=
=E3=80=81=E8=BD=89=E7=99=BC=E3=80=81=E5=88=97=E5=8D=B0=E3=80=81=E8=A4=87=E8=
=A3=BD=E3=80=81=E5=82=B3=E9=96=B1=E3=80=81=E5=87=BA=E7=89=88=E3=80=81=E6=95=
=A3=E6=92=AD=E6=88=96=E4=BB=A5=E5=85=B6=E5=AE=83=E6=96=B9=E5=BC=8F=E4=BD=BF=
=E7=94=A8=E6=9C=AC=E4=BF=A1=E6=81=AF=EF=BC=8C=E6=88=96=E4=BE=9D=E8=B3=B4=E6=
=9C=AC=E4=BF=A1=E6=81=AF=E4=BD=9C=E5=87=BA=E6=88=96=E4=B8=8D=E4=BD=9C=E5=87=
=BA=E4=BB=BB=E4=BD=95=E8=A1=8C=E7=82=BA=E3=80=82=E5=A6=82=E6=9E=9C=E9=96=A3=
=E4=B8=8B=E9=8C=AF=E8=AA=A4=E5=9C=B0=E6=94=B6=E5=88=B0=E6=9C=AC=E4=BF=A1=E6=
=81=AF=EF=BC=8C=E8=AB=8B=E8=81=AF=E7=B5=A1=E7=99=BC=E4=BF=A1=E4=BA=BA=E4=B8=
=A6=E5=BE=9E=E4=BB=BB=E4=BD=95=E9=9B=BB=E8=85=A6=E3=80=81=E7=A3=81=E7=89=87=
=E3=80=81=E7=A3=81=E7=A2=9F=E6=88=96=E5=85=B6=E5=AE=83=E5=AD=98=E5=84=B2=E8=
=A3=9D=E7=BD=AE=E6=88=96=E5=AA=92=E9=AB=94=E4=B8=AD=E5=88=AA=E9=99=A4=E6=9C=
=AC=E4=BF=A1=E6=81=AF=E3=80=82
