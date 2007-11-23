Message-ID: <47470916.6050308@domain.hid>
Date: Fri, 23 Nov 2007 18:08:38 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2AE092AC@ARVMAIL1.mra.roland-man.biz>
	<4742E82B.1040000@domain.hid>
In-Reply-To: <4742E82B.1040000@domain.hid>
Content-Type: multipart/mixed; boundary="------------020204000905090408050808"
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_write error: "Cannot allocate memory ";
 bug or feature ?
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik.Wildenburg@domain.hid
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------020204000905090408050808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Roderik.Wildenburg@domain.hid wrote:
>>> No more than one block is allocated at any given time in your example.
>>> This is expected due to the priority scheme your test 
>>> undergoes. In any
>>> case, 282 bytes (+ a few bytes message header) should grab 
>>> one 512-byte
>>> buffer here. For anything below the size of a logical page (4k in
>>> 2.3.x), the allocator picks the next power of 2 greater or 
>>> equal to the
>>> requested size.
>> Is it possible that a allocated block remembers the size he is allocated
>> for 
>> and that the block is just usable for this size even after the block is
>> freed ?
>>
> 
> The block will belong to a 512-byte pool until all the blocks from the
> same pool are free, in which case the entire page the pool sits on will
> be moved to a free page list, and recycled for blocks of any size.
> 

Did I say that? Mmff..., I lied, then.

As a matter of fact, the issue you face is due to pages holding blocks
of size <= pagesize * 2 (i.e. 8k in our case), lingering in the free
bucket queues, instead of being moved to the global free page list.

Now, the human readable form of the explanation:
- you ask for a 10kb heap, which is silently rounded to 12k in order to
cope with the 4k alignment constraint we have on shareable heaps
(userland heaps are always shareable).
- 12kb heap means 3 * 4k pages available in the global free list.
- your application allocates randomly-sized blocks, each new size
rounded to the next power of 2 grabs one page from the global pool to
hold blocks of the same size, but unfortunately, the heap manager does
_not_ release it back to the free list when the last block laid on the
page is freed.
- after more than 3 different allocation sizes (e.g. 2^3, 2^5 and 2^8)
have been requested to the heap manager, it fails honoring a fourth one.

I would rather consider this as a bug, since putting a lot of pressure
on a single block size would beget the same problem (i.e. no need for a
funky randomized allocation pattern here), with a global free page list
being emptied over time, and all pages lingering inside some private
(per-block size) bucket queue.

The attached patch fixed the issue (against v2.4-rc6). I'm still
pondering whether v2.3.x should get this update too, due to the
variations this patch introduces wrt memory consumption for the heap
meta-data. Still, it also fixes a miscalculated overhead value for such
meta-data in all previous releases, so merging it would make sense.
You can give it a try on v2.3.x, you would just have to fix a trivial
hunk manually on include/nucleus/heap.h.

-- 
Philippe.

--------------020204000905090408050808
Content-Type: text/x-patch;
 name="heap-fix-bucket-page-recycling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="heap-fix-bucket-page-recycling.patch"

Index: include/nucleus/heap.h
===================================================================
--- include/nucleus/heap.h	(revision 3204)
+++ include/nucleus/heap.h	(working copy)
@@ -47,7 +47,7 @@
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
 #define XNHEAP_MINLOG2    3
-#define XNHEAP_MAXLOG2    22
+#define XNHEAP_MAXLOG2    22	/* Must hold pagemap::bcount objects */
 #define XNHEAP_MINALLOCSZ (1 << XNHEAP_MINLOG2)
 #define XNHEAP_MINALIGNSZ (1 << 4) /* i.e. 16 bytes */
 #define XNHEAP_NBUCKETS   (XNHEAP_MAXLOG2 - XNHEAP_MINLOG2 + 2)
@@ -67,7 +67,10 @@
 		memlim,		/* Memory limit of page array */
 		freelist;	/* Head of the free page list */
 
-	u_char pagemap[1];	/* Beginning of page map */
+	struct xnpagemap {	/* Beginning of page map */
+		unsigned int type : 8;	  /* PFREE, PCONT, PLIST or log2 */
+		unsigned int bcount : 24; /* Number of active blocks. */
+	} pagemap[1];
 
 } xnextent_t;
 
@@ -101,18 +104,26 @@
 
 extern xnheap_t kheap;
 
