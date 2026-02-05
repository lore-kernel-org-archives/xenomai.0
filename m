Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCEC3EF0AA
	for <xenomai@lists.linux.dev>; Thu,  5 Feb 2026 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300024; cv=none; b=I0J2DVgq1nAtM2f1HGTf9YlOdRVOYPXTG59pJDbSk+fM1ifxFb1bCPO4dLTyG5ZKq9B6eFkZLpG7y8aVued6Z/gWhQ3CWCeds7LJyDS8MD8eukSXZUhaW6vIhwgEHq10O78TZGBSUD3RG23lRiUDzxesy4mLE8fmWtXsfUpm8qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300024; c=relaxed/simple;
	bh=qWMxiwHgfzBXFc5fsBe/JmpoS2UFF5oT1zEhbejhyj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SCZ0GqrqJda3j/sWK5DLgsim3VxnHTkdVvW5TdLW2ZBN+pWL4PniiHO0orlPtuUR12oVfrxGVvjfpCw1pYjWpcdC7UORTb8333liUnLWw+cDVP2Hn4YFxAYCQb+G6iG5eao1q7vww7+omTHoz5tA/KjyB/nOkDRcTjdE6rGBOCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=hpN4j0h9; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="hpN4j0h9"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026020514001587b095480300020784
        for <xenomai@lists.linux.dev>;
        Thu, 05 Feb 2026 15:00:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=I6UsXsmwjZF4aLNfGekXhhDVmkLGgZHsQAegnYUHs8k=;
 b=hpN4j0h9OC/rJoqJ5ngPpDDeWQ6N2MLHxJJHszZL8k30Y+vBWxwaPtwFCOPrQ9G7KZjPMs
 bOAKDbTw3sFguJTKYjwIooSBDcmj7ZfTpZ25uy0PCSa/SxXGYBTYzKvky5/I8Bz//dbhW9S6
 ypdavN4LRW/1XKVMr1GKCNwOQrDoiVKhhzZ8yC23cmXEMqU9m8rvb533NZPpkkLKLNzIpi3M
 VhxpWNvHsh6yNZ6Uy/livifmOykvwYdihc9/N54qe4DWtCsDZ4wfKbcl4Cs7zaxZbiBl9Ymk
 0SSjrphlL4iQ32x9vgS5Ze/wZyWSZIyeVfDCMOi0CIn2Ql3Gnfi9hngg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 05 Feb 2026 15:00:14 +0100
Subject: [PATCH Dovetail 6.18 v2 3/4] arm64: irq_pipeline: Fix
 IPI_KGDB_ROUNDUP and IPI_CPU_BACKTRACE IPIs
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-wip-flo-fixes-for-6-18-v2-3-28b30dbcfdf8@siemens.com>
References: <20260201-wip-flo-fixes-for-6-18-v2-0-28b30dbcfdf8@siemens.com>
In-Reply-To: <20260201-wip-flo-fixes-for-6-18-v2-0-28b30dbcfdf8@siemens.com>
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
call smp_cross_call() - where setting the reason / ipi message takes
place.

Setting the reason has been factored out into set_ipi_message() which
can be called with and without IRQ pipelining.

In addition, it is not allowed to call arm64_send_ipi() with ipi != 0
when CONFIG_IRQ_PIPELINE is active. The following kernel splat is now
fixed as well:

