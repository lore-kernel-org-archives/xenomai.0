Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA8979D2
	for <xenomai@lists.linux.dev>; Wed, 31 May 2023 11:03:29 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id E6177240008
	for <xenomai@lists.linux.dev>; Wed, 31 May 2023 11:03:21 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	by spool.mail.gandi.net (Postfix) with ESMTPS id EF3E57803E9
	for <xenomai@xenomai.org>; Wed, 31 May 2023 11:03:20 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2023053111032021971580de073633e7
        for <xenomai@xenomai.org>;
        Wed, 31 May 2023 13:03:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=rsUibPpUzHt0Ai9wJxvliBU7kzI1AOlK87uk2VNC0rw=;
 b=gMTvAh8ZNrlt79ZeehSxcwpl38StmrcaLVOva1HPl+ml62Vy/5wWvGWj2FptgV3NFqZ+Mg
 i0c5ViachN1doxcYbB5/a/Toi51QupO9oBf2uv0uVkfXGXHFjMJmd+MgHx0+Dk0qLzy7LV6Z
 SGDEMPFC/K9FJ+aY+iSFQ27dXI8+M=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [PATCH 3/4] drivers/can: Convert rtcan_devices_nrt_lock to real mutex
Date: Wed, 31 May 2023 13:03:13 +0200
Message-Id: <c046b8ea35f4830f6661497a5686eeeb3873e6c2.1685530994.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1685530994.git.jan.kiszka@siemens.com>
References: <cover.1685530994.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool4: domain of rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) client-ip=185.136.64.228; envelope-from=fm-294854-2023053111032021971580de073633e7-bfP4H2@rts-flowmailer.siemens.com; helo=mta-64-228.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=gMTvAh8Z;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-2023053111032021971580de073633e7-bfP4H2@rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) smtp.mailfrom=fm-294854-2023053111032021971580de073633e7-bfP4H2@rts-flowmailer.siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

No need to use a semaphore here which is semantically not a real mutex
anyway. Also avoids to adjust to the kernel changes coming in with 6.4.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/can/rtcan_dev.c    | 18 +++++++++---------
 kernel/drivers/can/rtcan_dev.h    |  4 ++--
 kernel/drivers/can/rtcan_module.c | 12 ++++++------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/drivers/can/rtcan_dev.c b/kernel/drivers/can/rtcan_dev.c
index da64be75ca..36d513152e 100644
--- a/kernel/drivers/can/rtcan_dev.c
+++ b/kernel/drivers/can/rtcan_dev.c
@@ -36,7 +36,7 @@
 static struct rtcan_device *rtcan_devices[RTCAN_MAX_DEVICES];
 static DEFINE_RTDM_LOCK(rtcan_devices_rt_lock);
 
-DEFINE_SEMAPHORE(rtcan_devices_nrt_lock);
+DEFINE_MUTEX(rtcan_devices_nrt_lock);
 
 /* Spinlock for all reception lists and also for some members in
  * struct rtcan_socket */
@@ -210,10 +210,10 @@ int rtcan_dev_register(struct rtcan_device *dev)
     rtdm_lockctx_t context;
     int ret;
 
-    down(&rtcan_devices_nrt_lock);
+    mutex_lock(&rtcan_devices_nrt_lock);
 
     if ((ret = __rtcan_dev_new_index()) < 0) {
-	up(&rtcan_devices_nrt_lock);
+	mutex_unlock(&rtcan_devices_nrt_lock);
 	return ret;
     }
     dev->ifindex = ret;
@@ -222,7 +222,7 @@ int rtcan_dev_register(struct rtcan_device *dev)
 	rtcan_dev_alloc_name(dev, dev->name);
 
     if (__rtcan_dev_get_by_name(dev->name) != NULL) {
-	up(&rtcan_devices_nrt_lock);
+	mutex_unlock(&rtcan_devices_nrt_lock);
 	return -EEXIST;
     }
 
@@ -233,7 +233,7 @@ int rtcan_dev_register(struct rtcan_device *dev)
     rtdm_lock_put_irqrestore(&rtcan_devices_rt_lock, context);
     rtcan_dev_create_proc(dev);
 
-    up(&rtcan_devices_nrt_lock);
+    mutex_unlock(&rtcan_devices_nrt_lock);
 
     printk("rtcan: registered %s\n", dev->name);
 
@@ -254,7 +254,7 @@ int rtcan_dev_unregister(struct rtcan_device *dev)
     if (CAN_STATE_OPERATING(dev->state))
 	return -EBUSY;
 
-    down(&rtcan_devices_nrt_lock);
+    mutex_lock(&rtcan_devices_nrt_lock);
 
     rtcan_dev_remove_proc(dev);
 
