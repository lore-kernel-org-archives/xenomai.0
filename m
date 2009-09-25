MIME-Version: 1.0
Date: Fri, 25 Sep 2009 16:27:09 -0300
Message-ID: <7a15153d0909251227y598abd0fmb4297cb2614b13af@domain.hid>
From: Felipe Castro <felipecpc1@domain.hid>
Content-Type: multipart/alternative; boundary=0016364d1f0d2d475d04746bef1c
Subject: [Xenomai-help] High CPU Load
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

--0016364d1f0d2d475d04746bef1c
Content-Type: text/plain; charset=ISO-8859-1

Hi guys ...

I wrote a simple code just to learn how to deal with real time tasks, but
there is something wrong .....
the code is working , and my tasks running , but the processor load is to
high 98% ....

#include <stdio.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/timer.h>

void periodic_1(void *arg);
void periodic_refresh (void *arg);
void refreshScreen();

#define TASK_PRIORITY     99     //Priority
#define TASK_PRIORITY2     95     //Priority
#define TASK_MODE    0
#define TASK_STACKSIZE    0

#define TASK_PERIOD    10 * 1000000 //10ms
#define TASK_PERIOD2    1000 * 1000000 //5ms

RT_TASK td,task2;

void periodic_refresh (void *arg){
    unsigned long over;
    int err2 =
rt_task_set_periodic(NULL,TM_NOW,rt_timer_ns2ticks(TASK_PERIOD2));

    for(;;){
        err2 = rt_task_wait_period(&over);
        if(err2)break;

        }
}

void periodic_1(void *arg){

    unsigned long over1;
    int err1 =
rt_task_set_periodic(NULL,TM_NOW,rt_timer_ns2ticks(TASK_PERIOD));

        for(;;){
        err1 = rt_task_wait_period(&over1);
        if(err1)break;
    }
}

int main (int argc, char *argv[]){

    int err=0,err2=0;

    mlockall(MCL_CURRENT|MCL_FUTURE);

    err=rt_task_spawn(&td,
"serialRead",TASK_STACKSIZE,TASK_PRIORITY,TASK_MODE,&periodic_1,NULL);
    err2=rt_task_spawn(&task2,
"refresh",TASK_STACKSIZE,TASK_PRIORITY2,TASK_MODE,&periodic_refresh,NULL);

    if(!err && !err2){

                refreshScreen();
                for(;;){}
                rt_task_delete(&td);
                rt_task_delete(&task2);

    }

    return 0;
}


 void refreshScreen(void){

    system("reset");

printf("|---------------------------------------------------------------------------------------|\n");
    printf("| Xenomai
Task
|\n");

printf("|---------------------------------------------------------------------------------------|\n\n\n");
    printf("Press ctrl+c to finish ...\n");

 }

Thanks

--0016364d1f0d2d475d04746bef1c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi guys ... <br><br>I wrote a simple code just to learn how to deal with re=
al time tasks, but there is something wrong .....<br> the code is working ,=
 and my tasks running , but the processor load is to high 98% ....<br><br>
#include &lt;stdio.h&gt;<br>#include &lt;sys/mman.h&gt;<br>#include &lt;nat=
ive/task.h&gt;<br>#include &lt;native/timer.h&gt;<br><br>void periodic_1(vo=
id *arg);<br>void periodic_refresh (void *arg);<br>void refreshScreen();<br=
>
<br>#define TASK_PRIORITY =A0=A0=A0 99 =A0=A0=A0 //Priority<br>#define TASK=
_PRIORITY2 =A0=A0=A0 95 =A0=A0=A0 //Priority<br>#define TASK_MODE=A0=A0=A0 =
0<br>#define TASK_STACKSIZE=A0=A0=A0 0<br><br>#define TASK_PERIOD=A0=A0=A0 =
10 * 1000000 //10ms<br>#define TASK_PERIOD2=A0=A0=A0 1000 * 1000000 //5ms<b=
r>
<br>RT_TASK td,task2;<br><br>void periodic_refresh (void *arg){<br>=A0=A0=
=A0 unsigned long over;<br>=A0=A0=A0 int err2 =3D rt_task_set_periodic(NULL=
,TM_NOW,rt_timer_ns2ticks(TASK_PERIOD2));<br>=A0=A0=A0=A0=A0=A0=A0 <br>=A0=
=A0=A0 for(;;){<br>=A0=A0=A0 =A0=A0=A0 err2 =3D rt_task_wait_period(&amp;ov=
er);<br>
=A0=A0=A0 =A0=A0=A0 if(err2)break;<br><br>=A0=A0=A0=A0=A0=A0=A0 }<br>}<br><=
br>void periodic_1(void *arg){<br>=A0=A0=A0 <br>=A0=A0=A0 unsigned long ove=
r1;<br>=A0=A0=A0 int err1 =3D rt_task_set_periodic(NULL,TM_NOW,rt_timer_ns2=
ticks(TASK_PERIOD));<br><br>=A0=A0=A0=A0=A0=A0=A0 for(;;){<br>
=A0=A0=A0 =A0=A0=A0 err1 =3D rt_task_wait_period(&amp;over1);<br>=A0=A0=A0 =
=A0=A0=A0 if(err1)break;<br>=A0=A0=A0 }<br>}<br><br>int main (int argc, cha=
r *argv[]){<br><br>=A0=A0=A0 int err=3D0,err2=3D0;<br><br>=A0=A0=A0 mlockal=
l(MCL_CURRENT|MCL_FUTURE);<br><br>=A0=A0=A0 err=3Drt_task_spawn(&amp;td, &q=
uot;serialRead&quot;,TASK_STACKSIZE,TASK_PRIORITY,TASK_MODE,&amp;periodic_1=
,NULL);<br>
=A0=A0=A0 err2=3Drt_task_spawn(&amp;task2, &quot;refresh&quot;,TASK_STACKSI=
ZE,TASK_PRIORITY2,TASK_MODE,&amp;periodic_refresh,NULL);<br><br>=A0=A0=A0 i=
f(!err &amp;&amp; !err2){<br><br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 refreshScreen();<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for(;=
;){}<br>
=A0=A0=A0 =A0=A0 =A0 =A0 =A0 =A0=A0 rt_task_delete(&amp;td);<br>=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rt_task_delete(&amp;task2);<br>=A0=A0=
=A0 <br>=A0=A0=A0 }<br><br>=A0=A0=A0 return 0;<br>}<br><br><br>=A0void refr=
eshScreen(void){<br><br>=A0=A0=A0 system(&quot;reset&quot;);<br>=A0=A0=A0 p=
rintf(&quot;|--------------------------------------------------------------=
-------------------------|\n&quot;);<br>
=A0=A0=A0 printf(&quot;| Xenomai Task=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |\n&quot;);<br>=A0=A0=A0 printf(&quot;|--=
---------------------------------------------------------------------------=
----------|\n\n\n&quot;);<br>
=A0=A0=A0 printf(&quot;Press ctrl+c to finish ...\n&quot;);<br><br>=A0}<br>=
<br>Thanks<br>

--0016364d1f0d2d475d04746bef1c--

