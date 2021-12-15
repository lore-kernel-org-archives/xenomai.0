From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 4/4] drivers/can/rtcan_flexcan: Drop PowerPC bits
Date: Wed, 15 Dec 2021 19:04:25 +0100
Message-ID: <6fb0764201d91ae67ecdd8ee1aeb7149396d33a6.1639591464.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1639591464.git.jan.kiszka@siemens.com>
References: <cover.1639591464.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Remove the flexcan_read/write abstraction, now that PowerPC is gone.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/can/rtcan_flexcan.c | 189 +++++++++++++----------------
 1 file changed, 81 insertions(+), 108 deletions(-)

diff --git a/kernel/drivers/can/rtcan_flexcan.c b/kernel/drivers/can/rtcan_flexcan.c
index 3348e8ce0a..edaaad7031 100644
--- a/kernel/drivers/can/rtcan_flexcan.c
+++ b/kernel/drivers/can/rtcan_flexcan.c
@@ -335,39 +335,12 @@ static const struct can_bittiming_const flexcan_bittiming_const = {
 	.brp_inc = 1,
 };
 
-/* Abstract off the read/write for arm versus ppc. This
- * assumes that PPC uses big-endian registers and everything
- * else uses little-endian registers, independent of CPU
- * endianness.
- */
-#if defined(CONFIG_PPC)
-static inline u32 flexcan_read(void __iomem *addr)
-{
-	return in_be32(addr);
-}
-
-static inline void flexcan_write(u32 val, void __iomem *addr)
-{
-	out_be32(addr, val);
-}
-#else
-static inline u32 flexcan_read(void __iomem *addr)
-{
-	return readl(addr);
-}
-
-static inline void flexcan_write(u32 val, void __iomem *addr)
-{
-	writel(val, addr);
-}
-#endif
-
 static inline void flexcan_error_irq_enable(const struct flexcan_priv *priv)
 {
 	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 reg_ctrl = (priv->reg_ctrl_default | FLEXCAN_CTRL_ERR_MSK);
 
-	flexcan_write(reg_ctrl, &regs->ctrl);
+	writel(reg_ctrl, &regs->ctrl);
 }
 
 static inline void flexcan_error_irq_disable(const struct flexcan_priv *priv)
@@ -375,7 +348,7 @@ static inline void flexcan_error_irq_disable(const struct flexcan_priv *priv)
 	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 reg_ctrl = (priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_MSK);
 
-	flexcan_write(reg_ctrl, &regs->ctrl);
+	writel(reg_ctrl, &regs->ctrl);
 }
 
 static inline int flexcan_transceiver_enable(const struct flexcan_priv *priv)
@@ -400,14 +373,14 @@ static int flexcan_chip_enable(struct flexcan_priv *priv)
 	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
 	u32 reg;
 
-	reg = flexcan_read(&regs->mcr);
+	reg = readl(&regs->mcr);
 	reg &= ~FLEXCAN_MCR_MDIS;
-	flexcan_write(reg, &regs->mcr);
+	writel(reg, &regs->mcr);
 
