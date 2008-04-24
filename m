From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18448.10594.876717.762863@domain.hid>
Date: Thu, 24 Apr 2008 08:32:02 +0200
In-Reply-To: <18448.10494.796374.943152@domain.hid>
References: <18448.9649.956656.531081@domain.hid>
	<18448.9901.799115.445182@domain.hid>
	<18448.9967.355128.570111@domain.hid>
	<18448.10037.181558.14996@domain.hid>
	<18448.10157.853132.856441@domain.hid>
	<18448.10221.879356.57696@domain.hid>
	<18448.10337.610639.200224@domain.hid>
	<18448.10494.796374.943152@domain.hid>
Subject: [Xenomai-core] [8/9] Re-implementation of mutexes,
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


The new implementation of mutexes consists of an atomic_cmpxchg on the mutex
owner, using the classical test and set raises problems for doing this and
setting the mutex owner atomically, so we do it all at once.

The room for storing the mutex owner is allocated in a shared heap, so that it
can be shared between kernel and user-space. I wonder if we need this at all. If
it is possible to call atomic_cmpxchg in kernel-space specifying a user-space
address, a bit like what futex_atomic_cmpxchg_inatomic does on platforms where
it is implemented, then we do not need it. But since this function is not
implemented for any of the architectures supported by Xenomai, I preferred to
stay with the heap implementation.

Further, the owner bit 0 (unused in an xnthread_t * pointer, since it is aligned
at least on a sizeof(int)), is used to mean that the mutex is claimed, to have
the atomic_cmpxchg used by the user-space mutex_unlock fail and cause the call
to the syscall, which will trigger xnsynch_wakeup_one_sleeper.

The implementation of pthread_cond_wait is also slightly modified, the mutex
condvars counter, used to forbid a call to pthread_mutex_destroy while
pthread_cond_wait is suspended, disappeared in favour of a locking by
pthread_cond_wait of the mutex control-block read-write lock.

The function used by pthread_cond_wait to unlock a mutex, possibly saving its
recursion count also needed to be rewritten.

---
 include/posix/pthread.h    |   56 ++++---
 ksrc/skins/posix/cond.c    |   41 +++--
 ksrc/skins/posix/mutex.c   |  296 ++++++++++++++++++++++++----------------
 ksrc/skins/posix/mutex.h   |  123 ++++++++++++----
 ksrc/skins/posix/syscall.c |  329 +++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 651 insertions(+), 194 deletions(-)

Index: src/skins/posix/mutex.c
===================================================================
--- src/skins/posix/mutex.c	(revision 3718)
+++ src/skins/posix/mutex.c	(working copy)
@@ -18,9 +18,14 @@
 
 #include <errno.h>
 #include <posix/syscall.h>
+#include <posix/cb_lock.h>
 #include <pthread.h>
 
+#define PSE51_MUTEX_MAGIC (0x86860303)
+
 extern int __pse51_muxid;
+extern pthread_key_t pse51_cur_key;
+extern unsigned long pse51_shared_map[2];
 
 int __wrap_pthread_mutexattr_init(pthread_mutexattr_t *attr)
 {
@@ -73,66 +78,279 @@ int __wrap_pthread_mutexattr_setpshared(
 				  __pse51_mutexattr_setpshared, attr, pshared);
 }
 
-int __wrap_pthread_mutex_init(pthread_mutex_t * mutex,
-			      const pthread_mutexattr_t * attr)
+static atomic_ptr_t *get_ownerp(struct __shadow_mutex *shadow)
+{
+	if (likely(!shadow->attr.pshared))
+		return shadow->owner;
+	
+	return (atomic_ptr_t *) (pse51_shared_map[1] + shadow->owner_offset);
+}
+
+int __wrap_pthread_mutex_init(pthread_mutex_t *mutex,
+			      const pthread_mutexattr_t *attr)
 {
 	union __xeno_mutex *_mutex = (union __xeno_mutex *)mutex;
+	struct __shadow_mutex *shadow = &_mutex->shadow_mutex;
 	int err;
 
-	err = -XENOMAI_SKINCALL2(__pse51_muxid,
-				 __pse51_mutex_init,&_mutex->shadow_mutex,attr);
+#ifdef XNARCH_HAVE_US_ATOMIC_CMPXCHG
+	if (unlikely(cb_try_read_lock(&shadow->lock, s)))
+		goto checked;
+
+	err = -XENOMAI_SKINCALL2(__pse51_muxid,__pse51_check_init,shadow,attr);
+
+	if (err) {
+		cb_read_unlock(&shadow->lock, s);
+		return err;
+	}
+
+  checked:
+	cb_force_write_lock(&shadow->lock, s);
+#endif /* XNARCH_HAVE_US_ATOMIC_CMPXCHG */
+
+	err = -XENOMAI_SKINCALL2(__pse51_muxid,__pse51_mutex_init,shadow,attr);
+
+	if (!shadow->attr.pshared)
+		shadow->owner = (atomic_ptr_t *)
+			(pse51_shared_map[0] + shadow->owner_offset);
+	
+	cb_write_unlock(&shadow->lock, s);
+
 	return err;
 }
 
