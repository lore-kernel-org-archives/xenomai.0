Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF2D199FB9
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 06:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728628703; cv=none; b=QJavz4vEib/gXVk1RKDrwGvB2mgwh/QmexlLD3mAG+F8tJVzL1pkaILFUjXkmlOdaVDIxV2stRojpLBB9rZHdtV1ivfVgKlYHCyFFzIYgXoJOWYWQvu/xiYPcA2Q2eFavSRizLJcjrHX2oC0eUoJUu4oBWuZNeocFKLYul6LRDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728628703; c=relaxed/simple;
	bh=5dm5TR0DcqUoGSmfN0Qwhcd7gBz/8pAXpPYL4YUFFb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SUnWUYcOf/sTNrbB4QSHLPt0wc4ikZMkKgs+25pdCqzUXp2YfIo84523pn1AMYGt1MIZQFLznaEn1FlLRGWrJXt7UN/pla1YxbwFS/kVqY0wMdawEwEHnfviu9dzRG5KEQIXmUvPfwhBoudsT2AoGMjHWSsHYYBD1Wwl23M3M/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFwJIs7D; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFwJIs7D"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c77459558so13764245ad.0
        for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 23:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728628699; x=1729233499; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcnNw+nBy/MarmGUWQ8Sq/ijYu+xx1mHdqoQV0BaT0E=;
        b=BFwJIs7Dz/w1ISt0eCgwTld85Kq74j/6DPh6+JLPS5mZN9QQTk2RB1BgY/UfSMv4bB
         aZd5NhXNEpPwAGFFayMztHJD0KBd/eFX2MyDg5ZplmWhdWE8aZHjjUqhOxYidBDDmEpq
         c+LWgvsAJronJd6AtJVodpN4YNrK1ENvBAb6zVqLLIIAfGHb5/oYqRAcYJWKEG3f/q95
         VGgfMhme/QJE5aRL+wC4SEPXOAS155t6+anpzO9z8KKzLluYh+JCgnhi26PzysR7kVNI
         rc2h3+xR10U/KP2QzonjV/yUDS/OGsQdj5Wzzge1aWw21oGCu9wrsD4KisINGBB3X7wK
         8YDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728628699; x=1729233499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcnNw+nBy/MarmGUWQ8Sq/ijYu+xx1mHdqoQV0BaT0E=;
        b=cf+SGwrOpUqPjJQcg3kWA/4uEDvmKdSJq/6e3qUvhv+FXv60SpVhKwXLyF7lD0I2Ic
         DPUP2iQ5P22fGaLQLfAbOksNgpMZfazmMCsADglasBH6U0e2EA52fxkIWaNGeFluZflA
         2EIpu8SEi3QTWviv3EoEGLN/LspSYHV6nYw9YF5sflDC7Yp6nWe3iwyqeaOXD+7ke2sq
         gPX7q+MxfU1Q5JXjuR29/oiwo1QVls6vWpRZR1pTbQ5vw1UAXPNBI2uXhuwImrtZ1svH
         9MFLxS2HSEfagz2dOt+NGPdzvQpxRcAbvrH+b6lOdEa9QYr4IdYL9e9nDnagj/2byr3R
         /5rQ==
X-Gm-Message-State: AOJu0YyXx2iXkURKJlp93c7s2ax3vYi1IuiweFCg7eWkYju4D5FddkkG
	QCXzY2hEp8oFxgJoLPJTowtBEurEwj4zxpL0fOCEo9a3a/8v6TZcQQsbtzlloOs=
X-Google-Smtp-Source: AGHT+IH0DVezEh2Cd74u6i/QH7kuC7lbEdvkNSJgsw2ec7KHXwbjSQTOB2q3moZ0mrFIamQk071A8g==
X-Received: by 2002:a17:903:184:b0:20b:7e30:b2eb with SMTP id d9443c01a7336-20ca1724e5cmr16026025ad.58.1728628698373;
        Thu, 10 Oct 2024 23:38:18 -0700 (PDT)
