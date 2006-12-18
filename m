From: Sebastian Smolorz <ssm@domain.hid>
Date: Mon, 18 Dec 2006 17:04:59 +0100
References: <E1GutB2-0005VT-Vb@domain.hid>
	<E1GwG68-0005um-1j@domain.hid> <458681C3.9040507@domain.hid>
In-Reply-To: <458681C3.9040507@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rwrhFZou5pMr2Gm"
Message-Id: <E1GwKz1-0008O4-Mn@domain.hid>
Subject: [Xenomai-core] Re: [Adeos-main] Latency trace on ARM
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

--Boundary-00=_rwrhFZou5pMr2Gm
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jan Kiszka wrote:
>
> If you have anything more pending, please post soon, Gilles is
> collecting the ARM stuff for Xenomai 2.3.

Attached are all patches that I posted in the last two months but didn't get 
into Ipipe CVS or Xenomai svn. The first file pools all patches for Ipipe, 
here comes an overview what it comprises:

- I-pipe for Samsung S3C24xx
- I-pipe tracer for ARM
- Introduce __ipipe_mach_release_timer()
- Fix ipipe_tsc2ns()
- Don't activate the tracer too early during the boot process

Please consider these patches for Xenomai 2.3. Thanks!

--
Sebastian

--Boundary-00=_rwrhFZou5pMr2Gm
Content-Type: text/x-diff; charset="iso-8859-15"; name="ipipe-2.6.15-arm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ipipe-2.6.15-arm.patch"

diff -upNr linux-2.6.15-ipipe.orig/arch/arm/boot/compressed/head.S linux-2.6.15-ipipe/arch/arm/boot/compressed/head.S
--- linux-2.6.15-ipipe.orig/arch/arm/boot/compressed/head.S	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-ipipe/arch/arm/boot/compressed/head.S	2006-12-04 17:45:52.000000000 +0100
@@ -710,6 +710,16 @@ memdump:	mov	r12, r0
 		mov	pc, r10
 #endif
 
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+                .text
+                .align 0
+                .type mcount %function
+                .global mcount
+mcount:
+		mov pc, lr	@ just return
+#endif
+
+
 reloc_end:
 
 		.align
