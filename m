Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48F764A5.1030600@domain.hid>
Message-Id: <20081016154621.488387180@domain.hid>
Date: Thu, 16 Oct 2008 17:46:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
References: <20081016154620.320953568@domain.hid>
Content-Disposition: inline; filename=switch-posix-to-fast-xnsynch.patch
Subject: [Xenomai-core] [PATCH 07/12] Convert POSIX skin to fast xnsynch
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

Migrates the existing fast mutex implementation of the POSIX skin to
fast xnsynch services, also fixing the build for arch that do not
support fast mutexes.

Lock stealing via pthread_trylock is not considered by this patch,
keeping this services lockless and syscall-less until we identify the
need for using the steal mechanism also for this case.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/skins/posix/cond.c    |   18 ++---
 ksrc/skins/posix/mutex.c   |   92 ++++++++++++++++++++--------
 ksrc/skins/posix/mutex.h   |  143 +++++++--------------------------------------
 ksrc/skins/posix/syscall.c |   22 ++----
 src/skins/posix/mutex.c    |   55 ++++++++---------
 5 files changed, 132 insertions(+), 198 deletions(-)

Index: b/ksrc/skins/posix/cond.c
===================================================================
--- a/ksrc/skins/posix/cond.c
+++ b/ksrc/skins/posix/cond.c
@@ -223,27 +223,23 @@ static inline int mutex_save_count(xnthr
 				   unsigned *count_ptr)
 {
 	pse51_mutex_t *mutex;
-	xnthread_t *owner;
 
 	if (!pse51_obj_active(shadow, PSE51_MUTEX_MAGIC, struct __shadow_mutex))
 		 return EINVAL;
 
 	mutex = shadow->mutex;
 
-	if (clear_claimed(xnarch_atomic_get(mutex->owner)) !=
-	    xnthread_handle(cur))
+#ifdef CONFIG_XENO_FASTSYNCH
+	if (xnsynch_fast_owner_check(mutex->synchbase.fastlock,
+				     xnthread_handle(cur)) != 0)
+#else /* !CONFIG_XENO_FASTSYNCH */
+	if (xnsynch_owner(&mutex->synchbase) != cur)
+#endif /* !CONFIG_XENO_FASTSYNCH */
 		return EPERM;
 
 	*count_ptr = shadow->lockcnt;
 
-	if (likely(xnarch_atomic_cmpxchg(mutex->owner, cur, XN_NO_HANDLE) ==
-		   xnthread_handle(cur)))
-		return 0;
-
-	owner = xnsynch_release(&mutex->synchbase);
-	xnarch_atomic_set(mutex->owner,
-			  set_claimed(xnthread_handle(owner),
-				      xnsynch_nsleepers(&mutex->synchbase)));
+	xnsynch_release(&mutex->synchbase);
 
 	/* Do not reschedule here, releasing the mutex and suspension must be
 	   done atomically in pthread_cond_*wait. */
Index: b/ksrc/skins/posix/mutex.c
===================================================================
--- a/ksrc/skins/posix/mutex.c
+++ b/ksrc/skins/posix/mutex.c
@@ -102,9 +102,9 @@ int pse51_mutex_init_internal(struct __s
 	shadow->magic = PSE51_MUTEX_MAGIC;
 	shadow->mutex = mutex;
 	shadow->lockcnt = 0;
+	xnarch_atomic_set(&shadow->lock, -1);
 
 #ifdef CONFIG_XENO_FASTSYNCH
-	xnarch_atomic_set(&shadow->lock, -1);
 	shadow->attr = *attr;
 	shadow->owner_offset = xnheap_mapped_offset(&sys_ppd->sem_heap, ownerp);
 #endif /* CONFIG_XENO_FASTSYNCH */
@@ -112,13 +112,10 @@ int pse51_mutex_init_internal(struct __s
 	if (attr->protocol == PTHREAD_PRIO_INHERIT)
 		synch_flags |= XNSYNCH_PIP;
 
-	xnsynch_init(&mutex->synchbase, synch_flags, NULL);
+	xnsynch_init(&mutex->synchbase, synch_flags, ownerp);
 	inith(&mutex->link);
 	mutex->attr = *attr;
-	mutex->owner = ownerp;
 	mutex->owningq = kq;
-	mutex->sleepers = 0;
-	xnarch_atomic_set(ownerp, XN_NO_HANDLE);
 
 	xnlock_get_irqsave(&nklock, s);
 	appendq(&kq->mutexq, &mutex->link);
@@ -159,7 +156,7 @@ int pthread_mutex_init(pthread_mutex_t *
 	    &((union __xeno_mutex *)mx)->shadow_mutex;
 	DECLARE_CB_LOCK_FLAGS(s);
 	pse51_mutex_t *mutex;
-	xnarch_atomic_t *ownerp;
+	xnarch_atomic_t *ownerp = NULL;
 	int err;
 
 	if (!attr)
@@ -185,6 +182,7 @@ int pthread_mutex_init(pthread_mutex_t *
 	if (!mutex)
 		return ENOMEM;
 
+#ifdef CONFIG_XENO_FASTSYNCH
 	ownerp = (xnarch_atomic_t *)
 		xnheap_alloc(&xnsys_ppd_get(attr->pshared)->sem_heap,
 			     sizeof(xnarch_atomic_t));
@@ -192,6 +190,7 @@ int pthread_mutex_init(pthread_mutex_t *
 		xnfree(mutex);
 		return EAGAIN;
 	}
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	cb_force_write_lock(&shadow->lock, s);
 	err = pse51_mutex_init_internal(shadow, mutex, ownerp, attr);
@@ -199,7 +198,9 @@ int pthread_mutex_init(pthread_mutex_t *
 
 	if (err) {
 		xnfree(mutex);
+#ifdef CONFIG_XENO_FASTSYNCH
 		xnheap_free(&xnsys_ppd_get(attr->pshared)->sem_heap, ownerp);
+#endif /* CONFIG_XENO_FASTSYNCH */
 	}
 	return -err;
 }
@@ -216,8 +217,10 @@ void pse51_mutex_destroy_internal(pse51_
 	xnsynch_destroy(&mutex->synchbase);
 	xnlock_put_irqrestore(&nklock, s);
 
-	if (mutex->attr.pshared)
-		xnheap_free(&xnsys_ppd_get(1)->sem_heap, mutex->owner);
+#ifdef CONFIG_XENO_FASTSYNCH
+	xnheap_free(&xnsys_ppd_get(mutex->attr.pshared)->sem_heap,
+		    mutex->synchbase.fastlock);
+#endif /* CONFIG_XENO_FASTSYNCH */
 	/* We do not free the owner if the mutex is not pshared, because when
 	   this function is called from pse51_mutexq_cleanup, the sem_heap has
 	   been destroyed, and we have no way to find it back. */
@@ -266,7 +269,12 @@ int pthread_mutex_destroy(pthread_mutex_
 		return EPERM;
 	}
 
-	if (xnarch_atomic_get(mutex->owner) != XN_NO_HANDLE) {
+#ifdef CONFIG_XENO_FASTSYNCH
+	if (xnsynch_fast_owner_check(mutex->synchbase.fastlock,
+				     XN_NO_HANDLE) != 0) {
+#else /* CONFIG_XENO_FASTSYNCH */
+	if (shadow->lockcnt) {
+#endif
 		cb_write_unlock(&shadow->lock, s);
 		return EBUSY;
 	}
@@ -274,9 +282,6 @@ int pthread_mutex_destroy(pthread_mutex_
 	pse51_mark_deleted(shadow);
 	cb_write_unlock(&shadow->lock, s);
 
-	if (!mutex->attr.pshared)
-		xnheap_free(&xnsys_ppd_get(mutex->attr.pshared)->sem_heap,
-			    mutex->owner);
 	pse51_mutex_destroy_internal(mutex, pse51_kqueues(mutex->attr.pshared));
 	
 	return 0;
@@ -305,14 +310,12 @@ int pse51_mutex_timedlock_break(struct _
 		/* Attempting to relock a normal mutex, deadlock. */
 		xnlock_get_irqsave(&nklock, s);
 		for (;;) {
-			++mutex->sleepers;
 			if (timed)
 				xnsynch_acquire(&mutex->synchbase,
 						abs_to, XN_REALTIME);
 			else
 				xnsynch_acquire(&mutex->synchbase,
 						XN_INFINITE, XN_RELATIVE);
-			--mutex->sleepers;
 
 			if (xnthread_test_info(cur, XNBREAK)) {
 				err = -EINTR;
@@ -384,19 +387,48 @@ int pthread_mutex_trylock(pthread_mutex_
 {
 	struct __shadow_mutex *shadow =
 	    &((union __xeno_mutex *)mx)->shadow_mutex;
-	xnthread_t *owner, *cur = xnpod_current_thread();
+	xnthread_t *cur = xnpod_current_thread();
+	pse51_mutex_t *mutex = shadow->mutex;
 	DECLARE_CB_LOCK_FLAGS(s);
 	int err;
 
+	if (xnpod_unblockable_p())
+		return EPERM;
+
 	if (unlikely(cb_try_read_lock(&shadow->lock, s)))
 		return EINVAL;
 
-	owner = pse51_mutex_trylock_internal(cur, shadow, 1);
-	if (likely(!owner) || IS_ERR(owner))
-		return -PTR_ERR(owner);
+	if (!pse51_obj_active(shadow, PSE51_MUTEX_MAGIC,
+			      struct __shadow_mutex)) {
+		err = EINVAL;
+		goto unlock_and_return;
+	}
+
+#if XENO_DEBUG(POSIX)
+	if (mutex->owningq != pse51_kqueues(mutex->attr.pshared)) {
+		err = EPERM;
+		goto unlock_and_return;
+	}
+#endif /* XENO_DEBUG(POSIX) */
 
-	err = EBUSY;
-	if (owner == cur) {
+#ifdef CONFIG_XENO_FASTSYNCH
+	err = -xnsynch_fast_acquire(mutex->synchbase.fastlock,
+				    xnthread_handle(cur));
+#else /* !CONFIG_XENO_FASTSYNCH */
+	{
+		xnthread_t *owner = xnsynch_owner(&mutex->synchbase);
+		if (!owner)
+			err = 0;
+		else if (owner == cur)
+			err = EBUSY;
+		else
+			err = EAGAIN;
+	}
+#endif /* !CONFIG_XENO_FASTSYNCH */
+
+	if (likely(!err))
+		shadow->lockcnt = 1;
+	else if (err == EBUSY) {
 		pse51_mutex_t *mutex = shadow->mutex;
 
 		if (mutex->attr.type == PTHREAD_MUTEX_RECURSIVE) {
@@ -409,6 +441,7 @@ int pthread_mutex_trylock(pthread_mutex_
 		}
 	}
 
+  unlock_and_return:
 	cb_read_unlock(&shadow->lock, s);
 
 	return err;
@@ -564,7 +597,7 @@ int pthread_mutex_unlock(pthread_mutex_t
 	int err;
 
 	if (xnpod_root_p() || xnpod_interrupt_p())
-		return -EPERM;
+		return EPERM;
 
 	if (unlikely(cb_try_read_lock(&shadow->lock, s)))
 		return EINVAL;
@@ -576,14 +609,16 @@ int pthread_mutex_unlock(pthread_mutex_t
 	}
 
 	mutex = shadow->mutex;
-	
-	if (clear_claimed(xnarch_atomic_get(mutex->owner)) !=
-	    xnthread_handle(cur)) {
-		err = EPERM;
+
+#ifdef CONFIG_XENO_FASTSYNCH
+	err = -xnsynch_fast_owner_check(mutex->synchbase.fastlock,
+					xnthread_handle(cur));
+#else /* !CONFIG_XENO_FASTSYNCH */
+	err = (xnsynch_owner(&mutex->synchbase) == cur) ? 0 : EPERM;
+#endif /* !CONFIG_XENO_FASTSYNCH */
+	if (err)
 		goto out;
-	}
 
-	err = 0;
 	if (shadow->lockcnt > 1) {
 		/* Mutex is recursive */
 		--shadow->lockcnt;
@@ -591,7 +626,8 @@ int pthread_mutex_unlock(pthread_mutex_t
 		return 0;
 	}
 
-	pse51_mutex_unlock_internal(cur, mutex);
+	if (xnsynch_release(&mutex->synchbase))
+		xnpod_schedule();
 
   out:
 	cb_read_unlock(&shadow->lock, s);
Index: b/ksrc/skins/posix/mutex.h
===================================================================
--- a/ksrc/skins/posix/mutex.h
+++ b/ksrc/skins/posix/mutex.h
@@ -30,8 +30,8 @@ union __xeno_mutex {
 		unsigned magic;
 		unsigned lockcnt;
 		struct pse51_mutex *mutex;
-#ifdef CONFIG_XENO_FASTSYNCH
 		xnarch_atomic_t lock;
+#ifdef CONFIG_XENO_FASTSYNCH
 		union {
 			unsigned owner_offset;
 			xnarch_atomic_t *owner;
@@ -54,9 +54,7 @@ typedef struct pse51_mutex {
 #define link2mutex(laddr)                                               \
 	((pse51_mutex_t *)(((char *)laddr) - offsetof(pse51_mutex_t, link)))
 
-	xnarch_atomic_t *owner;
 	pthread_mutexattr_t attr;
-	unsigned sleepers;
 	pse51_kqueues_t *owningq;
 } pse51_mutex_t;
 
@@ -83,145 +81,52 @@ int pse51_mutex_init_internal(struct __s
 void pse51_mutex_destroy_internal(pse51_mutex_t *mutex,
 				  pse51_kqueues_t *q);
 
-static inline xnthread_t *
-pse51_mutex_trylock_internal(xnthread_t *cur,
-			     struct __shadow_mutex *shadow, unsigned count)
+/* must be called with nklock locked, interrupts off. */
+static inline int pse51_mutex_timedlock_internal(xnthread_t *cur,
+						 struct __shadow_mutex *shadow,
+						 unsigned count,
+						 int timed,
+						 xnticks_t abs_to)
+
 {
 	pse51_mutex_t *mutex = shadow->mutex;
-	xnhandle_t ownerh;
-	xnthread_t *owner;
 
 	if (xnpod_unblockable_p())
-		return ERR_PTR(-EPERM);
+		return -EPERM;
 
 	if (!pse51_obj_active(shadow, PSE51_MUTEX_MAGIC, struct __shadow_mutex))
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 #if XENO_DEBUG(POSIX)
 	if (mutex->owningq != pse51_kqueues(mutex->attr.pshared))
-		return ERR_PTR(-EPERM);
+		return -EPERM;
 #endif /* XENO_DEBUG(POSIX) */
 
-	ownerh = xnarch_atomic_cmpxchg(mutex->owner, XN_NO_HANDLE,
-				       xnthread_handle(cur));
-	if (unlikely(ownerh != XN_NO_HANDLE)) {
-		owner = xnthread_lookup(clear_claimed(ownerh));
-		if (!owner)
-			return ERR_PTR(-EINVAL);
-		return owner;
-	}
-
-	shadow->lockcnt = count;
-	return NULL;
-}
-
-/* must be called with nklock locked, interrupts off. */
-static inline int pse51_mutex_timedlock_internal(xnthread_t *cur,
-						 struct __shadow_mutex *shadow,
-						 unsigned count,
-						 int timed,
-						 xnticks_t abs_to)
-
-{
-	pse51_mutex_t *mutex;
-	xnthread_t *owner;
-	xnhandle_t ownerh, old;
-	spl_t s;
-	int err;
-
-  retry_lock:
-	owner = pse51_mutex_trylock_internal(cur, shadow, count);
-	if (likely(!owner) || IS_ERR(owner))
-		return PTR_ERR(owner);
-
-	mutex = shadow->mutex;
-	if (owner == cur)
+#ifdef CONFIG_XENO_FASTSYNCH
+	if (xnsynch_fast_owner_check(mutex->synchbase.fastlock,
+				     xnthread_handle(cur)) == 0)
+#else /* !CONFIG_XENO_FASTSYNCH */
+	if (xnsynch_owner(&mutex->synchbase) == cur)
+#endif /* !CONFIG_XENO_FASTSYNCH */
 		return -EBUSY;
 
-	/* Set bit 0, so that mutex_unlock will know that the mutex is claimed.
-	   Hold the nklock, for mutual exclusion with slow mutex_unlock. */
-	xnlock_get_irqsave(&nklock, s);
-	if (test_claimed(ownerh)) {
-		old = xnarch_atomic_get(mutex->owner);
-		goto test_no_owner;
-	}
-	do {
-		old = xnarch_atomic_cmpxchg(mutex->owner, ownerh,
-					    set_claimed(ownerh, 1));
-		if (likely(old == ownerh))
-			break;
-	  test_no_owner:
-		if (old == XN_NO_HANDLE) {
-			/* Owner called fast mutex_unlock
-			   (on another cpu) */
-			xnlock_put_irqrestore(&nklock, s);
-			goto retry_lock;
-		}
-		ownerh = old;
-	} while (!test_claimed(ownerh));
-
-	owner = xnthread_lookup(clear_claimed(ownerh));
-
-	if (unlikely(!owner)) {
-		err = -EINVAL;
-		goto error;
-	}
-
-	xnsynch_set_owner(&mutex->synchbase, owner);
-	++mutex->sleepers;
 	if (timed)
 		xnsynch_acquire(&mutex->synchbase, abs_to, XN_REALTIME);
 	else
 		xnsynch_acquire(&mutex->synchbase, XN_INFINITE, XN_RELATIVE);
-	--mutex->sleepers;
 
-	if (xnthread_test_info(cur, XNBREAK)) {
-		err = -EINTR;
-		goto error;
-	}
-	if (xnthread_test_info(cur, XNRMID)) {
-		err = -EINVAL;
-		goto error;
-	}
-	if (xnthread_test_info(cur, XNTIMEO)) {
-		err = -ETIMEDOUT;
-		goto error;
+	if (unlikely(xnthread_test_info(cur, XNBREAK | XNRMID | XNTIMEO))) {
+		if (xnthread_test_info(cur, XNBREAK))
+			return -EINTR;
+		else if (xnthread_test_info(cur, XNTIMEO))
+			return -ETIMEDOUT;
+		else /* XNRMID */
+			return -EINVAL;
 	}
 
-	ownerh = set_claimed(xnthread_handle(cur), mutex->sleepers);
-	xnarch_atomic_set(mutex->owner, ownerh);
 	shadow->lockcnt = count;
-	xnlock_put_irqrestore(&nklock, s);
 
 	return 0;
-
-  error:
-	if (!mutex->sleepers)
-		xnarch_atomic_set
-			(mutex->owner,
-			 clear_claimed(xnarch_atomic_get(mutex->owner)));
-	xnlock_put_irqrestore(&nklock, s);
-	return err;
-}
-
-static inline void pse51_mutex_unlock_internal(xnthread_t *cur,
-					       pse51_mutex_t *mutex)
-{
-	xnhandle_t ownerh;
-	xnthread_t *owner;
-	spl_t s;
-
-	if (likely(xnarch_atomic_cmpxchg(mutex->owner, cur, XN_NO_HANDLE) ==
-		   xnthread_handle(cur)))
-		return;
-
-	xnlock_get_irqsave(&nklock, s);
-	owner = xnsynch_release(&mutex->synchbase);
-	ownerh = set_claimed(xnthread_handle(owner), mutex->sleepers);
-	xnarch_atomic_set(mutex->owner, ownerh);
-	if (owner)
-		xnpod_schedule();
-	xnlock_put_irqrestore(&nklock, s);
 }
 
 #endif /* __KERNEL__ */
Index: b/ksrc/skins/posix/syscall.c
===================================================================
--- a/ksrc/skins/posix/syscall.c
+++ b/ksrc/skins/posix/syscall.c
@@ -1060,13 +1060,10 @@ static int __pthread_mutex_unlock(struct
 
 	mutex = shadow->mutex;
 
-	if (clear_claimed(xnarch_atomic_get(mutex->owner)) !=
-	    xnthread_handle(cur)) {
-		err = -EPERM;
+	err = (xnsynch_owner(&mutex->synchbase) == cur) ? 0 : -EPERM;
+	if (err)
 		goto out;
-	}
 
-	err = 0;
 	if (shadow->lockcnt > 1) {
 		/* Mutex is recursive */
 		--shadow->lockcnt;
@@ -1080,8 +1077,9 @@ static int __pthread_mutex_unlock(struct
 
 		return 0;
 	}
-	
-	pse51_mutex_unlock_internal(cur, mutex);
+
+	if (xnsynch_release(&mutex->synchbase))
+		xnpod_schedule();
 
   out:
 	cb_read_unlock(&shadow->lock, s);
@@ -1186,13 +1184,11 @@ static int __pthread_mutex_destroy(struc
 	if (pse51_kqueues(mutex->attr.pshared) != mutex->owningq)
 		return -EPERM;
 
-	if (xnarch_atomic_get(mutex->owner) != XN_NO_HANDLE)
+	if (xnsynch_fast_owner_check(mutex->synchbase.fastlock,
+				     XN_NO_HANDLE) != 0)
 		return -EBUSY;
 
 	pse51_mark_deleted(shadow);
-	if (!mutex->attr.pshared)
-		xnheap_free(&xnsys_ppd_get(mutex->attr.pshared)->sem_heap,
-			    mutex->owner);
 	pse51_mutex_destroy_internal(mutex, mutex->owningq);
 
 	return __xn_safe_copy_to_user((void __user *)&umx->shadow_mutex,
@@ -1262,7 +1258,6 @@ static int __pthread_mutex_timedlock(str
 
 static int __pthread_mutex_unlock(struct pt_regs *regs)
 {
-	xnthread_t *cur = xnpod_current_thread();
 	union __xeno_mutex mx, *umx;
 
 	if (xnpod_root_p())
@@ -1275,7 +1270,8 @@ static int __pthread_mutex_unlock(struct
 				     offsetof(struct __shadow_mutex, lock)))
 		return -EFAULT;
 
-	pse51_mutex_unlock_internal(cur, mx.shadow_mutex.mutex);
+	if (xnsynch_release(&mx.shadow_mutex.mutex->synchbase))
+		xnpod_schedule();
 
 	return 0;
 }
Index: b/src/skins/posix/mutex.c
===================================================================
--- a/src/skins/posix/mutex.c
+++ b/src/skins/posix/mutex.c
@@ -19,6 +19,7 @@
 #include <errno.h>
 #include <pthread.h>
 #include <limits.h>
+#include <nucleus/synch.h>
 #include <posix/mutex.h>
 #include <posix/syscall.h>
 #include <posix/cb_lock.h>
@@ -146,10 +147,10 @@ int __wrap_pthread_mutex_lock(pthread_mu
 {
 	union __xeno_mutex *_mutex = (union __xeno_mutex *)mutex;
 	struct __shadow_mutex *shadow = &_mutex->shadow_mutex;
-	int err = 0;
+	int err;
 
 #ifdef CONFIG_XENO_FASTSYNCH
-	xnhandle_t cur, owner;
+	xnhandle_t cur;
 
 	cur = xeno_get_current();
 	if (cur == XN_NO_HANDLE)
@@ -163,14 +164,15 @@ int __wrap_pthread_mutex_lock(pthread_mu
 		goto out;
 	}
 
-	owner = xnarch_atomic_cmpxchg(get_ownerp(shadow), XN_NO_HANDLE, cur);
-	if (likely(owner == XN_NO_HANDLE)) {
+	err = xnsynch_fast_acquire(get_ownerp(shadow), cur);
+
+	if (likely(!err)) {
 		shadow->lockcnt = 1;
 		cb_read_unlock(&shadow->lock, s);
 		return 0;
 	}
 
-	if (clear_claimed(owner) == cur)
+	if (err == -EBUSY)
 		switch(shadow->attr.type) {
 		case PTHREAD_MUTEX_NORMAL:
 			break;
@@ -184,8 +186,8 @@ int __wrap_pthread_mutex_lock(pthread_mu
 				err = -EAGAIN;
 				goto out;
 			}
-
 			++shadow->lockcnt;
+			err = 0;
 			goto out;
 		}
 #endif /* CONFIG_XENO_FASTSYNCH */
@@ -207,10 +209,10 @@ int __wrap_pthread_mutex_timedlock(pthre
 {
 	union __xeno_mutex *_mutex = (union __xeno_mutex *)mutex;
 	struct __shadow_mutex *shadow = &_mutex->shadow_mutex;
-	int err = 0;
+	int err;
 
 #ifdef CONFIG_XENO_FASTSYNCH
-	xnhandle_t cur, owner;
+	xnhandle_t cur;
 
 	cur = xeno_get_current();
 	if (cur == XN_NO_HANDLE)
@@ -224,14 +226,15 @@ int __wrap_pthread_mutex_timedlock(pthre
 		goto out;
 	}	
 
-	owner = xnarch_atomic_cmpxchg(get_ownerp(shadow), XN_NO_HANDLE, cur);
-	if (likely(owner == XN_NO_HANDLE)) {
+	err = xnsynch_fast_acquire(get_ownerp(shadow), cur);
+
+	if (likely(!err)) {
 		shadow->lockcnt = 1;
 		cb_read_unlock(&shadow->lock, s);
 		return 0;
 	}
 
-	if (clear_claimed(owner) == cur)
+	if (err == -EBUSY)
 		switch(shadow->attr.type) {
 		case PTHREAD_MUTEX_NORMAL:
 			break;
@@ -268,10 +271,10 @@ int __wrap_pthread_mutex_trylock(pthread
 {
 	union __xeno_mutex *_mutex = (union __xeno_mutex *)mutex;
 	struct __shadow_mutex *shadow = &_mutex->shadow_mutex;
-	int err = 0;
+	int err;
 
 #ifdef CONFIG_XENO_FASTSYNCH
-	xnhandle_t cur, owner;
+	xnhandle_t cur;
 
 	cur = xeno_get_current();
 	if (cur == XN_NO_HANDLE)
@@ -285,23 +288,23 @@ int __wrap_pthread_mutex_trylock(pthread
 		goto out;
 	}	
 
-	owner = xnarch_atomic_cmpxchg(get_ownerp(shadow), XN_NO_HANDLE, cur);
-	if (likely(owner == XN_NO_HANDLE)) {
+	err = xnsynch_fast_acquire(get_ownerp(shadow), cur);
+
+	if (likely(!err)) {
 		shadow->lockcnt = 1;
 		cb_read_unlock(&shadow->lock, s);
 		return 0;
 	}
 
-	err = -EBUSY;
-	if (clear_claimed(owner) == cur
-	    && shadow->attr.type == PTHREAD_MUTEX_RECURSIVE) {
+	if (err == -EBUSY && shadow->attr.type == PTHREAD_MUTEX_RECURSIVE) {
 		if (shadow->lockcnt == UINT_MAX)
 			err = -EAGAIN;
 		else {
 			++shadow->lockcnt;
 			err = 0;
 		}
-	}
+	} else
+		err = -EBUSY;
 
   out:
 	cb_read_unlock(&shadow->lock, s);
@@ -322,11 +325,11 @@ int __wrap_pthread_mutex_unlock(pthread_
 {
 	union __xeno_mutex *_mutex = (union __xeno_mutex *)mutex;
 	struct __shadow_mutex *shadow = &_mutex->shadow_mutex;
-	int err = 0;
+	int err;
 
 #ifdef CONFIG_XENO_FASTSYNCH
 	xnarch_atomic_t *ownerp;
-	xnhandle_t cur, owner;
+	xnhandle_t cur;
 
 	cur = xeno_get_current();
 	if (cur == XN_NO_HANDLE)
@@ -341,19 +344,17 @@ int __wrap_pthread_mutex_unlock(pthread_
 	}
 
 	ownerp = get_ownerp(shadow);
-	owner = clear_claimed(xnarch_atomic_get(ownerp));
-	if (unlikely(owner != cur)) {
-		err = -EPERM;
+
+	err = xnsynch_fast_owner_check(ownerp, cur);
+	if (unlikely(err))
 		goto out_err;
-	}
 
-	err = 0;
 	if (shadow->lockcnt > 1) {
 		--shadow->lockcnt;
 		goto out;
 	}
 
-	if (likely(xnarch_atomic_cmpxchg(ownerp, cur, XN_NO_HANDLE) == cur)) {
+	if (likely(xnsynch_fast_release(ownerp, cur))) {
 	  out:
 		cb_read_unlock(&shadow->lock, s);
 		return 0;


