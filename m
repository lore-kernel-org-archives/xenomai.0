Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E702C1584
	for <xenomai@lists.linux.dev>; Mon,  2 Feb 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018934; cv=none; b=KAxdPUm8PZUeEGiLpXVBWaqTZNrrkdscUVSR4sMMRgecyPcS+m2hTbZNz72q4g9CToQRCgeYCmljg+kpPHTHTnhZnmoc2ZG8mso7hOlHFEL72Kct447tuK5JUy0HESR2ie8fE2WZ0m0AWIQu/r95F+aXoBpa0rq2i1nolrrgUqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018934; c=relaxed/simple;
	bh=KOH/9ClnlT4/UY4SmKcQ1tzyZo6wn9Kw4lYITrfHctk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fsdz+KvO5AUj+0/B/cyCDRv4dyAmtp6F2Nldp1Odd0f3jWX56tWWTQOLCTfDAkxd5shKt6oopWPwxTpNiqcZn8lOgJAG55knEizNp7Rk5Z3Y4b5w9OCl4zyg5oonLu8+XfjBblKNk43aFudgwHR6ROMfDJTByVH52yxTXW6saG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Q0y7trD3; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Q0y7trD3"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260202075521cf84c2ad650002076a
        for <xenomai@lists.linux.dev>;
        Mon, 02 Feb 2026 08:55:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=sZLUSzdWM2+RJhm1ldsvEYkrGTUe4i5K8H7VVEaUs2U=;
 b=Q0y7trD35gVRX0HrxsPcgZ4f9fD9dB/uKwy26pP0KZFuehMBIXKDZwPj9NsPcjoeP85BOb
 yfJdw3KbWuG3Dih5hQ9xGhIyjG5KL4DjIRxkxDrC/ZWr0I+8laQ/1xuswjqNXJrPJtuZGbJI
 4/fBW10HajxZVxPn78iluHZ84nS+77OxKbrdpKhsKKPKLOciSixQIb2BTxWYOyX9nkiOyaJg
 I7oB5leclvmFUZuAMubfP3mk1asAaikNJOXusOrZoSL2yYP/z1aCfQE42B6sK0PsQYLYRdPx
 Uwxz0nccwlZ2VLBZ6k7Ji2e1BZRLlPFAXaOx+aHtPJOVgs7sjkQtp3qQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Feb 2026 08:55:22 +0100
Subject: [PATCH Dovetail 6.18 3/3] arm64: irq_pipeline: Fix
 IPI_KGDB_ROUNDUP and IPI_CPU_BACKTRACE IPIs
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-wip-flo-fixes-for-6-18-v1-3-91ea07c7eb7e@siemens.com>
References: <20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com>
In-Reply-To: <20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Both IPIs (IPI_KGDB_ROUNDUP and IPI_CPU_BACKTRACE) are multiplexed in
case the IRQ pipelining is enabled, so we have to set an IPI reason
in both cases.

Both cases were directly calling into the IRQ chip implementation and
forgot to set the reason. IPIs were ignored on the receiving side at
the end.

As tracing should be bypassed for all IRQs behind NR_IPI we can not
call smp_cross_call() - where setting the reason / ipi message took
place.

Setting the reason has been factored out into set_ipi_message() which
can be called with and without IRQ pipelining.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm64/kernel/smp.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 716ba0b0c274b..f85392de0e6a6 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -913,6 +913,24 @@ static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs
 #endif
 }
 
+#ifdef CONFIG_IRQ_PIPELINE
+
+DEFINE_PER_CPU(unsigned long, ipi_messages);
+
+static inline void set_ipi_message(const cpumask_t *target, unsigned int ipi)
+{
+	int cpu;
+
+	for_each_cpu(cpu, target)
+		set_bit(ipi, &per_cpu(ipi_messages, cpu));
+
+	wmb();
+}
+#else
+static inline void set_ipi_message(const cpumask_t *target, unsigned int ipi)
+{ }
+#endif
+
 static void arm64_send_ipi(const cpumask_t *mask, unsigned int nr)
 {
 	unsigned int cpu;
@@ -926,6 +944,7 @@ static void arm64_send_ipi(const cpumask_t *mask, unsigned int nr)
 
 static void arm64_backtrace_ipi(cpumask_t *mask)
 {
+	set_ipi_message(mask, IPI_CPU_BACKTRACE);
 	arm64_send_ipi(mask, IPI_CPU_BACKTRACE);
 }
 
@@ -951,6 +970,7 @@ void kgdb_roundup_cpus(void)
 		if (cpu == this_cpu)
 			continue;
 
+		set_ipi_message(cpumask_of(cpu), IPI_KGDB_ROUNDUP);
 		__ipi_send_single(get_ipi_desc(cpu, IPI_KGDB_ROUNDUP), cpu);
 	}
 }
@@ -1047,8 +1067,6 @@ static void __smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 	arm64_send_ipi(target, ipinr);
 }
 
-static DEFINE_PER_CPU(unsigned long, ipi_messages);
-
 static DEFINE_PER_CPU(unsigned int [MAX_IPI], ipi_counts);
 
 static irqreturn_t ipi_handler(int irq, void *data)
@@ -1074,13 +1092,8 @@ static irqreturn_t ipi_handler(int irq, void *data)
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
-	unsigned int cpu;
-
 	/* regular in-band IPI (multiplexed over SGI0). */
-	for_each_cpu(cpu, target)
-		set_bit(ipinr, &per_cpu(ipi_messages, cpu));
-
-	wmb();
+	set_ipi_message(target, ipinr);
 	__smp_cross_call(target, 0);
 }
 

-- 
2.39.5

