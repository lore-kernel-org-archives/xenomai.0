Message-ID: <43DF72A6.2090805@domain.hid>
Date: Tue, 31 Jan 2006 15:22:30 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] rt_heap reminder
References: <200601302311.48645.kisda@domain.hid>
In-Reply-To: <200601302311.48645.kisda@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org


Hi,

Stefan Kisdaroczi wrote:
> Hi all,
> 
> as a reminder (userspace, native skin, shared heap) [1]:
> API documentation: "If the heap is shared, this value can be either zero, or 
> the same value given to rt_heap_create()."
> This is not true. As the heapsize gets altered in rt_heap_create for page size 
> alignment, the following call to rt_heap_alloc with the same value will fail.
> 
> Ex:
> rt_heap_create( ..., ..., 10000, ... )
> rt_heap_alloc( ..., 10000, ..., .... ) -> This call fails
> 
> I suggest only accepting zero as a valid size for shared heaps.
> 
> about attached patch:
> 1) not tested
> 2) there are possible better names than H_ALL
> 3) the comments could be in a better english
> 4) i hope you get the idea
>

The heap support is currently reworked in the native API so that we can access it 
from user-space without necessarily asking for a single common block, to obtain a 
shared memory segment, like in the present situation (i.e. the H_ALL mode in your 
patch). The idea is to decouple the mappable and single-block properties of heaps. 
Therefore, your patch is actually going to be a subset of this larger update. 
Thanks for your contribution to this.

> thx
> kisda
> 
> [1] https://mail.gna.org/public/xenomai-core/2006-01/msg00177.html
> 
> 
> ------------------------------------------------------------------------
> 
> Index: include/native/heap.h
> ===================================================================
> --- include/native/heap.h	(Revision 465)
> +++ include/native/heap.h	(Arbeitskopie)
> @@ -32,6 +32,9 @@
>  #define H_DMA    0x100		/* Use memory suitable for DMA. */
>  #define H_SHARED 0x200		/* Use mappable shared memory. */
>  
> +/* Operation flags. */
> +#define H_ALL    0x0	        /* Entire heap space. */
> +
>  typedef struct rt_heap_info {
>  
>      int nwaiters;		/* !< Number of pending tasks. */
> Index: ksrc/skins/native/heap.c
> ===================================================================
> --- ksrc/skins/native/heap.c	(Revision 465)
> +++ ksrc/skins/native/heap.c	(Arbeitskopie)
> @@ -410,10 +410,9 @@
>   * from.
>   *
>   * @param size The requested size in bytes of the block. If the heap
> - * is shared, this value can be either zero, or the same value given
> - * to rt_heap_create(). In any case, the same block covering the
> - * entire heap space will always be returned to all callers of this
> - * service.
> + * is shared, H_ALL should be passed, as always the same block
> + * covering the entire heap space will be returned to all callers of
> + * this service.
>   *
>   * @param timeout The number of clock ticks to wait for a block of
>   * sufficient size to be available from a local heap (see
> @@ -432,8 +431,7 @@
>   * @return 0 is returned upon success. Otherwise:
>   *
>   * - -EINVAL is returned if @a heap is not a heap descriptor, or @a
> - * heap is shared (i.e. H_SHARED mode) and @a size is non-zero but
> - * does not match the actual heap size passed to rt_heap_create().
> + * heap is shared (i.e. H_SHARED mode) and @a size is not H_ALL.
>   *
>   * - -EIDRM is returned if @a heap is a deleted heap descriptor.
>   *
> @@ -503,12 +501,7 @@
>  
>  	if (!block)
>  	    {
> -	    /* It's ok to pass zero for size here, since the requested
> -	       size is implicitely the whole heap space; but if
> -	       non-zero is given, it must match the actual heap
> -	       size. */
> -
> -	    if (size > 0 && size != xnheap_size(&heap->heap_base))
> +	    if (size != H_ALL)
>  		{
>  		err = -EINVAL;
>  		goto unlock_and_exit;
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

