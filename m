Message-ID: <48305998.8050006@domain.hid>
Date: Sun, 18 May 2008 18:30:16 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <18459.38249.462320.715909@domain.hid>
	<18459.38430.835407.942336@domain.hid>
In-Reply-To: <18459.38430.835407.942336@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Patch 1/7] Support for non cached memory
	mappings
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
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> In addition to support for non cached memory mappings, this patch implements
> xnheap_init_mapped and xnheap_destroy_mapped in the !CONFIG_XENO_OPT_PERVASIVE
> case. This avoids a lot of #ifdefs for users of these functions without
> user-space support (posix skin shared memories, and the new semaphore heaps,
> heaps where is allocated the memory used for storing semaphores counters and
> mutexes owner fields).
>

Looks good. I would suggest to make xnheap_init_mapped() whine and bail out when
non-cached DMA memory is requested though.

> ---
>  include/asm-generic/wrappers.h |   12 +++++---
>  include/native/heap.h          |    1
>  include/nucleus/heap.h         |    2 +
>  ksrc/nucleus/heap.c            |   55 +++++++++++++++++++++++++++++++++++------
>  ksrc/skins/native/heap.c       |    8 +++++
>  5 files changed, 66 insertions(+), 12 deletions(-)
> 
> Index: include/native/heap.h
> ===================================================================
> --- include/native/heap.h	(revision 3738)
> +++ include/native/heap.h	(working copy)
> @@ -33,6 +33,7 @@
>  #define H_MAPPABLE 0x200	/* Memory is mappable to user-space. */
>  #define H_SINGLE   0x400	/* Manage as single-block area. */
>  #define H_SHARED   (H_MAPPABLE|H_SINGLE) /* I.e. shared memory segment. */
> +#define H_NONCACHED 0x800
>  
>  /** Structure containing heap-information useful to users.
>   *
> Index: include/asm-generic/wrappers.h
> ===================================================================
> --- include/asm-generic/wrappers.h	(revision 3738)
> +++ include/asm-generic/wrappers.h	(working copy)
> @@ -62,7 +62,7 @@ unsigned long __va_to_kva(unsigned long 
>  
>  #define wrap_remap_vm_page(vma,from,to) ({ \
>      vma->vm_flags |= VM_RESERVED; \
> -    remap_page_range(from,virt_to_phys((void *)__va_to_kva(to)),PAGE_SIZE,PAGE_SHARED); \
> +    remap_page_range(from,virt_to_phys((void *)__va_to_kva(to)),PAGE_SIZE,vma->vm_page_prot); \
>  })
>  #define wrap_remap_io_page_range(vma,from,to,size,prot) ({ \
>      vma->vm_flags |= VM_RESERVED; \
> @@ -223,7 +223,7 @@ unsigned long __va_to_kva(unsigned long 
>   * memory. Anyway, this legacy would only hit setups using pre-2.6.11
>   * kernel revisions. */
>  #define wrap_remap_vm_page(vma,from,to) \
> -    remap_pfn_range(vma,from,virt_to_phys((void *)__va_to_kva(to)) >> PAGE_SHIFT,PAGE_SHIFT,PAGE_SHARED)
> +    remap_pfn_range(vma,from,virt_to_phys((void *)__va_to_kva(to)) >> PAGE_SHIFT,PAGE_SHIFT,vma->vm_page_prot)
>  #define wrap_remap_io_page_range(vma,from,to,size,prot)  ({		\
>      (vma)->vm_page_prot = pgprot_noncached((vma)->vm_page_prot);	\
>      /* Sets VM_RESERVED | VM_IO | VM_PFNMAP on the vma. */		\
> @@ -236,7 +236,7 @@ unsigned long __va_to_kva(unsigned long 
>  #else /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10) */
>  #define wrap_remap_vm_page(vma,from,to) ({ \
>      vma->vm_flags |= VM_RESERVED; \
> -    remap_page_range(from,virt_to_phys((void *)__va_to_kva(to)),PAGE_SIZE,PAGE_SHARED); \
> +    remap_page_range(from,virt_to_phys((void *)__va_to_kva(to)),PAGE_SIZE,vma->vm_page_prot); \
>  })
>  #define wrap_remap_io_page_range(vma,from,to,size,prot) ({	\
>        vma->vm_flags |= VM_RESERVED;				\
> @@ -248,7 +248,11 @@ unsigned long __va_to_kva(unsigned long 
>      })
>  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,15) */
>  
> -#define wrap_switch_mm(prev,next,task)	\
> +#ifndef __GFP_BITS_SHIFT
> +#define __GFP_BITS_SHIFT 20
> +#endif
> +
> +#define wrap_switch_mm(prev,next,task)		\
>      switch_mm(prev,next,task)
>  #define wrap_enter_lazy_tlb(mm,task)	\
>      enter_lazy_tlb(mm,task)
> Index: include/nucleus/heap.h
> ===================================================================
> --- include/nucleus/heap.h	(revision 3738)
> +++ include/nucleus/heap.h	(working copy)
> @@ -57,6 +57,8 @@
>  #define XNHEAP_PCONT   1
>  #define XNHEAP_PLIST   2
>  
> +#define XNHEAP_GFP_NONCACHED (1 << __GFP_BITS_SHIFT)
> +
>  typedef struct xnextent {
>  
>  	xnholder_t link;
> Index: ksrc/skins/native/heap.c
> ===================================================================
> --- ksrc/skins/native/heap.c	(revision 3738)
> +++ ksrc/skins/native/heap.c	(working copy)
> @@ -205,6 +205,10 @@ static void __heap_flush_private(xnheap_
>   * operations with I/O devices. The physical address of the
>   * heap can be obtained by a call to rt_heap_inquire().
>   *
> + * - H_NONCACHED causes the heap not to be cached. This is necessary on
> + * platforms such as ARM to share a heap between kernel and user-space.
> + * Note that this flag is not compatible with the H_DMA flag.
> + *
>   * @return 0 is returned upon success. Otherwise:
>   *
>   * - -EEXIST is returned if the @a name is already in use by some
> @@ -260,7 +264,9 @@ int rt_heap_create(RT_HEAP *heap, const 
>  
>  		err = xnheap_init_mapped(&heap->heap_base,
>  					 heapsize,
> -					 (mode & H_DMA) ? GFP_DMA : 0);
> +					 ((mode & H_DMA) ? GFP_DMA : 0)
> +					 | ((mode & H_NONCACHED) ?
> +					    XNHEAP_GFP_NONCACHED : 0));
>  		if (err)
>  			return err;
>  
> Index: ksrc/nucleus/heap.c
> ===================================================================
> --- ksrc/nucleus/heap.c	(revision 3738)
> +++ ksrc/nucleus/heap.c	(working copy)
> @@ -1097,9 +1097,13 @@ static int xnheap_mmap(struct file *file
>  
>  	vaddr = (unsigned long)heap->archdep.heapbase;
>  
> -	if (!heap->archdep.kmflags) {
> +	if (!heap->archdep.kmflags
> +	    || heap->archdep.kmflags == XNHEAP_GFP_NONCACHED) {
>  		unsigned long maddr = vma->vm_start;
>  
> +		if (heap->archdep.kmflags == XNHEAP_GFP_NONCACHED)
> +			vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +
>  		while (size > 0) {
>  			if (xnarch_remap_vm_page(vma, maddr, vaddr))
>  				return -EAGAIN;
> @@ -1174,9 +1178,13 @@ static inline void *__alloc_and_reserve_
>  
>  	/* Size must be page-aligned. */
>  
> -	if (!kmflags) {
> -		ptr = vmalloc(size);
> -
> +	if (!kmflags || kmflags == XNHEAP_GFP_NONCACHED) {
> +		if (!kmflags)
> +			ptr = vmalloc(size);
> +		else
> +			ptr = __vmalloc(size,
> +					GFP_KERNEL | __GFP_HIGHMEM,
> +					pgprot_noncached(PAGE_KERNEL));
>  		if (!ptr)
>  			return NULL;
>  
> @@ -1217,7 +1225,7 @@ static inline void __unreserve_and_free_
>  
>  	vabase = (unsigned long)ptr;
>  
> -	if (!kmflags) {
> +	if (!kmflags  || kmflags == XNHEAP_GFP_NONCACHED) {
>  		for (vaddr = vabase; vaddr < vabase + size; vaddr += PAGE_SIZE)
>  			ClearPageReserved(virt_to_page(__va_to_kva(vaddr)));
>  
> @@ -1241,6 +1249,11 @@ int xnheap_init_mapped(xnheap_t *heap, u
>  
>  	/* Caller must have accounted for internal overhead. */
>  	heapsize = xnheap_align(heapsize, PAGE_SIZE);
> +
> +	if ((memflags & XNHEAP_GFP_NONCACHED)
> +	    && memflags != XNHEAP_GFP_NONCACHED)
> +		return -EINVAL;
> +
>  	heapbase = __alloc_and_reserve_heap(heapsize, memflags);
>  
>  	if (!heapbase)
> @@ -1284,11 +1297,39 @@ int xnheap_destroy_mapped(xnheap_t *heap
>  	return 0;
>  }
>  
> -EXPORT_SYMBOL(xnheap_init_mapped);
> -EXPORT_SYMBOL(xnheap_destroy_mapped);
> +#else /* !CONFIG_XENO_OPT_PERVASIVE */
> +static void xnheap_free_extent(xnheap_t *heap,
> +			       void *extent, u_long size, void *cookie)
> +{
> +	xnarch_free_host_mem(extent, size);
> +}
> +
> +int xnheap_init_mapped(xnheap_t *heap, unsigned len, int flags)
> +{
> +	void *heapaddr = xnarch_alloc_host_mem(len);
> +	int err;
>  
> +	if (heapaddr) {
> +		err = xnheap_init(&shm->heapbase,
> +				  heapaddr, len, XNCORE_PAGE_SIZE);
> +		if (err)
> +			xnarch_free_host_mem(heapaddr, len);
> +
> +		return err;
> +	}
> +
> +	return -ENOMEM;
> +}
> +
> +void xnheap_destroy_mapped(xnheap_t *heap)
> +{
> +	xnheap_destroy(heap, &xnheap_free_extent, NULL);
> +}
>  #endif /* CONFIG_XENO_OPT_PERVASIVE */
>  
> +EXPORT_SYMBOL(xnheap_init_mapped);
> +EXPORT_SYMBOL(xnheap_destroy_mapped);
> +
>  /*@}*/
>  
>  EXPORT_SYMBOL(xnheap_alloc);
> 


-- 
Philippe.

