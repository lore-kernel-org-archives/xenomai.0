References: <1366732845.34430.YahooMailNeo@web161405.mail.bf1.yahoo.com>
	<5176B0E3.3030009@xenomai.org>
Message-ID: <1366738934.20080.YahooMailNeo@web161406.mail.bf1.yahoo.com>
Date: Tue, 23 Apr 2013 10:42:14 -0700 (PDT)
From: Tom Z <tomz30@yahoo.com>
In-Reply-To: <5176B0E3.3030009@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rt_task_wait_period returns -11 (-EAGAIN)
Reply-To: Tom Z <tomz30@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Philippe,=0A=0AThanks for answering my previous question. However, I enc=
ountered another one regarding rt_task_wait_period(). NowI fixed a problema=
tic parameter in rt_task_set_periodic(), and add the checking of the return=
 values of rt_task_wait_period() and rt_task_set_periodic(). I use rt_task_=
set_periodic()to set a period of 500 ms for a rt_task, and call rt_task_wai=
t_period() later. It seems that sometimes rt_task_wait_period()works good, =
but sometimes it just returns 0 immediately. Here is what my code looks lik=
e:=0A=0Aunsigned long overrun;=0ARTIME release_time;=0A=0Aif (0 !=3D rt_tas=
k_set_periodic(NULL, TM_NOW, 500000000){=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rt_printf("Error\n");=0A}=
=0A....=0Awhile (1){=0A=C2=A0=C2=A0=C2=A0 release_time =3D rt_timer_read();=
=0A=C2=A0=C2=A0=C2=A0 //Store release_time in an array for offline analysis=
=0A=C2=A0=C2=A0=C2=A0 //Some computation taking about 100 ms=0A=C2=A0=C2=A0=
=C2=A0 if (0 !=3D rt_task_wait_period(&overrun)){=0A=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rt_printf("Error\n");=
=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }=0A}=0A=0A=0AI noticed that, during the =
program's execution, no "Error" was printed, but some consecutive values of=
 release_time is about 100 ms which is the computation time and far less th=
an the period 500 ms.=0A=0AThis problem seems weird to me. Did I possibly o=
verlook something?=0A=0AThanks,=0ATom=0A=0A=0A=0A=0A=0A____________________=
____________=0A From: Philippe Gerum <rpm@xenomai.org>=0ATo: Tom Z <tomz30@=
yahoo.com> =0ACc: "xenomai@xenomai.org" <xenomai@xenomai.org> =0ASent: Tues=
day, 23 April 2013 11:03 AM=0ASubject: Re: [Xenomai] rt_task_wait_period re=
turns -11 (-EAGAIN)=0A =0A=0AOn 04/23/2013 06:00 PM, Tom Z wrote:=0A> Hi,=
=0A>=0A> It seems this problem didn't occur before, but yesterday when I ra=
n the same program on the same platform, a statement in my program calling =
rt_task_wait_period() returns -11. I looked up the error code, and 11 is th=
e value of EAGAIN defined in <LINUX INCLUDE>/asm-generic/error_base.h. So I=
 tried to modify my code like this=0A>=0A> unsigned long overrun;=0A>=0A> r=
et =3D -EAGAIN=0A> while(-EAGAIN =3D=3D ret)=0A>=C2=A0 =C2=A0 =C2=A0 ret =
=3D rt_task_wait_period( &overrun);=0A>=0A>=0A> But it keeps spinning and t=
hrows an error in the end: CPU time exceeded.=0A>=0A>=0A>=0A> What would be=
 the possible cause?=E3=80=80=EF=BC=AD=EF=BD=99 platform is a Core 2 Duo la=
ptop with Xenomai 2.6.2.1 on Linux 3.5.7.=0A>=0A=0A=0ACheck the doc for EWO=
ULDBLOCK. rt_task_set_periodic() was not=0Acalled for the task.=0A=0A-- =0A=
Philippe.
