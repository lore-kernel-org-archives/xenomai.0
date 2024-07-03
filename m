Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88E117A5B6
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013152; cv=none; b=F/8hIk/cfVxi0qzilb7dnVOT7dlmCadZGp4IjtSDJZ0X3ekv3avQziRNm4/DV3+h0dM4m79CWFDgHC/TXBiF5VoU1+n0eFXKy+frF2t3jHjatVnuaK469e3sr7U0UlQgh7cGCS2NZZ8dYWG+xFJ2qcGKyIvx35+hIQJF0NaYUpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013152; c=relaxed/simple;
	bh=EZtaAR44W9ZdZfevSrqrFnduh7yMj8TbOkjJlnNQALM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bmYbzvcB1mqkw7ALfyPKIs7woY1rqFc98i8GJhNxpUTjkqZDEJQgVi9LVZdc1AKmovTukCwao4egLm3hxLdD/tJRP2VXwHhRFt/2jsUQ64UmuoED4slHKVC9/QVKJp2mv3FsW2lHZPxbignawcYgWcfnltDwBPPhYxSW1lE8XIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=rDZuIXcx; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="rDZuIXcx"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240703132545e3ca6bbefb40464137
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=juGSaeT42MamVuLTh64i8C2XHeoTx7Chz9sdxusLKQg=;
 b=rDZuIXcx5/C1N68x/mifRkwBRuEz9y7ErTh1kQ7g95ym5TA4D4FGF7vuSBo9BckWgR33vI
 u4Clxxrzzsh+TDSlvK08UD7e3a6g3pvlEPGj6FPMiWTg0xpPW1vW0h+KgKx0PcvWUFyRtpU3
 IBvgWdeqPRLmnlAI6/7vneDiNsG2w=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:42 +0200
Subject: [PATCH 19/33] drivers/pcnet32: Migrate from printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-19-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Some printk() calls were missing log level information. The default
level (= warn) did fit well for them.

The missing log level is addressed by migrating to the pr_*() API.

All pr_*() calls are now in sync with the upstream driver (taken from
Linux 6.9). The usage of pr_cont() is not SMP safe but the upstream
driver has the same issue.

No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/drivers/pcnet32.c | 136 +++++++++++++++--------------------
 1 file changed, 59 insertions(+), 77 deletions(-)

diff --git a/kernel/drivers/net/drivers/pcnet32.c b/kernel/drivers/net/drivers/pcnet32.c
index eebb66ecb..0ac423c11 100644
--- a/kernel/drivers/net/drivers/pcnet32.c
+++ b/kernel/drivers/net/drivers/pcnet32.c
@@ -25,7 +25,8 @@
 #define DRV_NAME "pcnet32-rt"
 #define DRV_VERSION "1.27a-RTnet-0.2"
 #define DRV_RELDATE "2003-09-24"
-#define PFX DRV_NAME ": "
+
+#define pr_fmt(fmt) DRV_NAME ": " fmt
 
 static const char *version =
 	DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE " Jan.Kiszka@web.de\n";
