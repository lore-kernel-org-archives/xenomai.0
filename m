Message-ID: <48C4FFCA.4010900@domain.hid>
Date: Mon, 08 Sep 2008 12:34:50 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200808251743.26012@domain.hid>	<48B2DCCC.4010303@domain.hid>	<200809041804.16435@domain.hid>	<67b6b3430809041446m2e716c04p7032c7ed606c354c@domain.hid>
	<48C0F1E1.2000400@domain.hid>
In-Reply-To: <48C0F1E1.2000400@domain.hid>
Content-Type: multipart/mixed; boundary="------------050102010805090502060803"
Subject: Re: [Xenomai-help] rt_queue_delete returns -EBUSY
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------050102010805090502060803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Mark Saiia wrote:
>> Hello,
>>
>> This is my first post, but I have been following the lists for a while.  I
>> just updated to xenomai 2.4.5 and noticed the same issue occurring in a
>> clean-up routine.
> 
> AFAIK Philippe is working on this issue. So I guess he will tell us a
> bit more when he is done.
> 

Feedback welcome.

-- 
Philippe.

--------------050102010805090502060803
Content-Type: text/x-diff;
 name="fix-mapped-heap-refcnt-handling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-mapped-heap-refcnt-handling.patch"

Index: include/native/heap.h
===================================================================
--- include/native/heap.h	(revision 4147)
+++ include/native/heap.h	(working copy)
@@ -118,6 +118,9 @@
 	xeno_flush_rq(RT_HEAP, rq, heap);
 }
 
+int rt_heap_delete_inner(RT_HEAP *heap,
+			 void __user *mapaddr);
+
 #else /* !CONFIG_XENO_OPT_NATIVE_HEAP */
 
 #define __native_heap_pkg_init()		({ 0; })
Index: include/native/queue.h
===================================================================
--- include/native/queue.h	(revision 4147)
+++ include/native/queue.h	(working copy)
@@ -132,6 +132,9 @@
 	xeno_flush_rq(RT_QUEUE, rq, queue);
 }
 
+int rt_queue_delete_inner(RT_QUEUE *q,
+			  void __user *mapaddr);
+
 #else /* !CONFIG_XENO_OPT_NATIVE_QUEUE */
 
 #define __native_queue_pkg_init()		({ 0; })
Index: include/nucleus/heap.h
===================================================================
--- include/nucleus/heap.h	(revision 4147)
+++ include/nucleus/heap.h	(working copy)
@@ -178,7 +178,8 @@
 		       u_long heapsize,
 		       int memflags);
 
-int xnheap_destroy_mapped(xnheap_t *heap);
+int xnheap_destroy_mapped(xnheap_t *heap,
+			  void __user *mapaddr);
 
 #define xnheap_mapped_offset(heap,ptr) \
 (((caddr_t)(ptr)) - ((caddr_t)(heap)->archdep.heapbase))
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 4148)
+++ ChangeLog	(working copy)
@@ -1,3 +1,11 @@
+2008-09-08  Philippe Gerum  <rpm@xenomai.org>
+
+	* ksrc/nucleus/heap.c (xnheap_destroy_mapped): Handle last
+	unmapping in heap deletion routine.
+
+	* ksrc/native/{queue.c, heap.c}: Fix spurious -EBUSY upon
+	deletion calls.
+
 2008-08-27  Philippe Gerum  <rpm@xenomai.org>
 
 	* ksrc/skins/vxworks/syscalls.c: Fix taskNametoId() wrapper, so
Index: src/skins/native/heap.c
===================================================================
--- src/skins/native/heap.c	(revision 4147)
+++ src/skins/native/heap.c	(working copy)
@@ -81,6 +81,7 @@
 		/* If the mapping fails, make sure we don't leave a dandling
 		   heap in kernel space -- remove it. */
 		XENOMAI_SKINCALL1(__native_muxid, __native_heap_delete, &ph);
+
 	return err;
 }
 
@@ -117,14 +118,11 @@
 	if (err)
 		return err;
 
-	if (__real_munmap(heap->mapbase, heap->mapsize))
-		err = -errno;
-
 	heap->opaque = XN_NO_HANDLE;
 	heap->mapbase = NULL;
 	heap->mapsize = 0;
 
-	return err;
+	return 0;
 }
 
 int rt_heap_alloc(RT_HEAP *heap, size_t size, RTIME timeout, void **bufp)
