References: <1394996997.10478.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <532605BE.3060101@xenomai.org>
Message-ID: <1395004042.86948.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Sun, 16 Mar 2014 21:07:22 +0000 (GMT)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <532605BE.3060101@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Issue suspending threads on mercury
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

> On Sunday, March 16, 2014 9:12 PM, Gilles Chanteperdrix <gilles.chanteper=
drix@xenomai.org> wrote:=0A=0A> > On 03/16/2014 08:09 PM, Matthias Schneide=
r wrote:=0A> =0A>>  Hi all,=0A>> =0A>>  I am experiencing a problem with xe=
nomai-forge (recent "next" =0A> checkout) on Mercury (on top of a 3.12.9+CO=
NFIG_PREEMPT_RT on x86) when suspending =0A>>  tasks/threads.=0A>> =0A>>  A=
s far=A0 as I understand, the mercury implementation sends a signal to the =
thread =0A>>  to be suspended, with that threads signal handler setting the=
 suspended state, =0A>>  i.e. the setting of __THREAD_S_SUSPENDED happens i=
n notifier_callback, which =0A>>  seems to be different from the cobalt imp=
lementation.=0A>> =0A>>  The problem I am experiencing is that sometimes th=
e signal handler never seems =0A>>  to get called in a thread that should b=
e suspended,=A0 i.e. that thread suspension =0A>>  sometimes simply does no=
t work.=0A>>  The following example code (for the vxworks skin) reproduces =
the issue (it=A0gets =0A>>  stuck in the loop waiting for the WIND_SUSPEND =
flag): =0A>> =0A>>  http://www.pastebin.ca/2667435=0A>> =0A>>  Any hints on=
 how I can continue investigating this issue?=0A> =0A> Have you tried check=
ing taskSpawn and taskSuspend return values? To see=0A> if the calls are su=
ccessful?=0A> =0A> =0A> -- =0A> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 Gilles.=0A> =0A=0AHi Gilles,=0A=0Ayes, the calls seem to return=
 with "OK". I have put updated sample code at=0A=0Ahttp://www.pastebin.ca/2=
667459=0A=0A=0AThe problem seems to happen quite often when attached with g=
db (mostly during=0Athe first execution of the do .. while loop.=0A=0AThe t=
hread not suspended stack looks like this:=0A#0 =A00xffffe424 in __kernel_v=
syscall ()=0A#1 =A00xb7e8e8ee in clock_nanosleep (clock_id=3D-1208270244, f=
lags=3D1, req=3D0xb69ff1f0, rem=3D0x0) at ../sysdeps/unix/sysv/linux/clock_=
nanosleep.c:47=0A#2 =A00xb7fa02cb in threadobj_sleep (ts=3D0xb69ff1f0) at t=
hreadobj.c:1096=0A#3 =A00xb7fcdf00 in taskDelay (ticks=3D1000) at taskLib.c=
:851=0A#4 =A00x0804878f in windTask (...) at task-1.c:15=0A[...]=0A=0Awhile=
 all the other suspended stacks look like=0A=0A#0 =A00xffffe424 in __kernel=
_vsyscall ()=0A#1 =A00xb7f5272b in read () at ../sysdeps/unix/syscall-templ=
ate.S:81=0A#2 =A00xb7fa679f in notifier_wait (nf=3D0x804a418) at notifier.c=
:279=0A#3 =A00xb7f9cf36 in notifier_callback (nf=3D0x804a418) at threadobj.=
c:430=0A#4 =A00xb7fa524d in notifier_sighandler (sig=3D42, siginfo=3D0xb7d8=
9e0c, uc=3D0xb7d89e8c) at notifier.c:91=0A#5 =A0<signal handler called>=0A#=
6 =A00xffffe424 in __kernel_vsyscall ()=0A#7 =A00xb7e8e8ee in clock_nanosle=
ep (...) at clock_nanosleep.c:47=0A#8 =A00xb7fa02cb in threadobj_sleep (ts=
=3D0xb7d8a1f0) at threadobj.c:1096=0A#9 =A00xb7fcdf00 in taskDelay (ticks=
=3D1000) at taskLib.c:851=0A#10 0x0804878f in windTask (...) at task-1.c:15=
=0A=0A, which is probably what I would suspect...=0A=0AMatthias

