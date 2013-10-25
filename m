From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Sat, 26 Oct 2013 00:03:47 +0200
Message-Id: <1382738632-14649-2-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1382738632-14649-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <526AEA7E.6030801@xenomai.org>
 <1382738632-14649-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH 2/7] cobalt/fpu: pass xnthread structures to
	arch/*/thread.c
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

in order to prepare for next changes
---
 include/cobalt/kernel/thread.h                     |    6 ++++-
 .../cobalt/arch/arm/include/asm/xenomai/thread.h   |   26 +++++++++++---------
 kernel/cobalt/arch/arm/mayday.c                    |    2 +-
 kernel/cobalt/arch/arm/thread.c                    |   15 +++++++----
 .../arch/blackfin/include/asm/xenomai/thread.h     |   18 +++++++-------
 kernel/cobalt/arch/blackfin/mayday.c               |    2 +-
 kernel/cobalt/arch/blackfin/thread.c               |    3 ++-
 .../cobalt/arch/nios2/include/asm/xenomai/thread.h |   18 +++++++-------
 kernel/cobalt/arch/nios2/mayday.c                  |    2 +-
 kernel/cobalt/arch/nios2/thread.c                  |    3 ++-
 .../arch/powerpc/include/asm/xenomai/thread.h      |   24 +++++++++---------
 kernel/cobalt/arch/powerpc/mayday.c                |    2 +-
 kernel/cobalt/arch/powerpc/thread.c                |   17 ++++++++-----
 kernel/cobalt/arch/sh/include/asm/xenomai/thread.h |   18 ++++++++------
 kernel/cobalt/arch/sh/mayday.c                     |    2 +-
 kernel/cobalt/arch/sh/thread.c                     |   15 +++++++----
 .../cobalt/arch/x86/include/asm/xenomai/thread.h   |   26 ++++++++++----------
 kernel/cobalt/arch/x86/mayday.c                    |    2 +-
 kernel/cobalt/arch/x86/thread.c                    |   25 ++++++++++++-------
 kernel/cobalt/include/asm-generic/xenomai/thread.h |    5 ++++
 kernel/cobalt/sched.c                              |    6 ++---
 kernel/cobalt/shadow.c                             |    6 ++---
 kernel/cobalt/thread.c                             |   16 ++++++------
 23 files changed, 146 insertions(+), 113 deletions(-)

diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
index 4539c15..aa2fd46 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -208,6 +208,11 @@ static inline void xnthread_clear_info(struct xnthread *thread, int bits)
 	thread->info &= ~bits;
 }
 
+static inline struct xnarchtcb *xnthread_archtcb(struct xnthread *thread)
+{
+	return &thread->tcb;
+}
+
 #define xnthread_lock_count(thread)        ((thread)->schedlck)
 #define xnthread_init_schedparam(thread)   ((thread)->init_schedparam)
 #define xnthread_base_priority(thread)     ((thread)->bprio)
@@ -216,7 +221,6 @@ static inline void xnthread_clear_info(struct xnthread *thread, int bits)
 #define xnthread_base_class(thread)        ((thread)->base_class)
 #define xnthread_sched_class(thread)       ((thread)->sched_class)
 #define xnthread_time_slice(thread)        ((thread)->rrperiod)
-#define xnthread_archtcb(thread)           (&((thread)->tcb))
 #define xnthread_timeout(thread)           xntimer_get_timeout(&(thread)->rtimer)
 #define xnthread_handle(thread)            ((thread)->registry.handle)
 #define xnthread_host_task(thread)         (xnthread_archtcb(thread)->core.host_task)
diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h b/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
index d12a050..fc79fc8 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
@@ -81,28 +81,30 @@ struct xnarchtcb {
 
 #define xnarch_fault_notify(d) (!xnarch_fault_bp_p(d))
 
-void xnarch_enable_fpu(struct xnarchtcb *current_tcb);
+void xnarch_enable_fpu(struct xnthread *current_thread);
 
-void xnarch_save_fpu(struct xnarchtcb *tcb);
+void xnarch_save_fpu(struct xnthread *thread);
 
-void xnarch_restore_fpu(struct xnarchtcb *tcb);
+void xnarch_restore_fpu(struct xnthread *thread);
 
-void xnarch_switch_to(struct xnarchtcb *out_tcb, struct xnarchtcb *in_tcb);
+void xnarch_switch_to(struct xnthread *out, struct xnthread *in);
 
-static inline void xnarch_enter_root(struct xnarchtcb *rootcb) { }
+static inline void xnarch_enter_root(struct xnthread *root) { }
 
 int xnarch_escalate(void);
 
 #ifdef CONFIG_XENO_HW_FPU
 
-static inline void xnarch_init_root_tcb(struct xnarchtcb *tcb)
+static inline void xnarch_init_root_tcb(struct xnthread *thread)
 {
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	tcb->is_root = 1;
 	tcb->fpup = NULL;
 }
 
-static inline void xnarch_init_shadow_tcb(struct xnarchtcb *tcb)
+static inline void xnarch_init_shadow_tcb(struct xnthread *thread)
 {
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	tcb->is_root = 0;
 	tcb->fpup = (struct arm_fpustate *)
 		&task_thread_info(tcb->core.host_task)->used_cp[0];
@@ -110,12 +112,12 @@ static inline void xnarch_init_shadow_tcb(struct xnarchtcb *tcb)
 
 int xnarch_fault_fpu_p(struct ipipe_trap_data *d);
 
-void xnarch_leave_root(struct xnarchtcb *rootcb);
+void xnarch_leave_root(struct xnthread *root);
 
 #else /* !CONFIG_XENO_HW_FPU */
 
