Message-ID: <fd6a47a90601181204g4c86f778x@domain.hid>
Date: Wed, 18 Jan 2006 21:04:25 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3468_15604445.1137614665749"
Subject: [Xenomai-core] Scheduling while atomic
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_3468_15604445.1137614665749
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,


Apparently, the code I shared with Gilles never made it to this forum.
Anyway, the issue I'm having here is really a problem and it might be usefu=
l
if some of you could try it out or comment on it. I might be making a silly
programming error here, but the result is invariably erroneous operation or
kernel crashes.

The program creates a file dump.txt and has two independent threads trying
to access it and write a one or a zero there. Inside the writing routine,
which is accessed by both threads, a check is made to see if the access is
really locked. In my setup, I have tons of ALERTS popping up with this
program, meaning that something is wrong with my use of mutex. Could anyone
please check and see if a) it is correctly written and b) it fails as well
on their machine. It would allow me to focus my actions on the Xenomai setu=
p
(which I keep frozen this instant, in order to keep a possible bug
predictable) or on my own programming.

A second example is also included, which tries to achieve the same goal wit=
h
a semaphore (initialized to 1). That seems to work, but under heavy load
(tmax =3D 1.0e7), the kernel crashes.

Kernel: 2.6.15 Adeos: 1.1-03 gcc: 4.0.2 Ipipe tracing enabled

TIA

Jeroen.



/* TEST_MUTEX.C */

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>
#include <math.h>
#include <values.h>

#include <sys/mman.h>

#include <native/task.h>
#include <native/mutex.h>
#include <native/sem.h>

int fd, err;
RT_MUTEX m;
RT_SEM s;
float tmax =3D 1.0e7;

#define CHECK(arg) check(arg, __LINE__)

int check(int r, int n)
{
    if (r !=3D 0)
        fprintf(stderr, "L%d: %s.\n", n, strerror(-r));
    return(r);
}

void output(char c) {
    static int cnt =3D 0;
    int n;
    char buf[2];
    RT_MUTEX_INFO mutexinfo;

    buf[0] =3D c;

    if (cnt =3D=3D 80) {
        buf[1] =3D '\n';
        n =3D 2;
        cnt =3D 0;
    }
    else {
        n =3D 1;
        cnt++;
    }

    CHECK(rt_mutex_inquire(&m, &mutexinfo));
    if (mutexinfo.lockcnt <=3D 0) {
        RT_TASK_INFO taskinfo;
        CHECK(rt_task_inquire(NULL, &taskinfo));
        fprintf(stderr, "ALERT: No lock! (lockcnt=3D%d) Offending task: %s\=
n",
                mutexinfo.lockcnt, taskinfo.name);
    }

    if (write(fd, buf, n) !=3D n) {
        fprintf(stderr, "File write error.\n");
        CHECK(rt_sem_v(&s));
    }

}

void task0(void *arg)
{
    CHECK(rt_task_set_mode(T_PRIMARY, 0, NULL));
    while (1) {
        CHECK(rt_task_sleep((float)rand()*tmax/(float)RAND_MAX));
        CHECK(rt_mutex_lock(&m, TM_INFINITE));
        output('0');
        CHECK(rt_mutex_unlock(&m));
    }
}

void task1(void *arg)
{
    CHECK(rt_task_set_mode(T_PRIMARY, 0, NULL));
    while (1) {
        CHECK(rt_task_sleep((float)rand()*tmax/(float)RAND_MAX));
        CHECK(rt_mutex_lock(&m, TM_INFINITE));
        output('1');
        CHECK(rt_mutex_unlock(&m));
    }
}

void sighandler(int arg)
{
    CHECK(rt_sem_v(&s));
}

