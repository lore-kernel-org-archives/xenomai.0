Message-ID: <466EE437.40905@domain.hid>
Date: Tue, 12 Jun 2007 20:21:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig21555103AA730DCF895147EA"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH] link-check sched_setaffinity
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig21555103AA730DCF895147EA
Content-Type: multipart/mixed;
 boundary="------------060401050405080107070205"

This is a multi-part message in MIME format.
--------------060401050405080107070205
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

as indicated earlier, there is an issue with uClibc from the blackfin
distribution: AC_TRY_COMPILE succeeds, but linking later on fails.

So my suggestion is to try to link already during configure (and test
for missing defines differently).

Jan

--------------060401050405080107070205
Content-Type: text/plain;
 name="link-check-sched_setaffinity.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="link-check-sched_setaffinity.patch"

Index: configure.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- configure.in	(Revision 2571)
+++ configure.in	(Arbeitskopie)
@@ -516,12 +516,12 @@
 AC_CACHE_VAL(ac_cv_sched_setaffinity,
  save_CFLAGS=3D"$CFLAGS"
  CFLAGS=3D"-Wimplicit-function-declaration -Werror -D_GNU_SOURCE"
- [AC_TRY_COMPILE([#include <sched.h>],
+ [AC_TRY_LINK([#include <sched.h>],
  [cpu_set_t cpu_set; sched_setaffinity(0, sizeof(cpu_set), &cpu_set);],
  [ac_cv_sched_setaffinity=3Dnew],
  [ac_cv_sched_setaffinity=3Dbad])]
  if test $ac_cv_sched_setaffinity =3D bad ; then
-   [AC_TRY_COMPILE([#include <sched.h>],
+   [AC_TRY_LINK([#include <sched.h>],
    [cpu_set_t cpu_set; sched_setaffinity(0, &cpu_set);],
    [ac_cv_sched_setaffinity=3Dold],
    [ac_cv_sched_setaffinity=3Dno])]
Index: src/testsuite/switchtest/switchtest.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/switchtest/switchtest.c	(Revision 2571)
+++ src/testsuite/switchtest/switchtest.c	(Arbeitskopie)
@@ -27,8 +27,10 @@
 typedef unsigned long cpu_set_t;
 #endif
 #define do_sched_setaffinity(pid,len,mask) 0
+#ifndef CPU_ZERO
 #define	 CPU_ZERO(set)		do { *(set) =3D 0; } while(0)
 #define	 CPU_SET(n,set) 	do { *(set) |=3D (1 << n); } while(0)
+#endif
 #endif /* HAVE_OLD_SETAFFINITY */
 #endif /* HAVE_RECENT_SETAFFINITY */
=20
Index: src/testsuite/clocktest/clocktest.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/clocktest/clocktest.c	(Revision 2571)
+++ src/testsuite/clocktest/clocktest.c	(Arbeitskopie)
@@ -18,6 +18,7 @@
=20
 #include <errno.h>
 #include <pthread.h>
+#include <sched.h>
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -35,8 +36,10 @@
 typedef unsigned long cpu_set_t;
 #endif
 #define sched_setaffinity(pid, len, mask)	do { } while (0)
+#ifndef CPU_ZERO
 #define CPU_ZERO(set)				memset(set, 0, sizeof(*set))
 #define CPU_SET(n, set)				do { } while (0)
+#endif
 #endif /* !HAVE_OLD_SETAFFINITY */
 #endif /* !HAVE_RECENT_SETAFFINITY */
=20

--------------060401050405080107070205--

--------------enig21555103AA730DCF895147EA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGbuQ3niDOoMHTA+kRAshTAJ0WMtiFtWHa/0ApPPkyKiemw5ZezwCfXA7A
/c3vhMLP+8EPPEu1K4jFHJg=
=7CAG
-----END PGP SIGNATURE-----

--------------enig21555103AA730DCF895147EA--

