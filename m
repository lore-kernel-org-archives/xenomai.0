Message-ID: <4402549A.30201@domain.hid>
Date: Mon, 27 Feb 2006 02:23:38 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] set VM_RESERVED for remapped mem
References: <440205C3.80900@domain.hid>
In-Reply-To: <440205C3.80900@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> while reviewing my own rtdm_mmap-code again, I noticed that the wrapped
> remap_pfn_range() sets VM_RESERVED (+ some other bits) on the passed vma
> while the compatibility function remap_page_range() doesn't do this.
> This flag seems to exclude the vma from swapping considerations.
> 
> Adding the bit to the wrapper appears to me as the best way to catch
> this on older kernels. And this should also make the VM_LOCKED setting
> obsolete in nucleus/heap.c.
>

Sounds good, even if the deprecated remap_page_range() did not change the VMA 
flags, but I cannot come with a better approach, and after all, we always align on 
the behaviour of the most recent version supported, i.e. remap_pfn_range(), so 
that's definitely ok. Fixed, thanks.

> Feel free to correct/enlighten me.
> 
> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: include/asm-generic/wrappers.h
> ===================================================================
> --- include/asm-generic/wrappers.h	(Revision 600)
> +++ include/asm-generic/wrappers.h	(Arbeitskopie)
> @@ -46,8 +46,10 @@
>  #define module_param_named(name,var,type,mode)  module_param(var,type,mode)
>  
>  /* VM */
> -#define wrap_remap_page_range(vma,from,to,size,prot) \
> -    remap_page_range(from,to,size,prot)
> +#define wrap_remap_page_range(vma,from,to,size,prot) do { \
> +    vma->flags |= VM_RESERVED; \
> +    remap_page_range(from,to,size,prot); \
> +} while (0)
>  #define wrap_switch_mm(prev,next,task)	\
>      switch_mm(prev,next,task,(task)->processor)
>  #define wrap_enter_lazy_tlb(mm,task)	\
> @@ -145,8 +147,10 @@
>  #define wrap_remap_page_range(vma,from,to,size,prot)  \
>      remap_pfn_range(vma,from,(to) >> PAGE_SHIFT,size,prot)
>  #else /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10) */
> -#define wrap_remap_page_range(vma,from,to,size,prot)  \
> -    remap_page_range(vma,from,to,size,prot)
> +#define wrap_remap_page_range(vma,from,to,size,prot) do { \
> +    vma->flags |= VM_RESERVED; \
> +    remap_page_range(vma,from,to,size,prot); \
> +} while (0)
>  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,10) */
>  #define wrap_switch_mm(prev,next,task)	\
>      switch_mm(prev,next,task)
> Index: ksrc/nucleus/heap.c
> ===================================================================
> --- ksrc/nucleus/heap.c	(Revision 600)
> +++ ksrc/nucleus/heap.c	(Arbeitskopie)
> @@ -948,7 +948,6 @@
>  	return -ENXIO;	/* Doesn't match the heap size. */
>          
>      vma->vm_ops = &xnheap_vmops;
> -    vma->vm_flags |= VM_LOCKED;	/* Don't swap this out. */
>      vma->vm_private_data = file->private_data;
>  
>      vaddr = (unsigned long)heap->archdep.heapbase;
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

