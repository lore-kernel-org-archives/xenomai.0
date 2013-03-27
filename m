Message-ID: <5152F489.1000106@siemens.com>
Date: Wed, 27 Mar 2013 14:30:49 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <515229C4.6000805@xenomai.org> <515296C8.30806@web.de>
	<5152BAA3.30508@xenomai.org> <5152BC4D.8050501@siemens.com>
	<5152EC25.7060004@xenomai.org>
In-Reply-To: <5152EC25.7060004@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] one-shot fasteoi irqs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-03-27 13:55, Gilles Chanteperdrix wrote:
> Ok, how about this one:
> 
> iff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 11e75d1..47d1d27 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -256,13 +256,19 @@ void mask_irq(struct irq_desc *desc)
>  void unmask_irq(struct irq_desc *desc)
>  {
>  	unsigned long flags;
> -
> +	
> +	flags = hard_cond_local_irq_save();
> +#ifdef CONFIG_IPIPE
> +	if (desc->irq_data.chip->irq_release) {
> +		desc->irq_data.chip->irq_release(&desc->irq_data);
> +		irq_state_clr_masked(desc);

Are you sure that every call to unmask_irq implies (under I-pipe) that
the IRQ was held before so that release_irq is appropriate here? Or did
you rather want to patch cond_unmask_irq this way? But that has
unfortunately also more users than our fast_eoi path.

> +	} else
> +#endif /* CONFIG_IPIPE */
>  	if (desc->irq_data.chip->irq_unmask) {
> -		flags = hard_cond_local_irq_save();
>  		desc->irq_data.chip->irq_unmask(&desc->irq_data);
>  		irq_state_clr_masked(desc);
> -		hard_cond_local_irq_restore(flags);
>  	}
> +	hard_cond_local_irq_restore(flags);
>  }
>  
>  /*
> @@ -463,8 +469,7 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc)
>  
>  #ifdef CONFIG_IPIPE
>  	/* XXX: IRQCHIP_EOI_IF_HANDLED is ignored. */
> -	if (desc->irq_data.chip->irq_release)
> -		desc->irq_data.chip->irq_release(&desc->irq_data);
> +	cond_unmask_irq(desc);

I'm wondering now why we need this differently for the I-pipe case.

Let's revisit what happens with a fasteoi normally:

- it's masked only if it's a oneshot IRQ before calling the flow handler
- it's unmasked after the flow handling if the thread was not woken up

With I-pipe we already enter handle_fasteoi_irq with the IRQ masked. The
conditions and spots to unmask are:
- from handle_fasteoi_irq if the thread wasn't woken up or we have
  non-threaded or non-oneshot handling
- otherwise on end_irq from the handler thread

Do you think this is correct? If so, I do not think it matches this
patch yet.

Jan

>  out_eoi:
>  #else  /* !CONFIG_IPIPE */
>  	if (desc->istate & IRQS_ONESHOT)
> @@ -682,12 +687,15 @@ void __ipipe_end_level_irq(unsigned irq, struct irq_desc *desc)
>  void __ipipe_ack_fasteoi_irq(unsigned irq, struct irq_desc *desc)
>  {
>  	desc->irq_data.chip->irq_hold(&desc->irq_data);
> +	irq_state_set_masked(desc);	
>  }
>  
>  void __ipipe_end_fasteoi_irq(unsigned irq, struct irq_desc *desc)
>  {
> -	if (desc->irq_data.chip->irq_release)
> +	if (desc->irq_data.chip->irq_release) {
> +		irq_state_clr_masked(desc);		
>  		desc->irq_data.chip->irq_release(&desc->irq_data);
> +	}
>  }
>  
>  void __ipipe_ack_edge_irq(unsigned irq, struct irq_desc *desc)
> 
> 
> 

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

