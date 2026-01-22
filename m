Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4711313274
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 20:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769113326; cv=none; b=EGHUnKVTyf+ftS597MLwXLJHt96NjJsHuX+4D0EMiQk8Y1T129A1PR1grshjdNooLRvuDDmQVm9KvNeEwq4BnxAEw8qk3PKmWgMBeHw8Ek0fzxazndNw2ifrHopqXC1u2bH3Uxz0Bqp+vp2w5KdJp13BBQ36kgnmPg/wwuwfFZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769113326; c=relaxed/simple;
	bh=Bi4GLtRWwXL/Q0ja5bjT9NKD50WzBSXkqA4O8xv+3wk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jkHqB2kN+jESZjfAVy6svwT415z9HGBNwKjtzPz2J5e0jaX/KoeTkdDoLEEQqhUUCqLeswFkZ5qzz2Y7y4iTzC9ukO5BWkQI5WCV94Zhnd9kihJ2dCkuCjYM1bLLISikptPy+QVkz1U0I12oYe8R9I2oA9ntt0vUQYMnKWhgwR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=QetrkgPa; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="QetrkgPa"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id C92CF58681F
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 19:55:43 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0D62441CFA;
	Thu, 22 Jan 2026 19:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1769111741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7a8KqXGRbiUukFjstx/yHWXifo479OLCx6gz8uoknIU=;
	b=QetrkgPa0lWCTTjYYmA5/b6ajrzNkFIKgz4EgP4hvX10nMFCuHUO22P7RdbG5O9wDRkAd1
	vK26HrVwpFSIiLpgLHu55rrvDoYoTP8WK3K2cFIgFI8OI0XTjrtgzjQ+AnPn0Ca79s+RzN
	6+PCOZRsXirXM0ksQCJGqZTA+7oqBqNFyxvLsQ5EL6SfJ7rHC5ILXVN86fu9WdvugmpW4c
	fKwmIVHxxVn8Q/qyj0zdd6vupYfQ6g59uVkytWnav8UuQ+CvhpClI6u4kxRPas3i80tHNA
	kZnLfzF7Zqg5ojuO5vwV/Sb/0jb0VKLezyI7lEoRTbYbObHUVIeN5MsPFvOmug==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH dovetail v4 02/12] riscv: irq_pipeline: fix irq stack
 handling
In-Reply-To: <20260122102304.421957-3-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Thu, 22 Jan 2026 11:22:54 +0100")
References: <20260122102304.421957-1-tobias.schaffner@siemens.com>
	<20260122102304.421957-3-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 22 Jan 2026 20:55:40 +0100
Message-ID: <87fr7xifr7.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejtdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugeptdffiedvgeegudevhfetpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepthhosghirghsrdhstghhrghffhhnvghrsehsihgvmhgvnhhsrdgtohhm
X-GND-State: clean

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> We can not rely on the task pointer with the companion core potentially
> switching contetexts over the irq stack.
>
> Track the nesting depth instead like arm64 does.
>

This change is specific to CONFIG_DOVETAIL=y, so this should go to
"riscv: dovetail: add core support".

> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  arch/riscv/kernel/traps.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 44b627d762f9..d0400086a075 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -443,14 +443,21 @@ static void noinstr handle_riscv_irq(struct pt_regs *regs)
>  
>  extern void (*handle_arch_irq)(struct pt_regs *);
>  
> +DEFINE_PER_CPU(int, irq_nesting);
> +
>  asmlinkage void noinstr do_irq(struct pt_regs *regs)
>  {
>  	irqentry_state_t state = irqentry_enter(regs);
>  
> -	if (IS_ENABLED(CONFIG_IRQ_STACKS) && on_thread_stack())
> +#ifdef CONFIG_IRQ_STACKS
> +	if (this_cpu_inc_return(irq_nesting) == 1)

This is Dovetail-specific, we may want this code to be compiled out when
CONFIG_IRQ_PIPELINE=n. See the related section in v6.18 for arm64.
Nitpicking: actually we could even make this Dovetail-specific, because
the only way to have an oob task preempt an in-band task is when
CONFIG_DOVETAIL=y. The arm64 pipeline implementation is a bit sloppy on
this too.

>  		call_on_irq_stack(regs, handle_riscv_irq);
>  	else
>  		handle_riscv_irq(regs);
> +	this_cpu_dec(irq_nesting);
> +#else
> +	handle_riscv_irq(regs);
> +#endif /* CONFIG_IRQ_STACKS */
>  
>  	irqentry_exit(regs, state);
>  }

-- 
Philippe.
