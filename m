Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8C653AE
	for <xenomai@lists.linux.dev>; Thu, 31 Aug 2023 20:37:50 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202308312037430e80179c3f7782571a
        for <xenomai@lists.linux.dev>;
        Thu, 31 Aug 2023 22:37:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=dmSL/S41ZGzkvfHV5MwYBuOPlJldV9Ezr8FBYABS6xM=;
 b=pVGTeP8NR52hi740/nI31kQTc4D+D1Obl1DN7gpIPm9M+UEdX6BA2O6djREj+erNSlYcHQ
 +f4qLTSRAColOcZSBbKKonwU7pNyHzdn/eXZ/9RDcYPcV3Z1YUsNQUJbdLFqHH3z2sC+0ikl
 TuNbQkbofVyJVGSN95Gq7Lqmf5+F4=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 31 Aug 2023 22:37:31 +0200
Subject: [PATCH stable/v3.2.x 05/19] drivers: Convert pci_set_*dma_mask to
 DMA API
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v1-5-0e08770820e8@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

[ master commit 2e730324790f34413a5b29b7444a05ae48eac0cd ]

The legacy API has been finally dropped, and the new one was "already"
available with 5.10.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/e1000/e1000_main.c              | 8 ++++----
 kernel/drivers/net/drivers/experimental/e1000/e1000_main.c | 8 ++++----
 kernel/drivers/net/drivers/experimental/rt2500/rt2500pci.c | 4 ++--
 kernel/drivers/net/drivers/via-rhine.c                     | 2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/drivers/net/drivers/e1000/e1000_main.c b/kernel/drivers/net/drivers/e1000/e1000_main.c
index 222709a48..e2141313d 100644
--- a/kernel/drivers/net/drivers/e1000/e1000_main.c
+++ b/kernel/drivers/net/drivers/e1000/e1000_main.c
@@ -705,10 +705,10 @@ static int e1000_probe(struct pci_dev *pdev,
 	if ((err = pci_enable_device(pdev)))
 		return err;
 
-	if ((err = pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) ||
-	    (err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64)))) {
-		if ((err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32))) &&
-		    (err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32)))) {
+	if ((err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) ||
+	    (err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64)))) {
+		if ((err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32))) &&
+		    (err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32)))) {
 			E1000_ERR("No usable DMA configuration, aborting\n");
 			return err;
 		}
diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
index 64b724c3c..1b5579532 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
@@ -1061,12 +1061,12 @@ static int e1000_probe(struct pci_dev *pdev,
 	if ((err = pci_enable_device(pdev)))
 		return err;
 
-	if (!(err = pci_set_dma_mask(pdev, DMA_64BIT_MASK)) &&
-	    !(err = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK))) {
+	if (!(err = dma_set_mask(&pdev->dev, DMA_64BIT_MASK)) &&
+	    !(err = dma_set_coherent_mask(&pdev->dev, DMA_64BIT_MASK))) {
 		pci_using_dac = 1;
 	} else {
-		if ((err = pci_set_dma_mask(pdev, DMA_32BIT_MASK)) &&
-		    (err = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK))) {
+		if ((err = dma_set_mask(&pdev->dev, DMA_32BIT_MASK)) &&
+		    (err = dma_set_coherent_mask(&pdev->dev, DMA_32BIT_MASK))) {
 			E1000_ERR("No usable DMA configuration, aborting\n");
 			goto err_dma;
 		}
diff --git a/kernel/drivers/net/drivers/experimental/rt2500/rt2500pci.c b/kernel/drivers/net/drivers/experimental/rt2500/rt2500pci.c
index f6f9a2597..9bbdce7fd 100644
--- a/kernel/drivers/net/drivers/experimental/rt2500/rt2500pci.c
+++ b/kernel/drivers/net/drivers/experimental/rt2500/rt2500pci.c
@@ -1184,8 +1184,8 @@ int rt2x00_pci_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 
 	pci_set_master(pci_dev);
 
-	if (pci_set_dma_mask(pci_dev, DMA_BIT_MASK(64)) &&
-	    pci_set_dma_mask(pci_dev, DMA_BIT_MASK(32))) {
+	if (dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(64)) &&
+	    dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(32))) {
 		ERROR("PCI DMA not supported\n");
 		status = -EIO;
 		goto exit_disable_device;
diff --git a/kernel/drivers/net/drivers/via-rhine.c b/kernel/drivers/net/drivers/via-rhine.c
index 9618d23e3..122e41d30 100644
--- a/kernel/drivers/net/drivers/via-rhine.c
+++ b/kernel/drivers/net/drivers/via-rhine.c
@@ -662,7 +662,7 @@ static int via_rhine_init_one (struct pci_dev *pdev,
 		goto err_out;
 
 	/* this should always be supported */
-	if (pci_set_dma_mask(pdev, 0xffffffff)) {
+	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(32))) {
 		printk(KERN_ERR "32-bit PCI DMA addresses not supported by the card!?\n");
 		goto err_out;
 	}

-- 
2.39.2

