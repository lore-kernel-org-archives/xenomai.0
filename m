References: <20200928123359.29826-1-richard@nod.at>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] drvlib: Explain why we need cobalt_machine.prefault
In-reply-to: <20200928123359.29826-1-richard@nod.at>
Date: Wed, 30 Sep 2020 18:10:19 +0200
Message-ID: <87zh571c0k.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>
Cc: xenomai@xenomai.org


Richard Weinberger via Xenomai <xenomai@xenomai.org> writes:

> It is not obvious why cobalt_machine.prefault is needed
> and why only for ARM.
> One would expect that mlockall() would do it too.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> Note: I think we can make mach_arm_prefault() a no-op on arm64
> if cpu_has_hw_af() returns true.
> But I need to test it first. B-)
> ---
>  kernel/cobalt/arch/arm/machine.c   |  5 +++++
>  kernel/cobalt/arch/arm64/machine.c |  5 +++++
>  kernel/cobalt/rtdm/drvlib.c        | 13 +++++++++++++
>  3 files changed, 23 insertions(+)
>
> diff --git a/kernel/cobalt/arch/arm/machine.c b/kernel/cobalt/arch/arm/machine.c
> index 721567182f49..be56b2b84e2e 100644
> --- a/kernel/cobalt/arch/arm/machine.c
> +++ b/kernel/cobalt/arch/arm/machine.c
> @@ -35,6 +35,11 @@ static void mach_arm_prefault(struct vm_area_struct *vma)
>  		flags = (vma->vm_flags & VM_MAYWRITE) ? FAULT_FLAG_WRITE : 0;
>  		for (addr = vma->vm_start;
>  		     addr != vma->vm_end; addr += PAGE_SIZE)
> +			/*
> +			 * Explicitly mark pages dirty such that future writes
> +			 * won't trigger a page fault due to PTE dirty bit
> +			 * emulation.
> +			 */
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0)
>  			handle_mm_fault(vma->vm_mm, vma, addr, flags);
>  #else
> diff --git a/kernel/cobalt/arch/arm64/machine.c b/kernel/cobalt/arch/arm64/machine.c
> index cb2867492360..f820e63624ec 100644
> --- a/kernel/cobalt/arch/arm64/machine.c
> +++ b/kernel/cobalt/arch/arm64/machine.c
> @@ -35,6 +35,11 @@ static void mach_arm_prefault(struct vm_area_struct *vma)
>  		flags = (vma->vm_flags & VM_MAYWRITE) ? FAULT_FLAG_WRITE : 0;
>  		for (addr = vma->vm_start;
>  		     addr != vma->vm_end; addr += PAGE_SIZE)
> +			/*
> +			 * Explicitly mark pages dirty such that future writes
> +			 * won't trigger a page fault due to PTE dirty bit
> +			 * emulation.
> +			 */
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0)
>  			handle_mm_fault(vma->vm_mm, vma, addr, flags);
>  #else
> diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
> index 5778ad559ced..674292d89b71 100644
> --- a/kernel/cobalt/rtdm/drvlib.c
> +++ b/kernel/cobalt/rtdm/drvlib.c
> @@ -1695,6 +1695,19 @@ static int mmap_kmem_helper(struct vm_area_struct *vma, void *va)
>  		}
>  	}
>  
> +	/*
> +	 * Extra prefaulting is needed for two reasons on ARMv8 (and older):
> +	 *

nitpicking: pre-armv8.1-A to be precise? AFAIR, armv8.1-A introduced
hardware support for dirty bit management in PTEs.

> +	 * 1. ARM does not have a dirty PTE flag in hardware, upon first write
> +	 * a page fault exception happens and Linux marks the page as dirty.
> +	 * On x86 this is not the case and therefore the prefault handler can
> +	 * be NULL.
> +	 *

Maybe refer the reader to arch/arm/include/asm/pgtable-2level.h for
details?

> +	 * 2. __mm_populate() (via mlock/all()) does not dirty MAP_SHARED
> +	 * memory mappings, this would trigger a lot of IO due to write back.
> +	 * As of today, __mm_populate() cannot distinguish between MAP_SHARED
> +	 * with and without possible write back.

Another way to say this would be that shared mappings are not touched by
populate_vma_page_range() <- __mm_populate() because their pages cannot
be subject to COW by definition, so there would be no point for the main
kernel in dirtying them uselessly on mlock. However, Cobalt wants to
make sure the page table is always fixed up for those pages in advance
when installing a new shared mapping via RTDM regardless, to spare the
user from increased latency due to receiving a minor fault on first
access.

> +	 */
>  	if (cobalt_machine.prefault)
>  		cobalt_machine.prefault(vma);
>  #endif

-- 
Philippe.

