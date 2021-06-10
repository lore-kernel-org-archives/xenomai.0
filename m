From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [[next]PATCH v2] cobalt/thread: move inband work descriptions off the
 stack
Date: Wed,  9 Jun 2021 22:14:38 -0400
Message-Id: <20210610021438.8004-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Unlike the I-pipe, Dovetail does not copy the work descriptor but
merely hands over the request to the common irq_work() mechanism. We
must guarantee that such descriptor lives in a portion of memory which
won't go stale until the handler has run, which by design can only
happen once the calling out-of-band context unwinds.

Therefore, we have to add one or more "signal slots" per possible
cause of in-band signal into this thread's control block.

For SIGDEBUG, except SIGDEBUG_WATCHDOG all other SIGDEBUG_* cause
including SIGDEBUG_MIGRATE_SIGNAL, SIGDEBUG_MIGRATE_SYSCALL,
SIGDEBUG_MIGRATE_FAULT, SIGDEBUG_MIGRATE_PRIOINV, SIGDEBUG_NOMLOCK,
SIGDEBUG_RESCNT_IMBALANCE, SIGDEBUG_LOCK_BREAK, SIGDEBUG_MUTEX_SLEEP
are synchronous and mutually exclusive due to the oob->in-band transition.
But SIGDEBUG_WATCHDOG is triggered asynchronously by the oob timer.

All SIGSHADOW_* events need their own slot: SIGSHADOW_ACTION_HARDEN and
SIGSHADOW_ACTION_HOME can be raised by remote threads asynchronously to
the target thread. SIGSHADOW_ACTION_BACKTRACE comes in addition to
SIGDEBUG_MIGRATE_*. For the latter reason, SIGSHADOW_ACTION_BACKTRACE
cannot pile up though.

Including SIGTERM, we have totally 6 slots.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
index c92037bfe..0c5eacda7 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -23,6 +23,7 @@
 #include <linux/sched.h>
 #include <linux/sched/rt.h>
 #include <pipeline/thread.h>
+#include <pipeline/inband_work.h>
 #include <cobalt/kernel/list.h>
 #include <cobalt/kernel/stat.h>
 #include <cobalt/kernel/timer.h>
@@ -42,6 +43,14 @@
 #define XNTHREAD_BLOCK_BITS   (XNSUSP|XNPEND|XNDELAY|XNDORMANT|XNRELAX|XNHELD|XNDBGSTOP)
 #define XNTHREAD_MODE_BITS    (XNRRB|XNWARN|XNTRAPLB)
 
+#define XNTHREAD_SIGNALS_NUM           6
+#define XNTHREAD_SIGDEBUG_NONWATCHDOG  0
+#define XNTHREAD_SIGDEBUG_WATCHDOD     1
+#define XNTHREAD_SIGSHADOW_HARDEN      2
+#define XNTHREAD_SIGSHADOW_BACKTRACE   3
+#define XNTHREAD_SIGSHADOW_HOME        4
+#define XNTHREAD_SIGTERM               5
+
 struct xnthread;
 struct xnsched;
 struct xnselector;
@@ -50,6 +59,13 @@ struct xnsched_tpslot;
 struct xnthread_personality;
 struct completion;
 
+struct lostage_signal {
+	struct pipeline_inband_work inband_work; /* Must be first. */
+	struct task_struct *task;
+	int signo, sigval;
+	struct lostage_signal *self; /* Revisit: I-pipe requirement */
+};
+
 struct xnthread_init_attr {
 	struct xnthread_personality *personality;
 	cpumask_t affinity;
@@ -199,6 +215,29 @@ struct xnthread {
 	const char *exe_path;	/* Executable path */
 	u32 proghash;		/* Hash value for exe_path */
 #endif
+	/*
+	 * Each slot handle different cause of signal
+	 * slot 0:
+	 *	SIGDEBUG_MIGRATE_SIGNAL
+	 *	SIGDEBUG_MIGRATE_SYSCALL
+	 *	SIGDEBUG_MIGRATE_FAULT
+	 *	SIGDEBUG_MIGRATE_PRIOINV
+	 *	SIGDEBUG_NOMLOCK
+	 *	SIGDEBUG_RESCNT_IMBALANCE
+	 *	SIGDEBUG_LOCK_BREAK
+	 *	SIGDEBUG_MUTEX_SLEEP
+	 * slot 1:
+	 *	SIGDEBUG_WATCHDOG
+	 * slot 2:
+	 *	SIGSHADOW_ACTION_HARDEN
+	 * slot 3:
+	 *	SIGSHADOW_ACTION_BACKTRACE
+	 * slot 4:
+	 *	SIGSHADOW_ACTION_HOME
+	 * slot 5:
+	 *	SIGTERM
+	 */
+	struct lostage_signal sigarray[XNTHREAD_SIGNALS_NUM];
 };
 
 static inline int xnthread_get_state(const struct xnthread *thread)
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index d3a827eaa..d180aa85c 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2083,12 +2083,6 @@ void xnthread_relax(int notify, int reason)
 }
 EXPORT_SYMBOL_GPL(xnthread_relax);
 
