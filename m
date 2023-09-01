Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A50C8F1
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 19:45:33 +0000 (UTC)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202309011945308fc4b8ca38547a814d
        for <xenomai@lists.linux.dev>;
        Fri, 01 Sep 2023 21:45:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=tu6rlbnk5g1mHlRuwRE1cEW/gH+Zfcs3WKIGySwP3m8=;
 b=Qah33biEkg9I4FS0YoXTxibebQiJrhDUwMN5l2f4QIPRA/Q7NEo8albTG0CpPG71jmKBS7
 6zyq7rfv2n3irvSFRnQ/ggb5Yh/K40dHesnNmESB51dw+IkvwXu7ZYxqfrzu/pKNkYUuLCM3
 YQbPh63r9dWkLdoKE7eSHjhUulObs=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 01 Sep 2023 21:45:30 +0200
Subject: [PATCH stable/v3.2.x v2 07/17] drivers: Convert
 pci_map/unmap_single/page to DMA API
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v2-7-5189cfb05a62@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

[ master commit 602a7f10a722a3c99a89503bc97edcfe2c07f482 ]

The legacy API has been finally dropped, and the new one was "already"
available with 5.10.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/e1000/e1000_main.c      | 32 ++++++------
 kernel/drivers/net/drivers/eepro100.c              | 35 +++++++------
 .../net/drivers/experimental/e1000/e1000_main.c    | 60 +++++++++++-----------
 kernel/drivers/net/drivers/natsemi.c               | 29 ++++++-----
 kernel/drivers/net/drivers/pcnet32.c               | 34 ++++++------
 kernel/drivers/net/drivers/r8169.c                 | 12 ++---
 kernel/drivers/net/drivers/tulip/interrupt.c       | 18 ++++---
 kernel/drivers/net/drivers/tulip/tulip_core.c      | 27 +++++-----
 kernel/drivers/net/drivers/via-rhine.c             | 36 +++++++------
 9 files changed, 149 insertions(+), 134 deletions(-)

