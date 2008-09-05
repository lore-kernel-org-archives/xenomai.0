Message-ID: <48C0EF8B.9010205@domain.hid>
Date: Fri, 05 Sep 2008 10:36:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48BBA9E6.5070400@domain.hid> <48BBAF6F.1030804@domain.hid>
In-Reply-To: <48BBAF6F.1030804@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [RFC][PATCH 8/9] Native support for fast mutexes - v2
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Analogously to POSIX, this patch adds fast mutex support to the native
> skin.

For reference only: Updated to include the claimed-bit-race fix.

---
 include/native/mutex.h      |   31 +++-
 ksrc/skins/native/cond.c    |   17 +-
 ksrc/skins/native/mutex.c   |  339 ++++++++++++++++++++++++++++++--------------
 ksrc/skins/native/syscall.c |   71 +++++++--
 src/skins/native/cond.c     |   28 ++-
 src/skins/native/mutex.c    |  103 ++++++++++++-
 6 files changed, 448 insertions(+), 141 deletions(-)

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
 
@@ -44,9 +44,22 @@ typedef struct rt_mutex_info {
 } RT_MUTEX_INFO;
 
 typedef struct rt_mutex_placeholder {
+
 	xnhandle_t opaque;
+
+#ifdef CONFIG_XENO_FASTSEM
+	xnarch_atomic_t *fast_lock;
+
+	int lockcnt;
+#endif /* CONFIG_XENO_FASTSEM */
+
 } RT_MUTEX_PLACEHOLDER;
 
+#define __rt_mutex_is_claimed(state)	((state) & XN_HANDLE_SPARE3)
+#define __rt_mutex_mask_claimed(state)	((state) & ~XN_HANDLE_SPARE3)
+#define __rt_mutex_set_claimed(state, bit) \
+	(((state) & ~XN_HANDLE_SPARE3) | ((bit) ? XN_HANDLE_SPARE3 : 0))
+
 #if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_CPP)
 
 #include <nucleus/synch.h>