-struct lostage_signal {
-	struct pipeline_inband_work inband_work; /* Must be first. */
-	struct task_struct *task;
-	int signo, sigval;
-};
-
 static inline void do_kthread_signal(struct task_struct *p,
 				     struct xnthread *thread,
 				     struct lostage_signal *rq)
@@ -2112,7 +2106,7 @@ static void lostage_task_signal(struct pipeline_inband_work *inband_work)
 	thread = xnthread_from_task(p);
 	if (thread && !xnthread_test_state(thread, XNUSER)) {
 		do_kthread_signal(p, thread, rq);
-		return;
+		goto out;
 	}
 
 	signo = rq->signo;
@@ -2127,6 +2121,8 @@ static void lostage_task_signal(struct pipeline_inband_work *inband_work)
 		send_sig_info(signo, &si, p);
 	} else
 		send_sig(signo, p, 1);
+out:
+	memset(rq->self, 0, sizeof(*rq));
 }
 
 static int force_wakeup(struct xnthread *thread) /* nklock locked, irqs off */
@@ -2288,19 +2284,77 @@ void xnthread_demote(struct xnthread *thread)
 }
 EXPORT_SYMBOL_GPL(xnthread_demote);
 
+static int get_slot_index_from_sig(int sig, int arg)
+{
+	int action;
+
+	switch (sig) {
+	case SIGDEBUG:
+		switch (arg) {
+		case SIGDEBUG_WATCHDOG:
+			return XNTHREAD_SIGDEBUG_WATCHDOD;
+		case SIGDEBUG_MIGRATE_SIGNAL:
+		case SIGDEBUG_MIGRATE_SYSCALL:
+		case SIGDEBUG_MIGRATE_FAULT:
+		case SIGDEBUG_MIGRATE_PRIOINV:
+		case SIGDEBUG_NOMLOCK:
+		case SIGDEBUG_RESCNT_IMBALANCE:
+		case SIGDEBUG_LOCK_BREAK:
+		case SIGDEBUG_MUTEX_SLEEP:
+			return XNTHREAD_SIGDEBUG_NONWATCHDOG;
+		}
+		break;
+	case SIGSHADOW:
+		action = sigshadow_action(arg);
+		switch (action) {
+		case SIGSHADOW_ACTION_HARDEN:
+			return XNTHREAD_SIGSHADOW_HARDEN;
+		case SIGSHADOW_ACTION_BACKTRACE:
+			return XNTHREAD_SIGSHADOW_BACKTRACE;
+		case SIGSHADOW_ACTION_HOME:
+			return XNTHREAD_SIGSHADOW_HOME;
+		}
+		break;
+	case SIGTERM:
+		return XNTHREAD_SIGTERM;
+	}
+
+	return -1;
+}
+
 void xnthread_signal(struct xnthread *thread, int sig, int arg)
 {
-	struct lostage_signal sigwork = {
-		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(sigwork,
-					lostage_task_signal),
-		.task = xnthread_host_task(thread),
-		.signo = sig,
-		.sigval = sig == SIGDEBUG ? arg | sigdebug_marker : arg,
-	};
+	struct lostage_signal *sigwork;
+	int slot;
+
+	slot = get_slot_index_from_sig(sig, arg);
+
+	if (WARN_ON(slot < 0))
+		return;
+
+	sigwork = &thread->sigarray[slot];
+
+	/* To avoid invalidating the already submitted event
+	 * if previous submitted has not been handled as we expected
+	 * because setting sigwork->self zero is final step
+	 * in handling sig.
+	 */
+	if (WARN_ON((sigwork->self != NULL) &&
+				(sigwork->self == sigwork))) {
+		return;
+	}
+
+	sigwork->inband_work = (struct pipeline_inband_work)
+			PIPELINE_INBAND_WORK_INITIALIZER(*sigwork,
+					lostage_task_signal);
+	sigwork->task = xnthread_host_task(thread);
+	sigwork->signo = sig;
+	sigwork->sigval = sig == SIGDEBUG ? arg | sigdebug_marker : arg;
+	sigwork->self = sigwork; /* Revisit: I-pipe requirement */
 
-	trace_cobalt_lostage_request("signal", sigwork.task);
+	trace_cobalt_lostage_request("signal", sigwork->task);
 
-	pipeline_post_inband_work(&sigwork);
+	pipeline_post_inband_work(sigwork);
 }
 EXPORT_SYMBOL_GPL(xnthread_signal);
 
-- 
2.17.1


