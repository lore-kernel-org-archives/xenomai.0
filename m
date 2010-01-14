From: Wolfgang Grandegger <wg@domain.hid>
Date: Thu, 14 Jan 2010 13:07:45 +0100
Message-Id: <1263470867-1533-4-git-send-email-wg@domain.hid>
In-Reply-To: <1263470867-1533-3-git-send-email-wg@domain.hid>
References: <1263470867-1533-1-git-send-email-wg@domain.hid>
	<1263470867-1533-2-git-send-email-wg@domain.hid>
	<1263470867-1533-3-git-send-email-wg@domain.hid>
Subject: [Xenomai-core] [PATCH xenomai-2.5 3/3] rtcan: mscan: new OF
	platform driver for MPC521x and MPC5200
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid
Cc: Wolfgang Grandegger <wg@domain.hid>

From: Wolfgang Grandegger <wg@domain.hid>

This patch introduces support for the MPC512x from Freescale. To re-use
the driver initialization code from the new "mpc5xxx_can" driver from
the mainline kernel, the old initialization code for the MPC5200 from
"rtcan_mscan.c" has been moved to "rtcan_mscan_mpc52xx.c", mainly for
backward compatibility with older kernel version. If required, it can
be selected via Kconfig option. The new file "rtcan_mscan_mpc5xxx.c"
adds OF platform driver support for the MPC5200 *and* the MPC512x.
Port and clock selection is done as described for the mpc5xxx_can
mainline driver in "Documentation/powerpc/dts-bindings/fsl/can.txt".

Signed-off-by: Wolfgang Grandegger <wg@domain.hid>
---
 ksrc/drivers/can/mscan/Kconfig               |   21 ++-
 ksrc/drivers/can/mscan/Makefile              |    7 +-
 ksrc/drivers/can/mscan/rtcan_mscan.c         |  255 +++---------------
 ksrc/drivers/can/mscan/rtcan_mscan.h         |   38 +++
 ksrc/drivers/can/mscan/rtcan_mscan_mpc52xx.c |  254 +++++++++++++++++
 ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c |  374 ++++++++++++++++++++++++++
 ksrc/drivers/can/mscan/rtcan_mscan_proc.c    |    6 +-
 ksrc/drivers/can/mscan/rtcan_mscan_regs.h    |    8 +
 8 files changed, 745 insertions(+), 218 deletions(-)
 create mode 100644 ksrc/drivers/can/mscan/rtcan_mscan.h
 create mode 100644 ksrc/drivers/can/mscan/rtcan_mscan_mpc52xx.c
 create mode 100644 ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c

diff --git a/ksrc/drivers/can/mscan/Kconfig b/ksrc/drivers/can/mscan/Kconfig
index eadad97..c624c88 100644
--- a/ksrc/drivers/can/mscan/Kconfig
+++ b/ksrc/drivers/can/mscan/Kconfig
@@ -1,7 +1,22 @@
 config XENO_DRIVERS_CAN_MSCAN
-	depends on XENO_DRIVERS_CAN && PPC_MPC52xx
-	tristate "MSCAN driver for MPC52xx"
+	depends on XENO_DRIVERS_CAN && (PPC_MPC52xx || PPC_MPC512x)
+	tristate "MSCAN driver for MPC52xx and MPC512x"
 	default n
+	help
+
+	This driver is for the MSCAN on the MPC5200 and MPC512x processor
+	from Freescale.
+
+config XENO_DRIVERS_CAN_MSCAN_OLD
+	depends on XENO_DRIVERS_CAN_MSCAN && PPC_MPC52xx
+	bool "Use old MSCAN driver for old kernel version"
+	default n
+	help
+
+	For backward compatibility with older kernel versions, you may
+	want to select the old MSCAN driver for the MPC5200.
+
+if XENO_DRIVERS_CAN_MSCAN_OLD
 
 config XENO_DRIVERS_CAN_MSCAN_1
 	depends on XENO_DRIVERS_CAN_MSCAN
@@ -41,3 +56,5 @@ config XENO_DRIVERS_CAN_MSCAN_PSC2
 
 endchoice
 
+endif
+
diff --git a/ksrc/drivers/can/mscan/Makefile b/ksrc/drivers/can/mscan/Makefile
index 8976ffe..7ce9249 100644
--- a/ksrc/drivers/can/mscan/Makefile
+++ b/ksrc/drivers/can/mscan/Makefile
@@ -7,6 +7,11 @@ EXTRA_CFLAGS += -D__IN_XENOMAI__ -Iinclude/xenomai -Idrivers/xenomai/can -Idrive
 obj-$(CONFIG_XENO_DRIVERS_CAN_MSCAN) += xeno_can_mscan.o
 
 xeno_can_mscan-y := rtcan_mscan.o rtcan_mscan_proc.o
+ifdef CONFIG_XENO_DRIVERS_CAN_MSCAN_OLD
+xeno_can_mscan-y += rtcan_mscan_mpc52xx.o
+else
+xeno_can_mscan-y += rtcan_mscan_mpc5xxx.o
+endif
 
 else
 
@@ -18,7 +23,7 @@ obj-$(CONFIG_XENO_DRIVERS_CAN_MSCAN) := xeno_can_mscan.o
 
 list-multi := xeno_can_mscan.o
 
-xeno_can_mscan-objs := rtcan_mscan.o rtcan_mscan_proc.o
+xeno_can_mscan-objs := rtcan_mscan.o rtcan_mscan_proc.o rtcan_mscan_mpc52xx.o
 
 export-objs := $(xeno_can_mscan-objs)
 
diff --git a/ksrc/drivers/can/mscan/rtcan_mscan.c b/ksrc/drivers/can/mscan/rtcan_mscan.c
index 4975320..d25fc5a 100644
--- a/ksrc/drivers/can/mscan/rtcan_mscan.c
+++ b/ksrc/drivers/can/mscan/rtcan_mscan.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006 Wolfgang Grandegger <wg@domain.hid>
+ * Copyright (C) 2006-2010 Wolfgang Grandegger <wg@domain.hid>
  *
  * Copyright (C) 2005, 2006 Sebastian Smolorz
  *                          <Sebastian.Smolorz@domain.hid>
