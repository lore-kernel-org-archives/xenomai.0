Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAA917CA2
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 22:26:36 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 959511C0007
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 22:26:29 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 71DA9941C31
	for <xenomai@xenomai.org>; Tue, 22 Nov 2022 22:26:28 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20221122222627ca67f4746315a25e2e
        for <xenomai@xenomai.org>;
        Tue, 22 Nov 2022 23:26:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DQv9t5oXU4FKEU1qqUbF9+LY+MHI6QwTWCIls/Edf7A=;
 b=Fj3iSOuyrTTGS+MkA8n612ESnLBUNd5yuVgFWu4cPWT4OVAFPtd3NBmmgqUljxEPeakVx/
 +VK/Hg3lWpdcMuOAWAcxlLWAkIeL1x2pKbFdjLrH0BV6xD+gHuWiEoCueXxCeyXbuz9KSSqa
 c5WJQnKw9EPG2KwM0U/ANRE01TjKI=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Cc: Gunter Grau <gunter.grau@philips.com>
Subject: [PATCH 3/8] drivers/net/freescale: Drop NAPI traces
Date: Tue, 22 Nov 2022 23:26:21 +0100
Message-Id: <ba1c3f30999b189ef19ee4149cff31490d7d9508.1669155986.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1669155986.git.jan.kiszka@siemens.com>
References: <cover.1669155986.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool1: domain of rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) client-ip=185.136.64.228; envelope-from=fm-294854-20221122222627ca67f4746315a25e2e-Og6l_b@rts-flowmailer.siemens.com; helo=mta-64-228.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=Fj3iSOuy;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20221122222627ca67f4746315a25e2e-Og6l_b@rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) smtp.mailfrom=fm-294854-20221122222627ca67f4746315a25e2e-Og6l_b@rts-flowmailer.siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

This is an RTnet driver, so it has no need to interact with NAPI as the
kernel provides. Cleaning up also fixes building over 6.1.

CC: Gunter Grau <gunter.grau@philips.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/freescale/fec.h    |  1 -
 .../drivers/net/drivers/freescale/fec_main.c  | 22 -------------------
 2 files changed, 23 deletions(-)

diff --git a/kernel/drivers/net/drivers/freescale/fec.h b/kernel/drivers/net/drivers/freescale/fec.h
index 002085a373..0e25662967 100644
--- a/kernel/drivers/net/drivers/freescale/fec.h
+++ b/kernel/drivers/net/drivers/freescale/fec.h
@@ -571,7 +571,6 @@ struct fec_enet_private {
 	int	wol_flag;
 	u32	quirks;
 
-	struct	napi_struct napi;
 	int	csum_flags;
 
 	struct work_struct tx_timeout_work;
diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
index 0080505397..21d98e44df 100644
--- a/kernel/drivers/net/drivers/freescale/fec_main.c
+++ b/kernel/drivers/net/drivers/freescale/fec_main.c
@@ -1227,25 +1227,6 @@ fec_rt_interrupt(rtdm_irq_t *irqh)
 	return ret;
 }
 
-static int fec_enet_rx_napi(struct napi_struct *napi, int budget)
-{
-	struct net_device *ndev = napi->dev;
-	struct fec_enet_private *fep = netdev_priv(ndev);
-	int done = 0;
-
-	do {
-		done += fec_enet_rx(ndev, budget - done);
-		fec_enet_tx(ndev);
-	} while ((done < budget) && fec_enet_collect_events(fep));
-
-	if (done < budget) {
-		napi_complete_done(napi, done);
-		writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
-	}
-
-	return done;
-}
-
 /* ------------------------------------------------------------------------- */
 static void fec_get_mac(struct net_device *ndev)
 {
@@ -2661,7 +2642,6 @@ __fec_enet_open(struct net_device *ndev)
 	if (fep->quirks & FEC_QUIRK_ERR006687)
 		imx6q_cpuidle_fec_irqs_used();
 
-	napi_enable(&fep->napi);
 	phy_start(ndev->phydev);
 	netif_tx_start_all_queues(ndev);
 
@@ -2712,7 +2692,6 @@ fec_enet_close(struct net_device *ndev)
 	phy_stop(ndev->phydev);
 
 	if (netif_device_present(ndev)) {
-		napi_disable(&fep->napi);
 		netif_tx_disable(ndev);
 		fec_stop(ndev);
 	}
@@ -3045,7 +3024,6 @@ static int fec_enet_init(struct net_device *ndev)
 	ndev->ethtool_ops = &fec_enet_ethtool_ops;
 
 	writel(FEC_RX_DISABLED_IMASK, fep->hwp + FEC_IMASK);
-	netif_napi_add(ndev, &fep->napi, fec_enet_rx_napi, NAPI_POLL_WEIGHT);
 
 	if (fep->quirks & FEC_QUIRK_HAS_VLAN)
 		/* enable hw VLAN support */
-- 
2.35.3

