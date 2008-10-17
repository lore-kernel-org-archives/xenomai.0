Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48F8B484.1040000@domain.hid>
Message-Id: <20081017154600.591862350@domain.hid>
Date: Fri, 17 Oct 2008 17:46:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
References: <20081017154559.420723261@domain.hid>
Subject: [Xenomai-core] [PATCH 07/13] Lockless fast path for
	xnsynch_acquire/release
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


This patch adds optional lockless fast paths to xnsynch_acquire and
xnsynch_release. Those paths are considered if CONFIG_XENO_FASTSYNC
is defined and the owner-tracking xnsynch object is given a non-NULL
reference to an atomic fastlock variable on initialization. This allows
for a smooth migration of existing mutex implementations in Xenomai
skins to a fast xnsynch scheme.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 configure.in                      |   16 ++--
 include/asm-generic/bits/bind.h   |   16 ++--
 include/asm-generic/features.h    |   24 +++---
 include/nucleus/synch.h           |   58 ++++++++++++++++
 ksrc/arch/arm/Kconfig             |    2 
 ksrc/arch/powerpc/Kconfig         |    2 
 ksrc/arch/x86/Kconfig             |    2 
 ksrc/drivers/testing/switchtest.c |    2 
 ksrc/nucleus/pipe.c               |    2 
 ksrc/nucleus/registry.c           |    4 -
 ksrc/nucleus/select.c             |    2 
 ksrc/nucleus/synch.c              |  132 ++++++++++++++++++++++++++++++++------
 ksrc/skins/native/Kconfig         |    2 
 ksrc/skins/native/alarm.c         |    2 
 ksrc/skins/native/buffer.c        |    4 -
 ksrc/skins/native/cond.c          |    2 
 ksrc/skins/native/event.c         |    2 
 ksrc/skins/native/heap.c          |    2 
 ksrc/skins/native/intr.c          |    2 
 ksrc/skins/native/mutex.c         |    2 
 ksrc/skins/native/queue.c         |    2 
 ksrc/skins/native/sem.c           |    2 
 ksrc/skins/native/task.c          |    6 -
 ksrc/skins/posix/Kconfig          |    2 
 ksrc/skins/posix/cb_lock.h        |    6 -
 ksrc/skins/posix/cond.c           |   18 ++---
 ksrc/skins/posix/intr.c           |    2 
 ksrc/skins/posix/mq.c             |    4 -
 ksrc/skins/posix/mutex.c          |   12 +--
 ksrc/skins/posix/mutex.h          |    4 -
 ksrc/skins/posix/sem.c            |    2 
 ksrc/skins/posix/syscall.c        |   20 ++---
 ksrc/skins/posix/thread.c         |    6 -
 ksrc/skins/psos+/Kconfig          |    2 
 ksrc/skins/psos+/event.c          |    2 
 ksrc/skins/psos+/queue.c          |    2 
 ksrc/skins/psos+/rn.c             |    2 
 ksrc/skins/psos+/sem.c            |    2 
 ksrc/skins/rtai/Kconfig           |    2 
 ksrc/skins/rtai/sem.c             |    2 
 ksrc/skins/rtai/task.c            |    4 -
 ksrc/skins/rtdm/drvlib.c          |   10 +-
 ksrc/skins/uitron/Kconfig         |    2 
 ksrc/skins/uitron/flag.c          |    2 
 ksrc/skins/uitron/mbx.c           |    3 
 ksrc/skins/uitron/sem.c           |    3 
 ksrc/skins/uitron/task.c          |    4 -
 ksrc/skins/vrtx/Kconfig           |    2 
 ksrc/skins/vrtx/event.c           |    2 
 ksrc/skins/vrtx/mb.c              |    2 
 ksrc/skins/vrtx/mx.c              |    3 
 ksrc/skins/vrtx/queue.c           |    2 
 ksrc/skins/vrtx/sem.c             |    2 
 ksrc/skins/vxworks/Kconfig        |    2 
 ksrc/skins/vxworks/module.c       |    2 
 ksrc/skins/vxworks/msgQLib.c      |    2 
 ksrc/skins/vxworks/semLib.c       |    2 
 ksrc/skins/vxworks/syscall.c      |    2 
 ksrc/skins/vxworks/taskLib.c      |    2 
 src/skins/posix/mutex.c           |   42 ++++++------
 60 files changed, 313 insertions(+), 162 deletions(-)

Index: b/configure.in
===================================================================
--- a/configure.in
+++ b/configure.in
@@ -59,27 +59,27 @@ AM_PROG_LEX
 
 AC_MSG_CHECKING([for target architecture])
 
-CONFIG_XENO_FASTSEM=
+CONFIG_XENO_FASTSYNCH=
 case "$host" in
  i*86*-*)
 	XENO_TARGET_ARCH=x86
         XENO_LINUX_ARCH=i386
 	XENO_LINUX_INSTALL_TARGET=install
-	CONFIG_XENO_FASTSEM=y
+	CONFIG_XENO_FASTSYNCH=y
         ;;
  powerpc-*|ppc-*)
 	XENO_TARGET_ARCH=powerpc
         XENO_LINUX_ARCH=ppc
 	XENO_LINUX_INSTALL_TARGET=install_image
 	XENO_LINUX_IMAGE=arch/ppc/boot/images/zImage.elf
-	CONFIG_XENO_FASTSEM=y
+	CONFIG_XENO_FASTSYNCH=y
         ;;
  powerpc64-*|ppc64-*)
 	XENO_TARGET_ARCH=powerpc
         XENO_LINUX_ARCH=ppc64
 	XENO_LINUX_INSTALL_TARGET=install_image
 	XENO_LINUX_IMAGE=arch/ppc64/boot/images/zImage
-	CONFIG_XENO_FASTSEM=y
+	CONFIG_XENO_FASTSYNCH=y
         ;;
  ia64-*)
 	XENO_TARGET_ARCH=ia64
@@ -96,14 +96,14 @@ case "$host" in
  	XENO_LINUX_ARCH=arm
 	XENO_LINUX_INSTALL_TARGET=install_image
 	XENO_LINUX_IMAGE=arch/arm/boot/zImage
-	# We set CONFIG_XENO_FASTSEM later, when we know what architecture we
+	# We set CONFIG_XENO_FASTSYNCH later, when we know what architecture we
 	# are running
 	;;
  x86_64-*|amd64-*)
 	XENO_TARGET_ARCH=x86
         XENO_LINUX_ARCH=x86_64
 	XENO_LINUX_INSTALL_TARGET=install
-	CONFIG_XENO_FASTSEM=y
+	CONFIG_XENO_FASTSYNCH=y
         ;;
  *) echo ""
    echo "*******************************************"
@@ -288,7 +288,7 @@ user-space]),
   AC_MSG_RESULT(${CONFIG_XENO_ARM_EABI:-no})
 
   if test $CONFIG_XENO_ARM_ARCH -ge 6 || test x$CONFIG_SMP != xy; then
-	CONFIG_XENO_FASTSEM=y
+	CONFIG_XENO_FASTSYNCH=y
   fi
 fi
 
@@ -570,7 +570,7 @@ dnl
 
 test x$CONFIG_XENO_X86_SEP = xy && AC_DEFINE(CONFIG_XENO_X86_SEP,1,[config])
 test x$CONFIG_SMP = xy && AC_DEFINE(CONFIG_SMP,1,[config])
-test x$CONFIG_XENO_FASTSEM = xy && AC_DEFINE(CONFIG_XENO_FASTSEM,1,[config])
+test x$CONFIG_XENO_FASTSYNCH = xy && AC_DEFINE(CONFIG_XENO_FASTSYNCH,1,[config])
 test x$CONFIG_X86_TSC = xy && AC_DEFINE(CONFIG_X86_TSC,1,[config])
 test -n "$CONFIG_XENO_ARM_ARCH" && AC_DEFINE_UNQUOTED(CONFIG_XENO_ARM_ARCH,$CONFIG_XENO_ARM_ARCH,[config])
 
