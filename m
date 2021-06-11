From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 01/17] cobalt/thread: Rework kthread check for xnthread_signal
Date: Fri, 11 Jun 2021 20:05:27 +0200
Message-Id: <89662225efb0213bb31a64857ba1cc18ff9ce6cf.1623434743.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1623434743.git.jan.kiszka@siemens.com>
References: <cover.1623434743.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

We only reach lostage_task_signal for a kthread if xnthread_signal has
sent us. So move the check to the caller, making debugging easier.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/thread.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index d3a827eaa..6a3e3fa18 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2089,19 +2089,9 @@ struct lostage_signal {
 	int signo, sigval;
 };
 
-static inline void do_kthread_signal(struct task_struct *p,
-				     struct xnthread *thread,
-				     struct lostage_signal *rq)
-{
-	printk(XENO_WARNING
-	       "kernel shadow %s received unhandled signal %d (action=0x%x)\n",
-	       thread->name, rq->signo, rq->sigval);
-}
-
 static void lostage_task_signal(struct pipeline_inband_work *inband_work)
 {
 	struct lostage_signal *rq;
-	struct xnthread *thread;
 	struct task_struct *p;
 	kernel_siginfo_t si;
 	int signo;
@@ -2109,12 +2099,6 @@ static void lostage_task_signal(struct pipeline_inband_work *inband_work)
 	rq = container_of(inband_work, struct lostage_signal, inband_work);
 	p = rq->task;
 
-	thread = xnthread_from_task(p);
-	if (thread && !xnthread_test_state(thread, XNUSER)) {
-		do_kthread_signal(p, thread, rq);
-		return;
-	}
-
 	signo = rq->signo;
 
 	trace_cobalt_lostage_signal(p, signo);
@@ -2298,6 +2282,9 @@ void xnthread_signal(struct xnthread *thread, int sig, int arg)
 		.sigval = sig == SIGDEBUG ? arg | sigdebug_marker : arg,
 	};
 
+	if (XENO_WARN_ON(COBALT, !xnthread_test_state(thread, XNUSER)))
+		return;
+
 	trace_cobalt_lostage_request("signal", sigwork.task);
 
 	pipeline_post_inband_work(&sigwork);
-- 
2.26.2


