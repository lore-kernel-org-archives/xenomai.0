References: <1404640109.73994.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53B981B8.5070901@xenomai.org>
Message-ID: <1404668168.16673.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Sun, 6 Jul 2014 18:36:08 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53B981B8.5070901@xenomai.org>
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

----- Original Message -----=0A=0A> From: Gilles Chanteperdrix <gilles.chan=
teperdrix@xenomai.org>=0A> To: Matthias Schneider <ma30002000@yahoo.de>; "x=
enomai@xenomai.org" <xenomai@xenomai.org>=0A> Cc: =0A> Sent: Sunday, July 6=
, 2014 7:04 PM=0A> Subject: Re: [Xenomai] issue with cobalt/timer: avoid pe=
riodic timer drift=0A> =0A> On 07/06/2014 11:48 AM, Matthias Schneider wrot=
e:=0A>>  Hi all,=0A>> =0A>>  commit =0A>> =0A>>  2014-06-02 c20fceb147e337e=
2379b29ecd81b943318c7fbc7 =0A>>  (patch) cobalt/timer: avoid periodic timer=
 drift=0A>> =0A>>  seems to cause an endless kernel loop in one of my=0A>> =
 freertos demos. The issue does not occur when =0A>>  reverting this commit=
.=0A>> =0A>>  Investigating the issue, can see the following:=0A>> =0A>>  #=
0=A0 0xc00ba45c in mach_arm_nodiv_llimd (rhs_integ=3D<optimized out>, =0A> =
frac=3D<optimized out>, op=3D<optimized out>)=0A>> =A0 =A0  at arch/arm/xen=
omai/include/asm/xenomai/uapi/arith.h:120=0A>>  #1=A0 xnclock_core_ns_to_ti=
cks (ns=3D0) at kernel/xenomai/clock.c:52=0A>>  #2=A0 0xc00baf34 in xnclock=
_ns_to_ticks (clock=3D<optimized out>, =0A> ns=3D<optimized out>)=0A>> =A0 =
=A0  at include/xenomai/cobalt/kernel/clock.h:204=0A>>  #3=A0 xntimer_updat=
e_date (timer=3D0xde706518) at =0A> include/xenomai/cobalt/kernel/timer.h:2=
68=0A>>  #4=A0 xnclock_tick (clock=3D0xc06b1138 <nkclock>) at =0A> kernel/x=
enomai/clock.c:644=0A>>  #5=A0 0xc00bcbcc in xnintr_core_clock_handler () a=
t kernel/xenomai/intr.c:121=0A>>  #6=A0 0xc0095a98 in dispatch_irq_head (ir=
q=3D<optimized out>) at =0A> kernel/ipipe/core.c:1179=0A>> =0A>>  This seem=
s to be the endless loop:=0A>>  642=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
 do {=0A>>  643=A0 =A0 =A0 timer->periodic_ticks +=3D interval_ticks;=0A>> =
 644=A0 =A0 =A0 xntimer_update_date(timer);=0A>>  645=A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0  } while (xntimerh_date(&timer->aplink) < =0A> now + cl=
ock->gravity);=0A> =0A> =0A> I do not really understand how interval_ticks =
can be 0, but please try =0A> the following patch:=0A> =0A> diff --git a/ke=
rnel/cobalt/clock.c b/kernel/cobalt/clock.c=0A> index a578f89..1107f7a 1006=
44=0A> --- a/kernel/cobalt/clock.c=0A> +++ b/kernel/cobalt/clock.c=0A> @@ -=
619,10 +619,9 @@ void xnclock_tick(struct xnclock *clock)=0A> =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0  * wait for 250 ms for the user to continue=0A> =A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0  * program execution.=0A> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=
  */=0A> -=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (timer->interval_ns > 250000000)=
=0A> -=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 goto advance;=0A> -=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 interval_ticks =3D 250000000 /=0A> -=A0=A0=A0 =A0=A0=A0=
 =A0=A0=A0 =A0=A0=A0 (unsigned)timer->interval_ns;=0A> +=A0=A0=A0 =A0=A0=A0=
 =A0=A0=A0 xntimerh_date(&timer->aplink) +=3D=0A> +=A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 xnclock_ns_to_ticks(xntimer_clock(timer),=0A> +=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 250000000);=0A> =A0=A0=A0=
 =A0=A0=A0 =A0=A0=A0 goto requeue;=0A> =A0=A0=A0 =A0=A0=A0 }=0A> =A0=A0=A0 =
fire:=0A> @@ -638,11 +637,11 @@ void xnclock_tick(struct xnclock *clock)=0A=
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 continue;=0A> =A0=A0=A0 advance:=0A> =A0=A0=
=A0 =A0=A0=A0 interval_ticks =3D 1;=0A> -=A0=A0=A0 requeue:=0A> =0A> =A0=A0=
=A0 =A0=A0=A0 do {=0A> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 timer->periodic_ticks =
+=3D interval_ticks;=0A> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 xntimer_update_date(=
timer);=0A> =A0=A0=A0 =A0=A0=A0 } while (xntimerh_date(&timer->aplink) < no=
w + =0A> clock->gravity);=0A> +=A0=A0=A0 requeue:=0A> #ifdef CONFIG_SMP=0A>=
 =A0=A0=A0 =A0=A0=A0 /*=0A> =A0=A0=A0 =A0=A0=A0  * Make sure to pick the ri=
ght percpu queue, in case=0A> =0A=0A=0AHi Gilles,=0A=0Athanks for the quick=
 fix, it seems to resolve my problem. Yes,=0Ain fact I was used gdb when th=
e issues occured.=A0=0A=0AConsidering I entered the=0A=0Aif (unlikely(atomi=
c_read(&nkclklk) > 0))=0A[...]=0Acode path, a series of division by zeroes =
I had without a sensible backtrace=0Acould also be explained (I was under t=
he impression that it is possible to=0Aget a backtrace of a division by zer=
o exception on arm for some time now,=0Abut it seems not to have worked for=
 me).=0A=0ARegards,=0AMatthias

