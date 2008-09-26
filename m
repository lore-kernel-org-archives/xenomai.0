Message-ID: <48DC9F3C.8050008@domain.hid>
Date: Fri, 26 Sep 2008 10:37:16 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200809212234.06587.niklaus.giger@domain.hid>
	<48D7C506.8000109@domain.hid>
	<200809222145.23158.niklaus.giger@domain.hid>
In-Reply-To: <200809222145.23158.niklaus.giger@domain.hid>
Content-Type: multipart/mixed; boundary="------------090503030504050007010608"
Subject: Re: [Xenomai-core] xenomai-solo vxWorks: know whether a task is
 safe or not
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Niklaus Giger <niklaus.giger@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------090503030504050007010608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Niklaus Giger wrote:
> Am Montag 22 September 2008 18.17:10 schrieb Philippe Gerum:
>> Niklaus Giger wrote:
>>> Hi
>>>
>>> For various reasons we were forced to examine under vxWorks 5.5 the
>>> private WIND_TCB safeCnt field to determine whether a task was "safe" or
>>> not.
>>>
>>> With the attached patch I try to add a taskIsSafe procedure to
>>> xenomai-solo. It is probably not free from race condition, as I do not
>>> know how to access a pthread_mutex.
>>>
>>> Would such (may be improved) patch find its way into the "official"
>>> trunk?
>> Assuming that VxWorks tracks the locking depth in safeCnt, that
>> implementation would not properly account for nested locking (safelock is a
>> recursive mutex). Additionally, since WIND_TCB is something of a
>> semi-public structure in 5.x and earlier versions, we could just track the
>> safe counter there as well, instead of adding a non-standard taskIsSafe()
>> call; we already do that for the status field anyway. Here is a possible
>> implementation:
> 
> This implementation is okay for me, too. It seems to work, as far I could
> test it.
> 
> I however still have some issues because we used sometimes (for historical 
> reasons in order to emulate a pre-vxWorks home grown cooperative mulit-tasking 
> operation system) a taskInit/taskActivate/taskRestart combination. 
> 
> Would it be a lot of work for you to add taskRestart to xenomai-solo?
> 

I must admit that I always considered the task restart interface as a pure
manifestation of the Evil, so its absence from SOLO might not be totally
fortuitous. Trashing your system with that stuff is way to easy.

Anyway, here is a possible implementation based on - cough, cough... -
sigsetjmp(); I don't like it since it adds code to various hot paths just to
provide a rarely used feature, so I may make this optional using a configuration
knob at build time if/when I actually merge that, mmmh, thing.

Please let me know how that works for you.

-- 
Philippe.


--------------090503030504050007010608
Content-Type: text/x-diff;
 name="solo-vxworks-add-task-restart.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="solo-vxworks-add-task-restart.patch"

diff --git a/include/vxworks/taskLib.h b/include/vxworks/taskLib.h
index 6334396..2f09de6 100644
--- a/include/vxworks/taskLib.h
+++ b/include/vxworks/taskLib.h
@@ -39,6 +39,7 @@
 #define WIND_DELAY	0x4
 #define WIND_DEAD	0x8
 #define WIND_STOP	0x10	/* Never reported. */
+#define WIND_RESTART	0x20	/* Internal. */
 
 typedef intptr_t TASK_ID;
 
@@ -78,6 +79,8 @@ STATUS taskInit(WIND_TCB *pTcb,
 
 STATUS taskActivate(TASK_ID tid);
 
+STATUS taskRestart(TASK_ID tid);
+
 STATUS taskDelete(TASK_ID tid);
 
 STATUS taskDeleteForce(TASK_ID tid);
diff --git a/vxworks/msgQLib.c b/vxworks/msgQLib.c
index d591a7b..e3d071d 100644
--- a/vxworks/msgQLib.c
+++ b/vxworks/msgQLib.c
@@ -149,6 +149,8 @@ int msgQReceive(MSG_Q_ID msgQId, char *buffer, UINT maxNBytes, int timeout)
 		return ERROR;
 	}
 
