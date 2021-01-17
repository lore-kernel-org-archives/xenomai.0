From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 3/4] cobalt/thread: pipeline: convert to abstract root work API
Date: Sun, 17 Jan 2021 16:11:32 +0100
Message-Id: <20210117151133.478069-3-rpm@xenomai.org>
In-Reply-To: <20210117151133.478069-1-rpm@xenomai.org>
References: <20210117151133.478069-1-rpm@xenomai.org>
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

No functional change is introduced.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/thread.c | 43 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 88a4ff621..a02c09db4 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -39,6 +39,7 @@
 #include <cobalt/kernel/lock.h>
 #include <cobalt/kernel/thread.h>
 #include <pipeline/kevents.h>
+#include <pipeline/inband_work.h>
 #include <trace/events/cobalt-core.h>
 #include "debug.h"
 
@@ -1961,16 +1962,16 @@ int xnthread_harden(void)
 EXPORT_SYMBOL_GPL(xnthread_harden);
 
 struct lostage_wakeup {
-	struct ipipe_work_header work; /* Must be first. */
+	struct pipeline_inband_work inband_work; /* Must be first. */
 	struct task_struct *task;
 };
 
-static void lostage_task_wakeup(struct ipipe_work_header *work)
+static void lostage_task_wakeup(struct pipeline_inband_work *inband_work)
 {
 	struct lostage_wakeup *rq;
 	struct task_struct *p;
 
-	rq = container_of(work, struct lostage_wakeup, work);
+	rq = container_of(inband_work, struct lostage_wakeup, inband_work);
 	p = rq->task;
 
 	trace_cobalt_lostage_wakeup(p);
@@ -1981,16 +1982,14 @@ static void lostage_task_wakeup(struct ipipe_work_header *work)
 static void post_wakeup(struct task_struct *p)
 {
 	struct lostage_wakeup wakework = {
-		.work = {
-			.size = sizeof(wakework),
-			.handler = lostage_task_wakeup,
-		},
+		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(wakework,
+					lostage_task_wakeup),
 		.task = p,
 	};
 
 	trace_cobalt_lostage_request("wakeup", wakework.task);
 
-	ipipe_post_work_root(&wakework, work);
+	pipeline_post_inband_work(&wakework);
 }
 
 void __xnthread_propagate_schedparam(struct xnthread *curr)
@@ -2170,7 +2169,7 @@ void xnthread_relax(int notify, int reason)
 EXPORT_SYMBOL_GPL(xnthread_relax);
 
 struct lostage_signal {
-	struct ipipe_work_header work; /* Must be first. */
+	struct pipeline_inband_work inband_work; /* Must be first. */
 	struct task_struct *task;
 	int signo, sigval;
 };
@@ -2184,7 +2183,7 @@ static inline void do_kthread_signal(struct task_struct *p,
 	       thread->name, rq->signo, rq->sigval);
 }
 
-static void lostage_task_signal(struct ipipe_work_header *work)
+static void lostage_task_signal(struct pipeline_inband_work *inband_work)
 {
 	struct lostage_signal *rq;
 	struct xnthread *thread;
@@ -2192,7 +2191,7 @@ static void lostage_task_signal(struct ipipe_work_header *work)
 	kernel_siginfo_t si;
 	int signo;
 
-	rq = container_of(work, struct lostage_signal, work);
+	rq = container_of(inband_work, struct lostage_signal, inband_work);
 	p = rq->task;
 
 	thread = xnthread_from_task(p);
@@ -2377,10 +2376,8 @@ EXPORT_SYMBOL_GPL(xnthread_demote);
 void xnthread_signal(struct xnthread *thread, int sig, int arg)
 {
 	struct lostage_signal sigwork = {
-		.work = {
-			.size = sizeof(sigwork),
-			.handler = lostage_task_signal,
-		},
+		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(sigwork,
+					lostage_task_signal),
 		.task = xnthread_host_task(thread),
 		.signo = sig,
 		.sigval = sig == SIGDEBUG ? arg | sigdebug_marker : arg,
@@ -2388,7 +2385,7 @@ void xnthread_signal(struct xnthread *thread, int sig, int arg)
 
 	trace_cobalt_lostage_request("signal", sigwork.task);
 
-	ipipe_post_work_root(&sigwork, work);
+	pipeline_post_inband_work(&sigwork);
 }
 EXPORT_SYMBOL_GPL(xnthread_signal);
 
@@ -2423,31 +2420,29 @@ void xnthread_pin_initial(struct xnthread *thread)
 }
 
 struct parent_wakeup_request {
-	struct ipipe_work_header work; /* Must be first. */
+	struct pipeline_inband_work inband_work; /* Must be first. */
 	struct completion *done;
 };
 
-static void do_parent_wakeup(struct ipipe_work_header *work)
+static void do_parent_wakeup(struct pipeline_inband_work *inband_work)
 {
 	struct parent_wakeup_request *rq;
 
-	rq = container_of(work, struct parent_wakeup_request, work);
+	rq = container_of(inband_work, struct parent_wakeup_request, inband_work);
 	complete(rq->done);
 }
 
 static inline void wakeup_parent(struct completion *done)
 {
 	struct parent_wakeup_request wakework = {
-		.work = {
-			.size = sizeof(wakework),
-			.handler = do_parent_wakeup,
-		},
+		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(wakework,
+					do_parent_wakeup),
 		.done = done,
 	};
 
 	trace_cobalt_lostage_request("wakeup", current);
 
-	ipipe_post_work_root(&wakework, work);
+	pipeline_post_inband_work(&wakework);
 }
 
 static inline void init_kthread_info(struct xnthread *thread)
-- 
2.26.2


