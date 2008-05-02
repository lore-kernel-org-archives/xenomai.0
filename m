From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18459.38785.367098.763153@domain.hid>
Date: Sat, 3 May 2008 00:36:49 +0200
In-Reply-To: <18459.38704.252719.734650@domain.hid>
References: <18459.38249.462320.715909@domain.hid>
	<18459.38430.835407.942336@domain.hid>
	<18459.38500.720338.652195@domain.hid>
	<18459.38558.684426.240775@domain.hid>
	<18459.38644.699369.801548@domain.hid>
	<18459.38704.252719.734650@domain.hid>
Subject: [Xenomai-core] [Patch 6/7] Re-implementation of mutexes,
	kernel-space support.
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


No comment.

---
 include/posix/pthread.h    |   56 ++++----
 ksrc/skins/posix/cb_lock.h |   84 ++++++++++++
 ksrc/skins/posix/cond.c    |   41 ++++-
 ksrc/skins/posix/mutex.c   |  308 +++++++++++++++++++++++++++------------------
 ksrc/skins/posix/mutex.h   |  125 ++++++++++++++----
 ksrc/skins/posix/shm.c     |   40 -----
 ksrc/skins/posix/syscall.c |  300 ++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 725 insertions(+), 229 deletions(-)

Index: ksrc/skins/posix/shm.c
===================================================================
--- ksrc/skins/posix/shm.c	(revision 3738)
+++ ksrc/skins/posix/shm.c	(working copy)
@@ -90,14 +90,6 @@ static void pse51_shm_init(pse51_shm_t *
 	appendq(&pse51_shmq, &shm->link);
 }
 
