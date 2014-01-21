From: Stefan Roese <sr@denx.de>
Date: Tue, 21 Jan 2014 16:36:06 +0100
Message-Id: <1390318566-3704-1-git-send-email-sr@denx.de>
Subject: [Xenomai] [PATCH v3] hal/arm: Add Zynq v3.5.7 patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Xilinx Zynq is already supported in the mainline Xenomai git repository.
This patch adds support for the v3.5.7 Linux Kernel with the latest
arm-6 i-pipe patch additionally to the already present v3.8 support.

Signed-off-by: Stefan Roese <sr@denx.de>
---
v3:
- Removed all non-ipipe related patches from post- patch
- Only EXPORT_SYMBOL_GPL(init_mm) is now removed

v2:
- Base pre-patch on top of a different git reopsitory based on v3.5.7
- Remove defconfig and other board specific stuff from post-patch
- All this leads to minimal pre- and post- patches as requested
  by Gilles

 ksrc/arch/arm/patches/README                       |  11 +-
 .../patches/zynq/ipipe-core-3.5.7-zynq-post.patch  | 271 +++++++++++++++++++++
 .../patches/zynq/ipipe-core-3.5.7-zynq-pre.patch   |  28 +++
 3 files changed, 309 insertions(+), 1 deletion(-)
 create mode 100644 ksrc/arch/arm/patches/zynq/ipipe-core-3.5.7-zynq-post.patch
 create mode 100644 ksrc/arch/arm/patches/zynq/ipipe-core-3.5.7-zynq-pre.patch

diff --git a/ksrc/arch/arm/patches/README b/ksrc/arch/arm/patches/README
index de47f32..ed406d9 100644
--- a/ksrc/arch/arm/patches/README
+++ b/ksrc/arch/arm/patches/README
@@ -76,7 +76,7 @@ From [5]:
 2- apply raspberry/ipipe-core-3.8.13-raspberry-post-2.patch
 3- you can resume to generic installation instructions.
 
----- Zynq
+---- Zynq (v3.8)
 
 1- Checkout the xilinx-v14.5 tag (6a0bedad60e2bca8d9b50bf81b9895e29e31a6d7)
    from [6]
@@ -85,6 +85,15 @@ From [5]:
 4- apply ipipe-core-3.8-zynq-post.patch
 5- you can resume to generic installation instructions.
 
+---- Zynq (v3.5.7)
+
+1- Checkout the "xilinx-zynq-v3.5.7" branch from the DENX Linux git
+   repository [2]
+2- apply ipipe-core-3.5.7-zynq-pre.patch
+3- apply ipipe-core-3.5.7-arm-6.patch
+4- apply ipipe-core-3.5.7-zynq-post.patch
+5- you can resume to generic installation instructions.
+
 -- External links
 
 [1] http://opensource.freescale.com/pub/scm/imx/linux-2.6-imx.git
