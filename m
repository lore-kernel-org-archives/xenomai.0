From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-core] I-pipe patch for ARM S3C24xx
Date: Fri, 27 Oct 2006 16:20:54 +0200
References: <E1Gapzw-0005RB-Ob@domain.hid>
In-Reply-To: <E1Gapzw-0005RB-Ob@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GXhQFf1A2pinyXT"
Message-Id: <E1GdSZr-0001Pg-BV@mailer.emlix.com>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

--Boundary-00=_GXhQFf1A2pinyXT
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

here comes version 2 of the I-pipe patch for the S3C24xx ARM. The reported 
problem is solved, the timer works as expected as far as I can see. Linux is 
still there after insmod'ding the native skin. More test results will follow 
next week after I tortured the new patch with the whole testsuite 
arsenal. ;-)

The patch has got two suboptimal characteristics due to the generic ARM I-pipe 
implementation which I did not want to change during the first steps:

1. Regarding the demux of chained IRQs (See [1]). As the S3C24xx has more than 
one chained IRQ there are two consecutive queries for them in 
__ipipe_mach_irq_mux_p() and __ipipe_mach_demux_irq(). This could be 
optimized.

2. If the xenomai timer is stopped the first two jiffies for Linux are one 
timer tick too long. The solution could be a change of this line [2]. The 
patch for the S3C24xx needs a timer reload value of 
__ipipe_mach_ticks_per_jiffy-1 when Xenomai's timer is inactive. For example 
we could introduce a new inline function which is called in line 98 of hal.c. 
The new I-pipe patch would then call 
__ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy-1) and the other ARM 
patches __ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy).

Sebastian


[1] 
http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/arch/arm/patches/adeos-ipipe-2.6.15-arm-1.5-01.patch?v=SVN-trunk;a=arm#L3761
[2] 
http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/arch/arm/hal.c?v=SVN-trunk;a=arm#L98

--Boundary-00=_GXhQFf1A2pinyXT
Content-Type: text/x-diff; charset="utf-8";
	name="ipipe-2.6.15-s3c24xx-1.5-01.patch_v2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ipipe-2.6.15-s3c24xx-1.5-01.patch_v2"

diff -upr linux-2.6.15-ipipe.orig/arch/arm/mach-s3c2410/irq.c linux-2.6.15-ipipe.work/arch/arm/mach-s3c2410/irq.c
--- linux-2.6.15-ipipe.orig/arch/arm/mach-s3c2410/irq.c	2006-10-10 16:36:50.000000000 +0200
+++ linux-2.6.15-ipipe.work/arch/arm/mach-s3c2410/irq.c	2006-10-26 11:55:45.000000000 +0200
@@ -3,6 +3,8 @@
  * Copyright (c) 2003,2004 Simtec Electronics
  *	Ben Dooks <ben@domain.hid>
  *
+ * Copyright (C) 2006 Sebastian Smolorz <ssmolorz@domain.hid>, emlix GmbH
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -48,7 +50,10 @@
  *
  *   25-Jul-2005  Ben Dooks
  *		  Split the S3C2440 IRQ code to seperate file
-*/
+ *
+ *   11-Oct-2006  Sebastian Smolorz
+ *		  Added Adeos/Ipipe support
+ */
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -56,6 +61,7 @@
 #include <linux/ioport.h>
 #include <linux/ptrace.h>
 #include <linux/sysdev.h>
+#include <linux/ipipe.h>
 
 #include <asm/hardware.h>
 #include <asm/irq.h>
@@ -70,6 +76,14 @@
 #include "pm.h"
 #include "irq.h"
 
+#ifdef CONFIG_IPIPE
+#ifdef CONFIG_CPU_S3C2440
+extern void __ipipe_s3c_irq_demux_wdtac97(unsigned int irq,
+					  struct pt_regs *regs);
+extern void __ipipe_s3c_irq_demux_cam(unsigned int irq, struct pt_regs *regs);
+#endif /* CONFIG_CPU_S3C2440 */
+#endif /* CONFIG_IPIPE */
+
 /* wakeup irq control */
 
 #ifdef CONFIG_PM
