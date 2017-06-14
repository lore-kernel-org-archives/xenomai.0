From: Nitin Kulkarni <nitink@kth.se>
Date: Wed, 14 Jun 2017 12:57:00 +0000
Message-ID: <1497445019861.76883@kth.se>
References: <mailman.117.1496166485.4225.xenomai@xenomai.org>
 <1496167354451.78382@kth.se>
 <e1ed397b-c902-7b7d-5d1c-e78d9c5f8bf0@xenomai.org>
 <1496226896420.15161@kth.se>
 <78c2df60-f9d8-ff4e-a53d-1b64e4af5c4a@xenomai.org>
 <1497222185664.65276@kth.se> <1497265336521.90775@kth.se>,
 <af63a95f-4cb0-508c-7939-eea5b2f3c62d@xenomai.org>
In-Reply-To: <af63a95f-4cb0-508c-7939-eea5b2f3c62d@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Problem with gpio interrupts for xenomai3 on Intel
 joule
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Major change is use of handle_level_irq flow handler instead of handle_simp=
le_irq=0A=
& calling the ack function manually in ipipe_irq_cascade.=0A=
Here is the Patch :=0A=
=0A=
diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/=
pinctrl-intel.c=0A=
index 3b19ef0..4f41532 100644=0A=
--- a/drivers/pinctrl/intel/pinctrl-intel.c=0A=
+++ b/drivers/pinctrl/intel/pinctrl-intel.c=0A=
@@ -22,6 +22,9 @@=0A=
 #include <linux/pinctrl/pinmux.h>=0A=
 #include <linux/pinctrl/pinconf.h>=0A=
 #include <linux/pinctrl/pinconf-generic.h>=0A=
+#include <linux/ipipe.h> =0A=
 =0A=
 #include "pinctrl-intel.h"=0A=
 =0A=
@@ -65,6 +68,8 @@=0A=
 #define PADCFG1_TERM_5K			2=0A=
 #define PADCFG1_TERM_1K			1=0A=
 =0A=
