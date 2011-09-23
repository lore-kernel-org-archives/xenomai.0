From: Richard Cochran <richardcochran@domain.hid>
Date: Fri, 23 Sep 2011 13:16:48 +0200
Message-Id: <31527b677d1d58ef03e2e1b96cc26e97555985bc.1316775991.git.richard.cochran@domain.hid>
In-Reply-To: <cover.1316775991.git.richard.cochran@domain.hid>
References: <cover.1316775991.git.richard.cochran@domain.hid>
In-Reply-To: <cover.1316775991.git.richard.cochran@domain.hid>
References: <cover.1316775991.git.richard.cochran@domain.hid>
Subject: [Xenomai-core] [RFC 3/4] Add a real time module for the gianfar
	driver.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This commit adds support for the xenomai packet interface to the gianfar
driver. Only the transmit path is implemented.

Signed-off-by: Richard Cochran <richard.cochran@domain.hid>
---
 drivers/net/Makefile     |    5 +
 drivers/net/gianfar.c    |   20 +--
 drivers/net/gianfar.h    |   74 +++++++++++
 drivers/net/gianfar_rt.c |  314 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 399 insertions(+), 14 deletions(-)
 create mode 100644 drivers/net/gianfar_rt.c

diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 46737b3..1db25fb 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -40,6 +40,11 @@ gianfar_driver-objs := gianfar.o \
 		gianfar_ethtool.o \
 		gianfar_sysfs.o
 
+ifeq ($(CONFIG_XENOMAI),y)
+EXTRA_CFLAGS += -D__IN_XENOMAI__ -Iinclude/xenomai
+gianfar_driver-objs += gianfar_rt.o
+endif
+
 obj-$(CONFIG_UCC_GETH) += ucc_geth_driver.o
 ucc_geth_driver-objs := ucc_geth.o ucc_geth_ethtool.o
 
diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 78c68b1..2ffde68 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -1071,6 +1071,8 @@ static int gfar_probe(struct platform_device *ofdev,
 		rstat = tstat =0;
 	}
 
+	tqueue |= TQUEUE_EN0; /* Enable real time Tx queue. */
+
 	gfar_write(&regs->rqueue, rqueue);
 	gfar_write(&regs->tqueue, tqueue);
 
@@ -1166,6 +1168,8 @@ static int gfar_probe(struct platform_device *ofdev,
 		 printk(KERN_INFO "%s: TX BD ring size for Q[%d]: %d\n",
 			dev->name, i, priv->tx_queue[i]->tx_ring_size);
 
+	gfar_rt_init(priv);
+
 	return 0;
 
 register_fail:
@@ -1195,6 +1199,8 @@ static int gfar_remove(struct platform_device *ofdev)
 	unmap_group_regs(priv);
 	free_netdev(priv->ndev);
 
+	gfar_rt_cleanup(priv);
+
 	return 0;
 }
 
@@ -1961,20 +1967,6 @@ void inline gfar_tx_vlan(struct sk_buff *skb, struct txfcb *fcb)
 	fcb->vlctl = vlan_tx_tag_get(skb);
 }
 
-static inline struct txbd8 *skip_txbd(struct txbd8 *bdp, int stride,
-			       struct txbd8 *base, int ring_size)
-{
-	struct txbd8 *new_bd = bdp + stride;
-
-	return (new_bd >= (base + ring_size)) ? (new_bd - ring_size) : new_bd;
-}
-
-static inline struct txbd8 *next_txbd(struct txbd8 *bdp, struct txbd8 *base,
-		int ring_size)
-{
-	return skip_txbd(bdp, 1, base, ring_size);
-}
-
 /* This is called by the kernel when a frame is ready for transmission. */
 /* It is pointed to by the dev->hard_start_xmit function pointer */
 static int gfar_start_xmit(struct sk_buff *skb, struct net_device *dev)
diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h
index 77167ce..d9ead28 100644
--- a/drivers/net/gianfar.h
+++ b/drivers/net/gianfar.h
@@ -47,6 +47,10 @@
 #include <linux/workqueue.h>
 #include <linux/ethtool.h>
 
+#ifdef CONFIG_XENOMAI
+#include <rtdm/rtpacket.h>
+#endif /* CONFIG_XENOMAI */
+
 /* The maximum number of packets to be handled in one call of gfar_poll */
 #define GFAR_DEV_WEIGHT 64
 
