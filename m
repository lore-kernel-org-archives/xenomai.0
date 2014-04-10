Message-ID: <53471FDB.50008@xenomai.org>
Date: Fri, 11 Apr 2014 00:48:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1396407588.27578.5.camel@localhost.localdomain>
 <533BBB11.5090808@xenomai.org>
 <1396848843.2481.15.camel@localhost.localdomain>
 <5343BEFB.7050402@xenomai.org>
 <1396999856.2660.7.camel@localhost.localdomain>
 <53449244.8040502@xenomai.org>
 <1397003664.2660.14.camel@localhost.localdomain>
 <1397017658.2660.16.camel@localhost.localdomain>
 <534534FD.5090805@xenomai.org>
 <1397113300.2720.5.camel@localhost.localdomain>
 <5346895B.6080401@xenomai.org>
 <1397159850.2881.3.camel@localhost.localdomain>
 <53471389.6000000@xenomai.org>
 <1397168263.6356.11.camel@localhost.localdomain>
 <534719F5.2020605@xenomai.org>
 <1397169248.6356.15.camel@localhost.localdomain>
In-Reply-To: <1397169248.6356.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] OMAP L138
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Peter Howard <pjh@northern-ridge.com.au>
Cc: xenomai@xenomai.org

On 04/11/2014 12:34 AM, Peter Howard wrote:
> On Fri, 2014-04-11 at 00:23 +0200, Gilles Chanteperdrix wrote:
> (Stripping back conversation on this one - apologies if that's bad
> etiquette for this list)
>  
>> Attachment is better. Also please post the changes you made for omapL138
>>
> 
> diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
> index a075b3e..3d8bc59 100644
> --- a/arch/arm/mach-davinci/Kconfig
> +++ b/arch/arm/mach-davinci/Kconfig
> @@ -41,6 +41,8 @@ config ARCH_DAVINCI_DA850
>  	select ARCH_DAVINCI_DA8XX
>  	select ARCH_HAS_CPUFREQ
>  	select CP_INTC
> +    select IPIPE_ARM_KUSER_TSC if IPIPE
> +    select ARM_FCSE if IPIPE

You may want to leave the choice of enabling or disabling FCSE to the user.

>  
>  config ARCH_DAVINCI_DA8XX
>  	bool
> diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
> index 006dae8..61fa26f 100644
> --- a/arch/arm/mach-davinci/cp_intc.c
> +++ b/arch/arm/mach-davinci/cp_intc.c
> @@ -17,6 +17,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> +#include <linux/ipipe.h>
>  
>  #include <mach/common.h>
>  #include <mach/cp_intc.h>
> @@ -39,6 +40,7 @@ static void cp_intc_ack_irq(struct irq_data *d)
>  /* Disable interrupt */
>  static void cp_intc_mask_irq(struct irq_data *d)
>  {
> +	ipipe_lock_irq(d->irq);
>  	/* XXX don't know why we need to disable nIRQ here... */
>  	cp_intc_write(1, CP_INTC_HOST_ENABLE_IDX_CLR);
>  	cp_intc_write(d->hwirq, CP_INTC_SYS_ENABLE_IDX_CLR);
> @@ -49,8 +51,25 @@ static void cp_intc_mask_irq(struct irq_data *d)
>  static void cp_intc_unmask_irq(struct irq_data *d)
>  {
>  	cp_intc_write(d->hwirq, CP_INTC_SYS_ENABLE_IDX_SET);
> +	ipipe_unlock_irq(d->irq);
>  }
>  
> +#ifdef CONFIG_IPIPE
> +/* Hold and release without irq locking */
> +static void cp_intc_hold_irq(struct irq_data *d)
> +{
> +	/* XXX don't know why we need to disable nIRQ here... */
> +	cp_intc_write(1, CP_INTC_HOST_ENABLE_IDX_CLR);
> +	cp_intc_write(d->hwirq, CP_INTC_SYS_ENABLE_IDX_CLR);
> +	cp_intc_write(1, CP_INTC_HOST_ENABLE_IDX_SET);
> +}
> +
> +static void cp_intc_release_irq(struct irq_data *d)
> +{
> +	cp_intc_write(d->hwirq, CP_INTC_SYS_ENABLE_IDX_SET);
> +}
> +#endif /* CONFIG_IPIPE */
> +
>  static int cp_intc_set_irq_type(struct irq_data *d, unsigned int flow_type)
>  {
>  	unsigned reg		= BIT_WORD(d->hwirq);
> @@ -100,6 +119,12 @@ static struct irq_chip cp_intc_irq_chip = {
>  	.irq_ack	= cp_intc_ack_irq,
>  	.irq_mask	= cp_intc_mask_irq,
>  	.irq_unmask	= cp_intc_unmask_irq,
> +#ifdef CONFIG_IPIPE
> +	.irq_disable = cp_intc_hold_irq,
> +	.irq_enable = cp_intc_release_irq,
> +	.irq_hold	= cp_intc_hold_irq,
> +	.irq_release = cp_intc_release_irq,
> +#endif /* CONFIG_IPIPE */
>  	.irq_set_type	= cp_intc_set_irq_type,
>  	.irq_set_wake	= cp_intc_set_wake,
>  };

The hold/release stuff should be only be needed for fasteoi irq, not for
edge irqs.

Other than that, the patch looks pretty straightforward.


-- 
                                                                Gilles.

