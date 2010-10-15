Date: Fri, 15 Oct 2010 12:54:51 +0100 (BST)
From: edward.robbins@domain.hid
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_20101015125451000000_53276"
In-Reply-To: <1287134519.029617765@domain.hid>
References: <1281709057.650414331@domain.hid>
	<4C65583D.3030800@domain.hid> 
	<1281960823.030215299@domain.hid> <4C692FC3.5040802@domain.hid>  
	<1283531433.789315367@domain.hid>  
	<1283590285.1709.2153.camel@domain.hid> 
	<1287134519.029617765@domain.hid>
Message-ID: <1287143691.028416668@domain.hid>
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
To: edward.robbins@domain.hid
Cc: xenomai@xenomai.org

------=_20101015125451000000_53276
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am also finding that tasks are frequently hanging, causing ipipetraces wi=
th "INFO: task xxx:xxx blocked for more than 120 seconds". Ihave just had t=
his with apt-get update, and was previously getting itwith grub-install. Co=
uld this be related?=0A=0AThanks again=0A=0AOn Friday, 15 October, 2010 10:=
21am, edward.robbins@domain.hid said:=0A=0AOn Saturday, 4 Sep=
tember, 2010 9:51am, "Philippe Gerum" <rpm@xenomai.org> said:=0A=0A> On Fri=
, 2010-09-03 at 17:30 +0100,=0A> edward.robbins@domain.hid wr=
ote:=0A> > Today I have tried using the intel video driver with the option =
"NoAccel",=0A> and that seems to stop the high latencies; with this option =
I can kill X, restart=0A> it, and run glxgears without issues, all while co=
mpiling the linux kernel and=0A> having xeno-test or latency running. The h=
ighest latency I have gotten so far is=0A> 18uS.=0A> >=0A> > However, if an=
yone is interested I have made a trace without the NoAccel=0A> option, when=
 the latency jumped to 1113uS upon starting X, attached.=0A> >=0A> =0A> Ple=
ase try this patch. Your trace log reveals that we are only virtually=0A> m=
asking interrupts while flushing the TLB, which is quite wrong.=0A> =0A=0AH=
i Phillipe,=0A=0AI have tried the patch, and the only noticeable difference=
 is that now when I have the NoAccel option set I am getting high latencies=
 when I make actions such as killing the X server. Below is the ipipe trace=
. I presume this is going to be a problem even if I am not running X?=0A=0A=
Thanks again,=0AEdward=0A=0AI-pipe frozen back-tracing service on 2.6.32.15=
-xenomai-2.5.4/ipipe-2.7-01=0A---------------------------------------------=
---------------=0ACPU: 0, Freeze: 4761785881144 cycles, Trace Points: 100 (=
+10)=0ACalibrated minimum trace-point overhead: 0.131 us=0A=0A +----- Hard =
IRQs ('|': locked)=0A |+---- <unused>=0A ||+--- <unused>=0A |||+-- Xenomai=
=0A ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)=
=0A |||||                        +---------- Delay flag ('+': > 1 us, '!': =
> 10 us)=0A |||||                        |        +- NMI noise ('N')=0A |||=
||                        |        |=0A      Type    User Val.   Time    De=
lay  Function (Parent)=0A:|  # func               -2144    0.326  __phys_ad=
dr+0x4 (__xnpod_schedule+0x562)=0A:|  # func               -2143    0.390  =
__switch_to_xtra+0x8 (__switch_to+0x255)=0A:|  # [ 3276] Xorg    -1 -2143  =
  0.427  __xnpod_schedule+0x834 (xnintr_clock_handler+0x130)=0A:|   +func  =
             -2143    0.408  __ipipe_walk_pipeline+0x11 (__ipipe_dispatch_w=
ired_nocheck+0x1da)=0A:|   +end     0x000000f6 -2142    0.416  common_inter=
rupt+0x39 (debug_smp_processor_id+0x97)=0A:|   +begin   0x80000001 -2142   =
 0.240  debug_smp_processor_id+0x44 (smp_call_function_single+0x122)=0A:|  =
 +end     0x80000001 -2141    0.262  debug_smp_processor_id+0x94 (smp_call_=
function_single+0x122)=0A:    +func               -2141    0.221  generic_e=
xec_single+0x11 (smp_call_function_single+0x160)=0A:    +func              =
 -2141    0.195  _spin_lock_irqsave+0x7 (generic_exec_single+0x3d)=0A:    +=
func               -2141    0.195  ipipe_check_context+0x11 (_spin_lock_irq=
save+0x1b)=0A:|   +begin   0x80000001 -2141    0.262  ipipe_check_context+0=
x33 (_spin_lock_irqsave+0x1b)=0A:|   +end     0x80000001 -2140    0.244  ip=
ipe_check_context+0xda (_spin_lock_irqsave+0x1b)=0A:    #func              =
 -2140    0.206  add_preempt_count+0x9 (_spin_lock_irqsave+0x4c)=0A:    #fu=
nc               -2140    0.202  ipipe_check_context+0x11 (add_preempt_coun=
t+0x1c)=0A:|   #begin   0x80000001 -2140    0.259  ipipe_check_context+0x33=
 (add_preempt_count+0x1c)=0A:|   #end     0x80000001 -2139    0.251  ipipe_=
check_context+0xda (add_preempt_count+0x1c)=0A:    #func               -213=
9    0.195  _spin_unlock_irqrestore+0x4 (generic_exec_single+0x5d)=0A:    #=
func               -2139    0.191  __ipipe_restore_root+0xb (_spin_unlock_i=
rqrestore+0x21)=0A:|   #begin   0x80000001 -2139    0.236  __ipipe_restore_=
root+0x2d (_spin_unlock_irqrestore+0x21)=0A:|   #end     0x80000001 -2139  =
  0.236  __ipipe_restore_root+0x7d (_spin_unlock_irqrestore+0x21)=0A:    #f=
