Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4ADDA26D.80903@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue, 20 Oct 2009 13:37:25 +0200
Message-ID: <20091020113725.9069.28060.stgit@domain.hid>
In-Reply-To: <20091020113724.9069.23594.stgit@domain.hid>
References: <20091020113724.9069.23594.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v3 5/9] nucleus: Avoid returning errors
	from	xnheap_destroy_mapped
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

Allowing xnheap_delete_mapped to return an error and then attempting to
recover from it does not work out very well: Corner cases are racy,
intransparent to the user, and proper error handling imposes a lot of
complexity on the caller - if it actually bothers to check the return
value...

Fortunately, there is no reason for this function to fail: If the heap
is still mapped, just install the provide cleanup handler and switch to
deferred removal. If the unmapping fails, we either raced with some
other caller of unmap or user space provided a bogus address, or
something else is wrong. In any case, leaving the cleanup callback
behind is the best we can do anyway.

Removing the return value immediately allows to simplify the callers,
namemly rt_queue_delete and rt_heap_delete.

Note: This is still not 100% waterproof. If we issue
xnheap_destroy_mapped from module cleanup passing a release handler
that belongs to the module text, deferred release will cause a crash.
But this corner case is no new regression, so let's keep the head in the
sand.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/nucleus/heap.h    |    6 +++---
 ksrc/nucleus/heap.c       |   45 +++++++++++++++++++++++++++------------------
 ksrc/skins/native/heap.c  |   21 ++++++---------------
 ksrc/skins/native/queue.c |   21 ++++++---------------
 ksrc/skins/rtai/shm.c     |    6 +-----
 5 files changed, 43 insertions(+), 56 deletions(-)

diff --git a/include/nucleus/heap.h b/include/nucleus/heap.h
index ca691bf..44db738 100644
--- a/include/nucleus/heap.h
+++ b/include/nucleus/heap.h
@@ -204,9 +204,9 @@ int xnheap_init_mapped(xnheap_t *heap,
 		       u_long heapsize,
 		       int memflags);
 
-int xnheap_destroy_mapped(xnheap_t *heap,
-			  void (*release)(struct xnheap *heap),
-			  void __user *mapaddr);
+void xnheap_destroy_mapped(xnheap_t *heap,
+			   void (*release)(struct xnheap *heap),
+			   void __user *mapaddr);
 
 #define xnheap_mapped_offset(heap,ptr) \
 (((caddr_t)(ptr)) - ((caddr_t)(heap)->archdep.heapbase))
diff --git a/ksrc/nucleus/heap.c b/ksrc/nucleus/heap.c
index 4958daa..96c46f8 100644
--- a/ksrc/nucleus/heap.c
+++ b/ksrc/nucleus/heap.c
@@ -1173,42 +1173,51 @@ int xnheap_init_mapped(xnheap_t *heap, u_long heapsize, int memflags)
 	return 0;
 }
 
