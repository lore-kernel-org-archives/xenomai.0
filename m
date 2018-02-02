From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu,  1 Feb 2018 21:23:02 -0500
Message-Id: <1517538184-25673-1-git-send-email-greg@embeddedgreg.com>
Subject: [Xenomai] [PATCH 1/3] Add Xilinx AXI gpio driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 kernel/drivers/gpio/Kconfig       | 10 +++++++++-
 kernel/drivers/gpio/Makefile      |  3 ++-
 kernel/drivers/gpio/gpio-xilinx.c | 40 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 2 deletions(-)
 create mode 100644 kernel/drivers/gpio/gpio-xilinx.c

diff --git a/kernel/drivers/gpio/Kconfig b/kernel/drivers/gpio/Kconfig
index 81fc442..b7efa54 100644
--- a/kernel/drivers/gpio/Kconfig
+++ b/kernel/drivers/gpio/Kconfig
@@ -6,7 +6,7 @@ config XENO_DRIVERS_GPIO
        help
 
        Real-time capable GPIO module.
-      
+
 if XENO_DRIVERS_GPIO
 
 config XENO_DRIVERS_GPIO_BCM2835
@@ -41,6 +41,14 @@ config XENO_DRIVERS_GPIO_ZYNQ7000
 	Enables support for the GPIO controller available from
 	Xilinx's Zynq7000 SoC.
 
+config XENO_DRIVERS_GPIO_XILINX
+	depends on ARCH_ZYNQ
+	bool "Support for Xilinx GPIOs"
+	help
+
+	Enables support for the GPIO controller available from
+	Xilinx's softcore IP.
+
 config XENO_DRIVERS_GPIO_DEBUG
        bool "Enable GPIO core debugging features"
 
diff --git a/kernel/drivers/gpio/Makefile b/kernel/drivers/gpio/Makefile
index 7f28403..3737330 100644
--- a/kernel/drivers/gpio/Makefile
+++ b/kernel/drivers/gpio/Makefile
@@ -1,4 +1,3 @@
-
 ccflags-$(CONFIG_XENO_DRIVERS_GPIO_DEBUG) := -DDEBUG
 
 obj-$(CONFIG_XENO_DRIVERS_GPIO) += xeno_gpio.o
@@ -9,3 +8,5 @@ xeno_gpio-$(CONFIG_XENO_DRIVERS_GPIO_BCM2835) += gpio-bcm2835.o
 xeno_gpio-$(CONFIG_XENO_DRIVERS_GPIO_MXC) += gpio-mxc.o
 xeno_gpio-$(CONFIG_XENO_DRIVERS_GPIO_SUN8I_H3) += gpio-sun8i-h3.o
 xeno_gpio-$(CONFIG_XENO_DRIVERS_GPIO_ZYNQ7000) += gpio-zynq7000.o
+xeno_gpio-$(CONFIG_XENO_DRIVERS_GPIO_XILINX) += gpio-xilinx.o
+
diff --git a/kernel/drivers/gpio/gpio-xilinx.c b/kernel/drivers/gpio/gpio-xilinx.c
new file mode 100644
index 0000000..e982f5f
--- /dev/null
+++ b/kernel/drivers/gpio/gpio-xilinx.c
@@ -0,0 +1,40 @@
+/**
+ * @note Copyright (C) 2017 Greg Gallagher <greg@embeddedgreg.com>
+ *
+ * This driver controls the gpio that can be located on the PL
+ * of the Zynq SOC
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
+#define RTDM_SUBCLASS_XILINX  5
+
+static int __init xilinx_gpio_init(void)
+{
+	return rtdm_gpiochip_scan_of(NULL, "xlnx,xps-gpio-1.00.a",
+                     RTDM_SUBCLASS_XILINX);
+}
+module_init(xilinx_gpio_init);
+
+static void __exit xilinx_gpio_exit(void)
+{
+	rtdm_gpiochip_remove_of(RTDM_SUBCLASS_XILINX);
+}
+module_exit(xilinx_gpio_exit);
+
+MODULE_LICENSE("GPL");
+
-- 
2.7.4


