From: Sebastian Smolorz <ssm@domain.hid>
Date: Wed, 18 Jul 2007 16:24:58 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6KinGJoccKvT1zP"
Message-Id: <E1IBASV-0003zW-Kv@domain.hid>
Subject: [Adeos-main] [PATCH] [arm] Fixes for
	adeos-ipipe-2.6.20-arm-1.7-03.patch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

--Boundary-00=_6KinGJoccKvT1zP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Gilles,

from my local ipipe git repository:

commit 8d207e254161579bcd9dea70e6e9a615d42c5c1c
Author: Sebastian Smolorz <ssm@domain.hid>
Date:   Tue Jul 17 10:06:02 2007 +0200

    Extend ipipe handling of cascaded IRQs.

commit 26851a115304b7de2b4526868131b4b356aafb20
Author: Sebastian Smolorz <ssm@domain.hid>
Date:   Mon Jul 16 14:26:16 2007 +0200

    Abort compilation when CONFIG_NO_IDLE_HZ is set.

commit e3729c39007ca0c9757a5fdcf8cb2ccb19b54b77
Author: Sebastian Smolorz <ssm@domain.hid>
Date:   Mon Jul 16 13:51:59 2007 +0200

    Remove double defined macro irqs_disabled().

commit 9951735935d708f1ef4d9355cb94e3dce2def470
Author: Sebastian Smolorz <ssm@domain.hid>
Date:   Mon Jul 16 13:51:07 2007 +0200

    Remove unused macro raw_irqs_disabled().

commit e16a9f0deafa15a30e90e56fa96ada026d28adc1
Author: Sebastian Smolorz <ssm@domain.hid>
Date:   Mon Jul 16 13:49:56 2007 +0200

    Negate condition in macros local_irq_save_hw(x) and 
local_irq_restore_hw(x)

-- 
Sebastian

--Boundary-00=_6KinGJoccKvT1zP
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ipipe-2.6.20-arm-1.7-03.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ipipe-2.6.20-arm-1.7-03.diff"

diff --git a/arch/arm/mach-s3c2410/irq.c b/arch/arm/mach-s3c2410/irq.c
index 77c79e1..a677f4c 100644
--- a/arch/arm/mach-s3c2410/irq.c
+++ b/arch/arm/mach-s3c2410/irq.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2003,2004 Simtec Electronics
  *	Ben Dooks <ben@domain.hid>
  *
- * Copyright (C) 2006 Sebastian Smolorz <ssmolorz@domain.hid>, emlix GmbH
+ * Copyright (C) 2006, 2007 Sebastian Smolorz <ssmolorz@domain.hid>, emlix GmbH
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -701,6 +701,26 @@ static void __ipipe_s3c_irq_demux_adc(unsigned int subsrc,
 	}
 }
 
+static void __ipipe_s3c_irq_demux_extint(unsigned long mask,
+						struct pt_regs *regs)
+{
+	unsigned int irq;
+	unsigned long eintpnd = __raw_readl(S3C24XX_EINTPEND);
+	unsigned long eintmsk = __raw_readl(S3C24XX_EINTMASK);
+
+	eintpnd &= ~eintmsk;
+	eintpnd &= mask;
+
+	while (eintpnd) {
+		irq = __ffs(eintpnd);
+		eintpnd &= ~(1<<irq);
+
+		irq += (IRQ_EINT4 - 4);
+
+		__ipipe_handle_irq(irq, regs);
+	}
+}
+
 void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
 {
 	unsigned int subsrc, submsk;
@@ -726,14 +746,22 @@ void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
 	case IRQ_ADCPARENT:
 		__ipipe_s3c_irq_demux_adc(subsrc, regs);
 		break;
+	case IRQ_EINT4t7:
+		__ipipe_s3c_irq_demux_extint(0xff, regs);
+		break;
+	case IRQ_EINT8t23:
+		__ipipe_s3c_irq_demux_extint(0xffffff00, regs);
+		break;
 #ifdef CONFIG_CPU_S3C2440
 	case IRQ_WDT:
 		__ipipe_s3c_irq_demux_wdtac97(subsrc, regs);
 		break;
+#endif /* CONFIG_CPU_S3C2440 */
+#ifdef CONFIG_CPU_S3C244X
 	case IRQ_CAM:
 		__ipipe_s3c_irq_demux_cam(subsrc, regs);
 		break;
-#endif /* CONFIG_CPU_S3C2440 */
+#endif /* CONFIG_CPU_S3C244X */
 	}
 
 	desc_unused->chip->unmask(irq);
