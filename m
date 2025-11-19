Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D61A2D73AB
	for <xenomai@lists.linux.dev>; Wed, 19 Nov 2025 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562335; cv=none; b=sM/YcjLplsiQswZDzLlrDTQt8UFeFAqlXl69vKL0kqL/ELvwjQzg21eDva9viT4s7OLvQ/6PikqkkzS1Zkj+uPFykOS46PkAIBkDLyp3HSUjsOZIuE+eFToarbcQK0/psJdvWV0j36jeDPNkxybVhFnxVKixtmh52yOGiWeAOh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562335; c=relaxed/simple;
	bh=aGWMeHau21CtBkKVIfFZor7ehM0Hh28YvTTIVj7bYbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VikPjE+qfhMJNVrvp37lWy4J2UGPHcT/8B9OAb6bCRJBIOOijPiNrWoAzlCfW189S2UzW1gJhQqWAXPyahT/XvYdmtCOn+PlHEqTnyceoQFTogAKwbM7n5UkrDhMz1Eh40NLLdGx9Bvu8MEX9uXLIHufkxbzP7vGAjdX1FKQvIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=DtUkpi8P; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="DtUkpi8P"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2025111914252231b8d130a7000207c5
        for <xenomai@lists.linux.dev>;
        Wed, 19 Nov 2025 15:25:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EtfgSClWjeQIB8saidg7cl854XudavW0RhsC3pS6b+c=;
 b=DtUkpi8PII51OR1pR99KtZlbg49QEs2bJb+i6ALKo3UsPjn/09wxNrY7VJhfWUfLm+pNBi
 gF6N6MlSPbggGjNDiWeZUU7FjJTKkotTic56FWDa3pl9W2vrIhYbLhxWFTDN4ip22pccESiS
 q92A9kp95LUCR5nAULIf1xqL6U1ORZwJZ8pr3Wgtq5DEDd8o9FXr6bXFBQaJb6VoBDKRZAew
 LOjw4tBZcVMnuiM4BPLefxuevHt06LaxHwi9crjidosoBa71ye3wpe+6RiCeEREGASRyf9eM
 zO4eQ9W/TagpqbAUzRbkmROjM5fpU8PzGRgXNhiCHJz33XCOEY+noORw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 19 Nov 2025 15:25:19 +0100
Subject: [PATCH RFC Dovetail 6.1 1/3] arm64: fpsimd: Drop unneeded 'busy'
 flag
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-1-8653c0b573fd@siemens.com>
References: <20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-0-8653c0b573fd@siemens.com>
In-Reply-To: <20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-0-8653c0b573fd@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

[ Backport of commit 9b19700e623f ("arm64: fpsimd: Drop unneeded 'busy' flag") ]

Kernel mode NEON will preserve the user mode FPSIMD state by saving it
into the task struct before clobbering the registers. In order to avoid
the need for preserving kernel mode state too, we disallow nested use of
kernel mode NEON, i..e, use in softirq context while the interrupted
task context was using kernel mode NEON too.

Originally, this policy was implemented using a per-CPU flag which was
exposed via may_use_simd(), requiring the users of the kernel mode NEON
to deal with the possibility that it might return false, and having NEON
and non-NEON code paths. This policy was changed by commit
13150149aa6ded1 ("arm64: fpsimd: run kernel mode NEON with softirqs
disabled"), and now, softirq processing is disabled entirely instead,
and so may_use_simd() can never fail when called from task or softirq
context.

This means we can drop the fpsimd_context_busy flag entirely, and
instead, ensure that we disable softirq processing in places where we
formerly relied on the flag for preventing races in the FPSIMD preserve
routines.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231208113218.3001940-7-ardb@google.com
[will: Folded in fix from CAMj1kXFhzbJRyWHELCivQW1yJaF=p07LLtbuyXYX3G1WtsdyQg@mail.gmail.com]
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm64/include/asm/simd.h | 11 +--------
 arch/arm64/kernel/fpsimd.c    | 53 +++++++++----------------------------------
 2 files changed, 12 insertions(+), 52 deletions(-)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index 6a75d7ecdcaa2..8e86c9e70e483 100644
--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -12,8 +12,6 @@
 #include <linux/preempt.h>
 #include <linux/types.h>
 
-DECLARE_PER_CPU(bool, fpsimd_context_busy);
-
 #ifdef CONFIG_KERNEL_MODE_NEON
 
 /*
@@ -28,17 +26,10 @@ static __must_check inline bool may_use_simd(void)
 	/*
 	 * We must make sure that the SVE has been initialized properly
 	 * before using the SIMD in kernel.
-	 * fpsimd_context_busy is only set while preemption is disabled,
-	 * and is clear whenever preemption is enabled. Since
-	 * this_cpu_read() is atomic w.r.t. preemption, fpsimd_context_busy
-	 * cannot change under our feet -- if it's set we cannot be
-	 * migrated, and if it's clear we cannot be migrated to a CPU
-	 * where it is set.
 	 */
 	return !WARN_ON(!system_capabilities_finalized()) &&
 	       system_supports_fpsimd() &&
-	       !in_hardirq() && !irqs_disabled() && !in_nmi() &&
-	       !this_cpu_read(fpsimd_context_busy);
+	       !in_hardirq() && !irqs_disabled() && !in_nmi();
 }
 
 #else /* ! CONFIG_KERNEL_MODE_NEON */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 0b5c2af07d82a..ab429ff629204 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -85,13 +85,13 @@
  * softirq kicks in. Upon vcpu_put(), KVM will save the vcpu FP state and
  * flag the register state as invalid.
  *
