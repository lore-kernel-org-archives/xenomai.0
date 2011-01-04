Message-ID: <4D23435B.70603@domain.hid>
Date: Tue, 04 Jan 2011 16:57:15 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFAA45A5CFF959C6AE59FE11D"
Subject: [Xenomai-help] RFC: 16550A pci serial board support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFAA45A5CFF959C6AE59FE11D
Content-Type: multipart/mixed;
 boundary="------------030408070400060105000001"

This is a multi-part message in MIME format.
--------------030408070400060105000001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

the attached patch adds pci support to the 16550A serial driver. I have
a Moxa CP-132 board and the first tests are looking good. If there is a
chance to get the patch applied I kindly request you to review it. I'll
add support for more Moxa boards if there is a interest to apply the patc=
h.

thanks
Stefan


--------------030408070400060105000001
Content-Type: text/x-patch;
 name="xeno_16550A_pci.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="xeno_16550A_pci.patch"

diff --git a/ksrc/drivers/serial/16550A.c b/ksrc/drivers/serial/16550A.c
index 4c46d86..73665f0 100644
--- a/ksrc/drivers/serial/16550A.c
+++ b/ksrc/drivers/serial/16550A.c
@@ -140,6 +140,7 @@ MODULE_AUTHOR("jan.kiszka@domain.hid");
=20
 #include "16550A_io.h"
 #include "16550A_pnp.h"
+#include "16550A_pci.h"
=20
 static inline int rt_16550_rx_interrupt(struct rt_16550_context *ctx,
 					uint64_t * timestamp)
@@ -1119,6 +1120,7 @@ int __init rt_16550_init(void)
 	int i;
=20
 	rt_16550_pnp_init();
+	rt_16550_pci_init();
=20
 	for (i =3D 0; i < MAX_DEVICES; i++) {
 		if (!rt_16550_addr_param(i))
@@ -1192,6 +1194,7 @@ void rt_16550_exit(void)
 			kfree(device[i]);
 		}
=20
+	rt_16550_pci_cleanup();
 	rt_16550_pnp_cleanup();
 }
