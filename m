Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE49CC8ED
	for <xenomai@lists.linux.dev>; Wed, 31 May 2023 11:11:30 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202305311111267d16139e3ba2a6ec40
        for <xenomai@lists.linux.dev>;
        Wed, 31 May 2023 13:11:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=LsE1uwMJ61tjyp+/zoHbAGtVgPJfOxLQvZH8Fi6VU/Y=;
 b=SPgFDwA/Tfrj8dFkkZ8POZaf79fkb2Uvyff914uGB/eSgma1ukmAkJ2/iOltqjfoFHQ+4B
 30pgdqR2qieQ7ClDeZFpDjt0/70xa3OaxH/PaUNlRkMYKS9Kr98m1l0CuRxHsmaS1HVhb+81
 kaKWnNC+CVzz+2q/pQbioayEnJ/7k=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH [REPOST] 1/4] kernel: Account for signature change of class_create in 6.4
Date: Wed, 31 May 2023 13:11:23 +0200
Message-Id: <ee2d8907dae99e99fb9e69625b02154b8a885939.1685531485.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1685531485.git.jan.kiszka@siemens.com>
References: <cover.1685531485.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/pipe.c                    | 4 ++++
 kernel/cobalt/rtdm/device.c             | 4 ++++
 kernel/drivers/gpio/gpio-core.c         | 4 ++++
 kernel/drivers/net/stack/rtnet_module.c | 4 ++++
 kernel/drivers/spi/spi-master.c         | 7 +++++--
 5 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/pipe.c b/kernel/cobalt/pipe.c
index 33181101a0..7519f31651 100644
--- a/kernel/cobalt/pipe.c
+++ b/kernel/cobalt/pipe.c
@@ -1149,7 +1149,11 @@ int xnpipe_mount(void)
 		state->nroutq = 0;
 	}
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6,4,0)
+	xnpipe_class = class_create("rtpipe");
+#else
 	xnpipe_class = class_create(THIS_MODULE, "rtpipe");
+#endif
 	if (IS_ERR(xnpipe_class)) {
 		printk(XENO_ERR "error creating rtpipe class, err=%ld\n",
 		       PTR_ERR(xnpipe_class));
diff --git a/kernel/cobalt/rtdm/device.c b/kernel/cobalt/rtdm/device.c
index 33db21e63b..9d6837c393 100644
--- a/kernel/cobalt/rtdm/device.c
+++ b/kernel/cobalt/rtdm/device.c
@@ -630,7 +630,11 @@ int __init rtdm_init(void)
 {
 	xntree_init(&protocol_devices);
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6,4,0)
+	rtdm_class = class_create("rtdm");
+#else
 	rtdm_class = class_create(THIS_MODULE, "rtdm");
+#endif
 	if (IS_ERR(rtdm_class)) {
 		printk(XENO_ERR "cannot create RTDM sysfs class\n");
 		return PTR_ERR(rtdm_class);
diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index e58bce1616..ba5014f8bd 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -415,7 +415,11 @@ int rtdm_gpiochip_add(struct rtdm_gpio_chip *rgc,
 {
 	int ret;
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6,4,0)
+	rgc->devclass = class_create(gc->label);
+#else
 	rgc->devclass = class_create(gc->owner, gc->label);
+#endif
 	if (IS_ERR(rgc->devclass)) {
 		printk(XENO_ERR "cannot create sysfs class\n");
 		return PTR_ERR(rgc->devclass);
diff --git a/kernel/drivers/net/stack/rtnet_module.c b/kernel/drivers/net/stack/rtnet_module.c
index 16dc91fda0..37c61289f6 100644
--- a/kernel/drivers/net/stack/rtnet_module.c
+++ b/kernel/drivers/net/stack/rtnet_module.c
@@ -324,7 +324,11 @@ int __init rtnet_init(void)
 	printk("\n*** RTnet for Xenomai v" XENO_VERSION_STRING " ***\n\n");
 	printk("RTnet: initialising real-time networking\n");
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6,4,0)
+	rtnet_class = class_create("rtnet");
+#else
 	rtnet_class = class_create(THIS_MODULE, "rtnet");
+#endif
 	if (IS_ERR(rtnet_class))
 		return PTR_ERR(rtnet_class);
 
diff --git a/kernel/drivers/spi/spi-master.c b/kernel/drivers/spi/spi-master.c
index ccc50eedee..6c3af409d3 100644
--- a/kernel/drivers/spi/spi-master.c
+++ b/kernel/drivers/spi/spi-master.c
@@ -372,8 +372,11 @@ int __rtdm_spi_setup_driver(struct rtdm_spi_master *master)
 {
 	master->classname = kstrdup(
 		dev_name(&master->controller->dev), GFP_KERNEL);
-	master->devclass = class_create(THIS_MODULE,
-		master->classname);
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6,4,0)
+	master->devclass = class_create(master->classname);
+#else
+	master->devclass = class_create(THIS_MODULE, master->classname);
+#endif
 	if (IS_ERR(master->devclass)) {
 		kfree(master->classname);
 		printk(XENO_ERR "cannot create sysfs class\n");
-- 
2.35.3

