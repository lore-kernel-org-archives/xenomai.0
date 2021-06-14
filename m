From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/2] cobalt/ipipe: Drop tests for IPIPE_KEVT_*
Date: Mon, 14 Jun 2021 14:07:35 +0200
Message-Id: <31d0c3616192e29c9a719d0ade56977120204273.1623672456.git.jan.kiszka@siemens.com>
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

All those events have been added long ago to I-pipe versions we want to
support with the next release. Time to drop the tests which will also
allow sharing some code with dovetail.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/ipipe/kevents.c | 28 ----------------------------
 kernel/cobalt/ipipe/sched.c   |  2 --
 2 files changed, 30 deletions(-)

diff --git a/kernel/cobalt/ipipe/kevents.c b/kernel/cobalt/ipipe/kevents.c
index 19970c8b8..32d305cb2 100644
--- a/kernel/cobalt/ipipe/kevents.c
+++ b/kernel/cobalt/ipipe/kevents.c
@@ -32,8 +32,6 @@ process_from_thread(struct xnthread *thread)
 	return container_of(thread, struct cobalt_thread, threadbase)->process;
 }
 
-#ifdef IPIPE_KEVT_PTRESUME
-
 static void stop_debugged_process(struct xnthread *thread)
 {
 	struct cobalt_process *process = process_from_thread(thread);
@@ -64,18 +62,6 @@ static void resume_debugged_process(struct cobalt_process *process)
 	xnsched_unlock();
 }
 
-#else /* !IPIPE_KEVT_PTRESUME */
-
-static inline void stop_debugged_process(struct xnthread *thread)
-{
-}
-
-static inline void resume_debugged_process(struct cobalt_process *process)
-{
-}
-
-#endif /* !IPIPE_KEVT_PTRESUME */
-
 /* called with nklock held */
 static void register_debugged_thread(struct xnthread *thread)
 {
@@ -117,7 +103,6 @@ static inline int handle_exception(struct ipipe_trap_data *d)
 	if (xnthread_test_state(thread, XNROOT))
 		return 0;
 
-#ifdef IPIPE_KEVT_USERINTRET
 	if (xnarch_fault_bp_p(d) && user_mode(d->regs)) {
 		spl_t s;
 
@@ -129,7 +114,6 @@ static inline int handle_exception(struct ipipe_trap_data *d)
 		xnlock_put_irqrestore(&nklock, s);
 		xnsched_run();
 	}
-#endif
 
 	if (xnarch_fault_fpu_p(d)) {
 #ifdef CONFIG_XENO_ARCH_FPU
@@ -359,7 +343,6 @@ void ipipe_migration_hook(struct task_struct *p) /* hw IRQs off */
 	if (affinity_ok(p))
 		xnthread_resume(thread, XNRELAX);
 
-#ifdef IPIPE_KEVT_USERINTRET
 	/*
 	 * In case we migrated independently of the user return notifier, clear
 	 * XNCONTHI here and also disable the notifier - we are already done.
@@ -368,7 +351,6 @@ void ipipe_migration_hook(struct task_struct *p) /* hw IRQs off */
 		xnthread_clear_info(thread, XNCONTHI);
 		ipipe_disable_user_intret_notifier();
 	}
-#endif
 
 	/* Unregister as debugged thread in case we postponed this. */
 	if (unlikely(xnthread_test_state(thread, XNSSTEP)))
@@ -681,7 +663,6 @@ static inline int handle_clockfreq_event(unsigned int *p)
 	return KEVENT_PROPAGATE;
 }
 
-#ifdef IPIPE_KEVT_USERINTRET
 static int handle_user_return(struct task_struct *task)
 {
 	struct xnthread *thread;
@@ -715,9 +696,7 @@ static int handle_user_return(struct task_struct *task)
 
 	return KEVENT_PROPAGATE;
 }
-#endif /* IPIPE_KEVT_USERINTRET */
 
-#ifdef IPIPE_KEVT_PTRESUME
 int handle_ptrace_resume(struct ipipe_ptrace_resume_data *resume)
 {
 	struct xnthread *thread;
@@ -739,7 +718,6 @@ int handle_ptrace_resume(struct ipipe_ptrace_resume_data *resume)
 
 	return KEVENT_PROPAGATE;
 }
-#endif /* IPIPE_KEVT_PTRESUME */
 
 int ipipe_kevent_hook(int kevent, void *data)
 {
@@ -766,21 +744,15 @@ int ipipe_kevent_hook(int kevent, void *data)
 		ret = handle_hostrt_event(data);
 		break;
 #endif
-#ifdef IPIPE_KEVT_CLOCKFREQ
 	case IPIPE_KEVT_CLOCKFREQ:
 		ret = handle_clockfreq_event(data);
 		break;
-#endif
-#ifdef IPIPE_KEVT_USERINTRET
 	case IPIPE_KEVT_USERINTRET:
 		ret = handle_user_return(data);
 		break;
-#endif
-#ifdef IPIPE_KEVT_PTRESUME
 	case IPIPE_KEVT_PTRESUME:
 		ret = handle_ptrace_resume(data);
 		break;
-#endif
 	default:
 		ret = KEVENT_PROPAGATE;
 	}
diff --git a/kernel/cobalt/ipipe/sched.c b/kernel/cobalt/ipipe/sched.c
index 411c5ec8c..3104e5015 100644
--- a/kernel/cobalt/ipipe/sched.c
+++ b/kernel/cobalt/ipipe/sched.c
@@ -158,7 +158,6 @@ int pipeline_leave_oob_prepare(void)
 
 	set_current_state(p->state & ~TASK_NOWAKEUP);
 
-#ifdef IPIPE_KEVT_USERINTRET
 	/*
 	 * If current is being debugged, record that it should migrate
 	 * back in case it resumes in userspace. If it resumes in
@@ -171,7 +170,6 @@ int pipeline_leave_oob_prepare(void)
 		ipipe_enable_user_intret_notifier();
 		suspmask |= XNDBGSTOP;
 	}
-#endif
 	/*
 	 * Return the suspension bits the caller should pass to
 	 * xnthread_suspend().
-- 
2.26.2


