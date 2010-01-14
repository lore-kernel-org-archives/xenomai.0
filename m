From: Wolfgang Grandegger <wg@domain.hid>
Date: Thu, 14 Jan 2010 13:07:43 +0100
Message-Id: <1263470867-1533-2-git-send-email-wg@domain.hid>
In-Reply-To: <1263470867-1533-1-git-send-email-wg@domain.hid>
References: <1263470867-1533-1-git-send-email-wg@domain.hid>
Subject: [Xenomai-core] [PATCH xenomai-2.5 1/3] rtcan: mscan: use tabs for
	indention and white space cleanup
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

This patch introduces tabs for indention, deletes training white space
and corrects some other white space issues.

Signed-off-by: Wolfgang Grandegger <wg@domain.hid>
---
 ksrc/drivers/can/mscan/Makefile           |    4 +-
 ksrc/drivers/can/mscan/rtcan_mscan.c      | 1226 ++++++++++++++---------------
 ksrc/drivers/can/mscan/rtcan_mscan_proc.c |  172 ++--
 ksrc/drivers/can/mscan/rtcan_mscan_regs.h |   66 +-
 4 files changed, 732 insertions(+), 736 deletions(-)

diff --git a/ksrc/drivers/can/mscan/Makefile b/ksrc/drivers/can/mscan/Makefile
index 20e29e4..8976ffe 100644
--- a/ksrc/drivers/can/mscan/Makefile
+++ b/ksrc/drivers/can/mscan/Makefile
@@ -14,9 +14,9 @@ else
 
 O_TARGET := built-in.o
 
-obj-$(CONFIG_XENO_DRIVERS_CAN_MSCAN) := xeno_can_mscan.o 
+obj-$(CONFIG_XENO_DRIVERS_CAN_MSCAN) := xeno_can_mscan.o
 
-list-multi := xeno_can_mscan.o 
+list-multi := xeno_can_mscan.o
 
 xeno_can_mscan-objs := rtcan_mscan.o rtcan_mscan_proc.o
 
diff --git a/ksrc/drivers/can/mscan/rtcan_mscan.c b/ksrc/drivers/can/mscan/rtcan_mscan.c
index 9618057..b5b6489 100644
--- a/ksrc/drivers/can/mscan/rtcan_mscan.c
+++ b/ksrc/drivers/can/mscan/rtcan_mscan.c
@@ -74,9 +74,9 @@ int port[RTCAN_MSCAN_DEVS] = {
 compat_module_param_array(port, int, RTCAN_MSCAN_DEVS, 0444);
 MODULE_PARM_DESC(port, "Enabled CAN ports (1,1 or 0,1 or 0,1)");
 
-/* 
- * Note: on the MPC5200 the MSCAN clock source is the IP bus 
- * clock (IP_CLK) while on the MPC5200B it is the oscillator 
+/*
+ * Note: on the MPC5200 the MSCAN clock source is the IP bus
+ * clock (IP_CLK) while on the MPC5200B it is the oscillator
  * clock (SYS_XTAL_IN).
  */
 unsigned int mscan_clock = CONFIG_XENO_DRIVERS_CAN_MSCAN_CLOCK;
@@ -86,11 +86,10 @@ MODULE_PARM_DESC(mscan_clock, "Clock frequency in Hz");
 char *mscan_pins = NULL;
 module_param(mscan_pins, charp, 0444);
 MODULE_PARM_DESC(mscan_pins, "Routing to GPIO pins (PSC2 or I2C1/TMR01)");
- 
+
 static struct rtcan_device *rtcan_mscan_devs[RTCAN_MSCAN_DEVS];
 static int rtcan_mscan_count;
 
-
 /**
  *  Reception Interrupt handler
  *
@@ -103,224 +102,220 @@ static int rtcan_mscan_count;
  *  @param[in]  dev  Device ID
  */
 static inline void rtcan_mscan_rx_interrupt(struct rtcan_device *dev,
-					    struct rtcan_skb *skb
-    )
+					    struct rtcan_skb *skb)
 {
-    int i;
-    unsigned char size;
-    struct rtcan_rb_frame *frame = &skb->rb_frame;
-    struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
-
-    skb->rb_frame_size = EMPTY_RB_FRAME_SIZE;
-
-    frame->can_dlc = regs->canrxfg.dlr & 0x0F;
-
-    /* If DLC exceeds 8 bytes adjust it to 8 (for the payload size) */
-    size = (frame->can_dlc > 8) ? 8 : frame->can_dlc;
-
-    if (regs->canrxfg.idr[1] & MSCAN_BUF_EXTENDED) {
-	frame->can_id = ((regs->canrxfg.idr[0] << 21) |
-			 ((regs->canrxfg.idr[1] & 0xE0) << 13) |
-			 ((regs->canrxfg.idr[1] & 0x07) << 15) |
-			 (regs->canrxfg.idr[4] << 7) |
-			 (regs->canrxfg.idr[5] >> 1));
-			 
-	frame->can_id |= CAN_EFF_FLAG;
-	
-	if ((regs->canrxfg.idr[5] & MSCAN_BUF_EXT_RTR)) {
-	    frame->can_id |= CAN_RTR_FLAG;
-        } else {
-             for (i = 0; i < size; i++)
-                frame->data[i] = regs->canrxfg.dsr[i + (i / 2) * 2];
-	    skb->rb_frame_size += size;
-	}
-
-    } else {
-	frame->can_id = ((regs->canrxfg.idr[0] << 3) | 
-			 (regs->canrxfg.idr[1] >> 5));
-
-	if ((regs->canrxfg.idr[1] & MSCAN_BUF_STD_RTR)) {
-	    frame->can_id |= CAN_RTR_FLAG;
-        } else {
-	    for (i = 0; i < size; i++)
-                frame->data[i] = regs->canrxfg.dsr[i + (i / 2) * 2];
-	    skb->rb_frame_size += size;
-        } 
-    }
-
-    
-    /* Store the interface index */
-    frame->can_ifindex = dev->ifindex;
-}
-
+	int i;
+	unsigned char size;
+	struct rtcan_rb_frame *frame = &skb->rb_frame;
+	struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
 
-static can_state_t mscan_stat_map[4] = {
-    CAN_STATE_ACTIVE,
-    CAN_STATE_BUS_WARNING,
-    CAN_STATE_BUS_PASSIVE,
-    CAN_STATE_BUS_OFF
-};
+	skb->rb_frame_size = EMPTY_RB_FRAME_SIZE;
 
