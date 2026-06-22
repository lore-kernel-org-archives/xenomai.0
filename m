Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76C038F248
	for <xenomai@lists.linux.dev>; Mon, 22 Jun 2026 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115548; cv=none; b=BXLPqBR497YmPRiRwG2dvm6IslzlGt5Ymtc9E1oSn1e1KorU8k7thdvStAiBQznXvMVfNuAFhV85jBZuubsUyUpKlIi7qovJ8l7UTfB1Y49Aa9tJ2XD5dcw+AKM/dZ8guYUDLqO+EZo2hYVHJeCpJqZkH3BoqDvJwDFhHKuabME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115548; c=relaxed/simple;
	bh=HOYqsxzA3FB34qlnWuFSocobOyE9B5WTPuIL6iXyBnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qPJAnDdVgNz8+XpxbPY3KIeGS9qjNA+expgVogXHmPofvgC9bW/MfB23sBi5y4rek3S1j4/Xp8cDzwS+NqyYwgAxdYEPkBp+ZtLZfsWuwaTTw0jwOAHlAHEBENpM6UGVyDXsPcHS45QOKYb+s4TupOkCHiCpl7JvMpmL0hS3Vs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=wBsc8KlY; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="wBsc8KlY"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260622080539d4e69dcdbb000207b7
        for <xenomai@lists.linux.dev>;
        Mon, 22 Jun 2026 10:05:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=AAG7pbhtW2r0iycUYaDVnKn3ZIuthz93adNjaRZC2Ms=;
 b=wBsc8KlYSt9IrIGWFX39LUbRyR5ZRY427a7uDfC2Fyv9GZ6H06+goD0i6ecE6K0a4dbYoR
 v8NmnnnOiy00zdMvSGjhMVtZjUGtZ6WaYWGOjqdHXyTl3QwYVRc8izaYr8HDx7mAca/HGNLw
 xG07Nrx1oEuX4A1XefiHN7dJokVcr2OvV1/MnGEI5ULH2tn3lUrdfVuEcDX/iugAkZSFdNN5
 23wFvWH17IA4tlQjjf96QsV1BMDEPYNG+zN04BJ8dqx2x5Uj82FGl18zzq3mPrmUf+VB6y8u
 ux4CS82EdGTNxrcvTzBxYTjCFPay3Yz3eG2GFlKJN/K8uPOwXkgo3Pmw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 22 Jun 2026 10:05:30 +0200
Subject: [PATCH Dovetail v3 6/6] arm: irq_pipeline: Fix IRQ state checking
 in trap entry paths
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-6-230f03227abb@siemens.com>
References: <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-0-230f03227abb@siemens.com>
In-Reply-To: <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-0-230f03227abb@siemens.com>
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
index 6266380737dd88dca7fe8fde14b786a52ec42635..c94383d8d81da902d9bee1240ad14d91526f70a4 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -951,7 +951,7 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
 
 	preempt_disable();
 
-	if (interrupts_enabled(regs))
+	if (arch_kentry_irqs_enabled(regs))
 		local_irq_enable();
 
 	/* We only handle watchpoints and hardware breakpoints. */
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 37023b96a468531c026ea5f6c47d25f3d49fd6a7..1af7d306fcb1f09497b026e30ad49891ec5a3ff1 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -817,7 +817,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	mark_trap_entry(ARM_TRAP_ALIGNMENT, regs);
 
-	if (interrupts_enabled(regs))
+	if (arch_kentry_irqs_enabled(regs))
 		local_irq_enable();
 
 	instrptr = instruction_pointer(regs);
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 08ebc043971000fd8d6245bcbb6c170d801c73b3..049c2733e695ee4e4a4d228f023c2e0bf755196c 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -341,7 +341,7 @@ do_kernel_address_page_fault(struct mm_struct *mm, unsigned long addr,
 		 * PTE or PTE permission fault. This may happen in exceptional
 		 * circumstances and need the fixup tables to be walked.
 		 */
-		if (interrupts_enabled(regs))
+		if (arch_kentry_irqs_enabled(regs))
 			local_irq_enable();
 
 		__do_kernel_fault(mm, addr, fsr, regs);

-- 
2.54.0

