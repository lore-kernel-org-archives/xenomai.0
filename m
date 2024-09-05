Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD58519AA63
	for <xenomai@lists.linux.dev>; Thu,  5 Sep 2024 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552367; cv=none; b=QQpkg6V5NwnLd3ENuUqKzdY//18l3hPW1YCNrApJL4vLdtKlOdAnlLtSHLNLrYYT0WS0AFEyeNoErF0lzKo/jT7X4dA8WDG877saal3QNg0VbeRxIOfLgjna+F2QxFefuTuSCfzdHo4V8b56YODCOhwnfYHQ97wZmzDxauyuO9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552367; c=relaxed/simple;
	bh=9OwGLrYQOzk37/r2JNzI1o/gvBGIhX/Z6gkUxBY1YVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VbLalEV4cCcnmFtemtyg4ivkQvaiSJ34mSBhwXSPXpN5oTXKikYYu7edFhmVbmyD7owr65J//YMIZ5v9SO3gnb/4RlBsNySguP6IyoNUyBiKKTnzXIj/zuFLdi4RyXjgVQ3p+GJnx4zVdWu3oYXYwE9Rsfnvjp3UiDC1VSEp8PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53654e2ed93so751913e87.0
        for <xenomai@lists.linux.dev>; Thu, 05 Sep 2024 09:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725552364; x=1726157164;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYNPeFnW6BtUIkzQCZEfRNM34C2bk/Hs4CbC1TIAGro=;
        b=tmeZkQFpbzFXDAzo2guWnTS4sA7v6Ggr3vXqqcSo2QXS3yHY2SQrVSvmEpN+ofjFKx
         MKvxaDOX3gQ5tfbBrFwM5BNXPwU2h9U8/ZP0WVeiLWunTaP6dW4e+SUHhe4pAi6DD0TB
         C+zJulRdYatwug3KlLcyRv0ajfhnsMr0gzsc/igAxwee/hnruofFXnmo1j9C3/g5QFAT
         7gtcwVT9N+5eubcBg/nmzD+xP4inAaj5S8vAKClUkfsmKlOE3fos2vcESsYjVMrCqbi6
         2gcTY0WrHjzIGvrYIKv6O6eWjbsv5R+1TELYGN5kM/aUFI+dKUYwteueWbouyM/dqJzv
         WNrw==
X-Gm-Message-State: AOJu0Yx5BLO67/fpbXmhLKzk7jIJlXOnwbA5PrjCQ1ow52YldJaNFNsY
	hwlKIQX70ceAyZjyILuYMCYUkxBmXgAld8ISuSstm1680rDw1woV
X-Google-Smtp-Source: AGHT+IFlB327GvkrLIFasGZT/qmnKxGqs2tUFfd66GMyYDyZoHF8/xdy4Z7kW1HC5fQlHDuR17/4bw==
X-Received: by 2002:ac2:4c4e:0:b0:52c:842b:c276 with SMTP id 2adb3069b0e04-53546bb303amr14645016e87.53.1725552363565;
        Thu, 05 Sep 2024 09:06:03 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639d512sm269808775e9.18.2024.09.05.09.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 09:06:02 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>,  Ionut
 Nechita <ionut.nechita@intel.com>
Subject: Re: [PATCH dovetail 6.10] x86: dovetail: Allow multiple HV guest
 extensions to be enabled
