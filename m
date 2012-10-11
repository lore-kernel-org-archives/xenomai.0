From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Thu, 11 Oct 2012 08:22:41 +0200
Message-Id: <1349936561-18062-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH] rtdm: get spinlocks to lock the scheduler
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

In a context where callbacks are called with spinlocks held, it is not
possible for drivers callbacks to wake up threads without holding any
spinlock. So, we need a mechanism to lock the scheduler when a spinlock
is grabbed. As xnpod_lock_sched/xnpod_unlock_sched may be a bit heavy
weight for this case, we implement new nucleus services xnpod_spin_locked
and xnpod_spin_unlocked.
---
 include/nucleus/pod.h      |   20 ++++++++++++++++++--
 include/nucleus/sched.h    |    2 ++
 include/rtdm/rtdm_driver.h |   22 +++++++++++++++++-----
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/include/nucleus/pod.h b/include/nucleus/pod.h
index 06361ff..32e6b01 100644
--- a/include/nucleus/pod.h
+++ b/include/nucleus/pod.h
@@ -277,11 +277,11 @@ static inline void xnpod_schedule(void)
 	 * unlocked context switch.
 	 */
 #if XENO_DEBUG(NUCLEUS)
-	if (testbits(sched->status | sched->lflags, XNKCOUT|XNINIRQ|XNSWLOCK))
+	if (testbits(sched->status | sched->lflags, XNKCOUT|XNINIRQ|XNSWLOCK|XNHELDSPIN))
 		return;
 #else /* !XENO_DEBUG(NUCLEUS) */
 	if (testbits(sched->status | sched->lflags,
-		     XNKCOUT|XNINIRQ|XNSWLOCK|XNRESCHED) != XNRESCHED)
+		     XNKCOUT|XNINIRQ|XNSWLOCK|XNHELDSPIN|XNRESCHED) != XNRESCHED)
 		return;
 #endif /* !XENO_DEBUG(NUCLEUS) */
 
@@ -332,6 +332,22 @@ static inline void xnpod_unlock_sched(void)
 	xnlock_put_irqrestore(&nklock, s);
 }
 
+static inline void xnpod_spin_locked(void)
+{
+	struct xnsched *sched = xnpod_current_sched();
+	if (sched->held_spinlocks++ == 0)
+		__setbits(sched->lflags, XNHELDSPIN);
+}
+
+static inline void xnpod_spin_unlocked(void)
+{
+	struct xnsched *sched = xnpod_current_sched();
+	if (--sched->held_spinlocks == 0) {
+		__clrbits(sched->lflags, XNHELDSPIN);
+		xnpod_schedule();
+	}
+}
+
 void xnpod_fire_callouts(xnqueue_t *hookq,
 			 xnthread_t *thread);
 
diff --git a/include/nucleus/sched.h b/include/nucleus/sched.h
index 6ce9228..367c02a 100644
--- a/include/nucleus/sched.h
+++ b/include/nucleus/sched.h
@@ -47,6 +47,7 @@
 #define XNHTICK		0x00008000	/* Host tick pending  */
 #define XNINIRQ		0x00004000	/* In IRQ handling context */
 #define XNHDEFER	0x00002000	/* Host tick deferred */
+#define	XNHELDSPIN	0x00001000	/* Spinlocks held */
 
 /* Sched RPI status flags */
 #define XNRPICK		0x80000000	/* Check RPI state */
@@ -82,6 +83,7 @@ typedef struct xnsched {
 
 	xntimerq_t timerqueue;		/* !< Core timer queue. */
 	volatile unsigned inesting;	/*!< Interrupt nesting level. */
+	unsigned held_spinlocks;	/*!< Number of spinlocks held by curr */
 	struct xntimer htimer;		/*!< Host timer. */
 	struct xnthread *zombie;
 	struct xnthread rootcb;		/*!< Root thread control block. */
diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index 3006d59..a8fa471 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -730,6 +730,7 @@ typedef unsigned long rtdm_lockctx_t;
 	do {							\
 		XENO_BUGON(RTDM, !rthal_local_irq_disabled());	\
 		rthal_spin_lock(lock);				\
+		xnpod_spin_locked();				\
 	} while (0)
 #endif
 
@@ -749,7 +750,11 @@ typedef unsigned long rtdm_lockctx_t;
  *
  * Rescheduling: never.
  */
-#define rtdm_lock_put(lock)	rthal_spin_unlock(lock)
+#define rtdm_lock_put(lock)					\
+	do {							\
+		rthal_spin_unlock(lock);			\
+		xnpod_spin_unlocked();				\
+	} while (0)
 
 /**
  * Acquire lock and disable preemption
@@ -768,8 +773,11 @@ typedef unsigned long rtdm_lockctx_t;
  *
  * Rescheduling: never.
  */
-#define rtdm_lock_get_irqsave(lock, context)	\
-	rthal_spin_lock_irqsave(lock, context)
+#define rtdm_lock_get_irqsave(lock, context)				\
+	do {								\
+		rthal_spin_lock_irqsave(lock, context);			\
+		xnpod_spin_locked();					\
+	} while (0)
 
 /**
  * Release lock and restore preemption state
@@ -788,8 +796,12 @@ typedef unsigned long rtdm_lockctx_t;
  *
  * Rescheduling: possible.
  */
-#define rtdm_lock_put_irqrestore(lock, context)	\
-	rthal_spin_unlock_irqrestore(lock, context)
+#define rtdm_lock_put_irqrestore(lock, context)			\
+	do {							\
+		rthal_spin_unlock(lock);			\
+		xnpod_spin_unlocked();				\
+		rthal_local_irq_restore(context);		\
+	} while (0)
 
 /**
  * Disable preemption locally
-- 
1.7.2.5


