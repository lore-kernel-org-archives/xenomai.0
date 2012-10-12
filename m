From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Fri, 12 Oct 2012 08:26:17 +0200
Message-Id: <1350023177-8123-1-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <5077B799.5000408@xenomai.org>
References: <5077B799.5000408@xenomai.org>
Subject: [Xenomai] [PATCH 1/1] rtdm: get spinlocks to lock the scheduler
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
weight for this case, we try and reimplement a lighter version.
---
 include/nucleus/pod.h      |   35 +++++++++++++++-----------------
 include/nucleus/sched.h    |    3 +-
 include/nucleus/thread.h   |    2 +-
 include/rtdm/rtdm_driver.h |   22 +++++++++++++++----
 ksrc/nucleus/pod.c         |   47 +++++++++++++++++++++++--------------------
 ksrc/nucleus/sched-rt.c    |    2 +-
 ksrc/nucleus/sched.c       |    8 -------
 ksrc/nucleus/shadow.c      |    7 ++++++
 8 files changed, 69 insertions(+), 57 deletions(-)

diff --git a/include/nucleus/pod.h b/include/nucleus/pod.h
index 06361ff..d7e81e8 100644
--- a/include/nucleus/pod.h
+++ b/include/nucleus/pod.h
@@ -180,7 +180,7 @@ void __xnpod_schedule(struct xnsched *sched);
 #endif
 
 #define xnpod_locked_p() \
-    xnthread_test_state(xnpod_current_thread(), XNLOCK)
+    testbits(xnpod_current_sched()->status, XNSWLOCK)
 
 #define xnpod_unblockable_p() \
     (xnpod_asynch_p() || xnthread_test_state(xnpod_current_thread(), XNROOT))
@@ -288,47 +288,44 @@ static inline void xnpod_schedule(void)
 	__xnpod_schedule(sched);
 }
 
-void ___xnpod_lock_sched(struct xnthread *curr);
-
-void ___xnpod_unlock_sched(struct xnthread *curr);
-
 static inline void __xnpod_lock_sched(void)
 {
-	struct xnthread *curr;
+	struct xnsched *sched;
 
-	barrier();
-	curr = xnpod_current_thread();
-	___xnpod_lock_sched(curr);
+	sched = xnpod_current_sched();
+	if (sched->lock_count++ == 0) {
+		setbits(sched->status, XNSWLOCK);
+		xnthread_set_state(sched->curr, XNLOCK);
+	}
 }
 
 static inline void __xnpod_unlock_sched(void)
 {
-	struct xnthread *curr;
+	struct xnsched *sched;
 
-	barrier();
-	curr = xnpod_current_thread();
-	___xnpod_unlock_sched(curr);
+	sched = xnpod_current_sched();
+	if (--sched->lock_count == 0) {
+		xnthread_clear_state(sched->curr, XNLOCK);
+		clrbits(sched->status, XNSWLOCK);
+		xnpod_schedule();
+	}
 }
 
 static inline void xnpod_lock_sched(void)
 {
-	struct xnthread *curr;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
-	curr = xnpod_current_thread();
-	___xnpod_lock_sched(curr);
+	__xnpod_lock_sched();
 	xnlock_put_irqrestore(&nklock, s);
 }
 
 static inline void xnpod_unlock_sched(void)
 {
-	struct xnthread *curr;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
-	curr = xnpod_current_thread();
-	___xnpod_unlock_sched(curr);
+	__xnpod_unlock_sched();
 	xnlock_put_irqrestore(&nklock, s);
 }
 
diff --git a/include/nucleus/sched.h b/include/nucleus/sched.h
index 6ce9228..b15cafd 100644
--- a/include/nucleus/sched.h
+++ b/include/nucleus/sched.h
@@ -40,7 +40,7 @@
 /* Sched status flags */
 #define XNKCOUT		0x80000000	/* Sched callout context */
 #define XNINTCK		0x40000000	/* In master tick handler context */