@@ -573,6 +587,71 @@ s3c_irq_demux_uart2(unsigned int irq,
 }
 
 
+#ifdef CONFIG_IPIPE
+static void __ipipe_s3c_irq_demux_uart(unsigned int start,
+					unsigned int subsrc,
+					struct pt_regs *regs)
+{
+	unsigned int offset = start - IRQ_S3CUART_RX0;
+
+	subsrc >>= offset;
+	subsrc &= 7;
+
+	if (subsrc != 0) {
+		if (subsrc & 1)
+			__ipipe_handle_irq(start, regs);
+		if (subsrc & 2)
+			__ipipe_handle_irq(start+1, regs);
+		if (subsrc & 4)
+			__ipipe_handle_irq(start+2, regs);
+	}
+}
+
+static void __ipipe_s3c_irq_demux_adc(unsigned int subsrc,
+					struct pt_regs *regs)
+{
+	subsrc >>= 9;
+	subsrc &= 3;
+
+	if (subsrc != 0) {
+		if (subsrc & 1)
+			__ipipe_handle_irq(IRQ_TC, regs);
+		if (subsrc & 2)
+			__ipipe_handle_irq(IRQ_ADC, regs);
+	}
+}
+
+void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
+{
+	unsigned int subsrc, submsk;
+	struct irqdesc *desc_unused = irq_desc + irq;
+
+	/* read the current pending interrupts, and the mask
+	 * for what it is available */
+	subsrc = __raw_readl(S3C2410_SUBSRCPND);
+	submsk = __raw_readl(S3C2410_INTSUBMSK);
+
+	subsrc &= ~submsk;
+
+	if (irq == IRQ_UART0)
+		__ipipe_s3c_irq_demux_uart(IRQ_S3CUART_RX0, subsrc, regs);
+	else if (irq == IRQ_UART1)
+		__ipipe_s3c_irq_demux_uart(IRQ_S3CUART_RX1, subsrc, regs);
+	else if (irq == IRQ_UART2)
+		__ipipe_s3c_irq_demux_uart(IRQ_S3CUART_RX2, subsrc, regs);
+	else if (irq == IRQ_ADCPARENT)
+		__ipipe_s3c_irq_demux_adc(subsrc, regs);
+#ifdef CONFIG_CPU_S3C2440
+	else if (irq == IRQ_WDT)
+		__ipipe_s3c_irq_demux_wdtac97(subsrc, regs);
+	else if (irq == IRQ_CAM)
+		__ipipe_s3c_irq_demux_cam(subsrc, regs);
+#endif /* CONFIG_CPU_S3C2440 */
+
+	desc_unused->chip->unmask(irq);
+}
+#endif /* CONFIG_IPIPE */
+
 /* s3c24xx_init_irq
  *
  * Initialise S3C2410 IRQ system
diff -upr linux-2.6.15-ipipe.orig/arch/arm/mach-s3c2410/s3c2440-irq.c linux-2.6.15-ipipe.work/arch/arm/mach-s3c2410/s3c2440-irq.c
--- linux-2.6.15-ipipe.orig/arch/arm/mach-s3c2410/s3c2440-irq.c	2006-10-10 16:36:50.000000000 +0200
+++ linux-2.6.15-ipipe.work/arch/arm/mach-s3c2410/s3c2440-irq.c	2006-10-26 11:55:45.000000000 +0200
@@ -3,6 +3,8 @@
  * Copyright (c) 2003,2004 Simtec Electronics
  *	Ben Dooks <ben@domain.hid>
  *
+ * Copyright (C) 2006 Sebastian Smolorz <ssmolorz@domain.hid>, emlix GmbH
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -19,8 +21,10 @@
  *
  * Changelog:
  *	25-Jul-2005 BJD		Split from irq.c
+ *   	11-Oct-2006 Sebastian Smolorz
+ *		    Added Adeos/Ipipe support
  *
-*/
+ */
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -28,6 +32,7 @@
 #include <linux/ioport.h>
 #include <linux/ptrace.h>
 #include <linux/sysdev.h>
+#include <linux/ipipe.h>
 
 #include <asm/hardware.h>
 #include <asm/irq.h>
