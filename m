Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4ADDA26D.6020000@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue, 20 Oct 2009 13:37:26 +0200
Message-ID: <20091020113726.9069.91437.stgit@domain.hid>
In-Reply-To: <20091020113724.9069.23594.stgit@domain.hid>
References: <20091020113724.9069.23594.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v3 8/9] native: Fix memory leak on heap/queue
	auto-deletion
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

We are currently leaking user space heap/queue objects when the owner
terminates without deleting them before. Fix it by releasing the objects
in the corresponding cleanup callbacks which are also called on owner
termination.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/skins/native/heap.c    |    5 +++++
 ksrc/skins/native/queue.c   |    5 +++++
 ksrc/skins/native/syscall.c |   25 ++++++-------------------
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/ksrc/skins/native/heap.c b/ksrc/skins/native/heap.c
index f7411e8..886758c 100644
--- a/ksrc/skins/native/heap.c
+++ b/ksrc/skins/native/heap.c
@@ -341,6 +341,11 @@ static void __heap_post_release(struct xnheap *h)
 		xnpod_schedule();
 
 	xnlock_put_irqrestore(&nklock, s);
+
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	if (heap->cpid)
+		xnfree(heap);
+#endif
 }
 
 /**
diff --git a/ksrc/skins/native/queue.c b/ksrc/skins/native/queue.c
index 3592a4a..249947a 100644
--- a/ksrc/skins/native/queue.c
+++ b/ksrc/skins/native/queue.c
@@ -303,6 +303,11 @@ static void __queue_post_release(struct xnheap *heap)
 		xnpod_schedule();
 
 	xnlock_put_irqrestore(&nklock, s);
+
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	if (q->cpid)
+		xnfree(q);
+#endif
 }
 
 /**
diff --git a/ksrc/skins/native/syscall.c b/ksrc/skins/native/syscall.c
index 28c720e..cb9f075 100644
--- a/ksrc/skins/native/syscall.c
+++ b/ksrc/skins/native/syscall.c
@@ -2073,24 +2073,17 @@ static int __rt_queue_delete(struct pt_regs *regs)
 {
 	RT_QUEUE_PLACEHOLDER ph;
 	RT_QUEUE *q;
-	int err;
 
 	if (__xn_safe_copy_from_user(&ph, (void __user *)__xn_reg_arg1(regs),
 				     sizeof(ph)))
 		return -EFAULT;
 
 	q = (RT_QUEUE *)xnregistry_fetch(ph.opaque);
-
 	if (!q)
-		err = -ESRCH;
-	else {
-		/* Callee will check the queue descriptor for validity again. */
-		err = rt_queue_delete_inner(q, (void __user *)ph.mapbase);
-		if (!err && q->cpid)
-			xnfree(q);
-	}
+		return -ESRCH;
 
-	return err;
+	/* Callee will check the queue descriptor for validity again. */
+	return rt_queue_delete_inner(q, (void __user *)ph.mapbase);
 }
 
 /*
@@ -2604,7 +2597,6 @@ static int __rt_heap_delete(struct pt_regs *regs)
 {
 	RT_HEAP_PLACEHOLDER ph;
 	RT_HEAP *heap;
-	int err;
 
 	if (__xn_safe_copy_from_user(&ph, (void __user *)__xn_reg_arg1(regs),
 				     sizeof(ph)))
@@ -2613,15 +2605,10 @@ static int __rt_heap_delete(struct pt_regs *regs)
 	heap = (RT_HEAP *)xnregistry_fetch(ph.opaque);
 
 	if (!heap)
-		err = -ESRCH;
-	else {
-		/* Callee will check the heap descriptor for validity again. */
-		err = rt_heap_delete_inner(heap, (void __user *)ph.mapbase);
-		if (!err && heap->cpid)
-			xnfree(heap);
-	}
+		return -ESRCH;
 
-	return err;
+	/* Callee will check the heap descriptor for validity again. */
+	return rt_heap_delete_inner(heap, (void __user *)ph.mapbase);
 }
 
 /*