unc               -2138    0.191  __ipipe_unstall_root+0x9 (__ipipe_restore=
_root+0xb1)=0A:|   #begin   0x80000000 -2138    0.266  __ipipe_unstall_root=
+0x20 (__ipipe_restore_root+0xb1)=0A:|   +end     0x80000000 -2138    0.213=
  __ipipe_unstall_root+0xce (__ipipe_restore_root+0xb1)=0A:    +func       =
        -2138    0.206  sub_preempt_count+0x9 (_spin_unlock_irqrestore+0x2b=
)=0A:    +func               -2137    0.206  ipipe_check_context+0x11 (sub_=
preempt_count+0x1c)=0A:|   +begin   0x80000001 -2137    0.259  ipipe_check_=
context+0x33 (sub_preempt_count+0x1c)=0A:|   +end     0x80000001 -2137    0=
.255  ipipe_check_context+0xda (sub_preempt_count+0x1c)=0A:    +func       =
        -2137    0.221  native_send_call_func_single_ipi+0x4 (generic_exec_=
single+0x6b)=0A:    +func               -2136    0.199  flat_send_IPI_mask+=
0x11 (native_send_call_func_single_ipi+0x34)=0A:|   +begin   0x80000001 -21=
36    0.247  flat_send_IPI_mask+0x36 (native_send_call_func_single_ipi+0x34=
)=0A:|   +end     0x80000001 -2136    0.228  flat_send_IPI_mask+0x8e (nativ=
e_send_call_func_single_ipi+0x34)=0A:    +func               -2136    0.206=
  sub_preempt_count+0x9 (smp_call_function_single+0x173)=0A:    +func      =
         -2136    0.191  ipipe_check_context+0x11 (sub_preempt_count+0x1c)=
=0A:|   +begin   0x80000001 -2135    0.244  ipipe_check_context+0x33 (sub_p=
reempt_count+0x1c)=0A:|   +end     0x80000001 -2135    0.262  ipipe_check_c=
ontext+0xda (sub_preempt_count+0x1c)=0A:    +func               -2135    0.=
191  sub_preempt_count+0x9 (smp_call_function+0x47)=0A:    +func           =
    -2135    0.187  ipipe_check_context+0x11 (sub_preempt_count+0x1c)=0A:| =
  +begin   0x80000001 -2135    0.244  ipipe_check_context+0x33 (sub_preempt=
_count+0x1c)=0A:|   +end     0x80000001 -2134    0.232  ipipe_check_context=
+0xda (sub_preempt_count+0x1c)=0A:    +func               -2134    0.187  i=
pipe_check_context+0x11 (set_mtrr+0x77)=0A:|   +begin   0x80000001 -2134   =
 0.251  ipipe_check_context+0x33 (set_mtrr+0x77)=0A:|   +end     0x80000001=
 -2134!  10.477  ipipe_check_context+0xda (set_mtrr+0x77)=0A:    #func     =
          -2123    0.206  generic_set_mtrr+0x11 (set_mtrr+0xdc)=0A:    #fun=
c               -2123    0.202  ipipe_check_context+0x11 (generic_set_mtrr+=
0x42)=0A:|   #begin   0x80000001 -2123    0.262  ipipe_check_context+0x33 (=
generic_set_mtrr+0x42)=0A:|   #end     0x80000001 -2122    0.259  ipipe_che=
ck_context+0xda (generic_set_mtrr+0x42)=0A:|   #begin   0x80000001 -2122   =
 0.221  generic_set_mtrr+0x85 (set_mtrr+0xdc)=0A:|   #func               -2=
122    0.199  prepare_set+0x4 (generic_set_mtrr+0x8a)=0A:|   #func         =
      -2122    0.213  _spin_lock+0x9 (prepare_set+0x15)=0A:|   #func       =
        -2122    0.191  add_preempt_count+0x9 (_spin_lock+0x1b)=0A:|   #fun=
c               -2121! 1840.932  ipipe_check_context+0x11 (add_preempt_coun=
t+0x1c)=0A:|   #func                -280!  55.546  mtrr_wrmsr+0xd (prepare_=
set+0x79)=0A:|   #func                -225!  53.303  mtrr_wrmsr+0xd (generi=
c_set_mtrr+0x111)=0A:|   #func                -172!  52.380  mtrr_wrmsr+0xd=
 (generic_set_mtrr+0x129)=0A:|   #func                -119!  50.782  post_s=
et+0x4 (generic_set_mtrr+0x12e)=0A:|   #func                 -68!  40.665  =
mtrr_wrmsr+0xd (post_set+0x25)=0A:|   #func                 -28+   1.185  _=
spin_unlock+0x4 (post_set+0x4f)=0A:|   #func                 -27    0.356  =
sub_preempt_count+0x9 (_spin_unlock+0x15)=0A:|   #func                 -26 =
   0.900  ipipe_check_context+0x11 (sub_preempt_count+0x1c)=0A:|   #end    =
 0x80000001   -25+   1.050  generic_set_mtrr+0x13f (set_mtrr+0xdc)=0A:|   #=
