Message-ID: <49A290E2.3040506@domain.hid>
Date: Mon, 23 Feb 2009 13:04:50 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <499EBF31.2080405@domain.hid>
In-Reply-To: <499EBF31.2080405@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH] x86: Always call fixup_if after event
	dispatching
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
> As we may switch the Linux context as a result of calling
> __ipipe_dispatch_event and, thus, may leave it with a different root
> domain state independent of the return code, we have to call __fixup_if
> unconditionally. Moreover, we should also always check for pending VIRQs
> on return.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> 
> ---
>  arch/x86/kernel/ipipe.c |   24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> Index: b/arch/x86/kernel/ipipe.c
> ===================================================================
> --- a/arch/x86/kernel/ipipe.c
> +++ b/arch/x86/kernel/ipipe.c
> @@ -540,6 +540,7 @@ asmlinkage void __ipipe_unstall_iret_roo
>  asmlinkage int __ipipe_syscall_root(struct pt_regs regs)
>  {
>  	unsigned long flags;
> +	int dont_pass;
>  
>  	__fixup_if(&regs);
>  
> @@ -551,8 +552,9 @@ asmlinkage int __ipipe_syscall_root(stru
>  	   tail work has to be performed (for handling signals etc). */
>  
>  	if (__ipipe_syscall_watched_p(current, regs.orig_ax) &&
> -	    __ipipe_event_monitored_p(IPIPE_EVENT_SYSCALL) &&
> -	    __ipipe_dispatch_event(IPIPE_EVENT_SYSCALL,&regs) > 0) {
> +	    __ipipe_event_monitored_p(IPIPE_EVENT_SYSCALL)) {
> +		dont_pass = __ipipe_dispatch_event(IPIPE_EVENT_SYSCALL,&regs);
> +
>  		/* We might enter here over a non-root domain and exit
>  		 * over the root one as a result of the syscall
>  		 * (i.e. by recycling the register set of the current
> @@ -568,9 +570,10 @@ asmlinkage int __ipipe_syscall_root(stru
>  			if ((ipipe_root_cpudom_var(irqpend_himask) & IPIPE_IRQMASK_VIRT) != 0)
>  				__ipipe_sync_pipeline(IPIPE_IRQMASK_VIRT);
>  			local_irq_restore_hw(flags);
> -			return -1;
> -		}
> -		return 1;
> +			if (dont_pass)
> +				return -1;
> +		} else if (dont_pass)
> +			return 1;
>  	}
>  
>  	return 0;
> @@ -610,6 +613,7 @@ asmlinkage int __ipipe_preempt_schedule_
>  asmlinkage int __ipipe_syscall_root(struct pt_regs *regs)
>  {
>  	unsigned long flags;
> +	int pass;
>  
>  	__fixup_if(regs);
>

This needs fixing; a thread relaxing to secondary mode to run a regular Linux
syscall would trigger the issue as well.

> @@ -621,8 +625,9 @@ asmlinkage int __ipipe_syscall_root(stru
>  	   tail work has to be performed (for handling signals etc). */
>  
>  	if (__ipipe_syscall_watched_p(current, regs->orig_ax) &&
> -	    __ipipe_event_monitored_p(IPIPE_EVENT_SYSCALL) &&
> -	    __ipipe_dispatch_event(IPIPE_EVENT_SYSCALL, regs) > 0) {
> +	    __ipipe_event_monitored_p(IPIPE_EVENT_SYSCALL)) {
> +		pass = !__ipipe_dispatch_event(IPIPE_EVENT_SYSCALL, regs);
> +
>  		/* We might enter here over a non-root domain and exit
>  		 * over the root one as a result of the syscall
>  		 * (i.e. by recycling the register set of the current
> @@ -632,6 +637,9 @@ asmlinkage int __ipipe_syscall_root(stru
>  		 * stall bit on exit. */
>  		__fixup_if(regs);
>  
> +		if (pass)
> +			return 0;
> +
>  		if (ipipe_root_domain_p && !in_atomic()) {

We may remove the in_atomic() check. This is legacy code that does not serve any
purpose in recent kernels.

>  			/* Sync pending VIRQs before _TIF_NEED_RESCHED is tested. */
>  			local_irq_save_hw(flags);
> @@ -648,7 +656,7 @@ asmlinkage int __ipipe_syscall_root(stru
>  		return 1;
>  	}
>  
> -    return 0;
> +	return 0;
>  }
>  
>  #endif /* !CONFIG_X86_32 */
> 


-- 
Philippe.



