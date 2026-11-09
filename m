Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208377;
	b=dXajMZgMc/tL8zIB+Qa/NrVcRKWtiV7gmMnL3sl89Pwy+h4TCxDOdnMRrOXadYeCUjpv
	 pooM9omuGsvTMaKrk/deUHGgPP2pia386N5tbA7ViDdqh0or3kY/sVg9PhSGs7X/K1YsN
	 JUEhQzPZjTDVOTUi/IKtQDWu/WhZ/zYzuFXCasvmYdMheB/CtMwIkdSV7yiAKN76j6+NL
	 nrFBzp/HIgrNylkkXO5rKF59IIHd/LUCLRIs6EZck1oOlHsn7Kbe1kwj4MhyMfPR8yBzG
	 zNqqhFBYaMM44AmVA0xqZ3Hpb1iSqanQttcRSb6r04/N/xyB/lflMDFpveRrFsNyRig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208377;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:
	 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID:
	 X-GND-State:X-GND-Score:X-GND-Cause;
	bh=9+QP5VgC260cGjYUL9TgCLgVdCTH+trB/n69utDzyqo=;
	b=eQFvAYdZZiNhway2VJTKHDnKSVDRRGmjUskiEySvBrcbwwlSNsFsgRLyrhNqLtObknjz
	 n5dZLpPUG2tFtrLxWpfN00of+ztF7MX9JtL+4uMUwYWH3APe4bftGjZ6X3cDmq4xOPf0O
	 xD1+8+PeP5Rv2zxiDKeb2y3vlPxY5Wz+NeTPzP20u/KtkQ/swOhhSusNS68jhnd0BoJxu
	 3vA8Qcy+1AJTrEjrFq+A5oF0bgjoNtGeGCD818/Q5sFD+vsh1WGO5BHVxvXVbNoIIYVOf
	 SoymU10f8wGRzF7OfZokzF8jvJ2DtjY/Y3RW/EPnGEFlgibzvbaM3m0cldcHNSjKDaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=AXSql9XH;
	arc=none smtp.remote-ip=217.70.178.232
Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6D7606A321
	for <xenomai@lists.linux.dev>; Mon,  9 Nov 2026 07:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A6D7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=AXSql9XH
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id EFCCB3E975
	for <xenomai@lists.linux.dev>; Mon,  9 Nov 2026 07:12:46 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B6F2DC00486
	for <xenomai@xenomai.org>; Mon,  9 Nov 2026 07:12:46 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm2 header.b=AXSql9XH;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20261109071245f8a6b00439000207ba-aETlyU@rts-flowmailer.siemens.com designates 185.136.64.226 as permitted sender) smtp.mailfrom=fm-294854-20261109071245f8a6b00439000207ba-aETlyU@rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20261109071245f8a6b00439000207ba
        for <xenomai@xenomai.org>;
        Mon, 09 Nov 2026 08:12:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=9+QP5VgC260cGjYUL9TgCLgVdCTH+trB/n69utDzyqo=;
 b=AXSql9XHh2JmfSPMiRWsnbNaBUqzjz+c4b+LVcjCnf59zr10Coleedy2IioXrv9UTNufdn
 vjfjJ1flADwVwqfSV/T/l03aE00vt1UpJF6yVnMk534HmaAj8Ivdzz65A7gdN1XFUEeVO9JI
 zIGr7gfTghIjHm9LWi5qrX/BsicYu7feCMY8mXcs9OjwFuVwu6pZ0UGs8IYoPg9WtqxrcxnO
 BYQlb0ZtrqHLYhV4tEaTq+eELPn4yzDd747R4WmHKcE52uajt7AP5+PY6o9Zu66zH/VlPXvD
 kJftadSvag+MyU56bqr3N+D53PHicLhnNCNT9OHWZ0rHR4/KY9bofQQw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	xenomai@xenomai.org
