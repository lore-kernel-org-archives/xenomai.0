Date: Mon, 18 Jun 2018 10:47:37 -0400 (EDT)
From: Jeff Melvile <jmelville@mitre.org>
In-Reply-To: <6c6edae0-3b57-d5e3-beb2-2a1ffad1c5f2@xenomai.org>
Message-ID: <alpine.DEB.2.20.1806181041440.23418@af78237-pc.mitre.org>
References: <CY4PR0901MB2211C40E748F61C0C92D976DA1900@CY4PR0901MB2211.namprd09.prod.outlook.com>
 <afc4023f-295b-0f0f-2c8a-e9f9496107f9@xenomai.org>
 <21f3928b-46d5-3de2-b18c-cdcc58492344@oss-tech.org>
 <alpine.DEB.2.20.1806121211290.22532@af78237-pc.mitre.org>
 <6c6edae0-3b57-d5e3-beb2-2a1ffad1c5f2@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Xenomai] Xenomai 3 Multi-core Semaphore latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Hi Philippe,

On Thu, 14 Jun 2018, Philippe Gerum wrote:

> On 06/12/2018 06:18 PM, Jeff Melvile wrote:
> > Dmitriy (and Philippe),
> > 
> > Thanks for looking into this. I'm working with Raman.
> > 
> > On Tue, 22 May 2018, Dmitriy Cherkasov wrote:
> > 
> >> On 05/20/2018 08:07 AM, Philippe Gerum wrote:
> >>> On 05/18/2018 06:24 PM, Singh, Raman wrote:
> >>>> Environment: ARM Cortex-A53 quad-core processor (ARM 64-bit) on a
> >>>> Zynq Ultrascale+ ZCU102 dev board, Xenomai 3 next branch from May 
> >>>> 14, 2018 (SHA1: 410a4cc1109ba4e0d05b7ece7b4a5210287e1183 ), 
> >>>> Cobalt configuration with POSIX skin, Linux Kernel version 4.9.24
> >>>>
> >>>> I've been having issues with semaphore latency when threads access 
> >>>> semaphores while executing on different cores. When both threads accessing 
> >>>> a semaphore execute on the same processor core, the latency between
> >>>> one thread posting a semaphore and another waking up after waiting on it 
> >>>> is fairly small. However, as soon as one of the threads is moved to a 
> >>>> different core, the latency between a semaphore post from one thread to a 
> >>>> waiting thread waking up in response starts to become large enough to 
> >>>> affect real time performance.  The latencies I've been seeing are on the order
> >>>> of 100's of milliseconds.
> >>>>
> >>>
> >>> Reproduced on hikey here: the rescheduling IPIs Xenomai is sending for
> >>> waking up threads on remote CPUs don't flow to the other end properly
> >>> (ipipe_send_ipi()), which explains the behavior you have been seeing.
> >>>
> >>> @Dmitriy: this may be an issue with the range of SGIs available to the
> >>> kernel when a secure firmware is enabled, which may be restricted to
> >>> SGI[0-7].
> >>>
> >>> For the rescheduling IPI on ARM64, the interrupt pipeline attempts to
> >>> trigger SGI8 which may be reserved by the ATF in secure mode, therefore
> >>> may never be received on the remote end.
> >>>
> >>> Fixing this will require some work in the interrupt pipeline, typically
> >>> for multiplexing our IPIs on a single SGI below SGI8. As a matter of
> >>> fact, the same issue exists on the ARM side, but since running a secure
> >>> firmware there is uncommon for Xenomai users, this went unnoticed (at
> >>> least not reported yet AFAIR). We need to sync up on this not to
> >>> duplicate work.
> >>>
> >>
> >> I see this on Hikey with the latest ipipe-arm64 tree as well. I can confirm the
> >> reschedule IPI isn't being received although it is sent. Rearranging the IPIs
> >> to move reschedule up a few spots resolves the issue, so I think this confirms
> >> the root cause.
> > 
> > Short term - what is the consequence of naively rearranging the IPIs? What 
> > else breaks? FWIW secure firmware is not in use. Is your test patch 
> > something we can apply to be able to test the multi-core aspects of our 
> > software?
> > 
> > Let me know if there is anything either of us can do to help. We have 
> > kernel development experience but admittedly not quite at this level.
> > 
> 
> This issue may affect the ARM port in some cases as well, so I took a stab at it for ARM64 since the related code is very similar. Could you test that patch? TIA,

