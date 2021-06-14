From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 2/2] cobalt: Move common debug handling code out of pipeline
 diversion again
Date: Mon, 14 Jun 2021 14:07:36 +0200
Message-Id: <8a9c33da096c7e42d02340a0bca293b8c8028a32.1623672456.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1623672456.git.jan.kiszka@siemens.com>
References: <cover.1623672456.git.jan.kiszka@siemens.com>
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
Cc: Philippe Gerum <philippe.gerum@ixblue.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

Those functions are identical now, with the variations due to some older
I-pipe releases removed.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/dovetail/kevents.c | 75 +++----------------------------
 kernel/cobalt/ipipe/kevents.c    | 77 +++-----------------------------
 kernel/cobalt/posix/process.c    | 63 ++++++++++++++++++++++++++
 kernel/cobalt/posix/process.h    |  6 +++
 4 files changed, 82 insertions(+), 139 deletions(-)

diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index c07c08a6e..f27d5a966 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -24,69 +24,6 @@
 
 static void detach_current(void);
 
-static inline struct cobalt_process *
-process_from_thread(struct xnthread *thread)
-{
-	return container_of(thread, struct cobalt_thread, threadbase)->process;
-}
-
-static inline void stop_debugged_process(struct xnthread *thread)
-{
-	struct cobalt_process *process = process_from_thread(thread);
-	struct cobalt_thread *cth;
-
-	if (process->debugged_threads > 0)
-		return;
-
-	list_for_each_entry(cth, &process->thread_list, next) {
-		if (&cth->threadbase == thread)
-			continue;
-
-		xnthread_suspend(&cth->threadbase, XNDBGSTOP, XN_INFINITE,
-				 XN_RELATIVE, NULL);
-	}
-}
-
-static inline void resume_debugged_process(struct cobalt_process *process)
-{
-	struct cobalt_thread *cth;
-
-	xnsched_lock();
-
-	list_for_each_entry(cth, &process->thread_list, next)
-		if (xnthread_test_state(&cth->threadbase, XNDBGSTOP))
-			xnthread_resume(&cth->threadbase, XNDBGSTOP);
-
-	xnsched_unlock();
-}
-
-/* called with nklock held */
-static void register_debugged_thread(struct xnthread *thread)
-{
-	struct cobalt_process *process = process_from_thread(thread);
-
-	xnthread_set_state(thread, XNSSTEP);
-
-	stop_debugged_process(thread);
-	process->debugged_threads++;
-
-	if (xnthread_test_state(thread, XNRELAX))
-		xnthread_suspend(thread, XNDBGSTOP, XN_INFINITE, XN_RELATIVE,
-				 NULL);
-}
-
-/* called with nklock held */
-static void unregister_debugged_thread(struct xnthread *thread)
-{
-	struct cobalt_process *process = process_from_thread(thread);
-
-	process->debugged_threads--;
-	xnthread_clear_state(thread, XNSSTEP);
-
-	if (process->debugged_threads == 0)
-		resume_debugged_process(process);
-}
-
 void arch_inband_task_init(struct task_struct *tsk)
 {
 	struct cobalt_threadinfo *p = dovetail_task_state(tsk);
@@ -117,7 +54,7 @@ void handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
 		xnlock_get_irqsave(&nklock, s);
 		xnthread_set_info(thread, XNCONTHI);
 		dovetail_request_ucall(current);
-		stop_debugged_process(thread);
+		cobalt_stop_debugged_process(thread);
 		xnlock_put_irqrestore(&nklock, s);
 		xnsched_run();
 	}
@@ -288,7 +225,7 @@ static void __handle_taskexit_event(struct task_struct *p)
 	xnlock_get_irqsave(&nklock, s);
 
 	if (xnthread_test_state(thread, XNSSTEP))
-		unregister_debugged_thread(thread);
+		cobalt_unregister_debugged_thread(thread);
 
 	xnsched_run();
 
@@ -386,7 +323,7 @@ static int handle_sigwake_event(struct task_struct *p)
 		if (sigismember(&pending, SIGTRAP) ||
 		    sigismember(&pending, SIGSTOP)
 		    || sigismember(&pending, SIGINT))
-			register_debugged_thread(thread);
+			cobalt_register_debugged_thread(thread);
 	}
 
 	if (xnthread_test_state(thread, XNRELAX))
@@ -472,7 +409,7 @@ int handle_ptrace_resume(struct task_struct *tracee)
 		xnlock_get_irqsave(&nklock, s);
 
 		xnthread_resume(thread, XNDBGSTOP);