diff --git a/arch/arm/mach-s3c2410/s3c2440-irq.c b/arch/arm/mach-s3c2410/s3c2440-irq.c
index da74c73..87e96e1 100644
--- a/arch/arm/mach-s3c2410/s3c2440-irq.c
+++ b/arch/arm/mach-s3c2410/s3c2440-irq.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2003,2004 Simtec Electronics
  *	Ben Dooks <ben@domain.hid>
  *
- * Copyright (C) 2006 Sebastian Smolorz <ssmolorz@domain.hid>, emlix GmbH
+ * Copyright (C) 2006, 2007 Sebastian Smolorz <ssmolorz@domain.hid>, emlix GmbH
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -112,19 +112,6 @@ void __ipipe_s3c_irq_demux_wdtac97(unsigned int subsrc, struct pt_regs *regs)
 			__ipipe_handle_irq(IRQ_S3C2440_AC97, regs);
 	}
 }
-
-void __ipipe_s3c_irq_demux_cam(unsigned int subsrc, struct pt_regs *regs)
-{
-	subsrc >>= 11;
-	subsrc &= 3;
-
-	if (subsrc != 0) {
-		if (subsrc & 1)
-			__ipipe_handle_irq(IRQ_S3C2440_CAM_C, regs);
-		if (subsrc & 2)
-			__ipipe_handle_irq(IRQ_S3C2440_CAM_P, regs);
-	}
-}
 #endif /* CONFIG_IPIPE */
 
 static int s3c2440_irq_add(struct sys_device *sysdev)
diff --git a/arch/arm/mach-s3c2410/s3c244x-irq.c b/arch/arm/mach-s3c2410/s3c244x-irq.c
index ede9463..73e6779 100644
--- a/arch/arm/mach-s3c2410/s3c244x-irq.c
+++ b/arch/arm/mach-s3c2410/s3c244x-irq.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2003,2004 Simtec Electronics
  *	Ben Dooks <ben@domain.hid>
  *
+ * Copyright (C) 2007 Sebastian Smolorz <ssmolorz@domain.hid>, emlix GmbH
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -95,6 +97,21 @@ static struct irq_chip s3c_irq_cam = {
 	.ack	    = s3c_irq_cam_ack,
 };
 
+#ifdef CONFIG_IPIPE
+void __ipipe_s3c_irq_demux_cam(unsigned int subsrc, struct pt_regs *regs)
+{
+	subsrc >>= 11;
+	subsrc &= 3;
+
+	if (subsrc != 0) {
+		if (subsrc & 1)
+			__ipipe_handle_irq(IRQ_S3C2440_CAM_C, regs);
+		if (subsrc & 2)
+			__ipipe_handle_irq(IRQ_S3C2440_CAM_P, regs);
+	}
+}
+#endif /* CONFIG_IPIPE */
+
 static int s3c244x_irq_add(struct sys_device *sysdev)
 {
 	unsigned int irqno;
diff --git a/arch/arm/mach-s3c2410/time.c b/arch/arm/mach-s3c2410/time.c
index e7b3d00..622ed34 100644
--- a/arch/arm/mach-s3c2410/time.c
+++ b/arch/arm/mach-s3c2410/time.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2003-2005 Simtec Electronics
  *	Ben Dooks, <ben@domain.hid>
  *
- * Copyright (C) 2006 Sebastian Smolorz <ssmolorz@domain.hid>, emlix GmbH
+ * Copyright (C) 2006, 2007 Sebastian Smolorz <ssmolorz@domain.hid>, emlix GmbH
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -62,6 +62,11 @@ static unsigned long free_running_tcon = 0;
 static unsigned long timer_lxlost = 0;
 
 #ifdef CONFIG_IPIPE
+
+#ifdef CONFIG_NO_IDLE_HZ
+#error "dynamic tick timer not yet supported with IPIPE"
+#endif /* CONFIG_NO_IDLE_HZ */
+
 unsigned int __ipipe_mach_ticks_per_jiffy;
 EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
 
diff --git a/include/asm-arm/arch-s3c2410/irqs.h b/include/asm-arm/arch-s3c2410/irqs.h
index 717be01..988406d 100644
--- a/include/asm-arm/arch-s3c2410/irqs.h
+++ b/include/asm-arm/arch-s3c2410/irqs.h
@@ -3,7 +3,7 @@
  * Copyright (c) 2003-2005 Simtec Electronics
  *   Ben Dooks <ben@domain.hid>
  *
- * Copyright (C) 2006 Sebastian Smolorz <ssmolorz@domain.hid>, emlix GmbH
+ * Copyright (C) 2006, 2007 Sebastian Smolorz <ssmolorz@domain.hid>, emlix GmbH
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -130,13 +130,25 @@
 				 __ipipe_irqbit(IRQ_UART2)	|	\
 				 __ipipe_irqbit(IRQ_ADCPARENT)	|	\
 				 __ipipe_irqbit(IRQ_WDT)	|	\
-				 __ipipe_irqbit(IRQ_CAM))
-#else /* !CONFIG_CPU_S3C2440 */
+				 __ipipe_irqbit(IRQ_CAM)	|	\
+				 __ipipe_irqbit(IRQ_EINT4t7)	|	\
+				 __ipipe_irqbit(IRQ_EINT8t23))
+#elif defined CONFIG_CPU_S3C244X
 #define __ipipe_muxed_irqmask	(__ipipe_irqbit(IRQ_UART0)	|	\
 				 __ipipe_irqbit(IRQ_UART1)	|	\
 				 __ipipe_irqbit(IRQ_UART2)	|	\
