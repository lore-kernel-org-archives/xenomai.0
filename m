Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693C0C8E3
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 19:45:32 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202309011945300de4ff1df641dd5715
        for <xenomai@lists.linux.dev>;
        Fri, 01 Sep 2023 21:45:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/orhCkbfJb5a2Xb3N5Dp2csoW8dmcDOHqWbSh0HBj2U=;
 b=P6Bu4g91vrNVT5g9STDGJOeshSE7Mz3EjeJGJPHEXLY4F2/QXxb0eupRd5TZaTBZDDVCGF
 cU8RNOkTiUflJxFKmgJ39mvppMPq+2RuYj8GimYjffMk253dWawE2XrYZi1BuSEF8w17Wjh2
 xPtxzjg9nrmwR+NbAyIaONhHPFoUQ=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 01 Sep 2023 21:45:29 +0200
Subject: [PATCH stable/v3.2.x v2 06/17] drivers: Convert
 pci_alloc/free_consistent to DMA API
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v2-6-5189cfb05a62@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

[ master commit 583d657fe202c3f31a6f454d1363f3faf790a773 ]

The legacy API has been finally dropped, and the new one was "already"
available with 5.10.

We keep the GFP_ATOMIC allocation type of the original wrapper, even if
some caller likely do not need them - safer and simpler than checking
them all.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/analogy/national_instruments/mite.c | 12 ++---
 kernel/drivers/analogy/national_instruments/mite.h |  4 +-
 kernel/drivers/net/drivers/8139too.c               | 18 +++++---
 kernel/drivers/net/drivers/e1000/e1000_main.c      | 44 +++++++++++-------
 kernel/drivers/net/drivers/eepro100.c              | 14 +++---
 kernel/drivers/net/drivers/experimental/3c59x.c    | 21 +++++----
 .../net/drivers/experimental/e1000/e1000_ethtool.c | 14 +++---
 .../net/drivers/experimental/e1000/e1000_main.c    | 54 +++++++++++-----------
 kernel/drivers/net/drivers/natsemi.c               |  6 +--
 kernel/drivers/net/drivers/pcnet32.c               | 18 +++++---
 kernel/drivers/net/drivers/r8169.c                 | 14 +++---
 kernel/drivers/net/drivers/tulip/tulip_core.c      | 24 +++++-----
 kernel/drivers/net/drivers/via-rhine.c             | 33 ++++++-------
 13 files changed, 155 insertions(+), 121 deletions(-)

