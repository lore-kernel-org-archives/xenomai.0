From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C07BA95.9080402@domain.hid>
References: <4C07BA95.9080402@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 05 Jun 2010 19:40:52 +0200
Message-ID: <1275759652.18250.178.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [RFC][PATCH 2/2] x86: Add support for
	ipipe_get_irq_regs
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

On Thu, 2010-06-03 at 16:22 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@domain.hid>
> 
> Implement the x86 arch bits for ipipe_get_irq_regs support. This allows
> to drop __ipipe_tick_regs and use the new service instead.

I'm unsure whether this patch would actually replace __ipipe_tick_regs
properly, particularly regarding how the profiling code works.

But I'm now convinced that we are on the wrong track, with trying to
track the IRQ frame, for the purpose we discussed on the Xenomai mailing
list. In fact, Gilles already told us about the best approach, we did
not pay attention enough, though:
https://mail.gna.org/public/xenomai-help/2010-06/msg00033.html

Basically, we want to get a hold of the register frame of a task context
before it returns to user-space, so that we can do some fixups.
Therefore, the best option is clearly to add a special event, that the
pipeline would dispatch upon request, when:

- __ipipe_grab/handle_irq is about to return to userland
- __ipipe_syscall_root is about to do the same

In those contexts, we do have the _real_ register frame for the context,
which removes the restriction on faked IRQ frames induced by the
deferred interrupt model. We could then use that feature, not only for
having a more graceful watchdog, but for allowing Xenomai's real-time
signals to preempt syscall-less code as well.

I worked on this lately, and eventually coupled that event to a
generalized support for forcing userland to run a kernel exit. I'll post
more info to the Xenomai list.

> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> ---
>  arch/x86/include/asm/ipipe.h    |   43 +++++++++++++++++++++++++++++++++++++-
>  arch/x86/include/asm/ipipe_32.h |    2 +-
>  arch/x86/include/asm/ipipe_64.h |    2 +-
>  arch/x86/kernel/ipipe.c         |   26 +++--------------------
>  4 files changed, 47 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/include/asm/ipipe.h b/arch/x86/include/asm/ipipe.h
> index 4d711dd..971b3f3 100644
> --- a/arch/x86/include/asm/ipipe.h
> +++ b/arch/x86/include/asm/ipipe.h
> @@ -31,8 +31,6 @@
>  #define IPIPE_PATCH_NUMBER	4
>  #endif
>  
> -DECLARE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
> -
>  static inline unsigned __ipipe_get_irq_vector(int irq)
>  {
>  #ifdef CONFIG_X86_IO_APIC
> @@ -153,4 +151,45 @@ int __ipipe_check_tickdev(const char *devname);
>  #define __ipipe_move_root_irq(irq)	do { } while (0)
>  #endif /* !(CONFIG_SMP && CONFIG_IPIPE) */
>  
> +static inline void
> +__ipipe_setup_irq_regs(struct pt_regs **orig_regs, struct pt_regs *saved_regs)
> +{
> +	*orig_regs = ipipe_get_irq_regs();
> +
> +	if (*orig_regs)
> +		saved_regs->orig_ax = (*orig_regs)->orig_ax;
> +	else {
> +		saved_regs->flags = X86_EFLAGS_IF;
> +		saved_regs->cs = __KERNEL_CS;
> +#ifdef CONFIG_X86_32
> +		saved_regs->ss = __KERNEL_DS;
> +		__asm__ __volatile__ ("here: movl $here, %0\n\t"
> +				      "movl %%ebp, %1\n\t"
> +				      "movl %%esp, %2\n\t"
> +				      : "=m" (saved_regs->ip),
> +					"=m" (saved_regs->bp),
> +					"=m" (saved_regs->sp));
> +#else /* CONFIG_X86_64 */
> +		saved_regs->ss = 0;
> +		__asm__ __volatile__ ("here: movq $here, %0\n\t"
> +				      "movq %%rbp, %1\n\t"
> +				      "movq %%rsp, %2\n\t"
> +				      : "=m" (saved_regs->ip),
> +					"=m" (saved_regs->bp),
> +					"=m" (saved_regs->sp));
> +#endif /* CONFIG_X86_64 */
> +		__ipipe_get_cpu_var(ipipe_irq_regs) = saved_regs;
> +	}
> +}
> +
> +static inline void
> +__ipipe_cleanup_irq_regs(struct pt_regs *orig_regs,
> +			 struct pt_regs *saved_regs)
> +{
> +	if (orig_regs)
> +		orig_regs->orig_ax = saved_regs->orig_ax;
> +	else
> +		__ipipe_get_cpu_var(ipipe_irq_regs) = NULL;
> +}
> +
>  #endif	/* !__X86_IPIPE_H */
> diff --git a/arch/x86/include/asm/ipipe_32.h b/arch/x86/include/asm/ipipe_32.h
> index 8d1f4b5..ce3d417 100644
> --- a/arch/x86/include/asm/ipipe_32.h
> +++ b/arch/x86/include/asm/ipipe_32.h
> @@ -65,7 +65,7 @@ void __ipipe_end_edge_irq(unsigned irq, struct irq_desc *desc);
>  static inline void __ipipe_call_root_xirq_handler(unsigned irq,
>  						  ipipe_irq_handler_t handler)
>  {
> -	struct pt_regs *regs = &__raw_get_cpu_var(__ipipe_tick_regs);
> +	struct pt_regs *regs = ipipe_get_irq_regs();
>  
>  	regs->orig_ax = ~__ipipe_get_irq_vector(irq);
>  
> diff --git a/arch/x86/include/asm/ipipe_64.h b/arch/x86/include/asm/ipipe_64.h
> index bc427b8..4452662 100644
> --- a/arch/x86/include/asm/ipipe_64.h
> +++ b/arch/x86/include/asm/ipipe_64.h
> @@ -63,7 +63,7 @@ void __ipipe_end_edge_irq(unsigned irq, struct irq_desc *desc);
>  static inline void __ipipe_call_root_xirq_handler(unsigned irq,
>  						  void (*handler)(unsigned, void *))
>  {
> -	struct pt_regs *regs = &__raw_get_cpu_var(__ipipe_tick_regs);
> +	struct pt_regs *regs = ipipe_get_irq_regs();
>  
>  	regs->orig_ax = ~__ipipe_get_irq_vector(irq);
>  
> diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
> index 521ec53..23b6908 100644
> --- a/arch/x86/kernel/ipipe.c
> +++ b/arch/x86/kernel/ipipe.c
> @@ -900,11 +900,14 @@ int __ipipe_syscall_root(struct pt_regs *regs)
>   */
>  int __ipipe_handle_irq(struct pt_regs *regs)
>  {
> +	struct pt_regs *old_regs = __ipipe_get_cpu_var(ipipe_irq_regs);
>  	struct ipipe_domain *this_domain, *next_domain;
>  	unsigned int vector = regs->orig_ax, irq;
>  	struct list_head *head, *pos;
>  	int m_ack;
>  
> +	__ipipe_get_cpu_var(ipipe_irq_regs) = regs;
> +
>  	if ((long)regs->orig_ax < 0) {
>  		vector = ~vector;
>  #ifdef CONFIG_X86_LOCAL_APIC
> @@ -976,28 +979,7 @@ int __ipipe_handle_irq(struct pt_regs *regs)
>  	__ipipe_walk_pipeline(head);
>  
>  finalize_nosync:
> -
> -	/*
> -	 * Given our deferred dispatching model for regular IRQs, we
> -	 * only record CPU regs for the last timer interrupt, so that
> -	 * the timer handler charges CPU times properly. It is assumed
> -	 * that other interrupt handlers don't actually care for such
> -	 * information.
> -	 */
> -
> -	if (irq == __ipipe_tick_irq) {
> -		struct pt_regs *tick_regs = &__raw_get_cpu_var(__ipipe_tick_regs);
> -		tick_regs->flags = regs->flags;
> -		tick_regs->cs = regs->cs;
> -		tick_regs->ip = regs->ip;
> -		tick_regs->bp = regs->bp;
> -#ifdef CONFIG_X86_64
> -		tick_regs->ss = regs->ss;
> -		tick_regs->sp = regs->sp;
> -#endif
> -		if (!ipipe_root_domain_p)
> -			tick_regs->flags &= ~X86_EFLAGS_IF;
> -	}
> +	__ipipe_get_cpu_var(ipipe_irq_regs) = old_regs;
>  
>  	if (!ipipe_root_domain_p ||
>  	    test_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status)))


-- 
Philippe.