-static inline void rtcan_mscan_err_interrupt(struct rtcan_device *dev,
-					     struct rtcan_skb *skb, 
-					     int r_status)
-{
-    u8 rstat, tstat;
-    struct rtcan_rb_frame *frame = &skb->rb_frame;
-    struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
-
-    skb->rb_frame_size = EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
+	frame->can_dlc = regs->canrxfg.dlr & 0x0F;
 
-    frame->can_id = CAN_ERR_FLAG;
-    frame->can_dlc = CAN_ERR_DLC;
+	/* If DLC exceeds 8 bytes adjust it to 8 (for the payload size) */
+	size = (frame->can_dlc > 8) ? 8 : frame->can_dlc;
 
-    memset(&frame->data[0], 0, frame->can_dlc);
+	if (regs->canrxfg.idr[1] & MSCAN_BUF_EXTENDED) {
+		frame->can_id = ((regs->canrxfg.idr[0] << 21) |
+				 ((regs->canrxfg.idr[1] & 0xE0) << 13) |
+				 ((regs->canrxfg.idr[1] & 0x07) << 15) |
+				 (regs->canrxfg.idr[4] << 7) |
+				 (regs->canrxfg.idr[5] >> 1));
 
-    if ((r_status & MSCAN_OVRIF)) {
-	frame->can_id |= CAN_ERR_CRTL;
-	frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+		frame->can_id |= CAN_EFF_FLAG;
 
-    } else if ((r_status & (MSCAN_CSCIF))) {
-	
-	rstat = (r_status & (MSCAN_TSTAT0 | 
-			     MSCAN_TSTAT1)) >> 2 & 0x3;  
-	tstat = (r_status & (MSCAN_RSTAT0 | 
-			     MSCAN_RSTAT1)) >> 4 & 0x3;  
-	dev->state = mscan_stat_map[max(rstat, tstat)];
+		if ((regs->canrxfg.idr[5] & MSCAN_BUF_EXT_RTR)) {
+			frame->can_id |= CAN_RTR_FLAG;
+		} else {
+			for (i = 0; i < size; i++)
+				frame->data[i] =
+					regs->canrxfg.dsr[i + (i / 2) * 2];
+			skb->rb_frame_size += size;
+		}
 
-	switch (dev->state) {
-	case CAN_STATE_BUS_OFF:
-	    /* Bus-off condition */
-	    frame->can_id |= CAN_ERR_BUSOFF;
-	    dev->state = CAN_STATE_BUS_OFF;
-	    /* Disable receiver interrupts */
-	    regs->canrier = 0;
-	    /* Wake up waiting senders */
-	    rtdm_sem_destroy(&dev->tx_sem);
-	    break;
+	} else {
+		frame->can_id = ((regs->canrxfg.idr[0] << 3) |
+				 (regs->canrxfg.idr[1] >> 5));
+
+		if ((regs->canrxfg.idr[1] & MSCAN_BUF_STD_RTR)) {
+			frame->can_id |= CAN_RTR_FLAG;
+		} else {
+			for (i = 0; i < size; i++)
+				frame->data[i] =
+					regs->canrxfg.dsr[i + (i / 2) * 2];
+			skb->rb_frame_size += size;
+		}
+	}
 
-	case CAN_STATE_BUS_PASSIVE:
-	    frame->can_id |= CAN_ERR_CRTL;
-	    if (tstat > rstat)
-		frame->data[1] = CAN_ERR_CRTL_TX_PASSIVE; 
-	    else 
-		frame->data[1] = CAN_ERR_CRTL_RX_PASSIVE;
-	    break;
 
-	case CAN_STATE_BUS_WARNING:
-	    frame->can_id |= CAN_ERR_CRTL;
-	    if (tstat > rstat)
-		frame->data[1] = CAN_ERR_CRTL_TX_WARNING; 
-	    else 
-		frame->data[1] = CAN_ERR_CRTL_RX_WARNING;
-	    break;
+	/* Store the interface index */
+	frame->can_ifindex = dev->ifindex;
+}
 
-	default:
-	    break;
+static can_state_t mscan_stat_map[4] = {
+	CAN_STATE_ACTIVE,
+	CAN_STATE_BUS_WARNING,
+	CAN_STATE_BUS_PASSIVE,
+	CAN_STATE_BUS_OFF
+};
 
+static inline void rtcan_mscan_err_interrupt(struct rtcan_device *dev,
+					     struct rtcan_skb *skb,
+					     int r_status)
+{
+	u8 rstat, tstat;
+	struct rtcan_rb_frame *frame = &skb->rb_frame;
+	struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
+
+	skb->rb_frame_size = EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
+
+	frame->can_id = CAN_ERR_FLAG;
+	frame->can_dlc = CAN_ERR_DLC;
+
+	memset(&frame->data[0], 0, frame->can_dlc);
+
+	if ((r_status & MSCAN_OVRIF)) {
+		frame->can_id |= CAN_ERR_CRTL;
+		frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+
+	} else if ((r_status & (MSCAN_CSCIF))) {
+
+		rstat = (r_status & (MSCAN_TSTAT0 |
+				     MSCAN_TSTAT1)) >> 2 & 0x3;
+		tstat = (r_status & (MSCAN_RSTAT0 |
+				     MSCAN_RSTAT1)) >> 4 & 0x3;
+		dev->state = mscan_stat_map[max(rstat, tstat)];
+
+		switch (dev->state) {
+		case CAN_STATE_BUS_OFF:
+			/* Bus-off condition */
+			frame->can_id |= CAN_ERR_BUSOFF;
+			dev->state = CAN_STATE_BUS_OFF;
+			/* Disable receiver interrupts */
+			regs->canrier = 0;
+			/* Wake up waiting senders */
+			rtdm_sem_destroy(&dev->tx_sem);
+			break;
+
+		case CAN_STATE_BUS_PASSIVE:
+			frame->can_id |= CAN_ERR_CRTL;
+			if (tstat > rstat)
+				frame->data[1] = CAN_ERR_CRTL_TX_PASSIVE;
+			else
+				frame->data[1] = CAN_ERR_CRTL_RX_PASSIVE;
+			break;
+
+		case CAN_STATE_BUS_WARNING:
+			frame->can_id |= CAN_ERR_CRTL;
+			if (tstat > rstat)
+				frame->data[1] = CAN_ERR_CRTL_TX_WARNING;
+			else
+				frame->data[1] = CAN_ERR_CRTL_RX_WARNING;
+			break;
+
+		default:
+			break;
+
+		}
 	}
-    }
-    /* Store the interface index */
-    frame->can_ifindex = dev->ifindex;
+	/* Store the interface index */
+	frame->can_ifindex = dev->ifindex;
 }
 
-
-
 /** Interrupt handler */
 static int rtcan_mscan_interrupt(rtdm_irq_t *irq_handle)
 {
-    struct rtcan_skb skb;
-    struct rtcan_device *dev;
-    struct mscan_regs *regs;
-    u8 canrflg;
-    int recv_lock_free = 1;
-    int ret = RTDM_IRQ_NONE;
+	struct rtcan_skb skb;
+	struct rtcan_device *dev;
+	struct mscan_regs *regs;
+	u8 canrflg;
+	int recv_lock_free = 1;
+	int ret = RTDM_IRQ_NONE;
 
 
-    dev = (struct rtcan_device *)rtdm_irq_get_arg(irq_handle, void);
-    regs = (struct mscan_regs *)dev->base_addr;
+	dev = (struct rtcan_device *)rtdm_irq_get_arg(irq_handle, void);
+	regs = (struct mscan_regs *)dev->base_addr;
 
-    rtdm_lock_get(&dev->device_lock);
+	rtdm_lock_get(&dev->device_lock);
 
-    canrflg = regs->canrflg;
+	canrflg = regs->canrflg;
 
-    ret = RTDM_IRQ_HANDLED;
+	ret = RTDM_IRQ_HANDLED;
 
-    /* Transmit Interrupt? */
-    if ((regs->cantier & MSCAN_TXIE0) && (regs->cantflg & MSCAN_TXE0)) {
-	regs->cantier = 0;
-	/* Wake up a sender */
-	rtdm_sem_up(&dev->tx_sem);
+	/* Transmit Interrupt? */
+	if ((regs->cantier & MSCAN_TXIE0) && (regs->cantflg & MSCAN_TXE0)) {
+		regs->cantier = 0;
+		/* Wake up a sender */
+		rtdm_sem_up(&dev->tx_sem);
 
-	if (rtcan_loopback_pending(dev)) {
+		if (rtcan_loopback_pending(dev)) {
 
-	    if (recv_lock_free) {
-		recv_lock_free = 0;
-		rtdm_lock_get(&rtcan_recv_list_lock);
-		rtdm_lock_get(&rtcan_socket_lock);
-	    }
+			if (recv_lock_free) {
+				recv_lock_free = 0;
+				rtdm_lock_get(&rtcan_recv_list_lock);
+				rtdm_lock_get(&rtcan_socket_lock);
+			}
 
-	    rtcan_loopback(dev);
+			rtcan_loopback(dev);
+		}
 	}
-    }
-
-    /* Wakeup interrupt?  */
-    if ((canrflg & MSCAN_WUPIF)) {
-	rtdm_printk("WUPIF interrupt\n");
-    }
-
-    /* Receive Interrupt? */
-    if ((canrflg & MSCAN_RXF)) {
-	
-	/* Read out HW registers */
-	rtcan_mscan_rx_interrupt(dev, &skb);
-	
-	/* Take more locks. Ensure that they are taken and
-	 * released only once in the IRQ handler. */
-	/* WARNING: Nested locks are dangerous! But they are
-	 * nested only in this routine so a deadlock should
-	 * not be possible. */
-	if (recv_lock_free) {
-	    recv_lock_free = 0;
-	    rtdm_lock_get(&rtcan_recv_list_lock);
-	    rtdm_lock_get(&rtcan_socket_lock);
+
+	/* Wakeup interrupt?  */
+	if ((canrflg & MSCAN_WUPIF)) {
+		rtdm_printk("WUPIF interrupt\n");
 	}
-    
-	/* Pass received frame out to the sockets */
-	rtcan_rcv(dev, &skb);
-    }
-
-    /* Error Interrupt? */
-    if ((canrflg & (MSCAN_CSCIF | MSCAN_OVRIF))) {
-	/* Check error condition and fill error frame */
-	rtcan_mscan_err_interrupt(dev, &skb, canrflg);
-
-	if (recv_lock_free) {
-	    recv_lock_free = 0;
-	    rtdm_lock_get(&rtcan_recv_list_lock);
-	    rtdm_lock_get(&rtcan_socket_lock);
+
+	/* Receive Interrupt? */
+	if ((canrflg & MSCAN_RXF)) {
+
+		/* Read out HW registers */
+		rtcan_mscan_rx_interrupt(dev, &skb);
+
+		/* Take more locks. Ensure that they are taken and
+		 * released only once in the IRQ handler. */
+		/* WARNING: Nested locks are dangerous! But they are
+		 * nested only in this routine so a deadlock should
+		 * not be possible. */
+		if (recv_lock_free) {
+			recv_lock_free = 0;
+			rtdm_lock_get(&rtcan_recv_list_lock);
+			rtdm_lock_get(&rtcan_socket_lock);
+		}
+
+		/* Pass received frame out to the sockets */
+		rtcan_rcv(dev, &skb);
 	}
-	
-	/* Pass error frame out to the sockets */
-	rtcan_rcv(dev, &skb);
-    }
-
-    /* Acknowledge the handled interrupt within the controller.
-     * Only do so for the receiver interrupts.
-     */
-    if (canrflg)
-	regs->canrflg = canrflg;
-
-    if (!recv_lock_free) {
-        rtdm_lock_put(&rtcan_socket_lock);
-        rtdm_lock_put(&rtcan_recv_list_lock);
-    }
-    rtdm_lock_put(&dev->device_lock);
-
-    return ret;
-}
 
+	/* Error Interrupt? */
+	if ((canrflg & (MSCAN_CSCIF | MSCAN_OVRIF))) {
+		/* Check error condition and fill error frame */
+		rtcan_mscan_err_interrupt(dev, &skb, canrflg);
 
+		if (recv_lock_free) {
+			recv_lock_free = 0;
+			rtdm_lock_get(&rtcan_recv_list_lock);
+			rtdm_lock_get(&rtcan_socket_lock);
+		}
+
+		/* Pass error frame out to the sockets */
+		rtcan_rcv(dev, &skb);
+	}
+
+	/* Acknowledge the handled interrupt within the controller.
+	 * Only do so for the receiver interrupts.
+	 */
+	if (canrflg)
+		regs->canrflg = canrflg;
+
+	if (!recv_lock_free) {
+		rtdm_lock_put(&rtcan_socket_lock);
+		rtdm_lock_put(&rtcan_recv_list_lock);
+	}
+	rtdm_lock_put(&dev->device_lock);
+
+	return ret;
+}
 
 /**
  *   Set controller into reset mode. Called from @ref rtcan_mscan_ioctl
@@ -345,45 +340,43 @@ static int rtcan_mscan_interrupt(rtdm_irq_t *irq_handle)
 static int rtcan_mscan_mode_stop(struct rtcan_device *dev,
 				 rtdm_lockctx_t *lock_ctx)
 {
-    int ret = 0;
-    int rinit = 0;
-    can_state_t state;
-    volatile struct mscan_regs *regs = 
-	(struct mscan_regs *)dev->base_addr;
-    u8 reg;
-
-    state = dev->state;
-    /* If controller is not operating anyway, go out */
-    if (!CAN_STATE_OPERATING(state))
-        goto out;
-
-    /* Switch to sleep mode */
-    regs->canctl0 |= MSCAN_SLPRQ;
-    regs->canctl0 |= MSCAN_INITRQ;
-    
-    reg = regs->canctl1;
-    while (!(reg & MSCAN_SLPAK) ||
-	   !(reg & MSCAN_INITAK)) {
-        if (likely(lock_ctx != NULL))
-            rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
-        /* Busy sleep 1 microsecond */
-        rtdm_task_busy_sleep(1000);
-        if (likely(lock_ctx != NULL))
-            rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
-	rinit++;
-	reg = regs->canctl1;
-    }
+	int ret = 0;
+	int rinit = 0;
+	can_state_t state;
+	volatile struct mscan_regs *regs =
+		(struct mscan_regs *)dev->base_addr;
+	u8 reg;
 
-    /* Volatile state could have changed while we slept busy. */
-    dev->state = CAN_STATE_STOPPED;
-    /* Wake up waiting senders */
-    rtdm_sem_destroy(&dev->tx_sem);
+	state = dev->state;
+	/* If controller is not operating anyway, go out */
+	if (!CAN_STATE_OPERATING(state))
+		goto out;
 
- out:
-    return ret;
-}
+	/* Switch to sleep mode */
+	regs->canctl0 |= MSCAN_SLPRQ;
+	regs->canctl0 |= MSCAN_INITRQ;
 
+	reg = regs->canctl1;
+	while (!(reg & MSCAN_SLPAK) ||
+	       !(reg & MSCAN_INITAK)) {
+		if (likely(lock_ctx != NULL))
+			rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
+		/* Busy sleep 1 microsecond */
+		rtdm_task_busy_sleep(1000);
+		if (likely(lock_ctx != NULL))
+			rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
+		rinit++;
+		reg = regs->canctl1;
+	}
 
+	/* Volatile state could have changed while we slept busy. */
+	dev->state = CAN_STATE_STOPPED;
+	/* Wake up waiting senders */
+	rtdm_sem_destroy(&dev->tx_sem);
+
+out:
+	return ret;
+}
 
 /**
  *   Set controller into operating mode.
@@ -405,183 +398,185 @@ static int rtcan_mscan_mode_stop(struct rtcan_device *dev,
 static int rtcan_mscan_mode_start(struct rtcan_device *dev,
 				  rtdm_lockctx_t *lock_ctx)
 {
-    int ret = 0, retries = 0;
-    can_state_t state;
-    volatile struct mscan_regs *regs = 
-	(struct mscan_regs *)dev->base_addr;
-
-    /* We won't forget that state in the device structure is volatile and
-     * access to it will not be optimized by the compiler. So ... */
-    state = dev->state;
-
-    switch (state) {
-    case CAN_STATE_ACTIVE:
-    case CAN_STATE_BUS_WARNING:
-    case CAN_STATE_BUS_PASSIVE:
-	break;
-
-    case CAN_STATE_SLEEPING:
-    case CAN_STATE_STOPPED:
-	/* Set error active state */
-	state = CAN_STATE_ACTIVE;
-	/* Set up sender "mutex" */
-	rtdm_sem_init(&dev->tx_sem, 1);
-
-	if ((dev->ctrl_mode & CAN_CTRLMODE_LISTENONLY)) {
-	    regs->canctl1 |= MSCAN_LISTEN;
-	} else {
-	    regs->canctl1 &= ~MSCAN_LISTEN;
-	}
-	if ((dev->ctrl_mode & CAN_CTRLMODE_LOOPBACK)) {
-	    regs->canctl1 |= MSCAN_LOOPB;
-	} else {
-	    regs->canctl1 &= ~MSCAN_LOOPB;
-	}
+	int ret = 0, retries = 0;
+	can_state_t state;
+	volatile struct mscan_regs *regs =
+		(struct mscan_regs *)dev->base_addr;
 
-	/* Switch to normal mode */
-	regs->canctl0 &= ~MSCAN_INITRQ;
-	regs->canctl0 &= ~MSCAN_SLPRQ;
-	while ((regs->canctl1 & MSCAN_INITAK) ||
-	       (regs->canctl1 & MSCAN_SLPAK)) {
-	    if (likely(lock_ctx != NULL))
-		rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
-	    /* Busy sleep 1 microsecond */
-	    rtdm_task_busy_sleep(1000);
-	    if (likely(lock_ctx != NULL))
-		rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
-	    retries++;
-	}
-	/* Enable interrupts */
-	regs->canrier |= MSCAN_RIER;
+	/* We won't forget that state in the device structure is volatile and
+	 * access to it will not be optimized by the compiler. So ... */
+	state = dev->state;
 
-	break;
+	switch (state) {
+	case CAN_STATE_ACTIVE:
+	case CAN_STATE_BUS_WARNING:
+	case CAN_STATE_BUS_PASSIVE:
+		break;
 
-    case CAN_STATE_BUS_OFF:
-	/* Trigger bus-off recovery */
-	regs->canrier = MSCAN_RIER;
-	/* Set up sender "mutex" */
-	rtdm_sem_init(&dev->tx_sem, 1);
-	/* Set error active state */
-	state = CAN_STATE_ACTIVE;
+	case CAN_STATE_SLEEPING:
+	case CAN_STATE_STOPPED:
+		/* Set error active state */
+		state = CAN_STATE_ACTIVE;
+		/* Set up sender "mutex" */
+		rtdm_sem_init(&dev->tx_sem, 1);
+
+		if ((dev->ctrl_mode & CAN_CTRLMODE_LISTENONLY)) {
+			regs->canctl1 |= MSCAN_LISTEN;
+		} else {
+			regs->canctl1 &= ~MSCAN_LISTEN;
+		}
+		if ((dev->ctrl_mode & CAN_CTRLMODE_LOOPBACK)) {
+			regs->canctl1 |= MSCAN_LOOPB;
+		} else {
+			regs->canctl1 &= ~MSCAN_LOOPB;
+		}
+
+		/* Switch to normal mode */
+		regs->canctl0 &= ~MSCAN_INITRQ;
+		regs->canctl0 &= ~MSCAN_SLPRQ;
+		while ((regs->canctl1 & MSCAN_INITAK) ||
+		       (regs->canctl1 & MSCAN_SLPAK)) {
+			if (likely(lock_ctx != NULL))
+				rtdm_lock_put_irqrestore(&dev->device_lock,
+							 *lock_ctx);
+			/* Busy sleep 1 microsecond */
+			rtdm_task_busy_sleep(1000);
+			if (likely(lock_ctx != NULL))
+				rtdm_lock_get_irqsave(&dev->device_lock,
+						      *lock_ctx);
+			retries++;
+		}
+		/* Enable interrupts */
+		regs->canrier |= MSCAN_RIER;
 
-	break;
+		break;
+
+	case CAN_STATE_BUS_OFF:
+		/* Trigger bus-off recovery */
+		regs->canrier = MSCAN_RIER;
+		/* Set up sender "mutex" */
+		rtdm_sem_init(&dev->tx_sem, 1);
+		/* Set error active state */
+		state = CAN_STATE_ACTIVE;
 
-    default:
-	/* Never reached, but we don't want nasty compiler warnings ... */
-	break;
-    }
-    /* Store new state in device structure (or old state) */
-    dev->state = state;
+		break;
 
-    return ret;
+	default:
+		/* Never reached, but we don't want nasty compiler warnings */
+		break;
+	}
+	/* Store new state in device structure (or old state) */
+	dev->state = state;
+
+	return ret;
 }
 
