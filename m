References: <56EBDBCE.3030800@sigmatek.at>
 <20160318111030.GE6555@hermes.click-hack.org> <56EBF155.6010006@sigmatek.at>
 <20160318122826.GA3345@hermes.click-hack.org>
From: Johann Obermayr <johann.obermayr@sigmatek.at>
Message-ID: <56F2776D.7060800@sigmatek.at>
Date: Wed, 23 Mar 2016 12:01:01 +0100
MIME-Version: 1.0
In-Reply-To: <20160318122826.GA3345@hermes.click-hack.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Subject: Re: [Xenomai] ipipe bug in gpio/irq for mx6
Reply-To: johann.obermayr@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Am 18.03.2016 um 13:28 schrieb Gilles Chanteperdrix:
> On Fri, Mar 18, 2016 at 01:15:17PM +0100, Johann Obermayr wrote:
>> Am 18.03.2016 um 12:10 schrieb Gilles Chanteperdrix:
>>> On Fri, Mar 18, 2016 at 11:43:26AM +0100, Johann Obermayr wrote:
>>>> Hello,
>>>>
>>>> in the the git branch ipipe-3.0-imx6q
>>> This I-pipe patch is really old now. Any chance to use a current
>>> version of Xenomai?
>> Not now. but we have started to change to 3.10.x with newer xenomai
>>>> in the file arch/arm/plat-mxc/gpio.c
>>>>
>>>> there is follow function.
>>>>
>>>> void __ipipe_mach_enable_irqdesc(struct ipipe_domain *ipd, unsigned ir=
q)
>>>> {
>>>>        struct irq_desc *desc =3D irq_to_desc(irq);
>>>>        struct irq_data *idata =3D irq_desc_get_irq_data(desc);
>>>>        struct irq_chip *chip =3D irq_data_get_irq_chip(idata);
>>>>
>>>>        if (chip =3D=3D &gpio_irq_chip) {
>>>>            /* It is a gpio. */
>>>>            u32 gpio =3D irq_to_gpio(irq);
>>>>            struct mxc_gpio_port *port =3D &mxc_gpio_ports[gpio / 32];
>>>>
>>>>            if (ipd !=3D &ipipe_root) {
>>>>                port->nonroot_gpios |=3D (1 << (gpio % 32));
>>>>                if (port->nonroot_gpios =3D=3D (1 << (gpio % 32))) {
>>>>                    __ipipe_irqbits[(port->irq / 32)]
>>>>                        &=3D ~(1 << (port->irq % 32));
>>>>                    set_irq_prio(port->irq, 1);
>>>>                }
>>>>            }
>>>>        } else
>>>>            set_irq_prio(irq, ipd !=3D &ipipe_root);
>>>> }
>>>>
>>>> But there is missing  set_irq_prio for the port->irq_high.
>>>> to add
>>>>                    if (port->irq_high > 0)
>>>>                        set_irq_prio(port->irq_high, 1);
>>>> is not my problem.
>>>>
>>>> my problem is, that i don't known if  __ipipe_irqbits is handled
>>>> correct.
>>> Well, if you want to set port->irq_high, you have to clear the
>>> corresponding bit in __ipipe_irqbits, as is done for port->irq.
>>>
>> Thank you Gilles.
>>
>> i've also take a part from newer version.
>> void __ipipe_mach_enable_irqdesc(struct ipipe_domain *ipd, unsigned irq)
>> {
>>       struct irq_desc *desc =3D irq_to_desc(irq);
>>       struct irq_data *idata =3D irq_desc_get_irq_data(desc);
>>       struct irq_chip *chip =3D irq_data_get_irq_chip(idata);
>>
>>       if (chip =3D=3D &gpio_irq_chip) {
>>           /* It is a gpio. */
>>           u32 gpio =3D irq_to_gpio(irq);
>>           struct mxc_gpio_port *port =3D &mxc_gpio_ports[gpio / 32];
>>
>>           if (ipd =3D=3D &ipipe_root) {
>>               port->nonroot_gpios &=3D ~(1 << (gpio % 32));
>>               if (port->nonroot_gpios =3D=3D 0) {
>>                   __ipipe_irqbits[(port->irq / 32)] &=3D ~(1 << (port->i=
rq
>> % 32));
>>                   __ipipe_irqbits[(port->irq_high / 32)] &=3D ~(1 <<
>> (port->irq_high % 32));
>>                   set_irq_prio(port->irq, 0);
>>                   if (port->irq_high > 0)
>>                       set_irq_prio(port->irq_high, 0);
>>               }
>>           } else {
>>               port->nonroot_gpios |=3D (1 << (gpio % 32));
>>               if (port->nonroot_gpios =3D=3D (1 << (gpio % 32))) {
>>                   __ipipe_irqbits[(port->irq / 32)] &=3D ~(1 << (port->i=
rq
>> % 32));
>>                   __ipipe_irqbits[(port->irq_high / 32)] &=3D ~(1 <<
>> (port->irq_high % 32));
>>                   set_irq_prio(port->irq, 1);
>>                   if (port->irq_high > 0)
>>                       set_irq_prio(port->irq_high, 1);
>>               }
>>           }
>>       } else
>>           set_irq_prio(irq, ipd !=3D &ipipe_root);
>> }
>>
>> is this correct to clear the the bit in __ipipe_irqbits also for ipd =3D=
=3D
>> ipipe_root ?
> It is useless, __ipipe_mach_enable_irqdesc for root irqs is called
> only once at boot time, when the bits are already cleared.
>
Here are my patches for imx.6 gpio irq handling.
also add patch for using edge select bit (irq raise/fall detection) on =