-#ifndef CONFIG_XENO_OPT_PERVASIVE
-static void pse51_free_heap_extent(xnheap_t *heap,
-				   void *extent, u_long size, void *cookie)
-{
-	xnarch_free_host_mem(extent, size);
-}
-#endif /* !CONFIG_XENO_OPT_PERVASIVE */
-
 /* Must be called nklock locked, irq off. */
 static void pse51_shm_destroy(pse51_shm_t * shm, int force)
 {
@@ -111,11 +103,7 @@ static void pse51_shm_destroy(pse51_shm_
 	if (shm->addr) {
 		xnheap_free(&shm->heapbase, shm->addr);
 
-#ifdef CONFIG_XENO_OPT_PERVASIVE
 		xnheap_destroy_mapped(&shm->heapbase);
-#else /* !CONFIG_XENO_OPT_PERVASIVE. */
-		xnheap_destroy(&shm->heapbase, &pse51_free_heap_extent, NULL);
-#endif /* !CONFIG_XENO_OPT_PERVASIVE. */
 
 		shm->addr = NULL;
 		shm->size = 0;
@@ -534,37 +522,19 @@ int ftruncate(int fd, off_t len)
 			memcpy(addr, shm->addr, size);
 
 			xnheap_free(&shm->heapbase, shm->addr);
-#ifdef CONFIG_XENO_OPT_PERVASIVE
 			xnheap_destroy_mapped(&shm->heapbase);
-#else /* !CONFIG_XENO_OPT_PERVASIVE. */
-			xnheap_destroy(&shm->heapbase, &pse51_free_heap_extent,
-				       NULL);
-#endif /* !CONFIG_XENO_OPT_PERVASIVE. */
 
 			shm->addr = NULL;
 			shm->size = 0;
 		}
 
 		if (len) {
-#ifdef CONFIG_XENO_OPT_PERVASIVE
-			int flags = len <= 128 * 1024 ? GFP_USER : 0;
-			err = -xnheap_init_mapped(&shm->heapbase, len, flags);
-#else /* !CONFIG_XENO_OPT_PERVASIVE. */
-			{
-				void *heapaddr = xnarch_alloc_host_mem(len);
-
-				if (heapaddr)
-					err =
-					    -xnheap_init(&shm->heapbase,
-							 heapaddr, len,
-							 XNCORE_PAGE_SIZE);
-				else
-					err = ENOMEM;
+			int flags = (XNARCH_SHARED_HEAP_FLAGS ?:
+				     len <= 128 * 1024 ? GFP_USER : 0);
 
-				if (err)
-					goto err_up;
-			}
-#endif /* !CONFIG_XENO_OPT_PERVASIVE. */
+			err = -xnheap_init_mapped(&shm->heapbase, len, flags);
+			if (err)
+				goto err_up;
 
 			shm->size = xnheap_max_contiguous(&shm->heapbase);
 			shm->addr = xnheap_alloc(&shm->heapbase, shm->size);
Index: ksrc/skins/posix/cb_lock.h
===================================================================
--- ksrc/skins/posix/cb_lock.h	(revision 0)
+++ ksrc/skins/posix/cb_lock.h	(revision 0)
@@ -0,0 +1,84 @@
+#ifndef CB_LOCK_H
+#define CB_LOCK_H
+
+#include <asm/xenomai/atomic.h>
+
+#ifndef __KERNEL__
+typedef void xnthread_t;
+#endif /* __KERNEL__ */
+
+#ifdef XNARCH_HAVE_US_ATOMIC_CMPXCHG
+
+#define test_claimed(owner) ((long) (owner) & 1)
+#define clear_claimed(owner) ((xnthread_t *) ((long) (owner) & ~1))
+#define set_claimed(owner, bit) \
+        ((xnthread_t *) ((long) clear_claimed(owner) | !!(bit)))
+	
+static  __inline__ int __cb_try_read_lock(xnarch_atomic_t *lock)
+{
+	unsigned val = xnarch_atomic_get(lock);
+	while (likely(val != -1)) {
+		unsigned old = xnarch_atomic_cmpxchg(lock, val, val + 1);
+		if (likely(old == val))
+			return 0;
+		val = old;
+	}
+	return -EBUSY;
+}
+
+static __inline__ void __cb_read_unlock(xnarch_atomic_t *lock)
+{
+	unsigned old, val = xnarch_atomic_get(lock);
+	while (likely(val != -1)) {
+		old = xnarch_atomic_cmpxchg(lock, val, val - 1);
+		if (likely(old == val))
+			return;
+		val = old;
+	}
+}
+
+static __inline__ int __cb_try_write_lock(xnarch_atomic_t *lock)
+{
+	unsigned old = xnarch_atomic_cmpxchg(lock, 0, -1);
+	if (unlikely(old))
+		return -EBUSY;
+	return 0;
+}
+
+static __inline__ void __cb_force_write_lock(xnarch_atomic_t *lock)
+{
+	xnarch_atomic_set(lock, -1);
+}
+
+static __inline__ void __cb_write_unlock(xnarch_atomic_t *lock)
+{
+	xnarch_atomic_set(lock, 0);
+}
+#define DECLARE_CB_LOCK_FLAGS(name) struct { } name __attribute__((unused))
+#define cb_try_read_lock(lock, flags) __cb_try_read_lock(lock)
+#define cb_read_unlock(lock, flags) __cb_read_unlock(lock)
+#define cb_try_write_lock(lock, flags) __cb_try_write_lock(lock)
+#define cb_force_write_lock(lock, flags) __cb_force_write_lock(lock)
+#define cb_write_unlock(lock, flags) __cb_write_unlock(lock)
+#else /* !XNARCH_HAVE_US_ATOMIC_CMPXCHG */
+#ifdef __KERNEL__
+#define DECLARE_CB_LOCK_FLAGS(name) spl_t name
+#define cb_try_read_lock(lock, flags) \
+	({ xnlock_get_irqsave(&nklock, flags); 0 })
+#define cb_read_unlock(lock, flags) xnlock_put_irqrestore(&nklock, flags)
+#define cb_try_write_lock(lock, flags)  \
+	({ xnlock_get_irqsave(&nklock, flags); 0 })
+#define cb_force_write_lock(lock, flags)  \
+	({ xnlock_get_irqsave(&nklock, flags); 0 })
+#define cb_write_unlock(lock, flags) xnlock_put_irqrestore(&nklock, flags)
+#else /* !__KERNEL__ */
+#define DECLARE_CB_LOCK_FLAGS(name)
+#define cb_try_read_lock(lock, flags) (0)
+#define cb_read_unlock(lock, flags) do { } while (0)
+#define cb_try_write_lock(lock, flags) (0)
+#define cb_force_write_lock(lock, flags) do { } while (0)
+#define cb_write_unlock(lock, flags) do { } while (0)
+#endif /* !__KERNEL__ */
+#endif /* !XNARCH_HAVE_US_ATOMIC_CMPXCHG */
+
+#endif /* CB_LOCK_H */
Index: include/posix/pthread.h
===================================================================
--- include/posix/pthread.h	(revision 3738)
+++ include/posix/pthread.h	(working copy)
@@ -93,19 +93,6 @@ typedef struct pse51_threadattr {
 
 /* pthread_mutexattr_t and pthread_condattr_t fit on 32 bits, for compatibility
    with libc. */
-typedef struct pse51_mutexattr {
-	unsigned magic: 24;
-	unsigned type: 2;
-	unsigned protocol: 2;
-	unsigned pshared: 1;
-} pthread_mutexattr_t;
-
-typedef struct pse51_condattr {
-	unsigned magic: 24;
-	unsigned clock: 2;
-	unsigned pshared: 1;
-} pthread_condattr_t;
-
 struct pse51_key;
 typedef struct pse51_key *pthread_key_t;
 
@@ -169,24 +156,44 @@ struct timespec;
 #define PTHREAD_IENABLE     0
 #define PTHREAD_IDISABLE    1
 
+struct pse51_mutexattr {
+	unsigned magic: 24;
+	unsigned type: 2;
+	unsigned protocol: 2;
+	unsigned pshared: 1;
+};
+
+struct pse51_condattr {
+	unsigned magic: 24;
+	unsigned clock: 2;
+	unsigned pshared: 1;
+};
+
 struct pse51_mutex;
 
 union __xeno_mutex {
-    pthread_mutex_t native_mutex;
-    struct __shadow_mutex {
-	unsigned magic;
-	struct pse51_mutex *mutex;
-    } shadow_mutex;
+	pthread_mutex_t native_mutex;
+	struct __shadow_mutex {
+		unsigned magic;
+		unsigned lockcnt;
+		struct pse51_mutex *mutex;
+		xnarch_atomic_t lock;
+		union {
+			unsigned owner_offset;
+			xnarch_atomic_intptr_t *owner;
+		};
+		struct pse51_mutexattr attr;
+	} shadow_mutex;
 };
 
 struct pse51_cond;
 
 union __xeno_cond {
-    pthread_cond_t native_cond;
-    struct __shadow_cond {
-	unsigned magic;
-	struct pse51_cond *cond;
-    } shadow_cond;
+	pthread_cond_t native_cond;
+	struct __shadow_cond {
+		unsigned magic;
+		struct pse51_cond *cond;
+	} shadow_cond;
 };
 
 struct pse51_interrupt;
@@ -194,6 +201,9 @@ struct pse51_interrupt;
 typedef struct pse51_interrupt *pthread_intr_t;
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
+typedef struct pse51_mutexattr pthread_mutexattr_t;
+
+typedef struct pse51_condattr pthread_condattr_t;
 
 #ifdef __cplusplus
 extern "C" {
Index: ksrc/skins/posix/mutex.h
===================================================================
--- ksrc/skins/posix/mutex.h	(revision 3738)
+++ ksrc/skins/posix/mutex.h	(working copy)
@@ -21,6 +21,7 @@
 
 #include <posix/internal.h>
 #include <posix/thread.h>
+#include <posix/cb_lock.h>
 
 typedef struct pse51_mutex {
 	xnsynch_t synchbase;
@@ -29,47 +30,58 @@ typedef struct pse51_mutex {
 #define link2mutex(laddr)                                               \
 	((pse51_mutex_t *)(((char *)laddr) - offsetof(pse51_mutex_t, link)))
 
+	xnarch_atomic_intptr_t *owner;
 	pthread_mutexattr_t attr;
-	unsigned count;             /* lock count. */
-	unsigned condvars;          /* count of condition variables using this
-				       mutex. */
 	pse51_kqueues_t *owningq;
 } pse51_mutex_t;
 
+extern pthread_mutexattr_t pse51_default_mutex_attr;
+
 void pse51_mutexq_cleanup(pse51_kqueues_t *q);
 
 void pse51_mutex_pkg_init(void);
 
 void pse51_mutex_pkg_cleanup(void);
 
-/* Interruptible versions of pthread_mutex_*. Exposed for use by syscall.c. */
+/* Internal mutex functions, exposed for use by syscall.c. */
 int pse51_mutex_timedlock_break(struct __shadow_mutex *shadow,
 				int timed, xnticks_t to);
 
-/* must be called with nklock locked, interrupts off. */
-static inline int pse51_mutex_trylock_internal(xnthread_t *cur,
-					       struct __shadow_mutex *shadow,
-					       unsigned count)
+int pse51_mutex_check_init(struct __shadow_mutex *shadow,
+			   const pthread_mutexattr_t *attr);
+
+int pse51_mutex_init_internal(struct __shadow_mutex *shadow,
+			      pse51_mutex_t *mutex,
+			      xnarch_atomic_intptr_t *ownerp,
+			      const pthread_mutexattr_t *attr);
+
+void pse51_mutex_destroy_internal(pse51_mutex_t *mutex,
+				  pse51_kqueues_t *q);
+
+static inline xnthread_t *
+pse51_mutex_trylock_internal(xnthread_t *cur,
+			     struct __shadow_mutex *shadow, unsigned count)
 {
 	pse51_mutex_t *mutex = shadow->mutex;
+	xnthread_t *owner;
 
 	if (xnpod_unblockable_p())
-		return EPERM;
+		return ERR_PTR(-EPERM);
 
 	if (!pse51_obj_active(shadow, PSE51_MUTEX_MAGIC, struct __shadow_mutex))
-		return EINVAL;
+		return ERR_PTR(-EINVAL);
 
 #if XENO_DEBUG(POSIX)
 	if (mutex->owningq != pse51_kqueues(mutex->attr.pshared))
-		return EPERM;
+		return ERR_PTR(-EPERM);
 #endif /* XENO_DEBUG(POSIX) */
 
-	if (mutex->count)
-		return EBUSY;
+	owner = xnarch_atomic_intptr_cmpxchg(mutex->owner, NULL, cur);
+	if (unlikely(owner))
+		return owner;
 
-	xnsynch_set_owner(&mutex->synchbase, cur);
-	mutex->count = count;
-	return 0;
+	shadow->lockcnt = count;
+	return NULL;
 }
 
 /* must be called with nklock locked, interrupts off. */
@@ -81,31 +93,86 @@ static inline int pse51_mutex_timedlock_
 
 {
 	pse51_mutex_t *mutex;
+	xnthread_t *owner, *old;
+	spl_t s;
 	int err;
 
-	err = pse51_mutex_trylock_internal(cur, shadow, count);
-	if (err != EBUSY)
-		return err;
+  retry_lock:
+	owner = pse51_mutex_trylock_internal(cur, shadow, count);
+	if (likely(!owner) || IS_ERR(owner))
+		return PTR_ERR(owner);
 
 	mutex = shadow->mutex;
-	if (xnsynch_owner(&mutex->synchbase) == cur)
-		return EBUSY;
+	if (clear_claimed(owner) == cur)
+		return -EBUSY;
 
+	/* Set bit 0, so that mutex_unlock will know that the mutex is claimed.
+	   Hold the nklock, for mutual exclusion with slow mutex_unlock. */
+	xnlock_get_irqsave(&nklock, s);
+	while(!test_claimed(owner)) {
+		old = xnarch_atomic_intptr_cmpxchg(mutex->owner,
+						   owner, set_claimed(owner, 1));
+		if (likely(old == owner))
+			break;
+		if (old == NULL) {
+			/* Owner called fast mutex_unlock
+			   (on another cpu) */
+			xnlock_put_irqrestore(&nklock, s);
+			goto retry_lock;
+		}
+		owner = old;
+	}
+
+	xnsynch_set_owner(&mutex->synchbase, clear_claimed(owner));
 	if (timed)
 		xnsynch_sleep_on(&mutex->synchbase, abs_to, XN_REALTIME);
 	else
 		xnsynch_sleep_on(&mutex->synchbase, XN_INFINITE, XN_RELATIVE);
 
-	if (xnthread_test_info(cur, XNBREAK))
-		return EINTR;
-            
-	if (xnthread_test_info(cur, XNRMID))
-		return EINVAL;
-
-	if (xnthread_test_info(cur, XNTIMEO))
-		return ETIMEDOUT;
+	if (xnthread_test_info(cur, XNBREAK)) {
+		err = -EINTR;
+		goto error;
+	}
+	if (xnthread_test_info(cur, XNRMID)) {
+		err = -EINVAL;
+		goto error;
+	}
+	if (xnthread_test_info(cur, XNTIMEO)) {
+		err = -ETIMEDOUT;
+		goto error;
+	}
+
+	xnarch_atomic_intptr_set
+		(mutex->owner,
+		 set_claimed(cur, xnsynch_nsleepers(&mutex->synchbase)));
+	shadow->lockcnt = count;
+	xnlock_put_irqrestore(&nklock, s);
 
 	return 0;
+
+  error:
+	if (!xnsynch_nsleepers(&mutex->synchbase))
+		xnarch_atomic_intptr_set
+			(mutex->owner,
+			 clear_claimed(xnarch_atomic_intptr_get(mutex->owner)));
+	xnlock_put_irqrestore(&nklock, s);
+	return err;
+}
+
+static inline void pse51_mutex_unlock_internal(xnthread_t *cur,
+					       pse51_mutex_t *mutex)
+{
+	spl_t s;
+
+	if (likely(xnarch_atomic_intptr_cmpxchg(mutex->owner, cur, NULL) == cur))
+		return;
+
+	xnlock_get_irqsave(&nklock, s);
+	if (xnsynch_wakeup_one_sleeper(&mutex->synchbase))
+		xnpod_schedule();
+	else
+		xnarch_atomic_intptr_set(mutex->owner, NULL);
+	xnlock_put_irqrestore(&nklock, s);
 }
 
 #endif /* !_POSIX_MUTEX_H */
Index: ksrc/skins/posix/mutex.c
===================================================================
--- ksrc/skins/posix/mutex.c	(revision 3738)
+++ ksrc/skins/posix/mutex.c	(working copy)
@@ -47,23 +47,74 @@
  *
  *@{*/
 
+#include <nucleus/sys_ppd.h>
 #include <posix/mutex.h>
 
-static pthread_mutexattr_t default_attr;
+pthread_mutexattr_t pse51_default_mutex_attr;
 
-static void pse51_mutex_destroy_internal(pse51_mutex_t *mutex,
-					 pse51_kqueues_t *q)
+int pse51_mutex_check_init(struct __shadow_mutex *shadow,
+			   const pthread_mutexattr_t *attr)
 {
+	xnqueue_t *mutexq;
+
+	if (!attr)
+		attr = &pse51_default_mutex_attr;
+
+	mutexq = &pse51_kqueues(attr->pshared)->mutexq;
+
+	if (shadow->magic == PSE51_MUTEX_MAGIC) {
+		xnholder_t *holder;
+		for (holder = getheadq(mutexq); holder;
+		     holder = nextq(mutexq, holder))
+			if (holder == &shadow->mutex->link)
+				/* mutex is already in the queue. */
+				return -EBUSY;
+	}
+
+	return 0;
+}
+
+int pse51_mutex_init_internal(struct __shadow_mutex *shadow,
+			      pse51_mutex_t *mutex,
+			      xnarch_atomic_intptr_t *ownerp,
+			      const pthread_mutexattr_t *attr)
+{
+	xnflags_t synch_flags = XNSYNCH_PRIO | XNSYNCH_NOPIP;
+	struct xnsys_ppd *sys_ppd;
+	pse51_kqueues_t *kq;
 	spl_t s;
 
+	if (!attr)
+		attr = &pse51_default_mutex_attr;
+
+	if (attr->magic != PSE51_MUTEX_ATTR_MAGIC)
+		return -EINVAL;
+
+	kq = pse51_kqueues(attr->pshared);
+	sys_ppd = xnsys_ppd_get(attr->pshared);
+
+	shadow->magic = PSE51_MUTEX_MAGIC;
+	atomic_set(&shadow->lock, -1);
+	shadow->mutex = mutex;
+	shadow->attr = *attr;
+	shadow->lockcnt = 0;
+	shadow->owner_offset = xnheap_mapped_offset(&sys_ppd->sem_heap, ownerp);
+
+	if (attr->protocol == PTHREAD_PRIO_INHERIT)
+		synch_flags |= XNSYNCH_PIP;
+
+	xnsynch_init(&mutex->synchbase, synch_flags);
+	inith(&mutex->link);
+	mutex->attr = *attr;
+	mutex->owner = ownerp;
+	mutex->owningq = kq;
+	xnarch_atomic_intptr_set(ownerp, NULL);
+
 	xnlock_get_irqsave(&nklock, s);
-	removeq(&q->mutexq, &mutex->link);
-	/* synchbase wait queue may not be empty only when this function is called
-	   from pse51_mutex_pkg_cleanup, hence the absence of xnpod_schedule(). */
-	xnsynch_destroy(&mutex->synchbase);
+	appendq(&kq->mutexq, &mutex->link);
 	xnlock_put_irqrestore(&nklock, s);
 
-	xnfree(mutex);
+	return 0;
 }
 
 /**
@@ -83,72 +134,84 @@ static void pse51_mutex_destroy_internal
  * - EBUSY, the mutex @a mx was already initialized;
  * - ENOMEM, insufficient memory exists in the system heap to initialize the
  *   mutex, increase CONFIG_XENO_OPT_SYS_HEAPSZ.
+ * - EAGAIN, insufficient memory exists in the semaphore heap to initialize the
+ *   mutex, increase CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ for a process-shared
+ *   mutex, or CONFG_XENO_OPT_SEM_HEAPSZ for a process-private mutex.
  *
  * @see
  * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/pthread_mutex_init.html">
  * Specification.</a>
  * 
  */
-int pthread_mutex_init(pthread_mutex_t * mx, const pthread_mutexattr_t * attr)
+int pthread_mutex_init(pthread_mutex_t *mx, const pthread_mutexattr_t *attr)
 {
 	struct __shadow_mutex *shadow =
 	    &((union __xeno_mutex *)mx)->shadow_mutex;
-	xnflags_t synch_flags = XNSYNCH_PRIO | XNSYNCH_NOPIP;
+	DECLARE_CB_LOCK_FLAGS(s);
 	pse51_mutex_t *mutex;
-	xnqueue_t *mutexq;
-	spl_t s;
+	xnarch_atomic_intptr_t *ownerp;
 	int err;
 
 	if (!attr)
-		attr = &default_attr;
+		attr = &pse51_default_mutex_attr;
 
+	if (unlikely(cb_try_read_lock(&shadow->lock, s)))
+		goto checked;
+
+	err = pse51_mutex_check_init(shadow, attr);
+#ifndef XNARCH_HAVE_US_ATOMIC_CMPXCHG
+	cb_read_unlock(&shadow->lock, s);
+	if (err)
+		return -err;
+#else /* XNARCH_HAVE_US_ATOMIC_CMPXCHG */
+	if (err) {
+		cb_read_unlock(&shadow->lock, s);
+		return -err;
+	}
+#endif /* XNARCH_HAVE_US_ATOMIC_CMPXCHG */
+
+  checked:
 	mutex = (pse51_mutex_t *) xnmalloc(sizeof(*mutex));
 	if (!mutex)
 		return ENOMEM;
 
-	xnlock_get_irqsave(&nklock, s);
-
-	if (attr->magic != PSE51_MUTEX_ATTR_MAGIC) {
-		err = EINVAL;
-		goto error;
+	ownerp = (xnarch_atomic_intptr_t *)
+		xnheap_alloc(&xnsys_ppd_get(attr->pshared)->sem_heap,
+			     sizeof(xnarch_atomic_intptr_t));
+	if (!ownerp) {
+		xnfree(mutex);
+		return EAGAIN;
 	}
 
-	mutexq = &pse51_kqueues(attr->pshared)->mutexq;
-
-	if (shadow->magic == PSE51_MUTEX_MAGIC) {
-		xnholder_t *holder;
-		for (holder = getheadq(mutexq); holder;
-		     holder = nextq(mutexq, holder))
-			if (holder == &shadow->mutex->link) {
-				/* mutex is already in the queue. */
-				err = EBUSY;
-				goto error;
-			}
+	cb_force_write_lock(&shadow->lock, s);
+	err = pse51_mutex_init_internal(shadow, mutex, ownerp, attr);
+	cb_write_unlock(&shadow->lock, s);
+
+	if (err) {
+		xnfree(mutex);
+		xnheap_free(&xnsys_ppd_get(attr->pshared)->sem_heap, ownerp);
 	}
+	return -err;
+}
 
-	shadow->magic = PSE51_MUTEX_MAGIC;
-	shadow->mutex = mutex;
-
-	if (attr->protocol == PTHREAD_PRIO_INHERIT)
-		synch_flags |= XNSYNCH_PIP;
-
-	xnsynch_init(&mutex->synchbase, synch_flags);
-	inith(&mutex->link);
-	mutex->attr = *attr;
-	mutex->count = 0;
-	mutex->condvars = 0;
-	mutex->owningq = pse51_kqueues(attr->pshared);
-
-	appendq(mutexq, &mutex->link);
+void pse51_mutex_destroy_internal(pse51_mutex_t *mutex,
+				  pse51_kqueues_t *q)
+{
+	spl_t s;
 
+	xnlock_get_irqsave(&nklock, s);
+	removeq(&q->mutexq, &mutex->link);
+	/* synchbase wait queue may not be empty only when this function is called
+	   from pse51_mutex_pkg_cleanup, hence the absence of xnpod_schedule(). */
+	xnsynch_destroy(&mutex->synchbase);
 	xnlock_put_irqrestore(&nklock, s);
 
-	return 0;
-
-  error:
-	xnlock_put_irqrestore(&nklock, s);
+	if (mutex->attr.pshared)
+		xnheap_free(&xnsys_ppd_get(1)->sem_heap, mutex->owner);
+	/* We do not free the owner if the mutex is not pshared, because when
+	   this function is called from pse51_mutexq_cleanup, the sem_heap has
+	   been destroyed, and we have no way to find it back. */
 	xnfree(mutex);
-	return err;
 }
 
 /**
@@ -176,30 +239,34 @@ int pthread_mutex_destroy(pthread_mutex_
 {
 	struct __shadow_mutex *shadow =
 	    &((union __xeno_mutex *)mx)->shadow_mutex;
+	DECLARE_CB_LOCK_FLAGS(s);
 	pse51_mutex_t *mutex;
-	spl_t s;
 
-	xnlock_get_irqsave(&nklock, s);
+	if (unlikely(cb_try_write_lock(&shadow->lock, s)))
+		return EBUSY;
 
 	if (!pse51_obj_active(shadow, PSE51_MUTEX_MAGIC, struct __shadow_mutex)) {
-		xnlock_put_irqrestore(&nklock, s);
+		cb_write_unlock(&shadow->lock, s);
 		return EINVAL;
 	}
 
 	mutex = shadow->mutex;
 	if (pse51_kqueues(mutex->attr.pshared) != mutex->owningq) {
-		xnlock_put_irqrestore(&nklock, s);
+		cb_write_unlock(&shadow->lock, s);
 		return EPERM;
 	}
 
-	if (mutex->count || mutex->condvars) {
-		xnlock_put_irqrestore(&nklock, s);
+	if (xnarch_atomic_intptr_get(mutex->owner)) {
+		cb_write_unlock(&shadow->lock, s);
 		return EBUSY;
 	}
 
 	pse51_mark_deleted(shadow);
-	xnlock_put_irqrestore(&nklock, s);
+	cb_write_unlock(&shadow->lock, s);
 
+	if (!mutex->attr.pshared)
+		xnheap_free(&xnsys_ppd_get(mutex->attr.pshared)->sem_heap,
+			    mutex->owner);
 	pse51_mutex_destroy_internal(mutex, pse51_kqueues(mutex->attr.pshared));
 	
 	return 0;
@@ -210,20 +277,19 @@ int pse51_mutex_timedlock_break(struct _
 {
 	xnthread_t *cur = xnpod_current_thread();
 	pse51_mutex_t *mutex;
-	int err;
 	spl_t s;
-
-	xnlock_get_irqsave(&nklock, s);
+	int err;
 
 	err = pse51_mutex_timedlock_internal(cur, shadow, 1, timed, abs_to);
-	if (err != EBUSY)
+	if (err != -EBUSY)
 		goto unlock_and_return;
 
 	mutex = shadow->mutex;
 
-	switch (mutex->attr.type) {
+	switch(mutex->attr.type) {
 	case PTHREAD_MUTEX_NORMAL:
 		/* Attempting to relock a normal mutex, deadlock. */
+		xnlock_get_irqsave(&nklock, s);
 		for (;;) {
 			if (timed)
 				xnsynch_sleep_on(&mutex->synchbase,
@@ -233,41 +299,41 @@ int pse51_mutex_timedlock_break(struct _
 						 XN_INFINITE, XN_RELATIVE);
 
 			if (xnthread_test_info(cur, XNBREAK)) {
-				err = EINTR;
+				err = -EINTR;
 				break;
 			}
 
 			if (xnthread_test_info(cur, XNTIMEO)) {
-				err = ETIMEDOUT;
+				err = -ETIMEDOUT;
 				break;
 			}
 
 			if (xnthread_test_info(cur, XNRMID)) {
-				err = EINVAL;
+				err = -EINVAL;
 				break;
 			}
 		}
+		xnlock_put_irqrestore(&nklock, s);
 
 		break;
 
 	case PTHREAD_MUTEX_ERRORCHECK:
-		err = EDEADLK;
+		err = -EDEADLK;
 		break;
 
 	case PTHREAD_MUTEX_RECURSIVE:
-		if (mutex->count == UINT_MAX) {
-			err = EAGAIN;
+		if (shadow->lockcnt == UINT_MAX) {
+			err = -EAGAIN;
 			break;
 		}
 
-		++mutex->count;
+		++shadow->lockcnt;
 		err = 0;
 	}
 
   unlock_and_return:
-	xnlock_put_irqrestore(&nklock, s);
-
 	return err;
+		
 }
 
 /**
@@ -298,33 +364,36 @@ int pse51_mutex_timedlock_break(struct _
  * Specification.</a>
  * 
  */
-int pthread_mutex_trylock(pthread_mutex_t * mx)
+int pthread_mutex_trylock(pthread_mutex_t *mx)
 {
 	struct __shadow_mutex *shadow =
 	    &((union __xeno_mutex *)mx)->shadow_mutex;
-	xnthread_t *cur = xnpod_current_thread();
+	xnthread_t *owner, *cur = xnpod_current_thread();
+	DECLARE_CB_LOCK_FLAGS(s);
 	int err;
-	spl_t s;
 
-	xnlock_get_irqsave(&nklock, s);
+	if (unlikely(cb_try_read_lock(&shadow->lock, s)))
+		return EINVAL;
 
-	err = pse51_mutex_trylock_internal(cur, shadow, 1);
+	owner = pse51_mutex_trylock_internal(cur, shadow, 1);
+	if (likely(!owner) || IS_ERR(owner))
+		return -PTR_ERR(owner);
 
-	if (err == EBUSY) {
+	err = EBUSY;
+	if (clear_claimed(owner) == cur) {
 		pse51_mutex_t *mutex = shadow->mutex;
 
-		if (mutex->attr.type == PTHREAD_MUTEX_RECURSIVE
-		    && xnsynch_owner(&mutex->synchbase) == cur) {
-			if (mutex->count == UINT_MAX)
+		if (mutex->attr.type == PTHREAD_MUTEX_RECURSIVE) {
+			if (shadow->lockcnt == UINT_MAX)
 				err = EAGAIN;
 			else {
-				++mutex->count;
+				++shadow->lockcnt;
 				err = 0;
 			}
 		}
 	}
 
-	xnlock_put_irqrestore(&nklock, s);
+	cb_read_unlock(&shadow->lock, s);
 
 	return err;
 }
@@ -369,12 +438,18 @@ int pthread_mutex_lock(pthread_mutex_t *
 {
 	struct __shadow_mutex *shadow =
 	    &((union __xeno_mutex *)mx)->shadow_mutex;
+	DECLARE_CB_LOCK_FLAGS(s);
 	int err;
 
+	if (unlikely(cb_try_read_lock(&shadow->lock, s)))
+		return EINVAL;
+
 	do {
 		err = pse51_mutex_timedlock_break(shadow, 0, XN_INFINITE);
 	} while (err == EINTR);
 
+	cb_read_unlock(&shadow->lock, s);
+
 	return err;
 }
 
@@ -416,40 +491,20 @@ int pthread_mutex_timedlock(pthread_mute
 {
 	struct __shadow_mutex *shadow =
 	    &((union __xeno_mutex *)mx)->shadow_mutex;
+	DECLARE_CB_LOCK_FLAGS(s);
 	int err;
 
+	if (unlikely(cb_try_read_lock(&shadow->lock, s)))
+		return EINVAL;
+
 	do {
 		err = pse51_mutex_timedlock_break(shadow, 1,
 						  ts2ticks_ceil(to) + 1);
 	} while (err == EINTR);
 
-	return err;
-}
-
-/* must be called with nklock locked, interrupts off.
-
-   Note: the function mutex_save_count() in cond.c is very similar to this
-   function.
-*/
-static inline int mutex_unlock_internal(xnthread_t *cur,
-					struct __shadow_mutex *shadow)
-{
-	pse51_mutex_t *mutex;
-
-	if (!pse51_obj_active(shadow, PSE51_MUTEX_MAGIC, struct __shadow_mutex))
-		 return EINVAL;
-
-	mutex = shadow->mutex;
-
-	if (xnsynch_owner(&mutex->synchbase) != cur || mutex->count != 1)
-		return EPERM;
-
-	if (xnsynch_wakeup_one_sleeper(&mutex->synchbase))
-		xnpod_schedule();
-	else
-		mutex->count = 0;
+	cb_read_unlock(&shadow->lock, s);
 
-	return 0;
+	return err;
 }
 
 /**
@@ -488,28 +543,41 @@ int pthread_mutex_unlock(pthread_mutex_t
 	struct __shadow_mutex *shadow =
 	    &((union __xeno_mutex *)mx)->shadow_mutex;
 	xnthread_t *cur = xnpod_current_thread();
+	DECLARE_CB_LOCK_FLAGS(s);
+	pse51_mutex_t *mutex;
 	int err;
-	spl_t s;
 
 	if (xnpod_root_p() || xnpod_interrupt_p())
-		return EPERM;
+		return -EPERM;
 
-	xnlock_get_irqsave(&nklock, s);
+	if (unlikely(cb_try_read_lock(&shadow->lock, s)))
+		return EINVAL;
 
-	err = mutex_unlock_internal(cur, shadow);
+	if (!pse51_obj_active(shadow,
+			      PSE51_MUTEX_MAGIC, struct __shadow_mutex)) {
+		err = EINVAL;
+		goto out;
+	}
 
-	if (err == EPERM) {
-		pse51_mutex_t *mutex = shadow->mutex;
+	mutex = shadow->mutex;
+	
+	if (clear_claimed(xnarch_atomic_intptr_get(mutex->owner)) != cur) {
+		err = EPERM;
+		goto out;
+	}
 
-		if (mutex->attr.type == PTHREAD_MUTEX_RECURSIVE
-		    && xnsynch_owner(&mutex->synchbase) == cur
-		    && mutex->count) {
-			--mutex->count;
-			err = 0;
-		}
+	err = 0;
+	if (shadow->lockcnt > 1) {
+		/* Mutex is recursive */
+		--shadow->lockcnt;
+		cb_read_unlock(&shadow->lock, s);
+		return 0;
 	}
 
-	xnlock_put_irqrestore(&nklock, s);
+	pse51_mutex_unlock_internal(cur, mutex);
+
+  out:
+	cb_read_unlock(&shadow->lock, s);
 
 	return err;
 }
@@ -536,7 +604,7 @@ void pse51_mutexq_cleanup(pse51_kqueues_
 void pse51_mutex_pkg_init(void)
 {
 	initq(&pse51_global_kqueues.mutexq);
-	pthread_mutexattr_init(&default_attr);
+	pthread_mutexattr_init(&pse51_default_mutex_attr);
 }
 
 void pse51_mutex_pkg_cleanup(void)
Index: ksrc/skins/posix/cond.c
===================================================================
--- ksrc/skins/posix/cond.c	(revision 3738)
+++ ksrc/skins/posix/cond.c	(working copy)
@@ -229,15 +229,16 @@ static inline int mutex_save_count(xnthr
 
 	mutex = shadow->mutex;
 
-	if (xnsynch_owner(&mutex->synchbase) != cur || mutex->count == 0)
+	if (clear_claimed(xnarch_atomic_intptr_get(mutex->owner)) != cur)
 		return EPERM;
 
-	*count_ptr = mutex->count;
+	*count_ptr = shadow->lockcnt;
 
-	if (xnsynch_wakeup_one_sleeper(&mutex->synchbase))
-		mutex->count = 1;
-	else
-		mutex->count = 0;
+	if (likely(xnarch_atomic_intptr_cmpxchg(mutex->owner, cur, NULL) == cur))
+		return 0;
+
+	if (!xnsynch_wakeup_one_sleeper(&mutex->synchbase))
+		xnarch_atomic_intptr_set(mutex->owner, NULL);
 	/* Do not reschedule here, releasing the mutex and suspension must be
 	   done atomically in pthread_cond_*wait. */
 
@@ -287,10 +288,8 @@ int pse51_cond_timedwait_prologue(xnthre
 		goto unlock_and_return;
 
 	/* Bind mutex to cond. */
-	if (cond->mutex == NULL) {
+	if (cond->mutex == NULL)
 		cond->mutex = mutex->mutex;
-		++mutex->mutex->condvars;
-	}
 
 	/* Wait for another thread to signal the condition. */
 	if (timed)
@@ -349,11 +348,8 @@ int pse51_cond_timedwait_epilogue(xnthre
 	/* Unbind mutex and cond, if no other thread is waiting, if the job was
 	   not already done. */
 	if (!xnsynch_nsleepers(&cond->synchbase)
-	    && cond->mutex == mutex->mutex) {
-	
-		--mutex->mutex->condvars;
+	    && cond->mutex == mutex->mutex)
 		cond->mutex = NULL;
-	}
 
 	thread_cancellation_point(cur);
 
@@ -419,9 +415,15 @@ int pthread_cond_wait(pthread_cond_t * c
 	struct __shadow_mutex *mutex =
 	    &((union __xeno_mutex *)mx)->shadow_mutex;
 	xnthread_t *cur = xnpod_current_thread();
+	DECLARE_CB_LOCK_FLAGS(s);
 	unsigned count;
 	int err;
 
+#ifdef XNARCH_HAVE_US_ATOMIC_CMPXCHG
+	if (unlikely(cb_try_read_lock(&mutex->lock, s)))
+		return EINVAL;
+#endif /* XNARCH_HAVE_US_ATOMIC_CMPXCHG */
+
 	err = pse51_cond_timedwait_prologue(cur, cond, mutex,
 					    &count, 0, XN_INFINITE);
 
@@ -430,6 +432,10 @@ int pthread_cond_wait(pthread_cond_t * c
 							      mutex, count))
 			;
 
+#ifdef XNARCH_HAVE_US_ATOMIC_CMPXCHG
+	cb_read_unlock(&mutex->lock, s);
+#endif /* XNARCH_HAVE_US_ATOMIC_CMPXCHG */
+
 	return err != EINTR ? err : 0;
 }
 
@@ -481,6 +487,11 @@ int pthread_cond_timedwait(pthread_cond_
 	unsigned count;
 	int err;
 
+#ifdef XNARCH_HAVE_US_ATOMIC_CMPXCHG
+	if (unlikely(cb_try_read_lock(&mutex->lock, s)))
+		return EINVAL;
+#endif /* XNARCH_HAVE_US_ATOMIC_CMPXCHG */
+
 	err = pse51_cond_timedwait_prologue(cur, cond, mutex, &count, 1,
 					    ts2ticks_ceil(abstime) + 1);
 
@@ -489,6 +500,10 @@ int pthread_cond_timedwait(pthread_cond_
 							      mutex, count))
 			;
 
+#ifdef XNARCH_HAVE_US_ATOMIC_CMPXCHG
+	cb_read_unlock(&mutex->lock, s);
+#endif /* XNARCH_HAVE_US_ATOMIC_CMPXCHG */
+
 	return err != EINTR ? err : 0;
 }
 
Index: ksrc/skins/posix/syscall.c
===================================================================
--- ksrc/skins/posix/syscall.c	(revision 3738)
+++ ksrc/skins/posix/syscall.c	(working copy)
@@ -23,6 +23,7 @@
 #include <asm/xenomai/wrappers.h>
 #include <nucleus/jhash.h>
 #include <nucleus/ppd.h>
+#include <nucleus/sys_ppd.h>
 #include <posix/syscall.h>
 #include <posix/posix.h>
 #include <posix/thread.h>
@@ -884,6 +885,7 @@ static int __pthread_mutexattr_setpshare
 	return __xn_safe_copy_to_user((void __user *)uattrp, &attr, sizeof(*uattrp));
 }
 
+#ifndef XNARCH_HAVE_US_ATOMIC_CMPXCHG
 static int __pthread_mutex_init(struct pt_regs *regs)
 {
 	pthread_mutexattr_t locattr, *attr, *uattrp;
@@ -941,54 +943,293 @@ static int __pthread_mutex_destroy(struc
 static int __pthread_mutex_lock(struct pt_regs *regs)
 {
 	union __xeno_mutex mx, *umx;
+	DECLARE_CB_LOCK_FLAGS(s);
+	int err;
 
 	umx = (union __xeno_mutex *)__xn_reg_arg1(regs);
 
 	if (__xn_safe_copy_from_user(&mx.shadow_mutex,
 				     (void __user *)&umx->shadow_mutex,
-				     sizeof(mx.shadow_mutex)))
+				     offsetof(struct __shadow_mutex, lock)))
+		return -EFAULT;
+
+	if (unlikely(cb_try_read_lock(&mx.shadow_mutex.lock, s)))
+		return -EINVAL;
+
+	err = pse51_mutex_timedlock_break(&mx.shadow_mutex, 0, XN_INFINITE);
+
+	cb_read_unlock(&mx.shadow_mutex.lock);
+
+	if (!err &&
+	    __xn_safe_copy_to_user((void __user *)&umx->shadow_mutex.lockcnt,
+				   &mx.shadow_mutex.lockcnt,
+				   sizeof(umx->shadow_mutex.lockcnt)))
 		return -EFAULT;
 
-	return -pse51_mutex_timedlock_break(&mx.shadow_mutex, 0, XN_INFINITE);
+	return -err
 }
 
 static int __pthread_mutex_timedlock(struct pt_regs *regs)
 {
 	union __xeno_mutex mx, *umx;
+	DECLARE_CB_LOCK_FLAGS(s);
 	struct timespec ts;
+	int err;
 
 	umx = (union __xeno_mutex *)__xn_reg_arg1(regs);
 
 	if (__xn_safe_copy_from_user(&mx.shadow_mutex,
 				     (void __user *)&umx->shadow_mutex,
-				     sizeof(mx.shadow_mutex)))
+				     offsetof(struct __shadow_mutex, lock)))
 		return -EFAULT;
 
 	if (__xn_safe_copy_from_user(&ts,
 				     (void __user *)__xn_reg_arg2(regs), sizeof(ts)))
 		return -EFAULT;
 
-	return -pse51_mutex_timedlock_break(&mx.shadow_mutex,
-					    1, ts2ticks_ceil(&ts) + 1);
+	if (unlikely(cb_try_read_lock(&mx.shadow_mutex.lock, s)))
+		return -EINVAL;
+
+	err = pse51_mutex_timedlock_break(&mx.shadow_mutex,
+					  1, ts2ticks_ceil(&ts) + 1);
+
+	cb_read_unlock(&mx.shadow_mutex.lock);
+
+	if (!err &&
+	    __xn_safe_copy_to_user((void __user *)&umx->shadow_mutex.lockcnt,
+				   &mx.shadow_mutex.lockcnt,
+				   sizeof(umx->shadow_mutex.lockcnt)))
+		return -EFAULT;
+
+	return -err
 }
 
 static int __pthread_mutex_trylock(struct pt_regs *regs)
 {
 	union __xeno_mutex mx, *umx;
+	int err;
 
 	umx = (union __xeno_mutex *)__xn_reg_arg1(regs);
 
 	if (__xn_safe_copy_from_user(&mx.shadow_mutex,
 				     (void __user *)&umx->shadow_mutex,
-				     sizeof(mx.shadow_mutex)))
+				     offsetof(struct __shadow_mutex, lock)))
 		return -EFAULT;
 
-	return -pthread_mutex_trylock(&mx.native_mutex);
+	err = pthread_mutex_trylock(&mx.native_mutex);
+
+	if (!err &&
+	    __xn_safe_copy_to_user((void __user *)&umx->shadow_mutex.lockcnt,
+				   &mx.shadow_mutex.lockcnt,
+				   sizeof(umx->shadow_mutex.lockcnt)))
+		return -EFAULT;
+
+	return -err;
 }
 
 static int __pthread_mutex_unlock(struct pt_regs *regs)
 {
+	xnthread_t *cur = xnpod_current_thread();
+	struct __shadow_mutex *shadow;
+	union __xeno_mutex mx, *umx;
+	DECLARE_CB_LOCK_FLAGS(s);
+	pse51_mutex_t *mutex;
+	int err;
+
+	if (xnpod_root_p())
+		return -EPERM;
+
+	umx = (union __xeno_mutex *)__xn_reg_arg1(regs);
+
+	if (__xn_safe_copy_from_user(&mx.shadow_mutex,
+				     (void __user *)&umx->shadow_mutex,
+				     offsetof(struct __shadow_mutex, lock)))
+		return -EFAULT;
+
+	shadow = &mx.shadow_mutex;
+
+	if (unlikely(cb_try_read_lock(&shadow->lock, s)))
+		return -EINVAL;
+
+	if (!pse51_obj_active(shadow,
+			      PSE51_MUTEX_MAGIC, struct __shadow_mutex)) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	mutex = shadow->mutex;
+
+	if (clear_claimed(xnarch_atomic_intptr_get(mutex->owner)) != cur) {
+		err = -EPERM;
+		goto out;
+	}
+
+	err = 0;
+	if (shadow->lockcnt > 1) {
+		/* Mutex is recursive */
+		--shadow->lockcnt;
+		cb_read_unlock(&shadow->lock, s);
+
+		if (__xn_safe_copy_to_user((void __user *)
+					   &umx->shadow_mutex.lockcnt,
+					   &shadow->lockcnt,
+					   sizeof(umx->shadow_mutex.lockcnt)))
+			return -EFAULT;
+
+		return 0;
+	}
+	
+	pse51_mutex_unlock_internal(cur, mutex);
+
+  out:
+	cb_read_unlock(&shadow->lock, s);
+
+	return err;
+}
+#else /* !XNARCH_HAVE_US_ATOMIC_CMPXCHG */
+static int __pthread_mutex_check_init(struct pt_regs *regs)
+{
+	pthread_mutexattr_t locattr, *attr, *uattrp;
+	union __xeno_mutex mx, *umx;
+
+	umx = (union __xeno_mutex *)__xn_reg_arg1(regs);
+
+	uattrp = (pthread_mutexattr_t *) __xn_reg_arg2(regs);
+
+	if (__xn_safe_copy_from_user(&mx.shadow_mutex,
+				     (void __user *)&umx->shadow_mutex,
+				     sizeof(mx.shadow_mutex)))
+		return -EFAULT;
+
+	if (uattrp) {
+		if (__xn_safe_copy_from_user(&locattr, (void __user *)
+					     uattrp, sizeof(locattr)))
+			return -EFAULT;
+
+		attr = &locattr;
+	} else
+		attr = NULL;
+
+	return pse51_mutex_check_init(&umx->shadow_mutex, attr);
+}
+
+static int __pthread_mutex_init(struct pt_regs *regs)
+{
+	pthread_mutexattr_t locattr, *attr, *uattrp;
+	union __xeno_mutex mx, *umx;
+	pse51_mutex_t *mutex;
+	xnarch_atomic_intptr_t *ownerp;
+	int err;
+
+	umx = (union __xeno_mutex *)__xn_reg_arg1(regs);
+
+	uattrp = (pthread_mutexattr_t *) __xn_reg_arg2(regs);
+
+	if (__xn_safe_copy_from_user(&mx.shadow_mutex,
+				     (void __user *)&umx->shadow_mutex,
+				     sizeof(mx.shadow_mutex)))
+		return -EFAULT;
+
+	if (uattrp) {
+		if (__xn_safe_copy_from_user(&locattr, (void __user *)
+					     uattrp, sizeof(locattr)))
+			return -EFAULT;
+
+		attr = &locattr;
+	} else
+		attr = &pse51_default_mutex_attr;
+
+	mutex = (pse51_mutex_t *) xnmalloc(sizeof(*mutex));
+	if (!mutex)
+		return -ENOMEM;
+
+	ownerp = (xnarch_atomic_intptr_t *)
+		xnheap_alloc(&xnsys_ppd_get(attr->pshared)->sem_heap,
+			     sizeof(xnarch_atomic_intptr_t));
+	if (!ownerp) {
+		xnfree(mutex);
+		return -EAGAIN;
+	}
+
+	err = pse51_mutex_init_internal(&mx.shadow_mutex, mutex, ownerp, attr);
+	if (err) {
+		xnfree(mutex);
+		xnheap_free(&xnsys_ppd_get(attr->pshared)->sem_heap, ownerp);
+		return err;
+	}
+
+	return __xn_safe_copy_to_user((void __user *)&umx->shadow_mutex,
+				      &mx.shadow_mutex, sizeof(umx->shadow_mutex));
+}
+
+static int __pthread_mutex_destroy(struct pt_regs *regs)
+{
+	struct __shadow_mutex *shadow;
 	union __xeno_mutex mx, *umx;
+	pse51_mutex_t *mutex;
+
+	umx = (union __xeno_mutex *)__xn_reg_arg1(regs);
+
+	shadow = &mx.shadow_mutex;
+
+	if (__xn_safe_copy_from_user(shadow,
+				     (void __user *)&umx->shadow_mutex,
+				     sizeof(*shadow)))
+		return -EFAULT;
+
+	if (!pse51_obj_active(shadow, PSE51_MUTEX_MAGIC, struct __shadow_mutex))
+		return -EINVAL;
+
+	mutex = shadow->mutex;
+	if (pse51_kqueues(mutex->attr.pshared) != mutex->owningq)
+		return -EPERM;
+
+	if (xnarch_atomic_intptr_get(mutex->owner))
+		return -EBUSY;
+
+	pse51_mark_deleted(shadow);
+	if (!mutex->attr.pshared)
+		xnheap_free(&xnsys_ppd_get(mutex->attr.pshared)->sem_heap,
+			    mutex->owner);
+	pse51_mutex_destroy_internal(mutex, mutex->owningq);
+
+	return __xn_safe_copy_to_user((void __user *)&umx->shadow_mutex,
+				      shadow, sizeof(umx->shadow_mutex));
+}
+
+static int __pthread_mutex_lock(struct pt_regs *regs)
+{
+	struct __shadow_mutex *shadow;
+	union __xeno_mutex mx, *umx;
+	int err;
+
+	umx = (union __xeno_mutex *)__xn_reg_arg1(regs);
+
+	if (__xn_safe_copy_from_user(&mx.shadow_mutex,
+				     (void __user *)&umx->shadow_mutex,
+				     offsetof(struct __shadow_mutex, lock)))
+		return -EFAULT;
+
+	shadow = &mx.shadow_mutex;
+
+	err = pse51_mutex_timedlock_break(&mx.shadow_mutex, 0, XN_INFINITE);
+
+	if (!err &&
+	    __xn_safe_copy_to_user((void __user *)
+				   &umx->shadow_mutex.lockcnt,
+				   &shadow->lockcnt,
+				   sizeof(umx->shadow_mutex.lockcnt)))
+		return -EFAULT;
+
+	return -err;
+}
+
+static int __pthread_mutex_timedlock(struct pt_regs *regs)
+{
+	struct __shadow_mutex *shadow;
+	union __xeno_mutex mx, *umx;
+	struct timespec ts;
+	int err;
 
 	umx = (union __xeno_mutex *)__xn_reg_arg1(regs);
 
@@ -997,8 +1238,46 @@ static int __pthread_mutex_unlock(struct
 				     sizeof(mx.shadow_mutex)))
 		return -EFAULT;
 
-	return -pthread_mutex_unlock(&mx.native_mutex);
+	if (__xn_safe_copy_from_user(&ts,
+				     (void __user *)__xn_reg_arg2(regs),
+				     sizeof(ts)))
+		return -EFAULT;
+
+	shadow = &mx.shadow_mutex;
+
+	err = pse51_mutex_timedlock_break(&mx.shadow_mutex,
+					    1, ts2ticks_ceil(&ts) + 1);
+
+	if (!err &&
+	    __xn_safe_copy_to_user((void __user *)
+				   &umx->shadow_mutex.lockcnt,
+				   &shadow->lockcnt,
+				   sizeof(umx->shadow_mutex.lockcnt)))
+		return -EFAULT;
+
+	return -err;
+}
+
+static int __pthread_mutex_unlock(struct pt_regs *regs)
+{
+	xnthread_t *cur = xnpod_current_thread();
+	union __xeno_mutex mx, *umx;
+
+	if (xnpod_root_p())
+		return -EPERM;
+
+	umx = (union __xeno_mutex *)__xn_reg_arg1(regs);
+
+	if (__xn_safe_copy_from_user(&mx.shadow_mutex,
+				     (void __user *)&umx->shadow_mutex,
+				     offsetof(struct __shadow_mutex, lock)))
+		return -EFAULT;
+
+	pse51_mutex_unlock_internal(cur, mx.shadow_mutex.mutex);
+
+	return 0;
 }
+#endif /* !XNARCH_HAVE_US_ATOMIC_CMPXCHG */
 
 static int __pthread_condattr_init(struct pt_regs *regs)
 {
@@ -2394,7 +2673,11 @@ static xnsysent_t __systab[] = {
 	[__pse51_mutex_lock] = {&__pthread_mutex_lock, __xn_exec_primary},
 	[__pse51_mutex_timedlock] =
 	    {&__pthread_mutex_timedlock, __xn_exec_primary},
+#ifndef XNARCH_HAVE_US_ATOMIC_CMPXCHG
 	[__pse51_mutex_trylock] = {&__pthread_mutex_trylock, __xn_exec_primary},
+#else
+        [__pse51_check_init] = {&__pthread_mutex_check_init, __xn_exec_any},
+#endif
 	[__pse51_mutex_unlock] = {&__pthread_mutex_unlock, __xn_exec_primary},
 	[__pse51_cond_init] = {&__pthread_cond_init, __xn_exec_any},
 	[__pse51_cond_destroy] = {&__pthread_cond_destroy, __xn_exec_any},
@@ -2477,7 +2760,6 @@ static void *pse51_eventcb(int event, vo
 
 	switch (event) {
 	case XNSHADOW_CLIENT_ATTACH:
-
 		q = (pse51_queues_t *) xnarch_alloc_host_mem(sizeof(*q));
 		if (!q)
 			return ERR_PTR(-ENOSPC);


-- 


					    Gilles.