-int rtcan_mscan_set_bit_time(struct rtcan_device *dev, 
+int rtcan_mscan_set_bit_time(struct rtcan_device *dev,
 			     struct can_bittime *bit_time,
 			     rtdm_lockctx_t *lock_ctx)
 {
-    struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr; 
-    u8 btr0, btr1;
-	
-    switch (bit_time->type) {
-    case CAN_BITTIME_BTR:
-	btr0 = bit_time->btr.btr0;
-	btr1 = bit_time->btr.btr1;
-	break;
-
-    case CAN_BITTIME_STD:
-	btr0 = (BTR0_SET_BRP(bit_time->std.brp) | 
-		BTR0_SET_SJW(bit_time->std.sjw));
-	btr1 = (BTR1_SET_TSEG1(bit_time->std.prop_seg + 
-			       bit_time->std.phase_seg1) |
-		BTR1_SET_TSEG2(bit_time->std.phase_seg2) | 
-		BTR1_SET_SAM(bit_time->std.sam));
-	break;
-	
-    default:
-	return -EINVAL;
-    }
-
-    regs->canbtr0 = btr0;
-    regs->canbtr1 = btr1;
-    
-    rtdm_printk("%s: btr0=0x%02x btr1=0x%02x\n", dev->name, btr0, btr1);
- 
-    return 0;
+	struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
+	u8 btr0, btr1;
+
+	switch (bit_time->type) {
+	case CAN_BITTIME_BTR:
+		btr0 = bit_time->btr.btr0;
+		btr1 = bit_time->btr.btr1;
+		break;
+
+	case CAN_BITTIME_STD:
+		btr0 = (BTR0_SET_BRP(bit_time->std.brp) |
+			BTR0_SET_SJW(bit_time->std.sjw));
+		btr1 = (BTR1_SET_TSEG1(bit_time->std.prop_seg +
+				       bit_time->std.phase_seg1) |
+			BTR1_SET_TSEG2(bit_time->std.phase_seg2) |
+			BTR1_SET_SAM(bit_time->std.sam));
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	regs->canbtr0 = btr0;
+	regs->canbtr1 = btr1;
+
+	rtdm_printk("%s: btr0=0x%02x btr1=0x%02x\n", dev->name, btr0, btr1);
+
+	return 0;
 }
 
-int rtcan_mscan_set_mode(struct rtcan_device *dev, 
+int rtcan_mscan_set_mode(struct rtcan_device *dev,
 			 can_mode_t mode,
 			 rtdm_lockctx_t *lock_ctx)
 {
-    int ret = 0, retries = 0;
-    can_state_t state;
-    struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr; 
-
-    switch (mode) {
+	int ret = 0, retries = 0;
+	can_state_t state;
+	struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
 
-    case CAN_MODE_STOP:
-	ret = rtcan_mscan_mode_stop(dev, lock_ctx);
-	break;
+	switch (mode) {
 
-    case CAN_MODE_START:
-	ret = rtcan_mscan_mode_start(dev, lock_ctx);
-	break;
+	case CAN_MODE_STOP:
+		ret = rtcan_mscan_mode_stop(dev, lock_ctx);
+		break;
 
-    case CAN_MODE_SLEEP:
-	    
-	state = dev->state;
-	
-	/* Controller must operate, otherwise go out */
-	if (!CAN_STATE_OPERATING(state)) {
-	    ret = -ENETDOWN;
-	    goto mode_sleep_out;
-	}
-	
-	/* Is controller sleeping yet? If yes, go out */
-	if (state == CAN_STATE_SLEEPING)
-	    goto mode_sleep_out;
-	
-	/* Remember into which state to return when we
-	 * wake up */
-	dev->state_before_sleep = state;
-	state = CAN_STATE_SLEEPING;
-	
-	/* Let's take a nap. (Now I REALLY understand
-	 * the meaning of interrupts ...) */
-	regs->canrier = 0;
-	regs->cantier = 0;
-	regs->canctl0 |= MSCAN_SLPRQ /*| MSCAN_INITRQ*/ | MSCAN_WUPE;
-	while (!(regs->canctl1 & MSCAN_SLPAK)) {
-	    rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
-	    /* Busy sleep 1 microsecond */
-	    rtdm_task_busy_sleep(1000);
-	    rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
-	    if (retries++ >= 1000)
+	case CAN_MODE_START:
+		ret = rtcan_mscan_mode_start(dev, lock_ctx);
 		break;
-	}
-	rtdm_printk("Fallen asleep after %d tries.\n", retries);
-	regs->canctl0 &= ~MSCAN_INITRQ;
-	while ((regs->canctl1 & MSCAN_INITAK)) {
-	    rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
-	    /* Busy sleep 1 microsecond */
-	    rtdm_task_busy_sleep(1000);
-	    rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
-	    if (retries++ >= 1000)
+
+	case CAN_MODE_SLEEP:
+
+		state = dev->state;
+
+		/* Controller must operate, otherwise go out */
+		if (!CAN_STATE_OPERATING(state)) {
+			ret = -ENETDOWN;
+			goto mode_sleep_out;
+		}
+
+		/* Is controller sleeping yet? If yes, go out */
+		if (state == CAN_STATE_SLEEPING)
+			goto mode_sleep_out;
+
+		/* Remember into which state to return when we
+		 * wake up */
+		dev->state_before_sleep = state;
+		state = CAN_STATE_SLEEPING;
+
+		/* Let's take a nap. (Now I REALLY understand
+		 * the meaning of interrupts ...) */
+		regs->canrier = 0;
+		regs->cantier = 0;
+		regs->canctl0 |= MSCAN_SLPRQ /*| MSCAN_INITRQ*/ | MSCAN_WUPE;
+		while (!(regs->canctl1 & MSCAN_SLPAK)) {
+			rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
+			/* Busy sleep 1 microsecond */
+			rtdm_task_busy_sleep(1000);
+			rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
+			if (retries++ >= 1000)
+				break;
+		}
+		rtdm_printk("Fallen asleep after %d tries.\n", retries);
+		regs->canctl0 &= ~MSCAN_INITRQ;
+		while ((regs->canctl1 & MSCAN_INITAK)) {
+			rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
+			/* Busy sleep 1 microsecond */
+			rtdm_task_busy_sleep(1000);
+			rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
+			if (retries++ >= 1000)
+				break;
+		}
+		rtdm_printk("Back to normal after %d tries.\n", retries);
+		regs->canrier = MSCAN_WUPIE;
+
+	mode_sleep_out:
+		dev->state = state;
 		break;
-	}
-	rtdm_printk("Back to normal after %d tries.\n", retries);
-	regs->canrier = MSCAN_WUPIE;
-	
-    mode_sleep_out:
-	dev->state = state;
-	break;
 
-    default:
-	ret = -EOPNOTSUPP;
-    }
+	default:
+		ret = -EOPNOTSUPP;
+	}
 
-    return ret;
+	return ret;
 }
 
 /**
@@ -594,81 +589,80 @@ int rtcan_mscan_set_mode(struct rtcan_device *dev,
  *  @param[in] frame  Pointer to CAN frame which is about to be sent
  *  @param[in] dev Device ID
  */
-static int rtcan_mscan_start_xmit(struct rtcan_device *dev,
-				  can_frame_t *frame)
+static int rtcan_mscan_start_xmit(struct rtcan_device *dev, can_frame_t *frame)
 {
-    int             i, id;
-    /* "Real" size of the payload */
-    unsigned char   size;
-    /* Content of frame information register */
-    unsigned char   dlc;
-
-    struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
-
-    /* Is TX buffer empty? */
-    if (!(regs->cantflg & MSCAN_TXE0)) {
-	rtdm_printk("rtcan_mscan_start_xmit: TX buffer not empty");
-	return -EIO;
-    }
-    /* Select the buffer we've found. */
-    regs->cantbsel = MSCAN_TXE0;
-
-    /* Get DLC and ID */
-    dlc = frame->can_dlc;
-
-    /* If DLC exceeds 8 bytes adjust it to 8 (for the payload) */
-    size = (dlc > 8) ? 8 : dlc;
-
-    id = frame->can_id;
-    if (frame->can_id & CAN_EFF_FLAG) {
-	regs->cantxfg.idr[0]  = (id & 0x1fe00000) >> 21;
-	regs->cantxfg.idr[1]  = (id & 0x001c0000) >> 13;
-	regs->cantxfg.idr[1] |= (id & 0x00038000) >> 15;
-	regs->cantxfg.idr[1] |= 0x18; /* set SRR and IDE bits */
-
-	regs->cantxfg.idr[4]  = (id & 0x00007f80) >> 7 ;
-	regs->cantxfg.idr[5]  = (id & 0x0000007f) << 1 ;
-
-        /* RTR? */
-        if (frame->can_id & CAN_RTR_FLAG)
-	    regs->cantxfg.idr[5] |= 0x1;
-        else {
-	    regs->cantxfg.idr[5] &= ~0x1;
-            /* No RTR, write data bytes */
-            for (i = 0; i < size; i++)
-		regs->cantxfg.dsr[i + (i / 2) * 2] = frame->data[i];
-        }
-
-    } else {
-        /* Send standard frame */
-
-	regs->cantxfg.idr[0] = (id & 0x000007f8) >> 3;
-	regs->cantxfg.idr[1] = (id & 0x00000007) << 5;
-
-        /* RTR? */
-        if (frame->can_id & CAN_RTR_FLAG)
-	    regs->cantxfg.idr[1] |= 0x10;
-        else {
-	    regs->cantxfg.idr[1] &= ~0x10;
-            /* No RTR, write data bytes */
-            for (i = 0; i < size; i++)
- 		regs->cantxfg.dsr[i + (i / 2) * 2] = frame->data[i];
-        }
-    }
-
-    regs->cantxfg.dlr = frame->can_dlc;
-    regs->cantxfg.tbpr = 0;	/* all messages have the same prio */
-
-    /* Trigger transmission. */
-    regs->cantflg = MSCAN_TXE0;
-
-    /* Enable interrupt. */
-    regs->cantier |= MSCAN_TXIE0;
-
-    return 0;
-}
+	int             i, id;
+	/* "Real" size of the payload */
+	unsigned char   size;
+	/* Content of frame information register */
+	unsigned char   dlc;
+
+	struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
+
+	/* Is TX buffer empty? */
+	if (!(regs->cantflg & MSCAN_TXE0)) {
+		rtdm_printk("rtcan_mscan_start_xmit: TX buffer not empty");
+		return -EIO;
+	}
+	/* Select the buffer we've found. */
+	regs->cantbsel = MSCAN_TXE0;
+
+	/* Get DLC and ID */
+	dlc = frame->can_dlc;
+
+	/* If DLC exceeds 8 bytes adjust it to 8 (for the payload) */
+	size = (dlc > 8) ? 8 : dlc;
+
+	id = frame->can_id;
+	if (frame->can_id & CAN_EFF_FLAG) {
+		regs->cantxfg.idr[0]  = (id & 0x1fe00000) >> 21;
+		regs->cantxfg.idr[1]  = (id & 0x001c0000) >> 13;
+		regs->cantxfg.idr[1] |= (id & 0x00038000) >> 15;
+		regs->cantxfg.idr[1] |= 0x18; /* set SRR and IDE bits */
+
+		regs->cantxfg.idr[4]  = (id & 0x00007f80) >> 7 ;
+		regs->cantxfg.idr[5]  = (id & 0x0000007f) << 1 ;
+
+		/* RTR? */
+		if (frame->can_id & CAN_RTR_FLAG)
+			regs->cantxfg.idr[5] |= 0x1;
+		else {
+			regs->cantxfg.idr[5] &= ~0x1;
+			/* No RTR, write data bytes */
+			for (i = 0; i < size; i++)
+				regs->cantxfg.dsr[i + (i / 2) * 2] =
+					frame->data[i];
+		}
 
+	} else {
+		/* Send standard frame */
+
+		regs->cantxfg.idr[0] = (id & 0x000007f8) >> 3;
+		regs->cantxfg.idr[1] = (id & 0x00000007) << 5;
+
+		/* RTR? */
+		if (frame->can_id & CAN_RTR_FLAG)
+			regs->cantxfg.idr[1] |= 0x10;
+		else {
+			regs->cantxfg.idr[1] &= ~0x10;
+			/* No RTR, write data bytes */
+			for (i = 0; i < size; i++)
+				regs->cantxfg.dsr[i + (i / 2) * 2] =
+					frame->data[i];
+		}
+	}
 
+	regs->cantxfg.dlr = frame->can_dlc;
+	regs->cantxfg.tbpr = 0;	/* all messages have the same prio */
+
+	/* Trigger transmission. */
+	regs->cantflg = MSCAN_TXE0;
+
+	/* Enable interrupt. */
+	regs->cantier |= MSCAN_TXIE0;
+
+	return 0;
+}
 
 /**
  *  MSCAN Chip configuration
@@ -682,231 +676,231 @@ static int rtcan_mscan_start_xmit(struct rtcan_device *dev,
  */
 static inline void __init mscan_chip_config(struct mscan_regs *regs)
 {
-    /* Choose IP bus as clock source.
-     */
-    regs->canctl1 |= MSCAN_CLKSRC;
-    regs->canctl1 &= ~MSCAN_LISTEN;
-
-    /* Configure MSCAN to accept all incoming messages.
-     */
-    regs->canidar0 = regs->canidar1 = 0x00;
-    regs->canidar2 = regs->canidar3 = 0x00;
-    regs->canidmr0 = regs->canidmr1 = 0xFF;
-    regs->canidmr2 = regs->canidmr3 = 0xFF;
-    regs->canidar4 = regs->canidar5 = 0x00;
-    regs->canidar6 = regs->canidar7 = 0x00;
-    regs->canidmr4 = regs->canidmr5 = 0xFF;
-    regs->canidmr6 = regs->canidmr7 = 0xFF;
-    regs->canidac &= ~(MSCAN_IDAM0 | MSCAN_IDAM1);
+	/* Choose IP bus as clock source.
+	 */
+	regs->canctl1 |= MSCAN_CLKSRC;
+	regs->canctl1 &= ~MSCAN_LISTEN;
+
+	/* Configure MSCAN to accept all incoming messages.
+	 */
+	regs->canidar0 = regs->canidar1 = 0x00;
+	regs->canidar2 = regs->canidar3 = 0x00;
+	regs->canidmr0 = regs->canidmr1 = 0xFF;
+	regs->canidmr2 = regs->canidmr3 = 0xFF;
+	regs->canidar4 = regs->canidar5 = 0x00;
+	regs->canidar6 = regs->canidar7 = 0x00;
+	regs->canidmr4 = regs->canidmr5 = 0xFF;
+	regs->canidmr6 = regs->canidmr7 = 0xFF;
+	regs->canidac &= ~(MSCAN_IDAM0 | MSCAN_IDAM1);
 }
 
 static inline void __init mscan_gpio_config(void)
 {
-    struct mpc5xxx_gpio *gpio = (struct mpc5xxx_gpio *)MPC5xxx_GPIO;
-    int can_to_psc2 = -1;
+	struct mpc5xxx_gpio *gpio = (struct mpc5xxx_gpio *)MPC5xxx_GPIO;
+	int can_to_psc2 = -1;
 
 #if defined(CONFIG_XENO_DRIVERS_CAN_MSCAN_ALT)
-    can_to_psc2 = 0;
+	can_to_psc2 = 0;
 #elif defined(CONFIG_XENO_DRIVERS_CAN_MSCAN_PSC2)
-    can_to_psc2 = 1;
+	can_to_psc2 = 1;
 #endif
 
-    /* Configure CAN routing to GPIO pins.
-     */
-    if (mscan_pins != NULL) {
-	if (strncmp(mscan_pins, "psc2", 4) == 0 ||
-	    !strncmp(mscan_pins, "PSC2", 4))
-	    can_to_psc2 = 1;
-	else if (strncmp(mscan_pins, "i2c1/tmr01", 10) == 0 ||
-		 strncmp(mscan_pins, "I2C1/TMR01", 10) == 0)
-	    can_to_psc2 = 0;
-	else {
-	    printk("Module parameter mscan_pins=%s is invalid. "
-		   "Please use PSC2 or I2C1/TMR01.\n", mscan_pins);	    
+	/* Configure CAN routing to GPIO pins.
+	 */
+	if (mscan_pins != NULL) {
+		if (strncmp(mscan_pins, "psc2", 4) == 0 ||
+		    !strncmp(mscan_pins, "PSC2", 4))
+			can_to_psc2 = 1;
+		else if (strncmp(mscan_pins, "i2c1/tmr01", 10) == 0 ||
+			 strncmp(mscan_pins, "I2C1/TMR01", 10) == 0)
+			can_to_psc2 = 0;
+		else {
+			printk("Module parameter mscan_pins=%s is invalid. "
+			       "Please use PSC2 or I2C1/TMR01.\n", mscan_pins);
+		}
+	}
+
+	if (!gpio || can_to_psc2 < 0) {
+		printk("%s: use pre-configure CAN routing\n", RTCAN_DRV_NAME);
+		return;
+	}
+
+	if (can_to_psc2) {
+		gpio->port_config &= ~0x10000070;
+		gpio->port_config |= 0x00000010;
+		printk("%s: CAN 1 and 2 routed to PSC2 pins\n", RTCAN_DRV_NAME);
+	} else {
+		gpio->port_config |= 0x10000000;
+		printk("%s: CAN 1 routed to I2C1 pins and CAN2 to TMR01 pins\n",
+		       RTCAN_DRV_NAME);
 	}
-    }
-
-    if (!gpio || can_to_psc2 < 0) {
-	printk("%s: use pre-configure CAN routing\n", RTCAN_DRV_NAME);
-	return;
-    }
-
-    if (can_to_psc2) {
-	gpio->port_config &= ~0x10000070;
-	gpio->port_config |= 0x00000010;
-	printk("%s: CAN 1 and 2 routed to PSC2 pins\n", RTCAN_DRV_NAME);
-    } else {
-	gpio->port_config |= 0x10000000;
-	printk("%s: CAN 1 routed to I2C1 pins and CAN2 to TMR01 pins\n",
-	       RTCAN_DRV_NAME);
-    }
 }
 
-static inline int mscan_get_config(unsigned long *addr,
-				   unsigned int *irq)
+static inline int mscan_get_config(unsigned long *addr, unsigned int *irq)
 {
 #if defined(CONFIG_PPC_MERGE) || LINUX_VERSION_CODE > KERNEL_VERSION(2,6,27)
-    /* Use Open Firmware device tree */
-    struct device_node *np = NULL;
-    unsigned int i;
-    int ret;
-
-    for (i = 0; i < RTCAN_MSCAN_DEVS; i++) {
-	struct resource r[2] = {};
-
-	np = of_find_compatible_node(np, NULL, "fsl,mpc5200-mscan");
-	if (np == NULL)
-	    np = of_find_compatible_node(np, NULL, "mpc5200-mscan");
-	if (np == NULL)
-	    break;
-	ret = of_address_to_resource(np, 0, &r[0]);
-	if (ret)
-	    return ret;
-	of_irq_to_resource(np, 0, &r[1]);
-	addr[i] = r[0].start;
-	irq[i] = r[1].start;
-	rtcan_mscan_count++;
-    }
+	/* Use Open Firmware device tree */
+	struct device_node *np = NULL;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < RTCAN_MSCAN_DEVS; i++) {
+		struct resource r[2] = {};
+
+		np = of_find_compatible_node(np, NULL, "fsl,mpc5200-mscan");
+		if (np == NULL)
+			np = of_find_compatible_node(np, NULL, "mpc5200-mscan");
+		if (np == NULL)
+			break;
+		ret = of_address_to_resource(np, 0, &r[0]);
+		if (ret)
+			return ret;
+		of_irq_to_resource(np, 0, &r[1]);
+		addr[i] = r[0].start;
+		irq[i] = r[1].start;
+		rtcan_mscan_count++;
+	}
 #else
-    addr[0] = MSCAN_CAN1_ADDR;
-    irq[0] = MSCAN_CAN1_IRQ;
-    addr[1] = MSCAN_CAN2_ADDR;
-    irq[1] = MSCAN_CAN2_IRQ;
-    rtcan_mscan_count = 2;
+	addr[0] = MSCAN_CAN1_ADDR;
+	irq[0] = MSCAN_CAN1_IRQ;
+	addr[1] = MSCAN_CAN2_ADDR;
+	irq[1] = MSCAN_CAN2_IRQ;
+	rtcan_mscan_count = 2;
 #endif
-    return 0;
+	return 0;
 }
 
 int __init rtcan_mscan_init_one(int idx, unsigned long addr, int irq)
 {
-    int ret;
-    struct rtcan_device *dev;
-    struct mscan_regs *regs;
+	int ret;
+	struct rtcan_device *dev;
+	struct mscan_regs *regs;
 
-    if ((dev = rtcan_dev_alloc(0, 0)) == NULL) {
-        return -ENOMEM;
-    }
+	if ((dev = rtcan_dev_alloc(0, 0)) == NULL) {
+		return -ENOMEM;
+	}
 
-    dev->ctrl_name = mscan_ctlr_name;
-    dev->board_name = mscan_board_name;
+	dev->ctrl_name = mscan_ctlr_name;
+	dev->board_name = mscan_board_name;
 
-    dev->can_sys_clock = mscan_clock;
+	dev->can_sys_clock = mscan_clock;
 
-    dev->base_addr = (unsigned long)ioremap(addr, MSCAN_SIZE);
-    if (dev->base_addr == 0) {
-	ret = -ENOMEM;
-	printk("ERROR! ioremap of %#lx failed\n", addr);
-	goto out_dev_free;
-    }
+	dev->base_addr = (unsigned long)ioremap(addr, MSCAN_SIZE);
+	if (dev->base_addr == 0) {
+		ret = -ENOMEM;
+		printk("ERROR! ioremap of %#lx failed\n", addr);
+		goto out_dev_free;
+	}
 
-    regs = (struct mscan_regs *)dev->base_addr;
+	regs = (struct mscan_regs *)dev->base_addr;
 
-    /* Enable MSCAN module. */
-    regs->canctl1 |= MSCAN_CANE;
-    udelay(100);
+	/* Enable MSCAN module. */
+	regs->canctl1 |= MSCAN_CANE;
+	udelay(100);
 
-    /* Set dummy state for following call */
-    dev->state = CAN_STATE_ACTIVE;
+	/* Set dummy state for following call */
+	dev->state = CAN_STATE_ACTIVE;
 
-    /* Enter reset mode */
-    rtcan_mscan_mode_stop(dev, NULL);
+	/* Enter reset mode */
+	rtcan_mscan_mode_stop(dev, NULL);
 
-    /* Give device an interface name (so that programs using this driver
-       don't need to know the device ID) */
+	/* Give device an interface name (so that programs using this driver
+	   don't need to know the device ID) */
 
-    strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+	strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
 
-    dev->hard_start_xmit = rtcan_mscan_start_xmit;
-    dev->do_set_mode = rtcan_mscan_set_mode;
-    dev->do_set_bit_time = rtcan_mscan_set_bit_time;
+	dev->hard_start_xmit = rtcan_mscan_start_xmit;
+	dev->do_set_mode = rtcan_mscan_set_mode;
+	dev->do_set_bit_time = rtcan_mscan_set_bit_time;
 
-    /* Register IRQ handler and pass device structure as arg */
-    ret = rtdm_irq_request(&dev->irq_handle, irq, 
-			   rtcan_mscan_interrupt,
-			   0, RTCAN_DRV_NAME, (void *)dev);
-    if (ret) {
-	printk("ERROR! rtdm_irq_request for IRQ %d failed\n", irq);
-	goto out_iounmap;
-    }
+	/* Register IRQ handler and pass device structure as arg */
+	ret = rtdm_irq_request(&dev->irq_handle, irq,
+			       rtcan_mscan_interrupt,
+			       0, RTCAN_DRV_NAME, (void *)dev);
+	if (ret) {
+		printk("ERROR! rtdm_irq_request for IRQ %d failed\n", irq);
+		goto out_iounmap;
+	}
 
-    mscan_chip_config(regs);
+	mscan_chip_config(regs);
 
-    /* Register RTDM device */
-    ret = rtcan_dev_register(dev);
-    if (ret) {
-	printk(KERN_ERR "ERROR while trying to register RTCAN device!\n");
-        goto out_irq_free;
-    }
+	/* Register RTDM device */
+	ret = rtcan_dev_register(dev);
+	if (ret) {
+		printk(KERN_ERR
+		       "ERROR while trying to register RTCAN device!\n");
+		goto out_irq_free;
+	}
 
-    rtcan_mscan_create_proc(dev);
+	rtcan_mscan_create_proc(dev);
 
-    /* Remember initialized devices */
-    rtcan_mscan_devs[idx] = dev;
+	/* Remember initialized devices */
+	rtcan_mscan_devs[idx] = dev;
 
-    printk("%s: %s driver loaded (port %d, base-addr 0x%lx irq %d)\n",
-	   dev->name, RTCAN_DRV_NAME, idx + 1, addr, irq);
+	printk("%s: %s driver loaded (port %d, base-addr 0x%lx irq %d)\n",
+	       dev->name, RTCAN_DRV_NAME, idx + 1, addr, irq);
 
-    return 0;
+	return 0;
 
 out_irq_free:
-    rtdm_irq_free(&dev->irq_handle);
+	rtdm_irq_free(&dev->irq_handle);
 
 out_iounmap:
-    /* Disable MSCAN module. */
-    regs->canctl1 &= ~MSCAN_CANE;
-    iounmap((void *)dev->base_addr);
+	/* Disable MSCAN module. */
+	regs->canctl1 &= ~MSCAN_CANE;
+	iounmap((void *)dev->base_addr);
 
 out_dev_free:
-    rtcan_dev_free(dev);
+	rtcan_dev_free(dev);
 
-    return ret;
+	return ret;
 
 }
 
 static void rtcan_mscan_exit(void)
 {
-    int i;
-    struct rtcan_device *dev;
+	int i;
+	struct rtcan_device *dev;
 
-    for (i = 0; i < rtcan_mscan_count; i++) {
+	for (i = 0; i < rtcan_mscan_count; i++) {
 
-	if ((dev = rtcan_mscan_devs[i]) == NULL)
-	    continue;
+		if ((dev = rtcan_mscan_devs[i]) == NULL)
+			continue;
 
-	printk("Unloading %s device %s\n", RTCAN_DRV_NAME, dev->name);
+		printk("Unloading %s device %s\n", RTCAN_DRV_NAME, dev->name);
 
-        rtcan_mscan_mode_stop(dev, NULL);
-	rtdm_irq_free(&dev->irq_handle);
-	rtcan_mscan_remove_proc(dev);
-	rtcan_dev_unregister(dev);
-	iounmap((void *)dev->base_addr);
-        rtcan_dev_free(dev);
-    }
+		rtcan_mscan_mode_stop(dev, NULL);
+		rtdm_irq_free(&dev->irq_handle);
+		rtcan_mscan_remove_proc(dev);
+		rtcan_dev_unregister(dev);
+		iounmap((void *)dev->base_addr);
+		rtcan_dev_free(dev);
+	}
 
 }
 
 static int __init rtcan_mscan_init(void)
 {
-    int i, err;
-    int unsigned long addr[RTCAN_MSCAN_DEVS];
-    int irq[RTCAN_MSCAN_DEVS];
-
-    if ((err = mscan_get_config(addr, irq)))
-	return err;
-    mscan_gpio_config();
-
-    for (i = 0; i < rtcan_mscan_count; i++) {
-	if (!port[i])
-	    continue;
-
-	err = rtcan_mscan_init_one(i, addr[i], irq[i]);
-	if (err) {
-	    rtcan_mscan_exit();
-	    return err;
+	int i, err;
+	int unsigned long addr[RTCAN_MSCAN_DEVS];
+	int irq[RTCAN_MSCAN_DEVS];
+
+	if ((err = mscan_get_config(addr, irq)))
+		return err;
+	mscan_gpio_config();
+
+	for (i = 0; i < rtcan_mscan_count; i++) {
+		if (!port[i])
+			continue;
+
+		err = rtcan_mscan_init_one(i, addr[i], irq[i]);
+		if (err) {
+			rtcan_mscan_exit();
+			return err;
+		}
 	}
-    }
 
-    return 0;
+	return 0;
 }
 
 module_init(rtcan_mscan_init);
diff --git a/ksrc/drivers/can/mscan/rtcan_mscan_proc.c b/ksrc/drivers/can/mscan/rtcan_mscan_proc.c
index c4e02da..5671cad 100644
--- a/ksrc/drivers/can/mscan/rtcan_mscan_proc.c
+++ b/ksrc/drivers/can/mscan/rtcan_mscan_proc.c
@@ -35,104 +35,104 @@
 static int rtcan_mscan_proc_regs(char *buf, char **start, off_t offset,
 				 int count, int *eof, void *data)
 {
-    struct rtcan_device *dev = (struct rtcan_device *)data;
-    struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
-    struct mpc5xxx_gpio *gpio = (struct mpc5xxx_gpio *)MPC5xxx_GPIO;
-    RTCAN_PROC_PRINT_VARS(80);
-
-    if (!RTCAN_PROC_PRINT("MSCAN registers at %p\n", regs))
-	goto done;
-    if (!RTCAN_PROC_PRINT("canctl0  0x%02x%s%s%s%s%s%s%s%s\n",
-			  regs->canctl0,
-			  (regs->canctl0 & MSCAN_RXFRM) ? " rxfrm" :"",
-			  (regs->canctl0 & MSCAN_RXACT) ? " rxact" :"",
-			  (regs->canctl0 & MSCAN_CSWAI) ? " cswai" :"",
-			  (regs->canctl0 & MSCAN_SYNCH) ? " synch" :"",
-			  (regs->canctl0 & MSCAN_TIME)  ? " time"  :"",
-			  (regs->canctl0 & MSCAN_WUPE)  ? " wupe"  :"",
-			  (regs->canctl0 & MSCAN_SLPRQ) ? " slprq" :"",
-			  (regs->canctl0 & MSCAN_INITRQ)? " initrq":"" ))
-	goto done;
-    if (!RTCAN_PROC_PRINT("canctl1  0x%02x%s%s%s%s%s%s%s\n",
-			  regs->canctl1,
-			  (regs->canctl1 & MSCAN_CANE)  ? " cane"  :"",
-			  (regs->canctl1 & MSCAN_CLKSRC)? " clksrc":"",
-			  (regs->canctl1 & MSCAN_LOOPB) ? " loopb" :"",
-			  (regs->canctl1 & MSCAN_LISTEN)? " listen":"",
-			  (regs->canctl1 & MSCAN_WUPM)  ? " wump"  :"",
-			  (regs->canctl1 & MSCAN_SLPAK) ? " slpak" :"",
-			  (regs->canctl1 & MSCAN_INITAK)? " initak":""))
-	goto done;
-    if (!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canbtr0 )) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canbtr1 )) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canrflg )) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canrier )) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(cantflg )) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(cantier )) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(cantarq )) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(cantaak )) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(cantbsel)) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidac )) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canrxerr)) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(cantxerr)) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar0)) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar1)) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar2)) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar3)) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr0)) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr1)) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr2)) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr3)) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar4)) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar5)) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar6)) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar7)) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr4)) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr5)) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr6)) |
-	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr7)))
-	goto done;
-
-    if (!RTCAN_PROC_PRINT("GPIO registers\n"))
-	goto done;
-    if (!RTCAN_PROC_PRINT("port_config 0x%08x %s\n", gpio->port_config,
-			  (gpio->port_config & 0x10000000 ?  
-			   "CAN1 on I2C1, CAN2 on TMR0/1 pins":
-			   (gpio->port_config & 0x70) == 0x10 ?
-			    "CAN1/2 on PSC2 pins": "MSCAN1/2 not routed")))
-	goto done;
-
-  done:
-    RTCAN_PROC_PRINT_DONE;
+	struct rtcan_device *dev = (struct rtcan_device *)data;
+	struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
+	struct mpc5xxx_gpio *gpio = (struct mpc5xxx_gpio *)MPC5xxx_GPIO;
+	RTCAN_PROC_PRINT_VARS(80);
+
+	if (!RTCAN_PROC_PRINT("MSCAN registers at %p\n", regs))
+		goto done;
+	if (!RTCAN_PROC_PRINT("canctl0  0x%02x%s%s%s%s%s%s%s%s\n",
+			      regs->canctl0,
+			      (regs->canctl0 & MSCAN_RXFRM) ? " rxfrm" :"",
+			      (regs->canctl0 & MSCAN_RXACT) ? " rxact" :"",
+			      (regs->canctl0 & MSCAN_CSWAI) ? " cswai" :"",
+			      (regs->canctl0 & MSCAN_SYNCH) ? " synch" :"",
+			      (regs->canctl0 & MSCAN_TIME)  ? " time"  :"",
+			      (regs->canctl0 & MSCAN_WUPE)  ? " wupe"  :"",
+			      (regs->canctl0 & MSCAN_SLPRQ) ? " slprq" :"",
+			      (regs->canctl0 & MSCAN_INITRQ)? " initrq":"" ))
+		goto done;
+	if (!RTCAN_PROC_PRINT("canctl1  0x%02x%s%s%s%s%s%s%s\n",
+			      regs->canctl1,
+			      (regs->canctl1 & MSCAN_CANE)  ? " cane"  :"",
+			      (regs->canctl1 & MSCAN_CLKSRC)? " clksrc":"",
+			      (regs->canctl1 & MSCAN_LOOPB) ? " loopb" :"",
+			      (regs->canctl1 & MSCAN_LISTEN)? " listen":"",
+			      (regs->canctl1 & MSCAN_WUPM)  ? " wump"  :"",
+			      (regs->canctl1 & MSCAN_SLPAK) ? " slpak" :"",
+			      (regs->canctl1 & MSCAN_INITAK)? " initak":""))
+		goto done;
+	if (!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canbtr0 )) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canbtr1 )) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canrflg )) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canrier )) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(cantflg )) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(cantier )) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(cantarq )) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(cantaak )) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(cantbsel)) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidac )) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canrxerr)) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(cantxerr)) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar0)) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar1)) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar2)) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar3)) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr0)) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr1)) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr2)) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr3)) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar4)) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar5)) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar6)) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar7)) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr4)) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr5)) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr6)) |
+	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr7)))
+		goto done;
+
+	if (!RTCAN_PROC_PRINT("GPIO registers\n"))
+		goto done;
+	if (!RTCAN_PROC_PRINT("port_config 0x%08x %s\n", gpio->port_config,
+			      (gpio->port_config & 0x10000000 ?
+			       "CAN1 on I2C1, CAN2 on TMR0/1 pins":
+			       (gpio->port_config & 0x70) == 0x10 ?
+			       "CAN1/2 on PSC2 pins": "MSCAN1/2 not routed")))
+		goto done;
+
+done:
+	RTCAN_PROC_PRINT_DONE;
 }
 
 int rtcan_mscan_create_proc(struct rtcan_device* dev)
 {
-    struct proc_dir_entry *proc_entry;
+	struct proc_dir_entry *proc_entry;
 
-    if (!dev->proc_root)
-	return -EINVAL;
+	if (!dev->proc_root)
+		return -EINVAL;
 
-    proc_entry = create_proc_entry("registers", S_IFREG | S_IRUGO | S_IWUSR,
-                                   dev->proc_root);
-    if (!proc_entry)
-        goto error;
-    proc_entry->read_proc = rtcan_mscan_proc_regs;
-    proc_entry->data = dev;
+	proc_entry = create_proc_entry("registers", S_IFREG | S_IRUGO | S_IWUSR,
+				       dev->proc_root);
+	if (!proc_entry)
+		goto error;
+	proc_entry->read_proc = rtcan_mscan_proc_regs;
+	proc_entry->data = dev;
 
-    return 0;
+	return 0;
 
-  error:
-    printk("%s: unable to create /proc entries for MSCAN\n", dev->name);
-    return -1;
+error:
+	printk("%s: unable to create /proc entries for MSCAN\n", dev->name);
+	return -1;
 }
 
 void rtcan_mscan_remove_proc(struct rtcan_device* dev)
 {
-    if (!dev->proc_root)
-	return;
+	if (!dev->proc_root)
+		return;
 
-    remove_proc_entry("registers", dev->proc_root);
+	remove_proc_entry("registers", dev->proc_root);
 }
 
 #else /* !CONFIG_XENO_DRIVERS_CAN_DEBUG */
