Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E1A3D566A
	for <xenomai@lists.linux.dev>; Wed, 10 Jun 2026 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083229; cv=none; b=UkcQBjEcG+AbI48E6DT4IwPOg1ZrftLo7rFZA9dcby+M6tMxGA56/TthVXde/XXRyj4wkO2pdWCDQvRuyR8paJSsP4nSC82LUGDSvQi928YPMxDeo/zvVL3ttpCHAIr0Qzqa1dpNZyQNG9ZQhI5by7FczBpGIJEWo7S2Nm6/oUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083229; c=relaxed/simple;
	bh=J9ai3br+Sof3kfHcRQQvg4r0cEayLu6TI2ErCUDfanI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aj2u13MV19YOEiyD0FRWSuDfgIV0AHD9YfdwHFPjql1te258dHKzCjLkJY9K5kUd0QINlJoNNrVhIDdhPpPs28TJonQjQa526RYtFiuh3KxxwO/wpMWnZLadXIvCEaADBqTVZ75WkG8ppyTPmwtS3f3HVkuGl3TUa9AsfU6dWiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=YZyChFrA; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="YZyChFrA"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260610092014c02905afdd0002071e
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jun 2026 11:20:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Xpnz9n96F0JbzOnRvB5EQJyApLs9ZxK1BWYC8QT67xI=;
 b=YZyChFrAMnRZfB+hZDX6J6rNw3JgAawgGiKvyB2JiBm5ooqvmgx/hpZwg4kQ+jVfj+Nf62
 sGRWY/og4ygXgEr19R4z5px9bbT1rxiUsJSvDZ9TDZzd1FG3xkNAWYpTKqxhBjRusDxUuXZK
 eRIMFUanZYgK38/eWxuV8ppiNY7inrNV28Ef+0r9QtOp/S4kG9gEsVclfR2QVLAUhFibY1xS
 bVdcqzrTRg78cqQ/VkFNhicQZLWvijWFxbJC5q7RIE4MRkxZM4V0d0+2eezzLH4JrxV3lkLG
 3AhNvAiuEX4yLBC96WBaNx2HE5zn01y7LEMHWI7DosPx/QDyszle+jZQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 10 Jun 2026 11:20:15 +0200
Subject: [PATCH Dovetail v2 3/6] arm: irq_pipeline: Fix fault_{entry,exit}
 bypass in hw_breakpoint_pending
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-3-62c9c477f8f2@siemens.com>
References: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-0-62c9c477f8f2@siemens.com>
In-Reply-To: <20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-0-62c9c477f8f2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

HW breakpoint / watchpoint handling was bypassing the fault_{entry,exit}
machinery. As a result it could happen that the inband IRQ mask was
touched from the OOB stage.

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
index cd4b34c96e35e9e63e9a1ade1aeb415c22d32b00..d4b7953eff35d4c0194dec9aed7f7b17af5cf1f4 100644
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
 
+	irqflags = fault_entry(ARM_TRAP_HW_BREAK, regs);
+
 	preempt_disable();
 
 	if (interrupts_enabled(regs))
@@ -973,6 +977,8 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
 
 	preempt_enable();
 
+	fault_exit(ARM_TRAP_HW_BREAK, regs, irqflags);
+
 	return ret;
 }
 

-- 
2.54.0