begin   0x000000f6   -24    0.566  common_interrupt+0x20 (generic_set_mtrr+=
0x142)=0A:|   #func                 -24    0.468  __ipipe_handle_irq+0x11 (=
common_interrupt+0x27)=0A:|   #func                 -23    0.266  irq_to_de=
sc+0x4 (__ipipe_handle_irq+0x134)=0A:|   #func                 -23    0.397=
  __ipipe_ack_apic+0x4 (__ipipe_handle_irq+0x13c)=0A:|   #func             =
    -23    0.465  native_apic_mem_write+0x4 (__ipipe_ack_apic+0x1d)=0A:|   =
#func                 -22    0.348  __ipipe_dispatch_wired+0xd (__ipipe_han=
dle_irq+0x147)=0A:|   #func                 -22    0.450  __ipipe_dispatch_=
wired_nocheck+0x11 (__ipipe_dispatch_wired+0xba)=0A:|  #*func              =
   -21    0.634  xnintr_clock_handler+0xb (__ipipe_dispatch_wired_nocheck+0=
x12b)=0A:|  #*func                 -21    0.892  xntimer_tick_aperiodic+0xb=
 (xnintr_clock_handler+0x81)=0A:|  #*func                 -20    0.352  xnt=
hread_periodic_handler+0x4 (xntimer_tick_aperiodic+0x8d)=0A:|  #*func      =
           -19    0.585  xnpod_resume_thread+0x11 (xnthread_periodic_handle=
r+0x2d)=0A:|  #*[ 3272] -<?>-   99   -19    0.682  xnpod_resume_thread+0xfa=
 (xnthread_periodic_handler+0x2d)=0A:|  #*func                 -18    0.318=
  xntimer_next_local_shot+0x9 (xntimer_tick_aperiodic+0x191)=0A:|  #*event =
  tick@domain.hid      -18    0.285  xntimer_next_local_shot+0xb0 (xntimer_tick_ape=
riodic+0x191)=0A:|  #*func                 -18    0.420  native_apic_mem_wr=
ite+0x4 (xntimer_next_local_shot+0xe5)=0A:|  #*func                 -17    =
0.517  __xnpod_schedule+0x11 (xnintr_clock_handler+0x130)=0A:|  #*[ 3276] X=
org    -1   -17    0.296  __xnpod_schedule+0x189 (xnintr_clock_handler+0x13=
0)=0A:|  #*func                 -16+   1.601  xnsched_pick_next+0x4 (__xnpo=
d_schedule+0x1e3)=0A:|  #*func                 -15+   1.091  __phys_addr+0x=
4 (__xnpod_schedule+0x562)=0A:|  #*func                 -14    0.697  __swi=
tch_to_xtra+0x8 (__switch_to+0x255)=0A:|  #*[ 3272] -<?>-   99   -13    0.9=
45  __xnpod_schedule+0x834 (xnpod_suspend_thread+0x281)=0A:|  #*func       =
          -12    0.495  xntimer_get_overruns+0x8 (xnpod_wait_thread_period+=
0x14c)=0A:|  #*func                 -11    0.307  __ipipe_restore_pipeline_=
head+0x7 (xnpod_wait_thread_period+0x1cb)=0A:|  +*end     0x80000000   -11+=
   1.526  __ipipe_restore_pipeline_head+0x137 (xnpod_wait_thread_period+0x1=
cb)=0A:|  +*begin   0x80000001   -10    0.442  __ipipe_dispatch_event+0x1d9=
 (__ipipe_syscall_root+0xcd)=0A:|  +*end     0x80000001    -9    0.341  __i=
pipe_dispatch_event+0x3f0 (__ipipe_syscall_root+0xcd)=0A:|  +*begin   0x800=
00001    -9+   4.351  __ipipe_syscall_root+0xec (__ipipe_syscall_root_thunk=
+0x35)=0A:   +*func                  -5    0.322  __ipipe_syscall_root+0x11=
 (__ipipe_syscall_root_thunk+0x35)=0A:   +*func                  -4    0.20=
2  __ipipe_dispatch_event+0x11 (__ipipe_syscall_root+0xcd)=0A:|  +*begin   =
0x80000001    -4    0.510  __ipipe_dispatch_event+0x34 (__ipipe_syscall_roo=
t+0xcd)=0A:|  +*end     0x80000001    -3    0.266  __ipipe_dispatch_event+0=
x1a6 (__ipipe_syscall_root+0xcd)=0A:   +*func                  -3    0.791 =
 hisyscall_event+0x11 (__ipipe_dispatch_event+0x1b7)=0A:   +*func          =
        -2    0.528  xnshadow_sys_trace+0x7 (hisyscall_event+0x151)=0A:   +=
*func                  -2    0.300  ipipe_trace_frozen_reset+0xb (xnshadow_=
sys_trace+0x69)=0A:   +*func                  -2    0.199  __ipipe_global_p=
ath_lock+0x4 (ipipe_trace_frozen_reset+0x1c)=0A:   +*func                  =
-1    0.187  __ipipe_spin_lock_irqsave+0xb (__ipipe_global_path_lock+0x15)=
=0A:|  +*begin   0x80000001    -1+   1.226  __ipipe_spin_lock_irqsave+0x2a =
(__ipipe_global_path_lock+0x15)=0A:|  #*func                   0    0.262  =
__ipipe_spin_unlock_irqcomplete+0xb (__ipipe_global_path_unlock+0x7d)=0A:| =
 +*end     0x80000001     0    0.229  __ipipe_spin_unlock_irqcomplete+0xcf =
(__ipipe_global_path_unlock+0x7d)=0A<   +*freeze  0x001f3e65     0    0.225=
  xnshadow_sys_trace+0x73 (hisyscall_event+0x151)=0A |  +*begin   0x8000000=
