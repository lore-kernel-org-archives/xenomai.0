Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689E2196C7C
	for <xenomai@lists.linux.dev>; Thu, 28 May 2026 06:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779950366; cv=none; b=KpS+0ZRh/xNP0IqbiXWtXUNtR9Ga9YJUVeDlDTQ5RoK/FbGpShjpVXk7nFB2a3yf3C04trBFOGDX23Q+MbqAyLAI8Wb2R2OCP5qqrP5XKH9dElGbgEI2/289C8oK8Q/KSve32qxL8snK5rZKDr1cxNrj9ztDFJ7dqVEwD2JDDns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779950366; c=relaxed/simple;
	bh=yKRRVqJ0J0jK+xEKPAMoKMYw94MVbtwWhZCyw6wkrQs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XwM/gtms27yEOOqAGYDUKpiZJHFYNk7zxn369zC3ofeHXd8Y8mkhKPZSaCsA4x1fV6LZ6CDJkq5wqEFwskYS6oSIrDS3lad8z+Kxem6BEL/ZUA7eaGtVWGnISqhZr7B+/QQagLW6/5bFvtV/yEi8JtU1OYkEdw9YsclyhhTDfzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=d+z6aeSM; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="d+z6aeSM"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026052806391237273b8f900002073c
        for <xenomai@lists.linux.dev>;
        Thu, 28 May 2026 08:39:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=0T4TR1vtppr4LazjM8mFYe/RdLAEhUg0/c+lX9QGLGY=;
 b=d+z6aeSMiwwFAz5260BpqJ5VEJVQdQ3fTbRFL/uXEWfTdpbB6DWeBAawZvJa1aqEkY50xE
 aZ2w4sUoz+IEnPwSWAXUEdibHWdd3EvzcebD0cPEZq1VIG7rZiXZ+YEkUPhLT+C9NfrgJsLk
 0i+Fmk1vfrK/Zw9kqrNBPW1q0AacIlptqmmUYdwVEp8mSxbjtsijsE4lad7V/B+a4GyVEQmj
 ju5PY18gac/PBZMAlcrxyO713OQ+su50KfWLwBmwkdhNxqaO4Obryc1/TvLLmU+B6hXrMFgZ
 rmI83diloMIF5GnvAawCceHc6iPHIheEDXRA7yIhvb87uBMKHab330Cw==;
