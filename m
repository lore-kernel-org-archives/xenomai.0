Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26D6153823
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781944; cv=none; b=mrJe7rbUD6rntSe2DVFII+hK5fp3a7witxwJVEYi7nQcAJUaWjvDXkCIzw6HjVwGFo2+Y9OQXYsefUui2egncMbiiQDPAsvHtEYV8ewUm4rDFAX5SnbgRaKyZPMT6miExlC6vR2ZpV2wK7IBbiXNz7r/hE/bq5FBqFOMGtM2PYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781944; c=relaxed/simple;
	bh=5puk6Rv5Ahun9qu5LOb6sG9f7iWsYTjR27frxlx9zC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=njSQveXrK8IUQbR/vD9QziUUxRc6NDreUHQi3q+aaqyTywoG5V1Wzg8JP8ofS7FeHEQKciDLdD6eDFwuOKT3OIyM1wbosij/Pv+o6Ans9u4RXG0YzO6lnNWhXHJeUdejmVh6DfKDNDUFiWnGid1TESE58m9VXyLVdEE4a6DPn90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=G6Fu4LMc; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="G6Fu4LMc"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240712104851e9ffb11befd6c07125
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:48:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3NZQbqU0fD7fotEnXiLsqsl3JmRN1vOnMTVJuJWwV8o=;
 b=G6Fu4LMcTi4Od6xOlel50ApfV9kcvEf8p3RXjFH+l8S1sJVVstYLdozugfIidQBb4le0Z5
 mI/STf3B23Gz90ivBD9Rteijz0YH7++48TpzjsepFVKb28ZQFmZ5puw6dvmIaYcpRlCf2h2h
 eu2cjH7MaF5Ujd867zgIHOkNY032k=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:48:52 +0200
Subject: [PATCH v2 06/33] drivers/can/sja1000: Migrate from printk() to
 pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-6-facd992606c7@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Some printk() calls were missing log level information. The default
level (= warn) does not fit well for most of them.

The missing log level is addressed by migrating to the pr_*() API.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/can/sja1000/rtcan_adv_pci.c   |  4 +++-
 kernel/drivers/can/sja1000/rtcan_esd_pci.c   | 10 ++++++----
 kernel/drivers/can/sja1000/rtcan_isa.c       |  8 +++++---
 kernel/drivers/can/sja1000/rtcan_ixxat_pci.c | 17 +++++++++--------
 kernel/drivers/can/sja1000/rtcan_mem.c       |  8 +++++---
 kernel/drivers/can/sja1000/rtcan_peak_dng.c  | 25 ++++++++++++-------------
 kernel/drivers/can/sja1000/rtcan_peak_pci.c  | 22 ++++++++++++----------
 kernel/drivers/can/sja1000/rtcan_sja1000.c   | 25 +++++++++++++------------
 8 files changed, 65 insertions(+), 54 deletions(-)

