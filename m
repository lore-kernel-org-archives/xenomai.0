Message-ID: <46CC16CD.7080603@domain.hid>
Date: Wed, 22 Aug 2007 12:58:21 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050106040707060105010800"
Subject: [Xenomai-core] [PATCH] RT-Socket-CAN driver for EMS CPC PCI card
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

This is a multi-part message in MIME format.
--------------050106040707060105010800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

the following patch changes:

2007-08-22  Wolfgang Grandegger  <wg@domain.hid>

	* ksrc/drivers/can/sja1000: Add the RT-Socket-CAN SJA1000 driver
	rtcan_ems_pci.c for the EMS CPC PCI card from EMS Dr. Thomas
	Wuensche (http://www.ems-wuensche.de).

I would like to apply it to Xenomai's trunk and v2.3.x branch.

Wolfgang.

--------------050106040707060105010800
Content-Type: text/x-patch;
 name="xenomai-rtcan-ems-cpc-pci.patch"
Content-Disposition: inline;
 filename="xenomai-rtcan-ems-cpc-pci.patch"
Content-Transfer-Encoding: quoted-printable

Index: scripts/Modules.frag
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- scripts/Modules.frag	(revision 2945)
+++ scripts/Modules.frag	(working copy)
@@ -20,4 +20,5 @@ DRIVERS-$(CONFIG_XENO_DRIVERS_CAN_SJA100
 DRIVERS-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_PCI) +=3D drivers/xenomai=
/can/sja1000/xeno_can_peak_pci.o
 DRIVERS-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_DNG) +=3D drivers/xenomai=
/can/sja1000/xeno_can_peak_dng.o
 DRIVERS-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_IXXAT_PCI) +=3D drivers/xenoma=