-int __wrap_pthread_mutex_destroy(pthread_mutex_t * mutex)
+int __wrap_pthread_mutex_destroy(pthread_mutex_t *mutex)
 {
 	union __xeno_mutex *_mutex = (union __xeno_mutex *)mutex;
+	struct __shadow_mutex *shadow = &_mutex->shadow_mutex;
+	int err;
 
-	return -XENOMAI_SKINCALL1(__pse51_muxid,
-				  __pse51_mutex_destroy, &_mutex->shadow_mutex);
+	if (unlikely(cb_try_write_lock(&shadow->lock, s)))
+		return EINVAL;
+
+	err = -XENOMAI_SKINCALL1(__pse51_muxid, __pse51_mutex_destroy, shadow);
+
+	cb_write_unlock(&shadow->lock, s);
+
+	return err;
 }
 
-int __wrap_pthread_mutex_lock(pthread_mutex_t * mutex)
+int __wrap_pthread_mutex_lock(pthread_mutex_t *mutex)
 {
 	union __xeno_mutex *_mutex = (union __xeno_mutex *)mutex;
-	int err;
+	struct __shadow_mutex *shadow = &_mutex->shadow_mutex;
+	xnthread_t *cur, *owner;
+	int err = 0;
+
+#ifdef XNARCH_HAVE_US_ATOMIC_CMPXCHG
+	cur = pthread_getspecific(pse51_cur_key);
+	if (!cur)
+		return EPERM;
+
+	if (unlikely(cb_try_read_lock(&shadow->lock, s)))
+		return EINVAL;
+
+	if (unlikely(shadow->magic != PSE51_MUTEX_MAGIC)) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	owner = atomic_ptr_cmpxchg(get_ownerp(shadow), NULL, cur);
+	if (likely(!owner)) {
+		shadow->lockcnt = 1;
+		cb_read_unlock(&shadow->lock, s);
+		return 0;
+	}
+
+	if (clear_claimed(owner) == cur)
+		switch(shadow->attr.type) {
+		case PTHREAD_MUTEX_NORMAL:
+			break;
+
+		case PTHREAD_MUTEX_ERRORCHECK:
+			err = -EDEADLK;
+			goto out;
+
+		case PTHREAD_MUTEX_RECURSIVE:
+			if (shadow->lockcnt == UINT_MAX) {
+				err = -EAGAIN;
+				goto out;
+			}
+
+			++shadow->lockcnt;
+			goto out;
+		}
+#endif /* XNARCH_HAVE_US_ATOMIC_CMPXCHG */
 
 	do {
-		err = XENOMAI_SKINCALL1(__pse51_muxid,
-					__pse51_mutex_lock,
-					&_mutex->shadow_mutex);
+		err = XENOMAI_SKINCALL1(__pse51_muxid,__pse51_mutex_lock,shadow);
 	} while (err == -EINTR);
 
+#ifdef XNARCH_HAVE_US_ATOMIC_CMPXCHG
+  out:
+	cb_read_unlock(&shadow->lock, s);
+#endif /* XNARCH_HAVE_US_ATOMIC_CMPXCHG */
+
 	return -err;
 }
 
