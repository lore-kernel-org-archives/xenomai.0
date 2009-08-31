MIME-Version: 1.0
In-Reply-To: <4A982D08.4050802@domain.hid>
References: <7a15153d0908281050l56343b26g45a8f66b87c839e9@domain.hid>
	<4A981B54.4020908@domain.hid> <4A981C1E.8000904@domain.hid>
	<7a15153d0908281209i5b133c53l4fa816993df7d0eb@domain.hid>
	<4A982D08.4050802@domain.hid>
Date: Mon, 31 Aug 2009 11:53:14 -0300
Message-ID: <7a15153d0908310753s68f36dffg817df3cb9a16db06@domain.hid>
From: Felipe Castro <felipecpc1@domain.hid>
Content-Type: multipart/alternative; boundary=001485f6c7888a810a0472713107
Subject: Re: [Xenomai-core] [PXA + Xenomai] Latency program
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--001485f6c7888a810a0472713107
Content-Type: text/plain; charset=ISO-8859-1

hi !

I apllied the patch that you sent me, but there are some weird!
When i run latency program the result is:

root@domain.hid$ /usr/xenomai/bin/latency
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:02  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|      83.384|     146.769|     189.538|    1803|      83.384|
189.538


And than the program just freeze, and the kernel trace:

[  780.136217] Xenomai: Switching display-343 to secondary mode after
exception #5 from user-space at 0x93e0 (pid 345)
[  780.169608] Xenomai: registered exported object dispsem-345 (semaphores)
[  783.284333] Xenomai: watchdog triggered -- killing runaway thread
'sampling-343'

I did a software to test, like this :

#include <stdio.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/timer.h>


void periodic_serialRead (void *arg);


#define TASK_PRIORITY     99     //Priority
#define TASK_MODE    0
#define TASK_STACKSIZE    0

#define TASK_PERIOD    69444 // 69,4us

RT_TASK td;

void periodic_serialRead (void *arg){
    int i1=0;
    unsigned long over1;
    int err1 =
rt_task_set_periodic(NULL,TM_NOW,rt_timer_ns2ticks(TASK_PERIOD));

    for(;;){
        err1 = rt_task_wait_period(&over1);
        if(err1)break;
        printf(" Task Active - Reading -> %d\n",i1++);

    }
}

int main (int argc, char *argv[]){



    int err=0;

    mlockall(MCL_CURRENT|MCL_FUTURE);

    err=rt_task_spawn(&td,
"serialRead",TASK_STACKSIZE,TASK_PRIORITY,TASK_MODE,&periodic_serialRead,NULL);


    if(!err){
        printf("Press any key to finish ... \n ");
        getchar();

        rt_task_delete(&td);

    }

    return 0;
}

if i set a long time interval for my task , for example 500ms it works fine,
but if i put a small value like 70us , the software just freeze.

Can you help ?

Thanks in advance.

On Fri, Aug 28, 2009 at 4:16 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Felipe Castro wrote:
> > Well , i found the topic, but I'm using kernel 2.6.27 with xenomai 2.4.8
> and
> > the code to be patched is a little bit different. I dont't know how to do
> ,
> > can you help me ?
>
> The code has not changed, but I think my patch was mangled, please try
> the attached one.
>
>
> --
>                                             Gilles.
>

--001485f6c7888a810a0472713107
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi ! <br><br>I apllied the patch that you sent me, but there are some weird=
!<br>When i run latency program the result is:<br><br>root@domain.hid$ /=
usr/xenomai/bin/latency <br>=3D=3D Sampling period: 100 us<br>=3D=3D Test m=
ode: periodic user-mode task<br>
=3D=3D All results in microseconds<br>warming up...<br>RTT|=A0 00:00:02=A0 =
(periodic user-mode task, 100 us period, priority 99)<br>RTH|-----lat min|-=
----lat avg|-----lat max|-overrun|----lat best|---lat worst<br>RTD|=A0=A0=
=A0=A0=A0 83.384|=A0=A0=A0=A0 146.769|=A0=A0=A0=A0 189.538|=A0=A0=A0 1803|=
=A0=A0=A0=A0=A0 83.384|=A0=A0=A0=A0 189.538<br>
<br><br>And than the program just freeze, and the kernel trace:<br><br>[=A0=
 780.136217] Xenomai: Switching display-343 to secondary mode after excepti=
