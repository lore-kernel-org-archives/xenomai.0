Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FC6158862
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781949; cv=none; b=MFtxnbtnDt1THpDBYQiXknR1/VSVG4iEhdEWJ7drpIaMSsYhqyfmnVhxS4NfKoMI1eaNdeyz6KxqKWrSwS7rVxJ9mAg+9dPze6htrCHtIovbEG5GqUXvuRx6ueiEbnmW8mcuY/WIVl8n2RN4L3roe/5U5JKVIq5pMteH11ipmqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781949; c=relaxed/simple;
	bh=o72N/H83IxzGIa3GHrDGiyHBd+j6nM3z/UCroBJWSK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KtdWsxG00O5ny9Bf9aKe1UNlz/P1lqzmXiNE2f52ka5eAWKb6L74GRncP/7pB6oES+BhgCMLCdHZ7s8uqZq8Cb0qcNJNG/1EjEPDBInON0R3M9MZR62SMtTWEwGyFBaccwOrE2zHpf+snNYK4k4z+FzihDafBUhAefUvBMcGkII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=pbsMeOvP; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="pbsMeOvP"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240712104856cb9547379a1ab549dd
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:48:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yYDcW57bV/8hobNkqzE24S3hGHkW/LlCg3N5yn/DNfU=;
 b=pbsMeOvP8J8q693vBTISlN/wvtX7PwO3BJv0IiGlkG+AJpx7bVK/Ht07ZUti0eY81vrcys
 ZRwSOXV0Es0D/Ryvfi7smXJNetsaFDYdWqYaTkIcCuSbr6pQ+5SRmijMIUWjJpjK/sZE4EKR
 srf0PHUNjUmruIMRRGQsf+yvPAhwk=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:49:06 +0200
Subject: [PATCH v2 20/33] drivers/r8169: Migrate from printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-20-facd992606c7@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Some printk() calls were missing log level information. This alone is
not a problem, but confusion starts when the default printk log level
is set to an unexpected value.

The missing log level is addressed by migrating to the pr_*() API.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/drivers/r8169.c | 127 +++++++++++++++++++++----------------
 1 file changed, 71 insertions(+), 56 deletions(-)

diff --git a/kernel/drivers/net/drivers/r8169.c b/kernel/drivers/net/drivers/r8169.c
index bbc5bc803..b470ddb51 100644
--- a/kernel/drivers/net/drivers/r8169.c
+++ b/kernel/drivers/net/drivers/r8169.c
@@ -68,6 +68,9 @@ RTL8169_VERSION "2.2"	<2004/08/09>
  *
  */
 
+#define MODULENAME "rt_r8169"
+#define pr_fmt(fmt) MODULENAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/netdevice.h>
@@ -81,9 +84,7 @@ RTL8169_VERSION "2.2"	<2004/08/09>
 #include <rtnet_port.h>	/*** RTnet ***/
 
 #define RTL8169_VERSION "2.2-04"
-#define MODULENAME "rt_r8169"
 #define RTL8169_DRIVER_NAME   MODULENAME " RTnet Gigabit Ethernet driver " RTL8169_VERSION
-#define PFX MODULENAME ": "
 
 //#define RTL8169_DEBUG
 #undef RTL8169_JUMBO_FRAME_SUPPORT	/*** RTnet: no not enable! ***/
@@ -97,13 +98,13 @@ RTL8169_VERSION "2.2"	<2004/08/09>
 
 #ifdef RTL8169_DEBUG
 	#define assert(expr) \
