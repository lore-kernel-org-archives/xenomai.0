Message-ID: <4E0C439D.2030602@domain.hid>
Date: Thu, 30 Jun 2011 11:36:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 2/2] native: Fix error cleanup of
	rt_task_create
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

When creating of a shadow task fails, rt_task_create has to free the
task object consistently, not only on registry errors. Then we need to
delete the core thread when fastlock allocation failed. Moreover, fix a
double free of the fastlock object which is now released via the delete
hook. Finally, avoid a use-after-release of the fastlock object in
__task_delete_hook.

This fixes heap corruptions when running out of resources.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

Applies on top of xenomai-gch.git gch/u_mode

 ksrc/skins/native/syscall.c |    4 ++-
 ksrc/skins/native/task.c    |   44 ++++++++++++++++++++++++------------------
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/ksrc/skins/native/syscall.c b/ksrc/skins/native/syscall.c
index 17071da..b21705a 100644
--- a/ksrc/skins/native/syscall.c
+++ b/ksrc/skins/native/syscall.c
@@ -184,8 +184,10 @@ static int __rt_task_create(struct pt_regs *regs)
 	   the platform does not support it. */
 
 	err = rt_task_create(task, name, 0, prio, XNFPU | XNSHADOW | mode);
-	if (err)
+	if (err) {
+		task = NULL;
 		goto fail;
+	}
 
 	/* Apply CPU affinity */
 	set_cpus_allowed(p, task->affinity);
diff --git a/ksrc/skins/native/task.c b/ksrc/skins/native/task.c
index af62d56..c6e9a22 100644
--- a/ksrc/skins/native/task.c
+++ b/ksrc/skins/native/task.c
@@ -74,16 +74,14 @@ static void __task_delete_hook(xnthread_t *thread)
 
 	task = thread2rtask(thread);
 
-#if defined(CONFIG_XENO_OPT_NATIVE_MPS) && defined(CONFIG_XENO_FASTSYNCH)
-	xnheap_free(&xnsys_ppd_get(0)->sem_heap,
-		    task->msendq.fastlock);
-#endif
-
 #ifdef CONFIG_XENO_OPT_NATIVE_MPS
 	/* The nucleus will reschedule as needed when all the deletion
 	   hooks are done. */
 	xnsynch_destroy(&task->mrecv);
 	xnsynch_destroy(&task->msendq);
+#ifdef CONFIG_XENO_FASTSYNCH
+	xnheap_free(&xnsys_ppd_get(0)->sem_heap, task->msendq.fastlock);
+#endif
 #endif /* CONFIG_XENO_OPT_NATIVE_MPS */
 
 	xnsynch_destroy(&task->safesynch);
@@ -265,11 +263,15 @@ int rt_task_create(RT_TASK *task,
 	xnflags_t bflags;
 	spl_t s;
 
-	if (prio < T_LOPRIO || prio > T_HIPRIO)
-		return -EINVAL;
+	if (prio < T_LOPRIO || prio > T_HIPRIO) {
+		err = -EINVAL;
+		goto fail;
+	}
 
-	if (xnpod_asynch_p())
-		return -EPERM;
+	if (xnpod_asynch_p()) {
+		err = -EPERM;
+		goto fail;
+	}
 
 	bflags = mode & (XNFPU | XNSHADOW | XNSUSP);
 
@@ -283,10 +285,10 @@ int rt_task_create(RT_TASK *task,
 	attr.stacksize = stksize;
 	param.rt.prio = prio;
 
-	if (xnpod_init_thread(&task->thread_base,
-			      &attr, &xnsched_class_rt, &param) != 0)
-		/* Assume this is the only possible failure. */
-		return -ENOMEM;
+	err = xnpod_init_thread(&task->thread_base, &attr, &xnsched_class_rt,
+				&param);
+	if (err)
+		goto fail;
 
 	inith(&task->link);
 	task->suspend_depth = (bflags & XNSUSP) ? 1 : 0;
@@ -310,8 +312,10 @@ int rt_task_create(RT_TASK *task,
 	/* Allocate lock memory for in-kernel use */
 	fastlock = xnheap_alloc(&xnsys_ppd_get(0)->sem_heap,
 				sizeof(*fastlock));
-	if (fastlock == NULL)
+	if (fastlock == NULL) {
+		xnpod_delete_thread(&task->thread_base);
 		return -ENOMEM;
+	}
 #endif /* CONFIG_XENO_FASTSYNCH */
 	xnsynch_init(&task->mrecv, XNSYNCH_FIFO, NULL);
 	/*
@@ -333,18 +337,20 @@ int rt_task_create(RT_TASK *task,
 	   half-baked objects... */
 
 	err = xnthread_register(&task->thread_base, name ? task->rname : "");
-	if (err) {
-#if defined(CONFIG_XENO_OPT_NATIVE_MPS) && defined(CONFIG_XENO_FASTSYNCH)
-		xnheap_free(&xnsys_ppd_get(0)->sem_heap, fastlock);
-#endif
+	if (err)
 		xnpod_delete_thread(&task->thread_base);
-	}
 #if defined(CONFIG_XENO_OPT_NATIVE_MPS) && defined(CONFIG_XENO_FASTSYNCH)
 	else
 		xnsynch_fast_acquire(fastlock, xnthread_handle(&task->thread_base));
 #endif
 
 	return err;
+
+      fail:
+	if (xnthread_test_state(&task->thread_base, XNSHADOW))
+		xnfree(task);
+
+	return err;
 }
 
 /**
-- 
1.7.1