-int xnheap_destroy_mapped(xnheap_t *heap, void (*release)(struct xnheap *heap),
-			  void __user *mapaddr)
+void xnheap_destroy_mapped(xnheap_t *heap,
+			   void (*release)(struct xnheap *heap),
+			   void __user *mapaddr)
 {
-	int ret = 0, ccheck;
 	unsigned long len;
 
-	ccheck = mapaddr ? 1 : 0;
+	/*
+	 * Trying to unmap user memory without providing a release handler for
+	 * deferred cleanup is a bug.
+	 */
+	XENO_ASSERT(NUCLEUS, !mapaddr || release, /* nop */);
 
 	spin_lock(&kheapq_lock);
 
-	if (heap->archdep.numaps > ccheck) {
-		heap->archdep.release = release;
-		spin_unlock(&kheapq_lock);
-		return -EBUSY;
-	}
-
 	removeq(&kheapq, &heap->link); /* Prevent further mapping. */
+
+	heap->archdep.release = release;
+
+	if (heap->archdep.numaps == 0)
+		mapaddr = NULL; /* nothing left to unmap */
+	else
+		release = NULL; /* will be called by Linux on unmap */
+
 	spin_unlock(&kheapq_lock);
 
 	len = xnheap_extentsize(heap);
 
 	if (mapaddr) {
 		down_write(&current->mm->mmap_sem);
-		heap->archdep.release = NULL;
-		ret = do_munmap(current->mm, (unsigned long)mapaddr, len);
+		do_munmap(current->mm, (unsigned long)mapaddr, len);
 		up_write(&current->mm->mmap_sem);
 	}
 
-	if (ret == 0) {
+	if (heap->archdep.numaps > 0) {
+		/* The release handler is supposed to clean up the rest. */
+		XENO_ASSERT(NUCLEUS, heap->archdep.release, /* nop */);
+		return;
+	}
+
+	if (!mapaddr) {
 		__unreserve_and_free_heap(heap->archdep.heapbase, len,
 					  heap->archdep.kmflags);
 		if (release)
 			release(heap);
 	}
-
-	return ret;
 }
 
 static struct file_operations xnheap_fops = {
@@ -1260,11 +1269,11 @@ int xnheap_init_mapped(xnheap_t *heap, u_long heapsize, int memflags)
 	return -ENOMEM;
 }
 
-int xnheap_destroy_mapped(xnheap_t *heap, void (*release)(struct xnheap *heap),
-			  void __user *mapaddr)
+void xnheap_destroy_mapped(xnheap_t *heap,
+			   void (*release)(struct xnheap *heap),
+			   void __user *mapaddr)
 {
 	xnheap_destroy(heap, &xnheap_free_extent, NULL);
-	return 0;
 }
 #endif /* !CONFIG_XENO_OPT_PERVASIVE */
 
diff --git a/ksrc/skins/native/heap.c b/ksrc/skins/native/heap.c
index 0d7ad83..f7411e8 100644
--- a/ksrc/skins/native/heap.c
+++ b/ksrc/skins/native/heap.c
@@ -357,9 +357,6 @@ static void __heap_post_release(struct xnheap *h)
  *
  * @return 0 is returned upon success. Otherwise:
  *
- * - -EBUSY is returned if @a heap is in use by another process and the
- * descriptor is not destroyed.
- *
  * - -EINVAL is returned if @a heap is not a heap descriptor.
  *
  * - -EIDRM is returned if @a heap is a deleted heap descriptor.
@@ -379,7 +376,7 @@ static void __heap_post_release(struct xnheap *h)
 
 int rt_heap_delete_inner(RT_HEAP *heap, void __user *mapaddr)
 {
-	int err = 0;
+	int err;
 	spl_t s;
 
 	if (!xnpod_root_p())
@@ -412,22 +409,16 @@ int rt_heap_delete_inner(RT_HEAP *heap, void __user *mapaddr)
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	if (heap->mode & H_MAPPABLE)
-		err = xnheap_destroy_mapped(&heap->heap_base,
-					    __heap_post_release, mapaddr);
+		xnheap_destroy_mapped(&heap->heap_base,
+				      __heap_post_release, mapaddr);
 	else
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
+	{
 		xnheap_destroy(&heap->heap_base, &__heap_flush_private, NULL);
-
-	xnlock_get_irqsave(&nklock, s);
-
-	if (err)
-		heap->magic = XENO_HEAP_MAGIC;
-	else if (!(heap->mode & H_MAPPABLE))
 		__heap_post_release(&heap->heap_base);
+	}
 
-	xnlock_put_irqrestore(&nklock, s);
-
-	return err;
+	return 0;
 }
 
 int rt_heap_delete(RT_HEAP *heap)
diff --git a/ksrc/skins/native/queue.c b/ksrc/skins/native/queue.c
index f913675..3592a4a 100644
--- a/ksrc/skins/native/queue.c
+++ b/ksrc/skins/native/queue.c
@@ -326,9 +326,6 @@ static void __queue_post_release(struct xnheap *heap)
  * - -EPERM is returned if this service was called from an
  * asynchronous context.
  *
- * - -EBUSY is returned if an attempt is made to delete a shared queue
- * which is still bound to a process.
- *
  * Environments:
  *
  * This service can be called from:
@@ -341,7 +338,7 @@ static void __queue_post_release(struct xnheap *heap)
 
 int rt_queue_delete_inner(RT_QUEUE *q, void __user *mapaddr)
 {
-	int err = 0;
+	int err;
 	spl_t s;
 
 	if (xnpod_asynch_p())
@@ -373,22 +370,16 @@ int rt_queue_delete_inner(RT_QUEUE *q, void __user *mapaddr)
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	if (q->mode & Q_SHARED)
-		err = xnheap_destroy_mapped(&q->bufpool,
-					    __queue_post_release, mapaddr);
+		xnheap_destroy_mapped(&q->bufpool,
+				      __queue_post_release, mapaddr);
 	else
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
+	{
 		xnheap_destroy(&q->bufpool, &__queue_flush_private, NULL);
-
-	xnlock_get_irqsave(&nklock, s);
-
-	if (err)
-		q->magic = XENO_QUEUE_MAGIC;
-	else if (!(q->mode & Q_SHARED))
 		__queue_post_release(&q->bufpool);
+	}
 
-	xnlock_put_irqrestore(&nklock, s);
-
-	return err;
+	return 0;
 }
 
 int rt_queue_delete(RT_QUEUE *q)
diff --git a/ksrc/skins/rtai/shm.c b/ksrc/skins/rtai/shm.c
index fddf455..4c56495 100644
--- a/ksrc/skins/rtai/shm.c
+++ b/ksrc/skins/rtai/shm.c
@@ -293,13 +293,11 @@ static int _shm_free(unsigned long name)
 				 * [YES!]
 				 */
 #ifdef CONFIG_XENO_OPT_PERVASIVE
-				ret = xnheap_destroy_mapped(p->heap, NULL, NULL);
+				xnheap_destroy_mapped(p->heap, NULL, NULL);
 #else /* !CONFIG_XENO_OPT_PERVASIVE */
 				xnheap_destroy(p->heap,
 					       &__heap_flush_private, NULL);
 #endif /* !CONFIG_XENO_OPT_PERVASIVE */
-				if (ret)
-					goto unlock_and_exit;
 				xnheap_free(&kheap, p->heap);
 			}
 			removeq(&xnshm_allocq, &p->link);
@@ -311,8 +309,6 @@ static int _shm_free(unsigned long name)
 		holder = nextq(&xnshm_allocq, holder);
 	}
 
-      unlock_and_exit:
-
 	xnlock_put_irqrestore(&nklock, s);
 
 	return ret;