-int __wrap_pthread_mutex_timedlock(pthread_mutex_t * mutex,
+int __wrap_pthread_mutex_timedlock(pthread_mutex_t *mutex,
 				   const struct timespec *to)
 {
 	union __xeno_mutex *_mutex = (union __xeno_mutex *)mutex;
-	int err;
+	struct __shadow_mutex *shadow = &_mutex->shadow_mutex;
+	xnthread_t *cur, *owner;
+	int err = 0;
+
+#ifdef XNARCH_HAVE_US_ATOMIC_CMPXCHG
+	cur = pthread_getspecific(pse51_cur_key);
+	if (!cur)
+		return EPERM;
+
+	if (unlikely(cb_try_read_lock(&shadow->lock, s)))
+		return EINVAL;
+
+	if (shadow->magic != PSE51_MUTEX_MAGIC) {
+		err = -EINVAL;
+		goto out;
+	}	
+
+	owner = atomic_ptr_cmpxchg(get_ownerp(shadow), NULL, cur);
+	if (likely(!owner)) {
+		shadow->lockcnt = 1;
+		cb_read_unlock(&shadow->lock, s);
+		return 0;
+	}
+
+	if (clear_claimed(owner) == cur)
+		switch(shadow->attr.type) {
+		case PTHREAD_MUTEX_NORMAL:
+			break;
+
+		case PTHREAD_MUTEX_ERRORCHECK:
+			err = -EDEADLK;
+			goto out;
+
+		case PTHREAD_MUTEX_RECURSIVE:
+			if (shadow->lockcnt == UINT_MAX) {
+				err = -EAGAIN;
+				goto out;
+			}
+
+			++shadow->lockcnt;
+			goto out;
+		}
+#endif /* XNARCH_HAVE_US_ATOMIC_CMPXCHG */
 
 	do {
 		err = XENOMAI_SKINCALL2(__pse51_muxid,
-					__pse51_mutex_timedlock,
-					&_mutex->shadow_mutex, to);
+					__pse51_mutex_timedlock, shadow, to);
 	} while (err == -EINTR);
 
+#ifdef XNARCH_HAVE_US_ATOMIC_CMPXCHG
+  out:
+	cb_read_unlock(&shadow->lock, s);
+#endif /* XNARCH_HAVE_US_ATOMIC_CMPXCHG */
+
 	return -err;
 }
 
-int __wrap_pthread_mutex_trylock(pthread_mutex_t * mutex)
+int __wrap_pthread_mutex_trylock(pthread_mutex_t *mutex)
 {
 	union __xeno_mutex *_mutex = (union __xeno_mutex *)mutex;
+	struct __shadow_mutex *shadow = &_mutex->shadow_mutex;
+	xnthread_t *cur, *owner;
+	int err = 0;
+
+#ifdef XNARCH_HAVE_US_ATOMIC_CMPXCHG
+	cur = pthread_getspecific(pse51_cur_key);
+	if (!cur)
+		return EPERM;
+
+	if (unlikely(cb_try_read_lock(&shadow->lock, s)))
+		return EINVAL;
+
+	if (unlikely(shadow->magic != PSE51_MUTEX_MAGIC)) {
+		err = -EINVAL;
+		goto out;
+	}	
+
+	owner = atomic_ptr_cmpxchg(get_ownerp(shadow), NULL, cur);
+	if (likely(!owner)) {
+		shadow->lockcnt = 1;
+		cb_read_unlock(&shadow->lock, s);
+		return 0;
+	}
+
+	err = -EBUSY;
+	if (clear_claimed(owner) == cur
+	    && shadow->attr.type == PTHREAD_MUTEX_RECURSIVE)
+		if (shadow->lockcnt == UINT_MAX)
+			err = -EAGAIN;
+		else {
+			++shadow->lockcnt;
+			err = 0;
+		}
+
+  out:
+	cb_read_unlock(&shadow->lock, s);
+
+	return -err;
+
+#else /* !XNARCH_HAVE_US_ATOMIC_CMPXCHG */
+
+	return -XENOMAI_SKINCALL1(__pse51_muxid, __pse51_mutex_trylock, shadow);
 
-	return -XENOMAI_SKINCALL1(__pse51_muxid,
-				  __pse51_mutex_trylock, &_mutex->shadow_mutex);
+#endif /* !XNARCH_HAVE_US_ATOMIC_CMPXCHG */
 }
 