Received: from 43c7c7756ed8.. ([117.129.58.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc1b9f3sm18241865ad.76.2024.10.10.23.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 23:38:17 -0700 (PDT)
From: shannmu <shanmu1901@gmail.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	shannmu <shanmu1901@gmail.com>
Subject: [PATCH 1/3] RISC-V: enable IRQ-PIPELINE
Date: Fri, 11 Oct 2024 06:37:28 +0000
Message-Id: <20241011063730.310568-2-shanmu1901@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011063730.310568-1-shanmu1901@gmail.com>
References: <20241011063730.310568-1-shanmu1901@gmail.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds virtual interrupt functions `arch_xxx`,
irq-pipelined top-level interrupt handler `handle_riscv_irq`
and `handle_arch_irq_pipelined`,
real interrupt-flags functions `native_xxx`,
`mark_trap_entry` and `mark_trap_exit` in trap functions,
multiplexed ipi_message_type `IPI_RESCHEDULE` for in-band ipi.

Signed-off-by: shannmu <shanmu1901@gmail.com>
---
 arch/riscv/Kconfig                    |   5 +
 arch/riscv/include/asm/dovetail.h     |  58 +++++++
 arch/riscv/include/asm/irq_pipeline.h | 173 +++++++++++++++++++++
 arch/riscv/include/asm/irqflags.h     |  26 ++--
 arch/riscv/include/asm/mmu_context.h  |  21 ++-
 arch/riscv/include/asm/syscall.h      |   6 +
 arch/riscv/kernel/Makefile            |   1 +
 arch/riscv/kernel/irq.c               |  72 ++++++---
 arch/riscv/kernel/irq_pipeline.c      |  46 ++++++
 arch/riscv/kernel/smp.c               | 135 ++++++++++++----
 arch/riscv/kernel/smpboot.c           |   2 +-
 arch/riscv/kernel/traps.c             | 212 +++++++++++++++-----------
 arch/riscv/mm/fault.c                 |  46 +++---
 13 files changed, 633 insertions(+), 170 deletions(-)
 create mode 100644 arch/riscv/include/asm/dovetail.h
 create mode 100644 arch/riscv/include/asm/irq_pipeline.h
 create mode 100644 arch/riscv/kernel/irq_pipeline.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c785a0200573..8974767e1304 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -28,6 +28,7 @@ config RISCV
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MMIOWB
+	select HAVE_ARCH_EVL
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API
 	select ARCH_HAS_PTE_SPECIAL
@@ -121,6 +122,8 @@ config RISCV
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_VDSO if MMU && 64BIT
+	select HAVE_IRQ_PIPELINE
+	select HAVE_DOVETAIL
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
@@ -639,6 +642,8 @@ endmenu # "Platform type"
 menu "Kernel features"
 
 source "kernel/Kconfig.hz"
+source "kernel/Kconfig.dovetail"
+source "kernel/Kconfig.evl"
 
 config RISCV_SBI_V01
 	bool "SBI v0.1 support"
diff --git a/arch/riscv/include/asm/dovetail.h b/arch/riscv/include/asm/dovetail.h
new file mode 100644
index 000000000000..bbcc42cb4ef8
--- /dev/null
+++ b/arch/riscv/include/asm/dovetail.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_RISCV_DOVETAIL_H
+#define _ASM_RISCV_DOVETAIL_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_DOVETAIL
+
+static inline void arch_dovetail_exec_prepare(void)
+{
+}
+
+static inline void arch_dovetail_switch_prepare(bool leave_inband)
+{
+}
+
+static inline void arch_dovetail_switch_finish(bool enter_inband)
+{
+}
+
+/*
+ * 172 is __NR_prctl from unistd in compat mode, without #inclusion
+ * hell. At the end of the day, this number is written in stone to
+ * honor the ABI stability promise anyway.
+ */
+#define arch_dovetail_is_syscall(__nr) \
+	(is_compat_task() ? (__nr) == 172 : (__nr) == __NR_prctl)
+
+#endif
+
+/*
+ * Pass the trap event to the companion core. Return true if running
+ * in-band afterwards.
+ */
+#define mark_cond_trap_entry(__trapnr, __regs)             \
+	({                                                 \
+		bool __ret;                                \
+		oob_trap_notify(__trapnr, __regs);         \
+		__ret = running_inband();                  \
+		if (!__ret)                                \
+			oob_trap_unwind(__trapnr, __regs); \
+		__ret;                                     \
+	})
+
+/*
+ * Pass the trap event to the companion core. We expect the current
+ * context to be running on the in-band stage upon return so that our
+ * caller can tread on common kernel code.
+ */
+#define mark_trap_entry(__trapnr, __regs)                            \
+	do {                                                         \
+		bool __ret = mark_cond_trap_entry(__trapnr, __regs); \
+		BUG(dovetail_debug() && !__ret);                     \
+	} while (0)
+
+#define mark_trap_exit(__trapnr, __regs) oob_trap_unwind(__trapnr, __regs)
+
+#endif /* _ASM_RISCV_DOVETAIL_H */
diff --git a/arch/riscv/include/asm/irq_pipeline.h b/arch/riscv/include/asm/irq_pipeline.h
new file mode 100644
index 000000000000..753234376d53
--- /dev/null
+++ b/arch/riscv/include/asm/irq_pipeline.h
@@ -0,0 +1,173 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_RISCV_IRQ_PIPELINE_H
+#define _ASM_RISCV_IRQ_PIPELINE_H
+
+#include <asm-generic/irq_pipeline.h>
+
+#include <linux/compiler.h>
+#include <asm/irqflags.h>
+
+#ifdef CONFIG_IRQ_PIPELINE
+
+#define RISCV_STATUS_SIE_BIT 1
+// NOTE: RISCV_STATIS_SS_BIT should be unused bit.
+#define RISCV_STATIS_SS_BIT 31
+
+/*
+ * In order to cope with the limited number of SGIs available to us,
+ * In-band IPI messages are multiplexed over SGI0, whereas out-of-band
+ * IPIs are directly mapped to SGI1-3.
+ */
+#define OOB_NR_IPI 3
+#define OOB_IPI_OFFSET 1 /* SGI1 */
+#define TIMER_OOB_IPI (ipi_virq_base + OOB_IPI_OFFSET)
+#define RESCHEDULE_OOB_IPI (TIMER_OOB_IPI + 1)
+#define CALL_FUNCTION_OOB_IPI (RESCHEDULE_OOB_IPI + 1)
+
+extern int ipi_virq_base;
+
+static inline notrace unsigned long
+arch_irqs_virtual_to_native_flags(int stalled)
+{
+	return (!stalled) << RISCV_STATUS_SIE_BIT;
+}
+
+static inline notrace unsigned long
+arch_irqs_native_to_virtual_flags(unsigned long flags)
+{
+	return (!!hard_irqs_disabled_flags(flags)) << RISCV_STATIS_SS_BIT;
+}
+
+static inline notrace unsigned long arch_local_irq_save(void)
+{
+	int stalled = inband_irq_save();
+
+	barrier();
+	return arch_irqs_virtual_to_native_flags(stalled);
+}
+
+static inline notrace void arch_local_irq_enable(void)
+{
+	barrier();
+	inband_irq_enable();
+}
+
+static inline notrace void arch_local_irq_disable(void)
+{
+	inband_irq_disable();
+	barrier();
+}
+
+static inline notrace unsigned long arch_local_save_flags(void)
+{
+	int stalled = inband_irqs_disabled();
+
+	barrier();
+	return arch_irqs_virtual_to_native_flags(stalled);
+}
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return native_irqs_disabled_flags(flags);
+}
+
+static inline notrace void arch_local_irq_restore(unsigned long flags)
+{
+	inband_irq_restore(arch_irqs_disabled_flags(flags));
+	barrier();
+}
+
+static inline void arch_save_timer_regs(struct pt_regs *dst,
+					struct pt_regs *src)
+{
+	dst->epc = src->epc;
+	dst->ra = src->ra;
+	dst->sp = src->sp;
+	dst->gp = src->gp;
+	dst->tp = src->tp;
+	dst->t0 = src->t0;
+	dst->t1 = src->t1;
+	dst->t2 = src->t2;
+	dst->s0 = src->s0;
+	dst->s1 = src->s1;
+	dst->a0 = src->a0;
+	dst->a1 = src->a1;
+	dst->a2 = src->a2;
+	dst->a3 = src->a3;
+	dst->a4 = src->a4;
+	dst->a5 = src->a5;
+	dst->a6 = src->a6;
+	dst->a7 = src->a7;
+	dst->s2 = src->s2;
+	dst->s3 = src->s3;
+	dst->s4 = src->s4;
+	dst->s5 = src->s5;
+	dst->s6 = src->s6;
+	dst->s7 = src->s7;
+	dst->s8 = src->s8;
+	dst->s9 = src->s9;
+	dst->s10 = src->s10;
+	dst->s11 = src->s11;
+	dst->t3 = src->t3;
+	dst->t4 = src->t4;
+	dst->t5 = src->t5;
+	dst->status = src->status;
+	dst->badaddr = src->badaddr;
+	dst->cause = src->cause;
+	dst->orig_a0 = src->orig_a0;
+}
+
+static inline bool arch_steal_pipelined_tick(struct pt_regs *regs)
+{
+	return !(regs->status & SR_IE);
+}
+
+static inline int arch_enable_oob_stage(void)
+{
+	return 0;
+}
+
+extern void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
+
+static inline void arch_handle_irq_pipelined(struct pt_regs *regs)
+{
+	handle_arch_irq(regs);
+}
+#else /* !CONFIG_IRQ_PIPELINE */
+static inline unsigned long arch_local_irq_save(void)
+{
+	return native_irq_save();
+}
+
+static inline void arch_local_irq_enable(void)
+{
+	native_irq_enable();
+}
+
+static inline void arch_local_irq_disable(void)
+{
+	native_irq_disable();
+}
+
+static inline unsigned long arch_local_save_flags(void)
+{
+	return native_save_flags();
+}
+
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	native_irq_restore(flags);
+}
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return native_irqs_disabled_flags(flags);
+}
+
+#endif /* CONFIG_IRQ_PIPELINE */
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
+
+#endif /* _ASM_RISCV_IRQ_PIPELINE_H */
diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index 08d4d6a5b7e9..6a857e6f4919 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -3,7 +3,6 @@
  * Copyright (C) 2012 Regents of the University of California
  */
 
