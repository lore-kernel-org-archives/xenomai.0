Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496FE15B984
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781347; cv=none; b=sf685lZh8QRXp3dkx0d/zmsBZvC/lIb1lS5Ud45vB+LNhYqvS4eZYOWWh/8ANVHaJeyj9rnVmGN8zuQQUbSq88vt4/Xmphuhibk4KpjGOb1rpnxC+KJxOxXV+w+aF6OGFfGM5QkRds1ers/PHD9ywPDIt6lM9rhqDUfnmr9mXDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781347; c=relaxed/simple;
	bh=57AF/VJhJtARibmId2yEvgE1si4gvh5c3x91s1TWIVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XNAT90im3eaqRpzCm0yNRhM3z6igCj4i0Ba6iHShGocQRbNE7gdbSTwdqWDyfqirkRx0r2XmQZsM72JMXG6Xt5pYv48F1fYV4OmGEZjuSAPlWdOwC2zPFFZQT8caBKuefbaHnh30regA1Mt2jCJFKeS+upprGygtDEfSuKdJTLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=kg7He0d3; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="kg7He0d3"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202407121048554ea580d555efcf688a
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:48:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=W8GHXYmMXTRp8HAMXmvA5bIHFLkcsVi5Lb8XPaIaLy4=;
 b=kg7He0d37Wc6GI0XFgj1np1ouAEPmiyjNQyMsFBLHUa2ZiIg8s1x2W2AUsm1KwYOoS/cey
 P6nXSHfhxsX3BUaBhuZwqMeuhxwyfn+3e4y9FjjChMX+eDIkoFxNhWvIq6WaqDvMTWJ76jA0
 S9uIUIJENgY4u1Dr3D8dVGdqF1PsM=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:49:04 +0200
Subject: [PATCH v2 18/33] drivers/natsemi: Migrate from rtdm_printk() and
 printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-18-facd992606c7@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Some (rtdm_)printk() calls were missing log level information. The
default level (= warn) did not fit well for them.

The missing log level is addressed by migrating to the pr_*() API.

rtdm_printk() itself is just an alias for printk(). Migrating helps to
remove this function once all drivers were updated.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/drivers/natsemi.c | 188 ++++++++++++++++-------------------
 1 file changed, 85 insertions(+), 103 deletions(-)

diff --git a/kernel/drivers/net/drivers/natsemi.c b/kernel/drivers/net/drivers/natsemi.c
index 82d1c3350..5f80e6054 100644
--- a/kernel/drivers/net/drivers/natsemi.c
+++ b/kernel/drivers/net/drivers/natsemi.c
@@ -141,6 +141,8 @@
 	Ported to RTNET: December 2003, Erik Buit <e.buit@student.utwente.nl>
 */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #if !defined(__OPTIMIZE__)
 #warning  You must compile this file with the correct options!
 #warning  See the last lines of the source file.
@@ -246,7 +248,7 @@ static int full_duplex[MAX_UNITS];
 
 /* These identify the driver base version and may not be removed. */
 static char version[] =
-  KERN_INFO DRV_NAME " dp8381x driver, version "
+  DRV_NAME " dp8381x driver, version "
       DRV_VERSION ", " DRV_RELDATE "\n"
   KERN_INFO "  originally by Donald Becker <becker@scyld.com>\n"
   KERN_INFO "  http://www.scyld.com/network/natsemi.html\n"
