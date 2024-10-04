Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B863126C04
	for <xenomai@lists.linux.dev>; Fri,  4 Oct 2024 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033483; cv=none; b=rhlzPU1r/4nA7KBnRFcQxMlw4UJ17TodgZeo+DDlf56cW7u3/PhTmHAkIsWk/QE+RXBe77tlGJcM59F0Ui6vq5vZuF1m5wOM3sLXpMX1z2T4V1vd1h4/wpnWmpRoQEFIbDDizgMr1/1qNTrgJyVoIDSIk2kd5xrP/RmaWZLXDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033483; c=relaxed/simple;
	bh=hOQAFJR338wc7147R9nk3NIquC6tn2e1UxuT4B8dyHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uQS7K+JGZRH9amynDBsr5F5Q00LwXSVyBPu4/P3gedXSFw/S6NNdDM3nuzZlCRVcrVZ4t+531xFfQbTizy2iAhPYZA5vv6dlhNUYuw1se0wD+10WxGgrE3U2KqUAqhS3NfyHFpXgnVdrwwCdL/X3mL1Zazy1whrnZ+ZSZmX6bQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so18107695e9.1
        for <xenomai@lists.linux.dev>; Fri, 04 Oct 2024 02:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728033479; x=1728638279;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLeZvLC8CSnoNasO5MNd+QpFFWmrP2tnLCa7xQ6yHxQ=;
        b=EmWORnfQEuLydr6oggyMfUaFGJHXY3UTOdlPX6fmzJX+8RVHxHNfSV8rf5QRsDr7I2
         EJt8bNAoS5INm0e9ZdhjWJmSSMl+hmYBCr6jqOEHJp7boniqr8DwQwb0gOi8kkpDQX/a
         NsXZ8ItwX1R7Svszk+Uwc8syuCbu5/pt2+y3I2EtwfJutIUuIFqpO6Qi0vCzp+h3Fhr0
         twhoonlJrJnBU6AhCfffE/1OPvGNpnpEskLOumvvG8/zBaHC0NlJPBEq+fXVrjAS1Z4V
         hCvPmgllKMlmavvtYB5BCReIzGX5d9PhQHGPY0EQturyJcrldHxcoxz/WXwBD/0osmIl
         YS+g==
X-Gm-Message-State: AOJu0Yy9lY/vUEd1UfyDCrKn0Zj1IEQEN1RRAYEBmyxmtD8pAngogOUk
	xebGXKHidmZyWDq1bIan81CeK6RI6re7o9MV8++gY+7/O2ZIIBI8
X-Google-Smtp-Source: AGHT+IE9CERqpy5x+Fm0i1W5m8F89mUN+EQklzR0Uz4ai8sKJBwNeocBIOpSPOl9n5F/uP++FRzPIg==
X-Received: by 2002:a05:600c:5804:b0:42c:b1ee:4b04 with SMTP id 5b1f17b1804b1-42f85ae918amr13849585e9.28.1728033479126;
        Fri, 04 Oct 2024 02:17:59 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b2a580sm10692265e9.33.2024.10.04.02.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 02:17:58 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  jan.kiszka@siemens.com
Subject: Re: [PATCH dovetail 6.11 2/2] RISC-V: irq_pipeline: add IRQ
 pipelining core
In-Reply-To: <20241002104007.991278-3-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Wed, 2 Oct 2024 12:40:07 +0200")
References: <20241002104007.991278-1-tobias.schaffner@siemens.com>
	<20241002104007.991278-3-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 04 Oct 2024 11:17:53 +0200
Message-ID: <87ldz45iri.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Hi Tobias,

This is really nice and refreshing to see people contributing to this
project, not to mention that a dovetail architecture port to RISC-V is
definitely valuable.

The following patch review is only about nitpicking, the core logic
looks sane. I'll bring up a qemu vm asap to work with you on merging
this port.

Thanks,

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
> index 7030837adc1a..a96a4a16819c 100644
> --- a/arch/riscv/include/asm/mmu_context.h
> +++ b/arch/riscv/include/asm/mmu_context.h
> @@ -33,6 +33,11 @@ static inline int init_new_context(struct task_struct *tsk,
>  	return 0;
>  }
>  
> +static inline void
> +switch_oob_mm(struct mm_struct *prev, struct mm_struct *next,
> +	      struct task_struct *tsk) { }
> +
> +
>  DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
>  
>  #include <asm-generic/mmu_context.h>

This should be part of a separate patch enabling the alternate
scheduling capability. This way we can git-bisect through reasonably
fine-grained changes (at least from a functional POV) when chasing
regressions.

> diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
> index 121fff429dce..9e602ce18a18 100644
> --- a/arch/riscv/include/asm/syscall.h
> +++ b/arch/riscv/include/asm/syscall.h
> @@ -95,6 +95,12 @@ static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
>  	return false;
>  }
>  
> +static inline unsigned long syscall_get_arg0(struct task_struct *task,
> +					     struct pt_regs *regs)
> +{
> +	return regs->a0;
> +}
> +
>  asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
>  
Separate patch as well, for routing/intercepting syscalls.

