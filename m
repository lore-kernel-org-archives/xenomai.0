Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE84F469C
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:09:09 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id D4172C93BB
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:44 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 822251C0018
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:37 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 3A9DFD807E4
	for <xenomai@xenomai.org>; Mon,  4 Jul 2022 13:08:37 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202207041308369bd0069e348de85847
        for <xenomai@xenomai.org>;
        Mon, 04 Jul 2022 15:08:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=kKq+qTA/CWJKUn+YgvbouHWBNIdfA/GtVOd+4kNMuXo=;
 b=K53g0RluwP59lmPI9N0398X0qZElFM7f+D9zfgcrrHE8PAE0hTz3H/61U8cRecr2gE2whS
 /iyJxYjn98sj0AmwYa0SE4NUKsdBAiiGM93g4SX3iQsRj03aXRX5u54+lBBY3kqAg/FUSf6S
 uA8uTczmM7harjl3/wWtM/RS+2Uuc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [PATCH 09/15] drivers: Convert pci_dma_sync_single_for_cpu/device to DMA API
Date: Mon,  4 Jul 2022 15:08:29 +0200
Message-Id: <f61203bf2d35d0c6cbc04e6a83b70e63cdf20946.1656940114.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1656940114.git.jan.kiszka@siemens.com>
References: <cover.1656940114.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool5: domain of rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) client-ip=185.136.64.228; envelope-from=fm-294854-202207041308369bd0069e348de85847-fT_VGZ@rts-flowmailer.siemens.com; helo=mta-64-228.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=K53g0Rlu;
	dmarc=pass (policy=none) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-202207041308369bd0069e348de85847-fT_VGZ@rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) smtp.mailfrom=fm-294854-202207041308369bd0069e348de85847-fT_VGZ@rts-flowmailer.siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

The legacy API has been finally dropped, and the new one was "already"
available with 5.10.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/eepro100.c | 26 ++++++++++++++------------
 kernel/drivers/net/drivers/r8169.c    | 10 +++++-----
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/kernel/drivers/net/drivers/eepro100.c b/kernel/drivers/net/drivers/eepro100.c
index 74385d61d2..1985befe7b 100644
--- a/kernel/drivers/net/drivers/eepro100.c
+++ b/kernel/drivers/net/drivers/eepro100.c
@@ -1076,8 +1076,9 @@ speedo_init_rx_ring(struct rtnet_device *rtdev)
 		rtskb_reserve(skb, sizeof(struct RxFD));
 		if (last_rxf) {
 			last_rxf->link = cpu_to_le32(sp->rx_ring_dma[i]);
-			pci_dma_sync_single_for_device(sp->pdev, last_rxf_dma,
-					sizeof(struct RxFD), PCI_DMA_TODEVICE);
+			dma_sync_single_for_device(&sp->pdev->dev, last_rxf_dma,
+						   sizeof(struct RxFD),
+						   DMA_TO_DEVICE);
 		}
 		last_rxf = rxf;
 		last_rxf_dma = sp->rx_ring_dma[i];
@@ -1086,14 +1087,15 @@ speedo_init_rx_ring(struct rtnet_device *rtdev)
 		/* This field unused by i82557. */
 		rxf->rx_buf_addr = 0xffffffff;
 		rxf->count = cpu_to_le32(PKT_BUF_SZ << 16);
-		pci_dma_sync_single_for_device(sp->pdev, sp->rx_ring_dma[i],
-				sizeof(struct RxFD), PCI_DMA_TODEVICE);
+		dma_sync_single_for_device(&sp->pdev->dev, sp->rx_ring_dma[i],
+					   sizeof(struct RxFD), DMA_TO_DEVICE);
 	}
 	sp->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
 	/* Mark the last entry as end-of-list. */
 	last_rxf->status = cpu_to_le32(0xC0000002);	/* '2' is flag value only. */
-	pci_dma_sync_single_for_device(sp->pdev, sp->rx_ring_dma[RX_RING_SIZE-1],
-			sizeof(struct RxFD), PCI_DMA_TODEVICE);
+	dma_sync_single_for_device(&sp->pdev->dev,
+				   sp->rx_ring_dma[RX_RING_SIZE-1],
+				   sizeof(struct RxFD), DMA_TO_DEVICE);
 	sp->last_rxf = last_rxf;
 	sp->last_rxf_dma = last_rxf_dma;
 }
@@ -1400,8 +1402,8 @@ static inline struct RxFD *speedo_rx_alloc(struct rtnet_device *rtdev, int entry
 			       DMA_FROM_DEVICE);
 	rtskb_reserve(skb, sizeof(struct RxFD));
 	rxf->rx_buf_addr = 0xffffffff;
-	pci_dma_sync_single_for_device(sp->pdev, sp->rx_ring_dma[entry],
-			sizeof(struct RxFD), PCI_DMA_TODEVICE);
+	dma_sync_single_for_device(&sp->pdev->dev, sp->rx_ring_dma[entry],
+				   sizeof(struct RxFD), DMA_TO_DEVICE);
 	return rxf;
 }
 
