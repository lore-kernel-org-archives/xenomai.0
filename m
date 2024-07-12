Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2455C15B555
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781342; cv=none; b=hKXQUoCyD+sqZ0NIZkOpXBKy5oGZ782lZlFknQt8kZaGbV5G+rgOhEVtDG/Uy8RqEzDJFW+437f0sozwWyXDc0Hg3cfUNh72U6v+tq8SskC728cajDnNFcb3bPzHqNwiQxqsn+UbbVgCB97PFz4xIl1Bpqd+Yu5LSWC9Tsx8Cao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781342; c=relaxed/simple;
	bh=Q7iKBjpaWBk9YRr0qVZ8AxLoizLZQNhSwZCWuGIjdjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KM1KEpQsALOtBC4QbkSC83ChdNbrF5qeXJRIvFG71aKN+949vpXbrgF7fUtxy4i8IDE8fNg9PnjP9jTAqG7tttyuUB2QAajaNxl42NCCqNU6p2wJJWT4MgNIeVwBwbJtYkv5mIcnsCBIz1gUDGrI4NaYfvkRjYM0QuMUAsHeS9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=pU5ksQBb; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="pU5ksQBb"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240712104853fcbc720dc017b67191
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:48:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7WchKUNPh8uMru8ef4wN6hkqp0ONcn4lIrJb4BWMgaI=;
 b=pU5ksQBbLHVMkYYfc36emtcuxToWA8sw6sBBFP3H9BaD9YKKzb5Ffx+EoxUTOUQCkK6UYi
 6Kl7ApoCoSUIuH0FWXybFEveMhXNa9vRQ7GlocfVTt8T2VU8T64B8VM86olilHZZMRDRIOr0
 6sPxevqPLAa3jjViMl5nO7v+pqbX8=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:48:57 +0200
Subject: [PATCH v2 11/33] drivers/experimental/e1000: Migrate from
 rtdm_printk() and printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-11-facd992606c7@siemens.com>
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
 .../drivers/net/drivers/experimental/e1000/e1000.h | 14 ++++++----
 .../net/drivers/experimental/e1000/e1000_main.c    | 32 ++++++++++++----------
 2 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000.h b/kernel/drivers/net/drivers/experimental/e1000/e1000.h
index 8b9830b99..986eeb088 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000.h
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000.h
@@ -47,13 +47,15 @@ struct e1000_adapter;
 
 #define E1000_DBG(args...)
 
-#define E1000_ERR(args...) printk(KERN_ERR "e1000: " args)
+#define E1000_ERR(args...) pr_err(args)
 
