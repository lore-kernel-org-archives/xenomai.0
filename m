References: <cover.1535375976.git.henning.schild@siemens.com>
 <b213d887c6dafd679240fd9c92db81650fea9fd0.1535375976.git.henning.schild@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <44d138fc-717e-6b56-c9db-49cd9b5ea4f5@siemens.com>
Date: Mon, 27 Aug 2018 18:28:52 +0200
MIME-Version: 1.0
In-Reply-To: <b213d887c6dafd679240fd9c92db81650fea9fd0.1535375976.git.henning.schild@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 3/3] cobalt/x86: add ipipe-4.14 eager fpu
 support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, Xenomai <xenomai@xenomai.org>

On 2018-08-27 15:28, Henning Schild wrote:
> Signed-off-by: Henning Schild <henning.schild@siemens.com>

As this is more than adding the version filter, some commit message 
would be nice.

> ---
>   kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h |  4 ++++
>   kernel/cobalt/arch/x86/thread.c                       | 18 +++++++++++++++---
>   kernel/cobalt/include/asm-generic/xenomai/syscall.h   |  4 ++++
>   3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
> index 0156e86f0..4389d1202 100644
> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
> @@ -35,6 +35,10 @@
>       LINUX_VERSION_CODE > KERNEL_VERSION(4,4,71)
>   #define IPIPE_X86_FPU_EAGER
>   #endif
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
> +#define IPIPE_X86_FPU_EAGER
> +#endif
> +
>   
>   #if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
>   #include <asm/i387.h>
> diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x86/thread.c
> index 54bc5c008..30dd37dab 100644
> --- a/kernel/cobalt/arch/x86/thread.c
> +++ b/kernel/cobalt/arch/x86/thread.c
> @@ -42,6 +42,7 @@ static struct kmem_cache *xstate_cache;
>   #define cpu_has_xsave boot_cpu_has(X86_FEATURE_XSAVE)
>   #endif
>   
> +#ifndef IPIPE_X86_FPU_EAGER
>   #if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
>   #include <asm/i387.h>
>   #include <asm/fpu-internal.h>
> @@ -68,11 +69,11 @@ static inline void x86_fpregs_activate(struct task_struct *t)
>   	if (!x86_fpregs_active(t))
>   		__fpregs_activate(&t->thread.fpu);
>   }
> +#endif

I suspect that this is "< 4.2.0", right?

> +#endif /* !IPIPE_X86_FPU_EAGER */
>   
>   #define x86_xstate_alignment		__alignof__(union fpregs_state)
>   
> -#endif
> -

That looks weird. Are you sure you want to enable that define 
unconditionally?

>   #if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0)
>   /*
>    * This is obsolete context switch code uselessly duplicating
> @@ -462,7 +463,9 @@ void xnarch_leave_root(struct xnthread *root)
>   		return;
>   
>   	// the kernel never marked the task as not being the fpu owner anymore
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)

The comment should address the version differences.

>   	if (&current->thread.fpu.fpstate_active)
> +#endif
>   		fpregs_deactivate(&current->thread.fpu);
>   
>   	copy_fpregs_to_fpstate(rootcb->kfpu);
> @@ -526,7 +529,11 @@ void xnarch_init_shadow_tcb(struct xnthread *thread)
>   
>   #ifdef IPIPE_X86_FPU_EAGER
>   	xnthread_set_state(thread, XNFPU);
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
>   	fpu__activate_fpstate_read(&p->thread.fpu);
> +#else
> +	fpu__prepare_read(&p->thread.fpu);
> +#endif
>   #endif
>   }
>   
> @@ -535,7 +542,12 @@ int mach_x86_thread_init(void)
>   	xstate_cache = kmem_cache_create("cobalt_x86_xstate",
>   					 fpu_kernel_xstate_size,
>   					 x86_xstate_alignment,
> -					 SLAB_NOTRACK, NULL);
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
> +					 SLAB_NOTRACK,
> +#else
> +					 0,
> +#endif
> +					 NULL);
>   	if (xstate_cache == NULL)
>   		return -ENOMEM;
>   
> diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
> index f11ade8e7..9d57eaf74 100644
> --- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
> +++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
> @@ -20,7 +20,11 @@
>   #define _COBALT_ASM_GENERIC_SYSCALL_H
>   
>   #include <linux/types.h>
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
>   #include <asm/uaccess.h>
> +#else
> +#include <linux/uaccess.h>
> +#endif
>   #include <asm/xenomai/features.h>
>   #include <asm/xenomai/wrappers.h>
>   #include <asm/xenomai/machine.h>
> 

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

