From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt: sched-quota: Fix live-updating if quotas, once more
Message-ID: <35b12f3f-f3ac-012b-ab5e-0b225324dff3@siemens.com>
Date: Tue, 17 Dec 2019 20:36:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

f116e7eb9b56 already tried to enable live updates of a quota group but
got one thing wrong and missed another catch:

First, we must not use group_is_active() to check if the group is
currently consuming time. That has to be the same logic as in
xnsched_quota_pick(), i.e. a check of the currently running thread on
the target sched belongs to the modified group.

The second issue is that, if a group had no budget on refill or consumed
it in this period already, an extension of the budget missed to move
expired threads back to the runqueue.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/sched-quota.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/sched-quota.c b/kernel/cobalt/sched-quota.c
index bb31833088..4c3383b5f6 100644
--- a/kernel/cobalt/sched-quota.c
+++ b/kernel/cobalt/sched-quota.c
@@ -584,8 +584,10 @@ void xnsched_quota_set_limit(struct xnsched_quota_group *tg,
 			     int quota_percent, int quota_peak_percent,
 			     int *quota_sum_r)
 {
-	struct xnsched_quota *qs = &tg->sched->quota;
+	struct xnsched *sched = tg->sched;
+	struct xnsched_quota *qs = &sched->quota;
 	xnticks_t old_quota_ns = tg->quota_ns;
+	struct xnthread *thread, *tmp, *curr;
 	xnticks_t now, elapsed, consumed;
 
 	atomic_only();
@@ -611,7 +613,9 @@ void xnsched_quota_set_limit(struct xnsched_quota_group *tg,
 	tg->quota_percent = quota_percent;
 	tg->quota_peak_percent = quota_peak_percent;
 
-	if (group_is_active(tg)) {
+	curr = sched->curr;
+	if (curr->quota == tg &&
+	    xnthread_test_state(curr, XNREADY|XNTHREAD_BLOCK_BITS) == 0) {
 		now = xnclock_read_monotonic(&nkclock);
 
 		elapsed = now - tg->run_start_ns;
@@ -638,11 +642,19 @@ void xnsched_quota_set_limit(struct xnsched_quota_group *tg,
 
 	*quota_sum_r = quota_sum_all(qs);
 
+	if (tg->run_budget_ns > 0) {
+		list_for_each_entry_safe_reverse(thread, tmp, &tg->expired,
+						 quota_expired) {
+			list_del_init(&thread->quota_expired);
+			xnsched_addq(&sched->rt.runnable, thread);
+		}
+	}
+
 	/*
 	 * Apply the new budget immediately, in case a member of this
 	 * group is currently running.
 	 */
-	xnsched_set_resched(tg->sched);
+	xnsched_set_resched(sched);
 	xnsched_run();
 }
 EXPORT_SYMBOL_GPL(xnsched_quota_set_limit);
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

