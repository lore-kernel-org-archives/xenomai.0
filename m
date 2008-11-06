Date: Thu, 6 Nov 2008 10:21:16 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1776528731-1225966876=:30595"
Message-ID: <442698.30595.qm@domain.hid>
Subject: [Xenomai-help] the exception saga - system hangs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--0-1776528731-1225966876=:30595
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0AI was trying to do custom exceptions handling for a xenomai task but=0AI=
 had problem of erratic hangs so I've done an example program to=0Areproduc=
e the behaviour.=0AThe user xenomai task causes an exception #13 when try t=
o execute a=0Aread in the eax of dr7 program register. The exception handle=
r will=0Aonly change the ip to the next instruction.=0A=0AAll seems to work=
 but after some loops (from 50 to 10000...=0Anot predictable) system hangs.=
 I can't figure the problem...=0Aif the problem isn't in my code maybe the =
problem is in adeos.=0A=0A[x86 32 bit - Xenomai 2.4.5 - Linux kernel `vanil=
la` 2.6.24-7, gcc 4.1.3]=0A-------------------------=0A =0AUser program=0A-=
------------------------=0A#include <stdio.h>=0A#include <sys/mman.h>=0A#in=
clude <native/task.h>=0A#include <rtdk.h>=0A=0A#define MODULE_TASK_NAME    =
"xtask_user"=0A#define TASK_PRIO  99=0A#define TASK_MODE  T_FPU|T_CPU(0)=0A=
#define TASK_STKSZ 4096=0A#define FIXED_PERIOD 2000000          /* 2 ms */=
=0A=0ART_TASK task_desc;=0A=0Avoid xeno_task(void *cookie)=0A{=0A  static l=
ong loop_count=3D0;=0A  for (;;loop_count++) {=0A    rt_task_wait_period(NU=
LL);=0A    rt_printf("Loop number: %ld\n", loop_count);=0A    /* Let's rais=
e an exception #13*/=0A    __asm__ __volatile__("nop; movl %dr7, %eax;nop")=
;=0A  }=0A}=0A =0Aint main(int argc, char *argv[])=0A{=0A    mlockall(MCL_C=
URRENT|MCL_FUTURE);=0A    rt_print_auto_init(1);=0A    rt_task_create(&task=
_desc, MODULE_TASK_NAME, TASK_STKSZ, TASK_PRIO, TASK_MODE);=0A    rt_task_s=
et_periodic(&task_desc, TM_NOW, rt_timer_ns2ticks(FIXED_PERIOD));=0A    rt_=
task_start(&task_desc,&xeno_task,NULL);=0A    pause();=0A    rt_task_delete=
(&task_desc);=0A}=0A-------------------------=0A Kernel module=0A----------=
---------------=0A#include <linux/module.h>=0A#include <rtdm/rtdm_driver.h>=
=0A#include <native/task.h>=0A#include <native/timer.h>=0A#include <native/=
intr.h>=0A=0AMODULE_AUTHOR(xxx");=0AMODULE_DESCRIPTION("xxx");=0AMODULE_LIC=
ENSE("GPL");                      =0A=0Astatic rthal_trap_handler_t old_tra=
p_handler;=0A=0Astatic int custom_trap_fault(unsigned event, unsigned domid=
, void *data)=0A{=0A  volatile short *istr;=0A  struct pt_regs *regs=3Ddata=
;=0A  xnthread_t *thread;=0A  if (event=3D=3D13) {=0A    if (!xnpod_active_=
p() ||=0A      (!xnpod_interrupt_p() && xnpod_idle_p()))=0A      goto xeno_=
handle;    =0A    if (!xnpod_shadow_p()) =0A      goto xeno_handle;    =0A =
   if (!xnpod_userspace_p())=0A      goto xeno_handle;    =0A    thread =3D=
 xnpod_current_thread();  =0A    if (!user_mode(regs)) /* not a user CS */=
=0A      goto xeno_handle;=0A    if (strcmp(thread->name,"xtask_user")!=3D0=
)=0A      goto xeno_handle;=0A    istr =3D (char *) (regs->x86reg_ip);=0A  =
  if (*istr =3D=3D 0x210f && (*(istr+1) & 0xFF) =3D=3D 0xf8) {=0A      /* m=
ovl %dr7, %eax */=0A      regs->x86reg_ip+=3D3; =0A      return RTHAL_EVENT=
_STOP;=0A    } =0A  }=0Axeno_handle: /* Xenomai will handle the event */=0A=
    return ((rthal_trap_handler_t) old_trap_handler)(event, domid, data);=
=0A}=0A=0Aint __init init_mymodule(void)=0A{=0A  old_trap_handler =3D rthal=
_trap_catch(&custom_trap_fault);=0A  return 0; // OK, adesso ho fatto! =0A}=
=0Avoid __exit cleanup_mymodule(void)=0A{=0A    rthal_trap_catch(old_trap_h=
andler);=0A}=0Amodule_init(init_mymodule);=0Amodule_exit(cleanup_mymodule);=
=0A=0A=0A      Unisciti alla community di Io fotografo e video, il nuovo co=
rso di fotografia di Gazzetta dello sport:=0Ahttp://www.flickr.com/groups/i=
ofotografoevideo
--0-1776528731-1225966876=:30595
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial,helvetica,sans-serif;font-size:10p=
t"><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"=
><br>I was trying to do custom exceptions handling for a xenomai task but<b=
r>I had problem of erratic hangs so I've done an example program to<br>repr=
oduce the behaviour.<br>The user xenomai task causes an exception #13 when =
try to execute a<br>read in the eax of dr7 program register. The exception =
handler will<br>only change the ip to the next instruction.<br><br>All seem=
s to work but after some loops (from 50 to 10000...<br>not predictable) sys=
tem hangs. I can't figure the problem...<br>if the problem isn't in my code=
 maybe the problem is in adeos.<br><br>=0A[x86 32 bit - Xenomai 2.4.5 - Lin=
ux kernel `vanilla` 2.6.24-7, gcc 4.1.3]<br>-------------------------<br>&n=
bsp;=0AUser program<br>=0A-------------------------<br>=0A#include &lt;stdi=
o.h&gt;<br>#include &lt;sys/mman.h&gt;<br>#include &lt;native/task.h&gt;<br=
>#include &lt;rtdk.h&gt;<br><br>#define MODULE_TASK_NAME&nbsp;&nbsp;&nbsp; =
"xtask_user"<br>#define TASK_PRIO&nbsp; 99<br>#define TASK_MODE&nbsp; T_FPU=
|T_CPU(0)<br>#define TASK_STKSZ 4096<br>#define FIXED_PERIOD 2000000&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 2 ms */<br><br>RT_TASK t=
ask_desc;<br><br>void xeno_task(void *cookie)<br>{<br>&nbsp; static long lo=
op_count=3D0;<br>&nbsp; for (;;loop_count++) {<br>&nbsp;&nbsp;&nbsp; rt_tas=
k_wait_period(NULL);<br>&nbsp;&nbsp;&nbsp; rt_printf("Loop number: %ld\n", =
loop_count);<br>&nbsp; &nbsp; /* Let's raise an exception #13*/<br>&nbsp;&n=
bsp;&nbsp; __asm__ __volatile__("nop; movl %dr7, %eax;nop");<br>&nbsp; }<br=
>}<br>&nbsp;<br>int main(int argc, char *argv[])<br>{<br>&nbsp;&nbsp;&nbsp;=
 mlockall(MCL_CURRENT|MCL_FUTURE);<br>&nbsp;&nbsp;&nbsp; rt_print_auto_init=
(1);<br>&nbsp; &nbsp; rt_task_create(&amp;task_desc,=0A MODULE_TASK_NAME, T=
ASK_STKSZ, TASK_PRIO, TASK_MODE);<br>&nbsp;&nbsp;&nbsp; rt_task_set_periodi=
c(&amp;task_desc, TM_NOW, rt_timer_ns2ticks(FIXED_PERIOD));<br>&nbsp;&nbsp;=
&nbsp; rt_task_start(&amp;task_desc,&amp;xeno_task,NULL);<br>&nbsp;&nbsp;&n=
bsp; pause();<br>&nbsp;&nbsp;&nbsp; rt_task_delete(&amp;task_desc);<br>}<br=
>-------------------------<br>&nbsp;Kernel module<br>----------------------=
---<br>#include &lt;linux/module.h&gt;<br>#include &lt;rtdm/rtdm_driver.h&g=
t;<br>#include &lt;native/task.h&gt;<br>#include &lt;native/timer.h&gt;<br>=
#include &lt;native/intr.h&gt;<br><br>MODULE_AUTHOR(xxx");<br>MODULE_DESCRI=
PTION("xxx");<br>MODULE_LICENSE("GPL");&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; <br><br>static rthal_trap_handler_t old_trap_handler;<br><b=
r>static int custom_trap_fault(unsigned event, unsigned domid, void *data)<=
br>{<br>&nbsp; volatile short *istr;<br>&nbsp;=0A struct pt_regs *regs=3Dda=
ta;<br>&nbsp; xnthread_t *thread;<br>&nbsp; if (event=3D=3D13) {<br>&nbsp;&=
nbsp;&nbsp; if (!xnpod_active_p() ||<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!xn=
pod_interrupt_p() &amp;&amp; xnpod_idle_p()))<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; goto xeno_handle;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; if (!xnpod_=
shadow_p()) <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto xeno_handle;&nbsp;&nbsp=
;&nbsp; <br>&nbsp;&nbsp;&nbsp; if (!xnpod_userspace_p())<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto xeno_handle;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; =
thread =3D xnpod_current_thread();&nbsp; <br>&nbsp;&nbsp;&nbsp; if (!user_m=
ode(regs)) /* not a user CS */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto xeno_=
handle;<br>&nbsp;&nbsp;&nbsp; if (strcmp(thread-&gt;name,"xtask_user")!=3D0=
)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto xeno_handle;<br>&nbsp;&nbsp;&nbsp;=
 istr =3D (char *) (regs-&gt;x86reg_ip);<br>&nbsp;&nbsp;&nbsp; if (*istr =
=3D=3D 0x210f &amp;&amp; (*(istr+1) &amp; 0xFF) =3D=3D 0xf8)=0A {<br>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; /* movl %dr7, %eax */<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; regs-&gt;x86reg_ip+=3D3;=0A<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
RTHAL_EVENT_STOP;<br>&nbsp;&nbsp;&nbsp; }=0A<br>&nbsp; }<br>xeno_handle: /*=
 Xenomai will handle the event */<br>&nbsp;&nbsp;&nbsp; return ((rthal_trap=
_handler_t) old_trap_handler)(event, domid, data);<br>}<br><br>int __init i=
nit_mymodule(void)<br>{<br>&nbsp; old_trap_handler =3D rthal_trap_catch(&am=
p;custom_trap_fault);<br>&nbsp; return 0; // OK, adesso ho fatto! <br>}<br>=
void __exit cleanup_mymodule(void)<br>{<br>&nbsp;&nbsp; &nbsp;rthal_trap_ca=
tch(old_trap_handler);<br>}<br>module_init(init_mymodule);<br>module_exit(c=
leanup_mymodule);<br><br></div></div><br>=0A=0A=0A=0A      <hr size=3D1><fo=
nt face=3D"Arial" size=3D"2">Scopri la community di Io fotografo e video<br=
>=0A<a href=3Dhttp://us.rd.yahoo.com/SIG=3D11ud6kror/**http%3A%2F%2Fwww.fli=
ckr.com%2Fgroups%2Fiofotografoevideo%2F>Il nuovo corso</a> di Gazzetta dell=
o sport per diventare veri fotografi!</font></body></html>
--0-1776528731-1225966876=:30595--

