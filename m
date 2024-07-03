Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA56517B429
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013153; cv=none; b=uTs5uWXRjsUwUOiVUq141gqKUYG5/vHJFk0brJqS/gCiG85ogfjaczoZ7vHRNNFnUpqmcHaUj5u17ZvYf/rj+LNOJfoTa69IUrLpvi34UXbutprrq6rYeod5VQxs80ByrzCOsuZVsSpzQsJKorRLfrp3bla+GRfUMT/Y1Sagusg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013153; c=relaxed/simple;
	bh=SPE7IntE0zX+cEodweFyv4k459tnp8PAOq2Rg7cbDt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oxsX1sOIuLoPn5Q5Kh2yVBtMffDt+K3y/7we7PVBO/28AV+71zDiPHhFkTn/V3VukN48Rotg3oODueYRV1dEsIb87TN5fq6uztUD/i3ADlKj/rhRJBjYOS3PlLfGlTVl8po67v0q6Tm8sjBBWQ/jemyZDHfwr6SwGnkoTqPszg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=CG1ZWTwi; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="CG1ZWTwi"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240703132550ad01a3105a8ace6dc8
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Grd2nujOW1I8Y+KVhKApdU6y2/ynFdzFyHxYA2PVDTY=;
 b=CG1ZWTwiQedKpfK/vOvlPEinQRk4EOafc9K3S3eTcYeltuvpj5nAoeftlP52d82ff1r76L
 cnIYOaenmHem2O5MB4OKimP2kQdUBUOQXU+3xYmGv33iWWPDzewFSa+hXm4XzuKI9S4xp/Iu
 AL7a4TRIp9Dffn59BgkrFE03Yfo18=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:53 +0200
Subject: [PATCH 30/33] drivers/stack/rtwlan: Migrate from rtdm_printk() and
 printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-30-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

All log levels were correct, migrating to pr_*() to keep in sync with
other drivers.

rtdm_printk() itself is just an alias for printk(). Migrating helps to
remove this function once all drivers were updated.

There was only a single usage of RTWLAN_DEBUG(). Migration to pr_debug()
allows using the machinery around dynamic debug. Macros are cleaned
up. CONFIG_RTWLAN_DEBUG was never set.

No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/stack/include/rtwlan.h | 14 --------------
 kernel/drivers/net/stack/rtwlan.c         |  6 ++++--
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/kernel/drivers/net/stack/include/rtwlan.h b/kernel/drivers/net/stack/include/rtwlan.h
index 85d6a99e5..f455c9034 100644
--- a/kernel/drivers/net/stack/include/rtwlan.h
+++ b/kernel/drivers/net/stack/include/rtwlan.h
@@ -131,20 +131,6 @@
 	((u8 *)(x))[0], ((u8 *)(x))[1], ((u8 *)(x))[2], ((u8 *)(x))[3],        \
 		((u8 *)(x))[4], ((u8 *)(x))[5]
 
-#ifdef CONFIG_RTWLAN_DEBUG
-#define RTWLAN_DEBUG_PRINTK(__message...)                                      \
-	do {                                                                   \
-		rtdm_printk(__message);                                        \
-	} while (0)
-#define RTWLAN_DEBUG(__message, __args...)                                     \
-	RTWLAN_DEBUG_PRINTK(KERN_DEBUG "rtwlan->%s: Debug - " __message,       \
-			    __FUNCTION__, ##__args);
-#else
-#define RTWLAN_DEBUG(__message...)                                             \
-	do {                                                                   \
-	} while (0)
-#endif
-
 struct rtwlan_stats {
 	unsigned long rx_packets; /* total packets received	*/
 	unsigned long tx_packets; /* total packets transmitted	*/
diff --git a/kernel/drivers/net/stack/rtwlan.c b/kernel/drivers/net/stack/rtwlan.c
index 6b2644825..f98647359 100644
--- a/kernel/drivers/net/stack/rtwlan.c
+++ b/kernel/drivers/net/stack/rtwlan.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) "rtwlan: " fmt
+
 #include <linux/module.h>
 
 #include <rtnet_port.h>
@@ -100,7 +102,7 @@ struct rtnet_device *rtwlan_alloc_dev(unsigned sizeof_priv,
 {
 	struct rtnet_device *rtnet_dev;
 
-	RTWLAN_DEBUG("Start.\n");
+	pr_debug("Start.\n");
 
 	rtnet_dev = rt_alloc_etherdev(
 		sizeof(struct rtwlan_device) + sizeof_priv, dev_pool_size);
@@ -208,7 +210,7 @@ struct rtnet_ioctls rtnet_wlan_ioctls = {
 int __init rtwlan_init(void)
 {
 	if (rtnet_register_ioctls(&rtnet_wlan_ioctls))
-		rtdm_printk(KERN_ERR "Failed to register rtnet_wlan_ioctl!\n");
+		pr_err("Failed to register rtnet_wlan_ioctl!\n");
 
 	return 0;
 }

-- 
2.39.2

