Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5E3158862
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781945; cv=none; b=fPD525dodswW5GEalddQxTn3CS408XcQYdtLIsv7QQ+B0NA6Ix3EbyOMFhW+x/W0Er4+zOS8rsYLSQOpFbdjV4R5iTmX974NVVN9nnFLCMLR23gh2buVyiP94zbOFM7sr0xkOnUSprOCQkEXH+X5QC4hewY9Q4nxQYvqYna56Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781945; c=relaxed/simple;
	bh=gCizG+ntdYvUnLTXBSJx/s54u0l5l9h5vs/vAjMquGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/O/hgLqlvuFtsO25AQ3vVVsYYFHKsc/pLbp7csb7DDVSnvJiea3dx3kHlli9AWwFc1lAfS5Cfa1soCn2deCOoxl+YPIFOmaf6Ude4JqCTNmXc+iV4dE3YcQ7TDE57TQhX3GBbWIfL8gx3ufF6b6IPlYAr44jSsTaJsnQAFUnfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=jaXFzr5P; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="jaXFzr5P"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240712104853007e0f9da3854dee9c
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:48:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DgQ7BoTPRGwi5wzo6B8AtdeGCpREyN+E0FyZQlMyh54=;
 b=jaXFzr5PimzjVEg8MxKgcEwYfgyaasZ1nlIyYh0ag1kMrbPkhQ5E4Y/OVcCih4oFlXwuQY
 R+jiHLMnGmzZXIhih/1JSovO0ITrdxqH20qxAa9sp4BBxxhecrHdigEs3FHNxWZjd3DmuuNG
 gbIcIXobTNzNhpGDcBjZ3j0QwG6mw=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:48:58 +0200
Subject: [PATCH v2 12/33] drivers/experimental/rt2500: Migrate from
 rtdm_printk() and printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-12-facd992606c7@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

In this case all log levels were correct. Migrating to pr_*() to be
consistent with other drivers.

rtdm_printk() itself is just an alias for printk(). Migrating helps to
remove this function once all drivers were updated.

The DEBUG_PRINTK macro has been removed along with CONFIG_RT2X00_DEBUG.
DEBUG_PRINTK() was never used, CONFIG_RT2X00_DEBUG was missing in
Kconfig.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 .../net/drivers/experimental/rt2500/rt2500pci.c    |  4 +--
 .../net/drivers/experimental/rt2500/rt2x00.h       | 37 ++++------------------
 .../net/drivers/experimental/rt2500/rt2x00core.c   |  7 ++--
 3 files changed, 11 insertions(+), 37 deletions(-)