i/can/sja1000/xeno_can_ixxat_pci.o
+DRIVERS-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_EMS_PCI) +=3D drivers/xenomai/=
can/sja1000/xeno_can_ems_pci.o
=20
Index: ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ChangeLog	(revision 2945)
+++ ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2007-08-22  Wolfgang Grandegger  <wg@domain.hid>
+
+	* ksrc/drivers/can/sja1000: Add the RT-Socket-CAN SJA1000 driver
+	rtcan_ems_pci.c for the EMS CPC PCI card from EMS Dr. Thomas
+	Wuensche (http://www.ems-wuensche.de).
+
 2007-08-18  Philippe Gerum  <rpm@xenomai.org>
=20
 	* RELEASE: Xenomai 2.4-rc2
Index: ksrc/drivers/can/sja1000/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/can/sja1000/Kconfig	(revision 2945)
+++ ksrc/drivers/can/sja1000/Kconfig	(working copy)
@@ -42,6 +42,16 @@ config XENO_DRIVERS_CAN_SJA1000_IXXAT_PC
 	must be enabled.
=20
=20
+config XENO_DRIVERS_CAN_SJA1000_EMS_PCI
+	depends on XENO_DRIVERS_CAN_SJA1000
+	tristate "EMS CPC PCI Card"
+	help
+
+	This driver is for the 2 channel CPC PCI card from EMS Dr. Thomas
+	W=C3=BCnsche (http://www.ems-wuensche.de). To get the second channel
+	working, Xenomai's shared interrupt support must be enabled.
+
+
 config XENO_DRIVERS_CAN_SJA1000_PEAK_DNG
 	depends on XENO_DRIVERS_CAN_SJA1000
 	tristate "PEAK Parallel Port Dongle"
Index: ksrc/drivers/can/sja1000/rtcan_ems_pci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/can/sja1000/rtcan_ems_pci.c	(revision 0)
+++ ksrc/drivers/can/sja1000/rtcan_ems_pci.c	(revision 0)
@@ -0,0 +1,345 @@
+/*
+ * Copyright (C) 2007 Wolfgang Grandegger <wg@domain.hid>
+ *
+ * Register definitions and descriptions are taken from LinCAN 0.3.3.
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundatio=
n,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+
+#include <rtdm/rtdm_driver.h>
+
+/* CAN device profile */
+#include <rtdm/rtcan.h>
+#include <rtcan_dev.h>
+#include <rtcan_raw.h>
+#include <rtcan_internal.h>
+#include <rtcan_sja1000.h>
+#include <rtcan_sja1000_regs.h>
+
+#define RTCAN_DEV_NAME    "rtcan%d"
+#define RTCAN_DRV_NAME    "EMS-CPC-PCI-CAN"
+
+static char *ems_pci_board_name =3D "EMS-CPC-PCI";
+
+MODULE_AUTHOR("Wolfgang Grandegger <wg@domain.hid>");
+MODULE_DESCRIPTION("RTCAN board driver for EMS CPC-PCI cards");
+MODULE_SUPPORTED_DEVICE("EMS CPC-PCI card CAN controller");
+MODULE_LICENSE("GPL");
+
+struct rtcan_ems_pci
+{
+    struct pci_dev *pci_dev;
+    struct rtcan_device *slave_dev;
+    int channel;
+    volatile void __iomem *base_addr;
+    volatile void __iomem *conf_addr;
+};
+
+#define EMS_PCI_SINGLE 0 /* this is a single channel device */
+#define EMS_PCI_MASTER 1 /* multi channel device, this device is master =
*/
+#define EMS_PCI_SLAVE  2 /* multi channel device, this is slave */
+
+/*
+ * PSB4610 PITA-2 bridge control registers
+ */
+#define PITA2_ICR           0x00	/* Interrupt Control Register */
+#define PITA2_ICR_INT0      0x00000002	/* [RC] INT0 Active/Clear */
+#define PITA2_ICR_GP0_INT   0x00000004	/* [RC] GP0 Interrupt: GP0_Int_En=
=3D1,
+					   GP0_Out_En=3D0 and low detected */
+#define PITA2_ICR_GP1_INT   0x00000008	/* [RC] GP1 Interrupt */
+#define PITA2_ICR_GP2_INT   0x00000010	/* [RC] GP2 Interrupt */
+#define PITA2_ICR_GP3_INT   0x00000020	/* [RC] GP2 Interrupt */
+#define PITA2_ICR_INT0_EN   0x00020000	/* [RW] Enable INT0 */
+
+#define PITA2_MISC          0x1c	/* Miscellaneous Register */
+#define PITA2_MISC_CONFIG   0x04000000	/* Multiplexed Parallel_interface=
_model */
+
+/*
+ * The board configuration is probably following:
+ * RX1 is connected to ground.
+ * TX1 is not connected.
+ * CLKO is not connected.
+ * Setting the OCR register to 0xDA is a good idea.
+ * This means  normal output mode , push-pull and the correct polarity.
+ */
+#define EMS_PCI_OCR_STD     0xda	/* Standard value: Pushpull */
+#define EMS_PCI_OCR_GAL     0xdb	/* For Galathea piggyback. */
+
+/*
+ * In the CDR register, you should set CBP to 1.
+ * You will probably also want to set the clock divider value to 7
+ * (meaning direct oscillator output) because the second SJA1000 chip
+ * is driven by the first one CLKOUT output.
+ */
+#define EMS_PCI_CDR_MASTER  (SJA_CDR_CAN_MODE | SJA_CDR_CBP | 0x07)
+#define EMS_PCI_CDR_SINGLE  (SJA_CDR_CAN_MODE | SJA_CDR_CBP | 0x07 | \
+			     SJA_CDR_CLK_OFF)
+#define EMS_PCI_CONF_SIZE   0x0100  /* Size of the config io-memory */
+#define EMS_PCI_PORT_START  0x0400  /* Start of the channel io-memory */
+#define EMS_PCI_PORT_SIZE   0x0200  /* Size of a channel io-memory */
+
+
+#define EMS_PCI_PORT_BYTES  0x4     /* Each register occupies 4 bytes */
+
+#define EMS_PCI_VENDOR_ID   0x110a  /* PCI device and vendor ID */
+#define EMS_PCI_DEVICE_ID   0x2104
+
+static struct pci_device_id ems_pci_tbl[] =3D {
+	{EMS_PCI_VENDOR_ID, EMS_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}=
,
+};
+MODULE_DEVICE_TABLE (pci, ems_pci_tbl);
+
+#define EMS_PCI_CAN_SYS_CLOCK (16000000 / 2)
+
+static u8 rtcan_ems_pci_read_reg(struct rtcan_device *dev, int port)
+{
+    struct rtcan_ems_pci *board =3D (struct rtcan_ems_pci *)dev->board_p=
riv;
+    return readb(board->base_addr + (port * EMS_PCI_PORT_BYTES));
+}
+
+static void rtcan_ems_pci_write_reg(struct rtcan_device *dev, int port, =
u8 data)
+{
+    struct rtcan_ems_pci *board =3D (struct rtcan_ems_pci *)dev->board_p=
riv;
+    writeb(data, board->base_addr + (port * EMS_PCI_PORT_BYTES));
+}
+
+static void rtcan_ems_pci_irq_ack(struct rtcan_device *dev)
+{
+    struct rtcan_ems_pci *board =3D (struct rtcan_ems_pci *)dev->board_p=
riv;
+
+    writel(PITA2_ICR_INT0_EN | PITA2_ICR_INT0,
+	   board->conf_addr + PITA2_ICR);
+}
+
+static void rtcan_ems_pci_del_chan(struct rtcan_device *dev,
+				    int init_step)
+{
+    struct rtcan_ems_pci *board;
+
+    if (!dev)
+	return;
+
+    board =3D (struct rtcan_ems_pci *)dev->board_priv;
+
+    switch (init_step) {
+    case 0:			/* Full cleanup */
+	 RTCAN_DBG("Removing %s %s device %s\n",
+		   ems_pci_board_name, dev->ctrl_name, dev->name);
+	rtcan_sja1000_unregister(dev);
+    case 5:
+    case 4:
+	iounmap((void *)board->base_addr);
+    case 3:
+	if (board->channel !=3D EMS_PCI_SLAVE)
+	    iounmap((void *)board->conf_addr);
+    case 2:
+        rtcan_dev_free(dev);
+    case 1:
+	break;
+    }
+}
+
+static int rtcan_ems_pci_add_chan(struct pci_dev *pdev, int channel,
+				   struct rtcan_device **master_dev)
+{
+    struct rtcan_device *dev;
+    struct rtcan_sja1000 *chip;
+    struct rtcan_ems_pci *board;
+    unsigned long addr;
+    int ret, init_step =3D 1;
+
+    dev =3D rtcan_dev_alloc(sizeof(struct rtcan_sja1000),
+			  sizeof(struct rtcan_ems_pci));
+    if (dev =3D=3D NULL)
+        return -ENOMEM;
+    init_step =3D 2;
+
+    chip =3D (struct rtcan_sja1000 *)dev->priv;
+    board =3D (struct rtcan_ems_pci *)dev->board_priv;
+
+    board->pci_dev =3D pdev;
+    board->channel =3D channel;
+
+    if (channel !=3D EMS_PCI_SLAVE) {
+
+	addr =3D pci_resource_start(pdev, 0);
+	board->conf_addr =3D ioremap(addr, EMS_PCI_CONF_SIZE);
+	if (board->conf_addr =3D=3D 0) {
+	    ret =3D -ENODEV;
+	    goto failure;
+	}
+	init_step =3D 3;
+
+	/* Configure PITA-2 parallel interface */
+	writel(PITA2_MISC_CONFIG, board->conf_addr + PITA2_MISC);
+	/* Enable interrupts from card */
+	writel(PITA2_ICR_INT0_EN, board->conf_addr + PITA2_ICR);
+    } else {
+	struct rtcan_ems_pci *master_board =3D
+	    (struct rtcan_ems_pci *)(*master_dev)->board_priv;
+	master_board->slave_dev =3D dev;
+	board->conf_addr =3D master_board->conf_addr;
+    }
+
+    addr =3D pci_resource_start(pdev, 1) + EMS_PCI_PORT_START;
+    if (channel =3D=3D EMS_PCI_SLAVE)
+	addr +=3D EMS_PCI_PORT_SIZE;
+
+    board->base_addr =3D ioremap(addr, EMS_PCI_PORT_SIZE);
+    if (board->base_addr =3D=3D 0) {
+	ret =3D -ENODEV;
+	goto failure;
+    }
+    init_step =3D 4;
+
+    dev->board_name =3D ems_pci_board_name;
+
+    chip->read_reg =3D rtcan_ems_pci_read_reg;
+    chip->write_reg =3D rtcan_ems_pci_write_reg;
+    chip->irq_ack =3D rtcan_ems_pci_irq_ack;
+
+    /* Clock frequency in Hz */
+    dev->can_sys_clock =3D EMS_PCI_CAN_SYS_CLOCK;
+
+    /* Output control register */
+    chip->ocr =3D EMS_PCI_OCR_STD;
+
+    /* Clock divider register */
+    if (channel =3D=3D EMS_PCI_MASTER)
+	chip->cdr =3D EMS_PCI_CDR_MASTER;
+    else
+	chip->cdr =3D EMS_PCI_CDR_SINGLE;
+
+    strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+
+    /* Register and setup interrupt handling */
+#ifdef CONFIG_XENO_OPT_SHIRQ_LEVEL
+    chip->irq_flags =3D RTDM_IRQTYPE_SHARED;
+#else
+    chip->irq_flags =3D 0;
+#endif
+    chip->irq_num =3D pdev->irq;
+    init_step =3D 5;
+
+    printk("%s: base_addr=3D%p conf_addr=3D%p irq=3D%d\n", RTCAN_DRV_NAM=
E,
+	   board->base_addr, board->conf_addr, chip->irq_num);
+
+    /* Register SJA1000 device */
+    ret =3D rtcan_sja1000_register(dev);
+    if (ret) {
+	printk(KERN_ERR "ERROR while trying to register SJA1000 device %d!\n",
+	       ret);
+	goto failure;
+    }
+
+    if (channel !=3D EMS_PCI_SLAVE)
+	*master_dev =3D dev;
+
+    return 0;
+
+ failure:
+    rtcan_ems_pci_del_chan(dev, init_step);
+    return ret;
+}
+
+static int __devinit ems_pci_init_one (struct pci_dev *pdev,
+					const struct pci_device_id *ent)
+{
+    struct rtcan_device *master_dev =3D NULL;
+    int ret;
+
+    RTCAN_DBG("%s: initializing device %04x:%04x\n",
+	      RTCAN_DRV_NAME,  pdev->vendor, pdev->device);
+
+    if ((ret =3D pci_enable_device (pdev)))
+	goto failure;
+
+   if ((ret =3D pci_request_regions(pdev, RTCAN_DRV_NAME)))
+	goto failure;
+
+    if ((ret =3D pci_write_config_word(pdev, 0x04, 2)))
+	goto failure_cleanup;
+
+#ifdef CONFIG_XENO_OPT_SHIRQ_LEVEL
+    if ((ret =3D rtcan_ems_pci_add_chan(pdev, EMS_PCI_MASTER,
+				      &master_dev)))
+	    goto failure_cleanup;
+    if ((ret =3D rtcan_ems_pci_add_chan(pdev, EMS_PCI_SLAVE,
+				      &master_dev)))
+	    goto failure_cleanup;
+#else
+    printk("Shared interrupts not enabled, using single channel!\n");
+    if ((ret =3D rtcan_ems_pci_add_chan(pdev, EMS_PCI_MASTER,
+				      &master_dev)))
+	    goto failure_cleanup;
+#endif
+
+    pci_set_drvdata(pdev, master_dev);
+    return 0;
+
+ failure_cleanup:
+    if (master_dev)
+	rtcan_ems_pci_del_chan(master_dev, 0);
+
+    pci_release_regions(pdev);
+
+ failure:
+    return ret;
+
+}
+
+static void __devexit ems_pci_remove_one (struct pci_dev *pdev)
+{
+    struct rtcan_device *dev =3D pci_get_drvdata(pdev);
+    struct rtcan_ems_pci *board =3D (struct rtcan_ems_pci *)dev->board_p=
riv;
+
+    /* Disable interrupts from card */
+    writel(0x0, board->conf_addr + PITA2_ICR);
+
+    if (board->slave_dev)
+	rtcan_ems_pci_del_chan(board->slave_dev, 0);
+    rtcan_ems_pci_del_chan(dev, 0);
+
+    pci_release_regions(pdev);
+    pci_disable_device(pdev);
+    pci_set_drvdata(pdev, NULL);
+}
+
+static struct pci_driver rtcan_ems_pci_driver =3D {
+	.name		=3D RTCAN_DRV_NAME,
+	.id_table	=3D ems_pci_tbl,
+	.probe		=3D ems_pci_init_one,
+	.remove		=3D __devexit_p(ems_pci_remove_one),
+};
+
+static int __init rtcan_ems_pci_init(void)
+{
+    return pci_register_driver(&rtcan_ems_pci_driver);
+}
+
+
+static void __exit rtcan_ems_pci_exit(void)
+{
+    pci_unregister_driver(&rtcan_ems_pci_driver);
+}
+
+module_init(rtcan_ems_pci_init);
+module_exit(rtcan_ems_pci_exit);
Index: ksrc/drivers/can/sja1000/Config.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/can/sja1000/Config.in	(revision 2945)
+++ ksrc/drivers/can/sja1000/Config.in	(working copy)
@@ -15,6 +15,7 @@ dep_tristate '  Memory mapped controller
 if [ "$CONFIG_PCI" =3D "y" ]; then
 	dep_tristate '  PEAK PCI cards' CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_PC=
I $CONFIG_XENO_DRIVERS_CAN_SJA1000
 	dep_tristate '  IXXAT PCI cards' CONFIG_XENO_DRIVERS_CAN_SJA1000_IXXAT_=
PCI $CONFIG_XENO_DRIVERS_CAN_SJA1000
+	dep_tristate '  EMS CPC PCI cards' CONFIG_XENO_DRIVERS_CAN_SJA1000_EMS_=
PCI $CONFIG_XENO_DRIVERS_CAN_SJA1000
 fi
=20
 dep_tristate '  PEAK Parallel Port Dongle' CONFIG_XENO_DRIVERS_CAN_SJA10=
00_PEAK_DNG $CONFIG_XENO_DRIVERS_CAN_SJA1000
Index: ksrc/drivers/can/sja1000/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/can/sja1000/Makefile	(revision 2945)
+++ ksrc/drivers/can/sja1000/Makefile	(working copy)
@@ -8,6 +8,7 @@ obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000) +
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_PCI) +=3D xeno_can_peak_pci.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_DNG) +=3D xeno_can_peak_dng.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_IXXAT_PCI) +=3D xeno_can_ixxat_pci=
.o
+obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_EMS_PCI) +=3D xeno_can_ems_pci.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA) +=3D xeno_can_isa.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM) +=3D xeno_can_mem.o
=20
@@ -15,6 +16,7 @@ xeno_can_sja1000-y :=3D rtcan_sja1000.o rt
 xeno_can_peak_pci-y :=3D rtcan_peak_pci.o
 xeno_can_peak_dng-y :=3D rtcan_peak_dng.o
 xeno_can_ixxat_pci-y :=3D rtcan_ixxat_pci.o
