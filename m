Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4797FE540
	for <xenomai@lists.linux.dev>; Fri,  6 Oct 2023 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="e5Iunp4c"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202310061043312e4ff54c5cc982b753
        for <xenomai@lists.linux.dev>;
        Fri, 06 Oct 2023 12:43:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=XPXeFaYfwBCNU88Sy3LACteV7/ebAhLzB0+K22ojoq0=;
 b=e5Iunp4cvPGI2UDO6aGde7U4NEO3tOJdHYkZ4IdMe2R0gQZE5i/3kk/9eNqJ66MPbZNigl
 jWCKulcRvCMLXDRDV+fjGmECfZgoRj13q72kx/ELjqS5EAK1t5OYzJH+fv7emT52omX53VTV
 06uDZiHQX+1U8lPJsuHu+u6/cmKwU=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [RFC PATCH v2 1/2] arm64: dovetail: Fix undefinstr/break trap handling
Date: Fri,  6 Oct 2023 12:43:03 +0200
Message-Id: <20231006104304.3813326-2-clara.kowalsky@siemens.com>
In-Reply-To: <20231006104304.3813326-1-clara.kowalsky@siemens.com>
References: <20231006104304.3813326-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

From: Florian Bezdeka <florian.bezdeka@siemens.com>

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

In addition aarch32_break_handler() has to report the trap entry to the
companion core.

Reported-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Tested-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm64/kernel/debug-monitors.c | 2 ++
 arch/arm64/kernel/traps.c          | 7 -------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 32271ed24ef5..8157496bea62 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -373,7 +373,9 @@ int aarch32_break_handler(struct pt_regs *regs)
 	if (!bp)
 		return -EFAULT;
 
+	mark_trap_entry(ARM64_TRAP_UNDI, regs);
 	send_user_sigtrap(TRAP_BRKPT);
+	mark_trap_entry(ARM64_TRAP_UNDI, regs);
 	return 0;
 }
 NOKPROBE_SYMBOL(aarch32_break_handler);
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index b0db35eda8f5..a8c3642c61dc 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -456,13 +456,6 @@ void do_el0_undef(struct pt_regs *regs, unsigned long esr)
 {
 	u32 insn;
 
-	/*
-	 * If the companion core did not switched us to in-band
-	 * context, we may assume that it has handled the trap.
-	 */
-	if (running_oob())
-		return;
-
 	/* check for AArch32 breakpoint instructions */
 	if (!aarch32_break_handler(regs))
 		return;
-- 
2.39.2

