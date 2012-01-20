Message-ID: <4F19B324.8080001@domain.hid>
Date: Fri, 20 Jan 2012 19:32:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C65BAE4E2DF04BD68697066C4075EC78@domain.hid>
	<4F19B046.6090504@domain.hid>
	<D2F2766145E048789E0063D6F386E760@domain.hid>
In-Reply-To: <D2F2766145E048789E0063D6F386E760@domain.hid>
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

On 01/20/2012 07:24 PM, Terry Fryar wrote:
> Yeh, omap and gpio.....edge irq from a square wave pulse.... 

Try this patch:

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 30cb7d4..114ccf0 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1272,7 +1272,7 @@ static void gpio_irq_handler(unsigned int irq,
struct irq_desc *desc)
 	u32 retrigger = 0;
 	int unmasked = 0;

-	desc->irq_data.chip->irq_ack(&desc->irq_data);
+	desc->irq_data.chip->irq_mask_ack(&desc->irq_data);

 	bank = get_irq_data(irq);
 #ifdef CONFIG_ARCH_OMAP1

-- 
                                                                Gilles.

