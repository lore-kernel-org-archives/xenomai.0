From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Sat, 13 Oct 2012 13:30:11 +0200
Message-Id: <1350127811-776-1-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <50795024.4010506@xenomai.org>
References: <50795024.4010506@xenomai.org>
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
weight for this case, we try and make them a bit lighter, by avoiding
entering __xnpod_schedule when xnpod_unlock_sched is called without
the rescheduling bit set.
---
 include/rtdm/rtdm_driver.h |   24 +++++++++++++++++++-----
 ksrc/nucleus/pod.c         |    7 ++++++-
 ksrc/nucleus/sched-rt.c    |    5 ++---
 ksrc/nucleus/sched.c       |    8 --------
 4 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index 3006d59..8b01f04 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -668,7 +668,9 @@ int rtdm_select_bind(int fd, rtdm_selector_t *selector,
 	spl_t __rtdm_s;					\
 							\
 	xnlock_get_irqsave(&nklock, __rtdm_s);		\
+	__xnpod_lock_sched();				\
 	code_block;					\
+	__xnpod_unlock_sched();				\
 	xnlock_put_irqrestore(&nklock, __rtdm_s);	\
 }
 #endif
@@ -730,6 +732,7 @@ typedef unsigned long rtdm_lockctx_t;
 	do {							\
 		XENO_BUGON(RTDM, !rthal_local_irq_disabled());	\
 		rthal_spin_lock(lock);				\
+		__xnpod_lock_sched();				\
 	} while (0)
 #endif
 
@@ -749,7 +752,11 @@ typedef unsigned long rtdm_lockctx_t;
  *
  * Rescheduling: never.
  */
-#define rtdm_lock_put(lock)	rthal_spin_unlock(lock)
+#define rtdm_lock_put(lock)			\
+	do {					\
+		rthal_spin_unlock(lock);	\
+		__xnpod_unlock_sched();		\
+	} while (0)
 
 /**
  * Acquire lock and disable preemption
@@ -768,8 +775,11 @@ typedef unsigned long rtdm_lockctx_t;
  *
  * Rescheduling: never.
  */
-#define rtdm_lock_get_irqsave(lock, context)	\
-	rthal_spin_lock_irqsave(lock, context)
+#define rtdm_lock_get_irqsave(lock, context)		\
+	do {						\
+		rthal_spin_lock_irqsave(lock, context);	\
+		__xnpod_lock_sched();			\
+	} while (0)
 
 /**
  * Release lock and restore preemption state
@@ -788,8 +798,12 @@ typedef unsigned long rtdm_lockctx_t;
  *
  * Rescheduling: possible.
  */
-#define rtdm_lock_put_irqrestore(lock, context)	\
-	rthal_spin_unlock_irqrestore(lock, context)
+#define rtdm_lock_put_irqrestore(lock, context)		\
+	do {						\
+		rthal_spin_unlock(lock);		\
+		__xnpod_unlock_sched();			\
+		rthal_local_irq_restore(context);	\
+	} while (0)
 
 /**
  * Disable preemption locally
diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 7c56abc..0f801fe 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -2203,6 +2203,12 @@ reschedule:
 	if (!need_resched)
 		goto signal_unlock_and_exit;
 #endif /* !XENO_DEBUG(NUCLEUS) */
+	if (xnthread_test_state(curr, XNTHREAD_BLOCK_BITS|XNLOCK) == XNLOCK) {
+		/* scheduler is locked, thread is not suspending */
+		xnsched_set_self_resched(sched);
+		goto signal_unlock_and_exit;
+	}
+
 	zombie = xnthread_test_state(curr, XNZOMBIE);
 
 	next = xnsched_pick_next(sched);
@@ -2347,7 +2353,6 @@ void ___xnpod_unlock_sched(struct xnthread *curr)
 {
 	if (--xnthread_lock_count(curr) == 0) {
 		xnthread_clear_state(curr, XNLOCK);
-		xnsched_set_self_resched(curr->sched);
 		xnpod_schedule();
 	}
 }
diff --git a/ksrc/nucleus/sched-rt.c b/ksrc/nucleus/sched-rt.c
index a167af6..8d17dca 100644
--- a/ksrc/nucleus/sched-rt.c
+++ b/ksrc/nucleus/sched-rt.c
@@ -81,11 +81,10 @@ static void xnsched_rt_rotate(struct xnsched *sched,
 	/*
 	 * In case we picked the current thread, we have to make sure
 	 * not to move it back to the runnable queue if it was blocked
-	 * before we were called. The same goes if the current thread
-	 * holds the scheduler lock.
+	 * before we were called.
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
-- 
1.7.2.5


