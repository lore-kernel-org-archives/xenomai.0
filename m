Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607621D6DA3
	for <xenomai@lists.linux.dev>; Wed, 19 Feb 2025 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739974711; cv=none; b=tLQ8j99pZYueGyWOjB35qLrexoAZgg4cLCX5R+IfYNgnjOvjLxi6kVL0g0NqPxdxrTIz0NlMd3tQcfHzbpNMgWWy94ZCrYOUy3a/8tSqz/EeoXh5a6WGNHSS9v3gx7jnVAu05V+rG7lwiBueJxz+mjOPdu/Ddjj2UbQ0tS/xmp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739974711; c=relaxed/simple;
	bh=/5IHDkqmeX2++qtPSDF/u+bet6DO/GBW6jEjaLark6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mvonfvid3z1wE5FIC7iu06xLkI6c3CniDg1VXcPOB18ahtHnl7t7sL8nxyXr/M7ynX/aYA8QOP09OtTPzc2HKLEWTYLfRXIO1FuzcX7qT7P02eEp663olaN8yUl1X+GB7Fg7AgorcSpqZ5LfIVBpgNSCb6cRRS1ugO+emErSiCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=IEQWaQFg; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="IEQWaQFg"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250219141816db97d0e2cc61e848cd
        for <xenomai@lists.linux.dev>;
        Wed, 19 Feb 2025 15:18:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=kPoMru/yVhIvi0MJJMwk4lxEW34NmrkXZC1p3Z3YLIg=;
 b=IEQWaQFg7wd3iZ/S3TWJO6YPe/zMZB88YFk3YJHIyyFLBZH/I+8WoEE8RmfZvMvNjvDTIs
 9aE6RTsZSv7zPESfuhu1qAQxlL6UOO1Ew0qfaqlLf5XgpCe7+ueocGebNc2r8GTxZAxkR+kI
 Z5nCrhLoDnBXgYfhcPflyQY1LCVCEmAwqEVV3vuIerwsiF405WKzRhumqgduwSwKHPryFon5
 6xIkDjY6KOS094UGiUVoeNFmstlxPUGX2wHFZavhtqcgTO/NgvH/3mbSkbKZq7SwcF91WhdV
 gnMXgCMppIC8iajnXvZYHUv9h81XkK1Nncd3JYITx8LzGWB927VB7leg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
	powertree <powertree@163.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH Dovetail] arm64: fpsimd: dovetail: Allow preemption of in-band fpsimd kernel sections
Date: Wed, 19 Feb 2025 15:17:59 +0100
Message-Id: <20250219141759.2455053-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Preemption of in-band in-kernel fpsimd sections was not allowed /
properly implemented in Dovetail up to now.

That piled up again as some crypto code was optimized for arm64 in
Linux 6.14. A possible call stack that makes clear that the FPU was
corrupted follows. The inband stage was using crypto/FPU code inside
the kernel and got interrupted by OOB.

	[  331.703695]  task_fpsimd_load+0xd0/0x214 (P)
	[  331.703713]  fpsimd_restore_current_state+0x9c/0xb8
	[  331.703732]  fpsimd_restore_current_oob+0x1c/0x2c
	[  331.703751]  dovetail_context_switch+0x90/0x180
	[  331.703769]  pipeline_switch_to+0x10/0x1c
	[  331.703792]  ___xnsched_run+0x1bc/0x29c
	[  331.703811]  run_oob_call+0x98/0x17c
	[  331.703830]  handle_irq_pipelined_finish+0x1e0/0x1ec
	[  331.703848]  handle_irq_pipelined+0x58/0x6c
	[  331.703865]  call_on_irq_stack+0x24/0x4c
	[  331.703884]  do_interrupt_handler+0x150/0x178
	[  331.703902]  el1_interrupt+0x44/0x11c
	[  331.703921]  el1h_64_irq_handler+0x18/0x24
	[  331.703941]  el1h_64_irq+0x6c/0x70                <- oob
	[  331.703957]  crc32c_le_arm64_4way+0x4c/0xc0 (P)   <- inband
	[  331.703978]  ext4_block_bitmap_csum_set+0x38/0x60
	[  331.704002]  ext4_mb_mark_context+0x1b0/0x398
	[  331.704025]  ext4_mb_mark_diskspace_used+0xd8/0x1f8

