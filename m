Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C317B419
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013154; cv=none; b=nnfpmxgQCzC1G0yKg13AYVSF8A0UjNS9sPdVkpBDwiTsoUwfKBfqJk0jNj1zfP2Of/TJVVRqVMDkd/cNbNuFfkxV5JmEhY1w11Gdd2KGUJeZsK0e1172Q7B9LEOWsn/LNqevZFwWiIEnKTMaiNOWDDGsMLGQ51UzSIAA5xi8fek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013154; c=relaxed/simple;
	bh=E+JS9xpMucX+8jRu+kMl1tYzMJVdphKAyjn3mZ93NtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e5uyahATXkYsdLYdmu0P3fVhq0fz3AucTBI4lxmnsGAK/K0xo35P9eAQytqB4dZOq0lh7ePpqfUgE5/RVOM8YW5nva2gakhEm0jzuvUDoSMLHGIhTJ4uVfUjpmYiL6FJSTTsBm7sg2W6e0j4T/Te1AEDIwbZN3uNiB73fXWbe5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=JKIgyV91; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="JKIgyV91"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2024070313254980e34c8f5a69291499
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RMVFv3O1v+Uc9lE6RDY+Wft81UirzMQX7e4Ny217bE8=;
 b=JKIgyV91WoLCzCd3Fzy42u2GpDyq+Ms7Mr55x37OflC645MLgsJFZ5rNFRUfh7BRC5Bq68
 Tzrcezj8CYYj5KVHq6tdaKOeEzEDvJnWJ3ceBnB2VqJgynu4OHhWkKOXov3COC05iZP8V1yl
 TBDhPmjO909A6Sy10Ion9S3VRFOn4=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:52 +0200
Subject: [PATCH 29/33] drivers/stack/rtmac: Migrate from rtdm_printk() and
 printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-29-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Some (rtdm_)printk() calls were missing log level information. The
default level (= warn) did not fit well for them.

The missing log level is addressed by migrating the pr_*() API.

rtdm_printk() itself is just an alias for printk(). Migrating helps to
remove this function once all drivers were updated.

The print_jobs() macro was unused. Cleaning up instead of doing the
migration.

No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/stack/include/rtmac/tdma/tdma.h  |  9 ---------
 kernel/drivers/net/stack/rtmac/nomac/nomac_module.c |  6 ++++--
 kernel/drivers/net/stack/rtmac/rtmac_disc.c         | 14 +++++++-------
 kernel/drivers/net/stack/rtmac/rtmac_module.c       |  6 ++++--
 kernel/drivers/net/stack/rtmac/rtmac_proc.c         |  4 +++-
 kernel/drivers/net/stack/rtmac/rtmac_proto.c        |  9 +++++----
 kernel/drivers/net/stack/rtmac/rtmac_vnic.c         |  4 +++-
 kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c    | 10 ++++++----
 kernel/drivers/net/stack/rtmac/tdma/tdma_module.c   |  7 ++++---
 kernel/drivers/net/stack/rtmac/tdma/tdma_proto.c    | 15 +++++++--------
 10 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/kernel/drivers/net/stack/include/rtmac/tdma/tdma.h b/kernel/drivers/net/stack/include/rtmac/tdma/tdma.h
