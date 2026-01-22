Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7319B33CE8C
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111833; cv=none; b=GQ4916bt0DhScPv/vOPMI19K7EbZkZDiqZX5wPRt8gJ0sfGoZbAEjlOSnmMzM5d7CQihdFRHS7s26pFKYxZ+ueWVspSo9wb1Kh3LJaO8olLoXbjh/ksdERu5JmUEsMOhUKQgYFuM4obEKPvkzS9qtHN+0ADYTSSE9D3cuTRc1Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111833; c=relaxed/simple;
	bh=xhkmCZW7gVSo7Wai8PLuSoI9Ys0zNknmQY9w5/AVSsE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jG8vxxQwvbJycl7BG4KArgKjglv+le23G7568YvYijxppruIIZZTnVPelUqgcDIVPMVwN5ygtAXYFCEzp1Ai7R2p7VU1KlI6R8BWGcsZRBpsTiGbyk0l0PROfhWvYNRNN3Bnj734F9y/wT1LwxHRJ7jKeffvQU5T3dsYot1yA/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Kg8ATAAk; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Kg8ATAAk"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 70236442FF;
	Thu, 22 Jan 2026 19:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1769111829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YZfzKgnj3gHXfAgDfAXwWfGx7h0pWVwcnIZz799iI0o=;
	b=Kg8ATAAkeKT0P5M6dcsFJYImMYYsvZB14pnE/1GZwL8SM3xu1mEKn7jkLIeN1/rNk7SwqL
	cX2zJIWiUrZTJIWBcxsVzyeY8wt8yoU4C/jfkSD9FP6VeqLGB4iToAtL2YjbeEYxgMS4Qz
	3obfwNohoxOr3I50010TKP5aOovURS45puhJWFdFq0k0poOEWE5lcpqfZ58pQkPhwUSEXT
	yqkzffPRPosawuDHORK5tqHv6uDlZmOh0R13jB4Ibo5EhhUV9AOG0R4ulke67rOp63ShLg
	HuXZpd40qkIlMXw2RULMgbFiE2gPYznpQLOSkVD7zj9mq8YNksbxUQsZPyLJBQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH dovetail v4 11/12] riscv: add out-of-band aware trap
 handling
In-Reply-To: <20260122102304.421957-12-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Thu, 22 Jan 2026 11:23:03 +0100")
References: <20260122102304.421957-1-tobias.schaffner@siemens.com>
	<20260122102304.421957-12-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 22 Jan 2026 20:57:09 +0100
Message-ID: <874iodifoq.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejtdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepjedtvdefieeggedvhffhpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepthhosghirghsrdhstghhrghffhhnvghrsehsihgvmhgvnhhsrdgtohhm
X-GND-State: clean


