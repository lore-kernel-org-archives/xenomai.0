Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9FC153823
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781947; cv=none; b=KJT99Xfm67a1MPS1IvfN/B3/BDwg8brpc+MRH9lc3C6+NjDHop3zUbowwA8zrIutoXDSeWVM+ZlwCfICA7Gs4W/AVGxo7OkebGK6iIQ8xpcco1UE1PGM0eIUmwPC5uVezNRpI45xgNfOGrk7sayZEI/onvnY9Z9uqGPlRH7XCPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781947; c=relaxed/simple;
	bh=OKM5t06W5v5VEd1E9t/wBWwPflzzOUm/UDjmdr2ngHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hl1m0mMcSautlxjKO8azSLIf/ALkJpmmcce0hTDdqTmGeDQSqy8VNM3aV6xF4Lg1zd95ATvSuSLeRm7aSi59niQ4eFUnGOTzMFYZRZ+DJJ9GIVQKIp+ksrorRyuAv6mgci/uSyJv1r/htGShofCj0oCMUpM9fps7Tzvrgwe2S5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=SaTgS7gM; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="SaTgS7gM"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240712104854fd868251766ef1c92e
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:48:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=J0WTmicZlfsPvioLuDFXs+ihT1dtmtEFkmdaxMyODMM=;
 b=SaTgS7gM/Tl04TOUBtArxJz6dtZNMi6xF41z9lNJhnfj7cLYyv258ENUuLy9wKydoiPV9M
 oy+DOYnrgOhT7jrJ7pjPGNhjTMQ0yqAyR3zGwOVW+MF5wK9K/nm/WpLR4jgeOW/k59W4/mvE
 gtvwRPvXQ0Pbg5ndZnKaLbjRhHe8o=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:49:01 +0200
Subject: [PATCH v2 15/33] drivers/8139too: Migrate from rtdm_printk() and
 printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-15-facd992606c7@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

A few (rtdm_)printk() calls were missing log level information. The
default log level (= warn) did not fit well for them.

The missing log level is addressed by migrating to the pr_*() API.

rtdm_printk() itself is just an alias for printk(). Migrating helps to
remove this function once all drivers were updated.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/drivers/8139too.c | 50 ++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/kernel/drivers/net/drivers/8139too.c b/kernel/drivers/net/drivers/8139too.c
index c335b300b..5325940fd 100644
--- a/kernel/drivers/net/drivers/8139too.c
+++ b/kernel/drivers/net/drivers/8139too.c
@@ -31,6 +31,8 @@
 #define DRV_NAME            "rt_8139too"
 #define DRV_VERSION         "0.9.24-rt0.7"
 
+#define pr_fmt(fmt) DRV_NAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/compiler.h>
@@ -70,7 +72,6 @@ MODULE_PARM_DESC(rx_pool_size, "number of receive buffers");
 
 
 #define RTL8139_DRIVER_NAME   DRV_NAME " Fast Ethernet driver " DRV_VERSION
-#define PFX DRV_NAME ": "
 
 /* enable PIO instead of MMIO, if CONFIG_8139TOO_PIO is selected */
 /* *** RTnet ***
@@ -639,7 +640,7 @@ static int rtl8139_init_board (struct pci_dev *pdev,
 	rtdev=rt_alloc_etherdev(sizeof (struct rtl8139_private),
 				rx_pool_size + NUM_TX_DESC);
 	if (rtdev==NULL) {
-		rtdm_printk (KERN_ERR PFX "%s: Unable to alloc new net device\n", pci_name(pdev));
+		pr_err("%s: Unable to alloc new net device\n", pci_name(pdev));
 		return -ENOMEM;
 	}
 	rtdev_alloc_name(rtdev, "rteth%d");
@@ -677,25 +678,25 @@ static int rtl8139_init_board (struct pci_dev *pdev,
 
 	/* make sure PCI base addr 0 is PIO */
 	if (!(pio_flags & IORESOURCE_IO)) {
-		rtdm_printk (KERN_ERR PFX "%s: region #0 not a PIO resource, aborting\n", pci_name(pdev));
+		pr_err("%s: region #0 not a PIO resource, aborting\n", pci_name(pdev));
 		rc = -ENODEV;
 		goto err_out;
 	}
 	/* check for weird/broken PCI region reporting */
 	if (pio_len < RTL_MIN_IO_SIZE) {
-		rtdm_printk (KERN_ERR PFX "%s: Invalid PCI I/O region size(s), aborting\n", pci_name(pdev));
+		pr_err("%s: Invalid PCI I/O region size(s), aborting\n", pci_name(pdev));
 		rc = -ENODEV;
 		goto err_out;
 	}
 #else
 	/* make sure PCI base addr 1 is MMIO */
 	if (!(mmio_flags & IORESOURCE_MEM)) {
-		rtdm_printk(KERN_ERR PFX "%s: region #1 not an MMIO resource, aborting\n", pci_name(pdev));
+		pr_err("%s: region #1 not an MMIO resource, aborting\n", pci_name(pdev));
 		rc = -ENODEV;
 		goto err_out;
 	}
 	if (mmio_len < RTL_MIN_IO_SIZE) {
-		rtdm_printk(KERN_ERR PFX "%s: Invalid PCI mem region size(s), aborting\n", pci_name(pdev));
+		pr_err("%s: Invalid PCI mem region size(s), aborting\n", pci_name(pdev));
 		rc = -ENODEV;
 		goto err_out;
 	}
