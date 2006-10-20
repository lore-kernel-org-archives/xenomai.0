Message-ID: <453911D7.5050003@domain.hid>
Date: Fri, 20 Oct 2006 20:13:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010702010306020100050708"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 1/2] Break up nucleus heap
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, Miguel Angel Masmano Tello <mimastel@domain.hid>

This is a multi-part message in MIME format.
--------------010702010306020100050708
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

By splitting up the nucleus heap layer in generic part and an allocator
implementation, this patch allows to install different heap allocation
schemes. For now the patch only moves the BSD-specific parts into
separate files and pushes BSD-specific fields in xnheap_t into a private
sub-block. Also a "Heap allocator" config option is added, but it only
offers BSD.

Todo: Comments in ksrc/nucleus/heap.c need to be updated or moved to
bsdalloc.c.

--------------010702010306020100050708
Content-Type: text/plain;
 name="alloc-framework-v4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alloc-framework-v4.patch"

---
 include/nucleus/bsdalloc.h |   58 +++++
 include/nucleus/heap.h     |   37 +--
 ksrc/nucleus/Config.in     |   10 
 ksrc/nucleus/Kconfig       |    9 
 ksrc/nucleus/Makefile      |    3 
 ksrc/nucleus/bsdalloc.c    |  485 +++++++++++++++++++++++++++++++++++++++++++++
 ksrc/nucleus/heap.c        |  474 -------------------------------------------
 7 files changed, 575 insertions(+), 501 deletions(-)

Index: include/nucleus/heap.h
===================================================================
--- include/nucleus/heap.h.orig
+++ include/nucleus/heap.h
@@ -20,8 +20,6 @@
 #ifndef _XENO_NUCLEUS_HEAP_H
 #define _XENO_NUCLEUS_HEAP_H
 
