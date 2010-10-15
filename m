Date: Fri, 15 Oct 2010 10:21:59 +0100 (BST)
From: edward.robbins@domain.hid
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_20101015102159000000_40150"
In-Reply-To: <1283590285.1709.2153.camel@domain.hid>
References: <1281709057.650414331@domain.hid>
	<4C65583D.3030800@domain.hid> 
	<1281960823.030215299@domain.hid> <4C692FC3.5040802@domain.hid> 
	<1283531433.789315367@domain.hid> 
	<1283590285.1709.2153.camel@domain.hid>
Message-ID: <1287134519.029617765@domain.hid>
Subject: Re: [Xenomai-help] Very high latencies under stress testing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

------=_20101015102159000000_40150
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Saturday, 4 September, 2010 9:51am, "Philippe Gerum" <rpm@xenomai.org> s=
aid:=0A=0A> On Fri, 2010-09-03 at 17:30 +0100,=0A> edward.robbins@domain.hid=
hnologies.co.uk wrote:=0A> > Today I have tried using the intel video drive=
r with the option "NoAccel",=0A> and that seems to stop the high latencies;=
 with this option I can kill X, restart=0A> it, and run glxgears without is=
sues, all while compiling the linux kernel and=0A> having xeno-test or late=
ncy running. The highest latency I have gotten so far is=0A> 18uS.=0A> >=0A=
> > However, if anyone is interested I have made a trace without the NoAcce=
l=0A> option, when the latency jumped to 1113uS upon starting X, attached.=
=0A> >=0A> =0A> Please try this patch. Your trace log reveals that we are o=
nly virtually=0A> masking interrupts while flushing the TLB, which is quite=
 wrong.=0A> =0A=0AHi Phillipe,=0A=0AI have tried the patch, and the only no=
ticeable difference is that now when I have the NoAccel option set I am get=
ting high latencies when I make actions such as killing the X server. Below=
 is the ipipe trace. I presume this is going to be a problem even if I am n=
