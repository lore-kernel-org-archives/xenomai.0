From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 4/5] cobalt/sched: tp: add early parameter checking handler
Date: Thu, 29 Nov 2018 14:54:16 +0100
Message-Id: <20181129135417.29797-4-rpm@xenomai.org>
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
 kernel/cobalt/sched-tp.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/cobalt/sched-tp.c b/kernel/cobalt/sched-tp.c
index 982d95e6e..d3e2586b0 100644
--- a/kernel/cobalt/sched-tp.c
+++ b/kernel/cobalt/sched-tp.c
@@ -163,17 +163,24 @@ static void xnsched_tp_protectprio(struct xnthread *thread, int prio)
 	thread->cprio = prio;
 }
 
-static int xnsched_tp_declare(struct xnthread *thread,
-			      const union xnsched_policy_param *p)
+static int xnsched_tp_chkparam(struct xnthread *thread,
+			       const union xnsched_policy_param *p)
 {
-	struct xnsched *sched = thread->sched;
-	struct xnsched_tp *tp = &sched->tp;
+	struct xnsched_tp *tp = &thread->sched->tp;
 
 	if (tp->gps == NULL ||
 	    p->tp.prio < XNSCHED_TP_MIN_PRIO ||
 	    p->tp.prio > XNSCHED_TP_MAX_PRIO)
 		return -EINVAL;
 
+	return 0;
+}
+
+static int xnsched_tp_declare(struct xnthread *thread,
+			      const union xnsched_policy_param *p)
+{
+	struct xnsched *sched = thread->sched;
+
 	list_add_tail(&thread->tp_link, &sched->tp.threads);
 
 	return 0;
@@ -434,6 +441,7 @@ struct xnsched_class xnsched_class_tp = {
 	.sched_tick		=	NULL,
 	.sched_rotate		=	NULL,
 	.sched_migrate		=	xnsched_tp_migrate,
+	.sched_chkparam		=	xnsched_tp_chkparam,
 	.sched_setparam		=	xnsched_tp_setparam,
 	.sched_getparam		=	xnsched_tp_getparam,
 	.sched_trackprio	=	xnsched_tp_trackprio,
-- 
2.17.2


