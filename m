MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZRpQenWdN7"
Content-Transfer-Encoding: 7bit
Message-ID: <18413.23840.924010.355653@domain.hid>
Date: Fri, 28 Mar 2008 22:03:28 +0100
In-Reply-To: <2ff1a98a0803280914w1135416bnb45ae48395d86244@domain.hid>
References: <d6c8ef150803280435s2fb6a459kcfe68a0dde86b34c@domain.hid>
	<2ff1a98a0803280605j43811112y1c29e61edd0bc53c@domain.hid>
	<d6c8ef150803280646y4fd12734v862b4f399727a5b5@domain.hid>
	<2ff1a98a0803280654u35f2da13t16a145ac22c1714f@domain.hid>
	<2ff1a98a0803280655r665412f5qfa8ada46f630536a@domain.hid>
	<d6c8ef150803280828v59f764en6bbb543fd6b7b8f7@domain.hid>
	<2ff1a98a0803280834t38a195eey3fce0bb0c5ef9831@domain.hid>
	<d6c8ef150803280844o4e2b2f92w1ecf3dcd555942a3@domain.hid>
	<2ff1a98a0803280848o6ab78800l51b7afb486d6a5d0@domain.hid>
	<d6c8ef150803280904y30c9fbdfl1545094ad2a7022d@domain.hid>
	<2ff1a98a0803280914w1135416bnb45ae48395d86244@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Using shared memory, Xenomai 2.4.2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>, xenomai-help <xenomai@xenomai.org>


--ZRpQenWdN7
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
 > On Fri, Mar 28, 2008 at 5:04 PM, Bosko Radivojevic
 > <bosko.radivojevic@domain.hid> wrote:
 > > Yes, you are absolutely right. I moved rt_heap_create call to module
 > >  initialization. What about patch you've mentioned? :)
 > 
 > I do not have it at hand. Will send it tonight.

Here comes the patch. It is unfinished, getting posix heaps to
automatically use the new flag on ARM requires some more work.

-- 


					    Gilles.

--ZRpQenWdN7
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-heap-uncached.diff"
Content-Transfer-Encoding: 7bit

Index: include/native/heap.h
===================================================================
--- include/native/heap.h	(revision 3661)
+++ include/native/heap.h	(working copy)
@@ -33,6 +33,7 @@
 #define H_MAPPABLE 0x200	/* Memory is mappable to user-space. */
 #define H_SINGLE   0x400	/* Manage as single-block area. */
 #define H_SHARED   (H_MAPPABLE|H_SINGLE) /* I.e. shared memory segment. */
+#define H_NONCACHED 0x800
 
 /** Structure containing heap-information useful to users.
  *
Index: include/asm-generic/wrappers.h
===================================================================
--- include/asm-generic/wrappers.h	(revision 3661)
+++ include/asm-generic/wrappers.h	(working copy)
@@ -62,7 +62,7 @@ unsigned long __va_to_kva(unsigned long 
 
 #define wrap_remap_vm_page(vma,from,to) ({ \
     vma->vm_flags |= VM_RESERVED; \
-    remap_page_range(from,virt_to_phys((void *)__va_to_kva(to)),PAGE_SIZE,PAGE_SHARED); \
+    remap_page_range(from,virt_to_phys((void *)__va_to_kva(to)),PAGE_SIZE,vma->vm_page_prot); \
 })
 #define wrap_remap_io_page_range(vma,from,to,size,prot) ({ \
     vma->vm_flags |= VM_RESERVED; \
@@ -223,7 +223,7 @@ unsigned long __va_to_kva(unsigned long 
  * memory. Anyway, this legacy would only hit setups using pre-2.6.11
  * kernel revisions. */
 #define wrap_remap_vm_page(vma,from,to) \
-    remap_pfn_range(vma,from,virt_to_phys((void *)__va_to_kva(to)) >> PAGE_SHIFT,PAGE_SHIFT,PAGE_SHARED)
+    remap_pfn_range(vma,from,virt_to_phys((void *)__va_to_kva(to)) >> PAGE_SHIFT,PAGE_SHIFT,vma->vm_page_prot)
 #define wrap_remap_io_page_range(vma,from,to,size,prot)  ({		\
     (vma)->vm_page_prot = pgprot_noncached((vma)->vm_page_prot);	\
     /* Sets VM_RESERVED | VM_IO | VM_PFNMAP on the vma. */		\
