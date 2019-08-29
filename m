From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/sched-quota: Allow NULL quota_sum_r in
Message-ID: <89de0897-bdea-0663-ff97-d40895112d3c@siemens.com>
Date: Thu, 29 Aug 2019 16:55:10 +0200
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

Avoids pointless dummy variables on the call-site.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/sched.c | 5 +----
 kernel/cobalt/sched-quota.c | 3 ++-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/cobalt/posix/sched.c b/kernel/cobalt/posix/sched.c
index 103f855340..f018ac3e8e 100644
--- a/kernel/cobalt/posix/sched.c
+++ b/kernel/cobalt/posix/sched.c
@@ -830,9 +830,6 @@ void cobalt_sched_reclaim(struct cobalt_process *process)
 {
 	struct cobalt_resources *p = &process->resources;
 	struct cobalt_sched_group *group;
-#ifdef CONFIG_XENO_OPT_SCHED_QUOTA
-	int quota_sum;
-#endif
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
@@ -840,7 +837,7 @@ void cobalt_sched_reclaim(struct cobalt_process *process)
 	while (!list_empty(&p->schedq)) {
 		group = list_get_entry(&p->schedq, struct cobalt_sched_group, next);
 #ifdef CONFIG_XENO_OPT_SCHED_QUOTA
-		xnsched_quota_destroy_group(&group->quota, 1, &quota_sum);
+		xnsched_quota_destroy_group(&group->quota, 1, NULL);
 #endif
 		xnlock_put_irqrestore(&nklock, s);
 		xnfree(group);
diff --git a/kernel/cobalt/sched-quota.c b/kernel/cobalt/sched-quota.c
index 79b9e5c907..bb31833088 100644
--- a/kernel/cobalt/sched-quota.c
+++ b/kernel/cobalt/sched-quota.c
@@ -573,7 +573,8 @@ int xnsched_quota_destroy_group(struct xnsched_quota_group *tg,
 	if (list_empty(&qs->groups))
 		xntimer_stop(&qs->refill_timer);
 
-	*quota_sum_r = quota_sum_all(qs);
+	if (quota_sum_r)
+		*quota_sum_r = quota_sum_all(qs);
 
 	return 0;
 }
-- 

2.16.4

