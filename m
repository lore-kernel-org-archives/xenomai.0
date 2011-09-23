From: Richard Cochran <richardcochran@domain.hid>
Date: Fri, 23 Sep 2011 13:16:47 +0200
Message-Id: <397498a8db5bcfc848ca0e93bcd7ed64fcea9d1e.1316775991.git.richard.cochran@domain.hid>
In-Reply-To: <cover.1316775991.git.richard.cochran@domain.hid>
References: <cover.1316775991.git.richard.cochran@domain.hid>
In-Reply-To: <cover.1316775991.git.richard.cochran@domain.hid>
References: <cover.1316775991.git.richard.cochran@domain.hid>
Subject: [Xenomai-core] [RFC 2/4] gianfar: reserve the first receive queue
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This commit adjusts the code to use the second hardware receive queue.
The idea is to keep the first queue open for later use as a fast path
for real time Ethernet packets.

Note that this patch relies on the specific filer capabilities of eTSEC
version 1.2 (like in the p2020) and probably will not work on later
versions (like in the p1020), since Freescale keeps changing their
hardware interfaces.

Signed-off-by: Richard Cochran <richard.cochran@domain.hid>
---
 drivers/net/gianfar.c         |   85 +++------------------
 drivers/net/gianfar.h         |   14 ++-
 drivers/net/gianfar_ethtool.c |  163 +----------------------------------------
 3 files changed, 23 insertions(+), 239 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index cecfb4f..78c68b1 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -340,7 +340,7 @@ static void gfar_init_tx_rx_base(struct gfar_private *priv)
 		baddr	+= 2;
 	}
 