-#define XNSWLOCK	0x20000000	/* In context switch */
+#define XNSWLOCK	0x20000000	/* Scheduler is locked */
 #define XNRESCHED	0x10000000	/* Needs rescheduling */
 
 /* Sched local flags */
@@ -82,6 +82,7 @@ typedef struct xnsched {
 
 	xntimerq_t timerqueue;		/* !< Core timer queue. */
 	volatile unsigned inesting;	/*!< Interrupt nesting level. */
+	unsigned lock_count;		/*!< Scheduler lock count */
 	struct xntimer htimer;		/*!< Host timer. */
 	struct xnthread *zombie;
 	struct xnthread rootcb;		/*!< Root thread control block. */
diff --git a/include/nucleus/thread.h b/include/nucleus/thread.h
index 8934e19..5e4e7cc 100644
--- a/include/nucleus/thread.h
+++ b/include/nucleus/thread.h
@@ -234,7 +234,7 @@ typedef struct xnthread {
 
 	int cprio;			/* Current priority */
 
-	u_long schedlck;		/*!< Scheduler lock count. */
+	u_long schedlck;		/*!< Saved scheduler lock count. */
 
 	xnpholder_t rlink;		/* Thread holder in ready queue */
 
diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index 3006d59..053df78 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -730,6 +730,7 @@ typedef unsigned long rtdm_lockctx_t;
 	do {							\
 		XENO_BUGON(RTDM, !rthal_local_irq_disabled());	\
 		rthal_spin_lock(lock);				\
+		__xnpod_lock_sched();				\
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
+		__xnpod_unlock_sched();				\
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
+		__xnpod_lock_sched();					\
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
+		__xnpod_unlock_sched();				\
+		rthal_local_irq_restore(context);		\
+	} while (0)
 
 /**
  * Disable preemption locally
diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 7c56abc..2fdfccb 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -844,8 +844,10 @@ static void xnpod_reset_thread(struct xnthread *thread)
 	thread->signals = 0;
 
 	if (xnthread_test_state(thread, XNLOCK)) {
+		struct xnsched *sched;
+		sched = thread->sched;
 		xnthread_clear_state(thread, XNLOCK);
-		xnthread_lock_count(thread) = 0;
+		clrbits(sched->status, XNSWLOCK);
 	}
 }
 
@@ -1002,11 +1004,14 @@ EXPORT_SYMBOL_GPL(xnpod_restart_thread);
 xnflags_t xnpod_set_thread_mode(xnthread_t *thread,
 				xnflags_t clrmask, xnflags_t setmask)
 {
-	xnthread_t *curr = xnpod_current_thread();
 	xnflags_t oldmode;
+	xnthread_t *curr;
+	xnsched_t *sched;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
+	sched = xnpod_current_sched();
+	curr = sched->curr;
 
 	trace_mark(xn_nucleus, thread_setmode,
 		   "thread %p thread_name %s clrmask %lu setmask %lu",
@@ -1021,8 +1026,11 @@ xnflags_t xnpod_set_thread_mode(xnthread_t *thread,
 			if (xnthread_test_state(thread, XNLOCK))
 				/* Actually grab the scheduler lock. */
 				xnpod_lock_sched();
-		} else if (!xnthread_test_state(thread, XNLOCK))
-			xnthread_lock_count(thread) = 0;
+		} else if (!xnthread_test_state(thread, XNLOCK)) {
+			sched->lock_count = 0;
+			__clrbits(sched->status, XNSWLOCK);
+			xnpod_schedule();
+		}
 	}
 
 	xnlock_put_irqrestore(&nklock, s);
