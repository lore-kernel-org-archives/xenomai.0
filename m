Message-ID: <44EC9E02.3090201@domain.hid>
Date: Wed, 23 Aug 2006 20:27:14 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030502040800080603030002"
Subject: [Xenomai-core] [PATCH] Various fixes and improvements for
	RT-Socket-CAN
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------030502040800080603030002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

attached is a patch for the RT-Socket-CAN RTDM driver providing:

   * ksrc/drivers/can/rtcan_dev.c, ksrc/drivers/can/rtcan_dev.h,
   ksrc/drivers/can/rtcan_modules.c: Suppress handling of refcount
   if module support is not enabled or modules cannot be unloaded.

   * ksrc/drivers/can/mscan/rtcan_mscan.c,
   ksrc/drivers/can/mscan/rtcan_mscan_proc.c,
   ksrc/drivers/can/mscan/rtcan_mscan_regs.h: Make the MSCAN driver
   work on Linux 2.6. We now use our own set of MSCAN register
   definitions because they differ between 2.4 and 2.6 (prefix).

   * scripts/Modules.frag: bug fix for making PEAK device drivers.

Note that it adds the file ksrc/drivers/can/mscan/rtcan_mscan_regs.h !

Wolfgang.

--------------030502040800080603030002
Content-Type: text/x-patch;
 name="xenomai-rtsocketcan4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtsocketcan4.patch"

+ diff -u xenomai/ChangeLog.ORIG xenomai/ChangeLog
--- xenomai/ChangeLog.ORIG	2006-08-23 19:20:42.000000000 +0200
+++ xenomai/ChangeLog	2006-08-23 19:21:50.000000000 +0200
@@ -1,3 +1,17 @@
+2006-08-23  Wolfgang Grandegger <wg@domain.hid>
+
+	* ksrc/drivers/can/rtcan_dev.c, ksrc/drivers/can/rtcan_dev.h,
+	ksrc/drivers/can/rtcan_modules.c: Suppress handling of refcount 
+	if module support is not enabled or modules cannot be unloaded.
+
+	* ksrc/drivers/can/mscan/rtcan_mscan.c,
+	ksrc/drivers/can/mscan/rtcan_mscan_proc.c,
+	ksrc/drivers/can/mscan/rtcan_mscan_regs.h: Make the MSCAN driver
+	work on Linux 2.6. We now use our own set of MSCAN register
+	definitions because they differ between 2.4 and 2.6 (prefix).
+	
+	* scripts/Modules.frag: bug fix for making PEAK device drivers.
+
 2006-08-23  Philippe Gerum  <rpm@xenomai.org>
 
 	* include/asm-i386/features.h (xeno_x86_features_check): Try
+ diff -u xenomai/ksrc/drivers/can/mscan/rtcan_mscan.c.ORIG xenomai/ksrc/drivers/can/mscan/rtcan_mscan.c
--- xenomai/ksrc/drivers/can/mscan/rtcan_mscan.c.ORIG	2006-08-22 20:40:29.000000000 +0200
+++ xenomai/ksrc/drivers/can/mscan/rtcan_mscan.c	2006-08-22 20:41:52.000000000 +0200
@@ -29,7 +29,6 @@
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
-#include <asm/mpc5xxx.h>
 #include <asm/ppcboot.h>
 
 #include <rtdm/rtdm_driver.h>
@@ -38,6 +37,7 @@
 #include <rtdm/rtcan.h>
 #include "rtcan_dev.h"
 #include "rtcan_raw.h"
+#include "rtcan_mscan_regs.h"
 
 extern int rtcan_mscan_create_proc(struct rtcan_device* dev);
 extern void rtcan_mscan_remove_proc(struct rtcan_device* dev);
@@ -49,39 +49,6 @@
 static char *mscan_ctlr_name  = "MSCAN-MPC5200";
 static char *mscan_board_name = "unkown";
 
-/** Value for the interrupt enable register */
-#define MSCAN_RIER                  (MPC5xxx_MSCAN_OVRIE | \
-				     MPC5xxx_MSCAN_RXFIE | \
-				     MPC5xxx_MSCAN_WUPIF | \
-				     MPC5xxx_MSCAN_CSCIE | \
-				     MPC5xxx_MSCAN_RSTATE0 | \
-				     MPC5xxx_MSCAN_RSTATE1 | \
-				     MPC5xxx_MSCAN_TSTATE0 | \
-				     MPC5xxx_MSCAN_TSTATE1)
-
-#define BTR0_BRP_MASK    0x3f
-#define BTR0_SJW_SHIFT   6
-#define BTR0_SJW_MASK    (0x3 << BTR0_SJW_SHIFT)
-
-#define BTR1_TSEG1_MASK  0xf
-#define BTR1_TSEG2_SHIFT 4
-#define BTR1_TSEG2_MASK  (0x7 << BTR1_TSEG2_SHIFT)
-#define BTR1_SAM_SHIFT   7
-
-#define BTR0_SET_BRP(brp)     (((brp) - 1) & BTR0_BRP_MASK)
-#define BTR0_SET_SJW(sjw)     ((((sjw) - 1) << BTR0_SJW_SHIFT) & BTR0_SJW_MASK)
-
-#define BTR1_SET_TSEG1(tseg1) (((tseg1) - 1) & BTR1_TSEG1_MASK)
-#define BTR1_SET_TSEG2(tseg2) ((((tseg2) - 1) << BTR1_TSEG2_SHIFT) & BTR1_TSEG2_MASK)
-#define BTR1_SET_SAM(sam)     (((sam) & 1) << BTR1_SAM_SHIFT)
-
-/* Message type access macros.
- */
-#define MSCAN_BUF_STD_RTR       0x10
-#define MSCAN_BUF_EXT_RTR       0x01
-#define MSCAN_BUF_EXTENDED      0x08
-#define MSCAN_TX_BUFS           3
-
 MODULE_AUTHOR("Wolfgang Grandegger <wg@domain.hid>");
 MODULE_DESCRIPTION("RT-Socket-CAN driver for MSCAN-MPC2500");
 MODULE_SUPPORTED_DEVICE("MSCAN-MPC5200 CAN controller");
