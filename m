Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F1618C902
	for <xenomai@lists.linux.dev>; Tue,  3 Sep 2024 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377290; cv=none; b=r0V9VLpf8XaGs4e+Woo0IQ4RKNGzOR0Q2cb4abd9bAeq+pgse9pZhRbZwgNmktpcuaBr1CXB/vqmK9GTB3Kr2ALajj/YN/2xbk/ij2RxYSEQj4uxtiE481N36SRjtzmORMRWKEJozuCKp1i4w4my8gQSuPG92jdGYM8JmdwFxCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377290; c=relaxed/simple;
	bh=9UCze0V0+2vTz8mgO6cCI8U2IEcGveJ6Zo0gRTTQRLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n3zMJiKomqP8pza+j1QvBN6wQBAArQhGk8IwNqjXOCAHaouCw+zJ3kcjLM2AuSo24D1q6+ylonhT0IlYCiE+HH1moqO+7pyCQebuJIF5HOtlH3caq+NszGxaPQ/3b/Dq+W2ZOpNh1GaCkhk0z3hurcWijMctNibgyUDVssO14iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=owqWxp6e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y0uVHMXY; arc=none smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="owqWxp6e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y0uVHMXY"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id E336480009
	for <xenomai@lists.linux.dev>; Tue,  3 Sep 2024 15:27:59 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 1D6127803D9
	for <xenomai@xenomai.org>; Tue,  3 Sep 2024 15:27:59 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725377278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FS/+wcOptex9w0n1+usuiiHNIy2bMHJiFiJUw1KecZM=;
	b=owqWxp6eENMLk4dE2aS6UfgcfoUhnDq+HsOeOuEl+0njFiiu75UW5m7EWPNjvNYBtK1pk6
	N5O1er45S4fhkHkUpcvxN30qkUloORAAlMUreWLd/5UNFiMR1e1x23am7cmAvai/fYpDOY
	ylLYRX15mvBfOuMz/TOzyJX0LDQa9V+1JBg19uM/+hP+BEbgJZiNPD86NJkQMXPr8qeJIn
	AmUzdL4KkSRAncF731GShQh5ERH7jZEEc3QLF7Z8a1gXwQLobj15LKlr6ARJ+Suo6SplRE
	00z6VLo3d8BXgmhrhrgHQUWdC79UmZwf4KSLzB56tpNLdHOJWVSDC9cTow5r3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725377278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FS/+wcOptex9w0n1+usuiiHNIy2bMHJiFiJUw1KecZM=;
	b=y0uVHMXYnLoYYBgIm9LnewmUmd/jqdRFqzKT7UkKyuWJgxg+TbunQqwFnbJks54tX5E8HC
	OeExF1IbJAOApbCA==
To: Jan Kiszka <jan.kiszka@siemens.com>, Henning Schild
 <henning.schild@siemens.com>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Guenter Roeck <linux@roeck-us.net>,
 xenomai@xenomai.org, guocai.he.cn@windriver.com
Subject: Re: sched: Unexpected reschedule of offline CPU#2!
In-Reply-To: <745f219e-1593-4fbd-fa7f-1719ef6f444d@siemens.com>
References: <20190727164450.GA11726@roeck-us.net>
 <20190729093545.GV31381@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907291156170.1791@nanos.tec.linutronix.de>
 <20190729101349.GX31381@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907291235580.1791@nanos.tec.linutronix.de>
 <20190729104745.GA31398@hirez.programming.kicks-ass.net>
 <20190729205059.GA1127@roeck-us.net>
 <alpine.DEB.2.21.1908161217380.1873@nanos.tec.linutronix.de>
 <20190816193208.GA29478@roeck-us.net>
 <alpine.DEB.2.21.1908172219470.1923@nanos.tec.linutronix.de>
 <20210727100018.19d61165@md1za8fc.ad001.siemens.net>
 <745f219e-1593-4fbd-fa7f-1719ef6f444d@siemens.com>
Date: Tue, 03 Sep 2024 17:27:58 +0200
Message-ID: <8734mg92pt.ffs@tglx>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=owqWxp6e;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=y0uVHMXY;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (spool.mail.gandi.net: domain of tglx@linutronix.de designates 193.142.43.55 as permitted sender) smtp.mailfrom=tglx@linutronix.de

On Tue, Jul 27 2021 at 10:46, Jan Kiszka wrote:

Picking up this dead thread again.

