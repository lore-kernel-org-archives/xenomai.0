Date: Fri, 14 Sep 2018 17:16:58 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180914171658.169ee9bf@md1pvb1c.ad001.siemens.net>
In-Reply-To: <20180914151018.1226-5-henning.schild@siemens.com>
References: <20180914151018.1226-1-henning.schild@siemens.com>
 <20180914151018.1226-5-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCHv2 4/4] cobalt/x86: add ipipe-4.14 eager fpu
 support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

All three kernels are tested now. I addressed comments from the first
review. Unfortunately i did not find a nice split to reduce the ifdef
hell we are in here.

I guess once we drop lazy fpu, most of it will go away.

Henning

Am Fri, 14 Sep 2018 17:10:18 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> 4.14 is always eager, unfortunately we will need a few ifdefs inside
> the eager fpu support as well.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  .../arch/x86/include/asm/xenomai/wrappers.h   |  4 ++++
>  kernel/cobalt/arch/x86/thread.c               | 21
> ++++++++++++++++++- 2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
> b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h index
> a47730106..a4cc368a5 100644 ---
> a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h +++
> b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h @@ -32,6
> +32,10 @@ LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
>  #define IPIPE_X86_FPU_EAGER
>  #endif
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
> +#define IPIPE_X86_FPU_EAGER
> +#endif
> +
>  
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
>  #include <asm/i387.h>
> diff --git a/kernel/cobalt/arch/x86/thread.c
> b/kernel/cobalt/arch/x86/thread.c index 18cf636e5..2668ce274 100644
> --- a/kernel/cobalt/arch/x86/thread.c
> +++ b/kernel/cobalt/arch/x86/thread.c
> @@ -42,6 +42,7 @@ static struct kmem_cache *xstate_cache;
>  #define cpu_has_xsave boot_cpu_has(X86_FEATURE_XSAVE)
>  #endif
>  
> +#ifndef IPIPE_X86_FPU_EAGER
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
>  #include <asm/i387.h>
>  #include <asm/fpu-internal.h>
> @@ -72,6 +73,9 @@ static inline void x86_fpregs_activate(struct
> task_struct *t) #define x86_xstate_alignment
> __alignof__(union fpregs_state) 
>  #endif
> +#else /* IPIPE_X86_FPU_EAGER */
> +#define x86_xstate_alignment		__alignof__(union
> fpregs_state) +#endif /* ! IPIPE_X86_FPU_EAGER */
>  
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0)
>  /*
> @@ -465,9 +469,15 @@ void xnarch_leave_root(struct xnthread *root)
>  	// save fpregs from in-kernel use
>  	copy_fpregs_to_fpstate(rootcb->kfpu);
>  	kernel_fpu_enable();
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
> +	// restore current's fpregs
> +	__cpu_invalidate_fpregs_state();
> +	switch_fpu_finish(&current->thread.fpu, smp_processor_id());
> +#else
>  	// mark current thread as not owning the FPU anymore
>  	if (&current->thread.fpu.fpstate_active)
>  		fpregs_deactivate(&current->thread.fpu);
> +#endif
>  }
>  
>  void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
> @@ -528,7 +538,11 @@ void xnarch_init_shadow_tcb(struct xnthread
> *thread) #else /* IPIPE_X86_FPU_EAGER */
>  	/* XNFPU is always set */
>  	xnthread_set_state(thread, XNFPU);
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
>  	fpu__activate_fpstate_read(&p->thread.fpu);
> +#else
> +	fpu__initialize(&p->thread.fpu);
> +#endif
>  #endif /* ! IPIPE_X86_FPU_EAGER */
>  }
>  
> @@ -537,7 +551,12 @@ int mach_x86_thread_init(void)
>  	xstate_cache = kmem_cache_create("cobalt_x86_xstate",
>  					 fpu_kernel_xstate_size,
>  					 x86_xstate_alignment,
> -					 SLAB_NOTRACK, NULL);
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
> +					 SLAB_NOTRACK,
> +#else
> +					 0,
> +#endif
> +					 NULL);
>  	if (xstate_cache == NULL)
>  		return -ENOMEM;
>  



-- 
Siemens AG
Corporate Technology
CT RDA IOT SES-DE
Otto-Hahn-Ring 6
81739 Muenchen, Germany
Mobile: +49 172 8378927
mailto: henning.schild@siemens.com