diff --git a/kernel/drivers/net/drivers/experimental/rt2500/rt2500pci.c b/kernel/drivers/net/drivers/experimental/rt2500/rt2500pci.c
index c89837a03..3438b4818 100644
--- a/kernel/drivers/net/drivers/experimental/rt2500/rt2500pci.c
+++ b/kernel/drivers/net/drivers/experimental/rt2500/rt2500pci.c
@@ -1261,13 +1261,13 @@ struct pci_driver rt2x00_pci_driver = {
 
 static int __init rt2x00_pci_init(void)
 {
-	rtdm_printk(KERN_INFO "Loading module: %s\n", version);
+	pr_info("Loading module: %s\n", version);
 	return pci_register_driver(&rt2x00_pci_driver);
 }
 
 static void __exit rt2x00_pci_exit(void)
 {
-	rtdm_printk(KERN_INFO "Unloading module: %s\n", version);
+	pr_info("Unloading module: %s\n", version);
 	pci_unregister_driver(&rt2x00_pci_driver);
 }
 
diff --git a/kernel/drivers/net/drivers/experimental/rt2500/rt2x00.h b/kernel/drivers/net/drivers/experimental/rt2500/rt2x00.h
index ec8ca90b4..6e06e4e5a 100644
--- a/kernel/drivers/net/drivers/experimental/rt2500/rt2x00.h
+++ b/kernel/drivers/net/drivers/experimental/rt2500/rt2x00.h
@@ -44,25 +44,6 @@
 #define DRV_NAME "rt2x00"
 #define DRV_VERSION "0.1"
 #define DRV_AUTHOR "Daniel Gregorek <dxg@gmx.de>"
-//#define CONFIG_RT2X00_DEBUG
-
-/*
- * Debug defines.
- * The debug variable will be exported by the device specific module.
- * For this reason this variable must be set to extern to make it accessible
- * to the core module as well.
- */
-#ifdef CONFIG_RT2X00_DEBUG
-extern int rt2x00_debug_level;
-#define DEBUG_PRINTK(__message...)                                             \
-	do {                                                                   \
-		rtdm_printk(__message);                                        \
-	} while (0)
-#else /* CONFIG_RT2X00_DEBUG */
-#define DEBUG_PRINTK(__message...)                                             \
-	do {                                                                   \
-	} while (0)
-#endif /* CONFIG_RT2X00_DEBUG */
 
 /*
  * Various debug levels.
@@ -70,23 +51,17 @@ extern int rt2x00_debug_level;
  * these should never be ignored and thus we will always print the message.
  */
 #define PANIC(__message, __args...)                                            \
-	rtdm_printk(KERN_PANIC DRV_NAME "->%s: Panic - " __message,            \
-		    __FUNCTION__, ##__args);
+	pr_emerg(DRV_NAME "->%s: Panic - " __message, __FUNCTION__, ##__args);
 #define ERROR(__message, __args...)                                            \
-	rtdm_printk(KERN_ERR DRV_NAME "->%s: Error - " __message,              \
-		    __FUNCTION__, ##__args);
+	pr_err(DRV_NAME "->%s: Error - " __message, __FUNCTION__, ##__args);
 #define WARNING(__message, __args...)                                          \
-	rtdm_printk(KERN_WARNING DRV_NAME "->%s: Warning - " __message,        \
-		    __FUNCTION__, ##__args);
+	pr_warn(DRV_NAME "->%s: Warning - " __message, __FUNCTION__, ##__args);
 #define NOTICE(__message, __args...)                                           \
-	rtdm_printk(KERN_NOTICE DRV_NAME "->%s: Notice - " __message,          \
-		    __FUNCTION__, ##__args);
+	pr_notice(DRV_NAME "->%s: Notice - " __message, __FUNCTION__, ##__args);
 #define INFO(__message, __args...)                                             \
-	rtdm_printk(KERN_INFO DRV_NAME "->%s: Info - " __message,              \
-		    __FUNCTION__, ##__args);
+	pr_info(DRV_NAME "->%s: Info - " __message, __FUNCTION__, ##__args);
 #define DEBUG(__message, __args...)                                            \
-	DEBUG_PRINTK(KERN_DEBUG DRV_NAME "->%s: Debug - " __message,           \
-		     __FUNCTION__, ##__args);
+	pr_debug(DRV_NAME "->%s: Debug - " __message, __FUNCTION__, ##__args);
 
 /*
  * RT2x00 ring types.
diff --git a/kernel/drivers/net/drivers/experimental/rt2500/rt2x00core.c b/kernel/drivers/net/drivers/experimental/rt2500/rt2x00core.c
index fac5c3e3d..d1d257ae2 100644
--- a/kernel/drivers/net/drivers/experimental/rt2500/rt2x00core.c
+++ b/kernel/drivers/net/drivers/experimental/rt2500/rt2x00core.c
@@ -393,8 +393,7 @@ struct rtnet_device *rt2x00_core_probe(struct _rt2x00_dev_handler *handler,
 
 	if ((err = rt_register_rtnetdev(rtnet_dev)) != 0) {
 		rtdev_free(rtnet_dev);
-		ERROR("rtnet_device registration failed.\n");
-		printk("err=%d\n", err);
+		ERROR("rtnet_device registration failed. err=%d\n", err);
 		goto exit_dev_remove;
 	}
 
@@ -431,13 +430,13 @@ MODULE_LICENSE("GPL");
 
 static int __init rt2x00_core_init(void)
 {
-	printk(KERN_INFO "Loading module: %s\n", version);
+	pr_info("Loading module: %s\n", version);
 	return 0;
 }
 
 static void __exit rt2x00_core_exit(void)
 {
-	printk(KERN_INFO "Unloading module: %s\n", version);
+	pr_info("Unloading module: %s\n", version);
 }
 
 module_init(rt2x00_core_init);

-- 
2.39.2

