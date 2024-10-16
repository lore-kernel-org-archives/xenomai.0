Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5160918BB89
	for <xenomai@lists.linux.dev>; Wed, 16 Oct 2024 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103722; cv=none; b=pq0A3tZFm+YF1CWWeOv6aYycJsLHUTBEf/PpMmQ4KOp2h4mTQfe98pBsvCz4HsaQhc3oOWyjDvXshnFW2x9VoBpDZmCJtIiHeH/XH3cVzpZuEegxWd7aRflXowZz7ofUn62K29zIWMGkAxyBUMJZbuTvU5yI3DTw4rBHUWiGY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103722; c=relaxed/simple;
	bh=FO4hACUKn5ECAOVf//xBeAOLk19VVw741CUdys5U7Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDU8P1o4D8bOvQvx25MpKguRVm6irneU7+ATHcf6uqWdMK/5wk45aOzK84HN6UziUhPG0xBoYkhgwaetZn2IV4SyG+5NEUizEByWi6/FYv5sSPrGCnBq2qBrrk0Yh0xKK7/nlp5wKygHcczKZ1m4jeIuYZemEqfgRwQZFnZJXzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sz5rcLkV; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sz5rcLkV"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-20c805a0753so1273875ad.0
        for <xenomai@lists.linux.dev>; Wed, 16 Oct 2024 11:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729103718; x=1729708518; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzBxyKA98VciMsYc1mOTVtnu3Mw+VNB99qG8xoWTbh4=;
        b=Sz5rcLkVmHoZgzbgqHjmVmmd1py9wTLNtM8N0qQ1Vnyg2MAC+RJZYNZwkNFqLnFKl5
         jXwSBTS4esNm4c5oxdgQPR0yOvAdyeVf3zoZ8YS+byZxIn9weamcGO1CqL9TDBrif1NV
         v5Pl1B3Det2n8GUytja100Q7ZdG0nwMYI7oP9stVecZiSIHsVVtbkd3hN4Mcl4MDZNFV
         d10NSld4KfGGk3bpKzVwPt8soLlYJKqClkUGPI0mgu9u6z6pMksqDdRknllZQgpbqfUW
         laJw0I7CJx7QUtFecfiytES1AqTjQZgkRfrRnxiiVgdIbrnGEP5O+8DcpwU3yBtbWkCW
         IVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729103718; x=1729708518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzBxyKA98VciMsYc1mOTVtnu3Mw+VNB99qG8xoWTbh4=;
        b=de+6t/P0pSrv5OPy66YfA9GQan+OfRT6K9tpFVVjtrKK/JKutTtDtZmQjIcH8NDEZE
         GhXNZUQYPhOBbsIgkzM9bvgXzJYxqO5R9N2bbLi/Vpv1u/APgMvPTPOTqIyubDyJ4adI
         sfotF1Y7emjlxX8DcFY2yNdlzYBovR159V/iwKKnF9sEsGR9klD0npnfeo6ogMN0+wQ9
         PF0f1tttMwI46hkgjqSPkajQ6tG8FSUdFH7Co/0F7/QQ8ijZ3Hx4kofGk+xZD9mVK4D5
         F7a08Ugu+9I1bt5INfMyQdGVY2T3HuZ3StCNmqCJvJ9hg92azPKbx/tSmlrQ9l2AG2YR
         Jg8w==
X-Gm-Message-State: AOJu0YxON+CBRyGCABUEfomkeJeVqXMaksFGZPsgbbHAYv13QfCCkwhO
	Gjbo9KLPqTnYRE5AYT2So6MGwXl2Ku4RKNhv6mt40wgQZ9M6szBE0YmHMogI3QsPMQSE
X-Google-Smtp-Source: AGHT+IGyq09ja2OTEIAYo9p8tK1gDvNGUjoU3vRUnk2TpdaMsXKytfk3LpBx4oi9L3uBBPiw12JnHA==
X-Received: by 2002:a17:902:d2cc:b0:20c:dbff:b9d8 with SMTP id d9443c01a7336-20d27f0db37mr50814315ad.37.1729103718207;
        Wed, 16 Oct 2024 11:35:18 -0700 (PDT)
