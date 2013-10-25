From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Sat, 26 Oct 2013 00:03:52 +0200
Message-Id: <1382738632-14649-7-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1382738632-14649-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <526AEA7E.6030801@xenomai.org>
 <1382738632-14649-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH 7/7] cobalt/x86: lazy FPU switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Only enable XNFPU on first FPU use in kernel-space.
Skip context restore with fxsr when context allows it.
---
 kernel/cobalt/arch/x86/thread.c |   33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x86/thread.c
index 2cb5ff1..aa35eb6 100644
--- a/kernel/cobalt/arch/x86/thread.c
+++ b/kernel/cobalt/arch/x86/thread.c
@@ -225,7 +225,7 @@ int xnarch_handle_fpu_fault(struct xnthread *from,
 	struct xnarchtcb *tcb = xnthread_archtcb(to);
 	struct task_struct *p = tcb->core.host_task;
 
-	if (tsk_used_math(p))
+	if (wrap_test_fpu_used(p))
 		return 0;
 
 	/*
@@ -243,6 +243,7 @@ int xnarch_handle_fpu_fault(struct xnthread *from,
 
 	set_stopped_child_used_math(p);
 	wrap_set_fpu_used(p);
+	xnthread_set_state(to, XNFPU);
 
 	return 1;
 }
@@ -273,7 +274,7 @@ void xnarch_save_fpu(struct xnthread *thread)
 	struct task_struct *p = tcb->core.host_task;
 
 	if (wrap_test_fpu_used(p) == 0)
-		/* Common case: already saved by __switch_to */
+		/* Saved by last __switch_to */
 		return;
 	
 	/* Exceptional case: a migrating thread */
@@ -287,11 +288,28 @@ int xnarch_switch_fpu(struct xnthread *from, struct xnthread *thread)
 {
 	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	struct task_struct *p = tcb->core.host_task;
+	const unsigned root_kfpu = tcb->root_kfpu;
 
-	if (tcb->root_kfpu == 0 && 
-		(tsk_used_math(p) == 0 || xnthread_test_state(thread, XNROOT)))
+	if (root_kfpu == 0) {
 		/* Restore lazy mode */
-		return xnthread_test_state(thread, XNROOT);
+		if (tsk_used_math(p) == 0)
+			return 0;
+		if (xnthread_test_state(thread, XNROOT))
+			return 1;
+
+		/*
+		 * If we never switched fpu, and the cpu has fxsr, the
+		 * last context switch saved fpu but did not
+		 * reinitialize it, so we can simply reenable fpu
+		 */
+		if (cpu_has_fxsr &&
+			(from == thread || 
+				(from && from->tcb.fpup == thread->tcb.fpup))) {
+			clts();
+			wrap_set_fpu_used(p);
+			return thread != from;
+		}
+	}
 
 	/*
 	 * Restore the FPU hardware with valid fp registers from a
@@ -300,7 +318,7 @@ int xnarch_switch_fpu(struct xnthread *from, struct xnthread *thread)
 	clts();
 
 	__do_restore_i387(x86_fpustate_ptr(&p->thread));
-	if (tcb->root_kfpu) {
+	if (root_kfpu) {
 		x86_fpustate_ptr(&p->thread) = tcb->fpup;
 		wrap_clear_fpu_used(p);
 		if (tcb->root_used_math == 0)
@@ -337,9 +355,6 @@ void xnarch_init_shadow_tcb(struct xnthread *thread)
 #endif
 	tcb->fpup = x86_fpustate_ptr(&p->thread);
 	tcb->root_kfpu = 0;
-
-	if (xnthread_test_state(thread, XNUSER))
-		xnthread_set_state(thread, XNFPU);
 }
 
 int xnarch_escalate(void)
-- 
1.7.10.4


