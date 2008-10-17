Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48F8B484.6090000@domain.hid>
Message-Id: <20081017154559.799152118@domain.hid>
Date: Fri, 17 Oct 2008 17:46:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
References: <20081017154559.420723261@domain.hid>
Subject: [Xenomai-core] [PATCH 02/13] Handle-based xeno_get_current service
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


To avoid sharing kernel object pointers with user space, a handle-based
approach is installed by this patch. It also reserves a few bits of the
handle value for special use (like the claimed bit of fast xnsynch).
Furthermore, the patch ensures that threads are registered at least
anonymously to allow them being used with fast xnsynch objects.

As a cleanup, the xeno_current_key creation is switched from a
pthread_once scheme to a constructor.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-generic/bits/bind.h    |   18 ++++++----
 include/asm-generic/bits/current.h |   10 ++++--
 include/nucleus/types.h            |   13 +++++++
 ksrc/nucleus/shadow.c              |   16 +++++++--
 ksrc/skins/native/Kconfig          |    1 
 ksrc/skins/native/task.c           |    8 +---
 ksrc/skins/posix/Kconfig           |    1 
 ksrc/skins/posix/cb_lock.h         |   15 ++++++---
 ksrc/skins/posix/cond.c            |   12 ++++---
 ksrc/skins/posix/mutex.c           |   21 +++++++-----
 ksrc/skins/posix/mutex.h           |   61 +++++++++++++++++++++++--------------
 ksrc/skins/posix/syscall.c         |   11 +++---
 ksrc/skins/posix/thread.c          |   12 +++++++
 ksrc/skins/psos+/Kconfig           |    2 -
 ksrc/skins/rtai/Kconfig            |    1 
 ksrc/skins/rtai/task.c             |   10 ++++++
 ksrc/skins/rtdm/drvlib.c           |    8 ++++
 ksrc/skins/uitron/Kconfig          |    1 
 ksrc/skins/uitron/task.c           |   11 ++++++
 ksrc/skins/vrtx/Kconfig            |    2 -
 ksrc/skins/vrtx/task.c             |   17 +++++++++-
 ksrc/skins/vxworks/Kconfig         |    2 -
 src/skins/posix/mutex.c            |   41 ++++++++++++------------
 23 files changed, 206 insertions(+), 88 deletions(-)

Index: b/include/asm-generic/bits/current.h
===================================================================
--- a/include/asm-generic/bits/current.h
+++ b/include/asm-generic/bits/current.h
@@ -2,14 +2,20 @@
 #define _XENO_ASM_GENERIC_CURRENT_H
 
 #include <pthread.h>
+#include <nucleus/types.h>
 
 extern pthread_key_t xeno_current_key;
 
 extern void xeno_set_current(void);
 
-static inline void *xeno_get_current(void)
+static inline xnhandle_t xeno_get_current(void)
 {
-	return pthread_getspecific(xeno_current_key);
+	void *val = pthread_getspecific(xeno_current_key);
+
+	if (!val)
+		return XN_NO_HANDLE;
+
+	return (xnhandle_t)val;
 }
 
 #endif /* _XENO_ASM_GENERIC_CURRENT_H */
Index: b/include/nucleus/types.h
===================================================================
--- a/include/nucleus/types.h
+++ b/include/nucleus/types.h
@@ -61,6 +61,19 @@ typedef unsigned long xnhandle_t;
 
 #define XN_NO_HANDLE ((xnhandle_t)0)
 
+#define XN_HANDLE_SPARE0	((xnhandle_t)0x10000000)
+#define XN_HANDLE_SPARE1	((xnhandle_t)0x20000000)
+#define XN_HANDLE_SPARE2	((xnhandle_t)0x40000000)
+#define XN_HANDLE_SPARE3	((xnhandle_t)0x80000000)
+#define XN_HANDLE_SPARE_MASK	((xnhandle_t)0xf0000000)
+
+#define xnhandle_mask_spare(handle)  ((handle) & ~XN_HANDLE_SPARE_MASK)
+#define xnhandle_test_spare(handle, bits)  (!!((handle) & (bits)))
+#define xnhandle_set_spare(handle, bits) \
+	do { (handle) |= (bits); } while (0)
+#define xnhandle_clear_spare(handle, bits) \
+	do { (handle) &= ~(bits); } while (0)
+
 struct xnintr;
 
 typedef int (*xnisr_t)(struct xnintr *intr);
Index: b/ksrc/nucleus/shadow.c
===================================================================
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -1908,13 +1908,21 @@ static int xnshadow_sys_sem_heap(struct
 	return __xn_safe_copy_to_user(us_hinfo, &hinfo, sizeof(*us_hinfo));
 }
 