diff --git a/kernel/drivers/net/drivers/e1000/e1000_main.c b/kernel/drivers/net/drivers/e1000/e1000_main.c
index 7c34e2f00..726b38ab8 100644
--- a/kernel/drivers/net/drivers/e1000/e1000_main.c
+++ b/kernel/drivers/net/drivers/e1000/e1000_main.c
@@ -1809,10 +1809,10 @@ e1000_unmap_and_free_tx_resource(struct e1000_adapter *adapter,
 			struct e1000_buffer *buffer_info)
 {
 	if (buffer_info->dma) {
-		pci_unmap_page(adapter->pdev,
-				buffer_info->dma,
-				buffer_info->length,
-				PCI_DMA_TODEVICE);
+		dma_unmap_page(&adapter->pdev->dev,
+			       buffer_info->dma,
+			       buffer_info->length,
+			       DMA_TO_DEVICE);
 	}
 	if (buffer_info->skb)
 		kfree_rtskb(buffer_info->skb);
@@ -1933,10 +1933,10 @@ e1000_clean_rx_ring(struct e1000_adapter *adapter,
 	for (i = 0; i < rx_ring->count; i++) {
 		buffer_info = &rx_ring->buffer_info[i];
 		if (buffer_info->skb) {
-			pci_unmap_single(pdev,
+			dma_unmap_single(&pdev->dev,
 					 buffer_info->dma,
 					 buffer_info->length,
-					 PCI_DMA_FROMDEVICE);
+					 DMA_FROM_DEVICE);
 
 			kfree_rtskb(buffer_info->skb);
 			buffer_info->skb = NULL;
@@ -2382,10 +2382,10 @@ e1000_tx_map(struct e1000_adapter *adapter, struct e1000_tx_ring *tx_ring,
 
 		buffer_info->length = size;
 		buffer_info->dma =
-			pci_map_single(adapter->pdev,
-				skb->data + offset,
-				size,
-				PCI_DMA_TODEVICE);
+			dma_map_single(&adapter->pdev->dev,
+				       skb->data + offset,
+				       size,
+				       DMA_TO_DEVICE);
 		buffer_info->time_stamp = jiffies;
 
 		len -= size;
@@ -2850,10 +2850,10 @@ e1000_clean_rx_irq(struct e1000_adapter *adapter,
 
 		cleaned = TRUE;
 		cleaned_count++;
-		pci_unmap_single(pdev,
+		dma_unmap_single(&pdev->dev,
 				 buffer_info->dma,
 				 buffer_info->length,
-				 PCI_DMA_FROMDEVICE);
+				 DMA_FROM_DEVICE);
 
 		length = le16_to_cpu(rx_desc->length);
 
@@ -2985,10 +2985,10 @@ e1000_alloc_rx_buffers(struct e1000_adapter *adapter,
 		buffer_info->skb = skb;
 		buffer_info->length = adapter->rx_buffer_len;
 map_skb:
-		buffer_info->dma = pci_map_single(pdev,
+		buffer_info->dma = dma_map_single(&pdev->dev,
 						  skb->data,
 						  adapter->rx_buffer_len,
-						  PCI_DMA_FROMDEVICE);
+						  DMA_FROM_DEVICE);
 
 		/* Fix for errata 23, can't cross 64kB boundary */
 		if (!e1000_check_64k_bound(adapter,
@@ -3001,9 +3001,9 @@ map_skb:
 			kfree_rtskb(skb);
 			buffer_info->skb = NULL;
 
-			pci_unmap_single(pdev, buffer_info->dma,
+			dma_unmap_single(&pdev->dev, buffer_info->dma,
 					 adapter->rx_buffer_len,
-					 PCI_DMA_FROMDEVICE);
+					 DMA_FROM_DEVICE);
 
 			break; /* while !buffer_info->skb */
 		}
diff --git a/kernel/drivers/net/drivers/eepro100.c b/kernel/drivers/net/drivers/eepro100.c
index 64507756c..74385d61d 100644
--- a/kernel/drivers/net/drivers/eepro100.c
+++ b/kernel/drivers/net/drivers/eepro100.c
@@ -1070,8 +1070,9 @@ speedo_init_rx_ring(struct rtnet_device *rtdev)
 		rxf = (struct RxFD *)skb->tail;
 		sp->rx_ringp[i] = rxf;
 		sp->rx_ring_dma[i] =
-			pci_map_single(sp->pdev, rxf,
-					PKT_BUF_SZ + sizeof(struct RxFD), PCI_DMA_BIDIRECTIONAL);
+			dma_map_single(&sp->pdev->dev, rxf,
+				       PKT_BUF_SZ + sizeof(struct RxFD),
+				       DMA_BIDIRECTIONAL);
 		rtskb_reserve(skb, sizeof(struct RxFD));
 		if (last_rxf) {
 			last_rxf->link = cpu_to_le32(sp->rx_ring_dma[i]);
@@ -1139,8 +1140,8 @@ speedo_start_xmit(struct rtskb *skb, struct rtnet_device *rtdev)
 	/* The data region is always in one buffer descriptor. */
 	sp->tx_ring[entry].count = cpu_to_le32(sp->tx_threshold);
 	sp->tx_ring[entry].tx_buf_addr0 =
-		cpu_to_le32(pci_map_single(sp->pdev, skb->data,
-					   skb->len, PCI_DMA_TODEVICE));
+		cpu_to_le32(dma_map_single(&sp->pdev->dev, skb->data,
+					   skb->len, DMA_TO_DEVICE));
 	sp->tx_ring[entry].tx_buf_size0 = cpu_to_le32(skb->len);
 
 // *** RTnet ***
@@ -1206,9 +1207,9 @@ static void speedo_tx_buffer_gc(struct rtnet_device *rtdev)
 		if (sp->tx_skbuff[entry]) {
 			sp->stats.tx_packets++;	/* Count only user packets. */
 			sp->stats.tx_bytes += sp->tx_skbuff[entry]->len;
-			pci_unmap_single(sp->pdev,
-					le32_to_cpu(sp->tx_ring[entry].tx_buf_addr0),
-					sp->tx_skbuff[entry]->len, PCI_DMA_TODEVICE);
+			dma_unmap_single(&sp->pdev->dev,
+					 le32_to_cpu(sp->tx_ring[entry].tx_buf_addr0),
+					 sp->tx_skbuff[entry]->len, DMA_TO_DEVICE);
 
 			// *** RTnet ***
 			dev_kfree_rtskb(sp->tx_skbuff[entry]);
@@ -1394,8 +1395,9 @@ static inline struct RxFD *speedo_rx_alloc(struct rtnet_device *rtdev, int entry
 	rtskb_reserve(skb, 2);  /* IP header alignment */
 	rxf = sp->rx_ringp[entry] = (struct RxFD *)skb->tail;
 	sp->rx_ring_dma[entry] =
-		pci_map_single(sp->pdev, rxf,
-					   PKT_BUF_SZ + sizeof(struct RxFD), PCI_DMA_FROMDEVICE);
+		dma_map_single(&sp->pdev->dev, rxf,
+			       PKT_BUF_SZ + sizeof(struct RxFD),
+			       DMA_FROM_DEVICE);
 	rtskb_reserve(skb, sizeof(struct RxFD));
 	rxf->rx_buf_addr = 0xffffffff;
 	pci_dma_sync_single_for_device(sp->pdev, sp->rx_ring_dma[entry],
@@ -1538,8 +1540,10 @@ speedo_rx(struct rtnet_device *rtdev, int* packets, nanosecs_abs_t *time_stamp)
 				sp->rx_skbuff[entry] = NULL;
 				rtskb_put(skb, pkt_len);
 				sp->rx_ringp[entry] = NULL;
-				pci_unmap_single(sp->pdev, sp->rx_ring_dma[entry],
-						PKT_BUF_SZ + sizeof(struct RxFD), PCI_DMA_FROMDEVICE);
+				dma_unmap_single(&sp->pdev->dev,
+						 sp->rx_ring_dma[entry],
+						 PKT_BUF_SZ + sizeof(struct RxFD),
+						 DMA_FROM_DEVICE);
 			}
 			skb->protocol = rt_eth_type_trans(skb, rtdev);
 			//rtmac
@@ -1608,9 +1612,10 @@ speedo_close(struct rtnet_device *rtdev)
 		sp->rx_skbuff[i] = 0;
 		/* Clear the Rx descriptors. */
 		if (skb) {
-			pci_unmap_single(sp->pdev,
+			dma_unmap_single(&sp->pdev->dev,
 					 sp->rx_ring_dma[i],
-					 PKT_BUF_SZ + sizeof(struct RxFD), PCI_DMA_FROMDEVICE);
+					 PKT_BUF_SZ + sizeof(struct RxFD),
+					 DMA_FROM_DEVICE);
 			dev_kfree_rtskb(skb);
 		}
 	}
@@ -1620,9 +1625,9 @@ speedo_close(struct rtnet_device *rtdev)
 		sp->tx_skbuff[i] = 0;
 		/* Clear the Tx descriptors. */
 		if (skb) {
-			pci_unmap_single(sp->pdev,
+			dma_unmap_single(&sp->pdev->dev,
 					 le32_to_cpu(sp->tx_ring[i].tx_buf_addr0),
-					 skb->len, PCI_DMA_TODEVICE);
+					 skb->len, DMA_TO_DEVICE);
 
 			// *** RTnet ***
 			dev_kfree_rtskb(skb);
diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
index d32c5f361..3bd82cf59 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
@@ -2594,10 +2594,10 @@ static void e1000_unmap_and_free_tx_resource(struct e1000_adapter *adapter,
 					     struct e1000_buffer *buffer_info)
 {
 	if (buffer_info->dma) {
-		pci_unmap_page(adapter->pdev,
-				buffer_info->dma,
-				buffer_info->length,
-				PCI_DMA_TODEVICE);
+		dma_unmap_page(&adapter->pdev->dev,
+			       buffer_info->dma,
+			       buffer_info->length,
+			       DMA_TO_DEVICE);
 		buffer_info->dma = 0;
 	}
 	if (buffer_info->skb) {
@@ -2714,20 +2714,20 @@ static void e1000_clean_rx_ring(struct e1000_adapter *adapter,
 		buffer_info = &rx_ring->buffer_info[i];
 		if (buffer_info->dma &&
 		    adapter->clean_rx == e1000_clean_rx_irq) {
-			pci_unmap_single(pdev, buffer_info->dma,
+			dma_unmap_single(&pdev->dev, buffer_info->dma,
 					 adapter->rx_buffer_len,
-					 PCI_DMA_FROMDEVICE);
+					 DMA_FROM_DEVICE);
 #ifdef CONFIG_E1000_NAPI
 		} else if (buffer_info->dma &&
 			   adapter->clean_rx == e1000_clean_jumbo_rx_irq) {
-			pci_unmap_page(pdev, buffer_info->dma, PAGE_SIZE,
-				       PCI_DMA_FROMDEVICE);
+			dma_unmap_page(&pdev->dev, buffer_info->dma, PAGE_SIZE,
+				       DMA_FROM_DEVICE);
 #endif
 		} else if (buffer_info->dma &&
 			   adapter->clean_rx == e1000_clean_rx_irq_ps) {
-			pci_unmap_single(pdev, buffer_info->dma,
+			dma_unmap_single(&pdev->dev, buffer_info->dma,
 					 adapter->rx_ps_bsize0,
-					 PCI_DMA_FROMDEVICE);
+					 DMA_FROM_DEVICE);
 		}
 		buffer_info->dma = 0;
 		if (buffer_info->page) {
@@ -2742,9 +2742,9 @@ static void e1000_clean_rx_ring(struct e1000_adapter *adapter,
 		ps_page_dma = &rx_ring->ps_page_dma[i];
 		for (j = 0; j < adapter->rx_ps_pages; j++) {
 			if (!ps_page->ps_page[j]) break;
-			pci_unmap_page(pdev,
+			dma_unmap_page(&pdev->dev,
 				       ps_page_dma->ps_page_dma[j],
-				       PAGE_SIZE, PCI_DMA_FROMDEVICE);
+				       PAGE_SIZE, DMA_FROM_DEVICE);
 			ps_page_dma->ps_page_dma[j] = 0;
 			put_page(ps_page->ps_page[j]);
 			ps_page->ps_page[j] = NULL;
@@ -3488,10 +3488,10 @@ static int e1000_tx_map(struct e1000_adapter *adapter,
 		/* set time_stamp *before* dma to help avoid a possible race */
 		buffer_info->time_stamp = jiffies;
 		buffer_info->dma =
-			pci_map_single(adapter->pdev,
+			dma_map_single(&adapter->pdev->dev,
 				skb->data + offset,
 				size,
-				PCI_DMA_TODEVICE);
+				DMA_TO_DEVICE);
 		buffer_info->next_to_watch = i;
 
 		len -= size;
@@ -3528,11 +3528,11 @@ static int e1000_tx_map(struct e1000_adapter *adapter,
 			buffer_info->length = size;
 			buffer_info->time_stamp = jiffies;
 			buffer_info->dma =
-				pci_map_page(adapter->pdev,
+				dma_map_page(&adapter->pdev->dev,
 					frag->page,
 					offset,
 					size,
-					PCI_DMA_TODEVICE);
+					DMA_TO_DEVICE);
 			buffer_info->next_to_watch = i;
 
 			len -= size;
@@ -4724,10 +4724,10 @@ static bool e1000_clean_jumbo_rx_irq(struct e1000_adapter *adapter,
 
 		cleaned = TRUE;
 		cleaned_count++;
-		pci_unmap_page(pdev,
+		dma_unmap_page(&pdev->dev,
 			       buffer_info->dma,
 			       PAGE_SIZE,
-			       PCI_DMA_FROMDEVICE);
+			       DMA_FROM_DEVICE);
 		buffer_info->dma = 0;
 
 		length = le16_to_cpu(rx_desc->length);
@@ -4929,10 +4929,10 @@ static bool e1000_clean_rx_irq(struct e1000_adapter *adapter,
 
 		cleaned = TRUE;
 		cleaned_count++;
-		pci_unmap_single(pdev,
+		dma_unmap_single(&pdev->dev,
 				 buffer_info->dma,
 				 adapter->rx_buffer_len,
-				 PCI_DMA_FROMDEVICE);
+				 DMA_FROM_DEVICE);
 		buffer_info->dma = 0;
 
 		length = le16_to_cpu(rx_desc->length);
@@ -5077,9 +5077,9 @@ static bool e1000_clean_rx_irq_ps(struct e1000_adapter *adapter,
 
 		cleaned = TRUE;
 		cleaned_count++;
-		pci_unmap_single(pdev, buffer_info->dma,
+		dma_unmap_single(&pdev->dev, buffer_info->dma,
 				 adapter->rx_ps_bsize0,
-				 PCI_DMA_FROMDEVICE);
+				 DMA_FROM_DEVICE);
 		buffer_info->dma = 0;
 
 		if (unlikely(!(staterr & E1000_RXD_STAT_EOP))) {
@@ -5147,8 +5147,8 @@ static bool e1000_clean_rx_irq_ps(struct e1000_adapter *adapter,
 		for (j = 0; j < adapter->rx_ps_pages; j++) {
 			if (!(length= le16_to_cpu(rx_desc->wb.upper.length[j])))
 				break;
-			pci_unmap_page(pdev, ps_page_dma->ps_page_dma[j],
-					PAGE_SIZE, PCI_DMA_FROMDEVICE);
+			dma_unmap_page(&pdev->dev, ps_page_dma->ps_page_dma[j],
+				       PAGE_SIZE, DMA_FROM_DEVICE);
 			ps_page_dma->ps_page_dma[j] = 0;
 			skb_fill_page_desc(skb, j, ps_page->ps_page[j], 0,
 					   length);
@@ -5291,10 +5291,10 @@ check_page:
 		}
 
 		if (!buffer_info->dma)
-			buffer_info->dma = pci_map_page(pdev,
+			buffer_info->dma = dma_map_page(&pdev->dev,
 							buffer_info->page, 0,
 							PAGE_SIZE,
-							PCI_DMA_FROMDEVICE);
+							DMA_FROM_DEVICE);
 
 		rx_desc = E1000_RX_DESC(*rx_ring, i);
 		rx_desc->buffer_addr = cpu_to_le64(buffer_info->dma);
@@ -5385,10 +5385,10 @@ static void e1000_alloc_rx_buffers(struct e1000_adapter *adapter,
 
 		buffer_info->skb = skb;
 map_skb:
-		buffer_info->dma = pci_map_single(pdev,
+		buffer_info->dma = dma_map_single(&pdev->dev,
 						  skb->data,
 						  adapter->rx_buffer_len,
-						  PCI_DMA_FROMDEVICE);
+						  DMA_FROM_DEVICE);
 
 		/* Fix for errata 23, can't cross 64kB boundary */
 		if (!e1000_check_64k_bound(adapter,
@@ -5401,9 +5401,9 @@ map_skb:
 			kfree_rtskb(skb);
 			buffer_info->skb = NULL;
 
-			pci_unmap_single(pdev, buffer_info->dma,
+			dma_unmap_single(&pdev->dev, buffer_info->dma,
 					 adapter->rx_buffer_len,
-					 PCI_DMA_FROMDEVICE);
+					 DMA_FROM_DEVICE);
 			buffer_info->dma = 0;
 
 			adapter->alloc_rx_buff_failed++;
diff --git a/kernel/drivers/net/drivers/natsemi.c b/kernel/drivers/net/drivers/natsemi.c
index 74112c5a2..82d1c3350 100644
--- a/kernel/drivers/net/drivers/natsemi.c
+++ b/kernel/drivers/net/drivers/natsemi.c
@@ -1435,8 +1435,8 @@ static void refill_rx(struct rtnet_device *dev)
 			np->rx_skbuff[entry] = skb;
 			if (skb == NULL)
 				break; /* Better luck next round. */
-			np->rx_dma[entry] = pci_map_single(np->pci_dev,
-				skb->data, np->rx_buf_sz, PCI_DMA_FROMDEVICE);
+			np->rx_dma[entry] = dma_map_single(&np->pci_dev->dev,
+				skb->data, np->rx_buf_sz, DMA_FROM_DEVICE);
 			np->rx_ring[entry].addr = cpu_to_le32(np->rx_dma[entry]);
 		}
 		np->rx_ring[entry].cmd_status = cpu_to_le32(np->rx_buf_sz);
@@ -1493,9 +1493,9 @@ static void drain_tx(struct rtnet_device *dev)
 
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		if (np->tx_skbuff[i]) {
-			pci_unmap_single(np->pci_dev,
+			dma_unmap_single(&np->pci_dev->dev,
 				np->rx_dma[i], np->tx_skbuff[i]->len,
-				PCI_DMA_TODEVICE);
+				DMA_TO_DEVICE);
 			dev_kfree_rtskb(np->tx_skbuff[i]);
 			np->stats.tx_dropped++;
 		}
@@ -1513,9 +1513,9 @@ static void drain_ring(struct rtnet_device *dev)
 		np->rx_ring[i].cmd_status = 0;
 		np->rx_ring[i].addr = 0xBADF00D0; /* An invalid address. */
 		if (np->rx_skbuff[i]) {
-			pci_unmap_single(np->pci_dev,
+			dma_unmap_single(&np->pci_dev->dev,
 				np->rx_dma[i], np->rx_skbuff[i]->len,
-				PCI_DMA_FROMDEVICE);
+				DMA_FROM_DEVICE);
 			dev_kfree_rtskb(np->rx_skbuff[i]);
 		}
 		np->rx_skbuff[i] = NULL;
@@ -1546,8 +1546,8 @@ static int start_tx(struct rtskb *skb, struct rtnet_device *dev) /*** RTnet ***/
 	entry = np->cur_tx % TX_RING_SIZE;
 
 	np->tx_skbuff[entry] = skb;
-	np->tx_dma[entry] = pci_map_single(np->pci_dev,
-				skb->data,skb->len, PCI_DMA_TODEVICE);
+	np->tx_dma[entry] = dma_map_single(&np->pci_dev->dev,
+				skb->data,skb->len, DMA_TO_DEVICE);
 
 	np->tx_ring[entry].addr = cpu_to_le32(np->tx_dma[entry]);
 
@@ -1621,9 +1621,9 @@ static void netdev_tx_done(struct rtnet_device *dev)
 				np->stats.tx_window_errors++;
 			np->stats.tx_errors++;
 		}
-		pci_unmap_single(np->pci_dev,np->tx_dma[entry],
-					np->tx_skbuff[entry]->len,
-					PCI_DMA_TODEVICE);
+		dma_unmap_single(&np->pci_dev->dev,np->tx_dma[entry],
+				np->tx_skbuff[entry]->len,
+				DMA_TO_DEVICE);
 		/* Free the original skb. */
 		dev_kfree_rtskb(np->tx_skbuff[entry]); /*** RTnet ***/
 /*		dev_kfree_skb_irq(np->tx_skbuff[entry]);*/
@@ -1750,9 +1750,10 @@ static void netdev_rx(struct rtnet_device *dev, nanosecs_abs_t *time_stamp)
 /*** RTnet ***/
 			{
 				skb = np->rx_skbuff[entry];
-				pci_unmap_single(np->pci_dev, np->rx_dma[entry],
-					np->rx_skbuff[entry]->len,
-					PCI_DMA_FROMDEVICE);
+				dma_unmap_single(&np->pci_dev->dev,
+						 np->rx_dma[entry],
+						 np->rx_skbuff[entry]->len,
+						 DMA_FROM_DEVICE);
 				rtskb_put(skb, pkt_len);
 				np->rx_skbuff[entry] = NULL;
 			}
diff --git a/kernel/drivers/net/drivers/pcnet32.c b/kernel/drivers/net/drivers/pcnet32.c
index 11a0af863..4fd5ba0b4 100644
--- a/kernel/drivers/net/drivers/pcnet32.c
+++ b/kernel/drivers/net/drivers/pcnet32.c
@@ -1083,8 +1083,8 @@ static int pcnet32_init_ring(struct rtnet_device *dev) /*** RTnet ***/
 			rtskb_reserve(rx_skbuff, 2); /*** RTnet ***/
 		}
 		lp->rx_dma_addr[i] =
-			pci_map_single(lp->pci_dev, rx_skbuff->tail,
-				       rx_skbuff->len, PCI_DMA_FROMDEVICE);
+			dma_map_single(&lp->pci_dev->dev, rx_skbuff->tail,
+				       rx_skbuff->len, DMA_FROM_DEVICE);
 		lp->rx_ring[i].base = (u32)le32_to_cpu(lp->rx_dma_addr[i]);
 		lp->rx_ring[i].buf_length = le16_to_cpu(-PKT_BUF_SZ);
 		lp->rx_ring[i].status = le16_to_cpu(0x8000);
@@ -1157,8 +1157,8 @@ static int pcnet32_start_xmit(struct rtskb *skb,
 	lp->tx_ring[entry].misc = 0x00000000;
 
 	lp->tx_skbuff[entry] = skb;
-	lp->tx_dma_addr[entry] = pci_map_single(lp->pci_dev, skb->data,
-						skb->len, PCI_DMA_TODEVICE);
+	lp->tx_dma_addr[entry] = dma_map_single(&lp->pci_dev->dev, skb->data,
+						skb->len, DMA_TO_DEVICE);
 	lp->tx_ring[entry].base = (u32)le32_to_cpu(lp->tx_dma_addr[entry]);
 
 	/*** RTnet ***/
@@ -1295,11 +1295,11 @@ static int pcnet32_interrupt(rtdm_irq_t *irq_handle) /*** RTnet ***/
 
 				/* We must free the original skb */
 				if (lp->tx_skbuff[entry]) {
-					pci_unmap_single(
-						lp->pci_dev,
+					dma_unmap_single(
+						&lp->pci_dev->dev,
 						lp->tx_dma_addr[entry],
 						lp->tx_skbuff[entry]->len,
-						PCI_DMA_TODEVICE);
+						DMA_TO_DEVICE);
 					dev_kfree_rtskb(
 						lp->tx_skbuff[entry]); /*** RTnet ***/
 					lp->tx_skbuff[entry] = 0;
@@ -1425,19 +1425,19 @@ static int pcnet32_rx(struct rtnet_device *dev,
 						     dev, PKT_BUF_SZ))) {
 						rtskb_reserve(newskb, 2);
 						skb = lp->rx_skbuff[entry];
-						pci_unmap_single(
-							lp->pci_dev,
+						dma_unmap_single(
+							&lp->pci_dev->dev,
 							lp->rx_dma_addr[entry],
 							skb->len,
-							PCI_DMA_FROMDEVICE);
+							DMA_FROM_DEVICE);
 						rtskb_put(skb, pkt_len);
 						lp->rx_skbuff[entry] = newskb;
 						lp->rx_dma_addr
-							[entry] = pci_map_single(
-							lp->pci_dev,
+							[entry] = dma_map_single(
+							&lp->pci_dev->dev,
 							newskb->tail,
 							newskb->len,
-							PCI_DMA_FROMDEVICE);
+							DMA_FROM_DEVICE);
 						lp->rx_ring[entry]
 							.base = le32_to_cpu(
 							lp->rx_dma_addr[entry]);
@@ -1529,9 +1529,9 @@ static int pcnet32_close(struct rtnet_device *dev) /*** RTnet ***/
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		lp->rx_ring[i].status = 0;
 		if (lp->rx_skbuff[i]) {
-			pci_unmap_single(lp->pci_dev, lp->rx_dma_addr[i],
+			dma_unmap_single(&lp->pci_dev->dev, lp->rx_dma_addr[i],
 					 lp->rx_skbuff[i]->len,
-					 PCI_DMA_FROMDEVICE);
+					 DMA_FROM_DEVICE);
 			dev_kfree_rtskb(lp->rx_skbuff[i]); /*** RTnet ***/
 		}
 		lp->rx_skbuff[i] = NULL;
@@ -1540,9 +1540,9 @@ static int pcnet32_close(struct rtnet_device *dev) /*** RTnet ***/
 
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		if (lp->tx_skbuff[i]) {
-			pci_unmap_single(lp->pci_dev, lp->tx_dma_addr[i],
+			dma_unmap_single(&lp->pci_dev->dev, lp->tx_dma_addr[i],
 					 lp->tx_skbuff[i]->len,
-					 PCI_DMA_TODEVICE);
+					 DMA_TO_DEVICE);
 			dev_kfree_rtskb(lp->tx_skbuff[i]); /*** RTnet ***/
 		}
 		lp->tx_skbuff[i] = NULL;
diff --git a/kernel/drivers/net/drivers/r8169.c b/kernel/drivers/net/drivers/r8169.c
index 72a6d2327..eb059d32a 100644
--- a/kernel/drivers/net/drivers/r8169.c
+++ b/kernel/drivers/net/drivers/r8169.c
@@ -1289,7 +1289,7 @@ static void rtl8169_init_ring (struct rtnet_device *rtdev)
 
 	for (i=0 ; i<NUM_TX_DESC ; i++){
 		priv->Tx_skbuff[i]=NULL;
-		priv->txdesc_array_dma_addr[i] = pci_map_single(pdev, &priv->TxDescArray[i], sizeof(struct TxDesc), PCI_DMA_TODEVICE);
+		priv->txdesc_array_dma_addr[i] = dma_map_single(&pdev->dev, &priv->TxDescArray[i], sizeof(struct TxDesc), DMA_TO_DEVICE);
 	}
 
 	for (i=0; i <NUM_RX_DESC; i++) {
@@ -1302,7 +1302,7 @@ static void rtl8169_init_ring (struct rtnet_device *rtdev)
 
 		{//-----------------------------------------------------------------------
 			skb = priv->Rx_skbuff[i];
-			priv->rx_skbuff_dma_addr[i] = pci_map_single(pdev, skb->data, priv->rx_buf_size /* MAX_RX_SKBDATA_SIZE */, PCI_DMA_FROMDEVICE);	/*** <kk> ***/
+			priv->rx_skbuff_dma_addr[i] = dma_map_single(&pdev->dev, skb->data, priv->rx_buf_size /* MAX_RX_SKBDATA_SIZE */, DMA_FROM_DEVICE);	/*** <kk> ***/
 
 			if( skb != NULL ){
 				priv->RxDescArray[i].buf_addr = cpu_to_le32(priv->rx_skbuff_dma_addr[i]);
@@ -1313,7 +1313,7 @@ static void rtl8169_init_ring (struct rtnet_device *rtdev)
 				priv->drvinit_fail = 1;
 			}
 		}//-----------------------------------------------------------------------
-		priv->rxdesc_array_dma_addr[i] = pci_map_single(pdev, &priv->RxDescArray[i], sizeof(struct RxDesc), PCI_DMA_TODEVICE);
+		priv->rxdesc_array_dma_addr[i] = dma_map_single(&pdev->dev, &priv->RxDescArray[i], sizeof(struct RxDesc), DMA_TO_DEVICE);
 		pci_dma_sync_single_for_device(pdev, priv->rxdesc_array_dma_addr[i], sizeof(struct RxDesc), PCI_DMA_TODEVICE);
 	}
 }
@@ -1382,7 +1382,7 @@ static int rtl8169_start_xmit (struct rtskb *skb, struct rtnet_device *rtdev)
 			len = ETH_ZLEN;
 		}
 
-		txbuf_dma_addr = pci_map_single(pdev, skb->data, len, PCI_DMA_TODEVICE);
+		txbuf_dma_addr = dma_map_single(&pdev->dev, skb->data, len, DMA_TO_DEVICE);
 
 		priv->TxDescArray[entry].buf_addr = cpu_to_le32(txbuf_dma_addr);
 
@@ -1508,7 +1508,7 @@ static void rtl8169_tx_interrupt (struct rtnet_device *rtdev, struct rtl8169_pri
 #endif //end #ifdef RTL8169_DYNAMIC_CONTROL
 
 			if (priv->txdesc_array_dma_addr[entry])
-				pci_unmap_single(priv->pci_dev, priv->txdesc_array_dma_addr[entry], priv->Tx_skbuff[entry]->len, PCI_DMA_TODEVICE);	/*** ##KK## ***/
+				dma_unmap_single(&priv->pci_dev->dev, priv->txdesc_array_dma_addr[entry], priv->Tx_skbuff[entry]->len, DMA_TO_DEVICE);	/*** ##KK## ***/
 			dev_kfree_rtskb( priv->Tx_skbuff[entry] );	/*** RTnet; previously: dev_kfree_skb_irq() - luckily we're within an IRQ ***/
 			priv->Tx_skbuff[entry] = NULL;
 			priv->stats.tx_packets++;
@@ -1630,7 +1630,7 @@ static void rtl8169_rx_interrupt (struct rtnet_device *rtdev, struct rtl8169_pri
 				cur_skb = priv->Rx_skbuff[cur_rx];
 
 				if( cur_skb != NULL ){
-					priv->rx_skbuff_dma_addr[cur_rx] = pci_map_single(pdev, cur_skb->data, priv->rx_buf_size /* <kk> MAX_RX_SKBDATA_SIZE */, PCI_DMA_FROMDEVICE);
+					priv->rx_skbuff_dma_addr[cur_rx] = dma_map_single(&pdev->dev, cur_skb->data, priv->rx_buf_size /* <kk> MAX_RX_SKBDATA_SIZE */, DMA_FROM_DEVICE);
 					rxdesc->buf_addr = cpu_to_le32(priv->rx_skbuff_dma_addr[cur_rx]);
 				}
 				else{
diff --git a/kernel/drivers/net/drivers/tulip/interrupt.c b/kernel/drivers/net/drivers/tulip/interrupt.c
index a5e16c829..d65bb3f78 100644
--- a/kernel/drivers/net/drivers/tulip/interrupt.c
+++ b/kernel/drivers/net/drivers/tulip/interrupt.c
@@ -78,8 +78,8 @@ int tulip_refill_rx(/*RTnet*/struct rtnet_device *rtdev)
 			if (skb == NULL)
 				break;
 
-			mapping = pci_map_single(tp->pdev, skb->tail, PKT_BUF_SZ,
-						 PCI_DMA_FROMDEVICE);
+			mapping = dma_map_single(&tp->pdev->dev, skb->tail,
+						 PKT_BUF_SZ, DMA_FROM_DEVICE);
 			tp->rx_buffers[entry].mapping = mapping;
 
 			tp->rx_ring[entry].buffer1 = cpu_to_le32(mapping);
@@ -168,8 +168,9 @@ static int tulip_rx(/*RTnet*/struct rtnet_device *rtdev, nanosecs_abs_t *time_st
 				}
 #endif
 
-				pci_unmap_single(tp->pdev, tp->rx_buffers[entry].mapping,
-						 PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
+				dma_unmap_single(&tp->pdev->dev,
+						 tp->rx_buffers[entry].mapping,
+						 PKT_BUF_SZ, DMA_FROM_DEVICE);
 
 				tp->rx_buffers[entry].skb = NULL;
 				tp->rx_buffers[entry].mapping = 0;
@@ -247,10 +248,10 @@ int tulip_interrupt(rtdm_irq_t *irq_handle)
 				if (tp->tx_buffers[entry].skb == NULL) {
 					/* test because dummy frames not mapped */
 					if (tp->tx_buffers[entry].mapping)
-						pci_unmap_single(tp->pdev,
+						dma_unmap_single(&tp->pdev->dev,
 							 tp->tx_buffers[entry].mapping,
 							 sizeof(tp->setup_frame),
-							 PCI_DMA_TODEVICE);
+							 DMA_TO_DEVICE);
 					continue;
 				}
 
@@ -275,9 +276,10 @@ int tulip_interrupt(rtdm_irq_t *irq_handle)
 					tp->stats.tx_packets++;
 				}
 
-				pci_unmap_single(tp->pdev, tp->tx_buffers[entry].mapping,
+				dma_unmap_single(&tp->pdev->dev,
+						 tp->tx_buffers[entry].mapping,
 						 tp->tx_buffers[entry].skb->len,
-						 PCI_DMA_TODEVICE);
+						 DMA_TO_DEVICE);
 
 				/* Free the original skb. */
 				/*RTnet*/dev_kfree_rtskb(tp->tx_buffers[entry].skb);
diff --git a/kernel/drivers/net/drivers/tulip/tulip_core.c b/kernel/drivers/net/drivers/tulip/tulip_core.c
index f5e7b3e9d..3d0b3dba6 100644
--- a/kernel/drivers/net/drivers/tulip/tulip_core.c
+++ b/kernel/drivers/net/drivers/tulip/tulip_core.c
@@ -333,9 +333,9 @@ static void tulip_up(/*RTnet*/struct rtnet_device *rtdev)
 		*setup_frm++ = eaddrs[1]; *setup_frm++ = eaddrs[1];
 		*setup_frm++ = eaddrs[2]; *setup_frm++ = eaddrs[2];
 
-		mapping = pci_map_single(tp->pdev, tp->setup_frame,
+		mapping = dma_map_single(&tp->pdev->dev, tp->setup_frame,
 					 sizeof(tp->setup_frame),
-					 PCI_DMA_TODEVICE);
+					 DMA_TO_DEVICE);
 		tp->tx_buffers[tp->cur_tx].skb = NULL;
 		tp->tx_buffers[tp->cur_tx].mapping = mapping;
 
@@ -537,7 +537,8 @@ static void tulip_init_ring(/*RTnet*/struct rtnet_device *rtdev)
 		tp->rx_buffers[i].skb = skb;
 		if (skb == NULL)
 			break;
-		mapping = pci_map_single(tp->pdev, skb->tail, PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
+		mapping = dma_map_single(&tp->pdev->dev, skb->tail, PKT_BUF_SZ,
+					 DMA_FROM_DEVICE);
 		tp->rx_buffers[i].mapping = mapping;
 		tp->rx_ring[i].status = cpu_to_le32(DescOwned);	/* Owned by Tulip chip */
 		tp->rx_ring[i].buffer1 = cpu_to_le32(mapping);
@@ -582,7 +583,8 @@ tulip_start_xmit(struct /*RTnet*/rtskb *skb, /*RTnet*/struct rtnet_device *rtdev
 	entry = tp->cur_tx % TX_RING_SIZE;
 
 	tp->tx_buffers[entry].skb = skb;
-	mapping = pci_map_single(tp->pdev, skb->data, skb->len, PCI_DMA_TODEVICE);
+	mapping = dma_map_single(&tp->pdev->dev, skb->data, skb->len,
+				 DMA_TO_DEVICE);
 	tp->tx_buffers[entry].mapping = mapping;
 	tp->tx_ring[entry].buffer1 = cpu_to_le32(mapping);
 
@@ -642,16 +644,16 @@ static void tulip_clean_tx_ring(struct tulip_private *tp)
 		if (tp->tx_buffers[entry].skb == NULL) {
 			/* test because dummy frames not mapped */
 			if (tp->tx_buffers[entry].mapping)
-				pci_unmap_single(tp->pdev,
+				dma_unmap_single(&tp->pdev->dev,
 					tp->tx_buffers[entry].mapping,
 					sizeof(tp->setup_frame),
-					PCI_DMA_TODEVICE);
+					DMA_TO_DEVICE);
 			continue;
 		}
 
-		pci_unmap_single(tp->pdev, tp->tx_buffers[entry].mapping,
+		dma_unmap_single(&tp->pdev->dev, tp->tx_buffers[entry].mapping,
 				tp->tx_buffers[entry].skb->len,
-				PCI_DMA_TODEVICE);
+				DMA_TO_DEVICE);
 
 		/* Free the original skb. */
 		/*RTnet*/dev_kfree_rtskb(tp->tx_buffers[entry].skb);
@@ -731,8 +733,8 @@ static int tulip_close (/*RTnet*/struct rtnet_device *rtdev)
 		tp->rx_ring[i].length = 0;
 		tp->rx_ring[i].buffer1 = 0xBADF00D0;	/* An invalid address. */
 		if (skb) {
-			pci_unmap_single(tp->pdev, mapping, PKT_BUF_SZ,
-					 PCI_DMA_FROMDEVICE);
+			dma_unmap_single(&tp->pdev->dev, mapping, PKT_BUF_SZ,
+					 DMA_FROM_DEVICE);
 			/*RTnet*/dev_kfree_rtskb (skb);
 		}
 	}
@@ -740,8 +742,9 @@ static int tulip_close (/*RTnet*/struct rtnet_device *rtdev)
 		struct /*RTnet*/rtskb *skb = tp->tx_buffers[i].skb;
 
 		if (skb != NULL) {
-			pci_unmap_single(tp->pdev, tp->tx_buffers[i].mapping,
-					 skb->len, PCI_DMA_TODEVICE);
+			dma_unmap_single(&tp->pdev->dev,
+					 tp->tx_buffers[i].mapping,
+					 skb->len, DMA_TO_DEVICE);
 			/*RTnet*/dev_kfree_rtskb (skb);
 		}
 		tp->tx_buffers[i].skb = NULL;
diff --git a/kernel/drivers/net/drivers/via-rhine.c b/kernel/drivers/net/drivers/via-rhine.c
index fc867cf73..192f02eb6 100644
--- a/kernel/drivers/net/drivers/via-rhine.c
+++ b/kernel/drivers/net/drivers/via-rhine.c
@@ -985,8 +985,8 @@ static void alloc_rbufs(struct rtnet_device *dev) /*** RTnet ***/
 		if (skb == NULL)
 			break;
 		np->rx_skbuff_dma[i] =
-			pci_map_single(np->pdev, skb->tail, np->rx_buf_sz,
-						   PCI_DMA_FROMDEVICE);
+			dma_map_single(&np->pdev->dev, skb->tail, np->rx_buf_sz,
+				       DMA_FROM_DEVICE);
 
 		np->rx_ring[i].addr = cpu_to_le32(np->rx_skbuff_dma[i]);
 		np->rx_ring[i].rx_status = cpu_to_le32(DescOwn);
@@ -1004,9 +1004,8 @@ static void free_rbufs(struct rtnet_device* dev) /*** RTnet ***/
 		np->rx_ring[i].rx_status = 0;
 		np->rx_ring[i].addr = cpu_to_le32(0xBADF00D0); /* An invalid address. */
 		if (np->rx_skbuff[i]) {
-			pci_unmap_single(np->pdev,
-							 np->rx_skbuff_dma[i],
-							 np->rx_buf_sz, PCI_DMA_FROMDEVICE);
+			dma_unmap_single(&np->pdev->dev, np->rx_skbuff_dma[i],
+					 np->rx_buf_sz, DMA_FROM_DEVICE);
 			dev_kfree_rtskb(np->rx_skbuff[i]); /*** RTnet ***/
 		}
 		np->rx_skbuff[i] = 0;
@@ -1044,9 +1043,10 @@ static void free_tbufs(struct rtnet_device* dev) /*** RTnet ***/
 		np->tx_ring[i].addr = cpu_to_le32(0xBADF00D0); /* An invalid address. */
 		if (np->tx_skbuff[i]) {
 			if (np->tx_skbuff_dma[i]) {
-				pci_unmap_single(np->pdev,
-								 np->tx_skbuff_dma[i],
-								 np->tx_skbuff[i]->len, PCI_DMA_TODEVICE);
+				dma_unmap_single(&np->pdev->dev,
+						 np->tx_skbuff_dma[i],
+						 np->tx_skbuff[i]->len,
+						 DMA_TO_DEVICE);
 			}
 			dev_kfree_rtskb(np->tx_skbuff[i]); /*** RTnet ***/
 		}
@@ -1282,7 +1282,8 @@ static int via_rhine_start_tx(struct rtskb *skb, struct rtnet_device *dev) /***
 										  (np->tx_buf[entry] - np->tx_bufs));
 	} else {
 		np->tx_skbuff_dma[entry] =
-			pci_map_single(np->pdev, skb->data, skb->len, PCI_DMA_TODEVICE);
+			dma_map_single(&np->pdev->dev, skb->data, skb->len,
+				       DMA_TO_DEVICE);
 		np->tx_ring[entry].addr = cpu_to_le32(np->tx_skbuff_dma[entry]);
 
 /*** RTnet ***/
@@ -1445,9 +1446,10 @@ static void via_rhine_tx(struct rtnet_device *dev) /*** RTnet ***/
 		}
 		/* Free the original skb. */
 		if (np->tx_skbuff_dma[entry]) {
-			pci_unmap_single(np->pdev,
-							 np->tx_skbuff_dma[entry],
-							 np->tx_skbuff[entry]->len, PCI_DMA_TODEVICE);
+			dma_unmap_single(&np->pdev->dev,
+					 np->tx_skbuff_dma[entry],
+					 np->tx_skbuff[entry]->len,
+					 DMA_TO_DEVICE);
 		}
 		dev_kfree_rtskb(np->tx_skbuff[entry]); /*** RTnet ***/
 		np->tx_skbuff[entry] = NULL;
@@ -1522,8 +1524,10 @@ static void via_rhine_rx(struct rtnet_device *dev, nanosecs_abs_t *time_stamp) /
 				}
 				np->rx_skbuff[entry] = NULL;
 				rtskb_put(skb, pkt_len); /*** RTnet ***/
-				pci_unmap_single(np->pdev, np->rx_skbuff_dma[entry],
-								 np->rx_buf_sz, PCI_DMA_FROMDEVICE);
+				dma_unmap_single(&np->pdev->dev,
+						 np->rx_skbuff_dma[entry],
+						 np->rx_buf_sz,
+						 DMA_FROM_DEVICE);
 			}
 /*** RTnet ***/
 			skb->protocol = rt_eth_type_trans(skb, dev);
@@ -1548,8 +1552,8 @@ static void via_rhine_rx(struct rtnet_device *dev, nanosecs_abs_t *time_stamp) /
 			if (skb == NULL)
 				break;			/* Better luck next round. */
 			np->rx_skbuff_dma[entry] =
-				pci_map_single(np->pdev, skb->tail, np->rx_buf_sz,
-							   PCI_DMA_FROMDEVICE);
+				dma_map_single(&np->pdev->dev, skb->tail,
+					       np->rx_buf_sz, DMA_FROM_DEVICE);
 			np->rx_ring[entry].addr = cpu_to_le32(np->rx_skbuff_dma[entry]);
 		}
 		np->rx_ring[entry].rx_status = cpu_to_le32(DescOwn);

-- 
2.39.2

