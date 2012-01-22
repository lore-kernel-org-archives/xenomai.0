From: "Terry Fryar" <terry.fryar@domain.hid>
References: <C65BAE4E2DF04BD68697066C4075EC78@domain.hid>
	<4F19B046.6090504@domain.hid>
	<D2F2766145E048789E0063D6F386E760@domain.hid>
	<4F19B324.8080001@domain.hid>
	<DE531AD0193E45018B21711AD3A8DB03@domain.hid>
	<4F1AE22D.4070509@domain.hid>
In-Reply-To: <4F1AE22D.4070509@domain.hid>
Date: Sun, 22 Jan 2012 17:32:46 -0600
Message-ID: <132E775E779D4C6A821C8E2C461DA578@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

I think the irq ticking to fast is correct....these are firing very, very
quickly, and if I clear out the irq flag register myself in the isr, it
works for quite a while.  If I don't, the stack overflows pretty fast.  I'll
try both patches and report back.

I'm not sure what the kernel does with the irq status register in the omap
code, but if this was a microprocessor binary, I'd have to reset the
register flags in my isr myself, since there's no o/s to do it.  I wasn't
sure in the linux world if this was required...I assumed it was not, as you
said, but clearing it out in the middle of the isr does help prevent so many
irq's from ticking and greatly improves the odds against a stack overflow.
I have noticed I am now (with little load) able to have irq latency around
1.8us....pretty fast!

I'll let you know how the patches fare......

Thanks Gilles & Philippe!!  Your help is always much appreciated!!

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
Sent: Saturday, January 21, 2012 10:05 AM
To: Terry Fryar
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] rtdm difficulties

On 01/20/2012 08:37 PM, Terry Fryar wrote:
> Ok, I'll try the patch.  A question though...on the beagle, there is a 
> OMAP register GPIO_IRQSTATUSx that I am not manually clearing out.  
> This is the only place to ack an irq I know of...I assumed that was 
> being handled by the kernel?  Or is this what the patch is adding??  
> I'm very new to writing irq handlers, as you can tell!

I am not sure what you are talking about, but I guess you do not have to
clear anything on the omap side, the irq demuxing side should take care
about it.

The problem you have look like the edge irq is ticking to fast, and causing
an overflow because we are re-enabling irqs in the middle of the irq
demuxing code. So, if the patch I sent does not solve the issue, please try
the following one. Note that if the irq is indeed ticking to fast, you are
going to replace the stack overflow with a complete lock-up.

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c index
30cb7d4..9c9b6d7 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1229,13 +1229,14 @@ static void gpio_demux_inner(struct gpio_bank *bank,
u32 isr, int nonroot)
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
@@ -1308,12 +1309,14 @@ static void gpio_irq_handler(unsigned int irq,
struct irq_desc *desc)
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


