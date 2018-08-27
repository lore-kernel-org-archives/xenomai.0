From: Henning Schild <henning.schild@siemens.com>
Date: Mon, 27 Aug 2018 15:28:05 +0200
Message-Id: <9943ff4b424f1d12b00b2d087680e5c0047fbe00.1535375976.git.henning.schild@siemens.com>
In-Reply-To: <cover.1535375976.git.henning.schild@siemens.com>
References: <cover.1535375976.git.henning.schild@siemens.com>
In-Reply-To: <cover.1535375976.git.henning.schild@siemens.com>
References: <cover.1535375976.git.henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 1/3] cobalt/x86: add support for eager fpu handling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Upstream 4.14 switched to purely eager fpu switching. That was
backported to 4.4 and 4.9. This commit makes cobalt able to deal whith
the changed kernel behaviour.

Introduce IPIPE_X86_FPU_EAGER to switch between the new and the old
implementations. The new implementation is much simpler than the old
one. We basically only deal with the odd case where Xenomai preempts
Linux in a kernel-fpu context.
In a regular Linux that can never happen and if it happens we need to
make sure to get things into a consistent state. We have to make
"current" as not owning the fpu anymore and allow others to use
in-kernel fpu (kernel_fpu_enable). __switch_to from Linux will do the
rest.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 .../cobalt/arch/x86/include/asm/xenomai/thread.h   |  8 ++-
 .../cobalt/arch/x86/include/asm/xenomai/wrappers.h |  6 ++
 kernel/cobalt/arch/x86/thread.c                    | 67 +++++++++++++++++++++-
 3 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
index f174a82c0..0c5c4da9c 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
@@ -24,6 +24,7 @@
 #include <asm/xenomai/wrappers.h>
 #include <asm/traps.h>
 
+#ifndef IPIPE_X86_FPU_EAGER
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0)
 typedef union thread_xstate x86_fpustate;
 #define x86_fpustate_ptr(t) ((t)->fpu.state)
@@ -31,6 +32,7 @@ typedef union thread_xstate x86_fpustate;
 typedef union fpregs_state x86_fpustate;
 #define x86_fpustate_ptr(t) ((t)->fpu.active_state)
 #endif
+#endif
 
 struct xnarchtcb {
 	struct xntcb core;
@@ -40,10 +42,14 @@ struct xnarchtcb {
 	unsigned long ip;
 	unsigned long *ipp;
 #endif  
+#ifdef IPIPE_X86_FPU_EAGER
+	struct fpu *kfpu;
+#else
 	x86_fpustate *fpup;
-	unsigned int root_kfpu: 1;
 	unsigned int root_used_math: 1;
 	x86_fpustate *kfpu_state;
+#endif
+	unsigned int root_kfpu: 1;
 	struct {
 		unsigned long ip;
 		unsigned long ax;
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
index 5f9cff3c9..73df60cc6 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
@@ -24,6 +24,12 @@
 #define __get_user_inatomic __get_user
 #define __put_user_inatomic __put_user
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,9,0) && \
+    LINUX_VERSION_CODE < KERNEL_VERSION(4,10,0) && \
+    LINUX_VERSION_CODE > KERNEL_VERSION(4,9,108)
+#define IPIPE_X86_FPU_EAGER
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
 #include <asm/i387.h>
 #include <asm/fpu-internal.h>
diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x86/thread.c
index 7fb136300..54bc5c008 100644
--- a/kernel/cobalt/arch/x86/thread.c
+++ b/kernel/cobalt/arch/x86/thread.c
@@ -28,9 +28,13 @@
 
 static struct kmem_cache *xstate_cache;
 
+#ifdef IPIPE_X86_FPU_EAGER
+#define fpu_kernel_xstate_size sizeof(struct fpu)
+#else
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,7,0)
 #define fpu_kernel_xstate_size xstate_size
 #endif
+#endif
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(4,6,0)
 #define cpu_has_xmm boot_cpu_has(X86_FEATURE_XMM)
@@ -199,20 +203,24 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
 	struct mm_struct *prev_mm, *next_mm;
 
 	prev = out_tcb->core.host_task;
+#ifndef IPIPE_X86_FPU_EAGER
 	if (x86_fpregs_active(prev))
 		/*
 		 * __switch_to will try and use __unlazy_fpu, so we
 		 * need to clear the ts bit.
 		 */
 		clts();
+#endif
 
 	next = in_tcb->core.host_task;
+#ifndef IPIPE_X86_FPU_EAGER
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0)
 	next->thread.fpu.counter = 0;
 #elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
 	next->thread.fpu_counter = 0;
 #else
 	next->fpu_counter = 0;
