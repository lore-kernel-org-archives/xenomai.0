Message-ID: <4BCC631B.3060108@domain.hid>
Date: Mon, 19 Apr 2010 16:05:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4BCC619E.2@domain.hid>
In-Reply-To: <4BCC619E.2@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC] fix XENO_OPT_DEBUG bugs.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> (...)
> So, a patch follows which:

Sorry, here is a patch without the whitespace changes.

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
diff --git a/include/native/types.h b/include/native/types.h
index 0dd721f..daeedff 100644
--- a/include/native/types.h
+++ b/include/native/types.h
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
@@ -38,4 +38,44 @@
         xnpod_fatal("bug at %s:%d (%s)", __FILE__, __LINE__, (#cond)); \
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
 #define XNHEAP_PAGE_SIZE	512 /* A reasonable value for the xnheap page
size */
 #define XNHEAP_PAGE_MASK	(~(XNHEAP_PAGE_SIZE-1))
 #define XNHEAP_PAGE_ALIGN(addr)
(((addr)+XNHEAP_PAGE_SIZE-1)&XNHEAP_PAGE_MASK)
diff --git a/include/nucleus/pod.h b/include/nucleus/pod.h
index e652a1e..8831fb5 100644
--- a/include/nucleus/pod.h
+++ b/include/nucleus/pod.h
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
diff --git a/include/nucleus/sched-sporadic.h
b/include/nucleus/sched-sporadic.h
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
@@ -175,7 +175,7 @@ static inline void
xnsynch_detect_claimed_relax(struct xnthread *owner)
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
diff --git a/ksrc/nucleus/registry.c b/ksrc/nucleus/registry.c
index 9958dd3..8fb42fb 100644
--- a/ksrc/nucleus/registry.c
+++ b/ksrc/nucleus/registry.c
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
@@ -529,10 +529,6 @@ void xnsched_migrate_passive(struct xnthread
*thread, struct xnsched *sched)

 #ifdef CONFIG_XENO_OPT_SCALABLE_SCHED

-#ifndef CONFIG_XENO_OPT_DEBUG_QUEUES
-#define CONFIG_XENO_OPT_DEBUG_QUEUES 0
-#endif
-
 void initmlq(struct xnsched_mlq *q, int loprio, int hiprio)
 {
 	int prio;
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
 MODULE_PARM_DESC(xenomai_gid, "GID of the group with access to Xenomai
services");
diff --git a/ksrc/nucleus/synch.c b/ksrc/nucleus/synch.c
index 619929e..d57f7cd 100644
--- a/ksrc/nucleus/synch.c
+++ b/ksrc/nucleus/synch.c
@@ -36,10 +36,6 @@
 #include <nucleus/thread.h>
 #include <nucleus/module.h>

-#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
-#define CONFIG_XENO_OPT_DEBUG_NUCLEUS 0
-#endif
-
 #define w_bprio(t)	xnsched_weighted_bprio(t)
 #define w_cprio(t)	xnsched_weighted_cprio(t)

@@ -981,7 +977,7 @@ void xnsynch_release_all_ownerships(struct xnthread
*thread)
 }
 EXPORT_SYMBOL_GPL(xnsynch_release_all_ownerships);

-#ifdef CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX
+#if XENO_DEBUG(SYNCH_RELAX)

 /*
  * Detect when a thread is about to sleep on a synchronization
@@ -1025,7 +1021,7 @@ void xnsynch_detect_claimed_relax(struct xnthread
*owner)
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
@@ -103,7 +103,7 @@ static int rt_mutex_acquire_inner(RT_MUTEX *mutex,
RTIME timeout, xntmode_t mode
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


-- 
					    Gilles.

