Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48F764A5.4040303@domain.hid>
Message-Id: <20081016154620.523981771@domain.hid>
Date: Thu, 16 Oct 2008 17:46:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
References: <20081016154620.320953568@domain.hid>
Content-Disposition: inline; filename=generic-thread-registration.patch
Subject: [Xenomai-core] [PATCH 01/12] Generic thread registration
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>

Lay groundwork for registering every thread at least anonymously with
the Xenomai registry when required (e.g. handle-based fast xnsynch
support). Wrap the operations appropriately, also saving a few #ifdefs.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/nucleus/registry.h   |    1 
 include/nucleus/thread.h     |   25 +++++++++++++++++
 ksrc/nucleus/thread.c        |    2 +
 ksrc/skins/native/syscall.c  |   61 ++++++++++++++++++++++++++-----------------
 ksrc/skins/native/task.c     |   13 ---------
 ksrc/skins/psos+/syscall.c   |   19 ++++++++-----
 ksrc/skins/psos+/task.c      |   20 +++-----------
 ksrc/skins/vxworks/syscall.c |   31 ++++++++++++---------
 ksrc/skins/vxworks/taskLib.c |   10 -------
 9 files changed, 102 insertions(+), 80 deletions(-)

Index: b/ksrc/skins/native/syscall.c
===================================================================
--- a/ksrc/skins/native/syscall.c
+++ b/ksrc/skins/native/syscall.c
@@ -52,7 +52,8 @@ int __native_muxid;
 static int __rt_bind_helper(struct task_struct *p,
 			    struct pt_regs *regs,
 			    xnhandle_t *handlep,
-			    unsigned magic, void **objaddrp)
+			    unsigned magic, void **objaddrp,
+			    unsigned long objoffs)
 {
 	char name[XNOBJECT_NAME_LEN];
 	RTIME timeout;
@@ -82,7 +83,7 @@ static int __rt_bind_helper(struct task_
 
 	/* Also validate the type of the bound object. */
 
-	if (xeno_test_magic(objaddr, magic)) {
+	if (xeno_test_magic(objaddr + objoffs, magic)) {
 		if (objaddrp)
 			*objaddrp = objaddr;
 	} else
@@ -93,6 +94,11 @@ static int __rt_bind_helper(struct task_
 	return err;
 }
 
+static RT_TASK *__rt_task_lookup(xnhandle_t threadh)
+{
+	return thread2rtask(xnthread_lookup(threadh));
+}
+
 static RT_TASK *__rt_task_current(struct task_struct *p)
 {
 	xnthread_t *thread = xnshadow_thread(p);
@@ -223,7 +229,9 @@ static int __rt_task_bind(struct pt_regs
 	RT_TASK_PLACEHOLDER ph;
 	int err;
 
-	err = __rt_bind_helper(p, regs, &ph.opaque, XENO_TASK_MAGIC, NULL);
+	err =
+	    __rt_bind_helper(p, regs, &ph.opaque, XENO_TASK_MAGIC, NULL,
+			     -offsetof(RT_TASK, thread_base));
 
 	if (err)
 		return err;
@@ -253,7 +261,7 @@ static int __rt_task_start(struct pt_reg
 				     sizeof(ph)))
 		return -EFAULT;
 
-	task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+	task = __rt_task_lookup(ph.opaque);
 
 	if (!task)
 		return -ESRCH;
@@ -279,7 +287,7 @@ static int __rt_task_suspend(struct pt_r
 					     sizeof(ph)))
 			return -EFAULT;
 
-		task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task = __rt_task_lookup(ph.opaque);
 	} else
 		task = __rt_task_current(p);
 
@@ -302,7 +310,7 @@ static int __rt_task_resume(struct pt_re
 				     sizeof(ph)))
 		return -EFAULT;
 
-	task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+	task = __rt_task_lookup(ph.opaque);
 
 	if (!task)
 		return -ESRCH;
@@ -326,7 +334,7 @@ static int __rt_task_delete(struct pt_re
 					     sizeof(ph)))
 			return -EFAULT;
 
-		task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task = __rt_task_lookup(ph.opaque);
 	} else
 		task = __rt_task_current(p);
 
