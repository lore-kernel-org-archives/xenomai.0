From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C0692A9.2080806@domain.hid>
References: <4C0692A9.2080806@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Jun 2010 22:58:04 +0200
Message-ID: <1275512284.18250.56.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC] Break out of endless user space loops
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>, Tschaeche IT-Services <services@domain.hid>

On Wed, 2010-06-02 at 19:19 +0200, Jan Kiszka wrote:
> Hi all,
> 
> here is the first apparently working prototype for getting hold of
> endless user space loops in RT threads. A simple test case of mine now
> receive a SIGDEBUG even if it does "while (1);".
> 
> The design follows Gilles' suggestion to force a SEGV on victim thread
> but restore the patched PC before migrating the thread after this fault.
> The only drawback of this approach: We need to keep track of the
> preempted register set at I-pipe level. I basically replicated what
> Linux does these days as well and exported it as ipipe_get_irq_regs()
> (the second patch).
> 
> This is an x86-64-only draft which clearly needs more love. I'm open for
> suggestions of different abstractions wherever you see a need.

What if you have no MMU ?

> 
> Jan
> 
> ---
>  include/asm-generic/hal.h        |    2 ++
>  include/asm-x86/bits/thread_64.h |    1 +
>  include/asm-x86/system_64.h      |   26 ++++++++++++++++++++++++++
>  ksrc/nucleus/pod.c               |    5 +++++
>  ksrc/nucleus/sched.c             |    1 +
>  5 files changed, 35 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-generic/hal.h b/include/asm-generic/hal.h
> index 84c1a4d..be6abf0 100644
> --- a/include/asm-generic/hal.h
> +++ b/include/asm-generic/hal.h
> @@ -96,6 +96,8 @@ typedef spinlock_t rthal_spinlock_t;
>  #define rthal_irq_cookie(ipd,irq)	__ipipe_irq_cookie(ipd,irq)
>  #define rthal_irq_handler(ipd,irq)	__ipipe_irq_handler(ipd,irq)
>  
> +#define rthal_get_irq_regs()		ipipe_get_irq_regs()
> +
>  #define rthal_cpudata_irq_hits(ipd,cpu,irq)	__ipipe_cpudata_irq_hits(ipd,cpu,irq)
>  
>  #ifndef local_irq_save_hw_smp
> diff --git a/include/asm-x86/bits/thread_64.h b/include/asm-x86/bits/thread_64.h
> index 91b71ed..d163c9e 100644
> --- a/include/asm-x86/bits/thread_64.h
> +++ b/include/asm-x86/bits/thread_64.h
> @@ -33,6 +33,7 @@ static inline void xnarch_init_tcb(xnarchtcb_t * tcb)
>  	tcb->ripp = &tcb->rip;
>  	tcb->fpup = &tcb->i387;
>  	tcb->is_root = 0;
> +	tcb->forced_um_exit = 0;
>  	/* Must be followed by xnarch_init_thread(). */
>  }
>  
> diff --git a/include/asm-x86/system_64.h b/include/asm-x86/system_64.h
> index 4de8693..f023dab 100644
> --- a/include/asm-x86/system_64.h
> +++ b/include/asm-x86/system_64.h
> @@ -60,6 +60,8 @@ typedef struct xnarchtcb {      /* Per-thread arch-dependent block */
>  	unsigned long ts_usedfpu: 1;
>  	unsigned long cr0_ts: 1;
>  
> +	unsigned long forced_um_exit: 1;
> +
>  	unsigned stacksize;         /* Aligned size of stack (bytes) */
>  	unsigned long *stackbase;   /* Stack space */
>  
> @@ -122,6 +124,30 @@ static inline void xnarch_free_stack_mem(void *chunk, u_long bytes)
>  	kfree(chunk);
>  }
>  
> +static inline void xnarch_force_userspace_exit(xnarchtcb_t *tcb)
> +{
> +	struct pt_regs *regs = rthal_get_irq_regs();
> +
> +	if (user_mode(regs)) {
> +		tcb->rip = regs->x86reg_ip;
> +		tcb->forced_um_exit = 1;
> +		regs->x86reg_ip = 0;
> +	}
> +}
> +
> +static inline int
> +xnarch_fixup_userspace_exit(xnarchtcb_t *tcb, xnarch_fltinfo_t *fi)
> +{
> +#ifdef CONFIG_XENO_OPT_PERVASIVE
> +	if (tcb->forced_um_exit) {
> +		fi->regs->x86reg_ip = tcb->rip;
> +		tcb->forced_um_exit = 0;
> +		return 1;
> +	}
> +#endif /* CONFIG_XENO_OPT_PERVASIVE */
> +	return 0;
> +}
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
> index 7002a73..bdb5758 100644
> --- a/ksrc/nucleus/pod.c
> +++ b/ksrc/nucleus/pod.c
> @@ -2547,6 +2547,11 @@ int xnpod_trap_fault(xnarch_fltinfo_t *fltinfo)
>  
>  	thread = xnpod_current_thread();
>  
> +	if (xnarch_fixup_userspace_exit(xnthread_archtcb(thread), fltinfo)) {
> +		xnshadow_relax(0, 0);
> +		return 1;
> +	}
> +
>  	trace_mark(xn_nucleus, thread_fault,
>  		   "thread %p thread_name %s ip %p type %d",
>  		   thread, xnthread_name(thread),
> diff --git a/ksrc/nucleus/sched.c b/ksrc/nucleus/sched.c
> index 0b737a3..64fa0e0 100644
> --- a/ksrc/nucleus/sched.c
> +++ b/ksrc/nucleus/sched.c
> @@ -100,6 +100,7 @@ static void xnsched_watchdog_handler(struct xntimer *timer)
>  			 "'%s'\n", xnthread_name(thread));
>  		xnthread_set_info(thread, XNAMOK | XNKICKED);
>  		xnshadow_send_sig(thread, SIGDEBUG, SIGDEBUG_WATCHDOG, 1);
> +		xnarch_force_userspace_exit(xnthread_archtcb(thread));
>  	} else
>  #endif /* CONFIG_XENO_OPT_PERVASIVE */
>  	{


-- 
Philippe.



