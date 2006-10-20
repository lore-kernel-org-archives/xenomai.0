Message-ID: <453911D9.3020002@domain.hid>
Date: Fri, 20 Oct 2006 20:13:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020301020007010402070101"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 2/2] Add TLSF heap allocator
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
--------------020301020007010402070101
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Based on previous split-up, the attached patch adds TLSF version 2.2.0
as an alternative heap allocator for Xenomai. It is currently limited to
32-bit platforms. It also does not yet implement extensible heap
support, which may break on some PPC platforms (so far obviously the
only user of this feature).

For now this allocator is intended as an experimental variant until the
above issues are resolved and it is proven to work reliably across any
Xenomai-enabled architecture.

--------------020301020007010402070101
Content-Type: text/plain;
 name="tlsf-allocator.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tlsf-allocator.patch"

---
 include/nucleus/heap.h      |    2 
 include/nucleus/tlsfalloc.h |   81 +++++++++
 ksrc/nucleus/Config.in      |    3 
 ksrc/nucleus/Kconfig        |   17 +
 ksrc/nucleus/Makefile       |    2 
 ksrc/nucleus/tlsfalloc.c    |  385 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 489 insertions(+), 1 deletion(-)

Index: include/nucleus/tlsfalloc.h
===================================================================
--- /dev/null
+++ include/nucleus/tlsfalloc.h
@@ -0,0 +1,81 @@
+/*
+ * Two Levels Segregate Fit memory allocator (TLSF)
+ * Version 2.2.0
+ *
+ * Written by Miguel Masmano Tello, adapted to Xenomai by Jan Kiszka
+ *
+ * Copyright (C) 2004,2005,2006 Miguel Masmano Tello <mimastel@domain.hid>.
+ * Copyright (C) 2006 Jan Kiszka <jan.kiszka@domain.hid>.
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
+#ifndef _XENO_NUCLEUS_TLSFALLOC_H
+#define _XENO_NUCLEUS_TLSFALLOC_H
+
+/* Some IMPORTANT TLSF parameters */
+#define MAX_FLI			30
+#define MAX_SLI			32
+#define MAX_LOG2_SLI		5
+#define MAX_SLI			32  /* MAX_SLI = 2^MAX_LOG2_SLI */
+
+#define FLI_OFFSET 6		/* tlsf structure just will manage blocks bigger \
+				   than 128 bytes */
+#define SMALL_BLOCK		128
+#define REAL_FLI		(MAX_FLI - FLI_OFFSET)
+
+#define XNHEAP_MINALIGNSZ	(1 << 4) /* i.e. 16 bytes */
+#define XNHEAP_MAXEXTSZ		(1 << MAX_FLI) /* i.e. 1Gb */
+
+#define xnheap_overhead(hsize,psize) \
+((sizeof(xnextent_t) + XNHEAP_MINALIGNSZ - 1) & ~(XNHEAP_MINALIGNSZ - 1))
+
+struct bhdr_struct;
+
+typedef struct free_ptr_struct {
+	struct bhdr_struct *prev;
+	struct bhdr_struct *next;
+} free_ptr_t;
+
+typedef struct bhdr_struct {
+	/* This pointer is just valid if the first bit of size is set */
+	struct bhdr_struct *prev_hdr;
+	/* The size is stored in bytes */
+	u32 size;	/* bit 0 indicates whether the block is used and
+			   bit 1 allows to know whether the previous block is free */
+	union {
+		struct free_ptr_struct free_ptr;
+		u8 buffer[sizeof(struct free_ptr_struct)];
+	} ptr;
+} bhdr_t;
+
+typedef struct tlsf_struct {
+	/* The first-level bitmap
+	   This array should have a size of REAL_FLI bits */
+	u32 fl_bitmap;
+
+	/* The second-level bitmap */
+	u32 sl_bitmap[REAL_FLI];
+
+	bhdr_t *matrix[REAL_FLI][MAX_SLI];
+} tlsf_t;
+
+typedef tlsf_t xnextend_priv_t;
+
+typedef struct xnheap_priv {
+} xnheap_priv_t;
+
+#endif /* !_XENO_NUCLEUS_TLSFALLOC_H */
Index: ksrc/nucleus/Kconfig
===================================================================
--- ksrc/nucleus/Kconfig.orig
+++ ksrc/nucleus/Kconfig
@@ -133,6 +133,23 @@ choice
 
 config XENO_OPT_ALLOC_BSD
 	bool "BSD"
