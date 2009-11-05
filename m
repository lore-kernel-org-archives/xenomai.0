MIME-Version: 1.0
In-Reply-To: <4AF29E87.9090401@domain.hid>
References: <985eb86f0911050120l3a989588ida812a9394659a78@domain.hid>
	<4AF29E87.9090401@domain.hid>
Date: Thu, 5 Nov 2009 11:38:43 -0200
Message-ID: <985eb86f0911050538x5e467b0dgd7dbd4a6d278fbaf@domain.hid>
From: tarek ben ali <tarekbenali@domain.hid>
Content-Type: multipart/alternative; boundary=001485f7cc0a88f9ce04779fd819
Subject: Re: [Xenomai-core] setting priority
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--001485f7cc0a88f9ce04779fd819
Content-Type: text/plain; charset=ISO-8859-1

2009/11/5 Gilles Chanteperdrix <>
Gilles would you like to take a look on this please:
#include <sched.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
       struct sched_param param;

       param.sched_priority = 99;

       sched_setscheduler(0, SCHED_FIFO, &param);
       while(1) sleep(1);
       exit(0);
}

-->
/root> ./t&
/root> ps l
F   UID   PID  PPID PRI  NI    VSZ   RSS WCHAN  STAT TTY        TIME COMMAND
4     0  2984  2881 -100  -   1548   284 -      SN   pts/0      0:00 ./t
0     0  2988  2881  20   0   2348   740 -      R+   pts/0      0:00 ps l

the process has no longer a priority due to the set of SCHED_FIFO ,moreover
it's marked as an RT task.
The question is when defining a PID of process running(ex:3760 firefox )
this result is lost!!

--001485f7cc0a88f9ce04779fd819
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote">2009/11/5 Gilles Chante=
perdrix <span dir=3D"ltr">&lt;&gt;</span><br></div>Gilles would you like to=
 take a look on this please:<br>
#include &lt;sched.h&gt;<br>

#include &lt;stdlib.h&gt;
<div class=3D"im"><br>

int main(int argc, char **argv)<br>
{<br></div>

 =A0 =A0 =A0 =A0struct sched_param param;<br>

<br>

 =A0 =A0 =A0 =A0param.sched_priority =3D 99;<br>

<br>

 =A0 =A0 =A0 =A0sched_setscheduler(0, SCHED_FIFO, &amp;param);<br>

 =A0 =A0 =A0 =A0while(1) sleep(1);<br>

 =A0 =A0 =A0 =A0exit(0);<br>

}<br>

<br>

--&gt;<br>

/root&gt; ./t&amp;<br>

/root&gt; ps l<br>

F =A0 UID =A0 PID =A0PPID PRI =A0NI =A0 =A0VSZ =A0 RSS WCHAN =A0STAT TTY =
=A0 =A0 =A0 =A0TIME COMMAND<br>

4 =A0 =A0 0 =A02984 =A02881 -100 =A0- =A0 1548 =A0 284 - =A0 =A0 =A0SN =A0 =
pts/0 =A0 =A0 =A00:00 ./t<br>

0 =A0 =A0 0 =A02988 =A02881 =A020 =A0 0 =A0 2348 =A0 740 - =A0 =A0 =A0R+ =
=A0 pts/0 =A0 =A0 =A00:00 ps l<br>
<br>
the process has no longer a priority due to the set of SCHED_FIFO ,moreover=
 it&#39;s marked as an RT task.<br>
The question is when defining a PID of process running(ex:3760 firefox ) th=
is result is lost!!<br>
</div>

--001485f7cc0a88f9ce04779fd819--

