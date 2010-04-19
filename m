From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Mon, 19 Apr 2010 16:00:22 +0200
Message-Id: <1271685622-13281-1-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4BCC619E.2@domain.hid>
References: <4BCC619E.2@domain.hid>
Subject: [Xenomai-core] [PATCH] debug: fix direct references to
	CONFIG_XENO_OPT_DEBUG_*
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <xenomai@xenomai.org>

We have some #ifdef CONFIG_XENO_OPT_DEBUG_FOO, it is incompatible with
XENO_DEBUG(FOO), XENO_BUGON(FOO, ...) etc... So, this commit:
- replaces these #ifdef with #if XENO_DEBUG(FOO)
- moves all the piece of code like:
to include/nucleus/assert.h, this avoids some code duplication, and allows
us to treat as an error remaining references to CONFIG_XENO_OPT_DEBUG_FOO
in other files than assert.h.
---
 include/asm-generic/system.h     |   10 ++----
 include/native/types.h           |    6 +---
 include/nucleus/assert.h         |   50 ++++++++++++++++++++++++++---
 include/nucleus/bheap.h          |    8 +---
 include/nucleus/heap.h           |    4 --
 include/nucleus/pod.h            |    8 ++--
 include/nucleus/queue.h          |    4 --
 include/nucleus/sched-sporadic.h |    4 --
 include/nucleus/sched.h          |    6 +---
 include/nucleus/synch.h          |    6 ++--
 include/nucleus/timer.h          |    4 --
 include/psos+/ppd.h              |    6 +---
 include/rtdm/rtdm_driver.h       |    4 --
 include/vxworks/ppd.h            |    6 +---
 ksrc/nucleus/bufd.c              |    6 +---
 ksrc/nucleus/pod.c               |   64 ++++++++++++++++++--------------------
 ksrc/nucleus/registry.c          |    6 +---
 ksrc/nucleus/sched.c             |   12 ++-----
 ksrc/nucleus/shadow.c            |   50 +++++++++++++----------------
 ksrc/nucleus/synch.c             |   24 ++++++--------
 ksrc/skins/posix/internal.h      |    6 +---
 ksrc/skins/rtdm/internal.h       |    4 --
 ksrc/skins/uitron/ppd.h          |    6 +---
 src/skins/native/mutex.c         |    2 +-
 24 files changed, 133 insertions(+), 173 deletions(-)

diff --git a/include/asm-generic/system.h b/include/asm-generic/system.h
index a2c8fb9..6a255c0 100644
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -44,10 +44,6 @@
 /* debug support */
 #include <nucleus/assert.h>
 