-
 #ifndef _ASM_RISCV_IRQFLAGS_H
 #define _ASM_RISCV_IRQFLAGS_H
 
@@ -11,45 +10,54 @@
 #include <asm/csr.h>
 
 /* read interrupt enabled status */
-static inline unsigned long arch_local_save_flags(void)
+static inline unsigned long native_save_flags(void)
 {
 	return csr_read(CSR_STATUS);
 }
 
 /* unconditionally enable interrupts */
-static inline void arch_local_irq_enable(void)
+static inline void native_irq_enable(void)
 {
 	csr_set(CSR_STATUS, SR_IE);
 }
 
 /* unconditionally disable interrupts */
-static inline void arch_local_irq_disable(void)
+static inline void native_irq_disable(void)
 {
 	csr_clear(CSR_STATUS, SR_IE);
 }
 
+static inline void native_irq_sync(void)
+{
+	native_irq_enable();
+	asm volatile("fence" : : : "memory");
+	native_irq_disable();
+}
+
 /* get status and disable interrupts */
-static inline unsigned long arch_local_irq_save(void)
+static inline unsigned long native_irq_save(void)
 {
 	return csr_read_clear(CSR_STATUS, SR_IE);
 }
 
 /* test flags */
-static inline int arch_irqs_disabled_flags(unsigned long flags)
+static inline int native_irqs_disabled_flags(unsigned long flags)
 {
 	return !(flags & SR_IE);
 }
 
 /* test hardware interrupt enable bit */
-static inline int arch_irqs_disabled(void)
+static inline int native_irqs_disabled(void)
 {
-	return arch_irqs_disabled_flags(arch_local_save_flags());
+	return native_irqs_disabled_flags(native_save_flags());
 }
 
 /* set interrupt enabled status */
-static inline void arch_local_irq_restore(unsigned long flags)
+static inline void native_irq_restore(unsigned long flags)
 {
 	csr_set(CSR_STATUS, flags & SR_IE);
 }
 
+#include <asm/irq_pipeline.h>
+
 #endif /* _ASM_RISCV_IRQFLAGS_H */
diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index 7030837adc1a..79ad5d6a50c7 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -7,25 +7,32 @@
 #ifndef _ASM_RISCV_MMU_CONTEXT_H
 #define _ASM_RISCV_MMU_CONTEXT_H
 
+#include "asm/mmu_context.h"
 #include <linux/mm_types.h>
 #include <asm-generic/mm_hooks.h>
 
 #include <linux/mm.h>
 #include <linux/sched.h>
+#include <linux/dovetail.h>
+#include <linux/irq_pipeline.h>
+#include <linux/compiler.h>
 
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
-	struct task_struct *task);
+	       struct task_struct *task);
 
 #define activate_mm activate_mm
-static inline void activate_mm(struct mm_struct *prev,
-			       struct mm_struct *next)
+static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
+	unsigned long flags;
+
+	protect_inband_mm(flags);
 	switch_mm(prev, next, NULL);
+	unprotect_inband_mm(flags);
 }
 
 #define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
-			struct mm_struct *mm)
+				   struct mm_struct *mm)
 {
 #ifdef CONFIG_MMU
 	atomic_long_set(&mm->context.id, 0);
@@ -33,6 +40,12 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
+static inline void switch_oob_mm(struct mm_struct *prev, struct mm_struct *next,
+				 struct task_struct *tsk)
+{
+	switch_mm(prev, next, tsk);
+}
+
 DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
 
 #include <asm-generic/mmu_context.h>
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 121fff429dce..5237e28c2b20 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -66,6 +66,12 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	memcpy(args, &regs->a1, 5 * sizeof(args[0]));
 }
 
+static inline unsigned long syscall_get_arg0(struct task_struct *task,
+					     struct pt_regs *regs)
+{
+	return regs->orig_a0;
+}
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 #ifdef CONFIG_64BIT
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 03968c06258c..657fb7c35c16 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
 
 obj-$(CONFIG_CPU_PM)		+= suspend_entry.o suspend.o
+obj-$(CONFIG_IRQ_PIPELINE)		+= irq_pipeline.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate.o hibernate-asm.o
 
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 9cc0a7669271..e3145150465b 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -10,6 +10,7 @@
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
+#include <linux/irq_pipeline.h>
 #include <asm/sbi.h>
 #include <asm/smp.h>
 #include <asm/softirq_stack.h>
@@ -49,7 +50,7 @@ static void init_irq_stacks(void)
 }
 #else
 /* irq stack only needs to be 16 byte aligned - not IRQ_STACK_SIZE aligned. */