ot running X?=0A=0AThanks again,=0AEdward=0A=0AI-pipe frozen back-tracing s=
ervice on 2.6.32.15-xenomai-2.5.4/ipipe-2.7-01=0A--------------------------=
----------------------------------=0ACPU: 0, Freeze: 4761785881144 cycles, =
Trace Points: 100 (+10)=0ACalibrated minimum trace-point overhead: 0.131 us=
=0A=0A +----- Hard IRQs ('|': locked)=0A |+---- <unused>=0A ||+--- <unused>=
=0A |||+-- Xenomai=0A ||||+- Linux ('*': domain stalled, '+': current, '#':=
 current+stalled)=0A |||||                        +---------- Delay flag ('=
+': > 1 us, '!': > 10 us)=0A |||||                        |        +- NMI n=
oise ('N')=0A |||||                        |        |=0A      Type    User =
Val.   Time    Delay  Function (Parent)=0A:|  # func               -2144   =
 0.326  __phys_addr+0x4 (__xnpod_schedule+0x562)=0A:|  # func              =
 -2143    0.390  __switch_to_xtra+0x8 (__switch_to+0x255)=0A:|  # [ 3276] X=
org    -1 -2143    0.427  __xnpod_schedule+0x834 (xnintr_clock_handler+0x13=
0)=0A:|   +func               -2143    0.408  __ipipe_walk_pipeline+0x11 (_=
_ipipe_dispatch_wired_nocheck+0x1da)=0A:|   +end     0x000000f6 -2142    0.=
416  common_interrupt+0x39 (debug_smp_processor_id+0x97)=0A:|   +begin   0x=
80000001 -2142    0.240  debug_smp_processor_id+0x44 (smp_call_function_sin=
gle+0x122)=0A:|   +end     0x80000001 -2141    0.262  debug_smp_processor_i=
d+0x94 (smp_call_function_single+0x122)=0A:    +func               -2141   =
 0.221  generic_exec_single+0x11 (smp_call_function_single+0x160)=0A:    +f=
unc               -2141    0.195  _spin_lock_irqsave+0x7 (generic_exec_sing=
le+0x3d)=0A:    +func               -2141    0.195  ipipe_check_context+0x1=
1 (_spin_lock_irqsave+0x1b)=0A:|   +begin   0x80000001 -2141    0.262  ipip=
e_check_context+0x33 (_spin_lock_irqsave+0x1b)=0A:|   +end     0x80000001 -=
2140    0.244  ipipe_check_context+0xda (_spin_lock_irqsave+0x1b)=0A:    #f=
unc               -2140    0.206  add_preempt_count+0x9 (_spin_lock_irqsave=
+0x4c)=0A:    #func               -2140    0.202  ipipe_check_context+0x11 =
(add_preempt_count+0x1c)=0A:|   #begin   0x80000001 -2140    0.259  ipipe_c=
heck_context+0x33 (add_preempt_count+0x1c)=0A:|   #end     0x80000001 -2139=
    0.251  ipipe_check_context+0xda (add_preempt_count+0x1c)=0A:    #func  =
             -2139    0.195  _spin_unlock_irqrestore+0x4 (generic_exec_sing=
le+0x5d)=0A:    #func               -2139    0.191  __ipipe_restore_root+0x=
b (_spin_unlock_irqrestore+0x21)=0A:|   #begin   0x80000001 -2139    0.236 =
 __ipipe_restore_root+0x2d (_spin_unlock_irqrestore+0x21)=0A:|   #end     0=
x80000001 -2139    0.236  __ipipe_restore_root+0x7d (_spin_unlock_irqrestor=
e+0x21)=0A:    #func               -2138    0.191  __ipipe_unstall_root+0x9=
 (__ipipe_restore_root+0xb1)=0A:|   #begin   0x80000000 -2138    0.266  __i=
pipe_unstall_root+0x20 (__ipipe_restore_root+0xb1)=0A:|   +end     0x800000=
00 -2138    0.213  __ipipe_unstall_root+0xce (__ipipe_restore_root+0xb1)=0A=
:    +func               -2138    0.206  sub_preempt_count+0x9 (_spin_unloc=
k_irqrestore+0x2b)=0A:    +func               -2137    0.206  ipipe_check_c=
ontext+0x11 (sub_preempt_count+0x1c)=0A:|   +begin   0x80000001 -2137    0.=
259  ipipe_check_context+0x33 (sub_preempt_count+0x1c)=0A:|   +end     0x80=
000001 -2137    0.255  ipipe_check_context+0xda (sub_preempt_count+0x1c)=0A=
:    +func               -2137    0.221  native_send_call_func_single_ipi+0=
x4 (generic_exec_single+0x6b)=0A:    +func               -2136    0.199  fl=
at_send_IPI_mask+0x11 (native_send_call_func_single_ipi+0x34)=0A:|   +begin=
   0x80000001 -2136    0.247  flat_send_IPI_mask+0x36 (native_send_call_fun=
c_single_ipi+0x34)=0A:|   +end     0x80000001 -2136    0.228  flat_send_IPI=
_mask+0x8e (native_send_call_func_single_ipi+0x34)=0A:    +func            =
   -2136    0.206  sub_preempt_count+0x9 (smp_call_function_single+0x173)=
=0A:    +func               -2136    0.191  ipipe_check_context+0x11 (sub_p=
reempt_count+0x1c)=0A:|   +begin   0x80000001 -2135    0.244  ipipe_check_c=
ontext+0x33 (sub_preempt_count+0x1c)=0A:|   +end     0x80000001 -2135    0.=
262  ipipe_check_context+0xda (sub_preempt_count+0x1c)=0A:    +func        =
       -2135    0.191  sub_preempt_count+0x9 (smp_call_function+0x47)=0A:  =
  +func               -2135    0.187  ipipe_check_context+0x11 (sub_preempt=
_count+0x1c)=0A:|   +begin   0x80000001 -2135    0.244  ipipe_check_context=
+0x33 (sub_preempt_count+0x1c)=0A:|   +end     0x80000001 -2134    0.232  i=
pipe_check_context+0xda (sub_preempt_count+0x1c)=0A:    +func              =
 -2134    0.187  ipipe_check_context+0x11 (set_mtrr+0x77)=0A:|   +begin   0=
x80000001 -2134    0.251  ipipe_check_context+0x33 (set_mtrr+0x77)=0A:|   +=
end     0x80000001 -2134!  10.477  ipipe_check_context+0xda (set_mtrr+0x77)=
=0A:    #func               -2123    0.206  generic_set_mtrr+0x11 (set_mtrr=
+0xdc)=0A:    #func               -2123    0.202  ipipe_check_context+0x11 =
(generic_set_mtrr+0x42)=0A:|   #begin   0x80000001 -2123    0.262  ipipe_ch=
eck_context+0x33 (generic_set_mtrr+0x42)=0A:|   #end     0x80000001 -2122  =
  0.259  ipipe_check_context+0xda (generic_set_mtrr+0x42)=0A:|   #begin   0=
x80000001 -2122    0.221  generic_set_mtrr+0x85 (set_mtrr+0xdc)=0A:|   #fun=
c               -2122    0.199  prepare_set+0x4 (generic_set_mtrr+0x8a)=0A:=
|   #func               -2122    0.213  _spin_lock+0x9 (prepare_set+0x15)=
=0A:|   #func               -2122    0.191  add_preempt_count+0x9 (_spin_lo=
ck+0x1b)=0A:|   #func               -2121! 1840.932  ipipe_check_context+0x=
11 (add_preempt_count+0x1c)=0A:|   #func                -280!  55.546  mtrr=
_wrmsr+0xd (prepare_set+0x79)=0A:|   #func                -225!  53.303  mt=
rr_wrmsr+0xd (generic_set_mtrr+0x111)=0A:|   #func                -172!  52=
.380  mtrr_wrmsr+0xd (generic_set_mtrr+0x129)=0A:|   #func                -=
119!  50.782  post_set+0x4 (generic_set_mtrr+0x12e)=0A:|   #func           =
      -68!  40.665  mtrr_wrmsr+0xd (post_set+0x25)=0A:|   #func            =
     -28+   1.185  _spin_unlock+0x4 (post_set+0x4f)=0A:|   #func           =
      -27    0.356  sub_preempt_count+0x9 (_spin_unlock+0x15)=0A:|   #func =
                -26    0.900  ipipe_check_context+0x11 (sub_preempt_count+0=
x1c)=0A:|   #end     0x80000001   -25+   1.050  generic_set_mtrr+0x13f (set=
_mtrr+0xdc)=0A:|   #begin   0x000000f6   -24    0.566  common_interrupt+0x2=
0 (generic_set_mtrr+0x142)=0A:|   #func                 -24    0.468  __ipi=
pe_handle_irq+0x11 (common_interrupt+0x27)=0A:|   #func                 -23=
    0.266  irq_to_desc+0x4 (__ipipe_handle_irq+0x134)=0A:|   #func         =
        -23    0.397  __ipipe_ack_apic+0x4 (__ipipe_handle_irq+0x13c)=0A:| =
  #func                 -23    0.465  native_apic_mem_write+0x4 (__ipipe_ac=