imx.6

Regards
    Johann

-------------- next part --------------
>From b806dcf59ec3cf1abc18318cce090b78e396dec6 Mon Sep 17 00:00:00 2001
From: Johann Obermayr <johann.obermayr@sigmatek.at>
Date: Fri, 18 Mar 2016 16:04:38 +0100
Subject: [PATCH] high irq for GPIO input not working.

---
 arch/arm/plat-mxc/gpio.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index 87b643e..3f5925a 100755
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -426,9 +426,12 @@ void __ipipe_mach_enable_irqdesc(struct ipipe_domain *=
ipd, unsigned irq)
 		if (ipd !=3D &ipipe_root) {
 			port->nonroot_gpios |=3D (1 << (gpio % 32));
 			if (port->nonroot_gpios =3D=3D (1 << (gpio % 32))) {
-				__ipipe_irqbits[(port->irq / 32)]
-					&=3D ~(1 << (port->irq % 32));
+				__ipipe_irqbits[(port->irq / 32)] &=3D ~(1 << (port->irq % 32));
 				set_irq_prio(port->irq, 1);
+				if (port->irq_high > 0) {
+					__ipipe_irqbits[(port->irq_high / 32)] &=3D ~(1 << (port->irq_high % =
32));
+					set_irq_prio(port->irq_high, 1);
+				}
 			}
 		}
 	} else
@@ -450,8 +453,11 @@ void __ipipe_mach_disable_irqdesc(struct ipipe_domain =
*ipd, unsigned irq)
 			port->nonroot_gpios &=3D ~(1 << (gpio % 32));
 			if (!port->nonroot_gpios) {
 				set_irq_prio(port->irq, 0);
-				__ipipe_irqbits[(port->irq / 32)]
-					|=3D (1 << (port->irq % 32));
+				__ipipe_irqbits[(port->irq / 32)] |=3D (1 << (port->irq % 32));
+				if (port->irq_high > 0) {
+					set_irq_prio(port->irq_high, 0);
+					__ipipe_irqbits[(port->irq_high / 32)] |=3D (1 << (port->irq_high % 3=
2));
+				}
 			}
 		}
 	} else if (ipd !=3D &ipipe_root)
-- =

1.7.9.5

-------------- next part --------------
>From 962417f6870aec76188f391a708fc05d54f6d94c Mon Sep 17 00:00:00 2001
From: Johann Obermayr <johann.obermayr@sigmatek.at>
Date: Mon, 21 Mar 2016 17:14:18 +0100
Subject: [PATCH] use edge select bit to activate raise/fall irq detection.

---
 arch/arm/plat-mxc/gpio.c |   51 ++++++++++++++++++++++++++++++++----------=
----
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index 3f5925a..c1caa6b 100755
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -31,6 +31,7 @@
 =

 static struct mxc_gpio_port *mxc_gpio_ports;
 static int gpio_table_size;
+static int GPIO_EDGE_SEL =3D -1;
 =

 #define cpu_is_mx1_mx2()	(cpu_is_mx1() || cpu_is_mx2())
 =

@@ -46,7 +47,7 @@ static int gpio_table_size;
 #define GPIO_INT_HIGH_LEV	(cpu_is_mx1_mx2() ? 0x2 : 0x1)
 #define GPIO_INT_RISE_EDGE	(cpu_is_mx1_mx2() ? 0x0 : 0x2)
 #define GPIO_INT_FALL_EDGE	(cpu_is_mx1_mx2() ? 0x1 : 0x3)
