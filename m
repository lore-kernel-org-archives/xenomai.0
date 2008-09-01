Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48BBB22E.2010408@domain.hid>
Message-ID: <48BBAA50.7060608@domain.hid>
Date: Mon, 01 Sep 2008 10:39:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48BBA9E6.5070400@domain.hid>
In-Reply-To: <48BBA9E6.5070400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 1/9] Always register threads by their base
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

In order to use xnthread_handle(thread) for the fast mutex lock
variable, we have to ensure that all skins pass the generic object on
xnregistry_enter. The following patch ensures this for preexisting
registrations.

---
 ksrc/skins/native/syscall.c  |   56 +++++++++++++++++++++++++------------------
 ksrc/skins/native/task.c     |    2 -
 ksrc/skins/psos+/syscall.c   |   14 +++++-----
 ksrc/skins/psos+/task.c      |    7 +++--
 ksrc/skins/vxworks/syscall.c |   28 +++++++++++----------
 ksrc/skins/vxworks/taskLib.c |    4 +--
 6 files changed, 63 insertions(+), 48 deletions(-)

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
@@ -223,7 +224,9 @@ static int __rt_task_bind(struct pt_regs
 	RT_TASK_PLACEHOLDER ph;
 	int err;
 
-	err = __rt_bind_helper(p, regs, &ph.opaque, XENO_TASK_MAGIC, NULL);
+	err =
+	    __rt_bind_helper(p, regs, &ph.opaque, XENO_TASK_MAGIC, NULL,
+			     -offsetof(RT_TASK, thread_base));
 
 	if (err)
 		return err;
@@ -253,7 +256,7 @@ static int __rt_task_start(struct pt_reg
 				     sizeof(ph)))
 		return -EFAULT;
 
-	task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+	task = thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
 
 	if (!task)
 		return -ESRCH;
@@ -279,7 +282,7 @@ static int __rt_task_suspend(struct pt_r
 					     sizeof(ph)))
 			return -EFAULT;
 
-		task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task = thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
 	} else
 		task = __rt_task_current(p);
 
@@ -302,7 +305,7 @@ static int __rt_task_resume(struct pt_re
 				     sizeof(ph)))
 		return -EFAULT;
 
-	task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+	task = thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
 
 	if (!task)
 		return -ESRCH;
@@ -326,7 +329,7 @@ static int __rt_task_delete(struct pt_re
 					     sizeof(ph)))
 			return -EFAULT;
 
-		task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task = thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
 	} else
 		task = __rt_task_current(p);
 
@@ -364,7 +367,7 @@ static int __rt_task_set_periodic(struct
 					     sizeof(ph)))
 			return -EFAULT;
 
-		task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task = thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
 	} else
 		task = __rt_task_current(p);
 
@@ -418,7 +421,7 @@ static int __rt_task_set_priority(struct
 					     sizeof(ph)))
 			return -EFAULT;
 
-		task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task = thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
 	} else
 		task = __rt_task_current(p);
 
@@ -473,7 +476,7 @@ static int __rt_task_unblock(struct pt_r
 				     sizeof(ph)))
 		return -EFAULT;
 
-	task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+	task = thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
 
 	if (!task)
 		return -ESRCH;
@@ -500,7 +503,7 @@ static int __rt_task_inquire(struct pt_r
 					     sizeof(ph)))
 			return -EFAULT;
 
-		task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task = thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
 	} else
 		task = __rt_task_current(p);
 
@@ -541,7 +544,7 @@ static int __rt_task_notify(struct pt_re
 					     sizeof(ph)))
 			return -EFAULT;
 
-		task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task = thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
 	} else
 		task = __rt_task_current(p);
 
@@ -627,7 +630,7 @@ static int __rt_task_slice(struct pt_reg
 					     sizeof(ph)))
 			return -EFAULT;
 
-		task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task = thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
 	} else
 		task = __rt_task_current(current);
 
@@ -667,7 +670,7 @@ static int __rt_task_send(struct pt_regs
 					     sizeof(ph)))
 			return -EFAULT;
 