k_apic+0x1d)=0A:|   #func                 -22    0.348  __ipipe_dispatch_wi=
red+0xd (__ipipe_handle_irq+0x147)=0A:|   #func                 -22    0.45=
0  __ipipe_dispatch_wired_nocheck+0x11 (__ipipe_dispatch_wired+0xba)=0A:|  =
#*func                 -21    0.634  xnintr_clock_handler+0xb (__ipipe_disp=
atch_wired_nocheck+0x12b)=0A:|  #*func                 -21    0.892  xntime=
r_tick_aperiodic+0xb (xnintr_clock_handler+0x81)=0A:|  #*func              =
   -20    0.352  xnthread_periodic_handler+0x4 (xntimer_tick_aperiodic+0x8d=
)=0A:|  #*func                 -19    0.585  xnpod_resume_thread+0x11 (xnth=
read_periodic_handler+0x2d)=0A:|  #*[ 3272] -<?>-   99   -19    0.682  xnpo=
d_resume_thread+0xfa (xnthread_periodic_handler+0x2d)=0A:|  #*func         =
        -18    0.318  xntimer_next_local_shot+0x9 (xntimer_tick_aperiodic+0=
x191)=0A:|  #*event   tick@domain.hid      -18    0.285  xntimer_next_local_shot+0x=
b0 (xntimer_tick_aperiodic+0x191)=0A:|  #*func                 -18    0.420=
  native_apic_mem_write+0x4 (xntimer_next_local_shot+0xe5)=0A:|  #*func    =
             -17    0.517  __xnpod_schedule+0x11 (xnintr_clock_handler+0x13=
0)=0A:|  #*[ 3276] Xorg    -1   -17    0.296  __xnpod_schedule+0x189 (xnint=
r_clock_handler+0x130)=0A:|  #*func                 -16+   1.601  xnsched_p=
ick_next+0x4 (__xnpod_schedule+0x1e3)=0A:|  #*func                 -15+   1=
.091  __phys_addr+0x4 (__xnpod_schedule+0x562)=0A:|  #*func                =
 -14    0.697  __switch_to_xtra+0x8 (__switch_to+0x255)=0A:|  #*[ 3272] -<?=
>-   99   -13    0.945  __xnpod_schedule+0x834 (xnpod_suspend_thread+0x281)=
=0A:|  #*func                 -12    0.495  xntimer_get_overruns+0x8 (xnpod=
_wait_thread_period+0x14c)=0A:|  #*func                 -11    0.307  __ipi=
pe_restore_pipeline_head+0x7 (xnpod_wait_thread_period+0x1cb)=0A:|  +*end  =
   0x80000000   -11+   1.526  __ipipe_restore_pipeline_head+0x137 (xnpod_wa=
it_thread_period+0x1cb)=0A:|  +*begin   0x80000001   -10    0.442  __ipipe_=
dispatch_event+0x1d9 (__ipipe_syscall_root+0xcd)=0A:|  +*end     0x80000001=
    -9    0.341  __ipipe_dispatch_event+0x3f0 (__ipipe_syscall_root+0xcd)=
=0A:|  +*begin   0x80000001    -9+   4.351  __ipipe_syscall_root+0xec (__ip=
ipe_syscall_root_thunk+0x35)=0A:   +*func                  -5    0.322  __i=
pipe_syscall_root+0x11 (__ipipe_syscall_root_thunk+0x35)=0A:   +*func      =
            -4    0.202  __ipipe_dispatch_event+0x11 (__ipipe_syscall_root+=
0xcd)=0A:|  +*begin   0x80000001    -4    0.510  __ipipe_dispatch_event+0x3=
4 (__ipipe_syscall_root+0xcd)=0A:|  +*end     0x80000001    -3    0.266  __=
ipipe_dispatch_event+0x1a6 (__ipipe_syscall_root+0xcd)=0A:   +*func        =
          -3    0.791  hisyscall_event+0x11 (__ipipe_dispatch_event+0x1b7)=
=0A:   +*func                  -2    0.528  xnshadow_sys_trace+0x7 (hisysca=
ll_event+0x151)=0A:   +*func                  -2    0.300  ipipe_trace_froz=
en_reset+0xb (xnshadow_sys_trace+0x69)=0A:   +*func                  -2    =
0.199  __ipipe_global_path_lock+0x4 (ipipe_trace_frozen_reset+0x1c)=0A:   +=
*func                  -1    0.187  __ipipe_spin_lock_irqsave+0xb (__ipipe_=
global_path_lock+0x15)=0A:|  +*begin   0x80000001    -1+   1.226  __ipipe_s=
pin_lock_irqsave+0x2a (__ipipe_global_path_lock+0x15)=0A:|  #*func         =
          0    0.262  __ipipe_spin_unlock_irqcomplete+0xb (__ipipe_global_p=
ath_unlock+0x7d)=0A:|  +*end     0x80000001     0    0.229  __ipipe_spin_un=
lock_irqcomplete+0xcf (__ipipe_global_path_unlock+0x7d)=0A<   +*freeze  0x0=
01f3e65     0    0.225  xnshadow_sys_trace+0x73 (hisyscall_event+0x151)=0A =
|  +*begin   0x80000001     0    0.251  __ipipe_dispatch_event+0x1d9 (__ipi=
pe_syscall_root+0xcd)=0A |  +*end     0x80000001     0    0.214  __ipipe_di=
spatch_event+0x3f0 (__ipipe_syscall_root+0xcd)=0A |  +*begin   0x80000001  =
   0    0.708  __ipipe_syscall_root+0xec (__ipipe_syscall_root_thunk+0x35)=