@@ -38,57 +38,7 @@
 #include "rtcan_raw.h"
 #include "rtcan_internal.h"
 #include "rtcan_mscan_regs.h"
-
-extern int rtcan_mscan_create_proc(struct rtcan_device* dev);
-extern void rtcan_mscan_remove_proc(struct rtcan_device* dev);
-
-#define RTCAN_DEV_NAME    "rtcan%d"
-#define RTCAN_DRV_NAME    "MSCAN"
-#define RTCAN_MSCAN_DEVS  2
-
-static char *mscan_ctlr_name  = "MSCAN-MPC5200";
-static char *mscan_board_name = "unkown";
-
-MODULE_AUTHOR("Wolfgang Grandegger <wg@domain.hid>");
-MODULE_DESCRIPTION("RT-Socket-CAN driver for MSCAN-MPC2500");
-MODULE_SUPPORTED_DEVICE("MSCAN-MPC5200 CAN controller");
-MODULE_LICENSE("GPL");
-
-/** Module parameter for the CAN controllers' */
-
-int port[RTCAN_MSCAN_DEVS] = {
-#ifdef CONFIG_XENO_DRIVERS_CAN_MSCAN_1
-#ifdef CONFIG_XENO_DRIVERS_CAN_MSCAN_2
-	1, 1  /* Enable CAN 1 and 2 */
-#else
-	1, 0  /* Enable CAN 1 only  */
-#endif
-#else
-#ifdef CONFIG_XENO_DRIVERS_CAN_MSCAN_2
-	0, 1  /* Enable CAN 2 only  */
-#else
-#error "No CAN controller enabled, fix configuration!"
-#endif
-#endif
-};
-compat_module_param_array(port, int, RTCAN_MSCAN_DEVS, 0444);
-MODULE_PARM_DESC(port, "Enabled CAN ports (1,1 or 0,1 or 0,1)");
-
-/*
- * Note: on the MPC5200 the MSCAN clock source is the IP bus
- * clock (IP_CLK) while on the MPC5200B it is the oscillator
- * clock (SYS_XTAL_IN).
- */
-unsigned int mscan_clock = CONFIG_XENO_DRIVERS_CAN_MSCAN_CLOCK;
-module_param(mscan_clock, int, 0444);
-MODULE_PARM_DESC(mscan_clock, "Clock frequency in Hz");
-
-char *mscan_pins = NULL;
-module_param(mscan_pins, charp, 0444);
-MODULE_PARM_DESC(mscan_pins, "Routing to GPIO pins (PSC2 or I2C1/TMR01)");
-
-static struct rtcan_device *rtcan_mscan_devs[RTCAN_MSCAN_DEVS];
-static int rtcan_mscan_count;
+#include "rtcan_mscan.h"
 
 /**
  *  Reception Interrupt handler
@@ -472,9 +422,9 @@ static int rtcan_mscan_mode_start(struct rtcan_device *dev,
 	return ret;
 }
 
-int rtcan_mscan_set_bit_time(struct rtcan_device *dev,
-			     struct can_bittime *bit_time,
-			     rtdm_lockctx_t *lock_ctx)
+static int rtcan_mscan_set_bit_time(struct rtcan_device *dev,
+				    struct can_bittime *bit_time,
+				    rtdm_lockctx_t *lock_ctx)
 {
 	struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
 	u8 btr0, btr1;
@@ -506,9 +456,9 @@ int rtcan_mscan_set_bit_time(struct rtcan_device *dev,
 	return 0;
 }
 
-int rtcan_mscan_set_mode(struct rtcan_device *dev,
-			 can_mode_t mode,
-			 rtdm_lockctx_t *lock_ctx)
+static int rtcan_mscan_set_mode(struct rtcan_device *dev,
+				can_mode_t mode,
+				rtdm_lockctx_t *lock_ctx)
 {
 	int ret = 0, retries = 0;
 	can_state_t state;
@@ -675,11 +625,13 @@ static int rtcan_mscan_start_xmit(struct rtcan_device *dev, can_frame_t *frame)
  *
  *  @param[in] dev Device ID of the controller to be configured
  */
