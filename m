From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 15/15] cobalt/thread: drop xnthread_init_shadow_tcb and
 xnthread_init_root_tcb and xnthread_switch_fpu
Date: Mon,  9 Nov 2020 02:50:27 -0500
Message-Id: <20201109075027.14760-15-hongzhan.chen@intel.com>
In-Reply-To: <20201109075027.14760-1-hongzhan.chen@intel.com>
References: <20201109075027.14760-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan.kiszka@siemens.com, xenomai@xenomai.org

drop xnthread_init_shadow_tcb and xnthread_init_root_tcb and
xnthread_switch_fpu because dovetail alternate scheduling will
handle related context switch including fpu switch.

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 include/cobalt/kernel/thread.h |  8 -----
 kernel/cobalt/posix/process.c  |  1 -
 kernel/cobalt/sched.c          |  2 --
 kernel/cobalt/thread.c         | 55 ----------------------------------
 4 files changed, 66 deletions(-)

diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
index 3283400be..4e6d305ce 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -429,16 +429,8 @@ int xnthread_wait_complete_p(struct xnthread_wait_context *wc)
 	return wc->posted;
 }
 
-#ifdef CONFIG_XENO_ARCH_FPU
-void xnthread_switch_fpu(struct xnsched *sched);
-#else
-static inline void xnthread_switch_fpu(struct xnsched *sched) { }
-#endif /* CONFIG_XENO_ARCH_FPU */
-
 void xnthread_init_shadow_tcb(struct xnthread *thread);
 
-void xnthread_init_root_tcb(struct xnthread *thread);
-
 void xnthread_deregister(struct xnthread *thread);
 
 char *xnthread_format_status(unsigned long status,
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 366e5889e..97e3319d8 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -694,7 +694,6 @@ int cobalt_map_user(struct xnthread *thread, __u32 __user *u_winoff)
 	 * positive in debug code from handle_schedule_event() and
 	 * friends.
 	 */
-	xnthread_init_shadow_tcb(thread);
 	xnthread_suspend(thread, XNRELAX, XN_INFINITE, XN_RELATIVE, NULL);
 	init_uthread_info(thread);
 	xnthread_set_state(thread, XNMAPPED);
diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index f54c411a0..70679b035 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -214,7 +214,6 @@ static void xnsched_init(struct xnsched *sched, int cpu)
 	sched->fpuholder = &sched->rootcb;
 #endif /* CONFIG_XENO_ARCH_FPU */
 
-	xnthread_init_root_tcb(&sched->rootcb);
 	list_add_tail(&sched->rootcb.glink, &nkthreadq);
 	cobalt_nrthreads++;
 
@@ -1075,7 +1074,6 @@ reschedule:
 	 * because of relaxed/hardened transitions.
 	 */
 	curr = sched->curr;
-	xnthread_switch_fpu(sched);
 	xntrace_pid(task_pid_nr(current), xnthread_current_priority(curr));
 out:
 	if (switched &&
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index cb8c01f5d..87b5d0716 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -238,47 +238,6 @@ err_out:
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
-#warning TODO
-	//__ipipe_share_current(0);
-
-	tcb->core.host_task = p;
-	tcb->core.tsp = &p->thread;
-	tcb->core.mm = p->mm;
-	tcb->core.active_mm = p->mm;
-	tcb->core.tip = task_thread_info(p);
-#ifdef CONFIG_XENO_ARCH_FPU
-	tcb->core.user_fpu_owner = p;
-#endif /* CONFIG_XENO_ARCH_FPU */
-#warning TODO?
-	//xnarch_init_shadow_tcb(thread);
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
-#warning TODO?
-	//xnarch_init_root_tcb(thread);
-}
-
 void xnthread_deregister(struct xnthread *thread)
 {
 	if (thread->handle != XN_NO_HANDLE)
@@ -438,18 +397,6 @@ static inline void giveup_fpu(struct xnsched *sched,
 		sched->fpuholder = NULL;
 }
 
-void xnthread_switch_fpu(struct xnsched *sched)
-{
-	struct xnthread *curr = sched->curr;
-
-	if (!xnthread_test_state(curr, XNFPU))
-		return;
-
-#warning TODO: nothing to do? then general cleanup of FPU
-	//xnarch_switch_fpu(sched->fpuholder, curr);
-	sched->fpuholder = curr;
-}
-
 #else /* !CONFIG_XENO_ARCH_FPU */
 
 static inline void giveup_fpu(struct xnsched *sched,
@@ -1964,7 +1911,6 @@ int xnthread_harden(void)
 
 	/* "current" is now running into the Xenomai domain. */
 	sched = xnsched_finish_unlocked_switch(thread->sched);
-	xnthread_switch_fpu(sched);
 
 	xnlock_clear_irqon(&nklock);
 	xnsched_resched_after_unlocked_switch();
@@ -2531,7 +2477,6 @@ int xnthread_map(struct xnthread *thread)
 	xnthread_pin_initial(thread);
 	dovetail_init_altsched(&thread->altsched);
 
-	xnthread_init_shadow_tcb(thread);
 	xnthread_suspend(thread, XNRELAX, XN_INFINITE, XN_RELATIVE, NULL);
 	init_kthread_info(thread);
 	xnthread_set_state(thread, XNMAPPED);
-- 
2.17.1