=0A    +*func                   1    0.199  __ipipe_syscall_root+0x11 (__ip=
ipe_syscall_root_thunk+0x35)=0A    +*func                   1    0.183  __i=
pipe_dispatch_event+0x11 (__ipipe_syscall_root+0xcd)=0A |  +*begin   0x8000=
0001     1    0.262  __ipipe_dispatch_event+0x34 (__ipipe_syscall_root+0xcd=
)=0A |  +*end     0x80000001     2    0.199  __ipipe_dispatch_event+0x1a6 (=
__ipipe_syscall_root+0xcd)=0A    +*func                   2    0.352  hisys=
call_event+0x11 (__ipipe_dispatch_event+0x1b7)=0A    +*func                =
   2    0.281  __rt_task_wait_period+0xb (hisyscall_event+0x151)=0A    +*fu=
nc                   2    0.000  rt_task_wait_period+0x4 (__rt_task_wait_pe=
riod+0x1c)=0A
------=_20101015102159000000_40150
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<font face=3D"arial" size=3D"2">On Saturday, 4 September, 2010 9:51am, "Phi=
lippe Gerum" &lt;rpm@xenomai.org&gt; said:<br><br>&gt; On Fri, 2010-09-03 a=
t 17:30 +0100,<br>&gt; edward.robbins@domain.hid wrote:<br>&g=
t; &gt; Today I have tried using the intel video driver with the option "No=
Accel",<br>&gt; and that seems to stop the high latencies; with this option=
 I can kill X, restart<br>&gt; it, and run glxgears without issues, all whi=
le compiling the linux kernel and<br>&gt; having xeno-test or latency runni=
ng. The highest latency I have gotten so far is<br>&gt; 18uS.<br>&gt; &gt;<=
br>&gt; &gt; However, if anyone is interested I have made a trace without t=
he NoAccel<br>&gt; option, when the latency jumped to 1113uS upon starting =
X, attached.<br>&gt; &gt;<br>&gt; <br>&gt; Please try this patch. Your trac=
e log reveals that we are only virtually<br>&gt; masking interrupts while f=
lushing the TLB, which is quite wrong.<br>&gt; <br><br>Hi Phillipe,<br><br>=
I have tried the patch, and the only noticeable difference is that now when=
 I have the NoAccel option set I am getting high latencies when I make acti=
ons such as killing the X server. Below is the ipipe trace. I presume this =
is going to be a problem even if I am not running X?<br><br>Thanks again,<b=
r>Edward<br><br>I-pipe frozen back-tracing service on 2.6.32.15-xenomai-2.5=
.4/ipipe-2.7-01<br>--------------------------------------------------------=
----<br>CPU: 0, Freeze: 4761785881144 cycles, Trace Points: 100 (+10)<br>Ca=
librated minimum trace-point overhead: 0.131 us<br><br>&nbsp;+----- Hard IR=
Qs ('|': locked)<br>&nbsp;|+---- &lt;unused&gt;<br>&nbsp;||+--- &lt;unused&=
gt;<br>&nbsp;|||+-- Xenomai<br>&nbsp;||||+- Linux ('*': domain stalled, '+'=
: current, '#': current+stalled)<br>&nbsp;|||||&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +---------- Delay flag ('+': &gt; 1 us,=
 '!': &gt; 10 us)<br>&nbsp;|||||&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +- NMI noi=
se ('N')<br>&nbsp;|||||&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; Type&nbsp;&nbsp;&nbsp; User Val.&nbsp;&nbsp; Time&nbsp;&nb=
sp;&nbsp; Delay&nbsp; Function (Parent)<br>:|&nbsp; # func&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2144&n=
bsp;&nbsp;&nbsp; 0.326&nbsp; __phys_addr+0x4 (__xnpod_schedule+0x562)<br>:|=
&nbsp; # func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; -2143&nbsp;&nbsp;&nbsp; 0.390&nbsp; __switch_to_xtra=
+0x8 (__switch_to+0x255)<br>:|&nbsp; # [ 3276] Xorg&nbsp;&nbsp;&nbsp; -1 -2=
143&nbsp;&nbsp;&nbsp; 0.427&nbsp; __xnpod_schedule+0x834 (xnintr_clock_hand=
ler+0x130)<br>:|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2143&nbsp;&nbsp;&nbsp; 0.408&n=
bsp; __ipipe_walk_pipeline+0x11 (__ipipe_dispatch_wired_nocheck+0x1da)<br>:=
|&nbsp;&nbsp; +end&nbsp;&nbsp;&nbsp;&nbsp; 0x000000f6 -2142&nbsp;&nbsp;&nbs=
p; 0.416&nbsp; common_interrupt+0x39 (debug_smp_processor_id+0x97)<br>:|&nb=
sp;&nbsp; +begin&nbsp;&nbsp; 0x80000001 -2142&nbsp;&nbsp;&nbsp; 0.240&nbsp;=
 debug_smp_processor_id+0x44 (smp_call_function_single+0x122)<br>:|&nbsp;&n=
