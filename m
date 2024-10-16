Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4F1212F1E
	for <xenomai@lists.linux.dev>; Wed, 16 Oct 2024 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103731; cv=none; b=IjAqX4iI6uFIw3r/H89Mj5S3a59X8x9h1jPkl5eD0Kt00JFLrxAcM6YIJKWvJq9QYxhYLFjx5KvuT7Cci4oLu24Fw2kpdxeEraKbvvMFQH8gGwi9QaQZibL2twXScjzGFV7Rt8xhViRJeeEtA35Mgsu/ma4d1zwvaE4YA1MQpJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103731; c=relaxed/simple;
	bh=EbOA1BH23PtSnRA8Im9cnutFbRE9W2tWr4drzoXksuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/YQ9eTA8Y+XTpQuKZNYHbVFrWxxCHhiM79l6LYMx1v0OTIMlkR6nCwdjoGzh9GcjUgaM7UZR8+BIaN3GEDRpmE1WA8YXJSgPuhRMJN80xlIclx/zV8Kkwr92iHA+gC0+BqLc8nmMY7qlNKp95c4OVVqu5pSpPgw4mEYnhGgfdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6S3NMyf; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6S3NMyf"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7e9fd82f1a5so83728a12.1
        for <xenomai@lists.linux.dev>; Wed, 16 Oct 2024 11:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729103728; x=1729708528; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5k8azSVnolv7FniK1olqkfkCZr9ysdLiGyFHa3TdEY=;
        b=S6S3NMyfZFGWDl4FWNXCdtsPT0ZN+3iLq+m5eCp5KZYswwL0Q/hhCoFMi2SKh0LpJY
         Mgfia4GcNU0PGHXgHfFsQ6zp/yEDEVjcFzlXrEZB9Md32pTKu9Wiy/CHY/nX1wAFZ0Hh
         LyW1qH2AOPE11h9pRk252zfvr/H81th8GspfCB36mnqXdiL5ZHPzVOI/EDUp5dY5iaOB
         E/MWqs7P1JnACrr5SFWDP955pxDQ+7suoBkb8rbBsqa/NWlNxg+AgZoU9ZAbHeI/el6K
         IJrTTj2GwLAFw9HYG4kKIIiEUFNNvoQ5YZ4mLa7waV7Wzxi7gQjYtaIK9B1EqBn7xC6h
         41Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729103728; x=1729708528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5k8azSVnolv7FniK1olqkfkCZr9ysdLiGyFHa3TdEY=;
        b=JIzwOOTB0wtuxqynwoLSNGL5vW/1U1eh7lPoSO47kGD1OoqcEcHF9UL5Tef9pg4fX4
         TVs8J7z/mq0Bf5foTo67uicNZYk+qpev8clc/nkC/Ba0VgGIK7p8l48dWcCw7NSlHTZj
         x5ZfUz3aCrMV6XnxDBnr6P6LikpArcD8hneN4f8wu7JkrLp+Xn0Cu7O1dypq8Gep1gLU
         Bsf+KJdvyuCKU3z0kPe4fUs+eXPLBxRpHNiYPMfkgWMwjy2mfduBNy6wfKlOoSJTUDNN
         fK1RKoHWzA80fgopWxn/wBXdiU9Tw+OSy1lLc+HTSKV3Hpc9ksAVDEEKxd5PZK6VjEY/
         xkkw==
X-Gm-Message-State: AOJu0Yww72HQPvxgIEUSDG2vEUIlgDnDGeYlh/uvUTqfajcaSmNnUNeh
	a9OADNeiicY1B/iDRgVpCSGHAYDzOlQCxfPiQ1d8FXgdRTgfjO+VTXBpn3shvD1KrQ1M
X-Google-Smtp-Source: AGHT+IEl0/g/NIOIStKvSUw8GWWZN38mWca8y9g+cO4xFXE7Z4hg1wBQq8HTQfs+7fOLcghT0ND6jA==
X-Received: by 2002:a05:6a20:e94:b0:1d9:ee1:3bfe with SMTP id adf61e73a8af0-1d90ee13cecmr3440050637.13.1729103728377;
        Wed, 16 Oct 2024 11:35:28 -0700 (PDT)
