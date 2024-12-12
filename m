Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871F020967D
	for <xenomai@lists.linux.dev>; Thu, 12 Dec 2024 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021571; cv=none; b=G/RNv8gesZPZZqtAok4i/oV5ICSFehscBg+gkfZp2nfwZ7e/A9hDP8K2GASemlus1/l3rk61/G8DG7r6w14lJBdy+jMbJVccil25c5aIxCc95d3p02PazRPmPIQzGvTN25Gn4RiAPUN5Hy3HPJr/qVUZ54yymiWBIAdDDXANAc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021571; c=relaxed/simple;
	bh=MoL1puIcbpR48TJ74PV0YRga38x3aYrFR6rXec4ARPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SszYVcot929LZvegc7HJOD7eOP8BYhCqS08R6z+C6ruGq3b7TDXz8NfuB7DuMRAufWYFZMq7puJphaloBJjfcIFNFdcE8JWEDjZnJsDc4dwUpleYybikAeO3kv6K6aw6P1c8iEhRbuMaKDlJW/7y8G7Y2L/UecHotttxjwh6kG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp0Uvib5; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp0Uvib5"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-725ee6f56b4so732477b3a.3
        for <xenomai@lists.linux.dev>; Thu, 12 Dec 2024 08:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734021567; x=1734626367; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpEtBBqxeHm4r8RRKe/LPvE+3heW4ugDqa9q5BbpIao=;
        b=jp0Uvib5uOk+RnelxDg8HzIRgcsWKyWp3o3HkDMzlqyk+BRZg6sd6kcn3U+Sz8n1tT
         hL5I7goCEFvUULD5JpLSPDqyBEOcbsKO1Vd+BEvWDacJL2GK75SVAEVjlcBqIX+rWIhx
         6akvnpx9Hf3uXXh9/o4HxPOPt0WX8jMFoy8UMov9iDD7lz7dKwZnY9MA1U09ek3LpgQ6
         Av4oOkORUP07OUFuz8PRK1AHNsuaVVCgPg80vpKjBkfv6V3o2uMfcPdsc/uoVWKgMPT0
         drMuffq31xV6kKrixi0NE5pkfzwCzQ3LldJGrEBmCoC7GgZcIyBASLKz5lihqLC9BVpw
         1W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734021567; x=1734626367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpEtBBqxeHm4r8RRKe/LPvE+3heW4ugDqa9q5BbpIao=;
        b=UB34wDcjdOrw+93/jWdeW2JhNjc28yYsDTaaa9+onv1tSZx4hHfaok1TS2Lzv45QJr
         G3sxOIE1SRWxO84upEHem2m7IhnQtr4zvgpDTPaabzThQqaZZz0O3jkFE0WNtUtHE0xC
         3E4DGeRlNM5lUGugqTfI1/LdR/i2pe3hMaVLL5NlMOJH9tWygC0qvM7zjw5ZrpQDG4XE
         MxJ0hHRmUqk6qsXUoV4n0XoNjJ4HZVTPDCV4590E99fyU0BU95jxMKnPeMGIx2a9wTg7
         JoATbWQq2l9esWCLm4qzl7DvEoEHhIHdBI6lHVpnIZfiyy4vX1Z5onSOdAhXJ9FrZbch
         AUZg==
X-Gm-Message-State: AOJu0YzLvAAWxzjds42bBS5PnlgpKE9HpxvB0jWSHnpNMFsBrV5synqH
	PjsgdK13EqI9moZwsNYjGLTyH/TI2xGuTsXXDW+dhhiiH+HLu3LX3FNXwWqY
X-Gm-Gg: ASbGncsKiCEM5lEdHjWHp+OjxIeTnMCfR661FbOgZevcbXKbkW3n0erbCeAgJ2ZXt3c
	Ih3nehsQZjWSaCB3URh0gwxRb7dsM99/gPWGbr3dqCOBbgaVKnNl1YZQBysXEgCTiorZ+boCaYP
	eGjGVO1NRmGrZ+ZhxOwaE0yIv0W54+kOCT/8kGqtyjZVN1JueTx9lm9g79EgcP5WUy0CZ5jPNr5
	rXGOs0JvpuUN0u96fc8Z/BOHF5ot84QYkqDxp+q4hPSwVcLjuf4D9uqgU0wO0WkCFWSob3ggIp/
	RMrQ/a0=
