Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C3817B40B
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013153; cv=none; b=Kr09gdPH+av1Zz/FHUkGdhle0ySROts1K5zG2sfoD7/j5C314VnoiJn+IFWJPoCOgAFLMQ4HFrdqZeCzzRKevdqo5CIFLSsKp4v5AxVWascK5VrPyUQY7cx+3Z3pfapsqfXhzi3JlAj49d7mPiReisHDK28nU/YPA6Z8Bv0anAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013153; c=relaxed/simple;
	bh=QB/Kc55UF5Y8kadIb+PtjO3a+AvFXkNfdaxV5gw4YxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fwi6JoPgKYFAjqcU/6mN5yv4ODjqyfjIeGBjMq4lVvL6B2RdxDRglY+LS+hRcBXU1yuAV0gLp8VBAA61D663RJYGhdNqDPCEmrpMCwV6W90+nocFi6mntM7DybC4qGXLtPsw2j9Ob5cm8DVDuSq1Z7SZUcT5Dj8cb2BKunWncr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=HXb9ONtp; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="HXb9ONtp"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202407031325434d07c3b0367bfea77f
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9eAaozoCEwPAnS6wuFtHVYyq8NUEMZSWAz69OHKU+Kw=;
 b=HXb9ONtpye0jvTXVFg3JKvE2Y3FkOxxZrNqWb8pVDJ6KkJFtSE/KTJ4xSmmrZH203+0LTW
 DKXdkZeLk2JH82nJz5a+TMX6/DmV7b4EVE2/KVUuFi72ltecwIAHCcqgVgmoyIP+Ix0Pm6Od
 K02KC15QgJr7lGQWrw1tYTDYCwWIE=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:36 +0200
Subject: [PATCH 13/33] drivers/freescale: Add missing log levels of
 rtdm_printk_ratelimited()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-13-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

No functional change.

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

