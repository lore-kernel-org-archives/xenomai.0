Message-ID: <4399C536.2010709@domain.hid>
Date: Fri, 09 Dec 2005 18:56:06 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050301080008070005090508"
Subject: [Xenomai-core] [PATCH] rt_task_join
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------050301080008070005090508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

this is a cleaned up and documented version of my rt_task_join proposal.
 Please apply.

Jan


--------------050301080008070005090508
Content-Type: text/plain;
 name="rt_task_join.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt_task_join.patch"

Index: include/native/task.h
===================================================================
--- include/native/task.h	(revision 245)
+++ include/native/task.h	(working copy)
@@ -35,18 +35,19 @@
 #define T_CPUMASK  0xff000000
 
 /* Status/mode flags. */
-#define T_BLOCKED XNPEND
-#define T_DELAYED XNDELAY
-#define T_READY   XNREADY
-#define T_DORMANT XNDORMANT
-#define T_STARTED XNSTARTED
-#define T_BOOST   XNBOOST
-#define T_LOCK    XNLOCK
-#define T_RRB     XNRRB
-#define T_NOSIG   XNASDI
-#define T_SHIELD  XNSHIELD
-#define T_WARNSW  XNTRAPSW
-#define T_PRIMARY XNTHREAD_SPARE0
+#define T_BLOCKED  XNPEND
+#define T_DELAYED  XNDELAY
+#define T_READY    XNREADY
+#define T_DORMANT  XNDORMANT
+#define T_STARTED  XNSTARTED
+#define T_BOOST    XNBOOST
+#define T_LOCK     XNLOCK
+#define T_RRB      XNRRB
+#define T_NOSIG    XNASDI
+#define T_SHIELD   XNSHIELD
+#define T_WARNSW   XNTRAPSW
+#define T_PRIMARY  XNTHREAD_SPARE0
+#define T_JOINABLE XNTHREAD_SPARE1
 
 /* Task hook types. */
 #define T_HOOK_START  XNHOOK_THREAD_START
@@ -206,6 +207,8 @@
     return 0;
 }
 
+int rt_task_join(RT_TASK *task);
+
 #ifdef __cplusplus
 }
 #endif
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 245)
+++ ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2005-12-09  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* src/skins/native/task.c, include/native/task.h: Add rt_task_join()
+	and the related T_JOINABLE mode flag.
+
 2005-12-05  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
 
 	* configure.in, doc/doxygen/Doxyfile.in: Fix compilation of
Index: src/skins/native/task.c
===================================================================
--- src/skins/native/task.c	(revision 245)
+++ src/skins/native/task.c	(working copy)
@@ -127,7 +127,8 @@
 	stksize = PTHREAD_STACK_MIN;
 
     pthread_attr_setstacksize(&thattr,stksize);
-    pthread_attr_setdetachstate(&thattr,PTHREAD_CREATE_DETACHED);
+    if (!(mode & T_JOINABLE))
+	pthread_attr_setdetachstate(&thattr,PTHREAD_CREATE_DETACHED);
     pthread_attr_setschedpolicy(&thattr,SCHED_FIFO);
     param.sched_priority = sched_get_priority_max(SCHED_FIFO);
     pthread_attr_setschedparam(&thattr,&param);
@@ -331,6 +332,11 @@
 			     &quantum);
 }
 
+int rt_task_join (RT_TASK *task)
+{
+    return -pthread_join((pthread_t)task->opaque2, NULL);
+}
+
 #ifdef CONFIG_XENO_OPT_NATIVE_MPS
 
 ssize_t rt_task_send (RT_TASK *task,
Index: ksrc/skins/native/task.c
===================================================================
--- ksrc/skins/native/task.c	(revision 245)
+++ ksrc/skins/native/task.c	(working copy)
@@ -136,6 +136,11 @@
  * - T_CPU(cpuid) makes the new task affine to CPU # @b cpuid. CPU
  * identifiers range from 0 to RTHAL_NR_CPUS - 1 (inclusive).
  *
+ * - T_JOINABLE (user-space only) allows another task to wait on the
+ * termination of the new task. This implies that rt_task_join() is
+ * actually called for this task to clean up any user-space located
+ * resources after its termination.
+ *
  * Passing T_FPU|T_CPU(1) in the @a mode parameter thus creates a task
  * with FPU support enabled and which will be affine to CPU #1.
  *
@@ -2267,6 +2272,31 @@
  * Rescheduling: never.
  */
 
+/**
+ * @fn int rt_task_join(RT_TASK *task)
+ *
+ * @brief Wait on the termination of a real-time task.
+ *
+ * This user-space only service blocks the caller in non-real-time context
+ * until @a task has terminated. Note that the specified task must have
+ * been created with the T_JOINABLE mode flag set.
+ *
+ * @param task The address of a task descriptor to join.
+ *
+ * @return 0 is returned upon success. Otherwise:
+ *
+ * - -EINVAL is returned if the task was not created with T_JOINABLE set or
+ * some other task is already waiting on the termination.
+ *
+ * - -EDEADLK is returned if @a task refers to the caller.
+ *
+ * This service can be called from:
+ *
+ * - User-space task.
+ *
+ * Rescheduling: always unless the task was already terminated.
+ */
+
 /*@}*/
 
 EXPORT_SYMBOL(rt_task_create);

--------------050301080008070005090508--

