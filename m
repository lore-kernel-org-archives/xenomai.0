From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH v2 6/7] cobalt/sched: drop useless rmb in lock check
Date: Sun, 24 Nov 2019 16:46:07 +0100
Message-Id: <20191124154608.9353-6-rpm@xenomai.org>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/sched.h | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/cobalt/kernel/sched.h b/include/cobalt/kernel/sched.h
index 3b0825d67..c66e29d4c 100644
--- a/include/cobalt/kernel/sched.h
+++ b/include/cobalt/kernel/sched.h
@@ -298,6 +298,9 @@ void __xnsched_run_handler(void);
 static inline int __xnsched_run(struct xnsched *sched)
 {
 	/*
+	 * Reschedule if XNSCHED is pending, but never over an IRQ
+	 * handler or in the middle of unlocked context switch.
+	 *
 	 * NOTE: Since ___xnsched_run() won't run immediately if an
 	 * escalation to primary domain is needed, we won't use
 	 * critical scheduler information before we actually run in
@@ -328,15 +331,9 @@ static inline int __xnsched_run(struct xnsched *sched)
 static inline int xnsched_run(void)
 {
 	struct xnsched *sched = xnsched_current();
-	/*
-	 * No rescheduling is possible, either if:
-	 *
-	 * - the current thread holds the scheduler lock
-	 * - an ISR context is active
-	 * - we are caught in the middle of an unlocked context switch.
-	 */
-	smp_rmb();
-	if (unlikely(sched->curr->lock_count > 0))
+	struct xnthread *curr = sched->curr;
+
+	if (unlikely(curr->lock_count > 0))
 		return 0;
 
 	return __xnsched_run(sched);
-- 
2.21.0


