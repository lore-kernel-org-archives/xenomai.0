From: =?UTF-8?Q?Robert?= <robert-km@domain.hid>
In-Reply-To: <4EA53424.6050803@domain.hid>
References: <584f2ab9.7f72956e.4e78ccaa.5171d@domain.hid>
	<4EA522E1.80207@domain.hid>
	<848f265.55f3d06f.4ea52ce9.ebedc@domain.hid>
	<4EA53424.6050803@domain.hid>
Mime-Version: 1.0
Message-ID: <9a6b34f.290ebc9d.4ea53837.4438c@domain.hid>
Date: Mon, 24 Oct 2011 12:04:39 +0200
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
Cc: xenomai@xenomai.org




Dnia=2024=20pa=C5=BAdziernika=202011=2011:47=20Gilles=20Chanteperdrix=20<=
gilles.chanteperdrix@xenomai.org>=20napisa=C5=82(a):

>=20On=2010/24/2011=2011:16=20AM,=20Robert=20wrote:
>=20>=20
>=20>=20
>=20>=20Dnia=2024=20pa=C5=BAdziernika=202011=2010:33=20Gilles=20Chanteper=
drix=20<gilles.chanteperdrix@xenomai.org>=20napisa=C5=82(a):
>=20>=20
>=20>>=20On=2010/24/2011=2009:53=20AM,=20Robert=20wrote:
>=20>>>
>=20>>>
>=20>>>
>=20>>>=20Dnia=2020=20wrze=C5=9Bnia=202011=2020:13=20Gilles=20Chanteperdr=
ix=20<gilles.chanteperdrix@xenomai.org>=20napisa=C5=82(a):
>=20>>>
>=20>>>>=20On=2009/20/2011=2007:26=20PM,=20Robert=20wrote:
>=20>>>>>=20Can=20someone=20help=20me=20installing=20xenomai=20on=20panda=
?
>=20>>>>>
>=20>>>>>=20What=20should=20I=20do,=20to=20install=20xenomai=20on=20ubunt=
u=20host?
>=20>>>>>=20Download=20kernel=20from=20kernel.org=20and=20patch=20it=20wi=
th=20xenomai=20and=20adeos-patch,=20or=20download=20kernel=20from=20git=20=
repository,=20or=20download=20ubuntu=20image-omap4=20via=20apt-get=20sour=
ce?
>=20>>>>>
>=20>>>>>=20The=20last=20one=20would=20download=202.6.38=20kernel,=20but=20=
there=20is=20no=20adeos=20patch=20for=20this=20version=20yet.
>=20>>>>>=20It=20is=20also=20possible=20to=20download=202.6.37-9,=20but=20=
the=20same=20problem.
>=20>>>>
>=20>>>>=20The=20upcoming=20xenomai=202.6.0=20supports=20panda.=20It=20sh=
ould=20be=20released=20real
>=20>>>>=20soon=20now,=20in=20the=20mean-time,=20you=20can=20try=20xenoma=
i=202.6.0-rc3.
>=20>>>>
>=20>>>>
>=20>>>
>=20>>>=20Hi=20again,
>=20>>>=20I=20have=20downloaded=20xenomai=202.6.0-rc5,=20and=20kernel=202=
.6.38.8=20from=20kernel.org=20to=20ubuntu=2011.04=20on=20pandaboard.
>=20>>>=20Patched=20it=20with=20adeos=20included=20in=20xeno=20package.
>=20>>>
>=20>>>=20Compiled=20the=20kernel,=20modules=20and=20copied=20uImage=20to=
=20boot=20partition.
>=20>>>=20After=20reboot=20i=20got=20the=20following=20dmesg=20|=20grep=20=
-i=20xeno:
>=20>>>=20user@domain.hid
>=20>>>=20[=20=20=20=201.195556]=20I-pipe:=20Domain=20Xenomai=20registere=
d.
>=20>>>=20[=20=20=20=201.195587]=20Xenomai:=20hal/arm=20started.
>=20>>>=20[=20=20=20=201.195861]=20Xenomai:=20scheduling=20class=20idle=20=
registered.
>=20>>>=20[=20=20=20=201.195861]=20Xenomai:=20scheduling=20class=20rt=20r=
egistered.
>=20>>>=20[=20=20=20=201.199798]=20Xenomai:=20real-time=20nucleus=20v2.6.=
0-rc5=20(head)=20loaded.
>=20>>>=20[=20=20=20=201.199798]=20Xenomai:=20debug=20mode=20enabled.
>=20>>>=20[=20=20=20=201.590240]=20Xenomai:=20native=20skin=20init=20fail=
ed,=20code=20-19.
>=20>>>=20[=20=20=20=201.590270]=20Xenomai:=20starting=20POSIX=20services=
.
>=20>>>=20[=20=20=20=201.980804]=20Xenomai:=20POSIX=20skin=20init=20faile=
d,=20code=20-19.
>=20>>>=20[=20=20=20=202.371429]=20Xenomai:=20RTDM=20skin=20init=20failed=
,=20code=20-19.
>=20>>>
>=20>>>=20user@domain.hid
>=20>>>=20user@domain.hid
>=20>>>=20user@domain.hid
>=20>>>
>=20>>>=20user@domain.hid
>=20>>>=20/usr/xenomai/bin/xeno-test-run-wrapper:=2019:=20source:=20not=20=
found
>=20>>>=20./xeno-test=20failed:=20dead=20child=201238=20not=20found!
>=20>>
>=20>>=20That=20is=20surprising,=20what=20shell=20do=20you=20use?=20Have=20=
you=20copied=20all=20files
>=20>>=20installed=20by=20xenomai=20on=20the=20board=20root=20filesystem?=

