Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B079CF
	for <xenomai@lists.linux.dev>; Fri,  3 Nov 2023 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="JGkxum3S"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2023110308112749a8831d14e6e9f708
        for <xenomai@lists.linux.dev>;
        Fri, 03 Nov 2023 09:11:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=jawY7NwfERb80uvNvA0PPf93oiLHwKWhFIvY5iYdQsM=;
 b=JGkxum3S11WrET7G5+Hc9NKCQ8rkMUDjj9lEqzjr4Ro812EIhniNnHTOPutemc2QYZnRZ6
 e+UYVyDufBYAaqaw7dhSPR+teozi6GKyp2oJzJAQ4T73zJ52i3WWqaVvdSb9QaAo/R6+/lgy
 /vMXxpifOF2hqpFsUC7ns7/Xvx0IM=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: florian.bezdeka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH][Dovetail 6.1] arm64: dovetail: Fix undefinstr/break trap handling
Date: Fri,  3 Nov 2023 09:11:07 +0100
Message-Id: <20231103081107.3400986-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

[ This is a backport of ca33f993e7b677f20a29150b14fd120416bf548e ]

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

Therefore do_undefinstr() reports the trap entry to the
companion core. If the companion core handles the undefined instruction,
running_oob returns true and the bailout occurs. Otherwise, switching to
the in-band stage takes place and the undefined instruction handler
continues with the compat breakpoint detection.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 arch/arm64/kernel/traps.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index cc68be400244..5ea4cf543113 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -489,25 +489,28 @@ void arm64_notify_segfault(unsigned long addr)
 
 void do_undefinstr(struct pt_regs *regs, unsigned long esr)
 {
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
 
 	if (call_undef_hook(regs) == 0)
-		return;
+		goto out_exit;
 
 	if (!user_mode(regs))
 		die("Oops - Undefined instruction", regs, esr);
 
-	mark_trap_entry(ARM64_TRAP_UNDI, regs);
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
+
+out_exit:
 	mark_trap_exit(ARM64_TRAP_UNDI, regs);
 }
 NOKPROBE_SYMBOL(do_undefinstr);
-- 
2.39.2

