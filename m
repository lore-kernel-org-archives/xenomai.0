From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/sched-quota: Account for already consumed time on
 limit update
Message-ID: <b886e67a-66e2-c0d0-c646-65bccd58dc0f@siemens.com>
Date: Wed, 21 Nov 2018 17:59:24 +0100
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
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

If we change the quota value of thread group, we should take its already
consumed time during the current cycle into account. So far, we refilled
the budget blindly, which could have given the group an uncontrolled
"peak".

This commit first update the run_budget_ns of an active group and kills
its limit timer. Then it refills run_budget_ns only with the remaining
budget of the current cycle, taking the new quota as limit.

Accumulated credits are still dropped - not worth to deal with their
complexity in this scenario.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Philippe, review would be appreciated.

I'm still struggling with writing a good test case for that.

 kernel/cobalt/sched-quota.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/sched-quota.c b/kernel/cobalt/sched-quota.c
index 817699457e..7e58f1b374 100644
--- a/kernel/cobalt/sched-quota.c
+++ b/kernel/cobalt/sched-quota.c
@@ -572,6 +572,8 @@ void xnsched_quota_set_limit(struct xnsched_quota_group *tg,
 			     int *quota_sum_r)
 {
 	struct xnsched_quota *qs = &tg->sched->quota;
+	xnticks_t old_quota_ns = tg->quota_ns;
+	xnticks_t now, elapsed, consumed;
 
 	atomic_only();
 
@@ -592,7 +594,30 @@ void xnsched_quota_set_limit(struct xnsched_quota_group *tg,
 
 	tg->quota_percent = quota_percent;
 	tg->quota_peak_percent = quota_peak_percent;
-	tg->run_budget_ns = tg->quota_ns;
+
+	if (group_is_active(tg)) {
+		now = xnclock_read_monotonic(&nkclock);
+
+		elapsed = now - tg->run_start_ns;
+		if (elapsed < tg->run_budget_ns)
+			tg->run_budget_ns -= elapsed;
+		else
+			tg->run_budget_ns = 0;
+
+		tg->run_start_ns = now;
+
+		xntimer_stop(&qs->limit_timer);
+	}
+
+	if (tg->run_budget_ns <= old_quota_ns)
+		consumed = old_quota_ns - tg->run_budget_ns;
+	else
+		consumed = 0;
+	if (tg->quota_ns >= consumed)
+		tg->run_budget_ns = tg->quota_ns - consumed;
+	else
+		tg->run_budget_ns = 0;
+
 	tg->run_credit_ns = 0;	/* Drop accumulated credit. */
 
 	*quota_sum_r = quota_sum_all(qs);
-- 
2.16.4

