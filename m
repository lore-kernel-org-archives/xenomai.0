From: Nitin Kulkarni <nitink@kth.se>
Date: Mon, 12 Jun 2017 11:02:15 +0000
Message-ID: <1497265336521.90775@kth.se>
References: <mailman.117.1496166485.4225.xenomai@xenomai.org>
 <1496167354451.78382@kth.se>
 <e1ed397b-c902-7b7d-5d1c-e78d9c5f8bf0@xenomai.org>
 <1496226896420.15161@kth.se>,
 <78c2df60-f9d8-ff4e-a53d-1b64e4af5c4a@xenomai.org>,
 <1497222185664.65276@kth.se>
In-Reply-To: <1497222185664.65276@kth.se>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Problem with gpio interrupts for xenomai3 on Intel joule
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Philippe,=0A=
Correcting the subject of this thread and adding it to the mailing list.=0A=
Thanks for those precise code suggestions. There are two issues.=0A=
=0A=
1. I found that the ipipe_irq_cascade handler is called but the problem is =
that=0A=
there are 5 pinctrl devices on this soc and all of them share the same irq =
line. Hence I see that the intel_gpio_probe()=0A=
runs for all the 5 pin controllers during kernel initialization and overwri=
tes the irq descriptor with respective pinctrl data each time the probe run=
s.=0A=
When the interrupt is triggered ipipe_irq_cascade invoked with the irq desc=
, I always see that the pinctrl data retrieved from=0A=
irq_desc using  irq_desc_get_handler_data is always the last pinctrl. Hence=
 I do not read the right pinctrl to call intel_gpio_irq() and read the righ=
t interrupt enable reg for the gpio pin I enabled as interrupt.=0A=
=0A=
2. When I forced it to read the right pinctrl data by storing that informat=
ion when intel_gpio_irq_enable is executed.=0A=
The rtdm handller from my module is executed but the ack call intel_gpio_ir=
q_ack is not called. Hence the irq flags were never cleared and the mmc dri=
ver also starts complaining about interrupts not being received. The whole =
system slows down and virtually hangs.=0A=
=0A=
*I tried some fixes*=0A=
-> I changed the flow handler type from handle_simple_irq to handle_edge_ir=
q  while calling  gpiochip_irqchip_add()=0A=
  in intel_gpio_probe.=0A=
-> I called the ack function in ipipe_irq_cascade using the irq_desc which =
it has.=0A=
It seems to work perfectly with this fix but this is a raw and a hackish wa=
y of doing. I am not sure if this has any consequences.=0A=
Can you suggest me whats wrong with the ack not being called and how to dea=
l with multiple pinctrl devices sharing the same irq.=0A=
=0A=
Regards,=0A=
Nitin=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
From: Philippe Gerum <rpm@xenomai.org>=0A=
Sent: Thursday, June 1, 2017 9:11 AM=0A=
To: Nitin Kulkarni; xenomai@xenomai.org=0A=
Subject: Re: [Xenomai] problem gpio interrupts xenomai3 on the raspberry pi=
 2 (or 3)=0A=
=0A=
On 05/31/2017 12:34 PM, Nitin Kulkarni wrote:=0A=
> This is the output from /proc/interrupts  (Note: irq 300 is the one I hav=
e requested )=0A=
>=0A=
>  root@intel-corei7-64:~# cat /proc/interrupts=0A=
>             CPU0       CPU1       CPU2       CPU3=0A=
=0A=
[snip]=0A=
=0A=
>  142:          0          0          0          0  intel-gpio   19  bq258=
90_irq=0A=
>  300:          0          0          0          0  intel-gpio   22  test_=
interrupt=0A=
=0A=
[snip]=0A=
=0A=
>  373:          0          0          0          0  bxtwc_irq_chip_level2 =
   0  pmic_thermal=0A=
>  374:          0          0          0          0  bxtwc_irq_chip_level2 =
   1  pmic_thermal=0A=
>  375:          0          0          0          0  bxtwc_irq_chip_level2 =
   2  pmic_thermal=0A=
>  383:          1          0          0          0  Whiskey Cove    7  ACP=
I:Event=0A=
>  470:          1          0          0          0  bxtwc_irq_chip_level2 =
   7  bxt_wcove_gpio=0A=
>  471:          1          0          0          0  bxtwc_irq_chip_level2 =
   5  wcove_typec=0A=
>  472:          0          0          0          0  bxtwc_irq_chip_tmu   1=
0  bxt_wcove_tmu=0A=
=0A=
There are several IRQ chip controllers which are not I-pipe aware on this S=
oc. The bxtwc and the pin controller allow multiple GPIO modules to sit on =
the same IRQ vector (IRQF_SHARED), this is not going to work with pipelined=
 interrupts, at least not with the current implementation of  the I-pipe pa=