@@ -157,6 +162,34 @@ static struct irqchip s3c_irq_cam = {
 	.ack	    = s3c_irq_cam_ack,
 };
 
+#ifdef CONFIG_IPIPE
+void __ipipe_s3c_irq_demux_wdtac97(unsigned int subsrc, struct pt_regs *regs)
+{
+	subsrc >>= 13;
+	subsrc &= 3;
+
+	if (subsrc != 0) {
+		if (subsrc & 1)
+			__ipipe_handle_irq(IRQ_S3C2440_WDT, regs);
+		if (subsrc & 2)
+			__ipipe_handle_irq(IRQ_S3C2440_AC97, regs);
+	}
+}
+
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
 static int s3c2440_irq_add(struct sys_device *sysdev)
 {
 	unsigned int irqno;
diff -upr linux-2.6.15-ipipe.orig/arch/arm/mach-s3c2410/time.c linux-2.6.15-ipipe.work/arch/arm/mach-s3c2410/time.c
--- linux-2.6.15-ipipe.orig/arch/arm/mach-s3c2410/time.c	2006-10-10 16:36:50.000000000 +0200
+++ linux-2.6.15-ipipe.work/arch/arm/mach-s3c2410/time.c	2006-10-27 14:47:23.000000000 +0200
@@ -3,6 +3,8 @@
  * Copyright (C) 2003-2005 Simtec Electronics
  *	Ben Dooks, <ben@domain.hid>
  *
+ * Copyright (C) 2006 Sebastian Smolorz <ssmolorz@domain.hid>, emlix GmbH
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -24,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/err.h>
+#include <linux/module.h>
 
 #include <asm/system.h>
 #include <asm/leds.h>
@@ -40,7 +43,6 @@
 #include "clock.h"
 #include "cpu.h"
 
-static unsigned long timer_startval;
 static unsigned long timer_usec_ticks;
 
 #define TIMER_USEC_SHIFT 16
@@ -55,6 +57,24 @@ static unsigned long timer_usec_ticks;
  * Original patch by Dimitry Andric, updated by Ben Dooks
 */
 
+static unsigned long timer_reload = 0;
+static unsigned long tcon_stop = 0;
+static unsigned long timer_lxlost = 0;
+
+#ifdef CONFIG_IPIPE
+int __ipipe_mach_timerint = IRQ_TIMER4;
+EXPORT_SYMBOL(__ipipe_mach_timerint);
+
+static unsigned long long __ipipe_mach_tsc = 0;
+static int timer_wrapped = 0;
+static DEFINE_SPINLOCK(timer_lock);
+
+int __ipipe_mach_timerstolen = 0;
+EXPORT_SYMBOL(__ipipe_mach_timerstolen);
+
+unsigned int __ipipe_mach_ticks_per_jiffy;
+EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
+#endif /* CONFIG_IPIPE */
 
 /* timer_mask_usec_ticks
  *
@@ -85,12 +105,6 @@ static inline unsigned long timer_ticks_
 	return res >> TIMER_USEC_SHIFT;
 }
 
-/***
- * Returns microsecond  since last clock interrupt.  Note that interrupts
- * will have been disabled by do_gettimeoffset()
- * IRQs are disabled before entering here from do_gettimeofday()
- */
-
 #define SRCPND_TIMER4 (1<<(IRQ_TIMER4 - IRQ_EINT0))
 
 static unsigned long s3c2410_gettimeoffset (void)
@@ -102,7 +116,7 @@ static unsigned long s3c2410_gettimeoffs
 	/* work out how many ticks have gone since last timer interrupt */
 
         tval =  __raw_readl(S3C2410_TCNTO(4));
-	tdone = timer_startval - tval;
+	tdone = timer_reload - tval;
 
 	/* check to see if there is an interrupt pending */
 
@@ -114,15 +128,38 @@ static unsigned long s3c2410_gettimeoffs
 		 */
 
 		tval =  __raw_readl(S3C2410_TCNTO(4));
-		tdone = timer_startval - tval;
+		tdone = timer_reload - tval;
 
 		if (tval != 0)
-			tdone += timer_startval;
+			tdone += timer_reload + 1;
 	}
 
