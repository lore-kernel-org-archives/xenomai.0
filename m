Message-ID: <435E8647.2030501@domain.hid>
Date: Tue, 25 Oct 2005 21:23:51 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Usage of sim with xenomai-2.0
References: <FDBBB5CC70676540B3EF7CFE83FD94E00E6CE2@domain.hid>
	<435E3A68.9090601@domain.hid>
	<FDBBB5CC70676540B3EF7CFE83FD94E0043049@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0043049@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

ROSSIER Daniel wrote:
> Ok, I will also try to have a look. Maybe, an idea would be to migrate =
to gcc-3.4.4 for the code
> instrumentation...Are there specific issues related to the gcc version =
for that?
>=20

There is big issue, unfortunately: the instrumenter is based on a patch a=
gainst=20
the C and C++ parsers that provides the needed support to insert code on-=
the-fly=20
into the user code; it is this code which actually binds the application =
to the=20
simulation engine. Crafting this patch is a rather complex business becau=
se you=20
have to tap directly into GCC's lexer and grammar parser, and quite frank=
ly,=20
this is something I'm really reluctant to start anew on a radically diffe=
rent=20
GCC parsing engine, at least now, with respect to the actual benefit upgr=
ading=20
the instrumenter base would bring. Again, usefulness / complexity ratio i=
ssue.

