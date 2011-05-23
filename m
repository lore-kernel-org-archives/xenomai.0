Message-ID: <4DDA66CF.2010307@domain.hid>
Date: Mon, 23 May 2011 15:53:19 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL] native: Fix msendq fastlock leakage
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

The following changes since commit aec30a2543afa18fa7832deee85e187b0faeb1f0:

  xeno-test: fix reference to @XENO_TEST_DIR@ (2011-05-15 21:20:41 +0200)

are available in the git repository at:
  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (1):
      native: Fix msendq fastlock leakage

 include/native/task.h    |    5 +++++
 ksrc/skins/native/task.c |   13 ++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

------8<------

When a native task terminates without going through rt_task_delete, we
leaked the fastlock so far. Fix it by moving the release into the delete
hook. As the ppd is already invalid at that point, we have to save the
heap address in the task data structure.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/native/task.h    |    5 +++++
 ksrc/skins/native/task.c |   13 ++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/native/task.h b/include/native/task.h
index 519aaec..0d44ccf 100644
--- a/include/native/task.h
+++ b/include/native/task.h
@@ -22,6 +22,7 @@
 #ifndef _XENO_TASK_H
 #define _XENO_TASK_H
 
+#include <nucleus/heap.h>
 #include <nucleus/sched.h>
 #include <native/types.h>
 
@@ -166,6 +167,10 @@ typedef struct rt_task {
     xnsynch_t mrecv,
 	      msendq;
 
+#ifdef CONFIG_XENO_FASTSYNCH
+	xnheap_t *msendq_fastlock_heap;
+#endif /* CONFIG_XENO_FASTSYNCH */
+
     int flowgen;		/* !< Flow id. generator. */
 #endif /* CONFIG_XENO_OPT_NATIVE_MPS */
 
diff --git a/ksrc/skins/native/task.c b/ksrc/skins/native/task.c
index 1192509..6970363 100644
--- a/ksrc/skins/native/task.c
+++ b/ksrc/skins/native/task.c
@@ -79,6 +79,9 @@ static void __task_delete_hook(xnthread_t *thread)
 	   hooks are done. */
 	xnsynch_destroy(&task->mrecv);
 	xnsynch_destroy(&task->msendq);
+#ifdef CONFIG_XENO_FASTSYNCH
+	xnheap_free(task->msendq_fastlock_heap, task->msendq.fastlock);
+#endif /* CONFIG_XENO_FASTSYNCH */
 #endif /* CONFIG_XENO_OPT_NATIVE_MPS */
 
 	xnsynch_destroy(&task->safesynch);
@@ -301,7 +304,8 @@ int rt_task_create(RT_TASK *task,
 #ifdef CONFIG_XENO_OPT_NATIVE_MPS
 #ifdef CONFIG_XENO_FASTSYNCH
 	/* Allocate lock memory for in-kernel use */
-	fastlock = xnheap_alloc(&xnsys_ppd_get(0)->sem_heap,
+	task->msendq_fastlock_heap = &xnsys_ppd_get(0)->sem_heap;
+	fastlock = xnheap_alloc(task->msendq_fastlock_heap,
 				sizeof(*fastlock));
 	if (fastlock == NULL)
 		return -ENOMEM;
@@ -328,7 +332,7 @@ int rt_task_create(RT_TASK *task,
 	err = xnthread_register(&task->thread_base, name ? task->rname : "");
 	if (err) {
 #if defined(CONFIG_XENO_OPT_NATIVE_MPS) && defined(CONFIG_XENO_FASTSYNCH)
-		xnheap_free(&xnsys_ppd_get(0)->sem_heap, fastlock);
+		xnheap_free(task->msendq_fastlock_heap, fastlock);
 #endif
 		xnpod_delete_thread(&task->thread_base);
 	} else
@@ -640,11 +644,6 @@ int rt_task_delete(RT_TASK *task)
 	if (err)
 		goto unlock_and_exit;
 
-#if defined(CONFIG_XENO_OPT_NATIVE_MPS) && defined(CONFIG_XENO_FASTSYNCH)
-	xnheap_free(&xnsys_ppd_get(0)->sem_heap,
-		    task->msendq.fastlock);
-#endif
-
 	/* Does not return if task is current. */
 	xnpod_delete_thread(&task->thread_base);
 
-- 
1.7.1