-				 __ipipe_irqbit(IRQ_ADCPARENT))
-#endif /* CONFIG_CPU_S3C2440 */
+				 __ipipe_irqbit(IRQ_ADCPARENT)	|	\
+				 __ipipe_irqbit(IRQ_CAM)	|	\
+				 __ipipe_irqbit(IRQ_EINT4t7)	|	\
+				 __ipipe_irqbit(IRQ_EINT8t23))
+#else
+#define __ipipe_muxed_irqmask	(__ipipe_irqbit(IRQ_UART0)	|	\
+				 __ipipe_irqbit(IRQ_UART1)	|	\
+				 __ipipe_irqbit(IRQ_UART2)	|	\
+				 __ipipe_irqbit(IRQ_ADCPARENT)	|	\
+				 __ipipe_irqbit(IRQ_EINT4t7)	|	\
+				 __ipipe_irqbit(IRQ_EINT8t23))
+#endif
 
 #define __ipipe_mach_irq_mux_p(irq)	((irq) <= IRQ_ADCPARENT  &&	\
 					 (__ipipe_irqbit(irq) &		\
diff --git a/include/asm-arm/irqflags.h b/include/asm-arm/irqflags.h
index d0534b9..7e9e55f 100644
--- a/include/asm-arm/irqflags.h
+++ b/include/asm-arm/irqflags.h
@@ -150,8 +150,6 @@ void __ipipe_restore_root(unsigned long flags);
 #define raw_local_save_flags(flags)	((flags) = __ipipe_test_root() << 7)
 #define raw_local_irq_restore(flags)	__ipipe_restore_root(flags & (1 << 7))
 
-#define raw_irqs_disabled()		__ipipe_test_root()
-
 #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
 
 #include <linux/ipipe_trace.h>
@@ -170,13 +168,13 @@ void __ipipe_restore_root(unsigned long flags);
 } while (0)
 #define local_irq_save_hw(x) do { \
 	local_save_flags_hw(x); \
-	if (raw_irqs_disabled_flags(x)) { \
+	if (!raw_irqs_disabled_flags(x)) { \
 		local_irq_disable_hw_notrace(); \
 		ipipe_trace_begin(0x80000001); \
 	} \
 } while (0)
 #define local_irq_restore_hw(x) do { \
-	if (raw_irqs_disabled_flags(x)) \
+	if (!raw_irqs_disabled_flags(x)) \
 		ipipe_trace_end(0x80000001); \
 	local_irq_restore_hw_notrace(x); \
 } while (0)
@@ -209,8 +207,6 @@ void __ipipe_restore_root(unsigned long flags);
 #define local_fiq_disable_hw()		local_fiq_disable_hw_notrace()
 #define local_irq_restore_hw(flags)	local_irq_restore_hw_notrace(flags)
 
-#define irqs_disabled()		irqs_disabled_hw()
-
 #endif /* CONFIG_IPIPE */
 
 #endif

--Boundary-00=_6KinGJoccKvT1zP--

