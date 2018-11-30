From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC][PATCH 5/7] cobalt/kernel: Implement synchronous stop and resume
 for process debugging
Date: Fri, 30 Nov 2018 21:03:19 +0100
Message-Id: <43beca14b954c2170f79c456dc3a2ea99b755d08.1543608201.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1543608201.git.jan.kiszka@siemens.com>
References: <cover.1543608201.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1543608201.git.jan.kiszka@siemens.com>
References: <cover.1543608201.git.jan.kiszka@siemens.com>
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

When a thread in primary mode currently hits a breakpoint, it will
immediately be relaxed, leaving space for other runnable RT threads of
the process to take over. This can delay gdb to finally take control and
stop the whole process.

To prevent this unexpected and often undesired behavior, this introduces
a mechanism to stop all threads of a process in primary mode when one of
them runs into a breakpoint or a single-step event. The new XNDBGSTOP
thread state is used for this purpose.

On resumption, no thread can continue in primary mode until all that
should do so have reached this state. Then the last one will wake up all
threads waiting on XNDBGSTOP.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/process.c | 131 +++++++++++++++++++++++++++++++++++++++---
 kernel/cobalt/posix/process.h |   1 +
 kernel/cobalt/thread.c        |   4 +-
 3 files changed, 126 insertions(+), 10 deletions(-)

diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 1b89ab7580..e748c4fbdf 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -94,6 +94,12 @@ struct cobalt_resources cobalt_global_resources = {
 	.schedq = LIST_HEAD_INIT(cobalt_global_resources.schedq),
 };
 
+static inline struct cobalt_process *
+process_from_thread(struct xnthread *thread)
+{
+	return container_of(thread, struct cobalt_thread, threadbase)->process;
+}
+
 static unsigned __attribute__((pure)) process_hash_crunch(struct mm_struct *mm)
 {
 	unsigned long hash = ((unsigned long)mm - PAGE_OFFSET) / sizeof(*mm);
@@ -720,16 +726,73 @@ int cobalt_map_user(struct xnthread *thread, __u32 __user *u_winoff)
 	return 0;
 }
 
+#ifdef IPIPE_KEVT_PTRESUME
+static void stop_debugged_process(struct xnthread *thread)
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
+static void resume_debugged_process(struct cobalt_process *process)
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
+#else /* IPIPE_KEVT_PTRESUME unavailable */
+
+static inline void stop_debugged_process(struct xnthread *thread)
+{
+}
+
+static inline void resume_debugged_process(struct cobalt_process *process)
+{
+}
+#endif /* IPIPE_KEVT_PTRESUME unavailable */
+
 /* called with nklock held */
 static void cobalt_register_debugged_thread(struct xnthread *thread)
 {
+	struct cobalt_process *process = process_from_thread(thread);
+
 	xnthread_set_state(thread, XNSSTEP);
+
+	stop_debugged_process(thread);
+	process->debugged_threads++;
+
+	if (xnthread_test_state(thread, XNRELAX))
+		xnthread_suspend(thread, XNDBGSTOP, XN_INFINITE, XN_RELATIVE,
+				 NULL);
 }
 
 /* called with nklock held */
 static void cobalt_unregister_debugged_thread(struct xnthread *thread)
 {
+	struct cobalt_process *process = process_from_thread(thread);
+
+	process->debugged_threads--;
 	xnthread_clear_state(thread, XNSSTEP);
+
+	if (process->debugged_threads == 0)
+		resume_debugged_process(process);
 }
 
 static inline int handle_exception(struct ipipe_trap_data *d)
@@ -740,23 +803,25 @@ static inline int handle_exception(struct ipipe_trap_data *d)
 	sched = xnsched_current();
 	thread = sched->curr;
 
-	if (xnthread_test_state(thread, XNROOT))
-		return 0;
-
-	trace_cobalt_thread_fault(d);
-
 #ifdef IPIPE_KEVT_USERINTRET
 	if (xnarch_fault_bp_p(d) && user_mode(d->regs)) {
 		spl_t s;
 
 		xnlock_get_irqsave(&nklock, s);
-		xnthread_set_info(thread, XNCONTHI);
+		if (!xnthread_test_state(thread, XNRELAX)) {
+			xnthread_set_info(thread, XNCONTHI);
+			ipipe_enable_user_intret_notifier();
+		}
+		stop_debugged_process(thread);
 		xnlock_put_irqrestore(&nklock, s);
-
-		ipipe_enable_user_intret_notifier();
 	}
 #endif
 
+	if (xnthread_test_state(thread, XNROOT))
+		return 0;
+
+	trace_cobalt_thread_fault(d);
+
 	if (xnarch_fault_fpu_p(d)) {
 #ifdef CONFIG_XENO_ARCH_FPU
 		spl_t s;
@@ -991,6 +1056,10 @@ void ipipe_migration_hook(struct task_struct *p) /* hw IRQs off */
 	}
 #endif
 
