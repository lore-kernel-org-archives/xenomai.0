From: Richard Cochran <richardcochran@domain.hid>
Date: Fri, 23 Sep 2011 13:16:46 +0200
Message-Id: <a2c0ba72fbfee298d885525d7a732cb8c20ccd5b.1316775991.git.richard.cochran@domain.hid>
In-Reply-To: <cover.1316775991.git.richard.cochran@domain.hid>
References: <cover.1316775991.git.richard.cochran@domain.hid>
In-Reply-To: <cover.1316775991.git.richard.cochran@domain.hid>
References: <cover.1316775991.git.richard.cochran@domain.hid>
Subject: [Xenomai-core] [RFC 1/4] gianfar: reserve the first transmit queue
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This commit adjusts the code to use the second hardware transmit queue.
The idea is to keep the first queue open for later use as a fast path
for real time Ethernet packets.

Signed-off-by: Richard Cochran <richard.cochran@domain.hid>
---
 drivers/net/gianfar.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 7d83091..cecfb4f 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -99,6 +99,9 @@
 #include "gianfar.h"
 #include "fsl_pq_mdio.h"
 
+/* Reserve the first transmit queue. */
+#define QADJ(x) (x+1)
+
 #define TX_TIMEOUT      (1*HZ)
 #undef BRIEF_GFAR_ERRORS
 #undef VERBOSE_GFAR_ERRORS
@@ -331,7 +334,7 @@ static void gfar_init_tx_rx_base(struct gfar_private *priv)
 	u32 __iomem *baddr;
 	int i;
 
-	baddr = &regs->tbase0;
+	baddr = &regs->tbase1;
 	for(i = 0; i < priv->num_tx_queues; i++) {
 		gfar_write(baddr, priv->tx_queue[i]->tx_bd_dma_base);
 		baddr	+= 2;
@@ -1121,8 +1124,8 @@ static int gfar_probe(struct platform_device *ofdev,
 				priv->num_tx_queues) {
 			priv->gfargrp[grp_idx].num_tx_queues++;
 			priv->tx_queue[i]->grp = &priv->gfargrp[grp_idx];
-			tstat = tstat | (TSTAT_CLEAR_THALT >> i);
-			tqueue = tqueue | (TQUEUE_EN0 >> i);
+			tstat  = tstat | (TSTAT_CLEAR_THALT >> QADJ(i));
+			tqueue = tqueue | (TQUEUE_EN0 >> QADJ(i));
 		}
 		priv->gfargrp[grp_idx].rstat = rstat;
 		priv->gfargrp[grp_idx].tstat = tstat;
@@ -2247,7 +2250,7 @@ static int gfar_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	/* Tell the DMA to go go go */
-	gfar_write(&regs->tstat, TSTAT_CLEAR_THALT >> tx_queue->qindex);
+	gfar_write(&regs->tstat, TSTAT_CLEAR_THALT >> QADJ(tx_queue->qindex));
 
 	/* Unlock priv */
 	spin_unlock_irqrestore(&tx_queue->txlock, flags);
-- 
1.7.2.5