+#ifdef CONFIG_XENO_OPT_REGISTRY
 static int xnshadow_sys_current(struct pt_regs *regs)
 {
-	xnthread_t * __user *us_current, *cur = xnshadow_thread(current);
-	us_current = (xnthread_t *__user *) __xn_reg_arg1(regs);
+	xnthread_t *cur = xnshadow_thread(current);
+	xnhandle_t __user *us_handle;
 
-	return __xn_safe_copy_to_user(us_current, &cur, sizeof(*us_current));
+	if (!cur)
+		return -EPERM;
+
+	us_handle = (xnhandle_t __user *) __xn_reg_arg1(regs);
+
+	return __xn_safe_copy_to_user(us_handle, &xnthread_handle(cur),
+				      sizeof(*us_handle));
 }
+#endif /* CONFIG_XENO_OPT_REGISTRY */
 
 static xnsysent_t __systab[] = {
 	[__xn_sys_migrate] = {&xnshadow_sys_migrate, __xn_exec_current},
@@ -1925,7 +1933,9 @@ static xnsysent_t __systab[] = {
 	[__xn_sys_barrier] = {&xnshadow_sys_barrier, __xn_exec_lostage},
 	[__xn_sys_trace] = {&xnshadow_sys_trace, __xn_exec_any},
 	[__xn_sys_sem_heap] = {&xnshadow_sys_sem_heap, __xn_exec_any},
+#ifdef CONFIG_XENO_OPT_REGISTRY
 	[__xn_sys_current] = {&xnshadow_sys_current, __xn_exec_any},
+#endif /* CONFIG_XENO_OPT_REGISTRY */
 };
 
 static void *xnshadow_sys_event(int event, void *data)
Index: b/ksrc/skins/posix/cb_lock.h
===================================================================
--- a/ksrc/skins/posix/cb_lock.h
+++ b/ksrc/skins/posix/cb_lock.h
@@ -3,15 +3,22 @@
 
 #include <asm/xenomai/atomic.h>
 #include <nucleus/compiler.h>
+#include <nucleus/types.h>
 
 #ifndef __KERNEL__
 typedef void xnthread_t;
 #endif /* __KERNEL__ */
 
-#define test_claimed(owner) ((long) (owner) & 1)
-#define clear_claimed(owner) ((xnthread_t *) ((long) (owner) & ~1))
-#define set_claimed(owner, bit) \
-        ((xnthread_t *) ((long) clear_claimed(owner) | !!(bit)))
+#define __CLAIMED_BIT		XN_HANDLE_SPARE3
+
+#define test_claimed(owner)	xnhandle_test_spare(owner, __CLAIMED_BIT)
+#define clear_claimed(owner)	xnhandle_mask_spare(owner)
+#define set_claimed(owner, bit) ({ \
+	xnhandle_t __tmp = xnhandle_mask_spare(owner); \
+	if (bit) \
+		xnhandle_set_spare(__tmp, __CLAIMED_BIT); \
+	__tmp; \
+})
 
 #ifdef CONFIG_XENO_FASTSEM
 
