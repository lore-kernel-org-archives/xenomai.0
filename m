Message-ID: <4F04589A.5090404@domain.hid>
Date: Wed, 04 Jan 2012 14:48:10 +0100
From: Fabrice Gasnier <fabrice.gasnier@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090506010205040304070409"
Subject: Re: [Xenomai-help] Xenomai rtcan build issue on MPC5121 (kernel >=
 2.6.35)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: wg@domain.hid, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------090506010205040304070409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

---
  ksrc/drivers/can/mscan/rtcan_mscan.c |   38 
++++++++++++++++++++++++++++++++-
  1 files changed, 36 insertions(+), 2 deletions(-)



--------------090506010205040304070409
Content-Type: text/x-patch;
 name="0001-fix-mscan-init-on-mpc5121.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-fix-mscan-init-on-mpc5121.patch"

diff --git a/ksrc/drivers/can/mscan/rtcan_mscan.c b/ksrc/drivers/can/mscan/rtcan_mscan.c
index d25fc5a..edd590e 100644
--- a/ksrc/drivers/can/mscan/rtcan_mscan.c
+++ b/ksrc/drivers/can/mscan/rtcan_mscan.c
@@ -40,6 +40,8 @@
 #include "rtcan_mscan_regs.h"
 #include "rtcan_mscan.h"
 
+#define MSCAN_SET_MODE_RETRIES	255
+
 /**
  *  Reception Interrupt handler
  *
@@ -306,11 +308,41 @@ static int rtcan_mscan_mode_stop(struct rtcan_device *dev,
 
 	/* Switch to sleep mode */
 	setbits8(&regs->canctl0, MSCAN_SLPRQ);
+	reg = in_8(&regs->canctl1);
+	while (!(reg & MSCAN_SLPAK) &&
+	        (rinit < MSCAN_SET_MODE_RETRIES)) {
+		if (likely(lock_ctx != NULL))
+			rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
+		/* Busy sleep 1 microsecond */
+		rtdm_task_busy_sleep(1000);
+		if (likely(lock_ctx != NULL))
+			rtdm_lock_get_irqsave(&dev->device_lock, *lock_ctx);
+		rinit++;
+		reg = in_8(&regs->canctl1);
+	}
+	/*
+	 * The mscan controller will fail to enter sleep mode,
+	 * while there are irregular activities on bus, like
+	 * somebody keeps retransmitting. This behavior is
+	 * undocumented and seems to differ between mscan built
+	 * in mpc5200b and mpc5200. We proceed in that case,
+	 * since otherwise the slprq will be kept set and the
+	 * controller will get stuck. NOTE: INITRQ or CSWAI
+	 * will abort all active transmit actions, if still
+	 * any, at once.
+	 */
+	if (rinit >= MSCAN_SET_MODE_RETRIES)
+		rtdm_printk("rtcan_mscan: device failed to enter sleep mode. "
+				"We proceed anyhow.\n");
+	else
+		dev->state = CAN_STATE_SLEEPING;
+
+	rinit = 0;
 	setbits8(&regs->canctl0, MSCAN_INITRQ);
 
 	reg = in_8(&regs->canctl1);
-	while (!(reg & MSCAN_SLPAK) ||
-	       !(reg & MSCAN_INITAK)) {
+	while (!(reg & MSCAN_INITAK) &&
+	        (rinit < MSCAN_SET_MODE_RETRIES)) {
 		if (likely(lock_ctx != NULL))
 			rtdm_lock_put_irqrestore(&dev->device_lock, *lock_ctx);
 		/* Busy sleep 1 microsecond */
@@ -320,6 +352,8 @@ static int rtcan_mscan_mode_stop(struct rtcan_device *dev,
 		rinit++;
 		reg = in_8(&regs->canctl1);
 	}
+	if (rinit >= MSCAN_SET_MODE_RETRIES)
+		ret = -ENODEV;
 
 	/* Volatile state could have changed while we slept busy. */
 	dev->state = CAN_STATE_STOPPED;


--------------090506010205040304070409--