diff -upNr linux-2.6.15-ipipe.orig/arch/arm/kernel/entry-common.S linux-2.6.15-ipipe/arch/arm/kernel/entry-common.S
--- linux-2.6.15-ipipe.orig/arch/arm/kernel/entry-common.S	2006-05-04 14:43:39.000000000 +0200
+++ linux-2.6.15-ipipe/arch/arm/kernel/entry-common.S	2006-12-04 09:48:15.000000000 +0100
@@ -294,3 +294,28 @@ sys_mmap2:
 		str	r5, [sp, #4]
 		b	do_mmap2
 #endif
+
+#ifdef CONFIG_FRAME_POINTER
+
+	.text
+	.align 0
+	.type arm_return_addr %function
+	.global arm_return_addr
+
+arm_return_addr:
+	mov	ip, r0
+	mov	r0, fp
+3:
+	cmp	r0, #0
+	beq	1f		@ frame list hit end, bail
+	cmp	ip, #0
+	beq	2f		@ reached desired frame
+	ldr	r0, [r0, #-12]  @ else continue, get next fp
+	sub	ip, ip, #1
+	b	3b
+2:
+	ldr	r0, [r0, #-4]   @ get target return address
+1:
+	mov	pc, lr
+
+#endif
diff -upNr linux-2.6.15-ipipe.orig/arch/arm/kernel/ipipe-mcount.S linux-2.6.15-ipipe/arch/arm/kernel/ipipe-mcount.S
--- linux-2.6.15-ipipe.orig/arch/arm/kernel/ipipe-mcount.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-ipipe/arch/arm/kernel/ipipe-mcount.S	2006-12-04 09:46:30.000000000 +0100
@@ -0,0 +1,40 @@
+/*
+ *  linux/arch/arm/kernel/ipipe-mcount.S
+ *
+ *  Copyright (C) 2006 Sebastian Smolorz <ssmolorz@domain.hid>, emlix GmbH
+ */
+
+#include <linux/config.h>
+
+#ifdef CONFIG_FRAME_POINTER
+
+	.text
+	.align 0
+	.type mcount %function
+	.global mcount
+
+mcount:
+
+	ldr	ip, =ipipe_trace_enable	@ leave early, if disabled
+	ldr	ip, [ip]
+	cmp	ip, #0
+	moveq	pc,lr
+
+	mov	ip,  sp
+	stmdb   sp!, {r0 - r3, fp, ip, lr, pc}	@ create stack frame
+
+	mov	r3, #0			@ no additional value (v)
+	ldr	r2, [fp, #-4]		@ get lr (the return address
+					@ of the caller of the
+					@ instrumented function)
+	mov	r1, lr			@ get lr - (the return address
+					@ of the instrumented function)
+	mov	r0, #0			@ IPIPE_TRACE_FN
+
+	sub	fp, ip, #4		@ point fp at this frame
+
+	bl	__ipipe_trace
+
+	ldmdb   fp, {r0 - r3, fp, sp, pc}	@ pop entry frame and return
+
+#endif
diff -upNr linux-2.6.15-ipipe.orig/arch/arm/kernel/ipipe-root.c linux-2.6.15-ipipe/arch/arm/kernel/ipipe-root.c
--- linux-2.6.15-ipipe.orig/arch/arm/kernel/ipipe-root.c	2006-10-09 22:41:23.000000000 +0200
+++ linux-2.6.15-ipipe/arch/arm/kernel/ipipe-root.c	2006-12-13 17:20:00.000000000 +0100
@@ -306,11 +306,19 @@ asmlinkage int __ipipe_grab_irq(int irq,
 		}
 	}
 
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+	ipipe_trace_begin(regs->ARM_ORIG_r0);
+#endif
+
 	if (__ipipe_mach_irq_mux_p(irq))
 		__ipipe_mach_demux_irq(irq, regs);
 	else
 		__ipipe_handle_irq(irq, regs);
 
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+	ipipe_trace_end(regs->ARM_ORIG_r0);
+#endif
+
 	ipipe_load_cpuid();
 
 	return (per_cpu(ipipe_percpu_domain, cpuid) == ipipe_root_domain &&
@@ -376,3 +384,8 @@ EXPORT_SYMBOL_GPL(show_stack);
 #ifndef MULTI_CPU
 EXPORT_SYMBOL_GPL(cpu_do_switch_mm);
 #endif
+
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+void notrace mcount(void);
+EXPORT_SYMBOL(mcount);
+#endif /* CONFIG_IPIPE_TRACE_MCOUNT */
diff -upNr linux-2.6.15-ipipe.orig/arch/arm/kernel/Makefile linux-2.6.15-ipipe/arch/arm/kernel/Makefile
--- linux-2.6.15-ipipe.orig/arch/arm/kernel/Makefile	2006-02-20 14:54:22.000000000 +0100
+++ linux-2.6.15-ipipe/arch/arm/kernel/Makefile	2006-12-01 13:42:49.000000000 +0100
@@ -20,6 +20,7 @@ obj-$(CONFIG_ISA_DMA)		+= dma-isa.o
 obj-$(CONFIG_PCI)		+= bios32.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_IPIPE)		+= ipipe-core.o ipipe-root.o
+obj-$(CONFIG_IPIPE_TRACE_MCOUNT)	+= ipipe-mcount.o
 
 obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
diff -upNr linux-2.6.15-ipipe.orig/arch/arm/kernel/process.c linux-2.6.15-ipipe/arch/arm/kernel/process.c
--- linux-2.6.15-ipipe.orig/arch/arm/kernel/process.c	2006-02-20 14:54:22.000000000 +0100
+++ linux-2.6.15-ipipe/arch/arm/kernel/process.c	2006-12-14 16:35:09.000000000 +0100
@@ -89,12 +89,18 @@ void default_idle(void)
 	if (hlt_counter)
 		cpu_relax();
 	else {
-		local_irq_disable_hw();
+		local_irq_disable();
 		if (!need_resched()) {
 			timer_dyn_reprogram();
+#ifdef CONFIG_IPIPE
+			__ipipe_unstall_root();
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+			ipipe_trace_end(0x8000000E);
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+#endif /* CONFIG_IPIPE */
 			arch_idle();
 		}
-		local_irq_enable_hw();
+		local_irq_enable();
 	}
 }
 
diff -upNr linux-2.6.15-ipipe.orig/arch/arm/mach-integrator/core.c linux-2.6.15-ipipe/arch/arm/mach-integrator/core.c
--- linux-2.6.15-ipipe.orig/arch/arm/mach-integrator/core.c	2006-01-30 23:46:08.000000000 +0100
+++ linux-2.6.15-ipipe/arch/arm/mach-integrator/core.c	2006-12-18 15:42:03.000000000 +0100
@@ -303,7 +303,7 @@ void __ipipe_mach_acktimer(void)
 	writel(1, TIMER1_VA_BASE + TIMER_INTCLR);
 }
 
