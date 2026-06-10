Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEC63DB31F
	for <xenomai@lists.linux.dev>; Wed, 10 Jun 2026 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083226; cv=none; b=linPAiOq3SRhltfARKLeosJcyy7ukTzATtry1QPPSyJgh0jaUKjmg8hf2wOLWP18rPZjFdPGl4npAkGgHeW1KtMx1l4PIjuX5BitQWVx8h7lcdTkEhJ9KraGCuXhtDacWwkuu3odFlQ1Cm/tJXoJuwlY9vvYB7f0Ku/UuBXvgw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083226; c=relaxed/simple;
	bh=ZwH9XNC+pejz/0n6+39keE5somrhsmNMekHoE/h827k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U40yvCPLCYDsNO+1GTjME+JqqoMcpJaWJanSc/Jmn2Zem5gun7oDquHsc+rAnRrOmLPDTzzrxt/jg6eCvsXlALBYcPNlbqSfVpnJbWxLPz2V1xvXwvbeb9lYfvT4hCt7bacxoCrtiv1gFD2T8yPFh2o8rmwA/5avcslmIyrf+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=NM4uK0qy; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="NM4uK0qy"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026061009201380d3f4dfa50002072a
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jun 2026 11:20:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=X/Y7CwuKCw6an7iAkYGxbIuusqdWC6g04Zil5/Rz51E=;
 b=NM4uK0qyD+XxMivHMT3H4DD2Q1pJ7DaJZBxaDx27VeXBGUrfqf3Um7T+9HTqOp7pT6gaxQ
 DaF7qV8jCAtKUOAxVv8Q2gnQ2OLoHoTp+F6qkr+/f87eB5838BYNPW2A6R8RVqSrB6NQibsi
 4Wqk9k2iNRi6ZbAVUYiJ4ad7/tzywg+adiXp0jGQGs1HHMawxjvvCq2MM0s5QJYUhdRvJ17l
 GZxfHjTi2NSPO4q7I0SOH8yNLRkmMlXt/UExkU2STz0ewXDVrziLvwel+loTTi+5wiXnI5pq
 xbCbmo125F5MrnxOYQBM1PGdOqXZEhFpPSJuCotV7OgziLk4nGWhrCqA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 10 Jun 2026 11:20:14 +0200
Subject: [PATCH Dovetail v2 2/6] arm: irq_pipeline: Move fault_entry()
 fault_exit() into separate header
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-2-62c9c477f8f2@siemens.com>
References: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-0-62c9c477f8f2@siemens.com>
In-Reply-To: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-0-62c9c477f8f2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Introducing a new header allows us to keep the implementation as
static inline function. Moving them into asm/dovetail.h or
asm/irq_pipeline.h would require us to rewrite those helpers as macros.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm/include/asm/trap_entry.h | 82 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/fault.c               | 65 +------------------------------
 2 files changed, 83 insertions(+), 64 deletions(-)