-#define PFX "e1000: "
-#define DPRINTK(nlevel, klevel, fmt, args...) \
-	(void)((NETIF_MSG_##nlevel & adapter->msg_enable) && \
-	printk(KERN_##klevel PFX "%s: %s: " fmt, adapter->netdev->name, \
-		__FUNCTION__ , ## args))
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#define DPRINTK(nlevel, klevel, fmt, args...)                           \
+	(void)((NETIF_MSG_##nlevel & adapter->msg_enable) &&            \
+	       printk(KERN_##klevel "%s: %s: %s: " fmt, KBUILD_MODNAME, \
+		      adapter->netdev->name, __FUNCTION__, ##args))
 
 #define E1000_MAX_INTR 10
 
diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
index 76cfb0dee..56f172636 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
@@ -460,11 +460,11 @@ MODULE_PARM_DESC(pciif, "PCI Interface: 'all' (default), 'pci', 'pcie'");
 static int __init e1000_init_module(void)
 {
 	int ret;
-    strcpy(e1000_driver_name, THIS_MODULE->name);
-	printk(KERN_INFO "%s - %s version %s (pciif: %s)\n",
-	       e1000_driver_string, e1000_driver_name, e1000_driver_version, pciif);
+	strcpy(e1000_driver_name, THIS_MODULE->name);
+	pr_info("%s - %s version %s (pciif: %s)\n", e1000_driver_string,
+		e1000_driver_name, e1000_driver_version, pciif);
 
-	printk(KERN_INFO "%s\n", e1000_copyright);
+	pr_info("%s\n", e1000_copyright);
 
 
     if (0 == strcmp(pciif, "pcie"))
@@ -486,10 +486,11 @@ static int __init e1000_init_module(void)
 #endif
 	if (copybreak != COPYBREAK_DEFAULT) {
 		if (copybreak == 0)
-			printk(KERN_INFO "e1000: copybreak disabled\n");
+			pr_info("e1000: copybreak disabled\n");
 		else
-			printk(KERN_INFO "e1000: copybreak enabled for "
-			       "packets <= %u bytes\n", copybreak);
+			pr_info("e1000: copybreak enabled for "
+				"packets <= %u bytes\n",
+				copybreak);
 	}
 	return ret;
 }
@@ -1376,8 +1377,9 @@ static int e1000_probe(struct pci_dev *pdev,
 		 "32-bit"));
 	}
 
-	for (i = 0; i < 6; i++)
-		printk("%2.2x%c", netdev->dev_addr[i], i == 5 ? '\n' : ':');
+	pr_debug("%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x\n", netdev->dev_addr[0],
+		 netdev->dev_addr[1], netdev->dev_addr[2], netdev->dev_addr[3],
+		 netdev->dev_addr[4], netdev->dev_addr[5]);
 
 	/* reset the hardware with the new settings */
 	e1000_reset(adapter);
@@ -3848,7 +3850,7 @@ static int e1000_xmit_frame_ring(struct sk_buff *skb,
 	 * head, otherwise try next time */
 	if (unlikely(e1000_maybe_stop_tx(netdev, tx_ring, count + 2))) {
 		rtdm_lock_put_irqrestore(&tx_ring->tx_lock, irq_flags);
-		rtdm_printk("FATAL: rt_e1000 ran into tail close to head situation!\n");
+		pr_crit("FATAL: rt_e1000 ran into tail close to head situation!\n");
 		return NETDEV_TX_BUSY;
 	}
 
@@ -3859,7 +3861,7 @@ static int e1000_xmit_frame_ring(struct sk_buff *skb,
 			if (!test_bit(__E1000_DOWN, &adapter->state))
 				schedule_delayed_work(&adapter->fifo_stall_task,
 						      1);
-		    rtdm_printk("FATAL: rt_e1000 ran into tail 82547 controller bug!\n");
+			pr_crit("FATAL: rt_e1000 ran into tail 82547 controller bug!\n");
 			return NETDEV_TX_BUSY;
 		}
 	}
@@ -4897,7 +4899,7 @@ static bool e1000_clean_rx_irq(struct e1000_adapter *adapter,
 	bool cleaned = FALSE;
 	unsigned int total_rx_bytes=0, total_rx_packets=0;
 
-	// rtdm_printk("<2> e1000_clean_rx_irq %i\n", __LINE__);
+	// pr_debug("<2> e1000_clean_rx_irq %i\n", __LINE__);
 
 	i = rx_ring->next_to_clean;
 	rx_desc = E1000_RX_DESC(*rx_ring, i);
@@ -5808,7 +5810,7 @@ static int e1000_resume(struct pci_dev *pdev)
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	if ((err = pci_enable_device(pdev))) {
-		printk(KERN_ERR "e1000: Cannot enable PCI device from suspend\n");
+		pr_err("Cannot enable PCI device from suspend\n");
 		return err;
 	}
 	pci_set_master(pdev);
@@ -5909,7 +5911,7 @@ static pci_ers_result_t e1000_io_slot_reset(struct pci_dev *pdev)
 	struct e1000_adapter *adapter = netdev->priv;
 
 	if (pci_enable_device(pdev)) {
-		printk(KERN_ERR "e1000: Cannot re-enable PCI device after reset.\n");
+		pr_err("Cannot re-enable PCI device after reset.\n");
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 	pci_set_master(pdev);
@@ -5940,7 +5942,7 @@ static void e1000_io_resume(struct pci_dev *pdev)
 
 	if (rtnetif_running(netdev)) {
 		if (e1000_up(adapter)) {
-			printk("e1000: can't bring device back up after reset\n");
+			pr_err("can't bring device back up after reset\n");
 			return;
 		}
 	}

-- 
2.39.2