int main(int argc, char *argv[])
{
    RT_TASK t, t0, t1;

    if ((fd =3D open("dump.txt", O_CREAT | O_TRUNC | O_WRONLY)) < 0)
        fprintf(stderr, "File open error.\n");
    else {
        if (argc =3D=3D 2) {
            tmax =3D atof(argv[1]);
            if (tmax =3D=3D 0.0)
                tmax =3D 1.0e7;
        }
        if (mlockall(MCL_CURRENT | MCL_FUTURE) !=3D 0)
            printf("mlockall() error.\n");

        CHECK(rt_task_shadow(&t, "main", 1, T_FPU));

        CHECK(rt_timer_start(TM_ONESHOT));

        CHECK(rt_mutex_create(&m, "mutex"));
        CHECK(rt_sem_create(&s, "sem", 0, S_PRIO));

        signal(SIGINT, sighandler);

        CHECK(rt_task_create(&t0, "task0", 0, 30, T_FPU));
        CHECK(rt_task_start(&t0, task0, NULL));
        CHECK(rt_task_create(&t1, "task1", 0, 29, T_FPU));
        CHECK(rt_task_start(&t1, task1, NULL));

        printf("Running for %.2f seconds.\n", (float)MAXLONG/1.0e9);
        CHECK(rt_sem_p(&s, MAXLONG));
        signal(SIGINT, SIG_IGN);

        CHECK(rt_task_delete(&t1));
        CHECK(rt_task_delete(&t1));
        CHECK(rt_task_delete(&t0));

        CHECK(rt_sem_delete(&s));
        CHECK(rt_mutex_delete(&m));

        rt_timer_stop();

        close(fd);
    }
    return 0;
}

/**************************************************************************=
***********/

/* TEST_SEM.C */

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>
#include <math.h>
#include <values.h>

#include <sys/mman.h>

#include <native/task.h>
#include <native/sem.h>

int fd, err;
RT_SEM s, m;
float tmax =3D 1.0e9;

#define CHECK(arg) check(arg, __LINE__)

int check(int r, int n)
{
    if (r !=3D 0)
        fprintf(stderr, "L%d: %s.\n", n, strerror(-r));
    return(r);
}

void output(char c) {
    static int cnt =3D 0;
    int n;
    char buf[2];
    RT_SEM_INFO seminfo;

    buf[0] =3D c;

    if (cnt =3D=3D 80) {
        buf[1] =3D '\n';
        n =3D 2;
        cnt =3D 0;
    }
    else {
        n =3D 1;
        cnt++;
    }

    CHECK(rt_sem_inquire(&m, &seminfo));
    if (seminfo.count !=3D 0) {
        RT_TASK_INFO taskinfo;
        CHECK(rt_task_inquire(NULL, &taskinfo));
        fprintf(stderr, "ALERT: No lock! (count=3D%ld) Offending task: %s\n=
",
                seminfo.count, taskinfo.name);
    }

    if (write(fd, buf, n) !=3D n) {
        fprintf(stderr, "File write error.\n");
        CHECK(rt_sem_v(&s));
    }

}

void task0(void *arg)
{
    CHECK(rt_task_set_mode(T_PRIMARY, 0, NULL));
    while (1) {
        CHECK(rt_task_sleep((float)rand()*tmax/(float)RAND_MAX));
        CHECK(rt_sem_p(&m, TM_INFINITE));
        output('0');
        CHECK(rt_sem_v(&m));
    }
}

void task1(void *arg)
{
    CHECK(rt_task_set_mode(T_PRIMARY, 0, NULL));
    while (1) {
        CHECK(rt_task_sleep((float)rand()*tmax/(float)RAND_MAX));
        CHECK(rt_sem_p(&m, TM_INFINITE));
        output('1');
        CHECK(rt_sem_v(&m));
    }
}

void sighandler(int arg)
{
    CHECK(rt_sem_v(&s));
}

int main(int argc, char *argv[])
{
    RT_TASK t, t0, t1;

    if ((fd =3D open("dump.txt", O_CREAT | O_TRUNC | O_WRONLY)) < 0)
        fprintf(stderr, "File open error.\n");
    else {
        if (argc =3D=3D 2) {
            tmax =3D atof(argv[1]);
            if (tmax =3D=3D 0.0)
                tmax =3D 1.0e7;
        }
        if (mlockall(MCL_CURRENT | MCL_FUTURE) !=3D 0)
            printf("mlockall() error.\n");

        CHECK(rt_task_shadow(&t, "main", 1, T_FPU));

        CHECK(rt_timer_start(TM_ONESHOT));

        CHECK(rt_sem_create(&m, "mutex", 1, S_PRIO));
        CHECK(rt_sem_create(&s, "sem", 0, S_PRIO));

        signal(SIGINT, sighandler);

        CHECK(rt_task_create(&t0, "task0", 0, 30, T_FPU));
        CHECK(rt_task_start(&t0, task0, NULL));
        CHECK(rt_task_create(&t1, "task1", 0, 29, T_FPU));
        CHECK(rt_task_start(&t1, task1, NULL));

        printf("Running for %.2f seconds.\n", (float)MAXLONG/1.0e9);
        CHECK(rt_sem_p(&s, MAXLONG));
        signal(SIGINT, SIG_IGN);

        CHECK(rt_task_delete(&t1));
        CHECK(rt_task_delete(&t1));
        CHECK(rt_task_delete(&t0));

        CHECK(rt_sem_delete(&s));
        CHECK(rt_sem_delete(&m));

        rt_timer_stop();

        close(fd);
    }
    return 0;
}

