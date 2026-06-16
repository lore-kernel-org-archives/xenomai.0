Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C930FC23
	for <xenomai@lists.linux.dev>; Tue, 16 Jun 2026 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592641; cv=none; b=iBBl/RJ6Jay6AsVBvZ7LHIXl0uOGTsb9dT5TH659+vuZk6sQf2HZAucalAbm1AX3XQ773M6AEFzD3R/+bujeHGBKlKbu5d0foHSvKIAayd0Tjx7Di28jtov6N7IXf71ACwA4W0WH8NXgYq+zCSbbijm2jphcZvJE//XPFRL/28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592641; c=relaxed/simple;
	bh=N8zwZ5ZtBLfxio7uxr+RikB2q/OC9mHYQoQzBx4k2D4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DTwtKn8mPrkrnJ5UHuMiypSFCG1yaeBJai8OM+flYHVmcr4ryrSvPyfMub7bIwmvzK4e60PZa3ER+8lnxynCgbBmEHx2FdjBvaSzbyaJLJIOvsw0gElUig8lMNF3VBdWMKN+mrudT2w+13mrkyZ78NIuT5Vd61JX1TsULynuZWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=VdvIN362; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="VdvIN362"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 056B43F569;
	Tue, 16 Jun 2026 06:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781592637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I53DEja5p8bZ3l9ULsUOZrflFiXDULBMHzNyTTqAKhQ=;
	b=VdvIN362dciFVW8TQmimneJYEIf+RWzFY9tLBYaIuXKSISJqmwvN4DTbKIGqJGRNhQGSYK
	IzYjZ5RI9Bz1dNajSxtv5YONKwr+ImrchPAwuDy2co1wIgRtFcTuApX7RFR0V8z6UwpNbZ
	V6r1NlaGJ1gxbgrK3egYFrmGrxxLs1FFET0c1J4RLGOveEegY4ip89MIJ+SkParMvZGQbz
	7HiSSFGel3n98I3MWcJKPkjLwgdkB4AWxVZtuacjNvhM+z+3aW4/9INr+XMdI0XCD/PFZ5
	2b5b6Nn5gk4+I68VxL1syaPg5D4HM7zPkjTsYQjnpbpR0KC8djj+vqqOiwQH/Q==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH RFC Dovetail 7.1] arm64: irq_pipeline: 7.1 specific
 adjustments
