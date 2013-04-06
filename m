Message-ID: <515FEE47.90507@web.de>
Date: Sat, 06 Apr 2013 11:43:35 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <515229C4.6000805@xenomai.org> <515296C8.30806@web.de>
	<5152BAA3.30508@xenomai.org> <5152BC4D.8050501@siemens.com>
	<5152EC25.7060004@xenomai.org> <5152F489.1000106@siemens.com>
	<515B5154.2000802@xenomai.org>
In-Reply-To: <515B5154.2000802@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

On 2013-04-02 23:44, Gilles Chanteperdrix wrote:
> On 03/27/2013 02:30 PM, Jan Kiszka wrote:
> =

>> I'm wondering now why we need this differently for the I-pipe case.
>>
>> Let's revisit what happens with a fasteoi normally:
>>
>> - it's masked only if it's a oneshot IRQ before calling the flow handler
>> - it's unmasked after the flow handling if the thread was not woken up
>>
>> With I-pipe we already enter handle_fasteoi_irq with the IRQ masked. The
>> conditions and spots to unmask are:
>> - from handle_fasteoi_irq if the thread wasn't woken up or we have
>>   non-threaded or non-oneshot handling
>> - otherwise on end_irq from the handler thread
>>
>> Do you think this is correct? If so, I do not think it matches this
>> patch yet.
> =

> =

> Hi,
> =

> here is a much simpler patch:
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 11e75d1..a1c9918 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -421,6 +421,13 @@ static inline void preflow_handler(struct irq_desc *=
desc)
>  static inline void preflow_handler(struct irq_desc *desc) { }
>  #endif
>  =

> +static void cond_release_fasteoi_irq(struct irq_desc *desc)
> +{
> +	if (desc->irq_data.chip->irq_release && =

> +	    !irqd_irq_disabled(&desc->irq_data) && !desc->threads_oneshot)
> +		desc->irq_data.chip->irq_release(&desc->irq_data);
> +}
> +
>  /**
>   *	handle_fasteoi_irq - irq handler for transparent controllers
>   *	@irq:	the interrupt number
> @@ -463,8 +470,7 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc =
*desc)
>  =

>  #ifdef CONFIG_IPIPE
>  	/* XXX: IRQCHIP_EOI_IF_HANDLED is ignored. */

Makes me wonder what this comment wants to tell us. That there is an
unhandled corner case or that this is intentionally ignored? I support
the latter as I-pipe already does EOI when accepting the IRQ, no? Maybe
you can clarify that line at this chance.

> -	if (desc->irq_data.chip->irq_release)
> -		desc->irq_data.chip->irq_release(&desc->irq_data);
> +	cond_release_fasteoi_irq(desc);
>  out_eoi:
>  #else  /* !CONFIG_IPIPE */
>  	if (desc->istate & IRQS_ONESHOT)
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index e49a288..e7ae8bd 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -715,9 +715,14 @@ again:
>  =

>  	desc->threads_oneshot &=3D ~action->thread_mask;
>  =

> +#ifndef CONFIG_IPIPE
>  	if (!desc->threads_oneshot && !irqd_irq_disabled(&desc->irq_data) &&
>  	    irqd_irq_masked(&desc->irq_data))
>  		unmask_irq(desc);
> +#else /* CONFIG_IPIPE */
> +	if (!desc->threads_oneshot && !irqd_irq_disabled(&desc->irq_data))
> +		desc->ipipe_end(desc->irq_data.irq, desc);
> +#endif /* CONFIG_IPIPE */
>  =

>  out_unlock:
>  	raw_spin_unlock_irq(&desc->lock);
> =

> =


Looks good. I should dig out our test case again and check it on x86. I
think it was PCI device assignment with KVM where the IRQ of the
assigned device is handled by an IRQ thread of KVM.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130406/ef69ff6=
6/attachment.pgp>
