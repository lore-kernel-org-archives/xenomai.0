From: Stelian Pop <stelian@domain.hid>
In-Reply-To: <1132841651.27409.1.camel@domain.hid>
References: <1132841651.27409.1.camel@domain.hid>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 15:18:07 +0100
Message-Id: <1132841888.27409.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH 2/2] Adeos ARM/2.6 support - arch specific code
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

This is the ARM architecture specific part of the I-Pipe patch.
The PPC 1.0-06 I-Pipe patch served as a basis for this port.

The port supports the ARM Integrator/CP platform, but other platforms
can be easily added.

The processor exception interception is not complete yet, look for
the 'TODO' tag in the patch below.

Signed-off-by: Stelian Pop <stelian@domain.hid>
---

 arch/arm/Kconfig                              |    2 
 arch/arm/kernel/Makefile                      |    1 
 arch/arm/kernel/entry-armv.S                  |   25 +
 arch/arm/kernel/entry-common.S                |   30 +
 arch/arm/kernel/entry-header.S                |    9 
 arch/arm/kernel/irq.c                         |    3 
 arch/arm/kernel/process.c                     |    5 
 arch/arm/mach-integrator/core.c               |  166 +++++---
 arch/arm/mach-integrator/integrator_cp.c      |    8 
 arch/arm/mm/fault.c                           |    3 
 b/arch/arm/kernel/ipipe-core.c                |  501 ++++++++++++++++++++++++++
 b/arch/arm/kernel/ipipe-root.c                |  410 +++++++++++++++++++++
 b/include/asm-arm/hw_irq.h                    |    6 
 b/include/asm-arm/ipipe.h                     |  161 ++++++++
 include/asm-arm/arch-integrator/entry-macro.S |    6 
 include/asm-arm/arch-integrator/platform.h    |    9 
 include/asm-arm/arch-integrator/timex.h       |    4 
 include/asm-arm/atomic.h                      |   12 
 include/asm-arm/bitops.h                      |   24 -
 include/asm-arm/mmu_context.h                 |   10 
 include/asm-arm/pgalloc.h                     |    5 
 include/asm-arm/system.h                      |   88 +++-
 22 files changed, 1371 insertions(+), 117 deletions(-)

diff -r 0e63a7fee245 arch/arm/Kconfig
--- a/arch/arm/Kconfig	Wed Nov 23 18:33:26 2005 +0200
+++ b/arch/arm/Kconfig	Thu Nov 24 12:56:06 2005 +0200
@@ -338,6 +338,8 @@
 	range 2 32
 	depends on SMP
 	default "4"
+
+source "kernel/ipipe/Kconfig"
 
 config PREEMPT
 	bool "Preemptible Kernel (EXPERIMENTAL)"
diff -r 0e63a7fee245 arch/arm/kernel/Makefile
--- a/arch/arm/kernel/Makefile	Wed Nov 23 18:33:26 2005 +0200
+++ b/arch/arm/kernel/Makefile	Thu Nov 24 12:56:06 2005 +0200
@@ -19,6 +19,7 @@
 obj-$(CONFIG_ISA_DMA)		+= dma-isa.o
 obj-$(CONFIG_PCI)		+= bios32.o
 obj-$(CONFIG_SMP)		+= smp.o
+obj-$(CONFIG_IPIPE)		+= ipipe-core.o ipipe-root.o
 
 obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
diff -r 0e63a7fee245 arch/arm/kernel/entry-armv.S
--- a/arch/arm/kernel/entry-armv.S	Wed Nov 23 18:33:26 2005 +0200
+++ b/arch/arm/kernel/entry-armv.S	Thu Nov 24 12:56:06 2005 +0200
@@ -3,6 +3,7 @@
  *
  *  Copyright (C) 1996,1997,1998 Russell King.
  *  ARM700 fix by Matthew Godbolt (linux-user@domain.hid)
+ *  Copyright (C) 2005 Stelian Pop.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -33,7 +34,11 @@
 	@ routine called with r0 = irq number, r1 = struct pt_regs *
 	@
 	adrne	lr, 1b
+#ifdef CONFIG_IPIPE
+	bne	__ipipe_grab_irq
+#else
 	bne	asm_do_IRQ
+#endif
 
 #ifdef CONFIG_SMP
 	/*
@@ -182,6 +187,11 @@
 #endif
 
 	irq_handler
+#ifdef CONFIG_IPIPE
+	cmp	r0, #0
+	beq	__ipipe_fast_svc_irq_exit
+#endif
+
 #ifdef CONFIG_PREEMPT
 	ldr	r0, [tsk, #TI_FLAGS]		@ get flags
 	tst	r0, #_TIF_NEED_RESCHED
@@ -191,6 +201,9 @@
 	str	r8, [tsk, #TI_PREEMPT]		@ restore preempt count
 	teq	r0, r7
 	strne	r0, [r0, -r0]			@ bug()
+#endif
+#ifdef CONFIG_IPIPE
+__ipipe_fast_svc_irq_exit:
 #endif
 	ldr	r0, [sp, #S_PSR]		@ irqs are already disabled
 	msr	spsr_cxsf, r0
@@ -220,6 +233,12 @@
 __und_svc:
 	svc_entry
 
+#ifdef CONFIG_IPIPE
+	mov	r1, sp				@ r0 = trapno, r1 = &regs
+	bl	__ipipe_dispatch_event		@ branch to trap handler
+	cmp	r0, #0
+	bne	1f
+#endif /* CONFIG_IPIPE */
 	@
 	@ call emulation code, which returns using r9 if it has emulated
 	@ the instruction, or the more conventional lr if we are to treat
@@ -378,6 +397,12 @@
 #endif
 
 	irq_handler
