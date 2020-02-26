From: Greg Gallagher <greg@embeddedgreg.com>
Subject: [PATCH] Add RTDM gpio driver for the OMAP family of SOCs
Date: Wed, 26 Feb 2020 01:00:13 -0500
Message-Id: <20200226060013.16809-1-greg@embeddedgreg.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Add new gpio RTDM driver for OMAP family of SOCs, tested on beaglebone black
and beaglebone green (AM335x)

Signed-off-by: Greg Gallagher <greg@embeddedgreg.com>
---
 kernel/drivers/gpio/Kconfig     |  8 ++++++
 kernel/drivers/gpio/Makefile    |  2 ++
 kernel/drivers/gpio/gpio-omap.c | 43 +++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 kernel/drivers/gpio/gpio-omap.c

diff --git a/kernel/drivers/gpio/Kconfig b/kernel/drivers/gpio/Kconfig
index 48475f291..dbc862754 100644
--- a/kernel/drivers/gpio/Kconfig
+++ b/kernel/drivers/gpio/Kconfig
@@ -49,6 +49,14 @@ config XENO_DRIVERS_GPIO_XILINX
 	Enables support for the GPIO controller available from
 	Xilinx's softcore IP.
 
+config XENO_DRIVERS_GPIO_OMAP
+	depends on ARCH_OMAP2PLUS || ARCH_OMAP
+	tristate "Support for OMAP GPIOs"
+	help
+
+	Enables support for the GPIO controller available from
+	OMAP family SOC.
+
 config XENO_DRIVERS_GPIO_DEBUG
        bool "Enable GPIO core debugging features"
 
diff --git a/kernel/drivers/gpio/Makefile b/kernel/drivers/gpio/Makefile
index 8648fcca9..7bcf59949 100644
--- a/kernel/drivers/gpio/Makefile
+++ b/kernel/drivers/gpio/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_XENO_DRIVERS_GPIO_MXC) += xeno-gpio-mxc.o
 obj-$(CONFIG_XENO_DRIVERS_GPIO_SUN8I_H3) += xeno-gpio-sun8i-h3.o
 obj-$(CONFIG_XENO_DRIVERS_GPIO_ZYNQ7000) += xeno-gpio-zynq7000.o
 obj-$(CONFIG_XENO_DRIVERS_GPIO_XILINX) += xeno-gpio-xilinx.o
+obj-$(CONFIG_XENO_DRIVERS_GPIO_OMAP) += xeno-gpio-omap.o
 obj-$(CONFIG_XENO_DRIVERS_GPIO) += gpio-core.o
 
 xeno-gpio-bcm2835-y := gpio-bcm2835.o
@@ -12,3 +13,4 @@ xeno-gpio-mxc-y := gpio-mxc.o
 xeno-gpio-sun8i-h3-y := gpio-sun8i-h3.o
 xeno-gpio-zynq7000-y := gpio-zynq7000.o
 xeno-gpio-xilinx-y := gpio-xilinx.o
+xeno-gpio-omap-y := gpio-omap.o
diff --git a/kernel/drivers/gpio/gpio-omap.c b/kernel/drivers/gpio/gpio-omap.c
new file mode 100644
index 000000000..5f10278f3
--- /dev/null
+++ b/kernel/drivers/gpio/gpio-omap.c
@@ -0,0 +1,43 @@
+/**
+ * @note Copyright (C) 2020 Greg Gallagher <greg@embeddedgreg.com>
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+#include <linux/module.h>
+#include <rtdm/gpio.h>
+
+#define RTDM_SUBCLASS_OMAP  6
+
+static const char *compat_array[] = {
+	"ti,omap4-gpio",
+	"ti,omap3-gpio",
+	"ti,omap2-gpio",
+};
+
+static int __init omap_gpio_init(void)
+{
+	return rtdm_gpiochip_scan_array_of(NULL, compat_array,
+					   ARRAY_SIZE(compat_array),
+					   RTDM_SUBCLASS_OMAP);
+}
+module_init(omap_gpio_init);
+
+static void __exit omap_gpio_exit(void)
+{
+	rtdm_gpiochip_remove_of(RTDM_SUBCLASS_OMAP);
+}
+module_exit(omap_gpio_exit);
+
+MODULE_LICENSE("GPL");
-- 
2.17.1


