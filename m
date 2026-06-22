Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2191B38E8C9
	for <xenomai@lists.linux.dev>; Mon, 22 Jun 2026 08:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115552; cv=none; b=H4hcrgCRi579DAJ0JG73ZEj/eZussOYUr11LzpJuUup7/4kG0nI7v6UUckL88X8XVzHA24XMX6LMjMdhmqYMdequTdKNegKjHjH65Vd688TMyPuERR2j+gc/XF1KghpwYBvrJSnGYLpe+Cw0yd6ZK7ASeXjkxL0BmD3kjpnpocQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115552; c=relaxed/simple;
	bh=0VV0rQHTsGFbWJjkZwcLnMeW8lp1YdG/iApH0DM3Ts8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lH0ZWxR6M47a3kTcxsHIVuHtKq3TvVi8cddk7rNM8IM5o8dhf/KQHzhKnsPPg+zZeKjuHwCavNuO3wIKSRscZCERyU2l42EmV1llXJ7AOcx+43jynVj/kVHjMuX4XKK5qV03WKqu5+RgJAEnqWT66okhc1feJ/j0w+4mAcmKrdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=h0vju+pk; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="h0vju+pk"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202606220805383fe2dfcbfe00020795
        for <xenomai@lists.linux.dev>;
        Mon, 22 Jun 2026 10:05:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=FpT+8GpVykL1zM8unGHtxjUHeof0xXezzUMpo59JucY=;
 b=h0vju+pkktpiAJ+sOopwG3/UgBjrcEKD2QzivsrnzedGJ8kA+YvPFxrL26Cl/87b88XbAY
 fXpFMDu1EZbI3cdQaRLgsOS+uSF8wrjkmV6DrhRmkt+KlA301SmPZb+MdEVsy6MEU7s/5ov4
 ITkhQ54Gtk5KYVZmiVkdQX7t8CKx+0/mSfvZEVd0ZLrukiGC4RH1in4x7u5huAVqBkUnpmpF
 Ng/xfOAY+9th+qcX0CRT4m4JA27L1dGh1nPvNnHD5V3bbNlZfPl7omnTjo2SHKaYLffqhEzZ
 Yz3DDwQ+4/ow53Uai+CBdph8l2LsmCCa0pstAQ/HM0FdwiZiRoMbofQQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 22 Jun 2026 10:05:27 +0200
Subject: [PATCH Dovetail v3 3/6] arm: irq_pipeline: Fix
 dovetail_fault_{entry,exit} bypass in hw_breakpoint_pending
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-3-230f03227abb@siemens.com>
References: <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-0-230f03227abb@siemens.com>
In-Reply-To: <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-0-230f03227abb@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

HW breakpoint / watchpoint handling was bypassing the
dovetail_fault_{entry,exit} machinery. As a result it could happen that
the inband IRQ mask was touched from the OOB stage.

There is one more problem in the HW bp/wp handling related to
interrupts_enabled(). This one will be fixed in a separate patch.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm/include/asm/dovetail.h         | 1 +
 arch/arm/include/asm/trace/exceptions.h | 3 ++-
 arch/arm/kernel/hw_breakpoint.c         | 6 ++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/dovetail.h b/arch/arm/include/asm/dovetail.h
index 795a1fb903ec29f4c2fb7b25e70980796804acc0..eeb5d16ad032044a2587822f6b35074d664a9bbc 100644
--- a/arch/arm/include/asm/dovetail.h
+++ b/arch/arm/include/asm/dovetail.h
@@ -16,6 +16,7 @@
 #define ARM_TRAP_VFP		6	/* VFP floating point exception */
 #define ARM_TRAP_UNDEFINSTR	7	/* Undefined instruction */
 #define ARM_TRAP_ALIGNMENT	8	/* Unaligned access exception */
+#define ARM_TRAP_HW_BREAK	9	/* HW break or watchpoint exception */
 
 #if !defined(__ASSEMBLY__)
 
diff --git a/arch/arm/include/asm/trace/exceptions.h b/arch/arm/include/asm/trace/exceptions.h
index bdb666b3da4e364e0d7e33337be3e8ad8aeedb88..f0164e55efc31a4f363764d2c5c84761f3ea34d4 100644
--- a/arch/arm/include/asm/trace/exceptions.h
+++ b/arch/arm/include/asm/trace/exceptions.h
@@ -21,7 +21,8 @@
 			__trace_trap(ARM_TRAP_FPU),		\
 			__trace_trap(ARM_TRAP_VFP),		\
 			__trace_trap(ARM_TRAP_UNDEFINSTR),	\
-			__trace_trap(ARM_TRAP_ALIGNMENT))
+			__trace_trap(ARM_TRAP_ALIGNMENT),	\
+			__trace_trap(ARM_TRAP_HW_BREAK))
 
 DECLARE_EVENT_CLASS(ARM_trap_event,
 	TP_PROTO(int trapnr, struct pt_regs *regs),
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index cd4b34c96e35e9e63e9a1ade1aeb415c22d32b00..6266380737dd88dca7fe8fde14b786a52ec42635 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -26,6 +26,7 @@
 #include <asm/current.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/traps.h>
+#include <asm/trap_entry.h>
 
 /* Breakpoint currently in use for each BRP. */
 static DEFINE_PER_CPU(struct perf_event *, bp_on_reg[ARM_MAX_BRP]);
@@ -942,9 +943,12 @@ static void hw_breakpoint_cfi_handler(struct pt_regs *regs)
 static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
 				 struct pt_regs *regs)
 {
+	unsigned long irqflags;
 	int ret = 0;
 	u32 dscr;
 
+	irqflags = dovetail_fault_entry(ARM_TRAP_HW_BREAK, regs);
+
 	preempt_disable();
 
 	if (interrupts_enabled(regs))
@@ -973,6 +977,8 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
 
 	preempt_enable();
 
+	dovetail_fault_exit(ARM_TRAP_HW_BREAK, regs, irqflags);
+
 	return ret;
 }
 

-- 
2.54.0

