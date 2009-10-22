Message-ID: <4AE03436.8020809@domain.hid>
Date: Thu, 22 Oct 2009 12:30:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20091020113724.9069.23594.stgit@domain.hid>
	<20091020113726.9069.91437.stgit@domain.hid>
In-Reply-To: <20091020113726.9069.91437.stgit@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] native: Avoid double release on queue/heap
	auto-cleanup
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> We are currently leaking user space heap/queue objects when the owner
> terminates without deleting them before. Fix it by releasing the objects
> in the corresponding cleanup callbacks which are also called on owner
> termination.

Just realized that we need this patch in addition:

------------>

Commit 3a7330b164 also requires this patch to avoid that the queue and
heap objects are released twice on automatic cleanup (via the xnheap
release handler and via the ppd object queue flush).

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/native/heap.h  |    2 +-
 include/native/queue.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/native/heap.h b/include/native/heap.h
index 5444a43..0c2a7a2 100644
--- a/include/native/heap.h
+++ b/include/native/heap.h
@@ -117,7 +117,7 @@ void __native_heap_pkg_cleanup(void);
 
 static inline void __native_heap_flush_rq(xnqueue_t *rq)
 {
-	xeno_flush_rq(RT_HEAP, rq, heap);
+	xeno_flush_rq_norelease(RT_HEAP, rq, heap);
 }
 
 int rt_heap_delete_inner(RT_HEAP *heap,
diff --git a/include/native/queue.h b/include/native/queue.h
index 77925c2..2951c42 100644
--- a/include/native/queue.h
+++ b/include/native/queue.h
@@ -129,7 +129,7 @@ void __native_queue_pkg_cleanup(void);
 
 static inline void __native_queue_flush_rq(xnqueue_t *rq)
 {
-	xeno_flush_rq(RT_QUEUE, rq, queue);
+	xeno_flush_rq_norelease(RT_QUEUE, rq, queue);
 }
 
 ssize_t rt_queue_receive_inner(RT_QUEUE *q, void **bufp,