In-Reply-To: <20240823091858.3355791-1-florian.bezdeka@siemens.com> (Florian
	Bezdeka's message of "Fri, 23 Aug 2024 11:18:54 +0200")
References: <20240823091858.3355791-1-florian.bezdeka@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Thu, 05 Sep 2024 18:06:02 +0200
Message-ID: <87jzfqxez9.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> do_sysvec_inband() assumed that only one of CONFIG_ACRN_GUEST and
> CONFIG_KVM_GUEST is active at the same time. If both were enabled we
> run into a compile issue:
>
> arch/x86/kernel/irq_pipeline.c: In function 'do_sysvec_inband':
> arch/x86/kernel/irq_pipeline.c:160:9: error: duplicate case value
>    160 |         case HYPERVISOR_CALLBACK_VECTOR:
>        |         ^~~~
> arch/x86/kernel/irq_pipeline.c:154:9: note: previously used here
>    154 |         case HYPERVISOR_CALLBACK_VECTOR:
>        |         ^~~~
>
> As only one hypervisor (HV) can be active at the same time, but support
> for more than one can be compiled in, we have to migrate from a build
> time decision to a runtime based one.
>
> We introduce sysvec_install() macro - like modern kernels already do -
> and call a dovetail specific pipelined_sysvec_install() before
> registering the IDT gate.
>
> All HYPERVISOR_CALLBACK_VECTOR related callsites of alloc_intr_gate()
> have been migrated to sysvec_install(). sysvec_install() is able to
> distinguish between the low level entry point (asm_ variant) and the
> higher entry point (__ variant).
>
> The trampoline function (pipeline_hv_callback()) is needed to statisfy
> type checks done by run_sysvec_on_irqstack_cond().
>
> Reported-by: Ionut Nechita <ionut.nechita@intel.com>
> Closes: https://lore.kernel.org/xenomai/PH0PR11MB59498BE915597AEF0B5BBB30F4B42@PH0PR11MB5949.namprd11.prod.outlook.com/
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>
> Hi all,
>
> changes compared to the RFC:
> - Changed title
> - Some renamings, mainly taking care of the feedback provided by
>   Philippe
> - Added backports for all dovetail/Linux LTS versions
>
> All patches are build tested and runtime tested for KVM guests. I have
> no other HV / VMM at hand.
>
> Ionut, it would be very nice if you could test at least one version for
> ACRN. Thanks!
>
> Best regards,
> Florian
>
>  arch/x86/include/asm/idtentry.h | 10 ++++++++++
>  arch/x86/kernel/irq_pipeline.c  | 18 ++++++++----------
>  2 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index 524cb93afc34..e7d434e2ace0 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -235,6 +235,13 @@ __visible __noreturn void __##func(struct pt_regs *regs)
>  #define DEFINE_IDTENTRY_SYSVEC_SIMPLE_PIPELINED(vector, func)		\
>  	DEFINE_IDTENTRY_SYSVEC_PIPELINED(vector, func)
>  
> +extern void (*pipeline_hv_callback_fn)(struct pt_regs *regs);
> +static inline void pipeline_install_sysvec(int vector, const void *function)
> +{
> +	if (vector == HYPERVISOR_CALLBACK_VECTOR)
> +		pipeline_hv_callback_fn = function;
> +}
> +
>  #else  /* !CONFIG_IRQ_PIPELINE */
>  
>  #define DECLARE_IDTENTRY_SYSVEC_PIPELINED(vector, func)		DECLARE_IDTENTRY_SYSVEC(vector, func)
> @@ -274,6 +281,8 @@ __visible noinstr void func(struct pt_regs *regs,			\
>  									\
>  static noinline void __##func(struct pt_regs *regs, u32 vector)
>  
> +static inline void pipeline_install_sysvec(vector, function) {}
> +
>  #endif	/* !CONFIG_IRQ_PIPELINE */
>  
>  /**
> @@ -523,6 +532,7 @@ static inline void fred_install_sysvec(unsigned int vector, const idtentry_t fun
>  #endif
>  
>  #define sysvec_install(vector, function) {				\
> +	pipeline_install_sysvec(vector, __##function);			\
>  	if (cpu_feature_enabled(X86_FEATURE_FRED))			\
>  		fred_install_sysvec(vector, function);			\
>  	else								\
> diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
> index 73e97fba55e7..7a64af5dab73 100644
> --- a/arch/x86/kernel/irq_pipeline.c
> +++ b/arch/x86/kernel/irq_pipeline.c
> @@ -14,6 +14,8 @@
>  #include <asm/mshyperv.h>
>  #include <asm/idtentry.h>
>  
> +void (*pipeline_hv_callback_fn)(struct pt_regs *regs) = NULL;
> +
>  static struct irq_domain *sipic_domain;
>  
>  static void sipic_irq_noop(struct irq_data *data) { }
> @@ -76,6 +78,11 @@ static void pipeline_exit_rcu(irqentry_state_t state)
>  		ct_irq_exit();
>  }
>  
> +static void pipeline_hv_callback(struct pt_regs *regs)
> +{
> +	pipeline_hv_callback_fn(regs);
> +}
> +
>  static void do_sysvec_inband(struct irq_desc *desc, struct pt_regs *regs)
>  {
>  	unsigned int irq = irq_desc_get_irq(desc);
> @@ -150,18 +157,9 @@ static void do_sysvec_inband(struct irq_desc *desc, struct pt_regs *regs)
>  					regs);
>  		break;
>  #endif
> -#ifdef CONFIG_ACRN_GUEST
>  	case HYPERVISOR_CALLBACK_VECTOR:
> -		run_sysvec_on_irqstack_cond(__sysvec_acrn_hv_callback,
> -					regs);
> +		run_sysvec_on_irqstack_cond(pipeline_hv_callback, regs);
>  		break;
> -#endif
> -#ifdef CONFIG_KVM_GUEST
> -	case HYPERVISOR_CALLBACK_VECTOR:
> -		run_sysvec_on_irqstack_cond(__sysvec_kvm_asyncpf_interrupt,
> -					    regs);
> -		break;
> -#endif
>  	case LOCAL_TIMER_VECTOR:
>  		run_sysvec_on_irqstack_cond(__sysvec_apic_timer_interrupt,
>  					regs);

6.1.y, 6.6.y and 6.10 series merged, thanks.

-- 
Philippe.