tch (at some point in the future this will be the case, but we are not ther=
e yet). We can still fix the situation for a single GPIO module per IRQ lin=
e though.=0A=
=0A=
This is how I would fix up the code for the pin controller driver you are i=
nterested in; not tested, not even compiled, just some hints about the way =
to do it. Until there are fixups for the other drivers (bxtwc abd whiskey c=
ove), you may want to disable them, only to make sure that they won't freak=
 out if/when receiving an interrupt.=0A=
=0A=
diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/=
pinctrl-intel.c=0A=
index 0144376..f8bf54b 100644=0A=
--- a/drivers/pinctrl/intel/pinctrl-intel.c=0A=
+++ b/drivers/pinctrl/intel/pinctrl-intel.c=0A=
@@ -91,7 +91,11 @@ struct intel_pinctrl_context {=0A=
  */=0A=
 struct intel_pinctrl {=0A=
        struct device *dev;=0A=
+#ifdef CONFIG_IPIPE=0A=
+       ipipe_spinlock_t lock;=0A=
+#else=0A=
        raw_spinlock_t lock;=0A=
+#endif=0A=
        struct pinctrl_desc pctldesc;=0A=
        struct pinctrl_dev *pctldev;=0A=
        struct gpio_chip chip;=0A=
@@ -647,15 +651,13 @@ static const struct gpio_chip intel_gpio_chip =3D {=
=0A=
        .set =3D intel_gpio_set,=0A=
 };=0A=
=0A=
-static void intel_gpio_irq_ack(struct irq_data *d)=0A=
+static void __intel_gpio_irq_ack(struct irq_data *d)=0A=
 {=0A=
        struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);=0A=
        struct intel_pinctrl *pctrl =3D gpiochip_get_data(gc);=0A=
        const struct intel_community *community;=0A=
        unsigned pin =3D irqd_to_hwirq(d);=0A=
=0A=
-       raw_spin_lock(&pctrl->lock);=0A=
-=0A=
        community =3D intel_get_community(pctrl, pin);=0A=
        if (community) {=0A=
                unsigned padno =3D pin_to_padno(community, pin);=0A=
@@ -664,7 +666,14 @@ static void intel_gpio_irq_ack(struct irq_data *d)=0A=
=0A=
                writel(BIT(gpp_offset), community->regs + GPI_IS + gpp * 4)=
;=0A=
        }=0A=
+}=0A=
=0A=
+static void intel_gpio_irq_ack(struct irq_data *d)=0A=
+{=0A=
+       struct intel_pinctrl *pctrl =3D gpiochip_get_data(gc);=0A=
+=0A=
+       raw_spin_lock(&pctrl->lock);=0A=
+       __intel_gpio_irq_ack(d);=0A=
        raw_spin_unlock(&pctrl->lock);=0A=
 }=0A=
=0A=
@@ -694,18 +703,17 @@ static void intel_gpio_irq_enable(struct irq_data *d)=
=0A=
                writel(value, community->regs + community->ie_offset + gpp =
* 4);=0A=
        }=0A=
=0A=
+       ipipe_unlock_irq(d->irq);=0A=
+=0A=
        raw_spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
 }=0A=
=0A=
-static void intel_gpio_irq_mask_unmask(struct irq_data *d, bool mask)=0A=
+static void __intel_gpio_irq_mask_unmask(struct irq_data *d, bool mask)=0A=
 {=0A=
        struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);=0A=
        struct intel_pinctrl *pctrl =3D gpiochip_get_data(gc);=0A=
        const struct intel_community *community;=0A=
        unsigned pin =3D irqd_to_hwirq(d);=0A=
-       unsigned long flags;=0A=
-=0A=
-       raw_spin_lock_irqsave(&pctrl->lock, flags);=0A=
=0A=
        community =3D intel_get_community(pctrl, pin);=0A=
        if (community) {=0A=
@@ -723,20 +731,55 @@ static void intel_gpio_irq_mask_unmask(struct irq_dat=
a *d, bool mask)=0A=
                        value |=3D BIT(gpp_offset);=0A=
                writel(value, reg);=0A=
        }=0A=
-=0A=
-       raw_spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
 }=0A=
=0A=
 static void intel_gpio_irq_mask(struct irq_data *d)=0A=
 {=0A=
-       intel_gpio_irq_mask_unmask(d, true);=0A=
+       struct intel_pinctrl *pctrl =3D gpiochip_get_data(gc);=0A=
+       unsigned long flags;=0A=
+=0A=
+       raw_spin_lock_irqsave(&pctrl->lock, flags);=0A=
+       ipipe_lock_irq(d->irq);=0A=
+       __intel_gpio_irq_mask_unmask(d, true);=0A=
+       raw_spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
 }=0A=