-DEFINE_PER_CPU_ALIGNED(ulong [IRQ_STACK_SIZE/sizeof(ulong)], irq_stack);
+DEFINE_PER_CPU_ALIGNED(ulong[IRQ_STACK_SIZE / sizeof(ulong)], irq_stack);
 
 static void init_irq_stacks(void)
 {
@@ -65,29 +66,29 @@ void do_softirq_own_stack(void)
 {
 #ifdef CONFIG_IRQ_STACKS
 	if (on_thread_stack()) {
-		ulong *sp = per_cpu(irq_stack_ptr, smp_processor_id())
-					+ IRQ_STACK_SIZE/sizeof(ulong);
-		__asm__ __volatile(
-		"addi	sp, sp, -"RISCV_SZPTR  "\n"
-		REG_S"  ra, (sp)		\n"
-		"addi	sp, sp, -"RISCV_SZPTR  "\n"
-		REG_S"  s0, (sp)		\n"
-		"addi	s0, sp, 2*"RISCV_SZPTR "\n"
-		"move	sp, %[sp]		\n"
-		"call	__do_softirq		\n"
-		"addi	sp, s0, -2*"RISCV_SZPTR"\n"
-		REG_L"  s0, (sp)		\n"
-		"addi	sp, sp, "RISCV_SZPTR   "\n"
-		REG_L"  ra, (sp)		\n"
-		"addi	sp, sp, "RISCV_SZPTR   "\n"
-		:
-		: [sp] "r" (sp)
-		: "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
-		  "t0", "t1", "t2", "t3", "t4", "t5", "t6",
+		ulong *sp = per_cpu(irq_stack_ptr, smp_processor_id()) +
+			    IRQ_STACK_SIZE / sizeof(ulong);
+		__asm__ __volatile("addi	sp, sp, -" RISCV_SZPTR
+				   "\n" REG_S "  ra, (sp)		\n"
+				   "addi	sp, sp, -" RISCV_SZPTR
+				   "\n" REG_S "  s0, (sp)		\n"
+				   "addi	s0, sp, 2*" RISCV_SZPTR "\n"
+				   "move	sp, %[sp]		\n"
+				   "call	__do_softirq		\n"
+				   "addi	sp, s0, -2*" RISCV_SZPTR
+				   "\n" REG_L "  s0, (sp)		\n"
+				   "addi	sp, sp, " RISCV_SZPTR "\n" REG_L
+				   "  ra, (sp)		\n"
+				   "addi	sp, sp, " RISCV_SZPTR "\n"
+				   :
+				   : [sp] "r"(sp)
+				   : "a0", "a1", "a2", "a3", "a4", "a5", "a6",
+				     "a7", "t0", "t1", "t2", "t3", "t4", "t5",
+				     "t6",
 #ifndef CONFIG_FRAME_POINTER
-		  "s0",
+				     "s0",
 #endif
-		  "memory");
+				     "memory");
 	} else
 #endif
 		__do_softirq();
@@ -95,7 +96,9 @@ void do_softirq_own_stack(void)
 #endif /* CONFIG_SOFTIRQ_ON_OWN_STACK */
 
 #else
-static void init_irq_stacks(void) {}
+static void init_irq_stacks(void)
+{
+}
 #endif /* CONFIG_IRQ_STACKS */
 
 int arch_show_interrupts(struct seq_file *p, int prec)
@@ -112,3 +115,26 @@ void __init init_IRQ(void)
 		panic("No interrupt controller found.");
 	sbi_ipi_init();
 }
+
+DEFINE_PER_CPU(int, irq_nesting);
+
+#ifdef CONFIG_IRQ_PIPELINE
+
+asmlinkage int notrace handle_arch_irq_pipelined(struct pt_regs *regs)
+{
+	if (this_cpu_inc_return(irq_nesting) == 1) {
+		handle_irq_pipelined(regs);
+		this_cpu_dec(irq_nesting);
+		return running_inband() && !arch_irqs_disabled();
+	}
+
+	return handle_irq_pipelined(regs);
+}
+
+#else
+asmlinkage int notrace handle_arch_irq_pipelined(struct pt_regs *regs)
+{
+	return handle_irq_pipelined(regs);
+}
+
+#endif /* CONFIG_IRQ_PIPELINE */
diff --git a/arch/riscv/kernel/irq_pipeline.c b/arch/riscv/kernel/irq_pipeline.c
new file mode 100644
index 000000000000..c5ebd0d2c994
--- /dev/null
+++ b/arch/riscv/kernel/irq_pipeline.c
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/irq.h>
+#include <linux/irq_pipeline.h>
+#include <linux/entry-common.h>
+
+static irqentry_state_t pipeline_enter_rcu(void)
+{
+	irqentry_state_t state = {
+		.exit_rcu = false,
+		.stage_info = IRQENTRY_INBAND_UNSTALLED,
+	};
+
+	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
+		ct_irq_enter();
+		state.exit_rcu = true;
+	} else {
+		rcu_irq_enter_check_tick();
+	}
+
+	return state;
+}
+
+static void pipeline_exit_rcu(irqentry_state_t state)
+{
+	if (state.exit_rcu)
+		ct_irq_exit();
+}
+
+void arch_do_IRQ_pipelined(struct irq_desc *desc)
+{
+	struct pt_regs *regs = raw_cpu_ptr(&irq_pipeline.tick_regs);
+
+	irqentry_state_t state = pipeline_enter_rcu();
+
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	handle_irq_desc(desc);
+	set_irq_regs(old_regs);
+
+	pipeline_exit_rcu(state);
+}
+
+void __init arch_irq_pipeline_init(void)
+{
+	/* no per-arch init. */
+}
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 40420afbb1a0..48201bdbfdbf 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -37,7 +37,7 @@ enum ipi_message_type {
 };
 
 unsigned long __cpuid_to_hartid_map[NR_CPUS] __ro_after_init = {
-	[0 ... NR_CPUS-1] = INVALID_HARTID
+	[0 ... NR_CPUS - 1] = INVALID_HARTID
 };
 
 void __init smp_setup_processor_id(void)
@@ -46,7 +46,7 @@ void __init smp_setup_processor_id(void)
 }
 
 static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
-static int ipi_virq_base __ro_after_init;
+int ipi_virq_base __ro_after_init;
 static int nr_ipi __ro_after_init = IPI_MAX;
 static struct irq_desc *ipi_desc[IPI_MAX] __read_mostly;
 
@@ -77,14 +77,14 @@ static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 
 	atomic_dec(&waiting_for_crash_ipi);
 
-	local_irq_disable();
+	local_irq_disable_full();
 
 #ifdef CONFIG_HOTPLUG_CPU
 	if (cpu_has_hotplug(cpu))
 		cpu_ops[cpu]->cpu_stop();
 #endif
 
-	for(;;)
+	for (;;)
 		wait_for_interrupt();
 }
 #else
@@ -94,24 +94,18 @@ static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 }
 #endif
 
-static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
+static void __send_ipi_mask(const struct cpumask *mask,
+			    enum ipi_message_type op)
 {
 	__ipi_send_mask(ipi_desc[op], mask);
 }
 
-static void send_ipi_single(int cpu, enum ipi_message_type op)
+static void __send_ipi_single(int cpu, enum ipi_message_type op)
 {
 	__ipi_send_mask(ipi_desc[op], cpumask_of(cpu));
 }
 
-#ifdef CONFIG_IRQ_WORK
-void arch_irq_work_raise(void)
-{
-	send_ipi_single(smp_processor_id(), IPI_IRQ_WORK);
-}
-#endif
-
-static irqreturn_t handle_IPI(int irq, void *data)
+static void __handle_IPI(int irq, void *data)
 {
 	int ipi = irq - ipi_virq_base;
 
@@ -140,10 +134,92 @@ static irqreturn_t handle_IPI(int irq, void *data)
 		pr_warn("CPU%d: unhandled IPI%d\n", smp_processor_id(), ipi);
 		break;
 	}
