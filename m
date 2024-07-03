Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C6917A58B
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013762; cv=none; b=FQIuawUMt6Ep58NhI4FEmhphZHpxH8GJ5g26iUd8VBTinLYCEnbqfbOzqW6xKlcLHsWQppU7osXWixLfVHZC7tNJdicPxG7Q0N3are22VQiPp0ArLdgfeO7uhUx4YmAKytvdLbI0qNFL0omdklu0CVVIG0AL3wpCXDUWrtoUV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013762; c=relaxed/simple;
	bh=9qrbsOpsd9pskNelCbjlEyD4ScX1ry1+mTJFoIiP7Vo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bOTy8DLKYcoHFP/qHZFYwWsWWIIrZq15xC+QV1gh2BJosbgAyJ0VSgr5JquVbp/0myvA/IQaa66PWUPWWzGLB2E9fi0ZswNx9xgYCFQXeLW73k9GTXR7i+SS2YRqB27BH2Nhx3r0Y4XtIMBdOYI57iR00/PPSUGJzG7VEp1vA/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=FFXF7JLl; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="FFXF7JLl"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2024070313254608bb020723b0a403d7
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=NQvSbazX9SiXgZd+OjvfO/eVh+8pUOAMY8tjVqsdVk4=;
 b=FFXF7JLlvEDHbBEOPc/PHo9+WroiM23DsR2VCyF8QkdumgSn6/S0fT2jFHYMw3BR2AiMSq
 p03hmLTelJKKDWTXuOGSEZIe4lowW6J5liYHUDkoWG9k0u8eTASO1/k51TGdfA9adu/xY7U1
 /4hk4bK58oigjH+jVVPv/ooSH32/E=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:45 +0200
Subject: [PATCH 22/33] drivers/r8169: Remove DBG_PRINT() macro
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-22-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

We can turn on/off the printing of debug messages by using the kernel
infrastructure around dynamic_debug and DEBUG. We can decouple that
from the driver specific RTL8169_DEBUG.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/drivers/r8169.c | 66 ++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/kernel/drivers/net/drivers/r8169.c b/kernel/drivers/net/drivers/r8169.c
index 22d2697b0..8f57752ad 100644
--- a/kernel/drivers/net/drivers/r8169.c
+++ b/kernel/drivers/net/drivers/r8169.c
@@ -102,11 +102,9 @@ RTL8169_VERSION "2.2"	<2004/08/09>
 	/*** RTnet / <kk>: rt_assert must be used instead of assert() within interrupt context! ***/
 	#define rt_assert(expr) \
 		if(!(expr)) { pr_err("Assertion failed! %s,%s,%s,line=%d\n", #expr,__FILE__,__FUNCTION__,__LINE__); }
-	#define DBG_PRINT( fmt, args...)   pr_debug(fmt, ## args);
 #else
 	#define assert(expr) do {} while (0)
 	#define rt_assert(expr) do {} while (0)
-	#define DBG_PRINT( fmt, args...)   ;
 #endif	// end of #ifdef RTL8169_DEBUG
 
 /* media options */
@@ -815,13 +813,13 @@ static int rtl8169_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	priv->hw_rx_pkt_len = priv->rx_pkt_len + 8;
 //#endif //end #ifdef RTL8169_JUMBO_FRAME_SUPPORT
 
-	DBG_PRINT("-------------------------- \n");
-	DBG_PRINT("dev->mtu = %d \n", rtdev->mtu);
-	DBG_PRINT("priv->curr_mtu_size = %d \n", priv->curr_mtu_size);
-	DBG_PRINT("priv->tx_pkt_len = %d \n", priv->tx_pkt_len);
-	DBG_PRINT("priv->rx_pkt_len = %d \n", priv->rx_pkt_len);
-	DBG_PRINT("priv->hw_rx_pkt_len = %d \n", priv->hw_rx_pkt_len);
-	DBG_PRINT("-------------------------- \n");
+	pr_debug("-------------------------- \n");
+	pr_debug("dev->mtu = %d \n", rtdev->mtu);
+	pr_debug("priv->curr_mtu_size = %d \n", priv->curr_mtu_size);
+	pr_debug("priv->tx_pkt_len = %d \n", priv->tx_pkt_len);
+	pr_debug("priv->rx_pkt_len = %d \n", priv->rx_pkt_len);
+	pr_debug("priv->hw_rx_pkt_len = %d \n", priv->hw_rx_pkt_len);
+	pr_debug("-------------------------- \n");
 
 	rtdm_lock_init(&priv->lock);	/*** RTnet ***/
 
@@ -848,18 +846,18 @@ static int rtl8169_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	// Config PHY
 	rtl8169_hw_PHY_config(rtdev);
 
-	DBG_PRINT("Set MAC Reg C+CR Offset 0x82h = 0x01h\n");
+	pr_debug("Set MAC Reg C+CR Offset 0x82h = 0x01h\n");
 	RTL_W8( 0x82, 0x01 );
 
 	if( priv->mcfg < MCFG_METHOD_3 ){
-		DBG_PRINT("Set PCI Latency=0x40\n");
+		pr_debug("Set PCI Latency=0x40\n");
 		pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0x40);
 	}
 
 	if( priv->mcfg == MCFG_METHOD_2 ){
-		DBG_PRINT("Set MAC Reg C+CR Offset 0x82h = 0x01h\n");
+		pr_debug("Set MAC Reg C+CR Offset 0x82h = 0x01h\n");
 		RTL_W8( 0x82, 0x01 );
-		DBG_PRINT("Set PHY Reg 0x0bh = 0x00h\n");
+		pr_debug("Set PHY Reg 0x0bh = 0x00h\n");
 		RTL8169_WRITE_GMII_REG( ioaddr, 0x0b, 0x0000 );	//w 0x0b 15 0 0
 	}
 
@@ -957,12 +955,12 @@ static int rtl8169_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 				priv->linkstatus = (option & FullDup) ? _10_Full : _10_Half;
 			}
 		}
