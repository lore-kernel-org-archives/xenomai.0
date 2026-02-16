Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA0E219A8A
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771268734; cv=none; b=Tvd3tyYc7deF5bTtHYcsikvR1lBWr2iZGXwlyhsTwgs3Uh3cBmqWw5+g/XcP1GKc1lK9qaYglTs7yIRVK/VjJ5lHLrG+wCZhKnh557sDzP5xvONtqEnanaTNXiu1YL90gbMoUBMhZnzVWGqpuBw0ZOyGg+2wgzPWUupuS7ai73Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771268734; c=relaxed/simple;
	bh=x5RuKB5/AAztb3+4d8J4Lr2t85fZ3TSHhq5Fp/nsARE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZE0ogILkICujWZe/pl9zH6yTA1y+0xAUj3UOwTac6lQiwkxDmhqVjw8AsgjF7t2fvHB5CEpUGOyJZoEdjRi4NsxluxJjld9q+QcdsNuCeDkFTfI5qVAOzL1A9o43X8RUH9PWWxogQfPYsGffQkt771HPS9aQGmwE4ygInI7MaV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=HiyCjnJd; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="HiyCjnJd"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202602161905260e373b3a38000207a7
        for <xenomai@lists.linux.dev>;
        Mon, 16 Feb 2026 20:05:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Vue/yOlG71WvT/rYXG3ai+aVqzZ3rMWVksxeQoSOtXw=;
 b=HiyCjnJdZ2xmx/DiAbV2hZTvCs2791I5SIuXcHBxmBtvkGQ3woPrZVsq8uP6TXdiGTn7NN
 c7gSzSkDLG4qChB29XEJ2tHApQUstL4J1moUo4IJKVG10HUOE1mKH46bbvgsECl5/qXCfVs1
 2R6pwBZUHosg9rFLpGwM40mn7DSTZYOrx7RKXRPBGkQgsdNxmyZ9z9dkIpRHKNr+zvNPCHaL
 ulJy2OuE05lBMyUKM+OyjSp4Tkd8J1oVEvmACdwjK2sBbJyb0l+eYgfRFfH/qgj4+X4tnvFX
 +3zmU8yQTlCIaJzeVJi3GP4jZbasD0xRudiwZnRw//c9slt6NoVLnyTw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 16 Feb 2026 20:05:26 +0100
Subject: [PATCH Dovetail 2/2] arm64: irq_pipeline: Fix the demotion checks
 for el0 and el1 IRQs
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-wip-flo-v6-19-dovetail-rebase-v1-2-5c36863cba17@siemens.com>
References: <20260216-wip-flo-v6-19-dovetail-rebase-v1-0-5c36863cba17@siemens.com>
In-Reply-To: <20260216-wip-flo-v6-19-dovetail-rebase-v1-0-5c36863cba17@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

While reviewing some of the low level pipeline code I realized that
the checks for task demotion are wrong on arm64.

el0: The demotion check was missing in the oob case. We have to check
     for running_inband() only as user_mode(regs) will always be true.
     We are serving an IRQ over el0, so application / user mode.

el1: The demotion check was unnecessary and "inactive" as
     user_mode(regs) is never true on el1, we are serving an IRQ over
     kernel mode.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm64/kernel/entry-common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 07fa70713ce04eaf3df9223354babcecde923280..9c99eb3d18c459a90e1f7ce4e4c307e235e457a2 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -73,6 +73,10 @@ static noinstr void arm64_pipeline_el0_irq(struct pt_regs *regs,
 	do_interrupt_handler(regs, handler);
 	/* Done, unwind now. */
 	handle_irq_pipelined_finish(prevd, regs);
+	if (running_inband()) {
+		stall_inband_nocheck();
+		irqentry_exit_to_user_mode(regs);
+	}
 	instrumentation_end();
 	arm64_exit_to_user_mode(regs);
 }
@@ -90,10 +94,6 @@ static noinstr void arm64_pipeline_el1_irq(struct pt_regs *regs,
 		prevd = handle_irq_pipelined_prepare(regs);
 		do_interrupt_handler(regs, handler);
 		handle_irq_pipelined_finish(prevd, regs);
-		if (running_inband() && user_mode(regs)) {
-			stall_inband_nocheck();
-			irqentry_exit_to_user_mode(regs);
-		}
 		instrumentation_end();
 		mte_check_tfsr_exit();
 		return;

-- 
2.53.0

