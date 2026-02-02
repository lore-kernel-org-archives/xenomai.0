Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0201526AC3
	for <xenomai@lists.linux.dev>; Mon,  2 Feb 2026 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018929; cv=none; b=D7G/S6qG7l6MtgLqykDI0Y4vAKCYoamNgOocGBDXs9gJxzIFtx+V74YaV903p1DVjioq7PgDDSf/+X1SAqkfYQXYIO3vTE7Sh4E0Txetb6j/1UlxuKBkk2N9yK1Ju6clrVn89E1xYk8ylIIXTQPwHU5VuDPfAh6g/+8GJMueU6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018929; c=relaxed/simple;
	bh=vvrmEdc2b1s10NKHi3uJ4/80T4I6ENfoLRzHoMZSSeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KNKLVcfuKrKtUb1PM0J/PckL2gjSR9PlBD+DN/HdH1woeePiYDjHc4UFWpAtlj+Q0J3Q/DnaIiOXX7IrxHtYxZy25y4VDTLikyvu6lKjmlSWqIUWI70o7kxlvK73K35c6qE5ayl62MhjYN2A3zVCfFqY2Q3phnhunAwL8o5QRJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=dx0wJ9O6; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="dx0wJ9O6"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202602020755214ea517b1f90002079b
        for <xenomai@lists.linux.dev>;
        Mon, 02 Feb 2026 08:55:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=BrhK3lwm35EstOfsKM6ZHWXGNXPm0lwToF1XgQJyBE0=;
 b=dx0wJ9O6gHG1IpiVr5UX/z6p3DQF70P4VJOBHiW+y1qWaKOLet9Hz9MBruOcU/GUdjO8rw
 d35uClpskkmecLwlnxNxp7tkecexW3PssUOxmGFrJUdpNRfTrscuf9gXj7XC4M4VWZlb2wNb
 PiySygkimNiMUADg3O86AGAFxPoht03i1IR9BPdzvjtdd29NzEo89+FsqNBuduKdebbOQwxH
 K/aEyYosuRJM+VopOOfngdAZilgjEzyeSpJIkaIlL2Ov0SrqDZBZrEOqjQJ2gntKGlDcP8u8
 jWlDq0KHRKev+QmEh9xxZLjLlcWET9xa5Hpsg5hLw7fGh7BOWtEmeYNA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Feb 2026 08:55:20 +0100
Subject: [PATCH Dovetail 6.18 1/3] arm64: irq_pipeline: Fix mapping of
 SGI/LPI IPIs
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-wip-flo-fixes-for-6-18-v1-1-91ea07c7eb7e@siemens.com>
References: <20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com>
In-Reply-To: <20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There were two problems with the mapping:
  - We stopped mapping after OOB_NR_IPI (3) IPIs.
    There are more IPIs after the last IPI reserved for OOB

  - In the LPI case everything was mapped to the IRQ desc of CPU 0,
    which seems odd. Each CPU has its own LPI used for multiplexing
    inband IPIs.

The following splat was observed whent trying to handle a backtrace
IPI. This is one of the IPIs located after the OOB IPIs.

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
 arch/arm64/kernel/smp.c | 50 +++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 3a12956580a35..e8cee27dc1132 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1020,28 +1020,25 @@ static void do_handle_IPI(int ipinr)
 
 #ifdef CONFIG_IRQ_PIPELINE
 
-static inline void map_oob_ipis(int cpu)
+static inline void map_oob_ipis(int cpu, unsigned int irq)
 {
 	int ipi;
 
-	for (ipi = OOB_IPI_OFFSET; ipi < OOB_NR_IPI + OOB_IPI_OFFSET; ipi++)
-		get_ipi_desc(cpu, ipi) = irq_to_desc(ipi_irq_base + ipi);
+	for (ipi = OOB_IPI_OFFSET; ipi < nr_ipi; ipi++)
+		get_ipi_desc(cpu, ipi) = irq_to_desc(irq);
 }
 
-static void ipi_setup_oob_sgi(void)
+static void ipi_setup_oob_sgi(unsigned int irq)
 {
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		map_oob_ipis(cpu);
+		map_oob_ipis(cpu, irq);
 }
 
-static void ipi_setup_oob_lpi(int ncpus)
+static void ipi_setup_oob_lpi(unsigned int irq, int cpu)
 {
-	int cpu;
-
-	for (cpu = 0; cpu < ncpus; cpu++)
-		map_oob_ipis(cpu);
+	map_oob_ipis(cpu, irq);
 }
 
 static void __smp_cross_call(const struct cpumask *target, unsigned int ipinr)
@@ -1061,7 +1058,7 @@ static irqreturn_t ipi_handler(int irq, void *data)
 
 	/*
 	 * Decode in-band IPIs (0..NR_IPI - 1) multiplexed over
-	 * SGI0. Out-of-band IPIs (SGI1, SGI2) have their own
+	 * SGI0. Out-of-band IPIs (SGI1, SGI2, SGI3) have their own
 	 * individual handler.
 	 */
 	pmsg = raw_cpu_ptr(&ipi_messages);
@@ -1108,10 +1105,10 @@ EXPORT_SYMBOL_GPL(irq_send_oob_ipi);
 
 #else
 
-static inline void ipi_setup_oob_sgi(void)
+static inline void ipi_setup_oob_sgi(unsigned int irq)
 { }
 
-static inline void ipi_setup_oob_lpi(int ncpus)
+static inline void ipi_setup_oob_lpi(unsigned int irq, int cpu)
 { }
 
 static irqreturn_t ipi_handler(int irq, void *data)
@@ -1214,6 +1211,14 @@ static void ipi_setup_sgi(int ipi)
 		get_ipi_desc(cpu, ipi) = irq_to_desc(irq);
 
 	irq_set_status_flags(irq, IRQ_HIDDEN);
+
+	/*
+	 * irq_pipeline: although a single IPI will be requested for
+	 * in-band operations, all IPI descriptors have to be mapped,
+	 * so that arm64_send_ipi() can issue out-of-band IPIs as
+	 * well.
+	 */
+	ipi_setup_oob_sgi(irq);
 }
 
 static void ipi_setup_lpi(int ipi, int ncpus)
@@ -1233,6 +1238,14 @@ static void ipi_setup_lpi(int ipi, int ncpus)
 		irq_set_status_flags(irq, (IRQ_HIDDEN | IRQ_NO_BALANCING_MASK));
 
 		get_ipi_desc(cpu, ipi) = irq_to_desc(irq);
+
+		/*
+		 * irq_pipeline: although a single IPI will be requested for
+		 * in-band operations, all IPI descriptors have to be mapped,
+		 * so that arm64_send_ipi() can issue out-of-band IPIs as
+		 * well.
+		 */
+		ipi_setup_oob_lpi(irq, ncpus);
 	}
 }
 
@@ -1264,17 +1277,6 @@ void __init set_smp_ipi_range_percpu(int ipi_base, int n, int ncpus)
 			ipi_setup_lpi(i, ncpus);
 	}
 
-	/*
-	 * irq_pipeline: although a single IPI will be requested for
-	 * in-band operations, all IPI descriptors have to be mapped,
-	 * so that arm64_send_ipi() can issue out-of-band IPIs as
-	 * well.
-	 */
-	if (!percpu_ipi_descs)
-		ipi_setup_oob_sgi();
-	else
-		ipi_setup_oob_lpi(ncpus);
-
 	/* Setup the boot CPU immediately */
 	ipi_setup(smp_processor_id());
 }

-- 
2.39.5

