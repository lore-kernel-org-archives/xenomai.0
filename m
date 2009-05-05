Message-ID: <4A008DC9.1000603@domain.hid>
Date: Tue, 05 May 2009 21:04:41 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2BDCFFA281BDED63E4E7BA59"
Subject: [Xenomai-help] IXXAT-PCI-CAN driver hijacks my pci board
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
--------------enig2BDCFFA281BDED63E4E7BA59
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

my pci board has the same pci-interface-chip as the IXXAT-PCI board.
The vendor and device id's are identical, but the subsys id is different.=


The documentation for my board says that it is essential to check all ID =
values,
because vendor and device id are standard values for the pci-interface-ch=
ip.

dmesg output, there is no IXXAT-PCI-CAN board installed:
> RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
> RTCAN SJA1000 driver initialized
> PCI: setting IRQ 12 as level-triggered
> IXXAT-PCI-CAN 0000:00:11.0: found PCI INT A -> IRQ 12
> IXXAT-PCI-CAN: Initializing device 10b5:9050:2503

The following patch fixed it for me (my own driver loads again).
However, i could not check if it still detects the CAN board,
as i dont have one.

Thanks
kisda

--- xenomai-2.4.7.orig/ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c
+++ xenomai-2.4.7/ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c
@@ -73,7 +73,7 @@
 #define IXXAT_BASE_PORT_SIZE 0x0400

 static struct pci_device_id ixxat_pci_tbl[] =3D {
-	{IXXAT_PCI_VENDOR_ID, IXXAT_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0=
, 0},
+	{IXXAT_PCI_VENDOR_ID, IXXAT_PCI_DEVICE_ID, IXXAT_PCI_VENDOR_ID, IXXAT_P=
CI_SUB_SYS_ID, 0, 0, 0},
 	{ }
 };
 MODULE_DEVICE_TABLE (pci, ixxat_pci_tbl);



--------------enig2BDCFFA281BDED63E4E7BA59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFKAI3KIPTw9rIdn6oRAkXLAJ9jV+bBoa5Mq/KQsZiSrDmNBRCIagCfZXge
uL9cbyUuxyEFoab80wvoguk=
=O7+U
-----END PGP SIGNATURE-----

--------------enig2BDCFFA281BDED63E4E7BA59--

