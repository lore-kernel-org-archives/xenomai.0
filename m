From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4AF94F70.9060602@domain.hid>
References: <4AF8A72E.1060204@domain.hid>  <4AF8B50E.4010900@domain.hid>
	<1257848915.2210.487.camel@domain.hid>
	<4AF943BD.3020808@domain.hid>
	<1257850543.2210.494.camel@domain.hid>
	<4AF94F70.9060602@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Nov 2009 14:26:19 +0100
Message-ID: <1257859579.2210.599.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] hal: Ensure atomicity of
 rthal_local_irq_disabled
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2009-11-10 at 12:33 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Tue, 2009-11-10 at 11:43 +0100, Jan Kiszka wrote:
> [...]
> >> Oh, *_hw_smp is new, isn't it? Do we need to wrap it for older I-pipes?
> > 
> > Yes, it was introduced to solve the SMP migration issue actually, so we
> > need a wrapper. The advantage of having that wrapper instead of going
> > for inlined #ifdef CONFIG_SMP is that I could simply get rid of that
> > wrapper in 3.x, since all legacy pipeline patches would be deprecated
> > there anyway.
> 
> Something like this, or where to put the wrapper?
> 

Better move it to asm-generic/hal.h like other i-pipe related
conditionals.

> Jan
> 
> ---
> 
> diff --git a/include/asm-generic/hal.h b/include/asm-generic/hal.h
> index 97c549e..a8bc5ec 100644
> --- a/include/asm-generic/hal.h
> +++ b/include/asm-generic/hal.h
> @@ -117,7 +117,14 @@ typedef spinlock_t rthal_spinlock_t;
>  #endif /* !CONFIG_XENO_OPT_PIPELINE_HEAD */
>  #define rthal_local_irq_flags(x)	((x) = ipipe_test_pipeline_from(&rthal_domain) & 1)
>  #define rthal_local_irq_test()		ipipe_test_pipeline_from(&rthal_domain)
> -#define rthal_local_irq_disabled()	ipipe_test_pipeline_from(&rthal_domain)
> +#define rthal_local_irq_disabled()				\
> +({								\
> +	unsigned long __flags, __ret;				\
> +	local_irq_save_hw_smp(__flags);				\
> +	__ret = ipipe_test_pipeline_from(&rthal_domain);	\
> +	local_irq_restore_hw_smp(__flags);			\
> +	__ret;							\
> +})
>  #define rthal_stage_irq_enable(dom)	ipipe_unstall_pipeline_from(dom)
>  #define rthal_local_irq_save_hw(x)	local_irq_save_hw(x)
>  #define rthal_local_irq_restore_hw(x)	local_irq_restore_hw(x)
> diff --git a/include/asm-generic/wrappers.h b/include/asm-generic/wrappers.h
> index 1cfd60c..c175ea4 100644
> --- a/include/asm-generic/wrappers.h
> +++ b/include/asm-generic/wrappers.h
> @@ -555,4 +555,16 @@ static inline void wrap_proc_dir_entry_owner(struct proc_dir_entry *entry)
>  #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30) */
>  #endif /* CONFIG_PROC_FS */
>  
> +#include <linux/ipipe.h>
> +
> +#ifndef local_irq_save_hw_smp
> +#ifdef CONFIG_SMP
> +#define local_irq_save_hw_smp(flags)	local_irq_save_hw(flags)
> +#define local_irq_restore_hw_smp(flags)	local_irq_restore_hw(flags)
> +#else /* !CONFIG_SMP */
> +#define local_irq_save_hw_smp(flags)	do { (void)(flags); } while (0)
> +#define local_irq_restore_hw_smp(flags)	do { } while (0)
> +#endif /* !CONFIG_SMP */
> +#endif /* !local_irq_save_hw_smp */
> +
>  #endif /* _XENO_ASM_GENERIC_WRAPPERS_H */
> 


-- 
Philippe.