-#define GPIO_INT_NONE		0x4
+#define GPIO_INT_BOTH_EDGES	0x4
 =

 /* Note: This driver assumes 32 GPIOs are handled in one register */
 =

@@ -93,8 +94,9 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
 	u32 bit, val;
 	int edge;
 	void __iomem *reg =3D port->base;
+	u32 gpio_idx =3D gpio & 31;
 =

-	port->both_edges &=3D ~(1 << (gpio & 31));
+	port->both_edges &=3D ~(1 << gpio_idx);
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
 		edge =3D GPIO_INT_RISE_EDGE;
@@ -103,15 +105,19 @@ static int gpio_set_irq_type(struct irq_data *d, u32 =
type)
 		edge =3D GPIO_INT_FALL_EDGE;
 		break;
 	case IRQ_TYPE_EDGE_BOTH:
-		val =3D mxc_gpio_get(&port->chip, gpio & 31);
-		if (val) {
-			edge =3D GPIO_INT_LOW_LEV;
-			pr_debug("mxc: set GPIO %d to low trigger\n", gpio);
+		if (GPIO_EDGE_SEL >=3D 0) {
+			edge =3D GPIO_INT_BOTH_EDGES;
 		} else {
-			edge =3D GPIO_INT_HIGH_LEV;
-			pr_debug("mxc: set GPIO %d to high trigger\n", gpio);
+			val =3D mxc_gpio_get(&port->chip, gpio_idx);
+			if (val) {
+				edge =3D GPIO_INT_LOW_LEV;
+				pr_debug("mxc: set GPIO %d to low trigger\n", gpio);
+			} else {
+				edge =3D GPIO_INT_HIGH_LEV;
+				pr_debug("mxc: set GPIO %d to high trigger\n", gpio);
+			}
+			port->both_edges |=3D (1 << gpio_idx);
 		}
-		port->both_edges |=3D 1 << (gpio & 31);
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
 		edge =3D GPIO_INT_LOW_LEV;
@@ -124,11 +130,22 @@ static int gpio_set_irq_type(struct irq_data *d, u32 =
type)
 	}
 =

 	spin_lock_irqsave(&port->lock, flags);
-	reg +=3D GPIO_ICR1 + ((gpio & 0x10) >> 2); /* lower or upper register */
-	bit =3D gpio & 0xf;
-	val =3D __raw_readl(reg) & ~(0x3 << (bit << 1));
-	__raw_writel(val | (edge << (bit << 1)), reg);
-	_clear_gpio_irqstatus(port, gpio & 0x1f);
+	if (GPIO_EDGE_SEL >=3D 0) {
+		void __iomem *regsel =3D port->base + GPIO_EDGE_SEL;
+		val =3D __raw_readl(regsel);
+		if (edge =3D=3D GPIO_INT_BOTH_EDGES)
+			__raw_writel(val | (1 << gpio_idx), regsel);
+		else
+			__raw_writel(val & ~(1 << gpio_idx), regsel);
+	}
+
+	if (edge !=3D GPIO_INT_BOTH_EDGES) {
+		reg +=3D GPIO_ICR1 + ((gpio & 0x10) >> 2); /* lower or upper register */
+		bit =3D gpio & 0xf;
+		val =3D __raw_readl(reg) & ~(0x3 << (bit << 1));
+		__raw_writel(val | (edge << (bit << 1)), reg);
+	}
+	_clear_gpio_irqstatus(port, gpio_idx);
 	spin_unlock_irqrestore(&port->lock, flags);
 =

 	return 0;
@@ -330,7 +347,7 @@ int mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
 	mxc_gpio_ports =3D port;
 	gpio_table_size =3D cnt;
 =

-	printk(KERN_INFO "MXC GPIO hardware\n");
+	printk(KERN_INFO "MXC (%u) GPIO hardware\n", mxc_cpu_type);
 =

 	for (i =3D 0; i < cnt; i++) {
 		/* disable the interrupt and clear the status */
@@ -381,6 +398,10 @@ int mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
 		irq_set_handler_data(port[0].irq, port);
 	}
 =

+	/* mx35 or newer support edge select */
+	if (mxc_cpu_type >=3D MXC_CPU_MX35)
+		GPIO_EDGE_SEL =3D 0x1C;
+
 	return 0;
 }
 =

-- =

1.7.9.5

