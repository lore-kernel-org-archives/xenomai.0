Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399059;
	b=QIM9SYf5O+J8MTOc/PpB1BTcl0fBHa+MayE9PO0WN9Nn4hYhZmz9J1BnKteLVwTd7CEr
	 L+dIBy3tjXfdxBzCxdrpOY8vf+LNIsXM4UO0nT57FhVozKQ59oTif4F0V0dRiOrql44jM
	 HKHXqFOyDTn7JEctTCP34MWFYAN/dePgPQO3bHJ+UDTAebtBOmTlmmAH1Hzz5Se0p9rKM
	 ClNzT84NjgpldbhXk/Oh23i7USDKCJgrou7r50AKsAT+4BooTpiyxaot37gW8qt7a8n2K
	 MRCcYLC0bUVEA54YvMtjl0EGGUzuDeDXK1/pRb9oaLzE2Ch48LawQobkWC0csukUFwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399059;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:
	 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID:
	 X-GND-Cause:X-GND-State:X-GND-Score;
	bh=MtcBwRpoJQ409IByhD8u73fFUGNrDF9LECd4trN/vlY=;
	b=Y+tXiK2cmQJRKyapxvNVqmP3hc4PNGxBl1NLbDMgpujndDbvOuMVMvbt64gcoSfOjYY5
	 BhJXqJ1sBCbWkqBmEwpq8HGqBt7wouUa2n88SdOqnrNp35Rfjgz1OyikJ1iQAQfcifaCg
	 eQn2ulCVg0ispboCo7PLGWBu04buONXHrZQKedQi32ZUY+8SOr/G7VCeX3DkBNWK7GBjS
	 v1BOQiAGhFGqd4P64e6CuFpQnqj3qwIJ8AySAA2TFiOV3CdiJFO4Xs2y+VLGu189LalFI
	 lxXOf0TGI5YR25XAVb/ksCvumJj52EcgATUUqqdE7OsHGdY1pBVwActr+fNpSY9qbYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=nAzKXfN9;
	arc=none smtp.remote-ip=217.70.178.231
Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A15B606A33A
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 12:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A15B606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=nAzKXfN9
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id ABABA3ECBB
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 12:10:50 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 4479527E0222
	for <xenomai@xenomai.org>; Wed, 11 Nov 2026 12:10:50 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=nAzKXfN9;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20261111121049a94ce360fb000207bb-T4ISZc@rts-flowmailer.siemens.com designates 185.136.65.225 as permitted sender) smtp.mailfrom=fm-294854-20261111121049a94ce360fb000207bb-T4ISZc@rts-flowmailer.siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20261111121049a94ce360fb000207bb
        for <xenomai@xenomai.org>;
        Wed, 11 Nov 2026 13:10:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=MtcBwRpoJQ409IByhD8u73fFUGNrDF9LECd4trN/vlY=;
 b=nAzKXfN9YYbzG737UORZF2OZFGncCsIlZFuuH53GHx29pj3MS/SajspcJlv+rUjVYYhKD/
 MlB6SicYgs8rvcwzX6UFpCApK07ip9HRg661oz9fhKvtmsSdRnuQwoo1Al6DOpbk5N2nURgB
 4KtmdUEB2J2BXXX3FLYHdFRhPYhCT5OV0ZI6dqil+ZR8CaIjKmlW1Xhu5KbMMrVXhqshnaw4
 jPMqmLS67Tu1mngEFi4IAg/O5+kxv29zdn9Qwmhupy9ixwjp7PD2mj9kc9c3fiPL2BQMPH2D
 eC8NYYjgsmg2XRe3+XvX3FOuBvXVW7MjPkVYOVsruaxdMMlenWTvAqmA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	xenomai@xenomai.org
Subject: [dovetail][PATCH v2 1/4] dovetail: Track the owner of a trap notification by exception frame
Date: Wed, 11 Nov 2026 13:10:44 +0100
Message-ID: <d40c9a22e1e450a83533ef7d781f88010c2aacc6.1794399047.git.jan.kiszka@siemens.com>
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
X-GND-Cause: dmFkZTGVONs7jqIhW0VdlqRSqfb7y0Kvn7XVihjBeBze4/kEiFBhyS34TbN0PtjLLY+JTjoybjgoJDK90bIpPnEnl+xbkr9bDZ6ozwDiOe5rgewHfTCybAwwjt3AL3eR63R9Rx0EtzVJ3ffr3IW8LIuuNfo6PXD4sBC7WwC4e68UCWr2wzR6/PU86gUUzQbJKTCxGfz1qTkBtrdVKcLMmnEOH/ULfrf2hxldcIPTfGXFRecreEodcLAxMiStU26SOR/aklyQUpK1K61zewNC9AEDtlXL1tKGYKB4bhYKs4IhsLLtNzet1fkb322Ws54vm/pr2Wx4gg8XMBY+8gfeq7ecmllOQxnZvsqDT/6EpL49E3lV9A5gh0NOw4dK7Ir2u+UvcOn5/FECwzecna7rKUUo3EsasKINGPSINtkaVYm1Vd+ExYSjSRB0YWUEr3/OyP+7ooQ7/0Q8mQZLxHofKPgP1p852uz51QG8aHt4FDZDkkBcHsspq0w2vFa6fKy6jclBDlsUh8ktNG4KqcO6mrAisZrD7IVkINV9UY/mQ9pTa9TfQGhQZXX62mG7ycwJMluHh4gC80f8lRDWHfFNHPbpabUXUsjcLhwOLC5Zqs4UvTGFWecPfUGge4JxiAG+GzSNXc4K7fSo5BllqqqUTu/TeUTDHe0C/OfjfpOc1/RpE3VdgQ
X-GND-State: clean
X-GND-Score: -100

