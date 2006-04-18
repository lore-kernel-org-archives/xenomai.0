Message-ID: <44455949.4030403@domain.hid>
Date: Tue, 18 Apr 2006 23:25:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig87D91D178A015A870A5139B6"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATH] fix pthread.h include
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
--------------enig87D91D178A015A870A5139B6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

--- include/posix/pthread.h     (revision 946)
+++ include/posix/pthread.h     (working copy)
@@ -137,6 +137,7 @@ typedef struct

 #include <sched.h>
 #include_next <pthread.h>
+#include <nucleus/thread.h>

 struct timespec;


[In order to use PTHREAD_WARNSW in userspace.]

Jan


--------------enig87D91D178A015A870A5139B6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFERVlJniDOoMHTA+kRAsJKAJ9QLYuMfjrJm57FJLuX1VVb+P+54QCfYadv
6xhgQqT6oyvLNF5F3qLhVyM=
=w1aV
-----END PGP SIGNATURE-----

--------------enig87D91D178A015A870A5139B6--

