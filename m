From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH v2 7/7] cobalt/sched: restrict rescheduling hints to
 migration-safe context
Date: Sun, 24 Nov 2019 16:46:08 +0100
Message-Id: <20191124154608.9353-7-rpm@xenomai.org>
In-Reply-To: <20191124154608.9353-1-rpm@xenomai.org>
References: <20191124154608.9353-1-rpm@xenomai.org>
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

XNINIRQ, XNINSW and XNSCHED are quick hints loaded from per-cpu data
which are considered by the main rescheduling call (xnsched_run()) to
figure out whether the actual rescheduling backend (___xnsched_run())
should actually run immediately, or be postponed to a later call.

In seldom cases, we might call xnsched_run() from the root thread with
hard irqs enabled.  Because such requests also depend on those hints,
they are sensitive to CPU migration. The changes address this issue,
considering that such requests can be forwarded to ___xnsched_run()
directly - ignoring the hints - because the following premises apply
in this case:

- XNINIRQ must be cleared, since that one only appears when serving an
  IRQ from the head domain, in which case hard irqs must be disabled.

- XNINSW must be cleared, since it frames a Cobalt context switch,
  which can only happen from the head domain with hard irqs disabled
  too.

- the lock count is irrelevant for the root thread if hard irqs are
  enabled, and should be ignored as such (see
  xnsched_lock()). Disabling hard interrupts is the only way to
  prevent the root stage from being preempted by actual Cobalt
  threads.

- if xnsched_run() is called by a Cobalt interrupt handler which has
  preempted the root thread then unwinds
  (e.g. xnintr_core_clock_handler()), hard irqs are disabled, in which
  case the XNSCHED hint must be considered first.

Otherwise, we can safely assume that calling xnsched_run() from the
root stage with hard irqs enabled should cause an actual rescheduling
in most cases, either on the local CPU or remotely, following some
Cobalt syscall.  So far, only Cobalt thread creation and deletion
events are known to trigger potentially nop rescheduling requests, and
those are definitely slow paths already. In any case, ___xnsched_run()
ignores useless calls, so no harm done with infrequent invocations
from such paths.

This prevents any CPU migration issue by accessing per-cpu scheduler
data only when hard interrupts are disabled.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/sched.h | 37 ++++++++++++-----------------------
 kernel/cobalt/sched.c         |  6 +++++-
 2 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/include/cobalt/kernel/sched.h b/include/cobalt/kernel/sched.h
index c66e29d4c..55581148e 100644
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
@@ -331,12 +311,21 @@ static inline int __xnsched_run(struct xnsched *sched)
 static inline int xnsched_run(void)
 {
 	struct xnsched *sched = xnsched_current();
-	struct xnthread *curr = sched->curr;
+	struct xnthread *curr = READ_ONCE(sched->curr);
+	int ret = 0;
 
-	if (unlikely(curr->lock_count > 0))
-		return 0;
+	/*
+	 * If running over the root thread and hard irqs are enabled,
+	 * kick the rescheduling procedure unconditionally: no hints
+	 * apply.
+	 */
+	if (unlikely(xnthread_test_state(curr, XNROOT) &&
+			!hard_irqs_disabled())) {
+		ret = ___xnsched_run(sched);
+	} else if (likely(curr->lock_count == 0))
+		ret = __xnsched_run(sched);
 
-	return __xnsched_run(sched);
+	return ret;
 }
 
 void xnsched_lock(void);
diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index 74dc7a961..024431af2 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -1000,7 +1000,11 @@ reschedule:
 
 	trace_cobalt_switch_context(prev, next);
 
-	sched->curr = next;
+	/*
+	 * sched->curr is shared locklessly with xnsched_run(), be
+	 * careful about load/store tearing.
+	 */
+	WRITE_ONCE(sched->curr, next);
 	shadow = 1;
 
 	if (xnthread_test_state(prev, XNROOT)) {
-- 
2.21.0


