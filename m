Message-ID: <494BBC66.5060207@domain.hid>
Date: Fri, 19 Dec 2008 16:23:18 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <494B6A26.1040001@domain.hid> <494BBB5A.90805@domain.hid>
In-Reply-To: <494BBB5A.90805@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [RFC][PATCH] x86-64: Enable root domain
	IRQ	migration
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Currently, I-pipe breaks the setting of IRQ affinities through Linux,
>> the root domain. This is because migrating IRQs while they are active is
>> a tricky business on x86, requiring special measures within the IRQ ack
>> path. And as this path is now used by non-root domains, the migration
>> code had to be deactivated.
>>
>> The following patch is a proof of concept for x86-64 how to overcome
>> this unfortunate limitation (if you want to isolate RT from non-RT
>> CPUs). The approach works without adding code to critical paths. First
>> tests inside KVM indicate that things work as expected, but more testing
>> on real iron is scheduled, e.g. to check MSI IRQs which I don't have in
>> my KVM environment.
>>
> 
> Here is version 2, now also including 32-bit support (untested).
> 
> Meanwhile I've run this patch on an real dual core box with MSI, and all
> works smoothly.
>

The idea looks good in any case. I will merge this next week unless a problem
arises during testing. Thanks,

> Jan
> ---
>  arch/x86/kernel/io_apic_32.c |   24 ++++++++++++++++++++++++
>  arch/x86/kernel/io_apic_64.c |   42 +++++++++++++++++++++++++++++++++++++-----
>  include/asm-x86/ipipe.h      |   11 +++++++++++
>  include/asm-x86/ipipe_64.h   |    5 +++--
>  include/linux/irq.h          |    3 +++
>  5 files changed, 78 insertions(+), 7 deletions(-)
> 
> Index: b/arch/x86/kernel/io_apic_64.c
> ===================================================================
> --- a/arch/x86/kernel/io_apic_64.c
> +++ b/arch/x86/kernel/io_apic_64.c
> @@ -174,7 +174,6 @@ static inline void io_apic_modify(unsign
>  	writel(value, &io_apic->data);
>  }
>  
> -#ifndef CONFIG_IPIPE
>  static bool io_apic_level_ack_pending(unsigned int irq)
>  {
>  	struct irq_pin_list *entry;
> @@ -203,7 +202,6 @@ static bool io_apic_level_ack_pending(un
>  
>  	return false;
>  }
> -#endif /* !CONFIG_IPIPE */
>  
>  /*
>   * Synchronize the IO-APIC and the CPU by doing
> @@ -1436,7 +1434,6 @@ unlock:
>  	irq_exit();
>  }
>  
> -#ifndef CONFIG_IPIPE
>  static void irq_complete_move(unsigned int irq)
>  {
>  	struct irq_cfg *cfg = irq_cfg + irq;
> @@ -1456,11 +1453,34 @@ static void irq_complete_move(unsigned i
>  		cfg->move_in_progress = 0;
>  	}
>  }
> -#endif
> -#elif !defined(CONFIG_IPIPE)
> +#else
>  static inline void irq_complete_move(unsigned int irq) {}
>  #endif
>  
> +#ifdef CONFIG_IPIPE
> +static void move_apic_irq(unsigned int irq)
> +{
> +	struct irq_desc *desc = &irq_desc[irq];
> +
> +	if (desc->handle_irq == &handle_edge_irq) {
> +		spin_lock(&desc->lock);
> +		irq_complete_move(irq);
> +		move_native_irq(irq);
> +		spin_unlock(&desc->lock);
> +	} else if (desc->handle_irq == &handle_fasteoi_irq) {
> +		spin_lock(&desc->lock);
> +		irq_complete_move(irq);
> +		if (unlikely(desc->status & IRQ_MOVE_PENDING)) {
> +			if (!io_apic_level_ack_pending(irq))
> +				move_masked_irq(irq);
> +			unmask_IO_APIC_irq(irq);
> +		}
> +		spin_unlock(&desc->lock);
> +	} else
> +		WARN_ON_ONCE(1);
> +}
> +#endif /* CONFIG_IPIPE */
> +
>  static void ack_apic_edge(unsigned int irq)
>  {
>  #ifndef CONFIG_IPIPE
> @@ -1544,6 +1564,9 @@ static struct irq_chip ioapic_chip __rea
>  	.eoi 		= ack_apic_level,
>  #ifdef CONFIG_SMP
>  	.set_affinity 	= set_ioapic_affinity_irq,
> +#ifdef CONFIG_IPIPE
> +	.move		= move_apic_irq,
> +#endif
>  #endif
>  	.retrigger	= ioapic_retrigger_irq,
>  };
> @@ -2087,6 +2110,9 @@ static struct irq_chip msi_chip = {
>  	.ack		= ack_apic_edge,
>  #ifdef CONFIG_SMP
>  	.set_affinity	= set_msi_irq_affinity,
> +#ifdef CONFIG_IPIPE
> +	.move		= move_apic_irq,
> +#endif
>  #endif
>  	.retrigger	= ioapic_retrigger_irq,
>  };
> @@ -2156,6 +2182,9 @@ struct irq_chip dmar_msi_type = {
>  	.ack = ack_apic_edge,
>  #ifdef CONFIG_SMP
>  	.set_affinity = dmar_msi_set_affinity,
> +#ifdef CONFIG_IPIPE
> +	.move = move_apic_irq,
> +#endif
>  #endif
>  	.retrigger = ioapic_retrigger_irq,
>  };
> @@ -2225,6 +2254,9 @@ static struct irq_chip ht_irq_chip = {
>  	.ack		= ack_apic_edge,
>  #ifdef CONFIG_SMP
>  	.set_affinity	= set_ht_irq_affinity,
> +#ifdef CONFIG_IPIPE
> +	.move		= move_apic_irq,
> +#endif
>  #endif
>  	.retrigger	= ioapic_retrigger_irq,
>  };
> Index: b/include/asm-x86/ipipe_64.h
> ===================================================================
> --- a/include/asm-x86/ipipe_64.h
> +++ b/include/asm-x86/ipipe_64.h
> @@ -144,10 +144,11 @@ static inline void __ipipe_call_root_vir
>  	do {								\
>  		local_irq_enable_nohead(ipd);				\
>  		if (ipd == ipipe_root_domain) {				\
> -			if (likely(!ipipe_virtual_irq_p(irq)))		\
> +			if (likely(!ipipe_virtual_irq_p(irq))) {	\
> +				__ipipe_move_root_irq(irq);		\
>  				__ipipe_call_root_xirq_handler(		\
>  					irq, (ipd)->irqs[irq].handler);	\
> -			else						\
> +			} else						\
>  				__ipipe_call_root_virq_handler(		\
>  					irq, (ipd)->irqs[irq].handler,	\
>  					(ipd)->irqs[irq].cookie);	\
> Index: b/include/linux/irq.h
> ===================================================================
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -111,6 +111,9 @@ struct irq_chip {
>  
>  	void		(*end)(unsigned int irq);
>  	void		(*set_affinity)(unsigned int irq, cpumask_t dest);
> +#ifdef CONFIG_IPIPE
> +	void		(*move)(unsigned int irq);
> +#endif /* CONFIG_IPIPE */
>  	int		(*retrigger)(unsigned int irq);
>  	int		(*set_type)(unsigned int irq, unsigned int flow_type);
>  	int		(*set_wake)(unsigned int irq, unsigned int on);
> Index: b/arch/x86/kernel/io_apic_32.c
> ===================================================================
> --- a/arch/x86/kernel/io_apic_32.c
> +++ b/arch/x86/kernel/io_apic_32.c
> @@ -1929,6 +1929,21 @@ static unsigned int startup_ioapic_irq(u
>  	return was_pending;
>  }
>  
> +#if defined(CONFIG_IPIPE) && defined(CONFIG_SMP)
> +static void move_apic_irq(unsigned int irq)
> +{
> +	struct irq_desc *desc = &irq_desc[irq];
> +
> +	if (desc->handle_irq == &handle_edge_irq ||
> +	    desc->handle_irq == &handle_fasteoi_irq) {
> +		spin_lock(&desc->lock);
> +		move_native_irq(irq);
> +		spin_unlock(&desc->lock);
> +	} else
> +		WARN_ON_ONCE(1);
> +}
> +#endif /* CONFIG_IPIPE && CONFIG_SMP */
> +
>  static void ack_ioapic_irq(unsigned int irq)
>  {
>  #ifndef CONFIG_IPIPE
> @@ -2018,6 +2033,9 @@ static struct irq_chip ioapic_chip __rea
>  	.eoi 		= ack_ioapic_quirk_irq,
>  #ifdef CONFIG_SMP
>  	.set_affinity 	= set_ioapic_affinity_irq,
> +#ifdef CONFIG_IPIPE
> +	.move		= move_apic_irq,
> +#endif
>  #endif
>  	.retrigger	= ioapic_retrigger_irq,
>  };
> @@ -2600,6 +2618,9 @@ static struct irq_chip msi_chip = {
>  	.ack		= ack_ioapic_irq,
>  #ifdef CONFIG_SMP
>  	.set_affinity	= set_msi_irq_affinity,
> +#ifdef CONFIG_IPIPE
> +	.move		= move_apic_irq,
> +#endif
>  #endif
>  	.retrigger	= ioapic_retrigger_irq,
>  };
> @@ -2680,6 +2701,9 @@ static struct irq_chip ht_irq_chip = {
>  	.ack		= ack_ioapic_irq,
>  #ifdef CONFIG_SMP
>  	.set_affinity	= set_ht_irq_affinity,
> +#ifdef CONFIG_IPIPE
> +	.move		= move_apic_irq,
> +#endif
>  #endif
>  	.retrigger	= ioapic_retrigger_irq,
>  };
> Index: b/include/asm-x86/ipipe.h
> ===================================================================
> --- a/include/asm-x86/ipipe.h
> +++ b/include/asm-x86/ipipe.h
> @@ -118,6 +118,17 @@ int __ipipe_check_tickdev(const char *de
>  
>  #define __ipipe_root_tick_p(regs)	((regs)->flags & X86_EFLAGS_IF)
>  
> +#ifdef CONFIG_SMP
> +#define __ipipe_move_root_irq(irq)					\
> +	do {								\
> +		struct irq_chip *chip = irq_desc[irq].chip;		\
> +		if (irq < NR_IRQS && chip->move)			\
> +			chip->move(irq);				\
> +	} while (0)
> +#else /* !CONFIG_SMP */
> +#define __ipipe_move_root_irq(irq)	do { } while (0)
> +#endif /* !CONFIG_SMP */
> +
>  #else /* !CONFIG_IPIPE */
>  
>  #define ipipe_update_tick_evtdev(evtdev)	do { } while (0)
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
> 


-- 
Philippe.

