Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAAF3033EF
	for <xenomai@lists.linux.dev>; Thu,  5 Feb 2026 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770317607; cv=none; b=VE58mQFR9+jJVSMHsHH0/1mdMx2itUDR+M0ruy0bTmDOd7dS4PujCYrOh11HcmFz4Uhz+ZNw8EkiBGbrtfPkV9MifbtGV0fnQCvk7xtA1p9MBXPvXr3Fkb44oI2mgm1ihnZVztZY1dMPRHUAg1gpkbsK16FTowUGAPAd4zh3qMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770317607; c=relaxed/simple;
	bh=LpFeSpyzOEY9mH87zyLR6FisKVp0P+1PpyrOaaCQeVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K1ySTbm4S4AcwX7L2n3ION1uT+qvpnJeOF5TpgsebtiGSxc34UEVVSKHbXUB78ReNCEqyewMAsEzvrHO4jW9xvc3IoanV9aJGnkhG66BKnmP1PkIiiknre4HUyDBe6aMfthTsrMCZjEfnsqPQd9ZAEZfsL4+14iWBcuPPZ0UD0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=gXR+ty27; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="gXR+ty27"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E79EC44297;
	Thu,  5 Feb 2026 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1770317605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=82d2W4OY7TxmhvDOFpdbe1WUc9MunWoag7X41Z5wwbo=;
	b=gXR+ty27M+5wVa8pEN3FBID5NpvkTjSt5VWnGpI1N58pEikNlzcIT99Ik4WmgtxPbH3eT1
	6ahlTSw8d8Ba73olJaxq845qJZfin3C+fs5wEdJ3jg/+d6ZrYygenCMNBCRvo0HI9ScMpo
	k/IDY/ay1dP7RM0NoXFmR11cmMDOo0m+CzLX1rgRZZ7yVw70OAUFy3br4oQUw1Q1Qgoi8/
	9M7u3+7Z7CF44g4/Ed2/rA+4mT4WgIRh8uahmlYrafSw+rbdWyv6dDQg7iKW+xH4SHXQSl
	XUaurCIrPq0Y96R6XOeKk+v5pXixwm8MFfe7XYPPuhfD4rIa2mtbIXBvBTx/Zg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.18 v2 3/4] arm64: irq_pipeline: Fix
 IPI_KGDB_ROUNDUP and IPI_CPU_BACKTRACE IPIs
In-Reply-To: <20260201-wip-flo-fixes-for-6-18-v2-3-28b30dbcfdf8@siemens.com>
	(Florian Bezdeka's message of "Thu, 05 Feb 2026 15:00:14 +0100")
References: <20260201-wip-flo-fixes-for-6-18-v2-0-28b30dbcfdf8@siemens.com>
	<20260201-wip-flo-fixes-for-6-18-v2-3-28b30dbcfdf8@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 05 Feb 2026 19:53:24 +0100
Message-ID: <87o6m381jv.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeitdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepgfejlefgveeggedvleejpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-State: clean

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Both IPIs (IPI_KGDB_ROUNDUP and IPI_CPU_BACKTRACE) are multiplexed in
> case the IRQ pipelining is enabled, so we have to set an IPI reason
> in both cases.
>
> Both cases were directly calling into the IRQ chip implementation and
> forgot to set the reason. IPIs were ignored on the receiving side at
> the end.
>
> As tracing should be bypassed for all IRQs behind NR_IPI we can not
> call smp_cross_call() - where setting the reason / ipi message takes
> place.
>
> Setting the reason has been factored out into set_ipi_message() which
> can be called with and without IRQ pipelining.
>
> In addition, it is not allowed to call arm64_send_ipi() with ipi != 0
> when CONFIG_IRQ_PIPELINE is active. The following kernel splat is now
> fixed as well:
>

[snip]

>  static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
>  {
> -	unsigned int cpu;
> -
>  	/* regular in-band IPI (multiplexed over SGI0). */
> -	for_each_cpu(cpu, target)
> -		set_bit(ipinr, &per_cpu(ipi_messages, cpu));
> -
> -	wmb();
> +	set_ipi_message(target, ipinr);
>  	__smp_cross_call(target, 0);
>  }

Given the significant amount of time and consequential hair loss
invested in debugging this issue, I would recommend to protect against
overlooking new calls to arm64_send_ipi() which upstream might add in
the future.

For instance (happily untested):

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 3a12956580a35..8acbdce764dfd 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -72,6 +72,15 @@ struct ipi_descs {
 	struct irq_desc *descs[MAX_IPI];
 };
 
+typedef struct ipi_index { unsigned int sgi; } ipi_index_t;
+
+static inline unsigned int ipi_index(ipi_index_t ipi)
+{
+	return ipi.sgi;
+}
+
+static inline ipi_index_t mkipi_inband(unsigned int ipi);
+
 static DEFINE_PER_CPU_READ_MOSTLY(struct ipi_descs, pcpu_ipi_desc);
 
 #define get_ipi_desc(__cpu, __ipi) (per_cpu_ptr(&pcpu_ipi_desc, __cpu)->descs[__ipi])
@@ -913,20 +922,20 @@ static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs
 #endif
 }
 