-static inline void __init mscan_chip_config(struct mscan_regs *regs)
+static inline void __init mscan_chip_config(struct mscan_regs *regs,
+					    int mscan_clksrc)
 {
 	/* Choose IP bus as clock source.
 	 */
-	setbits8(&regs->canctl1, MSCAN_CLKSRC);
+	if (mscan_clksrc)
+		setbits8(&regs->canctl1, MSCAN_CLKSRC);
 	clrbits8(&regs->canctl1, MSCAN_LISTEN);
 
 	/* Configure MSCAN to accept all incoming messages.
@@ -703,107 +655,19 @@ static inline void __init mscan_chip_config(struct mscan_regs *regs)
 	clrbits8(&regs->canidac, MSCAN_IDAM0 | MSCAN_IDAM1);
 }
 
-static inline void __init mscan_gpio_config(void)
-{
-	struct mpc5xxx_gpio *gpio = (struct mpc5xxx_gpio *)MPC5xxx_GPIO;
-	int can_to_psc2 = -1;
-	u32 port_config;
-
-#if defined(CONFIG_XENO_DRIVERS_CAN_MSCAN_ALT)
-	can_to_psc2 = 0;
-#elif defined(CONFIG_XENO_DRIVERS_CAN_MSCAN_PSC2)
-	can_to_psc2 = 1;
-#endif
-
-	/* Configure CAN routing to GPIO pins.
-	 */
-	if (mscan_pins != NULL) {
-		if (strncmp(mscan_pins, "psc2", 4) == 0 ||
-		    !strncmp(mscan_pins, "PSC2", 4))
-			can_to_psc2 = 1;
-		else if (strncmp(mscan_pins, "i2c1/tmr01", 10) == 0 ||
-			 strncmp(mscan_pins, "I2C1/TMR01", 10) == 0)
-			can_to_psc2 = 0;
-		else {
-			printk("Module parameter mscan_pins=%s is invalid. "
-			       "Please use PSC2 or I2C1/TMR01.\n", mscan_pins);
-		}
-	}
-
-	if (!gpio || can_to_psc2 < 0) {
-		printk("%s: use pre-configure CAN routing\n", RTCAN_DRV_NAME);
-		return;
-	}
-
-	port_config = in_be32(&gpio->port_config);
-	if (can_to_psc2) {
-		port_config &= ~0x10000070;
-		port_config |= 0x00000010;
-		printk("%s: CAN 1 and 2 routed to PSC2 pins\n", RTCAN_DRV_NAME);
-	} else {
-		port_config |= 0x10000000;
-		printk("%s: CAN 1 routed to I2C1 pins and CAN2 to TMR01 pins\n",
-		       RTCAN_DRV_NAME);
-	}
-	out_be32(&gpio->port_config, port_config);
-}
-
-static inline int mscan_get_config(unsigned long *addr, unsigned int *irq)
-{
-#if defined(CONFIG_PPC_MERGE) || LINUX_VERSION_CODE > KERNEL_VERSION(2,6,27)
-	/* Use Open Firmware device tree */
-	struct device_node *np = NULL;
-	unsigned int i;
-	int ret;
-
-	for (i = 0; i < RTCAN_MSCAN_DEVS; i++) {
-		struct resource r[2] = {};
-
-		np = of_find_compatible_node(np, NULL, "fsl,mpc5200-mscan");
-		if (np == NULL)
-			np = of_find_compatible_node(np, NULL, "mpc5200-mscan");
-		if (np == NULL)
-			break;
-		ret = of_address_to_resource(np, 0, &r[0]);
-		if (ret)
-			return ret;
-		of_irq_to_resource(np, 0, &r[1]);
-		addr[i] = r[0].start;
-		irq[i] = r[1].start;
-		rtcan_mscan_count++;
-	}
-#else
-	addr[0] = MSCAN_CAN1_ADDR;
-	irq[0] = MSCAN_CAN1_IRQ;
-	addr[1] = MSCAN_CAN2_ADDR;
-	irq[1] = MSCAN_CAN2_IRQ;
-	rtcan_mscan_count = 2;
-#endif
-	return 0;
-}
-
-int __init rtcan_mscan_init_one(int idx, unsigned long addr, int irq)
+/**
+ *  MSCAN Chip registration
+ *
+ *  Called during @ref init_module.
+ *
+ *  @param[in] dev Device ID of the controller to be registered
+ *  @param[in] mscan_clksrc clock source to be used
+ */
+int rtcan_mscan_register(struct rtcan_device *dev, int irq, int mscan_clksrc)
 {
 	int ret;
-	struct rtcan_device *dev;
 	struct mscan_regs *regs;
 
-	if ((dev = rtcan_dev_alloc(0, 0)) == NULL) {
-		return -ENOMEM;
-	}
-
-	dev->ctrl_name = mscan_ctlr_name;
-	dev->board_name = mscan_board_name;
-
-	dev->can_sys_clock = mscan_clock;
-
-	dev->base_addr = (unsigned long)ioremap(addr, MSCAN_SIZE);
-	if (dev->base_addr == 0) {
-		ret = -ENOMEM;
-		printk("ERROR! ioremap of %#lx failed\n", addr);
-		goto out_dev_free;
-	}
-
 	regs = (struct mscan_regs *)dev->base_addr;
 
 	/* Enable MSCAN module. */
@@ -826,15 +690,14 @@ int __init rtcan_mscan_init_one(int idx, unsigned long addr, int irq)
 	dev->do_set_bit_time = rtcan_mscan_set_bit_time;
 
 	/* Register IRQ handler and pass device structure as arg */
-	ret = rtdm_irq_request(&dev->irq_handle, irq,
-			       rtcan_mscan_interrupt,
+	ret = rtdm_irq_request(&dev->irq_handle, irq, rtcan_mscan_interrupt,
 			       0, RTCAN_DRV_NAME, (void *)dev);
 	if (ret) {
 		printk("ERROR! rtdm_irq_request for IRQ %d failed\n", irq);
-		goto out_iounmap;
+		goto out_can_disable;
 	}
 
-	mscan_chip_config(regs);
+	mscan_chip_config(regs, mscan_clksrc);
 
 	/* Register RTDM device */
 	ret = rtcan_dev_register(dev);
@@ -846,74 +709,38 @@ int __init rtcan_mscan_init_one(int idx, unsigned long addr, int irq)
 
 	rtcan_mscan_create_proc(dev);
 
-	/* Remember initialized devices */
-	rtcan_mscan_devs[idx] = dev;
-
-	printk("%s: %s driver loaded (port %d, base-addr 0x%lx irq %d)\n",
-	       dev->name, RTCAN_DRV_NAME, idx + 1, addr, irq);
-
 	return 0;
 
 out_irq_free:
 	rtdm_irq_free(&dev->irq_handle);
 
-out_iounmap:
+out_can_disable:
 	/* Disable MSCAN module. */
 	clrbits8(&regs->canctl1, MSCAN_CANE);
-	iounmap((void *)dev->base_addr);
-
-out_dev_free:
-	rtcan_dev_free(dev);
 
 	return ret;
-
 }
 
-static void rtcan_mscan_exit(void)
+/**
+ *  MSCAN Chip deregistration
+ *
+ *  Called during @ref cleanup_module
+ *
+ *  @param[in] dev Device ID of the controller to be registered
+ */
+int rtcan_mscan_unregister(struct rtcan_device *dev)
 {
-	int i;
-	struct rtcan_device *dev;
-
-	for (i = 0; i < rtcan_mscan_count; i++) {
-
-		if ((dev = rtcan_mscan_devs[i]) == NULL)
-			continue;
-
-		printk("Unloading %s device %s\n", RTCAN_DRV_NAME, dev->name);
+	struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
 
-		rtcan_mscan_mode_stop(dev, NULL);
-		rtdm_irq_free(&dev->irq_handle);
-		rtcan_mscan_remove_proc(dev);
-		rtcan_dev_unregister(dev);
-		iounmap((void *)dev->base_addr);
-		rtcan_dev_free(dev);
-	}
+	printk("Unregistering %s device %s\n", RTCAN_DRV_NAME, dev->name);
 
-}
+	rtcan_mscan_mode_stop(dev, NULL);
+	rtdm_irq_free(&dev->irq_handle);
+	rtcan_mscan_remove_proc(dev);
+	rtcan_dev_unregister(dev);
 
-static int __init rtcan_mscan_init(void)
-{
-	int i, err;
-	int unsigned long addr[RTCAN_MSCAN_DEVS];
-	int irq[RTCAN_MSCAN_DEVS];
-
-	if ((err = mscan_get_config(addr, irq)))
-		return err;
-	mscan_gpio_config();
-
-	for (i = 0; i < rtcan_mscan_count; i++) {
-		if (!port[i])
-			continue;
-
-		err = rtcan_mscan_init_one(i, addr[i], irq[i]);
-		if (err) {
-			rtcan_mscan_exit();
-			return err;
-		}
-	}
+	/* Disable MSCAN module. */
+	clrbits8(&regs->canctl1, MSCAN_CANE);
 
 	return 0;
 }
-
-module_init(rtcan_mscan_init);
-module_exit(rtcan_mscan_exit);
diff --git a/ksrc/drivers/can/mscan/rtcan_mscan.h b/ksrc/drivers/can/mscan/rtcan_mscan.h
new file mode 100644
index 0000000..654a0f5
--- /dev/null
+++ b/ksrc/drivers/can/mscan/rtcan_mscan.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright (C) 2009 Wolfgang Grandegger <wg@domain.hid>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef __RTCAN_MSCAN_H_
+#define __RTCAN_MSCAN_H_
+
+#define RTCAN_DEV_NAME    "rtcan%d"
+#define RTCAN_DRV_NAME    "rtcan_mscan"
+
+/* MSCAN type variants */
+enum {
+	MSCAN_TYPE_MPC5200,
+	MSCAN_TYPE_MPC5121
+};
+
+extern int rtcan_mscan_register(struct rtcan_device *dev, int irq,
+				       int mscan_clksrc);
+extern int rtcan_mscan_unregister(struct rtcan_device *dev);
+
+extern int rtcan_mscan_create_proc(struct rtcan_device* dev);
+extern void rtcan_mscan_remove_proc(struct rtcan_device* dev);
+
+#endif /* __RTCAN_MSCAN_H_ */
diff --git a/ksrc/drivers/can/mscan/rtcan_mscan_mpc52xx.c b/ksrc/drivers/can/mscan/rtcan_mscan_mpc52xx.c
new file mode 100644
index 0000000..27feaf8
--- /dev/null
+++ b/ksrc/drivers/can/mscan/rtcan_mscan_mpc52xx.c
@@ -0,0 +1,254 @@
+/*
+ * Copyright (C) 2006-2010 Wolfgang Grandegger <wg@domain.hid>
+ *
+ * Copyright (C) 2005, 2006 Sebastian Smolorz
+ *                          <Sebastian.Smolorz@domain.hid>
+ *
+ * Derived from the PCAN project file driver/src/pcan_mpc5200.c:
+ *
+ * Copyright (c) 2003 Wolfgang Denk, DENX Software Engineering, wd@domain.hid.
+ *
+ * Copyright (c) 2005 Felix Daners, Plugit AG, felix.daners@domain.hid
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+
+#include <rtdm/rtdm_driver.h>
+
+/* CAN device profile */
+#include <rtdm/rtcan.h>
+#include "rtcan_dev.h"
+#include "rtcan_raw.h"
+#include "rtcan_internal.h"
+#include "rtcan_mscan_regs.h"
+#include "rtcan_mscan.h"
+
+#define RTCAN_MSCAN_DEVS  2
+
+static char *mscan_ctlr_name  = "MSCAN-MPC5200";
+static char *mscan_board_name = "unkown";
+
+MODULE_AUTHOR("Wolfgang Grandegger <wg@domain.hid>");
+MODULE_DESCRIPTION("RT-Socket-CAN driver for MSCAN-MPC2500");
+MODULE_SUPPORTED_DEVICE("MSCAN-MPC5200 CAN controller");
+MODULE_LICENSE("GPL");
+
+/** Module parameter for the CAN controllers' */
+
+int port[RTCAN_MSCAN_DEVS] = {
+#ifdef CONFIG_XENO_DRIVERS_CAN_MSCAN_1
+#ifdef CONFIG_XENO_DRIVERS_CAN_MSCAN_2
+	1, 1  /* Enable CAN 1 and 2 */
+#else
+	1, 0  /* Enable CAN 1 only  */
+#endif
+#else
+#ifdef CONFIG_XENO_DRIVERS_CAN_MSCAN_2
+	0, 1  /* Enable CAN 2 only  */
+#else
+#error "No CAN controller enabled, fix configuration!"
+#endif
+#endif
+};
+compat_module_param_array(port, int, RTCAN_MSCAN_DEVS, 0444);
+MODULE_PARM_DESC(port, "Enabled CAN ports (1,1 or 0,1 or 0,1)");
+
+/*
+ * Note: on the MPC5200 the MSCAN clock source is the IP bus
+ * clock (IP_CLK) while on the MPC5200B it is the oscillator
+ * clock (SYS_XTAL_IN).
+ */
+unsigned int mscan_clock = CONFIG_XENO_DRIVERS_CAN_MSCAN_CLOCK;
+module_param(mscan_clock, int, 0444);
+MODULE_PARM_DESC(mscan_clock, "Clock frequency in Hz");
+
+char *mscan_pins = NULL;
+module_param(mscan_pins, charp, 0444);
+MODULE_PARM_DESC(mscan_pins, "Routing to GPIO pins (PSC2 or I2C1/TMR01)");
+
+static struct rtcan_device *rtcan_mscan_devs[RTCAN_MSCAN_DEVS];
+static int rtcan_mscan_count;
+
+static inline void __init mscan_gpio_config(void)
+{
+	struct mpc5xxx_gpio *gpio = (struct mpc5xxx_gpio *)MPC5xxx_GPIO;
+	int can_to_psc2 = -1;
+	u32 port_config;
+
+#if defined(CONFIG_XENO_DRIVERS_CAN_MSCAN_ALT)
+	can_to_psc2 = 0;
+#elif defined(CONFIG_XENO_DRIVERS_CAN_MSCAN_PSC2)
+	can_to_psc2 = 1;
+#endif
+
+	/* Configure CAN routing to GPIO pins.
+	 */
+	if (mscan_pins != NULL) {
+		if (strncmp(mscan_pins, "psc2", 4) == 0 ||
+		    !strncmp(mscan_pins, "PSC2", 4))
+			can_to_psc2 = 1;
+		else if (strncmp(mscan_pins, "i2c1/tmr01", 10) == 0 ||
+			 strncmp(mscan_pins, "I2C1/TMR01", 10) == 0)
+			can_to_psc2 = 0;
+		else {
+			printk("Module parameter mscan_pins=%s is invalid. "
+			       "Please use PSC2 or I2C1/TMR01.\n", mscan_pins);
+		}
+	}
+
+	if (!gpio || can_to_psc2 < 0) {
+		printk("%s: use pre-configure CAN routing\n", RTCAN_DRV_NAME);
+		return;
+	}
+
+	port_config = in_be32(&gpio->port_config);
+	if (can_to_psc2) {
+		port_config &= ~0x10000070;
+		port_config |= 0x00000010;
+		printk("%s: CAN 1 and 2 routed to PSC2 pins\n", RTCAN_DRV_NAME);
+	} else {
+		port_config |= 0x10000000;
+		printk("%s: CAN 1 routed to I2C1 pins and CAN2 to TMR01 pins\n",
+		       RTCAN_DRV_NAME);
+	}
+	out_be32(&gpio->port_config, port_config);
+}
+
+static inline int mscan_get_config(unsigned long *addr, unsigned int *irq)
+{
+#if defined(CONFIG_PPC_MERGE) || LINUX_VERSION_CODE > KERNEL_VERSION(2,6,27)
+	/* Use Open Firmware device tree */
+	struct device_node *np = NULL;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < RTCAN_MSCAN_DEVS; i++) {
+		struct resource r[2] = {};
+
+		np = of_find_compatible_node(np, NULL, "fsl,mpc5200-mscan");
+		if (np == NULL)
+			np = of_find_compatible_node(np, NULL, "mpc5200-mscan");
+		if (np == NULL)
+			break;
+		ret = of_address_to_resource(np, 0, &r[0]);
+		if (ret)
+			return ret;
+		of_irq_to_resource(np, 0, &r[1]);
+		addr[i] = r[0].start;
+		irq[i] = r[1].start;
+		rtcan_mscan_count++;
+	}
+#else
+	addr[0] = MSCAN_CAN1_ADDR;
+	irq[0] = MSCAN_CAN1_IRQ;
+	addr[1] = MSCAN_CAN2_ADDR;
+	irq[1] = MSCAN_CAN2_IRQ;
+	rtcan_mscan_count = 2;
+#endif
+	return 0;
+}
+
+static int __init rtcan_mscan_init_one(int idx, unsigned long addr, int irq)
+{
+	struct rtcan_device *dev;
+	int ret;
+
+	dev = rtcan_dev_alloc(0, 0);
+	if (dev == NULL)
+		return -ENOMEM;
+
+	dev->base_addr = (unsigned long)ioremap(addr, MSCAN_SIZE);
+	if (dev->base_addr == 0) {
+		ret = -ENOMEM;
+		printk("ERROR! ioremap of %#lx failed\n", addr);
+		goto out_dev_free;
+	}
+
+	dev->ctrl_name = mscan_ctlr_name;
+	dev->board_name = mscan_board_name;
+	dev->can_sys_clock = mscan_clock;
+
+	ret = rtcan_mscan_register(dev, irq, 1);
+	if (ret)
+		goto out_iounmap;
+
+	/* Remember initialized devices */
+	rtcan_mscan_devs[idx] = dev;
+
+	printk("%s: %s driver: MSCAN port %d, base-addr 0x%lx, irq %d\n",
+	       dev->name, RTCAN_DRV_NAME, idx + 1, addr, irq);
+
+	return 0;
+
+out_iounmap:
+	iounmap((void *)dev->base_addr);
+
+out_dev_free:
+	rtcan_dev_free(dev);
+
+	return ret;
+
+}
+
+static void rtcan_mscan_exit(void)
+{
+	int i;
+	struct rtcan_device *dev;
+
+	for (i = 0; i < rtcan_mscan_count; i++) {
+
+		if ((dev = rtcan_mscan_devs[i]) == NULL)
+			continue;
+
+		printk("Unloading %s device %s\n", RTCAN_DRV_NAME, dev->name);
+
+		rtcan_mscan_unregister(dev);
+		iounmap((void *)dev->base_addr);
+		rtcan_dev_free(dev);
+	}
+
+}
+
+static int __init rtcan_mscan_init(void)
+{
+	int i, err;
+	int unsigned long addr[RTCAN_MSCAN_DEVS];
+	int irq[RTCAN_MSCAN_DEVS];
+
+	if ((err = mscan_get_config(addr, irq)))
+		return err;
+	mscan_gpio_config();
+
+	for (i = 0; i < rtcan_mscan_count; i++) {
+		if (!port[i])
+			continue;
+
+		err = rtcan_mscan_init_one(i, addr[i], irq[i]);
+		if (err) {
+			rtcan_mscan_exit();
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+module_init(rtcan_mscan_init);
+module_exit(rtcan_mscan_exit);
diff --git a/ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c b/ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c
new file mode 100644
index 0000000..48abd89
--- /dev/null
+++ b/ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c
@@ -0,0 +1,374 @@
+/*
+ * CAN bus driver for the Freescale MPC5xxx embedded CPU.
+ *
+ * Copyright (C) 2004-2005 Andrey Volkov <avolkov@domain.hid>,
+ *                         Varma Electronics Oy
+ * Copyright (C) 2008-2010 Wolfgang Grandegger <wg@domain.hid>
+ * Copyright (C) 2009 Wolfram Sang, Pengutronix <w.sang@domain.hid>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the version 2 of the GNU General Public License
+ * as published by the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/netdevice.h>
+#include <linux/of_platform.h>
+#include <sysdev/fsl_soc.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <asm/mpc52xx.h>
+
+#include "rtcan_dev.h"
+#include "rtcan_mscan_regs.h"
+#include "rtcan_mscan.h"
+
+static char mscan_ctrl_name_mpc5200[] = "MSCAN-MPC5200";
+static char mscan_ctrl_name_mpc512x[] = "MSCAN-MPC512x";
+static char mscan_board_name[] = "unkown";
+
+struct mpc5xxx_can_data {
+	unsigned int type;
+	u32 (*get_clock)(struct of_device *ofdev, const char *clock_name,
+			 int *mscan_clksrc);
+};
+
+#ifdef CONFIG_PPC_MPC52xx
+static struct of_device_id __devinitdata mpc52xx_cdm_ids[] = {
+	{ .compatible = "fsl,mpc5200-cdm", },
+	{}
+};
+
+static u32 __devinit mpc52xx_can_get_clock(struct of_device *ofdev,
+					   const char *clock_name,
+					   int *mscan_clksrc)
+{
+	unsigned int pvr;
+	struct mpc52xx_cdm  __iomem *cdm;
+	struct device_node *np_cdm;
+	unsigned int freq;
+	u32 val;
+
+	pvr = mfspr(SPRN_PVR);
+
+	/*
+	 * Either the oscillator clock (SYS_XTAL_IN) or the IP bus clock
+	 * (IP_CLK) can be selected as MSCAN clock source. According to
+	 * the MPC5200 user's manual, the oscillator clock is the better
+	 * choice as it has less jitter. For this reason, it is selected
+	 * by default. Unfortunately, it can not be selected for the old
+	 * MPC5200 Rev. A chips due to a hardware bug (check errata).
+	 */
+	if (clock_name && strcmp(clock_name, "ip") == 0)
+		*mscan_clksrc = MSCAN_CLKSRC_BUS;
+	else
+		*mscan_clksrc = MSCAN_CLKSRC_XTAL;
+
+	freq = mpc5xxx_get_bus_frequency(ofdev->node);
+	if (!freq)
+		return 0;
+
+	if (*mscan_clksrc == MSCAN_CLKSRC_BUS || pvr == 0x80822011)
+		return freq;
+
+	/* Determine SYS_XTAL_IN frequency from the clock domain settings */
+	np_cdm = of_find_matching_node(NULL, mpc52xx_cdm_ids);
+	if (!np_cdm) {
+		dev_err(&ofdev->dev, "can't get clock node!\n");
+		return 0;
+	}
+	cdm = of_iomap(np_cdm, 0);
+
+	if (in_8(&cdm->ipb_clk_sel) & 0x1)
+		freq *= 2;
+	val = in_be32(&cdm->rstcfg);
+
+	freq *= (val & (1 << 5)) ? 8 : 4;
+	freq /= (val & (1 << 6)) ? 12 : 16;
+
+	of_node_put(np_cdm);
+	iounmap(cdm);
+
+	return freq;
+}
+#else /* !CONFIG_PPC_MPC5200 */
+static u32 __devinit mpc52xx_can_get_clock(struct of_device *ofdev,
+					   const char *clock_name,
+					   int *mscan_clksrc)
+{
+	return 0;
+}
+#endif /* CONFIG_PPC_MPC52xx */
+
+#ifdef CONFIG_PPC_MPC512x
+struct mpc512x_clockctl {
+	u32 spmr;		/* System PLL Mode Reg */
+	u32 sccr[2];		/* System Clk Ctrl Reg 1 & 2 */
+	u32 scfr1;		/* System Clk Freq Reg 1 */
+	u32 scfr2;		/* System Clk Freq Reg 2 */
+	u32 reserved;
+	u32 bcr;		/* Bread Crumb Reg */
+	u32 pccr[12];		/* PSC Clk Ctrl Reg 0-11 */
+	u32 spccr;		/* SPDIF Clk Ctrl Reg */
+	u32 cccr;		/* CFM Clk Ctrl Reg */
+	u32 dccr;		/* DIU Clk Cnfg Reg */
+	u32 mccr[4];		/* MSCAN Clk Ctrl Reg 1-3 */
+};
+
+static struct of_device_id __devinitdata mpc512x_clock_ids[] = {
+	{ .compatible = "fsl,mpc5121-clock", },
+	{}
+};
+
+static u32 __devinit mpc512x_can_get_clock(struct of_device *ofdev,
+					   const char *clock_name,
+					   int *mscan_clksrc)
+{
+	struct mpc512x_clockctl __iomem *clockctl;
+	struct device_node *np_clock;
+	struct clk *sys_clk, *ref_clk;
+	int plen, clockidx, clocksrc = -1;
+	u32 sys_freq, val, clockdiv = 1, freq = 0;
+	const u32 *pval;
+
+	np_clock = of_find_matching_node(NULL, mpc512x_clock_ids);
+	if (!np_clock) {
+		dev_err(&ofdev->dev, "couldn't find clock node\n");
+		return -ENODEV;
+	}
+	clockctl = of_iomap(np_clock, 0);
+	if (!clockctl) {
+		dev_err(&ofdev->dev, "couldn't map clock registers\n");
+		return 0;
+	}
+
+	/* Determine the MSCAN device index from the physical address */
+	pval = of_get_property(ofdev->node, "reg", &plen);
+	BUG_ON(!pval || plen < sizeof(*pval));
+	clockidx = (*pval & 0x80) ? 1 : 0;
+	if (*pval & 0x2000)
+		clockidx += 2;
+
+	/*
+	 * Clock source and divider selection: 3 different clock sources
+	 * can be selected: "ip", "ref" or "sys". For the latter two, a
+	 * clock divider can be defined as well. If the clock source is
+	 * not specified by the device tree, we first try to find an
+	 * optimal CAN source clock based on the system clock. If that
+	 * is not posslible, the reference clock will be used.
+	 */
+	if (clock_name && !strcmp(clock_name, "ip")) {
+		*mscan_clksrc = MSCAN_CLKSRC_IPS;
+		freq = mpc5xxx_get_bus_frequency(ofdev->node);
+	} else {
+		*mscan_clksrc = MSCAN_CLKSRC_BUS;
+
+		pval = of_get_property(ofdev->node,
+				       "fsl,mscan-clock-divider", &plen);
+		if (pval && plen == sizeof(*pval))
+			clockdiv = *pval;
+		if (!clockdiv)
+			clockdiv = 1;
+
+		if (!clock_name || !strcmp(clock_name, "sys")) {
+			sys_clk = clk_get(&ofdev->dev, "sys_clk");
+			if (!sys_clk) {
+				dev_err(&ofdev->dev, "couldn't get sys_clk\n");
+				goto exit_unmap;
+			}
+			/* Get and round up/down sys clock rate */
+			sys_freq = 1000000 *
+				((clk_get_rate(sys_clk) + 499999) / 1000000);
+
+			if (!clock_name) {
+				/* A multiple of 16 MHz would be optimal */
+				if ((sys_freq % 16000000) == 0) {
+					clocksrc = 0;
+					clockdiv = sys_freq / 16000000;
+					freq = sys_freq / clockdiv;
+				}
+			} else {
+				clocksrc = 0;
+				freq = sys_freq / clockdiv;
+			}
+		}
+
+		if (clocksrc < 0) {
+			ref_clk = clk_get(&ofdev->dev, "ref_clk");
+			if (!ref_clk) {
+				dev_err(&ofdev->dev, "couldn't get ref_clk\n");
+				goto exit_unmap;
+			}
+			clocksrc = 1;
+			freq = clk_get_rate(ref_clk) / clockdiv;
+		}
+	}
+
+	/* Disable clock */
+	out_be32(&clockctl->mccr[clockidx], 0x0);
+	if (clocksrc >= 0) {
+		/* Set source and divider */
+		val = (clocksrc << 14) | ((clockdiv - 1) << 17);
+		out_be32(&clockctl->mccr[clockidx], val);
+		/* Enable clock */
+		out_be32(&clockctl->mccr[clockidx], val | 0x10000);
+	}
+
+	/* Enable MSCAN clock domain */
+	val = in_be32(&clockctl->sccr[1]);
+	if (!(val & (1 << 25)))
+		out_be32(&clockctl->sccr[1], val | (1 << 25));
+
+	dev_dbg(&ofdev->dev, "using '%s' with frequency divider %d\n",
+		*mscan_clksrc == MSCAN_CLKSRC_IPS ? "ips_clk" :
+		clocksrc == 1 ? "ref_clk" : "sys_clk", clockdiv);
+
+exit_unmap:
+	of_node_put(np_clock);
+	iounmap(clockctl);
+
+	return freq;
+}
+#else /* !CONFIG_PPC_MPC512x */
+static u32 __devinit mpc512x_can_get_clock(struct of_device *ofdev,
+					   const char *clock_name,
+					   int *mscan_clksrc)
+{
+	return 0;
+}
+#endif /* CONFIG_PPC_MPC512x */
+
+static int __devinit mpc5xxx_can_probe(struct of_device *ofdev,
+				       const struct of_device_id *id)
+{
+	struct mpc5xxx_can_data *data = (struct mpc5xxx_can_data *)id->data;
+	struct device_node *np = ofdev->node;
+	struct rtcan_device *dev;
+	void __iomem *base;
+	const char *clock_name = NULL;
+	int irq, mscan_clksrc = 0;
+	int err = -ENOMEM;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		dev_err(&ofdev->dev, "couldn't ioremap\n");
+		return err;
+	}
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (!irq) {
+		dev_err(&ofdev->dev, "no irq found\n");
+		err = -ENODEV;
+		goto exit_unmap_mem;
+	}
+
+	dev = rtcan_dev_alloc(0, 0);
+	if (!dev)
+		goto exit_dispose_irq;
+
+	clock_name = of_get_property(np, "fsl,mscan-clock-source", NULL);
+
+	BUG_ON(!data);
+	dev->can_sys_clock = data->get_clock(ofdev, clock_name,
+					     &mscan_clksrc);
+	if (!dev->can_sys_clock) {
+		dev_err(&ofdev->dev, "couldn't get MSCAN clock properties\n");
+		goto exit_free_mscan;
+	}
+
+	if (data->type == MSCAN_TYPE_MPC5121)
+		dev->ctrl_name = mscan_ctrl_name_mpc512x;
+	else
+		dev->ctrl_name = mscan_ctrl_name_mpc5200;
+	dev->board_name = mscan_board_name;
+	dev->base_addr = (unsigned long)base;
+
+	err = rtcan_mscan_register(dev, irq, mscan_clksrc);
+	if (err) {
+		dev_err(&ofdev->dev, "registering %s failed (err=%d)\n",
+			RTCAN_DRV_NAME, err);
+		goto exit_free_mscan;
+	}
+
+	dev_set_drvdata(&ofdev->dev, dev);
+
+	dev_info(&ofdev->dev, "MSCAN at 0x%p, irq %d, clock %d Hz\n",
+		 base, irq, dev->can_sys_clock);
+
+	return 0;
+
+exit_free_mscan:
+	rtcan_dev_free(dev);
+exit_dispose_irq:
+	irq_dispose_mapping(irq);
+exit_unmap_mem:
+	iounmap(base);
+
+	return err;
+}
+
+static int __devexit mpc5xxx_can_remove(struct of_device *ofdev)
+{
+	struct rtcan_device *dev = dev_get_drvdata(&ofdev->dev);
+
+	dev_set_drvdata(&ofdev->dev, NULL);
+
+	rtcan_mscan_unregister(dev);
+	iounmap((void *)dev->base_addr);
+        rtcan_dev_free(dev);
+
+	return 0;
+}
+
+static struct mpc5xxx_can_data __devinitdata mpc5200_can_data = {
+	.type = MSCAN_TYPE_MPC5200,
+	.get_clock = mpc52xx_can_get_clock,
+};
+
+static struct mpc5xxx_can_data __devinitdata mpc5121_can_data = {
+	.type = MSCAN_TYPE_MPC5121,
+	.get_clock = mpc512x_can_get_clock,
+};
+
+static struct of_device_id __devinitdata mpc5xxx_can_table[] = {
+	{ .compatible = "fsl,mpc5200-mscan", .data = &mpc5200_can_data, },
+	/* Note that only MPC5121 Rev. 2 (and later) is supported */
+	{ .compatible = "fsl,mpc5121-mscan", .data = &mpc5121_can_data, },
+	{},
+};
+
+static struct of_platform_driver mpc5xxx_can_driver = {
+	.owner = THIS_MODULE,
+	.name = RTCAN_DRV_NAME,
+	.probe = mpc5xxx_can_probe,
+	.remove = __devexit_p(mpc5xxx_can_remove),
+	.match_table = mpc5xxx_can_table,
+};
+
+static int __init mpc5xxx_can_init(void)
+{
+	return of_register_platform_driver(&mpc5xxx_can_driver);
+}
+module_init(mpc5xxx_can_init);
+
+static void __exit mpc5xxx_can_exit(void)
+{
+	return of_unregister_platform_driver(&mpc5xxx_can_driver);
+};
+module_exit(mpc5xxx_can_exit);
+
+MODULE_AUTHOR("Wolfgang Grandegger <wg@domain.hid>");
+MODULE_DESCRIPTION("RT-Socket-CAN driver for MPC5200 and MPC521x");
+MODULE_LICENSE("GPL v2");
diff --git a/ksrc/drivers/can/mscan/rtcan_mscan_proc.c b/ksrc/drivers/can/mscan/rtcan_mscan_proc.c
index cfddfb7..13ba8e4 100644
--- a/ksrc/drivers/can/mscan/rtcan_mscan_proc.c
+++ b/ksrc/drivers/can/mscan/rtcan_mscan_proc.c
@@ -38,9 +38,11 @@ static int rtcan_mscan_proc_regs(char *buf, char **start, off_t offset,
 {
 	struct rtcan_device *dev = (struct rtcan_device *)data;
 	struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
+#ifdef CONFIG_XENO_DRIVERS_CAN_MSCAN_OLD
 	struct mpc5xxx_gpio *gpio = (struct mpc5xxx_gpio *)MPC5xxx_GPIO;
-	u8 canctl0, canctl1;
 	u32 port_config;
+#endif
+	u8 canctl0, canctl1;
 	RTCAN_PROC_PRINT_VARS(80);
 
 	if (!RTCAN_PROC_PRINT("MSCAN registers at %p\n", regs))
@@ -98,6 +100,7 @@ static int rtcan_mscan_proc_regs(char *buf, char **start, off_t offset,
 	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr7)))
 		goto done;
 
+#ifdef CONFIG_XENO_DRIVERS_CAN_MSCAN_OLD
 	if (!RTCAN_PROC_PRINT("GPIO registers\n"))
 		goto done;
 	port_config = in_be32(&gpio->port_config);
@@ -107,6 +110,7 @@ static int rtcan_mscan_proc_regs(char *buf, char **start, off_t offset,
 			       (port_config & 0x70) == 0x10 ?
 			       "CAN1/2 on PSC2 pins": "MSCAN1/2 not routed")))
 		goto done;