Thanks for the patch. We ended up applying it on top of 
a kernel patched with ipipe-core-4.9.24-arm64-2.patch, manually resolving 
the conflicts (contained to smp.c IIRC). Clearly this is a little diferent 
than applying it on top of the ipipe HEAD and generating a fresh patch. 

The fix did resolve the high latencies we were seeing in our application 
across cores. Thanks again for the fix and let me know if you'd 
like us to do any additional testing.

Thanks,
Jeff 

> 
> commit 765aa7853642b46e1c13fd1f21dfcb9d049f5bfa (HEAD -> wip/arm64-ipi-4.9)
> Author: Philippe Gerum <rpm@xenomai.org>
> Date:   Wed Jun 13 19:16:27 2018 +0200
> 
>     arm64/ipipe: multiplex IPIs
>     
>     SGI8-15 can be reserved for the exclusive use of the firmware. The
>     ARM64 kernel currently uses six of them (NR_IPI), and the pipeline
>     needs to define three more for conveying out-of-band events
>     (i.e. reschedule, hrtimer and critical IPIs). Therefore we have to
>     multiplex nine inter-processor events over eight SGIs (SGI0-7).
>     
>     This patch changes the IPI management in order to multiplex all
>     regular (in-band) IPIs over SGI0, reserving SGI1-3 for out-of-band
>     events.
> 
> diff --git a/arch/arm64/include/asm/ipipe.h b/arch/arm64/include/asm/ipipe.h
> index b16f03b508d6..8e756be01906 100644
> --- a/arch/arm64/include/asm/ipipe.h
> +++ b/arch/arm64/include/asm/ipipe.h
> @@ -32,6 +32,7 @@
>  #include <linux/jump_label.h>
>  #include <linux/ipipe_trace.h>
>  #include <linux/ipipe_debug.h>
> +#include <asm/hardirq.h>
>  
>  #define IPIPE_CORE_RELEASE	4
>  
> @@ -165,7 +166,7 @@ static inline void ipipe_unmute_pic(void)
>  void __ipipe_early_core_setup(void);
>  void __ipipe_hook_critical_ipi(struct ipipe_domain *ipd);
>  void __ipipe_root_localtimer(unsigned int irq, void *cookie);
> -void __ipipe_grab_ipi(unsigned svc, struct pt_regs *regs);
> +void __ipipe_grab_ipi(unsigned int sgi, struct pt_regs *regs);
>  void __ipipe_ipis_alloc(void);
>  void __ipipe_ipis_request(void);
>  
> diff --git a/arch/arm64/include/asm/ipipe_base.h b/arch/arm64/include/asm/ipipe_base.h
> index 867474e1b075..4d8beb560a2f 100644
> --- a/arch/arm64/include/asm/ipipe_base.h
> +++ b/arch/arm64/include/asm/ipipe_base.h
> @@ -31,13 +31,15 @@
>  
>  #ifdef CONFIG_SMP
>  
> -extern unsigned __ipipe_first_ipi;
> -
> -#define IPIPE_CRITICAL_IPI	__ipipe_first_ipi
> -#define IPIPE_HRTIMER_IPI	(IPIPE_CRITICAL_IPI + 1)
> -#define IPIPE_RESCHEDULE_IPI	(IPIPE_CRITICAL_IPI + 2)
> -
> -#define IPIPE_LAST_IPI		IPIPE_RESCHEDULE_IPI
> +/*
> + * Out-of-band IPIs are directly mapped to SGI1-3, instead of
> + * multiplexed over SGI0 like regular in-band messages.
> + */
> +#define IPIPE_IPI_BASE		IPIPE_VIRQ_BASE
> +#define IPIPE_OOB_IPI_NR	3
> +#define IPIPE_CRITICAL_IPI	(IPIPE_IPI_BASE + NR_IPI)
> +#define IPIPE_HRTIMER_IPI	(IPIPE_IPI_BASE + NR_IPI + 1)
> +#define IPIPE_RESCHEDULE_IPI	(IPIPE_IPI_BASE + NR_IPI + 2)
>  
>  #ifdef CONFIG_IPIPE_LEGACY
>  #define hard_smp_processor_id()						\
> diff --git a/arch/arm64/kernel/ipipe.c b/arch/arm64/kernel/ipipe.c
> index ae1d0f542a3e..57f4e951648e 100644
> --- a/arch/arm64/kernel/ipipe.c
> +++ b/arch/arm64/kernel/ipipe.c
> @@ -219,7 +219,6 @@ void __ipipe_enable_pipeline(void)
>  				  irq,
>  				  (ipipe_irq_handler_t)__ipipe_do_IRQ,
>  				  NULL, NULL);
> -
>  #ifdef CONFIG_SMP
>  	__ipipe_ipis_request();
>  #endif /* CONFIG_SMP */
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index dbb00c13eb6f..3fe20f7b7f36 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -75,23 +75,8 @@ enum ipi_msg_type {
>  	IPI_TIMER,
>  	IPI_IRQ_WORK,
>  	IPI_WAKEUP,
> -#ifdef CONFIG_IPIPE
> -	IPI_IPIPE_FIRST,
> -#endif /* CONFIG_IPIPE */
>  };
>  
> -#ifdef CONFIG_IPIPE
> -#define noipipe_irq_enter()			\
> -	do {					\
> -	} while(0)
> -#define noipipe_irq_exit()			\
> -	do {					\
> -	} while(0)
> -#else /* !CONFIG_IPIPE */
> -#define noipipe_irq_enter()	irq_enter()
> -#define noipipe_irq_exit()	irq_exit()
> -#endif /* !CONFIG_IPIPE */
> -
>  #ifdef CONFIG_ARM64_VHE
>  
>  /* Whether the boot CPU is running in HYP mode or not*/
> @@ -766,12 +751,6 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
>  	S(IPI_WAKEUP, "CPU wake-up interrupts"),
>  };
>  
> -static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
> -{
> -	trace_ipi_raise(target, ipi_types[ipinr]);
> -	__smp_cross_call(target, ipinr);
> -}
> -
>  void show_ipi_list(struct seq_file *p, int prec)
>  {
>  	unsigned int cpu, i;
> @@ -798,60 +777,123 @@ u64 smp_irq_stat_cpu(unsigned int cpu)
>  }
>  
>  #ifdef CONFIG_IPIPE
> -#define IPIPE_IPI_BASE	IPIPE_VIRQ_BASE
>  
> -unsigned __ipipe_first_ipi;
> -EXPORT_SYMBOL_GPL(__ipipe_first_ipi);
> +static DEFINE_PER_CPU(unsigned long, ipi_messages);
> +
> +#define noipipe_irq_enter()			\
> +	do {					\
> +	} while(0)
> +#define noipipe_irq_exit()			\
> +	do {					\
> +	} while(0)
>  
> -static void  __ipipe_do_IPI(unsigned virq, void *cookie)
> +static void  __ipipe_do_IPI(unsigned int virq, void *cookie)
>  {
> -	enum ipi_msg_type msg = virq - IPIPE_IPI_BASE;
> -	handle_IPI(msg, raw_cpu_ptr(&ipipe_percpu.tick_regs));
> +	unsigned int ipinr = virq - IPIPE_IPI_BASE;
> +	
> +	handle_IPI(ipinr, raw_cpu_ptr(&ipipe_percpu.tick_regs));
>  }
>  
>  void __ipipe_ipis_alloc(void)
>  {
> -	unsigned int virq, ipi, last_ipi;
> +	unsigned int virq, ipi;
> +	static bool done;
>  
>  	/* May be called multiple times via init_stage() */
> -	if (__ipipe_first_ipi)
> +	if (done)
>  		return;
>  
> -	last_ipi = NR_IPI + IPIPE_LAST_IPI;
> -	for (ipi = 0; ipi <= last_ipi; ipi++) {
> +	/*
> +	 * We have to get virtual IRQs in the range
> +	 * [ IPIPE_IPI_BASE..IPIPE_IPI_BASE + NR_IPI + IPIPE_OOB_IPI_NR - 1 ],
> +	 * otherwise something is wrong (likely someone would have
> +	 * allocated virqs before we do, and this would break our
> +	 * fixed numbering scheme for IPIs).
> +	 */
> +	for (ipi = 0; ipi < NR_IPI + IPIPE_OOB_IPI_NR; ipi++) {
>  		virq = ipipe_alloc_virq();
> -		if (ipi == IPI_IPIPE_FIRST)
> -			__ipipe_first_ipi = virq;
> +		WARN_ON_ONCE(virq != IPIPE_IPI_BASE + ipi);
>  	}
> +
> +	done = true;
>  }
>  
>  void __ipipe_ipis_request(void)
>  {
> -	unsigned virq;
> +	unsigned int virq;
>  
> -	for (virq = IPIPE_IPI_BASE; virq < __ipipe_first_ipi; virq++)
> +	/*
> +	 * Attach a handler to each VIRQ mapping an IPI which might be
> +	 * posted by __ipipe_grab_ipi(). This handler will invoke
> +	 * handle_IPI() from the root stage in turn, passing it the
> +	 * corresponding IPI message number.
> +	 */
> +	for (virq = IPIPE_IPI_BASE;
> +	     virq < IPIPE_IPI_BASE + NR_IPI + IPIPE_OOB_IPI_NR; virq++)
>  		ipipe_request_irq(ipipe_root_domain,
>  				  virq,
>  				  (ipipe_irq_handler_t)__ipipe_do_IPI,
>  				  NULL, NULL);
>  }
> -void ipipe_send_ipi(unsigned ipi, cpumask_t cpumask)
> +
> +static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
> +{
> +	unsigned int cpu, sgi;
> +
> +	if (ipinr < NR_IPI) {
> +		/* regular in-band IPI (multiplexed over SGI0). */
> +		trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
> +		for_each_cpu(cpu, target)
> +			set_bit(ipinr, &per_cpu(ipi_messages, cpu));
> +		smp_mb();
> +		sgi = 0;
> +	} else	/* out-of-band IPI (SGI1-3). */
> +		sgi = ipinr - NR_IPI + 1;
> +		
> +	__smp_cross_call(target, sgi);
> +}
> +
> +void ipipe_send_ipi(unsigned int ipi, cpumask_t cpumask)
>  {
> -	enum ipi_msg_type msg = ipi - IPIPE_IPI_BASE;
> -	smp_cross_call(&cpumask, msg);
> +	unsigned int ipinr = ipi - IPIPE_IPI_BASE;
> +	smp_cross_call(&cpumask, ipinr);
>  }
>  EXPORT_SYMBOL_GPL(ipipe_send_ipi);
>  
>   /* hw IRQs off */
> -asmlinkage void __exception __ipipe_grab_ipi(unsigned svc, struct pt_regs *regs)
> +asmlinkage void __ipipe_grab_ipi(unsigned int sgi, struct pt_regs *regs)
>  {
> -	int virq = IPIPE_IPI_BASE + svc;
> +	unsigned int ipinr, irq;
> +	unsigned long *pmsg;
>  
> -	__ipipe_dispatch_irq(virq, IPIPE_IRQF_NOACK);
> +	if (sgi) {		/* SGI1-3, OOB messages. */
> +		irq = sgi + NR_IPI - 1 + IPIPE_IPI_BASE;
> +		__ipipe_dispatch_irq(irq, IPIPE_IRQF_NOACK);
> +	} else {
> +		/* In-band IPI (0..NR_IPI-1) multiplexed over SGI0. */
> +		pmsg = raw_cpu_ptr(&ipi_messages);
> +		while (*pmsg) {
> +			ipinr = ffs(*pmsg) - 1;
> +			clear_bit(ipinr, pmsg);
> +			irq = IPIPE_IPI_BASE + ipinr;
> +			__ipipe_dispatch_irq(irq, IPIPE_IRQF_NOACK);
> +		}
> +	}
>  
>  	__ipipe_exit_irq(regs);
>  }
>  
> +#else
> +
> +#define noipipe_irq_enter()	irq_enter()
> +#define noipipe_irq_exit()	irq_exit()
> +
> +static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
> +{
> +	trace_ipi_raise(target, ipi_types[ipinr]);
> +	__smp_cross_call(target, ipinr);
> +}
> +
>  #endif /* CONFIG_IPIPE */
>  
>  void arch_send_call_function_ipi_mask(const struct cpumask *mask)
> 
> -- 
> Philippe.
> 
> 