Subject: [dovetail][PATCH 3/4] ARM: dovetail: Notify the core about undefined instruction traps from user mode
Date: Mon,  9 Nov 2026 08:12:43 +0100
Message-ID: <d425108b1f1a00c99f9dc474ff5a3f72d58806c0.1794208364.git.jan.kiszka@siemens.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFM7VoUm4Y2opacq4ToBP6PzeqLNgyuOTeUtSX+Se0OjKeCHbYJFVU93a8FdxEPBCuJ24ThuqJyPbX8uvg6TNLPTehHKKEd+WxfTo+wNxT746l757CKobvO8PntEhvyyNamGbkZyZTTcYm483vt+93MqvTXmyIUpN5HKdq5sS3G6x02qOq8FLNRy/I8ghdas8MvsEH+J0hRqiBQANstnbi6C0q8ju3DSAxg+A6tCvF2wlvwZq7HlQY0QJpxrxFiHeh0jieE/MBP6QV12dk6jyHVTLOVjkJa0j2IzlOTqghHcjvaqeSTiKPsxHsf7Od8mcC5EnxJNjgyi/Lfgk36FC49Zz9bjAOeO28DHm5Gc8kOwJyVZwsiO95NidCZLzZMFJ26U/nRfeab6fSImDEOgK+KaRlHI1xdTSOOeOscT71jb2aMYO6JTb3dZ6Ic/tMu2Msn0YCrMSe/uN/GDQOab1xxH8/0BcTtH5Fv09jx6cwlQqpT59H6E5w7Mrf0lCfXmtQMv6vJ27q/u5rLFsJ2rg7lY1pcknNBb1kqZvpqApG5CJVrMWKrAPVIoZhKSvZR0mr5v6LfYy6XqgBoPWuIFiCttrMK1Vx4+UbtjYM9obKzm6ztYogkSxz7F/R9cQj+nZerav1DUs/VhEtgVd35UsfdS6JraVhstg0L3h8fSHKXeA

From: Jan Kiszka <jan.kiszka@siemens.com>

Unlike the kernel mode entry (__und_svc), the user mode undefined
instruction path does not inform the companion core at all. This is
intended for the undef hooks which must stay oob-capable, like the
lazy VFP state restore in vfp_support_entry(), but leaves the in-band
fallbacks of that path unannotated, so an oob thread may run them
from the oob stage:

- do_undefinstr() raising SIGILL when no hook claimed the instruction
  or the instruction could not be read from user memory,

- swp_handler() emulating SWP{B}, which accesses user memory (and may
  fault in pages), takes the mmap lock and raises SIGSEGV on errors,

- uprobe_trap_handler(), which depends on the in-band return to user
  path for running the probe handlers, a path an oob thread skips.

Annotate them. do_undefinstr() uses the conditional form, since the
companion core may want to handle an undefined instruction of an oob
thread entirely from the oob stage, in which case it does not demote
the thread and we must not inject the in-band signal (this is the
behavior arm64 implements in do_el0_undef()). Kernel mode faults are
already covered by the notification issued from __und_svc, don't
notify twice.

swp_handler() and uprobe_trap_handler() are restricted to user mode
by their hook descriptors and always need the in-band stage, so they
use the strict form like break_trap() does.

Assisted-by: opencode:Fable-5.1
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/kernel/swp_emulate.c  | 22 ++++++++++++++++++----
 arch/arm/kernel/traps.c        | 12 ++++++++++++
 arch/arm/probes/uprobes/core.c | 10 ++++++++++
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
index fdce83c95acb0..39b45c598f7f0 100644
--- a/arch/arm/kernel/swp_emulate.c
+++ b/arch/arm/kernel/swp_emulate.c
@@ -23,6 +23,7 @@
 #include <linux/sched/mm.h>
 #include <linux/syscalls.h>
 #include <linux/perf_event.h>
