From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 2/3] cobalt: Move common cleanup code out of pipeline
 diversion again
Date: Tue, 15 Jun 2021 08:56:32 +0200
Message-Id: <748ed827411a42171a58108e955dc0716770d9d0.1623740192.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1623740192.git.jan.kiszka@siemens.com>
References: <cover.1623740192.git.jan.kiszka@siemens.com>
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

Same pattern as for previous changes: All that code it common, no need
to duplicate it. The only difference between the two versions of
handle_cleanup_event was what is now encapsulated in
pipeline_cleanup_process.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../cobalt/kernel/dovetail/pipeline/kevents.h |   2 +
 .../cobalt/kernel/ipipe/pipeline/kevents.h    |   2 +
 kernel/cobalt/dovetail/kevents.c              | 114 ++---------------
 kernel/cobalt/ipipe/kevents.c                 | 119 ++----------------
 kernel/cobalt/posix/process.c                 | 111 ++++++++++++++++
 kernel/cobalt/posix/process.h                 |   4 +
 6 files changed, 138 insertions(+), 214 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/kevents.h b/include/cobalt/kernel/dovetail/pipeline/kevents.h
index 5cc78721a2..fa47f0375c 100644
--- a/include/cobalt/kernel/dovetail/pipeline/kevents.h
+++ b/include/cobalt/kernel/dovetail/pipeline/kevents.h
@@ -31,4 +31,6 @@ int pipeline_trap_kevents(void);
 
 void pipeline_enable_kevents(void);
 
+void pipeline_cleanup_process(void);
+
 #endif /* !_COBALT_KERNEL_DOVETAIL_KEVENTS_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/kevents.h b/include/cobalt/kernel/ipipe/pipeline/kevents.h
index 2f186a57ee..f3f0c2f95e 100644
--- a/include/cobalt/kernel/ipipe/pipeline/kevents.h
+++ b/include/cobalt/kernel/ipipe/pipeline/kevents.h
@@ -31,4 +31,6 @@ int pipeline_trap_kevents(void);
 
 void pipeline_enable_kevents(void);
 
+void pipeline_cleanup_process(void);
+
 #endif /* !_COBALT_KERNEL_IPIPE_KEVENTS_H */
diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index e2ded266c0..96180731e6 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -22,8 +22,6 @@
 #include "../posix/thread.h"
 #include "../posix/memory.h"
 
-static void detach_current(void);
-
 void arch_inband_task_init(struct task_struct *tsk)
 {
 	struct cobalt_threadinfo *p = dovetail_task_state(tsk);
@@ -99,56 +97,9 @@ static inline int handle_setaffinity_event(struct dovetail_migration_data *d)
 	return cobalt_handle_setaffinity_event(d->task);
 }
 
-static void __handle_taskexit_event(struct task_struct *p)
-{
-	struct cobalt_ppd *sys_ppd;
-	struct xnthread *thread;
-	spl_t s;
-
-	/*
-	 * We are called for both kernel and user shadows over the
-	 * root thread.
-	 */
-	secondary_mode_only();
-
-	thread = xnthread_current();
-	XENO_BUG_ON(COBALT, thread == NULL);
-	trace_cobalt_shadow_unmap(thread);
-
-	xnlock_get_irqsave(&nklock, s);
-
-	if (xnthread_test_state(thread, XNSSTEP))
-		cobalt_unregister_debugged_thread(thread);
-
-	xnsched_run();
-
-	xnlock_put_irqrestore(&nklock, s);
-
-	xnthread_run_handler_stack(thread, exit_thread);
-
-	if (xnthread_test_state(thread, XNUSER)) {
-		cobalt_umm_free(&cobalt_kernel_ppd.umm, thread->u_window);
-		thread->u_window = NULL;
-		sys_ppd = cobalt_ppd_get(0);
-		if (atomic_dec_and_test(&sys_ppd->refcnt))
-			cobalt_remove_process(cobalt_current_process());
-	}
-}
-
-static int handle_taskexit_event(struct task_struct *p) /* p == current */
+static inline int handle_taskexit_event(struct task_struct *p)
 {
-	__handle_taskexit_event(p);
-
-	/*
-	 * __xnthread_cleanup() -> ... -> finalize_thread
-	 * handler. From that point, the TCB is dropped. Be careful of
-	 * not treading on stale memory within @thread.
-	 */
-	__xnthread_cleanup(xnthread_current());
-
-	detach_current();
-
-	return KEVENT_PROPAGATE;
+	return cobalt_handle_taskexit_event(p);
 }
 
 static int handle_user_return(struct task_struct *task)
