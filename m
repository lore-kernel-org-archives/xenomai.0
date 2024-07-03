Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C631D17A5A3
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013152; cv=none; b=U2JTBUdw53qtEQpE22pPND8ehUa2/gPB0vR4Ch3qe1lWfTmO5WB52tNcV1SArk3IuKin5gov32l/EyAfXj7CSHcv+As4rnCejogcNpjuosmw0IXd1EQDiJc4TfU6aYB93+IBgyOPIencymBgNGEf7aO/Mk4XV2RvhAGjFEt1M/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013152; c=relaxed/simple;
	bh=uuupb9p+Z/C3HxC/MRpM65VFSrhHuWCX3ztn/wq+KoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5/lWO4USDuJVPGrarq3U4P3ZD0U5zrmu9msSBtersq5JmI+d+/I60qOFtfE5aIBzo9QfgZraFvH/SgQzGgeP8fYsakvgFfmgrTNJ6r8+HWn2LWR6MMoZUZxPfuCVOpLMRnRVwzfkRXAdQ7VTAmzluJK5fpRbjUiT5eWAzLQovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=wA4UfUiq; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="wA4UfUiq"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202407031325444ad919cf83986a2b47
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Pi3AwW3f+Ol1D9L+sXAIzhohDtUmQaWneMuhzmy3v/M=;
 b=wA4UfUiqzpm9fkGIl5E6KbRAqjCaafEwnQ193hOCXiRI/w2YWV4tSXwlrpNL7ELyn5gQd5
 r3L6Dw3S44dE7Jj4pup5hiuGi+bmlbw0dzsWtaXS3wAE0RvzSYigLVtoZw/jSLWnS/YgCqAY
 T1rzoofI+2yGSf5p48ME/qmJQY8vE=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:39 +0200
Subject: [PATCH 16/33] drivers/eepro100: Migrate from rtdm_printk() and
 printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-16-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

A few (rtdm_)printk() calls were missing log level information. The
default log level (= warn) did not fit well for them.

The missing log level is addressed by migrating the pr_*() API.

rtdm_printk() itself is just an alias for printk(). Migrating helps to
remove this function once all drivers were updated.

No functional change.

While at it: rt_wait_for_cmd_done() has been reformatted to match
current coding style.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/drivers/eepro100.c | 235 ++++++++++++++++++----------------
 1 file changed, 123 insertions(+), 112 deletions(-)

diff --git a/kernel/drivers/net/drivers/eepro100.c b/kernel/drivers/net/drivers/eepro100.c
index 1985befe7..e88989446 100644
--- a/kernel/drivers/net/drivers/eepro100.c
+++ b/kernel/drivers/net/drivers/eepro100.c
@@ -29,6 +29,8 @@
 		Ported to RTnet (RTAI version)
 */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 static const char *version =
 "eepro100-rt.c:1.36-RTnet-0.8 2002-2006 Jan Kiszka <Jan.Kiszka@web.de>\n"
 "eepro100-rt.c: based on eepro100.c 1.36 by D. Becker, A. V. Savochkin and others\n";
@@ -321,26 +323,27 @@ static inline void wait_for_cmd_done(long cmd_ioaddr)
 	while(inb(cmd_ioaddr) && --wait >= 0);
 #ifdef CONFIG_XENO_DRIVERS_NET_DRV_EEPRO100_DBG
 	if (wait < 0)