-#define xnheap_extentsize(heap)      ((heap)->extentsize)
-#define xnheap_page_size(heap)       ((heap)->pagesize)
-#define xnheap_page_count(heap)      ((heap)->npages)
-#define xnheap_usable_mem(heap)      ((heap)->maxcont * countq(&(heap)->extents))
-#define xnheap_used_mem(heap)        ((heap)->ubytes)
-#define xnheap_max_contiguous(heap)  ((heap)->maxcont)
-#define xnheap_overhead(hsize,psize) \
-((sizeof(xnextent_t) + (((hsize) - sizeof(xnextent_t)) / (psize)) + \
- XNHEAP_MINALIGNSZ - 1) & ~(XNHEAP_MINALIGNSZ - 1))
-/* The alignment value must be a power of 2 */
-#define xnheap_align(size,al)		(((size)+(al)-1)&(~((al)-1)))
+#define xnheap_extentsize(heap)		((heap)->extentsize)
+#define xnheap_page_size(heap)		((heap)->pagesize)
+#define xnheap_page_count(heap)		((heap)->npages)
+#define xnheap_usable_mem(heap)		((heap)->maxcont * countq(&(heap)->extents))
+#define xnheap_used_mem(heap)		((heap)->ubytes)
+#define xnheap_max_contiguous(heap)	((heap)->maxcont)
 
+static inline size_t xnheap_align(size_t size, size_t al)
+{
+	/* The alignment value must be a power of 2 */
+	return ((size+al-1)&(~(al-1)));
+}
+
+static inline size_t xnheap_overhead(size_t hsize, size_t psize)
+{
+	size_t m = psize / sizeof(struct xnpagemap);
+	size_t q = ((hsize - sizeof(xnextent_t)) * m) / (m + 1);
+	return xnheap_align(hsize - q, XNHEAP_MINALIGNSZ);
+}
+
 #define xnmalloc(size)     xnheap_alloc(&kheap,size)
 #define xnfree(ptr)        xnheap_free(&kheap,ptr)
 #define xnfreesync()       xnheap_finalize_free(&kheap)
@@ -132,12 +143,14 @@
 	 * match the requested size. Using a small page size for large
 	 * single-block heaps might reserve a lot of useless page map
 	 * memory, but this should never get pathological anyway,
-	 * since we are only consuming 1 byte per page.
+	 * since we only consume 4 bytes per page.
 	 */
 	if (hsize < 2 * psize)
 		hsize = 2 * psize;
-	hsize = xnheap_align(hsize,psize) + xnheap_overhead(hsize,psize);
-	return xnheap_align(hsize,psize);
+	else
+		hsize = xnheap_align(hsize, psize);
+	hsize += xnheap_overhead(hsize, psize);
+	return xnheap_align(hsize, psize);
 }
 
 #ifdef __cplusplus
Index: ksrc/nucleus/heap.c
===================================================================
--- ksrc/nucleus/heap.c	(revision 3204)
+++ ksrc/nucleus/heap.c	(working copy)
@@ -66,6 +66,7 @@
 #include <nucleus/pod.h>
 #include <nucleus/thread.h>
 #include <nucleus/heap.h>
+#include <nucleus/assert.h>
 #include <asm/xenomai/bits/heap.h>
 
 xnheap_t kheap;			/* System heap */
@@ -85,11 +86,13 @@
 	for (n = 0, freepage = extent->membase;
 	     n < lastpgnum; n++, freepage += heap->pagesize) {
 		*((caddr_t *) freepage) = freepage + heap->pagesize;
-		extent->pagemap[n] = XNHEAP_PFREE;
+		extent->pagemap[n].type = XNHEAP_PFREE;
+		extent->pagemap[n].bcount = 0;
 	}
 
 	*((caddr_t *) freepage) = NULL;
-	extent->pagemap[lastpgnum] = XNHEAP_PFREE;
+	extent->pagemap[lastpgnum].type = XNHEAP_PFREE;
+	extent->pagemap[lastpgnum].bcount = 0;
 	extent->memlim = freepage + heap->pagesize;
 
 	/* The first page starts the free list of a new extent. */
@@ -118,12 +121,17 @@
  *
  * @param heapsize The size in bytes of the initial extent pointed at
  * by @a heapaddr. @a heapsize must be a multiple of pagesize and
