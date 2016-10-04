From: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <9ab7c23a-84c4-a8cd-0dde-59dccccce13a@grandegger.com>
Date: Tue, 4 Oct 2016 08:25:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] rtcan: ems_pci driver update to support more
	devices
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>
Cc: Markus Plessing <plessing@ems-wuensche.com>, Sebastian Haas <haas@ems-wuensche.com>

The driver follows now more closely the corresponding Linux driver
to simplify updates in the future.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 ksrc/drivers/can/sja1000/rtcan_ems_pci.c      | 487 +++++++++++++++-----------
 ksrc/drivers/can/sja1000/rtcan_sja1000_regs.h |   1 +
 2 files changed, 281 insertions(+), 207 deletions(-)

diff --git a/ksrc/drivers/can/sja1000/rtcan_ems_pci.c b/ksrc/drivers/can/sja1000/rtcan_ems_pci.c
index 4a88ca6..868d236 100644
--- a/ksrc/drivers/can/sja1000/rtcan_ems_pci.c
+++ b/ksrc/drivers/can/sja1000/rtcan_ems_pci.c
@@ -1,28 +1,28 @@
 /*
- * Copyright (C) 2007 Wolfgang Grandegger <wg@grandegger.com>
+ * Copyright (C) 2007, 2016 Wolfgang Grandegger <wg@grandegger.com>
+ * Copyright (C) 2008 Markus Plessing <plessing@ems-wuensche.com>
+ * Copyright (C) 2008 Sebastian Haas <haas@ems-wuensche.com>
  *
- * Register definitions and descriptions are taken from LinCAN 0.3.3.
+ * Derived from Linux CAN SJA1000 PCI driver "ems_pci".
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the version 2 of the GNU General Public License
+ * as published by the Free Software Foundation
  *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software Foundation,
- * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include <rtdm/rtdm_driver.h>
 
@@ -40,23 +40,30 @@
 static char *ems_pci_board_name = "EMS-CPC-PCI";
 
 MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
-MODULE_DESCRIPTION("RTCAN board driver for EMS CPC-PCI cards");
-MODULE_SUPPORTED_DEVICE("EMS CPC-PCI card CAN controller");
-MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RTCAN board driver for EMS CPC-PCI/PCIe/104P CAN cards");
+MODULE_SUPPORTED_DEVICE("EMS CPC-PCI/PCIe/104P CAN card");
+MODULE_LICENSE("GPL v2");
+
+#define EMS_PCI_V1_MAX_CHAN 2
+#define EMS_PCI_V2_MAX_CHAN 4
+#define EMS_PCI_MAX_CHAN    EMS_PCI_V2_MAX_CHAN
+
+struct ems_pci_card {
+	int version;
+	int channels;
 
-struct rtcan_ems_pci
-{
 	struct pci_dev *pci_dev;
-	struct rtcan_device *slave_dev;
-	int channel;
-	volatile void __iomem *base_addr;
-	volatile void __iomem *conf_addr;
+	struct rtcan_device *rtcan_dev[EMS_PCI_MAX_CHAN];
+
+	void __iomem *conf_addr;
+	void __iomem *base_addr;
 };
 
-#define EMS_PCI_MASTER 1 /* multi channel device, this device is master */
-#define EMS_PCI_SLAVE  2 /* multi channel device, this is slave */
+#define EMS_PCI_CAN_CLOCK (16000000 / 2)
 
 /*
+ * Register definitions and descriptions are from LinCAN 0.3.3.
+ *
  * PSB4610 PITA-2 bridge control registers
  */
 #define PITA2_ICR           0x00	/* Interrupt Control Register */
@@ -64,7 +71,17 @@ struct rtcan_ems_pci
 #define PITA2_ICR_INT0_EN   0x00020000	/* [RW] Enable INT0 */
 
 #define PITA2_MISC          0x1c	/* Miscellaneous Register */