"riscv: dovetail: add core support" as well.

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Introduce trap handling hooks for the Dovetail co-kernel, integrating
> out-of-band (OOB) notification and unwind support.
>
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  arch/riscv/kernel/traps.c | 110 ++++++++++++++++++++++++++++++++------
>  arch/riscv/mm/fault.c     |  21 +++++---
>  2 files changed, 108 insertions(+), 23 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index d0400086a075..51e1407ee066 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -3,6 +3,8 @@
>   * Copyright (C) 2012 Regents of the University of California
>   */
>  
> +#include <asm-generic/signal.h>
> +#include <linux/compiler_attributes.h>
>  #include <linux/cpu.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> @@ -115,6 +117,8 @@ void die(struct pt_regs *regs, const char *str)
>  static __always_inline
>  bool mark_trap_entry(int signo, struct pt_regs *regs)
>  {
> +	oob_trap_notify(signo, regs);
> +
>  	/*
>  	 * Dovetail: irqentry_enter*() already synchronized the
>  	 * virtual and real interrupt states for us. If running
> @@ -126,21 +130,40 @@ bool mark_trap_entry(int signo, struct pt_regs *regs)
>  		return true;
>  	}
>  
> +	oob_trap_unwind(signo, regs);
> +
>  	return false;
>  }
>  
>  static __always_inline
>  void mark_trap_exit(int signo, struct pt_regs *regs)
>  {
> +	oob_trap_unwind(signo, regs);
>  	hard_cond_local_irq_disable();
>  }
>  
> -void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
> +static __always_inline
> +bool mark_trap_entry_raw(int trapnr, struct pt_regs *regs)
>  {
> -	struct task_struct *tsk = current;
> +	oob_trap_notify(trapnr, regs);
>  
> -	if (!mark_trap_entry(signo, regs))
> -		return;
> +	if (running_oob()) {
> +		oob_trap_unwind(trapnr, regs);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static __always_inline
> +void mark_trap_exit_raw(int trapnr, struct pt_regs *regs)
> +{
> +	oob_trap_unwind(trapnr, regs);
> +}
> +
> +static void do_trap_raw(struct pt_regs *regs, int signo, int code, unsigned long addr)
> +{
> +	struct task_struct *tsk = current;
>  
>  	if (show_unhandled_signals && unhandled_signal(tsk, signo)
>  	    && printk_ratelimit()) {
> @@ -153,6 +176,14 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
>  	}
>  
>  	force_sig_fault(signo, code, (void __user *)addr);
> +}
> +
> +void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
> +{
> +	if(!mark_trap_entry(signo, regs))
> +		return;
> +
> +	do_trap_raw(regs, signo, code, addr);
>  
>  	mark_trap_exit(signo, regs);
>  }
> @@ -163,7 +194,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
>  	current->thread.bad_cause = regs->cause;
>  
>  	if (user_mode(regs)) {
> -		do_trap(regs, signo, code, addr);
> +		do_trap_raw(regs, signo, code, addr);
>  	} else {
>  		/*
>  		 * Dovetail: If we trapped from kernel space, either
> @@ -181,9 +212,12 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
>  #else
>  #define __trap_section noinstr
>  #endif
> -#define DO_ERROR_INFO(name, signo, code, str)					\
> +#define DO_ERROR_INFO(name, signo, code, str, trapnr)				\
>  asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
>  {										\
> +	if(!mark_trap_entry(trapnr, regs))					\
> +		return;								\
> +										\
>  	if (user_mode(regs)) {							\
>  		irqentry_enter_from_user_mode(regs);				\
>  		local_irq_enable();						\
> @@ -195,19 +229,24 @@ asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
>  		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
>  		irqentry_nmi_exit(regs, state);					\
>  	}									\
> +										\
> +	mark_trap_exit(trapnr, regs);						\
>  }
>  
>  DO_ERROR_INFO(do_trap_unknown,
> -	SIGILL, ILL_ILLTRP, "unknown exception");
> +	SIGILL, ILL_ILLTRP, "unknown exception", EXC_INST_ILLEGAL);
>  DO_ERROR_INFO(do_trap_insn_misaligned,
> -	SIGBUS, BUS_ADRALN, "instruction address misaligned");
> +	SIGBUS, BUS_ADRALN, "instruction address misaligned", EXC_INST_MISALIGNED);
>  DO_ERROR_INFO(do_trap_insn_fault,
> -	SIGSEGV, SEGV_ACCERR, "instruction access fault");
> +	SIGSEGV, SEGV_ACCERR, "instruction access fault", EXC_INST_ACCESS);
>  
>  asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *regs)
>  {
>  	bool handled;
>  
> +	if(!mark_trap_entry(EXC_INST_ILLEGAL, regs))
> +		return;
> +
>  	if (user_mode(regs)) {
>  		irqentry_enter_from_user_mode(regs);
>  
> @@ -237,10 +276,11 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
>  
>  		irqentry_nmi_exit(regs, state);
>  	}
> +	mark_trap_exit(EXC_INST_ILLEGAL, regs);
>  }
>  
>  DO_ERROR_INFO(do_trap_load_fault,
> -	SIGSEGV, SEGV_ACCERR, "load access fault");
> +	SIGSEGV, SEGV_ACCERR, "load access fault", EXC_LOAD_ACCESS);
>  
>  enum misaligned_access_type {
>  	MISALIGNED_STORE,
> @@ -264,6 +304,9 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
>  {
>  	irqentry_state_t state;
>  
> +	if(!mark_trap_entry(EXC_LOAD_MISALIGNED, regs))
> +		return;
> +
>  	if (user_mode(regs)) {
>  		irqentry_enter_from_user_mode(regs);
>  		local_irq_enable();
> @@ -281,6 +324,8 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
>  	} else {
>  		irqentry_nmi_exit(regs, state);
>  	}
> +
> +	mark_trap_exit(EXC_LOAD_MISALIGNED, regs);
>  }
>  
>  asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
> @@ -290,15 +335,36 @@ asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs
>  
>  asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
>  {
> -	do_trap_misaligned(regs, MISALIGNED_STORE);
> +	if(!mark_trap_entry(EXC_STORE_MISALIGNED, regs))
> +		return;
> +
> +	if (user_mode(regs)) {
> +		irqentry_enter_from_user_mode(regs);
> +
> +		if (handle_misaligned_store(regs))
> +			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
> +				"Oops - store (or AMO) address misaligned");
> +
> +		irqentry_exit_to_user_mode(regs);
> +	} else {
> +		irqentry_state_t state = irqentry_nmi_enter(regs);
> +
> +		if (handle_misaligned_store(regs))
> +			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
> +				"Oops - store (or AMO) address misaligned");
> +
> +		irqentry_nmi_exit(regs, state);
> +	}
> +
> +	mark_trap_exit(EXC_STORE_MISALIGNED, regs);
>  }
>  
>  DO_ERROR_INFO(do_trap_store_fault,
> -	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault");
> +	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault", EXC_STORE_ACCESS);
>  DO_ERROR_INFO(do_trap_ecall_s,
> -	SIGILL, ILL_ILLTRP, "environment call from S-mode");
> +	SIGILL, ILL_ILLTRP, "environment call from S-mode", EXC_SYSCALL);
>  DO_ERROR_INFO(do_trap_ecall_m,
> -	SIGILL, ILL_ILLTRP, "environment call from M-mode");
> +	SIGILL, ILL_ILLTRP, "environment call from M-mode", EXC_SUPERVISOR_SYSCALL);
>  
>  static inline unsigned long get_break_insn_length(unsigned long pc)
>  {
> @@ -350,6 +416,9 @@ void handle_break(struct pt_regs *regs)
>  
>  asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>  {
> +	if(!mark_trap_entry_raw(EXC_BREAKPOINT, regs))
> +		return;
> +
>  	if (user_mode(regs)) {
>  		irqentry_enter_from_user_mode(regs);
>  		local_irq_enable();
> @@ -365,6 +434,8 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>  
>  		irqentry_nmi_exit(regs, state);
>  	}
> +
> +	mark_trap_exit_raw(EXC_BREAKPOINT, regs);
>  }
>  
>  asmlinkage __visible __trap_section  __no_stack_protector
> @@ -381,6 +452,15 @@ void do_trap_ecall_u(struct pt_regs *regs)
>  
>  		syscall = syscall_enter_from_user_mode(regs, syscall);
>  
> +		if(dovetailing()) {
> +			if (syscall == EXIT_SYSCALL_OOB) {
> +				hard_local_irq_disable();
> +				return;
> +			}
> +			if (syscall == EXIT_SYSCALL_TAIL)
> +				goto done_inband;
> +		}
> +
>  		add_random_kstack_offset();
>  
>  		if (syscall >= 0 && syscall < NR_syscalls)
> @@ -398,6 +478,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
>  		 */
>  		choose_random_kstack_offset(get_random_u16());
>  
> +done_inband:
>  		syscall_exit_to_user_mode(regs);
>  	} else {
>  		irqentry_state_t state = irqentry_nmi_enter(regs);
> @@ -407,7 +488,6 @@ void do_trap_ecall_u(struct pt_regs *regs)
>  
>  		irqentry_nmi_exit(regs, state);
>  	}
> -
>  }
>  
>  #ifdef CONFIG_MMU
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index d64d01874a79..42450c47ee12 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -385,6 +385,10 @@ void handle_page_fault(struct pt_regs *regs)
>  		die_kernel_fault("access to user memory without uaccess routines", addr, regs);
>  	}
>  
> +	oob_trap_notify(EXC_INST_PAGE_FAULT, regs);
> +	if (!running_inband())
> +		goto out;
> +
>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
>  
>  	if (cause == EXC_STORE_PAGE_FAULT)
> @@ -403,7 +407,7 @@ void handle_page_fault(struct pt_regs *regs)
>  		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
>  		tsk->thread.bad_cause = cause;
>  		bad_area_nosemaphore(regs, SEGV_ACCERR, addr);
> -		return;
> +		goto out;
>  	}
>  
>  	fault = handle_mm_fault(vma, addr, flags | FAULT_FLAG_VMA_LOCK, regs);
> @@ -421,7 +425,7 @@ void handle_page_fault(struct pt_regs *regs)
>  	if (fault_signal_pending(fault, regs)) {
>  		if (!user_mode(regs))
>  			no_context(regs, addr);
> -		return;
> +		goto out;
>  	}
>  lock_mmap:
>  
> @@ -430,7 +434,7 @@ void handle_page_fault(struct pt_regs *regs)
>  	if (unlikely(!vma)) {
>  		tsk->thread.bad_cause = cause;
>  		bad_area_nosemaphore(regs, code, addr);
> -		return;
> +		goto out;
>  	}
>  
>  	/*
> @@ -442,7 +446,7 @@ void handle_page_fault(struct pt_regs *regs)
>  	if (unlikely(access_error(cause, vma))) {
>  		tsk->thread.bad_cause = cause;
>  		bad_area(regs, mm, code, addr);
> -		return;
> +		goto out;
>  	}
>  
>  	/*
> @@ -460,12 +464,12 @@ void handle_page_fault(struct pt_regs *regs)
>  	if (fault_signal_pending(fault, regs)) {
>  		if (!user_mode(regs))
>  			no_context(regs, addr);
> -		return;
> +		goto out;
>  	}
>  
>  	/* The fault is fully completed (including releasing mmap lock) */
>  	if (fault & VM_FAULT_COMPLETED)
> -		return;
> +		goto out;
>  
>  	if (unlikely(fault & VM_FAULT_RETRY)) {
>  		flags |= FAULT_FLAG_TRIED;
> @@ -484,7 +488,8 @@ void handle_page_fault(struct pt_regs *regs)
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
>  		tsk->thread.bad_cause = cause;
>  		mm_fault_error(regs, addr, fault);
> -		return;
>  	}
> -	return;
> +
> +out:
> +	oob_trap_unwind(EXC_INST_PAGE_FAULT, regs);
>  }

-- 
Philippe.