=20
diff --git a/ksrc/drivers/serial/16550A_pci.h b/ksrc/drivers/serial/16550=
A_pci.h
new file mode 100644
index 0000000..b766888
--- /dev/null
+++ b/ksrc/drivers/serial/16550A_pci.h
@@ -0,0 +1,123 @@
+/*
+ * Copyright (C) 2006-2007 Jan Kiszka <jan.kiszka@domain.hid>.
+ * Copyright (C) 2011 Stefan Kisdaroczi <kisda@domain.hid>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,0) && defined(CONFIG_PCI)=
 && \
+	defined(CONFIG_XENO_DRIVERS_16550A_PCI)
+
+#include <linux/pci.h>
+
+struct rt_16550_pci_board {
+	char *name;
+	resource_size_t resource_base_addr;
+	unsigned int nports;
+	unsigned int port_ofs;
+	unsigned int baud_base;
+	int tx_fifo;
+};
+
+static const struct rt_16550_pci_board rt_16550_pci_boards[] =3D {
+/*  0 */ { 0 },
+/*  1 */ { "Moxa C104H/PCI",	2, 4, 8, 921600, 16 },
+/*  2 */ { "Moxa C168H/PCI",	2, 8, 8, 921600, 16 },
+/*  3 */ { "Moxa CP-114",	2, 4, 8, 921600, 16 },
+/*  4 */ { "Moxa CP-132",	2, 2, 8, 921600, 16 },
+};
+
+/* driver_data correspond to the line in the structure above */
+DEFINE_PCI_DEVICE_TABLE( rt_16550_pci_tbl ) =3D {
+#if defined(CONFIG_XENO_DRIVERS_16550A_PCI_MOXA)
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C104),  .driver_data =3D 1 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C168),  .driver_data =3D 2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114), .driver_data =3D 3 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132), .driver_data =3D 4 },
+#endif
+	{ 0 }
+};
+
+static int __devinit rt_16550_pci_probe(       struct pci_dev *pdev,
+					 const struct pci_device_id *ent )
+{
+	struct rt_16550_pci_board *board;
+	int err;
+	int i;
+	int port =3D 0;
+	int base_addr;
+	int max_devices =3D 0;
+
+	if (!ent->driver_data)
+		return -ENODEV;
+
+	board =3D &rt_16550_pci_boards[ent->driver_data];
+
+	for (i =3D 0; i < MAX_DEVICES; i++)
+		if (!rt_16550_addr_param(i))
+			max_devices++;
+
+	if (board->nports > max_devices)
+		return -ENODEV;
+
+	if (err =3D pci_enable_device(pdev))
+		return err;
+
+	base_addr =3D pci_resource_start(pdev, board->resource_base_addr);
+
+	for (i =3D 0; i < MAX_DEVICES; i++) {
+		if ((port < board->nports) && (!rt_16550_addr_param(i))) {
+			io[i] =3D base_addr + port * board->port_ofs;
+			irq[i] =3D pdev->irq;
+			baud_base[i] =3D board->baud_base;
+			tx_fifo[i] =3D board->tx_fifo;
+			port++;
+		}
+	}
+
+	return 0;
+}
+
+static void __devexit rt_16550_pci_remove( struct pci_dev *pdev ) {
+	pci_disable_device( pdev );
+};
+
+static struct pci_driver rt_16550_pci_driver =3D {
+	.name     =3D RT_16550_DRIVER_NAME,
+	.id_table =3D rt_16550_pci_tbl,
+	.probe    =3D rt_16550_pci_probe,
+	.remove   =3D __devexit_p(rt_16550_pci_remove)
+};
+
+static int pci_registered;
+
+static inline void rt_16550_pci_init(void)
+{
+	if (pci_register_driver(&rt_16550_pci_driver) =3D=3D 0)
+		pci_registered =3D 1;
+}
+
+static inline void rt_16550_pci_cleanup(void)
+{
+	if (pci_registered)
+		pci_unregister_driver(&rt_16550_pci_driver);
+}
+
+#else /* Linux < 2.6.0 || !CONFIG_PCI || !(..._16550A_PCI */
+
+#define rt_16550_pci_init()	do { } while (0)
+#define rt_16550_pci_cleanup()	do { } while (0)
+
+#endif /* Linux < 2.6.0 || !CONFIG_PCI || !(..._16550A_PCI */
diff --git a/ksrc/drivers/serial/Kconfig b/ksrc/drivers/serial/Kconfig
index afbaabf..4964f05 100644
--- a/ksrc/drivers/serial/Kconfig
+++ b/ksrc/drivers/serial/Kconfig
@@ -39,4 +39,24 @@ config XENO_DRIVERS_16550A_ANY
=20
 endchoice
=20
+config XENO_DRIVERS_16550A_PCI
+	depends on XENO_DRIVERS_16550A_PIO || XENO_DRIVERS_16550A_ANY
+	bool "PCI board support"
+	default n
+	help
+
+	This option activates support for PCI serial boards.
+
+config XENO_DRIVERS_16550A_PCI_MOXA
+	depends on XENO_DRIVERS_16550A_PCI
+	bool "Moxa multiport PCI boards"
+	default n
+	help
+
+	This option activates support for the following Moxa PCI serial boards:=

+	- C104H/PCI
+	- C168H/PCI
+	- CP-114
+	- CP-132
+
 endmenu

--------------030408070400060105000001--

--------------enigFAA45A5CFF959C6AE59FE11D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk0jQ2MACgkQIPTw9rIdn6oupgCdHAvhnMQJwkHomncVFQ0B2yy0
HesAniv7WEVvCWmWZybZSHksW9bApM9/
=vHXV
-----END PGP SIGNATURE-----

--------------enigFAA45A5CFF959C6AE59FE11D--