+}
+
+#ifdef CONFIG_IRQ_PIPELINE
+
+static DEFINE_PER_CPU(unsigned long, ipi_messages);
+
+static DEFINE_PER_CPU(unsigned int[IPI_MAX], ipi_counts);
+
+static irqreturn_t handle_IPI(int irq, void *data)
+{
+	unsigned long *pmsg;
+	unsigned int ipinr;
+
+	/*
+	 * Decode in-band IPIs (0..NR_IPI - 1) multiplexed over
+	 * SGI0. Out-of-band IPIs (SGI1, SGI2) have their own
+	 * individual handler.
+	 */
+
+	pmsg = raw_cpu_ptr(&ipi_messages);
+	while (*pmsg) {
+		ipinr = ffs(*pmsg) - 1;
+		clear_bit(ipinr, pmsg);
+		__this_cpu_inc(ipi_counts[ipinr]);
+		__handle_IPI(ipinr, data);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
+{
+	unsigned int cpu;
+
+	/* regular in-band IPI (multiplexed over SGI0). */
+	for_each_cpu(cpu, mask)
+		set_bit(op, &per_cpu(ipi_messages, cpu));
+	wmb();
+	__send_ipi_mask(mask, 0);
+}
 
+static void send_ipi_single(int cpu, enum ipi_message_type op)
+{
+	set_bit(op, &per_cpu(ipi_messages, cpu));
+	wmb();
+	__send_ipi_single(cpu, 0);
+}
+
+void irq_send_oob_ipi(unsigned int irq, const struct cpumask *cpumask)
+{
+	unsigned int op = irq - ipi_virq_base;
+
+	if (WARN_ON(irq_pipeline_debug() &&
+		    (op < OOB_IPI_OFFSET || op >= OOB_IPI_OFFSET + OOB_NR_IPI)))
+		return;
+
+	/* Out-of-band IPI (OP1-2). */
+	__send_ipi_mask(cpumask, op);
+}
+
+#else
+static irqreturn_t handle_IPI(int irq, void *data)
+{
+	__handle_IPI(irq, data);
 	return IRQ_HANDLED;
 }
 
+static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
+{
+	__send_ipi_mask(mask, op);
+}
+
+static void send_ipi_single(int cpu, enum ipi_message_type op)
+{
+	__send_ipi_single(cpu, op);
+}
+
+#endif /* CONFIG_IRQ_PIPELINE */
+
+#ifdef CONFIG_IRQ_WORK
+void arch_irq_work_raise(void)
+{
+	send_ipi_single(smp_processor_id(), IPI_IRQ_WORK);
+}
+#endif
+
 void riscv_ipi_enable(void)
 {
 	int i;
@@ -176,7 +252,7 @@ EXPORT_SYMBOL_GPL(riscv_ipi_for_rfence);
 
 void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence)
 {
-	int i, err;
+	int i, err, inband_nr_ipi;
 
 	if (WARN_ON(ipi_virq_base))
 		return;
@@ -185,11 +261,15 @@ void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence)
 	nr_ipi = min(nr, IPI_MAX);
 	ipi_virq_base = virq;
 
+	inband_nr_ipi = irqs_pipelined() ? 1 : nr_ipi;
+
 	/* Request IPIs */
 	for (i = 0; i < nr_ipi; i++) {
-		err = request_percpu_irq(ipi_virq_base + i, handle_IPI,
-					 "IPI", &ipi_dummy_dev);
-		WARN_ON(err);
+		if (i < inband_nr_ipi) {
+			err = request_percpu_irq(ipi_virq_base + i, handle_IPI,
+						 "IPI", &ipi_dummy_dev);
+			WARN_ON(err);
+		}
 
 		ipi_desc[i] = irq_to_desc(ipi_virq_base + i);
 		irq_set_status_flags(ipi_virq_base + i, IRQ_HIDDEN);
@@ -205,13 +285,13 @@ void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence)
 		static_branch_disable(&riscv_ipi_for_rfence);
 }
 
-static const char * const ipi_names[] = {
-	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
-	[IPI_CALL_FUNC]		= "Function call interrupts",
-	[IPI_CPU_STOP]		= "CPU stop interrupts",
-	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
-	[IPI_IRQ_WORK]		= "IRQ work interrupts",
-	[IPI_TIMER]		= "Timer broadcast interrupts",
+static const char *const ipi_names[] = {
+	[IPI_RESCHEDULE] = "Rescheduling interrupts",
+	[IPI_CALL_FUNC] = "Function call interrupts",
+	[IPI_CPU_STOP] = "CPU stop interrupts",
+	[IPI_CPU_CRASH_STOP] = "CPU stop (for crash dump) interrupts",
+	[IPI_IRQ_WORK] = "IRQ work interrupts",
+	[IPI_TIMER] = "Timer broadcast interrupts",
 };
 
 void show_ipi_stats(struct seq_file *p, int prec)
@@ -222,7 +302,8 @@ void show_ipi_stats(struct seq_file *p, int prec)
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i], cpu));
+			seq_printf(p, "%10u ",
+				   irq_desc_kstat_cpu(ipi_desc[i], cpu));
 		seq_printf(p, " %s\n", ipi_names[i]);
 	}
 }
@@ -266,7 +347,7 @@ void smp_send_stop(void)
 
 	if (num_online_cpus() > 1)
 		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
-			   cpumask_pr_args(cpu_online_mask));
+			cpumask_pr_args(cpu_online_mask));
 }
 
 #ifdef CONFIG_KEXEC_CORE
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 1b8da4e40a4d..457d79d33047 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -263,6 +263,6 @@ asmlinkage __visible void smp_callin(void)
 	 * Disable preemption before enabling interrupts, so we don't try to
 	 * schedule a CPU that hasn't actually started yet.
 	 */
-	local_irq_enable();
+	local_irq_enable_full();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 67d0073fb624..a032415769b6 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2012 Regents of the University of California
  */
 
+#include "asm/irq_pipeline.h"
 #include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -20,21 +21,26 @@
 #include <linux/irq.h>
 #include <linux/kexec.h>
 #include <linux/entry-common.h>
+#include <linux/irq_pipeline.h>
 
 #include <asm/asm-prototypes.h>
 #include <asm/bug.h>
 #include <asm/cfi.h>
 #include <asm/csr.h>
+#include <asm/dovetail.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/syscall.h>
 #include <asm/thread_info.h>
 #include <asm/vector.h>
 #include <asm/irq_stack.h>
+#include <asm/irq_pipeline.h>
 
 int show_unhandled_signals = 1;
 