@@ -236,7 +236,7 @@ unsigned long __va_to_kva(unsigned long 
 #else /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10) */
 #define wrap_remap_vm_page(vma,from,to) ({ \
     vma->vm_flags |= VM_RESERVED; \
-    remap_page_range(from,virt_to_phys((void *)__va_to_kva(to)),PAGE_SIZE,PAGE_SHARED); \
+    remap_page_range(from,virt_to_phys((void *)__va_to_kva(to)),PAGE_SIZE,vma->vm_page_prot); \
 })
 #define wrap_remap_io_page_range(vma,from,to,size,prot) ({	\
       vma->vm_flags |= VM_RESERVED;				\
@@ -248,7 +248,11 @@ unsigned long __va_to_kva(unsigned long 
     })
 #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,15) */
 
-#define wrap_switch_mm(prev,next,task)	\
+#ifndef __GFP_BITS_SHIFT
+#define __GFP_BITS_SHIFT 20
+#endif
+
+#define wrap_switch_mm(prev,next,task)		\
     switch_mm(prev,next,task)
 #define wrap_enter_lazy_tlb(mm,task)	\
     enter_lazy_tlb(mm,task)
Index: include/nucleus/heap.h
===================================================================
--- include/nucleus/heap.h	(revision 3661)
+++ include/nucleus/heap.h	(working copy)
@@ -57,6 +57,8 @@
 #define XNHEAP_PCONT   1
 #define XNHEAP_PLIST   2
 
+#define XNHEAP_GFP_NONCACHED (1 << __GFP_BITS_SHIFT)
+
 typedef struct xnextent {
 
 	xnholder_t link;
Index: ksrc/skins/native/heap.c
===================================================================
--- ksrc/skins/native/heap.c	(revision 3661)
+++ ksrc/skins/native/heap.c	(working copy)
@@ -205,6 +205,10 @@ static void __heap_flush_private(xnheap_
  * operations with I/O devices. The physical address of the
  * heap can be obtained by a call to rt_heap_inquire().
  *
+ * - H_NONCACHED causes the heap not to be cached. This is necessary on
+ * platforms such as ARM to share a heap between kernel and user-space.
+ * Note that this flag is not compatible with the H_DMA flag.
+ *
  * @return 0 is returned upon success. Otherwise:
  *
  * - -EEXIST is returned if the @a name is already in use by some
@@ -260,7 +264,9 @@ int rt_heap_create(RT_HEAP *heap, const 
 
 		err = xnheap_init_mapped(&heap->heap_base,
 					 heapsize,
-					 (mode & H_DMA) ? GFP_DMA : 0);
+					 ((mode & H_DMA) ? GFP_DMA : 0)
+					 | ((mode & H_NONCACHED) ?
+					    XNHEAP_GFP_NONCACHED : 0));
 		if (err)
 			return err;
 
Index: ksrc/nucleus/heap.c
===================================================================
--- ksrc/nucleus/heap.c	(revision 3661)
+++ ksrc/nucleus/heap.c	(working copy)
@@ -1097,9 +1097,13 @@ static int xnheap_mmap(struct file *file
 
 	vaddr = (unsigned long)heap->archdep.heapbase;
 
-	if (!heap->archdep.kmflags) {
+	if (!heap->archdep.kmflags
+	    || heap->archdep.kmflags == XNHEAP_GFP_NONCACHED) {
 		unsigned long maddr = vma->vm_start;
 
+		if (heap->archdep.kmflags == XNHEAP_GFP_NONCACHED)
+			vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
 		while (size > 0) {
 			if (xnarch_remap_vm_page(vma, maddr, vaddr))
 				return -EAGAIN;
@@ -1174,9 +1178,13 @@ static inline void *__alloc_and_reserve_
 
 	/* Size must be page-aligned. */
 
-	if (!kmflags) {
-		ptr = vmalloc(size);
-
+	if (!kmflags || kmflags == XNHEAP_GFP_NONCACHED) {
+		if (!kmflags)
+			ptr = vmalloc(size);
+		else
+			ptr = __vmalloc(size,
+					GFP_KERNEL | __GFP_HIGHMEM,
+					pgprot_noncached(PAGE_KERNEL));
 		if (!ptr)
 			return NULL;
 
@@ -1241,6 +1249,11 @@ int xnheap_init_mapped(xnheap_t *heap, u
 
 	/* Caller must have accounted for internal overhead. */
 	heapsize = xnheap_align(heapsize, PAGE_SIZE);
+
+	if ((memflags & XNHEAP_GFP_NONCACHED)
+	    && memflags != XNHEAP_GFP_NONCACHED)
+		return -EINVAL;
+
 	heapbase = __alloc_and_reserve_heap(heapsize, memflags);
 
 	if (!heapbase)

--ZRpQenWdN7--

