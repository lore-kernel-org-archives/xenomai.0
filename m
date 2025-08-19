Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F66A244677
	for <xenomai@lists.linux.dev>; Tue, 19 Aug 2025 22:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755644032; cv=none; b=Sq/UMhaApmC8MxFPXGZ0T0vMOhBgU6pWQbB4Bga8K1Bl28Lu25gjmv38h2/DH6Zhf/w4t/JRBl6/OnXAn3wlF2CrZRMxkDna3K9G/ScjgDWpE/kJynH0LaHlw/s4qFqnrjhLcfQ1DwW1tdFVWWQFvK5japJpjNbYUl+OJZKwtPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755644032; c=relaxed/simple;
	bh=/C9eFqp8/AwT9rTJCqxbcV/smMUyXKmi2GD4kgQTwiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UPoJNQJ/jejkd/htYJPWt7U1r++EBeFgXBh+s575hNthrWH2mRe+xC34mk2/c3FBoKKz/VfmACQN940+vJMZLd+yisp2HgLHKjyer9CUHvSkGsPGllVRb5G8yZByCPFfcCvkgPJKaTNoVObcj4jNcF4W3413tPXHP4GkgAFYhFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=FtcrJCsx; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="FtcrJCsx"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202508192253397f93881bda799b5192
        for <xenomai@lists.linux.dev>;
        Wed, 20 Aug 2025 00:53:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=pX0F0HsNmSGIThjEZaZHvi86JKGdO5/CuH2VKdA6gB8=;
 b=FtcrJCsx+zMR9Vc3sVwdLc/Rhxdddv5VC+MQkJQ7ER2CEWM9I2NlsM7lIGjfuPDbBLu1Xz
 dQ42OBhD+2KT3zzJpfFe0ZiAP2jvOlgYwtQr+5Joz1snkBOGsPW/Z229Widbvo2oVh5GAjsR
 ZtqnT9F4RU6rJzJ6Dtq+yDl1dRXzxM+CcwHrCh8lo6JX46a50vnUBCl5JPCObdGTEsNzWLLV
 R39izpNgeCQsLgZu7MIPOgdyHBaWMayruUNFy16cfpeRjdWZ2DQq6I6EV2iq1jkckPuXtTUL
 DtqXUGjwyWN+qfzAMK1hoqwLxJ0sZGqImf/0OJ26Dmt7qvfO/QnMLp6A==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 20 Aug 2025 00:53:36 +0200
Subject: [PATCH Dovetail 6.16 2/2] irq_pipeline: Fix pipelining code for
 level triggered IRQs
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-wip-flo-fixes-for-dovetail-6-15-v1-2-d44f50cb4b0b@siemens.com>
References: <20250820-wip-flo-fixes-for-dovetail-6-15-v1-0-d44f50cb4b0b@siemens.com>
In-Reply-To: <20250820-wip-flo-fixes-for-dovetail-6-15-v1-0-d44f50cb4b0b@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

During the last forward port to 6.16 the pipelining code was
accidentally removed from handle_level_irq().

The result was the following warning, observed on qemu/kvm:

