From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Fri, 7 Jan 2011 23:21:43 +0100
References: <4D23435B.70603@domain.hid> <201101052303.46018.kisda@domain.hid>
	<4D26CEBE.6070308@domain.hid>
In-Reply-To: <4D26CEBE.6070308@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3H5JNFdf/BJt6Oi"
Message-Id: <201101072321.43680.kisda@domain.hid>
Subject: Re: [Xenomai-help] RFC: 16550A pci serial board support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

--Boundary-00=_3H5JNFdf/BJt6Oi
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

Am Freitag 07 Januar 2011, 09:28:46 schrieb Jan Kiszka:
> Am 05.01.2011 23:03, Stefan Kisdaroczi wrote:
> > Am Mittwoch 05 Januar 2011, 20:55:29 schrieb Jan Kiszka:
> >> Am 05.01.2011 20:40, Stefan Kisdaroczi wrote:
> >>> Am Dienstag 04 Januar 2011, 20:49:59 schrieben Sie:
> >>>> Stefan Kisdaroczi wrote:
> >>>>> Hi,
> >>>>> 
> >>>>> the attached patch adds pci support to the 16550A serial driver. I
> >>>>> have a Moxa CP-132 board and the first tests are looking good. If
> >>>>> there is a chance to get the patch applied I kindly request you to
> >>>>> review it. I'll add support for more Moxa boards if there is a
> >>>>> interest to apply the patch.
> >>>>> 
> >>>>> thanks
> >>>>> Stefan
> >>>> 
> >>>> Looks fine to me, however, nit-picking a bit, could we do this 
differently:
> >>> new patches attached.
> >> 
> >> Looks good to me as well except for a minor white space damage:
> >>> +static int __devinit rt_16550_pci_probe(       struct pci_dev *pdev,
> >>> 
> >>                                            ^^^^^^^
> >> 
> >> I have one further suggestion which can be done on top: The RTDM_IRQTYPE
> >> flags should be customized as well. So far we assume edge-type devices,
> >> but PCI is level-triggered. Requesting edge works, but is suboptimal.
> >> 
> >> Jan
> > 
> > thanks for the input. updated patches attached with customizable irqtype.
> > better? (not compiled and not tested -> tomorrow)
> 
> Fine with me (unless an even smarter solution shows up, but I don't see
> it ATM). One simplification:
> 
> static unsigned long irqtype[MAX_DEVICES] = {
> 	[0 ... MAX_DEVICES-1] = RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE;
> };
> 
> Jan

fixed and tested patches attached.

Stefan

--Boundary-00=_3H5JNFdf/BJt6Oi
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-16550A-customizable-irqtype.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-16550A-customizable-irqtype.patch"

=46rom 69ffa9ea1225382fbad995e22caf8da837322b46 Mon Sep 17 00:00:00 2001
=46rom: Stefan Kisdaroczi <kisda@domain.hid>
Date: Fri, 7 Jan 2011 20:21:16 +0100
Subject: [PATCH 1/3] 16550A: customizable irqtype

=2D--
 ksrc/drivers/serial/16550A.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/ksrc/drivers/serial/16550A.c b/ksrc/drivers/serial/16550A.c
index 4c46d86..f290e43 100644
=2D-- a/ksrc/drivers/serial/16550A.c
+++ b/ksrc/drivers/serial/16550A.c
@@ -119,6 +119,9 @@ static const struct rtser_config default_config =3D {
 static struct rtdm_device *device[MAX_DEVICES];
=20
 static unsigned int irq[MAX_DEVICES];
+static unsigned long irqtype[MAX_DEVICES] =3D {
+	[0 ... MAX_DEVICES-1] =3D RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE
+};
 static unsigned int baud_base[MAX_DEVICES];
 static int tx_fifo[MAX_DEVICES];
 static unsigned int start_index;
@@ -478,8 +481,7 @@ int rt_16550_open(struct rtdm_dev_context *context,
 	rt_16550_set_config(ctx, &default_config, &dummy);
=20
 	err =3D rtdm_irq_request(&ctx->irq_handle, irq[dev_id],
=2D			       rt_16550_interrupt,
=2D			       RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE,
+			       rt_16550_interrupt, irqtype[dev_id],
 			       context->device->proc_name, ctx);
 	if (err) {
 		/* reset DTR and RTS */
=2D-=20
1.7.2.3


--Boundary-00=_3H5JNFdf/BJt6Oi
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0002-16550A-pci-support.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-16550A-pci-support.patch"

=46rom 7008e23c297bf966d79eeca534fa3abe7a589ea5 Mon Sep 17 00:00:00 2001
=46rom: Stefan Kisdaroczi <kisda@domain.hid>
Date: Fri, 7 Jan 2011 20:21:48 +0100
Subject: [PATCH 2/3] 16550A: pci support

=2D--
 ksrc/drivers/serial/16550A.c     |    3 +
 ksrc/drivers/serial/16550A_pci.h |  110 ++++++++++++++++++++++++++++++++++=
++++
 ksrc/drivers/serial/Kconfig      |    8 +++
 3 files changed, 121 insertions(+), 0 deletions(-)
 create mode 100644 ksrc/drivers/serial/16550A_pci.h

diff --git a/ksrc/drivers/serial/16550A.c b/ksrc/drivers/serial/16550A.c
index f290e43..8c8c864 100644
=2D-- a/ksrc/drivers/serial/16550A.c
+++ b/ksrc/drivers/serial/16550A.c
@@ -143,6 +143,7 @@ MODULE_AUTHOR("jan.kiszka@domain.hid");
=20
 #include "16550A_io.h"
 #include "16550A_pnp.h"
+#include "16550A_pci.h"
=20
 static inline int rt_16550_rx_interrupt(struct rt_16550_context *ctx,
 					uint64_t * timestamp)
@@ -1121,6 +1122,7 @@ int __init rt_16550_init(void)
 	int i;
=20
 	rt_16550_pnp_init();
+	rt_16550_pci_init();
=20
 	for (i =3D 0; i < MAX_DEVICES; i++) {
 		if (!rt_16550_addr_param(i))
@@ -1194,6 +1196,7 @@ void rt_16550_exit(void)
 			kfree(device[i]);
 		}
=20
+	rt_16550_pci_cleanup();
 	rt_16550_pnp_cleanup();
 }
=20
diff --git a/ksrc/drivers/serial/16550A_pci.h b/ksrc/drivers/serial/16550A_=
pci.h
new file mode 100644
index 0000000..442846d
=2D-- /dev/null
+++ b/ksrc/drivers/serial/16550A_pci.h
@@ -0,0 +1,110 @@
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
+#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,0) && defined(CONFIG_PCI) &=
& \
+	defined(CONFIG_XENO_DRIVERS_16550A_PCI)
+
+#include <linux/pci.h>
+
+struct rt_16550_pci_board {
+	char *name;
+	resource_size_t resource_base_addr;
+	unsigned int nports;
+	unsigned int port_ofs;
+	unsigned long irqtype;
+	unsigned int baud_base;
+	int tx_fifo;
+};
+
+DEFINE_PCI_DEVICE_TABLE( rt_16550_pci_table ) =3D {
+	{ }
+};
+
+static int __devinit rt_16550_pci_probe( struct pci_dev *pdev,
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
+	board =3D (struct rt_16550_pci_board *)ent->driver_data;
+
+	for (i =3D 0; i < MAX_DEVICES; i++)
+		if (!rt_16550_addr_param(i))
+			max_devices++;
+
+	if (board->nports > max_devices)
+		return -ENODEV;
+
+	if ((err =3D pci_enable_device(pdev)))
+		return err;
+
+	base_addr =3D pci_resource_start(pdev, board->resource_base_addr);
+
+	for (i =3D 0; i < MAX_DEVICES; i++) {
+		if ((port < board->nports) && (!rt_16550_addr_param(i))) {
+			io[i] =3D base_addr + port * board->port_ofs;
+			irq[i] =3D pdev->irq;
+			irqtype[i] =3D board->irqtype;
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
+	.id_table =3D rt_16550_pci_table,
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
index afbaabf..b468fbc 100644
=2D-- a/ksrc/drivers/serial/Kconfig
+++ b/ksrc/drivers/serial/Kconfig
@@ -39,4 +39,12 @@ config XENO_DRIVERS_16550A_ANY
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
 endmenu
=2D-=20
1.7.2.3


--Boundary-00=_3H5JNFdf/BJt6Oi
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0003-16550A-Moxa-pci-board-support.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0003-16550A-Moxa-pci-board-support.patch"

=46rom a5bfbb4368d70707c515fa360926840b1f9af1c6 Mon Sep 17 00:00:00 2001
=46rom: Stefan Kisdaroczi <kisda@domain.hid>
Date: Fri, 7 Jan 2011 20:23:27 +0100
Subject: [PATCH 3/3] 16550A: Moxa pci board support

=2D--
 ksrc/drivers/serial/16550A_pci.h |  177 ++++++++++++++++++++++++++++++++++=
++++
 ksrc/drivers/serial/Kconfig      |   16 ++++
 2 files changed, 193 insertions(+), 0 deletions(-)

diff --git a/ksrc/drivers/serial/16550A_pci.h b/ksrc/drivers/serial/16550A_=
pci.h
index 442846d..2c71a5e 100644
=2D-- a/ksrc/drivers/serial/16550A_pci.h
+++ b/ksrc/drivers/serial/16550A_pci.h
@@ -32,7 +32,184 @@ struct rt_16550_pci_board {
 	int tx_fifo;
 };
=20
+#if defined(CONFIG_XENO_DRIVERS_16550A_PCI_MOXA)
+
+#define PCI_DEVICE_ID_CP112UL	0x1120
+#define PCI_DEVICE_ID_CP114UL	0x1143
+#define PCI_DEVICE_ID_CP138U	0x1380
+
+static const struct rt_16550_pci_board rt_16550_moxa_c104 =3D {
+	.name =3D "Moxa C104H/PCI",
+	.resource_base_addr =3D 2,
+	.nports =3D 4,
+	.port_ofs =3D 8,
+	.baud_base =3D 921600,
+	.tx_fifo =3D 16,
+	.irqtype =3D RTDM_IRQTYPE_SHARED,
+};
+
+static const struct rt_16550_pci_board rt_16550_moxa_c168 =3D {
+	.name =3D "Moxa C168H/PCI",
+	.resource_base_addr =3D 2,
+	.nports =3D 8,
+	.port_ofs =3D 8,
+	.baud_base =3D 921600,
+	.tx_fifo =3D 16,
+	.irqtype =3D RTDM_IRQTYPE_SHARED,
+};
+
+static const struct rt_16550_pci_board rt_16550_moxa_cp114 =3D {
+	.name =3D "Moxa CP-114",
+	.resource_base_addr =3D 2,
+	.nports =3D 4,
+	.port_ofs =3D 8,
+	.baud_base =3D 921600,
+	.tx_fifo =3D 16,
+	.irqtype =3D RTDM_IRQTYPE_SHARED,
+};
+
+static const struct rt_16550_pci_board rt_16550_moxa_cp132 =3D {
+	.name =3D "Moxa CP-132",
+	.resource_base_addr =3D 2,
+	.nports =3D 2,
+	.port_ofs =3D 8,
+	.baud_base =3D 921600,
+	.tx_fifo =3D 16,
+	.irqtype =3D RTDM_IRQTYPE_SHARED,
+};
+
+static const struct rt_16550_pci_board rt_16550_moxa_cp102u =3D {
+	.name =3D "Moxa CP-102U",
+	.resource_base_addr =3D 2,
+	.nports =3D 2,
+	.port_ofs =3D 8,
+	.baud_base =3D 921600,
+	.tx_fifo =3D 16,
+	.irqtype =3D RTDM_IRQTYPE_SHARED,
+};
+
+static const struct rt_16550_pci_board rt_16550_moxa_cp102ul =3D {
+	.name =3D "Moxa CP-102UL",
+	.resource_base_addr =3D 2,
+	.nports =3D 2,
+	.port_ofs =3D 8,
+	.baud_base =3D 921600,
+	.tx_fifo =3D 16,
+	.irqtype =3D RTDM_IRQTYPE_SHARED,
+};
+
+static const struct rt_16550_pci_board rt_16550_moxa_cp104u =3D {
+	.name =3D "Moxa CP-104U",
+	.resource_base_addr =3D 2,
+	.nports =3D 4,
+	.port_ofs =3D 8,
+	.baud_base =3D 921600,
+	.tx_fifo =3D 16,
+	.irqtype =3D RTDM_IRQTYPE_SHARED,
+};
+
+static const struct rt_16550_pci_board rt_16550_moxa_cp112ul =3D {
+	.name =3D "Moxa CP-112UL",
+	.resource_base_addr =3D 2,
+	.nports =3D 2,
+	.port_ofs =3D 8,
+	.baud_base =3D 921600,
+	.tx_fifo =3D 16,
+	.irqtype =3D RTDM_IRQTYPE_SHARED,
+};
+
+static const struct rt_16550_pci_board rt_16550_moxa_cp114ul =3D {
+	.name =3D "Moxa CP-114UL",
+	.resource_base_addr =3D 2,
+	.nports =3D 4,
+	.port_ofs =3D 8,
+	.baud_base =3D 921600,
+	.tx_fifo =3D 16,
+	.irqtype =3D RTDM_IRQTYPE_SHARED,
+};
+
+static const struct rt_16550_pci_board rt_16550_moxa_cp118u =3D {
+	.name =3D "Moxa CP-118U",
+	.resource_base_addr =3D 2,
+	.nports =3D 8,
+	.port_ofs =3D 8,
+	.baud_base =3D 921600,
+	.tx_fifo =3D 16,
+	.irqtype =3D RTDM_IRQTYPE_SHARED,
+};
+
+static const struct rt_16550_pci_board rt_16550_moxa_cp132u =3D {
+	.name =3D "Moxa CP-132U",
+	.resource_base_addr =3D 2,
+	.nports =3D 2,
+	.port_ofs =3D 8,
+	.baud_base =3D 921600,
+	.tx_fifo =3D 16,
+	.irqtype =3D RTDM_IRQTYPE_SHARED,
+};
+
+static const struct rt_16550_pci_board rt_16550_moxa_cp134u =3D {
+	.name =3D "Moxa CP-134U",
+	.resource_base_addr =3D 2,
+	.nports =3D 4,
+	.port_ofs =3D 8,
+	.baud_base =3D 921600,
+	.tx_fifo =3D 16,
+	.irqtype =3D RTDM_IRQTYPE_SHARED,
+};
+
+static const struct rt_16550_pci_board rt_16550_moxa_cp138u =3D {
+	.name =3D "Moxa CP-138U",
+	.resource_base_addr =3D 2,
+	.nports =3D 8,
+	.port_ofs =3D 8,
+	.baud_base =3D 921600,
+	.tx_fifo =3D 16,
+	.irqtype =3D RTDM_IRQTYPE_SHARED,
+};
+
+static const struct rt_16550_pci_board rt_16550_moxa_cp168u =3D {
+	.name =3D "Moxa CP-168U",
+	.resource_base_addr =3D 2,
+	.nports =3D 8,
+	.port_ofs =3D 8,
+	.baud_base =3D 921600,
+	.tx_fifo =3D 16,
+	.irqtype =3D RTDM_IRQTYPE_SHARED,
+};
+#endif
+
 DEFINE_PCI_DEVICE_TABLE( rt_16550_pci_table ) =3D {
+#if defined(CONFIG_XENO_DRIVERS_16550A_PCI_MOXA)
+	{PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C104),
+	 .driver_data =3D (unsigned long)&rt_16550_moxa_c104},
+	{PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C168),
+	 .driver_data =3D (unsigned long)&rt_16550_moxa_c168},
+	{PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114),
+	 .driver_data =3D (unsigned long)&rt_16550_moxa_cp114},
+	{PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132),
+	 .driver_data =3D (unsigned long)&rt_16550_moxa_cp132},
+	{PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102U),
+	 .driver_data =3D (unsigned long)&rt_16550_moxa_cp102u},
+	{PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102UL),
+	 .driver_data =3D (unsigned long)&rt_16550_moxa_cp102ul},
+	{PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104U),
+	 .driver_data =3D (unsigned long)&rt_16550_moxa_cp104u},
+	{PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP112UL),
+	 .driver_data =3D (unsigned long)&rt_16550_moxa_cp112ul},
+	{PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP114UL),
+	 .driver_data =3D (unsigned long)&rt_16550_moxa_cp114ul},
+	{PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118U),
+	 .driver_data =3D (unsigned long)&rt_16550_moxa_cp118u},
+	{PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132U),
+	 .driver_data =3D (unsigned long)&rt_16550_moxa_cp132u},
+	{PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134U),
+	 .driver_data =3D (unsigned long)&rt_16550_moxa_cp134u},
+	{PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP138U),
+	 .driver_data =3D (unsigned long)&rt_16550_moxa_cp138u},
+	{PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168U),
+	 .driver_data =3D (unsigned long)&rt_16550_moxa_cp168u},
+#endif
 	{ }
 };
=20
diff --git a/ksrc/drivers/serial/Kconfig b/ksrc/drivers/serial/Kconfig
index b468fbc..d3c100e 100644
=2D-- a/ksrc/drivers/serial/Kconfig
+++ b/ksrc/drivers/serial/Kconfig
@@ -47,4 +47,20 @@ config XENO_DRIVERS_16550A_PCI
=20
 	This option activates support for PCI serial boards.
=20
+config XENO_DRIVERS_16550A_PCI_MOXA
+	depends on XENO_DRIVERS_16550A_PCI
+	bool "Moxa PCI boards"
+	default n
+	help
+
+	This option activates support for the following Moxa boards:
+	PCI Serial Boards:
+	  C104H/PCI, C168H/PCI
+	  CP-114, CP-132
+	Universal PCI Serial Boards:
+	  CP-102U, CP-102UL, CP-104U
+	  CP-112UL, CP-114UL, CP-118U
+	  CP-132U, CP-134U, CP-138U
+	  CP-168U
+
 endmenu
=2D-=20
1.7.2.3


--Boundary-00=_3H5JNFdf/BJt6Oi--