- * In order to allow softirq handlers to use FPSIMD, kernel_neon_begin() may
- * save the task's FPSIMD context back to task_struct from softirq context.
- * To prevent this from racing with the manipulation of the task's FPSIMD state
- * from task context and thereby corrupting the state, it is necessary to
- * protect any manipulation of a task's fpsimd_state or TIF_FOREIGN_FPSTATE
- * flag with {, __}get_cpu_fpsimd_context(). This will still allow softirqs to
- * run but prevent them to use FPSIMD.
+ * In order to allow softirq handlers to use FPSIMD, kernel_neon_begin() may be
+ * called from softirq context, which will save the task's FPSIMD context back
+ * to task_struct. To prevent this from racing with the manipulation of the
+ * task's FPSIMD state from task context and thereby corrupting the state, it
+ * is necessary to protect any manipulation of a task's fpsimd_state or
+ * TIF_FOREIGN_FPSTATE flag with get_cpu_fpsimd_context(), which will suspend
+ * softirq servicing entirely until put_cpu_fpsimd_context() is called.
  *
  * For a certain task, the sequence may look something like this:
  * - the task gets scheduled in; if both the task's fpsimd_cpu field
@@ -219,36 +219,17 @@ static inline void sme_free(struct task_struct *t) { }
 
 #endif
 
-DEFINE_PER_CPU(bool, fpsimd_context_busy);
-EXPORT_PER_CPU_SYMBOL(fpsimd_context_busy);
-
 static void fpsimd_bind_task_to_cpu(void);
 
-static void __get_cpu_fpsimd_context(void)
-{
-	bool busy = __this_cpu_xchg(fpsimd_context_busy, true);
-
-	WARN_ON(busy);
-}
-
-static void __put_cpu_fpsimd_context(void)
-{
-	bool busy = __this_cpu_xchg(fpsimd_context_busy, false);
-
-	WARN_ON(!busy); /* No matching get_cpu_fpsimd_context()? */
-}
-
 #ifdef CONFIG_DOVETAIL
 
 #define get_cpu_fpsimd_context(__flags)			\
 	do {						\
 		(__flags) = hard_preempt_disable();	\
-		__get_cpu_fpsimd_context();		\
 	} while (0)
 
 #define put_cpu_fpsimd_context(__flags)			\
 	do {						\
-		__put_cpu_fpsimd_context();		\
 		hard_preempt_enable(__flags);		\
 	} while (0)
 
@@ -273,9 +254,6 @@ void fpsimd_restore_current_oob(void)
  * The caller may freely manipulate the FPSIMD context metadata until
  * put_cpu_fpsimd_context() is called.
  *
- * The double-underscore version must only be called if you know the task
- * can't be preempted.
- *
  * On RT kernels local_bh_disable() is not sufficient because it only
  * serializes soft interrupt related sections via a local lock, but stays
  * preemptible. Disabling preemption is the right choice here as bottom
@@ -288,7 +266,6 @@ void fpsimd_restore_current_oob(void)
 			local_bh_disable();		\
 		else					\
 			preempt_disable();		\
-		__get_cpu_fpsimd_context();		\
 		(void)(__flags);			\
 	} while (0)
 
@@ -301,7 +278,6 @@ void fpsimd_restore_current_oob(void)
  */
 #define put_cpu_fpsimd_context(__flags)			\
 	do {						\
-		__put_cpu_fpsimd_context();		\
 		if (!IS_ENABLED(CONFIG_PREEMPT_RT))	\
 			local_bh_enable();		\
 		else					\
@@ -311,11 +287,6 @@ void fpsimd_restore_current_oob(void)
 
 #endif	/* !CONFIG_DOVETAIL */
 
-static bool have_cpu_fpsimd_context(void)
-{
-	return !preemptible() && __this_cpu_read(fpsimd_context_busy);
-}
-
 unsigned int task_get_vl(const struct task_struct *task, enum vec_type type)
 {
 	return task->thread.vl[type];
@@ -426,7 +397,8 @@ static void task_fpsimd_load(void)
 	bool restore_ffr;
 
 	WARN_ON(!system_supports_fpsimd());
-	WARN_ON(!hard_irqs_disabled() && !have_cpu_fpsimd_context());
+	WARN_ON(preemptible());
+	WARN_ON(dovetail_debug() && !hard_irqs_disabled());
 
 	/* Check if we should restore SVE first */
 	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE)) {
@@ -485,7 +457,8 @@ static void __fpsimd_save(void)
 	unsigned int vl;
 
 	WARN_ON(!system_supports_fpsimd());
-	WARN_ON(!hard_irqs_disabled() && !have_cpu_fpsimd_context());
+	WARN_ON(preemptible());
+	WARN_ON(dovetail_debug() && !hard_irqs_disabled());
 
 	if (test_thread_flag(TIF_FOREIGN_FPSTATE))
 		return;
@@ -1629,8 +1602,6 @@ void fpsimd_thread_switch(struct task_struct *next)
 
 	flags = hard_cond_local_irq_save();
 
-	__get_cpu_fpsimd_context();
-
 	/* Save unsaved fpsimd state, if any: */
 	__fpsimd_save();
 
@@ -1646,8 +1617,6 @@ void fpsimd_thread_switch(struct task_struct *next)
 	update_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE,
 			       wrong_task || wrong_cpu);
 
-	__put_cpu_fpsimd_context();
-
 	hard_cond_local_irq_restore(flags);
 }
 

-- 
2.39.5