bsp; +end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001 -2141&nbsp;&nbsp;&nbsp; 0.262&=
nbsp; debug_smp_processor_id+0x94 (smp_call_function_single+0x122)<br>:&nbs=
p;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2141&nbsp;&nbsp;&nbsp; 0.221&nbsp; generic_e=
xec_single+0x11 (smp_call_function_single+0x160)<br>:&nbsp;&nbsp;&nbsp; +fu=
nc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; -2141&nbsp;&nbsp;&nbsp; 0.195&nbsp; _spin_lock_irqsave+0x7 (gen=
eric_exec_single+0x3d)<br>:&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2141&nbsp;&nb=
sp;&nbsp; 0.195&nbsp; ipipe_check_context+0x11 (_spin_lock_irqsave+0x1b)<br=
>:|&nbsp;&nbsp; +begin&nbsp;&nbsp; 0x80000001 -2141&nbsp;&nbsp;&nbsp; 0.262=
&nbsp; ipipe_check_context+0x33 (_spin_lock_irqsave+0x1b)<br>:|&nbsp;&nbsp;=
 +end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001 -2140&nbsp;&nbsp;&nbsp; 0.244&nbsp=
; ipipe_check_context+0xda (_spin_lock_irqsave+0x1b)<br>:&nbsp;&nbsp;&nbsp;=
 #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; -2140&nbsp;&nbsp;&nbsp; 0.206&nbsp; add_preempt_count+0x9 (=
_spin_lock_irqsave+0x4c)<br>:&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2140&nbsp;&=
nbsp;&nbsp; 0.202&nbsp; ipipe_check_context+0x11 (add_preempt_count+0x1c)<b=
r>:|&nbsp;&nbsp; #begin&nbsp;&nbsp; 0x80000001 -2140&nbsp;&nbsp;&nbsp; 0.25=
9&nbsp; ipipe_check_context+0x33 (add_preempt_count+0x1c)<br>:|&nbsp;&nbsp;=
 #end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001 -2139&nbsp;&nbsp;&nbsp; 0.251&nbsp=
; ipipe_check_context+0xda (add_preempt_count+0x1c)<br>:&nbsp;&nbsp;&nbsp; =
#func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; -2139&nbsp;&nbsp;&nbsp; 0.195&nbsp; _spin_unlock_irqrestore+=
0x4 (generic_exec_single+0x5d)<br>:&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2139&=
nbsp;&nbsp;&nbsp; 0.191&nbsp; __ipipe_restore_root+0xb (_spin_unlock_irqres=
tore+0x21)<br>:|&nbsp;&nbsp; #begin&nbsp;&nbsp; 0x80000001 -2139&nbsp;&nbsp=
;&nbsp; 0.236&nbsp; __ipipe_restore_root+0x2d (_spin_unlock_irqrestore+0x21=
)<br>:|&nbsp;&nbsp; #end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001 -2139&nbsp;&nbs=
p;&nbsp; 0.236&nbsp; __ipipe_restore_root+0x7d (_spin_unlock_irqrestore+0x2=
1)<br>:&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2138&nbsp;&nbsp;&nbsp; 0.191&nbsp=
; __ipipe_unstall_root+0x9 (__ipipe_restore_root+0xb1)<br>:|&nbsp;&nbsp; #b=
egin&nbsp;&nbsp; 0x80000000 -2138&nbsp;&nbsp;&nbsp; 0.266&nbsp; __ipipe_uns=
tall_root+0x20 (__ipipe_restore_root+0xb1)<br>:|&nbsp;&nbsp; +end&nbsp;&nbs=
p;&nbsp;&nbsp; 0x80000000 -2138&nbsp;&nbsp;&nbsp; 0.213&nbsp; __ipipe_unsta=
ll_root+0xce (__ipipe_restore_root+0xb1)<br>:&nbsp;&nbsp;&nbsp; +func&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; -2138&nbsp;&nbsp;&nbsp; 0.206&nbsp; sub_preempt_count+0x9 (_spin_unlock=
_irqrestore+0x2b)<br>:&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2137&nbsp;&nbsp;&n=
bsp; 0.206&nbsp; ipipe_check_context+0x11 (sub_preempt_count+0x1c)<br>:|&nb=
sp;&nbsp; +begin&nbsp;&nbsp; 0x80000001 -2137&nbsp;&nbsp;&nbsp; 0.259&nbsp;=
 ipipe_check_context+0x33 (sub_preempt_count+0x1c)<br>:|&nbsp;&nbsp; +end&n=
