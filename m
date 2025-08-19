Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA501F8677
	for <xenomai@lists.linux.dev>; Tue, 19 Aug 2025 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755644945; cv=none; b=ZMHYR3zhNQzqooiUqY5JwcrkJ6yCR4bg/jDTjDaVNK/FI591vrOMkrqABjUdH30ESwXk/v9hV6U70jCxgudUq2RZHNghPr8IpDjqd6cqHRnEdszZZRothNiFnEt8k3MFL1QP780wC8/4HXv44z4Pdl+CmunJAI+rUIXxLtMQMsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755644945; c=relaxed/simple;
	bh=wIQ1a3igmZSUGCv9j07lC21sNb8bEfBLEU+sWalzQtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=heFhUkb7VuvXK0oDIIppFgnF2VfV3zAMnosz56U3VzEEFd93ITNzNLuGm8HiYxozxcWrGN9FktX+s/PfpAuXzPbFCE1yrcm0t9hWr2MSxUZSo+HhSAhpqK/zpgWYb0ol7D0M2gyZnGJwMm0Wm+zVIv3Ow/HdVbyDT2RrZGGC+nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZXgOAX4D; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZXgOAX4D"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250819230850daedded21a934e002e
        for <xenomai@lists.linux.dev>;
        Wed, 20 Aug 2025 01:08:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=OiV9FteCQErW8zuSHrM9DwxUQgv2EGBl7VZGeYJdFSw=;
 b=ZXgOAX4DFtTvCminNOdyPIZcKqhOrON7hLHGZprJcbCWmA2kmxsXbsZRuZ6reBGCmZy3na
 Ce4o7VaVxFPDsLxmwv965V3n9sxVAea4tl95ax8SBdBG03Xb08D4GxuN94MjtXZof03CRscX
 +reV8UDq5Ez+cXvXRLCyOtLmOETbd+5pqFvVpC3N6iCs2XRVUU408h/pKQ4szIddFVE0EK6y
 szqrVQgQelFy/+FUQDOjP8yXrYH3uD5gkYx8zT7t4sY+1LrUjfDl8/M77iPN9Ma6FgBioDx3
 cTPv3fFtrqUifr9ICw4IXl6MmQi8TPLPnjaCYDrBmUV9pT/Gc4BQuztA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 20 Aug 2025 01:08:50 +0200
Subject: [PATCH Dovetail] irq_pipeline: Fix system freeze triggered by
 periodic edge type IRQs
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-wip-flo-fix-edge-irq-handling-v1-1-1a2c7805b372@siemens.com>
X-B4-Tracking: v=1; b=H4sIAAEEpWgC/x2NTQ6CMBCFr0Jm7SRtUYOuvYVxMbQDTNK02CqYE
 O7u6PL9fW+DykW4wrXZoPAiVXJSYQ8N+InSyChBNTjjTqZzBleZcYgZB/kgh19enqjNECWNaM9
 87OylJSYPyuipMvaFkp+Ukt4xqjkX1vX/9A63vPCLJMJj379AiNUtjgAAAA==
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

When IRQ pipelining is enabled, it could happen that handle_edge_irq()
is interrupted while syncing the IRQ log - for the very same IRQ - as
hard IRQs are enabled while processing the IRQ log.

The pipeline entry code will set the IRQS_PENDING flag and bail out
forcing the sync code (still in handle_edge_irq()) to loop to infinity
as the (periodic) IRQ might fire again after calling unmask_irq() from
inside the loop.

Delaying the call to unmask_irq() until the loop has been left fixes
this problem.

There is a "race window" involved. To trigger looping to infinity the
IRQ(s) must arrive while processing the IRQ log for the same IRQ.
Enabling some debug options like CONFIG_PROVE_LOCKING widens this
window as execution time increases.

This time the problem could be observed during IO APIC initialization
on a virtual machine. That simplified debugging a lot.

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
 kernel/irq/chip.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 8a0831193d74..578e79d60de3 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1010,6 +1010,7 @@ EXPORT_SYMBOL_GPL(handle_fasteoi_nmi);
 void handle_edge_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
+	bool delay_unmask = false;
 	int flow;
 
 	guard(hybrid_spinlock)(&desc->lock);
@@ -1054,13 +1055,24 @@ void handle_edge_irq(struct irq_desc *desc)
 		 */
 		if (unlikely(desc->istate & IRQS_PENDING)) {
 			if (!irqd_irq_disabled(&desc->irq_data) &&
-			    irqd_irq_masked(&desc->irq_data))
-				unmask_irq(desc);
+			    irqd_irq_masked(&desc->irq_data)) {
+				delay_unmask = irqs_pipelined();
+				if (!delay_unmask)				
+					unmask_irq(desc);
+			}
 		}
 
 		handle_irq_event(desc);
 
 	} while ((desc->istate & IRQS_PENDING) && !irqd_irq_disabled(&desc->irq_data));
+
+	/*
+	 * Pipelining: We have to delay unmasking until we left the loop above.
+	 * Otherwise, a pipeline entry could interrupt syncing the IRQ log and
+	 * trigger looping to infinity.
+	 */
+	if (delay_unmask)
+		unmask_irq(desc);
 }
 EXPORT_SYMBOL(handle_edge_irq);
 

---
base-commit: eec111a874f5899e1078ef785ccf29dff986e5a0
change-id: 20250820-wip-flo-fix-edge-irq-handling-16e48193aeac

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

