From: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Date: Thu, 12 Oct 2017 14:49:35 +0200
Message-Id: <20171012124935.24781-1-christoph.muellner@theobroma-systems.com>
In-Reply-To: <6f474cec-909e-f230-73ff-b3b1fcf9c555@siemens.com>
References: <6f474cec-909e-f230-73ff-b3b1fcf9c555@siemens.com>
Subject: [Xenomai] [PATCH] ipipe: gicv3: [v3] Enable interrupt pipelining.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan.kiszka@siemens.com, dmitriy@oss-tech.org, christoph.muellner@theobroma-systems.com, xenomai@xenomai.org

This patch enables interrupt pipelining for ARM/ARM64 SoC with a
GICv3 interrupt controller.

The patch was tested on a Rockchip RK3399 (ARM64 SoC) with
Linux 4.12.14, I-pipe 4.11-arm64 and Xenomai/Cobalt 3.1 (next).
xeno-test did not show any errors/fails and latency ran
72 hours in a row.

[v2]: Add I-pipe locking and the forwarding calls for locking/unlocking
the IRQ in case of masking/unmasking.

[v3]: Using hard_cond_* instead of #ifdef'd hard_local_*.

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 drivers/irqchip/irq-gic-v3.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 9e14388403b9..381a35eb3158 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -200,7 +200,12 @@ static void gic_poke_irq(struct irq_data *d, u32 offset)
 
 static void gic_mask_irq(struct irq_data *d)
 {
+	unsigned long flags;
+
+	flags = hard_cond_local_irq_save();
+	ipipe_lock_irq(d->irq);
 	gic_poke_irq(d, GICD_ICENABLER);
+	hard_cond_local_irq_restore(flags);
 }
 
 static void gic_eoimode1_mask_irq(struct irq_data *d)
@@ -220,7 +225,12 @@ static void gic_eoimode1_mask_irq(struct irq_data *d)
 
 static void gic_unmask_irq(struct irq_data *d)
 {
+	unsigned long flags;
+
+	flags = hard_cond_local_irq_save();
 	gic_poke_irq(d, GICD_ISENABLER);
+	ipipe_unlock_irq(d->irq);
+	hard_cond_local_irq_restore(flags);
 }
 
 static int gic_irq_set_irqchip_state(struct irq_data *d,
@@ -294,6 +304,27 @@ static void gic_eoimode1_eoi_irq(struct irq_data *d)
 	gic_write_dir(gic_irq(d));
 }
 
+#ifdef CONFIG_IPIPE
+static void gic_hold_irq(struct irq_data *d)
+{
+	struct irq_chip *chip = irq_data_get_irq_chip(d);
+
+	gic_poke_irq(d, GICD_ICENABLER);
+
+	if (chip->irq_eoi == gic_eoimode1_eoi_irq) {
+		if (irqd_is_forwarded_to_vcpu(d))
+			gic_poke_irq(d, GICD_ICACTIVER);
+		gic_eoimode1_eoi_irq(d);
+	} else
+		gic_eoi_irq(d);
+}
+
+static void gic_release_irq(struct irq_data *d)
+{
+	gic_poke_irq(d, GICD_ISENABLER);
+}
+#endif /* CONFIG_IPIPE */
+
 static int gic_set_type(struct irq_data *d, unsigned int type)
 {
 	unsigned int irq = gic_irq(d);
@@ -717,6 +748,10 @@ static struct irq_chip gic_chip = {
 	.irq_unmask		= gic_unmask_irq,
 	.irq_eoi		= gic_eoi_irq,
 	.irq_set_type		= gic_set_type,
+#ifdef CONFIG_IPIPE
+	.irq_hold		= gic_hold_irq,
+	.irq_release		= gic_release_irq,
+#endif
 	.irq_set_affinity	= gic_set_affinity,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
@@ -729,6 +764,10 @@ static struct irq_chip gic_eoimode1_chip = {
 	.irq_unmask		= gic_unmask_irq,
 	.irq_eoi		= gic_eoimode1_eoi_irq,
 	.irq_set_type		= gic_set_type,
+#ifdef CONFIG_IPIPE
+	.irq_hold		= gic_hold_irq,
+	.irq_release		= gic_release_irq,
+#endif
 	.irq_set_affinity	= gic_set_affinity,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
-- 
2.11.0


