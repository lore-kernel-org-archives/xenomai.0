From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 4/4] Revert "clocksource: omap/dmtimer: ipipe: add support for
 user-visible TSC"
Date: Fri,  1 Mar 2019 13:03:14 +0100
Message-Id: <b94126f3d00415628ededaf9c4eeb148d893133a.1551441793.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1551441793.git.jan.kiszka@siemens.com>
References: <cover.1551441793.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1551441793.git.jan.kiszka@siemens.com>
References: <cover.1551441793.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This reverts commit d35c49508ea205e86de96b005021f46d4199a861.

Belongs into the ARM tree.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/plat-omap/dmtimer.c              | 17 ++---------------
 arch/arm/plat-omap/include/plat/dmtimer.h |  6 ------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 4e8cfc405974..ebef8aacea83 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -395,18 +395,6 @@ int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
 
-#ifdef CONFIG_IPIPE
-unsigned long omap_dm_timer_get_phys_counter_addr(struct omap_dm_timer *timer)
-{
-	return timer->phys_base + (OMAP_TIMER_COUNTER_REG & 0xff);
-}
-
-unsigned long omap_dm_timer_get_virt_counter_addr(struct omap_dm_timer *timer)
-{
-	return (unsigned long)timer->io_base + (OMAP_TIMER_COUNTER_REG & 0xff);
-}
-#endif /* CONFIG_IPIPE */
-
 #if defined(CONFIG_ARCH_OMAP1)
 #include <mach/hardware.h>
 /**
@@ -584,7 +572,7 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
 
 int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
-                            unsigned int load)
+			    unsigned int load)
 {
 	u32 l;
 
@@ -611,7 +599,7 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_set_load);
 
 /* Optimized set_load which removes costly spin wait in timer_start */
 int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
-			    unsigned int load)
+                            unsigned int load)
 {
 	u32 l;
 
@@ -876,7 +864,6 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	}
 
 	timer->fclk = ERR_PTR(-ENODEV);
-	timer->phys_base = mem->start;
 	timer->io_base = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(timer->io_base))
 		return PTR_ERR(timer->io_base);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index ee368c414bb9..dd79f3005cdf 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -104,7 +104,6 @@ struct omap_dm_timer {
 	int irq;
 	struct clk *fclk;
 
-	unsigned long	phys_base;
 	void __iomem	*io_base;
 	void __iomem	*irq_stat;	/* TISR/IRQSTATUS interrupt status */
 	void __iomem	*irq_ena;	/* irq enable */
@@ -416,9 +415,4 @@ static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
 	writel_relaxed(value, timer->irq_stat);
 }
 
-static inline unsigned long __omap_dm_timer_read_status(struct omap_dm_timer *timer)
-{
-	return __raw_readl(timer->irq_stat);
-}
-
 #endif /* __ASM_ARCH_DMTIMER_H */
-- 
2.16.4