Index: b/ksrc/skins/posix/cond.c
===================================================================
--- a/ksrc/skins/posix/cond.c
+++ b/ksrc/skins/posix/cond.c
@@ -230,18 +230,20 @@ static inline int mutex_save_count(xnthr
 
 	mutex = shadow->mutex;
 
-	if (clear_claimed(xnarch_atomic_intptr_get(mutex->owner)) != cur)
+	if (clear_claimed(xnarch_atomic_get(mutex->owner)) !=
+	    xnthread_handle(cur))
 		return EPERM;
 
 	*count_ptr = shadow->lockcnt;
 
-	if (likely(xnarch_atomic_intptr_cmpxchg(mutex->owner, cur, NULL) == cur))
+	if (likely(xnarch_atomic_cmpxchg(mutex->owner, cur, XN_NO_HANDLE) ==
+		   xnthread_handle(cur)))
 		return 0;
 
 	owner = xnsynch_wakeup_one_sleeper(&mutex->synchbase);
-	xnarch_atomic_intptr_set
-		(mutex->owner,
-		 set_claimed(owner,xnsynch_nsleepers(&mutex->synchbase)));
+	xnarch_atomic_set(mutex->owner,
+			  set_claimed(xnthread_handle(owner),
+				      xnsynch_nsleepers(&mutex->synchbase)));
 
 	/* Do not reschedule here, releasing the mutex and suspension must be
 	   done atomically in pthread_cond_*wait. */
Index: b/ksrc/skins/posix/mutex.c
===================================================================
--- a/ksrc/skins/posix/mutex.c
+++ b/ksrc/skins/posix/mutex.c
@@ -82,7 +82,7 @@ int pse51_mutex_check_init(struct __shad
 
 int pse51_mutex_init_internal(struct __shadow_mutex *shadow,
 			      pse51_mutex_t *mutex,
-			      xnarch_atomic_intptr_t *ownerp,
+			      xnarch_atomic_t *ownerp,
 			      const pthread_mutexattr_t *attr)
 {
 	xnflags_t synch_flags = XNSYNCH_PRIO | XNSYNCH_NOPIP;
@@ -118,7 +118,7 @@ int pse51_mutex_init_internal(struct __s
 	mutex->owner = ownerp;
 	mutex->owningq = kq;
 	mutex->sleepers = 0;
-	xnarch_atomic_intptr_set(ownerp, NULL);
+	xnarch_atomic_set(ownerp, XN_NO_HANDLE);
 
 	xnlock_get_irqsave(&nklock, s);
 	appendq(&kq->mutexq, &mutex->link);
@@ -159,7 +159,7 @@ int pthread_mutex_init(pthread_mutex_t *
 	    &((union __xeno_mutex *)mx)->shadow_mutex;
 	DECLARE_CB_LOCK_FLAGS(s);
 	pse51_mutex_t *mutex;
-	xnarch_atomic_intptr_t *ownerp;
+	xnarch_atomic_t *ownerp;
 	int err;
 
 	if (!attr)
@@ -185,9 +185,9 @@ int pthread_mutex_init(pthread_mutex_t *
 	if (!mutex)
 		return ENOMEM;
 
-	ownerp = (xnarch_atomic_intptr_t *)
+	ownerp = (xnarch_atomic_t *)
 		xnheap_alloc(&xnsys_ppd_get(attr->pshared)->sem_heap,
-			     sizeof(xnarch_atomic_intptr_t));
+			     sizeof(xnarch_atomic_t));
 	if (!ownerp) {
 		xnfree(mutex);
 		return EAGAIN;
@@ -266,7 +266,7 @@ int pthread_mutex_destroy(pthread_mutex_
 		return EPERM;
 	}
 
-	if (xnarch_atomic_intptr_get(mutex->owner)) {
+	if (xnarch_atomic_get(mutex->owner) != XN_NO_HANDLE) {
 		cb_write_unlock(&shadow->lock, s);
 		return EBUSY;
 	}
@@ -290,6 +290,10 @@ int pse51_mutex_timedlock_break(struct _
 	spl_t s;
 	int err;
 
+	/* We need a valid thread handle for the fast lock. */
+	if (xnthread_handle(cur) == XN_NO_HANDLE)
+		return -EPERM;
+
 	err = pse51_mutex_timedlock_internal(cur, shadow, 1, timed, abs_to);
 	if (err != -EBUSY)
 		goto unlock_and_return;
@@ -392,7 +396,7 @@ int pthread_mutex_trylock(pthread_mutex_
 		return -PTR_ERR(owner);
 
 	err = EBUSY;
-	if (clear_claimed(owner) == cur) {
+	if (owner == cur) {
 		pse51_mutex_t *mutex = shadow->mutex;
 
 		if (mutex->attr.type == PTHREAD_MUTEX_RECURSIVE) {
@@ -573,7 +577,8 @@ int pthread_mutex_unlock(pthread_mutex_t
 
 	mutex = shadow->mutex;
 	
-	if (clear_claimed(xnarch_atomic_intptr_get(mutex->owner)) != cur) {
+	if (clear_claimed(xnarch_atomic_get(mutex->owner)) !=
+	    xnthread_handle(cur)) {
 		err = EPERM;
 		goto out;
 	}
Index: b/ksrc/skins/posix/mutex.h
===================================================================
--- a/ksrc/skins/posix/mutex.h
+++ b/ksrc/skins/posix/mutex.h
@@ -34,7 +34,7 @@ union __xeno_mutex {
 		xnarch_atomic_t lock;
 		union {
 			unsigned owner_offset;
-			xnarch_atomic_intptr_t *owner;
+			xnarch_atomic_t *owner;
 		};
 		struct pse51_mutexattr attr;
 #endif /* CONFIG_XENO_FASTSEM */
@@ -54,7 +54,7 @@ typedef struct pse51_mutex {
 #define link2mutex(laddr)                                               \
 	((pse51_mutex_t *)(((char *)laddr) - offsetof(pse51_mutex_t, link)))
 
-	xnarch_atomic_intptr_t *owner;
+	xnarch_atomic_t *owner;
 	pthread_mutexattr_t attr;
 	unsigned sleepers;
 	pse51_kqueues_t *owningq;
@@ -77,7 +77,7 @@ int pse51_mutex_check_init(struct __shad
 
 int pse51_mutex_init_internal(struct __shadow_mutex *shadow,
 			      pse51_mutex_t *mutex,
-			      xnarch_atomic_intptr_t *ownerp,
+			      xnarch_atomic_t *ownerp,
 			      const pthread_mutexattr_t *attr);
 
 void pse51_mutex_destroy_internal(pse51_mutex_t *mutex,
@@ -88,6 +88,7 @@ pse51_mutex_trylock_internal(xnthread_t
 			     struct __shadow_mutex *shadow, unsigned count)
 {
 	pse51_mutex_t *mutex = shadow->mutex;
+	xnhandle_t ownerh;
 	xnthread_t *owner;
 
 	if (xnpod_unblockable_p())
@@ -101,9 +102,14 @@ pse51_mutex_trylock_internal(xnthread_t
 		return ERR_PTR(-EPERM);
 #endif /* XENO_DEBUG(POSIX) */
 
-	owner = xnarch_atomic_intptr_cmpxchg(mutex->owner, NULL, cur);
-	if (unlikely(owner != NULL))
+	ownerh = xnarch_atomic_cmpxchg(mutex->owner, XN_NO_HANDLE,
+				       xnthread_handle(cur));
+	if (unlikely(ownerh != XN_NO_HANDLE)) {
+		owner = xnthread_lookup(clear_claimed(ownerh));
+		if (!owner)
+			return ERR_PTR(-EINVAL);
 		return owner;
+	}
 
 	shadow->lockcnt = count;
 	return NULL;
@@ -118,7 +124,8 @@ static inline int pse51_mutex_timedlock_
 
 {
 	pse51_mutex_t *mutex;
-	xnthread_t *owner, *old;
+	xnthread_t *owner;
+	xnhandle_t ownerh, old;
 	spl_t s;
 	int err;
 
@@ -128,32 +135,39 @@ static inline int pse51_mutex_timedlock_
 		return PTR_ERR(owner);
 
 	mutex = shadow->mutex;
-	if (clear_claimed(owner) == cur)
+	if (owner == cur)
 		return -EBUSY;
 
 	/* Set bit 0, so that mutex_unlock will know that the mutex is claimed.
 	   Hold the nklock, for mutual exclusion with slow mutex_unlock. */
 	xnlock_get_irqsave(&nklock, s);
-	if (test_claimed(owner)) {
-		old = xnarch_atomic_intptr_get(mutex->owner);
+	if (test_claimed(ownerh)) {
+		old = xnarch_atomic_get(mutex->owner);
 		goto test_no_owner;
 	}
 	do {
-		old = xnarch_atomic_intptr_cmpxchg(mutex->owner,
-						   owner, set_claimed(owner, 1));
-		if (likely(old == owner))
+		old = xnarch_atomic_cmpxchg(mutex->owner, ownerh,
+					    set_claimed(ownerh, 1));
+		if (likely(old == ownerh))
 			break;
 	  test_no_owner:
-		if (old == NULL) {
+		if (old == XN_NO_HANDLE) {
 			/* Owner called fast mutex_unlock
 			   (on another cpu) */
 			xnlock_put_irqrestore(&nklock, s);
 			goto retry_lock;
 		}
-		owner = old;
-	} while (!test_claimed(owner));
+		ownerh = old;
+	} while (!test_claimed(ownerh));
+
+	owner = xnthread_lookup(clear_claimed(ownerh));
+
+	if (unlikely(!owner)) {
+		err = -EINVAL;
+		goto error;
+	}
 
-	xnsynch_set_owner(&mutex->synchbase, clear_claimed(owner));
+	xnsynch_set_owner(&mutex->synchbase, owner);
 	++mutex->sleepers;
 	if (timed)
 		xnsynch_sleep_on(&mutex->synchbase, abs_to, XN_REALTIME);
@@ -174,7 +188,8 @@ static inline int pse51_mutex_timedlock_
 		goto error;
 	}
 
-	xnarch_atomic_intptr_set(mutex->owner,set_claimed(cur, mutex->sleepers));
+	ownerh = set_claimed(xnthread_handle(cur), mutex->sleepers);
+	xnarch_atomic_set(mutex->owner, ownerh);
 	shadow->lockcnt = count;
 	xnlock_put_irqrestore(&nklock, s);
 
@@ -182,9 +197,9 @@ static inline int pse51_mutex_timedlock_
 
   error:
 	if (!mutex->sleepers)
-		xnarch_atomic_intptr_set
+		xnarch_atomic_set
 			(mutex->owner,
-			 clear_claimed(xnarch_atomic_intptr_get(mutex->owner)));
+			 clear_claimed(xnarch_atomic_get(mutex->owner)));
 	xnlock_put_irqrestore(&nklock, s);
 	return err;
 }
@@ -192,16 +207,18 @@ static inline int pse51_mutex_timedlock_
 static inline void pse51_mutex_unlock_internal(xnthread_t *cur,
 					       pse51_mutex_t *mutex)
 {
+	xnhandle_t ownerh;
 	xnthread_t *owner;
 	spl_t s;
 
-	if (likely(xnarch_atomic_intptr_cmpxchg(mutex->owner, cur, NULL) == cur))
+	if (likely(xnarch_atomic_cmpxchg(mutex->owner, cur, XN_NO_HANDLE) ==
+		   xnthread_handle(cur)))
 		return;
 
 	xnlock_get_irqsave(&nklock, s);
 	owner = xnsynch_wakeup_one_sleeper(&mutex->synchbase);
-	xnarch_atomic_intptr_set(mutex->owner,
-				 set_claimed(owner, mutex->sleepers));
+	ownerh = set_claimed(xnthread_handle(owner), mutex->sleepers);
+	xnarch_atomic_set(mutex->owner, ownerh);
 	if (owner)
 		xnpod_schedule();
 	xnlock_put_irqrestore(&nklock, s);
Index: b/ksrc/skins/posix/syscall.c
===================================================================
--- a/ksrc/skins/posix/syscall.c
+++ b/ksrc/skins/posix/syscall.c
@@ -1060,7 +1060,8 @@ static int __pthread_mutex_unlock(struct
 
 	mutex = shadow->mutex;
 
-	if (clear_claimed(xnarch_atomic_intptr_get(mutex->owner)) != cur) {
+	if (clear_claimed(xnarch_atomic_get(mutex->owner)) !=
+	    xnthread_handle(cur)) {
 		err = -EPERM;
 		goto out;
 	}
@@ -1119,7 +1120,7 @@ static int __pthread_mutex_init(struct p
 	pthread_mutexattr_t locattr, *attr, *uattrp;
 	union __xeno_mutex mx, *umx;
 	pse51_mutex_t *mutex;
-	xnarch_atomic_intptr_t *ownerp;
+	xnarch_atomic_t *ownerp;
 	int err;
 
 	umx = (union __xeno_mutex *)__xn_reg_arg1(regs);
@@ -1144,9 +1145,9 @@ static int __pthread_mutex_init(struct p
 	if (!mutex)
 		return -ENOMEM;
 
-	ownerp = (xnarch_atomic_intptr_t *)
+	ownerp = (xnarch_atomic_t *)
 		xnheap_alloc(&xnsys_ppd_get(attr->pshared)->sem_heap,
-			     sizeof(xnarch_atomic_intptr_t));
+			     sizeof(xnarch_atomic_t));
 	if (!ownerp) {
 		xnfree(mutex);
 		return -EAGAIN;
@@ -1185,7 +1186,7 @@ static int __pthread_mutex_destroy(struc
 	if (pse51_kqueues(mutex->attr.pshared) != mutex->owningq)
 		return -EPERM;
 
-	if (xnarch_atomic_intptr_get(mutex->owner))
+	if (xnarch_atomic_get(mutex->owner) != XN_NO_HANDLE)
 		return -EBUSY;
 
 	pse51_mark_deleted(shadow);
Index: b/src/skins/posix/mutex.c
===================================================================
--- a/src/skins/posix/mutex.c
+++ b/src/skins/posix/mutex.c
@@ -31,12 +31,12 @@ extern int __pse51_muxid;
 
 extern unsigned long xeno_sem_heap[2];
 
-static xnarch_atomic_intptr_t *get_ownerp(struct __shadow_mutex *shadow)
+static xnarch_atomic_t *get_ownerp(struct __shadow_mutex *shadow)
 {
 	if (likely(!shadow->attr.pshared))
 		return shadow->owner;
 	
-	return (xnarch_atomic_intptr_t *) (xeno_sem_heap[1] + shadow->owner_offset);
+	return (xnarch_atomic_t *) (xeno_sem_heap[1] + shadow->owner_offset);
 }
 #endif /* CONFIG_XENO_FASTSEM */
 
@@ -117,7 +117,7 @@ int __wrap_pthread_mutex_init(pthread_mu
 
 #ifdef CONFIG_XENO_FASTSEM
 	if (!shadow->attr.pshared)
-		shadow->owner = (xnarch_atomic_intptr_t *)
+		shadow->owner = (xnarch_atomic_t *)
 			(xeno_sem_heap[0] + shadow->owner_offset);
 	
 	cb_write_unlock(&shadow->lock, s);
@@ -149,10 +149,10 @@ int __wrap_pthread_mutex_lock(pthread_mu
 	int err = 0;
 
 #ifdef CONFIG_XENO_FASTSEM
-	xnthread_t *cur, *owner;
+	xnhandle_t cur, owner;
 
 	cur = xeno_get_current();
-	if (!cur)
+	if (cur == XN_NO_HANDLE)
 		return EPERM;
 
 	if (unlikely(cb_try_read_lock(&shadow->lock, s)))
@@ -163,8 +163,8 @@ int __wrap_pthread_mutex_lock(pthread_mu
 		goto out;
 	}
 
-	owner = xnarch_atomic_intptr_cmpxchg(get_ownerp(shadow), NULL, cur);
-	if (likely(!owner)) {
+	owner = xnarch_atomic_cmpxchg(get_ownerp(shadow), XN_NO_HANDLE, cur);
+	if (likely(owner == XN_NO_HANDLE)) {
 		shadow->lockcnt = 1;
 		cb_read_unlock(&shadow->lock, s);
 		return 0;
@@ -210,10 +210,10 @@ int __wrap_pthread_mutex_timedlock(pthre
 	int err = 0;
 
 #ifdef CONFIG_XENO_FASTSEM
-	xnthread_t *cur, *owner;
+	xnhandle_t cur, owner;
 
 	cur = xeno_get_current();
-	if (!cur)
+	if (cur == XN_NO_HANDLE)
 		return EPERM;
 
 	if (unlikely(cb_try_read_lock(&shadow->lock, s)))
@@ -224,8 +224,8 @@ int __wrap_pthread_mutex_timedlock(pthre
 		goto out;
 	}	
 
-	owner = xnarch_atomic_intptr_cmpxchg(get_ownerp(shadow), NULL, cur);
-	if (likely(!owner)) {
+	owner = xnarch_atomic_cmpxchg(get_ownerp(shadow), XN_NO_HANDLE, cur);
+	if (likely(owner == XN_NO_HANDLE)) {
 		shadow->lockcnt = 1;
 		cb_read_unlock(&shadow->lock, s);
 		return 0;
@@ -271,10 +271,10 @@ int __wrap_pthread_mutex_trylock(pthread
 	int err = 0;
 
 #ifdef CONFIG_XENO_FASTSEM
-	xnthread_t *cur, *owner;
+	xnhandle_t cur, owner;
 
 	cur = xeno_get_current();
-	if (!cur)
+	if (cur == XN_NO_HANDLE)
 		return EPERM;
 
 	if (unlikely(cb_try_read_lock(&shadow->lock, s)))
@@ -285,8 +285,8 @@ int __wrap_pthread_mutex_trylock(pthread
 		goto out;
 	}	
 
-	owner = xnarch_atomic_intptr_cmpxchg(get_ownerp(shadow), NULL, cur);
-	if (likely(!owner)) {
+	owner = xnarch_atomic_cmpxchg(get_ownerp(shadow), XN_NO_HANDLE, cur);
+	if (likely(owner == XN_NO_HANDLE)) {
 		shadow->lockcnt = 1;
 		cb_read_unlock(&shadow->lock, s);
 		return 0;
@@ -325,11 +325,11 @@ int __wrap_pthread_mutex_unlock(pthread_
 	int err = 0;
 
 #ifdef CONFIG_XENO_FASTSEM
-	xnarch_atomic_intptr_t *ownerp;
-	xnthread_t *cur;
+	xnarch_atomic_t *ownerp;
+	xnhandle_t cur, owner;
 
 	cur = xeno_get_current();
-	if (!cur)
+	if (cur == XN_NO_HANDLE)
 		return EPERM;
 
 	if (unlikely(cb_try_read_lock(&shadow->lock, s)))
@@ -341,7 +341,8 @@ int __wrap_pthread_mutex_unlock(pthread_
 	}
 
 	ownerp = get_ownerp(shadow);
-	if (unlikely(clear_claimed(xnarch_atomic_intptr_get(ownerp)) != cur)) {
+	owner = clear_claimed(xnarch_atomic_get(ownerp));
+	if (unlikely(owner != cur)) {
 		err = -EPERM;
 		goto out_err;
 	}
@@ -352,7 +353,7 @@ int __wrap_pthread_mutex_unlock(pthread_
 		goto out;
 	}
 
-	if (likely(xnarch_atomic_intptr_cmpxchg(ownerp, cur, NULL) == cur)) {
+	if (likely(xnarch_atomic_cmpxchg(ownerp, cur, XN_NO_HANDLE) == cur)) {
 	  out:
 		cb_read_unlock(&shadow->lock, s);
 		return 0;
Index: b/ksrc/skins/posix/thread.c
===================================================================
--- a/ksrc/skins/posix/thread.c
+++ b/ksrc/skins/posix/thread.c
@@ -234,6 +234,18 @@ int pthread_create(pthread_t *tid,
 	thread->hkey.mm = NULL;
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
+#ifdef CONFIG_XENO_FASTSEM
+	/* We need an anonymous registry entry to obtain a handle for fast
+	   mutex locking. */
+	{
+		int err = xnthread_register(&thread->threadbase, "");
+		if (err) {
+			thread_destroy(thread);
+			return err;
+		}
+	}
+#endif /* CONFIG_XENO_FASTSEM */
+
 	*tid = thread;		/* Must be done before the thread is started. */
 
 	if (start)		/* Do not start shadow threads (i.e. start == NULL). */
Index: b/ksrc/skins/posix/Kconfig
===================================================================
--- a/ksrc/skins/posix/Kconfig
+++ b/ksrc/skins/posix/Kconfig
@@ -1,5 +1,6 @@
 menuconfig XENO_SKIN_POSIX
 	depends on XENO_OPT_NUCLEUS 
+	select XENO_OPT_REGISTRY if XENO_FASTSEM
 	tristate "POSIX API"
 	default y
 	help
Index: b/include/asm-generic/bits/bind.h
===================================================================
--- a/include/asm-generic/bits/bind.h
+++ b/include/asm-generic/bits/bind.h
@@ -15,18 +15,24 @@
 
 __attribute__ ((weak))
 pthread_key_t xeno_current_key;
-__attribute__ ((weak))
-pthread_once_t xeno_init_current_key_once = PTHREAD_ONCE_INIT;
 
 __attribute__ ((weak))
 void xeno_set_current(void)
 {
 	void *kthread_cb;
-	XENOMAI_SYSCALL1(__xn_sys_current, &kthread_cb);
+	int err;
+
+	err = XENOMAI_SYSCALL1(__xn_sys_current, &kthread_cb);
+	if (err) {
+		fprintf(stderr, "Xenomai: error obtaining handle for current "
+			"thread: %s\n", strerror(err));
+		exit(1);
+	}
 	pthread_setspecific(xeno_current_key, kthread_cb);
 }
 
-static void init_current_key(void)
+static __attribute__ ((constructor))
+void init_current_key(void)
 {
 	int err = pthread_key_create(&xeno_current_key, NULL);
 	if (err) {
@@ -168,8 +174,6 @@ xeno_bind_skin(unsigned skin_magic, cons
 	sa.sa_flags = 0;
 	sigaction(SIGXCPU, &sa, NULL);
 
-	pthread_once(&xeno_init_current_key_once, &init_current_key);
-
 #ifdef CONFIG_XENO_FASTSEM
 	/* In case we forked, we need to map the new local semaphore heap */
 	if (xeno_sem_heap[0])
@@ -244,8 +248,6 @@ xeno_bind_skin_opt(unsigned skin_magic,
 	xeno_arch_features_check();
 #endif /* xeno_arch_features_check */
 
-	pthread_once(&xeno_init_current_key_once, &init_current_key);
-
 #ifdef CONFIG_XENO_FASTSEM
 	/* In case we forked, we need to map the new local semaphore heap */
 	if (xeno_sem_heap[0])
Index: b/ksrc/skins/native/Kconfig
===================================================================
--- a/ksrc/skins/native/Kconfig
+++ b/ksrc/skins/native/Kconfig
@@ -1,5 +1,6 @@
 menuconfig XENO_SKIN_NATIVE
 	depends on XENO_OPT_NUCLEUS
+	select XENO_OPT_REGISTRY if XENO_FASTSEM
 	tristate "Native API"
 	default y
 	help
Index: b/ksrc/skins/native/task.c
===================================================================
--- a/ksrc/skins/native/task.c
+++ b/ksrc/skins/native/task.c
@@ -283,11 +283,9 @@ int rt_task_create(RT_TASK *task,
 	   complete objects, so that the registry cannot return handles to
 	   half-baked objects... */
 
-	if (name) {
-		err = xnthread_register(&task->thread_base, task->rname);
-		if (err)
-			xnpod_delete_thread(&task->thread_base);
-	}
+	err = xnthread_register(&task->thread_base, name ? task->rname : "");
+	if (err)
+		xnpod_delete_thread(&task->thread_base);
 
 	return err;
 }
Index: b/ksrc/skins/psos+/Kconfig
===================================================================
--- a/ksrc/skins/psos+/Kconfig
+++ b/ksrc/skins/psos+/Kconfig
@@ -2,7 +2,7 @@ menuconfig XENO_SKIN_PSOS
 	depends on XENO_OPT_NUCLEUS
 	select XENO_OPT_TIMING_PERIODIC
 	tristate "pSOS+ emulator"
-	select XENO_OPT_REGISTRY if XENO_OPT_PERVASIVE
+	select XENO_OPT_REGISTRY if XENO_OPT_PERVASIVE || XENO_FASTSEM
 	help
 
 	This API skin emulates WindRiver's pSOS+ operating system.
Index: b/ksrc/skins/uitron/Kconfig
===================================================================
--- a/ksrc/skins/uitron/Kconfig
+++ b/ksrc/skins/uitron/Kconfig
@@ -2,6 +2,7 @@ menuconfig XENO_SKIN_UITRON
 	depends on XENO_OPT_NUCLEUS
 	select XENO_OPT_TIMING_PERIODIC
 	select XENO_OPT_MAP
+	select XENO_OPT_REGISTRY if XENO_FASTSEM
 	tristate "uITRON API"
 	help
 
Index: b/ksrc/skins/uitron/task.c
===================================================================
--- a/ksrc/skins/uitron/task.c
+++ b/ksrc/skins/uitron/task.c
@@ -16,7 +16,6 @@
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-#include <nucleus/registry.h>
 #include <nucleus/pod.h>
 #include <nucleus/heap.h>
 #include <uitron/task.h>
@@ -151,6 +150,16 @@ ER cre_tsk(ID tskid, T_CTSK *pk_ctsk)
 	xnlock_put_irqrestore(&nklock, s);
 	task->magic = uITRON_TASK_MAGIC;
 
+#ifdef CONFIG_XENO_FASTSEM
+	/* We need an anonymous registry entry to obtain a handle for fast
+	   mutex locking. */
+	if (xnthread_register(&task->threadbase, "")) {
+		xnmap_remove(ui_task_idmap, tskid);
+		xnpod_abort_thread(&task->threadbase);
+		return E_NOMEM;
+	}
+#endif /* CONFIG_XENO_FASTSEM */
+
 	return E_OK;
 }
 
Index: b/ksrc/skins/rtai/Kconfig
===================================================================
--- a/ksrc/skins/rtai/Kconfig
+++ b/ksrc/skins/rtai/Kconfig
@@ -1,5 +1,6 @@
 menuconfig XENO_SKIN_RTAI
 	depends on XENO_OPT_NUCLEUS
+	select XENO_OPT_REGISTRY if XENO_FASTSEM
 	tristate "RTAI emulator"
 	help
 
Index: b/ksrc/skins/rtai/task.c
===================================================================
--- a/ksrc/skins/rtai/task.c
+++ b/ksrc/skins/rtai/task.c
@@ -152,6 +152,16 @@ int rt_task_init(RT_TASK *task,
 	task->magic = RTAI_TASK_MAGIC;
 	appendq(&__rtai_task_q, &task->link);
 
+#ifdef CONFIG_XENO_FASTSEM
+	/* We need an anonymous registry entry to obtain a handle for fast
+	   mutex locking. */
+	err = xnthread_register(&task->thread_base, "");
+	if (err) {
+		xnpod_abort_thread(&task->thread_base);
+		goto unlock_and_exit;
+	}
+#endif /* CONFIG_XENO_FASTSEM */
+
 	/* Add a switch hook only if a signal function has been declared
 	   at least once for some created task. */
 
Index: b/ksrc/skins/vrtx/Kconfig
===================================================================
--- a/ksrc/skins/vrtx/Kconfig
+++ b/ksrc/skins/vrtx/Kconfig
@@ -3,7 +3,7 @@ menuconfig XENO_SKIN_VRTX
 	select XENO_OPT_TIMING_PERIODIC
 	select XENO_OPT_MAP
 	tristate "VRTX emulator"
-	select XENO_OPT_REGISTRY if XENO_OPT_PERVASIVE
+	select XENO_OPT_REGISTRY if XENO_OPT_PERVASIVE || CONFIG_XENO_FASTSEM
 	help
 
 	This API skin emulates Mentor Graphics's VRTX operating
Index: b/ksrc/skins/vrtx/task.c
===================================================================
--- a/ksrc/skins/vrtx/task.c
+++ b/ksrc/skins/vrtx/task.c
@@ -188,12 +188,25 @@ int sc_tecreate_inner(vrtxtask_t *task,
 	if (mode & 0x10)
 		bmode |= XNRRB;
 
-	*errp = RET_OK;
-
 	xnlock_get_irqsave(&nklock, s);
 	appendq(&vrtx_task_q, &task->link);
 	xnlock_put_irqrestore(&nklock, s);
 
+#ifdef CONFIG_XENO_FASTSEM
+	/* We need an anonymous registry entry to obtain a handle for fast
+	   mutex locking. */
+	{
+		int err = xnthread_register(&task->threadbase, "");
+		if (err) {
+			xnpod_abort_thread(&task->threadbase);
+			*errp = ER_MEM;
+			return -1;
+		}
+	}
+#endif /* CONFIG_XENO_FASTSEM */
+
+	*errp = RET_OK;
+
 	xnpod_start_thread(&task->threadbase,
 			   bmode, 0, XNPOD_ALL_CPUS, &vrtxtask_trampoline,
 			   task);
Index: b/ksrc/skins/vxworks/Kconfig
===================================================================
--- a/ksrc/skins/vxworks/Kconfig
+++ b/ksrc/skins/vxworks/Kconfig
@@ -2,7 +2,7 @@ menuconfig XENO_SKIN_VXWORKS
 	depends on XENO_OPT_NUCLEUS
 	select XENO_OPT_TIMING_PERIODIC
 	tristate "VxWorks emulator"
-	select XENO_OPT_REGISTRY if XENO_OPT_PERVASIVE
+	select XENO_OPT_REGISTRY if XENO_OPT_PERVASIVE || XENO_FASTSEM
 	help
 
 	This API skin emulates WindRiver's VxWorks operating system.
Index: b/ksrc/skins/rtdm/drvlib.c
===================================================================
--- a/ksrc/skins/rtdm/drvlib.c
+++ b/ksrc/skins/rtdm/drvlib.c
@@ -145,6 +145,14 @@ int rtdm_task_init(rtdm_task_t *task, co
 	if (err)
 		return err;
 
+#ifdef CONFIG_XENO_FASTSEM
+	/* We need an anonymous registry entry to obtain a handle for fast
+	   mutex locking. */
+	err = xnthread_register(task, "");
+	if (err)
+		goto cleanup_out;
+#endif /* CONFIG_XENO_FASTSEM */
+
 	if (period > 0) {
 		err = xnpod_set_thread_periodic(task, XN_INFINITE,
 						xntbase_ns2ticks_ceil