@@ -709,7 +710,7 @@ static int rtl8139_init_board (struct pci_dev *pdev,
 	/* ioremap MMIO region */
 	ioaddr = ioremap (mmio_start, mmio_len);
 	if (ioaddr == NULL) {
-		rtdm_printk(KERN_ERR PFX "%s: cannot remap MMIO, aborting\n", pci_name(pdev));
+		pr_err("%s: cannot remap MMIO, aborting\n", pci_name(pdev));
 		rc = -EIO;
 		goto err_out;
 	}
@@ -722,7 +723,7 @@ static int rtl8139_init_board (struct pci_dev *pdev,
 
 	/* check for missing/broken hardware */
 	if (RTL_R32 (TxConfig) == 0xFFFFFFFF) {
-		rtdm_printk(KERN_ERR PFX "%s: Chip not responding, ignoring board\n", pci_name(pdev));
+		pr_err("%s: Chip not responding, ignoring board\n", pci_name(pdev));
 		rc = -EIO;
 		goto err_out;
 	}
@@ -735,8 +736,8 @@ static int rtl8139_init_board (struct pci_dev *pdev,
 			goto match;
 		}
 
-	rtdm_printk("rt8139too: unknown chip version, assuming RTL-8139\n");
-	rtdm_printk("rt8139too: TxConfig = 0x%08x\n", RTL_R32 (TxConfig));
+	pr_info("%s: unknown chip version, assuming RTL-8139\n", pci_name(pdev));
+	pr_info("%s: TxConfig = 0x%08x\n", pci_name(pdev), RTL_R32 (TxConfig));
 
 	tp->chipset = 0;
 
@@ -808,7 +809,7 @@ static int rtl8139_init_one (struct pci_dev *pdev,
 	{
 		static int printed_version;
 		if (!printed_version++)
-			rtdm_printk (KERN_INFO RTL8139_DRIVER_NAME "\n");
+			pr_info(RTL8139_DRIVER_NAME "\n");
 	}
 #endif
 
@@ -861,7 +862,7 @@ static int rtl8139_init_one (struct pci_dev *pdev,
 			tp->medialock = 1;
 	}
 	if (tp->default_port) {
-		rtdm_printk(KERN_INFO "  Forcing %dMbps %s-duplex operation.\n",
+		pr_info("  Forcing %dMbps %s-duplex operation.\n",
 			    (option & 0x20 ? 100 : 10),
 			    (option & 0x10 ? "full" : "half"));
 		mdio_write(rtdev, tp->phys[0], 0,
@@ -1297,7 +1298,7 @@ static int rtl8139_start_xmit (struct rtskb *skb, struct rtnet_device *rtdev)
 	dev_kfree_rtskb(skb);
 
 #ifdef DEBUG
-	rtdm_printk ("%s: Queued Tx packet size %u to slot %d.\n", rtdev->name, len, entry);
+	pr_debug("%s: Queued Tx packet size %u to slot %d.\n", rtdev->name, len, entry);
 #endif
 	return 0;
 }
@@ -1356,7 +1357,7 @@ static void rtl8139_tx_interrupt (struct rtnet_device *rtdev,
 		/* Note: TxCarrierLost is always asserted at 100mbps. */
 		if (txstatus & (TxOutOfWindow | TxAborted)) {
 			/* There was an major error, log it. */
-			rtdm_printk("%s: Transmit error, Tx status %8.8x.\n",
+			pr_err("%s: Transmit error, Tx status %8.8x.\n",
 				    rtdev->name, txstatus);
 			tp->stats.tx_errors++;
 			if (txstatus & TxAborted) {
@@ -1409,8 +1410,8 @@ static void rtl8139_rx_err
 #endif */
 
 	/* RTnet-TODO: We really need an error manager to handle such issues... */
-	rtdm_printk("%s: FATAL - Ethernet frame had errors, status %8.8x.\n",
-		    rtdev->name, rx_status);
+	pr_err("%s: FATAL - Ethernet frame had errors, status %8.8x.\n",
+       	       rtdev->name, rx_status);
 }
 
 
@@ -1482,7 +1483,7 @@ static void rtl8139_rx_interrupt (struct rtnet_device *rtdev,
 			tp->stats.rx_bytes += pkt_size;
 			tp->stats.rx_packets++;
 		} else {
-			rtdm_printk (KERN_WARNING"%s: Memory squeeze, dropping packet.\n", rtdev->name);
+			pr_warn("%s: Memory squeeze, dropping packet.\n", rtdev->name);
 			tp->stats.rx_dropped++;
 		}
 
@@ -1502,8 +1503,7 @@ static void rtl8139_weird_interrupt (struct rtnet_device *rtdev,
 				     void *ioaddr,
 				     int status, int link_changed)
 {
-	rtdm_printk ("%s: Abnormal interrupt, status %8.8x.\n",
-		      rtdev->name, status);
+	pr_err("%s: Abnormal interrupt, status %8.8x.\n", rtdev->name, status);
 
 	/* Update the error count. */
 	tp->stats.rx_missed_errors += RTL_R32 (RxMissed);
@@ -1530,7 +1530,7 @@ static void rtl8139_weird_interrupt (struct rtnet_device *rtdev,
 		pci_read_config_word (tp->pci_dev, PCI_STATUS, &pci_cmd_status);
 		pci_write_config_word (tp->pci_dev, PCI_STATUS, pci_cmd_status);
 
-		rtdm_printk (KERN_ERR "%s: PCI Bus error %4.4x.\n", rtdev->name, pci_cmd_status);
+		pr_err("%s: PCI Bus error %4.4x.\n", rtdev->name, pci_cmd_status);
 	}
 }
 
@@ -1611,7 +1611,7 @@ static int rtl8139_close (struct rtnet_device *rtdev)
 	void *ioaddr = tp->mmio_addr;
 	rtdm_lockctx_t context;
 
-	printk ("%s: Shutting down ethercard, status was 0x%4.4x.\n", rtdev->name, RTL_R16 (IntrStatus));
+	pr_info("%s: Shutting down ethercard, status was 0x%4.4x.\n", rtdev->name, RTL_R16 (IntrStatus));
 
 	rtnetif_stop_queue (rtdev);
 
@@ -1660,14 +1660,14 @@ static void __set_rx_mode (struct rtnet_device *rtdev)
 	u32 tmp;
 
 #ifdef DEBUG
-	rtdm_printk ("%s:   rtl8139_set_rx_mode(%4.4x) done -- Rx config %8.8lx.\n",
-			rtdev->name, rtdev->flags, RTL_R32 (RxConfig));
+	pr_debug("%s:   rtl8139_set_rx_mode(%4.4x) done -- Rx config %8.8lx.\n",
+		 rtdev->name, rtdev->flags, RTL_R32 (RxConfig));
 #endif
 
 	/* Note: do not reorder, GCC is clever about common statements. */
 	if (rtdev->flags & IFF_PROMISC) {
 		/* Unconditionally log net taps. */
-		/*printk (KERN_NOTICE "%s: Promiscuous mode enabled.\n", rtdev->name);*/
+		/*pr_notice("%s: Promiscuous mode enabled.\n", rtdev->name);*/
 		rx_mode = AcceptBroadcast | AcceptMulticast | AcceptMyPhys | AcceptAllPhys;
 		mc_filter[1] = mc_filter[0] = 0xffffffff;
 	} else if (rtdev->flags & IFF_ALLMULTI) {
@@ -1716,7 +1716,7 @@ static int __init rtl8139_init_module (void)
 	 */
 
 #ifdef MODULE
-	printk (KERN_INFO RTL8139_DRIVER_NAME "\n");
+	pr_info(RTL8139_DRIVER_NAME "\n");
 #endif
 
 	return pci_register_driver (&rtl8139_pci_driver);

-- 
2.39.2