-		DBG_PRINT("priv->linkstatus = 0x%02x\n", priv->linkstatus);
+		pr_debug("priv->linkstatus = 0x%02x\n", priv->linkstatus);
 
 	}// end of TBI is not enabled
 	else{
 		udelay(100);
-		DBG_PRINT("1000Mbps Full-duplex operation, TBI Link %s!\n",(RTL_R32(TBICSR) & TBILinkOK) ? "OK" : "Failed" );
+		pr_debug("1000Mbps Full-duplex operation, TBI Link %s!\n",(RTL_R32(TBICSR) & TBILinkOK) ? "OK" : "Failed" );
 
 	}// end of TBI is not enabled
 
@@ -1094,7 +1092,7 @@ static int rtl8169_open (struct rtnet_device *rtdev)
 
 	// ------------------------------------------------------
 
-	//DBG_PRINT("%s: %s() alloc_rxskb_cnt = %d\n", dev->name, __FUNCTION__, alloc_rxskb_cnt );	/*** <kk> won't work anymore... ***/
+	//pr_debug("%s: %s() alloc_rxskb_cnt = %d\n", dev->name, __FUNCTION__, alloc_rxskb_cnt );	/*** <kk> won't work anymore... ***/
 
 	return 0;
 
@@ -1117,7 +1115,7 @@ static void rtl8169_hw_PHY_config (struct rtnet_device *rtdev)
 	struct rtl8169_private *priv = rtdev->priv;
 	void *ioaddr = (void*)priv->ioaddr;
 
-	DBG_PRINT("priv->mcfg=%d, priv->pcfg=%d\n",priv->mcfg,priv->pcfg);
+	pr_debug("priv->mcfg=%d, priv->pcfg=%d\n",priv->mcfg,priv->pcfg);
 
 	if( priv->mcfg == MCFG_METHOD_4 ){
 		RTL8169_WRITE_GMII_REG( (unsigned long)ioaddr, 0x1F, 0x0001 );
@@ -1172,7 +1170,7 @@ static void rtl8169_hw_PHY_config (struct rtnet_device *rtdev)
 		RTL8169_WRITE_GMII_REG( (unsigned long)ioaddr, 0x0B, 0x0000 );
 	}
 	else{
-		DBG_PRINT("priv->mcfg=%d. Discard hw PHY config.\n",priv->mcfg);
+		pr_debug("priv->mcfg=%d. Discard hw PHY config.\n",priv->mcfg);
 	}
 }
 
@@ -1225,12 +1223,12 @@ static void rtl8169_hw_start (struct rtnet_device *rtdev)
 		priv->mcfg == MCFG_METHOD_3)
 	{
 		RTL_W16( CPlusCmd, (RTL_R16(CPlusCmd)|(1<<14)|(1<<3)) );
-		DBG_PRINT("Set MAC Reg C+CR Offset 0xE0: bit-3 and bit-14\n");
+		pr_debug("Set MAC Reg C+CR Offset 0xE0: bit-3 and bit-14\n");
 	}
 	else
 	{
 		RTL_W16( CPlusCmd, (RTL_R16(CPlusCmd)|(1<<3)) );
-		DBG_PRINT("Set MAC Reg C+CR Offset 0xE0: bit-3.\n");
+		pr_debug("Set MAC Reg C+CR Offset 0xE0: bit-3.\n");
 	}
 
 	{
@@ -1308,7 +1306,7 @@ static void rtl8169_init_ring (struct rtnet_device *rtdev)
 				priv->RxDescArray[i].buf_Haddr = 0;
 			}
 			else{
-				DBG_PRINT("%s: %s() Rx_skbuff == NULL\n", rtdev->name, __FUNCTION__);
+				pr_debug("%s: %s() Rx_skbuff == NULL\n", rtdev->name, __FUNCTION__);
 				priv->drvinit_fail = 1;
 			}
 		}//-----------------------------------------------------------------------
