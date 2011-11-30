Message-ID: <4ED6140A.1050109@domain.hid>
Date: Wed, 30 Nov 2011 12:31:22 +0100
From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
MIME-Version: 1.0
References: <4ED38714.2000207@domain.hid> <4ED4E86C.3080902@domain.hid>
	<4ED55BDF.9070209@domain.hid>
In-Reply-To: <4ED55BDF.9070209@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Fasteoi unmasking issue
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@domain.hid>, adeos-main <adeos-main@gna.org>, "Hillier, Gernot" <gernot.hillier@domain.hid>

On 29/11/11 23:25, Wolfgang Mauerer wrote:
> On 29/11/11 15:13, Philippe Gerum wrote:
>> On 11/28/2011 02:05 PM, Wolfgang Mauerer wrote:
>>> we are facing some difficulties with GSI interrupt storms
>>> originating from a PCI card that seem to be caused by
>>> ipipe: The card is passed through to qemu-kvm (the setup
>>> is based on the patches sent by Jan some time ago). Once
>>> the card becomes active, we are hit by a tremendous amount
>>> of interrupts (>  100000/s) that keep ipipe fully occupied.
>>> The observed pattern is (excerpt from the ipipe tracer)
>>>
>>> :| common_interrupt+0x20 (__ipipe_spin_unlock_irqrestore+0x62)
>>> :| __ipipe_handle_irq+0x11 (common_interrupt+0x27)
>>> (...)
>>> :  handle_irq+0x9 (do_IRQ+0x66)
>>> :  irq_to_desc+0x4 (handle_irq+0x15)
>>> :  handle_fasteoi_irq+0x14 (handle_irq+0x22)
>>> (...)
>>> :  unmask_ioapic_irq+0x4 (handle_fasteoi_irq+0x94)
>>> :  unmask_ioapic+0xd (unmask_ioapic_irq+0x14)
>>> :  __ipipe_spin_lock_irqsave+0x7 (unmask_ioapic+0x23)
>>> :| __ipipe_spin_lock_irqsave+0x93 (unmask_ioapic+0x23)
>>> :| __io_apic_modify_irq+0x4 (unmask_ioapic+0x41)
>>> :| __ipipe_unlock_irq+0x11 (unmask_ioapic+0x66)
>>> :| __ipipe_spin_unlock_irqrestore+0x9 (unmask_ioapic+0x75)
>>> :| __ipipe_spin_unlock_irqrestore+0x60 (unmask_ioapic+0x75)
>>> :| common_interrupt+0x20 (__ipipe_spin_unlock_irqrestore+0x62)
>>>
>>> That is, as soon as the IRQ in question is unmasked, the
>>> next one is immediately received, and the interrupt handler
>>> in non-RT context never gets a chance to actually service
>>> the interrupt.
>>>
>>> The problem seems to be caused by unmasking the IRQ in
>>> handle_fasteoi_irq(), and with a hack along the lines of
>>>
>>> --- a/kernel/irq/chip.c
>>> +++ b/kernel/irq/chip.c
>>> @@ -586,7 +586,8 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc
>>> *desc)
>>>          raw_spin_lock(&desc->lock);
>>>          desc->status&= ~IRQ_INPROGRESS;
>>>   #ifdef CONFIG_IPIPE
>>> -       desc->irq_data.chip->irq_unmask(&desc->irq_data);
>>> +       if (irq != WHICHEVER_IRQ_CAUSES_THE_STORM)
>>> +               desc->irq_data.chip->irq_unmask(&desc->irq_data);
>>>   out:
>>>   #else
>>>   out:
>>>
>>> the issue is solved.
>>>
>>> So the question is: Why is it okay to unconditionally unmask
>>> all interrupts in the fasteoi handler? All cards that re-send
>>> interrupts at high frequencies unless they are properly handled
>>> by their device driver should cause the same problem.
>>> I take the early unmasking is an optimisation, or are there any
>>> further reasons for the unconditional unmasking in
>>> handle_fasteoi_irq()?
>>
>> This is not an optimization, the flow for which this code was designed 
>> for is:
>>
>> hw IRQ receipt
>> chip->eoi()
>> 	must mask the IRQ line
>> ...
>> real-time or Linux handling, clear device interrupt
>> ...
>> handle_fasteoi()
>> 	unmask previous masking
>>
>> It does not cope well with the recent threaded interrupt model addition 
>> in the vanilla kernel. So it will likely break for any device with 
>> threaded level IRQ handling.
> ah true, with non-threaded IRQ handlers, the unmasking happens
> after the handler is finished.
> 
> Modulo any polishing etc., how about something like:

Too invasive ;) It turns out there's some Linux fasteoi
bug present in 2.6.38, patch follows in separate Mail. --Wolfgang