+static struct intel_pinctrl *hack_pctrl;=0A=
+=0A=
 struct intel_pad_context {=0A=
 	u32 padcfg0;=0A=
 	u32 padcfg1;=0A=
@@ -94,7 +99,11 @@ struct intel_pinctrl_context {=0A=
  */=0A=
 struct intel_pinctrl {=0A=
 	struct device *dev;=0A=
-	spinlock_t lock;=0A=
+#ifdef  CONFIG_IPIPE=0A=
+        ipipe_spinlock_t lock;=0A=
+#else=0A=
+        raw_spinlock_t lock;=0A=
+#endif=0A=
 	struct pinctrl_desc pctldesc;=0A=
 	struct pinctrl_dev *pctldev;=0A=
 	struct gpio_chip chip;=0A=
@@ -324,7 +333,7 @@ static int intel_pinmux_set_mux(struct pinctrl_dev *pct=
ldev, unsigned function,=0A=
 	unsigned long flags;=0A=
 	int i;=0A=
 =0A=
-	spin_lock_irqsave(&pctrl->lock, flags);=0A=
+	raw_spin_lock_irqsave(&pctrl->lock, flags);=0A=
 =0A=
 	/*=0A=
 	 * All pins in the groups needs to be accessible and writable=0A=
@@ -332,7 +341,7 @@ static int intel_pinmux_set_mux(struct pinctrl_dev *pct=
ldev, unsigned function,=0A=
 	 */=0A=
 	for (i =3D 0; i < grp->npins; i++) {=0A=
 		if (!intel_pad_usable(pctrl, grp->pins[i])) {=0A=
-			spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
+			raw_spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
 			return -EBUSY;=0A=
 		}=0A=
 	}=0A=
@@ -351,7 +360,7 @@ static int intel_pinmux_set_mux(struct pinctrl_dev *pct=
ldev, unsigned function,=0A=
 		writel(value, padcfg0);=0A=
 	}=0A=
 =0A=
-	spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
 =0A=
 	return 0;=0A=
 }=0A=
@@ -365,10 +374,10 @@ static int intel_gpio_request_enable(struct pinctrl_d=
ev *pctldev,=0A=
 	unsigned long flags;=0A=
 	u32 value;=0A=
 =0A=
-	spin_lock_irqsave(&pctrl->lock, flags);=0A=
+	raw_spin_lock_irqsave(&pctrl->lock, flags);=0A=
 =0A=
 	if (!intel_pad_usable(pctrl, pin)) {=0A=
-		spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
+		raw_spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
 		return -EBUSY;=0A=
 	}=0A=
 =0A=
@@ -383,7 +392,7 @@ static int intel_gpio_request_enable(struct pinctrl_dev=
 *pctldev,=0A=
 	value |=3D PADCFG0_GPIOTXDIS;=0A=
 	writel(value, padcfg0);=0A=
 =0A=
-	spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
 =0A=
 	return 0;=0A=
 }=0A=
@@ -397,7 +406,7 @@ static int intel_gpio_set_direction(struct pinctrl_dev =
*pctldev,=0A=
 	unsigned long flags;=0A=
 	u32 value;=0A=
 =0A=
-	spin_lock_irqsave(&pctrl->lock, flags);=0A=
+	raw_spin_lock_irqsave(&pctrl->lock, flags);=0A=
 =0A=
 	padcfg0 =3D intel_get_padcfg(pctrl, pin, PADCFG0);=0A=
 =0A=
@@ -408,7 +417,7 @@ static int intel_gpio_set_direction(struct pinctrl_dev =
*pctldev,=0A=
 		value &=3D ~PADCFG0_GPIOTXDIS;=0A=
 	writel(value, padcfg0);=0A=
 =0A=
-	spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
 =0A=
 	return 0;=0A=
 }=0A=
@@ -496,7 +505,7 @@ static int intel_config_set_pull(struct intel_pinctrl *=
pctrl, unsigned pin,=0A=
 	int ret =3D 0;=0A=
 	u32 value;=0A=
 =0A=
-	spin_lock_irqsave(&pctrl->lock, flags);=0A=
+	raw_spin_lock_irqsave(&pctrl->lock, flags);=0A=
 =0A=
 	padcfg1 =3D intel_get_padcfg(pctrl, pin, PADCFG1);=0A=
 	value =3D readl(padcfg1);=0A=
@@ -550,7 +559,7 @@ static int intel_config_set_pull(struct intel_pinctrl *=
pctrl, unsigned pin,=0A=
 	if (!ret)=0A=
 		writel(value, padcfg1);=0A=
 =0A=
-	spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
 =0A=
 	return ret;=0A=
 }=0A=
@@ -617,14 +626,14 @@ static void intel_gpio_set(struct gpio_chip *chip, un=
signed offset, int value)=0A=
 		unsigned long flags;=0A=
 		u32 padcfg0;=0A=
 =0A=
-		spin_lock_irqsave(&pctrl->lock, flags);=0A=
+		raw_spin_lock_irqsave(&pctrl->lock, flags);=0A=
 		padcfg0 =3D readl(reg);=0A=
 		if (value)=0A=
 			padcfg0 |=3D PADCFG0_GPIOTXSTATE;=0A=
 		else=0A=
 			padcfg0 &=3D ~PADCFG0_GPIOTXSTATE;=0A=
 		writel(padcfg0, reg);=0A=
-		spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
+		raw_spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
 	}=0A=
 }=0A=
 =0A=
@@ -650,14 +659,14 @@ static const struct gpio_chip intel_gpio_chip =3D {=
=0A=
 	.set =3D intel_gpio_set,=0A=
 };=0A=
 =0A=
-static void intel_gpio_irq_ack(struct irq_data *d)=0A=
+static void __intel_gpio_irq_ack(struct irq_data *d)=0A=
+=0A=
 {=0A=
 	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);=0A=
 	struct intel_pinctrl *pctrl =3D gpiochip_get_data(gc);=0A=
 	const struct intel_community *community;=0A=
 	unsigned pin =3D irqd_to_hwirq(d);=0A=
 =0A=
-	spin_lock(&pctrl->lock);=0A=
 =0A=
 	community =3D intel_get_community(pctrl, pin);=0A=
 	if (community) {=0A=
@@ -668,20 +677,32 @@ static void intel_gpio_irq_ack(struct irq_data *d)=0A=
 		writel(BIT(gpp_offset), community->regs + GPI_IS + gpp * 4);=0A=
 	}=0A=
 =0A=
-	spin_unlock(&pctrl->lock);=0A=
 }=0A=
 =0A=
+=0A=
+static void intel_gpio_irq_ack(struct irq_data *d)=0A=
+{=0A=
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);=0A=
+	struct intel_pinctrl *pctrl =3D gpiochip_get_data(gc);=0A=
+=0A=
+	raw_spin_lock(&pctrl->lock);=0A=
+	__intel_gpio_irq_ack(d);=0A=
+	raw_spin_unlock(&pctrl->lock);=0A=
+}=0A=
+=0A=
+=0A=
 static void intel_gpio_irq_enable(struct irq_data *d)=0A=
 {=0A=
 	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);=0A=
 	struct intel_pinctrl *pctrl =3D gpiochip_get_data(gc);=0A=
+=0A=
 	const struct intel_community *community;=0A=
 	unsigned pin =3D irqd_to_hwirq(d);=0A=
 	unsigned long flags;=0A=
-=0A=
-	spin_lock_irqsave(&pctrl->lock, flags);=0A=
+	raw_spin_lock_irqsave(&pctrl->lock, flags);=0A=
 =0A=
 	community =3D intel_get_community(pctrl, pin);=0A=
+=0A=
 	if (community) {=0A=
 		unsigned padno =3D pin_to_padno(community, pin);=0A=
 		unsigned gpp_size =3D community->gpp_size;=0A=
@@ -694,21 +715,24 @@ static void intel_gpio_irq_enable(struct irq_data *d)=
=0A=
 =0A=
 		value =3D readl(community->regs + community->ie_offset + gpp * 4);=0A=
 		value |=3D BIT(gpp_offset);=0A=
-		writel(value, community->regs + community->ie_offset + gpp * 4);=0A=
+		writel(value, community->regs + community->ie_offset + gpp * 4);	=0A=
+=0A=
 	}=0A=
 =0A=
-	spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
+	hack_pctrl =3D pctrl;=0A=
+=0A=
+	ipipe_unlock_irq(d->irq);=0A=
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
 }=0A=
 =0A=
-static void intel_gpio_irq_mask_unmask(struct irq_data *d, bool mask)=0A=
+static void __intel_gpio_irq_mask_unmask(struct irq_data *d, bool mask)=0A=
 {=0A=
 	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);=0A=
 	struct intel_pinctrl *pctrl =3D gpiochip_get_data(gc);=0A=
 	const struct intel_community *community;=0A=
 	unsigned pin =3D irqd_to_hwirq(d);=0A=
-	unsigned long flags;=0A=
-=0A=
-	spin_lock_irqsave(&pctrl->lock, flags);=0A=
 =0A=
 	community =3D intel_get_community(pctrl, pin);=0A=
 	if (community) {=0A=
@@ -727,23 +751,63 @@ static void intel_gpio_irq_mask_unmask(struct irq_dat=
a *d, bool mask)=0A=
 		writel(value, reg);=0A=
 	}=0A=
 =0A=
-	spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
 }=0A=
 =0A=
