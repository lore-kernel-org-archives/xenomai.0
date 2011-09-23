From: Richard Cochran <richardcochran@domain.hid>
Date: Fri, 23 Sep 2011 13:16:49 +0200
Message-Id: <76ed8afa668cd9f6e272d490290acb1909f58019.1316775991.git.richard.cochran@domain.hid>
In-Reply-To: <cover.1316775991.git.richard.cochran@domain.hid>
References: <cover.1316775991.git.richard.cochran@domain.hid>
In-Reply-To: <cover.1316775991.git.richard.cochran@domain.hid>
References: <cover.1316775991.git.richard.cochran@domain.hid>
Subject: [Xenomai-core] [RFC 4/4] Add a real time packet reception to the
	gianfar driver.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This commit completes the support for the xenomai packet interface in
the gianfar driver.

Signed-off-by: Richard Cochran <richard.cochran@domain.hid>
---
 drivers/net/gianfar.c    |    4 +++
 drivers/net/gianfar.h    |    2 +
 drivers/net/gianfar_rt.c |   60 ++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 2ffde68..5cef1e4 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -1072,6 +1072,7 @@ static int gfar_probe(struct platform_device *ofdev,
 	}
 
 	tqueue |= TQUEUE_EN0; /* Enable real time Tx queue. */
+	rqueue |= (RQUEUE_EN0|RQUEUE_EX0);
 
 	gfar_write(&regs->rqueue, rqueue);
 	gfar_write(&regs->tqueue, tqueue);
@@ -2749,6 +2750,9 @@ static int gfar_poll(struct napi_struct *napi, int budget)
 	 * because of the packets that have already arrived */
 	gfar_write(&regs->ievent, IEVENT_RTX_MASK);
 
+	gfar_rt_clean_tx_ring(priv);
+	gfar_rt_clean_rx_ring(priv);
+
 	while (num_queues && left_over_budget) {
 
 		budget_per_queue = left_over_budget/num_queues;
diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h
index d9ead28..5d9b20a 100644
--- a/drivers/net/gianfar.h
+++ b/drivers/net/gianfar.h
@@ -1232,10 +1232,12 @@ extern const struct ethtool_ops gfar_ethtool_ops;
 
 #ifdef CONFIG_XENOMAI
 extern void gfar_rt_clean_tx_ring(struct gfar_private *priv);
+extern void gfar_rt_clean_rx_ring(struct gfar_private *priv);
 extern void gfar_rt_init(struct gfar_private *priv);
 extern void gfar_rt_cleanup(struct gfar_private *priv);
 #else
 static inline void gfar_rt_clean_tx_ring(struct gfar_private *priv) {}
+static inline void gfar_rt_clean_rx_ring(struct gfar_private *priv) {}
 static inline void gfar_rt_init(struct gfar_private *priv) {}
 static inline void gfar_rt_cleanup(struct gfar_private *priv) {}
 #endif
diff --git a/drivers/net/gianfar_rt.c b/drivers/net/gianfar_rt.c
index a7dda5a..50bc54e 100644
--- a/drivers/net/gianfar_rt.c
+++ b/drivers/net/gianfar_rt.c
@@ -7,6 +7,27 @@
 #define RT_BD_BUFSIZE \
 (sizeof(struct txbd8)*RT_TX_RING_SIZE + sizeof(struct rxbd8)*RT_RX_RING_SIZE)
 
+static int rt_filter(struct rtpacket_driver_ops *ops, struct rtpacket_filter *f)
+{
+	struct gfar_private *priv =
+		container_of(ops, struct gfar_private, rtops);
+	int i;
+	u32 rqfpr, rqfcr = RQFCR_QUEUE_0 | RQFCR_CMP_EXACT | RQFCR_PID_ETY;
+
+	for (i = 0; i < RTPACKET_MAX_FILTER && f->ethertype[i]; i++) {
+		rqfpr = f->ethertype[i];
+		gfar_write_filer(priv, i, rqfcr, rqfpr);
+	}
+
+	/* Restore default rule in unused slots. */
+	rqfcr = RQFCR_QUEUE_1 | RQFCR_CMP_MATCH;
+	rqfpr = 0;
+	for (; i < RTPACKET_MAX_FILTER; i++)
+		gfar_write_filer(priv, i, rqfcr, rqfpr);
+
+	return 0;
+}
+
 static int rt_transmit(struct rtpacket_driver_ops *ops, struct rtpacket *rtp)
 {
 	struct gfar_private *priv =
@@ -18,8 +39,6 @@ static int rt_transmit(struct rtpacket_driver_ops *ops, struct rtpacket *rtp)
 	rtdm_lockctx_t ctx;
 	u32 lstatus;
 
-	gfar_rt_clean_tx_ring(priv);
-
 	nr_frags = 0;
 	nr_txbds = nr_frags + 1;
 	if (nr_txbds > q->num_txbdfree)
@@ -155,7 +174,9 @@ static int rt_init_bds(struct net_device *ndev)
 	rxbdp = rx_queue->rx_bd_base;
 
 	if (rtpacket_pool_init(&rx_queue->pool, &priv->ofdev->dev,
-			       rx_queue->rx_ring_size, RTPACKET_BUFFER_SIZE)) {
+			       GMAC_FCB_LEN + 8 /* time stamp padding */,
+			       2 * rx_queue->rx_ring_size,
+			       RTPACKET_BUFFER_SIZE)) {
 		pr_err("%s: Can't allocate RX buffers\n", ndev->name);
 		goto err_rxalloc_fail;
 	}
@@ -163,7 +184,7 @@ static int rt_init_bds(struct net_device *ndev)
 	for (j = 0; j < rx_queue->rx_ring_size; j++) {
 		struct rtpacket *rtp = rtpacket_pool_pop(&rx_queue->pool);
 		rx_queue->rx_rtp[j] = rtp;
-		rt_init_rxbdp(rx_queue, rxbdp, rtp->data.pa);
+		rt_init_rxbdp(rx_queue, rxbdp, rtp->base.pa);
 		rxbdp++;
 	}
 
@@ -272,6 +293,36 @@ void gfar_rt_clean_tx_ring(struct gfar_private *priv)
 	q->dirty_tx = bdp;
 }
 
