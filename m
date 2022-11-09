Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413BA8F53
	for <xenomai@lists.linux.dev>; Wed,  9 Nov 2022 10:22:35 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id DF4C624000C;
	Wed,  9 Nov 2022 10:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1667989348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YdaVTMZxwB94p0CTMbqSwKqB+vfGjmHxCsHHUcvJkuw=;
	b=IP7UYA1pkCUDv4sxW4OhfTSxbCutswCx624QG2wdi7q98hEN9e02lxWDFYIVbA96qEK2lD
	boBTBeR0J1lXKD47U+LvLZDRDbQT5fkfIgF2f5vSv4k7EKPHv5GP+AngRde+T3FUCT1F/0
	7PgB+/V9taeyHEZ6vpb8NcrMw8T9hHgU2rwKfrugBnFLiS3Mv6J8tyENx3ONk1YmmxKpXG
	7Rywic4sqGRT4nCR+NS8Lwy88pzcZtQ07EJs9sWSBFPS/dnBF/Y6U0SFPgqqCC7qcKZqHc
	T+Z54wF2fBf70jLjPMuWEDv7kRcceuYsJy29IOsYNXMrkkLr3XwBh7g2wt+9iw==
References: <006148b8-dfa1-1abb-b243-029db08ceb0a@siemens.com>
 <8929fce3-cbe6-79cf-d0a9-5e8399e3dec4@siemens.com>
 <VE1PR08MB4909620AE0E4EE0139B54276923E9@VE1PR08MB4909.eurprd08.prod.outlook.com>
 <f275bac0-492e-c8da-ea30-a48ebae505c4@siemens.com>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>, Xenomai
 <xenomai@lists.linux.dev>, Richard Weinberger <richard@nod.at>
Subject: Re: [RFC][PATCH] x86: dovetail: Permit to declare a trap handled
Date: Wed, 09 Nov 2022 11:06:59 +0100
In-reply-to: <f275bac0-492e-c8da-ea30-a48ebae505c4@siemens.com>
Message-ID: <87iljoh1gd.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 09.11.22 08:31, Johannes Kirchmair wrote:
>> Hello all,
>> 
>> I just recently found the time to test this patch in the context of our rt_signals.
>> As a matter of fact it works quite well for us.
>> 
>> So is there any intent/possibility to bring this upstream?
>> 
>> I also did some similar changes for arm64. As we also use imx8 boards.
>> If there is interest in those, I could post them.
>
> Yes, please share. Then we can continue with proposing it for the latest
> dovetail port (6.1 now).
>

There is a slightly different approach which expresses the intent of
that notification hook Dovetail-wise:

- if the real-time core switches in-band upon notification, then the
  in-band kernel code may assume that all regular fixups need to be
  applied next. This is the common case for most traps.

- if the real-time core stays on the out-of-band stage upon
  notification, then the in-band kernel code should assume that all
  required fixups were done from that stage already, returning asap from
  the outer trap handler.

This gives the same flexibility than by expecting the hook to return a
continuation status, but makes sure that regular fixups cannot be
bypassed when/if switching to in-band mode is required to handle the
trap. Rationale: the regular in-band trap handlers know better about the
way to deal with those events from in-band context.

e.g.

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index aed5828f784dc..beae6fbf11541 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -161,10 +161,16 @@ static void show_signal(struct task_struct *tsk, int signr,
 }
 
 static __always_inline
-void mark_trap_entry(int trapnr, struct pt_regs *regs)
+bool mark_trap_entry(int trapnr, struct pt_regs *regs)
 {
 	oob_trap_notify(trapnr, regs);
-	hard_cond_local_irq_enable();
+
+	if (likely(running_inband())) {
+		hard_cond_local_irq_enable();
+		return true;
+	}
+
+	return false;
 }
 
 static __always_inline
@@ -175,9 +181,10 @@ void mark_trap_exit(int trapnr, struct pt_regs *regs)
 }
 
 static __always_inline
-void mark_trap_entry_raw(int trapnr, struct pt_regs *regs)
+bool mark_trap_entry_raw(int trapnr, struct pt_regs *regs)
 {
 	oob_trap_notify(trapnr, regs);
+	return running_inband();
 }
 
 static __always_inline
