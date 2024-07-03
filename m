Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C7E13A25B
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013148; cv=none; b=QL5YiR98SAce6l7y7H9J1cbRuALQoZw581fK3PznPIqarnA5TnfxqZJNFLIZF5lZpG+OXqJO6d8pak9KOZTAQYLPuR5/VOixNUoO9HqO22gSDTQN4JM9nJN1XByM0BBzJmQ+6uemo1u88a6B5CgKwN2irGGyNJgbXfAEjSJWSZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013148; c=relaxed/simple;
	bh=NB4J/JqjIWpdp2Dpaopj2jNTQh116THraTW0s9Yy3sQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LJ+9bCZvzc5RoE4O9pbpxk+HbEed+cHsvL26NCj22RlFYfOQFt4W+kdZidh4mIymwuOMQrsLr3xFQeJRu7JOUcK2vFk/ayNwYruNblfSJukz+yaQst6j7/UCxVV8GzVogkAnTF/ceIlganUUouu4TjT/fLRYIt0eYDkaUt1Roq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=do4cx+/7; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="do4cx+/7"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202407031325406f9734060e7de5fdd8
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8fqbGYgg5Og1l1o77Tmshw+9W0Di+w0u+rRlt01OxK0=;
 b=do4cx+/7J+VaLg5uaxhTI3eT2aR1dcYFjza3Zzkqn9rowIdGQxHlgRPhucBOCTDJw0AY+K
 0/C5q09eY0Md92j3YfBCexzycot7JeJKG5xU4AkncjHgFMc2X5sx97tQvki1XM0VhIjFx71n
 rJANzmNrCCEuicVUnVdLNWWq73qH8=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:31 +0200
Subject: [PATCH 08/33] drivers/net/addons: Migrate from rtdm_printk() and
 printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-8-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

(rtdm_)printk() calls were missing log level information. The default
level (= warn) does not fit well for most of them.

The missing log level is addressed by migrating to the pr_*() API.

rtdm_printk() itself is just an alias for printk(). Migrating helps to
remove this function once all drivers were updated.

No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/addons/cap.c   | 22 ++++++++++++----------
 kernel/drivers/net/addons/proxy.c | 10 ++++++----
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/kernel/drivers/net/addons/cap.c b/kernel/drivers/net/addons/cap.c
index 27d90f3ca..12cea2bf2 100644
--- a/kernel/drivers/net/addons/cap.c
+++ b/kernel/drivers/net/addons/cap.c
@@ -22,6 +22,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTcap: " fmt
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/netdevice.h>
@@ -250,7 +252,7 @@ static void rtcap_signal_handler(rtdm_nrtsig_t *nrtsig, void *arg)
 				rtcap_kfree_rtskb(rtskb);
 			}
 		} else {
-			printk("RTcap: unable to allocate linux skb\n");
+			pr_err("unable to allocate linux skb\n");
 			rtcap_kfree_rtskb(rtskb);
 		}
 	}
@@ -351,7 +353,7 @@ static int __init rtcap_init(void)
 	int devices = 0;
 	int i;
 
-	printk("RTcap: real-time capturing interface\n");
+	pr_info("real-time capturing interface\n");
 
 	rtskb_queue_init(&cap_queue);
 
@@ -366,8 +368,8 @@ static int __init rtcap_init(void)
 
 			if (test_bit(PRIV_FLAG_UP, &rtdev->priv_flags)) {
 				mutex_unlock(&rtdev->nrt_lock);
-				printk("RTcap: %s busy, skipping device!\n",
-				       rtdev->name);
+				pr_info("%s busy, skipping device!\n",
+					rtdev->name);
 				rtdev_dereference(rtdev);
 				continue;
 			}
@@ -375,9 +377,9 @@ static int __init rtcap_init(void)
 			if (rtdev->mac_priv != NULL) {
 				mutex_unlock(&rtdev->nrt_lock);
 
-				printk("RTcap: RTmac discipline already active on device %s. "
-				       "Load RTcap before RTmac!\n",
-				       rtdev->name);
+				pr_info("RTmac discipline already active on device %s. "
+					"Load RTcap before RTmac!\n",
+					rtdev->name);
 
 				rtdev_dereference(rtdev);
 				continue;
@@ -447,7 +449,7 @@ static int __init rtcap_init(void)
 	}
 
 	if (devices == 0) {
-		printk("RTcap: no real-time devices found!\n");
+		pr_err("no real-time devices found!\n");
 		ret = -ENODEV;
 		goto error2;
 	}
@@ -468,7 +470,7 @@ static int __init rtcap_init(void)
 error3:
 	mutex_unlock(&rtdev->nrt_lock);
 	rtdev_dereference(rtdev);
-	printk("RTcap: unable to register %s!\n", dev->name);
+	pr_err("unable to register %s!\n", dev->name);
 
 error2:
 	cleanup_tap_devices();
@@ -496,7 +498,7 @@ static void rtcap_cleanup(void)
 
 	rtskb_pool_release(&cap_pool);
 
-	printk("RTcap: unloaded\n");
+	pr_info("unloaded\n");
 }
 
 module_init(rtcap_init);
diff --git a/kernel/drivers/net/addons/proxy.c b/kernel/drivers/net/addons/proxy.c
index b37b42c9d..752cdfe9f 100644
--- a/kernel/drivers/net/addons/proxy.c
+++ b/kernel/drivers/net/addons/proxy.c
@@ -36,6 +36,8 @@
  * Mathias Koehrer - mathias_koehrer@yahoo.de
 */
 
+#define pr_fmt(fmt) "RTproxy: " fmt
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
@@ -213,7 +215,7 @@ static void rtnetproxy_recv(struct rtskb *rtskb)
 	/* Acquire rtskb (JK) */
 	if (rtskb_acquire(rtskb, &rtskb_pool) != 0) {
 		dev_rtnetproxy->stats.rx_dropped++;
-		rtdm_printk("rtnetproxy_recv: No free rtskb in pool\n");
+		pr_err("rtnetproxy_recv: No free rtskb in pool\n");
 		kfree_rtskb(rtskb);
 		return;
 	}
@@ -341,10 +343,10 @@ static int __init rtnetproxy_init_module(void)
 
 #ifdef CONFIG_XENO_DRIVERS_NET_ADDON_PROXY_ARP
 	if ((rtnetproxy_rtdev = rtdev_get_by_name(rtdev_attach)) == NULL) {
-		printk("Couldn't attach to %s\n", rtdev_attach);
+		pr_err("Couldn't attach to %s\n", rtdev_attach);
 		return -EINVAL;
 	}
-	printk("RTproxy attached to %s\n", rtdev_attach);
+	pr_info("RTproxy attached to %s\n", rtdev_attach);
 #endif
 
 	/* Initialize the proxy's rtskb pool (JK) */
@@ -381,7 +383,7 @@ static int __init rtnetproxy_init_module(void)
 	/* Register with RTnet */
 	rt_ip_fallback_handler = rtnetproxy_recv;
 
-	printk("rtnetproxy installed as \"%s\"\n", dev_rtnetproxy->name);
+	pr_info("rtnetproxy installed as \"%s\"\n", dev_rtnetproxy->name);
 
 	return 0;
 

-- 
2.39.2

