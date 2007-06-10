Message-ID: <305035a40706100515o13761d1fkea7b1932c7e65de3@domain.hid>
Date: Sun, 10 Jun 2007 14:15:24 +0200
From: "Gregory CLEMENT" <gclement00@domain.hid>
In-Reply-To: <18026.38832.965291.874125@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <403B28AE6257B548B66BB88414AC78330174BC34@domain.hid>
	<18025.37833.610273.790254@domain.hid>
	<305035a40706081335v5d49fde2i96dd8b2b0a22fb50@domain.hid>
	<18026.38832.965291.874125@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main]  AT91 patch duplicated code ...
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org, xenomai@xenomai.org

2007/6/9, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> Gregory CLEMENT wrote:
>  > 2007/6/8, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>  > > BOUIN Alexandre wrote:
>  > >  >
>  > >  > > When we released our last version of adeos-ipipe-2.6.19-arm-AT91.patch, we suggested to merge code for at91rm9200 and at91sam926x.
>  > >  > > These 2 code are split but quite similar, so we think it could be a good idea. Are you OK for removing duplicated code ?
>  > >
>  > > If I have to choose between duplicating some Linux code in I-pipe code
>  > > and have some duplication in the I-pipe patch, I choose duplication in
>  > > the I-pipe patch. If you duplicate Linux code, you will have to avoid
>  > > forgetting to update this duplicate code when Linux code evolves.
>  > >
>  >
>  > Well the first mail wasn't very clear. I am going to explain what we
>  > have in mind.
>  >
>  > In Linux code for AT91 timer there are two files: at91sam926x_time.c
>  > and at91rm9200_time.c because AT91RM9200 and AT91SAM926x have
>  > different system timer: AT91RM9200 use AT91_ST peripheral and
>  > AT91SAM926x use AT91_PIT peripheral.
>
> I was somehow thinking that there was something else in at91xx_time.c
> than what is enclosed in #ifdef CONFIG_IPIPE. I was wrong.
>
> Now, I have another question: is there no way to use the AT91_PIT
> peripheral in one shot mode ? What is the resolution of this PIT ?
>
> In any case, please send a patch, this will make a real base for
> discussion.

Here it is!
As I have no AT91 board at home, I just test that it compil without
error. But this patch is a good start for discussion.

-- 
Gregory CLEMENT
Adeneo
2, chemin du Ruisseau - BP21
69136 Ecully Cedex
France
Tel : +33-4 72 18 08 40


>From a5e44b874bbdb444115be753debbcc8f36edd7c5 Mon Sep 17 00:00:00 2001
From: Gregory CLEMENT <gclement00@domain.hid>
Date: Sun, 10 Jun 2007 13:05:26 +0200
Subject: [PATCH] Merge AT91RM200 and AT91SAM926x timer ipipe in only one file

---
 arch/arm/mach-at91rm9200/Makefile           |   16 +-
 arch/arm/mach-at91rm9200/at91ipipe_time.c   |  335 +++++++++++++++++++++++++++
 arch/arm/mach-at91rm9200/at91rm9200_time.c  |  295 +-----------------------
 arch/arm/mach-at91rm9200/at91sam926x_time.c |  312 -------------------------
 4 files changed, 349 insertions(+), 609 deletions(-)
 create mode 100644 arch/arm/mach-at91rm9200/at91ipipe_time.c

diff --git a/arch/arm/mach-at91rm9200/Makefile
b/arch/arm/mach-at91rm9200/Makefile
index cf77700..c3d00dc 100644
--- a/arch/arm/mach-at91rm9200/Makefile
+++ b/arch/arm/mach-at91rm9200/Makefile
@@ -10,9 +10,19 @@ obj-		:=
 obj-$(CONFIG_PM)		+= pm.o

 # CPU-specific support
-obj-$(CONFIG_ARCH_AT91RM9200)	+= at91rm9200.o at91rm9200_time.o
at91rm9200_devices.o
-obj-$(CONFIG_ARCH_AT91SAM9260)	+= at91sam9260.o at91sam926x_time.o
at91sam9260_devices.o
-obj-$(CONFIG_ARCH_AT91SAM9261)	+= at91sam9261.o at91sam926x_time.o
at91sam9261_devices.o
+obj-$(CONFIG_ARCH_AT91RM9200)   += at91rm9200.o at91rm9200_devices.o
+obj-$(CONFIG_ARCH_AT91SAM9260)  += at91sam9260.o at91sam9260_devices.o
+obj-$(CONFIG_ARCH_AT91SAM9261)  += at91sam9261.o at91sam9261_devices.o
+
+ifeq ($(CONFIG_IPIPE),y)
+obj-$(CONFIG_ARCH_AT91RM9200)   += at91ipipe_time.o
+obj-$(CONFIG_ARCH_AT91SAM9260)  += at91ipipe_time.o
+obj-$(CONFIG_ARCH_AT91SAM9261)  += at91ipipe_time.o
+else
+obj-$(CONFIG_ARCH_AT91RM9200)   += at91rm9200_time.o
+obj-$(CONFIG_ARCH_AT91SAM9260)  += at91sam926x_time.o
+obj-$(CONFIG_ARCH_AT91SAM9261)  += at91sam926x_time.o
+endif

 # AT91RM9200 board-specific support
 obj-$(CONFIG_MACH_ONEARM)	+= board-1arm.o