-		printk(KERN_ALERT "eepro100: wait_for_cmd_done timeout!\n");
+		pr_alert("eepro100: wait_for_cmd_done timeout!\n");
 #endif
 }
 
 #ifdef CONFIG_XENO_DRIVERS_NET_DRV_EEPRO100_CMDSTATS
 static inline int rt_wait_for_cmd_done(long cmd_ioaddr, const char *cmd)
 {
-    int wait = CONFIG_XENO_DRIVERS_NET_DRV_EEPRO100_CMDTIMEOUT;
-    rtmd_time_t t0, t1;
-
-    t0 = rtdm_clock_read();
-    while (inb(cmd_ioaddr) != 0) {
-	if (wait-- == 0) {
-	    rtdm_printk(KERN_ALERT "eepro100: rt_wait_for_cmd_done(%s) "
-			"timeout!\n", cmd);
-	    return 1;
+	int wait = CONFIG_XENO_DRIVERS_NET_DRV_EEPRO100_CMDTIMEOUT;
+	rtmd_time_t t0, t1;
+
+	t0 = rtdm_clock_read();
+	while (inb(cmd_ioaddr) != 0) {
+		if (wait-- == 0) {
+			pr_alert(
+				"eepro100: rt_wait_for_cmd_done(%s) timeout!\n",
+				cmd);
+			return 1;
+		}
+		rtdm_task_busy_sleep(1000);
 	}
-	rtdm_task_busy_sleep(1000);
-    }
-    return 0;
+	return 0;
 }
 #else
 static inline int rt_wait_for_cmd_done(long cmd_ioaddr, const char *cmd)
@@ -580,7 +583,7 @@ static int eepro100_init_one (struct pci_dev *pdev,
 
 	static int did_version /* = 0 */;		/* Already printed version info. */
 	if (speedo_debug > 0  &&  did_version++ == 0)
-		printk(version);
+		pr_info("%s", version);
 
 	// *** RTnet ***
 	cards_found++;
@@ -590,12 +593,12 @@ static int eepro100_init_one (struct pci_dev *pdev,
 
 	if (!request_region(pci_resource_start(pdev, 1),
 			pci_resource_len(pdev, 1), "eepro100")) {
-		printk (KERN_ERR "eepro100: cannot reserve I/O ports\n");
+		pr_err("eepro100: cannot reserve I/O ports\n");
 		goto err_out_none;
 	}
 	if (!request_mem_region(pci_resource_start(pdev, 0),
 			pci_resource_len(pdev, 0), "eepro100")) {
-		printk (KERN_ERR "eepro100: cannot reserve MMIO region\n");
+		pr_err("eepro100: cannot reserve MMIO region\n");
 		goto err_out_free_pio_region;
 	}
 
@@ -603,20 +606,20 @@ static int eepro100_init_one (struct pci_dev *pdev,
 #ifdef USE_IO
 	ioaddr = pci_resource_start(pdev, 1);
 	if (speedo_debug > 2)
-		printk("Found Intel i82557 PCI Speedo at I/O %#lx, IRQ %d.\n",
-			   ioaddr, irq);
+		pr_info("Found Intel i82557 PCI Speedo at I/O %#lx, IRQ %d.\n",
+			ioaddr, irq);
 #else
 	ioaddr = (unsigned long)ioremap(pci_resource_start(pdev, 0),
 									pci_resource_len(pdev, 0));
 	if (!ioaddr) {
-		printk(KERN_ERR "eepro100: cannot remap MMIO region %llx @ %llx\n",
+		pr_err("eepro100: cannot remap MMIO region %llx @ %llx\n",
 		       (unsigned long long)pci_resource_len(pdev, 0),
 		       (unsigned long long)pci_resource_start(pdev, 0));
 		goto err_out_free_mmio_region;
 	}
 	if (speedo_debug > 2)
-		printk("Found Intel i82557 PCI Speedo, MMIO at %#llx, IRQ %d.\n",
-		       (unsigned long long)pci_resource_start(pdev, 0), irq);
+		pr_info("Found Intel i82557 PCI Speedo, MMIO at %#llx, IRQ %d.\n",
+			(unsigned long long)pci_resource_start(pdev, 0), irq);
 #endif
 
 	/* save power state b4 pci_enable_device overwrites it */
@@ -674,7 +677,7 @@ static int speedo_found1(struct pci_dev *pdev,
 	rtdev = rt_alloc_etherdev(sizeof(struct speedo_private),
 				RX_RING_SIZE * 2 + TX_RING_SIZE);
 	if (rtdev == NULL) {
-		printk(KERN_ERR "eepro100: Could not allocate ethernet device.\n");
+		pr_err("eepro100: Could not allocate ethernet device.\n");
 		dma_free_coherent(&pdev->dev, size, tx_ring_space, tx_ring_dma);
 		return -1;
 	}
@@ -725,9 +728,9 @@ static int speedo_found1(struct pci_dev *pdev,
 			}
 		}
 		if (sum != 0xBABA)
-			printk(KERN_WARNING "%s: Invalid EEPROM checksum %#4.4x, "
-				   "check settings before activating this device!\n",
-				   rtdev->name, sum);
+			pr_warn("%s: Invalid EEPROM checksum %#4.4x, "
+				"check settings before activating this device!\n",
+				rtdev->name, sum);
 		/* Don't  unregister_netdev(dev);  as the EEPro may actually be
 		   usable, especially if the MAC address is set later.
 		   On the other hand, it may be unusable if MDI data is corrupted. */
@@ -745,15 +748,19 @@ static int speedo_found1(struct pci_dev *pdev,
 	else
 		product = pci_name(pdev);
 
-	printk(KERN_INFO "%s: %s, ", rtdev->name, product);
-
-	for (i = 0; i < 5; i++)
-		printk("%2.2X:", rtdev->dev_addr[i]);
-	printk("%2.2X, ", rtdev->dev_addr[i]);
+	pr_info(
+#ifdef USE_IO
+		"%s: %s, %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X, I/O at %#3lx, IRQ %d\n",
+#else
+		"%s: %s, %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X, IRQ %d\n",
+#endif
+		rtdev->name, product, rtdev->dev_addr[0], rtdev->dev_addr[1],
+		rtdev->dev_addr[2], rtdev->dev_addr[3], rtdev->dev_addr[4],
+		rtdev->dev_addr[5],
 #ifdef USE_IO
-	printk("I/O at %#3lx, ", ioaddr);
+		ioaddr,
 #endif
-	printk("IRQ %d.\n", pdev->irq);
+		pdev->irq);
 
 	outl(PortReset, ioaddr + SCBPort);
 	inl(ioaddr + SCBPort);
@@ -788,9 +795,10 @@ static int speedo_found1(struct pci_dev *pdev,
 		sp->chip_id = 1;
 	}
 
-	if (sp->rx_bug)
-		printk(KERN_ERR "  *** Receiver lock-up bug detected ***\n"
-		       KERN_ERR "  Your device may not work reliably!\n");
+	if (sp->rx_bug) {
+		pr_err("  *** Receiver lock-up bug detected ***\n");
+		pr_err("  Your device may not work reliably!\n");
+	}
 
 	// *** RTnet ***
 	/* The Speedo-specific entries in the device structure. */
@@ -862,7 +870,7 @@ static int mdio_read(long ioaddr, int phy_id, int location)
 	do {
 		val = inl(ioaddr + SCBCtrlMDI);
 		if (--boguscnt < 0) {
-			printk(KERN_ERR " mdio_read() timed out with val = %8.8x.\n", val);
+			pr_err(" mdio_read() timed out with val = %8.8x.\n", val);
 			break;
 		}
 	} while (! (val & 0x10000000));
@@ -878,7 +886,8 @@ speedo_open(struct rtnet_device *rtdev)
 	int retval;
 
 	if (speedo_debug > 1)
-		printk(KERN_DEBUG "%s: speedo_open() irq %d.\n", rtdev->name, rtdev->irq);
+		pr_debug("%s: speedo_open() irq %d.\n", rtdev->name,
+			 rtdev->irq);
 
 	pci_set_power_state(sp->pdev, 0);
 
@@ -927,10 +936,9 @@ speedo_open(struct rtnet_device *rtdev)
 	else
 		rtnetif_carrier_off(rtdev);
 
-	if (speedo_debug > 2) {
-		printk(KERN_DEBUG "%s: Done speedo_open(), status %8.8x.\n",
-			   rtdev->name, inw(ioaddr + SCBStatus));
-	}
+	if (speedo_debug > 2)
+		pr_debug("%s: Done speedo_open(), status %8.8x.\n", rtdev->name,
+			 inw(ioaddr + SCBStatus));
 
 	/* No need to wait for the command unit to accept here. */
 	if ((sp->phy[0] & 0x8000) == 0)
@@ -966,8 +974,8 @@ static void speedo_resume(struct rtnet_device *rtdev)
 
 	if (sp->rx_ringp[sp->cur_rx % RX_RING_SIZE] == NULL) {
 		if (speedo_debug > 2)
-			printk(KERN_DEBUG "%s: NULL cur_rx in speedo_resume().\n",
-					rtdev->name);
+			pr_debug("%s: NULL cur_rx in speedo_resume().\n",
+				 rtdev->name);
 	} else {
 		wait_for_cmd_done(ioaddr + SCBCmd);
 		outl(sp->rx_ring_dma[sp->cur_rx % RX_RING_SIZE],
@@ -1009,25 +1017,26 @@ static void speedo_show_state(struct rtnet_device *rtdev)
 
 	/* Print a few items for debugging. */
 	if (speedo_debug > 0) {
-		printk(KERN_DEBUG "%s: Tx ring dump,  Tx queue %u / %u:\n", rtdev->name,
-			   sp->cur_tx, sp->dirty_tx);
+		pr_debug("%s: Tx ring dump,  Tx queue %u / %u:\n", rtdev->name,
+			 sp->cur_tx, sp->dirty_tx);
 		for (i = 0; i < TX_RING_SIZE; i++)
-			printk(KERN_DEBUG "%s:  %c%c%2d %8.8x.\n", rtdev->name,
-				   i == sp->dirty_tx % TX_RING_SIZE ? '*' : ' ',
-				   i == sp->cur_tx % TX_RING_SIZE ? '=' : ' ',
-				   i, sp->tx_ring[i].status);
+			pr_debug("%s:  %c%c%2d %8.8x.\n", rtdev->name,
+				 i == sp->dirty_tx % TX_RING_SIZE ? '*' : ' ',
+				 i == sp->cur_tx % TX_RING_SIZE ? '=' : ' ', i,
+				 sp->tx_ring[i].status);
 	}
-	printk(KERN_DEBUG "%s: Printing Rx ring"
-		   " (next to receive into %u, dirty index %u).\n",
-		   rtdev->name, sp->cur_rx, sp->dirty_rx);
+	pr_debug("%s: Printing Rx ring"
+		 " (next to receive into %u, dirty index %u).\n",
+		 rtdev->name, sp->cur_rx, sp->dirty_rx);
 
 	for (i = 0; i < RX_RING_SIZE; i++)
-		printk(KERN_DEBUG "%s: %c%c%c%2d %8.8x.\n", rtdev->name,
-			   sp->rx_ringp[i] == sp->last_rxf ? 'l' : ' ',
-			   i == sp->dirty_rx % RX_RING_SIZE ? '*' : ' ',
-			   i == sp->cur_rx % RX_RING_SIZE ? '=' : ' ',
-			   i, (sp->rx_ringp[i] != NULL) ?
-					   (unsigned)sp->rx_ringp[i]->status : 0);
+		pr_debug("%s: %c%c%c%2d %8.8x.\n", rtdev->name,
+			 sp->rx_ringp[i] == sp->last_rxf ? 'l' : ' ',
+			 i == sp->dirty_rx % RX_RING_SIZE ? '*' : ' ',
+			 i == sp->cur_rx % RX_RING_SIZE ? '=' : ' ', i,
+			 (sp->rx_ringp[i] != NULL) ?
+				 (unsigned)sp->rx_ringp[i]->status :
+				 0);
 
 	{
 		long ioaddr = rtdev->base_addr;
@@ -1035,8 +1044,9 @@ static void speedo_show_state(struct rtnet_device *rtdev)
 		for (i = 0; i < 16; i++) {
 			/* FIXME: what does it mean?  --SAW */
 			if (i == 6) i = 21;
-			printk(KERN_DEBUG "%s:  PHY index %d register %d is %4.4x.\n",
-				   rtdev->name, phy_num, i, mdio_read(ioaddr, phy_num, i));
+			pr_debug("%s:  PHY index %d register %d is %4.4x.\n",
+				 rtdev->name, phy_num, i,
+				 mdio_read(ioaddr, phy_num, i));
 		}
 	}
 }
@@ -1121,7 +1131,7 @@ speedo_start_xmit(struct rtskb *skb, struct rtnet_device *rtdev)
 
 		rtdm_lock_put_irqrestore(&sp->lock, context);
 
-		rtdm_printk(KERN_ERR "%s: incorrect tbusy state, fixed.\n", rtdev->name);
+		pr_err("%s: incorrect tbusy state, fixed.\n", rtdev->name);
 		// *** RTnet ***
 
 		return 1;
@@ -1194,15 +1204,16 @@ static void speedo_tx_buffer_gc(struct rtnet_device *rtdev)
 		int status = le32_to_cpu(sp->tx_ring[entry].status);
 
 		if (speedo_debug > 5)
-			printk(KERN_DEBUG " scavenge candidate %d status %4.4x.\n",
-				   entry, status);
+			pr_debug(" scavenge candidate %d status %4.4x.\n",
+				 entry, status);
 		if ((status & StatusComplete) == 0)
 			break;			/* It still hasn't been processed. */
 		if (status & TxUnderrun)
 			if (sp->tx_threshold < 0x01e08000) {
 				if (speedo_debug > 2)
-					printk(KERN_DEBUG "%s: TX underrun, threshold adjusted.\n",
-						   rtdev->name);
+					pr_debug(
+						"%s: TX underrun, threshold adjusted.\n",
+						rtdev->name);
 				sp->tx_threshold += 0x00040000;
 			}
 		/* Free the original skb. */
@@ -1250,10 +1261,10 @@ static int speedo_interrupt(rtdm_irq_t *irq_handle)
 
 #ifdef CONFIG_XENO_DRIVERS_NET_DRV_EEPRO100_DBG
 	/* A lock to prevent simultaneous entry on SMP machines. */
-	if (test_and_set_bit(0, (void*)&sp->in_interrupt)) {
-		rtdm_printk(KERN_ERR"%s: SMP simultaneous entry of an interrupt handler.\n",
-			   rtdev->name);
-		sp->in_interrupt = 0;	/* Avoid halting machine. */
+	if (test_and_set_bit(0, (void *)&sp->in_interrupt)) {
+		pr_err("%s: SMP simultaneous entry of an interrupt handler.\n",
+		       rtdev->name);
+		sp->in_interrupt = 0; /* Avoid halting machine. */
 		return ret;
 	}
 #endif
@@ -1267,8 +1278,8 @@ static int speedo_interrupt(rtdm_irq_t *irq_handle)
 		speedo_write_flush(ioaddr);
 
 		if (speedo_debug > 4)
-			rtdm_printk(KERN_DEBUG "%s: interrupt  status=%#4.4x.\n",
-				   rtdev->name, status);
+			pr_debug("%s: interrupt  status=%#4.4x.\n", rtdev->name,
+				 status);
 
 		if ((status & 0xfc00) == 0)
 			break;
@@ -1287,39 +1298,39 @@ static int speedo_interrupt(rtdm_irq_t *irq_handle)
 			rtdm_lock_get(&sp->lock);
 			if ((status & 0x003c) == 0x0028) {		/* No more Rx buffers. */
 				struct RxFD *rxf;
-				rtdm_printk(KERN_WARNING "%s: card reports no RX buffers.\n",
-						rtdev->name);
+				pr_warn("%s: card reports no RX buffers.\n",
+					rtdev->name);
 				rxf = sp->rx_ringp[sp->cur_rx % RX_RING_SIZE];
 				if (rxf == NULL) {
 					if (speedo_debug > 2)
-						rtdm_printk(KERN_DEBUG
-								"%s: NULL cur_rx in speedo_interrupt().\n",
-								rtdev->name);
+						pr_debug(
+							"%s: NULL cur_rx in speedo_interrupt().\n",
+							rtdev->name);
 					sp->rx_ring_state |= RrNoMem|RrNoResources;
 				} else if (rxf == sp->last_rxf) {
 					if (speedo_debug > 2)
-						rtdm_printk(KERN_DEBUG
-								"%s: cur_rx is last in speedo_interrupt().\n",
-								rtdev->name);
+						pr_debug(
+							"%s: cur_rx is last in speedo_interrupt().\n",
+							rtdev->name);
 					sp->rx_ring_state |= RrNoMem|RrNoResources;
 				} else
 					outb(RxResumeNoResources, ioaddr + SCBCmd);
 			} else if ((status & 0x003c) == 0x0008) { /* No resources. */
 				struct RxFD *rxf;
-				rtdm_printk(KERN_WARNING "%s: card reports no resources.\n",
-						rtdev->name);
+				pr_warn("%s: card reports no resources.\n",
+					rtdev->name);
 				rxf = sp->rx_ringp[sp->cur_rx % RX_RING_SIZE];
 				if (rxf == NULL) {
 					if (speedo_debug > 2)
-						rtdm_printk(KERN_DEBUG
-								"%s: NULL cur_rx in speedo_interrupt().\n",
-								rtdev->name);
+						pr_debug(
+							"%s: NULL cur_rx in speedo_interrupt().\n",
+							rtdev->name);
 					sp->rx_ring_state |= RrNoMem|RrNoResources;
 				} else if (rxf == sp->last_rxf) {
 					if (speedo_debug > 2)
-						rtdm_printk(KERN_DEBUG
-								"%s: cur_rx is last in speedo_interrupt().\n",
-								rtdev->name);
+						pr_debug(
+							"%s: cur_rx is last in speedo_interrupt().\n",
+							rtdev->name);
 					sp->rx_ring_state |= RrNoMem|RrNoResources;
 				} else {
 					/* Restart the receiver. */
@@ -1333,9 +1344,8 @@ static int speedo_interrupt(rtdm_irq_t *irq_handle)
 		}
 
 		if ((sp->rx_ring_state&(RrNoMem|RrNoResources)) == RrNoResources) {
-			rtdm_printk(KERN_WARNING
-					"%s: restart the receiver after a possible hang.\n",
-					rtdev->name);
+			pr_warn("%s: restart the receiver after a possible hang.\n",
+				rtdev->name);
 			rtdm_lock_get(&sp->lock);
 			/* Restart the receiver.
 			   I'm not sure if it's always right to restart the receiver
@@ -1362,8 +1372,8 @@ static int speedo_interrupt(rtdm_irq_t *irq_handle)
 		}
 
 		if (--boguscnt < 0) {
-			rtdm_printk(KERN_ERR "%s: Too much work at interrupt, status=0x%4.4x.\n",
-				   rtdev->name, status);
+			pr_err("%s: Too much work at interrupt, status=0x%4.4x.\n",
+			       rtdev->name, status);
 			/* Clear all interrupt sources. */
 			/* Will change from 0xfc00 to 0xff00 when we start handling
 			   FCP and ER interrupts --Dragan */
@@ -1373,8 +1383,8 @@ static int speedo_interrupt(rtdm_irq_t *irq_handle)
 	} while (1);
 
 	if (speedo_debug > 3)
-		rtdm_printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4x.\n",
-			   rtdev->name, inw(ioaddr + SCBStatus));
+		pr_debug("%s: exiting interrupt, status=%#4.4x.\n", rtdev->name,
+			 inw(ioaddr + SCBStatus));
 
 	clear_bit(0, (void*)&sp->in_interrupt);
 	if (packets > 0)
@@ -1436,8 +1446,8 @@ static int speedo_refill_rx_buf(struct rtnet_device *rtdev, int force)
 			int forw_entry;
 			if (speedo_debug > 2 || !(sp->rx_ring_state & RrOOMReported)) {
 				// *** RTnet ***
-				rtdm_printk(KERN_WARNING "%s: can't fill rx buffer (force %d)!\n",
-						rtdev->name, force);
+				pr_warn("%s: can't fill rx buffer (force %d)!\n",
+					rtdev->name, force);
 				// *** RTnet ***
 				sp->rx_ring_state |= RrOOMReported;
 			}
@@ -1483,7 +1493,7 @@ speedo_rx(struct rtnet_device *rtdev, int* packets, nanosecs_abs_t *time_stamp)
 	int alloc_ok = 1;
 
 	if (speedo_debug > 4)
-		rtdm_printk(KERN_DEBUG " In speedo_rx().\n");
+		pr_debug(" In speedo_rx().\n");
 	/* If we own the next entry, it's a new packet. Send it up. */
 	while (sp->rx_ringp[entry] != NULL) {
 		int status;
@@ -1506,25 +1516,26 @@ speedo_rx(struct rtnet_device *rtdev, int* packets, nanosecs_abs_t *time_stamp)
 			/* Postpone the packet.  It'll be reaped at an interrupt when this
 			   packet is no longer the last packet in the ring. */
 			if (speedo_debug > 2)
-				rtdm_printk(KERN_DEBUG "%s: RX packet postponed!\n",
-					   rtdev->name);
+				pr_debug("%s: RX packet postponed!\n",
+					 rtdev->name);
 			sp->rx_ring_state |= RrPostponed;
 			break;
 		}
 
 		if (speedo_debug > 4)
-			rtdm_printk(KERN_DEBUG "  speedo_rx() status %8.8x len %d.\n", status,
+			pr_debug("  speedo_rx() status %8.8x len %d.\n", status,
 				   pkt_len);
 		if ((status & (RxErrTooBig|RxOK|0x0f90)) != RxOK) {
 			if (status & RxErrTooBig)
-				rtdm_printk(KERN_ERR "%s: Ethernet frame overran the Rx buffer, "
-					   "status %8.8x!\n", rtdev->name, status);
+				pr_err("%s: Ethernet frame overran the Rx buffer, "
+				       "status %8.8x!\n",
+				       rtdev->name, status);
 			else if (! (status & RxOK)) {
 				/* There was a fatal error.  This *should* be impossible. */
 				sp->stats.rx_errors++;
-				rtdm_printk(KERN_ERR "%s: Anomalous event in speedo_rx(), "
-					   "status %8.8x.\n",
-					   rtdev->name, status);
+				pr_err("%s: Anomalous event in speedo_rx(), "
+				       "status %8.8x.\n",
+				       rtdev->name, status);
 			}
 		} else {
 			struct rtskb *skb;
@@ -1535,8 +1546,8 @@ speedo_rx(struct rtnet_device *rtdev, int* packets, nanosecs_abs_t *time_stamp)
 				/* Pass up the already-filled skbuff. */
 				skb = sp->rx_skbuff[entry];
 				if (skb == NULL) {
-					rtdm_printk(KERN_ERR "%s: Inconsistent Rx descriptor chain.\n",
-						   rtdev->name);
+					pr_err("%s: Inconsistent Rx descriptor chain.\n",
+					       rtdev->name);
 					break;
 				}
 				sp->rx_skbuff[entry] = NULL;
@@ -1583,8 +1594,8 @@ speedo_close(struct rtnet_device *rtdev)
 	rtnetif_stop_queue(rtdev);
 
 	if (speedo_debug > 1)
-		printk(KERN_DEBUG "%s: Shutting down ethercard, status was %4.4x.\n",
-			   rtdev->name, inw(ioaddr + SCBStatus));
+		pr_debug("%s: Shutting down ethercard, status was %4.4x.\n",
+			 rtdev->name, inw(ioaddr + SCBStatus));
 
 	/* Shutdown procedure according to Intel's e100 */
 	outl(PortPartialReset, ioaddr + SCBPort);
@@ -1672,8 +1683,8 @@ static void set_rx_mode(struct rtnet_device *rtdev)
 		new_rx_mode = 0;
 
 	if (speedo_debug > 3)
-		printk(KERN_DEBUG "%s: set_rx_mode %d -> %d\n", rtdev->name,
-				sp->rx_mode, new_rx_mode);
+		pr_debug("%s: set_rx_mode %d -> %d\n", rtdev->name, sp->rx_mode,
+			 new_rx_mode);
 
 	if ((int)(sp->cur_tx - sp->dirty_tx) > TX_RING_SIZE - TX_MULTICAST_SIZE) {
 	    /* The Tx ring is full -- don't add anything!  Hope the mode will be
@@ -1835,7 +1846,7 @@ static int __init eepro100_init_module(void)
 {
 #ifdef CONFIG_XENO_DRIVERS_NET_DRV_EEPRO100_DBG
 	if (local_debug >= 0 && speedo_debug != local_debug)
-		printk(KERN_INFO "eepro100.c: Debug level is %d.\n", local_debug);
+		pr_info("eepro100.c: Debug level is %d.\n", local_debug);
 	if (local_debug >= 0)
 		speedo_debug = local_debug;
 #else  /* !CONFIG_XENO_DRIVERS_NET_DRV_EEPRO100_DBG */

-- 
2.39.2

