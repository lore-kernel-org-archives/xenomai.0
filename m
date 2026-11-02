Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630110;
	b=4SCFgM+5qpHkBKKcs/I+Av4E7MHVwPfQvTDb/QBR8e2nrwbne43MMsst9EyY0mmnXdp8
	 nnOkQgfXceNOEpeCVO8NCDQ15A33uRNS4HQqVTa9F7RbuJfws9QX1xoCaHWdwcGMjmtG4
	 lPulx2gTarQDcmPZoyunwsDWZe74wmfdFirgdYNa68FA3sNctCZ3h1ACI3DHA81CT0Q+L
	 Mp4ypRuWojCwL2h/pknB6o3O8goQjx405hT3IoB+4vjqyFzRD9CXtXk9+SJPb7U2TLFef
	 LK/ks1aSt4dN3laR4UQ6WWOlQRarYGb0ayGG3Rg50fLhTG4u8UsVwNYYin3xNgqZ9mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630110;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID;
	bh=8VMNe9I251uou/B+uX4ioIpdZexssZv6TXW1dK6LcZI=;
	b=Ewkqt5WqvgX88iqSFQNsI0JUOwqo/fqv+Y2UGF6CDjfF/wcyqsxLNkN04zba8AY+3LYa
	 NU2GA6jQkHDp6Nw6qXBi1BePvHVJj6L7y0n3V7GFA0voBIFQedLybNfS1OJ5r7hL/3bnC
	 hXN39PuvZr4Uqwqj6EEtOWtKLkymUqWQKEFHbXUcIZ5QfglObkZ37CVWvEPNLlKGJhVLD
	 gdujwuBaGbicujzg7Ka+AH+MNuBVS+J3BbPtTv/Ghwhcp0yo8+ybTAk44lrZneQ0wa2N6
	 bHrPw4I9j76eQFYJkiPH+sPuYtjbPOdWEQTNQ4RiAFKZTh3avkVYqnUQ9+3eon8ugEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=o4+So2nd;
	arc=none smtp.remote-ip=185.136.64.228
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C436072C7A
	for <xenomai@lists.linux.dev>; Mon,  2 Nov 2026 14:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0C436072C7A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=o4+So2nd
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202611021435013c87b8098000020768
        for <xenomai@lists.linux.dev>;
        Mon, 02 Nov 2026 15:35:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=8VMNe9I251uou/B+uX4ioIpdZexssZv6TXW1dK6LcZI=;
 b=o4+So2ndkB15p6NmMUoSOEwSClCVV+JRHDiV4J/fk9p0F8Dc4fEE4NmiXeU+mqXROf93TB
 9RnYg1N9Ua4XgdtM9KFOdlTl9LA2NGcrHQ2XTenqxr2LnoJ/v+8S5FTCsYbqZxoYCsTVzYXR
 LeCiha9tw6gZ1r/rBl/nb261GD5BOg63/nH2/Gbbt3ZkaWvDrTZPq3PYTUo8LyOx3AZwsRg0
 96LwPZ6+9lZ5WzvE/A0jEcWBB8ATqh45IsoJk2Wk9LI7NaAGgdvefYgF7ofdOiaoprupIwS9
 skGFINREJNmDBv5u21oZ4Tpf9sksd/he180nFyFCOkT1UtjxootO/DNg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Philippe Gerum <rpm@xenomai.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail 7.3 v2] ARM: dovetail: Fix inconsistencies in trap routing
Date: Mon,  2 Nov 2026 15:34:59 +0100
Message-ID: <20261102143459.735942-1-florian.bezdeka@siemens.com>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

 Changed in v2:
   - Fix wrong comment in do_bad_area()

 arch/arm/mm/alignment.c |  6 ++++--
 arch/arm/mm/fault.c     | 12 +++++++-----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 612db267f6246..34c3b7c10be41 100644
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
@@ -1007,7 +1009,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	}
 
 out:
-	mark_trap_exit(ARM_TRAP_ALIGNMENT, regs);
+	dovetail_fault_exit(ARM_TRAP_ALIGNMENT, regs, irqflags);
 
 	return ret;
 }
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 95870a96a6286..8081cb3e633ca 100644
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
+	  if (user_mode(regs))
 		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
-		dovetail_fault_exit(ARM_TRAP_ACCESS, regs, irqflags);
-	  } else
+	  else
 		/*
 		 * irq_pipeline: kernel faults are either quickly
 		 * recoverable via fixup, or lethal. In both cases, we
-- 
2.56.0

