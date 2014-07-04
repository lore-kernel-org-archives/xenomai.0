From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri,  4 Jul 2014 11:42:50 +0200
Message-Id: <1404466970-15874-1-git-send-email-maxime.ripard@free-electrons.com>
Subject: [Xenomai] [PATCH v2] AT91: SAMA5D3: Adapt Ipipe for AIC5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: gilles.chanteperdrix@xenomai.org
Cc: Thomas Petazzoni <thomas@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, xenomai@xenomai.org

In the latest generation of Atmel SoCs, the interrupt controller changed. Adapt
the existing code to take this into account.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
Hi,

This patch is not meant to be merged as is.

At the moment, its behaviour is still to erratic to be useful.

An application compiled against Xenomai will hang at least on a call to exit
(while hitting ctrl+c actually make the application stop, leaving the system in
a stable state), while a linux application will just make the system freeze.

 arch/arm/mach-at91/at91sam926x_time.c |  2 --
 arch/arm/mach-at91/irq.c              | 51 +++++++++++++++++++++++++++++++----
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
index 1f7ad837c05d..2a78267da445 100644
--- a/arch/arm/mach-at91/at91sam926x_time.c
+++ b/arch/arm/mach-at91/at91sam926x_time.c
@@ -274,8 +274,6 @@ void __init at91sam926x_pit_init(void)
 	pit_clkevt.mult = div_sc(pit_rate, NSEC_PER_SEC, pit_clkevt.shift);
 	pit_clkevt.cpumask = cpumask_of(0);
 	clockevents_register_device(&pit_clkevt);
-
-	at91_pic_muter_register();
 }
 
 void __init at91sam926x_ioremap_pit(u32 addr)
diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
index a18f229d5d27..83ce0ddc08fc 100644
--- a/arch/arm/mach-at91/irq.c
+++ b/arch/arm/mach-at91/irq.c
@@ -202,13 +202,25 @@ static void at91_aic_mask_irq(struct irq_data *d)
 	hard_cond_local_irq_restore(flags);
 }
 
-static void __maybe_unused at91_aic5_mask_irq(struct irq_data *d)
+static inline void at91_aic5_hard_mask_irq(struct irq_data *d)
 {
 	/* Disable interrupt on AIC5 */
 	at91_aic_write(AT91_AIC5_SSR, d->hwirq & AT91_AIC5_INTSEL_MSK);
 	at91_aic_write(AT91_AIC5_IDCR, 1);
+}
+
+static void at91_aic5_mask_irq(struct irq_data *d)
+{
+	unsigned long flags;
+
+	flags = hard_cond_local_irq_save();
+	at91_aic5_hard_mask_irq(d);
+
 	/* Update ISR cache */
 	clear_backup(d->hwirq);
+
+	ipipe_lock_irq(d->irq);
+	hard_cond_local_irq_restore(flags);
 }
 
 static inline void at91_aic_hard_unmask_irq(struct irq_data *d)
@@ -229,13 +241,25 @@ static void at91_aic_unmask_irq(struct irq_data *d)
 	hard_cond_local_irq_restore(flags);
 }
 
-static void __maybe_unused at91_aic5_unmask_irq(struct irq_data *d)
+static inline void at91_aic5_hard_unmask_irq(struct irq_data *d)
 {
 	/* Enable interrupt on AIC5 */
 	at91_aic_write(AT91_AIC5_SSR, d->hwirq & AT91_AIC5_INTSEL_MSK);
 	at91_aic_write(AT91_AIC5_IECR, 1);
+}
+
+static void at91_aic5_unmask_irq(struct irq_data *d)
+{
+	unsigned long flags;
+
+	flags = hard_cond_local_irq_save();
+	at91_aic5_hard_unmask_irq(d);
+
 	/* Update ISR cache */
 	set_backup(d->hwirq);
+
+	ipipe_unlock_irq(d->irq);
+	hard_cond_local_irq_restore(flags);
 }
 
 static void at91_aic_eoi(struct irq_data *d)
@@ -247,6 +271,11 @@ static void at91_aic_eoi(struct irq_data *d)
 	at91_aic_write(AT91_AIC_EOICR, 0);
 }
 
+static inline void __maybe_unused at91_aic5_eoi(struct irq_data *d)
+{
+	at91_aic_write(AT91_AIC5_EOICR, 0);
+}
+
 #ifdef CONFIG_IPIPE
 static void at91_aic_hold_irq(struct irq_data *d)
 {
@@ -258,13 +287,20 @@ static void at91_aic_release_irq(struct irq_data *d)
 {
 	at91_aic_hard_unmask_irq(d);
 }
-#endif /* CONFIG_IPIPE */
 
-static void __maybe_unused at91_aic5_eoi(struct irq_data *d)
+static void at91_aic5_hold_irq(struct irq_data *d)
 {
-	at91_aic_write(AT91_AIC5_EOICR, 0);
+	at91_aic5_hard_mask_irq(d);
+	at91_aic5_eoi(d);
 }
 
+static void at91_aic5_release_irq(struct irq_data *d)
+{
+	at91_aic5_hard_unmask_irq(d);
+}
+
+#endif /* CONFIG_IPIPE */
+
 static unsigned long *at91_extern_irq;
 
 u32 at91_get_extern_irq(void)
@@ -529,6 +565,11 @@ int __init at91_aic5_of_init(struct device_node *node,
 	at91_aic_chip.irq_eoi		= at91_aic5_eoi;
 	at91_aic_irq_ops.map		= at91_aic5_irq_map;
 
+#ifdef CONFIG_IPIPE
+	at91_aic_chip.irq_hold		= at91_aic5_hold_irq;
+	at91_aic_chip.irq_release	= at91_aic5_release_irq;
+#endif
+
 	err = at91_aic_of_common_init(node, parent);
 	if (err)
 		return err;
-- 
2.0.1


