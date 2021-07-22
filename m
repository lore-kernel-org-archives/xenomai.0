From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 6/6] clocksource/exynos_mct: irq_pipeline: enable out-of-band
 clock events
Date: Thu, 22 Jul 2021 11:48:59 +0200
Message-Id: <20210722094859.3580166-7-rpm@xenomai.org>
In-Reply-To: <20210722094859.3580166-1-rpm@xenomai.org>
References: <20210722094859.3580166-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Ensure end-of-end out-of-band event delivery by receiving the clock
interrupts directly on the out-of-band stage.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 drivers/clocksource/exynos_mct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index a60cecf62c1cd6c..8d8ad16c13c3712 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -340,7 +340,7 @@ static int exynos4_clockevent_init(void)
 	clockevents_config_and_register(&mct_comp_device, clk_rate,
 					0xf, 0xffffffff);
 	if (request_irq(mct_irqs[MCT_G0_IRQ], exynos4_mct_comp_isr,
-			IRQF_TIMER | IRQF_IRQPOLL, "mct_comp_irq",
+			IRQF_TIMER | IRQF_IRQPOLL | IRQF_OOB, "mct_comp_irq",
 			&mct_comp_device))
 		pr_err("%s: request_irq() failed\n", "mct_comp_irq");
 
-- 
2.31.1