diff --git a/kernel/drivers/can/sja1000/rtcan_adv_pci.c b/kernel/drivers/can/sja1000/rtcan_adv_pci.c
index f09be056b..33724a4c4 100644
--- a/kernel/drivers/can/sja1000/rtcan_adv_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_adv_pci.c
@@ -18,6 +18,8 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
+#define pr_fmt(fmt) "RTcan: " fmt
+
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
@@ -217,7 +219,7 @@ static int rtcan_adv_pci_add_chan(struct pci_dev *pdev,
 	/* Register SJA1000 device */
 	ret = rtcan_sja1000_register(dev);
 	if (ret) {
-		printk(KERN_ERR "ERROR %d while trying to register SJA1000 device!\n",
+		pr_err("ERROR %d while trying to register SJA1000 device!\n",
 		       ret);
 		goto failure_iounmap;
 	}
diff --git a/kernel/drivers/can/sja1000/rtcan_esd_pci.c b/kernel/drivers/can/sja1000/rtcan_esd_pci.c
index 2b5a19caf..795e9f676 100644
--- a/kernel/drivers/can/sja1000/rtcan_esd_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_esd_pci.c
@@ -20,6 +20,8 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
+#define pr_fmt(fmt) "RTcan: " fmt
+
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
@@ -140,8 +142,8 @@ static void rtcan_esd_pci_del_chan(struct rtcan_device *dev)
 
 	board = (struct rtcan_esd_pci *)dev->board_priv;
 
-	printk("Removing %s %s device %s\n",
-		esd_pci_board_name, dev->ctrl_name, dev->name);
+	pr_info("Removing %s %s device %s\n", esd_pci_board_name,
+		dev->ctrl_name, dev->name);
 
 	rtcan_sja1000_unregister(dev);
 
@@ -198,8 +200,8 @@ static int rtcan_esd_pci_add_chan(struct pci_dev *pdev, int channel,
 	/* Register SJA1000 device */
 	ret = rtcan_sja1000_register(dev);
 	if (ret) {
-		printk(KERN_ERR "ERROR %d while trying to register SJA1000 "
-				"device!\n", ret);
+		pr_err("ERROR %d while trying to register SJA1000 device!\n",
+		       ret);
 		goto failure;
 	}
 
diff --git a/kernel/drivers/can/sja1000/rtcan_isa.c b/kernel/drivers/can/sja1000/rtcan_isa.c
index c658fdfc3..9c56b047e 100644
--- a/kernel/drivers/can/sja1000/rtcan_isa.c
+++ b/kernel/drivers/can/sja1000/rtcan_isa.c
@@ -20,6 +20,8 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
+#define pr_fmt(fmt) "RTcan: " fmt
+
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
@@ -135,8 +137,8 @@ static int __init rtcan_isa_init_one(int idx)
 
 	ret = rtcan_sja1000_register(dev);
 	if (ret) {
-		printk(KERN_ERR "ERROR %d while trying to register SJA1000 "
-		       "device!\n", ret);
+		pr_err("ERROR %d while trying to register SJA1000 device!\n",
+		       ret);
 		goto out_free_region;
 	}
 
@@ -174,7 +176,7 @@ static int __init rtcan_isa_init(void)
 	if (devices)
 		return 0;
 
-	printk(KERN_ERR "ERROR! No devices specified! "
+	pr_err("ERROR! No devices specified! "
 	       "Use io=<port1>[,...] irq=<irq1>[,...]\n");
 	return -EINVAL;
 }
diff --git a/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c b/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
index 9c5197f83..ff91c6a12 100644
--- a/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
@@ -16,6 +16,11 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
+#define RTCAN_DEV_NAME "rtcan%d"
+#define RTCAN_DRV_NAME "IXXAT-PCI-CAN"
+
+#define pr_fmt(fmt) RTCAN_DRV_NAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
@@ -32,9 +37,6 @@
 #include <rtcan_sja1000.h>
 #include <rtcan_sja1000_regs.h>
 
-#define RTCAN_DEV_NAME "rtcan%d"
-#define RTCAN_DRV_NAME "IXXAT-PCI-CAN"
-
 static char *ixxat_pci_board_name = "IXXAT-PCI";
 
 MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
@@ -102,8 +104,8 @@ static void rtcan_ixxat_pci_del_chan(struct rtcan_device *dev)
 
     board = (struct rtcan_ixxat_pci *)dev->board_priv;
 
-    printk("Removing %s %s device %s\n",
-	   ixxat_pci_board_name, dev->ctrl_name, dev->name);
+    pr_info("Removing %s %s device %s\n", ixxat_pci_board_name, dev->ctrl_name,
+	    dev->name);
 
     rtcan_sja1000_unregister(dev);
 
@@ -188,9 +190,8 @@ static int rtcan_ixxat_pci_add_chan(struct pci_dev *pdev,
     /* Register SJA1000 device */
     ret = rtcan_sja1000_register(dev);
     if (ret) {
-	printk(KERN_ERR "ERROR %d while trying to register SJA1000 device!\n",
-	       ret);
-	goto failure;
+	    pr_err("ERROR %d while trying to register SJA1000 device!\n", ret);
+	    goto failure;
     }
 
     if (channel != CHANNEL_SLAVE)
diff --git a/kernel/drivers/can/sja1000/rtcan_mem.c b/kernel/drivers/can/sja1000/rtcan_mem.c
index 8c90574c2..980eba979 100644
--- a/kernel/drivers/can/sja1000/rtcan_mem.c
+++ b/kernel/drivers/can/sja1000/rtcan_mem.c
@@ -28,6 +28,8 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
+#define pr_fmt(fmt) "RTcan: " fmt
+
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
@@ -144,8 +146,8 @@ static int __init rtcan_mem_init_one(int idx)
 
 	ret = rtcan_sja1000_register(dev);
 	if (ret) {
-		printk(KERN_ERR "ERROR %d while trying to register SJA1000 "
-		       "device!\n", ret);
+		pr_err("ERROR %d while trying to register SJA1000 device!\n",
+		       ret);
 		goto out_iounmap;
 	}
 
@@ -186,7 +188,7 @@ static int __init rtcan_mem_init(void)
 	if (devices)
 		return 0;
 
-	printk(KERN_ERR "ERROR! No devices specified! "
+	pr_err("ERROR! No devices specified! "
 	       "Use mem=<port1>[,...] irq=<irq1>[,...]\n");
 	return -EINVAL;
 }
diff --git a/kernel/drivers/can/sja1000/rtcan_peak_dng.c b/kernel/drivers/can/sja1000/rtcan_peak_dng.c
index f949c7669..e201bf2ad 100644
--- a/kernel/drivers/can/sja1000/rtcan_peak_dng.c
+++ b/kernel/drivers/can/sja1000/rtcan_peak_dng.c
@@ -21,6 +21,11 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
+#define RTCAN_DEV_NAME    "rtcan%d"
+#define RTCAN_DRV_NAME    "PEAK-Dongle"
+
+#define pr_fmt(fmt) RTCAN_DRV_NAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/version.h>
@@ -36,9 +41,6 @@
 #include <rtcan_sja1000.h>
 #include <rtcan_sja1000_regs.h>
 
-#define RTCAN_DEV_NAME    "rtcan%d"
-#define RTCAN_DRV_NAME    "PEAK-Dongle"
-
 #define RTCAN_PEAK_DNG_MAX_DEV 1
 
 static char *dongle_board_name = "PEAK-Dongle";
@@ -164,7 +166,7 @@ static void dongle_set_ecr(u16 port, struct rtcan_peak_dng *dng)
     outb((dng->old_ecr & 0x1F) | 0x20, ecr);
 
     if (dng->old_ecr == 0xff)
-	printk(KERN_DEBUG "%s: realy ECP mode configured?\n", RTCAN_DRV_NAME);
+	pr_debug("really ECP mode configured?\n");
 }
 
 static void dongle_restore_ecr(u16 port, struct rtcan_peak_dng *dng)
@@ -173,7 +175,7 @@ static void dongle_restore_ecr(u16 port, struct rtcan_peak_dng *dng)
 
     outb(dng->old_ecr, ecr);
 
-    printk(KERN_DEBUG "%s: restore ECR\n", RTCAN_DRV_NAME);
+    pr_debug("restore ECR\n");
 }
 
 static inline void rtcan_peak_dng_enable(struct rtcan_device *dev)
@@ -220,8 +222,7 @@ static int __init rtcan_peak_dng_init_one(int idx)
     else if (strncmp(type[idx], "epp", 3) == 0)
 	dtype = DONGLE_TYPE_EPP;
     else {
-	printk("%s: type %s is invalid, use \"sp\" or \"epp\".",
-	       RTCAN_DRV_NAME, type[idx]);
+	pr_debug("type %s is invalid, use \"sp\" or \"epp\".", type[idx]);
 	return -EINVAL;
     }
 
@@ -283,9 +284,8 @@ static int __init rtcan_peak_dng_init_one(int idx)
     /* Register RTDM device */
     ret = rtcan_sja1000_register(dev);
     if (ret) {
-	printk(KERN_ERR "ERROR while trying to register SJA1000 device %d!\n",
-	       ret);
-	goto out_free_region2;
+	    pr_err("ERROR while trying to register SJA1000 device %d!\n", ret);
+	    goto out_free_region2;
     }
 
     rtcan_peak_dng_devs[idx] = dev;
@@ -369,7 +369,7 @@ static int __init rtcan_peak_dng_init(void)
 	 i++) {
 
 	if ((ret = rtcan_peak_dng_init_one(i)) != 0) {
-	    printk(KERN_ERR "%s: Init failed with %d\n", RTCAN_DRV_NAME, ret);
+	    pr_err("Init failed with %d\n", ret);
 	    goto cleanup;
 	}
 	done++;
@@ -377,8 +377,7 @@ static int __init rtcan_peak_dng_init(void)
     if (done)
 	return 0;
 
-    printk(KERN_ERR "%s: Please specify type=epp or type=sp\n",
-	   RTCAN_DRV_NAME);
+    pr_err("Please specify type=epp or type=sp\n");
 
 cleanup:
     rtcan_peak_dng_exit();
diff --git a/kernel/drivers/can/sja1000/rtcan_peak_pci.c b/kernel/drivers/can/sja1000/rtcan_peak_pci.c
index 19f728b41..dfae45a87 100644
--- a/kernel/drivers/can/sja1000/rtcan_peak_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_peak_pci.c
@@ -21,6 +21,11 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
+#define RTCAN_DEV_NAME    "rtcan%d"
+#define RTCAN_DRV_NAME    "PEAK-PCI-CAN"
+
+#define pr_fmt(fmt) RTCAN_DRV_NAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
@@ -36,8 +41,7 @@
 #include <rtcan_sja1000.h>
 #include <rtcan_sja1000_regs.h>
 
-#define RTCAN_DEV_NAME    "rtcan%d"
-#define RTCAN_DRV_NAME    "PEAK-PCI-CAN"
+
 
 static char *peak_pci_board_name = "PEAK-PCI";
 
@@ -138,7 +142,7 @@ static void rtcan_peak_pci_del_chan(struct rtcan_device *dev,
 
     switch (init_step) {
     case 0:			/* Full cleanup */
-	printk("Removing %s %s device %s\n",
+	pr_info("Removing %s %s device %s\n",
 	       peak_pci_board_name, dev->ctrl_name, dev->name);
 	rtcan_sja1000_unregister(dev);
 	fallthrough;
@@ -260,15 +264,14 @@ static int rtcan_peak_pci_add_chan(struct pci_dev *pdev, int channel,
     writew(pita_icr_high, board->conf_addr + PITA_ICR + 2);
     init_step = 5;
 
-    printk("%s: base_addr=%p conf_addr=%p irq=%d\n", RTCAN_DRV_NAME,
-	   board->base_addr, board->conf_addr, chip->irq_num);
+    pr_info("base_addr=%p conf_addr=%p irq=%d\n", board->base_addr,
+	    board->conf_addr, chip->irq_num);
 
     /* Register SJA1000 device */
     ret = rtcan_sja1000_register(dev);
     if (ret) {
-	printk(KERN_ERR
-	       "ERROR %d while trying to register SJA1000 device!\n", ret);
-	goto failure;
+	    pr_err("ERROR %d while trying to register SJA1000 device!\n", ret);
+	    goto failure;
     }
 
     if (channel != CHANNEL_SLAVE)
@@ -291,8 +294,7 @@ static int peak_pci_init_one(struct pci_dev *pdev,
     if (!rtdm_available())
 	return -ENODEV;
 
-    printk("%s: initializing device %04x:%04x\n",
-	   RTCAN_DRV_NAME,  pdev->vendor, pdev->device);
+    pr_info("initializing device %04x:%04x\n", pdev->vendor, pdev->device);
 
     if ((ret = pci_enable_device (pdev)))
 	goto failure;
diff --git a/kernel/drivers/can/sja1000/rtcan_sja1000.c b/kernel/drivers/can/sja1000/rtcan_sja1000.c
index 887c4e493..073a34325 100644
--- a/kernel/drivers/can/sja1000/rtcan_sja1000.c
+++ b/kernel/drivers/can/sja1000/rtcan_sja1000.c
@@ -34,6 +34,8 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
+#define pr_fmt(fmt) "RTcan: " fmt
+
 #include <linux/module.h>
 
 #include <rtdm/driver.h>
@@ -634,7 +636,7 @@ static int rtcan_sja_set_bit_time(struct rtcan_device *dev,
 	return -EINVAL;
     }
 
-    printk("%s: btr0=%#x btr1=%#x\n", __func__, btr0, btr1);
+    pr_debug("%s: btr0=%#x btr1=%#x\n", __func__, btr0, btr1);
     chip->write_reg(dev, SJA_BTR0, btr0);
     chip->write_reg(dev, SJA_BTR1, btr1);
 
@@ -759,7 +761,7 @@ int rtcan_sja1000_register(struct rtcan_device *dev)
 
     if ((chip->read_reg(dev, SJA_SR) &
 	 (SJA_SR_RBS | SJA_SR_DOS | SJA_SR_TBS)) != SJA_SR_TBS) {
-	printk("ERROR! No SJA1000 device found!\n");
+	pr_err("ERROR! No SJA1000 device found!\n");
 	return -ENODEV;
     }
 
@@ -780,10 +782,10 @@ int rtcan_sja1000_register(struct rtcan_device *dev)
 			   chip->irq_num, rtcan_sja_interrupt,
 			   chip->irq_flags, sja_ctrl_name, dev);
     if (ret) {
-	printk(KERN_ERR "ERROR %d: IRQ %d is %s!\n",
-	       ret, chip->irq_num, ret == -EBUSY ?
-	       "busy, check shared interrupt support" : "invalid");
-	return ret;
+	    pr_err("ERROR %d: IRQ %d is %s!\n", ret, chip->irq_num,
+		   ret == -EBUSY ? "busy, check shared interrupt support" :
+				   "invalid");
+	    return ret;
     }
 
     sja1000_chip_config(dev);
@@ -791,9 +793,8 @@ int rtcan_sja1000_register(struct rtcan_device *dev)
     /* Register RTDM device */
     ret = rtcan_dev_register(dev);
     if (ret) {
-	    printk(KERN_ERR
-		   "ERROR %d while trying to register RTCAN device!\n", ret);
-	goto out_irq_free;
+	    pr_err("ERROR %d while trying to register RTCAN device!\n", ret);
+	    goto out_irq_free;
     }
 
     rtcan_sja_create_proc(dev);
@@ -810,7 +811,7 @@ int rtcan_sja1000_register(struct rtcan_device *dev)
 /* Cleanup module */
 void rtcan_sja1000_unregister(struct rtcan_device *dev)
 {
-    printk("Unregistering SJA1000 device %s\n", dev->name);
+    pr_info("Unregistering SJA1000 device %s\n", dev->name);
 
     rtdm_irq_disable(&dev->irq_handle);
     rtcan_sja_mode_stop(dev, NULL);
@@ -824,14 +825,14 @@ static int __init rtcan_sja_init(void)
 	if (!rtdm_available())
 		return -ENOSYS;
 
-	printk("RTCAN SJA1000 driver initialized\n");
+	pr_info("RTCAN SJA1000 driver initialized\n");
 	return 0;
 }
 
 
 static void __exit rtcan_sja_exit(void)
 {
-	printk("%s removed\n", sja_ctrl_name);
+	pr_info("%s removed\n", sja_ctrl_name);
 }
 
 module_init(rtcan_sja_init);

-- 
2.39.2

