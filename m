Subject: Re: [Xenomai-core] Nocow patch.
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45A6554D.2060900@domain.hid>
References: <45A52B04.1010706@domain.hid>  <45A6554D.2060900@domain.hid>
Content-Type: text/plain
Date: Sat, 13 Jan 2007 19:57:53 +0100
Message-Id: <1168714673.21854.17.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2007-01-11 at 16:18 +0100, Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
> > This was run on x86, but need further testing before inclusion.
> 
> Here is a new version, after testing. It appears to run fine. I tested
> forking in real-time applications both before and after calling
> rt_task_shadow, and vmallocing areas of 256 Mo, and memseting them both
> from a non-realtime or real-time context and it works.
> 
> The next step is to clean up the patch, but I have to admit that I need
> some help: should I keep the functions in the files where I put them ?
> in what headers should I declare them ? Should I define an empty
> ipipe_update_nofault_mms when CONFIG_IPIPE is not set in order to avoid
> a few #ifdefs ?

> diff -Naurdp -x '*~' ipipe-2.6.19/arch/i386/mm/fault.c ipipe-2.6.19-nocow/arch/i386/mm/fault.c
> --- ipipe-2.6.19/arch/i386/mm/fault.c	2007-01-10 09:44:52.000000000 +0100
> +++ ipipe-2.6.19-nocow/arch/i386/mm/fault.c	2007-01-11 09:58:49.000000000 +0100
> @@ -654,3 +654,19 @@ void vmalloc_sync_all(void)
>  	}
>  }
>  #endif
> +
> +#ifdef CONFIG_IPIPE
> +int ipipe_arch_map_vm_area_to_mm(struct mm_struct *mm,
> +				 unsigned long start,
> +				 unsigned long end)
> +{

__ipipe_pin_range_mapping() would better identify an internal routine
which somehow wires the mapping of a virtual address range into a
memory context.

[...]

> +
> +#if CONFIG_IPIPE
> +	struct list_head nofault;

s,nofault,pinned, ?  The point is that the NOFAULT feature does not
really disable all faults, but only faults leading to lazy/ondemand
mappings. E.g. pathological faults would still raise exceptions.

> +#endif /* CONFIG_IPIPE */
>  };
>  
>  struct sighand_struct {
> diff -Naurdp -x '*~' ipipe-2.6.19/kernel/fork.c ipipe-2.6.19-nocow/kernel/fork.c
> --- ipipe-2.6.19/kernel/fork.c	2007-01-10 09:44:53.000000000 +0100
> +++ ipipe-2.6.19-nocow/kernel/fork.c	2007-01-11 15:32:25.000000000 +0100
> @@ -385,6 +385,7 @@ void mmput(struct mm_struct *mm)
>  
>  	if (atomic_dec_and_test(&mm->mm_users)) {
>  		ipipe_cleanup_notify(mm);
> +		ipipe_destroy_nofault_mm(mm);

We may want to merge both into the notification trigger. Those
nitty-gritty I-pipe details ought to be gathered; after all, removing
the mm from the pinned mm queue is also a cleanup operation. This
would also remove the need for adding a placeholder in the
!CONFIG_IPIPE case.

[...]

> -
> +#ifdef CONFIG_IPIPE
> +	ipipe_update_nofault_mms(start, end);

I'd suggest something like __ipipe_update_all_pinned_mm().

[...]

> +#ifdef CONFIG_IPIPE
> +#include <linux/vmalloc.h>	/* For vmlist */
> +#endif /* CONFIG_IPIPE */

No need for noisy conditional here. Including linux/vmalloc.h has no
undesirable side-effect in the !CONFIG_IPIPE case anyway.

[...]

> +
> +#ifdef CONFIG_IPIPE
> +static LIST_HEAD(nofault_mms);
> +static DEFINE_RWLOCK(nofault_mms_lock);
> +
> +static int ipipe_fault_pte_range(struct mm_struct *mm, pmd_t *pmd,
> +				 struct vm_area_struct *vma,
> +				 unsigned long addr, unsigned long

[...]

> +static int ipipe_fault_pmd_range(struct mm_struct *mm, pud_t *pud,
> +				 struct vm_area_struct *vma,
> +				 unsigned long addr, unsigned long end)

[...]

> +static int ipipe_fault_pud_range(struct mm_struct *mm, pgd_t *pgd,
> +				 struct vm_area_struct *vma,
> +				 unsigned long addr, unsigned long end)

[...]

Those routines are good candidates for inlining.

> +int ipipe_disable_task_faults(struct task_struct *tsk)
> +{

ipipe_disable_ondemand_mappings() would be more accurate.

[...]

> +#ifdef CONFIG_IPIPE
> +	ipipe_update_nofault_mms((unsigned long) area->addr, end);
> +#endif /* CONFIG_IPIPE */

Better define a nop placeholder for __ipipe_update_all_pinned_mm()
in the !CONFIG_IPIPE case instead of the conditional.

-- 
Philippe.



