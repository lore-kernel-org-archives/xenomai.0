From: Sebastian Smolorz <smolorz@domain.hid>
Date: Tue, 8 Sep 2009 16:39:47 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zympKzQ54WFU38r"
Message-Id: <200909081639.47736.smolorz@domain.hid>
Subject: [Xenomai-core] [PATCH] rtcan: Add support for CAN PCI cards from ESD
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

--Boundary-00=_zympKzQ54WFU38r
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch adds support for SJA1000 based PCI CAN interface cards from 
electronic system design gmbh.

The following list of boards are supported:

CAN-PCI/200 (tested)
CAN-PCI/266
CAN-PMC266
CAN-PCIe/2000
CAN-CPCI/200
CAN-PCI104

The patch is based on the Socket-CAN driver for those boards by Matthias 
Fuchs.

Signed-off-by: Sebastian Smolorz <smolorz@domain.hid>
-- 


--Boundary-00=_zympKzQ54WFU38r
Content-Type: text/plain;
  charset="UTF-8";
  name="esd.diffstat"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="esd.diffstat"

 ksrc/drivers/can/sja1000/Kconfig         |   11 +
 ksrc/drivers/can/sja1000/Makefile        |    7 +
 ksrc/drivers/can/sja1000/rtcan_esd_pci.c |  354 ++++++++++++++++++++++++++++++
 3 files changed, 372 insertions(+), 0 deletions(-)

--Boundary-00=_zympKzQ54WFU38r
Content-Type: text/x-patch;
  charset="UTF-8";
  name="esd.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="esd.diff"

diff --git a/ksrc/drivers/can/sja1000/Kconfig b/ksrc/drivers/can/sja1000/Kconfig
index 4d0ed48..53abdd9 100644
--- a/ksrc/drivers/can/sja1000/Kconfig
+++ b/ksrc/drivers/can/sja1000/Kconfig
@@ -52,6 +52,17 @@ config XENO_DRIVERS_CAN_SJA1000_EMS_PCI
 	working, Xenomai's shared interrupt support must be enabled.
 
 
+config XENO_DRIVERS_CAN_SJA1000_ESD_PCI
+	depends on XENO_DRIVERS_CAN_SJA1000
+	tristate "ESD PCI Cards"
+	help
+
+	This driver supports the esd PCI CAN cards CAN-PCI/200,
+	CAN-PCI/266, CAN-PMC/266 (PMC), CAN-CPCI/200 (CompactPCI),
+	CAN-PCIe2000 (PCI Express) and CAN-PCI104/200 (PCI104)
+	from the esd electronic system design gmbh (http://www.esd.eu).
+
+
 config XENO_DRIVERS_CAN_SJA1000_PEAK_DNG
 	depends on XENO_DRIVERS_CAN_SJA1000
 	tristate "PEAK Parallel Port Dongle"
diff --git a/ksrc/drivers/can/sja1000/Makefile b/ksrc/drivers/can/sja1000/Makefile
index 1db102e..09a03ab 100644
--- a/ksrc/drivers/can/sja1000/Makefile
+++ b/ksrc/drivers/can/sja1000/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_PCI) += xeno_can_peak_pci.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_DNG) += xeno_can_peak_dng.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_IXXAT_PCI) += xeno_can_ixxat_pci.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_EMS_PCI) += xeno_can_ems_pci.o
+obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_ESD_PCI) += xeno_can_esd_pci.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA) += xeno_can_isa.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM) += xeno_can_mem.o
 
@@ -17,6 +18,7 @@ xeno_can_peak_pci-y := rtcan_peak_pci.o
 xeno_can_peak_dng-y := rtcan_peak_dng.o
 xeno_can_ixxat_pci-y := rtcan_ixxat_pci.o
 xeno_can_ems_pci-y := rtcan_ems_pci.o
+xeno_can_esd_pci-y := rtcan_esd_pci.o
 xeno_can_isa-y := rtcan_isa.o
 xeno_can_mem-y := rtcan_mem.o
 