> 
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index eca7fa8..e28745f 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -240,7 +240,8 @@ static inline void move_masked_irq(int irq) { }
>  extern int no_irq_affinity;
>  
>  /* Handle irq action chains: */
> -extern irqreturn_t handle_IRQ_event(unsigned int irq, struct irqaction *action);
> +extern irqreturn_t handle_IRQ_event(unsigned int irq, struct irqaction *action,
> +				    short *threaded);
>  
>  /*
>   * Built-in IRQ handlers for various IRQ types,
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 9671529..d36e327 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -479,7 +479,7 @@ handle_simple_irq(unsigned int irq, struct irq_desc *desc)
>  	desc->status |= IRQ_INPROGRESS;
>  	raw_spin_unlock(&desc->lock);
>  
> -	action_ret = handle_IRQ_event(irq, action);
> +	action_ret = handle_IRQ_event(irq, action, NULL);
>  	if (!noirqdebug)
>  		note_interrupt(irq, desc, action_ret);
>  
> @@ -526,7 +526,7 @@ handle_level_irq(unsigned int irq, struct irq_desc *desc)
>  	desc->status |= IRQ_INPROGRESS;
>  	raw_spin_unlock(&desc->lock);
>  
> -	action_ret = handle_IRQ_event(irq, action);
> +	action_ret = handle_IRQ_event(irq, action, NULL);
>  	if (!noirqdebug)
>  		note_interrupt(irq, desc, action_ret);
>  
> @@ -555,6 +555,7 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc)
>  {
>  	struct irqaction *action;
>  	irqreturn_t action_ret;
> +	short threaded = 0;
>  
>  	raw_spin_lock(&desc->lock);
>  
> @@ -579,14 +580,15 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc)
>  	desc->status &= ~IRQ_PENDING;
>  	raw_spin_unlock(&desc->lock);
>  
> -	action_ret = handle_IRQ_event(irq, action);
> +	action_ret = handle_IRQ_event(irq, action, &threaded);
>  	if (!noirqdebug)
>  		note_interrupt(irq, desc, action_ret);
>  
>  	raw_spin_lock(&desc->lock);
>  	desc->status &= ~IRQ_INPROGRESS;
>  #ifdef CONFIG_IPIPE
> -	desc->irq_data.chip->irq_unmask(&desc->irq_data);
> +	if (!threaded)
> +		desc->irq_data.chip->irq_unmask(&desc->irq_data);
>  out:
>  #else
>  out:
> @@ -662,7 +664,7 @@ handle_edge_irq(unsigned int irq, struct irq_desc *desc)
>  
>  		desc->status &= ~IRQ_PENDING;
>  		raw_spin_unlock(&desc->lock);
> -		action_ret = handle_IRQ_event(irq, action);
> +		action_ret = handle_IRQ_event(irq, action, NULL);
>  		if (!noirqdebug)
>  			note_interrupt(irq, desc, action_ret);
>  		raw_spin_lock(&desc->lock);
> @@ -693,7 +695,7 @@ handle_percpu_irq(unsigned int irq, struct irq_desc *desc)
>  		desc->irq_data.chip->irq_ack(&desc->irq_data);
>  #endif /* CONFIG_IPIPE */
>  
> -	action_ret = handle_IRQ_event(irq, desc->action);
> +	action_ret = handle_IRQ_event(irq, desc->action, NULL);
>  	if (!noirqdebug)
>  		note_interrupt(irq, desc, action_ret);
>  
> diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
> index 3540a71..a9cff8d 100644
> --- a/kernel/irq/handle.c
> +++ b/kernel/irq/handle.c
> @@ -58,7 +58,8 @@ static void warn_no_thread(unsigned int irq, struct irqaction *action)
>   *
>   * Handles the action chain of an irq event
>   */
> -irqreturn_t handle_IRQ_event(unsigned int irq, struct irqaction *action)
> +irqreturn_t handle_IRQ_event(unsigned int irq, struct irqaction *action,
> +			     short *threaded)
>  {
>  	irqreturn_t ret, retval = IRQ_NONE;
>  	unsigned int status = 0;
> @@ -97,6 +98,8 @@ irqreturn_t handle_IRQ_event(unsigned int irq, struct irqaction *action)
>  					     &action->thread_flags))) {
>  				set_bit(IRQTF_RUNTHREAD, &action->thread_flags);
>  				wake_up_process(action->thread);
> +				if (threaded)
> +					*threaded = 1;
>  			}
>  
>  			/* Fall through to add to randomness */
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 9033c1c..db35e6b 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -608,6 +608,9 @@ static int irq_thread(void *data)
>  			raw_spin_unlock_irq(&desc->lock);
>  
>  			action->thread_fn(action->irq, action->dev_id);
> +#ifdef CONFIG_IPIPE
> +			desc->irq_data.chip->irq_unmask(&desc->irq_data);
> +#endif
>  
>  			if (oneshot)
>  				irq_finalize_oneshot(action->irq, desc);
> diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
> index 3089d3b..50e4f08 100644
> --- a/kernel/irq/spurious.c
> +++ b/kernel/irq/spurious.c
> @@ -71,7 +71,7 @@ static int try_one_irq(int irq, struct irq_desc *desc)
>  		 */
>  		work = 1;
>  		raw_spin_unlock(&desc->lock);
> -		handle_IRQ_event(irq, action);
> +		handle_IRQ_event(irq, action, NULL);
>  		raw_spin_lock(&desc->lock);
>  		desc->status &= ~IRQ_PENDING;
>  	}
> 
> Cheers, Wolfgang
> 
> --
> Siemens AG, Open Source Platforms,
> Corporate Competence Centre Embedded Linux


