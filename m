From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 02/17] cobalt/thread: Move xnthread_signal work off the stack
Date: Fri, 11 Jun 2021 20:05:28 +0200
Message-Id: <850b378954c602fa91b0cf6a6b5e7a37524ef9b2.1623434743.git.jan.kiszka@siemens.com>
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

Unlike the I-pipe, Dovetail does not copy the work descriptor but
merely hands over the request to the common irq_work() mechanism. We
must guarantee that such descriptor lives in a portion of memory which
won't go stale until the handler has run, which by design can only
happen once the calling out-of-band context unwinds.

Therefore, we have to create signal slots per possible cause in the
thread's control block in order to overcome sigwork in xnthread_signal.

For SIGDEBUG, we are only interested in the very first event coming in,
so one slot is enough. All SIGSHADOW_* events need their own slot:
SIGSHADOW_ACTION_HARDEN and SIGSHADOW_ACTION_HOME can be raised by
remote threads asynchronously to the target thread.
SIGSHADOW_ACTION_BACKTRACE comes in addition to SIGDEBUG_MIGRATE_*. For
the latter reason, SIGSHADOW_ACTION_BACKTRACE cannot pile up though.

Including SIGTERM, we have totally 5 slots.

To ensure that multiple asynchronous signals on the same slot do not
overwrite each other (e.g. SIGSHADOW_ACTION_HOME or SIGDEBUG reasons),
synchronize the slot usage under nklock. Create a __xnthread_signal
variant that can be called from already locked contexts (the majority of
xnthread_signal users).

Based on original patch by Hongzhan Chen.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/thread.h   |  21 ++++++-
 kernel/cobalt/dovetail/kevents.c |   2 +-
 kernel/cobalt/ipipe/kevents.c    |   2 +-
 kernel/cobalt/synch.c            |   4 +-
 kernel/cobalt/thread.c           | 103 +++++++++++++++++++++++--------
 5 files changed, 101 insertions(+), 31 deletions(-)

diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
index c92037bfe..2d6ce9053 100644
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
@@ -42,6 +43,13 @@
 #define XNTHREAD_BLOCK_BITS   (XNSUSP|XNPEND|XNDELAY|XNDORMANT|XNRELAX|XNHELD|XNDBGSTOP)
 #define XNTHREAD_MODE_BITS    (XNRRB|XNWARN|XNTRAPLB)
 
+#define XNTHREAD_SIGDEBUG		0
+#define XNTHREAD_SIGSHADOW_HARDEN	1
+#define XNTHREAD_SIGSHADOW_BACKTRACE	2
+#define XNTHREAD_SIGSHADOW_HOME		3
+#define XNTHREAD_SIGTERM		4
+#define XNTHREAD_MAX_SIGNALS		5
+
 struct xnthread;
 struct xnsched;
 struct xnselector;
@@ -50,6 +58,13 @@ struct xnsched_tpslot;
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
@@ -199,6 +214,7 @@ struct xnthread {
 	const char *exe_path;	/* Executable path */
 	u32 proghash;		/* Hash value for exe_path */
 #endif
+	struct lostage_signal sigarray[XNTHREAD_MAX_SIGNALS];
 };
 
 static inline int xnthread_get_state(const struct xnthread *thread)
@@ -492,8 +508,9 @@ void __xnthread_demote(struct xnthread *thread);
 
 void xnthread_demote(struct xnthread *thread);
 
-void xnthread_signal(struct xnthread *thread,
-		     int sig, int arg);
+void __xnthread_signal(struct xnthread *thread, int sig, int arg);
+
+void xnthread_signal(struct xnthread *thread, int sig, int arg);
 
 void xnthread_pin_initial(struct xnthread *thread);
 
diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index 3987d119a..c07c08a6e 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -188,7 +188,7 @@ static int handle_setaffinity_event(struct dovetail_migration_data *d)
 	xnlock_get_irqsave(&nklock, s);
 
 	if (xnthread_test_state(thread, XNTHREAD_BLOCK_BITS & ~XNRELAX))
-		xnthread_signal(thread, SIGSHADOW, SIGSHADOW_ACTION_HARDEN);
+		__xnthread_signal(thread, SIGSHADOW, SIGSHADOW_ACTION_HARDEN);
 
 	xnlock_put_irqrestore(&nklock, s);
 
