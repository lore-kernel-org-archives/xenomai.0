Message-ID: <4358A665.2020903@domain.hid>
Date: Fri, 21 Oct 2005 10:27:17 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig29DD17D8F4769E8D3DA532B3"
Subject: [Xenomai-core] [patch] signedness issues in testsuite
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
--------------enig29DD17D8F4769E8D3DA532B3
Content-Type: multipart/mixed; boundary="------------070003030205000902030004"

This is a multi-part message in MIME format.
--------------070003030205000902030004
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Fixes gcc-4 warnings.

Jan


--------------070003030205000902030004
Content-Type: text/plain;
 name="signedness.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="signedness.patch"

Index: testsuite/latency/latency.c
===================================================================
--- testsuite/latency/latency.c	(revision 54)
+++ testsuite/latency/latency.c	(working copy)
@@ -40,9 +40,9 @@
 #define WARMUP_TIME 1
 #define HISTOGRAM_CELLS 100
 int histogram_size = HISTOGRAM_CELLS;
-unsigned long *histogram_avg = NULL,
-    *histogram_max = NULL,
-    *histogram_min = NULL;
+long *histogram_avg = NULL,
+     *histogram_max = NULL,
+     *histogram_min = NULL;
 
 int do_histogram = 0, do_stats = 0, finished = 0;
 int bucketsize = 1000;  /* default = 1000ns, -B <size> to override */
Index: testsuite/klatency/latency.c
===================================================================
--- testsuite/klatency/latency.c	(revision 54)
+++ testsuite/klatency/latency.c	(working copy)
@@ -12,9 +12,9 @@
 
 #define HISTOGRAM_CELLS 200
 int histogram_size = HISTOGRAM_CELLS;
-unsigned long *histogram_avg = NULL,
-              *histogram_max = NULL,
-              *histogram_min = NULL;
+long *histogram_avg = NULL,
+     *histogram_max = NULL,
+     *histogram_min = NULL;
 
 int do_histogram = 0, do_stats = 0, finished = 0;
 int bucketsize = 1000;		/* bucketsize */

--------------070003030205000902030004--

--------------enig29DD17D8F4769E8D3DA532B3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDWKZlncNeS9Q0k+IRAlukAJ0evtQeAUJLVaHRKeVBpeIQ5FBl4wCbBCkl
f5srmmNua6jrMr2v3QdpoHs=
=T327
-----END PGP SIGNATURE-----

--------------enig29DD17D8F4769E8D3DA532B3--

