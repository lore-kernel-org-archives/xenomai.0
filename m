Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B6515E5CF
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781343; cv=none; b=JLJ7FmYxxh4pTJtb+tl7ZoJLpRQ6saGqtM/FppYsCPPHzyjzPsiXKI8RpmGFhXkDaAFt3ZmMFSoRxXIj+kzUOX41jjB+ptcPUdRZk7qsZ9zPtLNY0p2HU8MaXlJ+R61WjVCXM+Pq6wcaK+kykRs6n+Ug5Kh2qVI4xAbk2FbLxS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781343; c=relaxed/simple;
	bh=3gRIxm1q9JNhjgG9qn3BjroCpf67hJ3+wdLhrbSnqmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ErSWjw2+Xbz6Li/5/Ly/uyMLPjeC8yoESph2zj5mpdJMkpb0VinfTjhX8jUuVw9ieR0qKS5ff2RuxqgiN7lscBClPQJogbMH3IyYmet4xblreRVulYj7zdxTuuFfa8tTVVC2lgda2gXm4FD4+OGYpd91cslhLX7ugOmstvAWbVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=WDz9YzD9; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="WDz9YzD9"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024071210490019e85dd4ab0efb0530
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:49:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=fF+AyogWSl5b2Ha5qum5UjSInmmvCtHO69BzpRaVYTs=;
 b=WDz9YzD9kBiFLUMh3BGnFWDzJwz8Qt+LSIsPbBuEP6yVlD2X4h+lfj9yoBEsNxoQsM9ARC
 sjMUVBRFkGFIzvZzW+zI4UmSO/wzysLREJjF3f0MlK1PWI6r7mBD4TqTcRnacMBX6FLpEYH2
 28KOGmz4pDjmWyY8D7tzXBvdIqg5Q=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:49:16 +0200
Subject: [PATCH v2 30/33] drivers/stack/rtwlan: Migrate from rtdm_printk()
 and printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-30-facd992606c7@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
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