Index: src/skins/native/queue.c
===================================================================
--- src/skins/native/queue.c	(revision 4147)
+++ src/skins/native/queue.c	(working copy)
@@ -118,14 +118,11 @@
 	if (err)
 		return err;
 
-	if (__real_munmap(q->mapbase, q->mapsize))
-		err = -errno;
-
 	q->opaque = XN_NO_HANDLE;
 	q->mapbase = NULL;
 	q->mapsize = 0;
 
-	return err;
+	return 0;
 }
 
 void *rt_queue_alloc(RT_QUEUE *q, size_t size)
Index: ksrc/skins/psos+/rn.c
===================================================================
--- ksrc/skins/psos+/rn.c	(revision 4147)
+++ ksrc/skins/psos+/rn.c	(working copy)
@@ -143,7 +143,7 @@
 #endif /* CONFIG_XENO_OPT_REGISTRY */
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	if (xnheap_mapped_p(&rn->heapbase))
-		xnheap_destroy_mapped(&rn->heapbase);
+		xnheap_destroy_mapped(&rn->heapbase, NULL);
 	else
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 		xnheap_destroy(&rn->heapbase, NULL, NULL);
Index: ksrc/skins/rtai/shm.c
===================================================================
--- ksrc/skins/rtai/shm.c	(revision 4147)
+++ ksrc/skins/rtai/shm.c	(working copy)
@@ -299,7 +299,7 @@
 				 * Can destroy_mapped suspend ?
 				 */
 #ifdef CONFIG_XENO_OPT_PERVASIVE