To fix that we have to hook into the task switch as we do on x86 and
invoke the FPU (re)store logic.

Cc: powertree <powertree@163.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm64/include/asm/dovetail.h    | 10 +++++++--
 arch/arm64/include/asm/fpsimd.h      |  7 +++++-
 arch/arm64/include/asm/thread_info.h |  1 +
 arch/arm64/kernel/fpsimd.c           | 33 ++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/dovetail.h b/arch/arm64/include/asm/dovetail.h
index dc46f131e3eb..8cd359710353 100644
--- a/arch/arm64/include/asm/dovetail.h
+++ b/arch/arm64/include/asm/dovetail.h
@@ -26,11 +26,17 @@ static inline void arch_dovetail_exec_prepare(void)
 { }
 
 static inline void arch_dovetail_switch_prepare(bool leave_inband)
-{ }
+{
+	if (leave_inband)
+		fpsimd_suspend_inband();
+}
 
 static inline void arch_dovetail_switch_finish(bool enter_inband)
 {
-	fpsimd_restore_current_oob();
+	if (enter_inband)
+		fpsimd_resume_inband();
+	else
+		fpsimd_restore_current_oob();
 }
 
 /*
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 8e12d5be076e..1ba7b75b2277 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -79,10 +79,15 @@ extern void fpsimd_flush_thread(void);
 extern void fpsimd_signal_preserve_current_state(void);
 extern void fpsimd_preserve_current_state(void);
 extern void fpsimd_restore_current_state(void);
-extern void fpsimd_restore_current_oob(void);
 extern void fpsimd_update_current_state(struct user_fpsimd_state const *state);
 extern void fpsimd_kvm_prepare(void);
 
+#ifdef CONFIG_DOVETAIL
+extern void fpsimd_restore_current_oob(void);
+extern void fpsimd_suspend_inband(void);
+extern void fpsimd_resume_inband(void);
+#endif
+
 struct cpu_fp_state {
 	struct user_fpsimd_state *st;
 	void *sve_state;
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 3028a8f294c2..8ee08fd30d8c 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -76,6 +76,7 @@ void arch_setup_new_exec(void);
 #define TIF_SECCOMP		11	/* syscall secure computing */
 #define TIF_SYSCALL_EMU		12	/* syscall emulation active */
 #define TIF_MAYDAY		13	/* Emergency trap pending */
+#define TIF_KERNEL_FP_PREEMPTED	14	/* Dovetail: kernel mode FPSIMD section preempted by OOB */
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_FREEZE		19
 #define TIF_RESTORE_SIGMASK	20
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 96f2f60b4caa..032234593d6e 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -2240,6 +2240,39 @@ void cpu_enable_fpsimd(const struct arm64_cpu_capabilities *__always_unused p)
 	isb();
 }
 
+#ifdef CONFIG_DOVETAIL
+
+/*
+ * Holds the in-kernel fpu state when preempted by a task running on the
+ * out-of-band stage.
+ */
+static DEFINE_PER_CPU(struct user_fpsimd_state, in_kernel_fpstate);
+
+void fpsimd_suspend_inband(void)
+{
+	struct user_fpsimd_state *kfpu = this_cpu_ptr(&in_kernel_fpstate);
+
+	/*
+	 * If TIF_KERNEL_FPSTATE is set, we are dealing with the preemption of an
+	 * inband kernel context currently using the fpu by a thread which resumes
+	 * on the oob stage.
+	 */
+	if (test_thread_flag(TIF_KERNEL_FPSTATE)) {
+		fpsimd_save_state(kfpu);
+		set_thread_flag(TIF_KERNEL_FP_PREEMPTED);
+	}
+}
+
+void fpsimd_resume_inband(void)
+{
+	struct user_fpsimd_state *kfpu = this_cpu_ptr(&in_kernel_fpstate);
+
+	if (test_and_clear_thread_flag(TIF_KERNEL_FP_PREEMPTED))
+		fpsimd_load_state(kfpu);
+}
+
+#endif
+
 /*
  * FP/SIMD support code initialisation.
  */
-- 
2.39.5

