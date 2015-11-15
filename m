Message-ID: <BLU437-SMTP72A29E46372946E95D6CFAF01F0@phx.gbl>
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Date: Sun, 15 Nov 2015 08:53:14 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] IPIPE patch for BCM2709/RPI2 (version #3)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

>From 2aa9fa2759a6bfafdac5b3355d2e827cee7c200f Mon Sep 17 00:00:00 2001
From: Mathieu Rondonneau <mathieu.rondonneau@gmail.com>
Date: Fri, 13 Nov 2015 20:59:49 -0800
Subject: [PATCH] IPIPE patch for BCM2709.

 - kernel: https://github.com/raspberrypi/linux (rpi-3.18.y)
   - 1bb18c8f721ef674a447f3622273f2e2de7a205c
 - xenomai: git://git.xenomai.org/xenomai-3.git (stable-3.0.x)
   - cb72996a06ae4f29e403e3397324069f1983145e
---
 arch/arm/mach-bcm2709/armctrl.c                  |  4 ++++
 arch/arm/mach-bcm2709/bcm2708_gpio.c             |  6 ++++--
 arch/arm/mach-bcm2709/bcm2709.c                  |  9 +++++++++
 arch/arm/mach-bcm2709/include/mach/entry-macro.S | 12 ++++++++++--
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-bcm2709/armctrl.c
b/arch/arm/mach-bcm2709/armctrl.c
index fc6cb8b..c50b2cb 100644
--- a/arch/arm/mach-bcm2709/armctrl.c
+++ b/arch/arm/mach-bcm2709/armctrl.c
@@ -333,6 +333,10 @@ static struct irq_chip armctrl_chip = {
 	.irq_mask = armctrl_mask_irq,
 	.irq_unmask = armctrl_unmask_irq,
 	.irq_set_wake = armctrl_set_wake,
+#ifdef CONFIG_IPIPE
+	.irq_hold = armctrl_mask_irq,
+	.irq_release = armctrl_unmask_irq,
+#endif
 };

 /**
diff --git a/arch/arm/mach-bcm2709/bcm2708_gpio.c
b/arch/arm/mach-bcm2709/bcm2708_gpio.c
index c1e9254..7852129 100644
--- a/arch/arm/mach-bcm2709/bcm2708_gpio.c
+++ b/arch/arm/mach-bcm2709/bcm2708_gpio.c
@@ -24,6 +24,7 @@
 #include <linux/pinctrl/consumer.h>

 #include <linux/platform_data/bcm2708.h>
+#include <linux/ipipe.h>

 #define BCM_GPIO_DRIVER_NAME "bcm2708_gpio"
 #define DRIVER_NAME BCM_GPIO_DRIVER_NAME
@@ -56,7 +57,8 @@ enum { GPIO_FSEL_INPUT, GPIO_FSEL_OUTPUT,
 	 * the GPIO code. This also makes the case of a GPIO routine call from
 	 * the IRQ code simpler.
 	 */
-static DEFINE_SPINLOCK(lock);	/* GPIO registers */
+static IPIPE_DEFINE_SPINLOCK(lock); /* GPIO registers */
+

 struct bcm2708_gpio {
 	struct list_head list;
@@ -294,7 +296,7 @@ static irqreturn_t bcm2708_gpio_interrupt(int irq,
void *dev_id)
 			if (!(level_bits & (1<<i)))
 				writel(1<<i,
 				       __io_address(GPIO_BASE) + GPIOEDS(bank));
-			generic_handle_irq(gpio_to_irq(gpio));
+			ipipe_handle_demuxed_irq(gpio_to_irq(gpio));
 			/* ack level triggered IRQ after handling them */
 			if (level_bits & (1<<i))
 				writel(1<<i,
diff --git a/arch/arm/mach-bcm2709/bcm2709.c
b/arch/arm/mach-bcm2709/bcm2709.c
index 6bfd99e..4dd796c 100644
--- a/arch/arm/mach-bcm2709/bcm2709.c
+++ b/arch/arm/mach-bcm2709/bcm2709.c
@@ -1072,11 +1072,13 @@ static void __init bcm2709_timer_init(void)
 static void __init bcm2709_timer_init(void)
 {
 	extern void dc4_arch_timer_init(void);
+#ifndef CONFIG_IPIPE
 	// timer control
 	writel(0, __io_address(ARM_LOCAL_CONTROL));
 	// timer pre_scaler
 	writel(0x80000000, __io_address(ARM_LOCAL_PRESCALER)); // 19.2MHz
 	//writel(0x06AAAAAB, __io_address(ARM_LOCAL_PRESCALER)); // 1MHz
+#endif

 	if (use_dt)
 	{
@@ -1085,6 +1087,13 @@ static void __init bcm2709_timer_init(void)
 	}
 	else
 		dc4_arch_timer_init();
+
+#ifdef CONFIG_IPIPE
+	// timer control
+	writel(0, __io_address(ARM_LOCAL_CONTROL));
+	// timer pre_scaler
+	writel(0x80000000, __io_address(ARM_LOCAL_PRESCALER)); // 19.2MHz
+#endif
 }

 #endif
diff --git a/arch/arm/mach-bcm2709/include/mach/entry-macro.S
b/arch/arm/mach-bcm2709/include/mach/entry-macro.S
index 101d9f1..9e089c8 100644
--- a/arch/arm/mach-bcm2709/include/mach/entry-macro.S
+++ b/arch/arm/mach-bcm2709/include/mach/entry-macro.S
@@ -52,7 +52,11 @@
 	dsb
 	mov	r1, sp
 	adr	lr, BSYM(1b)
-	b	do_IPI
+#ifdef CONFIG_IPIPE
+        b	__ipipe_grab_ipi
+#else
+        b	do_IPI
+#endif

 1030:
 	/* check gpu interrupt */
@@ -107,7 +111,11 @@
 	@ routine called with r0 = irq number, r1 = struct pt_regs *
 	@
 	adr	lr, BSYM(1b)
-	b	asm_do_IRQ
+#ifdef CONFIG_IPIPE
+        b	__ipipe_grab_irq
+#else
+        b	asm_do_IRQ
+#endif

 1020:	@ EQ will be set if no irqs pending
 	.endm
-- 
2.6.3