+#ifdef CONFIG_IPIPE
+	cmp	r0, #0
+	bne	__ipipe_usr_irq_continue
+	slow_restore_user_regs			@ Fast exit path over non-root domains
+__ipipe_usr_irq_continue:
+#endif
 #ifdef CONFIG_PREEMPT
 	ldr	r0, [tsk, #TI_PREEMPT]
 	str	r8, [tsk, #TI_PREEMPT]
diff -r 0e63a7fee245 arch/arm/kernel/entry-common.S
--- a/arch/arm/kernel/entry-common.S	Wed Nov 23 18:33:26 2005 +0200
+++ b/arch/arm/kernel/entry-common.S	Thu Nov 24 12:56:06 2005 +0200
@@ -2,6 +2,7 @@
  *  linux/arch/arm/kernel/entry-common.S
  *
  *  Copyright (C) 2000 Russell King
+ *  Copyright (C) 2005 Stelian Pop.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -26,7 +27,7 @@
 	tst	r1, #_TIF_WORK_MASK
 	bne	fast_work_pending
 
-	@ fast_restore_user_regs
+fast_restore_user_regs:
 	ldr	r1, [sp, #S_OFF + S_PSR]	@ get calling cpsr
 	ldr	lr, [sp, #S_OFF + S_PC]!	@ get pc
 	msr	spsr_cxsf, r1			@ save in spsr_svc
@@ -34,6 +35,12 @@
 	mov	r0, r0
 	add	sp, sp, #S_FRAME_SIZE - S_PC
 	movs	pc, lr				@ return & move spsr_svc into cpsr
+
+#ifdef CONFIG_IPIPE
+__ipipe_fast_exit_syscall:
+	disable_irq				@ disable interrupts
+	b	fast_restore_user_regs
+#endif /* CONFIG_IPIPE */
 
 /*
  * Ok, we need to do extra processing, enter the slow path.
@@ -63,14 +70,7 @@
 	tst	r1, #_TIF_WORK_MASK
 	bne	work_pending
 no_work_pending:
-	@ slow_restore_user_regs
-	ldr	r1, [sp, #S_PSR]		@ get calling cpsr
-	ldr	lr, [sp, #S_PC]!		@ get pc
-	msr	spsr_cxsf, r1			@ save in spsr_svc
-	ldmdb	sp, {r0 - lr}^			@ get calling r1 - lr
-	mov	r0, r0
-	add	sp, sp, #S_FRAME_SIZE - S_PC
-	movs	pc, lr				@ return & move spsr_svc into cpsr
+	slow_restore_user_regs
 
 /*
  * This is how we return from a fork.
@@ -152,6 +152,15 @@
 	ldr	ip, [tsk, #TI_FLAGS]		@ check for syscall tracing
 	bic	scno, scno, #0xff000000		@ mask off SWI op-code
 	eor	scno, scno, #__NR_SYSCALL_BASE	@ check OS number
+#ifdef CONFIG_IPIPE
+	stmfd	sp!, {r0-r3, ip}
+	add	r0, sp, #S_OFF
+	mov	r1, scno
+	bl	__ipipe_syscall_root
+	cmp	r0,#0
+	ldmfd	sp!, {r0-r3, ip}
+	bne	__ipipe_fast_exit_syscall
+#endif /* CONFIG_IPIPE */
 	adr	tbl, sys_call_table		@ load syscall table pointer
 	tst	ip, #_TIF_SYSCALL_TRACE		@ are we tracing syscalls?
 	bne	__sys_trace
@@ -195,6 +204,9 @@
 	.type	__cr_alignment, #object
 __cr_alignment:
 	.word	cr_alignment
+#endif
+#ifdef CONFIG_IPIPE
+	.word	__ipipe_syscall_root
 #endif
 
 	.type	sys_call_table, #object
diff -r 0e63a7fee245 arch/arm/kernel/entry-header.S
--- a/arch/arm/kernel/entry-header.S	Wed Nov 23 18:33:26 2005 +0200
+++ b/arch/arm/kernel/entry-header.S	Thu Nov 24 12:56:06 2005 +0200
@@ -67,6 +67,15 @@
 #endif
 	.endm
 
+	.macro slow_restore_user_regs
+	ldr	r1, [sp, #S_PSR]		@ get calling cpsr
+	ldr	lr, [sp, #S_PC]!		@ get pc
+	msr	spsr_cxsf, r1			@ save in spsr_svc
+	ldmdb	sp, {r0 - lr}^			@ get calling r1 - lr
+	mov	r0, r0
+	add	sp, sp, #S_FRAME_SIZE - S_PC
+	movs	pc, lr				@ return & move spsr_svc into cpsr
+	.endm
 
 /*
  * These are the registers used in the syscall handler, and allow us to
diff -r 0e63a7fee245 arch/arm/kernel/irq.c
--- a/arch/arm/kernel/irq.c	Wed Nov 23 18:33:26 2005 +0200
+++ b/arch/arm/kernel/irq.c	Thu Nov 24 12:56:06 2005 +0200
@@ -54,10 +54,11 @@
 
 static int noirqdebug;
 static volatile unsigned long irq_err_count;
-static DEFINE_SPINLOCK(irq_controller_lock);
+DEFINE_SPINLOCK(irq_controller_lock);
 static LIST_HEAD(irq_pending);
 
 struct irqdesc irq_desc[NR_IRQS];
+EXPORT_SYMBOL(irq_desc);
 void (*init_arch_irq)(void) __initdata = NULL;
 
 /*
diff -r 0e63a7fee245 arch/arm/kernel/process.c
--- a/arch/arm/kernel/process.c	Wed Nov 23 18:33:26 2005 +0200
+++ b/arch/arm/kernel/process.c	Thu Nov 24 12:56:06 2005 +0200
@@ -85,12 +85,12 @@
  */
 void default_idle(void)
 {
-	local_irq_disable();
+	local_irq_disable_hw_cond();
 	if (!need_resched() && !hlt_counter) {
 		timer_dyn_reprogram();
 		arch_idle();
 	}
-	local_irq_enable();
+	local_irq_enable_hw_cond();
 }
 
 /*
@@ -107,6 +107,7 @@
 		void (*idle)(void) = pm_idle;
 		if (!idle)
 			idle = default_idle;
+		ipipe_suspend_domain();
 		preempt_disable();
 		leds_event(led_idle_start);
 		while (!need_resched())
diff -r 0e63a7fee245 arch/arm/mach-integrator/core.c
--- a/arch/arm/mach-integrator/core.c	Wed Nov 23 18:33:26 2005 +0200
+++ b/arch/arm/mach-integrator/core.c	Thu Nov 24 12:56:06 2005 +0200
@@ -2,6 +2,7 @@
  *  linux/arch/arm/mach-integrator/core.c
  *
  *  Copyright (C) 2000-2003 Deep Blue Solutions Ltd
+ *  Copyright (C) 2005 Stelian Pop.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2, as
@@ -148,16 +149,46 @@
 /*
  * How long is the timer interval?
  */
-#define TIMER_INTERVAL	(TICKS_PER_uSEC * mSEC_10)
-#if TIMER_INTERVAL >= 0x100000
-#define TICKS2USECS(x)	(256 * (x) / TICKS_PER_uSEC)
-#elif TIMER_INTERVAL >= 0x10000
-#define TICKS2USECS(x)	(16 * (x) / TICKS_PER_uSEC)
-#else
 #define TICKS2USECS(x)	((x) / TICKS_PER_uSEC)
+
+static unsigned long timer_reload;
+static unsigned long timer_interval;
+static unsigned long timer_lxlost;
+static int tscok;
+
+#ifdef CONFIG_IPIPE
+int ipipe_mach_timerint = IRQ_TIMERINT1;
+static unsigned long long ipipe_mach_tsc;
+static DEFINE_SPINLOCK(timer_lock);
+
+int ipipe_mach_timerstolen = 0;
+EXPORT_SYMBOL(ipipe_mach_timerstolen);
 #endif
 
-static unsigned long timer_reload;
+/*
+ * Called with IRQ disabled from do_gettimeofday().
+ */
+static inline unsigned long integrator_getticksoffset(void)
+{
+	unsigned long ticks;
+
+	if (!tscok)
+		return 0;
+
+	ticks = readl(TIMER1_VA_BASE + TIMER_VALUE) & 0xffff;
+
+	if (ticks > timer_reload)
+		ticks = 0xffff + timer_reload - ticks;
+	else
+		ticks = timer_reload - ticks;
+
+	if (timer_interval < 0x10000)
+		return ticks;
+	else if (timer_interval < 0x100000)
+		return ticks * 16;
+	else
+		return ticks * 256;
+}
 
 /*
  * Returns number of ms since last clock interrupt.  Note that interrupts
@@ -165,36 +196,10 @@
  */
 unsigned long integrator_gettimeoffset(void)
 {
-	unsigned long ticks1, ticks2, status;
-
-	/*
-	 * Get the current number of ticks.  Note that there is a race
-	 * condition between us reading the timer and checking for
-	 * an interrupt.  We get around this by ensuring that the
-	 * counter has not reloaded between our two reads.
-	 */
-	ticks2 = readl(TIMER1_VA_BASE + TIMER_VALUE) & 0xffff;
-	do {
-		ticks1 = ticks2;
-		status = __raw_readl(VA_IC_BASE + IRQ_RAW_STATUS);
-		ticks2 = readl(TIMER1_VA_BASE + TIMER_VALUE) & 0xffff;
-	} while (ticks2 > ticks1);
-
-	/*
-	 * Number of ticks since last interrupt.
-	 */
-	ticks1 = timer_reload - ticks2;
-
-	/*
-	 * Interrupt pending?  If so, we've reloaded once already.
-	 */
-	if (status & (1 << IRQ_TIMERINT1))
-		ticks1 += timer_reload;
-
 	/*
 	 * Convert the ticks to usecs
 	 */
-	return TICKS2USECS(ticks1);
+	return TICKS2USECS(timer_lxlost + integrator_getticksoffset());
 }
 
 /*
@@ -205,10 +210,21 @@
 {
 	write_seqlock(&xtime_lock);
 
-	/*
-	 * clear the interrupt
-	 */
-	writel(1, TIMER1_VA_BASE + TIMER_INTCLR);
+	timer_lxlost = 0;
+
+#ifdef CONFIG_IPIPE
+	/*
+	 * If Linux is the only domain, ack the timer and reprogram it
+	 */
+	if (!ipipe_mach_timerstolen) {
+		ipipe_mach_tsc += integrator_getticksoffset();
+#endif
+		writel(1, TIMER1_VA_BASE + TIMER_INTCLR);
+
+		writel(timer_reload, TIMER1_VA_BASE + TIMER_LOAD);
+#ifdef CONFIG_IPIPE
+	}
+#endif
 
 	/*
 	 * the clock tick routines are only processed on the
@@ -239,24 +255,30 @@
 	.handler	= integrator_timer_interrupt,
 };
 
+static inline void set_dec(unsigned long reload)
+{
+	unsigned int ctrl = TIMER_CTRL_ENABLE | TIMER_CTRL_IE;
+
+	timer_reload = reload;
+	timer_interval = reload;
+
+	if (timer_reload >= 0x100000) {
+		timer_reload >>= 8;
+		ctrl |= TIMER_CTRL_DIV256;
+	} else if (timer_reload >= 0x010000) {
+		timer_reload >>= 4;
+		ctrl |= TIMER_CTRL_DIV16;
+	}
+
+	writel(ctrl, TIMER1_VA_BASE + TIMER_CTRL);
+	writel(timer_reload, TIMER1_VA_BASE + TIMER_LOAD);
+}
+
 /*
  * Set up timer interrupt, and return the current time in seconds.
  */
 void __init integrator_time_init(unsigned long reload, unsigned int ctrl)
 {
-	unsigned int timer_ctrl = TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC;
-
-	timer_reload = reload;
-	timer_ctrl |= ctrl;
-
-	if (timer_reload > 0x100000) {
-		timer_reload >>= 8;
-		timer_ctrl |= TIMER_CTRL_DIV256;
-	} else if (timer_reload > 0x010000) {
-		timer_reload >>= 4;
-		timer_ctrl |= TIMER_CTRL_DIV16;
-	}
-
 	/*
 	 * Initialise to a known state (all timers off)
 	 */
@@ -264,12 +286,46 @@
 	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 
-	writel(timer_reload, TIMER1_VA_BASE + TIMER_LOAD);
-	writel(timer_reload, TIMER1_VA_BASE + TIMER_VALUE);
-	writel(timer_ctrl, TIMER1_VA_BASE + TIMER_CTRL);
+	set_dec(reload);
 
 	/*
 	 * Make irqs happen for the system timer
 	 */
 	setup_irq(IRQ_TIMERINT1, &integrator_timer_irq);
-}
+
+	tscok = 1;
+}
+
+#ifdef CONFIG_IPIPE
+unsigned long long ipipe_mach_get_tsc(void)
+{
+	unsigned long long result;
+	unsigned long flags;
+
+	spin_lock_irqsave_hw(&timer_lock, flags);
+	result = ipipe_mach_tsc + integrator_getticksoffset();
+	spin_unlock_irqrestore_hw(&timer_lock, flags);
+	return result;
+}
+EXPORT_SYMBOL(ipipe_mach_get_tsc);
+
+void ipipe_mach_set_dec(unsigned long reload)
+{
+	unsigned long ticks;
+	unsigned long flags;
+
+	spin_lock_irqsave_hw(&timer_lock, flags);
+	ticks = integrator_getticksoffset();
+	ipipe_mach_tsc += ticks;
+	timer_lxlost += ticks;
+
+	set_dec(reload);
+	spin_unlock_irqrestore_hw(&timer_lock, flags);
+}
+EXPORT_SYMBOL(ipipe_mach_set_dec);
+
+unsigned long ipipe_mach_get_dec(void)
+{
+	return readl(TIMER1_VA_BASE + TIMER_VALUE);
+}
+#endif /* CONFIG_IPIPE */
diff -r 0e63a7fee245 arch/arm/mach-integrator/integrator_cp.c
--- a/arch/arm/mach-integrator/integrator_cp.c	Wed Nov 23 18:33:26 2005 +0200
+++ b/arch/arm/mach-integrator/integrator_cp.c	Thu Nov 24 12:56:06 2005 +0200
@@ -2,6 +2,7 @@
  *  linux/arch/arm/mach-integrator/integrator_cp.c
  *
  *  Copyright (C) 2003 Deep Blue Solutions Ltd
+ *  Copyright (C) 2005 Stelian Pop.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -521,9 +522,14 @@
 
 #define TIMER_CTRL_IE	(1 << 5)			/* Interrupt Enable */
 
+#ifdef CONFIG_IPIPE
+unsigned int ipipe_mach_ticks_per_jiffy = 1000000 * TICKS_PER_uSEC / HZ;
+EXPORT_SYMBOL(ipipe_mach_ticks_per_jiffy);
+#endif
+
 static void __init intcp_timer_init(void)
 {
-	integrator_time_init(1000000 / HZ, TIMER_CTRL_IE);
+	integrator_time_init(1000000 * TICKS_PER_uSEC / HZ, TIMER_CTRL_IE);
 }
 
 static struct sys_timer cp_timer = {
diff -r 0e63a7fee245 arch/arm/mm/fault.c
--- a/arch/arm/mm/fault.c	Wed Nov 23 18:33:26 2005 +0200
+++ b/arch/arm/mm/fault.c	Thu Nov 24 12:56:06 2005 +0200
@@ -225,6 +225,9 @@
 
 	tsk = current;
 	mm  = tsk->mm;
+
+	if (ipipe_trap_notify(IPIPE_TRAP_ACCESS,regs))
+		return 0;
 
 	/*
 	 * If we're in an interrupt or have no user
diff -r 0e63a7fee245 include/asm-arm/arch-integrator/entry-macro.S
--- a/include/asm-arm/arch-integrator/entry-macro.S	Wed Nov 23 18:33:26 2005 +0200
+++ b/include/asm-arm/arch-integrator/entry-macro.S	Thu Nov 24 12:56:06 2005 +0200
@@ -20,7 +20,11 @@
 		teq	\irqstat, #0
 		ldreq	\irqstat, [\base, #(INTEGRATOR_HDR_IC_OFFSET+IRQ_STATUS)]
 		moveq	\irqnr, #IRQ_CIC_START
-
+#ifdef CONFIG_IPIPE
+		tst	\irqstat, #0x00000040			@ check IRQ_TIMERINT1 first
+		movne	\irqnr, #6
+		bne	1003f
+#endif /* CONFIG_IPIPE */
 1001:		tst	\irqstat, #15
 		bne	1002f
 		add	\irqnr, \irqnr, #4
diff -r 0e63a7fee245 include/asm-arm/arch-integrator/platform.h
--- a/include/asm-arm/arch-integrator/platform.h	Wed Nov 23 18:33:26 2005 +0200
+++ b/include/asm-arm/arch-integrator/platform.h	Thu Nov 24 12:56:06 2005 +0200
@@ -32,6 +32,8 @@
 
 #ifndef __address_h
 #define __address_h                     1
+
+#include <linux/config.h>
 
 /* ========================================================================
  *  Integrator definitions
@@ -436,7 +438,7 @@
  *  Timer definitions
  *
  *  Only use timer 1 & 2
- *  (both run at 24MHz and will need the clock divider set to 16).
+ *  (both run at 1MHZ on /CP and at 24MHz on /AP)
  *
  *  Timer 0 runs at bus frequency and therefore could vary and currently
  *  uHAL can't handle that.
@@ -449,7 +451,12 @@
 
 #define MAX_TIMER                       2
 #define MAX_PERIOD                      699050
+
+#ifdef CONFIG_ARCH_INTEGRATOR_CP
+#define TICKS_PER_uSEC                  1
+#else
 #define TICKS_PER_uSEC                  24
+#endif
 
 /*
  *  These are useconds NOT ticks.
diff -r 0e63a7fee245 include/asm-arm/arch-integrator/timex.h
--- a/include/asm-arm/arch-integrator/timex.h	Wed Nov 23 18:33:26 2005 +0200
+++ b/include/asm-arm/arch-integrator/timex.h	Thu Nov 24 12:56:06 2005 +0200
@@ -21,6 +21,6 @@
  */
 
 /*
- * ??
+ * Timer rate
  */
-#define CLOCK_TICK_RATE		(50000000 / 16)
+#define CLOCK_TICK_RATE		(1000000)
diff -r 0e63a7fee245 include/asm-arm/atomic.h
--- a/include/asm-arm/atomic.h	Wed Nov 23 18:33:26 2005 +0200
+++ b/include/asm-arm/atomic.h	Thu Nov 24 12:56:06 2005 +0200
@@ -110,10 +110,10 @@
 	unsigned long flags;
 	int val;
 
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	val = v->counter;
 	v->counter = val += i;
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 
 	return val;
 }
@@ -123,10 +123,10 @@
 	unsigned long flags;
 	int val;
 
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	val = v->counter;
 	v->counter = val -= i;
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 
 	return val;
 }
@@ -135,9 +135,9 @@
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	*addr &= ~mask;
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
 
 #endif /* __LINUX_ARM_ARCH__ */
diff -r 0e63a7fee245 include/asm-arm/bitops.h
--- a/include/asm-arm/bitops.h	Wed Nov 23 18:33:26 2005 +0200
+++ b/include/asm-arm/bitops.h	Thu Nov 24 12:56:06 2005 +0200
@@ -36,9 +36,9 @@
 
 	p += bit >> 5;
 
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	*p |= mask;
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
 
 static inline void ____atomic_clear_bit(unsigned int bit, volatile unsigned long *p)
@@ -48,9 +48,9 @@
 
 	p += bit >> 5;
 
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	*p &= ~mask;
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
 
 static inline void ____atomic_change_bit(unsigned int bit, volatile unsigned long *p)
@@ -60,9 +60,9 @@
 
 	p += bit >> 5;
 
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	*p ^= mask;
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
 
 static inline int
@@ -74,10 +74,10 @@
 
 	p += bit >> 5;
 
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	res = *p;
 	*p = res | mask;
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 
 	return res & mask;
 }
@@ -91,10 +91,10 @@
 
 	p += bit >> 5;
 
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	res = *p;
 	*p = res & ~mask;
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 
 	return res & mask;
 }
@@ -108,10 +108,10 @@
 
 	p += bit >> 5;
 
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	res = *p;
 	*p = res ^ mask;
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 
 	return res & mask;
 }
diff -r 0e63a7fee245 include/asm-arm/mmu_context.h
--- a/include/asm-arm/mmu_context.h	Wed Nov 23 18:33:26 2005 +0200
+++ b/include/asm-arm/mmu_context.h	Thu Nov 24 12:56:06 2005 +0200
@@ -91,6 +91,16 @@
 }
 
 #define deactivate_mm(tsk,mm)	do { } while (0)