> What is supposed to prevent the following in mainline:
>
> CPU 0                   CPU 1                      CPU 2
>
> native_stop_other_cpus                             <INTERRUPT>
>   send_IPI_allbutself                              ...
>                         <INTERRUPT>
>                         sysvec_reboot
>                           stop_this_cpu
>                             set_cpu_online(false)
>                                                    native_smp_send_reschedule(1)
>                                                      if (cpu_is_offline(1)) ...

Nothing. And that's what probably happens if I read the stack trace
correctly.

But we can be slightly smarter about this for the reboot IPI (the NMI
case does not have that issue).

CPU 0                   CPU 1                      CPU 2

native_stop_other_cpus                             <INTERRUPT>
   send_IPI_allbutself                              ...
                         <IPI>
                         sysvec_reboot
                           wait_for_others();
                                                    </INTERRUPT>
                                                    <IPI>
                                                    sysvec_reboot
                                                    wait_for_others();
                           stop_this_cpu();           stop_this_cpu();
                             set_cpu_online(false);     set_cpu_online(false);

Something like the uncompiled below.

Thanks,

        tglx
---
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -68,5 +68,6 @@ bool intel_find_matching_signature(void
 int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type);
 
 extern struct cpumask cpus_stop_mask;
+atomic_t cpus_stop_in_ipi;
 
 #endif /* _ASM_X86_CPU_H */
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -721,7 +721,7 @@ bool xen_set_default_idle(void);
 #define xen_set_default_idle 0
 #endif
 
-void __noreturn stop_this_cpu(void *dummy);
+void __noreturn stop_this_cpu(bool sync);
 void microcode_check(struct cpuinfo_x86 *prev_info);
 void store_cpu_caps(struct cpuinfo_x86 *info);
 
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -791,9 +791,10 @@ bool xen_set_default_idle(void)
 }
 #endif
 
+atomic_t cpus_stop_in_ipi;
 struct cpumask cpus_stop_mask;
 
-void __noreturn stop_this_cpu(void *dummy)
+void __noreturn stop_this_cpu(bool sync)
 {
 	struct cpuinfo_x86 *c = this_cpu_ptr(&cpu_info);
 	unsigned int cpu = smp_processor_id();
@@ -801,6 +802,16 @@ void __noreturn stop_this_cpu(void *dumm
 	local_irq_disable();
 
 	/*
+	 * Account this CPU and loop until the other CPUs reached this
+	 * point. If they don't react, the control CPU will raise an NMI.
+	 */
+	if (sync) {
+		atomic_dec(&cpus_stop_in_ipi);
+		while (atomic_read(&cpus_stop_in_ipi))
+			cpu_relax();
+	}
+
+	/*
 	 * Remove this CPU from the online mask and disable it
 	 * unconditionally. This might be redundant in case that the reboot
 	 * vector was handled late and stop_other_cpus() sent an NMI.
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -788,7 +788,7 @@ static void native_machine_halt(void)
 
 	tboot_shutdown(TB_SHUTDOWN_HALT);
 
-	stop_this_cpu(NULL);
+	stop_this_cpu(false);
 }
 
 static void native_machine_power_off(void)
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -125,7 +125,7 @@ static int smp_stop_nmi_callback(unsigne
 		return NMI_HANDLED;
 
 	cpu_emergency_disable_virtualization();
-	stop_this_cpu(NULL);
+	stop_this_cpu(false);
 
 	return NMI_HANDLED;
 }
@@ -137,7 +137,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_reboot)
 {
 	apic_eoi();
 	cpu_emergency_disable_virtualization();
-	stop_this_cpu(NULL);
+	stop_this_cpu(true);
 }
 
 static int register_stop_handler(void)
@@ -189,6 +189,7 @@ static void native_stop_other_cpus(int w
 	 */
 	cpumask_copy(&cpus_stop_mask, cpu_online_mask);
 	cpumask_clear_cpu(this_cpu, &cpus_stop_mask);
+	atomic_set(&cpus_stop_in_ipi, num_online_cpus() - 1);
 
 	if (!cpumask_empty(&cpus_stop_mask)) {
 		apic_send_IPI_allbutself(REBOOT_VECTOR);
@@ -235,10 +236,12 @@ static void native_stop_other_cpus(int w
 	local_irq_restore(flags);
 
 	/*
-	 * Ensure that the cpus_stop_mask cache lines are invalidated on
-	 * the other CPUs. See comment vs. SME in stop_this_cpu().
+	 * Ensure that the cpus_stop_mask and cpus_stop_in_ipi cache lines
+	 * are invalidated on the other CPUs. See comment vs. SME in
+	 * stop_this_cpu().
 	 */
 	cpumask_clear(&cpus_stop_mask);
+	atomic_set(&cpus_stop_in_ipi, 0);
 }
 
 /*

