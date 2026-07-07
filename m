Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F0D3D75A4
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417833; cv=none; b=c4uGAdwyxzOenGTyPwXQhzEVBPkmmYb3r84PjUd9ZLqiHkdW63Y8Tj8H8pTvV0/l/zlNGGa3GDhwUq1g8blWaKh4M6by/XucUQctg0fzX/KOO5XpeZdiiWOWzXXpMwf7I6HG+bpU7t7vuNY/wejfjBleAXHJhngI0fMghbJQB6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417833; c=relaxed/simple;
	bh=kbykTf4/H9MHIfkCc5otfMiyEjehvpr4wWMLThq6/BE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aKNzpxYNM3VxyK0O229jCmhgJuBiq0Hq78W5tMfdf1QTM/CoTtzwzDa0rMw+YTNGWwEqXGXUj22/R+fLcYGcYKr/z2M2kLcVUx78d84zqE3SyjjoybBrPYw91AdjNp9PbYwbjUZUgA5zvNd/rV3bG2PnDdemBvn9tmjNuHfV5O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=C/iJ+kN3; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="C/iJ+kN3"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260707095019992b18f56200020765
        for <xenomai@lists.linux.dev>;
        Tue, 07 Jul 2026 11:50:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=U1FPPbyYWECJqQ4OWDmPse+rHhYWLQNShY8wRVt1QqU=;
 b=C/iJ+kN3YgbMa/KYJfmwCyKxD9hSJ3x8Qy9uXfLYUv7SG0+rsdoISQ0MfPOqzISkg0t0IT
 joQQC8lipYZd0wP7yOFkF0XEUGkyT/kcI3yJhvCkViAjkPidmfSDeqYlnBx9RFfNGBzd96kK
 Pyxcovvjisr1My1u5P89U+1sK0JzpGVb1i9IxyAuiBH2+KNwsV1QQB+PqAC5TG+XKYsueg56
 8lVVqck/NYAhEQ//CKBFB2+6+L5Key4biUSK6pVwP+XrJ/nPc+Cd5zqbkE7LmSnaMNE7LXcp
 25xi0N4yDgL3w0lPlFfWltZyJrGaZrVFIlt+X9/FyUQl/6dTXKe87XNg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 07 Jul 2026 11:50:17 +0200
Subject: [PATCH Dovetail v4 1/8] arm: irq_pipeline: Rename and move
 fault_entry_{enter,exit}
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-1-057b8af5a2ca@siemens.com>
References: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
In-Reply-To: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Introducing a new header allows us to keep the implementation as
static inline function and make it re-usable for other compile units.
Moving the implementation into existing headers like asm/dovetail.h or
asm/irq_pipeline.h would require us to rewrite those helpers as macros.

Prefixing with dovetail_ to keep the Linux namespace clean.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm/include/asm/trap_entry.h | 83 ++++++++++++++++++++++++++++++++++++
 arch/arm/mm/fault.c               | 89 ++++++---------------------------------
 2 files changed, 96 insertions(+), 76 deletions(-)

diff --git a/arch/arm/include/asm/trap_entry.h b/arch/arm/include/asm/trap_entry.h
new file mode 100644
index 0000000000000000000000000000000000000000..abe5f80cd301a8ca5ddb2ca350b80bf5708f0f79
--- /dev/null
+++ b/arch/arm/include/asm/trap_entry.h
@@ -0,0 +1,83 @@
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
+static inline unsigned long dovetail_fault_entry(int exception,
+						 struct pt_regs *regs)
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
+static inline void dovetail_fault_exit(int exception, struct pt_regs *regs,
+				       unsigned long flags)
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
+#define dovetail_fault_entry(__exception, __regs)		\
+	do {							\
+		(void)(__exception);				\
+		(void)(__regs);					\
+	} while (0)
+
+#define dovetail_fault_exit(__exception, __regs, __flags)	\
+	do {							\
+		(void)(__exception);				\
+		(void)(__regs);					\
+		(void)(__flags);				\
+	} while (0)
+
+#endif /* !CONFIG_IRQ_PIPELINE */
+
+#else /* CONFIG_MMU */
+unsigned long dovetail_fault_entry(int exception, struct pt_regs *regs)
+{
+	return 0;
+}
+
+static inline void dovetail_fault_exit(int exception, struct pt_regs *regs,
+				       unsigned long combo)
+{ }
+#endif /* !CONFIG_MMU */
+
+#endif
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 49f5d628c4c9a91a3e879af0d541fd76665d78fe..b6b766652b753ef860d16b153685b0d3b582bffa 100644
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
@@ -278,9 +215,9 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	 * have no context to handle this fault with.
 	 */
 	  if (user_mode(regs)) {
-		irqflags = fault_entry(ARM_TRAP_ACCESS, regs);
+		irqflags = dovetail_fault_entry(ARM_TRAP_ACCESS, regs);
 		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
-		fault_exit(ARM_TRAP_ACCESS, regs, irqflags);
+		dovetail_fault_exit(ARM_TRAP_ACCESS, regs, irqflags);
 	  } else
 		/*
 		 * irq_pipeline: kernel faults are either quickly
@@ -391,9 +328,9 @@ do_kernel_address_page_fault(struct mm_struct *mm, unsigned long addr,
 		 * Note that __do_user_fault() will enable interrupts.
 		 */
 		harden_branch_predictor();
