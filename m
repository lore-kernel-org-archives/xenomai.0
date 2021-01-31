From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 01/13] cobalt/kernel: pipeline: abstract context switching
 support
Date: Sun, 31 Jan 2021 15:45:28 +0100
Message-Id: <20210131144540.243363-1-rpm@xenomai.org>
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

Implement an abstract API for the low-level context switching code,
moving the legacy open coded support to the I-pipe specific section
(e.g. fpu management, register file switching, root context tracking).
Dovetail provides built-in support for all these nitty-gritty details,
which we may tap into for the same purpose instead.

The changes have been introduced in a way which properly maps to the
Dovetail interface, while remaining compatible with the interface to
the legacy code.

No functional change is introduced.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/ipipe/pipeline/sched.h |  38 ++++
 include/cobalt/kernel/sched.h                |   3 +-
 include/cobalt/kernel/thread.h               |   4 -
 kernel/cobalt/ipipe/Makefile                 |   2 +-
 kernel/cobalt/ipipe/sched.c                  | 178 +++++++++++++++++++
 kernel/cobalt/posix/process.c                |   3 +-
 kernel/cobalt/sched.c                        |  70 ++------
 kernel/cobalt/thread.c                       |  91 ++--------
 8 files changed, 248 insertions(+), 141 deletions(-)
 create mode 100644 include/cobalt/kernel/ipipe/pipeline/sched.h
 create mode 100644 kernel/cobalt/ipipe/sched.c

diff --git a/include/cobalt/kernel/ipipe/pipeline/sched.h b/include/cobalt/kernel/ipipe/pipeline/sched.h
new file mode 100644
index 000000000..692ee6228
--- /dev/null
+++ b/include/cobalt/kernel/ipipe/pipeline/sched.h
@@ -0,0 +1,38 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2020 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#ifndef _COBALT_KERNEL_IPIPE_SCHED_H
+#define _COBALT_KERNEL_IPIPE_SCHED_H
+
+struct xnthread;
+struct xnsched;
+struct task_struct;
+
+void pipeline_init_shadow_tcb(struct xnthread *thread);
+
+void pipeline_init_root_tcb(struct xnthread *thread);
+
+int pipeline_schedule(struct xnsched *sched);
+
+void pipeline_prep_switch_oob(struct xnthread *root);
+
+bool pipeline_switch_to(struct xnthread *prev,
+			struct xnthread *next,
+			bool leaving_inband);
+
+int pipeline_leave_inband(void);
+
+void pipeline_leave_oob_prepare(void);
+
+void pipeline_leave_oob_finish(void);
+
+void pipeline_finalize_thread(struct xnthread *thread);
+
+void pipeline_raise_mayday(struct task_struct *tsk);
+
+void pipeline_clear_mayday(void);
+
+#endif /* !_COBALT_KERNEL_IPIPE_SCHED_H */
diff --git a/include/cobalt/kernel/sched.h b/include/cobalt/kernel/sched.h
index ad815b595..c13f46ff7 100644
--- a/include/cobalt/kernel/sched.h
+++ b/include/cobalt/kernel/sched.h
@@ -30,6 +30,7 @@
 #include <cobalt/kernel/vfile.h>
 #include <cobalt/kernel/assert.h>
 #include <asm/xenomai/machine.h>
+#include <pipeline/sched.h>
 
 /**
  * @addtogroup cobalt_core_sched
@@ -300,7 +301,7 @@ static inline int __xnsched_run(struct xnsched *sched)
 	     (XNINIRQ|XNINSW|XNRESCHED)) != XNRESCHED)
 		return 0;
 
-	return ___xnsched_run(sched);
+	return pipeline_schedule(sched);
 }
 
 static inline int xnsched_run(void)
diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
index 2d57b8398..fe7390088 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -427,10 +427,6 @@ void xnthread_switch_fpu(struct xnsched *sched);
 static inline void xnthread_switch_fpu(struct xnsched *sched) { }
 #endif /* CONFIG_XENO_ARCH_FPU */
 
