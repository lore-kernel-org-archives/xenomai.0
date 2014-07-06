References: <1404640109.73994.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53B964DC.1020004@xenomai.org>
 <1404662453.79446.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53B974A3.5010004@xenomai.org>
 <1404664284.37181.YahooMailNeo@web171606.mail.ir2.yahoo.com>
Message-ID: <1404664634.35911.YahooMailNeo@web171602.mail.ir2.yahoo.com>
Date: Sun, 6 Jul 2014 17:37:14 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <1404664284.37181.YahooMailNeo@web171606.mail.ir2.yahoo.com>
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
To: Matthias Schneider <ma30002000@yahoo.de>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

----- Original Message -----=0A=0A> From: Matthias Schneider <ma30002000@ya=
hoo.de>=0A> To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>; "x=
enomai@xenomai.org" <xenomai@xenomai.org>=0A> Cc: =0A> Sent: Sunday, July 6=
, 2014 6:31 PM=0A> Subject: Re: [Xenomai] issue with cobalt/timer: avoid pe=
riodic timer drift=0A> =0A> =0A> =0A> =0A> =0A> =0A> ----- Original Message=
 -----=0A>>  From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>=
=0A>>  To: Matthias Schneider <ma30002000@yahoo.de>; =0A> "xenomai@xenomai.=
org" <xenomai@xenomai.org>=0A>>  Cc: =0A>>  Sent: Sunday, July 6, 2014 6:09=
 PM=0A>>  Subject: Re: [Xenomai] issue with cobalt/timer: avoid periodic ti=
mer drift=0A>> =0A>>  On 07/06/2014 06:00 PM, Matthias Schneider wrote:=0A>=
>>> =A0 You seem to have created a periodic timer with a null period. =0A> =
Could you=0A>>>> =A0 post a sample code allowing to reproduce this issue?=
=0A>>>>  =A0 =0A>>> =0A>>> =0A>>> =A0 This happens in most of my freertos a=
pps (e.g. demo, etc.). However, =0A>>> =A0 I have not put any effort in nar=
rowing the problem down, in the hope=0A>>> =A0 the problem would be deducti=
ble from the kernel state. Maybe you could=0A>>> =A0 give a few hints where=
 a periodic timer could come into play? In the=0A>>> =A0 freertos skin ther=
e are only tasks, queues and semaphores, so I=0A>>> =A0 am not creating any=
 periodic timer explicitly. Are there occasiosn=0A>>> =A0 when periodic tim=
ers are being created implicitly using the three=0A>>> =A0 primitives menti=
oned above? Or can I configure an intelligent=0A>>> =A0 breakpoint to catch=
 the creation of a periodic timer?=0A>> =0A>>  Maybe you could put a breakp=
oint to see where xntimer_start is called?=0A> =0A> =0A> I have already had=
 the idea, unfortunately it seems to be called all=0A> the time:=0A> =0A> #=
0=A0 xntimer_start (timer=3D0xc06b7628 <nksched+24>, value=3D405804, =0A> i=
nterval=3Dinterval@entry=3D0, mode=3Dmode@entry=3DXN_RELATIVE) at =0A> kern=
el/xenomai/timer.c:104=0A> #1=A0 0xc00ca504 in program_htick_shot (delay=3D=
<optimized out>, =0A> cdev=3D<optimized out>) at kernel/xenomai/timer.c:572=
=0A> #2=A0 0xc007407c in clockevents_program_event (dev=3D0xc06a65c0 =0A> <=
clockevent_gpt>, expires=3D..., force=3Dforce@entry=3Dfalse) at =0A> kernel=
/time/clockevents.c:269=0A> #3=A0 0xc0074a54 in tick_program_event (expires=
=3D..., force=3Dforce@entry=3D0) at =0A> kernel/time/tick-oneshot.c:31=0A> =
#4=A0 0xc0050974 in hrtimer_interrupt (dev=3D<optimized out>) at =0A> kerne=
l/hrtimer.c:1360=0A> =0A> Any other idea?=0A=0A=0ABy the way, how can I ded=
uce it was a periodic timer?=0A=0Astatus seems to be 0x1 (XNTIMER_DEQUEUED)=
, but not 0x4(XNTIMER_PERIODIC)=0AAlso, all the other timer values seem to =
indicate that=0A=0A=A0if (interval !=3D XN_INFINITE) {=0A=A0 timer->interva=
l_ns =3D interval;=0A=A0 timer->interval =3D xnclock_ns_to_ticks(clock, int=
erval);=0A=A0 timer->periodic_ticks =3D 0;=0A=A0 timer->start_date =3D date=
;=0A=A0 timer->pexpect_ticks =3D 0;=0A=A0 timer->status |=3D XNTIMER_PERIOD=
IC;=0A=A0}=0A=0Awas never being used for that timer...=0A=0AMatthias

