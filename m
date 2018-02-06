From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon,  5 Feb 2018 23:09:59 -0500
Message-Id: <1517890199-26957-1-git-send-email-greg@embeddedgreg.com>
Subject: [Xenomai] [PATCH]  fixes for rpi 2b build
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Small fix ups to enable building multi_v7_defconfig
---
 drivers/gpio/gpio-mvebu.c          |  1 +
 drivers/gpio/gpio-pl061.c          |  1 +
 drivers/gpio/gpio-zynq.c           |  2 +-
 drivers/irqchip/irq-atmel-aic5.c   |  6 ++++--
 drivers/irqchip/irq-bcm7120-l2.c   | 15 +++++++++------
 drivers/irqchip/irq-brcmstb-l2.c   | 10 ++++++----
 drivers/irqchip/irq-dw-apb-ictl.c  |  1 +
 drivers/pinctrl/pinctrl-rockchip.c |  8 ++++----
 drivers/soc/dove/pmu.c             |  1 +
 9 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 50242fa..058362c 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -50,6 +50,7 @@
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/ipipe.h>
 
 #include "gpiolib.h"
 
diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 97b093e..5f9be96 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -261,6 +261,7 @@ static void pl061_irq_mask_ack(struct irq_data *d)
 	writeb(gpioie, pl061->base + GPIOIE);
 	raw_spin_unlock(&pl061->lock);
 }