-void xnthread_init_shadow_tcb(struct xnthread *thread);
-
-void xnthread_init_root_tcb(struct xnthread *thread);
-
 void xnthread_deregister(struct xnthread *thread);
 
 char *xnthread_format_status(unsigned long status,
diff --git a/kernel/cobalt/ipipe/Makefile b/kernel/cobalt/ipipe/Makefile
index 1daa84440..eae6a4a7c 100644
--- a/kernel/cobalt/ipipe/Makefile
+++ b/kernel/cobalt/ipipe/Makefile
@@ -2,4 +2,4 @@ ccflags-y += -I$(srctree)/kernel
 
 obj-y +=	pipeline.o
 
-pipeline-y :=	init.o intr.o kevents.o tick.o syscall.o
+pipeline-y :=	init.o intr.o kevents.o tick.o syscall.o sched.o
diff --git a/kernel/cobalt/ipipe/sched.c b/kernel/cobalt/ipipe/sched.c
new file mode 100644
index 000000000..4850b229d
--- /dev/null
+++ b/kernel/cobalt/ipipe/sched.c
@@ -0,0 +1,178 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2001-2020 Philippe Gerum <rpm@xenomai.org>.
+ */
+
+#include <cobalt/kernel/thread.h>
+#include <cobalt/kernel/sched.h>
+#include <cobalt/kernel/assert.h>
+#include <pipeline/sched.h>
+#include <trace/events/cobalt-core.h>
+
+int pipeline_schedule(struct xnsched *sched)
+{
+	int ret = 0;
+
+	XENO_WARN_ON_ONCE(COBALT,
+		!hard_irqs_disabled() && is_secondary_domain());
+
+	if (!xnarch_escalate())
+		ret = ___xnsched_run(sched);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pipeline_schedule);
+
+void pipeline_prep_switch_oob(struct xnthread *root)
+{
+	struct xnarchtcb *rootcb = xnthread_archtcb(root);
+	struct task_struct *p = current;
+
+	ipipe_notify_root_preemption();
+	/* Remember the preempted Linux task pointer. */
+	rootcb->core.host_task = p;
+	rootcb->core.tsp = &p->thread;
+	rootcb->core.mm = rootcb->core.active_mm = ipipe_get_active_mm();
+	rootcb->core.tip = task_thread_info(p);
+	xnarch_leave_root(root);
+}
+
+#ifdef CONFIG_XENO_ARCH_FPU
+
+static void switch_fpu(void)
+{
+	struct xnsched *sched = xnsched_current();
+	struct xnthread *curr = sched->curr;
+
+	if (!xnthread_test_state(curr, XNFPU))
+		return;
+
+	xnarch_switch_fpu(sched->fpuholder, curr);
+	sched->fpuholder = curr;
+}
+
+void giveup_fpu(struct xnthread *thread)
+{
+	struct xnsched *sched = thread->sched;
+
+	if (thread == sched->fpuholder)
+		sched->fpuholder = NULL;
+}
+
+#else
+
+static inline void giveup_fpu(struct xnthread *thread)
+{ }
+
+#endif /* !CONFIG_XENO_ARCH_FPU */
+
+bool pipeline_switch_to(struct xnthread *prev, struct xnthread *next,
+			bool leaving_inband)
+{
+	xnarch_switch_to(prev, next);
+
+	/*
+	 * Test whether we transitioned from primary mode to secondary
+	 * over a shadow thread, caused by a call to xnthread_relax().
+	 * In such a case, we are running over the regular schedule()
+	 * tail code, so we have to tell the caller to skip the Cobalt
+	 * tail code.
+	 */
+	if (!leaving_inband && is_secondary_domain()) {
+		__ipipe_complete_domain_migration();
+		XENO_BUG_ON(COBALT, xnthread_current() == NULL);
+		/*
+		 * Interrupts must be disabled here (has to be done on
+		 * entry of the Linux [__]switch_to function), but it
+		 * is what callers expect, specifically the reschedule
+		 * of an IRQ handler that hit before we call
+		 * xnsched_run in xnthread_suspend() when relaxing a
+		 * thread.
+		 */
+		XENO_BUG_ON(COBALT, !hard_irqs_disabled());
+		return true;
+	}
+
+	switch_fpu();
+
+	return false;
+}
+
+void pipeline_init_shadow_tcb(struct xnthread *thread)
+{
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
+	struct task_struct *p = current;
+
+	/*
+	 * If the current task is a kthread, the pipeline will take
+	 * the necessary steps to make the FPU usable in such
+	 * context. The kernel already took care of this issue for
+	 * userland tasks (e.g. setting up a clean backup area).
+	 */
+	__ipipe_share_current(0);
+
+	tcb->core.host_task = p;
+	tcb->core.tsp = &p->thread;
+	tcb->core.mm = p->mm;
+	tcb->core.active_mm = p->mm;
+	tcb->core.tip = task_thread_info(p);
+#ifdef CONFIG_XENO_ARCH_FPU
+	tcb->core.user_fpu_owner = p;
+#endif /* CONFIG_XENO_ARCH_FPU */
+	xnarch_init_shadow_tcb(thread);
+
+	trace_cobalt_shadow_map(thread);
+}
+
+void pipeline_init_root_tcb(struct xnthread *thread)
+{
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
+	struct task_struct *p = current;
+
+	tcb->core.host_task = p;
+	tcb->core.tsp = &tcb->core.ts;
+	tcb->core.mm = p->mm;
+	tcb->core.tip = NULL;
+	xnarch_init_root_tcb(thread);
+}
+
+int pipeline_leave_inband(void)
+{
+	int ret;
+
+	ret = __ipipe_migrate_head();
+	if (ret)
+		return ret;
+
+	switch_fpu();
+
+	return 0;
+}
+
+void pipeline_leave_oob_prepare(void)
+{
+	struct task_struct *p = current;
+
+	set_current_state(p->state & ~TASK_NOWAKEUP);
+}
+
+void pipeline_leave_oob_finish(void)
+{
+	__ipipe_reenter_root();
+}
+
+void pipeline_finalize_thread(struct xnthread *thread)
+{
+	giveup_fpu(thread);
+}
+
+void pipeline_raise_mayday(struct task_struct *tsk)
+{
+	ipipe_raise_mayday(tsk);
+}
+
+void pipeline_clear_mayday(void) /* May solely affect current. */
+{
+	ipipe_clear_thread_flag(TIP_MAYDAY);
+}
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 5926eb49e..945a52a35 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -47,6 +47,7 @@
 #include <cobalt/kernel/thread.h>
 #include <cobalt/uapi/signal.h>
 #include <cobalt/uapi/syscall.h>
+#include <pipeline/sched.h>
 #include <trace/events/cobalt-core.h>
 #include <rtdm/driver.h>
 #include <asm/xenomai/features.h>
@@ -624,7 +625,7 @@ int cobalt_map_user(struct xnthread *thread, __u32 __user *u_winoff)
 	 * positive in debug code from handle_schedule_event() and
 	 * friends.
 	 */
-	xnthread_init_shadow_tcb(thread);
+	pipeline_init_shadow_tcb(thread);
 	xnthread_suspend(thread, XNRELAX, XN_INFINITE, XN_RELATIVE, NULL);
 	pipeline_attach_current(thread);
 	xnthread_set_state(thread, XNMAPPED);
diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index a44109e78..8a5621642 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -27,6 +27,7 @@
 #include <cobalt/kernel/heap.h>
 #include <cobalt/kernel/arith.h>
 #include <cobalt/uapi/signal.h>
+#include <pipeline/sched.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/cobalt-core.h>
 
@@ -212,7 +213,7 @@ static void xnsched_init(struct xnsched *sched, int cpu)
 	sched->fpuholder = &sched->rootcb;
 #endif /* CONFIG_XENO_ARCH_FPU */
 
-	xnthread_init_root_tcb(&sched->rootcb);
+	pipeline_init_root_tcb(&sched->rootcb);
 	list_add_tail(&sched->rootcb.glink, &nkthreadq);
 	cobalt_nrthreads++;
 
@@ -875,16 +876,7 @@ static inline void enter_root(struct xnthread *root)
 
 static inline void leave_root(struct xnthread *root)
 {
-	struct xnarchtcb *rootcb = xnthread_archtcb(root);
-	struct task_struct *p = current;
-
-	ipipe_notify_root_preemption();
-	/* Remember the preempted Linux task pointer. */
-	rootcb->core.host_task = p;
-	rootcb->core.tsp = &p->thread;
-	rootcb->core.mm = rootcb->core.active_mm = ipipe_get_active_mm();
-	rootcb->core.tip = task_thread_info(p);
-	xnarch_leave_root(root);
+	pipeline_prep_switch_oob(root);
 
 #ifdef CONFIG_XENO_OPT_WATCHDOG
 	xntimer_start(&root->sched->wdtimer, get_watchdog_timeout(),
@@ -905,15 +897,11 @@ static inline void do_lazy_user_work(struct xnthread *curr)
 
 int ___xnsched_run(struct xnsched *sched)
 {
+	bool switched = false, leaving_inband;
 	struct xnthread *prev, *next, *curr;
-	int switched, shadow;
 	spl_t s;
 
-	XENO_WARN_ON_ONCE(COBALT,
-			  !hard_irqs_disabled() && is_secondary_domain());
-
-	if (xnarch_escalate())
-		return 0;
+	XENO_WARN_ON_ONCE(COBALT, is_secondary_domain());
 
 	trace_cobalt_schedule(sched);
 
@@ -931,7 +919,6 @@ int ___xnsched_run(struct xnsched *sched)
 	if (xnthread_test_state(curr, XNUSER))
 		do_lazy_user_work(curr);
 
-	switched = 0;
 	if (!test_resched(sched))
 		goto out;
 
@@ -958,11 +945,11 @@ int ___xnsched_run(struct xnsched *sched)
 	 * store tearing.
 	 */
 	WRITE_ONCE(sched->curr, next);
-	shadow = 1;
+	leaving_inband = false;
 
 	if (xnthread_test_state(prev, XNROOT)) {
 		leave_root(prev);
-		shadow = 0;
+		leaving_inband = true;
 	} else if (xnthread_test_state(next, XNROOT)) {
 		if (sched->lflags & XNHTICK)
 			xnintr_host_tick(sched);
@@ -973,46 +960,23 @@ int ___xnsched_run(struct xnsched *sched)
 
 	xnstat_exectime_switch(sched, &next->stat.account);
 	xnstat_counter_inc(&next->stat.csw);
-	xnarch_switch_to(prev, next);
 
-	/*
-	 * Test whether we transitioned from primary mode to secondary
-	 * over a shadow thread, caused by a call to xnthread_relax().
-	 * In such a case, we are running over the regular schedule()
-	 * tail code, so we have to skip our tail code.
-	 */
-	if (shadow && is_secondary_domain())
-		goto shadow_epilogue;
+	if (pipeline_switch_to(prev, next, leaving_inband))
+		/* oob -> in-band transition detected. */
+		return true;
 
-	switched = 1;
-	sched = xnsched_current();
 	/*
-	 * Re-read the currently running thread, this is needed
-	 * because of relaxed/hardened transitions.
+	 * Re-read sched->curr for tracing: the current thread may
+	 * have switched from in-band to oob context.
 	 */
-	curr = sched->curr;
-	xnthread_switch_fpu(sched);
-	xntrace_pid(task_pid_nr(current), xnthread_current_priority(curr));
+	xntrace_pid(task_pid_nr(current),
+		xnthread_current_priority(xnsched_current()->curr));
+
+	switched = true;
 out:
 	xnlock_put_irqrestore(&nklock, s);
 
-	return switched;
-
-shadow_epilogue:
-	__ipipe_complete_domain_migration();
-
-	XENO_BUG_ON(COBALT, xnthread_current() == NULL);
-
-	/*
-	 * Interrupts must be disabled here (has to be done on entry
-	 * of the Linux [__]switch_to function), but it is what
-	 * callers expect, specifically the reschedule of an IRQ
-	 * handler that hit before we call xnsched_run in
-	 * xnthread_suspend() when relaxing a thread.
-	 */
-	XENO_BUG_ON(COBALT, !hard_irqs_disabled());
-
-	return 1;
+	return !!switched;
 }
 EXPORT_SYMBOL_GPL(___xnsched_run);
 
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index a02c09db4..a2eae7ffc 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -40,6 +40,7 @@
 #include <cobalt/kernel/thread.h>
 #include <pipeline/kevents.h>
 #include <pipeline/inband_work.h>
+#include <pipeline/sched.h>
 #include <trace/events/cobalt-core.h>
 #include "debug.h"
 
@@ -236,44 +237,6 @@ err_out:
 	return ret;
 }
 
-void xnthread_init_shadow_tcb(struct xnthread *thread)
-{
-	struct xnarchtcb *tcb = xnthread_archtcb(thread);
-	struct task_struct *p = current;
-
-	/*
-	 * If the current task is a kthread, the pipeline will take
-	 * the necessary steps to make the FPU usable in such
-	 * context. The kernel already took care of this issue for
-	 * userland tasks (e.g. setting up a clean backup area).
-	 */
-	__ipipe_share_current(0);
-
-	tcb->core.host_task = p;
-	tcb->core.tsp = &p->thread;
-	tcb->core.mm = p->mm;
-	tcb->core.active_mm = p->mm;
-	tcb->core.tip = task_thread_info(p);
-#ifdef CONFIG_XENO_ARCH_FPU
-	tcb->core.user_fpu_owner = p;
-#endif /* CONFIG_XENO_ARCH_FPU */
-	xnarch_init_shadow_tcb(thread);
-
-	trace_cobalt_shadow_map(thread);
-}
-
-void xnthread_init_root_tcb(struct xnthread *thread)
-{
-	struct xnarchtcb *tcb = xnthread_archtcb(thread);
-	struct task_struct *p = current;
-
-	tcb->core.host_task = p;
-	tcb->core.tsp = &tcb->core.ts;
-	tcb->core.mm = p->mm;
-	tcb->core.tip = NULL;
-	xnarch_init_root_tcb(thread);
-}
-
 void xnthread_deregister(struct xnthread *thread)
 {
 	if (thread->handle != XN_NO_HANDLE)
@@ -408,35 +371,6 @@ void xnthread_prepare_wait(struct xnthread_wait_context *wc)
 }
 EXPORT_SYMBOL_GPL(xnthread_prepare_wait);
 
-#ifdef CONFIG_XENO_ARCH_FPU
-
-static inline void giveup_fpu(struct xnsched *sched,
-			      struct xnthread *thread)
-{
-	if (thread == sched->fpuholder)
-		sched->fpuholder = NULL;
-}
-
-void xnthread_switch_fpu(struct xnsched *sched)
-{
-	struct xnthread *curr = sched->curr;
-
-	if (!xnthread_test_state(curr, XNFPU))
-		return;
-
-	xnarch_switch_fpu(sched->fpuholder, curr);
-	sched->fpuholder = curr;
-}
-
-#else /* !CONFIG_XENO_ARCH_FPU */
-
-static inline void giveup_fpu(struct xnsched *sched,
-				      struct xnthread *thread)
-{
-}
-
-#endif /* !CONFIG_XENO_ARCH_FPU */
-
 static inline void release_all_ownerships(struct xnthread *curr)
 {
 	struct xnsynch *synch, *tmp;
@@ -455,8 +389,6 @@ static inline void release_all_ownerships(struct xnthread *curr)
 
 static inline void cleanup_tcb(struct xnthread *curr) /* nklock held, irqs off */
 {
-	struct xnsched *sched = curr->sched;
-
 	list_del(&curr->glink);
 	cobalt_nrthreads--;
 	xnvfile_touch_tag(&nkthreadlist_tag);
@@ -479,7 +411,7 @@ static inline void cleanup_tcb(struct xnthread *curr) /* nklock held, irqs off *
 	 */
 	release_all_ownerships(curr);
 
-	giveup_fpu(sched, curr);
+	pipeline_finalize_thread(curr);
 	xnsched_forget(curr);
 	xnthread_deregister(curr);
 }
@@ -1912,7 +1844,6 @@ int xnthread_harden(void)
 {
 	struct task_struct *p = current;
 	struct xnthread *thread;
-	struct xnsched *sched;
 	int ret;
 
 	secondary_mode_only();
@@ -1928,16 +1859,14 @@ int xnthread_harden(void)
 
 	xnthread_clear_sync_window(thread, XNRELAX);
 
-	ret = __ipipe_migrate_head();
+	ret = pipeline_leave_inband();
 	if (ret) {
 		xnthread_test_cancel();
 		xnthread_set_sync_window(thread, XNRELAX);
 		return ret;
 	}
 
-	/* "current" is now running into the Xenomai domain. */
-	sched = xnsched_current();
-	xnthread_switch_fpu(sched);
+	/* "current" is now running on the out-of-band stage. */
 
 	xnlock_clear_irqon(&nklock);
 	xnthread_test_cancel();
@@ -2097,8 +2026,8 @@ void xnthread_relax(int notify, int reason)
 		suspension |= XNDBGSTOP;
 	}
 #endif
-	set_current_state(p->state & ~TASK_NOWAKEUP);
 	xnthread_run_handler_stack(thread, relax_thread);
+	pipeline_leave_oob_prepare();
 	xnthread_suspend(thread, suspension, XN_INFINITE, XN_RELATIVE, NULL);
 	splnone();
 
@@ -2110,7 +2039,7 @@ void xnthread_relax(int notify, int reason)
 		  "xnthread_relax() failed for thread %s[%d]",
 		  thread->name, xnthread_host_pid(thread));
 
-	__ipipe_reenter_root();
+	pipeline_leave_oob_finish();
 
 	/* Account for secondary mode switch. */
 	xnstat_counter_inc(&thread->stat.ssw);
@@ -2162,7 +2091,7 @@ void xnthread_relax(int notify, int reason)
 	 */
 	xnthread_clear_localinfo(thread, XNSYSRST);
 
-	ipipe_clear_thread_flag(TIP_MAYDAY);
+	pipeline_clear_mayday();
 
 	trace_cobalt_shadow_relaxed(thread);
 }
@@ -2320,7 +2249,7 @@ void __xnthread_kick(struct xnthread *thread) /* nklock locked, irqs off */
 	 */
 	if (thread != xnsched_current_thread() &&
 	    xnthread_test_state(thread, XNUSER))
-		ipipe_raise_mayday(p);
+		pipeline_raise_mayday(p);
 }
 
 void xnthread_kick(struct xnthread *thread)
@@ -2510,7 +2439,7 @@ int xnthread_map(struct xnthread *thread, struct completion *done)
 	thread->u_window = NULL;
 	xnthread_pin_initial(thread);
 
-	xnthread_init_shadow_tcb(thread);
+	pipeline_init_shadow_tcb(thread);
 	xnthread_suspend(thread, XNRELAX, XN_INFINITE, XN_RELATIVE, NULL);
 	init_kthread_info(thread);
 	xnthread_set_state(thread, XNMAPPED);
@@ -2568,7 +2497,7 @@ void xnthread_call_mayday(struct xnthread *thread, int reason)
 	XENO_BUG_ON(COBALT, !xnthread_test_state(thread, XNUSER));
 	xnthread_set_info(thread, XNKICKED);
 	xnthread_signal(thread, SIGDEBUG, reason);
-	ipipe_raise_mayday(p);
+	pipeline_raise_mayday(p);
 }
 EXPORT_SYMBOL_GPL(xnthread_call_mayday);
 
-- 
2.26.2


