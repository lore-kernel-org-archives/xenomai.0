Message-ID: <4677B095.3070903@domain.hid>
Date: Tue, 19 Jun 2007 12:31:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5620F1630C03768ABBCED186"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] Switch to pci_register_driver
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5620F1630C03768ABBCED186
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,

can we just switch over to pci_register_driver in order to avoid
deprecated (and soon removed) pci_module_init? Or do we also need some
wrapper for older 2.4 kernels (latest 2.4 is already aligned with 2.6)?

Jan


Index: ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c	(Revision 2609)
+++ ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c	(Arbeitskopie)
@@ -307,7 +307,7 @@ static struct pci_driver rtcan_ixxat_pci

 static int __init rtcan_ixxat_pci_init(void)
 {
-    return pci_module_init(&rtcan_ixxat_pci_driver);
+    return pci_register_driver(&rtcan_ixxat_pci_driver);
 }


Index: ksrc/drivers/can/sja1000/rtcan_peak_pci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/can/sja1000/rtcan_peak_pci.c	(Revision 2609)
+++ ksrc/drivers/can/sja1000/rtcan_peak_pci.c	(Arbeitskopie)
@@ -346,7 +346,7 @@ static struct pci_driver rtcan_peak_pci_

 static int __init rtcan_peak_pci_init(void)
 {
-    return pci_module_init(&rtcan_peak_pci_driver);
+    return pci_register_driver(&rtcan_peak_pci_driver);
 }




--------------enig5620F1630C03768ABBCED186
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGd7CVniDOoMHTA+kRArNpAJ49zQUzoc/q+SfqxUnEPnWHZlhmQwCeK+f2
r8bRBnAe/iJGflDEyGYzm2w=
=faTC
-----END PGP SIGNATURE-----

--------------enig5620F1630C03768ABBCED186--