-#include <nucleus/queue.h>
-
 /*
  * CONSTRAINTS:
  *
@@ -44,16 +42,11 @@
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
-#define XNHEAP_MINLOG2    3
-#define XNHEAP_MAXLOG2    22
-#define XNHEAP_MINALLOCSZ (1 << XNHEAP_MINLOG2)
-#define XNHEAP_MINALIGNSZ (1 << 4) /* i.e. 16 bytes */
-#define XNHEAP_NBUCKETS   (XNHEAP_MAXLOG2 - XNHEAP_MINLOG2 + 2)
-#define XNHEAP_MAXEXTSZ   (1 << 31) /* i.e. 2Gb */
-
-#define XNHEAP_PFREE   0
-#define XNHEAP_PCONT   1
-#define XNHEAP_PLIST   2
+#include <nucleus/queue.h>
+
+#if defined(CONFIG_XENO_OPT_ALLOC_BSD)
+#include <nucleus/bsdalloc.h>
+#endif /* allocator selection */
 
 typedef struct xnextent {
 
@@ -63,10 +56,9 @@ typedef struct xnextent {
 ((xnextent_t *)(((char *)laddr) - (int)(&((xnextent_t *)0)->link)))
 
     caddr_t membase,	/* Base address of the page array */
-	    memlim,	/* Memory limit of page array */
-	    freelist;	/* Head of the free page list */
+	    memlim;	/* Memory limit of page array */
 
-    u_char pagemap[1];	/* Beginning of page map */
+    xnextend_priv_t priv;
 
 } xnextent_t;
 
@@ -78,12 +70,10 @@ typedef struct xnheap {
 ((xnheap_t *)(((char *)laddr) - (int)(&((xnheap_t *)0)->link)))
 
     u_long extentsize,
-           pagesize,
-           pageshift,
+	   pagesize,
 	   hdrsize,
-	   npages,	/* Number of pages per extent */
 	   ubytes,
-           maxcont;
+	   maxcont;
 
     xnqueue_t extents;
 
@@ -91,7 +81,7 @@ typedef struct xnheap {
     xnlock_t lock;
 #endif /* CONFIG_SMP */
 
-    caddr_t buckets[XNHEAP_NBUCKETS];
+    xnheap_priv_t priv;
 
     xnholder_t *idleq;
 
@@ -105,14 +95,9 @@ extern xnheap_t kheap;
 
 #define xnheap_size(heap)            ((heap)->extentsize)
 #define xnheap_page_size(heap)       ((heap)->pagesize)
-#define xnheap_page_count(heap)      ((heap)->npages)
 #define xnheap_used_mem(heap)        ((heap)->ubytes)
 #define xnheap_max_contiguous(heap)  ((heap)->maxcont)
-#define xnheap_overhead(hsize,psize) \
-((sizeof(xnextent_t) + (((hsize) - sizeof(xnextent_t)) / (psize)) + \
- XNHEAP_MINALIGNSZ - 1) & ~(XNHEAP_MINALIGNSZ - 1))
-/* The alignment value must be a power of 2 */
-#define xnheap_align(size,al)		(((size)+(al)-1)&(~((al)-1)))
+#define xnheap_align(size,al)        (((size)+(al)-1)&(~((al)-1)))
 
 #define xnmalloc(size)     xnheap_alloc(&kheap,size)
 #define xnfree(ptr)        xnheap_free(&kheap,ptr)
Index: include/nucleus/bsdalloc.h
===================================================================
--- /dev/null
+++ include/nucleus/bsdalloc.h
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2001,2002,2003 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License,
+ * or (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+
+#ifndef _XENO_NUCLEUS_BSDALLOC_H
+#define _XENO_NUCLEUS_BSDALLOC_H
+
+#define XNHEAP_MINLOG2    3
+#define XNHEAP_MAXLOG2    22
+#define XNHEAP_MINALLOCSZ (1 << XNHEAP_MINLOG2)
+#define XNHEAP_MINALIGNSZ (1 << 4) /* i.e. 16 bytes */
+#define XNHEAP_NBUCKETS   (XNHEAP_MAXLOG2 - XNHEAP_MINLOG2 + 2)
+#define XNHEAP_MAXEXTSZ   (1 << 31) /* i.e. 2Gb */
+
+#define XNHEAP_PFREE   0
+#define XNHEAP_PCONT   1
+#define XNHEAP_PLIST   2
+
+#define xnheap_page_count(heap)      ((heap)->priv.npages)
+
+#define xnheap_overhead(hsize,psize) \
+((sizeof(xnextent_t) + (((hsize) - sizeof(xnextent_t)) / (psize)) + \
+ XNHEAP_MINALIGNSZ - 1) & ~(XNHEAP_MINALIGNSZ - 1))
+/* The alignment value must be a power of 2 */
+
+typedef struct xnextend_priv {
+
+    caddr_t freelist;	/* Head of the free page list */
+
+    u_char pagemap[1];	/* Beginning of page map */
+
+} xnextend_priv_t;
+
+typedef struct xnheap_priv {
+
+    u_long npages,	/* Number of pages per extent */
+           pageshift;
+
+    caddr_t buckets[XNHEAP_NBUCKETS];
+
+} xnheap_priv_t;
+
+#endif /* !_XENO_NUCLEUS_BSDALLOC_H */
Index: ksrc/nucleus/Kconfig
===================================================================
--- ksrc/nucleus/Kconfig.orig
+++ ksrc/nucleus/Kconfig
@@ -127,6 +127,15 @@ config XENO_OPT_REGISTRY_NRSLOTS
 	registry can handle. All skins using the registry share this
 	storage.
 
+choice
+	prompt "Heap allocator"
+	default XENO_OPT_ALLOC_BSD
+
+config XENO_OPT_ALLOC_BSD
+	bool "BSD"
+
+endchoice
+
 config XENO_OPT_SYS_HEAPSZ
 	int "Size of the system heap (Kb)"
 	default 128
Index: ksrc/nucleus/heap.c
===================================================================
--- ksrc/nucleus/heap.c.orig
+++ ksrc/nucleus/heap.c
@@ -66,39 +66,9 @@ HEAP {
 #include <nucleus/pod.h>
 #include <nucleus/thread.h>
 #include <nucleus/heap.h>
-#include <asm/xenomai/bits/heap.h>
 
 xnheap_t kheap;			/* System heap */
 
-static void init_extent(xnheap_t *heap, xnextent_t *extent)
-{
-	caddr_t freepage;
-	int n, lastpgnum;
-
-	inith(&extent->link);
-
-	/* The page area starts right after the (aligned) header. */
-	extent->membase = (caddr_t) extent + heap->hdrsize;
-	lastpgnum = heap->npages - 1;
-
-	/* Mark each page as free in the page map. */
-	for (n = 0, freepage = extent->membase;
-	     n < lastpgnum; n++, freepage += heap->pagesize) {
-		*((caddr_t *) freepage) = freepage + heap->pagesize;
-		extent->pagemap[n] = XNHEAP_PFREE;
-	}
-
-	*((caddr_t *) freepage) = NULL;
-	extent->pagemap[lastpgnum] = XNHEAP_PFREE;
-	extent->memlim = freepage + heap->pagesize;
-
-	/* The first page starts the free list of a new extent. */
-	extent->freelist = extent->membase;
-}
-
-/*
- */
-
 /*!
  * \fn xnheap_init(xnheap_t *heap,void *heapaddr,u_long heapsize,u_long pagesize)
  * \brief Initialize a memory heap.
@@ -148,79 +118,6 @@ static void init_extent(xnheap_t *heap, 
  * Rescheduling: never.
  */
 
-int xnheap_init(xnheap_t *heap,
-		void *heapaddr, u_long heapsize, u_long pagesize)
-{
-	u_long hdrsize, shiftsize, pageshift;
-	xnextent_t *extent;
-	int n;
-
-	/*
-	 * Perform some parametrical checks first.
-	 * Constraints are:
-	 * PAGESIZE must be >= 2 ** MINLOG2.
-	 * PAGESIZE must be <= 2 ** MAXLOG2.
-	 * PAGESIZE must be a power of 2.
-	 * HEAPSIZE must be large enough to contain the static part of an
-	 * extent header.
-	 * HEAPSIZE must be a multiple of PAGESIZE.
-	 * HEAPSIZE must be lower than XNHEAP_MAXEXTSZ.
-	 */
-
-	if ((pagesize < (1 << XNHEAP_MINLOG2)) ||
-	    (pagesize > (1 << XNHEAP_MAXLOG2)) ||
-	    (pagesize & (pagesize - 1)) != 0 ||
-	    heapsize <= sizeof(xnextent_t) ||
-	    heapsize > XNHEAP_MAXEXTSZ || (heapsize & (pagesize - 1)) != 0)
-		return -EINVAL;
-
-	/* Determine the page map overhead inside the given extent
-	   size. We need to reserve a byte in a page map for each page
-	   which is addressable into this extent. The page map is itself
-	   stored in the extent space, right after the static part of its
-	   header, and before the first allocatable page.
-	   pmapsize = (heapsize - sizeof(xnextent_t)) / pagesize; */
-
-	/* The overall header size is: static_part + page_map rounded to
-	   the minimum alignment size. */
-	hdrsize = xnheap_overhead(heapsize, pagesize);
-
-	/* An extent must contain at least two addressable pages to cope
-	   with allocation sizes between pagesize and 2 * pagesize. */
-	if (hdrsize + 2 * pagesize > heapsize)
-		return -EINVAL;
-
-	/* Compute the page shiftmask from the page size (i.e. log2 value). */
-	for (pageshift = 0, shiftsize = pagesize; shiftsize > 1; shiftsize >>= 1, pageshift++) ;	/* Loop */
-
-	heap->pagesize = pagesize;
-	heap->pageshift = pageshift;
-	heap->extentsize = heapsize;
-	heap->hdrsize = hdrsize;
-	heap->npages = (heapsize - hdrsize) >> pageshift;
-	heap->ubytes = 0;
-	heap->maxcont = heap->npages * pagesize;
-	heap->idleq = NULL;
-	inith(&heap->link);
-	initq(&heap->extents);
-	xnlock_init(&heap->lock);
-
-	xnarch_init_heapcb(&heap->archdep);
-
-	for (n = 0; n < XNHEAP_NBUCKETS; n++)
-		heap->buckets[n] = NULL;
-
-	extent = (xnextent_t *)heapaddr;
-
-	init_extent(heap, extent);
-
-	appendq(&heap->extents, &extent->link);
-
-	xnarch_init_display_context(heap);
-
-	return 0;
-}
-
 /*! 
  * \fn void xnheap_destroy(xnheap_t *heap, void (*flushfn)(xnheap_t *heap, void *extaddr, u_long extsize, void *cookie), void *cookie)
  * \brief Destroys a memory heap.
@@ -250,127 +147,7 @@ int xnheap_init(xnheap_t *heap,
  * Rescheduling: never.
  */
 
-int xnheap_destroy(xnheap_t *heap,
-		   void (*flushfn) (xnheap_t *heap,
-				    void *extaddr,
-				    u_long extsize, void *cookie), void *cookie)
-{
-	xnholder_t *holder;
-	spl_t s;
-
-	if (!flushfn)
-		return 0;
-
-	xnlock_get_irqsave(&heap->lock, s);
-
-	while ((holder = getq(&heap->extents)) != NULL) {
-		xnlock_put_irqrestore(&heap->lock, s);
-		flushfn(heap, link2extent(holder), heap->extentsize, cookie);
-		xnlock_get_irqsave(&heap->lock, s);
-	}
-
-	xnlock_put_irqrestore(&heap->lock, s);
-
-	return 0;
-}
-
-/*
- * get_free_range() -- Obtain a range of contiguous free pages to
- * fulfill an allocation of 2 ** log2size.  The caller must have
- * acquired the heap lock.
- */
-
-static caddr_t get_free_range(xnheap_t *heap, u_long bsize, int log2size)
-{
-	caddr_t block, eblock, freepage, lastpage, headpage, freehead = NULL;
-	u_long pagenum, pagecont, freecont;
-	xnholder_t *holder;
-	xnextent_t *extent;
-
-	holder = getheadq(&heap->extents);
-
-	while (holder != NULL) {
-		extent = link2extent(holder);
-
-		freepage = extent->freelist;
-
-		while (freepage != NULL) {
-			headpage = freepage;
-			freecont = 0;
-
-			/* Search for a range of contiguous pages in the free page
-			   list of the current extent. The range must be 'bsize'
-			   long. */
-			do {
-				lastpage = freepage;
-				freepage = *((caddr_t *) freepage);
-				freecont += heap->pagesize;
-			}
-			while (freepage == lastpage + heap->pagesize
-			       && freecont < bsize);
-
-			if (freecont >= bsize) {
-				/* Ok, got it. Just update the extent's free page
-				   list, then proceed to the next step. */
-
-				if (headpage == extent->freelist)
-					extent->freelist =
-					    *((caddr_t *) lastpage);
-				else
-					*((caddr_t *) freehead) =
-					    *((caddr_t *) lastpage);
-
-				goto splitpage;
-			}
-
-			freehead = lastpage;
-		}
-
-		holder = nextq(&heap->extents, holder);
-	}
-
-	return NULL;
-
-      splitpage:
-
-	/* At this point, headpage is valid and points to the first page
-	   of a range of contiguous free pages larger or equal than
-	   'bsize'. */
-
-	if (bsize < heap->pagesize) {
-		/* If the allocation size is smaller than the standard page
-		   size, split the page in smaller blocks of this size,
-		   building a free list of free blocks. */
-
-		for (block = headpage, eblock =
-		     headpage + heap->pagesize - bsize; block < eblock;
-		     block += bsize)
-			*((caddr_t *) block) = block + bsize;
-
-		*((caddr_t *) eblock) = NULL;
-	} else
-		*((caddr_t *) headpage) = NULL;
-
-	pagenum = (headpage - extent->membase) >> heap->pageshift;
-
-	/* Update the extent's page map.  If log2size is non-zero
-	   (i.e. bsize <= 2 * pagesize), store it in the first page's slot
-	   to record the exact block size (which is a power of
-	   two). Otherwise, store the special marker XNHEAP_PLIST,
-	   indicating the start of a block whose size is a multiple of the
-	   standard page size, but not necessarily a power of two.  In any
-	   case, the following pages slots are marked as 'continued'
-	   (PCONT). */
-
-	extent->pagemap[pagenum] = log2size ? : XNHEAP_PLIST;
-
-	for (pagecont = bsize >> heap->pageshift; pagecont > 1; pagecont--)
-		extent->pagemap[pagenum + pagecont - 1] = XNHEAP_PCONT;
-
-	return headpage;
-}
-
-/*! 
+/*!
  * \fn void *xnheap_alloc(xnheap_t *heap, u_long size)
  * \brief Allocate a memory block from a memory heap.
  *
@@ -402,82 +179,7 @@ static caddr_t get_free_range(xnheap_t *
  * Rescheduling: never.
  */
 
-void *xnheap_alloc(xnheap_t *heap, u_long size)
-{
-	caddr_t block;
-	u_long bsize;
-	int log2size;
-	spl_t s;
-
-	if (size == 0)
-		return NULL;
-
-	if (size <= heap->pagesize)
-		/* Sizes lower or equal to the page size are rounded either to
-		   the minimum allocation size if lower than this value, or to
-		   the minimum alignment size if greater or equal to this
-		   value. In other words, with MINALLOC = 8 and MINALIGN = 16,
-		   a 7 bytes request will be rounded to 8 bytes, and a 17
-		   bytes request will be rounded to 32. */
-	{
-		if (size <= XNHEAP_MINALIGNSZ)
-			size =
-			    (size + XNHEAP_MINALLOCSZ -
-			     1) & ~(XNHEAP_MINALLOCSZ - 1);
-		else
-			size =
-			    (size + XNHEAP_MINALIGNSZ -
-			     1) & ~(XNHEAP_MINALIGNSZ - 1);
-	} else
-		/* Sizes greater than the page size are rounded to a multiple
-		   of the page size. */
-		size = (size + heap->pagesize - 1) & ~(heap->pagesize - 1);
-
-	/* It becomes more space efficient to directly allocate pages from
-	   the free page list whenever the requested size is greater than
-	   2 times the page size. Otherwise, use the bucketed memory
-	   blocks. */
-
-	if (size <= heap->pagesize * 2) {
-		/* Find the first power of two greater or equal to the rounded
-		   size. The log2 value of this size is also computed. */
-
-		for (bsize = (1 << XNHEAP_MINLOG2), log2size = XNHEAP_MINLOG2; bsize < size; bsize <<= 1, log2size++) ;	/* Loop */
-
-		xnlock_get_irqsave(&heap->lock, s);
-
-		block = heap->buckets[log2size - XNHEAP_MINLOG2];
-
-		if (block == NULL) {
-			block = get_free_range(heap, bsize, log2size);
-
-			if (block == NULL)
-				goto release_and_exit;
-		}
-
-		heap->buckets[log2size - XNHEAP_MINLOG2] = *((caddr_t *) block);
-		heap->ubytes += bsize;
-	} else {
-		if (size > heap->maxcont)
-			return NULL;
-
-		xnlock_get_irqsave(&heap->lock, s);
-
-		/* Directly request a free page range. */
-		block = get_free_range(heap, size, 0);
-
-		if (block)
-			heap->ubytes += size;
-	}
-
-      release_and_exit:
-
-	xnlock_put_irqrestore(&heap->lock, s);
-
-	return block;
-}
-
-/*! 
+/*!
  * \fn int xnheap_test_and_free(xnheap_t *heap,void *block,int (*ckfn)(void *block))
  * \brief Test and release a memory block to a memory heap.
  *
@@ -517,116 +219,7 @@ void *xnheap_alloc(xnheap_t *heap, u_lon
  * Rescheduling: never.
  */
 
-int xnheap_test_and_free(xnheap_t *heap, void *block, int (*ckfn) (void *block))
-{
-	caddr_t freepage, lastpage, nextpage, tailpage;
-	u_long pagenum, pagecont, boffset, bsize;
-	xnextent_t *extent = NULL;
-	int log2size, npages, err;
-	xnholder_t *holder;
-	spl_t s;
-
-	xnlock_get_irqsave(&heap->lock, s);
-
-	/* Find the extent from which the returned block is
-	   originating. */
-
-	for (holder = getheadq(&heap->extents);
-	     holder != NULL; holder = nextq(&heap->extents, holder)) {
-		extent = link2extent(holder);
-
-		if ((caddr_t) block >= extent->membase &&
-		    (caddr_t) block < extent->memlim)
-			break;
-	}
-
-	if (!holder)
-		goto bad_block;
-
-	/* Compute the heading page number in the page map. */
-	pagenum = ((caddr_t) block - extent->membase) >> heap->pageshift;
-	boffset =
-	    ((caddr_t) block -
-	     (extent->membase + (pagenum << heap->pageshift)));
-
-	switch (extent->pagemap[pagenum]) {
-	case XNHEAP_PFREE:	/* Unallocated page? */
-	case XNHEAP_PCONT:	/* Not a range heading page? */
-
-	      bad_block:
-		err = -EINVAL;
-
-	      unlock_and_fail:
-
-		xnlock_put_irqrestore(&heap->lock, s);
-		return err;
-
-	case XNHEAP_PLIST:
-
-		if (ckfn && (err = ckfn(block)) != 0)
-			goto unlock_and_fail;
-
-		npages = 1;
-
-		while (npages < heap->npages &&
-		       extent->pagemap[pagenum + npages] == XNHEAP_PCONT)
-			npages++;
-
-		bsize = npages * heap->pagesize;
-
-		/* Link all freed pages in a single sub-list. */
-
-		for (freepage = (caddr_t) block,
-		     tailpage = (caddr_t) block + bsize - heap->pagesize;
-		     freepage < tailpage; freepage += heap->pagesize)
-			*((caddr_t *) freepage) = freepage + heap->pagesize;
-
-		/* Mark the released pages as free in the extent's page map. */
-
-		for (pagecont = 0; pagecont < npages; pagecont++)
-			extent->pagemap[pagenum + pagecont] = XNHEAP_PFREE;
-
-		/* Return the sub-list to the free page list, keeping
-		   an increasing address order to favor coalescence. */
-
-		for (nextpage = extent->freelist, lastpage = NULL; nextpage != NULL && nextpage < (caddr_t) block; lastpage = nextpage, nextpage = *((caddr_t *) nextpage)) ;	/* Loop */
-
-		*((caddr_t *) tailpage) = nextpage;
-
-		if (lastpage)
-			*((caddr_t *) lastpage) = (caddr_t) block;
-		else
-			extent->freelist = (caddr_t) block;
-
-		break;
-
-	default:
-
-		log2size = extent->pagemap[pagenum];
-		bsize = (1 << log2size);
-
-		if ((boffset & (bsize - 1)) != 0)	/* Not a block start? */
-			goto bad_block;
-
-		if (ckfn && (err = ckfn(block)) != 0)
-			goto unlock_and_fail;
-
-		/* Return the block to the bucketed memory space. */
-
-		*((caddr_t *) block) = heap->buckets[log2size - XNHEAP_MINLOG2];
-		heap->buckets[log2size - XNHEAP_MINLOG2] = block;
-
-		break;
-	}
-
-	heap->ubytes -= bsize;
-
-	xnlock_put_irqrestore(&heap->lock, s);
-
-	return 0;
-}
-
-/*! 
+/*!
  * \fn int xnheap_free(xnheap_t *heap, void *block)
  * \brief Release a memory block to a memory heap.
  *
@@ -687,25 +280,6 @@ int xnheap_free(xnheap_t *heap, void *bl
  * Rescheduling: never.
  */
 
-int xnheap_extend(xnheap_t *heap, void *extaddr, u_long extsize)
-{
-	xnextent_t *extent = (xnextent_t *)extaddr;
-	spl_t s;
-
-	if (extsize != heap->extentsize)
-		return -EINVAL;
-
-	init_extent(heap, extent);
-
-	xnlock_get_irqsave(&heap->lock, s);
-
-	appendq(&heap->extents, &extent->link);
-
-	xnlock_put_irqrestore(&heap->lock, s);
-
-	return 0;
-}
-
 /*! 
  * \fn int xnheap_schedule_free(xnheap_t *heap, void *block, xnholder_t *link)
  * \brief Schedule a memory block for release.
@@ -769,48 +343,6 @@ void xnheap_finalize_free_inner(xnheap_t
 	xnlock_put_irqrestore(&heap->lock, s);
 }
 
-int xnheap_check_block(xnheap_t *heap, void *block)
-{
-	xnextent_t *extent = NULL;
-	u_long pagenum, boffset;
-	xnholder_t *holder;
-	int ptype, err = 0;
-	spl_t s;
-
-	xnlock_get_irqsave(&heap->lock, s);
-
-	/* Find the extent from which the checked block is
-	   originating. */
-
-	for (holder = getheadq(&heap->extents);
-	     holder != NULL; holder = nextq(&heap->extents, holder)) {
-		extent = link2extent(holder);
-
-		if ((caddr_t) block >= extent->membase &&
-		    (caddr_t) block < extent->memlim)
-			break;
-	}
-
-	if (!holder)
-		goto bad_block;
-
-	/* Compute the heading page number in the page map. */
-	pagenum = ((caddr_t) block - extent->membase) >> heap->pageshift;
-	boffset =
-	    ((caddr_t) block -
-	     (extent->membase + (pagenum << heap->pageshift)));
-	ptype = extent->pagemap[pagenum];
-
-	if (ptype == XNHEAP_PFREE ||	/* Unallocated page? */
-	    ptype == XNHEAP_PCONT)	/* Not a range heading page? */
-	      bad_block:
-		err = -EINVAL;
-
-	xnlock_put_irqrestore(&heap->lock, s);
-
-	return err;
-}
-
 #if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
 
 #include <asm/io.h>
Index: ksrc/nucleus/bsdalloc.c
===================================================================
--- /dev/null
+++ ksrc/nucleus/bsdalloc.c
@@ -0,0 +1,485 @@
+/*
+ * Copyright (C) 2001,2002,2003 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License,
+ * or (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+
+#include <nucleus/heap.h>
+#include <asm/xenomai/bits/heap.h>
+
+static void init_extent(xnheap_t *heap, xnextent_t *extent)
+{
+	caddr_t freepage;
+	int n, lastpgnum;
+
+	inith(&extent->link);
+
+	/* The page area starts right after the (aligned) header. */
+	extent->membase = (caddr_t) extent + heap->hdrsize;
+	lastpgnum = xnheap_page_count(heap) - 1;
+
+	/* Mark each page as free in the page map. */
+	for (n = 0, freepage = extent->membase;
+	     n < lastpgnum; n++, freepage += heap->pagesize) {
+		*((caddr_t *) freepage) = freepage + heap->pagesize;
+		extent->priv.pagemap[n] = XNHEAP_PFREE;
+	}
+
+	*((caddr_t *) freepage) = NULL;
+	extent->priv.pagemap[lastpgnum] = XNHEAP_PFREE;
+	extent->memlim = freepage + heap->pagesize;
+
+	/* The first page starts the free list of a new extent. */
+	extent->priv.freelist = extent->membase;
+}
+
+int xnheap_init(xnheap_t *heap,
+		void *heapaddr, u_long heapsize, u_long pagesize)
+{
+	u_long hdrsize, shiftsize, pageshift;
+	xnextent_t *extent;
+	int n;
+
+	/*
+	 * Perform some parametrical checks first.
+	 * Constraints are:
+	 * PAGESIZE must be >= 2 ** MINLOG2.
+	 * PAGESIZE must be <= 2 ** MAXLOG2.
+	 * PAGESIZE must be a power of 2.
+	 * HEAPSIZE must be large enough to contain the static part of an
+	 * extent header.
+	 * HEAPSIZE must be a multiple of PAGESIZE.
+	 * HEAPSIZE must be lower than XNHEAP_MAXEXTSZ.
+	 */
+
+	if ((pagesize < (1 << XNHEAP_MINLOG2)) ||
+	    (pagesize > (1 << XNHEAP_MAXLOG2)) ||
+	    (pagesize & (pagesize - 1)) != 0 ||
+	    heapsize <= sizeof(xnextent_t) ||
+	    heapsize > XNHEAP_MAXEXTSZ || (heapsize & (pagesize - 1)) != 0)
+		return -EINVAL;
+
+	/* Determine the page map overhead inside the given extent
+	   size. We need to reserve a byte in a page map for each page
+	   which is addressable into this extent. The page map is itself
+	   stored in the extent space, right after the static part of its
+	   header, and before the first allocatable page.
+	   pmapsize = (heapsize - sizeof(xnextent_t)) / pagesize; */
+
+	/* The overall header size is: static_part + page_map rounded to
+	   the minimum alignment size. */
+	hdrsize = xnheap_overhead(heapsize, pagesize);
+
+	/* An extent must contain at least two addressable pages to cope
+	   with allocation sizes between pagesize and 2 * pagesize. */
+	if (hdrsize + 2 * pagesize > heapsize)
+		return -EINVAL;
+
+	/* Compute the page shiftmask from the page size (i.e. log2 value). */
+	for (pageshift = 0, shiftsize = pagesize; shiftsize > 1; shiftsize >>= 1, pageshift++) ;	/* Loop */
+
+	heap->pagesize = pagesize;
+	heap->priv.pageshift = pageshift;
+	heap->extentsize = heapsize;
+	heap->hdrsize = hdrsize;
+	heap->priv.npages = (heapsize - hdrsize) >> pageshift;
+	heap->ubytes = 0;
+	heap->maxcont = xnheap_page_count(heap) * pagesize;
+	heap->idleq = NULL;
+	inith(&heap->link);
+	initq(&heap->extents);
+	xnlock_init(&heap->lock);
+
+	xnarch_init_heapcb(&heap->archdep);
+
+	for (n = 0; n < XNHEAP_NBUCKETS; n++)
+		heap->priv.buckets[n] = NULL;
+
+	extent = (xnextent_t *)heapaddr;
+
+	init_extent(heap, extent);
+
+	appendq(&heap->extents, &extent->link);
+
+	xnarch_init_display_context(heap);
+
+	return 0;
+}
+
+int xnheap_destroy(xnheap_t *heap,
+		   void (*flushfn) (xnheap_t *heap,
+				    void *extaddr,
+				    u_long extsize, void *cookie), void *cookie)
+{
+	xnholder_t *holder;
+	spl_t s;
+
+	if (!flushfn)
+		return 0;
+
+	xnlock_get_irqsave(&heap->lock, s);
+
+	while ((holder = getq(&heap->extents)) != NULL) {
+		xnlock_put_irqrestore(&heap->lock, s);
+		flushfn(heap, link2extent(holder), heap->extentsize, cookie);
+		xnlock_get_irqsave(&heap->lock, s);
+	}
+
+	xnlock_put_irqrestore(&heap->lock, s);
+
+	return 0;
+}
+
+/*
+ * get_free_range() -- Obtain a range of contiguous free pages to
+ * fulfill an allocation of 2 ** log2size.  The caller must have
+ * acquired the heap lock.
+ */
+
+static caddr_t get_free_range(xnheap_t *heap, u_long bsize, int log2size)
+{
+	caddr_t block, eblock, freepage, lastpage, headpage, freehead = NULL;
+	u_long pagenum, pagecont, freecont;
+	xnholder_t *holder;
+	xnextent_t *extent;
+
+	holder = getheadq(&heap->extents);
+
+	while (holder != NULL) {
+		extent = link2extent(holder);
+
+		freepage = extent->priv.freelist;
+
+		while (freepage != NULL) {
+			headpage = freepage;
+			freecont = 0;
+
+			/* Search for a range of contiguous pages in the free page
+			   list of the current extent. The range must be 'bsize'
+			   long. */
+			do {
+				lastpage = freepage;
+				freepage = *((caddr_t *) freepage);
+				freecont += heap->pagesize;
+			}
+			while (freepage == lastpage + heap->pagesize
+			       && freecont < bsize);
+
+			if (freecont >= bsize) {
+				/* Ok, got it. Just update the extent's free page
+				   list, then proceed to the next step. */
+
+				if (headpage == extent->priv.freelist)
+					extent->priv.freelist =
+					    *((caddr_t *) lastpage);
+				else
+					*((caddr_t *) freehead) =
+					    *((caddr_t *) lastpage);
+
+				goto splitpage;
+			}
+
+			freehead = lastpage;
+		}
+
+		holder = nextq(&heap->extents, holder);
+	}
+
+	return NULL;
+
+      splitpage:
+
+	/* At this point, headpage is valid and points to the first page
+	   of a range of contiguous free pages larger or equal than
+	   'bsize'. */
+
+	if (bsize < heap->pagesize) {
+		/* If the allocation size is smaller than the standard page
+		   size, split the page in smaller blocks of this size,
+		   building a free list of free blocks. */
+
+		for (block = headpage, eblock =
+		     headpage + heap->pagesize - bsize; block < eblock;
+		     block += bsize)
+			*((caddr_t *) block) = block + bsize;
+
+		*((caddr_t *) eblock) = NULL;
+	} else
+		*((caddr_t *) headpage) = NULL;
+
+	pagenum = (headpage - extent->membase) >> heap->priv.pageshift;
+
+	/* Update the extent's page map.  If log2size is non-zero
+	   (i.e. bsize <= 2 * pagesize), store it in the first page's slot
+	   to record the exact block size (which is a power of
+	   two). Otherwise, store the special marker XNHEAP_PLIST,
+	   indicating the start of a block whose size is a multiple of the
+	   standard page size, but not necessarily a power of two.  In any
+	   case, the following pages slots are marked as 'continued'
+	   (PCONT). */
+
+	extent->priv.pagemap[pagenum] = log2size ? : XNHEAP_PLIST;
+
+	for (pagecont = bsize >> heap->priv.pageshift; pagecont > 1; pagecont--)
+		extent->priv.pagemap[pagenum + pagecont - 1] = XNHEAP_PCONT;
+
+	return headpage;
+}
+
+void *xnheap_alloc(xnheap_t *heap, u_long size)
+{
+	caddr_t block;
+	u_long bsize;
+	int log2size;
+	spl_t s;
+
+	if (size == 0)
+		return NULL;
+
+	if (size <= heap->pagesize)
+		/* Sizes lower or equal to the page size are rounded either to
+		   the minimum allocation size if lower than this value, or to
+		   the minimum alignment size if greater or equal to this
+		   value. In other words, with MINALLOC = 8 and MINALIGN = 16,
+		   a 7 bytes request will be rounded to 8 bytes, and a 17
+		   bytes request will be rounded to 32. */
+	{
+		if (size <= XNHEAP_MINALIGNSZ)
+			size =
+			    (size + XNHEAP_MINALLOCSZ -
+			     1) & ~(XNHEAP_MINALLOCSZ - 1);
+		else
+			size =
+			    (size + XNHEAP_MINALIGNSZ -
+			     1) & ~(XNHEAP_MINALIGNSZ - 1);
+	} else
+		/* Sizes greater than the page size are rounded to a multiple
+		   of the page size. */
+		size = (size + heap->pagesize - 1) & ~(heap->pagesize - 1);
+
+	/* It becomes more space efficient to directly allocate pages from
+	   the free page list whenever the requested size is greater than
+	   2 times the page size. Otherwise, use the bucketed memory
+	   blocks. */
+
+	if (size <= heap->pagesize * 2) {
+		/* Find the first power of two greater or equal to the rounded
+		   size. The log2 value of this size is also computed. */
+
+		for (bsize = (1 << XNHEAP_MINLOG2), log2size = XNHEAP_MINLOG2; bsize < size; bsize <<= 1, log2size++) ;	/* Loop */
+
+		xnlock_get_irqsave(&heap->lock, s);
+
+		block = heap->priv.buckets[log2size - XNHEAP_MINLOG2];
+
+		if (block == NULL) {
+			block = get_free_range(heap, bsize, log2size);
+
+			if (block == NULL)
+				goto release_and_exit;
+		}
+
+		heap->priv.buckets[log2size - XNHEAP_MINLOG2] = *((caddr_t *) block);
+		heap->ubytes += bsize;
+	} else {
+		if (size > xnheap_max_contiguous(heap))
+			return NULL;
+
+		xnlock_get_irqsave(&heap->lock, s);
+
+		/* Directly request a free page range. */
+		block = get_free_range(heap, size, 0);
+
+		if (block)
+			heap->ubytes += size;
+	}
+
+      release_and_exit:
+
+	xnlock_put_irqrestore(&heap->lock, s);
+
+	return block;
+}
+
+int xnheap_test_and_free(xnheap_t *heap, void *block, int (*ckfn) (void *block))
+{
+	caddr_t freepage, lastpage, nextpage, tailpage;
+	u_long pagenum, pagecont, boffset, bsize;
+	xnextent_t *extent = NULL;
+	int log2size, npages, err;
+	xnholder_t *holder;
+	spl_t s;
+
+	xnlock_get_irqsave(&heap->lock, s);
+
+	/* Find the extent from which the returned block is
+	   originating. */
+
+	for (holder = getheadq(&heap->extents);
+	     holder != NULL; holder = nextq(&heap->extents, holder)) {
+		extent = link2extent(holder);
+
+		if ((caddr_t) block >= extent->membase &&
+		    (caddr_t) block < extent->memlim)
+			break;
+	}
+
+	if (!holder)
+		goto bad_block;
+
+	/* Compute the heading page number in the page map. */
+	pagenum = ((caddr_t) block - extent->membase) >> heap->priv.pageshift;
+	boffset =
+	    ((caddr_t) block -
+	     (extent->membase + (pagenum << heap->priv.pageshift)));
+
+	switch (extent->priv.pagemap[pagenum]) {
+	case XNHEAP_PFREE:	/* Unallocated page? */
+	case XNHEAP_PCONT:	/* Not a range heading page? */
+
+	      bad_block:
+		err = -EINVAL;
+
+	      unlock_and_fail:
+
+		xnlock_put_irqrestore(&heap->lock, s);
+		return err;
+
+	case XNHEAP_PLIST:
+
+		if (ckfn && (err = ckfn(block)) != 0)
+			goto unlock_and_fail;
+
+		npages = 1;
+
+		while (npages < xnheap_page_count(heap) &&
+		       extent->priv.pagemap[pagenum + npages] == XNHEAP_PCONT)
+			npages++;
+
+		bsize = npages * heap->pagesize;
+
+		/* Link all freed pages in a single sub-list. */
+
+		for (freepage = (caddr_t) block,
+		     tailpage = (caddr_t) block + bsize - heap->pagesize;
+		     freepage < tailpage; freepage += heap->pagesize)
+			*((caddr_t *) freepage) = freepage + heap->pagesize;
+
+		/* Mark the released pages as free in the extent's page map. */
+
+		for (pagecont = 0; pagecont < npages; pagecont++)
+			extent->priv.pagemap[pagenum + pagecont] = XNHEAP_PFREE;
+
+		/* Return the sub-list to the free page list, keeping
+		   an increasing address order to favor coalescence. */
+
+		for (nextpage = extent->priv.freelist, lastpage = NULL; nextpage != NULL && nextpage < (caddr_t) block; lastpage = nextpage, nextpage = *((caddr_t *) nextpage)) ;	/* Loop */
+
+		*((caddr_t *) tailpage) = nextpage;
+
+		if (lastpage)
+			*((caddr_t *) lastpage) = (caddr_t) block;
+		else
+			extent->priv.freelist = (caddr_t) block;
+
+		break;
+
+	default:
+
+		log2size = extent->priv.pagemap[pagenum];
+		bsize = (1 << log2size);
+
+		if ((boffset & (bsize - 1)) != 0)	/* Not a block start? */
+			goto bad_block;
+
+		if (ckfn && (err = ckfn(block)) != 0)
+			goto unlock_and_fail;
+
+		/* Return the block to the bucketed memory space. */
+
+		*((caddr_t *) block) = heap->priv.buckets[log2size - XNHEAP_MINLOG2];
+		heap->priv.buckets[log2size - XNHEAP_MINLOG2] = block;
+
+		break;
+	}
+
+	heap->ubytes -= bsize;
+
+	xnlock_put_irqrestore(&heap->lock, s);
+
+	return 0;
+}
+
+int xnheap_extend(xnheap_t *heap, void *extaddr, u_long extsize)
+{
+	xnextent_t *extent = (xnextent_t *)extaddr;
+	spl_t s;
+
+	if (extsize != heap->extentsize)
+		return -EINVAL;
+
+	init_extent(heap, extent);
+
+	xnlock_get_irqsave(&heap->lock, s);
+
+	appendq(&heap->extents, &extent->link);
+
+	xnlock_put_irqrestore(&heap->lock, s);
+
+	return 0;
+}
+
+int xnheap_check_block(xnheap_t *heap, void *block)
+{
+	xnextent_t *extent = NULL;
+	u_long pagenum, boffset;
+	xnholder_t *holder;
+	int ptype, err = 0;
+	spl_t s;
+
+	xnlock_get_irqsave(&heap->lock, s);
+
+	/* Find the extent from which the checked block is
+	   originating. */
+
+	for (holder = getheadq(&heap->extents);
+	     holder != NULL; holder = nextq(&heap->extents, holder)) {
+		extent = link2extent(holder);
+
+		if ((caddr_t) block >= extent->membase &&
+		    (caddr_t) block < extent->memlim)
+			break;
+	}
+
+	if (!holder)
+		goto bad_block;
+
+	/* Compute the heading page number in the page map. */
+	pagenum = ((caddr_t) block - extent->membase) >> heap->priv.pageshift;
+	boffset =
+	    ((caddr_t) block -
+	     (extent->membase + (pagenum << heap->priv.pageshift)));
+	ptype = extent->priv.pagemap[pagenum];
+
+	if (ptype == XNHEAP_PFREE ||	/* Unallocated page? */
+	    ptype == XNHEAP_PCONT)	/* Not a range heading page? */
+	      bad_block:
+		err = -EINVAL;
+
+	xnlock_put_irqrestore(&heap->lock, s);
+
+	return err;
+}
Index: ksrc/nucleus/Config.in
===================================================================
--- ksrc/nucleus/Config.in.orig
+++ ksrc/nucleus/Config.in
@@ -26,6 +26,8 @@ if [ "$CONFIG_XENO_OPT_NUCLEUS" != "n" ]
 	if [ "$CONFIG_XENO_OPT_REGISTRY" != "n" ]; then
 		int 'Number of registry slots' CONFIG_XENO_OPT_REGISTRY_NRSLOTS 512
 	fi
+	choice 'Heap allocator'						\
+		"BSD			CONFIG_XENO_OPT_ALLOC_BSD	BSD
 	int 'Size of the system heap (Kb)' CONFIG_XENO_OPT_SYS_HEAPSZ 128
 	bool 'Interrupt shield support' CONFIG_XENO_OPT_ISHIELD
 	bool 'Optimize as pipeline head' CONFIG_XENO_OPT_PIPELINE_HEAD
@@ -49,10 +51,10 @@ if [ "$CONFIG_XENO_OPT_NUCLEUS" != "n" ]
 	mainmenu_option next_comment
 	comment 'Scalability options'
 		bool 'O(1) scheduler' CONFIG_XENO_OPT_SCALABLE_SCHED
-        choice 'Timer indexing method'			\
-	"Linear			CONFIG_XENO_OPT_TIMER_LIST	\
-	 Tree			CONFIG_XENO_OPT_TIMER_HEAP	\
-	 Hash			CONFIG_XENO_OPT_TIMER_WHEEL"	Linear
+	choice 'Timer indexing method'			\
+		"Linear			CONFIG_XENO_OPT_TIMER_LIST	\
+		 Tree			CONFIG_XENO_OPT_TIMER_HEAP	\
+		 Hash			CONFIG_XENO_OPT_TIMER_WHEEL"	Linear
 	if [ "$CONFIG_XENO_OPT_TIMER_HEAP" = "y" ]; then
 		int 'Max. number of timers' CONFIG_XENO_OPT_TIMER_HEAP_CAPACITY 256
 	fi
Index: ksrc/nucleus/Makefile
===================================================================
--- ksrc/nucleus/Makefile.orig
+++ ksrc/nucleus/Makefile
@@ -12,6 +12,8 @@ xeno_nucleus-$(CONFIG_XENO_OPT_PIPE) += 
 
 xeno_nucleus-$(CONFIG_XENO_OPT_REGISTRY) += registry.o
 
+xeno_nucleus-$(CONFIG_XENO_OPT_ALLOC_BSD) += bsdalloc.o
+
 xeno_nucleus-$(CONFIG_LTT) += ltt.o
 
 EXTRA_CFLAGS += -D__IN_XENOMAI__ -Iinclude/xenomai
@@ -32,6 +34,7 @@ opt_objs-y :=
 opt_objs-$(CONFIG_XENO_OPT_PERVASIVE) += shadow.o core.o
 opt_objs-$(CONFIG_XENO_OPT_PIPE) += pipe.o
 opt_objs-$(CONFIG_XENO_OPT_REGISTRY) += registry.o
+opt_objs-$(CONFIG_XENO_OPT_ALLOC_BSD) += bsdalloc.o
 opt_objs-$(CONFIG_LTT) += ltt.o
 
 xeno_nucleus-objs += $(opt_objs-y)

--------------010702010306020100050708--

