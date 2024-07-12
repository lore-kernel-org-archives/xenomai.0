Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2B015E5BA
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781345; cv=none; b=HnoperdXpBSSq6Rwl9iMa3yJ8u8uJ2T+FYud3RjSkZHVy4HzMjHRh9wqiJtvND4lS03gu/OCyFqTPhRqhbWFvv+TnOxDEsOEExur9bJvVLPROrEqvVvwgCVDVT+0Hs2TuqWMNNmnzqS1erzSVqJbo/BYUUEvoMzYBttAFk88WFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781345; c=relaxed/simple;
	bh=CUQu0bB4KgQV1cRfou9VGntnn/pugQDmVcZ3TktgXTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z8zYM51JvSDy+Nw2Voyxac7f3pORwnpBEm/DY/rS3TX9rKn2U5c03+VXQXNIwaYcMzWglxIhOAp4fhZW49S/s4uw+BszYNejz9AvqGiJFGG7oi6b5fEwkqaBFBM1xc5/jCaOaxrhQqsH34Wq95+/cLHNnaqBRwxCTh/fWeM8v5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=m2QKBxXL; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="m2QKBxXL"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240712104900946f42d4fb16ea3762
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:49:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qo13OfWY6Wed4orHOJKBkZsooFJQ1Ac1/gFG7xn59WI=;
 b=m2QKBxXLxGuFrvAeVzuP4fGLwzPCCPlPXPNaBZe6qPH3z/OUQa3dSZXR9mqGXurEXDteOb
 iT8CrMgyXG6MiKUqih7aBtfcz0uHtvEr3yD4x/Sx6kUo5e74qA7EcOf590f5jfP2l4QxB0np
 J9qS3W5o6fN7T7uCEf8ICC9i+PKGo=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:49:14 +0200
Subject: [PATCH v2 28/33] drivers/net/stack/rtcfg: Migrate from
 rtdm_printk() and printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-28-facd992606c7@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
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
index cf9e1fc83..3dfd0aed3 100644
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
+			pr_err("unable to create timer task\n");
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

