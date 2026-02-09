Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5387E344D96
	for <xenomai@lists.linux.dev>; Mon,  9 Feb 2026 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629636; cv=none; b=R5SEPMhLi1X6DuMZdr2gDHeYL4FG/yMpbQUmIuwA53kwYKcd5bBYEFC6dxgFclxbXy4qBnstWNQyRZpCzB5S2/NW49vX0eybGbSbQLOU3b/WLM1VyjINe/nzSnPnU3AZts7nEH51qFQVmRIXvas8oSs5aUyg6aUULhr4oL/DfLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629636; c=relaxed/simple;
	bh=QHtRGfLrdMo0nllbpzp0FMMxDDpjMJciBEnlKZNmEq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AjwWqytbpPK3iWlkIYyxFpe1zIrUOeAkTozIENa7xzZnxxiQ60AUXQDjgpw8EuOF+Zqu8O4YsQkNCke9043onGAuxxVD7W1WzSpFCzpr1TzPg90F+FifMs7Gy/v5EKKjFYy0IWNw2R2NImeqD70ITG4W4Htk6Y9NZOye6AV4JfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=UYJhVWb9; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="UYJhVWb9"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2026020909334750b17b6c8000020708
        for <xenomai@lists.linux.dev>;
        Mon, 09 Feb 2026 10:33:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qzNzuerAbIZUafz71matoL+Om4zwLcELqMLdAwz5aA8=;
 b=UYJhVWb9TVT4YPTlEVSPTrJ+Qg4LjEpUYsSvJ/mH0abU/dsQCNN9E/rPmLimYkJFjIbxLI
 2U+rNUc2MWuPLZnC/s42XoSt45d+VJ9IZ2YhKW3mAjrHgZTkdALIgjgtlq82NUaZBXJ0r3FQ
 /bvqzlzAeqv1LYaluKnb5yaUrc+D/9b79uRtctYsMbwBdUiYBzM8Id2tDDXgB6PGwmEZu7yM
 ycA6bNTotXgg0IZvU7StlMVKyex8kr2JpkgtXPvBKp9nzvEOx6aewhis+0ZqNWKNbN/vBxzm
 Ygc+s/a0sE2hcQAFkoupls8kwScHFRJkftTzAemtvXVPpZD3OpD1wdlA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 09 Feb 2026 10:33:37 +0100
Subject: [PATCH Dovetail 6.18 v3 3/3] arm64: irq_pipeline: Fix
 IPI_KGDB_ROUNDUP and IPI_CPU_BACKTRACE IPIs
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-wip-flo-fixes-for-6-18-v3-3-4f980378bbde@siemens.com>
References: <20260209-wip-flo-fixes-for-6-18-v3-0-4f980378bbde@siemens.com>
In-Reply-To: <20260209-wip-flo-fixes-for-6-18-v3-0-4f980378bbde@siemens.com>
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

End result was the following kernel splat:

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

To address and also catch future calls to amd64_send_ipi() the
signature of this function has been changed.

In the IRQ pipelining case setting the reason for multiplexed IPIs is
now done in the newly introduced mkipi_inband(). That allows us to
remove the pipeline specific version of smp_cross_call().

While at it: Adding some clear trace point descriptions for OOB IPIs.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm64/kernel/smp.c | 108 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 8d3791ed39e6935a63ba351038e4b685e07c05d3..03cfcf231d8102507f1ebafe805f232d18d22ebe 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -913,20 +913,27 @@ static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs
 #endif
 }
 
