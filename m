Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16513330B27
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110588; cv=none; b=fAXBftkW0YriWwDNp48kSwAQ1jKnlfZpgaPUW0HIsV3XIzzpgIuaRJU4Lo23eUJgoZkTaMml9uTqO8Q9vCpR1X27SC44f+ycDsoyFpQ+UazcyeiuEXzyYWXq0FS76hO56bB25+WFPrbW3qgZ3eSM1DPchsjOX/X/TtkAx6pewHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110588; c=relaxed/simple;
	bh=2JkT+S6hYb2IsmXEZN4YCFoshv3VXHmJ328Jzlg33kU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TNmf2snWxrs1riYp8rDyrqU9W+xqjCO3KSwlfuqXo8qlmopbUvvCi+EJRforVuWDExt3kW86Dp1RpcQwUpvBcOJ9JU0V45DNpZukUJo3ozy8Husx2lnWyd2qzFPr7yGBGjS2R+Aok8QpE6/whCwfZmfy4BLUXxaDo1bh6zIjTio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=NbjgOmKn; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="NbjgOmKn"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2122A444F9;
	Thu, 22 Jan 2026 19:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1769110560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QgJO7IKxeN3iCsP76Q7pKGtpAkt1XOVVklyDSM6q+XA=;
	b=NbjgOmKnDY0rezgPDlAILpUS8P4J1ZwCbKnS3XVE+donVRQDBEm+pgQiS7JC5aXzFY/Ols
	q8QvNbTUaDHObYxEmvehWAa3mndcWgjKD9MG69Q1E8tVWfYdmL0x4SR4pEnAC16xgfKvPU
	zMVCU6w2am67mdLK04EelYAle4erzNjBO9LZc81truIVBWxJkodlW15/Ewh9JYkWQhV4rR
	XCl1IzdVVD5KjFW2exndX82nI4WeFvBkh5vr1JUF8E3vk1miy/jzfj8WWM+wwvuYKBR0kD
	Q1q3hKPlmGvWaWzJ52AaSma/tab/0FNrlQDPDLotr5kL7//l+aCpGDkC2t8eWg==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  shannmu <shanmu1901@gmail.com>
Subject: Re: [PATCH dovetail v4 01/12] riscv: irq_pipeline: add IRQ
 pipelining core
In-Reply-To: <20260122102304.421957-2-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Thu, 22 Jan 2026 11:22:53 +0100")
References: <20260122102304.421957-1-tobias.schaffner@siemens.com>
	<20260122102304.421957-2-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 22 Jan 2026 20:35:58 +0100