@@ -547,6 +551,20 @@ struct txbd8
 	u32	bufPtr;	/* Buffer Pointer */
 };
 
+static inline struct txbd8 *skip_txbd(struct txbd8 *bdp, int stride,
+				      struct txbd8 *base, int ring_size)
+{
+	struct txbd8 *new_bd = bdp + stride;
+
+	return (new_bd >= (base + ring_size)) ? (new_bd - ring_size) : new_bd;
+}
+
+static inline struct txbd8 *next_txbd(struct txbd8 *bdp, struct txbd8 *base,
+		int ring_size)
+{
+	return skip_txbd(bdp, 1, base, ring_size);
+}
+
 struct txfcb {
 	u8	flags;
 	u8	ptp;    /* Flag to enable tx timestamping */
@@ -1040,6 +1058,38 @@ enum gfar_errata {
 	GFAR_ERRATA_A002	= 0x04,
 };
 
+#ifdef CONFIG_XENOMAI
+
+struct gfar_rt_tx_q {
+	struct rtpacket ** tx_rtp;
+	dma_addr_t tx_bd_dma_base;
+	struct	txbd8 *tx_bd_base;
+	struct	txbd8 *cur_tx;
+	struct	txbd8 *dirty_tx;
+	struct	net_device *dev;
+	struct gfar_priv_grp *grp;
+	u16	skb_curtx;
+	u16	skb_dirtytx;
+	u16	qindex;
+	unsigned int tx_ring_size;
+	unsigned int num_txbdfree;
+};
+
+struct gfar_rt_rx_q {
+	struct	rtpacket ** rx_rtp;
+	dma_addr_t rx_bd_dma_base;
+	struct	rxbd8 *rx_bd_base;
+	struct	rxbd8 *cur_rx;
+	struct	net_device *dev;
+	struct gfar_priv_grp *grp;
+	u16	skb_currx;
+	u16	qindex;
+	unsigned int	rx_ring_size;
+	struct rtpacket_pool pool;
+};
+
+#endif /* CONFIG_XENOMAI */
+
 /* Struct stolen almost completely (and shamelessly) from the FCC enet source
  * (Ok, that's not so true anymore, but there is a family resemblence)
  * The GFAR buffer descriptors track the ring buffers.  The rx_bd_base
@@ -1120,6 +1170,20 @@ struct gfar_private {
 	/* HW time stamping enabled flag */
 	int hwts_rx_en;
 	int hwts_tx_en;
+
+#ifdef CONFIG_XENOMAI
+	struct rtpacket_interface *rtif;
+	struct rtpacket_driver_ops rtops;
+	struct gfar_rt_tx_q rt_txq;
+	struct gfar_rt_rx_q rt_rxq;
+	/*
+	 * Protects:
+	 *  - rt_txq.num_txbdfree
+	 *  - regs->tstat
+	 */
+	rtdm_lock_t txlock;
+
+#endif /* CONFIG_XENOMAI */
 };
 
 static inline int gfar_has_errata(struct gfar_private *priv,
@@ -1166,4 +1230,14 @@ void gfar_init_sysfs(struct net_device *dev);
 
 extern const struct ethtool_ops gfar_ethtool_ops;
 
+#ifdef CONFIG_XENOMAI
+extern void gfar_rt_clean_tx_ring(struct gfar_private *priv);
+extern void gfar_rt_init(struct gfar_private *priv);
+extern void gfar_rt_cleanup(struct gfar_private *priv);
+#else
+static inline void gfar_rt_clean_tx_ring(struct gfar_private *priv) {}
+static inline void gfar_rt_init(struct gfar_private *priv) {}
+static inline void gfar_rt_cleanup(struct gfar_private *priv) {}
+#endif
+
 #endif /* __GIANFAR_H */
diff --git a/drivers/net/gianfar_rt.c b/drivers/net/gianfar_rt.c
new file mode 100644
index 0000000..a7dda5a
--- /dev/null
+++ b/drivers/net/gianfar_rt.c
@@ -0,0 +1,314 @@
+#include <linux/of.h>
+
+#include "gianfar.h"
+
+#define RT_TX_RING_SIZE RTPACKET_TX_POOL_SIZE
+#define RT_RX_RING_SIZE 128
+#define RT_BD_BUFSIZE \
+(sizeof(struct txbd8)*RT_TX_RING_SIZE + sizeof(struct rxbd8)*RT_RX_RING_SIZE)
+
+static int rt_transmit(struct rtpacket_driver_ops *ops, struct rtpacket *rtp)
+{
+	struct gfar_private *priv =
+		container_of(ops, struct gfar_private, rtops);
+	struct gfar_rt_tx_q *q = &priv->rt_txq;
+	struct gfar __iomem *regs = q->grp->regs;
+	struct txbd8 *txbdp, *txbdp_start, *base = q->tx_bd_base;
+	unsigned int nr_frags, nr_txbds;
+	rtdm_lockctx_t ctx;
+	u32 lstatus;
+
+	gfar_rt_clean_tx_ring(priv);
+
+	nr_frags = 0;
+	nr_txbds = nr_frags + 1;
+	if (nr_txbds > q->num_txbdfree)
+		return -1;
+
+	txbdp = txbdp_start = q->cur_tx;
+	lstatus = txbdp->lstatus;
+	lstatus |= BD_LFLAG(TXBD_LAST | TXBD_INTERRUPT);
+
+	txbdp_start->bufPtr = rtp->data.pa;
+
+	lstatus |= BD_LFLAG(TXBD_CRC | TXBD_READY) | rtp->length;
+
+	rtdm_lock_get_irqsave(&priv->txlock, ctx);
+
+	eieio();
+	txbdp_start->lstatus = lstatus;
+	eieio(); /* force lstatus write before tx_skbuff */
+
+	q->tx_rtp[q->skb_curtx] = rtp;
+	q->skb_curtx = (q->skb_curtx + 1) & TX_RING_MOD_MASK(q->tx_ring_size);
+	q->cur_tx = next_txbd(txbdp, base, q->tx_ring_size);
+	q->num_txbdfree -= nr_txbds;
+
+	gfar_write(&regs->tstat, TSTAT_CLEAR_THALT0);
+
+	rtdm_lock_put_irqrestore(&priv->txlock, ctx);
+
+	return 0;
+}
+
+static void rt_recycle(struct rtpacket_driver_ops *ops, struct rtpacket *rtp)
+{
+	struct gfar_private *priv =
+		container_of(ops, struct gfar_private, rtops);
+
+	rtpacket_pool_push(&priv->rt_rxq.pool, rtp);
+}
+
+static void rt_free_skb_tx_queue(struct gfar_rt_tx_q *tx_queue)
+{
+	struct txbd8 *txbdp = tx_queue->tx_bd_base;
+	struct gfar_private *priv = netdev_priv(tx_queue->dev);
+	int i;
+
+	for (i = 0; i < tx_queue->tx_ring_size; i++) {
+		if (!tx_queue->tx_rtp[i])
+			continue;
+		txbdp->lstatus = 0;
+		txbdp++;
+		BUG_ON(!priv->rtif);
+		rtpacket_recycle(priv->rtif, tx_queue->tx_rtp[i]);
+		tx_queue->tx_rtp[i] = NULL;
+	}
+	kfree(tx_queue->tx_rtp);
+}
+
+static void rt_free_skb_rx_queue(struct gfar_rt_rx_q *rx_queue)
+{
+	struct rxbd8 *rxbdp = rx_queue->rx_bd_base;
+	int i;
+
+	for (i = 0; i < rx_queue->rx_ring_size; i++) {
+		if (rx_queue->rx_rtp[i]) {
+			rtpacket_pool_push(&rx_queue->pool, rx_queue->rx_rtp[i]);
+			rx_queue->rx_rtp[i] = NULL;
+		}
+		rxbdp->lstatus = 0;
+		rxbdp->bufPtr = 0;
+		rxbdp++;
+	}
+	rtpacket_pool_drain(&rx_queue->pool);
+	kfree(rx_queue->rx_rtp);
+}
+
+static void rt_free_skb_resources(struct gfar_private *priv)
+{
+	struct gfar_rt_tx_q *tx_queue = &priv->rt_txq;
+	struct gfar_rt_rx_q *rx_queue = &priv->rt_rxq;
+
+	if (tx_queue->tx_rtp)
+		rt_free_skb_tx_queue(tx_queue);
+
+	if (rx_queue->rx_rtp)
+		rt_free_skb_rx_queue(rx_queue);
+
+	dma_free_coherent(&priv->ofdev->dev, RT_BD_BUFSIZE,
+			  priv->rt_txq.tx_bd_base,
+			  priv->rt_txq.tx_bd_dma_base);
+}
+
+static void rt_init_rxbdp(struct gfar_rt_rx_q *rx_queue, struct rxbd8 *bdp,
+			  dma_addr_t buf)
+{
+	u32 lstatus;
+
+	bdp->bufPtr = buf;
+
+	lstatus = BD_LFLAG(RXBD_EMPTY | RXBD_INTERRUPT);
+	if (bdp == rx_queue->rx_bd_base + rx_queue->rx_ring_size - 1)
+		lstatus |= BD_LFLAG(RXBD_WRAP);
+
+	eieio();
+
+	bdp->lstatus = lstatus;
+}
+
+static int rt_init_bds(struct net_device *ndev)
+{
+	struct gfar_private *priv = netdev_priv(ndev);
+	struct gfar_rt_tx_q *tx_queue = &priv->rt_txq;
+	struct gfar_rt_rx_q *rx_queue = &priv->rt_rxq;
+	struct txbd8 *txbdp;
+	struct rxbd8 *rxbdp;
+	int j;
+
+	tx_queue->num_txbdfree = tx_queue->tx_ring_size;
+	tx_queue->dirty_tx = tx_queue->tx_bd_base;
+	tx_queue->cur_tx = tx_queue->tx_bd_base;
+	tx_queue->skb_curtx = 0;
+	tx_queue->skb_dirtytx = 0;
+	txbdp = tx_queue->tx_bd_base;
+	for (j = 0; j < tx_queue->tx_ring_size; j++) {
+		txbdp->lstatus = 0;
+		txbdp->bufPtr = 0;
+		txbdp++;
+	}
+	txbdp--;
+	txbdp->status |= TXBD_WRAP;
+
+	rx_queue->cur_rx = rx_queue->rx_bd_base;
+	rx_queue->skb_currx = 0;
+	rxbdp = rx_queue->rx_bd_base;
+
+	if (rtpacket_pool_init(&rx_queue->pool, &priv->ofdev->dev,
+			       rx_queue->rx_ring_size, RTPACKET_BUFFER_SIZE)) {
+		pr_err("%s: Can't allocate RX buffers\n", ndev->name);
+		goto err_rxalloc_fail;
+	}
+
+	for (j = 0; j < rx_queue->rx_ring_size; j++) {
+		struct rtpacket *rtp = rtpacket_pool_pop(&rx_queue->pool);
+		rx_queue->rx_rtp[j] = rtp;
+		rt_init_rxbdp(rx_queue, rxbdp, rtp->data.pa);
+		rxbdp++;
+	}
+
+	return 0;
+
+err_rxalloc_fail:
+	rt_free_skb_resources(priv);
+	return -ENOMEM;
+}
+
+static int rt_alloc_skb_resources(struct net_device *ndev)
+{
+	void *vaddr;
+	dma_addr_t addr;
+	int j;
+	struct gfar_private *priv = netdev_priv(ndev);
+	struct device *dev = &priv->ofdev->dev;
+	struct gfar_rt_tx_q *tx_queue = &priv->rt_txq;
+	struct gfar_rt_rx_q *rx_queue = &priv->rt_rxq;
+
+	tx_queue->grp = &priv->gfargrp[0];
+	rx_queue->grp = &priv->gfargrp[0];
+
+	vaddr = dma_alloc_coherent(dev, RT_BD_BUFSIZE, &addr, GFP_KERNEL);
+	if (!vaddr) {
+		pr_err("Could not allocate RT buffer descriptors!\n");
+		return -ENOMEM;
+	}
+	tx_queue->tx_bd_base = (struct txbd8 *) vaddr;
+	tx_queue->tx_bd_dma_base = addr;
+	tx_queue->dev = ndev;
+	tx_queue->tx_ring_size = RT_TX_RING_SIZE;
+	addr  += sizeof(struct txbd8) * tx_queue->tx_ring_size;
+	vaddr += sizeof(struct txbd8) * tx_queue->tx_ring_size;
+
+	rx_queue->rx_bd_base = (struct rxbd8 *) vaddr;
+	rx_queue->rx_bd_dma_base = addr;
+	rx_queue->dev = ndev;
+	rx_queue->rx_ring_size = RT_RX_RING_SIZE;
+	addr  += sizeof (struct rxbd8) * rx_queue->rx_ring_size;
+	vaddr += sizeof (struct rxbd8) * rx_queue->rx_ring_size;
+
+	tx_queue->tx_rtp = kmalloc(sizeof(*tx_queue->tx_rtp) *
+				      tx_queue->tx_ring_size, GFP_KERNEL);
+	if (!tx_queue->tx_rtp) {
+		pr_err("Could not allocate RT tx_rtp\n");
+		goto cleanup;
+	}
+	for (j = 0; j < tx_queue->tx_ring_size; j++)
+		tx_queue->tx_rtp[j] = NULL;
+
+	rx_queue->rx_rtp = kmalloc(sizeof(*rx_queue->rx_rtp) *
+				      rx_queue->rx_ring_size, GFP_KERNEL);
+	if (!rx_queue->rx_rtp) {
+		pr_err("Could not allocate RT rx_rtp\n");
+		goto cleanup;
+	}
+	for (j = 0; j < rx_queue->rx_ring_size; j++)
+		rx_queue->rx_rtp[j] = NULL;
+
+	if (rt_init_bds(ndev))
+		goto cleanup;
+
+	return 0;
+cleanup:
+	rt_free_skb_resources(priv);
+	return -ENOMEM;
+}
+
+void gfar_rt_clean_tx_ring(struct gfar_private *priv)
+{
+	struct gfar_rt_tx_q *q = &priv->rt_txq;
+	struct txbd8 *bdp, *lbdp, *base = q->tx_bd_base;
+	int nr_txbds = 1, dirty, ring_size = q->tx_ring_size;
+	struct rtpacket *rtp;
+	rtdm_lockctx_t ctx;
+	u32 lstat;
+
+	bdp = q->dirty_tx;
+	dirty = q->skb_dirtytx;
+
+	while ((rtp = q->tx_rtp[dirty])) {
+
+		lbdp = skip_txbd(bdp, nr_txbds - 1, base, ring_size);
+		lstat = lbdp->lstatus;
+
+		if ((lstat & BD_LFLAG(TXBD_READY)) && (lstat & BD_LENGTH_MASK)) {
+			pr_err("lstat 0x%x not ready\n", lstat);
+			break;
+		}
+
+		bdp->lstatus &= BD_LFLAG(TXBD_WRAP);
+		bdp = next_txbd(bdp, base, ring_size);
+
+		rtpacket_recycle(priv->rtif, rtp);
+
+		q->tx_rtp[dirty] = NULL;
+		dirty = (dirty + 1) & TX_RING_MOD_MASK(ring_size);
+
+		rtdm_lock_get_irqsave(&priv->txlock, ctx);
+		q->num_txbdfree += nr_txbds;
+		rtdm_lock_put_irqrestore(&priv->txlock, ctx);
+	}
+
+	q->skb_dirtytx = dirty;
+	q->dirty_tx = bdp;
+}
+
+static void rt_init_tx_rx_base(struct gfar_private *priv)
+{
+	struct gfar __iomem *regs = priv->gfargrp[0].regs;
+	u32 __iomem *baddr;
+
+	baddr = &regs->tbase0;
+	gfar_write(baddr, priv->rt_txq.tx_bd_dma_base);
+
+	baddr = &regs->rbase0;
+	gfar_write(baddr, priv->rt_rxq.rx_bd_dma_base);
+}
+
+void gfar_rt_init(struct gfar_private *priv)
+{
+	if (rt_alloc_skb_resources(priv->ndev)) {
+		pr_err("failed to allocate real time resources\n");
+		return;
+	}
+
+	rt_init_tx_rx_base(priv);
+
+	priv->rtops.owner = THIS_MODULE;
+	snprintf(priv->rtops.name, 16, "%s", priv->ndev->name);
+	priv->rtops.transmit = rt_transmit;
+	priv->rtops.recycle = rt_recycle;
+
+	rtdm_lock_init(&priv->txlock);
+
+	priv->rtif = rtpacket_register(&priv->rtops, &priv->ofdev->dev, 0);
+	if (!priv->rtif) {
+		pr_err("failed to register real time device\n");
+		rt_free_skb_resources(priv);
+	}
+}
+
+void gfar_rt_cleanup(struct gfar_private *priv)
+{
+	rt_free_skb_resources(priv);
+	rtpacket_deregister(priv->rtif);
+}
-- 
1.7.2.5