index 9574c2dca..84cab716d 100644
--- a/kernel/drivers/net/stack/include/rtmac/tdma/tdma.h
+++ b/kernel/drivers/net/stack/include/rtmac/tdma/tdma.h
@@ -149,13 +149,4 @@ struct tdma_priv {
 
 extern struct rtmac_disc tdma_disc;
 
-#define print_jobs()                                                           \
-	do {                                                                   \
-		struct tdma_job *entry;                                        \
-		rtdm_printk("%s:%d - ", __FUNCTION__, __LINE__);               \
-		list_for_each_entry (entry, &tdma->first_job->entry, entry)    \
-			rtdm_printk("%d ", entry->id);                         \
-		rtdm_printk("\n");                                             \
-	} while (0)
-
 #endif /* __TDMA_H_ */
diff --git a/kernel/drivers/net/stack/rtmac/nomac/nomac_module.c b/kernel/drivers/net/stack/rtmac/nomac/nomac_module.c
index 1a36e3363..3bd2b0d69 100644
--- a/kernel/drivers/net/stack/rtmac/nomac/nomac_module.c
+++ b/kernel/drivers/net/stack/rtmac/nomac/nomac_module.c
@@ -22,6 +22,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTmac/NoMAC: " fmt
+
 #include <linux/init.h>
 #include <linux/module.h>
 
@@ -131,7 +133,7 @@ static int __init nomac_init(void)
 {
 	int ret;
 
-	printk("RTmac/NoMAC: init void media access control mechanism\n");
+	pr_info("init void media access control mechanism\n");
 
 	ret = nomac_proto_init();
 	if (ret < 0)
@@ -151,7 +153,7 @@ static void nomac_release(void)
 	rtmac_disc_deregister(&nomac_disc);
 	nomac_proto_cleanup();
 
-	printk("RTmac/NoMAC: unloaded\n");
+	pr_info("unloaded\n");
 }
 
 module_init(nomac_init);
diff --git a/kernel/drivers/net/stack/rtmac/rtmac_disc.c b/kernel/drivers/net/stack/rtmac/rtmac_disc.c
index 5806db19d..d5b0a7a63 100644
--- a/kernel/drivers/net/stack/rtmac/rtmac_disc.c
+++ b/kernel/drivers/net/stack/rtmac/rtmac_disc.c
@@ -22,6 +22,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTmac: " fmt
+
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
@@ -58,8 +60,8 @@ int rtmac_disc_attach(struct rtnet_device *rtdev, struct rtmac_disc *disc)
 	RTNET_ASSERT(disc->attach != NULL, return -EINVAL;);
 
 	if (rtdev->mac_disc) {
-		printk("RTmac: another discipline for rtdev '%s' active.\n",
-		       rtdev->name);
+		pr_info("another discipline for rtdev '%s' active.\n",
+			rtdev->name);
 		return -EBUSY;
 	}
 
@@ -77,7 +79,7 @@ int rtmac_disc_attach(struct rtnet_device *rtdev, struct rtmac_disc *disc)
 	/* alloc memory */
 	priv = kmalloc(sizeof(struct rtmac_priv) + disc->priv_size, GFP_KERNEL);
 	if (!priv) {
-		printk("RTmac: kmalloc returned NULL for rtmac!\n");
+		pr_err("kmalloc returned NULL for rtmac!\n");
 		return -ENOMEM;
 	}
 	priv->orig_start_xmit = rtdev->start_xmit;
@@ -98,8 +100,7 @@ int rtmac_disc_attach(struct rtnet_device *rtdev, struct rtmac_disc *disc)
 	/* create the VNIC */
 	ret = rtmac_vnic_add(rtdev, disc->vnic_xmit);
 	if (ret < 0) {
-		printk("RTmac: Warning, VNIC creation failed for rtdev %s.\n",
-		       rtdev->name);
+		pr_warn("VNIC creation failed for rtdev %s.\n", rtdev->name);
 		goto err_disc_detach;
 	}
 
@@ -205,8 +206,7 @@ int __rtmac_disc_register(struct rtmac_disc *disc, struct module *module)
 	disc->owner = module;
 
 	if (rtmac_get_disc_by_name(disc->name) != NULL) {
-		printk("RTmac: discipline '%s' already registered!\n",
-		       disc->name);
+		pr_info("discipline '%s' already registered!\n", disc->name);
 		return -EBUSY;
 	}
 
diff --git a/kernel/drivers/net/stack/rtmac/rtmac_module.c b/kernel/drivers/net/stack/rtmac/rtmac_module.c
index 0a4e1b750..d4174dd32 100644
--- a/kernel/drivers/net/stack/rtmac/rtmac_module.c
+++ b/kernel/drivers/net/stack/rtmac/rtmac_module.c
@@ -19,6 +19,8 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#define pr_fmt(fmt) "RTmac: " fmt
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -34,7 +36,7 @@ static int __init rtmac_init(void)
 {
 	int ret = 0;
 
-	printk("RTmac: init realtime media access control\n");
+	pr_info("init realtime media access control\n");
 
 #ifdef CONFIG_XENO_OPT_VFILE
 	ret = rtmac_proc_register();
@@ -70,7 +72,7 @@ static void rtmac_release(void)
 	rtmac_proc_release();
 #endif
 
-	printk("RTmac: unloaded\n");
+	pr_info("unloaded\n");
 }
 
 module_init(rtmac_init);
diff --git a/kernel/drivers/net/stack/rtmac/rtmac_proc.c b/kernel/drivers/net/stack/rtmac/rtmac_proc.c
index 3f0c3aa4e..5df5c2e8a 100644
--- a/kernel/drivers/net/stack/rtmac/rtmac_proc.c
+++ b/kernel/drivers/net/stack/rtmac/rtmac_proc.c
@@ -22,6 +22,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTmac: " fmt
+
 #include <linux/module.h>
 
 #include <rtnet_internal.h>
@@ -118,7 +120,7 @@ err2:
 	xnvfile_destroy_dir(&rtmac_proc_root);
 
 err1:
-	/*ERRMSG*/ printk("RTmac: unable to initialize /proc entries\n");
+	/*ERRMSG*/ pr_err("unable to initialize /proc entries\n");
 	return err;
 }
 
