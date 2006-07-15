Subject: Re: [Xenomai-core] [PATCH] fix xnheap_alloc rounding
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44B8A259.1040608@domain.hid>
References: <44B3AF69.4050100@domain.hid> <1152928135.5027.60.camel@domain.hid>
	<44B8A259.1040608@domain.hid>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 10:19:35 +0200
Message-Id: <1152951576.5057.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Sat, 2006-07-15 at 10:07 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Tue, 2006-07-11 at 16:02 +0200, Jan Kiszka wrote:
> >> Hi,
> >>
> >> playing a stupid rt_heap user (actually I didn't just play this...), I
> >> stumbled over this undocumented oddity:
> >>
> >> rt_heap_create(&heap, name, 10000, H_PRIO|H_MAPPABLE);
> >> rt_heap_alloc(&heap, 10000, TM_NONBLOCK, &ptr);
> >>
> >> Creation is successful, allocation fails. The reason: while during
> >> creation the net heap size is rounded down to page boundaries, the
> >> allocation of memory > PAGE_SIZE is rounded up. One could add H_SINGLE
> >> to the flags, but this may even result in allocating less memory than
> >> the user expected, causing severe problems later.
> >>
> >> How to resolve this best? I thought about rounding twice in
> >> rt_head_create (one time the net size, the second time including the
> >> overhead), but this encodes characteristics of the underlying heap
> >> allocator into the skin (I have a generic heap allocator framework in
> >> mind for 2.3).
> > 
> > The nucleus heap expects the caller to pass it the memory which is going
> > to be used to fulfill allocation requests, so there is already a builtin
> > dependency from any client heap manager on the nucleus implementation.
> > Double rounding is therefore the way to go, since callers need to be
> > fixed so that they provide enough memory to the xnheap manager when
> > specializing its behaviour.
> 
> If this means to do the rounding in the clients without the help of some
> well-defined xnheap-API, then I disagree. I have an alternative nucleus
> heap manager in mind for the future that will have a different rounding
> strategy for allocations. So we should cleanly hide such property behind
> a xnheap service - either in the overhead calculation or in some
> additional rounding service. But I do not see a need for splitting this
> up yet.

xnheap_overhead() needs to remain that way, i.e. compute the exact
number of additional bytes used for housekeeping purposes by the heap
manager. Fixing the clients by providing them the required support to
perform proper rounding without resorting to open-coded calculations is
another issue, and is indeed the way to go. I'll handle that.

> 
> > 
> >>  So I decided to do this rounding in xnheap_overhead()
> >> instead, see attached patch. Hope I didn't skewed up any calculation. At
> >> least the scenario above now works fine.
> >>
> >> Jan
> >> plain text document attachment (xnheap_overhead-fix-rounding.patch)
> >> Index: include/nucleus/heap.h
> >> ===================================================================
> >> --- include/nucleus/heap.h	(revision 1322)
> >> +++ include/nucleus/heap.h	(working copy)
> >> @@ -109,8 +109,14 @@ extern xnheap_t kheap;
> >>  #define xnheap_used_mem(heap)        ((heap)->ubytes)
> >>  #define xnheap_max_contiguous(heap)  ((heap)->maxcont)
> >>  #define xnheap_overhead(hsize,psize) \
> >> -((sizeof(xnextent_t) + (((hsize) - sizeof(xnextent_t)) / (psize)) + \
> >> - XNHEAP_MINALIGNSZ - 1) & ~(XNHEAP_MINALIGNSZ - 1))
> >> +({ \
> >> +    u_long rounded_hsize = (hsize + psize - 1) & ~(psize - 1); \
> >> +    u_long overhead = ((sizeof(xnextent_t) + \
> >> +	(((rounded_hsize) - sizeof(xnextent_t)) / (psize)) + \
> >> +	XNHEAP_MINALIGNSZ - 1) & ~(XNHEAP_MINALIGNSZ - 1)); \
> >> +    overhead += rounded_hsize - hsize; \
> >> +    overhead; \
> >> +})
> >>  
> >>  #define xnmalloc(size)     xnheap_alloc(&kheap,size)
> >>  #define xnfree(ptr)        xnheap_free(&kheap,ptr)
> >> _______________________________________________
> >> Xenomai-core mailing list
> >> Xenomai-core@domain.hid
> >> https://mail.gna.org/listinfo/xenomai-core
> 
> 
-- 
Philippe.



