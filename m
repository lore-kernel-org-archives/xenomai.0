Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208376;
	b=gKHPeclg4GT03uhf9wlmH/Q4EQ4mnaYV+PN/XXGj1H0ZBUWZpZKcw6E9AbaS2xZX+7lU
	 UCdMN/q2daNIKHjbkV5rNc4hyYlfmXOtrr2FbjPGl3A9pWhM6a7z7GIAvGmLRcX+fRISP
	 gU2aDLs2AlAwqFZ+Q6ofakqHH11pQKmO0cv/AC5083gtHp5sIrXGywjvmC4rFS9CgmwWV
	 miL7a+MGFioxRpjozPiMBoIqM9DDNdF2E4BFmIJzX1SeWhmRzZhjGW0c4tU5NWkMWpMHb
	 DXJY0TLJMPekTU2ZHHRE9zkYZ8+aI2tQZKFAT+8OeNxGsXghf2gzQg/kXl+7lH0efdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208376;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:
	 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID:
	 X-GND-Score:X-GND-Cause:X-GND-State;
	bh=jG5tGH9uwtxyc64uQ4slEsGZEMpOA1TZsXOtyCl+Ol0=;
	b=kPzJmur1YWu1YEJthAzQG0KSuVS+6r8pVd0jbB06tNX8stjqIBsEISilUPtwSeaVd6C1
	 bV/8hNlk2Q/81A1q53gQ0NpCq8BS0CO8YAQrBs8TXo0Ce797X3MnvUnpIrvFZ9WGddGMP
	 vYvlgXf59SHITSTNXAxLMa526jWP7643u6BJUHr9vuLfQ0jPmTfwL8SYM9u5UevTYFoAF
	 MIfYd4zI2ZtVo/YueWa2hhGW7Nmd2M3kcuBH2YSIoxOywjDgBMgx6sq1l0XZkJCBAkLWc
	 2d6F8QP4AvX6E2uGkN2RC4Pmb1K4DGMkMwtCB/3mIu/usrk77R2nOqXHY/VMEIBX8bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=qREIhIPN;
	arc=none smtp.remote-ip=217.70.178.230
Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77980606A323
	for <xenomai@lists.linux.dev>; Mon,  9 Nov 2026 07:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77980606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=qREIhIPN
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 01B953E958
	for <xenomai@lists.linux.dev>; Mon,  9 Nov 2026 07:12:47 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	by spool.mail.gandi.net (Postfix) with ESMTPS id BD791C00621
	for <xenomai@xenomai.org>; Mon,  9 Nov 2026 07:12:46 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm2 header.b=qREIhIPN;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20261109071246ccfad294680002076e-S0m7__@rts-flowmailer.siemens.com designates 185.136.65.226 as permitted sender) smtp.mailfrom=fm-294854-20261109071246ccfad294680002076e-S0m7__@rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20261109071246ccfad294680002076e
        for <xenomai@xenomai.org>;
        Mon, 09 Nov 2026 08:12:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=jG5tGH9uwtxyc64uQ4slEsGZEMpOA1TZsXOtyCl+Ol0=;
 b=qREIhIPNRqHktKhVJsJ+PZpszIPzLvRr52WEpTtroKqNDzvARpq9QTNFDJtRqq2FktvWY6
 8mMgyorGZIyI25nf/d7M+PzVM2nDwiJWgstF2tTyafCn7NIaKMy4CqUMMRk7KimGcOtOqTko
 n3wjz/58WFQX8G+/laAg4XjQ1NvVY9j4S2hCZVBASfxUuL+objfQaWdD8x3WOJzFs5gEClrF
 E21s95upgQoqWIW3pSG/18VF8s7VNsFzEjNDdFUe77SVyzX4EGVSoX6Psw9oNTTbTeHw6Kex
 68xptt4d6JE76BAIttZVptKMYvVdR5WsAhlJvc3PGQHD0BybaDViAumQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	xenomai@xenomai.org
Subject: [dovetail][PATCH 4/4] ARM: dovetail: Fix VFP exception trap notification
Date: Mon,  9 Nov 2026 08:12:44 +0100
Message-ID: <867ff3ddc080f8e7e01170861aa6877e1e07d571.1794208364.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1794208364.git.jan.kiszka@siemens.com>
References: <cover.1794208364.git.jan.kiszka@siemens.com>
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
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-GND-Score: -100
X-GND-Cause: dmFkZTFWphzIPhV9WHvYua4DF1BZD4GuvIEZqWaEz24AfW07JMwngqXzaH1Zl7FJQRuV4osMxDRvvLOVGCnv8uwqtwyJAcZMAZ1cxHdcuC+ZYql0TgvAKbqIfT2PFFPAGC/LS3Y9uCx6GsyzeM4ZgyjgQB4DzjpRAiLBKSLDsBzRttNbePpzh0jo3C1s/rG17f3ZcPaqWTBVsXl5Ft2ftoT2Vxp1LEvcwOwEzBUycF49TIbBAUHov+PFwG02qmlo0turwuVN/kZfJ1ttll0h7VMkGRnoUYkax1XrQQAbhfKEVnjJ5LXGKezjr2POZeoQzz8X1Wb/HDUCswKSBnDU8iVHt5IIdacaDlYxzoo8BvZmtNAkx+DFnCggsYYzOfi8q0CTK9z/CqhRLqLOF9zSFyQ3tdY02P25RUvIgLLRhH6oLkt4CXhKI1I/DvcmVh8g8j8ovhgeDDUTqYaX8NdeH1P7fjgwSsiTln419tzMa1AgJvEbL6a+t81h6R+oFyf609ZD+9jLRqguy/+GghK90eX3ibsrdHHdrfLGzIXDLAFSAIAic/AQOMXLb/MQLhsddw1CukxbKiu2hSIROMF1YgpQYnn1ytdL8aKXlXkldUDvRERgbwO8ydEp6JDUWc/1UeCnmEaT2asq6FzG7hExGEsfD9VIklKX+QMFD0bcEefKzPW9AA
X-GND-State: clean