diff --git a/arch/arm/include/asm/trap_entry.h b/arch/arm/include/asm/trap_entry.h
new file mode 100644
index 0000000000000000000000000000000000000000..56cf3352c38d9347e989f9b4f6be0b7d649d9b13
--- /dev/null
+++ b/arch/arm/include/asm/trap_entry.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASMARM_TRAP_ENTRY_H
+#define _ASMARM_TRAP_ENTRY_H
+
+#include <asm/dovetail.h>
+#include <asm/trace/exceptions.h>
+
+#ifdef CONFIG_MMU
+#ifdef CONFIG_IRQ_PIPELINE
+/*
+ * We need to synchronize the virtual interrupt state with the hard
+ * interrupt state we received on entry, then turn hardirqs back on to
+ * allow code which does not require strict serialization to be
+ * preempted by an out-of-band activity.
+ */
+static inline unsigned long fault_entry(int exception, struct pt_regs *regs)
+{
+	unsigned long flags;
+
+	trace_ARM_trap_entry(exception, regs);
+
+	flags = hard_local_save_flags();
+
+	/*
+	 * The companion core must demote the current context to
+	 * in-band stage if running oob on entry.
+	 */
+	mark_trap_entry(exception, regs);
+
+	if (raw_irqs_disabled_flags(flags)) {
+		stall_inband();
+		trace_hardirqs_off();
+	}
+
+	hard_local_irq_enable();
+
+	return flags;
+}
+
+static inline void fault_exit(int exception, struct pt_regs *regs,
+			      unsigned long flags)
+{
+	WARN_ON_ONCE(irq_pipeline_debug() && hard_irqs_disabled());
+
+	/*
+	 * We expect kentry_exit_pipelined() to clear the stall bit if
+	 * kentry_enter_pipelined() observed it that way.
+	 */
+	mark_trap_exit(exception, regs);
+	trace_ARM_trap_exit(exception, regs);
+	hard_local_irq_restore(flags);
+}
+
+#else /* !CONFIG_IRQ_PIPELINE */
+
+#define fault_entry(__exception, __regs)		\
+	do {						\
+		(void)(__exception);			\
+		(void)(__regs);				\
+	} while (0)
+
+#define fault_exit(__exception, __regs, __flags)	\
+	do {						\
+		(void)(__exception);			\
+		(void)(__regs);				\
+		(void)(__flags);			\
+	} while (0)
+
+#endif /* !CONFIG_IRQ_PIPELINE */
+
+#else /* CONFIG_MMU */
+unsigned long fault_entry(int exception, struct pt_regs *regs)
+{
+	return 0;
+}
+
+static inline void fault_exit(int exception, struct pt_regs *regs,
+			      unsigned long combo)
+{ }
+#endif /* !CONFIG_MMU */
+
+#endif
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 7a5c0a5a825df5f76eec6aa341d910c3efa63f88..60982ec0627464dd389e1c9b106858bc92ccf260 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -24,6 +24,7 @@
 #include <asm/system_info.h>
 #include <asm/tlbflush.h>
 #include <asm/dovetail.h>
+#include <asm/trap_entry.h>
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
 
@@ -38,61 +39,6 @@ bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 	return addr >= TASK_SIZE && ULONG_MAX - addr >= size;
 }
 
-#ifdef CONFIG_IRQ_PIPELINE
-/*
- * We need to synchronize the virtual interrupt state with the hard
- * interrupt state we received on entry, then turn hardirqs back on to
- * allow code which does not require strict serialization to be
- * preempted by an out-of-band activity.
- */
-static inline
-unsigned long fault_entry(int exception, struct pt_regs *regs)
-{
-	unsigned long flags;
-
-	trace_ARM_trap_entry(exception, regs);
-
-	flags = hard_local_save_flags();
-
-	/*
-	 * The companion core must demote the current context to
-	 * in-band stage if running oob on entry.
-	 */
-	mark_trap_entry(exception, regs);
-
-	if (raw_irqs_disabled_flags(flags)) {
-		stall_inband();
-		trace_hardirqs_off();
-	}
-
-	hard_local_irq_enable();
-
-	return flags;
-}
-
-static inline
-void fault_exit(int exception, struct pt_regs *regs,
-		unsigned long flags)
-{
-	WARN_ON_ONCE(irq_pipeline_debug() && hard_irqs_disabled());
-
-	/*
-	 * We expect kentry_exit_pipelined() to clear the stall bit if
-	 * kentry_enter_pipelined() observed it that way.
-	 */
-	mark_trap_exit(exception, regs);
-	trace_ARM_trap_exit(exception, regs);
-	hard_local_irq_restore(flags);
-}
-
-#else	/* !CONFIG_IRQ_PIPELINE */
-
-#define fault_entry(__exception, __regs)  ({ 0; })
-#define fault_exit(__exception, __regs, __flags)  \
-	do { (void)(__flags); } while (0)
-
-#endif	/* !CONFIG_IRQ_PIPELINE */
-
 /*
  * This is useful to dump out the page tables associated with
  * 'addr' in mm 'mm'.
@@ -165,15 +111,6 @@ void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr)
 	pr_cont("\n");
 }
 #else					/* CONFIG_MMU */
-unsigned long fault_entry(int exception, struct pt_regs *regs)
-{
-	return 0;
-}
-
-static inline void fault_exit(int exception, struct pt_regs *regs,
-			unsigned long combo)
-{ }
-
 void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr)
 { }
 #endif					/* CONFIG_MMU */

-- 
2.54.0