Received: from localhost ([38.207.154.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774ccebfsm3507322b3a.172.2024.10.16.11.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:35:28 -0700 (PDT)
From: Zheng Zhang <lz5333885@gmail.com>
To: xenomai@lists.linux.dev
Cc: Zheng Zhang <lz5333885@gmail.com>
Subject: [PATCH 5/6] dovetail: Disable irq in mm and fpu's critical area
Date: Thu, 17 Oct 2024 02:35:04 +0800
Message-ID: <20241016183505.738682-6-lz5333885@gmail.com>
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

Disable hardware interrupt in functhion like switch_mm.

Signed-off-by: Zheng Zhang <lz5333885@gmail.com>
---
 arch/loongarch/include/asm/mmu_context.h | 31 +++++++++++++++----
 arch/loongarch/kernel/alternative.c      |  4 +--
 arch/loongarch/kernel/idle.c             |  2 ++
 arch/loongarch/kernel/perf_event.c       |  8 ++---
 arch/loongarch/kernel/smp.c              |  5 +--
 arch/loongarch/kernel/traps.c            | 39 ++++++++++++++++++------
 arch/loongarch/mm/fault.c                |  4 +--
 arch/loongarch/mm/tlb.c                  | 17 ++++++-----
 8 files changed, 76 insertions(+), 34 deletions(-)

diff --git a/arch/loongarch/include/asm/mmu_context.h b/arch/loongarch/include/asm/mmu_context.h
index 9f97c3453b9c..583a32228518 100644
--- a/arch/loongarch/include/asm/mmu_context.h
+++ b/arch/loongarch/include/asm/mmu_context.h
@@ -12,6 +12,7 @@
 #include <linux/mm_types.h>
 #include <linux/smp.h>
 #include <linux/slab.h>
+#include <linux/irq_pipeline.h>
 
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
@@ -99,14 +100,14 @@ static inline void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *
 
 #define switch_mm_irqs_off switch_mm_irqs_off
 
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
+static inline void do_switch_mm(struct mm_struct *prev, struct mm_struct *next,
 			     struct task_struct *tsk)
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 	switch_mm_irqs_off(prev, next, tsk);
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 }
 
 /*
@@ -117,9 +118,27 @@ static inline void destroy_context(struct mm_struct *mm)
 {
 }
 
-#define activate_mm(prev, next)	switch_mm(prev, next, current)
+static inline void
+switch_mm(struct mm_struct *prev, struct mm_struct *next,
+	  struct task_struct *tsk)
+{
+	unsigned long flags;
+
+	protect_inband_mm(flags);
+	do_switch_mm(prev, next, tsk);
+	unprotect_inband_mm(flags);
+}
+
+#define activate_mm(prev, next)	do_switch_mm(prev, next, current)
 #define deactivate_mm(task, mm)	do { } while (0)
 
+static inline void
+switch_oob_mm(struct mm_struct *prev, struct mm_struct *next,
+	      struct task_struct *tsk)
+{
+	do_switch_mm(prev, next, tsk);
+}
+
 /*
  * If mm is currently active, we can't really drop it.
  * Instead, we will get a new one for it.
@@ -130,7 +149,7 @@ drop_mmu_context(struct mm_struct *mm, unsigned int cpu)
 	int asid;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 
 	asid = read_csr_asid() & cpu_asid_mask(&current_cpu_data);
 
@@ -146,7 +165,7 @@ drop_mmu_context(struct mm_struct *mm, unsigned int cpu)
 	cpu_context(cpu, mm) = 0;
 	cpumask_clear_cpu(cpu, mm_cpumask(mm));
 out:
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 }
 
 #endif /* _ASM_MMU_CONTEXT_H */
diff --git a/arch/loongarch/kernel/alternative.c b/arch/loongarch/kernel/alternative.c
index 4ad13847e962..0e24a482c4eb 100644
--- a/arch/loongarch/kernel/alternative.c
+++ b/arch/loongarch/kernel/alternative.c
@@ -160,12 +160,12 @@ static void *__init_or_module text_poke_early(union loongarch_instruction *insn,
 	int i;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 
 	for (i = 0; i < nr; i++)
 		insn[i].word = buf[i].word;
 
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 
 	wbflush();
 	flush_icache_range((unsigned long)insn, (unsigned long)(insn + nr));
diff --git a/arch/loongarch/kernel/idle.c b/arch/loongarch/kernel/idle.c
index 0b5dd2faeb90..5f2778287066 100644
--- a/arch/loongarch/kernel/idle.c
+++ b/arch/loongarch/kernel/idle.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
+#include "asm-generic/irq_pipeline.h"
 #include <linux/cpu.h>
 #include <linux/irqflags.h>
 #include <asm/cpu.h>
@@ -11,6 +12,7 @@
 
 void __cpuidle arch_cpu_idle(void)
 {
+	hard_local_irq_enable();
 	raw_local_irq_enable();
 	__arch_cpu_idle(); /* idle instruction needs irq enabled */
 	raw_local_irq_disable();
diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/perf_event.c
index 0491bf453cd4..c7f99e28e644 100644
--- a/arch/loongarch/kernel/perf_event.c
+++ b/arch/loongarch/kernel/perf_event.c
@@ -289,11 +289,11 @@ static void loongarch_pmu_disable_event(int idx)
 
 	WARN_ON(idx < 0 || idx >= loongarch_pmu.num_counters);
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 	cpuc->saved_ctrl[idx] = loongarch_pmu_read_control(idx) &
 		~M_PERFCTL_COUNT_EVENT_WHENEVER;
 	loongarch_pmu_write_control(idx, cpuc->saved_ctrl[idx]);
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 }
 
 static int loongarch_pmu_event_set_period(struct perf_event *event,
@@ -826,14 +826,14 @@ static void pause_local_counters(void)
 	int ctr = loongarch_pmu.num_counters;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 	do {
 		ctr--;
 		cpuc->saved_ctrl[ctr] = loongarch_pmu_read_control(ctr);
 		loongarch_pmu_write_control(ctr, cpuc->saved_ctrl[ctr] &
 					 ~M_PERFCTL_COUNT_EVENT_WHENEVER);
 	} while (ctr > 0);
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 }
 
 static void resume_local_counters(void)
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index fb2113688842..c455d8c8318c 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2000, 2001 Silicon Graphics, Inc.
  * Copyright (C) 2000, 2001, 2003 Broadcom Corporation
  */
+#include "linux/kern_levels.h"
 #include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
@@ -301,10 +302,10 @@ int loongson_cpu_disable(void)
 #endif
 	set_cpu_online(cpu, false);
 	calculate_cpu_foreign_map();
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 	irq_migrate_all_off_this_cpu();
 	clear_csr_ecfg(ECFG0_IM);
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 	local_flush_tlb_all();
 
 	return 0;
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index f51371d1790e..664323aa5db3 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -484,13 +484,14 @@ asmlinkage void noinstr do_fpe(struct pt_regs *regs, unsigned long fcsr)
 	void __user *fault_addr;
 	irqentry_state_t state = irqentry_enter(regs);
 
+	oob_trap_notify(LOONGARCH64_TRAP_FPE, regs);
 	if (notify_die(DIE_FP, "FP exception", regs, 0, current->thread.trap_nr,
 		       SIGFPE) == NOTIFY_STOP)
 		goto out;
 
 	/* Clear FCSR.Cause before enabling interrupts */
 	write_fcsr(LOONGARCH_FCSR0, fcsr & ~mask_fcsr_x(fcsr));
-	local_irq_enable();
+	hard_local_irq_enable();
 
 	die_if_kernel("FP exception in kernel code", regs);
 
@@ -501,7 +502,8 @@ asmlinkage void noinstr do_fpe(struct pt_regs *regs, unsigned long fcsr)
 	process_fpemu_return(sig, fault_addr, fcsr);
 
 out:
-	local_irq_disable();
+	hard_local_irq_disable();
+	oob_trap_unwind(LOONGARCH64_TRAP_FPE, regs);
 	irqentry_exit(regs, state);
 }
 
@@ -676,8 +678,10 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
 	unsigned long era = exception_era(regs);
 	irqentry_state_t state = irqentry_enter(regs);
 
+
+	oob_trap_notify(LOONGARCH64_TRAP_BP, regs);
 	if (regs->csr_prmd & CSR_PRMD_PIE)
-		local_irq_enable();
+		hard_local_irq_enable();
 
 	if (__get_inst(&opcode, (u32 *)era, user))
 		goto out_sigsegv;
@@ -743,7 +747,9 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
 
 out:
 	if (regs->csr_prmd & CSR_PRMD_PIE)
-		local_irq_disable();
+		hard_local_irq_disable();
+
+	oob_trap_unwind(LOONGARCH64_TRAP_BP, regs);
 
 	irqentry_exit(regs, state);
 	return;
@@ -813,7 +819,7 @@ asmlinkage void noinstr do_ri(struct pt_regs *regs)
 	unsigned int __user *era = (unsigned int __user *)exception_era(regs);
 	irqentry_state_t state = irqentry_enter(regs);
 
-	local_irq_enable();
+	hard_local_irq_enable();
 	current->thread.trap_nr = read_csr_excode();
 
 	if (notify_die(DIE_RI, "RI Fault", regs, 0, current->thread.trap_nr,
@@ -830,7 +836,7 @@ asmlinkage void noinstr do_ri(struct pt_regs *regs)
 	force_sig(status);
 
 out:
-	local_irq_disable();
+	hard_local_irq_disable();
 	irqentry_exit(regs, state);
 }
 
@@ -848,6 +854,19 @@ static void init_restore_fp(void)
 	BUG_ON(!is_fp_enabled());
 }
 
+#ifdef CONFIG_DOVETAIL
+void restore_fp_current_oob(void)
+{
+	unsigned long __flags;
+
+	if (current->mm && used_math() && !is_fpu_owner()) {
+		__flags = hard_preempt_disable();
+		own_fpu_inatomic(1);
+		hard_preempt_enable(__flags);
+	}
+}
+#endif
+
 static void init_restore_lsx(void)
 {
 	enable_lsx();
@@ -905,7 +924,7 @@ asmlinkage void noinstr do_fpu(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
 
-	local_irq_enable();
+	hard_local_irq_enable();
 	die_if_kernel("do_fpu invoked from kernel context!", regs);
 	BUG_ON(is_lsx_enabled());
 	BUG_ON(is_lasx_enabled());
@@ -914,7 +933,7 @@ asmlinkage void noinstr do_fpu(struct pt_regs *regs)
 	init_restore_fp();
 	preempt_enable();
 
-	local_irq_disable();
+	hard_local_irq_disable();
 	irqentry_exit(regs, state);
 }
 
@@ -922,7 +941,7 @@ asmlinkage void noinstr do_lsx(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
 
-	local_irq_enable();
+	hard_local_irq_enable();
 	if (!cpu_has_lsx) {
 		force_sig(SIGILL);
 		goto out;
@@ -936,7 +955,7 @@ asmlinkage void noinstr do_lsx(struct pt_regs *regs)
 	preempt_enable();
 
 out:
-	local_irq_disable();
+	hard_local_irq_disable();
 	irqentry_exit(regs, state);
 }
 
diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
index 1fc2f6813ea0..9d34556dd34c 100644
--- a/arch/loongarch/mm/fault.c
+++ b/arch/loongarch/mm/fault.c
@@ -260,11 +260,11 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 
 	/* Enable interrupt if enabled in parent context */
 	if (likely(regs->csr_prmd & CSR_PRMD_PIE))
-		local_irq_enable();
+		hard_local_irq_enable();
 
 	__do_page_fault(regs, write, address);
 
-	local_irq_disable();
+	hard_local_irq_disable();
 
 	irqentry_exit(regs, state);
 }
diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index 2c0a411f23aa..ee47e07e12d6 100644
--- a/arch/loongarch/mm/tlb.c
+++ b/arch/loongarch/mm/tlb.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
+#include "asm-generic/irq_pipeline.h"
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
@@ -62,7 +63,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 	if (asid_valid(mm, cpu)) {
 		unsigned long size, flags;
 
-		local_irq_save(flags);
+		flags = hard_local_irq_save();
 		start = round_down(start, PAGE_SIZE << 1);
 		end = round_up(end, PAGE_SIZE << 1);
 		size = (end - start) >> (PAGE_SHIFT + 1);
@@ -78,7 +79,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		} else {
 			drop_mmu_context(mm, cpu);
 		}
-		local_irq_restore(flags);
+		hard_local_irq_restore(flags);
 	} else {
 		cpumask_clear_cpu(cpu, mm_cpumask(mm));
 	}
@@ -88,7 +89,7 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
 	unsigned long size, flags;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 	size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
 	size = (size + 1) >> 1;
 	if (size <= (current_cpu_data.tlbsizestlbsets ?
@@ -106,7 +107,7 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	} else {
 		local_flush_tlb_kernel();
 	}
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 }
 
 void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
@@ -141,7 +142,7 @@ static void __update_hugetlb(struct vm_area_struct *vma, unsigned long address,
 	unsigned long lo;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 
 	address &= (PAGE_MASK << 1);
 	write_csr_entryhi(address);
@@ -158,7 +159,7 @@ static void __update_hugetlb(struct vm_area_struct *vma, unsigned long address,
 		tlb_write_indexed();
 	write_csr_pagesize(PS_DEFAULT_SIZE);
 
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 #endif
 }
 
@@ -181,7 +182,7 @@ void __update_tlb(struct vm_area_struct *vma, unsigned long address, pte_t *ptep
 		return;
 	}
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 
 	if ((unsigned long)ptep & sizeof(pte_t))
 		ptep--;
@@ -198,7 +199,7 @@ void __update_tlb(struct vm_area_struct *vma, unsigned long address, pte_t *ptep
 	else
 		tlb_write_indexed();
 
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 }
 
 static void setup_ptwalker(void)
-- 
2.47.0

