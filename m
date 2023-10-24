Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9546C224F7
	for <xenomai@lists.linux.dev>; Tue, 24 Oct 2023 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="pbHiQdV4"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202310240915439f681977f94bdf4058
        for <xenomai@lists.linux.dev>;
        Tue, 24 Oct 2023 11:15:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=nl4wq5jkMg5v4qpumj2o01GSUP/5yv9PLq2/D6/OuDU=;
 b=pbHiQdV46oCwuzzXN1QFLU+bngZQ80jHdcLjIa3xsZG9bVkazHuuQZBS0wEHPPd2MrqBEP
 xAxMR3CJNllQZRurWmLiZEn2X/e/FSh+/pfnwHUCVUmawZsHlj3adDCkiCyOpeiP7AXm/DZ0
 HtNdkOPUF5t6hVezettjcjBIlPJkQ=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v3][Dovetail 6.6] arm64: dovetail: Fix undefinstr/break trap handling
Date: Tue, 24 Oct 2023 11:14:28 +0200
Message-Id: <20231024091428.1077419-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

When running an compat RT application on arm64 the break trap is
handled via the undefined instruction trap.

A possible call stack looks like this:

Call trace:
  handle_inband_event+0x2d0/0x320
  inband_event_notify+0x28/0x50
  signal_wake_up_state+0x7c/0xa4
  complete_signal+0x104/0x2d0
  __send_signal_locked+0x1d0/0x3e4
  send_signal_locked+0xf0/0x140
  force_sig_info_to_task+0xa0/0x164
  force_sig_fault+0x64/0x94
  arm64_force_sig_fault+0x48/0x80
  send_user_sigtrap+0x50/0x8c
  aarch32_break_handler+0xac/0x1d0
  do_undefinstr+0x6c/0x360
  el0_undef+0x4c/0xd0
  el0t_32_sync_handler+0xd0/0x140
  el0t_32_sync+0x190/0x194

The trap is never reported to the companion core at that stage so
running_oob() in do_undefinstr() will always return true. As the
following bailout happens before calling the compat breakpoint
detection (aarch32_break_handler()) debugging the compat
application does not work.

In addition the emulation of the deprecated armv8 SWP{B} instruction
(try_emulate_armv8_deprecated()) cannot be done from the out-of-band
stage.

Therefore do_undefinstr()/do_el0_undef reports the trap entry to the
companion core. If the companion core handles the undefined instruction,
running_oob returns true and the bailout occurs. Otherwise, switching to
the in-band stage takes place and the undefined instruction handler
continues with the compat breakpoint detection and the SWP{B}
instruction emulation.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 arch/arm64/kernel/traps.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index b0db35eda8f5..0811aa219ea7 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -456,29 +456,32 @@ void do_el0_undef(struct pt_regs *regs, unsigned long esr)
 {
 	u32 insn;
 
+	mark_trap_entry(ARM64_TRAP_UNDI, regs);
+
 	/*
 	 * If the companion core did not switched us to in-band
 	 * context, we may assume that it has handled the trap.
 	 */
 	if (running_oob())
-		return;
+		goto out_exit;
 
 	/* check for AArch32 breakpoint instructions */
 	if (!aarch32_break_handler(regs))
-		return;
+		goto out_exit;
 
 	if (user_insn_read(regs, &insn))
 		goto out_err;
 
 	if (try_emulate_mrs(regs, insn))
-		return;
+		goto out_exit;
 
 	if (try_emulate_armv8_deprecated(regs, insn))
-		return;
+		goto out_exit;
 
 out_err:
-	mark_trap_entry(ARM64_TRAP_UNDI, regs);
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
+
+out_exit:
 	mark_trap_exit(ARM64_TRAP_UNDI, regs);
 }
 
-- 
2.39.2