From: Jan Kiszka <jan.kiszka@siemens.com>

The trap annotation of the VFP bounce path predates upstream
commit c0b5195bad63 ("ARM: 9426/1: vfp: Move sending signals outside of vfp_state_hold()ed section.")
which turned vfp_raise_exceptions() into returning the si_code,
deferring vfp_raise_sigfpe() to the exit of VFP_bounce() after
vfp_state_release(). The Dovetail hunk was kept in place verbatim,
which is now wrong in three ways:

- for VFP_EXCEPTION_ERROR, SIGFPE is sent twice: once from the
  annotated block in vfp_raise_exceptions(), once more from the exit
  path of VFP_bounce() via the returned si_code,

- the deferred signals for regular FP exceptions enabled in FPSCR
  (divide by zero, overflow, ...) are not annotated at all, so an oob
  thread sends them from the oob stage,

- the annotated block runs within the vfp_state_hold() section, which
  under Dovetail is a hard_preempt_disable() section. If the core
  demotes the thread to in-band from there, hard_preempt_enable()
  pairs an oob-stage hard_preempt_disable() which did not touch the
  preemption count with an in-band preempt_enable_no_resched(),
  unbalancing it. Besides, that was the very reason for the upstream
  change on PREEMPT_RT.

Move the notification to the exit path of VFP_bounce(), after the
VFP state was released: if any signal is to be raised, have the
companion core demote the thread, or skip the signal if the core
decided to handle the trap from the oob stage. This mirrors what
arm64 does for ARM64_TRAP_FPE in do_fpsimd_exc().

vfp_raise_exceptions() does not need the register frame anymore,
restore its upstream signature.

Assisted-by: opencode:Fable-5.1
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/vfp/vfpmodule.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 4bbe92c619f2d..5589eb76379b5 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -283,7 +283,7 @@ static void vfp_panic(char *reason, u32 inst)
 /*
  * Process bitmask of exception conditions.
  */
-static int vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr, struct pt_regs *regs)
+static int vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr)
 {
 	int si_code = 0;
 
@@ -291,10 +291,6 @@ static int vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr, struct pt_r
 
 	if (exceptions == VFP_EXCEPTION_ERROR) {
 		vfp_panic("unhandled bounce", inst);
-		if (mark_cond_trap_entry(ARM_TRAP_VFP, regs)) {
-			vfp_raise_sigfpe(FPE_FLTINV, regs);
-			mark_trap_exit(ARM_TRAP_VFP, regs);
-		}
 		return FPE_FLTINV;
 	}
 
@@ -437,7 +433,7 @@ static void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs, unsigned lo
 		 * unallocated VFP instruction but with FPSCR.IXE set and not
 		 * on VFP subarch 1.
 		 */
-		si_code = vfp_raise_exceptions(VFP_EXCEPTION_ERROR, trigger, fpscr, regs);
+		si_code = vfp_raise_exceptions(VFP_EXCEPTION_ERROR, trigger, fpscr);
 		goto exit;
 	}
 
@@ -462,7 +458,7 @@ static void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs, unsigned lo
 	 */
 	exceptions = vfp_emulate_instruction(trigger, fpscr, regs);
 	if (exceptions)
-		si_code2 = vfp_raise_exceptions(exceptions, trigger, orig_fpscr, regs);
+		si_code2 = vfp_raise_exceptions(exceptions, trigger, orig_fpscr);
 
 	/*
 	 * If there isn't a second FP instruction, exit now. Note that
@@ -476,13 +472,28 @@ static void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs, unsigned lo
 emulate:
 	exceptions = vfp_emulate_instruction(trigger, orig_fpscr, regs);
 	if (exceptions)
-		si_code = vfp_raise_exceptions(exceptions, trigger, orig_fpscr, regs);
+		si_code = vfp_raise_exceptions(exceptions, trigger, orig_fpscr);
 exit:
 	vfp_state_release(flags);
+
+	if (!si_code && !si_code2)
+		return;
+
+	/*
+	 * Dovetail: the companion core may handle the FP exception of
+	 * an oob thread entirely from the oob stage, in which case it
+	 * does not demote us to in-band and we must not raise the
+	 * signal. Otherwise, we run in-band from this point.
+	 */
+	if (!mark_cond_trap_entry(ARM_TRAP_VFP, regs))
+		return;
+
 	if (si_code2)
 		vfp_raise_sigfpe(si_code2, regs);
 	if (si_code)
 		vfp_raise_sigfpe(si_code, regs);
+
+	mark_trap_exit(ARM_TRAP_VFP, regs);
 }
 
 static void vfp_enable(void *unused)
-- 
2.47.3