-static void arm64_send_ipi(const cpumask_t *mask, unsigned int nr)
+static void arm64_send_ipi(const cpumask_t *mask, ipi_index_t ipi)
 {
 	unsigned int cpu;
 
 	if (!percpu_ipi_descs)
-		__ipi_send_mask(get_ipi_desc(0, nr), mask);
+		__ipi_send_mask(get_ipi_desc(0, ipi_index(ipi)), mask);
 	else
 		for_each_cpu(cpu, mask)
-			__ipi_send_single(get_ipi_desc(cpu, nr), cpu);
+			__ipi_send_single(get_ipi_desc(cpu, ipi_index(ipi)), cpu);
 }
 
 static void arm64_backtrace_ipi(cpumask_t *mask)
 {
-	arm64_send_ipi(mask, IPI_CPU_BACKTRACE);
+	arm64_send_ipi(mask, mkipi_inband(IPI_CPU_BACKTRACE));
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
@@ -1020,6 +1029,18 @@ static void do_handle_IPI(int ipinr)
 
 #ifdef CONFIG_IRQ_PIPELINE
 
+static inline ipi_index_t mkipi_inband(unsigned int ipi)
+{
+	WARN_ON(ipi >= OOB_IPI_OFFSET);
+	return (struct ipi_index){ .sgi = ipi };
+}
+
+static inline ipi_index_t mkipi_oob(unsigned int ipi)
+{
+	WARN_ON(ipi < OOB_IPI_OFFSET || ipi > OOB_IPI_OFFSET + OOB_NR_IPI - 1);
+	return (struct ipi_index){ .sgi = ipi };
+}
+
 static inline void map_oob_ipis(int cpu)
 {
 	int ipi;
@@ -1044,12 +1065,6 @@ static void ipi_setup_oob_lpi(int ncpus)
 		map_oob_ipis(cpu);
 }
 
-static void __smp_cross_call(const struct cpumask *target, unsigned int ipinr)
-{
-	trace_ipi_raise(target, ipi_types[ipinr]);
-	arm64_send_ipi(target, ipinr);
-}
-
 static DEFINE_PER_CPU(unsigned long, ipi_messages);
 
 static DEFINE_PER_CPU(unsigned int [NR_IPI], ipi_counts);
@@ -1084,7 +1099,8 @@ static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 		set_bit(ipinr, &per_cpu(ipi_messages, cpu));
 
 	wmb();
-	__smp_cross_call(target, 0);
+	trace_ipi_raise(target, ipi_types[0]);
+	arm64_send_ipi(target, mkipi_inband(0));
 }
 
 static unsigned int get_ipi_count(int ipi, unsigned int cpu)
@@ -1092,22 +1108,30 @@ static unsigned int get_ipi_count(int ipi, unsigned int cpu)
 	return per_cpu(ipi_counts, cpu)[ipi];
 }
 
-void irq_send_oob_ipi(unsigned int irq, const struct cpumask *cpumask)
+void irq_send_oob_ipi(unsigned int irq, const struct cpumask *target)
 {
-	unsigned int sgi = irq - ipi_irq_base;
-
-	if (WARN_ON(irq_pipeline_debug() &&
-		    (sgi < OOB_IPI_OFFSET ||
-		     sgi >= OOB_IPI_OFFSET + OOB_NR_IPI)))
-		return;
+	unsigned int ipi = irq - ipi_irq_base;
 
 	/* Out-of-band IPI (SGI1-3). */
-	__smp_cross_call(cpumask, sgi);
+	wmb();
+	trace_ipi_raise(target, ipi_types[ipi]);
+	arm64_send_ipi(target, mkipi_oob(ipi));
 }
 EXPORT_SYMBOL_GPL(irq_send_oob_ipi);
 
 #else
 
+static inline ipi_index_t mkipi_inband(unsigned int ipi)
+{
+	WARN_ON(ipi >= MAX_IPI);
+	return (struct ipi_index_t){ .sgi = ipi };
+}
+
+static inline ipi_index_t mkipi_oob(unsigned int ipi)
+{
+	BUG();
+}
+
 static inline void ipi_setup_oob_sgi(void)
 { }
 
@@ -1125,7 +1149,7 @@ static irqreturn_t ipi_handler(int irq, void *data)
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
 	trace_ipi_raise(target, ipi_types[ipinr]);
-	arm64_send_ipi(target, ipinr);
+	arm64_send_ipi(target, mkipi_inband(ipinr));
 }
 
 static unsigned int get_ipi_count(int ipi, unsigned int cpu)
 
-- 
Philippe.
