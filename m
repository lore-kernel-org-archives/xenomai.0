From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Sat, 26 Oct 2013 00:03:51 +0200
Message-Id: <1382738632-14649-6-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1382738632-14649-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <526AEA7E.6030801@xenomai.org>
 <1382738632-14649-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH 6/7] cobalt/fpu: change fpu handling interface
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

For different reasons on x86 and ARM, implementing FPU switching in terms
of xnarch_enable_fpu/xnarch_save_fpu/xnarch_restore_fpu no longer really
makes sense. So, keep xnarch_save_fpu for migration, but replace
xnarch_enable_fpu and xnarch_restore_fpu with xnarch_switch_fpu(from, to).

A default implementation for xnarch_switch_fpu is provided which switches
fpu in terms of xnarch_save_fpu/xnarch_restore_fpu/xnarch_enable_fpu on
architectures where it still makes sense.
---
 .../cobalt/arch/arm/include/asm/xenomai/thread.h   |    4 +---
 kernel/cobalt/arch/arm/thread.c                    |   16 ++++++++++++++++
 .../arch/blackfin/include/asm/xenomai/thread.h     |    7 +++++--
 .../cobalt/arch/nios2/include/asm/xenomai/thread.h |    7 +++++--
 .../arch/powerpc/include/asm/xenomai/thread.h      |    4 +---
 kernel/cobalt/arch/powerpc/thread.c                |   20 ++++++++++++++++++--
 kernel/cobalt/arch/sh/thread.c                     |   20 ++++++++++++++++++--
 .../cobalt/arch/x86/include/asm/xenomai/thread.h   |   10 ++++++----
 kernel/cobalt/arch/x86/thread.c                    |    9 +++------
 kernel/cobalt/thread.c                             |   14 +-------------
 10 files changed, 74 insertions(+), 37 deletions(-)

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h b/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
index 8c42775..e780212 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
@@ -79,11 +79,9 @@ struct xnarchtcb {
 
 #define xnarch_fault_notify(d) (!xnarch_fault_bp_p(d))
 
-void xnarch_enable_fpu(struct xnthread *current_thread);
-
 void xnarch_save_fpu(struct xnthread *thread);
 
-void xnarch_restore_fpu(struct xnthread *thread);
+int xnarch_switch_fpu(struct xnthread *from, struct xnthread *thread);
 
 void xnarch_switch_to(struct xnthread *out, struct xnthread *in);
 
diff --git a/kernel/cobalt/arch/arm/thread.c b/kernel/cobalt/arch/arm/thread.c
index 5f0d792..5775d2c 100644
--- a/kernel/cobalt/arch/arm/thread.c
+++ b/kernel/cobalt/arch/arm/thread.c
@@ -393,6 +393,22 @@ void xnarch_restore_fpu(struct xnthread *thread)
 #endif /* CONFIG_XENO_HW_FPU */
 }
 