Message-ID: <87ldhpigo1.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejtdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepvdduvddvteeggeeghfelpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehshhgrnhhmuhduledtudesghhmrghilhdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepthhosghirghsrdhstghhrghffhhnvghrsehsihgvmhgvnhhsrdgtohhm

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> This patchset integrates IRQ pipelining into the RISC-V architecture,
> bringing it in line with the Dovetail/IRQ pipeline model used on other
> architectures. It adds the core pipelining infrastructure, updates the
> interrupt and trap entry/exit paths, and adapts low-level primitives to
> cleanly separate in-band and out-of-band interrupt handling.
>
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> Co-authored-by: shannmu <shanmu1901@gmail.com>
> Co-authored-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  arch/riscv/Kconfig                     |   1 +
>  arch/riscv/include/asm/irq_pipeline.h  | 148 +++++++++++++++++++++++++
>  arch/riscv/include/asm/irqflags.h      |  32 ++++--
>  arch/riscv/include/asm/thread_info.h   |   9 ++
>  arch/riscv/kernel/Makefile             |   1 +
>  arch/riscv/kernel/irq_pipeline.c       |  26 +++++
>  arch/riscv/kernel/kernel_mode_vector.c |   2 +-
>  arch/riscv/kernel/sbi-ipi.c            |  10 +-
>  arch/riscv/kernel/smp.c                |  97 ++++++++++++----
>  arch/riscv/kernel/smpboot.c            |   2 +-
>  arch/riscv/kernel/traps.c              |  67 +++++++++--
>  arch/riscv/mm/fault.c                  |  51 ++++++++-
>  drivers/clocksource/timer-clint.c      |   8 ++
>  13 files changed, 408 insertions(+), 46 deletions(-)
>  create mode 100644 arch/riscv/include/asm/irq_pipeline.h
>  create mode 100644 arch/riscv/kernel/irq_pipeline.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index fadec20b87a8..e93a0b6f9f2b 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -148,6 +148,7 @@ config RISCV
>  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if 64BIT && MMU
>  	select HAVE_ARCH_USERFAULTFD_MINOR if 64BIT && USERFAULTFD
>  	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
> +	select HAVE_IRQ_PIPELINE
>  	select HAVE_ASM_MODVERSIONS
>  	select HAVE_CONTEXT_TRACKING_USER
>  	select HAVE_DEBUG_KMEMLEAK
> diff --git a/arch/riscv/include/asm/irq_pipeline.h b/arch/riscv/include/asm/irq_pipeline.h
> new file mode 100644
> index 000000000000..c479ec44b3a5
> --- /dev/null
> +++ b/arch/riscv/include/asm/irq_pipeline.h
> @@ -0,0 +1,148 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * IRQ Pipelining adapted from the ARM version.
> + *
> + * Copyright (C) 2024 Siemens AG
> + * Author:       Tobias Schaffner <tobias.schaffner@siemens.com>.
> + */
> +
> +#ifndef _ASM_RISCV_IRQ_PIPELINE_H
> +#define _ASM_RISCV_IRQ_PIPELINE_H
> +
> +#define OOB_NR_IPI		3
> +
> +
> +extern int ipi_virq_base;
> +extern int NR_CALL_FUNCTION_OOB_IPI;
> +extern int NR_RESCHEDULE_OOB_IPI;
> +extern int NR_TIMER_OOB_IPI;
> +extern int ipi_max;
> +
> +#define CALL_FUNCTION_OOB_IPI (ipi_virq_base + NR_CALL_FUNCTION_OOB_IPI)
> +#define RESCHEDULE_OOB_IPI (ipi_virq_base + NR_RESCHEDULE_OOB_IPI)
> +#define TIMER_OOB_IPI (ipi_virq_base + NR_TIMER_OOB_IPI)
> +#define PIPELINED_IPI_MAX ipi_max

Is there any reason for not having the above oob-specific stuff guarded
by CONFIG_IRQ_PIPELINE as below?

