Message-ID: <441AA70F.30805@domain.hid>
Date: Fri, 17 Mar 2006 13:09:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFF6BBD73FE4ACF797D5A38B1"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] reduce stack size in accuracy demo
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
--------------enigFF6BBD73FE4ACF797D5A38B1
Content-Type: multipart/mixed; boundary="------------080700050909090508010007"

This is a multi-part message in MIME format.
--------------080700050909090508010007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles,

running your accuracy demo on a resource restricted system aside a
hungry cache benchmark (as load) produced OOM too early. This patch
reduces the stack thread sizes (which get locked into memory) - and it
also demonstrates how to create RT-pthreads preferably.

Jan


PS: cyclictest now runs as expected with pthread_setschedparam, will
post some patch to the list and Thomas. I think it's useful as it can
create multiple timed threads, and it's POSIX (latency is native,
accuracy tests relative sleeping).

--------------080700050909090508010007
Content-Type: text/plain;
 name="accuracy-thread.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="accuracy-thread.patch"

Index: ksrc/skins/posix/demos/accuracy.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/posix/demos/accuracy.c	(revision 702)
+++ ksrc/skins/posix/demos/accuracy.c	(working copy)
@@ -12,6 +12,7 @@
 #include <unistd.h>
 #include <pthread.h>
 #include <semaphore.h>
+#include <limits.h>
=20
 #define SEMB_NAME "/semB"
=20
@@ -229,6 +230,7 @@ int main (int argc, char **argv)
     pthread_attr_setinheritsched(&thattrA,PTHREAD_EXPLICIT_SCHED);
     pthread_attr_setschedpolicy(&thattrA,SCHED_FIFO);
     pthread_attr_setschedparam(&thattrA,&paramA);
+    pthread_attr_setstacksize(&thattrA,PTHREAD_STACK_MIN);
     err =3D pthread_create(&thidA,&thattrA,&threadA,NULL);
=20
     if (err)
@@ -239,6 +241,7 @@ int main (int argc, char **argv)
     pthread_attr_setinheritsched(&thattrB,PTHREAD_EXPLICIT_SCHED);
     pthread_attr_setschedpolicy(&thattrB,SCHED_FIFO);
     pthread_attr_setschedparam(&thattrB,&paramB);
+    pthread_attr_setstacksize(&thattrB,PTHREAD_STACK_MIN);
     err =3D pthread_create(&thidB,&thattrB,&threadB,NULL);
=20
     if (err)


--------------080700050909090508010007--

--------------enigFF6BBD73FE4ACF797D5A38B1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEGqcPniDOoMHTA+kRAuhzAJ9R8aZT0kRUx+zm3n8g7hB5FCrUrQCeLCae
snSrXl3KNwoVpRqrEHNzG/M=
=gGI0
-----END PGP SIGNATURE-----

--------------enigFF6BBD73FE4ACF797D5A38B1--

