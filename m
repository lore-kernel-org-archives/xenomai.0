Message-ID: <4F0424A0.3010206@domain.hid>
Date: Wed, 04 Jan 2012 11:06:24 +0100
From: Fabrice Gasnier <fabrice.gasnier@domain.hid>
MIME-Version: 1.0
References: <4EF1C18C.3020407@domain.hid> <4EF8B4E8.8060003@domain.hid>
	<4F02C0A8.5020908@domain.hid> <4F036D27.6050800@domain.hid>
In-Reply-To: <4F036D27.6050800@domain.hid>
Content-Type: multipart/mixed; boundary="------------090701090604000106070808"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------090701090604000106070808
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Gilles.

I posted some time ago another question that is somehow related to rtcan 
and mpc5121:
insmod xeno_rtcan_mscan gets stuck on MPC5121
https://mail.gna.org/public/xenomai-core/2011-09/msg00032.html

I still have this issue and prepared a re-worked patch that you can find 
attached to this email.
Can this also be applied?

Regards,
Fabrice

On 03/01/2012 22:03, Gilles Chanteperdrix wrote:
> On 01/03/2012 09:47 AM, Fabrice Gasnier wrote:
>> Dear Gilles,
>>
>> please find attached a properly formatted patch using git (hope so).
> Applied, thanks.
>

--------------090701090604000106070808
Content-Type: text/x-patch;
 name="0001-fix-mscan-init-on-mpc5121.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-fix-mscan-init-on-mpc5121.patch"

>From 8e8a5e35d4c85a6a0e239c61009a309f6cb0437d Mon Sep 17 00:00:00 2001
From: Fabrice Gasnier <fabrice.gasnier@domain.hid>
Date: Wed, 4 Jan 2012 10:54:56 +0100
Subject: [PATCH] fix mscan init on mpc5121

---
 ksrc/drivers/can/mscan/rtcan_mscan.c |   38 ++++++++++++++++++++++++++++++++-
 1 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/ksrc/drivers/can/mscan/rtcan_mscan.c b/ksrc/drivers/can/mscan/rtcan_mscan.c
index d25fc5a..7d69348 100644
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
+	rinit=0;
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
-- 
1.7.0.4


--------------090701090604000106070808--

