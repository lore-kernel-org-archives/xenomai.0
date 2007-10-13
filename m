Message-ID: <4710F5A5.4060400@domain.hid>
Date: Sat, 13 Oct 2007 18:43:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig815843010351A108F3DC7065"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Cross compiling for ARM
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig815843010351A108F3DC7065
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi all,

in order to build Xenomai's userland with a toolchain that is prefixed
with "armv5l-linux-", I had to patch configure.in like this

Index: configure.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- configure.in	(Revision 3050)
+++ configure.in	(Arbeitskopie)
@@ -83,7 +83,7 @@ case "$host" in
         XENO_LINUX_ARCH=3Dbfinnommu
 	XENO_LINUX_INSTALL_TARGET=3Dinstall
         ;;
- arm-*)
+ arm*-*)
  	XENO_TARGET_ARCH=3Darm
  	XENO_LINUX_ARCH=3Darm
 	XENO_LINUX_INSTALL_TARGET=3Dinstall_image

in order to call "configure --host=3Darmv5l-linux ...". Am I doing
something crazy or is this really a required patch for Xenomai?

Jan


--------------enig815843010351A108F3DC7065
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHEPWlniDOoMHTA+kRAm+AAJ972jir9EZo0pXlsZdDVN4OXnzRYgCdGlfS
9y3ZjkamfmvnJx3e1+UVaXo=
=AgI5
-----END PGP SIGNATURE-----

--------------enig815843010351A108F3DC7065--

