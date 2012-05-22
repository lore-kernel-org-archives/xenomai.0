Message-ID: <4FBB88A8.7030209@xenomai.org>
Date: Tue, 22 May 2012 14:38:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FBADE7D.5030609@bbn.com>, <4FBB4951.5070803@xenomai.org>
	<C7408997F5B0784C970ED53C11855FAE01111233915D@INSITEOSBS01.insiteo.local>,
	<4FBB5393.5040003@xenomai.org>
	<C7408997F5B0784C970ED53C11855FAE011112339161@INSITEOSBS01.insiteo.local>
In-Reply-To: <C7408997F5B0784C970ED53C11855FAE011112339161@INSITEOSBS01.insiteo.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RE : RE : A possible mis-interaction between
 CONFIG_PREEMPT and GPIO IRQ handling for ARM, leading to extreme latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jean-Pascal JULIEN <jean-pascal.julien@insiteo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/22/2012 01:52 PM, Jean-Pascal JULIEN wrote:
> Gilles,
> 
> I have tested the new patch but i have the same result.
> i have a logic analyzer who monitored the irq and the answer to the irq.
> Below two  acquisitions with response latency higher than 1ms :
> 
>        ******       ******       ******       ******       ******       ******
> ******       ******       ******       ******       ******       ******       ****** the irq input on GPIO (2KHz)
> 
>        *****************        ***********               ************                first acquisition
> ******                      ******              ************               *********** the toggle of the output GPIO on IRQ
> 
> 
>        ***********************        ***********               ************        second acquisition
> ******                             ******              ************               ****** the toggle of the output GPIO on IRQ
> 
> My irq on the linux space is : (cat /proc/interrupts).
>          CPU0
>   7:       6005        INTC  TWL4030-PIH
>  11:          0        INTC  prcm
>  12:      84772        INTC  DMA
>  25:          4        INTC  OMAP DSS
>  38:     589982        INTC  gp timer
>  56:     138661        INTC  omap_i2c
>  61:       1015        INTC  omap_i2c
>  72:          3        INTC  serial idle
>  73:          0        INTC  serial idle
>  74:        280        INTC  serial idle, OMAP UART2
>  77:          0        INTC  ehci_hcd:usb2
>  83:      31139        INTC  mmc0
>  86:         26        INTC  mmc1
>  92:          0        INTC  musb-hdrc
>  93:          0        INTC  musb-hdrc
> 336:     291209        GPIO  eth0
> 371:          0     twl4030  twl4030_madc
> 378:          0     twl4030  twl4030_usb
> 379:       6005     twl4030  rtc0
> 
> My irq in the xenomai space are: (cat /proc/xenomai/irq).
> IRQ         CPU0
>  38:      603343         [timer]
> 307:     2956569         XENO_IRQ_RECEIVE
> 418:           0         [virtual]
> 
> 
> What kind of test do you need, for help me to solve my problem?

Please try the following (completely untested) patch. If it still
does not, try and do what Mitchell did: use the I-pipe tracer, and
show us the trace corresponding to the bug you observe.

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 25c17a3..3e5a88d 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1221,7 +1221,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
-static void gpio_demux_inner(struct gpio_bank *bank, u32 isr, int nonroot)
+static void gpio_demux_inner(struct gpio_bank *bank, u32 isr)
 {
 	unsigned int gpio_irq, gpio_index;
 
@@ -1230,13 +1230,6 @@ static void gpio_demux_inner(struct gpio_bank *bank, u32 isr, int nonroot)
 		if (!(isr & 1))
 			continue;
 
-#ifdef CONFIG_IPIPE
-		if (!nonroot) {
-			local_irq_enable_hw();
-			local_irq_disable_hw();
-		}
-#endif /* CONFIG_IPIPE */
-
 #ifdef CONFIG_ARCH_OMAP1
 		gpio_index = get_gpio_index(irq_to_gpio(gpio_irq));
 
@@ -1272,11 +1265,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	u32 retrigger = 0;
 	int unmasked = 0;
 
-#ifndef CONFIG_IPIPE
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
-#else /* CONFIG_IPIPE */
-	desc->irq_data.chip->irq_mask_ack(&desc->irq_data);
-#endif /* CONFIG_IPIPE */
 
 	bank = get_irq_data(irq);
 #ifdef CONFIG_ARCH_OMAP1
@@ -1312,13 +1301,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		u32 isr_saved, level_mask = 0;
 		u32 enabled;
 
-#ifdef CONFIG_IPIPE
-		if (!bank->nonroot_gpios) {
-			local_irq_enable_hw();
-			local_irq_disable_hw();
-		}
-#endif /* CONFIG_IPIPE */
-
 		enabled = _get_gpio_irqbank_mask(bank);
 		isr_saved = isr = __raw_readl(isr_reg) & enabled;
 
@@ -1336,27 +1318,19 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		_clear_gpio_irqbank(bank, isr_saved & ~level_mask);
 		_enable_gpio_irqbank(bank, isr_saved & ~level_mask, 1);
 
-#ifndef CONFIG_IPIPE
 		/* if there is only edge sensitive GPIO pin interrupts
 		configured, we could unmask GPIO bank interrupt immediately */
 		if (!level_mask && !unmasked) {
 			unmasked = 1;
 			desc->irq_data.chip->irq_unmask(&desc->irq_data);
 		}
-#endif /* !CONFIG_IPIPE */
 
 		isr |= retrigger;
 		retrigger = 0;
 		if (!isr)
 			break;
 
-#ifdef CONFIG_IPIPE
-		if (bank->nonroot_gpios)
-			gpio_demux_inner(bank, isr & bank->nonroot_gpios, 1);
-		gpio_demux_inner(bank, isr & ~bank->nonroot_gpios, 0);
-#else /* !CONFIG_IPIPE */
-		gpio_demux_inner(bank, isr, 0);
-#endif /* !CONFIG_IPIPE */
+		gpio_demux_inner(bank, isr);
 
 	}
 	/* if bank has any level sensitive GPIO pin interrupt


-- 
					    Gilles.

