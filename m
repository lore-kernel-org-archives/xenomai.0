From: =?UTF-8?Q?Robert?= <robert-km@domain.hid>
In-Reply-To: <4E78D7C0.2090108@domain.hid>
References: <584f2ab9.7f72956e.4e78ccaa.5171d@domain.hid>
	<4E78D7C0.2090108@domain.hid>
Mime-Version: 1.0
Message-ID: <2b889a6c.722ea076.4ea51970.edef6@domain.hid>
Date: Mon, 24 Oct 2011 09:53:20 +0200
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




Dnia=2020=20wrze=C5=9Bnia=202011=2020:13=20Gilles=20Chanteperdrix=20<gill=
es.chanteperdrix@domain.hid>=20napisa=C5=82(a):

>=20On=2009/20/2011=2007:26=20PM,=20Robert=20wrote:
>=20>=20Can=20someone=20help=20me=20installing=20xenomai=20on=20panda?
>=20>=20
>=20>=20What=20should=20I=20do,=20to=20install=20xenomai=20on=20ubuntu=20=
host?
>=20>=20Download=20kernel=20from=20kernel.org=20and=20patch=20it=20with=20=
xenomai=20and=20adeos-patch,=20or=20download=20kernel=20from=20git=20repo=
sitory,=20or=20download=20ubuntu=20image-omap4=20via=20apt-get=20source?
>=20>=20
>=20>=20The=20last=20one=20would=20download=202.6.38=20kernel,=20but=20th=
ere=20is=20no=20adeos=20patch=20for=20this=20version=20yet.
>=20>=20It=20is=20also=20possible=20to=20download=202.6.37-9,=20but=20the=
=20same=20problem.
>=20
>=20The=20upcoming=20xenomai=202.6.0=20supports=20panda.=20It=20should=20=
be=20released=20real
>=20soon=20now,=20in=20the=20mean-time,=20you=20can=20try=20xenomai=202.6=
.0-rc3.
>=20
>=20

Hi=20again,
I=20have=20downloaded=20xenomai=202.6.0-rc5,=20and=20kernel=202.6.38.8=20=
from=20kernel.org=20to=20ubuntu=2011.04=20on=20pandaboard.
Patched=20it=20with=20adeos=20included=20in=20xeno=20package.

Compiled=20the=20kernel,=20modules=20and=20copied=20uImage=20to=20boot=20=
partition.
After=20reboot=20i=20got=20the=20following=20dmesg=20|=20grep=20-i=20xeno=
:
user@domain.hid
[=20=20=20=201.195556]=20I-pipe:=20Domain=20Xenomai=20registered.
[=20=20=20=201.195587]=20Xenomai:=20hal/arm=20started.
[=20=20=20=201.195861]=20Xenomai:=20scheduling=20class=20idle=20registere=
d.
[=20=20=20=201.195861]=20Xenomai:=20scheduling=20class=20rt=20registered.=

[=20=20=20=201.199798]=20Xenomai:=20real-time=20nucleus=20v2.6.0-rc5=20(h=
ead)=20loaded.
[=20=20=20=201.199798]=20Xenomai:=20debug=20mode=20enabled.
[=20=20=20=201.590240]=20Xenomai:=20native=20skin=20init=20failed,=20code=
=20-19.
[=20=20=20=201.590270]=20Xenomai:=20starting=20POSIX=20services.
[=20=20=20=201.980804]=20Xenomai:=20POSIX=20skin=20init=20failed,=20code=20=
-19.
[=20=20=20=202.371429]=20Xenomai:=20RTDM=20skin=20init=20failed,=20code=20=
-19.

user@domain.hid
user@domain.hid
user@domain.hid

user@domain.hid
/usr/xenomai/bin/xeno-test-run-wrapper:=2019:=20source:=20not=20found
./xeno-test=20failed:=20dead=20child=201238=20not=20found!

user@domain.hid
Xenomai:=20incompatible=20feature=20set
(userland=20requires=20"kuser=5Ftsc=20fastsynch=20nosmp",=20kernel=20prov=
ides=20"sa1100=20v6=20eabi
kuser=5Ftsc=20fastsynch=20smp",=20missing=3D"nosmp").

Should=20I=20disable=20smp=20in=20kernel=20config?