+#endif
 
 static void pl061_irq_unmask(struct irq_data *d)
 {
diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index f961274..4dd3627 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -225,7 +225,6 @@ static int zynq_gpio_get_value(struct gpio_chip *chip, unsigned int pin)
 	u32 data;
 	unsigned int bank_num, bank_pin_num;
 	struct zynq_gpio *gpio = gpiochip_get_data(chip);
-	unsigned long flags;
 
 	zynq_gpio_get_bank_pin(pin, &bank_num, &bank_pin_num, gpio);
 
@@ -306,6 +305,7 @@ static int zynq_gpio_dir_in(struct gpio_chip *chip, unsigned int pin)
 	u32 reg;
 	unsigned int bank_num, bank_pin_num;
 	struct zynq_gpio *gpio = gpiochip_get_data(chip);
+	unsigned long flags;
 
 	zynq_gpio_get_bank_pin(pin, &bank_num, &bank_pin_num, gpio);
 
diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index 699a7be..4bbdd31 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -194,6 +194,7 @@ static void aic5_suspend(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	int i;
 	u32 mask;
+	unsigned long flags;
 
 	if (smr_cache)
 		for (i = 0; i < domain->revmap_size; i++) {
@@ -201,7 +202,7 @@ static void aic5_suspend(struct irq_data *d)
 			smr_cache[i] = irq_reg_readl(bgc, AT91_AIC5_SMR);
 		}
 
-	irq_gc_lock(bgc);
+	flags = irq_gc_lock(bgc);
 	for (i = 0; i < dgc->irqs_per_chip; i++) {
 		mask = 1 << i;
 		if ((mask & gc->mask_cache) == (mask & gc->wake_active))
@@ -224,8 +225,9 @@ static void aic5_resume(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	int i;
 	u32 mask;
+	unsigned long flags;
 
-	irq_gc_lock(bgc);
+	flags = irq_gc_lock(bgc);
 
 	if (smr_cache) {
 		irq_reg_writel(bgc, 0xffffffff, AT91_AIC5_SPU);
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 983640e..1224980 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -61,6 +61,7 @@ static void bcm7120_l2_intc_irq_handle(struct irq_desc *desc)
 	struct bcm7120_l2_intc_data *b = data->b;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int idx;
+	unsigned long flags;
 
 	chained_irq_enter(chip, desc);
 
@@ -71,11 +72,11 @@ static void bcm7120_l2_intc_irq_handle(struct irq_desc *desc)
 		unsigned long pending;
 		int hwirq;
 
-		irq_gc_lock(gc);
+		flags = irq_gc_lock(gc);
 		pending = irq_reg_readl(gc, b->stat_offset[idx]) &
 					    gc->mask_cache &
 					    data->irq_map_mask[idx];
-		irq_gc_unlock(gc);
+		irq_gc_unlock(gc, flags);
 
 		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD) {
 			generic_handle_irq(irq_find_mapping(b->domain,
@@ -90,22 +91,24 @@ static void bcm7120_l2_intc_suspend(struct irq_chip_generic *gc)
 {
 	struct bcm7120_l2_intc_data *b = gc->private;
 	struct irq_chip_type *ct = gc->chip_types;
+        unsigned long flags;
 
-	irq_gc_lock(gc);
+	flags = irq_gc_lock(gc);
 	if (b->can_wake)
 		irq_reg_writel(gc, gc->mask_cache | gc->wake_active,
 			       ct->regs.mask);
-	irq_gc_unlock(gc);
+	irq_gc_unlock(gc, flags);
 }
 
 static void bcm7120_l2_intc_resume(struct irq_chip_generic *gc)
 {
 	struct irq_chip_type *ct = gc->chip_types;
+        unsigned long flags;
 
 	/* Restore the saved mask */
-	irq_gc_lock(gc);
+	flags = irq_gc_lock(gc);
 	irq_reg_writel(gc, gc->mask_cache, ct->regs.mask);
-	irq_gc_unlock(gc);
+	irq_gc_unlock(gc, flags);
 }
 
 static int bcm7120_l2_intc_init_one(struct device_node *dn,
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index b009b91..410b194 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -83,8 +83,9 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct brcmstb_l2_intc_data *b = gc->private;
+	unsigned long flags;
 
-	irq_gc_lock(gc);
+	flags = irq_gc_lock(gc);
 	/* Save the current mask */
 	b->saved_mask = irq_reg_readl(gc, CPU_MASK_STATUS);
 
@@ -93,22 +94,23 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
 		irq_reg_writel(gc, ~gc->wake_active, CPU_MASK_SET);
 		irq_reg_writel(gc, gc->wake_active, CPU_MASK_CLEAR);
 	}
-	irq_gc_unlock(gc);
+	irq_gc_unlock(gc, flags);
 }
 
 static void brcmstb_l2_intc_resume(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct brcmstb_l2_intc_data *b = gc->private;
+        unsigned long flags;
 
-	irq_gc_lock(gc);
+	flags = irq_gc_lock(gc);
 	/* Clear unmasked non-wakeup interrupts */
 	irq_reg_writel(gc, ~b->saved_mask & ~gc->wake_active, CPU_CLEAR);
 
 	/* Restore the saved mask */
 	irq_reg_writel(gc, b->saved_mask, CPU_MASK_SET);
 	irq_reg_writel(gc, ~b->saved_mask, CPU_MASK_CLEAR);
-	irq_gc_unlock(gc);
+	irq_gc_unlock(gc, flags);
 }
 
 static int __init brcmstb_l2_intc_of_init(struct device_node *np,
diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index 9b2696c..061189b 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -17,6 +17,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/ipipe.h>
 
 #define APB_INT_ENABLE_L	0x00
 #define APB_INT_ENABLE_H	0x04
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index b5cb785..f8c4d32 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2629,7 +2629,7 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 	u32 polarity;
 	u32 level;
 	u32 data;
-	unsigned long flags;
+	unsigned long flags, flags2;
 	int ret;
 
 	/* make sure the pin is configured as gpio input */
@@ -2652,7 +2652,7 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 		irq_set_handler_locked(d, handle_level_irq);
 
 	raw_spin_lock_irqsave(&bank->slock, flags);
-	irq_gc_lock(gc);
+	flags2 = irq_gc_lock(gc);
 
 	level = readl_relaxed(gc->reg_base + GPIO_INTTYPE_LEVEL);
 	polarity = readl_relaxed(gc->reg_base + GPIO_INT_POLARITY);
@@ -2693,7 +2693,7 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 		polarity &= ~mask;
 		break;
 	default:
-		irq_gc_unlock(gc);
+		irq_gc_unlock(gc, flags2);
 		raw_spin_unlock_irqrestore(&bank->slock, flags);
 		clk_disable(bank->clk);
 		return -EINVAL;
@@ -2702,7 +2702,7 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 	writel_relaxed(level, gc->reg_base + GPIO_INTTYPE_LEVEL);
 	writel_relaxed(polarity, gc->reg_base + GPIO_INT_POLARITY);
 
-	irq_gc_unlock(gc);
+	irq_gc_unlock(gc, flags2);
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
 	clk_disable(bank->clk);
 
diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
index a51095f..f5790ab 100644
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/soc/dove/pmu.h>
 #include <linux/spinlock.h>
+#include <linux/ipipe.h>
 
 #define NR_PMU_IRQS		7
 
-- 
2.7.4


