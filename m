From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18448.10494.796374.943152@domain.hid>
Date: Thu, 24 Apr 2008 08:30:22 +0200
In-Reply-To: <18448.10337.610639.200224@domain.hid>
References: <18448.9649.956656.531081@domain.hid>
	<18448.9901.799115.445182@domain.hid>
	<18448.9967.355128.570111@domain.hid>
	<18448.10037.181558.14996@domain.hid>
	<18448.10157.853132.856441@domain.hid>
	<18448.10221.879356.57696@domain.hid>
	<18448.10337.610639.200224@domain.hid>
Subject: [Xenomai-core] [7/9] Poor man's object control block read-write lock
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



This patch adds the file ksrc/skins/posix/cb_lock.h, a header used in kernel and
user-space to protect access to mutex control blocks. It implements a kind of
read-write lock without rescheduling, a failure meaning a programming error.

pthread_mutex_lock and pthread_mutex_unlock are considered readers, several of
them are allowed to enter the lock section, they will be serialized by cmpxchg
in user-space or the nklock in the syscalls anyway, pthread_mutex_init and
pthread_mutex_destroy, however, are considered writers, only one of them may
enter the lock section, and trying to call them at the same time as a call to
pthread_mutex_lock or pthread_mutex_unlock is a programming error which is
detected and reported.

These locks boil down to locking the nklock in kernel-space when atomic_cmpxchg
is not available in user-space. But this will be removed when all architectures
define XNARCH_HAVE_US_ATOMIC_CMPXCHG.

I intend to generalize the use of this mechanism to all posix skin objects,
because they allow shorter nklock sections in kernel space: access to the object
members are protected by this read-write lock mechanism, and no longer by the
nklock with interrupts off. It also solves an issue that was opened when getting
the posix skin copy_from/to_user calls out of nklock sections.

---
 cb_lock.h |   84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

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
+static  __inline__ int __cb_try_read_lock(atomic_t *lock)
+{
+	unsigned val = atomic_read(lock);
+	while (likely(val != -1)) {
+		unsigned old = atomic_cmpxchg(lock, val, val + 1);
+		if (likely(old == val))
+			return 0;
+		val = old;
+	}
+	return -EBUSY;
+}
+
+static __inline__ void __cb_read_unlock(atomic_t *lock)
+{
+	unsigned old, val = atomic_read(lock);
+	while (likely(val != -1)) {
+		old = atomic_cmpxchg(lock, val, val - 1);
+		if (likely(old == val))
+			return;
+		val = old;
+	}
+}
+
+static __inline__ int __cb_try_write_lock(atomic_t *lock)
+{
+	unsigned old = atomic_cmpxchg(lock, 0, -1);
+	if (unlikely(old))
+		return -EBUSY;
+	return 0;
+}
+
+static __inline__ void __cb_force_write_lock(atomic_t *lock)
+{
+	atomic_set(lock, -1);
+}
+
+static __inline__ void __cb_write_unlock(atomic_t *lock)
+{
+	atomic_set(lock, 0);
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


-- 


					    Gilles.

