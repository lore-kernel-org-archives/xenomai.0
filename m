Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B631B1D73
	for <xenomai@lists.linux.dev>; Wed, 21 Aug 2024 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251921; cv=none; b=gfyqWoJRt559uRvr/vpBdayHKT6UlzdXqs1Lj+8/uR74FvdqQ6S7McWLXM8EoOns/lqRq6xUzTYpfeu6CKlEGM2g2FNkbInhUA7e86FtvOtMShS2RnkVw5le9x/tgtC+ndAX53HgdjugjDZS3IWVBEknVr0e82GpXgG17A7kpCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251921; c=relaxed/simple;
	bh=EqlHsbK/q4SLuroJstoa8me5/dzO+1SgIedTHvUGcz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RZ5oA9h/QNXwP2sbC1kbTkWW8FKdFyOCN1Djjv2BGoyJDSSL6CKLeJmqTVEjJv9zOnMnnv9yLDkbaPVEbxPF0B85tTncJM/aUIUC4OhgupeyiHo4rbk7R7v+wrFyGvFGCeaOKqXqgwxS/+O5c5ex24OLKZdLk+2qVyv/g+Owf6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-371ba7e46easo1985704f8f.0
        for <xenomai@lists.linux.dev>; Wed, 21 Aug 2024 07:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724251918; x=1724856718;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1GQTNgB2K+06C3Fx68LqQHSvu597j/IJipDL/8hNxc=;
        b=jjNtHn7AeSNCkgqwdxrKZLGzA1soIvFwD2Zf1Bbe1cby6T9O31WbD5tBalu1WLEcwB
         X+wIlXS4B4iwoIoNlX6mQyfwnwhnsytG0AFaLRJHSC7BmrHCGBF+hPgKS0RE/AKV3D4c
         qFBOVoU0dk1urlQUrr5F30iIVezLb0OR+1KaxuhrXmBPJWuQlKrCib2Zxtw15L4ibOQ0
         KdGM786XB/b2rQ9ooyurFdole8NQ2+hkEWAJ8blNIzfmQw0AbVcfzB5vr9e8vyt6Rjim
         pfQC/Pinzn0lAepyJ1hVjYkp0A4tniVFFYm7dqQCQN7LycuHT3fNlMXXo33o/0wc3ii+
         7t0g==
X-Gm-Message-State: AOJu0YynoiQbKau7wxhrJSskMD5QKJtXxgs7cPc0s226d6oKYqPWuBZJ
	yMwGp+SMCk8yHahvcWWapveEYIm5a/Viyq4RiJ7OdlULrJxKe+le
X-Google-Smtp-Source: AGHT+IFR05BaOCFxlqH2pWM1akofvkKY363h29maeI0U1yuSilwbXnEYh1fYPCc+UbT3bPndxeF9Ow==
X-Received: by 2002:adf:f5d1:0:b0:371:8a90:112f with SMTP id ffacd0b85a97d-372fd70c777mr1432627f8f.44.1724251917435;
        Wed, 21 Aug 2024 07:51:57 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abef81a5esm28124835e9.28.2024.08.21.07.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:51:56 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Ionut Nechita <ionut.nechita@intel.com>
Subject: Re: [PATCH RFC dovetail 6.11,6.10] x86: dovetail: Allow
 CONFIG_ACRN_GUEST and CONFIG_KVM_GUEST at the same time