+=0A=
 static void intel_gpio_irq_mask(struct irq_data *d)=0A=
 {=0A=
-	intel_gpio_irq_mask_unmask(d, true);=0A=
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);=0A=
+	struct intel_pinctrl *pctrl =3D gpiochip_get_data(gc);=0A=
+	unsigned long flags;=0A=
+=0A=
+	raw_spin_lock_irqsave(&pctrl->lock, flags);=0A=
+	ipipe_lock_irq(d->irq);=0A=
+	__intel_gpio_irq_mask_unmask(d, true);=0A=
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
 }=0A=
 =0A=
 static void intel_gpio_irq_unmask(struct irq_data *d)=0A=
 {=0A=
-	intel_gpio_irq_mask_unmask(d, false);=0A=
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);=0A=
+	struct intel_pinctrl *pctrl =3D gpiochip_get_data(gc);=0A=
+	unsigned long flags;=0A=
+=0A=
+	raw_spin_lock_irqsave(&pctrl->lock, flags);=0A=
+	__intel_gpio_irq_mask_unmask(d, false);=0A=
+	ipipe_unlock_irq(d->irq);=0A=
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
 }=0A=
 =0A=
+#ifdef CONFIG_IPIPE=0A=
+=0A=
+static void intel_gpio_irq_hold(struct irq_data *d)=0A=
+{=0A=
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);=0A=
+	struct intel_pinctrl *pctrl =3D gpiochip_get_data(gc);=0A=
+	unsigned long flags;=0A=
+	raw_spin_lock_irqsave(&pctrl->lock, flags);=0A=
+	__intel_gpio_irq_mask_unmask(d, true);=0A=
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
+=0A=
+}=0A=
+=0A=
+static void intel_gpio_irq_release(struct irq_data *d)=0A=
+{=0A=
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);=0A=
+	struct intel_pinctrl *pctrl =3D gpiochip_get_data(gc);=0A=
+	unsigned long flags;=0A=
+	raw_spin_lock_irqsave(&pctrl->lock, flags);=0A=
+	__intel_gpio_irq_mask_unmask(d, false);=0A=
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
+ }=0A=
+ =0A=
+#endif=0A=
+=0A=
 static int intel_gpio_irq_type(struct irq_data *d, unsigned type)=0A=
 {=0A=
 	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);=0A=
 	struct intel_pinctrl *pctrl =3D gpiochip_get_data(gc);=0A=
 	unsigned pin =3D irqd_to_hwirq(d);=0A=
 	unsigned long flags;=0A=
 	void __iomem *reg;=0A=
