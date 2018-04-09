From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sun,  8 Apr 2018 20:53:51 -0400
Message-Id: <1523235231-12106-1-git-send-email-greg@embeddedgreg.com>
Subject: [Xenomai] [PATCH] Set irq-bcm2835 pipeline safe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 drivers/irqchip/irq-bcm2835.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index bf8c9d4..8a1b729 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -115,6 +115,7 @@ static struct irq_chip armctrl_chip = {
 	.irq_hold = armctrl_mask_irq,
 	.irq_release = armctrl_unmask_irq,
 #endif
+	.flags	     = IRQCHIP_PIPELINE_SAFE,
 };
 
 static int armctrl_xlate(struct irq_domain *d, struct device_node *ctrlr,
-- 
2.7.4


