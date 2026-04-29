Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A672D3890E7
	for <xenomai@lists.linux.dev>; Wed, 29 Apr 2026 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777448820; cv=none; b=lEFQkilxfUvYGu/v/Ww/DprTVdGJmYk30JQKK/ajO6PgNmJsoJa52ZsK3xneqhFVXLP5oLzCzl7froalr8FygaIRPfvv5bV9D1/1+NTYO+qmRUvAv6iejfLzLtReYn3P4rJPM2BVQ8ztI4XodRDlMDPD6uHpxzY5SaE/hvV7W14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777448820; c=relaxed/simple;
	bh=xGBqmrcXwwZ+XxvXZtSGaTRVNQnGc95Jrog7237h1uo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sO0GfrOAgxN8LCFbPKgt6ajA2jZkfZXEDe5HhSLu8saAPeGxjixUlluq455V06g1pJEUI6t3Ip69SVm2mx4NW/dSu+wQuVg9Se24WoYcPO8QYa0h+09gdu/PM7fslhiD2aNVw0c9Rg4EpVNNeNeZ5fGo89hnuInXvF7nkfx8/xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=QjcnONUY; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="QjcnONUY"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D95F13ED69;
	Wed, 29 Apr 2026 07:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1777448809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x1jqgGlVJpR1qFITJTnAHwKS1F3q6h2EbjHpUW/2JAo=;
	b=QjcnONUY02DpHuWVnArfLgarcHxng+ZU/ENpa6xHEsdsqLXHO/Jt9fq5Pift0DQE+qJYND
	ylXKMnBzjSs9KsAGVlT8pm5RmXxD0LZxJRFHgzdhWuqegNDPMsKHZH4GZUb+ruKOA1Dt/q
	IoliGyh6NcScm2VbffOkVq1T+ZlQPk8ZzjP8ELoIzJ2lO4BZ5xZNcy4aWNl16pqD5RznfT
	rg3vS0yOJjjm0zqcXarPX8DlM9q1+wbBtid80Sa1uK/QDcZjCcmXA3sT1OxYe6fop1m42w
	teWAI3p1b9xoFUf4EpKu0JqmHQRjpGOvS2hXwTRXIBr4kJRTUWf8v9i/MCcreA==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  florian.bezdeka@siemens.com,
  jan.kiszka@siemens.com,  shannmu <shanmu1901@gmail.com>
Subject: Re: [PATCH dovetail 02/11] riscv: irq_pipeline: add IRQ pipelining
 core
In-Reply-To: <20260417210154.2290819-3-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Fri, 17 Apr 2026 23:01:45 +0200")
References: <20260417210154.2290819-1-tobias.schaffner@siemens.com>
	<20260417210154.2290819-3-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 29 Apr 2026 09:46:42 +0200
