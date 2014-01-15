From: Stefan Roese <sr@denx.de>
Date: Wed, 15 Jan 2014 14:53:02 +0100
Message-Id: <1389793982-18114-1-git-send-email-sr@denx.de>
Subject: [Xenomai] [PATCH v2] hal/arm: Add Zynq v3.5.7 patches
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
v2:
- Base pre-patch on top of a different git reopsitory based on v3.5.7
- Remove defconfig and other board specific stuff from post-patch
- All this leads to minimal pre- and post- patches as requested
  by Gilles

 ksrc/arch/arm/patches/README                       |  11 +-
 .../patches/zynq/ipipe-core-3.5.7-zynq-post.patch  | 749 +++++++++++++++++++++
 .../patches/zynq/ipipe-core-3.5.7-zynq-pre.patch   |  28 +
 3 files changed, 787 insertions(+), 1 deletion(-)
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
index 0000000..94f15a6
--- /dev/null
+++ b/ksrc/arch/arm/patches/zynq/ipipe-core-3.5.7-zynq-post.patch
@@ -0,0 +1,749 @@
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
+diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
+index 85ba299..5ec3bf4 100644
+--- a/arch/arm/boot/dts/zynq-zc702.dts
++++ b/arch/arm/boot/dts/zynq-zc702.dts
+@@ -143,11 +143,13 @@
+ 			phy_type = "ulpi";
+ 		};
+ 
+-		gpio@e000a000 {
++		gpio: gpio@e000a000 {
+ 			compatible = "xlnx,ps7-gpio-1.00.a";
+ 			reg = <0xe000a000 0x1000>;
+ 			interrupts = <0 20 4>;
+ 			interrupt-parent = <&gic>;
++			interrupt-controller;
++			#interrupt-cells = <2>;
+ 		};
+ 
+ 		qspi0: spi@e000d000 {
+diff --git a/arch/arm/kernel/ipipe.c b/arch/arm/kernel/ipipe.c
+index ff4ad1a..cf5f29b 100644
+--- a/arch/arm/kernel/ipipe.c
++++ b/arch/arm/kernel/ipipe.c
+@@ -574,8 +574,6 @@ EXPORT_SYMBOL_GPL(__ipipe_serial_debug);
+ 
+ EXPORT_SYMBOL_GPL(do_munmap);
+ EXPORT_SYMBOL_GPL(show_stack);
+-EXPORT_SYMBOL_GPL(init_mm);
+-EXPORT_SYMBOL_GPL(cpu_architecture);
+ #ifndef MULTI_CPU
+ EXPORT_SYMBOL_GPL(cpu_do_switch_mm);
+ #endif
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
+diff --git a/arch/arm/mach-zynq/include/mach/gpio.h b/arch/arm/mach-zynq/include/mach/gpio.h
+index df1b13a..1364c30 100755
+--- a/arch/arm/mach-zynq/include/mach/gpio.h
++++ b/arch/arm/mach-zynq/include/mach/gpio.h
+@@ -18,8 +18,8 @@
+ #define __ASM_ARCH_GPIO_H
+ 
+ 
+-#define ARCH_NR_GPIOS		512
+-#define XGPIOPS_IRQBASE		128
++#define ARCH_NR_GPIOS		256
++#define XGPIOPS_IRQBASE		256
+ 
+ struct xgpio_platform_data {
+         unsigned int            state;
+@@ -60,9 +60,6 @@ static inline unsigned int irq_to_gpio(unsigned int irq)
+ 	return irq - XGPIOPS_IRQBASE;
+ }
+ 
+-void xgpiodf_set_bypass_mode(struct gpio_chip *chip, unsigned int pin);
+-void xgpiodf_set_normal_mode(struct gpio_chip *chip, unsigned int pin);
+-
+ #endif /* __ASM_ARCH_GPIO_H */
+ 
+ 
+diff --git a/arch/arm/mach-zynq/include/mach/irqs.h b/arch/arm/mach-zynq/include/mach/irqs.h
+index 33b6af6..d780882 100644
+--- a/arch/arm/mach-zynq/include/mach/irqs.h
++++ b/arch/arm/mach-zynq/include/mach/irqs.h
+@@ -15,6 +15,11 @@
+ #ifndef __MACH_IRQS_H
+ #define __MACH_IRQS_H
+ 
+-#define NR_IRQS		128
++#define IRQ_XILINX_MSI_0       128
++/*
++ * IRQs 128-256 - PCIe
++ * IRQs 256-512 - gpio
++ */
++#define NR_IRQS		512
+ 
+ #endif
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
+index b89739d..b0c9162 100644
+--- a/drivers/gpio/gpio-xilinxps.c
++++ b/drivers/gpio/gpio-xilinxps.c
+@@ -24,12 +24,15 @@
+ #include <linux/platform_device.h>
+ #include <linux/slab.h>
+ #include <linux/pm_runtime.h>
+-#ifdef CONFIG_COMMON_CLK
++#include <linux/pm_wakeup.h>
+ #include <linux/err.h>
+ #include <linux/clk.h>
+-#endif
++#include <linux/ipipe.h>
++#include <linux/irqdomain.h>
++#include <asm/mach/irq.h>
+ 
+ #define DRIVER_NAME "xgpiops"
++#define XGPIOPS_NR_GPIOS	118
+ 
+ /* Register offsets for the GPIO device */
+ 
+@@ -84,12 +87,13 @@ static unsigned int xgpiops_pin_table[] = {
+ struct xgpiops {
+ 	struct gpio_chip chip;
+ 	void __iomem *base_addr;
+-#ifdef CONFIG_COMMON_CLK
++	unsigned int irq;
+ 	struct clk *clk;
+-#endif
+-	spinlock_t gpio_lock;
++	ipipe_spinlock_t gpio_lock;
+ };
+ 
++static struct irq_domain *irq_domain;
++
+ /**
+  * xgpiops_get_bank_pin - Get the bank number and pin number within that bank
+  * for a given pin in the GPIO device
+@@ -236,6 +240,11 @@ static int xgpiops_dir_out(struct gpio_chip *chip, unsigned int pin, int state)
+ 	return 0;
+ }
+ 
++static int xgpiops_to_irq(struct gpio_chip *chip, unsigned offset)
++{
++	return irq_find_mapping(irq_domain, offset);
++}
++
+ /**
+  * xgpiops_irq_ack - Acknowledge the interrupt of a gpio pin
+  * @irq_data:	irq data containing irq number of gpio pin for the interrupt to ack
+@@ -247,15 +256,11 @@ static void xgpiops_irq_ack(struct irq_data *irq_data)
+ {
+ 	struct xgpiops *gpio = (struct xgpiops *)irq_data_get_irq_chip_data(irq_data);
+ 	unsigned int device_pin_num, bank_num, bank_pin_num;
+-	unsigned int irq_sts;
+ 
+-	device_pin_num = irq_to_gpio(irq_data->irq); /* get pin num within the device */
++	device_pin_num = irq_data->hwirq; /* get pin num within the device */
+ 	xgpiops_get_bank_pin(device_pin_num, &bank_num, &bank_pin_num);
+-	irq_sts = xgpiops_readreg(gpio->base_addr +
+-				   XGPIOPS_INTSTS_OFFSET(bank_num)) |
+-				   (1 << bank_pin_num);
+-	xgpiops_writereg(irq_sts,
+-			  gpio->base_addr + (XGPIOPS_INTSTS_OFFSET(bank_num)));
++	xgpiops_writereg(1 << bank_pin_num, gpio->base_addr +
++			(XGPIOPS_INTSTS_OFFSET(bank_num)));
+ }
+ 
+ /**
+@@ -270,14 +275,10 @@ static void xgpiops_irq_mask(struct irq_data *irq_data)
+ {
+ 	struct xgpiops *gpio = (struct xgpiops *)irq_data_get_irq_chip_data(irq_data);
+ 	unsigned int device_pin_num, bank_num, bank_pin_num;
+-	unsigned int irq_dis;
+ 
+-	device_pin_num = irq_to_gpio(irq_data->irq); /* get pin num within the device */
++	device_pin_num = irq_data->hwirq; /* get pin num within the device */
+ 	xgpiops_get_bank_pin(device_pin_num, &bank_num, &bank_pin_num);
+-	irq_dis = xgpiops_readreg(gpio->base_addr +
+-				   XGPIOPS_INTDIS_OFFSET(bank_num)) |
+-				   (1 << bank_pin_num);
+-	xgpiops_writereg(irq_dis,
++	xgpiops_writereg(1 << bank_pin_num,
+ 			  gpio->base_addr + XGPIOPS_INTDIS_OFFSET(bank_num));
+ }
+ 
+@@ -293,20 +294,16 @@ static void xgpiops_irq_unmask(struct irq_data *irq_data)
+ {
+ 	struct xgpiops *gpio = (struct xgpiops *)irq_data_get_irq_chip_data(irq_data);
+ 	unsigned int device_pin_num, bank_num, bank_pin_num;
+-	unsigned int irq_en;
+ 
+-	device_pin_num = irq_to_gpio(irq_data->irq); /* get pin num within the device */
++	device_pin_num = irq_data->hwirq; /* get pin num within the device */
+ 	xgpiops_get_bank_pin(device_pin_num, &bank_num, &bank_pin_num);
+-	irq_en = xgpiops_readreg(gpio->base_addr +
+-				  XGPIOPS_INTEN_OFFSET(bank_num)) |
+-				  (1 << bank_pin_num);
+-	xgpiops_writereg(irq_en,
++	xgpiops_writereg(1 << bank_pin_num,
+ 			  gpio->base_addr + XGPIOPS_INTEN_OFFSET(bank_num));
+ }
+ 
+ /**
+  * xgpiops_set_irq_type - Set the irq type for a gpio pin
+- * @irq_data:	irq data containing irq number of gpio pin 
++ * @irq_data:	irq data containing irq number of gpio pin
+  * @type:	interrupt type that is to be set for the gpio pin
+  *
+  * This function gets the gpio pin number and its bank from the gpio pin number
+@@ -324,7 +321,7 @@ static int xgpiops_set_irq_type(struct irq_data *irq_data, unsigned int type)
+ 	unsigned int device_pin_num, bank_num, bank_pin_num;
+ 	unsigned int int_type, int_pol, int_any;
+ 
+-	device_pin_num = irq_to_gpio(irq_data->irq); /* get pin num within the device */
++	device_pin_num = irq_data->hwirq; /* get pin num within the device */
+ 	xgpiops_get_bank_pin(device_pin_num, &bank_num, &bank_pin_num);
+ 
+ 	int_type = xgpiops_readreg(gpio->base_addr +
+@@ -374,6 +371,16 @@ static int xgpiops_set_irq_type(struct irq_data *irq_data, unsigned int type)
+ 	return 0;
+ }
+ 
++static int xgpiops_set_wake(struct irq_data *data, unsigned int on)
++{
++	if (on)
++		xgpiops_irq_unmask(data);
++	else
++		xgpiops_irq_mask(data);
++
++	return 0;
++}
++
+ /* irq chip descriptor */
+ static struct irq_chip xgpiops_irqchip = {
+ 	.name		= DRIVER_NAME,
+@@ -381,6 +388,7 @@ static struct irq_chip xgpiops_irqchip = {
+ 	.irq_mask	= xgpiops_irq_mask,
+ 	.irq_unmask	= xgpiops_irq_unmask,
+ 	.irq_set_type	= xgpiops_set_irq_type,
++	.irq_set_wake	= xgpiops_set_wake,
+ };
+ 
+ /**
+@@ -401,45 +409,50 @@ void xgpiops_irqhandler(unsigned int irq, struct irq_desc *desc)
+ 	unsigned int int_sts, int_enb, bank_num;
+ 	struct irq_desc *gpio_irq_desc;
+ 	struct irq_chip *chip = irq_desc_get_chip(desc);
+-	struct irq_data *irq_data = irq_get_chip_data(irq);
+ 
+-	chip->irq_ack(irq_data);
++	chained_irq_enter(chip, desc);
++
+ 	for (bank_num = 0; bank_num < 4; bank_num++) {
+ 		int_sts = xgpiops_readreg(gpio->base_addr +
+ 					   XGPIOPS_INTSTS_OFFSET(bank_num));
+ 		int_enb = xgpiops_readreg(gpio->base_addr +
+ 					   XGPIOPS_INTMASK_OFFSET(bank_num));
+-		/*
+-		 * handle only the interrupts which are enabled in interrupt
+-		 * mask register
+-		 */
+ 		int_sts &= ~int_enb;
++
+ 		for (; int_sts != 0; int_sts >>= 1, gpio_irq++) {
+ 			if ((int_sts & 1) == 0)
+ 				continue;
+-			BUG_ON(!(irq_desc[gpio_irq].handle_irq));
+ 			gpio_irq_desc = irq_to_desc(gpio_irq);
+-			chip->irq_ack(irq_data);
++			BUG_ON(!gpio_irq_desc);
++			chip = irq_desc_get_chip(gpio_irq_desc);
++			BUG_ON(!chip);
++			chip->irq_ack(&gpio_irq_desc->irq_data);
+ 
+ 			/* call the pin specific handler */
+-			irq_desc[gpio_irq].handle_irq(gpio_irq,
+-						      &irq_desc[gpio_irq]);
++			ipipe_handle_demuxed_irq(gpio_irq);
+ 		}
+ 		/* shift to first virtual irq of next bank */
+-		gpio_irq = (int)irq_get_handler_data(irq) + 
++		gpio_irq = (int)irq_get_handler_data(irq) +
+ 				(xgpiops_pin_table[bank_num] + 1);
+ 	}
+-	chip->irq_unmask(irq_data);
++
++	chip = irq_desc_get_chip(desc);
++	chained_irq_exit(chip, desc);
+ }
+ 
+-#if defined(CONFIG_PM) && defined(CONFIG_COMMON_CLK)
++#ifdef CONFIG_PM_SLEEP
+ static int xgpiops_suspend(struct device *_dev)
+ {
+ 	struct platform_device *pdev = container_of(_dev,
+ 			struct platform_device, dev);
+ 	struct xgpiops *gpio = platform_get_drvdata(pdev);
+ 
+-	clk_disable(gpio->clk);
++	if (!device_may_wakeup(_dev)) {
++		if (!pm_runtime_suspended(_dev))
++			clk_disable(gpio->clk);
++		return 0;
++	}
++
+ 	return 0;
+ }
+ 
+@@ -449,10 +462,38 @@ static int xgpiops_resume(struct device *_dev)
+ 			struct platform_device, dev);
+ 	struct xgpiops *gpio = platform_get_drvdata(pdev);
+ 
+-	return clk_enable(gpio->clk);
++	if (!device_may_wakeup(_dev)) {
++		if (!pm_runtime_suspended(_dev))
++			return clk_enable(gpio->clk);
++	}
++
++	return 0;
+ }
++#endif
+ 
+ #ifdef CONFIG_PM_RUNTIME
++static int xgpiops_runtime_suspend(struct device *_dev)
++{
++	struct platform_device *pdev = container_of(_dev,
++			struct platform_device, dev);
++	struct xgpiops *gpio = platform_get_drvdata(pdev);
++
++	clk_disable(gpio->clk);
++
++	return 0;
++}
++
++static int xgpiops_runtime_resume(struct device *_dev)
++{
++	struct platform_device *pdev = container_of(_dev,
++			struct platform_device, dev);
++	struct xgpiops *gpio = platform_get_drvdata(pdev);
++
++	return clk_enable(gpio->clk);
++
++	return 0;
++}
++
+ static int xgpiops_idle(struct device *dev)
+ {
+ 	return pm_schedule_suspend(dev, 1);
+@@ -460,29 +501,38 @@ static int xgpiops_idle(struct device *dev)
+ 
+ static int xgpiops_request(struct gpio_chip *chip, unsigned offset)
+ {
+-	return pm_runtime_get(chip->dev);
++	int ret;
++
++	ret = pm_runtime_get_sync(chip->dev);
++
++	/*
++	 * If the device is already active pm_runtime_get() will return 1 on
++	 * success, but gpio_request still needs to return 0.
++	 */
++	return ret < 0 ? ret : 0;
+ }
+ 
+ static void xgpiops_free(struct gpio_chip *chip, unsigned offset)
+ {
+-	pm_runtime_put(chip->dev);
++	pm_runtime_put_sync(chip->dev);
+ }
+ 
+-static UNIVERSAL_DEV_PM_OPS(xgpiops_dev_pm_ops, xgpiops_suspend, xgpiops_resume,
+-		xgpiops_idle);
+ #else /* ! CONFIG_PM_RUNTIME */
+-static SIMPLE_DEV_PM_OPS(xgpiops_dev_pm_ops, xgpiops_suspend, xgpiops_resume);
+ #define xgpiops_request	NULL
+ #define xgpiops_free	NULL
+ #endif /* ! CONFIG_PM_RUNTIME */
+ 
++#if defined(CONFIG_PM_RUNTIME) || defined(CONFIG_PM_SLEEP)
++static const struct dev_pm_ops xgpiops_dev_pm_ops = {
++	SET_SYSTEM_SLEEP_PM_OPS(xgpiops_suspend, xgpiops_resume)
++	SET_RUNTIME_PM_OPS(xgpiops_runtime_suspend, xgpiops_runtime_resume,
++			xgpiops_idle)
++};
+ #define XGPIOPS_PM	(&xgpiops_dev_pm_ops)
+ 
+-#else /*! CONFIG_PM && ! CONFIG_COMMON_CLK */
++#else /*! CONFIG_PM_RUNTIME || ! CONFIG_PM_SLEEP */
+ #define XGPIOPS_PM	NULL
+-#define xgpiops_request	NULL
+-#define xgpiops_free	NULL
+-#endif /*! CONFIG_PM && ! CONFIG_COMMON_CLK */
++#endif /*! CONFIG_PM_RUNTIME */
+ 
+ /**
+  * xgpiops_probe - Initialization method for a xgpiops device
+@@ -494,7 +544,7 @@ static SIMPLE_DEV_PM_OPS(xgpiops_dev_pm_ops, xgpiops_suspend, xgpiops_resume);
+  * Note: Interrupts are disabled for all the banks during initialization.
+  * Returns 0 on success, negative error otherwise.
+  */
+-static int __init xgpiops_probe(struct platform_device *pdev)
++static int __devinit xgpiops_probe(struct platform_device *pdev)
+ {
+ 	int ret;
+ 	unsigned int irq_num;
+@@ -502,7 +552,8 @@ static int __init xgpiops_probe(struct platform_device *pdev)
+ 	struct gpio_chip *chip;
+ 	resource_size_t remap_size;
+ 	struct resource *mem_res = NULL;
+-	int pin_num, bank_num, gpio_irq;
++	int pin_num, bank_num;
++	int irq_base;
+ 
+ 	gpio = kzalloc(sizeof(struct xgpiops), GFP_KERNEL);
+ 	if (!gpio) {
+@@ -538,6 +589,7 @@ static int __init xgpiops_probe(struct platform_device *pdev)
+ 	}
+ 
+ 	irq_num = platform_get_irq(pdev, 0);
++	gpio->irq = irq_num;
+ 
+ 	/* configure the gpio chip */
+ 	chip = &gpio->chip;
+@@ -550,9 +602,10 @@ static int __init xgpiops_probe(struct platform_device *pdev)
+ 	chip->free = xgpiops_free;
+ 	chip->direction_input = xgpiops_dir_in;
+ 	chip->direction_output = xgpiops_dir_out;
++	chip->to_irq = xgpiops_to_irq;
+ 	chip->dbg_show = NULL;
+ 	chip->base = 0;		/* default pin base */
+-	chip->ngpio = 246;
++	chip->ngpio = XGPIOPS_NR_GPIOS;
+ 	chip->can_sleep = 0;
+ 
+ 	/* report a bug if gpio chip registration fails */
+@@ -566,20 +619,18 @@ static int __init xgpiops_probe(struct platform_device *pdev)
+ 			 (unsigned long)gpio->base_addr);
+ 	}
+ 
+-#ifdef CONFIG_COMMON_CLK
+ 	/* Enable GPIO clock */
+ 	gpio->clk = clk_get_sys("GPIO_APER", NULL);
+ 	if (IS_ERR(gpio->clk)) {
+-		pr_err("Xilinx GPIOPS clock not found.\n");
++		dev_err(&pdev->dev, "Clock not found.\n");
+ 		ret = PTR_ERR(gpio->clk);
+ 		goto err_chip_remove;
+ 	}
+ 	ret = clk_prepare_enable(gpio->clk);
+ 	if (ret) {
+-		pr_err("Xilinx GPIOPS unable to enable clock.\n");
++		dev_err(&pdev->dev, "Unable to enable clock.\n");
+ 		goto err_clk_put;
+ 	}
+-#endif
+ 
+ 	/* disable interrupts for all banks */
+ 	for (bank_num = 0; bank_num < 4; bank_num++) {
+@@ -587,32 +638,43 @@ static int __init xgpiops_probe(struct platform_device *pdev)
+ 				  XGPIOPS_INTDIS_OFFSET(bank_num));
+ 	}
+ 
++	irq_base = irq_alloc_descs(-1, 0, XGPIOPS_NR_GPIOS, 0);
++	if (irq_base < 0) {
++		dev_err(&pdev->dev, "Failed to allocate IRQ numbers\n");
++		goto err_clk_put;
++	}
++
++	irq_domain = irq_domain_add_legacy(pdev->dev.of_node, XGPIOPS_NR_GPIOS,
++					   irq_base, 0, &irq_domain_simple_ops,
++					   NULL);
++
+ 	/*
+ 	 * set the irq chip, handler and irq chip data for callbacks for
+ 	 * each pin
+ 	 */
+-	gpio_irq = XGPIOPS_IRQBASE;
+-	for (pin_num = 0; pin_num < ARCH_NR_GPIOS; pin_num++, gpio_irq++) {
+-		irq_set_chip(gpio_irq, &xgpiops_irqchip);
++	for (pin_num = 0; pin_num < XGPIOPS_NR_GPIOS; pin_num++) {
++		int gpio_irq = irq_find_mapping(irq_domain, pin_num);
++
++		irq_set_chip_and_handler(gpio_irq, &xgpiops_irqchip,
++					 handle_simple_irq);
+ 		irq_set_chip_data(gpio_irq, (void *)gpio);
+-		irq_set_handler(gpio_irq, handle_simple_irq);
+-		irq_set_status_flags(gpio_irq, IRQF_VALID);
++		set_irq_flags(gpio_irq, IRQF_VALID);
+ 	}
+ 
+-	irq_set_handler_data(irq_num, (void *)(XGPIOPS_IRQBASE));
++	irq_set_handler_data(irq_num, (void *)irq_base);
+ 	irq_set_chained_handler(irq_num, xgpiops_irqhandler);
+ 
+-	pm_runtime_set_active(&pdev->dev);
++	clk_disable(gpio->clk);
+ 	pm_runtime_enable(&pdev->dev);
+ 
++	device_set_wakeup_capable(&pdev->dev, 1);
++
+ 	return 0;
+ 
+-#ifdef CONFIG_COMMON_CLK
+ err_clk_put:
+ 	clk_put(gpio->clk);
+ err_chip_remove:
+ 	gpiochip_remove(chip);
+-#endif
+ err_iounmap:
+ 	iounmap(gpio->base_addr);
+ err_release_region:
+@@ -626,31 +688,26 @@ err_free_gpio:
+ 
+ static int xgpiops_remove(struct platform_device *pdev)
+ {
+-#ifdef CONFIG_COMMON_CLK
+ 	struct xgpiops *gpio = platform_get_drvdata(pdev);
+ 
+ 	clk_disable_unprepare(gpio->clk);
+ 	clk_put(gpio->clk);
+-#endif
++	device_set_wakeup_capable(&pdev->dev, 0);
+ 	return 0;
+ }
+ 
+-#ifdef CONFIG_OF
+ static struct of_device_id xgpiops_of_match[] __devinitdata = {
+ 	{ .compatible = "xlnx,ps7-gpio-1.00.a", },
+ 	{ /* end of table */}
+ };
+ MODULE_DEVICE_TABLE(of, xgpiops_of_match);
+-#endif
+ 
+ static struct platform_driver xgpiops_driver = {
+ 	.driver	= {
+ 		.name	= DRIVER_NAME,
+ 		.owner	= THIS_MODULE,
+ 		.pm	= XGPIOPS_PM,
+-#ifdef CONFIG_OF
+ 		.of_match_table = xgpiops_of_match,
+-#endif
+ 	},
+ 	.probe		= xgpiops_probe,
+ 	.remove		= xgpiops_remove,
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
1.8.5.2


