From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:27:11 +0200
Message-Id: <20180925102716.4492-7-rpm@xenomai.org>
In-Reply-To: <20180925102716.4492-1-rpm@xenomai.org>
References: <20180925102716.4492-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 06/11] arm64: fpsimd: ipipe: enable sharing with
 head domain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Dmitriy Cherkasov <dmitriy@oss-tech.org>

Serialize accesses to the fpsimd so as to allow co-kernel activities
(e.g. tasks) running in the head domain to share the unit with the
host kernel.
---
 arch/arm64/kernel/fpsimd.c | 138 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 123 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 5d547deb6996..01f336ff9270 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -26,6 +26,7 @@
 #include <linux/preempt.h>
 #include <linux/sched/signal.h>
 #include <linux/signal.h>
+#include <linux/ipipe.h>
 
 #include <asm/fpsimd.h>
 #include <asm/cputype.h>
@@ -104,6 +105,9 @@ static DEFINE_PER_CPU(struct fpsimd_state *, fpsimd_last_state);
  */
 void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
 {
+	if (__ipipe_report_trap(IPIPE_TRAP_FPU_ACC, regs))
+		return;
+
 	/* TODO: implement lazy context saving/restoring */
 	WARN_ON(1);
 }
@@ -116,6 +120,9 @@ void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
 	siginfo_t info;
 	unsigned int si_code = 0;
 
+	if (__ipipe_report_trap(IPIPE_TRAP_FPU_EXC, regs))
+		return;
+
 	if (esr & FPEXC_IOF)
 		si_code = FPE_FLTINV;
 	else if (esr & FPEXC_DZF)
@@ -135,7 +142,7 @@ void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
 	send_sig_info(SIGFPE, &info, current);
 }
 
-void fpsimd_thread_switch(struct task_struct *next)
+static void fpsimd_root_save(void)
 {
 	if (!system_supports_fpsimd())
 		return;
@@ -146,7 +153,10 @@ void fpsimd_thread_switch(struct task_struct *next)
 	 */
 	if (current->mm && !test_thread_flag(TIF_FOREIGN_FPSTATE))
 		fpsimd_save_state(&current->thread.fpsimd_state);
+}
 