+#include <linux/dovetail.h>
 
 #include <asm/opcodes.h>
 #include <asm/system_info.h>
@@ -161,6 +162,14 @@ static int swp_handler(struct pt_regs *regs, unsigned int instr)
 {
 	unsigned int address, destreg, data, type;
 	unsigned int res = 0;
+	int ret = 0;
+
+	/*
+	 * Dovetail: emulating the access may fault on user memory,
+	 * and failures are reported by signal. We need to run
+	 * in-band for this, have the companion core demote us.
+	 */
+	mark_trap_entry(ARM_TRAP_UNDEFINSTR, regs);
 
 	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, regs->ARM_pc);
 
@@ -171,12 +180,14 @@ static int swp_handler(struct pt_regs *regs, unsigned int instr)
 	case ARM_OPCODE_CONDTEST_FAIL:
 		/* Condition failed - return to next instruction */
 		regs->ARM_pc += 4;
-		return 0;
+		goto out;
 	case ARM_OPCODE_CONDTEST_UNCOND:
 		/* If unconditional encoding - not a SWP, undef */
-		return -EFAULT;
+		ret = -EFAULT;
+		goto out;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	if (current->pid != previous_pid) {
@@ -220,7 +231,10 @@ static int swp_handler(struct pt_regs *regs, unsigned int instr)
 		set_segfault(regs, address);
 	}
 
-	return 0;
+out:
+	mark_trap_exit(ARM_TRAP_UNDEFINSTR, regs);
+
+	return ret;
 }
 
 /*
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 8ca5ba26d2598..059a1dc900431 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -483,6 +483,16 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
 		return;
 
 die_sig:
+	/*
+	 * Dovetail: the companion core may handle an undefined
+	 * instruction raised by an oob thread entirely from the oob
+	 * stage, in which case it does not demote us to in-band and
+	 * we must not apply the in-band fixup. The kernel mode case
+	 * was notified from __und_svc already.
+	 */
+	if (user_mode(regs) &&
+	    !mark_cond_trap_entry(ARM_TRAP_UNDEFINSTR, regs))
+		return;
 #ifdef CONFIG_DEBUG_USER
 	if (user_debug & UDBG_UNDEFINED) {
 		pr_info("%s (%d): undefined instruction: pc=%px\n",
@@ -493,6 +503,8 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
 #endif
 	arm_notify_die("Oops - undefined instruction", regs,
 		       SIGILL, ILL_ILLOPC, pc, 0, 6);
+	if (user_mode(regs))
+		mark_trap_exit(ARM_TRAP_UNDEFINSTR, regs);
 }
 NOKPROBE_SYMBOL(do_undefinstr)
 
diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index 0e1c6b9e7e54a..06b3b5e37e73d 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -10,6 +10,7 @@
 #include <linux/sched.h>
 #include <linux/uprobes.h>
 #include <linux/notifier.h>
+#include <linux/dovetail.h>
 
 #include <asm/opcodes.h>
 #include <asm/traps.h>
@@ -185,6 +186,13 @@ static int uprobe_trap_handler(struct pt_regs *regs, unsigned int instr)
 {
 	unsigned long flags;
 
+	/*
+	 * Dovetail: uprobe handling runs from the in-band return to
+	 * user path, which an oob thread would skip. Have the
+	 * companion core demote us first.
+	 */
+	mark_trap_entry(ARM_TRAP_BREAK, regs);
+
 	local_irq_save(flags);
 	instr &= 0x0fffffff;
 	if (instr == (UPROBE_SWBP_ARM_INSN & 0x0fffffff))
@@ -193,6 +201,8 @@ static int uprobe_trap_handler(struct pt_regs *regs, unsigned int instr)
 		uprobe_post_sstep_notifier(regs);
 	local_irq_restore(flags);
 
+	mark_trap_exit(ARM_TRAP_BREAK, regs);
+
 	return 0;
 }
 
-- 
2.47.3