[  115.357495] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000048
[  115.358088] Mem abort info:
[  115.358216]   ESR = 0x0000000096000004
[  115.358394]   EC = 0x25: DABT (current EL), IL = 32 bits
[  115.358624]   SET = 0, FnV = 0
[  115.358762]   EA = 0, S1PTW = 0
[  115.358910]   FSC = 0x04: level 0 translation fault
[  115.359117] Data abort info:
[  115.359254]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  115.359498]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  115.359718]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  115.359990] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000042d15000
[  115.360386] [0000000000000048] pgd=0000000000000000, p4d=0000000000000000
[  115.361730] Internal error: Oops: 0000000096000004 [#1]  SMP
[  115.361868] Modules linked in: cfg80211 rfkill drm fuse drm_panel_orientation_quirks ipv6
[  115.362470] CPU: 1 UID: 0 PID: 15 Comm: rcu_preempt Not tainted 6.18.2 #1 PREEMPT
[  115.362533] Hardware name: linux,dummy-virt (DT)
[  115.362561] IRQ stage: Linux
[  115.362746] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  115.362794] pc : __ipi_send_mask+0x18/0x108
[  115.363335] lr : arm64_backtrace_ipi+0xa8/0xc0
[  115.363372] sp : ffff80008215b840
[  115.363388] x29: ffff80008215b840 x28: 0000000000000080 x27: ffff800081cfeec0
[  115.363481] x26: ffff8000818b6000 x25: ffffffffffffffff x24: 0000000000000040
[  115.363505] x23: 0000000000000001 x22: ffff800080041080 x21: ffff800082089d98
[  115.363527] x20: ffff800081c72e40 x19: 0000000000000030 x18: 000000000000019b
[  115.363548] x17: 74666f7320303030 x16: 3030303030303030 x15: 0000000000000001
[  115.363569] x14: 0000000000000000 x13: 3a30207355504320 x12: ffff800081c8de70
[  115.363590] x11: 0000000000000058 x10: 0000000000000018 x9 : ffff800081c8de70
[  115.363633] x8 : 000000000000019c x7 : ffff800081ce5e70 x6 : ffff800081ce5e70
[  115.363654] x5 : ffff00001fec25c8 x4 : 0000000000000000 x3 : 0000000000000000
[  115.363674] x2 : ffff7fff9e316000 x1 : ffff800081c72e40 x0 : 0000000000000000
[  115.363805] Call trace:
[  115.364002]  __ipi_send_mask+0x18/0x108 (P)
[  115.364213]  arm64_backtrace_ipi+0xa8/0xc0
[  115.364266]  nmi_trigger_cpumask_backtrace+0x1e0/0x1f4
[  115.364295]  arch_trigger_cpumask_backtrace+0x18/0x24
[  115.364315]  dump_cpu_task+0x74/0x80
[  115.364337]  rcu_dump_cpu_stacks+0x150/0x1b8
[  115.364356]  rcu_sched_clock_irq+0xc7c/0xebc
[  115.364377]  update_process_times+0x7c/0xe0
[  115.364400]  tick_nohz_handler+0xbc/0x150
[  115.364420]  __hrtimer_run_queues+0x168/0x2f0
[  115.364436]  hrtimer_interrupt+0xec/0x258
[  115.364451]  proxy_irq_handler+0x24/0x40
[  115.364469]  handle_synthetic_irq+0x94/0x1dc
[  115.364503]  handle_irq_desc+0x38/0x5c
[  115.364521]  arch_do_IRQ_pipelined+0x44/0x80
[  115.364538]  sync_current_irq_stage+0x160/0x200
[  115.364555]  __inband_irq_enable+0x5c/0x70
[  115.364572]  inband_irq_restore+0x28/0x40
[  115.364589]  resched_cpu+0x98/0xc0
[  115.364606]  force_qs_rnp+0x27c/0x34c
[  115.364623]  rcu_gp_fqs_loop+0x304/0x4c4
[  115.364641]  rcu_gp_kthread+0x130/0x15c
[  115.364659]  kthread+0x144/0x200
[  115.364677]  ret_from_fork+0x10/0x20
[  115.364928] Code: 910003fd a90153f3 9100c013 a9025bf5 (f9400e75)
[  115.365743] ---[ end trace 0000000000000000 ]---
[  115.366033] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[  115.366216] SMP: stopping secondary CPUs
[  116.728391] SMP: failed to stop secondary CPUs 0
[  116.728668] Kernel Offset: disabled
[  116.728691] CPU features: 0x082000,04046800,40004000,0400421b
[  116.728736] Memory Limit: none
[  116.739224] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm64/kernel/smp.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 8d3791ed39e69..53ec370235f93 100644
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
@@ -926,7 +944,10 @@ static void arm64_send_ipi(const cpumask_t *mask, unsigned int nr)
 
 static void arm64_backtrace_ipi(cpumask_t *mask)
 {
-	arm64_send_ipi(mask, IPI_CPU_BACKTRACE);
+	int ipi = IS_ENABLED(CONFIG_IRQ_PIPELINE) ? 0 : IPI_CPU_BACKTRACE;
+
+	set_ipi_message(mask, IPI_CPU_BACKTRACE);
+	arm64_send_ipi(mask, ipi);
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
@@ -943,6 +964,7 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
 #ifdef CONFIG_KGDB
 void kgdb_roundup_cpus(void)
 {
+	int ipi = IS_ENABLED(CONFIG_IRQ_PIPELINE) ? 0 : IPI_KGDB_ROUNDUP;
 	int this_cpu = raw_smp_processor_id();
 	int cpu;
 
@@ -951,7 +973,8 @@ void kgdb_roundup_cpus(void)
 		if (cpu == this_cpu)
 			continue;
 
-		__ipi_send_single(get_ipi_desc(cpu, IPI_KGDB_ROUNDUP), cpu);
+		set_ipi_message(cpumask_of(cpu), IPI_KGDB_ROUNDUP);
+		__ipi_send_single(get_ipi_desc(cpu, ipi), cpu);
 	}
 }
 #endif
@@ -1052,8 +1075,6 @@ static void __smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 	arm64_send_ipi(target, ipinr);
 }
 
-static DEFINE_PER_CPU(unsigned long, ipi_messages);
-
 static DEFINE_PER_CPU(unsigned int [MAX_IPI], ipi_counts);
 
 static irqreturn_t ipi_handler(int irq, void *data)
@@ -1063,7 +1084,7 @@ static irqreturn_t ipi_handler(int irq, void *data)
 
 	/*
 	 * Decode in-band IPIs (0..NR_IPI - 1) multiplexed over
-	 * SGI0. Out-of-band IPIs (SGI1, SGI2) have their own
+	 * SGI0. Out-of-band IPIs (SGI1, SGI2, SGI3) have their own
 	 * individual handler.
 	 */
 	pmsg = raw_cpu_ptr(&ipi_messages);
@@ -1079,13 +1100,8 @@ static irqreturn_t ipi_handler(int irq, void *data)
 
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