+	check_task_restart(wind_task_current());
+
 	mq = get_mq_from_id(msgQId);
 	if (mq == NULL) {
 	objid_error:
@@ -217,6 +219,8 @@ STATUS msgQSend(MSG_Q_ID msgQId, const char *buffer, UINT bytes,
 	UINT maxbytes;
 	int ret;
 	
+	check_task_restart(wind_task_current());
+
 	mq = get_mq_from_id(msgQId);
 	if (mq == NULL) {
 	objid_error:
diff --git a/vxworks/semLib.c b/vxworks/semLib.c
index 6467354..dfc37cc 100644
--- a/vxworks/semLib.c
+++ b/vxworks/semLib.c
@@ -61,7 +61,9 @@ static STATUS xsem_take(struct wind_sem *sem, int timeout)
 
 	if (threadobj_async_p())
 		return S_intLib_NOT_ISR_CALLABLE;
-	  
+
+	check_task_restart(wind_task_current());
+
 	if (syncobj_lock(&sem->u.xsem.sobj, &syns))
 		return S_objLib_OBJ_ID_ERROR;
 
@@ -196,8 +198,11 @@ static STATUS msem_take(struct wind_sem *sem, int timeout)
 		return S_intLib_NOT_ISR_CALLABLE;
 	  
 	current = wind_task_current();
-	if (current != NULL && (sem->options & SEM_DELETE_SAFE))
-		pthread_mutex_lock(&current->safelock);
+	if (current != NULL) {
+		check_task_restart(current);
+		if (sem->options & SEM_DELETE_SAFE)
+			pthread_mutex_lock(&current->safelock);
+	}
 
 	if (timeout == NO_WAIT) {
 		ret = pthread_mutex_trylock(&sem->u.msem.lock);
diff --git a/vxworks/taskLib.c b/vxworks/taskLib.c
index a9e12e7..7e74cf0 100644
--- a/vxworks/taskLib.c
+++ b/vxworks/taskLib.c
@@ -97,6 +97,8 @@ struct wind_task *get_wind_task_or_self(TASK_ID tid)
 	if (current == NULL)
 		return NULL;
 
+	check_task_restart(current);
+
 	/* This one might block but can't fail, it is ours. */
 	threadobj_lock(&current->thobj);
 
@@ -114,6 +116,12 @@ void put_wind_task(struct wind_task *task)
 	threadobj_unlock(&task->thobj);
 }
 
+void check_task_restart(struct wind_task *current)
+{
+	if (current && (current->tcb->status & WIND_RESTART) != 0)
+		siglongjmp(current->ienv, 1);
+}
+
 static void task_finalizer(struct threadobj *thobj)
 {
 	struct wind_task *task = container_of(thobj, struct wind_task, thobj);
@@ -253,6 +261,11 @@ static void *task_trampoline(void *arg)
 	/* Wait for someone to run taskActivate() upon us. */
 	sem_wait(&task->barrier);
 
+	threadobj_lock(&task->thobj);
+	sigsetjmp(task->ienv, 1); /* For taskRestart(). */
+	task->tcb->status &= ~WIND_RESTART;
+	threadobj_unlock(&task->thobj);
+
 	args->entry(args->arg0, args->arg1, args->arg2, args->arg3,
 		    args->arg4, args->arg5, args->arg6, args->arg7,
 		    args->arg8, args->arg9);
@@ -356,7 +369,7 @@ STATUS taskInit(WIND_TCB *pTcb,
 		errno = S_intLib_NOT_ISR_CALLABLE;
 		return ERROR;
 	}
-	  
+
 	task = alloc_task();
 	if (task == NULL) {
 		errno = S_memLib_NOT_ENOUGH_MEMORY;
@@ -396,6 +409,30 @@ STATUS taskActivate(TASK_ID tid)
 	return OK;
 }
 
+STATUS taskRestart(TASK_ID tid)
+{
+	struct wind_task *task;
+
+	if (threadobj_async_p()) {
+		errno = S_intLib_NOT_ISR_CALLABLE;
+		return ERROR;
+	}
+	  
+	/* The thread lock will be released at jump site. */
+	task = get_wind_task_or_self(tid);
+	if (task == NULL) {
+		errno = S_objLib_OBJ_ID_ERROR;
+		return ERROR;
+	}
+
+	task->tcb->status |= WIND_RESTART;
+
+	if (task == wind_task_current())
+		siglongjmp(task->ienv, 1); /* Does not return. */
+
+	return OK;
+}
+
 TASK_ID taskSpawn(const char *name,
 		  int prio,
 		  int flags,
@@ -454,8 +491,10 @@ static STATUS __taskDelete(TASK_ID tid, int force)
 	if (task == NULL)
 		goto objid_error;
 
-	if (task == wind_task_current()) /* Self-deletion. */
+	if (task == wind_task_current()) { /* Self-deletion. */
+		check_task_restart(task);
 		pthread_exit(NULL);
+	}
 
 	/*
 	 * We always attempt to grab the thread safe lock first, then
@@ -517,11 +556,12 @@ TASK_ID taskIdSelf(void)
 	}
 	  
 	current = wind_task_current();
-
 	if (current == NULL) {
 		errno = S_objLib_OBJ_NO_METHOD;
 		return ERROR;
 	}
+
+	check_task_restart(current);
 	  
 	return (TASK_ID)current->tcb;
 }
@@ -546,6 +586,7 @@ STATUS taskSuspend(TASK_ID tid)
 	if (task == NULL)
 		goto objid_error;
 
+	check_task_restart(wind_task_current());
 	ret = threadobj_suspend(&task->thobj);
 	put_wind_task(task);
 
@@ -648,7 +689,6 @@ STATUS taskPrioritySet(TASK_ID tid, int prio)
 		goto objid_error;
 
 	ret = check_task_priority(prio);
-
 	if (ret) {
 		put_wind_task(task);
 		errno = ret;
@@ -745,12 +785,13 @@ STATUS taskDelay(int ticks)
 	}
 
 	current = wind_task_current();
-
 	if (current == NULL) {
 		errno = S_objLib_OBJ_NO_METHOD;
 		return ERROR;
 	}
 
+	check_task_restart(current);
+
 	if (ticks == 0) {
 		sched_yield();	/* Manual round-robin. */
 		return OK;
diff --git a/vxworks/taskLib.h b/vxworks/taskLib.h
index 299d059..46718e1 100644
--- a/vxworks/taskLib.h
+++ b/vxworks/taskLib.h
@@ -20,6 +20,7 @@
 #define _VXWORKS_TASKLIB_H
 
 #include <semaphore.h>
+#include <setjmp.h>
 #include <xenomai/threadobj.h>
 #include <xenomai/registry.h>
 #include <vxworks/taskLib.h>
@@ -53,6 +54,8 @@ struct wind_task {
 	struct threadobj thobj;
 	struct fsobj fsobj;
 	struct hashobj obj;
+
+	jmp_buf ienv;
 };
 
 int wind_task_get_priority(struct wind_task *task);
@@ -97,6 +100,8 @@ struct wind_task *get_wind_task_or_self(TASK_ID tid);
 
 void put_wind_task(struct wind_task *task);
 
+void check_task_restart(struct wind_task *current);
+
 extern struct hash_table wind_task_table;
 
 #endif /* _VXWORKS_TASKLIB_H */


--------------090503030504050007010608--