+	help
+
+	The is an enhanced version of the BSD memory allocator. Details
+	on the algorithm can be found in "Design of a General Purpose
+	Memory Allocator for the 4.3BSD Unix Kernel" by Marshall K.
+	McKusick and Michael J. Karels (USENIX 1988). Xenomai adds
+	support for extendible heaps to this model.
+
+config XENO_OPT_ALLOC_TLSF
+	bool "TLSF"
+	depends on !IA64
+	help
+
+	The TLSF heap allocator has strict O(1) complexity and keeps
+	overhead and fragmentation low. So far it is only available for
+	32-bit platforms. For more details on TLSF see
+	http://rtportal.upv.es/rtmalloc/allocators/tlsf/index.shtml.
 
 endchoice
 
Index: ksrc/nucleus/tlsfalloc.c
===================================================================
--- /dev/null
+++ ksrc/nucleus/tlsfalloc.c
@@ -0,0 +1,385 @@
+/*
+ * Two Levels Segregate Fit memory allocator (TLSF)
+ * Version 2.2.0
+ *
+ * Written by Miguel Masmano Tello, adapted to Xenomai by Jan Kiszka
+ *
+ * Copyright (C) 2004,2005,2006 Miguel Masmano Tello <mimastel@domain.hid>.
+ * Copyright (C) 2006 Jan Kiszka <jan.kiszka@domain.hid>.
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
+#include <asm/bitops.h>
+
+#include <nucleus/pod.h>
+#include <nucleus/heap.h>
+#include <asm/xenomai/bits/heap.h>
+
+#define _fls(x)			(fls(x)-1)
+#define _ffs(x)			(ffs(x)-1)
+
+#define TLSF_MIN_BLOCK_SIZE	12	/* the size of free_ptr_t + 4 */
+
+#define TLSF_BLOCK_SIZE		0xFFFFFFFC
+#define TLSF_BLOCK_INF		0x3
+#define TLSF_BLOCK_STATE	0x1
+#define TLSF_PREV_STATE		0x2
+
+/* bit 0 of the block size */
+#define TLSF_FREE_BLOCK		0x1
+#define TLSF_USED_BLOCK		0
+
+/* bit 1 of the block size */
+#define TLSF_PREV_FREE		0x2
+#define TLSF_PREV_USED		0
+
+/* 4 bytes is size a header (SIZE + several bits to indicate the
+   status of the block) */
+#define TLSF_BHDR_OVERHEAD		4	/* just four bytes */
+
+
+/* TLSF uses boundary tag to know who is the previous and the
+   next memory block, 4 bytes is the size of this tag */
+#define TLSF_GET_NEXT_BLOCK(_addr, _r) \
+	((bhdr_t *) ((unsigned long) _addr + (_r) - 4))
+
+/*
+  We round up or round down _r to a multiple of 4 (we are in a
+  32 bits architecture)
+ */
+#define TLSF_ROUNDUP_SIZE(_r) ((_r + 0x3) & ~0x3)
+#define TLSF_ROUNDDOWN_SIZE(_r) ((_r) & ~0x3)
+
+static inline void TLSF_MAPPING_SEARCH(u_long *_r, int *_fl, int *_sl)
+{
+	int _t;
+
+	if (*_r < SMALL_BLOCK) {
+		*_fl = 0;
+		*_sl = *_r / (SMALL_BLOCK / MAX_SLI);
+	} else {
+		_t = (1 << (_fls(*_r) - MAX_LOG2_SLI)) - 1;
+		*_r = *_r + _t;
+		*_fl = _fls(*_r);
+		*_sl = (*_r >> (*_fl - MAX_LOG2_SLI)) - MAX_SLI;
+		*_fl -= FLI_OFFSET;
+		*_r &= ~_t;
+	}
+}
+
+static inline void TLSF_MAPPING_INSERT(u_long _r, int *_fl, int *_sl)
+{
+	if (_r < SMALL_BLOCK) {
+		*_fl = 0;
+		*_sl = _r / (SMALL_BLOCK / MAX_SLI);
+	} else {
+		*_fl = _fls(_r);
+		*_sl = (_r >> (*_fl - MAX_LOG2_SLI)) - MAX_SLI;
+		*_fl -= FLI_OFFSET;
+	}
+}
+
+static inline bhdr_t *TLSF_FIND_SUITABLE_BLOCK(tlsf_t * _tlsf, int *_fl,
+					  int *_sl)
+{
+	u32 _tmp = _tlsf->sl_bitmap[*_fl] & (~0 << *_sl);
+	bhdr_t *_b = NULL;
+
+	if (_tmp) {
+		*_sl = _ffs(_tmp);
+		_b = _tlsf->matrix[*_fl][*_sl];
+	} else {
+		*_fl = _ffs(_tlsf->fl_bitmap & (~0 << (*_fl + 1)));
+		if (likely(*_fl > 0)) {
+			*_sl = _ffs(_tlsf->sl_bitmap[*_fl]);
+			_b = _tlsf->matrix[*_fl][*_sl];
+		}
+	}
+	return _b;
+}
+
+#define TLSF_EXTRACT_BLOCK_HDR(_b, _tlsf, _fl, _sl) do {\
+	_tlsf->matrix[_fl][_sl] = _b->ptr.free_ptr.next; \
+	if (_tlsf->matrix[_fl][_sl]) \
+		_tlsf->matrix[_fl][_sl] -> ptr.free_ptr.prev = NULL; \
+	else { \
+		__clear_bit(_sl, (u_long *)&_tlsf->sl_bitmap[_fl]); \
+		if (!_tlsf->sl_bitmap[_fl]) \
+			__clear_bit(_fl, (u_long *)&_tlsf->fl_bitmap); \
+	} \
+	_b -> ptr.free_ptr = (free_ptr_t){ NULL, NULL }; \
+} while (0)
+
+#define TLSF_EXTRACT_BLOCK(_b, _tlsf, _fl, _sl) do { \
+	if (_b->ptr.free_ptr.next) \
+		_b->ptr.free_ptr.next->ptr.free_ptr.prev = \
+			_b->ptr.free_ptr.prev; \
+	if (_b->ptr.free_ptr.prev) \
+		_b->ptr.free_ptr.prev->ptr.free_ptr.next = \
+			_b->ptr.free_ptr.next; \
+	if (_tlsf->matrix[_fl][_sl] == _b) {  \
+		_tlsf->matrix[_fl][_sl] = _b->ptr.free_ptr.next; \
+		if (!_tlsf->matrix[_fl][_sl]) {  \
+			__clear_bit(_sl, (u_long *)&_tlsf->sl_bitmap[_fl]); \
+			if (!_tlsf->sl_bitmap[_fl]) \
+				__clear_bit(_fl, \
+					(u_long *)&_tlsf->fl_bitmap); \
+		} \
+	} \
+	_b->ptr.free_ptr = (free_ptr_t){ NULL, NULL }; \
+} while (0)
+
+#define TLSF_INSERT_BLOCK(_b, _tlsf, _fl, _sl) do { \
+	_b->ptr.free_ptr = (free_ptr_t){ NULL, _tlsf->matrix[_fl][_sl] }; \
+	if (_tlsf->matrix[_fl][_sl]) \
+		_tlsf->matrix[_fl][_sl]->ptr.free_ptr.prev = _b; \
+	_tlsf->matrix[_fl][_sl] = _b; \
+	__set_bit(_sl, (u_long *)&_tlsf->sl_bitmap [_fl]); \
+	__set_bit(_fl, (u_long *)&_tlsf->fl_bitmap); \
+} while (0)
+
+
+int xnheap_init(xnheap_t *heap,
+		void *heapaddr, u_long heapsize, u_long pagesize)
+{
+	xnextent_t *extent;
+	tlsf_t *tlsf;
+	bhdr_t *b, *lb;
+	int fl, sl;
+
+	if (!heapaddr || !heapsize ||
+	    heapsize < xnheap_overhead(heapsize, pagesize) + SMALL_BLOCK) {
+		xnlogerr("xnheap_init(): heapaddr invalid\n");
+		return -EINVAL;
+	}
+
+	if (((unsigned long) heapaddr & 0x3)) {
+		xnlogerr("xnheap_init(): heapaddr must be aligned to a word\n");
+		return -EINVAL;
+	}
+
+	/* xnheap initialisation */
+	heap->pagesize = pagesize;
+	heap->extentsize = heapsize;
+	heap->hdrsize = xnheap_overhead(heapsize, pagesize);
+	heap->ubytes = 0;
+	heap->maxcont = heapsize - heap->hdrsize;
+	heap->idleq = NULL;
+	inith(&heap->link);
+	initq(&heap->extents);
+	xnlock_init(&heap->lock);
+
+	xnarch_init_heapcb(&heap->archdep);
+
+	/* xnextent initialisation */
+	extent = (xnextent_t *) heapaddr;
+	memset(extent, 0x0, heap->hdrsize);
+	inith(&extent->link);
+	extent->membase = (caddr_t) extent + heap->hdrsize;
+	extent->memlim = extent->membase + heap->maxcont;
+
+	tlsf = &extent->priv;
+	b = TLSF_GET_NEXT_BLOCK(heapaddr, sizeof(xnextent_t));
+	b->size = TLSF_ROUNDDOWN_SIZE(heapsize - sizeof(xnextent_t) - 2 *
+				TLSF_BHDR_OVERHEAD) | TLSF_FREE_BLOCK | TLSF_PREV_USED;
+	b->ptr.free_ptr.prev = b->ptr.free_ptr.next = 0;
+
+	if (b->size > XNHEAP_MAXEXTSZ) {
+		xnlogerr("xnheap_init(): TLSF can't store a block of %u bytes.\n",
+			  b->size & TLSF_BLOCK_SIZE);
+		return -EINVAL;
+	}
+
+	TLSF_MAPPING_INSERT(b->size, &fl, &sl);
+	TLSF_INSERT_BLOCK(b, tlsf, fl, sl);
+	/* The sentinel block, it allow us to know when we're in the last block */
+	lb = TLSF_GET_NEXT_BLOCK(b->ptr.buffer, b->size & TLSF_BLOCK_SIZE);
+	lb->prev_hdr = b;
+	lb->size = 0 | TLSF_USED_BLOCK | TLSF_PREV_FREE;
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
+				    u_long extsize, void *cookie),
+		   void *cookie)
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
+void *xnheap_alloc(xnheap_t *heap, u_long size)
+{
+	/* FIXME: we only have one extent for now */
+	tlsf_t *tlsf = &link2extent(getheadq(&heap->extents))->priv;
+	bhdr_t *b, *b2, *next_b;
+	int fl, sl, tmp_size;
+	spl_t s;
+
+	if (size == 0)
+		return NULL;
+
+	size = (size < TLSF_MIN_BLOCK_SIZE) ? TLSF_MIN_BLOCK_SIZE : TLSF_ROUNDUP_SIZE(size);
+	/* Rounding up the requested size and calculating fl and sl */
+	TLSF_MAPPING_SEARCH(&size, &fl, &sl);
+
+	xnlock_get_irqsave(&heap->lock, s);
+
+	/* Searching a free block */
+	if (!(b = TLSF_FIND_SUITABLE_BLOCK(tlsf, &fl, &sl))) {
+		xnlock_put_irqrestore(&heap->lock, s);
+		return NULL;		/* Not found */
+	}
+
+	TLSF_EXTRACT_BLOCK_HDR(b, tlsf, fl, sl);
+
+	/*-- found: */
+	next_b = TLSF_GET_NEXT_BLOCK(b->ptr.buffer, b->size & TLSF_BLOCK_SIZE);
+	/* Should the block be split? */
+	tmp_size = (b->size & TLSF_BLOCK_SIZE) - size - TLSF_BHDR_OVERHEAD;
+	if (tmp_size >= TLSF_MIN_BLOCK_SIZE) {
+		b2 = TLSF_GET_NEXT_BLOCK(b->ptr.buffer, size);
+		b2->size = tmp_size | TLSF_FREE_BLOCK | TLSF_PREV_USED;
+		next_b->prev_hdr = b2;
+
+		TLSF_MAPPING_INSERT(tmp_size, &fl, &sl);
+		TLSF_INSERT_BLOCK(b2, tlsf, fl, sl);
+
+		b->size = size | (b->size & TLSF_PREV_STATE);
+	} else
+		next_b->size &= (~TLSF_PREV_FREE);
+
+	b->size &= (~TLSF_FREE_BLOCK);	/* Now it's used */
+
+	heap->ubytes += (b->size & TLSF_BLOCK_SIZE) + TLSF_BHDR_OVERHEAD;
+
+	xnlock_put_irqrestore(&heap->lock, s);
+
+	return (void *) b->ptr.buffer;
+}
+
+int xnheap_test_and_free(xnheap_t *heap, void *block,
+			 int (*ckfn) (void *block))
+{
+	tlsf_t *tlsf;
+	bhdr_t *b = (bhdr_t *) ((unsigned long) block - 8), *tmp_b;
+	int fl = 0, sl = 0;
+	xnholder_t *holder;
+	xnextent_t *extent;
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
+	if (!holder) {
+		xnlock_put_irqrestore(&heap->lock, s);
+		return -EINVAL;
+	}
+
+	tlsf = &extent->priv;
+
+	heap->ubytes -= (b->size & TLSF_BLOCK_SIZE) + TLSF_BHDR_OVERHEAD;
+
+	b->size |= TLSF_FREE_BLOCK;
+	b->ptr.free_ptr = (free_ptr_t) { NULL, NULL };
+	tmp_b = TLSF_GET_NEXT_BLOCK(b->ptr.buffer, b->size & TLSF_BLOCK_SIZE);
+	if (tmp_b->size & TLSF_FREE_BLOCK) {
+		TLSF_MAPPING_INSERT(tmp_b->size & TLSF_BLOCK_SIZE, &fl, &sl);
+		TLSF_EXTRACT_BLOCK(tmp_b, tlsf, fl, sl);
+		b->size += (tmp_b->size & TLSF_BLOCK_SIZE) + TLSF_BHDR_OVERHEAD;
+	}
+	if (b->size & TLSF_PREV_FREE) {
+		tmp_b = b->prev_hdr;
+		TLSF_MAPPING_INSERT(tmp_b->size & TLSF_BLOCK_SIZE, &fl, &sl);
+		TLSF_EXTRACT_BLOCK(tmp_b, tlsf, fl, sl);
+		tmp_b->size += (b->size & TLSF_BLOCK_SIZE) + TLSF_BHDR_OVERHEAD;
+		b = tmp_b;
+	}
+	TLSF_MAPPING_INSERT(b->size & TLSF_BLOCK_SIZE, &fl, &sl);
+	TLSF_INSERT_BLOCK(b, tlsf, fl, sl);
+
+	tmp_b = TLSF_GET_NEXT_BLOCK(b->ptr.buffer, b->size & TLSF_BLOCK_SIZE);
+	tmp_b->size |= TLSF_PREV_FREE;
+	tmp_b->prev_hdr = b;
+
+	xnlock_put_irqrestore(&heap->lock, s);
+
+	return 0;
+}
+
+int xnheap_extend(xnheap_t *heap, void *extaddr, u_long extsize)
+{
+	/* FIXME: add support for multiple extents */
+	return -ENOSYS;
+}
+
+int xnheap_check_block(xnheap_t *heap, void *block)
+{
+	xnholder_t *holder;
+	xnextent_t *extent;
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
+	xnlock_put_irqrestore(&heap->lock, s);
+
+	return (holder) ? 0 : -EINVAL;
+}
Index: ksrc/nucleus/Config.in
===================================================================
--- ksrc/nucleus/Config.in.orig
+++ ksrc/nucleus/Config.in
@@ -27,7 +27,8 @@ if [ "$CONFIG_XENO_OPT_NUCLEUS" != "n" ]
 		int 'Number of registry slots' CONFIG_XENO_OPT_REGISTRY_NRSLOTS 512
 	fi
 	choice 'Heap allocator'						\