------=_Part_3468_15604445.1137614665749
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hello,</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Apparently, the code I shared with Gilles never made it to this forum.=
 Anyway, the issue I'm having here is really a problem and it might be usef=
ul if some of you could try it out or comment on it. I might be making a si=
lly programming error here, but the result is invariably erroneous operatio=
n or kernel crashes.
</div>
<div>&nbsp;</div>
<div>The program creates a file dump.txt and has two independent threads tr=
ying to access it and write a one or a zero there. Inside the writing routi=
ne, which is accessed by both threads, a check is made to see if the access=
 is really locked. In my setup, I have tons of ALERTS popping up with this =
program, meaning that something is wrong with my use of mutex. Could anyone=
 please check and see if a) it is correctly written and b) it fails as well=
 on their machine. It would allow me to focus my actions on the Xenomai set=
up (which I keep frozen this instant, in order to keep a possible bug predi=
ctable) or on my own programming.
</div>
<div>&nbsp;</div>
<div>A second example is also included, which tries to achieve the same goa=
l with a semaphore (initialized to 1). That seems to work, but under heavy =
load (tmax =3D 1.0e7), the kernel crashes.</div>
<div>&nbsp;</div>
<div>Kernel: 2.6.15 Adeos: 1.1-03 gcc: 4.0.2 Ipipe tracing enabled</div>
<div>&nbsp;</div>
<div>TIA</div>
<div>&nbsp;</div>
<div>Jeroen.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div><font size=3D"2">
<p>/* TEST_MUTEX.C */</p>
<p>#include &lt;stdlib.h&gt;<br>#include &lt;stdio.h&gt;<br>#include &lt;un=
istd.h&gt;<br>#include &lt;fcntl.h&gt;<br>#include &lt;signal.h&gt;<br>#inc=
lude &lt;math.h&gt;<br>#include &lt;values.h&gt;</p>
<p>#include &lt;sys/mman.h&gt;</p>
<p>#include &lt;native/task.h&gt;<br>#include &lt;native/mutex.h&gt;<br>#in=
clude &lt;native/sem.h&gt;</p>
<p>int fd, err;<br>RT_MUTEX m;<br>RT_SEM s;<br>float tmax =3D 1.0e7;</p>
<p>#define CHECK(arg) check(arg, __LINE__)</p>
<p>int check(int r, int n)<br>{<br>&nbsp;&nbsp;&nbsp; if (r !=3D 0)<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;L%d: %s.\n&quo=
t;, n, strerror(-r));<br>&nbsp;&nbsp;&nbsp; return(r);<br>}</p>
<p>void output(char c) {<br>&nbsp;&nbsp;&nbsp; static int cnt =3D 0;<br>&nb=
sp;&nbsp;&nbsp; int n;<br>&nbsp;&nbsp;&nbsp; char buf[2];<br>&nbsp;&nbsp;&n=
bsp; RT_MUTEX_INFO mutexinfo;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; =
buf[0] =3D c;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; if (cnt =3D=3D 8=
0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf[1] =3D '\n';<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n =3D 2;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cnt =3D 0;<br>&nbsp;&nbsp;&n=
bsp; }<br>&nbsp;&nbsp;&nbsp; else {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; n =3D 1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cnt++;<br>&nb=
sp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; CHECK(rt_mut=
ex_inquire(&amp;m, &amp;mutexinfo));<br>&nbsp;&nbsp;&nbsp; if (mutexinfo.lo=
ckcnt &lt;=3D 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RT_TASK_IN=
FO taskinfo;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_inquire(NULL, =
&amp;taskinfo));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stde=
rr, &quot;ALERT: No lock! (lockcnt=3D%d) Offending task: %s\n&quot;,<br>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; mutexinfo.lockcnt, <a href=3D"http://taskinfo.name">taskinfo.n=
ame
</a>);<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; if (w=
rite(fd, buf, n) !=3D n) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fp=
rintf(stderr, &quot;File write error.\n&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; CHECK(rt_sem_v(&amp;s));<br>&nbsp;&nbsp;&nbsp; }<br>&nbs=
p;&nbsp;&nbsp; <br>}</p>
<p>void task0(void *arg)<br>{<br>&nbsp;&nbsp;&nbsp; CHECK(rt_task_set_mode(=
T_PRIMARY, 0, NULL));<br>&nbsp;&nbsp;&nbsp; while (1) {<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_sleep((float)rand()*tmax/(float)RA=
ND_MAX));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_mutex_lock=
(&amp;m, TM_INFINITE));
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; output('0');<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_mutex_unlock(&amp;m));<br>&nbsp;&nb=
sp;&nbsp; }<br>}</p>
<p>void task1(void *arg)<br>{<br>&nbsp;&nbsp;&nbsp; CHECK(rt_task_set_mode(=
T_PRIMARY, 0, NULL));<br>&nbsp;&nbsp;&nbsp; while (1) {<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_sleep((float)rand()*tmax/(float)RA=
ND_MAX));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_mutex_lock=
(&amp;m, TM_INFINITE));
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; output('1');<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_mutex_unlock(&amp;m));<br>&nbsp;&nb=
sp;&nbsp; }<br>}</p>
<p>void sighandler(int arg)<br>{<br>&nbsp;&nbsp;&nbsp; CHECK(rt_sem_v(&amp;=
s));<br>}</p>
<p>int main(int argc, char *argv[])<br>{<br>&nbsp;&nbsp;&nbsp; RT_TASK t, t=
0, t1;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; if ((fd =3D open(&quot;=
dump.txt&quot;, O_CREAT | O_TRUNC | O_WRONLY)) &lt; 0)<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;File open error.\n&quot;);<=
br>
&nbsp;&nbsp;&nbsp; else {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(argc =3D=3D 2) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; tmax =3D atof(argv[1]);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmax =3D=3D 0.0)<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tma=
x =3D 1.0e7;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mlockall(MCL_CURRENT | MCL_FUTURE) !=3D=
 0)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
