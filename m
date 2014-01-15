Message-ID: <52D6980B.3080605@xenomai.org>
Date: Wed, 15 Jan 2014 15:15:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1389793982-18114-1-git-send-email-sr@denx.de>
In-Reply-To: <1389793982-18114-1-git-send-email-sr@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v2] hal/arm: Add Zynq v3.5.7 patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stefan Roese <sr@denx.de>
Cc: xenomai@xenomai.org

On 01/15/2014 02:53 PM, Stefan Roese wrote:
> Xilinx Zynq is already supported in the mainline Xenomai git repository.
> This patch adds support for the v3.5.7 Linux Kernel with the latest
> arm-6 i-pipe patch additionally to the already present v3.8 support.
>
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
> v2:
> - Base pre-patch on top of a different git reopsitory based on v3.5.7
> - Remove defconfig and other board specific stuff from post-patch
> - All this leads to minimal pre- and post- patches as requested
>    by Gilles

Hi Stefan,

this looks fine to me, except:


> +diff --git a/arch/arm/kernel/ipipe.c b/arch/arm/kernel/ipipe.c
> +index ff4ad1a..cf5f29b 100644
> +--- a/arch/arm/kernel/ipipe.c
> ++++ b/arch/arm/kernel/ipipe.c
> +@@ -574,8 +574,6 @@ EXPORT_SYMBOL_GPL(__ipipe_serial_debug);
> +
> + EXPORT_SYMBOL_GPL(do_munmap);
> + EXPORT_SYMBOL_GPL(show_stack);
> +-EXPORT_SYMBOL_GPL(init_mm);
> +-EXPORT_SYMBOL_GPL(cpu_architecture);
> + #ifndef MULTI_CPU
> + EXPORT_SYMBOL_GPL(cpu_do_switch_mm);
> + #endif

If you need to remove these two lines, they should be removed from the 
I-pipe patch itself, not in the Zynq-specific patch. But, why do you 
need to remove them?

> +diff --git a/drivers/gpio/gpio-xilinxps.c b/drivers/gpio/gpio-xilinxps.c

> +-	device_pin_num = irq_to_gpio(irq_data->irq); /* get pin num within the device */
> ++	device_pin_num = irq_data->hwirq; /* get pin num within the device */

Why do you need to change that? Is it related to the I-pipe patch?

> +-	device_pin_num = irq_to_gpio(irq_data->irq); /* get pin num within the device */
> ++	device_pin_num = irq_data->hwirq; /* get pin num within the device */

> +-	device_pin_num = irq_to_gpio(irq_data->irq); /* get pin num within the device */
> ++	device_pin_num = irq_data->hwirq; /* get pin num within the device */

> +-	device_pin_num = irq_to_gpio(irq_data->irq); /* get pin num within the device */
> ++	device_pin_num = irq_data->hwirq; /* get pin num within the device */


> ++static int xgpiops_set_wake(struct irq_data *data, unsigned int on)
> ++{
> ++	if (on)
> ++		xgpiops_irq_unmask(data);
> ++	else
> ++		xgpiops_irq_mask(data);
> ++
> ++	return 0;
> ++}
> ++
> + /* irq chip descriptor */
> + static struct irq_chip xgpiops_irqchip = {
> + 	.name		= DRIVER_NAME,
> +@@ -381,6 +388,7 @@ static struct irq_chip xgpiops_irqchip = {
> + 	.irq_mask	= xgpiops_irq_mask,
> + 	.irq_unmask	= xgpiops_irq_unmask,
> + 	.irq_set_type	= xgpiops_set_irq_type,
> ++	.irq_set_wake	= xgpiops_set_wake,

Same question

> +-	chip->irq_ack(irq_data);
> ++	chained_irq_enter(chip, desc);

Same question.

> +-	chip->irq_unmask(irq_data);
> ++
> ++	chip = irq_desc_get_chip(desc);
> ++	chained_irq_exit(chip, desc);

Same question, and chip is probably still valid, so, calling 
irq_desc_get_chip seems useless.

I do not really mind the changes in gpios, but I do not think removing 
the EXPORT_SYMBOL from ipipe.c makes sense. These should only be useful 
if you compile Xenomai completely as module, but should still be useful.

-- 
					    Gilles.