Message-ID: <87cxzib44d.fsf@2a01cb0804738000b42250ae26cae50b.ipv6.abo.wanadoo.fr>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTGWvtzUEHOQPVwB9o9lNi9gVXDRtjk4mwJenu+48r7GmH8JZEwvZ9FBn7UQtSDZs3J2oyzX4WnLWLvNJIKTL2VCcsdY5AY/PoeB3T5Q/3Gp01j8xoAIFsNZbuClJoNuUSlke1AnbzoxTq4hUhh63yFBRZIKSbVgkGAy/WWmo4Cs+FgXaQ53wgWZnOwUBmzAA05vnX/A/LMsaGirzWytFgxjUv33mjNBd+5ez+4V5vjjJ3xZaH9M1k+iH/NVsZaX3xxZA2QERGy3p53F/hFkJb8Lk4xfg/jhNoRthruj0hlLAYKS9ZMvjF+KnOXhEVVwKd236rN0tlidKLxL4UZteIYtHUKU1fI0hhoM85XBmhcOX1qEvX9543CPzs/MCbSDsbcQ4WxIaXjKYoRSrakdyaXYNC1HYfF75rz5y2Bdq/qupzj4WZ6q9YaUaBg/Z1J6hKK7CppM53XX5QKcNLalXbeCU7NwyKrJaZZl+tXsVN5hRqcDebAO1jK34CQGk6QpW/E2eJS9eYybaexT//I8SZHc4XGeagfSxv0yb2QD0xKY+goY3Kp5K2y3YJETEbLx8166WOQcF35bxfcPiCjJSB7aDu0+uZRM7SYOCvJegLw9Y0Z7SZDMuoZms4WS3jYlKE1z5S+u/Yh9EQ0V4GRK6OXl9cSVi2H/MBp7t9oAnW7IqA
X-GND-State: clean
X-GND-Score: -100

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> This patchset integrates IRQ pipelining into the RISC-V architecture,
> bringing it in line with the Dovetail/IRQ pipeline model used on other
> architectures. It adds the core pipelining infrastructure and adapts
> low-level primitives to cleanly separate in-band and out-of-band
> interrupt handling.
>
> @@ -176,9 +204,12 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
>  
>  	if (user_mode(regs)) {
>  		irqentry_enter_from_user_mode(regs);
> -		local_irq_enable();
> +		hard_local_irq_enable();
>

irqentry_enter_from_user_mode() has just stalled the in-band stage, so
we end up here with hard irqs on, but irqs_disabled() now yields true.
Maybe riscv_v_first_use_handler() would never complain about running
with irqs (virtually) disabled although the caller explicitly enables
them, but maybe it would, right now or as a result of a future upstream
change.

As a rule of thumb, I would always keep the assumption the original
kernel logic may make about the interrupt state when running in-band,
in this case (*):

-	local_irq_enable();
+	unstall_inband_nocheck();
+	hard_local_irq_enable();

(*) hard irqs must be off when manipulating the stall bit, so the proper
sequence is always unstall+enable when entering with hard irqs off,
disable+stall when entering with hard irqs on.

>  		handled = riscv_v_first_use_handler(regs);
> +
> +		hard_local_irq_disable();
> +

and conversely,

+	hard_local_irq_disable();
+	stall_inband_nocheck();

>  		if (!handled)
>  			do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
>  				      "Oops - illegal instruction");
> @@ -308,11 +339,12 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>  {
>  	if (user_mode(regs)) {
>  		irqentry_enter_from_user_mode(regs);
> -		local_irq_enable();
> +		hard_local_irq_enable();
>

Ditto.

>  		handle_break(regs);
>  
> -		local_irq_disable();
> +		hard_local_irq_disable();
> +
>  		irqentry_exit_to_user_mode(regs);
>  	} else {
>  		irqentry_state_t state = irqentry_nmi_enter(regs);
> @@ -428,13 +460,69 @@ asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
>  	irqentry_state_t state = irqentry_enter(regs);
>  
>  	handle_page_fault(regs);
> -
> -	local_irq_disable();
> +	hard_local_irq_disable();
>

Ditto.

>  	irqentry_exit(regs, state);
>  }
>  #endif
>  
> +#ifdef CONFIG_IRQ_PIPELINE
> +
> +extern void (*handle_arch_irq)(struct pt_regs *);
> +
> +static void noinstr handle_riscv_irq_pipelined(struct pt_regs *regs)
> +{
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +	handle_arch_irq(regs);
> +	set_irq_regs(old_regs);
> +}
> +
> +DEFINE_PER_CPU(int, irq_nesting);
> +
> +static void noinstr handle_riscv_irq_pipelined_on_stack(struct pt_regs *regs)
> +{
> +	if (IS_ENABLED(CONFIG_IRQ_STACKS) && this_cpu_inc_return(irq_nesting) == 1)
> +		call_on_irq_stack(regs, handle_riscv_irq_pipelined);
> +	else
> +		handle_riscv_irq_pipelined(regs);
> +	this_cpu_dec(irq_nesting);

What if CONFIG_IRQ_STACKS is off? Imbalance?

-- 
Philippe.
