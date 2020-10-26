From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 03/11] cobalt/x86: Account for FPU changes in kernel 5.2
Date: Mon, 26 Oct 2020 12:04:49 +0100
Message-Id: <608c23297c4d35a6f782c5f5ee3b0aca2e05c2fc.1603710297.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1603710297.git.jan.kiszka@siemens.com>
References: <cover.1603710297.git.jan.kiszka@siemens.com>
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
Cc: Fino Meng <fino.meng@linux.intel.com>, Mingliang Hu <mingliang.hu@intel.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

Since that version, the FPU is only updated when returning to userspace.
This breaks the thread switching expectations of Xenomai because there
is no update happening when returning to a thread in primary mode or
when switching in a primary-mode kernel thread.

Account for that by
 - saving the context when switching out an in-kernel Xenomai thread
 - restoring the context after switching in a Xenomai thread
 - invalidate the FPU state variables after returning to a preempted
   Linux kernel thread that uses the FPU

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/arch/x86/thread.c | 46 +++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x86/thread.c
index ba807ac1ed..1ed6acb46b 100644
--- a/kernel/cobalt/arch/x86/thread.c
+++ b/kernel/cobalt/arch/x86/thread.c
@@ -215,6 +215,21 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
 		 */
 		clts();
 #endif /* ! IPIPE_X86_FPU_EAGER */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
+	if (!xnthread_test_state(out, XNROOT | XNUSER) &&
+	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		/*
+		 * This compensates that switch_fpu_prepare ignores kernel
+		 * threads.
+		 */
+		struct fpu *prev_fpu = &prev->thread.fpu;
+
+		if (!copy_fpregs_to_fpstate(prev_fpu))
+			prev_fpu->last_cpu = -1;
+		else
+			prev_fpu->last_cpu = smp_processor_id();
+	}
+#endif
 
 	next = in_tcb->core.host_task;
 #ifndef IPIPE_X86_FPU_EAGER
@@ -260,6 +275,29 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
 #ifndef IPIPE_X86_FPU_EAGER
 	stts();
 #endif /* ! IPIPE_X86_FPU_EAGER */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
+	/* 
+	 * Refresh 'in', we switch the stacks. However, there might be no
+	 * current thread at this point.
+	 */
+	in = xnthread_current();
+	if (in && !xnthread_test_state(in, XNROOT) &&
+	    test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		/*
+		 * This is open-coded switch_fpu_return but without a test for
+		 * PF_KTHREAD, i.e including kernel threads.
+		 */
+		struct fpu *fpu = &current->thread.fpu;
+		int cpu = smp_processor_id();
+
+		if (!fpregs_state_valid(fpu, cpu)) {
+			copy_kernel_to_fpregs(&fpu->state);
+			fpregs_activate(fpu);
+			fpu->last_cpu = cpu;
+		}
+		clear_thread_flag(TIF_NEED_FPU_LOAD);
+	}
+#endif
 }
 
 #ifndef IPIPE_X86_FPU_EAGER
@@ -472,7 +510,11 @@ void xnarch_leave_root(struct xnthread *root)
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
 	/* restore current's fpregs */
 	__cpu_invalidate_fpregs_state();
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
+	switch_fpu_finish(&current->thread.fpu);
+#else
 	switch_fpu_finish(&current->thread.fpu, smp_processor_id());
+#endif
 #else
 	/* mark current thread as not owning the FPU anymore */
 	if (fpregs_active())
@@ -488,6 +530,10 @@ void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
 		return;
 
 	copy_kernel_to_fpregs(&to_tcb->kfpu->state);
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
+	/* redo the invalidation done by kernel_fpu_begin */
+	__cpu_invalidate_fpregs_state();
+#endif
 	kernel_fpu_disable();
 }
 #endif /* ! IPIPE_X86_FPU_EAGER */
-- 
2.26.2


