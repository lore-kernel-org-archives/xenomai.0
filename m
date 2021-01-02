From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH Dovetail 04/13] cobalt/lock: pipeline: abstract hard lock API
Date: Sat,  2 Jan 2021 10:33:44 +0100
Message-Id: <20210102093353.3195090-5-rpm@xenomai.org>
In-Reply-To: <20210102093353.3195090-1-rpm@xenomai.org>
References: <20210102093353.3195090-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Dovetail implements two types of locks: hard, and hybrid ones.  See
https://evlproject.org/dovetail/pipeline/locking/ for details.

Cobalt is interested in using Dovetail's hard_spinlock_t locks, which
are strictly equivalent to the ipipe_spinlock_t locks. Provide a
wrapper mapping a generic hard lock to the proper implementation
depending on the underlying pipeline flavour.

No functional change is introduced.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/ipipe/pipeline/lock.h   | 21 +++++++++
 .../cobalt/kernel/ipipe/pipeline/pipeline.h   | 25 +++++++++++
 include/cobalt/kernel/lock.h                  | 44 +------------------
 include/cobalt/kernel/rtdm/driver.h           |  9 ++--
 4 files changed, 53 insertions(+), 46 deletions(-)
 create mode 100644 include/cobalt/kernel/ipipe/pipeline/lock.h
 create mode 100644 include/cobalt/kernel/ipipe/pipeline/pipeline.h

diff --git a/include/cobalt/kernel/ipipe/pipeline/lock.h b/include/cobalt/kernel/ipipe/pipeline/lock.h
new file mode 100644
index 000000000..f33b041c7
--- /dev/null
+++ b/include/cobalt/kernel/ipipe/pipeline/lock.h
@@ -0,0 +1,21 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _COBALT_KERNEL_IPIPE_LOCK_H
+#define _COBALT_KERNEL_IPIPE_LOCK_H
+
+#include <pipeline/pipeline.h>
+
+typedef ipipe_spinlock_t pipeline_spinlock_t;
+
+#define PIPELINE_SPIN_LOCK_UNLOCKED(__name)  IPIPE_SPIN_LOCK_UNLOCKED
+
+#ifdef CONFIG_XENO_OPT_DEBUG_LOCKING
+/* Disable UP-over-SMP kernel optimization in debug mode. */
+#define __locking_active__  1
+#else
+#define __locking_active__  ipipe_smp_p
+#endif
+
+#endif /* !_COBALT_KERNEL_IPIPE_LOCK_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/pipeline.h b/include/cobalt/kernel/ipipe/pipeline/pipeline.h
new file mode 100644
index 000000000..317fa62d7
--- /dev/null
+++ b/include/cobalt/kernel/ipipe/pipeline/pipeline.h
@@ -0,0 +1,25 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _COBALT_KERNEL_IPIPE_PIPELINE_H
+#define _COBALT_KERNEL_IPIPE_PIPELINE_H
+
+#include <linux/ipipe.h>
+
+typedef unsigned long spl_t;
+
+#define splhigh(x)  ((x) = ipipe_test_and_stall_head() & 1)
+#ifdef CONFIG_SMP
+#define splexit(x)  ipipe_restore_head(x & 1)
+#else /* !CONFIG_SMP */
+#define splexit(x)  ipipe_restore_head(x)
+#endif /* !CONFIG_SMP */
+#define splmax()    ipipe_stall_head()
+#define splnone()   ipipe_unstall_head()
+#define spltest()   ipipe_test_head()
+
+#define is_secondary_domain()	ipipe_root_p
+#define is_primary_domain()	(!ipipe_root_p)
+
+#endif /* !_COBALT_KERNEL_IPIPE_PIPELINE_H */
diff --git a/include/cobalt/kernel/lock.h b/include/cobalt/kernel/lock.h
index bae047524..185f6e785 100644
--- a/include/cobalt/kernel/lock.h
+++ b/include/cobalt/kernel/lock.h
@@ -20,49 +20,16 @@
 #ifndef _COBALT_KERNEL_LOCK_H
 #define _COBALT_KERNEL_LOCK_H
 
