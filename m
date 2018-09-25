From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:37:58 +0200
Message-Id: <20180925103809.4932-22-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 21/32] x86: ipipe fpu support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Henning Schild <henning.schild@siemens.com>

---
 arch/x86/include/asm/fpu/internal.h | 20 +++++++++++++
 arch/x86/kernel/fpu/core.c          | 58 +++++++++++++++++++++----------------
 2 files changed, 53 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index a38bf5a1e37a..5d37b192e866 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -604,4 +604,24 @@ static inline void xsetbv(u32 index, u64 value)
 		     : : "a" (eax), "d" (edx), "c" (index));
 }
 
+DECLARE_PER_CPU(bool, in_kernel_fpu);
+
+static void kernel_fpu_disable(void)
+{
+	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
+	this_cpu_write(in_kernel_fpu, true);
+}
+
+static void kernel_fpu_enable(void)
+{
+	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
+	this_cpu_write(in_kernel_fpu, false);
+}
+
+static bool kernel_fpu_disabled(void)
+{
+	return this_cpu_read(in_kernel_fpu);
+}
+
+
 #endif /* _ASM_X86_FPU_INTERNAL_H */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 2ea85b32421a..18ac3f3450e6 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -35,30 +35,13 @@ union fpregs_state init_fpstate __read_mostly;
  *
  *   - to debug kernel_fpu_begin()/end() correctness
  */
-static DEFINE_PER_CPU(bool, in_kernel_fpu);
+DEFINE_PER_CPU(bool, in_kernel_fpu);
 
 /*
  * Track which context is using the FPU on the CPU:
  */
 DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 
-static void kernel_fpu_disable(void)
-{
-	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
-	this_cpu_write(in_kernel_fpu, true);
-}
-
-static void kernel_fpu_enable(void)
-{
-	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
-	this_cpu_write(in_kernel_fpu, false);
-}
-
-static bool kernel_fpu_disabled(void)
-{
-	return this_cpu_read(in_kernel_fpu);
-}
-
 static bool interrupted_kernel_fpu_idle(void)
 {
 	return !kernel_fpu_disabled();
@@ -96,9 +79,11 @@ EXPORT_SYMBOL(irq_fpu_usable);
 void __kernel_fpu_begin(void)
 {
 	struct fpu *fpu = &current->thread.fpu;
+	unsigned long flags;
 
 	WARN_ON_FPU(!irq_fpu_usable());
 
+	flags = hard_cond_local_irq_save();
 	kernel_fpu_disable();
 
 	if (fpu->initialized) {
@@ -110,17 +95,21 @@ void __kernel_fpu_begin(void)
 	} else {
 		__cpu_invalidate_fpregs_state();
 	}
+	hard_cond_local_irq_restore(flags);
 }
 EXPORT_SYMBOL(__kernel_fpu_begin);
 
 void __kernel_fpu_end(void)
 {
 	struct fpu *fpu = &current->thread.fpu;
+	unsigned long flags;
 
+	flags = hard_cond_local_irq_save();
 	if (fpu->initialized)
 		copy_kernel_to_fpregs(&fpu->state);
 
 	kernel_fpu_enable();
+	hard_cond_local_irq_restore(flags);
 }
 EXPORT_SYMBOL(__kernel_fpu_end);
 
@@ -145,9 +134,11 @@ EXPORT_SYMBOL_GPL(kernel_fpu_end);
  */
 void fpu__save(struct fpu *fpu)
 {
+	unsigned long flags;
+
 	WARN_ON_FPU(fpu != &current->thread.fpu);
 
-	preempt_disable();
+	flags = hard_preempt_disable();
 	trace_x86_fpu_before_save(fpu);
 	if (fpu->initialized) {
 		if (!copy_fpregs_to_fpstate(fpu)) {
@@ -155,7 +146,7 @@ void fpu__save(struct fpu *fpu)
 		}
 	}
 	trace_x86_fpu_after_save(fpu);
-	preempt_enable();
+	hard_preempt_enable(flags);
 }
 EXPORT_SYMBOL_GPL(fpu__save);
 
@@ -317,6 +308,9 @@ void fpu__prepare_write(struct fpu *fpu)
  */
 void fpu__restore(struct fpu *fpu)
 {
+	unsigned long flags;
+
+	flags = hard_local_irq_save();
 	fpu__initialize(fpu);
 
 	/* Avoid __kernel_fpu_begin() right after fpregs_activate() */
@@ -326,9 +320,18 @@ void fpu__restore(struct fpu *fpu)
 	copy_kernel_to_fpregs(&fpu->state);
 	trace_x86_fpu_after_restore(fpu);
 	kernel_fpu_enable();
+	hard_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(fpu__restore);
 
+#ifdef CONFIG_IPIPE
+#define FWAIT_PROLOGUE "sti\n"
+#define FWAIT_EPILOGUE "cli\n"
+#else
+#define FWAIT_PROLOGUE
+#define FWAIT_EPILOGUE
+#endif
+
 /*
  * Drops current FPU state: deactivates the fpregs and
  * the fpstate. NOTE: it still leaves previous contents
@@ -340,13 +343,16 @@ EXPORT_SYMBOL_GPL(fpu__restore);
  */
 void fpu__drop(struct fpu *fpu)
 {
-	preempt_disable();
+	unsigned long flags;
 
+	flags = hard_preempt_disable();
 	if (fpu == &current->thread.fpu) {
 		if (fpu->initialized) {
 			/* Ignore delayed exceptions from user space */
-			asm volatile("1: fwait\n"
+			asm volatile(FWAIT_PROLOGUE
+				     "1: fwait\n"
 				     "2:\n"
+				     FWAIT_EPILOGUE
 				     _ASM_EXTABLE(1b, 2b));
 			fpregs_deactivate(fpu);
 		}
@@ -356,7 +362,7 @@ void fpu__drop(struct fpu *fpu)
 
 	trace_x86_fpu_dropped(fpu);
 
-	preempt_enable();
+	hard_preempt_enable(flags);
 }
 
 /*
@@ -384,6 +390,8 @@ static inline void copy_init_fpstate_to_fpregs(void)
  */
 void fpu__clear(struct fpu *fpu)
 {
+	unsigned long flags;
+
 	WARN_ON_FPU(fpu != &current->thread.fpu); /* Almost certainly an anomaly */
 
 	fpu__drop(fpu);
@@ -392,11 +400,11 @@ void fpu__clear(struct fpu *fpu)
 	 * Make sure fpstate is cleared and initialized.
 	 */
 	if (static_cpu_has(X86_FEATURE_FPU)) {
-		preempt_disable();
+		flags = hard_local_irq_save();
 		fpu__initialize(fpu);
 		user_fpu_begin();
 		copy_init_fpstate_to_fpregs();
-		preempt_enable();
+		hard_local_irq_restore(flags);
 	}
 }
 
-- 
2.14.4


