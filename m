Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jun 2011 15:51:17 +0200
Message-ID: <3FF315C710820E47A04E55C6F7D9B0AD7FED32@domain.hid>
In-Reply-To: <1308662104.2125.50.camel@domain.hid>
References: <3FF315C710820E47A04E55C6F7D9B0AD7FE9FF@AREXCH02.mra.roland-man.biz>
	<1308044391.2699.2.camel@domain.hid>
	<3FF315C710820E47A04E55C6F7D9B0AD7FEA2C@AREXCH02.mra.roland-man.biz>
	<1308387052.2122.14.camel@domain.hid> <4DFCABDA.6000702@domain.hid>
	<1308406918.2122.24.camel@domain.hid>
	<3FF315C710820E47A04E55C6F7D9B0AD7FECDA@AREXCH02.mra.roland-man.biz>
	<1308652557.2125.45.camel@domain.hid>
	<3FF315C710820E47A04E55C6F7D9B0AD7FECF6@domain.hid>
	<4E008174.2060305@domain.hid>
	<3FF315C710820E47A04E55C6F7D9B0AD7FED23@domain.hid>
	<1308662104.2125.50.camel@domain.hid>
From: <roderik.wildenburg@domain.hid>
Subject: Re: [Xenomai-help] Xenomai 2.5.6 with PPC-Kernel 2.4.25
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

>=20
> The number of switches is related to the number of tasks running in =
this
> test, nofpu reduces this number. So that is ok.=20

I understand this, but both tests X2.4.9+PPC2.4.25 and X2.5.6+PPC-2.6.34 =
I run without(!) the option --nofpu. And in both cases there were 22 =
tasks.
With X2.4.9+2.4.25 I got about 1170 CTX-switches and with 2.5.6+2.6.34 =
about 4300 CTW-switches.
Only one test I run with --nofpu option (X2.5.6+PPC2.6.34)  (mail form =
13:25 o=C2=B4clock)!  and got about 2200 CTX-switches and there the =
difference is due to reduced number of taks.

>The problem with this
> test is that switches/sec values are sampled by a regular linux thread
> which nanosleeps, so at least over 2.4, the delay is not accurate. So
> the number of switches observed can't be either.
>=20
> I still have to check over 2.6 + hires if we can still explain this 2%
> offset the same way.

But in (2.6.34)+2.5.6 the display task is still an ordinary linux task =
(__real_pthread_create, as far as I can see). Why should it be more =
accurate?
Sorry for steeling your time and asking stupid  questions.

Roderik