diff --git a/kernel/cobalt/ipipe/kevents.c b/kernel/cobalt/ipipe/kevents.c
index 617e5cb6a..19970c8b8 100644
--- a/kernel/cobalt/ipipe/kevents.c
+++ b/kernel/cobalt/ipipe/kevents.c
@@ -261,7 +261,7 @@ static int handle_setaffinity_event(struct ipipe_cpu_migration_data *d)
 	xnlock_get_irqsave(&nklock, s);
 
 	if (xnthread_test_state(thread, XNTHREAD_BLOCK_BITS & ~XNRELAX))
-		xnthread_signal(thread, SIGSHADOW, SIGSHADOW_ACTION_HARDEN);
+		__xnthread_signal(thread, SIGSHADOW, SIGSHADOW_ACTION_HARDEN);
 
 	xnlock_put_irqrestore(&nklock, s);
 
diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
index c65c07aac..911bc83f6 100644
--- a/kernel/cobalt/synch.c
+++ b/kernel/cobalt/synch.c
@@ -1147,7 +1147,7 @@ void xnsynch_detect_relaxed_owner(struct xnsynch *synch,
 	    !xnthread_test_info(sleeper, XNPIALERT) &&
 	    xnthread_test_state(synch->owner, XNRELAX)) {
 		xnthread_set_info(sleeper, XNPIALERT);
-		xnthread_signal(sleeper, SIGDEBUG,
+		__xnthread_signal(sleeper, SIGDEBUG,
 				  SIGDEBUG_MIGRATE_PRIOINV);
 	} else
 		xnthread_clear_info(sleeper,  XNPIALERT);
@@ -1171,7 +1171,7 @@ void xnsynch_detect_boosted_relax(struct xnthread *owner)
 		xnsynch_for_each_sleeper(sleeper, synch) {
 			if (xnthread_test_state(sleeper, XNWARN)) {
 				xnthread_set_info(sleeper, XNPIALERT);
-				xnthread_signal(sleeper, SIGDEBUG,
+				__xnthread_signal(sleeper, SIGDEBUG,
 						  SIGDEBUG_MIGRATE_PRIOINV);
 			}
 		}
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 6a3e3fa18..1f8e1119a 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -948,7 +948,7 @@ void xnthread_suspend(struct xnthread *thread, int mask,
 	 */
 	if (((oldstate & (XNTHREAD_BLOCK_BITS|XNUSER)) == (XNRELAX|XNUSER)) &&
 	    (mask & (XNDELAY | XNSUSP | XNHELD)) != 0)
-		xnthread_signal(thread, SIGSHADOW, SIGSHADOW_ACTION_HARDEN);
+		__xnthread_signal(thread, SIGSHADOW, SIGSHADOW_ACTION_HARDEN);
 out:
 	xnlock_put_irqrestore(&nklock, s);
 	return;
@@ -959,7 +959,7 @@ lock_break:
 	    !xnthread_test_localinfo(thread, XNLBALERT)) {
 		xnthread_set_info(thread, XNKICKED);
 		xnthread_set_localinfo(thread, XNLBALERT);
-		xnthread_signal(thread, SIGDEBUG, SIGDEBUG_LOCK_BREAK);
+		__xnthread_signal(thread, SIGDEBUG, SIGDEBUG_LOCK_BREAK);
 	}
 abort:
 	if (wchan) {
@@ -1492,7 +1492,7 @@ check_self_cancel:
 	 */
 	if (xnthread_test_state(thread, XNUSER)) {
 		__xnthread_demote(thread);
-		xnthread_signal(thread, SIGTERM, 0);
+		__xnthread_signal(thread, SIGTERM, 0);
 	} else
 		__xnthread_kick(thread);
 out:
@@ -1803,7 +1803,7 @@ int __xnthread_set_schedparam(struct xnthread *thread,
 	xnthread_set_info(thread, XNSCHEDP);
 	/* Ask the target thread to call back if relaxed. */
 	if (xnthread_test_state(thread, XNRELAX))
-		xnthread_signal(thread, SIGSHADOW, SIGSHADOW_ACTION_HOME);
+		__xnthread_signal(thread, SIGSHADOW, SIGSHADOW_ACTION_HOME);
 	
 	return ret;
 }
@@ -2083,23 +2083,29 @@ void xnthread_relax(int notify, int reason)
 }
 EXPORT_SYMBOL_GPL(xnthread_relax);
 
-struct lostage_signal {
-	struct pipeline_inband_work inband_work; /* Must be first. */
-	struct task_struct *task;
-	int signo, sigval;
-};
-
 static void lostage_task_signal(struct pipeline_inband_work *inband_work)
 {
 	struct lostage_signal *rq;
 	struct task_struct *p;
 	kernel_siginfo_t si;
-	int signo;
+	int signo, sigval;
+	spl_t s;
 
 	rq = container_of(inband_work, struct lostage_signal, inband_work);
-	p = rq->task;
+	/*
+	 * Revisit: I-pipe requirement. It passes a copy of the original work
+	 * struct, so retrieve the original one first in order to update is.
+	 */
+	rq = rq->self;
 
+	xnlock_get_irqsave(&nklock, s);
+
+	p = rq->task;
 	signo = rq->signo;
+	sigval = rq->sigval;
+	rq->task = NULL;
+
+	xnlock_put_irqrestore(&nklock, s);
 
 	trace_cobalt_lostage_signal(p, signo);
 
@@ -2107,10 +2113,11 @@ static void lostage_task_signal(struct pipeline_inband_work *inband_work)
 		memset(&si, '\0', sizeof(si));
 		si.si_signo = signo;
 		si.si_code = SI_QUEUE;
-		si.si_int = rq->sigval;
+		si.si_int = sigval;
 		send_sig_info(signo, &si, p);
-	} else
+	} else {
 		send_sig(signo, p, 1);
+	}
 }
 
 static int force_wakeup(struct xnthread *thread) /* nklock locked, irqs off */
