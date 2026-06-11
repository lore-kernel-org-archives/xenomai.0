Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245461DEFE8
	for <xenomai@lists.linux.dev>; Thu, 11 Jun 2026 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185887; cv=none; b=MlR5f2j8NuOO64QWlILWls58PV0Vf3jYoSaiU8SFoPCAXEaWaGBN2edXA9FKw6PGAuhTt/hE74B3BonuDHWOYJW3vrp6Pj6qOe49Kd5J6vp0bUnBt1zeEUASODlj96Il5VxxW7JkWOU3p/m4fwaeMjRDxsv8qeoV9gGlgUgm7uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185887; c=relaxed/simple;
	bh=RVxfeqSHhpkgFFhO8yDg1CvyNnoKk5M8PtVafr4gTJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KysiH3nPCk8dClrr0t59fTfZIGfhodVceBu/ghkyJzwba7FB0IoClzRkXrA4ULEbanIeXpuIMTH0IFeJfOUx8kqwIUSczL/uoLFj/1rOxDT4wuoRq0EYw94c0FGeMWFY2GMXNFIsxsrPd1Q5y43oMxNWRQJxA7gOtvLo3TRN+QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Etq8lfOQ; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Etq8lfOQ"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026061113410263566f49c50002070f
        for <xenomai@lists.linux.dev>;
        Thu, 11 Jun 2026 15:41:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=j5E3I+8JDRiJScI16gP4v32ICFAk2y+ZN1JCWUXIAgI=;
 b=Etq8lfOQJa/OiiOU7M9o7gJo/eSldbauNSYGIaP/9rxfRLFvjrHQMvTZ0qaIQVg/6oFrCR
 Ze9buU2rhPYsv7dOa9KGAhCIQIawWCRQmMzFr678nfFwxNWlcoFoJf6JJ0RdIji1TaDR/weC
 nh1zdW5OQOaWwwkI7XQX/SE38EDYC0UjKvUpCQVuGol420yOjUG+nw+G3GM/gcpoN74g0j3G
 OUS3TFqjVwBctjHIYJwrjGzQJgwS/qFm1qiFvxjJrEfQp1iKo3f5mRUMTHkPwLaYCd4wqVxs
 CMKa151owQmK2u7CVaimUKDwCSiQc3+ES4Sg2Y0par4ggOpcFtKGLswg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Philippe Gerum <rpm@xenomai.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH RFC Dovetail 7.1] arm64: irq_pipeline: 7.1 specific adjustments
Date: Thu, 11 Jun 2026 15:40:57 +0200
Message-ID: <20260611134057.2267177-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---

Hi Philippe,

final tests are still running but the local tests are looking good.
The EVL testsuite triggered a WARN_ONCE() - see process.c below - which
caused the systems to hang.

Turned out the arm64 entry code got some refactorings that needed some
adjustments - pipline wise.

I would fold the following into 7.1, so could you please double check?
Thanks!

 arch/arm64/kernel/entry-common.c | 35 ++++++++++++++++++++++++++++----
 arch/arm64/kernel/process.c      |  6 +++---
 include/linux/irq-entry-common.h |  3 +++
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index b0e141266349..97f6d6904a5d 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -166,7 +166,16 @@ static noinstr irqentry_state_t arm64_enter_from_kernel_mode(struct pt_regs *reg
 static void noinstr arm64_exit_to_kernel_mode(struct pt_regs *regs,
 					      irqentry_state_t state)
 {
-	local_irq_disable();
+	if (irqs_pipelined()) {
+		hard_local_irq_disable();
+		if (running_inband()) {
+			stall_inband_nocheck();
+			trace_hardirqs_off();
+		}
+	} else {
+		local_irq_disable();
+	}
+
 	irqentry_exit_to_kernel_mode_preempt(regs, state);
 	local_daif_mask();
 	mte_check_tfsr_exit();
@@ -175,7 +184,14 @@ static void noinstr arm64_exit_to_kernel_mode(struct pt_regs *regs,
 
 static __always_inline void arm64_syscall_enter_from_user_mode(struct pt_regs *regs)
 {
-	enter_from_user_mode(regs);
+	if (running_inband()) {
+		WARN_ON_ONCE(irq_pipeline_debug() && irqs_disabled());
+		stall_inband_nocheck();
+		enter_from_user_mode(regs);
+		trace_hardirqs_on();
+		unstall_inband_nocheck();
+	}
+
 	mte_disable_tco_entry(current);
 	sme_enter_from_user_mode();
 }
@@ -191,6 +207,7 @@ static __always_inline void arm64_enter_from_user_mode(struct pt_regs *regs)
 		WARN_ON_ONCE(irq_pipeline_debug() && irqs_disabled());
 		stall_inband_nocheck();
 		enter_from_user_mode(regs);
+		rseq_note_user_irq_entry();
 		trace_hardirqs_on();
 		unstall_inband_nocheck();
 	}
@@ -226,8 +243,18 @@ static __always_inline void arm64_syscall_exit_to_user_mode(struct pt_regs *regs
  */
 static __always_inline void arm64_exit_to_user_mode(struct pt_regs *regs)
 {
-	local_irq_disable();
-	irqentry_exit_to_user_mode_prepare(regs);
+	if (irqs_pipelined()) {
+		hard_local_irq_disable();
+		if (running_inband()) {
+			stall_inband_nocheck();
+			trace_hardirqs_off();
+			irqentry_exit_to_user_mode_prepare(regs);
+		}
+	} else {
+		local_irq_disable();
+		irqentry_exit_to_user_mode_prepare(regs);
+	}
+
 	local_daif_mask();
 	sme_exit_to_user_mode();
 	mte_check_tfsr_exit();
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index b1eac5fd75c1..0047d0bdedd9 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -748,8 +748,8 @@ static inline void debug_switch_state(void)
 		unsigned long pmr_expected = GIC_PRIO_IRQOFF;
 		unsigned long pmr_actual = read_sysreg_s(SYS_ICC_PMR_EL1);
 
-		WARN_ONCE(daif_actual != daif_expected ||
-			  pmr_actual != pmr_expected,
+		WARN_ONCE(running_inband() && (daif_actual != daif_expected ||
+			  pmr_actual != pmr_expected),
 			  "Unexpected DAIF + PMR: 0x%lx + 0x%lx (expected 0x%lx + 0x%lx)\n",
 			  daif_actual, pmr_actual,
 			  daif_expected, pmr_expected);
@@ -757,7 +757,7 @@ static inline void debug_switch_state(void)
 		unsigned long daif_expected = DAIF_PROCCTX_NOIRQ;
 		unsigned long daif_actual = read_sysreg(daif);
 
-		WARN_ONCE(daif_actual != daif_expected,
+		WARN_ONCE(running_inband() && daif_actual != daif_expected,
 			  "Unexpected DAIF value: 0x%lx (expected 0x%lx)\n",
 			  daif_actual, daif_expected);
 	}
diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index 58c28b2a8f2b..61a8e129e71f 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -600,6 +600,9 @@ irqentry_exit_to_kernel_mode_after_preempt(struct pt_regs *regs, irqentry_state_
 {
 	bool synchronized;
 
+	if (running_oob())
+		return;
+
 	instrumentation_begin();
 	synchronized = irqentry_syncstage(state);
 
-- 
2.54.0

