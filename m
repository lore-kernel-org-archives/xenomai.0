Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35DC17A58A
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013153; cv=none; b=P+7KITjJFeHBXS2VLvTH9NT/byXvXlxd2pnYUz4Aq7Rp1ocADDjOs7rfTgdutxNsQKM/+JwOrCPOpscDNlbZt97AUgf7scWnUqb4BPQ2fWuk4UOLlbuBPndfcwOX/9JLUXe1w0Xkghz7sBt4Ll0Nzl5IiaHArLQVELABJrE0ZEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013153; c=relaxed/simple;
	bh=MpdJcDB9iEGqiI4HCLT6zbQiyquvhTJJ/5mD0rhGUrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UtfhF1Dsd/O20LlTPqXD0AbFfMIW43YC8AsC/Vcv+i4qwA38pvFDphE2q+ITaUy+OSdWlPUa7QlS831CyE21ZKxKwjEfvwKjMmedaMahdnYYOUWruvGSYygtNTgiCFCSOkLx9yRX6MYrNZyYQqP5kqAPwfOdZVRww5T9Kp1EVcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=fLeL6Hb8; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="fLeL6Hb8"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202407031325507c32ec920ed692dc7b
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=87YdOLCMf1KdrHgoAmf5o/YVceP7yBZ6p6gDyCUZbDQ=;
 b=fLeL6Hb82TNRnq7B/Ct5Y2u4NSr3TX1jcXvfAelLdDLDuqkhmBCFa7QV/hl4HWRGChbodl
 Xve/Uk667YgeilVpKhzziW4hZmz0A4Fo1MeSf4PKrYRVahwUwS63em146sync88uuGmPZpw5
 XsYzJ1VC1e3dP8m+uMZkTtq/I2rzE=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:54 +0200
Subject: [PATCH 31/33] drivers/stack: Migrate from rtdm_printk() and
 printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-31-cc91bffdd063@siemens.com>
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
 kernel/drivers/net/stack/include/rtnet_internal.h |  2 +-
 kernel/drivers/net/stack/rtdev.c                  | 20 +++++++++++---------
 kernel/drivers/net/stack/rtnet_chrdev.c           |  4 +++-
 kernel/drivers/net/stack/rtnet_module.c           | 10 ++++++----
 kernel/drivers/net/stack/rtskb.c                  | 13 +++++++------
 kernel/drivers/net/stack/stack_mgr.c              | 10 ++++++----
 6 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/kernel/drivers/net/stack/include/rtnet_internal.h b/kernel/drivers/net/stack/include/rtnet_internal.h
