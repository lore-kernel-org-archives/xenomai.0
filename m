MIME-Version: 1.0
From: "Ramappa. Hugar." <rainbow2ramu@gmail.com>
Date: Thu, 18 Oct 2018 12:02:40 +0530
Message-ID: <CABJm_X0vbaGg-vdNf87EB_Qck4ftzkixEtC5oBW5ZJONN4jeKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] [ipipe-arm64] Xenomai porting on msm-4.9 kernel for
 DB410C SOC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Ramappa. Hugar. <rainbow2ramu@gmail.com>
10:34 AM (1 hour ago)
to xenomai

Dear all,



Trying to port the xenomai on DB410c soc with kernel
https://source.codeaurora.org/kernel/msm-4.9.git



Ported the arm64 ipipe and xenomai patches. Trying to make soc related
changes

.

Following '
https://gitlab.denx.de/Xenomai/xenomai/wikis/Porting_Xenomai_To_A_New_Arm_SOC#flow-handler'
link to port xenomai on new SOC.

Here we could find three interrupt controller drivers in which we need to
add .mask and .unmask callbacks.

   - drivers/gpio/gpio-msm-smp2p.c

   - drivers/pinctrl/qcom/pinctrl-msm.c

   - drivers/irqchip/qcom/pdc.c



1.  'drivers/irqchip/qcom/pdc.c' made following changes to support xenomai.

*----------------------  *

*diff --git a/drivers/irqchip/qcom/pdc.c b/drivers/irqchip/qcom/pdc.c*

*index ba7b6da..5772760 100644*

*--- a/drivers/irqchip/qcom/pdc.c*

*+++ b/drivers/irqchip/qcom/pdc.c*

*@@ -40,7 +40,8 @@ enum pdc_register_offsets {*

*        IRQ_i_CFG = 0x110,*

* };*



*-static DEFINE_SPINLOCK(pdc_lock);*

*+//static DEFINE_SPINLOCK(pdc_lock);*

*+static IPIPE_DEFINE_SPINLOCK(pdc_lock);*

* static void __iomem *pdc_base;*



* static int get_pdc_pin(irq_hw_number_t hwirq, void *data)*

*@@ -228,8 +229,14 @@ static struct irq_chip qcom_pdc_gic_chip = {*

*        .irq_disable            = qcom_pdc_gic_disable,*

*        .irq_retrigger          = irq_chip_retrigger_hierarchy,*

*        .irq_set_type           = qcom_pdc_gic_set_type,*

*+#ifdef CONFIG_IPIPE*

*+       .irq_hold               = qcom_pdc_gic_mask,*

*+       .irq_release            = qcom_pdc_gic_unmask,*

*+#endif*

*+*

*        .flags                  = IRQCHIP_MASK_ON_SUSPEND |*

*                                        IRQCHIP_SET_TYPE_MASKED |*

*+                                       IRQCHIP_PIPELINE_SAFE |*

*                                        IRQCHIP_SKIP_SET_WAKE,*

*----------------------*

Not  finding equivalent API for 'irq_domain_add_hierarchy'.

*---------------------- *

*       pdc_domain = irq_domain_add_hierarchy(parent_domain, 0, MAX_IRQS,*

*                        node, &qcom_pdc_ops, data);*

*---------------------- *



After this changes target is getting hang while booting.



Could you please help me to port this driver ?



Thanks,

Ramappa