+void gfar_rt_clean_rx_ring(struct gfar_private *priv)
+{
+	struct gfar_rt_rx_q *q = &priv->rt_rxq;
+	struct rxbd8 *bdp = q->cur_rx, *base = q->rx_bd_base;
+	struct rtpacket *rtp, *refill;
+	int rx_work_limit = RT_RX_RING_SIZE / 2;
+
+	while (!((bdp->status & RXBD_EMPTY) || (--rx_work_limit < 0))) {
+		rmb();
+
+		refill = rtpacket_pool_pop(&q->pool);
+		rtp = q->rx_rtp[q->skb_currx];
+
+		if (refill) {
+			rtp->length = bdp->length; /* todo: - ETH_FCS_LEN; */
+			rtpacket_receive(priv->rtif, rtp);
+		} else {
+			refill = rtp;
+			pr_err("no refill at %p", rtp);
+		}
+		q->rx_rtp[q->skb_currx] = refill;
+		rt_init_rxbdp(q, bdp, refill->base.pa);
+		bdp = next_bd(bdp, base, q->rx_ring_size);
+		q->skb_currx = (q->skb_currx + 1) &
+			RX_RING_MOD_MASK(q->rx_ring_size);
+	}
+
+	q->cur_rx = bdp;
+}
+
 static void rt_init_tx_rx_base(struct gfar_private *priv)
 {
 	struct gfar __iomem *regs = priv->gfargrp[0].regs;
@@ -295,6 +346,7 @@ void gfar_rt_init(struct gfar_private *priv)
 
 	priv->rtops.owner = THIS_MODULE;
 	snprintf(priv->rtops.name, 16, "%s", priv->ndev->name);
+	priv->rtops.filter = rt_filter;
 	priv->rtops.transmit = rt_transmit;
 	priv->rtops.recycle = rt_recycle;
 
-- 
1.7.2.5


