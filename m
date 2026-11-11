Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399058;
	b=38Zr++6zky6T9fX9fp7Nc24SOg0rvXIPAOTPWg04iS58GCD2/dlihweLbnPb5GBilyXJ
	 tV/stY6lU2cmXZ8w6UsIn1SSgW9ZzvFYNLAlaFDEG9MyzfuKXf0y6meu8A+4Hox4Dd/Ed
	 kIFdPJ65jTp4OcFmqjA61FOmqFYzzJ4/vYX5NFSXT33xP4Y67bKZDAgmOPDtCLIdPCWsN
	 2siSaAJZKoG/gURUMHGWJIDjTLkPeRT/4Oo9FuAty5LVT2Y1dcpf58FSTDOcmaA2RC5jJ
	 JMcg5gPv/6y6a2BjKs2daKjJjpzbw1GYZswC+kzd4uqDG5gGNcY12OJo9bsMFxvIPbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399058;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:
	 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID:
	 X-GND-Cause:X-GND-State:X-GND-Score;
	bh=9+QP5VgC260cGjYUL9TgCLgVdCTH+trB/n69utDzyqo=;
	b=mpXUCJ1Qgpp27IKXMLMm0jj5ZBbSrwXZkleI8V4Bn8SlEFCcyGUVOclI1dmFj/80/wuC
	 oQAS0RB2tprBtMxiJhxlhCBGG81+mQHRJDomhz8uOoc3DQYY2wubhYtt1QV3PzVTQY2o/
	 srw4NhEyGwlI9zCZlxe4NLPp0YO3SnDcQEPm7a9MYw88tP0kyJSWtVmhOtifaKQf3Dk8/
	 CK8aJpn34b9i+SuRsH8XNYSTjFiX51fI/5UFxcAiarQ+ZbOIsecxoq402/Q0RRtODzvck
	 DzzJQSkoabcFSkkKkZMI1wBGyKfCXbwBor2hzMzumuFZ1YZorV1eqIzkDZfOIVrgJ9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=JskwZdQV;
	arc=none smtp.remote-ip=217.70.178.231
Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DECC606A338
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 12:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DECC606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=JskwZdQV
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 9A07B3ECB3
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 12:10:50 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 4618027E0274
	for <xenomai@xenomai.org>; Wed, 11 Nov 2026 12:10:50 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=JskwZdQV;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-2026111112104955b7e48bfd000207ed-vohNpP@rts-flowmailer.siemens.com designates 185.136.65.225 as permitted sender) smtp.mailfrom=fm-294854-2026111112104955b7e48bfd000207ed-vohNpP@rts-flowmailer.siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2026111112104955b7e48bfd000207ed
        for <xenomai@xenomai.org>;
        Wed, 11 Nov 2026 13:10:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=9+QP5VgC260cGjYUL9TgCLgVdCTH+trB/n69utDzyqo=;
 b=JskwZdQVy7yKMXtt5eW38/pctTp6PiPYoTlKQNv6BgyHuR2NtDYGVfQTvkCA6JFymsBar9
 QYa+gNcU4XTFbMJnxQRxYIkoX2BhF3EEnwY6QzMV4qnoDscvLPn9lnxzXace00u+0w9xCWMX
 8mRN+1BO7bM8tFbsyzGLlmLYtBiLukwoElvgyWfzI7TV4W/493YqieGjiG5J0bKZgXcTK6N8
 l6yKBvO+4J/H1NEG7sxsLvvovESlXYCAa6jsKirnfT67OPtYSenLi4M5KsSdGVQZHtGRpVPG
 1OL4XPFKCEx3+a09SAHvl/9Nz1+w4b7s9ntN2D9ezX3pYqkQj8Ft0yXQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	xenomai@xenomai.org
Subject: [dovetail][PATCH v2 3/4] ARM: dovetail: Notify the core about undefined instruction traps from user mode
Date: Wed, 11 Nov 2026 13:10:46 +0100
Message-ID: <7184813b876d9e138cb8d93802ba19b97dadf177.1794399047.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1794399047.git.jan.kiszka@siemens.com>
References: <cover.1794399047.git.jan.kiszka@siemens.com>
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
X-GND-Cause: dmFkZTGVONs7jqIhW0VdlqRSqfb7y0Kvn7XVihjBeBze4/kEiFBhyS34TbN0PtjLLY+JTjoybjgoJDK90bIpPnEnl+xbkr9bDZ6ozwDiOe5rgewHfTCybAwwjt3AL3eR63R9Rx0EtzVJ3ffr3IW8LIuuNfo6PXD4sBC7WwC4e68UCWr2wzR6/PU86gUUzQbJKTCxGfz1qTkBtrdVKcLMmnEOH/ULfrf2hxldcIPTfGXFRecreEodcLAxMiStU26SOR/aklyQUpK1K61zewNC9AEDtlXL1tKGYKB4bhYKs4IhsLLtNzet1fkb322Ws54vm/pr2Wx4gg8XMBY+8gfeq7ecmllOLoW/CYVVo4J0UaoBluZIVXW+ijZmik0Vk6YANEEViQQPude26XqtZMI1c0E39TJ57OezWxQ1MEu77iZWxX0n83WFA7pCM7v6m/cKdVjWzXcsHMN8BWwVhFjYm92H+Fd6FvmBYPtf53QOPDPBsBL/QzOujG4YckpbBxdH8/2q1vrVggRVpZ+s/aiKWV7zwIur+fdDAgm1G6hhNzo6U2IzG5DA2JFvXc9HD5kjQtrVdv4RjEuKGOmcuTh3IychljcE15eZeGmfRm+CpdGwk3oaItAGOJmChIEKj9+Vu/cUftBsjtSI6JqcddxMKVxFht8cBQGDFpMaLqcJxFZa5dq1EQ
X-GND-State: clean
X-GND-Score: -100

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

