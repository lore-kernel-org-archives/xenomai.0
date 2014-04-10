Message-ID: <1397169248.6356.15.camel@localhost.localdomain>
From: Peter Howard <pjh@northern-ridge.com.au>
Date: Fri, 11 Apr 2014 08:34:08 +1000
In-Reply-To: <534719F5.2020605@xenomai.org>
References: <1396407588.27578.5.camel@localhost.localdomain>
 <533BBB11.5090808@xenomai.org>
 <1396848843.2481.15.camel@localhost.localdomain>
 <5343BEFB.7050402@xenomai.org>
 <1396999856.2660.7.camel@localhost.localdomain>
 <53449244.8040502@xenomai.org>
 <1397003664.2660.14.camel@localhost.localdomain>
 <1397017658.2660.16.camel@localhost.localdomain>
 <534534FD.5090805@xenomai.org>
 <1397113300.2720.5.camel@localhost.localdomain>
 <5346895B.6080401@xenomai.org>
 <1397159850.2881.3.camel@localhost.localdomain>
 <53471389.6000000@xenomai.org>
 <1397168263.6356.11.camel@localhost.localdomain>
 <534719F5.2020605@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] OMAP L138
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, 2014-04-11 at 00:23 +0200, Gilles Chanteperdrix wrote:
(Stripping back conversation on this one - apologies if that's bad
etiquette for this list)
 
> Attachment is better. Also please post the changes you made for omapL138
> 

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index a075b3e..3d8bc59 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -41,6 +41,8 @@ config ARCH_DAVINCI_DA850
 	select ARCH_DAVINCI_DA8XX
 	select ARCH_HAS_CPUFREQ
 	select CP_INTC
+    select IPIPE_ARM_KUSER_TSC if IPIPE
+    select ARM_FCSE if IPIPE
 
 config ARCH_DAVINCI_DA8XX
 	bool
diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 006dae8..61fa26f 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/ipipe.h>
 
 #include <mach/common.h>
 #include <mach/cp_intc.h>
@@ -39,6 +40,7 @@ static void cp_intc_ack_irq(struct irq_data *d)
 /* Disable interrupt */
 static void cp_intc_mask_irq(struct irq_data *d)
 {
+	ipipe_lock_irq(d->irq);
 	/* XXX don't know why we need to disable nIRQ here... */
 	cp_intc_write(1, CP_INTC_HOST_ENABLE_IDX_CLR);
 	cp_intc_write(d->hwirq, CP_INTC_SYS_ENABLE_IDX_CLR);
@@ -49,8 +51,25 @@ static void cp_intc_mask_irq(struct irq_data *d)
 static void cp_intc_unmask_irq(struct irq_data *d)
 {
 	cp_intc_write(d->hwirq, CP_INTC_SYS_ENABLE_IDX_SET);
+	ipipe_unlock_irq(d->irq);
 }
 
+#ifdef CONFIG_IPIPE
+/* Hold and release without irq locking */
+static void cp_intc_hold_irq(struct irq_data *d)
+{
+	/* XXX don't know why we need to disable nIRQ here... */
+	cp_intc_write(1, CP_INTC_HOST_ENABLE_IDX_CLR);
+	cp_intc_write(d->hwirq, CP_INTC_SYS_ENABLE_IDX_CLR);
+	cp_intc_write(1, CP_INTC_HOST_ENABLE_IDX_SET);
+}
+
+static void cp_intc_release_irq(struct irq_data *d)
+{
+	cp_intc_write(d->hwirq, CP_INTC_SYS_ENABLE_IDX_SET);
+}
+#endif /* CONFIG_IPIPE */
+
 static int cp_intc_set_irq_type(struct irq_data *d, unsigned int flow_type)
 {
 	unsigned reg		= BIT_WORD(d->hwirq);
@@ -100,6 +119,12 @@ static struct irq_chip cp_intc_irq_chip = {
 	.irq_ack	= cp_intc_ack_irq,
 	.irq_mask	= cp_intc_mask_irq,
 	.irq_unmask	= cp_intc_unmask_irq,
+#ifdef CONFIG_IPIPE
+	.irq_disable = cp_intc_hold_irq,
+	.irq_enable = cp_intc_release_irq,
+	.irq_hold	= cp_intc_hold_irq,
+	.irq_release = cp_intc_release_irq,
+#endif /* CONFIG_IPIPE */
 	.irq_set_type	= cp_intc_set_irq_type,
 	.irq_set_wake	= cp_intc_set_wake,
 };
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index bad361e..2b39ba5 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -18,6 +18,10 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
+#ifdef CONFIG_IPIPE
+#include <linux/ipipe.h>
+#include <linux/ipipe_tickdev.h>
+#endif /* CONFIG_IPIPE */
 
 #include <asm/sched_clock.h>
 #include <asm/mach/irq.h>
@@ -94,9 +98,15 @@ struct timer_s {
 	unsigned long opts;
 	unsigned long flags;
 	void __iomem *base;
+#ifdef CONFIG_IPIPE
+	void *pbase;
+#endif /*CONFIG_IPIPE */
 	unsigned long tim_off;
 	unsigned long prd_off;
 	unsigned long enamode_shift;
+#ifdef CONFIG_IPIPE
+	int irq;
+#endif /* CONFIG_IPIPE */
 	struct irqaction irqaction;
 };
 static struct timer_s timers[];
@@ -166,6 +176,9 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = &clockevent_davinci;
 
+#ifdef CONFIG_IPIPE
+	__ipipe_tsc_update();
+#endif /* CONFIG_IPIPE */
 	evt->event_handler(evt);
 	return IRQ_HANDLED;
 }
@@ -241,6 +254,9 @@ static void __init timer_init(void)
 		t->base = base[timer];
 		if (!t->base)
 			continue;
+#ifdef CONFIG_IPIPE
+		t->pbase = (void *)dtip[timer].base;
+#endif /* CONFIG_IPIPE */
 
 		if (IS_TIMER_BOT(t->id)) {
 			t->enamode_shift = 6;
@@ -262,6 +278,9 @@ static void __init timer_init(void)
 			irq = USING_COMPARE(t) ? dtip[i].cmp_irq : irq;
 			setup_irq(irq, &t->irqaction);
 		}
+#ifdef CONFIG_IPIPE
+		t->irq = irq;
+#endif /* CONFIG_IPIPE */
 	}
 }
 