Message-ID: <2c2db565533aa453c6099704580825aa5cce81e3.camel@siemens.com>
Subject: Re: [PATCH dovetail v7 11/11] riscv: dovetail: add core support
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
Date: Thu, 28 May 2026 08:39:12 +0200
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
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0d8291a6c4da5..70ea8457e1f66 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -151,6 +151,7 @@ config RISCV
>  	select HAVE_ARCH_USERFAULTFD_WP if 64BIT && MMU && USERFAULTFD && RISCV=
_ISA_SVRSW60T59B
>  	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
>  	select HAVE_IRQ_PIPELINE
> +	select HAVE_DOVETAIL
>  	select HAVE_ASM_MODVERSIONS
>  	select HAVE_CONTEXT_TRACKING_USER
>  	select HAVE_DEBUG_KMEMLEAK
> @@ -379,6 +380,7 @@ config AS_HAS_OPTION_ARCH
> =20
>  source "arch/riscv/Kconfig.socs"
>  source "arch/riscv/Kconfig.errata"
> +source "kernel/Kconfig.dovetail"
> =20
>  menu "Platform type"
> =20
> diff --git a/arch/riscv/include/asm/dovetail.h b/arch/riscv/include/asm/d=
ovetail.h
> new file mode 100644
> index 0000000000000..ac08db99f4e92
> --- /dev/null
> +++ b/arch/riscv/include/asm/dovetail.h
> @@ -0,0 +1,23 @@
> +/*
> +* SPDX-License-Identifier: GPL-2.0
> +*
> +* Copyright (C) 2024-2026 Tobias Schaffner
> +*/
> +#ifndef _ASM_RISCV_DOVETAIL_H
> +#define _ASM_RISCV_DOVETAIL_H
> +
> +#if !defined(__ASSEMBLY__)
> +#ifdef CONFIG_DOVETAIL
> +
> +static inline void arch_dovetail_exec_prepare(void)
> +{ }
> +
> +static inline void arch_dovetail_switch_prepare(bool leave_inband)
> +{ }
> +
> +static inline void arch_dovetail_switch_finish(bool enter_inband)
> +{ }
> +
> +#endif /* CONFIG_DOVETAIL */
> +#endif /* !__ASSEMBLY__ */
> +#endif /* _ASM_RISCV_DOVETAIL_H */
> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/as=
m/mmu_context.h
> index dbf27a78df6c8..a1ac9192d51c8 100644
> --- a/arch/riscv/include/asm/mmu_context.h
> +++ b/arch/riscv/include/asm/mmu_context.h
> @@ -15,6 +15,8 @@
> =20
>  void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  	struct task_struct *task);
> +void switch_oob_mm(struct mm_struct *prev, struct mm_struct *next,
> +	struct task_struct *task);
> =20
>  #define activate_mm activate_mm
>  static inline void activate_mm(struct mm_struct *prev,
> diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/sy=
scall.h
> index 8067e666a4ca6..12376b54268e0 100644
> --- a/arch/riscv/include/asm/syscall.h
> +++ b/arch/riscv/include/asm/syscall.h
> @@ -117,6 +117,12 @@ static inline bool arch_syscall_is_vdso_sigreturn(st=
ruct pt_regs *regs)
>  	return false;
>  }
> =20
> +static inline unsigned long syscall_get_arg0(struct task_struct *task,
> +					     struct pt_regs *regs)
> +{
> +	return regs->orig_a0;
> +}
> +
>  asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
> =20
>  asmlinkage long sys_riscv_hwprobe(struct riscv_hwprobe *, size_t, size_t=
,
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/as=
m/thread_info.h
> index 8a9e85c6e6316..8153a4f263638 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -41,6 +41,7 @@
> =20
>  #include <asm/processor.h>
>  #include <asm/csr.h>
> +#include <dovetail/thread_info.h>
> =20
>  /*
>   * low level task data that entry.S needs immediate access to
> @@ -80,6 +81,7 @@ struct thread_info {
>  #ifdef CONFIG_RISCV_USER_CFI
>  	struct cfi_state	user_cfi_state;
>  #endif
> +	struct oob_thread_state oob_state;      /* co-kernel thread state */
>  };
> =20
>  #ifdef CONFIG_SHADOW_CALL_STACK
> @@ -123,6 +125,9 @@ int arch_dup_task_struct(struct task_struct *dst, str=
uct task_struct *src);
> =20
>  #include <asm-generic/thread_info_tif.h>
> =20
> +#define TIF_MAYDAY			14      /* emergency trap pending */
> +#define _TIF_MAYDAY			(1 << TIF_MAYDAY)
> +
>  #define TIF_32BIT			16	/* compat-mode 32bit process */
>  #define TIF_RISCV_V_DEFER_RESTORE	17	/* restore Vector before returing t=
o user */
> =20
> @@ -132,5 +137,8 @@ int arch_dup_task_struct(struct task_struct *dst, str=
uct task_struct *src);
>   * Local (synchronous) thread flags.
>   */
>  #define _TLF_OOB		0x0001
> +#define _TLF_DOVETAIL		0x0002
> +#define _TLF_OFFSTAGE		0x0004
> +#define _TLF_OOBTRAP		0x0008
> =20
>  #endif /* _ASM_RISCV_THREAD_INFO_H */
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

I think that it should be possible to merge mark_trap_{entry,exit}_raw()
with the non-raw variant, so that only mark_trap_{entry,exit} would
stay.

The _raw variant is used for traps over kernel-, while non-raw is used
for traps over user-space.

We could check for user_mode() and handle that within one function.

But: See do_trap_break(), break point handling.=20

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

This is the only trap - or more specific: caller of _raw() - that is
different. Why?

All other traps are using _raw() for the kernel- and non-raw for user-
space part.

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
