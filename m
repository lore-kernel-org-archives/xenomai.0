Message-ID: <4710FD80.3050605@domain.hid>
Date: Sat, 13 Oct 2007 19:16:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4710F5A5.4060400@domain.hid>
	<200710131900.56087.Sebastian.Smolorz@domain.hid>
In-Reply-To: <200710131900.56087.Sebastian.Smolorz@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig16757E19C61F21B9FB911E5E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Cross compiling for ARM
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig16757E19C61F21B9FB911E5E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Hi Jan,
>=20
> Jan Kiszka wrote:
>> in order to build Xenomai's userland with a toolchain that is prefixed=

>> with "armv5l-linux-", I had to patch configure.in like this
>>
>> Index: configure.in
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- configure.in	(Revision 3050)
>> +++ configure.in	(Arbeitskopie)
>> @@ -83,7 +83,7 @@ case "$host" in
>>          XENO_LINUX_ARCH=3Dbfinnommu
>>  	XENO_LINUX_INSTALL_TARGET=3Dinstall
>>          ;;
>> - arm-*)
>> + arm*-*)
>>   	XENO_TARGET_ARCH=3Darm
>>   	XENO_LINUX_ARCH=3Darm
>>  	XENO_LINUX_INSTALL_TARGET=3Dinstall_image
>>
>> in order to call "configure --host=3Darmv5l-linux ...". Am I doing
>> something crazy or is this really a required patch for Xenomai?
>=20
> I never had such problems compiling Xenomai for ARM. Our toolchains are=
=20
> generally prefixed with "arm-linux-". For the --host option I=20
> use "--host=3Darm-unknown-linux-gnu". It works without a flaw.

That toolchain is provided by TimeSys, the official BSP provider for
Atmel eval boards etc. So this issue could be a beginners trap...

Jan


--------------enig16757E19C61F21B9FB911E5E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFHEP2AniDOoMHTA+kRAvjPAJig0VsesIAyA90vy3gw7xiGUNXGAJ9Io++f
7eJ4Zqc9HOWgjybmclH3Iw==
=/Vdv
-----END PGP SIGNATURE-----

--------------enig16757E19C61F21B9FB911E5E--

