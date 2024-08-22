Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9689417E00A
	for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315581; cv=none; b=G7Up5v8ZUjbk3kq8S1h3sIN98YrJdv1/BJiqZwt4y6TfI3aXfQt8v7tr6dvgaewSwHfBcwEOtUI66RajF6arm/tCKvZdjXOQBbIXPdaoGa0M0N1o79ZvBBO3qsrHRP3aaJoubbOgH6xZGcrP2B5lv1zOgkoC/v1yFZ0oHJBJ49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315581; c=relaxed/simple;
	bh=PeWsToZ62GKDPJQwUZUiZBMm3wdEe251hKae3IKJk2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QUr+k1OnwhbU9SBTwYHKiOXfZBQl1x1jA3IjqU+ytZ83JBhtrWfxNGPcDqLWfC+qX5u+07bKVKGrLJ3lxf/2df5OdsReX54siex/FXIJAd1C8ApzuAVVrDFvBsSpavToTWVAExMMDnUUpQ9mRy7yR3tUXIp/2kt6+UBnl+pmvNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3719398eafcso234190f8f.1
        for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 01:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724315577; x=1724920377;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++qSFZsp8PtIvUi11NmX+Y2uy0+As+M0SD4T1BYXyl4=;
        b=RX3soDQsFPgtkoChNjZYOu5864BLgAm1EQGJL95L6pNFjWGAhoLUEFFhFWu39S2sRB
         5HmxkbbNrIqE79gXynqDjRGHhMpM6MWpZ4AJagOqtsxEOBONOdJgBBQXKmqMnWs2R5gF
         qsiS7cJ/VVIP1X78CU3FQxs5W20LuV0GXQMA1SoT7rR3yvI/lZ1fQ6ASCfHzGWqpr6cT
         kFKG7wHX+h5A49PAH7lnxNcwtyACIpNAupxEoC4wu+/ziqNvaXfnaWXo6ipquJGNy+fz
         unDNisQg6+UIu05W0ewxDezu70sLVD44ZzOcH4pQmUiwCixAMjT6n+zqsCsMuF+7pGoU
         PM5w==
X-Gm-Message-State: AOJu0YywA/kzgHU22JLR6V7ndkmwKnHvuTUiUhOyuajU5PIRMZJGGvSD
	vNNxtCy4lkcZn2OIwFS1Ktrl9fAcfsyjfGXlVQ5IQb7flPMCPO4w
X-Google-Smtp-Source: AGHT+IFXb8/YczOYqcHOzAIUol+9qGVjvaqfofsb4FC3Y+vTqyLjKxhF6Xb494BZq92pZckkoyTIRw==
X-Received: by 2002:a05:6000:12d2:b0:371:9121:5643 with SMTP id ffacd0b85a97d-37308bff3f1mr656464f8f.12.1724315576428;
        Thu, 22 Aug 2024 01:32:56 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c459sm1074247f8f.27.2024.08.22.01.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:32:55 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Ionut Nechita <ionut.nechita@intel.com>
Subject: Re: [PATCH RFC dovetail 6.11,6.10] x86: dovetail: Allow
 CONFIG_ACRN_GUEST and CONFIG_KVM_GUEST at the same time