Received: from localhost ([38.207.154.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f84534sm31756205ad.9.2024.10.16.11.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:35:17 -0700 (PDT)
From: Zheng Zhang <lz5333885@gmail.com>
To: xenomai@lists.linux.dev
Cc: Zheng Zhang <lz5333885@gmail.com>
Subject: [PATCH 2/6] dovetail: Port Architecture bits related code to Loongarch
Date: Thu, 17 Oct 2024 02:35:01 +0800
Message-ID: <20241016183505.738682-3-lz5333885@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016183505.738682-1-lz5333885@gmail.com>
References: <20241016183505.738682-1-lz5333885@gmail.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. Modify the irq entry code to adapt the generic interrupt
   management provide by irq pipeline.

2. Interrupt mask virtualization arch-specific code is implemented
   to provide real and virtual interrupt control for inband and
   oob stage.

Signed-off-by: Zheng Zhang <lz5333885@gmail.com>
---
 arch/loongarch/include/asm/dovetail.h     |  44 +++++++
 arch/loongarch/include/asm/irq.h          |   2 +
 arch/loongarch/include/asm/irq_pipeline.h | 145 ++++++++++++++++++++++
 arch/loongarch/include/asm/irqflags.h     |  28 +++--
 arch/loongarch/include/asm/ptrace.h       |   3 +-
 arch/loongarch/include/asm/syscall.h      |   6 +
 arch/loongarch/include/asm/thread_info.h  |  17 +++
 arch/loongarch/kernel/Makefile            |   2 +
 arch/loongarch/kernel/asm-offsets.c       |   1 +
 arch/loongarch/kernel/irq.c               |  23 ++++
 arch/loongarch/kernel/irq_pipeline.c      |  34 +++++
 arch/loongarch/kernel/time.c              |   4 +
 arch/loongarch/kernel/traps.c             |  13 +-
 13 files changed, 305 insertions(+), 17 deletions(-)
 create mode 100644 arch/loongarch/include/asm/dovetail.h
 create mode 100644 arch/loongarch/include/asm/irq_pipeline.h
 create mode 100644 arch/loongarch/kernel/irq_pipeline.c

diff --git a/arch/loongarch/include/asm/dovetail.h b/arch/loongarch/include/asm/dovetail.h
new file mode 100644
index 000000000000..da2ca9704b3b
--- /dev/null
+++ b/arch/loongarch/include/asm/dovetail.h
@@ -0,0 +1,44 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2018 Philippe Gerum  <rpm@xenomai.org>.
+ * Copyright (C) 2023 Hao Miao <haomiao19@mails.ucas.ac.cn>.
+ * Copyright (C) 2024 Zhang Zheng <lz5333885@gmail.com>.
+ */
+#ifndef _ASM_LOONGARCH64_DOVETAIL_H
+#define _ASM_LOONGARCH64_DOVETAIL_H
+
+/* LOONGARCH64 traps */
+#define LOONGARCH64_TRAP_FPE		0	/* Delayed fp exception */
+#define LOONGARCH64_TRAP_BP		1	/* Break point */
+#define LOONGARCH64_TRAP_WATCH		2	/* Watch point */
+#define LOONGARCH64_TRAP_RI		3	/* Reserved instruction */
+#define LOONGARCH64_TRAP_FPU		4	/* FPU access */
+#define LOONGARCH64_TRAP_LSX		5	/* LAX access */
+#define LOONGARCH64_TRAP_LASX		6	/* LASX access */
+#define LOONGARCH64_TRAP_LBT		7	/* LBT access */
+#define LOONGARCH64_TRAP_RESERVED	8	/* Reserved exception */
+#define LOONGARCH64_TRAP_ADE		9	/* Wrong memory address access */
+#define LOONGARCH64_TRAP_ALE		10	/* Unaligned memory address access */
+#define LOONGARCH64_TRAP_PAGEFAULT	11	/* Page fault */
+
+#ifdef CONFIG_DOVETAIL
+
+static inline void arch_dovetail_exec_prepare(void)
+{ }
+
+static inline void arch_dovetail_switch_prepare(bool leave_inband)
+{ }
+
+static inline void arch_dovetail_switch_finish(bool enter_inband)
+{
+	extern void restore_fp_current_oob(void);
+	restore_fp_current_oob();
+}
+
+#define arch_dovetail_is_syscall(__nr)	\
+	((__nr) == __NR_prctl)
+
+#endif
+
+#endif /* _ASM_LOONGARCH64_DOVETAIL_H */
diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index 218b4da0ea90..8a8dbe1f3856 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -121,4 +121,6 @@ extern irqreturn_t loongson_ipi_interrupt(int irq, void *dev);
 
 #include <asm-generic/irq.h>
 
+int handle_arch_irq_pipelined(struct pt_regs *regs);
+
 #endif /* _ASM_IRQ_H */
diff --git a/arch/loongarch/include/asm/irq_pipeline.h b/arch/loongarch/include/asm/irq_pipeline.h
new file mode 100644
index 000000000000..92bb4df48b22
--- /dev/null
+++ b/arch/loongarch/include/asm/irq_pipeline.h
@@ -0,0 +1,145 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2018 Philippe Gerum  <rpm@xenomai.org>.
+ * Copyright (C) 2023 Hao Miao <haomiao19@mails.ucas.ac.cn>.
+ * Copyright (C) 2024 Zhang Zheng <lz5333885@gmail.com>.
+ */
+#ifndef _ASM_LOONGARCH64_IRQ_PIPELINE_H
+#define _ASM_LOONGARCH64_IRQ_PIPELINE_H
+
+#include <asm-generic/irq_pipeline.h>
+
+#include <asm/loongarch.h>
+#include <asm/ptrace.h>
+
+#ifdef CONFIG_IRQ_PIPELINE
+
+#define OOB_NR_IPI		2
+#define OOB_IPI_OFFSET		1 /* SGI1 */
+#define TIMER_OOB_IPI		(ipi_irq_base + OOB_IPI_OFFSET)
+#define RESCHEDULE_OOB_IPI	(TIMER_OOB_IPI + 1)
+#define CALL_FUNCTION_OOB_IPI	(RESCHEDULE_OOB_IPI + 1)
+
+extern int ipi_irq_base;
+
+#define CSR_CRME_EMPTY		10
+
+static inline notrace
+unsigned long arch_irqs_virtual_to_native_flags(int stalled)
+{
+	return (!stalled) << CSR_CRMD_IE_SHIFT;
+}
+
+static inline int native_irqs_disabled_flags(unsigned long flags)
+{
+	return !(flags & CSR_CRMD_IE);
+}
+
+static inline notrace
+unsigned long arch_irqs_native_to_virtual_flags(unsigned long flags)
+{
+	return (!!hard_irqs_disabled_flags(flags)) << CSR_CRME_EMPTY;
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
+static inline
+void arch_save_timer_regs(struct pt_regs *dst, struct pt_regs *src)
+{
+	dst->csr_crmd = src->csr_crmd;
+	dst->csr_prmd = src->csr_prmd;
+	dst->orig_a0 = src->orig_a0;
+}
+
+static inline bool arch_steal_pipelined_tick(struct pt_regs *regs)
+{
+	return !(regs->csr_crmd & CSR_CRMD_IE);
+}
+
+static inline int arch_enable_oob_stage(void)
+{
+	return 0;
+}
+
+
+inline void arch_handle_irq_pipelined(struct pt_regs *regs);
+
+#else  /* !CONFIG_IRQ_PIPELINE */
+
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
+#endif /* !CONFIG_IRQ_PIPELINE */
+
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
+
+#endif /* _ASM_LOONGARCH64_IRQ_PIPELINE_H */
diff --git a/arch/loongarch/include/asm/irqflags.h b/arch/loongarch/include/asm/irqflags.h
index 319a8c616f1f..f3c2ea057f72 100644
--- a/arch/loongarch/include/asm/irqflags.h
+++ b/arch/loongarch/include/asm/irqflags.h
@@ -10,8 +10,9 @@
 #include <linux/compiler.h>
 #include <linux/stringify.h>
 #include <asm/loongarch.h>
+#include <asm/irq_pipeline.h>
 
-static inline void arch_local_irq_enable(void)
+static inline void native_irq_enable(void)
 {
 	u32 flags = CSR_CRMD_IE;
 	__asm__ __volatile__(
@@ -21,7 +22,7 @@ static inline void arch_local_irq_enable(void)
 		: "memory");
 }
 
-static inline void arch_local_irq_disable(void)
+static inline void native_irq_disable(void)
 {
 	u32 flags = 0;
 	__asm__ __volatile__(
@@ -31,7 +32,14 @@ static inline void arch_local_irq_disable(void)
 		: "memory");
 }
 
-static inline unsigned long arch_local_irq_save(void)
+static inline void native_irq_sync(void)
+{
+	native_irq_enable();
+	barrier();
+	native_irq_disable();
+}
+
+static inline unsigned long native_irq_save(void)
 {
 	u32 flags = 0;
 	__asm__ __volatile__(
@@ -42,7 +50,7 @@ static inline unsigned long arch_local_irq_save(void)
 	return flags;
 }
 
-static inline void arch_local_irq_restore(unsigned long flags)
+static inline void native_irq_restore(unsigned long flags)
 {
 	__asm__ __volatile__(
 		"csrxchg %[val], %[mask], %[reg]\n\t"
@@ -51,7 +59,7 @@ static inline void arch_local_irq_restore(unsigned long flags)
 		: "memory");
 }
 
-static inline unsigned long arch_local_save_flags(void)
+static inline unsigned long native_save_flags(void)
 {
 	u32 flags;
 	__asm__ __volatile__(
@@ -62,16 +70,10 @@ static inline unsigned long arch_local_save_flags(void)
 	return flags;
 }
 
-static inline int arch_irqs_disabled_flags(unsigned long flags)
-{
-	return !(flags & CSR_CRMD_IE);
-}
 
-static inline int arch_irqs_disabled(void)
+static inline int native_irqs_disabled(void)
 {
-	return arch_irqs_disabled_flags(arch_local_save_flags());
+	return native_irqs_disabled_flags(native_save_flags());
 }
 
 #endif /* #ifndef __ASSEMBLY__ */
-
-#endif /* _ASM_IRQFLAGS_H */
diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
index f3ddaed9ef7f..86ec684e51bd 100644
--- a/arch/loongarch/include/asm/ptrace.h
+++ b/arch/loongarch/include/asm/ptrace.h
@@ -6,7 +6,6 @@
 #define _ASM_PTRACE_H
 
 #include <asm/page.h>
-#include <asm/irqflags.h>
 #include <asm/thread_info.h>
 #include <uapi/asm/ptrace.h>
 
@@ -35,7 +34,7 @@ struct pt_regs {
 
 static inline int regs_irqs_disabled(struct pt_regs *regs)
 {
-	return arch_irqs_disabled_flags(regs->csr_prmd);
+	return !(regs->csr_prmd & CSR_CRMD_IE);
 }
 
 static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loongarch/include/asm/syscall.h
index e286dc58476e..2fcc6f72e94b 100644
--- a/arch/loongarch/include/asm/syscall.h
+++ b/arch/loongarch/include/asm/syscall.h
@@ -61,6 +61,12 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	memcpy(&args[1], &regs->regs[5], 5 * sizeof(long));
 }
 
+static inline unsigned long syscall_get_arg0(struct task_struct *task,
+					     struct pt_regs *regs)
+{
+	return regs->orig_a0;
+}
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_LOONGARCH64;
diff --git a/arch/loongarch/include/asm/thread_info.h b/arch/loongarch/include/asm/thread_info.h
index 8cb653d49a54..4e544d6237b8 100644
--- a/arch/loongarch/include/asm/thread_info.h
+++ b/arch/loongarch/include/asm/thread_info.h
@@ -12,6 +12,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <dovetail/thread_info.h>
 #include <asm/processor.h>
 
 /*
@@ -24,12 +25,14 @@
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
 	unsigned long		flags;		/* low level flags */
+	unsigned long		local_flags;	/* local (synchronous) flags */
 	unsigned long		tp_value;	/* thread pointer */
 	__u32			cpu;		/* current CPU */
 	int			preempt_count;	/* 0 => preemptible, <0 => BUG */
 	struct pt_regs		*regs;
 	unsigned long		syscall;	/* syscall number */
 	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
+	struct oob_thread_state	oob_state;
 };
 
 /*
@@ -40,9 +43,11 @@ struct thread_info {
 	.task		= &tsk,			\
 	.flags		= _TIF_FIXADE,		\
 	.cpu		= 0,			\
+ 	.local_flags	= 0,	\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
 }
 
+#define ti_local_flags(__ti)	((__ti)->local_flags)
 /* How to get the thread information struct from C. */
 register struct thread_info *__current_thread_info __asm__("$tp");
 
@@ -86,6 +91,8 @@ register unsigned long current_stack_pointer __asm__("$sp");
 #define TIF_LASX_CTX_LIVE	18	/* LASX context must be preserved */
 #define TIF_USEDLBT		19	/* LBT was used by this task this quantum (SMP) */
 #define TIF_LBT_CTX_LIVE	20	/* LBT context must be preserved */
+#define TIF_RETUSER		21	/* INBAND_TASK_RETUSER is pending */
+#define TIF_MAYDAY		22	/* Emergency trap pending */
 
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
@@ -105,6 +112,16 @@ register unsigned long current_stack_pointer __asm__("$sp");
 #define _TIF_LASX_CTX_LIVE	(1<<TIF_LASX_CTX_LIVE)
 #define _TIF_USEDLBT		(1<<TIF_USEDLBT)
 #define _TIF_LBT_CTX_LIVE	(1<<TIF_LBT_CTX_LIVE)
+#define _TIF_RETUSER		(1 << TIF_RETUSER)
+#define _TIF_SINGLESTEP         (1<<TIF_SINGLESTEP)
+
+/*
+ * Local (synchronous) thread flags.
+ */
+#define _TLF_OOB		0x0001
+#define _TLF_DOVETAIL		0x0002
+#define _TLF_OFFSTAGE		0x0004
+#define _TLF_OOBTRAP		0x0008
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_THREAD_INFO_H */
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 4fcc168f0732..c1086fcf8c0b 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -57,6 +57,8 @@ obj-$(CONFIG_MAGIC_SYSRQ)	+= sysrq.o
 
 obj-$(CONFIG_RELOCATABLE)	+= relocate.o
 
+obj-$(CONFIG_IRQ_PIPELINE) += irq_pipeline.o
+
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index 8da0726777ed..02c4279f7ffb 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -81,6 +81,7 @@ void output_thread_info_defines(void)
 	COMMENT("LoongArch thread_info offsets.");
 	OFFSET(TI_TASK, thread_info, task);
 	OFFSET(TI_FLAGS, thread_info, flags);
+	OFFSET(TI_LOCAL_FLAGS, thread_info, local_flags);
 	OFFSET(TI_TP_VALUE, thread_info, tp_value);
 	OFFSET(TI_CPU, thread_info, cpu);
 	OFFSET(TI_PRE_COUNT, thread_info, preempt_count);
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index 883e5066ae44..f9e868cf8e4c 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -16,6 +16,7 @@
 #include <linux/seq_file.h>
 #include <linux/kallsyms.h>
 #include <linux/uaccess.h>
+#include <linux/irq_pipeline.h>
 
 #include <asm/irq.h>
 #include <asm/loongson.h>
@@ -135,3 +136,25 @@ void __init init_IRQ(void)
 
 	set_csr_ecfg(ECFGF_IP0 | ECFGF_IP1 | ECFGF_IP2 | ECFGF_IPI | ECFGF_PMC);
 }
+
+DEFINE_PER_CPU(int, irq_nesting);
+
+#ifdef CONFIG_IRQ_PIPELINE
+asmlinkage int
+handle_arch_irq_pipelined(struct pt_regs *regs)
+{
+	if (this_cpu_inc_return(irq_nesting) == 1) {
+		handle_irq_pipelined(regs);
+		this_cpu_dec(irq_nesting);
+		return running_inband() && !arch_irqs_disabled();
+	}
+
+	return handle_irq_pipelined(regs);
+}
+#else
+asmlinkage int
+handle_arch_irq_pipelined(struct pt_regs *regs)
+{
+	return handle_irq_pipelined(regs);
+}
+#endif
diff --git a/arch/loongarch/kernel/irq_pipeline.c b/arch/loongarch/kernel/irq_pipeline.c
new file mode 100644
index 000000000000..25352e50dc55
--- /dev/null
+++ b/arch/loongarch/kernel/irq_pipeline.c
@@ -0,0 +1,34 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2018 Philippe Gerum  <rpm@xenomai.org>.
+ * Copyright (C) 2023 Hao Miao <haomiao19@mails.ucas.ac.cn>.
+ * Copyright (C) 2024 Zhang Zheng <lz5333885@gmail.com>.
+ *
+ */
+
+#include <linux/irq.h>
+#include <linux/irq_pipeline.h>
+
+void arch_do_IRQ_pipelined(struct irq_desc *desc)
+{
+	struct pt_regs *regs = raw_cpu_ptr(&irq_pipeline.tick_regs);
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	irq_enter();
+	handle_irq_desc(desc);
+	irq_exit();
+
+	set_irq_regs(old_regs);
+}
+
+
+void __init arch_irq_pipeline_init(void)
+{
+	/* no per-arch init. */
+}
+
+inline void arch_handle_irq_pipelined(struct pt_regs *regs)
+{
+	handle_arch_irq(regs);
+}
diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index 3064af94db9c..a03b62aae83c 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -179,6 +179,10 @@ int constant_clockevent_init(void)
 	if (request_irq(irq, constant_timer_interrupt, IRQF_PERCPU | IRQF_TIMER, "timer", NULL))
 		pr_err("Failed to request irq %d (timer)\n", irq);
 
+#ifdef CONFIG_IRQ_PIPELINE
+	irq_set_percpu_devid(irq);
+#endif
+
 	lpj_fine = get_loops_per_jiffy();
 	pr_info("Constant clock event device register\n");
 
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index aebfc3733a76..f51371d1790e 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -1053,8 +1053,13 @@ asmlinkage void noinstr do_vint(struct pt_regs *regs, unsigned long sp)
 
 	cpu = smp_processor_id();
 
-	if (on_irq_stack(cpu, sp))
-		handle_loongarch_irq(regs);
+	if (on_irq_stack(cpu, sp)) {
+#ifdef CONFIG_IRQ_PIPELINE
+	handle_arch_irq_pipelined(regs);
+#else
+	handle_arch_irq(regs);
+#endif
+	}
 	else {
 		stack = per_cpu(irq_stack, cpu) + IRQ_STACK_START;
 
@@ -1065,7 +1070,11 @@ asmlinkage void noinstr do_vint(struct pt_regs *regs, unsigned long sp)
 		"move	$s0, $sp		\n" /* Preserve sp */
 		"move	$sp, %[stk]		\n" /* Switch stack */
 		"move	$a0, %[regs]		\n"
+#ifdef CONFIG_IRQ_PIPELINE
+		"bl	handle_arch_irq_pipelined		\n"
+#else
 		"bl	handle_loongarch_irq	\n"
+#endif
 		"move	$sp, $s0		\n" /* Restore sp */
 		: /* No outputs */
 		: [stk] "r" (stack), [regs] "r" (regs)
-- 
2.47.0

