Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700518;
	b=1E6lh1+POPpZ4ZubwCobSjrFBLDrwP7ZoLXkJK406YGVoqL587ItXDN0CBwCyL4aYcpn
	 LCg1kHP67lBijuogWGKTqa/USvXTAhw3R7LkPkNhfwzOYZCcKCFZOU8ZgN6SWIm9LNn/5
	 00F65i0aQpfFLQ+4I1lU44jMmk9eXN3CZfoPiiXvN336ndlAPUQqQnXCeifeElY+3jVwJ
	 mWu8UZVQx2QqPUUQ11DlKYbbKSYQrUCdj1L5Az/qdTvMYrRAHCuQIinlp4wxFLfsNPR9t
	 f7weP26N3Pv/hbh7Hjj5tjqsqa+4o/0SJg8ktYeBUH4kOwSMughz3aoNHoE35LMWB+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700518;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Flowmailer-Platform:Feedback-ID;
	bh=QTJ9qW2Kx0mGTwffy9gOQGS1esAL3VyLBZ78qbGqK4U=;
	b=jv0aI2zaD0cgHCMSZZFIwfShlhvvjKGGDA/9wL90x62NdmHHU8zVHIo22hjTTewT2VZ6
	 sVwwYEJNXF2ktZqL3hRir00p0W2BY55aMJLIHhIT5OeJFcCK8TZmJEiZadkfptCLeC4fS
	 8hGh0vOYF1gWW8PMDE3M3D4szioUPh8hyxojA5E0iTHXQc9fUvjgyXc0RhKSv8Cdlt1O1
	 r/kC4y/aW2L8C1DeYC0vdVvVGlnlWtyrXDBGRnIhxMpgUf0umppB9VReWeveO3FEqVTu6
	 Nps7q5iG/psXIzvk4qoALB/LXzJTrwbiO1JKVxiA6IjBBoUnNSBewWYwvhUweAhbxCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b="D1E467v/";
	arc=none smtp.remote-ip=185.136.64.225
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05ED606A817
	for <xenomai@lists.linux.dev>; Tue,  3 Nov 2026 10:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B05ED606A817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=D1E467v/
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202611031008010d50e7e4d300020795
        for <xenomai@lists.linux.dev>;
        Tue, 03 Nov 2026 11:08:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=QTJ9qW2Kx0mGTwffy9gOQGS1esAL3VyLBZ78qbGqK4U=;
 b=D1E467v/Z7YFzhuJHIt0oZAaVDiEfGuZ+jFkgWeOdx6sGLyKKlEumjD6bbzpW5ORxyYZtN
 eWJmpRvh3jiYzhnPz2qNA6xzzDBb1N3qh+AwauW7XKdS/RxvjMYM6J164RNhqzD3Yakj8feK
 SUMx1r9RTX9pujc1xQWJBrB/3WOeV//DEJTe+F5RbAidMEQ2BKndsUp2EeDMl0qqxP+Hex2P
 P9yacsRCXYA8dRI9Bpc1Z0izaJLDbtj1nfIRu/xK5sbicC6I5lo47ART6BOAnKo+jVSDXdB2
 soV/S+Rbg2+5qpYdIL1kWNPELi6e3q6/sv7oYBCcooTl+YmPzGUfc3kg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 03 Nov 2026 11:08:00 +0100
Subject: [PATCH Dovetail 7.3 v4] ARM: dovetail: Fix inconsistencies in trap
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
Message-Id: <20261103-wip-flo-v7-3-fix-arm-trap-inconsistency-v4-1-afc37569c383@siemens.com>
X-B4-Tracking: v=1; b=H4sIAH+y6WoC/5WOTQ6CMBCFr0Jm7RBKgaIrF97CsChlkEmkJS2pE
 sLdbbiBy5f3870dAnmmALdsB0+RAzubRHXJwEzavgh5SBrKomyEKEr88ILj22FUKHHkL2o/4+r
 1gmyNs4HDStZsOMjW9LW6tlVdQ1pbPKX0SXrCw0VaNb8zlUvokjulmvPbeSPKM/M3MUoUKJRsG
 1WQqmR/D0wz2ZAbN0N3HMcPMlBGqu4AAAA=
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
---
Changes in v4:
- do_alignment(): Return unconditionally after the first
  dovetail_fault_exit() call 
- Link to v3: https://lore.kernel.org/r/20261102-wip-flo-v7-3-fix-arm-trap-inconsistency-v3-1-1738670e743b@siemens.com

Changes in v3:
- Fix ordering problem in do_alignment(), calling
  dovetail_fault_exit() after hard_local_irq_disable() would
  trigger a WARN_ONCE().
- Fix whitespace issue in fault.c

Changes in  v2:
- Fix wrong comment in do_bad_area()
---
 arch/arm/mm/alignment.c |  8 ++++++--
 arch/arm/mm/fault.c     | 12 +++++++-----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 612db267f6246d5e5ed1c2e9291d51e315aaec25..336011105f27e2bcbec7b2d7674d224d376dd915 100644
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
@@ -1001,13 +1003,15 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		 * entry-common.S) and disable the alignment trap only if
 		 * there is no work pending for this thread.
 		 */
+		dovetail_fault_exit(ARM_TRAP_ALIGNMENT, regs, irqflags);
 		hard_local_irq_disable();
 		if (!(read_thread_flags() & _TIF_WORK_MASK))
 			set_cr(cr_no_alignment);
+		return ret;
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

