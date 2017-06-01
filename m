References: <mailman.117.1496166485.4225.xenomai@xenomai.org>
 <1496167354451.78382@kth.se>
 <e1ed397b-c902-7b7d-5d1c-e78d9c5f8bf0@xenomai.org>
 <1496226896420.15161@kth.se>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <78c2df60-f9d8-ff4e-a53d-1b64e4af5c4a@xenomai.org>
Date: Thu, 1 Jun 2017 09:11:32 +0200
MIME-Version: 1.0
In-Reply-To: <1496226896420.15161@kth.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] problem gpio interrupts xenomai3 on the raspberry pi
 2 (or 3)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nitin Kulkarni <nitink@kth.se>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/31/2017 12:34 PM, Nitin Kulkarni wrote:
> This is the output from /proc/interrupts  (Note: irq 300 is the one I have requested ) 
> 
>  root@intel-corei7-64:~# cat /proc/interrupts
>             CPU0       CPU1       CPU2       CPU3

[snip]

>  142:          0          0          0          0  intel-gpio   19  bq25890_irq
>  300:          0          0          0          0  intel-gpio   22  test_interrupt

[snip]

>  373:          0          0          0          0  bxtwc_irq_chip_level2    0  pmic_thermal
>  374:          0          0          0          0  bxtwc_irq_chip_level2    1  pmic_thermal
>  375:          0          0          0          0  bxtwc_irq_chip_level2    2  pmic_thermal
>  383:          1          0          0          0  Whiskey Cove    7  ACPI:Event
>  470:          1          0          0          0  bxtwc_irq_chip_level2    7  bxt_wcove_gpio
>  471:          1          0          0          0  bxtwc_irq_chip_level2    5  wcove_typec
>  472:          0          0          0          0  bxtwc_irq_chip_tmu   10  bxt_wcove_tmu

There are several IRQ chip controllers which are not I-pipe aware on this Soc. The bxtwc and the pin controller allow multiple GPIO modules to sit on the same IRQ vector (IRQF_SHARED), this is not going to work with pipelined interrupts, at least not with the current implementation of  the I-pipe patch (at some point in the future this will be the case, but we are not there yet). We can still fix the situation for a single GPIO module per IRQ line though.

