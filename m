References: <1404640109.73994.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53B964DC.1020004@xenomai.org>
 <1404662453.79446.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53B974A3.5010004@xenomai.org>
 <1404664284.37181.YahooMailNeo@web171606.mail.ir2.yahoo.com>
 <1404664634.35911.YahooMailNeo@web171602.mail.ir2.yahoo.com>
 <53B97CE2.5080700@xenomai.org>
Message-ID: <1404665771.3492.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Sun, 6 Jul 2014 17:56:11 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53B97CE2.5080700@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] issue with cobalt/timer: avoid periodic timer drift
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=0A=0A=0A----- Original Message -----=0A> From: Gilles Chanteperdrix <gi=
lles.chanteperdrix@xenomai.org>=0A> To: Matthias Schneider <ma30002000@yaho=
o.de>; "xenomai@xenomai.org" <xenomai@xenomai.org>=0A> Cc: =0A> Sent: Sunda=
y, July 6, 2014 6:44 PM=0A> Subject: Re: [Xenomai] issue with cobalt/timer:=
 avoid periodic timer drift=0A> =0A> On 07/06/2014 06:37 PM, Matthias Schne=
ider wrote:=0A>>  ----- Original Message -----=0A>> =0A>>>  From: Matthias =
Schneider <ma30002000@yahoo.de>=0A>>>  To: Gilles Chanteperdrix <gilles.cha=
nteperdrix@xenomai.org>; =0A> "xenomai@xenomai.org" <xenomai@xenomai.org>=
=0A>>>  Cc: =0A>>>  Sent: Sunday, July 6, 2014 6:31 PM=0A>>>  Subject: Re: =
[Xenomai] issue with cobalt/timer: avoid periodic timer =0A> drift=0A>>> =
=0A>>> =0A>>> =0A>>> =0A>>> =0A>>> =0A>>>  ----- Original Message -----=0A>=
>>> =A0 From: Gilles Chanteperdrix =0A> <gilles.chanteperdrix@xenomai.org>=
=0A>>>> =A0 To: Matthias Schneider <ma30002000@yahoo.de>; =0A>>>  "xenomai@=
xenomai.org" <xenomai@xenomai.org>=0A>>>> =A0 Cc: =0A>>>> =A0 Sent: Sunday,=
 July 6, 2014 6:09 PM=0A>>>> =A0 Subject: Re: [Xenomai] issue with cobalt/t=
imer: avoid periodic =0A> timer drift=0A>>>> =0A>>>> =A0 On 07/06/2014 06:0=
0 PM, Matthias Schneider wrote:=0A>>>>>> =A0  You seem to have created a pe=
riodic timer with a null =0A> period. =0A>>>  Could you=0A>>>>>> =A0  post =
a sample code allowing to reproduce this issue?=0A>>>>>> =A0 =A0 =0A>>>>> =
=0A>>>>> =0A>>>>> =A0  This happens in most of my freertos apps (e.g. demo,=
 etc.). =0A> However, =0A>>>>> =A0  I have not put any effort in narrowing =
the problem down, in =0A> the hope=0A>>>>> =A0  the problem would be deduct=
ible from the kernel state. Maybe =0A> you could=0A>>>>> =A0  give a few hi=
nts where a periodic timer could come into play? =0A> In the=0A>>>>> =A0  f=
reertos skin there are only tasks, queues and semaphores, so =0A> I=0A>>>>>=
 =A0  am not creating any periodic timer explicitly. Are there =0A> occasio=
sn=0A>>>>> =A0  when periodic timers are being created implicitly using the=
 =0A> three=0A>>>>> =A0  primitives mentioned above? Or can I configure an =
intelligent=0A>>>>> =A0  breakpoint to catch the creation of a periodic tim=
er?=0A>>>> =0A>>>> =A0 Maybe you could put a breakpoint to see where xntime=
r_start is =0A> called?=0A>>> =0A>>> =0A>>>  I have already had the idea, u=
nfortunately it seems to be called all=0A>>>  the time:=0A>>> =0A>>>  #0=A0=
 xntimer_start (timer=3D0xc06b7628 <nksched+24>, value=3D405804, =0A>>>  in=
terval=3Dinterval@entry=3D0, mode=3Dmode@entry=3DXN_RELATIVE) at =0A>>>  ke=
rnel/xenomai/timer.c:104=0A>>>  #1=A0 0xc00ca504 in program_htick_shot (del=
ay=3D<optimized out>, =0A>>>  cdev=3D<optimized out>) at kernel/xenomai/tim=
er.c:572=0A>>>  #2=A0 0xc007407c in clockevents_program_event (dev=3D0xc06a=
65c0 =0A>>>  <clockevent_gpt>, expires=3D..., force=3Dforce@entry=3Dfalse) =
at =0A>>>  kernel/time/clockevents.c:269=0A>>>  #3=A0 0xc0074a54 in tick_pr=
ogram_event (expires=3D..., force=3Dforce@entry=3D0) =0A> at =0A>>>  kernel=
/time/tick-oneshot.c:31=0A>>>  #4=A0 0xc0050974 in hrtimer_interrupt (dev=
=3D<optimized out>) at =0A>>>  kernel/hrtimer.c:1360=0A>>> =0A>>>  Any othe=
r idea?=0A>> =0A>> =0A>>  By the way, how can I deduce it was a periodic ti=
mer?=0A>> =0A>>  status seems to be 0x1 (XNTIMER_DEQUEUED), but not 0x4(XNT=
IMER_PERIODIC)=0A>>  Also, all the other timer values seem to indicate that=
=0A>> =0A>> =A0 if (interval !=3D XN_INFINITE) {=0A>> =A0  timer->interval_=
ns =3D interval;=0A>> =A0  timer->interval =3D xnclock_ns_to_ticks(clock, i=
nterval);=0A>> =A0  timer->periodic_ticks =3D 0;=0A>> =A0  timer->start_dat=
e =3D date;=0A>> =A0  timer->pexpect_ticks =3D 0;=0A>> =A0  timer->status |=
=3D XNTIMER_PERIODIC;=0A>> =A0 }=0A>> =0A>>  was never being used for that =
timer...=0A> =0A> You mean for the timer where you hit the breakpoint, or f=
or the timer=0A> which has the bug?=0A=0A=0AI assumed that if I would have =
create a periodic timer, status would at least=0Ahave been or'ed with 0x4. =
However, as can be seen in my initial post, the=A0=0Astatus value of the ti=
mer causing the problem was 1. Thats why I asked how=A0=0Ayou deduced that =
it was a periodic timer with a period of 0.=0A=0AMatthias

