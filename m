From: =?UTF-8?Q?Robert?= <robert-km@domain.hid>
Mime-Version: 1.0
Message-ID: <32d9b02a.29dd933a.4ea82693.8ffcf@domain.hid>
Date: Wed, 26 Oct 2011 17:26:11 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] =?utf-8?q?installing_xenomai_on_pandaboard?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?Q?Gilles_Chanteperdrix?= <gilles.chanteperdrix@xenomai.org>
Cc: =?UTF-8?Q?Xenomai_help?= <xenomai@xenomai.org>


Dnia=2024=20pa=C5=BAdziernika=202011=2022:58=20Gilles=20Chanteperdrix=20<=
gilles.chanteperdrix@xenomai.org>=20napisa=C5=82(a):

>=20On=2010/24/2011=2001:11=20PM,=20Robert=20wrote:
>=20>=20
>=20>=20
>=20>=20
>=20>=20Dnia=2024=20pa=C5=BAdziernika=202011=2013:07=20Gilles=20Chanteper=
drix=20<gilles.chanteperdrix@xenomai.org>=20napisa=C5=82(a):
>=20>=20
>=20>>=20On=2010/24/2011=2012:59=20PM,=20Robert=20wrote:
>=20>>>=20Dnia=2024=20pa=C5=BAdziernika=202011=2012:37=20Gilles=20Chantep=
erdrix=20<gilles.chanteperdrix@xenomai.org>=20napisa=C5=82(a):
>=20>>
>=20>>>>=20Ok.=20Try=20calling=20/usr/xenomai/bin/xeno-test=20instead=20o=
f=20cding=20to=20the
>=20>>>>=20directory=20and=20runing=20./xeno-test.
>=20>>>
>=20>>>=20No=20difference.
>=20>>
>=20>>=20I=20am=20unable=20to=20reproduce=20this=20issue,=20but=20I=20am=20=
using=20ash,=20not=20bash.=20last
>=20>>=20attempt:=20could=20you=20try=20adding=20/usr/xenomai/bin=20to=20=
the=20PATH=20variable?
>=20>=20
>=20>=20The=20same.
>=20
>=20Could=20you=20try=20the=20following=20patch?=20
>=20
>=20http://git.xenomai.org/?p=3Dxenomai-head.git;a=3Dcommitdiff;h=3D8f2fd=
0b49e51fb2547c4972f2cda9e32dfc5dca6;hp=3D82ab99a3a840dd78c3ed8e5a6555f422=
420b7827
>=20
>=20The=20problem=20is=20due=20to=20dash,=20not=20bash,=20which=20is=20li=
nked=20to=20/bin/sh=20by=20
>=20default=20on=20ubuntu.=20
>=20

I=20applied=20Yours=20patches,=20and=20now=20it=20compile=20and=20almost=20=
run:

root@domain.hid=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
Started=20child=201035:=20/bin/bash=20/usr/xenomai/bin/xeno-test-run-wrap=
per=20/usr/xenoma
i/bin/xeno-test=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
++=20echo=200=20

After=20that,=20board=20is=20dead.

And=20I=20have=20to=20build=20xenomai=20sources=20using=20'make=20CFLAGS+=
=3D-Wa,mimplicit-it=3Dthumb'.
My=20gcc=20version=204.5.2-8ubuntu4


>=20>=20
>=20>>>>=20I=20have=20not=20received=20the=20config=20file.
>=20>>
>=20>>>=20CONFIG=5FARCH=5FOMAP2PLUS=5FTYPICAL=3Dy
>=20>>>=20#=20CONFIG=5FARCH=5FOMAP2=20is=20not=20set
>=20>>>=20CONFIG=5FARCH=5FOMAP3=3Dy
>=20>>>=20CONFIG=5FARCH=5FOMAP4=3Dy
>=20>>>=20#=20CONFIG=5FARCH=5FOMAP3430=20is=20not=20set
>=20>>>=20CONFIG=5FOMAP=5FPACKAGE=5FCBL=3Dy
>=20>>>=20CONFIG=5FOMAP=5FPACKAGE=5FCBS=3Dy
>=20>>
>=20>>=20Could=20you=20try=20disabling=20CONFIG=5FOMAP3?
>=20>=20
>=20>=20No.=20While=20running=20"make=20oldconfig"=20CONFIG=5FOMAP3=20aut=
omatically=20set=20to=20yes,=20so=20i=20didn't=20touch=20it.
>=20>=20Ok,=20so=20now=20I=20will=20try=20to=20recompile=20kernel=20with=20=
new=20config.
>=20
>=20The=20error=20is=20indeed=20due=20to=20OMAP3=20+=20OMAP4=20setting.=20=
In=20order=20to=20disable
>=20CONFIG=5FOMAP3,=20you=20have=20to=20unselect=20all=20the=20omap3=20ba=
sed=20boards.=20
>=20"make=20xconfig"=20has=20debug=20options=20allowing=20to=20find=20suc=
h=20dependencies.
>=20

It=20was=20my=20fault.=20While=20compilling=20uImage=20and=20modules=20pa=
nda=20hangs=20up.=20After=20reboot,=20I=20have=20continued=20make=20proce=
ss.
During=20reboot=20time=20has=20changed,=20so=20build=20was=20broken.
I=20have=20rebuild=20the=20kernel,=20and=20now=20everything=20works.
Sorry=20for=20wasting=20Your=20time.


>=20And=20by=20the=20way,=20thanks=20for=20testing=20the=20release=20cand=
idate.
>=20
>=20Regards.
>=20
>=20