+#endif
 
 done:
 	RTCAN_PROC_PRINT_DONE;
diff --git a/ksrc/drivers/can/mscan/rtcan_mscan_regs.h b/ksrc/drivers/can/mscan/rtcan_mscan_regs.h
index b4652f5..e623b9a 100644
--- a/ksrc/drivers/can/mscan/rtcan_mscan_regs.h
+++ b/ksrc/drivers/can/mscan/rtcan_mscan_regs.h
@@ -25,6 +25,7 @@
 #ifndef __RTCAN_MSCAN_REGS_H_
 #define __RTCAN_MSCAN_REGS_H_
 
+#ifdef CONFIG_XENO_DRIVERS_CAN_MSCAN_OLD
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,20)
 #include <sysdev/fsl_soc.h>
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,22)
@@ -60,6 +61,7 @@ static inline void __iomem *mpc5xxx_gpio_find_and_map(void)
 #define MPC5xxx_GPIO	MPC52xx_VA(MPC52xx_GPIO_OFFSET)
 #define mpc5xxx_gpio	mpc52xx_gpio
 #endif
+#endif
 
 #define MSCAN_CAN1_ADDR	(MSCAN_MBAR + 0x0900) /* MSCAN Module 1 */
 #define MSCAN_CAN2_ADDR	(MSCAN_MBAR + 0x0980) /* MSCAN Module 2 */
@@ -200,6 +202,12 @@ struct mscan_regs {
 	struct mscan_msgbuf cantxfg;	/* MSCAN + 0x60 */    /* Foreground transmit buffer */
 };
 
+/* Clock source selection
+ */
+#define MSCAN_CLKSRC_BUS	0
+#define MSCAN_CLKSRC_XTAL	MSCAN_CLKSRC
+#define MSCAN_CLKSRC_IPS	MSCAN_CLKSRC
+
 /* Message type access macros.
  */
 #define MSCAN_BUF_STD_RTR	0x10
-- 
1.6.2.5


