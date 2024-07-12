Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614E414EC73
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781344; cv=none; b=UvF4LTgPN3eHynVJUOdUypXsKi9LNdgQ1f+zAT2o5Xhpey3wEu6wpCOODUGltuRohTVL3r7RMX3uO5CGbzklhrKAU6r+O5IV9XJaxs9ndGRWUNl69MG+6NYOcak9GGTqgZ1mh1ZreDEu6WuQT/581Yot4C8oG5vjDWeGLgQ5k9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781344; c=relaxed/simple;
	bh=8iyAN2NEvcOE0E/0IZxx1b/VO94xsxuzHILm9VkXhss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ShAZE81e7rYSqKgTibpQToL2Mb0UyvIYfQSVXsC0wz1qM42I5+w76WhMG7/HmpcI0wmDDvEbi9xYRR90XDJ85pCeAHt9X2GFG0yBxRIPt6VLr3I50nu6IOs4jMrpG+znmlLxfv61eWaLzsagFl0Q1RxS7TsV3Omar5IuiHbTThQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=a/VFDdJm; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="a/VFDdJm"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2024071210485809cb7be021be8073af
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:48:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=17lyHJlkq1jdCuTmBeKHYppPDdKv1QTIueEnYTcy2Cc=;
 b=a/VFDdJmXXgkOsKtQH3IFJT14QLgYtAnM3dba7WYRagolYvKa6PVVQqPW/kaBKsGhDGNR0
 MHNgP7xFhBMh36EPJDLRI0fY+IM5inEHJJOOFcsHKbQGjRbIal0yrHS886aA47ZXKcEeSu8c
 /HDRowBMBe08zLT39mi6MwjgIjwUc=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:49:11 +0200
Subject: [PATCH v2 25/33] drivers/via-rhine: Migrate from rtdm_printk() and
 printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-25-facd992606c7@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

In this case only a single printk() call was missing the log level.
Migrating to keep in sync with other drivers.

The missing log level is addressed by migrating to the pr_*() API.

rtdm_printk() itself is just an alias for printk(). Migrating helps to
remove this function once all drivers were updated.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/drivers/via-rhine.c | 184 +++++++++++++++++----------------
 1 file changed, 94 insertions(+), 90 deletions(-)

diff --git a/kernel/drivers/net/drivers/via-rhine.c b/kernel/drivers/net/drivers/via-rhine.c
index 8407ab54a..9b6a40188 100644
--- a/kernel/drivers/net/drivers/via-rhine.c
+++ b/kernel/drivers/net/drivers/via-rhine.c
@@ -122,6 +122,7 @@
 #define DRV_VERSION	"1.1.17-RTnet-0.1"
 #define DRV_RELDATE	"2003-10-05"
 
+#define pr_fmt(fmt) DRV_NAME ": " fmt
 
 /* A few user-configurable values.
    These may be modified when a driver module is loaded. */
@@ -216,8 +217,8 @@ MODULE_PARM_DESC(cards, "array of cards to be supported (e.g. 1,0,1)");
 /*** RTnet ***/
 
 /* These identify the driver base version and may not be removed. */
-static char version[] =
-KERN_INFO DRV_NAME ".c:" DRV_VERSION "  " DRV_RELDATE "  Jan.Kiszka@web.de\n";
+static char version[] = DRV_NAME ".c:" DRV_VERSION "  " DRV_RELDATE
+				 "  Jan.Kiszka@web.de\n";
 
 static char shortname[] = DRV_NAME;
 
@@ -581,8 +582,7 @@ static void wait_for_reset(struct rtnet_device *dev, int chip_id, char *name) /*
 	IOSYNC;
 
 	if (readw(ioaddr + ChipCmd) & CmdReset) {
-		printk(KERN_INFO "%s: Reset not complete yet. "
-			"Trying harder.\n", name);
+		pr_info("%s: Reset not complete yet. Trying harder.\n", name);
 
 		/* Rhine-II needs to be forced sometimes */
 		if (chip_id == VT6102)