@@ -143,7 +110,7 @@
     int i;
     unsigned char size;
     struct rtcan_rb_frame *frame = &skb->rb_frame;
-    struct mpc5xxx_mscan *regs = (struct mpc5xxx_mscan *)dev->base_addr;
+    struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
 
     skb->rb_frame_size = EMPTY_RB_FRAME_SIZE;
 
@@ -201,7 +168,7 @@
 {
     u8 rstat, tstat;
     struct rtcan_rb_frame *frame = &skb->rb_frame;
-    struct mpc5xxx_mscan *regs = (struct mpc5xxx_mscan *)dev->base_addr;
+    struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
 
     skb->rb_frame_size = EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
 
@@ -210,16 +177,16 @@
 
     memset(&frame->data[0], 0, frame->can_dlc);
 
-    if ((r_status & MPC5xxx_MSCAN_OVRIF)) {
+    if ((r_status & MSCAN_OVRIF)) {
 	frame->can_id |= CAN_ERR_CRTL;
 	frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-    } else if ((r_status & (MPC5xxx_MSCAN_CSCIF))) {
+    } else if ((r_status & (MSCAN_CSCIF))) {
 	
-	rstat = (r_status & (MPC5xxx_MSCAN_TSTAT0 | 
-			     MPC5xxx_MSCAN_TSTAT1)) >> 2 & 0x3;  
-	tstat = (r_status & (MPC5xxx_MSCAN_RSTAT0 | 
-			     MPC5xxx_MSCAN_RSTAT1)) >> 4 & 0x3;  
+	rstat = (r_status & (MSCAN_TSTAT0 | 
+			     MSCAN_TSTAT1)) >> 2 & 0x3;  
+	tstat = (r_status & (MSCAN_RSTAT0 | 
+			     MSCAN_RSTAT1)) >> 4 & 0x3;  
 	dev->state = mscan_stat_map[max(rstat, tstat)];
 
 	switch (dev->state) {
@@ -266,14 +233,14 @@
     nanosecs_abs_t timestamp = rtdm_clock_read();
     struct rtcan_skb skb;
     struct rtcan_device *dev;
-    struct mpc5xxx_mscan *regs;
+    struct mscan_regs *regs;
     u8 t_status, r_status;
     int recv_lock_free = 1;
     int ret = RTDM_IRQ_NONE;
 
 
     dev = (struct rtcan_device *)rtdm_irq_get_arg(irq_handle, void);
-    regs = (struct mpc5xxx_mscan *)dev->base_addr;
+    regs = (struct mscan_regs *)dev->base_addr;
 
     rtdm_lock_get(&dev->device_lock);
 
@@ -283,23 +250,23 @@
     ret = RTDM_IRQ_HANDLED;
 
     /* Transmit Interrupt? */
-    if ((t_status & MPC5xxx_MSCAN_TXE)) {
+    if ((t_status & MSCAN_TXE)) {
 	/* Disable transmit interrupt here or it will
 	 * constantly be pending.
 	 */
-	regs->cantier &= ~MPC5xxx_MSCAN_TXIE;
+	regs->cantier &= ~MSCAN_TXIE;
 
 	/* Wake up a sender */
 	rtdm_sem_up(&dev->tx_sem);
     }
 
     /* Wakeup interrupt?  */
-    if ((r_status & MPC5xxx_MSCAN_WUPIF)) {
+    if ((r_status & MSCAN_WUPIF)) {
 	rtdm_printk("WUPIF interrupt\n");
     }
 
     /* Receive Interrupt? */
-    if ((r_status & MPC5xxx_MSCAN_RXF)) {
+    if ((r_status & MSCAN_RXF)) {
 	
 	/* Read out HW registers */
 	rtcan_mscan_rx_interrupt(dev, &skb);
@@ -324,7 +291,7 @@
     }
 
     /* Error Interrupt? */
-    if ((r_status & (MPC5xxx_MSCAN_CSCIF | MPC5xxx_MSCAN_OVRIF))) {
+    if ((r_status & (MSCAN_CSCIF | MSCAN_OVRIF))) {
 	/* Check error condition and fill error frame */
 	rtcan_mscan_err_interrupt(dev, &skb, r_status);
 
@@ -345,8 +312,8 @@
 	regs->canrflg = r_status;
 
     if (!recv_lock_free) {
-        rtdm_lock_put(&socket_lock);
-        rtdm_lock_put(&recv_list_lock);
+        rtdm_lock_put(&rtcan_socket_lock);
+        rtdm_lock_put(&rtcan_recv_list_lock);
     }
     rtdm_lock_put(&dev->device_lock);
 
@@ -381,8 +348,8 @@
     int ret = 0;
     int rinit = 0;
     can_state_t state;
-    volatile struct mpc5xxx_mscan *regs = 
-	(struct mpc5xxx_mscan *)dev->base_addr;
+    volatile struct mscan_regs *regs = 
+	(struct mscan_regs *)dev->base_addr;
     u8 reg;
 
     state = dev->state;
@@ -391,12 +358,12 @@
         goto out;
 
     /* Switch to sleep mode */
-    regs->canctl0 |= MPC5xxx_MSCAN_SLPRQ;
-    regs->canctl0 |= MPC5xxx_MSCAN_INITRQ;
+    regs->canctl0 |= MSCAN_SLPRQ;
+    regs->canctl0 |= MSCAN_INITRQ;
     
     reg = regs->canctl1;
-    while (!(reg & MPC5xxx_MSCAN_SLPAK) ||
-	   !(reg & MPC5xxx_MSCAN_INITAK)) {
+    while (!(reg & MSCAN_SLPAK) ||
+	   !(reg & MSCAN_INITAK)) {
         if (likely(lock_ctx != NULL))
             rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
         /* Busy sleep 1 microsecond */
@@ -440,8 +407,8 @@
 {
     int ret = 0, retries = 0;
     can_state_t state;
-    volatile struct mpc5xxx_mscan *regs = 
-	(struct mpc5xxx_mscan *)dev->base_addr;
+    volatile struct mscan_regs *regs = 
+	(struct mscan_regs *)dev->base_addr;
 
     /* We won't forget that state in the device structure is volatile and
      * access to it will not be optimized by the compiler. So ... */
@@ -461,21 +428,21 @@
 	rtdm_sem_init(&dev->tx_sem, MSCAN_TX_BUFS);
 
 	if ((dev->ctrl_mode & CAN_CTRLMODE_LISTENONLY)) {
-	    regs->canctl1 |= MPC5xxx_MSCAN_LISTEN;
+	    regs->canctl1 |= MSCAN_LISTEN;
 	} else {
-	    regs->canctl1 &= ~MPC5xxx_MSCAN_LISTEN;
+	    regs->canctl1 &= ~MSCAN_LISTEN;
 	}
 	if ((dev->ctrl_mode & CAN_CTRLMODE_LOOPBACK)) {
-	    regs->canctl1 |= MPC5xxx_MSCAN_LOOPB;
+	    regs->canctl1 |= MSCAN_LOOPB;
 	} else {
-	    regs->canctl1 &= ~MPC5xxx_MSCAN_LOOPB;
+	    regs->canctl1 &= ~MSCAN_LOOPB;
 	}
 
 	/* Switch to normal mode */
-	regs->canctl0 &= ~MPC5xxx_MSCAN_INITRQ;
-	regs->canctl0 &= ~MPC5xxx_MSCAN_SLPRQ;
-	while ((regs->canctl1 & MPC5xxx_MSCAN_INITAK) ||
-	       (regs->canctl1 & MPC5xxx_MSCAN_SLPAK)) {
+	regs->canctl0 &= ~MSCAN_INITRQ;
+	regs->canctl0 &= ~MSCAN_SLPRQ;
+	while ((regs->canctl1 & MSCAN_INITAK) ||
+	       (regs->canctl1 & MSCAN_SLPAK)) {
 	    if (likely(lock_ctx != NULL))
 		rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
 	    /* Busy sleep 1 microsecond */
@@ -513,7 +480,7 @@
 			     struct can_bittime *bit_time,
 			     rtdm_lockctx_t *lock_ctx)
 {
-    struct mpc5xxx_mscan *regs = (struct mpc5xxx_mscan *)dev->base_addr; 
+    struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr; 
     u8 btr0, btr1;
 	
     switch (bit_time->type) {
@@ -549,7 +516,7 @@
 {
     int ret = 0, retries = 0;
     can_state_t state;
-    struct mpc5xxx_mscan *regs = (struct mpc5xxx_mscan *)dev->base_addr; 
+    struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr; 
 
     switch (mode) {
 
@@ -584,8 +551,8 @@
 	 * the meaning of interrupts ...) */
 	regs->canrier = 0;
 	regs->cantier = 0;
-	regs->canctl0 |= MPC5xxx_MSCAN_SLPRQ /*| MPC5xxx_MSCAN_INITRQ*/ | MPC5xxx_MSCAN_WUPE;
-	while (!(regs->canctl1 & MPC5xxx_MSCAN_SLPAK)) {
+	regs->canctl0 |= MSCAN_SLPRQ /*| MSCAN_INITRQ*/ | MSCAN_WUPE;
+	while (!(regs->canctl1 & MSCAN_SLPAK)) {
 	    rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
 	    /* Busy sleep 1 microsecond */
 	    rtdm_task_busy_sleep(1000);
@@ -594,8 +561,8 @@
 		break;
 	}
 	rtdm_printk("Fallen asleep after %d tries.\n", retries);
-	regs->canctl0 &= ~MPC5xxx_MSCAN_INITRQ;
-	while ((regs->canctl1 & MPC5xxx_MSCAN_INITAK)) {
+	regs->canctl0 &= ~MSCAN_INITRQ;
+	while ((regs->canctl1 & MSCAN_INITAK)) {
 	    rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
 	    /* Busy sleep 1 microsecond */
 	    rtdm_task_busy_sleep(1000);
@@ -604,7 +571,7 @@
 		break;
 	}
 	rtdm_printk("Back to normal after %d tries.\n", retries);
-	regs->canrier = MPC5xxx_MSCAN_WUPIE;
+	regs->canrier = MSCAN_WUPIE;
 	
     mode_sleep_out:
 	dev->state = state;
@@ -636,7 +603,7 @@
     /* Content of frame information register */
     unsigned char   dlc;
 
-    struct mpc5xxx_mscan *regs = (struct mpc5xxx_mscan *)dev->base_addr;
+    struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
 
     /* Find an empty TX buffer. */
     for (buf = 0; buf < MSCAN_TX_BUFS; buf++) {
@@ -718,12 +685,12 @@
  *
  *  @param[in] dev Device ID of the controller to be configured
  */
-static inline void __init mscan_chip_config(struct mpc5xxx_mscan *regs)
+static inline void __init mscan_chip_config(struct mscan_regs *regs)
 {
     /* Choose IP bus as clock source.
      */
-    regs->canctl1 |= MPC5xxx_MSCAN_CLKSRC;
-    regs->canctl1 &= ~MPC5xxx_MSCAN_LISTEN;
+    regs->canctl1 |= MSCAN_CLKSRC;
+    regs->canctl1 &= ~MSCAN_LISTEN;
 
     /* Configure MSCAN to accept all incoming messages.
      */
@@ -735,7 +702,7 @@
     regs->canidar6 = regs->canidar7 = 0x00;
     regs->canidmr4 = regs->canidmr5 = 0xFF;
     regs->canidmr6 = regs->canidmr7 = 0xFF;
-    regs->canidac &= ~(MPC5xxx_MSCAN_IDAM0 | MPC5xxx_MSCAN_IDAM1);
+    regs->canidac &= ~(MSCAN_IDAM0 | MSCAN_IDAM1);
 }
 
 static inline void __init mscan_gpio_config(void)
@@ -779,16 +746,16 @@
     unsigned long addr;
     struct rtcan_device *dev;
     struct rtcan_priv *priv;
-    struct mpc5xxx_mscan *regs;
+    struct mscan_regs *regs;
 
     switch (port[idx]) {
     case 1:
-	addr = MPC5xxx_MSCAN1;
-	irq = MPC5xxx_CAN1_IRQ;
+	addr = MSCAN_CAN1_ADDR;
+	irq = MSCAN_CAN1_IRQ;
 	break;
     case 2:
-	addr = MPC5xxx_MSCAN2;
-	irq = MPC5xxx_CAN2_IRQ;
+	addr = MSCAN_CAN2_ADDR;
+	irq = MSCAN_CAN2_IRQ;
 	break;
     default:
 	return 0;
@@ -805,10 +772,10 @@
 
     priv = dev->priv;
     dev->base_addr = addr;
-    regs = (struct mpc5xxx_mscan *)dev->base_addr;
+    regs = (struct mscan_regs *)dev->base_addr;
     
     /* Enable MSCAN module. */
-    regs->canctl1 |= MPC5xxx_MSCAN_CANE;
+    regs->canctl1 |= MSCAN_CANE;
     udelay(100);
     
     /* Set dummy state for following call */
@@ -862,7 +829,7 @@
 
  out_dev_free:
     /* Disable MSCAN module. */
-    regs->canctl1 &= ~MPC5xxx_MSCAN_CANE;
+    regs->canctl1 &= ~MSCAN_CANE;
     rtcan_dev_free(dev);
 
     return ret;
+ diff -u xenomai/ksrc/drivers/can/mscan/rtcan_mscan_proc.c.ORIG xenomai/ksrc/drivers/can/mscan/rtcan_mscan_proc.c
--- xenomai/ksrc/drivers/can/mscan/rtcan_mscan_proc.c.ORIG	2006-08-22 20:40:29.000000000 +0200
+++ xenomai/ksrc/drivers/can/mscan/rtcan_mscan_proc.c	2006-08-22 20:41:52.000000000 +0200
@@ -20,13 +20,13 @@
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
-#include <asm/mpc5xxx.h>
 
 #include <rtdm/rtdm_driver.h>
 
 /* CAN device profile */
 #include "rtcan_dev.h"
 #include "rtcan_internal.h"
+#include "rtcan_mscan_regs.h"
 
 #define MSCAN_REG_ARGS(reg) "%-8s 0x%02x\n", #reg, (int)((regs)->reg) & 0xff
 
@@ -36,7 +36,7 @@
 				 int count, int *eof, void *data)
 {
     struct rtcan_device *dev = (struct rtcan_device *)data;
-    struct mpc5xxx_mscan *regs = (struct mpc5xxx_mscan *)dev->base_addr;
+    struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
     struct mpc5xxx_gpio *gpio = (struct mpc5xxx_gpio *)MPC5xxx_GPIO;
     RTCAN_PROC_PRINT_VARS(80);
 
@@ -44,24 +44,24 @@
 	goto done;
     if (!RTCAN_PROC_PRINT("canctl0  0x%02x%s%s%s%s%s%s%s%s\n",
 			  regs->canctl0,
-			  (regs->canctl0 & MPC5xxx_MSCAN_RXFRM) ? " rxfrm" :"",
-			  (regs->canctl0 & MPC5xxx_MSCAN_RXACT) ? " rxact" :"",
-			  (regs->canctl0 & MPC5xxx_MSCAN_CSWAI) ? " cswai" :"",
-			  (regs->canctl0 & MPC5xxx_MSCAN_SYNCH) ? " synch" :"",
-			  (regs->canctl0 & MPC5xxx_MSCAN_TIME)  ? " time"  :"",
-			  (regs->canctl0 & MPC5xxx_MSCAN_WUPE)  ? " wupe"  :"",
-			  (regs->canctl0 & MPC5xxx_MSCAN_SLPRQ) ? " slprq" :"",
-			  (regs->canctl0 & MPC5xxx_MSCAN_INITRQ)? " initrq":"" ))
+			  (regs->canctl0 & MSCAN_RXFRM) ? " rxfrm" :"",
+			  (regs->canctl0 & MSCAN_RXACT) ? " rxact" :"",
+			  (regs->canctl0 & MSCAN_CSWAI) ? " cswai" :"",
+			  (regs->canctl0 & MSCAN_SYNCH) ? " synch" :"",
+			  (regs->canctl0 & MSCAN_TIME)  ? " time"  :"",
+			  (regs->canctl0 & MSCAN_WUPE)  ? " wupe"  :"",
+			  (regs->canctl0 & MSCAN_SLPRQ) ? " slprq" :"",
+			  (regs->canctl0 & MSCAN_INITRQ)? " initrq":"" ))
 	goto done;
     if (!RTCAN_PROC_PRINT("canctl1  0x%02x%s%s%s%s%s%s%s\n",
 			  regs->canctl1,
-			  (regs->canctl1 & MPC5xxx_MSCAN_CANE)  ? " cane"  :"",
-			  (regs->canctl1 & MPC5xxx_MSCAN_CLKSRC)? " clksrc":"",
-			  (regs->canctl1 & MPC5xxx_MSCAN_LOOPB) ? " loopb" :"",
-			  (regs->canctl1 & MPC5xxx_MSCAN_LISTEN)? " listen":"",
-			  (regs->canctl1 & MPC5xxx_MSCAN_WUPM)  ? " wump"  :"",
-			  (regs->canctl1 & MPC5xxx_MSCAN_SLPAK) ? " slpak" :"",
-			  (regs->canctl1 & MPC5xxx_MSCAN_INITAK)? " initak":""))
+			  (regs->canctl1 & MSCAN_CANE)  ? " cane"  :"",
+			  (regs->canctl1 & MSCAN_CLKSRC)? " clksrc":"",
+			  (regs->canctl1 & MSCAN_LOOPB) ? " loopb" :"",
+			  (regs->canctl1 & MSCAN_LISTEN)? " listen":"",
+			  (regs->canctl1 & MSCAN_WUPM)  ? " wump"  :"",
+			  (regs->canctl1 & MSCAN_SLPAK) ? " slpak" :"",
+			  (regs->canctl1 & MSCAN_INITAK)? " initak":""))
 	goto done;
     if (!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canbtr0 )) |
 	!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canbtr1 )) |
+ diff -u xenomai/ksrc/drivers/can/mscan/rtcan_mscan_regs.h.ORIG xenomai/ksrc/drivers/can/mscan/rtcan_mscan_regs.h
--- xenomai/ksrc/drivers/can/mscan/rtcan_mscan_regs.h.ORIG	2006-08-22 20:41:52.000000000 +0200
+++ xenomai/ksrc/drivers/can/mscan/rtcan_mscan_regs.h	2006-08-22 20:41:52.000000000 +0200
@@ -0,0 +1,214 @@
+/*
+ * Copyright (C) 2006 Wolfgang Grandegger <wg@domain.hid>
+ *
+ * Based on linux-2.4.25/include/asm-ppc/mpc5xxx.h
+ * Prototypes, etc. for the Motorola MPC5xxx embedded cpu chips
+ *
+ * Author: Dale Farnsworth <dfarnsworth@domain.hid>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef __RTCAN_MSCAN_REGS_H_
+#define __RTCAN_MSCAN_REGS_H_
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
+#include <asm/mpc5xxx.h>
+#define MSCAN_MBAR	MPC5xxx_MBAR
+#define MSCAN_CAN1_IRQ	MPC5xxx_CAN1_IRQ
+#define MSCAN_CAN2_IRQ	MPC5xxx_CAN2_IRQ
+#else
+#include <asm/mpc52xx.h>
+#define MSCAN_MBAR	MPC52xx_MBAR
+#define MSCAN_CAN1_IRQ	MPC52xx_MSCAN1_IRQ
+#define MSCAN_CAN2_IRQ	MPC52xx_MSCAN2_IRQ
+#define MPC5xxx_GPIO	MPC52xx_GPIO_OFFSET 
+#define mpc5xxx_gpio	mpc52xx_gpio
+#endif
+
+#define MSCAN_CAN1_ADDR	(MSCAN_MBAR + 0x0900) /* MSCAN Module 1 */
+#define MSCAN_CAN2_ADDR	(MSCAN_MBAR + 0x0980) /* MSCAN Module 2 */
+
+/* MSCAN control register 0 (CANCTL0) bits */
+#define MSCAN_RXFRM	0x80
+#define MSCAN_RXACT	0x40
+#define MSCAN_CSWAI	0x20
+#define MSCAN_SYNCH	0x10
+#define MSCAN_TIME	0x08
+#define MSCAN_WUPE	0x04
+#define MSCAN_SLPRQ	0x02
+#define MSCAN_INITRQ	0x01
+
+/* MSCAN control register 1 (CANCTL1) bits */
+#define MSCAN_CANE	0x80
+#define MSCAN_CLKSRC	0x40
+#define MSCAN_LOOPB	0x20
+#define MSCAN_LISTEN	0x10
+#define MSCAN_WUPM	0x04
+#define MSCAN_SLPAK	0x02
+#define MSCAN_INITAK	0x01
+
+/* MSCAN receiver flag register (CANRFLG) bits */
+#define MSCAN_WUPIF	0x80
+#define MSCAN_CSCIF	0x40
+#define MSCAN_RSTAT1	0x20
+#define MSCAN_RSTAT0	0x10
+#define MSCAN_TSTAT1	0x08
+#define MSCAN_TSTAT0	0x04
+#define MSCAN_OVRIF	0x02
+#define MSCAN_RXF	0x01
+
+/* MSCAN receiver interrupt enable register (CANRIER) bits */
+#define MSCAN_WUPIE	0x80
+#define MSCAN_CSCIE	0x40
+#define MSCAN_RSTATE1	0x20
+#define MSCAN_RSTATE0	0x10
+#define MSCAN_TSTATE1	0x08
+#define MSCAN_TSTATE0	0x04
+#define MSCAN_OVRIE	0x02
+#define MSCAN_RXFIE	0x01
+
+/* MSCAN transmitter flag register (CANTFLG) bits */
+#define MSCAN_TXE2	0x04
+#define MSCAN_TXE1	0x02
+#define MSCAN_TXE0	0x01
+#define MSCAN_TXE	(MSCAN_TXE2 | MSCAN_TXE1 | MSCAN_TXE0)
+
+/* MSCAN transmitter interrupt enable register (CANTIER) bits */
+#define MSCAN_TXIE2	0x04
+#define MSCAN_TXIE1	0x02
+#define MSCAN_TXIE0	0x01
+#define MSCAN_TXIE	(MSCAN_TXIE2 | MSCAN_TXIE1 | MSCAN_TXIE0)
+
+/* MSCAN transmitter message abort request (CANTARQ) bits */
+#define MSCAN_ABTRQ2	0x04
+#define MSCAN_ABTRQ1	0x02
+#define MSCAN_ABTRQ0	0x01
+
+/* MSCAN transmitter message abort ack (CANTAAK) bits */
+#define MSCAN_ABTAK2	0x04
+#define MSCAN_ABTAK1	0x02
+#define MSCAN_ABTAK0	0x01
+
+/* MSCAN transmit buffer selection (CANTBSEL) bits */
+#define MSCAN_TX2	0x04
+#define MSCAN_TX1	0x02
+#define MSCAN_TX0	0x01
+
+/* MSCAN ID acceptance control register (CANIDAC) bits */
+#define MSCAN_IDAM1	0x20
+#define MSCAN_IDAM0	0x10
+#define MSCAN_IDHIT2	0x04
+#define MSCAN_IDHIT1	0x02
+#define MSCAN_IDHIT0	0x01
+
+struct mscan_msgbuf {
+	volatile u8  idr[0x8];		/* 0x00 */
+	volatile u8  dsr[0x10];		/* 0x08 */
+	volatile u8  dlr;		/* 0x18 */
+	volatile u8  tbpr;		/* 0x19 */	/* This register is not applicable for receive buffers */
+	volatile u16 rsrv1;		/* 0x1A */
+	volatile u8  tsrh;		/* 0x1C */
+	volatile u8  tsrl;		/* 0x1D */
+	volatile u16 rsrv2;		/* 0x1E */
+};
+
+struct mscan_regs {
+	volatile u8  canctl0;		/* MSCAN + 0x00 */
+	volatile u8  canctl1;		/* MSCAN + 0x01 */
+	volatile u16 rsrv1;		/* MSCAN + 0x02 */
+	volatile u8  canbtr0;		/* MSCAN + 0x04 */
+	volatile u8  canbtr1;		/* MSCAN + 0x05 */
+	volatile u16 rsrv2;		/* MSCAN + 0x06 */
+	volatile u8  canrflg;		/* MSCAN + 0x08 */
+	volatile u8  canrier;		/* MSCAN + 0x09 */
+	volatile u16 rsrv3;		/* MSCAN + 0x0A */
+	volatile u8  cantflg;		/* MSCAN + 0x0C */
+	volatile u8  cantier;		/* MSCAN + 0x0D */
+	volatile u16 rsrv4;		/* MSCAN + 0x0E */
+	volatile u8  cantarq;		/* MSCAN + 0x10 */
+	volatile u8  cantaak;		/* MSCAN + 0x11 */
+	volatile u16 rsrv5;		/* MSCAN + 0x12 */
+	volatile u8  cantbsel;		/* MSCAN + 0x14 */
+	volatile u8  canidac;		/* MSCAN + 0x15 */
+	volatile u16 rsrv6[3];		/* MSCAN + 0x16 */
+	volatile u8  canrxerr;		/* MSCAN + 0x1C */
+	volatile u8  cantxerr;		/* MSCAN + 0x1D */
+	volatile u16 rsrv7;		/* MSCAN + 0x1E */
+	volatile u8  canidar0;		/* MSCAN + 0x20 */
+	volatile u8  canidar1;		/* MSCAN + 0x21 */
+	volatile u16 rsrv8;		/* MSCAN + 0x22 */
+	volatile u8  canidar2;		/* MSCAN + 0x24 */
+	volatile u8  canidar3;		/* MSCAN + 0x25 */
+	volatile u16 rsrv9;		/* MSCAN + 0x26 */
+	volatile u8  canidmr0;		/* MSCAN + 0x28 */
+	volatile u8  canidmr1;		/* MSCAN + 0x29 */
+	volatile u16 rsrv10;		/* MSCAN + 0x2A */
+	volatile u8  canidmr2;		/* MSCAN + 0x2C */
+	volatile u8  canidmr3;		/* MSCAN + 0x2D */
+	volatile u16 rsrv11;		/* MSCAN + 0x2E */
+	volatile u8  canidar4;		/* MSCAN + 0x30 */
+	volatile u8  canidar5;		/* MSCAN + 0x31 */
+	volatile u16 rsrv12;		/* MSCAN + 0x32 */
+	volatile u8  canidar6;		/* MSCAN + 0x34 */
+	volatile u8  canidar7;		/* MSCAN + 0x35 */
+	volatile u16 rsrv13;		/* MSCAN + 0x36 */
+	volatile u8  canidmr4;		/* MSCAN + 0x38 */
+	volatile u8  canidmr5;		/* MSCAN + 0x39 */
+	volatile u16 rsrv14;		/* MSCAN + 0x3A */
+	volatile u8  canidmr6;		/* MSCAN + 0x3C */
+	volatile u8  canidmr7;		/* MSCAN + 0x3D */
+	volatile u16 rsrv15;		/* MSCAN + 0x3E */
+
+	struct mscan_msgbuf canrxfg;	/* MSCAN + 0x40 */    /* Foreground receive buffer */
+	struct mscan_msgbuf cantxfg;	/* MSCAN + 0x60 */    /* Foreground transmit buffer */
+};
+
+/* Message type access macros.
+ */
+#define MSCAN_BUF_STD_RTR       0x10
+#define MSCAN_BUF_EXT_RTR       0x01
+#define MSCAN_BUF_EXTENDED      0x08
+#define MSCAN_TX_BUFS           3
+
+#define MSCAN_IDAM1	0x20
+/* Value for the interrupt enable register */
+#define MSCAN_RIER 	(MSCAN_OVRIE | \
+			 MSCAN_RXFIE | \
+			 MSCAN_WUPIF | \
+			 MSCAN_CSCIE | \
+			 MSCAN_RSTATE0 | \
+			 MSCAN_RSTATE1 | \
+			 MSCAN_TSTATE0 | \
+			 MSCAN_TSTATE1)
+
+#define BTR0_BRP_MASK 	 	0x3f
+#define BTR0_SJW_SHIFT 	 	6
+#define BTR0_SJW_MASK 	 	(0x3 << BTR0_SJW_SHIFT)
+
+#define BTR1_TSEG1_MASK	 	0xf
+#define BTR1_TSEG2_SHIFT  	4
+#define BTR1_TSEG2_MASK  	(0x7 << BTR1_TSEG2_SHIFT)
+#define BTR1_SAM_SHIFT 	  	7
+
+#define BTR0_SET_BRP(brp) 	(((brp) - 1) & BTR0_BRP_MASK)
+#define BTR0_SET_SJW(sjw) 	((((sjw) - 1) << BTR0_SJW_SHIFT) & BTR0_SJW_MASK)
+
+#define BTR1_SET_TSEG1(tseg1) 	(((tseg1) - 1) & BTR1_TSEG1_MASK)
+#define BTR1_SET_TSEG2(tseg2) 	((((tseg2) - 1) << BTR1_TSEG2_SHIFT) & BTR1_TSEG2_MASK)
+#define BTR1_SET_SAM(sam) 	(((sam) & 1) << BTR1_SAM_SHIFT)
+
+#endif /* __RTCAN_MSCAN_REGS_H_ */
+ diff -u xenomai/ksrc/drivers/can/rtcan_dev.c.ORIG xenomai/ksrc/drivers/can/rtcan_dev.c
--- xenomai/ksrc/drivers/can/rtcan_dev.c.ORIG	2006-08-22 20:40:29.000000000 +0200
+++ xenomai/ksrc/drivers/can/rtcan_dev.c	2006-08-22 20:41:52.000000000 +0200
@@ -79,16 +79,22 @@
 struct rtcan_device *rtcan_dev_get_by_name(const char *name)
 {
     struct rtcan_device *dev;
+#ifdef RTCAN_USE_REFCOUNT
     rtdm_lockctx_t context;
+#endif
 
 
+#ifdef RTCAN_USE_REFCOUNT
     rtdm_lock_get_irqsave(&rtcan_devices_rt_lock, context);
+#endif
 
     dev = __rtcan_dev_get_by_name(name);
+
+#ifdef RTCAN_USE_REFCOUNT
     if (dev != NULL)
         atomic_inc(&dev->refcount);
-
     rtdm_lock_put_irqrestore(&rtcan_devices_rt_lock, context);
+#endif
 
     return dev;
 }
@@ -103,19 +109,25 @@
 struct rtcan_device *rtcan_dev_get_by_index(int ifindex)
 {
     struct rtcan_device *dev;
+#ifdef RTCAN_USE_REFCOUNT
     rtdm_lockctx_t context;
+#endif
 
 
     if ((ifindex <= 0) || (ifindex > RTCAN_MAX_DEVICES))
         return NULL;
 
+#ifdef RTCAN_USE_REFCOUNT
     rtdm_lock_get_irqsave(&rtcan_devices_rt_lock, context);
+#endif
 
     dev = __rtcan_dev_get_by_index(ifindex);
+
+#ifdef RTCAN_USE_REFCOUNT
     if (dev != NULL)
         atomic_inc(&dev->refcount);
-
     rtdm_lock_put_irqrestore(&rtcan_devices_rt_lock, context);
+#endif
 
     return dev;
 }
@@ -134,8 +146,10 @@
             strncpy(dev->name, buf, IFNAMSIZ);
             break;
         }
+#ifdef RTCAN_USE_REFCOUNT
         else
             rtcan_dev_dereference(tmp);
+#endif
     }
 }
 
@@ -165,8 +179,9 @@
     /* Init TX Semaphore, will be destroyed forthwith
      * when setting stop mode */
     rtdm_sem_init(&dev->tx_sem, 0);
-
+#ifdef RTCAN_USE_REFCOUNT
     atomic_set(&dev->refcount, 0);
+#endif
 
     /* Initialize receive list */
     dev->empty_list = recv_list_elem = dev->receivers;
@@ -241,6 +256,7 @@
 
 int rtcan_dev_unregister(struct rtcan_device *dev)
 {
+#ifdef RTCAN_USE_REFCOUNT
     rtdm_lockctx_t context;
 
 
@@ -281,6 +297,10 @@
     printk("RTCAN: unregistered %s\n", dev->name);
 
     return 0;
+#else
+    printk("RTCAN: Oops, unexpected call of rtcan_dev_unregister()\n");
+    return -EINVAL;
+#endif
 }
 
 
+ diff -u xenomai/ksrc/drivers/can/rtcan_dev.h.ORIG xenomai/ksrc/drivers/can/rtcan_dev.h
--- xenomai/ksrc/drivers/can/rtcan_dev.h.ORIG	2006-08-22 20:40:30.000000000 +0200
+++ xenomai/ksrc/drivers/can/rtcan_dev.h	2006-08-22 21:29:11.000000000 +0200
@@ -36,8 +36,6 @@
 #include "rtcan_list.h"
 
 
-#define RTCAN_DEV_VERS_0_1   0x0001
-
 /* Number of MSCAN devices the driver can handle */
 #define RTCAN_MAX_DEVICES    CONFIG_XENO_DRIVERS_RTCAN_MAX_DEVICES
 
@@ -45,10 +43,13 @@
  * for reception at the same time using Bind */
 #define RTCAN_MAX_RECEIVERS  CONFIG_XENO_DRIVERS_RTCAN_MAX_RECEIVERS
 
+/* Suppress handling of refcount if module support is not enabled
+ * or modules cannot be unloaded */
+#if defined(CONFIG_MODULES) && !defined(CONFIG_MODULE_UNLOAD)
+#define RTCAN_USE_REFCOUNT
+#endif
+
 
-/**
- *  rtcan_device
- */
 struct rtcan_device {
     unsigned int        version;
 
@@ -61,7 +62,9 @@
     rtdm_irq_t          irq_handle; /* RTDM IRQ handle */
  
     int                 ifindex;
+#ifdef RTCAN_USE_REFCOUNT
     atomic_t            refcount;
+#endif
 
     void                *priv;      /* pointer to chip private data */
 
@@ -153,8 +156,13 @@
 struct rtcan_device *rtcan_dev_get_by_name(const char *if_name);
 struct rtcan_device *rtcan_dev_get_by_index(int ifindex);
 
+#ifdef RTCAN_USE_REFCOUNT
 #define rtcan_dev_reference(dev)      atomic_inc(&(dev)->refcount)
 #define rtcan_dev_dereference(dev)    atomic_dec(&(dev)->refcount)
+#else
+#define rtcan_dev_reference(dev)      do {} while(0)
+#define rtcan_dev_dereference(dev)    do {} while(0)
+#endif
 
 int rtcan_dev_create_proc(struct rtcan_device* dev);
 void rtcan_dev_remove_proc(struct rtcan_device* dev);
+ diff -u xenomai/ksrc/drivers/can/rtcan_module.c.ORIG xenomai/ksrc/drivers/can/rtcan_module.c
--- xenomai/ksrc/drivers/can/rtcan_module.c.ORIG	2006-08-22 20:40:30.000000000 +0200
+++ xenomai/ksrc/drivers/can/rtcan_module.c	2006-08-22 20:41:52.000000000 +0200
@@ -237,10 +237,14 @@
 	!RTCAN_PROC_PRINT("%s %s\n", "State     ", state_name) ||
 	!RTCAN_PROC_PRINT("%s %d\n", "TX-Counter", dev->tx_count) ||
 	!RTCAN_PROC_PRINT("%s %d\n", "RX-Counter", dev->rx_count) ||
-	!RTCAN_PROC_PRINT("%s %d\n", "Errors    ", dev->err_count) ||
-	!RTCAN_PROC_PRINT("%s %d\n", "Refcount  ", atomic_read(&dev->refcount)))
+	!RTCAN_PROC_PRINT("%s %d\n", "Errors    ", dev->err_count))
         goto done;
-    
+
+#ifdef RTCAN_USE_REFCOUNT
+    if (!RTCAN_PROC_PRINT("%s %d\n", "Refcount  ", atomic_read(&dev->refcount)))
+	goto done;
+#endif
+
   done:
     up(&rtcan_devices_nrt_lock);
     RTCAN_PROC_PRINT_DONE;
+ diff -u xenomai/scripts/Modules.frag.ORIG xenomai/scripts/Modules.frag
--- xenomai/scripts/Modules.frag.ORIG	2006-08-22 20:39:57.000000000 +0200
+++ xenomai/scripts/Modules.frag	2006-08-22 22:10:17.000000000 +0200
@@ -14,5 +14,5 @@
 DRIVERS-$(CONFIG_XENO_DRIVERS_RTCAN) += drivers/xenomai/can/xeno_rtcan.o
 DRIVERS-$(CONFIG_XENO_DRIVERS_RTCAN_MSCAN) += drivers/xenomai/can/mscan/xeno_rtcan_mscan.o
 DRIVERS-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000) += drivers/xenomai/can/sja1000/xeno_rtcan_sja1000.o
-DRIVERS-$(CONFIG_XENO_DRIVERS_RTCAN_PEAK_PCI) += drivers/xenomai/can/sja1000/xeno_rtcan_peak_pci.o
-DRIVERS-$(CONFIG_XENO_DRIVERS_RTCAN_PEAK_DNG) += drivers/xenomai/can/sja1000/xeno_rtcan_peak_dng.o
+DRIVERS-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000_PEAK_PCI) += drivers/xenomai/can/sja1000/xeno_rtcan_peak_pci.o
+DRIVERS-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000_PEAK_DNG) += drivers/xenomai/can/sja1000/xeno_rtcan_peak_dng.o

--------------030502040800080603030002--