In-Reply-To: <20240821-flo-6-10-fix-kvm-acrn-both-active-v1-1-7473ea13b638@siemens.com>
	(Florian Bezdeka's message of "Wed, 21 Aug 2024 15:35:24 +0200")
References: <20240821-flo-6-10-fix-kvm-acrn-both-active-v1-1-7473ea13b638@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 21 Aug 2024 16:51:52 +0200
Message-ID: <87y14qgc8n.fsf@xenomai.org>
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
> We hook into the sysvec_install() macro and call a dovetail specific
> pipelined_sysvec_install(). This way we get informed about the init
> phase of HV guest code and handle all hypervisors the same way.
>
> The trampoline function (pipeline_hv_callback()) is needed to statisfy
> type checks done by run_sysvec_on_irqstack_cond().
>
> Link: https://lore.kernel.org/xenomai/PH0PR11MB59498BE915597AEF0B5BBB30F4B42@PH0PR11MB5949.namprd11.prod.outlook.com/
> Reported-by: Ionut Nechita <ionut.nechita@intel.com>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Hi all,
>
> this is my first try to fix the build error shown in patch 1 that
> appears when both CONFIG_ACRN_GUEST and CONFIG_KVM_GUEST are active.
>
> This patch (series) applies to recent dovetail versions only. I tested 6.11,
> 6.10 and 6.9. LTS versions (like 6.6, 6.1 and below) would require a
> backport. The FRED support added in recent version makes a difference
> here.

Dovetail does not support the FRED extension (ATM at least).

>
> Feedback welcome...

The logic looks fine to me, some nitpicking below:

> ---
>  arch/x86/include/asm/idtentry.h |  9 +++++++++
>  arch/x86/kernel/irq_pipeline.c  | 19 +++++++++----------
>  2 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index 524cb93afc34..3107f2cbf7f8 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -235,6 +235,12 @@ __visible __noreturn void __##func(struct pt_regs *regs)
>  #define DEFINE_IDTENTRY_SYSVEC_SIMPLE_PIPELINED(vector, func)		\
>  	DEFINE_IDTENTRY_SYSVEC_PIPELINED(vector, func)
>  
> +extern void (*pipelined_hv_callback_fn)(struct pt_regs *regs);
> +static inline void pipelined_sysvec_install(int vector, const void
> *function)

s/pipelined_sysvec_install/pipelined_install_sysvec/

to align with what seems to be the common naming (e.g. fred_install_sysvec).

> +{
> +	if (vector == HYPERVISOR_CALLBACK_VECTOR)
> +		pipelined_hv_callback_fn = function;
> +}
>  #else  /* !CONFIG_IRQ_PIPELINE */
>  
>  #define DECLARE_IDTENTRY_SYSVEC_PIPELINED(vector, func)		DECLARE_IDTENTRY_SYSVEC(vector, func)
> @@ -274,6 +280,8 @@ __visible noinstr void func(struct pt_regs *regs,			\
>  									\
>  static noinline void __##func(struct pt_regs *regs, u32 vector)
>  
> +#define pipelined_sysvec_install(vector, function)
> +
>  #endif	/* !CONFIG_IRQ_PIPELINE */
>  
>  /**
> @@ -523,6 +531,7 @@ static inline void fred_install_sysvec(unsigned int vector, const idtentry_t fun
>  #endif
>  
>  #define sysvec_install(vector, function) {				\
> +        pipelined_sysvec_install(vector, __##function);			\
>  	if (cpu_feature_enabled(X86_FEATURE_FRED))			\
>  		fred_install_sysvec(vector, function);			\
>  	else								\
> diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
> index 73e97fba55e7..21e40eafd9d5 100644
> --- a/arch/x86/kernel/irq_pipeline.c
> +++ b/arch/x86/kernel/irq_pipeline.c
> @@ -14,6 +14,8 @@
>  #include <asm/mshyperv.h>
>  #include <asm/idtentry.h>
>  
> +void (*pipelined_hv_callback_fn)(struct pt_regs *regs) = NULL;
> +
>  static struct irq_domain *sipic_domain;
>  
>  static void sipic_irq_noop(struct irq_data *data) { }
> @@ -76,6 +78,12 @@ static void pipeline_exit_rcu(irqentry_state_t state)
>  		ct_irq_exit();
>  }
>  
> +static void pipeline_hv_callback(struct pt_regs *regs)
> +{
> +	if (pipelined_hv_callback_fn)

Is there any way we could have no callback set there? We are interposing
at the earliest possible code spot already, i.e. where vectors are
installed. So either we do have a vector set when receiving
HYPERVISOR_CALLBACK_VECTOR, or the arch code did not install any handler
for that vector in the first place, and we should never receive such
trap. At any rate, ignoring the event looks wrong.

> +		pipelined_hv_callback_fn(regs);
> +}
> +

-- 
Philippe.