bsp;&nbsp;&nbsp;&nbsp; 0x80000001 -2137&nbsp;&nbsp;&nbsp; 0.255&nbsp; ipipe=
_check_context+0xda (sub_preempt_count+0x1c)<br>:&nbsp;&nbsp;&nbsp; +func&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; -2137&nbsp;&nbsp;&nbsp; 0.221&nbsp; native_send_call_func_single_ip=
i+0x4 (generic_exec_single+0x6b)<br>:&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -213=
6&nbsp;&nbsp;&nbsp; 0.199&nbsp; flat_send_IPI_mask+0x11 (native_send_call_f=
unc_single_ipi+0x34)<br>:|&nbsp;&nbsp; +begin&nbsp;&nbsp; 0x80000001 -2136&=
nbsp;&nbsp;&nbsp; 0.247&nbsp; flat_send_IPI_mask+0x36 (native_send_call_fun=
c_single_ipi+0x34)<br>:|&nbsp;&nbsp; +end&nbsp;&nbsp;&nbsp;&nbsp; 0x8000000=
1 -2136&nbsp;&nbsp;&nbsp; 0.228&nbsp; flat_send_IPI_mask+0x8e (native_send_=
call_func_single_ipi+0x34)<br>:&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2136&nbsp=
;&nbsp;&nbsp; 0.206&nbsp; sub_preempt_count+0x9 (smp_call_function_single+0=
x173)<br>:&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2136&nbsp;&nbsp;&nbsp; 0.191&n=
bsp; ipipe_check_context+0x11 (sub_preempt_count+0x1c)<br>:|&nbsp;&nbsp; +b=
egin&nbsp;&nbsp; 0x80000001 -2135&nbsp;&nbsp;&nbsp; 0.244&nbsp; ipipe_check=
_context+0x33 (sub_preempt_count+0x1c)<br>:|&nbsp;&nbsp; +end&nbsp;&nbsp;&n=
bsp;&nbsp; 0x80000001 -2135&nbsp;&nbsp;&nbsp; 0.262&nbsp; ipipe_check_conte=
xt+0xda (sub_preempt_count+0x1c)<br>:&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -213=
5&nbsp;&nbsp;&nbsp; 0.191&nbsp; sub_preempt_count+0x9 (smp_call_function+0x=
47)<br>:&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2135&nbsp;&nbsp;&nbsp; 0.187&nbs=
p; ipipe_check_context+0x11 (sub_preempt_count+0x1c)<br>:|&nbsp;&nbsp; +beg=
in&nbsp;&nbsp; 0x80000001 -2135&nbsp;&nbsp;&nbsp; 0.244&nbsp; ipipe_check_c=
ontext+0x33 (sub_preempt_count+0x1c)<br>:|&nbsp;&nbsp; +end&nbsp;&nbsp;&nbs=
p;&nbsp; 0x80000001 -2134&nbsp;&nbsp;&nbsp; 0.232&nbsp; ipipe_check_context=
+0xda (sub_preempt_count+0x1c)<br>:&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2134&=
nbsp;&nbsp;&nbsp; 0.187&nbsp; ipipe_check_context+0x11 (set_mtrr+0x77)<br>:=
|&nbsp;&nbsp; +begin&nbsp;&nbsp; 0x80000001 -2134&nbsp;&nbsp;&nbsp; 0.251&n=
bsp; ipipe_check_context+0x33 (set_mtrr+0x77)<br>:|&nbsp;&nbsp; +end&nbsp;&=
nbsp;&nbsp;&nbsp; 0x80000001 -2134!&nbsp; 10.477&nbsp; ipipe_check_context+=
0xda (set_mtrr+0x77)<br>:&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2123&nbsp;&nbsp=
;&nbsp; 0.206&nbsp; generic_set_mtrr+0x11 (set_mtrr+0xdc)<br>:&nbsp;&nbsp;&=
nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; -2123&nbsp;&nbsp;&nbsp; 0.202&nbsp; ipipe_check_contex=
t+0x11 (generic_set_mtrr+0x42)<br>:|&nbsp;&nbsp; #begin&nbsp;&nbsp; 0x80000=
001 -2123&nbsp;&nbsp;&nbsp; 0.262&nbsp; ipipe_check_context+0x33 (generic_s=
et_mtrr+0x42)<br>:|&nbsp;&nbsp; #end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001 -21=
22&nbsp;&nbsp;&nbsp; 0.259&nbsp; ipipe_check_context+0xda (generic_set_mtrr=
+0x42)<br>:|&nbsp;&nbsp; #begin&nbsp;&nbsp; 0x80000001 -2122&nbsp;&nbsp;&nb=
sp; 0.221&nbsp; generic_set_mtrr+0x85 (set_mtrr+0xdc)<br>:|&nbsp;&nbsp; #fu=
nc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; -2122&nbsp;&nbsp;&nbsp; 0.199&nbsp; prepare_set+0x4 (generic_se=
t_mtrr+0x8a)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2122&nbsp;&nbsp;&nbsp; 0.213=
&nbsp; _spin_lock+0x9 (prepare_set+0x15)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -=
2122&nbsp;&nbsp;&nbsp; 0.191&nbsp; add_preempt_count+0x9 (_spin_lock+0x1b)<=
br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2121! 1840.932&nbsp; ipipe_check_context+=
0x11 (add_preempt_count+0x1c)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -280!&=
nbsp; 55.546&nbsp; mtrr_wrmsr+0xd (prepare_set+0x79)<br>:|&nbsp;&nbsp; #fun=
c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; -225!&nbsp; 53.303&nbsp; mtrr_wrmsr+0xd (generic_set_mtrr+=
0x111)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -172!&nbsp; 52.380&nbsp; mtrr=
_wrmsr+0xd (generic_set_mtrr+0x129)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
-119!&nbsp; 50.782&nbsp; post_set+0x4 (generic_set_mtrr+0x12e)<br>:|&nbsp;&=
nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -68!&nbsp; 40.665&nbsp; mtrr_wrmsr+0xd (po=
st_set+0x25)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -28+&nbsp;&nbsp; =
1.185&nbsp; _spin_unlock+0x4 (post_set+0x4f)<br>:|&nbsp;&nbsp; #func&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; -27&nbsp;&nbsp;&nbsp; 0.356&nbsp; sub_preempt_count+0x9 (_sp=
in_unlock+0x15)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -26&nbsp;&nbsp=
;&nbsp; 0.900&nbsp; ipipe_check_context+0x11 (sub_preempt_count+0x1c)<br>:|=
&nbsp;&nbsp; #end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&nbsp; -25+&nbsp;=
&nbsp; 1.050&nbsp; generic_set_mtrr+0x13f (set_mtrr+0xdc)<br>:|&nbsp;&nbsp;=
 #begin&nbsp;&nbsp; 0x000000f6&nbsp;&nbsp; -24&nbsp;&nbsp;&nbsp; 0.566&nbsp=