-int __wrap_pthread_mutex_unlock(pthread_mutex_t * mutex)
+int __wrap_pthread_mutex_unlock(pthread_mutex_t *mutex)
 {
 	union __xeno_mutex *_mutex = (union __xeno_mutex *)mutex;
+	struct __shadow_mutex *shadow = &_mutex->shadow_mutex;
 
-	return -XENOMAI_SKINCALL1(__pse51_muxid,
-				  __pse51_mutex_unlock, &_mutex->shadow_mutex);
+#ifdef XNARCH_HAVE_US_ATOMIC_CMPXCHG
+	atomic_ptr_t *ownerp;
+	xnthread_t *cur;
+	int err = 0;
+
+	cur = pthread_getspecific(pse51_cur_key);
+	if (!cur)
+		return EPERM;
+
+	if (unlikely(cb_try_read_lock(&shadow->lock, s)))
+		return EINVAL;
+
+	if (unlikely(shadow->magic != PSE51_MUTEX_MAGIC)) {
+		err = -EINVAL;
+		goto out_err;
+	}
+
+	ownerp = get_ownerp(shadow);
+	if (unlikely(clear_claimed(atomic_ptr_read(ownerp)) != cur)) {
+		err = -EPERM;
+		goto out_err;
+	}
+
+	err = 0;
+	if (shadow->lockcnt > 1) {
+		--shadow->lockcnt;
+		goto out;
+	}
+
+	if (likely(atomic_ptr_cmpxchg(ownerp, cur, NULL) == cur)) {
+	  out:
+		cb_read_unlock(&shadow->lock, s);
+		return 0;
+	}
+#endif /* XNARCH_HAVE_US_ATOMIC_CMPXCHG */
+
+	err = XENOMAI_SKINCALL1(__pse51_muxid, __pse51_mutex_unlock, shadow);
+
+#ifdef XNARCH_HAVE_US_ATOMIC_CMPXCHG
+  out_err:
+	cb_read_unlock(&shadow->lock, s);
+#endif /* XNARCH_HAVE_US_ATOMIC_CMPXCHG */
+
+	return -err;
 }
Index: src/skins/posix/cond.c
===================================================================
--- src/skins/posix/cond.c	(revision 3718)
+++ src/skins/posix/cond.c	(working copy)
@@ -19,6 +19,7 @@
 #include <errno.h>
 #include <posix/syscall.h>
 #include <pthread.h>
+#include <posix/cb_lock.h>
 
 extern int __pse51_muxid;
 
@@ -95,7 +96,7 @@ static void __pthread_cond_cleanup(void 
 			  c->count);
 }
 
-int __wrap_pthread_cond_wait(pthread_cond_t * cond, pthread_mutex_t * mutex)
+int __wrap_pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex)
 {
 	struct pse51_cond_cleanup_t c = {
 		.cond = (union __xeno_cond *)cond,
@@ -103,6 +104,9 @@ int __wrap_pthread_cond_wait(pthread_con
 	};
 	int err, oldtype;
 
+	if (cb_try_read_lock(&c.mutex->shadow_mutex.lock, s))
+		return EINVAL;
+
 	pthread_cleanup_push(&__pthread_cond_cleanup, &c);
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
@@ -118,11 +122,15 @@ int __wrap_pthread_cond_wait(pthread_con
 
 	pthread_cleanup_pop(0);
 
-	if (err)
+	if (err) {
+		cb_read_unlock(&c.mutex->shadow_mutex.lock, s);
 		return err;
+	}
 
 	__pthread_cond_cleanup(&c);
 
+	cb_read_unlock(&c.mutex->shadow_mutex.lock, s);
+
 	pthread_testcancel();
 
 	return 0;
@@ -138,6 +146,9 @@ int __wrap_pthread_cond_timedwait(pthrea
 	};
 	int err, oldtype;
 
+	if (cb_try_read_lock(&c.mutex->shadow_mutex.lock, s))
+		return EINVAL;
+
 	pthread_cleanup_push(&__pthread_cond_cleanup, &c);
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
@@ -153,11 +164,15 @@ int __wrap_pthread_cond_timedwait(pthrea
 
 	pthread_cleanup_pop(0);
 
-	if (err && err != ETIMEDOUT)
+	if (err && err != ETIMEDOUT) {
+		cb_read_unlock(&c.mutex->shadow_mutex.lock, s);		
 		return err;
+	}
 
 	__pthread_cond_cleanup(&c);
 
+	cb_read_unlock(&c.mutex->shadow_mutex.lock, s);
+
 	pthread_testcancel();
 
 	return err;
Index: src/skins/posix/Makefile.am
===================================================================
--- src/skins/posix/Makefile.am	(revision 3718)
+++ src/skins/posix/Makefile.am	(working copy)
@@ -2,6 +2,8 @@ includedir = $(prefix)/include/posix
 
 lib_LTLIBRARIES = libpthread_rt.la
 
+CPPFLAGS+=-I$(top_srcdir)/ksrc/skins
+
 libpthread_rt_la_LDFLAGS = -version-info 1:0:0 -lpthread
 
 libpthread_rt_la_SOURCES = \


-- 


					    Gilles.