-	baddr = &regs->rbase0;
+	baddr = &regs->rbase1;
 	for(i = 0; i < priv->num_rx_queues; i++) {
 		gfar_write(baddr, priv->rx_queue[i]->rx_bd_dma_base);
 		baddr   += 2;
@@ -361,11 +361,8 @@ static void gfar_init_mac(struct net_device *ndev)
 	/* Configure the coalescing support */
 	gfar_configure_coalescing(priv, 0xFF, 0xFF);
 
-	if (priv->rx_filer_enable) {
-		rctrl |= RCTRL_FILREN;
-		/* Program the RIR0 reg with the required distribution */
-		gfar_write(&regs->rir0, DEFAULT_RIR0);
-	}
+	/* Enable the filer to allow packets into the second Rx queue. */
+	rctrl |= RCTRL_FILREN | RCTRL_PRSDEP_L2;
 
 	if (priv->rx_csum_enable)
 		rctrl |= RCTRL_CHECKSUMMING;
@@ -479,9 +476,6 @@ static const struct net_device_ops gfar_netdev_ops = {
 #endif
 };
 
-unsigned int ftp_rqfpr[MAX_FILER_IDX + 1];
-unsigned int ftp_rqfcr[MAX_FILER_IDX + 1];
-
 void lock_rx_qs(struct gfar_private *priv)
 {
 	int i = 0x0;
@@ -865,71 +859,16 @@ static unsigned int reverse_bitmap(unsigned int bit_map, unsigned int max_qs)
 	return new_bit_map;
 }
 
-static u32 cluster_entry_per_class(struct gfar_private *priv, u32 rqfar,
-				   u32 class)
-{
-	u32 rqfpr = FPR_FILER_MASK;
-	u32 rqfcr = 0x0;
-
-	rqfar--;
-	rqfcr = RQFCR_CLE | RQFCR_PID_MASK | RQFCR_CMP_EXACT;
-	ftp_rqfpr[rqfar] = rqfpr;
-	ftp_rqfcr[rqfar] = rqfcr;
-	gfar_write_filer(priv, rqfar, rqfcr, rqfpr);
-
-	rqfar--;
-	rqfcr = RQFCR_CMP_NOMATCH;
-	ftp_rqfpr[rqfar] = rqfpr;
-	ftp_rqfcr[rqfar] = rqfcr;
-	gfar_write_filer(priv, rqfar, rqfcr, rqfpr);
-
-	rqfar--;
-	rqfcr = RQFCR_CMP_EXACT | RQFCR_PID_PARSE | RQFCR_CLE | RQFCR_AND;
-	rqfpr = class;
-	ftp_rqfcr[rqfar] = rqfcr;
-	ftp_rqfpr[rqfar] = rqfpr;
-	gfar_write_filer(priv, rqfar, rqfcr, rqfpr);
-
-	rqfar--;
-	rqfcr = RQFCR_CMP_EXACT | RQFCR_PID_MASK | RQFCR_AND;
-	rqfpr = class;
-	ftp_rqfcr[rqfar] = rqfcr;
-	ftp_rqfpr[rqfar] = rqfpr;
-	gfar_write_filer(priv, rqfar, rqfcr, rqfpr);
-
-	return rqfar;
-}
-
 static void gfar_init_filer_table(struct gfar_private *priv)
 {
-	int i = 0x0;
-	u32 rqfar = MAX_FILER_IDX;
-	u32 rqfcr = 0x0;
-	u32 rqfpr = FPR_FILER_MASK;
-
-	/* Default rule */
-	rqfcr = RQFCR_CMP_MATCH;
-	ftp_rqfcr[rqfar] = rqfcr;
-	ftp_rqfpr[rqfar] = rqfpr;
-	gfar_write_filer(priv, rqfar, rqfcr, rqfpr);
-
-	rqfar = cluster_entry_per_class(priv, rqfar, RQFPR_IPV6);
-	rqfar = cluster_entry_per_class(priv, rqfar, RQFPR_IPV6 | RQFPR_UDP);
-	rqfar = cluster_entry_per_class(priv, rqfar, RQFPR_IPV6 | RQFPR_TCP);
-	rqfar = cluster_entry_per_class(priv, rqfar, RQFPR_IPV4);
-	rqfar = cluster_entry_per_class(priv, rqfar, RQFPR_IPV4 | RQFPR_UDP);
-	rqfar = cluster_entry_per_class(priv, rqfar, RQFPR_IPV4 | RQFPR_TCP);
-
-	/* cur_filer_idx indicated the first non-masked rule */
-	priv->cur_filer_idx = rqfar;
-
-	/* Rest are masked rules */
-	rqfcr = RQFCR_CMP_NOMATCH;
-	for (i = 0; i < rqfar; i++) {
-		ftp_rqfcr[i] = rqfcr;
-		ftp_rqfpr[i] = rqfpr;
+	int i;
+	u32 rqfcr = RQFCR_QUEUE_1 | RQFCR_CMP_MATCH;
+	u32 rqfpr = 0;
+	/*
+	 * By default, deliver all packets to the second queue.
+	 */
+	for (i = 0; i < MAX_FILER_IDX; i++)
 		gfar_write_filer(priv, i, rqfcr, rqfpr);
-	}
 }
 
 static void gfar_detect_errata(struct gfar_private *priv)
@@ -1116,8 +1055,8 @@ static int gfar_probe(struct platform_device *ofdev,
 				priv->num_rx_queues) {
 			priv->gfargrp[grp_idx].num_rx_queues++;
 			priv->rx_queue[i]->grp = &priv->gfargrp[grp_idx];
-			rstat = rstat | (RSTAT_CLEAR_RHALT >> i);
-			rqueue = rqueue | ((RQUEUE_EN0 | RQUEUE_EX0) >> i);
+			rstat = rstat | (RSTAT_CLEAR_RHALT >> QADJ(i));
+			rqueue = rqueue | ((RQUEUE_EN0|RQUEUE_EX0) >> QADJ(i));
 		}
 		priv->gfargrp[grp_idx].num_tx_queues = 0x0;
 		for_each_set_bit(i, &priv->gfargrp[grp_idx].tx_bit_map,
diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h
index 68984eb..77167ce 100644
--- a/drivers/net/gianfar.h
+++ b/drivers/net/gianfar.h
@@ -271,6 +271,7 @@ extern const char gfar_driver_version[];
 #define RCTRL_TUCSEN		0x00000100
 #define RCTRL_PRSDEP_MASK	0x000000c0
 #define RCTRL_PRSDEP_INIT	0x000000c0
+#define RCTRL_PRSDEP_L2		0x00000040
 #define RCTRL_PROM		0x00000008
 #define RCTRL_EMEN		0x00000002
 #define RCTRL_REQ_PARSER	(RCTRL_VLEX | RCTRL_IPCSEN | \
@@ -414,6 +415,14 @@ extern const char gfar_driver_version[];
 #define RQFCR_HASHTBL_2		0x00060000
 #define RQFCR_HASHTBL_3		0x00080000
 #define RQFCR_HASH		0x00010000
+#define RQFCR_QUEUE_7		0x00004000
+#define RQFCR_QUEUE_6		0x00003000
+#define RQFCR_QUEUE_5		0x00002000
+#define RQFCR_QUEUE_4		0x00001000
+#define RQFCR_QUEUE_3		0x00000C00
+#define RQFCR_QUEUE_2		0x00000800
+#define RQFCR_QUEUE_1		0x00000400
+#define RQFCR_QUEUE_0		0x00000000
 #define RQFCR_CLE		0x00000200
 #define RQFCR_RJE		0x00000100
 #define RQFCR_AND		0x00000080
@@ -1066,8 +1075,6 @@ struct gfar_private {
 	unsigned int rx_stash_size;
 	unsigned int rx_stash_index;
 
-	u32 cur_filer_idx;
-
 	struct sk_buff_head rx_recycle;
 
 	struct vlan_group *vlgrp;
@@ -1115,9 +1122,6 @@ struct gfar_private {
 	int hwts_tx_en;
 };
 
-extern unsigned int ftp_rqfpr[MAX_FILER_IDX + 1];
-extern unsigned int ftp_rqfcr[MAX_FILER_IDX + 1];
-
 static inline int gfar_has_errata(struct gfar_private *priv,
 				  enum gfar_errata err)
 {
diff --git a/drivers/net/gianfar_ethtool.c b/drivers/net/gianfar_ethtool.c
index 9bda023..c251dd5 100644
--- a/drivers/net/gianfar_ethtool.c
+++ b/drivers/net/gianfar_ethtool.c
@@ -680,169 +680,10 @@ static int gfar_ethflow_to_class(int flow_type, u64 *class)
 	return 1;
 }
 
-static void ethflow_to_filer_rules (struct gfar_private *priv, u64 ethflow)
-{
-	u32 fcr = 0x0, fpr = FPR_FILER_MASK;
-
-	if (ethflow & RXH_L2DA) {
-		fcr = RQFCR_PID_DAH |RQFCR_CMP_NOMATCH |
-			RQFCR_HASH | RQFCR_AND | RQFCR_HASHTBL_0;
-		ftp_rqfpr[priv->cur_filer_idx] = fpr;
-		ftp_rqfcr[priv->cur_filer_idx] = fcr;
-		gfar_write_filer(priv, priv->cur_filer_idx, fcr, fpr);
-		priv->cur_filer_idx = priv->cur_filer_idx - 1;
-
-		fcr = RQFCR_PID_DAL | RQFCR_AND | RQFCR_CMP_NOMATCH |
-				RQFCR_HASH | RQFCR_AND | RQFCR_HASHTBL_0;
-		ftp_rqfpr[priv->cur_filer_idx] = fpr;
-		ftp_rqfcr[priv->cur_filer_idx] = fcr;
-		gfar_write_filer(priv, priv->cur_filer_idx, fcr, fpr);
-		priv->cur_filer_idx = priv->cur_filer_idx - 1;
-	}
-
-	if (ethflow & RXH_VLAN) {
-		fcr = RQFCR_PID_VID | RQFCR_CMP_NOMATCH | RQFCR_HASH |
-				RQFCR_AND | RQFCR_HASHTBL_0;
-		gfar_write_filer(priv, priv->cur_filer_idx, fcr, fpr);
-		ftp_rqfpr[priv->cur_filer_idx] = fpr;
-		ftp_rqfcr[priv->cur_filer_idx] = fcr;
-		priv->cur_filer_idx = priv->cur_filer_idx - 1;
-	}
-
-	if (ethflow & RXH_IP_SRC) {
-		fcr = RQFCR_PID_SIA | RQFCR_CMP_NOMATCH | RQFCR_HASH |
-			RQFCR_AND | RQFCR_HASHTBL_0;
-		ftp_rqfpr[priv->cur_filer_idx] = fpr;
-		ftp_rqfcr[priv->cur_filer_idx] = fcr;
-		gfar_write_filer(priv, priv->cur_filer_idx, fcr, fpr);
-		priv->cur_filer_idx = priv->cur_filer_idx - 1;
-	}
-
-	if (ethflow & (RXH_IP_DST)) {
-		fcr = RQFCR_PID_DIA | RQFCR_CMP_NOMATCH | RQFCR_HASH |
-			RQFCR_AND | RQFCR_HASHTBL_0;
-		ftp_rqfpr[priv->cur_filer_idx] = fpr;
-		ftp_rqfcr[priv->cur_filer_idx] = fcr;
-		gfar_write_filer(priv, priv->cur_filer_idx, fcr, fpr);
-		priv->cur_filer_idx = priv->cur_filer_idx - 1;
-	}
-
-	if (ethflow & RXH_L3_PROTO) {
-		fcr = RQFCR_PID_L4P | RQFCR_CMP_NOMATCH | RQFCR_HASH |
-			RQFCR_AND | RQFCR_HASHTBL_0;
-		ftp_rqfpr[priv->cur_filer_idx] = fpr;
-		ftp_rqfcr[priv->cur_filer_idx] = fcr;
-		gfar_write_filer(priv, priv->cur_filer_idx, fcr, fpr);
-		priv->cur_filer_idx = priv->cur_filer_idx - 1;
-	}
-
-	if (ethflow & RXH_L4_B_0_1) {
-		fcr = RQFCR_PID_SPT | RQFCR_CMP_NOMATCH | RQFCR_HASH |
-			RQFCR_AND | RQFCR_HASHTBL_0;
-		ftp_rqfpr[priv->cur_filer_idx] = fpr;
-		ftp_rqfcr[priv->cur_filer_idx] = fcr;
-		gfar_write_filer(priv, priv->cur_filer_idx, fcr, fpr);
-		priv->cur_filer_idx = priv->cur_filer_idx - 1;
-	}
-
-	if (ethflow & RXH_L4_B_2_3) {
-		fcr = RQFCR_PID_DPT | RQFCR_CMP_NOMATCH | RQFCR_HASH |
-			RQFCR_AND | RQFCR_HASHTBL_0;
-		ftp_rqfpr[priv->cur_filer_idx] = fpr;
-		ftp_rqfcr[priv->cur_filer_idx] = fcr;
-		gfar_write_filer(priv, priv->cur_filer_idx, fcr, fpr);
-		priv->cur_filer_idx = priv->cur_filer_idx - 1;
-	}
-}
-
 static int gfar_ethflow_to_filer_table(struct gfar_private *priv, u64 ethflow, u64 class)
 {
-	unsigned int last_rule_idx = priv->cur_filer_idx;
-	unsigned int cmp_rqfpr;
-	unsigned int local_rqfpr[MAX_FILER_IDX + 1];
-	unsigned int local_rqfcr[MAX_FILER_IDX + 1];
-	int i = 0x0, k = 0x0;
-	int j = MAX_FILER_IDX, l = 0x0;
-
-	switch (class) {
-	case TCP_V4_FLOW:
-		cmp_rqfpr = RQFPR_IPV4 |RQFPR_TCP;
-		break;
-	case UDP_V4_FLOW:
-		cmp_rqfpr = RQFPR_IPV4 |RQFPR_UDP;
-		break;
-	case TCP_V6_FLOW:
-		cmp_rqfpr = RQFPR_IPV6 |RQFPR_TCP;
-		break;
-	case UDP_V6_FLOW:
-		cmp_rqfpr = RQFPR_IPV6 |RQFPR_UDP;
-		break;
-	case IPV4_FLOW:
-		cmp_rqfpr = RQFPR_IPV4;
-	case IPV6_FLOW:
-		cmp_rqfpr = RQFPR_IPV6;
-		break;
-	default:
-		printk(KERN_ERR "Right now this class is not supported\n");
-		return 0;
-	}
-
-	for (i = 0; i < MAX_FILER_IDX + 1; i++) {
-		local_rqfpr[j] = ftp_rqfpr[i];
-		local_rqfcr[j] = ftp_rqfcr[i];
-		j--;
-		if ((ftp_rqfcr[i] == (RQFCR_PID_PARSE |
-			RQFCR_CLE |RQFCR_AND)) &&
-			(ftp_rqfpr[i] == cmp_rqfpr))
-			break;
-	}
-
-	if (i == MAX_FILER_IDX + 1) {
-		printk(KERN_ERR "No parse rule found, ");
-		printk(KERN_ERR "can't create hash rules\n");
-		return 0;
-	}
-
-	/* If a match was found, then it begins the starting of a cluster rule
-	 * if it was already programmed, we need to overwrite these rules
-	 */
-	for (l = i+1; l < MAX_FILER_IDX; l++) {
-		if ((ftp_rqfcr[l] & RQFCR_CLE) &&
-			!(ftp_rqfcr[l] & RQFCR_AND)) {
-			ftp_rqfcr[l] = RQFCR_CLE | RQFCR_CMP_EXACT |
-				RQFCR_HASHTBL_0 | RQFCR_PID_MASK;
-			ftp_rqfpr[l] = FPR_FILER_MASK;
-			gfar_write_filer(priv, l, ftp_rqfcr[l], ftp_rqfpr[l]);
-			break;
-		}
-
-		if (!(ftp_rqfcr[l] & RQFCR_CLE) && (ftp_rqfcr[l] & RQFCR_AND))
-			continue;
-		else {
-			local_rqfpr[j] = ftp_rqfpr[l];
-			local_rqfcr[j] = ftp_rqfcr[l];
-			j--;
-		}
-	}
-
-	priv->cur_filer_idx = l - 1;
-	last_rule_idx = l;
-
-	/* hash rules */
-	ethflow_to_filer_rules(priv, ethflow);
-
-	/* Write back the popped out rules again */
-	for (k = j+1; k < MAX_FILER_IDX; k++) {
-		ftp_rqfpr[priv->cur_filer_idx] = local_rqfpr[k];
-		ftp_rqfcr[priv->cur_filer_idx] = local_rqfcr[k];
-		gfar_write_filer(priv, priv->cur_filer_idx,
-				local_rqfcr[k], local_rqfpr[k]);
-		if (!priv->cur_filer_idx)
-			break;
-		priv->cur_filer_idx = priv->cur_filer_idx - 1;
-	}
-
-	return 1;
+	printk(KERN_ERR "Right now this class is not supported\n");
+	return 0;
 }
 
 static int gfar_set_hash_opts(struct gfar_private *priv, struct ethtool_rxnfc *cmd)
-- 
1.7.2.5


