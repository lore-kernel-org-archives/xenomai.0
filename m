Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82FE392824
	for <xenomai@lists.linux.dev>; Wed, 10 Jun 2026 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083228; cv=none; b=WSlr5+Pbl4Kr8Qolx9IZ+D4N71Udzkg+Ime+YtW3O9z6THvIHtXG5ShbH1i6L8AkSIIq3+sRoQ1jy1K+ept+a1w6JxJjr+8iwlr/1pjciR+0abDrC1dp5bSfwqk9o7wrcPTY5jes69QTXz6PhBgbYV5Q4q/vrEqIWOvo0Y7U1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083228; c=relaxed/simple;
	bh=2kCwhIxqXFANUAaQBa5B6emFS6YoUhbCX0F3urpCFOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ujmjGeroNr1fDF2iVvOvlUDMAWOfalnkEAB5hhQsM1txiboJXUYJ2N+Q5Vt+nZjKFf6476IkQd0WXToawnm3u/Xnb6bjMD65w6GGz/mMEFnTnkHpntXdbx8Bf0JJIsvjuXgGq1eFE7fU6fkGsL096eC6LfVdSyISXRAYIva6krY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Szi30jwT; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Szi30jwT"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260610092014b6d64e58e6000207d9
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jun 2026 11:20:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qtnuARnPFX0lo2QBJMpRHaP38kxxdZKUrDQhoxXx+ik=;
 b=Szi30jwTw0yEyPVaabzLnYgXkZVcpt3eCpJ/91rSO0ubERCK6+xFpAyrfTU9OrZVjUH2h3
 jc8JDfoN01x7YrlnINYdupL11uYDbXEH1pMCaHPZNPSGfAFrL0BTHT9ld65Zl6GlKlH64d+/
 JHIEfQmbnaxN8Esc50DSWM/+KUZAUaCltSL0QvR7VbcvW9kCW/i1PD8fJN47/u8AQCoYsolD
 fd98Dg3w4Hi5Y2+a3b7lxZTQlXgFdcuXxbPAcyGDDzX6Pdsfg49NVMyYNzuNS/jTQPxPTlnH
 wLYiq48zqOrIAhw1pPCJPxQp3bMISnQYTt2Xr/feCi6vsT/7rjsVIf4A==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 10 Jun 2026 11:20:17 +0200
Subject: [PATCH Dovetail v2 5/6] dovetail: Decouple kernel/irq/pipeline.c
 from irqstate bit definitions
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-5-62c9c477f8f2@siemens.com>
References: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-0-62c9c477f8f2@siemens.com>
In-Reply-To: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-0-62c9c477f8f2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

This only affects architectures where CONFIG_GENERIC_ENTRY is not set.

Moving the stall bit definitions into the architecture specific
implementations allows re-use of those definition within the arch
specifics.

Moving the defines to include/linux/irq_pipeline.h turned out to
trigger a lot of trouble as re-use will live in asm/ where including
a "general" header is quite hard.

The platform independent implementation will now need the following
arch specific hooks, all operating on the platform specific
struct pt_regs:
  - arch_kentry_irqs_enabled()
  - arch_kentry_lockdep_set()
  - arch_kentry_clear_irq_state()
  - arch_kentry_set_irqs_stalled()
  - arch_kentry_set_lockdep()

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm/include/asm/irq_pipeline.h   | 41 +++++++++++++++++++++++++++--------
 arch/arm64/include/asm/irq_pipeline.h |  9 ++++----
 kernel/irq/pipeline.c                 | 20 +++++------------
 3 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/arch/arm/include/asm/irq_pipeline.h b/arch/arm/include/asm/irq_pipeline.h
index 5e3a20149246505e8401bc7157d9c9f13673f45e..d1ee5cefd407a117eca5a1907848580e0a5bb622 100644
--- a/arch/arm/include/asm/irq_pipeline.h
+++ b/arch/arm/include/asm/irq_pipeline.h
@@ -98,15 +98,33 @@ static inline void arch_handle_irq_pipelined(struct pt_regs *regs)
 	handle_arch_irq(regs);
 }
 
