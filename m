From: =?UTF-8?Q?Robert?= <robert-km@domain.hid>
In-Reply-To: <4EA9B774.1020401@domain.hid>
References: <ba98230140e2190e763c418428e3198d.squirrel@domain.hid>
	<4EA9B774.1020401@domain.hid>
Mime-Version: 1.0
Message-ID: <40ce31e8.8bebe60.4eaa7e05.4437d@domain.hid>
Date: Fri, 28 Oct 2011 12:03:49 +0200
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
To: xenomai@xenomai.org, =?UTF-8?Q?Gilles_Chanteperdrix?= <gilles.chanteperdrix@xenomai.org>

Dnia=2027=20pa=C5=BAdziernika=202011=2021:56=20Gilles=20Chanteperdrix=20<=
gilles.chanteperdrix@xenomai.org>=20napisa=C5=82(a):

>=20On=2010/27/2011=2011:05=20AM,=20Gilles=20Chanteperdrix=20wrote:
>=20>=20
>=20>=20
>=20>=20Robert=20wrote:
>=20>>=20Ok,=20so=20now=20latency=20test=20looks=20good,=20but=20board=20=
still=20hangs=20up=20on=20xeno-test.
>=20>>
>=20>=20
>=20>=20Please=20try,=20as=20I=20suggested=20in=20a=20previous=20mail,=20=
to=20get=20the=20kernel=20console
>=20>=20output=20on=20the=20serial=20port,=20and=20see=20if=20the=20hang=20=
is=20not=20due=20to=20a=20kernel
>=20>=20oops.
>=20>=20
>=20>=20And=20I=20am=20also=20asking=20again:=20are=20you=20compiling=20u=
ser-space=20support=20for=20thumb?
>=20>=20
>=20
>=20Hi=20Robert,
>=20
>=20I=20tried=20the=20same=20configuration=20as=20you.=20As=20expected,=20=
the=20bug=20is=20a=20oops,
>=20and=20the=20serial=20console=20helped.=20The=20problem=20is=20CONFIG=5F=
CC=5FSTACKPROTECTOR,
>=20it=20is=20currently=20not=20implemented=20for=20xenomai=20on=20ARM.
>=20
>=20This=20configuration=20will=20cause=20a=20compilation=20error=20in=20=
the=20next=20release.
>=20
>=20Regards.

This=20is=20part=20of=20my=20config.log:
=20
Configured=20with:=20../src/configure=20-v=20--with-pkgversion=3D'Ubuntu/=
Linaro=204.5.2-8ubu
ntu4'=20--with-bugurl=3Dfile:///usr/share/doc/gcc-4.5/README.Bugs=20--ena=
ble-languages
=3Dc,c++,fortran,objc,obj-c++=20--prefix=3D/usr=20--program-suffix=3D-4.5=
=20--enable-shared
--enable-multiarch=20--with-multiarch-defaults=3Darm-linux-gnueabi=20--en=
able-linker-b
uild-id=20--with-system-zlib=20--libexecdir=3D/usr/lib/arm-linux-gnueabi=20=
--without-inc
luded-gettext=20--enable-threads=3Dposix=20--with-gxx-include-dir=3D/usr/=
include/c++/4.5
=20--libdir=3D/usr/lib/arm-linux-gnueabi=20--enable-nls=20--with-sysroot=3D=
/=20--enable-cloc
ale=3Dgnu=20--enable-libstdcxx-debug=20--enable-libstdcxx-time=3Dyes=20--=
enable-plugin=20--e
nable-gold=20--enable-ld=3Ddefault=20--with-plugin-ld=3Dld.gold=20--enabl=
e-objc-gc=20--disab
le-sjlj-exceptions=20--with-arch=3Darmv7-a=20--with-float=3Dsoftfp=20--wi=
th-fpu=3Dvfpv3-d16
--with-mode=3Dthumb=20--disable-werror=20--enable-checking=3Drelease=20--=
build=3Darm-linux-g
nueabi=20--host=3Darm-linux-gnueabi=20--target=3Darm-linux-gnueabi


So=20should=20I=20disable=20CONFIG=5FCC=5FSTACKPROTECTOR=20in=20my=20.con=
fig=20file?

On=20console=20I=20didn't=20get=20anything.

