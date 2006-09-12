Message-ID: <4506E6CD.5050302@domain.hid>
Date: Tue, 12 Sep 2006 18:56:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7BCAD677354B8AF7285DD6D0"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [patch] fix xeno-test for busybox
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
--------------enig7BCAD677354B8AF7285DD6D0
Content-Type: multipart/mixed; boundary="------------020708010705060901000109"

This is a multi-part message in MIME format.
--------------020708010705060901000109
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

I just tried to fire up xeno-test on a busybox system - without success.
Reason: missing getopts. But busybox initial test checks for something
else, namely getopt. The attached patch should fix this it, also taking
into account that getopts in a shell built-in, not an applet.

Jan

--------------020708010705060901000109
Content-Type: text/plain;
 name="xeno-test-getopts.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xeno-test-getopts.patch"

Index: scripts/xeno-test.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- scripts/xeno-test.in	(revision 1591)
+++ scripts/xeno-test.in	(working copy)
@@ -57,8 +57,8 @@ pidFile=3D/var/lock/`basename $0.$$`.pids
=20
 checkUtilities() {
   # Check for needed helper utilities
-  local neededApplets=3D"awk basename cut date dd dirname egrep grep get=
opt
-		       head kill md5sum mount sleep test top uname zcat"
+  local neededApplets=3D"awk basename cut date dd dirname egrep grep hea=
d
+		       kill md5sum mount sleep test top uname zcat"
   local foundAll=3D1
   for  _j in $neededApplets
   do
@@ -67,6 +67,10 @@ checkUtilities() {
       foundAll=3D0
     fi
   done
+  if ! type getopts 2>&1 >/dev/null; then
+    echo "Please build busybox's ash with support for getopts"
+    foundAll=3D0
+  fi
   if test $foundAll -eq 0 ; then exit 3 ; fi
 }
=20

--------------020708010705060901000109--

--------------enig7BCAD677354B8AF7285DD6D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFBubNniDOoMHTA+kRAtVsAJ4utlKSSAV33fzTCdWImp5TozJQrACfWQaV
dugBsWzYReCdsMnyXugj/d8=
=Dfss
-----END PGP SIGNATURE-----

--------------enig7BCAD677354B8AF7285DD6D0--