; common_interrupt+0x20 (generic_set_mtrr+0x142)<br>:|&nbsp;&nbsp; #func&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; -24&nbsp;&nbsp;&nbsp; 0.468&nbsp; __ipipe_handle_irq+0x1=
1 (common_interrupt+0x27)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -23&=
nbsp;&nbsp;&nbsp; 0.266&nbsp; irq_to_desc+0x4 (__ipipe_handle_irq+0x134)<br=
>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -23&nbsp;&nbsp;&nbsp; 0.397&nbsp=
; __ipipe_ack_apic+0x4 (__ipipe_handle_irq+0x13c)<br>:|&nbsp;&nbsp; #func&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; -23&nbsp;&nbsp;&nbsp; 0.465&nbsp; native_apic_mem_write=
+0x4 (__ipipe_ack_apic+0x1d)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -=
22&nbsp;&nbsp;&nbsp; 0.348&nbsp; __ipipe_dispatch_wired+0xd (__ipipe_handle=
_irq+0x147)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -22&nbsp;&nbsp;&nb=
sp; 0.450&nbsp; __ipipe_dispatch_wired_nocheck+0x11 (__ipipe_dispatch_wired=
+0xba)<br>:|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -21&nbsp;&nbsp;&nbsp; 0.634&=
nbsp; xnintr_clock_handler+0xb (__ipipe_dispatch_wired_nocheck+0x12b)<br>:|=
&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -21&nbsp;&nbsp;&nbsp; 0.892&nbsp; xntime=
r_tick_aperiodic+0xb (xnintr_clock_handler+0x81)<br>:|&nbsp; #*func&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; -20&nbsp;&nbsp;&nbsp; 0.352&nbsp; xnthread_periodic_handler+0=
x4 (xntimer_tick_aperiodic+0x8d)<br>:|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1=
9&nbsp;&nbsp;&nbsp; 0.585&nbsp; xnpod_resume_thread+0x11 (xnthread_periodic=
_handler+0x2d)<br>:|&nbsp; #*[ 3272] -&lt;?&gt;-&nbsp;&nbsp; 99&nbsp;&nbsp;=
 -19&nbsp;&nbsp;&nbsp; 0.682&nbsp; xnpod_resume_thread+0xfa (xnthread_perio=
dic_handler+0x2d)<br>:|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -18&nbsp;&nbsp;&n=
bsp; 0.318&nbsp; xntimer_next_local_shot+0x9 (xntimer_tick_aperiodic+0x191)=
<br>:|&nbsp; #*event&nbsp;&nbsp; tick@domain.hid&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -18&=
nbsp;&nbsp;&nbsp; 0.285&nbsp; xntimer_next_local_shot+0xb0 (xntimer_tick_ap=
eriodic+0x191)<br>:|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -18&nbsp;&nbsp;&nbsp=
; 0.420&nbsp; native_apic_mem_write+0x4 (xntimer_next_local_shot+0xe5)<br>:=
|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -17&nbsp;&nbsp;&nbsp; 0.517&nbsp; __xnp=
od_schedule+0x11 (xnintr_clock_handler+0x130)<br>:|&nbsp; #*[ 3276] Xorg&nb=
sp;&nbsp;&nbsp; -1&nbsp;&nbsp; -17&nbsp;&nbsp;&nbsp; 0.296&nbsp; __xnpod_sc=
hedule+0x189 (xnintr_clock_handler+0x130)<br>:|&nbsp; #*func&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; -16+&nbsp;&nbsp; 1.601&nbsp; xnsched_pick_next+0x4 (__xnpod_schedule=
+0x1e3)<br>:|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -15+&nbsp;&nbsp; 1.091&nbsp=
; __phys_addr+0x4 (__xnpod_schedule+0x562)<br>:|&nbsp; #*func&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; -14&nbsp;&nbsp;&nbsp; 0.697&nbsp; __switch_to_xtra+0x8 (__switch_to=
+0x255)<br>:|&nbsp; #*[ 3272] -&lt;?&gt;-&nbsp;&nbsp; 99&nbsp;&nbsp; -13&nb=
sp;&nbsp;&nbsp; 0.945&nbsp; __xnpod_schedule+0x834 (xnpod_suspend_thread+0x=
281)<br>:|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -12&nbsp;&nbsp;&nbsp; 0.495&nb=
sp; xntimer_get_overruns+0x8 (xnpod_wait_thread_period+0x14c)<br>:|&nbsp; #=
*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; -11&nbsp;&nbsp;&nbsp; 0.307&nbsp; __ipipe_restor=
e_pipeline_head+0x7 (xnpod_wait_thread_period+0x1cb)<br>:|&nbsp; +*end&nbsp=
;&nbsp;&nbsp;&nbsp; 0x80000000&nbsp;&nbsp; -11+&nbsp;&nbsp; 1.526&nbsp; __i=
pipe_restore_pipeline_head+0x137 (xnpod_wait_thread_period+0x1cb)<br>:|&nbs=
p; +*begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp; -10&nbsp;&nbsp;&nbsp; 0.442&n=
bsp; __ipipe_dispatch_event+0x1d9 (__ipipe_syscall_root+0xcd)<br>:|&nbsp; +=
*end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp; -9&nbsp;&nbsp;&nb=
sp; 0.341&nbsp; __ipipe_dispatch_event+0x3f0 (__ipipe_syscall_root+0xcd)<br=
>:|&nbsp; +*begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp; -9+&nbsp;&nbsp; =
4.351&nbsp; __ipipe_syscall_root+0xec (__ipipe_syscall_root_thunk+0x35)<br>=
:&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -5&nbsp;&nbsp;&nbsp; 0.322&=
nbsp; __ipipe_syscall_root+0x11 (__ipipe_syscall_root_thunk+0x35)<br>:&nbsp=
;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4&nbsp;&nbsp;&nbsp; 0.202&nbsp; =
__ipipe_dispatch_event+0x11 (__ipipe_syscall_root+0xcd)<br>:|&nbsp; +*begin=
&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp; -4&nbsp;&nbsp;&nbsp; 0.510&nbsp; =
__ipipe_dispatch_event+0x34 (__ipipe_syscall_root+0xcd)<br>:|&nbsp; +*end&n=
bsp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp; -3&nbsp;&nbsp;&nbsp; 0.=
266&nbsp; __ipipe_dispatch_event+0x1a6 (__ipipe_syscall_root+0xcd)<br>:&nbs=
p;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3&nbsp;&nbsp;&nbsp; 0.791&nbsp;=
 hisyscall_event+0x11 (__ipipe_dispatch_event+0x1b7)<br>:&nbsp;&nbsp; +*fun=
