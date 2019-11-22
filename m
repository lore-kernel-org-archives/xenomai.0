From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 7/7] cobalt/sched: block CPU migration when rescheduling over
 root
Date: Fri, 22 Nov 2019 18:19:49 +0100
Message-Id: <20191122171949.18021-8-rpm@xenomai.org>
In-Reply-To: <20191122171949.18021-1-rpm@xenomai.org>
References: <20191122171949.18021-1-rpm@xenomai.org>
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

In seldom cases, we might call xnsched_run() from the root context.
This call might be subject to CPU migration as the root stage would
likely be unstalled. In such a case, block CPU migration entirely
while checking for early exit conditions which involves accessing
per-cpu data.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/sched.h | 39 ++++++++++++++---------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/include/cobalt/kernel/sched.h b/include/cobalt/kernel/sched.h
index c66e29d4c..4adfccb75 100644
--- a/include/cobalt/kernel/sched.h
+++ b/include/cobalt/kernel/sched.h
@@ -300,26 +300,6 @@ static inline int __xnsched_run(struct xnsched *sched)
 	/*
 	 * Reschedule if XNSCHED is pending, but never over an IRQ
 	 * handler or in the middle of unlocked context switch.
-	 *
-	 * NOTE: Since ___xnsched_run() won't run immediately if an
-	 * escalation to primary domain is needed, we won't use
-	 * critical scheduler information before we actually run in
-	 * primary mode; therefore we can first test the scheduler
-	 * status then escalate.
-	 *
-	 * Running in the primary domain means that no Linux-triggered
-	 * CPU migration may occur from that point either. Finally,
-	 * since migration is always a self-directed operation for
-	 * Xenomai threads, we can safely read the scheduler state
-	 * bits without holding the nklock.
-	 *
-	 * Said differently, if we race here because of a CPU
-	 * migration, it must have been Linux-triggered because we run
-	 * in secondary mode; in which case we will escalate to the
-	 * primary domain, then unwind the current call frame without
-	 * running the rescheduling procedure in
-	 * ___xnsched_run(). Therefore, the scheduler slot
-	 * (i.e. "sched") will be either valid, or unused.
 	 */
 	if (((sched->status|sched->lflags) &
 	     (XNINIRQ|XNINSW|XNRESCHED)) != XNRESCHED)
@@ -332,11 +312,24 @@ static inline int xnsched_run(void)
 {
 	struct xnsched *sched = xnsched_current();
 	struct xnthread *curr = sched->curr;
+	int ret = 0;
+	spl_t s;
 
-	if (unlikely(curr->lock_count > 0))
-		return 0;
+	/*
+	 * If running over any root thread, make sure to lock out CPU
+	 * migration in order to always refer to the proper
+	 * runqueue. Otherwise, we are running in primary mode and as
+	 * such cannot change CPU.
+	 */
+	if (unlikely(xnthread_test_state(curr, XNROOT))) {
+		splhigh(s);
+		/* xnsched_pick_next() will check for lock count. */
+		ret = __xnsched_run(xnsched_current());
+		splexit(s);
+	} else if (likely(curr->lock_count == 0))
+		ret = __xnsched_run(sched);
 
-	return __xnsched_run(sched);
+	return ret;
 }
 
 void xnsched_lock(void);
-- 
2.21.0


