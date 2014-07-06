References: <1404640109.73994.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53B964DC.1020004@xenomai.org>
Message-ID: <1404662453.79446.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Date: Sun, 6 Jul 2014 17:00:53 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53B964DC.1020004@xenomai.org>
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
y, July 6, 2014 5:01 PM=0A> Subject: Re: [Xenomai] issue with cobalt/timer:=
 avoid periodic timer drift=0A> =0A> On 07/06/2014 11:48 AM, Matthias Schne=
ider wrote:=0A> =0A>>  Hi all,=0A>> =0A>>  commit =0A>> =0A>>  2014-06-02 c=
20fceb147e337e2379b29ecd81b943318c7fbc7 =0A>>  (patch) cobalt/timer: avoid =
periodic timer drift=0A>> =0A>>  seems to cause an endless kernel loop in o=
ne of my=0A>>  freertos demos. The issue does not occur when =0A>>  reverti=
ng this commit.=0A>> =0A>>  Investigating the issue, can see the following:=
=0A>> =0A>>  #0=A0 0xc00ba45c in mach_arm_nodiv_llimd (rhs_integ=3D<optimiz=
ed out>, =0A> frac=3D<optimized out>, op=3D<optimized out>)=0A>> =A0 =A0  a=
t arch/arm/xenomai/include/asm/xenomai/uapi/arith.h:120=0A>>  #1=A0 xnclock=
_core_ns_to_ticks (ns=3D0) at kernel/xenomai/clock.c:52=0A>>  #2=A0 0xc00ba=
f34 in xnclock_ns_to_ticks (clock=3D<optimized out>, =0A> ns=3D<optimized o=
ut>)=0A>> =A0 =A0  at include/xenomai/cobalt/kernel/clock.h:204=0A>>  #3=A0=
 xntimer_update_date (timer=3D0xde706518) at =0A> include/xenomai/cobalt/ke=
rnel/timer.h:268=0A>>  #4=A0 xnclock_tick (clock=3D0xc06b1138 <nkclock>) at=
 =0A> kernel/xenomai/clock.c:644=0A>>  #5=A0 0xc00bcbcc in xnintr_core_cloc=
k_handler () at kernel/xenomai/intr.c:121=0A>>  #6=A0 0xc0095a98 in dispatc=
h_irq_head (irq=3D<optimized out>) at =0A> kernel/ipipe/core.c:1179=0A>> =
=0A>>  This seems to be the endless loop:=0A>>  642=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0  do {=0A>>  643=A0 =A0 =A0 timer->periodic_ticks +=3D inter=
val_ticks;=0A>>  644=A0 =A0 =A0 xntimer_update_date(timer);=0A>>  645=A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0  } while (xntimerh_date(&timer->aplink)=
 < =0A> now + clock->gravity);=0A>> =0A>>  gdb) info locals=0A>>  timerq =
=3D 0xdebdae98=0A>>  now =3D 4257712977=0A>>  interval_ticks =3D 0=0A>>  ti=
mer =3D 0xde706518=0A>>  delta =3D <optimized out>=0A>>  h =3D 0xde706518=
=0A>> =0A>>  (gdb) print *timer=0A>>  $1 =3D {=0A>> =A0  aplink =3D {=0A>> =
=A0 =A0  link =3D {=0A>> =A0 =A0 =A0  next =3D 0x100100, =0A>> =A0 =A0 =A0 =
 prev =3D 0x200200=0A>> =A0 =A0  }, =0A>> =A0 =A0  key =3D 0, =0A>> =A0 =A0=
  prio =3D 999999999=0A>> =A0  }, =0A>> =A0  adjlink =3D {=0A>> =A0 =A0  ne=
xt =3D 0x0 <__vectors_start>, =0A>> =A0 =A0  prev =3D 0x0 <__vectors_start>=
=0A>> =A0  }, =0A>> =A0  status =3D 1, =0A>> =A0  interval =3D 0, =0A>> =A0=
  interval_ns =3D 0, =0A>> =A0  periodic_ticks =3D 0, =0A>> =A0  start_date=
 =3D 0, =0A>> =A0  pexpect_ticks =3D 0, =0A>> =A0  sched =3D 0xc06b1610 <nk=
sched>, =0A>> =A0  handler =3D 0xc00c7dc4 <timeout_handler>, =0A>> =A0  nam=
e =3D "CREATOR", '\000' <repeats 24 times>, =0A>> =A0  handler_name =3D 0xc=
05ad429 "timeout_handler", =0A>> =A0  next_stat =3D {=0A>> =A0 =A0  next =
=3D 0xde706624, =0A>> =A0 =A0  prev =3D 0xde705c24=0A>> =A0  }, =0A>> =A0  =
scheduled =3D {=0A>> =A0 =A0  counter =3D 3=0A>> =A0  }, =0A>> =A0  fired =
=3D {=0A>> =A0 =A0  counter =3D 1=0A>> =A0  }=0A>>  }=0A>>  (gdb) print *cl=
ock=0A>>  $2 =3D {=0A>> =A0  wallclock_offset =3D 200209, =0A>> =A0  resolu=
tion =3D 1, =0A>> =A0  gravity =3D 140, =0A>> =A0  name =3D 0xc05ac815 "cor=
eclk", =0A>> =A0  timerdata =3D 0xdebdae98, =0A>> =A0  id =3D -1, =0A>> =A0=
  vfile =3D {=0A>> =A0 =A0  entry =3D {=0A>> =A0 =A0 =A0  pde =3D 0xde1b870=
0, =0A>> =A0 =A0 =A0  file =3D 0x0 <__vectors_start>, =0A>> =A0 =A0 =A0  lo=
ckops =3D 0xc06b2c20 <xnvfile_nucleus_lock>, =0A>> =A0 =A0 =A0  refcnt =3D =
0, =0A>> =A0 =A0 =A0  private =3D 0xc06b1138 <nkclock>=0A>> =A0 =A0  }, =0A=
>> =A0 =A0  privsz =3D 4, =0A>> =A0 =A0  datasz =3D 104, =0A>> =A0 =A0  tag=
 =3D 0xc06b117c <nkclock+68>, =0A>> =A0 =A0  ops =3D 0xc06b1120 <vfile_cloc=
k_ops>=0A>> =A0  }, =0A>> =A0  revtag =3D {=0A>> =A0 =A0  rev =3D 36=0A>> =
=A0  }, =0A>> =A0  statq =3D {=0A>> =A0 =A0  next =3D 0xc06b18d4 <nksched+7=
08>, =0A>> =A0 =A0  prev =3D 0xde706e24=0A>> =A0  }, =0A>> =A0  nrtimers =
=3D 24=0A>>  }=0A>> =0A>>  Does anyone see right away what is going on wron=
g =0A>>  or shall I continue investigating the issue?=0A> =0A> You seem to =
have created a periodic timer with a null period. Could you=0A> post a samp=
le code allowing to reproduce this issue?=0A>=A0=0A=0A=0AThis happens in mo=
st of my freertos apps (e.g. demo, etc.). However,=A0=0AI have not put any =
effort in narrowing the problem down, in the hope=0Athe problem would be de=
ductible from the kernel state. Maybe you could=0Agive a few hints where a =
periodic timer could come into play? In the=0Afreertos skin there are only =
tasks, queues and semaphores, so I=0Aam not creating any periodic timer exp=
licitly. Are there occasiosn=0Awhen periodic timers are being created impli=
citly using the three=0Aprimitives mentioned above? Or can I configure an i=
ntelligent=0Abreakpoint to catch the creation of a periodic timer?=0A=0AReg=
ards,=0AMatthias