>=20>=20=20
>=20>=20I'm=20using=20bash.
>=20>=20What=20do=20you=20mean,=20by=20all=20files?=20I=20just=20ran=20ma=
ke=20and=20make=20install.
>=20
>=20I=20take=20it=20you=20are=20not=20cross-compiling=20then?=20Anyway,=20=
to=20understand=20the
>=20bug=20in=20xeno-test,=20you=20should=20try=20adding=20"set=20-x"=20in=

>=20xeno-test-run-wrapper,=20on=20the=20second=20line.

+=20script=3D./xeno-test
+=20shift
+=20source=20./xeno-test
/usr/xenomai/bin/xeno-test-run-wrapper:=201:=20source:=20not=20found
./xeno-test=20failed:=20dead=20child=2010486=20not=20found!



>=20>=20
>=20>=20
>=20>>>
>=20>>>=20user@domain.hid
>=20>>>=20Xenomai:=20incompatible=20feature=20set
>=20>>>=20(userland=20requires=20"kuser=5Ftsc=20fastsynch=20nosmp",=20ker=
nel=20provides=20"sa1100=20v6=20eabi
>=20>>>=20kuser=5Ftsc=20fastsynch=20smp",=20missing=3D"nosmp").
>=20>>>
>=20>>>=20Should=20I=20disable=20smp=20in=20kernel=20config?
>=20>>
>=20>>=20That,=20or=20more=20likely=20enable=20smp=20in=20user-space=20co=
nfiguration.
>=20>>
>=20>=20Now=20I=20try=20to=20compile=20without=20smp.
>=20
>=20I=20would=20recommend=20not=20to=20do=20that.=20SMP=20is=20better=20t=
ested=20than=20!SMP.=20And
>=20anyway,=20it=20is=20a=20bit=20stupid=20to=20only=20use=20one=20core=20=
on=20the=20dual-core=20OMAP4.
>=20
>=20

I=20thought=20it=20may=20cause=20a=20problems.=20So,=20what=20to=20do=20n=
ow?
config=20file=20looks=20good?

