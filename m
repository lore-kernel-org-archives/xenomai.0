Message-ID: <4F1AE22D.4070509@domain.hid>
Date: Sat, 21 Jan 2012 17:05:01 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C65BAE4E2DF04BD68697066C4075EC78@domain.hid>
	<4F19B046.6090504@domain.hid>
	<D2F2766145E048789E0063D6F386E760@domain.hid>
	<4F19B324.8080001@domain.hid>
	<DE531AD0193E45018B21711AD3A8DB03@domain.hid>
In-Reply-To: <DE531AD0193E45018B21711AD3A8DB03@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtdm difficulties
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Terry Fryar <terry.fryar@domain.hid>
Cc: xenomai@xenomai.org

On 01/20/2012 08:37 PM, Terry Fryar wrote:
> Ok, I'll try the patch.  A question though...on the beagle, there is a OMAP
> register GPIO_IRQSTATUSx that I am not manually clearing out.  This is the
> only place to ack an irq I know of...I assumed that was being handled by the
> kernel?  Or is this what the patch is adding??  I'm very new to writing irq
> handlers, as you can tell!

I am not sure what you are talking about, but I guess you do not have 
to clear anything on the omap side, the irq demuxing side should take 
care about it.

The problem you have look like the edge irq is ticking to fast, and 
causing an overflow because we are re-enabling irqs in the middle of 
the irq demuxing code. So, if the patch I sent does not solve the 
issue, please try the following one. Note that if the irq is indeed 
ticking to fast, you are going to replace the stack overflow with a 
complete lock-up.

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 30cb7d4..9c9b6d7 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1229,13 +1229,14 @@ static void gpio_demux_inner(struct gpio_bank *bank, u32 isr, int nonroot)
 	for (; isr != 0; isr >>= 1, gpio_irq++) {
 		if (!(isr & 1))
 			continue;
-
+#if 0
 #ifdef CONFIG_IPIPE
 		if (nonroot) {
 			local_irq_enable_hw();
 			local_irq_disable_hw();
 		}
 #endif /* CONFIG_IPIPE */
+#endif
 
 #ifdef CONFIG_ARCH_OMAP1
 		gpio_index = get_gpio_index(irq_to_gpio(gpio_irq));
@@ -1308,12 +1309,14 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		u32 isr_saved, level_mask = 0;
 		u32 enabled;
 
+#if 0
 #ifdef CONFIG_IPIPE
 		if (!bank->nonroot_gpios) {
 			local_irq_enable_hw();
 			local_irq_disable_hw();
 		}
 #endif /* CONFIG_IPIPE */
+#endif
 
 		enabled = _get_gpio_irqbank_mask(bank);
 		isr_saved = isr = __raw_readl(isr_reg) & enabled;

-- 
                                                                Gilles.

