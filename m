Message-ID: <474D383C.5080804@domain.hid>
Date: Wed, 28 Nov 2007 10:43:24 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2AE3BF3A@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2AE3BF3A@ARVMAIL1.mra.roland-man.biz>
Content-Type: multipart/mixed; boundary="------------080800080509090608090400"
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
--------------080800080509090608090400
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Roderik.Wildenburg@domain.hid wrote:
> Thank you. Good work !=20
>=20
> I applied your patch to 2.3.2 and, as far as I can see,=20
> the allocation problem does not accur anymore.
>

You will need this attached patch on top of the previous one to get the
complete fix.

> (please se my insertions below)
>=20
>> Now, the human readable form of the explanation:
>> - you ask for a 10kb heap, which is silently rounded to 12k=20
>> in order to
>> cope with the 4k alignment constraint we have on shareable heaps
>> (userland heaps are always shareable).
>> - 12kb heap means 3 * 4k pages available in the global free list.
>> - your application allocates randomly-sized blocks, each new size
>> rounded to the next power of 2 grabs one page from the global pool to
>> hold blocks of the same size, but unfortunately, the heap manager does
>> _not_ release it back to the free list when the last block laid on the
>> page is freed.
>=20
> Thank you for your explanation,
> I thought it must be something like this=20
> (block remembers what size ist as been allocated for)
>=20
>> - after more than 3 different allocation sizes (e.g. 2^3, 2^5 and 2^8)
>> have been requested to the heap manager, it fails honoring a=20
>> fourth one.
>> I would rather consider this as a bug, since putting a lot of pressure
>> on a single block size would beget the same problem (i.e. no=20
>> need for a
>> funky randomized allocation pattern here), with a global free=20
>=20
> I think the test case isn=B4t very funky. Of course we did not write=20
> random buffer sizes (this was just implemted to get a simple test case),
> but we simple wrote some messages of different size to a queue and faced
> the allocation problem.
> Therefore, form our point of view, this is a bug.
>=20

Funky in the sense that real-time applications usually have a
well-defined allocation pattern, with sizes known in advance, which
reduces the odds for fragmentation, and helps keeping the
allocation/deallocation cheap. This does not prevent from considering
the failure to cope with the opposite situation as a bug, though.

>> page list
>> being emptied over time, and all pages lingering inside some private
>> (per-block size) bucket queue.
>>
>> The attached patch fixed the issue (against v2.4-rc6). I'm still
>> pondering whether v2.3.x should get this update too, due to the
>> variations this patch introduces wrt memory consumption for the heap
>=20
> I would appreciate it, if 2.3.x could be updated too,=20
> as we could carry on using 2.3.x (vendor libraries don=B4t need to be upd=
ated)
>=20

It's not a feature change/addition, but can be considered as a
maintenance issue, so it's likely to make it into the ultimate v2.3.x
release.

> Many thanks and best regards
> Roderik=20
>=20
> MAN Roland Druckmaschinen AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Rall,=
 Paul Steidle   =20
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht Of=
fenbach HRB-Nr. 42592   =20
> USt-Ident-Nr. DE 250200933
>=20


--=20
Philippe.

--------------080800080509090608090400
Content-Type: text/x-patch;
 name="heap-fix-single-page-release.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="heap-fix-single-page-release.patch"

Index: include/nucleus/heap.h
===================================================================
--- include/nucleus/heap.h	(revision 3216)
+++ include/nucleus/heap.h	(revision 3217)
@@ -92,7 +92,10 @@
 
         DECLARE_XNLOCK(lock);
 
-	caddr_t buckets[XNHEAP_NBUCKETS];
+	struct xnbucket {
+		caddr_t freelist;
+		int fcount;
+	} buckets[XNHEAP_NBUCKETS];
 
 	xnholder_t *idleq;
 