-#define arch_kentry_get_irqstate(__regs)		\
-	({						\
-		to_svc_pt_regs(__regs)->irqstate;	\
-	})
-
-#define arch_kentry_set_irqstate(__regs, __irqstate)		\
-	do {							\
-		to_svc_pt_regs(__regs)->irqstate = __irqstate;	\
-	} while (0)
+#define KENTRY_STALL_BIT      BIT(0) /* Tracks INBAND_STALL_BIT */
+#define KENTRY_LOCKDEP_BIT    BIT(1) /* Tracks hardirqs_enabled */
+
+#define arch_kentry_irqs_enabled(__regs)			\
+({								\
+	!(to_svc_pt_regs(__regs)->irqstate & KENTRY_STALL_BIT);	\
+})
+
+#define arch_kentry_lockdep_set(__regs)				\
+({								\
+	to_svc_pt_regs(__regs)->irqstate & KENTRY_LOCKDEP_BIT;	\
+})
+
+#define arch_kentry_clear_irq_state(__regs)			\
+({								\
+	to_svc_pt_regs(__regs)->irqstate = 0;			\
+})
+
+#define arch_kentry_set_irqs_stalled(__regs)			\
+({								\
+	to_svc_pt_regs(__regs)->irqstate |= KENTRY_STALL_BIT;	\
+})
+
+#define arch_kentry_set_lockdep(__regs)				\
+({								\
+	to_svc_pt_regs(__regs)->irqstate |= KENTRY_LOCKDEP_BIT;	\
+})
 
 int handle_arch_irq_pipelined(struct pt_regs *regs);
 
@@ -142,6 +160,11 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 	return native_irqs_disabled_flags(flags);
 }
 
+#define arch_kentry_irqs_enabled(regs)	\
+({					\
+	!interrupts_enabled(regs);	\
+})
+
 #endif /* !CONFIG_IRQ_PIPELINE */
 
 #endif /* _ASM_ARM_IRQ_PIPELINE_H */
diff --git a/arch/arm64/include/asm/irq_pipeline.h b/arch/arm64/include/asm/irq_pipeline.h
index 09cb33b826cb63701678f40b61b65df885923db2..c4f9a39ad323bf4cd5c1ff59e43c64b1a87b49cf 100644
--- a/arch/arm64/include/asm/irq_pipeline.h
+++ b/arch/arm64/include/asm/irq_pipeline.h
@@ -102,10 +102,11 @@ static inline void arch_handle_irq_pipelined(struct pt_regs *regs)
  * the latter for now, until we enventually switch to using whichever
  * of them is available first.
  */
-#define arch_kentry_get_irqstate(__regs)	0
-
-#define arch_kentry_set_irqstate(__regs, __irqstate)	\
-	do { (void)__irqstate; } while (0)
+#define arch_kentry_irqs_enabled(__regs)	0
+#define arch_kentry_lockdep_set(__regs)		0
+#define arch_kentry_clear_irq_state(__regs)
+#define arch_kentry_set_irqs_stalled(__regs)
+#define arch_kentry_set_lockdep(__regs)
 
 #else  /* !CONFIG_IRQ_PIPELINE */
 
diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
index ced7003a8444125ff38d71bf867ce34cfa0235f1..34a62805def0e3a5a70893a8ea71d6c200bd8e70 100644
--- a/kernel/irq/pipeline.c
+++ b/kernel/irq/pipeline.c
@@ -1401,33 +1401,26 @@ void sync_current_irq_stage(void) /* hard irqs off */
  * in kernel context, indexed on the current register frame.
  */
 
-#define KENTRY_STALL_BIT      BIT(0) /* Tracks INBAND_STALL_BIT */
-#define KENTRY_LOCKDEP_BIT    BIT(1) /* Tracks hardirqs_enabled */
-
 asmlinkage __visible noinstr void kentry_enter_pipelined(struct pt_regs *regs)
 {
-	long irqstate = 0;
-
 	WARN_ON(irq_pipeline_debug() && !hard_irqs_disabled());
 
 	if (!running_inband())
 		return;
 
+	arch_kentry_clear_irq_state(regs);
+
 	if (lockdep_read_irqs_state())
-		irqstate |= KENTRY_LOCKDEP_BIT;
+		arch_kentry_set_lockdep(regs);
 
 	if (irqs_disabled())
-		irqstate |= KENTRY_STALL_BIT;
+		arch_kentry_set_irqs_stalled(regs);
 	else
 		trace_hardirqs_off();
-
-	arch_kentry_set_irqstate(regs, irqstate);
 }
 
 asmlinkage void __visible noinstr kentry_exit_pipelined(struct pt_regs *regs)
 {
-	long irqstate;
-
 	WARN_ON(irq_pipeline_debug() && !hard_irqs_disabled());
 
 	if (!running_inband())
@@ -1444,13 +1437,12 @@ asmlinkage void __visible noinstr kentry_exit_pipelined(struct pt_regs *regs)
 	 * do flip the stall bit, but are not tracked by lockdep).
 	 */
 
-	irqstate = arch_kentry_get_irqstate(regs);
-	if (!(irqstate & KENTRY_STALL_BIT)) {
+	if (arch_kentry_irqs_enabled(regs)) {
 		stall_inband_nocheck();
 		trace_hardirqs_on();
 		unstall_inband_nocheck();
 	} else {
-		lockdep_write_irqs_state(!!(irqstate & KENTRY_LOCKDEP_BIT));
+		lockdep_write_irqs_state(arch_kentry_lockdep_set(regs));
 	}
 }
 

-- 
2.54.0