-#define PITA2_MISC_CONFIG   0x04000000	/* Multiplexed Parallel_interface_model */
+#define PITA2_MISC_CONFIG   0x04000000	/* Multiplexed parallel interface */
+
+/*
+ * Register definitions for the PLX 9030
+ */
+#define PLX_ICSR            0x4c   /* Interrupt Control/Status register */
+#define PLX_ICSR_LINTI1_ENA 0x0001 /* LINTi1 Enable */
+#define PLX_ICSR_PCIINT_ENA 0x0040 /* PCI Interrupt Enable */
+#define PLX_ICSR_LINTI1_CLR 0x0400 /* Local Edge Triggerable Interrupt Clear */
+#define PLX_ICSR_ENA_CLR    (PLX_ICSR_LINTI1_ENA | PLX_ICSR_PCIINT_ENA | \
+			     PLX_ICSR_LINTI1_CLR)
 
 /*
  * The board configuration is probably following:
@@ -72,9 +89,9 @@ struct rtcan_ems_pci
  * TX1 is not connected.
  * CLKO is not connected.
  * Setting the OCR register to 0xDA is a good idea.
- * This means  normal output mode , push-pull and the correct polarity.
+ * This means normal output mode, push-pull and the correct polarity.
  */
-#define EMS_PCI_OCR_STD     0xda	/* Standard value: Pushpull */
+#define EMS_PCI_OCR         (SJA_OCR_TX0_PUSHPULL | SJA_OCR_TX1_PUSHPULL)
 
 /*
  * In the CDR register, you should set CBP to 1.
@@ -82,248 +99,304 @@ struct rtcan_ems_pci
  * (meaning direct oscillator output) because the second SJA1000 chip
  * is driven by the first one CLKOUT output.
  */
-#define EMS_PCI_CDR_MASTER  (SJA_CDR_CAN_MODE | SJA_CDR_CBP | 0x07)
-#define EMS_PCI_CDR_SLAVE   (SJA_CDR_CAN_MODE | SJA_CDR_CBP | 0x07 |	\
-			     SJA_CDR_CLK_OFF)
-#define EMS_PCI_CONF_SIZE   0x0100  /* Size of the config io-memory */
-#define EMS_PCI_PORT_START  0x0400  /* Start of the channel io-memory */
-#define EMS_PCI_PORT_SIZE   0x0200  /* Size of a channel io-memory */
-
-
-#define EMS_PCI_PORT_BYTES  0x4     /* Each register occupies 4 bytes */
-
-#define EMS_PCI_VENDOR_ID   0x110a  /* PCI device and vendor ID */
-#define EMS_PCI_DEVICE_ID   0x2104
-
-static struct pci_device_id ems_pci_tbl[] = {
-	{EMS_PCI_VENDOR_ID, EMS_PCI_DEVICE_ID,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ }
+#define EMS_PCI_CDR             (SJA_CDR_CBP | SJA_CDR_CLKOUT_MASK)
+
+#define EMS_PCI_V1_BASE_BAR     1
+#define EMS_PCI_V1_CONF_SIZE    4096 /* size of PITA control area */
+#define EMS_PCI_V2_BASE_BAR     2
+#define EMS_PCI_V2_CONF_SIZE    128 /* size of PLX control area */
+#define EMS_PCI_CAN_BASE_OFFSET 0x400 /* offset where the controllers starts */
+#define EMS_PCI_CAN_CTRL_SIZE   0x200 /* memory size for each controller */
+
+#define EMS_PCI_BASE_SIZE  4096 /* size of controller area */
+
+static const struct pci_device_id ems_pci_tbl[] = {
+	/* CPC-PCI v1 */
+	{PCI_VENDOR_ID_SIEMENS, 0x2104, PCI_ANY_ID, PCI_ANY_ID,},
+	/* CPC-PCI v2 */
+	{PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030, PCI_VENDOR_ID_PLX, 0x4000},
+	/* CPC-104P v2 */
+	{PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030, PCI_VENDOR_ID_PLX, 0x4002},
+	{0,}
 };
-MODULE_DEVICE_TABLE (pci, ems_pci_tbl);
+MODULE_DEVICE_TABLE(pci, ems_pci_tbl);
 
-#define EMS_PCI_CAN_SYS_CLOCK (16000000 / 2)
+/*
+ * Helper to read internal registers from card logic (not CAN)
+ */
+static u8 ems_pci_v1_readb(struct ems_pci_card *card, unsigned int port)
+{
+	return readb((void __iomem *)card->base_addr + (port * 4));
+}
 
-static u8 rtcan_ems_pci_read_reg(struct rtcan_device *dev, int port)
+static u8 ems_pci_v1_read_reg(struct rtcan_device *dev, int port)
 {
-	struct rtcan_ems_pci *board = (struct rtcan_ems_pci *)dev->board_priv;
-	return readb(board->base_addr + (port * EMS_PCI_PORT_BYTES));
+	return readb((void __iomem *)dev->base_addr + (port * 4));
 }
 
-static void rtcan_ems_pci_write_reg(struct rtcan_device *dev, int port, u8 data)
+static void ems_pci_v1_write_reg(struct rtcan_device *dev,
+				 int port, u8 val)
 {
-	struct rtcan_ems_pci *board = (struct rtcan_ems_pci *)dev->board_priv;
-	writeb(data, board->base_addr + (port * EMS_PCI_PORT_BYTES));
+	writeb(val, (void __iomem *)dev->base_addr + (port * 4));
 }
 
-static void rtcan_ems_pci_irq_ack(struct rtcan_device *dev)
+static void ems_pci_v1_post_irq(struct rtcan_device *dev)
 {
-	struct rtcan_ems_pci *board = (struct rtcan_ems_pci *)dev->board_priv;
+	struct ems_pci_card *card = (struct ems_pci_card *)dev->board_priv;
 
+	/* reset int flag of pita */
 	writel(PITA2_ICR_INT0_EN | PITA2_ICR_INT0,
-	       board->conf_addr + PITA2_ICR);
+	       card->conf_addr + PITA2_ICR);
 }
 
