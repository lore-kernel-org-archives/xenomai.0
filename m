Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA1F4B.D826973C"
Date: Mon, 17 Aug 2009 17:03:14 +0200
Message-ID: <EB48F2CADC239E44A8598CC0B0571102E4A9BE@XVS-DCFR-21.europe.corp.altran.com>
From: =?iso-8859-1?Q?Berruer_S=E9bastien?= <sebastien.berruer@domain.hid>
Subject: [Xenomai-help] Native message queue and synchronisation
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA1F4B.D826973C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I'm trying to make some basic test code using the native API of Xenomai. =
I declare two tasks (a consumer and a producer) and one queue from the =
main.
 - the producer get the system time and pass it throw a named queue
 - the consumer is supposed to block on the queue, waiting until the =
value is available in the queue

I issue a problem around the call to rt_queue_read().
 - when I run the actual code, the application hangs. As if, there were =
no means for mesure_task to write in the queue.
 - if I comment the sleep in the mesure_task and uncomment the one in =
display_task, the sleep is long enough (!) for data to be written and =
so, the call is issued correctly.

The parameter TM_INFINITE seems to be the cause. I can't figure why =
because, in the documentation, it's supposed to be rescheduled if there =
is no message yet.

I include my code and hope you can point me out what I am doing wrong.
I'm running a kernel 2.6.28 with Xenomai 2.4.8 on an ARM architecture =
(PXA255).

Best regards,





#include <stdlib.h>
#include <sys/mman.h>
#include <native/queue.h>
#include <native/task.h>
#include <native/timer.h>

#define ONE_BILLION     1000000000
#define ONE_MILLION     1000000
#define LOOP_NB         10
#define LOOP_DELAY      2 * ONE_BILLION

char queue_name[] =3D "exchange_data";

void display(void* cookie)
{
        RT_QUEUE disp_q;
        RTIME disp;
        int err, ret;

        err =3D rt_queue_bind(&disp_q, queue_name, TM_INFINITE);
        if(err) {
                perror("Unable to find the queue");
                return;
        }

        /*put a delay to be sure that other task write something*/
        /*rt_task_sleep(LOOP_DELAY);*/

        ret =3D rt_queue_read(&disp_q, (void*)&disp, sizeof(RTIME), =
TM_INFINITE);
        if(ret < 0)
                perror("Error reading");
        else
                printf("Value read from the queue: %lli\n", disp);

        err =3D rt_queue_unbind(&disp_q);
        if(err !=3D 0) {
                perror("Unable to release the queue");
                return;
        }

        return;
}

void mesure(void* cookie)
{
        RTIME date;
        RT_QUEUE mes_q;
        int err, ret;

        err =3D rt_queue_bind(&mes_q, queue_name, TM_INFINITE);
        if(err) {
                perror("Unable to find the queue");
                return;
        }

        /*put a delay to be sure that other task block on queue*/
        rt_task_sleep(LOOP_DELAY);

        date =3D rt_timer_read();

        ret =3D rt_queue_write(&mes_q, (void*)&date, sizeof(RTIME), =
Q_NORMAL);
        if(ret < 0)
                perror("Error writing");

        err =3D rt_queue_unbind(&mes_q);
        if(err !=3D 0) {
                perror("Unable to release the queue");
                return;
        }

        return;
}

int main(int argc, char* argv[])
{
        RT_QUEUE queue;
        RT_TASK display_task, mesure_task;
        int err;

        mlockall(MCL_CURRENT|MCL_FUTURE);

        err =3D rt_queue_create(&queue, queue_name, sizeof(int), =
Q_UNLIMITED, Q_FIFO|Q_SHARED);
        if(err) {
                perror("Unable to create the queue");
                exit(EXIT_FAILURE);
        }

        err =3D rt_task_create(&display_task, "display task", 0, 0, =
T_FPU|T_JOINABLE);
        err =3D rt_task_create(&mesure_task, "mesure task", 10, 0, =
T_FPU|T_JOINABLE);
        if(err) {
                perror("Unable to create a task");
                exit(EXIT_FAILURE);
        }

        err =3D rt_task_start(&display_task, &display, NULL);
        err =3D rt_task_start(&mesure_task, &mesure, NULL);
        if(err) {
                perror("Unable to start a task");
                exit(EXIT_FAILURE);
        }

        /*wait for terminaison of tasks*/
        rt_task_join(&mesure_task);
        rt_task_join(&display_task);

        /*delete all previously allocated ressources*/
        err =3D rt_task_delete(&display_task);
        err =3D rt_task_delete(&mesure_task);

        err =3D rt_queue_delete(&queue);

        exit(EXIT_SUCCESS);
}

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
| BERRUER S=E9bastien             |
| Trainee at Altran Ouest       |
| Centre d'Affaires Alphasis    |
| 35760 Saint-Gr=E9goire - FRANCE |
| Tel: 06-76-35-29-55           |
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D