@@ -31,6 +33,7 @@ obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_PCI) += xeno_can_peak_pci.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_DNG) += xeno_can_peak_dng.o 
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_IXXAT_PCI) += xeno_can_ixxat_pci.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_EMS_PCI) += xeno_can_ems_pci.o
+obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_ESD_PCI) += xeno_can_esd_pci.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_ISA) += xeno_can_isa.o 
 obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_MEM) += xeno_can_mem.o
 
@@ -41,6 +44,7 @@ xeno_can_peak_pci-objs := rtcan_peak_pci.o
 xeno_can_peak_dng-objs := rtcan_peak_dng.o
 xeno_can_ixxat_pci-objs := rtcan_ixxat_pci.o
 xeno_can_ems_pci-objs := rtcan_ems_pci.o
+xeno_can_esd_pci-objs := rtcan_esd_pci.o
 xeno_can_isa-objs := rtcan_isa.o
 xeno_can_mem-objs := rtcan_mem.o
 
@@ -65,6 +69,9 @@ xeno_can_ixxat_pci.o: $(xeno_can_ixxat_pci-objs)
 xeno_can_ems_pci.o: $(xeno_can_ems_pci-objs)
 	$(LD) -r -o $@ $(xeno_can_ems_pci-objs)
 
+xeno_can_esd_pci.o: $(xeno_can_esd_pci-objs)
+	$(LD) -r -o $@ $(xeno_can_esd_pci-objs)
+
 xeno_can_isa.o: $(xeno_can_isa-objs)
 	$(LD) -r -o $@ $(xeno_can_isa-objs)
 