This is how I would fix up the code for the pin controller driver you are interested in; not tested, not even compiled, just some hints about the way to do it. Until there are fixups for the other drivers (bxtwc abd whiskey cove), you may want to disable them, only to make sure that they won't freak out if/when receiving an interrupt.

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 0144376..f8bf54b 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -91,7 +91,11 @@ struct intel_pinctrl_context {
  */
 struct intel_pinctrl {
 	struct device *dev;
+#ifdef CONFIG_IPIPE
+	ipipe_spinlock_t lock;
+#else
 	raw_spinlock_t lock;
+#endif
 	struct pinctrl_desc pctldesc;
 	struct pinctrl_dev *pctldev;
 	struct gpio_chip chip;
@@ -647,15 +651,13 @@ static const struct gpio_chip intel_gpio_chip = {
 	.set = intel_gpio_set,
 };
 
-static void intel_gpio_irq_ack(struct irq_data *d)
+static void __intel_gpio_irq_ack(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
 	const struct intel_community *community;
 	unsigned pin = irqd_to_hwirq(d);
 
-	raw_spin_lock(&pctrl->lock);
-
 	community = intel_get_community(pctrl, pin);
 	if (community) {
 		unsigned padno = pin_to_padno(community, pin);
@@ -664,7 +666,14 @@ static void intel_gpio_irq_ack(struct irq_data *d)
 
 		writel(BIT(gpp_offset), community->regs + GPI_IS + gpp * 4);
 	}
+}
 
+static void intel_gpio_irq_ack(struct irq_data *d)
+{
+	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
+
+	raw_spin_lock(&pctrl->lock);
+	__intel_gpio_irq_ack(d);
 	raw_spin_unlock(&pctrl->lock);
 }
 
@@ -694,18 +703,17 @@ static void intel_gpio_irq_enable(struct irq_data *d)
 		writel(value, community->regs + community->ie_offset + gpp * 4);
 	}
 
+	ipipe_unlock_irq(d->irq);
+	
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
-static void intel_gpio_irq_mask_unmask(struct irq_data *d, bool mask)
+static void __intel_gpio_irq_mask_unmask(struct irq_data *d, bool mask)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
 	const struct intel_community *community;
 	unsigned pin = irqd_to_hwirq(d);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	community = intel_get_community(pctrl, pin);
 	if (community) {
@@ -723,20 +731,55 @@ static void intel_gpio_irq_mask_unmask(struct irq_data *d, bool mask)
 			value |= BIT(gpp_offset);
 		writel(value, reg);
 	}
-
-	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static void intel_gpio_irq_mask(struct irq_data *d)
 {
-	intel_gpio_irq_mask_unmask(d, true);
+	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	ipipe_lock_irq(d->irq);
+	__intel_gpio_irq_mask_unmask(d, true);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
 static void intel_gpio_irq_unmask(struct irq_data *d)
 {
-	intel_gpio_irq_mask_unmask(d, false);
+	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	__intel_gpio_irq_mask_unmask(d, false);
+	ipipe_unlock_irq(d->irq);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+}
+
+#ifdef CONFIG_IPIPE
+
+static void intel_gpio_irq_hold(struct irq_data *d)
+{
+	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	__intel_gpio_irq_mask_unmask(d, true);
+	__intel_gpio_irq_ack(d);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+}
+
+static void intel_gpio_irq_release(struct irq_data *d)
+{
+	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	__intel_gpio_irq_mask_unmask(d, false);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
+#endif
+
 static int intel_gpio_irq_type(struct irq_data *d, unsigned type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
@@ -837,7 +880,7 @@ static irqreturn_t intel_gpio_community_irq_handler(struct intel_pinctrl *pctrl,
 
 			irq = irq_find_mapping(gc->irqdomain,
 					       community->pin_base + padno);
-			generic_handle_irq(irq);
+			ipipe_handle_demuxed_irq(irq);
 
 			ret |= IRQ_HANDLED;
 		}
@@ -862,6 +905,14 @@ static irqreturn_t intel_gpio_irq(int irq, void *data)
 	return ret;
 }
 
+static void ipipe_irq_cascade(struct irq_desc *desc)
+{
+#ifdef CONFIG_IPIPE
+	intel_gpio_irq(irq_desc_get_irq(desc),
+		       irq_desc_get_handler_data(desc));
+#endif
+}
+
 static struct irq_chip intel_gpio_irqchip = {
 	.name = "intel-gpio",
 	.irq_enable = intel_gpio_irq_enable,
@@ -870,6 +921,10 @@ static struct irq_chip intel_gpio_irqchip = {
 	.irq_unmask = intel_gpio_irq_unmask,
 	.irq_set_type = intel_gpio_irq_type,
 	.irq_set_wake = intel_gpio_irq_wake,
+#ifdef CONFIG_IPIPE
+	.irq_hold = intel_gpio_irq_hold,
+	.irq_release = intel_gpio_irq_release,
+#endif
 };
 
 static int intel_gpio_probe(struct intel_pinctrl *pctrl, int irq)
@@ -902,12 +957,17 @@ static int intel_gpio_probe(struct intel_pinctrl *pctrl, int irq)
 	 * to the irq directly) because on some platforms several GPIO
 	 * controllers share the same interrupt line.
 	 */
-	ret = devm_request_irq(pctrl->dev, irq, intel_gpio_irq,
-			       IRQF_SHARED | IRQF_NO_THREAD,
-			       dev_name(pctrl->dev), pctrl);
-	if (ret) {
-		dev_err(pctrl->dev, "failed to request interrupt\n");
-		goto fail;
+	if (IS_ENABLED(CONFIG_IPIPE))
+		irq_set_chained_handler_and_data(irq,
+					ipipe_irq_cascade, pctrl);
+	else {
+		ret = devm_request_irq(pctrl->dev, irq, intel_gpio_irq,
+				       IRQF_SHARED | IRQF_NO_THREAD,
+				       dev_name(pctrl->dev), pctrl);
+		if (ret) {
+			dev_err(pctrl->dev, "failed to request interrupt\n");
+			goto fail;
+		}
 	}
 
 	ret = gpiochip_irqchip_add(&pctrl->chip, &intel_gpio_irqchip, 0,

-- 
Philippe.