-static DEFINE_SPINLOCK(die_lock);
+static DEFINE_HARD_SPINLOCK(die_lock);
+
+extern asmlinkage int handle_arch_irq_pipelined(struct pt_regs *regs);
 
 static void dump_kernel_instr(const char *loglvl, struct pt_regs *regs)
 {
@@ -66,7 +72,7 @@ void die(struct pt_regs *regs, const char *str)
 
 	oops_enter();
 
-	spin_lock_irqsave(&die_lock, flags);
+	raw_spin_lock_irqsave(&die_lock, flags);
 	console_verbose();
 	bust_spinlocks(1);
 
@@ -85,7 +91,7 @@ void die(struct pt_regs *regs, const char *str)
 
 	bust_spinlocks(0);
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
-	spin_unlock_irqrestore(&die_lock, flags);
+	raw_spin_unlock_irqrestore(&die_lock, flags);
 	oops_exit();
 
 	if (in_interrupt())
@@ -100,8 +106,8 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 {
 	struct task_struct *tsk = current;
 
-	if (show_unhandled_signals && unhandled_signal(tsk, signo)
-	    && printk_ratelimit()) {
+	if (show_unhandled_signals && unhandled_signal(tsk, signo) &&
+	    printk_ratelimit()) {
 		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
 			tsk->comm, task_pid_nr(tsk), signo, code, addr);
 		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
@@ -113,7 +119,7 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 }
 
 static void do_trap_error(struct pt_regs *regs, int signo, int code,
-	unsigned long addr, const char *str)
+			  unsigned long addr, const char *str)
 {
 	current->thread.bad_cause = regs->cause;
 
@@ -130,39 +136,47 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 #else
 #define __trap_section noinstr
 #endif
-#define DO_ERROR_INFO(name, signo, code, str)					\
-asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
-{										\
-	if (user_mode(regs)) {							\
-		irqentry_enter_from_user_mode(regs);				\
-		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
-		irqentry_exit_to_user_mode(regs);				\
-	} else {								\
-		irqentry_state_t state = irqentry_nmi_enter(regs);		\
-		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
-		irqentry_nmi_exit(regs, state);					\
-	}									\
-}
+#define DO_ERROR_INFO(name, signo, code, str)                               \
+	asmlinkage __visible __trap_section void name(struct pt_regs *regs) \
+	{                                                                   \
+		if (user_mode(regs)) {                                      \
+			irqentry_enter_from_user_mode(regs);                \
+			mark_trap_entry(regs->cause, regs);                 \
+			do_trap_error(regs, signo, code, regs->epc,         \
+				      "Oops - " str);                       \
+			mark_trap_exit(regs->cause, regs);                  \
+			irqentry_exit_to_user_mode(regs);                   \
+		} else {                                                    \
+			irqentry_state_t state = irqentry_nmi_enter(regs);  \
+			mark_trap_entry(regs->cause, regs);                 \
+			do_trap_error(regs, signo, code, regs->epc,         \
+				      "Oops - " str);                       \
+			mark_trap_exit(regs->cause, regs);                  \
+			irqentry_nmi_exit(regs, state);                     \
+		}                                                           \
+	}
 
-DO_ERROR_INFO(do_trap_unknown,
-	SIGILL, ILL_ILLTRP, "unknown exception");
-DO_ERROR_INFO(do_trap_insn_misaligned,
-	SIGBUS, BUS_ADRALN, "instruction address misaligned");
-DO_ERROR_INFO(do_trap_insn_fault,
-	SIGSEGV, SEGV_ACCERR, "instruction access fault");
+DO_ERROR_INFO(do_trap_unknown, SIGILL, ILL_ILLTRP, "unknown exception");
+DO_ERROR_INFO(do_trap_insn_misaligned, SIGBUS, BUS_ADRALN,
+	      "instruction address misaligned");
+DO_ERROR_INFO(do_trap_insn_fault, SIGSEGV, SEGV_ACCERR,
+	      "instruction access fault");
 
-asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *regs)
+asmlinkage __visible __trap_section void
+do_trap_insn_illegal(struct pt_regs *regs)
 {
 	bool handled;
 
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
-		local_irq_enable();
+		mark_trap_entry(regs->cause, regs);
+		local_irq_enable_full();
 
 		handled = riscv_v_first_use_handler(regs);
 
-		local_irq_disable();
+		local_irq_disable_full();
+		mark_trap_exit(regs->cause, regs);
 
 		if (!handled)
 			do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
@@ -179,65 +193,69 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 	}
 }
 
-DO_ERROR_INFO(do_trap_load_fault,
-	SIGSEGV, SEGV_ACCERR, "load access fault");
+DO_ERROR_INFO(do_trap_load_fault, SIGSEGV, SEGV_ACCERR, "load access fault");
 #ifndef CONFIG_RISCV_M_MODE
-DO_ERROR_INFO(do_trap_load_misaligned,
-	SIGBUS, BUS_ADRALN, "Oops - load address misaligned");
-DO_ERROR_INFO(do_trap_store_misaligned,
-	SIGBUS, BUS_ADRALN, "Oops - store (or AMO) address misaligned");
+DO_ERROR_INFO(do_trap_load_misaligned, SIGBUS, BUS_ADRALN,
+	      "Oops - load address misaligned");
+DO_ERROR_INFO(do_trap_store_misaligned, SIGBUS, BUS_ADRALN,
+	      "Oops - store (or AMO) address misaligned");
 #else
 int handle_misaligned_load(struct pt_regs *regs);
 int handle_misaligned_store(struct pt_regs *regs);
 
-asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
+asmlinkage __visible __trap_section void
+do_trap_load_misaligned(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
+		mark_trap_entry(regs->cause, regs);
 		if (handle_misaligned_load(regs))
 			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
-			      "Oops - load address misaligned");
-
+				      "Oops - load address misaligned");
+		mark_trap_exit(regs->cause, regs);
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
-
+		mark_trap_entry(regs->cause, regs);
 		if (handle_misaligned_load(regs))
 			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
-			      "Oops - load address misaligned");
-
+				      "Oops - load address misaligned");
+		mark_trap_exit(regs->cause, regs);
 		irqentry_nmi_exit(regs, state);
 	}
 }
 
-asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
+asmlinkage __visible __trap_section void
+do_trap_store_misaligned(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
-
+		mark_trap_entry(regs->cause, regs);
 		if (handle_misaligned_store(regs))
-			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
+			do_trap_error(
+				regs, SIGBUS, BUS_ADRALN, regs->epc,
 				"Oops - store (or AMO) address misaligned");
-
+		mark_trap_exit(regs->cause, regs);
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
-
+		mark_trap_entry(regs->cause, regs);
 		if (handle_misaligned_store(regs))
-			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
+			do_trap_error(
+				regs, SIGBUS, BUS_ADRALN, regs->epc,
 				"Oops - store (or AMO) address misaligned");
-
+		mark_trap_exit(regs->cause, regs);
 		irqentry_nmi_exit(regs, state);
 	}
 }
 #endif