-		unregister_debugged_thread(thread);
+		cobalt_unregister_debugged_thread(thread);
 
 		xnlock_put_irqrestore(&nklock, s);
 	}
@@ -489,7 +426,7 @@ static void handle_ptrace_cont(void)
 
 	if (xnthread_test_state(curr, XNSSTEP)) {
 		if (!xnthread_test_info(curr, XNCONTHI))
-			unregister_debugged_thread(curr);
+			cobalt_unregister_debugged_thread(curr);
 
 		xnthread_set_localinfo(curr, XNHICCUP);
 
@@ -608,7 +545,7 @@ void resume_oob_task(struct task_struct *p) /* inband, oob stage stalled */
 
 	/* Unregister as debugged thread in case we postponed this. */
 	if (unlikely(xnthread_test_state(thread, XNSSTEP)))
-		unregister_debugged_thread(thread);
+		cobalt_unregister_debugged_thread(thread);
 
 	xnlock_put(&nklock);
 
diff --git a/kernel/cobalt/ipipe/kevents.c b/kernel/cobalt/ipipe/kevents.c
index 32d305cb2..b0869cbf8 100644
--- a/kernel/cobalt/ipipe/kevents.c
+++ b/kernel/cobalt/ipipe/kevents.c
@@ -26,69 +26,6 @@
 
 static void detach_current(void);
 
-static inline struct cobalt_process *
-process_from_thread(struct xnthread *thread)
-{
-	return container_of(thread, struct cobalt_thread, threadbase)->process;
-}
-
-static void stop_debugged_process(struct xnthread *thread)
-{
-	struct cobalt_process *process = process_from_thread(thread);
-	struct cobalt_thread *cth;
-
-	if (process->debugged_threads > 0)
-		return;
-
-	list_for_each_entry(cth, &process->thread_list, next) {
-		if (&cth->threadbase == thread)
-			continue;
-
-		xnthread_suspend(&cth->threadbase, XNDBGSTOP, XN_INFINITE,
-				 XN_RELATIVE, NULL);
-	}
-}
-
-static void resume_debugged_process(struct cobalt_process *process)
-{
-	struct cobalt_thread *cth;
-
-	xnsched_lock();
-
-	list_for_each_entry(cth, &process->thread_list, next)
-		if (xnthread_test_state(&cth->threadbase, XNDBGSTOP))
-			xnthread_resume(&cth->threadbase, XNDBGSTOP);
-
-	xnsched_unlock();
-}
-
-/* called with nklock held */
-static void register_debugged_thread(struct xnthread *thread)
-{
-	struct cobalt_process *process = process_from_thread(thread);
-
-	xnthread_set_state(thread, XNSSTEP);
-
-	stop_debugged_process(thread);
-	process->debugged_threads++;
-
-	if (xnthread_test_state(thread, XNRELAX))
-		xnthread_suspend(thread, XNDBGSTOP, XN_INFINITE, XN_RELATIVE,
-				 NULL);
-}
-
-/* called with nklock held */
-static void unregister_debugged_thread(struct xnthread *thread)
-{
-	struct cobalt_process *process = process_from_thread(thread);
-
-	process->debugged_threads--;
-	xnthread_clear_state(thread, XNSSTEP);
-
-	if (process->debugged_threads == 0)
-		resume_debugged_process(process);
-}
-
 static inline int handle_exception(struct ipipe_trap_data *d)
 {
 	struct xnthread *thread;
@@ -110,7 +47,7 @@ static inline int handle_exception(struct ipipe_trap_data *d)
 		xnlock_get_irqsave(&nklock, s);
 		xnthread_set_info(thread, XNCONTHI);
 		ipipe_enable_user_intret_notifier();
-		stop_debugged_process(thread);
+		cobalt_stop_debugged_process(thread);
 		xnlock_put_irqrestore(&nklock, s);
 		xnsched_run();
 	}
@@ -354,7 +291,7 @@ void ipipe_migration_hook(struct task_struct *p) /* hw IRQs off */
 
 	/* Unregister as debugged thread in case we postponed this. */
 	if (unlikely(xnthread_test_state(thread, XNSSTEP)))
-		unregister_debugged_thread(thread);
+		cobalt_unregister_debugged_thread(thread);
 
 	xnlock_put(&nklock);
 
@@ -433,7 +370,7 @@ static void __handle_taskexit_event(struct task_struct *p)
 	xnlock_get_irqsave(&nklock, s);
 
 	if (xnthread_test_state(thread, XNSSTEP))
-		unregister_debugged_thread(thread);
+		cobalt_unregister_debugged_thread(thread);
 
 	xnsched_run();
 
@@ -505,11 +442,11 @@ static int handle_schedule_event(struct task_struct *next_task)
 
 		/*
 		 * Do not unregister before the thread migrated.
-		 * unregister_debugged_thread will then be called by our
+		 * cobalt_unregister_debugged_thread will then be called by our
 		 * ipipe_migration_hook.
 		 */
 		if (!xnthread_test_info(next, XNCONTHI))
-			unregister_debugged_thread(next);
+			cobalt_unregister_debugged_thread(next);
 
 		xnthread_set_localinfo(next, XNHICCUP);
 	}