-		irqflags = fault_entry(ARM_TRAP_ACCESS, regs);
+		irqflags = dovetail_fault_entry(ARM_TRAP_ACCESS, regs);
 		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
-		fault_exit(ARM_TRAP_ACCESS, regs, irqflags);
+		dovetail_fault_exit(ARM_TRAP_ACCESS, regs, irqflags);
 	} else {
 		/*
 		 * Fault from kernel mode. Enable interrupts if they were
@@ -433,7 +370,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (addr >= TASK_SIZE)
 		return do_kernel_address_page_fault(mm, addr, fsr, regs);
 
-	irqflags = fault_entry(ARM_TRAP_ACCESS, regs);
+	irqflags = dovetail_fault_entry(ARM_TRAP_ACCESS, regs);
 
 	/* Enable interrupts if they were enabled in the parent context. */
 	if (interrupts_enabled(regs))
@@ -595,7 +532,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 no_context:
 	__do_kernel_fault(mm, addr, fsr, regs);
 out:
-	fault_exit(ARM_TRAP_ACCESS, regs, irqflags);
+	dovetail_fault_exit(ARM_TRAP_ACCESS, regs, irqflags);
 
 	return 0;
 }
@@ -671,9 +608,9 @@ do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (addr >= TASK_SIZE && user_mode(regs))
 		harden_branch_predictor();
 
-	irqflags = fault_entry(ARM_TRAP_SECTION, regs);
+	irqflags = dovetail_fault_entry(ARM_TRAP_SECTION, regs);
 	do_bad_area(addr, fsr, regs);
-	fault_exit(ARM_TRAP_SECTION, regs, irqflags);
+	dovetail_fault_exit(ARM_TRAP_SECTION, regs, irqflags);
 	return 0;
 }
 #endif /* CONFIG_ARM_LPAE */
@@ -726,7 +663,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
 		return;
 
-	irqflags = fault_entry(ARM_TRAP_DABT, regs);
+	irqflags = dovetail_fault_entry(ARM_TRAP_DABT, regs);
 	pr_alert("8<--- cut here ---\n");
 	pr_alert("Unhandled fault: %s (0x%03x) at 0x%08lx\n",
 		inf->name, fsr, addr);
@@ -734,7 +671,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	arm_notify_die("", regs, inf->sig, inf->code, (void __user *)addr,
 		       fsr, 0);
-	fault_exit(ARM_TRAP_DABT, regs, irqflags);
+	dovetail_fault_exit(ARM_TRAP_DABT, regs, irqflags);
 }
 
 void __init
@@ -759,14 +696,14 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
 	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
 		return;
 
-	irqflags = fault_entry(ARM_TRAP_PABT, regs);
+	irqflags = dovetail_fault_entry(ARM_TRAP_PABT, regs);
 	pr_alert("8<--- cut here ---\n");
 	pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
 		inf->name, ifsr, addr);
 
 	arm_notify_die("", regs, inf->sig, inf->code, (void __user *)addr,
 		       ifsr, 0);
-	fault_exit(ARM_TRAP_PABT, regs, irqflags);
+	dovetail_fault_exit(ARM_TRAP_PABT, regs, irqflags);
 }
 
 /*

-- 
2.55.0