c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; -2&nbsp;&nbsp;&nbsp; 0.528&nbsp; xnshadow_sys_=
trace+0x7 (hisyscall_event+0x151)<br>:&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; -2&nbsp;&nbsp;&nbsp; 0.300&nbsp; ipipe_trace_frozen_reset+0xb (xn=
shadow_sys_trace+0x69)<br>:&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -=
2&nbsp;&nbsp;&nbsp; 0.199&nbsp; __ipipe_global_path_lock+0x4 (ipipe_trace_f=
rozen_reset+0x1c)<br>:&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1&nbs=
p;&nbsp;&nbsp; 0.187&nbsp; __ipipe_spin_lock_irqsave+0xb (__ipipe_global_pa=
th_lock+0x15)<br>:|&nbsp; +*begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp; =
-1+&nbsp;&nbsp; 1.226&nbsp; __ipipe_spin_lock_irqsave+0x2a (__ipipe_global_=
path_lock+0x15)<br>:|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;=
&nbsp;&nbsp; 0.262&nbsp; __ipipe_spin_unlock_irqcomplete+0xb (__ipipe_globa=
l_path_unlock+0x7d)<br>:|&nbsp; +*end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&nb=
sp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0.229&nbsp; __ipipe_spin_unlock_i=
rqcomplete+0xcf (__ipipe_global_path_unlock+0x7d)<br>&lt;&nbsp;&nbsp; +*fre=
eze&nbsp; 0x001f3e65&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0.225&nbsp=
; xnshadow_sys_trace+0x73 (hisyscall_event+0x151)<br>&nbsp;|&nbsp; +*begin&=
nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0.251&nb=
sp; __ipipe_dispatch_event+0x1d9 (__ipipe_syscall_root+0xcd)<br>&nbsp;|&nbs=
p; +*end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;=
&nbsp;&nbsp; 0.214&nbsp; __ipipe_dispatch_event+0x3f0 (__ipipe_syscall_root=
+0xcd)<br>&nbsp;|&nbsp; +*begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;&nb=
sp; 0&nbsp;&nbsp;&nbsp; 0.708&nbsp; __ipipe_syscall_root+0xec (__ipipe_sysc=
all_root_thunk+0x35)<br>&nbsp;&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 1&nbsp;&nbsp;&nbsp; 0.199&nbsp; __ipipe_syscall_root+0x11 (__ipipe_=
syscall_root_thunk+0x35)<br>&nbsp;&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; 0.183&nbsp; __ipipe_dispatch_event+0x11 (__=
ipipe_syscall_root+0xcd)<br>&nbsp;|&nbsp; +*begin&nbsp;&nbsp; 0x80000001&nb=
sp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; 0.262&nbsp; __ipipe_dispatch_even=
t+0x34 (__ipipe_syscall_root+0xcd)<br>&nbsp;|&nbsp; +*end&nbsp;&nbsp;&nbsp;=
&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp; 0.199&nbsp; _=
_ipipe_dispatch_event+0x1a6 (__ipipe_syscall_root+0xcd)<br>&nbsp;&nbsp;&nbs=
p; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp; 0.352&nbsp; =
hisyscall_event+0x11 (__ipipe_dispatch_event+0x1b7)<br>&nbsp;&nbsp;&nbsp; +=
*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp; 0.281&nbsp; __rt=
_task_wait_period+0xb (hisyscall_event+0x151)<br>&nbsp;&nbsp;&nbsp; +*func&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp; 0.000&nbsp; rt_task_wa=
it_period+0x4 (__rt_task_wait_period+0x1c)<br></font>
------=_20101015102159000000_40150--