>=20
> >
> > >Spare time has become a luxury over the last months. I'll try to =
find a
> > >time slot next week to have a look at this again.
> >
> > Tanks a lot!
> >  I don=C2=B4t dare to say, but I am on vacation for the rest of this =
and the next week, so
> I only can do testing as of 4. of July again.
> >
>=20
> Ok.
>=20
> > Roderik
> >
> > =
-------------------------------------------------------------------------=
---
> > Xenomai 2.4.9 on PPC-2.4.25:
> > RW24:/fat/sbin # switchtest
> > =3D=3D Testing FPU check routines...
> > r0: 1 !=3D 2
> > r1: 1 !=3D 2
> > r2: 1 !=3D 2
> > r3: 1 !=3D 2
> > r4: 1 !=3D 2
> > r5: 1 !=3D 2
> > r6: 1 !=3D 2
> > r7: 1 !=3D 2
> > r8: 1 !=3D 2
> > r9: 1 !=3D 2
> > r10: 1 !=3D 2
> > r11: 1 !=3D 2
> > r12: 1 !=3D 2
> > r13: 1 !=3D 2
> > r14: 1 !=3D 2
> > r15: 1 !=3D 2
> > r16: 1 !=3D 2
> > r17: 1 !=3D 2
> > r18: 1 !=3D 2
> > r19: 1 !=3D 2
> > r20: 1 !=3D 2
> > r21: 1 !=3D 2
> > r22: 1 !=3D 2
> > r23: 1 !=3D 2
> > r24: 1 !=3D 2
> > r25: 1 !=3D 2
> > r26: 1 !=3D 2
> > r27: 1 !=3D 2
> > r28: 1 !=3D 2
> > r29: 1 !=3D 2
> > r30: 1 !=3D 2
> > r31: 1 !=3D 2
> > =3D=3D FPU check routines: OK.
> > =3D=3D Threads: sleeper_ufps-0 rtk-1 rtk-2 rtk_fp-3 rtk_fp-4 =
rtk_fp_ufpp-5
> rtk_fp_ufpp-6 rtup-7 rtup-8 rtup_ufpp-9 rtup_ufpp-10 rtus-11 rtus-12 =
rtus_ufps-13
> rtus_ufps-14 rtuo-15 rtuo-16 rtuo_ufpp-17 rtuo_ufpp-18 rtuo_ufps-19 =
rtuo_ufps-
> 20 rtuo_ufpp_ufps-21 rtuo_ufpp_ufps-22
> > RTT|  00:00:01
> > RTH|ctx switches|-------total
> > RTD|        1150|        1150
> > RTD|        1150|        2300
> > RTD|        1173|        3473
> > RTD|        1173|        4646
> > RTD|        1150|        5796
> > RTD|        1173|        6969
> > RTD|        1150|        8119
> > RTD|        1173|        9292
> > RTD|        1150|       10442
> > RTD|        1173|       11615
> > RTD|        1173|       12788
> > RTD|        1150|       13938
> > RTD|        1173|       15111
> > RTD|        1173|       16284
> > RTD|        1150|       17434
> > RTD|        1150|       18584
> > RTD|        1150|       19734
> > RTD|        1173|       20907
> > RTD|        1150|       22057
> > RTD|        1150|       23207
> > RTD|        1150|       24357
> > RTT|  00:00:22
> > RTH|ctx switches|-------total
> > RTD|        1173|       25530
> > RTD|        1173|       26703
> > RTD|        1173|       27876
> > RTD|        1173|       29049
> > RTD|        1150|       30199
> > RTD|        1150|       31349
> > RTD|        1150|       32499
> > RTD|        1173|       33672
> > RTD|        1173|       34845
> > RTD|        1173|       36018
> > RTD|        1150|       37168
> > RTD|        1150|       38318
> > RTD|        1150|       39468
> > RTD|        1173|       40641
> > RTD|        1150|       41791
> > RTD|        1150|       42941
> > RTD|        1173|       44114
> > RTD|        1150|       45264
> > RTD|        1150|       46414
> > RTD|        1150|       47564
> > RTD|        1173|       48737
> > RTT|  00:00:43
> > RW24:/fat/sbin # cat /proc/xenomai/version
> > 2.4.9
> > RW24:/fat/sbin # cat /proc/xenomai/sched
> > CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
> >   0  0       -1      0          0          master    R          ROOT
> >   0  0       99      200000000  45608637   master    D          =
rt-watchdog
> > RW24:/fat/sbin # cat /proc/xenomai/stat
> > CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
> >   0  0      0          38989      0     00500080   98.3  ROOT
> >   0  0      0          701        0     00000084    0.0  rt-watchdog
> >   0  0      0          14730      0     00000000    0.1  IRQ256: =
[timer]
> > RW24:/fat/sbin #
> >
> >
> > > -----Urspr=C3=BCngliche Nachricht-----
> > > Von: Gilles Chanteperdrix =
[mailto:gilles.chanteperdrix@xenomai.org]
> > > Gesendet: Dienstag, 21. Juni 2011 13:33
> > > An: Wildenburg, Roderik RAEK1 MRA
> > > Cc: rpm@xenomai.org; xenomai@xenomai.org
> > > Betreff: Re: AW: AW: [Xenomai-help] Xenomai 2.5.6 with PPC-Kernel =
2.4.25
> > >
> > > On 06/21/2011 01:22 PM, roderik.wildenburg@domain.hid wrote:
> > > >> 2% off seems a lot for a transient load, and this would not =
happen on a
> > > >> periodic basis anyway. This needs to be investigated. Could you =
run
> > > >> switchtest in nofpu mode?
> > > >
> > > > Still fluctuates about 2% (see !!  mark) but now more erratic. =
The reduced
> > > number of context switches is caused by the reduced number of =
tasks?
> > >
> > > switchest works by switching context between several tasks. One of =
this
> > > task does sleep, in order to avoid starving linux, and also prints =
the
> > > numbers approximately every second.
> > >
> > > When there are less task, we enter the sleeping task more often, =
so,
> > > yes, there are less context switches.
> > >
> > > But more importantly, since, the time when we print the result is =
so
> > > imprecise, some variations are normal, so, chances are that the 2%
> > > variation is normal.
> > >
> > > --
> > >                                                                 =
Gilles.
> >
> > --------------------------------------------------------
> > manroland AG
> > Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> > Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul
> Steidle
> > Sitz der Gesellschaft: Offenbach am Main, Registergericht: =
Amtsgericht
> Offenbach HRB-Nr. 42592
> > USt-Ident-Nr. DE 250200933
> >
>=20
> --
> Philippe.
>=20
>

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933