rintf(&quot;mlockall() error.\n&quot;);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; CHECK(rt_task_shadow(&amp;t, &quot;main&quot;, 1, T_FPU)=
);</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_timer_start(TM_ONESH=
OT));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_mutex_create(&amp;m, &quot;mutex&quot;));<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_sem_create(&amp;s, &=
quot;sem&quot;, 0, S_PRIO));</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signal(SIGINT, sighandler);<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; CHECK(rt_task_create(&amp;t0, &quot;task0&quot;, 0, 30, T_=
FPU));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_start(&a=
mp;t0, task0, NULL));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(r=
t_task_create(&amp;t1, &quot;task1&quot;, 0, 29, T_FPU));
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_start(&amp;t1,=
 task1, NULL));</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Running for %.2f=
 seconds.\n&quot;, (float)MAXLONG/1.0e9);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; CHECK(rt_sem_p(&amp;s, MAXLONG));<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; signal(SIGINT, SIG_IGN);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_=
delete(&amp;t1));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_delete(&amp;t1));<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_delete(&amp;t0)=
);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; CHECK(rt_sem_delete(&amp;s));<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; CHECK(rt_mutex_delete(&amp;m));<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_=
timer_stop();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; close(fd);<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; ret=
urn 0;<br>}</p>
<p>/***********************************************************************=
**************/&nbsp;</p></font></div>
<div><font size=3D"2">
<p>/* TEST_SEM.C */</p>
<p>#include &lt;stdlib.h&gt;<br>#include &lt;stdio.h&gt;<br>#include &lt;un=
istd.h&gt;<br>#include &lt;fcntl.h&gt;<br>#include &lt;signal.h&gt;<br>#inc=
lude &lt;math.h&gt;<br>#include &lt;values.h&gt;</p>
<p>#include &lt;sys/mman.h&gt;</p>
<p>#include &lt;native/task.h&gt;<br>#include &lt;native/sem.h&gt;</p>
<p>int fd, err;<br>RT_SEM s, m;<br>float tmax =3D 1.0e9;</p>
<p>#define CHECK(arg) check(arg, __LINE__)</p>
<p>int check(int r, int n)<br>{<br>&nbsp;&nbsp;&nbsp; if (r !=3D 0)<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;L%d: %s.\n&quo=
t;, n, strerror(-r));<br>&nbsp;&nbsp;&nbsp; return(r);<br>}</p>
<p>void output(char c) {<br>&nbsp;&nbsp;&nbsp; static int cnt =3D 0;<br>&nb=
sp;&nbsp;&nbsp; int n;<br>&nbsp;&nbsp;&nbsp; char buf[2];<br>&nbsp;&nbsp;&n=
bsp; RT_SEM_INFO seminfo;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; buf[=
0] =3D c;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; if (cnt =3D=3D 80) {=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf[1] =3D '\n';<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n =3D 2;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cnt =3D 0;<br>&nbsp;&nbsp;&nbsp;=
 }<br>&nbsp;&nbsp;&nbsp; else {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; n =3D 1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cnt++;<br>&nbsp;&=
nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; CHECK(rt_sem_inq=
uire(&amp;m, &amp;seminfo));<br>&nbsp;&nbsp;&nbsp; if (seminfo.count !=3D 0=
) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RT_TASK_INFO taskinfo;<br=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_inquire(NULL, &am=
p;taskinfo));
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;ALERT:=
 No lock! (count=3D%ld) Offending task: %s\n&quot;,<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; semi=
nfo.count, <a href=3D"http://taskinfo.name">taskinfo.name</a>);<br>&nbsp;&n=
bsp;&nbsp; }<br>&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; if (write(fd, buf, n) !=
=3D n) {
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;File w=
rite error.\n&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(r=
t_sem_v(&amp;s));<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; <br>}</p>
<p>void task0(void *arg)<br>{<br>&nbsp;&nbsp;&nbsp; CHECK(rt_task_set_mode(=
T_PRIMARY, 0, NULL));<br>&nbsp;&nbsp;&nbsp; while (1) {<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_sleep((float)rand()*tmax/(float)RA=
ND_MAX));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_sem_p(&amp=
;m, TM_INFINITE));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; output('0');<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_sem_v(&amp;m));<br>&nbsp;&nbsp;&nbsp; }=
<br>}</p>
<p>void task1(void *arg)<br>{<br>&nbsp;&nbsp;&nbsp; CHECK(rt_task_set_mode(=
T_PRIMARY, 0, NULL));<br>&nbsp;&nbsp;&nbsp; while (1) {<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_sleep((float)rand()*tmax/(float)RA=
ND_MAX));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_sem_p(&amp=
;m, TM_INFINITE));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; output('1');<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_sem_v(&amp;m));<br>&nbsp;&nbsp;&nbsp; }=
<br>}</p>
<p>void sighandler(int arg)<br>{<br>&nbsp;&nbsp;&nbsp; CHECK(rt_sem_v(&amp;=
s));<br>}</p>
<p>int main(int argc, char *argv[])<br>{<br>&nbsp;&nbsp;&nbsp; RT_TASK t, t=
0, t1;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; if ((fd =3D open(&quot;=
dump.txt&quot;, O_CREAT | O_TRUNC | O_WRONLY)) &lt; 0)<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;File open error.\n&quot;);<=
br>
&nbsp;&nbsp;&nbsp; else {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(argc =3D=3D 2) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; tmax =3D atof(argv[1]);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmax =3D=3D 0.0)<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tma=
x =3D 1.0e7;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mlockall(MCL_CURRENT | MCL_FUTURE) !=3D=
 0)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
