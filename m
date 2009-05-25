Message-ID: <4A1A4BDA.9000204@domain.hid>
Date: Mon, 25 May 2009 09:42:18 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] rtcan: mscan: fix build problems with recent
	kernel versions
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This patch fixes build problems with recent kernel version due
to changes of the OpenFirmware device compatibility names.
Furthermore, it introduces a Kconfig option to leave the CAN
pin routing as-is (normally pre-configured by the boot-loader).

Signed-off-by: Wolfgang Grandegger <wg@domain.hid>
---
 ksrc/drivers/can/mscan/Kconfig            |    5 ++++-
 ksrc/drivers/can/mscan/rtcan_mscan.c      |   18 ++++++++++++++----
 ksrc/drivers/can/mscan/rtcan_mscan_regs.h |   12 +++++++++---
 3 files changed, 27 insertions(+), 8 deletions(-)

Index: xenomai-2.4/ksrc/drivers/can/mscan/rtcan_mscan.c
===================================================================
--- xenomai-2.4.orig/ksrc/drivers/can/mscan/rtcan_mscan.c	2009-05-25 08:25:44.478719020 +0200
+++ xenomai-2.4/ksrc/drivers/can/mscan/rtcan_mscan.c	2009-05-25 08:25:48.287395053 +0200
@@ -703,9 +703,11 @@
 static inline void __init mscan_gpio_config(void)
 {
     struct mpc5xxx_gpio *gpio = (struct mpc5xxx_gpio *)MPC5xxx_GPIO;
-    int can_to_psc2 = 0;
+    int can_to_psc2 = -1;
 
-#ifdef CONFIG_XENO_DRIVERS_CAN_MSCAN_PSC2
+#if defined(CONFIG_XENO_DRIVERS_CAN_MSCAN_ALT)
+    can_to_psc2 = 0;
+#elif defined(CONFIG_XENO_DRIVERS_CAN_MSCAN_PSC2)
     can_to_psc2 = 1;
 #endif
 
@@ -723,6 +725,12 @@
 		   "Please use PSC2 or I2C1/TMR01.\n", mscan_pins);	    
 	}
     }
+
+    if (!gpio || can_to_psc2 < 0) {
+	printk("%s: use pre-configure CAN routing\n", RTCAN_DRV_NAME);
+	return;
+    }
+
     if (can_to_psc2) {
 	gpio->port_config &= ~0x10000070;
 	gpio->port_config |= 0x00000010;
@@ -737,7 +745,7 @@
 static inline int mscan_get_config(unsigned long *addr,
 				   unsigned int *irq)
 {
-#ifdef CONFIG_PPC_MERGE
+#if defined(CONFIG_PPC_MERGE) || LINUX_VERSION_CODE > KERNEL_VERSION(2,6,27)
     /* Use Open Firmware device tree */
     struct device_node *np = NULL;
     unsigned int i;
@@ -746,7 +754,9 @@
     for (i = 0; i < RTCAN_MSCAN_DEVS; i++) {
 	struct resource r[2] = {};
 
-	np = of_find_compatible_node(np, "mscan", "mpc5200-mscan");
+	np = of_find_compatible_node(np, NULL, "fsl,mpc5200-mscan");
+	if (np == NULL)
+	    np = of_find_compatible_node(np, NULL, "mpc5200-mscan");
 	if (np == NULL)
 	    break;
 	ret = of_address_to_resource(np, 0, &r[0]);
Index: xenomai-2.4/ksrc/drivers/can/mscan/rtcan_mscan_regs.h
===================================================================
--- xenomai-2.4.orig/ksrc/drivers/can/mscan/rtcan_mscan_regs.h	2009-05-25 08:25:44.478719020 +0200
+++ xenomai-2.4/ksrc/drivers/can/mscan/rtcan_mscan_regs.h	2009-05-25 08:25:48.287718842 +0200
@@ -27,17 +27,23 @@
 
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,20)
 #include <sysdev/fsl_soc.h>
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,22)
+#include <linux/of_platform.h>
+#else
 #include <asm/of_platform.h>
+#endif
 #include <asm/mpc52xx.h>
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,24)
-static inline void __iomem *mpc52xx_find_and_map(const char *compatible)
+static inline void __iomem *mpc5xxx_gpio_find_and_map(void)
 {
 	struct device_node *ofn;
-	ofn = of_find_compatible_node(NULL, NULL, compatible);
+	ofn = of_find_compatible_node(NULL, NULL, "mpc5200-gpio");
+	if (!ofn)
+	    ofn = of_find_compatible_node(NULL, NULL, "fsl,mpc5200-gpio");
 	return ofn ? of_iomap(ofn, 0) : NULL;
 }
 #endif
-#define MPC5xxx_GPIO    mpc52xx_find_and_map("mpc5200-gpio")
+#define MPC5xxx_GPIO    mpc5xxx_gpio_find_and_map()
 #define mpc5xxx_gpio	mpc52xx_gpio
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
 #include <asm/mpc5xxx.h>
Index: xenomai-2.4/ksrc/drivers/can/mscan/Kconfig
===================================================================
--- xenomai-2.4.orig/ksrc/drivers/can/mscan/Kconfig	2009-05-25 08:25:44.478719020 +0200
+++ xenomai-2.4/ksrc/drivers/can/mscan/Kconfig	2009-05-25 08:25:48.290720662 +0200
@@ -27,9 +27,12 @@
 choice
 	depends on XENO_DRIVERS_CAN_MSCAN
 	prompt "Pin Configuration"
-	default I2C1/TMR01
+	default XENO_DRIVERS_CAN_MSCAN_PRE
 	help
 
+config XENO_DRIVERS_CAN_MSCAN_PRE
+	bool "Use pre-configured CAN routing"
+
 config XENO_DRIVERS_CAN_MSCAN_ALT
 	bool "CAN 1 on I2C1 pins, CAN 2 on TMR01 pins"
 