@@ -509,21 +510,20 @@ static int pcnet32_probe_pci(struct pci_dev *pdev,
 
 	err = pci_enable_device(pdev);
 	if (err < 0) {
-		printk(KERN_ERR PFX "failed to enable device -- err=%d\n", err);
+		pr_err("failed to enable device -- err=%d\n", err);
 		return err;
 	}
 	pci_set_master(pdev);
 
 	ioaddr = pci_resource_start(pdev, 0);
 	if (!ioaddr) {
-		printk(KERN_ERR PFX "card has no PCI IO resources, aborting\n");
+		pr_err("card has no PCI IO resources, aborting\n");
 		return -ENODEV;
 	}
 
 	err = dma_set_mask(&pdev->dev, PCNET32_DMA_MASK);
 	if (err) {
-		printk(KERN_ERR PFX
-		       "architecture does not support 32bit PCI busmaster DMA\n");
+		pr_err("architecture does not support 32bit PCI busmaster DMA\n");
 		return err;
 	}
 
@@ -571,8 +571,7 @@ static int pcnet32_probe1(unsigned long ioaddr, unsigned int irq_line,
 	chip_version =
 		a->read_csr(ioaddr, 88) | (a->read_csr(ioaddr, 89) << 16);
 	if (pcnet32_debug > 2)
-		printk(KERN_INFO "  PCnet chip version is %#x.\n",
-		       chip_version);
+		pr_info("PCnet chip version is %#x.\n", chip_version);
 	if ((chip_version & 0xfff) != 0x003)
 		return -ENODEV;
 
@@ -626,7 +625,7 @@ static int pcnet32_probe1(unsigned long ioaddr, unsigned int irq_line,
 		/* switch to home wiring mode */
 		media = a->read_bcr(ioaddr, 49);
 		if (pcnet32_debug > 2)
-			printk(KERN_DEBUG PFX "media reset to %#x.\n", media);
+			pr_debug("media reset to %#x.\n", media);
 		a->write_bcr(ioaddr, 49, media);
 		break;
 	case 0x2627:
@@ -635,8 +634,7 @@ static int pcnet32_probe1(unsigned long ioaddr, unsigned int irq_line,
 		mii = 1;
 		break;
 	default:
-		printk(KERN_INFO PFX "PCnet version %#x, no PCnet32 chip.\n",
-		       chip_version);
+		pr_info("PCnet version %#x, no PCnet32 chip.\n", chip_version);
 		return -ENODEV;
 	}
 
@@ -665,7 +663,7 @@ static int pcnet32_probe1(unsigned long ioaddr, unsigned int irq_line,
 	dev->sysbind = &pdev->dev;
 	/*** RTnet ***/
 
-	printk(KERN_INFO PFX "%s at %#3lx,", chipname, ioaddr);
+	pr_info("%s at %#3lx,", chipname, ioaddr);
 
 	/* In most chips, after a chip reset, the ethernet address is read from the
      * station address PROM at the base address and programmed into the
@@ -694,8 +692,8 @@ static int pcnet32_probe1(unsigned long ioaddr, unsigned int irq_line,
 		if (!is_valid_ether_addr(dev->dev_addr) &&
 		    is_valid_ether_addr(promaddr)) {
 #endif
-			printk(" warning: CSR address invalid,\n");
-			printk(KERN_INFO "    using instead PROM address of");
+			pr_cont(" warning: CSR address invalid,\n");
+			pr_info("    using instead PROM address of");
 			memcpy(dev->dev_addr, promaddr, 6);
 		}
 	}
@@ -705,43 +703,43 @@ static int pcnet32_probe1(unsigned long ioaddr, unsigned int irq_line,
 		memset(dev->dev_addr, 0, sizeof(dev->dev_addr));
 
 	for (i = 0; i < 6; i++)
-		printk(" %2.2x", dev->dev_addr[i]);
+		pr_cont(" %2.2x", dev->dev_addr[i]);
 
 	if (((chip_version + 1) & 0xfffe) ==
 	    0x2624) { /* Version 0x2623 or 0x2624 */
 		i = a->read_csr(ioaddr, 80) & 0x0C00; /* Check tx_start_pt */
-		printk("\n" KERN_INFO "    tx_start_pt(0x%04x):", i);
+		pr_info("    tx_start_pt(0x%04x):", i);
 		switch (i >> 10) {
 		case 0:
-			printk("  20 bytes,");
+			pr_cont("  20 bytes,");
 			break;
 		case 1:
-			printk("  64 bytes,");
+			pr_cont("  64 bytes,");
 			break;
 		case 2:
-			printk(" 128 bytes,");
+			pr_cont(" 128 bytes,");
 			break;
 		case 3:
-			printk("~220 bytes,");
+			pr_cont("~220 bytes,");
 			break;
 		}
 		i = a->read_bcr(ioaddr, 18); /* Check Burst/Bus control */
-		printk(" BCR18(%x):", i & 0xffff);
+		pr_cont(" BCR18(%x):", i & 0xffff);
 		if (i & (1 << 5))
-			printk("BurstWrEn ");
+			pr_cont("BurstWrEn ");
 		if (i & (1 << 6))
-			printk("BurstRdEn ");
+			pr_cont("BurstRdEn ");
 		if (i & (1 << 7))
-			printk("DWordIO ");
+			pr_cont("DWordIO ");
 		if (i & (1 << 11))
-			printk("NoUFlow ");
+			pr_cont("NoUFlow ");
 		i = a->read_bcr(ioaddr, 25);
-		printk("\n" KERN_INFO "    SRAMSIZE=0x%04x,", i << 8);
+		pr_info("    SRAMSIZE=0x%04x,", i << 8);
 		i = a->read_bcr(ioaddr, 26);
-		printk(" SRAM_BND=0x%04x,", i << 8);
+		pr_cont(" SRAM_BND=0x%04x,", i << 8);
 		i = a->read_bcr(ioaddr, 27);
 		if (i & (1 << 14))
-			printk("LowLatRx");
+			pr_cont("LowLatRx");
 	}
 
 	dev->base_addr = ioaddr;
@@ -785,7 +783,7 @@ static int pcnet32_probe1(unsigned long ioaddr, unsigned int irq_line,
 		lp->options |= PCNET32_PORT_FD;
 
 	if (!a) {
-		printk(KERN_ERR PFX "No access methods\n");
+		pr_err("No access methods\n");
 		dma_free_coherent(&lp->pci_dev->dev, sizeof(*lp), lp,
 				  lp->dma_addr);
 		release_region(ioaddr, PCNET32_TOTAL_SIZE);
@@ -827,7 +825,7 @@ static int pcnet32_probe1(unsigned long ioaddr, unsigned int irq_line,
 	}
 
 	if (dev->irq >= 2)
-		printk(" assigned IRQ %d.\n", dev->irq);
+		pr_info("assigned IRQ %d.\n", dev->irq);
 	else {
 		unsigned long irq_mask = probe_irq_on();
 
@@ -842,9 +840,9 @@ static int pcnet32_probe1(unsigned long ioaddr, unsigned int irq_line,
 
 		dev->irq = probe_irq_off(irq_mask);
 		if (dev->irq)
-			printk(", probed IRQ %d.\n", dev->irq);
+			pr_info("probed IRQ %d.\n", dev->irq);
 		else {
-			printk(", failed to detect IRQ line.\n");
+			pr_info("failed to detect IRQ line.\n");
 			dma_free_coherent(&lp->pci_dev->dev, sizeof(*lp), lp,
 					  lp->dma_addr);
 			release_region(ioaddr, PCNET32_TOTAL_SIZE);
@@ -878,7 +876,7 @@ static int pcnet32_probe1(unsigned long ioaddr, unsigned int irq_line,
 	}
 	/*** RTnet ***/
 
-	printk(KERN_INFO "%s: registered as %s\n", dev->name, lp->name);
+	pr_info("%s: registered as %s\n", dev->name, lp->name);
 	return 0;
 }
 
@@ -912,7 +910,7 @@ static int pcnet32_open(struct rtnet_device *dev) /*** RTnet ***/
 	lp->a.write_bcr(ioaddr, 20, 2);
 
 	if (pcnet32_debug > 1)
-		printk(KERN_DEBUG
+		pr_debug(
 		       "%s: pcnet32_open() irq %d tx/rx rings %#x/%#x init %#x.\n",
 		       dev->name, dev->irq,
 		       (u32)(lp->dma_addr +
@@ -1017,7 +1015,7 @@ static int pcnet32_open(struct rtnet_device *dev) /*** RTnet ***/
 	lp->a.write_csr(ioaddr, 0, 0x0042);
 
 	if (pcnet32_debug > 2)
-		printk(KERN_DEBUG
+		pr_debug(
 		       "%s: pcnet32 open after %d ticks, init block %#x csr0 %4.4x.\n",
 		       dev->name, i,
 		       (u32)(lp->dma_addr +
@@ -1076,7 +1074,7 @@ static int pcnet32_init_ring(struct rtnet_device *dev) /*** RTnet ***/
 					      dev,
 					      PKT_BUF_SZ))) { /*** RTnet ***/
 				/* there is not much, we can do at this point */
-				printk(KERN_ERR
+				pr_err(
 				       "%s: pcnet32_init_ring rtnetdev_alloc_rtskb failed.\n",
 				       dev->name);
 				return -1;
@@ -1122,9 +1120,8 @@ static int pcnet32_start_xmit(struct rtskb *skb,
 	rtdm_lockctx_t context;
 
 	if (pcnet32_debug > 3) {
-		rtdm_printk(KERN_DEBUG
-			    "%s: pcnet32_start_xmit() called, csr0 %4.4x.\n",
-			    dev->name, lp->a.read_csr(ioaddr, 0));
+		pr_debug("%s: pcnet32_start_xmit() called, csr0 %4.4x.\n",
+			 dev->name, lp->a.read_csr(ioaddr, 0));
 	}
 
 	/*** RTnet ***/
@@ -1207,12 +1204,12 @@ static int pcnet32_interrupt(rtdm_irq_t *irq_handle) /*** RTnet ***/
 	int ret = RTDM_IRQ_NONE;
 
 	/*** RTnet ***
-    if (!dev) {
-	rtdm_printk (KERN_DEBUG "%s(): irq %d for unknown device\n",
+	if (!dev) {
+		pr_debug("%s(): irq %d for unknown device\n",
 		__FUNCTION__, irq);
 	return;
-    }
- *** RTnet ***/
+	}
+	*** RTnet ***/
 
 	ioaddr = dev->base_addr;
 	lp = dev->priv;
@@ -1230,10 +1227,8 @@ static int pcnet32_interrupt(rtdm_irq_t *irq_handle) /*** RTnet ***/
 		must_restart = 0;
 
 		if (pcnet32_debug > 5)
-			rtdm_printk(
-				KERN_DEBUG
-				"%s: interrupt  csr0=%#2.2x new csr=%#2.2x.\n",
-				dev->name, csr0, lp->a.read_csr(ioaddr, 0));
+			pr_debug("%s: interrupt  csr0=%#2.2x new csr=%#2.2x.\n",
+				 dev->name, csr0, lp->a.read_csr(ioaddr, 0));
 
 		if (csr0 & 0x0400) /* Rx interrupt */
 			pcnet32_rx(dev, &time_stamp);
@@ -1267,10 +1262,8 @@ static int pcnet32_interrupt(rtdm_irq_t *irq_handle) /*** RTnet ***/
 						lp->stats.tx_fifo_errors++;
 						/* Ackk!  On FIFO errors the Tx unit is turned off! */
 						/* Remove this verbosity later! */
-						rtdm_printk(
-							KERN_ERR
-							"%s: Tx FIFO error! CSR0=%4.4x\n",
-							dev->name, csr0);
+						pr_err("%s: Tx FIFO error! CSR0=%4.4x\n",
+						       dev->name, csr0);
 						must_restart = 1;
 					}
 #else
@@ -1279,11 +1272,8 @@ static int pcnet32_interrupt(rtdm_irq_t *irq_handle) /*** RTnet ***/
 						if (!lp->dxsuflo) { /* If controller doesn't recover ... */
 							/* Ackk!  On FIFO errors the Tx unit is turned off! */
 							/* Remove this verbosity later! */
-							rtdm_printk(
-								KERN_ERR
-								"%s: Tx FIFO error! CSR0=%4.4x\n",
-								dev->name,
-								csr0);
+							pr_err("%s: Tx FIFO error! CSR0=%4.4x\n",
+							       dev->name, csr0);
 							must_restart = 1;
 						}
 					}
@@ -1310,11 +1300,9 @@ static int pcnet32_interrupt(rtdm_irq_t *irq_handle) /*** RTnet ***/
 			}
 
 			if (lp->cur_tx - dirty_tx >= TX_RING_SIZE) {
-				rtdm_printk(
-					KERN_ERR
-					"%s: out-of-sync dirty pointer, %d vs. %d, full=%d.\n",
-					dev->name, dirty_tx, lp->cur_tx,
-					lp->tx_full);
+				pr_err("%s: out-of-sync dirty pointer, %d vs. %d, full=%d.\n",
+				       dev->name, dirty_tx, lp->cur_tx,
+				       lp->tx_full);
 				dirty_tx += TX_RING_SIZE;
 			}
 
@@ -1345,10 +1333,8 @@ static int pcnet32_interrupt(rtdm_irq_t *irq_handle) /*** RTnet ***/
 			lp->stats.rx_errors++; /* Missed a Rx frame. */
 		}
 		if (csr0 & 0x0800) {
-			rtdm_printk(
-				KERN_ERR
-				"%s: Bus master arbitration failure, status %4.4x.\n",
-				dev->name, csr0);
+			pr_err("%s: Bus master arbitration failure, status %4.4x.\n",
+			       dev->name, csr0);
 			/* unlike for the lance, there is no restart needed */
 		}
 
@@ -1361,8 +1347,8 @@ static int pcnet32_interrupt(rtdm_irq_t *irq_handle) /*** RTnet ***/
 	lp->a.write_rap(ioaddr, rap);
 
 	if (pcnet32_debug > 4)
-		rtdm_printk(KERN_DEBUG "%s: exiting interrupt, csr0=%#4.4x.\n",
-			    dev->name, lp->a.read_csr(ioaddr, 0));
+		pr_debug("%s: exiting interrupt, csr0=%#4.4x.\n", dev->name,
+			 lp->a.read_csr(ioaddr, 0));
 
 	/*** RTnet ***/
 	rtdm_lock_put(&lp->lock);
@@ -1412,8 +1398,7 @@ static int pcnet32_rx(struct rtnet_device *dev,
 			struct rtskb *skb; /*** RTnet ***/
 
 			if (pkt_len < 60) {
-				rtdm_printk(KERN_ERR "%s: Runt packet!\n",
-					    dev->name);
+				pr_err("%s: Runt packet!\n", dev->name);
 				lp->stats.rx_errors++;
 			} else {
 				/*** RTnet ***/
@@ -1452,10 +1437,8 @@ static int pcnet32_rx(struct rtnet_device *dev,
 
 				if (skb == NULL) {
 					int i;
-					rtdm_printk(
-						KERN_ERR
-						"%s: Memory squeeze, deferring packet.\n",
-						dev->name);
+					pr_err("%s: Memory squeeze, deferring packet.\n",
+					       dev->name);
 					for (i = 0; i < RX_RING_SIZE; i++)
 						if ((short)le16_to_cpu(
 							    lp->rx_ring[(entry +
@@ -1506,9 +1489,8 @@ static int pcnet32_close(struct rtnet_device *dev) /*** RTnet ***/
 	lp->stats.rx_missed_errors = lp->a.read_csr(ioaddr, 112);
 
 	if (pcnet32_debug > 1)
-		printk(KERN_DEBUG
-		       "%s: Shutting down ethercard, status was %2.2x.\n",
-		       dev->name, lp->a.read_csr(ioaddr, 0));
+		pr_debug("%s: Shutting down ethercard, status was %2.2x.\n",
+			 dev->name, lp->a.read_csr(ioaddr, 0));
 
 	/* We stop the PCNET32 here -- it occasionally polls memory if we don't. */
 	lp->a.write_csr(ioaddr, 0, 0x0004);
@@ -1606,7 +1588,7 @@ MODULE_LICENSE("GPL");
 
 static int __init pcnet32_init_module(void)
 {
-	printk(KERN_INFO "%s", version);
+	pr_info("%s", version);
 
 	if (local_debug > 0)
 		pcnet32_debug = local_debug;
@@ -1623,7 +1605,7 @@ static int __init pcnet32_init_module(void)
 		pcnet32_probe_vlbus();
 
 	if (cards_found)
-		printk(KERN_INFO PFX "%d cards_found.\n", cards_found);
+		pr_info("%d cards_found.\n", cards_found);
 
 	return (pcnet32_have_pci + cards_found) ? 0 : -ENODEV;
 }

-- 
2.39.2

