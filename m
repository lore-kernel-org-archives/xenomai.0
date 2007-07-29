Message-ID: <46ACEE55.8050101@domain.hid>
Date: Sun, 29 Jul 2007 21:45:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig468606D3189D071DEE420D58"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix non-RPI build
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig468606D3189D071DEE420D58
Content-Type: multipart/mixed;
 boundary="------------090805010209070509060504"

This is a multi-part message in MIME format.
--------------090805010209070509060504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


--------------090805010209070509060504
Content-Type: text/x-patch;
 name="fix-no-rpi-build.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-no-rpi-build.patch"

Index: ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/shadow.c	(Revision 2865)
+++ ksrc/nucleus/shadow.c	(Arbeitskopie)
@@ -496,6 +496,7 @@ void xnshadow_rpi_check(void)
 =20
 #else
=20
+#define rpi_p(t)		(0)
 #define rpi_init_gk(gk)		do { } while(0)
 #define rpi_clear_local(t)	do { } while(0)
 #define rpi_clear_remote(t)	do { } while(0)

--------------090805010209070509060504--

--------------enig468606D3189D071DEE420D58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGrO5ZniDOoMHTA+kRAvAjAJ99AHFrI1E5BPTnU8e4JQnG8lqaWwCfa8gC
MgFQTMlQWmP4aQA10GVOTiI=
=MXRv
-----END PGP SIGNATURE-----

--------------enig468606D3189D071DEE420D58--

