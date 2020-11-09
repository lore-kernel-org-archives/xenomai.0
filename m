From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 14/15] cobalt/thread: re-implement xnthread_signal with making
 use of irq_work to replace ipipe related interface
Date: Mon,  9 Nov 2020 02:50:26 -0500
Message-Id: <20201109075027.14760-14-hongzhan.chen@intel.com>
In-Reply-To: <20201109075027.14760-1-hongzhan.chen@intel.com>
References: <20201109075027.14760-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan.kiszka@siemens.com, xenomai@xenomai.org

re-implement xnthread_signal with making use of irq_work to
replace ipipe related interface.

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 kernel/cobalt/thread.c | 85 ++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 49 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index f3168d75f..cb8c01f5d 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2193,53 +2193,36 @@ void xnthread_relax(int notify, int reason)
 }
 EXPORT_SYMBOL_GPL(xnthread_relax);
 
-#if 0
-struct lostage_signal {
-	struct ipipe_work_header work; /* Must be first. */
-	struct task_struct *task;
-	int signo, sigval;
-};
-
-static inline void do_kthread_signal(struct task_struct *p,
-				     struct xnthread *thread,
-				     struct lostage_signal *rq)
-{
-	printk(XENO_WARNING
-	       "kernel shadow %s received unhandled signal %d (action=0x%x)\n",
-	       thread->name, rq->signo, rq->sigval);
-}
-
-static void lostage_task_signal(struct ipipe_work_header *work)
+static void do_inband_signal(struct xnthread *thread, int signo, int sigval)
 {
-	struct lostage_signal *rq;
-	struct xnthread *thread;
-	struct task_struct *p;
-	kernel_siginfo_t si;
-	int signo;
-
-	rq = container_of(work, struct lostage_signal, work);
-	p = rq->task;
-
-	thread = xnthread_from_task(p);
-	if (thread && !xnthread_test_state(thread, XNUSER)) {
-		do_kthread_signal(p, thread, rq);
-		return;
-	}
-
-	signo = rq->signo;
-
-	trace_cobalt_lostage_signal(p, signo);
+	struct task_struct *p = thread->altsched.task;
+	struct kernel_siginfo si;
 
 	if (signo == SIGSHADOW || signo == SIGDEBUG) {
 		memset(&si, '\0', sizeof(si));
 		si.si_signo = signo;
 		si.si_code = SI_QUEUE;
-		si.si_int = rq->sigval;
+		si.si_int = sigval;
 		send_sig_info(signo, &si, p);
 	} else
 		send_sig(signo, p, 1);
 }
-#endif
+
+struct sig_irqwork_data {
+	struct xnthread *thread;
+	int signo, sigval;
+	struct irq_work work;
+};
+
+static void sig_irqwork(struct irq_work *work)
+{
+	struct sig_irqwork_data *sigd;
+
+	sigd = container_of(work, struct sig_irqwork_data, work);
+	do_inband_signal(sigd->thread, sigd->signo, sigd->sigval);
+	xnfree(sigd);
+
+}
 
 static int force_wakeup(struct xnthread *thread) /* nklock locked, irqs off */
 {
@@ -2402,20 +2385,24 @@ EXPORT_SYMBOL_GPL(xnthread_demote);
 
 void xnthread_signal(struct xnthread *thread, int sig, int arg)
 {
-#warning TODO
-/*	struct lostage_signal sigwork = {
-		.work = {
-			.size = sizeof(sigwork),
-			.handler = lostage_task_signal,
-		},
-		.task = xnthread_host_task(thread),
-		.signo = sig,
-		.sigval = sig == SIGDEBUG ? arg | sigdebug_marker : arg,
-	};
+	struct sig_irqwork_data *sigd;
+
+	if (thread && !xnthread_test_state(thread, XNUSER))
+		return;
+
+	if (running_inband()) {
+		do_inband_signal(thread, sig, arg);
+		return;
+	}
 
-	trace_cobalt_lostage_request("signal", sigwork.task);
+	sigd = xnmalloc(sizeof(*sigd));
+	init_irq_work(&sigd->work, sig_irqwork);
+	sigd->thread = thread;
+	sigd->signo = sig;
+	sigd->sigval = arg;
 
-	ipipe_post_work_root(&sigwork, work);*/
+	/* Cannot fail, irq_work is local to this call. */
+	irq_work_queue(&sigd->work);
 }
 EXPORT_SYMBOL_GPL(xnthread_signal);
 
-- 
2.17.1


