Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666F4242D65
	for <xenomai@lists.linux.dev>; Wed, 19 Nov 2025 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562939; cv=none; b=ndvDd912OCWF9091E3H4o1/T9H1dv8F9Xb/mCW9YIkYDI6cyOnRW27n3AKP1QH0dLzvnx0FrVaJOoPOw/1alhVPjngCzZYfKeCH84DnBcxpTAPNnifR2Lq1OMzqgTaLKtE4kuwB8JjS/8V0huBXgwnftbu/SNGAvBnDdHBwHj/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562939; c=relaxed/simple;
	bh=e2TYUnyJKHFw5jwgfI2p+DMveTGEN7sIKoB+VjqZR68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9YqnMRyZ9WpQNsDB+JgFHYJkm+XNDqYG7sgeMbuBnftaIeyr+QCqnyU4ZFlieE4J+XMVblbyjixKvzXA8CX2hJJcj6mSnR/zp9YszoF2nJFlXppLNTXYqVmmz3udN/x7ssxeKVRfD08b3XGoT6U8f6jY0MVbB+lWjVmtmI1aRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=XLK7rNA+; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="XLK7rNA+"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025111914252355159ad3d0000207cd
        for <xenomai@lists.linux.dev>;
        Wed, 19 Nov 2025 15:25:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nHZx+n1Ci0hxtAOmDfincXtHErV9yHdtXeCgDOszccI=;
 b=XLK7rNA+B5e0UllxZTkCUrAsTk51D6ANESF5PgK0W/LSjNj/RoBLetVKXhHKFo2ZCcI1sg
 M7sEC4pxp7isZSQoacyOQV3ulN6diTJrho+hm8ixaLQMo4S02d/gqX3T+vWjMBc8m/UyVul3
 SS7OqFhf5gWWTvWcMfFsre3dychxxBxQvY/G4t3JQGgqgg1cCo4gZXIea0WnGYKTTDh+B1t1
 gOskoXpnOocYNmlkzBE6h1V8M1NZ1Y8YaPvsj60G3iIcW/pEm8Qz+x+NnTEm2kADiFdpnP/B
 ZuQTSigRzvreAcnYs5gnqkjvBrZnVZepDnVMXLLwzKENVP69dP+KQkuQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 19 Nov 2025 15:25:20 +0100
Subject: [PATCH RFC Dovetail 6.1 2/3] arm64: fpsimd: Preserve/restore
 kernel mode NEON at context switch
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-2-8653c0b573fd@siemens.com>
References: <20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-0-8653c0b573fd@siemens.com>
In-Reply-To: <20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-0-8653c0b573fd@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

