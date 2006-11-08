Message-ID: <4551C634.4050902@domain.hid>
Date: Wed, 08 Nov 2006 12:57:40 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090600060306070604020001"
Subject: [Xenomai-core] [PATCH] RT-Socket-CAN, fix warnings on ARM, etc.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------090600060306070604020001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

the attached patch fixes:

    * ksrc/drivers/can/sja1000/rtcan_peak_dng.c: Fix warnings when
    building for ARM and fix bugs in the exit code.

    * ksrc/drivers/can/sja1000/rtcan_mem.c: Fix warnings when
    building for ARM.

Wolfgang.

--------------090600060306070604020001
Content-Type: text/x-patch;
 name="xenomai-rtcan-arm-warnings.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-arm-warnings.patch"

Index: ChangeLog
===================================================================
--- ChangeLog	(revision 1809)
+++ ChangeLog	(working copy)
@@ -1,3 +1,11 @@
+2006-11-08  Wolfgang Grandegger  <wg@domain.hid>
+
+	* ksrc/drivers/can/sja1000/rtcan_peak_dng.c: Fix warnings when
+	building for ARM and fix bugs in the exit code.
+
+	* ksrc/drivers/can/sja1000/rtcan_mem.c: Fix warnings when
+	building for ARM.
+
 2006-11-05  Philippe Gerum  <rpm@xenomai.org>
 
  	* RELEASE: Xenomai 2.3-rc1
Index: ksrc/drivers/can/sja1000/rtcan_peak_dng.c
===================================================================
--- ksrc/drivers/can/sja1000/rtcan_peak_dng.c	(revision 1809)
+++ ksrc/drivers/can/sja1000/rtcan_peak_dng.c	(working copy)
@@ -88,15 +88,15 @@
 };
 
 /* Enable and disable irqs */
-static inline void rtcan_parport_disable_irq(int port)
+static inline void rtcan_parport_disable_irq(u32 port)
 {
-    u16 pc = (u16)port + 2;
+    u32 pc = port + 2;
     outb(inb(pc) & ~0x10, pc);
 }
 
-static inline void rtcan_parport_enable_irq(int port)
+static inline void rtcan_parport_enable_irq(u32 port)
 {
-    u16 pc = (u16)port + 2;
+    u32 pc = port + 2;
     outb(inb(pc) | 0x10, pc);
 }
 
