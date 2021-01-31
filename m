From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 02/13] cobalt/thread: pipeline: abstract synchronous
 single-stepping code
Date: Sun, 31 Jan 2021 15:45:29 +0100
Message-Id: <20210131144540.243363-2-rpm@xenomai.org>
In-Reply-To: <20210131144540.243363-1-rpm@xenomai.org>
References: <20210131144540.243363-1-rpm@xenomai.org>
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

Although the synchronous single-stepping code has moved to the I-pipe
section, we should be able to reuse the current logic nearly as is on
top of Dovetail, with only minor adjustments.

However, compared to the previous implementation, the single-stepping
status (XNCONTHI) and the user return notifier are armed _after_ the
personality handlers have run, in the relaxing path for the current
thread (see xnthread_relax()). This change should not affect the
overall logic, assuming no custom relax handler was depending on the
original sequence of actions (which they should definitely not
anyway).

We keep this commit which does introduce a small functional change
separated from the other scheduler-related modifications, as a
convenience for chasing regressions if need be.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/ipipe/pipeline/sched.h |  2 +-
 kernel/cobalt/ipipe/sched.c                  | 24 +++++++++++++++++++-
 kernel/cobalt/thread.c                       | 18 ++-------------
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/include/cobalt/kernel/ipipe/pipeline/sched.h b/include/cobalt/kernel/ipipe/pipeline/sched.h
index 692ee6228..3fd5c4bea 100644
--- a/include/cobalt/kernel/ipipe/pipeline/sched.h
+++ b/include/cobalt/kernel/ipipe/pipeline/sched.h
@@ -25,7 +25,7 @@ bool pipeline_switch_to(struct xnthread *prev,
 
 int pipeline_leave_inband(void);
 
-void pipeline_leave_oob_prepare(void);
+int pipeline_leave_oob_prepare(void);
 
 void pipeline_leave_oob_finish(void);
 
diff --git a/kernel/cobalt/ipipe/sched.c b/kernel/cobalt/ipipe/sched.c
index 4850b229d..b6ad8dca5 100644
--- a/kernel/cobalt/ipipe/sched.c
+++ b/kernel/cobalt/ipipe/sched.c
@@ -150,11 +150,33 @@ int pipeline_leave_inband(void)
 	return 0;
 }
 
-void pipeline_leave_oob_prepare(void)
+int pipeline_leave_oob_prepare(void)
 {
+	struct xnthread *curr = xnthread_current();
 	struct task_struct *p = current;
+	int suspmask = XNRELAX;
 
 	set_current_state(p->state & ~TASK_NOWAKEUP);
+
+#ifdef IPIPE_KEVT_USERINTRET
+	/*
+	 * If current is being debugged, record that it should migrate
+	 * back in case it resumes in userspace. If it resumes in
+	 * kernel space, i.e.  over a restarting syscall, the
+	 * associated hardening will both clear XNCONTHI and disable
+	 * the user return notifier again.
+	 */
+	if (xnthread_test_state(curr, XNSSTEP)) {
+		xnthread_set_info(curr, XNCONTHI);
+		ipipe_enable_user_intret_notifier();
+		suspmask |= XNDBGSTOP;
+	}
+#endif
+	/*
+	 * Return the suspension bits the caller should pass to
+	 * xnthread_suspend().
+	 */
+	return suspmask;
 }
 
 void pipeline_leave_oob_finish(void)
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index a2eae7ffc..d3a827eaa 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -1981,9 +1981,8 @@ void __xnthread_propagate_schedparam(struct xnthread *curr)
 void xnthread_relax(int notify, int reason)
 {
 	struct xnthread *thread = xnthread_current();
+	int cpu __maybe_unused, suspension;
 	struct task_struct *p = current;
-	int suspension = XNRELAX;
-	int cpu __maybe_unused;
 	kernel_siginfo_t si;
 
 	primary_mode_only();
@@ -2013,21 +2012,8 @@ void xnthread_relax(int notify, int reason)
 	 * dropped by xnthread_suspend().
 	 */
 	xnlock_get(&nklock);
-#ifdef IPIPE_KEVT_USERINTRET
-	/*
-	 * If the thread is being debugged, record that it should migrate back
-	 * in case it resumes in userspace. If it resumes in kernel space, i.e.
-	 * over a restarting syscall, the associated hardening will both clear
-	 * XNCONTHI and disable the user return notifier again.
-	 */
-	if (xnthread_test_state(thread, XNSSTEP)) {
-		xnthread_set_info(thread, XNCONTHI);
-		ipipe_enable_user_intret_notifier();
-		suspension |= XNDBGSTOP;
-	}
-#endif
 	xnthread_run_handler_stack(thread, relax_thread);
-	pipeline_leave_oob_prepare();
+	suspension = pipeline_leave_oob_prepare();
 	xnthread_suspend(thread, suspension, XN_INFINITE, XN_RELATIVE, NULL);
 	splnone();
 
-- 
2.26.2