@@ -364,7 +372,7 @@ static int __rt_task_set_periodic(struct
 					     sizeof(ph)))
 			return -EFAULT;
 
-		task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task = __rt_task_lookup(ph.opaque);
 	} else
 		task = __rt_task_current(p);
 
@@ -418,7 +426,7 @@ static int __rt_task_set_priority(struct
 					     sizeof(ph)))
 			return -EFAULT;
 
-		task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task = __rt_task_lookup(ph.opaque);
 	} else
 		task = __rt_task_current(p);
 
@@ -473,7 +481,7 @@ static int __rt_task_unblock(struct pt_r
 				     sizeof(ph)))
 		return -EFAULT;
 
-	task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+	task = __rt_task_lookup(ph.opaque);
 
 	if (!task)
 		return -ESRCH;
@@ -500,7 +508,7 @@ static int __rt_task_inquire(struct pt_r
 					     sizeof(ph)))
 			return -EFAULT;
 
-		task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task = __rt_task_lookup(ph.opaque);
 	} else
 		task = __rt_task_current(p);
 
@@ -541,7 +549,7 @@ static int __rt_task_notify(struct pt_re
 					     sizeof(ph)))
 			return -EFAULT;
 
-		task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task = __rt_task_lookup(ph.opaque);
 	} else
 		task = __rt_task_current(p);
 
@@ -627,7 +635,7 @@ static int __rt_task_slice(struct pt_reg
 					     sizeof(ph)))
 			return -EFAULT;
 
-		task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task = __rt_task_lookup(ph.opaque);
 	} else
 		task = __rt_task_current(current);
 
@@ -667,7 +675,7 @@ static int __rt_task_send(struct pt_regs
 					     sizeof(ph)))
 			return -EFAULT;
 
-		task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task = __rt_task_lookup(ph.opaque);
 	} else
 		task = __rt_task_current(current);
 