+#ifdef CONFIG_IPIPE
+#define activate_mm(active_mm, mm)		\
+do {						\
+	unsigned long flags;			\
+	local_irq_save_hw_cond(flags);		\
+	switch_mm(active_mm, mm, current);	\
+	local_irq_restore_hw_cond(flags);	\
+} while(0)
+#else
 #define activate_mm(prev,next)	switch_mm(prev, next, NULL)
+#endif
 
 #endif
diff -r 0e63a7fee245 include/asm-arm/pgalloc.h
--- a/include/asm-arm/pgalloc.h	Wed Nov 23 18:33:26 2005 +0200
+++ b/include/asm-arm/pgalloc.h	Thu Nov 24 12:56:06 2005 +0200
@@ -28,6 +28,11 @@
 #define pgd_free(pgd)			free_pgd_slow(pgd)
 
 #define check_pgt_cache()		do { } while (0)
+
+static inline void set_pgdir(unsigned long address, pgd_t entry)
+{
+	/* nop */
+}
 
 /*
  * Allocate one PTE table.
diff -r 0e63a7fee245 include/asm-arm/system.h
--- a/include/asm-arm/system.h	Wed Nov 23 18:33:26 2005 +0200
+++ b/include/asm-arm/system.h	Thu Nov 24 12:56:06 2005 +0200
@@ -176,30 +176,30 @@
  */
 #if __LINUX_ARM_ARCH__ >= 6
 
