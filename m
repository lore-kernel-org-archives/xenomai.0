From: =?UTF-8?Q?Robert?= <robert-km@domain.hid>
In-Reply-To: <4EA86339.7000309@domain.hid>
References: <32d9b02a.29dd933a.4ea82693.8ffcf@domain.hid>
	<4EA828E2.1070400@domain.hid>
	<168a0ee9.3d0d6b71.4ea84aa9.11249@domain.hid>
	<4EA86339.7000309@domain.hid>
Mime-Version: 1.0
Message-ID: <171459e5.3f006368.4ea87bc0.cda86@domain.hid>
Date: Wed, 26 Oct 2011 23:29:36 +0200
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




Dnia=2026=20pa=C5=BAdziernika=202011=2021:44=20Gilles=20Chanteperdrix=20<=
gilles.chanteperdrix@xenomai.org>=20napisa=C5=82(a):

>=20On=2010/26/2011=2008:00=20PM,=20Robert=20wrote:
>=20>=20
>=20>=20
>=20>=20
>=20>=20Dnia=2026=20pa=C5=BAdziernika=202011=2017:36=20Gilles=20Chanteper=
drix=20<gilles.chanteperdrix@xenomai.org>=20napisa=C5=82(a):
>=20>=20
>=20>>=20On=2010/26/2011=2005:26=20PM,=20Robert=20wrote:
>=20>>>
>=20>>>=20Dnia=2024=20pa=C5=BAdziernika=202011=2022:58=20Gilles=20Chantep=
erdrix=20<gilles.chanteperdrix@xenomai.org>=20napisa=C5=82(a):
>=20>>>
>=20>>>>=20On=2010/24/2011=2001:11=20PM,=20Robert=20wrote:
>=20>>>>>
>=20>>>>>
>=20>>>>>
>=20>>>>>=20Dnia=2024=20pa=C5=BAdziernika=202011=2013:07=20Gilles=20Chant=
eperdrix=20<gilles.chanteperdrix@xenomai.org>=20napisa=C5=82(a):
>=20>>>>>
>=20>>>>>>=20On=2010/24/2011=2012:59=20PM,=20Robert=20wrote:
>=20>>>>>>>=20Dnia=2024=20pa=C5=BAdziernika=202011=2012:37=20Gilles=20Cha=
nteperdrix=20<gilles.chanteperdrix@xenomai.org>=20napisa=C5=82(a):
>=20>>>>>>
>=20>>>>>>>>=20Ok.=20Try=20calling=20/usr/xenomai/bin/xeno-test=20instead=
=20of=20cding=20to=20the
>=20>>>>>>>>=20directory=20and=20runing=20./xeno-test.
>=20>>>>>>>
>=20>>>>>>>=20No=20difference.
>=20>>>>>>
>=20>>>>>>=20I=20am=20unable=20to=20reproduce=20this=20issue,=20but=20I=20=
am=20using=20ash,=20not=20bash.=20last
>=20>>>>>>=20attempt:=20could=20you=20try=20adding=20/usr/xenomai/bin=20t=
o=20the=20PATH=20variable?
>=20>>>>>
>=20>>>>>=20The=20same.
>=20>>>>
>=20>>>>=20Could=20you=20try=20the=20following=20patch?=20
>=20>>>>
>=20>>>>=20http://git.xenomai.org/?p=3Dxenomai-head.git;a=3Dcommitdiff;h=3D=
8f2fd0b49e51fb2547c4972f2cda9e32dfc5dca6;hp=3D82ab99a3a840dd78c3ed8e5a655=
5f422420b7827
>=20>>>>
>=20>>>>=20The=20problem=20is=20due=20to=20dash,=20not=20bash,=20which=20=
is=20linked=20to=20/bin/sh=20by=20
>=20>>>>=20default=20on=20ubuntu.=20
>=20>>>>
>=20>>>
>=20>>>=20I=20applied=20Yours=20patches,=20and=20now=20it=20compile=20and=
=20almost=20run:
>=20>>>
>=20>>>=20root@domain.hid=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>=20>>>=20Started=20child=201035:=20/bin/bash=20/usr/xenomai/bin/xeno-tes=
t-run-wrapper=20/usr/xenoma
>=20>>>=20i/bin/xeno-test=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>=20>>>=20++=20echo=200=20
>=20>>>
>=20>>>=20After=20that,=20board=20is=20dead.
>=20>>>
>=20>>>=20And=20I=20have=20to=20build=20xenomai=20sources=20using=20'make=
=20CFLAGS+=3D-Wa,mimplicit-it=3Dthumb'.
>=20>>>=20My=20gcc=20version=204.5.2-8ubuntu4
>=20>>
>=20>>=20Please=20send=20me=20your=20.config,=20but=20beware=20your=20mai=
ler,=20it=20wraps=20long=20line,
>=20>>=20which=20make=20the=20last=20.config=20you=20sent=20unusable.=20I=
=20have=20not=20tried=20building
>=20>>=20for=20thumb,=20if=20that=20is=20what=20you=20are=20doing.
>=20>>
>=20>>=20You=20can=20try=20running=20the=20"latency"=20command=20alone,=20=
to=20see=20if=20it=20also
>=20>>=20hangs.=20You=20should=20also=20redirect=20the=20kernel=20console=
=20to=20the=20serial=20port,
>=20>>=20and=20capture=20the=20serial=20port=20on=20another=20computer,=20=
in=20case=20the=20hang=20is=20a
>=20>>=20kernel=20oops.
>=20>>
>=20>>=20Find=20attached=20the=20.config=20I=20use,=20and=20which=20works=
=20here.
>=20>=20
>=20>=20
>=20>=20Xenomai:=20incompatible=20feature=20set
>=20>=20(userland=20requires=20"kuser=5Ftsc=20fastsynch=20nosmp",=20kerne=
l=20provides=20"sa1100=20v6=20e
>=20>=20abi=20kuser=5Ftsc=20fastsynch=20smp",=20missing=3D"nosmp").
>=20>=20
>=20>=20I=20still=20don't=20know=20how=20to=20boot=20pandaboard=20with=20=
smp=20support.
>=20>=20
>=20>=20My=20config=20is=20here:=20http://www.copypastecode.com/88653/
>=20
>=20Enable=20SMP=20when=20compiling=20Xenomai=20user-space=20support,=20b=
y=20passing
>=20--enable-smp=20to=20the=20configure=20script.
>=20
>=20>=20
>=20>=20
>=20

Ok,=20so=20now=20latency=20test=20looks=20good,=20but=20board=20still=20h=
angs=20up=20on=20xeno-test.