1     0    0.251  __ipipe_dispatch_event+0x1d9 (__ipipe_syscall_root+0xcd)=
=0A |  +*end     0x80000001     0    0.214  __ipipe_dispatch_event+0x3f0 (_=
_ipipe_syscall_root+0xcd)=0A |  +*begin   0x80000001     0    0.708  __ipip=
e_syscall_root+0xec (__ipipe_syscall_root_thunk+0x35)=0A    +*func         =
          1    0.199  __ipipe_syscall_root+0x11 (__ipipe_syscall_root_thunk=
+0x35)=0A    +*func                   1    0.183  __ipipe_dispatch_event+0x=
11 (__ipipe_syscall_root+0xcd)=0A |  +*begin   0x80000001     1    0.262  _=
_ipipe_dispatch_event+0x34 (__ipipe_syscall_root+0xcd)=0A |  +*end     0x80=
000001     2    0.199  __ipipe_dispatch_event+0x1a6 (__ipipe_syscall_root+0=
xcd)=0A    +*func                   2    0.352  hisyscall_event+0x11 (__ipi=
pe_dispatch_event+0x1b7)=0A    +*func                   2    0.281  __rt_ta=
sk_wait_period+0xb (hisyscall_event+0x151)=0A    +*func                   2=
    0.000  rt_task_wait_period+0x4 (__rt_task_wait_period+0x1c)=0A
------=_20101015125451000000_53276
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<font face=3D"arial" size=3D"2">I am also finding that tasks are frequently=
 hanging, causing ipipe=0Atraces with "INFO: task xxx:xxx blocked for more =
than 120 seconds". I=0Ahave just had this with apt-get update, and was prev=
iously getting it=0Awith grub-install. Could this be related?<br>=0A<br>=0A=
Thanks again<br><br>On Friday, 15 October, 2010 10:21am, edward.robbins@domain.hid=
ordtechnologies.co.uk said:<br><br><font size=3D"2" face=3D"arial">On Satur=
day, 4 September, 2010 9:51am, "Philippe Gerum" &lt;rpm@xenomai.org&gt; sai=
d:<br><br>&gt; On Fri, 2010-09-03 at 17:30 +0100,<br>&gt; edward.robbins@domain.hid=
fordtechnologies.co.uk wrote:<br>&gt; &gt; Today I have tried using the int=
el video driver with the option "NoAccel",<br>&gt; and that seems to stop t=
he high latencies; with this option I can kill X, restart<br>&gt; it, and r=
un glxgears without issues, all while compiling the linux kernel and<br>&gt=
; having xeno-test or latency running. The highest latency I have gotten so=
 far is<br>&gt; 18uS.<br>&gt; &gt;<br>&gt; &gt; However, if anyone is inter=
ested I have made a trace without the NoAccel<br>&gt; option, when the late=
ncy jumped to 1113uS upon starting X, attached.<br>&gt; &gt;<br>&gt; <br>&g=
t; Please try this patch. Your trace log reveals that we are only virtually=
<br>&gt; masking interrupts while flushing the TLB, which is quite wrong.<b=
r>&gt; <br><br>Hi Phillipe,<br><br>I have tried the patch, and the only not=
iceable difference is that now when I have the NoAccel option set I am gett=
ing high latencies when I make actions such as killing the X server. Below =
is the ipipe trace. I presume this is going to be a problem even if I am no=
t running X?<br><br>Thanks again,<br>Edward<br><br>I-pipe frozen back-traci=
ng service on 2.6.32.15-xenomai-2.5.4/ipipe-2.7-01<br>---------------------=
---------------------------------------<br>CPU: 0, Freeze: 4761785881144 cy=
cles, Trace Points: 100 (+10)<br>Calibrated minimum trace-point overhead: 0=
.131 us<br><br>&nbsp;+----- Hard IRQs ('|': locked)<br>&nbsp;|+---- &lt;unu=
sed&gt;<br>&nbsp;||+--- &lt;unused&gt;<br>&nbsp;|||+-- Xenomai<br>&nbsp;|||=
|+- Linux ('*': domain stalled, '+': current, '#': current+stalled)<br>&nbs=
p;|||||&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +---=
------- Delay flag ('+': &gt; 1 us, '!': &gt; 10 us)<br>&nbsp;|||||&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; +- NMI noise ('N')<br>&nbsp;|||||&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; |<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type&nbsp;&nbsp;&nbsp; =
User Val.&nbsp;&nbsp; Time&nbsp;&nbsp;&nbsp; Delay&nbsp; Function (Parent)<=
br>:|&nbsp; # func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; -2144&nbsp;&nbsp;&nbsp; 0.326&nbsp; __phys_addr=
+0x4 (__xnpod_schedule+0x562)<br>:|&nbsp; # func&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2143&nbsp;&nbsp;=
&nbsp; 0.390&nbsp; __switch_to_xtra+0x8 (__switch_to+0x255)<br>:|&nbsp; # [=
 3276] Xorg&nbsp;&nbsp;&nbsp; -1 -2143&nbsp;&nbsp;&nbsp; 0.427&nbsp; __xnpo=
