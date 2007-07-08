Message-ID: <46914648.4000801@domain.hid>
Date: Sun, 08 Jul 2007 22:17:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9AFC6FFFAB7C62C3CE1AB26A"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix pthread_create regression
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9AFC6FFFAB7C62C3CE1AB26A
Content-Type: multipart/mixed;
 boundary="------------090706070507040308070000"

This is a multi-part message in MIME format.
--------------090706070507040308070000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

My rt-caps patch included an ugly regression for the posix skin:

pthread_create fails if the caller passes SCHED_FIFO + a priority > 0 in
the thread attribute. It's observable via switchtest for instance. This
patch should fix it.

Note that 2.3.x urgently needs this patch as well!

Jan

--------------090706070507040308070000
Content-Type: text/x-patch;
 name="fix-pthread_create-param-overwrite.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-pthread_create-param-overwrite.patch"

Index: src/skins/posix/thread.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/posix/thread.c	(Revision 2756)
+++ src/skins/posix/thread.c	(Arbeitskopie)
@@ -139,7 +139,7 @@ int __wrap_pthread_create(pthread_t *tid
=20
 	if (!attr) {
 		policy =3D SCHED_OTHER;
-		param.sched_priority =3D 0;
+		iargs.prio =3D 0;
 	} else {
 		pthread_attr_getinheritsched(attr, &inherit);
 		if (inherit =3D=3D PTHREAD_EXPLICIT_SCHED) {
@@ -149,12 +149,15 @@ int __wrap_pthread_create(pthread_t *tid
 			/* inherit =3D=3D PTHREAD_INHERIT_SCHED */
 			__wrap_pthread_getschedparam(pthread_self(),
 						     &policy, &param);
+		iargs.prio =3D param.sched_priority;
=20
 		/* Work around linuxthreads shortcoming: it doesn't believe
 		   that it could have RT power as non-root and fails the
 		   thread creation overeagerly. */
 		memcpy(&iattr, attr, sizeof(pthread_attr_t));
+		param.sched_priority =3D 0;
 		pthread_attr_setschedpolicy(&iattr, SCHED_OTHER);
+		pthread_attr_setschedparam(&iattr, &param);
 		attr =3D &iattr;
 	}
=20
@@ -164,7 +167,6 @@ int __wrap_pthread_create(pthread_t *tid
 	iargs.start =3D start;
 	iargs.arg =3D arg;
 	iargs.policy =3D policy;
-	iargs.prio =3D param.sched_priority;
 	iargs.ret =3D EAGAIN;
 	__real_sem_init(&iargs.sync, 0, 0);
=20

--------------090706070507040308070000--

--------------enig9AFC6FFFAB7C62C3CE1AB26A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGkUZMniDOoMHTA+kRAsHLAJ4nVrg5ErSyXbRIJv9m7JQJLiA0xACfcdM7
0xW1PwrSacRzqvsEPIsqoNE=
=BrYm
-----END PGP SIGNATURE-----

--------------enig9AFC6FFFAB7C62C3CE1AB26A--

