Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636365;
	b=3bAjJwdZGA517fhh8doorvFrGbC3pOnq1o1eSQVQe4Zdozw5wUG2pv/QJ766cJyZkTQQ
	 L6ACip/1speMuFyDbRhTvQbQi9qwD/1ZZAcMqZcl5+FhTfTXg4Tls7R9CXY6XcS3K7zAM
	 ry2ZsJKScLUnBYQ/hyb2/5EPrcmSLtdmN4azXiNcwWH0lhpxvnKZq+bQZS3QZwu1HEnV7
	 h5FgI3ph9AQ9DSp6nRfmhW08vg9yBmyxuMNVOfHdoSVwOMzDz4mHA3aD+JFvFcd8jB8s1
	 1IC73PBUAogqvzXzMe5szMRamo2bZliGi1VYLOoeE/reNwx3gMISLBjItI3Kh3j9bzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636365;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Flowmailer-Platform:Feedback-ID;
	bh=TKbR3jk7MO/PxjiYOh0isypsXTrNh3og7QlQH3a98do=;
	b=GHwG+shnRBQ+tWf/pAZxGATYstGCCZQhY8p8Zxh/p0TREzpuUC03I03OjtNZzZQM6Vs3
	 v/Tx2YRGls1RYUvzgqipGqsOxhN6Kj3mIHlaS2b4uk0SuFrwQSa3K5pAGOgSC6stB9sZF
	 MOcY4KtMmgKt3lXzUrxQk6DH9fRuQ+0j0CFAOvNk3E66/cBKL0q/3aypfOR3hB9Hlspla
	 ibbqSIPCqH0FwRQGEu8pk52H5h/Gc4lRJ/3P7yvVKohM796+CtA4+gNSm3LmgULcjl5EW
	 jp3PgutiFPOyf2TgouMGDGEnFdzOvNAkdT/5zobtFNYsOTHXUYkS/fWEjSIU9cV3bNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=exdFoOuP;
	arc=none smtp.remote-ip=185.136.64.227
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81700608362A
	for <xenomai@lists.linux.dev>; Mon,  2 Nov 2026 16:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81700608362A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=exdFoOuP
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20261102161920b9e8fdf624000207be
        for <xenomai@lists.linux.dev>;
        Mon, 02 Nov 2026 17:19:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=TKbR3jk7MO/PxjiYOh0isypsXTrNh3og7QlQH3a98do=;
 b=exdFoOuPvIn/OrnBDHwmBYz4J3X0DBiAkyDP8DRh3TZljnU2qeiTm4KbI3UxEINuyZaT23
 4V8yrxocdpjSmyPTOK1qP5EjOCeie96de7DDGBUCz4MjyeGERRwte+UPQKeGq/m34abD2TaG
 YrJEP8v6GnH0y1Tyih1549hvC+U4zFSQLkmNx3yH4xvFZ5br7YLTSTk1nk6XkUv/tqZubHaV
 93WjhQ8FmiGGE7FMOfoRH6j8lSPvp58a4RqoYrniwjU6bO2Kcd+wCW+tChLcoOrlCR4BhxlL
 akQH3nmf/QnfvjcvaIqTgnC/Y2xRXmG3VRK2PsSMN6nFgjFiis0R1R6w==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Nov 2026 17:19:16 +0100
Subject: [PATCH Dovetail 7.3 v3] ARM: dovetail: Fix inconsistencies in trap
 routing
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-wip-flo-v7-3-fix-arm-trap-inconsistency-v3-1-1738670e743b@siemens.com>
X-B4-Tracking: v=1; b=H4sIAAO46GoC/x2NQQ7CIBAAv0L27JoWRKpnf2F6QLrVTSoQIFjT9
 O8Sj5NMZjbIlJgyXMUGiSpnDr6BOghwL+ufhDw1BtnJc993Ej8ccV4CVoMKZ17RpjeWZCOyd8F
 nzoW8++KkBvfQ5jKctIZWi4ma/T/d4RYqFcuLMEcF477/AJb23luHAAAA
X-Change-ID: 20261102-wip-flo-v7-3-fix-arm-trap-inconsistency-d38cb5798455
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