-	return timer_ticks_to_usec(tdone);
+	return timer_ticks_to_usec(timer_lxlost + tdone);
+}
+
+static inline void timer_restart(unsigned long reload)
+{
+	/* Auto reload */
+	unsigned long tcon = tcon_stop | S3C2410_TCON_T4RELOAD;
+
+	/* Stop timer */
+	__raw_writel(tcon_stop, S3C2410_TCON);
+
+	__raw_writel(reload, S3C2410_TCNTB(4));
+	__raw_writel(reload, S3C2410_TCMPB(4));
+	
+	/* Manual update */
+	__raw_writel(tcon | S3C2410_TCON_T4MANUALUPD, S3C2410_TCON);
+
+	/* Start timer */
+	__raw_writel(tcon | S3C2410_TCON_T4START, S3C2410_TCON);
 }
 
+static inline void set_dec(unsigned long reload)
+{
+	timer_restart(reload);
+	timer_reload = reload;
+}
 
 /*
  * IRQ handler for the timer
@@ -131,6 +168,24 @@ static irqreturn_t
 s3c2410_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	write_seqlock(&xtime_lock);
+
+#ifdef CONFIG_IPIPE
+	timer_lxlost = 0;
+
+	if (!__ipipe_mach_timerstolen) {
+		__ipipe_mach_tsc += __ipipe_mach_ticks_per_jiffy;
+		/* If this is the first interrupt after having stopped
+		   the Xenomai timer the auto reload value must be decreased
+		   by one tick. So max. 2 jiffies are one tick too long after
+		   the Xenomai timer has stopped. */
+		if (unlikely(timer_reload == __ipipe_mach_ticks_per_jiffy)) {
+			timer_reload--;
+			__raw_writel(timer_reload, S3C2410_TCNTB(4));
+			__raw_writel(timer_reload, S3C2410_TCMPB(4));
+		}
+	}
+#endif /* CONFIG_IPIPE */
+
 	timer_tick(regs);
 	write_sequnlock(&xtime_lock);
 	return IRQ_HANDLED;
@@ -209,6 +264,10 @@ static void s3c2410_timer_setup (void)
 		tcnt = (pclk / 6) / HZ;
 	}
 
+#ifdef CONFIG_IPIPE
+	__ipipe_mach_ticks_per_jiffy = tcnt;
+#endif /* CONFIG_IPIPE */
+
 	/* timers reload after counting zero, so reduce the count by 1 */
 
 	tcnt--;
@@ -225,23 +284,10 @@ static void s3c2410_timer_setup (void)
 	__raw_writel(tcfg1, S3C2410_TCFG1);
 	__raw_writel(tcfg0, S3C2410_TCFG0);
 
-	timer_startval = tcnt;
-	__raw_writel(tcnt, S3C2410_TCNTB(4));
-
-	/* ensure timer is stopped... */
-
 	tcon &= ~(7<<20);
-	tcon |= S3C2410_TCON_T4RELOAD;
-	tcon |= S3C2410_TCON_T4MANUALUPD;
+	tcon_stop = tcon;
 
-	__raw_writel(tcon, S3C2410_TCON);
-	__raw_writel(tcnt, S3C2410_TCNTB(4));
-	__raw_writel(tcnt, S3C2410_TCMPB(4));
-
-	/* start the timer running */
-	tcon |= S3C2410_TCON_T4START;
-	tcon &= ~S3C2410_TCON_T4MANUALUPD;
-	__raw_writel(tcon, S3C2410_TCON);
+	set_dec(tcnt);
 }
 
 static void __init s3c2410_timer_init (void)
@@ -255,3 +301,64 @@ struct sys_timer s3c24xx_timer = {
 	.offset		= s3c2410_gettimeoffset,
 	.resume		= s3c2410_timer_setup
 };
