Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17137410D3A
	for <xenomai@lists.linux.dev>; Thu, 26 Mar 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542662; cv=none; b=TWrMnlYaTHpWj06AsFtCZj6FiK5kVmV3yYzAGOM8SOzx5M7HDuUr6UBeJDR05jX99LP8sDtZIWVjH3TCMgRzx3O7pvhe15oeVXVu/V1R+u7MOtx6VnEhc9xvRGLsLTExmqMsK6onSdjMFpYkLGI7t39A2hmINYOvFkfnpxpeR2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542662; c=relaxed/simple;
	bh=qhrrbUdMu0aSP2M3KWhh4Alw2mJEr1cMXtVVrOE6GJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QVkQTD0EmgTUowBz6zlaAOIp3Pd7x0Xn+0NbvEJ3sEySl3IOsrJfED1cRLr4bZARaYvHIKJkv9IPRrm5ZP7GWQ5aKYU4dBD+4mv5NQZ4jDddG5katuqKgdQKuUdi3D9XB32jPo0hmC/7f7Mvfe56bSQmN4js01smYrzeDu7NFeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=f2d6pYp6; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="f2d6pYp6"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 751FD581596
	for <xenomai@lists.linux.dev>; Thu, 26 Mar 2026 16:27:48 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB0403ED33;
	Thu, 26 Mar 2026 16:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1774542461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gjAihsMdG6qBs6O16pTuR6pUz0zauiQJF4E6mT3cqdk=;
	b=f2d6pYp6pcznpgkXJETEXyGynWuy8a9SmdkAqwqWwXQq2sFrWGVk7MVAGV+nkv0EDvVWPN
	MW60iDri39MnuBlrDyffSve0TNA9qIOI8CI1vne+d1+MNwXVgRPjCqxKxHY/x0TDiuWx7e
	O972H9evvl/P8wEXebxiEw0COPkqhElQ3ztXNfqhQptL3fUq3tu2ZDf98vbG4PvHZBehrI
	Z44Kz3z+inC96OXj/WWPcuIiYtvh9V/n1CCoGrTBqaDDat9uWAj7Un+RY5sE5BtJBOSZ8j
	sOETahh9mSRdUZb0vcDZjmgUZ17ukC408G0oUqcg6V+rKWlloGkZ6hrDCQ23aQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  florian.bezdeka@siemens.com,
  jan.kiszka@siemens.com,  shannmu <shanmu1901@gmail.com>
Subject: Re: [PATCH dovetail v5 02/12] riscv: irq_pipeline: add IRQ
 pipelining core
In-Reply-To: <20260320213657.2210419-3-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Fri, 20 Mar 2026 22:36:47 +0100")
References: <20260320213657.2210419-1-tobias.schaffner@siemens.com>
	<20260320213657.2210419-3-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 26 Mar 2026 17:27:35 +0100
Message-ID: <875x6ih7yg.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepgfeutdegtdefgffffeefpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohephedprhgtphhtthhopehshhgrnhhmuhduledtudesghhmrghilhdrtghomhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepg
 igvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehtohgsihgrshdrshgthhgrfhhfnhgvrhesshhivghmvghnshdrtghomh
X-GND-State: clean

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> +extern int NR_CALL_FUNCTION_OOB_IPI;
> +extern int NR_RESCHEDULE_OOB_IPI;
> +extern int NR_TIMER_OOB_IPI;

Instead of defining these pseudo-variables which are basically
duplicating the out-of-band IPI indices, couldn't we move the definition
of ipi_message_type to <asm/smp.h>?

> +
>  int riscv_hartid_to_cpuid(unsigned long hartid)
>  {
>  	int i;
> @@ -95,7 +134,7 @@ static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
>  
>  	atomic_dec(&waiting_for_crash_ipi);
>  
> -	local_irq_disable();
> +	hard_local_irq_disable();
>

local_irq_disable_full() may be safer in case hotplug handlers have
assertions checking for irqs_disabled().

> @@ -176,9 +176,19 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
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

This is basically what local_irq_enable_full() does, keeping
CONFIG_TRACE_IRQFLAGS happy too.

This said, I'm unsure that we really want the in-band stage to be
unstalled in the illegal instruction handler, although we do want the
oob stage to keep receiving interrupts as long as possible while
handling such trap. As a rule of thumb, unless the in-band code
explicitly enables interrupts (e.g. on page fault), we should assume
that it might expect not to receive any interrupt while handling such
trap.

Would hard_local_irq_enable() unconditionally suffice here?

>  		handled = riscv_v_first_use_handler(regs);
> +
> +		if (running_inband())
> +			local_irq_disable_full();
> +		else
> +			hard_local_irq_disable();
> +

Ditto (local_irq_disable_full()).

>  		if (!handled)
>  			do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
>  				      "Oops - illegal instruction");
> @@ -308,11 +318,19 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>  {
>  	if (user_mode(regs)) {
>  		irqentry_enter_from_user_mode(regs);
> -		local_irq_enable();
> +
> +		if (running_inband())
> +			local_irq_enable_full();
> +		else
> +			hard_local_irq_enable();
>

Ditto.

>  		handle_break(regs);
>  
> -		local_irq_disable();
> +		if (running_inband())
> +			local_irq_disable_full();
> +		else
> +			hard_local_irq_disable();
> +

Ditto.

>  		irqentry_exit_to_user_mode(regs);
>  	} else {
>  		irqentry_state_t state = irqentry_nmi_enter(regs);
> @@ -429,12 +447,72 @@ asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
>  
>  	handle_page_fault(regs);
>  
> -	local_irq_disable();
> +	if (running_inband())
> +		local_irq_disable_full();
> +	else
> +		hard_local_irq_disable();
>  

Ditto.

-- 
Philippe.
