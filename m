Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Usage of sim with xenomai-2.0
Date: Tue, 25 Oct 2005 15:12:24 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E00E6CE2@domain.hid>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


Hi Philippe,

Here is the info about my env:

- kernel 2.6.9
- glibc 2.3.5
- gcc 3.4.4
- actually, I built my env. from scratch (no distro) - simply from =
www.linuxfromscratch.org

But everything else works fine :-) (xenomai works perfectly. I tested it =
with the LinuxTraceToolkit, and it works as well)

Here is the fragment of log, right before the failure (all the =
compilation steps before are OK):


make[4]: Leaving directory =
`/home/rossier/xenomai-2.0/sim/gcic/gcc-build/i686-pc-linux-gnu/libiberty=
'
make[3]: Leaving directory =
`/home/rossier/xenomai-2.0/sim/gcic/gcc-build/i686-pc-linux-gnu/libiberty=
'
make[3]: Entering directory =
`/home/rossier/xenomai-2.0/sim/gcic/gcc-build/i686-pc-linux-gnu/libio'
if [ x"no" =3D xyes ] && [ ! -d pic ]; then \
  mkdir pic; \
else true; fi
touch stamp-picdir
test x"no" !=3D xyes ||\
  /home/rossier/xenomai-2.0/sim/gcic/gcc-build/gcc/xgcc =
-B/home/rossier/xenomai-2.0/sim/gcic/gcc-build/gcc/ =
-B/usr/realtime/libexec/gcic/i686-pc-linux-gnu/bin/ -c -g -O2 -I. =
-I../../../gcc-2.95.3/libio -D_IO_MTSAFE_IO  =
../../../gcc-2.95.3/libio/iogetline.c -o pic/iogetline.o =
/home/rossier/xenomai-2.0/sim/gcic/gcc-build/gcc/xgcc =
-B/home/rossier/xenomai-2.0/sim/gcic/gcc-build/gcc/ =
-B/usr/realtime/libexec/gcic/i686-pc-linux-gnu/bin/ -c -g -O2 -I. =
-I../../../gcc-2.95.3/libio -D_IO_MTSAFE_IO =
../../../gcc-2.95.3/libio/iogetline.c
In file included from ../../../gcc-2.95.3/libio/libio.h:167,
                 from ../../../gcc-2.95.3/libio/iolibio.h:1,
                 from ../../../gcc-2.95.3/libio/libioP.h:47,
                 from ../../../gcc-2.95.3/libio/iogetline.c:26:
/usr/include/bits/stdio-lock.h:24: lowlevellock.h: No such file or =
directory
make[3]: *** [iogetline.o] Error 1
make[3]: Leaving directory =
`/home/rossier/xenomai-2.0/sim/gcic/gcc-build/i686-pc-linux-gnu/libio'
make[2]: *** [all-target-libio] Error 2
make[2]: Leaving directory =
`/home/rossier/xenomai-2.0/sim/gcic/gcc-build'
make[1]: *** [gcc-build/.gcic-built] Error 2
make[1]: Leaving directory `/home/rossier/xenomai-2.0/sim/gcic'
make: *** [all-recursive] Error 1
root@domain.hid#


Thanks a lot.

Cheers

Daniel



-----Message d'origine-----
De=A0: Philippe Gerum [mailto:rpm@xenomai.org
Envoy=E9=A0: mardi, 25. octobre 2005 15:03
=C0=A0: ROSSIER Daniel
Cc=A0: xenomai@xenomai.org
Objet=A0: Re: [Xenomai-help] Usage of sim with xenomai-2.0

ROSSIER Daniel wrote:
> Hi xeno-workers,
>=20
> =20
>=20
> I'm trying to compile the simulator of xenomai-2.0 within a kernel =
2.6.9=20
> but I get
>=20
> the following error when gcc-2.95.3 is being compiled:=20
> "/usr/include/bits/stdio-lock.h:24: lowlevellock.h: No such file or=20
> directory"
>=20
> (I presume that this include is not supported anymore by my current =
libc)
>=20
> =20
>=20
> I'm pretty sure that it is not a new issue - Sorry about this - I=20
> probably missed the workaround.
>=20

This one is new actually. Could you send more information about your =
environment=20
(glibc version, distro, compiler version) and the fragment of the output =
log=20
containing the error message? TIA,

> Please, would you be so kind as to help me?
>=20
> =20
>=20
> Thanks in advance
>=20
> =20
>=20
> Cheers
>=20
> Daniel
>=20
> =20
>=20
> =20
>=20
> =20
>=20
> =20
>=20
> Dr. Daniel Rossier, Professeur
>=20
> REDS, Reconfigurable & Embedded Digital Systems, http://reds.eivd.ch/
>=20
> HES-SO
>=20
> Haute Ecole d'Ing=E9nieurs et de Gestion (HEIG-VD)
>=20
> Rte de Cheseaux 1
>=20
> =20
>=20
> CH-1774 Yverdon-les-Bains
>=20
> =20
>=20
> T=E9l. fixe:     +41 24 557 62 69
>=20
> T=E9l. mobile:   +41 79 292 54 58
>=20
> E-mail:        daniel.rossier@domain.hid =
<mailto:daniel.rossier@domain.hid>
>=20
> =20
>=20
>=20
> =
------------------------------------------------------------------------
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20

Philippe.

