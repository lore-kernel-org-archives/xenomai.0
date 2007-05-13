Message-ID: <46476686.8020407@domain.hid>
Date: Sun, 13 May 2007 21:27:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5DC34CFE1652479E85E63339"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [RFC][PATCH 2/2] Dump ipipe trace on kernel oopses
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5DC34CFE1652479E85E63339
Content-Type: multipart/mixed;
 boundary="------------000802060402030609020006"

This is a multi-part message in MIME format.
--------------000802060402030609020006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This is not a must-have, and it is not for all archs so far anyway:

Dump an I-pipe panic trace on ordinary kernel oopses. For me this turned
out to be useful already, but not everyone may love to see his/her
console flooded with call-history traces on oops, though this only
happens if the tracer is enabled.

Comments welcome.

Jan

--------------000802060402030609020006
Content-Type: text/x-patch;
 name="ipipe-trace-on-oops.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="ipipe-trace-on-oops.patch"

---
 arch/i386/mm/fault.c |    5 +++++
 lib/bust_spinlocks.c |    5 +++++
 2 files changed, 10 insertions(+)

Index: linux-2.6.20/arch/i386/mm/fault.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/arch/i386/mm/fault.c
+++ linux-2.6.20/arch/i386/mm/fault.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
+#include <linux/ipipe_trace.h>
=20
 #include <asm/system.h>
 #include <asm/desc.h>
@@ -68,9 +69,13 @@ void bust_spinlocks(int yes)
 	int loglevel_save =3D console_loglevel;
=20
 	if (yes) {
+		ipipe_trace_panic_freeze();
 		oops_in_progress =3D 1;
 		return;
 	}
+
+	ipipe_trace_panic_dump();
+
 #ifdef CONFIG_VT
 	unblank_screen();
 #endif
Index: linux-2.6.20/lib/bust_spinlocks.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/lib/bust_spinlocks.c
+++ linux-2.6.20/lib/bust_spinlocks.c
@@ -12,14 +12,19 @@
 #include <linux/tty.h>
 #include <linux/wait.h>
 #include <linux/vt_kern.h>
+#include <linux/ipipe_trace.h>
=20
=20
 void bust_spinlocks(int yes)
 {
 	if (yes) {
+		ipipe_trace_panic_freeze();
 		oops_in_progress =3D 1;
 	} else {
 		int loglevel_save =3D console_loglevel;
+
+		ipipe_trace_panic_dump();
+
 #ifdef CONFIG_VT
 		unblank_screen();
 #endif

--------------000802060402030609020006--

--------------enig5DC34CFE1652479E85E63339
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGR2aGniDOoMHTA+kRAnjTAJ9foQipojw6nL0rLgoiwAI8RsPK8wCfW1Mx
5tMMcesOFsBSq1IbYNv7GL8=
=T/4O
-----END PGP SIGNATURE-----

--------------enig5DC34CFE1652479E85E63339--