rintf(&quot;mlockall() error.\n&quot;);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; CHECK(rt_task_shadow(&amp;t, &quot;main&quot;, 1, T_FPU)=
);</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_timer_start(TM_ONESH=
OT));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_sem_create(&amp;m, &quot;mutex&quot;, 1, S=
_PRIO));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_sem_create(=
&amp;s, &quot;sem&quot;, 0, S_PRIO));</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signal(SIGINT, sighandler);<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; CHECK(rt_task_create(&amp;t0, &quot;task0&quot;, 0, 30, T_=
FPU));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_start(&a=
mp;t0, task0, NULL));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(r=
t_task_create(&amp;t1, &quot;task1&quot;, 0, 29, T_FPU));
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_start(&amp;t1,=
 task1, NULL));</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Running for %.2f=
 seconds.\n&quot;, (float)MAXLONG/1.0e9);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; CHECK(rt_sem_p(&amp;s, MAXLONG));<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; signal(SIGINT, SIG_IGN);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_=
delete(&amp;t1));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_delete(&amp;t1));<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_delete(&amp;t0)=
);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; CHECK(rt_sem_delete(&amp;s));<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; CHECK(rt_sem_delete(&amp;m));<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_ti=
mer_stop();<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(fd);<br>&nbsp;&nbsp;&n=
bsp; }<br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br></p></font></div>

------=_Part_3468_15604445.1137614665749--

