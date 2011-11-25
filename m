From: =?UTF-8?Q?Robert?= <robert-km@domain.hid>
In-Reply-To: <1322041129.15019.7.camel@domain.hid>
References: <1322041129.15019.7.camel@domain.hid>
Mime-Version: 1.0
Message-ID: <414be62.7ed9feda.4ecf92ea.afbae@domain.hid>
Date: Fri, 25 Nov 2011 14:06:50 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help]
	=?utf-8?q?can=27t_link_math=2Eh_in_a_userspace_pro?=
	=?utf-8?q?gramm?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, =?UTF-8?Q?Erik_Sommer?= <erik.sommer@domain.hid>

Hi,
have=20You=20tried=20to=20add=20'-lm'=20to=20LDFLAGS?
It=20adds=20math=20library=20while=20linking=20program.


Dnia=2023=20listopada=202011=2010:38=20Erik=20Sommer=20<erik.sommer@domain.hid=
r.de>=20napisa=C5=82(a):

>=20Hello,
>=20
>=20I'm=20programming=20a=20userspace=20Xenomai-Programm=20f=C3=BCr=20a=20=
Xilinx=20PowerPC
>=20(additional=20Information=20without=20FPU).=20I=20include=20the=20mat=
h.h=20because=20I
>=20have=20to=20use=20arcustangens=20and=20arcuscosinus.=20When=20compili=
ng=20the=20programm
>=20it=20seems=20so=20like=20the=20linker=20can't=20do=20his=20job=20for=20=
math.h.
>=20
>=20minimal=20example:
>=20
>=20"
>=20#include=20<stdbool.h>//=20boolescher=20Datentyp
>=20#include=20<native/task.h>
>=20#include=20<native/timer.h>
>=20#include=20<rtdm/rtdm.h>
>=20#include=20<sys/mman.h>
>=20#include=20<stdio.h>
>=20#include=20<fcntl.h>
>=20#include=20<unistd.h>
>=20#include=20<math.h>
>=20
>=20void=20user=5Ftask(void=20*cookie){
>=20...
>=20Vektor.y=5Fw=3D0.5*atan(Vektor.y/reg->l=5FO);
>=20...
>=20}
>=20"
>=20
>=20the=20Makefile:
>=20
>=20"
>=20#=20Name=20der=20zu=20erstellenden=20Programmdatei
>=20PROG=3Dpu10=5FLas=5FVek
>=20
>=20#=20Liste=20der=20C-Dateien=20im=20Verzeichnis
>=20C=5FDAT=3D$(wildcard=20*.c)
>=20
>=20
>=20#=20Variablen=20f=C3=BCr=20die=20Benutzung=20des=20ELDK-Compilers
>=20ARCH=3Dpowerpc
>=20
>=20#Xenomai=20Installations=20Pfad
>=20DESTDIR=3D../usersupport/root
>=20#DESTDIR=3D/mnt/albatros=5Fprojekte/PU10/pu10=5Fsw/PU10=5FXenomai/xen=
omai=5Fbuild/root
>=20XENO=20:=3D=20$(DESTDIR)/usr/xenomai
>=20
>=20XENOCONFIG=3D$(shell=20PATH=3D$(XENO):$(XENO)/bin:$(PATH)=20which=20x=
eno-config
>=202>/dev/null)
>=20
>=20CC=3D$(shell=20$(XENOCONFIG)=20--cc)
>=20
>=20CFLAGS=3D$(shell=20export=20DESTDIR=3D"$(DESTDIR)";=20$(XENOCONFIG)=20=
--skin=20native
>=20--cflags)=20$(MY=5FCFLAGS)
>=20
>=20LDFLAGS=3D$(shell=20export=20DESTDIR=3D"$(DESTDIR)";=20$(XENOCONFIG)=20=
--skin=20native
>=20--ldflags)=20$(MY=5FLDFLAGS)=20-lnative=20-lrtdm
>=20
>=20#Xenomai=20Library=20Pfad=20in=20binary=20hinzuf=C3=BCgen
>=20LPATH=3D/usr/xenomai/lib
>=20#LDFLAGS+=3D-Xlinker=20-rpath=20-Xlinker=20$(shell=20$(XENOCONFIG)=20=
--libdir)
>=20LDFLAGS+=3D-Xlinker=20-rpath=20-Xlinker=20$(LPATH)=20
>=20
>=20$(PROG)::=20
>=20=09$(CC)=20-Wall=20$(CFLAGS)=20$(LDFLAGS)=20-L/usr/lib=20-I/usr/inclu=
de
>=20$(C=5FDAT)=20../defines.h=20../regbank.h=20-o=20$(PROG)=09
>=20
>=20clean::
>=20=09$(RM)=20$(PROG)=20*.o
>=20"
>=20
>=20I=20hope=20for=20some=20hints.
>=20
>=20Erik=20
>=20
>=20
>=20
>=20
>=20=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
>=20Xenomai-help=20mailing=20list
>=20Xenomai-help@domain.hid
>=20https://mail.gna.org/listinfo/xenomai-help
>=20

