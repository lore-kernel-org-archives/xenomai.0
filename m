Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB12158DC1
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781341; cv=none; b=bfwYshDCgfCXpHHopYYiN8RbwFFipyRD5mXlE+hjVE5J2TsYULSuFGXejiamPlw2Y/mfY1vuVNxZ1vW33ga6Ap4jJVveFNpz8RUN91IcycP35MVJvmLdP2Drkws5WrUNgMnaxSSjbR2xmb1YotTlKrlUYwcc0jBmXuLnjN0HwOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781341; c=relaxed/simple;
	bh=5WHCGniPj5aoPscqSpYLQlyGnpGYBd+AdWEsJK1Kmr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aXQY84xuShB9OHdUpla1zq2pMdtqxgQebecNoNeoirysTbre5G8vRZ3Vh29eLZ5BQoZQ+b+e/I1L2SoWRJIzRs+LMxw5R96Y+aDsGwBhQaPcDWA5YQZ3wcoWtiNqPAUMLG1WynCkWDVsMplMeOBFvjywC7va6nw83To+hNSSr9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=HniVHCc3; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="HniVHCc3"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240712104851314d52ea226e174812
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:48:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=sHppQWQz8CpU0kU92x15wGwwSuAyf6y1iRFGj6WK8lg=;
 b=HniVHCc3n1cRp0GzQV6Ou7gD1YY8a5xTRoeeefkVrpL6RjYNev/hZSdEUL6KRl66vEQSyg
 nJ7rCTGU3CiTsPPip48yaMcSQdOObyKsjbPwqqid11qc3ZWG1Wc0gyimHro8UGdWbe63mnnl
 2p++i4WvIFEcwgcDpKJHU+cRDR9gg=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:48:53 +0200
Subject: [PATCH v2 07/33] drivers/can: Migrate from rtdm_printk() and
 printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-7-facd992606c7@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Some (rtdm_)printk() calls were missing log level information. The
default level (= warn) does not fit well for most of them.

The missing log level is addressed by migrating to the pr_*() API.

rtdm_printk() itself is just an alias for printk(). Migrating helps to
remove this function once all drivers were updated.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/can/rtcan_dev.c        | 12 +++++++-----
 kernel/drivers/can/rtcan_internal.h   | 14 +++++++-------
 kernel/drivers/can/rtcan_module.c     | 10 ++++++----
 kernel/drivers/can/rtcan_raw.c        |  4 +++-
 kernel/drivers/can/rtcan_raw_filter.c |  9 ++++-----
 kernel/drivers/can/rtcan_virt.c       | 16 +++++++++-------
 6 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/kernel/drivers/can/rtcan_dev.c b/kernel/drivers/can/rtcan_dev.c
index 36d513152..bd741e1db 100644
--- a/kernel/drivers/can/rtcan_dev.c
+++ b/kernel/drivers/can/rtcan_dev.c
@@ -23,6 +23,8 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#define pr_fmt(fmt) "RTcan: " fmt
+
 #include <linux/spinlock.h>
 #include <linux/if.h>
 #include <linux/if_arp.h>
@@ -151,7 +153,7 @@ struct rtcan_device *rtcan_dev_alloc(int sizeof_priv, int sizeof_board_priv)
 
     dev = (struct rtcan_device *)kmalloc(alloc_size, GFP_KERNEL);
     if (dev == NULL) {
-	printk(KERN_ERR "rtcan: cannot allocate rtcan device\n");
+	pr_err("cannot allocate rtcan device\n");
 	return NULL;
     }
 
@@ -235,7 +237,7 @@ int rtcan_dev_register(struct rtcan_device *dev)
 
     mutex_unlock(&rtcan_devices_nrt_lock);
 
-    printk("rtcan: registered %s\n", dev->name);
+    pr_info("registered %s\n", dev->name);
 
     return 0;
 }
@@ -247,7 +249,7 @@ int rtcan_dev_unregister(struct rtcan_device *dev)
 
 
     RTCAN_ASSERT(dev->ifindex != 0,
-		 printk("RTCAN: device %s/%p was not registered\n",
+		 pr_err("device %s/%p was not registered\n",
 			dev->name, dev); return -ENODEV;);
 
     /* If device is running, close it first. */
@@ -281,10 +283,10 @@ int rtcan_dev_unregister(struct rtcan_device *dev)
 
 #ifdef RTCAN_USE_REFCOUNT
     RTCAN_ASSERT(atomic_read(&dev->refcount) == 0,
-		 printk("RTCAN: dev reference counter < 0!\n"););
+		 pr_err("dev reference counter < 0!\n"););
 #endif
 
