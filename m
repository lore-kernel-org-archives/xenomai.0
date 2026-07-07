Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A3B3D952F
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418434; cv=none; b=WPGHdY0af8bj5NYkf2Aze4+00cmTweyua2C8dApfXRKZR2GkRL6CAXusiRIKilarcfyU9ZqIk9TsVSUiyxes2t5vXdqMWbS4yy8EP+Mp34kpd6+HZ3g9E7la+G2tXb6HhklUsh5qB9E9xf/rbK1fH/OqzWUXsPtgVxm80qLrsu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418434; c=relaxed/simple;
	bh=Y3V97DhTUp6HYChcgO7n6vElMdPajJ2MpxUP6fk/se8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XNVN/+x1Nxq69aF7wg5YWit4UfHqT8/ZWmf9dO9aHT7whRamd+qHFWpzBYw3j+fW0UG8Cfc70a61WReo0Qw+JfzAOPlE6pcm5WGOxNc/xNJZKi2k35tUrTjtc63kcCm4Dmnmej4dLJrNdYTnLCrxBK8Ia3AuVkqiHoPrhCwKxlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Ohzb84lD; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Ohzb84lD"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202607070950200ba6e96b5d000207e4
        for <xenomai@lists.linux.dev>;
        Tue, 07 Jul 2026 11:50:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xpUMvwnAJSZqmGBYryv8Hk7S1TLRJ+++jjexUY4cIV0=;
 b=Ohzb84lDc3JMLoaXJDZonTay3qD5/XIcYnLonHbfQRhs4d9F8lCTeuUI31NBKVXgW544b5
 HmFK87PMJkotDe8JEVGGk20BtOgJuV9YK3u5JolvMnr5fmlQH3CLL5cFi9Kf80cFco8ZYgOJ
 l3aHfxMHwcKEKUZ6mRYH2QVB25d1AGg/DP+1HGEihJgaE8BAVkLovM6GMDAUCrm+0HcPWvg/
 f3sl+zjBpqaKivA+Vq8rIsEjbTG9+ipK9evWINQxH34M5VHEvwcLgdFiW47fM5wE3hzy5aFq
 5ihXjSwLcNZFbQMOmaXYD/5qUOD9s9f+c6K8wpE6UaS7OPLHaHW9kxQA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 07 Jul 2026 11:50:19 +0200
Subject: [PATCH Dovetail v4 3/8] arm: irq_pipeline: Fix
 dovetail_fault_{entry,exit} bypass in hw_breakpoint_pending
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-3-057b8af5a2ca@siemens.com>
References: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
In-Reply-To: <20260707-wip-flo-v7-1-arm-pipelining-fixes-v4-0-057b8af5a2ca@siemens.com>
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
 arch/arm/kernel/hw_breakpoint.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index cd4b34c96e35e9e63e9a1ade1aeb415c22d32b00..2ef431f96a6aca9a396f4bb9642e318e9e1712a7 100644
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
 
+	irqflags = dovetail_fault_entry(ARM_TRAP_BREAK, regs);
+
 	preempt_disable();
 
 	if (interrupts_enabled(regs))
@@ -973,6 +977,8 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
 
 	preempt_enable();
 
+	dovetail_fault_exit(ARM_TRAP_BREAK, regs, irqflags);
+
 	return ret;
 }
 

-- 
2.55.0

