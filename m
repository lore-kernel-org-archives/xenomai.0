Message-ID: <51633200.8030007@xenomai.org>
Date: Mon, 08 Apr 2013 23:09:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <515229C4.6000805@xenomai.org> <515296C8.30806@web.de>
	<5152BAA3.30508@xenomai.org> <5152BC4D.8050501@siemens.com>
	<5152EC25.7060004@xenomai.org> <5152F489.1000106@siemens.com>
	<515B5154.2000802@xenomai.org> <515FEE47.90507@web.de>
In-Reply-To: <515FEE47.90507@web.de>
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
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On 04/06/2013 11:43 AM, Jan Kiszka wrote:

> On 2013-04-02 23:44, Gilles Chanteperdrix wrote:
>> On 03/27/2013 02:30 PM, Jan Kiszka wrote:
>>
>>> I'm wondering now why we need this differently for the I-pipe case.
>>>
>>> Let's revisit what happens with a fasteoi normally:
>>>
>>> - it's masked only if it's a oneshot IRQ before calling the flow handler
>>> - it's unmasked after the flow handling if the thread was not woken up
>>>
>>> With I-pipe we already enter handle_fasteoi_irq with the IRQ masked. The
>>> conditions and spots to unmask are:
>>> - from handle_fasteoi_irq if the thread wasn't woken up or we have
>>>   non-threaded or non-oneshot handling
>>> - otherwise on end_irq from the handler thread
>>>
>>> Do you think this is correct? If so, I do not think it matches this
>>> patch yet.
>>
>>
>> Hi,
>>
>> here is a much simpler patch:
>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>> index 11e75d1..a1c9918 100644
>> --- a/kernel/irq/chip.c
>> +++ b/kernel/irq/chip.c
>> @@ -421,6 +421,13 @@ static inline void preflow_handler(struct irq_desc *desc)
>>  static inline void preflow_handler(struct irq_desc *desc) { }
>>  #endif
>>  
>> +static void cond_release_fasteoi_irq(struct irq_desc *desc)
>> +{
>> +	if (desc->irq_data.chip->irq_release && 
>> +	    !irqd_irq_disabled(&desc->irq_data) && !desc->threads_oneshot)
>> +		desc->irq_data.chip->irq_release(&desc->irq_data);
>> +}
>> +
>>  /**
>>   *	handle_fasteoi_irq - irq handler for transparent controllers
>>   *	@irq:	the interrupt number
>> @@ -463,8 +470,7 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc)
>>  
>>  #ifdef CONFIG_IPIPE
>>  	/* XXX: IRQCHIP_EOI_IF_HANDLED is ignored. */
> 
> Makes me wonder what this comment wants to tell us. That there is an
> unhandled corner case or that this is intentionally ignored? I support
> the latter as I-pipe already does EOI when accepting the IRQ, no? Maybe
> you can clarify that line at this chance.


I have no idea where this comment come from. I do not think this flag
can be handled with the I-pipe kernel, as the EOI is sent before trying
to handle the IRQ. The only users are in arch/sparc and arch/powerpc,
maybe Philippe knows more?

-- 
                                                                Gilles.