index ec7e6141f..73f48c7a5 100644
--- a/kernel/drivers/net/stack/include/rtnet_internal.h
+++ b/kernel/drivers/net/stack/include/rtnet_internal.h
@@ -34,7 +34,7 @@
 #ifdef CONFIG_XENO_DRIVERS_NET_CHECKED
 #define RTNET_ASSERT(expr, func)                                               \
 	if (!(expr)) {                                                         \
-		rtdm_printk("Assertion failed! %s:%s:%d %s\n", __FILE__,       \
+		pr_err("Assertion failed! %s:%s:%d %s\n", __FILE__,            \
 			    __FUNCTION__, __LINE__, (#expr));                  \
 		func                                                           \
 	}
diff --git a/kernel/drivers/net/stack/rtdev.c b/kernel/drivers/net/stack/rtdev.c
index 7c50a9e9e..9bf867e95 100644
--- a/kernel/drivers/net/stack/rtdev.c
+++ b/kernel/drivers/net/stack/rtdev.c
@@ -23,6 +23,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTnet: " fmt
+
 #include <linux/spinlock.h>
 #include <linux/if.h>
 #include <linux/if_arp.h> /* ARPHRD_ETHER */
@@ -243,7 +245,7 @@ static int rtdev_init(struct rtnet_device *rtdev, unsigned dev_pool_size)
 	ret = rtskb_pool_init(&rtdev->dev_pool, dev_pool_size, &rtdev_ops,
 			      rtdev);
 	if (ret < dev_pool_size) {
-		printk(KERN_ERR "RTnet: cannot allocate rtnet device pool\n");
+		pr_err("cannot allocate rtnet device pool\n");
 		rtskb_pool_release(&rtdev->dev_pool);
 		return -ENOMEM;
 	}
@@ -287,7 +289,7 @@ static struct rtnet_device *rtdev_alloc(unsigned sizeof_priv,
 
 	rtdev = kzalloc(alloc_size, GFP_KERNEL);
 	if (rtdev == NULL) {
-		printk(KERN_ERR "RTnet: cannot allocate rtnet device\n");
+		pr_err("cannot allocate rtnet device\n");
 		return NULL;
 	}
 
@@ -403,7 +405,7 @@ static int rtskb_map(struct rtnet_device *rtdev, struct rtskb *skb)
 		return -ENOMEM;
 
 	if (skb->buf_dma_addr != RTSKB_UNMAPPED && addr != skb->buf_dma_addr) {
-		printk("RTnet: device %s maps skb differently than others. "
+		pr_err("device %s maps skb differently than others. "
 		       "Different IOMMU domain?\nThis is not supported.\n",
 		       rtdev->name);
 		return -EACCES;
@@ -589,7 +591,7 @@ int rt_register_rtnetdev(struct rtnet_device *rtdev)
 	/* Default state at registration is that the device is present. */
 	set_bit(__RTNET_LINK_STATE_PRESENT, &rtdev->link_state);
 
-	printk("RTnet: registered %s\n", rtdev->name);
+	pr_info("registered %s\n", rtdev->name);
 
 	return 0;
 
@@ -617,7 +619,7 @@ int rt_unregister_rtnetdev(struct rtnet_device *rtdev)
 	rtdm_lockctx_t context;
 
 	RTNET_ASSERT(rtdev->ifindex != 0,
-		     printk("RTnet: device %s/%p was not registered\n",
+		     pr_err("device %s/%p was not registered\n",
 			    rtdev->name, rtdev);
 		     return -ENODEV;);
 
@@ -649,9 +651,9 @@ int rt_unregister_rtnetdev(struct rtnet_device *rtdev)
 	clear_bit(__RTNET_LINK_STATE_PRESENT, &rtdev->link_state);
 
 	RTNET_ASSERT(atomic_read(&rtdev->refcount) == 0,
-		     printk("RTnet: rtdev reference counter < 0!\n"););
+		     pr_err("rtdev reference counter < 0!\n"););
 
-	printk("RTnet: unregistered %s\n", rtdev->name);
+	pr_info("unregistered %s\n", rtdev->name);
 
 	return 0;
 }
@@ -868,7 +870,7 @@ int rtdev_xmit(struct rtskb *rtskb)
 		/* on error we must free the rtskb here */
 		kfree_rtskb(rtskb);
 
-		rtdm_printk("hard_start_xmit returned %d\n", err);
+		pr_err("hard_start_xmit returned %d\n", err);
 	}
 
 	return err;
@@ -901,7 +903,7 @@ int rtdev_xmit_proxy(struct rtskb *rtskb)
 			/* on error we must free the rtskb here */
 			kfree_rtskb(rtskb);
 
-			rtdm_printk("hard_start_xmit returned %d\n", err);
+			pr_err("hard_start_xmit returned %d\n", err);
 		}
 	}
 
diff --git a/kernel/drivers/net/stack/rtnet_chrdev.c b/kernel/drivers/net/stack/rtnet_chrdev.c
index fa859c3bc..bb6e304d4 100644
--- a/kernel/drivers/net/stack/rtnet_chrdev.c
+++ b/kernel/drivers/net/stack/rtnet_chrdev.c
@@ -22,6 +22,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTnet: " fmt
+
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/if_arp.h>
@@ -218,7 +220,7 @@ int __init rtnet_chrdev_init(void)
 
 	err = misc_register(&rtnet_chr_misc_dev);
 	if (err) {
-		printk("RTnet: unable to register rtnet management device/class "
+		pr_err("unable to register rtnet management device/class "
 		       "(error %d)\n",
 		       err);
 		return err;
diff --git a/kernel/drivers/net/stack/rtnet_module.c b/kernel/drivers/net/stack/rtnet_module.c
index c245502cd..287ad1620 100644
--- a/kernel/drivers/net/stack/rtnet_module.c
+++ b/kernel/drivers/net/stack/rtnet_module.c
@@ -21,6 +21,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTnet: " fmt
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -298,7 +300,7 @@ error2:
 	xnvfile_destroy_dir(&rtnet_proc_root);
 
 error1:
-	printk("RTnet: unable to initialize /proc entries\n");
+	pr_err("unable to initialize /proc entries\n");
 	return err;
 }
 
@@ -322,8 +324,8 @@ static int __init rtnet_init(void)
 	if (!rtdm_available())
 		return -ENOSYS;
 
-	printk("\n*** RTnet for Xenomai v" XENO_VERSION_STRING " ***\n\n");
-	printk("RTnet: initialising real-time networking\n");
+	pr_info("\n*** RTnet for Xenomai v" XENO_VERSION_STRING " ***\n\n");
+	pr_info("initialising real-time networking\n");
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(6,4,0)
 	rtnet_class = class_create("rtnet");
@@ -409,7 +411,7 @@ static void __exit rtnet_release(void)
 
 	class_destroy(rtnet_class);
 
-	printk("RTnet: unloaded\n");
+	pr_info("unloaded\n");
 }
 
 module_init(rtnet_init);
diff --git a/kernel/drivers/net/stack/rtskb.c b/kernel/drivers/net/stack/rtskb.c
index e92cb3c64..fde421b36 100644
--- a/kernel/drivers/net/stack/rtskb.c
+++ b/kernel/drivers/net/stack/rtskb.c
@@ -21,6 +21,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTnet: " fmt
+
 #include <linux/moduleparam.h>
 #include <linux/slab.h>
 #include <rtnet_checksum.h>
@@ -125,8 +127,8 @@ EXPORT_SYMBOL_GPL(rtskb_copy_and_csum_dev);
  */
 void rtskb_over_panic(struct rtskb *skb, int sz, void *here)
 {
-	rtdm_printk("RTnet: rtskb_put :over: %p:%d put:%d dev:%s\n", here,
-		    skb->len, sz, (skb->rtdev) ? skb->rtdev->name : "<NULL>");
+	pr_err("rtskb_put :over: %p:%d put:%d dev:%s\n", here, skb->len, sz,
+	       (skb->rtdev) ? skb->rtdev->name : "<NULL>");
 }
 
 EXPORT_SYMBOL_GPL(rtskb_over_panic);
@@ -141,8 +143,8 @@ EXPORT_SYMBOL_GPL(rtskb_over_panic);
  */
 void rtskb_under_panic(struct rtskb *skb, int sz, void *here)
 {
-	rtdm_printk("RTnet: rtskb_push :under: %p:%d put:%d dev:%s\n", here,
-		    skb->len, sz, (skb->rtdev) ? skb->rtdev->name : "<NULL>");
+	pr_err("rtskb_push :under: %p:%d put:%d dev:%s\n", here, skb->len, sz,
+	       (skb->rtdev) ? skb->rtdev->name : "<NULL>");
 }
 
 EXPORT_SYMBOL_GPL(rtskb_under_panic);
@@ -370,8 +372,7 @@ unsigned int rtskb_pool_extend(struct rtskb_pool *pool, unsigned int add_rtskbs)
 	for (i = 0; i < add_rtskbs; i++) {
 		/* get rtskb from slab pool */
 		if (!(skb = kmem_cache_alloc(rtskb_slab_pool, GFP_KERNEL))) {
-			printk(KERN_ERR
-			       "RTnet: rtskb allocation from slab pool failed\n");
+			pr_err("rtskb allocation from slab pool failed\n");
 			break;
 		}
 
diff --git a/kernel/drivers/net/stack/stack_mgr.c b/kernel/drivers/net/stack/stack_mgr.c
index a7e22458a..b30a74549 100644
--- a/kernel/drivers/net/stack/stack_mgr.c
+++ b/kernel/drivers/net/stack/stack_mgr.c
@@ -22,6 +22,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTnet: " fmt
+
 #include <linux/moduleparam.h>
 
 #include <rtdev.h>
@@ -111,7 +113,7 @@ void rtnetif_rx(struct rtskb *skb)
 	RTNET_ASSERT(skb->rtdev != NULL, return;);
 
 	if (unlikely(rtskb_fifo_insert_inirq(&rx.fifo, skb) < 0)) {
-		rtdm_printk("RTnet: dropping packet in %s()\n", __FUNCTION__);
+		pr_warn("dropping packet in %s()\n", __FUNCTION__);
 		kfree_rtskb(skb);
 	}
 }
@@ -179,9 +181,9 @@ __DELIVER_PREFIX void rt_stack_deliver(struct rtskb *rtskb)
 	/* Don't warn if ETH_P_ALL listener were present or when running in
        promiscuous mode (RTcap). */
 	if (unlikely(!eth_p_all_hit && !(rtdev->flags & IFF_PROMISC)))
-		rtdm_printk("RTnet: no one cared for packet with layer 3 "
-			    "protocol type 0x%04x\n",
-			    ntohs(rtskb->protocol));
+		pr_warn("no one cared for packet with layer 3 "
+			"protocol type 0x%04x\n",
+			ntohs(rtskb->protocol));
 
 	kfree_rtskb(rtskb);
 }

-- 
2.39.2

