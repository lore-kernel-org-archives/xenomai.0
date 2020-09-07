From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 4/6] ipipe: pinctrl: enable basic pipeline support
Date: Mon,  7 Sep 2020 15:09:36 +0200
Message-Id: <20200907130938.416831-4-rpm@xenomai.org>
In-Reply-To: <20200907130938.416831-1-rpm@xenomai.org>
References: <20200907130938.416831-1-rpm@xenomai.org>
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

This patch enables the Intel pinctrl/GPIO core driver to operate in a
pipelined interrupt system. However, it does not allow chained GPIO
IRQs to be handled from the head stage of such pipeline yet. In other
words, the chained GPIO interrupts can safely be handled from the
in-band stage when CONFIG_IPIPE is turned on, but cannot be routed to
a real-time application.

Enabling full support will require the I-pipe core to handle IRQs
chained from a shared parent interrupt natively, which it is not
implemented at the moment.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 89ff2795a8b5..927c3dcee378 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1094,7 +1094,9 @@ static irqreturn_t intel_gpio_community_irq_handler(struct intel_pinctrl *pctrl,
 
 			irq = irq_find_mapping(gc->irq.domain,
 					       padgrp->gpio_base + gpp_offset);
-			generic_handle_irq(irq);
+			hard_cond_local_irq_disable();
+			ipipe_handle_demuxed_irq(irq);
+			hard_cond_local_irq_enable();
 
 			ret |= IRQ_HANDLED;
 		}
@@ -1127,7 +1129,7 @@ static struct irq_chip intel_gpio_irqchip = {
 	.irq_unmask = intel_gpio_irq_unmask,
 	.irq_set_type = intel_gpio_irq_type,
 	.irq_set_wake = intel_gpio_irq_wake,
-	.flags = IRQCHIP_MASK_ON_SUSPEND,
+	.flags = IRQCHIP_MASK_ON_SUSPEND|IRQCHIP_PIPELINE_SAFE,
 };
 
 static int intel_gpio_add_pin_ranges(struct intel_pinctrl *pctrl,
-- 
2.26.2