@@ -763,7 +827,7 @@ static int intel_gpio_irq_type(struct irq_data *d, unsi=
gned type)=0A=
 		return -EPERM;=0A=
 	}=0A=
 =0A=
-	spin_lock_irqsave(&pctrl->lock, flags);=0A=
+	raw_spin_lock_irqsave(&pctrl->lock, flags);=0A=
 =0A=
 	value =3D readl(reg);=0A=
 =0A=
@@ -790,7 +854,7 @@ static int intel_gpio_irq_type(struct irq_data *d, unsi=
gned type)=0A=
 	else if (type & IRQ_TYPE_LEVEL_MASK)=0A=
 		irq_set_handler_locked(d, handle_level_irq);=0A=
 =0A=
-	spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
 =0A=
 	return 0;=0A=
 }=0A=
@@ -840,12 +904,14 @@ static irqreturn_t intel_gpio_community_irq_handler(s=
truct intel_pinctrl *pctrl,=0A=
 =0A=
 			irq =3D irq_find_mapping(gc->irqdomain,=0A=
 					       community->pin_base + padno);=0A=
-			generic_handle_irq(irq);			=0A=
+			ipipe_handle_demuxed_irq(irq);=0A=
 =0A=
 			ret |=3D IRQ_HANDLED;=0A=
 		}=0A=
 	}=0A=
 =0A=
+=0A=
 	return ret;=0A=
 }=0A=
 =0A=
@@ -853,11 +919,13 @@ static irqreturn_t intel_gpio_irq(int irq, void *data=
)=0A=
 {=0A=
 	const struct intel_community *community;=0A=
 	struct intel_pinctrl *pctrl =3D data;=0A=
+=0A=
 	irqreturn_t ret =3D IRQ_NONE;=0A=
 	int i;=0A=
 =0A=
 	/* Need to check all communities for pending interrupts */=0A=
 	for (i =3D 0; i < pctrl->ncommunities; i++) {=0A=
+=0A=
 		community =3D &pctrl->communities[i];=0A=
 		ret |=3D intel_gpio_community_irq_handler(pctrl, community);=0A=
 	}=0A=
@@ -865,6 +933,20 @@ static irqreturn_t intel_gpio_irq(int irq, void *data)=
=0A=
 	return ret;=0A=
 }=0A=
 =0A=
