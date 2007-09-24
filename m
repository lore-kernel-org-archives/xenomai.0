Message-ID: <46F7B400.1020209@domain.hid>
Date: Mon, 24 Sep 2007 14:56:32 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <46F777EE.3060100@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB023D2124@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB023D2124@domain.hid>
Content-Type: multipart/mixed; boundary="------------030009030402060303050406"
Subject: Re: [Xenomai-core] RTCAN (MSCAN) doesn't compile on latest Denx
	2.6.23
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------030009030402060303050406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

Daniel Schnell wrote:
> Hi,
> 
> I have cross compiled Xenomai latest trunk (Adeos-1.7) for the Denx
> 2.6.23 tree for a PowerPC5200 arch, and the only annoyance I can see is
> that MSCAN driver for Xenomai is not compiling because of missing
> defines/enums in asm-powerpc/mpc52xx.h in comparision to
> asm-ppc/mpc52xx.h.

It's a bit more tricky as it has to deal with flat device tree based 
resource management.

> Looking at the included socket-can mscan driver, things seem to have
> changed quite a bit since the socketcan has been ported to
> RTCAN/Xenomai.
> 
> Wolfgang, Jan, is the MSCAN RT driver just needing the appropriate
> defines inside asm-powerpc/mpc52xx.h or or does the driver itself need
> changes ? How does the socketcan MSCAN driver come along without these ?

I have a patch already since a while but forgot to post it. Could you 
please give the attached patch a try?

Wolfgang.


--------------030009030402060303050406
Content-Type: text/x-patch;
 name="xenomai-rtcan-mscan.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-mscan.patch"

Index: ksrc/drivers/can/mscan/rtcan_mscan.c
===================================================================
--- ksrc/drivers/can/mscan/rtcan_mscan.c	(revision 3008)
+++ ksrc/drivers/can/mscan/rtcan_mscan.c	(working copy)
@@ -88,7 +88,9 @@ char *mscan_pins = NULL;
 module_param(mscan_pins, charp, 0444);
 MODULE_PARM_DESC(mscan_pins, "Routing to GPIO pins (PSC2 or I2C1/TMR01)");
  
-struct rtcan_device *rtcan_mscan_devs[RTCAN_MSCAN_DEVS];
+static struct rtcan_device *rtcan_mscan_devs[RTCAN_MSCAN_DEVS];
+static int rtcan_mscan_count;
+
 
 /**
  *  Reception Interrupt handler
@@ -733,26 +735,45 @@ static inline void __init mscan_gpio_con
     }
 }
 
-int __init rtcan_mscan_init_one(int idx)
+static inline int mscan_get_config(unsigned long *addr,
+				   unsigned int *irq)
+{
+#ifdef CONFIG_PPC_MERGE
+    /* Use Open Firmware device tree */
+    struct device_node *np = NULL;
+    unsigned int i;
+    int ret;
+
+    for (i = 0; i < RTCAN_MSCAN_DEVS; i++) {
+	struct resource r[2] = {};
+
+	np = of_find_compatible_node(np, "mscan", "mpc5200-mscan");
+	if (np == NULL)
+	    break;
+	ret = of_address_to_resource(np, 0, &r[0]);
+	if (ret)
+	    return ret;
+	of_irq_to_resource(np, 0, &r[1]);
+	addr[i] = r[0].start;
+	irq[i] = r[1].start;
+	rtcan_mscan_count++;
+    }
+#else
+    addr[0] = MSCAN_CAN1_ADDR;
+    irq[0] = MSCAN_CAN1_IRQ;
+    addr[1] = MSCAN_CAN2_ADDR;
+    irq[1] = MSCAN_CAN2_IRQ;
+    rtcan_mscan_count = 2;
+#endif
+    return 0;
+}
+
+int __init rtcan_mscan_init_one(int idx, unsigned long addr, int irq)
 {
-    int ret, irq;
-    unsigned long addr;
+    int ret;
     struct rtcan_device *dev;
     struct mscan_regs *regs;
 
-    switch (port[idx]) {
-    case 1:
-	addr = MSCAN_CAN1_ADDR;
-	irq = MSCAN_CAN1_IRQ;
-	break;
-    case 2:
-	addr = MSCAN_CAN2_ADDR;
-	irq = MSCAN_CAN2_IRQ;
-	break;
-    default:
-	return 0;
-    }
-
     if ((dev = rtcan_dev_alloc(0, 0)) == NULL) {
         return -ENOMEM;
     }
@@ -762,7 +783,13 @@ int __init rtcan_mscan_init_one(int idx)
 
     dev->can_sys_clock = mscan_clock;
 
-    dev->base_addr = addr;
+    dev->base_addr = (unsigned long)ioremap(addr, MSCAN_SIZE);
+    if (dev->base_addr == 0) {
+	ret = -ENOMEM;
+	printk("ERROR! ioremap of %#lx failed\n", addr);
+	goto out_dev_free;
+    }
+
     regs = (struct mscan_regs *)dev->base_addr;
 
     /* Enable MSCAN module. */
@@ -790,7 +817,7 @@ int __init rtcan_mscan_init_one(int idx)
 			   0, RTCAN_DRV_NAME, (void *)dev);
     if (ret) {
 	printk("ERROR! rtdm_irq_request for IRQ %d failed\n", irq);
-	goto out_dev_free;
+	goto out_iounmap;
     }
 
     mscan_chip_config(regs);
