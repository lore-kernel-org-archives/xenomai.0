Message-ID: <462CC82D.4010900@domain.hid>
Date: Mon, 23 Apr 2007 16:52:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEE49432440238B0E7FAB5BA0"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] Fix typo in x86_64 ffnz
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
--------------enigEE49432440238B0E7FAB5BA0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Grrr...

Index: include/asm-x86_64/hal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-x86_64/hal.h	(Revision 2402)
+++ include/asm-x86_64/hal.h	(Arbeitskopie)
@@ -30,7 +30,7 @@ typedef unsigned long rthal_time_t;
=20
 static inline __attribute_const__ unsigned long ffnz(unsigned long ul)
 {
-	__asm__("bsrq %1, %0":"=3Dr"(ul):"rm"(ul));
+	__asm__("bsfq %1, %0":"=3Dr"(ul):"rm"(ul));
 	return ul;
 }
=20
Index: ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ChangeLog	(Revision 2402)
+++ ChangeLog	(Arbeitskopie)
@@ -1,3 +1,8 @@
+2007-04-23  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* include/asm-x86_64/hal.h (ffnz): Fix typo that inverted the search
+	direction.
+
 2007-04-19  Philippe Gerum  <rpm@xenomai.org>
=20
 	* ksrc/skins/vrtx/module.c, ksrc/nucleus/pipe.c,


--------------enigEE49432440238B0E7FAB5BA0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLMgtniDOoMHTA+kRAhidAJ9pk/wBrm7wV2RdCWDaYXxrpZq/ngCfcz5i
XC6nIfrdB1DZSbbABDFsnwQ=
=bmlj
-----END PGP SIGNATURE-----

--------------enigEE49432440238B0E7FAB5BA0--

