Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4022B8A9
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111811; cv=none; b=SUC6i6zb/GBS5FkwV5uwg/JANQiFv5QLfnG17v8pzyI65N6tMVYi1DtraRnJRTIPqlAup5IJdIj6C/2GZTsg6951JF8wbmIyc7SqO/OluNZPBUS/chMct+CQ6O7caAU1AYIoEED9pUe7Nkuqpov0Yx9ZGUkSCKXdV5esG96hzTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111811; c=relaxed/simple;
	bh=s0AylVCEkxhP91FJjKVZvmQBOp3KsFW1n5Jto7ZOBqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AIKTKqb1ClZnf9vJwZYR0eSFkZv3SE7R7GOyJVFTS4fgodaqgW9aXf4ygNu4kcjF1ewNq3Y9WO52oSHIOSdOn/IkYi/OOJo1nhsXIdbNwz5WMurKjrcx2w86YiyCIUwhH8jHN5l+XEd++oSR2xGPHhjvUl3PaWJKBDO8zLk0Jso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=IvQa6Seo; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="IvQa6Seo"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CDC71443C4;
	Thu, 22 Jan 2026 19:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1769111808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T9NVnSk6yhxzLDdKAAGMdn8pRR58+od+L0s6W2gQruA=;
	b=IvQa6Seon8/KmMj/nWsyk0BPur+yF+P8/SNiUNI5Fs6uzZMWBnxunzg2upclCFzJt9j8Kf
	hB19eA3q4FMJFZJ1McBujN7yVSbONCxdwSXy9ul1SvVxQEvKe0OhefYj1Ni/OcZQzbqJyg
	ANmzgQrSaReIOOYEN5E+1ymMwUgW+Zlq7/Q0SA8btTjsou/o5HdysPpXImMxot0EWvot+S
	259Wao+zcqTi/8JMSM75jjCITv6cMekV2XY8ghukYvVVC3A8dP/5J7Cy9/9bsPrkBr0r9t
	l88+AUoVGlFh7UFznMTmK6ZNkFE2WxQtdaQhu+JuISqW3PipSTaSDepfPl+Y0g==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH dovetail v4 10/12] riscv: add initial dovetail co-kernel
 skeleton
In-Reply-To: <20260122102304.421957-11-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Thu, 22 Jan 2026 11:23:02 +0100")
References: <20260122102304.421957-1-tobias.schaffner@siemens.com>
	<20260122102304.421957-11-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 22 Jan 2026 20:56:47 +0100
Message-ID: <87a4y5ifpc.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejtdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepveffveejudeggeefveegpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepthhosghirghsrdhstghhrghffhhnvghrsehsihgvmhgvnhhsrdgtohhm
X-GND-State: clean
X-GND-Score: -100


This patch is specific to CONFIG_DOVETAIL=y, so this should go to
"riscv: dovetail: add core support".

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  arch/riscv/Kconfig                   |  2 ++
>  arch/riscv/include/asm/dovetail.h    | 23 +++++++++++++++++++++++
>  arch/riscv/include/asm/mmu_context.h |  4 ++++
>  arch/riscv/include/asm/syscall.h     |  6 ++++++
>  arch/riscv/include/asm/thread_info.h |  8 ++++++++
>  5 files changed, 43 insertions(+)
>  create mode 100644 arch/riscv/include/asm/dovetail.h
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e93a0b6f9f2b..abec407aced5 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -149,6 +149,7 @@ config RISCV
>  	select HAVE_ARCH_USERFAULTFD_MINOR if 64BIT && USERFAULTFD
>  	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
>  	select HAVE_IRQ_PIPELINE
> +	select HAVE_DOVETAIL
>  	select HAVE_ASM_MODVERSIONS
>  	select HAVE_CONTEXT_TRACKING_USER
>  	select HAVE_DEBUG_KMEMLEAK
> @@ -377,6 +378,7 @@ config AS_HAS_OPTION_ARCH
>  
>  source "arch/riscv/Kconfig.socs"
>  source "arch/riscv/Kconfig.errata"
> +source "kernel/Kconfig.dovetail"
>  
>  menu "Platform type"
>  
> diff --git a/arch/riscv/include/asm/dovetail.h b/arch/riscv/include/asm/dovetail.h
> new file mode 100644
> index 000000000000..bb342e9eb18a
> --- /dev/null
> +++ b/arch/riscv/include/asm/dovetail.h
> @@ -0,0 +1,23 @@
> +/*
> +* SPDX-License-Identifier: GPL-2.0
> +*
> +* Copyright (C) 2024 Tobias Schaffner
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
> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
> index 8c4bc49a3a0f..444136d7b253 100644
> --- a/arch/riscv/include/asm/mmu_context.h
> +++ b/arch/riscv/include/asm/mmu_context.h
> @@ -38,6 +38,10 @@ static inline int init_new_context(struct task_struct *tsk,
>  	return 0;
>  }
>  
> +static inline void
> +switch_oob_mm(struct mm_struct *prev, struct mm_struct *next,
> +	      struct task_struct *tsk) { }
> +
>  DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
>  
>  #ifdef CONFIG_RISCV_ISA_SUPM
> diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
> index 34313387f977..6ae989aafbcd 100644
> --- a/arch/riscv/include/asm/syscall.h
> +++ b/arch/riscv/include/asm/syscall.h
> @@ -117,6 +117,12 @@ static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
>  	return false;
>  }
>  
> +static inline unsigned long syscall_get_arg0(struct task_struct *task,
> +					     struct pt_regs *regs)
> +{
> +	return regs->orig_a0;
> +}
> +
>  asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
>  
>  asmlinkage long sys_riscv_hwprobe(struct riscv_hwprobe *, size_t, size_t,
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> index 9e4c9b884b5a..6c40e29f6445 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -41,6 +41,7 @@
>  
>  #include <asm/processor.h>
>  #include <asm/csr.h>
> +#include <dovetail/thread_info.h>
>  
>  /*
>   * low level task data that entry.S needs immediate access to
> @@ -77,6 +78,7 @@ struct thread_info {
>  	 */
>  	unsigned long		a0, a1, a2;
>  #endif
> +	struct oob_thread_state oob_state;      /* co-kernel thread state */
>  };
>  
>  #ifdef CONFIG_SHADOW_CALL_STACK
> @@ -120,6 +122,9 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>  
>  #include <asm-generic/thread_info_tif.h>
>  
> +#define TIF_MAYDAY			14      /* emergency trap pending */
> +#define _TIF_MAYDAY			(1 << TIF_MAYDAY)
> +
>  #define TIF_32BIT			16	/* compat-mode 32bit process */
>  #define TIF_RISCV_V_DEFER_RESTORE	17	/* restore Vector before returing to user */
>  
> @@ -129,5 +134,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>   * Local (synchronous) thread flags.
>   */
>  #define _TLF_OOB		0x0001
> +#define _TLF_DOVETAIL		0x0002
> +#define _TLF_OFFSTAGE		0x0004
> +#define _TLF_OOBTRAP		0x0008
>  
>  #endif /* _ASM_RISCV_THREAD_INFO_H */

-- 
Philippe.
