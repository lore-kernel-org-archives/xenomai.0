Message-ID: <466288C9.7030907@domain.hid>
Date: Sun, 03 Jun 2007 11:24:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2C2501E4A5429A0B7E2FE2BA"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 2/2] Fix abs. timeout restart in
	xnsynch_sleep_on
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
--------------enig2C2501E4A5429A0B7E2FE2BA
Content-Type: multipart/mixed;
 boundary="------------060104000104000504030901"

This is a multi-part message in MIME format.
--------------060104000104000504030901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


--------------060104000104000504030901
Content-Type: text/x-patch;
 name="fix-sleep-on-timeout.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-sleep-on-timeout.patch"

---
 ChangeLog            |    3 +++
 ksrc/nucleus/synch.c |    2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

Index: xenomai/ksrc/nucleus/synch.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/synch.c
+++ xenomai/ksrc/nucleus/synch.c
@@ -228,7 +228,7 @@ redo:
 		/* Somebody stole us the ownership while we were ready
 		   to run, waiting for the CPU: we need to wait again
 		   for the resource. */
-		if (timeout =3D=3D XN_INFINITE)
+		if (mode =3D=3D XN_ABSOLUTE || timeout =3D=3D XN_INFINITE)
 			goto redo;
 		timeout =3D xnthread_timeout(thread);
 		if (timeout > 1) /* Otherwise, it's too late. */
Index: xenomai/ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ChangeLog
+++ xenomai/ChangeLog
@@ -6,6 +6,9 @@
 	* ksrc/nucleus/{module.c, shadow.c}: Move remove_proc_entry out of
 	nklock.
=20
+	* ksrc/nucleus/synch.c (xnsynch_sleep_on): Fix timeout restart
+	if resource was robbed.
+
 2007-06-02  Philippe Gerum  <rpm@xenomai.org>
=20
 	* ksrc/skins/psos+, src/skins/psos+, include/psos+/psos.h: Add

--------------060104000104000504030901--

--------------enig2C2501E4A5429A0B7E2FE2BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGYojJniDOoMHTA+kRAs52AJ9Pkmeg8z6Qr2pBnknrDIH7Ny1RUQCeLNAA
4sqDZ7i64yhWUavnkckU73Q=
=T6ku
-----END PGP SIGNATURE-----

--------------enig2C2501E4A5429A0B7E2FE2BA--