-#include <linux/ipipe.h>
+#include <pipeline/lock.h>
 #include <linux/percpu.h>
 #include <cobalt/kernel/assert.h>
+#include <pipeline/pipeline.h>
 
 /**
  * @addtogroup cobalt_core_lock
  *
  * @{
  */
-typedef unsigned long spl_t;
-
-/**
- * Hard disable interrupts on the local processor, saving previous state.
- *
- * @param[out] x An unsigned long integer context variable
- */
-#define splhigh(x)  ((x) = ipipe_test_and_stall_head() & 1)
-#ifdef CONFIG_SMP
-/**
- * Restore the saved hard interrupt state on the local processor.
- *
- * @param[in] x The context variable previously updated by splhigh()
- */
-#define splexit(x)  ipipe_restore_head(x & 1)
-#else /* !CONFIG_SMP */
-#define splexit(x)  ipipe_restore_head(x)
-#endif /* !CONFIG_SMP */
-/**
- * Hard disable interrupts on the local processor.
- */
-#define splmax()    ipipe_stall_head()
-/**
- * Hard enable interrupts on the local processor.
- */
-#define splnone()   ipipe_unstall_head()
-/**
- * Test hard interrupt state on the local processor.
- *
- * @return Zero if the local processor currently accepts interrupts,
- * non-zero otherwise.
- */
-#define spltest()   ipipe_test_head()
-
 #ifdef CONFIG_XENO_OPT_DEBUG_LOCKING
 
 struct xnlock {
@@ -209,13 +176,6 @@ int ___xnlock_get(struct xnlock *lock /*, */ XNLOCK_DBG_CONTEXT_ARGS);
 void ___xnlock_put(struct xnlock *lock /*, */ XNLOCK_DBG_CONTEXT_ARGS);
 #endif /* out of line xnlock */
 
-#ifdef CONFIG_XENO_OPT_DEBUG_LOCKING
-/* Disable UP-over-SMP kernel optimization in debug mode. */
-#define __locking_active__  1
-#else
-#define __locking_active__  ipipe_smp_p
-#endif
-
 static inline spl_t
 __xnlock_get_irqsave(struct xnlock *lock /*, */ XNLOCK_DBG_CONTEXT_ARGS)
 {
diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 894e6f67e..84309d0b1 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -32,6 +32,7 @@
 #include <linux/cdev.h>
 #include <linux/wait.h>
 #include <linux/notifier.h>
+#include <pipeline/lock.h>
 #include <xenomai/version.h>
 #include <cobalt/kernel/heap.h>
 #include <cobalt/kernel/sched.h>
@@ -541,13 +542,13 @@ rtdm_execute_atomically(void) { }
 /**
  * Static lock initialisation
  */
-#define RTDM_LOCK_UNLOCKED(__name)	IPIPE_SPIN_LOCK_UNLOCKED
+#define RTDM_LOCK_UNLOCKED(__name)	PIPELINE_SPIN_LOCK_UNLOCKED(__name)
 
 #define DEFINE_RTDM_LOCK(__name)		\
 	rtdm_lock_t __name = RTDM_LOCK_UNLOCKED(__name)
 
 /** Lock variable */
-typedef ipipe_spinlock_t rtdm_lock_t;
+typedef pipeline_spinlock_t rtdm_lock_t;
 
 /** Variable to save the context while holding a lock */
 typedef unsigned long rtdm_lockctx_t;
@@ -606,7 +607,7 @@ static inline rtdm_lockctx_t __rtdm_lock_get_irqsave(rtdm_lock_t *lock)
 {
 	rtdm_lockctx_t context;
 
-	context = ipipe_test_and_stall_head();
+	splhigh(context);
 	raw_spin_lock(lock);
 	xnsched_lock();
 
@@ -626,7 +627,7 @@ void rtdm_lock_put_irqrestore(rtdm_lock_t *lock, rtdm_lockctx_t context)
 {
 	raw_spin_unlock(lock);
 	xnsched_unlock();
-	ipipe_restore_head(context);
+	splexit(context);
 }
 
 /**
-- 
2.26.2