diff --git a/kernel/drivers/net/stack/rtmac/rtmac_proto.c b/kernel/drivers/net/stack/rtmac/rtmac_proto.c
index 5d9d834a1..45c5f179a 100644
--- a/kernel/drivers/net/stack/rtmac/rtmac_proto.c
+++ b/kernel/drivers/net/stack/rtmac/rtmac_proto.c
@@ -22,6 +22,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTmac: " fmt
+
 #include <rtdm/driver.h>
 #include <stack_mgr.h>
 #include <rtmac/rtmac_disc.h>
@@ -41,10 +43,9 @@ static int rtmac_proto_rx(struct rtskb *skb, struct rtpacket_type *pt)
 	rtskb_pull(skb, sizeof(struct rtmac_hdr));
 
 	if (hdr->ver != RTMAC_VERSION) {
-		rtdm_printk(
-			"RTmac: received unsupported RTmac protocol version on "
-			"device %s.  Got 0x%x but expected 0x%x\n",
-			skb->rtdev->name, hdr->ver, RTMAC_VERSION);
+		pr_err("received unsupported RTmac protocol version on "
+		       "device %s.  Got 0x%x but expected 0x%x\n",
+		       skb->rtdev->name, hdr->ver, RTMAC_VERSION);
 		goto error;
 	}
 
diff --git a/kernel/drivers/net/stack/rtmac/rtmac_vnic.c b/kernel/drivers/net/stack/rtmac/rtmac_vnic.c
index 4b41785db..b4464f21b 100644
--- a/kernel/drivers/net/stack/rtmac/rtmac_vnic.c
+++ b/kernel/drivers/net/stack/rtmac/rtmac_vnic.c
@@ -19,6 +19,8 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#define pr_fmt(fmt) "RTmac: " fmt
+
 #include <linux/moduleparam.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
@@ -106,7 +108,7 @@ static void rtmac_vnic_signal_handler(rtdm_nrtsig_t *nrtsig, void *arg)
 
 			netif_rx(skb);
 		} else {
-			printk("RTmac: VNIC fails to allocate linux skb\n");
+			pr_err("VNIC fails to allocate linux skb\n");
 			kfree_rtskb(rtskb);
 		}
 	}
diff --git a/kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c b/kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c
index 02230064d..9805305b9 100644
--- a/kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c
+++ b/kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c
@@ -22,6 +22,8 @@
  *
  */
 
+#define pr_fmt(fmt) "TDMA: " fmt
+
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/uaccess.h>
@@ -108,7 +110,7 @@ static int tdma_ioctl_master(struct rtnet_device *rtdev,
 		tdma->sync_job.id = WAIT_ON_SYNC;
 	} else {
 		if (test_bit(TDMA_FLAG_BACKUP_MASTER, &tdma->flags))
-			printk("TDMA: warning, no primary master detected!\n");
+			pr_warn("no primary master detected!\n");
 		set_bit(TDMA_FLAG_CALIBRATED, &tdma->flags);
 		tdma->current_cycle_start = rtdm_clock_read();
 	}