@@ -596,7 +596,7 @@ static void wait_for_reset(struct rtnet_device *dev, int chip_id, char *name) /*
 	}
 
 	if (local_debug > 1)
-		printk(KERN_INFO "%s: Reset %s.\n", name,
+		pr_info("%s: Reset %s.\n", name,
 			boguscnt ? "succeeded" : "failed");
 }
 
@@ -645,7 +645,7 @@ static int via_rhine_init_one (struct pci_dev *pdev,
 #ifndef MODULE
 	static int printed_version;
 	if (!printed_version++)
-		printk(version);
+		pr_info("%s", version);
 #endif
 
 	card_idx++;
@@ -663,14 +663,14 @@ static int via_rhine_init_one (struct pci_dev *pdev,
 
 	/* this should always be supported */
 	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(32))) {
-		printk(KERN_ERR "32-bit PCI DMA addresses not supported by the card!?\n");
+		pr_err("32-bit PCI DMA addresses not supported by the card!?\n");
 		goto err_out;
 	}
 
 	/* sanity check */
 	if ((pci_resource_len (pdev, 0) < io_size) ||
 	    (pci_resource_len (pdev, 1) < io_size)) {
-		printk (KERN_ERR "Insufficient PCI resources, aborting\n");
+		pr_err("Insufficient PCI resources, aborting\n");
 		goto err_out;
 	}
 
