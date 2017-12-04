From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sun,  3 Dec 2017 22:31:51 -0500
Message-Id: <1512358311-120677-1-git-send-email-greg@embeddedgreg.com>
Subject: [Xenomai] [PATCH] Add zynq-7000 rtdm gpio driver.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Greg Gallagher <ggallagher31@gmail.com>

From: Greg Gallagher <ggallagher31@gmail.com>

---
 For the zynq platform (and possibly others in the future) we need to modify 
 gpio-core to request gpio pins before using them. The open() function will 
 now request a gpio and fail if it's already reserved. This should make 
 the pin request transparent to the user. The ability to request and release 
 pins is also available in an ioctrl message.  Tested on Microzed Zynq-7010 
 platform and the raspberry pi 2 board.

---
 include/rtdm/uapi/gpio.h            |  2 +
 kernel/drivers/gpio/Kconfig         |  8 ++++
 kernel/drivers/gpio/Makefile        |  1 +
 kernel/drivers/gpio/gpio-core.c     | 87 +++++++++++++++++++++++++++----------
 kernel/drivers/gpio/gpio-zynq7000.c | 40 +++++++++++++++++
 5 files changed, 116 insertions(+), 22 deletions(-)
 create mode 100644 kernel/drivers/gpio/gpio-zynq7000.c

diff --git a/include/rtdm/uapi/gpio.h b/include/rtdm/uapi/gpio.h
index f846f48..b745f15 100644
--- a/include/rtdm/uapi/gpio.h
+++ b/include/rtdm/uapi/gpio.h
@@ -22,6 +22,8 @@
 #define GPIO_RTIOC_DIR_IN		_IO(RTDM_CLASS_GPIO, 1)
 #define GPIO_RTIOC_IRQEN		_IOW(RTDM_CLASS_GPIO, 2, int) /* GPIO trigger */
 #define GPIO_RTIOC_IRQDIS		_IO(RTDM_CLASS_GPIO, 3)
+#define GPIO_RTIOC_REQS                _IO(RTDM_CLASS_GPIO, 4)
+#define GPIO_RTIOC_RELS                _IO(RTDM_CLASS_GPIO, 5)
 
 #define GPIO_TRIGGER_NONE		0x0 /* unspecified */
 #define GPIO_TRIGGER_EDGE_RISING	0x1
diff --git a/kernel/drivers/gpio/Kconfig b/kernel/drivers/gpio/Kconfig
index 869392f..81fc442 100644
--- a/kernel/drivers/gpio/Kconfig
+++ b/kernel/drivers/gpio/Kconfig
@@ -33,6 +33,14 @@ config XENO_DRIVERS_GPIO_SUN8I_H3
 	Suitable for the GPIO controller available from Allwinner's H3
 	SoC, as found on the NanoPI boards.
 
+config XENO_DRIVERS_GPIO_ZYNQ7000
+	depends on ARCH_ZYNQ
+	bool "Support for Zynq7000 GPIOs"
+	help
+
+	Enables support for the GPIO controller available from
+	Xilinx's Zynq7000 SoC.
+
 config XENO_DRIVERS_GPIO_DEBUG
        bool "Enable GPIO core debugging features"
 
diff --git a/kernel/drivers/gpio/Makefile b/kernel/drivers/gpio/Makefile
index 35ca52c..7f28403 100644
--- a/kernel/drivers/gpio/Makefile
+++ b/kernel/drivers/gpio/Makefile
@@ -8,3 +8,4 @@ xeno_gpio-y := gpio-core.o
 xeno_gpio-$(CONFIG_XENO_DRIVERS_GPIO_BCM2835) += gpio-bcm2835.o
 xeno_gpio-$(CONFIG_XENO_DRIVERS_GPIO_MXC) += gpio-mxc.o
 xeno_gpio-$(CONFIG_XENO_DRIVERS_GPIO_SUN8I_H3) += gpio-sun8i-h3.o