> Daniel
>=20
>=20
> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org]
> Sent: Tue 10/25/2005 4:00 PM
> To: ROSSIER Daniel
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Usage of sim with xenomai-2.0
> =20
> ROSSIER Daniel wrote:
>=20
>>Hi Philippe,
>>
>>Here is the info about my env:
>>
>>- kernel 2.6.9
>>- glibc 2.3.5
>>- gcc 3.4.4
>>- actually, I built my env. from scratch (no distro) - simply from www.=
linuxfromscratch.org
>>
>>But everything else works fine :-) (xenomai works perfectly. I tested i=
t with the LinuxTraceToolkit, and it works as well)
>>
>>Here is the fragment of log, right before the failure (all the compilat=
ion steps before are OK):
>>
>>
>>make[4]: Leaving directory `/home/rossier/xenomai-2.0/sim/gcic/gcc-buil=
d/i686-pc-linux-gnu/libiberty'
>>make[3]: Leaving directory `/home/rossier/xenomai-2.0/sim/gcic/gcc-buil=
d/i686-pc-linux-gnu/libiberty'
>>make[3]: Entering directory `/home/rossier/xenomai-2.0/sim/gcic/gcc-bui=
ld/i686-pc-linux-gnu/libio'
>>if [ x"no" =3D xyes ] && [ ! -d pic ]; then \
>>  mkdir pic; \
>>else true; fi
>>touch stamp-picdir
>>test x"no" !=3D xyes ||\
>>  /home/rossier/xenomai-2.0/sim/gcic/gcc-build/gcc/xgcc -B/home/rossier=
/xenomai-2.0/sim/gcic/gcc-build/gcc/ -B/usr/realtime/libexec/gcic/i686-pc=
-linux-gnu/bin/ -c -g -O2 -I. -I../../../gcc-2.95.3/libio -D_IO_MTSAFE_IO=
  ../../../gcc-2.95.3/libio/iogetline.c -o pic/iogetline.o /home/rossier/=
xenomai-2.0/sim/gcic/gcc-build/gcc/xgcc -B/home/rossier/xenomai-2.0/sim/g=
cic/gcc-build/gcc/ -B/usr/realtime/libexec/gcic/i686-pc-linux-gnu/bin/ -c=
 -g -O2 -I. -I../../../gcc-2.95.3/libio -D_IO_MTSAFE_IO ../../../gcc-2.95=
.3/libio/iogetline.c
>>In file included from ../../../gcc-2.95.3/libio/libio.h:167,
>>                 from ../../../gcc-2.95.3/libio/iolibio.h:1,
>>                 from ../../../gcc-2.95.3/libio/libioP.h:47,
>>                 from ../../../gcc-2.95.3/libio/iogetline.c:26:
>>/usr/include/bits/stdio-lock.h:24: lowlevellock.h: No such file or dire=
ctory
>>make[3]: *** [iogetline.o] Error 1
>>make[3]: Leaving directory `/home/rossier/xenomai-2.0/sim/gcic/gcc-buil=
d/i686-pc-linux-gnu/libio'
>>make[2]: *** [all-target-libio] Error 2
>>make[2]: Leaving directory `/home/rossier/xenomai-2.0/sim/gcic/gcc-buil=
d'
>>make[1]: *** [gcc-build/.gcic-built] Error 2
>>make[1]: Leaving directory `/home/rossier/xenomai-2.0/sim/gcic'
>>make: *** [all-recursive] Error 1
>>root@domain.hid#
>>
>=20
>=20
> It seems to be an incompatibility issue between the NPTL and gcc-2.95.x=
:
> http://sources.redhat.com/ml/glibc-bugs/2004-06/msg00144.html
>=20
> The best way to solve this would be to get rid of the MT support for bu=
ilding=20
> the GCC-based instrumenter, since we don't need it, and libio/ compilat=
ion would=20
> not break. I'll look at some way to fix this.
>=20
>=20
>>Thanks a lot.
>>
>>Cheers
>>
>>Daniel
>>
>>
>>
>>-----Message d'origine-----
>>De : Philippe Gerum [mailto:rpm@xenomai.org
>>Envoy=E9 : mardi, 25. octobre 2005 15:03
>>=C0 : ROSSIER Daniel
>>Cc : xenomai@xenomai.org
>>Objet : Re: [Xenomai-help] Usage of sim with xenomai-2.0
>>
>>ROSSIER Daniel wrote:
>>
>>
>>>Hi xeno-workers,
>>>
>>>
>>>
>>>I'm trying to compile the simulator of xenomai-2.0 within a kernel 2.6=
.9=20
>>>but I get
>>>
>>>the following error when gcc-2.95.3 is being compiled:=20
>>>"/usr/include/bits/stdio-lock.h:24: lowlevellock.h: No such file or=20
>>>directory"
>>>
>>>(I presume that this include is not supported anymore by my current li=
bc)
>>>
>>>
>>>
>>>I'm pretty sure that it is not a new issue - Sorry about this - I=20
>>>probably missed the workaround.
>>>
>>
>>
>>This one is new actually. Could you send more information about your en=
vironment=20
>>(glibc version, distro, compiler version) and the fragment of the outpu=
t log=20
>>containing the error message? TIA,
>>
>>
>>
>>>Please, would you be so kind as to help me?
>>>
>>>
>>>
>>>Thanks in advance
>>>
>>>
>>>
>>>Cheers
>>>
>>>Daniel
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>Dr. Daniel Rossier, Professeur
>>>
>>>REDS, Reconfigurable & Embedded Digital Systems, http://reds.eivd.ch/
>>>
>>>HES-SO
>>>
>>>Haute Ecole d'Ing=E9nieurs et de Gestion (HEIG-VD)
>>>
>>>Rte de Cheseaux 1
>>>
>>>
>>>
>>>CH-1774 Yverdon-les-Bains
>>>
>>>
>>>
>>>T=E9l. fixe:     +41 24 557 62 69
>>>
>>>T=E9l. mobile:   +41 79 292 54 58
>>>
>>>E-mail:        daniel.rossier@domain.hid <mailto:daniel.rossier@domain.hid=
d.ch>
>>>
>>>
>>>
>>>
>>>----------------------------------------------------------------------=
--
>>>
>>>_______________________________________________
>>>Xenomai-help mailing list
>>>Xenomai-help@domain.hid
>>>https://mail.gna.org/listinfo/xenomai-help
>>
>>
>>
>=20
>=20


--=20

Philippe.

