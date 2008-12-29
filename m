Message-ID: <4958E30C.5060103@domain.hid>
Date: Mon, 29 Dec 2008 15:47:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2AF38420C51C312BDF1BBBD1"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] x86-userspace: Turn on SMP by default
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2AF38420C51C312BDF1BBBD1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

A signigicant portion of x86 systems is SMP these days. Turn on the
corresponding user space option to reflect the situation, specifically
as running SMP-enabled libraries on a single-core system is just
slightly suboptimal while the other way around does not work, forcing
the user to rebuild the Xenomai libs.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 configure.in |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/configure.in b/configure.in
index 4300d6f..d665dc6 100644
--- a/configure.in
+++ b/configure.in
@@ -135,6 +135,9 @@ AC_MSG_RESULT(${debug_symbols:-no})
 dnl SMP support (default: off)
=20
 CONFIG_SMP=3D
+if test $XENO_TARGET_ARCH =3D x86; then
+	CONFIG_SMP=3Dy
+fi
 AC_MSG_CHECKING(for SMP support)
 AC_ARG_ENABLE(smp,
 	AS_HELP_STRING([--enable-smp], [Enable SMP support]),


--------------enig2AF38420C51C312BDF1BBBD1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAklY4wwACgkQniDOoMHTA+nGPQCeK2xAZGTgytHdAY3wIDtg7GNQ
8/EAn1Kw3nwSlQRtSiLK8LTFMUxt/AqO
=E4rQ
-----END PGP SIGNATURE-----

--------------enig2AF38420C51C312BDF1BBBD1--