diff --git a/kernel/drivers/analogy/national_instruments/mite.c b/kernel/drivers/analogy/national_instruments/mite.c
index be4b268c1..4eb9eee4f 100644
--- a/kernel/drivers/analogy/national_instruments/mite.c
+++ b/kernel/drivers/analogy/national_instruments/mite.c
@@ -381,9 +381,9 @@ int a4l_mite_buf_change(struct mite_dma_descriptor_ring *ring, struct a4l_subdev
 	int i;
 
 	if (ring->descriptors) {
-		pci_free_consistent(ring->pcidev,
-				    ring->n_links * sizeof(struct mite_dma_descriptor),
-				    ring->descriptors, ring->descriptors_dma_addr);
+		dma_free_coherent(&ring->pcidev->dev,
+				  ring->n_links * sizeof(struct mite_dma_descriptor),
+				  ring->descriptors, ring->descriptors_dma_addr);
 	}
 	ring->descriptors = NULL;
 	ring->descriptors_dma_addr = 0;
@@ -397,9 +397,9 @@ int a4l_mite_buf_change(struct mite_dma_descriptor_ring *ring, struct a4l_subdev
 	MDPRINTK("ring->pcidev=%p, n_links=0x%04x\n", ring->pcidev, n_links);
 
 	ring->descriptors =
-		pci_alloc_consistent(ring->pcidev,
-				     n_links * sizeof(struct mite_dma_descriptor),
-				     &ring->descriptors_dma_addr);
+		dma_alloc_coherent(&ring->pcidev->dev,
+				   n_links * sizeof(struct mite_dma_descriptor),
+				   &ring->descriptors_dma_addr, GFP_ATOMIC);
 	if (!ring->descriptors) {
 		printk("MITE: ring buffer allocation failed\n");
 		return -ENOMEM;
diff --git a/kernel/drivers/analogy/national_instruments/mite.h b/kernel/drivers/analogy/national_instruments/mite.h
index 93eff4dec..3b9aaba01 100644
--- a/kernel/drivers/analogy/national_instruments/mite.h
+++ b/kernel/drivers/analogy/national_instruments/mite.h
@@ -94,8 +94,8 @@ static inline void mite_free_ring(struct mite_dma_descriptor_ring *ring)
 {
 	if (ring) {
 		if (ring->descriptors) {
-			pci_free_consistent(
-				ring->pcidev,
+			dma_free_coherent(
+				&ring->pcidev->dev,
 				ring->n_links *
 				sizeof(struct mite_dma_descriptor),
 				ring->descriptors, ring->descriptors_dma_addr);
diff --git a/kernel/drivers/net/drivers/8139too.c b/kernel/drivers/net/drivers/8139too.c
index 05a4042f4..c335b300b 100644
--- a/kernel/drivers/net/drivers/8139too.c
+++ b/kernel/drivers/net/drivers/8139too.c
@@ -1114,15 +1114,19 @@ static int rtl8139_open (struct rtnet_device *rtdev)
 	if (retval)
 		return retval;
 
-	tp->tx_bufs = pci_alloc_consistent(tp->pci_dev, TX_BUF_TOT_LEN, &tp->tx_bufs_dma);
-	tp->rx_ring = pci_alloc_consistent(tp->pci_dev, RX_BUF_TOT_LEN, &tp->rx_ring_dma);
+	tp->tx_bufs = dma_alloc_coherent(&tp->pci_dev->dev, TX_BUF_TOT_LEN,
+					 &tp->tx_bufs_dma, GFP_ATOMIC);
+	tp->rx_ring = dma_alloc_coherent(&tp->pci_dev->dev, RX_BUF_TOT_LEN,
+					 &tp->rx_ring_dma, GFP_ATOMIC);
 
 	if (tp->tx_bufs == NULL || tp->rx_ring == NULL) {
 		rtdm_irq_free(&tp->irq_handle);
 		if (tp->tx_bufs)
-			pci_free_consistent(tp->pci_dev, TX_BUF_TOT_LEN, tp->tx_bufs, tp->tx_bufs_dma);
+			dma_free_coherent(&tp->pci_dev->dev, TX_BUF_TOT_LEN,
+					  tp->tx_bufs, tp->tx_bufs_dma);
 		if (tp->rx_ring)
-			pci_free_consistent(tp->pci_dev, RX_BUF_TOT_LEN, tp->rx_ring, tp->rx_ring_dma);
+			dma_free_coherent(&tp->pci_dev->dev, RX_BUF_TOT_LEN,
+					  tp->rx_ring, tp->rx_ring_dma);
 
 		return -ENOMEM;
 	}
@@ -1627,8 +1631,10 @@ static int rtl8139_close (struct rtnet_device *rtdev)
 
 	rtl8139_tx_clear (tp);
 
-	pci_free_consistent(tp->pci_dev, RX_BUF_TOT_LEN, tp->rx_ring, tp->rx_ring_dma);
-	pci_free_consistent(tp->pci_dev, TX_BUF_TOT_LEN, tp->tx_bufs, tp->tx_bufs_dma);
+	dma_free_coherent(&tp->pci_dev->dev, RX_BUF_TOT_LEN, tp->rx_ring,
+			  tp->rx_ring_dma);
+	dma_free_coherent(&tp->pci_dev->dev, TX_BUF_TOT_LEN, tp->tx_bufs,
+			  tp->tx_bufs_dma);
 	tp->rx_ring = NULL;
 	tp->tx_bufs = NULL;
 
diff --git a/kernel/drivers/net/drivers/e1000/e1000_main.c b/kernel/drivers/net/drivers/e1000/e1000_main.c
index e2141313d..7c34e2f00 100644
--- a/kernel/drivers/net/drivers/e1000/e1000_main.c
+++ b/kernel/drivers/net/drivers/e1000/e1000_main.c
@@ -1266,7 +1266,8 @@ e1000_setup_tx_resources(struct e1000_adapter *adapter,
 	txdr->size = txdr->count * sizeof(struct e1000_tx_desc);
 	E1000_ROUNDUP(txdr->size, 4096);
 
-	txdr->desc = pci_alloc_consistent(pdev, txdr->size, &txdr->dma);
+	txdr->desc = dma_alloc_coherent(&pdev->dev, txdr->size, &txdr->dma,
+					GFP_ATOMIC);
 	if (!txdr->desc) {
 setup_tx_desc_die:
 		vfree(txdr->buffer_info);
@@ -1282,18 +1283,21 @@ setup_tx_desc_die:
 		DPRINTK(TX_ERR, ERR, "txdr align check failed: %u bytes "
 				     "at %p\n", txdr->size, txdr->desc);
 		/* Try again, without freeing the previous */
-		txdr->desc = pci_alloc_consistent(pdev, txdr->size, &txdr->dma);
+		txdr->desc = dma_alloc_coherent(&pdev->dev, txdr->size,
+						&txdr->dma, GFP_ATOMIC);
 		/* Failed allocation, critical failure */
 		if (!txdr->desc) {
-			pci_free_consistent(pdev, txdr->size, olddesc, olddma);
+			dma_free_coherent(&pdev->dev, txdr->size, olddesc,
+					  olddma);
 			goto setup_tx_desc_die;
 		}
 
 		if (!e1000_check_64k_bound(adapter, txdr->desc, txdr->size)) {
 			/* give up */
-			pci_free_consistent(pdev, txdr->size, txdr->desc,
-					    txdr->dma);
-			pci_free_consistent(pdev, txdr->size, olddesc, olddma);
+			dma_free_coherent(&pdev->dev, txdr->size, txdr->desc,
+					  txdr->dma);
+			dma_free_coherent(&pdev->dev, txdr->size, olddesc,
+					  olddma);
 			DPRINTK(PROBE, ERR,
 				"Unable to allocate aligned memory "
 				"for the transmit descriptor ring\n");
@@ -1301,7 +1305,8 @@ setup_tx_desc_die:
 			return -ENOMEM;
 		} else {
 			/* Free old allocation, new allocation was successful */
-			pci_free_consistent(pdev, txdr->size, olddesc, olddma);
+			dma_free_coherent(&pdev->dev, txdr->size, olddesc,
+					  olddma);
 		}
 	}
 	memset(txdr->desc, 0, txdr->size);
@@ -1520,7 +1525,8 @@ e1000_setup_rx_resources(struct e1000_adapter *adapter,
 	rxdr->size = rxdr->count * desc_len;
 	E1000_ROUNDUP(rxdr->size, 4096);
 
-	rxdr->desc = pci_alloc_consistent(pdev, rxdr->size, &rxdr->dma);
+	rxdr->desc = dma_alloc_coherent(&pdev->dev, rxdr->size, &rxdr->dma,
+					GFP_ATOMIC);
 
 	if (!rxdr->desc) {
 		DPRINTK(PROBE, ERR,
@@ -1539,10 +1545,12 @@ setup_rx_desc_die:
 		DPRINTK(RX_ERR, ERR, "rxdr align check failed: %u bytes "
 				     "at %p\n", rxdr->size, rxdr->desc);
 		/* Try again, without freeing the previous */
-		rxdr->desc = pci_alloc_consistent(pdev, rxdr->size, &rxdr->dma);
+		rxdr->desc = dma_alloc_coherent(&pdev->dev, rxdr->size,
+						&rxdr->dma, GFP_ATOMIC);
 		/* Failed allocation, critical failure */
 		if (!rxdr->desc) {
-			pci_free_consistent(pdev, rxdr->size, olddesc, olddma);
+			dma_free_coherent(&pdev->dev, rxdr->size, olddesc,
+					  olddma);
 			DPRINTK(PROBE, ERR,
 				"Unable to allocate memory "
 				"for the receive descriptor ring\n");
@@ -1551,16 +1559,18 @@ setup_rx_desc_die:
 
 		if (!e1000_check_64k_bound(adapter, rxdr->desc, rxdr->size)) {
 			/* give up */
-			pci_free_consistent(pdev, rxdr->size, rxdr->desc,
-					    rxdr->dma);
-			pci_free_consistent(pdev, rxdr->size, olddesc, olddma);
+			dma_free_coherent(&pdev->dev, rxdr->size, rxdr->desc,
+					   rxdr->dma);
+			dma_free_coherent(&pdev->dev, rxdr->size, olddesc,
+					  olddma);
 			DPRINTK(PROBE, ERR,
 				"Unable to allocate aligned memory "
 				"for the receive descriptor ring\n");
 			goto setup_rx_desc_die;
 		} else {
 			/* Free old allocation, new allocation was successful */
-			pci_free_consistent(pdev, rxdr->size, olddesc, olddma);
+			dma_free_coherent(&pdev->dev, rxdr->size, olddesc,
+					  olddma);
 		}
 	}
 	memset(rxdr->desc, 0, rxdr->size);
@@ -1772,7 +1782,8 @@ e1000_free_tx_resources(struct e1000_adapter *adapter,
 	vfree(tx_ring->buffer_info);
 	tx_ring->buffer_info = NULL;
 
-	pci_free_consistent(pdev, tx_ring->size, tx_ring->desc, tx_ring->dma);
+	dma_free_coherent(&pdev->dev, tx_ring->size, tx_ring->desc,
+			  tx_ring->dma);
 
 	tx_ring->desc = NULL;
 }
@@ -1881,7 +1892,8 @@ e1000_free_rx_resources(struct e1000_adapter *adapter,
 	kfree(rx_ring->ps_page_dma);
 	rx_ring->ps_page_dma = NULL;
 
-	pci_free_consistent(pdev, rx_ring->size, rx_ring->desc, rx_ring->dma);
+	dma_free_coherent(&pdev->dev, rx_ring->size, rx_ring->desc,
+			  rx_ring->dma);
 
 	rx_ring->desc = NULL;
 }
diff --git a/kernel/drivers/net/drivers/eepro100.c b/kernel/drivers/net/drivers/eepro100.c
index 414eb7a45..64507756c 100644
--- a/kernel/drivers/net/drivers/eepro100.c
+++ b/kernel/drivers/net/drivers/eepro100.c
@@ -665,7 +665,8 @@ static int speedo_found1(struct pci_dev *pdev,
 	dma_addr_t tx_ring_dma;
 
 	size = TX_RING_SIZE * sizeof(struct TxFD) + sizeof(struct speedo_stats);
-	tx_ring_space = pci_alloc_consistent(pdev, size, &tx_ring_dma);
+	tx_ring_space = dma_alloc_coherent(&pdev->dev, size, &tx_ring_dma,
+					   GFP_ATOMIC);
 	if (tx_ring_space == NULL)
 		return -1;
 
@@ -674,7 +675,7 @@ static int speedo_found1(struct pci_dev *pdev,
 				RX_RING_SIZE * 2 + TX_RING_SIZE);
 	if (rtdev == NULL) {
 		printk(KERN_ERR "eepro100: Could not allocate ethernet device.\n");
-		pci_free_consistent(pdev, size, tx_ring_space, tx_ring_dma);
+		dma_free_coherent(&pdev->dev, size, tx_ring_space, tx_ring_dma);
 		return -1;
 	}
 	rtdev_alloc_name(rtdev, "rteth%d");
@@ -802,7 +803,7 @@ static int speedo_found1(struct pci_dev *pdev,
 
 	if ( (i=rt_register_rtnetdev(rtdev)) )
 	{
-		pci_free_consistent(pdev, size, tx_ring_space, tx_ring_dma);
+		dma_free_coherent(&pdev->dev, size, tx_ring_space, tx_ring_dma);
 		rtdev_free(rtdev);
 		return i;
 	}
@@ -1771,9 +1772,10 @@ static void eepro100_remove_one (struct pci_dev *pdev)
 	iounmap((char *)rtdev->base_addr);
 #endif
 
-	pci_free_consistent(pdev, TX_RING_SIZE * sizeof(struct TxFD)
-								+ sizeof(struct speedo_stats),
-						sp->tx_ring, sp->tx_ring_dma);
+	dma_free_coherent(
+		&pdev->dev,
+		TX_RING_SIZE * sizeof(struct TxFD) + sizeof(struct speedo_stats),
+		sp->tx_ring, sp->tx_ring_dma);
 	pci_disable_device(pdev);
 
 	// *** RTnet ***
diff --git a/kernel/drivers/net/drivers/experimental/3c59x.c b/kernel/drivers/net/drivers/experimental/3c59x.c
index c2cf4786c..94e0c9343 100644
--- a/kernel/drivers/net/drivers/experimental/3c59x.c
+++ b/kernel/drivers/net/drivers/experimental/3c59x.c
@@ -1070,9 +1070,12 @@ static int vortex_probe1(struct pci_dev *pdev,
 	vp->pdev = pdev;
 
 	/* Makes sure rings are at least 16 byte aligned. */
-	vp->rx_ring = pci_alloc_consistent(pdev, sizeof(struct boom_rx_desc) * RX_RING_SIZE
-					+ sizeof(struct boom_tx_desc) * TX_RING_SIZE,
-					&vp->rx_ring_dma);
+	vp->rx_ring = dma_alloc_coherent(
+			&pdev->dev,
+			sizeof(struct boom_rx_desc) * RX_RING_SIZE
+			+ sizeof(struct boom_tx_desc) * TX_RING_SIZE,
+			&vp->rx_ring_dma,
+			GFP_ATOMIC);
 	retval = -ENOMEM;
 	if (vp->rx_ring == 0)
 		goto free_region;
@@ -1329,11 +1332,11 @@ static int vortex_probe1(struct pci_dev *pdev,
 	// *** RTnet ***
 
   free_ring:
-	pci_free_consistent(pdev,
-			sizeof(struct boom_rx_desc) * RX_RING_SIZE
-			+ sizeof(struct boom_tx_desc) * TX_RING_SIZE,
-			vp->rx_ring,
-			vp->rx_ring_dma);
+	dma_free_coherent(&pdev->dev,
+		    sizeof(struct boom_rx_desc) * RX_RING_SIZE
+		    + sizeof(struct boom_tx_desc) * TX_RING_SIZE,
+		    vp->rx_ring,
+		    vp->rx_ring_dma);
   free_region:
 	if (vp->must_free_region)
 		release_region(ioaddr, vci->io_size);
@@ -2698,7 +2701,7 @@ static void vortex_remove_one (struct pci_dev *pdev)
 			pci_restore_state(vp->pdev, vp->power_state);
 	}
 
-	pci_free_consistent(pdev,
+	dma_free_coherent(&pdev->dev,
 			sizeof(struct boom_rx_desc) * RX_RING_SIZE
 			+ sizeof(struct boom_tx_desc) * TX_RING_SIZE,
 			vp->rx_ring,
diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_ethtool.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_ethtool.c
index 1911673af..a249f1719 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_ethtool.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_ethtool.c
@@ -1081,11 +1081,13 @@ static void e1000_free_desc_rings(struct e1000_adapter *adapter)
 	}
 
 	if (tx_ring->desc) {
-		pci_free_consistent(pdev, tx_ring->size, tx_ring->desc, tx_ring->dma);
+		dma_free_coherent(&pdev->dev, tx_ring->size, tx_ring->desc,
+				  tx_ring->dma);
 		tx_ring->desc = NULL;
 	}
 	if (rx_ring->desc) {
-		pci_free_consistent(pdev, rx_ring->size, rx_ring->desc, rx_ring->dma);
+		dma_free_coherent(&pdev->dev, rx_ring->size, rx_ring->desc,
+				  rx_ring->dma);
 		rx_ring->desc = NULL;
 	}
 
@@ -1119,8 +1121,8 @@ static int e1000_setup_desc_rings(struct e1000_adapter *adapter)
 
 	tx_ring->size = tx_ring->count * sizeof(struct e1000_tx_desc);
 	tx_ring->size = ALIGN(tx_ring->size, 4096);
-	if (!(tx_ring->desc = pci_alloc_consistent(pdev, tx_ring->size,
-	                                           &tx_ring->dma))) {
+	if (!(tx_ring->desc = dma_alloc_coherent(&pdev->dev, tx_ring->size,
+	                                         &tx_ring->dma, GFP_ATOMIC))) {
 		ret_val = 2;
 		goto err_nomem;
 	}
@@ -1179,8 +1181,8 @@ static int e1000_setup_desc_rings(struct e1000_adapter *adapter)
 	}
 
 	rx_ring->size = rx_ring->count * sizeof(struct e1000_rx_desc);
-	if (!(rx_ring->desc = pci_alloc_consistent(pdev, rx_ring->size,
-	                                           &rx_ring->dma))) {
+	if (!(rx_ring->desc = dma_alloc_coherent(&pdev->dev, rx_ring->size,
+	                                         &rx_ring->dma, GFP_ATOMIC))) {
 		ret_val = 5;
 		goto err_nomem;
 	}
diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
index 1b5579532..d32c5f361 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
@@ -1961,8 +1961,8 @@ static int e1000_setup_tx_resources(struct e1000_adapter *adapter,
 	tx_ring->size = tx_ring->count * sizeof(struct e1000_tx_desc);
 	tx_ring->size = ALIGN(tx_ring->size, 4096);
 
-	tx_ring->desc = pci_alloc_consistent(pdev, tx_ring->size,
-					     &tx_ring->dma);
+	tx_ring->desc = dma_alloc_coherent(&pdev->dev, tx_ring->size,
+					   &tx_ring->dma, GFP_ATOMIC);
 	if (!tx_ring->desc) {
 setup_tx_desc_die:
 		vfree(tx_ring->buffer_info);
@@ -1978,22 +1978,22 @@ setup_tx_desc_die:
 		DPRINTK(TX_ERR, ERR, "tx_ring align check failed: %u bytes "
 				     "at %p\n", tx_ring->size, tx_ring->desc);
 		/* Try again, without freeing the previous */
-		tx_ring->desc = pci_alloc_consistent(pdev, tx_ring->size,
-						     &tx_ring->dma);
+		tx_ring->desc = dma_alloc_coherent(&pdev->dev, tx_ring->size,
+						   &tx_ring->dma, GFP_ATOMIC);
 		/* Failed allocation, critical failure */
 		if (!tx_ring->desc) {
-			pci_free_consistent(pdev, tx_ring->size, olddesc,
-					    olddma);
+			dma_free_coherent(&pdev->dev, tx_ring->size, olddesc,
+					  olddma);
 			goto setup_tx_desc_die;
 		}
 
 		if (!e1000_check_64k_bound(adapter, tx_ring->desc,
 					   tx_ring->size)) {
 			/* give up */
-			pci_free_consistent(pdev, tx_ring->size, tx_ring->desc,
-					    tx_ring->dma);
-			pci_free_consistent(pdev, tx_ring->size, olddesc,
-					    olddma);
+			dma_free_coherent(&pdev->dev, tx_ring->size,
+					  tx_ring->desc, tx_ring->dma);
+			dma_free_coherent(&pdev->dev, tx_ring->size, olddesc,
+					  olddma);
 			DPRINTK(PROBE, ERR,
 				"Unable to allocate aligned memory "
 				"for the transmit descriptor ring\n");
@@ -2001,8 +2001,8 @@ setup_tx_desc_die:
 			return -ENOMEM;
 		} else {
 			/* Free old allocation, new allocation was successful */
-			pci_free_consistent(pdev, tx_ring->size, olddesc,
-					    olddma);
+			dma_free_coherent(&pdev->dev, tx_ring->size, olddesc,
+					  olddma);
 		}
 	}
 	memset(tx_ring->desc, 0, tx_ring->size);
@@ -2200,8 +2200,8 @@ static int e1000_setup_rx_resources(struct e1000_adapter *adapter,
 	rx_ring->size = rx_ring->count * desc_len;
 	rx_ring->size = ALIGN(rx_ring->size, 4096);
 
-	rx_ring->desc = pci_alloc_consistent(pdev, rx_ring->size,
-					     &rx_ring->dma);
+	rx_ring->desc = dma_alloc_coherent(&pdev->dev, rx_ring->size,
+					   &rx_ring->dma, GFP_ATOMIC);
 
 	if (!rx_ring->desc) {
 		DPRINTK(PROBE, ERR,
@@ -2220,12 +2220,12 @@ setup_rx_desc_die:
 		DPRINTK(RX_ERR, ERR, "rx_ring align check failed: %u bytes "
 				     "at %p\n", rx_ring->size, rx_ring->desc);
 		/* Try again, without freeing the previous */
-		rx_ring->desc = pci_alloc_consistent(pdev, rx_ring->size,
-						     &rx_ring->dma);
+		rx_ring->desc = dma_alloc_coherent(&pdev->dev, rx_ring->size,
+						   &rx_ring->dma, GFP_ATOMIC);
 		/* Failed allocation, critical failure */
 		if (!rx_ring->desc) {
-			pci_free_consistent(pdev, rx_ring->size, olddesc,
-					    olddma);
+			dma_free_coherent(&pdev->dev, rx_ring->size, olddesc,
+					  olddma);
 			DPRINTK(PROBE, ERR,
 				"Unable to allocate memory "
 				"for the receive descriptor ring\n");
@@ -2235,18 +2235,18 @@ setup_rx_desc_die:
 		if (!e1000_check_64k_bound(adapter, rx_ring->desc,
 					   rx_ring->size)) {
 			/* give up */
-			pci_free_consistent(pdev, rx_ring->size, rx_ring->desc,
-					    rx_ring->dma);
-			pci_free_consistent(pdev, rx_ring->size, olddesc,
-					    olddma);
+			dma_free_coherent(&pdev->dev, rx_ring->size,
+					  rx_ring->desc, rx_ring->dma);
+			dma_free_coherent(&pdev->dev, rx_ring->size, olddesc,
+					  olddma);
 			DPRINTK(PROBE, ERR,
 				"Unable to allocate aligned memory "
 				"for the receive descriptor ring\n");
 			goto setup_rx_desc_die;
 		} else {
 			/* Free old allocation, new allocation was successful */
-			pci_free_consistent(pdev, rx_ring->size, olddesc,
-					    olddma);
+			dma_free_coherent(&pdev->dev, rx_ring->size, olddesc,
+					  olddma);
 		}
 	}
 	memset(rx_ring->desc, 0, rx_ring->size);
@@ -2570,7 +2570,8 @@ static void e1000_free_tx_resources(struct e1000_adapter *adapter,
 	vfree(tx_ring->buffer_info);
 	tx_ring->buffer_info = NULL;
 
-	pci_free_consistent(pdev, tx_ring->size, tx_ring->desc, tx_ring->dma);
+	dma_free_coherent(&pdev->dev, tx_ring->size, tx_ring->desc,
+			  tx_ring->dma);
 
 	tx_ring->desc = NULL;
 }
@@ -2673,7 +2674,8 @@ static void e1000_free_rx_resources(struct e1000_adapter *adapter,
 	kfree(rx_ring->ps_page_dma);
 	rx_ring->ps_page_dma = NULL;
 
-	pci_free_consistent(pdev, rx_ring->size, rx_ring->desc, rx_ring->dma);
+	dma_free_coherent(&pdev->dev, rx_ring->size, rx_ring->desc,
+			  rx_ring->dma);
 
 	rx_ring->desc = NULL;
 }
diff --git a/kernel/drivers/net/drivers/natsemi.c b/kernel/drivers/net/drivers/natsemi.c
index b46d0ffef..74112c5a2 100644
--- a/kernel/drivers/net/drivers/natsemi.c
+++ b/kernel/drivers/net/drivers/natsemi.c
@@ -1413,9 +1413,9 @@ static void dump_ring(struct rtnet_device *dev)
 static int alloc_ring(struct rtnet_device *dev)
 {
 	struct netdev_private *np = dev->priv;
-	np->rx_ring = pci_alloc_consistent(np->pci_dev,
+	np->rx_ring = dma_alloc_coherent(&np->pci_dev->dev,
 		sizeof(struct netdev_desc) * (RX_RING_SIZE+TX_RING_SIZE),
-		&np->ring_dma);
+		&np->ring_dma, GFP_ATOMIC);
 	if (!np->rx_ring)
 		return -ENOMEM;
 	np->tx_ring = &np->rx_ring[RX_RING_SIZE];
@@ -1526,7 +1526,7 @@ static void drain_ring(struct rtnet_device *dev)
 static void free_ring(struct rtnet_device *dev)
 {
 	struct netdev_private *np = dev->priv;
-	pci_free_consistent(np->pci_dev,
+	dma_free_coherent(&np->pci_dev->dev,
 		sizeof(struct netdev_desc) * (RX_RING_SIZE+TX_RING_SIZE),
 		np->rx_ring, np->ring_dma);
 }
diff --git a/kernel/drivers/net/drivers/pcnet32.c b/kernel/drivers/net/drivers/pcnet32.c
index 135e26bb9..11a0af863 100644
--- a/kernel/drivers/net/drivers/pcnet32.c
+++ b/kernel/drivers/net/drivers/pcnet32.c
@@ -747,8 +747,9 @@ static int pcnet32_probe1(unsigned long ioaddr, unsigned int irq_line,
 	if (request_region(ioaddr, PCNET32_TOTAL_SIZE, chipname) == NULL)
 		return -EBUSY;
 
-	/* pci_alloc_consistent returns page-aligned memory, so we do not have to check the alignment */
-	if ((lp = pci_alloc_consistent(pdev, sizeof(*lp), &lp_dma_addr)) ==
+	/* dma_alloc_coherent returns page-aligned memory, so we do not have to check the alignment */
+	if ((lp = dma_alloc_coherent(&pdev->dev, sizeof(*lp), &lp_dma_addr,
+				     GFP_ATOMIC)) ==
 	    NULL) {
 		release_region(ioaddr, PCNET32_TOTAL_SIZE);
 		return -ENOMEM;
@@ -784,7 +785,8 @@ static int pcnet32_probe1(unsigned long ioaddr, unsigned int irq_line,
 
 	if (!a) {
 		printk(KERN_ERR PFX "No access methods\n");
-		pci_free_consistent(lp->pci_dev, sizeof(*lp), lp, lp->dma_addr);
+		dma_free_coherent(&lp->pci_dev->dev, sizeof(*lp), lp,
+				  lp->dma_addr);
 		release_region(ioaddr, PCNET32_TOTAL_SIZE);
 		return -ENODEV;
 	}
@@ -842,8 +844,8 @@ static int pcnet32_probe1(unsigned long ioaddr, unsigned int irq_line,
 			printk(", probed IRQ %d.\n", dev->irq);
 		else {
 			printk(", failed to detect IRQ line.\n");
-			pci_free_consistent(lp->pci_dev, sizeof(*lp), lp,
-					    lp->dma_addr);
+			dma_free_coherent(&lp->pci_dev->dev, sizeof(*lp), lp,
+					  lp->dma_addr);
 			release_region(ioaddr, PCNET32_TOTAL_SIZE);
 			return -ENODEV;
 		}
@@ -867,7 +869,8 @@ static int pcnet32_probe1(unsigned long ioaddr, unsigned int irq_line,
 	/* Fill in the generic fields of the device structure. */
 	/*** RTnet ***/
 	if ((i = rt_register_rtnetdev(dev))) {
-		pci_free_consistent(lp->pci_dev, sizeof(*lp), lp, lp->dma_addr);
+		dma_free_coherent(&lp->pci_dev->dev, sizeof(*lp), lp,
+				   lp->dma_addr);
 		release_region(ioaddr, PCNET32_TOTAL_SIZE);
 		rtdev_free(dev);
 		return i;
@@ -1637,7 +1640,8 @@ static void __exit pcnet32_cleanup_module(void)
 		rt_rtdev_disconnect(pcnet32_dev);
 		/*** RTnet ***/
 		release_region(pcnet32_dev->base_addr, PCNET32_TOTAL_SIZE);
-		pci_free_consistent(lp->pci_dev, sizeof(*lp), lp, lp->dma_addr);
+		dma_free_coherent(&lp->pci_dev->dev, sizeof(*lp), lp,
+				  lp->dma_addr);
 		/*** RTnet ***/
 		rtdev_free(pcnet32_dev);
 		/*** RTnet ***/
diff --git a/kernel/drivers/net/drivers/r8169.c b/kernel/drivers/net/drivers/r8169.c
index b49a15e30..72a6d2327 100644
--- a/kernel/drivers/net/drivers/r8169.c
+++ b/kernel/drivers/net/drivers/r8169.c
@@ -1045,13 +1045,15 @@ static int rtl8169_open (struct rtnet_device *rtdev)
 	//2004-05-11
 	// Allocate tx/rx descriptor space
 	priv->sizeof_txdesc_space = NUM_TX_DESC * sizeof(struct TxDesc)+256;
-	priv->txdesc_space = pci_alloc_consistent( pdev, priv->sizeof_txdesc_space, &priv->txdesc_phy_dma_addr );
+	priv->txdesc_space = dma_alloc_coherent(&pdev->dev,
+		priv->sizeof_txdesc_space, &priv->txdesc_phy_dma_addr, GFP_ATOMIC);
 	if( priv->txdesc_space == NULL ){
 		printk("%s: Gigabit driver alloc txdesc_space failed.\n", rtdev->name );
 		return -ENOMEM;
 	}
 	priv->sizeof_rxdesc_space = NUM_RX_DESC * sizeof(struct RxDesc)+256;
-	priv->rxdesc_space = pci_alloc_consistent( pdev, priv->sizeof_rxdesc_space, &priv->rxdesc_phy_dma_addr );
+	priv->rxdesc_space = dma_alloc_coherent(&pdev->dev,
+		priv->sizeof_rxdesc_space, &priv->rxdesc_phy_dma_addr, GFP_ATOMIC);
 	if( priv->rxdesc_space == NULL ){
 		printk("%s: Gigabit driver alloc rxdesc_space failed.\n", rtdev->name );
 		return -ENOMEM;
@@ -1783,8 +1785,8 @@ static int rtl8169_close (struct rtnet_device *rtdev)
 
 	//2004-05-11
 	if(priv->txdesc_space != NULL){
-		pci_free_consistent(
-				priv->pci_dev,
+		dma_free_coherent(
+				&priv->pci_dev->dev,
 				priv->sizeof_txdesc_space,
 				priv->txdesc_space,
 				priv->txdesc_phy_dma_addr
@@ -1793,8 +1795,8 @@ static int rtl8169_close (struct rtnet_device *rtdev)
 	}
 
 	if(priv->rxdesc_space != NULL){
-		pci_free_consistent(
-				priv->pci_dev,
+		dma_free_coherent(
+				&priv->pci_dev->dev,
 				priv->sizeof_rxdesc_space,
 				priv->rxdesc_space,
 				priv->rxdesc_phy_dma_addr
diff --git a/kernel/drivers/net/drivers/tulip/tulip_core.c b/kernel/drivers/net/drivers/tulip/tulip_core.c
index 0d68ef387..f5e7b3e9d 100644
--- a/kernel/drivers/net/drivers/tulip/tulip_core.c
+++ b/kernel/drivers/net/drivers/tulip/tulip_core.c
@@ -989,10 +989,10 @@ static int tulip_init_one (struct pci_dev *pdev,
 	 */
 	tp = rtdev->priv;
 
-	tp->rx_ring = pci_alloc_consistent(pdev,
-					   sizeof(struct tulip_rx_desc) * RX_RING_SIZE +
-					   sizeof(struct tulip_tx_desc) * TX_RING_SIZE,
-					   &tp->rx_ring_dma);
+	tp->rx_ring = dma_alloc_coherent(&pdev->dev,
+					 sizeof(struct tulip_rx_desc) * RX_RING_SIZE +
+					 sizeof(struct tulip_tx_desc) * TX_RING_SIZE,
+					 &tp->rx_ring_dma, GFP_ATOMIC);
 	if (!tp->rx_ring)
 		goto err_out_mtable;
 	tp->tx_ring = (struct tulip_tx_desc *)(tp->rx_ring + RX_RING_SIZE);
@@ -1319,10 +1319,10 @@ static int tulip_init_one (struct pci_dev *pdev,
 	return 0;
 
 err_out_free_ring:
-	pci_free_consistent (pdev,
-			     sizeof (struct tulip_rx_desc) * RX_RING_SIZE +
-			     sizeof (struct tulip_tx_desc) * TX_RING_SIZE,
-			     tp->rx_ring, tp->rx_ring_dma);
+	dma_free_coherent(&pdev->dev,
+			  sizeof (struct tulip_rx_desc) * RX_RING_SIZE +
+			  sizeof (struct tulip_tx_desc) * TX_RING_SIZE,
+			  tp->rx_ring, tp->rx_ring_dma);
 
 err_out_mtable:
 	if (tp->mtable)
@@ -1349,10 +1349,10 @@ static void tulip_remove_one (struct pci_dev *pdev)
 		return;
 
 	tp = rtdev->priv;
-	pci_free_consistent (pdev,
-			     sizeof (struct tulip_rx_desc) * RX_RING_SIZE +
-			     sizeof (struct tulip_tx_desc) * TX_RING_SIZE,
-			     tp->rx_ring, tp->rx_ring_dma);
+	dma_free_coherent(&pdev->dev,
+			  sizeof (struct tulip_rx_desc) * RX_RING_SIZE +
+			  sizeof (struct tulip_tx_desc) * TX_RING_SIZE,
+			  tp->rx_ring, tp->rx_ring_dma);
 	rt_unregister_rtnetdev (rtdev);
 	if (tp->mtable)
 		kfree (tp->mtable);
diff --git a/kernel/drivers/net/drivers/via-rhine.c b/kernel/drivers/net/drivers/via-rhine.c
index 122e41d30..fc867cf73 100644
--- a/kernel/drivers/net/drivers/via-rhine.c
+++ b/kernel/drivers/net/drivers/via-rhine.c
@@ -908,22 +908,23 @@ static int alloc_ring(struct rtnet_device* dev) /*** RTnet ***/
 	void *ring;
 	dma_addr_t ring_dma;
 
-	ring = pci_alloc_consistent(np->pdev,
-				    RX_RING_SIZE * sizeof(struct rx_desc) +
-				    TX_RING_SIZE * sizeof(struct tx_desc),
-				    &ring_dma);
+	ring = dma_alloc_coherent(&np->pdev->dev,
+				  RX_RING_SIZE * sizeof(struct rx_desc) +
+				  TX_RING_SIZE * sizeof(struct tx_desc),
+				  &ring_dma, GFP_ATOMIC);
 	if (!ring) {
 		printk(KERN_ERR "Could not allocate DMA memory.\n");
 		return -ENOMEM;
 	}
 	if (np->drv_flags & ReqTxAlign) {
-		np->tx_bufs = pci_alloc_consistent(np->pdev, PKT_BUF_SZ * TX_RING_SIZE,
-								   &np->tx_bufs_dma);
+		np->tx_bufs = dma_alloc_coherent(&np->pdev->dev,
+						 PKT_BUF_SZ * TX_RING_SIZE,
+						 &np->tx_bufs_dma, GFP_ATOMIC);
 		if (np->tx_bufs == NULL) {
-			pci_free_consistent(np->pdev,
-				    RX_RING_SIZE * sizeof(struct rx_desc) +
-				    TX_RING_SIZE * sizeof(struct tx_desc),
-				    ring, ring_dma);
+			dma_free_coherent(&np->pdev->dev,
+					  RX_RING_SIZE * sizeof(struct rx_desc) +
+					  TX_RING_SIZE * sizeof(struct tx_desc),
+					  ring, ring_dma);
 			return -ENOMEM;
 		}
 	}
@@ -940,15 +941,15 @@ void free_ring(struct rtnet_device* dev) /*** RTnet ***/
 {
 	struct netdev_private *np = dev->priv;
 
-	pci_free_consistent(np->pdev,
-			    RX_RING_SIZE * sizeof(struct rx_desc) +
-			    TX_RING_SIZE * sizeof(struct tx_desc),
-			    np->rx_ring, np->rx_ring_dma);
+	dma_free_coherent(&np->pdev->dev,
+			  RX_RING_SIZE * sizeof(struct rx_desc) +
+			  TX_RING_SIZE * sizeof(struct tx_desc),
+			  np->rx_ring, np->rx_ring_dma);
 	np->tx_ring = NULL;
 
 	if (np->tx_bufs)
-		pci_free_consistent(np->pdev, PKT_BUF_SZ * TX_RING_SIZE,
-							np->tx_bufs, np->tx_bufs_dma);
+		dma_free_coherent(&np->pdev->dev, PKT_BUF_SZ * TX_RING_SIZE,
+				  np->tx_bufs, np->tx_bufs_dma);
 
 	np->tx_bufs = NULL;
 

-- 
2.39.2