-static inline void xnarch_init_root_tcb(struct xnarchtcb *tcb) { }
-static inline void xnarch_init_shadow_tcb(struct xnarchtcb *tcb) { }
+static inline void xnarch_init_root_tcb(struct xnthread *thread) { }
+static inline void xnarch_init_shadow_tcb(struct xnthread *thread) { }
 
 /*
  * Userland may raise FPU faults with FPU-enabled kernels, regardless
@@ -127,11 +129,11 @@ static inline int xnarch_fault_fpu_p(struct ipipe_trap_data *d)
 	return 0;
 }
 
-static inline void xnarch_leave_root(struct xnarchtcb *rootcb) { }
+static inline void xnarch_leave_root(struct xnthread *root) { }
 
 #endif /* !CONFIG_XENO_HW_FPU */
 
-static inline int xnarch_handle_fpu_fault(struct xnarchtcb *tcb)
+static inline int xnarch_handle_fpu_fault(struct xnthread *thread)
 {
 	return 0;
 }
diff --git a/kernel/cobalt/arch/arm/mayday.c b/kernel/cobalt/arch/arm/mayday.c
index 2532fd2..142d69e 100644
--- a/kernel/cobalt/arch/arm/mayday.c
+++ b/kernel/cobalt/arch/arm/mayday.c
@@ -18,10 +18,10 @@
  */
 #include <linux/types.h>
 #include <linux/ipipe.h>
+#include <cobalt/kernel/thread.h>
 #include <asm/cacheflush.h>
 #include <asm/ptrace.h>
 #include <asm/xenomai/syscall.h>
-#include <asm/xenomai/thread.h>
 
 void xnarch_setup_mayday_page(void *page)
 {
diff --git a/kernel/cobalt/arch/arm/thread.c b/kernel/cobalt/arch/arm/thread.c
index a73eded..d77e59a 100644
--- a/kernel/cobalt/arch/arm/thread.c
+++ b/kernel/cobalt/arch/arm/thread.c
@@ -235,8 +235,9 @@ int xnarch_fault_fpu_p(struct ipipe_trap_data *d)
 	return exc != IPIPE_TRAP_UNDEFINSTR;
 }
 