+int xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
+{
+	if (from == to || 
+		xnarch_fpu_ptr(xnthread_archtcb(from)) == 
+		xnarch_fpu_ptr(xnthread_archtcb(to))) {
+		xnarch_enable_fpu(to);
+		return 1;
+	}
+	
+	if (from)
+		xnarch_save_fpu(from);
+	
+	xnarch_restore_fpu(to);
+	return 1;
+}
+
 int xnarch_escalate(void)
 {
 	if (ipipe_root_p) {
diff --git a/kernel/cobalt/arch/blackfin/include/asm/xenomai/thread.h b/kernel/cobalt/arch/blackfin/include/asm/xenomai/thread.h
index 6c630e7..b4c5637 100644
--- a/kernel/cobalt/arch/blackfin/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/blackfin/include/asm/xenomai/thread.h
@@ -58,9 +58,12 @@ static inline void xnarch_init_root_tcb(struct xnthread *thread) { }
 static inline void xnarch_init_shadow_tcb(struct xnthread *thread) { }
 static inline void xnarch_enter_root(struct xnthread *root) { }
 static inline void xnarch_leave_root(struct xnthread *root) { }
-static inline void xnarch_enable_fpu(struct xnthread *current_thread) { }
 static inline void xnarch_save_fpu(struct xnthread *thread) { }
-static inline void xnarch_restore_fpu(struct xnthread *thread) { }
+static inline int
+xnarch_switch_fpu(struct xnthread *from, struct xnthread *thread)
+{ 
+	return 0;
+}
 
 static inline int 
 xnarch_handle_fpu_fault(struct xnthread *from, 
diff --git a/kernel/cobalt/arch/nios2/include/asm/xenomai/thread.h b/kernel/cobalt/arch/nios2/include/asm/xenomai/thread.h
index 05de3c2..0544ff7 100644
--- a/kernel/cobalt/arch/nios2/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/nios2/include/asm/xenomai/thread.h
@@ -53,9 +53,12 @@ static inline void xnarch_init_root_tcb(struct xnthread *thread) { }
 static inline void xnarch_init_shadow_tcb(struct xnthread *thread) { }
 static inline void xnarch_enter_root(struct xnthread *root) { }
 static inline void xnarch_leave_root(struct xnthread *thread) { }
-static inline void xnarch_enable_fpu(struct xnthread *thread) { }
 static inline void xnarch_save_fpu(struct xnthread *thread) { }
-static inline void xnarch_restore_fpu(struct xnthread *thread) { }
+static inline int
+xnarch_switch_fpu(struct xnthread *from, struct xnthread *to) 
+{ 
+	return 0;
+}
 
 static inline int 
 xnarch_handle_fpu_fault(struct xnthread *from, 
diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/thread.h b/kernel/cobalt/arch/powerpc/include/asm/xenomai/thread.h
index 7504fba..1ee1a79 100644
--- a/kernel/cobalt/arch/powerpc/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/powerpc/include/asm/xenomai/thread.h
@@ -88,10 +88,8 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in);
 
 int xnarch_escalate(void);
 
-void xnarch_enable_fpu(struct xnthread *current_thread);
-
 void xnarch_save_fpu(struct xnthread *thread);
 
-void xnarch_restore_fpu(struct xnthread *thread);
+int xnarch_switch_fpu(struct xnthread *from, struct xnthread *thread);
 
 #endif /* !_COBALT_POWERPC_ASM_THREAD_H */
diff --git a/kernel/cobalt/arch/powerpc/thread.c b/kernel/cobalt/arch/powerpc/thread.c
index 70aad0e..fd5fd7a 100644
--- a/kernel/cobalt/arch/powerpc/thread.c
+++ b/kernel/cobalt/arch/powerpc/thread.c
@@ -115,7 +115,7 @@ asmlinkage void __asm_restore_fpu(struct thread_struct *ts);
 })
 #endif /* CONFIG_PPC64 */
 
-void xnarch_enable_fpu(struct xnthread *thread)
+static void xnarch_enable_fpu(struct xnthread *thread)
 {
 	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	struct task_struct *task = tcb->core.host_task;
@@ -139,7 +139,7 @@ void xnarch_save_fpu(struct xnthread *thread)
 	}
 }
 
-void xnarch_restore_fpu(struct xnthread *thread)
+static void xnarch_restore_fpu(struct xnthread *thread)
 {
 	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	struct thread_struct *ts;
@@ -168,6 +168,22 @@ void xnarch_restore_fpu(struct xnthread *thread)
 		do_disable_fpu();
 }
 
+int xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
+{
+	if (from == to || 
+		xnarch_fpu_ptr(xnthread_archtcb(from)) == 
+		xnarch_fpu_ptr(xnthread_archtcb(to))) {
+		xnarch_enable_fpu(to);
+		return 1;
+	}
+	
+	if (from)
+		xnarch_save_fpu(from);
+	
+	xnarch_restore_fpu(to);
+	return 1;
+}
+
 void xnarch_leave_root(struct xnthread *root)
 {
 	struct xnarchtcb *rootcb = xnthread_archtcb(root);
diff --git a/kernel/cobalt/arch/sh/thread.c b/kernel/cobalt/arch/sh/thread.c
index 4b2361e..10a78a0 100644
--- a/kernel/cobalt/arch/sh/thread.c
+++ b/kernel/cobalt/arch/sh/thread.c
@@ -227,7 +227,7 @@ static inline void do_restore_fpu(struct thread_struct *ts)
 		      :"memory");
 }
 
-inline void xnarch_enable_fpu(struct xnthread *thread)
+static inline void xnarch_enable_fpu(struct xnthread *thread)
 {
 	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	struct task_struct *task = tcb->core.host_task;
@@ -252,7 +252,7 @@ void xnarch_save_fpu(struct xnthread *thread)
 	}
 }
 