-static void rtcan_ems_pci_del_chan(struct rtcan_device *dev,
-				   int init_step)
+static u8 ems_pci_v2_read_reg(struct rtcan_device *dev, int port)
 {
-	struct rtcan_ems_pci *board;
+	return readb((void __iomem *)dev->base_addr + port);
+}
 
-	if (!dev)
-		return;
+static void ems_pci_v2_write_reg(struct rtcan_device *dev,
+				 int port, u8 val)
+{
+	writeb(val, (void __iomem *)dev->base_addr + port);
+}
 
-	board = (struct rtcan_ems_pci *)dev->board_priv;
+static void ems_pci_v2_post_irq(struct rtcan_device *dev)
+{
+	struct ems_pci_card *card = (struct ems_pci_card *)dev->board_priv;
 
-	switch (init_step) {
-	case 0:			/* Full cleanup */
-		RTCAN_DBG("Removing %s %s device %s\n",
-			  ems_pci_board_name, dev->ctrl_name, dev->name);
-		rtcan_sja1000_unregister(dev);
-	case 5:
-	case 4:
-		iounmap((void *)board->base_addr);
-	case 3:
-		if (board->channel != EMS_PCI_SLAVE)
-			iounmap((void *)board->conf_addr);
-	case 2:
-		rtcan_dev_free(dev);
-	case 1:
-		break;
-	}
+	writel(PLX_ICSR_ENA_CLR, card->conf_addr + PLX_ICSR);
 }
 