-unsigned long long __ipipe_mach_get_tsc(void)
+notrace unsigned long long __ipipe_mach_get_tsc(void)
 {
 	unsigned long long result;
 	unsigned long flags;
@@ -330,6 +330,12 @@ void __ipipe_mach_set_dec(unsigned long 
 }
 EXPORT_SYMBOL(__ipipe_mach_set_dec);
 
+void __ipipe_mach_release_timer(void)
+{
+       __ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
+}
+EXPORT_SYMBOL(__ipipe_mach_release_timer);
+
 unsigned long __ipipe_mach_get_dec(void)
 {
 	return readl(TIMER1_VA_BASE + TIMER_VALUE);
diff -upNr linux-2.6.15-ipipe.orig/arch/arm/mach-pxa/time.c linux-2.6.15-ipipe/arch/arm/mach-pxa/time.c
--- linux-2.6.15-ipipe.orig/arch/arm/mach-pxa/time.c	2006-09-10 17:13:35.000000000 +0200
+++ linux-2.6.15-ipipe/arch/arm/mach-pxa/time.c	2006-12-18 15:44:16.000000000 +0100
@@ -270,7 +270,7 @@ void __ipipe_mach_acktimer(void)
 	OSSR = OSSR_M0;  /* Clear match on timer 0 */
 }
 
-unsigned long long __ipipe_mach_get_tsc(void)
+notrace unsigned long long __ipipe_mach_get_tsc(void)
 {
 	if (likely(pxa_timer_initialized)) {
 		static union {
@@ -324,6 +324,12 @@ void __ipipe_mach_set_dec(unsigned long 
 }
 EXPORT_SYMBOL(__ipipe_mach_set_dec);
 
+void __ipipe_mach_release_timer(void)
+{
+       __ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
+}
+EXPORT_SYMBOL(__ipipe_mach_release_timer);
+
 unsigned long __ipipe_mach_get_dec(void)
 {
 	return OSMR0 - OSCR;
diff -upNr linux-2.6.15-ipipe.orig/arch/arm/mach-s3c2410/irq.c linux-2.6.15-ipipe/arch/arm/mach-s3c2410/irq.c
--- linux-2.6.15-ipipe.orig/arch/arm/mach-s3c2410/irq.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-ipipe/arch/arm/mach-s3c2410/irq.c	2006-11-30 12:23:27.000000000 +0100
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
+ *   30-Oct-2006  Sebastian Smolorz
+ *		  Added Adeos/I-pipe support
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
@@ -573,6 +587,79 @@ s3c_irq_demux_uart2(unsigned int irq,
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
+	switch (irq) {
+	case IRQ_UART0:
+		__ipipe_s3c_irq_demux_uart(IRQ_S3CUART_RX0, subsrc, regs);
+		break;
+	case IRQ_UART1:
+		__ipipe_s3c_irq_demux_uart(IRQ_S3CUART_RX1, subsrc, regs);
+		break;
+	case IRQ_UART2:
+		__ipipe_s3c_irq_demux_uart(IRQ_S3CUART_RX2, subsrc, regs);
+		break;
+	case IRQ_ADCPARENT:
+		__ipipe_s3c_irq_demux_adc(subsrc, regs);
+		break;
+#ifdef CONFIG_CPU_S3C2440
+	case IRQ_WDT:
+		__ipipe_s3c_irq_demux_wdtac97(subsrc, regs);
+		break;
+	case IRQ_CAM:
+		__ipipe_s3c_irq_demux_cam(subsrc, regs);
+		break;
+#endif /* CONFIG_CPU_S3C2440 */
+	}
+
+	desc_unused->chip->unmask(irq);
+}
+#endif /* CONFIG_IPIPE */
+
 /* s3c24xx_init_irq
  *
  * Initialise S3C2410 IRQ system
diff -upNr linux-2.6.15-ipipe.orig/arch/arm/mach-s3c2410/s3c2440-irq.c linux-2.6.15-ipipe/arch/arm/mach-s3c2410/s3c2440-irq.c
--- linux-2.6.15-ipipe.orig/arch/arm/mach-s3c2410/s3c2440-irq.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-ipipe/arch/arm/mach-s3c2410/s3c2440-irq.c	2006-11-30 12:24:21.000000000 +0100
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
diff -upNr linux-2.6.15-ipipe.orig/arch/arm/mach-s3c2410/time.c linux-2.6.15-ipipe/arch/arm/mach-s3c2410/time.c
--- linux-2.6.15-ipipe.orig/arch/arm/mach-s3c2410/time.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-ipipe/arch/arm/mach-s3c2410/time.c	2006-12-18 15:25:08.000000000 +0100
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
 
+static unsigned long last_free_running_tcnt = 0;
+static unsigned long free_running_tcon = 0;
+static unsigned long timer_lxlost = 0;
+
+#ifdef CONFIG_IPIPE
+unsigned int __ipipe_mach_ticks_per_jiffy;
+EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
+
+int __ipipe_mach_timerint = IRQ_TIMER4;
+EXPORT_SYMBOL(__ipipe_mach_timerint);
+
+static unsigned long long __ipipe_mach_tsc = 0;
+static unsigned long timer_ackval = 1UL << (IRQ_TIMER4 - IRQ_EINT0);
+static DEFINE_SPINLOCK(timer_lock);
+
+int __ipipe_mach_timerstolen = 0;
+EXPORT_SYMBOL(__ipipe_mach_timerstolen);
+#endif /* CONFIG_IPIPE */
 
 /* timer_mask_usec_ticks
  *
@@ -85,44 +105,46 @@ static inline unsigned long timer_ticks_
 	return res >> TIMER_USEC_SHIFT;
 }
 
-/***
- * Returns microsecond  since last clock interrupt.  Note that interrupts
- * will have been disabled by do_gettimeoffset()
- * IRQs are disabled before entering here from do_gettimeofday()
- */
-
-#define SRCPND_TIMER4 (1<<(IRQ_TIMER4 - IRQ_EINT0))
 
-static unsigned long s3c2410_gettimeoffset (void)
+static inline unsigned long timer_freerunning_getvalue(void)
 {
-	unsigned long tdone;
-	unsigned long irqpend;
-	unsigned long tval;
-
-	/* work out how many ticks have gone since last timer interrupt */
+	return __raw_readl(S3C2410_TCNTO(3));
+}
 
-        tval =  __raw_readl(S3C2410_TCNTO(4));
-	tdone = timer_startval - tval;
+static inline unsigned long timer_freerunning_getticksoffset(unsigned long tval)
+{
+	long tdone;
 
-	/* check to see if there is an interrupt pending */
+	tdone =  last_free_running_tcnt - tval;
+	if (tdone < 0)
+		tdone += 0x10000;
 
-	irqpend = __raw_readl(S3C2410_SRCPND);
-	if (irqpend & SRCPND_TIMER4) {
-		/* re-read the timer, and try and fix up for the missed
-		 * interrupt. Note, the interrupt may go off before the
-		 * timer has re-loaded from wrapping.
-		 */
+	return tdone;
+}
 
-		tval =  __raw_readl(S3C2410_TCNTO(4));
-		tdone = timer_startval - tval;
+static inline unsigned long getticksoffset(void)
+{
+	return timer_freerunning_getticksoffset(timer_freerunning_getvalue());
+}
 
-		if (tval != 0)
-			tdone += timer_startval;
-	}
+#ifdef CONFIG_IPIPE
+static inline unsigned long getticksoffset_tscupdate(void)
+{
+	unsigned long tval;
+	unsigned long ticks;
 
-	return timer_ticks_to_usec(tdone);
+	tval = timer_freerunning_getvalue();
+	ticks = timer_freerunning_getticksoffset(tval);
+	last_free_running_tcnt = tval;
+	__ipipe_mach_tsc += ticks;
+	return ticks;
 }
+#endif /* CONFIG_IPIPE */
 
+static unsigned long s3c2410_gettimeoffset (void)
+{
+	return timer_ticks_to_usec(timer_lxlost + getticksoffset());
+}
 
 /*
  * IRQ handler for the timer
@@ -131,6 +153,14 @@ static irqreturn_t
 s3c2410_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	write_seqlock(&xtime_lock);
+
+#ifdef CONFIG_IPIPE
+	timer_lxlost = 0;
+
+	if (!__ipipe_mach_timerstolen)
+		getticksoffset_tscupdate();
+#endif /* CONFIG_IPIPE */
+
 	timer_tick(regs);
 	write_sequnlock(&xtime_lock);
 	return IRQ_HANDLED;
@@ -143,10 +173,10 @@ static struct irqaction s3c2410_timer_ir
 };
 
 /*
- * Set up timer interrupt, and return the current time in seconds.
+ * Set up timer interrupt.
  *
- * Currently we only use timer4, as it is the only timer which has no
- * other function that can be exploited externally
+ * Currently we use timer4 as event timer and timer3 as tick counter which
+ * permanently counts ticks without interrupt generation.
  */
 static void s3c2410_timer_setup (void)
 {
@@ -154,6 +184,7 @@ static void s3c2410_timer_setup (void)
 	unsigned long tcnt;
 	unsigned long tcfg1;
 	unsigned long tcfg0;
+	unsigned long intmask;
 
 	tcnt = 0xffff;  /* default value for tcnt */
 
@@ -170,8 +201,8 @@ static void s3c2410_timer_setup (void)
 		timer_usec_ticks = timer_mask_usec_ticks(1, 12000000);
 		tcnt = 12000000 / HZ;
 
-		tcfg1 &= ~S3C2410_TCFG1_MUX4_MASK;
-		tcfg1 |= S3C2410_TCFG1_MUX4_TCLK1;
+		tcfg1 &= ~(S3C2410_TCFG1_MUX4_MASK | S3C2410_TCFG1_MUX3_MASK);
+		tcfg1 |= (S3C2410_TCFG1_MUX4_TCLK1 | S3C2410_TCFG1_MUX3_TCLK1);
 	} else {
 		unsigned long pclk;
 		struct clk *clk;
@@ -200,8 +231,8 @@ static void s3c2410_timer_setup (void)
 
 		timer_usec_ticks = timer_mask_usec_ticks(6, pclk);
 
-		tcfg1 &= ~S3C2410_TCFG1_MUX4_MASK;
-		tcfg1 |= S3C2410_TCFG1_MUX4_DIV2;
+		tcfg1 &= ~(S3C2410_TCFG1_MUX4_MASK | S3C2410_TCFG1_MUX3_MASK);
+		tcfg1 |= (S3C2410_TCFG1_MUX4_DIV2 | S3C2410_TCFG1_MUX3_DIV2);
 
 		tcfg0 &= ~S3C2410_TCFG_PRESCALER1_MASK;
 		tcfg0 |= ((6 - 1) / 2) << S3C2410_TCFG_PRESCALER1_SHIFT;
@@ -209,6 +240,10 @@ static void s3c2410_timer_setup (void)
 		tcnt = (pclk / 6) / HZ;
 	}
 
+#ifdef CONFIG_IPIPE
+	__ipipe_mach_ticks_per_jiffy = tcnt;
+#endif /* CONFIG_IPIPE */
+
 	/* timers reload after counting zero, so reduce the count by 1 */
 
 	tcnt--;
@@ -225,23 +260,37 @@ static void s3c2410_timer_setup (void)
 	__raw_writel(tcfg1, S3C2410_TCFG1);
 	__raw_writel(tcfg0, S3C2410_TCFG0);
 
-	timer_startval = tcnt;
-	__raw_writel(tcnt, S3C2410_TCNTB(4));
-
-	/* ensure timer is stopped... */
+	/* ensure timers are stopped... */
+	tcon &= ~(0x3f<<17);
+	__raw_writel(tcon, S3C2410_TCON);
 
-	tcon &= ~(7<<20);
-	tcon |= S3C2410_TCON_T4RELOAD;
-	tcon |= S3C2410_TCON_T4MANUALUPD;
+	/* Mask timer3 interrupt. */
+	intmask = __raw_readl(S3C2410_INTMSK);
+	intmask |= 1UL << (IRQ_TIMER3 - IRQ_EINT0);
+	__raw_writel(intmask, S3C2410_INTMSK);
 
-	__raw_writel(tcon, S3C2410_TCON);
+	/* Set timer values */
 	__raw_writel(tcnt, S3C2410_TCNTB(4));
 	__raw_writel(tcnt, S3C2410_TCMPB(4));
+	__raw_writel(0xffff, S3C2410_TCNTB(3));
+	__raw_writel(0xffff, S3C2410_TCMPB(3));
+
+	/* Set base tcon value for later programming of timer 4 by Xenomai. */
+	free_running_tcon = tcon |  S3C2410_TCON_T3RELOAD | S3C2410_TCON_T3START;
+
+	/* Set auto reloads for both timers. */
+	tcon |= S3C2410_TCON_T3RELOAD | S3C2410_TCON_T4RELOAD;
+
+	/* Manual update */
+	__raw_writel(tcon | S3C2410_TCON_T3MANUALUPD
+			  | S3C2410_TCON_T4MANUALUPD, S3C2410_TCON);
 
-	/* start the timer running */
-	tcon |= S3C2410_TCON_T4START;
-	tcon &= ~S3C2410_TCON_T4MANUALUPD;
+	tcon |= S3C2410_TCON_T3START | S3C2410_TCON_T4START;
+	/* Start timers.*/
 	__raw_writel(tcon, S3C2410_TCON);
+
+	/* Save start value of timer 3 as begining of first period. */
+	last_free_running_tcnt = 0xffff;
 }
 
 static void __init s3c2410_timer_init (void)
@@ -255,3 +304,56 @@ struct sys_timer s3c24xx_timer = {
 	.offset		= s3c2410_gettimeoffset,
 	.resume		= s3c2410_timer_setup
 };
+
+#ifdef CONFIG_IPIPE
+void __ipipe_mach_acktimer(void)
+{
+	__raw_writel(timer_ackval, S3C2410_SRCPND);
+	__raw_writel(timer_ackval, S3C2410_INTPND);
+}
+
+notrace unsigned long long __ipipe_mach_get_tsc(void)
+{
+	unsigned long long result;
+	unsigned long flags;
+
+	spin_lock_irqsave_hw(&timer_lock, flags);
+	result = __ipipe_mach_tsc + getticksoffset();
+	spin_unlock_irqrestore_hw(&timer_lock, flags);
+	return result;
+}
+EXPORT_SYMBOL(__ipipe_mach_get_tsc);
+
+static inline void set_dec(unsigned long reload)
+{
+	__raw_writel(reload, S3C2410_TCNTB(4));
+	/* Manual update */
+	__raw_writel(free_running_tcon | S3C2410_TCON_T4MANUALUPD, S3C2410_TCON);
+	/* Start timer */
+	__raw_writel(free_running_tcon | S3C2410_TCON_T4START, S3C2410_TCON);
+}
+
+void __ipipe_mach_set_dec(unsigned long reload)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave_hw(&timer_lock, flags);
+	timer_lxlost += getticksoffset_tscupdate();
+	set_dec(reload);
+	spin_unlock_irqrestore_hw(&timer_lock, flags);
+}
+EXPORT_SYMBOL(__ipipe_mach_set_dec);
+
+void __ipipe_mach_release_timer(void)
+{
+	free_running_tcon |= S3C2410_TCON_T4RELOAD;
+	__ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy - 1);
+	free_running_tcon &= ~S3C2410_TCON_T4RELOAD;
+}
+EXPORT_SYMBOL(__ipipe_mach_release_timer);
+
+unsigned long __ipipe_mach_get_dec(void)
+{
+	return __raw_readl(S3C2410_TCNTO(4));
+}
+#endif /* CONFIG_IPIPE */
diff -upNr linux-2.6.15-ipipe.orig/arch/arm/mach-sa1100/time.c linux-2.6.15-ipipe/arch/arm/mach-sa1100/time.c
--- linux-2.6.15-ipipe.orig/arch/arm/mach-sa1100/time.c	2006-09-10 17:13:35.000000000 +0200
+++ linux-2.6.15-ipipe/arch/arm/mach-sa1100/time.c	2006-12-18 15:44:59.000000000 +0100
@@ -263,7 +263,7 @@ void __ipipe_mach_acktimer(void)
 	OSSR = OSSR_M0;  /* Clear match on timer 0 */
 }
 
