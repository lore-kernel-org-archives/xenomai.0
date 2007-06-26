Message-ID: <46816E5A.6030101@domain.hid>
Date: Tue, 26 Jun 2007 21:51:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig274FB8A74FA42E192975DEAC"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] run aclocal first
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
--------------enig274FB8A74FA42E192975DEAC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

autoheader depends on aclocal output, so make the latter run first.
(I was facing bootstrap failures due to different aclocal versions.)

---
 scripts/bootstrap |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

Index: xenomai/scripts/bootstrap
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/scripts/bootstrap
+++ xenomai/scripts/bootstrap
@@ -14,16 +14,6 @@ rm -Rf autom4te.cache
 if [ "$?" !=3D "0" ]; then die "removing autom4te.cache"; fi
 echo "done"

-echo -n "running autoheader..."
-autoheader
-if [ "$?" !=3D "0" ]; then die "running autoheader"; fi
-echo "done"
-
-echo -n "running libtoolize..."
-libtoolize -c --automake
-if [ "$?" !=3D "0" ]; then die "running libtoolize"; fi
-echo "done"
-
 echo -n "running aclocal..."
 if test -r acinclude.m4; then
    touch acinclude.m4
@@ -34,6 +24,16 @@ fi
 if [ "$?" !=3D "0" ]; then die "running aclocal"; fi
 echo "done"

+echo -n "running autoheader..."
+autoheader
+if [ "$?" !=3D "0" ]; then die "running autoheader"; fi
+echo "done"
+
+echo -n "running libtoolize..."
+libtoolize -c --automake
+if [ "$?" !=3D "0" ]; then die "running libtoolize"; fi
+echo "done"
+
 echo -n "running autoconf..."
 autoconf
 if [ "$?" !=3D "0" ]; then die "running autoconf"; fi


--------------enig274FB8A74FA42E192975DEAC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGgW5aniDOoMHTA+kRAgtSAJ4517gum43PPsopiEkaOhLjrE367ACdHqUe
YTjii/e5jq7nvk+u6aEFP18=
=BKCA
-----END PGP SIGNATURE-----

--------------enig274FB8A74FA42E192975DEAC--