+xeno_gpio-$(CONFIG_XENO_DRIVERS_GPIO_ZYNQ7000) += gpio-zynq7000.o
diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index 55594f6..40e6993 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -36,7 +36,8 @@ struct rtdm_gpio_pin {
 struct rtdm_gpio_chan {
 	int requested : 1,
 	    has_direction : 1,
-	    is_output : 1 ;
+	    is_output : 1,
+            is_interrupt : 1;
 };
 
 static int gpio_pin_interrupt(rtdm_irq_t *irqh)
@@ -60,12 +61,16 @@ static int request_gpio_irq(unsigned int gpio, struct rtdm_gpio_pin *pin,
 	if (trigger & ~GPIO_TRIGGER_MASK)
 		return -EINVAL;
 
-	ret = gpio_request(gpio, pin->name);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			printk(XENO_ERR "cannot request GPIO%d\n", gpio);
-		return ret;
-	}
+        if (!chan->requested) {
+                ret = gpio_request(gpio, pin->name);
+	        if (ret) {
+                        if (ret != -EPROBE_DEFER)
+                                printk(XENO_ERR 
+				        "can not request GPIO%d\n", gpio);
+		        return ret;
+                }
+	        chan->requested = true;
+        }
 
 	ret = gpio_direction_input(gpio);
 	if (ret) {
@@ -99,13 +104,14 @@ static int request_gpio_irq(unsigned int gpio, struct rtdm_gpio_pin *pin,
 		goto fail;
 	}
 
-	chan->requested = true;
 
 	rtdm_irq_enable(&pin->irqh);
+        chan->is_interrupt = true;
 
 	return 0;
 fail:
 	gpio_free(gpio);
+        chan->requested = false;
 
 	return ret;
 }
@@ -116,6 +122,7 @@ static void release_gpio_irq(unsigned int gpio, struct rtdm_gpio_pin *pin,
 	rtdm_irq_free(&pin->irqh);
 	gpio_free(gpio);
 	chan->requested = false;
+        chan->is_interrupt = false;
 }
 
 static int gpio_pin_ioctl_nrt(struct rtdm_fd *fd,
@@ -134,32 +141,47 @@ static int gpio_pin_ioctl_nrt(struct rtdm_fd *fd,
 		ret = rtdm_safe_copy_from_user(fd, &val, arg, sizeof(val));
 		if (ret)
 			return ret;
-		ret = gpio_direction_output(gpio, val);
-		if (ret == 0) {
-			chan->has_direction = true;
-			chan->is_output = true;
-		}
-		break;
+                ret = gpio_direction_output(gpio, val);
+                if (ret == 0) {
+	                chan->has_direction = true;
+                        chan->is_output = true;
+                }
+	        break;
 	case GPIO_RTIOC_DIR_IN:
-		ret = gpio_direction_input(gpio);
+                ret = gpio_direction_input(gpio);
 		if (ret == 0)
 			chan->has_direction = true;
 		break;
 	case GPIO_RTIOC_IRQEN:
-		if (chan->requested)
-			return -EBUSY;
-		ret = rtdm_safe_copy_from_user(fd, &trigger,
+		if (chan->is_interrupt) {
+                        return -EBUSY;
+                }
+                ret = rtdm_safe_copy_from_user(fd, &trigger,
 				       arg, sizeof(trigger));
 		if (ret)
 			return ret;
 		ret = request_gpio_irq(gpio, pin, chan, trigger);
 		break;
 	case GPIO_RTIOC_IRQDIS:
-		release_gpio_irq(gpio, pin, chan);
-		chan->requested = false;
+		if (chan->is_interrupt) {
+                        release_gpio_irq(gpio, pin, chan);
+		        chan->requested = false;
+                        chan->is_interrupt = false;
+                }
 		break;
-	default:
-		return -EINVAL;
+	case GPIO_RTIOC_REQS:
+                ret = gpio_request(gpio, pin->name);
+                if (ret)
+                        return ret;
+                else
+                        chan->requested = true;
+                break;
+        case GPIO_RTIOC_RELS:
+                gpio_free(gpio);
+                chan->requested = false;
+                break;
+        default:
+	        return -EINVAL;
 	}
 	
 	return ret;
@@ -241,6 +263,26 @@ static int gpio_pin_select(struct rtdm_fd *fd, struct xnselector *selector,
 	return rtdm_event_select(&pin->event, selector, type, index);
 }
 
+int gpio_pin_open(struct rtdm_fd *fd, int oflags)
+{
+	struct rtdm_gpio_chan *chan = rtdm_fd_to_private(fd);
+	struct rtdm_device *dev = rtdm_fd_device(fd);
+	unsigned int gpio = rtdm_fd_minor(fd);
+	int ret = 0;
+	struct rtdm_gpio_pin *pin;
+
+	pin = container_of(dev, struct rtdm_gpio_pin, dev);
+	ret = gpio_request(gpio, pin->name);
+	if (ret) {
+		printk(XENO_ERR "failed to request pin %d : %d\n", gpio, ret);
+                return ret;
+	} else {
+		chan->requested = true;
+	}
+
+	return 0;
+}
+
 static void gpio_pin_close(struct rtdm_fd *fd)
 {
 	struct rtdm_gpio_chan *chan = rtdm_fd_to_private(fd);
@@ -361,6 +403,7 @@ int rtdm_gpiochip_add(struct rtdm_gpio_chip *rgc,
 	rgc->driver.device_count = gc->ngpio;
 	rgc->driver.context_size = sizeof(struct rtdm_gpio_chan);
 	rgc->driver.ops = (struct rtdm_fd_ops){
+		.open		=	gpio_pin_open,
 		.close		=	gpio_pin_close,
 		.ioctl_nrt	=	gpio_pin_ioctl_nrt,
 		.read_rt	=	gpio_pin_read_rt,
diff --git a/kernel/drivers/gpio/gpio-zynq7000.c b/kernel/drivers/gpio/gpio-zynq7000.c
new file mode 100644
index 0000000..99b24a9
--- /dev/null
+++ b/kernel/drivers/gpio/gpio-zynq7000.c
@@ -0,0 +1,40 @@
+/**
+ * @note Copyright (C) 2017 Greg Gallagher <greg@embeddedgreg.com>
+ * 
+ * This driver is inspired by:
+ * gpio-bcm2835.c, please see original file for copyright information
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
+#include "gpio-core.h"
+
+#define RTDM_SUBCLASS_ZYNQ7000  4
+
+static int __init zynq7000_gpio_init(void)
+{
+ 	return rtdm_gpiochip_scan_of(NULL, "xlnx,zynq-gpio-1.0", 
+                     RTDM_SUBCLASS_ZYNQ7000);
+}
+module_init(zynq7000_gpio_init);
+
+static void __exit zynq7000_gpio_exit(void)
+{
+	rtdm_gpiochip_remove_of(RTDM_SUBCLASS_ZYNQ7000);
+}
+module_exit(zynq7000_gpio_exit);
+
+MODULE_LICENSE("GPL");
+
-- 
2.7.4


