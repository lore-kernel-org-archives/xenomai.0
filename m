Message-ID: <477668F3.3070802@domain.hid>
Date: Sat, 29 Dec 2007 16:34:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig250D46006DB853A1024C3CE5"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] terminate PCI ID tables of CAN drivers
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
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig250D46006DB853A1024C3CE5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,

interesting, 2.6.24 started to complain about this. This is just FYI, I
already committed it to trunk and 2.4.x.

Jan


Index: xenomai/ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai/ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c	(Revision 3330)
+++ xenomai/ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c	(Arbeitskopie)
@@ -74,6 +74,7 @@
=20
 static struct pci_device_id ixxat_pci_tbl[] =3D {
 	{IXXAT_PCI_VENDOR_ID, IXXAT_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0=
, 0},
+	{ }
 };
 MODULE_DEVICE_TABLE (pci, ixxat_pci_tbl);
=20
Index: xenomai/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai/ksrc/drivers/can/sja1000/rtcan_peak_pci.c	(Revision 3330)
+++ xenomai/ksrc/drivers/can/sja1000/rtcan_peak_pci.c	(Arbeitskopie)
@@ -78,6 +78,7 @@
=20
 static struct pci_device_id peak_pci_tbl[] =3D {
 	{PEAK_PCI_VENDOR_ID, PEAK_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, =
0},
+	{ }
 };
 MODULE_DEVICE_TABLE (pci, peak_pci_tbl);
=20
Index: xenomai/ksrc/drivers/can/sja1000/rtcan_ems_pci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai/ksrc/drivers/can/sja1000/rtcan_ems_pci.c	(Revision 3330)
+++ xenomai/ksrc/drivers/can/sja1000/rtcan_ems_pci.c	(Arbeitskopie)
@@ -98,6 +98,7 @@
 static struct pci_device_id ems_pci_tbl[] =3D {
 	{EMS_PCI_VENDOR_ID, EMS_PCI_DEVICE_ID,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ }
 };
 MODULE_DEVICE_TABLE (pci, ems_pci_tbl);
=20


--------------enig250D46006DB853A1024C3CE5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHdmj3niDOoMHTA+kRAolgAJwPOU6zoV4ZNYnBfjnc/AI7y7AVmACfQBuV
f7vQyJ+xllfEPfNmcdDGSfo=
=GFHZ
-----END PGP SIGNATURE-----

--------------enig250D46006DB853A1024C3CE5--