- * lower than 16 Mbytes. @a heapsize must be large enough to contain
- * an internal header. The following formula gives the size of this
- * header:\n
- * hdrsize = (sizeof(xnextent_t) + ((heapsize -
- * sizeof(xnextent_t))) / (pagesize + 1) + 15) & ~15.\n
+ * lower than 16 Mbytes. @a heapsize must be large enough to contain a
+ * dynamically-sized internal header. The following formula gives the
+ * size of this header:\n
  *
+ * H = heapsize, P=pagesize, M=sizeof(struct pagemap), E=sizeof(xnextent_t)\n
+ * hdrsize = ((H - E) * M) / (M + 1)\n
+ *
+ * This value is then aligned on the next 16-byte boundary. The
+ * routine xnheap_overhead() computes the corrected heap size
+ * according to the previous formula.
+ *
  * @param pagesize The size in bytes of the fundamental memory page
  * which will be used to subdivide the heap internally. Choosing the
  * right page size is important regarding performance and memory
@@ -174,30 +182,37 @@
 	    heapsize > XNHEAP_MAXEXTSZ || (heapsize & (pagesize - 1)) != 0)
 		return -EINVAL;
 
-	/* Determine the page map overhead inside the given extent
-	   size. We need to reserve a byte in a page map for each page
-	   which is addressable into this extent. The page map is itself
-	   stored in the extent space, right after the static part of its
-	   header, and before the first allocatable page.
-	   pmapsize = (heapsize - sizeof(xnextent_t)) / pagesize; */
-
-	/* The overall header size is: static_part + page_map rounded to
-	   the minimum alignment size. */
+	/*
+	 * Determine the page map overhead inside the given extent
+	 * size. We need to reserve 4 bytes in a page map for each
+	 * page which is addressable into this extent. The page map is
+	 * itself stored in the extent space, right after the static
+	 * part of its header, and before the first allocatable page.
+	 * pmapsize = (heapsize - sizeof(xnextent_t)) / pagesize *
+	 * sizeof(struct xnpagemap). The overall header size is:
+	 * static_part + pmapsize rounded to the minimum alignment
+	 * size.
+	*/
 	hdrsize = xnheap_overhead(heapsize, pagesize);
 
-	/* An extent must contain at least two addressable pages to cope
-	   with allocation sizes between pagesize and 2 * pagesize. */
-	if (hdrsize + 2 * pagesize > heapsize)
-		return -EINVAL;
-
 	/* Compute the page shiftmask from the page size (i.e. log2 value). */
-	for (pageshift = 0, shiftsize = pagesize; shiftsize > 1; shiftsize >>= 1, pageshift++) ;	/* Loop */
+	for (pageshift = 0, shiftsize = pagesize;
+	     shiftsize > 1; shiftsize >>= 1, pageshift++)
+		;	/* Loop */
 
 	heap->pagesize = pagesize;
 	heap->pageshift = pageshift;
 	heap->extentsize = heapsize;
 	heap->hdrsize = hdrsize;
 	heap->npages = (heapsize - hdrsize) >> pageshift;
+
+	/*
+	 * An extent must contain at least two addressable pages to cope
+	 * with allocation sizes between pagesize and 2 * pagesize.
+	 */
+	if (heap->npages < 2)
+		return -EINVAL;
+
 	heap->ubytes = 0;
 	heap->maxcont = heap->npages * pagesize;
 	heap->idleq = NULL;
