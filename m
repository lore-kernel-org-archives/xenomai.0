Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4ADDA26D.2050504@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue, 20 Oct 2009 13:37:25 +0200
Message-ID: <20091020113725.9069.52444.stgit@domain.hid>
In-Reply-To: <20091020113724.9069.23594.stgit@domain.hid>
References: <20091020113724.9069.23594.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v3 3/9] nucleus: Fix race window in heap
	mapping procedure
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

There is a race window between setting the heap address via the IOCTL
and actually mapping it. A heap that is invalidated after the IOCTL can
still be mapped by user space. Fix this by pushing the heap validation
into xnheap_mmap.

Moreover, make sure that we update archdep.numaps along with declaring
the heap valid. Otherwise xnheap_destroy_mapped may draw wrong
conclusions about the heap mapping state.

As archdep.numaps is now exclusively modified under heapq_lock, we can
switch it to a non-atomic counter.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/asm-generic/bits/heap.h |    2 +
 include/asm-generic/system.h    |    2 +
 ksrc/nucleus/heap.c             |   55 +++++++++++++++++++--------------------
 ksrc/skins/native/heap.c        |    7 +++--
 4 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/include/asm-generic/bits/heap.h b/include/asm-generic/bits/heap.h
index 40d31c8..4d0c41a 100644
--- a/include/asm-generic/bits/heap.h
+++ b/include/asm-generic/bits/heap.h
@@ -27,7 +27,7 @@
 static inline void xnarch_init_heapcb (xnarch_heapcb_t *hcb)
 
 {
-    atomic_set(&hcb->numaps,0);
+    hcb->numaps = 0;
     hcb->kmflags = 0;
     hcb->heapbase = NULL;
 }
