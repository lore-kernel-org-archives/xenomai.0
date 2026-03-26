Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7B92DA755
	for <xenomai@lists.linux.dev>; Thu, 26 Mar 2026 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542721; cv=none; b=H/tp+l2kTUyYsbRxGBgVOIXiJtGNpTzf8JQY1+dNJvYOZRfmRH9tV8dfzpHMbnxXah6jgUzFxFL9/sXjZMN1iILHmqUFWwIsTTjkJdGvTGTsgW38hTMKHtKJQVwUlbh6cYffvmR5GhKX6FQA9kZTbLLI8BOX+c7L/IaJEsO9mVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542721; c=relaxed/simple;
	bh=g2O9gnwz361zwck3JaXk2KHhWkspAbB1T8Q/TQ3CMNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QQKQs+lUtSj+aDqxUqPO8byukQe9jhAqX/SyLtAruRszlqcReF/qHJZp3phstDIf+Cziq2GJu47efmwPZ49YYWP+QAArrfEvAIt/X5PbLvns6Lj3ZDgDFv1+Z0rUecK8LqITCFkNrGowiZgS570Ep7/rpudwFF6bIKKlYYjFlbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=DkK4EyYr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="DkK4EyYr"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66EFF3EBFD;
	Thu, 26 Mar 2026 16:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1774542711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7H1utYGqm01pM4Y163nRPqLB1lPZVMzts45oVNIBxaI=;
	b=DkK4EyYr+womy9/ve64OFkDtocsUIj4tudE4Qm8wI+w2idZDJP/RplPBAmfgWbTqZmPHs2
	TBd3quARf3HzpBO06BGsm1b5QpAuDYLFR6P6zdJXSuv+MoALrCXOAXMh1J+dUuSG+el4WV
	YoJL036CoYn5J0gcM/7IK1/KNlLawzhr6dU6nSEcBg1pBOUQMHH+lhlslIW0S3GzPLPAfG
	1V/olYEKS9Vet0qLnD3j9xg/K7kPDt3tblqDsjTyCo2iiCay2iFdDC52JTW37IYrHgdg7G
	dHH9lGvPJJMNVEvynAlWjghSbqVLJHg0xcveTf0MUnIF7swjnbs1gVL3qbV4WA==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  florian.bezdeka@siemens.com,
  jan.kiszka@siemens.com
Subject: Re: [PATCH dovetail v5 03/12] riscv: irq_pipeline: enable hard IRQs
 during in-band trap handling
In-Reply-To: <20260320213657.2210419-4-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Fri, 20 Mar 2026 22:36:48 +0100")
References: <20260320213657.2210419-1-tobias.schaffner@siemens.com>
	<20260320213657.2210419-4-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 26 Mar 2026 17:31:50 +0100
Message-ID: <87zf3uft6x.fsf@xenomai.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepieeigffhhfefgfeuhfffpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtt
 hhopehtohgsihgrshdrshgthhgrfhhfnhgvrhesshhivghmvghnshdrtghomh


Until mark_trap_entry/exit do call oob_trap_notify/unwind to forward the
event to the companion core, this code can be merged into the previous
patch introducing the interrupt pipeline.

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> When running with interrupt pipelining, re-enable hard interrupts
> while handling traps on the in-band stage so that out-of-band events
> can be delivered promptly.
>
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  arch/riscv/kernel/traps.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 267b8ec5a1bf..5b84e1ff0eeb 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -112,10 +112,30 @@ void die(struct pt_regs *regs, const char *str)
>  		make_task_dead(SIGSEGV);
>  }
>  
> +static __always_inline
> +bool mark_trap_entry(int signo, struct pt_regs *regs)
> +{
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
>  	if (show_unhandled_signals && unhandled_signal(tsk, signo)
>  	    && printk_ratelimit()) {
>  		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
> @@ -127,6 +147,8 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
>  	}
>  
>  	force_sig_fault(signo, code, (void __user *)addr);
> +
> +	mark_trap_exit(signo, regs);
>  }
>  
>  static void do_trap_error(struct pt_regs *regs, int signo, int code,
> @@ -137,6 +159,12 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
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

-- 
Philippe.
