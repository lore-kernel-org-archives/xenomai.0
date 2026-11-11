Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399054;
	b=xbzqCWVwA7Qbp9ARvCtIJGk9NTA2HnP/mmUnPu3LJoG5gVTSEsMKxxwB6N7NWx3kYpoQ
	 3jCQ2xcNibFXBBhy4iA2U+oOyf4TtuneNT5AUf8pHyEwNf7W0hRlM9wEKOCxUo4X75G9G
	 N0TZmw7BbQNTLcptGk8bhLHtBfaDEIx41j/N3D6iFZ7THOFPpBjzTCxUGv29yuJRX5Img
	 Q+y6yTMIVOYdESwlRPS/rXDBtvRhp0HixnasjSQZIs8VVA1wEmsVzp4TYUXiYrw5uN6YE
	 3Ods3EKJGZWFdYw19yarVOCc/SBe1sGTrFPBWwRN9N8jEr5paRPQtPIJhJXZdjFepAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399054;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:
	 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID:
	 X-GND-Cause:X-GND-State:X-GND-Score;
	bh=jSdRxqNkanywQMy7AQjWVzOMDnCOdwmK0tdgs/fx4eA=;
	b=HlazLPBb+IRrdAqKC5kBsBQHcar0aQ8veOb5gVVQRsAbGF2jAPb1ho2pBFvNznEqzYEI
	 zldteSoTM6myLbqVfmqwQ6kSrjACOHcsRT5ZLOq1t5zwAtnZ8Qj/JwUmHyHIBKbLEEzRf
	 gbHhd+BdB8kGJnG/hVff+sdPVMnk3pla0gyHvZqprNMjyKHD8ahsmPjd5EPXlH4Zxk1Jj
	 iKdm31KJzSUPbz+mHXRHco3o5nL2nWBBPYdcDahECMFSAPAIYi+W7h4szyBjzZ+ZFT03g
	 4hqaUs9M0xuxOHMKVcDsUaLEHVuvdpdtMCXu0pKHZEuS1ZR+6EMP7peSaydUtYixBpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=rHe2PKwo;
	arc=none smtp.remote-ip=217.70.178.233
Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FF2606A326
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 12:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45FF2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=rHe2PKwo
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id EBDF03E97E
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 12:10:50 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 8700D560080
	for <xenomai@xenomai.org>; Wed, 11 Nov 2026 12:10:50 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=rHe2PKwo;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20261111121049f22920f7d800020747-5riIg5@rts-flowmailer.siemens.com designates 185.136.64.225 as permitted sender) smtp.mailfrom=fm-294854-20261111121049f22920f7d800020747-5riIg5@rts-flowmailer.siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20261111121049f22920f7d800020747
        for <xenomai@xenomai.org>;
        Wed, 11 Nov 2026 13:10:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=jSdRxqNkanywQMy7AQjWVzOMDnCOdwmK0tdgs/fx4eA=;
 b=rHe2PKwoSg0MRZhHnD4WU4Pyuo9m+d6B1ma1YAYquJqRESnDWTr3nht1lhh2LGRKamG70K
 i+VgZnGjPzVqw/sIf9+H1QqYp+ESFL/kVA2+cSbQGSVHiyPi5sQQCKNaV7EqvJ1jINIMqSfa
 42SfvwT5QrOvzZ+WFuFl+ElTrPfr2m/K6dypYbEYeV9PxaQg3noYy5eC5+XBv9x76mKELPDD
 poX5RDITLvs9wPfl1SUYia/u5x0ixQjpZYY++XQeAm3wI97SIBdeSPKvf1qs2KBHgS7mU81w
 cehHdJ+MJsh6mF1CSCPu4whinB5HpkMhJ7EtjficnVbhK7IBSEpoP/RA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	xenomai@xenomai.org
Subject: [dovetail][PATCH v2 2/4] ARM: dovetail: Fix trap unwind condition in __und_svc
Date: Wed, 11 Nov 2026 13:10:45 +0100
Message-ID: <9dbb8af8adfe5814f307e809919bd68fb4b12d8d.1794399047.git.jan.kiszka@siemens.com>
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
X-GND-Cause: dmFkZTGi4m/ZrOfaoW2KBYNYHxiI+w8JWz6o6NaiO561SlfGUfyM2AGFZC1l8U8rX8gfuLroS9YErLuISk8GXY28bF7lro0IAkCysK5w9WbcVUli+QLtg043vUBagq0ZJDaa3gAwrjGkELr+qSp/yxo1AmnAVDjAljUhGi0Q+npJMWHfoBhWhjQH+DNA5vtqIuuxfKJrhVNMHHukefuikWqJaVVrI523DdQba1IrrFyMBS9tkp5N8S+52N2Ggljn6TNMVvx4xfYu0FiqCA4W2PRXnyX3HBVBRUgJuzoSX+T1F+P+1YxwHW6q2igQPiFH3Rp/kSAupqFswRbnlWqrGJ8a+zw6YmlNtH3pYihHT8SKiD/qE2l2oo6ctN2d8jCVz5BzaUpvMSrqKziCsx/Aof1ZLWrVWhlYlOxhrvgqaSqiunTTiO9T5tn8Dui/57ellhoBSO9QMUL8tNzbbLHOaWE8TVhEm7bWNi98Ayvf+od35MZxz69AA1H4APNIxESgvxAkDI9h5NCjpjx34DGTaOibNSUd++BpJvGqTEwV5lr2G0ScFCaMrGJbKEY0132AzkNrHFQ5kv3FpuPPbi5mlVahAKZTLm0jAD86RpzWT8Ys1fVTuBbNybG7Rvidw72B5uAKc2Y5q2lnDk1Fx0DwqPMfg2J0hAZOfg3KWK5ulVKQramA9A
X-GND-State: clean
X-GND-Score: -100

