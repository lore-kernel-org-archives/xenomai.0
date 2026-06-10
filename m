Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78333A7F59
	for <xenomai@lists.linux.dev>; Wed, 10 Jun 2026 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083229; cv=none; b=tOwFv1TPe3csb9iBEpx5L8HdwYl/kfFKLxRpx5wJUTdLAr/s0Okr/99Uec2x/9fQqLAC2h3xCAUwktkcyGbljiQ9lqnzFFQFWzTedFb1CiOTFZEaHzyb7FNQYSuHmZyqSwvE81iVdGHgVzMQsu/hVtEE40gODGoN5A11ca2NQqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083229; c=relaxed/simple;
	bh=/WMBz6RzrrRJ1pGMrqaSb2s1Soypw/L6httdDBcc4wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eb5ZPBwHHGrVHHjEtGy9sNQXUYEbKyfwdzgH24WqgFMmt6XnTxzrke4Xi6iGojDj0VMtTHFp1TtU+IJYT8s8Iy7/cLZ+fW/Lu/eMe6j9UnUMi1mtrXDTrxq7AX0WtvNPUZXXXGQ13Inrm+/TtYioJ3wXdNqgpLClzH0sTNeUr4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=cyRIx8qV; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="cyRIx8qV"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260610092014a52daae1ed000207c6
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jun 2026 11:20:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+Rq7W6ledEhTkWVWuUh1Bf9LlWIB7rb2NZPoSQ9w9NE=;
 b=cyRIx8qVOjKr6JZ8S0iW0nLET0qax+YrXSCRnrETy0YiL5yIZupzSWFvR6XVq7/tWrsVW8
 7H0SstsH2pXWLBejmVzVm+oOpmNOZyIPdyKdN/ASTtUKBja1kh6V2EsI9xfxWOGOwL2fhr7W
 u1s3ZvL+aQllo5ONT15+SVlWTk6zEyJLjwQ2VgTBwTCzLWianvINtSXXsk5n8gwTMdauUSCf
 jfNb6MYdAgH3yKmiWSy4mBBPdKqny9qaH4+5z76MFln3fZNXDN7Kak701swbs8Gy5liDW1Vu
 5AjgYMF6wlI29O3ofy6HHwAn08gy7O1kQC/2Lr2P2xUJkeMYw7xXiV3g==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 10 Jun 2026 11:20:18 +0200
Subject: [PATCH Dovetail v2 6/6] arm: irq_pipeline: Fix IRQ state checking
 in trap entry paths
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-6-62c9c477f8f2@siemens.com>
References: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-0-62c9c477f8f2@siemens.com>
In-Reply-To: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-0-62c9c477f8f2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

A couple of trap handlers where checking the hardware IRQ state after
inband migration instead of the inband stage state.

As we now have arch_kentry_irqs_enabled() available we can migrate all
callers.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm/kernel/hw_breakpoint.c | 2 +-
 arch/arm/mm/alignment.c         | 2 +-
 arch/arm/mm/fault.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index d4b7953eff35d4c0194dec9aed7f7b17af5cf1f4..419d35143ddb81c7d92c620db9df03f54384e418 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -951,7 +951,7 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
 
 	preempt_disable();
 
-	if (interrupts_enabled(regs))
+	if (arch_kentry_irqs_enabled(regs))
 		local_irq_enable();
 
 	/* We only handle watchpoints and hardware breakpoints. */
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 1d457f22a3e7db8b71006b673dd20646847de3c1..935bc061fc63bb90cb7090aef048812e7d2622b6 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -817,7 +817,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	mark_trap_entry(ARM_TRAP_ALIGNMENT, regs);
 
-	if (interrupts_enabled(regs))
+	if (arch_kentry_irqs_enabled(regs))
 		local_irq_enable();
 
 	instrptr = instruction_pointer(regs);
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 60982ec0627464dd389e1c9b106858bc92ccf260..37e043718f0abc75f8b3409c0f269e6a7166923e 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -340,7 +340,7 @@ do_kernel_address_page_fault(struct mm_struct *mm, unsigned long addr,
 		 * PTE or PTE permission fault. This may happen in exceptional
 		 * circumstances and need the fixup tables to be walked.
 		 */
-		if (interrupts_enabled(regs))
+		if (arch_kentry_irqs_enabled(regs))
 			local_irq_enable();
 
 		__do_kernel_fault(mm, addr, fsr, regs);

-- 
2.54.0

