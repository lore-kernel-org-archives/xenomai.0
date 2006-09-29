From: Stelian Pop <stelian.pop@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 29 Sep 2006 15:56:09 +0200
Message-Id: <1159538169.15778.22.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] [PATCH] automatically run ldconfig on installation
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

Hi,

When installing the userspace skin libraries, 'ldconfig' is not
automatically run to update the dynamic library loader cache.

The attached patch does just that, but it does so only if the user is
not installing cross-compiled libraries as it does not make sense in
this case.

Stelian.
Index: configure.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- configure.in	(r=E9vision 1680)
+++ configure.in	(copie de travail)
@@ -593,6 +593,7 @@
 AC_SUBST([CONFIG_STATUS_DEPENDENCIES],
         ['$(top_srcdir)/src/skins/posix/posix.wrappers'])
 AC_SUBST(XENO_POSIX_WRAPPERS)
+AC_SUBST(cross_compiling)
=20
 base=3Dasm-$XENO_TARGET_ARCH
 AC_CONFIG_LINKS([src/include/asm/xenomai:include/$base])
Index: src/skins/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/Makefile.am	(r=E9vision 1680)
+++ src/skins/Makefile.am	(copie de travail)
@@ -1,2 +1,4 @@
+install-data-local:
+	if test "@cross_compiling@" =3D "no"; then ldconfig; fi
=20
 SUBDIRS =3D native posix rtdm vxworks vrtx rtai

--=20
Stelian Pop <stelian.pop@domain.hid>