d_schedule+0x834 (xnintr_clock_handler+0x130)<br>:|&nbsp;&nbsp; +func&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; -2143&nbsp;&nbsp;&nbsp; 0.408&nbsp; __ipipe_walk_pipeline+0x11 (__ipipe=
_dispatch_wired_nocheck+0x1da)<br>:|&nbsp;&nbsp; +end&nbsp;&nbsp;&nbsp;&nbs=
p; 0x000000f6 -2142&nbsp;&nbsp;&nbsp; 0.416&nbsp; common_interrupt+0x39 (de=
bug_smp_processor_id+0x97)<br>:|&nbsp;&nbsp; +begin&nbsp;&nbsp; 0x80000001 =
-2142&nbsp;&nbsp;&nbsp; 0.240&nbsp; debug_smp_processor_id+0x44 (smp_call_f=
unction_single+0x122)<br>:|&nbsp;&nbsp; +end&nbsp;&nbsp;&nbsp;&nbsp; 0x8000=
0001 -2141&nbsp;&nbsp;&nbsp; 0.262&nbsp; debug_smp_processor_id+0x94 (smp_c=
all_function_single+0x122)<br>:&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2141&nbsp=
;&nbsp;&nbsp; 0.221&nbsp; generic_exec_single+0x11 (smp_call_function_singl=
e+0x160)<br>:&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2141&nbsp;&nbsp;&nbsp; 0.19=
5&nbsp; _spin_lock_irqsave+0x7 (generic_exec_single+0x3d)<br>:&nbsp;&nbsp;&=
nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; -2141&nbsp;&nbsp;&nbsp; 0.195&nbsp; ipipe_check_contex=
t+0x11 (_spin_lock_irqsave+0x1b)<br>:|&nbsp;&nbsp; +begin&nbsp;&nbsp; 0x800=
00001 -2141&nbsp;&nbsp;&nbsp; 0.262&nbsp; ipipe_check_context+0x33 (_spin_l=
ock_irqsave+0x1b)<br>:|&nbsp;&nbsp; +end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001=
 -2140&nbsp;&nbsp;&nbsp; 0.244&nbsp; ipipe_check_context+0xda (_spin_lock_i=
rqsave+0x1b)<br>:&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2140&nbsp;&nbsp;&nbsp; =
0.206&nbsp; add_preempt_count+0x9 (_spin_lock_irqsave+0x4c)<br>:&nbsp;&nbsp=
;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; -2140&nbsp;&nbsp;&nbsp; 0.202&nbsp; ipipe_check_cont=
ext+0x11 (add_preempt_count+0x1c)<br>:|&nbsp;&nbsp; #begin&nbsp;&nbsp; 0x80=
000001 -2140&nbsp;&nbsp;&nbsp; 0.259&nbsp; ipipe_check_context+0x33 (add_pr=
eempt_count+0x1c)<br>:|&nbsp;&nbsp; #end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001=
 -2139&nbsp;&nbsp;&nbsp; 0.251&nbsp; ipipe_check_context+0xda (add_preempt_=
count+0x1c)<br>:&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2139&nbsp;&nbsp;&nbsp; 0=
.195&nbsp; _spin_unlock_irqrestore+0x4 (generic_exec_single+0x5d)<br>:&nbsp=
;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; -2139&nbsp;&nbsp;&nbsp; 0.191&nbsp; __ipipe_re=
store_root+0xb (_spin_unlock_irqrestore+0x21)<br>:|&nbsp;&nbsp; #begin&nbsp=
;&nbsp; 0x80000001 -2139&nbsp;&nbsp;&nbsp; 0.236&nbsp; __ipipe_restore_root=
+0x2d (_spin_unlock_irqrestore+0x21)<br>:|&nbsp;&nbsp; #end&nbsp;&nbsp;&nbs=
p;&nbsp; 0x80000001 -2139&nbsp;&nbsp;&nbsp; 0.236&nbsp; __ipipe_restore_roo=
t+0x7d (_spin_unlock_irqrestore+0x21)<br>:&nbsp;&nbsp;&nbsp; #func&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 -2138&nbsp;&nbsp;&nbsp; 0.191&nbsp; __ipipe_unstall_root+0x9 (__ipipe_rest=
ore_root+0xb1)<br>:|&nbsp;&nbsp; #begin&nbsp;&nbsp; 0x80000000 -2138&nbsp;&=
nbsp;&nbsp; 0.266&nbsp; __ipipe_unstall_root+0x20 (__ipipe_restore_root+0xb=
1)<br>:|&nbsp;&nbsp; +end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000 -2138&nbsp;&nb=
sp;&nbsp; 0.213&nbsp; __ipipe_unstall_root+0xce (__ipipe_restore_root+0xb1)=
<br>:&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2138&nbsp;&nbsp;&nbsp; 0.206&nbsp; =
sub_preempt_count+0x9 (_spin_unlock_irqrestore+0x2b)<br>:&nbsp;&nbsp;&nbsp;=
 +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; -2137&nbsp;&nbsp;&nbsp; 0.206&nbsp; ipipe_check_context+0x1=