diff --git a/ksrc/drivers/can/sja1000/rtcan_esd_pci.c b/ksrc/drivers/can/sja1000/rtcan_esd_pci.c
new file mode 100644
index 0000000..79cf8b6
--- /dev/null
+++ b/ksrc/drivers/can/sja1000/rtcan_esd_pci.c
@@ -0,0 +1,354 @@
+/*
+ * Copyright (C) 2009 Sebastian Smolorz <sesmo@domain.hid>
+ *
+ * This driver is based on the Socket-CAN driver esd_pci.c,
+ * Copyright (C) 2007 Wolfgang Grandegger <wg@domain.hid>
+ * Copyright (C) 2008 Sascha Hauer <s.hauer@domain.hid>, Pengutronix
+ * Copyright (C) 2009 Matthias Fuchs <matthias.fuchs@domain.hid>, esd gmbh
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the version 2 of the GNU General Public License
+ * as published by the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
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
+#define RTCAN_DEV_NAME "rtcan%d"
+#define RTCAN_DRV_NAME "ESD-PCI-CAN"
+
+static char *esd_pci_board_name = "ESD-PCI";
+
+MODULE_AUTHOR("Sebastian Smolorz <sesmo@domain.hid");
+MODULE_DESCRIPTION("RTCAN board driver for esd PCI/PMC/CPCI/PCIe/PCI104 " \
+                   "CAN cards");
+MODULE_SUPPORTED_DEVICE("esd CAN-PCI/200, CAN-PCI/266, CAN-PMC266, " \
+			"CAN-PCIe/2000, CAN-CPCI/200, CAN-PCI104");
+MODULE_LICENSE("GPL v2");
+
+struct rtcan_esd_pci {
+	struct pci_dev *pci_dev;
+	struct rtcan_device *slave_dev;
+	void __iomem *conf_addr;
+	void __iomem *base_addr;
+};
+
+#define ESD_PCI_CAN_CLOCK	(16000000 / 2)
+
+#define ESD_PCI_OCR		(SJA_OCR_TX0_PUSHPULL | SJA_OCR_TX1_PUSHPULL | \
+				 SJA_OCR_TX1_INVERT | SJA_OCR_MODE_CLOCK)
+#define ESD_PCI_CDR		(SJA_CDR_CLK_OFF | SJA_CDR_CBP | \
+				 SJA_CDR_CAN_MODE)
+
+#define CHANNEL_SINGLE 0 /* this is a single channel device */
+#define CHANNEL_MASTER 1 /* multi channel device, this device is master */
+#define CHANNEL_SLAVE  2 /* multi channel device, this is slave */
+
+#define CHANNEL_OFFSET		0x100
+
+#define INTCSR_OFFSET		0x4c /* Offset in PLX9050 conf registers */
+#define INTCSR_LINTI1		(1 << 0)
+#define INTCSR_PCI		(1 << 6)
+
+#define INTCSR9056_OFFSET	0x68 /* Offset in PLX9056 conf registers */
+#define INTCSR9056_LINTI	(1 << 11)
+#define INTCSR9056_PCI		(1 << 8)
+
+#ifndef PCI_DEVICE_ID_PLX_9056
+# define PCI_DEVICE_ID_PLX_9056 0x9056
+#endif
+
+/* PCI subsystem IDs of esd's SJA1000 based CAN cards */
+
+/* CAN-PCI/200: PCI, 33MHz only, bridge: PLX9050 */
+#define ESD_PCI_SUB_SYS_ID_PCI200	0x0004
+
+/* CAN-PCI/266: PCI, 33/66MHz, bridge: PLX9056 */
+#define ESD_PCI_SUB_SYS_ID_PCI266	0x0009
+
+/* CAN-PMC/266: PMC module, 33/66MHz, bridge: PLX9056 */
+#define ESD_PCI_SUB_SYS_ID_PMC266	0x000e
+
+/* CAN-CPCI/200: Compact PCI, 33MHz only, bridge: PLX9030 */
+#define ESD_PCI_SUB_SYS_ID_CPCI200	0x010b
+
+/* CAN-PCIE/2000: PCI Express 1x, bridge: PEX8311 = PEX8111 + PLX9056 */
+#define ESD_PCI_SUB_SYS_ID_PCIE2000	0x0200
+
+/* CAN-PCI/104: PCI104 module, 33MHz only, bridge: PLX9030 */
+#define ESD_PCI_SUB_SYS_ID_PCI104200	0x0501
+
+static struct pci_device_id esd_pci_tbl[] = {
+	{PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
+	 PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCI200},
+	{PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9056,
+	 PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCI266},
+	{PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9056,
+	 PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PMC266},
+	{PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
+	 PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_CPCI200},
+	{PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9056,
+	 PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCIE2000},
+	{PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
+	 PCI_VENDOR_ID_ESDGMBH, ESD_PCI_SUB_SYS_ID_PCI104200},
+	{0,}
+};
+
+#define ESD_PCI_BASE_SIZE  0x200
+
+MODULE_DEVICE_TABLE(pci, esd_pci_tbl);
+
+
+static u8 rtcan_esd_pci_read_reg(struct rtcan_device *dev, int port)
+{
+	struct rtcan_esd_pci *board = (struct rtcan_esd_pci *)dev->board_priv;
+	return readb(board->base_addr + port);
+}
+
+static void rtcan_esd_pci_write_reg(struct rtcan_device *dev, int port, u8 val)
+{
+	struct rtcan_esd_pci *board = (struct rtcan_esd_pci *)dev->board_priv;
+	writeb(val, board->base_addr + port);
+}
+
+static void rtcan_esd_pci_del_chan(struct rtcan_device *dev)
+{
+	struct rtcan_esd_pci *board;
+
+	if (!dev)
+		return;
+
+	board = (struct rtcan_esd_pci *)dev->board_priv;
+
+	printk("Removing %s %s device %s\n",
+		esd_pci_board_name, dev->ctrl_name, dev->name);
+
+	rtcan_sja1000_unregister(dev);
+
+	rtcan_dev_free(dev);
+}
+
+static int rtcan_esd_pci_add_chan(struct pci_dev *pdev, int channel,
+				  struct rtcan_device **master_dev,
+				  void __iomem *conf_addr,
+				  void __iomem *base_addr)
+{
+	struct rtcan_device *dev;
+	struct rtcan_sja1000 *chip;
+	struct rtcan_esd_pci *board;
+	int ret;
+
+	dev = rtcan_dev_alloc(sizeof(struct rtcan_sja1000),
+			      sizeof(struct rtcan_esd_pci));
+	if (dev == NULL)
+		return -ENOMEM;
+
+	chip = (struct rtcan_sja1000 *)dev->priv;
+	board = (struct rtcan_esd_pci *)dev->board_priv;
+
+	board->pci_dev = pdev;
+	board->conf_addr = conf_addr;
+	board->base_addr = base_addr;
+
+	if (channel == CHANNEL_SLAVE) {
+		struct rtcan_esd_pci *master_board =
+			(struct rtcan_esd_pci *)(*master_dev)->board_priv;
+		master_board->slave_dev = dev;
+	}
+
+	dev->board_name = esd_pci_board_name;
+
+	chip->read_reg = rtcan_esd_pci_read_reg;
+	chip->write_reg = rtcan_esd_pci_write_reg;
+
+	dev->can_sys_clock = ESD_PCI_CAN_CLOCK;
+
+	chip->ocr = ESD_PCI_OCR;
+	chip->cdr = ESD_PCI_CDR;
+
+	strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+
+	chip->irq_flags = RTDM_IRQTYPE_SHARED;
+	chip->irq_num = pdev->irq;
+
+	RTCAN_DBG("%s: base_addr=0x%p conf_addr=0x%p irq=%d ocr=%#x cdr=%#x\n",
+		  RTCAN_DRV_NAME, board->base_addr, board->conf_addr,
+		  chip->irq_num, chip->ocr, chip->cdr);
+
+	/* Register SJA1000 device */
+	ret = rtcan_sja1000_register(dev);
+	if (ret) {
+		printk(KERN_ERR "ERROR %d while trying to register SJA1000 "
+				"device!\n", ret);
+		goto failure;
+	}
+
+	if (channel != CHANNEL_SLAVE)
+		*master_dev = dev;
+
+	return 0;
+
+
+failure:
+	rtcan_dev_free(dev);
+	return ret;
+}
+
+static int __devinit esd_pci_init_one(struct pci_dev *pdev,
+				      const struct pci_device_id *ent)
+{
+	int ret, channel;
+	void __iomem *base_addr;
+	void __iomem *conf_addr;
+	struct rtcan_device *master_dev = NULL;
+
+	if ((ret = pci_enable_device (pdev)))
+		goto failure;
+
+	if ((ret = pci_request_regions(pdev, RTCAN_DRV_NAME)))
+		goto failure;
+
+	RTCAN_DBG("%s: Initializing device %04x:%04x %04x:%04x\n",
+		 RTCAN_DRV_NAME, pdev->vendor, pdev->device,
+		 pdev->subsystem_vendor, pdev->subsystem_device);
+
+	conf_addr = pci_iomap(pdev, 0, ESD_PCI_BASE_SIZE);
+	if (conf_addr == NULL) {
+		ret = -ENODEV;
+		goto failure_release_pci;
+	}
+
+	base_addr = pci_iomap(pdev, 2, ESD_PCI_BASE_SIZE);
+	if (base_addr == NULL) {
+		ret = -ENODEV;
+		goto failure_iounmap_conf;
+	}
+
+	/* Check if second channel is available */
+	writeb(SJA_MOD_RM, base_addr + CHANNEL_OFFSET + SJA_MOD);
+	writeb(SJA_CDR_CBP, base_addr + CHANNEL_OFFSET + SJA_CDR);
+	writeb(SJA_MOD_RM, base_addr + CHANNEL_OFFSET + SJA_MOD);
+	if (readb(base_addr + CHANNEL_OFFSET + SJA_MOD) == 0x21) {
+		writeb(SJA_MOD_SM | SJA_MOD_AFM | SJA_MOD_STM | SJA_MOD_LOM |
+		       SJA_MOD_RM, base_addr + CHANNEL_OFFSET + SJA_MOD);
+		if (readb(base_addr + CHANNEL_OFFSET + SJA_MOD) == 0x3f)
+			channel = CHANNEL_MASTER;
+		else {
+			writeb(SJA_MOD_RM,
+				base_addr + CHANNEL_OFFSET + SJA_MOD);
+			channel = CHANNEL_SINGLE;
+		}
+	} else {
+		writeb(SJA_MOD_RM, base_addr + CHANNEL_OFFSET + SJA_MOD);
+		channel = CHANNEL_SINGLE;
+	}
+
+	if ((ret = rtcan_esd_pci_add_chan(pdev, channel, &master_dev,
+						conf_addr, base_addr)))
+		goto failure_iounmap_base;
+
+	if (channel != CHANNEL_SINGLE) {
+		channel = CHANNEL_SLAVE;
+		if ((ret = rtcan_esd_pci_add_chan(pdev, channel, &master_dev,
+				      conf_addr, base_addr + CHANNEL_OFFSET)))
+			goto failure_iounmap_base;
+	}
+
+	if ((pdev->device == PCI_DEVICE_ID_PLX_9050) ||
+	    (pdev->device == PCI_DEVICE_ID_PLX_9030)) {
+		/* Enable interrupts in PLX9050 */
+		writel(INTCSR_LINTI1 | INTCSR_PCI, conf_addr + INTCSR_OFFSET);
+	} else {
+		/* Enable interrupts in PLX9056*/
+		writel(INTCSR9056_LINTI | INTCSR9056_PCI,
+					conf_addr + INTCSR9056_OFFSET);
+	}
+
+	pci_set_drvdata(pdev, master_dev);
+
+	return 0;
+
+
+failure_iounmap_base:
+	if (master_dev)
+		rtcan_esd_pci_del_chan(master_dev);
+	pci_iounmap(pdev, base_addr);
+
+failure_iounmap_conf:
+	pci_iounmap(pdev, conf_addr);
+
+failure_release_pci:
+	pci_release_regions(pdev);
+
+failure:
+	return ret;
+}
+
+static void __devexit esd_pci_remove_one(struct pci_dev *pdev)
+{
+	struct rtcan_device *dev = pci_get_drvdata(pdev);
+	struct rtcan_esd_pci *board = (struct rtcan_esd_pci *)dev->board_priv;
+
+	if ((pdev->device == PCI_DEVICE_ID_PLX_9050) ||
+	    (pdev->device == PCI_DEVICE_ID_PLX_9030)) {
+		/* Disable interrupts in PLX9050*/
+		writel(0, board->conf_addr + INTCSR_OFFSET);
+	} else {
+		/* Disable interrupts in PLX9056*/
+		writel(0, board->conf_addr + INTCSR9056_OFFSET);
+	}
+
+	if (board->slave_dev)
+		rtcan_esd_pci_del_chan(board->slave_dev);
+	rtcan_esd_pci_del_chan(dev);
+
+
+	pci_iounmap(pdev, board->base_addr);
+	pci_iounmap(pdev, board->conf_addr);
+
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+}
+
+static struct pci_driver rtcan_esd_pci_driver = {
+	.name = RTCAN_DRV_NAME,
+	.id_table = esd_pci_tbl,
+	.probe = esd_pci_init_one,
+	.remove = __devexit_p(esd_pci_remove_one),
+};
+
+static int __init rtcan_esd_pci_init(void)
+{
+	return pci_register_driver(&rtcan_esd_pci_driver);
+}
+
+static void __exit rtcan_esd_pci_exit(void)
+{
+	pci_unregister_driver(&rtcan_esd_pci_driver);
+}
+
+module_init(rtcan_esd_pci_init);
+module_exit(rtcan_esd_pci_exit);

--Boundary-00=_zympKzQ54WFU38r--