@@ -1424,7 +1422,7 @@ static int rtl8169_start_xmit (struct rtskb *skb, struct rtnet_device *rtdev)
 			}
 
 			/* print frame informations */
-			DBG_PRINT("%s: TX len = %d, skb->len = %d, eth_proto=%04x\n", __FUNCTION__, len, skb->len, proto);
+			pr_debug("%s: TX len = %d, skb->len = %d, eth_proto=%04x\n", __FUNCTION__, len, skb->len, proto);
 
 			break;	/* leave loop */
 		}
@@ -1618,7 +1616,7 @@ static void rtl8169_rx_interrupt (struct rtnet_device *rtdev, struct rtl8169_pri
 					priv->Rx_skbuff[cur_rx] = n_skb;
 				}
 				else{
-					DBG_PRINT("%s: Allocate n_skb failed! (priv->rx_buf_size = %d)\n",__FUNCTION__, priv->rx_buf_size );
+					pr_debug("%s: Allocate n_skb failed! (priv->rx_buf_size = %d)\n",__FUNCTION__, priv->rx_buf_size );
 					priv->Rx_skbuff[cur_rx] = rx_skb;
 				}
 
@@ -1638,7 +1636,7 @@ static void rtl8169_rx_interrupt (struct rtnet_device *rtdev, struct rtl8169_pri
 					rxdesc->buf_addr = cpu_to_le32(priv->rx_skbuff_dma_addr[cur_rx]);
 				}
 				else{
-					DBG_PRINT("%s: %s() cur_skb == NULL\n", rtdev->name, __FUNCTION__);
+					pr_debug("%s: %s() cur_skb == NULL\n", rtdev->name, __FUNCTION__);
 				}
 
 			}//------------------------------------------------------------
@@ -1652,7 +1650,7 @@ static void rtl8169_rx_interrupt (struct rtnet_device *rtdev, struct rtl8169_pri
 	}// end of while ( (priv->RxDescArray[cur_rx].status & 0x80000000)== 0)
 
 	if( rxdesc_cnt >= max_interrupt_work ){
-		DBG_PRINT("%s: Too much work at Rx interrupt.\n", rtdev->name);
+		pr_debug("%s: Too much work at Rx interrupt.\n", rtdev->name);
 	}
 
 	priv->cur_rx = cur_rx;
@@ -1704,7 +1702,7 @@ static int rtl8169_interrupt(rtdm_irq_t *irq_handle)
 		}
 
 		if (unlikely(status & SYSErr)) {
-			DBG_PRINT("PCI error...!? %i\n", __LINE__);
+			pr_debug("PCI error...!? %i\n", __LINE__);
 			rtl8169_pcierr_interrupt(rtdev);
 			break;
 		}
@@ -1820,7 +1818,7 @@ static int rtl8169_close (struct rtnet_device *rtdev)
 		}
 	}//-----------------------------------------------------------------------------
 
-	//DBG_PRINT("%s: %s() alloc_rxskb_cnt = %d\n", dev->name, __FUNCTION__, alloc_rxskb_cnt );	/*** <kk> won't work anymore ***/
+	//pr_debug("%s: %s() alloc_rxskb_cnt = %d\n", dev->name, __FUNCTION__, alloc_rxskb_cnt );	/*** <kk> won't work anymore ***/
 
 	return 0;
 }
@@ -1950,13 +1948,13 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
 	RTL_W16(RxMaxSize, (unsigned short)priv->hw_rx_pkt_len);
 	RTL_W8(Cfg9346, Cfg9346_Lock);
 
-	DBG_PRINT("-------------------------- \n");
-	DBG_PRINT("dev->mtu = %d \n", dev->mtu);
-	DBG_PRINT("priv->curr_mtu_size = %d \n", priv->curr_mtu_size);
-	DBG_PRINT("priv->rx_pkt_len = %d \n", priv->rx_pkt_len);
-	DBG_PRINT("priv->tx_pkt_len = %d \n", priv->tx_pkt_len);
-	DBG_PRINT("RTL_W16( RxMaxSize, %d )\n", priv->hw_rx_pkt_len);
-	DBG_PRINT("-------------------------- \n");
+	pr_debug("-------------------------- \n");
+	pr_debug("dev->mtu = %d \n", dev->mtu);
+	pr_debug("priv->curr_mtu_size = %d \n", priv->curr_mtu_size);
+	pr_debug("priv->rx_pkt_len = %d \n", priv->rx_pkt_len);
+	pr_debug("priv->tx_pkt_len = %d \n", priv->tx_pkt_len);
+	pr_debug("RTL_W16( RxMaxSize, %d )\n", priv->hw_rx_pkt_len);
+	pr_debug("-------------------------- \n");
 
 	rtl8169_close(dev);
 	rtl8169_open(dev);

-- 
2.39.2