-    printk("RTCAN: unregistered %s\n", dev->name);
+    pr_info("unregistered %s\n", dev->name);
 
     return 0;
 }
diff --git a/kernel/drivers/can/rtcan_internal.h b/kernel/drivers/can/rtcan_internal.h
index b29000522..704d45fdd 100644
--- a/kernel/drivers/can/rtcan_internal.h
+++ b/kernel/drivers/can/rtcan_internal.h
@@ -32,7 +32,7 @@
 #ifdef CONFIG_XENO_DRIVERS_CAN_DEBUG
 #define RTCAN_ASSERT(expr, func) \
     if (!(expr)) { \
-	rtdm_printk("Assertion failed! %s:%s:%d %s\n", \
+	pr_debug("Assertion failed! %s:%s:%d %s\n", \
 	__FILE__, __FUNCTION__, __LINE__, (#expr)); \
 	func \
     }
@@ -41,8 +41,8 @@
 #endif /* CONFIG_RTCAN_CHECKED */
 
 #ifdef CONFIG_XENO_DRIVERS_CAN_DEBUG
-# define RTCAN_DBG(fmt,args...) do { printk(fmt ,##args); } while (0)
-# define RTCAN_RTDM_DBG(fmt,args...) do { rtdm_printk(fmt ,##args); } while (0)
+# define RTCAN_DBG(fmt,args...) do { pr_debug(fmt ,##args); } while (0)
+# define RTCAN_RTDM_DBG(fmt,args...) do { pr_debug(fmt ,##args); } while (0)
 #else
 # define RTCAN_DBG(fmt,args...) do {} while (0)
 # define RTCAN_RTDM_DBG(fmt,args...) do {} while (0)
@@ -50,12 +50,12 @@
 
 #define rtcan_priv(dev)			(dev)->priv
 #define rtcandev_dbg(dev, fmt, args...)				\
-	printk(KERN_DEBUG "%s: " fmt, (dev)->name, ##args)
+	pr_debug("%s: " fmt, (dev)->name, ##args)
 #define rtcandev_info(dev, fmt, args...)			\
-	printk(KERN_INFO "%s: " fmt, (dev)->name, ##args)
+	pr_info("%s: " fmt, (dev)->name, ##args)
 #define rtcandev_warn(dev, fmt, args...)			\
-	printk(KERN_WARNING "%s: " fmt, (dev)->name, ##args)
+	pr_warn("%s: " fmt, (dev)->name, ##args)
 #define rtcandev_err(dev, fmt, args...)				\
-	printk(KERN_ERR "%s: " fmt, (dev)->name, ##args)
+	pr_err("%s: " fmt, (dev)->name, ##args)
 
 #endif /* __RTCAN_INTERNAL_H_ */
diff --git a/kernel/drivers/can/rtcan_module.c b/kernel/drivers/can/rtcan_module.c
index 55d659689..edc977cdb 100644
--- a/kernel/drivers/can/rtcan_module.c
+++ b/kernel/drivers/can/rtcan_module.c
@@ -22,6 +22,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTcan: " fmt
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -358,7 +360,7 @@ int rtcan_dev_create_proc(struct rtcan_device* dev)
 
     dev->proc_root = proc_mkdir(dev->name, rtcan_proc_root);
     if (!dev->proc_root) {
-	printk("%s: unable to create /proc device entries\n", dev->name);
+	pr_err("%s: unable to create /proc device entries\n", dev->name);
 	return -1;
     }
 
@@ -375,7 +377,7 @@ static int rtcan_proc_register(void)
 {
     rtcan_proc_root = proc_mkdir("rtcan", NULL);
     if (!rtcan_proc_root) {
-	printk("rtcan: unable to initialize /proc entries\n");
+	pr_err("unable to initialize /proc entries\n");
 	return -1;
     }
 
@@ -408,7 +410,7 @@ static int __init rtcan_init(void)
     if (!rtdm_available())
 	return -ENOSYS;
 
-    printk("RT-Socket-CAN %d.%d.%d - %s\n",
+    pr_info("RT-Socket-CAN %d.%d.%d - %s\n",
 	   RTCAN_MAJOR_VER, RTCAN_MINOR_VER, RTCAN_BUGFIX_VER,
 	   rtcan_rtdm_provider_name);
 
@@ -436,7 +438,7 @@ static void __exit rtcan_exit(void)
     rtcan_proc_unregister();
 #endif
 
-    printk("rtcan: unloaded\n");
+    pr_info("unloaded\n");
 }
 
 
diff --git a/kernel/drivers/can/rtcan_raw.c b/kernel/drivers/can/rtcan_raw.c
index 87f9c4e6b..3f330c4dd 100644
--- a/kernel/drivers/can/rtcan_raw.c
+++ b/kernel/drivers/can/rtcan_raw.c
@@ -34,6 +34,8 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
+#define pr_fmt(fmt) "RTcan: " fmt
+
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/stringify.h>
@@ -176,7 +178,7 @@ void rtcan_tx_push(struct rtcan_device *dev, struct rtcan_socket *sock,
     struct rtcan_rb_frame *rb_frame = &dev->tx_skb.rb_frame;
 
     RTCAN_ASSERT(dev->tx_socket == 0,
-		 rtdm_printk("(%d) TX skb still in use", dev->ifindex););
+		 pr_err("(%d) TX skb still in use", dev->ifindex););
 
     rb_frame->can_id = frame->can_id;
     rb_frame->can_dlc = frame->can_dlc;
diff --git a/kernel/drivers/can/rtcan_raw_filter.c b/kernel/drivers/can/rtcan_raw_filter.c
index e121061ac..a3209b192 100644
--- a/kernel/drivers/can/rtcan_raw_filter.c
+++ b/kernel/drivers/can/rtcan_raw_filter.c
@@ -39,12 +39,11 @@ void rtcan_raw_print_filter(struct rtcan_device *dev)
     int i;
     struct rtcan_recv *r = dev->receivers;
 
-    rtdm_printk("%s: recv_list=%p empty_list=%p free_entries=%d\n",
-		dev->name, dev->recv_list, dev->empty_list, dev->free_entries);
+    pr_debug("%s: recv_list=%p empty_list=%p free_entries=%d\n",
+	     dev->name, dev->recv_list, dev->empty_list, dev->free_entries);
     for (i = 0; i < RTCAN_MAX_RECEIVERS; i++, r++) {
-	rtdm_printk("%2d %p sock=%p next=%p id=%x mask=%x\n",
-		    i, r, r->sock, r->next,
-		    r->can_filter.can_id, r->can_filter.can_mask);
+	    pr_debug("%2d %p sock=%p next=%p id=%x mask=%x\n", i, r, r->sock,
+		     r->next, r->can_filter.can_id, r->can_filter.can_mask);
     }
 }
 #else
diff --git a/kernel/drivers/can/rtcan_virt.c b/kernel/drivers/can/rtcan_virt.c
index 28e06a9d6..1e3b2c024 100644
--- a/kernel/drivers/can/rtcan_virt.c
+++ b/kernel/drivers/can/rtcan_virt.c
@@ -17,6 +17,11 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
+#define RTCAN_DEV_NAME          "rtcan%d"
+#define RTCAN_DRV_NAME          "VIRT"
+#define RTCAN_MAX_VIRT_DEVS     8
+
+#define pr_fmt(fmt) RTCAN_DRV_NAME ": " fmt
 
 #include <linux/module.h>
 #include <rtdm/driver.h>
@@ -24,10 +29,6 @@
 #include "rtcan_dev.h"
 #include "rtcan_raw.h"
 
-#define RTCAN_DEV_NAME          "rtcan%d"
-#define RTCAN_DRV_NAME          "VIRT"
-#define RTCAN_MAX_VIRT_DEVS     8
-
 #define VIRT_TX_BUFS            1
 
 static char *virt_ctlr_name  = "<virtual>";
@@ -136,14 +137,15 @@ static int __init rtcan_virt_init_one(int idx)
 	/* Register RTDM device */
 	err = rtcan_dev_register(dev);
 	if (err) {
-	    printk(KERN_ERR "ERROR %d while trying to register RTCAN device!\n", err);
+		pr_err("ERROR %d while trying to register RTCAN device!\n",
+		       err);
 		goto error_out;
 	}
 
 	/* Remember initialized devices */
 	rtcan_virt_devs[idx] = dev;
 
-	printk("%s: %s driver loaded\n", dev->name, RTCAN_DRV_NAME);
+	pr_info("%s driver loaded\n", dev->name);
 
 	return 0;
 
@@ -187,7 +189,7 @@ static void __exit rtcan_virt_exit(void)
 	for (i = 0; i < devices; i++) {
 		dev = rtcan_virt_devs[i];
 
-		printk("Unloading %s device %s\n", RTCAN_DRV_NAME, dev->name);
+		pr_info("Unloading device %s\n", dev->name);
 
 		rtcan_virt_set_mode(dev, CAN_MODE_STOP, NULL);
 		rtcan_dev_unregister(dev);

-- 
2.39.2