-static void arm64_send_ipi(const cpumask_t *mask, unsigned int nr)
+struct ipi_index {
+	unsigned int sgi;
+};
+
+static inline struct ipi_index mkipi_inband(unsigned int ipi,
+					    const struct cpumask *target);
+
+static void arm64_send_ipi(const cpumask_t *mask, struct ipi_index ipi)
 {
 	unsigned int cpu;
 
 	if (!percpu_ipi_descs)
-		__ipi_send_mask(get_ipi_desc(0, nr), mask);
+		__ipi_send_mask(get_ipi_desc(0, ipi.sgi), mask);
 	else
 		for_each_cpu(cpu, mask)
-			__ipi_send_single(get_ipi_desc(cpu, nr), cpu);
+			__ipi_send_single(get_ipi_desc(cpu, ipi.sgi), cpu);
 }
 
 static void arm64_backtrace_ipi(cpumask_t *mask)
 {
-	arm64_send_ipi(mask, IPI_CPU_BACKTRACE);
+	arm64_send_ipi(mask, mkipi_inband(IPI_CPU_BACKTRACE, mask));
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
@@ -1020,6 +1027,34 @@ static void do_handle_IPI(int ipinr)
 
 #ifdef CONFIG_IRQ_PIPELINE
 
+static DEFINE_PER_CPU(unsigned long, ipi_messages);
+
+static DEFINE_PER_CPU(unsigned int [MAX_IPI], ipi_counts);
+
+static inline struct ipi_index mkipi_inband(unsigned int ipi,
+					    const struct cpumask *target)
+{
+	unsigned int cpu;
+
+	WARN_ON(ipi >= MAX_IPI);
+
+	/* regular in-band IPI (multiplexed over SGI0). */
+	for_each_cpu(cpu, target)
+		set_bit(ipi, &per_cpu(ipi_messages, cpu));
+
+	/* Write barrier: Make sure ipi_message is set before raising the IPI */
+	wmb();
+
+	/* Multiplex inband IPIs via SGI0 */
+	return (struct ipi_index){ .sgi = 0 };
+}
+
+static inline struct ipi_index mkipi_oob(unsigned int ipi)
+{
+	WARN_ON(ipi < OOB_IPI_OFFSET || ipi > OOB_IPI_OFFSET + OOB_NR_IPI - 1);
+	return (struct ipi_index){ .sgi = ipi };
+}
+
 static inline void map_oob_ipis(int cpu, int ipi_offset)
 {
 	int ipi;
@@ -1046,16 +1081,6 @@ static void ipi_setup_oob_lpi(int ncpus)
 		map_oob_ipis(cpu, nr_ipi);
 }
 
-static void __smp_cross_call(const struct cpumask *target, unsigned int ipinr)
-{
-	trace_ipi_raise(target, ipi_types[ipinr]);
-	arm64_send_ipi(target, ipinr);
-}
-
-static DEFINE_PER_CPU(unsigned long, ipi_messages);
-
-static DEFINE_PER_CPU(unsigned int [MAX_IPI], ipi_counts);
-
 static irqreturn_t ipi_handler(int irq, void *data)
 {
 	unsigned long *pmsg;
@@ -1077,39 +1102,44 @@ static irqreturn_t ipi_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
-{
-	unsigned int cpu;
-
-	/* regular in-band IPI (multiplexed over SGI0). */
-	for_each_cpu(cpu, target)
-		set_bit(ipinr, &per_cpu(ipi_messages, cpu));
-
-	wmb();
-	__smp_cross_call(target, 0);
-}
-
 static unsigned int get_ipi_count(int ipi, unsigned int cpu)
 {
 	return per_cpu(ipi_counts, cpu)[ipi];
 }
 
-void irq_send_oob_ipi(unsigned int irq, const struct cpumask *cpumask)
+static const char *oob_ipi_types[OOB_NR_IPI + 1] __tracepoint_string = {
+	[0]	= "Inband IPI (you should not see this!)",
+	[1]	= "OOB timer IPI",
+	[2]	= "OOB reschedule IPI",
+	[3]	= "OOB function call IPI",
+};
+
+void irq_send_oob_ipi(unsigned int irq, const struct cpumask *target)
 {
-	unsigned int sgi = irq - ipi_irq_base;
+	unsigned int ipi = irq - ipi_irq_base;
 
-	if (WARN_ON(irq_pipeline_debug() &&
-		    (sgi < OOB_IPI_OFFSET ||
-		     sgi >= OOB_IPI_OFFSET + OOB_NR_IPI)))
-		return;
+	WARN_ON(ipi < OOB_IPI_OFFSET);
 
 	/* Out-of-band IPI (SGI1-3). */
-	__smp_cross_call(cpumask, sgi);
+	trace_ipi_raise(target, oob_ipi_types[ipi]);
+	arm64_send_ipi(target, mkipi_oob(ipi));
 }
 EXPORT_SYMBOL_GPL(irq_send_oob_ipi);
 
 #else
 
+static inline struct ipi_index mkipi_inband(unsigned int ipi,
+					    const struct cpumask *target)
+{
+	WARN_ON(ipi >= MAX_IPI);
+	return (struct ipi_index){ .sgi = ipi };
+}
+
+static inline struct ipi_index mkipi_oob(unsigned int ipi)
+{
+	WARN_ON_ONCE(1);
+}
+
 static inline void ipi_setup_oob_sgi(void)
 { }
 
@@ -1124,12 +1154,6 @@ static irqreturn_t ipi_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
-{
-	trace_ipi_raise(target, ipi_types[ipinr]);
-	arm64_send_ipi(target, ipinr);
-}
-
 static unsigned int get_ipi_count(int ipi, unsigned int cpu)
 {
   	struct irq_desc *desc = get_ipi_desc(cpu, ipi);
@@ -1138,6 +1162,12 @@ static unsigned int get_ipi_count(int ipi, unsigned int cpu)
 
 #endif /* CONFIG_IRQ_PIPELINE */
 
+static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
+{
+	trace_ipi_raise(target, ipi_types[ipinr]);
+	arm64_send_ipi(target, mkipi_inband(ipinr, target));
+}
+
 static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
 {
 	/* IRQ pipeline: see the reasoning in set_smp_ipi_range(). */

-- 
2.53.0