>  asmlinkage long sys_riscv_hwprobe(struct riscv_hwprobe *, size_t, size_t,
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> index fca5c6be2b81..09162da76a02 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -47,6 +47,7 @@
>   */
>  struct thread_info {
>  	unsigned long		flags;		/* low level flags */
> +	__u32			local_flags;	/* local (synchronous) flags */
>  	int                     preempt_count;  /* 0=>preemptible, <0=>BUG */
>  	/*
>  	 * These stack pointers are overwritten on every system call or
> @@ -83,6 +84,8 @@ struct thread_info {
>  	INIT_SCS				\
>  }
>  
> +#define ti_local_flags(__ti)    ((__ti)->local_flags)
> +
>  void arch_release_task_struct(struct task_struct *tsk);
>  int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>  
> @@ -104,6 +107,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>  #define TIF_UPROBE		10	/* uprobe breakpoint or singlestep */
>  #define TIF_32BIT		11	/* compat-mode 32bit process */
>  #define TIF_RISCV_V_DEFER_RESTORE	12 /* restore Vector before returing to user */
> +#define TIF_RETUSER		13	/* INBAND_TASK_RETUSER is pending */
> +#define TIF_MAYDAY		14	/* emergency trap pending */
>  
>  #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
> @@ -111,9 +116,19 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>  #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
>  #define _TIF_UPROBE		(1 << TIF_UPROBE)
>  #define _TIF_RISCV_V_DEFER_RESTORE	(1 << TIF_RISCV_V_DEFER_RESTORE)
> +#define _TIF_RETUSER		(1 << TIF_RETUSER)

RETUSER is a syscall-related extension, transferring control to the
companion core right before an in-band task returns to user mode after a
syscall/signal. Granted, I've been a bit sloppy in the past with RETUSER
which was a late addition, so it was introduced at different places in
the patch pile depending on the architecture. "<arch>: dovetail: route
syscalls" is probably the best place to include this hunk though. This
patch builds on the arch-specific dovetail core bits.

> +#define _TIF_MAYDAY		(1 << TIF_MAYDAY)
>  

MAYDAY should be part of the arch-specific dovetail core bits,
e.g. "<arch>: dovetail: add core support".

>  #define _TIF_WORK_MASK \
>  	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED | \
> -	 _TIF_NOTIFY_SIGNAL | _TIF_UPROBE)
> +	 _TIF_NOTIFY_SIGNAL | _TIF_UPROBE | _TIF_RETUSER)
> +
> +/*
> + * Local (synchronous) thread flags.
> + */
> +#define _TLF_OOB		0x0001
> +#define _TLF_DOVETAIL		0x0002

TLF_DOVETAIL should belong to the same patch which includes the MAYDAY
flag. This is a bit for marking a task which may use alternate
scheduling, oob syscalls, anything which task-related, built on top of
the execution domains in-band vs oob introduced by the interrupt
pipeline.

> +#define _TLF_OFFSTAGE		0x0004

Likewise, TLF_OFFSTAGE is a marker denoting a task migration from the
in-band stage to oob. So this should belong to "<arch>: dovetail: add
core support".

> +#define _TLF_OOBTRAP		0x0008
>

If we want to keep on following the existing patch split scheme, OOBTRAP
should be introduced by "<arch>: dovetail: route traps". This is a
marker to prevent recursion when the companion core faults while
processing a notification about...a fault.

> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 05a16b1f0aee..636a956ed699 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -111,10 +111,59 @@ void die(struct pt_regs *regs, const char *str)
>  		make_task_dead(SIGSEGV);
>  }
>  
> +static __always_inline
> +bool mark_trap_entry(int signo, struct pt_regs *regs)
> +{
> +	oob_trap_notify(signo, regs);
> +
> +	if (likely(running_inband())) {
> +		hard_cond_local_irq_enable();
> +		return true;
> +	}
> +
> +	/*
> +	 * If the oob core did not switch us inband, our caller is
> +	 * expected to leave the trap handler immediately, so we may
> +	 * notify the core about this right now.
> +	 */
> +	oob_trap_unwind(signo, regs);
> +
> +	return false;
> +}
> +
> +static __always_inline
> +void mark_trap_exit(int signo, struct pt_regs *regs)
> +{
> +	oob_trap_unwind(signo, regs);
> +	hard_cond_local_irq_disable();
> +}
> +
> +static __always_inline
> +bool mark_trap_entry_raw(int trapnr, struct pt_regs *regs)
> +{
> +	oob_trap_notify(trapnr, regs);
> +
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
>  void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
>  {
>  	struct task_struct *tsk = current;
>  
> +	if (!mark_trap_entry(signo, regs))
> +		return;
> +
>  	if (show_unhandled_signals && unhandled_signal(tsk, signo)
>  	    && printk_ratelimit()) {
>  		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
> @@ -126,6 +175,8 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
>  	}
>  
>  	force_sig_fault(signo, code, (void __user *)addr);
> +
> +	mark_trap_exit(signo, regs);
>  }
>  

oob_trap_notify() and oob_trap_unwind() are dovetail-specific for a
given architecture. These hooks tell the companion core about some
ongoing (synchronous) fault/exception the current task may
caused. Typically, the cobalt/evl would demote that task to in-band mode
if dovetail cannot fix the situation without running regular trap
management code (e.g. minor [access] faults which would only require
some fixup in the page table entries compared to major ones involving
error recovery and so on). So moving those calls to "<arch>: dovetail:
route traps" makes sense - which does not preclude the need for dealing
with the interrupt state as you do in mark_trap_entry/exit(), since this
is required by the interrupt pipeline logic for lowering latency.

-- 
Philippe.