@@ -104,9 +104,9 @@
 static u8 rtcan_peak_dng_sp_readreg(struct rtcan_device *dev, int port)
 {
     struct rtcan_peak_dng *dng = (struct rtcan_peak_dng *)dev->board_priv;
-    u16 pa = dng->ioport;
-    u16 pb = pa + 1;
-    u16 pc = pb + 1;
+    u32 pa = dng->ioport;
+    u32 pb = pa + 1;
+    u32 pc = pb + 1;
     u8  b0, b1 ;
     u8  irq_enable = inb(pc) & 0x10; /* don't influence irq_enable */
 
@@ -124,8 +124,8 @@
 static void rtcan_peak_dng_writereg(struct rtcan_device *dev, int port, u8 data)
 {
     struct rtcan_peak_dng *dng = (struct rtcan_peak_dng *)dev->board_priv;
-    u16 pa = dng->ioport;
-    u16 pc = pa + 2;
+    u32 pa = dng->ioport;
+    u32 pc = pa + 2;
     u8  irq_enable = inb(pc) & 0x10; /* don't influence irq_enable */
 
     outb((0x0B ^ 0x0D) | irq_enable, pc);
@@ -139,8 +139,8 @@
 static u8 rtcan_peak_dng_epp_readreg(struct rtcan_device *dev, int port)
 {
     struct rtcan_peak_dng *dng = (struct rtcan_peak_dng *)dev->board_priv;
-    u16 pa = dng->ioport;
-    u16 pc = pa + 2;
+    u32 pa = dng->ioport;
+    u32 pc = pa + 2;
     u8  val;
     u8  irq_enable = inb(pc) & 0x10; /* don't influence irq_enable */
 
@@ -157,7 +157,7 @@
 /* to switch epp on or restore register */
 static void dongle_set_ecr(u16 port, struct rtcan_peak_dng *dng)
 {
-    u16 ecr = dng->ecr;
+    u32 ecr = dng->ecr;
 
     dng->old_ecr = inb(ecr);
     outb((dng->old_ecr & 0x1F) | 0x20, ecr);
@@ -168,7 +168,7 @@
 
 static void dongle_restore_ecr(u16 port, struct rtcan_peak_dng *dng)
 {
-    u16 ecr = dng->ecr;
+    u32 ecr = dng->ecr;
 
     outb(dng->old_ecr, ecr);
 
@@ -178,7 +178,7 @@
 static inline void rtcan_peak_dng_enable(struct rtcan_device *dev)
 {
     struct rtcan_peak_dng *dng = (struct rtcan_peak_dng *)dev->board_priv;
-    u16 port = dng->ioport;
+    u32 port = dng->ioport;
 
     /* save old port contents */
     dng->old_data = inb(port);
@@ -194,7 +194,7 @@
 static inline void rtcan_peak_dng_disable(struct rtcan_device *dev)
 {
     struct rtcan_peak_dng *dng = (struct rtcan_peak_dng *)dev->board_priv;
-    u16 port = dng->ioport;
+    u32 port = dng->ioport;
 
     rtcan_parport_disable_irq(port);
     
@@ -303,6 +303,17 @@
     return ret;
 }
 
+void __exit rtcan_peak_dng_exit_one(struct rtcan_device *dev)
+{
+    struct rtcan_peak_dng *dng = (struct rtcan_peak_dng *)dev->board_priv;
+
+    rtcan_peak_dng_disable(dev);
+    if (dng->type == DONGLE_TYPE_EPP)
+	release_region(dng->ecr, ECR_PORT_SIZE);
+    release_region(dng->ioport, DNG_PORT_SIZE);
+    rtcan_sja1000_unregister(dev);
+}
+
 /** Init module */
 static int __init rtcan_peak_dng_init(void)
 {
@@ -312,7 +323,7 @@
 	 i < RTCAN_PEAK_DNG_MAX_DEV && type[i] != 0; 
 	 i++) {
 
-	if ((ret = rtcan_peak_dng_init_one(i) != 0)) {
+	if ((ret = rtcan_peak_dng_init_one(i)) != 0) {
 	    printk("Init failed with %d\n", ret);
 	    return ret;
 	}
@@ -333,10 +344,8 @@
 
     for (i = 0, dev = rtcan_peak_dng_devs[i]; 
 	 i < RTCAN_PEAK_DNG_MAX_DEV && dev != NULL;
-	 i++) {
-	rtcan_peak_dng_disable(dev);
-	rtcan_sja1000_unregister(dev);
-    }
+	 i++) 
+	rtcan_peak_dng_exit_one(dev);
 }
 
 module_init(rtcan_peak_dng_init);
Index: ksrc/drivers/can/sja1000/rtcan_mem.c
===================================================================
--- ksrc/drivers/can/sja1000/rtcan_mem.c	(revision 1809)
+++ ksrc/drivers/can/sja1000/rtcan_mem.c	(working copy)
@@ -154,7 +154,7 @@
 	return 0;
 
  out_iounmap:
-	iounmap(board->vmem);
+	iounmap((void *)board->vmem);
 
  out_release_mem:
 	release_mem_region(mem[idx], RTCAN_MEM_RANGE);
@@ -203,7 +203,7 @@
 			continue;
 		vmem = ((struct rtcan_mem *)dev->board_priv)->vmem;
 		rtcan_sja1000_unregister(dev);
-		iounmap(vmem);
+		iounmap((void *)vmem);
 		release_mem_region(mem[i], RTCAN_MEM_RANGE);
 	}
 }

--------------090600060306070604020001--