-#ifndef CONFIG_XENO_OPT_DEBUG_XNLOCK
-#define CONFIG_XENO_OPT_DEBUG_XNLOCK 0
-#endif
-
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -452,9 +448,9 @@ static inline int xnarch_remap_io_page_range(struct file *filp,
 					     unsigned long size,
 					     pgprot_t prot)
 {
- 	return wrap_remap_io_page_range(vma, from, to, size,
- 					wrap_phys_mem_prot(filp, (to) >> PAGE_SHIFT,
- 							   size, prot));
+	return wrap_remap_io_page_range(vma, from, to, size,
+					wrap_phys_mem_prot(filp, (to) >> PAGE_SHIFT,
+							   size, prot));
 }
 
 static inline int xnarch_remap_kmem_page_range(struct vm_area_struct *vma,
diff --git a/include/native/types.h b/include/native/types.h
index 0dd721f..daeedff 100644
--- a/include/native/types.h
+++ b/include/native/types.h
@@ -2,7 +2,7 @@
  * @file
  * This file is part of the Xenomai project.
  *
- * @note Copyright (C) 2004 Philippe Gerum <rpm@xenomai.org> 
+ * @note Copyright (C) 2004 Philippe Gerum <rpm@xenomai.org>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -32,10 +32,6 @@
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
-#ifndef CONFIG_XENO_OPT_DEBUG_NATIVE
-#define CONFIG_XENO_OPT_DEBUG_NATIVE  0
-#endif
-
 typedef xnticks_t RTIME;
 
 typedef xnsticks_t SRTIME;
diff --git a/include/nucleus/assert.h b/include/nucleus/assert.h
index 9cb88af..62bc329 100644
--- a/include/nucleus/assert.h
+++ b/include/nucleus/assert.h
@@ -26,16 +26,56 @@
 
 #define XENO_ASSERT(subsystem,cond,action)  do { \
     if (unlikely(CONFIG_XENO_OPT_DEBUG_##subsystem > 0 && !(cond))) { \
-        xnarch_trace_panic_freeze(); \
-        xnlogerr("assertion failed at %s:%d (%s)\n", __FILE__, __LINE__, (#cond)); \
-        xnarch_trace_panic_dump(); \
-        action; \
+	xnarch_trace_panic_freeze(); \
+	xnlogerr("assertion failed at %s:%d (%s)\n", __FILE__, __LINE__, (#cond)); \
+	xnarch_trace_panic_dump(); \
+	action; \
     } \
 } while(0)
 
 #define XENO_BUGON(subsystem,cond)  do { \
     if (unlikely(CONFIG_XENO_OPT_DEBUG_##subsystem > 0 && (cond))) \
-        xnpod_fatal("bug at %s:%d (%s)", __FILE__, __LINE__, (#cond)); \
+	xnpod_fatal("bug at %s:%d (%s)", __FILE__, __LINE__, (#cond)); \
 } while(0)
 
+#ifndef CONFIG_XENO_OPT_DEBUG_NATIVE
+#define CONFIG_XENO_OPT_DEBUG_NATIVE  0
+#endif /* CONFIG_XENO_OPT_DEBUG_NATIVE */
+#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
+#define CONFIG_XENO_OPT_DEBUG_NUCLEUS 0
+#endif /* CONFIG_XENO_OPT_DEBUG_NUCLEUS */
+#ifndef CONFIG_XENO_OPT_DEBUG_POSIX
+#define CONFIG_XENO_OPT_DEBUG_POSIX 0
+#endif /* CONFIG_XENO_OPT_DEBUG_POSIX */
+#ifndef CONFIG_XENO_OPT_DEBUG_PSOS
+#define CONFIG_XENO_OPT_DEBUG_PSOS  0
+#endif /* CONFIG_XENO_OPT_DEBUG_PSOS */
+#ifndef CONFIG_XENO_OPT_DEBUG_QUEUES
+#define CONFIG_XENO_OPT_DEBUG_QUEUES 0
+#endif /* CONFIG_XENO_OPT_DEBUG_QUEUES */
+#ifndef CONFIG_XENO_OPT_DEBUG_REGISTRY
+#define CONFIG_XENO_OPT_DEBUG_REGISTRY  0
+#endif /* CONFIG_XENO_OPT_DEBUG_REGISTRY */
+#ifndef CONFIG_XENO_OPT_DEBUG_RTDM
+#define CONFIG_XENO_OPT_DEBUG_RTDM	0
+#endif /* CONFIG_XENO_OPT_DEBUG_RTDM */
+#ifndef CONFIG_XENO_OPT_DEBUG_RTDM_APPL
+#define CONFIG_XENO_OPT_DEBUG_RTDM_APPL	0
+#endif /* CONFIG_XENO_OPT_DEBUG_RTDM_APPL */
+#ifndef CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX
+#define CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX 0
+#endif /* CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX */
+#ifndef CONFIG_XENO_OPT_DEBUG_TIMERS
+#define CONFIG_XENO_OPT_DEBUG_TIMERS  0
+#endif /* CONFIG_XENO_OPT_DEBUG_TIMERS */
+#ifndef CONFIG_XENO_OPT_DEBUG_UITRON
+#define CONFIG_XENO_OPT_DEBUG_UITRON  0
+#endif /* CONFIG_XENO_OPT_DEBUG_UITRON */
+#ifndef CONFIG_XENO_OPT_DEBUG_VXWORKS
+#define CONFIG_XENO_OPT_DEBUG_VXWORKS  0
+#endif /* CONFIG_XENO_OPT_DEBUG_VXWORKS */
+#ifndef CONFIG_XENO_OPT_DEBUG_XNLOCK
+#define CONFIG_XENO_OPT_DEBUG_XNLOCK 0
+#endif /* CONFIG_XENO_OPT_DEBUG_XNLOCK */
+
 #endif /* !_XENO_NUCLEUS_ASSERT_H */
diff --git a/include/nucleus/bheap.h b/include/nucleus/bheap.h
index 8b7798e..58ea93f 100644
--- a/include/nucleus/bheap.h
+++ b/include/nucleus/bheap.h
@@ -25,10 +25,6 @@
 /* debug support */
 #include <nucleus/assert.h>
 
-#ifndef CONFIG_XENO_OPT_DEBUG_QUEUES
-#define CONFIG_XENO_OPT_DEBUG_QUEUES 0
-#endif
-
 /* Priority queue implementation, using a binary heap. */
 
 typedef unsigned long long bheap_key_t;
@@ -44,8 +40,8 @@ typedef struct bheaph {
 #define bheaph_prio(holder) ((holder)->prio)
 #define bheaph_pos(holder)  ((holder)->pos)
 #define bheaph_lt(h1, h2)   ((long long) ((h1)->key - (h2)->key) < 0 ||	\
-                             ((h1)->key == (h2)->key &&			\
-                              (h1)->prio > (h2)->prio))
+			     ((h1)->key == (h2)->key &&			\
+			      (h1)->prio > (h2)->prio))
 
 typedef struct bheap {
 	unsigned sz;
diff --git a/include/nucleus/heap.h b/include/nucleus/heap.h
index 77fefa6..fecdb79 100644
--- a/include/nucleus/heap.h
+++ b/include/nucleus/heap.h
@@ -46,10 +46,6 @@
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
-#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
-#define CONFIG_XENO_OPT_DEBUG_NUCLEUS 0
-#endif
-
 #define XNHEAP_PAGE_SIZE	512 /* A reasonable value for the xnheap page size */
 #define XNHEAP_PAGE_MASK	(~(XNHEAP_PAGE_SIZE-1))
 #define XNHEAP_PAGE_ALIGN(addr)	(((addr)+XNHEAP_PAGE_SIZE-1)&XNHEAP_PAGE_MASK)
diff --git a/include/nucleus/pod.h b/include/nucleus/pod.h
index e652a1e..8831fb5 100644
--- a/include/nucleus/pod.h
+++ b/include/nucleus/pod.h
@@ -58,7 +58,7 @@
 
 struct xnsynch;
 
-/*! 
+/*!
  * \brief Real-time pod descriptor.
  *
  * The source of all Xenomai magic.
@@ -276,14 +276,14 @@ static inline void xnpod_schedule(void)
 	 * context is active, or if we are caught in the middle of a
 	 * unlocked context switch.
 	 */
-#ifdef CONFIG_XENO_OPT_DEBUG_NUCLEUS
+#if XENO_DEBUG(NUCLEUS)
 	if (testbits(sched->status, XNKCOUT|XNINIRQ|XNSWLOCK))
 		return;
-#else /* !CONFIG_XENO_OPT_DEBUG_NUCLEUS */
+#else /* !XENO_DEBUG(NUCLEUS) */
 	if (testbits(sched->status,
 		     XNKCOUT|XNINIRQ|XNSWLOCK|XNRESCHED) != XNRESCHED)
 		return;
-#endif /* !CONFIG_XENO_OPT_DEBUG_NUCLEUS */
+#endif /* !XENO_DEBUG(NUCLEUS) */
 
 	__xnpod_schedule(sched);
 }
diff --git a/include/nucleus/queue.h b/include/nucleus/queue.h
index e243f2f..15ec537 100644
--- a/include/nucleus/queue.h
+++ b/include/nucleus/queue.h
@@ -24,10 +24,6 @@
 #include <nucleus/types.h>
 #include <nucleus/assert.h>
 
-#ifndef CONFIG_XENO_OPT_DEBUG_QUEUES
-#define CONFIG_XENO_OPT_DEBUG_QUEUES 0
-#endif
-
 /* Basic element holder */
 
 typedef struct xnholder {
diff --git a/include/nucleus/sched-sporadic.h b/include/nucleus/sched-sporadic.h
index ecebc55..dfeec76 100644
--- a/include/nucleus/sched-sporadic.h
+++ b/include/nucleus/sched-sporadic.h
@@ -29,10 +29,6 @@
 
 #ifdef CONFIG_XENO_OPT_SCHED_SPORADIC
 
-#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
-#define CONFIG_XENO_OPT_DEBUG_NUCLEUS 0
-#endif
-
 #include <nucleus/heap.h>
 
 extern struct xnsched_class xnsched_class_sporadic;
diff --git a/include/nucleus/sched.h b/include/nucleus/sched.h
index c96d65d..05dd4b1 100644
--- a/include/nucleus/sched.h
+++ b/include/nucleus/sched.h
@@ -36,10 +36,6 @@
 #include <nucleus/sched-tp.h>
 #include <nucleus/sched-sporadic.h>
 
-#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
-#define CONFIG_XENO_OPT_DEBUG_NUCLEUS 0
-#endif
-
 /* Sched status flags */
 #define XNKCOUT		0x80000000	/* Sched callout context */
 #define XNHTICK		0x40000000	/* Host tick pending  */
@@ -57,7 +53,7 @@ struct xnsched_rt {
 #endif /* CONFIG_XENO_OPT_PRIOCPL */
 };
 
-/*! 
+/*!
  * \brief Scheduling information structure.
  */
 
diff --git a/include/nucleus/synch.h b/include/nucleus/synch.h
index bd9dbbc..d7edbc6 100644
--- a/include/nucleus/synch.h
+++ b/include/nucleus/synch.h
@@ -157,14 +157,14 @@ typedef struct xnsynch {
 extern "C" {
 #endif
 
-#ifdef CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX
+#if XENO_DEBUG(SYNCH_RELAX)
 
 void xnsynch_detect_relaxed_owner(struct xnsynch *synch,
 				  struct xnthread *sleeper);
 
 void xnsynch_detect_claimed_relax(struct xnthread *owner);
 
-#else /* !CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX */
+#else /* !XENO_DEBUG(SYNCH_RELAX) */
 
 static inline void xnsynch_detect_relaxed_owner(struct xnsynch *synch,
 				  struct xnthread *sleeper)
@@ -175,7 +175,7 @@ static inline void xnsynch_detect_claimed_relax(struct xnthread *owner)
 {
 }
 
-#endif /* !CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX */
+#endif /* !XENO_DEBUG(SYNCH_RELAX) */
 
 void xnsynch_init(struct xnsynch *synch, xnflags_t flags,
 		  xnarch_atomic_t *fastlock);
diff --git a/include/nucleus/timer.h b/include/nucleus/timer.h
index ef05822..f2e0b19 100644
--- a/include/nucleus/timer.h
+++ b/include/nucleus/timer.h
@@ -28,10 +28,6 @@
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
-#ifndef CONFIG_XENO_OPT_DEBUG_TIMERS
-#define CONFIG_XENO_OPT_DEBUG_TIMERS  0
-#endif
-
 #define XNTIMER_WHEELSIZE 64
 #define XNTIMER_WHEELMASK (XNTIMER_WHEELSIZE - 1)
 
diff --git a/include/psos+/ppd.h b/include/psos+/ppd.h
index 09ea13f..82f7834 100644
--- a/include/psos+/ppd.h
+++ b/include/psos+/ppd.h
@@ -2,7 +2,7 @@
  * @file
  * This file is part of the Xenomai project.
  *
- * @note Copyright (C) 2007 Philippe Gerum <rpm@xenomai.org> 
+ * @note Copyright (C) 2007 Philippe Gerum <rpm@xenomai.org>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -25,10 +25,6 @@
 #include <nucleus/pod.h>
 #include <nucleus/ppd.h>
 
-#ifndef CONFIG_XENO_OPT_DEBUG_PSOS
-#define CONFIG_XENO_OPT_DEBUG_PSOS  0
-#endif
-
 typedef struct psos_resource_holder {
 
 	xnshadow_ppd_t ppd;
diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index 0fc1496..0d11666 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -47,10 +47,6 @@
 #include <asm-generic/xenomai/pci_ids.h>
 #endif /* CONFIG_PCI */
 
-#ifndef CONFIG_XENO_OPT_DEBUG_RTDM
-#define CONFIG_XENO_OPT_DEBUG_RTDM	0
-#endif
-
 struct rtdm_dev_context;
 typedef struct xnselector rtdm_selector_t;
 enum rtdm_selecttype;
diff --git a/include/vxworks/ppd.h b/include/vxworks/ppd.h
index 245c9b7..bae6fa1 100644
--- a/include/vxworks/ppd.h
+++ b/include/vxworks/ppd.h
@@ -2,7 +2,7 @@
  * @file
  * This file is part of the Xenomai project.
  *
- * @note Copyright (C) 2007 Philippe Gerum <rpm@xenomai.org> 
+ * @note Copyright (C) 2007 Philippe Gerum <rpm@xenomai.org>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -25,10 +25,6 @@
 #include <nucleus/pod.h>
 #include <nucleus/ppd.h>
 
-#ifndef CONFIG_XENO_OPT_DEBUG_VXWORKS
-#define CONFIG_XENO_OPT_DEBUG_VXWORKS  0
-#endif
-
 typedef struct wind_resource_holder {
 
 	xnshadow_ppd_t ppd;
diff --git a/ksrc/nucleus/bufd.c b/ksrc/nucleus/bufd.c
index 8dd655c..d7a7b00 100644
--- a/ksrc/nucleus/bufd.c
+++ b/ksrc/nucleus/bufd.c
@@ -58,7 +58,7 @@
  *
  *       ret = this_may_fail();
  *       if (ret)
- *  	       xnbufd_invalidate(bufd);
+ *	       xnbufd_invalidate(bufd);
  *
  *       return ret;
  *   }
@@ -146,10 +146,6 @@
 #include <nucleus/bufd.h>
 #include <nucleus/assert.h>
 
-#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
-#define CONFIG_XENO_OPT_DEBUG_NUCLEUS  0
-#endif
-
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 
 #include <asm/xenomai/syscall.h>
diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 93713f2..3ffd548 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -46,10 +46,6 @@
 #include <nucleus/select.h>
 #include <asm/xenomai/bits/pod.h>
 
-#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
-#define CONFIG_XENO_OPT_DEBUG_NUCLEUS 0
-#endif
-
 /*
  * NOTE: We need to initialize the globals; remember that this code
  * also runs over the simulator in user-space.
@@ -318,7 +314,7 @@ static void xnpod_flush_stackpool(xnheap_t *heap,
 }
 #endif
 
-/*! 
+/*!
  * \fn int xnpod_init(void)
  * \brief Initialize the core pod.
  *
@@ -438,7 +434,7 @@ int xnpod_init(void)
 }
 EXPORT_SYMBOL_GPL(xnpod_init);
 
-/*! 
+/*!
  * \fn void xnpod_shutdown(int xtype)
  * \brief Shutdown the current pod.
  *
@@ -543,7 +539,7 @@ void xnpod_fire_callouts(xnqueue_t *hookq, xnthread_t *thread)
 	__clrbits(sched->status, XNKCOUT);
 }
 
-/*! 
+/*!
  * \fn void xnpod_init_thread(struct xnthread *thread,const struct xnthread_init_attr *attr,struct xnsched_class *sched_class,const union xnsched_policy_param *sched_param)
  * \brief Initialize a new thread.
  *
@@ -665,7 +661,7 @@ int xnpod_init_thread(struct xnthread *thread,
 }
 EXPORT_SYMBOL_GPL(xnpod_init_thread);
 
-/*! 
+/*!
  * \fn int xnpod_start_thread(struct xnthread *thread,const struct xnthread_start_attr *attr)
  * \brief Initial start of a newly created thread.
  *
@@ -824,7 +820,7 @@ unlock_and_exit:
 }
 EXPORT_SYMBOL_GPL(xnpod_start_thread);
 
-/*! 
+/*!
  * @internal
  * \fn void __xnpod_reset_thread(struct xnthread *thread, int unlock)
  * \brief Reset the thread.
@@ -861,7 +857,7 @@ void __xnpod_reset_thread(struct xnthread *thread)
 	}
 }
 
-/*! 
+/*!
  * \fn void xnpod_stop_thread(xnthread_t *thread)
  *
  * \brief Stop a thread.
@@ -907,7 +903,7 @@ void xnpod_stop_thread(struct xnthread *thread)
 }
 EXPORT_SYMBOL_GPL(xnpod_stop_thread);
 
-/*! 
+/*!
  * \fn void xnpod_restart_thread(xnthread_t *thread)
  *
  * \brief Restart a thread.
@@ -968,7 +964,7 @@ void xnpod_restart_thread(xnthread_t *thread)
 }
 EXPORT_SYMBOL_GPL(xnpod_restart_thread);
 
-/*! 
+/*!
  * \fn void xnpod_set_thread_mode(xnthread_t *thread,xnflags_t clrmask,xnflags_t setmask)
  * \brief Change a thread's control mode.
  *
@@ -1043,7 +1039,7 @@ xnflags_t xnpod_set_thread_mode(xnthread_t *thread,
 }
 EXPORT_SYMBOL_GPL(xnpod_set_thread_mode);
 
-/*! 
+/*!
  * \fn void xnpod_delete_thread(xnthread_t *thread)
  *
  * \brief Delete a thread.
@@ -1247,7 +1243,7 @@ void xnpod_delete_thread(xnthread_t *thread)
 }
 EXPORT_SYMBOL_GPL(xnpod_delete_thread);
 
-/*! 
+/*!
  * \fn void xnpod_abort_thread(xnthread_t *thread)
  *
  * \brief Abort a thread.
@@ -1408,9 +1404,9 @@ void xnpod_suspend_thread(xnthread_t *thread, xnflags_t mask,
 		 * the wakeup call pending for that task in the root
 		 * context, to collect and act upon the pending Linux
 		 * signal.
- 		 */
-		if ((mask & XNRELAX) == 0 
-		    && (xnthread_sigpending(thread) 
+		 */
+		if ((mask & XNRELAX) == 0
+		    && (xnthread_sigpending(thread)
 			|| xnthread_test_info(thread, XNKICKED))) {
 			xnthread_clear_info(thread, XNRMID | XNTIMEO);
 			xnthread_set_info(thread, XNBREAK);
@@ -1495,7 +1491,7 @@ void xnpod_suspend_thread(xnthread_t *thread, xnflags_t mask,
 	 * those. So there is no need to deal specifically with the
 	 * relax+suspend issue when the about to be suspended thread
 	 * is current, since it must not be relaxed anyway.
-	 * 
+	 *
 	 * - among all blocking bits (XNTHREAD_BLOCK_BITS), only
 	 * XNSUSP, XNDELAY, XNDORMANT and XNHELD may be applied by the
 	 * current thread to a non-current thread. XNPEND is always
@@ -1900,16 +1896,16 @@ unlock_and_exit:
 	return ret;
 }
 
-/** 
+/**
  * \fn int xnpod_migrate_thread(int cpu)
  *
  * \brief Migrate the current thread.
  *
  * This call makes the current thread migrate to another CPU if its
  * affinity allows it.
- * 
+ *
  * @param cpu The destination CPU.
- * 
+ *
  * @retval 0 if the thread could migrate ;
  * @retval -EPERM if the calling context is asynchronous, or the
  * current thread affinity forbids this migration ;
@@ -1971,7 +1967,7 @@ int xnpod_migrate_thread(int cpu)
 }
 EXPORT_SYMBOL_GPL(xnpod_migrate_thread);
 
-/*! 
+/*!
  * @internal
  * \fn void xnpod_dispatch_signals(void)
  * \brief Deliver pending asynchronous signals to the running thread.
@@ -2079,7 +2075,7 @@ static inline void xnpod_switch_to(xnsched_t *sched,
 			 xnthread_archtcb(next));
 }
 
-/*! 
+/*!
  * \fn void xnpod_schedule(void)
  * \brief Rescheduling procedure entry point.
  *
@@ -2133,7 +2129,7 @@ static inline void xnpod_switch_to(xnsched_t *sched,
  * context switch has taken place. This behaviour can be disabled by
  * setting the XNASDI flag in the thread's status mask by calling
  * xnpod_set_thread_mode().
- * 
+ *
  * Environments:
  *
  * This service can be called from:
@@ -2149,7 +2145,7 @@ static inline void xnpod_switch_to(xnsched_t *sched,
 static inline int __xnpod_test_resched(struct xnsched *sched)
 {
 	int cpu = xnsched_cpu(sched), resched;
-	
+
 	resched = xnarch_cpu_isset(cpu, sched->resched);
 	xnarch_cpu_clear(cpu, sched->resched);
 #ifdef CONFIG_SMP
@@ -2181,10 +2177,10 @@ void __xnpod_schedule(struct xnsched *sched)
 			 xnthread_current_priority(curr));
 
 	need_resched = __xnpod_test_resched(sched);
-#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
+#if !XENO_DEBUG(NUCLEUS)
 	if (!need_resched)
 		goto signal_unlock_and_exit;
-#endif /* !CONFIG_XENO_OPT_DEBUG_NUCLEUS */
+#endif /* !XENO_DEBUG(NUCLEUS) */
 	zombie = xnthread_test_state(curr, XNZOMBIE);
 
 	next = xnsched_pick_next(sched);
@@ -2293,7 +2289,7 @@ void __xnpod_schedule(struct xnsched *sched)
 	{
 		spl_t ignored;
 
-		/* Shadow on entry and root without shadow extension on exit? 
+		/* Shadow on entry and root without shadow extension on exit?
 		   Mmmm... This must be the user-space mate of a deleted real-time
 		   shadow we've just rescheduled in the Linux domain to have it
 		   exit properly.  Reap it now. */
@@ -2348,7 +2344,7 @@ void xnpod_unlock_sched(void)
 }
 EXPORT_SYMBOL_GPL(xnpod_unlock_sched);
 
-/*! 
+/*!
  * \fn int xnpod_add_hook(int type,void (*routine)(xnthread_t *))
  * \brief Install a nucleus hook.
  *
@@ -2441,7 +2437,7 @@ int xnpod_add_hook(int type, void (*routine) (xnthread_t *))
 }
 EXPORT_SYMBOL_GPL(xnpod_add_hook);
 
-/*! 
+/*!
  * \fn int xnpod_remove_hook(int type,void (*routine)(xnthread_t *))
  * \brief Remove a nucleus hook.
  *
@@ -2518,7 +2514,7 @@ int xnpod_remove_hook(int type, void (*routine) (xnthread_t *))
 }
 EXPORT_SYMBOL_GPL(xnpod_remove_hook);
 
-/*! 
+/*!
  * \fn void xnpod_trap_fault(xnarch_fltinfo_t *fltinfo);
  * \brief Default fault handler.
  *
@@ -2609,7 +2605,7 @@ int xnpod_trap_fault(xnarch_fltinfo_t *fltinfo)
 }
 EXPORT_SYMBOL_GPL(xnpod_trap_fault);
 
-/*! 
+/*!
  * \fn int xnpod_enable_timesource(void)
  * \brief Activate the core time source.
  *
@@ -2750,7 +2746,7 @@ int xnpod_enable_timesource(void)
 }
 EXPORT_SYMBOL_GPL(xnpod_enable_timesource);
 
-/*! 
+/*!
  * \fn void xnpod_disable_timesource(void)
  * \brief Stop the core time source.
  *
@@ -3055,7 +3051,7 @@ int xnpod_set_thread_tslice(struct xnthread *thread, xnticks_t quantum)
 	unsigned long oldmode;
 	int aperiodic;
 	spl_t s;
-	
+
 	if (thread->base_class->sched_tick == NULL)
 		return -EINVAL;
 
diff --git a/ksrc/nucleus/registry.c b/ksrc/nucleus/registry.c
index 9958dd3..8fb42fb 100644
--- a/ksrc/nucleus/registry.c
+++ b/ksrc/nucleus/registry.c
@@ -2,7 +2,7 @@
  * @file
  * This file is part of the Xenomai project.
  *
- * @note Copyright (C) 2004 Philippe Gerum <rpm@xenomai.org> 
+ * @note Copyright (C) 2004 Philippe Gerum <rpm@xenomai.org>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -42,10 +42,6 @@
 #include <nucleus/thread.h>
 #include <nucleus/assert.h>
 
-#ifndef CONFIG_XENO_OPT_DEBUG_REGISTRY
-#define CONFIG_XENO_OPT_DEBUG_REGISTRY  0
-#endif
-
 static xnobject_t *registry_obj_slots;
 
 static xnqueue_t registry_obj_freeq;	/* Free objects. */
diff --git a/ksrc/nucleus/sched.c b/ksrc/nucleus/sched.c
index 4ec0013..0b737a3 100644
--- a/ksrc/nucleus/sched.c
+++ b/ksrc/nucleus/sched.c
@@ -66,7 +66,7 @@ static u_long wd_timeout_arg = CONFIG_XENO_OPT_WATCHDOG_TIMEOUT;
 module_param_named(watchdog_timeout, wd_timeout_arg, ulong, 0644);
 MODULE_PARM_DESC(watchdog_timeout, "Watchdog timeout (s)");
 
-/*! 
+/*!
  * @internal
  * \fn void xnsched_watchdog_handler(struct xntimer *timer)
  * \brief Process watchdog ticks.
@@ -307,7 +307,7 @@ struct xnthread *xnsched_peek_rpi(struct xnsched *sched)
 #endif /* CONFIG_XENO_OPT_SCHED_CLASSES */
 }
 
-/*! 
+/*!
  * @internal
  * \fn void xnsched_renice_root(struct xnsched *sched, struct xnthread *target)
  * \brief Change the root thread priority.
@@ -529,10 +529,6 @@ void xnsched_migrate_passive(struct xnthread *thread, struct xnsched *sched)
 
 #ifdef CONFIG_XENO_OPT_SCALABLE_SCHED
 
-#ifndef CONFIG_XENO_OPT_DEBUG_QUEUES
-#define CONFIG_XENO_OPT_DEBUG_QUEUES 0
-#endif
-
 void initmlq(struct xnsched_mlq *q, int loprio, int hiprio)
 {
 	int prio;
@@ -546,7 +542,7 @@ void initmlq(struct xnsched_mlq *q, int loprio, int hiprio)
 	for (prio = 0; prio < XNSCHED_MLQ_LEVELS; prio++)
 		initq(&q->queue[prio]);
 
-	XENO_ASSERT(QUEUES, 
+	XENO_ASSERT(QUEUES,
 		    hiprio - loprio + 1 < XNSCHED_MLQ_LEVELS,
 		    xnpod_fatal("priority range [%d..%d] is beyond multi-level "
 				"queue indexing capabilities",
@@ -706,7 +702,7 @@ struct sched_seq_iterator {
 		int cprio;
 		int dnprio;
 		int periodic;
-	  	xnticks_t timeout;
+		xnticks_t timeout;
 		xnflags_t state;
 	} sched_info[1];
 };
diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 539d952..872c37f 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -55,10 +55,6 @@
 #include <asm/xenomai/syscall.h>
 #include <asm/xenomai/bits/shadow.h>
 
-#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
-#define CONFIG_XENO_OPT_DEBUG_NUCLEUS  0
-#endif
-
 static int xn_gid_arg = -1;
 module_param_named(xenomai_gid, xn_gid_arg, int, 0644);
 MODULE_PARM_DESC(xenomai_gid, "GID of the group with access to Xenomai services");
@@ -179,7 +175,7 @@ static struct xnthread *rpi_next(struct xnsched *sched, spl_t s)
 	struct xnthread *thread;
 
 	thread = xnsched_peek_rpi(sched);
-	while (thread && 
+	while (thread &&
 	       xnthread_user_task(thread)->state != TASK_RUNNING &&
 	       !xnthread_test_info(thread, XNATOMIC)) {
 		/*
@@ -458,7 +454,7 @@ static inline void rpi_switch(struct task_struct *next_task)
 			next->rpi = sched;
 			xnlock_put_irqrestore(&sched->rpilock, s);
 			xnlock_get_irqsave(&nklock, s);
-		  	xnsched_resume_rpi(next);
+			xnsched_resume_rpi(next);
 			xnlock_put_irqrestore(&nklock, s);
 		}
 	} else if (unlikely(next->rpi != sched))
@@ -500,17 +496,17 @@ void xnshadow_rpi_check(void)
 	struct xnsched *sched = xnpod_current_sched();
 	struct xnthread *top;
 	spl_t s;
- 
- 	xnlock_get_irqsave(&sched->rpilock, s);
- 	top = rpi_next(sched, s);
- 	xnlock_put_irqrestore(&sched->rpilock, s);
+
+	xnlock_get_irqsave(&sched->rpilock, s);
+	top = rpi_next(sched, s);
+	xnlock_put_irqrestore(&sched->rpilock, s);
 
 	if (top == NULL && xnsched_root_class(sched) != &xnsched_class_idle)
 		xnsched_renice_root(sched, NULL);
 }
 
 #endif	/* CONFIG_SMP */
- 
+
 #else
 
 #define rpi_p(t)		(0)
@@ -660,14 +656,14 @@ static inline void ppd_remove_mm(struct mm_struct *mm,
 	xnlock_put_irqrestore(&nklock, s);
 }
 
-/** 
+/**
  * Mark the per-thread per-skin signal condition for the skin whose
  * muxid is @a muxid.
- * 
+ *
  * @param thread the target thread;
  * @param muxid the muxid of the skin for which the signal is marked
  * pending.
- * 
+ *
  * @return whether rescheduling is needed.
  */
 int xnshadow_mark_sig(xnthread_t *thread, unsigned muxid)
@@ -687,13 +683,13 @@ int xnshadow_mark_sig(xnthread_t *thread, unsigned muxid)
 }
 EXPORT_SYMBOL_GPL(xnshadow_mark_sig);
 
-/** 
+/**
  * Clear the per-thrad per-skin signal condition.
- * 
+ *
  * Called with nklock locked irqs off.
  *
  * @param thread the target thrad
- * @param muxid 
+ * @param muxid
  */
 void xnshadow_clear_sig(xnthread_t *thread, unsigned muxid)
 {
@@ -754,7 +750,7 @@ static inline void handle_rt_signals(xnthread_t *thread,
 /* In the case when we are going to handle linux signals, do not let
    the kernel handle the syscall restart to give a chance to the
    xenomai handlers to be executed. */
-	if (__xn_interrupted_p(regs) 
+	if (__xn_interrupted_p(regs)
 	    || __xn_reg_rval(regs) == -ERESTARTSYS
 	    || __xn_reg_rval(regs) == -ERESTARTNOHAND)
 		__xn_error_return(regs, ((sysflags & __xn_exec_norestart)
@@ -902,7 +898,7 @@ static void schedule_linux_call(int type, struct task_struct *p, int arg)
 	rq->req[reqnum].type = type;
 	rq->req[reqnum].task = p;
 	rq->req[reqnum].arg = arg;
-	
+
 	splexit(s);
 
 	rthal_apc_schedule(lostage_apc);
@@ -979,7 +975,7 @@ static int gatekeeper_thread(void *data)
 	return 0;
 }
 
-/*! 
+/*!
  * @internal
  * \fn int xnshadow_harden(void);
  * \brief Migrate a Linux task to the Xenomai domain.
@@ -1111,7 +1107,7 @@ redo:
 }
 EXPORT_SYMBOL_GPL(xnshadow_harden);
 
-/*! 
+/*!
  * @internal
  * \fn void xnshadow_relax(int notify, int reason);
  * \brief Switch a shadow thread back to the Linux domain.
@@ -1280,7 +1276,7 @@ void xnshadow_exit(void)
  *
  * This service can be called from:
  *
- * - Regular user-space process. 
+ * - Regular user-space process.
  *
  * Rescheduling: always.
  *
@@ -1365,10 +1361,10 @@ int xnshadow_map(xnthread_t *thread, xncompletion_t __user *u_completion,
 		 */
 		xnshadow_renice(thread);
 
- 		/*
+		/*
 		 * We still have the XNDORMANT bit set, so we can't
- 		 * link to the RPI queue which only links _runnable_
- 		 * relaxed shadow.
+		 * link to the RPI queue which only links _runnable_
+		 * relaxed shadow.
 		 */
 		xnshadow_signal_completion(u_completion, 0);
 		return 0;
@@ -1994,7 +1990,7 @@ static xnsysent_t __systab[] = {
 	[__xn_sys_current] = {&xnshadow_sys_current, __xn_exec_any},
 	[__xn_sys_current_info] =
 		{&xnshadow_sys_current_info, __xn_exec_shadow},
-	[__xn_sys_get_next_sigs] = 
+	[__xn_sys_get_next_sigs] =
 		{&xnshadow_sys_get_next_sigs, __xn_exec_conforming},
 	[__xn_sys_drop_u_mode] =
 		{&xnshadow_sys_drop_u_mode, __xn_exec_shadow},
@@ -2748,7 +2744,7 @@ EXPORT_SYMBOL_GPL(xnshadow_unregister_interface);
  *
  * @return the per-process data if the current context is a user-space process;
  * @return NULL otherwise.
- * 
+ *
  */
 xnshadow_ppd_t *xnshadow_ppd_get(unsigned muxid)
 {
diff --git a/ksrc/nucleus/synch.c b/ksrc/nucleus/synch.c
index 619929e..d57f7cd 100644
--- a/ksrc/nucleus/synch.c
+++ b/ksrc/nucleus/synch.c
@@ -36,14 +36,10 @@
 #include <nucleus/thread.h>
 #include <nucleus/module.h>
 
-#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
-#define CONFIG_XENO_OPT_DEBUG_NUCLEUS 0
-#endif
-
 #define w_bprio(t)	xnsched_weighted_bprio(t)
 #define w_cprio(t)	xnsched_weighted_cprio(t)
 
-/*! 
+/*!
  * \fn void xnsynch_init(struct xnsynch *synch, xnflags_t flags,
  *                       xnarch_atomic_t *fastlock)
  *
@@ -360,7 +356,7 @@ static void xnsynch_renice_thread(struct xnthread *thread,
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 }
 
-/*! 
+/*!
  * \fn xnflags_t xnsynch_acquire(struct xnsynch *synch, xnticks_t timeout,
  *                               xntmode_t timeout_mode);
  * \brief Acquire the ownership of a synchronization object.
@@ -561,7 +557,7 @@ xnflags_t xnsynch_acquire(struct xnsynch *synch, xnticks_t timeout,
 }
 EXPORT_SYMBOL_GPL(xnsynch_acquire);
 
-/*! 
+/*!
  * @internal
  * \fn void xnsynch_clear_boost(struct xnsynch *synch, struct xnthread *owner);
  * \brief Clear the priority boost.
@@ -609,7 +605,7 @@ static void xnsynch_clear_boost(struct xnsynch *synch,
 		xnsynch_renice_thread(owner, target);
 }
 
-/*! 
+/*!
  * @internal
  * \fn void xnsynch_requeue_sleeper(struct xnthread *thread);
  * \brief Change a sleeper's priority.
@@ -761,7 +757,7 @@ struct xnthread *xnsynch_release(struct xnsynch *synch)
 }
 EXPORT_SYMBOL_GPL(xnsynch_release);
 
-/*! 
+/*!
  * \fn struct xnthread *xnsynch_peek_pendq(struct xnsynch *synch);
  * \brief Access the thread leading a synch object wait queue.
  *
@@ -800,7 +796,7 @@ struct xnthread *xnsynch_peek_pendq(struct xnsynch *synch)
 }
 EXPORT_SYMBOL_GPL(xnsynch_peek_pendq);
 
-/*! 
+/*!
  * \fn void xnsynch_flush(struct xnsynch *synch, xnflags_t reason);
  * \brief Unblock all waiters pending on a resource.
  *
@@ -882,7 +878,7 @@ int xnsynch_flush(struct xnsynch *synch, xnflags_t reason)
 }
 EXPORT_SYMBOL_GPL(xnsynch_flush);
 
-/*! 
+/*!
  * @internal
  * \fn void xnsynch_forget_sleeper(struct xnthread *thread);
  * \brief Abort a wait for a resource.
@@ -947,7 +943,7 @@ void xnsynch_forget_sleeper(struct xnthread *thread)
 }
 EXPORT_SYMBOL_GPL(xnsynch_forget_sleeper);
 
-/*! 
+/*!
  * @internal
  * \fn void xnsynch_release_all_ownerships(struct xnthread *thread);
  * \brief Release all ownerships.
@@ -981,7 +977,7 @@ void xnsynch_release_all_ownerships(struct xnthread *thread)
 }
 EXPORT_SYMBOL_GPL(xnsynch_release_all_ownerships);
 
-#ifdef CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX
+#if XENO_DEBUG(SYNCH_RELAX)
 
 /*
  * Detect when a thread is about to sleep on a synchronization
@@ -1025,7 +1021,7 @@ void xnsynch_detect_claimed_relax(struct xnthread *owner)
 	}
 }
 
-#endif /* CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX */
+#endif /* XENO_DEBUG(SYNCH_RELAX) */
 
 
 /*@}*/
diff --git a/ksrc/skins/posix/internal.h b/ksrc/skins/posix/internal.h
index dcc71e9..46fa547 100644
--- a/ksrc/skins/posix/internal.h
+++ b/ksrc/skins/posix/internal.h
@@ -28,10 +28,6 @@
 /* debug support */
 #include <nucleus/assert.h>
 
-#ifndef CONFIG_XENO_OPT_DEBUG_POSIX
-#define CONFIG_XENO_OPT_DEBUG_POSIX 0
-#endif
-
 #define PSE51_MAGIC(n) (0x8686##n##n)
 #define PSE51_ANY_MAGIC         PSE51_MAGIC(00)
 #define PSE51_THREAD_MAGIC      PSE51_MAGIC(01)
@@ -103,7 +99,7 @@ static inline pse51_queues_t *pse51_queues(void)
 	xnlock_get_irqsave(&nklock, s);
 
 	ppd = xnshadow_ppd_get(pse51_muxid);
-	
+
 	xnlock_put_irqrestore(&nklock, s);
 
 	if (!ppd)
diff --git a/ksrc/skins/rtdm/internal.h b/ksrc/skins/rtdm/internal.h
index 69299f8..64e5b47 100644
--- a/ksrc/skins/rtdm/internal.h
+++ b/ksrc/skins/rtdm/internal.h
@@ -28,10 +28,6 @@
 #include <nucleus/ppd.h>
 #include <rtdm/rtdm_driver.h>
 
-#ifndef CONFIG_XENO_OPT_DEBUG_RTDM_APPL
-#define CONFIG_XENO_OPT_DEBUG_RTDM_APPL	0
-#endif
-
 #define RTDM_FD_MAX			CONFIG_XENO_OPT_RTDM_FILDES
 
 #define DEF_DEVNAME_HASHTAB_SIZE	256	/* entries in name hash table */
diff --git a/ksrc/skins/uitron/ppd.h b/ksrc/skins/uitron/ppd.h
index 07616ec..c851cb9 100644
--- a/ksrc/skins/uitron/ppd.h
+++ b/ksrc/skins/uitron/ppd.h
@@ -2,7 +2,7 @@
  * @file
  * This file is part of the Xenomai project.
  *
- * @note Copyright (C) 2007 Philippe Gerum <rpm@xenomai.org> 
+ * @note Copyright (C) 2007 Philippe Gerum <rpm@xenomai.org>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -25,10 +25,6 @@
 #include <nucleus/pod.h>
 #include <nucleus/ppd.h>
 
-#ifndef CONFIG_XENO_OPT_DEBUG_UITRON
-#define CONFIG_XENO_OPT_DEBUG_UITRON  0
-#endif
-
 typedef struct ui_resource_holder {
 
 	xnshadow_ppd_t ppd;
diff --git a/src/skins/native/mutex.c b/src/skins/native/mutex.c
index 98844ef..55d502f 100644
--- a/src/skins/native/mutex.c
+++ b/src/skins/native/mutex.c
@@ -103,7 +103,7 @@ static int rt_mutex_acquire_inner(RT_MUTEX *mutex, RTIME timeout, xntmode_t mode
 		 * mutex state consistent.
 		 *
 		 * We make no efforts to migrate or warn here. There is
-		 * CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX to catch such bugs.
+		 * XENO_DEBUG(SYNCH_RELAX) to catch such bugs.
 		 */
 		if (mutex->lockcnt == UINT_MAX)
 			return -EAGAIN;
-- 
1.5.6.5


