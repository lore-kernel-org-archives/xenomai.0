Message-ID: <51535B8E.8010707@xenomai.org>
Date: Wed, 27 Mar 2013 21:50:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <515229C4.6000805@xenomai.org> <515296C8.30806@web.de>
	<5152BAA3.30508@xenomai.org> <5152BC4D.8050501@siemens.com>
	<5152EC25.7060004@xenomai.org> <5152F489.1000106@siemens.com>
In-Reply-To: <5152F489.1000106@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 03/27/2013 02:30 PM, Jan Kiszka wrote:

> On 2013-03-27 13:55, Gilles Chanteperdrix wrote:
>> Ok, how about this one:
>>
>> iff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>> index 11e75d1..47d1d27 100644
>> --- a/kernel/irq/chip.c
>> +++ b/kernel/irq/chip.c
>> @@ -256,13 +256,19 @@ void mask_irq(struct irq_desc *desc)
>>  void unmask_irq(struct irq_desc *desc)
>>  {
>>  	unsigned long flags;
>> -
>> +	
>> +	flags = hard_cond_local_irq_save();
>> +#ifdef CONFIG_IPIPE
>> +	if (desc->irq_data.chip->irq_release) {
>> +		desc->irq_data.chip->irq_release(&desc->irq_data);
>> +		irq_state_clr_masked(desc);
> 
> Are you sure that every call to unmask_irq implies (under I-pipe) that
> the IRQ was held before so that release_irq is appropriate here?


Yes, unmask_irq is always called after testing for irqd_irq_masked, so,
since ipipe_ack_fasteoi_irq is modified for setting the corresponding
bit, and ipipe_end_fasteoi_irq clearing it, if the bit is set, the irq
can be unmasked.

> Or did
> you rather want to patch cond_unmask_irq this way? But that has
> unfortunately also more users than our fast_eoi path.

No, the reason unmask_irq has to be changed that way is because
irq_finalize_oneshot, which does not know whether it is dealing with a
fasteoi, level, edge, irq, calls unmask_irq unconditionnaly, so, if we
want irq_release to be called from that point for fasteoi irqs, we have
to change unmask_irq.

Alternatively, we could call ->ipipe_end with a #ifdef CONFIG_IPIPE in
irq_finalize_oneshot..

> 
>> +	} else
>> +#endif /* CONFIG_IPIPE */
>>  	if (desc->irq_data.chip->irq_unmask) {
>> -		flags = hard_cond_local_irq_save();
>>  		desc->irq_data.chip->irq_unmask(&desc->irq_data);
>>  		irq_state_clr_masked(desc);
>> -		hard_cond_local_irq_restore(flags);
>>  	}
>> +	hard_cond_local_irq_restore(flags);
>>  }
>>  
>>  /*
>> @@ -463,8 +469,7 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc)
>>  
>>  #ifdef CONFIG_IPIPE
>>  	/* XXX: IRQCHIP_EOI_IF_HANDLED is ignored. */
>> -	if (desc->irq_data.chip->irq_release)
>> -		desc->irq_data.chip->irq_release(&desc->irq_data);
>> +	cond_unmask_irq(desc);
> 
> I'm wondering now why we need this differently for the I-pipe case.


In the non I-pipe case, we have:
	if (desc->istate & IRQS_ONESHOT)
		cond_unmask_irq(desc);
Which is wrong with I-pipe because we want the irq unmasked even for
irqs which are not one-host.

Then:
	desc->irq_data.chip->irq_eoi(&desc->irq_data);
Which is wrong because the EOI was already sent as part of the irq_hold
callback.

> 
> Let's revisit what happens with a fasteoi normally:
> 
> - it's masked only if it's a oneshot IRQ before calling the flow handler
> - it's unmasked after the flow handling if the thread was not woken up
> 
> With I-pipe we already enter handle_fasteoi_irq with the IRQ masked. The
> conditions and spots to unmask are:
> - from handle_fasteoi_irq if the thread wasn't woken up or we have
>   non-threaded or non-oneshot handling


That is what the unconditional call to cond_unmask_irq does.

> - otherwise on end_irq from the handler thread


That is what the call to unmask_irq at the end of irq_finalize_oneshot does.

> 
> Do you think this is correct? If so, I do not think it matches this

> patch yet.


Seems to me that it does (and indeed the patched kernel works for me, I
tested before sending the patch).

-- 
                                                                Gilles.

