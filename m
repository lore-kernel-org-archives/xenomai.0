Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4ADDA26D.9040903@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue, 20 Oct 2009 13:37:25 +0200
Message-ID: <20091020113725.9069.63679.stgit@domain.hid>
In-Reply-To: <20091020113724.9069.23594.stgit@domain.hid>
References: <20091020113724.9069.23594.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v3 4/9] nucleus: xnheap_destroy does not fail
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

There is no error returned by xnheap_destroy. So drop its return value
and update all callers.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/nucleus/heap.h    |   12 ++++++------
 ksrc/nucleus/heap.c       |   17 +++++++----------
 ksrc/skins/native/heap.c  |    2 +-
 ksrc/skins/native/queue.c |    2 +-
 ksrc/skins/rtai/shm.c     |    5 ++---
 5 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/include/nucleus/heap.h b/include/nucleus/heap.h
index f39ef64..ca691bf 100644
--- a/include/nucleus/heap.h
+++ b/include/nucleus/heap.h
@@ -226,12 +226,12 @@ int xnheap_init(xnheap_t *heap,
 		u_long heapsize,
 		u_long pagesize);
 
-int xnheap_destroy(xnheap_t *heap,
-		   void (*flushfn)(xnheap_t *heap,
-				   void *extaddr,
-				   u_long extsize,
-				   void *cookie),
-		   void *cookie);
+void xnheap_destroy(xnheap_t *heap,
+		    void (*flushfn)(xnheap_t *heap,
+				    void *extaddr,
+				    u_long extsize,
+				    void *cookie),
+		    void *cookie);
 
 int xnheap_extend(xnheap_t *heap,
 		  void *extaddr,
diff --git a/ksrc/nucleus/heap.c b/ksrc/nucleus/heap.c
index 0a9bfdf..4958daa 100644
--- a/ksrc/nucleus/heap.c
+++ b/ksrc/nucleus/heap.c
@@ -253,9 +253,6 @@ EXPORT_SYMBOL_GPL(xnheap_init);
  * @param cookie If @a flushfn is non-NULL, @a cookie is an opaque
  * pointer which will be passed unmodified to @a flushfn.
  *
- * @return 0 is returned on success, or -EBUSY if external mappings
- * are still pending on the heap memory.
- *
  * Environments:
  *
  * This service can be called from:
@@ -267,16 +264,17 @@ EXPORT_SYMBOL_GPL(xnheap_init);
  * Rescheduling: never.
  */
 
-int xnheap_destroy(xnheap_t *heap,
-		   void (*flushfn) (xnheap_t *heap,
+void xnheap_destroy(xnheap_t *heap,
+		    void (*flushfn)(xnheap_t *heap,
 				    void *extaddr,
-				    u_long extsize, void *cookie), void *cookie)
+				    u_long extsize, void *cookie),
+		    void *cookie)
 {
 	xnholder_t *holder;
 	spl_t s;
 
 	if (!flushfn)
-		return 0;
+		return;
 
 	xnlock_get_irqsave(&heap->lock, s);
 
@@ -287,8 +285,6 @@ int xnheap_destroy(xnheap_t *heap,
 	}
 
 	xnlock_put_irqrestore(&heap->lock, s);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(xnheap_destroy);
 
@@ -1267,7 +1263,8 @@ int xnheap_init_mapped(xnheap_t *heap, u_long heapsize, int memflags)
 int xnheap_destroy_mapped(xnheap_t *heap, void (*release)(struct xnheap *heap),
 			  void __user *mapaddr)
 {
-	return xnheap_destroy(heap, &xnheap_free_extent, NULL);
+	xnheap_destroy(heap, &xnheap_free_extent, NULL);
+	return 0;
 }
 #endif /* !CONFIG_XENO_OPT_PERVASIVE */
 
diff --git a/ksrc/skins/native/heap.c b/ksrc/skins/native/heap.c
index 9c3810c..0d7ad83 100644
--- a/ksrc/skins/native/heap.c
+++ b/ksrc/skins/native/heap.c
@@ -416,7 +416,7 @@ int rt_heap_delete_inner(RT_HEAP *heap, void __user *mapaddr)
 					    __heap_post_release, mapaddr);
 	else
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
-		err = xnheap_destroy(&heap->heap_base, &__heap_flush_private, NULL);
+		xnheap_destroy(&heap->heap_base, &__heap_flush_private, NULL);
 
 	xnlock_get_irqsave(&nklock, s);
 
diff --git a/ksrc/skins/native/queue.c b/ksrc/skins/native/queue.c
index 527bde8..f913675 100644
--- a/ksrc/skins/native/queue.c
+++ b/ksrc/skins/native/queue.c
@@ -377,7 +377,7 @@ int rt_queue_delete_inner(RT_QUEUE *q, void __user *mapaddr)
 					    __queue_post_release, mapaddr);
 	else
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
-		err = xnheap_destroy(&q->bufpool, &__queue_flush_private, NULL);
+		xnheap_destroy(&q->bufpool, &__queue_flush_private, NULL);
 
 	xnlock_get_irqsave(&nklock, s);
 
diff --git a/ksrc/skins/rtai/shm.c b/ksrc/skins/rtai/shm.c
index 81de434..fddf455 100644
--- a/ksrc/skins/rtai/shm.c
+++ b/ksrc/skins/rtai/shm.c
@@ -295,9 +295,8 @@ static int _shm_free(unsigned long name)
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 				ret = xnheap_destroy_mapped(p->heap, NULL, NULL);
 #else /* !CONFIG_XENO_OPT_PERVASIVE */
-				ret =
-				    xnheap_destroy(p->heap,
-						   &__heap_flush_private, NULL);
+				xnheap_destroy(p->heap,
+					       &__heap_flush_private, NULL);
 #endif /* !CONFIG_XENO_OPT_PERVASIVE */
 				if (ret)
 					goto unlock_and_exit;