-		if(!(expr)) { printk( "Assertion failed! %s,%s,%s,line=%d\n", #expr,__FILE__,__FUNCTION__,__LINE__); }
+		if(!(expr)) { pr_err("Assertion failed! %s,%s,%s,line=%d\n", #expr,__FILE__,__FUNCTION__,__LINE__); }
 	/*** RTnet / <kk>: rt_assert must be used instead of assert() within interrupt context! ***/
 	#define rt_assert(expr) \
-		if(!(expr)) { rtdm_printk( "Assertion failed! %s,%s,%s,line=%d\n", #expr,__FILE__,__FUNCTION__,__LINE__); }
+		if(!(expr)) { pr_err("Assertion failed! %s,%s,%s,line=%d\n", #expr,__FILE__,__FUNCTION__,__LINE__); }
 	/*** RTnet / <kk>: RT_DBG_PRINT must be used instead of DBG_PRINT() within interrupt context! ***/
-	#define DBG_PRINT( fmt, args...)   printk("r8169: " fmt, ## args);
-	#define RT_DBG_PRINT( fmt, args...)   rtdm_printk("r8169: " fmt, ## args);
+	#define DBG_PRINT( fmt, args...)   pr_debug(fmt, ## args);
+	#define RT_DBG_PRINT( fmt, args...)   pr_debug(fmt, ## args);
 #else
 	#define assert(expr) do {} while (0)
 	#define rt_assert(expr) do {} while (0)
@@ -581,7 +582,7 @@ static int rtl8169_init_board ( struct pci_dev *pdev, struct rtnet_device **dev_
 	rtdev = rt_alloc_etherdev(sizeof(struct rtl8169_private),
 				RX_RING_SIZE * 2 + TX_RING_SIZE);
 	if (rtdev == NULL) {
-		printk (KERN_ERR PFX "unable to alloc new ethernet\n");
+		pr_err("unable to alloc new ethernet\n");
 		return -ENOMEM;
 	}
 	rtdev_alloc_name(rtdev, "rteth%d");
@@ -603,7 +604,7 @@ static int rtl8169_init_board ( struct pci_dev *pdev, struct rtnet_device **dev_
 		goto err_out;
 
 	if (pci_set_mwi(pdev) < 0)
-		printk("R8169: Mem-Wr-Inval unavailable\n");
+		pr_info("Mem-Wr-Inval unavailable\n");
 
 	mmio_start = pci_resource_start (pdev, region);
 	mmio_end = pci_resource_end (pdev, region);
@@ -612,14 +613,14 @@ static int rtl8169_init_board ( struct pci_dev *pdev, struct rtnet_device **dev_
 
 	// make sure PCI base addr 1 is MMIO
 	if (!(mmio_flags & IORESOURCE_MEM)) {
-		printk (KERN_ERR PFX "region #%d not an MMIO resource, aborting\n", region);
+		pr_err("region #%d not an MMIO resource, aborting\n", region);
 		rc = -ENODEV;
 		goto err_out;
 	}
 
 	// check for weird/broken PCI region reporting
 	if ( mmio_len < RTL_MIN_IO_SIZE ) {
-		printk (KERN_ERR PFX "Invalid PCI region size(s), aborting\n");
+		pr_err("Invalid PCI region size(s), aborting\n");
 		rc = -ENODEV;
 		goto err_out;
 	}
@@ -638,7 +639,7 @@ static int rtl8169_init_board ( struct pci_dev *pdev, struct rtnet_device **dev_
 	// ioremap MMIO region
 	ioaddr = (unsigned long)ioremap (mmio_start, mmio_len);
 	if (ioaddr == 0) {
-		printk (KERN_ERR PFX "cannot remap MMIO, aborting\n");
+		pr_err("cannot remap MMIO, aborting\n");
 		rc = -EIO;
 		goto err_out_free_res;
 	}
@@ -661,7 +662,7 @@ static int rtl8169_init_board ( struct pci_dev *pdev, struct rtnet_device **dev_
 		u8 cfg2 = RTL_R8(Config2) & ~MSIEnable;
 		if (region) {
 			if (pci_enable_msi(pdev))
-				printk("R8169: no MSI, Back to INTx.\n");
+				pr_info("no MSI, Back to INTx.\n");
 			else {
 				cfg2 |= MSIEnable;
 				priv->features |= RTL_FEATURE_MSI;
@@ -716,7 +717,7 @@ static int rtl8169_init_board ( struct pci_dev *pdev, struct rtnet_device **dev_
 	}
 
 	//if unknown chip, assume array element #0, original RTL-8169 in this case
-	printk (KERN_DEBUG PFX "PCI device %s: unknown chip version, assuming RTL-8169\n", pci_name(pdev));
+	pr_debug("PCI device %s: unknown chip version, assuming RTL-8169\n", pci_name(pdev));
 	priv->chipset = 0;
 
 match:
@@ -839,17 +840,13 @@ static int rtl8169_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 
 	pci_set_drvdata(pdev, rtdev);     //      pdev->driver_data = data;
 
-	printk (KERN_DEBUG "%s: Identified chip type is '%s'.\n", rtdev->name, rtl_chip_info[priv->chipset].name);
-	printk (KERN_INFO "%s: %s at 0x%lx, "
-				"%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x, "
-				"IRQ %d\n",
-				rtdev->name,
-				RTL8169_DRIVER_NAME,
-				rtdev->base_addr,
-				rtdev->dev_addr[0], rtdev->dev_addr[1],
-				rtdev->dev_addr[2], rtdev->dev_addr[3],
-				rtdev->dev_addr[4], rtdev->dev_addr[5],
-				rtdev->irq);
+	pr_debug("%s: Identified chip type is '%s'.\n", rtdev->name,
+		 rtl_chip_info[priv->chipset].name);
+	pr_info("%s: %s at 0x%lx, %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x, IRQ %d\n",
+		rtdev->name, RTL8169_DRIVER_NAME, rtdev->base_addr,
+		rtdev->dev_addr[0], rtdev->dev_addr[1], rtdev->dev_addr[2],
+		rtdev->dev_addr[3], rtdev->dev_addr[4], rtdev->dev_addr[5],
+		rtdev->irq);
 
 	// Config PHY
 	rtl8169_hw_PHY_config(rtdev);
@@ -880,7 +877,7 @@ static int rtl8169_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 		option = (board_idx >= MAX_UNITS) ? 0 : media[board_idx];
 		// Force RTL8169 in 10/100/1000 Full/Half mode.
 		if( option > 0 ){
-			printk(KERN_INFO "%s: Force-mode Enabled. \n", rtdev->name);
+			pr_info("%s: Force-mode Enabled. \n", rtdev->name);
 			Cap10_100 = 0;
 			Cap1000 = 0;
 			switch( option ){
@@ -911,7 +908,7 @@ static int rtl8169_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 			RTL8169_WRITE_GMII_REG( ioaddr, PHY_1000_CTRL_REG, Cap1000 );
 		}
 		else{
-			printk(KERN_INFO "%s: Auto-negotiation Enabled.\n", rtdev->name);
+			pr_info("%s: Auto-negotiation Enabled.\n", rtdev->name);
 
 			// enable 10/100 Full/Half Mode, leave PHY_AUTO_NEGO_REG bit4:0 unchanged
 			RTL8169_WRITE_GMII_REG( ioaddr, PHY_AUTO_NEGO_REG,
@@ -934,11 +931,15 @@ static int rtl8169_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 				udelay(100);
 				option = RTL_R8(PHYstatus);
 				if( option & _1000bpsF ){
-					printk(KERN_INFO "%s: 1000Mbps Full-duplex operation.\n", rtdev->name);
-				}
-				else{
-					printk(KERN_INFO "%s: %sMbps %s-duplex operation.\n", rtdev->name,
-							(option & _100bps) ? "100" : "10", (option & FullDup) ? "Full" : "Half" );
+					pr_info("%s: 1000Mbps Full-duplex operation.\n",
+						rtdev->name);
+				} else{
+					pr_info("%s: %sMbps %s-duplex operation.\n",
+						rtdev->name,
+						(option & _100bps) ? "100" :
+								     "10",
+						(option & FullDup) ? "Full" :
+								     "Half");
 				}
 				break;
 			}
@@ -1022,7 +1023,7 @@ static int rtl8169_open (struct rtnet_device *rtdev)
 //	u32 TxPhyAddr, RxPhyAddr;
 
 	if( priv->drvinit_fail == 1 ){
-		printk("%s: Gigabit driver open failed.\n", rtdev->name );
+		pr_warn("%s: Gigabit driver open failed.\n", rtdev->name);
 		return -ENOMEM;
 	}
 
@@ -1044,22 +1045,26 @@ static int rtl8169_open (struct rtnet_device *rtdev)
 	priv->txdesc_space = dma_alloc_coherent(&pdev->dev,
 		priv->sizeof_txdesc_space, &priv->txdesc_phy_dma_addr, GFP_ATOMIC);
 	if( priv->txdesc_space == NULL ){
-		printk("%s: Gigabit driver alloc txdesc_space failed.\n", rtdev->name );
+		pr_warn("%s: Gigabit driver alloc txdesc_space failed.\n",
+			rtdev->name);
 		return -ENOMEM;
 	}
 	priv->sizeof_rxdesc_space = NUM_RX_DESC * sizeof(struct RxDesc)+256;
 	priv->rxdesc_space = dma_alloc_coherent(&pdev->dev,
 		priv->sizeof_rxdesc_space, &priv->rxdesc_phy_dma_addr, GFP_ATOMIC);
 	if( priv->rxdesc_space == NULL ){
-		printk("%s: Gigabit driver alloc rxdesc_space failed.\n", rtdev->name );
+		pr_warn("%s: Gigabit driver alloc rxdesc_space failed.\n",
+			rtdev->name);
 		return -ENOMEM;
 	}
 
 	if(priv->txdesc_phy_dma_addr & 0xff){
-		printk("%s: Gigabit driver txdesc_phy_dma_addr is not 256-bytes-aligned.\n", rtdev->name );
+		pr_warn("%s: Gigabit driver txdesc_phy_dma_addr is not 256-bytes-aligned.\n",
+			rtdev->name);
 	}
 	if(priv->rxdesc_phy_dma_addr & 0xff){
-		printk("%s: Gigabit driver rxdesc_phy_dma_addr is not 256-bytes-aligned.\n", rtdev->name );
+		pr_warn("%s: Gigabit driver rxdesc_phy_dma_addr is not 256-bytes-aligned.\n",
+			rtdev->name);
 	}
 	// Set tx/rx descriptor space
 	priv->TxDescArray = (struct TxDesc *)priv->txdesc_space;
@@ -1078,7 +1083,8 @@ static int rtl8169_open (struct rtnet_device *rtdev)
 				priv->Rx_skbuff[i] = skb;
 			}
 			else{
-				printk("%s: Gigabit driver failed to allocate skbuff.\n", rtdev->name);
+				pr_warn("%s: Gigabit driver failed to allocate skbuff.\n",
+					rtdev->name);
 				priv->drvinit_fail = 1;
 			}
 		}
@@ -1373,7 +1379,8 @@ static int rtl8169_start_xmit (struct rtskb *skb, struct rtnet_device *rtdev)
 			skb = rtskb_padto(skb, ETH_ZLEN);
 			if (skb == NULL) {
 				/* Error... */
-				rtdm_printk("%s: Error -- rtskb_padto returned NULL; out of memory?\n", rtdev->name);
+				pr_crit("%s: Error -- rtskb_padto returned NULL; out of memory?\n",
+					rtdev->name);
 			}
 			len = ETH_ZLEN;
 		}
@@ -1426,7 +1433,8 @@ static int rtl8169_start_xmit (struct rtskb *skb, struct rtnet_device *rtdev)
 		}
 
 		if( len > priv->tx_pkt_len ){
-			rtdm_printk("%s: Error -- Tx packet size(%d) > mtu(%d)+14\n", rtdev->name, len, rtdev->mtu);
+			pr_crit("%s: Error -- Tx packet size(%d) > mtu(%d)+14\n",
+				rtdev->name, len, rtdev->mtu);
 			len = priv->tx_pkt_len;
 		}
 
@@ -1457,12 +1465,14 @@ static int rtl8169_start_xmit (struct rtskb *skb, struct rtnet_device *rtdev)
 	rtdm_lock_put_irqrestore(&priv->lock, context);	/*** RTnet ***/
 
 	if ( (priv->cur_tx - NUM_TX_DESC) == priv->dirty_tx ){
-		if (r8169_debug & DEBUG_RUN) rtdm_printk(KERN_DEBUG "%s: stopping rtnetif queue", __FUNCTION__);
+		if (r8169_debug & DEBUG_RUN)
+			pr_debug("%s: stopping rtnetif queue", __FUNCTION__);
 		rtnetif_stop_queue (rtdev);
 	}
 	else{
 		if (rtnetif_queue_stopped (rtdev)){
-			if (r8169_debug & DEBUG_RUN) rtdm_printk(KERN_DEBUG "%s: waking rtnetif queue", __FUNCTION__);
+			if (r8169_debug & DEBUG_RUN)
+				pr_debug("%s: waking rtnetif queue", __FUNCTION__);
 			rtnetif_wake_queue (rtdev);
 		}
 	}
@@ -1561,7 +1571,7 @@ static void rtl8169_rx_interrupt (struct rtnet_device *rtdev, struct rtl8169_pri
 	    rxdesc_cnt++;
 
 	    if( le32_to_cpu(rxdesc->status) & RxRES ){
-			rtdm_printk(KERN_INFO "%s: Rx ERROR!!!\n", rtdev->name);
+			pr_info("%s: Rx ERROR!!!\n", rtdev->name);
 			priv->stats.rx_errors++;
 			if ( le32_to_cpu(rxdesc->status) & (RxRWT|RxRUNT) )
 				priv->stats.rx_length_errors++;
@@ -1576,7 +1586,8 @@ static void rtl8169_rx_interrupt (struct rtnet_device *rtdev, struct rtl8169_pri
 			pkt_size=(int)(le32_to_cpu(rxdesc->status) & 0x00001FFF)-4;
 
 			if( pkt_size > priv->rx_pkt_len ){
-				rtdm_printk("%s: Error -- Rx packet size(%d) > mtu(%d)+14\n", rtdev->name, pkt_size, rtdev->mtu);
+				pr_info("%s: Error -- Rx packet size(%d) > mtu(%d)+14\n",
+					rtdev->name, pkt_size, rtdev->mtu);
 				pkt_size = priv->rx_pkt_len;
 			}
 
@@ -1725,7 +1736,7 @@ static int rtl8169_interrupt(rtdm_irq_t *irq_handle)
 	} while (boguscnt > 0);
 
 	if (boguscnt <= 0) {
-		rtdm_printk(KERN_WARNING "%s: Too much work at interrupt!\n", rtdev->name);
+		pr_warn("%s: Too much work at interrupt!\n", rtdev->name);
 		RTL_W16( IntrStatus, 0xffff);	/* Clear all interrupt sources */
 	}
 
@@ -1836,7 +1847,7 @@ static void rtl8169_set_rx_mode (struct rtnet_device *rtdev)
 
 	if (rtdev->flags & IFF_PROMISC) {
 		/* Unconditionally log net taps. */
-		printk (KERN_NOTICE "%s: Promiscuous mode enabled.\n", rtdev->name);
+		pr_notice("%s: Promiscuous mode enabled.\n", rtdev->name);
 		rx_mode = AcceptBroadcast | AcceptMulticast | AcceptMyPhys | AcceptAllPhys;
 		mc_filter[1] = mc_filter[0] = 0xffffffff;
 	} else if (rtdev->flags & IFF_ALLMULTI) {
@@ -1902,7 +1913,10 @@ static int __init rtl8169_init_module (void)
 	if (local_debug > 0) {
 		r8169_debug = local_debug;
 	}
-	if (r8169_debug & DEBUG_RUN) printk("Initializing " MODULENAME " driver");
+
+	if (r8169_debug & DEBUG_RUN)
+		pr_info("Initializing " MODULENAME " driver");
+
 	return pci_register_driver (&rtl8169_pci_driver);
 }
 
@@ -1922,8 +1936,9 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
 	struct rtl8169_private *priv = dev->priv;
 	unsigned long ioaddr = priv->ioaddr;
 
-	if( new_mtu > MAX_JUMBO_FRAME_MTU ){
-		printk("%s: Error -- new_mtu(%d) > MAX_JUMBO_FRAME_MTU(%d).\n", dev->name, new_mtu, MAX_JUMBO_FRAME_MTU);
+	if (new_mtu > MAX_JUMBO_FRAME_MTU) {
+		pr_err("%s: Error -- new_mtu(%d) > MAX_JUMBO_FRAME_MTU(%d).\n",
+		       dev->name, new_mtu, MAX_JUMBO_FRAME_MTU);
 		return -1;
 	}
 
@@ -1934,9 +1949,9 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
 	priv->rx_pkt_len = new_mtu + ETH_HDR_LEN;
 	priv->hw_rx_pkt_len = priv->rx_pkt_len + 8;
 
-	RTL_W8 ( Cfg9346, Cfg9346_Unlock);
-	RTL_W16	( RxMaxSize, (unsigned short)priv->hw_rx_pkt_len );
-	RTL_W8 ( Cfg9346, Cfg9346_Lock);
+	RTL_W8(Cfg9346, Cfg9346_Unlock);
+	RTL_W16(RxMaxSize, (unsigned short)priv->hw_rx_pkt_len);
+	RTL_W8(Cfg9346, Cfg9346_Lock);
 
 	DBG_PRINT("-------------------------- \n");
 	DBG_PRINT("dev->mtu = %d \n", dev->mtu);
@@ -1946,8 +1961,8 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
 	DBG_PRINT("RTL_W16( RxMaxSize, %d )\n", priv->hw_rx_pkt_len);
 	DBG_PRINT("-------------------------- \n");
 
-	rtl8169_close (dev);
-	rtl8169_open (dev);
+	rtl8169_close(dev);
+	rtl8169_open(dev);
 
 	return 0;
 }
@@ -1973,8 +1988,8 @@ static void rtl8169_pcierr_interrupt(struct rtnet_device *rtdev)
 	pci_read_config_word(pdev, PCI_COMMAND, &pci_cmd);
 	pci_read_config_word(pdev, PCI_STATUS, &pci_status);
 
-	rtdm_printk(KERN_ERR PFX "%s: PCI error (cmd = 0x%04x, status = 0x%04x).\n",
-	       rtdev->name, pci_cmd, pci_status);
+	pr_err("%s: PCI error (cmd = 0x%04x, status = 0x%04x).\n", rtdev->name,
+	       pci_cmd, pci_status);
 
 	/*
 	 * The recovery sequence below admits a very elaborated explanation:
@@ -1994,7 +2009,7 @@ static void rtl8169_pcierr_interrupt(struct rtnet_device *rtdev)
 	/* The infamous DAC f*ckup only happens at boot time */
 	/*** <kk> ***
 	if ((priv->cp_cmd & PCIDAC) && !priv->dirty_rx && !priv->cur_rx) {
-		rtdm_printk(KERN_INFO PFX "%s: disabling PCI DAC.\n", rtdev->name);
+		pr_info("%s: disabling PCI DAC.\n", rtdev->name);
 		priv->cp_cmd &= ~PCIDAC;
 		RTL_W16(CPlusCmd, priv->cp_cmd);
 		rtdev->features &= ~NETIF_F_HIGHDMA;

-- 
2.39.2