@@ -2272,22 +2279,68 @@ void xnthread_demote(struct xnthread *thread)
 }
 EXPORT_SYMBOL_GPL(xnthread_demote);
 
-void xnthread_signal(struct xnthread *thread, int sig, int arg)
+static int get_slot_index_from_sig(int sig, int arg)
 {
-	struct lostage_signal sigwork = {
-		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(sigwork,
-					lostage_task_signal),
-		.task = xnthread_host_task(thread),
-		.signo = sig,
-		.sigval = sig == SIGDEBUG ? arg | sigdebug_marker : arg,
-	};
+	int action;
+
+	switch (sig) {
+	case SIGDEBUG:
+		return XNTHREAD_SIGDEBUG;
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
+/* nklock locked, irqs off */
+void __xnthread_signal(struct xnthread *thread, int sig, int arg)
+{
+	struct lostage_signal *sigwork;
+	int slot;
 
 	if (XENO_WARN_ON(COBALT, !xnthread_test_state(thread, XNUSER)))
 		return;
 
-	trace_cobalt_lostage_request("signal", sigwork.task);
+	slot = get_slot_index_from_sig(sig, arg);
+	if (WARN_ON_ONCE(slot < 0))
+		return;
+
+	sigwork = &thread->sigarray[slot];
+	if (sigwork->task)
+		return;
+
+	sigwork->inband_work = (struct pipeline_inband_work)
+			PIPELINE_INBAND_WORK_INITIALIZER(*sigwork,
+							 lostage_task_signal);
+	sigwork->task = xnthread_host_task(thread);
+	sigwork->signo = sig;
+	sigwork->sigval = sig == SIGDEBUG ? arg | sigdebug_marker : arg;
+	sigwork->self = sigwork; /* Revisit: I-pipe requirement */
+
+	trace_cobalt_lostage_request("signal", sigwork->task);
+
+	pipeline_post_inband_work(sigwork);
+}
+
+void xnthread_signal(struct xnthread *thread, int sig, int arg)
+{
+	spl_t s;
 
-	pipeline_post_inband_work(&sigwork);
+	xnlock_get_irqsave(&nklock, s);
+	__xnthread_signal(thread, sig, arg);
+	xnlock_put_irqrestore(&nklock, s);
 }
 EXPORT_SYMBOL_GPL(xnthread_signal);
 
@@ -2469,7 +2522,7 @@ void xnthread_call_mayday(struct xnthread *thread, int reason)
 	/* Mayday traps are available to userland threads only. */
 	XENO_BUG_ON(COBALT, !xnthread_test_state(thread, XNUSER));
 	xnthread_set_info(thread, XNKICKED);
-	xnthread_signal(thread, SIGDEBUG, reason);
+	__xnthread_signal(thread, SIGDEBUG, reason);
 	pipeline_raise_mayday(p);
 }
 EXPORT_SYMBOL_GPL(xnthread_call_mayday);
-- 
2.26.2


