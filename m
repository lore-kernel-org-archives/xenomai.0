Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48F764A5.6050209@domain.hid>
Message-Id: <20081016154621.644116499@domain.hid>
Date: Thu, 16 Oct 2008 17:46:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
References: <20081016154620.320953568@domain.hid>
Content-Disposition: inline; filename=switch-native-to-fast-xnsynch.patch
Subject: [Xenomai-core] [PATCH 08/12] Use fast xnsynch with native skin
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

Implement a fast path for rt_mutex_acquire/release, making use of fast
xnsynch services. Just as for the POSIX skin, lock stealing via trylock
is sacrificed for a syscall-less user space implementation.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/native/mutex.h      |   23 ++-
 ksrc/skins/native/cond.c    |   16 +-
 ksrc/skins/native/mutex.c   |  314 ++++++++++++++++++++++++++------------------
 ksrc/skins/native/syscall.c |   70 +++++++--
 src/skins/native/cond.c     |   30 ++++
 src/skins/native/mutex.c    |  102 +++++++++++++-
 6 files changed, 398 insertions(+), 157 deletions(-)

Index: b/include/native/mutex.h
===================================================================
--- a/include/native/mutex.h
+++ b/include/native/mutex.h
@@ -32,7 +32,7 @@ struct rt_task;
  */
 typedef struct rt_mutex_info {
 
-	int lockcnt;		/**< Lock nesting level (> 0 means "locked"). */
+	int locked;		/**< > 0 if mutex is locked. */
 
 	int nwaiters;		/**< Number of pending tasks. */
 
@@ -44,7 +44,15 @@ typedef struct rt_mutex_info {
 } RT_MUTEX_INFO;
 
 typedef struct rt_mutex_placeholder {
+
 	xnhandle_t opaque;
+
+#ifdef CONFIG_XENO_FASTSYNCH
+	xnarch_atomic_t *fastlock;
+
+	int lockcnt;
+#endif /* CONFIG_XENO_FASTSYNCH */
+
 } RT_MUTEX_PLACEHOLDER;
 
 #if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_CPP)
@@ -54,6 +62,8 @@ typedef struct rt_mutex_placeholder {
 
 #define XENO_MUTEX_MAGIC 0x55550505
 
+#define RT_MUTEX_EXPORTED	XNSYNCH_SPARE0	/* Mutex registered by name */
+
 typedef struct __rt_mutex {
 
 	unsigned magic;		/* !< Magic code - must be first */
@@ -74,7 +84,7 @@ typedef struct __rt_mutex {
 
 #define rlink2mutex(ln)		container_of(ln, RT_MUTEX, rlink)
 
-    xnqueue_t *rqueue;		/* !< Backpointer to resource queue. */
+	xnqueue_t *rqueue;	/* !< Backpointer to resource queue. */
 
 } RT_MUTEX;
 
@@ -93,9 +103,8 @@ static inline void __native_mutex_flush_
 	xeno_flush_rq(RT_MUTEX, rq, mutex);
 }
 
-int rt_mutex_acquire_inner(RT_MUTEX *mutex,
-			   xntmode_t timeout_mode,
-			   RTIME timeout);
+int rt_mutex_acquire_inner(RT_MUTEX *mutex, RTIME timeout,
+			   xntmode_t timeout_mode);
 
 #else /* !CONFIG_XENO_OPT_NATIVE_MUTEX */
 
@@ -138,6 +147,10 @@ static inline int rt_mutex_unbind (RT_MU
 extern "C" {
 #endif
 
+int rt_mutex_create_inner(RT_MUTEX *mutex, const char *name,
+			  xnarch_atomic_t *fastlock);
+int rt_mutex_delete_inner(RT_MUTEX *mutex);
+
 /* Public interface. */
 
 int rt_mutex_create(RT_MUTEX *mutex,
Index: b/ksrc/skins/native/cond.c
===================================================================
--- a/ksrc/skins/native/cond.c
+++ b/ksrc/skins/native/cond.c
@@ -407,24 +407,26 @@ int rt_cond_wait_inner(RT_COND *cond, RT
 
 	thread = xnpod_current_thread();
 
-	if (thread != xnsynch_owner(&mutex->synch_base)) {
+#ifdef CONFIG_XENO_FASTSYNCH
+	if (xnsynch_fast_owner_check(mutex->synch_base.fastlock,
+				     xnthread_handle(thread)) != 0) {
+#else /* !CONFIG_XENO_FASTSYNCH */
+	if (xnsynch_owner(&mutex->synch_base) != thread) {
+#endif /* !CONFIG_XENO_FASTSYNCH */
 		err = -EPERM;
 		goto unlock_and_exit;
 	}
 
 	/*
 	 * We can't use rt_mutex_release since that might reschedule
-	 * before enter xnsynch_sleep_on, hence most of the code is
-	 * duplicated here.
+	 * before enter xnsynch_sleep_on.
 	 */
 	lockcnt = mutex->lockcnt; /* Leave even if mutex is nested */
 
 	mutex->lockcnt = 0;
 
-	if (xnsynch_release(&mutex->synch_base)) {
-		mutex->lockcnt = 1;
-		/* Scheduling deferred */
-	}
+	xnsynch_release(&mutex->synch_base);
+	/* Scheduling deferred */
 
 	xnsynch_sleep_on(&cond->synch_base, timeout, timeout_mode);
 
Index: b/ksrc/skins/native/mutex.c
===================================================================
--- a/ksrc/skins/native/mutex.c
+++ b/ksrc/skins/native/mutex.c
@@ -57,29 +57,42 @@ static int __mutex_read_proc(char *page,
 			     off_t off, int count, int *eof, void *data)
 {
 	RT_MUTEX *mutex = (RT_MUTEX *)data;
+#ifdef CONFIG_XENO_FASTSYNCH
+	xnhandle_t lock_state;
+#endif /* CONFIG_XENO_FASTSYNCH */
+	xnthread_t *owner;
 	char *p = page;
 	int len;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
 
-	if (xnsynch_owner(&mutex->synch_base) != NULL) {
-		xnpholder_t *holder;
+#ifndef CONFIG_XENO_FASTSYNCH
+	owner = xnsynch_owner(&mutex->synch_base);
+#else /* CONFIG_XENO_FASTSYNCH */
+	lock_state = xnarch_atomic_get(mutex->synch_base.fastlock);
+
+	owner = (lock_state == XN_NO_HANDLE) ? NULL :
+		xnthread_lookup(xnsynch_fast_mask_claimed(lock_state));
 
+	if (!owner && lock_state != XN_NO_HANDLE)
+		p += sprintf(p, "=<DAMAGED HANDLE!>");
+	else
+#endif /* CONFIG_XENO_FASTSYNCH */
+	if (owner) {
 		/* Locked mutex -- dump owner and waiters, if any. */
+		xnpholder_t *holder;
 
-		p += sprintf(p, "=locked by %s depth=%d\n",
-			     xnthread_name(xnsynch_owner(&mutex->synch_base)),
-			     mutex->lockcnt);
+		p += sprintf(p, "=locked by %s\n", xnthread_name(owner));
 
 		holder = getheadpq(xnsynch_wait_queue(&mutex->synch_base));
 
 		while (holder) {
 			xnthread_t *sleeper = link2thread(holder, plink);
+
 			p += sprintf(p, "+%s\n", xnthread_name(sleeper));
-			holder =
-			    nextpq(xnsynch_wait_queue(&mutex->synch_base),
-				   holder);
+			holder = nextpq(xnsynch_wait_queue(&mutex->synch_base),
+					holder);
 		}
 	} else
 		/* Mutex unlocked. */
@@ -120,49 +133,8 @@ static xnpnode_t __mutex_pnode = {
 
 #endif /* CONFIG_XENO_EXPORT_REGISTRY */
 
-/**
- * @fn int rt_mutex_create(RT_MUTEX *mutex,const char *name)
- *
- * @brief Create a mutex.
- *
- * Create a mutual exclusion object that allows multiple tasks to
- * synchronize access to a shared resource. A mutex is left in an
- * unlocked state after creation.
- *
- * @param mutex The address of a mutex descriptor Xenomai will use to
- * store the mutex-related data.  This descriptor must always be valid
- * while the mutex is active therefore it must be allocated in
- * permanent memory.
- *
- * @param name An ASCII string standing for the symbolic name of the
- * mutex. When non-NULL and non-empty, this string is copied to a safe
- * place into the descriptor, and passed to the registry package if
- * enabled for indexing the created mutex.
- *
- * @return 0 is returned upon success. Otherwise:
- *
- * - -ENOMEM is returned if the system fails to get enough dynamic
- * memory from the global real-time heap in order to register the
- * mutex.
- *
- * - -EEXIST is returned if the @a name is already in use by some
- * registered object.
- *
- * - -EPERM is returned if this service was called from an
- * asynchronous context.
- *
- * Environments:
- *
- * This service can be called from:
- *
- * - Kernel module initialization/cleanup code
- * - Kernel-based task
- * - User-space task
- *
- * Rescheduling: possible.
- */
-
-int rt_mutex_create(RT_MUTEX *mutex, const char *name)
+int rt_mutex_create_inner(RT_MUTEX *mutex, const char *name,
+			  xnarch_atomic_t *fastlock)
 {
 	int err = 0;
 	spl_t s;
@@ -171,7 +143,7 @@ int rt_mutex_create(RT_MUTEX *mutex, con
 		return -EPERM;
 
 	xnsynch_init(&mutex->synch_base,
-		     XNSYNCH_PRIO | XNSYNCH_PIP | XNSYNCH_OWNER, NULL);
+		     XNSYNCH_PRIO | XNSYNCH_PIP | XNSYNCH_OWNER, fastlock);
 	mutex->handle = 0;	/* i.e. (still) unregistered mutex. */
 	mutex->magic = XENO_MUTEX_MAGIC;
 	mutex->lockcnt = 0;
@@ -196,7 +168,7 @@ int rt_mutex_create(RT_MUTEX *mutex, con
 				       &__mutex_pnode);
 
 		if (err)
-			rt_mutex_delete(mutex);
+			rt_mutex_delete_inner(mutex);
 	}
 #endif /* CONFIG_XENO_OPT_REGISTRY */
 
@@ -204,22 +176,32 @@ int rt_mutex_create(RT_MUTEX *mutex, con
 }
 
 /**
- * @fn int rt_mutex_delete(RT_MUTEX *mutex)
+ * @fn int rt_mutex_create(RT_MUTEX *mutex,const char *name)
  *
- * @brief Delete a mutex.
+ * @brief Create a mutex.
  *
- * Destroy a mutex and release all the tasks currently pending on it.
- * A mutex exists in the system since rt_mutex_create() has been
- * called to create it, so this service must be called in order to
- * destroy it afterwards.
+ * Create a mutual exclusion object that allows multiple tasks to
+ * synchronize access to a shared resource. A mutex is left in an
+ * unlocked state after creation.
  *
- * @param mutex The descriptor address of the affected mutex.
+ * @param mutex The address of a mutex descriptor Xenomai will use to
+ * store the mutex-related data.  This descriptor must always be valid
+ * while the mutex is active therefore it must be allocated in
+ * permanent memory.
+ *
+ * @param name An ASCII string standing for the symbolic name of the
+ * mutex. When non-NULL and non-empty, this string is copied to a safe
+ * place into the descriptor, and passed to the registry package if
+ * enabled for indexing the created mutex.
  *
  * @return 0 is returned upon success. Otherwise:
  *
- * - -EINVAL is returned if @a mutex is not a mutex descriptor.
+ * - -ENOMEM is returned if the system fails to get enough dynamic
+ * memory from the global real-time heap in order to register the
+ * mutex.
  *
- * - -EIDRM is returned if @a mutex is a deleted mutex descriptor.
+ * - -EEXIST is returned if the @a name is already in use by some
+ * registered object.
  *
  * - -EPERM is returned if this service was called from an
  * asynchronous context.
@@ -235,7 +217,30 @@ int rt_mutex_create(RT_MUTEX *mutex, con
  * Rescheduling: possible.
  */
 
-int rt_mutex_delete(RT_MUTEX *mutex)
+int rt_mutex_create(RT_MUTEX *mutex, const char *name)
+{
+	xnarch_atomic_t *fastlock = NULL;
+	int err;
+
+#ifdef CONFIG_XENO_FASTSYNCH
+	/* Allocate lock memory for in-kernel use */
+	fastlock = xnmalloc(sizeof(xnarch_atomic_t));
+
+	if (!fastlock)
+		return -ENOMEM;
+#endif /* CONFIG_XENO_FASTSYNCH */
+
+	err = rt_mutex_create_inner(mutex, name, fastlock);
+
+#ifdef CONFIG_XENO_FASTSYNCH
+	if (err)
+		xnfree(fastlock);
+#endif /* CONFIG_XENO_FASTSYNCH */
+
+	return err;
+}
+
+int rt_mutex_delete_inner(RT_MUTEX *mutex)
 {
 	int err = 0, rc;
 	spl_t s;
@@ -275,61 +280,116 @@ int rt_mutex_delete(RT_MUTEX *mutex)
 	return err;
 }
 
-int rt_mutex_acquire_inner(RT_MUTEX *mutex, xntmode_t timeout_mode, RTIME timeout)
+/**
+ * @fn int rt_mutex_delete(RT_MUTEX *mutex)
+ *
+ * @brief Delete a mutex.
+ *
+ * Destroy a mutex and release all the tasks currently pending on it.
+ * A mutex exists in the system since rt_mutex_create() has been
+ * called to create it, so this service must be called in order to
+ * destroy it afterwards.
+ *
+ * @param mutex The descriptor address of the affected mutex.
+ *
+ * @return 0 is returned upon success. Otherwise:
+ *
+ * - -EINVAL is returned if @a mutex is not a mutex descriptor.
+ *
+ * - -EIDRM is returned if @a mutex is a deleted mutex descriptor.
+ *
+ * - -EPERM is returned if this service was called from an
+ * asynchronous context.
+ *
+ * Environments:
+ *
+ * This service can be called from:
+ *
+ * - Kernel module initialization/cleanup code
+ * - Kernel-based task
+ * - User-space task
+ *
+ * Rescheduling: possible.
+ */
+
+int rt_mutex_delete(RT_MUTEX *mutex)
+{
+	int err;
+
+	err = rt_mutex_delete_inner(mutex);
+
+#ifdef CONFIG_XENO_FASTSYNCH
+	if (!err)
+		xnfree(mutex->synch_base.fastlock);
+#endif /* CONFIG_XENO_FASTSYNCH */
+
+	return err;
+}
+
+int rt_mutex_acquire_inner(RT_MUTEX *mutex, RTIME timeout,
+			   xntmode_t timeout_mode)
 {
 	xnthread_t *thread;
-	int err = 0;
-	spl_t s;
 
 	if (xnpod_unblockable_p())
 		return -EPERM;
 
-	xnlock_get_irqsave(&nklock, s);
-
 	mutex = xeno_h2obj_validate(mutex, XENO_MUTEX_MAGIC, RT_MUTEX);
 
-	if (!mutex) {
-		err = xeno_handle_error(mutex, XENO_MUTEX_MAGIC, RT_MUTEX);
-		goto unlock_and_exit;
-	}
+	if (!mutex)
+		return xeno_handle_error(mutex, XENO_MUTEX_MAGIC, RT_MUTEX);
 
 	thread = xnpod_current_thread();
 
-	if (xnsynch_owner(&mutex->synch_base) == NULL) {
-		xnsynch_set_owner(&mutex->synch_base, thread);
-		goto grab_mutex;
-	}
-
+#ifdef CONFIG_XENO_FASTSYNCH
+	if (xnsynch_fast_owner_check(mutex->synch_base.fastlock,
+				     xnthread_handle(thread)) == 0) {
+#else /* !CONFIG_XENO_FASTSYNCH */
 	if (xnsynch_owner(&mutex->synch_base) == thread) {
+#endif /* !CONFIG_XENO_FASTSYNCH */
 		mutex->lockcnt++;
-		goto unlock_and_exit;
+		return 0;
 	}
 
-	if (timeout == TM_NONBLOCK) {
-		err = -EWOULDBLOCK;
-		goto unlock_and_exit;
+	if (timeout == TM_NONBLOCK && timeout_mode == XN_RELATIVE) {
+#ifdef CONFIG_XENO_FASTSYNCH
+		if (xnsynch_fast_acquire(mutex->synch_base.fastlock,
+					 xnthread_handle(thread)) == 0) {
+			mutex->lockcnt = 1;
+			return 0;
+		} else
+			return -EWOULDBLOCK;
+
+#else /* !CONFIG_XENO_FASTSYNCH */
+		int err = 0;
+		spl_t s;
+
+		xnlock_get_irqsave(&nklock, s);
+		if (xnsynch_owner(&mutex->synch_base) == NULL)
+			mutex->lockcnt = 1;
+		else
+			err = -EWOULDBLOCK;
+		xnlock_put_irqrestore(&nklock, s);
+		return err;
+#endif /* !CONFIG_XENO_FASTSYNCH */
 	}
 
 	xnsynch_acquire(&mutex->synch_base, timeout, timeout_mode);
 
-	if (xnthread_test_info(thread, XNRMID))
-		err = -EIDRM;	/* Mutex deleted while pending. */
-	else if (xnthread_test_info(thread, XNTIMEO))
-		err = -ETIMEDOUT;	/* Timeout. */
-	else if (xnthread_test_info(thread, XNBREAK))
-		err = -EINTR;	/* Unblocked. */
-	else {
-	      grab_mutex:
-		/* xnsynch_sleep_on() might have stolen the resource,
-		   so we need to put our internal data in sync. */
-		mutex->lockcnt = 1;
+	if (unlikely(xnthread_test_info(thread, XNBREAK | XNRMID | XNTIMEO))) {
+		if (xnthread_test_info(thread, XNBREAK))
+			return -EINTR;
+		else if (xnthread_test_info(thread, XNTIMEO))
+			return -ETIMEDOUT;
+		else /* XNRMID */
+			return -EIDRM;
 	}
 
-      unlock_and_exit:
+	/* xnsynch_sleep_on() might have stolen the resource,
+	   so we need to put our internal data in sync. */
+	mutex->lockcnt = 1;
 
-	xnlock_put_irqrestore(&nklock, s);
-
-	return err;
+	return 0;
 }
 
 /**
@@ -398,7 +458,7 @@ int rt_mutex_acquire_inner(RT_MUTEX *mut
 
 int rt_mutex_acquire(RT_MUTEX *mutex, RTIME timeout)
 {
-	return rt_mutex_acquire_inner(mutex, XN_RELATIVE, timeout);
+	return rt_mutex_acquire_inner(mutex, timeout, XN_RELATIVE);
 }
 
 /**
@@ -464,7 +524,7 @@ int rt_mutex_acquire(RT_MUTEX *mutex, RT
 
 int rt_mutex_acquire_until(RT_MUTEX *mutex, RTIME timeout)
 {
-	return rt_mutex_acquire_inner(mutex, XN_REALTIME, timeout);
+	return rt_mutex_acquire_inner(mutex, timeout, XN_REALTIME);
 }
 
 /**
@@ -501,39 +561,33 @@ int rt_mutex_acquire_until(RT_MUTEX *mut
 
 int rt_mutex_release(RT_MUTEX *mutex)
 {
-	int err = 0;
-	spl_t s;
+	xnthread_t *thread = xnpod_current_thread();
+	int err;
 
 	if (xnpod_unblockable_p())
 		return -EPERM;
 
-	xnlock_get_irqsave(&nklock, s);
-
 	mutex = xeno_h2obj_validate(mutex, XENO_MUTEX_MAGIC, RT_MUTEX);
 
-	if (!mutex) {
-		err = xeno_handle_error(mutex, XENO_MUTEX_MAGIC, RT_MUTEX);
-		goto unlock_and_exit;
-	}
+	if (!mutex)
+		return xeno_handle_error(mutex, XENO_MUTEX_MAGIC, RT_MUTEX);
 
-	if (xnpod_current_thread() != xnsynch_owner(&mutex->synch_base)) {
-		err = -EPERM;
-		goto unlock_and_exit;
-	}
+#ifdef CONFIG_XENO_FASTSYNCH
+	err = xnsynch_fast_owner_check(mutex->synch_base.fastlock,
+					xnthread_handle(thread));
+#else /* !CONFIG_XENO_FASTSYNCH */
+	err = (xnsynch_owner(&mutex->synch_base) == thread) ? 0 : -EPERM;
+#endif /* !CONFIG_XENO_FASTSYNCH */
+	if (err)
+		return err;
 
 	if (--mutex->lockcnt > 0)
-		goto unlock_and_exit;
+		return 0;
 
-	if (xnsynch_release(&mutex->synch_base)) {
-		mutex->lockcnt = 1;
+	if (xnsynch_release(&mutex->synch_base))
 		xnpod_schedule();
-	}
 
-      unlock_and_exit:
-
-	xnlock_put_irqrestore(&nklock, s);
-
-	return err;
+	return 0;
 }
 
 /**
@@ -569,6 +623,10 @@ int rt_mutex_release(RT_MUTEX *mutex)
 
 int rt_mutex_inquire(RT_MUTEX *mutex, RT_MUTEX_INFO *info)
 {
+#ifdef CONFIG_XENO_FASTSYNCH
+	xnhandle_t lock_state;
+#endif /* CONFIG_XENO_FASTSYNCH */
+	xnthread_t *owner;
 	int err = 0;
 	spl_t s;
 
@@ -582,11 +640,21 @@ int rt_mutex_inquire(RT_MUTEX *mutex, RT
 	}
 
 	strcpy(info->name, mutex->name);
-	info->lockcnt = mutex->lockcnt;
 	info->nwaiters = xnsynch_nsleepers(&mutex->synch_base);
-	if (mutex->lockcnt)
-		strcpy(info->owner,
-		       xnthread_name(xnsynch_owner(&mutex->synch_base)));
+
+#ifndef CONFIG_XENO_FASTSYNCH
+	owner = xnsynch_owner(&mutex->synch_base);
+#else /* CONFIG_XENO_FASTSYNCH */
+	lock_state = xnarch_atomic_get(mutex->synch_base.fastlock);
+	info->locked = (lock_state != XN_NO_HANDLE);
+	owner = (info->locked) ?
+		xnthread_lookup(xnsynch_fast_mask_claimed(lock_state)) : NULL;
+	if (!owner && info->locked)
+		strcpy(info->owner, "<DAMAGED HANDLE!>");
+	else
+#endif /* CONFIG_XENO_FASTSYNCH */
+	if (owner)
+		strcpy(info->owner, xnthread_name(owner));
 	else
 		info->owner[0] = 0;
 
Index: b/ksrc/skins/native/syscall.c
===================================================================
--- a/ksrc/skins/native/syscall.c
+++ b/ksrc/skins/native/syscall.c
@@ -24,6 +24,7 @@
 #include <nucleus/heap.h>
 #include <nucleus/shadow.h>
 #include <nucleus/registry.h>
+#include <nucleus/sys_ppd.h>
 #include <native/syscall.h>
 #include <native/task.h>
 #include <native/timer.h>
@@ -1532,6 +1533,8 @@ static int __rt_event_inquire(struct pt_
 static int __rt_mutex_create(struct pt_regs *regs)
 {
 	char name[XNOBJECT_NAME_LEN];
+	xnarch_atomic_t *fastlock = NULL;
+	xnheap_t *sem_heap;
 	RT_MUTEX_PLACEHOLDER ph;
 	RT_MUTEX *mutex;
 	int err;
@@ -1546,22 +1549,45 @@ static int __rt_mutex_create(struct pt_r
 	} else
 		*name = '\0';
 
+	sem_heap = &xnsys_ppd_get(*name != '\0')->sem_heap;
+
 	mutex = (RT_MUTEX *)xnmalloc(sizeof(*mutex));
 
 	if (!mutex)
 		return -ENOMEM;
 
-	err = rt_mutex_create(mutex, name);
+#ifdef CONFIG_XENO_FASTSYNCH
+	fastlock = xnheap_alloc(sem_heap, sizeof(xnarch_atomic_t));
+
+	if (!fastlock) {
+		xnfree(mutex);
+		return -ENOMEM;
+	}
+#endif /* CONFIG_XENO_FASTSYNCH */
+
+	err = rt_mutex_create_inner(mutex, name, fastlock);
 
 	if (err == 0) {
 		mutex->cpid = current->pid;
 		/* Copy back the registry handle to the ph struct. */
 		ph.opaque = mutex->handle;
+#ifdef CONFIG_XENO_FASTSYNCH
+		/* The lock address will be finished in user space. */
+		ph.fastlock =
+			(void *)xnheap_mapped_offset(sem_heap, fastlock);
+		if (*name != '\0')
+			xnsynch_set_flags(&mutex->synch_base,
+					  RT_MUTEX_EXPORTED);
+#endif /* CONFIG_XENO_FASTSYNCH */
 		if (__xn_safe_copy_to_user((void __user *)__xn_reg_arg1(regs), &ph,
 					   sizeof(ph)))
 			err = -EFAULT;
-	} else
+	} else {
+#ifdef CONFIG_XENO_FASTSYNCH
+		xnheap_free(&xnsys_ppd_get(*name != '\0')->sem_heap, fastlock);
+#endif /* CONFIG_XENO_FASTSYNCH */
 		xnfree(mutex);
+	}
 
 	return err;
 }
@@ -1575,15 +1601,22 @@ static int __rt_mutex_create(struct pt_r
 static int __rt_mutex_bind(struct pt_regs *regs)
 {
 	RT_MUTEX_PLACEHOLDER ph;
+	RT_MUTEX *mutex;
 	int err;
 
 	err =
 	    __rt_bind_helper(current, regs, &ph.opaque, XENO_MUTEX_MAGIC,
-			     NULL, 0);
+			     (void **)&mutex, 0);
 
 	if (err)
 		return err;
 
+#ifdef CONFIG_XENO_FASTSYNCH
+	ph.fastlock =
+		(void *)xnheap_mapped_offset(&xnsys_ppd_get(1)->sem_heap,
+					     mutex->synch_base.fastlock);
+#endif /* CONFIG_XENO_FASTSYNCH */
+
 	if (__xn_safe_copy_to_user((void __user *)__xn_reg_arg1(regs), &ph,
 			      sizeof(ph)))
 		return -EFAULT;
@@ -1610,10 +1643,17 @@ static int __rt_mutex_delete(struct pt_r
 	if (!mutex)
 		return -ESRCH;
 
-	err = rt_mutex_delete(mutex);
+	err = rt_mutex_delete_inner(mutex);
 
-	if (!err && mutex->cpid)
+	if (!err && mutex->cpid) {
+#ifdef CONFIG_XENO_FASTSYNCH
+		int global = xnsynch_test_flags(&mutex->synch_base,
+						RT_MUTEX_EXPORTED);
+		xnheap_free(&xnsys_ppd_get(global)->sem_heap,
+			    mutex->synch_base.fastlock);
+#endif /* CONFIG_XENO_FASTSYNCH */
 		xnfree(mutex);
+	}
 
 	return err;
 }
@@ -1626,13 +1666,14 @@ static int __rt_mutex_delete(struct pt_r
 
 static int __rt_mutex_acquire(struct pt_regs *regs)
 {
-	RT_MUTEX_PLACEHOLDER ph;
+	RT_MUTEX_PLACEHOLDER __user *ph;
 	xntmode_t timeout_mode;
+	xnhandle_t mutexh;
 	RT_MUTEX *mutex;
 	RTIME timeout;
 
-	if (__xn_safe_copy_from_user(&ph, (void __user *)__xn_reg_arg1(regs),
-				     sizeof(ph)))
+	ph = (RT_MUTEX_PLACEHOLDER __user *)__xn_reg_arg1(regs);
+	if (__xn_safe_copy_from_user(&mutexh, &ph->opaque, sizeof(mutexh)))
 		return -EFAULT;
 
 	timeout_mode = __xn_reg_arg2(regs);
@@ -1641,12 +1682,12 @@ static int __rt_mutex_acquire(struct pt_
 				     sizeof(timeout)))
 		return -EFAULT;
 
-	mutex = (RT_MUTEX *)xnregistry_fetch(ph.opaque);
+	mutex = (RT_MUTEX *)xnregistry_fetch(mutexh);
 
 	if (!mutex)
 		return -ESRCH;
 
-	return rt_mutex_acquire_inner(mutex, timeout_mode, timeout);
+	return rt_mutex_acquire_inner(mutex, timeout, timeout_mode);
 }
 
 /*
@@ -1655,14 +1696,15 @@ static int __rt_mutex_acquire(struct pt_
 
 static int __rt_mutex_release(struct pt_regs *regs)
 {
-	RT_MUTEX_PLACEHOLDER ph;
+	RT_MUTEX_PLACEHOLDER __user *ph;
+	xnhandle_t mutexh;
 	RT_MUTEX *mutex;
 
-	if (__xn_safe_copy_from_user(&ph, (void __user *)__xn_reg_arg1(regs),
-				     sizeof(ph)))
+	ph = (RT_MUTEX_PLACEHOLDER __user *)__xn_reg_arg1(regs);
+	if (__xn_safe_copy_from_user(&mutexh, &ph->opaque, sizeof(mutexh)))
 		return -EFAULT;
 
-	mutex = (RT_MUTEX *)xnregistry_fetch(ph.opaque);
+	mutex = (RT_MUTEX *)xnregistry_fetch(mutexh);
 
 	if (!mutex)
 		return -ESRCH;
Index: b/src/skins/native/cond.c
===================================================================
--- a/src/skins/native/cond.c
+++ b/src/skins/native/cond.c
@@ -41,16 +41,46 @@ int rt_cond_delete(RT_COND *cond)
 
 int rt_cond_wait(RT_COND *cond, RT_MUTEX *mutex, RTIME timeout)
 {
+#ifdef CONFIG_XENO_FASTSYNCH
+	int saved_lockcnt, err;
+
+	saved_lockcnt = mutex->lockcnt;
+
+	err = XENOMAI_SKINCALL4(__native_muxid,
+				__native_cond_wait, cond, mutex,
+				XN_RELATIVE, &timeout);
+
+	mutex->lockcnt = saved_lockcnt;
+
+	return err;
+
+#else /* !CONFIG_XENO_FASTSYNCH */
 	return XENOMAI_SKINCALL4(__native_muxid,
 				 __native_cond_wait, cond, mutex,
 				 XN_RELATIVE, &timeout);
+#endif /* !CONFIG_XENO_FASTSYNCH */
 }
 
 int rt_cond_wait_until(RT_COND *cond, RT_MUTEX *mutex, RTIME timeout)
 {
+#ifdef CONFIG_XENO_FASTSYNCH
+	int saved_lockcnt, err;
+
+	saved_lockcnt = mutex->lockcnt;
+
+	err = XENOMAI_SKINCALL4(__native_muxid,
+				__native_cond_wait, cond, mutex,
+				XN_REALTIME, &timeout);
+
+	mutex->lockcnt = saved_lockcnt;
+
+	return err;
+
+#else /* !CONFIG_XENO_FASTSYNCH */
 	return XENOMAI_SKINCALL4(__native_muxid,
 				 __native_cond_wait, cond, mutex,
 				 XN_REALTIME, &timeout);
+#endif /* !CONFIG_XENO_FASTSYNCH */
 }
 
 int rt_cond_signal(RT_COND *cond)
Index: b/src/skins/native/mutex.c
===================================================================
--- a/src/skins/native/mutex.c
+++ b/src/skins/native/mutex.c
@@ -16,21 +16,51 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <limits.h>
+#include <nucleus/synch.h>
 #include <native/syscall.h>
 #include <native/mutex.h>
+#include <asm-generic/bits/current.h>
 
 extern int __native_muxid;
+extern unsigned long xeno_sem_heap[2];
 
 int rt_mutex_create(RT_MUTEX *mutex, const char *name)
 {
-	return XENOMAI_SKINCALL2(__native_muxid,
-				 __native_mutex_create, mutex, name);
+	int err;
+
+	err = XENOMAI_SKINCALL2(__native_muxid,
+				__native_mutex_create, mutex, name);
+
+#ifdef CONFIG_XENO_FASTSYNCH
+	if (!err) {
+		mutex->fastlock = (xnarch_atomic_t *)
+			(xeno_sem_heap[(name && *name) ? 1 : 0] +
+			 (unsigned long)mutex->fastlock);
+		mutex->lockcnt = 0;
+	}
+#endif /* CONFIG_XENO_FASTSYNCH */
+
+	return err;
 }
 
 int rt_mutex_bind(RT_MUTEX *mutex, const char *name, RTIME timeout)
 {
-	return XENOMAI_SKINCALL3(__native_muxid,
-				 __native_mutex_bind, mutex, name, &timeout);
+	int err;
+
+	err = XENOMAI_SKINCALL3(__native_muxid,
+				__native_mutex_bind, mutex, name, &timeout);
+
+#ifdef CONFIG_XENO_FASTSYNCH
+	if (!err) {
+		mutex->fastlock = (xnarch_atomic_t *)
+			(xeno_sem_heap[(name && *name) ? 1 : 0] +
+			 (unsigned long)mutex->fastlock);
+		mutex->lockcnt = 0;
+	}
+#endif /* CONFIG_XENO_FASTSYNCH */
+
+	return err;
 }
 
 int rt_mutex_delete(RT_MUTEX *mutex)
@@ -38,20 +68,76 @@ int rt_mutex_delete(RT_MUTEX *mutex)
 	return XENOMAI_SKINCALL1(__native_muxid, __native_mutex_delete, mutex);
 }
 
+static int rt_mutex_acquire_inner(RT_MUTEX *mutex, RTIME timeout, xntmode_t mode)
+{
+	int err;
+#ifdef CONFIG_XENO_FASTSYNCH
+	xnhandle_t cur;
+
+	cur = xeno_get_current();
+	if (!cur)
+		return -EPERM;
+
+	err = xnsynch_fast_acquire(mutex->fastlock, cur);
+	if (likely(!err)) {
+		mutex->lockcnt = 1;
+		return 0;
+	}
+
+	if (err == -EBUSY) {
+		if (mutex->lockcnt == UINT_MAX)
+			return -EAGAIN;
+
+		mutex->lockcnt++;
+		return 0;
+	}
+
+	if (timeout == TM_NONBLOCK && mode == XN_RELATIVE)
+		return -EWOULDBLOCK;
+#endif /* CONFIG_XENO_FASTSYNCH */
+
+	err = XENOMAI_SKINCALL3(__native_muxid,
+				__native_mutex_acquire, mutex, mode, &timeout);
+
+#ifdef CONFIG_XENO_FASTSYNCH
+	if (!err)
+		mutex->lockcnt = 1;
+#endif /* CONFIG_XENO_FASTSYNCH */
+
+	return err;
+}
+
 int rt_mutex_acquire(RT_MUTEX *mutex, RTIME timeout)
 {
-	return XENOMAI_SKINCALL3(__native_muxid,
-				 __native_mutex_acquire, mutex, XN_RELATIVE, &timeout);
+	return rt_mutex_acquire_inner(mutex, timeout, XN_RELATIVE);
 }
 
 int rt_mutex_acquire_until(RT_MUTEX *mutex, RTIME timeout)
 {
-	return XENOMAI_SKINCALL3(__native_muxid,
-				 __native_mutex_acquire, mutex, XN_REALTIME, &timeout);
+	return rt_mutex_acquire_inner(mutex, timeout, XN_REALTIME);
 }
 
 int rt_mutex_release(RT_MUTEX *mutex)
 {
+#ifdef CONFIG_XENO_FASTSYNCH
+	xnhandle_t cur;
+
+	cur = xeno_get_current();
+	if (!cur)
+		return -EPERM;
+
+	if (unlikely(xnsynch_fast_owner_check(mutex->fastlock, cur) != 0))
+		return -EPERM;
+
+	if (mutex->lockcnt > 1) {
+		mutex->lockcnt--;
+		return 0;
+	}
+
+	if (likely(xnsynch_fast_release(mutex->fastlock, cur)))
+		return 0;
+#endif /* CONFIG_XENO_FASTSYNCH */
+
 	return XENOMAI_SKINCALL1(__native_muxid, __native_mutex_release, mutex);
 }
 


