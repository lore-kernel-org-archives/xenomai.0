Message-ID: <467BEE12.3090609@domain.hid>
Date: Fri, 22 Jun 2007 17:43:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig95CEE7BC9007FD7C8E9AE03D"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 2/2] run prepare-kernel on defaults
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
--------------enig95CEE7BC9007FD7C8E9AE03D
Content-Type: multipart/mixed;
 boundary="------------040501000809060504080601"

This is a multi-part message in MIME format.
--------------040501000809060504080601
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

This helps to run prepare-kernel with less explicit switches from
automatic build scripts. It adds the "--default" parameter which
virtually presses <enter> when the user used to be asked for some decisio=
n.

Would be nice to have in 2.3.x as well.

--------------040501000809060504080601
Content-Type: text/plain;
 name="run-default-preparation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="run-default-preparation.patch"

Index: xenomai/scripts/prepare-kernel.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/scripts/prepare-kernel.sh
+++ xenomai/scripts/prepare-kernel.sh
@@ -168,7 +168,7 @@ generate_patch() {
 }
=20
=20
-usage=3D'usage: prepare-kernel --linux=3D<linux-tree> --adeos=3D<adeos-p=
atch> [--arch=3D<arch>] [--outpatch=3D<file> <tempdir> [--filterkvers=3Dy=
|n] [--filterarch=3Dy|n]] [--forcelink]'
+usage=3D'usage: prepare-kernel --linux=3D<linux-tree> --adeos=3D<adeos-p=
atch> [--arch=3D<arch>] [--outpatch=3D<file> <tempdir> [--filterkvers=3Dy=
|n] [--filterarch=3Dy|n]] [--forcelink] [--default] [--verbose]'
 me=3D`basename $0`
=20
 while test $# -gt 0; do
@@ -198,6 +198,9 @@ while test $# -gt 0; do
     --forcelink)
         forcelink=3D1
         ;;
+    --default)
+        usedefault=3D1
+        ;;
     --verbose)
 	verbose=3D1
 	;;
@@ -226,8 +229,10 @@ xenomai_root=3D`cd $xenomai_root && pwd`
 default_linux_tree=3D/lib/modules/`uname -r`/source
=20
 while test x$linux_tree =3D x; do
-   echo -n "Linux tree [default $default_linux_tree]: "
-   read linux_tree
+   if test x$usedefault =3D x; then
+      echo -n "Linux tree [default $default_linux_tree]: "
+      read linux_tree
+   fi
    if test x$linux_tree =3D x; then
       linux_tree=3D$default_linux_tree
    fi
@@ -274,8 +279,10 @@ fi
=20
 while : ; do
    if test x$linux_arch =3D x; then
-      echo -n "Target architecture [default $default_linux_arch]: "
-      read linux_arch
+      if test x$usedefault =3D x; then
+         echo -n "Target architecture [default $default_linux_arch]: "
+         read linux_arch
+      fi
       if test x$linux_arch =3D x; then
          linux_arch=3D$default_linux_arch
       fi
@@ -363,8 +370,10 @@ else
       default_adeos_patch=3D/dev/null
    fi
    while test x$adeos_patch =3D x; do
-      echo -n "Adeos patch [default $default_adeos_patch]: "
-      read adeos_patch
+      if test x$usedefault =3D x; then
+         echo -n "Adeos patch [default $default_adeos_patch]: "
+         read adeos_patch
+      fi
       if test x$adeos_patch =3D x; then
          adeos_patch=3D$default_adeos_patch
       fi

--------------040501000809060504080601--

--------------enig95CEE7BC9007FD7C8E9AE03D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGe+4SniDOoMHTA+kRAmLxAJ9/rk8c9O0bx/k1HvSzbaWbD4BehwCcCQxt
IAI+wkXc/x8YPcpNDpmjNUc=
=bivD
-----END PGP SIGNATURE-----

--------------enig95CEE7BC9007FD7C8E9AE03D--