[ Backport of commit aefbab8e77eb ("arm64: fpsimd: Preserve/restore kernel mode
NEON at context switch") ]

Currently, the FPSIMD register file is not preserved and restored along
with the general registers on exception entry/exit or context switch.
For this reason, we disable preemption when enabling FPSIMD for kernel
mode use in task context, and suspend the processing of softirqs so that
there are no concurrent uses in the kernel. (Kernel mode FPSIMD may not
be used at all in other contexts).

Disabling preemption while doing CPU intensive work on inputs of
potentially unbounded size is bad for real-time performance, which is
why we try and ensure that SIMD crypto code does not operate on more
than ~4k at a time, which is an arbitrary limit and requires assembler
code to implement efficiently.

We can avoid the need for disabling preemption if we can ensure that any
in-kernel users of the NEON will not lose the FPSIMD register state
across a context switch. And given that disabling softirqs implicitly
disables preemption as well, we will also have to ensure that a softirq
that runs code using FPSIMD can safely interrupt an in-kernel user.

So introduce a thread_info flag TIF_KERNEL_FPSTATE, and modify the
context switch hook for FPSIMD to preserve and restore the kernel mode
FPSIMD to/from struct thread_struct when it is set. This avoids any
scheduling blackouts due to prolonged use of FPSIMD in kernel mode,
without the need for manual yielding.

In order to support softirq processing while FPSIMD is being used in
kernel task context, use the same flag to decide whether the kernel mode
FPSIMD state needs to be preserved and restored before allowing FPSIMD
to be used in softirq context.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20231208113218.3001940-8-ardb@google.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm64/include/asm/processor.h   |  2 +
 arch/arm64/include/asm/thread_info.h |  3 +-
 arch/arm64/kernel/fpsimd.c           | 98 ++++++++++++++++++++++++++++--------
 3 files changed, 81 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 1b822e618bb4b..7e05173cbf133 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -167,6 +167,8 @@ struct thread_struct {
 	unsigned long		fault_address;	/* fault info */
 	unsigned long		fault_code;	/* ESR_EL1 value */
 	struct debug_info	debug;		/* debugging */
+
+	struct user_fpsimd_state	kernel_fpsimd_state;
 #ifdef CONFIG_ARM64_PTR_AUTH
 	struct ptrauth_keys_user	keys_user;
 #ifdef CONFIG_ARM64_PTR_AUTH_KERNEL
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 589a38b9b5fa3..f9693e04265aa 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -91,7 +91,8 @@ int arch_dup_task_struct(struct task_struct *dst,
 #define TIF_TAGGED_ADDR		26	/* Allow tagged user addresses */
 #define TIF_SME			27	/* SME in use */
 #define TIF_SME_VL_INHERIT	28	/* Inherit SME vl_onexec across exec */
-#define TIF_MAYDAY		29	/* Emergency trap pending */
+#define TIF_KERNEL_FPSTATE	29	/* Task is in a kernel mode FPSIMD section */
+#define TIF_MAYDAY		30	/* Emergency trap pending */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index ab429ff629204..4635c5592a236 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -398,6 +398,7 @@ static void task_fpsimd_load(void)
 
 	WARN_ON(!system_supports_fpsimd());
 	WARN_ON(preemptible());
+	WARN_ON(test_thread_flag(TIF_KERNEL_FPSTATE));
 	WARN_ON(dovetail_debug() && !hard_irqs_disabled());
 
 	/* Check if we should restore SVE first */
@@ -447,7 +448,7 @@ static void task_fpsimd_load(void)
  * than via current, if we are saving KVM state then it will have
  * ensured that the type of registers to save is set in last->to_save.
  */
-static void __fpsimd_save(void)
+static void fpsimd_save_user_state(void)
 {
 	struct fpsimd_last_state_struct const *last =
 		this_cpu_ptr(&fpsimd_last_state);
@@ -513,7 +514,7 @@ void fpsimd_save(void)
 	unsigned long flags;
 
 	flags = hard_cond_local_irq_save();
-	__fpsimd_save();
+	fpsimd_save_user_state();
 	hard_cond_local_irq_restore(flags);
 }
 
@@ -899,7 +900,7 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 	if (task == current) {
 		get_cpu_fpsimd_context(irqflags);
 
-		__fpsimd_save();
+		fpsimd_save_user_state();
 	}
 
 	fpsimd_flush_task_state(task);
@@ -1592,6 +1593,16 @@ void do_fpsimd_exc(unsigned long esr, struct pt_regs *regs)
 	mark_trap_exit(ARM64_TRAP_FPE, regs);
 }
 
+static void fpsimd_load_kernel_state(struct task_struct *task)
+{
+	fpsimd_load_state(&task->thread.kernel_fpsimd_state);
+}
+
+static void fpsimd_save_kernel_state(struct task_struct *task)
+{
+	fpsimd_save_state(&task->thread.kernel_fpsimd_state);
+}
+
 void fpsimd_thread_switch(struct task_struct *next)
 {
 	bool wrong_task, wrong_cpu;
@@ -1603,19 +1614,28 @@ void fpsimd_thread_switch(struct task_struct *next)
 	flags = hard_cond_local_irq_save();
 
 	/* Save unsaved fpsimd state, if any: */
-	__fpsimd_save();
+	if (test_thread_flag(TIF_KERNEL_FPSTATE))
+		fpsimd_save_kernel_state(current);
+	else
+		fpsimd_save_user_state();
 
-	/*
-	 * Fix up TIF_FOREIGN_FPSTATE to correctly describe next's
-	 * state.  For kernel threads, FPSIMD registers are never loaded
-	 * and wrong_task and wrong_cpu will always be true.
-	 */
-	wrong_task = __this_cpu_read(fpsimd_last_state.st) !=
-					&next->thread.uw.fpsimd_state;
-	wrong_cpu = next->thread.fpsimd_cpu != smp_processor_id();
+	if (test_tsk_thread_flag(next, TIF_KERNEL_FPSTATE)) {
+		fpsimd_load_kernel_state(next);
+		set_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE);
+	} else {
+		/*
+		 * Fix up TIF_FOREIGN_FPSTATE to correctly describe next's
+		 * state.  For kernel threads, FPSIMD registers are never
+		 * loaded with user mode FPSIMD state and so wrong_task and
+		 * wrong_cpu will always be true.
+		 */
+		wrong_task = __this_cpu_read(fpsimd_last_state.st) !=
+			&next->thread.uw.fpsimd_state;
+		wrong_cpu = next->thread.fpsimd_cpu != smp_processor_id();
 
-	update_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE,
-			       wrong_task || wrong_cpu);
+		update_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE,
+				       wrong_task || wrong_cpu);
+	}
 
 	hard_cond_local_irq_restore(flags);
 }
