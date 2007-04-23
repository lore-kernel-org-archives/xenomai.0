Message-ID: <462CCB4C.8040900@domain.hid>
Date: Mon, 23 Apr 2007 17:05:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA572D92BCF8724EFD6BFD9F8"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] cleanup ffnz from nucleus/system.h
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
--------------enigA572D92BCF8724EFD6BFD9F8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Index: xenomai/ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ChangeLog
+++ xenomai/ChangeLog
@@ -3,6 +3,8 @@
 	* include/asm-x86_64/hal.h (ffnz): Fix typo that inverted the search
 	direction.
=20
+	* include/nucleus/system.h: Remove unused (and bogus) ffnz wrapper.
+
 2007-04-19  Philippe Gerum  <rpm@xenomai.org>
=20
 	* ksrc/skins/vrtx/module.c, ksrc/nucleus/pipe.c,
Index: xenomai/include/nucleus/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/system.h
+++ xenomai/include/nucleus/system.h
@@ -24,11 +24,6 @@
 #include <string.h>
 #include <asm/param.h>
=20
-static inline unsigned long ffnz (unsigned long ul)
-{
-    return ffs((int)ul) - 1;
-}
-
 #include <asm/xenomai/atomic.h>
 #include <nucleus/core.h>
 #include <nucleus/trace.h>


--------------enigA572D92BCF8724EFD6BFD9F8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLMtMniDOoMHTA+kRAozYAJwPRZ0KnRd612NFH2LNV2h+wDfwlQCeIwoW
alOBqPWknsuEbb8wgp5AnYg=
=Xl7o
-----END PGP SIGNATURE-----

--------------enigA572D92BCF8724EFD6BFD9F8--

