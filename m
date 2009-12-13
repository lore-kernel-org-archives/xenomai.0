From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B240D0B.50603@domain.hid>
References: <4B240D0B.50603@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 13 Dec 2009 18:02:37 +0100
Message-ID: <1260723757.2216.2.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [pull request] x86: critical fix for
	native_safe_halt
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

On Sat, 2009-12-12 at 22:37 +0100, Jan Kiszka wrote:
> Recent moving of ipipe_suspend_domain finally exposed a deeper flaw in
> cpu_idle on x86: We failed to check the pipeline log before issuing the
> real hlt. This caused IRQ latencies or even drops for Linux,
> specifically on SMP. Credits go to plain QEMU whose slow SMP mode caused
> ipipe_critical_enter to deadlock frequently enough.
> 
> The first patch of this series fixes this (see below), the second one
> simply removes the two useless ipipe_suspend_domain calls.
> 

What your patch does as well, is killing the ability to run low priority
domains below the root level.

> 
> The following changes since commit 7cd56451b429702996adef794f01f1067e5fff51:
>   Philippe Gerum (1):
>         ipipe-2.6.31.1-x86-2.4-08
> 
> are available in the git repository at:
> 
>   git://git.kiszka.org/ipipe-2.6 queues/2.6.31-x86
> 
> Jan Kiszka (2):
>       x86: Properly virtualize native_safe_halt
>       x86: Drop redundant ipipe_suspend_domain from cpu_idle
> 
>  arch/x86/include/asm/ipipe_base.h |    2 ++
>  arch/x86/include/asm/irqflags.h   |    8 +++++---
>  arch/x86/kernel/ipipe.c           |   23 +++++++++++++++++++++++
>  arch/x86/kernel/process_32.c      |    2 --
>  arch/x86/kernel/process_64.c      |    3 ---
>  5 files changed, 30 insertions(+), 8 deletions(-)
> 
> ------
> 
> x86: Properly virtualize native_safe_halt
> 
> We have to check the root domain's log before halting. If it is not
> empty, we need to replay and return immediately. Otherwise we risk to
> defer or even lose root domain interrupts.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> ---
>  arch/x86/include/asm/ipipe_base.h |    2 ++
>  arch/x86/include/asm/irqflags.h   |    8 +++++---
>  arch/x86/kernel/ipipe.c           |   23 +++++++++++++++++++++++
>  3 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/ipipe_base.h b/arch/x86/include/asm/ipipe_base.h
> index c3bd7d1..3c81096 100644
> --- a/arch/x86/include/asm/ipipe_base.h
> +++ b/arch/x86/include/asm/ipipe_base.h
> @@ -203,6 +203,8 @@ static inline unsigned long __ipipe_test_root(void)
>  
>  #endif /* !CONFIG_SMP */
>  
> +void __ipipe_halt_root(void);
> +
>  void __ipipe_serial_debug(const char *fmt, ...);
>  
>  #endif	/* !__ASSEMBLY__ */
> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> index 71ede94..1baceba 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -72,10 +72,12 @@ static inline void native_irq_enable(void)
>  
>  static inline void native_safe_halt(void)
>  {
> -#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
> -	ipipe_trace_end(0x8000000E);
> -#endif
> +#ifdef CONFIG_IPIPE
> +	barrier();
> +	__ipipe_halt_root();
> +#else
>  	asm volatile("sti; hlt": : :"memory");
> +#endif
>  }
>  
>  static inline void native_halt(void)
> diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
> index d4789c8..487b2b0 100644
> --- a/arch/x86/kernel/ipipe.c
> +++ b/arch/x86/kernel/ipipe.c
> @@ -601,6 +601,29 @@ void __ipipe_preempt_schedule_irq(void)
>  
>  #endif /* !CONFIG_X86_32 */
>  
> +void __ipipe_halt_root(void)
> +{
> +	struct ipipe_percpu_domain_data *p;
> +
> +	/* Emulate sti+hlt sequence over the root domain. */
> +
> +	local_irq_disable_hw();
> +
> +	p = ipipe_root_cpudom_ptr();
> +
> +	clear_bit(IPIPE_STALL_FLAG, &p->status); 
> +
> +	if (unlikely(p->irqpend_himask != 0)) {
> +		__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
> +		local_irq_enable_hw();
> +	} else {
> +#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
> +		ipipe_trace_end(0x8000000E);
> +#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
> +		asm volatile("sti; hlt": : :"memory");
> +	}
> +}
> +
>  static void do_machine_check_vector(struct pt_regs *regs, long error_code)
>  {
>  #ifdef CONFIG_X86_MCE


-- 
Philippe.



