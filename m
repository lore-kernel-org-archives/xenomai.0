Message-ID: <4D21CE64.6010605@domain.hid>
Date: Mon, 03 Jan 2011 14:25:56 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7FA1FBF0F578678808CDD31D"
Subject: [Xenomai-core] [PATCH] debian: update debian/control for debian 6.0
	"squeeze"
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7FA1FBF0F578678808CDD31D
Content-Type: multipart/mixed;
 boundary="------------000606080900090507040909"

This is a multi-part message in MIME format.
--------------000606080900090507040909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

patch attached for upcoming debian 6.0 "squeeze".

Stefan


--------------000606080900090507040909
Content-Type: text/x-patch;
 name="0001-debian-update-debian-control-for-debian-6.0-squeeze.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-debian-update-debian-control-for-debian-6.0-squeeze.pat";
 filename*1="ch"

=46rom 505640995eac8b64b53a9fab476c9f91203be6ab Mon Sep 17 00:00:00 2001
From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Mon, 3 Jan 2011 14:07:57 +0100
Subject: [PATCH 1/2] debian: update debian/control for debian 6.0 "squeez=
e"

---
 debian/control |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/debian/control b/debian/control
index ab4636d..5505d2c 100644
--- a/debian/control
+++ b/debian/control
@@ -3,13 +3,13 @@ Section: devel
 Priority: extra
 Maintainer: Roland Stigge <stigge@domain.hid>
 Build-Depends: debhelper (>=3D 7), dh-kpatches, findutils (>=3D 4.2.28)
-Standards-Version: 3.8.0
+Standards-Version: 3.9.1
 Homepage: http://www.xenomai.org/
=20
 Package: xenomai-runtime
 Section: devel
 Architecture: amd64 arm armeb armel i386 powerpc
-Depends: ${shlibs:Depends}
+Depends: ${shlibs:Depends}, ${misc:Depends}
 Suggests: linux-patch-xenomai, xenomai-doc
 Replaces: xenomai
 Conflicts: xenomai
@@ -25,9 +25,9 @@ Description: Xenomai runtime utilities
  realtime system.
=20
 Package: linux-patch-xenomai
-Section: devel
+Section: kernel
 Architecture: all
-Depends: ${kpatch:Depends}
+Depends: ${kpatch:Depends}, ${misc:Depends}
 Suggests: xenomai, linux-source-2.6, kernel-package
 Description: Linux kernel patches for Xenomai
  Xenomai is a real-time development framework cooperating with the Linux=

@@ -48,7 +48,7 @@ Description: Linux kernel patches for Xenomai
 Package: libxenomai1
 Section: libs
 Architecture: amd64 arm armeb armel i386 powerpc
-Depends: ${shlibs:Depends}
+Depends: ${shlibs:Depends}, ${misc:Depends}
 Suggests: linux-patch-xenomai, xenomai-doc
 Replaces: xenomai
 Conflicts: xenomai
@@ -65,7 +65,7 @@ Description: Shared libraries for Xenomai
 Package: libxenomai-dev
 Section: libdevel
 Architecture: amd64 arm armeb armel i386 powerpc
-Depends: libxenomai1 (=3D ${binary:Version})
+Depends: libxenomai1 (=3D ${binary:Version}), ${misc:Depends}
 Suggests: linux-patch-xenomai, xenomai-doc
 Replaces: xenomai
 Conflicts: xenomai
@@ -83,7 +83,7 @@ Description: Headers and static libs for Xenomai
 Package: xenomai-doc
 Section: doc
 Architecture: all
-Depends:
+Depends: ${misc:Depends}
 Suggests: xenomai
 Conflicts: xenomai-docs
 Replaces: xenomai-docs
--=20
1.7.2.3


--------------000606080900090507040909--

--------------enig7FA1FBF0F578678808CDD31D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk0hzmsACgkQIPTw9rIdn6oKuQCcCCKDI3be9j7AtBcScRPf0A1e
PGwAnAu/DQHsWfNo+R8c86J9FeDmozn8
=lKMP
-----END PGP SIGNATURE-----

--------------enig7FA1FBF0F578678808CDD31D--