@@ -238,55 +189,14 @@ out:
 	return KEVENT_PROPAGATE;
 }
 
-static int handle_cleanup_event(struct mm_struct *mm)
+static inline int handle_cleanup_event(struct mm_struct *mm)
 {
-	struct cobalt_process *old, *process;
-	struct cobalt_ppd *sys_ppd;
-	struct xnthread *curr;
-
-	/*
-	 * We are NOT called for exiting kernel shadows.
-	 * cobalt_current_process() is cleared if we get there after
-	 * handle_task_exit(), so we need to restore this context
-	 * pointer temporarily.
-	 */
-	process = cobalt_search_process(mm);
-	old = cobalt_set_process(process);
-	sys_ppd = cobalt_ppd_get(0);
-	if (sys_ppd != &cobalt_kernel_ppd) {
-		bool running_exec;
-
-		/*
-		 * Detect a userland shadow running exec(), i.e. still
-		 * attached to the current linux task (no prior
-		 * detach_current). In this case, we emulate a task
-		 * exit, since the Xenomai binding shall not survive
-		 * the exec() syscall. Since the process will keep on
-		 * running though, we have to disable the event
-		 * notifier manually for it.
-		 */
-		curr = xnthread_current();
-		running_exec = curr && (current->flags & PF_EXITING) == 0;
-		if (running_exec) {
-			__handle_taskexit_event(current);
-			dovetail_stop_altsched();
-		}
-		if (atomic_dec_and_test(&sys_ppd->refcnt))
-			cobalt_remove_process(process);
-		if (running_exec) {
-			__xnthread_cleanup(curr);
-			detach_current();
-		}
-	}
-
-	/*
-	 * CAUTION: Do not override a state change caused by
-	 * cobalt_remove_process().
-	 */
-	if (cobalt_current_process() == process)
-		cobalt_set_process(old);
+	return cobalt_handle_cleanup_event(mm);
+}
 
-	return KEVENT_PROPAGATE;
+void pipeline_cleanup_process(void)
+{
+	dovetail_stop_altsched();
 }
 
 int handle_ptrace_resume(struct task_struct *tracee)
@@ -456,14 +366,6 @@ void pipeline_attach_current(struct xnthread *thread)
 	dovetail_init_altsched(&xnthread_archtcb(thread)->altsched);
 }
 
