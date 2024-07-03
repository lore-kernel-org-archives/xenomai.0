Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA50417B425
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013154; cv=none; b=TAKCqfWwa+GBPg2ejo3e5pH8434OrT84uWmcT1d+UG71XFZ3g0xDvb40hzQ+suzI+w5FpHVxceApGSzaUdWk84B0PRbu5PLUngfyFoscW9MhTGqZa4q12kPshc0qS0n801YTBdF4qZsl9+khg3sFRP7t+clLwzZsxgqpEXS/uJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013154; c=relaxed/simple;
	bh=GbXKvM7zj6VUZWMq1xu9TKtsoimwdjeQ0jHCE40bt1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KpdFNYgxzyO+ZelhjazkEGMpBxnqRE3FH32fkxhTlKftoBBVWt2bzx8JnQMQFwXjNAW242xM3Kv30/p+mcNBnoie59j8ZavpeGcTTk2m+wRAMkeDG2iQL4rsawdYHnRlNkEIeo/rH4xMTT/VoomPA2Hckh001Lvji6oInxzP3FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=hVsutgwv; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="hVsutgwv"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240703132549a35b024f09c11cdeb5
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=KTRgaxy1Ty7ckTRTtfOcaRs47Pbws/Ow8vb3nCeRh+M=;
 b=hVsutgwvWEhF6QoM7BNRCSgPpDBd/9jKtLqce8kohretKmqVm0G1PvF6Hnbw+LuSyvSUhQ
 tNaU8BSduR0dxF1UxQtMb0mqOnENDzu3vgSHk0NXGcvpWPvzB1qhFmLUe+JsyyRI2drMNhQu
 c0Fz9GWYE5yk16NGzAEczv/DzsfLM=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:51 +0200
Subject: [PATCH 28/33] drivers/net/stack/rtcfg: Migrate from rtdm_printk()
 and printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-28-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Some (rtdm_)printk() calls were missing log level information. The
default log level (= warn) did not fit well for them.

The missing log level is addressed by migrating to the pr_*() API.

rtdm_printk() itself is just an alias for printk(). Migrating helps to
remove this function once all drivers were updated.

No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/stack/include/rtcfg/rtcfg.h      | 5 +++--
 kernel/drivers/net/stack/rtcfg/rtcfg_client_event.c | 5 +++--
 kernel/drivers/net/stack/rtcfg/rtcfg_module.c       | 6 ++++--
 kernel/drivers/net/stack/rtcfg/rtcfg_proc.c         | 4 +++-
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/drivers/net/stack/include/rtcfg/rtcfg.h b/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
index 0b7cb539c..6148019fc 100644
--- a/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
+++ b/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
@@ -39,9 +39,10 @@ extern int rtcfg_debug;
 /* use 0 for production, 1 for verification, >2 for debug */
 #define RTCFG_DEFAULT_DEBUG_LEVEL 10
 
-#define RTCFG_DEBUG(n, args...) (rtcfg_debug >= (n)) ? (rtdm_printk(args)) : 0
+#define RTCFG_DEBUG(n, fmt, ...)                                               \
+	(rtcfg_debug >= (n)) ? (pr_debug(fmt, ##__VA_ARGS__)) : 0
 #else
-#define RTCFG_DEBUG(n, args...)
+#define RTCFG_DEBUG(n, fmt, ...)
 #endif /* CONFIG_RTCFG_DEBUG */
 
 #endif /* __RTCFG_H_INTERNAL_ */
diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_client_event.c b/kernel/drivers/net/stack/rtcfg/rtcfg_client_event.c
index cf9e1fc83..5058c9b61 100644
--- a/kernel/drivers/net/stack/rtcfg/rtcfg_client_event.c
+++ b/kernel/drivers/net/stack/rtcfg/rtcfg_client_event.c
@@ -22,6 +22,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTcfg: " fmt
+
 #include <ipv4/route.h>
 #include <rtcfg/rtcfg.h>
 #include <rtcfg/rtcfg_event.h>
@@ -882,8 +884,7 @@ static void rtcfg_client_recv_stage_2_cfg(int ifindex, struct rtskb *rtskb)
 		}
 
 		if (ret < 0)
-			/*ERRMSG*/ rtdm_printk(
-				"RTcfg: unable to create timer task\n");
+			/*ERRMSG*/ pr_err("unable to create timer task\n");
 		else
 			set_bit(FLAG_TIMER_STARTED, &rtcfg_dev->flags);
 	}
diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_module.c b/kernel/drivers/net/stack/rtcfg/rtcfg_module.c
index 5e597e818..857237744 100644
--- a/kernel/drivers/net/stack/rtcfg/rtcfg_module.c
+++ b/kernel/drivers/net/stack/rtcfg/rtcfg_module.c
@@ -22,6 +22,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTcfg: " fmt
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
@@ -37,7 +39,7 @@ static int __init rtcfg_init(void)
 {
 	int ret;
 
-	printk("RTcfg: init real-time configuration distribution protocol\n");
+	pr_info("init real-time configuration distribution protocol\n");
 
 	ret = rtcfg_init_ioctls();
 	if (ret != 0)
@@ -76,7 +78,7 @@ static void rtcfg_cleanup(void)
 	rtcfg_cleanup_state_machines();
 	rtcfg_cleanup_ioctls();
 
-	printk("RTcfg: unloaded\n");
+	pr_info("unloaded\n");
 }
 
 module_init(rtcfg_init);
diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_proc.c b/kernel/drivers/net/stack/rtcfg/rtcfg_proc.c
index 2e138180f..ea0a17207 100644
--- a/kernel/drivers/net/stack/rtcfg/rtcfg_proc.c
+++ b/kernel/drivers/net/stack/rtcfg/rtcfg_proc.c
@@ -22,6 +22,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTcfg: " fmt
+
 #include <rtdev.h>
 #include <rtnet_internal.h>
 #include <rtnet_port.h>
@@ -325,7 +327,7 @@ int rtcfg_init_proc(void)
 	return 0;
 
 err1:
-	printk("RTcfg: unable to initialise /proc entries\n");
+	pr_err("unable to initialise /proc entries\n");
 	return err;
 }
 

-- 
2.39.2