[    0.532822] ------------[ cut here ]------------
[    0.532823] WARNING: CPU: 0 PID: 0 at ./include/linux/interrupt.h:670 update_process_times+0xc8/0xf0
[    0.532832] Modules linked in:
[    0.532836] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.16.0-hyprv-xenomai-0+ #212 PREEMPT(voluntary)
[    0.532840] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    0.532841] IRQ stage: Linux
[    0.532843] RIP: 0010:update_process_times+0xc8/0xf0
[    0.532846] Code: e8 fd f1 01 00 84 c0 74 be 8b 05 17 5d d8 01 85 c0 74 1a 65 8b 05 30 13 6a 02 85 c0 75 0f 65 8b 05 25 10 6a 02 85 c0 75 04 900
[    0.532848] RSP: 0000:ffffffff82e03cb0 EFLAGS: 00010046
[    0.532851] RAX: 0000000000000000 RBX: ffff88803e64a800 RCX: 0000000000000000
[    0.532852] RDX: 00000000fffedb0a RSI: ffff88803e64cd80 RDI: ffff88803e64e040
[    0.532854] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
[    0.532855] R10: 2ecf57e6e4d1a59e R11: 0000000000000185 R12: 0000000000000000
[    0.532856] R13: ffff888004c52400 R14: 0000000000000000 R15: ffffffff82e277c0
[    0.532885] FS:  0000000000000000(0000) GS:ffff8880babc2000(0000) knlGS:0000000000000000
[    0.532887] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.532888] CR2: ffff888004801000 CR3: 0000000002e38000 CR4: 00000000000000b0
[    0.532889] Call Trace:
[    0.532891]  <TASK>
[    0.532895]  tick_periodic+0x29/0xe0
[    0.532909]  tick_handle_periodic+0x20/0x70
[    0.532914]  timer_interrupt+0x24/0x40
[    0.532918]  __handle_irq_event_percpu+0x9d/0x2e0
[    0.532924]  handle_irq_event+0x58/0xe0
[    0.532928]  handle_level_irq+0x166/0x1e0
[    0.532933]  generic_pipeline_irq_desc+0xc2/0x220
[    0.532937]  arch_handle_irq+0x5d/0x180
[    0.532943]  arch_pipeline_entry+0x38/0xf0
[    0.532950]  asm_common_interrupt+0x22/0x40
[    0.532953] RIP: 0010:unmask_8259A+0x68/0x70
[    0.532956] Code: c1 01 e6 21 0f b6 05 28 13 c1 01 e6 a1 48 c7 c7 b8 4f e4 82 48 89 de e8 06 3a 11 00 48 c7 c7 a0 4f e4 82 e8 da 6b 11 00 55 9d0
[    0.532957] RSP: 0000:ffffffff82e03e90 EFLAGS: 00000246
[    0.532959] RAX: 0000000000000001 RBX: ffffffff81233c31 RCX: ffffffff82e03e54
[    0.532960] RDX: 0000000000000000 RSI: ffffffff82e44fb8 RDI: ffffffff82e44fa0
[    0.532961] RBP: 0000000000000246 R08: 0000000000000001 R09: ffffffff82e286b0
[    0.532962] R10: 5878d26fbb66c2c1 R11: 0000000000000000 R12: ffffffff82e277c0
[    0.532963] R13: ffff88803ffd1f40 R14: ffffffffffffffea R15: ffffffff82e26e30
[    0.532966]  ? unmask_8259A+0x11/0x70
[    0.532976]  ? unmask_8259A+0x11/0x70
[    0.532979]  enable_IR_x2apic+0xf0/0x240
[    0.532986]  x86_64_probe_apic+0xb/0x50
[    0.532990]  apic_intr_mode_init+0x3e/0xf0
[    0.532992]  x86_late_time_init+0x20/0x40
[    0.532995]  start_kernel+0x75a/0x8b0
[    0.533002]  x86_64_start_reservations+0x14/0x30
[    0.533005]  x86_64_start_kernel+0xff/0x110
[    0.533009]  common_startup_64+0x13e/0x148
[    0.533022]  </TASK>

Forward porting the (old) code from 6.15 again to fix this problem.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/irq/chip.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 8a0831193d74..aacacb5869cd 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -846,15 +846,44 @@ static void cond_unmask_irq(struct irq_desc *desc)
  */
 void handle_level_irq(struct irq_desc *desc)
 {
+	int flow;
+
 	guard(hybrid_spinlock)(&desc->lock);
-	mask_ack_irq(desc);
 
-	if (!irq_can_handle(desc))
+	flow = get_flow_step(desc);
+	if (may_start_flow(flow)) {
+		mask_ack_irq(desc);
+
+		if (!irq_can_handle(desc))
+			return;
+	}
+
+	if (should_feed_pipeline(desc, flow)) {
+		if (handle_oob_irq(desc))
+			goto out_unmask;
+		return;
+	}
+
+	if (flow == IRQ_FLOW_FORWARD) {
+		forward_irq_event(desc);
 		return;
+	}
+
+	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
+
+	/*
+	 * If its disabled or no action available keep it masked and get out
+	 * of here
+	 */
+	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
+		desc->istate |= IRQS_PENDING;
+		return;
+	}
 
 	kstat_incr_irqs_this_cpu(desc);
 	handle_irq_event(desc);
 
+out_unmask:
 	cond_unmask_irq(desc);
 }
 EXPORT_SYMBOL_GPL(handle_level_irq);

-- 
2.39.5

