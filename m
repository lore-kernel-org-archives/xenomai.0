From: hongzha1 <hongzhan.chen@intel.com>
Subject: [Questions about gpio rtdm driver for cherryview pinctrl on rock pi
 x] 
Date: Wed, 14 Apr 2021 03:38:26 -0400
Message-Id: <20210414073826.19557-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Philippe,

I have implemented following rtdm gpio driver for cherryview pin ctrl on rock pi X
board ,which works for my validating gpio 335 and 336 with gpiochip INT33FF:02 to
run latmus.
But ,in my code , I just bind uglily fixed INT33FF:02 and actually there is four 
gpiochips from INT33FF:00 to INT33FF:03 with cherryview on Rock PI x board. How 
could I elegantly init all gpiochips as more common like OF device? Do you have any
suggestions about it?

Regards

Hongzhan Chen

diff --git a/kernel/drivers/gpio/Kconfig b/kernel/drivers/gpio/Kconfig
index 44f41688c..fcde04cc7 100644
--- a/kernel/drivers/gpio/Kconfig
+++ b/kernel/drivers/gpio/Kconfig
@@ -57,6 +57,14 @@ config XENO_DRIVERS_GPIO_OMAP
 	Enables support for the GPIO controller available from
 	OMAP family SOC.
 
+config XENO_DRIVERS_GPIO_CHERRYVIEW
+	depends on X86
+	tristate "Support for Cherryview GPIOs"
+	help
+
+	Enables support for the GPIO controller available from
+	Cherryview
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
index 000000000..8bab7b57d
--- /dev/null
+++ b/kernel/drivers/gpio/gpio-cherryview.c
@@ -0,0 +1,37 @@
+/**
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+#include <linux/module.h>
+#include <rtdm/gpio.h>
+
+#define RTDM_SUBCLASS_CHERRYVIEW  7
+
+static int __init cherryview_gpio_init(void)
+{
+	return rtdm_gpiochip_find(NULL, "INT33FF:02",
+				     RTDM_SUBCLASS_CHERRYVIEW);
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


