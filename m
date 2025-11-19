Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DB636C5A4
	for <xenomai@lists.linux.dev>; Wed, 19 Nov 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562335; cv=none; b=oL/PuigJmHBtk5lEmixXjTStZVrGYusanV2metU0Ms7UlcdRp9WA9rEqlpT17TqUXnPFWzoxtgOXu2OH0S82/BsVv5+zBkdX8CCLRwI/0i3/xjT+ue4GT+eSG2LSOPTsphHSf+KpyL5xOSM0zMoO0gwlvHfppKN9rjixHT9I3zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562335; c=relaxed/simple;
	bh=LP/YZhlufh74SDffbGVvL0kZxQa6AvMp9v0iehzVb4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qzvJxbIo1SfZ8ft0D18DPxHssXaa3uH8mxweeuLuLJKBR/KCA2gQ76I52EFSj9wO8WOlmiqJTRiUT61JP3JMPqCUgxUlJkdmYVzQxCqmFYzNe3lCBu2cj7AMoq7vU9NStjniUnibgu0InNY0Vhi7WzL+0nSpydUQp7sYS+fEScA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=NAcIWK9N; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="NAcIWK9N"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2025111914252346d51a61df000207af
        for <xenomai@lists.linux.dev>;
        Wed, 19 Nov 2025 15:25:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=AkKMpqUn/7WExGxXbPjJoz05G1q6cQi9Wkx3jZF9pUM=;
 b=NAcIWK9NVDuy/fzsU7pIqhkTXIQSvdKulhkCmYp6Xi2tilu4gCA6zuPtnNzBuKbUM88clI
 VdwUCXHXcKP5f1ki5ojKMjvXFXv3woL404xPanXURXv5LVubPG8DDBdSZDr4hSgJcfGbZqMC
 GTeshB+xXX8sea8dRdeMZ4Mwvg4NkB8aSzjEQGoGtQBxZ1SFglQPsnuCrLdebQHu/QPXgxDM
 OZ3kweYC3OLWW5yzhcbW/2RVLeGCMEfYHHY5Nlm9XgF2ssPkyYuIP3xQQ/VxaiD9EWpkSlCY
 yJpcFNTww/axk9Ccd4657T3qivDpY6m5DMkp6RAqxLicWCCAyjOnvSMQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 19 Nov 2025 15:25:21 +0100
Subject: [PATCH RFC Dovetail 6.1 3/3] arm64/fpsimd: Avoid erroneous elide
 of user state reload
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-3-8653c0b573fd@siemens.com>
References: <20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-0-8653c0b573fd@siemens.com>
In-Reply-To: <20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-0-8653c0b573fd@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

[ Backport of commit e92bee9f861b ("arm64/fpsimd: Avoid erroneous elide
of user state reload") ]

TIF_FOREIGN_FPSTATE is a 'convenience' flag that should reflect whether
the current CPU holds the most recent user mode FP/SIMD state of the
current task. It combines two conditions:
- whether the current CPU's FP/SIMD state belongs to the task;
- whether that state is the most recent associated with the task (as a
  task may have executed on other CPUs as well).

When a task is scheduled in and TIF_KERNEL_FPSTATE is set, it means the
task was in a kernel mode NEON section when it was scheduled out, and so
the kernel mode FP/SIMD state is restored. Since this implies that the
current CPU is *not* holding the most recent user mode FP/SIMD state of
the current task, the TIF_FOREIGN_FPSTATE flag is set too, so that the
user mode FP/SIMD state is reloaded from memory when returning to
userland.

However, the task may be scheduled out after completing the kernel mode
NEON section, but before returning to userland. When this happens, the
TIF_FOREIGN_FPSTATE flag will not be preserved, but will be set as usual
the next time the task is scheduled in, and will be based on the above
conditions.

This means that, rather than setting TIF_FOREIGN_FPSTATE when scheduling
in a task with TIF_KERNEL_FPSTATE set, the underlying state should be
updated so that TIF_FOREIGN_FPSTATE will assume the expected value as a
result.

So instead, call fpsimd_flush_cpu_state(), which takes care of this.

Closes: https://lore.kernel.org/all/cb8822182231850108fa43e0446a4c7f@kernel.org
Reported-by: Johannes Nixdorf <mixi@shadowice.org>
Fixes: aefbab8e77eb ("arm64: fpsimd: Preserve/restore kernel mode NEON at context switch")
Cc: Mark Brown <broonie@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Janne Grunau <j@jannau.net>
Cc: stable@vger.kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Janne Grunau <j@jannau.net>
Tested-by: Johannes Nixdorf <mixi@shadowice.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20240522091335.335346-2-ardb+git@google.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm64/kernel/fpsimd.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 4635c5592a236..aabe468e74c46 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1603,6 +1603,27 @@ static void fpsimd_save_kernel_state(struct task_struct *task)
 	fpsimd_save_state(&task->thread.kernel_fpsimd_state);
 }
 
+/*
+ * Invalidate any task's FPSIMD state that is present on this cpu.
+ * The FPSIMD context should be acquired with get_cpu_fpsimd_context()
+ * before calling this function.
+ */
+static void fpsimd_flush_cpu_state(void)
+{
+	WARN_ON(!system_supports_fpsimd());
+	__this_cpu_write(fpsimd_last_state.st, NULL);
+
+	/*
+	 * Leaving streaming mode enabled will cause issues for any kernel
+	 * NEON and leaving streaming mode or ZA enabled may increase power
+	 * consumption.
+	 */
+	if (system_supports_sme())
+		sme_smstop();
+
+	set_thread_flag(TIF_FOREIGN_FPSTATE);
+}
+
 void fpsimd_thread_switch(struct task_struct *next)
 {
 	bool wrong_task, wrong_cpu;
@@ -1621,7 +1642,7 @@ void fpsimd_thread_switch(struct task_struct *next)
 
 	if (test_tsk_thread_flag(next, TIF_KERNEL_FPSTATE)) {
 		fpsimd_load_kernel_state(next);
-		set_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE);
+		fpsimd_flush_cpu_state();
 	} else {
 		/*
 		 * Fix up TIF_FOREIGN_FPSTATE to correctly describe next's
@@ -1910,27 +1931,6 @@ void fpsimd_flush_task_state(struct task_struct *t)
 	barrier();
 }
 
-/*
- * Invalidate any task's FPSIMD state that is present on this cpu.
- * The FPSIMD context should be acquired with get_cpu_fpsimd_context()
- * before calling this function.
- */
-static void fpsimd_flush_cpu_state(void)
-{
-	WARN_ON(!system_supports_fpsimd());
-	__this_cpu_write(fpsimd_last_state.st, NULL);
-
-	/*
-	 * Leaving streaming mode enabled will cause issues for any kernel
-	 * NEON and leaving streaming mode or ZA enabled may increase power
-	 * consumption.
-	 */
-	if (system_supports_sme())
-		sme_smstop();
-
-	set_thread_flag(TIF_FOREIGN_FPSTATE);
-}
-
 /*
  * Save the FPSIMD state to memory and invalidate cpu view.
  * This function must be called with preemption disabled.

-- 
2.39.5