-#define local_irq_save(x)					\
-	({							\
-	__asm__ __volatile__(					\
-	"mrs	%0, cpsr		@ local_irq_save\n"	\
+#define local_irq_save_hw(x)					\
+	({							\
+	__asm__ __volatile__(					\
+	"mrs	%0, cpsr		@ local_irq_save_hw\n"	\
 	"cpsid	i"						\
 	: "=r" (x) : : "memory", "cc");				\
 	})
 
-#define local_irq_enable()  __asm__("cpsie i	@ __sti" : : : "memory", "cc")
-#define local_irq_disable() __asm__("cpsid i	@ __cli" : : : "memory", "cc")
-#define local_fiq_enable()  __asm__("cpsie f	@ __stf" : : : "memory", "cc")
-#define local_fiq_disable() __asm__("cpsid f	@ __clf" : : : "memory", "cc")
+#define local_irq_enable_hw()  __asm__("cpsie i	@ __sti" : : : "memory", "cc")
+#define local_irq_disable_hw() __asm__("cpsid i	@ __cli" : : : "memory", "cc")
+#define local_fiq_enable_hw()  __asm__("cpsie f	@ __stf" : : : "memory", "cc")
+#define local_fiq_disable_hw() __asm__("cpsid f	@ __clf" : : : "memory", "cc")
 
 #else
 
 /*
  * Save the current interrupt enable state & disable IRQs
  */
-#define local_irq_save(x)					\
+#define local_irq_save_hw(x)					\
 	({							\
 		unsigned long temp;				\
 		(void) (&temp == &x);				\
 	__asm__ __volatile__(					\
-	"mrs	%0, cpsr		@ local_irq_save\n"	\
+	"mrs	%0, cpsr		@ local_irq_save_hw\n"	\
 "	orr	%1, %0, #128\n"					\
 "	msr	cpsr_c, %1"					\
 	: "=r" (x), "=r" (temp)					\
@@ -210,11 +210,11 @@
 /*
  * Enable IRQs
  */
-#define local_irq_enable()					\
+#define local_irq_enable_hw()					\
 	({							\
 		unsigned long temp;				\
 	__asm__ __volatile__(					\
-	"mrs	%0, cpsr		@ local_irq_enable\n"	\
+	"mrs	%0, cpsr		@ local_irq_enable_hw\n"\
 "	bic	%0, %0, #128\n"					\
 "	msr	cpsr_c, %0"					\
 	: "=r" (temp)						\
@@ -225,11 +225,11 @@
 /*
  * Disable IRQs
  */
-#define local_irq_disable()					\
+#define local_irq_disable_hw()					\
 	({							\
 		unsigned long temp;				\
 	__asm__ __volatile__(					\
-	"mrs	%0, cpsr		@ local_irq_disable\n"	\
+	"mrs	%0, cpsr		@ local_irq_disable_hw\n"\
 "	orr	%0, %0, #128\n"					\
 "	msr	cpsr_c, %0"					\
 	: "=r" (temp)						\
@@ -240,7 +240,7 @@
 /*
  * Enable FIQs
  */
-#define local_fiq_enable()					\
+#define local_fiq_enable_hw()					\
 	({							\
 		unsigned long temp;				\
 	__asm__ __volatile__(					\
@@ -255,7 +255,7 @@
 /*
  * Disable FIQs
  */
-#define local_fiq_disable()					\
+#define local_fiq_disable_hw()					\
 	({							\
 		unsigned long temp;				\
 	__asm__ __volatile__(					\
@@ -272,29 +272,63 @@
 /*
  * Save the current interrupt enable state.
  */
-#define local_save_flags(x)					\
-	({							\
-	__asm__ __volatile__(					\
-	"mrs	%0, cpsr		@ local_save_flags"	\
+#define local_save_flags_hw(x)					\
+	({							\
+	__asm__ __volatile__(					\
+	"mrs	%0, cpsr		@ local_save_flags_hw"	\
 	: "=r" (x) : : "memory", "cc");				\
 	})
 
 /*
  * restore saved IRQ & FIQ state
  */
-#define local_irq_restore(x)					\
-	__asm__ __volatile__(					\
-	"msr	cpsr_c, %0		@ local_irq_restore\n"	\
+#define local_irq_restore_hw(x)					\
+	__asm__ __volatile__(					\
+	"msr	cpsr_c, %0		@ local_irq_restore_hw\n"\
 	:							\
 	: "r" (x)						\
 	: "memory", "cc")
 
-#define irqs_disabled()			\
-({					\
+#define irqs_disabled_hw()		\
+	({				\
 	unsigned long flags;		\
-	local_save_flags(flags);	\
+	local_save_flags_hw(flags);	\
 	(int)(flags & PSR_I_BIT);	\
-})
+	})
+
+
+#ifdef CONFIG_IPIPE
+
+void __ipipe_stall_root(void);
+void __ipipe_unstall_root(void);
+unsigned long __ipipe_test_root(void);
+unsigned long __ipipe_test_and_stall_root(void);
+void __ipipe_restore_root(unsigned long flags);
+
+/* PSR_I_BIT is bit no. 7 and is set if interrupts are _disabled_ */
+#define local_irq_save(flags)		((flags) = __ipipe_test_and_stall_root() << 7)
+#define local_irq_enable()		__ipipe_unstall_root()
+#define local_irq_disable()		__ipipe_stall_root()
+#define local_fiq_enable()		__ipipe_unstall_root()
+#define local_fiq_disable()		__ipipe_stall_root()
+#define local_save_flags(flags)		((flags) = __ipipe_test_root() << 7)
+#define local_irq_restore(flags)	__ipipe_restore_root(flags & PSR_I_BIT)
+
+#define irqs_disabled()			__ipipe_test_root()
+
+#else /* !CONFIG_IPIPE */
+
+#define local_irq_save(flags)		local_irq_save_hw(flags)
+#define local_irq_enable()		local_irq_enable_hw()
+#define local_irq_disable()		local_irq_disable_hw()
+#define local_fiq_enable()		local_fiq_enable_hw()
+#define local_fiq_disable()		local_fiq_disable_hw()
+#define local_save_flags(flags)		local_save_flags_hw(flags)
+#define local_irq_restore(flags)	local_irq_restore_hw(flags)
+
+#define irqs_disabled()			irqs_disabled_hw()
+
+#endif /* CONFIG_IPIPE */
 
 #ifdef CONFIG_SMP
 
diff -r 0e63a7fee245 arch/arm/kernel/ipipe-core.c
--- /dev/null	Wed Nov 23 18:33:26 2005 +0200
+++ b/arch/arm/kernel/ipipe-core.c	Thu Nov 24 12:56:06 2005 +0200
@@ -0,0 +1,501 @@
+/* -*- linux-c -*-
+ * linux/arch/arm/kernel/ipipe-core.c
+ *
+ * Copyright (C) 2002-2005 Philippe Gerum.
+ * Copyright (C) 2004 Wolfgang Grandegger (Adeos/arm port over 2.4).
+ * Copyright (C) 2005 Heikki Lindholm (PowerPC 970 fixes).
+ * Copyright (C) 2005 Stelian Pop.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Architecture-dependent I-PIPE core support for ARM.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/hardirq.h>
+#include <asm/io.h>
+
+/* Current reload value for the decrementer. */
+unsigned long __ipipe_decr_ticks;
+
+/* Next tick date (timebase value). */
+unsigned long long __ipipe_decr_next[IPIPE_NR_CPUS];
+
+struct pt_regs __ipipe_tick_regs[IPIPE_NR_CPUS];
+
+#ifdef CONFIG_SMP
+
+static cpumask_t __ipipe_cpu_sync_map;
+
+static cpumask_t __ipipe_cpu_lock_map;
+
+static ipipe_spinlock_t __ipipe_cpu_barrier = IPIPE_SPIN_LOCK_UNLOCKED;
+
+static atomic_t __ipipe_critical_count = ATOMIC_INIT(0);
+
+static void (*__ipipe_cpu_sync) (void);
+
+/* Always called with hw interrupts off. */
+
+void __ipipe_do_critical_sync(unsigned irq)
+{
+	ipipe_declare_cpuid;
+
+	ipipe_load_cpuid();
+
+	cpu_set(cpuid, __ipipe_cpu_sync_map);
+
+	/*
+	 * Now we are in sync with the lock requestor running on another
+	 * CPU. Enter a spinning wait until he releases the global
+	 * lock.
+	 */
+	spin_lock_hw(&__ipipe_cpu_barrier);
+
+	/* Got it. Now get out. */
+
+	if (__ipipe_cpu_sync)
+		/* Call the sync routine if any. */
+		__ipipe_cpu_sync();
+
+	spin_unlock_hw(&__ipipe_cpu_barrier);
+
+	cpu_clear(cpuid, __ipipe_cpu_sync_map);
+}
+
+#endif	/* CONFIG_SMP */
+
+/*
+ * ipipe_critical_enter() -- Grab the superlock excluding all CPUs
+ * but the current one from a critical section. This lock is used when
+ * we must enforce a global critical section for a single CPU in a
+ * possibly SMP system whichever context the CPUs are running.
+ */
+unsigned long ipipe_critical_enter(void (*syncfn) (void))
+{
+	unsigned long flags;
+
+	local_irq_save_hw(flags);
+
+#ifdef CONFIG_SMP
+	if (num_online_cpus() > 1) {	/* We might be running a SMP-kernel on a UP box... */
+		ipipe_declare_cpuid;
+		cpumask_t lock_map;
+
+		ipipe_load_cpuid();
+
+		if (!cpu_test_and_set(cpuid, __ipipe_cpu_lock_map)) {
+			while (cpu_test_and_set(BITS_PER_LONG - 1,
+						__ipipe_cpu_lock_map)) {
+				int n = 0;
+				do {
+					cpu_relax();
+				} while (++n < cpuid);
+			}
+
+			spin_lock_hw(&__ipipe_cpu_barrier);
+
+			__ipipe_cpu_sync = syncfn;
+
+			/* Send the sync IPI to all processors but the current one. */
+			send_IPI_allbutself(IPIPE_CRITICAL_VECTOR);
+
+			cpus_andnot(lock_map, cpu_online_map,
+				    __ipipe_cpu_lock_map);
+
+			while (!cpus_equal(__ipipe_cpu_sync_map, lock_map))
+				cpu_relax();
+		}
+
+		atomic_inc(&__ipipe_critical_count);
+	}
+#endif	/* CONFIG_SMP */
+
+	return flags;
+}
+
+/* ipipe_critical_exit() -- Release the superlock. */
+
+void ipipe_critical_exit(unsigned long flags)
+{
+#ifdef CONFIG_SMP
+	if (num_online_cpus() > 1) {	/* We might be running a SMP-kernel on a UP box... */
+		ipipe_declare_cpuid;
+
+		ipipe_load_cpuid();
+
+		if (atomic_dec_and_test(&__ipipe_critical_count)) {
+			spin_unlock_hw(&__ipipe_cpu_barrier);
+
+			while (!cpus_empty(__ipipe_cpu_sync_map))
+				cpu_relax();
+
+			cpu_clear(cpuid, __ipipe_cpu_lock_map);
+			cpu_clear(BITS_PER_LONG - 1, __ipipe_cpu_lock_map);
+		}
+	}
+#endif	/* CONFIG_SMP */
+
+	local_irq_restore_hw(flags);
+}
+
+void __ipipe_init_platform(void)
+{
+	__ipipe_decr_ticks = ipipe_mach_ticks_per_jiffy;
+}
+
+/*
+ * __ipipe_sync_stage() -- Flush the pending IRQs for the current
+ * domain (and processor). This routine flushes the interrupt log
+ * (see "Optimistic interrupt protection" from D. Stodolsky et al. for
+ * more on the deferred interrupt scheme). Every interrupt that
+ * occurred while the pipeline was stalled gets played. WARNING:
+ * callers on SMP boxen should always check for CPU migration on
+ * return of this routine. One can control the kind of interrupts
+ * which are going to be sync'ed using the syncmask
+ * parameter. IPIPE_IRQMASK_ANY plays them all, IPIPE_IRQMASK_VIRT
+ * plays virtual interrupts only. This routine must be called with hw
+ * interrupts off.
+ */
+void __ipipe_sync_stage(unsigned long syncmask)
+{
+	unsigned long mask, submask;
+	struct ipcpudata *cpudata;
+	struct ipipe_domain *ipd;
+	ipipe_declare_cpuid;
+	int level, rank;
+	unsigned irq;
+
+	ipipe_load_cpuid();
+	ipd = ipipe_percpu_domain[cpuid];
+	cpudata = &ipd->cpudata[cpuid];
+
+	if (__test_and_set_bit(IPIPE_SYNC_FLAG, &cpudata->status))
+		return;
+
+	/*
+	 * The policy here is to keep the dispatching code interrupt-free
+	 * by stalling the current stage. If the upper domain handler
+	 * (which we call) wants to re-enable interrupts while in a safe
+	 * portion of the code (e.g. SA_INTERRUPT flag unset for Linux's
+	 * sigaction()), it will have to unstall (then stall again before
+	 * returning to us!) the stage when it sees fit.
+	 */
+	while ((mask = (cpudata->irq_pending_hi & syncmask)) != 0) {
+		level = ffs(mask) - 1;
+		__clear_bit(level, &cpudata->irq_pending_hi);
+
+		while ((submask = cpudata->irq_pending_lo[level]) != 0) {
+			rank = ffs(submask) - 1;
+			irq = (level << IPIPE_IRQ_ISHIFT) + rank;
+
+			if (test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control)) {
+				__clear_bit(rank,
+					    &cpudata->irq_pending_lo[level]);
+				continue;
+			}
+
+			if (--cpudata->irq_hits[irq] == 0) {
+				__clear_bit(rank,
+					    &cpudata->irq_pending_lo[level]);
+				ipipe_mark_irq_delivery(ipd,irq,cpuid);
+			}
+
+			__set_bit(IPIPE_STALL_FLAG, &cpudata->status);
+			ipipe_mark_domain_stall(ipd, cpuid);
+
+			if (ipd == ipipe_root_domain) {
+				/*
+				 * Linux handlers are called w/ hw
+				 * interrupts on so that they could
+				 * not defer interrupts for higher
+				 * priority domains.
+				 */
+				local_irq_enable_hw();
+				((void (*)(unsigned, struct pt_regs *))
+				 ipd->irqs[irq].handler) (irq, __ipipe_tick_regs + cpuid);
+				local_irq_disable_hw();
+			} else {
+				__clear_bit(IPIPE_SYNC_FLAG, &cpudata->status);
+				ipd->irqs[irq].handler(irq);
+				__set_bit(IPIPE_SYNC_FLAG, &cpudata->status);
+			}
+#ifdef CONFIG_SMP
+			{
+				int _cpuid = ipipe_processor_id();
+
+				if (_cpuid != cpuid) {	/* Handle CPU migration. */
+					/*
+					 * We expect any domain to clear the SYNC bit each
+					 * time it switches in a new task, so that preemptions
+					 * and/or CPU migrations (in the SMP case) over the
+					 * ISR do not lock out the log syncer for some
+					 * indefinite amount of time. In the Linux case,
+					 * schedule() handles this (see kernel/sched.c). For
+					 * this reason, we don't bother clearing it here for
+					 * the source CPU in the migration handling case,
+					 * since it must have scheduled another task in by
+					 * now.
+					 */
+					cpuid = _cpuid;
+					cpudata = &ipd->cpudata[cpuid];
+					__set_bit(IPIPE_SYNC_FLAG, &cpudata->status);
+				}
+			}
+#endif	/* CONFIG_SMP */
+
+			__clear_bit(IPIPE_STALL_FLAG, &cpudata->status);
+			ipipe_mark_domain_unstall(ipd, cpuid);
+		}
+	}
+
+	__clear_bit(IPIPE_SYNC_FLAG, &cpudata->status);
+}
+
+/*
+ * ipipe_virtualize_irq() -- Attach a handler (and optionally a hw
+ * acknowledge routine) to an interrupt for the given domain.
+ */
+int ipipe_virtualize_irq(struct ipipe_domain *ipd,
+			 unsigned irq,
+			 void (*handler) (unsigned irq),
+			 int (*acknowledge) (unsigned irq), unsigned modemask)
+{
+	unsigned long flags;
+	int err;
+
+	if (irq >= IPIPE_NR_IRQS)
+		return -EINVAL;
+
+	if (ipd->irqs[irq].control & IPIPE_SYSTEM_MASK)
+		return -EPERM;
+
+	spin_lock_irqsave_hw(&__ipipe_pipelock, flags);
+
+	if (handler != NULL) {
+		/*
+		 * A bit of hack here: if we are re-virtualizing an IRQ just
+		 * to change the acknowledge routine by passing the special
+		 * IPIPE_SAME_HANDLER value, then allow to recycle the current
+		 * handler for the IRQ. This allows Linux device drivers
+		 * managing shared IRQ lines to call ipipe_virtualize_irq() in
+		 * addition to request_irq() just for the purpose of
+		 * interposing their own shared acknowledge routine.
+		 */
+
+		if (handler == IPIPE_SAME_HANDLER) {
+			handler = ipd->irqs[irq].handler;
+
+			if (handler == NULL) {
+				err = -EINVAL;
+				goto unlock_and_exit;
+			}
+		} else if ((modemask & IPIPE_EXCLUSIVE_MASK) != 0 &&
+			   ipd->irqs[irq].handler != NULL) {
+			err = -EBUSY;
+			goto unlock_and_exit;
+		}
+
+		if ((modemask & (IPIPE_SHARED_MASK | IPIPE_PASS_MASK)) ==
+			IPIPE_SHARED_MASK) {
+			err = -EINVAL;
+			goto unlock_and_exit;
+		}
+
+		if ((modemask & IPIPE_STICKY_MASK) != 0)
+			modemask |= IPIPE_HANDLE_MASK;
+	} else
+		modemask &=
+			~(IPIPE_HANDLE_MASK | IPIPE_STICKY_MASK |
+			IPIPE_SHARED_MASK);
+
+	if (acknowledge == NULL) {
+		if ((modemask & IPIPE_SHARED_MASK) == 0)
+			/*
+			 * Acknowledge handler unspecified -- this is ok in
+			 * non-shared management mode, but we will force the
+			 * use of the Linux-defined handler instead.
+			 */
+			acknowledge = ipipe_root_domain->irqs[irq].acknowledge;
+		else {
+			/*
+			 * A valid acknowledge handler to be called in shared
+			 * mode is required when declaring a shared IRQ.
+			 */
+			err = -EINVAL;
+			goto unlock_and_exit;
+		}
+	}
+
+	ipd->irqs[irq].handler = handler;
+	ipd->irqs[irq].acknowledge = acknowledge;
+	ipd->irqs[irq].control = modemask;
+
+	if (irq < NR_IRQS &&
+	    handler != NULL &&
+	    !ipipe_virtual_irq_p(irq) && (modemask & IPIPE_ENABLE_MASK) != 0) {
+		if (ipd != ipipe_current_domain) {
+			/*
+			 * IRQ enable/disable state is domain-sensitive, so
+			 * we may not change it for another domain. What is
+			 * allowed however is forcing some domain to handle
+			 * an interrupt source, by passing the proper 'ipd'
+			 * descriptor which thus may be different from
+			 * ipipe_current_domain.
+			 */
+			err = -EPERM;
+			goto unlock_and_exit;
+		}
+
+		enable_irq(irq);
+	}
+
+	err = 0;
+
+unlock_and_exit:
+
+	spin_unlock_irqrestore_hw(&__ipipe_pipelock, flags);
+
+	return err;
+}
+
+/* ipipe_control_irq() -- Change modes of a pipelined interrupt for
+ * the current domain. */
+
+int ipipe_control_irq(unsigned irq, unsigned clrmask, unsigned setmask)
+{
+	irq_desc_t *desc;
+	unsigned long flags;
+
+	if (irq >= IPIPE_NR_IRQS)
+		return -EINVAL;
+
+	if (ipipe_current_domain->irqs[irq].control & IPIPE_SYSTEM_MASK)
+		return -EPERM;
+
+	if (((setmask | clrmask) & IPIPE_SHARED_MASK) != 0)
+		return -EINVAL;
+
+	desc = irq_desc + irq;
+
+	if (ipipe_current_domain->irqs[irq].handler == NULL)
+		setmask &= ~(IPIPE_HANDLE_MASK | IPIPE_STICKY_MASK);
+
+	if ((setmask & IPIPE_STICKY_MASK) != 0)
+		setmask |= IPIPE_HANDLE_MASK;
+
+	if ((clrmask & (IPIPE_HANDLE_MASK | IPIPE_STICKY_MASK)) != 0)	/* If one goes, both go. */
+		clrmask |= (IPIPE_HANDLE_MASK | IPIPE_STICKY_MASK);
+
+	spin_lock_irqsave_hw(&__ipipe_pipelock, flags);
+
+	ipipe_current_domain->irqs[irq].control &= ~clrmask;
+	ipipe_current_domain->irqs[irq].control |= setmask;
+
+	if ((setmask & IPIPE_ENABLE_MASK) != 0)
+		enable_irq(irq);
+	else if ((clrmask & IPIPE_ENABLE_MASK) != 0)
+		disable_irq(irq);
+
+	spin_unlock_irqrestore_hw(&__ipipe_pipelock, flags);
+
+	return 0;
+}
+
+int ipipe_get_sysinfo(struct ipipe_sysinfo *info)
+{
+	info->ncpus = num_online_cpus();
+	info->cpufreq = ipipe_cpu_freq();
+	info->archdep.tmirq = ipipe_mach_timerint;
+	info->archdep.tmfreq = info->cpufreq;
+
+	return 0;
+}
+
+/*
+ * ipipe_trigger_irq() -- Push the interrupt at front of the pipeline
+ * just like if it has been actually received from a hw source. Also
+ * works for virtual interrupts.
+ */
+int ipipe_trigger_irq(unsigned irq)
+{
+	unsigned long flags;
+
+	if (irq >= IPIPE_NR_IRQS ||
+	    (ipipe_virtual_irq_p(irq)
+	     && !test_bit(irq - IPIPE_VIRQ_BASE, &__ipipe_virtual_irq_map)))
+		return -EINVAL;
+
+	local_irq_save_hw(flags);
+
+	__ipipe_handle_irq(irq, NULL);
+
+	local_irq_restore_hw(flags);
+
+	return 1;
+}
+
+static void __ipipe_set_decr(void)
+{
+	ipipe_declare_cpuid;
+
+	ipipe_load_cpuid();
+
+	__ipipe_decr_next[cpuid] = __ipipe_read_timebase() + __ipipe_decr_ticks;
+	ipipe_mach_set_dec(__ipipe_decr_ticks);
+}
+
+int ipipe_tune_timer(unsigned long ns, int flags)
+{
+	unsigned long x, ticks;
+
+	if (flags & IPIPE_RESET_TIMER)
+		ticks = ipipe_mach_ticks_per_jiffy;
+	else {
+		ticks = ns * ipipe_mach_ticks_per_jiffy / (1000000000 / HZ);
+
+		if (ticks > ipipe_mach_ticks_per_jiffy)
+			return -EINVAL;
+	}
+
+	x = ipipe_critical_enter(&__ipipe_set_decr);	/* Sync with all CPUs */
+	__ipipe_decr_ticks = ticks;
+	__ipipe_set_decr();
+	ipipe_critical_exit(x);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(__ipipe_sync_stage);
+EXPORT_SYMBOL(__ipipe_decr_ticks);
+EXPORT_SYMBOL(__ipipe_decr_next);
+EXPORT_SYMBOL(ipipe_critical_enter);
+EXPORT_SYMBOL(ipipe_critical_exit);
+EXPORT_SYMBOL(ipipe_trigger_irq);
+EXPORT_SYMBOL(ipipe_virtualize_irq);
+EXPORT_SYMBOL(ipipe_control_irq);
+EXPORT_SYMBOL(ipipe_get_sysinfo);
+EXPORT_SYMBOL(ipipe_tune_timer);
diff -r 0e63a7fee245 arch/arm/kernel/ipipe-root.c
--- /dev/null	Wed Nov 23 18:33:26 2005 +0200
+++ b/arch/arm/kernel/ipipe-root.c	Thu Nov 24 12:56:06 2005 +0200
@@ -0,0 +1,410 @@
+/* -*- linux-c -*-
+ * linux/arch/arm/kernel/ipipe-root.c
+ *
+ * Copyright (C) 2002-2005 Philippe Gerum (Adeos/ppc port over 2.6).
+ * Copyright (C) 2004 Wolfgang Grandegger (Adeos/ppc port over 2.4).
+ * Copyright (C) 2005 Stelian Pop.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Architecture-dependent I-pipe support for ARM.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/errno.h>
+#include <asm/system.h>
+#include <asm/hardirq.h>
+#include <asm/atomic.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/mach/irq.h>
+
+extern struct irqdesc irq_desc[];
+extern spinlock_t irq_controller_lock;
+extern asmlinkage void asm_do_IRQ(unsigned int irq, struct pt_regs *regs);
+
+static struct irqchip __ipipe_std_irq_dtype[NR_IRQS];
+
+static void __ipipe_override_irq_unmask(unsigned irq)
+{
+	unsigned long flags;
+
+	local_irq_save_hw(flags);
+	ipipe_irq_unlock(irq);
+	__ipipe_std_irq_dtype[irq].unmask(irq);
+	local_irq_restore_hw(flags);
+}
+
+static void __ipipe_override_irq_mask(unsigned irq)
+{
+	unsigned long flags;
+
+	local_irq_save_hw(flags);
+	ipipe_irq_lock(irq);
+	__ipipe_std_irq_dtype[irq].mask(irq);
+	local_irq_restore_hw(flags);
+}
+
+static void __ipipe_override_irq_mask_ack(unsigned irq)
+{
+	unsigned long flags;
+
+	local_irq_save_hw(flags);
+	ipipe_irq_lock(irq);
+	__ipipe_std_irq_dtype[irq].ack(irq);
+	local_irq_restore_hw(flags);
+}
+
+
+static void __ipipe_enable_sync(void)
+{
+	__ipipe_decr_next[ipipe_processor_id()] =
+		__ipipe_read_timebase() + ipipe_mach_get_dec();
+}
+
+/*
+ * __ipipe_enable_pipeline() -- We are running on the boot CPU, hw
+ * interrupts are off, and secondary CPUs are still lost in space.
+ */
+void __ipipe_enable_pipeline(void)
+{
+	unsigned long flags;
+	unsigned irq;
+
+	flags = ipipe_critical_enter(&__ipipe_enable_sync);
+
+	/* First, virtualize all interrupts from the root domain. */
+
+	for (irq = 0; irq < NR_IRQS; irq++)
+		ipipe_virtualize_irq(ipipe_root_domain,
+				     irq,
+				     (void (*)(unsigned))&asm_do_IRQ,
+				     &__ipipe_ack_irq,
+				     IPIPE_HANDLE_MASK | IPIPE_PASS_MASK);
+
+	/*
+	 * Interpose on the IRQ control routines so we can make them
+	 * atomic using hw masking and prevent the interrupt log from
+	 * being untimely flushed.
+	 */
+
+	for (irq = 0; irq < NR_IRQS; irq++)
+		__ipipe_std_irq_dtype[irq] = *irq_desc[irq].chip;
+
+	/*
+	 * The original controller structs are often shared, so we first
+	 * save them all before changing any of them. Notice that we don't
+	 * override the ack() handler since we will enforce the necessary
+	 * setup in __ipipe_ack_irq().
+	 */
+
+	for (irq = 0; irq < NR_IRQS; irq++) {
+		if (irq_desc[irq].chip->mask != NULL)
+			irq_desc[irq].chip->mask = __ipipe_override_irq_mask;
+
+		if (irq_desc[irq].chip->unmask != NULL)
+			irq_desc[irq].chip->unmask = __ipipe_override_irq_unmask;
+
+		if (irq_desc[irq].chip->ack != NULL)
+			irq_desc[irq].chip->ack = __ipipe_override_irq_mask_ack;
+	}
+
+	__ipipe_decr_next[ipipe_processor_id()] =
+		__ipipe_read_timebase() + ipipe_mach_get_dec();
+
+	ipipe_critical_exit(flags);
+}
+
+int __ipipe_ack_irq(unsigned irq)
+{
+	unsigned long flags;
+	ipipe_declare_cpuid;
+
+	/*
+	 * No need to mask IRQs at hw level: we are always called from
+	 * __ipipe_handle_irq(), so interrupts are already off. We
+	 * stall the pipeline so that spin_lock_irq*() ops won't
+	 * unintentionally flush it, since this could cause infinite
+	 * recursion.
+	 */
+
+	ipipe_load_cpuid();
+	flags = ipipe_test_and_stall_pipeline();
+	preempt_disable();
+	spin_lock_hw(&irq_controller_lock);
+	__ipipe_std_irq_dtype[irq].ack(irq);
+	spin_unlock_hw(&irq_controller_lock);
+	preempt_enable_no_resched();
+	ipipe_restore_pipeline_nosync(ipipe_percpu_domain[cpuid], flags, cpuid);
+
+	return 1;
+}
+
+/*
+ * __ipipe_walk_pipeline(): Plays interrupts pending in the log. Must
+ * be called with local hw interrupts disabled.
+ */
+static inline void __ipipe_walk_pipeline(struct list_head *pos, int cpuid)
+{
+	struct ipipe_domain *this_domain = ipipe_percpu_domain[cpuid];
+
+	while (pos != &__ipipe_pipeline) {
+		struct ipipe_domain *next_domain =
+			list_entry(pos, struct ipipe_domain, p_link);
+
+		if (test_bit(IPIPE_STALL_FLAG,
+			     &next_domain->cpudata[cpuid].status))
+			break;	/* Stalled stage -- do not go further. */
+
+		if (next_domain->cpudata[cpuid].irq_pending_hi != 0) {
+
+			if (next_domain == this_domain)
+				__ipipe_sync_stage(IPIPE_IRQMASK_ANY);
+			else {
+				__ipipe_switch_to(this_domain, next_domain, cpuid);
+
+				ipipe_load_cpuid();	/* Processor might have changed. */
+
+				if (this_domain->cpudata[cpuid].irq_pending_hi != 0
+				    && !test_bit(IPIPE_STALL_FLAG,
+						 &this_domain->cpudata[cpuid].status))
+					__ipipe_sync_stage(IPIPE_IRQMASK_ANY);
+			}
+
+			break;
+		} else if (next_domain == this_domain)
+			break;
+
+		pos = next_domain->p_link.next;
+	}
+}
+
+/*
+ * __ipipe_handle_irq() -- IPIPE's generic IRQ handler. An optimistic
+ * interrupt protection log is maintained here for each domain. Hw
+ * interrupts are off on entry.
+ */
+void __ipipe_handle_irq(int irq, struct pt_regs *regs)
+{
+	struct ipipe_domain *this_domain;
+	struct list_head *head, *pos;
+	ipipe_declare_cpuid;
+	int m_ack, s_ack;
+
+	m_ack = (regs == NULL);
+
+	if (irq >= IPIPE_NR_IRQS) {
+		printk(KERN_ERR "I-pipe: spurious interrupt %d\n", irq);
+		return;
+	}
+
+	ipipe_load_cpuid();
+
+	this_domain = ipipe_percpu_domain[cpuid];
+
+	s_ack = m_ack;
+
+	if (test_bit(IPIPE_STICKY_FLAG, &this_domain->irqs[irq].control))
+		head = &this_domain->p_link;
+	else
+		head = __ipipe_pipeline.next;
+
+	/* Ack the interrupt. */
+
+	pos = head;
+
+	while (pos != &__ipipe_pipeline) {
+		struct ipipe_domain *next_domain =
+			list_entry(pos, struct ipipe_domain, p_link);
+
+		/*
+		 * For each domain handling the incoming IRQ, mark it as
+		 * pending in its log.
+		 */
+		if (test_bit(IPIPE_HANDLE_FLAG,
+			     &next_domain->irqs[irq].control)) {
+			/*
+			 * Domains that handle this IRQ are polled for
+			 * acknowledging it by decreasing priority order. The
+			 * interrupt must be made pending _first_ in the
+			 * domain's status flags before the PIC is unlocked.
+			 */
+
+			next_domain->cpudata[cpuid].irq_hits[irq]++;
+			__ipipe_set_irq_bit(next_domain, cpuid, irq);
+			ipipe_mark_irq_receipt(next_domain, irq, cpuid);
+
+			/*
+			 * Always get the first master acknowledge available.
+			 * Once we've got it, allow slave acknowledge
+			 * handlers to run (until one of them stops us).
+			 */
+			if (next_domain->irqs[irq].acknowledge != NULL) {
+				if (!m_ack)
+					m_ack = next_domain->irqs[irq].acknowledge(irq);
+				else if (test_bit
+					 (IPIPE_SHARED_FLAG,
+					  &next_domain->irqs[irq].control) && !s_ack)
+					s_ack = next_domain->irqs[irq].acknowledge(irq);
+			}
+		}
+
+		/*
+		 * If the domain does not want the IRQ to be passed down the
+		 * interrupt pipe, exit the loop now.
+		 */
+
+		if (!test_bit(IPIPE_PASS_FLAG, &next_domain->irqs[irq].control))
+			break;
+
+		pos = next_domain->p_link.next;
+	}
+
+	/*
+	 * Now walk the pipeline, yielding control to the highest
+	 * priority domain that has pending interrupt(s) or
+	 * immediately to the current domain if the interrupt has been
+	 * marked as 'sticky'. This search does not go beyond the
+	 * current domain in the pipeline.
+	 */
+
+	__ipipe_walk_pipeline(head, cpuid);
+}
+
+asmlinkage int __ipipe_grab_irq(int irq, struct pt_regs *regs)
+{
+	ipipe_declare_cpuid;
+
+	if (irq == ipipe_mach_timerint) {
+
+		__ipipe_tick_regs[cpuid].ARM_cpsr = regs->ARM_cpsr;
+		__ipipe_tick_regs[cpuid].ARM_pc = regs->ARM_pc;
+
+		__ipipe_handle_irq(irq, regs);
+
+		ipipe_load_cpuid();
+
+		if (__ipipe_decr_ticks != ipipe_mach_ticks_per_jiffy) {
+			unsigned long long next_date, now;
+
+			next_date = __ipipe_decr_next[cpuid];
+
+			while ((now = __ipipe_read_timebase()) >= next_date)
+				next_date += __ipipe_decr_ticks;
+
+			ipipe_mach_set_dec(next_date - now);
+
+			__ipipe_decr_next[cpuid] = next_date;
+		}
+	}
+	else {
+		__ipipe_handle_irq(irq, regs);
+
+		ipipe_load_cpuid();
+	}
+
+	return (ipipe_percpu_domain[cpuid] == ipipe_root_domain &&
+		!test_bit(IPIPE_STALL_FLAG,
+			  &ipipe_root_domain->cpudata[cpuid].status));
+}
+
+asmlinkage int __ipipe_check_root(struct pt_regs *regs)
+{
+	ipipe_declare_cpuid;
+	/*
+	 * This routine is called with hw interrupts off, so no migration
+	 * can occur while checking the identity of the current domain.
+	 */
+	ipipe_load_cpuid();
+	return (ipipe_percpu_domain[cpuid] == ipipe_root_domain &&
+		!test_bit(IPIPE_STALL_FLAG,
+			  &ipipe_root_domain->cpudata[cpuid].status));
+}
+
+asmlinkage void __ipipe_stall_root_raw(void)
+{
+	ipipe_declare_cpuid;
+
+	ipipe_load_cpuid();	/* hw IRQs are off on entry. */
+
+	__set_bit(IPIPE_STALL_FLAG,
+		  &ipipe_root_domain->cpudata[cpuid].status);
+
+	ipipe_mark_domain_stall(ipipe_root_domain, cpuid);
+
+	local_irq_enable_hw();
+}
+
+asmlinkage void __ipipe_unstall_root_raw(void)
+{
+	ipipe_declare_cpuid;
+
+	local_irq_disable_hw();
+
+	ipipe_load_cpuid();
+
+	__clear_bit(IPIPE_STALL_FLAG,
+		    &ipipe_root_domain->cpudata[cpuid].status);
+
+	ipipe_mark_domain_unstall(ipipe_root_domain, cpuid);
+}
+
+asmlinkage int __ipipe_syscall_root(struct pt_regs *regs)
+{
+	ipipe_declare_cpuid;
+	unsigned long flags;
+
+	/*
+	 * This routine either returns:
+	 * 0 -- if the syscall is to be passed to Linux;
+	 * >0 -- if the syscall should not be passed to Linux, and no
+	 * tail work should be performed;
+	 * <0 -- if the syscall should not be passed to Linux but the
+	 * tail work has to be performed (for handling signals etc).
+	 */
+
+	if (__ipipe_event_monitors[IPIPE_EVENT_SYSCALL] > 0 &&
+	    __ipipe_dispatch_event(IPIPE_EVENT_SYSCALL,regs) > 0) {
+		/*
+		 * We might enter here over a non-root domain and exit
+		 * over the root one as a result of the syscall
+		 * (i.e. by recycling the register set of the current
+		 * context across the migration), so we need to fixup
+		 * the interrupt flag upon return too, so that
+		 * __ipipe_unstall_iret_root() resets the correct
+		 * stall bit on exit.
+		 */
+		if (ipipe_current_domain == ipipe_root_domain && !in_atomic()) {
+			/*
+			 * Sync pending VIRQs before _TIF_NEED_RESCHED
+			 * is tested.
+			 */
+			ipipe_lock_cpu(flags);
+			if ((ipipe_root_domain->cpudata[cpuid].irq_pending_hi & IPIPE_IRQMASK_VIRT) != 0)
+				__ipipe_sync_stage(IPIPE_IRQMASK_VIRT);
+			ipipe_unlock_cpu(flags);
+			return -1;
+		}
+		return 1;
+	}
+
+	return 0;
+}
diff -r 0e63a7fee245 include/asm-arm/hw_irq.h
--- /dev/null	Wed Nov 23 18:33:26 2005 +0200
+++ b/include/asm-arm/hw_irq.h	Thu Nov 24 12:56:06 2005 +0200
@@ -0,0 +1,6 @@
+#ifndef __ASM_ARM_HW_IRQ_H
+#define __ASM_ARM_HW_IRQ_H
+
+/* Dummy include. */
+
+#endif
diff -r 0e63a7fee245 include/asm-arm/ipipe.h
--- /dev/null	Wed Nov 23 18:33:26 2005 +0200
+++ b/include/asm-arm/ipipe.h	Thu Nov 24 12:56:06 2005 +0200
@@ -0,0 +1,161 @@
+/* -*- linux-c -*-
+ * include/asm-arm/ipipe.h
+ *
+ * Copyright (C) 2002-2005 Philippe Gerum.
+ * Copyright (C) 2005 Stelian Pop.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef __ARM_IPIPE_H
+#define __ARM_IPIPE_H
+
+#include <linux/config.h>
+
+#ifdef CONFIG_IPIPE
+
+#include <asm/ptrace.h>
+#include <asm/irq.h>
+#include <asm/bitops.h>
+#include <linux/list.h>
+#include <linux/cpumask.h>
+#include <linux/threads.h>
+
+#define IPIPE_ARCH_STRING	"1.0-06"
+#define IPIPE_MAJOR_NUMBER	1
+#define IPIPE_MINOR_NUMBER	0
+#define IPIPE_PATCH_NUMBER	6
+
+#define IPIPE_NR_XIRQS		NR_IRQS
+#define IPIPE_IRQ_ISHIFT	5	/* 2^5 for 32bits arch. */
+
+#ifdef CONFIG_SMP
+#error "I-pipe/arm: SMP not yet implemented"
+#define ipipe_processor_id()	(current_thread_info()->cpu)
+#else /* !CONFIG_SMP */
+#define ipipe_processor_id()	0
+#endif	/* CONFIG_SMP */
+
+#define prepare_arch_switch(next)				\
+do {								\
+	__ipipe_dispatch_event(IPIPE_EVENT_SCHEDULE,next);	\
+} while(0)
+
+#define task_hijacked(p)					\
+	( {							\
+	int x = ipipe_current_domain != ipipe_root_domain;	\
+	__clear_bit(IPIPE_SYNC_FLAG,				\
+		    &ipipe_root_domain->cpudata[task_cpu(p)].status); \
+	x;				\
+	} )
+
+/* ARM traps */
+#define IPIPE_TRAP_ACCESS	 0	/* Data or instruction access exception */
+#define IPIPE_NR_FAULTS		 1
+#if 0
+TODO
+#define IPIPE_TRAP_ALIGNMENT	 1	/* Alignment exception */
+#define IPIPE_TRAP_ALTUNAVAIL	 2	/* Altivec unavailable */
+#define IPIPE_TRAP_PCE		 3	/* Program check exception */
+#define IPIPE_TRAP_MCE		 4	/* Machine check exception */
+#define IPIPE_TRAP_UNKNOWN	 5	/* Unknown exception */
+#define IPIPE_TRAP_IABR		 6	/* Instruction breakpoint */
+#define IPIPE_TRAP_RM		 7	/* Run mode exception */
+#define IPIPE_TRAP_SSTEP	 8	/* Single-step exception */
+#define IPIPE_TRAP_NREC		 9	/* Non-recoverable exception */
+#define IPIPE_TRAP_SOFTEMU	10	/* Software emulation */
+#define IPIPE_TRAP_DEBUG	11	/* Debug exception */
+#define IPIPE_TRAP_SPE		12	/* SPE exception */
+#define IPIPE_TRAP_ALTASSIST	13	/* Altivec assist exception */
+#endif
+
+/* Pseudo-vectors used for kernel events */
+#define IPIPE_FIRST_EVENT	IPIPE_NR_FAULTS
+#define IPIPE_EVENT_SYSCALL	(IPIPE_FIRST_EVENT)
+#define IPIPE_EVENT_SCHEDULE	(IPIPE_FIRST_EVENT + 1)
+#define IPIPE_EVENT_SIGWAKE	(IPIPE_FIRST_EVENT + 2)
+#define IPIPE_EVENT_SETSCHED	(IPIPE_FIRST_EVENT + 3)
+#define IPIPE_EVENT_EXIT	(IPIPE_FIRST_EVENT + 4)
+#define IPIPE_LAST_EVENT	IPIPE_EVENT_EXIT
+#define IPIPE_NR_EVENTS		(IPIPE_LAST_EVENT + 1)
+
+struct ipipe_domain;
+
+struct ipipe_sysinfo {
+
+	int ncpus;		/* Number of CPUs on board */
+	u64 cpufreq;		/* CPU frequency (in Hz) */
+
+	/* Arch-dependent block */
+
+	struct {
+		unsigned tmirq;	/* Timer tick IRQ */
+		u64 tmfreq;	/* Timer frequency */
+	} archdep;
+};
+
+/* arch specific stuff */
+extern int ipipe_mach_timerint;
+extern int ipipe_mach_timerstolen;
+extern unsigned int ipipe_mach_ticks_per_jiffy;
+extern unsigned long long ipipe_mach_get_tsc(void);
+extern void ipipe_mach_set_dec(unsigned long);
+extern unsigned long ipipe_mach_get_dec(void);
+
+#define ipipe_read_tsc(t)		do { t = ipipe_mach_get_tsc(); } while (0)
+#define __ipipe_read_timebase()		( ipipe_mach_get_tsc() )
+
+#define ipipe_cpu_freq()	(HZ * ipipe_mach_ticks_per_jiffy)
+#define ipipe_tsc2ns(t)		(((t) * 1000) / (ipipe_cpu_freq() / 1000000))
+
+/* Private interface -- Internal use only */
+
+#define __ipipe_check_platform()	do { } while(0)
+
+void __ipipe_init_platform(void);
+
+void __ipipe_enable_pipeline(void);
+
+void __ipipe_sync_stage(unsigned long syncmask);
+
+int __ipipe_ack_irq(unsigned irq);
+
+void __ipipe_do_IRQ(int irq,
+		    struct pt_regs *regs);
+
+void __ipipe_do_timer(int irq,
+		      struct pt_regs *regs);
+
+void __ipipe_do_critical_sync(unsigned irq);
+
+extern unsigned long __ipipe_decr_ticks;
+
+extern unsigned long long __ipipe_decr_next[];
+
+extern struct pt_regs __ipipe_tick_regs[];
+
+void __ipipe_handle_irq(int irq,
+			struct pt_regs *regs);
+
+#define __ipipe_tick_irq	ipipe_timerint
+
+#else /* !CONFIG_IPIPE */
+
+#define task_hijacked(p)	0
+
+#endif /* CONFIG_IPIPE */
+
+#endif	/* !__ARM_IPIPE_H */

-- 
Stelian Pop <stelian@domain.hid>