Index: ksrc/nucleus/heap.c
===================================================================
--- ksrc/nucleus/heap.c	(revision 3216)
+++ ksrc/nucleus/heap.c	(revision 3217)
@@ -161,7 +161,6 @@
 {
 	u_long hdrsize, shiftsize, pageshift;
 	xnextent_t *extent;
-	int n;
 
 	/*
 	 * Perform some parametrical checks first.
@@ -219,14 +218,9 @@
 	inith(&heap->link);
 	initq(&heap->extents);
 	xnlock_init(&heap->lock);
-
 	xnarch_init_heapcb(&heap->archdep);
-
-	for (n = 0; n < XNHEAP_NBUCKETS; n++)
-		heap->buckets[n] = NULL;
-
+	memset(heap->buckets, 0, sizeof(heap->buckets));
 	extent = (xnextent_t *)heapaddr;
-
 	init_extent(heap, extent);
 
 	appendq(&heap->extents, &extent->link);
@@ -428,10 +422,10 @@
 {
 	xnholder_t *holder;
 	xnextent_t *extent;
+	int log2size, ilog;
 	u_long pagenum;
 	caddr_t block;
 	u_long bsize;
-	int log2size;
 	spl_t s;
 
 	if (size == 0)
@@ -463,7 +457,7 @@
 	   2 times the page size. Otherwise, use the bucketed memory
 	   blocks. */
 
-	if (size <= heap->pagesize * 2) {
+	if (likely(size <= heap->pagesize * 2)) {
 		/* Find the first power of two greater or equal to the rounded
 		   size. The log2 value of this size is also computed. */
 
@@ -471,22 +465,22 @@
 		     bsize < size; bsize <<= 1, log2size++)
 			;	/* Loop */
 
+		ilog = log2size - XNHEAP_MINLOG2;
+
 		xnlock_get_irqsave(&heap->lock, s);
 
-		block = heap->buckets[log2size - XNHEAP_MINLOG2];
+		block = heap->buckets[ilog].freelist;
 
 		if (block == NULL) {
 			block = get_free_range(heap, bsize, log2size);
 			if (block == NULL)
 				goto release_and_exit;
+			if (bsize <= heap->pagesize)
+				heap->buckets[ilog].fcount += (heap->pagesize >> log2size) - 1;
 		} else {
-			/*
-			 * If only we had all pages sitting on
-			 * pagesize boundaries, we could use a trivial
-			 * address masking to compute the address of
-			 * the containing page, but we can't assume
-			 * that for now. Oh, well...
-			 */
+			if (bsize <= heap->pagesize)
+				--heap->buckets[ilog].fcount;
+
 			for (holder = getheadq(&heap->extents), extent = NULL;
 			     holder != NULL; holder = nextq(&heap->extents, holder)) {
 				extent = link2extent(holder);
@@ -502,7 +496,7 @@
 			++extent->pagemap[pagenum].bcount;
 		}
 
-		heap->buckets[log2size - XNHEAP_MINLOG2] = *((caddr_t *) block);
+		heap->buckets[ilog].freelist = *((caddr_t *) block);
 		heap->ubytes += bsize;
 	} else {
 		if (size > heap->maxcont)
@@ -566,10 +560,10 @@
 
 int xnheap_test_and_free(xnheap_t *heap, void *block, int (*ckfn) (void *block))
 {
-	caddr_t freepage, lastpage, nextpage, tailpage;
+	caddr_t freepage, lastpage, nextpage, tailpage, freeptr, *tailptr;
+	int log2size, npages, err, nblocks, xpage, ilog;
 	u_long pagenum, pagecont, boffset, bsize;
 	xnextent_t *extent = NULL;
-	int log2size, npages, err;
 	xnholder_t *holder;
 	spl_t s;
 
@@ -672,22 +666,75 @@
 		 * value for the heading page is always 1).
 		 */
 
-		if (unlikely(--extent->pagemap[pagenum].bcount == 0)) {
-			heap->buckets[log2size - XNHEAP_MINLOG2] = NULL;
-			npages = bsize >> heap->pageshift;
-			if (likely(npages <= 1)) {
-				tailpage = block;
-				goto free_pages;
-			}
+		ilog = log2size - XNHEAP_MINLOG2;
+
+		if (likely(--extent->pagemap[pagenum].bcount > 0)) {
+			/* Return the block to the bucketed memory space. */
+			*((caddr_t *) block) = heap->buckets[ilog].freelist;
+			heap->buckets[ilog].freelist = block;
+			++heap->buckets[ilog].fcount;
+			break;
+		}
+
+		npages = bsize >> heap->pageshift;
+
+		if (unlikely(npages > 1))
+			/*
+			 * The simplest case: we only have a single
+			 * block to deal with, which spans multiple
+			 * pages. We just need to release it as a list
+			 * of pages, without caring about the
+			 * consistency of the bucket.
+			 */
 			goto free_page_list;
+
+		freepage = extent->membase + (pagenum << heap->pageshift);
+		block = freepage;
+		tailpage = freepage;
+		nextpage = freepage + heap->pagesize;
+		nblocks = heap->pagesize >> log2size;
+		heap->buckets[ilog].fcount -= (nblocks - 1);
+
+		XENO_ASSERT(NUCLEUS, heap->buckets[ilog].fcount >= 0,
+			    xnpod_fatal("free block count became negative (heap %p, log2=%d, fcount=%d)?!",
+					heap, log2size, heap->buckets[ilog].fcount);
+			);
+		/*
+		 * Easy case: all free blocks are laid on a single
+		 * page we are now releasing. Just clear the bucket
+		 * and bail out.
+		 */
+
+		if (likely(heap->buckets[ilog].fcount == 0)) {
+			heap->buckets[ilog].freelist = NULL;
+			goto free_pages;
 		}
 
-		/* Return the block to the bucketed memory space. */
+		/*
+		 * Worst case: multiple pages are traversed by the
+		 * bucket list. Scan the list to remove all blocks
+		 * belonging to the freed page. We are done whenever
+		 * all possible blocks from the freed page have been
+		 * traversed, or we hit the end of list, whichever
+		 * comes first.
+		 */
 
-		*((caddr_t *) block) = heap->buckets[log2size - XNHEAP_MINLOG2];
-		heap->buckets[log2size - XNHEAP_MINLOG2] = block;
+		for (tailptr = &heap->buckets[ilog].freelist, freeptr = *tailptr, xpage = 1;
+		     freeptr != NULL && nblocks > 0; freeptr = *((caddr_t *) freeptr)) {
+			if (unlikely(freeptr < freepage || freeptr >= nextpage)) {
+				if (unlikely(xpage)) { /* Limit random writes */
+					*tailptr = freeptr;
+					xpage = 0;
+				}
+				tailptr = (caddr_t *)freeptr;
+			} else {
+				--nblocks;
+				xpage = 1;
+			}
+		}
 
-		break;
+		*tailptr = freeptr;
+		goto free_pages;
 	}
 
 	heap->ubytes -= bsize;

--------------080800080509090608090400--