1 (sub_preempt_count+0x1c)<br>:|&nbsp;&nbsp; +begin&nbsp;&nbsp; 0x80000001 =
-2137&nbsp;&nbsp;&nbsp; 0.259&nbsp; ipipe_check_context+0x33 (sub_preempt_c=
ount+0x1c)<br>:|&nbsp;&nbsp; +end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001 -2137&=
nbsp;&nbsp;&nbsp; 0.255&nbsp; ipipe_check_context+0xda (sub_preempt_count+0=
x1c)<br>:&nbsp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2137&nbsp;&nbsp;&nbsp; 0.221&nb=
sp; native_send_call_func_single_ipi+0x4 (generic_exec_single+0x6b)<br>:&nb=
sp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2136&nbsp;&nbsp;&nbsp; 0.199&nbsp; flat_sen=
d_IPI_mask+0x11 (native_send_call_func_single_ipi+0x34)<br>:|&nbsp;&nbsp; +=
begin&nbsp;&nbsp; 0x80000001 -2136&nbsp;&nbsp;&nbsp; 0.247&nbsp; flat_send_=
IPI_mask+0x36 (native_send_call_func_single_ipi+0x34)<br>:|&nbsp;&nbsp; +en=
d&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001 -2136&nbsp;&nbsp;&nbsp; 0.228&nbsp; fl=
at_send_IPI_mask+0x8e (native_send_call_func_single_ipi+0x34)<br>:&nbsp;&nb=
sp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; -2136&nbsp;&nbsp;&nbsp; 0.206&nbsp; sub_preempt_co=
unt+0x9 (smp_call_function_single+0x173)<br>:&nbsp;&nbsp;&nbsp; +func&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; -2136&nbsp;&nbsp;&nbsp; 0.191&nbsp; ipipe_check_context+0x11 (sub_preem=
pt_count+0x1c)<br>:|&nbsp;&nbsp; +begin&nbsp;&nbsp; 0x80000001 -2135&nbsp;&=
nbsp;&nbsp; 0.244&nbsp; ipipe_check_context+0x33 (sub_preempt_count+0x1c)<b=
r>:|&nbsp;&nbsp; +end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001 -2135&nbsp;&nbsp;&=
nbsp; 0.262&nbsp; ipipe_check_context+0xda (sub_preempt_count+0x1c)<br>:&nb=
sp;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2135&nbsp;&nbsp;&nbsp; 0.191&nbsp; sub_pree=
mpt_count+0x9 (smp_call_function+0x47)<br>:&nbsp;&nbsp;&nbsp; +func&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; -2135&nbsp;&nbsp;&nbsp; 0.187&nbsp; ipipe_check_context+0x11 (sub_preempt=
_count+0x1c)<br>:|&nbsp;&nbsp; +begin&nbsp;&nbsp; 0x80000001 -2135&nbsp;&nb=
sp;&nbsp; 0.244&nbsp; ipipe_check_context+0x33 (sub_preempt_count+0x1c)<br>=
:|&nbsp;&nbsp; +end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001 -2134&nbsp;&nbsp;&nb=
sp; 0.232&nbsp; ipipe_check_context+0xda (sub_preempt_count+0x1c)<br>:&nbsp=
;&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; -2134&nbsp;&nbsp;&nbsp; 0.187&nbsp; ipipe_chec=
k_context+0x11 (set_mtrr+0x77)<br>:|&nbsp;&nbsp; +begin&nbsp;&nbsp; 0x80000=
001 -2134&nbsp;&nbsp;&nbsp; 0.251&nbsp; ipipe_check_context+0x33 (set_mtrr+=
0x77)<br>:|&nbsp;&nbsp; +end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001 -2134!&nbsp=
; 10.477&nbsp; ipipe_check_context+0xda (set_mtrr+0x77)<br>:&nbsp;&nbsp;&nb=
sp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; -2123&nbsp;&nbsp;&nbsp; 0.206&nbsp; generic_set_mtrr+0x1=
1 (set_mtrr+0xdc)<br>:&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2123&nbsp;&nbsp;&n=
bsp; 0.202&nbsp; ipipe_check_context+0x11 (generic_set_mtrr+0x42)<br>:|&nbs=
p;&nbsp; #begin&nbsp;&nbsp; 0x80000001 -2123&nbsp;&nbsp;&nbsp; 0.262&nbsp; =
ipipe_check_context+0x33 (generic_set_mtrr+0x42)<br>:|&nbsp;&nbsp; #end&nbs=
p;&nbsp;&nbsp;&nbsp; 0x80000001 -2122&nbsp;&nbsp;&nbsp; 0.259&nbsp; ipipe_c=
heck_context+0xda (generic_set_mtrr+0x42)<br>:|&nbsp;&nbsp; #begin&nbsp;&nb=
sp; 0x80000001 -2122&nbsp;&nbsp;&nbsp; 0.221&nbsp; generic_set_mtrr+0x85 (s=
et_mtrr+0xdc)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2122&nbsp;&nbsp;&nbsp; 0.19=
9&nbsp; prepare_set+0x4 (generic_set_mtrr+0x8a)<br>:|&nbsp;&nbsp; #func&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; -2122&nbsp;&nbsp;&nbsp; 0.213&nbsp; _spin_lock+0x9 (prepare_set+0x15)=
<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2122&nbsp;&nbsp;&nbsp; 0.191&nbsp; add_p=
reempt_count+0x9 (_spin_lock+0x1b)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2121! =
1840.932&nbsp; ipipe_check_context+0x11 (add_preempt_count+0x1c)<br>:|&nbsp=
;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; -280!&nbsp; 55.546&nbsp; mtrr_wrmsr+0xd (prepa=
re_set+0x79)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -225!&nbsp; 53.303&nbsp=
; mtrr_wrmsr+0xd (generic_set_mtrr+0x111)<br>:|&nbsp;&nbsp; #func&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; -172!&nbsp; 52.380&nbsp; mtrr_wrmsr+0xd (generic_set_mtrr+0x129)<br>:=
|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -119!&nbsp; 50.782&nbsp; post_set+0x4 (g=
eneric_set_mtrr+0x12e)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -68!&nb=
sp; 40.665&nbsp; mtrr_wrmsr+0xd (post_set+0x25)<br>:|&nbsp;&nbsp; #func&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; -28+&nbsp;&nbsp; 1.185&nbsp; _spin_unlock+0x4 (post_set+0=
x4f)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -27&nbsp;&nbsp;&nbsp; 0.3=
56&nbsp; sub_preempt_count+0x9 (_spin_unlock+0x15)<br>:|&nbsp;&nbsp; #func&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; -26&nbsp;&nbsp;&nbsp; 0.900&nbsp; ipipe_check_context+=
0x11 (sub_preempt_count+0x1c)<br>:|&nbsp;&nbsp; #end&nbsp;&nbsp;&nbsp;&nbsp=
; 0x80000001&nbsp;&nbsp; -25+&nbsp;&nbsp; 1.050&nbsp; generic_set_mtrr+0x13=
f (set_mtrr+0xdc)<br>:|&nbsp;&nbsp; #begin&nbsp;&nbsp; 0x000000f6&nbsp;&nbs=
p; -24&nbsp;&nbsp;&nbsp; 0.566&nbsp; common_interrupt+0x20 (generic_set_mtr=
r+0x142)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -24&nbsp;&nbsp;&nbsp;=
 0.468&nbsp; __ipipe_handle_irq+0x11 (common_interrupt+0x27)<br>:|&nbsp;&nb=
