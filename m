Message-ID: <44DCABB2.1060706@domain.hid>
Date: Fri, 11 Aug 2006 18:09:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCCCBEA29C84862348E7F5F8F"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] silence libtool warnings
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
--------------enigCCCBEA29C84862348E7F5F8F
Content-Type: multipart/mixed; boundary="------------030001020509070009050709"

This is a multi-part message in MIME format.
--------------030001020509070009050709
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

As we should not statically link the native/rtdm libraries against our
new CAN tools (that code may reside on small embedded devices soon...),
the old "Linking the executable XXXX ... is not portable!" warning now
pops up again during Xenomai user-space build.

Here is an approach to work around that warnings already at libtool
level (though I'm still convinced dropping "-module" would make more sens=
e).

Jan

--------------030001020509070009050709
Content-Type: text/plain;
 name="silence-libtool-warnings.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="silence-libtool-warnings.patch"

---
 configure.in                  |    8 ++++++++
 src/skins/native/Makefile.am  |    6 ------
 src/skins/posix/Makefile.am   |    6 ------
 src/skins/rtdm/Makefile.am    |    6 ------
 src/skins/vrtx/Makefile.am    |    6 ------
 src/skins/vxworks/Makefile.am |    6 ------
 6 files changed, 8 insertions(+), 30 deletions(-)

Index: xenomai/configure.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/configure.in
+++ xenomai/configure.in
@@ -632,3 +632,11 @@ if test \! x$XENO_MAYBE_DOCDIR =3D x; then
 fi
=20
 AC_OUTPUT()
+
+dnl
+dnl This suppresses the warnings "Linking the executable XXXX against th=
e
+dnl loadable module YYY.so is not portable!"
+dnl
+
+sed -e 's/shouldnotlink=3D\$module/shouldnotlink=3Dno/' libtool > libtoo=
l.patched
+mv libtool.patched libtool
Index: xenomai/src/skins/native/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/native/Makefile.am
+++ xenomai/src/skins/native/Makefile.am
@@ -20,9 +20,3 @@ libnative_la_SOURCES =3D \
 libnative_la_CPPFLAGS =3D \
 	@XENO_USER_CFLAGS@ \
 	-I$(top_srcdir)/include
-
-install-exec-hook:
-	for la in $(lib_LTLIBRARIES); do \
-	    sed -e 's/shouldnotlink=3Dyes/shouldnotlink=3Dno/' $(DESTDIR)$(libd=
ir)/$$la > $(DESTDIR)$(libdir)/$$la.patched; \
-	    mv $(DESTDIR)$(libdir)/$$la.patched $(DESTDIR)$(libdir)/$$la; \
-	done
Index: xenomai/src/skins/posix/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/posix/Makefile.am
+++ xenomai/src/skins/posix/Makefile.am
@@ -30,10 +30,4 @@ install-data-local:
 uninstall-local:
 	$(RM) $(DESTDIR)$(libdir)/posix.wrappers
=20
-install-exec-hook:
-	for la in $(lib_LTLIBRARIES); do \
-	    sed -e 's/shouldnotlink=3Dyes/shouldnotlink=3Dno/' $(DESTDIR)$(libd=
ir)/$$la > $(DESTDIR)$(libdir)/$$la.patched; \
-	    mv $(DESTDIR)$(libdir)/$$la.patched $(DESTDIR)$(libdir)/$$la; \
-	done
-
 EXTRA_DIST =3D posix.wrappers
Index: xenomai/src/skins/rtdm/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/rtdm/Makefile.am
+++ xenomai/src/skins/rtdm/Makefile.am
@@ -9,9 +9,3 @@ librtdm_la_SOURCES =3D \
 librtdm_la_CPPFLAGS =3D \
 	@XENO_USER_CFLAGS@ \
 	-I$(top_srcdir)/include
-
-install-exec-hook:
-	for la in $(lib_LTLIBRARIES); do \
-	    sed -e 's/shouldnotlink=3Dyes/shouldnotlink=3Dno/' $(DESTDIR)$(libd=
ir)/$$la > $(DESTDIR)$(libdir)/$$la.patched; \
-	    mv $(DESTDIR)$(libdir)/$$la.patched $(DESTDIR)$(libdir)/$$la; \
-	done
Index: xenomai/src/skins/vrtx/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/vrtx/Makefile.am
+++ xenomai/src/skins/vrtx/Makefile.am
@@ -17,9 +17,3 @@ libvrtx_la_SOURCES =3D \
 libvrtx_la_CPPFLAGS =3D \
 	@XENO_USER_CFLAGS@ \
 	-I$(top_srcdir)/include
-
-install-exec-hook:
-	for la in $(lib_LTLIBRARIES); do \
-	    sed -e 's/shouldnotlink=3Dyes/shouldnotlink=3Dno/' $(DESTDIR)$(libd=
ir)/$$la > $(DESTDIR)$(libdir)/$$la.patched; \
-	    mv $(DESTDIR)$(libdir)/$$la.patched $(DESTDIR)$(libdir)/$$la; \
-	done
Index: xenomai/src/skins/vxworks/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/vxworks/Makefile.am
+++ xenomai/src/skins/vxworks/Makefile.am
@@ -18,9 +18,3 @@ libvxworks_la_SOURCES =3D \
 libvxworks_la_CPPFLAGS =3D \
 	@XENO_USER_CFLAGS@ \
 	-I$(top_srcdir)/include
-
-install-exec-hook:
-	for la in $(lib_LTLIBRARIES); do \
-	    sed -e 's/shouldnotlink=3Dyes/shouldnotlink=3Dno/' $(DESTDIR)$(libd=
ir)/$$la > $(DESTDIR)$(libdir)/$$la.patched; \
-	    mv $(DESTDIR)$(libdir)/$$la.patched $(DESTDIR)$(libdir)/$$la; \
-	done

--------------030001020509070009050709--

--------------enigCCCBEA29C84862348E7F5F8F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE3KuyniDOoMHTA+kRAr6hAJ43GzFnm/MLDqaaRyvzQpnHU1A4/wCdH0xe
Ey0aSVAEEUa4tfjV1W9+TO4=
=CtZ1
-----END PGP SIGNATURE-----

--------------enigCCCBEA29C84862348E7F5F8F--

