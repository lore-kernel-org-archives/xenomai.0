Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDA384A3E
	for <xenomai@lists.linux.dev>; Tue, 16 Apr 2024 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258017; cv=none; b=oHo390+cZxjOysAHQrt73BsWlJe3fgbbQ0t/slDZxTDesMklaaMpR5T4WtblqPwHfoWTpTvMLBVGVhqF4kT8YT9wEqfoBjRhyeci9kyJTRpqju5aIFM3FPUVF0LXdrkNIChZ0V+vBgr7GauIiLhl9RuwGsquEVmOs2tO0d08du4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258017; c=relaxed/simple;
	bh=p29HmyXeNFFKrGgEWukPEVNanMYibXpRJIeBp1ZXJ60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ssDiLn5bWOGsm77Myc/pq0M/lBaTxdHFRpk2uDvYulrUw2WFv8eYca+JLxF6+MbRUIHO6D+JJtDG9BLkyaaLdX/jUXUKpcjzIxm0YwPc8hwrDcRFTvfLFpO5yEVqoOu1lPbEXz3LL5PysmAhQMZqpELkp/nSM3iYTxsFkcT6hCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=aqqj4rP9; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="aqqj4rP9"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240416090004dcf24bff742f86b941
        for <xenomai@lists.linux.dev>;
        Tue, 16 Apr 2024 11:00:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=aSiWKr4sgS/z8WVOCRDxxeTfburfMOCkAvZn9DUyUGg=;
 b=aqqj4rP9MEEuLtZXypmjR8OZ8F51AhxdIK0U7A13IYIbSub7eYI/KgZNRQ9NnPmzrn9KAF
 qw0y3Uxd8Q9cr1oIzb6rFjn/Ej92iTWVRiq0V/8GAEmR8eVeQRy6TpBL/mcNl1FEqXIEnmKJ
 Fxmu7ENUTz5pAXo+K6pfv5ybbrAgw=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH 1/5] drivers/gpio: Add driver for BCM2711-based SoCs
Date: Tue, 16 Apr 2024 10:59:07 +0200
Message-Id: <20240416085911.62073-2-clara.kowalsky@siemens.com>
In-Reply-To: <20240416085911.62073-1-clara.kowalsky@siemens.com>
References: <20240416085911.62073-1-clara.kowalsky@siemens.com>
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
 kernel/drivers/gpio/Kconfig        |  8 ++++++++
 kernel/drivers/gpio/Makefile       |  2 ++
 kernel/drivers/gpio/gpio-bcm2711.c | 27 +++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)
 create mode 100644 kernel/drivers/gpio/gpio-bcm2711.c

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