@@ -329,11 +348,27 @@ static void davinci_set_mode(enum clock_event_mode mode,
 	}
 }
 
+#ifdef CONFIG_IPIPE
+static struct ipipe_timer davinci_itimer;
+
+static struct __ipipe_tscinfo tsc_info = {
+	.type = IPIPE_TSC_TYPE_FREERUNNING,
+	.u = {
+			{
+				.mask = 0xffffffff,
+			},
+	},
+};
+#endif /* CONFIG_IPIPE */
+
 static struct clock_event_device clockevent_davinci = {
 	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.shift		= 32,
 	.set_next_event	= davinci_set_next_event,
 	.set_mode	= davinci_set_mode,
+#ifdef CONFIG_IPIPE
+	.ipipe_timer = &davinci_itimer,
+#endif /* CONFIG_IPIPE */
 };
 
 
@@ -404,6 +439,17 @@ void __init davinci_timer_init(void)
 	clockevent_davinci.min_delta_ns = 50000; /* 50 usec */
 
 	clockevent_davinci.cpumask = cpumask_of(0);
+#ifdef CONFIG_IPIPE
+	tsc_info.freq = davinci_clock_tick_rate;
+	tsc_info.counter_vaddr = (void *)(timers[TID_CLOCKSOURCE].base +
+			timers[TID_CLOCKSOURCE].tim_off);
+	tsc_info.u.counter_paddr = timers[TID_CLOCKSOURCE].pbase +
+			timers[TID_CLOCKSOURCE].tim_off;
+	__ipipe_tsc_register(&tsc_info);
+
+	davinci_itimer.irq = timers[TID_CLOCKEVENT].irq;
+	davinci_itimer.min_delay_ticks = 3;
+#endif /* CONFIG_IPIPE */
 	clockevents_register_device(&clockevent_davinci);
 
 	for (i=0; i< ARRAY_SIZE(timers); i++)
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 17df6db..0426ab2 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/ipipe.h>
 
 #include <asm/mach/irq.h>
 
@@ -282,7 +283,11 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 		while (status) {
 			res = ffs(status);
 			n += res;
+#ifdef CONFIG_IPIPE
+			ipipe_handle_demuxed_irq(n - 1);
+#else
 			generic_handle_irq(n - 1);
+#endif /* CONFIG_IPIPE */
 			status >>= res;
 		}
 	}

-- 
Peter Howard <pjh@northern-ridge.com.au>


