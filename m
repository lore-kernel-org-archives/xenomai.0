From: Konrad Banachowicz <konradb3@gmail.com>
Date: Mon, 16 Dec 2013 17:08:38 +0100
Message-Id: <1387210119-18909-1-git-send-email-konradb3@gmail.com>
Subject: [Xenomai] [PATCH 1/2] rtcan/peek_pci: style fixes.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Reformat files files according to kernel style.

---
 ksrc/drivers/can/sja1000/rtcan_peak_pci.c     |  496 +++++------
 ksrc/drivers/can/sja1000/rtcan_sja1000.c      | 1146 ++++++++++++-------------
 ksrc/drivers/can/sja1000/rtcan_sja1000.h      |   24 +-
 ksrc/drivers/can/sja1000/rtcan_sja1000_regs.h |  240 +++---
 4 files changed, 948 insertions(+), 958 deletions(-)

diff --git a/ksrc/drivers/can/sja1000/rtcan_peak_pci.c b/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
index d13a7ff..7e3507d 100644
--- a/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
+++ b/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
@@ -46,41 +46,44 @@ MODULE_DESCRIPTION("RTCAN board driver for PEAK-PCI cards");
 MODULE_SUPPORTED_DEVICE("PEAK-PCI card CAN controller");
 MODULE_LICENSE("GPL");
 
