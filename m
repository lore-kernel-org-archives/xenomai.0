From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC][PATCH 2/7] cobalt/kernel: Switch back ptraced primary mode
 threads on resume
Date: Fri, 30 Nov 2018 21:03:16 +0100
Message-Id: <0b395c00c364fa8fe93a8766b3c5bc516e807698.1543608201.git.jan.kiszka@siemens.com>
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

When a thread is stopped in primary mode for debugging, make sure it
will migrate back before resuming in user space. This is a building
block for making real-time process debugging more deterministic.

The information if a thread should resume in primary is transported via
a new thread info flag XNCONTHI. It is set either by the exception
handler detecting a breakpoint hit in primary user mode or by
xnthread_relax when invoked for a thread under XNSSTEP which indicates
it was signaled to stop.

The feature depends on the new I-pipe notifier for user interrupt
return, i.e. a callback from the point that a secondary mode thread is
about to return to user space after an exception or an interrupt.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/uapi/kernel/thread.h |  1 +
 kernel/cobalt/posix/process.c       | 68 ++++++++++++++++++++++++++++++++++++-
 kernel/cobalt/thread.c              | 12 +++++++
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/uapi/kernel/thread.h b/include/cobalt/uapi/kernel/thread.h
index f583ae3854..04982ee0e4 100644
--- a/include/cobalt/uapi/kernel/thread.h
+++ b/include/cobalt/uapi/kernel/thread.h
@@ -72,6 +72,7 @@
 #define XNCANCELD 0x00000040 /**< Cancellation request is pending */
 #define XNPIALERT 0x00000080 /**< Priority inversion alert (SIGDEBUG sent) */
 #define XNSCHEDP  0x00000100 /**< schedparam propagation is pending */
+#define XNCONTHI  0x00000200 /**< Continue in primary mode after debugging */
 
 /* Local information flags (private to current thread) */
 
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index f4ebf194f6..1e679762aa 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -745,6 +745,18 @@ static inline int handle_exception(struct ipipe_trap_data *d)
 
 	trace_cobalt_thread_fault(d);
 
+#ifdef IPIPE_KEVT_USERINTRET
+	if (xnarch_fault_bp_p(d) && user_mode(d->regs)) {
+		spl_t s;
+
+		xnlock_get_irqsave(&nklock, s);
+		xnthread_set_info(thread, XNCONTHI);
+		xnlock_put_irqrestore(&nklock, s);
+
+		ipipe_enable_user_intret_notifier();
+	}
+#endif
+
 	if (xnarch_fault_fpu_p(d)) {
 #ifdef CONFIG_XENO_ARCH_FPU
 		spl_t s;
@@ -957,15 +969,28 @@ void ipipe_migration_hook(struct task_struct *p) /* hw IRQs off */
 {
 	struct xnthread *thread = xnthread_from_task(p);
 
+	xnlock_get(&nklock);
+
 	/*
 	 * We fire the handler before the thread is migrated, so that
 	 * thread->sched does not change between paired invocations of
 	 * relax_thread/harden_thread handlers.
 	 */
-	xnlock_get(&nklock);
 	xnthread_run_handler_stack(thread, harden_thread);
 	if (affinity_ok(p))
 		xnthread_resume(thread, XNRELAX);
+
+#ifdef IPIPE_KEVT_USERINTRET
+	/*
+	 * In case we migrated independently of the user return notifier, clear
+	 * XNCONTHI here and also disable the notifier - we are already done.
+	 */
+	if (unlikely(xnthread_test_info(thread, XNCONTHI))) {
+		xnthread_clear_info(thread, XNCONTHI);
+		ipipe_disable_user_intret_notifier();
+	}
+#endif
+
 	xnlock_put(&nklock);
 
 	xnsched_run();
@@ -1274,6 +1299,42 @@ static inline int handle_clockfreq_event(unsigned int *p)
 	return KEVENT_PROPAGATE;
 }
 
+#ifdef IPIPE_KEVT_USERINTRET
+static int handle_user_return(struct task_struct *task)
+{
+	struct xnthread *thread;
+	spl_t s;
+	int err;
+
+	ipipe_disable_user_intret_notifier();
+
+	thread = xnthread_from_task(task);
+	if (thread == NULL)
+		return KEVENT_PROPAGATE;
+
+	if (xnthread_test_info(thread, XNCONTHI)) {
+		xnlock_get_irqsave(&nklock, s);
+		xnthread_clear_info(thread, XNCONTHI);
+		xnlock_put_irqrestore(&nklock, s);
+
+		err = xnthread_harden();
+
+		/*
+		 * XNCONTHI may or may not have been re-applied if
+		 * harden bailed out due to pending signals. Make sure
+		 * it is set in that case.
+		 */
+		if (err == -ERESTARTSYS) {
+			xnlock_get_irqsave(&nklock, s);
+			xnthread_set_info(thread, XNCONTHI);
+			xnlock_put_irqrestore(&nklock, s);
+		}
+	}
+
+	return KEVENT_PROPAGATE;
+}
+#endif /* IPIPE_KEVT_USERINTRET */
+
 int ipipe_kevent_hook(int kevent, void *data)
 {
 	int ret;
@@ -1301,6 +1362,11 @@ int ipipe_kevent_hook(int kevent, void *data)
 	case IPIPE_KEVT_CLOCKFREQ:
 		ret = handle_clockfreq_event(data);
 		break;
+#endif
+#ifdef IPIPE_KEVT_USERINTRET
+	case IPIPE_KEVT_USERINTRET:
+		ret = handle_user_return(data);
+		break;
 #endif
 	default:
 		ret = KEVENT_PROPAGATE;
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 1a069d07c9..902a9b8f1a 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2100,6 +2100,18 @@ void xnthread_relax(int notify, int reason)
 	 * dropped by xnthread_suspend().
 	 */
 	xnlock_get(&nklock);
+#ifdef IPIPE_KEVT_USERINTRET
+	/*
+	 * If the thread is being debugged, record that it should migrate back
+	 * in case it resumes in userspace. If it resumes in kernel space, i.e.
+	 * over a restarting syscall, the associated hardening will both clear
+	 * XNCONTHI and disable the user return notifier again.
+	 */
+	if (xnthread_test_state(thread, XNSSTEP)) {
+		xnthread_set_info(thread, XNCONTHI);
+		ipipe_enable_user_intret_notifier();
+	}
+#endif
 	set_current_state(p->state & ~TASK_NOWAKEUP);
 	xnthread_run_handler_stack(thread, relax_thread);
 	xnthread_suspend(thread, XNRELAX, XN_INFINITE, XN_RELATIVE, NULL);
-- 
2.16.4