diff --git a/ksrc/arch/arm/patches/zynq/ipipe-core-3.5.7-zynq-post.patch b/ksrc/arch/arm/patches/zynq/ipipe-core-3.5.7-zynq-post.patch
new file mode 100644
index 0000000..97a9fdf
--- /dev/null
+++ b/ksrc/arch/arm/patches/zynq/ipipe-core-3.5.7-zynq-post.patch
@@ -0,0 +1,271 @@
+diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
+index eebf8bb..f2b7782 100644
+--- a/arch/arm/Kconfig
++++ b/arch/arm/Kconfig
+@@ -992,6 +992,7 @@ config ARCH_ZYNQ
+ 	select COMMON_CLK
+ 	select ARCH_HAS_CPUFREQ
+ 	select ARCH_HAS_OPP
++	select IPIPE_ARM_KUSER_TSC if IPIPE
+ 	help
+ 	  Support for Xilinx Zynq ARM Cortex A9 Platform
+ endchoice
+diff --git a/arch/arm/kernel/ipipe.c b/arch/arm/kernel/ipipe.c
+index ff4ad1a..12bb964 100644
+--- a/arch/arm/kernel/ipipe.c
++++ b/arch/arm/kernel/ipipe.c
+@@ -574,7 +574,6 @@ EXPORT_SYMBOL_GPL(__ipipe_serial_debug);
+ 
+ EXPORT_SYMBOL_GPL(do_munmap);
+ EXPORT_SYMBOL_GPL(show_stack);
+-EXPORT_SYMBOL_GPL(init_mm);
+ EXPORT_SYMBOL_GPL(cpu_architecture);
+ #ifndef MULTI_CPU
+ EXPORT_SYMBOL_GPL(cpu_do_switch_mm);
+diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
+index f77ef11..1a19807 100644
+--- a/arch/arm/kernel/smp.c
++++ b/arch/arm/kernel/smp.c
+@@ -239,6 +239,9 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
+ {
+ 	struct mm_struct *mm = &init_mm;
+ 	unsigned int cpu;
++#ifdef CONFIG_ARCH_ZYNQ
++	static bool booted;
++#endif
+ 
+ 	cpu_switch_mm(mm->pgd, mm, 1);
+ 	enter_lazy_tlb(mm, current);
+@@ -266,7 +269,13 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
+ 
+ 	notify_cpu_starting(cpu);
+ 
++#ifdef CONFIG_ARCH_ZYNQ
++	if (!booted)
++		calibrate_delay();
++	booted = true;
++#else
+ 	calibrate_delay();
++#endif
+ 
+ 	smp_store_cpu_info(cpu);
+ 
+diff --git a/arch/arm/mach-zynq/timer.c b/arch/arm/mach-zynq/timer.c
+index 38faf0f..6f90595 100644
+--- a/arch/arm/mach-zynq/timer.c
++++ b/arch/arm/mach-zynq/timer.c
+@@ -28,6 +28,8 @@
+ #include <linux/of_irq.h>
+ #include <linux/clk.h>
+ #include <linux/err.h>
++#include <linux/ipipe.h>
++#include <linux/ipipe_tickdev.h>
+ 
+ #include <asm/mach/time.h>
+ #include <asm/smp_twd.h>
+@@ -73,9 +75,15 @@
+ /* Setup the timers to use pre-scaling, using a fixed value for now that will work
+  * across most input frequency, but it may need to be more dynamic
+  */
+-#define PRESCALE_EXPONENT 	11	/* 2 ^ PRESCALE_EXPONENT = PRESCALE */
+-#define PRESCALE 		2048	/* The exponent must match this */
+-#define CLK_CNTRL_PRESCALE (((PRESCALE_EXPONENT - 1) << 1) | 0x1)
++#define PRESCALE_EXPONENT	8	/* 2 ^ PRESCALE_EXPONENT = PRESCALE */
++#define PRESCALE		(2 << (PRESCALE_EXPONENT - 1))
++#define CLK_CNTRL_PRESCALE	(((PRESCALE_EXPONENT - 1) << 1) | 0x1)
++
++#define PRESCALE_EXPONENT_EV	5	/* 2 ^ PRESCALE_EXPONENT = PRESCALE */
++#define PRESCALE_EV		(2 << (PRESCALE_EXPONENT_EV - 1))
++#define CLK_CNTRL_PRESCALE_EV	(((PRESCALE_EXPONENT_EV - 1) << 1) | 0x1)
++
++unsigned max_delta_ticks;
+ 
+ /**
+  * struct xttcpss_timer - This definition defines local timer structure
+@@ -117,6 +125,13 @@ static void xttcpss_set_interval(struct xttcpss_timer *timer,
+ 	__raw_writel(ctrl_reg, timer->base_addr + XTTCPSS_CNT_CNTRL_OFFSET);
+ }
+ 
++static void xttcpss_timer_ack(void)
++{
++	struct xttcpss_timer *timer = &timers[XTTCPSS_CLOCKEVENT];
++
++	__raw_readl(timer->base_addr + XTTCPSS_ISR_OFFSET);
++}
++
+ /**
+  * xttcpss_clock_event_interrupt - Clock event timer interrupt handler
+  *
+@@ -128,11 +143,13 @@ static void xttcpss_set_interval(struct xttcpss_timer *timer,
+ static irqreturn_t xttcpss_clock_event_interrupt(int irq, void *dev_id)
+ {
+ 	struct clock_event_device *evt = &xttcpss_clockevent;
+-	struct xttcpss_timer *timer = dev_id;
+ 
+ 	/* Acknowledge the interrupt and call event handler */
+-	__raw_writel(__raw_readl(timer->base_addr + XTTCPSS_ISR_OFFSET),
+-			timer->base_addr + XTTCPSS_ISR_OFFSET);
++	if (!clockevent_ipipe_stolen(evt))
++		xttcpss_timer_ack();
++
++	if (num_possible_cpus() == 1)
++		__ipipe_tsc_update();
+ 
+ 	evt->event_handler(evt);
+ 
+@@ -145,6 +162,17 @@ static struct irqaction event_timer_irq = {
+ 	.handler = xttcpss_clock_event_interrupt,
+ };
+ 
++#ifdef CONFIG_IPIPE
++static struct __ipipe_tscinfo tsc_info = {
++	.type = IPIPE_TSC_TYPE_FREERUNNING,
++	.u = {
++		{
++			.mask = 0x0000ffff,
++		},
++	},
++};
++#endif /* CONFIG_IPIPE */
++
+ /**
+  * xttcpss_timer_hardware_init - Initialize the timer hardware
+  *
+@@ -171,7 +199,7 @@ static void __init xttcpss_timer_hardware_init(void)
+ 	 */
+ 	__raw_writel(0x23, timers[XTTCPSS_CLOCKEVENT].base_addr +
+ 			XTTCPSS_CNT_CNTRL_OFFSET);
+-	__raw_writel(CLK_CNTRL_PRESCALE, 
++	__raw_writel(CLK_CNTRL_PRESCALE_EV, 
+ 			timers[XTTCPSS_CLOCKEVENT].base_addr + 
+ 			XTTCPSS_CLK_CNTRL_OFFSET);
+ 	__raw_writel(0x1, timers[XTTCPSS_CLOCKEVENT].base_addr +
+@@ -216,6 +244,13 @@ static int xttcpss_set_next_event(unsigned long cycles,
+ {
+ 	struct xttcpss_timer *timer = &timers[XTTCPSS_CLOCKEVENT];
+ 
++#ifdef CONFIG_IPIPE
++	if (cycles > max_delta_ticks)
++		cycles = max_delta_ticks;
++#endif
++
++	__ipipe_tsc_update();
++
+ 	xttcpss_set_interval(timer, cycles);
+ 	return 0;
+ }
+@@ -255,6 +290,12 @@ static void xttcpss_set_mode(enum clock_event_mode mode,
+ 	}
+ }
+ 
++#ifdef CONFIG_IPIPE
++static struct ipipe_timer xttcpss_itimer = {
++	.ack = xttcpss_timer_ack,
++};
++#endif /* CONFIG_IPIPE */
++
+ /*
+  * Instantiate and initialize the clock event structure
+  */
+@@ -264,6 +305,9 @@ static struct clock_event_device xttcpss_clockevent = {
+ 	.set_next_event	= xttcpss_set_next_event,
+ 	.set_mode	= xttcpss_set_mode,
+ 	.rating		= 200,
++#ifdef CONFIG_IPIPE
++	.ipipe_timer	= &xttcpss_itimer,
++#endif /* CONFIG_IPIPE */
+ };
+ 
+ static int xttcpss_timer_rate_change_cb(struct notifier_block *nb,
+@@ -279,7 +323,7 @@ static int xttcpss_timer_rate_change_cb(struct notifier_block *nb,
+ 		timers[XTTCPSS_CLOCKSOURCE].frequency =
+ 			ndata->new_rate / PRESCALE;
+ 		timers[XTTCPSS_CLOCKEVENT].frequency =
+-			ndata->new_rate / PRESCALE;
++			ndata->new_rate / PRESCALE_EV;
+ 
+ 		/* Do whatever is necessare to maintain a proper time base */
+ 		/*
+@@ -400,11 +444,11 @@ static void __init xttcpss_timer_init(void)
+ 		}
+ 		if (prop2) {
+ 			timers[XTTCPSS_CLOCKEVENT].frequency =
+-				be32_to_cpup(prop2) / PRESCALE;
++				be32_to_cpup(prop2) / PRESCALE_EV;
+ 		} else {
+ 			pr_err("Error, no clock-frequency specified for timer\n");
+ 			timers[XTTCPSS_CLOCKEVENT].frequency =
+-				PERIPHERAL_CLOCK_RATE / PRESCALE;
++				PERIPHERAL_CLOCK_RATE / PRESCALE_EV;
+ 		}
+ 	} else {
+ 		clk_prepare_enable(clk);
+@@ -419,7 +463,7 @@ static void __init xttcpss_timer_init(void)
+ 		timers[XTTCPSS_CLOCKSOURCE].frequency =
+ 			clk_get_rate(clk) / PRESCALE;
+ 		timers[XTTCPSS_CLOCKEVENT].frequency =
+-			clk_get_rate(clk) / PRESCALE;
++			clk_get_rate(clk) / PRESCALE_EV;
+ 		if (clk_notifier_register(clk,
+ 			&timers[XTTCPSS_CLOCKSOURCE].clk_rate_change_nb))
+ 			pr_warn("Unable to register clock notifier.\n");
+@@ -429,6 +473,29 @@ static void __init xttcpss_timer_init(void)
+ 	clocksource_register_hz(&clocksource_xttcpss,
+ 				timers[XTTCPSS_CLOCKSOURCE].frequency);
+ 
++#ifdef CONFIG_IPIPE
++	if (num_possible_cpus() == 1) {
++		struct resource res;
++
++		tsc_info.freq = timers[XTTCPSS_CLOCKSOURCE].frequency;
++		tsc_info.counter_vaddr =
++			(unsigned long)timers[XTTCPSS_CLOCKSOURCE].base_addr +
++			XTTCPSS_COUNT_VAL_OFFSET;
++		of_address_to_resource(timer, 0, &res);
++		tsc_info.u.counter_paddr = res.start + XTTCPSS_COUNT_VAL_OFFSET;
++
++		__ipipe_tsc_register(&tsc_info);
++	}
++
++	xttcpss_itimer.irq = irq;
++	xttcpss_itimer.freq = timers[XTTCPSS_CLOCKEVENT].frequency;
++	max_delta_ticks = 0xffff - xttcpss_itimer.freq / 1000;
++	xttcpss_itimer.min_delay_ticks = 1;
++	printk(KERN_INFO "I-pipe, %lu.%03lu MHz timer\n",
++	       xttcpss_itimer.freq / 1000000,
++	       (xttcpss_itimer.freq % 1000000) / 1000);
++#endif /* CONFIG_IPIPE */
++
+ 	/* Indicate that clock event is on 1st CPU as SMP boot needs it */
+ 	xttcpss_clockevent.cpumask = cpumask_of(0);
+ 	clockevents_config_and_register(&xttcpss_clockevent,
+diff --git a/drivers/gpio/gpio-xilinxps.c b/drivers/gpio/gpio-xilinxps.c
+index cbccfa1..b0c9162 100644
+--- a/drivers/gpio/gpio-xilinxps.c
++++ b/drivers/gpio/gpio-xilinxps.c
+@@ -27,6 +27,7 @@
+ #include <linux/pm_wakeup.h>
+ #include <linux/err.h>
+ #include <linux/clk.h>
++#include <linux/ipipe.h>
+ #include <linux/irqdomain.h>
+ #include <asm/mach/irq.h>
+ 
+@@ -88,7 +89,7 @@ struct xgpiops {
+ 	void __iomem *base_addr;
+ 	unsigned int irq;
+ 	struct clk *clk;
+-	spinlock_t gpio_lock;
++	ipipe_spinlock_t gpio_lock;
+ };
+ 
+ static struct irq_domain *irq_domain;
+@@ -428,7 +429,7 @@ void xgpiops_irqhandler(unsigned int irq, struct irq_desc *desc)
+ 			chip->irq_ack(&gpio_irq_desc->irq_data);
+ 
+ 			/* call the pin specific handler */
+-			generic_handle_irq(gpio_irq);
++			ipipe_handle_demuxed_irq(gpio_irq);
+ 		}
+ 		/* shift to first virtual irq of next bank */
+ 		gpio_irq = (int)irq_get_handler_data(irq) +
diff --git a/ksrc/arch/arm/patches/zynq/ipipe-core-3.5.7-zynq-pre.patch b/ksrc/arch/arm/patches/zynq/ipipe-core-3.5.7-zynq-pre.patch
new file mode 100644
index 0000000..acde6c7
--- /dev/null
+++ b/ksrc/arch/arm/patches/zynq/ipipe-core-3.5.7-zynq-pre.patch
@@ -0,0 +1,28 @@
+diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
+index 4d7130c1..ea73045 100644
+--- a/arch/arm/kernel/smp.c
++++ b/arch/arm/kernel/smp.c
+@@ -223,9 +223,6 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
+ {
+ 	struct mm_struct *mm = &init_mm;
+ 	unsigned int cpu = smp_processor_id();
+-#ifdef CONFIG_ARCH_ZYNQ
+-	static bool booted;
+-#endif
+ 
+ 	/*
+ 	 * All kernel threads share the same mm context; grab a
+@@ -251,13 +248,7 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
+ 
+ 	notify_cpu_starting(cpu);
+ 
+-#ifdef CONFIG_ARCH_ZYNQ
+-	if (!booted)
+-		calibrate_delay();
+-	booted = true;
+-#else
+ 	calibrate_delay();
+-#endif
+ 
+ 	smp_store_cpu_info(cpu);
+ 
-- 
1.8.5.3