diff --git a/arch/arm/mach-at91rm9200/at91ipipe_time.c
b/arch/arm/mach-at91rm9200/at91ipipe_time.c
new file mode 100644
index 0000000..b236611
--- /dev/null
+++ b/arch/arm/mach-at91rm9200/at91ipipe_time.c
@@ -0,0 +1,335 @@
+/*
+ * linux/arch/arm/mach-at91rm9200/at91ipipe_time.c
+ *
+ * Copyright (C) 2007 Gregory CLEMENT, Adeneo
+ * based on at91rm9200_time.c patched by Gilles Chanteperdrix
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/time.h>
+
+#include <asm/hardware.h>
+#include <asm/io.h>
+#include <asm/mach/time.h>
+
+#include <asm/arch/at91_pit.h>
+
+static unsigned long last_crtr;
+
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/module.h>
+#include <asm/arch/at91_tc.h>
+#include "clock.h"
+
+#if defined(CONFIG_ARCH_AT91RM9200)
+#include <asm/arch/at91rm9200.h>
+#define AT91_ID_TC0 AT91RM9200_ID_TC0
+#define AT91_ID_TC1 AT91RM9200_ID_TC1
+#define AT91_ID_TC2 AT91RM9200_ID_TC2
+#elif defined(CONFIG_ARCH_AT91SAM9260)
+#include <asm/arch/at91sam9260.h>
+#define AT91_ID_TC0 AT91SAM9260_ID_TC0
+#define AT91_ID_TC1 AT91SAM9260_ID_TC1
+#define AT91_ID_TC2 AT91SAM9260_ID_TC2
+#elif defined(CONFIG_ARCH_AT91SAM9261)
+#include <asm/arch/at91sam9261.h>
+#define AT91_ID_TC0 AT91SAM9261_ID_TC0
+#define AT91_ID_TC1 AT91SAM9261_ID_TC1
+#define AT91_ID_TC2 AT91SAM9261_ID_TC2
+#else
+#error "Unsupported AT91 processor"
+#endif
+
+#ifdef CONFIG_NO_IDLE_HZ
+#error "dynamic tick timer not yet supported with IPIPE"
+#endif /* CONFIG_NO_IDLE_HZ */
+
+#define TCNXCNS(timer,v) ((v) << ((timer)<<1))
+#define AT91_TC_REG_MASK (0xffff)
+
+#if (CONFIG_IPIPE_AT91_TC==0)
+#   define KERNEL_TIMER_IRQ_NUM AT91_ID_TC0
+#elif (CONFIG_IPIPE_AT91_TC==1)
+#   define KERNEL_TIMER_IRQ_NUM AT91_ID_TC1
+#elif (CONFIG_IPIPE_AT91_TC==2)
+#   define KERNEL_TIMER_IRQ_NUM AT91_ID_TC2
+#else
+#error IPIPE_AT91_TC must be 0, 1 or 2.
+#endif
+
+static inline unsigned int at91_tc_read(unsigned int reg_offset)
+{
+	unsigned long addr =
+		(AT91_VA_BASE_TCB0 + 0x40 * CONFIG_IPIPE_AT91_TC);
+
+	return readl((void __iomem *)(addr + reg_offset));
+}
+
+static inline void at91_tc_write(unsigned int reg_offset, unsigned long value)
+{
+	unsigned long addr =
+		(AT91_VA_BASE_TCB0 + 0x40 * CONFIG_IPIPE_AT91_TC);
+
+	writel(value, (void __iomem *)(addr + reg_offset));
+}
+
+#define read_CV() at91_tc_read(AT91_TC_CV)
+#define read_RC() at91_tc_read(AT91_TC_RC)
+#define write_RC(value) at91_tc_write(AT91_TC_RC, value)
+
+int __ipipe_mach_timerint = KERNEL_TIMER_IRQ_NUM;
+EXPORT_SYMBOL(__ipipe_mach_timerint);
+
+int __ipipe_mach_timerstolen = 0;
+EXPORT_SYMBOL(__ipipe_mach_timerstolen);
+
+unsigned int __ipipe_mach_ticks_per_jiffy = LATCH;
+EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
+
+static int at91_timer_initialized;
+
+/*
+ * Returns number of microseconds since last timer interrupt.  Note
that interrupts
+ * will have been disabled by do_gettimeofday()
+ *  'LATCH' is hwclock ticks (see CLOCK_TICK_RATE in timex.h) per jiffy.
+*  'tick' is usecs per jiffy (linux/timex.h).
+ */
+static unsigned long at91ipipe_gettimeoffset(void)
+{
+	unsigned long elapsed;
+
+	elapsed = (read_CV() - last_crtr) & AT91_TC_REG_MASK;
+
+	return (unsigned long) (elapsed * (tick_nsec / 1000)) / LATCH;
+}
+
+void __ipipe_mach_acktimer(void)
+{
+	at91_tc_read(AT91_TC_SR);
+}
+
+/*
+ * IRQ handler for the timer.
+ */
+static irqreturn_t at91ipipe_timer_interrupt(int irq, void *dev_id)
+{
+	/*
+	 * - if Linux is running under ipipe, but it still has the control over
+	 *   the timer (no Xenomai for example), then reprogram the timer (ipipe
+	 *   has already acked it)
+	 * - if some other domain has taken over the timer, then do nothing
+	 *   (ipipe has acked it, and the other domain has reprogramed it)
+	 */
+
+	write_seqlock(&xtime_lock);
+
+	if (__ipipe_mach_timerstolen) {
+		timer_tick();
+		last_crtr = (last_crtr + LATCH) & AT91_TC_REG_MASK;
+	} else {
+		while (((read_CV() - last_crtr) & AT91_TC_REG_MASK) >= LATCH) {
+			timer_tick();
+			last_crtr = (last_crtr + LATCH) & AT91_TC_REG_MASK;
+		}
+		write_RC((last_crtr + LATCH) & AT91_TC_REG_MASK);
+	}
+
+	write_sequnlock(&xtime_lock);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t at91ipipe_bad_freq(int irq, void *dev_id)
+{
+	static int ticks = 0;
+
+	if (++ticks != HZ * 120) {
+		if (!console_drivers || try_acquire_console_sem())
+			return at91ipipe_timer_interrupt(irq, dev_id);
+	
+		release_console_sem();
+	}
+
+	panic("AT91 clock rate incorrectly set.\n"
+	      "Please recompile with IPIPE_AT91_MCK set to %lu Hz.",
+	      clk_get_rate(clk_get(NULL, "mck")));
+}
+
+union tsc_reg {
+#ifdef __BIG_ENDIAN
+	struct {
+		unsigned long high;
+		unsigned short mid;
+		unsigned short low;
+	};
+#else /* __LITTLE_ENDIAN */
+	struct {
+		unsigned short low;
+		unsigned short mid;
+		unsigned long high;
+	};
+#endif /* __LITTLE_ENDIAN */
+	unsigned long long full;
+};
+
+#ifdef CONFIG_SMP
+static union tsc_reg tsc[NR_CPUS];
+
+void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
+{
+	info->type = IPIPE_TSC_TYPE_NONE;
+}
+
+#else /* !CONFIG_SMP */
+static union tsc_reg *tsc;
+
+void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
+{
+	info->type = IPIPE_TSC_TYPE_FREERUNNING;
+	info->u.fr.counter =
+		(unsigned *)
+		(AT91_BASE_TCB0 + 0x40 * CONFIG_IPIPE_AT91_TC + AT91_TC_CV);
+	info->u.fr.mask = AT91_TC_REG_MASK;
+	info->u.fr.tsc = &tsc->full;
+}
+#endif /* !CONFIG_SMP */
+
+notrace unsigned long long __ipipe_mach_get_tsc(void)
+{
+	if (likely(at91_timer_initialized)) {
+		union tsc_reg *local_tsc;
+		unsigned long long result;
+		unsigned short stamp;
+		unsigned long flags;
+
+		local_irq_save_hw_notrace(flags);
+		local_tsc = &tsc[ipipe_processor_id()];
+		stamp = read_CV();
+		if (unlikely(stamp < local_tsc->low)) {
+			if (unlikely(!++local_tsc->mid))
+				/* 32 bit counter wrapped, increment high word. */
+				local_tsc->high++;
+		}
+		local_tsc->low = stamp;
+		result = local_tsc->full;
+		local_irq_restore_hw_notrace(flags);
+
+		return result;
+	}
+	
+        return 0;
+}
+EXPORT_SYMBOL(__ipipe_mach_get_tsc);
+
+/*
+ * Reprogram the timer
+ */
+
+void __ipipe_mach_set_dec(unsigned long delay)
+{
+	unsigned long flags;
+
+	if (delay > 2) {
+		local_irq_save_hw(flags);
+		write_RC((read_CV() + delay) & AT91_TC_REG_MASK);
+		local_irq_restore_hw(flags);
+	} else
+		ipipe_trigger_irq(KERNEL_TIMER_IRQ_NUM);
+}
+EXPORT_SYMBOL(__ipipe_mach_set_dec);
+
+void __ipipe_mach_release_timer(void)
+{
+       __ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
+}
+EXPORT_SYMBOL(__ipipe_mach_release_timer);
+
+unsigned long __ipipe_mach_get_dec(void)
+{
+	return (read_RC() - read_CV()) & AT91_TC_REG_MASK;
+}
+
+static struct irqaction at91ipipe_timer_irq = {
+	.name		= "at91_tick",
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.handler	= &at91ipipe_timer_interrupt
+};
+
+static char clk_name [] = "tc%";
+
+static struct clk tc = {
+	.name		= (const char *) clk_name,
+	.users          = 0,
+	.type		= CLK_TYPE_PERIPHERAL,
+	.pmc_mask       = 1 << (KERNEL_TIMER_IRQ_NUM),
+};
+
+void __init at91ipipe_timer_init(void)
+{
+	unsigned long v;
+	
+	if (clk_get_rate(clk_get(NULL, "mck")) != CONFIG_IPIPE_AT91_MCK)
+		at91ipipe_timer_irq.handler = &at91ipipe_bad_freq;
+
+	snprintf(clk_name, sizeof(clk_name), "tc%d", CONFIG_IPIPE_AT91_TC);
+	clk_register(&tc);
+	clk_enable(&tc);
+	
+	/* No Sync. */
+	at91_tc_write(AT91_TC_BCR, 0);
+
+	/* program NO signal on XCN */
+	v = readl((void __iomem *) (AT91_VA_BASE_TCB0 + AT91_TC_BMR));
+	v &= ~TCNXCNS(CONFIG_IPIPE_AT91_TC, 3);
+	v |= TCNXCNS(CONFIG_IPIPE_AT91_TC, 1); /* AT91_TC_TCNXCNS_NONE */
+	writel(v, (void __iomem *) (AT91_VA_BASE_TCB0 + AT91_TC_BMR));
+
+	/* Disable the channel */
+	at91_tc_write(AT91_TC_CCR, AT91_TC_CLKDIS);
+
+	/* Select TIMER_CLOCK3 (MCLK/32) as input frequency for TC. */
+	at91_tc_write(AT91_TC_CMR, AT91_TC_TIMER_CLOCK3);
+
+	/* Disable all interrupts. */
+	at91_tc_write(AT91_TC_IDR, ~0ul);
+
+	/* Load the TC register C. */
+	last_crtr = 0;
+	write_RC(LATCH);
+
+	/* Enable CPCS interrupt. */
+	at91_tc_write(AT91_TC_IER, AT91_TC_CPCS);
+
+	/* Set up the interrupt. */
+	setup_irq(KERNEL_TIMER_IRQ_NUM, &at91ipipe_timer_irq);
+
+	/* Enable the channel. */
+	at91_tc_write(AT91_TC_CCR, AT91_TC_CLKEN | AT91_TC_SWTRG);
+
+#ifndef CONFIG_SMP
+	tsc = (union tsc_reg *) __ipipe_tsc_area;
+	barrier();
+#endif /* CONFIG_SMP */
+
+	at91_timer_initialized = 1;
+}
+
+#ifdef CONFIG_ARCH_AT91RM9200
+struct sys_timer at91rm9200_timer = {
+#else
+struct sys_timer at91sam926x_timer = {
+#endif
+	.init		= at91ipipe_timer_init,
+	.offset		= at91ipipe_gettimeoffset,
+	.suspend	= NULL,
+	.resume		= NULL,
+};
diff --git a/arch/arm/mach-at91rm9200/at91rm9200_time.c
b/arch/arm/mach-at91rm9200/at91rm9200_time.c
index f751bd5..b999e19 100644
--- a/arch/arm/mach-at91rm9200/at91rm9200_time.c
+++ b/arch/arm/mach-at91rm9200/at91rm9200_time.c
@@ -34,62 +34,6 @@

 static unsigned long last_crtr;

-#ifdef CONFIG_IPIPE
-#include <linux/clk.h>
-#include <linux/console.h>
-#include <linux/module.h>
-#include <asm/arch/at91_tc.h>
-#include "clock.h"
-
-#ifdef CONFIG_NO_IDLE_HZ
-#error "dynamic tick timer not yet supported with IPIPE"
-#endif /* CONFIG_NO_IDLE_HZ */
-
-#define TCNXCNS(timer,v) ((v) << ((timer)<<1))
-#define AT91_TC_REG_MASK (0xffff)
-
-#if (CONFIG_IPIPE_AT91_TC==0)
-#   define KERNEL_TIMER_IRQ_NUM AT91RM9200_ID_TC0
-#elif (CONFIG_IPIPE_AT91_TC==1)
-#   define KERNEL_TIMER_IRQ_NUM AT91RM9200_ID_TC1
-#elif (CONFIG_IPIPE_AT91_TC==2)
-#   define KERNEL_TIMER_IRQ_NUM AT91RM9200_ID_TC2
-#else
-#error IPIPE_AT91_TC must be 0, 1 or 2.
-#endif
-
-static inline unsigned int at91_tc_read(unsigned int reg_offset)
-{
-	unsigned long addr =
-		(AT91_VA_BASE_TCB0 + 0x40 * CONFIG_IPIPE_AT91_TC);
-
-	return readl((void __iomem *)(addr + reg_offset));
-}
-
-static inline void at91_tc_write(unsigned int reg_offset, unsigned long value)
-{
-	unsigned long addr =
-		(AT91_VA_BASE_TCB0 + 0x40 * CONFIG_IPIPE_AT91_TC);
-
-	writel(value, (void __iomem *)(addr + reg_offset));
-}
-
-#define read_CV() at91_tc_read(AT91_TC_CV)
-#define read_RC() at91_tc_read(AT91_TC_RC)
-#define write_RC(value) at91_tc_write(AT91_TC_RC, value)
-
-int __ipipe_mach_timerint = KERNEL_TIMER_IRQ_NUM;
-EXPORT_SYMBOL(__ipipe_mach_timerint);
-
-int __ipipe_mach_timerstolen = 0;
-EXPORT_SYMBOL(__ipipe_mach_timerstolen);
-
-unsigned int __ipipe_mach_ticks_per_jiffy = LATCH;
-EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
-
-static int at91_timer_initialized;
-#endif /* CONFIG_IPIPE */
-
 /*
  * The ST_CRTR is updated asynchronously to the master clock.  It is therefore
  *  necessary to read it twice (with the same value) to ensure accuracy.
@@ -97,16 +41,14 @@ static int at91_timer_initialized;
 static inline unsigned long read_CRTR(void) {
 	unsigned long x1, x2;

-	x2 = at91_sys_read(AT91_ST_CRTR);
 	do {
-		x1 = x2;
+		x1 = at91_sys_read(AT91_ST_CRTR);
 		x2 = at91_sys_read(AT91_ST_CRTR);
 	} while (x1 != x2);

 	return x1;
 }

-#ifndef CONFIG_IPIPE
 /*
  * Returns number of microseconds since last timer interrupt.  Note
that interrupts
  * will have been disabled by do_gettimeofday()
@@ -202,238 +144,3 @@ struct sys_timer at91rm9200_timer = {
 	.resume		= at91rm9200_timer_reset,
 };

-#else /* CONFIG_IPIPE */
-
-/*
- * Returns number of microseconds since last timer interrupt.  Note
that interrupts
- * will have been disabled by do_gettimeofday()
- *  'LATCH' is hwclock ticks (see CLOCK_TICK_RATE in timex.h) per jiffy.
- *  'tick' is usecs per jiffy (linux/timex.h).
- */
-static unsigned long at91rm9200_gettimeoffset(void)
-{
-	unsigned long elapsed;
-
-	elapsed = (read_CV() - last_crtr) & AT91_TC_REG_MASK;
-
-	return (unsigned long) (elapsed * (tick_nsec / 1000)) / LATCH;
-}
-
-void __ipipe_mach_acktimer(void)
-{
-	at91_tc_read(AT91_TC_SR);
-}
-
-/*
- * IRQ handler for the timer.
- */
-static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
-{
-	/*
-	 * - if Linux is running under ipipe, but it still has the control over
-	 *   the timer (no Xenomai for example), then reprogram the timer (ipipe
-	 *   has already acked it)
-	 * - if some other domain has taken over the timer, then do nothing
-	 *   (ipipe has acked it, and the other domain has reprogramed it)
-	 */
-
-	write_seqlock(&xtime_lock);
-
-	if (__ipipe_mach_timerstolen) {
-		timer_tick();
-		last_crtr = (last_crtr + LATCH) & AT91_TC_REG_MASK;
-	} else {
-		while (((read_CV() - last_crtr) & AT91_TC_REG_MASK) >= LATCH) {
-			timer_tick();
-			last_crtr = (last_crtr + LATCH) & AT91_TC_REG_MASK;
-		}
-		write_RC((last_crtr + LATCH) & AT91_TC_REG_MASK);
-	}
-
-	write_sequnlock(&xtime_lock);
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t at91rm9200_bad_freq(int irq, void *dev_id)
-{
-	static int ticks = 0;
-
-	if (++ticks != HZ * 120) {
-		if (!console_drivers || try_acquire_console_sem())
-			return at91rm9200_timer_interrupt(irq, dev_id);
-	
-		release_console_sem();
-	}
-
-	panic("AT91 clock rate incorrectly set.\n"
-	      "Please recompile with IPIPE_AT91_MCK set to %lu Hz.",
-	      clk_get_rate(clk_get(NULL, "mck")));
-}
-
-union tsc_reg {
-#ifdef __BIG_ENDIAN
-	struct {
-		unsigned long high;
-		unsigned short mid;
-		unsigned short low;
-	};
-#else /* __LITTLE_ENDIAN */
-	struct {
-		unsigned short low;
-		unsigned short mid;
-		unsigned long high;
-	};
-#endif /* __LITTLE_ENDIAN */
-	unsigned long long full;
-};
-
-#ifdef CONFIG_SMP
-static union tsc_reg tsc[NR_CPUS];
-
-void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
-{
-	info->type = IPIPE_TSC_TYPE_NONE;
-}
-
-#else /* !CONFIG_SMP */
-static union tsc_reg *tsc;
-
-void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
-{
-	info->type = IPIPE_TSC_TYPE_FREERUNNING;
-	info->u.fr.counter =
-		(unsigned *)
-		(AT91_BASE_TCB0 + 0x40 * CONFIG_IPIPE_AT91_TC + AT91_TC_CV);
-	info->u.fr.mask = AT91_TC_REG_MASK;
-	info->u.fr.tsc = &tsc->full;
-}
-#endif /* !CONFIG_SMP */
-
-notrace unsigned long long __ipipe_mach_get_tsc(void)
-{
-	if (likely(at91_timer_initialized)) {
-		unsigned long long result;
-		union tsc_reg *local_tsc;
-		unsigned short stamp;
-		unsigned long flags;
-
-		local_irq_save_hw_notrace(flags);
-		local_tsc = &tsc[ipipe_processor_id()];
-		stamp = read_CV();
-		if (unlikely(stamp < local_tsc->low)) {
-			if (unlikely(!++local_tsc->mid))
-				/* 32 bit counter wrapped, increment high word. */
-				local_tsc->high++;
-		}
-		local_tsc->low = stamp;
-		result = local_tsc->full;
-		local_irq_restore_hw_notrace(flags);
-
-		return result;
-	}
-	
-        return 0;
-}
-EXPORT_SYMBOL(__ipipe_mach_get_tsc);
-
-/*
- * Reprogram the timer
- */
-
-void __ipipe_mach_set_dec(unsigned long delay)
-{
-	unsigned long flags;
-
-	if (delay > 2) {
-		local_irq_save_hw(flags);
-		write_RC((read_CV() + delay) & AT91_TC_REG_MASK);
-		local_irq_restore_hw(flags);
-	} else
-		ipipe_trigger_irq(KERNEL_TIMER_IRQ_NUM);
-}
-EXPORT_SYMBOL(__ipipe_mach_set_dec);
-
-void __ipipe_mach_release_timer(void)
-{
-       __ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
-}
-EXPORT_SYMBOL(__ipipe_mach_release_timer);
-
-unsigned long __ipipe_mach_get_dec(void)
-{
-	return (read_RC() - read_CV()) & AT91_TC_REG_MASK;
-}
-
-static struct irqaction at91rm9200_timer_irq = {
-	.name		= "at91_tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER,
-	.handler	= &at91rm9200_timer_interrupt
-};
-
-static char clk_name [] = "tc%";
-
-static struct clk tc = {
-	.name		= (const char *) clk_name,
-	.users          = 0,
-	.type		= CLK_TYPE_PERIPHERAL,
-	.pmc_mask       = 1 << (KERNEL_TIMER_IRQ_NUM),
-};
-
-void __init at91rm9200_timer_init(void)
-{
-	unsigned long v;
-	
-	if (clk_get_rate(clk_get(NULL, "mck")) != CONFIG_IPIPE_AT91_MCK)
-		at91rm9200_timer_irq.handler = &at91rm9200_bad_freq;
-
-	snprintf(clk_name, sizeof(clk_name), "tc%d", CONFIG_IPIPE_AT91_TC);
-	clk_register(&tc);
-	clk_enable(&tc);
-	
-	/* No Sync. */
-	at91_tc_write(AT91_TC_BCR, 0);
-
-	/* program NO signal on XCN */
-	v = readl((void __iomem *) (AT91_VA_BASE_TCB0 + AT91_TC_BMR));
-	v &= ~TCNXCNS(CONFIG_IPIPE_AT91_TC, 3);
-	v |= TCNXCNS(CONFIG_IPIPE_AT91_TC, 1); /* AT91_TC_TCNXCNS_NONE */
-	writel(v, (void __iomem *) (AT91_VA_BASE_TCB0 + AT91_TC_BMR));
-
-	/* Disable the channel */
-	at91_tc_write(AT91_TC_CCR, AT91_TC_CLKDIS);
-
-	/* Select TIMER_CLOCK3 (MCLK/32) as input frequency for TC. */
-	at91_tc_write(AT91_TC_CMR, AT91_TC_TIMER_CLOCK3);
-
-	/* Disable all interrupts. */
-	at91_tc_write(AT91_TC_IDR, ~0ul);
-
-	/* Load the TC register C. */
-	last_crtr = 0;
-	write_RC(LATCH);
-
-	/* Enable CPCS interrupt. */
-	at91_tc_write(AT91_TC_IER, AT91_TC_CPCS);
-
-	/* Set up the interrupt. */
-	setup_irq(KERNEL_TIMER_IRQ_NUM, &at91rm9200_timer_irq);
-
-	/* Enable the channel. */
-	at91_tc_write(AT91_TC_CCR, AT91_TC_CLKEN | AT91_TC_SWTRG);
-
-#ifndef CONFIG_SMP
-	tsc = (union tsc_reg *) __ipipe_tsc_area;
-	barrier();
-#endif /* CONFIG_SMP */
-
-	at91_timer_initialized = 1;
-}
-
-struct sys_timer at91rm9200_timer = {
-	.init		= at91rm9200_timer_init,
-	.offset		= at91rm9200_gettimeoffset,
-	.suspend	= NULL,
-	.resume		= NULL,
-};
-#endif /* CONFIG_IPIPE */
diff --git a/arch/arm/mach-at91rm9200/at91sam926x_time.c
b/arch/arm/mach-at91rm9200/at91sam926x_time.c
index e4c4440..99df5f6 100644
--- a/arch/arm/mach-at91rm9200/at91sam926x_time.c
+++ b/arch/arm/mach-at91rm9200/at91sam926x_time.c
@@ -22,87 +22,10 @@

 #include <asm/arch/at91_pit.h>

-static unsigned long last_crtr;
-
-#ifdef CONFIG_IPIPE
-#include <linux/clk.h>
-#include <linux/console.h>
-#include <linux/module.h>
-#include <asm/arch/at91_tc.h>
-#include "clock.h"
-
-#if defined(CONFIG_ARCH_AT91RM9200)
-#include <asm/arch/at91rm9200.h>
-#define AT91_ID_TC0 AT91RM9200_ID_TC0
-#define AT91_ID_TC1 AT91RM9200_ID_TC1
-#define AT91_ID_TC2 AT91RM9200_ID_TC2
-#elif defined(CONFIG_ARCH_AT91SAM9260)
-#include <asm/arch/at91sam9260.h>
-#define AT91_ID_TC0 AT91SAM9260_ID_TC0
-#define AT91_ID_TC1 AT91SAM9260_ID_TC1
-#define AT91_ID_TC2 AT91SAM9260_ID_TC2
-#elif defined(CONFIG_ARCH_AT91SAM9261)
-#include <asm/arch/at91sam9261.h>
-#define AT91_ID_TC0 AT91SAM9261_ID_TC0
-#define AT91_ID_TC1 AT91SAM9261_ID_TC1
-#define AT91_ID_TC2 AT91SAM9261_ID_TC2
-#else
-#error "Unsupported AT91 processor"
-#endif
-
-#ifdef CONFIG_NO_IDLE_HZ
-#error "dynamic tick timer not yet supported with IPIPE"
-#endif /* CONFIG_NO_IDLE_HZ */
-
-#define TCNXCNS(timer,v) ((v) << ((timer)<<1))
-#define AT91_TC_REG_MASK (0xffff)
-
-#if (CONFIG_IPIPE_AT91_TC==0)
-#   define KERNEL_TIMER_IRQ_NUM AT91_ID_TC0
-#elif (CONFIG_IPIPE_AT91_TC==1)
-#   define KERNEL_TIMER_IRQ_NUM AT91_ID_TC1
-#elif (CONFIG_IPIPE_AT91_TC==2)
-#   define KERNEL_TIMER_IRQ_NUM AT91_ID_TC2
-#else
-#error IPIPE_AT91_TC must be 0, 1 or 2.
-#endif
-
-static inline unsigned int at91_tc_read(unsigned int reg_offset)
-{
-	unsigned long addr =
-		(AT91_VA_BASE_TCB0 + 0x40 * CONFIG_IPIPE_AT91_TC);
-
-	return readl((void __iomem *)(addr + reg_offset));
-}
-
-static inline void at91_tc_write(unsigned int reg_offset, unsigned long value)
-{
-	unsigned long addr =
-		(AT91_VA_BASE_TCB0 + 0x40 * CONFIG_IPIPE_AT91_TC);
-
-	writel(value, (void __iomem *)(addr + reg_offset));
-}
-
-#define read_CV() at91_tc_read(AT91_TC_CV)
-#define read_RC() at91_tc_read(AT91_TC_RC)
-#define write_RC(value) at91_tc_write(AT91_TC_RC, value)
-
-int __ipipe_mach_timerint = KERNEL_TIMER_IRQ_NUM;
-EXPORT_SYMBOL(__ipipe_mach_timerint);
-
-int __ipipe_mach_timerstolen = 0;
-EXPORT_SYMBOL(__ipipe_mach_timerstolen);
-
-unsigned int __ipipe_mach_ticks_per_jiffy = LATCH;
-EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);
-
-static int at91_timer_initialized;
-#endif /* CONFIG_IPIPE */

 #define PIT_CPIV(x)	((x) & AT91_PIT_CPIV)
 #define PIT_PICNT(x)	(((x) & AT91_PIT_PICNT) >> 20)

-#ifndef CONFIG_IPIPE
 /*
  * Returns number of microseconds since last timer interrupt.  Note
that interrupts
  * will have been disabled by do_gettimeofday()
@@ -189,238 +112,3 @@ struct sys_timer at91sam926x_timer = {
 	.resume		= at91sam926x_timer_reset,
 };

-#else /* CONFIG_IPIPE */
-
-/*
- * Returns number of microseconds since last timer interrupt.  Note
that interrupts
- * will have been disabled by do_gettimeofday()
- *  'LATCH' is hwclock ticks (see CLOCK_TICK_RATE in timex.h) per jiffy.
-*  'tick' is usecs per jiffy (linux/timex.h).
- */
-static unsigned long at91sam926x_gettimeoffset(void)
-{
-	unsigned long elapsed;
-
-	elapsed = (read_CV() - last_crtr) & AT91_TC_REG_MASK;
-
-	return (unsigned long) (elapsed * (tick_nsec / 1000)) / LATCH;
-}
-
-void __ipipe_mach_acktimer(void)
-{
-	at91_tc_read(AT91_TC_SR);
-}
-
-/*
- * IRQ handler for the timer.
- */
-static irqreturn_t at91sam926x_timer_interrupt(int irq, void *dev_id)
-{
-	/*
-	 * - if Linux is running under ipipe, but it still has the control over
-	 *   the timer (no Xenomai for example), then reprogram the timer (ipipe
-	 *   has already acked it)
-	 * - if some other domain has taken over the timer, then do nothing
-	 *   (ipipe has acked it, and the other domain has reprogramed it)
-	 */
-
-	write_seqlock(&xtime_lock);
-
-	if (__ipipe_mach_timerstolen) {
-		timer_tick();
-		last_crtr = (last_crtr + LATCH) & AT91_TC_REG_MASK;
-	} else {
-		while (((read_CV() - last_crtr) & AT91_TC_REG_MASK) >= LATCH) {
-			timer_tick();
-			last_crtr = (last_crtr + LATCH) & AT91_TC_REG_MASK;
-		}
-		write_RC((last_crtr + LATCH) & AT91_TC_REG_MASK);
-	}
-
-	write_sequnlock(&xtime_lock);
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t at91sam926x_bad_freq(int irq, void *dev_id)
-{
-	static int ticks = 0;
-
-	if (++ticks != HZ * 120) {
-		if (!console_drivers || try_acquire_console_sem())
-			return at91sam926x_timer_interrupt(irq, dev_id);
-	
-		release_console_sem();
-	}
-
-	panic("AT91 clock rate incorrectly set.\n"
-	      "Please recompile with IPIPE_AT91_MCK set to %lu Hz.",
-	      clk_get_rate(clk_get(NULL, "mck")));
-}
-
-union tsc_reg {
-#ifdef __BIG_ENDIAN
-	struct {
-		unsigned long high;
-		unsigned short mid;
-		unsigned short low;
-	};
-#else /* __LITTLE_ENDIAN */
-	struct {
-		unsigned short low;
-		unsigned short mid;
-		unsigned long high;
-	};
-#endif /* __LITTLE_ENDIAN */
-	unsigned long long full;
-};
-
-#ifdef CONFIG_SMP
-static union tsc_reg tsc[NR_CPUS];
-
-void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
-{
-	info->type = IPIPE_TSC_TYPE_NONE;
-}
-
-#else /* !CONFIG_SMP */
-static union tsc_reg *tsc;
-
-void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
-{
-	info->type = IPIPE_TSC_TYPE_FREERUNNING;
-	info->u.fr.counter =
-		(unsigned *)
-		(AT91_BASE_TCB0 + 0x40 * CONFIG_IPIPE_AT91_TC + AT91_TC_CV);
-	info->u.fr.mask = AT91_TC_REG_MASK;
-	info->u.fr.tsc = &tsc->full;
-}
-#endif /* !CONFIG_SMP */
-
-notrace unsigned long long __ipipe_mach_get_tsc(void)
-{
-	if (likely(at91_timer_initialized)) {
-		union tsc_reg *local_tsc;
-		unsigned long long result;
-		unsigned short stamp;
-		unsigned long flags;
-
-		local_irq_save_hw_notrace(flags);
-		local_tsc = &tsc[ipipe_processor_id()];
-		stamp = read_CV();
-		if (unlikely(stamp < local_tsc->low)) {
-			if (unlikely(!++local_tsc->mid))
-				/* 32 bit counter wrapped, increment high word. */
-				local_tsc->high++;
-		}
-		local_tsc->low = stamp;
-		result = local_tsc->full;
-		local_irq_restore_hw_notrace(flags);
-
-		return result;
-	}
-	
-        return 0;
-}
-EXPORT_SYMBOL(__ipipe_mach_get_tsc);
-
-/*
- * Reprogram the timer
- */
-
-void __ipipe_mach_set_dec(unsigned long delay)
-{
-	unsigned long flags;
-
-	if (delay > 2) {
-		local_irq_save_hw(flags);
-		write_RC((read_CV() + delay) & AT91_TC_REG_MASK);
-		local_irq_restore_hw(flags);
-	} else
-		ipipe_trigger_irq(KERNEL_TIMER_IRQ_NUM);
-}
-EXPORT_SYMBOL(__ipipe_mach_set_dec);
-
-void __ipipe_mach_release_timer(void)
-{
-       __ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
-}
-EXPORT_SYMBOL(__ipipe_mach_release_timer);
-
-unsigned long __ipipe_mach_get_dec(void)
-{
-	return (read_RC() - read_CV()) & AT91_TC_REG_MASK;
-}
-
-static struct irqaction at91sam926x_timer_irq = {
-	.name		= "at91_tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER,
-	.handler	= &at91sam926x_timer_interrupt
-};
-
-static char clk_name [] = "tc%";
-
-static struct clk tc = {
-	.name		= (const char *) clk_name,
-	.users          = 0,
-	.type		= CLK_TYPE_PERIPHERAL,
-	.pmc_mask       = 1 << (KERNEL_TIMER_IRQ_NUM),
-};
-
-void __init at91sam926x_timer_init(void)
-{
-	unsigned long v;
-	
-	if (clk_get_rate(clk_get(NULL, "mck")) != CONFIG_IPIPE_AT91_MCK)
-		at91sam926x_timer_irq.handler = &at91sam926x_bad_freq;
-
-	snprintf(clk_name, sizeof(clk_name), "tc%d", CONFIG_IPIPE_AT91_TC);
-	clk_register(&tc);
-	clk_enable(&tc);
-	
-	/* No Sync. */
-	at91_tc_write(AT91_TC_BCR, 0);
-
-	/* program NO signal on XCN */
-	v = readl((void __iomem *) (AT91_VA_BASE_TCB0 + AT91_TC_BMR));
-	v &= ~TCNXCNS(CONFIG_IPIPE_AT91_TC, 3);
-	v |= TCNXCNS(CONFIG_IPIPE_AT91_TC, 1); /* AT91_TC_TCNXCNS_NONE */
-	writel(v, (void __iomem *) (AT91_VA_BASE_TCB0 + AT91_TC_BMR));
-
-	/* Disable the channel */
-	at91_tc_write(AT91_TC_CCR, AT91_TC_CLKDIS);
-
-	/* Select TIMER_CLOCK3 (MCLK/32) as input frequency for TC. */
-	at91_tc_write(AT91_TC_CMR, AT91_TC_TIMER_CLOCK3);
-
-	/* Disable all interrupts. */
-	at91_tc_write(AT91_TC_IDR, ~0ul);
-
-	/* Load the TC register C. */
-	last_crtr = 0;
-	write_RC(LATCH);
-
-	/* Enable CPCS interrupt. */
-	at91_tc_write(AT91_TC_IER, AT91_TC_CPCS);
-
-	/* Set up the interrupt. */
-	setup_irq(KERNEL_TIMER_IRQ_NUM, &at91sam926x_timer_irq);
-
-	/* Enable the channel. */
-	at91_tc_write(AT91_TC_CCR, AT91_TC_CLKEN | AT91_TC_SWTRG);
-
-#ifndef CONFIG_SMP
-	tsc = (union tsc_reg *) __ipipe_tsc_area;
-	barrier();
-#endif /* CONFIG_SMP */
-
-	at91_timer_initialized = 1;
-}
-
-struct sys_timer at91sam926x_timer = {
-	.init		= at91sam926x_timer_init,
-	.offset		= at91sam926x_gettimeoffset,
-	.suspend	= NULL,
-	.resume		= NULL,
-};
-#endif /* CONFIG_IPIPE */
-- 
1.5.2.1

