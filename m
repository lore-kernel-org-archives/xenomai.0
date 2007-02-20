Message-ID: <45DB66B4.6050700@domain.hid>
Date: Tue, 20 Feb 2007 22:23:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig639A8211BC27566784AE60AE"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] Catch HPET conflict
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
--------------enig639A8211BC27566784AE60AE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

As long as there is obviously a conflict, catch it during kernel
configuration and urge the user to disable CONFIG_HPET_TIMER.

Jan


Index: scripts/Kconfig.frag
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- scripts/Kconfig.frag	(Revision 2216)
+++ scripts/Kconfig.frag	(Arbeitskopie)
@@ -11,8 +11,13 @@ comment "NOTE: Xenomai conflicts with PC
 comment "(menu Device Drivers/Input device support/Miscellaneous devices=
)"
 	depends on !X86_TSC && X86 && INPUT_PCSPKR
=20
+comment "NOTE: Xenomai currently conflicts with HPET support."
+	depends on HPET_TIMER
+comment "(menu Processor type and features)"
+	depends on HPET_TIMER
+
 config XENOMAI
-	depends on X86_TSC || !X86 || !INPUT_PCSPKR
+	depends on (X86_TSC || !X86 || !INPUT_PCSPKR) && !HPET_TIMER
 	bool "Xenomai"
 	default y
         select IPIPE



--------------enig639A8211BC27566784AE60AE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF22a1niDOoMHTA+kRAjtoAJ0fG6aru6PvFfCkDtQh/9qV2wJiLgCggtAJ
0e9ERK0FaBVxltKV1HmMTmY=
=jzPw
-----END PGP SIGNATURE-----

--------------enig639A8211BC27566784AE60AE--