------_=_NextPart_001_01CA1F4B.D826973C
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>Native message queue and synchronisation</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hello,<BR>
<BR>
I'm trying to make some basic test code using the native API of Xenomai. =
I declare two tasks (a consumer and a producer) and one queue from the =
main.<BR>
&nbsp;- the producer get the system time and pass it throw a named =
queue<BR>
&nbsp;- the consumer is supposed to block on the queue, waiting until =
the value is available in the queue<BR>
<BR>
I issue a problem around the call to rt_queue_read().<BR>
&nbsp;- when I run the actual code, the application hangs. As if, there =
were no means for mesure_task to write in the queue.<BR>
&nbsp;- if I comment the sleep in the mesure_task and uncomment the one =
in display_task, the sleep is long enough (!) for data to be written and =
so, the call is issued correctly.<BR>
<BR>
The parameter TM_INFINITE seems to be the cause. I can't figure why =
because, in the documentation, it's supposed to be rescheduled if there =
is no message yet.<BR>
<BR>
I include my code and hope you can point me out what I am doing =
wrong.<BR>
I'm running a kernel 2.6.28 with Xenomai 2.4.8 on an ARM architecture =
(PXA255).<BR>
<BR>
Best regards,<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
#include &lt;stdlib.h&gt;<BR>
#include &lt;sys/mman.h&gt;<BR>
#include &lt;native/queue.h&gt;<BR>
#include &lt;native/task.h&gt;<BR>
#include &lt;native/timer.h&gt;<BR>
<BR>
#define ONE_BILLION&nbsp;&nbsp;&nbsp;&nbsp; 1000000000<BR>
#define ONE_MILLION&nbsp;&nbsp;&nbsp;&nbsp; 1000000<BR>
#define LOOP_NB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10<BR>
#define LOOP_DELAY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 * ONE_BILLION<BR>
<BR>
char queue_name[] =3D &quot;exchange_data&quot;;<BR>
<BR>
void display(void* cookie)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RT_QUEUE disp_q;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTIME disp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err, ret;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
rt_queue_bind(&amp;disp_q, queue_name, TM_INFINITE);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(err) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; perror(&quot;Unable to find the queue&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*put a delay to be sure that =
other task write something*/<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/*rt_task_sleep(LOOP_DELAY);*/<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D =
rt_queue_read(&amp;disp_q, (void*)&amp;disp, sizeof(RTIME), =
TM_INFINITE);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(ret &lt; 0)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; perror(&quot;Error reading&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; printf(&quot;Value read from the queue: %lli\n&quot;, =
disp);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
rt_queue_unbind(&amp;disp_q);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(err !=3D 0) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; perror(&quot;Unable to release the queue&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<BR>
}<BR>
<BR>
void mesure(void* cookie)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTIME date;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RT_QUEUE mes_q;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err, ret;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
rt_queue_bind(&amp;mes_q, queue_name, TM_INFINITE);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(err) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; perror(&quot;Unable to find the queue&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*put a delay to be sure that =
other task block on queue*/<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_sleep(LOOP_DELAY);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; date =3D rt_timer_read();<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D =
rt_queue_write(&amp;mes_q, (void*)&amp;date, sizeof(RTIME), =
Q_NORMAL);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(ret &lt; 0)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; perror(&quot;Error writing&quot;);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
rt_queue_unbind(&amp;mes_q);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(err !=3D 0) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; perror(&quot;Unable to release the queue&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<BR>
}<BR>
<BR>
int main(int argc, char* argv[])<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RT_QUEUE queue;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RT_TASK display_task, =
mesure_task;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mlockall(MCL_CURRENT|MCL_FUTURE);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
rt_queue_create(&amp;queue, queue_name, sizeof(int), Q_UNLIMITED, =
Q_FIFO|Q_SHARED);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(err) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; perror(&quot;Unable to create the queue&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; exit(EXIT_FAILURE);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
rt_task_create(&amp;display_task, &quot;display task&quot;, 0, 0, =
T_FPU|T_JOINABLE);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
rt_task_create(&amp;mesure_task, &quot;mesure task&quot;, 10, 0, =
T_FPU|T_JOINABLE);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(err) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; perror(&quot;Unable to create a task&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; exit(EXIT_FAILURE);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
rt_task_start(&amp;display_task, &amp;display, NULL);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
rt_task_start(&amp;mesure_task, &amp;mesure, NULL);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(err) {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; perror(&quot;Unable to start a task&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; exit(EXIT_FAILURE);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*wait for terminaison of =
tasks*/<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_join(&amp;mesure_task);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_join(&amp;display_task);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*delete all previously =
allocated ressources*/<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
rt_task_delete(&amp;display_task);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
rt_task_delete(&amp;mesure_task);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
rt_queue_delete(&amp;queue);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(EXIT_SUCCESS);<BR>
}<BR>
<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<BR>
| BERRUER =
S=E9bastien&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |<BR>
| Trainee at Altran Ouest&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<BR>
| Centre d'Affaires Alphasis&nbsp;&nbsp;&nbsp; |<BR>
| 35760 Saint-Gr=E9goire - FRANCE |<BR>
| Tel: =
06-76-35-29-55&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |<BR>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA1F4B.D826973C--