-	while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
+	while (timeout-- && (readl(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
 		udelay(10);
 
-	if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK)
+	if (readl(&regs->mcr) & FLEXCAN_MCR_LPM_ACK)
 		return -ETIMEDOUT;
 
 	return 0;
@@ -419,14 +392,14 @@ static int flexcan_chip_disable(struct flexcan_priv *priv)
 	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
 	u32 reg;
 
-	reg = flexcan_read(&regs->mcr);
+	reg = readl(&regs->mcr);
 	reg |= FLEXCAN_MCR_MDIS;
-	flexcan_write(reg, &regs->mcr);
+	writel(reg, &regs->mcr);
 
-	while (timeout-- && !(flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
+	while (timeout-- && !(readl(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
 		udelay(10);
 
-	if (!(flexcan_read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
+	if (!(readl(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
 		return -ETIMEDOUT;
 
 	return 0;
@@ -439,14 +412,14 @@ static int flexcan_chip_freeze(struct rtcan_device *dev)
 	unsigned int timeout = 1000 * 1000 * 10 / dev->baudrate;
 	u32 reg;
 
-	reg = flexcan_read(&regs->mcr);
+	reg = readl(&regs->mcr);
 	reg |= FLEXCAN_MCR_HALT;
-	flexcan_write(reg, &regs->mcr);
+	writel(reg, &regs->mcr);
 
-	while (timeout-- && !(flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
+	while (timeout-- && !(readl(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
 		udelay(100);
 
-	if (!(flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
+	if (!(readl(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
 		return -ETIMEDOUT;
 
 	return 0;
@@ -458,14 +431,14 @@ static int flexcan_chip_unfreeze(struct flexcan_priv *priv)
 	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
 	u32 reg;
 
-	reg = flexcan_read(&regs->mcr);
+	reg = readl(&regs->mcr);
 	reg &= ~FLEXCAN_MCR_HALT;
-	flexcan_write(reg, &regs->mcr);
+	writel(reg, &regs->mcr);
 
-	while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
+	while (timeout-- && (readl(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
 		udelay(10);
 
-	if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK)
+	if (readl(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK)
 		return -ETIMEDOUT;
 
 	return 0;
@@ -476,11 +449,11 @@ static int flexcan_chip_softreset(struct flexcan_priv *priv)
 	struct flexcan_regs __iomem *regs = priv->regs;
 	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
 
-	flexcan_write(FLEXCAN_MCR_SOFTRST, &regs->mcr);
-	while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_SOFTRST))
+	writel(FLEXCAN_MCR_SOFTRST, &regs->mcr);
+	while (timeout-- && (readl(&regs->mcr) & FLEXCAN_MCR_SOFTRST))
 		udelay(10);
 
-	if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_SOFTRST)
+	if (readl(&regs->mcr) & FLEXCAN_MCR_SOFTRST)
 		return -ETIMEDOUT;
 
 	return 0;
@@ -507,22 +480,22 @@ static int flexcan_start_xmit(struct rtcan_device *dev, struct can_frame *cf)
 
 	if (cf->can_dlc > 0) {
 		data = be32_to_cpup((__be32 *)&cf->data[0]);
-		flexcan_write(data, &priv->tx_mb->data[0]);
+		writel(data, &priv->tx_mb->data[0]);
 	}
 	if (cf->can_dlc > 4) {
 		data = be32_to_cpup((__be32 *)&cf->data[4]);
-		flexcan_write(data, &priv->tx_mb->data[1]);
+		writel(data, &priv->tx_mb->data[1]);
 	}
 
-	flexcan_write(can_id, &priv->tx_mb->can_id);
-	flexcan_write(ctrl, &priv->tx_mb->can_ctrl);
+	writel(can_id, &priv->tx_mb->can_id);
+	writel(ctrl, &priv->tx_mb->can_ctrl);
 
 	/* Errata ERR005829 step8:
 	 * Write twice INACTIVE(0x8) code to first MB.
 	 */
-	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
+	writel(FLEXCAN_MB_CODE_TX_INACTIVE,
 		      &priv->tx_mb_reserved->can_ctrl);
-	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
+	writel(FLEXCAN_MB_CODE_TX_INACTIVE,
 		      &priv->tx_mb_reserved->can_ctrl);
 
 	return 0;
@@ -659,7 +632,7 @@ static bool flexcan_irq_state(struct rtcan_device *dev, u32 reg_esr,
 	u32 reg;
 	int flt;
 
-	reg = flexcan_read(&regs->ecr);
+	reg = readl(&regs->ecr);
 	bec.txerr = (reg >> 0) & 0xff;
 	bec.rxerr = (reg >> 8) & 0xff;
 
@@ -697,7 +670,7 @@ static unsigned int flexcan_mailbox_read(struct rtcan_device *dev,
 
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
 		do {
-			reg_ctrl = flexcan_read(&mb->can_ctrl);
+			reg_ctrl = readl(&mb->can_ctrl);
 		} while (reg_ctrl & FLEXCAN_MB_CODE_RX_BUSY_BIT);
 
 		/* is this MB empty? */
@@ -706,18 +679,18 @@ static unsigned int flexcan_mailbox_read(struct rtcan_device *dev,
 		    (code != FLEXCAN_MB_CODE_RX_OVERRUN))
 			return 0;
 	} else {
-		reg_iflag1 = flexcan_read(&regs->iflag1);
+		reg_iflag1 = readl(&regs->iflag1);
 		if (!(reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE))
 			return 0;
 
-		reg_ctrl = flexcan_read(&mb->can_ctrl);
+		reg_ctrl = readl(&mb->can_ctrl);
 	}
 
 	/* increase timstamp to full 32 bit */
 	*timestamp = reg_ctrl << 16;
 
 	cf->can_dlc = get_can_dlc((reg_ctrl >> 16) & 0xf);
-	reg_id = flexcan_read(&mb->can_id);
+	reg_id = readl(&mb->can_id);
 	if (reg_ctrl & FLEXCAN_MB_CNT_IDE)
 		cf->can_id = ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
 	else
@@ -730,8 +703,8 @@ static unsigned int flexcan_mailbox_read(struct rtcan_device *dev,
 	else
 		skb->rb_frame_size += cf->can_dlc;
 
-	put_unaligned_be32(flexcan_read(&mb->data[0]), cf->data + 0);
-	put_unaligned_be32(flexcan_read(&mb->data[1]), cf->data + 4);
+	put_unaligned_be32(readl(&mb->data[0]), cf->data + 0);
+	put_unaligned_be32(readl(&mb->data[1]), cf->data + 4);
 
 	cf->can_ifindex = dev->ifindex;
 
@@ -739,12 +712,12 @@ static unsigned int flexcan_mailbox_read(struct rtcan_device *dev,
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
 		/* Clear IRQ */
 		if (n < 32)
-			flexcan_write(BIT(n), &regs->iflag1);
+			writel(BIT(n), &regs->iflag1);
 		else
-			flexcan_write(BIT(n - 32), &regs->iflag2);
+			writel(BIT(n - 32), &regs->iflag2);
 	} else {
-		flexcan_write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
-		flexcan_read(&regs->timer);
+		writel(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
+		readl(&regs->timer);
 	}
 
 	return 1;
@@ -831,8 +804,8 @@ static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv)
 	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 iflag1, iflag2;
 
-	iflag2 = flexcan_read(&regs->iflag2) & priv->reg_imask2_default;
-	iflag1 = flexcan_read(&regs->iflag1) & priv->reg_imask1_default &
+	iflag2 = readl(&regs->iflag2) & priv->reg_imask2_default;
+	iflag1 = readl(&regs->iflag1) & priv->reg_imask1_default &
 		~FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
 
 	return (u64)iflag2 << 32 | iflag1;
@@ -857,7 +830,7 @@ static int flexcan_do_rx(struct rtcan_device *dev, u32 reg_iflag1)
 		}
 	} else {
 		if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
-			flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
+			writel(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
 			init_err_skb(&skb);
 			cf->can_id |= CAN_ERR_CRTL;
 			cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
@@ -884,7 +857,7 @@ static int flexcan_irq(rtdm_irq_t *irq_handle)
 	rtdm_lock_get(&rtcan_recv_list_lock);
 	rtdm_lock_get(&rtcan_socket_lock);
 
-	reg_iflag1 = flexcan_read(&regs->iflag1);
+	reg_iflag1 = readl(&regs->iflag1);
 
 	/* reception interrupt */
 	if (flexcan_do_rx(dev, reg_iflag1))
@@ -893,9 +866,9 @@ static int flexcan_irq(rtdm_irq_t *irq_handle)
 	/* transmission complete interrupt */
 	if (reg_iflag1 & FLEXCAN_IFLAG_MB(priv->tx_mb_idx)) {
 		/* after sending a RTR frame MB is in RX mode */
-		flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
+		writel(FLEXCAN_MB_CODE_TX_INACTIVE,
 			      &priv->tx_mb->can_ctrl);
-		flexcan_write(FLEXCAN_IFLAG_MB(priv->tx_mb_idx), &regs->iflag1);
+		writel(FLEXCAN_IFLAG_MB(priv->tx_mb_idx), &regs->iflag1);
 		rtdm_sem_up(&dev->tx_sem);
 		dev->tx_count++;
 		if (rtcan_loopback_pending(dev))
@@ -903,11 +876,11 @@ static int flexcan_irq(rtdm_irq_t *irq_handle)
 		handled = RTDM_IRQ_HANDLED;
 	}
 
-	reg_esr = flexcan_read(&regs->esr);
+	reg_esr = readl(&regs->esr);
 
 	/* ACK all bus error and state change IRQ sources */
 	if (reg_esr & FLEXCAN_ESR_ALL_INT) {
-		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
+		writel(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
 		handled = RTDM_IRQ_HANDLED;
 	}
 
@@ -946,7 +919,7 @@ static void flexcan_set_bittiming(struct rtcan_device *dev)
 	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 reg;
 
-	reg = flexcan_read(&regs->ctrl);
+	reg = readl(&regs->ctrl);
 	reg &= ~(FLEXCAN_CTRL_PRESDIV(0xff) |
 		 FLEXCAN_CTRL_RJW(0x3) |
 		 FLEXCAN_CTRL_PSEG1(0x7) |
@@ -970,11 +943,11 @@ static void flexcan_set_bittiming(struct rtcan_device *dev)
 		reg |= FLEXCAN_CTRL_SMP;
 
 	rtcandev_dbg(dev, "writing ctrl=0x%08x\n", reg);
-	flexcan_write(reg, &regs->ctrl);
+	writel(reg, &regs->ctrl);
 
 	/* print chip status */
 	rtcandev_dbg(dev, "%s: mcr=0x%08x ctrl=0x%08x\n", __func__,
-		   flexcan_read(&regs->mcr), flexcan_read(&regs->ctrl));
+		   readl(&regs->mcr), readl(&regs->ctrl));
 }
 
 /* flexcan_chip_start
@@ -1021,7 +994,7 @@ static int flexcan_chip_start(struct rtcan_device *dev)
 	 * choose format C
 	 * set max mailbox number
 	 */
-	reg_mcr = flexcan_read(&regs->mcr);
+	reg_mcr = readl(&regs->mcr);
 	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
 	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT | FLEXCAN_MCR_SUPV |
 		FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_IRMQ |
@@ -1035,7 +1008,7 @@ static int flexcan_chip_start(struct rtcan_device *dev)
 			FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
 	}
 	rtcandev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
-	flexcan_write(reg_mcr, &regs->mcr);
+	writel(reg_mcr, &regs->mcr);
 
 	/* CTRL
 	 *
@@ -1048,7 +1021,7 @@ static int flexcan_chip_start(struct rtcan_device *dev)
 	 * enable bus off interrupt
 	 * (== FLEXCAN_CTRL_ERR_STATE)
 	 */
-	reg_ctrl = flexcan_read(&regs->ctrl);
+	reg_ctrl = readl(&regs->ctrl);
 	reg_ctrl &= ~FLEXCAN_CTRL_TSYN;
 	reg_ctrl |= FLEXCAN_CTRL_BOFF_REC | FLEXCAN_CTRL_LBUF |
 		FLEXCAN_CTRL_ERR_STATE;
@@ -1067,45 +1040,45 @@ static int flexcan_chip_start(struct rtcan_device *dev)
 	/* leave interrupts disabled for now */
 	reg_ctrl &= ~FLEXCAN_CTRL_ERR_ALL;
 	rtcandev_dbg(dev, "%s: writing ctrl=0x%08x", __func__, reg_ctrl);
-	flexcan_write(reg_ctrl, &regs->ctrl);
+	writel(reg_ctrl, &regs->ctrl);
 
 	if ((priv->devtype_data->quirks & FLEXCAN_QUIRK_ENABLE_EACEN_RRS)) {
-		reg_ctrl2 = flexcan_read(&regs->ctrl2);
+		reg_ctrl2 = readl(&regs->ctrl2);
 		reg_ctrl2 |= FLEXCAN_CTRL2_EACEN | FLEXCAN_CTRL2_RRS;
-		flexcan_write(reg_ctrl2, &regs->ctrl2);
+		writel(reg_ctrl2, &regs->ctrl2);
 	}
 
 	/* clear and invalidate all mailboxes first */
 	for (i = priv->tx_mb_idx; i < ARRAY_SIZE(regs->mb); i++) {
-		flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE,
+		writel(FLEXCAN_MB_CODE_RX_INACTIVE,
 			      &regs->mb[i].can_ctrl);
 	}
 
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
 		for (i = priv->mb_first; i <= priv->mb_last; i++)
-			flexcan_write(FLEXCAN_MB_CODE_RX_EMPTY,
+			writel(FLEXCAN_MB_CODE_RX_EMPTY,
 				      &regs->mb[i].can_ctrl);
 	}
 
 	/* Errata ERR005829: mark first TX mailbox as INACTIVE */
-	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
+	writel(FLEXCAN_MB_CODE_TX_INACTIVE,
 		      &priv->tx_mb_reserved->can_ctrl);
 
 	/* mark TX mailbox as INACTIVE */
-	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
+	writel(FLEXCAN_MB_CODE_TX_INACTIVE,
 		      &priv->tx_mb->can_ctrl);
 
 	/* acceptance mask/acceptance code (accept everything) */
-	flexcan_write(0x0, &regs->rxgmask);
-	flexcan_write(0x0, &regs->rx14mask);
-	flexcan_write(0x0, &regs->rx15mask);
+	writel(0x0, &regs->rxgmask);
+	writel(0x0, &regs->rx14mask);
+	writel(0x0, &regs->rx15mask);
 
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_DISABLE_RXFG)
-		flexcan_write(0x0, &regs->rxfgmask);
+		writel(0x0, &regs->rxfgmask);
 
 	/* clear acceptance filters */
 	for (i = 0; i < ARRAY_SIZE(regs->mb); i++)
-		flexcan_write(0, &regs->rximr[i]);
+		writel(0, &regs->rximr[i]);
 
 	/* On Vybrid, disable memory error detection interrupts
 	 * and freeze mode.
@@ -1118,16 +1091,16 @@ static int flexcan_chip_start(struct rtcan_device *dev)
 		 * and Correction of Memory Errors" to write to
 		 * MECR register
 		 */
-		reg_ctrl2 = flexcan_read(&regs->ctrl2);
+		reg_ctrl2 = readl(&regs->ctrl2);
 		reg_ctrl2 |= FLEXCAN_CTRL2_ECRWRE;
-		flexcan_write(reg_ctrl2, &regs->ctrl2);
+		writel(reg_ctrl2, &regs->ctrl2);
 
-		reg_mecr = flexcan_read(&regs->mecr);
+		reg_mecr = readl(&regs->mecr);
 		reg_mecr &= ~FLEXCAN_MECR_ECRWRDIS;
-		flexcan_write(reg_mecr, &regs->mecr);
+		writel(reg_mecr, &regs->mecr);
 		reg_mecr &= ~(FLEXCAN_MECR_NCEFAFRZ | FLEXCAN_MECR_HANCEI_MSK |
 			      FLEXCAN_MECR_FANCEI_MSK);
-		flexcan_write(reg_mecr, &regs->mecr);
+		writel(reg_mecr, &regs->mecr);
 	}
 
 	err = flexcan_transceiver_enable(priv);
@@ -1143,14 +1116,14 @@ static int flexcan_chip_start(struct rtcan_device *dev)
 
 	/* enable interrupts atomically */
 	rtdm_irq_disable(&dev->irq_handle);
-	flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
-	flexcan_write(priv->reg_imask1_default, &regs->imask1);
-	flexcan_write(priv->reg_imask2_default, &regs->imask2);
+	writel(priv->reg_ctrl_default, &regs->ctrl);
+	writel(priv->reg_imask1_default, &regs->imask1);
+	writel(priv->reg_imask2_default, &regs->imask2);
 	rtdm_irq_enable(&dev->irq_handle);
 
 	/* print chip status */
 	rtcandev_dbg(dev, "%s: reading mcr=0x%08x ctrl=0x%08x\n", __func__,
-		   flexcan_read(&regs->mcr), flexcan_read(&regs->ctrl));
+		   readl(&regs->mcr), readl(&regs->ctrl));
 
 	return 0;
 
@@ -1180,9 +1153,9 @@ static void flexcan_chip_stop(struct rtcan_device *dev)
 	flexcan_chip_disable(priv);
 
 	/* Disable all interrupts */
-	flexcan_write(0, &regs->imask2);
-	flexcan_write(0, &regs->imask1);
-	flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
+	writel(0, &regs->imask2);
+	writel(0, &regs->imask1);
+	writel(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
 		      &regs->ctrl);
 
 	flexcan_transceiver_disable(priv);
@@ -1312,26 +1285,26 @@ static int register_flexcandev(struct rtcan_device *dev)
 	err = flexcan_chip_disable(priv);
 	if (err)
 		goto out_disable_per;
-	reg = flexcan_read(&regs->ctrl);
+	reg = readl(&regs->ctrl);
 	reg |= FLEXCAN_CTRL_CLK_SRC;
-	flexcan_write(reg, &regs->ctrl);
+	writel(reg, &regs->ctrl);
 
 	err = flexcan_chip_enable(priv);
 	if (err)
 		goto out_chip_disable;
 
 	/* set freeze, halt and activate FIFO, restrict register access */
-	reg = flexcan_read(&regs->mcr);
+	reg = readl(&regs->mcr);
 	reg |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT |
 		FLEXCAN_MCR_FEN | FLEXCAN_MCR_SUPV;
-	flexcan_write(reg, &regs->mcr);
+	writel(reg, &regs->mcr);
 
 	/* Currently we only support newer versions of this core
 	 * featuring a RX hardware FIFO (although this driver doesn't
 	 * make use of it on some cores). Older cores, found on some
 	 * Coldfire derivates are not tested.
 	 */
-	reg = flexcan_read(&regs->mcr);
+	reg = readl(&regs->mcr);
 	if (!(reg & FLEXCAN_MCR_FEN)) {
 		rtcandev_err(dev, "Could not enable RX FIFO, unsupported core\n");
 		err = -ENODEV;
-- 
2.31.1


