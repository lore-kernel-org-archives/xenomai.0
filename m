Message-ID: <4958E439.9040503@domain.hid>
Date: Mon, 29 Dec 2008 15:52:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8F4255545E867F3EA13A0FA3"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] Fix include for kernel/panic.c
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8F4255545E867F3EA13A0FA3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Not all archs include ipipe_trace.h implicitly so that bulding
kernel/panic.c may break in oops_enter (seen on ARM with tracer
disabled). Fix this with a proper include.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

---
 kernel/panic.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/kernel/panic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -21,6 +21,7 @@
 #include <linux/debug_locks.h>
 #include <linux/random.h>
 #include <linux/kallsyms.h>
+#include <linux/ipipe_trace.h>
=20
 int panic_on_oops;
 int tainted;


--------------enig8F4255545E867F3EA13A0FA3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAklY5DkACgkQniDOoMHTA+nljQCeLG+wJk98n4O3xa/kehOes3/4
kAEAnjSxC2/goZ1sV6XGwEILLYMbwT8u
=P6ZX
-----END PGP SIGNATURE-----

--------------enig8F4255545E867F3EA13A0FA3--

