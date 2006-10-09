Message-ID: <452A4169.9050901@domain.hid>
Date: Mon, 09 Oct 2006 14:32:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig85CBB47A991B64C8D04D8872"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] cleanup xeno-config output
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
--------------enig85CBB47A991B64C8D04D8872
Content-Type: multipart/mixed; boundary="------------040602040703000504020106"

This is a multi-part message in MIME format.
--------------040602040703000504020106
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Following the discussion in an earlier thread, this patch reduces the
CFLAGS and LDFLAGS returned by xeno-config to the required minimum.

Compile tested with several external packages, no regression known
(except that one may want to set some of those flags elsewhere now).

Jan

--------------040602040703000504020106
Content-Type: text/plain;
 name="xeno-config-cleanup.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xeno-config-cleanup.patch"

---
 ChangeLog              |    8 +++++++-
 configure.in           |   13 ++++++-------
 scripts/xeno-config.in |    4 ++--
 3 files changed, 15 insertions(+), 10 deletions(-)

Index: configure.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- configure.in.orig
+++ configure.in
@@ -497,21 +497,23 @@ else
 fi
 AC_MSG_RESULT([done])
=20
-XENO_USER_CFLAGS=3D"-D_GNU_SOURCE -D_REENTRANT -D__XENO__"
+dnl Common CFLAGS and LDFLAGS
+XENO_USER_CFLAGS=3D"-D_GNU_SOURCE -D_REENTRANT"
 XENO_USER_LDFLAGS=3D
=20
+dnl Exported CFLAGS and LDFLAGS, may be enhanced per-arch below
+XENO_USER_APP_CFLAGS=3D$XENO_USER_CFLAGS
+XENO_USER_APP_LDFLAGS=3D$XENO_USER_LDFLAGS
+
 case $XENO_TARGET_ARCH in
  i386)
 	XENO_USER_CFLAGS=3D"$XENO_USER_CFLAGS -Wall -pipe -fstrict-aliasing $gc=
c_w_noalias"
-	XENO_USER_LDFLAGS=3D"-rdynamic"
         ;;
  powerpc)
 	XENO_USER_CFLAGS=3D"$XENO_USER_CFLAGS -Wall -pipe"
-	XENO_USER_LDFLAGS=3D"-rdynamic"
         ;;
  ia64)
 	XENO_USER_CFLAGS=3D"$XENO_USER_CFLAGS -Wall -pipe"
-	XENO_USER_LDFLAGS=3D"-rdynamic"
         ;;
  blackfin)
 	XENO_USER_CFLAGS=3D"$XENO_USER_CFLAGS -Wall -pipe"
@@ -521,7 +523,6 @@ case $XENO_TARGET_ARCH in
         ;;
  arm)
 	XENO_USER_CFLAGS=3D"$XENO_USER_CFLAGS -Wall -pipe"
-	XENO_USER_LDFLAGS=3D"-rdynamic"
         ;;
 esac
=20
@@ -531,9 +532,7 @@ else
    XENO_USER_CFLAGS=3D"-O2 $XENO_USER_CFLAGS"
 fi
=20
-XENO_USER_APP_CFLAGS=3D$XENO_USER_CFLAGS
 XENO_USER_CFLAGS=3D"$XENO_USER_CFLAGS -D__IN_XENO__ -Wstrict-prototypes"=

-XENO_USER_APP_LDFLAGS=3D$XENO_USER_LDFLAGS
=20
 AC_MSG_CHECKING([whether ld supports @file])
 AC_CACHE_VAL(ac_cv_ld_file_option,
Index: scripts/xeno-config.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- scripts/xeno-config.in.orig
+++ scripts/xeno-config.in
@@ -12,9 +12,9 @@ XENO_VERSION=3D"@PACKAGE_VERSION@"
 XENO_PREFIX=3D"${staging}${prefix}"
 XENO_CC=3D"@CC@"
 XENO_TARGET_ARCH=3D"@XENO_TARGET_ARCH@"
-XENO_BASE_CFLAGS=3D"-I. -I${staging}${includedir} @XENO_USER_APP_CFLAGS@=
"
+XENO_BASE_CFLAGS=3D"-I${staging}${includedir} @XENO_USER_APP_CFLAGS@"
 XENO_BASE_LDFLAGS=3D"-L${staging}${libdir} -lpthread @XENO_USER_APP_LDFL=
AGS@"
-XENO_POSIX_CFLAGS=3D"-I. -I${staging}${includedir} -I${staging}${include=
dir}/posix @XENO_USER_APP_CFLAGS@"
+XENO_POSIX_CFLAGS=3D"-I${staging}${includedir} -I${staging}${includedir}=
/posix @XENO_USER_APP_CFLAGS@ -D__XENO__"
 XENO_POSIX_LDFLAGS=3D"-L${staging}${libdir} -lpthread_rt -lpthread -lrt =
@XENO_USER_APP_LDFLAGS@"
 XENO_POSIX_WRAPPERS=3D"${staging}${libdir}/posix.wrappers"
 XENO_POSIX_FAST_WRAPPING=3D"@LD_FILE_OPTION@"
Index: ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ChangeLog.orig
+++ ChangeLog
@@ -1,3 +1,9 @@
+2006-10-09  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* configure.in, scripts/xeno-config.in: Reducing CFLAGS and LDFLAGS
+	return by xeno-config to the required minimum while keeping the
+	original flags internally.
+
 2006-10-08  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
=20
 	* src/testsuite/*/Makefile.am: Link with libtool libraries, in
@@ -9,7 +15,7 @@
 	* include/rtdm/rtdm_driver.h (rtdm_*copy_to/from_user): Fix
 	return code.
=20
-	* ksrc/skins/rtdm/drvlib.c (rtdm_strncpy_from_user): Adopt doc to
+	* ksrc/skins/rtdm/drvlib.c (rtdm_strncpy_from_user): Adapt doc to
 	actual success return code, the string length.
=20
 2006-10-08  Wolfgang Grandegger  <wg@domain.hid>

--------------040602040703000504020106--

--------------enig85CBB47A991B64C8D04D8872
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFKkFpniDOoMHTA+kRArE8AJ97AqzUi5J/fpulrCQj/ysWYEZo7ACfdS5z
/aYI4h7HB41TBwV1oJhQxc4=
=JAjD
-----END PGP SIGNATURE-----

--------------enig85CBB47A991B64C8D04D8872--