@@ -812,12 +839,15 @@ int __init rtcan_mscan_init_one(int idx)
 
     return 0;
 
- out_irq_free:
+out_irq_free:
     rtdm_irq_free(&dev->irq_handle);
 
- out_dev_free:
+out_iounmap:
     /* Disable MSCAN module. */
     regs->canctl1 &= ~MSCAN_CANE;
+    iounmap((void *)dev->base_addr);
+
+out_dev_free:
     rtcan_dev_free(dev);
 
     return ret;
@@ -829,17 +859,18 @@ static void __exit rtcan_mscan_exit(void
     int i;
     struct rtcan_device *dev;
 
-    for (i = 0; i < RTCAN_MSCAN_DEVS; i++) {
+    for (i = 0; i < rtcan_mscan_count; i++) {
 
 	if ((dev = rtcan_mscan_devs[i]) == NULL)
 	    continue;
-	
+
 	printk("Unloading %s device %s\n", RTCAN_DRV_NAME, dev->name);
 
         rtcan_mscan_mode_stop(dev, NULL);
 	rtdm_irq_free(&dev->irq_handle);
 	rtcan_mscan_remove_proc(dev);
 	rtcan_dev_unregister(dev);
+	iounmap((void *)dev->base_addr);
         rtcan_dev_free(dev);
     }
 
@@ -847,15 +878,21 @@ static void __exit rtcan_mscan_exit(void
 
 static int __init rtcan_mscan_init(void)
 {
-    int i, err;
+    int i, idx, err;
+    int unsigned long addr[RTCAN_MSCAN_DEVS];
+    int irq[RTCAN_MSCAN_DEVS];
 
+    if ((err = mscan_get_config(addr, irq)))
+	return err;
     mscan_gpio_config();
 
-    for (i = 0; i < RTCAN_MSCAN_DEVS; i++) {
-	if (port[i] < 1 || port[i] > RTCAN_MSCAN_DEVS)
+    for (i = 0; i < rtcan_mscan_count; i++) {
+	idx = port[i];
+	if (idx < 1 || idx > rtcan_mscan_count)
 	    continue;
 
-	if ((err = rtcan_mscan_init_one(i) != 0)) {
+	err = rtcan_mscan_init_one(idx, addr[idx], irq[idx]);
+	if (err) {
 	    rtcan_mscan_exit();
 	    return err;
 	}
Index: ksrc/drivers/can/mscan/rtcan_mscan_regs.h
===================================================================
--- ksrc/drivers/can/mscan/rtcan_mscan_regs.h	(revision 3008)
+++ ksrc/drivers/can/mscan/rtcan_mscan_regs.h	(working copy)
@@ -25,7 +25,13 @@
 #ifndef __RTCAN_MSCAN_REGS_H_
 #define __RTCAN_MSCAN_REGS_H_
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,20)
+#include <sysdev/fsl_soc.h>
+#include <asm/of_platform.h>
+#include <asm/mpc52xx.h>
+#define MPC5xxx_GPIO    mpc52xx_find_and_map("mpc5200-gpio")
+#define mpc5xxx_gpio	mpc52xx_gpio
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
 #include <asm/mpc5xxx.h>
 #define MSCAN_MBAR	MPC5xxx_MBAR
 #define MSCAN_CAN1_IRQ	MPC5xxx_CAN1_IRQ
@@ -35,12 +41,13 @@
 #define MSCAN_MBAR	MPC52xx_MBAR
 #define MSCAN_CAN1_IRQ	MPC52xx_MSCAN1_IRQ
 #define MSCAN_CAN2_IRQ	MPC52xx_MSCAN2_IRQ
-#define MPC5xxx_GPIO	MPC52xx_VA(MPC52xx_GPIO_OFFSET) 
+#define MPC5xxx_GPIO	MPC52xx_VA(MPC52xx_GPIO_OFFSET)
 #define mpc5xxx_gpio	mpc52xx_gpio
 #endif
 
 #define MSCAN_CAN1_ADDR	(MSCAN_MBAR + 0x0900) /* MSCAN Module 1 */
 #define MSCAN_CAN2_ADDR	(MSCAN_MBAR + 0x0980) /* MSCAN Module 2 */
+#define MSCAN_SIZE      0x80
 
 /* MSCAN control register 0 (CANCTL0) bits */
 #define MSCAN_RXFRM	0x80

--------------030009030402060303050406--