@@ -1104,7 +1112,9 @@ static int __rt_sem_bind(struct pt_regs
 	RT_SEM_PLACEHOLDER ph;
 	int err;
 
-	err = __rt_bind_helper(current, regs, &ph.opaque, XENO_SEM_MAGIC, NULL);
+	err =
+	    __rt_bind_helper(current, regs, &ph.opaque, XENO_SEM_MAGIC,
+			     NULL, 0);
 
 	if (err)
 		return err;
@@ -1324,7 +1334,8 @@ static int __rt_event_bind(struct pt_reg
 	int err;
 
 	err =
-	    __rt_bind_helper(current, regs, &ph.opaque, XENO_EVENT_MAGIC, NULL);
+	    __rt_bind_helper(current, regs, &ph.opaque, XENO_EVENT_MAGIC,
+			     NULL, 0);
 
 	if (err)
 		return err;
@@ -1567,7 +1578,8 @@ static int __rt_mutex_bind(struct pt_reg
 	int err;
 
 	err =
-	    __rt_bind_helper(current, regs, &ph.opaque, XENO_MUTEX_MAGIC, NULL);
+	    __rt_bind_helper(current, regs, &ph.opaque, XENO_MUTEX_MAGIC,
+			     NULL, 0);
 
 	if (err)
 		return err;
@@ -1758,7 +1770,8 @@ static int __rt_cond_bind(struct pt_regs
 	int err;
 
 	err =
-	    __rt_bind_helper(current, regs, &ph.opaque, XENO_COND_MAGIC, NULL);
+	    __rt_bind_helper(current, regs, &ph.opaque, XENO_COND_MAGIC,
+			     NULL, 0);
 
 	if (err)
 		return err;
@@ -2008,7 +2021,7 @@ static int __rt_queue_bind(struct pt_reg
 
 	err =
 	    __rt_bind_helper(p, regs, &ph.opaque, XENO_QUEUE_MAGIC,
-			     (void **)&q);
+			     (void **)&q, 0);
 
 	if (err)
 		goto unlock_and_exit;
@@ -2507,7 +2520,7 @@ static int __rt_heap_bind(struct pt_regs
 
 	err =
 	    __rt_bind_helper(p, regs, &ph.opaque, XENO_HEAP_MAGIC,
-			     (void **)&heap);
+			     (void **)&heap, 0);
 
 	if (err)
 		goto unlock_and_exit;
@@ -3018,7 +3031,7 @@ static int __rt_intr_bind(struct pt_regs
 	RT_INTR_PLACEHOLDER ph;
 	int err;
 
-	err = __rt_bind_helper(p, regs, &ph.opaque, XENO_INTR_MAGIC, NULL);
+	err = __rt_bind_helper(p, regs, &ph.opaque, XENO_INTR_MAGIC, NULL, 0);
 
 	if (err)
 		return err;
@@ -3275,7 +3288,7 @@ static int __rt_pipe_bind(struct pt_regs
 	RT_PIPE_PLACEHOLDER ph;
 	int err;
 
-	err = __rt_bind_helper(p, regs, &ph.opaque, XENO_PIPE_MAGIC, NULL);
+	err = __rt_bind_helper(p, regs, &ph.opaque, XENO_PIPE_MAGIC, NULL, 0);
 
 	if (err)
 		return err;
@@ -3551,7 +3564,9 @@ static int __rt_buffer_bind(struct pt_re
 	RT_BUFFER_PLACEHOLDER ph;
 	int ret;
 
-	ret = __rt_bind_helper(current, regs, &ph.opaque, XENO_BUFFER_MAGIC, NULL);
+	ret =
+	    __rt_bind_helper(current, regs, &ph.opaque, XENO_BUFFER_MAGIC,
+			     NULL, 0);
 	if (ret)
 		return ret;
 
Index: b/ksrc/skins/native/task.c
===================================================================
--- a/ksrc/skins/native/task.c
+++ b/ksrc/skins/native/task.c
@@ -46,7 +46,6 @@
 
 #include <nucleus/pod.h>
 #include <nucleus/heap.h>
-#include <nucleus/registry.h>
 #include <native/task.h>
 #include <native/timer.h>
 
@@ -80,11 +79,6 @@ static void __task_delete_hook(xnthread_
 	xnsynch_destroy(&task->msendq);
 #endif /* CONFIG_XENO_OPT_NATIVE_MPS */
 
-#ifdef CONFIG_XENO_OPT_REGISTRY
-	if (xnthread_handle(&task->thread_base) != XN_NO_HANDLE)
-		xnregistry_remove(xnthread_handle(&task->thread_base));
-#endif /* CONFIG_XENO_OPT_REGISTRY */
-
 	xnsynch_destroy(&task->safesynch);
 
 	removeq(&__xeno_task_q, &task->link);
@@ -285,20 +279,15 @@ int rt_task_create(RT_TASK *task,
 	appendq(&__xeno_task_q, &task->link);
 	xnlock_put_irqrestore(&nklock, s);
 
-#ifdef CONFIG_XENO_OPT_REGISTRY
 	/* <!> Since xnregister_enter() may reschedule, only register
 	   complete objects, so that the registry cannot return handles to
 	   half-baked objects... */
 
 	if (name) {
-		err = xnregistry_enter(task->rname,
-				       task,
-				       &xnthread_handle(&task->thread_base),
-				       NULL);
+		err = xnthread_register(&task->thread_base, task->rname);
 		if (err)
 			xnpod_delete_thread(&task->thread_base);
 	}
-#endif /* CONFIG_XENO_OPT_REGISTRY */
 
 	return err;
 }
Index: b/ksrc/skins/psos+/syscall.c
===================================================================
--- a/ksrc/skins/psos+/syscall.c
+++ b/ksrc/skins/psos+/syscall.c
@@ -44,6 +44,11 @@
 
 int __psos_muxid;
 
+static inline psostask_t *__psos_task_lookup(xnhandle_t taskh)
+{
+	return thread2psostask(xnthread_lookup(taskh));
+}
+
 static psostask_t *__psos_task_current(struct task_struct *p)
 {
 	xnthread_t *thread = xnshadow_thread(p);
@@ -131,7 +136,7 @@ static int __t_start(struct pt_regs *reg
 	psostask_t *task;
 
 	handle = __xn_reg_arg1(regs);
-	task = (psostask_t *)xnregistry_fetch(handle);
+	task = __psos_task_lookup(handle);
 
 	if (!task)
 		return ERR_OBJID;
@@ -162,7 +167,7 @@ static int __t_delete(struct pt_regs *re
 	handle = __xn_reg_arg1(regs);
 
 	if (handle)
-		task = (psostask_t *)xnregistry_fetch(handle);
+		task = __psos_task_lookup(handle);
 	else
 		task = __psos_task_current(current);
 
@@ -182,7 +187,7 @@ static int __t_suspend(struct pt_regs *r
 	psostask_t *task;
 
 	if (handle)
-		task = (psostask_t *)xnregistry_fetch(handle);
+		task = __psos_task_lookup(handle);
 	else
 		task = __psos_task_current(current);
 
@@ -202,7 +207,7 @@ static int __t_resume(struct pt_regs *re
 	psostask_t *task;
 
 	if (handle)
-		task = (psostask_t *)xnregistry_fetch(handle);
+		task = __psos_task_lookup(handle);
 	else
 		task = __psos_task_current(current);
 
@@ -284,7 +289,7 @@ static int __t_setpri(struct pt_regs *re
 	psostask_t *task;
 
 	if (handle)
-		task = (psostask_t *)xnregistry_fetch(handle);
+		task = __psos_task_lookup(handle);
 	else
 		task = __psos_task_current(current);
 
@@ -314,7 +319,7 @@ static int __ev_send(struct pt_regs *reg
 	u_long events;
 
 	if (handle)
-		task = (psostask_t *)xnregistry_fetch(handle);
+		task = __psos_task_lookup(handle);
 	else
 		task = __psos_task_current(current);
 
@@ -1317,7 +1322,7 @@ static int __as_send(struct pt_regs *reg
 	psostask_t *task;
 
 	if (handle)
-		task = (psostask_t *)xnregistry_fetch(handle);
+		task = __psos_task_lookup(handle);
 	else
 		task = __psos_task_current(current);
 
Index: b/ksrc/skins/psos+/task.c
===================================================================
--- a/ksrc/skins/psos+/task.c
+++ b/ksrc/skins/psos+/task.c
@@ -17,7 +17,6 @@
  * 02111-1307, USA.
  */
 
-#include <nucleus/registry.h>
 #include <psos+/task.h>
 #include <psos+/tm.h>
 
@@ -45,11 +44,6 @@ static void psostask_delete_hook(xnthrea
 	if (xnthread_get_magic(thread) != PSOS_SKIN_MAGIC)
 		return;
 
-#ifdef CONFIG_XENO_OPT_REGISTRY
-	if (xnthread_handle(thread) != XN_NO_HANDLE)
-		xnregistry_remove(xnthread_handle(thread));
-#endif /* CONFIG_XENO_OPT_REGISTRY */
-
 	task = thread2psostask(thread);
 
 	removeq(&psostaskq, &task->link);
@@ -95,6 +89,7 @@ u_long t_create(const char *name,
 {
 	xnflags_t bflags = 0;
 	psostask_t *task;
+	u_long err;
 	spl_t s;
 	int n;
 
@@ -159,16 +154,11 @@ u_long t_create(const char *name,
 	*tid_r = (u_long)task;
 	xnlock_put_irqrestore(&nklock, s);
 
-#ifdef CONFIG_XENO_OPT_REGISTRY
-	{
-		u_long err = xnregistry_enter(task->name,
-					      task, &xnthread_handle(&task->threadbase), NULL);
-		if (err) {
-			t_delete((u_long)task);
-			return err;
-		}
+	err = xnthread_register(&task->threadbase, task->name);
+	if (err) {
+		t_delete((u_long)task);
+		return err;
 	}
-#endif /* CONFIG_XENO_OPT_REGISTRY */
 
 	xnarch_create_display(&task->threadbase, task->name, psostask);
 
Index: b/ksrc/skins/vxworks/syscall.c
===================================================================
--- a/ksrc/skins/vxworks/syscall.c
+++ b/ksrc/skins/vxworks/syscall.c
@@ -42,6 +42,11 @@
 
 int __wind_muxid;
 
+static inline WIND_TCB *__wind_lookup_task(xnhandle_t threadh)
+{
+	return thread2wind_task(xnthread_lookup(threadh));
+}
+
 static WIND_TCB *__wind_task_current(struct task_struct *p)
 {
 	xnthread_t *thread = xnshadow_thread(p);
@@ -146,7 +151,7 @@ out:
 
 static int __wind_task_activate(struct pt_regs *regs)
 {
-	WIND_TCB *pTcb = (WIND_TCB *)xnregistry_fetch(__xn_reg_arg1(regs));
+	WIND_TCB *pTcb = __wind_lookup_task(__xn_reg_arg1(regs));
 
 	if (!pTcb)
 		return S_objLib_OBJ_ID_ERROR;
@@ -167,7 +172,7 @@ static int __wind_task_deleteforce(struc
 	WIND_TCB *pTcb;
 
 	if (handle)
-		pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+		pTcb = __wind_lookup_task(handle);
 	else
 		pTcb = __wind_task_current(current);
 
@@ -190,7 +195,7 @@ static int __wind_task_delete(struct pt_
 	WIND_TCB *pTcb;
 
 	if (handle)
-		pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+		pTcb = __wind_lookup_task(handle);
 	else
 		pTcb = __wind_task_current(current);
 
@@ -213,7 +218,7 @@ static int __wind_task_suspend(struct pt
 	WIND_TCB *pTcb;
 
 	if (handle)
-		pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+		pTcb = __wind_lookup_task(handle);
 	else
 		pTcb = __wind_task_current(current);
 
@@ -232,7 +237,7 @@ static int __wind_task_suspend(struct pt
 
 static int __wind_task_resume(struct pt_regs *regs)
 {
-	WIND_TCB *pTcb = (WIND_TCB *)xnregistry_fetch(__xn_reg_arg1(regs));
+	WIND_TCB *pTcb = __wind_lookup_task(__xn_reg_arg1(regs));
 
 	if (!pTcb)
 		return S_objLib_OBJ_ID_ERROR;
@@ -275,7 +280,7 @@ static int __wind_task_priorityset(struc
 	WIND_TCB *pTcb;
 
 	if (handle)
-		pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+		pTcb = __wind_lookup_task(handle);
 	else
 		pTcb = __wind_task_current(current);
 
@@ -299,7 +304,7 @@ static int __wind_task_priorityget(struc
 	int prio;
 
 	if (handle)
-		pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+		pTcb = __wind_lookup_task(handle);
 	else
 		pTcb = __wind_task_current(current);
 
@@ -374,7 +379,7 @@ static int __wind_task_verifyid(struct p
 	xnhandle_t handle = __xn_reg_arg1(regs);
 	WIND_TCB *pTcb;
 
-	pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+	pTcb = __wind_lookup_task(handle);
 
 	if (!pTcb)
 		return S_objLib_OBJ_ID_ERROR;
@@ -574,7 +579,7 @@ static int __wind_taskinfo_name(struct p
 	const char *name;
 	WIND_TCB *pTcb;
 
-	pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+	pTcb = __wind_lookup_task(handle);
 
 	if (!pTcb)
 		return S_objLib_OBJ_ID_ERROR;
@@ -618,7 +623,7 @@ static int __wind_taskinfo_status(struct
 
 	xnlock_get_irqsave(&nklock, s);
 
-	pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+	pTcb = __wind_lookup_task(handle);
 
 	if (!pTcb || pTcb->magic != WIND_TASK_MAGIC) {
 		xnlock_put_irqrestore(&nklock, s);
@@ -643,7 +648,7 @@ static int __wind_taskinfo_get(struct pt
 	WIND_TCB *pTcb;
 	int err;
 
-	pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+	pTcb = __wind_lookup_task(handle);
 	if (!pTcb)
 		return S_objLib_OBJ_ID_ERROR;
 
@@ -673,7 +678,7 @@ static int __wind_errno_taskset(struct p
  		return 0;
  	}
  
- 	pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+ 	pTcb = __wind_lookup_task(handle);
 	if (!pTcb)
 		return S_objLib_OBJ_ID_ERROR;
 
@@ -696,7 +701,7 @@ static int __wind_errno_taskget(struct p
  	if (!handle)
  		errcode = wind_errnoget();
  	else {
- 		pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+ 		pTcb = __wind_lookup_task(handle);
  		if (!pTcb)
  			return S_objLib_OBJ_ID_ERROR;
  
Index: b/ksrc/skins/vxworks/taskLib.c
===================================================================
--- a/ksrc/skins/vxworks/taskLib.c
+++ b/ksrc/skins/vxworks/taskLib.c
@@ -170,14 +170,11 @@ STATUS taskInit(WIND_TCB *pTcb,
 	appendq(&wind_tasks_q, &pTcb->link);
 	xnlock_put_irqrestore(&nklock, s);
 
-#ifdef CONFIG_XENO_OPT_REGISTRY
-	if (xnregistry_enter(pTcb->name,
-			     pTcb, &xnthread_handle(&pTcb->threadbase), NULL)) {
+	if (xnthread_register(&pTcb->threadbase, pTcb->name)) {
 		wind_errnoset(S_objLib_OBJ_ID_ERROR);
 		taskDeleteForce((TASK_ID) pTcb);
 		return ERROR;
 	}
-#endif /* CONFIG_XENO_OPT_REGISTRY */
 
 	return OK;
 }
@@ -618,11 +615,6 @@ static void wind_task_delete_hook(xnthre
 	if (xnthread_get_magic(thread) != VXWORKS_SKIN_MAGIC)
 		return;
 
-#ifdef CONFIG_XENO_OPT_REGISTRY
-	if (xnthread_handle(thread) != XN_NO_HANDLE)
-	    xnregistry_remove(xnthread_handle(thread));
-#endif /* CONFIG_XENO_OPT_REGISTRY */
-
 	task = thread2wind_task(thread);
 
 	xnsynch_destroy(&task->safesync);
Index: b/include/nucleus/registry.h
===================================================================
--- a/include/nucleus/registry.h
+++ b/include/nucleus/registry.h
@@ -35,7 +35,6 @@
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
 #include <nucleus/synch.h>
-#include <nucleus/thread.h>
 
 struct xnpnode;
 
Index: b/include/nucleus/thread.h
===================================================================
--- a/include/nucleus/thread.h
+++ b/include/nucleus/thread.h
@@ -130,6 +130,7 @@
 
 #include <nucleus/stat.h>
 #include <nucleus/timer.h>
+#include <nucleus/registry.h>
 
 #ifdef __XENO_SIM__
 /* Pseudo-status (must not conflict with other bits) */
@@ -392,6 +393,30 @@ static inline xnticks_t xnthread_get_per
 	return period;
 }
 
+#ifdef CONFIG_XENO_OPT_REGISTRY
+static inline int xnthread_register(xnthread_t *thread, const char *name)
+{
+	return xnregistry_enter(name, thread, &xnthread_handle(thread), NULL);
+}
+
+static inline xnthread_t *xnthread_lookup(xnhandle_t threadh)
+{
+	xnthread_t *thread = xnregistry_fetch(threadh);
+
+	return (thread && xnthread_handle(thread) == threadh) ? thread : NULL;
+}
+#else /* !CONFIG_XENO_OPT_REGISTRY */
+static inline int xnthread_register(xnthread_t *thread, const char *name)
+{
+	return 0;
+}
+
+static inline xnthread_t *xnthread_lookup(xnhandle_t threadh)
+{
+	return NULL;
+}
+#endif /* !CONFIG_XENO_OPT_REGISTRY */
+
 #ifdef __cplusplus
 }
 #endif
Index: b/ksrc/nucleus/thread.c
===================================================================
--- a/ksrc/nucleus/thread.c
+++ b/ksrc/nucleus/thread.c
@@ -136,6 +136,8 @@ void xnthread_cleanup_tcb(xnthread_t *th
 #endif
 
 #ifdef CONFIG_XENO_OPT_REGISTRY
+	if (thread->registry.handle != XN_NO_HANDLE)
+		xnregistry_remove(thread->registry.handle);
 	thread->registry.handle = XN_NO_HANDLE;
 #endif /* CONFIG_XENO_OPT_REGISTRY */
 }


