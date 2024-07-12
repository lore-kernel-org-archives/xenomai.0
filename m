Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4305B15ADA7
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781342; cv=none; b=OU7rUj4og6d7O0cqIl2skO+cKCNJe+T89aIQIDkHtskFjJty3hwtk1KVAJazNQMWknL7DrP++K4XW/wBxhMnXQbPxycgtIZtGlC71+QpuIZ5WTfOWXZ4xThNXSuMdEQNDff+rkVfBEe2lk7n6uTxtyxSoPj5gLGMSIpYpiQX/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781342; c=relaxed/simple;
	bh=ryzOTvG+pRcDGSBUKStCUEOmRsFxiWjUb7gCTmnMSCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XiVaZWfRUOHfJw6xJ7Li/xa0hbuM45mu73rV8fuNuszbl+GF7wucJ73vvpN3dbQnS5oBTpYaWsusPGWH9YJcQQQPO5Jfe8d8d9rPBi4hYvAdaxbWv2ETOUU+3hojoaxMgK1at8+a1rwzD4BlvXHaqExya9HcXTrYh1e2cJyl19w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ebv6bbpL; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ebv6bbpL"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2024071210485294dad43c5b0e1a75d1
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:48:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4u/7oe752MkgIhB+Oh9DklserihqH3j3n/3MZX+CJnM=;
 b=ebv6bbpL20Q3TePksXWPosTk4KXyALFR/hSW2p9OwUOXPNB8p2fGUvRjMHboXKRhtzP8YJ
 BLUaSaSvuCAJ1KebUg63s9VJQtlCMI7VSwulY+F2t/WF2iVJuY7GhjBX7YnPfP/LEiimYPNK
 c46yEOMekZQ1/UugzEzZ6MCVdy+4Y=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:48:55 +0200
Subject: [PATCH v2 09/33] drivers/net/e1000: Migrate from rtdm_printk() and
 printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-9-facd992606c7@siemens.com>
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
 kernel/drivers/net/drivers/e1000/e1000.h       | 16 +++++++++-------
 kernel/drivers/net/drivers/e1000/e1000_main.c  | 18 +++++++++---------
 kernel/drivers/net/drivers/e1000/e1000_osdep.h |  2 +-
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/kernel/drivers/net/drivers/e1000/e1000.h b/kernel/drivers/net/drivers/e1000/e1000.h
index 978b6ea9c..e38649bbf 100644
--- a/kernel/drivers/net/drivers/e1000/e1000.h
+++ b/kernel/drivers/net/drivers/e1000/e1000.h
@@ -103,18 +103,20 @@ struct e1000_adapter;
 #include "e1000_hw.h"
 
 #ifdef DBG
-#define E1000_DBG(args...) printk(KERN_DEBUG "e1000: " args)
+#define E1000_DBG(args...) pr_debug(args)
 #else
 #define E1000_DBG(args...)
 #endif
 
-#define E1000_ERR(args...) printk(KERN_ERR "e1000: " args)
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#define PFX "e1000: "
-#define DPRINTK(nlevel, klevel, fmt, args...) \
-	(void)((NETIF_MSG_##nlevel & adapter->msg_enable) && \
-	printk(KERN_##klevel PFX "%s: %s: " fmt, adapter->netdev->name, \
-		__FUNCTION__ , ## args))
+#define DPRINTK(nlevel, klevel, fmt, args...)                           \
+	(void)((NETIF_MSG_##nlevel & adapter->msg_enable) &&            \
+	       printk(KERN_##klevel "%s: %s: %s: " fmt, KBUILD_MODNAME, \
+		      adapter->netdev->name, __FUNCTION__, ##args))
+
+#define E1000_ERR(args...) pr_err(args)
 
 #define E1000_MAX_INTR 10
 
diff --git a/kernel/drivers/net/drivers/e1000/e1000_main.c b/kernel/drivers/net/drivers/e1000/e1000_main.c
index bf4fadba9..ff24b6fa6 100644
--- a/kernel/drivers/net/drivers/e1000/e1000_main.c
+++ b/kernel/drivers/net/drivers/e1000/e1000_main.c
@@ -264,10 +264,9 @@ static int __init
 e1000_init_module(void)
 {
 	int ret;
-	printk(KERN_INFO "%s - version %s\n",
-	       e1000_driver_string, e1000_driver_version);
+	pr_info("%s - version %s\n", e1000_driver_string, e1000_driver_version);
 
-	printk(KERN_INFO "%s\n", e1000_copyright);
+	pr_info("%s\n", e1000_copyright);
 
 	ret = pci_register_driver(&e1000_driver);
 	return ret;
@@ -911,9 +910,9 @@ static int e1000_probe(struct pci_dev *pdev,
 		 "32-bit"));
 	}
 
-	printk(KERN_INFO "e1000: hw ");
-	for (i = 0; i < 6; i++)
-		printk(KERN_CONT "%2.2x%c", netdev->dev_addr[i], i == 5 ? '\n' : ':');
+	pr_info("e1000: hw %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x\n",
+		netdev->dev_addr[0], netdev->dev_addr[1], netdev->dev_addr[2],
+		netdev->dev_addr[3], netdev->dev_addr[4], netdev->dev_addr[5]);
 
 	/* reset the hardware with the new settings */
 	e1000_reset(adapter);
@@ -2557,7 +2556,8 @@ e1000_xmit_frame(struct rtskb *skb, struct rtnet_device *netdev)
 	if (unlikely(E1000_DESC_UNUSED(tx_ring) < count + 2)) {
 		rtnetif_stop_queue(netdev);
 		rtdm_lock_put_irqrestore(&tx_ring->tx_lock, context);
-		rtdm_printk("FATAL: rt_e1000 ran into tail close to head situation!\n");
+		pr_err("FATAL: rt_e1000 ran into tail close to"
+		       "head situation!\n");
 		return NETDEV_TX_BUSY;
 	}
 
@@ -2568,8 +2568,8 @@ e1000_xmit_frame(struct rtskb *skb, struct rtnet_device *netdev)
 
 			/* FIXME: warn the user earlier, i.e. on startup if
 			   half-duplex is detected! */
-			rtdm_printk("FATAL: rt_e1000 ran into 82547 "
-				    "controller bug!\n");
+			pr_err("FATAL: rt_e1000 ran into 82547 "
+			       "controller bug!\n");
 			return NETDEV_TX_BUSY;
 		}
 	}
diff --git a/kernel/drivers/net/drivers/e1000/e1000_osdep.h b/kernel/drivers/net/drivers/e1000/e1000_osdep.h
index 8de304848..54d3b8ff9 100644
--- a/kernel/drivers/net/drivers/e1000/e1000_osdep.h
+++ b/kernel/drivers/net/drivers/e1000/e1000_osdep.h
@@ -70,7 +70,7 @@ typedef enum {
     TRUE = 1
 } boolean_t;
 
-#define MSGOUT(S, A, B)	printk(KERN_DEBUG S "\n", A, B)
+#define MSGOUT(S, A, B)	pr_debug(S "\n", A, B)
 
 #ifdef DBG
 #define DEBUGOUT(S)		printk(KERN_DEBUG S "\n")

-- 
2.39.2

