Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5674152163
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781945; cv=none; b=OVq/N2d/XoAAreICddY5U59v0Dk62kjV4y+BLF9tLYdlt8qNRjAT0383RHbQBUN+nvP0UegL+2tiQkjZWOfKUEK1TLpJl3F9FL0TcT4NSoPECC5lRBtr/RDOyqcJQH87ycNdKCfXzxcgF0TfwAa/VYC4SgBIioZGwk8Wk+rnb+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781945; c=relaxed/simple;
	bh=Q17GVPfrSuAtQmu5IIfQPj07HOmr2F3zTKquIdGT8Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQWF3BCLF0ty7iQ8H5gm8Xy10VnvaHfWyuOt/2h+9sVCO3OS2xNBHJ+XUopTFZ8Mjb9n5n2v8KfKkRaLz3R33MkfCC9KEey8o0DcW0OcnTOQROU74Hwca++q6xpe3k4revoEkCfDHerdCYrFFY60DjyUbHv55ckUiqAIF/LwdNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=vs8sP/1m; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="vs8sP/1m"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2024071210485340e7a5cbf09383a197
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:48:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LckumQNyeZvAHrWa3c5VEG6aVczVdFwEO2psnBfkWMo=;
 b=vs8sP/1mbiuAWSJ9YTfyJ+qaKjfQkEGzgKoOrzJAaGAUK5x/sHZ379bmpS5MD4HvSzmlJI
 b+rQpujyFX/1PQxNOHMmttyukMsyNz6MoH5SigA80mH8h0Gybysz6W5MBHznyqLMd1FQTMR4
 nSEFknXjRyqayJqNIb6Kx1InYZDMA=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:48:59 +0200
Subject: [PATCH v2 13/33] drivers/freescale: Add missing log levels of
 rtdm_printk_ratelimited()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-13-facd992606c7@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/drivers/freescale/fec_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
index 5abf5e822..d1b6fd166 100644
--- a/kernel/drivers/net/drivers/freescale/fec_main.c
+++ b/kernel/drivers/net/drivers/freescale/fec_main.c
@@ -395,7 +395,7 @@ static int fec_rt_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 
 	entries_free = fec_enet_get_free_txdesc_num(txq);
 	if (entries_free < MAX_SKB_FRAGS + 1) {
-		rtdm_printk_ratelimited("%s: NOT enough BD for SG!\n",
+		rtdm_printk_ratelimited(KERN_ERR "%s: NOT enough BD for SG!\n",
 					dev_name(&fep->pdev->dev));
 		return NETDEV_TX_BUSY;
 	}
@@ -431,7 +431,8 @@ static int fec_rt_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 	if (dma_mapping_error(&fep->pdev->dev, addr)) {
 		rtdm_lock_put_irqrestore(&frt->lock, c);
 		dev_kfree_rtskb(skb);
-		rtdm_printk_ratelimited("%s: Tx DMA memory map failed\n",
+		rtdm_printk_ratelimited(KERN_ERR
+					"%s: Tx DMA memory map failed\n",
 					dev_name(&fep->pdev->dev));
 		return NETDEV_TX_BUSY;
 	}
@@ -1018,7 +1019,8 @@ fec_rt_new_rxbdp(struct net_device *ndev, struct bufdesc *bdp, struct rtskb *skb
 
 	bdp->cbd_bufaddr = cpu_to_fec32(dma_map_single(&fep->pdev->dev, skb->data, RTSKB_SIZE - fep->rx_align, DMA_FROM_DEVICE));
 	if (dma_mapping_error(&fep->pdev->dev, fec32_to_cpu(bdp->cbd_bufaddr))) {
-		rtdm_printk_ratelimited("%s: Rx DMA memory map failed\n",
+		rtdm_printk_ratelimited(KERN_ERR
+					"%s: Rx DMA memory map failed\n",
 					dev_name(&fep->pdev->dev));
 		return -ENOMEM;
 	}

-- 
2.39.2

