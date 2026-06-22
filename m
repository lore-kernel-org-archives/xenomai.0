Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAA33B0AE8
	for <xenomai@lists.linux.dev>; Mon, 22 Jun 2026 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136283; cv=none; b=UmYpsDv/MQv06RS5QMBee3GMKLVhOS9E5qCAZ6uejRu1mA1K4Mf/45vEAMLXVcYLmeJTrZ95jjCyEkZWAqH+NbudG1vSxxvbCfw458AWKu5cqX/lR81/EIkPKFjzvUjtekCT3AgIIpRdp0iQ4uFRrktYFJBLm/nkA2sLYE+UqEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136283; c=relaxed/simple;
	bh=lnKLWpr6ASH8G5yfOr3BKcQgffe7QWITyTGv1wBZum8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ArX0cpcm0M+K5OzHMwR5amwgdue6GRQa4383XW48RmYz25RjbUG+aHoK715xULKqBiJD2Ivt77uL23KBkeF0du07qxXRdCN9So0L5YsJb+gokAer16sqtw6cY6KOqXbvIzjXeVBeJqdtVOjYZB1bXedeclS34zYx23YIm1ZG/4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=fu5n1/XG; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="fu5n1/XG"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D44393F473;
	Mon, 22 Jun 2026 13:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1782136274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3j5QYWoOUcizUAdo1lFvCvnCQBNZ7FO/fMu59nO8ja8=;
	b=fu5n1/XGPSZ7YKuE9ITiXFmxr493S7oq5MKSuYQm17NxDy7TfpJu0R95oLX7f+caTiovgc
	V7y329ckg7N2/kftY2Q6TIkJcTodlvqRx1/+ecw/Ad7UO7BcT8qVqiwIf4KXrzbaGavKrm
	InNqFSO2jJ4o/vKkdbDDfexeC8e5d5mfBY32A8kzmZTcJl0RFCBUs1gngOOMiRCntGYn40
	S9eAI6t5kKmMhR2/cPUSqWJht7Sn0unx4aNlyQSR1woadOaVi/25W3hEfuK+eARja+KqaQ
	T6FdACodcfJE/49YizAOV6svuczTDRR2NQXW6kepfrO0FVQ1DTCDAOMwP5a6aA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>,  Tobias
 Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH Dovetail v3 3/6] arm: irq_pipeline: Fix
 dovetail_fault_{entry,exit} bypass in hw_breakpoint_pending
