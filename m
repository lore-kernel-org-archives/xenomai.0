Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E278E3DBD4D
	for <xenomai@lists.linux.dev>; Wed, 10 Jun 2026 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083229; cv=none; b=f324rhZZYQEQy18HzvuOX6rdgjU+4hl6FGlP/6r7uVAlgEOMjEyM7JL6xKcXa7wdFQ3PK0Z5fktJwS3MJ1GOLxuTLmcma92dFAlQI60eGgiAPurj3KKPP3D2HL8EHPlyouzjYrXKarEsnaT1QnyeFc310N7p3g5tvKXSrHrJ4J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083229; c=relaxed/simple;
	bh=cpIMWyS00MB5y4Wy1wxzU/WC1LCk8JuZidawNJr5i+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q4tTp4WPduYk/GA72MBRBxCY0pRTVWrIGqBK8d3eEi0CA3k8r5U9eKgkZz4y5/vtnUCrgq02tiPD6tV6sRv/iG27me8TstGgqszw8/djyJMFGXhK2HWH7SP6t7VcD/KXjoZ4zrDintnp8+p4WN/Pa8bxqPm8PuKKEyW8fuw4EWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=qo91dzEh; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="qo91dzEh"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202606100920130a822fbb2a00020707
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jun 2026 11:20:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=FryUKitzJHLC3a4AvoKOlZk2um0Mr0Ac0fHSkSgWMb0=;
 b=qo91dzEhxWL2pH/W/VDA28wbvRRIaFFH8ipAIW/7PxJA1Fg5wKFrcmBKUt/H3D2r0wQaAA
 +/hahsJxozWUi2PbYnw5mvTP3ooL8yebs/BoAOjVAF5O7S2bR6TUQZPWijrR6xJXnbTM669S
 hUmaJPxH9eIlq58lg/5YLrfNZpgYdV7fQ+30KVLBDZJzlKPnlVPaWX8ljk+l9lCNA5ln//G/
 9w+hQIO2gMr1HrtIxsTR7FXpg47Jj3X+Qwbp5vvZxjeMl7I9QRev419oxzIA8y5cHyGVarL0
 mt59k8COeUdknJkHMHFiAWPKjaXFC4tpYOGdcZ9maxPHVsN1oWvnkUcQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 10 Jun 2026 11:20:13 +0200
Subject: [PATCH Dovetail v2 1/6] arm: irq_pipeline: Fix fault_{entry,exit}
 bypass in do_kernel_address_page_fault
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-1-62c9c477f8f2@siemens.com>
References: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-0-62c9c477f8f2@siemens.com>
In-Reply-To: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-0-62c9c477f8f2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

In case do_kernel_address_page_fault() was entered over supervisor mode
the fault_{entry,exit} machinery was bypassed. As a result the inband
IRQ mask might have been touched from the oob stage.

There is another problem with interrupts_enabled() in the supervisor
mode code path. That one will be addressed in a separate patch.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm/mm/fault.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 49f5d628c4c9a91a3e879af0d541fd76665d78fe..7a5c0a5a825df5f76eec6aa341d910c3efa63f88 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -382,6 +382,8 @@ do_kernel_address_page_fault(struct mm_struct *mm, unsigned long addr,
 {
 	unsigned long irqflags;
 
+	irqflags = fault_entry(ARM_TRAP_ACCESS, regs);
+
 	if (user_mode(regs)) {
 		/*
 		 * Fault from user mode for a kernel space address. User mode
@@ -391,9 +393,7 @@ do_kernel_address_page_fault(struct mm_struct *mm, unsigned long addr,
 		 * Note that __do_user_fault() will enable interrupts.
 		 */
 		harden_branch_predictor();
-		irqflags = fault_entry(ARM_TRAP_ACCESS, regs);
 		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
-		fault_exit(ARM_TRAP_ACCESS, regs, irqflags);
 	} else {
 		/*
 		 * Fault from kernel mode. Enable interrupts if they were
@@ -409,6 +409,8 @@ do_kernel_address_page_fault(struct mm_struct *mm, unsigned long addr,
 		__do_kernel_fault(mm, addr, fsr, regs);
 	}
 
+	fault_exit(ARM_TRAP_ACCESS, regs, irqflags);
+
 	return 0;
 }
 

-- 
2.54.0

