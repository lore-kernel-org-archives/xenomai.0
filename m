From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Thu, 9 Jun 2011 10:22:22 +0200
References: <67271.69338.qm@domain.hid>
In-Reply-To: <67271.69338.qm@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2665367.pKQPO5C0WI";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201106091022.30083.kisda@domain.hid>
Subject: Re: [Xenomai-help] Version mismatched during xenomai installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: nabanjan das <nabanjan@domain.hid>
Cc: xenomai@xenomai.org

--nextPart2665367.pKQPO5C0WI
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Am Donnerstag 09 Juni 2011, 09.33:04 schrieb nabanjan das:
> Hi,
>=20
> [...]
>=20
> The error message in a step at end for which I want a solution:
>=20
> prototype:~/merchant/linux-2.6.35.9# CONCURRENCY_LEVEL=3D2 CLEAN_SOURCE=
=3Dno
> fakeroot make-kpkg --initrd --append-to-version -xenomai-2.5.6 --revision
> 1.0 kernel_image kernel_headers exec debian/rules  DEBIAN_REVISION=3D1.0
>  APPEND_TO_VERSION=3D-xenomai-2.5.6  INITRD=3DYES  kernel_image kernel_he=
aders
> /usr/bin/make -f ./debian/rules       =20
> debian/stamp/binary/pre-linux-image-2.6.35.9-xenomai-2.5.6 make[1]:
> Entering directory `/root/merchant/linux-2.6.35.9'
> =3D=3D=3D=3D=3D=3D making target
> debian/stamp/install/linux-image-2.6.35.9-xenomai-2.5.6 [new prereqs:
> ]=3D=3D=3D=3D=3D=3D This is kernel package version 11.015.
> echo "The UTS Release version in include/linux/version.h"; echo "       =
=20
>  \"\" "; echo "does not match current version:"; echo "       =20
>  \"2.6.35.9-xenomai-2.5.6\" "; echo "Please correct this."; exit 2 The UTS
> Release version in include/linux/version.h
>            ""=20
> does not match current version:
>            "2.6.35.9-xenomai-2.5.6"=20
> Please correct this.
> make[1]: *** [debian/stamp/install/linux-image-2.6.35.9-xenomai-2.5.6]
> Error 2 make[1]: Leaving directory `/root/merchant/linux-2.6.35.9'
> make: *** [kernel_image] Error 2

Please run "make-kpkg clean" and retry to build the kernel after that.

This looks like debian 5.0 lenny (released February 2009). The last time i=
=20
checked with (old) lenny was in January 2011 with kernel 2.6.32 and it work=
ed.=20
Maybe there is a incompatibility between kernel-package 11.015 from lenny a=
nd=20
newer kernels.

If "make-kpkg clean" doesnt help consider upgrading to debian 6.0 squeeze=20
(released February 2011).

Sidenote: don't build packages/kernels as root.

Stefan

--nextPart2665367.pKQPO5C0WI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk3wgr4ACgkQIPTw9rIdn6rkBwCeN5lehfY+5GUdH4HiOl5QkWTM
MOkAnjgUXtaT6ZK3vTIIlrtbfXc961t1
=FNdl
-----END PGP SIGNATURE-----

--nextPart2665367.pKQPO5C0WI--

