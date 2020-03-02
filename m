Subject: Re: [PATCH] arm: ipipe: Fix up the omap-gpio driver to deliver
 interrupts properly to the pipeline.
References: <20200302042504.8524-1-greg@embeddedgreg.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8058ffd7-ab19-c309-855b-0d114d2884db@siemens.com>
Date: Mon, 2 Mar 2020 13:29:11 +0100
MIME-Version: 1.0
In-Reply-To: <20200302042504.8524-1-greg@embeddedgreg.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, xenomai@xenomai.org

On 02.03.20 05:25, Greg Gallagher via Xenomai wrote:
> OMAP gpio driver was changed upstream to be able to support threaded IRQ handler,
> this change impacted how the ipipe dealt with this driver. Since the ipipe expects
> a chained handler and now it's a generic one, we need to ack the event in the
> interrupt controller before calling the handler and unmask it after.
> 
> Level flow handler must be used for pipelined interrupts. Since the IRQ handler
>   on the root stage may be delayed until the real-time core releases the CPU, we
> need to mask the IRQ to prevent an IRQ storm when the interrupts are enabled again.
> 
> Convert wa_lock to ipipe_spinlock, since wa_lock is used in the irq_chip functions
> which when called from the head stage can't use a Linux kernel service.
> 
> Add the hold/release handlers for robustness.
> 
> Signed-off-by: Greg Gallagher <greg@embeddedgreg.com>
> ---
>   drivers/gpio/gpio-omap.c | 120 ++++++++++++++++++++++++++++++---------
>   1 file changed, 93 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 39d25f599831..d52fcf5bed66 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -61,10 +61,11 @@ struct gpio_bank {
>   	u32 toggle_mask;
>   #ifdef CONFIG_IPIPE
>   	ipipe_spinlock_t lock;
> +	ipipe_spinlock_t wa_lock;
>   #else
>   	raw_spinlock_t lock;
> -#endif
>   	raw_spinlock_t wa_lock;
> +#endif
>   	struct gpio_chip chip;
>   	struct clk *dbck;
>   	u32 mod_usage;
> @@ -575,18 +576,20 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
>   		goto error;
>   	}
>   	raw_spin_unlock_irqrestore(&bank->lock, flags);
> -
> -	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
> +#ifdef CONFIG_IPIPE
> +	irq_set_handler_locked(d, handle_level_irq);
> +#else
> +        if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
>   		irq_set_handler_locked(d, handle_level_irq);
> -	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
> -		/*
> -		 * Edge IRQs are already cleared/acked in irq_handler and
> -		 * not need to be masked, as result handle_edge_irq()
> -		 * logic is excessed here and may cause lose of interrupts.
> -		 * So just use handle_simple_irq.
> -		 */
> -		irq_set_handler_locked(d, handle_simple_irq);
> -
> +        else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
> +                /*
> +                 * Edge IRQs are already cleared/acked in irq_handler and
> +                 * not need to be masked, as result handle_edge_irq()
> +                 * logic is excessed here and may cause lose of interrupts.
> +                 * So just use handle_simple_irq.
> +                 */
> +                irq_set_handler_locked(d, handle_simple_irq);
> +#endif	
>   	return 0;
>   
>   error:
> @@ -759,7 +762,7 @@ static void __omap_gpio_irq_handler(struct gpio_bank *bank)
>   
>   		enabled = omap_get_gpio_irqbank_mask(bank);
>   		isr = readl_relaxed(isr_reg) & enabled;
> -
> +		
>   		if (bank->level_mask)
>   			level_mask = bank->level_mask & enabled;
>   		else
> @@ -809,7 +812,10 @@ static void __omap_gpio_irq_handler(struct gpio_bank *bank)
>   static void omap_gpio_irq_handler(struct irq_desc *d)
>   {
>   	struct gpio_bank *bank = irq_desc_get_handler_data(d);
> +
> +	d->irq_data.chip->irq_ack(&d->irq_data);
>   	__omap_gpio_irq_handler(bank);
> +	d->irq_data.chip->irq_unmask(&d->irq_data);
>   }
>   
>   #else
> @@ -896,39 +902,31 @@ static void omap_gpio_ack_irq(struct irq_data *d)
>   	omap_clear_gpio_irqstatus(bank, offset);
>   }
>   
> -static void omap_gpio_mask_irq(struct irq_data *d)
> +static void __omap_gpio_mask_irq(struct irq_data *d)
>   {
>   	struct gpio_bank *bank = omap_irq_data_get_bank(d);
>   	unsigned offset = d->hwirq;
> -	unsigned long flags;
>   
> -	raw_spin_lock_irqsave(&bank->lock, flags);
> -	omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
>   	omap_set_gpio_irqenable(bank, offset, 0);
> -	raw_spin_unlock_irqrestore(&bank->lock, flags);
> +	omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
>   }
>   
> -static void omap_gpio_mask_ack_irq(struct irq_data *d)
> +static void __omap_gpio_mask_ack_irq(struct irq_data *d)
>   {
>   	struct gpio_bank *bank = omap_irq_data_get_bank(d);
>   	unsigned offset = d->hwirq;
> -	unsigned long flags;
> -
> -	raw_spin_lock_irqsave(&bank->lock, flags);
> +	
>   	omap_set_gpio_irqenable(bank, offset, 0);
>   	omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
> -	omap_clear_gpio_irqstatus(bank, offset);
> -	raw_spin_unlock_irqrestore(&bank->lock, flags);
> +	
>   }
>   
> -static void omap_gpio_unmask_irq(struct irq_data *d)
> +static void __omap_gpio_unmask_irq(struct irq_data *d)
>   {
>   	struct gpio_bank *bank = omap_irq_data_get_bank(d);
>   	unsigned offset = d->hwirq;
>   	u32 trigger = irqd_get_trigger_type(d);
> -	unsigned long flags;
>   
> -	raw_spin_lock_irqsave(&bank->lock, flags);
>   	omap_set_gpio_irqenable(bank, offset, 1);
>   
>   	/*
> @@ -943,9 +941,69 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
>   	if (trigger)
>   		omap_set_gpio_triggering(bank, offset, trigger);
>   
> +}
> +
> +static void omap_gpio_mask_irq(struct irq_data *d)
> +{
> +	struct gpio_bank *bank = omap_irq_data_get_bank(d);
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&bank->lock, flags);
> +	ipipe_lock_irq(d->irq);
> +	__omap_gpio_mask_irq(d);
> +	raw_spin_unlock_irqrestore(&bank->lock, flags);
> +}
> +
> +static void omap_gpio_mask_ack_irq(struct irq_data *d)
> +{
> +	struct gpio_bank *bank = omap_irq_data_get_bank(d);
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&bank->lock, flags);
> +	__omap_gpio_mask_ack_irq(d);
> +	ipipe_lock_irq(d->irq);
> +	raw_spin_unlock_irqrestore(&bank->lock, flags);
> +}
> +
> +static void omap_gpio_unmask_irq(struct irq_data *d)
> +{
> +	struct gpio_bank *bank = omap_irq_data_get_bank(d);
> +	unsigned long flags;
> +	void __iomem *enabled_reg = NULL;
> +	
> +	raw_spin_lock_irqsave(&bank->lock, flags);
> +	__omap_gpio_unmask_irq(d);	
> +	ipipe_unlock_irq(d->irq);
> +	raw_spin_unlock_irqrestore(&bank->lock, flags);
> +	enabled_reg = bank->base + bank->regs->irqenable;
> +}
> +
> +
> +
> +#ifdef CONFIG_IPIPE
> +
> +static void omap_gpio_irq_hold(struct irq_data *d)
> +{
> +	struct gpio_bank *bank = omap_irq_data_get_bank(d);
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&bank->lock, flags);
> +	__omap_gpio_mask_ack_irq(d);
>   	raw_spin_unlock_irqrestore(&bank->lock, flags);
>   }
>   
> +static void omap_gpio_irq_release(struct irq_data *d)
> +{
> +	struct gpio_bank *bank = omap_irq_data_get_bank(d);
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&bank->lock, flags);
> +	__omap_gpio_unmask_irq(d);	
> +	raw_spin_unlock_irqrestore(&bank->lock, flags);
> +}
> +
> +#endif
> +
>   /*---------------------------------------------------------------------*/
>   
>   static int omap_mpuio_suspend_noirq(struct device *dev)
> @@ -1240,7 +1298,11 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
>   
>   	irq = &bank->chip.irq;
>   	irq->chip = irqc;
> +#ifdef CONFIG_IPIPE
> +	irq->handler = handle_level_irq;
> +#else
>   	irq->handler = handle_bad_irq;
> +#endif
>   	irq->default_type = IRQ_TYPE_NONE;
>   	irq->num_parents = 1;
>   	irq->parents = &bank->irq;
> @@ -1303,6 +1365,10 @@ static int omap_gpio_probe(struct platform_device *pdev)
>   	irqc->irq_mask = omap_gpio_mask_irq,
>   	irqc->irq_mask_ack = omap_gpio_mask_ack_irq,
>   	irqc->irq_unmask = omap_gpio_unmask_irq,
> +#ifdef CONFIG_IPIPE
> +	irqc->irq_hold = omap_gpio_irq_hold,
> +	irqc->irq_release = omap_gpio_irq_release,
> +#endif
>   	irqc->irq_set_type = omap_gpio_irq_type,
>   	irqc->irq_set_wake = omap_gpio_wake_enable,
>   	irqc->irq_bus_lock = omap_gpio_irq_bus_lock,
> 

Thanks, applied to ipipe/master on ipipe-arm. Note that fixing the 
whitespace mistakes made the patch even smaller. Please cross-check if 
the result is fine.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