@@ -1414,8 +1416,8 @@ static inline void speedo_rx_link(struct rtnet_device *rtdev, int entry,
 	rxf->count = cpu_to_le32(PKT_BUF_SZ << 16);
 	sp->last_rxf->link = cpu_to_le32(rxf_dma);
 	sp->last_rxf->status &= cpu_to_le32(~0xC0000000);
-	pci_dma_sync_single_for_device(sp->pdev, sp->last_rxf_dma,
-			sizeof(struct RxFD), PCI_DMA_TODEVICE);
+	dma_sync_single_for_device(&sp->pdev->dev, sp->last_rxf_dma,
+				   sizeof(struct RxFD), DMA_TO_DEVICE);
 	sp->last_rxf = rxf;
 	sp->last_rxf_dma = rxf_dma;
 }
@@ -1487,8 +1489,8 @@ speedo_rx(struct rtnet_device *rtdev, int* packets, nanosecs_abs_t *time_stamp)
 		int status;
 		int pkt_len;
 
-		pci_dma_sync_single_for_cpu(sp->pdev, sp->rx_ring_dma[entry],
-			sizeof(struct RxFD), PCI_DMA_FROMDEVICE);
+		dma_sync_single_for_cpu(&sp->pdev->dev, sp->rx_ring_dma[entry],
+					sizeof(struct RxFD), DMA_FROM_DEVICE);
 		status = le32_to_cpu(sp->rx_ringp[entry]->status);
 		pkt_len = le32_to_cpu(sp->rx_ringp[entry]->count) & 0x3fff;
 
diff --git a/kernel/drivers/net/drivers/r8169.c b/kernel/drivers/net/drivers/r8169.c
index 498b998188..7f280dd765 100644
--- a/kernel/drivers/net/drivers/r8169.c
+++ b/kernel/drivers/net/drivers/r8169.c
@@ -1310,7 +1310,7 @@ static void rtl8169_init_ring (struct rtnet_device *rtdev)
 			}
 		}//-----------------------------------------------------------------------
 		priv->rxdesc_array_dma_addr[i] = dma_map_single(&pdev->dev, &priv->RxDescArray[i], sizeof(struct RxDesc), DMA_TO_DEVICE);
-		pci_dma_sync_single_for_device(pdev, priv->rxdesc_array_dma_addr[i], sizeof(struct RxDesc), PCI_DMA_TODEVICE);
+		dma_sync_single_for_device(&pdev->dev, priv->rxdesc_array_dma_addr[i], sizeof(struct RxDesc), DMA_TO_DEVICE);
 	}
 }
 
@@ -1444,7 +1444,7 @@ static int rtl8169_start_xmit (struct rtskb *skb, struct rtnet_device *rtdev)
 		}
 		priv->TxDescArray[entry].status = cpu_to_le32(status);
 
-		pci_dma_sync_single_for_device(pdev, priv->txdesc_array_dma_addr[entry], sizeof(struct TxDesc), PCI_DMA_TODEVICE);
+		dma_sync_single_for_device(&pdev->dev, priv->txdesc_array_dma_addr[entry], sizeof(struct TxDesc), DMA_TO_DEVICE);
 
 		RTL_W8 ( TxPoll, 0x40);		//set polling bit
 
@@ -1554,7 +1554,7 @@ static void rtl8169_rx_interrupt (struct rtnet_device *rtdev, struct rtl8169_pri
 	cur_rx = priv->cur_rx;
 
 	rxdesc = &priv->RxDescArray[cur_rx];
-	pci_dma_sync_single_for_cpu(pdev, priv->rxdesc_array_dma_addr[cur_rx], sizeof(struct RxDesc), PCI_DMA_FROMDEVICE);
+	dma_sync_single_for_cpu(&pdev->dev, priv->rxdesc_array_dma_addr[cur_rx], sizeof(struct RxDesc), DMA_FROM_DEVICE);
 
 	while ( ((le32_to_cpu(rxdesc->status) & OWNbit)== 0) && (rxdesc_cnt < max_interrupt_work) ){
 
@@ -1589,7 +1589,7 @@ static void rtl8169_rx_interrupt (struct rtnet_device *rtdev, struct rtl8169_pri
 
 					// Indicate rx_skb
 					if( rx_skb != NULL ){
-						pci_dma_sync_single_for_cpu(pdev, priv->rx_skbuff_dma_addr[cur_rx], sizeof(struct RxDesc), PCI_DMA_FROMDEVICE);
+						dma_sync_single_for_cpu(&pdev->dev, priv->rx_skbuff_dma_addr[cur_rx], sizeof(struct RxDesc), DMA_FROM_DEVICE);
 
 						rtskb_put ( rx_skb, pkt_size );
 						rx_skb->protocol = rt_eth_type_trans ( rx_skb, rtdev );
@@ -1639,7 +1639,7 @@ static void rtl8169_rx_interrupt (struct rtnet_device *rtdev, struct rtl8169_pri
 
 	    cur_rx = (cur_rx +1) % NUM_RX_DESC;
 	    rxdesc = &priv->RxDescArray[cur_rx];
-	    pci_dma_sync_single_for_cpu(pdev, priv->rxdesc_array_dma_addr[cur_rx], sizeof(struct RxDesc), PCI_DMA_FROMDEVICE);
+	    dma_sync_single_for_cpu(&pdev->dev, priv->rxdesc_array_dma_addr[cur_rx], sizeof(struct RxDesc), DMA_FROM_DEVICE);
 
 	}// end of while ( (priv->RxDescArray[cur_rx].status & 0x80000000)== 0)
 
-- 
2.35.3

