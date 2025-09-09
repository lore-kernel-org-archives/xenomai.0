Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C9434A317
	for <xenomai@lists.linux.dev>; Tue,  9 Sep 2025 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424620; cv=none; b=nLFHrTNN3vspDx67KLeQo2AatzlimLKxwea5gGGaq8VHyc31rdpRIpgYsUmnR/AoQ/m20jBR6SygqciJMnLmNirioKzKEx43zcW3/6pMfAgYL8BmvICwmI4n+iZL5XOKJ6VECYodAZ4dWiCP+4g6ztkvwDU5XWj//yj3prta3KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424620; c=relaxed/simple;
	bh=2W8yDCMkQ9sfr2UCLX2w5b0EOOak3ipFhNNot9T8/Ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L1S3+7sTRCz4VDVoN8MaGVozmUE8GXlHRNQF5RfAHIaeVL/qShVk4XR2ovf9QBBwfWhkzBAQ6acl/yZJfKaRWvj1bEihJcOxXDXKLNXyTzbS7ooLj3715WJ/XpitZl3fvMSv08tpM6rLhuujdyewlY2VIlQDyumzVNiuBfHay3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Df5mUiV8; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Df5mUiV8"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025090913301037e692fcf90002076a
        for <xenomai@lists.linux.dev>;
        Tue, 09 Sep 2025 15:30:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=M+9j85mk+XkcPAPqC0Ezl/Nyydsei7VtYpvSBe3bUNI=;
 b=Df5mUiV8btGEelSCT+WXHVKMN4J4MuxibFDuTPxNLPs6OqERlzU3WKsgEBOcAQEm7vEvXF
 Kj81OVvx45i+8AiScpOzRU3WXyVtnLi1yuKxR5Gb8NSnZYOtFJ7x9ph6sODVdOA+HIWbuhB3
 Y/lNjEqmKRbD2vKyRriqvpFOkCUsH1zWJ5w7JWzXs0c0JWImrOyiUZDGOa+FmZXKZZ4eGxmD
 lmEk4Lo58aA6SXXZpePQkaqQOATbXmAL6jMezPevKcxITjjgiJuPQiiq7f+pVMMnBtqlKpMQ
 dPtYJx5R3HLd5d6Z6PjmiS9g/84TmEVxGMAGDpKfrvAeRAU7oLGcXaWQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 09 Sep 2025 15:30:09 +0200
Subject: [PATCH Dovetail v3] irq_pipeline: Fix system freeze triggered by
 edge IRQs
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-wip-flo-fix-edge-irq-handling-v3-1-8cc08939e6ca@siemens.com>
X-B4-Tracking: v=1; b=H4sIAOArwGgC/5WPMQ7CMAxFr1JlxqhJKS1MDNwCMaSpSy2FpCQQQ
 Kh3x2RjA3n6/vb79ktEDIRRbIuXCJgokncsqkUhzKjdCYF61kKVqi5bVcKdJhish4EegP3HDxf
 gyd6SO4Fc46qVm0qjNoIZnY4IXdDOjExxN2u5OQXk7Rx6EHuf8KrJiiM7I8WrD898TZLZ/zE4S
 eDSyjRtWXdVo3aR8IwuLo0/Z3ZSf/FU5m3qtpcNP4PfvHme3xKOnf47AQAA
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

When IRQ pipelining is enabled, it could happen that handle_edge_irq()
is interrupted while syncing the IRQ log - for the very same IRQ.

The pipeline entry code will set the IRQS_PENDING flag and bail out
forcing the sync code (lower part in handle_edge_irq()) to loop to
infinity as the (periodic) IRQ might fire again after calling
unmask_irq() and reaching the hard IRQ enablement in handle_irq_event().

There is a "race window" involved. To trigger looping to infinity the
IRQ(s) must arrive while processing the IRQ log for the same IRQ in
handle_irq_event().

