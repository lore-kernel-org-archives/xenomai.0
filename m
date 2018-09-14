From: Henning Schild <henning.schild@siemens.com>
Date: Fri, 14 Sep 2018 18:14:39 +0200
Message-Id: <20180914161442.2406-3-henning.schild@siemens.com>
In-Reply-To: <20180914161442.2406-1-henning.schild@siemens.com>
References: <20180914161442.2406-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] [IPIPE] [PATCHv2] x86: make fpu switching eager
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Linux 4.14 dropped support for lazy fpu switching and in the 4.4 and 4.9
series similar changes where backported.
So fpu is eager for those versions. That simplifies things a lot and we can
drop several changes from the IPIPE patch.
On the Xenomai side the only thing we still have to care about is the
kernel fpu state when we interrupt an in kernel fpu user. But we do that
explicit and can drop the indirection active_(fp)state.

This patch basically drops most of the fpu specifics from the ipipe
patch.

This patch applies on ipipe-4.9.y and it has to be followed by a merge with
>= 4.9.109. Cobalt will not compile if you are already eager and still
4.9.108

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 arch/x86/include/asm/fpu/internal.h | 30 ++++++++---------------------
 arch/x86/include/asm/fpu/types.h    | 12 ------------
 arch/x86/kernel/fpu/core.c          | 17 ++++++----------
 arch/x86/kernel/fpu/init.c          |  5 +----
 4 files changed, 15 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 35ca184e83e1..6bdceba90f17 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -13,7 +13,6 @@
 #include <linux/compat.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/kconfig.h>
 #include <linux/ipipe.h>
 
 #include <asm/user.h>
@@ -190,24 +189,12 @@ static inline int copy_user_to_fregs(struct fregs_state __user *fx)
 	return user_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-#ifdef CONFIG_IPIPE
-static inline union fpregs_state *active_fpstate(struct fpu *fpu)
-{
-	return fpu->active_state;
-}
-#else
-static inline union fpregs_state *active_fpstate(struct fpu *fpu)
-{
-	return &fpu->state;
-}
-#endif
-
 static inline void copy_fxregs_to_kernel(struct fpu *fpu)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
-		asm volatile( "fxsave %[fx]" : [fx] "=m" (active_fpstate(fpu)->fxsave));
+		asm volatile( "fxsave %[fx]" : [fx] "=m" (fpu->state.fxsave));
 	else if (IS_ENABLED(CONFIG_AS_FXSAVEQ))
-		asm volatile("fxsaveq %[fx]" : [fx] "=m" (active_fpstate(fpu)->fxsave));
+		asm volatile("fxsaveq %[fx]" : [fx] "=m" (fpu->state.fxsave));
 	else {
 		/* Using "rex64; fxsave %0" is broken because, if the memory
 		 * operand uses any extended registers for addressing, a second
@@ -231,8 +218,8 @@ static inline void copy_fxregs_to_kernel(struct fpu *fpu)
 		 * registers.
 		 */
 		asm volatile( "rex64/fxsave (%[fx])"
-			      : "=m" (active_fpstate(fpu)->fxsave)
-			      : [fx] "R" (&active_fpstate(fpu)->fxsave));
+                             : "=m" (fpu->state.fxsave)
+                             : [fx] "R" (&fpu->state.fxsave));
 	}
 }
 
@@ -441,7 +428,7 @@ static inline int copy_user_to_xregs(struct xregs_state __user *buf, u64 mask)
 static inline int copy_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
-		copy_xregs_to_kernel(&active_fpstate(fpu)->xsave);
+		copy_xregs_to_kernel(&fpu->state.xsave);
 		return 1;
 	}
 
@@ -454,7 +441,7 @@ static inline int copy_fpregs_to_fpstate(struct fpu *fpu)
 	 * Legacy FPU register saving, FNSAVE always clears FPU registers,
 	 * so we have to mark them inactive:
 	 */
-	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (active_fpstate(fpu)->fsave));
+	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (fpu->state.fsave));
 
 	return 0;
 }
@@ -609,8 +596,7 @@ switch_fpu_prepare(struct fpu *old_fpu, struct fpu *new_fpu, int cpu)
 	 * If the task has used the math, pre-load the FPU on xsave processors
 	 * or if the past 5 consecutive context-switches used math.
 	 */
-	fpu.preload = !IS_ENABLED(CONFIG_IPIPE) &&
-		      static_cpu_has(X86_FEATURE_FPU) &&
+	fpu.preload = static_cpu_has(X86_FEATURE_FPU) &&
 		      new_fpu->fpstate_active &&
 		      (use_eager_fpu() || new_fpu->counter > 5);
 
