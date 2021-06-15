From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/3] cobalt: Move common affinity handling code out of
 pipeline diversion again
Date: Tue, 15 Jun 2021 08:56:31 +0200
Message-Id: <926b795b8d3e530497a41ccd525da965b58d1858.1623740192.git.jan.kiszka@siemens.com>
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
to duplicate it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/dovetail/kevents.c | 113 +-----------------------------
 kernel/cobalt/ipipe/kevents.c    | 115 +------------------------------
 kernel/cobalt/posix/process.c    |  99 ++++++++++++++++++++++++++
 kernel/cobalt/posix/process.h    |   8 +++
 4 files changed, 113 insertions(+), 222 deletions(-)

diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index f27d5a966d..e2ded266c0 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -94,118 +94,11 @@ void handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
 	xnthread_relax(xnarch_fault_notify(trapnr), SIGDEBUG_MIGRATE_FAULT);
 }
 
-#ifdef CONFIG_SMP
-
-static int handle_setaffinity_event(struct dovetail_migration_data *d)
-{
-	struct task_struct *p = d->task;
-	struct xnthread *thread;
-	spl_t s;
-
-	thread = xnthread_from_task(p);
-	if (thread == NULL)
-		return KEVENT_PROPAGATE;
-
-	/*
-	 * Detect a Cobalt thread sleeping in primary mode which is
-	 * required to migrate to another CPU by the host kernel.
-	 *
-	 * We may NOT fix up thread->sched immediately using the
-	 * passive migration call, because that latter always has to
-	 * take place on behalf of the target thread itself while
-	 * running in secondary mode. Therefore, that thread needs to
-	 * go through secondary mode first, then move back to primary
-	 * mode, so that affinity_ok() does the fixup work.
-	 *
-	 * We force this by sending a SIGSHADOW signal to the migrated
-	 * thread, asking it to switch back to primary mode from the
-	 * handler, at which point the interrupted syscall may be
-	 * restarted.
-	 */
-	xnlock_get_irqsave(&nklock, s);
-
-	if (xnthread_test_state(thread, XNTHREAD_BLOCK_BITS & ~XNRELAX))
-		__xnthread_signal(thread, SIGSHADOW, SIGSHADOW_ACTION_HARDEN);
-
-	xnlock_put_irqrestore(&nklock, s);
-
-	return KEVENT_PROPAGATE;
-}
-
-static inline bool affinity_ok(struct task_struct *p) /* nklocked, IRQs off */
-{
-	struct xnthread *thread = xnthread_from_task(p);
-	struct xnsched *sched;
-	int cpu = task_cpu(p);
-
-	/*
-	 * To maintain consistency between both Cobalt and host
-	 * schedulers, reflecting a thread migration to another CPU
-	 * into the Cobalt scheduler state must happen from secondary
-	 * mode only, on behalf of the migrated thread itself once it
-	 * runs on the target CPU.
-	 *
-	 * This means that the Cobalt scheduler state regarding the
-	 * CPU information lags behind the host scheduler state until
-	 * the migrated thread switches back to primary mode
-	 * (i.e. task_cpu(p) != xnsched_cpu(xnthread_from_task(p)->sched)).
-	 * This is ok since Cobalt does not schedule such thread until then.
-	 *
-	 * check_affinity() detects when a Cobalt thread switching
-	 * back to primary mode did move to another CPU earlier while
-	 * in secondary mode. If so, do the fixups to reflect the
-	 * change.
-	 */
-	if (!xnsched_threading_cpu(cpu)) {
-		/*
-		 * The thread is about to switch to primary mode on a
-		 * non-rt CPU, which is damn wrong and hopeless.
-		 * Whine and cancel that thread.
-		 */
-		printk(XENO_WARNING "thread %s[%d] switched to non-rt CPU%d, aborted.\n",
-		       thread->name, xnthread_host_pid(thread), cpu);
-		/*
-		 * Can't call xnthread_cancel() from a migration
-		 * point, that would break. Since we are on the wakeup
-		 * path to hardening, just raise XNCANCELD to catch it
-		 * in xnthread_harden().
-		 */
-		xnthread_set_info(thread, XNCANCELD);
-		return false;
-	}
-
-	sched = xnsched_struct(cpu);
-	if (sched == thread->sched)
-		return true;
-
-	/*
-	 * The current thread moved to a supported real-time CPU,
-	 * which is not part of its original affinity mask
-	 * though. Assume user wants to extend this mask.
-	 */
-	if (!cpumask_test_cpu(cpu, &thread->affinity))
-		cpumask_set_cpu(cpu, &thread->affinity);
-
-	xnthread_run_handler_stack(thread, move_thread, cpu);
-	xnthread_migrate_passive(thread, sched);
-
-	return true;
-}
-
-#else /* !CONFIG_SMP */
-
-static int handle_setaffinity_event(struct dovetail_migration_data *d)
+static inline int handle_setaffinity_event(struct dovetail_migration_data *d)
 {
-	return KEVENT_PROPAGATE;
+	return cobalt_handle_setaffinity_event(d->task);
 }
 
