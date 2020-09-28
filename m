Subject: Re: [PATCH] drvlib: Explain why we need cobalt_machine.prefault
References: <20200928123359.29826-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a73c50a3-3596-3631-888a-119e4273fd93@siemens.com>
Date: Mon, 28 Sep 2020 19:39:03 +0200
MIME-Version: 1.0
In-Reply-To: <20200928123359.29826-1-richard@nod.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org

On 28.09.20 14:33, Richard Weinberger via Xenomai wrote:
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
> +	 * 1. ARM does not have a dirty PTE flag in hardware, upon first write
> +	 * a page fault exception happens and Linux marks the page as dirty.
> +	 * On x86 this is not the case and therefore the prefault handler can
> +	 * be NULL.
> +	 *
> +	 * 2. __mm_populate() (via mlock/all()) does not dirty MAP_SHARED
> +	 * memory mappings, this would trigger a lot of IO due to write back.
> +	 * As of today, __mm_populate() cannot distinguish between MAP_SHARED
> +	 * with and without possible write back.
> +	 */
>  	if (cobalt_machine.prefault)
>  		cobalt_machine.prefault(vma);
>  #endif
> 

Sounds reasonable to me, but I'm not deep into that. Will merge unless
someone in CC suggest something different.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