@@ -660,7 +646,7 @@ switch_fpu_prepare(struct fpu *old_fpu, struct fpu *new_fpu, int cpu)
  */
 static inline void switch_fpu_finish(struct fpu *new_fpu, fpu_switch_t fpu_switch)
 {
-	if (!IS_ENABLED(CONFIG_IPIPE) && fpu_switch.preload)
+	if (fpu_switch.preload)
 		copy_kernel_to_fpregs(&new_fpu->state);
 }
 
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 497c551469ec..48df486b02f9 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -332,18 +332,6 @@ struct fpu {
 	 * deal with bursty apps that only use the FPU for a short time:
 	 */
 	unsigned char			counter;
-
-#ifdef CONFIG_IPIPE
-	/*
-	 * @active_state
-	 *
-	 * An indirection pointer to reach the active state context
-	 * for the task.  This is used by co-kernels for dealing with
-	 * preemption of kernel fpu contexts by their own tasks.
-	 */
-	union fpregs_state		*active_state;
-#endif
-	
 	/*
 	 * @state:
 	 *
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index d31a73b2ab76..7dd8518272ca 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -124,7 +124,7 @@ void __kernel_fpu_end(void)
 
 	flags = hard_cond_local_irq_save();
 	if (fpu->fpregs_active)
-		copy_kernel_to_fpregs(active_fpstate(fpu));
+		copy_kernel_to_fpregs(&fpu->state);
 	else
 		__fpregs_deactivate_hw();
 
@@ -192,7 +192,7 @@ void fpu__save(struct fpu *fpu)
 	if (fpu->fpregs_active) {
 		if (!copy_fpregs_to_fpstate(fpu)) {
 			if (use_eager_fpu())
-				copy_kernel_to_fpregs(active_fpstate(fpu));
+				copy_kernel_to_fpregs(&fpu->state);
 			else
 				fpregs_deactivate(fpu);
 		}
@@ -244,13 +244,8 @@ int fpu__copy(struct fpu *dst_fpu, struct fpu *src_fpu)
 	dst_fpu->counter = 0;
 	dst_fpu->fpregs_active = 0;
 	dst_fpu->last_cpu = -1;
-#ifdef CONFIG_IPIPE
-	/* Must be set before FPU context is copied. */
-	dst_fpu->active_state = &dst_fpu->state;
-#endif
 
-	if (!IS_ENABLED(CONFIG_IPIPE) &&
-	    (!src_fpu->fpstate_active || !static_cpu_has(X86_FEATURE_FPU)))
+	if (!src_fpu->fpstate_active || !static_cpu_has(X86_FEATURE_FPU))
 		return 0;
 
 	WARN_ON_FPU(src_fpu != &current->thread.fpu);
@@ -283,7 +278,7 @@ int fpu__copy(struct fpu *dst_fpu, struct fpu *src_fpu)
 		       fpu_kernel_xstate_size);
 
 		if (use_eager_fpu())
-			copy_kernel_to_fpregs(active_fpstate(src_fpu));
+			copy_kernel_to_fpregs(&src_fpu->state);
 		else
 			fpregs_deactivate(src_fpu);
 	}
@@ -430,7 +425,7 @@ void fpu__current_fpstate_write_end(void)
 	 * an XRSTOR if they are active.
 	 */
 	if (fpregs_active())
-		copy_kernel_to_fpregs(active_fpstate(fpu));
+		copy_kernel_to_fpregs(&fpu->state);
 
 	/*
 	 * Our update is done and the fpregs/fpstate are in sync
@@ -460,7 +455,7 @@ void fpu__restore(struct fpu *fpu)
 	kernel_fpu_disable();
 	trace_x86_fpu_before_restore(fpu);
 	fpregs_activate(fpu);
-	copy_kernel_to_fpregs(active_fpstate(fpu));
+	copy_kernel_to_fpregs(&fpu->state);
 	fpu->counter++;
 	trace_x86_fpu_after_restore(fpu);
 	kernel_fpu_enable();
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 3eee35d3d6f8..a1fc061d03e1 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -42,9 +42,6 @@ static void fpu__init_cpu_generic(void)
 		cr0 |= X86_CR0_EM;
 	write_cr0(cr0);
 
-#ifdef CONFIG_IPIPE
-	current->thread.fpu.active_state = &current->thread.fpu.state;
-#endif
 	/* Flush out any pending x87 state: */
 #ifdef CONFIG_MATH_EMULATION
 	if (!boot_cpu_has(X86_FEATURE_FPU))
@@ -329,7 +326,7 @@ static void __init fpu__init_system_ctx_switch(void)
 		eagerfpu = ENABLE;
 
 	if (IS_ENABLED(CONFIG_IPIPE))
-		eagerfpu = DISABLE;
+		eagerfpu = ENABLE;
 
 	if (eagerfpu == ENABLE)
 		setup_force_cpu_cap(X86_FEATURE_EAGER_FPU);
-- 
2.19.0