-void xnarch_restore_fpu(struct xnthread *thread)
+static void xnarch_restore_fpu(struct xnthread *thread)
 {
 	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	struct pt_regs *regs;
@@ -273,6 +273,22 @@ void xnarch_restore_fpu(struct xnthread *thread)
 		disable_fpu();
 }
 
+int xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
+{
+	if (from == to || 
+		xnarch_fpu_ptr(xnthread_archtcb(from)) == 
+		xnarch_fpu_ptr(xnthread_archtcb(to))) {
+		xnarch_enable_fpu(to);
+		return 1;
+	}
+	
+	if (from)
+		xnarch_save_fpu(from);
+	
+	xnarch_restore_fpu(to);
+	return 1;
+}
+
 void xnarch_leave_root(struct xnthread *root)
 {
 	struct xnarchtcb *rootcb = xnthread_archtcb(root);
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
index 938b25d..e95774a 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
@@ -67,16 +67,18 @@ static inline int xnarch_shadow_p(struct xnarchtcb *tcb, struct task_struct *tas
 #ifdef CONFIG_XENO_HW_FPU
 
 void xnarch_save_fpu(struct xnthread *thread);
-void xnarch_restore_fpu(struct xnthread *thread);
-void xnarch_enable_fpu(struct xnthread *thread);
+int xnarch_switch_fpu(struct xnthread *from, struct xnthread *to);
 int xnarch_handle_fpu_fault(struct xnthread *from, 
 			struct xnthread *to, struct ipipe_trap_data *d);
 
 #else /* !CONFIG_XENO_HW_FPU */
 
 static inline void xnarch_save_fpu(struct xnthread *thread) { }
-static inline void xnarch_restore_fpu(struct xnthread *thread) { }
-static inline void xnarch_enable_fpu(struct xnthread *thread) { }
+static inline int 
+xnarch_switch_fpu(struct xnthread *from, struct xnthread *thread) 
+{ 
+	return 0;
+}
 
 static inline int
 xnarch_handle_fpu_fault(struct xnthread *from, 
diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x86/thread.c
index cbf3627..2cb5ff1 100644
--- a/kernel/cobalt/arch/x86/thread.c
+++ b/kernel/cobalt/arch/x86/thread.c
@@ -283,7 +283,7 @@ void xnarch_save_fpu(struct xnthread *thread)
 	wrap_clear_fpu_used(p);
 }
 
-void xnarch_restore_fpu(struct xnthread *thread)
+int xnarch_switch_fpu(struct xnthread *from, struct xnthread *thread)
 {
 	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	struct task_struct *p = tcb->core.host_task;
@@ -291,7 +291,7 @@ void xnarch_restore_fpu(struct xnthread *thread)
 	if (tcb->root_kfpu == 0 && 
 		(tsk_used_math(p) == 0 || xnthread_test_state(thread, XNROOT)))
 		/* Restore lazy mode */
-		return;
+		return xnthread_test_state(thread, XNROOT);
 
 	/*
 	 * Restore the FPU hardware with valid fp registers from a
@@ -307,11 +307,8 @@ void xnarch_restore_fpu(struct xnthread *thread)
 			clear_stopped_child_used_math(p);
 	} else
 		wrap_set_fpu_used(p);
-}
 
-void xnarch_enable_fpu(struct xnthread *thread)
-{
-	xnarch_restore_fpu(thread);
+	return 1;
 }
 
 #endif /* CONFIG_XENO_HW_FPU */
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 09d61e2..0c59839 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -391,20 +391,8 @@ void xnthread_switch_fpu(struct xnsched *sched)
 	if (!xnthread_test_state(curr, XNFPU))
 		return;
 
-	if (sched->fpuholder != curr) {
-		if (sched->fpuholder == NULL ||
-		    xnarch_fpu_ptr(xnthread_archtcb(sched->fpuholder)) !=
-		    xnarch_fpu_ptr(xnthread_archtcb(curr))) {
-			if (sched->fpuholder)
-				xnarch_save_fpu(sched->fpuholder);
-
-			xnarch_restore_fpu(curr);
-		} else
-			xnarch_enable_fpu(curr);
-
+	if (xnarch_switch_fpu(sched->fpuholder, curr))
 		sched->fpuholder = curr;
-	} else
-		xnarch_enable_fpu(curr);
 }
 
 #else /* !CONFIG_XENO_HW_FPU */
-- 
1.7.10.4


