Message-ID: <4630F1F1.6030205@domain.hid>
Date: Thu, 26 Apr 2007 20:39:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9D5CFF2864B51F7B8D199D4D"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 1/7] Tracer build fix for x86_64
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9D5CFF2864B51F7B8D199D4D
Content-Type: multipart/mixed;
 boundary="------------030509020605090801000709"

This is a multi-part message in MIME format.
--------------030509020605090801000709
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Other archs, other kernel versions, other implicit includes. :-/

--------------030509020605090801000709
Content-Type: text/plain;
 name="fix-x86_64-tracer-build.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-x86_64-tracer-build.patch"

---
 kernel/ipipe/tracer.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.20-x64/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20-x64.orig/kernel/ipipe/tracer.c
+++ linux-2.6.20-x64/kernel/ipipe/tracer.c
@@ -29,6 +29,8 @@
 #include <linux/ctype.h>
 #include <linux/vmalloc.h>
 #include <linux/utsrelease.h>
+#include <linux/sched.h>
+#include <linux/ipipe.h>
 #include <linux/ipipe_trace.h>
 #include <asm/uaccess.h>
=20

--------------030509020605090801000709--

--------------enig9D5CFF2864B51F7B8D199D4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMPHxniDOoMHTA+kRAib3AJ92n0mmiZY+DYwuhVmj8TcKSDTumwCeLCGq
/1TVC6qHLp8+UElFeayhxz8=
=K/Vi
-----END PGP SIGNATURE-----

--------------enig9D5CFF2864B51F7B8D199D4D--