-static inline bool affinity_ok(struct task_struct *p)
-{
-	return true;
-}
-
-#endif /* CONFIG_SMP */
-
 static void __handle_taskexit_event(struct task_struct *p)
 {
 	struct cobalt_ppd *sys_ppd;
@@ -531,7 +424,7 @@ void resume_oob_task(struct task_struct *p) /* inband, oob stage stalled */
 	 * relax_thread/harden_thread handlers.
 	 */
 	xnthread_run_handler_stack(thread, harden_thread);
-	if (affinity_ok(p))
+	if (cobalt_affinity_ok(p))
 		xnthread_resume(thread, XNRELAX);
 
 	/*
diff --git a/kernel/cobalt/ipipe/kevents.c b/kernel/cobalt/ipipe/kevents.c
index b0869cbf83..3142d17780 100644
--- a/kernel/cobalt/ipipe/kevents.c
+++ b/kernel/cobalt/ipipe/kevents.c
@@ -151,120 +151,11 @@ bool ipipe_enter_idle_hook(void)
 	return true;
 }
 
-#ifdef CONFIG_SMP
-
-static int handle_setaffinity_event(struct ipipe_cpu_migration_data *d)
+static inline int handle_setaffinity_event(struct ipipe_cpu_migration_data *d)
 {
-	struct task_struct *p = d->task;
-	struct xnthread *thread;
-	spl_t s;
-
-	thread = xnthread_from_task(p);
-	if (thread == NULL)
-		return KEVENT_PROPAGATE;
-
-	/*
-	 * Detect a Cobalt thread sleeping in primary mode which is
-	 * required to migrate to another CPU by the host kernel.
-	 *
-	 * We may NOT fix up thread->sched immediately using the
-	 * passive migration call, because that latter always has to
-	 * take place on behalf of the target thread itself while
-	 * running in secondary mode. Therefore, that thread needs to
-	 * go through secondary mode first, then move back to primary
-	 * mode, so that affinity_ok() does the fixup work.
-	 *
-	 * We force this by sending a SIGSHADOW signal to the migrated
-	 * thread, asking it to switch back to primary mode from the
-	 * handler, at which point the interrupted syscall may be
-	 * restarted.
-	 */
-	xnlock_get_irqsave(&nklock, s);
-
-	if (xnthread_test_state(thread, XNTHREAD_BLOCK_BITS & ~XNRELAX))
-		__xnthread_signal(thread, SIGSHADOW, SIGSHADOW_ACTION_HARDEN);
-
-	xnlock_put_irqrestore(&nklock, s);
-
-	return KEVENT_PROPAGATE;
+	return cobalt_handle_setaffinity_event(d->task);
 }
 
