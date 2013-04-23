References: <1366732845.34430.YahooMailNeo@web161405.mail.bf1.yahoo.com>
	<5176B0E3.3030009@xenomai.org>
Message-ID: <1366734857.26156.YahooMailNeo@web161401.mail.bf1.yahoo.com>
Date: Tue, 23 Apr 2013 09:34:17 -0700 (PDT)
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

Thanks Phillppe. You are right, I did call rt_task_set_period()before rt_ta=
sk_wait_period(), but it failed and I was too lazy to check rt_task_set_per=
iod()'s return value.=0A=0A=0A=0A=0A________________________________=0A Fro=
m: Philippe Gerum <rpm@xenomai.org>=0ATo: Tom Z <tomz30@yahoo.com> =0ACc: "=
xenomai@xenomai.org" <xenomai@xenomai.org> =0ASent: Tuesday, 23 April 2013 =
11:03 AM=0ASubject: Re: [Xenomai] rt_task_wait_period returns -11 (-EAGAIN)=
=0A =0A=0AOn 04/23/2013 06:00 PM, Tom Z wrote:=0A> Hi,=0A>=0A> It seems thi=
s problem didn't occur before, but yesterday when I ran the same program on=
 the same platform, a statement in my program calling rt_task_wait_period()=
 returns -11. I looked up the error code, and 11 is the value of EAGAIN def=
ined in <LINUX INCLUDE>/asm-generic/error_base.h. So I tried to modify my c=
ode like this=0A>=0A> unsigned long overrun;=0A>=0A> ret =3D -EAGAIN=0A> wh=
ile(-EAGAIN =3D=3D ret)=0A>=C2=A0 =C2=A0 =C2=A0 ret =3D rt_task_wait_period=
( &overrun);=0A>=0A>=0A> But it keeps spinning and throws an error in the e=
nd: CPU time exceeded.=0A>=0A>=0A>=0A> What would be the possible cause?=E3=
=80=80=EF=BC=AD=EF=BD=99 platform is a Core 2 Duo laptop with Xenomai 2.6.2=
.1 on Linux 3.5.7.=0A>=0A=0A=0ACheck the doc for EWOULDBLOCK. rt_task_set_p=
eriodic() was not=0Acalled for the task.=0A=0A-- =0APhilippe.
