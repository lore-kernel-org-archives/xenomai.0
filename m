Message-ID: <43568931.8070902@domain.hid>
Date: Wed, 19 Oct 2005 19:58:09 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDF1290C44DB2387970CAAB29"
Subject: [Xenomai-core] [patch] doc fix in rtdm
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
--------------enigDF1290C44DB2387970CAAB29
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

someone ;) complained about this statement regarding
rtdm_task_busy_sleep. I think he is right.

--- drvlib.c    (revision 44)
+++ drvlib.c    (working copy)
@@ -335,7 +335,7 @@
  * - Kernel-based task
  * - User-space task (RT, non-RT)
  *
- * Rescheduling: always.
+ * Rescheduling: never.
  */
 void rtdm_task_busy_sleep(__u64 delay)
 {

Jan


--------------enigDF1290C44DB2387970CAAB29
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDVokxncNeS9Q0k+IRArOdAJ4ztxQG3ZR2N5+FTrVVT4J5W41IxgCfcTie
1oqEml1NgnFJqUOnUdKfIvQ=
=l4Ee
-----END PGP SIGNATURE-----

--------------enigDF1290C44DB2387970CAAB29--

