From: GP Orcullo <kinsamanka@gmail.com>
Date: Thu, 16 Apr 2015 16:05:05 +0800
Message-Id: <1429171505-5598-1-git-send-email-kinsamanka@gmail.com>
Subject: [Xenomai] [PATCH] Add support for SUNXI boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: GP Orcullo <kinsamanka@gmail.com>

Tested on a Cubieboard2 with v3.16.7-ckt9 kernel.

---
 arch/arm/mach-sunxi/Kconfig     |    1 +
 drivers/irqchip/irq-sunxi-nmi.c |    7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 0fbd4f1..96d76da8 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -6,6 +6,7 @@ menuconfig ARCH_SUNXI
 	select PINCTRL
 	select PINCTRL_SUNXI
 	select SUN4I_TIMER
+	select IPIPE_ARM_KUSER_TSC if IPIPE
 
 if ARCH_SUNXI
 
diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 12f547a..d3e8da2 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -77,8 +77,9 @@ static int sunxi_sc_nmi_set_type(struct irq_data *data, unsigned int flow_type)
 	u32 ctrl_off = ct->regs.type;
 	unsigned int src_type;
 	unsigned int i;
+	unsigned long flags;
 
-	irq_gc_lock(gc);
+	flags = irq_gc_lock(gc);
 
 	switch (flow_type & IRQF_TRIGGER_MASK) {
 	case IRQ_TYPE_EDGE_FALLING:
@@ -95,7 +96,7 @@ static int sunxi_sc_nmi_set_type(struct irq_data *data, unsigned int flow_type)
 		src_type = SUNXI_SRC_TYPE_LEVEL_LOW;
 		break;
 	default:
-		irq_gc_unlock(gc);
+		irq_gc_unlock(gc, flags);
 		pr_err("%s: Cannot assign multiple trigger modes to IRQ %d.\n",
 			__func__, data->irq);
 		return -EBADR;
@@ -113,7 +114,7 @@ static int sunxi_sc_nmi_set_type(struct irq_data *data, unsigned int flow_type)
 	src_type_reg |= src_type;
 	sunxi_sc_nmi_write(gc, ctrl_off, src_type_reg);
 
-	irq_gc_unlock(gc);
+	irq_gc_unlock(gc, flags);
 
 	return IRQ_SET_MASK_OK;
 }
-- 
1.7.10.4