@@ -1452,6 +1460,11 @@ void xnpod_suspend_thread(xnthread_t *thread, xnflags_t mask,
 #endif /* __XENO_SIM__ */
 
 	if (thread == sched->curr) {
+		thread->schedlck = sched->lock_count;
+		sched->lock_count = 0;
+		if (thread->schedlck)
+			__clrbits(sched->status, XNSWLOCK);
+
 		/*
 		 * If the current thread is being relaxed, we must
 		 * have been called from xnshadow_relax(), in which
@@ -1896,7 +1909,7 @@ int __xnpod_set_thread_schedparam(struct xnthread *thread,
 	 * - we currently hold the scheduler lock, so we don't want
 	 * any round-robin effect to take place.
 	 */
-	if (!xnthread_test_state(thread, XNTHREAD_BLOCK_BITS|XNREADY|XNLOCK))
+	if (!xnthread_test_state(thread, XNTHREAD_BLOCK_BITS|XNREADY))
 		xnsched_putback(thread);
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
@@ -2310,6 +2323,13 @@ reschedule:
 	    xnsched_maybe_resched_after_unlocked_switch(sched))
 		goto reschedule;
 
+	/* Thread with scheduler locked is waking up, restore
+	   scheduler locked state */
+	if (curr->schedlck) {
+		sched->lock_count = curr->schedlck;
+		__setbits(sched->status, XNSWLOCK);
+	}
+
 	xnlock_put_irqrestore(&nklock, s);
 
 	return;
@@ -2336,23 +2356,6 @@ reschedule:
 }
 EXPORT_SYMBOL_GPL(__xnpod_schedule);
 
-void ___xnpod_lock_sched(struct xnthread *curr)
-{
-	if (xnthread_lock_count(curr)++ == 0)
-		xnthread_set_state(curr, XNLOCK);
-}
-EXPORT_SYMBOL_GPL(___xnpod_lock_sched);
-
-void ___xnpod_unlock_sched(struct xnthread *curr)
-{
-	if (--xnthread_lock_count(curr) == 0) {
-		xnthread_clear_state(curr, XNLOCK);
-		xnsched_set_self_resched(curr->sched);
-		xnpod_schedule();
-	}
-}
-EXPORT_SYMBOL_GPL(___xnpod_unlock_sched);
-
 /*!
  * \fn int xnpod_add_hook(int type,void (*routine)(xnthread_t *))
  * \brief Install a nucleus hook.
diff --git a/ksrc/nucleus/sched-rt.c b/ksrc/nucleus/sched-rt.c
index a167af6..5fe66f3 100644
--- a/ksrc/nucleus/sched-rt.c
+++ b/ksrc/nucleus/sched-rt.c
@@ -85,7 +85,7 @@ static void xnsched_rt_rotate(struct xnsched *sched,
 	 * holds the scheduler lock.
 	 */
 	if (thread == curr &&
-	    xnthread_test_state(curr, XNTHREAD_BLOCK_BITS | XNLOCK))
+	    xnthread_test_state(curr, XNTHREAD_BLOCK_BITS))
 		return;
 
 	xnsched_putback(thread);
diff --git a/ksrc/nucleus/sched.c b/ksrc/nucleus/sched.c
index 3f4068b..9e8a656 100644
--- a/ksrc/nucleus/sched.c
+++ b/ksrc/nucleus/sched.c
@@ -208,14 +208,6 @@ struct xnthread *xnsched_pick_next(struct xnsched *sched)
 
 	if (!xnthread_test_state(curr, XNTHREAD_BLOCK_BITS | XNZOMBIE)) {
 		/*
-		 * Do not preempt the current thread if it holds the
-		 * scheduler lock.
-		 */
-		if (xnthread_test_state(curr, XNLOCK)) {
-			xnsched_set_self_resched(sched);
-			return curr;
-		}
-		/*
 		 * Push the current thread back to the runnable queue
 		 * of the scheduling class it belongs to, if not yet
 		 * linked to it (XNREADY tells us if it is).
diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 260fdef..f4988b9 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -1036,6 +1036,13 @@ redo:
 	if (xnthread_signaled_p(thread))
 		xnpod_dispatch_signals();
 
+	/* Thread with scheduler locked is waking up, restore
+	   scheduler locked state */
+	if (curr->schedlck) {
+		sched->lock_count = curr->schedlck;
+		__setbits(sched->status, XNSWLOCK);
+	}
+
 	xnlock_clear_irqon(&nklock);
 
 	/*
-- 
1.7.2.5