-void xnarch_leave_root(struct xnarchtcb *rootcb)
+void xnarch_leave_root(struct xnthread *root)
 {
+	struct xnarchtcb *rootcb = xnthread_archtcb(root);
 #ifdef CONFIG_VFP
 	rootcb->fpup = get_fpu_owner();
 #else /* !CONFIG_VFP */
@@ -249,8 +250,9 @@ void xnarch_leave_root(struct xnarchtcb *rootcb)
 
 #endif /* CONFIG_XENO_HW_FPU */
 
-void xnarch_switch_to(struct xnarchtcb *out_tcb, struct xnarchtcb *in_tcb)
+void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
 {
+	struct xnarchtcb *out_tcb = &out->tcb, *in_tcb = &in->tcb;
 	struct mm_struct *prev_mm, *next_mm;
 	struct task_struct *next;
 
@@ -282,8 +284,9 @@ void xnarch_switch_to(struct xnarchtcb *out_tcb, struct xnarchtcb *in_tcb)
 #endif
 }
 
-void xnarch_enable_fpu(struct xnarchtcb *tcb)
+void xnarch_enable_fpu(struct xnthread *thread)
 {
+	struct xnarchtcb *tcb = &thread->tcb;
 #ifdef CONFIG_XENO_HW_FPU
 #ifdef CONFIG_VFP
 	/* If we are restoring the Linux current thread which does not own the
@@ -327,8 +330,9 @@ void xnarch_enable_fpu(struct xnarchtcb *tcb)
 #endif /* CONFIG_XENO_HW_FPU */
 }
 
-void xnarch_save_fpu(struct xnarchtcb *tcb)
+void xnarch_save_fpu(struct xnthread *thread)
 {
+	struct xnarchtcb *tcb = &thread->tcb;
 #ifdef CONFIG_XENO_HW_FPU
 #ifdef CONFIG_VFP
 	if (tcb->fpup)
@@ -346,8 +350,9 @@ void xnarch_save_fpu(struct xnarchtcb *tcb)
 #endif /* CONFIG_XENO_HW_FPU */
 }
 
-void xnarch_restore_fpu(struct xnarchtcb *tcb)
+void xnarch_restore_fpu(struct xnthread *thread)
 {
+	struct xnarchtcb *tcb = &thread->tcb;
 #ifdef CONFIG_XENO_HW_FPU
 #ifdef CONFIG_VFP
 	if (likely(!tcb->is_root)) {
diff --git a/kernel/cobalt/arch/blackfin/include/asm/xenomai/thread.h b/kernel/cobalt/arch/blackfin/include/asm/xenomai/thread.h
index 302675a..601fc4b 100644
--- a/kernel/cobalt/arch/blackfin/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/blackfin/include/asm/xenomai/thread.h
@@ -50,19 +50,19 @@ struct xnarchtcb {
 
 #define xnarch_fault_notify(d) (!xnarch_fault_bp_p(d))
 
-void xnarch_switch_to(struct xnarchtcb *out_tcb, struct xnarchtcb *in_tcb);
+void xnarch_switch_to(struct xnthread *out, struct xnthread *in);
 
 int xnarch_escalate(void);
 
-static inline void xnarch_init_root_tcb(struct xnarchtcb *tcb) { }
-static inline void xnarch_init_shadow_tcb(struct xnarchtcb *tcb) { }
-static inline void xnarch_enter_root(struct xnarchtcb *rootcb) { }
-static inline void xnarch_leave_root(struct xnarchtcb *rootcb) { }
-static inline void xnarch_enable_fpu(struct xnarchtcb *current_tcb) { }
-static inline void xnarch_save_fpu(struct xnarchtcb *tcb) { }
-static inline void xnarch_restore_fpu(struct xnarchtcb *tcb) { }
+static inline void xnarch_init_root_tcb(struct xnthread *thread) { }
+static inline void xnarch_init_shadow_tcb(struct xnthread *thread) { }
+static inline void xnarch_enter_root(struct xnthread *root) { }
+static inline void xnarch_leave_root(struct xnthread *root) { }
+static inline void xnarch_enable_fpu(struct xnthread *current_thread) { }
+static inline void xnarch_save_fpu(struct xnthread *thread) { }
+static inline void xnarch_restore_fpu(struct xnthread *thread) { }
 
-static inline int xnarch_handle_fpu_fault(struct xnarchtcb *tcb)
+static inline int xnarch_handle_fpu_fault(struct xnthread *thread)
 {
 	return 0;
 }
diff --git a/kernel/cobalt/arch/blackfin/mayday.c b/kernel/cobalt/arch/blackfin/mayday.c
index a43c8d4..e778794 100644
--- a/kernel/cobalt/arch/blackfin/mayday.c
+++ b/kernel/cobalt/arch/blackfin/mayday.c
@@ -18,11 +18,11 @@
  */
 #include <linux/types.h>
 #include <linux/ipipe.h>
+#include <cobalt/kernel/thread.h>
 #include <asm/cacheflush.h>
 #include <asm/ptrace.h>
 #include <asm/bug.h>
 #include <asm/xenomai/syscall.h>
-#include <asm/xenomai/thread.h>
 
 void xnarch_setup_mayday_page(void *page)
 {
diff --git a/kernel/cobalt/arch/blackfin/thread.c b/kernel/cobalt/arch/blackfin/thread.c
index e89cbb6..e0c5d54 100644
--- a/kernel/cobalt/arch/blackfin/thread.c
+++ b/kernel/cobalt/arch/blackfin/thread.c
@@ -56,8 +56,9 @@ void mpu_switch(struct xnarchtcb *out_tcb, struct xnarchtcb *in_tcb)
 
 #endif /* CONFIG_MPU */
 
-void xnarch_switch_to(struct xnarchtcb *out_tcb, struct xnarchtcb *in_tcb)
+void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
 {
+	struct xnarchtcb *out_tcb = &out->tcb, *in_tcb = &in->tcb;
 	mpu_switch(out_tcb, in_tcb);
 	__asm_switch_context(out_tcb->core.tsp, in_tcb->core.tsp);
 }
diff --git a/kernel/cobalt/arch/nios2/include/asm/xenomai/thread.h b/kernel/cobalt/arch/nios2/include/asm/xenomai/thread.h
index 85b18da..775b92a 100644
--- a/kernel/cobalt/arch/nios2/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/nios2/include/asm/xenomai/thread.h
@@ -49,20 +49,20 @@ struct xnarchtcb {
 
 #define xnarch_fault_notify(d) (xnarch_fault_bp_p(d) == 0)
 
-static inline void xnarch_init_root_tcb(struct xnarchtcb *tcb) { }
-static inline void xnarch_init_shadow_tcb(struct xnarchtcb *tcb) { }
-static inline void xnarch_enter_root(struct xnarchtcb *rootcb) { }
-static inline void xnarch_leave_root(struct xnarchtcb *rootcb) { }
-static inline void xnarch_enable_fpu(struct xnarchtcb *current_tcb) { }
-static inline void xnarch_save_fpu(struct xnarchtcb *tcb) { }
-static inline void xnarch_restore_fpu(struct xnarchtcb *tcb) { }
+static inline void xnarch_init_root_tcb(struct xnthread *thread) { }
+static inline void xnarch_init_shadow_tcb(struct xnthread *thread) { }
+static inline void xnarch_enter_root(struct xnthread *root) { }
+static inline void xnarch_leave_root(struct xnthread *thread) { }
+static inline void xnarch_enable_fpu(struct xnthread *thread) { }
+static inline void xnarch_save_fpu(struct xnthread *thread) { }
+static inline void xnarch_restore_fpu(struct xnthread *thread) { }
 
-static inline int xnarch_handle_fpu_fault(struct xnarchtcb *tcb)
+static inline int xnarch_handle_fpu_fault(struct xnthread *thread)
 {
 	return 0;
 }
 
-void xnarch_switch_to(struct xnarchtcb *out_tcb, struct xnarchtcb *in_tcb);
+void xnarch_switch_to(struct xnthread *out, struct xnthread *in);
 
 int xnarch_escalate(void);
 
diff --git a/kernel/cobalt/arch/nios2/mayday.c b/kernel/cobalt/arch/nios2/mayday.c
index 537034f..89f9572 100644
--- a/kernel/cobalt/arch/nios2/mayday.c
+++ b/kernel/cobalt/arch/nios2/mayday.c
@@ -19,9 +19,9 @@
 
 #include <linux/types.h>
 #include <linux/ipipe.h>
+#include <cobalt/kernel/thread.h>
 #include <asm/cacheflush.h>
 #include <asm/ptrace.h>
-#include <asm/xenomai/thread.h>
 
 void xnarch_setup_mayday_page(void *page)
 {
diff --git a/kernel/cobalt/arch/nios2/thread.c b/kernel/cobalt/arch/nios2/thread.c
index 90fdf35..2aed7db 100644
--- a/kernel/cobalt/arch/nios2/thread.c
+++ b/kernel/cobalt/arch/nios2/thread.c
@@ -27,8 +27,9 @@ asmlinkage void
 __asm_thread_switch(struct thread_struct *prev,
 		    struct thread_struct *next);
 
-void xnarch_switch_to(struct xnarchtcb *out_tcb, struct xnarchtcb *in_tcb)
+void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
 {
+	struct xnarchtcb *out_tcb = &out->tcb, *in_tcb = &in->tcb;
 	struct mm_struct *prev_mm, *next_mm;
 	struct task_struct *next;
 
diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/thread.h b/kernel/cobalt/arch/powerpc/include/asm/xenomai/thread.h
index 042946f..07a17cf 100644
--- a/kernel/cobalt/arch/powerpc/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/powerpc/include/asm/xenomai/thread.h
@@ -52,42 +52,44 @@ struct xnarchtcb {
 				 (d)->exception == IPIPE_TRAP_DEBUG))
 #define xnarch_fault_notify(d) (xnarch_fault_bp_p(d) == 0)
 
-static inline void xnarch_enter_root(struct xnarchtcb *rootcb) { }
+static inline void xnarch_enter_root(struct xnthread *root) { }
 
 #ifdef CONFIG_XENO_HW_FPU
 
-static inline void xnarch_init_root_tcb(struct xnarchtcb *tcb)
+static inline void xnarch_init_root_tcb(struct xnthread *thread)
 {
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	tcb->fpup = NULL;
 }
 
-static inline void xnarch_init_shadow_tcb(struct xnarchtcb *tcb)
+static inline void xnarch_init_shadow_tcb(struct xnthread *thread)
 {
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	tcb->fpup = &tcb->core.host_task->thread;
 }
 
-void xnarch_leave_root(struct xnarchtcb *rootcb);
+void xnarch_leave_root(struct xnthread *root);
 
 #else  /* !CONFIG_XENO_HW_FPU */
 
-static inline void xnarch_init_root_tcb(struct xnarchtcb *tcb) { }
-static inline void xnarch_init_shadow_tcb(struct xnarchtcb *tcb) { }
+static inline void xnarch_init_root_tcb(struct xnthread *thread) { }
+static inline void xnarch_init_shadow_tcb(struct xnthread *thread) { }
 
 #endif  /* !CONFIG_XENO_HW_FPU */
 
-static inline int xnarch_handle_fpu_fault(struct xnarchtcb *tcb)
+static inline int xnarch_handle_fpu_fault(struct xnthread *thread)
 {
 	return 0;
 }
 
-void xnarch_switch_to(struct xnarchtcb *out_tcb, struct xnarchtcb *in_tcb);
+void xnarch_switch_to(struct xnthread *out, struct xnthread *in);
 
 int xnarch_escalate(void);
 
-void xnarch_enable_fpu(struct xnarchtcb *current_tcb);
+void xnarch_enable_fpu(struct xnthread *current_thread);
 
-void xnarch_save_fpu(struct xnarchtcb *tcb);
+void xnarch_save_fpu(struct xnthread *thread);
 
-void xnarch_restore_fpu(struct xnarchtcb *tcb);
+void xnarch_restore_fpu(struct xnthread *thread);
 
 #endif /* !_COBALT_POWERPC_ASM_THREAD_H */
diff --git a/kernel/cobalt/arch/powerpc/mayday.c b/kernel/cobalt/arch/powerpc/mayday.c
index 5800caa..8a9ab95 100644
--- a/kernel/cobalt/arch/powerpc/mayday.c
+++ b/kernel/cobalt/arch/powerpc/mayday.c
@@ -19,9 +19,9 @@
 
 #include <linux/types.h>
 #include <linux/ipipe.h>
+#include <cobalt/kernel/thread.h>
 #include <asm/cacheflush.h>
 #include <asm/ptrace.h>
-#include <asm/xenomai/thread.h>
 #include <asm/xenomai/syscall.h>
 
 void xnarch_setup_mayday_page(void *page)
diff --git a/kernel/cobalt/arch/powerpc/thread.c b/kernel/cobalt/arch/powerpc/thread.c
index d6f2e74..70aad0e 100644
--- a/kernel/cobalt/arch/powerpc/thread.c
+++ b/kernel/cobalt/arch/powerpc/thread.c
@@ -30,9 +30,9 @@ asmlinkage struct task_struct *
 __asm_thread_switch(struct thread_struct *prev,
 		    struct thread_struct *next);
 
-void xnarch_switch_to(struct xnarchtcb *out_tcb,
-		      struct xnarchtcb *in_tcb)
+void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
 {
+	struct xnarchtcb *out_tcb = &out->tcb, *in_tcb = &in->tcb;
 	struct mm_struct *prev_mm, *next_mm;
 	struct task_struct *next;
 
@@ -115,8 +115,9 @@ asmlinkage void __asm_restore_fpu(struct thread_struct *ts);
 })
 #endif /* CONFIG_PPC64 */
 
-void xnarch_enable_fpu(struct xnarchtcb *tcb)
+void xnarch_enable_fpu(struct xnthread *thread)
 {
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	struct task_struct *task = tcb->core.host_task;
 
 	if (task && task != tcb->core.user_fpu_owner)
@@ -125,8 +126,10 @@ void xnarch_enable_fpu(struct xnarchtcb *tcb)
 		do_enable_fpu();
 }
 
-void xnarch_save_fpu(struct xnarchtcb *tcb)
+void xnarch_save_fpu(struct xnthread *thread)
 {
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
+
 	if (tcb->fpup) {
 		__asm_save_fpu(tcb->fpup);
 
@@ -136,8 +139,9 @@ void xnarch_save_fpu(struct xnarchtcb *tcb)
 	}
 }
 
-void xnarch_restore_fpu(struct xnarchtcb *tcb)
+void xnarch_restore_fpu(struct xnthread *thread)
 {
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	struct thread_struct *ts;
 	struct pt_regs *regs;
 
@@ -164,8 +168,9 @@ void xnarch_restore_fpu(struct xnarchtcb *tcb)
 		do_disable_fpu();
 }
 
-void xnarch_leave_root(struct xnarchtcb *rootcb)
+void xnarch_leave_root(struct xnthread *root)
 {
+	struct xnarchtcb *rootcb = xnthread_archtcb(root);
 	rootcb->core.user_fpu_owner = get_fpu_owner(rootcb->core.host_task);
 	/* So that xnarch_save_fpu() will operate on the right FPU area. */
 	rootcb->fpup = rootcb->core.user_fpu_owner ?
diff --git a/kernel/cobalt/arch/sh/include/asm/xenomai/thread.h b/kernel/cobalt/arch/sh/include/asm/xenomai/thread.h
index ef1358b..6bf7329 100644
--- a/kernel/cobalt/arch/sh/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/sh/include/asm/xenomai/thread.h
@@ -48,31 +48,33 @@ struct xnarchtcb {
 				(d)->exception == IPIPE_TRAP_BP)
 #define xnarch_fault_notify(d) (xnarch_fault_bp_p(d) == 0)
 
-static inline void xnarch_enter_root(struct xnarchtcb *rootcb) { }
+static inline void xnarch_enter_root(struct xnthread *root) { }
 
 #ifdef CONFIG_XENO_HW_FPU
 
-void xnarch_leave_root(struct xnarchtcb *rootcb);
+void xnarch_leave_root(struct xnthread *root);
 
-static inline void xnarch_init_root_tcb(struct xnarchtcb *tcb)
+static inline void xnarch_init_root_tcb(struct xnthread *thread)
 {
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	tcb->fpup = NULL;
 }
 
-static inline void xnarch_init_shadow_tcb(struct xnarchtcb *tcb)
+static inline void xnarch_init_shadow_tcb(struct xnthread *thread)
 {
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	tcb->fpup = &tcb->core.host_task->thread;
 }
 
 #else /* !CONFIG_XENO_HW_FPU */
 
-static inline void xnarch_leave_root(struct xnarchtcb *rootcb) { }
-static inline void xnarch_init_root_tcb(struct xnarchtcb *tcb) { }
-static inline void xnarch_init_shadow_tcb(struct xnarchtcb *tcb) { }
+static inline void xnarch_leave_root(struct xnthread *root) { }
+static inline void xnarch_init_root_tcb(struct xnthread *thread) { }
+static inline void xnarch_init_shadow_tcb(struct xnthread *thread) { }
 
 #endif /* !CONFIG_XENO_HW_FPU */
 
-static inline int xnarch_handle_fpu_fault(struct xnarchtcb *tcb)
+static inline int xnarch_handle_fpu_fault(struct xnthread *thread)
 {
 	return 0;
 }
diff --git a/kernel/cobalt/arch/sh/mayday.c b/kernel/cobalt/arch/sh/mayday.c
index abaea70..b564a68 100644
--- a/kernel/cobalt/arch/sh/mayday.c
+++ b/kernel/cobalt/arch/sh/mayday.c
@@ -20,9 +20,9 @@
 #include <linux/types.h>
 #include <linux/ipipe.h>
 #include <linux/mm.h>
+#include <cobalt/kernel/thread.h>
 #include <asm/cacheflush.h>
 #include <asm/ptrace.h>
-#include <asm/xenomai/thread.h>
 
 void xnarch_setup_mayday_page(void *page)
 {
diff --git a/kernel/cobalt/arch/sh/thread.c b/kernel/cobalt/arch/sh/thread.c
index e4d8414..4c8b532 100644
--- a/kernel/cobalt/arch/sh/thread.c
+++ b/kernel/cobalt/arch/sh/thread.c
@@ -90,8 +90,9 @@
 	__last;							\
 	})
 
-void xnarch_switch_to(struct xnarchtcb *out_tcb, struct xnarchtcb *in_tcb)
+void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
 {
+	struct xnarchtcb *out_tcb = &out->tcb, *in_tcb = &in->tcb;
 	struct mm_struct *prev_mm, *next_mm;
 	struct task_struct *next;
 
@@ -226,8 +227,9 @@ static inline void do_restore_fpu(struct thread_struct *ts)
 		      :"memory");
 }
 
-inline void xnarch_enable_fpu(struct xnarchtcb *tcb)
+inline void xnarch_enable_fpu(struct xnthread *thread)
 {
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	struct task_struct *task = tcb->core.host_task;
 
 	if (task != tcb->core.user_fpu_owner)
@@ -236,8 +238,9 @@ inline void xnarch_enable_fpu(struct xnarchtcb *tcb)
 		enable_fpu();
 }
 
-void xnarch_save_fpu(struct xnarchtcb *tcb)
+void xnarch_save_fpu(struct xnthread *thread)
 {
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	struct pt_regs *regs;
 
 	if (tcb->fpup) {
@@ -249,8 +252,9 @@ void xnarch_save_fpu(struct xnarchtcb *tcb)
 	}
 }
 
-void xnarch_restore_fpu(struct xnarchtcb *tcb)
+void xnarch_restore_fpu(struct xnthread *thread)
 {
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	struct pt_regs *regs;
 
 	if (tcb->fpup) {
@@ -269,8 +273,9 @@ void xnarch_restore_fpu(struct xnarchtcb *tcb)
 		disable_fpu();
 }
 
-void xnarch_leave_root(struct xnarchtcb *rootcb)
+void xnarch_leave_root(struct xnthread *root)
 {
+	struct xnarchtcb *rootcb = xnthread_archtcb(root);
 	rootcb->core.user_fpu_owner = get_fpu_owner(rootcb->core.host_task);
 	rootcb->fpup = rootcb->core.user_fpu_owner ?
 		&rootcb->core.user_fpu_owner->thread : NULL;
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
index 5d4c7ca..ee0f385 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
@@ -67,33 +67,33 @@ static inline int xnarch_shadow_p(struct xnarchtcb *tcb, struct task_struct *tas
 
 #ifdef CONFIG_XENO_HW_FPU
 
-void xnarch_save_fpu(struct xnarchtcb *tcb);
-void xnarch_restore_fpu(struct xnarchtcb *tcb);
-void xnarch_enable_fpu(struct xnarchtcb *tcb);
-int xnarch_handle_fpu_fault(struct xnarchtcb *tcb);
+void xnarch_save_fpu(struct xnthread *thread);
+void xnarch_restore_fpu(struct xnthread *thread);
+void xnarch_enable_fpu(struct xnthread *thread);
+int xnarch_handle_fpu_fault(struct xnthread *thread);
 
 #else /* !CONFIG_XENO_HW_FPU */
 
-static inline void xnarch_save_fpu(struct xnarchtcb *tcb) { }
-static inline void xnarch_restore_fpu(struct xnarchtcb *tcb) { }
-static inline void xnarch_enable_fpu(struct xnarchtcb *tcb) { }
+static inline void xnarch_save_fpu(struct xnthread *thread) { }
+static inline void xnarch_restore_fpu(struct xnthread *thread) { }
+static inline void xnarch_enable_fpu(struct xnthread *thread) { }
 
-static inline int xnarch_handle_fpu_fault(struct xnarchtcb *tcb)
+static inline int xnarch_handle_fpu_fault(struct xnthread *thread)
 {
 	return 0;
 }
 
 #endif /* !CONFIG_XENO_HW_FPU */
 
-void xnarch_init_root_tcb(struct xnarchtcb *tcb);
+void xnarch_init_root_tcb(struct xnthread *thread);
 
-void xnarch_init_shadow_tcb(struct xnarchtcb *tcb);
+void xnarch_init_shadow_tcb(struct xnthread *thread);
 
-void xnarch_switch_to(struct xnarchtcb *out_tcb, struct xnarchtcb *in_tcb);
+void xnarch_switch_to(struct xnthread *out, struct xnthread *in);
 
-static inline void xnarch_enter_root(struct xnarchtcb *tcb) { }
+static inline void xnarch_enter_root(struct xnthread *root) { }
 
-void xnarch_leave_root(struct xnarchtcb *rootcb);
+void xnarch_leave_root(struct xnthread *root);
 
 int xnarch_escalate(void);
 
diff --git a/kernel/cobalt/arch/x86/mayday.c b/kernel/cobalt/arch/x86/mayday.c
index 44e1a9c..2914369 100644
--- a/kernel/cobalt/arch/x86/mayday.c
+++ b/kernel/cobalt/arch/x86/mayday.c
@@ -19,8 +19,8 @@
 
 #include <linux/types.h>
 #include <linux/ipipe.h>
+#include <cobalt/kernel/thread.h>
 #include <asm/ptrace.h>
-#include <asm/xenomai/thread.h>
 #include <asm/xenomai/syscall.h>
 
 #ifdef CONFIG_X86_32
diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x86/thread.c
index 548c63c..0c24e02 100644
--- a/kernel/cobalt/arch/x86/thread.c
+++ b/kernel/cobalt/arch/x86/thread.c
@@ -83,8 +83,9 @@ static inline void do_switch_threads(struct xnarchtcb *out_tcb,
 
 #endif /* CONFIG_X86_64 */
 
-void xnarch_switch_to(struct xnarchtcb *out_tcb, struct xnarchtcb *in_tcb)
+void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
 {
+	struct xnarchtcb *out_tcb = &out->tcb, *in_tcb = &in->tcb;
 	unsigned long __maybe_unused fs, gs;
 	struct mm_struct *prev_mm, *next_mm;
 	struct task_struct *prev, *next;
@@ -218,8 +219,9 @@ static inline void __do_restore_i387(x86_fpustate *fpup)
 #endif /* CONFIG_X86_64 */
 }
 
-int xnarch_handle_fpu_fault(struct xnarchtcb *tcb)
+int xnarch_handle_fpu_fault(struct xnthread *thread)
 {
+	struct xnarchtcb *tcb = xnthread_archtcb(to);
 	struct task_struct *p = tcb->core.host_task;
 
 	if (tsk_used_math(p))
@@ -244,8 +246,9 @@ int xnarch_handle_fpu_fault(struct xnarchtcb *tcb)
 	return 1;
 }
 
-void xnarch_leave_root(struct xnarchtcb *rootcb)
+void xnarch_leave_root(struct xnthread *root)
 {
+	struct xnarchtcb *rootcb = xnthread_archtcb(root);
 	struct task_struct *p = current;
 
 #ifdef CONFIG_X86_64
@@ -263,8 +266,9 @@ void xnarch_leave_root(struct xnarchtcb *rootcb)
 	}
 }
 
-void xnarch_save_fpu(struct xnarchtcb *tcb)
+void xnarch_save_fpu(struct xnthread *thread)
 {
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	struct task_struct *p = tcb->core.host_task;
 
 	if (wrap_test_fpu_used(p) == 0)
@@ -278,8 +282,9 @@ void xnarch_save_fpu(struct xnarchtcb *tcb)
 	wrap_clear_fpu_used(p);
 }
 
-void xnarch_restore_fpu(struct xnarchtcb *tcb)
+void xnarch_restore_fpu(struct xnthread *thread)
 {
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	struct task_struct *p = tcb->core.host_task;
 
 	if (tcb->root_kfpu == 0 && (tsk_used_math(p) == 0 || tcb->is_root))
@@ -302,15 +307,16 @@ void xnarch_restore_fpu(struct xnarchtcb *tcb)
 		wrap_set_fpu_used(p);
 }
 
-void xnarch_enable_fpu(struct xnarchtcb *tcb)
+void xnarch_enable_fpu(struct xnthread *thread)
 {
-	xnarch_restore_fpu(tcb);
+	xnarch_restore_fpu(thread);
 }
 
 #endif /* CONFIG_XENO_HW_FPU */
 
-void xnarch_init_root_tcb(struct xnarchtcb *tcb)
+void xnarch_init_root_tcb(struct xnthread *thread)
 {
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	tcb->sp = 0;
 	tcb->spp = &tcb->sp;
 	tcb->ipp = &tcb->ip;
@@ -319,9 +325,10 @@ void xnarch_init_root_tcb(struct xnarchtcb *tcb)
 	tcb->root_kfpu = 0;
 }
 
-void xnarch_init_shadow_tcb(struct xnarchtcb *tcb)
+void xnarch_init_shadow_tcb(struct xnthread *thread)
 {
 	struct task_struct *p = tcb->core.host_task;
+	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 
 	tcb->sp = 0;
 	tcb->spp = &p->thread.sp;
diff --git a/kernel/cobalt/include/asm-generic/xenomai/thread.h b/kernel/cobalt/include/asm-generic/xenomai/thread.h
index e1c1e8b..303d373 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/thread.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/thread.h
@@ -28,6 +28,9 @@
 
 struct task_struct;
 
+struct xnthread;
+struct xnarchtcb;
+
 struct xntcb {
 	struct task_struct *host_task;
 	struct thread_struct *tsp;
@@ -43,4 +46,6 @@ struct xntcb {
 #endif
 };
 
+static inline struct xnarchtcb *xnthread_archtcb(struct xnthread *thread);
+
 #endif /* !_COBALT_ASM_GENERIC_THREAD_H */
diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index 2e11826..682f71b 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -25,7 +25,6 @@
 #include <cobalt/kernel/heap.h>
 #include <cobalt/kernel/shadow.h>
 #include <cobalt/kernel/arith.h>
-#include <asm/xenomai/thread.h>
 
 DEFINE_PER_CPU(struct xnsched, nksched);
 EXPORT_PER_CPU_SYMBOL_GPL(nksched);
@@ -646,8 +645,7 @@ static inline void switch_context(struct xnsched *sched,
 	xnlock_clear_irqon(&nklock);
 #endif /* !CONFIG_XENO_HW_UNLOCKED_SWITCH */
 
-	xnarch_switch_to(xnthread_archtcb(prev),
-			 xnthread_archtcb(next));
+	xnarch_switch_to(prev, next);
 }
 
 /**
@@ -746,7 +744,7 @@ static inline void leave_root(struct xnthread *root)
 #ifdef CONFIG_XENO_HW_UNLOCKED_SWITCH
 	rootcb->core.tip = task_thread_info(p);
 #endif
-	xnarch_leave_root(rootcb);
+	xnarch_leave_root(root);
 }
 
 void __xnsched_run_handler(void) /* hw interrupts off. */
diff --git a/kernel/cobalt/shadow.c b/kernel/cobalt/shadow.c
index e5ad6e3..99ccee0 100644
--- a/kernel/cobalt/shadow.c
+++ b/kernel/cobalt/shadow.c
@@ -57,9 +57,9 @@
 #include <cobalt/kernel/stat.h>
 #include <cobalt/kernel/ppd.h>
 #include <cobalt/kernel/vdso.h>
+#include <cobalt/kernel/thread.h>
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/syscall.h>
-#include <asm/xenomai/thread.h>
 #include <asm-generic/xenomai/mayday.h>
 #include "debug.h"
 
@@ -2592,7 +2592,6 @@ int ipipe_kevent_hook(int kevent, void *data)
 static inline int handle_exception(struct ipipe_trap_data *d)
 {
 	struct xnthread *thread;
-	struct xnarchtcb *tcb;
 
 	if (xnsched_root_p())
 		return 0;
@@ -2608,8 +2607,7 @@ static inline int handle_exception(struct ipipe_trap_data *d)
 	if (xnarch_fault_fpu_p(d)) {
 		if (!xnthread_test_state(thread, XNROOT)) {
 			/* FPU exception received in primary mode. */
-			tcb = xnthread_archtcb(thread);
-			if (xnarch_handle_fpu_fault(tcb))
+			if (xnarch_handle_fpu_fault(thread))
 				return 1;
 		}
 		print_symbol("invalid use of FPU in Xenomai context at %s\n",
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index c5825ef..09d61e2 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -36,7 +36,6 @@
 #include <cobalt/kernel/shadow.h>
 #include <cobalt/kernel/lock.h>
 #include <cobalt/kernel/thread.h>
-#include <asm/xenomai/thread.h>
 
 /**
  * @ingroup nucleus
@@ -225,7 +224,7 @@ void xnthread_init_shadow_tcb(struct xnthread *thread, struct task_struct *task)
 #ifdef CONFIG_XENO_HW_FPU
 	tcb->core.user_fpu_owner = task;
 #endif /* CONFIG_XENO_HW_FPU */
-	xnarch_init_shadow_tcb(tcb);
+	xnarch_init_shadow_tcb(thread);
 }
 
 void xnthread_init_root_tcb(struct xnthread *thread)
@@ -239,7 +238,7 @@ void xnthread_init_root_tcb(struct xnthread *thread)
 #ifdef CONFIG_XENO_HW_UNLOCKED_SWITCH
 	tcb->core.tip = &tcb->core.ti;
 #endif
-	xnarch_init_root_tcb(tcb);
+	xnarch_init_root_tcb(thread);
 }
 
 void xnthread_deregister(struct xnthread *thread)
@@ -380,7 +379,7 @@ static inline void release_fpu(struct xnthread *thread)
 	 * area of the migrated thread.
 	 */
 	if (xnthread_test_state(thread, XNFPU)) {
-		xnarch_save_fpu(xnthread_archtcb(thread));
+		xnarch_save_fpu(thread);
 		thread->sched->fpuholder = NULL;
 	}
 }
@@ -397,16 +396,15 @@ void xnthread_switch_fpu(struct xnsched *sched)
 		    xnarch_fpu_ptr(xnthread_archtcb(sched->fpuholder)) !=
 		    xnarch_fpu_ptr(xnthread_archtcb(curr))) {
 			if (sched->fpuholder)
-				xnarch_save_fpu(xnthread_archtcb
-						(sched->fpuholder));
+				xnarch_save_fpu(sched->fpuholder);
 
-			xnarch_restore_fpu(xnthread_archtcb(curr));
+			xnarch_restore_fpu(curr);
 		} else
-			xnarch_enable_fpu(xnthread_archtcb(curr));
+			xnarch_enable_fpu(curr);
 
 		sched->fpuholder = curr;
 	} else
-		xnarch_enable_fpu(xnthread_archtcb(curr));
+		xnarch_enable_fpu(curr);
 }
 
 #else /* !CONFIG_XENO_HW_FPU */
-- 
1.7.10.4


