Message-ID: <43FAFC4D.8070709@domain.hid>
Date: Tue, 21 Feb 2006 12:41:01 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Timer and calibration
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210D24@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0210D24@domain.hid>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

ROSSIER Daniel wrote:
> Hello,
>=20
> =20
>=20
> We are currently porting Adeos/Xenomai with Linux 2.6.14 on a ARM9-base=
d=20
> Freescale i.mx21 (litekit) development board.
>=20
> We started from the available patch for the ARM-based Integrator board.
>=20
> =20
>=20
> We are now facing some interesting problems regarding clock/timer=20
> frequencies with this board, but they are about to be solved J
>=20
> =20
>=20
> However, we have a question of understanding; as far as we know, ipipe=20
> starts with an aperiodic (one-shot) timer at the initialization time,=20
> and that before
>=20
> the calibrate function has been called. So, we get one interrupt only=20
> since the xenomai scheduler has not been registered (we understand
>=20
> that the xenomai scheduler should give the next timer shot, but since i=
t=20
> is not registered yet, no timer reprogramming is achieved).
>=20
> =20
>=20
> So, how can the calibrate function can be invoked safely if no timer IR=
Q=20
> is received since this kind of calibration comes before the xenomai=20
> registration
>=20
> (the calibrate function needs IRQ timers to calibrate the number of bus=
y=20
> loops between two jiffies) ?
>=20

Unlike Linux's calibrate_delay loop, Xenomai's timer calibration code doe=
s not=20
measure the CPU performance level, but only the average cost of programmi=
ng the=20
underlying timer hw in oneshot mode (time-wise), so that the nucleus can =
take this=20
unavoidable delay into account when programming the next shot.

Nowadays, this is basically an x86+8254 PIT only issue, since on this pla=
tform,=20
one has to go through the ISA bus to (re)program the PIT for the next tim=
er shot,=20
and this is quite expensive (1.5 - 2.5 us for each outb, and you need two=
 of them=20
for programming the shot). Btw, this is the reason why using the APIC whe=
n=20
available on x86 is always a good idea, since it only costs ~100 ns to pr=
ogram the=20
timer there through a memory mapped register.

IOW, the code does not wait for any timer IRQ, but only measures the aver=
age time=20
for setting up the proper hw registers in order to program a timer shot.

> =20
>=20
> How is it realized with a x86 architecture (another timer source?)
>=20

Look at ksrc/arch/*/hal.c, where all archs implement rthal_timer_calibrat=
e() their=20
own way.

> =20
>=20
> Is there any documentation =96 or discussion threads - which gives some=
=20
> information about the use of timers/RTC/TSC with Xenomai?
>=20

Maybe. Try browsing the archive.

> =20
>=20
> Thanks so much for your help
>=20
> =20
>=20
> Kind regards
>=20
> =20
>=20
> Daniel Rossier
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


--=20

Philippe.

