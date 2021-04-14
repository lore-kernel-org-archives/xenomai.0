From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH for linux] pinctrl/intel: irq_pipeline: enable pipelined
 interrupt control
Date: Wed, 14 Apr 2021 00:33:09 -0400
Message-Id: <20210414043309.30451-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 2ed17cdf946d..80ee69a8cf90 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -562,7 +562,7 @@ static const struct intel_pinctrl_soc_data *chv_soc_data[] = {
  * See Intel Atom Z8000 Processor Series Specification Update (Rev. 005),
  * errata #CHT34, for further information.
  */
-static DEFINE_RAW_SPINLOCK(chv_lock);
+static DEFINE_HARD_SPINLOCK(chv_lock);
 
 static u32 chv_pctrl_readl(struct intel_pinctrl *pctrl, unsigned int offset)
 {
@@ -1554,7 +1554,8 @@ static int chv_gpio_probe(struct intel_pinctrl *pctrl, int irq)
 	pctrl->irqchip.irq_mask = chv_gpio_irq_mask;
 	pctrl->irqchip.irq_unmask = chv_gpio_irq_unmask;
 	pctrl->irqchip.irq_set_type = chv_gpio_irq_type;
-	pctrl->irqchip.flags = IRQCHIP_SKIP_SET_WAKE;
+	pctrl->irqchip.flags = IRQCHIP_SKIP_SET_WAKE |
+				IRQCHIP_PIPELINE_SAFE;
 
 	chip->irq.chip = &pctrl->irqchip;
 	chip->irq.init_hw = chv_gpio_irq_init_hw;
-- 
2.17.1