From: Jan Kiszka <jan.kiszka@siemens.com>

Trap notifications are guarded by _TLF_OOBTRAP: oob_trap_notify() only
calls into the companion core if the flag is clear, and sets it;
oob_trap_unwind() calls the exit handler and clears the flag whenever
it is set.

This does not cope with nested traps. A trap handler running on behalf
of an oob thread may trigger another trap before it reaches its own
exit annotation, e.g. a user access from an emulation handler faulting
in a not yet resident page on ARM:

  do_alignment()                      <- notify, _TLF_OOBTRAP set
    do_alignment_ldmstm()
      ldrt/strt to user address       <- translation fault (SVC mode)
        do_DataAbort()
          do_page_fault()
            dovetail_fault_entry()    <- notify suppressed, fine
            handle_mm_fault()
            dovetail_fault_exit()     <- unwind fires: wrong trap number,
                                         wrong frame, and the core may
                                         switch us back to oob
    ...emulation continues oob...
  dovetail_fault_exit()               <- no-op, flag already clear

Since _TLF_OOBTRAP is per-thread and the thread does not change across
nesting levels, the flag alone cannot tell which trap occurrence owns
the notification. The exception frame can: every nesting level pushes
its own pt_regs on the kernel stack, and the frame is already passed
to both the notify and unwind helpers.

Record the owning frame in the task struct when notifying, and only
unwind when the frame passed to oob_trap_unwind() matches. Inner trap
exits become no-ops, the outer exit unwinds with the trap number and
frame the core was notified with. oob_trap_regs can in fact encode the
semantic of the _TLF_OOBTRAP flag, thus drop it.

A forking parent can never be inside a trap handler, so neither the
flag nor the owner frame can legitimately be set when a new task
inherits its state. Add a debug assertion for this in
inband_task_init(), which turns an unbalanced trap entry into a
loud warning on the next fork instead of silently propagating the
stuck state to the children.

Assisted-by: opencode:Fable-5.1
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/include/asm/thread_info.h   |  1 -
 arch/arm64/include/asm/thread_info.h |  1 -
 arch/riscv/include/asm/thread_info.h |  1 -
 arch/x86/include/asm/thread_info.h   |  2 --
 include/linux/dovetail.h             | 12 ++++++++++--
 include/linux/sched.h                |  5 +++++
 kernel/dovetail.c                    | 10 ++++++++--
 7 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 23cae59037c1e..12ab7e49b7b76 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -196,7 +196,6 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
 #define _TLF_OOB		0x0001
 #define _TLF_DOVETAIL		0x0002
 #define _TLF_OFFSTAGE		0x0004
-#define _TLF_OOBTRAP		0x0008
 
 #endif /* __KERNEL__ */
 #endif /* __ASM_ARM_THREAD_INFO_H */
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 48563d782a99a..934b080246146 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -144,7 +144,6 @@ void arch_setup_new_exec(void);
 #define _TLF_OOB			0x0001
 #define _TLF_DOVETAIL			0x0002
 #define _TLF_OFFSTAGE			0x0004
-#define _TLF_OOBTRAP			0x0008
 #define _TLF_KERNEL_FPU_PREEMPTED	0x0010	/* Dovetail: kernel mode FPSIMD section preempted by OOB */
 
 #endif /* __ASM_THREAD_INFO_H */
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 820a596d9bf65..11164e12317fa 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -140,6 +140,5 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #define _TLF_OOB		0x0001
 #define _TLF_DOVETAIL		0x0002
 #define _TLF_OFFSTAGE		0x0004
