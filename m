Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF52915
	for <xenomai@lists.linux.dev>; Fri, 25 Aug 2023 18:39:23 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230825125847d30d6e6d27e9fcbe4e
        for <xenomai@lists.linux.dev>;
        Fri, 25 Aug 2023 14:58:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=XubluNiqbmzjBVYMbKJmbc6+NIvnLeXWgTLUJeQ/OP0=;
 b=fkmsUPweSyfEI4J9KjI5YxeMH7plGjNYJ+Er7rgnv0tZFBnqVh7vTMLrdJPrJJfdfEFzAm
 60uR9QZppKOqi/PF5xiJkYzJlpf9jq7ps+UT+/tab0s25yOfhUxCVX26L/o2fSIwVpf7NKJl
 R8mnKrn94hWuwQPtgmZGNJ4fkkp60=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	rpm@xenomai.org,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH] arm64: dovetail: Fix undefinstr/break trap handling
Date: Fri, 25 Aug 2023 14:58:44 +0200
Message-Id: <20230825125844.588598-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

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
 arch/arm64/kernel/debug-monitors.c | 3 +++
 arch/arm64/kernel/traps.c          | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 32271ed24ef5..ef7ac042a0a6 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -373,7 +373,10 @@ int aarch32_break_handler(struct pt_regs *regs)
 	if (!bp)
 		return -EFAULT;
 
+	mark_trap_entry(ARM64_TRAP_UNDI, regs);
 	send_user_sigtrap(TRAP_BRKPT);
+	mark_trap_exit(ARM64_TRAP_UNDI, regs);
+
 	return 0;
 }
 NOKPROBE_SYMBOL(aarch32_break_handler);
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index cc68be400244..9bf2f309248f 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -489,13 +489,6 @@ void arm64_notify_segfault(unsigned long addr)
 
 void do_undefinstr(struct pt_regs *regs, unsigned long esr)
 {
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

