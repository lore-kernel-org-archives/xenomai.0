Message-ID: <48D75DE5.9020805@domain.hid>
Date: Mon, 22 Sep 2008 10:57:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48CE7BD7.6060504@domain.hid>
	<48D620DB.2070101@domain.hid>	<48D688EE.7010404@domain.hid>
	<48D68D6D.9070909@domain.hid> <48D69A7A.7090302@domain.hid>
	<48D752BA.3000403@domain.hid> <48D754D8.30205@domain.hid>
In-Reply-To: <48D754D8.30205@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH] Factor out xnsynch_acquire/release
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>
>>>> [1]http://thread.gmane.org/gmane.linux.real-time.xenomai.devel/5412/focus=5405
>>>>
>>> always-put-xnthread-base-into-registry.patch:
>>> 	I understand the need, but I will cowardly let Philippe decide whether
>>> he likes the implementation details.
>>>
>>> handle-base-xn_sys_current-1.patch:
>>> 	In some places (pse51_mutex_timedlock_inner for instances) you use
>>> XN_NO_HANDLE, in others (pse51_mutex_timedlock for instances) you use
>>> NULL, are the two equivalents ? If yes, should not we always use the
>>> same consistently ? Otherwise looks ok.
>> I fail to find the NULL spots - which pse51_mutex_timedlock do you mean?
> 
> A few excerpts:
> 
> @@ -101,9 +103,14 @@ pse51_mutex_trylock_internal(xnthread_t
>  		return ERR_PTR(-EPERM);
>  #endif /* XENO_DEBUG(POSIX) */
> 
> -	owner = xnarch_atomic_intptr_cmpxchg(mutex->owner, NULL, cur);
> -	if (unlikely(owner != NULL))
> +	ownerh = xnarch_atomic_cmpxchg(mutex->owner, XN_NO_HANDLE,
> +				       xnthread_handle(cur));
> +	if (unlikely(ownerh)) {
> +		owner = xnregistry_fetch(clear_claimed(ownerh));
> +		if (!owner)
> +			return ERR_PTR(-EINVAL);
>  		return owner;
> +	}
> 
>  	shadow->lockcnt = count;
>  	return NULL;
> 
> 
> @@ -128,32 +136,41 @@ static inline int pse51_mutex_timedlock_
> (...)
> -		old = xnarch_atomic_intptr_cmpxchg(mutex->owner,
> -						   owner, set_claimed(owner, 1));
> -		if (likely(old == owner))
> +		old = xnarch_atomic_cmpxchg(mutex->owner, ownerh,
> +					    set_claimed(ownerh, 1));
> +		if (likely(old == ownerh))
>  			break;
>  	  test_no_owner:
> -		if (old == NULL) {
> +		if (!old) {
>  			/* Owner called fast mutex_unlock
>  			   (on another cpu) */
>  			xnlock_put_irqrestore(&nklock, s);
> 
> @@ -163,7 +163,7 @@ int __wrap_pthread_mutex_lock(pthread_mu
>  		goto out;
>  	}
> 
> -	owner = xnarch_atomic_intptr_cmpxchg(get_ownerp(shadow), NULL, cur);
> +	owner = xnarch_atomic_cmpxchg(get_ownerp(shadow), XN_NO_HANDLE, cur);
>  	if (likely(!owner)) {
>  		shadow->lockcnt = 1;
>  		cb_read_unlock(&shadow->lock, s);
> 
> 
> @@ -210,7 +210,7 @@ int __wrap_pthread_mutex_timedlock(pthre
>  	int err = 0;
> 
>  #ifdef CONFIG_XENO_FASTSEM
> -	xnthread_t *cur, *owner;
> +	xnhandle_t cur, owner;
> 
>  	cur = xeno_get_current();
>  	if (!cur)
> 
> 
> 
> @@ -224,7 +224,7 @@ int __wrap_pthread_mutex_timedlock(pthre
>  		goto out;
>  	}	
> 
> -	owner = xnarch_atomic_intptr_cmpxchg(get_ownerp(shadow), NULL, cur);
> +	owner = xnarch_atomic_cmpxchg(get_ownerp(shadow), XN_NO_HANDLE, cur);
>  	if (likely(!owner)) {
>  		shadow->lockcnt = 1;
>  		cb_read_unlock(&shadow->lock, s);
> 
> @@ -271,7 +271,7 @@ int __wrap_pthread_mutex_trylock(pthread
>  	int err = 0;
> 
>  #ifdef CONFIG_XENO_FASTSEM
> -	xnthread_t *cur, *owner;
> +	xnhandle_t cur, owner;
> 
>  	cur = xeno_get_current();
>  	if (!cur)
> 
> @@ -285,7 +285,7 @@ int __wrap_pthread_mutex_trylock(pthread
>  		goto out;
>  	}	
> 
> -	owner = xnarch_atomic_intptr_cmpxchg(get_ownerp(shadow), NULL, cur);
> +	owner = xnarch_atomic_cmpxchg(get_ownerp(shadow), XN_NO_HANDLE, cur);
>  	if (likely(!owner)) {
>  		shadow->lockcnt = 1;
>  		cb_read_unlock(&shadow->lock, s);
> 
> @@ -325,8 +325,8 @@ int __wrap_pthread_mutex_unlock(pthread_
>  	int err = 0;
> 
>  #ifdef CONFIG_XENO_FASTSEM
> -	xnarch_atomic_intptr_t *ownerp;
> -	xnthread_t *cur;
> +	xnarch_atomic_t *ownerp;
> +	xnhandle_t cur, owner;
> 
>  	cur = xeno_get_current();
>  	if (!cur)
> 

Ah, you mean checking against non-zero - that can be changed of course.
Updated patch below, hope I caught them all.

Jan

---
 include/asm-generic/bits/bind.h    |    9 ++++-
 include/asm-generic/bits/current.h |    5 +-
 include/nucleus/types.h            |   13 +++++++
 ksrc/nucleus/shadow.c              |   17 ++++++++-
 ksrc/skins/native/Kconfig          |    1 
 ksrc/skins/native/task.c           |   14 +++-----
 ksrc/skins/posix/Kconfig           |    1 
 ksrc/skins/posix/cb_lock.h         |   15 ++++++--
 ksrc/skins/posix/cond.c            |   12 ++++--
 ksrc/skins/posix/mutex.c           |   21 +++++++-----
 ksrc/skins/posix/mutex.h           |   64 ++++++++++++++++++++++++-------------
 ksrc/skins/posix/syscall.c         |   11 +++---
 ksrc/skins/posix/thread.c          |   16 +++++++++
 ksrc/skins/psos+/Kconfig           |    2 -
 ksrc/skins/rtai/Kconfig            |    1 
 ksrc/skins/rtai/task.c             |   12 ++++++
 ksrc/skins/uitron/Kconfig          |    1 
 ksrc/skins/uitron/task.c           |   11 ++++++
 ksrc/skins/vrtx/Kconfig            |    2 -
 ksrc/skins/vrtx/task.c             |   20 ++++++++++-
 ksrc/skins/vxworks/Kconfig         |    2 -
 src/skins/posix/mutex.c            |   41 ++++++++++++-----------
 22 files changed, 208 insertions(+), 83 deletions(-)

Index: b/include/asm-generic/bits/current.h
===================================================================
--- a/include/asm-generic/bits/current.h
+++ b/include/asm-generic/bits/current.h
@@ -2,14 +2,15 @@
 #define _XENO_ASM_GENERIC_CURRENT_H
 
 #include <pthread.h>
+#include <nucleus/types.h>
 
 extern pthread_key_t xeno_current_key;
 
 extern void xeno_set_current(void);
 
-static inline void *xeno_get_current(void)
+static inline xnhandle_t xeno_get_current(void)
 {
-	return pthread_getspecific(xeno_current_key);
+	return (xnhandle_t)pthread_getspecific(xeno_current_key);
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
@@ -52,6 +52,7 @@
 #include <nucleus/trace.h>
 #include <nucleus/stat.h>
 #include <nucleus/sys_ppd.h>
+#include <nucleus/registry.h>
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/syscall.h>
 #include <asm/xenomai/bits/shadow.h>
@@ -1908,13 +1909,21 @@ static int xnshadow_sys_sem_heap(struct
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
@@ -1925,7 +1934,9 @@ static xnsysent_t __systab[] = {
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
@@ -43,6 +43,7 @@ union __xeno_mutex {
 
 #ifdef __KERNEL__
 
+#include <nucleus/registry.h>
 #include <posix/internal.h>
 #include <posix/thread.h>
 #include <posix/cb_lock.h>
@@ -54,7 +55,7 @@ typedef struct pse51_mutex {
 #define link2mutex(laddr)                                               \
 	((pse51_mutex_t *)(((char *)laddr) - offsetof(pse51_mutex_t, link)))
 
-	xnarch_atomic_intptr_t *owner;
+	xnarch_atomic_t *owner;
 	pthread_mutexattr_t attr;
 	unsigned sleepers;
 	pse51_kqueues_t *owningq;
@@ -77,7 +78,7 @@ int pse51_mutex_check_init(struct __shad
 
 int pse51_mutex_init_internal(struct __shadow_mutex *shadow,
 			      pse51_mutex_t *mutex,
-			      xnarch_atomic_intptr_t *ownerp,
+			      xnarch_atomic_t *ownerp,
 			      const pthread_mutexattr_t *attr);
 
 void pse51_mutex_destroy_internal(pse51_mutex_t *mutex,
@@ -88,6 +89,7 @@ pse51_mutex_trylock_internal(xnthread_t
 			     struct __shadow_mutex *shadow, unsigned count)
 {
 	pse51_mutex_t *mutex = shadow->mutex;
+	xnhandle_t ownerh;
 	xnthread_t *owner;
 
 	if (xnpod_unblockable_p())
@@ -101,9 +103,14 @@ pse51_mutex_trylock_internal(xnthread_t
 		return ERR_PTR(-EPERM);
 #endif /* XENO_DEBUG(POSIX) */
 
-	owner = xnarch_atomic_intptr_cmpxchg(mutex->owner, NULL, cur);
-	if (unlikely(owner != NULL))
+	ownerh = xnarch_atomic_cmpxchg(mutex->owner, XN_NO_HANDLE,
+				       xnthread_handle(cur));
+	if (unlikely(ownerh != XN_NO_HANDLE)) {
+		owner = xnregistry_fetch(clear_claimed(ownerh));
+		if (!owner)
+			return ERR_PTR(-EINVAL);
 		return owner;
+	}
 
 	shadow->lockcnt = count;
 	return NULL;
@@ -118,7 +125,8 @@ static inline int pse51_mutex_timedlock_
 
 {
 	pse51_mutex_t *mutex;
-	xnthread_t *owner, *old;
+	xnthread_t *owner;
+	xnhandle_t ownerh, old;
 	spl_t s;
 	int err;
 
@@ -128,32 +136,41 @@ static inline int pse51_mutex_timedlock_
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
+	owner = xnregistry_fetch(clear_claimed(ownerh));
+
+	/* Consistency check for owner handle - is the object a thread? */
+	if (unlikely(!owner ||
+		     xnthread_handle(owner) != clear_claimed(ownerh))) {
+		err = -EINVAL;
+		goto error;
+	}
 
-	xnsynch_set_owner(&mutex->synchbase, clear_claimed(owner));
+	xnsynch_set_owner(&mutex->synchbase, owner);
 	++mutex->sleepers;
 	if (timed)
 		xnsynch_sleep_on(&mutex->synchbase, abs_to, XN_REALTIME);
@@ -174,7 +191,8 @@ static inline int pse51_mutex_timedlock_
 		goto error;
 	}
 
-	xnarch_atomic_intptr_set(mutex->owner,set_claimed(cur, mutex->sleepers));
+	ownerh = set_claimed(xnthread_handle(cur), mutex->sleepers);
+	xnarch_atomic_set(mutex->owner, ownerh);
 	shadow->lockcnt = count;
 	xnlock_put_irqrestore(&nklock, s);
 
@@ -182,9 +200,9 @@ static inline int pse51_mutex_timedlock_
 
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
@@ -192,16 +210,18 @@ static inline int pse51_mutex_timedlock_
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
@@ -28,6 +28,7 @@
  * 
  *@{*/
 
+#include <nucleus/registry.h>
 #include <posix/thread.h>
 #include <posix/cancel.h>
 #include <posix/timer.h>
@@ -234,6 +235,21 @@ int pthread_create(pthread_t *tid,
 	thread->hkey.mm = NULL;
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
+#ifdef CONFIG_XENO_FASTSEM
+	/* We need an anonymous registry entry to obtain a handle for fast
+	   mutex locking. */
+	{
+		int err =
+		    xnregistry_enter("", &thread->threadbase,
+				     &xnthread_handle(&thread->threadbase),
+						      NULL);
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
@@ -22,7 +22,14 @@ __attribute__ ((weak))
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
@@ -290,14 +290,12 @@ int rt_task_create(RT_TASK *task,
 	   complete objects, so that the registry cannot return handles to
 	   half-baked objects... */
 
-	if (name) {
-		err = xnregistry_enter(task->rname,
-				       &task->thread_base,
-				       &xnthread_handle(&task->thread_base),
-				       NULL);
-		if (err)
-			xnpod_delete_thread(&task->thread_base);
-	}
+	err = xnregistry_enter(name ? task->rname : "",
+			       &task->thread_base,
+			       &xnthread_handle(&task->thread_base),
+			       NULL);
+	if (err)
+		xnpod_delete_thread(&task->thread_base);
 #endif /* CONFIG_XENO_OPT_REGISTRY */
 
 	return err;
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
@@ -151,6 +151,17 @@ ER cre_tsk(ID tskid, T_CTSK *pk_ctsk)
 	xnlock_put_irqrestore(&nklock, s);
 	task->magic = uITRON_TASK_MAGIC;
 
+#ifdef CONFIG_XENO_FASTSEM
+	/* We need an anonymous registry entry to obtain a handle for fast
+	   mutex locking. */
+	if (xnregistry_enter("", &task->threadbase,
+			     &xnthread_handle(&task->threadbase), NULL)) {
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
@@ -20,6 +20,7 @@
 
 #include <nucleus/pod.h>
 #include <nucleus/heap.h>
+#include <nucleus/registry.h>
 #include <rtai/task.h>
 
 static DEFINE_XNQUEUE(__rtai_task_q);
@@ -152,6 +153,17 @@ int rt_task_init(RT_TASK *task,
 	task->magic = RTAI_TASK_MAGIC;
 	appendq(&__rtai_task_q, &task->link);
 
+#ifdef CONFIG_XENO_FASTSEM
+	/* We need an anonymous registry entry to obtain a handle for fast
+	   mutex locking. */
+	err = xnregistry_enter("", &task->thread_base,
+			       &xnthread_handle(&task->thread_base), NULL);
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
@@ -188,12 +188,28 @@ int sc_tecreate_inner(vrtxtask_t *task,
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
+		int err =
+		    xnregistry_enter("", &task->threadbase,
+				     &xnthread_handle(&task->threadbase),
+						      NULL);
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

