Message-ID: <462CCC9E.1040500@domain.hid>
Date: Mon, 23 Apr 2007 17:11:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0829164EDA0BAE103A3A7309"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix ffnz for 64-bit hosts
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
--------------enig0829164EDA0BAE103A3A7309
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I'm just not sure if "#define _GNU_SOURCE" is the preferred way to go.


Index: xenomai/include/asm-sim/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-sim/system.h
+++ xenomai/include/asm-sim/system.h
@@ -24,6 +24,7 @@
=20
 #include <asm/param.h>
 #include <errno.h>
+#define _GNU_SOURCE
 #include <string.h>
 #include <malloc.h>
 #include <stdlib.h>
@@ -172,7 +173,7 @@ static inline unsigned long long xnarch_
=20
 static inline unsigned long ffnz (unsigned long word)
 {
-    return ffs((int)word) - 1;
+    return ffsl(word) - 1;
 }
=20
 #define xnarch_stack_size(tcb)    0
Index: xenomai/ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ChangeLog
+++ xenomai/ChangeLog
@@ -5,6 +5,8 @@
=20
 	* include/nucleus/system.h: Remove unused (and bogus) ffnz wrapper.
=20
+	* include/asm-sim/system.h: Fix ffnz for 64-bit hosts.
+
 2007-04-19  Philippe Gerum  <rpm@xenomai.org>
=20
 	* ksrc/skins/vrtx/module.c, ksrc/nucleus/pipe.c,


--------------enig0829164EDA0BAE103A3A7309
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLMyeniDOoMHTA+kRAiqKAJsF86Y9kf0tRx1aPZ3uk/hX6qleyQCfZSJG
gm0ZmnBSlcBX6ol8Z+qduIs=
=+W8x
-----END PGP SIGNATURE-----

--------------enig0829164EDA0BAE103A3A7309--