@@ -291,16 +306,17 @@
 
 	while (holder != NULL) {
 		extent = link2extent(holder);
-
 		freepage = extent->freelist;
 
 		while (freepage != NULL) {
 			headpage = freepage;
 			freecont = 0;
 
-			/* Search for a range of contiguous pages in the free page
-			   list of the current extent. The range must be 'bsize'
-			   long. */
+			/*
+			 * Search for a range of contiguous pages in
+			 * the free page list of the current
+			 * extent. The range must be 'bsize' long.
+			 */
 			do {
 				lastpage = freepage;
 				freepage = *((caddr_t *) freepage);
@@ -310,9 +326,11 @@
 			       && freecont < bsize);
 
 			if (freecont >= bsize) {
-				/* Ok, got it. Just update the extent's free page
-				   list, then proceed to the next step. */
-
+				/*
+				 * Ok, got it. Just update the free
+				 * page list, then proceed to the next
+				 * step.
+				 */
 				if (headpage == extent->freelist)
 					extent->freelist =
 					    *((caddr_t *) lastpage);
@@ -325,7 +343,6 @@
 
 			freehead = lastpage;
 		}
-
 		holder = nextq(&heap->extents, holder);
 	}
 
@@ -353,19 +370,24 @@
 
 	pagenum = (headpage - extent->membase) >> heap->pageshift;
 
-	/* Update the extent's page map.  If log2size is non-zero
-	   (i.e. bsize <= 2 * pagesize), store it in the first page's slot
-	   to record the exact block size (which is a power of
-	   two). Otherwise, store the special marker XNHEAP_PLIST,
-	   indicating the start of a block whose size is a multiple of the
-	   standard page size, but not necessarily a power of two.  In any
-	   case, the following pages slots are marked as 'continued'
-	   (PCONT). */
+	/*
+	 * Update the page map.  If log2size is non-zero (i.e. bsize
+	 * <= 2 * pagesize), store it in the first page's slot to
+	 * record the exact block size (which is a power of
+	 * two). Otherwise, store the special marker XNHEAP_PLIST,
+	 * indicating the start of a block whose size is a multiple of
+	 * the standard page size, but not necessarily a power of two.
+	 * In any case, the following pages slots are marked as
+	 * 'continued' (PCONT).
+	 */
 
-	extent->pagemap[pagenum] = log2size ? : XNHEAP_PLIST;
+	extent->pagemap[pagenum].type = log2size ? : XNHEAP_PLIST;
+	extent->pagemap[pagenum].bcount = 1;
 
-	for (pagecont = bsize >> heap->pageshift; pagecont > 1; pagecont--)
-		extent->pagemap[pagenum + pagecont - 1] = XNHEAP_PCONT;
+	for (pagecont = bsize >> heap->pageshift; pagecont > 1; pagecont--) {
+		extent->pagemap[pagenum + pagecont - 1].type = XNHEAP_PCONT;
+		extent->pagemap[pagenum + pagecont - 1].bcount = 0;
+	}
 
 	return headpage;
 }