sp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -23&nbsp;&nbsp;&nbsp; 0.266&nbsp; irq_to_des=
c+0x4 (__ipipe_handle_irq+0x134)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; -23&nbsp;&nbsp;&nbsp; 0.397&nbsp; __ipipe_ack_apic+0x4 (__ipipe_handle_i=
rq+0x13c)<br>:|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -23&nbsp;&nbsp;&nbsp=
; 0.465&nbsp; native_apic_mem_write+0x4 (__ipipe_ack_apic+0x1d)<br>:|&nbsp;=
&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -22&nbsp;&nbsp;&nbsp; 0.348&nbsp; __ipipe=
_dispatch_wired+0xd (__ipipe_handle_irq+0x147)<br>:|&nbsp;&nbsp; #func&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; -22&nbsp;&nbsp;&nbsp; 0.450&nbsp; __ipipe_dispatch_wired_n=
ocheck+0x11 (__ipipe_dispatch_wired+0xba)<br>:|&nbsp; #*func&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; -21&nbsp;&nbsp;&nbsp; 0.634&nbsp; xnintr_clock_handler+0xb (__ipipe_=
dispatch_wired_nocheck+0x12b)<br>:|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -21&n=
bsp;&nbsp;&nbsp; 0.892&nbsp; xntimer_tick_aperiodic+0xb (xnintr_clock_handl=
er+0x81)<br>:|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -20&nbsp;&nbsp;&nbsp; 0.35=
2&nbsp; xnthread_periodic_handler+0x4 (xntimer_tick_aperiodic+0x8d)<br>:|&n=
bsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -19&nbsp;&nbsp;&nbsp; 0.585&nbsp; xnpod_re=
sume_thread+0x11 (xnthread_periodic_handler+0x2d)<br>:|&nbsp; #*[ 3272] -&l=
t;?&gt;-&nbsp;&nbsp; 99&nbsp;&nbsp; -19&nbsp;&nbsp;&nbsp; 0.682&nbsp; xnpod=
_resume_thread+0xfa (xnthread_periodic_handler+0x2d)<br>:|&nbsp; #*func&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; -18&nbsp;&nbsp;&nbsp; 0.318&nbsp; xntimer_next_local_shot=
+0x9 (xntimer_tick_aperiodic+0x191)<br>:|&nbsp; #*event&nbsp;&nbsp; tick@domain.hid=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -18&nbsp;&nbsp;&nbsp; 0.285&nbsp; xntimer_ne=
xt_local_shot+0xb0 (xntimer_tick_aperiodic+0x191)<br>:|&nbsp; #*func&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; -18&nbsp;&nbsp;&nbsp; 0.420&nbsp; native_apic_mem_write+0x4 =
(xntimer_next_local_shot+0xe5)<br>:|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -17&=
nbsp;&nbsp;&nbsp; 0.517&nbsp; __xnpod_schedule+0x11 (xnintr_clock_handler+0=
x130)<br>:|&nbsp; #*[ 3276] Xorg&nbsp;&nbsp;&nbsp; -1&nbsp;&nbsp; -17&nbsp;=
&nbsp;&nbsp; 0.296&nbsp; __xnpod_schedule+0x189 (xnintr_clock_handler+0x130=
)<br>:|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -16+&nbsp;&nbsp; 1.601&nbsp; xnsc=
hed_pick_next+0x4 (__xnpod_schedule+0x1e3)<br>:|&nbsp; #*func&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; -15+&nbsp;&nbsp; 1.091&nbsp; __phys_addr+0x4 (__xnpod_schedule+0x56=
2)<br>:|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -14&nbsp;&nbsp;&nbsp; 0.697&nbsp=
; __switch_to_xtra+0x8 (__switch_to+0x255)<br>:|&nbsp; #*[ 3272] -&lt;?&gt;=
-&nbsp;&nbsp; 99&nbsp;&nbsp; -13&nbsp;&nbsp;&nbsp; 0.945&nbsp; __xnpod_sche=
dule+0x834 (xnpod_suspend_thread+0x281)<br>:|&nbsp; #*func&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; -12&nbsp;&nbsp;&nbsp; 0.495&nbsp; xntimer_get_overruns+0x8 (xnpod_wait=
_thread_period+0x14c)<br>:|&nbsp; #*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -11&nbsp;&nbs=
p;&nbsp; 0.307&nbsp; __ipipe_restore_pipeline_head+0x7 (xnpod_wait_thread_p=
eriod+0x1cb)<br>:|&nbsp; +*end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000&nbsp;&nbs=
p; -11+&nbsp;&nbsp; 1.526&nbsp; __ipipe_restore_pipeline_head+0x137 (xnpod_=
wait_thread_period+0x1cb)<br>:|&nbsp; +*begin&nbsp;&nbsp; 0x80000001&nbsp;&=
nbsp; -10&nbsp;&nbsp;&nbsp; 0.442&nbsp; __ipipe_dispatch_event+0x1d9 (__ipi=
pe_syscall_root+0xcd)<br>:|&nbsp; +*end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&=
nbsp;&nbsp;&nbsp; -9&nbsp;&nbsp;&nbsp; 0.341&nbsp; __ipipe_dispatch_event+0=
x3f0 (__ipipe_syscall_root+0xcd)<br>:|&nbsp; +*begin&nbsp;&nbsp; 0x80000001=
&nbsp;&nbsp;&nbsp; -9+&nbsp;&nbsp; 4.351&nbsp; __ipipe_syscall_root+0xec (_=
_ipipe_syscall_root_thunk+0x35)<br>:&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; -5&nbsp;&nbsp;&nbsp; 0.322&nbsp; __ipipe_syscall_root+0x11 (__ipipe=
_syscall_root_thunk+0x35)<br>:&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; -4&nbsp;&nbsp;&nbsp; 0.202&nbsp; __ipipe_dispatch_event+0x11 (__ipipe_sys=
call_root+0xcd)<br>:|&nbsp; +*begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp=
; -4&nbsp;&nbsp;&nbsp; 0.510&nbsp; __ipipe_dispatch_event+0x34 (__ipipe_sys=
call_root+0xcd)<br>:|&nbsp; +*end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&=
nbsp;&nbsp; -3&nbsp;&nbsp;&nbsp; 0.266&nbsp; __ipipe_dispatch_event+0x1a6 (=
__ipipe_syscall_root+0xcd)<br>:&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; -3&nbsp;&nbsp;&nbsp; 0.791&nbsp; hisyscall_event+0x11 (__ipipe_dispatch_=
event+0x1b7)<br>:&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2&nbsp;&nb=
sp;&nbsp; 0.528&nbsp; xnshadow_sys_trace+0x7 (hisyscall_event+0x151)<br>:&n=
bsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2&nbsp;&nbsp;&nbsp; 0.300&nbs=
p; ipipe_trace_frozen_reset+0xb (xnshadow_sys_trace+0x69)<br>:&nbsp;&nbsp; =
+*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2&nbsp;&nbsp;&nbsp; 0.199&nbsp; __ipipe_=
global_path_lock+0x4 (ipipe_trace_frozen_reset+0x1c)<br>:&nbsp;&nbsp; +*fun=
c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; -1&nbsp;&nbsp;&nbsp; 0.187&nbsp; __ipipe_spin_=
lock_irqsave+0xb (__ipipe_global_path_lock+0x15)<br>:|&nbsp; +*begin&nbsp;&=
nbsp; 0x80000001&nbsp;&nbsp;&nbsp; -1+&nbsp;&nbsp; 1.226&nbsp; __ipipe_spin=
_lock_irqsave+0x2a (__ipipe_global_path_lock+0x15)<br>:|&nbsp; #*func&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0.262&nbsp; __ipipe_spin_un=
lock_irqcomplete+0xb (__ipipe_global_path_unlock+0x7d)<br>:|&nbsp; +*end&nb=
sp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp=
; 0.229&nbsp; __ipipe_spin_unlock_irqcomplete+0xcf (__ipipe_global_path_unl=
ock+0x7d)<br>&lt;&nbsp;&nbsp; +*freeze&nbsp; 0x001f3e65&nbsp;&nbsp;&nbsp;&n=
bsp; 0&nbsp;&nbsp;&nbsp; 0.225&nbsp; xnshadow_sys_trace+0x73 (hisyscall_eve=
nt+0x151)<br>&nbsp;|&nbsp; +*begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;=
&nbsp; 0&nbsp;&nbsp;&nbsp; 0.251&nbsp; __ipipe_dispatch_event+0x1d9 (__ipip=
e_syscall_root+0xcd)<br>&nbsp;|&nbsp; +*end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000=
001&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0.214&nbsp; __ipipe_dispatc=
h_event+0x3f0 (__ipipe_syscall_root+0xcd)<br>&nbsp;|&nbsp; +*begin&nbsp;&nb=
sp; 0x80000001&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0.708&nbsp; __ip=
ipe_syscall_root+0xec (__ipipe_syscall_root_thunk+0x35)<br>&nbsp;&nbsp;&nbs=
p; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; 0.199&nbsp; =
__ipipe_syscall_root+0x11 (__ipipe_syscall_root_thunk+0x35)<br>&nbsp;&nbsp;=
&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; 0.183&nb=
sp; __ipipe_dispatch_event+0x11 (__ipipe_syscall_root+0xcd)<br>&nbsp;|&nbsp=
; +*begin&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp=
; 0.262&nbsp; __ipipe_dispatch_event+0x34 (__ipipe_syscall_root+0xcd)<br>&n=
bsp;|&nbsp; +*end&nbsp;&nbsp;&nbsp;&nbsp; 0x80000001&nbsp;&nbsp;&nbsp;&nbsp=
; 2&nbsp;&nbsp;&nbsp; 0.199&nbsp; __ipipe_dispatch_event+0x1a6 (__ipipe_sys=
call_root+0xcd)<br>&nbsp;&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 2&nbsp;&nbsp;&nbsp; 0.352&nbsp; hisyscall_event+0x11 (__ipipe_dispatch_e=
vent+0x1b7)<br>&nbsp;&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
&nbsp;&nbsp;&nbsp; 0.281&nbsp; __rt_task_wait_period+0xb (hisyscall_event+0=
x151)<br>&nbsp;&nbsp;&nbsp; +*func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;=
&nbsp;&nbsp; 0.000&nbsp; rt_task_wait_period+0x4 (__rt_task_wait_period+0x1=
c)<br></font></font>
------=_20101015125451000000_53276--


