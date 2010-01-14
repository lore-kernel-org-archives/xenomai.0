From: Wolfgang Grandegger <wg@domain.hid>
Date: Thu, 14 Jan 2010 13:07:44 +0100
Message-Id: <1263470867-1533-3-git-send-email-wg@domain.hid>
In-Reply-To: <1263470867-1533-2-git-send-email-wg@domain.hid>
References: <1263470867-1533-1-git-send-email-wg@domain.hid>
	<1263470867-1533-2-git-send-email-wg@domain.hid>
Subject: [Xenomai-core] [PATCH xenomai-2.5 2/3] rtcan: mscan: use proper io
	accessor functions for register access
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid
Cc: Wolfgang Grandegger <wg@domain.hid>

From: Wolfgang Grandegger <wg@domain.hid>

Signed-off-by: Wolfgang Grandegger <wg@domain.hid>
---
 ksrc/drivers/can/mscan/rtcan_mscan.c      |  180 +++++++++++++++-------------
 ksrc/drivers/can/mscan/rtcan_mscan_proc.c |   48 +++++----
 2 files changed, 123 insertions(+), 105 deletions(-)

diff --git a/ksrc/drivers/can/mscan/rtcan_mscan.c b/ksrc/drivers/can/mscan/rtcan_mscan.c
index b5b6489..4975320 100644
--- a/ksrc/drivers/can/mscan/rtcan_mscan.c
+++ b/ksrc/drivers/can/mscan/rtcan_mscan.c
@@ -111,39 +111,41 @@ static inline void rtcan_mscan_rx_interrupt(struct rtcan_device *dev,
 
 	skb->rb_frame_size = EMPTY_RB_FRAME_SIZE;
 
-	frame->can_dlc = regs->canrxfg.dlr & 0x0F;
+	frame->can_dlc = in_8(&regs->canrxfg.dlr) & 0x0F;
 
 	/* If DLC exceeds 8 bytes adjust it to 8 (for the payload size) */
 	size = (frame->can_dlc > 8) ? 8 : frame->can_dlc;
 
-	if (regs->canrxfg.idr[1] & MSCAN_BUF_EXTENDED) {
-		frame->can_id = ((regs->canrxfg.idr[0] << 21) |
-				 ((regs->canrxfg.idr[1] & 0xE0) << 13) |
-				 ((regs->canrxfg.idr[1] & 0x07) << 15) |
-				 (regs->canrxfg.idr[4] << 7) |
-				 (regs->canrxfg.idr[5] >> 1));
+	if (in_8(&regs->canrxfg.idr[1]) & MSCAN_BUF_EXTENDED) {
+		frame->can_id = ((in_8(&regs->canrxfg.idr[0]) << 21) |
+				 ((in_8(&regs->canrxfg.idr[1]) & 0xE0) << 13) |
+				 ((in_8(&regs->canrxfg.idr[1]) & 0x07) << 15) |
+				 (in_8(&regs->canrxfg.idr[4]) << 7) |
+				 (in_8(&regs->canrxfg.idr[5]) >> 1));
 
 		frame->can_id |= CAN_EFF_FLAG;
 
-		if ((regs->canrxfg.idr[5] & MSCAN_BUF_EXT_RTR)) {
+		if ((in_8(&regs->canrxfg.idr[5]) & MSCAN_BUF_EXT_RTR)) {
 			frame->can_id |= CAN_RTR_FLAG;
 		} else {
 			for (i = 0; i < size; i++)
 				frame->data[i] =
-					regs->canrxfg.dsr[i + (i / 2) * 2];
+					in_8(&regs->canrxfg.dsr[i +
+								(i / 2) * 2]);
 			skb->rb_frame_size += size;
 		}
 
 	} else {
-		frame->can_id = ((regs->canrxfg.idr[0] << 3) |
-				 (regs->canrxfg.idr[1] >> 5));
+		frame->can_id = ((in_8(&regs->canrxfg.idr[0]) << 3) |
+				 (in_8(&regs->canrxfg.idr[1]) >> 5));
 
-		if ((regs->canrxfg.idr[1] & MSCAN_BUF_STD_RTR)) {
+		if ((in_8(&regs->canrxfg.idr[1]) & MSCAN_BUF_STD_RTR)) {
 			frame->can_id |= CAN_RTR_FLAG;
 		} else {
 			for (i = 0; i < size; i++)
 				frame->data[i] =
-					regs->canrxfg.dsr[i + (i / 2) * 2];
+					in_8(&regs->canrxfg.dsr[i +
+								(i / 2) * 2]);
 			skb->rb_frame_size += size;
 		}
 	}
@@ -193,7 +195,7 @@ static inline void rtcan_mscan_err_interrupt(struct rtcan_device *dev,
 			frame->can_id |= CAN_ERR_BUSOFF;
 			dev->state = CAN_STATE_BUS_OFF;
 			/* Disable receiver interrupts */
-			regs->canrier = 0;
+			out_8(&regs->canrier, 0);
 			/* Wake up waiting senders */
 			rtdm_sem_destroy(&dev->tx_sem);
 			break;
@@ -239,13 +241,14 @@ static int rtcan_mscan_interrupt(rtdm_irq_t *irq_handle)
 
 	rtdm_lock_get(&dev->device_lock);
 
-	canrflg = regs->canrflg;
+	canrflg = in_8(&regs->canrflg);
 
 	ret = RTDM_IRQ_HANDLED;
 
 	/* Transmit Interrupt? */
-	if ((regs->cantier & MSCAN_TXIE0) && (regs->cantflg & MSCAN_TXE0)) {
-		regs->cantier = 0;
+	if ((in_8(&regs->cantier) & MSCAN_TXIE0) &&
+	    (in_8(&regs->cantflg) & MSCAN_TXE0)) {
+		out_8(&regs->cantier, 0);
 		/* Wake up a sender */
 		rtdm_sem_up(&dev->tx_sem);
 
@@ -306,7 +309,7 @@ static int rtcan_mscan_interrupt(rtdm_irq_t *irq_handle)
 	 * Only do so for the receiver interrupts.
 	 */
 	if (canrflg)
-		regs->canrflg = canrflg;
+		out_8(&regs->canrflg, canrflg);
 
 	if (!recv_lock_free) {
 		rtdm_lock_put(&rtcan_socket_lock);
@@ -343,8 +346,7 @@ static int rtcan_mscan_mode_stop(struct rtcan_device *dev,
 	int ret = 0;
 	int rinit = 0;
 	can_state_t state;
-	volatile struct mscan_regs *regs =
-		(struct mscan_regs *)dev->base_addr;
+	struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
 	u8 reg;
 
 	state = dev->state;
@@ -353,10 +355,10 @@ static int rtcan_mscan_mode_stop(struct rtcan_device *dev,
 		goto out;
 
 	/* Switch to sleep mode */
-	regs->canctl0 |= MSCAN_SLPRQ;
-	regs->canctl0 |= MSCAN_INITRQ;
+	setbits8(&regs->canctl0, MSCAN_SLPRQ);
+	setbits8(&regs->canctl0, MSCAN_INITRQ);
 
-	reg = regs->canctl1;
+	reg = in_8(&regs->canctl1);
 	while (!(reg & MSCAN_SLPAK) ||
 	       !(reg & MSCAN_INITAK)) {
 		if (likely(lock_ctx != NULL))
@@ -366,7 +368,7 @@ static int rtcan_mscan_mode_stop(struct rtcan_device *dev,
 		if (likely(lock_ctx != NULL))
 			rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
 		rinit++;
-		reg = regs->canctl1;
+		reg = in_8(&regs->canctl1);
 	}
 
 	/* Volatile state could have changed while we slept busy. */
@@ -400,8 +402,7 @@ static int rtcan_mscan_mode_start(struct rtcan_device *dev,
 {
 	int ret = 0, retries = 0;
 	can_state_t state;
-	volatile struct mscan_regs *regs =
-		(struct mscan_regs *)dev->base_addr;
+	struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
 
 	/* We won't forget that state in the device structure is volatile and
 	 * access to it will not be optimized by the compiler. So ... */
@@ -421,21 +422,21 @@ static int rtcan_mscan_mode_start(struct rtcan_device *dev,
 		rtdm_sem_init(&dev->tx_sem, 1);
 
 		if ((dev->ctrl_mode & CAN_CTRLMODE_LISTENONLY)) {
-			regs->canctl1 |= MSCAN_LISTEN;
+			setbits8(&regs->canctl1, MSCAN_LISTEN);
 		} else {
-			regs->canctl1 &= ~MSCAN_LISTEN;
+			clrbits8(&regs->canctl1, MSCAN_LISTEN);
 		}
 		if ((dev->ctrl_mode & CAN_CTRLMODE_LOOPBACK)) {
-			regs->canctl1 |= MSCAN_LOOPB;
+			setbits8(&regs->canctl1, MSCAN_LOOPB);
 		} else {
-			regs->canctl1 &= ~MSCAN_LOOPB;
+			clrbits8(&regs->canctl1, MSCAN_LOOPB);
 		}
 
 		/* Switch to normal mode */
-		regs->canctl0 &= ~MSCAN_INITRQ;
-		regs->canctl0 &= ~MSCAN_SLPRQ;
-		while ((regs->canctl1 & MSCAN_INITAK) ||
-		       (regs->canctl1 & MSCAN_SLPAK)) {
+		clrbits8(&regs->canctl0, MSCAN_INITRQ);
+		clrbits8(&regs->canctl0, MSCAN_SLPRQ);
+		while ((in_8(&regs->canctl1) & MSCAN_INITAK) ||
+		       (in_8(&regs->canctl1) & MSCAN_SLPAK)) {
 			if (likely(lock_ctx != NULL))
 				rtdm_lock_put_irqrestore(&dev->device_lock,
 							 *lock_ctx);
@@ -447,13 +448,13 @@ static int rtcan_mscan_mode_start(struct rtcan_device *dev,
 			retries++;
 		}
 		/* Enable interrupts */
-		regs->canrier |= MSCAN_RIER;
+		setbits8(&regs->canrier, MSCAN_RIER);
 
 		break;
 
 	case CAN_STATE_BUS_OFF:
 		/* Trigger bus-off recovery */
-		regs->canrier = MSCAN_RIER;
+		out_8(&regs->canrier, MSCAN_RIER);
 		/* Set up sender "mutex" */
 		rtdm_sem_init(&dev->tx_sem, 1);
 		/* Set error active state */
@@ -497,8 +498,8 @@ int rtcan_mscan_set_bit_time(struct rtcan_device *dev,
 		return -EINVAL;
 	}
 
-	regs->canbtr0 = btr0;
-	regs->canbtr1 = btr1;
+	out_8(&regs->canbtr0, btr0);
+	out_8(&regs->canbtr1, btr1);
 
 	rtdm_printk("%s: btr0=0x%02x btr1=0x%02x\n", dev->name, btr0, btr1);
 
@@ -544,10 +545,11 @@ int rtcan_mscan_set_mode(struct rtcan_device *dev,
 
 		/* Let's take a nap. (Now I REALLY understand
 		 * the meaning of interrupts ...) */
-		regs->canrier = 0;
-		regs->cantier = 0;
-		regs->canctl0 |= MSCAN_SLPRQ /*| MSCAN_INITRQ*/ | MSCAN_WUPE;
-		while (!(regs->canctl1 & MSCAN_SLPAK)) {
+		out_8(&regs->canrier, 0);
+		out_8(&regs->cantier, 0);
+		setbits8(&regs->canctl0,
+			 MSCAN_SLPRQ /*| MSCAN_INITRQ*/ | MSCAN_WUPE);
+		while (!(in_8(&regs->canctl1) & MSCAN_SLPAK)) {
 			rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
 			/* Busy sleep 1 microsecond */
 			rtdm_task_busy_sleep(1000);
@@ -556,8 +558,8 @@ int rtcan_mscan_set_mode(struct rtcan_device *dev,
 				break;
 		}
 		rtdm_printk("Fallen asleep after %d tries.\n", retries);
-		regs->canctl0 &= ~MSCAN_INITRQ;
-		while ((regs->canctl1 & MSCAN_INITAK)) {
+		clrbits8(&regs->canctl0, MSCAN_INITRQ);
+		while ((in_8(&regs->canctl1) & MSCAN_INITAK)) {
 			rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
 			/* Busy sleep 1 microsecond */
 			rtdm_task_busy_sleep(1000);
@@ -566,7 +568,7 @@ int rtcan_mscan_set_mode(struct rtcan_device *dev,
 				break;
 		}
 		rtdm_printk("Back to normal after %d tries.\n", retries);
-		regs->canrier = MSCAN_WUPIE;
+		out_8(&regs->canrier, MSCAN_WUPIE);
 
 	mode_sleep_out:
 		dev->state = state;
@@ -596,16 +598,15 @@ static int rtcan_mscan_start_xmit(struct rtcan_device *dev, can_frame_t *frame)
 	unsigned char   size;
 	/* Content of frame information register */
 	unsigned char   dlc;
-
 	struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
 
 	/* Is TX buffer empty? */
-	if (!(regs->cantflg & MSCAN_TXE0)) {
+	if (!(in_8(&regs->cantflg) & MSCAN_TXE0)) {
 		rtdm_printk("rtcan_mscan_start_xmit: TX buffer not empty");
 		return -EIO;
 	}
 	/* Select the buffer we've found. */
-	regs->cantbsel = MSCAN_TXE0;
+	out_8(&regs->cantbsel, MSCAN_TXE0);
 
 	/* Get DLC and ID */
 	dlc = frame->can_dlc;
@@ -615,51 +616,51 @@ static int rtcan_mscan_start_xmit(struct rtcan_device *dev, can_frame_t *frame)
 
 	id = frame->can_id;
 	if (frame->can_id & CAN_EFF_FLAG) {
-		regs->cantxfg.idr[0]  = (id & 0x1fe00000) >> 21;
-		regs->cantxfg.idr[1]  = (id & 0x001c0000) >> 13;
-		regs->cantxfg.idr[1] |= (id & 0x00038000) >> 15;
-		regs->cantxfg.idr[1] |= 0x18; /* set SRR and IDE bits */
+		out_8(&regs->cantxfg.idr[0], (id & 0x1fe00000) >> 21);
+		out_8(&regs->cantxfg.idr[1], ((id & 0x001c0000) >> 13) |
+		      ((id & 0x00038000) >> 15) |
+		      0x18); /* set SRR and IDE bits */
 
-		regs->cantxfg.idr[4]  = (id & 0x00007f80) >> 7 ;
-		regs->cantxfg.idr[5]  = (id & 0x0000007f) << 1 ;
+		out_8(&regs->cantxfg.idr[4], (id & 0x00007f80) >> 7);
+		out_8(&regs->cantxfg.idr[5], (id & 0x0000007f) << 1);
 
 		/* RTR? */
 		if (frame->can_id & CAN_RTR_FLAG)
-			regs->cantxfg.idr[5] |= 0x1;
+			setbits8(&regs->cantxfg.idr[5], 0x1);
 		else {
-			regs->cantxfg.idr[5] &= ~0x1;
+			clrbits8(&regs->cantxfg.idr[5], 0x1);
 			/* No RTR, write data bytes */
 			for (i = 0; i < size; i++)
-				regs->cantxfg.dsr[i + (i / 2) * 2] =
-					frame->data[i];
+				out_8(&regs->cantxfg.dsr[i + (i / 2) * 2],
+				      frame->data[i]);
 		}
 
 	} else {
 		/* Send standard frame */
 
-		regs->cantxfg.idr[0] = (id & 0x000007f8) >> 3;
-		regs->cantxfg.idr[1] = (id & 0x00000007) << 5;
+		out_8(&regs->cantxfg.idr[0], (id & 0x000007f8) >> 3);
+		out_8(&regs->cantxfg.idr[1], (id & 0x00000007) << 5);
 
 		/* RTR? */
 		if (frame->can_id & CAN_RTR_FLAG)
-			regs->cantxfg.idr[1] |= 0x10;
+			setbits8(&regs->cantxfg.idr[1], 0x10);
 		else {
-			regs->cantxfg.idr[1] &= ~0x10;
+			clrbits8(&regs->cantxfg.idr[1], 0x10);
 			/* No RTR, write data bytes */
 			for (i = 0; i < size; i++)
-				regs->cantxfg.dsr[i + (i / 2) * 2] =
-					frame->data[i];
+				out_8(&regs->cantxfg.dsr[i + (i / 2) * 2],
+				      frame->data[i]);
 		}
 	}
 
-	regs->cantxfg.dlr = frame->can_dlc;
-	regs->cantxfg.tbpr = 0;	/* all messages have the same prio */
+	out_8(&regs->cantxfg.dlr, frame->can_dlc);
+	out_8(&regs->cantxfg.tbpr, 0);	/* all messages have the same prio */
 
 	/* Trigger transmission. */
-	regs->cantflg = MSCAN_TXE0;
+	out_8(&regs->cantflg, MSCAN_TXE0);
 
 	/* Enable interrupt. */
-	regs->cantier |= MSCAN_TXIE0;
+	setbits8(&regs->cantier, MSCAN_TXIE0);
 
 	return 0;
 }
@@ -678,26 +679,35 @@ static inline void __init mscan_chip_config(struct mscan_regs *regs)
 {
 	/* Choose IP bus as clock source.
 	 */
-	regs->canctl1 |= MSCAN_CLKSRC;
-	regs->canctl1 &= ~MSCAN_LISTEN;
+	setbits8(&regs->canctl1, MSCAN_CLKSRC);
+	clrbits8(&regs->canctl1, MSCAN_LISTEN);
 
 	/* Configure MSCAN to accept all incoming messages.
 	 */
-	regs->canidar0 = regs->canidar1 = 0x00;
-	regs->canidar2 = regs->canidar3 = 0x00;
-	regs->canidmr0 = regs->canidmr1 = 0xFF;
-	regs->canidmr2 = regs->canidmr3 = 0xFF;
-	regs->canidar4 = regs->canidar5 = 0x00;
-	regs->canidar6 = regs->canidar7 = 0x00;
-	regs->canidmr4 = regs->canidmr5 = 0xFF;
-	regs->canidmr6 = regs->canidmr7 = 0xFF;
-	regs->canidac &= ~(MSCAN_IDAM0 | MSCAN_IDAM1);
+	out_8(&regs->canidar0, 0x00);
+	out_8(&regs->canidar1, 0x00);
+	out_8(&regs->canidar2, 0x00);
+	out_8(&regs->canidar3, 0x00);
+	out_8(&regs->canidmr0, 0xFF);
+	out_8(&regs->canidmr1, 0xFF);
+	out_8(&regs->canidmr2, 0xFF);
+	out_8(&regs->canidmr3, 0xFF);
+	out_8(&regs->canidar4, 0x00);
+	out_8(&regs->canidar5, 0x00);
+	out_8(&regs->canidar6, 0x00);
+	out_8(&regs->canidar7, 0x00);
+	out_8(&regs->canidmr4, 0xFF);
+	out_8(&regs->canidmr5, 0xFF);
+	out_8(&regs->canidmr6, 0xFF);
+	out_8(&regs->canidmr7, 0xFF);
+	clrbits8(&regs->canidac, MSCAN_IDAM0 | MSCAN_IDAM1);
 }
 
 static inline void __init mscan_gpio_config(void)
 {
 	struct mpc5xxx_gpio *gpio = (struct mpc5xxx_gpio *)MPC5xxx_GPIO;
 	int can_to_psc2 = -1;
+	u32 port_config;
 
 #if defined(CONFIG_XENO_DRIVERS_CAN_MSCAN_ALT)
 	can_to_psc2 = 0;
@@ -725,15 +735,17 @@ static inline void __init mscan_gpio_config(void)
 		return;
 	}
 
+	port_config = in_be32(&gpio->port_config);
 	if (can_to_psc2) {
-		gpio->port_config &= ~0x10000070;
-		gpio->port_config |= 0x00000010;
+		port_config &= ~0x10000070;
+		port_config |= 0x00000010;
 		printk("%s: CAN 1 and 2 routed to PSC2 pins\n", RTCAN_DRV_NAME);
 	} else {
-		gpio->port_config |= 0x10000000;
+		port_config |= 0x10000000;
 		printk("%s: CAN 1 routed to I2C1 pins and CAN2 to TMR01 pins\n",
 		       RTCAN_DRV_NAME);
 	}
+	out_be32(&gpio->port_config, port_config);
 }
 
 static inline int mscan_get_config(unsigned long *addr, unsigned int *irq)
@@ -795,7 +807,7 @@ int __init rtcan_mscan_init_one(int idx, unsigned long addr, int irq)
 	regs = (struct mscan_regs *)dev->base_addr;
 
 	/* Enable MSCAN module. */
-	regs->canctl1 |= MSCAN_CANE;
+	setbits8(&regs->canctl1, MSCAN_CANE);
 	udelay(100);
 
 	/* Set dummy state for following call */
@@ -847,7 +859,7 @@ out_irq_free:
 
 out_iounmap:
 	/* Disable MSCAN module. */
-	regs->canctl1 &= ~MSCAN_CANE;
+	clrbits8(&regs->canctl1, MSCAN_CANE);
 	iounmap((void *)dev->base_addr);
 
 out_dev_free:
diff --git a/ksrc/drivers/can/mscan/rtcan_mscan_proc.c b/ksrc/drivers/can/mscan/rtcan_mscan_proc.c
index 5671cad..cfddfb7 100644
--- a/ksrc/drivers/can/mscan/rtcan_mscan_proc.c
+++ b/ksrc/drivers/can/mscan/rtcan_mscan_proc.c
@@ -28,7 +28,8 @@
 #include "rtcan_internal.h"
 #include "rtcan_mscan_regs.h"
 
-#define MSCAN_REG_ARGS(reg) "%-8s 0x%02x\n", #reg, (int)((regs)->reg) & 0xff
+#define MSCAN_REG_ARGS(reg) \
+	"%-8s 0x%02x\n", #reg, (int)(in_8(&regs->reg)) & 0xff
 
 #ifdef CONFIG_XENO_DRIVERS_CAN_DEBUG
 
@@ -38,30 +39,34 @@ static int rtcan_mscan_proc_regs(char *buf, char **start, off_t offset,
 	struct rtcan_device *dev = (struct rtcan_device *)data;
 	struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
 	struct mpc5xxx_gpio *gpio = (struct mpc5xxx_gpio *)MPC5xxx_GPIO;
+	u8 canctl0, canctl1;
+	u32 port_config;
 	RTCAN_PROC_PRINT_VARS(80);
 
 	if (!RTCAN_PROC_PRINT("MSCAN registers at %p\n", regs))
 		goto done;
+	canctl0 = in_8(&regs->canctl0);
 	if (!RTCAN_PROC_PRINT("canctl0  0x%02x%s%s%s%s%s%s%s%s\n",
-			      regs->canctl0,
-			      (regs->canctl0 & MSCAN_RXFRM) ? " rxfrm" :"",
-			      (regs->canctl0 & MSCAN_RXACT) ? " rxact" :"",
-			      (regs->canctl0 & MSCAN_CSWAI) ? " cswai" :"",
-			      (regs->canctl0 & MSCAN_SYNCH) ? " synch" :"",
-			      (regs->canctl0 & MSCAN_TIME)  ? " time"  :"",
-			      (regs->canctl0 & MSCAN_WUPE)  ? " wupe"  :"",
-			      (regs->canctl0 & MSCAN_SLPRQ) ? " slprq" :"",
-			      (regs->canctl0 & MSCAN_INITRQ)? " initrq":"" ))
+			      canctl0,
+			      (canctl0 & MSCAN_RXFRM) ? " rxfrm" :"",
+			      (canctl0 & MSCAN_RXACT) ? " rxact" :"",
+			      (canctl0 & MSCAN_CSWAI) ? " cswai" :"",
+			      (canctl0 & MSCAN_SYNCH) ? " synch" :"",
+			      (canctl0 & MSCAN_TIME)  ? " time"  :"",
+			      (canctl0 & MSCAN_WUPE)  ? " wupe"  :"",
+			      (canctl0 & MSCAN_SLPRQ) ? " slprq" :"",
+			      (canctl0 & MSCAN_INITRQ)? " initrq":"" ))
 		goto done;
+	canctl1 = in_8(&regs->canctl1);
 	if (!RTCAN_PROC_PRINT("canctl1  0x%02x%s%s%s%s%s%s%s\n",
-			      regs->canctl1,
-			      (regs->canctl1 & MSCAN_CANE)  ? " cane"  :"",
-			      (regs->canctl1 & MSCAN_CLKSRC)? " clksrc":"",
-			      (regs->canctl1 & MSCAN_LOOPB) ? " loopb" :"",
-			      (regs->canctl1 & MSCAN_LISTEN)? " listen":"",
-			      (regs->canctl1 & MSCAN_WUPM)  ? " wump"  :"",
-			      (regs->canctl1 & MSCAN_SLPAK) ? " slpak" :"",
-			      (regs->canctl1 & MSCAN_INITAK)? " initak":""))
+			       canctl1,
+			      (canctl1 & MSCAN_CANE)  ? " cane"  :"",
+			      (canctl1 & MSCAN_CLKSRC)? " clksrc":"",
+			      (canctl1 & MSCAN_LOOPB) ? " loopb" :"",
+			      (canctl1 & MSCAN_LISTEN)? " listen":"",
+			      (canctl1 & MSCAN_WUPM)  ? " wump"  :"",
+			      (canctl1 & MSCAN_SLPAK) ? " slpak" :"",
+			      (canctl1 & MSCAN_INITAK)? " initak":""))
 		goto done;
 	if (!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canbtr0 )) |
 	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canbtr1 )) |
@@ -95,10 +100,11 @@ static int rtcan_mscan_proc_regs(char *buf, char **start, off_t offset,
 
 	if (!RTCAN_PROC_PRINT("GPIO registers\n"))
 		goto done;
-	if (!RTCAN_PROC_PRINT("port_config 0x%08x %s\n", gpio->port_config,
-			      (gpio->port_config & 0x10000000 ?
+	port_config = in_be32(&gpio->port_config);
+	if (!RTCAN_PROC_PRINT("port_config 0x%08x %s\n", port_config,
+			      (port_config & 0x10000000 ?
 			       "CAN1 on I2C1, CAN2 on TMR0/1 pins":
-			       (gpio->port_config & 0x70) == 0x10 ?
+			       (port_config & 0x70) == 0x10 ?
 			       "CAN1/2 on PSC2 pins": "MSCAN1/2 not routed")))
 		goto done;
 
-- 
1.6.2.5