-static void detach_current(void)
-{
-	struct cobalt_threadinfo *p = pipeline_current();
-
-	p->thread = NULL;
-	p->process = NULL;
-}
-
 int pipeline_trap_kevents(void)
 {
 	dovetail_start();
diff --git a/kernel/cobalt/ipipe/kevents.c b/kernel/cobalt/ipipe/kevents.c
index 3142d17780..94a951d0a6 100644
--- a/kernel/cobalt/ipipe/kevents.c
+++ b/kernel/cobalt/ipipe/kevents.c
@@ -24,8 +24,6 @@
 #include "../posix/thread.h"
 #include "../posix/memory.h"
 
-static void detach_current(void);
-
 static inline int handle_exception(struct ipipe_trap_data *d)
 {
 	struct xnthread *thread;
@@ -156,6 +154,11 @@ static inline int handle_setaffinity_event(struct ipipe_cpu_migration_data *d)
 	return cobalt_handle_setaffinity_event(d->task);
 }
 
+static inline int handle_taskexit_event(struct task_struct *p)
+{
+	return cobalt_handle_taskexit_event(p);
+}
+
 void ipipe_migration_hook(struct task_struct *p) /* hw IRQs off */
 {
 	struct xnthread *thread = xnthread_from_task(p);
@@ -242,58 +245,6 @@ static inline void init_hostrt(void) { }
 
 #endif /* !CONFIG_IPIPE_HAVE_HOSTRT */
 
-static void __handle_taskexit_event(struct task_struct *p)
-{
-	struct cobalt_ppd *sys_ppd;
-	struct xnthread *thread;
-	spl_t s;
-
-	/*
-	 * We are called for both kernel and user shadows over the
-	 * root thread.
-	 */
-	secondary_mode_only();
-
-	thread = xnthread_current();
-	XENO_BUG_ON(COBALT, thread == NULL);
-	trace_cobalt_shadow_unmap(thread);
-
-	xnlock_get_irqsave(&nklock, s);
-
-	if (xnthread_test_state(thread, XNSSTEP))
-		cobalt_unregister_debugged_thread(thread);
-
-	xnsched_run();
-
-	xnlock_put_irqrestore(&nklock, s);
-
-	xnthread_run_handler_stack(thread, exit_thread);
-
-	if (xnthread_test_state(thread, XNUSER)) {
-		cobalt_umm_free(&cobalt_kernel_ppd.umm, thread->u_window);
-		thread->u_window = NULL;
-		sys_ppd = cobalt_ppd_get(0);
-		if (atomic_dec_and_test(&sys_ppd->refcnt))
-			cobalt_remove_process(cobalt_current_process());
-	}
-}
-
-static int handle_taskexit_event(struct task_struct *p) /* p == current */
-{
-	__handle_taskexit_event(p);
-
-	/*
-	 * __xnthread_cleanup() -> ... -> finalize_thread
-	 * handler. From that point, the TCB is dropped. Be careful of
-	 * not treading on stale memory within @thread.
-	 */
-	__xnthread_cleanup(xnthread_current());
-
-	detach_current();
-
-	return KEVENT_PROPAGATE;
-}
-
 static int handle_schedule_event(struct task_struct *next_task)
 {
 	struct task_struct *prev_task;
@@ -431,55 +382,14 @@ out:
 	return KEVENT_PROPAGATE;
 }
 
-static int handle_cleanup_event(struct mm_struct *mm)
+static inline int handle_cleanup_event(struct mm_struct *mm)
 {
-	struct cobalt_process *old, *process;
-	struct cobalt_ppd *sys_ppd;
-	struct xnthread *curr;
-
-	/*
-	 * We are NOT called for exiting kernel shadows.
-	 * cobalt_current_process() is cleared if we get there after
-	 * handle_task_exit(), so we need to restore this context
-	 * pointer temporarily.
-	 */
-	process = cobalt_search_process(mm);
-	old = cobalt_set_process(process);
-	sys_ppd = cobalt_ppd_get(0);
-	if (sys_ppd != &cobalt_kernel_ppd) {
-		bool running_exec;
-
-		/*
-		 * Detect a userland shadow running exec(), i.e. still
-		 * attached to the current linux task (no prior
-		 * detach_current). In this case, we emulate a task
-		 * exit, since the Xenomai binding shall not survive
-		 * the exec() syscall. Since the process will keep on
-		 * running though, we have to disable the event
-		 * notifier manually for it.
-		 */
-		curr = xnthread_current();
-		running_exec = curr && (current->flags & PF_EXITING) == 0;
-		if (running_exec) {
-			__handle_taskexit_event(current);
-			ipipe_disable_notifier(current);
-		}
-		if (atomic_dec_and_test(&sys_ppd->refcnt))
-			cobalt_remove_process(process);
-		if (running_exec) {
-			__xnthread_cleanup(curr);
-			detach_current();
-		}
-	}
-
-	/*
-	 * CAUTION: Do not override a state change caused by
-	 * cobalt_remove_process().
-	 */
-	if (cobalt_current_process() == process)
-		cobalt_set_process(old);
+	return cobalt_handle_cleanup_event(mm);
+}
 
-	return KEVENT_PROPAGATE;
+void pipeline_cleanup_process(void)
+{
+	ipipe_disable_notifier(current);
 }
 
 static inline int handle_clockfreq_event(unsigned int *p)
@@ -642,13 +552,6 @@ void pipeline_attach_current(struct xnthread *thread)
 	p->process = cobalt_search_process(current->mm);
 }
 
-static void detach_current(void)
-{
-	struct cobalt_threadinfo *p = pipeline_current();
-	p->thread = NULL;
-	p->process = NULL;
-}
-
 int pipeline_trap_kevents(void)
 {
 	init_hostrt();
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 5f92ba8b3d..3cbad9bbb0 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -834,6 +834,117 @@ bool cobalt_affinity_ok(struct task_struct *task) /* nklocked, IRQs off */
 }
 #endif /* CONFIG_SMP */
 
+static void __handle_taskexit_event(struct task_struct *p)
+{
+	struct cobalt_ppd *sys_ppd;
+	struct xnthread *thread;
+	spl_t s;
+
+	/*
+	 * We are called for both kernel and user shadows over the
+	 * root thread.
+	 */
+	secondary_mode_only();
+
+	thread = xnthread_current();
+	XENO_BUG_ON(COBALT, thread == NULL);
+	trace_cobalt_shadow_unmap(thread);
+
+	xnlock_get_irqsave(&nklock, s);
+
+	if (xnthread_test_state(thread, XNSSTEP))
+		cobalt_unregister_debugged_thread(thread);
+
+	xnsched_run();
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	xnthread_run_handler_stack(thread, exit_thread);
+
+	if (xnthread_test_state(thread, XNUSER)) {
+		cobalt_umm_free(&cobalt_kernel_ppd.umm, thread->u_window);
+		thread->u_window = NULL;
+		sys_ppd = cobalt_ppd_get(0);
+		if (atomic_dec_and_test(&sys_ppd->refcnt))
+			cobalt_remove_process(cobalt_current_process());
+	}
+}
+
+static void detach_current(void)
+{
+	struct cobalt_threadinfo *p = pipeline_current();
+
+	p->thread = NULL;
+	p->process = NULL;
+}
+
+int cobalt_handle_taskexit_event(struct task_struct *task) /* task == current */
+{
+	__handle_taskexit_event(task);
+
+	/*
+	 * __xnthread_cleanup() -> ... -> finalize_thread
+	 * handler. From that point, the TCB is dropped. Be careful of
+	 * not treading on stale memory within @thread.
+	 */
+	__xnthread_cleanup(xnthread_current());
+
+	detach_current();
+
+	return KEVENT_PROPAGATE;
+}
+
+int cobalt_handle_cleanup_event(struct mm_struct *mm)
+{
+	struct cobalt_process *old, *process;
+	struct cobalt_ppd *sys_ppd;
+	struct xnthread *curr;
+
+	/*
+	 * We are NOT called for exiting kernel shadows.
+	 * cobalt_current_process() is cleared if we get there after
+	 * handle_task_exit(), so we need to restore this context
+	 * pointer temporarily.
+	 */
+	process = cobalt_search_process(mm);
+	old = cobalt_set_process(process);
+	sys_ppd = cobalt_ppd_get(0);
+	if (sys_ppd != &cobalt_kernel_ppd) {
+		bool running_exec;
+
+		/*
+		 * Detect a userland shadow running exec(), i.e. still
+		 * attached to the current linux task (no prior
+		 * detach_current). In this case, we emulate a task
+		 * exit, since the Xenomai binding shall not survive
+		 * the exec() syscall. Since the process will keep on
+		 * running though, we have to disable the event
+		 * notifier manually for it.
+		 */
+		curr = xnthread_current();
+		running_exec = curr && (current->flags & PF_EXITING) == 0;
+		if (running_exec) {
+			__handle_taskexit_event(current);
+			pipeline_cleanup_process();
+		}
+		if (atomic_dec_and_test(&sys_ppd->refcnt))
+			cobalt_remove_process(process);
+		if (running_exec) {
+			__xnthread_cleanup(curr);
+			detach_current();
+		}
+	}
+
+	/*
+	 * CAUTION: Do not override a state change caused by
+	 * cobalt_remove_process().
+	 */
+	if (cobalt_current_process() == process)
+		cobalt_set_process(old);
+
+	return KEVENT_PROPAGATE;
+}
+
 static int attach_process(struct cobalt_process *process)
 {
 	struct cobalt_ppd *p = &process->sys_ppd;
diff --git a/kernel/cobalt/posix/process.h b/kernel/cobalt/posix/process.h
index 051a0d90be..de3d9144d7 100644
--- a/kernel/cobalt/posix/process.h
+++ b/kernel/cobalt/posix/process.h
@@ -169,4 +169,8 @@ bool cobalt_affinity_ok(struct task_struct *task);
 #define cobalt_affinity_ok(task)	(true)
 #endif
 
+int cobalt_handle_taskexit_event(struct task_struct *task);
+
+int cobalt_handle_cleanup_event(struct mm_struct *mm);
+
 #endif /* !_COBALT_POSIX_PROCESS_H */
-- 
2.26.2


