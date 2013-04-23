Message-ID: <1366732845.34430.YahooMailNeo@web161405.mail.bf1.yahoo.com>
Date: Tue, 23 Apr 2013 09:00:45 -0700 (PDT)
From: Tom Z <tomz30@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] rt_task_wait_period returns -11 (-EAGAIN)
Reply-To: Tom Z <tomz30@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,=0A=0AIt seems this problem didn't occur before, but yesterday when I ra=
n the same program on the same platform, a statement in my program calling =
rt_task_wait_period() returns -11. I looked up the error code, and 11 is th=
e value of EAGAIN defined in <LINUX INCLUDE>/asm-generic/error_base.h. So I=
 tried to modify my code like this=0A=0Aunsigned long overrun;=0A=0Aret =3D=
 -EAGAIN=0Awhile(-EAGAIN =3D=3D ret)=0A=C2=A0=C2=A0=C2=A0 ret =3D rt_task_w=
ait_period( &overrun);=0A=0A=0ABut it keeps spinning and throws an error in=
 the end: CPU time exceeded. =0A=0A=0A=0AWhat would be the possible cause?=
=E3=80=80=EF=BC=AD=EF=BD=99 platform is a Core 2 Duo laptop with Xenomai 2.=
6.2.1 on Linux 3.5.7.=0A=0A=0AThanks a lot =0A=0ATom=0A
