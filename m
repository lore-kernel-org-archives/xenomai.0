Message-ID: <4662AE5B.6090207@domain.hid>
Date: Sun, 03 Jun 2007 14:04:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig55B48067B3C7E25C73B5203E"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 3/2] Fix locking on interation restart
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
--------------enig55B48067B3C7E25C73B5203E
Content-Type: multipart/mixed;
 boundary="------------000700090400040201030308"

This is a multi-part message in MIME format.
--------------000700090400040201030308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Argh, someone very blind must have contributed this bug - of course /me.

This is also stuff or 2.3 (just like the 1/2 patch).

Jan

--------------000700090400040201030308
Content-Type: text/x-patch;
 name="fix-proc-restarts.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-proc-restarts.patch"

---
 ChangeLog             |    3 +++
 ksrc/nucleus/module.c |    7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

Index: xenomai/ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ChangeLog
+++ xenomai/ChangeLog
@@ -9,6 +9,9 @@
 	* ksrc/nucleus/synch.c (xnsynch_sleep_on): Fix timeout restart
 	if resource was robbed.
=20
+	* ksrc/nucleus/module.c: Fix locking on restart of sched and stat
+	interation for proc output.
+
 2007-06-02  Philippe Gerum  <rpm@xenomai.org>
=20
 	* ksrc/skins/psos+, src/skins/psos+, include/psos+/psos.h: Add
Index: xenomai/ksrc/nucleus/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/module.c
+++ xenomai/ksrc/nucleus/module.c
@@ -190,9 +190,9 @@ static int sched_seq_open(struct inode *
 	if (!nkpod)
 		return -ESRCH;
=20
-      restart:
 	xnlock_get_irqsave(&nklock, s);
=20
+      restart:
 	rev =3D nkpod->threadq_rev;
 	count =3D countq(&nkpod->threadq);	/* Cannot be empty (ROOT) */
 	holder =3D getheadq(&nkpod->threadq);
@@ -363,9 +363,10 @@ static int stat_seq_open(struct inode *i
 	if (!nkpod)
 		return -ESRCH;
=20
-      restart:
+      restart_unlocked:
 	xnlock_get_irqsave(&nklock, s);
=20
+      restart:
 	count =3D countq(&nkpod->threadq);	/* Cannot be empty (ROOT) */
 	holder =3D getheadq(&nkpod->threadq);
 	thrq_rev =3D nkpod->threadq_rev;
@@ -461,7 +462,7 @@ static int stat_seq_open(struct inode *i
 					   &stat_info->runtime,
 					   &stat_info->account_period);
 			if (err =3D=3D -EAGAIN)
-				goto restart;
+				goto restart_unlocked;
 			if (err)
 				break; /* line unused or end of chain */
=20

--------------000700090400040201030308--

--------------enig55B48067B3C7E25C73B5203E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGYq5cniDOoMHTA+kRAp2XAJ90FGwLEsr72lPcUjELz/beum/wcgCfQe7y
oe2n7HoBpWjgaHUTHH7Pk7A=
=Q2tI
-----END PGP SIGNATURE-----

--------------enig55B48067B3C7E25C73B5203E--