do_bad_area() was informing the co-kernel about an ongoing trap
handling - but only for the trap over user mode case. Removing the
dovetail_fault_{entry,exit}() pair removes that inconsistency - we
never inform the co-kernel now, callers have to do so -
and fixes yet another issue:

do_bad_area() is called by
  - do_sect_fault(): fault.c
  - do_alignment(): alignment.c

do_sect_fault() already informed the co-kernel about the trap, but
with a different type: ARM_TRAP_SECTION vs. ARM_TRAP_ACCESS. This
nesting is removed at the same time.

The second caller, do_alignment(), used mark_trap_{entry,exit}()
instead of dovetail_fault_{entry,exit}.

In addition, leaving a comment in do_bad_area() why we do not have
to use mark_trap_{entry,exit}() here. All other users of
__do_{user,kernel}_fault() still have to call them.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
To: Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>

Changelog:

  v3:
    - Fix ordering problem in do_alignment(), calling
      dovetail_fault_exit() after hard_local_irq_disable() would
      trigger a WARN_ONCE().
    - Fix whitespace issue in fault.c
  v2:
    - Fix wrong comment in do_bad_area()
---
 arch/arm/mm/alignment.c |  9 +++++++--
 arch/arm/mm/fault.c     | 12 +++++++-----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 612db267f6246d5e5ed1c2e9291d51e315aaec25..f3be49a007a66357573f431125bd4cf8bed19c87 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -25,6 +25,7 @@
 #include <asm/cp15.h>
 #include <asm/system_info.h>
 #include <asm/system_misc.h>
+#include <asm/trap_entry.h>
 #include <asm/opcodes.h>
 
 #include "fault.h"
@@ -803,6 +804,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
 	union offset_union offset;
 	unsigned long instrptr;
+	unsigned long irqflags;
 	int (*handler)(unsigned long addr, u32 instr, struct pt_regs *regs);
 	unsigned int type;
 	u32 instr = 0;
@@ -815,7 +817,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (addr >= TASK_SIZE && user_mode(regs))
 		harden_branch_predictor();
 
-	mark_trap_entry(ARM_TRAP_ALIGNMENT, regs);
+	irqflags = dovetail_fault_entry(ARM_TRAP_ALIGNMENT, regs);
 
 	if (!arch_kentry_test_stalled(regs))
 		local_irq_enable();
@@ -1001,13 +1003,16 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		 * entry-common.S) and disable the alignment trap only if
 		 * there is no work pending for this thread.
 		 */
+		dovetail_fault_exit(ARM_TRAP_ALIGNMENT, regs, irqflags);
 		hard_local_irq_disable();
 		if (!(read_thread_flags() & _TIF_WORK_MASK))
 			set_cr(cr_no_alignment);
+		if (dovetailing())
+			return ret;
 	}
 
 out:
-	mark_trap_exit(ARM_TRAP_ALIGNMENT, regs);
+	dovetail_fault_exit(ARM_TRAP_ALIGNMENT, regs, irqflags);
 
 	return ret;
 }
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 95870a96a628631d67d391ac857ce038c10610e9..d4cb5d8db89b41eed4b1ab3bd6189cd6945084ad 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -212,17 +212,19 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->active_mm;
-	unsigned long irqflags;
+
+	/*
+	 * irq_pipeline: No dovetail_fault_{entry,exit}() here. All callers
+	 * are expected to have informed the co-kernel already.
+	 */
 
 	/*
 	 * If we are in kernel mode at this point, we
 	 * have no context to handle this fault with.
 	 */
-	  if (user_mode(regs)) {
-		irqflags = dovetail_fault_entry(ARM_TRAP_ACCESS, regs);
+	if (user_mode(regs))
 		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
-		dovetail_fault_exit(ARM_TRAP_ACCESS, regs, irqflags);
-	  } else
+	else
 		/*
 		 * irq_pipeline: kernel faults are either quickly
 		 * recoverable via fixup, or lethal. In both cases, we

---
base-commit: 1e576742fe11627dd0343deef641cd6805a76f22
change-id: 20261102-wip-flo-v7-3-fix-arm-trap-inconsistency-d38cb5798455

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

