MIME-Version: 1.0
Date: Mon, 24 Jan 2011 10:54:50 +0100
Message-ID: <AANLkTi=ba-NePDr0bem0yFuZfV7TwXubF3HQSNLV8bxY@mail.gmail.com>
From: Charles Clerdan <charles.clerdan@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6434bd640db05049a9497aa
Subject: [Xenomai-help] Detect switch in secondary mode + mlockall = bug?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, armadeus-forum@domain.hid

--0016e6434bd640db05049a9497aa
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I'm trying to catch the signal SIGXCPU, in order to know when a task goes in
secondary mode.
I would like to know, why I have to comment the fonction mlockall.

PS : The problem is not related to the Code, but, there is a piece of it :

#include "config.h"
#include <native/task.h>
#include <stdio.h>
#include <assert.h>
#include <signal.h>


void WorkingTask (void* cookie)
{
   while (1) {};
}

static RT_TASK Rt_Work_Task;

void go (void * cookie)
{
   printf("Test for switch : %d\r\n",(int)rt_task_self());
}

  void warn_upon_switch(int sig __attribute__((unused)))
{
   printf("/!\\ Secondary Mode /!\\ : ");
}

int main (void)
{
   RT_TASK Rt_main_task;
   int erreur;

   /* Pagination Locked */
  // mlockall( MCL_CURRENT | MCL_FUTURE );   <- This is the line which makes
my question


    signal(SIGXCPU, warn_upon_switch);

    /* Real-Time Task */
    rt_task_spawn (&Rt_main_task, "go", 2048, 20, T_FPU | T_JOINABLE,
&go,&Rt_main_task);

    /* Waiting for the end */
    rt_task_join(&Rt_main_task);

    return 0;
}

Regards,

Charles

--0016e6434bd640db05049a9497aa
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I&#39;m trying to catch the signal SIGXCPU, in order to know whe=
n a task goes in secondary mode. <br>I would like to know, why I have to co=
mment the fonction mlockall.<br><br>PS : The problem is not related to the =
Code, but, there is a piece of it :<br>

<br>#include &quot;config.h&quot;<br>#include &lt;native/task.h&gt;<br>#inc=
lude &lt;stdio.h&gt;<br>#include &lt;assert.h&gt;<br>#include &lt;signal.h&=
gt;<br><br><br>void WorkingTask (void* cookie)<br>{<br>=A0=A0 while (1) {};=
<br>

}<br><br>static RT_TASK Rt_Work_Task;<br><br>void go (void * cookie) <br>{<=
br>=A0=A0 printf(&quot;Test for switch : %d\r\n&quot;,(int)rt_task_self());=
<br>}<br>=A0 <br>=A0 void warn_upon_switch(int sig __attribute__((unused)))=
<br>

{<br>=A0=A0 printf(&quot;/!\\ Secondary Mode /!\\ : &quot;);<br>} <br><br>i=
nt main (void)<br>{<br>=A0=A0 RT_TASK Rt_main_task;<br>=A0=A0 int erreur;<b=
r>=A0=A0 <br>=A0=A0 /* Pagination Locked */<br>=A0 // mlockall( MCL_CURRENT=
 | MCL_FUTURE );=A0=A0 &lt;- This is the line which makes my question<br>

=A0=A0 <br><br>=A0 =A0 signal(SIGXCPU, warn_upon_switch);<br><br>=A0=A0=A0 =
/* Real-Time Task */<br>=A0=A0=A0 rt_task_spawn (&amp;Rt_main_task, &quot;g=
o&quot;, 2048, 20, T_FPU | T_JOINABLE, &amp;go,&amp;Rt_main_task);<br>=A0=
=A0=A0 <br>=A0=A0=A0 /* Waiting for the end */<br>

=A0=A0=A0 rt_task_join(&amp;Rt_main_task);<br>=A0=A0=A0 <br>=A0=A0=A0 retur=
n 0;<br>}<br><br>Regards,<br><br>Charles<br><br>

--0016e6434bd640db05049a9497aa--