> +
> +#ifdef CONFIG_IRQ_PIPELINE
> +
> +#include <asm/ptrace.h>
> +
> +/* NOTE: Any bit should be fine as long as we don't hit SR_SIE or SR_MIE. */
> +#define IRQMASK_i_POS   31
> +
> +static inline notrace
> +unsigned long arch_irqs_virtual_to_native_flags(int stalled)
> +{
> +	if (!stalled)
> +		return SR_IE;
> +	return 0;
> +}
> +
> +static inline notrace
> +unsigned long arch_irqs_native_to_virtual_flags(unsigned long flags)
> +{
> +	return (!!native_irqs_disabled_flags(flags)) << IRQMASK_i_POS;
> +}
> +
> +static inline int arch_irqs_disabled_flags(unsigned long flags)
> +{
> +	return native_irqs_disabled_flags(flags);
> +}
> +
> +static inline notrace void arch_local_irq_enable(void)
> +{
> +	barrier();
> +	inband_irq_enable();
> +}
> +
> +static inline notrace void arch_local_irq_disable(void)
> +{
> +	inband_irq_disable();
> +	barrier();
> +}
> +
> +static inline notrace unsigned long arch_local_save_flags(void)
> +{
> +	int stalled = inband_irqs_disabled();
> +
> +	barrier();
> +	return arch_irqs_virtual_to_native_flags(stalled);
> +}
> +
> +static inline notrace unsigned long arch_local_irq_save(void)
> +{
> +	int stalled = inband_irq_save();
> +
> +	barrier();
> +	return arch_irqs_virtual_to_native_flags(stalled);
> +}
> +
> +/* set interrupt enabled status */
> +static inline void arch_local_irq_restore(unsigned long flags)
> +{
> +	inband_irq_restore(arch_irqs_disabled_flags(flags));
> +	barrier();
> +}
> +
> +static inline
> +void arch_save_timer_regs(struct pt_regs *dst, struct pt_regs *src)
> +{
> +	dst->status = src->status;
> +	dst->epc = src->epc;
> +}
> +
> +#else /* !CONFIG_IRQ_PIPELINE */
> +
> +static inline unsigned long arch_local_irq_save(void)
> +{
> +	return native_irq_save();
> +}
> +
> +static inline void arch_local_irq_enable(void)
> +{
> +	native_irq_enable();
> +}
> +
> +static inline void arch_local_irq_disable(void)
> +{
> +	native_irq_disable();
> +}
> +
> +static inline unsigned long arch_local_save_flags(void)
> +{
> +	return native_save_flags();
> +}
> +
> +static inline void arch_local_irq_restore(unsigned long flags)
> +{
> +	native_irq_restore(flags);
> +}
> +
> +static inline int arch_irqs_disabled_flags(unsigned long flags)
> +{
> +	return native_irqs_disabled_flags(flags);
> +}
> +
> +#endif /* !CONFIG_IRQ_PIPELINE */
> +
> +/* test hardware interrupt enable bit */
> +static inline int arch_irqs_disabled(void)
> +{
> +	return arch_irqs_disabled_flags(arch_local_save_flags());
> +}
> +
> +struct pt_regs;
> +
> +extern void (*handle_arch_irq)(struct pt_regs *);
> +
> +static inline void arch_handle_irq_pipelined(struct pt_regs *regs)
> +{
> +	handle_arch_irq(regs);
> +}
> +
> +static inline int arch_enable_oob_stage(void)
> +{
> +	return 0;
> +}
> +
> +#endif /* _ASM_RISCV_IRQ_PIPELINE_H */
> diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
> index 6fd8cbfcfcc7..c3087b74752b 100644
> --- a/arch/riscv/include/asm/irqflags.h
> +++ b/arch/riscv/include/asm/irqflags.h
> @@ -10,45 +10,57 @@
>  #include <asm/csr.h>
>  
>  /* read interrupt enabled status */
> -static inline unsigned long arch_local_save_flags(void)
> +static inline unsigned long native_save_flags(void)
>  {
> -	return csr_read(CSR_STATUS);
> +	return csr_read(CSR_STATUS) & SR_IE;
>  }
>  
>  /* unconditionally enable interrupts */
> -static inline void arch_local_irq_enable(void)
> +static inline void native_irq_enable(void)
>  {
>  	csr_set(CSR_STATUS, SR_IE);
>  }
>  
>  /* unconditionally disable interrupts */
> -static inline void arch_local_irq_disable(void)
> +static inline void native_irq_disable(void)
>  {
>  	csr_clear(CSR_STATUS, SR_IE);
>  }
>  
>  /* get status and disable interrupts */
> -static inline unsigned long arch_local_irq_save(void)
> +static inline unsigned long native_irq_save(void)
>  {
>  	return csr_read_clear(CSR_STATUS, SR_IE);
>  }
>  
>  /* test flags */
> -static inline int arch_irqs_disabled_flags(unsigned long flags)
> +static inline int native_irqs_disabled_flags(unsigned long flags)
>  {
>  	return !(flags & SR_IE);
>  }
>  
>  /* test hardware interrupt enable bit */
> -static inline int arch_irqs_disabled(void)
> +static inline bool native_irqs_disabled(void)
>  {
> -	return arch_irqs_disabled_flags(arch_local_save_flags());
> +	return native_irqs_disabled_flags(native_save_flags());
>  }
>  
>  /* set interrupt enabled status */
> -static inline void arch_local_irq_restore(unsigned long flags)
> +static inline void native_irq_restore(unsigned long flags)
>  {
> -	csr_set(CSR_STATUS, flags & SR_IE);
> +	if (flags & SR_IE)
> +		csr_set(CSR_STATUS, SR_IE);
> +	else
> +		csr_clear(CSR_STATUS, SR_IE);
> +}
> +
> +#include <asm/irq_pipeline.h>
> +
> +static inline void native_irq_sync(void)
> +{
> +	native_irq_enable();
> +	asm volatile("nop" : : : "memory");
> +	native_irq_disable();
>  }
>  
>  #endif /* _ASM_RISCV_IRQFLAGS_H */
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> index 836d80dd2921..9e4c9b884b5a 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -52,6 +52,10 @@
>   */
>  struct thread_info {
>  	unsigned long		flags;		/* low level flags */
> +#ifdef CONFIG_IRQ_PIPELINE
> +	__u32			local_flags;	/* local (synchronous) flags */
> +#define ti_local_flags(__ti)    ((__ti)->local_flags)
> +#endif  
>  	int                     preempt_count;  /* 0=>preemptible, <0=>BUG */
>  	/*
>  	 * These stack pointers are overwritten on every system call or
> @@ -121,4 +125,9 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>  
>  #define _TIF_RISCV_V_DEFER_RESTORE	BIT(TIF_RISCV_V_DEFER_RESTORE)
>  
> +/*
> + * Local (synchronous) thread flags.
> + */
> +#define _TLF_OOB		0x0001
> +
>  #endif /* _ASM_RISCV_THREAD_INFO_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f60fce69b725..e4be4ae40b30 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -91,6 +91,7 @@ obj-$(CONFIG_MODULES)		+= module.o
>  obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
>  
>  obj-$(CONFIG_CPU_PM)		+= suspend_entry.o suspend.o
> +obj-$(CONFIG_IRQ_PIPELINE)	+= irq_pipeline.o
>  obj-$(CONFIG_HIBERNATION)	+= hibernate.o hibernate-asm.o
>  
>  obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
> diff --git a/arch/riscv/kernel/irq_pipeline.c b/arch/riscv/kernel/irq_pipeline.c
> new file mode 100644
> index 000000000000..4eeb4394434f
> --- /dev/null
> +++ b/arch/riscv/kernel/irq_pipeline.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IRQ Pipelining implementation adapted from the ARM version.
> + *
> + * Copyright (C) 2024 Siemens AG
> + * Author:       Tobias Schaffner <tobias.schaffner@siemens.com>.
> + */
> +#include <linux/irq.h>
> +#include <linux/irq_pipeline.h>
> +
> +void arch_do_IRQ_pipelined(struct irq_desc *desc)
> +{
> +	struct pt_regs *regs = raw_cpu_ptr(&irq_pipeline.tick_regs);
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +
> +	irq_enter();
> +	handle_irq_desc(desc);
> +	irq_exit();
> +
> +	set_irq_regs(old_regs);
> +}
> +
> +void __init arch_irq_pipeline_init(void)
> +{
> +	/* no per-arch init. */
> +}
> diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
> index 99972a48e86b..c4444577449c 100644
> --- a/arch/riscv/kernel/kernel_mode_vector.c
> +++ b/arch/riscv/kernel/kernel_mode_vector.c
> @@ -171,7 +171,7 @@ asmlinkage void riscv_v_context_nesting_end(struct pt_regs *regs)
>  	struct __riscv_v_ext_state *vstate = &current->thread.kernel_vstate;
>  	u32 depth;
>  
> -	WARN_ON(!irqs_disabled());
> +	WARN_ON(!hard_irqs_disabled());
>  
>  	if (!riscv_preempt_v_started(current))
>  		return;
> diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
> index 0cc5559c08d8..176f4ad3c427 100644
> --- a/arch/riscv/kernel/sbi-ipi.c
> +++ b/arch/riscv/kernel/sbi-ipi.c
> @@ -12,6 +12,7 @@
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
>  #include <asm/sbi.h>
> +#include <asm/irq_pipeline.h>
>  
>  DEFINE_STATIC_KEY_FALSE(riscv_sbi_for_rfence);
>  EXPORT_SYMBOL_GPL(riscv_sbi_for_rfence);
> @@ -57,7 +58,11 @@ void __init sbi_ipi_init(void)
>  		return;
>  	}
>  
> +#ifdef CONFIG_IRQ_PIPELINE
> +	virq = ipi_mux_create(PIPELINED_IPI_MAX, sbi_send_ipi);
> +#else
>  	virq = ipi_mux_create(BITS_PER_BYTE, sbi_send_ipi);
> +#endif
>  	if (virq <= 0) {
>  		pr_err("unable to create muxed IPIs\n");
>  		irq_dispose_mapping(sbi_ipi_virq);
> @@ -74,8 +79,11 @@ void __init sbi_ipi_init(void)
>  	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_SBI_IPI_STARTING,
>  			  "irqchip/sbi-ipi:starting",
>  			  sbi_ipi_starting_cpu, NULL);
> -
> +#ifdef CONFIG_IRQ_PIPELINE
> +	riscv_ipi_set_virq_range(virq, PIPELINED_IPI_MAX);
> +#else
>  	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
> +#endif
>  	pr_info("providing IPIs using SBI IPI extension\n");
>

