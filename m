From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 2/5] cobalt/sched: quota: add early parameter checking handler
Date: Thu, 29 Nov 2018 14:54:14 +0100
Message-Id: <20181129135417.29797-2-rpm@xenomai.org>
In-Reply-To: <20181129135417.29797-1-rpm@xenomai.org>
References: <20181129135417.29797-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

This is actually a plain conversion of the former sched_declare()
handler to the recently introduced sched_chkparam(), which solely
checks the parameter block.

By doing so, we ensure that those checks are done early and
unconditionally in xnsched_set_policy().

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/sched-quota.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/sched-quota.c b/kernel/cobalt/sched-quota.c
index 7e58f1b37..b2f24cbb9 100644
--- a/kernel/cobalt/sched-quota.c
+++ b/kernel/cobalt/sched-quota.c
@@ -293,8 +293,8 @@ static void xnsched_quota_protectprio(struct xnthread *thread, int prio)
 	thread->cprio = prio;
 }
 
-static int xnsched_quota_declare(struct xnthread *thread,
-				 const union xnsched_policy_param *p)
+static int xnsched_quota_chkparam(struct xnthread *thread,
+				  const union xnsched_policy_param *p)
 {
 	struct xnsched_quota_group *tg;
 	struct xnsched_quota *qs;
@@ -789,11 +789,11 @@ struct xnsched_class xnsched_class_quota = {
 	.sched_tick		=	NULL,
 	.sched_rotate		=	NULL,
 	.sched_migrate		=	xnsched_quota_migrate,
+	.sched_chkparam		=	xnsched_quota_chkparam,
 	.sched_setparam		=	xnsched_quota_setparam,
 	.sched_getparam		=	xnsched_quota_getparam,
 	.sched_trackprio	=	xnsched_quota_trackprio,
 	.sched_protectprio	=	xnsched_quota_protectprio,
-	.sched_declare		=	xnsched_quota_declare,
 	.sched_forget		=	xnsched_quota_forget,
 	.sched_kick		=	xnsched_quota_kick,
 #ifdef CONFIG_XENO_OPT_VFILE
-- 
2.17.2


