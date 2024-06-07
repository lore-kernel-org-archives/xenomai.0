Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEB5194C69
	for <xenomai@lists.linux.dev>; Fri,  7 Jun 2024 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767969; cv=none; b=dEiLsdDkH+FDfny7rbEPfGyWey6dNBYe2RS7HxeK3f224YiAmMEvFi4Ur2x+ERBTEacQdIV61t/mWcL9X3ezLeDhavW663T/4BvJ2m3P4Co5cidhi91C96kT21hrNyv5BzpjGDJcCnhxPtijdBUC9iqRry6oy+mztLQbeYBr0n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767969; c=relaxed/simple;
	bh=0FyR1jVHh9rsDDcRLs2iBtdkRvsbo0TojLojfV8e8EI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gR/6R4g0J31Im+RKFUvsOfTXMeNF3oWxH8iTpUDN/qHMZ4FZVu2YArSmTVHiK0x+fI9/cHKoeprwlvOJrHncFBBYQdxmvnEJ5vnMiIuEu02P6AeQPtxGWFfYi28AUiBhtls2xnUyXG/viYRhGlvhTt4LuI+AuQYMPGLiEXgWo1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=iFxWQBDi; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="iFxWQBDi"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2024060713460387ed00490b6384110c
        for <xenomai@lists.linux.dev>;
        Fri, 07 Jun 2024 15:46:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RCKzh0VBKEhex4Ozm9pk0BLBcFbGv8i0cfgtafbU5jM=;
 b=iFxWQBDiN7pLJk4diyYQLkoxkjrFJlalhfiMMtw0sg5hkhK2XARwcXDTvFMLhppcm0I14q
 1IXOw8Q+v8m4b9zFQeNfBgXzIEnJ0yfcHN2mXQ6HEEeWlh0gNWvTJaBj5gdwvStgR9n3dLSI
 V3Whq3bdSqtEEeLTz0W/aSN7UYAVw=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v2 1/3] drivers/gpio: Add driver for BCM2711-based SoCs
Date: Fri,  7 Jun 2024 15:45:49 +0200
Message-Id: <20240607134551.3450170-2-clara.kowalsky@siemens.com>
In-Reply-To: <20240607134551.3450170-1-clara.kowalsky@siemens.com>
References: <20240607134551.3450170-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Add support for BCM2711 pin control driver.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 .gitlab-ci.yml                     |  1 +
 kernel/drivers/gpio/Kconfig        |  8 ++++++++
 kernel/drivers/gpio/Makefile       |  2 ++
 kernel/drivers/gpio/gpio-bcm2711.c | 27 +++++++++++++++++++++++++++
 4 files changed, 38 insertions(+)
 create mode 100644 kernel/drivers/gpio/gpio-bcm2711.c

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 21df3c879..7929a7efa 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -153,6 +153,7 @@ variables:
     - ./scripts/config -e GPIOLIB
     - ./scripts/config -e XENO_DRIVERS_GPIO
     - ./scripts/config -e XENO_DRIVERS_GPIO_BCM2835
+    - ./scripts/config -e XENO_DRIVERS_GPIO_BCM2711
     - ./scripts/config -e XENO_DRIVERS_GPIO_MXC
     - ./scripts/config -e XENO_DRIVERS_GPIO_SUN8I_H3
     - ./scripts/config -e XENO_DRIVERS_GPIO_ZYNQ7000
diff --git a/kernel/drivers/gpio/Kconfig b/kernel/drivers/gpio/Kconfig
index c257444f0..bc9cbc5e9 100644
--- a/kernel/drivers/gpio/Kconfig
+++ b/kernel/drivers/gpio/Kconfig
@@ -17,6 +17,14 @@ config XENO_DRIVERS_GPIO_BCM2835
 	Enables support for the GPIO controller available from
 	Broadcom's BCM2835 SoC.
 
+config XENO_DRIVERS_GPIO_BCM2711
+	depends on MACH_BCM2708 || ARCH_BCM2835
+	tristate "Support for BCM2711 GPIOs"
+	help
+
+	Enables support for the GPIO controller available from
+	Broadcom's BCM2711 SoC.
+
 config XENO_DRIVERS_GPIO_MXC
 	depends on GPIO_MXC
 	tristate "Support for MXC GPIOs"
diff --git a/kernel/drivers/gpio/Makefile b/kernel/drivers/gpio/Makefile
index e534eab93..89337e3f3 100644
--- a/kernel/drivers/gpio/Makefile
+++ b/kernel/drivers/gpio/Makefile
@@ -1,6 +1,7 @@
 ccflags-$(CONFIG_XENO_DRIVERS_GPIO_DEBUG) := -DDEBUG
 
 obj-$(CONFIG_XENO_DRIVERS_GPIO_BCM2835) += xeno-gpio-bcm2835.o
+obj-$(CONFIG_XENO_DRIVERS_GPIO_BCM2711) += xeno-gpio-bcm2711.o
 obj-$(CONFIG_XENO_DRIVERS_GPIO_MXC) += xeno-gpio-mxc.o
 obj-$(CONFIG_XENO_DRIVERS_GPIO_SUN8I_H3) += xeno-gpio-sun8i-h3.o
 obj-$(CONFIG_XENO_DRIVERS_GPIO_ZYNQ7000) += xeno-gpio-zynq7000.o
@@ -10,6 +11,7 @@ obj-$(CONFIG_XENO_DRIVERS_GPIO_CHERRYVIEW) += xeno-gpio-cherryview.o
 obj-$(CONFIG_XENO_DRIVERS_GPIO) += gpio-core.o
 
 xeno-gpio-bcm2835-y := gpio-bcm2835.o
+xeno-gpio-bcm2711-y := gpio-bcm2711.o
 xeno-gpio-mxc-y := gpio-mxc.o
 xeno-gpio-sun8i-h3-y := gpio-sun8i-h3.o
 xeno-gpio-zynq7000-y := gpio-zynq7000.o
diff --git a/kernel/drivers/gpio/gpio-bcm2711.c b/kernel/drivers/gpio/gpio-bcm2711.c
new file mode 100644
index 000000000..a861def27
--- /dev/null
+++ b/kernel/drivers/gpio/gpio-bcm2711.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Siemens AG 2024
+ *
+ * Authors:
+ *  Clara Kowalsky <clara.kowalsky@siemens.com>
+ */
+#include <linux/module.h>
+#include <rtdm/gpio.h>
+
+#define RTDM_SUBCLASS_BCM2711  1
+
+static int __init bcm2711_gpio_init(void)
+{
+	return rtdm_gpiochip_scan_of(NULL, "brcm,bcm2711-gpio",
+				     RTDM_SUBCLASS_BCM2711);
+}
+module_init(bcm2711_gpio_init);
+
+static void __exit bcm2711_gpio_exit(void)
+{
+	rtdm_gpiochip_remove_by_type(RTDM_SUBCLASS_BCM2711);
+}
+module_exit(bcm2711_gpio_exit);
+
+MODULE_LICENSE("GPL");
+
-- 
2.39.2

