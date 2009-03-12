Message-ID: <49B98835.1020000@domain.hid>
Date: Thu, 12 Mar 2009 23:09:57 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <881791.69224.qm@domain.hid>
In-Reply-To: <881791.69224.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] kernel BUG in preempt_schedule_irq
	at	kernel/sched.c:3114!
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: yigal_gold@domain.hid
Cc: xenomai@xenomai.org

Yigal Goldberger wrote:
> Hi,=20
> I've also submitted this on the website under Xenomai-support, but I'm =
not sure which is the best way to go... so I'll try this channel as well.
>

This channel is the best one for now.

> My system is a PPC running kernel 2.6.14.7 patched with Xenomai.=20
> My system communicates with the host PC through two RS-232 ports and ea=
ch port has also a uart connection to a slave device.=20
> The slave device sends interrupts to the CPU on the board , and are han=
dled by a lodable kernel module interrupt handler .=20
> When the system works only through a singel port - (RS-232 between the =
PC and the board,and uart between the board and a slave device) it works =
fine, but when the 2 ports are stressed together I get the Oops below.I'v=
e tried working with the uart without interrupts and the Oops still occur=
es .=20
>=20
>=20
> I've looked it up in the System.map file and the addresses correspond t=
o the following :=20
> c0004c7c - __ipipe_ret_from_except=20
> c0004a40 - somewhere inside resume_kernel.=20
>=20
>=20
> " kernel BUG in preempt_schedule_irq at kernel/sched.c:3114!=20
> Oops: Exception in kernel mode, sig: 5 [#1]=20
> PREEMPT=20
> NIP: C02297A8 LR: C0004A40 SP: C0286170 REGS: c02860c0 TRAP: 0700 Taint=
ed: P=20
> MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11=20
> TASK =3D c0265b00[0] 'swapper' THREAD: c0286000=20
> Last syscall: 120=20
> GPR00: 00000001 C0286170 C0265B00 00009032 00000000 00003032 00600084 C=
02B5594=20
> GPR08: C0280000 C0286000 00000001 C026A200 512037AD 4377FFBF 0FFFD000 0=
0000000=20
> GPR16: 00000001 00000001 FFFFFFFF 007FFF00 0FFF7E68 00000000 00000002 0=
FBC62B0=20
> GPR24: 00000000 00000000 40000000 007FFF7D 007FFF00 C02A0000 C0265B00 C=
02A28F0=20
> Call trace: [c0004a40] [c0004c7c] [c0004c7c] [c0004c7c] [c0004c7c] [c00=
04c7c] [c0004c7c] [c0004c7c] [c0004c7c] [c0004c7c] [c0004c7c] [c0004c7c] =
[c0004c7c] [c0004c7c] [c0004c7c]=20
> Kernel panic - not syncing: Attempted to kill the idle task!=20
> <0>Rebooting in 1 seconds..=FE "=20
>=20
>=20
> Does anyone have an idea why this is happening and what am I doing wron=
g ?=20
>=20

Your kernel is outdated. I-pipe patches for 2.6.14 were not fully PREEMPT=
-safe.=20
Disable CONFIG_PREEMPT and try again, but there is no guarantee you won't=
 face=20
other issues that have been fixed in the I-pipe support for recent kernel=
s.=20
2.6.20 is the oldest release that I would recommend for running a powerpc=
=20
plateform w/ Xenomai over the Linux 2.6.x series; earlier I-pipe patches =
for=20
2.6.x/powerpc may have stability and performances issues.

>=20
> Thanks,=20
> Yigal.=20
>=20
>=20
>=20
>=20
>      =20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--=20
Philippe.