@@ -54,10 +67,16 @@ typedef struct rt_mutex_placeholder {
 
 #define XENO_MUTEX_MAGIC 0x55550505
 
+#define RT_MUTEX_EXPORTED	XNSYNCH_SPARE0	/* Mutex registered by name */
+
 typedef struct __rt_mutex {
 
 	unsigned magic;		/* !< Magic code - must be first */
 
+#ifdef CONFIG_XENO_FASTSEM
+	xnarch_atomic_t *fast_lock; /* !< Address of fast-path lock */
+#endif /* CONFIG_XENO_FASTSEM */
+
 	xnsynch_t synch_base;	/* !< Base synchronization object. */
 
 	xnhandle_t handle;	/* !< Handle in registry -- zero if unregistered. */
@@ -74,7 +93,7 @@ typedef struct __rt_mutex {
 
 #define rlink2mutex(ln)		container_of(ln, RT_MUTEX, rlink)
 
-    xnqueue_t *rqueue;		/* !< Backpointer to resource queue. */
+	xnqueue_t *rqueue;	/* !< Backpointer to resource queue. */
 
 } RT_MUTEX;
 
@@ -93,9 +112,8 @@ static inline void __native_mutex_flush_
 	xeno_flush_rq(RT_MUTEX, rq, mutex);
 }
 
-int rt_mutex_acquire_inner(RT_MUTEX *mutex,
-			   xntmode_t timeout_mode,
-			   RTIME timeout);
+int rt_mutex_acquire_inner(RT_MUTEX *mutex, RTIME timeout,
+			   xntmode_t timeout_mode);
 
 #else /* !CONFIG_XENO_OPT_NATIVE_MUTEX */
 
@@ -138,6 +156,9 @@ static inline int rt_mutex_unbind (RT_MU
 extern "C" {
 #endif
 
+int rt_mutex_create_inner(RT_MUTEX *mutex, const char *name);
+int rt_mutex_delete_inner(RT_MUTEX *mutex);
+
 /* Public interface. */
 
 int rt_mutex_create(RT_MUTEX *mutex,
Index: b/ksrc/skins/native/mutex.c
===================================================================
--- a/ksrc/skins/native/mutex.c
+++ b/ksrc/skins/native/mutex.c
@@ -68,9 +68,8 @@ static int __mutex_read_proc(char *page,
 
 		/* Locked mutex -- dump owner and waiters, if any. */
 
-		p += sprintf(p, "=locked by %s depth=%d\n",
-			     xnthread_name(xnsynch_owner(&mutex->synch_base)),
-			     mutex->lockcnt);
+		p += sprintf(p, "=locked by %s\n",
+			     xnthread_name(xnsynch_owner(&mutex->synch_base)));
 
 		holder = getheadpq(xnsynch_wait_queue(&mutex->synch_base));
 
@@ -120,49 +119,7 @@ static xnpnode_t __mutex_pnode = {
 
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
+int rt_mutex_create_inner(RT_MUTEX *mutex, const char *name)
 {
 	int err = 0;
 	spl_t s;
@@ -170,7 +127,8 @@ int rt_mutex_create(RT_MUTEX *mutex, con
 	if (xnpod_asynch_p())
 		return -EPERM;
 
-	xnsynch_init(&mutex->synch_base, XNSYNCH_PRIO | XNSYNCH_PIP);
+	xnsynch_init(&mutex->synch_base,
+		     XNSYNCH_PRIO | XNSYNCH_PIP | XNSYNCH_FWDROB);
 	mutex->handle = 0;	/* i.e. (still) unregistered mutex. */
 	mutex->magic = XENO_MUTEX_MAGIC;
 	mutex->lockcnt = 0;
@@ -185,6 +143,10 @@ int rt_mutex_create(RT_MUTEX *mutex, con
 	mutex->cpid = 0;
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
+#ifdef CONFIG_XENO_FASTSEM
+	xnarch_atomic_set(mutex->fast_lock, XN_NO_HANDLE);
+#endif /* CONFIG_XENO_FASTSEM */
+
 #ifdef CONFIG_XENO_OPT_REGISTRY
 	/* <!> Since xnregister_enter() may reschedule, only register
 	   complete objects, so that the registry cannot return handles to
@@ -195,7 +157,7 @@ int rt_mutex_create(RT_MUTEX *mutex, con
 				       &__mutex_pnode);
 
 		if (err)
-			rt_mutex_delete(mutex);
+			rt_mutex_delete_inner(mutex);
 	}
 #endif /* CONFIG_XENO_OPT_REGISTRY */
 
@@ -203,22 +165,32 @@ int rt_mutex_create(RT_MUTEX *mutex, con
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
@@ -234,7 +206,29 @@ int rt_mutex_create(RT_MUTEX *mutex, con
  * Rescheduling: possible.
  */
 
-int rt_mutex_delete(RT_MUTEX *mutex)
+int rt_mutex_create(RT_MUTEX *mutex, const char *name)
+{
+	int err;
+
+#ifdef CONFIG_XENO_FASTSEM
+	/* Allocate lock memory for in-kernel use */
+	mutex->fast_lock = xnmalloc(sizeof(xnarch_atomic_t));
+
+	if (!mutex->fast_lock)
+		return -ENOMEM;
+#endif /* CONFIG_XENO_FASTSEM */
+
+	err = rt_mutex_create_inner(mutex, name);
+
+#ifdef CONFIG_XENO_FASTSEM
+	if (err)
+		xnfree(mutex->fast_lock);
+#endif /* CONFIG_XENO_FASTSEM */
+
+	return err;
+}
+
+int rt_mutex_delete_inner(RT_MUTEX *mutex)
 {
 	int err = 0, rc;
 	spl_t s;
@@ -274,15 +268,84 @@ int rt_mutex_delete(RT_MUTEX *mutex)
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
 {
-	xnthread_t *thread;
-	int err = 0;
+	int err;
+
+	err = rt_mutex_delete_inner(mutex);
+
+#ifdef CONFIG_XENO_FASTSEM
+	if (!err)
+		xnfree(mutex->fast_lock);
+#endif /* CONFIG_XENO_FASTSEM */
+
+	return err;
+}
+
+int rt_mutex_acquire_inner(RT_MUTEX *mutex, RTIME timeout,
+			   xntmode_t timeout_mode)
+{
+	xnhandle_t fast_lock, threadh, old;
+	xnthread_t *thread, *owner;
+	int err;
 	spl_t s;
 
 	if (xnpod_unblockable_p())
 		return -EPERM;
 
+	thread = xnpod_current_thread();
+	threadh = xnthread_handle(thread);
+
+      retry:
+
+	fast_lock =
+	    xnarch_atomic_cmpxchg(mutex->fast_lock, XN_NO_HANDLE, threadh);
+
+	if (likely(!fast_lock)) {
+		mutex->lockcnt = 1;
+		return 0;
+	}
+
+	if (__rt_mutex_mask_claimed(fast_lock) == threadh) {
+		if (mutex->lockcnt == UINT_MAX)
+			return -EAGAIN;
+
+		mutex->lockcnt++;
+		return 0;
+	}
+
 	xnlock_get_irqsave(&nklock, s);
 
 	mutex = xeno_h2obj_validate(mutex, XENO_MUTEX_MAGIC, RT_MUTEX);
@@ -292,42 +355,83 @@ int rt_mutex_acquire_inner(RT_MUTEX *mut
 		goto unlock_and_exit;
 	}
 
-	thread = xnpod_current_thread();
+	/* Set bit 0, so that mutex_unlock will know that the mutex is
+	   claimed. */
+	if (__rt_mutex_is_claimed(fast_lock)) {
+		old = xnarch_atomic_get(mutex->fast_lock);
+		goto test_no_owner;
+	}
+	do {
+		old = xnarch_atomic_cmpxchg(mutex->fast_lock, fast_lock,
+					    __rt_mutex_set_claimed(fast_lock,
+								   1));
+		if (likely(old == fast_lock))
+			break;
+
+	      test_no_owner:
+
+		if (old == 0) {
+			/* Owner called fast mutex release (on another cpu) */
+			xnlock_put_irqrestore(&nklock, s);
+			goto retry;
+		}
+		fast_lock = old;
+	} while (!__rt_mutex_is_claimed(fast_lock));
 
-	if (xnsynch_owner(&mutex->synch_base) == NULL) {
-		xnsynch_set_owner(&mutex->synch_base, thread);
-		goto grab_mutex;
-	}
+	owner = xnregistry_fetch(__rt_mutex_mask_claimed(fast_lock));
 
-	if (xnsynch_owner(&mutex->synch_base) == thread) {
-		mutex->lockcnt++;
-		goto unlock_and_exit;
-	}
-
-	if (timeout == TM_NONBLOCK) {
-		err = -EWOULDBLOCK;
-		goto unlock_and_exit;
+	/* Consistency check for owner handle - is the object a thread? */
+	if (unlikely(!owner ||
+		     xnthread_handle(owner) !=
+		     __rt_mutex_mask_claimed(fast_lock))) {
+		err = -EINVAL;
+		goto cleanup_and_exit;
 	}
 
+	xnsynch_set_owner(&mutex->synch_base, owner);
 	xnsynch_sleep_on(&mutex->synch_base, timeout, timeout_mode);
 
-	if (xnthread_test_info(thread, XNRMID))
+	if (unlikely
+	    (xnthread_test_info(thread,
+				XNBREAK | XNRMID | XNROBBED | XNTIMEO))) {
+		if (xnthread_test_info(thread, XNROBBED)) {
+			xnlock_put_irqrestore(&nklock, s);
+			goto retry;
+		}
+		if (xnthread_test_info(thread, XNTIMEO)) {
+			if (timeout_mode == XN_RELATIVE &&
+			    timeout == XN_NONBLOCK)
+				err = -EWOULDBLOCK;
+			else
+				err = -ETIMEDOUT;
+			goto cleanup_and_exit;
+		}
+		if (xnthread_test_info(thread, XNBREAK)) {
+			err = -EINTR;	/* Forcibly unblocked. */
+			goto cleanup_and_exit;
+		}
 		err = -EIDRM;	/* Mutex deleted while pending. */
-	else if (xnthread_test_info(thread, XNTIMEO))
-		err = -ETIMEDOUT;	/* Timeout. */
-	else if (xnthread_test_info(thread, XNBREAK))
-		err = -EINTR;	/* Unblocked. */
-	else {
-	      grab_mutex:
-		/* xnsynch_sleep_on() might have stolen the resource,
-		   so we need to put our internal data in sync. */
-		mutex->lockcnt = 1;
+		goto cleanup_and_exit;
 	}
 
-      unlock_and_exit:
+	if (xnsynch_nsleepers(&mutex->synch_base))
+		threadh = __rt_mutex_set_claimed(threadh, 1);
+	xnarch_atomic_set(mutex->fast_lock, threadh);
+	mutex->lockcnt = 1;
 
 	xnlock_put_irqrestore(&nklock, s);
+	return 0;
+
+      cleanup_and_exit:
+
+	if (!xnsynch_nsleepers(&mutex->synch_base))
+		xnarch_atomic_set(mutex->fast_lock,
+				  __rt_mutex_mask_claimed(xnarch_atomic_get
+							  (mutex->fast_lock)));
 
+      unlock_and_exit:
+
+	xnlock_put_irqrestore(&nklock, s);
 	return err;
 }
 
@@ -397,7 +501,7 @@ int rt_mutex_acquire_inner(RT_MUTEX *mut
 
 int rt_mutex_acquire(RT_MUTEX *mutex, RTIME timeout)
 {
-	return rt_mutex_acquire_inner(mutex, XN_RELATIVE, timeout);
+	return rt_mutex_acquire_inner(mutex, timeout, XN_RELATIVE);
 }
 
 /**
@@ -463,7 +567,7 @@ int rt_mutex_acquire(RT_MUTEX *mutex, RT
 
 int rt_mutex_acquire_until(RT_MUTEX *mutex, RTIME timeout)
 {
-	return rt_mutex_acquire_inner(mutex, XN_REALTIME, timeout);
+	return rt_mutex_acquire_inner(mutex, timeout, XN_REALTIME);
 }
 
 /**
@@ -500,12 +604,30 @@ int rt_mutex_acquire_until(RT_MUTEX *mut
 
 int rt_mutex_release(RT_MUTEX *mutex)
 {
-	int err = 0;
+	xnhandle_t threadh, ownerh;
+	xnthread_t *owner;
+	int err;
 	spl_t s;
 
 	if (xnpod_unblockable_p())
 		return -EPERM;
 
+	threadh = xnthread_handle(xnpod_current_thread());
+
+	if (__rt_mutex_mask_claimed(xnarch_atomic_get(mutex->fast_lock)) !=
+	    threadh)
+		return -EPERM;
+
+	if (mutex->lockcnt > 1) {
+		mutex->lockcnt--;
+		return 0;
+	}
+
+	if (likely
+	    (xnarch_atomic_cmpxchg(mutex->fast_lock, threadh, XN_NO_HANDLE) ==
+	     threadh))
+		return 0;
+
 	xnlock_get_irqsave(&nklock, s);
 
 	mutex = xeno_h2obj_validate(mutex, XENO_MUTEX_MAGIC, RT_MUTEX);
@@ -515,18 +637,16 @@ int rt_mutex_release(RT_MUTEX *mutex)
 		goto unlock_and_exit;
 	}
 
-	if (xnpod_current_thread() != xnsynch_owner(&mutex->synch_base)) {
-		err = -EPERM;
-		goto unlock_and_exit;
-	}
-
-	if (--mutex->lockcnt > 0)
-		goto unlock_and_exit;
-
-	if (xnsynch_wakeup_one_sleeper(&mutex->synch_base)) {
-		mutex->lockcnt = 1;
+	owner = xnsynch_wakeup_one_sleeper(&mutex->synch_base);
+	if (owner) {
+		ownerh = __rt_mutex_set_claimed(xnthread_handle(owner),
+						xnsynch_nsleepers(&mutex->
+								  synch_base));
+		xnarch_atomic_set(mutex->fast_lock, ownerh);
 		xnpod_schedule();
-	}
+	} else
+		xnarch_atomic_set(mutex->fast_lock, XN_NO_HANDLE);
+	err = 0;
 
       unlock_and_exit:
 
@@ -568,6 +688,8 @@ int rt_mutex_release(RT_MUTEX *mutex)
 
 int rt_mutex_inquire(RT_MUTEX *mutex, RT_MUTEX_INFO *info)
 {
+	xnhandle_t fast_lock;
+	xnthread_t *owner;
 	int err = 0;
 	spl_t s;
 
@@ -581,12 +703,21 @@ int rt_mutex_inquire(RT_MUTEX *mutex, RT
 	}
 
 	strcpy(info->name, mutex->name);
-	info->lockcnt = mutex->lockcnt;
+	fast_lock = xnarch_atomic_get(mutex->fast_lock);
+	info->locked = !!fast_lock;
 	info->nwaiters = xnsynch_nsleepers(&mutex->synch_base);
-	if (mutex->lockcnt)
-		strcpy(info->owner,
-		       xnthread_name(xnsynch_owner(&mutex->synch_base)));
-	else
+	if (fast_lock) {
+		owner = xnregistry_fetch(__rt_mutex_mask_claimed(fast_lock));
+
+		if (owner &&
+		    xnthread_handle(owner) ==
+		    __rt_mutex_mask_claimed(fast_lock))
+			strcpy(info->owner,
+			       xnthread_name(xnsynch_owner(&mutex->
+							   synch_base)));
+		else
+			strcpy(info->owner, "<DAMAGED HANDLE!>");
+	} else
 		info->owner[0] = 0;
 
       unlock_and_exit:
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
@@ -1527,6 +1528,7 @@ static int __rt_event_inquire(struct pt_
 static int __rt_mutex_create(struct pt_regs *regs)
 {
 	char name[XNOBJECT_NAME_LEN];
+	xnheap_t *sem_heap;
 	RT_MUTEX_PLACEHOLDER ph;
 	RT_MUTEX *mutex;
 	int err;
@@ -1541,22 +1543,47 @@ static int __rt_mutex_create(struct pt_r
 	} else
 		*name = '\0';
 
+	sem_heap = &xnsys_ppd_get(*name != '\0')->sem_heap;
+
 	mutex = (RT_MUTEX *)xnmalloc(sizeof(*mutex));
 
 	if (!mutex)
 		return -ENOMEM;
 
-	err = rt_mutex_create(mutex, name);
+#ifdef CONFIG_XENO_FASTSEM
+	mutex->fast_lock = xnheap_alloc(sem_heap, sizeof(xnarch_atomic_t));
+
+	if (!mutex->fast_lock) {
+		xnfree(mutex);
+		return -ENOMEM;
+	}
+#endif /* CONFIG_XENO_FASTSEM */
+
+	err = rt_mutex_create_inner(mutex, name);
 
 	if (err == 0) {
 		mutex->cpid = current->pid;
 		/* Copy back the registry handle to the ph struct. */
 		ph.opaque = mutex->handle;
+#ifdef CONFIG_XENO_FASTSEM
+		/* The lock address will be finished in user space. */
+		ph.fast_lock =
+			(void *)xnheap_mapped_offset(sem_heap,
+						     mutex->fast_lock);
+		if (*name != '\0')
+			xnsynch_set_flags(&mutex->synch_base,
+					  RT_MUTEX_EXPORTED);
+#endif /* CONFIG_XENO_FASTSEM */
 		if (__xn_safe_copy_to_user((void __user *)__xn_reg_arg1(regs), &ph,
 					   sizeof(ph)))
 			err = -EFAULT;
-	} else
+	} else {
+#ifdef CONFIG_XENO_FASTSEM
+		xnheap_free(&xnsys_ppd_get(*name != '\0')->sem_heap,
+			    mutex->fast_lock);
+#endif /* CONFIG_XENO_FASTSEM */
 		xnfree(mutex);
+	}
 
 	return err;
 }
@@ -1570,15 +1597,22 @@ static int __rt_mutex_create(struct pt_r
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
 
+#ifdef CONFIG_XENO_FASTSEM
+	ph.fast_lock =
+		(void *)xnheap_mapped_offset(&xnsys_ppd_get(1)->sem_heap,
+					     mutex->fast_lock);
+#endif /* CONFIG_XENO_FASTSEM */
+
 	if (__xn_safe_copy_to_user((void __user *)__xn_reg_arg1(regs), &ph,
 			      sizeof(ph)))
 		return -EFAULT;
@@ -1605,10 +1639,17 @@ static int __rt_mutex_delete(struct pt_r
 	if (!mutex)
 		return -ESRCH;
 
-	err = rt_mutex_delete(mutex);
+	err = rt_mutex_delete_inner(mutex);
 
-	if (!err && mutex->cpid)
+	if (!err && mutex->cpid) {
+#ifdef CONFIG_XENO_FASTSEM
+		int global = xnsynch_test_flags(&mutex->synch_base,
+						RT_MUTEX_EXPORTED);
+		xnheap_free(&xnsys_ppd_get(global)->sem_heap,
+			    mutex->fast_lock);
+#endif /* CONFIG_XENO_FASTSEM */
 		xnfree(mutex);
+	}
 
 	return err;
 }
@@ -1621,13 +1662,14 @@ static int __rt_mutex_delete(struct pt_r
 
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
@@ -1636,12 +1678,12 @@ static int __rt_mutex_acquire(struct pt_
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
@@ -1650,14 +1692,15 @@ static int __rt_mutex_acquire(struct pt_
 
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
Index: b/src/skins/native/mutex.c
===================================================================
--- a/src/skins/native/mutex.c
+++ b/src/skins/native/mutex.c
@@ -16,21 +16,50 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <limits.h>
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
+#ifdef CONFIG_XENO_FASTSEM
+	if (!err) {
+		mutex->fast_lock = (xnarch_atomic_t *)
+			(xeno_sem_heap[(name && *name) ? 1 : 0] +
+			 (unsigned long)mutex->fast_lock);
+		mutex->lockcnt = 0;
+	}
+#endif /* CONFIG_XENO_FASTSEM */
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
+#ifdef CONFIG_XENO_FASTSEM
+	if (!err) {
+		mutex->fast_lock = (xnarch_atomic_t *)
+			(xeno_sem_heap[(name && *name) ? 1 : 0] +
+			 (unsigned long)mutex->fast_lock);
+		mutex->lockcnt = 0;
+	}
+#endif /* CONFIG_XENO_FASTSEM */
+
+	return err;
 }
 
 int rt_mutex_delete(RT_MUTEX *mutex)
@@ -38,20 +67,78 @@ int rt_mutex_delete(RT_MUTEX *mutex)
 	return XENOMAI_SKINCALL1(__native_muxid, __native_mutex_delete, mutex);
 }
 
+static int rt_mutex_acquire_inner(RT_MUTEX *mutex, RTIME timeout, xntmode_t mode)
+{
+	int err;
+#ifdef CONFIG_XENO_FASTSEM
+	xnhandle_t cur, fast_lock;
+
+	cur = xeno_get_current();
+	if (!cur)
+		return -EPERM;
+
+	fast_lock =
+	    xnarch_atomic_cmpxchg(mutex->fast_lock, XN_NO_HANDLE, cur);
+
+	if (likely(fast_lock == 0)) {
+		mutex->lockcnt = 1;
+		return 0;
+	}
+
+	if (__rt_mutex_mask_claimed(fast_lock) == cur) {
+		if (mutex->lockcnt == UINT_MAX)
+			return -EAGAIN;
+
+		mutex->lockcnt++;
+		return 0;
+	}
+#endif /* CONFIG_XENO_FASTSEM */
+
+	err = XENOMAI_SKINCALL3(__native_muxid,
+				__native_mutex_acquire, mutex, mode, &timeout);
+
+#ifdef CONFIG_XENO_FASTSEM
+	if (!err)
+		mutex->lockcnt = 1;
+#endif /* CONFIG_XENO_FASTSEM */
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
+#ifdef CONFIG_XENO_FASTSEM
+	xnhandle_t cur, fast_lock;
+
+	cur = xeno_get_current();
+	if (!cur)
+		return -EPERM;
+
+	fast_lock = xnarch_atomic_get(mutex->fast_lock);
+
+	if (unlikely(__rt_mutex_mask_claimed(fast_lock) != cur))
+		return -EPERM;
+
+	if (mutex->lockcnt > 1) {
+		mutex->lockcnt--;
+		return 0;
+	}
+
+	if (likely(xnarch_atomic_cmpxchg(mutex->fast_lock,
+					 cur, XN_NO_HANDLE) == cur))
+		return 0;
+#endif /* CONFIG_XENO_FASTSEM */
+
 	return XENOMAI_SKINCALL1(__native_muxid, __native_mutex_release, mutex);
 }
 
Index: b/ksrc/skins/native/cond.c
===================================================================
--- a/ksrc/skins/native/cond.c
+++ b/ksrc/skins/native/cond.c
@@ -378,8 +378,9 @@ int rt_cond_broadcast(RT_COND *cond)
 int rt_cond_wait_inner(RT_COND *cond, RT_MUTEX *mutex,
 		       xntmode_t timeout_mode, RTIME timeout)
 {
+	xnhandle_t fast_lock, threadh;
+	xnthread_t *thread, *owner;
 	int err = 0, kicked = 0;
-	xnthread_t *thread;
 	int lockcnt;
 	spl_t s;
 
@@ -406,8 +407,10 @@ int rt_cond_wait_inner(RT_COND *cond, RT
 	}
 
 	thread = xnpod_current_thread();
+	threadh = xnthread_handle(thread);
 
-	if (thread != xnsynch_owner(&mutex->synch_base)) {
+	fast_lock = xnarch_atomic_get(mutex->fast_lock);
+	if (__rt_mutex_mask_claimed(fast_lock) != threadh) {
 		err = -EPERM;
 		goto unlock_and_exit;
 	}
@@ -421,8 +424,14 @@ int rt_cond_wait_inner(RT_COND *cond, RT
 
 	mutex->lockcnt = 0;
 
-	if (xnsynch_wakeup_one_sleeper(&mutex->synch_base)) {
-		mutex->lockcnt = 1;
+	if (unlikely
+	    (xnarch_atomic_cmpxchg(mutex->fast_lock, threadh, XN_NO_HANDLE) !=
+	     threadh)) {
+		owner = xnsynch_wakeup_one_sleeper(&mutex->synch_base);
+		xnarch_atomic_set(mutex->fast_lock,
+				  __rt_mutex_set_claimed(xnthread_handle(owner),
+							 xnsynch_nsleepers
+							 (&mutex->synch_base)));
 		/* Scheduling deferred */
 	}
 
Index: b/src/skins/native/cond.c
===================================================================
--- a/src/skins/native/cond.c
+++ b/src/skins/native/cond.c
@@ -41,16 +41,32 @@ int rt_cond_delete(RT_COND *cond)
 
 int rt_cond_wait(RT_COND *cond, RT_MUTEX *mutex, RTIME timeout)
 {
-	return XENOMAI_SKINCALL4(__native_muxid,
-				 __native_cond_wait, cond, mutex,
-				 XN_RELATIVE, &timeout);
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
 }
 
 int rt_cond_wait_until(RT_COND *cond, RT_MUTEX *mutex, RTIME timeout)
 {
-	return XENOMAI_SKINCALL4(__native_muxid,
-				 __native_cond_wait, cond, mutex,
-				 XN_REALTIME, &timeout);
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
 }
 
 int rt_cond_signal(RT_COND *cond)

