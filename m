Message-ID: <48B7984D.8060402@domain.hid>
Date: Fri, 29 Aug 2008 08:33:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig78ACBAAC903E895274EA9492"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] Fix rt_mutex_acquire_until doc
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig78ACBAAC903E895274EA9492
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Copy&paste error?
(Note that diff misses the context, it's rt_mutex_acquire_until.)

Index: ksrc/skins/native/mutex.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/mutex.c	(Revision 4155)
+++ ksrc/skins/native/mutex.c	(Arbeitskopie)
@@ -421,10 +421,7 @@ int rt_mutex_acquire(RT_MUTEX *mutex, RT
  *
  * @param timeout The absolute date specifying a time limit to wait
  * for the mutex to be available to the calling task (see
- * note). Passing TM_INFINITE causes the caller to block indefinitely
- * until the mutex is available. Passing TM_NONBLOCK causes the
- * service to return immediately without waiting if the mutex is still
- * locked by another task.
+ * note).
  *
  * @return 0 is returned upon success. Otherwise:
  *


--------------enig78ACBAAC903E895274EA9492
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAki3mFEACgkQniDOoMHTA+mXBwCgglA36tFRCTG2sRy+qQba5/mU
hyAAnRKSsGfnmlJ8PozZ1qpJfJbZ5BBU
=aN8F
-----END PGP SIGNATURE-----

--------------enig78ACBAAC903E895274EA9492--