+	/* Unregister as debugged thread in case we postponed this. */
+	if (unlikely(xnthread_test_state(thread, XNSSTEP)))
+		cobalt_unregister_debugged_thread(thread);
+
 	xnlock_put(&nklock);
 
 	xnsched_run();
@@ -1151,7 +1220,15 @@ static int handle_schedule_event(struct task_struct *next_task)
 			    sigismember(&pending, SIGINT))
 				goto no_ptrace;
 		}
-		cobalt_unregister_debugged_thread(next);
+
+		/*
+		 * Do not unregister before the thread migrated.
+		 * cobalt_unregister_debugged_thread will then be called by our
+		 * ipipe_migration_hook.
+		 */
+		if (!xnthread_test_info(next, XNCONTHI))
+			cobalt_unregister_debugged_thread(next);
+
 		xnthread_set_localinfo(next, XNHICCUP);
 	}
 
@@ -1230,6 +1307,13 @@ static int handle_sigwake_event(struct task_struct *p)
 	if (p->state & (TASK_INTERRUPTIBLE|TASK_UNINTERRUPTIBLE))
 		cobalt_set_task_state(p, p->state | TASK_NOWAKEUP);
 
+	/*
+	 * Allow a thread stopped for debugging to resume briefly in order to
+	 * migrate to secondary mode. xnthread_relax will reapply XNDBGSTOP.
+	 */
+	if (xnthread_test_state(thread, XNDBGSTOP))
+		xnthread_resume(thread, XNDBGSTOP);
+
 	__xnthread_kick(thread);
 
 	xnsched_run();
@@ -1335,6 +1419,30 @@ static int handle_user_return(struct task_struct *task)
 }
 #endif /* IPIPE_KEVT_USERINTRET */
 
+#ifdef IPIPE_KEVT_PTRESUME
+int handle_ptrace_resume(struct ipipe_ptrace_resume_data *resume)
+{
+	struct xnthread *thread;
+	spl_t s;
+
+	thread = xnthread_from_task(resume->task);
+	if (thread == NULL)
+		return KEVENT_PROPAGATE;
+
+	if (resume->request == PTRACE_SINGLESTEP &&
+	    xnthread_test_state(thread, XNSSTEP)) {
+		xnlock_get_irqsave(&nklock, s);
+
+		xnthread_resume(thread, XNDBGSTOP);
+		cobalt_unregister_debugged_thread(thread);
+
+		xnlock_put_irqrestore(&nklock, s);
+	}
+
+	return KEVENT_PROPAGATE;
+}
+#endif /* IPIPE_KEVT_PTRESUME */
+
 int ipipe_kevent_hook(int kevent, void *data)
 {
 	int ret;
@@ -1367,6 +1475,11 @@ int ipipe_kevent_hook(int kevent, void *data)
 	case IPIPE_KEVT_USERINTRET:
 		ret = handle_user_return(data);
 		break;
+#endif
+#ifdef IPIPE_KEVT_PTRESUME
+	case IPIPE_KEVT_PTRESUME:
+		ret = handle_ptrace_resume(data);
+		break;
 #endif
 	default:
 		ret = KEVENT_PROPAGATE;
diff --git a/kernel/cobalt/posix/process.h b/kernel/cobalt/posix/process.h
index f867b8a919..375b4cbbb8 100644
--- a/kernel/cobalt/posix/process.h
+++ b/kernel/cobalt/posix/process.h
@@ -56,6 +56,7 @@ struct cobalt_process {
 	struct cobalt_timer *timers[CONFIG_XENO_OPT_NRTIMERS];
 	void *priv[NR_PERSONALITIES];
 	int ufeatures;
+	unsigned int debugged_threads;
 };
 
 struct cobalt_resnode {
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 902a9b8f1a..6597749a20 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2070,6 +2070,7 @@ void xnthread_relax(int notify, int reason)
 {
 	struct xnthread *thread = xnthread_current();
 	struct task_struct *p = current;
+	int suspension = XNRELAX;
 	int cpu __maybe_unused;
 	siginfo_t si;
 
@@ -2110,11 +2111,12 @@ void xnthread_relax(int notify, int reason)
 	if (xnthread_test_state(thread, XNSSTEP)) {
 		xnthread_set_info(thread, XNCONTHI);
 		ipipe_enable_user_intret_notifier();
+		suspension |= XNDBGSTOP;
 	}
 #endif
 	set_current_state(p->state & ~TASK_NOWAKEUP);
 	xnthread_run_handler_stack(thread, relax_thread);
-	xnthread_suspend(thread, XNRELAX, XN_INFINITE, XN_RELATIVE, NULL);
+	xnthread_suspend(thread, suspension, XN_INFINITE, XN_RELATIVE, NULL);
 	splnone();
 
 	/*
-- 
2.16.4


