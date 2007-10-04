Message-ID: <4704ED0B.2060706@domain.hid>
Date: Thu, 04 Oct 2007 15:39:23 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <46F777EE.3060100@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB023D2124@domain.hid>
	<46F7B400.1020209@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB0244B830@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0244B830@domain.hid>
Content-Type: multipart/mixed; boundary="------------060001060803030505010004"
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
--------------060001060803030505010004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Daniel Schnell wrote:
> Wolfgang Grandegger wrote:
> 
>> I have a patch already since a while but forgot to post it. Could you
>> please give the attached patch a try? 
>>
> 
> I have given the patch a try and it doesn't quite work out of the box,
> as there is an index off-by-one error concerning the configured CAN
> ports. The result is that probing the CAN controller starts with the
> second entry in the device tree and a random address will be probed for
> the second CAN controller where ioremap gladly bumps out with an error
> which results in a RT-CAN shutdown.
> 
> The applied patch solves the issue for me. I don't know if it works in
> case of (! #defined CONFIG_PPC_MERGE)

I have fixed this issue in a slightly different way. The MSCAN ports can 
now be enabled/disbaled via module argument as shown:

   port=1,1  enable both ports
   port=1,0  enable only first port
   port=0,1  enable only second port

This is less error-prone and works also fine if only one MSCAN device is 
defined in the Flat Device Tree.

If there are no objections, I'm going to commit the changes to the trunk 
and the v2.3.x branch.

Wolfgang.

--------------060001060803030505010004
Content-Type: text/x-patch;
 name="xenomai-rtcan-mscan-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-mscan-2.patch"

Index: ksrc/drivers/can/mscan/rtcan_mscan.c
===================================================================
--- ksrc/drivers/can/mscan/rtcan_mscan.c	(revision 3025)
+++ ksrc/drivers/can/mscan/rtcan_mscan.c	(working copy)
@@ -60,20 +60,20 @@
 int port[RTCAN_MSCAN_DEVS] = {
 #ifdef CONFIG_XENO_DRIVERS_CAN_MSCAN_1
 #ifdef CONFIG_XENO_DRIVERS_CAN_MSCAN_2
-	1, 2  /* Enable CAN 1 and 2 */
+	1, 1  /* Enable CAN 1 and 2 */
 #else
 	1, 0  /* Enable CAN 1 only  */
 #endif
 #else
 #ifdef CONFIG_XENO_DRIVERS_CAN_MSCAN_2
-	2, 0  /* Enable CAN 2 only  */
+	0, 1  /* Enable CAN 2 only  */
 #else
 #error "No CAN controller enabled, fix configuration!"
 #endif
 #endif
 };
 compat_module_param_array(port, int, RTCAN_MSCAN_DEVS, 0444);
-MODULE_PARM_DESC(port, "Port numbers of enabled controllers, e.g. 1,2");
+MODULE_PARM_DESC(port, "Enabled CAN ports (1,1 or 0,1 or 0,1)");
 
 /* 
  * Note: on the MPC5200 the MSCAN clock source is the IP bus 
@@ -88,8 +88,10 @@
 module_param(mscan_pins, charp, 0444);
 MODULE_PARM_DESC(mscan_pins, "Routing to GPIO pins (PSC2 or I2C1/TMR01)");
  
-struct rtcan_device *rtcan_mscan_devs[RTCAN_MSCAN_DEVS];
+static struct rtcan_device *rtcan_mscan_devs[RTCAN_MSCAN_DEVS];
+static int rtcan_mscan_count;
 
+
 /**
  *  Reception Interrupt handler
  *
@@ -733,26 +735,45 @@
     }
 }
 
-int __init rtcan_mscan_init_one(int idx)
+static inline int mscan_get_config(unsigned long *addr,
+				   unsigned int *irq)
 {
-    int ret, irq;
-    unsigned long addr;
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
+{
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
@@ -762,7 +783,13 @@
 
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
@@ -790,7 +817,7 @@
 			   0, RTCAN_DRV_NAME, (void *)dev);
     if (ret) {
 	printk("ERROR! rtdm_irq_request for IRQ %d failed\n", irq);
-	goto out_dev_free;
+	goto out_iounmap;
     }
 
     mscan_chip_config(regs);
@@ -808,16 +835,19 @@
     rtcan_mscan_devs[idx] = dev;
 
     printk("%s: %s driver loaded (port %d, base-addr 0x%lx irq %d)\n",
-	   dev->name, RTCAN_DRV_NAME, port[idx], addr, irq);
+	   dev->name, RTCAN_DRV_NAME, idx + 1, addr, irq);
 
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
@@ -829,17 +859,18 @@
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
 
@@ -848,14 +879,19 @@
 static int __init rtcan_mscan_init(void)
 {
     int i, err;
+    int unsigned long addr[RTCAN_MSCAN_DEVS];
+    int irq[RTCAN_MSCAN_DEVS];
 
+    if ((err = mscan_get_config(addr, irq)))
+	return err;
     mscan_gpio_config();
 
-    for (i = 0; i < RTCAN_MSCAN_DEVS; i++) {
-	if (port[i] < 1 || port[i] > RTCAN_MSCAN_DEVS)
+    for (i = 0; i < rtcan_mscan_count; i++) {
+	if (!port[i])
 	    continue;
 
-	if ((err = rtcan_mscan_init_one(i) != 0)) {
+	err = rtcan_mscan_init_one(i, addr[i], irq[i]);
+	if (err) {
 	    rtcan_mscan_exit();
 	    return err;
 	}
Index: ksrc/drivers/can/mscan/rtcan_mscan_regs.h
===================================================================
--- ksrc/drivers/can/mscan/rtcan_mscan_regs.h	(revision 3025)
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

--------------060001060803030505010004--