X-Google-Smtp-Source: AGHT+IFYDrAVpHxZlQsxvYRWQHe7d9OumIyudVm2c7WsOL3v5W2D5PghbaOSEc1z2Gt2c15jCj69pQ==
X-Received: by 2002:a05:6a00:90a9:b0:729:49a:2db9 with SMTP id d2e1a72fcca58-72906ab396fmr1394994b3a.21.1734021566951;
        Thu, 12 Dec 2024 08:39:26 -0800 (PST)
Received: from 43c7c7756ed8.tail12dc50.ts.net ([223.72.120.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e7c98efbsm8294896b3a.186.2024.12.12.08.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:39:26 -0800 (PST)
From: shannmu <shanmu1901@gmail.com>
To: xenomai@lists.linux.dev
Cc: shannmu <shanmu1901@gmail.com>
Subject: [PATCH] riscv: irq_pipeline: simplify the send and handle operation for ipis
Date: Thu, 12 Dec 2024 16:38:37 +0000
Message-Id: <20241212163837.326938-2-shanmu1901@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212163837.326938-1-shanmu1901@gmail.com>
References: <20241212163837.326938-1-shanmu1901@gmail.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

riscv is different from aarch64 and we don't need to
encode and decode inband ipis multiplexed over `ipi_desc[0]`,
because we can alloc for up to `BITS_PER_TYPE(int)` ipis.
So we could introudce more `OOB_XXX` ipi_message_types
and treat them as inband ipi.

Signed-off-by: shannmu <shanmu1901@gmail.com>
---
 arch/riscv/include/asm/irq_pipeline.h |  18 +++--
 arch/riscv/kernel/sbi-ipi.c           |  10 ++-
 arch/riscv/kernel/smp.c               | 102 ++++++++------------------
 drivers/clocksource/timer-clint.c     |   8 ++
 4 files changed, 59 insertions(+), 79 deletions(-)

diff --git a/arch/riscv/include/asm/irq_pipeline.h b/arch/riscv/include/asm/irq_pipeline.h
index 2ef91c2af706..030823745787 100644
--- a/arch/riscv/include/asm/irq_pipeline.h
+++ b/arch/riscv/include/asm/irq_pipeline.h
@@ -9,17 +9,19 @@
 #ifndef _ASM_RISCV_IRQ_PIPELINE_H
 #define _ASM_RISCV_IRQ_PIPELINE_H
 
-/*
- * Multiplex In-band IPI messages over software interrupt 0
- * as we do in the arm implementation.
- */
 #define OOB_NR_IPI		3
-#define OOB_IPI_OFFSET		1 /* Software interrupt 1 */
-#define TIMER_OOB_IPI		(ipi_virq_base + OOB_IPI_OFFSET)
-#define RESCHEDULE_OOB_IPI	(TIMER_OOB_IPI + 1)
-#define CALL_FUNCTION_OOB_IPI	(RESCHEDULE_OOB_IPI + 1)
+
 
 extern int ipi_virq_base;
+extern int NR_CALL_FUNCTION_OOB_IPI;
+extern int NR_RESCHEDULE_OOB_IPI;
+extern int NR_TIMER_OOB_IPI;
+extern int ipi_max;
+
+#define CALL_FUNCTION_OOB_IPI (ipi_virq_base + NR_CALL_FUNCTION_OOB_IPI)
+#define RESCHEDULE_OOB_IPI (ipi_virq_base + NR_RESCHEDULE_OOB_IPI)
+#define TIMER_OOB_IPI (ipi_virq_base + NR_TIMER_OOB_IPI)
+#define PIPELINED_IPI_MAX ipi_max
 
 #ifdef CONFIG_IRQ_PIPELINE
 
diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
index 0cc5559c08d8..176f4ad3c427 100644
--- a/arch/riscv/kernel/sbi-ipi.c
+++ b/arch/riscv/kernel/sbi-ipi.c
@@ -12,6 +12,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <asm/sbi.h>
+#include <asm/irq_pipeline.h>
 
 DEFINE_STATIC_KEY_FALSE(riscv_sbi_for_rfence);
 EXPORT_SYMBOL_GPL(riscv_sbi_for_rfence);
@@ -57,7 +58,11 @@ void __init sbi_ipi_init(void)
 		return;
 	}
 
+#ifdef CONFIG_IRQ_PIPELINE
+	virq = ipi_mux_create(PIPELINED_IPI_MAX, sbi_send_ipi);
+#else
 	virq = ipi_mux_create(BITS_PER_BYTE, sbi_send_ipi);
+#endif
 	if (virq <= 0) {
 		pr_err("unable to create muxed IPIs\n");
 		irq_dispose_mapping(sbi_ipi_virq);
@@ -74,8 +79,11 @@ void __init sbi_ipi_init(void)
 	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_SBI_IPI_STARTING,
 			  "irqchip/sbi-ipi:starting",
 			  sbi_ipi_starting_cpu, NULL);
-
+#ifdef CONFIG_IRQ_PIPELINE
+	riscv_ipi_set_virq_range(virq, PIPELINED_IPI_MAX);
+#else
 	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
+#endif
 	pr_info("providing IPIs using SBI IPI extension\n");
 
 	/*
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 0af7c992c98f..61da8d273a3f 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include "linux/compiler.h"
 #include <linux/cpu.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
@@ -40,9 +41,24 @@ enum ipi_message_type {
 	IPI_TIMER,
 	IPI_CPU_BACKTRACE,
 	IPI_KGDB_ROUNDUP,
-	IPI_MAX
+#ifdef CONFIG_IRQ_PIPELINE
+	OOB_TIMER_IPI,
+	OOB_RESCHEDULE_IPI,
+	OOB_CALL_FUNCTION_IPI,
+#endif
+	IPI_MAX,
+
 };
 
+#ifdef CONFIG_IRQ_PIPELINE
+#define INBAND_IPI_MAX (IPI_MAX - OOB_NR_IPI)
+int ipi_max __ro_after_init = IPI_MAX;
+int NR_TIMER_OOB_IPI __ro_after_init = OOB_TIMER_IPI;
+int NR_RESCHEDULE_OOB_IPI __ro_after_init = OOB_RESCHEDULE_IPI;
+int NR_CALL_FUNCTION_OOB_IPI __ro_after_init = OOB_CALL_FUNCTION_IPI;
+#endif
+
+
 unsigned long __cpuid_to_hartid_map[NR_CPUS] __ro_after_init = {
 	[0 ... NR_CPUS-1] = INVALID_HARTID
 };
@@ -52,11 +68,11 @@ void __init smp_setup_processor_id(void)
 	cpuid_to_hartid_map(0) = boot_cpu_hartid;
 }
 
-static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
 int ipi_virq_base __ro_after_init;
 static int nr_ipi __ro_after_init = IPI_MAX;
 static struct irq_desc *ipi_desc[IPI_MAX] __read_mostly;
 
+
 int riscv_hartid_to_cpuid(unsigned long hartid)
 {
 	int i;
@@ -143,60 +159,25 @@ static irqreturn_t handle_IPI(int irq, void *data)
 
 #ifdef CONFIG_IRQ_PIPELINE
 
-static DEFINE_PER_CPU(unsigned long, ipi_messages);
-
-static DEFINE_PER_CPU(unsigned int [IPI_MAX], ipi_counts);
-
 void irq_send_oob_ipi(unsigned int irq,
 		const struct cpumask *cpumask)
 {
-	unsigned int sgi = irq - ipi_virq_base;
+	unsigned int op = irq - ipi_virq_base;
 
 	if (WARN_ON(irq_pipeline_debug() &&
-		    (sgi < OOB_IPI_OFFSET ||
-		     sgi >= OOB_IPI_OFFSET + OOB_NR_IPI)))
+		    (op < INBAND_IPI_MAX ||
+		     op >= IPI_MAX)))
 		return;
 
-	__ipi_send_mask(ipi_desc[sgi], cpumask);
-}
-EXPORT_SYMBOL_GPL(irq_send_oob_ipi);
-
-static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
-{
-	unsigned int cpu;
-
-	for_each_cpu(cpu, mask)
-		set_bit(op, &per_cpu(ipi_messages, cpu));
-
-	wmb();
-	__ipi_send_mask(ipi_desc[0], mask);
-}
-
-static void send_ipi_single(int cpu, enum ipi_message_type op)
-{
-	set_bit(op, &per_cpu(ipi_messages, cpu));
+	/* Init oob ipis at first involve*/
+	if (unlikely(ipi_desc[op] == NULL))
+		ipi_desc[op] = irq_to_desc(irq);
 
-	wmb();
-	__ipi_send_mask(ipi_desc[0], cpumask_of(cpu));
-}
-
-static irqreturn_t ipi_handler(int irq, void *data)
-{
-	unsigned long *pmsg;
-	unsigned int ipinr;
-
-	pmsg = raw_cpu_ptr(&ipi_messages);
-	while (*pmsg) {
-		ipinr = ffs(*pmsg) - 1;
-		clear_bit(ipinr, pmsg);
-		__this_cpu_inc(ipi_counts[ipinr]);
-		handle_IPI(ipinr + ipi_virq_base, data);
-	}
-
-	return IRQ_HANDLED;
+	__ipi_send_mask(ipi_desc[op], cpumask);
 }