-DO_ERROR_INFO(do_trap_store_fault,
-	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault");
-DO_ERROR_INFO(do_trap_ecall_s,
-	SIGILL, ILL_ILLTRP, "environment call from S-mode");
-DO_ERROR_INFO(do_trap_ecall_m,
-	SIGILL, ILL_ILLTRP, "environment call from M-mode");
+DO_ERROR_INFO(do_trap_store_fault, SIGSEGV, SEGV_ACCERR,
+	      "store (or AMO) access fault");
+DO_ERROR_INFO(do_trap_ecall_s, SIGILL, ILL_ILLTRP,
+	      "environment call from S-mode");
+DO_ERROR_INFO(do_trap_ecall_m, SIGILL, ILL_ILLTRP,
+	      "environment call from M-mode");
 
 static inline unsigned long get_break_insn_length(unsigned long pc)
 {
@@ -253,14 +271,16 @@ static bool probe_single_step_handler(struct pt_regs *regs)
 {
 	bool user = user_mode(regs);
 
-	return user ? uprobe_single_step_handler(regs) : kprobe_single_step_handler(regs);
+	return user ? uprobe_single_step_handler(regs) :
+			    kprobe_single_step_handler(regs);
 }
 
 static bool probe_breakpoint_handler(struct pt_regs *regs)
 {
 	bool user = user_mode(regs);
 
-	return user ? uprobe_breakpoint_handler(regs) : kprobe_breakpoint_handler(regs);
+	return user ? uprobe_breakpoint_handler(regs) :
+			    kprobe_breakpoint_handler(regs);
 }
 
 void handle_break(struct pt_regs *regs)
@@ -276,8 +296,8 @@ void handle_break(struct pt_regs *regs)
 	if (user_mode(regs))
 		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->epc);
 #ifdef CONFIG_KGDB
-	else if (notify_die(DIE_TRAP, "EBREAK", regs, 0, regs->cause, SIGTRAP)
-								== NOTIFY_STOP)
+	else if (notify_die(DIE_TRAP, "EBREAK", regs, 0, regs->cause,
+			    SIGTRAP) == NOTIFY_STOP)
 		return;
 #endif
 	else if (report_bug(regs->epc, regs) == BUG_TRAP_TYPE_WARN ||
@@ -292,13 +312,17 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
+		mark_trap_entry(regs->cause, regs);
 		handle_break(regs);
+		mark_trap_exit(regs->cause, regs);
 
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
 
+		mark_trap_entry(regs->cause, regs);
 		handle_break(regs);
+		mark_trap_exit(regs->cause, regs);
 
 		irqentry_nmi_exit(regs, state);
 	}
@@ -316,21 +340,24 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
 
 		syscall = syscall_enter_from_user_mode(regs, syscall);
 
+		mark_trap_entry(regs->cause, regs);
 		if (syscall >= 0 && syscall < NR_syscalls)
 			syscall_handler(regs, syscall);
 		else if (syscall != -1)
 			regs->a0 = -ENOSYS;
+		mark_trap_exit(regs->cause, regs);
 
 		syscall_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
 
+		mark_trap_entry(regs->cause, regs);
 		do_trap_error(regs, SIGILL, ILL_ILLTRP, regs->epc,
-			"Oops - environment call from U-mode");
+			      "Oops - environment call from U-mode");
+		mark_trap_entry(regs->cause, regs);
 
 		irqentry_nmi_exit(regs, state);
 	}
-
 }
 
 #ifdef CONFIG_MMU
@@ -338,9 +365,11 @@ asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
 
+	mark_trap_entry(regs->cause, regs);
 	handle_page_fault(regs);
+	mark_trap_exit(regs->cause, regs);
 
-	local_irq_disable();
+	local_irq_disable_full();
 
 	irqentry_exit(regs, state);
 }
@@ -352,7 +381,13 @@ static void noinstr handle_riscv_irq(struct pt_regs *regs)
 
 	irq_enter_rcu();
 	old_regs = set_irq_regs(regs);
+
+#ifdef CONFIG_IRQ_PIPELINE
+	handle_arch_irq_pipelined(regs);
+#else
 	handle_arch_irq(regs);
+#endif
+
 	set_irq_regs(old_regs);
 	irq_exit_rcu();
 }
@@ -362,30 +397,30 @@ asmlinkage void noinstr do_irq(struct pt_regs *regs)
 	irqentry_state_t state = irqentry_enter(regs);
 #ifdef CONFIG_IRQ_STACKS
 	if (on_thread_stack()) {
-		ulong *sp = per_cpu(irq_stack_ptr, smp_processor_id())
-					+ IRQ_STACK_SIZE/sizeof(ulong);
-		__asm__ __volatile(
-		"addi	sp, sp, -"RISCV_SZPTR  "\n"
-		REG_S"  ra, (sp)		\n"
-		"addi	sp, sp, -"RISCV_SZPTR  "\n"
-		REG_S"  s0, (sp)		\n"
-		"addi	s0, sp, 2*"RISCV_SZPTR "\n"
-		"move	sp, %[sp]		\n"
-		"move	a0, %[regs]		\n"
-		"call	handle_riscv_irq	\n"
-		"addi	sp, s0, -2*"RISCV_SZPTR"\n"
-		REG_L"  s0, (sp)		\n"
-		"addi	sp, sp, "RISCV_SZPTR   "\n"
-		REG_L"  ra, (sp)		\n"
-		"addi	sp, sp, "RISCV_SZPTR   "\n"
-		:
-		: [sp] "r" (sp), [regs] "r" (regs)
-		: "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
-		  "t0", "t1", "t2", "t3", "t4", "t5", "t6",
+		ulong *sp = per_cpu(irq_stack_ptr, smp_processor_id()) +
+			    IRQ_STACK_SIZE / sizeof(ulong);
+		__asm__ __volatile("addi	sp, sp, -" RISCV_SZPTR
+				   "\n" REG_S "  ra, (sp)		\n"
+				   "addi	sp, sp, -" RISCV_SZPTR
+				   "\n" REG_S "  s0, (sp)		\n"
+				   "addi	s0, sp, 2*" RISCV_SZPTR "\n"
+				   "move	sp, %[sp]		\n"
+				   "move	a0, %[regs]		\n"
+				   "call	handle_riscv_irq	\n"
+				   "addi	sp, s0, -2*" RISCV_SZPTR
+				   "\n" REG_L "  s0, (sp)		\n"
+				   "addi	sp, sp, " RISCV_SZPTR "\n" REG_L
+				   "  ra, (sp)		\n"
+				   "addi	sp, sp, " RISCV_SZPTR "\n"
+				   :
+				   : [sp] "r"(sp), [regs] "r"(regs)
+				   : "a0", "a1", "a2", "a3", "a4", "a5", "a6",
+				     "a7", "t0", "t1", "t2", "t3", "t4", "t5",
+				     "t6",
 #ifndef CONFIG_FRAME_POINTER
-		  "s0",
+				     "s0",
 #endif
-		  "memory");
+				     "memory");
 	} else
 #endif
 		handle_riscv_irq(regs);
