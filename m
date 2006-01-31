Message-ID: <43DFA9C9.4000209@domain.hid>
Date: Tue, 31 Jan 2006 19:17:45 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rt_heap in userspace, heapsize [patch]
References: <43CCF7C2.6070403@domain.hid> <200601172237.56905.kisda@domain.hid>
In-Reply-To: <200601172237.56905.kisda@domain.hid>
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

Stefan Kisdaroczi wrote:
> Hi again,
> 
> I looked at the sources now...
> 
> Am Tuesday 17 January 2006 14:57 schrieb Stefan Kisdaroczi:
> 
>>Hi,
>>
>>I made a small test with rt_heap_ in userspace,
>>i think I understood the actual limitations of the userspace support.
>>I used 10000 as heapsize. Xenomai 2.1-RC2/x86.
>>
>>This should alloc the entire heap, according to the API documentation:
>>rt_heap_create( ..., ..., 10000, ... )
>>rt_heap_alloc( ..., 10000, ..., .... ) -> This call fails, but it should
>>work
> 
> API documentation: "If the heap is shared, this value can be either zero, or 
> the same value given to rt_heap_create()."
> 
> Looking at the code, calculating the right value can be tricky and would 
> depend on xeno-internals. rt_heap_inquire would be another way to get it.
> 
> Only accepting 0 would be less confusing. See (untested) patch as as 
> suggestion.
> 

Actually, the idea behind allowing to pass the original heap size is to provide a 
cheap sanity check to distributed and/or multi-component applications that share a 
  memory segment to cooperate. If each of them passes the size of the expected shm 
block, all of them must pass the same value for the application to bootstrap 
properly. Of course, there is a lot of ways to defeat this simple check,  but if a 
C struct is used to define the layout of such segment and sizeof(this_struct) is 
passed to rt_heap_create(), then, trivial discrepancies due to member 
addition/removal become detectable, at least. This may save some headbanging on 
one's office walls in case of miscompilation of some sort...

> 
>>Using heapsize 0 it works:
>>rt_heap_create( ..., ..., 10000, ... )
>>rt_heap_alloc( ..., 0, ..., .... )
>>
>>rt_heap_inquire shows a heapsize of 12228 (IIRC).
>>So, this would probably work (untested):
>>rt_heap_create( ..., ..., 10000, ... )
>>rt_heap_alloc( ..., 12228, ..., .... )
>>
>>The 2228 bytes difference seems to be the space needed for the heap control
>>structures.
>>
>>I think the following should be fixed:
>>1) rt_create_alloc should alter the heapsize the same as rt_heap_create
>>does 
> 
> Makes no sense, after looking at the code.
> 
> 
>>>2) rt_heap_inquire should return the _real_ heapsize 
> 
> The real heap space can be bigger than the requested, so this can happen.
> 
> thx again
> kisda
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