Index: b/include/asm-generic/bits/bind.h
===================================================================
--- a/include/asm-generic/bits/bind.h
+++ b/include/asm-generic/bits/bind.h
@@ -42,14 +42,14 @@ void init_current_key(void)
 	}
 }
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 __attribute__ ((weak))
 unsigned long xeno_sem_heap[2] = { 0, 0 };
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 void xeno_handle_mlock_alert(int sig);
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 static void *map_sem_heap(unsigned shared)
 {
 	struct heap_info {
@@ -103,7 +103,7 @@ static void unmap_sem_heap(unsigned long
 
 	munmap((void *) heap_addr, hinfo.size);
 }
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 void __attribute__((weak)) xeno_sigill_handler(int sig)
 {
@@ -174,7 +174,7 @@ xeno_bind_skin(unsigned skin_magic, cons
 	sa.sa_flags = 0;
 	sigaction(SIGXCPU, &sa, NULL);
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 	/* In case we forked, we need to map the new local semaphore heap */
 	if (xeno_sem_heap[0])
 		unmap_sem_heap(xeno_sem_heap[0], 0);
@@ -193,7 +193,7 @@ xeno_bind_skin(unsigned skin_magic, cons
 			exit(EXIT_FAILURE);
 		}
 	}
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	return muxid;
 }
@@ -248,7 +248,7 @@ xeno_bind_skin_opt(unsigned skin_magic,
 	xeno_arch_features_check();
 #endif /* xeno_arch_features_check */
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 	/* In case we forked, we need to map the new local semaphore heap */
 	if (xeno_sem_heap[0])
 		unmap_sem_heap(xeno_sem_heap[0], 0);
@@ -267,7 +267,7 @@ xeno_bind_skin_opt(unsigned skin_magic,
 			exit(EXIT_FAILURE);
 		}
 	}
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	return muxid;
 }
Index: b/include/asm-generic/features.h
===================================================================
--- a/include/asm-generic/features.h
+++ b/include/asm-generic/features.h
@@ -25,9 +25,9 @@
 #include <xeno_config.h>
 #endif /* __KERNEL__ */
 
-#define __xn_feat_smp       0x80000000
-#define __xn_feat_fastsem   0x40000000
-#define __xn_feat_nofastsem 0x20000000
+#define __xn_feat_smp         0x80000000
+#define __xn_feat_fastsynch   0x40000000
+#define __xn_feat_nofastsynch 0x20000000
 
 #ifdef CONFIG_SMP
 #define __xn_feat_smp_mask __xn_feat_smp
@@ -35,25 +35,25 @@
 #define __xn_feat_smp_mask 0
 #endif
 
-#ifdef CONFIG_XENO_FASTSEM
-#define __xn_feat_fastsem_mask __xn_feat_fastsem
+#ifdef CONFIG_XENO_FASTSYNCH
+#define __xn_feat_fastsynch_mask __xn_feat_fastsynch
 #else
-#define __xn_feat_fastsem_mask __xn_feat_nofastsem
+#define __xn_feat_fastsynch_mask __xn_feat_nofastsynch
 #endif
 
-#define __xn_feat_generic_mask     (__xn_feat_smp_mask | __xn_feat_fastsem_mask)
+#define __xn_feat_generic_mask     (__xn_feat_smp_mask | __xn_feat_fastsynch_mask)
 
-#define __xn_feat_generic_man_mask (__xn_feat_fastsem | __xn_feat_nofastsem)
+#define __xn_feat_generic_man_mask (__xn_feat_fastsynch | __xn_feat_nofastsynch)
 
 static inline const char *get_generic_feature_label (unsigned feature)
 {
     switch (feature) {
     	case __xn_feat_smp:
 	    return "smp";
-        case __xn_feat_fastsem:
-	    return "fastsem";
-        case __xn_feat_nofastsem:
-	    return "nofastsem";
+        case __xn_feat_fastsynch:
+	    return "fastsynch";
+        case __xn_feat_nofastsynch:
+	    return "nofastsynch";
     	default:
 	    return 0;
     }
Index: b/include/nucleus/synch.h
===================================================================
--- a/include/nucleus/synch.h
+++ b/include/nucleus/synch.h
@@ -32,10 +32,42 @@
 #define XNSYNCH_DREORD  0x4
 #define XNSYNCH_OWNER   0x8
 
+/* Fast lock API */
+static inline int xnsynch_fast_owner_check(xnarch_atomic_t *fastlock,
+					   xnhandle_t ownerh)
+{
+	return (xnhandle_mask_spare(xnarch_atomic_get(fastlock)) == ownerh) ?
+		0 : -EPERM;
+}
+
+static inline int xnsynch_fast_acquire(xnarch_atomic_t *fastlock,
+				       xnhandle_t new_ownerh)
+{
+	xnhandle_t lock_state =
+	    xnarch_atomic_cmpxchg(fastlock, XN_NO_HANDLE, new_ownerh);
+
+	if (likely(lock_state == XN_NO_HANDLE))
+		return 0;
+
+	if (xnhandle_mask_spare(lock_state) == new_ownerh)
+		return -EBUSY;
+
+	return -EAGAIN;
+}
+
+static inline int xnsynch_fast_release(xnarch_atomic_t *fastlock,
+				       xnhandle_t cur_ownerh)
+{
+	return (xnarch_atomic_cmpxchg(fastlock, cur_ownerh, XN_NO_HANDLE) ==
+		cur_ownerh);
+}
+
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
 #define XNSYNCH_CLAIMED 0x10	/* Claimed by other thread(s) w/ PIP */
 
+#define XNSYNCH_FLCLAIM XN_HANDLE_SPARE3 /* Corresponding bit in fast lock */
+
 /* Spare flags usable by upper interfaces */
 #define XNSYNCH_SPARE0  0x01000000
 #define XNSYNCH_SPARE1  0x02000000
@@ -67,6 +99,10 @@ typedef struct xnsynch {
 
     struct xnthread *owner; /* Thread which owns the resource */
 
+#ifdef CONFIG_XENO_FASTSYNCH
+    xnarch_atomic_t *fastlock; /* Pointer to fast lock word */
+#endif /* CONFIG_XENO_FASTSYNCH */
+
     void (*cleanup)(struct xnsynch *synch); /* Cleanup handler */
 
     XNARCH_DECL_DISPLAY_CONTEXT();
@@ -81,12 +117,30 @@ typedef struct xnsynch {
 #define xnsynch_pended_p(synch)		(!emptypq_p(&((synch)->pendq)))
 #define xnsynch_owner(synch)		((synch)->owner)
 
+#ifdef CONFIG_XENO_FASTSYNCH
+#define xnsynch_fastlock(synch)		((synch)->fastlock)
+#define xnsynch_fastlock_p(synch)	((synch)->fastlock != NULL)
+#define xnsynch_owner_check(synch, thread) \
+	xnsynch_fast_owner_check((synch)->fastlock, xnthread_handle(thread))
+#else /* !CONFIG_XENO_FASTSYNCH */
+#define xnsynch_fastlock(synch)		NULL
+#define xnsynch_fastlock_p(synch)	0
+#define xnsynch_owner_check(synch, thread) \
+	((synch)->owner == thread ? 0 : -EPERM)
+#endif /* !CONFIG_XENO_FASTSYNCH */
+
+#define xnsynch_fast_is_claimed(fastlock) \
+	xnhandle_test_spare(fastlock, XNSYNCH_FLCLAIM)
+#define xnsynch_fast_set_claimed(fastlock, enable) \
+	(((fastlock) & ~XNSYNCH_FLCLAIM) | ((enable) ? XNSYNCH_FLCLAIM : 0))
+#define xnsynch_fast_mask_claimed(fastlock) ((fastlock) & ~XNSYNCH_FLCLAIM)
+
 #ifdef __cplusplus
 extern "C" {
 #endif
 
-void xnsynch_init(xnsynch_t *synch,
-		  xnflags_t flags);
+void xnsynch_init(xnsynch_t *synch, xnflags_t flags,
+		  xnarch_atomic_t *fastlock);
 
 #define xnsynch_destroy(synch) xnsynch_flush(synch,XNRMID)
 
Index: b/ksrc/arch/arm/Kconfig
===================================================================
--- a/ksrc/arch/arm/Kconfig
+++ b/ksrc/arch/arm/Kconfig
@@ -2,7 +2,7 @@ config XENO_GENERIC_STACKPOOL
 	bool
 	default y
 
-config XENO_FASTSEM
+config XENO_FASTSYNCH
 	bool
 	default y if (CPU_32v3 || CPU_32v4T || CPU_32v5) && !SMP || CPU_32v6 || CPU_32v7
 
Index: b/ksrc/arch/powerpc/Kconfig
===================================================================
--- a/ksrc/arch/powerpc/Kconfig
+++ b/ksrc/arch/powerpc/Kconfig
@@ -2,7 +2,7 @@ config XENO_GENERIC_STACKPOOL
 	bool
 	default y
 
-config XENO_FASTSEM
+config XENO_FASTSYNCH
 	bool
 	default y
 
Index: b/ksrc/arch/x86/Kconfig
===================================================================
--- a/ksrc/arch/x86/Kconfig
+++ b/ksrc/arch/x86/Kconfig
@@ -2,7 +2,7 @@ config XENO_GENERIC_STACKPOOL
 	bool
 	default y
 
-config XENO_FASTSEM
+config XENO_FASTSYNCH
 	bool
 	default y
 
Index: b/ksrc/skins/native/Kconfig
===================================================================
--- a/ksrc/skins/native/Kconfig
+++ b/ksrc/skins/native/Kconfig
@@ -1,6 +1,6 @@
 menuconfig XENO_SKIN_NATIVE
 	depends on XENO_OPT_NUCLEUS
-	select XENO_OPT_REGISTRY if XENO_FASTSEM
+	select XENO_OPT_REGISTRY if XENO_FASTSYNCH
 	tristate "Native API"
 	default y
 	help
Index: b/ksrc/skins/posix/Kconfig
===================================================================
--- a/ksrc/skins/posix/Kconfig
+++ b/ksrc/skins/posix/Kconfig
@@ -1,6 +1,6 @@
 menuconfig XENO_SKIN_POSIX
 	depends on XENO_OPT_NUCLEUS 
-	select XENO_OPT_REGISTRY if XENO_FASTSEM
+	select XENO_OPT_REGISTRY if XENO_FASTSYNCH
 	tristate "POSIX API"
 	default y
 	help
Index: b/ksrc/skins/posix/cb_lock.h
===================================================================
--- a/ksrc/skins/posix/cb_lock.h
+++ b/ksrc/skins/posix/cb_lock.h
@@ -20,7 +20,7 @@ typedef void xnthread_t;
 	__tmp; \
 })
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 
 static  __inline__ int __cb_try_read_lock(xnarch_atomic_t *lock)
 {
@@ -68,7 +68,7 @@ static __inline__ void __cb_write_unlock
 #define cb_try_write_lock(lock, flags) __cb_try_write_lock(lock)
 #define cb_force_write_lock(lock, flags) __cb_force_write_lock(lock)
 #define cb_write_unlock(lock, flags) __cb_write_unlock(lock)
-#else /* !CONFIG_XENO_FASTSEM */
+#else /* !CONFIG_XENO_FASTSYNCH */
 #ifdef __KERNEL__
 #define DECLARE_CB_LOCK_FLAGS(name) spl_t name
 #define cb_try_read_lock(lock, flags) \
@@ -87,6 +87,6 @@ static __inline__ void __cb_write_unlock
 #define cb_force_write_lock(lock, flags) do { } while (0)
 #define cb_write_unlock(lock, flags) do { } while (0)
 #endif /* !__KERNEL__ */
-#endif /* !CONFIG_XENO_FASTSEM */
+#endif /* !CONFIG_XENO_FASTSYNCH */
 
 #endif /* CB_LOCK_H */
Index: b/ksrc/skins/posix/cond.c
===================================================================
--- a/ksrc/skins/posix/cond.c
+++ b/ksrc/skins/posix/cond.c
@@ -142,7 +142,7 @@ int pthread_cond_init(pthread_cond_t * c
 	shadow->magic = PSE51_COND_MAGIC;
 	shadow->cond = cond;
 
-	xnsynch_init(&cond->synchbase, synch_flags);
+	xnsynch_init(&cond->synchbase, synch_flags, NULL);
 	inith(&cond->link);
 	cond->attr = *attr;
 	cond->mutex = NULL;
@@ -424,10 +424,10 @@ int pthread_cond_wait(pthread_cond_t * c
 	unsigned count;
 	int err;
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 	if (unlikely(cb_try_read_lock(&mutex->lock, s)))
 		return EINVAL;
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	err = pse51_cond_timedwait_prologue(cur, cond, mutex,
 					    &count, 0, XN_INFINITE);
@@ -437,9 +437,9 @@ int pthread_cond_wait(pthread_cond_t * c
 							      mutex, count))
 			;
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 	cb_read_unlock(&mutex->lock, s);
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	return err != EINTR ? err : 0;
 }
@@ -492,10 +492,10 @@ int pthread_cond_timedwait(pthread_cond_
 	unsigned count;
 	int err;
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 	if (unlikely(cb_try_read_lock(&mutex->lock, s)))
 		return EINVAL;
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	err = pse51_cond_timedwait_prologue(cur, cond, mutex, &count, 1,
 					    ts2ticks_ceil(abstime) + 1);
@@ -505,9 +505,9 @@ int pthread_cond_timedwait(pthread_cond_
 							      mutex, count))
 			;
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 	cb_read_unlock(&mutex->lock, s);
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	return err != EINTR ? err : 0;
 }
Index: b/ksrc/skins/posix/mutex.c
===================================================================
--- a/ksrc/skins/posix/mutex.c
+++ b/ksrc/skins/posix/mutex.c
@@ -103,16 +103,16 @@ int pse51_mutex_init_internal(struct __s
 	shadow->mutex = mutex;
 	shadow->lockcnt = 0;
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 	xnarch_atomic_set(&shadow->lock, -1);
 	shadow->attr = *attr;
 	shadow->owner_offset = xnheap_mapped_offset(&sys_ppd->sem_heap, ownerp);
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	if (attr->protocol == PTHREAD_PRIO_INHERIT)
 		synch_flags |= XNSYNCH_PIP;
 
-	xnsynch_init(&mutex->synchbase, synch_flags);
+	xnsynch_init(&mutex->synchbase, synch_flags, NULL);
 	inith(&mutex->link);
 	mutex->attr = *attr;
 	mutex->owner = ownerp;
@@ -169,16 +169,16 @@ int pthread_mutex_init(pthread_mutex_t *
 		goto checked;
 
 	err = pse51_mutex_check_init(shadow, attr);
-#ifndef CONFIG_XENO_FASTSEM
+#ifndef CONFIG_XENO_FASTSYNCH
 	cb_read_unlock(&shadow->lock, s);
 	if (err)
 		return -err;
-#else /* CONFIG_XENO_FASTSEM */
+#else /* CONFIG_XENO_FASTSYNCH */
 	if (err) {
 		cb_read_unlock(&shadow->lock, s);
 		return -err;
 	}
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
   checked:
 	mutex = (pse51_mutex_t *) xnmalloc(sizeof(*mutex));
Index: b/ksrc/skins/posix/mutex.h
===================================================================
--- a/ksrc/skins/posix/mutex.h
+++ b/ksrc/skins/posix/mutex.h
@@ -30,14 +30,14 @@ union __xeno_mutex {
 		unsigned magic;
 		unsigned lockcnt;
 		struct pse51_mutex *mutex;
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 		xnarch_atomic_t lock;
 		union {
 			unsigned owner_offset;
 			xnarch_atomic_t *owner;
 		};
 		struct pse51_mutexattr attr;
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 	} shadow_mutex;
 };
 
Index: b/ksrc/skins/posix/syscall.c
===================================================================
--- a/ksrc/skins/posix/syscall.c
+++ b/ksrc/skins/posix/syscall.c
@@ -886,7 +886,7 @@ static int __pthread_mutexattr_setpshare
 	return __xn_safe_copy_to_user((void __user *)uattrp, &attr, sizeof(*uattrp));
 }
 
-#ifndef CONFIG_XENO_FASTSEM
+#ifndef CONFIG_XENO_FASTSYNCH
 static int __pthread_mutex_init(struct pt_regs *regs)
 {
 	pthread_mutexattr_t locattr, *attr, *uattrp;
@@ -1088,7 +1088,7 @@ static int __pthread_mutex_unlock(struct
 
 	return err;
 }
-#else /* !CONFIG_XENO_FASTSEM */
+#else /* !CONFIG_XENO_FASTSYNCH */
 static int __pthread_mutex_check_init(struct pt_regs *regs)
 {
 	pthread_mutexattr_t locattr, *attr, *uattrp;
@@ -1279,7 +1279,7 @@ static int __pthread_mutex_unlock(struct
 
 	return 0;
 }
-#endif /* !CONFIG_XENO_FASTSEM */
+#endif /* !CONFIG_XENO_FASTSYNCH */
 
 static int __pthread_condattr_init(struct pt_regs *regs)
 {
@@ -1469,11 +1469,11 @@ static int __pthread_cond_wait_prologue(
 
 	if (__xn_safe_copy_from_user(&mx.shadow_mutex,
 				     (void __user *)&umx->shadow_mutex,
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 				     offsetof(struct __shadow_mutex, lock)
-#else /* !CONFIG_XENO_FASTSEM */
+#else /* !CONFIG_XENO_FASTSYNCH */
 				     sizeof(mx.shadow_mutex)
-#endif /* !CONFIG_XENO_FASTSEM */
+#endif /* !CONFIG_XENO_FASTSYNCH */
 				     ))
 		return -EFAULT;
 
@@ -1537,11 +1537,11 @@ static int __pthread_cond_wait_epilogue(
 
 	if (__xn_safe_copy_from_user(&mx.shadow_mutex,
 				     (void __user *)&umx->shadow_mutex,
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 				     offsetof(struct __shadow_mutex, lock)
-#else /* !CONFIG_XENO_FASTSEM */
+#else /* !CONFIG_XENO_FASTSYNCH */
 				     sizeof(mx.shadow_mutex)
-#endif /* !CONFIG_XENO_FASTSEM */
+#endif /* !CONFIG_XENO_FASTSYNCH */
 				     ))
 		return -EFAULT;
 
@@ -2695,7 +2695,7 @@ static xnsysent_t __systab[] = {
 	[__pse51_mutex_lock] = {&__pthread_mutex_lock, __xn_exec_primary},
 	[__pse51_mutex_timedlock] =
 	    {&__pthread_mutex_timedlock, __xn_exec_primary},
-#ifndef CONFIG_XENO_FASTSEM
+#ifndef CONFIG_XENO_FASTSYNCH
 	[__pse51_mutex_trylock] = {&__pthread_mutex_trylock, __xn_exec_primary},
 #else
         [__pse51_check_init] = {&__pthread_mutex_check_init, __xn_exec_any},
Index: b/ksrc/skins/posix/thread.c
===================================================================
--- a/ksrc/skins/posix/thread.c
+++ b/ksrc/skins/posix/thread.c
@@ -209,7 +209,7 @@ int pthread_create(pthread_t *tid,
 	thread->magic = PSE51_THREAD_MAGIC;
 	thread->entry = start;
 	thread->arg = arg;
-	xnsynch_init(&thread->join_synch, XNSYNCH_PRIO);
+	xnsynch_init(&thread->join_synch, XNSYNCH_PRIO, NULL);
 	thread->nrt_joiners = 0;
 
 	pse51_cancel_init_thread(thread);
@@ -234,7 +234,7 @@ int pthread_create(pthread_t *tid,
 	thread->hkey.mm = NULL;
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 	/* We need an anonymous registry entry to obtain a handle for fast
 	   mutex locking. */
 	{
@@ -244,7 +244,7 @@ int pthread_create(pthread_t *tid,
 			return err;
 		}
 	}
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	*tid = thread;		/* Must be done before the thread is started. */
 
Index: b/ksrc/skins/psos+/Kconfig
===================================================================
--- a/ksrc/skins/psos+/Kconfig
+++ b/ksrc/skins/psos+/Kconfig
@@ -2,7 +2,7 @@ menuconfig XENO_SKIN_PSOS
 	depends on XENO_OPT_NUCLEUS
 	select XENO_OPT_TIMING_PERIODIC
 	tristate "pSOS+ emulator"
-	select XENO_OPT_REGISTRY if XENO_OPT_PERVASIVE || XENO_FASTSEM
+	select XENO_OPT_REGISTRY if XENO_OPT_PERVASIVE || XENO_FASTSYNCH
 	help
 
 	This API skin emulates WindRiver's pSOS+ operating system.
Index: b/ksrc/skins/rtai/Kconfig
===================================================================
--- a/ksrc/skins/rtai/Kconfig
+++ b/ksrc/skins/rtai/Kconfig
@@ -1,6 +1,6 @@
 menuconfig XENO_SKIN_RTAI
 	depends on XENO_OPT_NUCLEUS
-	select XENO_OPT_REGISTRY if XENO_FASTSEM
+	select XENO_OPT_REGISTRY if XENO_FASTSYNCH
 	tristate "RTAI emulator"
 	help
 
Index: b/ksrc/skins/rtai/task.c
===================================================================
--- a/ksrc/skins/rtai/task.c
+++ b/ksrc/skins/rtai/task.c
@@ -152,7 +152,7 @@ int rt_task_init(RT_TASK *task,
 	task->magic = RTAI_TASK_MAGIC;
 	appendq(&__rtai_task_q, &task->link);
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 	/* We need an anonymous registry entry to obtain a handle for fast
 	   mutex locking. */
 	err = xnthread_register(&task->thread_base, "");
@@ -160,7 +160,7 @@ int rt_task_init(RT_TASK *task,
 		xnpod_abort_thread(&task->thread_base);
 		goto unlock_and_exit;
 	}
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	/* Add a switch hook only if a signal function has been declared
 	   at least once for some created task. */
Index: b/ksrc/skins/uitron/Kconfig
===================================================================
--- a/ksrc/skins/uitron/Kconfig
+++ b/ksrc/skins/uitron/Kconfig
@@ -2,7 +2,7 @@ menuconfig XENO_SKIN_UITRON
 	depends on XENO_OPT_NUCLEUS
 	select XENO_OPT_TIMING_PERIODIC
 	select XENO_OPT_MAP
-	select XENO_OPT_REGISTRY if XENO_FASTSEM
+	select XENO_OPT_REGISTRY if XENO_FASTSYNCH
 	tristate "uITRON API"
 	help
 
Index: b/ksrc/skins/uitron/task.c
===================================================================
--- a/ksrc/skins/uitron/task.c
+++ b/ksrc/skins/uitron/task.c
@@ -150,7 +150,7 @@ ER cre_tsk(ID tskid, T_CTSK *pk_ctsk)
 	xnlock_put_irqrestore(&nklock, s);
 	task->magic = uITRON_TASK_MAGIC;
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 	/* We need an anonymous registry entry to obtain a handle for fast
 	   mutex locking. */
 	if (xnthread_register(&task->threadbase, "")) {
@@ -158,7 +158,7 @@ ER cre_tsk(ID tskid, T_CTSK *pk_ctsk)
 		xnpod_abort_thread(&task->threadbase);
 		return E_NOMEM;
 	}
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	return E_OK;
 }
Index: b/ksrc/skins/vrtx/Kconfig
===================================================================
--- a/ksrc/skins/vrtx/Kconfig
+++ b/ksrc/skins/vrtx/Kconfig
@@ -3,7 +3,7 @@ menuconfig XENO_SKIN_VRTX
 	select XENO_OPT_TIMING_PERIODIC
 	select XENO_OPT_MAP
 	tristate "VRTX emulator"
-	select XENO_OPT_REGISTRY if XENO_OPT_PERVASIVE || CONFIG_XENO_FASTSEM
+	select XENO_OPT_REGISTRY if XENO_OPT_PERVASIVE || CONFIG_XENO_FASTSYNCH
 	help
 
 	This API skin emulates Mentor Graphics's VRTX operating
Index: b/ksrc/skins/vxworks/Kconfig
===================================================================
--- a/ksrc/skins/vxworks/Kconfig
+++ b/ksrc/skins/vxworks/Kconfig
@@ -2,7 +2,7 @@ menuconfig XENO_SKIN_VXWORKS
 	depends on XENO_OPT_NUCLEUS
 	select XENO_OPT_TIMING_PERIODIC
 	tristate "VxWorks emulator"
-	select XENO_OPT_REGISTRY if XENO_OPT_PERVASIVE || XENO_FASTSEM
+	select XENO_OPT_REGISTRY if XENO_OPT_PERVASIVE || XENO_FASTSYNCH
 	help
 
 	This API skin emulates WindRiver's VxWorks operating system.
Index: b/src/skins/posix/mutex.c
===================================================================
--- a/src/skins/posix/mutex.c
+++ b/src/skins/posix/mutex.c
@@ -26,7 +26,7 @@
 
 extern int __pse51_muxid;
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 #define PSE51_MUTEX_MAGIC (0x86860303)
 
 extern unsigned long xeno_sem_heap[2];
@@ -38,7 +38,7 @@ static xnarch_atomic_t *get_ownerp(struc
 	
 	return (xnarch_atomic_t *) (xeno_sem_heap[1] + shadow->owner_offset);
 }
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 int __wrap_pthread_mutexattr_init(pthread_mutexattr_t *attr)
 {
@@ -98,7 +98,7 @@ int __wrap_pthread_mutex_init(pthread_mu
 	struct __shadow_mutex *shadow = &_mutex->shadow_mutex;
 	int err;
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 	if (unlikely(cb_try_read_lock(&shadow->lock, s)))
 		goto checked;
 
@@ -111,17 +111,17 @@ int __wrap_pthread_mutex_init(pthread_mu
 
   checked:
 	cb_force_write_lock(&shadow->lock, s);
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	err = -XENOMAI_SKINCALL2(__pse51_muxid,__pse51_mutex_init,shadow,attr);
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 	if (!shadow->attr.pshared)
 		shadow->owner = (xnarch_atomic_t *)
 			(xeno_sem_heap[0] + shadow->owner_offset);
 	
 	cb_write_unlock(&shadow->lock, s);
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	return err;
 }
@@ -148,7 +148,7 @@ int __wrap_pthread_mutex_lock(pthread_mu
 	struct __shadow_mutex *shadow = &_mutex->shadow_mutex;
 	int err = 0;
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 	xnhandle_t cur, owner;
 
 	cur = xeno_get_current();
@@ -188,16 +188,16 @@ int __wrap_pthread_mutex_lock(pthread_mu
 			++shadow->lockcnt;
 			goto out;
 		}
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	do {
 		err = XENOMAI_SKINCALL1(__pse51_muxid,__pse51_mutex_lock,shadow);
 	} while (err == -EINTR);
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
   out:
 	cb_read_unlock(&shadow->lock, s);
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	return -err;
 }
@@ -209,7 +209,7 @@ int __wrap_pthread_mutex_timedlock(pthre
 	struct __shadow_mutex *shadow = &_mutex->shadow_mutex;
 	int err = 0;
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 	xnhandle_t cur, owner;
 
 	cur = xeno_get_current();
@@ -249,17 +249,17 @@ int __wrap_pthread_mutex_timedlock(pthre
 			++shadow->lockcnt;
 			goto out;
 		}
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	do {
 		err = XENOMAI_SKINCALL2(__pse51_muxid,
 					__pse51_mutex_timedlock, shadow, to);
 	} while (err == -EINTR);
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
   out:
 	cb_read_unlock(&shadow->lock, s);
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	return -err;
 }
@@ -270,7 +270,7 @@ int __wrap_pthread_mutex_trylock(pthread
 	struct __shadow_mutex *shadow = &_mutex->shadow_mutex;
 	int err = 0;
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 	xnhandle_t cur, owner;
 
 	cur = xeno_get_current();
@@ -306,14 +306,14 @@ int __wrap_pthread_mutex_trylock(pthread
   out:
 	cb_read_unlock(&shadow->lock, s);
 
-#else /* !CONFIG_XENO_FASTSEM */
+#else /* !CONFIG_XENO_FASTSYNCH */
 
 	do {
 		err = XENOMAI_SKINCALL1(__pse51_muxid,
 					__pse51_mutex_trylock, shadow);
 	} while (err == -EINTR);
 
-#endif /* !CONFIG_XENO_FASTSEM */
+#endif /* !CONFIG_XENO_FASTSYNCH */
 
 	return -err;
 }
@@ -324,7 +324,7 @@ int __wrap_pthread_mutex_unlock(pthread_
 	struct __shadow_mutex *shadow = &_mutex->shadow_mutex;
 	int err = 0;
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 	xnarch_atomic_t *ownerp;
 	xnhandle_t cur, owner;
 
@@ -358,17 +358,17 @@ int __wrap_pthread_mutex_unlock(pthread_
 		cb_read_unlock(&shadow->lock, s);
 		return 0;
 	}
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	do {
 		err = XENOMAI_SKINCALL1(__pse51_muxid,
 					__pse51_mutex_unlock, shadow);
 	} while (err == -EINTR);
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
   out_err:
 	cb_read_unlock(&shadow->lock, s);
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	return -err;
 }
Index: b/ksrc/nucleus/pipe.c
===================================================================
--- a/ksrc/nucleus/pipe.c
+++ b/ksrc/nucleus/pipe.c
@@ -250,7 +250,7 @@ int xnpipe_connect(int minor,
 
 	__setbits(state->status, XNPIPE_KERN_CONN);
 
-	xnsynch_init(&state->synchbase, XNSYNCH_FIFO);
+	xnsynch_init(&state->synchbase, XNSYNCH_FIFO, NULL);
 	state->output_handler = output_handler;
 	state->input_handler = input_handler;
 	state->alloc_handler = alloc_handler;
Index: b/ksrc/nucleus/registry.c
===================================================================
--- a/ksrc/nucleus/registry.c
+++ b/ksrc/nucleus/registry.c
@@ -186,7 +186,7 @@ int xnregistry_init(void)
 	for (n = 0; n < registry_hash_entries; n++)
 		registry_hash_table[n] = NULL;
 
-	xnsynch_init(&registry_hash_synch, XNSYNCH_FIFO);
+	xnsynch_init(&registry_hash_synch, XNSYNCH_FIFO, NULL);
 
 	return 0;
 }
@@ -615,7 +615,7 @@ int xnregistry_enter(const char *key,
 
 	object = link2xnobj(holder);
 
-	xnsynch_init(&object->safesynch, XNSYNCH_FIFO);
+	xnsynch_init(&object->safesynch, XNSYNCH_FIFO, NULL);
 	object->objaddr = objaddr;
 	object->cstamp = ++registry_obj_stamp;
 	object->safelock = 0;
Index: b/ksrc/nucleus/select.c
===================================================================
--- a/ksrc/nucleus/select.c
+++ b/ksrc/nucleus/select.c
@@ -274,7 +274,7 @@ int xnselector_init(struct xnselector *s
 {
 	unsigned i;
 
-	xnsynch_init(&selector->synchbase, XNSYNCH_FIFO | XNSYNCH_NOPIP);
+	xnsynch_init(&selector->synchbase, XNSYNCH_FIFO, NULL);
 	for (i = 0; i < XNSELECT_MAX_TYPES; i++) {
 		__FD_ZERO(&selector->fds[i].expected);
 		__FD_ZERO(&selector->fds[i].pending);
Index: b/ksrc/nucleus/synch.c
===================================================================
--- a/ksrc/nucleus/synch.c
+++ b/ksrc/nucleus/synch.c
@@ -37,7 +37,9 @@
 #include <nucleus/module.h>
 
 /*! 
- * \fn void xnsynch_init(xnsynch_t *synch, xnflags_t flags);
+ * \fn void xnsynch_init(xnsynch_t *synch, xnflags_t flags,
+ *                       xnarch_atomic_t *fastlock)
+ *
  * \brief Initialize a synchronization object.
  *
  * Initializes a new specialized object which can subsequently be used
@@ -79,6 +81,10 @@
  * synchronization object makes the waiters wait by priority order on
  * the awaited resource (XNSYNCH_PRIO).
  *
+ * @param fastlock Address of the fast lock word to be associated with
+ * the synchronization object. If NULL is passed or XNSYNCH_OWNER is not
+ * set, fast-lock support is disabled.
+ *
  * Environments:
  *
  * This service can be called from:
@@ -90,7 +96,7 @@
  * Rescheduling: never.
  */
 
-void xnsynch_init(xnsynch_t *synch, xnflags_t flags)
+void xnsynch_init(xnsynch_t *synch, xnflags_t flags, xnarch_atomic_t *fastlock)
 {
 	initph(&synch->link);
 
@@ -100,6 +106,13 @@ void xnsynch_init(xnsynch_t *synch, xnfl
 	synch->status = flags & ~XNSYNCH_CLAIMED;
 	synch->owner = NULL;
 	synch->cleanup = NULL;	/* Only works for PIP-enabled objects. */
+#ifdef CONFIG_XENO_FASTSYNCH
+	if ((flags & XNSYNCH_OWNER) && fastlock) {
+		synch->fastlock = fastlock;
+		xnarch_atomic_set(fastlock, XN_NO_HANDLE);
+	} else
+		synch->fastlock = NULL;
+#endif /* CONFIG_XENO_FASTSYNCH */
 	initpq(&synch->pendq);
 	xnarch_init_display_context(synch);
 }
@@ -379,36 +392,87 @@ void xnsynch_acquire(xnsynch_t *synch, x
 		     xntmode_t timeout_mode)
 {
 	xnthread_t *thread = xnpod_current_thread(), *owner;
+	xnhandle_t threadh = xnthread_handle(thread), fastlock, old;
+	const int use_fastlock = xnsynch_fastlock_p(synch);
 	spl_t s;
 
 	XENO_BUGON(NUCLEUS, !testbits(synch->status, XNSYNCH_OWNER));
 
-	xnlock_get_irqsave(&nklock, s);
-
 	trace_mark(xn_nucleus_synch_acquire, "synch %p", synch);
 
-redo:
-	owner = synch->owner;
+      redo:
 
-	if (!owner) {
-		synch->owner = thread;
-		xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK);
-		goto unlock_and_exit;
-	}
+	if (use_fastlock) {
+		fastlock = xnarch_atomic_cmpxchg(xnsynch_fastlock(synch),
+						 XN_NO_HANDLE, threadh);
+
+		if (likely(fastlock == XN_NO_HANDLE)) {
+			xnthread_clear_info(thread,
+					    XNRMID | XNTIMEO | XNBREAK);
+			return;
+		}
 
-	if (!testbits(synch->status, XNSYNCH_PRIO)) { /* i.e. FIFO */
-		appendpq(&synch->pendq, &thread->plink);
-		xnpod_suspend_thread(thread, XNPEND, timeout, timeout_mode, synch);
-		goto unlock_and_exit;
+		xnlock_get_irqsave(&nklock, s);
+
+		/* Set claimed bit.
+		   In case it appears to be set already, re-read its state
+		   under nklock so that we don't miss any change between the
+		   lock-less read and here. But also try to avoid cmpxchg
+		   where possible. Only if it appears not to be set, start
+		   with cmpxchg directly. */
+		if (xnsynch_fast_is_claimed(fastlock)) {
+			old = xnarch_atomic_get(xnsynch_fastlock(synch));
+			goto test_no_owner;
+		}
+		do {
+			old = xnarch_atomic_cmpxchg
+				(xnsynch_fastlock(synch), fastlock,
+				 xnsynch_fast_set_claimed(fastlock, 1));
+			if (likely(old == fastlock))
+				break;
+
+		  test_no_owner:
+			if (old == XN_NO_HANDLE) {
+				/* Owner called xnsynch_release
+				   (on another cpu) */
+				xnlock_put_irqrestore(&nklock, s);
+				goto redo;
+			}
+			fastlock = old;
+		} while (!xnsynch_fast_is_claimed(fastlock));
+
+		owner = xnthread_lookup(xnsynch_fast_mask_claimed(fastlock));
+
+		if (!owner) {
+			/* The handle is broken, therefore pretend that the synch
+			   object was deleted to signal an error. */
+			xnthread_set_info(thread, XNRMID);
+			goto unlock_and_exit;
+		}
+
+		xnsynch_set_owner(synch, owner);
+	} else {
+		xnlock_get_irqsave(&nklock, s);
+
+		owner = synch->owner;
+
+		if (!owner) {
+			synch->owner = thread;
+			xnthread_clear_info(thread,
+					    XNRMID | XNTIMEO | XNBREAK);
+			goto unlock_and_exit;
+		}
 	}
 
-	if (thread->cprio > owner->cprio) {
+	if (!testbits(synch->status, XNSYNCH_PRIO)) /* i.e. FIFO */
+		appendpq(&synch->pendq, &thread->plink);
+	else if (thread->cprio > owner->cprio) {
 		if (xnthread_test_info(owner, XNWAKEN) && owner->wwake == synch) {
 			/* Ownership is still pending, steal the resource. */
 			synch->owner = thread;
 			xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK);
 			xnthread_set_info(owner, XNROBBED);
-			goto unlock_and_exit;
+			goto grab_and_exit;
 		}
 
 		insertpqf(&synch->pendq, &thread->plink, thread->cprio);
@@ -439,12 +503,28 @@ redo:
 		/* Somebody stole us the ownership while we were ready
 		   to run, waiting for the CPU: we need to wait again
 		   for the resource. */
-		if (timeout_mode != XN_RELATIVE || timeout == XN_INFINITE)
+		if (timeout_mode != XN_RELATIVE || timeout == XN_INFINITE) {
+			xnlock_put_irqrestore(&nklock, s);
 			goto redo;
+		}
 		timeout = xntimer_get_timeout_stopped(&thread->rtimer);
-		if (timeout > 1) /* Otherwise, it's too late. */
+		if (timeout > 1) { /* Otherwise, it's too late. */
+			xnlock_put_irqrestore(&nklock, s);
 			goto redo;
+		}
 		xnthread_set_info(thread, XNTIMEO);
+	} else {
+
+	      grab_and_exit:
+
+		if (use_fastlock) {
+			/* We are the new owner, update the fastlock
+			   accordingly. */
+			if (xnsynch_pended_p(synch))
+				threadh =
+				    xnsynch_fast_set_claimed(threadh, 1);
+			xnarch_atomic_set(xnsynch_fastlock(synch), threadh);
+		}
 	}
 
       unlock_and_exit:
@@ -582,12 +662,20 @@ void xnsynch_renice_sleeper(xnthread_t *
 
 struct xnthread *xnsynch_release(xnsynch_t *synch)
 {
+	const int use_fastlock = xnsynch_fastlock_p(synch);
 	xnthread_t *newowner, *lastowner;
+	xnhandle_t lastownerh, newownerh;
 	xnpholder_t *holder;
 	spl_t s;
 
 	XENO_BUGON(NUCLEUS, !testbits(synch->status, XNSYNCH_OWNER));
 
+	lastownerh = xnthread_handle(xnpod_current_thread());
+
+	if (use_fastlock &&
+	    likely(xnsynch_fast_release(xnsynch_fastlock(synch), lastownerh)))
+		return NULL;
+
 	xnlock_get_irqsave(&nklock, s);
 
 	trace_mark(xn_nucleus_synch_release, "synch %p", synch);
@@ -605,10 +693,16 @@ struct xnthread *xnsynch_release(xnsynch
 
 		if (testbits(synch->status, XNSYNCH_CLAIMED))
 			xnsynch_clear_boost(synch, lastowner);
+
+		newownerh = xnsynch_fast_set_claimed(xnthread_handle(newowner),
+						     xnsynch_pended_p(synch));
 	} else {
 		newowner = NULL;
 		synch->owner = NULL;
+		newownerh = XN_NO_HANDLE;
 	}
+	if (use_fastlock)
+		xnarch_atomic_set(xnsynch_fastlock(synch), newownerh);
 
 	xnlock_put_irqrestore(&nklock, s);
 
Index: b/ksrc/drivers/testing/switchtest.c
===================================================================
--- a/ksrc/drivers/testing/switchtest.c
+++ b/ksrc/drivers/testing/switchtest.c
@@ -219,7 +219,7 @@ static int rtswitch_register_task(rtswit
 	ctx->next_index++;
 	t->base = *arg;
 	sema_init(&t->nrt_synch, 0);
-	xnsynch_init(&t->rt_synch, XNSYNCH_FIFO);
+	xnsynch_init(&t->rt_synch, XNSYNCH_FIFO, NULL);
 
 	up(&ctx->lock);
 
Index: b/ksrc/skins/native/alarm.c
===================================================================
--- a/ksrc/skins/native/alarm.c
+++ b/ksrc/skins/native/alarm.c
@@ -207,7 +207,7 @@ int rt_alarm_create(RT_ALARM *alarm,
 	xnlock_put_irqrestore(&nklock, s);
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
-	xnsynch_init(&alarm->synch_base, XNSYNCH_PRIO);
+	xnsynch_init(&alarm->synch_base, XNSYNCH_PRIO, NULL);
 	alarm->cpid = 0;
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
Index: b/ksrc/skins/native/buffer.c
===================================================================
--- a/ksrc/skins/native/buffer.c
+++ b/ksrc/skins/native/buffer.c
@@ -192,8 +192,8 @@ int rt_buffer_create(RT_BUFFER *bf, cons
 	if (bf->bufmem == NULL)
 		return -ENOMEM;
 
-	xnsynch_init(&bf->isynch_base, mode & B_PRIO);
-	xnsynch_init(&bf->osynch_base, mode & B_PRIO);
+	xnsynch_init(&bf->isynch_base, mode & B_PRIO, NULL);
+	xnsynch_init(&bf->osynch_base, mode & B_PRIO, NULL);
 
 	bf->handle = 0;	/* i.e. (still) unregistered buffer. */
 	xnobject_copy_name(bf->name, name);
Index: b/ksrc/skins/native/cond.c
===================================================================
--- a/ksrc/skins/native/cond.c
+++ b/ksrc/skins/native/cond.c
@@ -160,7 +160,7 @@ int rt_cond_create(RT_COND *cond, const
 	if (xnpod_asynch_p())
 		return -EPERM;
 
-	xnsynch_init(&cond->synch_base, XNSYNCH_PRIO);
+	xnsynch_init(&cond->synch_base, XNSYNCH_PRIO, NULL);
 	cond->handle = 0;	/* i.e. (still) unregistered cond. */
 	cond->magic = XENO_COND_MAGIC;
 	xnobject_copy_name(cond->name, name);
Index: b/ksrc/skins/native/event.c
===================================================================
--- a/ksrc/skins/native/event.c
+++ b/ksrc/skins/native/event.c
@@ -183,7 +183,7 @@ int rt_event_create(RT_EVENT *event,
 	if (xnpod_asynch_p())
 		return -EPERM;
 
-	xnsynch_init(&event->synch_base, mode & EV_PRIO);
+	xnsynch_init(&event->synch_base, mode & EV_PRIO, NULL);
 	event->value = ivalue;
 	event->handle = 0;	/* i.e. (still) unregistered event. */
 	event->magic = XENO_EVENT_MAGIC;
Index: b/ksrc/skins/native/heap.c
===================================================================
--- a/ksrc/skins/native/heap.c
+++ b/ksrc/skins/native/heap.c
@@ -292,7 +292,7 @@ int rt_heap_create(RT_HEAP *heap, const
 		}
 	}
 
-	xnsynch_init(&heap->synch_base, mode & (H_PRIO | H_FIFO));
+	xnsynch_init(&heap->synch_base, mode & (H_PRIO | H_FIFO), NULL);
 	heap->handle = 0;	/* i.e. (still) unregistered heap. */
 	heap->magic = XENO_HEAP_MAGIC;
 	heap->mode = mode;
Index: b/ksrc/skins/native/intr.c
===================================================================
--- a/ksrc/skins/native/intr.c
+++ b/ksrc/skins/native/intr.c
@@ -266,7 +266,7 @@ int rt_intr_create(RT_INTR *intr,
 
 	xnintr_init(&intr->intr_base, intr->name, irq, isr, iack, mode);
 #ifdef CONFIG_XENO_OPT_PERVASIVE
-	xnsynch_init(&intr->synch_base, XNSYNCH_PRIO);
+	xnsynch_init(&intr->synch_base, XNSYNCH_PRIO, NULL);
 	intr->pending = 0;
 	intr->cpid = 0;
 	intr->mode = 0;
Index: b/ksrc/skins/native/mutex.c
===================================================================
--- a/ksrc/skins/native/mutex.c
+++ b/ksrc/skins/native/mutex.c
@@ -171,7 +171,7 @@ int rt_mutex_create(RT_MUTEX *mutex, con
 		return -EPERM;
 
 	xnsynch_init(&mutex->synch_base,
-		     XNSYNCH_PRIO | XNSYNCH_PIP | XNSYNCH_OWNER);
+		     XNSYNCH_PRIO | XNSYNCH_PIP | XNSYNCH_OWNER, NULL);
 	mutex->handle = 0;	/* i.e. (still) unregistered mutex. */
 	mutex->magic = XENO_MUTEX_MAGIC;
 	mutex->lockcnt = 0;
Index: b/ksrc/skins/native/queue.c
===================================================================
--- a/ksrc/skins/native/queue.c
+++ b/ksrc/skins/native/queue.c
@@ -255,7 +255,7 @@ int rt_queue_create(RT_QUEUE *q,
 		}
 	}
 
-	xnsynch_init(&q->synch_base, mode & (Q_PRIO | Q_FIFO));
+	xnsynch_init(&q->synch_base, mode & (Q_PRIO | Q_FIFO), NULL);
 	initq(&q->pendq);
 	q->handle = 0;		/* i.e. (still) unregistered queue. */
 	q->magic = XENO_QUEUE_MAGIC;
Index: b/ksrc/skins/native/sem.c
===================================================================
--- a/ksrc/skins/native/sem.c
+++ b/ksrc/skins/native/sem.c
@@ -181,7 +181,7 @@ int rt_sem_create(RT_SEM *sem, const cha
 	if ((mode & S_PULSE) && icount > 0)
 		return -EINVAL;
 
-	xnsynch_init(&sem->synch_base, mode & S_PRIO);
+	xnsynch_init(&sem->synch_base, mode & S_PRIO, NULL);
 	sem->count = icount;
 	sem->mode = mode;
 	sem->handle = 0;	/* i.e. (still) unregistered semaphore. */
Index: b/ksrc/skins/native/task.c
===================================================================
--- a/ksrc/skins/native/task.c
+++ b/ksrc/skins/native/task.c
@@ -255,7 +255,7 @@ int rt_task_create(RT_TASK *task,
 	task->overrun = -1;
 	task->cstamp = ++__xeno_task_stamp;
 	task->safelock = 0;
-	xnsynch_init(&task->safesynch, XNSYNCH_FIFO);
+	xnsynch_init(&task->safesynch, XNSYNCH_FIFO, NULL);
 
 	xnarch_cpus_clear(task->affinity);
 
@@ -268,9 +268,9 @@ int rt_task_create(RT_TASK *task,
 		task->affinity = XNPOD_ALL_CPUS;
 
 #ifdef CONFIG_XENO_OPT_NATIVE_MPS
-	xnsynch_init(&task->mrecv, XNSYNCH_FIFO);
+	xnsynch_init(&task->mrecv, XNSYNCH_FIFO, NULL);
 	xnsynch_init(&task->msendq,
-		     XNSYNCH_PRIO | XNSYNCH_PIP | XNSYNCH_OWNER);
+		     XNSYNCH_PRIO | XNSYNCH_PIP | XNSYNCH_OWNER, NULL);
 	xnsynch_set_owner(&task->msendq, &task->thread_base);
 	task->flowgen = 0;
 #endif /* CONFIG_XENO_OPT_NATIVE_MPS */
Index: b/ksrc/skins/posix/intr.c
===================================================================
--- a/ksrc/skins/posix/intr.c
+++ b/ksrc/skins/posix/intr.c
@@ -116,7 +116,7 @@ int pthread_intr_attach_np(pthread_intr_
 	xnintr_init(&intr->intr_base, NULL, irq, isr, iack, 0);
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
-	xnsynch_init(&intr->synch_base, XNSYNCH_PRIO);
+	xnsynch_init(&intr->synch_base, XNSYNCH_PRIO, NULL);
 	intr->pending = 0;
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 	intr->magic = PSE51_INTR_MAGIC;
Index: b/ksrc/skins/posix/mq.c
===================================================================
--- a/ksrc/skins/posix/mq.c
+++ b/ksrc/skins/posix/mq.c
@@ -129,8 +129,8 @@ static int pse51_mq_init(pse51_mq_t * mq
 
 	mq->memsize = memsize;
 	initpq(&mq->queued);
-	xnsynch_init(&mq->receivers, XNSYNCH_PRIO | XNSYNCH_NOPIP);
-	xnsynch_init(&mq->senders, XNSYNCH_PRIO | XNSYNCH_NOPIP);
+	xnsynch_init(&mq->receivers, XNSYNCH_PRIO | XNSYNCH_NOPIP, NULL);
+	xnsynch_init(&mq->senders, XNSYNCH_PRIO | XNSYNCH_NOPIP, NULL);
 	mq->mem = mem;
 
 	/* Fill the pool. */
Index: b/ksrc/skins/posix/sem.c
===================================================================
--- a/ksrc/skins/posix/sem.c
+++ b/ksrc/skins/posix/sem.c
@@ -99,7 +99,7 @@ static int pse51_sem_init_inner(pse51_se
 
 	inith(&sem->link);
 	appendq(&pse51_kqueues(pshared)->semq, &sem->link);
-	xnsynch_init(&sem->synchbase, XNSYNCH_PRIO);
+	xnsynch_init(&sem->synchbase, XNSYNCH_PRIO, NULL);
 	sem->value = value;
 	sem->pshared = pshared;
 	sem->is_named = 0;
Index: b/ksrc/skins/psos+/event.c
===================================================================
--- a/ksrc/skins/psos+/event.c
+++ b/ksrc/skins/psos+/event.c
@@ -21,7 +21,7 @@
 
 void taskev_init(psosevent_t *evgroup)
 {
-	xnsynch_init(&evgroup->synchbase, XNSYNCH_FIFO);
+	xnsynch_init(&evgroup->synchbase, XNSYNCH_FIFO, NULL);
 	evgroup->events = 0;
 }
 
Index: b/ksrc/skins/psos+/queue.c
===================================================================
--- a/ksrc/skins/psos+/queue.c
+++ b/ksrc/skins/psos+/queue.c
@@ -259,7 +259,7 @@ static u_long q_create_internal(const ch
 		}
 	}
 
-	xnsynch_init(&queue->synchbase, bflags);
+	xnsynch_init(&queue->synchbase, bflags, NULL);
 
 	queue->magic = PSOS_QUEUE_MAGIC;
 	xnobject_copy_name(queue->name, name);
Index: b/ksrc/skins/psos+/rn.c
===================================================================
--- a/ksrc/skins/psos+/rn.c
+++ b/ksrc/skins/psos+/rn.c
@@ -214,7 +214,7 @@ u_long rn_create(const char *name,
 	rn->usize = usize;
 	xnobject_copy_name(rn->name, name);
 
-	xnsynch_init(&rn->synchbase, bflags);
+	xnsynch_init(&rn->synchbase, bflags, NULL);
 	rn->magic = PSOS_RN_MAGIC;
 
 	inith(&rn->rlink);
Index: b/ksrc/skins/psos+/sem.c
===================================================================
--- a/ksrc/skins/psos+/sem.c
+++ b/ksrc/skins/psos+/sem.c
@@ -114,7 +114,7 @@ u_long sm_create(const char *name, u_lon
 	if (flags & SM_PRIOR)
 		bflags |= XNSYNCH_PRIO;
 
-	xnsynch_init(&sem->synchbase, bflags);
+	xnsynch_init(&sem->synchbase, bflags, NULL);
 
 	inith(&sem->link);
 	sem->count = icount;
Index: b/ksrc/skins/rtai/sem.c
===================================================================
--- a/ksrc/skins/rtai/sem.c
+++ b/ksrc/skins/rtai/sem.c
@@ -38,7 +38,7 @@ void rt_typed_sem_init(SEM * sem, int va
 			mode = XNSYNCH_FIFO;
 	}
 
-	xnsynch_init(&sem->synch_base, mode);
+	xnsynch_init(&sem->synch_base, mode, NULL);
 	sem->count = value;
 	sem->type = type & 0x3;
 	sem->owner = NULL;
Index: b/ksrc/skins/rtdm/drvlib.c
===================================================================
--- a/ksrc/skins/rtdm/drvlib.c
+++ b/ksrc/skins/rtdm/drvlib.c
@@ -145,13 +145,13 @@ int rtdm_task_init(rtdm_task_t *task, co
 	if (err)
 		return err;
 
-#ifdef CONFIG_XENO_FASTSEM
+#ifdef CONFIG_XENO_FASTSYNCH
 	/* We need an anonymous registry entry to obtain a handle for fast
 	   mutex locking. */
 	err = xnthread_register(task, "");
 	if (err)
 		goto cleanup_out;
-#endif /* CONFIG_XENO_FASTSEM */
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 	if (period > 0) {
 		err = xnpod_set_thread_periodic(task, XN_INFINITE,
@@ -761,7 +761,7 @@ void rtdm_event_init(rtdm_event_t *event
 	/* Make atomic for re-initialisation support */
 	xnlock_get_irqsave(&nklock, s);
 
-	xnsynch_init(&event->synch_base, XNSYNCH_PRIO);
+	xnsynch_init(&event->synch_base, XNSYNCH_PRIO, NULL);
 	if (pending)
 		xnsynch_set_flags(&event->synch_base, RTDM_EVENT_PENDING);
 	xnselect_init(&event->select_block);
@@ -1109,7 +1109,7 @@ void rtdm_sem_init(rtdm_sem_t *sem, unsi
 	xnlock_get_irqsave(&nklock, s);
 
 	sem->value = value;
-	xnsynch_init(&sem->synch_base, XNSYNCH_PRIO);
+	xnsynch_init(&sem->synch_base, XNSYNCH_PRIO, NULL);
 	xnselect_init(&sem->select_block);
 
 	xnlock_put_irqrestore(&nklock, s);
@@ -1391,7 +1391,7 @@ void rtdm_mutex_init(rtdm_mutex_t *mutex
 	xnlock_get_irqsave(&nklock, s);
 
 	xnsynch_init(&mutex->synch_base,
-		     XNSYNCH_PRIO | XNSYNCH_PIP | XNSYNCH_OWNER);
+		     XNSYNCH_PRIO | XNSYNCH_PIP | XNSYNCH_OWNER, NULL);
 
 	xnlock_put_irqrestore(&nklock, s);
 }
Index: b/ksrc/skins/uitron/flag.c
===================================================================
--- a/ksrc/skins/uitron/flag.c
+++ b/ksrc/skins/uitron/flag.c
@@ -122,7 +122,7 @@ ER cre_flg(ID flgid, T_CFLG *pk_cflg)
 		return E_OBJ;
 	}
 
-	xnsynch_init(&flag->synchbase, XNSYNCH_FIFO);
+	xnsynch_init(&flag->synchbase, XNSYNCH_FIFO, NULL);
 	flag->id = flgid;
 	flag->exinf = pk_cflg->exinf;
 	flag->flgatr = pk_cflg->flgatr;
Index: b/ksrc/skins/uitron/mbx.c
===================================================================
--- a/ksrc/skins/uitron/mbx.c
+++ b/ksrc/skins/uitron/mbx.c
@@ -138,7 +138,8 @@ ER cre_mbx(ID mbxid, T_CMBX *pk_cmbx)
 	}
 
 	xnsynch_init(&mbx->synchbase,
-		     (pk_cmbx->mbxatr & TA_TPRI) ? XNSYNCH_PRIO : XNSYNCH_FIFO);
+		     (pk_cmbx->mbxatr & TA_TPRI) ? XNSYNCH_PRIO : XNSYNCH_FIFO,
+		     NULL);
 
 	mbx->id = mbxid;
 	mbx->exinf = pk_cmbx->exinf;
Index: b/ksrc/skins/uitron/sem.c
===================================================================
--- a/ksrc/skins/uitron/sem.c
+++ b/ksrc/skins/uitron/sem.c
@@ -127,7 +127,8 @@ ER cre_sem(ID semid, T_CSEM *pk_csem)
 	}
 
 	xnsynch_init(&sem->synchbase,
-		     (pk_csem->sematr & TA_TPRI) ? XNSYNCH_PRIO : XNSYNCH_FIFO);
+		     (pk_csem->sematr & TA_TPRI) ? XNSYNCH_PRIO : XNSYNCH_FIFO,
+		     NULL);
 
 	sem->id = semid;
 	sem->exinf = pk_csem->exinf;
Index: b/ksrc/skins/vrtx/event.c
===================================================================
--- a/ksrc/skins/vrtx/event.c
+++ b/ksrc/skins/vrtx/event.c
@@ -151,7 +151,7 @@ int sc_fcreate(int *errp)
 		goto nocb;
 	}
 
-	xnsynch_init(&evgroup->synchbase, XNSYNCH_PRIO | XNSYNCH_DREORD);
+	xnsynch_init(&evgroup->synchbase, XNSYNCH_PRIO | XNSYNCH_DREORD, NULL);
 	inith(&evgroup->link);
 	evgroup->evid = evid;
 	evgroup->magic = VRTX_EVENT_MAGIC;
Index: b/ksrc/skins/vrtx/mb.c
===================================================================
--- a/ksrc/skins/vrtx/mb.c
+++ b/ksrc/skins/vrtx/mb.c
@@ -210,7 +210,7 @@ vrtxmb_t *mb_map(char **mboxp)
 	mb->mboxp = mboxp;
 	mb->msg = NULL;
 	mb->hnext = NULL;
-	xnsynch_init(&mb->synchbase, XNSYNCH_PRIO | XNSYNCH_DREORD);
+	xnsynch_init(&mb->synchbase, XNSYNCH_PRIO | XNSYNCH_DREORD, NULL);
 	appendq(&vrtx_mbox_q, &mb->link);
 	mb_hash(mboxp, mb);
 
Index: b/ksrc/skins/vrtx/mx.c
===================================================================
--- a/ksrc/skins/vrtx/mx.c
+++ b/ksrc/skins/vrtx/mx.c
@@ -161,7 +161,8 @@ int sc_mcreate(unsigned int opt, int *er
 	inith(&mx->link);
 	mx->mid = mid;
 	mx->owner = NULL;
-	xnsynch_init(&mx->synchbase, bflags | XNSYNCH_DREORD | XNSYNCH_OWNER);
+	xnsynch_init(&mx->synchbase, bflags | XNSYNCH_DREORD | XNSYNCH_OWNER,
+		     NULL);
 
 	xnlock_get_irqsave(&nklock, s);
 	appendq(&vrtx_mx_q, &mx->link);
Index: b/ksrc/skins/vrtx/queue.c
===================================================================
--- a/ksrc/skins/vrtx/queue.c
+++ b/ksrc/skins/vrtx/queue.c
@@ -165,7 +165,7 @@ int sc_qecreate(int qid, int qsize, int
 		bflags = XNSYNCH_PRIO;
 
 	inith(&queue->link);
-	xnsynch_init(&queue->synchbase, bflags | XNSYNCH_DREORD);
+	xnsynch_init(&queue->synchbase, bflags | XNSYNCH_DREORD, NULL);
 	queue->magic = VRTX_QUEUE_MAGIC;
 	queue->qid = qid;
 	queue->qsize = qsize;
Index: b/ksrc/skins/vrtx/sem.c
===================================================================
--- a/ksrc/skins/vrtx/sem.c
+++ b/ksrc/skins/vrtx/sem.c
@@ -155,7 +155,7 @@ int sc_screate(unsigned initval, int opt
 	else
 		bflags = XNSYNCH_FIFO;
 
-	xnsynch_init(&sem->synchbase, bflags | XNSYNCH_DREORD);
+	xnsynch_init(&sem->synchbase, bflags | XNSYNCH_DREORD, NULL);
 	inith(&sem->link);
 	sem->semid = semid;
 	sem->magic = VRTX_SEM_MAGIC;
Index: b/ksrc/skins/vxworks/module.c
===================================================================
--- a/ksrc/skins/vxworks/module.c
+++ b/ksrc/skins/vxworks/module.c
@@ -59,7 +59,7 @@ int SKIN_INIT(vxworks)
 	/* The following fields are unused in the global holder;
 	   still, we initialize them not to leave such data in an
 	   invalid state. */
-	xnsynch_init(&__wind_global_rholder.wdsynch, XNSYNCH_FIFO);
+	xnsynch_init(&__wind_global_rholder.wdsynch, XNSYNCH_FIFO, NULL);
 	initq(&__wind_global_rholder.wdpending);
 	__wind_global_rholder.wdcount = 0;
 
Index: b/ksrc/skins/vxworks/msgQLib.c
===================================================================
--- a/ksrc/skins/vxworks/msgQLib.c
+++ b/ksrc/skins/vxworks/msgQLib.c
@@ -174,7 +174,7 @@ MSG_Q_ID msgQCreate(int nb_msgs, int len
 	if (flags & MSG_Q_PRIORITY)
 		bflags |= XNSYNCH_PRIO;
 
-	xnsynch_init(&queue->synchbase, bflags);
+	xnsynch_init(&queue->synchbase, bflags, NULL);
 
 	msg_size = sizeof(wind_msg_t) + length;
 
Index: b/ksrc/skins/vxworks/semLib.c
===================================================================
--- a/ksrc/skins/vxworks/semLib.c
+++ b/ksrc/skins/vxworks/semLib.c
@@ -423,7 +423,7 @@ static SEM_ID sem_create_internal(int fl
 
 	check_alloc(wind_sem_t, sem, return 0);
 
-	xnsynch_init(&sem->synchbase, (xnflags_t)flags);
+	xnsynch_init(&sem->synchbase, (xnflags_t)flags, NULL);
 	sem->magic = WIND_SEM_MAGIC;
 	sem->count = count;
 	sem->vtbl = vtbl;
Index: b/ksrc/skins/vxworks/syscall.c
===================================================================
--- a/ksrc/skins/vxworks/syscall.c
+++ b/ksrc/skins/vxworks/syscall.c
@@ -1171,7 +1171,7 @@ static void *__wind_shadow_eventcb(int e
 
 		initq(&rh->wdq);
 		/* A single server thread pends on this. */
-		xnsynch_init(&rh->wdsynch, XNSYNCH_FIFO);
+		xnsynch_init(&rh->wdsynch, XNSYNCH_FIFO, NULL);
 		initq(&rh->wdpending);
 		rh->wdcount = 0;
 		initq(&rh->msgQq);
Index: b/ksrc/skins/vxworks/taskLib.c
===================================================================
--- a/ksrc/skins/vxworks/taskLib.c
+++ b/ksrc/skins/vxworks/taskLib.c
@@ -146,7 +146,7 @@ STATUS taskInit(WIND_TCB *pTcb,
 	xnthread_time_slice(&pTcb->threadbase) = rrperiod;
 
 	pTcb->safecnt = 0;
-	xnsynch_init(&pTcb->safesync, 0);
+	xnsynch_init(&pTcb->safesync, 0, NULL);
 
 	/* TODO: fill in attributes of wind_task_t:
 	   pTcb->status