-		"BSD			CONFIG_XENO_OPT_ALLOC_BSD	BSD
+		"BSD			CONFIG_XENO_OPT_ALLOC_BSD	\
+		 TLSF			CONFIG_XENO_OPT_ALLOC_TLSF"	BSD
 	int 'Size of the system heap (Kb)' CONFIG_XENO_OPT_SYS_HEAPSZ 128
 	bool 'Interrupt shield support' CONFIG_XENO_OPT_ISHIELD
 	bool 'Optimize as pipeline head' CONFIG_XENO_OPT_PIPELINE_HEAD
Index: ksrc/nucleus/Makefile
===================================================================
--- ksrc/nucleus/Makefile.orig
+++ ksrc/nucleus/Makefile
@@ -13,6 +13,7 @@ xeno_nucleus-$(CONFIG_XENO_OPT_PIPE) += 
 xeno_nucleus-$(CONFIG_XENO_OPT_REGISTRY) += registry.o
 
 xeno_nucleus-$(CONFIG_XENO_OPT_ALLOC_BSD) += bsdalloc.o
+xeno_nucleus-$(CONFIG_XENO_OPT_ALLOC_TLSF) += tlsfalloc.o
 
 xeno_nucleus-$(CONFIG_LTT) += ltt.o
 
@@ -35,6 +36,7 @@ opt_objs-$(CONFIG_XENO_OPT_PERVASIVE) +=
 opt_objs-$(CONFIG_XENO_OPT_PIPE) += pipe.o
 opt_objs-$(CONFIG_XENO_OPT_REGISTRY) += registry.o
 opt_objs-$(CONFIG_XENO_OPT_ALLOC_BSD) += bsdalloc.o
+opt_objs-$(CONFIG_XENO_OPT_ALLOC_TLSF) += tlsfalloc.o
 opt_objs-$(CONFIG_LTT) += ltt.o
 
 xeno_nucleus-objs += $(opt_objs-y)
Index: include/nucleus/heap.h
===================================================================
--- include/nucleus/heap.h.orig
+++ include/nucleus/heap.h
@@ -46,6 +46,8 @@
 
 #if defined(CONFIG_XENO_OPT_ALLOC_BSD)
 #include <nucleus/bsdalloc.h>
+#elif defined(CONFIG_XENO_OPT_ALLOC_TLSF)
+#include <nucleus/tlsfalloc.h>
 #endif /* allocator selection */
 
 typedef struct xnextent {

--------------020301020007010402070101--

