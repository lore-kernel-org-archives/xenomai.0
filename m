From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18459.38879.202210.838294@domain.hid>
Date: Sat, 3 May 2008 00:38:23 +0200
In-Reply-To: <18459.38785.367098.763153@domain.hid>
References: <18459.38249.462320.715909@domain.hid>
	<18459.38430.835407.942336@domain.hid>
	<18459.38500.720338.652195@domain.hid>
	<18459.38558.684426.240775@domain.hid>
	<18459.38644.699369.801548@domain.hid>
	<18459.38704.252719.734650@domain.hid>
	<18459.38785.367098.763153@domain.hid>
Subject: [Xenomai-core] [Patch 7/7] Re-implementation of mutexes,
	user-space support.
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


Since binding of the semaphore heaps is now made by xeno_skin_bind, there is
much less modifications in src/skins/posix/init.c. However, I had to do
something really ugly: since binding the semaphore heaps by xeno_skin_bind
requires calls to open, ioctl, mmap, close and munmap, I redefined these symbols
to be the __real_ variants before including bind.h.
Another solution would have been to use __open (which would not have been
wrapped) instead of open in bind.h and rely on the fact that the posix skin
wrapped syscalls fall back to the __real variants when called for non real-time
file descriptors. I do not know however, if this solution would have been
portable. In particular, does uclibc also defines __open ?

---
 Makefile.am |    2
 cond.c      |   21 ++++
 init.c      |   26 +++++
 mutex.c     |  265 ++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 287 insertions(+), 27 deletions(-)

Index: src/skins/posix/init.c
===================================================================
--- src/skins/posix/init.c	(revision 3738)
+++ src/skins/posix/init.c	(working copy)
@@ -26,9 +26,23 @@
 #include <posix/posix.h>
 #include <posix/syscall.h>
 #include <rtdm/syscall.h>
-#include <asm-generic/bits/bind.h>
 #include <asm-generic/bits/mlock_alert.h>
 
+/* asm-generic/bits/bind.h uses the following functions, so we redefine them to
+   be the __real variants */
+#undef open
+#undef ioctl
+#undef mmap
+#undef close
+#undef munmap
+#define open __real_open
+#define ioctl __real_ioctl
+#define mmap __real_mmap
+#define close __real_close
+#define munmap __real_munmap
+
+#include <asm-generic/bits/bind.h>
+
 int __pse51_muxid = -1;
 int __rtdm_muxid = -1;
 int __rtdm_fd_start = INT_MAX;
@@ -91,5 +105,15 @@ void __init_posix_interface(void)
 			exit(EXIT_FAILURE);
 		}
 		fork_handler_registered = 1;
+
+		if (sizeof(struct __shadow_mutex) > sizeof(pthread_mutex_t)) {
+			fprintf(stderr, "sizeof(pthread_mutex_t): %d,"
+				" sizeof(shadow_mutex): %d\n",
+				sizeof(pthread_mutex_t),
+				sizeof(struct __shadow_mutex));
+			exit(EXIT_FAILURE);
+		}
+
 	}
 }
+
Index: src/skins/posix/mutex.c
===================================================================
--- src/skins/posix/mutex.c	(revision 3738)
+++ src/skins/posix/mutex.c	(working copy)
@@ -17,10 +17,15 @@
  */
 
 #include <errno.h>
-#include <posix/syscall.h>
 #include <pthread.h>
+#include <posix/syscall.h>
+#include <posix/cb_lock.h>
+#include <asm-generic/bits/current.h>
+
+#define PSE51_MUTEX_MAGIC (0x86860303)
 
 extern int __pse51_muxid;
+extern unsigned long xeno_sem_heap[2];
 
 int __wrap_pthread_mutexattr_init(pthread_mutexattr_t *attr)
 {
@@ -73,66 +78,280 @@ int __wrap_pthread_mutexattr_setpshared(
 				  __pse51_mutexattr_setpshared, attr, pshared);
 }
 
-int __wrap_pthread_mutex_init(pthread_mutex_t * mutex,
-			      const pthread_mutexattr_t * attr)
+static xnarch_atomic_intptr_t *get_ownerp(struct __shadow_mutex *shadow)
+{
+	if (likely(!shadow->attr.pshared))
+		return shadow->owner;
+	
+	return (xnarch_atomic_intptr_t *) (xeno_sem_heap[1] + shadow->owner_offset);
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
+		shadow->owner = (xnarch_atomic_intptr_t *)
+			(xeno_sem_heap[0] + shadow->owner_offset);
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
+
+	if (unlikely(cb_try_write_lock(&shadow->lock, s)))
+		return EINVAL;
 
-	return -XENOMAI_SKINCALL1(__pse51_muxid,
-				  __pse51_mutex_destroy, &_mutex->shadow_mutex);
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
+	cur = xeno_get_current();
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
+	owner = xnarch_atomic_intptr_cmpxchg(get_ownerp(shadow), NULL, cur);
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
+	cur = xeno_get_current();
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
+	owner = xnarch_atomic_intptr_cmpxchg(get_ownerp(shadow), NULL, cur);
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
+	cur = xeno_get_current();
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
+	owner = xnarch_atomic_intptr_cmpxchg(get_ownerp(shadow), NULL, cur);
+	if (likely(!owner)) {
+		shadow->lockcnt = 1;
+		cb_read_unlock(&shadow->lock, s);
+		return 0;
+	}
+
+	err = -EBUSY;
+	if (clear_claimed(owner) == cur
+	    && shadow->attr.type == PTHREAD_MUTEX_RECURSIVE) {
+		if (shadow->lockcnt == UINT_MAX)
+			err = -EAGAIN;
+		else {
+			++shadow->lockcnt;
+			err = 0;
+		}
+	}
+
+  out:
+	cb_read_unlock(&shadow->lock, s);
 
-	return -XENOMAI_SKINCALL1(__pse51_muxid,
-				  __pse51_mutex_trylock, &_mutex->shadow_mutex);
+	return -err;
+
+#else /* !XNARCH_HAVE_US_ATOMIC_CMPXCHG */
+
+	return -XENOMAI_SKINCALL1(__pse51_muxid, __pse51_mutex_trylock, shadow);
+
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
+	xnarch_atomic_intptr_t *ownerp;
+	xnthread_t *cur;
+	int err = 0;
+
+	cur = xeno_get_current();
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
+	if (unlikely(clear_claimed(xnarch_atomic_intptr_get(ownerp)) != cur)) {
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
+	if (likely(xnarch_atomic_intptr_cmpxchg(ownerp, cur, NULL) == cur)) {
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
--- src/skins/posix/cond.c	(revision 3738)
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
--- src/skins/posix/Makefile.am	(revision 3738)
+++ src/skins/posix/Makefile.am	(working copy)
@@ -2,6 +2,8 @@ includedir = $(prefix)/include/posix
 
 lib_LTLIBRARIES = libpthread_rt.la
 
+CPPFLAGS+=-I$(top_srcdir)/ksrc/skins
+
 libpthread_rt_la_LDFLAGS = -version-info 1:0:0 -lpthread
 
 libpthread_rt_la_SOURCES = \


-- 


					    Gilles.

