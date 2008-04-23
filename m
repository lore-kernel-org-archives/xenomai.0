Message-ID: <480EBE1B.8050601@domain.hid>
Date: Wed, 23 Apr 2008 00:42:03 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
References: <480A3751.2020609@domain.hid> <480B07B9.7090202@domain.hid>
In-Reply-To: <480B07B9.7090202@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt handling questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org


Hi Philippe,

thank you for your detailed answers !

I have one more related question. Looking at "handle_edge_irq" in 
chip.c, with IPIPE patch applied. I don't understand why the edge 
interrupt handler is allowed to call "mask_ack_irq" with IPIPE. I'd have 
expected it to be changed to "mask_irq" to prevent double "acking". 
However, if Xenomai prevented the same interrupt to recur on another 
CPU, the branch would probably never take place. Does Xenomai do 
anything like that ?

Thanks,
Tomas


Philippe Gerum wrote:
> Tomas Kalibera wrote:
>   
>> Hi,
>>
>> I've read the Adeos whitepaper ("Live with Adeos"), API docs, and looked 
>> at the sources, but I still have some interrupt handling questions.
>>
>> First, the optimistic interrupt protection. Live with Adeos says that 
>> Adeos uses optimistic interrupt protection. In optimistic interrupt 
>> protection, the handled interrupt is not masked at entry to interrupt 
>> handler, but only on the second entry, if it really recurs. The 
>> recurring interrupt is handled after the first one is handled. The 
>> "optimism" is in hoping that the interrupt in fact would not recur and 
>> is motivated by saving time on masking/unmasking on the fast path.
>>
>>     
>
> The important issue in "optimistic" interrupt handling is that one may assume
> that most of the time, no interrupt will occur during a critical section. That
> assumption allows to create a virtual interrupt mask where incoming hw
> interrupts are logged when caught within a critical section, and replayed when
> that section is exited. Whether you mask such interrupt or not upon the first
> occurence is an optional detail of the implementation. In Stodolsky's paper,
> such masking is said to be "non strictly necessary", even if "it tends to
> simplify the implementation" on their platform.
>
> We don't do this because all archs the interrupt pipeline is ported to, do not
> necessarily provide a mean to mask a single interrupt channel efficiently on the
> fast path ("efficiently" being the key word here). If it's pretty easy on
> Blackfin, it's quite sub-optimal on platform exhibiting i8259 PICs through the
> ISA bus for instance. On PowerPC, the decrementer interrupt would have to be
> processed separately than other interrupt sources for specific
> masking/unmasking, etc. We could do per-arch optimization of this kind though
> (and actually, our Blackfin port does it), but I'm unsure this would buy us much
> on most archs, latency-wise.
>
>   
>> However, the Xenomai API says (in kernel space rt_intr_create) that the 
>> handler is already called with the interrupt masked at hardware level. 
>> Unless the handler returns with RT_INTR_NOENABLE, the interrupt would be 
>> umasked at hardware level when the handler returns. Where is then the 
>> optimistic interrupt protection used ? And, does this really happen for 
>> all I/O interrupts (in particular, not only level triggered, but also 
>> edge triggered) ? And, are the interrupts also acknowledged by Xenomai ?
>>
>>     
>
> What happens at Xenomai level should not be confused with the interrupt pipeline
> actions. Xenomai does not do optimistic interrupt protection by itself for its
> own "client" handlers, it just happens to get interrupts from the pipeline; the
> fact that the I-pipe may use optimistic interrupt protection for Xenomai (and
> all other domains) is out of Xenomai's knowledge. Besides, when Xenomai is
> heading the pipeline, we optimize latency by masking all interrupts at hw level
> when Xenomai asks for its stage to be stalled, because there is no point in
> expecting interrupts to be dispatched to any higher priority domain: there is no
> such domain in that case.
>
>   
>> Live with Adeos says that a domain is stalled before entering an 
>> interrupt handler in the domain, which means that further interrupts are 
>> not delivered to the domain. The domain is automatically unstalled when 
>> the handler finishes. Does the stalling prevent all interrupts from 
>> being delivered to the domain ? Or does it only prevent the interrupt(s) 
>> that are being served by handlers presently running in the domain ?
>>
>>     
>
> All interrupts.
>
>   
>> Life with Adeos says that disabling an interrupt (rthal_irq_disable) 
>> disables the interrupt at hardware level and also locks out delivery of 
>> the interrupt to the current domain, preventing logged interrupts to be 
>> re-played. Similarly, it says that enabling an interrupt enables the 
>> interrupt at hardware level and unlocks its delivery to the current 
>> domain. Is the "locking delivery to current domain" the same as stalling 
>> the domain which happens when the handler is started ?
>>
>>     
>
> No, this one is a per-IRQ AND per-domain locking, which may remain in effect
> independently of some handler running or not. It's there to handle the following
> case:
>
> stall_stage()
> 	-> IRQ
> 		IRQ logged for domain - not played
> disable_irq(IRQ)
> unstall_stage()
> 	-> without the per-IRQ locking, we would play this specific interrupt
> 	when unstalling, but we don't want so, because this code pattern relies 		on
> disable_irq() to prevent that.
>
>   
>> Life with Adeos also suggests that, because a domain is stalled when 
>> handler is invoked and interrupts are logged, handlers do not need to 
>> disable the handled interrupt at hardware level explicitly. But, aren't 
>> the handlers already called with the interrupt disabled at hardware 
>> level ? So how could the logging take place ?
>>
>>     
>
> Whether interrupts are masked on entry or not by the I-pipe's primary handler
> depends on the type of interrupt. Edge interrupts are not masked for instance.
>
>   
>> Which is even more puzzling to me, the text suggests that not only the 
>> handled interrupt should not be disabled explicitly, but we should 
>> enable it to allow it being received by Xenomai and logged for the 
>> domain. The example uses rthal_intr_enable, which however would also 
>> unstall the domain, right ?
>>     
>
> No, it would remove the per-IRQ lock, and unmask the interrupt source at PIC
> level, but keep the stage stalled.
>
> In short:
> - stall/unstall are local, per-domain actions.
> disable/enable_irq are global, per-IRQ actions (i.e. affecting the PIC state).
>
>  So, wouldn't it  lead to logging of the
>   
>> interrupts, but to reentrant invocation of the handler ?
>>
>> Thanks!
>>
>> Tomas
>>
>>
>>
>>
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>
>>     
>
>
>   


