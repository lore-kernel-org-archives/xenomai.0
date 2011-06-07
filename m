Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 7 Jun 2011 09:57:18 +0200
Message-ID: <3FF315C710820E47A04E55C6F7D9B0AD78FC91@domain.hid>
In-Reply-To: <1306930148.2118.45.camel@domain.hid>
References: <3FF315C710820E47A04E55C6F7D9B0AD78FAF5@domain.hid>
	<1306930148.2118.45.camel@domain.hid>
From: <roderik.wildenburg@domain.hid>
Subject: Re: [Xenomai-help] Xenomai latency measurements
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

Just one more question about the latency test:
Is the "Timer Handler" test an ISR so that the latency of this test =
tells us the interrupt latency or do I have to run an other test to =
determine the interrupt latency?.
If Timer Handler is an ISR could you tell me why "ordinary" Linux load =
has influence on this latency?

I tried to run the latency test also on a kernel 2.4.25 with Xenomai =
2.5.6 but I get the error message " Xenomai: mmap local sem heap: No =
such device or address" (see below). Do you have an idea what is wrong? =
Google says something about a missing /dev/rtheap, but this device is =
available on my system.

Many thanks in advance
Roderik

-------------------------------------------------------------------------=
--------------
mrconfig:/fat/sbin # latency -t0
Xenomai: mmap local sem heap: No such device or address


mrconfig:/fat/sbin # strace latency -t0
execve("/fat/sbin/latency", ["latency", "-t0"], [/* 37 vars */]) =3D 0
:
:
access("/dev/rtheap", F_OK)             =3D 0
rt_sigaction(SIGILL, {0xff23cb8, [ILL], SA_RESTART}, {SIG_DFL}, 8) =3D 0
rt_sigaction(SIGILL, {SIG_DFL}, {0xff23cb8, [ILL], SA_RESTART}, 8) =3D 0
open("/dev/rtheap", O_RDWR)             =3D 3
ioctl(3, 0, 0xcfbf4210)                 =3D 0
mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) =3D -1 ENXIO =
(No such device or address)
close(3)                                =3D 0
dup(2)                                  =3D 3
fcntl64(3, F_GETFL)                     =3D 0x2 (flags O_RDWR)
fstat64(3, {st_mode=3DS_IFCHR|0600, st_rdev=3Dmakedev(4, 64), ...}) =3D =
0
ioctl(3, TCGETS, {B38400 opost isig icanon echo ...}) =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x30016000
_llseek(3, 0, 0x7fffeac8, SEEK_CUR)     =3D -1 ESPIPE (Illegal seek)
write(3, "Xenomai: mmap local sem heap: No"..., 56Xenomai: mmap local =
sem heap: No such device or address
) =3D 56
close(3)                                =3D 0
munmap(0x30016000, 4096)                =3D 0
exit(1)                                 =3D ?

mrconfig:/fat/sbin # ll /dev/rtheap
crw-rw-rw-    1 root     root      10, 254 May 19 14:16 /dev/rtheap
mrconfig:/fat/sbin #
mrconfig:/fat/sbin # uname -r
2.4.25
mrconfig:/fat/sbin # cat /proc/xenomai/version
2.5.6

-------------------------------------------------------------------------=
--------------

> -----Urspr=C3=BCngliche Nachricht-----
> Von: Philippe Gerum [mailto:rpm@xenomai.org]
> Gesendet: Mittwoch, 1. Juni 2011 14:09
> An: Wildenburg, Roderik RAEK1 MRA
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] Xenomai latency measurements
>=20
> On Wed, 2011-06-01 at 13:14 +0200, roderik.wildenburg@domain.hid
> wrote:
> > I performed some measurements with the Xenomai latency test.
> > In case somebody is interested I attached the results for our =
PPC-System
> > (5200B 400MHZ).
> > In this document I also compared latencies of kernel 2.4 with kernel
> > 2.6.
> > Any comments are welcome, especially whether the values I measured =
are
> > reasonable for a 400MHZ PPC.
> >
>=20
> Yes, they look like ok but the CPU frequency is not what makes the
> difference, the performance of the memory subsystem does - =
particularly
> since ppc MMU management is software-assisted.
>=20
> We would have more significant information by comparing Xenomai 2.5.6
> over Linux 2.4.25.
>=20
> > Roderik
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
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
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