-		task = (RT_TASK *)xnregistry_fetch(ph.opaque);
+		task = thread2rtask((xnthread_t *)xnregistry_fetch(ph.opaque));
 	} else
 		task = __rt_task_current(current);
 
@@ -1104,7 +1107,9 @@ static int __rt_sem_bind(struct pt_regs
 	RT_SEM_PLACEHOLDER ph;
 	int err;
 
-	err = __rt_bind_helper(current, regs, &ph.opaque, XENO_SEM_MAGIC, NULL);
+	err =
+	    __rt_bind_helper(current, regs, &ph.opaque, XENO_SEM_MAGIC,
+			     NULL, 0);
 
 	if (err)
 		return err;
@@ -1324,7 +1329,8 @@ static int __rt_event_bind(struct pt_reg
 	int err;
 
 	err =
-	    __rt_bind_helper(current, regs, &ph.opaque, XENO_EVENT_MAGIC, NULL);
+	    __rt_bind_helper(current, regs, &ph.opaque, XENO_EVENT_MAGIC,
+			     NULL, 0);
 
 	if (err)
 		return err;
@@ -1567,7 +1573,8 @@ static int __rt_mutex_bind(struct pt_reg
 	int err;
 
 	err =
-	    __rt_bind_helper(current, regs, &ph.opaque, XENO_MUTEX_MAGIC, NULL);
+	    __rt_bind_helper(current, regs, &ph.opaque, XENO_MUTEX_MAGIC,
+			     NULL, 0);
 
 	if (err)
 		return err;
@@ -1758,7 +1765,8 @@ static int __rt_cond_bind(struct pt_regs
 	int err;
 
 	err =
-	    __rt_bind_helper(current, regs, &ph.opaque, XENO_COND_MAGIC, NULL);
+	    __rt_bind_helper(current, regs, &ph.opaque, XENO_COND_MAGIC,
+			     NULL, 0);
 
 	if (err)
 		return err;
@@ -2008,7 +2016,7 @@ static int __rt_queue_bind(struct pt_reg
 
 	err =
 	    __rt_bind_helper(p, regs, &ph.opaque, XENO_QUEUE_MAGIC,
-			     (void **)&q);
+			     (void **)&q, 0);
 
 	if (err)
 		goto unlock_and_exit;
@@ -2507,7 +2515,7 @@ static int __rt_heap_bind(struct pt_regs
 
 	err =
 	    __rt_bind_helper(p, regs, &ph.opaque, XENO_HEAP_MAGIC,
-			     (void **)&heap);
+			     (void **)&heap, 0);
 
 	if (err)
 		goto unlock_and_exit;
@@ -3018,7 +3026,7 @@ static int __rt_intr_bind(struct pt_regs
 	RT_INTR_PLACEHOLDER ph;
 	int err;
 
-	err = __rt_bind_helper(p, regs, &ph.opaque, XENO_INTR_MAGIC, NULL);
+	err = __rt_bind_helper(p, regs, &ph.opaque, XENO_INTR_MAGIC, NULL, 0);
 
 	if (err)
 		return err;
@@ -3275,7 +3283,7 @@ static int __rt_pipe_bind(struct pt_regs
 	RT_PIPE_PLACEHOLDER ph;
 	int err;
 
-	err = __rt_bind_helper(p, regs, &ph.opaque, XENO_PIPE_MAGIC, NULL);
+	err = __rt_bind_helper(p, regs, &ph.opaque, XENO_PIPE_MAGIC, NULL, 0);
 
 	if (err)
 		return err;
@@ -3551,7 +3559,9 @@ static int __rt_buffer_bind(struct pt_re
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
@@ -292,7 +292,7 @@ int rt_task_create(RT_TASK *task,
 
 	if (name) {
 		err = xnregistry_enter(task->rname,
-				       task,
+				       &task->thread_base,
 				       &xnthread_handle(&task->thread_base),
 				       NULL);
 		if (err)
Index: b/ksrc/skins/psos+/syscall.c
===================================================================
--- a/ksrc/skins/psos+/syscall.c
+++ b/ksrc/skins/psos+/syscall.c
@@ -131,7 +131,7 @@ static int __t_start(struct pt_regs *reg
 	psostask_t *task;
 
 	handle = __xn_reg_arg1(regs);
-	task = (psostask_t *)xnregistry_fetch(handle);
+	task = thread2psostask((xnthread_t *)xnregistry_fetch(handle));
 
 	if (!task)
 		return ERR_OBJID;
@@ -162,7 +162,7 @@ static int __t_delete(struct pt_regs *re
 	handle = __xn_reg_arg1(regs);
 
 	if (handle)
-		task = (psostask_t *)xnregistry_fetch(handle);
+		task = thread2psostask((xnthread_t *)xnregistry_fetch(handle));
 	else
 		task = __psos_task_current(current);
 
@@ -182,7 +182,7 @@ static int __t_suspend(struct pt_regs *r
 	psostask_t *task;
 
 	if (handle)
-		task = (psostask_t *)xnregistry_fetch(handle);
+		task = thread2psostask((xnthread_t *)xnregistry_fetch(handle));
 	else
 		task = __psos_task_current(current);
 
@@ -202,7 +202,7 @@ static int __t_resume(struct pt_regs *re
 	psostask_t *task;
 
 	if (handle)
-		task = (psostask_t *)xnregistry_fetch(handle);
+		task = thread2psostask((xnthread_t *)xnregistry_fetch(handle));
 	else
 		task = __psos_task_current(current);
 
@@ -284,7 +284,7 @@ static int __t_setpri(struct pt_regs *re
 	psostask_t *task;
 
 	if (handle)
-		task = (psostask_t *)xnregistry_fetch(handle);
+		task = thread2psostask((xnthread_t *)xnregistry_fetch(handle));
 	else
 		task = __psos_task_current(current);
 
@@ -314,7 +314,7 @@ static int __ev_send(struct pt_regs *reg
 	u_long events;
 
 	if (handle)
-		task = (psostask_t *)xnregistry_fetch(handle);
+		task = thread2psostask((xnthread_t *)xnregistry_fetch(handle));
 	else
 		task = __psos_task_current(current);
 
@@ -1317,7 +1317,7 @@ static int __as_send(struct pt_regs *reg
 	psostask_t *task;
 
 	if (handle)
-		task = (psostask_t *)xnregistry_fetch(handle);
+		task = thread2psostask((xnthread_t *)xnregistry_fetch(handle));
 	else
 		task = __psos_task_current(current);
 
Index: b/ksrc/skins/psos+/task.c
===================================================================
--- a/ksrc/skins/psos+/task.c
+++ b/ksrc/skins/psos+/task.c
@@ -161,8 +161,11 @@ u_long t_create(const char *name,
 
 #ifdef CONFIG_XENO_OPT_REGISTRY
 	{
-		u_long err = xnregistry_enter(task->name,
-					      task, &xnthread_handle(&task->threadbase), NULL);
+		u_long err =
+			xnregistry_enter(task->name,
+					 &task->threadbase,
+					 &xnthread_handle(&task->threadbase),
+					 NULL);
 		if (err) {
 			t_delete((u_long)task);
 			return err;
Index: b/ksrc/skins/vxworks/syscall.c
===================================================================
--- a/ksrc/skins/vxworks/syscall.c
+++ b/ksrc/skins/vxworks/syscall.c
@@ -146,7 +146,8 @@ out:
 
 static int __wind_task_activate(struct pt_regs *regs)
 {
-	WIND_TCB *pTcb = (WIND_TCB *)xnregistry_fetch(__xn_reg_arg1(regs));
+	WIND_TCB *pTcb = thread2wind_task(
+		(xnthread_t *)xnregistry_fetch(__xn_reg_arg1(regs)));
 
 	if (!pTcb)
 		return S_objLib_OBJ_ID_ERROR;
@@ -167,7 +168,7 @@ static int __wind_task_deleteforce(struc
 	WIND_TCB *pTcb;
 
 	if (handle)
-		pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+		pTcb = thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
 	else
 		pTcb = __wind_task_current(current);
 
@@ -190,7 +191,7 @@ static int __wind_task_delete(struct pt_
 	WIND_TCB *pTcb;
 
 	if (handle)
-		pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+		pTcb = thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
 	else
 		pTcb = __wind_task_current(current);
 
@@ -213,7 +214,7 @@ static int __wind_task_suspend(struct pt
 	WIND_TCB *pTcb;
 
 	if (handle)
-		pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+		pTcb = thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
 	else
 		pTcb = __wind_task_current(current);
 
@@ -232,7 +233,8 @@ static int __wind_task_suspend(struct pt
 
 static int __wind_task_resume(struct pt_regs *regs)
 {
-	WIND_TCB *pTcb = (WIND_TCB *)xnregistry_fetch(__xn_reg_arg1(regs));
+	WIND_TCB *pTcb = thread2wind_task(
+		(xnthread_t *)xnregistry_fetch(__xn_reg_arg1(regs)));
 
 	if (!pTcb)
 		return S_objLib_OBJ_ID_ERROR;
@@ -275,7 +277,7 @@ static int __wind_task_priorityset(struc
 	WIND_TCB *pTcb;
 
 	if (handle)
-		pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+		pTcb = thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
 	else
 		pTcb = __wind_task_current(current);
 
@@ -299,7 +301,7 @@ static int __wind_task_priorityget(struc
 	int prio;
 
 	if (handle)
-		pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+		pTcb = thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
 	else
 		pTcb = __wind_task_current(current);
 
@@ -374,7 +376,7 @@ static int __wind_task_verifyid(struct p
 	xnhandle_t handle = __xn_reg_arg1(regs);
 	WIND_TCB *pTcb;
 
-	pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+	pTcb = (thread2wind_task((xnthread_t *)xnregistry_fetch(handle)));
 
 	if (!pTcb)
 		return S_objLib_OBJ_ID_ERROR;
@@ -574,7 +576,7 @@ static int __wind_taskinfo_name(struct p
 	const char *name;
 	WIND_TCB *pTcb;
 
-	pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+	pTcb = thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
 
 	if (!pTcb)
 		return S_objLib_OBJ_ID_ERROR;
@@ -618,7 +620,7 @@ static int __wind_taskinfo_status(struct
 
 	xnlock_get_irqsave(&nklock, s);
 
-	pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+	pTcb = thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
 
 	if (!pTcb || pTcb->magic != WIND_TASK_MAGIC) {
 		xnlock_put_irqrestore(&nklock, s);
@@ -643,7 +645,7 @@ static int __wind_taskinfo_get(struct pt
 	WIND_TCB *pTcb;
 	int err;
 
-	pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+	pTcb = thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
 	if (!pTcb)
 		return S_objLib_OBJ_ID_ERROR;
 
@@ -673,7 +675,7 @@ static int __wind_errno_taskset(struct p
  		return 0;
  	}
  
- 	pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+ 	pTcb = thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
 	if (!pTcb)
 		return S_objLib_OBJ_ID_ERROR;
 
@@ -696,7 +698,7 @@ static int __wind_errno_taskget(struct p
  	if (!handle)
  		errcode = wind_errnoget();
  	else {
- 		pTcb = (WIND_TCB *)xnregistry_fetch(handle);
+ 		pTcb = thread2wind_task((xnthread_t *)xnregistry_fetch(handle));
  		if (!pTcb)
  			return S_objLib_OBJ_ID_ERROR;
  
Index: b/ksrc/skins/vxworks/taskLib.c
===================================================================
--- a/ksrc/skins/vxworks/taskLib.c
+++ b/ksrc/skins/vxworks/taskLib.c
@@ -171,8 +171,8 @@ STATUS taskInit(WIND_TCB *pTcb,
 	xnlock_put_irqrestore(&nklock, s);
 
 #ifdef CONFIG_XENO_OPT_REGISTRY
-	if (xnregistry_enter(pTcb->name,
-			     pTcb, &xnthread_handle(&pTcb->threadbase), NULL)) {
+	if (xnregistry_enter(pTcb->name, &pTcb->threadbase,
+			     &xnthread_handle(&pTcb->threadbase), NULL)) {
 		wind_errnoset(S_objLib_OBJ_ID_ERROR);
 		taskDeleteForce((TASK_ID) pTcb);
 		return ERROR;