@@ -747,7 +749,7 @@ static int natsemi_probe1 (struct pci_dev *pdev,
 #ifndef MODULE
 	static int printed_version;
 	if (!printed_version++)
-		rtdm_printk(version);
+		pr_info(version);
 #endif
 
 	i = pci_enable_device(pdev);
@@ -781,7 +783,7 @@ static int natsemi_probe1 (struct pci_dev *pdev,
 	dev = rt_alloc_etherdev(sizeof(struct netdev_private),
 				RX_RING_SIZE * 2 + TX_RING_SIZE);
 	if (dev == NULL) {
-		rtdm_printk(KERN_ERR "init_ethernet failed for card #%d\n", find_cnt);
+		pr_err("init_ethernet failed for card #%d\n", find_cnt);
 		goto err_out;
 	}
 	rtdev_alloc_name(dev, "rteth%d");
@@ -846,8 +848,7 @@ static int natsemi_probe1 (struct pci_dev *pdev,
 		if (option & 0x200)
 			np->full_duplex = 1;
 		if (option & 15)
-			rtdm_printk(KERN_INFO
-				"%s: ignoring user supplied media type %d",
+			pr_info("%s: ignoring user supplied media type %d",
 				dev->name, option & 15);
 	}
 	if (find_cnt < MAX_UNITS  &&  full_duplex[find_cnt])
@@ -878,37 +879,34 @@ static int natsemi_probe1 (struct pci_dev *pdev,
 	rtnetif_carrier_off(dev);
 
 	if (netif_msg_drv(np)) {
-		rtdm_printk(KERN_INFO "%s: %s at %#08lx, ",
-			dev->name, natsemi_pci_info[chip_idx].name, ioaddr);
-		for (i = 0; i < ETH_ALEN-1; i++)
-				rtdm_printk("%02x:", dev->dev_addr[i]);
-		rtdm_printk("%02x, IRQ %d.\n", dev->dev_addr[i], irq);
+		pr_info("%s: %s at %#08lx, %02x:%02x:%02x:%02x:%02x:%02x, IRQ %d.\n",
+			dev->name, natsemi_pci_info[chip_idx].name, ioaddr,
+			dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
+			dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5],
+			irq);
 	}
 
 	np->advertising = mdio_read(dev, 1, MII_ADVERTISE);
 	if ((readl((void *)(ioaddr + ChipConfig)) & 0xe000) != 0xe000
 	 && netif_msg_probe(np)) {
 		u32 chip_config = readl((void *)(ioaddr + ChipConfig));
-		rtdm_printk(KERN_INFO "%s: Transceiver default autonegotiation %s "
+		pr_info("%s: Transceiver default autonegotiation %s "
 			"10%s %s duplex.\n",
 			dev->name,
-			chip_config & CfgAnegEnable ?
-			  "enabled, advertise" : "disabled, force",
+			chip_config & CfgAnegEnable ? "enabled, advertise" :
+						      "disabled, force",
 			chip_config & CfgAneg100 ? "0" : "",
 			chip_config & CfgAnegFull ? "full" : "half");
 	}
 	if (netif_msg_probe(np))
-		rtdm_printk(KERN_INFO
-			"%s: Transceiver status %#04x advertising %#04x.\n",
+		pr_info("%s: Transceiver status %#04x advertising %#04x.\n",
 			dev->name, mdio_read(dev, 1, MII_BMSR),
 			np->advertising);
 
 	/* save the silicon revision for later querying */
 	np->srr = readl((void *)(ioaddr + SiliconRev));
 	if (netif_msg_hw(np))
-		rtdm_printk(KERN_INFO "%s: silicon revision %#04x.\n",
-				dev->name, np->srr);
-
+		pr_info("%s: silicon revision %#04x.\n", dev->name, np->srr);
 
 	return 0;
 
@@ -1055,11 +1053,10 @@ static void natsemi_reset(struct rtnet_device *dev)
 		udelay(5);
 	}
 	if (i==NATSEMI_HW_TIMEOUT) {
-		rtdm_printk(KERN_WARNING "%s: reset did not complete in %d usec.\n",
-			dev->name, i*5);
+		pr_warn("%s: reset did not complete in %d usec.\n", dev->name,
+			i * 5);
 	} else if (netif_msg_hw(np)) {
-		rtdm_printk(KERN_DEBUG "%s: reset completed in %d usec.\n",
-			dev->name, i*5);
+		pr_debug("%s: reset completed in %d usec.\n", dev->name, i * 5);
 	}
 
 	/* restore CFG */
@@ -1095,11 +1092,11 @@ static void natsemi_reload_eeprom(struct rtnet_device *dev)
 			break;
 	}
 	if (i==NATSEMI_HW_TIMEOUT) {
-		rtdm_printk(KERN_WARNING "%s: EEPROM did not reload in %d usec.\n",
-			dev->name, i*50);
+		pr_warn("%s: EEPROM did not reload in %d usec.\n", dev->name,
+			i * 50);
 	} else if (netif_msg_hw(np)) {
-		rtdm_printk(KERN_DEBUG "%s: EEPROM reloaded in %d usec.\n",
-			dev->name, i*50);
+		pr_debug("%s: EEPROM reloaded in %d usec.\n", dev->name,
+			 i * 50);
 	}
 }
 
@@ -1116,11 +1113,11 @@ static void natsemi_stop_rxtx(struct rtnet_device *dev)
 		udelay(5);
 	}
 	if (i==NATSEMI_HW_TIMEOUT) {
-		rtdm_printk(KERN_WARNING "%s: Tx/Rx process did not stop in %d usec.\n",
-			dev->name, i*5);
+		pr_warn("%s: Tx/Rx process did not stop in %d usec.\n",
+			dev->name, i * 5);
 	} else if (netif_msg_hw(np)) {
-		rtdm_printk(KERN_DEBUG "%s: Tx/Rx process stopped in %d usec.\n",
-			dev->name, i*5);
+		pr_debug("%s: Tx/Rx process stopped in %d usec.\n", dev->name,
+			 i * 5);
 	}
 }
 