In-Reply-To: <0a76369a44e33ca1c8c27c5c2690770b4668be7c.camel@siemens.com>
	(Florian Bezdeka's message of "Thu, 11 Jun 2026 15:46:44 +0200")
References: <20260611134057.2267177-1-florian.bezdeka@siemens.com>
	<0a76369a44e33ca1c8c27c5c2690770b4668be7c.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 16 Jun 2026 08:50:36 +0200
Message-ID: <87qzm7ou6b.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTFbwRY7WJi9L8gjzG8FSceunpHdHla6ZERrMnakbHN//sa2sRfU3MYMUZRcAJw92fp8kZl6IWU1ABjGxBFrQ/QOEcSOjs0NiwqlPQ8BPmCz5KcBuPVW+CJMXr/q0TTW6iLwQPMAMSoHh26HKJvktfJpxkM18ScDsb3RwXMaJ9sYzYSP/f8/TuvhBWinxP7lqoxJm1UiBplYoIgPPOdQi1Ub+IFNXVDB1s0WrUGPxHrxphF4JDUrfTm8btTmH7z2wkqiFp46YGGY+VDcM8ZPUu3iYcKNsYWcn5hUNrtYpfKMj1cf8G0Gt18h4nzO6NylER08IAcXDWflHC3F5YU8Rg56D1QbYEyIgkd2DubkOK+boh7Y8a6nm0OOOO0rxV23Biam3+jPWDLJo8urafqh9MBxkpaO1KpK4uVJgMEKqmiJoYLnQwrDoR/61X3Bcj3T0/+uGzZOMTiukHV7qdNm1wBcabwGupRQ+IzU1ii4mOCYRp5foZd6S6t0uEB19fon/Ir1tzLmtkeK/K97hjNkgxOT4WZ2U59GiQ5v7sehMQ2zlQwFY8O1tvNGMI6YlbtEqxcapu2+zjsbcza0buPKJmiXe3MrkXn5RZ4LuBlFLc0uJrZbMJoEdbr/NodHh4C6KgWhiUx1/Cf9aLdFNOPm4VQMZ2XWD5nmQ+zRl0wyf5kOMA
X-GND-State: clean
X-GND-Score: -100

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Thu, 2026-06-11 at 15:40 +0200, Florian Bezdeka wrote:
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>> 
>> Hi Philippe,
>> 
>> final tests are still running but the local tests are looking good.
>> The EVL testsuite triggered a WARN_ONCE() - see process.c below - which
>> caused the systems to hang.
>> 
>> Turned out the arm64 entry code got some refactorings that needed some
>> adjustments - pipline wise.
>> 
>> I would fold the following into 7.1, so could you please double check?
>> Thanks!
>> 
>>  arch/arm64/kernel/entry-common.c | 35 ++++++++++++++++++++++++++++----
>>  arch/arm64/kernel/process.c      |  6 +++---
>>  include/linux/irq-entry-common.h |  3 +++
>>  3 files changed, 37 insertions(+), 7 deletions(-)
>> 
>> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
>> index b0e141266349..97f6d6904a5d 100644
>> --- a/arch/arm64/kernel/entry-common.c
>> +++ b/arch/arm64/kernel/entry-common.c
>> @@ -166,7 +166,16 @@ static noinstr irqentry_state_t arm64_enter_from_kernel_mode(struct pt_regs *reg
>>  static void noinstr arm64_exit_to_kernel_mode(struct pt_regs *regs,
>>  					      irqentry_state_t state)
>>  {
>> -	local_irq_disable();
>> +	if (irqs_pipelined()) {
>> +		hard_local_irq_disable();
>> +		if (running_inband()) {
>> +			stall_inband_nocheck();
>> +			trace_hardirqs_off();
>> +		}
>> +	} else {
>> +		local_irq_disable();
>> +	}
>> +
>>  	irqentry_exit_to_kernel_mode_preempt(regs, state);
>>  	local_daif_mask();
>>  	mte_check_tfsr_exit();
>> @@ -175,7 +184,14 @@ static void noinstr arm64_exit_to_kernel_mode(struct pt_regs *regs,
>>  
>>  static __always_inline void arm64_syscall_enter_from_user_mode(struct pt_regs *regs)
>>  {
>> -	enter_from_user_mode(regs);
>> +	if (running_inband()) {
>> +		WARN_ON_ONCE(irq_pipeline_debug() && irqs_disabled());
>> +		stall_inband_nocheck();
>> +		enter_from_user_mode(regs);
>> +		trace_hardirqs_on();
>> +		unstall_inband_nocheck();
>> +	}
>
> Should enter_from_user_mode() be called while the inband stage is
> stalled, or after unstalling?

It should be stalled on entry, to reflect the hardware state.

> The exit part is called while being
> stalled, so I kept that in sync, but I'm not 100% sure.
>

That's correct.

>> +
>>  	mte_disable_tco_entry(current);
>>  	sme_enter_from_user_mode();
>>  }
>> @@ -191,6 +207,7 @@ static __always_inline void arm64_enter_from_user_mode(struct pt_regs *regs)
>>  		WARN_ON_ONCE(irq_pipeline_debug() && irqs_disabled());
>>  		stall_inband_nocheck();
>>  		enter_from_user_mode(regs);
>> +		rseq_note_user_irq_entry();
>>  		trace_hardirqs_on();
>>  		unstall_inband_nocheck();
>>  	}
>> @@ -226,8 +243,18 @@ static __always_inline void arm64_syscall_exit_to_user_mode(struct pt_regs *regs
>>   */
>>  static __always_inline void arm64_exit_to_user_mode(struct pt_regs *regs)
>>  {
>> -	local_irq_disable();
>> -	irqentry_exit_to_user_mode_prepare(regs);
>> +	if (irqs_pipelined()) {
>> +		hard_local_irq_disable();
>> +		if (running_inband()) {
>> +			stall_inband_nocheck();
>> +			trace_hardirqs_off();
>> +			irqentry_exit_to_user_mode_prepare(regs);
>> +		}
>> +	} else {
>> +		local_irq_disable();
>> +		irqentry_exit_to_user_mode_prepare(regs);
>> +	}
>> +
>>  	local_daif_mask();
>>  	sme_exit_to_user_mode();
>>  	mte_check_tfsr_exit();
>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>> index b1eac5fd75c1..0047d0bdedd9 100644
>> --- a/arch/arm64/kernel/process.c
>> +++ b/arch/arm64/kernel/process.c
>> @@ -748,8 +748,8 @@ static inline void debug_switch_state(void)
>>  		unsigned long pmr_expected = GIC_PRIO_IRQOFF;
>>  		unsigned long pmr_actual = read_sysreg_s(SYS_ICC_PMR_EL1);
>>  
>> -		WARN_ONCE(daif_actual != daif_expected ||
>> -			  pmr_actual != pmr_expected,
>> +		WARN_ONCE(running_inband() && (daif_actual != daif_expected ||
>> +			  pmr_actual != pmr_expected),
>>  			  "Unexpected DAIF + PMR: 0x%lx + 0x%lx (expected 0x%lx + 0x%lx)\n",
>>  			  daif_actual, pmr_actual,
>>  			  daif_expected, pmr_expected);
>> @@ -757,7 +757,7 @@ static inline void debug_switch_state(void)
>>  		unsigned long daif_expected = DAIF_PROCCTX_NOIRQ;
>>  		unsigned long daif_actual = read_sysreg(daif);
>>  
>> -		WARN_ONCE(daif_actual != daif_expected,
>> +		WARN_ONCE(running_inband() && daif_actual != daif_expected,
>>  			  "Unexpected DAIF value: 0x%lx (expected 0x%lx)\n",
>>  			  daif_actual, daif_expected);
>
> That was the warning triggered by CI, that stalled the system. Is that
> expected? I'm quite sure that in the oob case the DAIF flags are
> different, but is WARN_ONCE() expected to completely halt the system?
>

WARN_ONCE() triggers a trap in the middle of the context switch
implementation, cobalt/evl are going to switch the caller to the in-band
stage in handle_oob_trap_entry(), which would cause __switch_to() calls
to pile up. So yes, this crash is definitely expected.

>
>>  	}
>> diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
>> index 58c28b2a8f2b..61a8e129e71f 100644
>> --- a/include/linux/irq-entry-common.h
>> +++ b/include/linux/irq-entry-common.h
>> @@ -600,6 +600,9 @@ irqentry_exit_to_kernel_mode_after_preempt(struct pt_regs *regs, irqentry_state_
>>  {
>>  	bool synchronized;
>>  
>> +	if (running_oob())
>> +		return;
>> +
>
> The enter/exit code moved one layer down, from irqentry_enter() to
> irqentry_enter_from_kernel_mode(), so this code needs the oob check as
> well.

Ok.

>
>>  	instrumentation_begin();
>>  	synchronized = irqentry_syncstage(state);
>>  
>> -- 
>> 2.54.0

-- 
Philippe.