@@ -263,21 +263,21 @@ int rtcan_dev_unregister(struct rtcan_device *dev)
 #ifdef RTCAN_USE_REFCOUNT
     while (atomic_read(&dev->refcount) > 0) {
 	rtdm_lock_put_irqrestore(&rtcan_devices_rt_lock, context);
-	up(&rtcan_devices_nrt_lock);
+	mutex_unlock(&rtcan_devices_nrt_lock);
 
 	RTCAN_DBG("RTCAN: unregistering %s deferred (refcount = %d)\n",
 		  dev->name, atomic_read(&dev->refcount));
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(1*HZ); /* wait a second */
 
-	down(&rtcan_devices_nrt_lock);
+	mutex_lock(&rtcan_devices_nrt_lock);
 	rtdm_lock_get_irqsave(&rtcan_devices_rt_lock, context);
     }
 #endif
     rtcan_devices[dev->ifindex - 1] = NULL;
 
     rtdm_lock_put_irqrestore(&rtcan_devices_rt_lock, context);
-    up(&rtcan_devices_nrt_lock);
+    mutex_unlock(&rtcan_devices_nrt_lock);
 
 #ifdef RTCAN_USE_REFCOUNT
     RTCAN_ASSERT(atomic_read(&dev->refcount) == 0,
diff --git a/kernel/drivers/can/rtcan_dev.h b/kernel/drivers/can/rtcan_dev.h
index cc081f6e8b..9f7c9ae751 100644
--- a/kernel/drivers/can/rtcan_dev.h
+++ b/kernel/drivers/can/rtcan_dev.h
@@ -30,8 +30,8 @@
 #ifdef __KERNEL__
 
 #include <asm/atomic.h>
+#include <linux/mutex.h>
 #include <linux/netdevice.h>
-#include <linux/semaphore.h>
 
 #include "rtcan_list.h"
 #include "rtcan_ethtool.h"
@@ -169,7 +169,7 @@ struct rtcan_device {
 };
 
 
-extern struct semaphore rtcan_devices_nrt_lock;
+extern struct mutex rtcan_devices_nrt_lock;
 
 
 void rtcan_dev_free(struct rtcan_device *dev);
diff --git a/kernel/drivers/can/rtcan_module.c b/kernel/drivers/can/rtcan_module.c
index 632c01bed2..81fdc7ffea 100644
--- a/kernel/drivers/can/rtcan_module.c
+++ b/kernel/drivers/can/rtcan_module.c
@@ -125,7 +125,7 @@ static int rtcan_read_proc_devices(struct seq_file *p, void *data)
     struct rtcan_device *dev;
     char state_name[20], baudrate_name[20];
 
-    if (down_interruptible(&rtcan_devices_nrt_lock))
+    if (mutex_lock_interruptible(&rtcan_devices_nrt_lock))
 	return -ERESTARTSYS;
 
     /* Name___________ _Baudrate State___ _TX_Counts _TX_Counts ____Errors
@@ -149,7 +149,7 @@ static int rtcan_read_proc_devices(struct seq_file *p, void *data)
 	}
     }
 
-    up(&rtcan_devices_nrt_lock);
+    mutex_unlock(&rtcan_devices_nrt_lock);
 
     return 0;
 }
@@ -175,7 +175,7 @@ static int rtcan_read_proc_sockets(struct seq_file *p, void *data)
     rtdm_lockctx_t lock_ctx;
     int ifindex;
 
-    if (down_interruptible(&rtcan_devices_nrt_lock))
+    if (mutex_lock_interruptible(&rtcan_devices_nrt_lock))
 	return -ERESTARTSYS;
 
     /* Name___________ Filter ErrMask RX_Timeout TX_Timeout RX_BufFull TX_Lo
@@ -211,7 +211,7 @@ static int rtcan_read_proc_sockets(struct seq_file *p, void *data)
 
     rtdm_lock_put_irqrestore(&rtcan_recv_list_lock, lock_ctx);
 
-    up(&rtcan_devices_nrt_lock);
+    mutex_unlock(&rtcan_devices_nrt_lock);
 
     return 0;
 }
@@ -233,7 +233,7 @@ static int rtcan_read_proc_info(struct seq_file *p, void *data)
     char state_name[20], baudrate_name[20];
     char ctrlmode_name[80], bittime_name[80];
 
-    if (down_interruptible(&rtcan_devices_nrt_lock))
+    if (mutex_lock_interruptible(&rtcan_devices_nrt_lock))
 	return -ERESTARTSYS;
 
     rtcan_dev_get_state_name(dev->state,
@@ -260,7 +260,7 @@ static int rtcan_read_proc_info(struct seq_file *p, void *data)
     seq_printf(p, "Refcount   %d\n", atomic_read(&dev->refcount));
 #endif
 
-    up(&rtcan_devices_nrt_lock);
+    mutex_unlock(&rtcan_devices_nrt_lock);
 
     return 0;
 }
-- 
2.35.3