In-Reply-To: <294f5d0740a0cd729ed855f46588c17a31b5e025.camel@siemens.com>
	(Florian Bezdeka's message of "Wed, 21 Aug 2024 17:05:02 +0200")
References: <20240821-flo-6-10-fix-kvm-acrn-both-active-v1-1-7473ea13b638@siemens.com>
	<87y14qgc8n.fsf@xenomai.org>
	<294f5d0740a0cd729ed855f46588c17a31b5e025.camel@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Thu, 22 Aug 2024 10:32:50 +0200
Message-ID: <87h6bdnej1.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Wed, 2024-08-21 at 16:51 +0200, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > do_sysvec_inband() assumed that only one of CONFIG_ACRN_GUEST and
>> > CONFIG_KVM_GUEST is active at the same time. If both were enabled we
>> > run into a compile issue:
>> > 
>> > arch/x86/kernel/irq_pipeline.c: In function 'do_sysvec_inband':
>> > arch/x86/kernel/irq_pipeline.c:160:9: error: duplicate case value
>> >    160 |         case HYPERVISOR_CALLBACK_VECTOR:
>> >        |         ^~~~
>> > arch/x86/kernel/irq_pipeline.c:154:9: note: previously used here
>> >    154 |         case HYPERVISOR_CALLBACK_VECTOR:
>> >        |         ^~~~
>> > 
>> > As only one hypervisor (HV) can be active at the same time, but support
>> > for more than one can be compiled in, we have to migrate from a build
>> > time decision to a runtime based one.
>> > 
>> > We hook into the sysvec_install() macro and call a dovetail specific
>> > pipelined_sysvec_install(). This way we get informed about the init
>> > phase of HV guest code and handle all hypervisors the same way.
>> > 
>> > The trampoline function (pipeline_hv_callback()) is needed to statisfy
>> > type checks done by run_sysvec_on_irqstack_cond().
>> > 
>> > Link: https://lore.kernel.org/xenomai/PH0PR11MB59498BE915597AEF0B5BBB30F4B42@PH0PR11MB5949.namprd11.prod.outlook.com/
>> > Reported-by: Ionut Nechita <ionut.nechita@intel.com>
>> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> > ---
>> > Hi all,
>> > 
>> > this is my first try to fix the build error shown in patch 1 that
>> > appears when both CONFIG_ACRN_GUEST and CONFIG_KVM_GUEST are active.
>> > 
>> > This patch (series) applies to recent dovetail versions only. I tested 6.11,
>> > 6.10 and 6.9. LTS versions (like 6.6, 6.1 and below) would require a
>> > backport. The FRED support added in recent version makes a difference
>> > here.
>> 
>> Dovetail does not support the FRED extension (ATM at least).
>
> Yep, but Linux got support for it, so the code path for recent kernels
> is a bit different and this patch does no longer apply. That was what I
> tried to express.
>

Ok.

>> 
>> > 
>> > Feedback welcome...
>> 
>> The logic looks fine to me, some nitpicking below:
>
> Thanks for the input!
>
>> 
>> > ---
>> >  arch/x86/include/asm/idtentry.h |  9 +++++++++
>> >  arch/x86/kernel/irq_pipeline.c  | 19 +++++++++----------
>> >  2 files changed, 18 insertions(+), 10 deletions(-)
>> > 
>> > diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
>> > index 524cb93afc34..3107f2cbf7f8 100644
>> > --- a/arch/x86/include/asm/idtentry.h
>> > +++ b/arch/x86/include/asm/idtentry.h
>> > @@ -235,6 +235,12 @@ __visible __noreturn void __##func(struct pt_regs *regs)
>> >  #define DEFINE_IDTENTRY_SYSVEC_SIMPLE_PIPELINED(vector, func)		\
>> >  	DEFINE_IDTENTRY_SYSVEC_PIPELINED(vector, func)
>> >  
>> > +extern void (*pipelined_hv_callback_fn)(struct pt_regs *regs);
>> > +static inline void pipelined_sysvec_install(int vector, const void
>> > *function)
>> 
>> s/pipelined_sysvec_install/pipelined_install_sysvec/
>> 
>> to align with what seems to be the common naming (e.g. fred_install_sysvec).
>> 
>
> Will do in v2. We hook into sysvec_install() so I took that pattern,
> but I agree with your suggestion.
>
>> > +{
>> > +	if (vector == HYPERVISOR_CALLBACK_VECTOR)
>> > +		pipelined_hv_callback_fn = function;
>> > +}
>> >  #else  /* !CONFIG_IRQ_PIPELINE */
>> >  
>> >  #define DECLARE_IDTENTRY_SYSVEC_PIPELINED(vector, func)		DECLARE_IDTENTRY_SYSVEC(vector, func)
>> > @@ -274,6 +280,8 @@ __visible noinstr void func(struct pt_regs *regs,			\
>> >  									\
>> >  static noinline void __##func(struct pt_regs *regs, u32 vector)
>> >  
>> > +#define pipelined_sysvec_install(vector, function)
>> > +
>> >  #endif	/* !CONFIG_IRQ_PIPELINE */
>> >  
>> >  /**
>> > @@ -523,6 +531,7 @@ static inline void fred_install_sysvec(unsigned int vector, const idtentry_t fun
>> >  #endif
>> >  
>> >  #define sysvec_install(vector, function) {				\
>> > +        pipelined_sysvec_install(vector, __##function);			\
>> >  	if (cpu_feature_enabled(X86_FEATURE_FRED))			\
>> >  		fred_install_sysvec(vector, function);			\
>> >  	else								\
>> > diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
>> > index 73e97fba55e7..21e40eafd9d5 100644
>> > --- a/arch/x86/kernel/irq_pipeline.c
>> > +++ b/arch/x86/kernel/irq_pipeline.c
>> > @@ -14,6 +14,8 @@
>> >  #include <asm/mshyperv.h>
>> >  #include <asm/idtentry.h>
>> >  
>> > +void (*pipelined_hv_callback_fn)(struct pt_regs *regs) = NULL;
>> > +
>> >  static struct irq_domain *sipic_domain;
>> >  
>> >  static void sipic_irq_noop(struct irq_data *data) { }
>> > @@ -76,6 +78,12 @@ static void pipeline_exit_rcu(irqentry_state_t state)
>> >  		ct_irq_exit();
>> >  }
>> >  
>> > +static void pipeline_hv_callback(struct pt_regs *regs)
>> > +{
>> > +	if (pipelined_hv_callback_fn)
>> 
>> Is there any way we could have no callback set there? We are interposing
>> at the earliest possible code spot already, i.e. where vectors are
>> installed. So either we do have a vector set when receiving
>> HYPERVISOR_CALLBACK_VECTOR, or the arch code did not install any handler
>> for that vector in the first place, and we should never receive such
>> trap. At any rate, ignoring the event looks wrong.
>
> I was not sure about spurious interrupts. To my understanding they
> would reach this point as well. To catch that I just made sure that at
> least one HV guest code registered the vector, otherwise we would crash
> with a NULL pointer reference.
>
> Do you still want me to remove the check?
>
> But yeah, beside that it's "impossible" that we receive this vector
> without a registration.

I agree, I can't see how we could receive an async page fault event as a
result of configuring some MSR without the hypervisor code setting that
MSR also trapping HYPERVISOR_CALLBACK_VECTOR as appropriate. With the
APIC, all spurious irqs from the xPIC logic standpoint would be notified
via the dedicated vector (0xff) IIRC. So I believe we are safe removing
that check (which looks a bit odd and confusing). One might want to turn
it into a debug assertion in order to panic, well, in a controlled
manner when dovetail_debug() is enabled, at least the code would convey
the idea that such situation is weird and unexpected.

-- 
Philippe.