@@ -209,7 +216,8 @@ static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 
-	mark_trap_entry(trapnr, regs);
+	if (!mark_trap_entry(trapnr, regs))
+		return;
 
 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
 			NOTIFY_STOP) {
@@ -289,7 +297,8 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
 {
 	irqentry_state_t state;
 
-	mark_trap_entry_raw(X86_TRAP_UD, regs);
+	if (!mark_trap_entry_raw(X86_TRAP_UD, regs))
+		return;
 
 	/*
 	 * We use UD2 as a short encoding for 'CALL __WARN', as such
@@ -336,7 +345,8 @@ DEFINE_IDTENTRY_ERRORCODE(exc_alignment_check)
 {
 	char *str = "alignment check";
 
-	mark_trap_entry(X86_TRAP_AC, regs);
+	if (!mark_trap_entry(X86_TRAP_AC, regs))
+		return;
 
 	if (notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_AC, SIGBUS) == NOTIFY_STOP)
 		goto mark_exit;
@@ -520,7 +530,8 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 
 DEFINE_IDTENTRY(exc_bounds)
 {
-	mark_trap_entry(X86_TRAP_BR, regs);
+	if (!mark_trap_entry(X86_TRAP_BR, regs))
+		return;
 
 	if (notify_die(DIE_TRAP, "bounds", regs, 0,
 			X86_TRAP_BR, SIGSEGV) == NOTIFY_STOP)
@@ -641,13 +652,15 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		if (fixup_iopl_exception(regs))
 			goto exit;
 
-		mark_trap_entry(X86_TRAP_GP, regs);
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_nr = X86_TRAP_GP;
 
 		if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
 			goto exit;
 
+		if (!mark_trap_entry(X86_TRAP_GP, regs))
+			goto exit;
+
 		show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
 		force_sig(SIGSEGV);
 		goto mark_exit;
@@ -668,7 +681,8 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	    kprobe_fault_handler(regs, X86_TRAP_GP))
 		goto exit;
 
-	mark_trap_entry(X86_TRAP_GP, regs);
+	if (!mark_trap_entry(X86_TRAP_GP, regs))
+		goto exit;
 
 	ret = notify_die(DIE_GPF, desc, regs, error_code, X86_TRAP_GP, SIGSEGV);
 	if (ret == NOTIFY_STOP)
@@ -740,7 +754,8 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 	if (poke_int3_handler(regs))
 		return;
 
-	mark_trap_entry_raw(X86_TRAP_BP, regs);
+	if (!mark_trap_entry_raw(X86_TRAP_BP, regs))
+		return;
 
 	/*
 	 * irqentry_enter_from_user_mode() uses static_branch_{,un}likely()
@@ -1089,17 +1104,19 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 /* IST stack entry */
 DEFINE_IDTENTRY_DEBUG(exc_debug)
 {
-	mark_trap_entry_raw(X86_TRAP_DB, regs);
-	exc_debug_kernel(regs, debug_read_clear_dr6());
-	mark_trap_exit_raw(X86_TRAP_DB, regs);
+	if (mark_trap_entry_raw(X86_TRAP_DB, regs)) {
+		exc_debug_kernel(regs, debug_read_clear_dr6());
+		mark_trap_exit_raw(X86_TRAP_DB, regs);
+	}
 }
 
 /* User entry, runs on regular task stack */
 DEFINE_IDTENTRY_DEBUG_USER(exc_debug)
 {
-	mark_trap_entry_raw(X86_TRAP_DB, regs);
-	exc_debug_user(regs, debug_read_clear_dr6());
-	mark_trap_exit_raw(X86_TRAP_DB, regs);
+	if (mark_trap_entry_raw(X86_TRAP_DB, regs)) {
+		exc_debug_user(regs, debug_read_clear_dr6());
+		mark_trap_exit_raw(X86_TRAP_DB, regs);
+	}
 }
 #else
 /* 32 bit does not have separate entry points. */
@@ -1133,7 +1150,9 @@ static void math_error(struct pt_regs *regs, int trapnr)
 		if (fixup_exception(regs, trapnr, 0, 0))
 			goto exit;
 
-		mark_trap_entry(trapnr, regs);
+		if (!mark_trap_entry(trapnr, regs))
+			goto exit;
+
 		task->thread.error_code = 0;
 		task->thread.trap_nr = trapnr;
 
@@ -1160,7 +1179,8 @@ static void math_error(struct pt_regs *regs, int trapnr)
 	if (fixup_vdso_exception(regs, trapnr, 0, 0))
 		goto exit;
 
-	mark_trap_entry(trapnr, regs);
+	if (!mark_trap_entry(trapnr, regs))
+		goto exit;
 
 	force_sig_fault(SIGFPE, si_code,
 			(void __user *)uprobe_get_trap_addr(regs));
@@ -1238,9 +1258,10 @@ DEFINE_IDTENTRY(exc_device_not_available)
 		 * to kill the task than getting stuck in a never-ending
 		 * loop of #NM faults.
 		 */
-		mark_trap_entry(X86_TRAP_NM, regs);
-		die("unexpected #NM exception", regs, 0);
-		mark_trap_exit(X86_TRAP_NM, regs);
+		if (mark_trap_entry(X86_TRAP_NM, regs)) {
+			die("unexpected #NM exception", regs, 0);
+			mark_trap_exit(X86_TRAP_NM, regs);
+		}
 	}
 }
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 75df0fa390cf9..3d5bcac24163b 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -891,6 +891,10 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		return;
 
 	oob_trap_notify(X86_TRAP_PF, regs);
+	if (!running_inband()) {
+		local_irq_disable_full();
+		return;
+	}
 
 	if (likely(show_unhandled_signals))
 		show_signal_msg(regs, error_code, address, tsk);
@@ -1361,9 +1365,12 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * At this point, we would have to stop running
 	 * out-of-band. Tell the companion core about the page fault
 	 * event, so that it might switch current to in-band mode if
-	 * need be.
+	 * need be. If it does not, then we may assume that it would
+	 * also handle the fixups.
 	 */
 	oob_trap_notify(X86_TRAP_PF, regs);
+	if (!running_inband())
+		return;
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
-- 
Philippe.
