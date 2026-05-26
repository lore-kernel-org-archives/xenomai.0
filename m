Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F09F3DFC75
	for <xenomai@lists.linux.dev>; Tue, 26 May 2026 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801441; cv=none; b=rgbv3noEkDySKITcw3kguICy9kHRCqhVAubcN1OsPxu3VfYuoUfHFSE/LYoXn/OW+tSEsWgvqXKM+CUuPxYhHHiobiH4rsDrUzZh4oIZFvt+YMhONapbWkhdYRHF6fLTLVp8dJMQRZtArpUkXxRX2/W/K2PkXjxoKnPDljyRrb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801441; c=relaxed/simple;
	bh=U0udLhh0z+gRMVoXdF+pK7gUSWKDHF8TZXcx7pDWGrE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sJnC+imchtMS/7zva9Tz5TCEilMt6V84sOMTgsSmLG2PsMWm/1iVYqDj1FnuN8FIZmWJlMRxASsUA6onj+STtLtRDxPQIqfHqgTY8JxcTmKF6tuHDmpDgmTS9BtAeE+CBChGFywgoV87T7878juoKwCdP8FhCVUDfM2qdeNJjzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=lCAm8qbv; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="lCAm8qbv"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026052613171281a322a582000207eb
        for <xenomai@lists.linux.dev>;
        Tue, 26 May 2026 15:17:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=JrzCT8HVtnDH6ANN45Mht+lw6CJ6MOPXEKt4f2SauPA=;
 b=lCAm8qbvo4uEgJlRO7klioWlS9jOgUTBSjSQNBbjE7ql3AJ/0p/o52TBaZHRhyaISUIFKe
 03TUioLq2lKqd0nM+yOt7M8dN18ZEqiPCazXdG83Yj5WGoHNuL4pzpY37k/x1Hu27V1Sifuy
 Kx54ZKKOzwG1hWNIwiPb2omZuTM9k4R3AzPTlz3GQF/AxL6kSTLQaBTwjPFKJ9XWsJdLwVFq
 2AluGpR6DVBL1D0B4RwmglU9OsznYXMd7eUh6tCFuhAiSwoMxZuzFyLvM2jQKzfasZvZGv9C
 a8qI1F4WJ4PLq0eQZlT4n26aw0z3Bl0Gir4/Xe3ccy5KdoOi3a0OGWnw==;
Message-ID: <276ef31e467ac0a0ffb0db5c5f860cab6714cbbc.camel@siemens.com>
Subject: Re: [PATCH dovetail v7 11/11] riscv: dovetail: add core support
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
Date: Tue, 26 May 2026 15:17:12 +0200
In-Reply-To: <20260430111101.1539377-12-tobias.schaffner@siemens.com>
References: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
	 <20260430111101.1539377-12-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Thu, 2026-04-30 at 13:11 +0200, Tobias Schaffner wrote:
> Add Dovetail co-kernel support for RISC-V, including, irq pipeline
> integration, out-of-band aware trap handling and memory management.
>=20
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  arch/riscv/Kconfig                   |   2 +
>  arch/riscv/include/asm/dovetail.h    |  23 ++++++
>  arch/riscv/include/asm/mmu_context.h |   2 +
>  arch/riscv/include/asm/syscall.h     |   6 ++
>  arch/riscv/include/asm/thread_info.h |   8 +++
>  arch/riscv/kernel/traps.c            | 102 ++++++++++++++++++++++-----
>  arch/riscv/mm/context.c              |  20 +++++-
>  arch/riscv/mm/fault.c                |  28 +++++---
>  8 files changed, 162 insertions(+), 29 deletions(-)
>  create mode 100644 arch/riscv/include/asm/dovetail.h
>=20

[snip]

> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index b37bb5da87c5c..1f7d471457892 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -115,26 +115,47 @@ void die(struct pt_regs *regs, const char *str)
>  static __always_inline
>  bool mark_trap_entry(int signo, struct pt_regs *regs)
>  {
> +	oob_trap_notify(signo, regs);
> +
>  	if (likely(running_inband())) {
>  		hard_cond_local_irq_enable();
>  		return true;
>  	}
> =20
> +	oob_trap_unwind(signo, regs);
> +
>  	return false;
>  }
> =20
>  static __always_inline
>  void mark_trap_exit(int signo, struct pt_regs *regs)
>  {
> +	oob_trap_unwind(signo, regs);
>  	hard_cond_local_irq_disable();
>  }
> =20
> -void do_trap(struct pt_regs *regs, int signo, int code, unsigned long ad=
dr)
> +static __always_inline
> +bool mark_trap_entry_raw(int trapnr, struct pt_regs *regs)
>  {
> -	struct task_struct *tsk =3D current;
> +	oob_trap_notify(trapnr, regs);
> =20
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
> +static void do_trap_raw(struct pt_regs *regs, int signo, int code, unsig=
ned long addr)
> +{
> +	struct task_struct *tsk =3D current;
> =20
>  	if (show_unhandled_signals && unhandled_signal(tsk, signo)
>  	    && printk_ratelimit()) {
> @@ -147,6 +168,14 @@ void do_trap(struct pt_regs *regs, int signo, int co=
de, unsigned long addr)
>  	}
> =20
>  	force_sig_fault(signo, code, (void __user *)addr);
> +}
> +
> +void do_trap(struct pt_regs *regs, int signo, int code, unsigned long ad=
dr)
> +{
> +	if(!mark_trap_entry(signo, regs))
> +		return;
> +
> +	do_trap_raw(regs, signo, code, addr);
> =20
>  	mark_trap_exit(signo, regs);
>  }
> @@ -157,7 +186,7 @@ static void do_trap_error(struct pt_regs *regs, int s=
igno, int code,
>  	current->thread.bad_cause =3D regs->cause;
> =20
>  	if (user_mode(regs)) {
> -		do_trap(regs, signo, code, addr);
> +		do_trap_raw(regs, signo, code, addr);
>  	} else {
>  		/*
>  		 * Dovetail: If we trapped from kernel space, either
> @@ -175,37 +204,46 @@ static void do_trap_error(struct pt_regs *regs, int=
 signo, int code,
>  #else
>  #define __trap_section noinstr
>  #endif
> -#define DO_ERROR_INFO(name, signo, code, str)					\
> +#define DO_ERROR_INFO(name, signo, code, str, trapnr)				\
>  asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
>  {										\
>  	if (user_mode(regs)) {							\
> +		if(!mark_trap_entry(trapnr, regs))				\
> +			return;							\
>  		irqentry_enter_from_user_mode(regs);				\
>  		local_irq_enable();						\
>  		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
>  		local_irq_disable();						\
>  		irqentry_exit_to_user_mode(regs);				\
> +		mark_trap_exit(trapnr, regs);					\
>  	} else {								\
> +		if(!mark_trap_entry_raw(trapnr, regs))				\
> +			return;							\
>  		int stalled =3D test_and_stall_inband_nocheck();			\
>  		irqentry_state_t state =3D irqentry_nmi_enter(regs);		\
>  		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
>  		irqentry_nmi_exit(regs, state);					\
>  		if (!stalled)							\
>  			unstall_inband_nocheck();				\
> +		mark_trap_exit_raw(trapnr, regs);				\
>  	}									\
>  }
> =20
>  DO_ERROR_INFO(do_trap_unknown,
> -	SIGILL, ILL_ILLTRP, "unknown exception");
> +	SIGILL, ILL_ILLTRP, "unknown exception", regs->cause);
>  DO_ERROR_INFO(do_trap_insn_misaligned,
> -	SIGBUS, BUS_ADRALN, "instruction address misaligned");
> +	SIGBUS, BUS_ADRALN, "instruction address misaligned", EXC_INST_MISALIGN=
ED);
>  DO_ERROR_INFO(do_trap_insn_fault,
> -	SIGSEGV, SEGV_ACCERR, "instruction access fault");
> +	SIGSEGV, SEGV_ACCERR, "instruction access fault", EXC_INST_ACCESS);

Linux > 7.1 will get one more:=20

DO_ERROR_INFO(do_trap_hardware_error,
	SIGBUS, BUS_MCEERR_AR, "hardware error");

which does not come with an EXT_INST_ macro.

Why can't we just use regs->cause, as we do for the unknown exception
case?

That would allow us to keep DO_ERROR_INFO() as it is, we would only
modify it internally.

> =20
>  asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_=
regs *regs)
>  {
>  	bool handled;
> =20
>  	if (user_mode(regs)) {
> +		if(!mark_trap_entry(EXC_INST_ILLEGAL, regs))
> +			return;
> +
>  		irqentry_enter_from_user_mode(regs);
>  		unstall_inband_nocheck();
>  		hard_local_irq_enable();
> @@ -220,7 +258,12 @@ asmlinkage __visible __trap_section void do_trap_ins=
n_illegal(struct pt_regs *re
>  				      "Oops - illegal instruction");
> =20
>  		irqentry_exit_to_user_mode(regs);
> +
> +		mark_trap_exit(EXC_INST_ILLEGAL, regs);
>  	} else {
> +		if(!mark_trap_entry_raw(EXC_INST_ILLEGAL, regs))
> +			return;
> +
>  		int stalled =3D test_and_stall_inband_nocheck();
>  		irqentry_state_t state =3D irqentry_nmi_enter(regs);
> =20
> @@ -230,11 +273,13 @@ asmlinkage __visible __trap_section void do_trap_in=
sn_illegal(struct pt_regs *re
>  		irqentry_nmi_exit(regs, state);
>  		if (!stalled)
>  			unstall_inband_nocheck();
> +
> +		mark_trap_exit_raw(EXC_INST_ILLEGAL, regs);
>  	}
>  }
> =20
>  DO_ERROR_INFO(do_trap_load_fault,
> -	SIGSEGV, SEGV_ACCERR, "load access fault");
> +	SIGSEGV, SEGV_ACCERR, "load access fault", EXC_LOAD_ACCESS);
> =20
>  enum misaligned_access_type {
>  	MISALIGNED_STORE,
> @@ -254,15 +299,22 @@ static const struct {
>  	},
>  };
> =20
> -static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_acc=
ess_type type)
> +static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_acc=
ess_type type,
> +			       int trapnr)
>  {
>  	irqentry_state_t state;
>  	int stalled;
> =20
>  	if (user_mode(regs)) {
> +		if(!mark_trap_entry(trapnr, regs))
> +			return;
> +
>  		irqentry_enter_from_user_mode(regs);
>  		local_irq_enable();
>  	} else {
> +		if(!mark_trap_entry_raw(trapnr, regs))
> +			return;
> +
>  		stalled =3D test_and_stall_inband_nocheck();
>  		state =3D irqentry_nmi_enter(regs);
>  	}
> @@ -274,29 +326,32 @@ static void do_trap_misaligned(struct pt_regs *regs=
, enum misaligned_access_type
>  	if (user_mode(regs)) {
>  		local_irq_disable();
>  		irqentry_exit_to_user_mode(regs);
> +		mark_trap_exit(trapnr, regs);
>  	} else {
>  		irqentry_nmi_exit(regs, state);
>  		if (!stalled)
>  			unstall_inband_nocheck();
> +
> +		mark_trap_exit_raw(trapnr, regs);
>  	}
>  }
> =20
>  asmlinkage __visible __trap_section void do_trap_load_misaligned(struct =
pt_regs *regs)
>  {
> -	do_trap_misaligned(regs, MISALIGNED_LOAD);
> +	do_trap_misaligned(regs, MISALIGNED_LOAD, EXC_LOAD_MISALIGNED);
>  }
> =20
>  asmlinkage __visible __trap_section void do_trap_store_misaligned(struct=
 pt_regs *regs)
>  {
> -	do_trap_misaligned(regs, MISALIGNED_STORE);
> +	do_trap_misaligned(regs, MISALIGNED_STORE, EXC_STORE_MISALIGNED);
>  }
> =20
>  DO_ERROR_INFO(do_trap_store_fault,
> -	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault");
> +	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault", EXC_STORE_ACCESS);
>  DO_ERROR_INFO(do_trap_ecall_s,
> -	SIGILL, ILL_ILLTRP, "environment call from S-mode");
> +	SIGILL, ILL_ILLTRP, "environment call from S-mode", EXC_SYSCALL);
>  DO_ERROR_INFO(do_trap_ecall_m,
> -	SIGILL, ILL_ILLTRP, "environment call from M-mode");
> +	SIGILL, ILL_ILLTRP, "environment call from M-mode", EXC_SUPERVISOR_SYSC=
ALL);
> =20
>  static inline unsigned long get_break_insn_length(unsigned long pc)
>  {
> @@ -348,6 +403,9 @@ void handle_break(struct pt_regs *regs)
> =20
>  asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *r=
egs)
>  {
> +	if(!mark_trap_entry_raw(EXC_BREAKPOINT, regs))
> +		return;
> +
>  	if (user_mode(regs)) {
>  		irqentry_enter_from_user_mode(regs);
>  		unstall_inband_nocheck();
> @@ -369,6 +427,8 @@ asmlinkage __visible __trap_section void do_trap_brea=
k(struct pt_regs *regs)
>  		if (!stalled)
>  			unstall_inband_nocheck();
>  	}
> +
> +	mark_trap_exit_raw(EXC_BREAKPOINT, regs);
>  }
> =20
>  asmlinkage __visible __trap_section  __no_stack_protector
> @@ -385,6 +445,15 @@ void do_trap_ecall_u(struct pt_regs *regs)
> =20
>  		syscall =3D syscall_enter_from_user_mode(regs, syscall);
> =20
> +		if(dovetailing()) {
> +			if (syscall =3D=3D EXIT_SYSCALL_OOB) {
> +				hard_local_irq_disable();
> +				return;
> +			}
> +			if (syscall =3D=3D EXIT_SYSCALL_TAIL)
> +				goto done_inband;
> +		}
> +
>  		add_random_kstack_offset();
> =20
>  		if (syscall >=3D 0 && syscall < NR_syscalls) {
> @@ -404,6 +473,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
>  		 */
>  		choose_random_kstack_offset(get_random_u16());
> =20
> +done_inband:
>  		syscall_exit_to_user_mode(regs);
>  	} else {
>  		int stalled =3D test_and_stall_inband_nocheck();
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 55c20ad1f7444..8f38b4a5eb262 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -25,7 +25,7 @@ static unsigned long num_asids;
> =20
>  static atomic_long_t current_version;
> =20
> -static DEFINE_RAW_SPINLOCK(context_lock);
> +static DEFINE_HARD_SPINLOCK(context_lock);
>  static cpumask_t context_tlb_flush_pending;
>  static unsigned long *context_asid_map;
> =20
> @@ -315,7 +315,7 @@ static inline void flush_icache_deferred(struct mm_st=
ruct *mm, unsigned int cpu,
>  #endif
>  }
> =20
> -void switch_mm(struct mm_struct *prev, struct mm_struct *next,
> +static void do_switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  	struct task_struct *task)
>  {
>  	unsigned int cpu;
> @@ -336,3 +336,19 @@ void switch_mm(struct mm_struct *prev, struct mm_str=
uct *next,
> =20
>  	flush_icache_deferred(next, cpu, task);
>  }
> +
> +void switch_mm(struct mm_struct *prev, struct mm_struct *next,
> +	struct task_struct *task)
> +{
> +	unsigned long flags;
> +
> +	protect_inband_mm(flags);
> +	do_switch_mm(prev, next, task);
> +	unprotect_inband_mm(flags);
> +}
> +
> +void switch_oob_mm(struct mm_struct *prev, struct mm_struct *next,
> +	struct task_struct *task)
> +{
> +	do_switch_mm(prev, next, task);
> +}
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 885e2f66515e3..32cb7285d6db8 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -7,6 +7,7 @@
>   */
> =20
> =20
> +#include <linux/preempt.h>
>  #include <linux/mm.h>
>  #include <linux/kernel.h>
>  #include <linux/interrupt.h>
> @@ -315,8 +316,12 @@ void handle_page_fault(struct pt_regs *regs)
>  		return;
>  	}
> =20
> +	oob_trap_notify(cause, regs);
> +	if (!running_inband())
> +		goto out;
> +
>  	/* Enable interrupts if they were enabled in the parent context. */
> -	if (!regs_irqs_disabled(regs) && running_inband())
> +	if (!regs_irqs_disabled(regs))
>  		local_irq_enable_full();
> =20
>  	/*
> @@ -326,7 +331,7 @@ void handle_page_fault(struct pt_regs *regs)
>  	if (unlikely(faulthandler_disabled() || !mm)) {
>  		tsk->thread.bad_cause =3D cause;
>  		no_context(regs, addr);
> -		return;
> +		goto out;
>  	}
> =20
>  	if (user_mode(regs))
> @@ -334,7 +339,7 @@ void handle_page_fault(struct pt_regs *regs)
> =20
>  	if (!user_mode(regs) && addr < TASK_SIZE && unlikely(!(regs->status & S=
R_SUM))) {
>  		if (fixup_exception(regs))
> -			return;
> +			goto out;
> =20
>  		die_kernel_fault("access to user memory without uaccess routines", add=
r, regs);
>  	}
> @@ -357,7 +362,7 @@ void handle_page_fault(struct pt_regs *regs)
>  		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
>  		tsk->thread.bad_cause =3D cause;
>  		bad_area_nosemaphore(regs, SEGV_ACCERR, addr);
> -		return;
> +		goto out;
>  	}
> =20
>  	fault =3D handle_mm_fault(vma, addr, flags | FAULT_FLAG_VMA_LOCK, regs)=
;
> @@ -375,7 +380,7 @@ void handle_page_fault(struct pt_regs *regs)
>  	if (fault_signal_pending(fault, regs)) {
>  		if (!user_mode(regs))
>  			no_context(regs, addr);
> -		return;
> +		goto out;
>  	}
>  lock_mmap:
> =20
> @@ -384,7 +389,7 @@ void handle_page_fault(struct pt_regs *regs)
>  	if (unlikely(!vma)) {
>  		tsk->thread.bad_cause =3D cause;
>  		bad_area_nosemaphore(regs, code, addr);
> -		return;
> +		goto out;
>  	}
> =20
>  	/*
> @@ -396,7 +401,7 @@ void handle_page_fault(struct pt_regs *regs)
>  	if (unlikely(access_error(cause, vma))) {
>  		tsk->thread.bad_cause =3D cause;
>  		bad_area(regs, mm, code, addr);
> -		return;
> +		goto out;
>  	}
> =20
>  	/*
> @@ -414,12 +419,12 @@ void handle_page_fault(struct pt_regs *regs)
>  	if (fault_signal_pending(fault, regs)) {
>  		if (!user_mode(regs))
>  			no_context(regs, addr);
> -		return;
> +		goto out;
>  	}
> =20
>  	/* The fault is fully completed (including releasing mmap lock) */
>  	if (fault & VM_FAULT_COMPLETED)
> -		return;
> +		goto out;
> =20
>  	if (unlikely(fault & VM_FAULT_RETRY)) {
>  		flags |=3D FAULT_FLAG_TRIED;
> @@ -438,7 +443,8 @@ void handle_page_fault(struct pt_regs *regs)
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
>  		tsk->thread.bad_cause =3D cause;
>  		mm_fault_error(regs, addr, fault);
> -		return;
>  	}
> -	return;
> +
> +out:
> +	oob_trap_unwind(cause, regs);
>  }
> --=20
> 2.43.0
