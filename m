Message-ID: <d6c8ef150803140339m4e2d4520gefde18747eda5b68@domain.hid>
Date: Fri, 14 Mar 2008 11:39:51 +0100
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <d6c8ef150803140241s438d6d5bo6240a406fc988ffa@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0803120923m76f75bder857abac049c22e4d@domain.hid>
	<d6c8ef150803130409g2a618d30gbede878d6a09e470@domain.hid>
	<d6c8ef150803131013p152b79fah70d97ee1429e86e9@domain.hid>
	<2ff1a98a0803131051v43dea811r67b5a81e7d32ba62@domain.hid>
	<d6c8ef150803140241s438d6d5bo6240a406fc988ffa@domain.hid>
Subject: Re: [Adeos-main] New I-pipe patch for ARM.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Here is the patch solving the problem. I have a "feeling" that maybe
there is some kind of performance issue, but not sure. I'll test that
later.

--- gpio.c	2008-03-14 11:31:33.000000000 +0100
+++ gpio.c-new	2008-03-14 11:38:35.000000000 +0100
@@ -442,19 +442,26 @@
 	struct irq_desc *desc = &irq_desc[irq];
 	unsigned	pin;
 	struct irq_desc	*gpio;
+	struct at91_gpio_bank *bank;
 	void __iomem	*pio;
 	u32		isr;

-	pio = get_irq_chip_data(irq);
+	bank = get_irq_chip_data(irq);
+	pio = bank->regbase;

 	/* temporarily mask (level sensitive) parent IRQ */
 	desc->chip->ack(irq);
 	for (;;) {
 		isr = __raw_readl(pio + PIO_ISR) & __raw_readl(pio + PIO_IMR);
-		if (!isr)
-			break;
+		if (!isr) {
+			if (!bank->next)
+				break;
+			bank = bank->next;
+			pio = bank->regbase;
+			continue;
+		}

-		pin = (unsigned) get_irq_data(irq);
+		pin = bank->chipbase;
 		gpio = &irq_desc[pin];

 		while (isr) {

On Fri, Mar 14, 2008 at 10:41 AM, Bosko Radivojevic
<bosko.radivojevic@domain.hid> wrote:
> On Thu, Mar 13, 2008 at 6:51 PM, Gilles Chanteperdrix
>  <gilles.chanteperdrix@xenomai.org> wrote:
>
>  >  Ok. The code which does this is __ipipe_mach_demux_irq in
>  >  arch/arm/mach-at91/gpio.c. Could you check if at least it triggers ?
>
>  I put the following code into __ipipe_mach_demux_irq() in mach-at91/gpio.c:
>
>  [..]
>         void __iomem    *pio;
>         u32             isr;
>
>  printk (KERN_INFO "__ipipe_mach_demux_irq: irq=%d\n", irq);
>         pio = get_irq_chip_data(irq);
>  printk (KERN_INFO "__ipipe_mach_demux_irq: pio=%x\n", pio);
>  [..]
>         for (;;) {
>                 isr = __raw_readl(pio + PIO_ISR) & __raw_readl(pio + PIO_IMR);
>  printk (KERN_INFO "__ipipe_mach_demux_irq: isr=%x\n", isr);
>                 if (!isr) {
>  printk (KERN_INFO "__ipipe_mach_demux_irq: !isr\n");
>                         break;
>                 }
>                 pin = (unsigned) get_irq_data(irq);
>  printk (KERN_INFO "__ipipe_mach_demux_irq: pin: %d\n", pin);
>  [...]
>
>  And all I get is just once (first time I send a packet):
>  __ipipe_mach_demux_irq: irq=3
>  __ipipe_mach_demux_irq: pio=c02203d8
>  __ipipe_mach_demux_irq: isr=0
>  __ipipe_mach_demux_irq: !isr
>
>  Maybe pio is wrongly calculated in get_irq_chip_data()?
>