+
+#ifdef CONFIG_IPIPE
+static inline unsigned long s3c2410_getticksoffset(void)
+{
+	unsigned long tdone;
+	unsigned long tval;
+
+	/* work out how many ticks have gone since last timer interrupt */
+
+        tval =  __raw_readl(S3C2410_TCNTO(4));
+	tdone = timer_reload - tval;
+
+	if (timer_wrapped && tval != 0)
+		tdone += timer_reload + 1;
+
+	return tdone;
+}
+
+void __ipipe_mach_acktimer(void)
+{
+	unsigned long bitval = 1UL << (IRQ_TIMER4 - IRQ_EINT0);
+
+	if (__ipipe_mach_timerstolen)
+		timer_wrapped = 1;
+
+	__raw_writel(bitval, S3C2410_SRCPND);
+	__raw_writel(bitval, S3C2410_INTPND);
+}
+
+unsigned long long __ipipe_mach_get_tsc(void)
+{
+	unsigned long long result;
+	unsigned long flags;
+
+	spin_lock_irqsave_hw(&timer_lock, flags);
+	result = __ipipe_mach_tsc + s3c2410_getticksoffset();
+	spin_unlock_irqrestore_hw(&timer_lock, flags);
+	return result;
+}
+EXPORT_SYMBOL(__ipipe_mach_get_tsc);
+
+void __ipipe_mach_set_dec(unsigned long reload)
+{
+	unsigned long ticks;
+	unsigned long flags;
+
+	spin_lock_irqsave_hw(&timer_lock, flags);
+	ticks = s3c2410_getticksoffset();
+	__ipipe_mach_tsc += ticks;
+	timer_lxlost += ticks;
+	set_dec(reload);
+	timer_wrapped = 0;
+	spin_unlock_irqrestore_hw(&timer_lock, flags);
+}
+EXPORT_SYMBOL(__ipipe_mach_set_dec);
+
+unsigned long __ipipe_mach_get_dec(void)
+{
+	return __raw_readl(S3C2410_TCNTO(4));
+}
+#endif /* CONFIG_IPIPE */
diff -upr linux-2.6.15-ipipe.orig/include/asm-arm/arch-s3c2410/irqs.h linux-2.6.15-ipipe.work/include/asm-arm/arch-s3c2410/irqs.h
--- linux-2.6.15-ipipe.orig/include/asm-arm/arch-s3c2410/irqs.h	2006-10-10 16:37:15.000000000 +0200
+++ linux-2.6.15-ipipe.work/include/asm-arm/arch-s3c2410/irqs.h	2006-10-26 11:55:45.000000000 +0200
@@ -3,6 +3,8 @@
  * Copyright (c) 2003-2005 Simtec Electronics
  *   Ben Dooks <ben@domain.hid>
  *
+ * Copyright (C) 2006 Sebastian Smolorz <ssmolorz@domain.hid>, emlix GmbH
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -13,6 +15,7 @@
  *  12-Mar-2004 BJD  Fixed bug in header protection
  *  10-Feb-2005 BJD  Added camera IRQ from guillaume.gourat@domain.hid
  *  28-Feb-2005 BJD  Updated s3c2440 IRQs
+ *  11-Oct-2006      Added Adeos/Ipipe support
  */
 
 
@@ -122,5 +125,20 @@
 
 #define NR_IRQS (IRQ_S3C2440_AC97+1)
 
+#ifdef CONFIG_IPIPE
+#ifdef CONFIG_CPU_S3C2440
+#define __ipipe_mach_irq_mux_p(irq)	((irq) == IRQ_UART0 	||	\
+					 (irq) == IRQ_UART1 	||	\
+					 (irq) == IRQ_UART2 	||	\
+					 (irq) == IRQ_ADCPARENT	||	\
+					 (irq) == IRQ_WDT	||	\
+					 (irq) == IRQ_CAM)
+#else /* !CONFIG_CPU_S3C2440 */
+#define __ipipe_mach_irq_mux_p(irq)	((irq) == IRQ_UART0 	||	\
+					 (irq) == IRQ_UART1 	||	\
+					 (irq) == IRQ_UART2 	||	\
+					 (irq) == IRQ_ADCPARENT)
+#endif /* CONFIG_CPU_S3C2440 */
+#endif /* CONFIG_IPIPE */
 
 #endif /* __ASM_ARCH_IRQ_H */

--Boundary-00=_GXhQFf1A2pinyXT--

