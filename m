Message-ID: <4E673356.2090306@domain.hid>
Date: Wed, 07 Sep 2011 11:03:18 +0200
From: Fabrice Gasnier <fabrice.gasnier@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030202020506030408040603"
Subject: [Xenomai-core] insmod xeno_rtcan_mscan gets stuck on MPC5121
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------030202020506030408040603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear all,

I'm currently evaluating xeno_rtcan_mscan driver on a phyCORE-MPC5121e.
I'm using linux-2.6.33.5 with Xenomai 2.5.6 
(adeos-ipipe-2.6.33.5-powerpc-2.10-03.patch).
Kernel has been configured with CONFIG_XENO_DRIVERS_CAN_MSCAN

Everything is ok until module is been loaded: insmod xeno_can_mscan hangs.
$insmod xeno_can.ko
RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
$insmod xeno_can_mscan.ko
=> get stuck then

I went through module source code. Module loading is stuck in an endless 
loop in "rtcan_mscan_mode_stop" routine in 
ksrc/drivers/can/mscan/rtcan_mscan.c. The driver expects can controller 
to acknowledge a sleep and init command.
Having a look at native linux source code shows a different way to 
initialize CAN controller. A strategy is being implemented to avoid 
being stuck here.

I've come to the attached patch to replicate native linux kernel module 
behaviour regarding this init routine. Insterting patched module shows:
rtcan_mscan: device failed to enter sleep mode. We proceed anyhow.
rtcan: registered rtcan0
rtcan_mscan 80001300.mscan: MSCAN at 0xd314c300, irq 23, clock 66660000 Hz
rtcan_mscan: device failed to enter sleep mode. We proceed anyhow.
rtcan: registered rtcan1
rtcan_mscan 80001380.mscan: MSCAN at 0xd3154380, irq 24, clock 66660000 Hz

I've tested it successfully: i'm now able to load driver and to use it 
(using canfestival for instance).
I'm not sure about the cause of this behaviour (e.g. chip revision, or 
something else ?) but i'm quite confident it solves this issue.

Could someone advise on the modifications brought here?

Thanks in advance
Fabrice


--------------030202020506030408040603
Content-Type: text/x-patch;
 name="001_fix_rtcan_mscan_mpc5121.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="001_fix_rtcan_mscan_mpc5121.patch"

Index: xenomai-2.5.6/ksrc/drivers/can/mscan/rtcan_mscan.c
===================================================================
--- xenomai-2.5.6.orig/ksrc/drivers/can/mscan/rtcan_mscan.c	2011-09-06 11:19:29.000000000 +0200
+++ xenomai-2.5.6/ksrc/drivers/can/mscan/rtcan_mscan.c	2011-09-06 14:20:03.000000000 +0200
@@ -40,6 +40,8 @@
 #include "rtcan_mscan_regs.h"
 #include "rtcan_mscan.h"
 
+#define MSCAN_SET_MODE_RETRIES	255
+
 /**
  *  Reception Interrupt handler
  *
@@ -294,31 +296,54 @@
 				 rtdm_lockctx_t *lock_ctx)
 {
 	int ret = 0;
-	int rinit = 0;
+	int i=0;
 	can_state_t state;
 	struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
-	u8 reg;
+	u8 canctl1;
 
 	state = dev->state;
 	/* If controller is not operating anyway, go out */
 	if (!CAN_STATE_OPERATING(state))
 		goto out;
 
-	/* Switch to sleep mode */
-	setbits8(&regs->canctl0, MSCAN_SLPRQ);
-	setbits8(&regs->canctl0, MSCAN_INITRQ);
-
-	reg = in_8(&regs->canctl1);
-	while (!(reg & MSCAN_SLPAK) ||
-	       !(reg & MSCAN_INITAK)) {
-		if (likely(lock_ctx != NULL))
-			rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
-		/* Busy sleep 1 microsecond */
-		rtdm_task_busy_sleep(1000);
-		if (likely(lock_ctx != NULL))
-			rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
-		rinit++;
-		reg = in_8(&regs->canctl1);
+	canctl1 = in_8(&regs->canctl1);
+	if (!(canctl1 & MSCAN_SLPAK)) {
+		setbits8(&regs->canctl0, MSCAN_SLPRQ);
+		for (i = 0; i < MSCAN_SET_MODE_RETRIES; i++) {
+			if (in_8(&regs->canctl1) & MSCAN_SLPAK)
+				break;
+			if (likely(lock_ctx != NULL))
+				rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
+			/* Busy sleep 1 microsecond */
+			rtdm_task_busy_sleep(1000);
+			if (likely(lock_ctx != NULL))
+				rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
+		}
+		/*
+		 * The mscan controller will fail to enter sleep mode,
+		 * while there are irregular activities on bus, like
+		 * somebody keeps retransmitting. This behavior is
+		 * undocumented and seems to differ between mscan built
+		 * in mpc5200b and mpc5200. We proceed in that case,
+		 * since otherwise the slprq will be kept set and the
+		 * controller will get stuck. NOTE: INITRQ or CSWAI
+		 * will abort all active transmit actions, if still
+		 * any, at once.
+		 */
+		if (i >= MSCAN_SET_MODE_RETRIES)
+			rtdm_printk("rtcan_mscan: device failed to enter sleep mode. "
+				    "We proceed anyhow.\n");
+		else
+			dev->state = CAN_STATE_SLEEPING;
+	}
+	if (!(canctl1 & MSCAN_INITAK)) {
+		setbits8(&regs->canctl0, MSCAN_INITRQ);
+		for (i = 0; i < MSCAN_SET_MODE_RETRIES; i++) {
+			if (in_8(&regs->canctl1) & MSCAN_INITAK)
+				break;
+		}
+		if (i >= MSCAN_SET_MODE_RETRIES)
+			ret = -ENODEV;
 	}
 
 	/* Volatile state could have changed while we slept busy. */

--------------030202020506030408040603--

