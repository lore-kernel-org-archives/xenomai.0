Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30E43D904D
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417832; cv=none; b=dI+slCAQOMC2DSjdruy2aUaaWo/CvYT61l7REAKFgkAqNjBCGzubojwJU7Cz0ThCYGu0JfasqdZYOOEGZQtZcWCQwqV9F2GEO3ZyfS+emswetzrHPq1jhpWEUKkk5Ro6MTH+xRhbD6MAuY+Iy+33p/BgZwwGVlrFpFPHWqrqZ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417832; c=relaxed/simple;
	bh=NqN1rGaNshcTaMS7Xaa8Vg0gFlyz7tI9ZuCq3lxflGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uZbO7AXqY3YiCsHlj7FO6TwdY0W+Pf6sKlcTmZhXcWfC0XJYmTxwEONVz2LHjeC8ySpMKI0v5ASgcSL+p8FSShRKlvLY2Atej4sVjp5oP6I5lNwzngQ60wphpH3bqfAwJePba9830thy31YaRrCqV/xp3mZiuI9D4rk/MDT5/bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=bUytmCmr; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="bUytmCmr"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260707095021b44320a2f1000207da
        for <xenomai@lists.linux.dev>;
        Tue, 07 Jul 2026 11:50:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9H/AEOUFoFoVmEUqcPSTtpCLyOj4fgnWWwLp+Hwu9Po=;
 b=bUytmCmrqaOAaBFFYXJFVUuGAPnwDdE/GBneTrxLq4Ky4V59F3mqcgntwJaZ+bqx0oI3sQ
 +Ifa4lz+5m+Wmfmq2YC6LTSK4FZwukr6OVYn14HUZpLDWX802hm7HqNWdvKHa809mysNdz81
 pI+K8b8OswbWRsN3tgBnoYU7laVINkNyWKtfnR7PmysI03IveLEeN4p84jmqHetLuVBiN1w7
 QjkwYXif4bf9gGP1Ehcrgn4JIrWKkNJ8UyuYAZXQfTks/A2kt1TrKqpPGRCwEtgxX/sjsXAq
 YM2/CungWlup6iPfRXLRdBqGGHakBoxbDAKxl0jA9bwtvlm1B6FANvGQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 07 Jul 2026 11:50:24 +0200
Subject: [PATCH Dovetail v4 8/8] arm: irq_pipeline: Fix IRQ state checking
 in trap entry paths
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-8-057b8af5a2ca@siemens.com>
References: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
In-Reply-To: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
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
index 2ef431f96a6aca9a396f4bb9642e318e9e1712a7..24b35df649becdd2f1976b683f6bb2ed642a00c3 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -951,7 +951,7 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
 
 	preempt_disable();
 
-	if (interrupts_enabled(regs))
+	if (!arch_kentry_test_stalled(regs))
 		local_irq_enable();
 
 	/* We only handle watchpoints and hardware breakpoints. */
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 37023b96a468531c026ea5f6c47d25f3d49fd6a7..612db267f6246d5e5ed1c2e9291d51e315aaec25 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -817,7 +817,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	mark_trap_entry(ARM_TRAP_ALIGNMENT, regs);
 
-	if (interrupts_enabled(regs))
+	if (!arch_kentry_test_stalled(regs))
 		local_irq_enable();
 
 	instrptr = instruction_pointer(regs);
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 08ebc043971000fd8d6245bcbb6c170d801c73b3..8f7feb1a228fc12c2d14389f865b13e23d11460d 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -341,7 +341,7 @@ do_kernel_address_page_fault(struct mm_struct *mm, unsigned long addr,
 		 * PTE or PTE permission fault. This may happen in exceptional
 		 * circumstances and need the fixup tables to be walked.
 		 */
-		if (interrupts_enabled(regs))
+		if (!arch_kentry_test_stalled(regs))
 			local_irq_enable();
 
 		__do_kernel_fault(mm, addr, fsr, regs);

-- 
2.55.0