=0A=
 static void intel_gpio_irq_unmask(struct irq_data *d)=0A=
 {=0A=
-       intel_gpio_irq_mask_unmask(d, false);=0A=
+       struct intel_pinctrl *pctrl =3D gpiochip_get_data(gc);=0A=
+       unsigned long flags;=0A=
+=0A=
+       raw_spin_lock_irqsave(&pctrl->lock, flags);=0A=
+       __intel_gpio_irq_mask_unmask(d, false);=0A=
+       ipipe_unlock_irq(d->irq);=0A=
+       raw_spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
+}=0A=
+=0A=
+#ifdef CONFIG_IPIPE=0A=
+=0A=
+static void intel_gpio_irq_hold(struct irq_data *d)=0A=
+{=0A=
+       struct intel_pinctrl *pctrl =3D gpiochip_get_data(gc);=0A=
+       unsigned long flags;=0A=
+=0A=
+       raw_spin_lock_irqsave(&pctrl->lock, flags);=0A=
+       __intel_gpio_irq_mask_unmask(d, true);=0A=
+       __intel_gpio_irq_ack(d);=0A=
+       raw_spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
+}=0A=
+=0A=
+static void intel_gpio_irq_release(struct irq_data *d)=0A=
+{=0A=
+       struct intel_pinctrl *pctrl =3D gpiochip_get_data(gc);=0A=
+       unsigned long flags;=0A=
+=0A=
+       raw_spin_lock_irqsave(&pctrl->lock, flags);=0A=
+       __intel_gpio_irq_mask_unmask(d, false);=0A=
+       raw_spin_unlock_irqrestore(&pctrl->lock, flags);=0A=
 }=0A=
=0A=
+#endif=0A=
+=0A=
 static int intel_gpio_irq_type(struct irq_data *d, unsigned type)=0A=
 {=0A=
        struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);=0A=
@@ -837,7 +880,7 @@ static irqreturn_t intel_gpio_community_irq_handler(str=
uct intel_pinctrl *pctrl,=0A=
=0A=
                        irq =3D irq_find_mapping(gc->irqdomain,=0A=
                                               community->pin_base + padno)=
;=0A=
-                       generic_handle_irq(irq);=0A=
+                       ipipe_handle_demuxed_irq(irq);=0A=
=0A=
                        ret |=3D IRQ_HANDLED;=0A=
                }=0A=
@@ -862,6 +905,14 @@ static irqreturn_t intel_gpio_irq(int irq, void *data)=
=0A=
        return ret;=0A=
 }=0A=
=0A=
+static void ipipe_irq_cascade(struct irq_desc *desc)=0A=
+{=0A=
+#ifdef CONFIG_IPIPE=0A=
+       intel_gpio_irq(irq_desc_get_irq(desc),=0A=
+                      irq_desc_get_handler_data(desc));=0A=
+#endif=0A=
+}=0A=
+=0A=
 static struct irq_chip intel_gpio_irqchip =3D {=0A=
        .name =3D "intel-gpio",=0A=
        .irq_enable =3D intel_gpio_irq_enable,=0A=
@@ -870,6 +921,10 @@ static struct irq_chip intel_gpio_irqchip =3D {=0A=
        .irq_unmask =3D intel_gpio_irq_unmask,=0A=
        .irq_set_type =3D intel_gpio_irq_type,=0A=
        .irq_set_wake =3D intel_gpio_irq_wake,=0A=
+#ifdef CONFIG_IPIPE=0A=
+       .irq_hold =3D intel_gpio_irq_hold,=0A=
+       .irq_release =3D intel_gpio_irq_release,=0A=
+#endif=0A=
 };=0A=
=0A=
 static int intel_gpio_probe(struct intel_pinctrl *pctrl, int irq)=0A=
@@ -902,12 +957,17 @@ static int intel_gpio_probe(struct intel_pinctrl *pct=
rl, int irq)=0A=
         * to the irq directly) because on some platforms several GPIO=0A=
         * controllers share the same interrupt line.=0A=
         */=0A=
-       ret =3D devm_request_irq(pctrl->dev, irq, intel_gpio_irq,=0A=
-                              IRQF_SHARED | IRQF_NO_THREAD,=0A=
-                              dev_name(pctrl->dev), pctrl);=0A=
-       if (ret) {=0A=
-               dev_err(pctrl->dev, "failed to request interrupt\n");=0A=
-               goto fail;=0A=
+       if (IS_ENABLED(CONFIG_IPIPE))=0A=
+               irq_set_chained_handler_and_data(irq,=0A=
+                                       ipipe_irq_cascade, pctrl);=0A=
+       else {=0A=
+               ret =3D devm_request_irq(pctrl->dev, irq, intel_gpio_irq,=
=0A=
+                                      IRQF_SHARED | IRQF_NO_THREAD,=0A=
+                                      dev_name(pctrl->dev), pctrl);=0A=
+               if (ret) {=0A=
+                       dev_err(pctrl->dev, "failed to request interrupt\n"=
);=0A=
+                       goto fail;=0A=
+               }=0A=
        }=0A=
=0A=
        ret =3D gpiochip_irqchip_add(&pctrl->chip, &intel_gpio_irqchip, 0,=
=0A=
=0A=
--=0A=
Philippe.=0A=