@@ -404,6 +426,9 @@
 
 void *xnheap_alloc(xnheap_t *heap, u_long size)
 {
+	xnholder_t *holder;
+	xnextent_t *extent;
+	u_long pagenum;
 	caddr_t block;
 	u_long bsize;
 	int log2size;
@@ -442,7 +467,9 @@
 		/* Find the first power of two greater or equal to the rounded
 		   size. The log2 value of this size is also computed. */
 
-		for (bsize = (1 << XNHEAP_MINLOG2), log2size = XNHEAP_MINLOG2; bsize < size; bsize <<= 1, log2size++) ;	/* Loop */
+		for (bsize = (1 << XNHEAP_MINLOG2), log2size = XNHEAP_MINLOG2;
+		     bsize < size; bsize <<= 1, log2size++)
+			;	/* Loop */
 
 		xnlock_get_irqsave(&heap->lock, s);
 
@@ -450,9 +477,29 @@
 
 		if (block == NULL) {
 			block = get_free_range(heap, bsize, log2size);
-
 			if (block == NULL)
 				goto release_and_exit;
+		} else {
+			/*
+			 * If only we had all pages sitting on
+			 * pagesize boundaries, we could use a trivial
+			 * address masking to compute the address of
+			 * the containing page, but we can't assume
+			 * that for now. Oh, well...
+			 */
+			for (holder = getheadq(&heap->extents), extent = NULL;
+			     holder != NULL; holder = nextq(&heap->extents, holder)) {
+				extent = link2extent(holder);
+				if ((caddr_t) block >= extent->membase &&
+				    (caddr_t) block < extent->memlim)
+					break;
+			}
+			XENO_ASSERT(NUCLEUS, extent != NULL,
+				    xnpod_fatal("Cannot determine source extent for block %p (heap %p)?!",
+						block, heap);
+				);
+			pagenum = ((caddr_t) block - extent->membase) >> heap->pageshift;
+			++extent->pagemap[pagenum].bcount;
 		}
 
 		heap->buckets[log2size - XNHEAP_MINLOG2] = *((caddr_t *) block);
@@ -534,7 +581,6 @@
 	for (holder = getheadq(&heap->extents);
 	     holder != NULL; holder = nextq(&heap->extents, holder)) {
 		extent = link2extent(holder);
-
 		if ((caddr_t) block >= extent->membase &&
 		    (caddr_t) block < extent->memlim)
 			break;
@@ -551,7 +597,7 @@
 	    ((caddr_t) block -
 	     (extent->membase + (pagenum << heap->pageshift)));
 
-	switch (extent->pagemap[pagenum]) {
+	switch (extent->pagemap[pagenum].type) {
 	case XNHEAP_PFREE:	/* Unallocated page? */
 	case XNHEAP_PCONT:	/* Not a range heading page? */
 
@@ -571,11 +617,13 @@
 		npages = 1;
 
 		while (npages < heap->npages &&
-		       extent->pagemap[pagenum + npages] == XNHEAP_PCONT)
+		       extent->pagemap[pagenum + npages].type == XNHEAP_PCONT)
 			npages++;
 
 		bsize = npages * heap->pagesize;
 
+	free_page_list:
+
 		/* Link all freed pages in a single sub-list. */
 
 		for (freepage = (caddr_t) block,
@@ -583,15 +631,20 @@
 		     freepage < tailpage; freepage += heap->pagesize)
 			*((caddr_t *) freepage) = freepage + heap->pagesize;
 
+	free_pages:
+
 		/* Mark the released pages as free in the extent's page map. */
 
 		for (pagecont = 0; pagecont < npages; pagecont++)
-			extent->pagemap[pagenum + pagecont] = XNHEAP_PFREE;
+			extent->pagemap[pagenum + pagecont].type = XNHEAP_PFREE;
 
 		/* Return the sub-list to the free page list, keeping
 		   an increasing address order to favor coalescence. */
 
-		for (nextpage = extent->freelist, lastpage = NULL; nextpage != NULL && nextpage < (caddr_t) block; lastpage = nextpage, nextpage = *((caddr_t *) nextpage)) ;	/* Loop */
+		for (nextpage = extent->freelist, lastpage = NULL;
+		     nextpage != NULL && nextpage < (caddr_t) block;
+		     lastpage = nextpage, nextpage = *((caddr_t *) nextpage))
+		  ;	/* Loop */
 
 		*((caddr_t *) tailpage) = nextpage;
 
@@ -599,12 +652,11 @@
 			*((caddr_t *) lastpage) = (caddr_t) block;
 		else
 			extent->freelist = (caddr_t) block;
-
 		break;
 
 	default:
 
-		log2size = extent->pagemap[pagenum];
+		log2size = extent->pagemap[pagenum].type;
 		bsize = (1 << log2size);
 
 		if ((boffset & (bsize - 1)) != 0)	/* Not a block start? */
@@ -613,6 +665,23 @@
 		if (ckfn && (err = ckfn(block)) != 0)
 			goto unlock_and_fail;
 
+		/*
+		 * Return the page to the free list if we've just
+		 * freed its last busy block. Pages from multi-page
+		 * blocks are always pushed to the free list (bcount
+		 * value for the heading page is always 1).
+		 */
+
+		if (unlikely(--extent->pagemap[pagenum].bcount == 0)) {
+			heap->buckets[log2size - XNHEAP_MINLOG2] = NULL;
+			npages = bsize >> heap->pageshift;
+			if (likely(npages <= 1)) {
+				tailpage = block;
+				goto free_pages;
+			}
+			goto free_page_list;
+		}
+
 		/* Return the block to the bucketed memory space. */
 
 		*((caddr_t *) block) = heap->buckets[log2size - XNHEAP_MINLOG2];
@@ -790,7 +859,6 @@
 	for (holder = getheadq(&heap->extents);
 	     holder != NULL; holder = nextq(&heap->extents, holder)) {
 		extent = link2extent(holder);
-
 		if ((caddr_t) block >= extent->membase &&
 		    (caddr_t) block < extent->memlim)
 			break;
@@ -804,11 +872,11 @@
 	boffset =
 	    ((caddr_t) block -
 	     (extent->membase + (pagenum << heap->pageshift)));
-	ptype = extent->pagemap[pagenum];
+	ptype = extent->pagemap[pagenum].type;
 
 	if (ptype == XNHEAP_PFREE ||	/* Unallocated page? */
 	    ptype == XNHEAP_PCONT)	/* Not a range heading page? */
-	      bad_block:
+  bad_block: 
 		err = -EINVAL;
 
 	xnlock_put_irqrestore(&heap->lock, s);

--------------020204000905090408050808--