on #5 from user-space at 0x93e0 (pid 345)<br>[=A0 780.169608] Xenomai: regi=
stered exported object dispsem-345 (semaphores)<br>
[=A0 783.284333] Xenomai: watchdog triggered -- killing runaway thread &#39=
;sampling-343&#39;<br><br>I did a software to test, like this :<br><br>#inc=
lude &lt;stdio.h&gt;<br>#include &lt;sys/mman.h&gt;<br>#include &lt;native/=
task.h&gt;<br>
#include &lt;native/timer.h&gt;<br><br><br>void periodic_serialRead (void *=
arg);<br><br><br>#define TASK_PRIORITY =A0=A0=A0 99 =A0=A0=A0 //Priority<br=
>#define TASK_MODE=A0=A0=A0 0<br>#define TASK_STACKSIZE=A0=A0=A0 0<br><br>#=
define TASK_PERIOD=A0=A0=A0 69444 // 69,4us<br>
<br>RT_TASK td;<br><br>void periodic_serialRead (void *arg){<br>=A0=A0=A0 i=
nt i1=3D0;<br>=A0=A0=A0 unsigned long over1;<br>=A0=A0=A0 int err1 =3D rt_t=
ask_set_periodic(NULL,TM_NOW,rt_timer_ns2ticks(TASK_PERIOD));<br><br>=A0=A0=
=A0 for(;;){<br>=A0=A0=A0 =A0=A0=A0 err1 =3D rt_task_wait_period(&amp;over1=
);<br>
=A0=A0=A0 =A0=A0=A0 if(err1)break;<br>=A0=A0=A0 =A0=A0=A0 printf(&quot; Tas=
k Active - Reading -&gt; %d\n&quot;,i1++);<br><br>=A0=A0=A0 }<br>}<br><br>i=
nt main (int argc, char *argv[]){<br><br><br><br>=A0=A0=A0 int err=3D0;<br>=
<br>=A0=A0=A0 mlockall(MCL_CURRENT|MCL_FUTURE);<br>
<br>=A0=A0=A0 err=3Drt_task_spawn(&amp;td, &quot;serialRead&quot;,TASK_STAC=
KSIZE,TASK_PRIORITY,TASK_MODE,&amp;periodic_serialRead,NULL);<br>=A0=A0=A0 =
<br><br>=A0=A0=A0 if(!err){<br>=A0=A0=A0 =A0=A0=A0 printf(&quot;Press any k=
ey to finish ... \n &quot;);<br>
=A0=A0=A0 =A0=A0=A0 getchar();<br><br>=A0=A0=A0 =A0=A0=A0 rt_task_delete(&a=
mp;td);<br>=A0=A0=A0 <br>=A0=A0=A0 }<br><br>=A0=A0=A0 return 0;<br>}<br><br=
>if i set a long time interval for my task , for example 500ms it works fin=
e, but if i put a small value like 70us , the software just freeze. <br>
<br>Can you help ?<br><br>Thanks in advance. <br><br><div class=3D"gmail_qu=
ote">On Fri, Aug 28, 2009 at 4:16 PM, Gilles Chanteperdrix <span dir=3D"ltr=
">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperd=
rix@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>Felipe Castro wrote:<br>
&gt; Well , i found the topic, but I&#39;m using kernel 2.6.27 with xenomai=
 2.4.8 and<br>
&gt; the code to be patched is a little bit different. I dont&#39;t know ho=
w to do ,<br>
&gt; can you help me ?<br>
<br>
</div>The code has not changed, but I think my patch was mangled, please tr=
y<br>
the attached one.<br>
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--001485f6c7888a810a0472713107--