+xeno_can_ems_pci-y :=3D rtcan_ems_pci.o
 xeno_can_isa-y :=3D rtcan_isa.o
 xeno_can_mem-y :=3D rtcan_mem.o
=20
@@ -28,6 +30,7 @@ obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000) +
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_PCI) +=3D xeno_can_peak_pci.o=
=20
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_DNG) +=3D xeno_can_peak_dng.o=
=20
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_IXXAT_PCI) +=3D xeno_can_ixxat_pci=
.o
+obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_EMS_PCI) +=3D xeno_can_ems_pci.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA) +=3D xeno_can_isa.o=20
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM) +=3D xeno_can_mem.o
=20
@@ -37,6 +40,7 @@ xeno_can_sja1000-objs :=3D rtcan_sja1000.o
 xeno_can_peak_pci-objs :=3D rtcan_peak_pci.o
 xeno_can_peak_dng-objs :=3D rtcan_peak_dng.o
 xeno_can_ixxat_pci-objs :=3D rtcan_ixxat_pci.o
+xeno_can_ems_pci-objs :=3D rtcan_ems_pci.o
 xeno_can_isa-objs :=3D rtcan_isa.o
 xeno_can_mem-objs :=3D rtcan_mem.o
=20
@@ -58,6 +62,9 @@ xeno_can_peak_dng.o: $(xeno_can_peak_dng
 xeno_can_ixxat_pci.o: $(xeno_can_ixxat_pci-objs)
 	$(LD) -r -o $@ $(xeno_can_ixxat_pci-objs)
=20
+xeno_can_ems_pci.o: $(xeno_can_ems_pci-objs)
+	$(LD) -r -o $@ $(xeno_can_ems_pci-objs)
+
 xeno_can_isa.o: $(xeno_can_isa-objs)
 	$(LD) -r -o $@ $(xeno_can_isa-objs)
=20

--------------050106040707060105010800--