+static void fpsimd_root_restore(struct task_struct *next)
+{
 	if (next->mm) {
 		/*
 		 * If we are switching to a task whose most recent userland
@@ -162,23 +172,112 @@ void fpsimd_thread_switch(struct task_struct *next)
 			clear_ti_thread_flag(task_thread_info(next),
 					     TIF_FOREIGN_FPSTATE);
 		else
+#ifdef CONFIG_IPIPE
+		{
+			fpsimd_load_state(st);
+			__this_cpu_write(fpsimd_last_state, st);
+			st->cpu = raw_smp_processor_id();
+		}
+#else
 			set_ti_thread_flag(task_thread_info(next),
 					   TIF_FOREIGN_FPSTATE);
+#endif
+	}
+}
+
+#if defined(CONFIG_IPIPE) || defined(CONFIG_KERNEL_MODE_NEON)
+DEFINE_PER_CPU(bool, kernel_neon_busy);
+#endif
+
+#if defined(CONFIG_IPIPE) || defined(CONFIG_EFI)
+static DEFINE_PER_CPU(bool, efi_fpsimd_state_used);
+#endif
+
+#ifdef CONFIG_IPIPE
+static DEFINE_PER_CPU(struct fpsimd_state, fpsimd_kernel_state);
+static DEFINE_PER_CPU(struct fpsimd_state, fpsimd_foreign_state);
+
+static void fpsimd_do_save(void)
+{
+	struct fpsimd_state *st;
+
+	if (__ipipe_root_p) {
+		fpsimd_root_save();
+	} else {
+		st = &current->thread.fpsimd_state;
+
+		if (__this_cpu_read(kernel_neon_busy) ||
+		    __this_cpu_read(efi_fpsimd_state_used))
+			st = this_cpu_ptr(&fpsimd_kernel_state);
+
+		if (test_thread_flag(TIF_FOREIGN_FPSTATE))
+			 st = this_cpu_ptr(&fpsimd_foreign_state);
+
+		fpsimd_save_state(st);
+	}
+}
+
+static void fpsimd_do_restore(struct task_struct *next)
+{
+	struct fpsimd_state *st;
+
+	if (__ipipe_root_p) {
+		fpsimd_root_restore(next);
+	} else {
+		st = &next->thread.fpsimd_state;
+
+		if (__this_cpu_read(kernel_neon_busy) ||
+		    __this_cpu_read(efi_fpsimd_state_used))
+			st = this_cpu_ptr(&fpsimd_kernel_state);
+
+		if (test_ti_thread_flag(task_thread_info(next),
+		    TIF_FOREIGN_FPSTATE))
+			st = this_cpu_ptr(&fpsimd_foreign_state);
+
+		fpsimd_load_state(st);
+		st->cpu = raw_smp_processor_id();
+		__this_cpu_write(fpsimd_last_state, NULL);
 	}
 }
 
+#else  /* !CONFIG_IPIPE */
+
+static void fpsimd_do_save(void)
+{
+	fpsimd_root_save();
+}
+
+static void fpsimd_do_restore(struct task_struct *next)
+{
+	fpsimd_root_restore(next);
+}
+
+#endif  /* CONFIG_IPIPE */
+
+void fpsimd_thread_switch(struct task_struct *next)
+{
+	unsigned long flags;
+
+	flags = hard_local_irq_save();
+	fpsimd_do_save();
+	fpsimd_do_restore(next);
+	hard_local_irq_restore(flags);
+}
+
 void fpsimd_flush_thread(void)
 {
+	unsigned long flags;
+
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	flags = hard_preempt_disable();
 
 	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
 	fpsimd_flush_task_state(current);
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 
-	local_bh_enable();
+	hard_preempt_enable(flags);
 }
 
 /*
@@ -187,15 +286,15 @@ void fpsimd_flush_thread(void)
  */
 void fpsimd_preserve_current_state(void)
 {
+	unsigned long flags;
+
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
-
+	flags = hard_preempt_disable();
 	if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
 		fpsimd_save_state(&current->thread.fpsimd_state);
-
-	local_bh_enable();
+	hard_preempt_enable(flags);
 }
 
 /*
@@ -205,10 +304,12 @@ void fpsimd_preserve_current_state(void)
  */
 void fpsimd_restore_current_state(void)
 {
+	unsigned long flags;
+
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	flags = hard_preempt_disable();
 
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		struct fpsimd_state *st = &current->thread.fpsimd_state;
@@ -218,7 +319,7 @@ void fpsimd_restore_current_state(void)
 		st->cpu = smp_processor_id();
 	}
 
-	local_bh_enable();
+	hard_preempt_enable(flags);
 }
 
 /*
@@ -228,10 +329,12 @@ void fpsimd_restore_current_state(void)
  */
 void fpsimd_update_current_state(struct fpsimd_state *state)
 {
+	unsigned long flags;
+
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	flags = hard_preempt_disable();
 
 	fpsimd_load_state(state);
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
@@ -241,7 +344,7 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
 		st->cpu = smp_processor_id();
 	}
 
-	local_bh_enable();
+	hard_preempt_enable(flags);
 }
 
 /*
@@ -254,7 +357,6 @@ void fpsimd_flush_task_state(struct task_struct *t)
 
 #ifdef CONFIG_KERNEL_MODE_NEON
 
-DEFINE_PER_CPU(bool, kernel_neon_busy);
 EXPORT_PER_CPU_SYMBOL(kernel_neon_busy);
 
 /*
@@ -276,11 +378,15 @@ EXPORT_PER_CPU_SYMBOL(kernel_neon_busy);
  */
 void kernel_neon_begin(void)
 {
+	unsigned long flags;
+
 	if (WARN_ON(!system_supports_fpsimd()))
 		return;
 
 	BUG_ON(!may_use_simd());
 
+	flags = hard_preempt_disable();
+
 	local_bh_disable();
 
 	__this_cpu_write(kernel_neon_busy, true);
@@ -292,7 +398,7 @@ void kernel_neon_begin(void)
 	/* Invalidate any task state remaining in the fpsimd regs: */
 	__this_cpu_write(fpsimd_last_state, NULL);
 
-	preempt_disable();
+	hard_local_irq_restore(flags);
 
 	local_bh_enable();
 }
@@ -310,21 +416,23 @@ EXPORT_SYMBOL(kernel_neon_begin);
 void kernel_neon_end(void)
 {
 	bool busy;
+	unsigned long flags;
 
 	if (!system_supports_fpsimd())
 		return;
 
+	flags = hard_local_irq_save();
 	busy = __this_cpu_xchg(kernel_neon_busy, false);
 	WARN_ON(!busy);	/* No matching kernel_neon_begin()? */
 
-	preempt_enable();
+	hard_preempt_enable(flags);
+	hard_local_irq_enable();
 }
 EXPORT_SYMBOL(kernel_neon_end);
 
 #ifdef CONFIG_EFI
 
 static DEFINE_PER_CPU(struct fpsimd_state, efi_fpsimd_state);
-static DEFINE_PER_CPU(bool, efi_fpsimd_state_used);
 
 /*
  * EFI runtime services support functions
-- 
2.14.4