@@ -569,7 +506,7 @@ static int handle_sigwake_event(struct task_struct *p)
 		if (sigismember(&pending, SIGTRAP) ||
 		    sigismember(&pending, SIGSTOP)
 		    || sigismember(&pending, SIGINT))
-			register_debugged_thread(thread);
+			cobalt_register_debugged_thread(thread);
 	}
 
 	if (xnthread_test_state(thread, XNRELAX))
@@ -711,7 +648,7 @@ int handle_ptrace_resume(struct ipipe_ptrace_resume_data *resume)
 		xnlock_get_irqsave(&nklock, s);
 
 		xnthread_resume(thread, XNDBGSTOP);
-		unregister_debugged_thread(thread);
+		cobalt_unregister_debugged_thread(thread);
 
 		xnlock_put_irqrestore(&nklock, s);
 	}
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 945a52a35..2ed98e05b 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -672,6 +672,69 @@ void cobalt_signal_yield(void)
 	xnlock_put_irqrestore(&nklock, s);
 }
 
+static inline struct cobalt_process *
+process_from_thread(struct xnthread *thread)
+{
+	return container_of(thread, struct cobalt_thread, threadbase)->process;
+}
+
+void cobalt_stop_debugged_process(struct xnthread *thread)
+{
+	struct cobalt_process *process = process_from_thread(thread);
+	struct cobalt_thread *cth;
+
+	if (process->debugged_threads > 0)
+		return;
+
+	list_for_each_entry(cth, &process->thread_list, next) {
+		if (&cth->threadbase == thread)
+			continue;
+
+		xnthread_suspend(&cth->threadbase, XNDBGSTOP, XN_INFINITE,
+				 XN_RELATIVE, NULL);
+	}
+}
+
+static void cobalt_resume_debugged_process(struct cobalt_process *process)
+{
+	struct cobalt_thread *cth;
+
+	xnsched_lock();
+
+	list_for_each_entry(cth, &process->thread_list, next)
+		if (xnthread_test_state(&cth->threadbase, XNDBGSTOP))
+			xnthread_resume(&cth->threadbase, XNDBGSTOP);
+
+	xnsched_unlock();
+}
+
+/* called with nklock held */
+void cobalt_register_debugged_thread(struct xnthread *thread)
+{
+	struct cobalt_process *process = process_from_thread(thread);
+
+	xnthread_set_state(thread, XNSSTEP);
+
+	cobalt_stop_debugged_process(thread);
+	process->debugged_threads++;
+
+	if (xnthread_test_state(thread, XNRELAX))
+		xnthread_suspend(thread, XNDBGSTOP, XN_INFINITE, XN_RELATIVE,
+				 NULL);
+}
+
+/* called with nklock held */
+void cobalt_unregister_debugged_thread(struct xnthread *thread)
+{
+	struct cobalt_process *process = process_from_thread(thread);
+
+	process->debugged_threads--;
+	xnthread_clear_state(thread, XNSSTEP);
+
+	if (process->debugged_threads == 0)
+		cobalt_resume_debugged_process(process);
+}
+
 static int attach_process(struct cobalt_process *process)
 {
 	struct cobalt_ppd *p = &process->sys_ppd;
diff --git a/kernel/cobalt/posix/process.h b/kernel/cobalt/posix/process.h
index 22142ee03..767d75e8b 100644
--- a/kernel/cobalt/posix/process.h
+++ b/kernel/cobalt/posix/process.h
@@ -151,6 +151,12 @@ void cobalt_remove_process(struct cobalt_process *process);
 
 void cobalt_signal_yield(void);
 
+void cobalt_stop_debugged_process(struct xnthread *thread);
+
+void cobalt_register_debugged_thread(struct xnthread *thread);
+
+void cobalt_unregister_debugged_thread(struct xnthread *thread);
+
 extern struct xnthread_personality *cobalt_personalities[];
 
 extern struct xnthread_personality cobalt_personality;
-- 
2.26.2


