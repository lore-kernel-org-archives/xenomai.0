Message-ID: <1404640109.73994.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Date: Sun, 6 Jul 2014 10:48:29 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] issue with cobalt/timer: avoid periodic timer drift
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

Hi all,=0A=0Acommit=A0=0A=0A2014-06-02 c20fceb147e337e2379b29ecd81b943318c7=
fbc7=A0=0A(patch) cobalt/timer: avoid periodic timer drift=0A=0Aseems to ca=
use an endless kernel loop in one of my=0Afreertos demos.=A0The issue does =
not occur when=A0=0Areverting this commit.=0A=0AInvestigating the issue, ca=
n see the following:=0A=0A#0  0xc00ba45c in mach_arm_nodiv_llimd (rhs_integ=
=3D<optimized out>, frac=3D<optimized out>, op=3D<optimized out>)=0A=A0 =A0=
 at arch/arm/xenomai/include/asm/xenomai/uapi/arith.h:120=0A#1  xnclock_cor=
e_ns_to_ticks (ns=3D0) at kernel/xenomai/clock.c:52=0A#2  0xc00baf34 in xnc=
lock_ns_to_ticks (clock=3D<optimized out>, ns=3D<optimized out>)=0A=A0 =A0 =
at include/xenomai/cobalt/kernel/clock.h:204=0A#3  xntimer_update_date (tim=
er=3D0xde706518) at include/xenomai/cobalt/kernel/timer.h:268=0A#4  xnclock=
_tick (clock=3D0xc06b1138 <nkclock>) at kernel/xenomai/clock.c:644=0A#5  0x=
c00bcbcc in xnintr_core_clock_handler () at kernel/xenomai/intr.c:121=0A#6 =
 0xc0095a98 in dispatch_irq_head (irq=3D<optimized out>) at kernel/ipipe/co=
re.c:1179=0A=0AThis seems to be the endless loop:=0A642                    =
 do {=0A643 =A0 =A0 =A0timer->periodic_ticks +=3D interval_ticks;=0A644 =A0=
 =A0 =A0xntimer_update_date(timer);=0A645                     } while (xnti=
merh_date(&timer->aplink) < now + clock->gravity);=0A=0Agdb) info locals=0A=
timerq =3D 0xdebdae98=0Anow =3D 4257712977=0Ainterval_ticks =3D 0=0Atimer =
=3D 0xde706518=0Adelta =3D <optimized out>=0Ah =3D 0xde706518=0A=0A(gdb) pr=
int *timer=0A$1 =3D {=0A=A0 aplink =3D {=0A=A0 =A0 link =3D {=0A=A0 =A0 =A0=
 next =3D 0x100100,=A0=0A=A0 =A0 =A0 prev =3D 0x200200=0A=A0 =A0 },=A0=0A=
=A0 =A0 key =3D 0,=A0=0A=A0 =A0 prio =3D 999999999=0A=A0 },=A0=0A=A0 adjlin=
k =3D {=0A=A0 =A0 next =3D 0x0 <__vectors_start>,=A0=0A=A0 =A0 prev =3D 0x0=
 <__vectors_start>=0A=A0 },=A0=0A=A0 status =3D 1,=A0=0A=A0 interval =3D 0,=
=A0=0A=A0 interval_ns =3D 0,=A0=0A=A0 periodic_ticks =3D 0,=A0=0A=A0 start_=
date =3D 0,=A0=0A=A0 pexpect_ticks =3D 0,=A0=0A=A0 sched =3D 0xc06b1610 <nk=
sched>,=A0=0A=A0 handler =3D 0xc00c7dc4 <timeout_handler>,=A0=0A=A0 name =
=3D "CREATOR", '\000' <repeats 24 times>,=A0=0A=A0 handler_name =3D 0xc05ad=
429 "timeout_handler",=A0=0A=A0 next_stat =3D {=0A=A0 =A0 next =3D 0xde7066=
24,=A0=0A=A0 =A0 prev =3D 0xde705c24=0A=A0 },=A0=0A=A0 scheduled =3D {=0A=
=A0 =A0 counter =3D 3=0A=A0 },=A0=0A=A0 fired =3D {=0A=A0 =A0 counter =3D 1=
=0A=A0 }=0A}=0A(gdb) print *clock=0A$2 =3D {=0A=A0 wallclock_offset =3D 200=
209,=A0=0A=A0 resolution =3D 1,=A0=0A=A0 gravity =3D 140,=A0=0A=A0 name =3D=
 0xc05ac815 "coreclk",=A0=0A=A0 timerdata =3D 0xdebdae98,=A0=0A=A0 id =3D -=
1,=A0=0A=A0 vfile =3D {=0A=A0 =A0 entry =3D {=0A=A0 =A0 =A0 pde =3D 0xde1b8=
700,=A0=0A=A0 =A0 =A0 file =3D 0x0 <__vectors_start>,=A0=0A=A0 =A0 =A0 lock=
ops =3D 0xc06b2c20 <xnvfile_nucleus_lock>,=A0=0A=A0 =A0 =A0 refcnt =3D 0,=
=A0=0A=A0 =A0 =A0 private =3D 0xc06b1138 <nkclock>=0A=A0 =A0 },=A0=0A=A0 =
=A0 privsz =3D 4,=A0=0A=A0 =A0 datasz =3D 104,=A0=0A=A0 =A0 tag =3D 0xc06b1=
17c <nkclock+68>,=A0=0A=A0 =A0 ops =3D 0xc06b1120 <vfile_clock_ops>=0A=A0 }=
,=A0=0A=A0 revtag =3D {=0A=A0 =A0 rev =3D 36=0A=A0 },=A0=0A=A0 statq =3D {=
=0A=A0 =A0 next =3D 0xc06b18d4 <nksched+708>,=A0=0A=A0 =A0 prev =3D 0xde706=
e24=0A=A0 },=A0=0A=A0 nrtimers =3D 24=0A}=0A=0ADoes anyone see right away w=
hat is going on wrong=A0=0Aor shall I continue investigating the issue?=0A=
=0ARegards,=0AMatthias