+static void ipipe_irq_cascade(struct irq_desc *desc)=0A=
+{=0A=
+=0A=
+#ifdef CONFIG_IPIPE=0A=
+	struct intel_pinctrl *pctrl =3D hack_pctrl;=0A=
+	int irq =3D irq_desc_get_irq(desc);=0A=
+=0A=
+	desc->irq_data.chip->irq_ack(&desc->irq_data);=0A=
+=0A=
+	intel_gpio_irq(irq,pctrl);=0A=
+#endif=0A=
+=0A=
+}=0A=
+=0A=
 static struct irq_chip intel_gpio_irqchip =3D {=0A=
 	.name =3D "intel-gpio",=0A=
 	.irq_enable =3D intel_gpio_irq_enable,=0A=
@@ -873,11 +955,18 @@ static struct irq_chip intel_gpio_irqchip =3D {=0A=
 	.irq_unmask =3D intel_gpio_irq_unmask,=0A=
 	.irq_set_type =3D intel_gpio_irq_type,=0A=
 	.irq_set_wake =3D intel_gpio_irq_wake,=0A=
+#ifdef CONFIG_IPIPE=0A=
+	.irq_hold =3D intel_gpio_irq_hold,=0A=
+	.irq_release =3D intel_gpio_irq_release,=0A=
+#endif=0A=
 };=0A=
 =0A=
+=0A=
+=0A=
 static int intel_gpio_probe(struct intel_pinctrl *pctrl, int irq)=0A=
 {=0A=
 	int ret;=0A=
+	=0A=
 =0A=
 	pctrl->chip =3D intel_gpio_chip;=0A=
 =0A=
@@ -887,6 +976,7 @@ static int intel_gpio_probe(struct intel_pinctrl *pctrl=
, int irq)=0A=
 	pctrl->chip.base =3D -1;=0A=
 	pctrl->irq =3D irq;=0A=
 =0A=
+=0A=
 	ret =3D gpiochip_add_data(&pctrl->chip, pctrl);=0A=
 	if (ret) {=0A=
 		dev_err(pctrl->dev, "failed to register gpiochip\n");=0A=
@@ -900,20 +990,28 @@ static int intel_gpio_probe(struct intel_pinctrl *pct=
rl, int irq)=0A=
 		goto fail;=0A=
 	}=0A=
 =0A=
+	if (IS_ENABLED(CONFIG_IPIPE))=0A=
+	{	=0A=
+		irq_set_chained_handler_and_data(irq,=0A=
+					ipipe_irq_cascade,pctrl);=0A=
+	}=0A=
+	else {=0A=
 	/*=0A=
 	 * We need to request the interrupt here (instead of providing chip=0A=
 	 * to the irq directly) because on some platforms several GPIO=0A=
 	 * controllers share the same interrupt line.=0A=
 	 */=0A=
-	ret =3D devm_request_irq(pctrl->dev, irq, intel_gpio_irq, IRQF_SHARED,=0A=
-			       dev_name(pctrl->dev), pctrl);=0A=
-	if (ret) {=0A=
-		dev_err(pctrl->dev, "failed to request interrupt\n");=0A=
-		goto fail;=0A=
+		ret =3D devm_request_irq(pctrl->dev, irq, intel_gpio_irq,=0A=
+					IRQF_SHARED | IRQF_NO_THREAD,=0A=
+					dev_name(pctrl->dev), pctrl);=0A=
+		if (ret) {=0A=
+			dev_err(pctrl->dev, "failed to request interrupt\n");=0A=
+			goto fail;=0A=
+		}=0A=
 	}=0A=
 =0A=
 	ret =3D gpiochip_irqchip_add(&pctrl->chip, &intel_gpio_irqchip, 0,=0A=
-				   handle_simple_irq, IRQ_TYPE_NONE);=0A=
+				   handle_level_irq, IRQ_TYPE_NONE);=0A=
 	if (ret) {=0A=
 		dev_err(pctrl->dev, "failed to add irqchip\n");=0A=
 		goto fail;=0A=
@@ -921,6 +1019,8 @@ static int intel_gpio_probe(struct intel_pinctrl *pctr=
l, int irq)=0A=
 =0A=
 	gpiochip_set_chained_irqchip(&pctrl->chip, &intel_gpio_irqchip, irq,=0A=
 				     NULL);=0A=
+=0A=
+=0A=
 	return 0;=0A=
 =0A=
 fail:=0A=
@@ -981,7 +1081,7 @@ int intel_pinctrl_probe(struct platform_device *pdev,=
=0A=
 =0A=
 	pctrl->dev =3D &pdev->dev;=0A=
 	pctrl->soc =3D soc_data;=0A=
-	spin_lock_init(&pctrl->lock);=0A=
+	raw_spin_lock_init(&pctrl->lock);=0A=
 =0A=
 	/*=0A=
 	 * Make a copy of the communities which we can use to hold pointers=0A=
=0A=
Note: I am working on kernel version 4.4.43, hence there are some differenc=
es from the recent version of pinctrl-intel.=0A=
For example, I had to change the spinlocks into raw spinlocks. =0A=
=0A=
regards,=0A=
Nitin =0A=
________________________________________=0A=
From: Philippe Gerum <rpm@xenomai.org>=0A=
Sent: Wednesday, June 14, 2017 10:27 AM=0A=
To: Nitin Kulkarni; xenomai@xenomai.org=0A=
Subject: Re: [Xenomai] Problem with gpio interrupts for xenomai3 on Intel j=
oule=0A=
=0A=
On 06/12/2017 01:02 PM, Nitin Kulkarni wrote:=0A=
> Hi Philippe,=0A=
> Correcting the subject of this thread and adding it to the mailing list.=
=0A=
> Thanks for those precise code suggestions. There are two issues.=0A=
>=0A=
> 1. I found that the ipipe_irq_cascade handler is called but the problem i=
s that=0A=
> there are 5 pinctrl devices on this soc and all of them share the same ir=
q line. Hence I see that the intel_gpio_probe()=0A=
> runs for all the 5 pin controllers during kernel initialization and overw=
rites the irq descriptor with respective pinctrl data each time the probe r=
uns.=0A=
> When the interrupt is triggered ipipe_irq_cascade invoked with the irq de=
sc, I always see that the pinctrl data retrieved from=0A=
> irq_desc using  irq_desc_get_handler_data is always the last pinctrl. Hen=
ce I do not read the right pinctrl to call intel_gpio_irq() and read the ri=
ght interrupt enable reg for the gpio pin I enabled as interrupt.=0A=
>=0A=
> 2. When I forced it to read the right pinctrl data by storing that inform=
ation when intel_gpio_irq_enable is executed.=0A=
> The rtdm handller from my module is executed but the ack call intel_gpio_=
irq_ack is not called. Hence the irq flags were never cleared and the mmc d=
river also starts complaining about interrupts not being received. The whol=
e system slows down and virtually hangs.=0A=
>=0A=
> *I tried some fixes*=0A=
> -> I changed the flow handler type from handle_simple_irq to handle_edge_=
irq  while calling  gpiochip_irqchip_add()=0A=
>   in intel_gpio_probe.=0A=
> -> I called the ack function in ipipe_irq_cascade using the irq_desc whic=
h it has.=0A=
> It seems to work perfectly with this fix but this is a raw and a hackish =
way of doing. I am not sure if this has any consequences.=0A=
> Can you suggest me whats wrong with the ack not being called and how to d=
eal with multiple pinctrl devices sharing the same irq.=0A=
>=0A=
=0A=
Please send a patch including your changes; it should be easier to=0A=
review and comment.=0A=
=0A=
--=0A=
Philippe.=0A=