@@ -1710,7 +1730,7 @@ void fpsimd_preserve_current_state(void)
 		return;
 
 	get_cpu_fpsimd_context(flags);
-	__fpsimd_save();
+	fpsimd_save_user_state();
 	put_cpu_fpsimd_context(flags);
 }
 
@@ -1923,7 +1943,7 @@ void fpsimd_save_and_flush_cpu_state(void)
 		return;
 	WARN_ON(preemptible());
 	get_cpu_fpsimd_context(flags);
-	__fpsimd_save();
+	fpsimd_save_user_state();
 	fpsimd_flush_cpu_state();
 	put_cpu_fpsimd_context(flags);
 }
@@ -1959,13 +1979,37 @@ void kernel_neon_begin(void)
 	get_cpu_fpsimd_context(flags);
 
 	/* Save unsaved fpsimd state, if any: */
-	__fpsimd_save();
+	if (test_thread_flag(TIF_KERNEL_FPSTATE)) {
+		BUG_ON(IS_ENABLED(CONFIG_PREEMPT_RT) || !in_serving_softirq());
+		fpsimd_save_kernel_state(current);
+	} else {
+		fpsimd_save_user_state();
+
+		/*
+		 * Set the thread flag so that the kernel mode FPSIMD state
+		 * will be context switched along with the rest of the task
+		 * state.
+		 *
+		 * On non-PREEMPT_RT, softirqs may interrupt task level kernel
+		 * mode FPSIMD, but the task will not be preemptible so setting
+		 * TIF_KERNEL_FPSTATE for those would be both wrong (as it
+		 * would mark the task context FPSIMD state as requiring a
+		 * context switch) and unnecessary.
+		 *
+		 * On PREEMPT_RT, softirqs are serviced from a separate thread,
+		 * which is scheduled as usual, and this guarantees that these
+		 * softirqs are not interrupting use of the FPSIMD in kernel
+		 * mode in task context. So in this case, setting the flag here
+		 * is always appropriate.
+		 */
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) || !in_serving_softirq())
+			set_thread_flag(TIF_KERNEL_FPSTATE);
+	}
 
 	/* Invalidate any task state remaining in the fpsimd regs: */
 	fpsimd_flush_cpu_state();
 
-	if (dovetailing())
-		hard_cond_local_irq_restore(flags);
+	put_cpu_fpsimd_context(flags);
 }
 EXPORT_SYMBOL(kernel_neon_begin);
 
@@ -1985,7 +2029,19 @@ void kernel_neon_end(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	put_cpu_fpsimd_context(flags);
+	/*
+	 * If we are returning from a nested use of kernel mode FPSIMD, restore
+	 * the task context kernel mode FPSIMD state. This can only happen when
+	 * running in softirq context on non-PREEMPT_RT.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && in_serving_softirq() &&
+	    test_thread_flag(TIF_KERNEL_FPSTATE)) {
+		flags = hard_cond_local_irq_save();
+		fpsimd_load_kernel_state(current);
+		hard_cond_local_irq_restore(flags);
+	} else {
+		clear_thread_flag(TIF_KERNEL_FPSTATE);
+	}
 }
 EXPORT_SYMBOL(kernel_neon_end);
 
@@ -2179,7 +2235,7 @@ void fpsimd_suspend_inband(void)
 	 * inband kernel context currently using the fpu by a thread which resumes
 	 * on the oob stage.
 	 */
-	if (__this_cpu_read(fpsimd_context_busy)) {
+	if (test_thread_flag(TIF_KERNEL_FPSTATE)) {
 		fpsimd_save_state(kfpu);
 		set_thread_flag(TIF_KERNEL_FP_PREEMPTED);
 	}

-- 
2.39.5