@@ -255,9 +257,9 @@ static void copyback_calibration(struct rt_proc_call *call, void *priv_data)
 	do_div(min, 1000);
 	max += 500;
 	do_div(max, 1000);
-	printk("TDMA: calibrated master-to-slave packet delay: "
-	       "%ld us (min/max: %ld/%ld us)\n",
-	       (unsigned long)average, (unsigned long)min, (unsigned long)max);
+	pr_info("calibrated master-to-slave packet delay: "
+		"%ld us (min/max: %ld/%ld us)\n",
+		(unsigned long)average, (unsigned long)min, (unsigned long)max);
 }
 
 static void cleanup_calibration(void *priv_data)
diff --git a/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c b/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
index 2269fa2d9..77ad1200b 100644
--- a/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
+++ b/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
@@ -22,6 +22,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTmac/TDMA: " fmt
+
 #include <asm/div64.h>
 #include <linux/delay.h>
 #include <linux/init.h>
@@ -293,8 +295,7 @@ static int __init tdma_init(void)
 {
 	int ret;
 
-	printk("RTmac/TDMA: init time division multiple access control "
-	       "mechanism\n");
+	pr_info("init time division multiple access control mechanism\n");
 
 	ret = rtmac_disc_register(&tdma_disc);
 	if (ret < 0)
@@ -307,7 +308,7 @@ static void tdma_release(void)
 {
 	rtmac_disc_deregister(&tdma_disc);
 
-	printk("RTmac/TDMA: unloaded\n");
+	pr_info("unloaded\n");
 }
 
 module_init(tdma_init);
diff --git a/kernel/drivers/net/stack/rtmac/tdma/tdma_proto.c b/kernel/drivers/net/stack/rtmac/tdma/tdma_proto.c
index b371c6398..472ec47be 100644
--- a/kernel/drivers/net/stack/rtmac/tdma/tdma_proto.c
+++ b/kernel/drivers/net/stack/rtmac/tdma/tdma_proto.c
@@ -22,6 +22,8 @@
  *
  */
 
+#define pr_fmt(fmt) "TDMA: " fmt
+
 #include <linux/init.h>
 #include "asm/div64.h"
 
@@ -72,7 +74,7 @@ void tdma_xmit_sync_frame(struct tdma_priv *tdma)
 	return;
 
 err_out:
-	/*ERROR*/ rtdm_printk("TDMA: Failed to transmit sync frame!\n");
+	/*ERROR*/ pr_err("Failed to transmit sync frame!\n");
 	return;
 }
 
@@ -120,8 +122,7 @@ int tdma_xmit_request_cal_frame(struct tdma_priv *tdma, u32 reply_cycle,
 	return 0;
 
 err_out:
-	/*ERROR*/ rtdm_printk("TDMA: Failed to transmit request calibration "
-			      "frame!\n");
+	/*ERROR*/ pr_err("Failed to transmit request calibration frame!\n");
 	return ret;
 }
 
@@ -262,9 +263,8 @@ int tdma_packet_rx(struct rtskb *rtskb)
 				sizeof(struct tdma_frm_rpl_cal) + 15,
 			&tdma->cal_rtskb_pool);
 		if (unlikely(!reply_rtskb)) {
-			/*ERROR*/ rtdm_printk(
-				"TDMA: Too many calibration requests "
-				"pending!\n");
+			/*ERROR*/ pr_err("Too many calibration requests "
+					 "pending!\n");
 			break;
 		}
 
@@ -370,8 +370,7 @@ int tdma_packet_rx(struct rtskb *rtskb)
 		break;
 
 	default:
-		/*ERROR*/ rtdm_printk("TDMA: Unknown frame %d!\n",
-				      ntohs(head->id));
+		/*ERROR*/ pr_err("Unknown frame %d!\n", ntohs(head->id));
 	}
 
 kfree_out:

-- 
2.39.2

