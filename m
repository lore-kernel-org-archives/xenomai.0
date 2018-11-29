From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 3/5] cobalt/sched: sporadic: add early parameter checking
 handler
Date: Thu, 29 Nov 2018 14:54:15 +0100
Message-Id: <20181129135417.29797-3-rpm@xenomai.org>
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

Move parameter checks from sched_declare() to the new sched_chkparam()
handler, which runs early and unconditionally from
xnsched_set_policy().

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/sched-sporadic.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/cobalt/sched-sporadic.c b/kernel/cobalt/sched-sporadic.c
index 4d307a803..77f1d00fd 100644
--- a/kernel/cobalt/sched-sporadic.c
+++ b/kernel/cobalt/sched-sporadic.c
@@ -290,11 +290,9 @@ static void xnsched_sporadic_protectprio(struct xnthread *thread, int prio)
 	thread->cprio = prio;
 }
 
-static int xnsched_sporadic_declare(struct xnthread *thread,
-				    const union xnsched_policy_param *p)
+static int xnsched_sporadic_chkparam(struct xnthread *thread,
+				     const union xnsched_policy_param *p)
 {
-	struct xnsched_sporadic_data *pss;
-
 	if (p->pss.low_prio != -1 &&
 	    (p->pss.low_prio < XNSCHED_SPORADIC_MIN_PRIO ||
 	     p->pss.low_prio > XNSCHED_SPORADIC_MAX_PRIO))
@@ -319,6 +317,14 @@ static int xnsched_sporadic_declare(struct xnthread *thread,
 	if (p->pss.max_repl < 1 || p->pss.max_repl > MAX_REPLENISH)
 		return -EINVAL;
 
+	return 0;
+}
+
+static int xnsched_sporadic_declare(struct xnthread *thread,
+				    const union xnsched_policy_param *p)
+{
+	struct xnsched_sporadic_data *pss;
+
 	pss = xnmalloc(sizeof(*pss));
 	if (pss == NULL)
 		return -ENOMEM;
@@ -535,6 +541,7 @@ struct xnsched_class xnsched_class_sporadic = {
 	.sched_tick		=	NULL,
 	.sched_rotate		=	NULL,
 	.sched_migrate		=	NULL,
+	.sched_chkparam		=	xnsched_sporadic_chkparam,
 	.sched_setparam		=	xnsched_sporadic_setparam,
 	.sched_getparam		=	xnsched_sporadic_getparam,
 	.sched_trackprio	=	xnsched_sporadic_trackprio,
-- 
2.17.2