Maybe we could tame down the #ifdeffery a bit by defining a single
symbol (e.g. IRQ_RISCV_IPI_MAX or whatever fits there) with a
conditional value, which we could use everywhere BITS_PER_BYTE has this
meaning?

#ifdef CONFIG_IRQ_PIPELINE
#define IRQ_RISCV_IPI_MAX ipi_max
#else
#define IRQ_RISCV_IPI_MAX BITS_PER_BYTE
#endif

>  	/*
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 5ed5095320e6..ab404da52b46 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -8,6 +8,7 @@
>   * Copyright (C) 2017 SiFive
>   */
>  
> +#include "linux/compiler.h"
>  #include <linux/cpu.h>
>  #include <linux/clockchips.h>
>  #include <linux/interrupt.h>
> @@ -21,6 +22,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/delay.h>
>  #include <linux/irq.h>
> +#include <linux/irq_pipeline.h>
>  #include <linux/irq_work.h>
>  #include <linux/nmi.h>
>  
> @@ -28,6 +30,8 @@
>  #include <asm/cacheflush.h>
>  #include <asm/cpu_ops.h>
>  
> +#include <trace/events/ipi.h>
> +
>  enum ipi_message_type {
>  	IPI_RESCHEDULE,
>  	IPI_CALL_FUNC,
> @@ -37,7 +41,13 @@ enum ipi_message_type {
>  	IPI_TIMER,
>  	IPI_CPU_BACKTRACE,
>  	IPI_KGDB_ROUNDUP,
> -	IPI_MAX
> +#ifdef CONFIG_IRQ_PIPELINE
> +	OOB_TIMER_IPI,
> +	OOB_RESCHEDULE_IPI,
> +	OOB_CALL_FUNCTION_IPI,
> +#endif
> +	IPI_MAX,
> +
>  };
>  
>  static const char * const ipi_names[] = {
> @@ -49,8 +59,21 @@ static const char * const ipi_names[] = {
>  	[IPI_TIMER]		= "Timer broadcast interrupts",
>  	[IPI_CPU_BACKTRACE]     = "CPU backtrace interrupts",
>  	[IPI_KGDB_ROUNDUP]	= "KGDB roundup interrupts",
> +#ifdef CONFIG_IRQ_PIPELINE
> +	[OOB_TIMER_IPI]		= "OOB timer interrupts",
> +	[OOB_RESCHEDULE_IPI]	= "OOB reschedule interrupts",
> +	[OOB_CALL_FUNCTION_IPI]	= "OOB call function interrupts",
> +#endif
>  };
>  
> +#ifdef CONFIG_IRQ_PIPELINE
> +#define INBAND_IPI_MAX (IPI_MAX - OOB_NR_IPI)
> +int ipi_max __ro_after_init = IPI_MAX;
> +int NR_TIMER_OOB_IPI __ro_after_init = OOB_TIMER_IPI;
> +int NR_RESCHEDULE_OOB_IPI __ro_after_init = OOB_RESCHEDULE_IPI;
> +int NR_CALL_FUNCTION_OOB_IPI __ro_after_init = OOB_CALL_FUNCTION_IPI;
> +#endif
> +
>  unsigned long __cpuid_to_hartid_map[NR_CPUS] __ro_after_init = {
>  	[0 ... NR_CPUS-1] = INVALID_HARTID
>  };
> @@ -63,11 +86,11 @@ void __init smp_setup_processor_id(void)
>  	pr_info("Booting Linux on hartid %lu\n", boot_cpu_hartid);
>  }
>  
> -static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
> -static int ipi_virq_base __ro_after_init;
> +int ipi_virq_base __ro_after_init;
>  static int nr_ipi __ro_after_init = IPI_MAX;
>  static struct irq_desc *ipi_desc[IPI_MAX] __read_mostly;
>  
> +
>  int riscv_hartid_to_cpuid(unsigned long hartid)
>  {
>  	int i;
> @@ -95,7 +118,7 @@ static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
>  
>  	atomic_dec(&waiting_for_crash_ipi);
>  
> -	local_irq_disable();
> +	hard_local_irq_disable();
>  
>  #ifdef CONFIG_HOTPLUG_CPU
>  	if (cpu_has_hotplug(cpu))
> @@ -112,23 +135,6 @@ static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
>  }
>  #endif
>  
> -static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
> -{
> -	__ipi_send_mask(ipi_desc[op], mask);
> -}
> -
> -static void send_ipi_single(int cpu, enum ipi_message_type op)
> -{
> -	__ipi_send_mask(ipi_desc[op], cpumask_of(cpu));
> -}
> -
> -#ifdef CONFIG_IRQ_WORK
> -void arch_irq_work_raise(void)
> -{
> -	send_ipi_single(smp_processor_id(), IPI_IRQ_WORK);
> -}
> -#endif
> -
>  static irqreturn_t handle_IPI(int irq, void *data)
>  {
>  	unsigned int cpu = smp_processor_id();
> @@ -169,6 +175,45 @@ static irqreturn_t handle_IPI(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +#ifdef CONFIG_IRQ_PIPELINE
> +
> +void irq_send_oob_ipi(unsigned int irq,
> +		const struct cpumask *cpumask)
> +{
> +	unsigned int op = irq - ipi_virq_base;
> +
> +	if (WARN_ON(irq_pipeline_debug() &&
> +		    (op < INBAND_IPI_MAX ||
> +		     op >= IPI_MAX)))
> +		return;
> +
> +	/* Init oob ipis at first involve*/
> +	if (unlikely(ipi_desc[op] == NULL))
> +		ipi_desc[op] = irq_to_desc(irq);
> +
> +	__ipi_send_mask(ipi_desc[op], cpumask);
> +}
> +EXPORT_SYMBOL_GPL(irq_send_oob_ipi);
> +
> +#endif

Again, generally speaking, I would really try to group pipeline-specific
changes to only a few sections in the file. Using neutral/empty
placeholders when no work is required when IRQ_PIPELINE/DOVETAIL is off
would preserve readability.

> +
> +static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
> +{
> +	__ipi_send_mask(ipi_desc[op], mask);
> +}
> +
> +static void send_ipi_single(int cpu, enum ipi_message_type op)
> +{
> +	__ipi_send_mask(ipi_desc[op], cpumask_of(cpu));
> +}
> +
> +#ifdef CONFIG_IRQ_WORK
> +void arch_irq_work_raise(void)
> +{
> +	send_ipi_single(smp_processor_id(), IPI_IRQ_WORK);
> +}
> +#endif
> +
>  void riscv_ipi_enable(void)
>  {
>  	int i;
> @@ -204,13 +249,17 @@ void riscv_ipi_set_virq_range(int virq, int nr)
>  		return;
>  
>  	WARN_ON(nr < IPI_MAX);
> -	nr_ipi = min(nr, IPI_MAX);
> +
>  	ipi_virq_base = virq;
>  
>  	/* Request IPIs */
>  	for (i = 0; i < nr_ipi; i++) {
> -		err = request_percpu_irq(ipi_virq_base + i, handle_IPI,
> -					 ipi_names[i], &ipi_dummy_dev);
> +#ifdef CONFIG_IRQ_PIPELINE
> +		if (i < INBAND_IPI_MAX)
> +#endif

On a general note, you may want to use the irqs_pipelined() predicate
(or dovetailed() if you need to check for CONFIG_DOVETAIL=y) instead of
guarding with CONFIG_IRQ_PIPELINE. Granted, you would need to provide a
neutral equivalent which the compiler would not complain about when
CONFIG_IRQ_PIPELINE=n, but that would be much easier to read, keeping
the original code and intent clear and the purpose of the
dovetail-related addition obvious (well, sort of).

e.g.

Some global conditional section:

#ifdef CONFIG_IRQ_PIPELINE

static inline bool foo(void)
{
        if (unlikely(strange_pipeline_work() == 42))
            return false;

        return true;
}

#else

static inline bool foo(void)
{
        return true;
}

#endif

...

int bar(void)
{
        if (!foo())
            return -EBADLUCK;

        return 0;
}

> +			err = request_percpu_irq(ipi_virq_base + i, handle_IPI,
> +						 ipi_names[i], &irq_stat);
> +
>  		WARN_ON(err);
>  
>  		ipi_desc[i] = irq_to_desc(ipi_virq_base + i);
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 601a321e0f17..9cdd5908edf4 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -248,6 +248,6 @@ asmlinkage __visible void smp_callin(void)
>  	 * Disable preemption before enabling interrupts, so we don't try to
>  	 * schedule a CPU that hasn't actually started yet.
>  	 */
> -	local_irq_enable();
> +	local_irq_enable_full();
>  	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
>  }
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 80230de167de..44b627d762f9 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -112,10 +112,36 @@ void die(struct pt_regs *regs, const char *str)
>  		make_task_dead(SIGSEGV);
>  }
>  
> +static __always_inline
> +bool mark_trap_entry(int signo, struct pt_regs *regs)
> +{
> +	/*
> +	 * Dovetail: irqentry_enter*() already synchronized the
> +	 * virtual and real interrupt states for us. If running
> +	 * in-band, we may re-enable hard irqs to allow oob events in
> +	 * while we perform the regular trap handling.
> +	 */
> +	if (likely(running_inband())) {
> +		hard_cond_local_irq_enable();
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static __always_inline
> +void mark_trap_exit(int signo, struct pt_regs *regs)
> +{
> +	hard_cond_local_irq_disable();
> +}
> +
>  void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
>  {
>  	struct task_struct *tsk = current;
>  
> +	if (!mark_trap_entry(signo, regs))
> +		return;
> +

Strictly speaking, we don't have to make a trap entry until we actually
run a companion core, because this is only useful when hitting a trap
from the oob stage, and this cannot/should not happen unless such core
is allowing threads to run on that stage. Iff that happens, then we do
need the companion core to do whatever it takes to switch us back to the
in-band execution stage, so that we can run the recovery code. So, if
CONFIG_DOVETAIL=n, we should never have to mark an entry. If we do, then
we have a serious problem, because that would mean that we trapped over
the oob stage when handling an IRQ. In this case, mark_trap_entry()
returning false would bypass the recovery code, which would not help.

IOW, I believe that any injecting of mark_trap_entry() and friends
should happen in a separate commit, so that it is possible to debug the
pipeline core without any interaction from such code, so that any
suspicion that introducing such code might cause a problem is ruled out.

>  	if (show_unhandled_signals && unhandled_signal(tsk, signo)
>  	    && printk_ratelimit()) {
>  		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
> @@ -127,6 +153,8 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
>  	}
>  
>  	force_sig_fault(signo, code, (void __user *)addr);
> +
> +	mark_trap_exit(signo, regs);
>  }
>  
>  static void do_trap_error(struct pt_regs *regs, int signo, int code,
> @@ -137,6 +165,12 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
>  	if (user_mode(regs)) {
>  		do_trap(regs, signo, code, addr);
>  	} else {
> +		/*
> +		 * Dovetail: If we trapped from kernel space, either
> +		 * we can fix up the situation, or we can't and we may
> +		 * happily crash with hard irqs off. Either way, don't
> +		 * bother.
> +		 */
>  		if (!fixup_exception(regs))
>  			die(regs, str);
>  	}
> @@ -176,9 +210,19 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
>  
>  	if (user_mode(regs)) {
>  		irqentry_enter_from_user_mode(regs);
> -		local_irq_enable();
> +
> +		if (running_inband())
> +			local_irq_enable_full();
> +		else
> +			hard_local_irq_enable();
>  
>  		handled = riscv_v_first_use_handler(regs);
> +
> +		if (running_inband())
> +			local_irq_disable_full();
> +		else
> +			hard_local_irq_disable();
> +
>  		if (!handled)
>  			do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
>  				      "Oops - illegal instruction");
> @@ -373,7 +417,10 @@ asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
>  
>  	handle_page_fault(regs);
>  
> -	local_irq_disable();
> +	if (running_inband())
> +		local_irq_disable_full();
> +	else
> +		hard_local_irq_disable();
>  
>  	irqentry_exit(regs, state);
>  }
> @@ -383,13 +430,19 @@ static void noinstr handle_riscv_irq(struct pt_regs *regs)
>  {
>  	struct pt_regs *old_regs;
>  
> -	irq_enter_rcu();
> -	old_regs = set_irq_regs(regs);
> -	handle_arch_irq(regs);
> -	set_irq_regs(old_regs);
> -	irq_exit_rcu();
> +	if (irqs_pipelined()) {
> +		handle_irq_pipelined(regs);
> +	} else {
> +		irq_enter_rcu();
> +		old_regs = set_irq_regs(regs);
> +		handle_arch_irq(regs);
> +		set_irq_regs(old_regs);
> +		irq_exit_rcu();
> +	}
>  }
>  
> +extern void (*handle_arch_irq)(struct pt_regs *);
> +
>  asmlinkage void noinstr do_irq(struct pt_regs *regs)
>  {
>  	irqentry_state_t state = irqentry_enter(regs);
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 04ed6f8acae4..d64d01874a79 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -25,6 +25,52 @@
>  
>  #include "../kernel/head.h"
>  
> +#ifdef CONFIG_IRQ_PIPELINE
> +/*
> + * We need to synchronize the virtual interrupt state with the hard
> + * interrupt state we received on entry, then turn hardirqs back on to
> + * allow code which does not require strict serialization to be
> + * preempted by an out-of-band activity.
> + */
> +static inline
> +unsigned long fault_entry(struct pt_regs *regs)
> +{
> +	unsigned long flags;
> +
> +	flags = hard_local_save_flags();
> +
> +	if (raw_irqs_disabled_flags(flags)) {
> +		stall_inband();
> +		trace_hardirqs_off();
> +	}
> +
> +	hard_local_irq_enable();
> +
> +	if (running_inband())
> +		local_irq_enable();
> +
> +	return flags;
> +}
> +
> +static inline void fault_exit(unsigned long flags)
> +{
> +	WARN_ON_ONCE(irq_pipeline_debug() && hard_irqs_disabled());
> +
> +	hard_local_irq_restore(flags);
> +}
> +
> +#else	/* !CONFIG_IRQ_PIPELINE */
> +
> +static inline
> +unsigned long fault_entry(struct pt_regs *regs)
> +{
> +	return 0;
> +}
> +
> +static inline void fault_exit(unsigned long x) { }
> +
> +#endif	/* !CONFIG_IRQ_PIPELINE */
> +
>  static void show_pte(unsigned long addr)
>  {
>  	pgd_t *pgdp, pgd;
> @@ -79,6 +125,7 @@ static void show_pte(unsigned long addr)
>  static void die_kernel_fault(const char *msg, unsigned long addr,
>  		struct pt_regs *regs)
>  {
> +	irq_pipeline_oops();
>  	bust_spinlocks(1);
>  
>  	pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n", msg,
> @@ -315,8 +362,8 @@ void handle_page_fault(struct pt_regs *regs)
>  	}
>  
>  	/* Enable interrupts if they were enabled in the parent context. */
> -	if (!regs_irqs_disabled(regs))
> -		local_irq_enable();
> +	if (!regs_irqs_disabled(regs) && running_inband())
> +		local_irq_enable_full();
>  
>  	/*
>  	 * If we're in an interrupt, have no user context, or are running
> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
> index 0bdd9d7ec545..5345e4d373ac 100644
> --- a/drivers/clocksource/timer-clint.c
> +++ b/drivers/clocksource/timer-clint.c
> @@ -243,7 +243,11 @@ static int __init clint_timer_init_dt(struct device_node *np)
>  	}
>  
>  #ifdef CONFIG_SMP
> +#ifdef CONFIG_IRQ_PIPELINE
> +	rc = ipi_mux_create(PIPELINED_IPI_MAX, clint_send_ipi);
> +#else
>  	rc = ipi_mux_create(BITS_PER_BYTE, clint_send_ipi);
> +#endif
>  	if (rc <= 0) {
>  		pr_err("unable to create muxed IPIs\n");
>  		rc = (rc < 0) ? rc : -ENODEV;
> @@ -251,7 +255,11 @@ static int __init clint_timer_init_dt(struct device_node *np)
>  	}
>  
>  	irq_set_chained_handler(clint_ipi_irq, clint_ipi_interrupt);
> +#ifdef CONFIG_IRQ_PIPELINE
> +	riscv_ipi_set_virq_range(rc, PIPELINED_IPI_MAX);
> +#else
>  	riscv_ipi_set_virq_range(rc, BITS_PER_BYTE);
> +#endif
>  	clint_clear_ipi();
>  #endif

-- 
Philippe.