-static int rtcan_ems_pci_add_chan(struct pci_dev *pdev, int channel,
-				  struct rtcan_device **master_dev)
+/*
+ * Check if a CAN controller is present at the specified location
+ * by trying to set 'em into the PeliCAN mode
+ */
+static inline int ems_pci_check_chan(struct rtcan_device *dev)
 {
-	struct rtcan_device *dev;
-	struct rtcan_sja1000 *chip;
-	struct rtcan_ems_pci *board;
-	unsigned long addr;
-	int err, init_step = 1;
+	struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
+	unsigned char res;
 
-	dev = rtcan_dev_alloc(sizeof(struct rtcan_sja1000),
-			      sizeof(struct rtcan_ems_pci));
-	if (dev == NULL)
-		return -ENOMEM;
-	init_step = 2;
+	/* Make sure SJA1000 is in reset mode */
+	chip->write_reg(dev, SJA_MOD, 1);
 
-	chip = (struct rtcan_sja1000 *)dev->priv;
-	board = (struct rtcan_ems_pci *)dev->board_priv;
+	chip->write_reg(dev, SJA_CDR, SJA_CDR_CAN_MODE);
 
-	board->pci_dev = pdev;
-	board->channel = channel;
+	/* read reset-values */
+	res = chip->read_reg(dev, SJA_CDR);
 
-	if (channel != EMS_PCI_SLAVE) {
+	if (res == SJA_CDR_CAN_MODE)
+		return 1;
 
-		addr = pci_resource_start(pdev, 0);
-		board->conf_addr = ioremap(addr, EMS_PCI_CONF_SIZE);
-		if (board->conf_addr == 0) {
-			err = -ENODEV;
-			goto failure;
-		}
-		init_step = 3;
+	return 0;
+}
 
-		/* Configure PITA-2 parallel interface */
-		writel(PITA2_MISC_CONFIG, board->conf_addr + PITA2_MISC);
-		/* Enable interrupts from card */
-		writel(PITA2_ICR_INT0_EN, board->conf_addr + PITA2_ICR);
-	} else {
-		struct rtcan_ems_pci *master_board =
-			(struct rtcan_ems_pci *)(*master_dev)->board_priv;
-		master_board->slave_dev = dev;
-		board->conf_addr = master_board->conf_addr;
-	}
+static void ems_pci_del_card(struct pci_dev *pdev)
+{
+	struct ems_pci_card *card = pci_get_drvdata(pdev);
+	struct rtcan_device *dev;
+	int i = 0;
 
-	addr = pci_resource_start(pdev, 1) + EMS_PCI_PORT_START;
-	if (channel == EMS_PCI_SLAVE)
-		addr += EMS_PCI_PORT_SIZE;
+	for (i = 0; i < card->channels; i++) {
+		dev = card->rtcan_dev[i];
 
-	board->base_addr = ioremap(addr, EMS_PCI_PORT_SIZE);
-	if (board->base_addr == 0) {
-		err = -ENODEV;
-		goto failure;
+		if (!dev)
+			continue;
+
+		dev_info(&pdev->dev, "Removing %s.\n", dev->name);
+		rtcan_sja1000_unregister(dev);
+		rtcan_dev_free(dev);
 	}
-	init_step = 4;
 
-	dev->board_name = ems_pci_board_name;
+	if (card->base_addr != NULL)
+		pci_iounmap(card->pci_dev, card->base_addr);
 
-	chip->read_reg = rtcan_ems_pci_read_reg;
-	chip->write_reg = rtcan_ems_pci_write_reg;
-	chip->irq_ack = rtcan_ems_pci_irq_ack;
+	if (card->conf_addr != NULL)
+		pci_iounmap(card->pci_dev, card->conf_addr);
 
-	/* Clock frequency in Hz */
-	dev->can_sys_clock = EMS_PCI_CAN_SYS_CLOCK;
+	kfree(card);
 
-	/* Output control register */
-	chip->ocr = EMS_PCI_OCR_STD;
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+}
 
-	/* Clock divider register */
-	if (channel == EMS_PCI_MASTER)
-		chip->cdr = EMS_PCI_CDR_MASTER;
-	else
-		chip->cdr = EMS_PCI_CDR_SLAVE;
+static void ems_pci_card_reset(struct ems_pci_card *card)
+{
+	/* Request board reset */
+	writeb(0, card->base_addr);
+}
 
-	strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+/*
+ * Probe PCI device for EMS CAN signature and register each available
+ * CAN channel to RTCAN subsystem.
+ */
+static int ems_pci_add_card(struct pci_dev *pdev,
+			    const struct pci_device_id *ent)
+{
+	struct rtcan_sja1000 *chip;
+	struct rtcan_device *dev;
+	struct ems_pci_card *card;
+	int max_chan, conf_size, base_bar;
+	int err, i;
+
+	/* Enabling PCI device */
+	if (pci_enable_device(pdev) < 0) {
+		dev_err(&pdev->dev, "Enabling PCI device failed\n");
+		return -ENODEV;
+	}
 
-	/* Register and setup interrupt handling */
-	chip->irq_flags = RTDM_IRQTYPE_SHARED;
-	chip->irq_num = pdev->irq;
-	init_step = 5;
+	/* Allocating card structures to hold addresses, ... */
+	card = kzalloc(sizeof(*card), GFP_KERNEL);
+	if (card == NULL) {
+		pci_disable_device(pdev);
+		return -ENOMEM;
+	}
 
-	printk("%s: base_addr=%p conf_addr=%p irq=%d\n", RTCAN_DRV_NAME,
-	       board->base_addr, board->conf_addr, chip->irq_num);
+	pci_set_drvdata(pdev, card);
 
-	/* Register SJA1000 device */
-	err = rtcan_sja1000_register(dev);
-	if (err) {
-		printk(KERN_ERR
-		       "ERROR %d while trying to register SJA1000 device!\n",
-		       err);
-		goto failure;
-	}
+	card->pci_dev = pdev;
 
-	if (channel != EMS_PCI_SLAVE)
-		*master_dev = dev;
+	card->channels = 0;
 
-	return 0;
+	if (pdev->vendor == PCI_VENDOR_ID_PLX) {
+		card->version = 2; /* CPC-PCI v2 */
+		max_chan = EMS_PCI_V2_MAX_CHAN;
+		base_bar = EMS_PCI_V2_BASE_BAR;
+		conf_size = EMS_PCI_V2_CONF_SIZE;
+	} else {
+		card->version = 1; /* CPC-PCI v1 */
+		max_chan = EMS_PCI_V1_MAX_CHAN;
+		base_bar = EMS_PCI_V1_BASE_BAR;
+		conf_size = EMS_PCI_V1_CONF_SIZE;
+	}
 
-failure:
-	rtcan_ems_pci_del_chan(dev, init_step);
-	return err;
-}
+	/* Remap configuration space and controller memory area */
+	card->conf_addr = pci_iomap(pdev, 0, conf_size);
+	if (card->conf_addr == NULL) {
+		err = -ENOMEM;
+		goto failure_cleanup;
+	}
 
-static int ems_pci_init_one(struct pci_dev *pdev,
-			    const struct pci_device_id *ent)
-{
-	struct rtcan_device *master_dev = NULL;
-	int err;
+	card->base_addr = pci_iomap(pdev, base_bar, EMS_PCI_BASE_SIZE);
+	if (card->base_addr == NULL) {
+		err = -ENOMEM;
+		goto failure_cleanup;
+	}
 
-	RTCAN_DBG("%s: initializing device %04x:%04x\n",
-		  RTCAN_DRV_NAME,  pdev->vendor, pdev->device);
+	if (card->version == 1) {
+		/* Configure PITA-2 parallel interface (enable MUX) */
+		writel(PITA2_MISC_CONFIG, card->conf_addr + PITA2_MISC);
+
+		/* Check for unique EMS CAN signature */
+		if (ems_pci_v1_readb(card, 0) != 0x55 ||
+		    ems_pci_v1_readb(card, 1) != 0xAA ||
+		    ems_pci_v1_readb(card, 2) != 0x01 ||
+		    ems_pci_v1_readb(card, 3) != 0xCB ||
+		    ems_pci_v1_readb(card, 4) != 0x11) {
+			dev_err(&pdev->dev,
+				"Not EMS Dr. Thomas Wuensche interface\n");
+			err = -ENODEV;
+			goto failure_cleanup;
+		}
+	}
 
-	if ((err = pci_enable_device (pdev)))
-		goto failure;
+	ems_pci_card_reset(card);
 
-	if ((err = pci_request_regions(pdev, RTCAN_DRV_NAME)))
-		goto failure;
+	for (i = 0; i < max_chan; i++) {
+		dev = rtcan_dev_alloc(sizeof(struct rtcan_sja1000), 0);
+		if (!dev) {
+			err = -ENOMEM;
+			goto failure_cleanup;
+		}
 
-	if ((err = pci_write_config_word(pdev, 0x04, 2)))
-		goto failure_cleanup;
+		strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+		dev->board_name = ems_pci_board_name;
+		dev->board_priv = card;
+
+		card->rtcan_dev[i] = dev;
+		chip = card->rtcan_dev[i]->priv;
+		chip->irq_flags = RTDM_IRQTYPE_SHARED;
+		chip->irq_num = pdev->irq;
+
+		dev->base_addr = (unsigned long)card->base_addr +
+			EMS_PCI_CAN_BASE_OFFSET + (i * EMS_PCI_CAN_CTRL_SIZE);
+		if (card->version == 1) {
+			chip->read_reg  = ems_pci_v1_read_reg;
+			chip->write_reg = ems_pci_v1_write_reg;
+			chip->irq_ack = ems_pci_v1_post_irq;
+		} else {
+			chip->read_reg  = ems_pci_v2_read_reg;
+			chip->write_reg = ems_pci_v2_write_reg;
+			chip->irq_ack = ems_pci_v2_post_irq;
+		}
 
-	if ((err = rtcan_ems_pci_add_chan(pdev, EMS_PCI_MASTER,
-					  &master_dev)))
-		goto failure_cleanup;
-	if ((err = rtcan_ems_pci_add_chan(pdev, EMS_PCI_SLAVE,
-					  &master_dev)))
+		/* Check if channel is present */
+		if (ems_pci_check_chan(dev)) {
+			dev->can_sys_clock = EMS_PCI_CAN_CLOCK;
+			chip->ocr = EMS_PCI_OCR | SJA_OCR_MODE_NORMAL;
+			chip->cdr = EMS_PCI_CDR | SJA_CDR_CAN_MODE;
+
+			if (card->version == 1)
+				/* reset int flag of pita */
+				writel(PITA2_ICR_INT0_EN | PITA2_ICR_INT0,
+				       card->conf_addr + PITA2_ICR);
+			else
+				/* enable IRQ in PLX 9030 */
+				writel(PLX_ICSR_ENA_CLR,
+				       card->conf_addr + PLX_ICSR);
+
+			/* Register SJA1000 device */
+			err = rtcan_sja1000_register(dev);
+			if (err) {
+				dev_err(&pdev->dev, "Registering device failed "
+					"(err=%d)\n", err);
+				rtcan_dev_free(dev);
+				goto failure_cleanup;
+			}
+
+			card->channels++;
+
+			dev_info(&pdev->dev, "Channel #%d at 0x%p, irq %d "
+				 "registered as %s\n", i + 1,
+				 (void* __iomem)dev->base_addr, chip->irq_num,
+				 dev->name);
+		} else {
+			dev_err(&pdev->dev, "Channel #%d not detected\n",
+				i + 1);
+			rtcan_dev_free(dev);
+		}
+	}
+
+	if (!card->channels) {
+		err = -ENODEV;
 		goto failure_cleanup;
+	}
 
-	pci_set_drvdata(pdev, master_dev);
 	return 0;
 
 failure_cleanup:
-	if (master_dev)
-		rtcan_ems_pci_del_chan(master_dev, 0);
+	dev_err(&pdev->dev, "Error: %d. Cleaning Up.\n", err);
 
-	pci_release_regions(pdev);
+	ems_pci_del_card(pdev);
 
-failure:
 	return err;
-
-}
-
-static void ems_pci_remove_one(struct pci_dev *pdev)
-{
-	struct rtcan_device *dev = pci_get_drvdata(pdev);
-	struct rtcan_ems_pci *board = (struct rtcan_ems_pci *)dev->board_priv;
-
-	/* Disable interrupts from card */
-	writel(0x0, board->conf_addr + PITA2_ICR);
-
-	if (board->slave_dev)
-		rtcan_ems_pci_del_chan(board->slave_dev, 0);
-	rtcan_ems_pci_del_chan(dev, 0);
-
-	pci_release_regions(pdev);
-	pci_disable_device(pdev);
-	pci_set_drvdata(pdev, NULL);
 }
 
-static struct pci_driver rtcan_ems_pci_driver = {
-	.name		= RTCAN_DRV_NAME,
-	.id_table	= ems_pci_tbl,
-	.probe		= ems_pci_init_one,
-	.remove		= ems_pci_remove_one,
+static struct pci_driver ems_pci_driver = {
+	.name = RTCAN_DRV_NAME,
+	.id_table = ems_pci_tbl,
+	.probe = ems_pci_add_card,
+	.remove = ems_pci_del_card,
 };
 
-static int __init rtcan_ems_pci_init(void)
+static int __init ems_pci_init(void)
 {
-	return pci_register_driver(&rtcan_ems_pci_driver);
+	return pci_register_driver(&ems_pci_driver);
 }
 
-static void __exit rtcan_ems_pci_exit(void)
+static void __exit ems_pci_exit(void)
 {
-	pci_unregister_driver(&rtcan_ems_pci_driver);
+	pci_unregister_driver(&ems_pci_driver);
 }
 
-module_init(rtcan_ems_pci_init);
-module_exit(rtcan_ems_pci_exit);
+module_init(ems_pci_init);
+module_exit(ems_pci_exit);
diff --git a/ksrc/drivers/can/sja1000/rtcan_sja1000_regs.h b/ksrc/drivers/can/sja1000/rtcan_sja1000_regs.h
index f02d23b..9f2f871 100644
--- a/ksrc/drivers/can/sja1000/rtcan_sja1000_regs.h
+++ b/ksrc/drivers/can/sja1000/rtcan_sja1000_regs.h
@@ -197,6 +197,7 @@ enum SJA1000_PELI_FIR {
 
 /* Clock divider register */
 enum SJA1000_PELI_CDR {
+    SJA_CDR_CLKOUT_MASK  = 0x07,
     SJA_CDR_CLK_OFF      = 1<<3, /* Clock off (CLKOUT pin)              */
     SJA_CDR_CBP          = 1<<6, /* CAN input comparator bypass         */
     SJA_CDR_CAN_MODE     = 1<<7  /* CAN mode: 1 = PeliCAN               */
-- 
1.9.1