In-Reply-To: <14287accb71c52ee73c768e6a9b4421670cc39ec.camel@siemens.com>
	(Florian Bezdeka's message of "Mon, 22 Jun 2026 15:44:58 +0200")
References: <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-0-230f03227abb@siemens.com>
	<20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-3-230f03227abb@siemens.com>
	<14287accb71c52ee73c768e6a9b4421670cc39ec.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 22 Jun 2026 15:51:13 +0200
Message-ID: <87pl1iel9q.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTEk8hwNBupTNJgeEImEtkSqmgYu63UOiYp1TXdaRvBfTkYjRYar6AteCD3ouH8NneF75/bvFnIsS4rBBJMhpRMygIOudJ1hSUyy3ocK1VzShNLw/0lzS81LzJ75oz9ctc7hT4fS6kHygIMzp0uwnSFY1niZ3w5QQb93LHeD7HWMhW2O65xQ8TV24pO9v9ftgqu/7ElYp3sX+VjiyWpDpQReM6ZGqm/ExneACuIsdqC0ZSn/90JJ06kL7e3kzJcZTyKUDHbI+ZD4wipAV8nBSKlq0jMlh/xLJ0E21AakGlNfE8+KGXbR/35mM9y6l1d9JndTHgpmpntvYpyXewOC7mIfPL3RegoIs44z4SlIpHtCRbDiMA9qQD+AgLfyffOlHNTcIMaRMcGBG64Hjv8ZwSWXqBh8BxSuax6KArvuTqM/f1pfuHIiLCfLZjVTl1dmL1uZX5NilN1bnPWznBGobxo5sRWWC27yr2Jg0ylUGr0UMUKbN7fmeHhD2gEXMe7/s08rVu7WegErsNGvt/54eCZFBtPfRnkQ99WWfA//0Xqe3aLJRLaERuXCt01aVBeP/BSnSXaJcYFqNVY7TVGarnKvj3wMeBBMQ0g6pE/FAejW1igfiXAjMnBSYdjV/nexeoIvFF26+dbojlG5H42jJ+Ianf4MWhHM4w8HQJnKHMDHkA

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Mon, 2026-06-22 at 10:05 +0200, Florian Bezdeka wrote:
>> HW breakpoint / watchpoint handling was bypassing the
>> dovetail_fault_{entry,exit} machinery. As a result it could happen that
>> the inband IRQ mask was touched from the OOB stage.
>> 
>> There is one more problem in the HW bp/wp handling related to
>> interrupts_enabled(). This one will be fixed in a separate patch.
>> 
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>>  arch/arm/include/asm/dovetail.h         | 1 +
>>  arch/arm/include/asm/trace/exceptions.h | 3 ++-
>>  arch/arm/kernel/hw_breakpoint.c         | 6 ++++++
>>  3 files changed, 9 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm/include/asm/dovetail.h b/arch/arm/include/asm/dovetail.h
>> index 795a1fb903ec29f4c2fb7b25e70980796804acc0..eeb5d16ad032044a2587822f6b35074d664a9bbc 100644
>> --- a/arch/arm/include/asm/dovetail.h
>> +++ b/arch/arm/include/asm/dovetail.h
>> @@ -16,6 +16,7 @@
>>  #define ARM_TRAP_VFP		6	/* VFP floating point exception */
>>  #define ARM_TRAP_UNDEFINSTR	7	/* Undefined instruction */
>>  #define ARM_TRAP_ALIGNMENT	8	/* Unaligned access exception */
>> +#define ARM_TRAP_HW_BREAK	9	/* HW break or watchpoint exception */
>>  
>>  #if !defined(__ASSEMBLY__)
>>  
>> diff --git a/arch/arm/include/asm/trace/exceptions.h b/arch/arm/include/asm/trace/exceptions.h
>> index bdb666b3da4e364e0d7e33337be3e8ad8aeedb88..f0164e55efc31a4f363764d2c5c84761f3ea34d4 100644
>> --- a/arch/arm/include/asm/trace/exceptions.h
>> +++ b/arch/arm/include/asm/trace/exceptions.h
>> @@ -21,7 +21,8 @@
>>  			__trace_trap(ARM_TRAP_FPU),		\
>>  			__trace_trap(ARM_TRAP_VFP),		\
>>  			__trace_trap(ARM_TRAP_UNDEFINSTR),	\
>> -			__trace_trap(ARM_TRAP_ALIGNMENT))
>> +			__trace_trap(ARM_TRAP_ALIGNMENT),	\
>> +			__trace_trap(ARM_TRAP_HW_BREAK))
>>  
>>  DECLARE_EVENT_CLASS(ARM_trap_event,
>>  	TP_PROTO(int trapnr, struct pt_regs *regs),
>> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
>> index cd4b34c96e35e9e63e9a1ade1aeb415c22d32b00..6266380737dd88dca7fe8fde14b786a52ec42635 100644
>> --- a/arch/arm/kernel/hw_breakpoint.c
>> +++ b/arch/arm/kernel/hw_breakpoint.c
>> @@ -26,6 +26,7 @@
>>  #include <asm/current.h>
>>  #include <asm/hw_breakpoint.h>
>>  #include <asm/traps.h>
>> +#include <asm/trap_entry.h>
>>  
>>  /* Breakpoint currently in use for each BRP. */
>>  static DEFINE_PER_CPU(struct perf_event *, bp_on_reg[ARM_MAX_BRP]);
>> @@ -942,9 +943,12 @@ static void hw_breakpoint_cfi_handler(struct pt_regs *regs)
>>  static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
>>  				 struct pt_regs *regs)
>>  {
>> +	unsigned long irqflags;
>>  	int ret = 0;
>>  	u32 dscr;
>>  
>> +	irqflags = dovetail_fault_entry(ARM_TRAP_HW_BREAK, regs);
>> +
>>  	preempt_disable();
>
> Philippe, is that the right ordering or should I move the
> dovetail_fault_entry() code below the preempt_disable() call?
>
> Normally we want preemption enabled as long as possible and I couldn't
> find a reason why the oob notify mechanism needs it already disabled,
> but as always I might have missed something.
>

I don't see any reason to disable in-band preemption before handling the
fault entry, especially with a potential stage switch. The ordering you
used is correct.

-- 
Philippe.
