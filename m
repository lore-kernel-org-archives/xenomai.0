Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767DC469C
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:45 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 20F4E240016
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:38 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 3093F9417DD
	for <xenomai@xenomai.org>; Mon,  4 Jul 2022 13:08:37 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202207041308362b2b0474561edec4d8
        for <xenomai@xenomai.org>;
        Mon, 04 Jul 2022 15:08:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=xKElPF4aMpFBtpI9NIm45eT2FnJfbusD4QjORT0X1+Q=;
 b=I6l83lm2OgBnFo3mhnkBgImneOUnO8dMkIBSjmzMevz1mUUw9xCREz2svRax8HbWhG/p0Q
 IlL7VI27NE4K/v/cbFk/vawVTuMq7QGcBs2RawhhYUWb68ptOPMQd+SILHaTn6mbjM42G7xr
 0Xlv07HL9+g5Hr852xdhNrZtOyzns=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [PATCH 06/15] drivers: Convert pci_set_*dma_mask to DMA API
Date: Mon,  4 Jul 2022 15:08:26 +0200
Message-Id: <4808964f18dc64761da8dc5c9e6f3345df8f76ea.1656940114.git.jan.kiszka@siemens.com>
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
Received-SPF: pass (spool1: domain of rts-flowmailer.siemens.com designates 185.136.64.227 as permitted sender) client-ip=185.136.64.227; envelope-from=fm-294854-202207041308362b2b0474561edec4d8-J1GSvu@rts-flowmailer.siemens.com; helo=mta-64-227.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=I6l83lm2;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-202207041308362b2b0474561edec4d8-J1GSvu@rts-flowmailer.siemens.com designates 185.136.64.227 as permitted sender) smtp.mailfrom=fm-294854-202207041308362b2b0474561edec4d8-J1GSvu@rts-flowmailer.siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

The legacy API has been finally dropped, and the new one was "already"
available with 5.10.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/e1000/e1000_main.c             | 8 ++++----
 .../drivers/net/drivers/experimental/e1000/e1000_main.c   | 8 ++++----
 .../drivers/net/drivers/experimental/rt2500/rt2500pci.c   | 4 ++--
 kernel/drivers/net/drivers/via-rhine.c                    | 2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/drivers/net/drivers/e1000/e1000_main.c b/kernel/drivers/net/drivers/e1000/e1000_main.c
index 222709a48f..e2141313d9 100644
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
index db16cff11a..50493cff72 100644
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
index f6f9a2597f..9bbdce7fde 100644
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
index 9618d23e37..122e41d302 100644
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
2.35.3

