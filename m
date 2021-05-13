From: hongzha1 <hongzhan.chen@intel.com>
Subject: [for-upstream/dovetail 2/2] driver/gpio: cherryview: introduce gpio
 driver for pinctl Cherryview
Date: Wed, 12 May 2021 21:02:38 -0400
Message-Id: <20210513010238.32466-3-hongzhan.chen@intel.com>
In-Reply-To: <20210513010238.32466-1-hongzhan.chen@intel.com>
References: <20210513010238.32466-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Add support for Intel Cherryview pin controller driver

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 kernel/drivers/gpio/Kconfig           |  7 +++++
 kernel/drivers/gpio/Makefile          |  2 ++
 kernel/drivers/gpio/gpio-cherryview.c | 43 +++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 kernel/drivers/gpio/gpio-cherryview.c

diff --git a/kernel/drivers/gpio/Kconfig b/kernel/drivers/gpio/Kconfig
index 44f41688c..c257444f0 100644
--- a/kernel/drivers/gpio/Kconfig
+++ b/kernel/drivers/gpio/Kconfig
@@ -57,6 +57,13 @@ config XENO_DRIVERS_GPIO_OMAP
 	Enables support for the GPIO controller available from
 	OMAP family SOC.
 
+config XENO_DRIVERS_GPIO_CHERRYVIEW
+	depends on PINCTRL_CHERRYVIEW
+	tristate "Support for Cherryview GPIOs"
+	help
+
+	Enables support for the Intel Cherryview GPIO controller
+
 config XENO_DRIVERS_GPIO_DEBUG
        bool "Enable GPIO core debugging features"
 
diff --git a/kernel/drivers/gpio/Makefile b/kernel/drivers/gpio/Makefile
index 7bcf59949..e534eab93 100644
--- a/kernel/drivers/gpio/Makefile
+++ b/kernel/drivers/gpio/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_XENO_DRIVERS_GPIO_SUN8I_H3) += xeno-gpio-sun8i-h3.o
 obj-$(CONFIG_XENO_DRIVERS_GPIO_ZYNQ7000) += xeno-gpio-zynq7000.o
 obj-$(CONFIG_XENO_DRIVERS_GPIO_XILINX) += xeno-gpio-xilinx.o
 obj-$(CONFIG_XENO_DRIVERS_GPIO_OMAP) += xeno-gpio-omap.o
+obj-$(CONFIG_XENO_DRIVERS_GPIO_CHERRYVIEW) += xeno-gpio-cherryview.o
 obj-$(CONFIG_XENO_DRIVERS_GPIO) += gpio-core.o
 
 xeno-gpio-bcm2835-y := gpio-bcm2835.o
@@ -14,3 +15,4 @@ xeno-gpio-sun8i-h3-y := gpio-sun8i-h3.o
 xeno-gpio-zynq7000-y := gpio-zynq7000.o
 xeno-gpio-xilinx-y := gpio-xilinx.o
 xeno-gpio-omap-y := gpio-omap.o
+xeno-gpio-cherryview-y := gpio-cherryview.o
diff --git a/kernel/drivers/gpio/gpio-cherryview.c b/kernel/drivers/gpio/gpio-cherryview.c
new file mode 100644
index 000000000..e23e13f98
--- /dev/null
+++ b/kernel/drivers/gpio/gpio-cherryview.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * @note Copyright (C) 2021 Hongzhan Chen <hongzhan.chen@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/module.h>
+#include <rtdm/gpio.h>
+
+#define RTDM_SUBCLASS_CHERRYVIEW  7
+
+static const char *compat_array[] = {
+	"INT33FF:00",
+	"INT33FF:01",
+	"INT33FF:02",
+	"INT33FF:03",
+};
+
+static int __init cherryview_gpio_init(void)
+{
+	return rtdm_gpiochip_array_find(NULL, compat_array,
+					ARRAY_SIZE(compat_array),
+					RTDM_SUBCLASS_CHERRYVIEW);
+}
+module_init(cherryview_gpio_init);
+
+static void __exit cherryview_gpio_exit(void)
+{
+	rtdm_gpiochip_remove_of(RTDM_SUBCLASS_CHERRYVIEW);
+}
+module_exit(cherryview_gpio_exit);
+
+MODULE_LICENSE("GPL");
+
-- 
2.17.1


