Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48B3F2C0.1000005@domain.hid>
Message-ID: <48B3EEC9.2040605@domain.hid>
Date: Tue, 26 Aug 2008 13:53:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48B3ED52.7080101@domain.hid>
In-Reply-To: <48B3ED52.7080101@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 3/6] Native skin: Use key-less registry
	entries
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

Make use of the new key-less property of xnregistry_enter, cleaning up
most pointless pseudo name creations for anonymous objects.

---
 ksrc/skins/native/alarm.c  |   22 +++++++++-------------
 ksrc/skins/native/buffer.c |   15 ++-------------
 ksrc/skins/native/cond.c   |   14 ++------------
 ksrc/skins/native/event.c  |   15 ++-------------
 ksrc/skins/native/heap.c   |   14 ++------------
 ksrc/skins/native/intr.c   |   17 +++--------------
 ksrc/skins/native/mutex.c  |   15 ++-------------
 ksrc/skins/native/pipe.c   |   14 ++------------
 ksrc/skins/native/queue.c  |   12 +-----------
 ksrc/skins/native/sem.c    |   14 ++------------
 ksrc/skins/native/task.c   |   16 ++--------------
 11 files changed, 29 insertions(+), 139 deletions(-)

Index: b/ksrc/skins/native/alarm.c
===================================================================
--- a/ksrc/skins/native/alarm.c
+++ b/ksrc/skins/native/alarm.c
@@ -212,24 +212,20 @@ int rt_alarm_create(RT_ALARM *alarm,
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
 	if (name) {
-#ifdef CONFIG_XENO_OPT_REGISTRY
-		/* <!> Since xnregister_enter() may reschedule, only register
-		   complete objects, so that the registry cannot return
-		   handles to half-baked objects... */
-
-		xnpnode_t *pnode = &__alarm_pnode;
-
 		if (!*name) {
-			/* Since this is an anonymous object (empty name on entry)
-			   from user-space, it gets registered under an unique
-			   internal name but is not exported through /proc. */
+			/* To improve readability in timer_base /proc
+			   output. */
 			xnobject_create_name(alarm->name, sizeof(alarm->name),
 					     (void *)alarm);
-			pnode = NULL;
 		}
 
-		err =
-		    xnregistry_enter(alarm->name, alarm, &alarm->handle, pnode);
+#ifdef CONFIG_XENO_OPT_REGISTRY
+		/* <!> Since xnregister_enter() may reschedule, only register
+		   complete objects, so that the registry cannot return
+		   handles to half-baked objects... */
+
+		err = xnregistry_enter((*name) ? alarm->name : "", alarm,
+				       &alarm->handle, &__alarm_pnode);
 
 		if (err)
 			rt_alarm_delete(alarm);
Index: b/ksrc/skins/native/buffer.c
===================================================================
--- a/ksrc/skins/native/buffer.c
+++ b/ksrc/skins/native/buffer.c
@@ -221,20 +221,9 @@ int rt_buffer_create(RT_BUFFER *bf, cons
 	 * handles to half-baked objects...
 	 */
 	if (name) {
-		xnpnode_t *pnode = &__buffer_pnode;
+		ret = xnregistry_enter(bf->name, bf, &bf->handle,
+				       &__buffer_pnode);
 
-		if (!*name) {
-			/*
-			 * Since this is an anonymous object (empty
-			 * name on entry) from user-space, it gets
-			 * registered under an unique internal name
-			 * but is not exported through /proc.
-			 */
-			xnobject_create_name(bf->name, sizeof(bf->name), bf);
-			pnode = NULL;
-		}
-
-		ret = xnregistry_enter(bf->name, bf, &bf->handle, pnode);
 		if (ret)
 			rt_buffer_delete(bf);
 	}
Index: b/ksrc/skins/native/cond.c
===================================================================
--- a/ksrc/skins/native/cond.c
+++ b/ksrc/skins/native/cond.c
@@ -180,18 +180,8 @@ int rt_cond_create(RT_COND *cond, const
 	   half-baked objects... */
 
 	if (name) {
-		xnpnode_t *pnode = &__cond_pnode;
-
-		if (!*name) {
-			/* Since this is an anonymous object (empty name on entry)
-			   from user-space, it gets registered under an unique
-			   internal name but is not exported through /proc. */
-			xnobject_create_name(cond->name, sizeof(cond->name),
-					     (void *)cond);
-			pnode = NULL;
-		}
-
-		err = xnregistry_enter(cond->name, cond, &cond->handle, pnode);
+		err = xnregistry_enter(cond->name, cond, &cond->handle,
+				       &__cond_pnode);
 
 		if (err)
 			rt_cond_delete(cond);
Index: b/ksrc/skins/native/event.c
===================================================================
--- a/ksrc/skins/native/event.c
+++ b/ksrc/skins/native/event.c
@@ -204,19 +204,8 @@ int rt_event_create(RT_EVENT *event,
 	   half-baked objects... */
 
 	if (name) {
-		xnpnode_t *pnode = &__event_pnode;
-
-		if (!*name) {
-			/* Since this is an anonymous object (empty name on entry)
-			   from user-space, it gets registered under an unique
-			   internal name but is not exported through /proc. */
-			xnobject_create_name(event->name, sizeof(event->name),
-					     (void *)event);
-			pnode = NULL;
-		}
-
-		err =
-		    xnregistry_enter(event->name, event, &event->handle, pnode);
+		err = xnregistry_enter(event->name, event, &event->handle,
+				       &__event_pnode);
 
 		if (err)
 			rt_event_delete(event);
Index: b/ksrc/skins/native/heap.c
===================================================================
--- a/ksrc/skins/native/heap.c
+++ b/ksrc/skins/native/heap.c
@@ -310,18 +310,8 @@ int rt_heap_create(RT_HEAP *heap, const
 	   half-baked objects... */
 
 	if (name) {
-		xnpnode_t *pnode = &__heap_pnode;
-
-		if (!*name) {
-			/* Since this is an anonymous object (empty name on entry)
-			   from user-space, it gets registered under an unique
-			   internal name but is not exported through /proc. */
-			xnobject_create_name(heap->name, sizeof(heap->name),
-					     (void *)heap);
-			pnode = NULL;
-		}
-
-		err = xnregistry_enter(heap->name, heap, &heap->handle, pnode);
+		err = xnregistry_enter(heap->name, heap, &heap->handle,
+				       &__heap_pnode);
 
 		if (err)
 			rt_heap_delete(heap);
Index: b/ksrc/skins/native/intr.c
===================================================================
--- a/ksrc/skins/native/intr.c
+++ b/ksrc/skins/native/intr.c
@@ -284,20 +284,9 @@ int rt_intr_create(RT_INTR *intr,
 	/* <!> Since xnregister_enter() may reschedule, only register
 	   complete objects, so that the registry cannot return handles to
 	   half-baked objects... */
-	if (!err && name) {
-		xnpnode_t *pnode = &__intr_pnode;
-
-		if (!*name) {
-			/* Since this is an anonymous object (empty name on entry)
-			 * from user-space, it gets registered under an unique
-			 * internal name but is not exported through /proc. */
-			xnobject_create_name(intr->name, sizeof(intr->name),
-				(void *)intr);
-			pnode = NULL;
-		}
-
-		err = xnregistry_enter(intr->name, intr, &intr->handle, pnode);
-	}	
+	if (!err && name)
+		err = xnregistry_enter(intr->name, intr, &intr->handle,
+				       &__intr_pnode);
 	
 #endif /* CONFIG_XENO_OPT_REGISTRY */
 
Index: b/ksrc/skins/native/mutex.c
===================================================================
--- a/ksrc/skins/native/mutex.c
+++ b/ksrc/skins/native/mutex.c
@@ -191,19 +191,8 @@ int rt_mutex_create(RT_MUTEX *mutex, con
 	   half-baked objects... */
 
 	if (name) {
-		xnpnode_t *pnode = &__mutex_pnode;
-
-		if (!*name) {
-			/* Since this is an anonymous object (empty name on entry)
-			   from user-space, it gets registered under an unique
-			   internal name but is not exported through /proc. */
-			xnobject_create_name(mutex->name, sizeof(mutex->name),
-					     (void *)mutex);
-			pnode = NULL;
-		}
-
-		err =
-		    xnregistry_enter(mutex->name, mutex, &mutex->handle, pnode);
+		err = xnregistry_enter(mutex->name, mutex, &mutex->handle,
+				       &__mutex_pnode);
 
 		if (err)
 			rt_mutex_delete(mutex);
Index: b/ksrc/skins/native/pipe.c
===================================================================
--- a/ksrc/skins/native/pipe.c
+++ b/ksrc/skins/native/pipe.c
@@ -338,18 +338,8 @@ int rt_pipe_create(RT_PIPE *pipe, const
 	   half-baked objects... */
 
 	if (name) {
-		xnpnode_t *pnode = &__pipe_pnode;
-
-		if (!*name) {
-			/* Since this is an anonymous object (empty name on entry)
-			   from user-space, it gets registered under an unique
-			   internal name but is not exported through /proc. */
-			xnobject_create_name(pipe->name, sizeof(pipe->name),
-					     (void *)pipe);
-			pnode = NULL;
-		}
-
-		err = xnregistry_enter(pipe->name, pipe, &pipe->handle, pnode);
+		err = xnregistry_enter(pipe->name, pipe, &pipe->handle,
+				       &__pipe_pnode);
 
 		if (err)
 			rt_pipe_delete(pipe);
Index: b/ksrc/skins/native/queue.c
===================================================================
--- a/ksrc/skins/native/queue.c
+++ b/ksrc/skins/native/queue.c
@@ -274,17 +274,7 @@ int rt_queue_create(RT_QUEUE *q,
 	   half-baked objects... */
 
 	if (name) {
-		xnpnode_t *pnode = &__queue_pnode;
-
-		if (!*name) {
-			/* Since this is an anonymous object (empty name on entry)
-			   from user-space, it gets registered under an unique
-			   internal name but is not exported through /proc. */
-			xnobject_create_name(q->name, sizeof(q->name), q);
-			pnode = NULL;
-		}
-
-		err = xnregistry_enter(q->name, q, &q->handle, pnode);
+		err = xnregistry_enter(q->name, q, &q->handle, &__queue_pnode);
 
 		if (err)
 			rt_queue_delete(q);
Index: b/ksrc/skins/native/sem.c
===================================================================
--- a/ksrc/skins/native/sem.c
+++ b/ksrc/skins/native/sem.c
@@ -203,18 +203,8 @@ int rt_sem_create(RT_SEM *sem, const cha
 	   half-baked objects... */
 
 	if (name) {
-		xnpnode_t *pnode = &__sem_pnode;
-
-		if (!*name) {
-			/* Since this is an anonymous object (empty name on entry)
-			   from user-space, it gets registered under an unique
-			   internal name but is not exported through /proc. */
-			xnobject_create_name(sem->name, sizeof(sem->name),
-					     (void *)sem);
-			pnode = NULL;
-		}
-
-		err = xnregistry_enter(sem->name, sem, &sem->handle, pnode);
+		err = xnregistry_enter(sem->name, sem, &sem->handle,
+				       &__sem_pnode);
 
 		if (err)
 			rt_sem_delete(sem);
Index: b/ksrc/skins/native/task.c
===================================================================
--- a/ksrc/skins/native/task.c
+++ b/ksrc/skins/native/task.c
@@ -248,15 +248,8 @@ int rt_task_create(RT_TASK *task,
 
 	bflags = mode & (XNFPU | XNSHADOW | XNSHIELD | XNSUSP);
 
-	if (name) {
-		if (!*name)
-			/* i.e. Anonymous object which must be accessible from
-			   user-space. */
-			xnobject_create_name(task->rname, sizeof(task->rname),
-					     task);
-		else
-			xnobject_copy_name(task->rname, name);
-	}
+	if (name)
+		xnobject_copy_name(task->rname, name);
 
 	if (xnpod_init_thread(&task->thread_base, __native_tbase,
 			      name, prio, bflags, stksize, &__xeno_task_ops) != 0)
@@ -304,11 +297,6 @@ int rt_task_create(RT_TASK *task,
 				       NULL);
 		if (err)
 			xnpod_delete_thread(&task->thread_base);
-		else if (!*name)
-			/* /proc/xenomai/sched will dump no name for the anonymous
-			   task, but the registry still has a stable reference
-			   into the TCB to set up a handle for the task. */
-			xnthread_clear_name(&task->thread_base);
 	}
 #endif /* CONFIG_XENO_OPT_REGISTRY */
 