+EXPORT_SYMBOL_GPL(irq_send_oob_ipi);
 
-#else /* !CONFIG_IRQ_PIPELINE */
+#endif
 
 static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
 {
@@ -208,14 +189,6 @@ static void send_ipi_single(int cpu, enum ipi_message_type op)
 	__ipi_send_mask(ipi_desc[op], cpumask_of(cpu));
 }
 
-static irqreturn_t ipi_handler(int irq, void *data)
-{
-	handle_IPI(irq, data);
-	return IRQ_HANDLED;
-}
-
-#endif /* !CONFIG_IRQ_PIPELINE */
-
 #ifdef CONFIG_IRQ_WORK
 void arch_irq_work_raise(void)
 {
@@ -252,34 +225,23 @@ bool riscv_ipi_have_virq_range(void)
 
 void riscv_ipi_set_virq_range(int virq, int nr)
 {
-	int i, err, inband_nr_ipi;
+	int i, err;
 
 	if (WARN_ON(ipi_virq_base))
 		return;
 
 	WARN_ON(nr < IPI_MAX);
-	nr_ipi = min(nr, IPI_MAX);
-
-	/*
-	 * irq_pipeline: the in-band stage traps a single IPI, over
-	 * which all IPI messages are mutiplexed. Other IPIs are
-	 * available for exchanging out-of-band IPIs.
-	 */
-	inband_nr_ipi = irqs_pipelined() ? 1 : nr_ipi;
 
 	ipi_virq_base = virq;
 
 	/* Request IPIs */
 	for (i = 0; i < nr_ipi; i++) {
-		if (!irqs_pipelined()) {
+#ifdef CONFIG_IRQ_PIPELINE
+		if (i < INBAND_IPI_MAX)
+#endif
 			err = request_percpu_irq(ipi_virq_base + i, handle_IPI,
-						"IPI", &ipi_dummy_dev);
-		} else if (i < inband_nr_ipi) {
-			int err;
-
-			err = request_percpu_irq(ipi_virq_base + i, ipi_handler,
 						 "IPI", &irq_stat);
-		}
+
 		WARN_ON(err);
 
 		ipi_desc[i] = irq_to_desc(ipi_virq_base + i);
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 0bdd9d7ec545..5345e4d373ac 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -243,7 +243,11 @@ static int __init clint_timer_init_dt(struct device_node *np)
 	}
 
 #ifdef CONFIG_SMP
+#ifdef CONFIG_IRQ_PIPELINE
+	rc = ipi_mux_create(PIPELINED_IPI_MAX, clint_send_ipi);
+#else
 	rc = ipi_mux_create(BITS_PER_BYTE, clint_send_ipi);
+#endif
 	if (rc <= 0) {
 		pr_err("unable to create muxed IPIs\n");
 		rc = (rc < 0) ? rc : -ENODEV;
@@ -251,7 +255,11 @@ static int __init clint_timer_init_dt(struct device_node *np)
 	}
 
 	irq_set_chained_handler(clint_ipi_irq, clint_ipi_interrupt);
+#ifdef CONFIG_IRQ_PIPELINE
+	riscv_ipi_set_virq_range(rc, PIPELINED_IPI_MAX);
+#else
 	riscv_ipi_set_virq_range(rc, BITS_PER_BYTE);
+#endif
 	clint_clear_ipi();
 #endif
 
-- 
2.34.1