diff --git a/include/asm-generic/system.h b/include/asm-generic/system.h
index fcec613..c0f1698 100644
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -270,7 +270,7 @@ struct xnheap;
 
 typedef struct xnarch_heapcb {
 
-	atomic_t numaps;	/* # of active user-space mappings. */
+	unsigned long numaps;	/* # of active user-space mappings. */
 	int kmflags;		/* Kernel memory flags (0 if vmalloc()). */
 	void *heapbase;		/* Shared heap memory base. */
 	void (*release)(struct xnheap *heap); /* callback upon last unmap */
diff --git a/ksrc/nucleus/heap.c b/ksrc/nucleus/heap.c
index 9ba5227..0a9bfdf 100644
--- a/ksrc/nucleus/heap.c
+++ b/ksrc/nucleus/heap.c
@@ -1027,7 +1027,7 @@ static void xnheap_vmclose(struct vm_area_struct *vma)
 
 	spin_lock(&kheapq_lock);
 
-	if (atomic_dec_and_test(&heap->archdep.numaps)) {
+	if (--heap->archdep.numaps == 0) {
 		if (heap->archdep.release) {
 			removeq(&kheapq, &heap->link);
 			spin_unlock(&kheapq_lock);
@@ -1067,31 +1067,15 @@ static inline xnheap_t *__validate_heap_addr(void *addr)
 static int xnheap_ioctl(struct inode *inode,
 			struct file *file, unsigned int cmd, unsigned long arg)
 {
-	xnheap_t *heap;
-	int err = 0;
-
-	spin_lock(&kheapq_lock);
-
-	heap = __validate_heap_addr((void *)arg);
-
-	if (!heap) {
-		err = -EINVAL;
-		goto unlock_and_exit;
-	}
-
-	file->private_data = heap;
-
-      unlock_and_exit:
-
-	spin_unlock(&kheapq_lock);
-
-	return err;
+	file->private_data = (void *)arg;
+	return 0;
 }
 
 static int xnheap_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	unsigned long offset, size, vaddr;
 	xnheap_t *heap;
+	int err;
 
 	if (vma->vm_ops != NULL || file->private_data == NULL)
 		/* Caller should mmap() once for a given file instance, after
@@ -1103,21 +1087,34 @@ static int xnheap_mmap(struct file *file, struct vm_area_struct *vma)
 
 	offset = vma->vm_pgoff << PAGE_SHIFT;
 	size = vma->vm_end - vma->vm_start;
-	heap = (xnheap_t *)file->private_data;
 
+	spin_lock(&kheapq_lock);
+
+	heap = __validate_heap_addr(file->private_data);
+	if (!heap) {
+		spin_unlock(&kheapq_lock);
+		return -EINVAL;
+	}
+
+	heap->archdep.numaps++;
+
+	spin_unlock(&kheapq_lock);
+
+	err = -ENXIO;
 	if (offset + size > xnheap_extentsize(heap))
-		return -ENXIO;
+		goto deref_out;
 
 	if (countq(&heap->extents) > 1)
 		/* Cannot map multi-extent heaps, we need the memory
 		   area we map from to be contiguous. */
-		return -ENXIO;
+		goto deref_out;
 
 	vma->vm_ops = &xnheap_vmops;
 	vma->vm_private_data = file->private_data;
 
 	vaddr = (unsigned long)heap->archdep.heapbase + offset;
 
+	err = -EAGAIN;
 	if ((heap->archdep.kmflags & ~XNHEAP_GFP_NONCACHED) == 0) {
 		unsigned long maddr = vma->vm_start;
 
@@ -1126,7 +1123,7 @@ static int xnheap_mmap(struct file *file, struct vm_area_struct *vma)
 
 		while (size > 0) {
 			if (xnarch_remap_vm_page(vma, maddr, vaddr))
-				return -EAGAIN;
+				goto deref_out;
 
 			maddr += PAGE_SIZE;
 			vaddr += PAGE_SIZE;
@@ -1136,13 +1133,15 @@ static int xnheap_mmap(struct file *file, struct vm_area_struct *vma)
 					      vma->vm_start,
 					      virt_to_phys((void *)vaddr),
 					      size, vma->vm_page_prot))
-		return -EAGAIN;
+		goto deref_out;
 
 	xnarch_fault_range(vma);
 
-	atomic_inc(&heap->archdep.numaps);
-
 	return 0;
+
+deref_out:
+	xnheap_vmclose(vma);
+	return err;
 }
 
 int xnheap_init_mapped(xnheap_t *heap, u_long heapsize, int memflags)
@@ -1188,7 +1187,7 @@ int xnheap_destroy_mapped(xnheap_t *heap, void (*release)(struct xnheap *heap),
 
 	spin_lock(&kheapq_lock);
 
-	if (atomic_read(&heap->archdep.numaps) > ccheck) {
+	if (heap->archdep.numaps > ccheck) {
 		heap->archdep.release = release;
 		spin_unlock(&kheapq_lock);
 		return -EBUSY;
diff --git a/ksrc/skins/native/heap.c b/ksrc/skins/native/heap.c
index 0a24735..9c3810c 100644
--- a/ksrc/skins/native/heap.c
+++ b/ksrc/skins/native/heap.c
@@ -60,11 +60,12 @@ static int __heap_read_proc(char *page,
 	int len;
 	spl_t s;
 
-	p += sprintf(p, "type=%s:size=%lu:used=%lu:numaps=%d\n",
+	p += sprintf(p, "type=%s:size=%lu:used=%lu:numaps=%lu\n",
 		     (heap->mode & H_SHARED) == H_SHARED ? "shared" :
 		     (heap->mode & H_MAPPABLE) ? "mappable" : "kernel",
-		     xnheap_usable_mem(&heap->heap_base), xnheap_used_mem(&heap->heap_base),
-		     atomic_read(&heap->heap_base.archdep.numaps));
+		     xnheap_usable_mem(&heap->heap_base),
+		     xnheap_used_mem(&heap->heap_base),
+		     heap->heap_base.archdep.numaps);
 
 	xnlock_get_irqsave(&nklock, s);
 


