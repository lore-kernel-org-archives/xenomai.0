From: Konrad Banachowicz <konradb3@gmail.com>
Date: Mon, 16 Dec 2013 17:08:39 +0100
Message-Id: <1387210119-18909-2-git-send-email-konradb3@gmail.com>
In-Reply-To: <1387210119-18909-1-git-send-email-konradb3@gmail.com>
References: <1387210119-18909-1-git-send-email-konradb3@gmail.com>
Subject: [Xenomai] [PATCH 2/2] rtcan/peek_pci: Driver rework based on
	cerresponding linux driver.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

* Added support for 3 and 4 port cards as done in corresponding linux driver.

---
 ksrc/drivers/can/sja1000/rtcan_peak_pci.c |  395 +++++++++++++----------------
 1 file changed, 170 insertions(+), 225 deletions(-)

diff --git a/ksrc/drivers/can/sja1000/rtcan_peak_pci.c b/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
index 7e3507d..6848f6c 100644
--- a/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
+++ b/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
@@ -39,37 +39,33 @@
 #define RTCAN_DEV_NAME    "rtcan%d"
 #define RTCAN_DRV_NAME    "PEAK-PCI-CAN"
 
-static char *peak_pci_board_name = "PEAK-PCI";
-
 MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
 MODULE_DESCRIPTION("RTCAN board driver for PEAK-PCI cards");
 MODULE_SUPPORTED_DEVICE("PEAK-PCI card CAN controller");
 MODULE_LICENSE("GPL");
 