@@ -410,8 +445,9 @@ int is_valid_bugaddr(unsigned long pc)
 #endif /* CONFIG_GENERIC_BUG */
 
 #ifdef CONFIG_VMAP_STACK
-DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
-		overflow_stack)__aligned(16);
+DEFINE_PER_CPU(unsigned long[OVERFLOW_STACK_SIZE / sizeof(long)],
+	       overflow_stack)
+__aligned(16);
 
 asmlinkage void handle_bad_stack(struct pt_regs *regs)
 {
@@ -421,10 +457,10 @@ asmlinkage void handle_bad_stack(struct pt_regs *regs)
 	console_verbose();
 
 	pr_emerg("Insufficient stack space to handle exception!\n");
-	pr_emerg("Task stack:     [0x%016lx..0x%016lx]\n",
-			tsk_stk, tsk_stk + THREAD_SIZE);
-	pr_emerg("Overflow stack: [0x%016lx..0x%016lx]\n",
-			ovf_stk, ovf_stk + OVERFLOW_STACK_SIZE);
+	pr_emerg("Task stack:     [0x%016lx..0x%016lx]\n", tsk_stk,
+		 tsk_stk + THREAD_SIZE);
+	pr_emerg("Overflow stack: [0x%016lx..0x%016lx]\n", ovf_stk,
+		 ovf_stk + OVERFLOW_STACK_SIZE);
 
 	__show_regs(regs);
 	panic("Kernel stack overflow");
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 90d4ba36d1d0..020d5740d338 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2012 Regents of the University of California
  */
 
-
 #include <linux/mm.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
@@ -23,12 +22,12 @@
 #include "../kernel/head.h"
 
 static void die_kernel_fault(const char *msg, unsigned long addr,
-		struct pt_regs *regs)
+			     struct pt_regs *regs)
 {
 	bust_spinlocks(1);
 
-	pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n", msg,
-		addr);
+	pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n",
+		 msg, addr);
 
 	bust_spinlocks(0);
 	die(regs, "Oops");
@@ -50,7 +49,8 @@ static inline void no_context(struct pt_regs *regs, unsigned long addr)
 	if (addr < PAGE_SIZE)
 		msg = "NULL pointer dereference";
 	else {
-		if (kfence_handle_page_fault(addr, regs->cause == EXC_STORE_PAGE_FAULT, regs))
+		if (kfence_handle_page_fault(
+			    addr, regs->cause == EXC_STORE_PAGE_FAULT, regs))
 			return;
 
 		msg = "paging request";
@@ -59,7 +59,8 @@ static inline void no_context(struct pt_regs *regs, unsigned long addr)
 	die_kernel_fault(msg, addr, regs);
 }
 
-static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_fault_t fault)
+static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr,
+				  vm_fault_t fault)
 {
 	if (fault & VM_FAULT_OOM) {
 		/*
@@ -72,7 +73,8 @@ static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_f
 		}
 		pagefault_out_of_memory();
 		return;
-	} else if (fault & (VM_FAULT_SIGBUS | VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE)) {
+	} else if (fault & (VM_FAULT_SIGBUS | VM_FAULT_HWPOISON |
+			    VM_FAULT_HWPOISON_LARGE)) {
 		/* Kernel mode? Handle exceptions or die */
 		if (!user_mode(regs)) {
 			no_context(regs, addr);
@@ -84,8 +86,8 @@ static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_f
 	BUG();
 }
 
-static inline void
-bad_area_nosemaphore(struct pt_regs *regs, int code, unsigned long addr)
+static inline void bad_area_nosemaphore(struct pt_regs *regs, int code,
+					unsigned long addr)
 {
 	/*
 	 * Something tried to access memory that isn't in our memory map.
@@ -93,23 +95,25 @@ bad_area_nosemaphore(struct pt_regs *regs, int code, unsigned long addr)
 	 */
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
+		mark_trap_entry(regs->cause, regs);
 		do_trap(regs, SIGSEGV, code, addr);
+		mark_trap_exit(regs->cause, regs);
 		return;
 	}
 
 	no_context(regs, addr);
 }
 
-static inline void
-bad_area(struct pt_regs *regs, struct mm_struct *mm, int code,
-	 unsigned long addr)
+static inline void bad_area(struct pt_regs *regs, struct mm_struct *mm,
+			    int code, unsigned long addr)
 {
 	mmap_read_unlock(mm);
 
 	bad_area_nosemaphore(regs, code, addr);
 }
 
-static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long addr)
+static inline void vmalloc_fault(struct pt_regs *regs, int code,
+				 unsigned long addr)
 {
 	pgd_t *pgd, *pgd_k;
 	pud_t *pud_k;
@@ -238,6 +242,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (kprobe_page_fault(regs, cause))
 		return;
 
+	mark_trap_entry(regs->cause, regs);
 	/*
 	 * Fault-in kernel-space virtual memory on-demand.
 	 * The 'reference' page table is init_mm.pgd.
@@ -255,7 +260,7 @@ void handle_page_fault(struct pt_regs *regs)
 
 	/* Enable interrupts if they were enabled in the parent context. */
 	if (!regs_irqs_disabled(regs))
-		local_irq_enable();
+		hard_local_irq_enable();
 
 	/*
 	 * If we're in an interrupt, have no user context, or are running
@@ -270,11 +275,14 @@ void handle_page_fault(struct pt_regs *regs)
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 
-	if (!user_mode(regs) && addr < TASK_SIZE && unlikely(!(regs->status & SR_SUM))) {
+	if (!user_mode(regs) && addr < TASK_SIZE &&
+	    unlikely(!(regs->status & SR_SUM))) {
 		if (fixup_exception(regs))
 			return;
 
-		die_kernel_fault("access to user memory without uaccess routines", addr, regs);
+		die_kernel_fault(
+			"access to user memory without uaccess routines", addr,
+			regs);
 	}
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
@@ -347,7 +355,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
 			no_context(regs, addr);
-		return;
+		goto out;
 	}
 
 	/* The fault is fully completed (including releasing mmap lock) */
@@ -371,7 +379,9 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		tsk->thread.bad_cause = cause;
 		mm_fault_error(regs, addr, fault);
-		return;
 	}
+
+out:
+	mark_trap_exit(regs->cause, regs);
 	return;
 }
-- 
2.34.1

