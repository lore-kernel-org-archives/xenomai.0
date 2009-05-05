Message-ID: <4A00848D.1090500@domain.hid>
Date: Tue, 05 May 2009 20:25:17 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1A7DCB2D17570D3AB08ABB9C"
Subject: [Xenomai-help] Debian package building fails with 2.5-rc1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1A7DCB2D17570D3AB08ABB9C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

there is no ChangeLog file in the project root anymore, so debian package=
 building fails.
Following patch fixed it for me.

kisda

--- xenomai-2.5.orig/debian/rules
+++ xenomai-2.5/debian/rules
@@ -108,7 +108,7 @@
 	dh_testdir -i
 	dh_testroot -i
 	dh_installdocs -i -A CREDITS README.INSTALL TROUBLESHOOTING
-	dh_installchangelogs -i ChangeLog
+	dh_installchangelogs -i
 	dh_link -i
 	dh_strip -i
 	dh_compress -i -X.pdf
@@ -131,7 +131,7 @@
 	dh_testroot -s
 	dh_installman -s
 	dh_installdocs -s -A CREDITS README.INSTALL TROUBLESHOOTING
-	dh_installchangelogs -s ChangeLog
+	dh_installchangelogs -s
 	dh_link -s
 	dh_strip -s
 	dh_compress -s



--------------enig1A7DCB2D17570D3AB08ABB9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFKAISSIPTw9rIdn6oRAgrTAJ9q7Df1A8vHB5sSFRXxG/AzimDgNACeL5CU
xuSkz0CkNooeuPNdbgGIjD4=
=GUgP
-----END PGP SIGNATURE-----

--------------enig1A7DCB2D17570D3AB08ABB9C--