+#endif
 #endif
 	prev_mm = out_tcb->core.active_mm;
 	next_mm = in_tcb->core.mm;
@@ -245,9 +253,13 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
 	switch_to(prev, next, last);
 #endif /* LINUX_VERSION_CODE >= 4.8 */
 
+#ifndef IPIPE_X86_FPU_EAGER
 	stts();
+#endif
 }
 
+#ifndef IPIPE_X86_FPU_EAGER
+
 #ifdef CONFIG_X86_64
 #define XSAVE_PREFIX	"0x48,"
 #define XSAVE_SUFFIX	"q"
@@ -359,11 +371,20 @@ int xnarch_handle_fpu_fault(struct xnthread *from,
 
 	return 1;
 }
+#else /* !IPIPE_X86_FPU_EAGER */
+
+int xnarch_handle_fpu_fault(struct xnthread *from,
+			struct xnthread *to, struct ipipe_trap_data *d)
+{
+	BUG_ON(1);
+}
+#endif /* IPIPE_X86_FPU_EAGER */
 
 #define current_task_used_kfpu() kernel_fpu_disabled()
 
 #define tcb_used_kfpu(t) ((t)->root_kfpu)
 
+#ifndef IPIPE_X86_FPU_EAGER
 void xnarch_leave_root(struct xnthread *root)
 {
 	struct xnarchtcb *const rootcb = xnthread_archtcb(root);
@@ -430,6 +451,35 @@ void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
 		p->flags &= ~PF_USED_MATH;
 	}
 }
+#else
+void xnarch_leave_root(struct xnthread *root)
+{
+	struct xnarchtcb *const rootcb = xnthread_archtcb(root);
+
+	rootcb->root_kfpu = current_task_used_kfpu();
+
+	if (!tcb_used_kfpu(rootcb))
+		return;
+
+	// the kernel never marked the task as not being the fpu owner anymore
+	if (&current->thread.fpu.fpstate_active)
+		fpregs_deactivate(&current->thread.fpu);
+
+	copy_fpregs_to_fpstate(rootcb->kfpu);
+	kernel_fpu_enable();
+}
+
+void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
+{
+	struct xnarchtcb *const to_tcb = xnthread_archtcb(to);
+
+	if (!tcb_used_kfpu(to_tcb))
+		return;
+
+	copy_kernel_to_fpregs(&to_tcb->kfpu->state);
+	kernel_fpu_disable();
+}
+#endif /* IPIPE_X86_FPU_EAGER */
 
 void xnarch_init_root_tcb(struct xnthread *thread)
 {
@@ -440,9 +490,13 @@ void xnarch_init_root_tcb(struct xnthread *thread)
 	tcb->spp = &tcb->sp;
 	tcb->ipp = &tcb->ip;
 #endif	
+#ifndef IPIPE_X86_FPU_EAGER
 	tcb->fpup = NULL;
-	tcb->root_kfpu = 0;
 	tcb->kfpu_state = kmem_cache_zalloc(xstate_cache, GFP_KERNEL);
+#else
+	tcb->kfpu = kmem_cache_zalloc(xstate_cache, GFP_KERNEL);
+#endif
+	tcb->root_kfpu = 0;
 }
 
 void xnarch_init_shadow_tcb(struct xnthread *thread)
@@ -459,12 +513,21 @@ void xnarch_init_shadow_tcb(struct xnthread *thread)
 	tcb->ipp = &p->thread.rip; /* <!> raw naming intended. */
 #endif
 #endif
+#ifndef IPIPE_X86_FPU_EAGER
 	tcb->fpup = x86_fpustate_ptr(&p->thread);
-	tcb->root_kfpu = 0;
 	tcb->kfpu_state = NULL;
+#else
+	tcb->kfpu = NULL;
+#endif
+	tcb->root_kfpu = 0;
 
 	/* XNFPU is set upon first FPU fault */
 	xnthread_clear_state(thread, XNFPU);
+
+#ifdef IPIPE_X86_FPU_EAGER
+	xnthread_set_state(thread, XNFPU);
+	fpu__activate_fpstate_read(&p->thread.fpu);
+#endif
 }
 
 int mach_x86_thread_init(void)
-- 
2.16.4