-struct rtcan_peak_pci {
-	struct pci_dev *pci_dev;
-	struct rtcan_device *slave_dev;
-	int channel;
-	volatile void __iomem *base_addr;
-	volatile void __iomem *conf_addr;
+struct peak_pci_chan {
+	void __iomem *cfg_base;		/* Common for all channels */
+	void __iomem *reg_base;
+	struct rtcan_device *prev_dev;	/* Chain of network devices */
+	u16 icr_mask;			/* Interrupt mask for fast ack */
 };
 
-#define PEAK_PCI_CAN_SYS_CLOCK (16000000 / 2)
+#define PEAK_PCI_CAN_CLOCK	(16000000 / 2)
+
+#define PEAK_PCI_CDR		(SJA_CDR_CAN_MODE | SJA_CDR_CBP | 0x07)
+#define PEAK_PCI_OCR		(SJA_OCR_MODE_NORMAL | SJA_OCR_TX0_PUSHPULL)
 
-#define PELICAN_SINGLE (SJA_CDR_CAN_MODE | SJA_CDR_CBP | 0x07 | SJA_CDR_CLK_OFF)
-#define PELICAN_MASTER  (SJA_CDR_CAN_MODE | SJA_CDR_CBP | 0x07)
-#define PELICAN_DEFAULT (SJA_CDR_CAN_MODE)
+/*
+ * Important PITA registers
+ */
+#define PITA_ICR		0x00	/* Interrupt control register */
+#define PITA_GPIOICR		0x18	/* GPIO interface control register */
+#define PITA_MISC		0x1C	/* Miscellaneous register */
 
-#define CHANNEL_SINGLE 0	/* this is a single channel device */
-#define CHANNEL_MASTER 1	/* multi channel device, this device is master
-*/
-#define CHANNEL_SLAVE  2	/* multi channel device, this is slave */
+#define PEAK_PCI_CFG_SIZE	0x1000	/* Size of the config PCI bar */
+#define PEAK_PCI_CHAN_SIZE	0x0400	/* Size used by the channel */
 
-/* important PITA registers */
-#define PITA_ICR         0x00	/* interrupt control register */
-#define PITA_GPIOICR     0x18	/* general purpose IO interface control register
-*/
-#define PITA_MISC        0x1C	/* miscellanoes register */
 
 #define PEAK_PCI_VENDOR_ID      0x001C	/* the PCI device and vendor IDs */
 #define PEAK_PCI_DEVICE_ID      0x0001	/* Device ID for PCI and older PCIe
@@ -82,10 +78,13 @@ cards */
 #define PEAK_PCI_104E_DEVICE_ID 0x0007	/* PCAN-PCI/104 Express cards */
 #define PEAK_MPCIE_DEVICE_ID    0x0008	/* The miniPCIe slot cards */
 
-#define PCI_CONFIG_PORT_SIZE 0x1000	/* size of the config io-memory */
-#define PCI_PORT_SIZE        0x0400	/* size of a channel io-memory */
+#define PEAK_PCI_CHAN_MAX	4
+
+static const u16 peak_pci_icr_masks[PEAK_PCI_CHAN_MAX] = {
+	0x02, 0x01, 0x40, 0x80
+};
 
-static struct pci_device_id peak_pci_tbl[] = {
+static DEFINE_PCI_DEVICE_TABLE(peak_pci_tbl) = {
 	{PEAK_PCI_VENDOR_ID, PEAK_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{PEAK_PCI_VENDOR_ID, PEAK_PCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{PEAK_PCI_VENDOR_ID, PEAK_MPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
@@ -100,254 +99,200 @@ MODULE_DEVICE_TABLE(pci, peak_pci_tbl);
 
 static u8 rtcan_peak_pci_read_reg(struct rtcan_device *dev, int port)
 {
-	struct rtcan_peak_pci *board = (struct rtcan_peak_pci *)dev->board_priv;
-	return readb(board->base_addr + ((unsigned long)port << 2));
+	struct peak_pci_chan *chan = (struct peak_pci_chan *)dev->board_priv;
+	return readb(chan->reg_base + (port << 2));
 }
 
 static void rtcan_peak_pci_write_reg(struct rtcan_device *dev, int port,
 				     u8 data)
 {
-	struct rtcan_peak_pci *board = (struct rtcan_peak_pci *)dev->board_priv;
-	writeb(data, board->base_addr + ((unsigned long)port << 2));
+	struct peak_pci_chan *chan = (struct peak_pci_chan *)dev->board_priv;
+	writeb(data, chan->reg_base + (port << 2));
 }
 
 static void rtcan_peak_pci_irq_ack(struct rtcan_device *dev)
 {
-	struct rtcan_peak_pci *board = (struct rtcan_peak_pci *)dev->board_priv;
-	u16 pita_icr_low;
-
-	/* Select and clear in Pita stored interrupt */
-	pita_icr_low = readw(board->conf_addr + PITA_ICR);
-	if (board->channel == CHANNEL_SLAVE) {
-		if (pita_icr_low & 0x0001)
-			writew(0x0001, board->conf_addr + PITA_ICR);
-	} else {
-		if (pita_icr_low & 0x0002)
-			writew(0x0002, board->conf_addr + PITA_ICR);
-	}
+	struct peak_pci_chan *chan = (struct peak_pci_chan *)dev->board_priv;
+	u16 icr;
+
+	/* Select and clear in PITA stored interrupt */
+	icr = readw(chan->cfg_base + PITA_ICR);
+	if (icr & chan->icr_mask)
+		writew(chan->icr_mask, chan->cfg_base + PITA_ICR);
 }
 
-static void rtcan_peak_pci_del_chan(struct rtcan_device *dev, int init_step)
+static int peak_pci_init_one(struct pci_dev *pdev,
+			     const struct pci_device_id *ent)
 {
-	struct rtcan_peak_pci *board;
-	u16 pita_icr_high;
-
-	if (!dev)
-		return;
-
-	board = (struct rtcan_peak_pci *)dev->board_priv;
+	struct rtcan_sja1000 *priv;
+	struct peak_pci_chan *chan;
+	struct rtcan_device *dev;
+	void __iomem *cfg_base, *reg_base;
+	u16 sub_sys_id, icr;
+	int i, err, channels;
+
+	err = pci_enable_device(pdev);
+	if (err)
+		return err;
+
+	err = pci_request_regions(pdev, RTCAN_DRV_NAME);
+	if (err)
+		goto failure_disable_pci;
+
+	err = pci_read_config_word(pdev, 0x2e, &sub_sys_id);
+	if (err)
+		goto failure_release_regions;
+
+	dev_dbg(&pdev->dev, "probing device %04x:%04x:%04x\n",
+		pdev->vendor, pdev->device, sub_sys_id);
+
+	err = pci_write_config_word(pdev, 0x44, 0);
+	if (err)
+		goto failure_release_regions;
+
+	if (sub_sys_id >= 12)
+		channels = 4;
+	else if (sub_sys_id >= 10)
+		channels = 3;
+	else if (sub_sys_id >= 4)
+		channels = 2;
+	else
+		channels = 1;
 
-	switch (init_step) {
-	case 0:		/* Full cleanup */
-		printk("Removing %s %s device %s\n",
-		       peak_pci_board_name, dev->ctrl_name, dev->name);
-		rtcan_sja1000_unregister(dev);
-	case 5:
-		pita_icr_high = readw(board->conf_addr + PITA_ICR + 2);
-		if (board->channel == CHANNEL_SLAVE)
-			pita_icr_high &= ~0x0001;
-		else
-			pita_icr_high &= ~0x0002;
-
-		writew(pita_icr_high, board->conf_addr + PITA_ICR + 2);
-	case 4:
-		iounmap((void *)board->base_addr);
-	case 3:
-		if (board->channel != CHANNEL_SLAVE)
-			iounmap((void *)board->conf_addr);
-	case 2:
-		rtcan_dev_free(dev);
-	case 1:
-		break;
+	cfg_base = pci_iomap(pdev, 0, PEAK_PCI_CFG_SIZE);
+	if (!cfg_base) {
+		dev_err(&pdev->dev, "failed to map PCI resource #0\n");
+		goto failure_release_regions;
 	}
 
-}
+	reg_base = pci_iomap(pdev, 1, PEAK_PCI_CHAN_SIZE * channels);
+	if (!reg_base) {
+		dev_err(&pdev->dev, "failed to map PCI resource #1\n");
+		goto failure_unmap_cfg_base;
+	}
 
-static int rtcan_peak_pci_add_chan(struct pci_dev *pdev, int channel,
-				   struct rtcan_device **master_dev)
-{
-	struct rtcan_device *dev;
-	struct rtcan_sja1000 *chip;
-	struct rtcan_peak_pci *board;
-	u16 pita_icr_high;
-	unsigned long addr;
-	int ret, init_step = 1;
-
-	dev = rtcan_dev_alloc(sizeof(struct rtcan_sja1000),
-			      sizeof(struct rtcan_peak_pci));
-	if (dev == NULL)
-		return -ENOMEM;
-	init_step = 2;
-
-	chip = (struct rtcan_sja1000 *)dev->priv;
-	board = (struct rtcan_peak_pci *)dev->board_priv;
-
-	board->pci_dev = pdev;
-	board->channel = channel;
-
-	if (channel != CHANNEL_SLAVE) {
-
-		addr = pci_resource_start(pdev, 0);
-		board->conf_addr = ioremap(addr, PCI_CONFIG_PORT_SIZE);
-		if (board->conf_addr == 0) {
-			ret = -ENODEV;
-			goto failure;
+	/* Set GPIO control register */
+	writew(0x0005, cfg_base + PITA_GPIOICR + 2);
+	/* Enable all channels of this card */
+	writeb(0x00, cfg_base + PITA_GPIOICR);
+	/* Toggle reset */
+	writeb(0x05, cfg_base + PITA_MISC + 3);
+	mdelay(5);
+	/* Leave parport mux mode */
+	writeb(0x04, cfg_base + PITA_MISC + 3);
+
+	icr = readw(cfg_base + PITA_ICR + 2);
+
+	for (i = 0; i < channels; i++) {
+		//dev = alloc_sja1000dev(sizeof(struct peak_pci_chan));
+		dev = rtcan_dev_alloc(sizeof(struct rtcan_sja1000),
+			      sizeof(struct peak_pci_chan));
+		if (!dev) {
+			err = -ENOMEM;
+			goto failure_remove_channels;
 		}
-		init_step = 3;
-
-		/* Set GPIO control register */
-		writew(0x0005, board->conf_addr + PITA_GPIOICR + 2);
-
-		if (channel == CHANNEL_MASTER)
-			writeb(0x00, board->conf_addr + PITA_GPIOICR);	/* enable both */
-		else
-			writeb(0x04, board->conf_addr + PITA_GPIOICR);	/* enable single */
-
-		/* toggle reset */
-		writeb(0x05, board->conf_addr + PITA_MISC + 3);
-		mdelay(5);
-		/* leave parport mux mode */
-		writeb(0x04, board->conf_addr + PITA_MISC + 3);
-	} else {
-		struct rtcan_peak_pci *master_board =
-		    (struct rtcan_peak_pci *)(*master_dev)->board_priv;
-		master_board->slave_dev = dev;
-		board->conf_addr = master_board->conf_addr;
-	}
 
-	addr = pci_resource_start(pdev, 1);
-	if (channel == CHANNEL_SLAVE)
-		addr += 0x400;
+		priv = (struct rtcan_sja1000 *)dev->priv;
+		chan = (struct peak_pci_chan *)dev->board_priv;
 
-	board->base_addr = ioremap(addr, PCI_PORT_SIZE);
-	if (board->base_addr == 0) {
-		ret = -ENODEV;
-		goto failure;
-	}
-	init_step = 4;
+		chan->cfg_base = cfg_base;
+		chan->reg_base = reg_base + i * PEAK_PCI_CHAN_SIZE;
 
-	dev->board_name = peak_pci_board_name;
+		priv->read_reg = rtcan_peak_pci_read_reg;
+		priv->write_reg = rtcan_peak_pci_write_reg;
+		priv->irq_ack = rtcan_peak_pci_irq_ack;
 
-	chip->read_reg = rtcan_peak_pci_read_reg;
-	chip->write_reg = rtcan_peak_pci_write_reg;
-	chip->irq_ack = rtcan_peak_pci_irq_ack;
+		/* Clock frequency in Hz */
+		dev->can_sys_clock = PEAK_PCI_CAN_CLOCK;
+		priv->ocr = PEAK_PCI_OCR;
+		priv->cdr = PEAK_PCI_CDR;
+		/* Neither a slave nor a single device distributes the clock */
+		if (channels == 1 || i > 0)
+			priv->cdr |= SJA_CDR_CLK_OFF;
 
-	/* Clock frequency in Hz */
-	dev->can_sys_clock = PEAK_PCI_CAN_SYS_CLOCK;
+		strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
 
-	/* Output control register */
-	chip->ocr = SJA_OCR_MODE_NORMAL | SJA_OCR_TX0_PUSHPULL;
+		/* Setup interrupt handling */
+		priv->irq_flags = RTDM_IRQTYPE_SHARED;
+		priv->irq_num = pdev->irq;
 
-	/* Clock divider register */
-	if (channel == CHANNEL_MASTER)
-		chip->cdr = PELICAN_MASTER;
-	else
-		chip->cdr = PELICAN_SINGLE;
+		chan->icr_mask = peak_pci_icr_masks[i];
+		icr |= chan->icr_mask;
 
-	strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+		//SET_NETDEV_DEV(dev, &pdev->dev);
 
-	/* Register and setup interrupt handling */
-	chip->irq_flags = RTDM_IRQTYPE_SHARED;
-	chip->irq_num = pdev->irq;
-	pita_icr_high = readw(board->conf_addr + PITA_ICR + 2);
-	if (channel == CHANNEL_SLAVE)
-		pita_icr_high |= 0x0001;
-	else
-		pita_icr_high |= 0x0002;
-	writew(pita_icr_high, board->conf_addr + PITA_ICR + 2);
-	init_step = 5;
-
-	printk("%s: base_addr=%p conf_addr=%p irq=%d\n", RTCAN_DRV_NAME,
-	       board->base_addr, board->conf_addr, chip->irq_num);
-
-	/* Register SJA1000 device */
-	ret = rtcan_sja1000_register(dev);
-	if (ret) {
-		printk(KERN_ERR
-		       "ERROR %d while trying to register SJA1000 device!\n",
-		       ret);
-		goto failure;
+		/* Create chain of SJA1000 devices */
+		chan->prev_dev = pci_get_drvdata(pdev);
+		pci_set_drvdata(pdev, dev);
+
+		err = rtcan_sja1000_register(dev);
+		if (err) {
+			dev_err(&pdev->dev, "failed to register device\n");
+			goto failure_free_dev;
+		}
+
+		dev_info(&pdev->dev,
+			 "%s at reg_base=0x%p cfg_base=0x%p irq=%d\n",
+			 dev->name, chan->reg_base, chan->cfg_base, priv->irq_num);
 	}
 
-	if (channel != CHANNEL_SLAVE)
-		*master_dev = dev;
+	/* Enable interrupts */
+	writew(icr, cfg_base + PITA_ICR + 2);
 
 	return 0;
 
-failure:
-	rtcan_peak_pci_del_chan(dev, init_step);
-	return ret;
-}
+failure_free_dev:
+	pci_set_drvdata(pdev, chan->prev_dev);
+	rtcan_dev_free(dev);
 
-static int peak_pci_init_one(struct pci_dev *pdev,
-			     const struct pci_device_id *ent)
-{
-	int ret;
-	u16 sub_sys_id;
-	struct rtcan_device *master_dev = NULL;
-
-	printk("%s: initializing device %04x:%04x\n",
-	       RTCAN_DRV_NAME, pdev->vendor, pdev->device);
-	ret = pci_enable_device(pdev);
-	if (ret)
-		goto failure;
-
-	ret = pci_request_regions(pdev, RTCAN_DRV_NAME);
-	if (ret)
-		goto failure;
-
-	ret = pci_read_config_word(pdev, 0x2e, &sub_sys_id);
-	if (ret)
-		goto failure_cleanup;
-
-	/* Enable memory space */
-	ret = pci_write_config_word(pdev, 0x04, 2);
-	if (ret)
-		goto failure_cleanup;
-
-	ret = pci_write_config_word(pdev, 0x44, 0);
-	if (ret)
-		goto failure_cleanup;
-
-	if (sub_sys_id > 3) {
-		ret = rtcan_peak_pci_add_chan(pdev, CHANNEL_MASTER, &master_dev);
-		if (ret)
-			goto failure_cleanup;
-		ret = rtcan_peak_pci_add_chan(pdev, CHANNEL_SLAVE, &master_dev);
-		if (ret)
-			goto failure_cleanup;
-	} else {
-		ret = rtcan_peak_pci_add_chan(pdev, CHANNEL_SINGLE,
-			&master_dev);
-		if (ret)
-			goto failure_cleanup;
+failure_remove_channels:
+	/* Disable interrupts */
+	writew(0x0, cfg_base + PITA_ICR + 2);
+
+	chan = NULL;
+	for (dev = pci_get_drvdata(pdev); dev; dev = chan->prev_dev) {
+		rtcan_sja1000_unregister(dev);
+		rtcan_dev_free(dev);
 	}
 
-	pci_set_drvdata(pdev, master_dev);
-	return 0;
+	pci_iounmap(pdev, reg_base);
 
-failure_cleanup:
-	if (master_dev)
-		rtcan_peak_pci_del_chan(master_dev, 0);
+failure_unmap_cfg_base:
+	pci_iounmap(pdev, cfg_base);
 
+failure_release_regions:
 	pci_release_regions(pdev);
 
-failure:
-	return ret;
+failure_disable_pci:
+	pci_disable_device(pdev);
+
+	return err;
 
 }
 
 static void peak_pci_remove_one(struct pci_dev *pdev)
 {
-	struct rtcan_device *dev = pci_get_drvdata(pdev);
-	struct rtcan_peak_pci *board = (struct rtcan_peak_pci *)dev->board_priv;
+	struct rtcan_device *dev = pci_get_drvdata(pdev); /* Last device */
+	struct peak_pci_chan *chan = (struct peak_pci_chan *)dev->board_priv;
+	void __iomem *cfg_base = chan->cfg_base;
+	void __iomem *reg_base = chan->reg_base;
 
-	if (board->slave_dev)
-		rtcan_peak_pci_del_chan(board->slave_dev, 0);
-	rtcan_peak_pci_del_chan(dev, 0);
+	/* Disable interrupts */
+	writew(0x0, cfg_base + PITA_ICR + 2);
 
+	/* Loop over all registered devices */
+	while (1) {
+		dev_info(&pdev->dev, "removing device %s\n", dev->name);
+		rtcan_sja1000_unregister(dev);
+		rtcan_dev_free(dev);
+		dev = chan->prev_dev;
+	}
+
+	pci_iounmap(pdev, reg_base);
+	pci_iounmap(pdev, cfg_base);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
+
 	pci_set_drvdata(pdev, NULL);
 }
 
-- 
1.7.9.5