From: Jan Kiszka <jan.kiszka@siemens.com>

The kernel mode undefined instruction entry notifies the companion
core from assembly, testing the current stage both before the notify
and before the unwind call. The second test is wrong: if the core
demoted the thread to in-band upon notification - the common case -
the thread is no longer running oob when __und_svc_finish is reached,
so the unwind is skipped altogether. As a result,

- handle_oob_trap_exit() is never called for that trap,

- oob_trap_regs stays set, suppressing every later trap notification
  for this thread until some unrelated trap exit eventually clears it
  with a stale unwind.

The C helpers get this right, keying the unwind on the owning exception
frame, not on the stage, also acting as nesting guard.

Replace the open-coded tests with calls to small asmlinkage wrappers
around oob_trap_notify()/oob_trap_unwind(), so that the assembly entry
follows the exact same rules as the C trap handlers. Overhead is
negligible in the exception path. The wrappers are blacklisted from
kprobes like do_undefinstr(), since a probe there would recurse through
__und_svc.

The TI_PIPELINE_STATE/TI_OOB_MASK offsets and the asm/dovetail.h
inclusion in entry-armv.S have no users left, drop them.

Assisted-by: opencode:Fable-5.1
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/include/asm/traps.h  |  2 ++
 arch/arm/kernel/asm-offsets.c |  2 --
 arch/arm/kernel/entry-armv.S  | 20 ++++----------------
 arch/arm/kernel/traps.c       | 15 +++++++++++++++
 4 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index 2621b9fb9b19b..8f7d526c36ecc 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -44,5 +44,7 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs);
 asmlinkage void baddataabort(int code, unsigned long instr, struct pt_regs *regs);
 asmlinkage void __div0(void);
 asmlinkage void handle_bad_stack(struct pt_regs *regs);
+asmlinkage void und_svc_trap_notify(struct pt_regs *regs);
+asmlinkage void und_svc_trap_unwind(struct pt_regs *regs);
 
 #endif
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index a5e5a666930ae..6135e9352335b 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -55,8 +55,6 @@ int main(void)
   DEFINE(TI_ABI_SYSCALL,	offsetof(struct thread_info, abi_syscall));
   DEFINE(TI_TP_VALUE,		offsetof(struct thread_info, tp_value));
   DEFINE(TI_FPSTATE,		offsetof(struct thread_info, fpstate));
-  DEFINE(TI_PIPELINE_STATE,	offsetof(struct thread_info, irq_pipeline_state));
-  DEFINE(TI_OOB_MASK,		STAGE_MASK);
 #ifdef CONFIG_VFP
   DEFINE(TI_VFPSTATE,		offsetof(struct thread_info, vfpstate));
 #ifdef CONFIG_SMP
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index a314c3152072b..1f44c9fad0186 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -30,7 +30,6 @@
 
 #include "entry-header.S"
 #include <asm/probes.h>
-#include <asm/dovetail.h>
 
 #ifdef CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 #define RELOC_TEXT_NONE .reloc  .text, R_ARM_NONE, .
@@ -298,14 +297,8 @@ __und_svc:
 	svc_entry
 #endif
 #ifdef CONFIG_DOVETAIL
-	get_thread_info tsk
-	ldr	r0, [tsk, #TI_PIPELINE_STATE]	@ get pipeline state
-	tst	r0, #TI_OOB_MASK		@ oob stage?
-	beq	1f
-	mov	r0, #ARM_TRAP_UNDEFINSTR
-	mov	r1, sp				@ r1 = &regs
-	bl	__oob_trap_notify
-1:
+	mov	r0, sp				@ struct pt_regs *regs
+	bl	und_svc_trap_notify
 #endif
 
 	mov	r1, #4				@ PC correction to apply
@@ -317,13 +310,8 @@ __und_svc:
 __und_svc_finish:
 	get_thread_info tsk
 #ifdef CONFIG_DOVETAIL
-	ldr	r0, [tsk, #TI_PIPELINE_STATE]	@ get pipeline state
-	tst	r0, #TI_OOB_MASK		@ oob stage?
-	beq	1f
-	mov	r0, #ARM_TRAP_UNDEFINSTR
-	mov	r1, sp				@ r1 = &regs
-	bl	__oob_trap_unwind
-1:
+	mov	r0, sp				@ struct pt_regs *regs
+	bl	und_svc_trap_unwind
 #endif
 	ldr	r5, [sp, #S_PSR]		@ Get SVC cpsr
 	svc_exit r5				@ return from exception
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 60c4725fa8530..8ca5ba26d2598 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -27,6 +27,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/irq.h>
 #include <linux/vmalloc.h>
+#include <linux/dovetail.h>
 
 #include <linux/atomic.h>
 #include <asm/cacheflush.h>
@@ -495,6 +496,20 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(do_undefinstr)
 
+#ifdef CONFIG_DOVETAIL
+asmlinkage void und_svc_trap_notify(struct pt_regs *regs)
+{
+	oob_trap_notify(ARM_TRAP_UNDEFINSTR, regs);
+}
+NOKPROBE_SYMBOL(und_svc_trap_notify)
+
+asmlinkage void und_svc_trap_unwind(struct pt_regs *regs)
+{
+	oob_trap_unwind(ARM_TRAP_UNDEFINSTR, regs);
+}
+NOKPROBE_SYMBOL(und_svc_trap_unwind)
+#endif /* CONFIG_DOVETAIL */
+
 /*
  * Handle FIQ similarly to NMI on x86 systems.
  *
-- 
2.47.3

