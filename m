Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B38173336
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013150; cv=none; b=elWMoOw+goQG8tmF+KKeX0yE38MZ33sNqQUMyXIHhBCs+Ce9mb5p0L1CvfftIE1/LPY5CjzC2fgHDNBQPKFj226snEWrPqegz0c/yQRK072iGFehiS78x26vHliLVDKB2B76WUyumBzelqpD0n9TEHRsagp7a+D4YXNEgVb312I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013150; c=relaxed/simple;
	bh=9CM4IHNjg1HupXh0Pxmzna2FTK+EtbngvOA+ERNwvrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IWc+mQemSLi/4ka71nRMEkyf/wEbD9DWjLtr+Y2r6Dm76YYR/s+DLf+VBdglaqMZ6mQj1NG7k+rd4CbUjkG/iSCHxRCfFkCad5MtZF9RZpXHgVpgGFIdwP6+zgbZGWScStPJ8RkIEnFfG/POOhGa/d6+oZ2WV+SGayCCJmIotVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Ws9zeto5; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Ws9zeto5"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240703132539a5f304c36bd5313720
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=B4NZSRdYKYy4W9DeGlE4pfQ1ISeZPLlDng1HH6npETk=;
 b=Ws9zeto5XrfSUGnQBWMlDgWeLQfMauUuYMNlOfXz0DGsbeAt+9jENuJSeG4xWxzD8gV9oz
 FoVI2wOKFhs2K1oX6GvtRx4+LNoH0A+qtnCyzTEl3B4z3DuHiSW7wbnUMhbmU480xEuhHbQq
 D66y6/sCf4QwcAneqsQU1kvt5vT7w=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:28 +0200
Subject: [PATCH 05/33] drivers/can/peak_canfd: Migrate from rtdm_printk()
 to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-5-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The rtdm_printk() calls were missing log level information. The default
level (= warn) does not fit well for most of them.

The missing log level is addressed by migrating to the pr_*() API.

On the long run we want to get rid of rtdm_printk(), which is only an
alias for printk() these days.

No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c | 41 +++++++++++-------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c b/kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c
index 4ecc1e965..5214159b3 100644
--- a/kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c
+++ b/kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c
@@ -5,15 +5,17 @@
  * Copyright (C) 2001-2021 PEAK System-Technik GmbH
  * Copyright (C) 2019-2021 Stephane Grosjean <s.grosjean@peak-system.com>
  */
+
+#define DRV_NAME "xeno_peak_canfd"
+#define RTCAN_DEV_NAME "rtcan%d"
+#define RTCAN_CTRLR_NAME "peak_canfd"
+
+#define pr_fmt(fmt) DRV_NAME ": " fmt
+
 #include "rtcan_dev.h"
 #include "rtcan_raw.h"
 #include "rtcan_peak_canfd_user.h"
 
-#define DRV_NAME		"xeno_peak_canfd"
-
-#define RTCAN_DEV_NAME		"rtcan%d"
-#define RTCAN_CTRLR_NAME	"peak_canfd"
-
 /* bittiming ranges of the PEAK-System PC CAN-FD interfaces */
 static const struct can_bittiming_const peak_canfd_nominal_const = {
 	.name = RTCAN_CTRLR_NAME,
@@ -261,8 +263,7 @@ static int pucan_handle_status(struct peak_canfd_priv *priv,
 
 	/* test state error bits according to their priority */
 	if (pucan_status_is_busoff(msg)) {
-		rtdm_printk(DRV_NAME " CAN%u: Bus-off entry status\n",
-			    priv->index+1);
+		pr_info("CAN%u: Bus-off entry status\n", priv->index + 1);
 		rdev->state = CAN_STATE_BUS_OFF;
 		cf->can_id |= CAN_ERR_BUSOFF;
 
@@ -270,8 +271,7 @@ static int pucan_handle_status(struct peak_canfd_priv *priv,
 		rtdm_sem_destroy(&rdev->tx_sem);
 
 	} else if (pucan_status_is_passive(msg)) {
-		rtdm_printk(DRV_NAME " CAN%u: Error passive status\n",
-			    priv->index+1);
+		pr_info("CAN%u: Error passive status\n", priv->index + 1);
 		rdev->state = CAN_STATE_ERROR_PASSIVE;
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->data[1] = (priv->bec.txerr > priv->bec.rxerr) ?
@@ -281,8 +281,7 @@ static int pucan_handle_status(struct peak_canfd_priv *priv,
 		cf->data[7] = priv->bec.rxerr;
 
 	} else if (pucan_status_is_warning(msg)) {
-		rtdm_printk(DRV_NAME " CAN%u: Error warning status\n",
-			    priv->index+1);
+		pr_info("CAN%u: Error warning status\n", priv->index + 1);
 		rdev->state = CAN_STATE_ERROR_WARNING;
 
 		cf->can_id |= CAN_ERR_CRTL;
@@ -294,8 +293,7 @@ static int pucan_handle_status(struct peak_canfd_priv *priv,
 
 	} else if (rdev->state != CAN_STATE_ERROR_ACTIVE) {
 		/* back to ERROR_ACTIVE */
-		rtdm_printk(DRV_NAME " CAN%u: Error active status\n",
-			    priv->index+1);
+		pr_info("CAN%u: Error active status\n", priv->index + 1);
 		rdev->state = CAN_STATE_ERROR_ACTIVE;
 	}
 
@@ -456,8 +454,7 @@ static int peak_canfd_stop(struct rtcan_device *rdev,
 		/* go back to RESET mode */
 		err = pucan_set_reset_mode(priv);
 		if (err) {
-			rtdm_printk(DRV_NAME " CAN%u: reset failed\n",
-				    priv->index+1);
+			pr_err("CAN%u: reset failed\n", priv->index + 1);
 			break;
 		}
 
@@ -511,9 +508,8 @@ static int peak_canfd_set_bittiming(struct rtcan_device *rdev,
 
 	/* can't support BTR0BTR1 mode with clock greater than 8 MHz */
 	if (pbt->type != CAN_BITTIME_STD) {
-		rtdm_printk(DRV_NAME
-			    " CAN%u: unsupported bittiming mode %u\n",
-			    priv->index+1, pbt->type);
+		pr_err("CAN%u: unsupported bittiming mode %u\n",
+		       priv->index + 1, pbt->type);
 		return -EINVAL;
 	}
 
@@ -530,8 +526,8 @@ static int peak_canfd_set_bittiming(struct rtcan_device *rdev,
 
 	cmd->ewl = 96;	/* default */
 
-	rtdm_printk(DRV_NAME ": nominal: brp=%u tseg1=%u tseg2=%u sjw=%u\n",
-		   le16_to_cpu(cmd->brp), cmd->tseg1, cmd->tseg2, cmd->sjw_t);
+	pr_debug("nominal: brp=%u tseg1=%u tseg2=%u sjw=%u\n",
+		 le16_to_cpu(cmd->brp), cmd->tseg1, cmd->tseg2, cmd->sjw_t);
 
 	return pucan_write_cmd(priv);
 }
@@ -553,9 +549,8 @@ static netdev_tx_t peak_canfd_start_xmit(struct rtcan_device *rdev,
 	 * (auto-)restart mechanism
 	 */
 	if (!msg) {
-		rtdm_printk(DRV_NAME
-			    " CAN%u: skb lost (No room left in tx buffer)\n",
-			    priv->index+1);
+		pr_err("CAN%u: skb lost (No room left in tx buffer)\n",
+		       priv->index + 1);
 		return 0;
 	}
 

-- 
2.39.2