-				ret = xnheap_destroy_mapped(p->heap);
+				ret = xnheap_destroy_mapped(p->heap, NULL);
 #else /* !CONFIG_XENO_OPT_PERVASIVE */
 				ret =
 				    xnheap_destroy(p->heap,
@@ -357,10 +357,10 @@
 			if (p->heap == &kheap)
 				xnheap_free(&kheap, p->chunk);
 			else {
-				/* Should release lock here? Can destroy_mapped suspend ?
+				/* FIXME: MUST release lock here.
 				 */
 #ifdef CONFIG_XENO_OPT_PERVASIVE
-				xnheap_destroy_mapped(p->heap);
+				xnheap_destroy_mapped(p->heap, NULL);
 #else /* !CONFIG_XENO_OPT_PERVASIVE */
 				xnheap_destroy(p->heap, &__heap_flush_private,
 					       NULL);
Index: ksrc/skins/posix/shm.c
===================================================================
--- ksrc/skins/posix/shm.c	(revision 4147)
+++ ksrc/skins/posix/shm.c	(working copy)
@@ -112,7 +112,7 @@
 		xnheap_free(&shm->heapbase, shm->addr);
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
-		xnheap_destroy_mapped(&shm->heapbase);
+		xnheap_destroy_mapped(&shm->heapbase, NULL);
 #else /* !CONFIG_XENO_OPT_PERVASIVE. */
 		xnheap_destroy(&shm->heapbase, &pse51_free_heap_extent, NULL);
 #endif /* !CONFIG_XENO_OPT_PERVASIVE. */
@@ -531,7 +531,7 @@
 
 			xnheap_free(&shm->heapbase, shm->addr);
 #ifdef CONFIG_XENO_OPT_PERVASIVE
-			xnheap_destroy_mapped(&shm->heapbase);
+			xnheap_destroy_mapped(&shm->heapbase, NULL);
 #else /* !CONFIG_XENO_OPT_PERVASIVE. */
 			xnheap_destroy(&shm->heapbase, &pse51_free_heap_extent,
 				       NULL);
Index: ksrc/skins/vrtx/syscall.c
===================================================================
--- ksrc/skins/vrtx/syscall.c	(revision 4147)
+++ ksrc/skins/vrtx/syscall.c	(working copy)
@@ -1182,7 +1182,7 @@
 
 unmap_pt:
 
-	xnheap_destroy_mapped(ptheap);
+	xnheap_destroy_mapped(ptheap, NULL);
 
 free_heap:
 
Index: ksrc/skins/vrtx/heap.c
===================================================================
--- ksrc/skins/vrtx/heap.c	(revision 4147)
+++ ksrc/skins/vrtx/heap.c	(working copy)
@@ -86,7 +86,7 @@
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	if (xnheap_mapped_p(&heap->sysheap))
-		xnheap_destroy_mapped(&heap->sysheap);
+		xnheap_destroy_mapped(&heap->sysheap, NULL);
 	else
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 		xnheap_destroy(&heap->sysheap, NULL, NULL);
Index: ksrc/skins/vrtx/pt.c
===================================================================
--- ksrc/skins/vrtx/pt.c	(revision 4147)
+++ ksrc/skins/vrtx/pt.c	(working copy)
@@ -85,7 +85,7 @@
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	if (pt->sysheap) {
-		xnheap_destroy_mapped(pt->sysheap);
+		xnheap_destroy_mapped(pt->sysheap, NULL);
 		xnfree(pt->sysheap);
 	}
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
Index: ksrc/skins/native/syscall.c
===================================================================
--- ksrc/skins/native/syscall.c	(revision 4147)
+++ ksrc/skins/native/syscall.c	(working copy)
@@ -2140,8 +2140,8 @@
 	if (!q)
 		err = -ESRCH;
 	else {
-		err = rt_queue_delete(q);	/* Callee will check the queue
-						   descriptor for validity again. */
+		/* Callee will check the queue descriptor for validity again. */
+		err = rt_queue_delete_inner(q, (void __user *)ph.mapbase);
 		if (!err && q->cpid)
 			xnfree(q);
 	}
@@ -2668,8 +2668,8 @@
 	if (!heap)
 		err = -ESRCH;
 	else {
-		err = rt_heap_delete(heap);	/* Callee will check the heap
-						   descriptor for validity again. */
+		/* Callee will check the heap descriptor for validity again. */
+		err = rt_heap_delete_inner(heap, (void __user *)ph.mapbase);
 		if (!err && heap->cpid)
 			xnfree(heap);
 	}
Index: ksrc/skins/native/heap.c
===================================================================
--- ksrc/skins/native/heap.c	(revision 4147)
+++ ksrc/skins/native/heap.c	(working copy)
@@ -366,7 +366,7 @@
  * Rescheduling: possible.
  */
 
-int rt_heap_delete(RT_HEAP *heap)
+int rt_heap_delete_inner(RT_HEAP *heap, void __user *mapaddr)
 {
 	int err = 0;
 	spl_t s;
@@ -392,14 +392,16 @@
 
 	xnlock_put_irqrestore(&nklock, s);
 
-	/* The heap descriptor has been marked as deleted before we
-	   released the superlock thus preventing any sucessful subsequent
-	   calls of rt_heap_delete(), so now we can actually destroy
-	   it safely. */
+	/*
+	 * The heap descriptor has been marked as deleted before we
+	 * released the superlock thus preventing any sucessful
+	 * subsequent calls of rt_heap_delete(), so now we can
+	 * actually destroy it safely.
+	 */
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	if (heap->mode & H_MAPPABLE)
-		err = xnheap_destroy_mapped(&heap->heap_base);
+		err = xnheap_destroy_mapped(&heap->heap_base, mapaddr);
 	else
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 		err = xnheap_destroy(&heap->heap_base, &__heap_flush_private, NULL);
@@ -429,6 +431,11 @@
 	return err;
 }
 
+int rt_heap_delete(RT_HEAP *heap)
+{
+	return rt_heap_delete_inner(heap, NULL);
+}
+
 /**
  * @fn int rt_heap_alloc(RT_HEAP *heap,size_t size,RTIME timeout,void **blockp)
  *
Index: ksrc/skins/native/queue.c
===================================================================
--- ksrc/skins/native/queue.c	(revision 4147)
+++ ksrc/skins/native/queue.c	(working copy)
@@ -328,7 +328,7 @@
  * Rescheduling: possible.
  */
 
-int rt_queue_delete(RT_QUEUE *q)
+int rt_queue_delete_inner(RT_QUEUE *q, void __user *mapaddr)
 {
 	int err = 0;
 	spl_t s;
@@ -353,14 +353,16 @@
 
 	xnlock_put_irqrestore(&nklock, s);
 
-	/* The queue descriptor has been marked as deleted before we
-	   released the superlock thus preventing any sucessful subsequent
-	   calls of rt_queue_delete(), so now we can actually destroy the
-	   associated heap safely. */
+	/*
+	 * The queue descriptor has been marked as deleted before we
+	 * released the superlock thus preventing any sucessful
+	 * subsequent calls of rt_queue_delete(), so now we can
+	 * actually destroy the associated heap safely.
+	 */
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	if (q->mode & Q_SHARED)
-		err = xnheap_destroy_mapped(&q->bufpool);
+		err = xnheap_destroy_mapped(&q->bufpool, mapaddr);
 	else
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 		err = xnheap_destroy(&q->bufpool, &__queue_flush_private, NULL);
@@ -390,6 +392,11 @@
 	return err;
 }
 
+int rt_queue_delete(RT_QUEUE *q)
+{
+	return rt_queue_delete_inner(q, NULL);
+}
+
 /**
  * @fn void *rt_queue_alloc(RT_QUEUE *q,size_t size)
  *
Index: ksrc/nucleus/heap.c
===================================================================
--- ksrc/nucleus/heap.c	(revision 4147)
+++ ksrc/nucleus/heap.c	(working copy)
@@ -953,7 +953,7 @@
 
 static void xnheap_vmclose(struct vm_area_struct *vma)
 {
-	xnheap_t *heap = (xnheap_t *)vma->vm_private_data;
+	xnheap_t *heap = vma->vm_private_data;
 	atomic_dec(&heap->archdep.numaps);
 }
 
@@ -967,28 +967,14 @@
 	return 0;
 }
 
-static int xnheap_release(struct inode *inode, struct file *file)
-{
-	xnheap_t *heap = (xnheap_t *)file->private_data;
-
-	/* Careful: the ioctl() binding might have not been issued. */
-
-	if (heap != NULL)
-		atomic_dec(&heap->archdep.numaps);
-
-	return 0;
-}
-
 static inline xnheap_t *__validate_heap_addr(void *addr)
 {
 	xnholder_t *holder;
 
-	/* Not time critical and seldomly called, so O(N) is ok here. */
-
 	for (holder = getheadq(&kheapq); holder;
 	     holder = nextq(&kheapq, holder))
-		if (link2heap(holder) == (xnheap_t *)addr)
-			return (xnheap_t *)addr;
+		if (link2heap(holder) == addr)
+			return addr;
 
 	return NULL;
 }
@@ -1009,7 +995,6 @@
 		goto unlock_and_exit;
 	}
 
