Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7705446BEB
	for <xenomai@lists.linux.dev>; Tue, 21 Jul 2026 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621780; cv=none; b=ZWjYBer+YGVQRFYZZ4arQgusxHtKg/AJIHAI5/HcdiTtbumixuBNUspZKv0pO3/h+JE8+ISxuKZVLjCSY/dfSbuERQUV/2kyZUnYpOFuWgaUKpy3pDtwQbl5nxbl6HOu72Ek0XBBaaYseHnsjgzziuLKmBdfKUAsPrYMFlK2AXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621780; c=relaxed/simple;
	bh=yKovHVf88SBGzj5L83YUMuIMqliaDX+zRdQwr/mSJ9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AE7Rjey43Waj2tbjp5JqksknZpDj4nwLiRutfm4tuTnEYEeL1Plthyoi/aekru/3XBrCZUndTPzWBu3c/cBPBM2UDHvLGqJpgm34r8T+BQWwPuJksGcMQwbBC5Hn3Y/B/JdrTpC/Fw7xxj34oL6jeTVXv9tZkyEZuvV0aMP2q7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A92DD2CFC9E;
	Tue, 21 Jul 2026 10:15:50 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id tmooe0idAZUT; Tue, 21 Jul 2026 10:15:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 581161012E4;
	Tue, 21 Jul 2026 10:15:50 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id M__xUm7kuld6; Tue, 21 Jul 2026 10:15:50 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 24C782B03EB;
	Tue, 21 Jul 2026 10:15:50 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/2] genirq: irq_pipeline: Don't run handlers of disabled lines on replay
Date: Tue, 21 Jul 2026 10:15:36 +0200
Message-ID: <20260721081537.809383-1-richard@nod.at>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The pipelined handle_level_irq() function only checks unsing irq_can_hand=
le()
on the IRQ_FLOW_START path, assuming that an event which reaches
the in-band replay path already passed this check when it was deferred
at pipeline entry.
This assumption does not hold for interrupts demultiplexed by an
in-band parent action handler.

This was observed on qcom hardware, the qcom-ipcc summary interrupt is
an in-band line, hence its demux handler runs from the replay path.
qcom_glink_smem requests its child IPCC interrupt with IRQF_NO_AUTOEN
and only enables it once smem->glink has been assigned, but the demux
delivered the interrupt early, dereferencing the still-NULL pointer:

Unable to handle kernel NULL pointer dereference at 00000000000000a0
Call trace:
_raw_spin_lock_irqsave+0x40/0x9c
__wake_up+0x28/0x70
qcom_glink_native_rx+0x58/0x6a4
qcom_glink_smem_intr+0x14/0x24
__handle_irq_event_percpu+0x4c/0x1c8
handle_irq_event+0x54/0x11c
handle_level_irq+0x150/0x24c
generic_handle_irq+0x24/0x30
qcom_ipcc_irq_fn+0x5c/0xb4
__handle_irq_event_percpu+0x4c/0x1c8
handle_irq_event+0x54/0x11c
handle_fasteoi_irq+0x164/0x278
arch_do_IRQ_pipelined+0x44/0x6c
sync_current_irq_stage+0x150/0x1e0

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 kernel/irq/chip.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 562cc856a3871..1b33a9599c46d 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -948,6 +948,11 @@ void handle_level_irq(struct irq_desc *desc)
 		return;
 	}
=20
+	if (!irq_can_handle_actions(desc)) {
+		mask_irq(desc);
+		return;
+	}
+
 	kstat_incr_irqs_this_cpu(desc);
 	handle_irq_event(desc);
=20
--=20
2.51.0