-#define _TLF_OOBTRAP		0x0008
 
 #endif /* _ASM_RISCV_THREAD_INFO_H */
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 6da425bc87712..0c9cdf60e3f12 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -218,13 +218,11 @@ static inline int arch_within_stack_frames(const void * const stack,
 #define TS_OOB			0x0010	/* Thread is running out-of-band */
 #define TS_DOVETAIL		0x0020  /* Dovetail notifier enabled */
 #define TS_OFFSTAGE		0x0040	/* Thread is in-flight to OOB context */
-#define TS_OOBTRAP		0x0080	/* Handling a trap from OOB context */
 #define TS_KERNEL_FPU_PREEMPTED	0x0100	/* Dovetail: kernel mode FPU section preempted by OOB */
 
 #define _TLF_OOB			TS_OOB
 #define _TLF_DOVETAIL			TS_DOVETAIL
 #define _TLF_OFFSTAGE			TS_OFFSTAGE
-#define _TLF_OOBTRAP			TS_OOBTRAP
 #define _TLF_KERNEL_FPU_PREEMPTED	TS_KERNEL_FPU_PREEMPTED
 
 #ifndef __ASSEMBLER__
diff --git a/include/linux/dovetail.h b/include/linux/dovetail.h
index 1140c5b7c99f3..645d1eec32aa6 100644
--- a/include/linux/dovetail.h
+++ b/include/linux/dovetail.h
@@ -62,10 +62,18 @@ int pipeline_syscall(unsigned int nr, struct pt_regs *regs);
 void __oob_trap_notify(unsigned int exception,
 		       struct pt_regs *regs);
 
+/*
+ * Trap notifications do not nest: a trap handler running on behalf
+ * of an oob thread may itself trigger a fault (e.g. a user access
+ * from an emulation handler), landing into another annotated trap
+ * handler. Only the outermost trap occurrence notifies the companion
+ * core, which is told about the exit when that same occurrence
+ * unwinds.
+ */
 static __always_inline void oob_trap_notify(unsigned int exception,
 					struct pt_regs *regs)
 {
-	if (running_oob() && !test_thread_local_flags(_TLF_OOBTRAP))
+	if (running_oob() && !current->oob_trap_regs)
 		__oob_trap_notify(exception, regs);
 }
 
@@ -75,7 +83,7 @@ void __oob_trap_unwind(unsigned int exception,
 static __always_inline void oob_trap_unwind(unsigned int exception,
 					struct pt_regs *regs)
 {
-	if (test_thread_local_flags(_TLF_OOBTRAP))
+	if (current->oob_trap_regs == regs)
 		__oob_trap_unwind(exception, regs);
 }
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c4291b7f7b6ea..3012926e8e355 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -74,6 +74,7 @@ struct perf_event_context;
 struct perf_ctx_data;
 struct pid_namespace;
 struct pipe_inode_info;
+struct pt_regs;
 struct rcu_node;
 struct reclaim_state;
 struct root_domain;
@@ -1302,6 +1303,10 @@ struct task_struct {
 #ifdef CONFIG_IRQ_PIPELINE
 	unsigned long			stall_bits;
 #endif
+#ifdef CONFIG_DOVETAIL
+	/* Exception frame owning the pending oob trap notification. */
+	struct pt_regs			*oob_trap_regs;
+#endif
 
 #ifdef CONFIG_LOCKDEP
 # define MAX_LOCK_DEPTH			48UL
diff --git a/kernel/dovetail.c b/kernel/dovetail.c
index 16ac66e4529f5..f196a9815dabd 100644
--- a/kernel/dovetail.c
+++ b/kernel/dovetail.c
@@ -22,6 +22,12 @@ void inband_task_init(struct task_struct *p)
 {
 	struct thread_info *ti = task_thread_info(p);
 
+	/*
+	 * A forking parent cannot be inside a trap handler. If oob_trap_regs
+	 * is non-NULL, some trap entry was not balanced by a matching exit.
+	 */
+	WARN_ON_ONCE(dovetail_debug() && p->oob_trap_regs);
+
 	clear_ti_local_flags(ti, _TLF_DOVETAIL|_TLF_OOB|_TLF_OFFSTAGE);
 	arch_inband_task_init(p);
 }
@@ -284,7 +290,7 @@ noinstr void __oob_trap_notify(unsigned int exception,
 	 * to the in-band stage, may return with hard irqs on.
 	 */
 	if (dovetail_enabled) {
-		set_thread_local_flags(_TLF_OOBTRAP);
+		current->oob_trap_regs = regs;
 		flags = hard_local_irq_save();
 		instrumentation_begin();
 		handle_oob_trap_entry(exception, regs);
@@ -306,7 +312,7 @@ noinstr void __oob_trap_unwind(unsigned int exception, struct pt_regs *regs)
 	 * stage. Must return with hard irqs off.
 	 */
 	hard_local_irq_disable();
-	clear_thread_local_flags(_TLF_OOBTRAP);
+	current->oob_trap_regs = NULL;
 	instrumentation_begin();
 	handle_oob_trap_exit(exception, regs);
 	instrumentation_end();
-- 
2.47.3