-	atomic_inc(&heap->archdep.numaps);	/* Paired with xnheap_release() */
 	file->private_data = heap;
 
       unlock_and_exit:
@@ -1120,7 +1105,6 @@
 static struct file_operations xnheap_fops = {
 	.owner = THIS_MODULE,
 	.open = &xnheap_open,
-	.release = &xnheap_release,
 	.ioctl = &xnheap_ioctl,
 	.mmap = &xnheap_mmap
 };
@@ -1249,12 +1233,10 @@
 		return -EINVAL;
 
 	heapbase = __alloc_and_reserve_heap(heapsize, memflags);
-
 	if (!heapbase)
 		return -ENOMEM;
 
 	err = xnheap_init(heap, heapbase, heapsize, PAGE_SIZE);
-
 	if (err) {
 		__unreserve_and_free_heap(heapbase, heapsize, memflags);
 		return err;
@@ -1270,13 +1252,17 @@
 	return 0;
 }
 
-int xnheap_destroy_mapped(xnheap_t *heap)
+int xnheap_destroy_mapped(xnheap_t *heap, void __user *mapaddr)
 {
+	int err = 0, ccheck;
+	unsigned long len;
 	spl_t s;
 
+	ccheck = mapaddr ? 1 : 0;
+
 	xnlock_get_irqsave(&nklock, s);
 
-	if (atomic_read(&heap->archdep.numaps) > 0) {
+	if (atomic_read(&heap->archdep.numaps) > ccheck) {
 		xnlock_put_irqrestore(&nklock, s);
 		return -EBUSY;
 	}
@@ -1286,9 +1272,17 @@
 
 	xnlock_put_irqrestore(&nklock, s);
 
-	__unreserve_and_free_heap(heap->archdep.heapbase,
-				  xnheap_extentsize(heap), heap->archdep.kmflags);
-	return 0;
+	len = xnheap_extentsize(heap);
+
+	if (mapaddr) {
+		down_write(&current->mm->mmap_sem);
+		err = do_munmap(current->mm, (unsigned long)mapaddr, len);
+		up_write(&current->mm->mmap_sem);
+	}
+	if (err == 0)
+		__unreserve_and_free_heap(heap->archdep.heapbase,
+					  len, heap->archdep.kmflags);
+	return err;
 }
 
 EXPORT_SYMBOL(xnheap_init_mapped);

--------------050102010805090502060803--