@@ -684,7 +684,7 @@ static int via_rhine_init_one (struct pci_dev *pdev,
 	dev = rt_alloc_etherdev(sizeof(struct netdev_private),
 							RX_RING_SIZE * 2 + TX_RING_SIZE);
 	if (dev == NULL) {
-		printk (KERN_ERR "init_ethernet failed for card #%d\n", card_idx);
+		pr_err("init_ethernet failed for card #%d\n", card_idx);
 		goto err_out;
 	}
 	rtdev_alloc_name(dev, "rteth%d");
@@ -702,8 +702,8 @@ static int via_rhine_init_one (struct pci_dev *pdev,
 
 	ioaddr = ioremap (memaddr, io_size);
 	if (!ioaddr) {
-		printk (KERN_ERR "ioremap failed for device %s, region 0x%X @ 0x%lX\n",
-				pci_name(pdev), io_size, memaddr);
+		pr_err("ioremap failed for device %s, region 0x%X @ 0x%lX\n",
+		       pci_name(pdev), io_size, memaddr);
 		goto err_out_free_res;
 	}
 
@@ -714,8 +714,8 @@ static int via_rhine_init_one (struct pci_dev *pdev,
 		unsigned char a = inb(ioaddr0+reg);
 		unsigned char b = readb(ioaddr+reg);
 		if (a != b) {
-			printk (KERN_ERR "MMIO do not match PIO [%02x] (%02x != %02x)\n",
-					reg, a, b);
+			pr_err("MMIO do not match PIO [%02x] (%02x != %02x)\n",
+			       reg, a, b);
 			goto err_out_unmap;
 		}
 	}
@@ -760,7 +760,7 @@ static int via_rhine_init_one (struct pci_dev *pdev,
 		dev->dev_addr[i] = readb(ioaddr + StationAddr + i);
 
 	if (!is_valid_ether_addr(dev->dev_addr)) {
-		printk(KERN_ERR "Invalid MAC address for card #%d\n", card_idx);
+		pr_err("Invalid MAC address for card #%d\n", card_idx);
 		goto err_out_unmap;
 	}
 
@@ -828,18 +828,17 @@ static int via_rhine_init_one (struct pci_dev *pdev,
 		np->mii_if.full_duplex = 1;
 
 	if (np->mii_if.full_duplex) {
-		printk(KERN_INFO "%s: Set to forced full duplex, autonegotiation"
-			   " disabled.\n", dev->name);
+		pr_info("%s: Set to forced full duplex, autonegotiation "
+			"disabled.\n", dev->name);
 		np->mii_if_force_media = 1; /*** RTnet ***/
 	}
 
-	printk(KERN_INFO "%s: %s at 0x%lx, ",
-		   dev->name, via_rhine_chip_info[chip_id].name,
-		   (pci_flags & PCI_USES_IO) ? (long)ioaddr : memaddr);
-
-	for (i = 0; i < 5; i++)
-			printk("%2.2x:", dev->dev_addr[i]);
-	printk("%2.2x, IRQ %d.\n", dev->dev_addr[i], pdev->irq);
+	pr_info("%s: %s at 0x%lx, %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x, IRQ %d. \n",
+		dev->name, via_rhine_chip_info[chip_id].name,
+		(pci_flags & PCI_USES_IO) ? (long)ioaddr : memaddr,
+		dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
+		dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5],
+		pdev->irq);
 
 	pci_set_drvdata(pdev, dev);
 
@@ -851,10 +850,11 @@ static int via_rhine_init_one (struct pci_dev *pdev,
 			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
 				np->phys[phy_idx++] = phy;
 				np->mii_if.advertising = mdio_read(dev, phy, 4);
-				printk(KERN_INFO "%s: MII PHY found at address %d, status "
-					   "0x%4.4x advertising %4.4x Link %4.4x.\n",
-					   dev->name, phy, mii_status, np->mii_if.advertising,
-					   mdio_read(dev, phy, 5));
+				pr_info("%s: MII PHY found at address %d, status "
+					"0x%4.4x advertising %4.4x Link %4.4x.\n",
+					dev->name, phy, mii_status,
+					np->mii_if.advertising,
+					mdio_read(dev, phy, 5));
 
 				/* set IFF_RUNNING */
 				if (mii_status & BMSR_LSTATUS)
@@ -875,9 +875,9 @@ static int via_rhine_init_one (struct pci_dev *pdev,
 		if (np->default_port & 0x330) {
 			/* FIXME: shouldn't someone check this variable? */
 			/* np->medialock = 1; */
-			printk(KERN_INFO "  Forcing %dMbs %s-duplex operation.\n",
-				   (option & 0x300 ? 100 : 10),
-				   (option & 0x220 ? "full" : "half"));
+			pr_info("  Forcing %dMbs %s-duplex operation.\n",
+				(option & 0x300 ? 100 : 10),
+				(option & 0x220 ? "full" : "half"));
 			if (np->mii_cnt)
 				mdio_write(dev, np->phys[0], MII_BMCR,
 						   ((option & 0x300) ? 0x2000 : 0) |  /* 100mbps? */
@@ -913,7 +913,7 @@ static int alloc_ring(struct rtnet_device* dev) /*** RTnet ***/
 				  TX_RING_SIZE * sizeof(struct tx_desc),
 				  &ring_dma, GFP_ATOMIC);
 	if (!ring) {
-		printk(KERN_ERR "Could not allocate DMA memory.\n");
+		pr_err("Could not allocate DMA memory.\n");
 		return -ENOMEM;
 	}
 	if (np->drv_flags & ReqTxAlign) {
@@ -1170,8 +1170,8 @@ static int via_rhine_open(struct rtnet_device *dev) /*** RTnet ***/
 	}
 
 	if (local_debug > 1)
-		printk(KERN_DEBUG "%s: via_rhine_open() irq %d.\n",
-			   dev->name, np->pdev->irq);
+		pr_debug("%s: via_rhine_open() irq %d.\n", dev->name,
+			 np->pdev->irq);
 
 	i = alloc_ring(dev);
 	if (i) {
@@ -1182,10 +1182,10 @@ static int via_rhine_open(struct rtnet_device *dev) /*** RTnet ***/
 	wait_for_reset(dev, np->chip_id, dev->name);
 	init_registers(dev);
 	if (local_debug > 2)
-		printk(KERN_DEBUG "%s: Done via_rhine_open(), status %4.4x "
-			   "MII status: %4.4x.\n",
-			   dev->name, readw(ioaddr + ChipCmd),
-			   mdio_read(dev, np->phys[0], MII_BMSR));
+		pr_debug("%s: Done via_rhine_open(), status %4.4x "
+			 "MII status: %4.4x.\n",
+			 dev->name, readw(ioaddr + ChipCmd),
+			 mdio_read(dev, np->phys[0], MII_BMSR));
 
 	rtnetif_start_queue(dev); /*** RTnet ***/
 
@@ -1210,9 +1210,10 @@ static void via_rhine_check_duplex(struct rtnet_device *dev) /*** RTnet ***/
 	if (np->mii_if.full_duplex != duplex) {
 		np->mii_if.full_duplex = duplex;
 		if (local_debug)
-			printk(KERN_INFO "%s: Setting %s-duplex based on MII #%d link"
-				   " partner capability of %4.4x.\n", dev->name,
-				   duplex ? "full" : "half", np->phys[0], mii_lpa);
+			pr_info("%s: Setting %s-duplex based on MII #%d link"
+				" partner capability of %4.4x.\n",
+				dev->name, duplex ? "full" : "half",
+				np->phys[0], mii_lpa);
 		if (duplex)
 			np->chip_cmd |= CmdFDuplex;
 		else
@@ -1327,8 +1328,8 @@ static int via_rhine_start_tx(struct rtskb *skb, struct rtnet_device *dev) /***
 /*** RTnet ***/
 
 	if (local_debug > 4) {
-		rtdm_printk(KERN_DEBUG "%s: Transmit frame #%d queued in slot %d.\n", /*** RTnet ***/
-			   dev->name, np->cur_tx-1, entry);
+		pr_debug("%s: Transmit frame #%d queued in slot %d.\n", /*** RTnet ***/
+			 dev->name, np->cur_tx-1, entry);
 	}
 	return 0;
 }
@@ -1359,8 +1360,8 @@ static int via_rhine_interrupt(rtdm_irq_t *irq_handle) /*** RTnet ***/
 		ret = RTDM_IRQ_HANDLED;
 
 		if (local_debug > 4)
-			rtdm_printk(KERN_DEBUG "%s: Interrupt, status %8.8x.\n", /*** RTnet ***/
-				   dev->name, intr_status);
+			pr_debug("%s: Interrupt, status %8.8x.\n", /*** RTnet ***/
+				 dev->name, intr_status);
 
 		if (intr_status & (IntrRxDone | IntrRxErr | IntrRxDropped |
 						   IntrRxWakeUp | IntrRxEmpty | IntrRxNoBuf))
@@ -1369,7 +1370,7 @@ static int via_rhine_interrupt(rtdm_irq_t *irq_handle) /*** RTnet ***/
 		if (intr_status & (IntrTxErrSummary | IntrTxDone)) {
 			if (intr_status & IntrTxErrSummary) {
 /*** RTnet ***/
-				rtdm_printk(KERN_ERR "%s: via_rhine_interrupt(), Transmissions error\n", dev->name);
+				pr_err("%s: via_rhine_interrupt(), Transmissions error\n", dev->name);
 /*** RTnet ***/
 			}
 			via_rhine_tx(dev);
@@ -1382,16 +1383,16 @@ static int via_rhine_interrupt(rtdm_irq_t *irq_handle) /*** RTnet ***/
 			via_rhine_error(dev, intr_status);
 
 		if (--boguscnt < 0) {
-			rtdm_printk(KERN_WARNING "%s: Too much work at interrupt, " /*** RTnet ***/
-				   "status=%#8.8x.\n",
-				   dev->name, intr_status);
+			pr_warn("%s: Too much work at interrupt, " /*** RTnet ***/
+				"status=%#8.8x.\n",
+				dev->name, intr_status);
 			break;
 		}
 	}
 
 	if (local_debug > 3)
-		rtdm_printk(KERN_DEBUG "%s: exiting interrupt, status=%8.8x.\n", /*** RTnet ***/
-			   dev->name, readw((void *)ioaddr + IntrStatus));
+		pr_debug("%s: exiting interrupt, status=%8.8x.\n", /*** RTnet ***/
+			 dev->name, readw((void *)ioaddr + IntrStatus));
 
 /*** RTnet ***/
 	if (old_packet_cnt != np->stats.rx_packets)
@@ -1412,14 +1413,14 @@ static void via_rhine_tx(struct rtnet_device *dev) /*** RTnet ***/
 	while (np->dirty_tx != np->cur_tx) {
 		txstatus = le32_to_cpu(np->tx_ring[entry].tx_status);
 		if (local_debug > 6)
-			rtdm_printk(KERN_DEBUG " Tx scavenge %d status %8.8x.\n", /*** RTnet ***/
-				   entry, txstatus);
+			pr_debug(" Tx scavenge %d status %8.8x.\n", /*** RTnet ***/
+				 entry, txstatus);
 		if (txstatus & DescOwn)
 			break;
 		if (txstatus & 0x8000) {
 			if (local_debug > 1)
-				rtdm_printk(KERN_DEBUG "%s: Transmit error, Tx status %8.8x.\n", /*** RTnet ***/
-					   dev->name, txstatus);
+				pr_debug("%s: Transmit error, Tx status %8.8x.\n", /*** RTnet ***/
+					 dev->name, txstatus);
 			np->stats.tx_errors++;
 			if (txstatus & 0x0400) np->stats.tx_carrier_errors++;
 			if (txstatus & 0x0200) np->stats.tx_window_errors++;
@@ -1438,9 +1439,9 @@ static void via_rhine_tx(struct rtnet_device *dev) /*** RTnet ***/
 			else
 				np->stats.collisions += txstatus & 0x0F;
 			if (local_debug > 6)
-				rtdm_printk(KERN_DEBUG "collisions: %1.1x:%1.1x\n", /*** RTnet ***/
-					(txstatus >> 3) & 0xF,
-					txstatus & 0xF);
+				pr_debug("collisions: %1.1x:%1.1x\n", /*** RTnet ***/
+					 (txstatus >> 3) & 0xF,
+					 txstatus & 0xF);
 			np->stats.tx_bytes += np->tx_skbuff[entry]->len;
 			np->stats.tx_packets++;
 		}
@@ -1470,8 +1471,8 @@ static void via_rhine_rx(struct rtnet_device *dev, nanosecs_abs_t *time_stamp) /
 	int boguscnt = np->dirty_rx + RX_RING_SIZE - np->cur_rx;
 
 	if (local_debug > 4) {
-		rtdm_printk(KERN_DEBUG "%s: via_rhine_rx(), entry %d status %8.8x.\n", /*** RTnet ***/
-			   dev->name, entry, le32_to_cpu(np->rx_head_desc->rx_status));
+		pr_debug("%s: via_rhine_rx(), entry %d status %8.8x.\n", /*** RTnet ***/
+			 dev->name, entry, le32_to_cpu(np->rx_head_desc->rx_status));
 	}
 
 	/* If EOP is set on the next entry, it's a new packet. Send it up. */
@@ -1481,23 +1482,25 @@ static void via_rhine_rx(struct rtnet_device *dev, nanosecs_abs_t *time_stamp) /
 		int data_size = desc_status >> 16;
 
 		if (local_debug > 4)
-			rtdm_printk(KERN_DEBUG "  via_rhine_rx() status is %8.8x.\n", /*** RTnet ***/
-				   desc_status);
+			pr_debug("  via_rhine_rx() status is %8.8x.\n", /*** RTnet ***/
+				 desc_status);
 		if (--boguscnt < 0)
 			break;
 		if ( (desc_status & (RxWholePkt | RxErr)) !=  RxWholePkt) {
 			if ((desc_status & RxWholePkt) !=  RxWholePkt) {
-				rtdm_printk(KERN_WARNING "%s: Oversized Ethernet frame spanned " /*** RTnet ***/
-					   "multiple buffers, entry %#x length %d status %8.8x!\n",
-					   dev->name, entry, data_size, desc_status);
-				rtdm_printk(KERN_WARNING "%s: Oversized Ethernet frame %p vs %p.\n", /*** RTnet ***/
-					   dev->name, np->rx_head_desc, &np->rx_ring[entry]);
+				pr_warn("%s: Oversized Ethernet frame spanned " /*** RTnet ***/
+					"multiple buffers, entry %#x length %d status %8.8x!\n",
+					dev->name, entry, data_size,
+					desc_status);
+				pr_warn("%s: Oversized Ethernet frame %p vs %p.\n", /*** RTnet ***/
+					dev->name, np->rx_head_desc,
+					&np->rx_ring[entry]);
 				np->stats.rx_length_errors++;
 			} else if (desc_status & RxErr) {
 				/* There was a error. */
 				if (local_debug > 2)
-					rtdm_printk(KERN_DEBUG "  via_rhine_rx() Rx error was %8.8x.\n", /*** RTnet ***/
-						   desc_status);
+					pr_debug("  via_rhine_rx() Rx error was %8.8x.\n", /*** RTnet ***/
+						 desc_status);
 				np->stats.rx_errors++;
 				if (desc_status & 0x0030) np->stats.rx_length_errors++;
 				if (desc_status & 0x0048) np->stats.rx_fifo_errors++;
@@ -1518,8 +1521,8 @@ static void via_rhine_rx(struct rtnet_device *dev, nanosecs_abs_t *time_stamp) /
 /*** RTnet ***/
 				skb = np->rx_skbuff[entry];
 				if (skb == NULL) {
-					rtdm_printk(KERN_ERR "%s: Inconsistent Rx descriptor chain.\n", /*** RTnet ***/
-						   dev->name);
+					pr_err("%s: Inconsistent Rx descriptor chain.\n", /*** RTnet ***/
+					       dev->name);
 					break;
 				}
 				np->rx_skbuff[entry] = NULL;
@@ -1599,9 +1602,9 @@ static void via_rhine_restart_tx(struct rtnet_device *dev) { /*** RTnet ***/
 	else {
 		/* This should never happen */
 		if (local_debug > 1)
-			rtdm_printk(KERN_WARNING "%s: via_rhine_restart_tx() " /*** RTnet ***/
-				   "Another error occured %8.8x.\n",
-				   dev->name, intr_status);
+			pr_warn("%s: via_rhine_restart_tx() " /*** RTnet ***/
+				"Another error occured %8.8x.\n",
+				dev->name, intr_status);
 	}
 
 }
@@ -1621,10 +1624,11 @@ static void via_rhine_error(struct rtnet_device *dev, int intr_status) /*** RTne
 		} else
 			via_rhine_check_duplex(dev);
 		if (local_debug)
-			rtdm_printk(KERN_ERR "%s: MII status changed: Autonegotiation " /*** RTnet ***/
-				   "advertising %4.4x  partner %4.4x.\n", dev->name,
-			   mdio_read(dev, np->phys[0], MII_ADVERTISE),
-			   mdio_read(dev, np->phys[0], MII_LPA));
+			pr_err("%s: MII status changed: Autonegotiation " /*** RTnet ***/
+			       "advertising %4.4x  partner %4.4x.\n",
+			       dev->name,
+			       mdio_read(dev, np->phys[0], MII_ADVERTISE),
+			       mdio_read(dev, np->phys[0], MII_LPA));
 	}
 	if (intr_status & IntrStatsMax) {
 		np->stats.rx_crc_errors	+= readw(ioaddr + RxCRCErrs);
@@ -1633,21 +1637,21 @@ static void via_rhine_error(struct rtnet_device *dev, int intr_status) /*** RTne
 	}
 	if (intr_status & IntrTxAborted) {
 		if (local_debug > 1)
-			rtdm_printk(KERN_INFO "%s: Abort %8.8x, frame dropped.\n", /*** RTnet ***/
+			pr_info("%s: Abort %8.8x, frame dropped.\n", /*** RTnet ***/
 				   dev->name, intr_status);
 	}
 	if (intr_status & IntrTxUnderrun) {
 		if (np->tx_thresh < 0xE0)
 			writeb(np->tx_thresh += 0x20, ioaddr + TxConfig);
 		if (local_debug > 1)
-			rtdm_printk(KERN_INFO "%s: Transmitter underrun, Tx " /*** RTnet ***/
-				   "threshold now %2.2x.\n",
-				   dev->name, np->tx_thresh);
+			pr_info("%s: Transmitter underrun, Tx " /*** RTnet ***/
+				"threshold now %2.2x.\n",
+				dev->name, np->tx_thresh);
 	}
 	if (intr_status & IntrTxDescRace) {
 		if (local_debug > 2)
-			rtdm_printk(KERN_INFO "%s: Tx descriptor write-back race.\n", /*** RTnet ***/
-				   dev->name);
+			pr_info("%s: Tx descriptor write-back race.\n", /*** RTnet ***/
+				dev->name);
 	}
 	if ((intr_status & IntrTxError) && ~( IntrTxAborted | IntrTxUnderrun |
 		IntrTxDescRace )) {
@@ -1655,7 +1659,7 @@ static void via_rhine_error(struct rtnet_device *dev, int intr_status) /*** RTne
 			writeb(np->tx_thresh += 0x20, ioaddr + TxConfig);
 		}
 		if (local_debug > 1)
-			rtdm_printk(KERN_INFO "%s: Unspecified error. Tx " /*** RTnet ***/
+			pr_info("%s: Unspecified error. Tx " /*** RTnet ***/
 				"threshold now %2.2x.\n",
 				dev->name, np->tx_thresh);
 	}
@@ -1667,8 +1671,8 @@ static void via_rhine_error(struct rtnet_device *dev, int intr_status) /*** RTne
 						 IntrTxError | IntrTxAborted | IntrNormalSummary |
 						 IntrTxDescRace )) {
 		if (local_debug > 1)
-			rtdm_printk(KERN_ERR "%s: Something Wicked happened! %8.8x.\n", /*** RTnet ***/
-				   dev->name, intr_status);
+			pr_err("%s: Something Wicked happened! %8.8x.\n", /*** RTnet ***/
+			       dev->name, intr_status);
 	}
 
 	rtdm_lock_put(&np->lock); /*** RTnet ***/
@@ -1698,7 +1702,7 @@ static void via_rhine_set_rx_mode(struct rtnet_device *dev) /*** RTnet ***/
 
 	if (dev->flags & IFF_PROMISC) {			/* Set promiscuous. */
 		/* Unconditionally log net taps. */
-		printk(KERN_NOTICE "%s: Promiscuous mode enabled.\n", dev->name);
+		pr_notice("%s: Promiscuous mode enabled.\n", dev->name);
 		rx_mode = 0x1C;
 		writel(0xffffffff, (void *)ioaddr + MulticastFilter0);
 		writel(0xffffffff, (void *)ioaddr + MulticastFilter1);
@@ -1735,8 +1739,8 @@ static int via_rhine_close(struct rtnet_device *dev) /*** RTnet ***/
 	rtnetif_stop_queue(dev); /*** RTnet ***/
 
 	if (local_debug > 1)
-		rtdm_printk(KERN_DEBUG "%s: Shutting down ethercard, status was %4.4x.\n", /*** RTnet ***/
-			   dev->name, readw((void *)ioaddr + ChipCmd));
+		pr_debug("%s: Shutting down ethercard, status was %4.4x.\n", /*** RTnet ***/
+			 dev->name, readw((void *)ioaddr + ChipCmd));
 
 	/* Switch to loopback mode to avoid hardware races. */
 	writeb(np->tx_thresh | 0x02, (void *)ioaddr + TxConfig);
@@ -1797,7 +1801,7 @@ static int __init via_rhine_init (void)
 {
 /* when a module, this is printed whether or not devices are found in probe */
 #ifdef MODULE
-	printk(version);
+	pr_info("%s", version);
 #endif
 	return pci_register_driver (&via_rhine_driver);
 }

-- 
2.39.2