-unsigned long long __ipipe_mach_get_tsc(void)
+notrace unsigned long long __ipipe_mach_get_tsc(void)
 {
 	if (likely(sa1100_timer_initialized)) {
 		static union {
@@ -314,6 +314,12 @@ void __ipipe_mach_set_dec(unsigned long 
 }
 EXPORT_SYMBOL(__ipipe_mach_set_dec);
 
+void __ipipe_mach_release_timer(void)
+{
+       __ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
+}
+EXPORT_SYMBOL(__ipipe_mach_release_timer);
+
 unsigned long __ipipe_mach_get_dec(void)
 {
 	return OSMR0 - OSCR;
diff -upNr linux-2.6.15-ipipe.orig/include/asm-arm/arch-s3c2410/irqs.h linux-2.6.15-ipipe/include/asm-arm/arch-s3c2410/irqs.h
--- linux-2.6.15-ipipe.orig/include/asm-arm/arch-s3c2410/irqs.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-ipipe/include/asm-arm/arch-s3c2410/irqs.h	2006-11-30 12:20:22.000000000 +0100
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
+ *  30-Oct-2006      Added Adeos/I-pipe support
  */
 
 
@@ -123,4 +126,26 @@
 #define NR_IRQS (IRQ_S3C2440_AC97+1)
 
 
+#ifdef CONFIG_IPIPE
+#define __ipipe_irqbit(irq)	(1 << ((irq) - S3C2410_CPUIRQ_OFFSET))
+
+#ifdef CONFIG_CPU_S3C2440
+#define __ipipe_muxed_irqmask	(__ipipe_irqbit(IRQ_UART0)	|	\
+				 __ipipe_irqbit(IRQ_UART1)	|	\
+				 __ipipe_irqbit(IRQ_UART2)	|	\
+				 __ipipe_irqbit(IRQ_ADCPARENT)	|	\
+				 __ipipe_irqbit(IRQ_WDT)	|	\
+				 __ipipe_irqbit(IRQ_CAM))
+#else /* !CONFIG_CPU_S3C2440 */
+#define __ipipe_muxed_irqmask	(__ipipe_irqbit(IRQ_UART0)	|	\
+				 __ipipe_irqbit(IRQ_UART1)	|	\
+				 __ipipe_irqbit(IRQ_UART2)	|	\
+				 __ipipe_irqbit(IRQ_ADCPARENT))
+#endif /* CONFIG_CPU_S3C2440 */
+
+#define __ipipe_mach_irq_mux_p(irq)	((irq) <= IRQ_ADCPARENT  &&	\
+					 (__ipipe_irqbit(irq) &		\
+					  __ipipe_muxed_irqmask))
+#endif /* CONFIG_IPIPE */
+
 #endif /* __ASM_ARCH_IRQ_H */
diff -upNr linux-2.6.15-ipipe.orig/include/asm-arm/ipipe.h linux-2.6.15-ipipe/include/asm-arm/ipipe.h
--- linux-2.6.15-ipipe.orig/include/asm-arm/ipipe.h	2006-11-12 20:33:33.000000000 +0100
+++ linux-2.6.15-ipipe/include/asm-arm/ipipe.h	2006-12-18 15:40:04.000000000 +0100
@@ -95,6 +95,13 @@ do {								\
 #define IPIPE_LAST_EVENT	IPIPE_EVENT_CLEANUP
 #define IPIPE_NR_EVENTS		(IPIPE_LAST_EVENT + 1)
 
+extern unsigned long arm_return_addr(int level);
+
+#define BROKEN_BUILTIN_RETURN_ADDRESS
+#define __BUILTIN_RETURN_ADDRESS0 arm_return_addr(0)
+#define __BUILTIN_RETURN_ADDRESS1 arm_return_addr(1)
+
+
 struct ipipe_domain;
 
 struct ipipe_sysinfo {
@@ -117,6 +124,7 @@ extern unsigned int __ipipe_mach_ticks_p
 extern void __ipipe_mach_acktimer(void);
 extern unsigned long long __ipipe_mach_get_tsc(void);
 extern void __ipipe_mach_set_dec(unsigned long);
+extern void __ipipe_mach_release_timer(void);
 extern unsigned long __ipipe_mach_get_dec(void);
 extern void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs);
 
@@ -124,7 +132,8 @@ extern void __ipipe_mach_demux_irq(unsig
 #define __ipipe_read_timebase()		__ipipe_mach_get_tsc()
 
 #define ipipe_cpu_freq()	(HZ * __ipipe_mach_ticks_per_jiffy)
-#define ipipe_tsc2ns(t)		(((t) * 1000) / (ipipe_cpu_freq() / 1000000))
+#define ipipe_tsc2ns(t) 	(((unsigned long)(t) * 1000) / (ipipe_cpu_freq() / 1000000))
+#define ipipe_tsc2us(t) 	(((unsigned long)(t)) / (ipipe_cpu_freq() / 1000000))
 
 /* Private interface -- Internal use only */
 
diff -upNr linux-2.6.15-ipipe.orig/include/asm-arm/system.h linux-2.6.15-ipipe/include/asm-arm/system.h
--- linux-2.6.15-ipipe.orig/include/asm-arm/system.h	2006-10-21 00:08:28.000000000 +0200
+++ linux-2.6.15-ipipe/include/asm-arm/system.h	2006-12-04 17:27:24.000000000 +0100
@@ -177,7 +177,7 @@ do {									\
  */
 #if __LINUX_ARM_ARCH__ >= 6
 
-#define local_irq_save_hw(x)					\
+#define local_irq_save_hw_notrace(x)				\
 	({							\
 	__asm__ __volatile__(					\
 	"mrs	%0, cpsr		@ local_irq_save_hw\n"	\
@@ -195,7 +195,7 @@ do {									\
 /*
  * Save the current interrupt enable state & disable IRQs
  */
-#define local_irq_save_hw(x)					\
+#define local_irq_save_hw_notrace(x)				\
 	({							\
 		unsigned long temp;				\
 		(void) (&temp == &x);				\
@@ -211,7 +211,7 @@ do {									\
 /*
  * Enable IRQs
  */
-#define local_irq_enable_hw()					\
+#define local_irq_enable_hw_notrace()				\
 	({							\
 		unsigned long temp;				\
 	__asm__ __volatile__(					\
@@ -226,7 +226,7 @@ do {									\
 /*
  * Disable IRQs
  */
-#define local_irq_disable_hw()					\
+#define local_irq_disable_hw_notrace()				\
 	({							\
 		unsigned long temp;				\
 	__asm__ __volatile__(					\
@@ -241,7 +241,7 @@ do {									\
 /*
  * Enable FIQs
  */
-#define local_fiq_enable_hw()					\
+#define local_fiq_enable_hw_notrace()				\
 	({							\
 		unsigned long temp;				\
 	__asm__ __volatile__(					\
@@ -256,7 +256,7 @@ do {									\
 /*
  * Disable FIQs
  */
-#define local_fiq_disable_hw()					\
+#define local_fiq_disable_hw_notrace()				\
 	({							\
 		unsigned long temp;				\
 	__asm__ __volatile__(					\
@@ -283,7 +283,7 @@ do {									\
 /*
  * restore saved IRQ & FIQ state
  */
-#define local_irq_restore_hw(x)					\
+#define local_irq_restore_hw_notrace(x)				\
 	__asm__ __volatile__(					\
 	"msr	cpsr_c, %0		@ local_irq_restore_hw\n"\
 	:							\
@@ -306,6 +306,8 @@ unsigned long __ipipe_test_root(void);
 unsigned long __ipipe_test_and_stall_root(void);
 void __ipipe_restore_root(unsigned long flags);
 
+#define local_test_iflag_hw(x)   (!((x) & PSR_I_BIT))
+
 /* PSR_I_BIT is bit no. 7 and is set if interrupts are _disabled_ */
 #define local_irq_save(flags)		((flags) = __ipipe_test_and_stall_root() << 7)
 #define local_irq_enable()		__ipipe_unstall_root()
@@ -317,15 +319,62 @@ void __ipipe_restore_root(unsigned long 
 
 #define irqs_disabled()		__ipipe_test_root()
 
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+
+#include <linux/ipipe_trace.h>
+
+#define local_irq_disable_hw() do { \
+	if (!irqs_disabled_hw()) { \
+		local_irq_disable_hw_notrace(); \
+		ipipe_trace_begin(0x80000000); \
+	} \
+} while (0)
+#define local_irq_enable_hw() do { \
+	if (irqs_disabled_hw()) { \
+		ipipe_trace_end(0x80000000); \
+		local_irq_enable_hw_notrace(); \
+	} \
+} while (0)
+#define local_irq_save_hw(x) do { \
+	local_save_flags_hw(x); \
+	if (local_test_iflag_hw(x)) { \
+		local_irq_disable_hw_notrace(); \
+		ipipe_trace_begin(0x80000001); \
+	} \
+} while (0)
+#define local_irq_restore_hw(x) do { \
+	if (local_test_iflag_hw(x)) \
+		ipipe_trace_end(0x80000001); \
+	local_irq_restore_hw_notrace(x); \
+} while (0)
+
+#else /* !CONFIG_IPIPE_TRACE_IRQSOFF */
+
+#define local_irq_save_hw(flags)	local_irq_save_hw_notrace(flags)
+#define local_irq_enable_hw()		local_irq_enable_hw_notrace()
+#define local_irq_disable_hw()		local_irq_disable_hw_notrace()
+#define local_fiq_enable_hw()		local_fiq_enable_hw_notrace()
+#define local_fiq_disable_hw()		local_fiq_disable_hw_notrace()
+#define local_irq_restore_hw(flags)	local_irq_restore_hw_notrace(flags)
+
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+
 #else /* !CONFIG_IPIPE */
 
-#define local_irq_save(flags)		local_irq_save_hw(flags)
-#define local_irq_enable()		local_irq_enable_hw()
-#define local_irq_disable()		local_irq_disable_hw()
-#define local_fiq_enable()		local_fiq_enable_hw()
-#define local_fiq_disable()		local_fiq_disable_hw()
-#define local_save_flags(flags)	local_save_flags_hw(flags)
-#define local_irq_restore(flags)	local_irq_restore_hw(flags)
+#define local_irq_save(flags)		local_irq_save_hw_notrace(flags)
+#define local_irq_enable()		local_irq_enable_hw_notrace()
+#define local_irq_disable()		local_irq_disable_hw_notrace()
+#define local_fiq_enable()		local_fiq_enable_hw_notrace()
+#define local_fiq_disable()		local_fiq_disable_hw_notrace()
+#define local_save_flags(flags)		local_save_flags_hw(flags)
+#define local_irq_restore(flags)	local_irq_restore_hw_notrace(flags)
+
+#define local_irq_save_hw(flags)	local_irq_save_hw_notrace(flags)
+#define local_irq_enable_hw()		local_irq_enable_hw_notrace()
+#define local_irq_disable_hw()		local_irq_disable_hw_notrace()
+#define local_fiq_enable_hw()		local_fiq_enable_hw_notrace()
+#define local_fiq_disable_hw()		local_fiq_disable_hw_notrace()
+#define local_irq_restore_hw(flags)	local_irq_restore_hw_notrace(flags)
 
 #define irqs_disabled()		irqs_disabled_hw()
 
diff -upNr linux-2.6.15-ipipe.orig/include/linux/ipipe.h linux-2.6.15-ipipe/include/linux/ipipe.h
--- linux-2.6.15-ipipe.orig/include/linux/ipipe.h	2006-10-15 16:28:49.000000000 +0200
+++ linux-2.6.15-ipipe/include/linux/ipipe.h	2006-12-14 09:58:24.000000000 +0100
@@ -38,7 +38,7 @@
 #ifndef BROKEN_BUILTIN_RETURN_ADDRESS
 #define __BUILTIN_RETURN_ADDRESS0 ((unsigned long)__builtin_return_address(0))
 #define __BUILTIN_RETURN_ADDRESS1 ((unsigned long)__builtin_return_address(1))
-#endif /* !BUILTIN_RETURN_ADDRESS */
+#endif /* !BROKEN_BUILTIN_RETURN_ADDRESS */
 
 #define IPIPE_ROOT_PRIO		100
 #define IPIPE_ROOT_ID		0
diff -upNr linux-2.6.15-ipipe.orig/kernel/ipipe/tracer.c linux-2.6.15-ipipe/kernel/ipipe/tracer.c
--- linux-2.6.15-ipipe.orig/kernel/ipipe/tracer.c	2006-10-12 20:08:50.000000000 +0200
+++ linux-2.6.15-ipipe/kernel/ipipe/tracer.c	2006-12-06 16:53:23.000000000 +0100
@@ -100,12 +100,10 @@ enum ipipe_trace_type
 
 
 #ifdef CONFIG_IPIPE_TRACE_VMALLOC
-#define IPIPE_DEFAULT_TRACE_STATE   0
 
 static struct ipipe_trace_path *trace_paths[NR_CPUS];
 
 #else /* !CONFIG_IPIPE_TRACE_VMALLOC */
-#define IPIPE_DEFAULT_TRACE_STATE   CONFIG_IPIPE_TRACE_ENABLE_VALUE
 
 static struct ipipe_trace_path trace_paths[NR_CPUS][IPIPE_TRACE_PATHS] =
 	{ [0 ... NR_CPUS-1] =
@@ -115,7 +113,7 @@ static struct ipipe_trace_path trace_pat
 	};
 #endif /* CONFIG_IPIPE_TRACE_VMALLOC */
 
-int ipipe_trace_enable = IPIPE_DEFAULT_TRACE_STATE;
+int ipipe_trace_enable = 0;
 
 static int active_path[NR_CPUS] =
 	{ [0 ... NR_CPUS-1] = IPIPE_DEFAULT_ACTIVE };
@@ -1217,8 +1215,8 @@ void __init __ipipe_init_tracer(void)
 			trace_paths[cpu][path].end   = -1;
 		}
 	}
-	ipipe_trace_enable = CONFIG_IPIPE_TRACE_ENABLE_VALUE;
 #endif /* CONFIG_IPIPE_TRACE_VMALLOC */
+	ipipe_trace_enable = CONFIG_IPIPE_TRACE_ENABLE_VALUE;
 
 	trace_dir = create_proc_entry("trace", S_IFDIR, ipipe_proc_root);
 

--Boundary-00=_rwrhFZou5pMr2Gm
Content-Type: text/x-diff; charset="iso-8859-15";
	name="xeno_release_timer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xeno_release_timer.patch"

Index: ChangeLog
===================================================================
--- ChangeLog	(Revision 1966)
+++ ChangeLog	(Arbeitskopie)
@@ -1,3 +1,8 @@
+2006-12-18  Sebastian Smolorz  <ssmolorz@domain.hid>
+
+	* ksrc/arch/arm/hal.c: Introduce __ipipe_mach_release_timer()
+	according to changes in I-pipe for ARM
+
 2006-12-18  Jan Kiszka  <jan.kiszka@domain.hid>
 
 	* scripts/xeno-test.in, src/testsuite/*: Install testsuite binaries
Index: ksrc/arch/arm/hal.c
===================================================================
--- ksrc/arch/arm/hal.c	(Revision 1966)
+++ ksrc/arch/arm/hal.c	(Arbeitskopie)
@@ -94,7 +94,7 @@ void rthal_timer_release(void)
     if (rthal_periodic_p)
         rthal_reset_timer();
     else
-        __ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
+        __ipipe_mach_release_timer();
 
     rthal_irq_release(RTHAL_TIMER_IRQ);
 

--Boundary-00=_rwrhFZou5pMr2Gm--