-static inline bool affinity_ok(struct task_struct *p) /* nklocked, IRQs off */
-{
-	struct xnthread *thread = xnthread_from_task(p);
-	struct xnsched *sched;
-	int cpu = task_cpu(p);
-
-	/*
-	 * To maintain consistency between both Cobalt and host
-	 * schedulers, reflecting a thread migration to another CPU
-	 * into the Cobalt scheduler state must happen from secondary
-	 * mode only, on behalf of the migrated thread itself once it
-	 * runs on the target CPU.
-	 *
-	 * This means that the Cobalt scheduler state regarding the
-	 * CPU information lags behind the host scheduler state until
-	 * the migrated thread switches back to primary mode
-	 * (i.e. task_cpu(p) != xnsched_cpu(xnthread_from_task(p)->sched)).
-	 * This is ok since Cobalt does not schedule such thread until then.
-	 *
-	 * check_affinity() detects when a Cobalt thread switching
-	 * back to primary mode did move to another CPU earlier while
-	 * in secondary mode. If so, do the fixups to reflect the
-	 * change.
-	 */
-	if (!xnsched_threading_cpu(cpu)) {
-		/*
-		 * The thread is about to switch to primary mode on a
-		 * non-rt CPU, which is damn wrong and hopeless.
-		 * Whine and cancel that thread.
-		 */
-		printk(XENO_WARNING "thread %s[%d] switched to non-rt CPU%d, aborted.\n",
-		       thread->name, xnthread_host_pid(thread), cpu);
-		/*
-		 * Can't call xnthread_cancel() from a migration
-		 * point, that would break. Since we are on the wakeup
-		 * path to hardening, just raise XNCANCELD to catch it
-		 * in xnthread_harden().
-		 */
-		xnthread_set_info(thread, XNCANCELD);
-		return false;
-	}
-
-	sched = xnsched_struct(cpu);
-	if (sched == thread->sched)
-		return true;
-
-	/*
-	 * The current thread moved to a supported real-time CPU,
-	 * which is not part of its original affinity mask
-	 * though. Assume user wants to extend this mask.
-	 */
-	if (!cpumask_test_cpu(cpu, &thread->affinity))
-		cpumask_set_cpu(cpu, &thread->affinity);
-
-	xnthread_run_handler_stack(thread, move_thread, cpu);
-	xnthread_migrate_passive(thread, sched);
-
-	return true;
-}
-
-#else /* !CONFIG_SMP */
-
-struct ipipe_cpu_migration_data;
-
-static int handle_setaffinity_event(struct ipipe_cpu_migration_data *d)
-{
-	return KEVENT_PROPAGATE;
-}
-
-static inline bool affinity_ok(struct task_struct *p)
-{
-	return true;
-}
-
-#endif /* CONFIG_SMP */
-
 void ipipe_migration_hook(struct task_struct *p) /* hw IRQs off */
 {
 	struct xnthread *thread = xnthread_from_task(p);
@@ -277,7 +168,7 @@ void ipipe_migration_hook(struct task_struct *p) /* hw IRQs off */
 	 * relax_thread/harden_thread handlers.
 	 */
 	xnthread_run_handler_stack(thread, harden_thread);
-	if (affinity_ok(p))
+	if (cobalt_affinity_ok(p))
 		xnthread_resume(thread, XNRELAX);
 
 	/*
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 2ed98e05bc..5f92ba8b3d 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -735,6 +735,105 @@ void cobalt_unregister_debugged_thread(struct xnthread *thread)
 		cobalt_resume_debugged_process(process);
 }
 
+int cobalt_handle_setaffinity_event(struct task_struct *task)
+{
+#ifdef CONFIG_SMP
+	struct xnthread *thread;
+	spl_t s;
+
+	thread = xnthread_from_task(task);
+	if (thread == NULL)
+		return KEVENT_PROPAGATE;
+
+	/*
+	 * Detect a Cobalt thread sleeping in primary mode which is
+	 * required to migrate to another CPU by the host kernel.
+	 *
+	 * We may NOT fix up thread->sched immediately using the
+	 * passive migration call, because that latter always has to
+	 * take place on behalf of the target thread itself while
+	 * running in secondary mode. Therefore, that thread needs to
+	 * go through secondary mode first, then move back to primary
+	 * mode, so that affinity_ok() does the fixup work.
+	 *
+	 * We force this by sending a SIGSHADOW signal to the migrated
+	 * thread, asking it to switch back to primary mode from the
+	 * handler, at which point the interrupted syscall may be
+	 * restarted.
+	 */
+	xnlock_get_irqsave(&nklock, s);
+
+	if (xnthread_test_state(thread, XNTHREAD_BLOCK_BITS & ~XNRELAX))
+		__xnthread_signal(thread, SIGSHADOW, SIGSHADOW_ACTION_HARDEN);
+
+	xnlock_put_irqrestore(&nklock, s);
+#endif /* CONFIG_SMP */
+
+	return KEVENT_PROPAGATE;
+}
+
+#ifdef CONFIG_SMP
+bool cobalt_affinity_ok(struct task_struct *task) /* nklocked, IRQs off */
+{
+	struct xnthread *thread = xnthread_from_task(task);
+	struct xnsched *sched;
+	int cpu = task_cpu(task);
+
+	/*
+	 * To maintain consistency between both Cobalt and host
+	 * schedulers, reflecting a thread migration to another CPU
+	 * into the Cobalt scheduler state must happen from secondary
+	 * mode only, on behalf of the migrated thread itself once it
+	 * runs on the target CPU.
+	 *
+	 * This means that the Cobalt scheduler state regarding the
+	 * CPU information lags behind the host scheduler state until
+	 * the migrated thread switches back to primary mode
+	 * (i.e. task_cpu(p) != xnsched_cpu(xnthread_from_task(p)->sched)).
+	 * This is ok since Cobalt does not schedule such thread until then.
+	 *
+	 * check_affinity() detects when a Cobalt thread switching
+	 * back to primary mode did move to another CPU earlier while
+	 * in secondary mode. If so, do the fixups to reflect the
+	 * change.
+	 */
+	if (!xnsched_threading_cpu(cpu)) {
+		/*
+		 * The thread is about to switch to primary mode on a
+		 * non-rt CPU, which is damn wrong and hopeless.
+		 * Whine and cancel that thread.
+		 */
+		printk(XENO_WARNING "thread %s[%d] switched to non-rt CPU%d, aborted.\n",
+		       thread->name, xnthread_host_pid(thread), cpu);
+		/*
+		 * Can't call xnthread_cancel() from a migration
+		 * point, that would break. Since we are on the wakeup
+		 * path to hardening, just raise XNCANCELD to catch it
+		 * in xnthread_harden().
+		 */
+		xnthread_set_info(thread, XNCANCELD);
+		return false;
+	}
+
+	sched = xnsched_struct(cpu);
+	if (sched == thread->sched)
+		return true;
+
+	/*
+	 * The current thread moved to a supported real-time CPU,
+	 * which is not part of its original affinity mask
+	 * though. Assume user wants to extend this mask.
+	 */
+	if (!cpumask_test_cpu(cpu, &thread->affinity))
+		cpumask_set_cpu(cpu, &thread->affinity);
+
+	xnthread_run_handler_stack(thread, move_thread, cpu);
+	xnthread_migrate_passive(thread, sched);
+
+	return true;
+}
+#endif /* CONFIG_SMP */
+
 static int attach_process(struct cobalt_process *process)
 {
 	struct cobalt_ppd *p = &process->sys_ppd;
diff --git a/kernel/cobalt/posix/process.h b/kernel/cobalt/posix/process.h
index 767d75e8ba..051a0d90be 100644
--- a/kernel/cobalt/posix/process.h
+++ b/kernel/cobalt/posix/process.h
@@ -161,4 +161,12 @@ extern struct xnthread_personality *cobalt_personalities[];
 
 extern struct xnthread_personality cobalt_personality;
 
+int cobalt_handle_setaffinity_event(struct task_struct *task);
+
+#ifdef CONFIG_SMP
+bool cobalt_affinity_ok(struct task_struct *task);
+#else
+#define cobalt_affinity_ok(task)	(true)
+#endif
+
 #endif /* !_COBALT_POSIX_PROCESS_H */
-- 
2.26.2


