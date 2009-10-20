Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4ADDA26D.5060105@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue, 20 Oct 2009 13:37:25 +0200
Message-ID: <20091020113725.9069.39805.stgit@domain.hid>
In-Reply-To: <20091020113724.9069.23594.stgit@domain.hid>
References: <20091020113724.9069.23594.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v3 2/9] nucleus: Use Linux spin lock for heap
	list management
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

No need for hard nklock protection of kheapq and the map counter, a
normal spin lock suffices as all users must run over the root thread
anyway.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/nucleus/heap.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/ksrc/nucleus/heap.c b/ksrc/nucleus/heap.c
index 9ca2591..9ba5227 100644
--- a/ksrc/nucleus/heap.c
+++ b/ksrc/nucleus/heap.c
@@ -951,8 +951,10 @@ EXPORT_SYMBOL_GPL(xnheap_check_block);
 #include <linux/device.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
+#include <linux/spinlock.h>
 
 static DEFINE_XNQUEUE(kheapq);	/* Shared heap queue. */
+static DEFINE_SPINLOCK(kheapq_lock);
 
 static inline void *__alloc_and_reserve_heap(size_t size, int kmflags)
 {
@@ -1022,14 +1024,13 @@ static void __unreserve_and_free_heap(void *ptr, size_t size, int kmflags)
 static void xnheap_vmclose(struct vm_area_struct *vma)
 {
 	xnheap_t *heap = vma->vm_private_data;
-	spl_t s;
 
-	xnlock_get_irqsave(&nklock, s);
+	spin_lock(&kheapq_lock);
 
 	if (atomic_dec_and_test(&heap->archdep.numaps)) {
 		if (heap->archdep.release) {
 			removeq(&kheapq, &heap->link);
-			xnlock_put_irqrestore(&nklock, s);
+			spin_unlock(&kheapq_lock);
 			__unreserve_and_free_heap(heap->archdep.heapbase,
 						  xnheap_extentsize(heap),
 						  heap->archdep.kmflags);
@@ -1038,7 +1039,7 @@ static void xnheap_vmclose(struct vm_area_struct *vma)
 		}
 	}
 
-	xnlock_put_irqrestore(&nklock, s);
+	spin_unlock(&kheapq_lock);
 }
 
 static struct vm_operations_struct xnheap_vmops = {
@@ -1068,9 +1069,8 @@ static int xnheap_ioctl(struct inode *inode,
 {
 	xnheap_t *heap;
 	int err = 0;
-	spl_t s;
 
-	xnlock_get_irqsave(&nklock, s);
+	spin_lock(&kheapq_lock);
 
 	heap = __validate_heap_addr((void *)arg);
 
@@ -1083,7 +1083,7 @@ static int xnheap_ioctl(struct inode *inode,
 
       unlock_and_exit:
 
-	xnlock_put_irqrestore(&nklock, s);
+	spin_unlock(&kheapq_lock);
 
 	return err;
 }
@@ -1148,7 +1148,6 @@ static int xnheap_mmap(struct file *file, struct vm_area_struct *vma)
 int xnheap_init_mapped(xnheap_t *heap, u_long heapsize, int memflags)
 {
 	void *heapbase;
-	spl_t s;
 	int err;
 
 	/* Caller must have accounted for internal overhead. */
@@ -1172,9 +1171,9 @@ int xnheap_init_mapped(xnheap_t *heap, u_long heapsize, int memflags)
 	heap->archdep.heapbase = heapbase;
 	heap->archdep.release = NULL;
 
-	xnlock_get_irqsave(&nklock, s);
+	spin_lock(&kheapq_lock);
 	appendq(&kheapq, &heap->link);
-	xnlock_put_irqrestore(&nklock, s);
+	spin_unlock(&kheapq_lock);
 
 	return 0;
 }
@@ -1184,20 +1183,19 @@ int xnheap_destroy_mapped(xnheap_t *heap, void (*release)(struct xnheap *heap),
 {
 	int ret = 0, ccheck;
 	unsigned long len;
-	spl_t s;
 
 	ccheck = mapaddr ? 1 : 0;
 
-	xnlock_get_irqsave(&nklock, s);
+	spin_lock(&kheapq_lock);
 
 	if (atomic_read(&heap->archdep.numaps) > ccheck) {
 		heap->archdep.release = release;
-		xnlock_put_irqrestore(&nklock, s);
+		spin_unlock(&kheapq_lock);
 		return -EBUSY;
 	}
 
 	removeq(&kheapq, &heap->link); /* Prevent further mapping. */
-	xnlock_put_irqrestore(&nklock, s);
+	spin_unlock(&kheapq_lock);
 
 	len = xnheap_extentsize(heap);
 