-struct rtcan_peak_pci
-{
-    struct pci_dev *pci_dev;
-    struct rtcan_device *slave_dev;
-    int channel;
-    volatile void __iomem *base_addr;
-    volatile void __iomem *conf_addr;
+struct rtcan_peak_pci {
+	struct pci_dev *pci_dev;
+	struct rtcan_device *slave_dev;
+	int channel;
+	volatile void __iomem *base_addr;
+	volatile void __iomem *conf_addr;
 };
 
 #define PEAK_PCI_CAN_SYS_CLOCK (16000000 / 2)
 
-#define PELICAN_SINGLE  (SJA_CDR_CAN_MODE | SJA_CDR_CBP | 0x07 | SJA_CDR_CLK_OFF)
-#define PELICAN_MASTER  (SJA_CDR_CAN_MODE | SJA_CDR_CBP | 0x07            )
-#define PELICAN_DEFAULT (SJA_CDR_CAN_MODE                                 )
-
-#define CHANNEL_SINGLE 0 /* this is a single channel device */
-#define CHANNEL_MASTER 1 /* multi channel device, this device is master */
-#define CHANNEL_SLAVE  2 /* multi channel device, this is slave */
-
-// important PITA registers
-#define PITA_ICR         0x00        // interrupt control register
-#define PITA_GPIOICR     0x18        // general purpose IO interface control register
-#define PITA_MISC        0x1C        // miscellanoes register
-
-#define PEAK_PCI_VENDOR_ID      0x001C  // the PCI device and vendor IDs
-#define PEAK_PCI_DEVICE_ID      0x0001  // Device ID for PCI and older PCIe cards
-#define PEAK_PCIE_DEVICE_ID     0x0003  // Device ID for newer PCIe cards (IPEH-003027)
-#define PEAK_CPCI_DEVICE_ID     0x0004  // for nextgen cPCI slot cards
-#define PEAK_MPCI_DEVICE_ID     0x0005  // for nextgen miniPCI slot cards
-#define PEAK_PC_104P_DEVICE_ID  0x0006  // PCAN-PC/104+ cards
-#define PEAK_PCI_104E_DEVICE_ID 0x0007  // PCAN-PCI/104 Express cards
-#define PEAK_MPCIE_DEVICE_ID    0x0008  // The miniPCIe slot cards
-
-#define PCI_CONFIG_PORT_SIZE 0x1000  // size of the config io-memory
-#define PCI_PORT_SIZE        0x0400  // size of a channel io-memory
+#define PELICAN_SINGLE (SJA_CDR_CAN_MODE | SJA_CDR_CBP | 0x07 | SJA_CDR_CLK_OFF)
+#define PELICAN_MASTER  (SJA_CDR_CAN_MODE | SJA_CDR_CBP | 0x07)
+#define PELICAN_DEFAULT (SJA_CDR_CAN_MODE)
+
+#define CHANNEL_SINGLE 0	/* this is a single channel device */
+#define CHANNEL_MASTER 1	/* multi channel device, this device is master
+*/
+#define CHANNEL_SLAVE  2	/* multi channel device, this is slave */
+
+/* important PITA registers */
+#define PITA_ICR         0x00	/* interrupt control register */
+#define PITA_GPIOICR     0x18	/* general purpose IO interface control register
+*/
+#define PITA_MISC        0x1C	/* miscellanoes register */
+
+#define PEAK_PCI_VENDOR_ID      0x001C	/* the PCI device and vendor IDs */
+#define PEAK_PCI_DEVICE_ID      0x0001	/* Device ID for PCI and older PCIe
+cards */
+#define PEAK_PCIE_DEVICE_ID     0x0003	/* Device ID for newer PCIe cards
+(IPEH-003027) */
+#define PEAK_CPCI_DEVICE_ID     0x0004	/* for nextgen cPCI slot cards */
+#define PEAK_MPCI_DEVICE_ID     0x0005	/* for nextgen miniPCI slot cards */
+#define PEAK_PC_104P_DEVICE_ID  0x0006	/* PCAN-PC/104+ cards */
+#define PEAK_PCI_104E_DEVICE_ID 0x0007	/* PCAN-PCI/104 Express cards */
+#define PEAK_MPCIE_DEVICE_ID    0x0008	/* The miniPCIe slot cards */
+
+#define PCI_CONFIG_PORT_SIZE 0x1000	/* size of the config io-memory */
+#define PCI_PORT_SIZE        0x0400	/* size of a channel io-memory */
 
 static struct pci_device_id peak_pci_tbl[] = {
 	{PEAK_PCI_VENDOR_ID, PEAK_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
@@ -90,274 +93,279 @@ static struct pci_device_id peak_pci_tbl[] = {
 	{PEAK_PCI_VENDOR_ID, PEAK_PC_104P_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{PEAK_PCI_VENDOR_ID, PEAK_PCI_104E_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{PEAK_PCI_VENDOR_ID, PEAK_CPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
-	{ }
+	{}
 };
-MODULE_DEVICE_TABLE (pci, peak_pci_tbl);
 
+MODULE_DEVICE_TABLE(pci, peak_pci_tbl);
 
 static u8 rtcan_peak_pci_read_reg(struct rtcan_device *dev, int port)
 {
-    struct rtcan_peak_pci *board = (struct rtcan_peak_pci *)dev->board_priv;
-    return readb(board->base_addr + ((unsigned long)port << 2));
+	struct rtcan_peak_pci *board = (struct rtcan_peak_pci *)dev->board_priv;
+	return readb(board->base_addr + ((unsigned long)port << 2));
 }
 
-static void rtcan_peak_pci_write_reg(struct rtcan_device *dev, int port, u8 data)
+static void rtcan_peak_pci_write_reg(struct rtcan_device *dev, int port,
+				     u8 data)
 {
-    struct rtcan_peak_pci *board = (struct rtcan_peak_pci *)dev->board_priv;
-    writeb(data, board->base_addr + ((unsigned long)port << 2));
+	struct rtcan_peak_pci *board = (struct rtcan_peak_pci *)dev->board_priv;
+	writeb(data, board->base_addr + ((unsigned long)port << 2));
 }
 
 static void rtcan_peak_pci_irq_ack(struct rtcan_device *dev)
 {
-    struct rtcan_peak_pci *board = (struct rtcan_peak_pci *)dev->board_priv;
-    u16 pita_icr_low;
-
-    /* Select and clear in Pita stored interrupt */
-    pita_icr_low = readw(board->conf_addr + PITA_ICR);
-    if (board->channel == CHANNEL_SLAVE) {
-	if (pita_icr_low & 0x0001)
-	    writew(0x0001, board->conf_addr + PITA_ICR);
-    }
-    else {
-	if (pita_icr_low & 0x0002)
-	    writew(0x0002, board->conf_addr + PITA_ICR);
-    }
-}
-
-static void rtcan_peak_pci_del_chan(struct rtcan_device *dev,
-				    int init_step)
-{
-    struct rtcan_peak_pci *board;
-    u16 pita_icr_high;
-
-    if (!dev)
-	return;
-
-    board = (struct rtcan_peak_pci *)dev->board_priv;
+	struct rtcan_peak_pci *board = (struct rtcan_peak_pci *)dev->board_priv;
+	u16 pita_icr_low;
 
-    switch (init_step) {
-    case 0:			/* Full cleanup */
-	printk("Removing %s %s device %s\n",
-	       peak_pci_board_name, dev->ctrl_name, dev->name);
-	rtcan_sja1000_unregister(dev);
-    case 5:
-	pita_icr_high = readw(board->conf_addr + PITA_ICR + 2);
+	/* Select and clear in Pita stored interrupt */
+	pita_icr_low = readw(board->conf_addr + PITA_ICR);
 	if (board->channel == CHANNEL_SLAVE) {
-	    pita_icr_high &= ~0x0001;
+		if (pita_icr_low & 0x0001)
+			writew(0x0001, board->conf_addr + PITA_ICR);
 	} else {
-	    pita_icr_high &= ~0x0002;
+		if (pita_icr_low & 0x0002)
+			writew(0x0002, board->conf_addr + PITA_ICR);
+	}
+}
+
+static void rtcan_peak_pci_del_chan(struct rtcan_device *dev, int init_step)
+{
+	struct rtcan_peak_pci *board;
+	u16 pita_icr_high;
+
+	if (!dev)
+		return;
+
+	board = (struct rtcan_peak_pci *)dev->board_priv;
+
+	switch (init_step) {
+	case 0:		/* Full cleanup */
+		printk("Removing %s %s device %s\n",
+		       peak_pci_board_name, dev->ctrl_name, dev->name);
+		rtcan_sja1000_unregister(dev);
+	case 5:
+		pita_icr_high = readw(board->conf_addr + PITA_ICR + 2);
+		if (board->channel == CHANNEL_SLAVE)
+			pita_icr_high &= ~0x0001;
+		else
+			pita_icr_high &= ~0x0002;
+
+		writew(pita_icr_high, board->conf_addr + PITA_ICR + 2);
+	case 4:
+		iounmap((void *)board->base_addr);
+	case 3:
+		if (board->channel != CHANNEL_SLAVE)
+			iounmap((void *)board->conf_addr);
+	case 2:
+		rtcan_dev_free(dev);
+	case 1:
+		break;
 	}
-	writew(pita_icr_high, board->conf_addr + PITA_ICR + 2);
-    case 4:
-	iounmap((void *)board->base_addr);
-    case 3:
-	if (board->channel != CHANNEL_SLAVE)
-	    iounmap((void *)board->conf_addr);
-    case 2:
-	rtcan_dev_free(dev);
-    case 1:
-	break;
-    }
 
 }
 
 static int rtcan_peak_pci_add_chan(struct pci_dev *pdev, int channel,
 				   struct rtcan_device **master_dev)
 {
-    struct rtcan_device *dev;
-    struct rtcan_sja1000 *chip;
-    struct rtcan_peak_pci *board;
-    u16 pita_icr_high;
-    unsigned long addr;
-    int ret, init_step = 1;
-
-    dev = rtcan_dev_alloc(sizeof(struct rtcan_sja1000),
-			  sizeof(struct rtcan_peak_pci));
-    if (dev == NULL)
-	return -ENOMEM;
-    init_step = 2;
-
-    chip = (struct rtcan_sja1000 *)dev->priv;
-    board = (struct rtcan_peak_pci *)dev->board_priv;
-
-    board->pci_dev = pdev;
-    board->channel = channel;
-
-    if (channel != CHANNEL_SLAVE) {
-
-	addr = pci_resource_start(pdev, 0);
-	board->conf_addr = ioremap(addr, PCI_CONFIG_PORT_SIZE);
-	if (board->conf_addr == 0) {
-	    ret = -ENODEV;
-	    goto failure;
+	struct rtcan_device *dev;
+	struct rtcan_sja1000 *chip;
+	struct rtcan_peak_pci *board;
+	u16 pita_icr_high;
+	unsigned long addr;
+	int ret, init_step = 1;
+
+	dev = rtcan_dev_alloc(sizeof(struct rtcan_sja1000),
+			      sizeof(struct rtcan_peak_pci));
+	if (dev == NULL)
+		return -ENOMEM;
+	init_step = 2;
+
+	chip = (struct rtcan_sja1000 *)dev->priv;
+	board = (struct rtcan_peak_pci *)dev->board_priv;
+
+	board->pci_dev = pdev;
+	board->channel = channel;
+
+	if (channel != CHANNEL_SLAVE) {
+
+		addr = pci_resource_start(pdev, 0);
+		board->conf_addr = ioremap(addr, PCI_CONFIG_PORT_SIZE);
+		if (board->conf_addr == 0) {
+			ret = -ENODEV;
+			goto failure;
+		}
+		init_step = 3;
+
+		/* Set GPIO control register */
+		writew(0x0005, board->conf_addr + PITA_GPIOICR + 2);
+
+		if (channel == CHANNEL_MASTER)
+			writeb(0x00, board->conf_addr + PITA_GPIOICR);	/* enable both */
+		else
+			writeb(0x04, board->conf_addr + PITA_GPIOICR);	/* enable single */
+
+		/* toggle reset */
+		writeb(0x05, board->conf_addr + PITA_MISC + 3);
+		mdelay(5);
+		/* leave parport mux mode */
+		writeb(0x04, board->conf_addr + PITA_MISC + 3);
+	} else {
+		struct rtcan_peak_pci *master_board =
+		    (struct rtcan_peak_pci *)(*master_dev)->board_priv;
+		master_board->slave_dev = dev;
+		board->conf_addr = master_board->conf_addr;
 	}
-	init_step = 3;
 
-	/* Set GPIO control register */
-	writew(0x0005, board->conf_addr + PITA_GPIOICR + 2);
+	addr = pci_resource_start(pdev, 1);
+	if (channel == CHANNEL_SLAVE)
+		addr += 0x400;
 
-	if (channel == CHANNEL_MASTER)
-	    writeb(0x00, board->conf_addr + PITA_GPIOICR); /* enable both */
-	else
-	    writeb(0x04, board->conf_addr + PITA_GPIOICR); /* enable single */
-
-	writeb(0x05, board->conf_addr + PITA_MISC + 3);  /* toggle reset */
-	mdelay(5);
-	writeb(0x04, board->conf_addr + PITA_MISC + 3);  /* leave parport mux mode */
-    } else {
-	struct rtcan_peak_pci *master_board =
-	    (struct rtcan_peak_pci *)(*master_dev)->board_priv;
-	master_board->slave_dev = dev;
-	board->conf_addr = master_board->conf_addr;
-    }
-
-    addr = pci_resource_start(pdev, 1);
-    if (channel == CHANNEL_SLAVE)
-	addr += 0x400;
-
-    board->base_addr = ioremap(addr, PCI_PORT_SIZE);
-    if (board->base_addr == 0) {
-	ret = -ENODEV;
-	goto failure;
-    }
-    init_step = 4;
-
-    dev->board_name = peak_pci_board_name;
-
-    chip->read_reg = rtcan_peak_pci_read_reg;
-    chip->write_reg = rtcan_peak_pci_write_reg;
-    chip->irq_ack = rtcan_peak_pci_irq_ack;
-
-    /* Clock frequency in Hz */
-    dev->can_sys_clock = PEAK_PCI_CAN_SYS_CLOCK;
-
-    /* Output control register */
-    chip->ocr = SJA_OCR_MODE_NORMAL | SJA_OCR_TX0_PUSHPULL;
-
-    /* Clock divider register */
-    if (channel == CHANNEL_MASTER)
-	chip->cdr = PELICAN_MASTER;
-    else
-	chip->cdr = PELICAN_SINGLE;
-
-    strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
-
-    /* Register and setup interrupt handling */
-    chip->irq_flags = RTDM_IRQTYPE_SHARED;
-    chip->irq_num = pdev->irq;
-    pita_icr_high = readw(board->conf_addr + PITA_ICR + 2);
-    if (channel == CHANNEL_SLAVE) {
-	pita_icr_high |= 0x0001;
-    } else {
-	pita_icr_high |= 0x0002;
-    }
-    writew(pita_icr_high, board->conf_addr + PITA_ICR + 2);
-    init_step = 5;
-
-    printk("%s: base_addr=%p conf_addr=%p irq=%d\n", RTCAN_DRV_NAME,
-	   board->base_addr, board->conf_addr, chip->irq_num);
-
-    /* Register SJA1000 device */
-    ret = rtcan_sja1000_register(dev);
-    if (ret) {
-	printk(KERN_ERR
-	       "ERROR %d while trying to register SJA1000 device!\n", ret);
-	goto failure;
-    }
-
-    if (channel != CHANNEL_SLAVE)
-	*master_dev = dev;
-
-    return 0;
-
- failure:
-    rtcan_peak_pci_del_chan(dev, init_step);
-    return ret;
-}
+	board->base_addr = ioremap(addr, PCI_PORT_SIZE);
+	if (board->base_addr == 0) {
+		ret = -ENODEV;
+		goto failure;
+	}
+	init_step = 4;
 
-static int peak_pci_init_one(struct pci_dev *pdev,
-			     const struct pci_device_id *ent)
-{
-    int ret;
-    u16 sub_sys_id;
-    struct rtcan_device *master_dev = NULL;
+	dev->board_name = peak_pci_board_name;
+
+	chip->read_reg = rtcan_peak_pci_read_reg;
+	chip->write_reg = rtcan_peak_pci_write_reg;
+	chip->irq_ack = rtcan_peak_pci_irq_ack;
 
-    printk("%s: initializing device %04x:%04x\n",
-	   RTCAN_DRV_NAME,  pdev->vendor, pdev->device);
+	/* Clock frequency in Hz */
+	dev->can_sys_clock = PEAK_PCI_CAN_SYS_CLOCK;
 
-    if ((ret = pci_enable_device (pdev)))
-	goto failure;
+	/* Output control register */
+	chip->ocr = SJA_OCR_MODE_NORMAL | SJA_OCR_TX0_PUSHPULL;
 
-    if ((ret = pci_request_regions(pdev, RTCAN_DRV_NAME)))
-	goto failure;
+	/* Clock divider register */
+	if (channel == CHANNEL_MASTER)
+		chip->cdr = PELICAN_MASTER;
+	else
+		chip->cdr = PELICAN_SINGLE;
+
+	strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+
+	/* Register and setup interrupt handling */
+	chip->irq_flags = RTDM_IRQTYPE_SHARED;
+	chip->irq_num = pdev->irq;
+	pita_icr_high = readw(board->conf_addr + PITA_ICR + 2);
+	if (channel == CHANNEL_SLAVE)
+		pita_icr_high |= 0x0001;
+	else
+		pita_icr_high |= 0x0002;
+	writew(pita_icr_high, board->conf_addr + PITA_ICR + 2);
+	init_step = 5;
+
+	printk("%s: base_addr=%p conf_addr=%p irq=%d\n", RTCAN_DRV_NAME,
+	       board->base_addr, board->conf_addr, chip->irq_num);
+
+	/* Register SJA1000 device */
+	ret = rtcan_sja1000_register(dev);
+	if (ret) {
+		printk(KERN_ERR
+		       "ERROR %d while trying to register SJA1000 device!\n",
+		       ret);
+		goto failure;
+	}
 
-    if ((ret = pci_read_config_word(pdev, 0x2e, &sub_sys_id)))
-	goto failure_cleanup;
+	if (channel != CHANNEL_SLAVE)
+		*master_dev = dev;
 
-    /* Enable memory space */
-    if ((ret = pci_write_config_word(pdev, 0x04, 2)))
-	goto failure_cleanup;
+	return 0;
 
-    if ((ret = pci_write_config_word(pdev, 0x44, 0)))
-	goto failure_cleanup;
+failure:
+	rtcan_peak_pci_del_chan(dev, init_step);
+	return ret;
+}
 
-    if (sub_sys_id > 3) {
-	if ((ret = rtcan_peak_pci_add_chan(pdev, CHANNEL_MASTER,
-					   &master_dev)))
-	    goto failure_cleanup;
-	if ((ret = rtcan_peak_pci_add_chan(pdev, CHANNEL_SLAVE,
-					   &master_dev)))
-	    goto failure_cleanup;
-    } else {
-	if ((ret = rtcan_peak_pci_add_chan(pdev, CHANNEL_SINGLE,
-					   &master_dev)))
-	    goto failure_cleanup;
-    }
+static int peak_pci_init_one(struct pci_dev *pdev,
+			     const struct pci_device_id *ent)
+{
+	int ret;
+	u16 sub_sys_id;
+	struct rtcan_device *master_dev = NULL;
+
+	printk("%s: initializing device %04x:%04x\n",
+	       RTCAN_DRV_NAME, pdev->vendor, pdev->device);
+	ret = pci_enable_device(pdev);
+	if (ret)
+		goto failure;
+
+	ret = pci_request_regions(pdev, RTCAN_DRV_NAME);
+	if (ret)
+		goto failure;
+
+	ret = pci_read_config_word(pdev, 0x2e, &sub_sys_id);
+	if (ret)
+		goto failure_cleanup;
+
+	/* Enable memory space */
+	ret = pci_write_config_word(pdev, 0x04, 2);
+	if (ret)
+		goto failure_cleanup;
+
+	ret = pci_write_config_word(pdev, 0x44, 0);
+	if (ret)
+		goto failure_cleanup;
+
+	if (sub_sys_id > 3) {
+		ret = rtcan_peak_pci_add_chan(pdev, CHANNEL_MASTER, &master_dev);
+		if (ret)
+			goto failure_cleanup;
+		ret = rtcan_peak_pci_add_chan(pdev, CHANNEL_SLAVE, &master_dev);
+		if (ret)
+			goto failure_cleanup;
+	} else {
+		ret = rtcan_peak_pci_add_chan(pdev, CHANNEL_SINGLE,
+			&master_dev);
+		if (ret)
+			goto failure_cleanup;
+	}
 
-    pci_set_drvdata(pdev, master_dev);
-    return 0;
+	pci_set_drvdata(pdev, master_dev);
+	return 0;
 
- failure_cleanup:
-    if (master_dev)
-	rtcan_peak_pci_del_chan(master_dev, 0);
+failure_cleanup:
+	if (master_dev)
+		rtcan_peak_pci_del_chan(master_dev, 0);
 
-    pci_release_regions(pdev);
+	pci_release_regions(pdev);
 
- failure:
-    return ret;
+failure:
+	return ret;
 
 }
 
 static void peak_pci_remove_one(struct pci_dev *pdev)
 {
-    struct rtcan_device *dev = pci_get_drvdata(pdev);
-    struct rtcan_peak_pci *board = (struct rtcan_peak_pci *)dev->board_priv;
+	struct rtcan_device *dev = pci_get_drvdata(pdev);
+	struct rtcan_peak_pci *board = (struct rtcan_peak_pci *)dev->board_priv;
 
-    if (board->slave_dev)
-	rtcan_peak_pci_del_chan(board->slave_dev, 0);
-    rtcan_peak_pci_del_chan(dev, 0);
+	if (board->slave_dev)
+		rtcan_peak_pci_del_chan(board->slave_dev, 0);
+	rtcan_peak_pci_del_chan(dev, 0);
 
-    pci_release_regions(pdev);
-    pci_disable_device(pdev);
-    pci_set_drvdata(pdev, NULL);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
 }
 
 static struct pci_driver rtcan_peak_pci_driver = {
-	.name		= RTCAN_DRV_NAME,
-	.id_table	= peak_pci_tbl,
-	.probe		= peak_pci_init_one,
-	.remove		= peak_pci_remove_one,
+	.name = RTCAN_DRV_NAME,
+	.id_table = peak_pci_tbl,
+	.probe = peak_pci_init_one,
+	.remove = peak_pci_remove_one,
 };
 
 static int __init rtcan_peak_pci_init(void)
 {
-    return pci_register_driver(&rtcan_peak_pci_driver);
+	return pci_register_driver(&rtcan_peak_pci_driver);
 }
 
-
 static void __exit rtcan_peak_pci_exit(void)
 {
-    pci_unregister_driver(&rtcan_peak_pci_driver);
+	pci_unregister_driver(&rtcan_peak_pci_driver);
 }
 
 module_init(rtcan_peak_pci_init);
diff --git a/ksrc/drivers/can/sja1000/rtcan_sja1000.c b/ksrc/drivers/can/sja1000/rtcan_sja1000.c
index cf91439..db56bd2 100644
--- a/ksrc/drivers/can/sja1000/rtcan_sja1000.c
+++ b/ksrc/drivers/can/sja1000/rtcan_sja1000.c
@@ -46,7 +46,6 @@
 #include <rtcan_sja1000.h>
 #include <rtcan_sja1000_regs.h>
 
-
 #define BTR0_BRP_MASK	0x3f
 #define BTR0_SJW_SHIFT	6
 #define BTR0_SJW_MASK	(0x3 << BTR0_SJW_SHIFT)
@@ -64,19 +63,18 @@
 #define BTR1_SET_SAM(sam)     (((sam) & 1) << BTR1_SAM_SHIFT)
 
 /* Value for the interrupt enable register */
-#define SJA1000_IER                 SJA_IER_RIE | SJA_IER_TIE | \
+#define SJA1000_IER                 (SJA_IER_RIE | SJA_IER_TIE | \
 				    SJA_IER_EIE | SJA_IER_WUIE | \
 				    SJA_IER_EPIE | SJA_IER_BEIE | \
-				    SJA_IER_ALIE | SJA_IER_DOIE
+				    SJA_IER_ALIE | SJA_IER_DOIE)
 
 static char *sja_ctrl_name = "SJA1000";
 
-#define STATE_OPERATING(state) \
-    ((state) != CAN_STATE_STOPPED && (state) != CAN_STATE_BUS_OFF)
-
-#define STATE_RESET(state) \
-    ((state) == CAN_STATE_STOPPED || (state) == CAN_STATE_BUS_OFF)
+#define STATE_OPERATING(state)\
+	((state) != CAN_STATE_STOPPED && (state) != CAN_STATE_BUS_OFF)
 
+#define STATE_RESET(state)\
+	((state) == CAN_STATE_STOPPED || (state) == CAN_STATE_BUS_OFF)
 
 MODULE_AUTHOR("Sebastian.Smolorz@stud.uni-hannover.de");
 MODULE_LICENSE("GPL");
@@ -100,283 +98,281 @@ static struct can_bittiming_const sja1000_bittiming_const = {
 static inline void rtcan_sja_rx_interrupt(struct rtcan_device *dev,
 					  struct rtcan_skb *skb)
 {
-    int i;
-    /* "Real" size of the payload */
-    u8 size;
-    /* Content of frame information register */
-    u8 fir;
-    /* Ring buffer frame within skb */
-    struct rtcan_rb_frame *frame = &skb->rb_frame;
-    struct rtcan_sja1000 *chip = dev->priv;
-
-    /* Read out frame information register */
-    fir = chip->read_reg(dev, SJA_FIR);
-
-    /* Extract data length code */
-    frame->can_dlc = fir & SJA_FIR_DLC_MASK;
-
-    /* If DLC exceeds 8 bytes adjust it to 8 (for the payload size) */
-    size = (frame->can_dlc > 8) ? 8 : frame->can_dlc;
-
-
-    if (fir & SJA_FIR_EFF) {
-	/* Extended frame */
-	frame->can_id = CAN_EFF_FLAG;
-
-	/* Read ID */
-	frame->can_id |= chip->read_reg(dev, SJA_ID1) << 21;
-	frame->can_id |= chip->read_reg(dev, SJA_ID2) << 13;
-	frame->can_id |= chip->read_reg(dev, SJA_ID3) << 5;
-	frame->can_id |= chip->read_reg(dev, SJA_ID4) >> 3;
-
-	if (!(fir & SJA_FIR_RTR)) {
-	    /* No RTR, read data bytes */
-	    for (i = 0; i < size; i++)
-		frame->data[i] = chip->read_reg(dev,
-						SJA_DATA_EFF(i));
-	}
+	int i;
+	/* "Real" size of the payload */
+	u8 size;
+	/* Content of frame information register */
+	u8 fir;
+	/* Ring buffer frame within skb */
+	struct rtcan_rb_frame *frame = &skb->rb_frame;
+	struct rtcan_sja1000 *chip = dev->priv;
+
+	/* Read out frame information register */
+	fir = chip->read_reg(dev, SJA_FIR);
+
+	/* Extract data length code */
+	frame->can_dlc = fir & SJA_FIR_DLC_MASK;
+
+	/* If DLC exceeds 8 bytes adjust it to 8 (for the payload size) */
+	size = (frame->can_dlc > 8) ? 8 : frame->can_dlc;
+
+	if (fir & SJA_FIR_EFF) {
+		/* Extended frame */
+		frame->can_id = CAN_EFF_FLAG;
+
+		/* Read ID */
+		frame->can_id |= chip->read_reg(dev, SJA_ID1) << 21;
+		frame->can_id |= chip->read_reg(dev, SJA_ID2) << 13;
+		frame->can_id |= chip->read_reg(dev, SJA_ID3) << 5;
+		frame->can_id |= chip->read_reg(dev, SJA_ID4) >> 3;
+
+		if (!(fir & SJA_FIR_RTR)) {
+			/* No RTR, read data bytes */
+			for (i = 0; i < size; i++)
+				frame->data[i] = chip->read_reg(dev,
+								SJA_DATA_EFF
+								(i));
+		}
 
-    } else {
-	/* Standard frame */
+	} else {
+		/* Standard frame */
 
-	/* Read ID */
-	frame->can_id  = chip->read_reg(dev, SJA_ID1) << 3;
-	frame->can_id |= chip->read_reg(dev, SJA_ID2) >> 5;
+		/* Read ID */
+		frame->can_id = chip->read_reg(dev, SJA_ID1) << 3;
+		frame->can_id |= chip->read_reg(dev, SJA_ID2) >> 5;
 
-	if (!(fir & SJA_FIR_RTR)) {
-	    /* No RTR, read data bytes */
-	    for (i = 0; i < size; i++)
-		frame->data[i] = chip->read_reg(dev, SJA_DATA_SFF(i));
+		if (!(fir & SJA_FIR_RTR)) {
+			/* No RTR, read data bytes */
+			for (i = 0; i < size; i++)
+				frame->data[i] =
+				    chip->read_reg(dev, SJA_DATA_SFF(i));
+		}
 	}
-    }
-
-    /* Release Receive Buffer */
-    chip->write_reg(dev, SJA_CMR, SJA_CMR_RRB);
 
+	/* Release Receive Buffer */
+	chip->write_reg(dev, SJA_CMR, SJA_CMR_RRB);
 
-    /* RTR? */
-    if (fir & SJA_FIR_RTR) {
-	frame->can_id |= CAN_RTR_FLAG;
-	skb->rb_frame_size = EMPTY_RB_FRAME_SIZE;
-    } else
-	skb->rb_frame_size = EMPTY_RB_FRAME_SIZE + size;
-
-    /* Store the interface index */
-    frame->can_ifindex = dev->ifindex;
+	/* RTR? */
+	if (fir & SJA_FIR_RTR) {
+		frame->can_id |= CAN_RTR_FLAG;
+		skb->rb_frame_size = EMPTY_RB_FRAME_SIZE;
+	} else
+		skb->rb_frame_size = EMPTY_RB_FRAME_SIZE + size;
+
+	/* Store the interface index */
+	frame->can_ifindex = dev->ifindex;
 }
 
-
 static inline void rtcan_sja_err_interrupt(struct rtcan_device *dev,
 					   struct rtcan_sja1000 *chip,
-					   struct rtcan_skb *skb,
-					   u8 irq_source)
+					   struct rtcan_skb *skb, u8 irq_source)
 {
-    struct rtcan_rb_frame *frame = &skb->rb_frame;
-    can_state_t state = dev->state;
-    u8 status, txerr, rxerr;
-
-    status = chip->read_reg(dev, SJA_SR);
-    txerr = chip->read_reg(dev, SJA_TXERR);
-    rxerr = chip->read_reg(dev, SJA_RXERR);
-
-    skb->rb_frame_size = EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
-
-    frame->can_id = CAN_ERR_FLAG;
-    frame->can_dlc = CAN_ERR_DLC;
-
-    memset(&frame->data[0], 0, frame->can_dlc);
-
-    /* Data overrun interrupt? */
-    if (irq_source & SJA_IR_DOI) {
-	frame->can_id |= CAN_ERR_CRTL;
-	frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
-    }
-
-    /* Arbitratio lost interrupt? */
-    if (irq_source & SJA_IR_ALI) {
-	frame->can_id |= CAN_ERR_LOSTARB;
-	frame->data[0] = chip->read_reg(dev, SJA_ALC)  & 0x1f;
-    }
-
-    /* Bus error interrupt? */
-    if (irq_source & SJA_IR_BEI) {
-	u8 ecc = chip->read_reg(dev, SJA_ECC);
-
-	frame->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
-
-	switch (ecc & SJA_ECC_ERR_MASK) {
-	case SJA_ECC_ERR_BIT:
-	    frame->data[2] |= CAN_ERR_PROT_BIT;
-	    break;
-	case SJA_ECC_ERR_FORM:
-	    frame->data[2] |= CAN_ERR_PROT_FORM;
-	    break;
-	case SJA_ECC_ERR_STUFF:
-	    frame->data[2] |= CAN_ERR_PROT_STUFF;
-	    break;
-	default:
-	    frame->data[2] |= CAN_ERR_PROT_UNSPEC;
-	    frame->data[3] = ecc & SJA_ECC_SEG_MASK;
-	    break;
-	}
-	/* Error occured during transmission? */
-	if ((ecc & SJA_ECC_DIR) == 0)
-	    frame->data[2] |= CAN_ERR_PROT_TX;
-    }
-
-    /* Error passive interrupt? */
-    if (unlikely(irq_source & SJA_IR_EPI)) {
-	if (state == CAN_STATE_BUS_WARNING) {
-	    state = CAN_STATE_BUS_PASSIVE;
-	} else {
-	    state = CAN_STATE_BUS_WARNING;
-	}
-    }
-
-    /* Error warning interrupt? */
-    if (irq_source & SJA_IR_EI) {
-
-	/* Test bus status (bus-off condition) */
-	if (status & SJA_SR_BS) {
-	    /* Bus-off */
-	    state = CAN_STATE_BUS_OFF;
-	    frame->can_id |= CAN_ERR_BUSOFF;
-	    /* Only allow error warning interrupts
-	       (otherwise an EPI would arise during bus-off
-	       recovery) */
-	    chip->write_reg(dev, SJA_IER, SJA_IER_EIE);
-	    /* Wake up waiting senders */
-	    rtdm_sem_destroy(&dev->tx_sem);
-	}
+	struct rtcan_rb_frame *frame = &skb->rb_frame;
+	can_state_t state = dev->state;
+	u8 status, txerr, rxerr;
 
-	/* Test error status (error warning limit) */
-	else if (status & SJA_SR_ES)
-	    /* error warning limit reached */
-	    state = CAN_STATE_BUS_WARNING;
+	status = chip->read_reg(dev, SJA_SR);
+	txerr = chip->read_reg(dev, SJA_TXERR);
+	rxerr = chip->read_reg(dev, SJA_RXERR);
 
-	/* Re-entrance into error active state from bus-warn? */
-	else if (state == CAN_STATE_BUS_WARNING)
-	    state = CAN_STATE_ACTIVE;
+	skb->rb_frame_size = EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
 
-	else
-	    /* Bus-off recovery complete, enable all interrupts again */
-	    chip->write_reg(dev, SJA_IER, SJA1000_IER);
-    }
-
-    if (state != dev->state &&
-	(state == CAN_STATE_BUS_WARNING || state == CAN_STATE_BUS_PASSIVE)) {
-	frame->can_id |= CAN_ERR_PROT;
-	if (txerr > rxerr)
-	    frame->data[1] = CAN_ERR_CRTL_TX_WARNING;
-	else
-	    frame->data[1] = CAN_ERR_CRTL_RX_WARNING;
-    }
+	frame->can_id = CAN_ERR_FLAG;
+	frame->can_dlc = CAN_ERR_DLC;
 
-    dev->state = state;
-    frame->can_ifindex = dev->ifindex;
-}
+	memset(&frame->data[0], 0, frame->can_dlc);
 
-static int rtcan_sja_interrupt(rtdm_irq_t *irq_handle)
-{
-    struct rtcan_device *dev;
-    struct rtcan_sja1000 *chip;
-    struct rtcan_skb skb;
-    int recv_lock_free = 1;
-    int irq_count = 0;
-    int ret = RTDM_IRQ_NONE;
-    u8 irq_source;
+	/* Data overrun interrupt? */
+	if (irq_source & SJA_IR_DOI) {
+		frame->can_id |= CAN_ERR_CRTL;
+		frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+	}
 
+	/* Arbitratio lost interrupt? */
+	if (irq_source & SJA_IR_ALI) {
+		frame->can_id |= CAN_ERR_LOSTARB;
+		frame->data[0] = chip->read_reg(dev, SJA_ALC) & 0x1f;
+	}
 
-    /* Get the ID of the device which registered this IRQ. */
-    dev = (struct rtcan_device *)rtdm_irq_get_arg(irq_handle, void);
-    chip = (struct rtcan_sja1000 *)dev->priv;
+	/* Bus error interrupt? */
+	if (irq_source & SJA_IR_BEI) {
+		u8 ecc = chip->read_reg(dev, SJA_ECC);
+
+		frame->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+
+		switch (ecc & SJA_ECC_ERR_MASK) {
+		case SJA_ECC_ERR_BIT:
+			frame->data[2] |= CAN_ERR_PROT_BIT;
+			break;
+		case SJA_ECC_ERR_FORM:
+			frame->data[2] |= CAN_ERR_PROT_FORM;
+			break;
+		case SJA_ECC_ERR_STUFF:
+			frame->data[2] |= CAN_ERR_PROT_STUFF;
+			break;
+		default:
+			frame->data[2] |= CAN_ERR_PROT_UNSPEC;
+			frame->data[3] = ecc & SJA_ECC_SEG_MASK;
+			break;
+		}
+		/* Error occured during transmission? */
+		if ((ecc & SJA_ECC_DIR) == 0)
+			frame->data[2] |= CAN_ERR_PROT_TX;
+	}
 
-    /* Take spinlock protecting HW register access and device structures. */
-    rtdm_lock_get(&dev->device_lock);
+	/* Error passive interrupt? */
+	if (unlikely(irq_source & SJA_IR_EPI)) {
+		if (state == CAN_STATE_BUS_WARNING)
+			state = CAN_STATE_BUS_PASSIVE;
+		else
+			state = CAN_STATE_BUS_WARNING;
+	}
 
-    /* Loop as long as the device reports an event */
-    while ((irq_source = chip->read_reg(dev, SJA_IR))) {
-	ret = RTDM_IRQ_HANDLED;
-	irq_count++;
+	/* Error warning interrupt? */
+	if (irq_source & SJA_IR_EI) {
+
+		/* Test bus status (bus-off condition) */
+		if (status & SJA_SR_BS) {
+			/* Bus-off */
+			state = CAN_STATE_BUS_OFF;
+			frame->can_id |= CAN_ERR_BUSOFF;
+			/* Only allow error warning interrupts
+			   (otherwise an EPI would arise during bus-off
+			   recovery) */
+			chip->write_reg(dev, SJA_IER, SJA_IER_EIE);
+			/* Wake up waiting senders */
+			rtdm_sem_destroy(&dev->tx_sem);
+		}
+
+		/* Test error status (error warning limit) */
+		else if (status & SJA_SR_ES)
+			/* error warning limit reached */
+			state = CAN_STATE_BUS_WARNING;
 
-	/* Now look up which interrupts appeared */
+		/* Re-entrance into error active state from bus-warn? */
+		else if (state == CAN_STATE_BUS_WARNING)
+			state = CAN_STATE_ACTIVE;
 
-	/* Wake-up interrupt? */
-	if (irq_source & SJA_IR_WUI)
-	    dev->state = dev->state_before_sleep;
+		else
+			/* Bus-off recovery complete, enable all interrupts again */
+			chip->write_reg(dev, SJA_IER, SJA1000_IER);
+	}
 
-	/* Error Interrupt? */
-	if (irq_source & (SJA_IR_EI | SJA_IR_DOI | SJA_IR_EPI |
-			  SJA_IR_ALI | SJA_IR_BEI)) {
+	if (state != dev->state &&
+	    (state == CAN_STATE_BUS_WARNING
+	     || state == CAN_STATE_BUS_PASSIVE)) {
+		frame->can_id |= CAN_ERR_PROT;
+		if (txerr > rxerr)
+			frame->data[1] = CAN_ERR_CRTL_TX_WARNING;
+		else
+			frame->data[1] = CAN_ERR_CRTL_RX_WARNING;
+	}
 
-	    /* Check error condition and fill error frame */
-	    if (!((irq_source & SJA_IR_BEI) && (chip->bus_err_on-- < 2))) {
-		rtcan_sja_err_interrupt(dev, chip, &skb, irq_source);
+	dev->state = state;
+	frame->can_ifindex = dev->ifindex;
+}
 
-		if (recv_lock_free) {
-		    recv_lock_free = 0;
-		    rtdm_lock_get(&rtcan_recv_list_lock);
-		    rtdm_lock_get(&rtcan_socket_lock);
+static int rtcan_sja_interrupt(rtdm_irq_t *irq_handle)
+{
+	struct rtcan_device *dev;
+	struct rtcan_sja1000 *chip;
+	struct rtcan_skb skb;
+	int recv_lock_free = 1;
+	int irq_count = 0;
+	int ret = RTDM_IRQ_NONE;
+	u8 irq_source;
+
+	/* Get the ID of the device which registered this IRQ. */
+	dev = (struct rtcan_device *)rtdm_irq_get_arg(irq_handle, void);
+	chip = (struct rtcan_sja1000 *)dev->priv;
+
+	/* Take spinlock protecting HW register access and device structures. */
+	rtdm_lock_get(&dev->device_lock);
+
+	/* Loop as long as the device reports an event */
+	while ((irq_source = chip->read_reg(dev, SJA_IR))) {
+		ret = RTDM_IRQ_HANDLED;
+		irq_count++;
+
+		/* Now look up which interrupts appeared */
+
+		/* Wake-up interrupt? */
+		if (irq_source & SJA_IR_WUI)
+			dev->state = dev->state_before_sleep;
+
+		/* Error Interrupt? */
+		if (irq_source & (SJA_IR_EI | SJA_IR_DOI | SJA_IR_EPI |
+				  SJA_IR_ALI | SJA_IR_BEI)) {
+
+			/* Check error condition and fill error frame */
+			if (!
+			    ((irq_source & SJA_IR_BEI)
+			     && (chip->bus_err_on-- < 2))) {
+				rtcan_sja_err_interrupt(dev, chip, &skb,
+							irq_source);
+
+				if (recv_lock_free) {
+					recv_lock_free = 0;
+					rtdm_lock_get(&rtcan_recv_list_lock);
+					rtdm_lock_get(&rtcan_socket_lock);
+				}
+				/* Pass error frame out to the sockets */
+				rtcan_rcv(dev, &skb);
+			}
 		}
-		/* Pass error frame out to the sockets */
-		rtcan_rcv(dev, &skb);
-	    }
-	}
 
-	/* Transmit Interrupt? */
-	if (irq_source & SJA_IR_TI) {
-	    /* Wake up a sender */
-	    rtdm_sem_up(&dev->tx_sem);
+		/* Transmit Interrupt? */
+		if (irq_source & SJA_IR_TI) {
+			/* Wake up a sender */
+			rtdm_sem_up(&dev->tx_sem);
 
-	    if (rtcan_loopback_pending(dev)) {
+			if (rtcan_loopback_pending(dev)) {
 
-		if (recv_lock_free) {
-		    recv_lock_free = 0;
-		    rtdm_lock_get(&rtcan_recv_list_lock);
-		    rtdm_lock_get(&rtcan_socket_lock);
-		}
+				if (recv_lock_free) {
+					recv_lock_free = 0;
+					rtdm_lock_get(&rtcan_recv_list_lock);
+					rtdm_lock_get(&rtcan_socket_lock);
+				}
 
-		rtcan_loopback(dev);
-	    }
-	}
+				rtcan_loopback(dev);
+			}
+		}
 
-	/* Receive Interrupt? */
-	if (irq_source & SJA_IR_RI) {
-
-	    /* Read out HW registers */
-	    rtcan_sja_rx_interrupt(dev, &skb);
-
-	    /* Take more locks. Ensure that they are taken and
-	     * released only once in the IRQ handler. */
-	    /* WARNING: Nested locks are dangerous! But they are
-	     * nested only in this routine so a deadlock should
-	     * not be possible. */
-	    if (recv_lock_free) {
-		recv_lock_free = 0;
-		rtdm_lock_get(&rtcan_recv_list_lock);
-		rtdm_lock_get(&rtcan_socket_lock);
-	    }
-
-	    /* Pass received frame out to the sockets */
-	    rtcan_rcv(dev, &skb);
+		/* Receive Interrupt? */
+		if (irq_source & SJA_IR_RI) {
+
+			/* Read out HW registers */
+			rtcan_sja_rx_interrupt(dev, &skb);
+
+			/* Take more locks. Ensure that they are taken and
+			 * released only once in the IRQ handler. */
+			/* WARNING: Nested locks are dangerous! But they are
+			 * nested only in this routine so a deadlock should
+			 * not be possible. */
+			if (recv_lock_free) {
+				recv_lock_free = 0;
+				rtdm_lock_get(&rtcan_recv_list_lock);
+				rtdm_lock_get(&rtcan_socket_lock);
+			}
+
+			/* Pass received frame out to the sockets */
+			rtcan_rcv(dev, &skb);
+		}
 	}
-    }
 
-    if (chip->irq_ack)
-	chip->irq_ack(dev);
+	if (chip->irq_ack)
+		chip->irq_ack(dev);
 
-    /* Release spinlocks */
-    if (!recv_lock_free) {
-	rtdm_lock_put(&rtcan_socket_lock);
-	rtdm_lock_put(&rtcan_recv_list_lock);
-    }
-    rtdm_lock_put(&dev->device_lock);
+	/* Release spinlocks */
+	if (!recv_lock_free) {
+		rtdm_lock_put(&rtcan_socket_lock);
+		rtdm_lock_put(&rtcan_recv_list_lock);
+	}
+	rtdm_lock_put(&dev->device_lock);
 
-    return ret;
+	return ret;
 }
 
-
-
 /*
  * Inline function to decide if controller is operating
  *
@@ -387,22 +383,21 @@ static int rtcan_sja_interrupt(rtdm_irq_t *irq_handle)
 static inline int rtcan_sja_is_operating(struct rtcan_device *dev,
 					 can_state_t *state)
 {
-    int is_operating = STATE_OPERATING(*state);
-    struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
-
-    if (unlikely(is_operating && chip->read_reg(dev, SJA_MOD) & SJA_MOD_RM)) {
-	*state = CAN_STATE_STOPPED;
-	is_operating = 0;
-	/* Disable the controller's interrupts */
-	chip->write_reg(dev, SJA_IER, 0x00);
-	/* Wake up waiting senders */
-	rtdm_sem_destroy(&dev->tx_sem);
-    }
+	int is_operating = STATE_OPERATING(*state);
+	struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
+
+	if (unlikely(is_operating && chip->read_reg(dev, SJA_MOD) & SJA_MOD_RM)) {
+		*state = CAN_STATE_STOPPED;
+		is_operating = 0;
+		/* Disable the controller's interrupts */
+		chip->write_reg(dev, SJA_IER, 0x00);
+		/* Wake up waiting senders */
+		rtdm_sem_destroy(&dev->tx_sem);
+	}
 
-    return is_operating;
+	return is_operating;
 }
 
-
 /*
  * Set controller into reset mode.
  *
@@ -415,54 +410,51 @@ static inline int rtcan_sja_is_operating(struct rtcan_device *dev,
 static int rtcan_sja_mode_stop(struct rtcan_device *dev,
 			       rtdm_lockctx_t *lock_ctx)
 {
-    int ret = 0;
-    /* Max. 50 loops busy sleep. If the controller is stopped while in
-     * sleep mode 20-40 loops are needed (tested on PHYTEC eNET). */
-    int wait_loop = 50;
-    can_state_t state;
-    struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
-
-    state = dev->state;
-    /* If controller is not operating anyway, go out */
-    if (STATE_RESET(state))
-	goto out;
-
-    /* Disable the controller's interrupts */
-    chip->write_reg(dev, SJA_IER, 0x00);
-
-    /* Set reset mode bit */
-    chip->write_reg(dev, SJA_MOD, SJA_MOD_RM);
-
-    /* Read reset mode bit, multiple tests */
-    do {
-	if (chip->read_reg(dev, SJA_MOD) & SJA_MOD_RM)
-	    break;
-
-	if (lock_ctx)
-	    rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
-	/* Busy sleep 1 microsecond */
-	rtdm_task_busy_sleep(1000);
-	if (lock_ctx)
-	    rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
-    } while(--wait_loop);
-
-
-    if (wait_loop) {
-	/* Volatile state could have changed while we slept busy. */
-	dev->state = CAN_STATE_STOPPED;
-	/* Wake up waiting senders */
-	rtdm_sem_destroy(&dev->tx_sem);
-    } else {
-	ret = -EAGAIN;
-	/* Enable interrupts again as we did not succeed */
-	chip->write_reg(dev, SJA_IER, SJA1000_IER);
-    }
-
- out:
-    return ret;
-}
+	int ret = 0;
+	/* Max. 50 loops busy sleep. If the controller is stopped while in
+	 * sleep mode 20-40 loops are needed (tested on PHYTEC eNET). */
+	int wait_loop = 50;
+	can_state_t state;
+	struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
+
+	state = dev->state;
+	/* If controller is not operating anyway, go out */
+	if (STATE_RESET(state))
+		goto out;
 
+	/* Disable the controller's interrupts */
+	chip->write_reg(dev, SJA_IER, 0x00);
 
+	/* Set reset mode bit */
+	chip->write_reg(dev, SJA_MOD, SJA_MOD_RM);
+
+	/* Read reset mode bit, multiple tests */
+	do {
+		if (chip->read_reg(dev, SJA_MOD) & SJA_MOD_RM)
+			break;
+
+		if (lock_ctx)
+			rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
+		/* Busy sleep 1 microsecond */
+		rtdm_task_busy_sleep(1000);
+		if (lock_ctx)
+			rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
+	} while (--wait_loop);
+
+	if (wait_loop) {
+		/* Volatile state could have changed while we slept busy. */
+		dev->state = CAN_STATE_STOPPED;
+		/* Wake up waiting senders */
+		rtdm_sem_destroy(&dev->tx_sem);
+	} else {
+		ret = -EAGAIN;
+		/* Enable interrupts again as we did not succeed */
+		chip->write_reg(dev, SJA_IER, SJA1000_IER);
+	}
+
+out:
+	return ret;
+}
 
 /*
  * Set controller into operating mode.
@@ -474,366 +466,358 @@ static int rtcan_sja_mode_stop(struct rtcan_device *dev,
 static int rtcan_sja_mode_start(struct rtcan_device *dev,
 				rtdm_lockctx_t *lock_ctx)
 {
-    int ret = 0;
-    u8 mod_reg;
-    struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
-
-    /* We won't forget that state in the device structure is volatile and
-     * access to it will not be optimized by the compiler. So ... */
-
-    mod_reg = 0;
-    if (dev->ctrl_mode & CAN_CTRLMODE_LISTENONLY)
-	mod_reg |= SJA_MOD_LOM;
-    if (dev->ctrl_mode & CAN_CTRLMODE_LOOPBACK)
-	mod_reg |= SJA_MOD_STM;
-
-    switch (dev->state) {
-
-    case CAN_STATE_ACTIVE:
-    case CAN_STATE_BUS_WARNING:
-    case CAN_STATE_BUS_PASSIVE:
-	break;
-
-    case CAN_STATE_STOPPED:
-	/* Clear error counters */
-	chip->write_reg(dev, SJA_RXERR , 0);
-	chip->write_reg(dev, SJA_TXERR , 0);
-	/* Clear error code capture (i.e. read it) */
-	chip->read_reg(dev, SJA_ECC);
-	/* Set error active state */
-	dev->state = CAN_STATE_ACTIVE;
-	/* Set up sender "mutex" */
-	rtdm_sem_init(&dev->tx_sem, 1);
-	/* Enable interrupts */
-	chip->write_reg(dev, SJA_IER, SJA1000_IER);
-
-	/* Clear reset mode bit in SJA1000 */
-	chip->write_reg(dev, SJA_MOD, mod_reg);
-
-	break;
-
-    case CAN_STATE_SLEEPING:
-	/* Trigger Wake-up interrupt */
-	chip->write_reg(dev, SJA_MOD, mod_reg);
-
-	/* Ok, coming from sleep mode is problematic. We have to wait
-	 * for the SJA1000 to get on both feet again. */
-	rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
-	rtdm_task_busy_sleep(110000);
-	rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
-
-	/* Meanwhile, the Wake-up interrupt was serviced and has set the
-	 * right state. As we don't want to set it back jump out. */
-	goto out;
-
-	break;
-
-    case CAN_STATE_BUS_OFF:
-	/* Trigger bus-off recovery */
-	chip->write_reg(dev, SJA_MOD, mod_reg);
-	/* Set up sender "mutex" */
-	rtdm_sem_init(&dev->tx_sem, 1);
-	/* Set error active state */
-	dev->state = CAN_STATE_ACTIVE;
-
-	break;
+	int ret = 0;
+	u8 mod_reg;
+	struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
+
+	/* We won't forget that state in the device structure is volatile and
+	 * access to it will not be optimized by the compiler. So ... */
+
+	mod_reg = 0;
+	if (dev->ctrl_mode & CAN_CTRLMODE_LISTENONLY)
+		mod_reg |= SJA_MOD_LOM;
+	if (dev->ctrl_mode & CAN_CTRLMODE_LOOPBACK)
+		mod_reg |= SJA_MOD_STM;
+
+	switch (dev->state) {
+
+	case CAN_STATE_ACTIVE:
+	case CAN_STATE_BUS_WARNING:
+	case CAN_STATE_BUS_PASSIVE:
+		break;
+
+	case CAN_STATE_STOPPED:
+		/* Clear error counters */
+		chip->write_reg(dev, SJA_RXERR, 0);
+		chip->write_reg(dev, SJA_TXERR, 0);
+		/* Clear error code capture (i.e. read it) */
+		chip->read_reg(dev, SJA_ECC);
+		/* Set error active state */
+		dev->state = CAN_STATE_ACTIVE;
+		/* Set up sender "mutex" */
+		rtdm_sem_init(&dev->tx_sem, 1);
+		/* Enable interrupts */
+		chip->write_reg(dev, SJA_IER, SJA1000_IER);
+
+		/* Clear reset mode bit in SJA1000 */
+		chip->write_reg(dev, SJA_MOD, mod_reg);
+
+		break;
+
+	case CAN_STATE_SLEEPING:
+		/* Trigger Wake-up interrupt */
+		chip->write_reg(dev, SJA_MOD, mod_reg);
+
+		/* Ok, coming from sleep mode is problematic. We have to wait
+		 * for the SJA1000 to get on both feet again. */
+		rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
+		rtdm_task_busy_sleep(110000);
+		rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
+
+		/* Meanwhile, the Wake-up interrupt was serviced and has set the
+		 * right state. As we don't want to set it back jump out. */
+		goto out;
+
+		break;
+
+	case CAN_STATE_BUS_OFF:
+		/* Trigger bus-off recovery */
+		chip->write_reg(dev, SJA_MOD, mod_reg);
+		/* Set up sender "mutex" */
+		rtdm_sem_init(&dev->tx_sem, 1);
+		/* Set error active state */
+		dev->state = CAN_STATE_ACTIVE;
+
+		break;
 
-    default:
-	/* Never reached, but we don't want nasty compiler warnings ... */
-	break;
-    }
+	default:
+		/* Never reached, but we don't want nasty compiler warnings ... */
+		break;
+	}
 
- out:
-    return ret;
+out:
+	return ret;
 }
 
 can_state_t rtcan_sja_get_state(struct rtcan_device *dev)
 {
-    can_state_t state = dev->state;
-    rtcan_sja_is_operating(dev, &state);
-    return state;
+	can_state_t state = dev->state;
+	rtcan_sja_is_operating(dev, &state);
+	return state;
 }
 
 int rtcan_sja_set_mode(struct rtcan_device *dev,
-		       can_mode_t mode,
-		       rtdm_lockctx_t *lock_ctx)
+		       can_mode_t mode, rtdm_lockctx_t *lock_ctx)
 {
-    int ret = 0;
-    can_state_t state;
-    struct rtcan_sja1000 *chip = (struct rtcan_sja1000*)dev->priv;
+	int ret = 0;
+	can_state_t state;
+	struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
 
-    switch (mode) {
+	switch (mode) {
 
-    case CAN_MODE_STOP:
-	ret = rtcan_sja_mode_stop(dev, lock_ctx);
-	break;
+	case CAN_MODE_STOP:
+		ret = rtcan_sja_mode_stop(dev, lock_ctx);
+		break;
 
-    case CAN_MODE_START:
-	ret = rtcan_sja_mode_start(dev, lock_ctx);
-	break;
+	case CAN_MODE_START:
+		ret = rtcan_sja_mode_start(dev, lock_ctx);
+		break;
 
-    case CAN_MODE_SLEEP:
+	case CAN_MODE_SLEEP:
 
-	state = dev->state;
+		state = dev->state;
 
-	/* Controller must operate, otherwise go out */
-	if (!rtcan_sja_is_operating(dev, &state)) {
-	    ret = -ENETDOWN;
-	    goto mode_sleep_out;
-	}
+		/* Controller must operate, otherwise go out */
+		if (!rtcan_sja_is_operating(dev, &state)) {
+			ret = -ENETDOWN;
+			goto mode_sleep_out;
+		}
 
-	/* Is controller sleeping yet? If yes, go out */
-	if (state == CAN_STATE_SLEEPING)
-	    goto mode_sleep_out;
+		/* Is controller sleeping yet? If yes, go out */
+		if (state == CAN_STATE_SLEEPING)
+			goto mode_sleep_out;
 
-	/* Remember into which state to return when we
-	 * wake up */
-	dev->state_before_sleep = state;
+		/* Remember into which state to return when we
+		 * wake up */
+		dev->state_before_sleep = state;
 
-	/* Let's take a nap. (Now I REALLY understand
-	 * the meaning of interrupts ...) */
-	state = CAN_STATE_SLEEPING;
-	chip->write_reg(dev, SJA_MOD,
-			chip->read_reg(dev, SJA_MOD) | SJA_MOD_SM);
+		/* Let's take a nap. (Now I REALLY understand
+		 * the meaning of interrupts ...) */
+		state = CAN_STATE_SLEEPING;
+		chip->write_reg(dev, SJA_MOD,
+				chip->read_reg(dev, SJA_MOD) | SJA_MOD_SM);
 
-    mode_sleep_out:
-	dev->state = state;
-	break;
+mode_sleep_out:
+		dev->state = state;
+		break;
 
-    default:
-	ret = -EOPNOTSUPP;
-	break;
-    }
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
 
-    return ret;
+	return ret;
 }
 
 int rtcan_sja_set_bit_time(struct rtcan_device *dev,
 			   struct can_bittime *bit_time,
 			   rtdm_lockctx_t *lock_ctx)
 {
-    struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
-    u8 btr0, btr1;
-
-    switch (bit_time->type) {
-    case CAN_BITTIME_BTR:
-	btr0 = bit_time->btr.btr0;
-	btr1 = bit_time->btr.btr1;
-	break;
-
-    case CAN_BITTIME_STD:
-	btr0 = (BTR0_SET_BRP(bit_time->std.brp) |
-		BTR0_SET_SJW(bit_time->std.sjw));
-	btr1 = (BTR1_SET_TSEG1(bit_time->std.prop_seg +
-			       bit_time->std.phase_seg1) |
-		BTR1_SET_TSEG2(bit_time->std.phase_seg2) |
-		BTR1_SET_SAM(bit_time->std.sam));
-
-	break;
-
-    default:
-	return -EINVAL;
-    }
-
-    printk("%s: btr0=%#x btr1=%#x\n", __func__, btr0, btr1);
-    chip->write_reg(dev, SJA_BTR0, btr0);
-    chip->write_reg(dev, SJA_BTR1, btr1);
-
-    return 0;
+	struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
+	u8 btr0, btr1;
+
+	switch (bit_time->type) {
+	case CAN_BITTIME_BTR:
+		btr0 = bit_time->btr.btr0;
+		btr1 = bit_time->btr.btr1;
+		break;
+
+	case CAN_BITTIME_STD:
+		btr0 = (BTR0_SET_BRP(bit_time->std.brp) |
+			BTR0_SET_SJW(bit_time->std.sjw));
+		btr1 = (BTR1_SET_TSEG1(bit_time->std.prop_seg +
+				       bit_time->std.phase_seg1) |
+			BTR1_SET_TSEG2(bit_time->std.phase_seg2) |
+			BTR1_SET_SAM(bit_time->std.sam));
+
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	printk("%s: btr0=%#x btr1=%#x\n", __func__, btr0, btr1);
+	chip->write_reg(dev, SJA_BTR0, btr0);
+	chip->write_reg(dev, SJA_BTR1, btr1);
+
+	return 0;
 }
 
 void rtcan_sja_enable_bus_err(struct rtcan_device *dev)
 {
-    struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
+	struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
 
-    if (chip->bus_err_on < 2) {
-	if (chip->bus_err_on < 1)
-	    chip->read_reg(dev, SJA_ECC);
-	chip->bus_err_on = 2;
-    }
+	if (chip->bus_err_on < 2) {
+		if (chip->bus_err_on < 1)
+			chip->read_reg(dev, SJA_ECC);
+		chip->bus_err_on = 2;
+	}
 }
 
 /*
  *  Start a transmission to a SJA1000 device
  */
-static int rtcan_sja_start_xmit(struct rtcan_device *dev,
-				can_frame_t *frame)
+static int rtcan_sja_start_xmit(struct rtcan_device *dev, can_frame_t *frame)
 {
-    int             i;
-    /* "Real" size of the payload */
-    u8   size;
-    /* Content of frame information register */
-    u8   fir;
-    struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
-
-    /* Get DLC */
-    fir  = frame->can_dlc;
-
-    /* If DLC exceeds 8 bytes adjust it to 8 (for the payload) */
-    size = (fir > 8) ? 8 : fir;
-
-
-    if (frame->can_id & CAN_EFF_FLAG) {
-	/* Send extended frame */
-	fir |= SJA_FIR_EFF;
-
-	/* Write ID */
-	chip->write_reg(dev, SJA_ID1, frame->can_id >> 21);
-	chip->write_reg(dev, SJA_ID2, frame->can_id >> 13);
-	chip->write_reg(dev, SJA_ID3, frame->can_id >> 5);
-	chip->write_reg(dev, SJA_ID4, frame->can_id << 3);
+	int i;
+	/* "Real" size of the payload */
+	u8 size;
+	/* Content of frame information register */
+	u8 fir;
+	struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
+
+	/* Get DLC */
+	fir = frame->can_dlc;
+
+	/* If DLC exceeds 8 bytes adjust it to 8 (for the payload) */
+	size = (fir > 8) ? 8 : fir;
+
+	if (frame->can_id & CAN_EFF_FLAG) {
+		/* Send extended frame */
+		fir |= SJA_FIR_EFF;
+
+		/* Write ID */
+		chip->write_reg(dev, SJA_ID1, frame->can_id >> 21);
+		chip->write_reg(dev, SJA_ID2, frame->can_id >> 13);
+		chip->write_reg(dev, SJA_ID3, frame->can_id >> 5);
+		chip->write_reg(dev, SJA_ID4, frame->can_id << 3);
+
+		/* RTR? */
+		if (frame->can_id & CAN_RTR_FLAG)
+			fir |= SJA_FIR_RTR;
+
+		else {
+			/* No RTR, write data bytes */
+			for (i = 0; i < size; i++)
+				chip->write_reg(dev, SJA_DATA_EFF(i),
+						frame->data[i]);
+		}
 
-	/* RTR? */
-	if (frame->can_id & CAN_RTR_FLAG)
-	    fir |= SJA_FIR_RTR;
-
-	else {
-	    /* No RTR, write data bytes */
-	    for (i = 0; i < size; i++)
-		chip->write_reg(dev, SJA_DATA_EFF(i),
-				frame->data[i]);
-	}
+	} else {
+		/* Send standard frame */
 
-    } else {
-	/* Send standard frame */
+		/* Write ID */
+		chip->write_reg(dev, SJA_ID1, frame->can_id >> 3);
+		chip->write_reg(dev, SJA_ID2, frame->can_id << 5);
 
-	/* Write ID */
-	chip->write_reg(dev, SJA_ID1, frame->can_id >> 3);
-	chip->write_reg(dev, SJA_ID2, frame->can_id << 5);
+		/* RTR? */
+		if (frame->can_id & CAN_RTR_FLAG)
+			fir |= SJA_FIR_RTR;
 
-	/* RTR? */
-	if (frame->can_id & CAN_RTR_FLAG)
-	    fir |= SJA_FIR_RTR;
-
-	else {
-	    /* No RTR, write data bytes */
-	    for (i = 0; i < size; i++)
-		chip->write_reg(dev, SJA_DATA_SFF(i),
-				frame->data[i]);
+		else {
+			/* No RTR, write data bytes */
+			for (i = 0; i < size; i++)
+				chip->write_reg(dev, SJA_DATA_SFF(i),
+						frame->data[i]);
+		}
 	}
-    }
-
 
-    /* Write frame information register */
-    chip->write_reg(dev, SJA_FIR, fir);
+	/* Write frame information register */
+	chip->write_reg(dev, SJA_FIR, fir);
 
-    /* Push the 'send' button */
-    if (dev->ctrl_mode & CAN_CTRLMODE_LOOPBACK)
-	chip->write_reg(dev, SJA_CMR, SJA_CMR_SRR);
-    else
-	chip->write_reg(dev, SJA_CMR, SJA_CMR_TR);
+	/* Push the 'send' button */
+	if (dev->ctrl_mode & CAN_CTRLMODE_LOOPBACK)
+		chip->write_reg(dev, SJA_CMR, SJA_CMR_SRR);
+	else
+		chip->write_reg(dev, SJA_CMR, SJA_CMR_TR);
 
-    return 0;
+	return 0;
 }
 
-
-
 /*
  *  SJA1000 chip configuration
  */
 static void sja1000_chip_config(struct rtcan_device *dev)
 {
-    struct rtcan_sja1000 *chip = (struct rtcan_sja1000* )dev->priv;
+	struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
 
-    chip->write_reg(dev, SJA_CDR, chip->cdr);
-    chip->write_reg(dev, SJA_OCR, chip->ocr);
+	chip->write_reg(dev, SJA_CDR, chip->cdr);
+	chip->write_reg(dev, SJA_OCR, chip->ocr);
 
-    chip->write_reg(dev, SJA_AMR0, 0xFF);
-    chip->write_reg(dev, SJA_AMR1, 0xFF);
-    chip->write_reg(dev, SJA_AMR2, 0xFF);
-    chip->write_reg(dev, SJA_AMR3, 0xFF);
+	chip->write_reg(dev, SJA_AMR0, 0xFF);
+	chip->write_reg(dev, SJA_AMR1, 0xFF);
+	chip->write_reg(dev, SJA_AMR2, 0xFF);
+	chip->write_reg(dev, SJA_AMR3, 0xFF);
 }
 
-
 int rtcan_sja1000_register(struct rtcan_device *dev)
 {
-    int                         ret;
-    struct rtcan_sja1000 *chip = dev->priv;
-
-    if (chip == NULL)
-	return -EINVAL;
-
-    /* Set dummy state for following call */
-    dev->state = CAN_STATE_ACTIVE;
-    /* Enter reset mode */
-    rtcan_sja_mode_stop(dev, NULL);
-
-    if ((chip->read_reg(dev, SJA_SR) &
-	 (SJA_SR_RBS | SJA_SR_DOS | SJA_SR_TBS)) != SJA_SR_TBS) {
-	printk("ERROR! No SJA1000 device found!\n");
-	return -ENODEV;
-    }
-
-    dev->ctrl_name = sja_ctrl_name;
-
-    dev->hard_start_xmit = rtcan_sja_start_xmit;
-    dev->do_set_mode = rtcan_sja_set_mode;
-    dev->do_get_state = rtcan_sja_get_state;
-    dev->do_set_bit_time = rtcan_sja_set_bit_time;
-    dev->do_enable_bus_err = rtcan_sja_enable_bus_err;
+	int ret;
+	struct rtcan_sja1000 *chip = dev->priv;
+
+	if (chip == NULL)
+		return -EINVAL;
+
+	/* Set dummy state for following call */
+	dev->state = CAN_STATE_ACTIVE;
+	/* Enter reset mode */
+	rtcan_sja_mode_stop(dev, NULL);
+
+	if ((chip->read_reg(dev, SJA_SR) &
+	     (SJA_SR_RBS | SJA_SR_DOS | SJA_SR_TBS)) != SJA_SR_TBS) {
+		printk("ERROR! No SJA1000 device found!\n");
+		return -ENODEV;
+	}
+
+	dev->ctrl_name = sja_ctrl_name;
+
+	dev->hard_start_xmit = rtcan_sja_start_xmit;
+	dev->do_set_mode = rtcan_sja_set_mode;
+	dev->do_get_state = rtcan_sja_get_state;
+	dev->do_set_bit_time = rtcan_sja_set_bit_time;
+	dev->do_enable_bus_err = rtcan_sja_enable_bus_err;
 #ifndef CONFIG_XENO_DRIVERS_CAN_CALC_BITTIME_OLD
-    dev->bittiming_const = &sja1000_bittiming_const;
+	dev->bittiming_const = &sja1000_bittiming_const;
 #endif
 
-    chip->bus_err_on = 1;
+	chip->bus_err_on = 1;
 
-    ret = rtdm_irq_request(&dev->irq_handle,
-			   chip->irq_num, rtcan_sja_interrupt,
-			   chip->irq_flags, sja_ctrl_name, dev);
-    if (ret) {
-	printk(KERN_ERR "ERROR %d: IRQ %d is %s!\n",
-	       ret, chip->irq_num, ret == -EBUSY ?
-	       "busy, check shared interrupt support" : "invalid");
-	return ret;
-    }
+	ret = rtdm_irq_request(&dev->irq_handle,
+			       chip->irq_num, rtcan_sja_interrupt,
+			       chip->irq_flags, sja_ctrl_name, dev);
+	if (ret) {
+		printk(KERN_ERR "ERROR %d: IRQ %d is %s!\n",
+		       ret, chip->irq_num, ret == -EBUSY ?
+		       "busy, check shared interrupt support" : "invalid");
+		return ret;
+	}
 
-    sja1000_chip_config(dev);
+	sja1000_chip_config(dev);
 
-    /* Register RTDM device */
-    ret = rtcan_dev_register(dev);
-    if (ret) {
-	    printk(KERN_ERR
-		   "ERROR %d while trying to register RTCAN device!\n", ret);
-	goto out_irq_free;
-    }
+	/* Register RTDM device */
+	ret = rtcan_dev_register(dev);
+	if (ret) {
+		printk(KERN_ERR
+		       "ERROR %d while trying to register RTCAN device!\n",
+		       ret);
+		goto out_irq_free;
+	}
 
-    rtcan_sja_create_proc(dev);
+	rtcan_sja_create_proc(dev);
 
-    return 0;
+	return 0;
 
- out_irq_free:
-    rtdm_irq_free(&dev->irq_handle);
+out_irq_free:
+	rtdm_irq_free(&dev->irq_handle);
 
-    return ret;
+	return ret;
 }
-
+EXPORT_SYMBOL_GPL(rtcan_sja1000_register);
 
 /* Cleanup module */
 void rtcan_sja1000_unregister(struct rtcan_device *dev)
 {
-    printk("Unregistering SJA1000 device %s\n", dev->name);
+	printk("Unregistering SJA1000 device %s\n", dev->name);
 
-    rtdm_irq_disable(&dev->irq_handle);
-    rtcan_sja_mode_stop(dev, NULL);
-    rtdm_irq_free(&dev->irq_handle);
-    rtcan_sja_remove_proc(dev);
-    rtcan_dev_unregister(dev);
+	rtdm_irq_disable(&dev->irq_handle);
+	rtcan_sja_mode_stop(dev, NULL);
+	rtdm_irq_free(&dev->irq_handle);
+	rtcan_sja_remove_proc(dev);
+	rtcan_dev_unregister(dev);
 }
+EXPORT_SYMBOL_GPL(rtcan_sja1000_unregister);
 
 int __init rtcan_sja_init(void)
 {
-    printk("RTCAN SJA1000 driver initialized\n");
-    return 0;
+	printk("RTCAN SJA1000 driver initialized\n");
+	return 0;
 }
 
-
 void __exit rtcan_sja_exit(void)
 {
-    printk("%s removed\n", sja_ctrl_name);
+	printk("%s removed\n", sja_ctrl_name);
 }
 
 module_init(rtcan_sja_init);
 module_exit(rtcan_sja_exit);
 
-EXPORT_SYMBOL_GPL(rtcan_sja1000_register);
-EXPORT_SYMBOL_GPL(rtcan_sja1000_unregister);
diff --git a/ksrc/drivers/can/sja1000/rtcan_sja1000.h b/ksrc/drivers/can/sja1000/rtcan_sja1000.h
index 7565b99..4912564 100644
--- a/ksrc/drivers/can/sja1000/rtcan_sja1000.h
+++ b/ksrc/drivers/can/sja1000/rtcan_sja1000.h
@@ -23,20 +23,20 @@
 #include <rtcan_dev.h>
 
 struct rtcan_sja1000 {
-    unsigned char (*read_reg)(struct rtcan_device *dev, int off);
-    void (*write_reg)(struct rtcan_device *dev, int off, unsigned char val);
-    void (*irq_ack)(struct rtcan_device *dev);
-    unsigned short irq_num;
-    unsigned short irq_flags;
-    unsigned char ocr;
-    unsigned char cdr;
-    char bus_err_on;
+	unsigned char (*read_reg) (struct rtcan_device *dev, int off);
+	void (*write_reg) (struct rtcan_device *dev, int off,
+			   unsigned char val);
+	void (*irq_ack) (struct rtcan_device *dev);
+	unsigned short irq_num;
+	unsigned short irq_flags;
+	unsigned char ocr;
+	unsigned char cdr;
+	char bus_err_on;
 };
 
-int rtcan_sja_create_proc(struct rtcan_device* dev);
-void rtcan_sja_remove_proc(struct rtcan_device* dev);
+int rtcan_sja_create_proc(struct rtcan_device *dev);
+void rtcan_sja_remove_proc(struct rtcan_device *dev);
 int rtcan_sja1000_register(struct rtcan_device *dev);
 void rtcan_sja1000_unregister(struct rtcan_device *dev);
 
-
-#endif  /* __SJA1000_H_ */
+#endif /* __SJA1000_H_ */
diff --git a/ksrc/drivers/can/sja1000/rtcan_sja1000_regs.h b/ksrc/drivers/can/sja1000/rtcan_sja1000_regs.h
index f02d23b..c11f0e7 100644
--- a/ksrc/drivers/can/sja1000/rtcan_sja1000_regs.h
+++ b/ksrc/drivers/can/sja1000/rtcan_sja1000_regs.h
@@ -26,180 +26,178 @@
 #ifndef __SJA1000_REGS_H_
 #define __SJA1000_REGS_H_
 
-
 /* PeliCAN mode address map */
 
 /* reset and operating mode */
-#define SJA_MOD          0       /* Mode register                   */
-#define SJA_CMR          1       /* Command register                */
-#define SJA_SR           2       /* Status register                 */
-#define SJA_IR           3       /* Interrupt register              */
-#define SJA_IER          4       /* Interrupt enable register       */
-#define SJA_BTR0         6       /* Bus timing register 0           */
-#define SJA_BTR1         7       /* Bus timing register 1           */
-#define SJA_OCR          8       /* Output control register         */
-#define SJA_ALC         11       /* Arbitration lost capture        */
-#define SJA_ECC         12       /* Error code capture register     */
-#define SJA_RXERR       14       /* Receive error counter           */
-#define SJA_TXERR       15       /* Transmit error counter          */
-#define SJA_CDR         31       /* Clock divider register          */
+#define SJA_MOD          0	/* Mode register                   */
+#define SJA_CMR          1	/* Command register                */
+#define SJA_SR           2	/* Status register                 */
+#define SJA_IR           3	/* Interrupt register              */
+#define SJA_IER          4	/* Interrupt enable register       */
+#define SJA_BTR0         6	/* Bus timing register 0           */
+#define SJA_BTR1         7	/* Bus timing register 1           */
+#define SJA_OCR          8	/* Output control register         */
+#define SJA_ALC         11	/* Arbitration lost capture        */
+#define SJA_ECC         12	/* Error code capture register     */
+#define SJA_RXERR       14	/* Receive error counter           */
+#define SJA_TXERR       15	/* Transmit error counter          */
+#define SJA_CDR         31	/* Clock divider register          */
 
 /* reset mode */
-#define SJA_ACR0        16       /* Acceptance code register 0      */
-#define SJA_ACR1        17       /* Acceptance code register 1      */
-#define SJA_ACR2        18       /* Acceptance code register 2      */
-#define SJA_ACR3        19       /* Acceptance code register 3      */
-#define SJA_AMR0        20       /* Acceptance mask register 0      */
-#define SJA_AMR1        21       /* Acceptance mask register 1      */
-#define SJA_AMR2        22       /* Acceptance mask register 2      */
-#define SJA_AMR3        23       /* Acceptance mask register 3      */
+#define SJA_ACR0        16	/* Acceptance code register 0      */
+#define SJA_ACR1        17	/* Acceptance code register 1      */
+#define SJA_ACR2        18	/* Acceptance code register 2      */
+#define SJA_ACR3        19	/* Acceptance code register 3      */
+#define SJA_AMR0        20	/* Acceptance mask register 0      */
+#define SJA_AMR1        21	/* Acceptance mask register 1      */
+#define SJA_AMR2        22	/* Acceptance mask register 2      */
+#define SJA_AMR3        23	/* Acceptance mask register 3      */
 
 /* operating mode */
-#define SJA_FIR         16       /* Frame information register      */
-#define SJA_ID1         17       /* Identifier 1                    */
-#define SJA_ID2         18       /* Identifier 2                    */
-#define SJA_ID3         19       /* Identifier 3 (EFF only)         */
-#define SJA_ID4         20       /* Identifier 4 (EFF only)         */
+#define SJA_FIR         16	/* Frame information register      */
+#define SJA_ID1         17	/* Identifier 1                    */
+#define SJA_ID2         18	/* Identifier 2                    */
+#define SJA_ID3         19	/* Identifier 3 (EFF only)         */
+#define SJA_ID4         20	/* Identifier 4 (EFF only)         */
 
-#define SJA_DATA_SFF(x) (19 + (x)) /* Data registers in case of standard
-				    * frame format; 0 <= x <= 7 */
-#define SJA_DATA_EFF(x) (21 + (x)) /* Data registers in case of extended
-				    * frame format; 0 <= x <= 7 */
+#define SJA_DATA_SFF(x) (19 + (x))	/* Data registers in case of standard
+					 * frame format; 0 <= x <= 7 */
+#define SJA_DATA_EFF(x) (21 + (x))	/* Data registers in case of extended
+					 * frame format; 0 <= x <= 7 */
 
 /* Mode register */
 enum SJA1000_PELI_MOD {
-    SJA_MOD_RM           = 1,    /* Reset Mode                          */
-    SJA_MOD_LOM          = 1<<1, /* Listen Only Mode                    */
-    SJA_MOD_STM          = 1<<2, /* Self Test Mode                      */
-    SJA_MOD_AFM          = 1<<3, /* Acceptance Filter Mode              */
-    SJA_MOD_SM           = 1<<4  /* Sleep Mode                          */
+	SJA_MOD_RM = 1,		/* Reset Mode                          */
+	SJA_MOD_LOM = 1 << 1,	/* Listen Only Mode                    */
+	SJA_MOD_STM = 1 << 2,	/* Self Test Mode                      */
+	SJA_MOD_AFM = 1 << 3,	/* Acceptance Filter Mode              */
+	SJA_MOD_SM = 1 << 4	/* Sleep Mode                          */
 };
 
 /* Command register */
 enum SJA1000_PELI_CMR {
-    SJA_CMR_TR  = 1,             /* Transmission request                */
-    SJA_CMR_AT  = 1<<1,          /* Abort Transmission                  */
-    SJA_CMR_RRB = 1<<2,          /* Release Receive Buffer              */
-    SJA_CMR_CDO = 1<<3,          /* Clear Data Overrun                  */
-    SJA_CMR_SRR = 1<<4           /* Self reception request              */
+	SJA_CMR_TR = 1,		/* Transmission request                */
+	SJA_CMR_AT = 1 << 1,	/* Abort Transmission                  */
+	SJA_CMR_RRB = 1 << 2,	/* Release Receive Buffer              */
+	SJA_CMR_CDO = 1 << 3,	/* Clear Data Overrun                  */
+	SJA_CMR_SRR = 1 << 4	/* Self reception request              */
 };
 
 /* Status register */
 enum SJA1000_PELI_SR {
-    SJA_SR_RBS           = 1,    /* Receive Buffer Status               */
-    SJA_SR_DOS           = 1<<1, /* Data Overrun Status                 */
-    SJA_SR_TBS           = 1<<2, /* Transmit Buffer Status              */
-    SJA_SR_ES            = 1<<6, /* Error Status                        */
-    SJA_SR_BS            = 1<<7  /* Bus Status                          */
+	SJA_SR_RBS = 1,		/* Receive Buffer Status               */
+	SJA_SR_DOS = 1 << 1,	/* Data Overrun Status                 */
+	SJA_SR_TBS = 1 << 2,	/* Transmit Buffer Status              */
+	SJA_SR_ES = 1 << 6,	/* Error Status                        */
+	SJA_SR_BS = 1 << 7	/* Bus Status                          */
 };
 
 /* Interrupt register */
 enum SJA1000_PELI_IR {
-    SJA_IR_RI           = 1,     /* Receive Interrupt                   */
-    SJA_IR_TI           = 1<<1,  /* Transmit Interrupt                  */
-    SJA_IR_EI           = 1<<2,  /* Error Warning Interrupt             */
-    SJA_IR_DOI          = 1<<3,  /* Data Overrun Interrupt              */
-    SJA_IR_WUI          = 1<<4,  /* Wake-Up Interrupt                   */
-    SJA_IR_EPI          = 1<<5,  /* Error Passive Interrupt             */
-    SJA_IR_ALI          = 1<<6,  /* Arbitration Lost Interrupt          */
-    SJA_IR_BEI          = 1<<7,  /* Bus Error Interrupt                 */
+	SJA_IR_RI = 1,		/* Receive Interrupt                   */
+	SJA_IR_TI = 1 << 1,	/* Transmit Interrupt                  */
+	SJA_IR_EI = 1 << 2,	/* Error Warning Interrupt             */
+	SJA_IR_DOI = 1 << 3,	/* Data Overrun Interrupt              */
+	SJA_IR_WUI = 1 << 4,	/* Wake-Up Interrupt                   */
+	SJA_IR_EPI = 1 << 5,	/* Error Passive Interrupt             */
+	SJA_IR_ALI = 1 << 6,	/* Arbitration Lost Interrupt          */
+	SJA_IR_BEI = 1 << 7,	/* Bus Error Interrupt                 */
 };
 
 /* Interrupt enable register */
 enum SJA1000_PELI_IER {
-    SJA_IER_RIE         = 1,     /* Receive Interrupt Enable            */
-    SJA_IER_TIE         = 1<<1,  /* Transmit Interrupt Enable           */
-    SJA_IER_EIE         = 1<<2,  /* Error Warning Interrupt Enable      */
-    SJA_IER_DOIE        = 1<<3,  /* Data Overrun Interrupt Enable       */
-    SJA_IER_WUIE        = 1<<4,  /* Wake-Up Interrupt Enable            */
-    SJA_IER_EPIE        = 1<<5,  /* Error Passive Interrupt Enable      */
-    SJA_IER_ALIE        = 1<<6,  /* Arbitration Lost Interrupt Enable   */
-    SJA_IER_BEIE        = 1<<7,  /* Bus Error Interrupt Enable          */
+	SJA_IER_RIE = 1,	/* Receive Interrupt Enable            */
+	SJA_IER_TIE = 1 << 1,	/* Transmit Interrupt Enable           */
+	SJA_IER_EIE = 1 << 2,	/* Error Warning Interrupt Enable      */
+	SJA_IER_DOIE = 1 << 3,	/* Data Overrun Interrupt Enable       */
+	SJA_IER_WUIE = 1 << 4,	/* Wake-Up Interrupt Enable            */
+	SJA_IER_EPIE = 1 << 5,	/* Error Passive Interrupt Enable      */
+	SJA_IER_ALIE = 1 << 6,	/* Arbitration Lost Interrupt Enable   */
+	SJA_IER_BEIE = 1 << 7,	/* Bus Error Interrupt Enable          */
 };
 
 /* Bus timing register 0 */
 enum SJA1000_PELI_BTR0 {
-    /* Period of the CAN system clock t_SCl
-     * (t_CLK = time period of XTAL frequency) */
-    SJA_BTR0_T_SCL_2_T_CLK  = 0,    /* t_SCl = 2 x t_CLK                 */
-    SJA_BTR0_T_SCL_4_T_CLK  = 1,    /* t_SCl = 4 x t_CLK                 */
-    SJA_BTR0_T_SCL_6_T_CLK  = 2,    /* t_SCl = 6 x t_CLK                 */
-    SJA_BTR0_T_SCL_8_T_CLK  = 3,    /* t_SCl = 8 x t_CLK                 */
-    SJA_BTR0_T_SCL_10_T_CLK = 4,    /* t_SCl = 10 x t_CLK                */
-    SJA_BTR0_T_SCL_12_T_CLK = 5,    /* t_SCl = 12 x t_CLK                */
-    SJA_BTR0_T_SCL_14_T_CLK = 6,    /* t_SCl = 14 x t_CLK                */
-    SJA_BTR0_T_SCL_16_T_CLK = 7,    /* t_SCl = 16 x t_CLK                */
-    SJA_BTR0_T_SCL_20_T_CLK = 9,    /* t_SCl = 20 x t_CLK                */
-    SJA_BTR0_T_SCL_40_T_CLK = 19,   /* t_SCl = 40 x t_CLK                */
-    SJA_BTR0_T_SCL_100_T_CLK = 49,  /* t_SCl = 100 x t_CLK               */
+	/* Period of the CAN system clock t_SCl
+	 * (t_CLK = time period of XTAL frequency) */
+	SJA_BTR0_T_SCL_2_T_CLK = 0,	/* t_SCl = 2 x t_CLK                 */
+	SJA_BTR0_T_SCL_4_T_CLK = 1,	/* t_SCl = 4 x t_CLK                 */
+	SJA_BTR0_T_SCL_6_T_CLK = 2,	/* t_SCl = 6 x t_CLK                 */
+	SJA_BTR0_T_SCL_8_T_CLK = 3,	/* t_SCl = 8 x t_CLK                 */
+	SJA_BTR0_T_SCL_10_T_CLK = 4,	/* t_SCl = 10 x t_CLK                */
+	SJA_BTR0_T_SCL_12_T_CLK = 5,	/* t_SCl = 12 x t_CLK                */
+	SJA_BTR0_T_SCL_14_T_CLK = 6,	/* t_SCl = 14 x t_CLK                */
+	SJA_BTR0_T_SCL_16_T_CLK = 7,	/* t_SCl = 16 x t_CLK                */
+	SJA_BTR0_T_SCL_20_T_CLK = 9,	/* t_SCl = 20 x t_CLK                */
+	SJA_BTR0_T_SCL_40_T_CLK = 19,	/* t_SCl = 40 x t_CLK                */
+	SJA_BTR0_T_SCL_100_T_CLK = 49,	/* t_SCl = 100 x t_CLK               */
 
 };
 
 /* Bus timing register 1 */
 enum SJA1000_PELI_BTR1 {
-    /* Time segment 1 */
-    SJA_BTR1_T_SEG1_1_T_SCL = 0,    /* t_SEG1 = 1 x t_SCl               */
-    SJA_BTR1_T_SEG1_2_T_SCL = 1,    /* t_SEG1 = 2 x t_SCl               */
-    SJA_BTR1_T_SEG1_3_T_SCL = 2,    /* t_SEG1 = 3 x t_SCl               */
-    SJA_BTR1_T_SEG1_4_T_SCL = 3,    /* t_SEG1 = 4 x t_SCl               */
-    SJA_BTR1_T_SEG1_5_T_SCL = 4,    /* t_SEG1 = 5 x t_SCl               */
-    SJA_BTR1_T_SEG1_6_T_SCL = 5,    /* t_SEG1 = 6 x t_SCl               */
-    SJA_BTR1_T_SEG1_7_T_SCL = 6,    /* t_SEG1 = 7 x t_SCl               */
-    SJA_BTR1_T_SEG1_8_T_SCL = 7,    /* t_SEG1 = 8 x t_SCl               */
-    /* Time segment 2 */
-    SJA_BTR1_T_SEG2_1_T_SCL = 0<<4, /* t_SEG2 = 1 x t_SCl               */
-    SJA_BTR1_T_SEG2_2_T_SCL = 1<<4, /* t_SEG2 = 2 x t_SCl               */
-    SJA_BTR1_T_SEG2_3_T_SCL = 2<<4, /* t_SEG2 = 3 x t_SCl               */
-    SJA_BTR1_T_SEG2_4_T_SCL = 3<<4, /* t_SEG2 = 4 x t_SCl               */
-    SJA_BTR1_T_SEG2_5_T_SCL = 4<<4, /* t_SEG2 = 5 x t_SCl               */
-    SJA_BTR1_T_SEG2_6_T_SCL = 5<<4, /* t_SEG2 = 6 x t_SCl               */
-    SJA_BTR1_T_SEG2_7_T_SCL = 6<<4, /* t_SEG2 = 7 x t_SCl               */
-    SJA_BTR1_T_SEG2_8_T_SCL = 7<<4, /* t_SEG2 = 8 x t_SCl               */
+	/* Time segment 1 */
+	SJA_BTR1_T_SEG1_1_T_SCL = 0,	/* t_SEG1 = 1 x t_SCl               */
+	SJA_BTR1_T_SEG1_2_T_SCL = 1,	/* t_SEG1 = 2 x t_SCl               */
+	SJA_BTR1_T_SEG1_3_T_SCL = 2,	/* t_SEG1 = 3 x t_SCl               */
+	SJA_BTR1_T_SEG1_4_T_SCL = 3,	/* t_SEG1 = 4 x t_SCl               */
+	SJA_BTR1_T_SEG1_5_T_SCL = 4,	/* t_SEG1 = 5 x t_SCl               */
+	SJA_BTR1_T_SEG1_6_T_SCL = 5,	/* t_SEG1 = 6 x t_SCl               */
+	SJA_BTR1_T_SEG1_7_T_SCL = 6,	/* t_SEG1 = 7 x t_SCl               */
+	SJA_BTR1_T_SEG1_8_T_SCL = 7,	/* t_SEG1 = 8 x t_SCl               */
+	/* Time segment 2 */
+	SJA_BTR1_T_SEG2_1_T_SCL = 0 << 4,	/* t_SEG2 = 1 x t_SCl */
+	SJA_BTR1_T_SEG2_2_T_SCL = 1 << 4,	/* t_SEG2 = 2 x t_SCl */
+	SJA_BTR1_T_SEG2_3_T_SCL = 2 << 4,	/* t_SEG2 = 3 x t_SCl */
+	SJA_BTR1_T_SEG2_4_T_SCL = 3 << 4,	/* t_SEG2 = 4 x t_SCl */
+	SJA_BTR1_T_SEG2_5_T_SCL = 4 << 4,	/* t_SEG2 = 5 x t_SCl */
+	SJA_BTR1_T_SEG2_6_T_SCL = 5 << 4,	/* t_SEG2 = 6 x t_SCl */
+	SJA_BTR1_T_SEG2_7_T_SCL = 6 << 4,	/* t_SEG2 = 7 x t_SCl */
+	SJA_BTR1_T_SEG2_8_T_SCL = 7 << 4,	/* t_SEG2 = 8 x t_SCl */
 };
 
 /* One bit time = t_SCl + t_SEG1 + t_SEG2 */
 
-
 /* Output control register */
 enum SJA1000_PELI_OCR {
-    SJA_OCR_MODE_BIPHASE = 0,
-    SJA_OCR_MODE_TEST    = 1,
-    SJA_OCR_MODE_NORMAL  = 2,
-    SJA_OCR_MODE_CLOCK   = 3,
-    SJA_OCR_TX0_INVERT   = 1<<2,
-    SJA_OCR_TX0_PULLDOWN = 1<<3,
-    SJA_OCR_TX0_PULLUP   = 2<<3,
-    SJA_OCR_TX0_PUSHPULL = 3<<3,
-    SJA_OCR_TX1_INVERT   = 1<<5,
-    SJA_OCR_TX1_PULLDOWN = 1<<6,
-    SJA_OCR_TX1_PULLUP   = 2<<6,
-    SJA_OCR_TX1_PUSHPULL = 3<<6
+	SJA_OCR_MODE_BIPHASE = 0,
+	SJA_OCR_MODE_TEST = 1,
+	SJA_OCR_MODE_NORMAL = 2,
+	SJA_OCR_MODE_CLOCK = 3,
+	SJA_OCR_TX0_INVERT = 1 << 2,
+	SJA_OCR_TX0_PULLDOWN = 1 << 3,
+	SJA_OCR_TX0_PULLUP = 2 << 3,
+	SJA_OCR_TX0_PUSHPULL = 3 << 3,
+	SJA_OCR_TX1_INVERT = 1 << 5,
+	SJA_OCR_TX1_PULLDOWN = 1 << 6,
+	SJA_OCR_TX1_PULLUP = 2 << 6,
+	SJA_OCR_TX1_PUSHPULL = 3 << 6
 };
 
 /* Error code capture register */
 enum SJA1000_PELI_ECC {
-    /* The segmentation field gives information about the location of
-     * errors on the bus */
-    SJA_ECC_SEG_MASK     = 31,   /* Segmentation field mask             */
-    SJA_ECC_DIR          = 1<<5, /* Transfer direction                  */
-    SJA_ECC_ERR_BIT      = 0<<6,
-    SJA_ECC_ERR_FORM     = 1<<6,
-    SJA_ECC_ERR_STUFF    = 2<<6,
-    SJA_ECC_ERR_MASK     = 3<<6  /* Error code mask                     */
+	/* The segmentation field gives information about the location of
+	 * errors on the bus */
+	SJA_ECC_SEG_MASK = 31,	/* Segmentation field mask             */
+	SJA_ECC_DIR = 1 << 5,	/* Transfer direction                  */
+	SJA_ECC_ERR_BIT = 0 << 6,
+	SJA_ECC_ERR_FORM = 1 << 6,
+	SJA_ECC_ERR_STUFF = 2 << 6,
+	SJA_ECC_ERR_MASK = 3 << 6	/* Error code mask */
 };
 
 /* Frame information register */
 enum SJA1000_PELI_FIR {
-    SJA_FIR_DLC_MASK     = 15,   /* Data length code mask               */
-    SJA_FIR_RTR          = 1<<6, /* Remote transmission request         */
-    SJA_FIR_EFF          = 1<<7  /* Extended frame format               */
+	SJA_FIR_DLC_MASK = 15,	/* Data length code mask               */
+	SJA_FIR_RTR = 1 << 6,	/* Remote transmission request         */
+	SJA_FIR_EFF = 1 << 7	/* Extended frame format               */
 };
 
 /* Clock divider register */
 enum SJA1000_PELI_CDR {
-    SJA_CDR_CLK_OFF      = 1<<3, /* Clock off (CLKOUT pin)              */
-    SJA_CDR_CBP          = 1<<6, /* CAN input comparator bypass         */
-    SJA_CDR_CAN_MODE     = 1<<7  /* CAN mode: 1 = PeliCAN               */
+	SJA_CDR_CLK_OFF = 1 << 3,	/* Clock off (CLKOUT pin) */
+	SJA_CDR_CBP = 1 << 6,	/* CAN input comparator bypass         */
+	SJA_CDR_CAN_MODE = 1 << 7	/* CAN mode: 1 = PeliCAN */
 };
 
-#endif  /* __SJA1000_REGS_H_ */
+#endif /* __SJA1000_REGS_H_ */
-- 
1.7.9.5


