From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 06/17] cobalt/thread: dovetail: keep hard irqs off on
 transition to in-band
Date: Fri, 11 Jun 2021 20:05:32 +0200
Message-Id: <98288382bd466130fedd65c653f70f90a7e5c4af.1623434743.git.jan.kiszka@siemens.com>
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

From: Philippe Gerum <rpm@xenomai.org>

Dovetail provides a fast service to escalate the caller to out-of-band
mode for executing a routine (run_oob_call()), which we use to enforce
primary mode in ___xnsched_run() to schedule out the relaxing thread.

Due to the way run_oob_call() works, enabling hardirqs during this
transition can trigger a subtle bug caused by the relaxing thread to
be switched out, as a result of taking an interrupt during the irqs on
section, before __xnsched_run() actually runs on behalf of
xnthread_relax() -> xnthread_suspend().

This may lead to a breakage of the inband interrupt state, revealed by
lockdep complaining about a HARDIRQ-IN-W -> HARDIRQ-ON-W situation,
when finalize_task_switch() runs for reconciling both the in-band and
Xenomai scheduler states.

Re-enabling hard irqs before switching out the relaxing thread was
throught as a mean to reduce the scope of the interrupt-free section
while relaxing a thread with the I-pipe, which unlike Dovetail
requires us to open code an escalation service based on triggering a
synthetic interrupt.

We differentiate the behavior between the I-pipe and Dovetail by
abstracting the related bits as pipeline_leave_oob_unlock(), keeping
the current implementation unchanged for the I-pipe.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../cobalt/kernel/dovetail/pipeline/sched.h   | 12 +++++++
 include/cobalt/kernel/ipipe/pipeline/sched.h  | 20 ++++++++++++
 kernel/cobalt/thread.c                        | 32 +++++++------------
 3 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/sched.h b/include/cobalt/kernel/dovetail/pipeline/sched.h
index b5d6c1773..45512b983 100644
--- a/include/cobalt/kernel/dovetail/pipeline/sched.h
+++ b/include/cobalt/kernel/dovetail/pipeline/sched.h
@@ -7,6 +7,8 @@
 #ifndef _COBALT_KERNEL_DOVETAIL_SCHED_H
 #define _COBALT_KERNEL_DOVETAIL_SCHED_H
 
+#include <cobalt/kernel/lock.h>
+
 struct xnthread;
 struct xnsched;
 struct task_struct;
@@ -35,6 +37,16 @@ int pipeline_leave_inband(void);
 
 int pipeline_leave_oob_prepare(void);
 
+static inline void pipeline_leave_oob_unlock(void)
+{
+	/*
+	 * We may not re-enable hard irqs due to the specifics of
+	 * stage escalation via run_oob_call(), to prevent breaking
+	 * the (virtual) interrupt state.
+	 */
+	xnlock_put(&nklock);
+}
+
 void pipeline_leave_oob_finish(void);
 
 static inline
diff --git a/include/cobalt/kernel/ipipe/pipeline/sched.h b/include/cobalt/kernel/ipipe/pipeline/sched.h
index 3fd5c4bea..9d7bf886b 100644
--- a/include/cobalt/kernel/ipipe/pipeline/sched.h
+++ b/include/cobalt/kernel/ipipe/pipeline/sched.h
@@ -7,6 +7,8 @@
 #ifndef _COBALT_KERNEL_IPIPE_SCHED_H
 #define _COBALT_KERNEL_IPIPE_SCHED_H
 
+#include <cobalt/kernel/lock.h>
+
 struct xnthread;
 struct xnsched;
 struct task_struct;
@@ -27,6 +29,24 @@ int pipeline_leave_inband(void);
 
 int pipeline_leave_oob_prepare(void);
 
+static inline void pipeline_leave_oob_unlock(void)
+{
+	/*
+	 * Introduce an opportunity for interrupt delivery right
+	 * before switching context, which shortens the
+	 * uninterruptible code path.
+	 *
+	 * We have to shut irqs off before __xnsched_run() is called
+	 * next though: if an interrupt could preempt us right after
+	 * xnarch_escalate() is passed but before the nklock is
+	 * grabbed, we would enter the critical section in
+	 * ___xnsched_run() from the root domain, which would defeat
+	 * the purpose of escalating the request.
+	 */
+	xnlock_clear_irqon(&nklock);
+	splmax();
+}
+
 void pipeline_leave_oob_finish(void);
 
 void pipeline_finalize_thread(struct xnthread *thread);
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index bc2eebc92..d096a20d3 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -955,27 +955,17 @@ void xnthread_suspend(struct xnthread *thread, int mask,
 	if (wchan)
 		thread->wchan = wchan;
 
-	/*
-	 * If the current thread is being relaxed, we must have been
-	 * called from xnthread_relax(), in which case we introduce an
-	 * opportunity for interrupt delivery right before switching
-	 * context, which shortens the uninterruptible code path.
-	 *
-	 * We have to shut irqs off before calling __xnsched_run()
-	 * though: if an interrupt could preempt us right after
-	 * xnarch_escalate() is passed but before the nklock is
-	 * grabbed, we would enter the critical section in
-	 * ___xnsched_run() from the root domain, which would defeat
-	 * the purpose of escalating the request.
-	 *
-	 * NOTE: using __xnsched_run() for rescheduling allows us to
-	 * break the scheduler lock temporarily.
-	 */
 	if (likely(thread == sched->curr)) {
 		xnsched_set_resched(sched);
+		/*
+		 * Transition to secondary mode (XNRELAX) is a
+		 * separate path which is only available to
+		 * xnthread_relax(). Using __xnsched_run() there for
+		 * rescheduling allows us to break the scheduler lock
+		 * temporarily.
+		 */
 		if (unlikely(mask & XNRELAX)) {
-			xnlock_clear_irqon(&nklock);
-			splmax();
+			pipeline_leave_oob_unlock();
 			__xnsched_run(sched);
 			return;
 		}
@@ -1683,7 +1673,7 @@ int xnthread_join(struct xnthread *thread, bool uninterruptible)
 
 	xnthread_set_state(thread, XNJOINED);
 	tpid = xnthread_host_pid(thread);
-	
+
 	if (curr && !xnthread_test_state(curr, XNRELAX)) {
 		xnlock_put_irqrestore(&nklock, s);
 		xnthread_relax(0, 0);
@@ -1889,7 +1879,7 @@ int __xnthread_set_schedparam(struct xnthread *thread,
 	/* Ask the target thread to call back if relaxed. */
 	if (xnthread_test_state(thread, XNRELAX))
 		__xnthread_signal(thread, SIGSHADOW, SIGSHADOW_ACTION_HOME);
-	
+
 	return ret;
 }
 
@@ -2081,7 +2071,6 @@ void xnthread_relax(int notify, int reason)
 	 * We disable interrupts during the migration sequence, but
 	 * xnthread_suspend() has an interrupts-on section built in.
 	 */
-	splmax();
 	trace_cobalt_lostage_request("wakeup", p);
 	pipeline_post_inband_work(&wakework);
 	/*
@@ -2089,6 +2078,7 @@ void xnthread_relax(int notify, int reason)
 	 * manipulation with handle_sigwake_event. This lock will be
 	 * dropped by xnthread_suspend().
 	 */
+	splmax();
 	xnlock_get(&nklock);
 	xnthread_run_handler_stack(thread, relax_thread);
 	suspension = pipeline_leave_oob_prepare();
-- 
2.26.2