@@ -143,6 +143,6 @@ void rtcan_mscan_remove_proc(struct rtcan_device* dev)
 
 int rtcan_mscan_create_proc(struct rtcan_device* dev)
 {
-    return 0;
+	return 0;
 }
 #endif	/* CONFIG_XENO_DRIVERS_CAN_DEBUG */
diff --git a/ksrc/drivers/can/mscan/rtcan_mscan_regs.h b/ksrc/drivers/can/mscan/rtcan_mscan_regs.h
index e6fd7ed..b4652f5 100644
--- a/ksrc/drivers/can/mscan/rtcan_mscan_regs.h
+++ b/ksrc/drivers/can/mscan/rtcan_mscan_regs.h
@@ -39,12 +39,12 @@ static inline void __iomem *mpc5xxx_gpio_find_and_map(void)
 	struct device_node *ofn;
 	ofn = of_find_compatible_node(NULL, NULL, "mpc5200-gpio");
 	if (!ofn)
-	    ofn = of_find_compatible_node(NULL, NULL, "fsl,mpc5200-gpio");
+		ofn = of_find_compatible_node(NULL, NULL, "fsl,mpc5200-gpio");
 	return ofn ? of_iomap(ofn, 0) : NULL;
 }
-#define MPC5xxx_GPIO    mpc5xxx_gpio_find_and_map()
+#define MPC5xxx_GPIO	mpc5xxx_gpio_find_and_map()
 #else
