Message-ID: <466EDD82.7030407@domain.hid>
Date: Tue, 12 Jun 2007 19:53:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig98601D1B35978FC091E1D4C7"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [BUG] too lax asm constraints of __xn_rdtsc on bfin
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
--------------enig98601D1B35978FC091E1D4C7
Content-Type: multipart/mixed;
 boundary="------------050503070207070704050400"

This is a multi-part message in MIME format.
--------------050503070207070704050400
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sigh. Actually, I only wanted to give that shiny new BF537-STAMP board,
kindly provided by ADI, a short try. Now I'm right in the middle of all
this...

Changelog says it all. Problem appears with trunk and 2.3.x user space
build (=3D>direct TSC).

Jan

--------------050503070207070704050400
Content-Type: text/plain;
 name="fix-__xn_rdtsc-constraints.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-__xn_rdtsc-constraints.patch"

Index: ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ChangeLog	(Revision 2571)
+++ ChangeLog	(Arbeitskopie)
@@ -1,3 +1,9 @@
+2007-06-12  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* include/asm-blackfin/syscall.h (__xn_rdtsc): Assure that CC only
+	works on data registers. Otherwise, bfin's as may pick a pointer reg
+	and crash during user land build (toolchain bug #3332).
+
 2007-06-09  Philippe Gerum  <rpm@xenomai.org>
=20
 	* ksrc/skins/native/pipe.c (rt_pipe_create): Keep the
Index: include/asm-blackfin/syscall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-blackfin/syscall.h	(Revision 2571)
+++ include/asm-blackfin/syscall.h	(Arbeitskopie)
@@ -249,9 +249,9 @@
 				"%2 =3D CYCLES2\n"
 				"CC =3D %2 =3D=3D %0\n"
 				"if !cc jump 1b\n"
-				:"=3Dr" (u.s.h),
-				"=3Dr" (u.s.l),
-				"=3Dr" (cy2)
+				:"=3Dd" (u.s.h),
+				"=3Dd" (u.s.l),
+				"=3Dd" (cy2)
 				: /*no input*/ : "cc");
     return u.t;
 }

--------------050503070207070704050400--

--------------enig98601D1B35978FC091E1D4C7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGbt2CniDOoMHTA+kRAhCHAJ9Y1LB4bRG6zG+QI+1mvvnGt8I4JgCfTggp
0VRWd3TaoUJSzerOYSM5Xfk=
=JInK
-----END PGP SIGNATURE-----

--------------enig98601D1B35978FC091E1D4C7--