@@ -1144,8 +1141,7 @@ static int netdev_open(struct rtnet_device *dev)
 	}
 
 	if (netif_msg_ifup(np))
-		rtdm_printk(KERN_DEBUG "%s: netdev_open() irq %d.\n",
-			dev->name, dev->irq);
+		pr_debug("%s: netdev_open() irq %d.\n", dev->name, dev->irq);
 	i = alloc_ring(dev);
 	if (i < 0) {
 		rtdm_irq_free(&np->irq_handle);
@@ -1165,10 +1161,10 @@ static int netdev_open(struct rtnet_device *dev)
 	rtnetif_start_queue(dev); /*** RTnet ***/
 
 	if (netif_msg_ifup(np))
-		rtdm_printk(KERN_DEBUG "%s: Done netdev_open(), status: %#08x.\n",
-			dev->name, (int)readl((void *)(ioaddr + ChipCmd)));
+		pr_debug("%s: Done netdev_open(), status: %#08x.\n", dev->name,
+			 (int)readl((void *)(ioaddr + ChipCmd)));
 
-/*** RTnet ***/
+	/*** RTnet ***/
 	/* Set the timer to check for link beat. */
 /*** RTnet ***/
 
@@ -1241,8 +1237,7 @@ static void check_link(struct rtnet_device *dev)
 	if (!(chipcfg & CfgLink)) {
 		if (rtnetif_carrier_ok(dev)) {
 			if (netif_msg_link(np))
-				rtdm_printk(KERN_NOTICE "%s: link down.\n",
-					dev->name);
+				pr_notice("%s: link down.\n", dev->name);
 			rtnetif_carrier_off(dev);
 			undo_cable_magic(dev);
 		}
@@ -1250,7 +1245,7 @@ static void check_link(struct rtnet_device *dev)
 	}
 	if (!rtnetif_carrier_ok(dev)) {
 		if (netif_msg_link(np))
-			rtdm_printk(KERN_NOTICE "%s: link up.\n", dev->name);
+			pr_notice("%s: link up.\n", dev->name);
 		rtnetif_carrier_on(dev);
 		do_cable_magic(dev);
 	}
@@ -1260,10 +1255,9 @@ static void check_link(struct rtnet_device *dev)
 	/* if duplex is set then bit 28 must be set, too */
 	if (duplex ^ !!(np->rx_config & RxAcceptTx)) {
 		if (netif_msg_link(np))
-			rtdm_printk(KERN_INFO
-				"%s: Setting %s-duplex based on negotiated "
-				"link capability.\n", dev->name,
-				duplex ? "full" : "half");
+			pr_info("%s: Setting %s-duplex based on negotiated "
+				"link capability.\n",
+				dev->name, duplex ? "full" : "half");
 		if (duplex) {
 			np->rx_config |= RxAcceptTx;
 			np->tx_config |= TxCarrierIgn | TxHeartIgn;
@@ -1288,9 +1282,8 @@ static void init_registers(struct rtnet_device *dev)
 		udelay(10);
 	}
 	if (i==NATSEMI_HW_TIMEOUT && netif_msg_link(np)) {
-		rtdm_printk(KERN_INFO
-			"%s: autonegotiation did not complete in %d usec.\n",
-			dev->name, i*10);
+		pr_info("%s: autonegotiation did not complete in %d usec.\n",
+			dev->name, i * 10);
 	}
 
 	/* On page 78 of the spec, they recommend some settings for "optimum
@@ -1354,8 +1347,8 @@ static void init_registers(struct rtnet_device *dev)
 	np->SavedClkRun = readl((void *)(ioaddr + ClkRun));
 	writel(np->SavedClkRun & ~PMEEnable, (void *)(ioaddr + ClkRun));
 	if (np->SavedClkRun & PMEStatus && netif_msg_wol(np)) {
-		rtdm_printk(KERN_NOTICE "%s: Wake-up event %#08x\n",
-			dev->name, readl((void *)(ioaddr + WOLCmd)));
+		pr_notice("%s: Wake-up event %#08x\n", dev->name,
+			  readl((void *)(ioaddr + WOLCmd)));
 	}
 
 	check_link(dev);
@@ -1390,19 +1383,19 @@ static void dump_ring(struct rtnet_device *dev)
 
 	if (netif_msg_pktdata(np)) {
 		int i;
-		rtdm_printk(KERN_DEBUG "  Tx ring at %p:\n", np->tx_ring);
+		pr_debug("  Tx ring at %p:\n", np->tx_ring);
 		for (i = 0; i < TX_RING_SIZE; i++) {
-			rtdm_printk(KERN_DEBUG " #%d desc. %#08x %#08x %#08x.\n",
-				i, np->tx_ring[i].next_desc,
-				np->tx_ring[i].cmd_status,
-				np->tx_ring[i].addr);
+			pr_debug(" #%d desc. %#08x %#08x %#08x.\n", i,
+				 np->tx_ring[i].next_desc,
+				 np->tx_ring[i].cmd_status,
+				 np->tx_ring[i].addr);
 		}
-		rtdm_printk(KERN_DEBUG "  Rx ring %p:\n", np->rx_ring);
+		pr_debug("  Rx ring %p:\n", np->rx_ring);
 		for (i = 0; i < RX_RING_SIZE; i++) {
-			rtdm_printk(KERN_DEBUG " #%d desc. %#08x %#08x %#08x.\n",
-				i, np->rx_ring[i].next_desc,
-				np->rx_ring[i].cmd_status,
-				np->rx_ring[i].addr);
+			pr_debug(" #%d desc. %#08x %#08x %#08x.\n", i,
+				 np->rx_ring[i].next_desc,
+				 np->rx_ring[i].cmd_status,
+				 np->rx_ring[i].addr);
 		}
 	}
 }
@@ -1443,7 +1436,7 @@ static void refill_rx(struct rtnet_device *dev)
 	}
 	if (np->cur_rx - np->dirty_rx == RX_RING_SIZE) {
 		if (netif_msg_rx_err(np))
-			rtdm_printk(KERN_WARNING "%s: going OOM.\n", dev->name);
+			pr_warn("%s: going OOM.\n", dev->name);
 		np->oom = 1;
 	}
 }
@@ -1586,8 +1579,8 @@ static int start_tx(struct rtskb *skb, struct rtnet_device *dev) /*** RTnet ***/
 /*	dev->trans_start = jiffies;*/
 
 	if (netif_msg_tx_queued(np)) {
-		rtdm_printk(KERN_DEBUG "%s: Transmit frame #%d queued in slot %d.\n",
-			dev->name, np->cur_tx, entry);
+		pr_debug("%s: Transmit frame #%d queued in slot %d.\n",
+			 dev->name, np->cur_tx, entry);
 	}
 	return 0;
 }
@@ -1601,10 +1594,9 @@ static void netdev_tx_done(struct rtnet_device *dev)
 		if (np->tx_ring[entry].cmd_status & cpu_to_le32(DescOwn))
 			break;
 		if (netif_msg_tx_done(np))
-			rtdm_printk(KERN_DEBUG
-				"%s: tx frame #%d finished, status %#08x.\n",
-					dev->name, np->dirty_tx,
-					le32_to_cpu(np->tx_ring[entry].cmd_status));
+			pr_debug("%s: tx frame #%d finished, status %#08x.\n",
+				 dev->name, np->dirty_tx,
+				 le32_to_cpu(np->tx_ring[entry].cmd_status));
 		if (np->tx_ring[entry].cmd_status & cpu_to_le32(DescPktOK)) {
 			np->stats.tx_packets++;
 			np->stats.tx_bytes += np->tx_skbuff[entry]->len;
@@ -1656,10 +1648,9 @@ static int intr_handler(rtdm_irq_t *irq_handle)
 		u32 intr_status = readl((void *)(ioaddr + IntrStatus));
 
 		if (netif_msg_intr(np))
-			rtdm_printk(KERN_DEBUG
-				"%s: Interrupt, status %#08x, mask %#08x.\n",
-				dev->name, intr_status,
-				readl((void *)(ioaddr + IntrMask)));
+			pr_debug("%s: Interrupt, status %#08x, mask %#08x.\n",
+				 dev->name, intr_status,
+				 readl((void *)(ioaddr + IntrMask)));
 
 		if (intr_status == 0)
 			break;
@@ -1685,8 +1676,7 @@ static int intr_handler(rtdm_irq_t *irq_handle)
 
 		if (--boguscnt < 0) {
 			if (netif_msg_intr(np))
-				rtdm_printk(KERN_WARNING
-					"%s: Too much work at interrupt, "
+				pr_warn("%s: Too much work at interrupt, "
 					"status=%#08x.\n",
 					dev->name, intr_status);
 			break;
@@ -1694,7 +1684,7 @@ static int intr_handler(rtdm_irq_t *irq_handle)
 	} while (1);
 
 	if (netif_msg_intr(np))
-		rtdm_printk(KERN_DEBUG "%s: exiting interrupt.\n", dev->name);
+		pr_debug("%s: exiting interrupt.\n", dev->name);
 
 /*** RTnet ***/
 	if (old_packet_cnt != np->stats.rx_packets)
@@ -1714,20 +1704,19 @@ static void netdev_rx(struct rtnet_device *dev, nanosecs_abs_t *time_stamp)
 	/* If the driver owns the next entry it's a new packet. Send it up. */
 	while (desc_status < 0) { /* e.g. & DescOwn */
 		if (netif_msg_rx_status(np))
-			rtdm_printk(KERN_DEBUG
-				"  netdev_rx() entry %d status was %#08x.\n",
-				entry, desc_status);
+			pr_debug("  netdev_rx() entry %d status was %#08x.\n",
+				 entry, desc_status);
 		if (--boguscnt < 0)
 			break;
 		if ((desc_status&(DescMore|DescPktOK|DescRxLong)) != DescPktOK){
 			if (desc_status & DescMore) {
 				if (netif_msg_rx_err(np))
-					rtdm_printk(KERN_WARNING
-						"%s: Oversized(?) Ethernet "
+					pr_warn("%s: Oversized(?) Ethernet "
 						"frame spanned multiple "
 						"buffers, entry %#08x "
-						"status %#08x.\n", dev->name,
-						np->cur_rx, desc_status);
+						"status %#08x.\n",
+						dev->name, np->cur_rx,
+						desc_status);
 				np->stats.rx_length_errors++;
 			} else {
 				/* There was an error. */
@@ -1791,10 +1780,9 @@ static void netdev_error(struct rtnet_device *dev, int intr_status)
 		u16 lpa = mdio_read(dev, 1, MII_LPA);
 		if (mdio_read(dev, 1, MII_BMCR) & BMCR_ANENABLE
 		 && netif_msg_link(np)) {
-			rtdm_printk(KERN_INFO
-				"%s: Autonegotiation advertising"
-				" %#04x  partner %#04x.\n", dev->name,
-				adv, lpa);
+			pr_info("%s: Autonegotiation advertising"
+				" %#04x  partner %#04x.\n",
+				dev->name, adv, lpa);
 		}
 
 		/* read MII int status to clear the flag */
@@ -1808,27 +1796,25 @@ static void netdev_error(struct rtnet_device *dev, int intr_status)
 		if ((np->tx_config & TxDrthMask) < 62)
 			np->tx_config += 2;
 		if (netif_msg_tx_err(np))
-			rtdm_printk(KERN_NOTICE
-				"%s: increased Tx threshold, txcfg %#08x.\n",
-				dev->name, np->tx_config);
+			pr_notice("%s: increased Tx threshold, txcfg %#08x.\n",
+				  dev->name, np->tx_config);
 		writel(np->tx_config, (void *)(ioaddr + TxConfig));
 	}
 	if (intr_status & WOLPkt && netif_msg_wol(np)) {
 		int wol_status = readl((void *)(ioaddr + WOLCmd));
-		rtdm_printk(KERN_NOTICE "%s: Link wake-up event %#08x\n",
-			dev->name, wol_status);
+		pr_notice("%s: Link wake-up event %#08x\n", dev->name,
+			  wol_status);
 	}
 	if (intr_status & RxStatusFIFOOver) {
 		if (netif_msg_rx_err(np) && netif_msg_intr(np)) {
-			rtdm_printk(KERN_NOTICE "%s: Rx status FIFO overrun\n",
-				dev->name);
+			pr_notice("%s: Rx status FIFO overrun\n", dev->name);
 		}
 		np->stats.rx_fifo_errors++;
 	}
 	/* Hmmmmm, it's not clear how to recover from PCI faults. */
 	if (intr_status & IntrPCIErr) {
-		rtdm_printk(KERN_NOTICE "%s: PCI error %#08x\n", dev->name,
-			intr_status & IntrPCIErr);
+		pr_notice("%s: PCI error %#08x\n", dev->name,
+			  intr_status & IntrPCIErr);
 		np->stats.tx_fifo_errors++;
 		np->stats.rx_fifo_errors++;
 	}
@@ -1869,8 +1855,7 @@ static void __set_rx_mode(struct rtnet_device *dev)
 
 	if (dev->flags & IFF_PROMISC) { /* Set promiscuous. */
 		/* Unconditionally log net taps. */
-		rtdm_printk(KERN_NOTICE "%s: Promiscuous mode enabled.\n",
-			dev->name);
+		pr_notice("%s: Promiscuous mode enabled.\n", dev->name);
 		rx_mode = RxFilterEnable | AcceptBroadcast
 			| AcceptAllMulticast | AcceptAllPhys | AcceptMyPhys;
 	} else if (dev->flags & IFF_ALLMULTI) {
@@ -1910,8 +1895,7 @@ static void enable_wol_mode(struct rtnet_device *dev, int enable_intr)
 	struct netdev_private *np = dev->priv;
 
 	if (netif_msg_wol(np))
-		rtdm_printk(KERN_INFO "%s: remaining active for wake-on-lan\n",
-			dev->name);
+		pr_info("%s: remaining active for wake-on-lan\n", dev->name);
 
 	/* For WOL we must restart the rx process in silent mode.
 	 * Write NULL to the RxRingPtr. Only possible if
@@ -1944,14 +1928,12 @@ static int netdev_close(struct rtnet_device *dev)
 	struct netdev_private *np = dev->priv;
 
 	if (netif_msg_ifdown(np))
-		rtdm_printk(KERN_DEBUG
-			"%s: Shutting down ethercard, status was %#04x.\n",
-			dev->name, (int)readl((void *)(ioaddr + ChipCmd)));
+		pr_debug("%s: Shutting down ethercard, status was %#04x.\n",
+			 dev->name, (int)readl((void *)(ioaddr + ChipCmd)));
 	if (netif_msg_pktdata(np))
-		rtdm_printk(KERN_DEBUG
-			"%s: Queue pointers were Tx %d / %d,  Rx %d / %d.\n",
-			dev->name, np->cur_tx, np->dirty_tx,
-			np->cur_rx, np->dirty_rx);
+		pr_debug("%s: Queue pointers were Tx %d / %d,  Rx %d / %d.\n",
+			 dev->name, np->cur_tx, np->dirty_tx, np->cur_rx,
+			 np->dirty_rx);
 
 	/*
 	 * FIXME: what if someone tries to close a device
@@ -2080,7 +2062,7 @@ static int __init natsemi_init_mod (void)
 {
 /* when a module, this is printed whether or not devices are found in probe */
 #ifdef MODULE
-	rtdm_printk(version);
+	pr_info("%s", version);
 #endif
 
 	return pci_register_driver (&natsemi_driver);

-- 
2.39.2