-#define MPC5xxx_GPIO    mpc52xx_find_and_map("mpc5200-gpio")
+#define MPC5xxx_GPIO	mpc52xx_find_and_map("mpc5200-gpio")
 #endif
 #define mpc5xxx_gpio	mpc52xx_gpio
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
@@ -63,7 +63,7 @@ static inline void __iomem *mpc5xxx_gpio_find_and_map(void)
 
 #define MSCAN_CAN1_ADDR	(MSCAN_MBAR + 0x0900) /* MSCAN Module 1 */
 #define MSCAN_CAN2_ADDR	(MSCAN_MBAR + 0x0980) /* MSCAN Module 2 */
-#define MSCAN_SIZE      0x80
+#define MSCAN_SIZE	0x80
 
 /* MSCAN control register 0 (CANCTL0) bits */
 #define MSCAN_RXFRM	0x80
@@ -202,35 +202,37 @@ struct mscan_regs {
 
 /* Message type access macros.
  */
-#define MSCAN_BUF_STD_RTR       0x10
-#define MSCAN_BUF_EXT_RTR       0x01
-#define MSCAN_BUF_EXTENDED      0x08
+#define MSCAN_BUF_STD_RTR	0x10
+#define MSCAN_BUF_EXT_RTR	0x01
+#define MSCAN_BUF_EXTENDED	0x08
 
-#define MSCAN_IDAM1	0x20
+#define MSCAN_IDAM1		0x20
 /* Value for the interrupt enable register */
-#define MSCAN_RIER 	(MSCAN_OVRIE | \
-			 MSCAN_RXFIE | \
-			 MSCAN_WUPIF | \
-			 MSCAN_CSCIE | \
-			 MSCAN_RSTATE0 | \
-			 MSCAN_RSTATE1 | \
-			 MSCAN_TSTATE0 | \
-			 MSCAN_TSTATE1)
-
-#define BTR0_BRP_MASK 	 	0x3f
-#define BTR0_SJW_SHIFT 	 	6
-#define BTR0_SJW_MASK 	 	(0x3 << BTR0_SJW_SHIFT)
-
-#define BTR1_TSEG1_MASK	 	0xf
-#define BTR1_TSEG2_SHIFT  	4
-#define BTR1_TSEG2_MASK  	(0x7 << BTR1_TSEG2_SHIFT)
-#define BTR1_SAM_SHIFT 	  	7
-
-#define BTR0_SET_BRP(brp) 	(((brp) - 1) & BTR0_BRP_MASK)
-#define BTR0_SET_SJW(sjw) 	((((sjw) - 1) << BTR0_SJW_SHIFT) & BTR0_SJW_MASK)
-
-#define BTR1_SET_TSEG1(tseg1) 	(((tseg1) - 1) & BTR1_TSEG1_MASK)
-#define BTR1_SET_TSEG2(tseg2) 	((((tseg2) - 1) << BTR1_TSEG2_SHIFT) & BTR1_TSEG2_MASK)
-#define BTR1_SET_SAM(sam) 	(((sam) & 1) << BTR1_SAM_SHIFT)
+#define MSCAN_RIER		(MSCAN_OVRIE |		\
+				 MSCAN_RXFIE |		\
+				 MSCAN_WUPIF |		\
+				 MSCAN_CSCIE |		\
+				 MSCAN_RSTATE0 |	\
+				 MSCAN_RSTATE1 |	\
+				 MSCAN_TSTATE0 |	\
+				 MSCAN_TSTATE1)
+
+#define BTR0_BRP_MASK		0x3f
+#define BTR0_SJW_SHIFT		6
+#define BTR0_SJW_MASK		(0x3 << BTR0_SJW_SHIFT)
+
+#define BTR1_TSEG1_MASK		0xf
+#define BTR1_TSEG2_SHIFT	4
+#define BTR1_TSEG2_MASK		(0x7 << BTR1_TSEG2_SHIFT)
+#define BTR1_SAM_SHIFT		7
+
+#define BTR0_SET_BRP(brp)	(((brp) - 1) & BTR0_BRP_MASK)
+#define BTR0_SET_SJW(sjw)	((((sjw) - 1) << BTR0_SJW_SHIFT) & \
+				 BTR0_SJW_MASK)
+
+#define BTR1_SET_TSEG1(tseg1)	(((tseg1) - 1) & BTR1_TSEG1_MASK)
+#define BTR1_SET_TSEG2(tseg2)	((((tseg2) - 1) << BTR1_TSEG2_SHIFT) & \
+				 BTR1_TSEG2_MASK)
+#define BTR1_SET_SAM(sam)	(((sam) & 1) << BTR1_SAM_SHIFT)
 
 #endif /* __RTCAN_MSCAN_REGS_H_ */
-- 
1.6.2.5


