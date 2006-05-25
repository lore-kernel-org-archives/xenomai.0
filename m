Message-ID: <4475F918.6040409@domain.hid>
Date: Thu, 25 May 2006 20:36:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8FD262854E9DF819087CE124"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [patch] fix pthread_set_mode_np
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8FD262854E9DF819087CE124
Content-Type: multipart/mixed; boundary="------------070103090206020105030206"

This is a multi-part message in MIME format.
--------------070103090206020105030206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles,

obviously, the userspace part of pthread_set_mode_np was forgotten on
the last refactoring. This fixes it.

Jan

--------------070103090206020105030206
Content-Type: text/x-patch;
 name="pthread_set_mode.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="pthread_set_mode.patch"

Index: src/skins/posix/thread.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/posix/thread.c	(Revision 1136)
+++ src/skins/posix/thread.c	(Arbeitskopie)
@@ -213,12 +213,10 @@ int pthread_set_mode_np (int clrmask,
 			 int setmask)
 {
     extern int xeno_sigxcpu_no_mlock;
-    pthread_t tid =3D pthread_self();
     int err;
=20
-    err =3D -XENOMAI_SKINCALL3(__pse51_muxid,
+    err =3D -XENOMAI_SKINCALL2(__pse51_muxid,
 			     __pse51_thread_set_mode,
-			     tid, /* Do not inline. */
 			     clrmask,
 			     setmask);
=20

--------------070103090206020105030206--

--------------enig8FD262854E9DF819087CE124
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEdfkYniDOoMHTA+kRAr98AJ4qS5T9STK/vZvTAecL5PwWa3cIIwCfcimV
9e0iCtuueT6HYwkZh7LMkZE=
=mL8H
-----END PGP SIGNATURE-----

--------------enig8FD262854E9DF819087CE124--