Call graph, delivered by a modified NMI handler and NMI injected by
hyper-v:
[    5.929380] Call Trace:
[    5.929381]  <NMI>
[    5.929383]  default_do_nmi+0xd9/0x110
[    5.929387]  exc_nmi+0xde/0x110
[    5.929388]  end_repeat_nmi+0xf/0x53
[    5.929390] RIP: 0010:mask_ioapic_irq+0x86/0xf0
[    5.929392] Code:
[    5.929392] RSP: 0000:ffffa1c680003e48 EFLAGS: 00010086
[    5.929393] RAX: ffffffffff5fc000 RBX: 0000000000000086 RCX: ffff8e4f01049340
[    5.929393] RDX: 0000000000203000 RSI: 0000000000010030 RDI: 0000000000000014
[    5.929394] RBP: ffff8e4f01049320 R08: 0000000000000012 R09: 0000000000000001
[    5.929394] R10: 0000000000000000 R11: 770e017136e49082 R12: ffffffffac506000
[    5.929395] R13: ffff8e4f3ec49840 R14: 0000000000000000 R15: 0000000000000000
[    5.929402]  </NMI>
[    5.929402]  <IRQ>
[    5.929402]  handle_edge_irq+0x300/0x320
[    5.929405]  generic_pipeline_irq_desc+0xc2/0x220
[    5.929408]  arch_handle_irq+0x5d/0x180
[    5.929410]  arch_pipeline_entry+0x38/0xf0
[    5.929413]  asm_common_interrupt+0x22/0x40
[    5.929421]  handle_irq_event+0xbe/0xe0
[    5.929424]  handle_edge_irq+0x1ec/0x320
[    5.929425]  arch_do_IRQ_pipelined+0xa5/0x560
[    5.929427]  </IRQ>
[    5.929427]  <TASK>
[    5.929428]  sync_current_irq_stage+0x191/0x240
[    5.929430]  __inband_irq_enable+0x48/0x60
[    5.929431]  setup_IO_APIC+0x36b/0x860
[    5.929434]  ? ioapic_read_entry+0x1a/0x80
[    5.929436]  ? clear_IO_APIC_pin+0x1d/0x240
[    5.929437]  ? clear_IO_APIC_pin+0x190/0x240
[    5.929440]  apic_intr_mode_init+0x6f/0xf0
[    5.929441]  x86_late_time_init+0x20/0x40
[    5.929442]  start_kernel+0x743/0x890
[    5.929445]  x86_64_start_reservations+0x14/0x30
[    5.929446]  x86_64_start_kernel+0xc1/0xd0
[    5.929447]  common_startup_64+0x13e/0x148
[    5.929452]  </TASK>

Enabling some debug options like CONFIG_PROVE_LOCKING widens this
window as execution time increases.

If we detect that the very same IRQ line is currently processed while we
receive another hard irq, the current event is logged into the IRQ log.
The event gets replayed within the same sync run in
sync_current_irq_stage().

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Hi all,

the problem could be observed and debuged quite well on hyper-v with
lockdep enabled and a slightly modified NMI handler to print out the
current call stack.

This seems to be a long standing issue for Dovetail. We had several
reports in the past that debug options (like lockdep) on hypervisors
(like VirtualBox) ended up in a boot failure.

Once we agree that the patch is correct I can send backports, if
necessary, haven't checked that yet.

Best regards,
Florian

CC: Philippe Gerum <rpm@xenomai.org>
CC: Jan Kiszka <jan.kiszka@siemens.com>
---
Changes in v3:
- Introduce irq_active_on_this_cpu() 
- Link to v2: https://lore.kernel.org/r/20250820-wip-flo-fix-edge-irq-handling-v2-1-1a958d17eace@siemens.com

Changes in v2:
- v1 crashed qemu, similar to 
  https://lore.kernel.org/all/20250701163558.2588435-1-liangyan.peng@bytedance.com/
  so v1 was analyzed further and reworked completely 
- Link to v1: https://lore.kernel.org/r/20250820-wip-flo-fix-edge-irq-handling-v1-1-1a2c7805b372@siemens.com
---
 kernel/irq/chip.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index f5dfc378ccf2..12b820c99bb9 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -639,6 +639,26 @@ static inline bool should_feed_pipeline(struct irq_desc *desc, int state)
 	return false;
 }
 
+static bool irq_active_on_this_cpu(struct irq_desc *desc)
+{
+	struct irq_data *data = &desc->irq_data;
+	const struct cpumask *aff;
+
+	/* Check if active on any CPU */
+	if (!irqd_irq_inprogress(data))
+		return false;
+
+	/* The below works only for single target interrupts */
+	if (!irqd_is_single_target(data) || desc->handle_irq != handle_edge_irq)
+		return false;
+
+	aff = irq_data_get_effective_affinity_mask(data);
+	if (cpumask_first(aff) != smp_processor_id())
+		return false;
+
+	return true;
+}
+
 static bool irq_can_handle_pm(struct irq_desc *desc)
 {
 	unsigned int mask = IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED;
@@ -669,6 +689,8 @@ static bool irq_can_handle_pm(struct irq_desc *desc)
 		WARN_ON_ONCE(irq_pipeline_debug() && !in_pipeline());
 		if (irqd_is_wakeup_armed(&desc->irq_data))
 			return true;
+		if (irq_active_on_this_cpu(desc))
+			return true;
 	} else if (irq_pm_check_wakeup(desc))
 		return false;
 

---
base-commit: fd7ae0eaafd268a5d1cbc2876d6cbe2a284b0d8c
change-id: 20250820-wip-flo-fix-edge-irq-handling-16e48193aeac

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

