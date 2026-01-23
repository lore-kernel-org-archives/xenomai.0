Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D91ADC83
	for <xenomai@lists.linux.dev>; Fri, 23 Jan 2026 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769181280; cv=none; b=puKqLuEL8IBCqyC5LyB4ML+YGluPrqo7fCGLjOzqq1YS7Ju1VOQDHhF/lcg/mj6HOz0u+Uz53Cn+o72FXNPhc+VqAgN/X/v0KjPWiMfisS0nNfGBlVW54ugqz9390XHbHSyP4mAxArFYmcIYPMG6wNJJpZUV0A4Kp7euplcZuPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769181280; c=relaxed/simple;
	bh=fX5z4B5TOJuTuvMDv/dQ3p6nK2tLsWxR6Tn1bLxWMY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tAB1WZrFYIMNjhxOIuSV2U9sPvVqWOV57x3tqcgqckhXNGVxuTaSVZ6gDv6S9ekdL5SOU+IvfuESFqzwY38bH1KPZ9/XRrFP2Mv2mMrS4T1vfuJ3NppWK7IqbvHnRZk8aQ6FyNL1ab9PFGvxsv6NSHXAMDWGCFJPHitEYt2a93U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=BRWp2UZG; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="BRWp2UZG"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 98BFB43B73;
	Fri, 23 Jan 2026 15:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1769181270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HDHmCxWg+64OK1vylQhVUrrQXGdNZeTdp0g5IWgmuhM=;
	b=BRWp2UZGjOpuJ+Ip4j9fvx9XCAXik+PcBE5TstNFJTYVJPn7GXGOoqolOCnw/cuzQ0UA/C
	YUBdVcfbH8n25PY3gPdzDN8ICmHGXeoy3XgibA+4rl186lBxjIT7egfcMYED4sVgrAN7Qg
	pkEUQWaAQEuCSHzzqoC95pHdQsA08EaOB+YcNHOx9brkExMcagNUtsk8D3dZWwSHPZG++y
	MHjP8lpl+mklFS5LIivL9eIJPeMEgzuKZ3ZjFaw8LoTrg/ITgaMzsG3UsMFFQlbCy31OIp
	pExfj/6GoyqR5e9Fb4O1KEWYUe3jfdkR+CtttS5OHoE+hijq7wlY0nP7W1QGFA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Florian Bezdeka
 <florian.bezdeka@siemens.com>
Subject: Re: [v6.18.y-dovetail][PATCH] arm64: dovetail: restore lost debug
 trap hooks
In-Reply-To: <59c22e2a-2946-4114-93c9-5c7736d15c7d@siemens.com> (Jan Kiszka's
	message of "Fri, 23 Jan 2026 16:00:44 +0100")
References: <59c22e2a-2946-4114-93c9-5c7736d15c7d@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 23 Jan 2026 16:14:28 +0100
Message-ID: <878qdo1huz.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelfeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepleekuefhueegfeeujeefpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-State: clean
X-GND-Score: -100

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Apparently lost in the forward porting from 6.17.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Fixes the gdb smokey test of Xenomai 3.
>
>  arch/arm64/kernel/entry-common.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 2ae2f6898bd2c..e0227d467cef4 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -842,6 +842,7 @@ static void noinstr el0_softstp(struct pt_regs *regs, unsigned long esr)
>  		arm64_apply_bp_hardening();
>  
>  	arm64_enter_from_user_mode(regs);
> +	mark_trap_entry(ARM64_TRAP_DEBUG, regs);
>  	/*
>  	 * After handling a breakpoint, we suspend the breakpoint
>  	 * and use single-step to move to the next instruction.
> @@ -852,6 +853,7 @@ static void noinstr el0_softstp(struct pt_regs *regs, unsigned long esr)
>  	local_daif_restore(DAIF_PROCCTX);
>  	if (!step_done)
>  		do_el0_softstep(esr, regs);
> +	mark_trap_exit(ARM64_TRAP_DEBUG, regs);
>  	arm64_exit_to_user_mode(regs);
>  }
>  
> @@ -871,8 +873,10 @@ static void noinstr el0_watchpt(struct pt_regs *regs, unsigned long esr)
>  static void noinstr el0_brk64(struct pt_regs *regs, unsigned long esr)
>  {
>  	arm64_enter_from_user_mode(regs);
> +	mark_trap_entry(ARM64_TRAP_DEBUG, regs);
>  	local_daif_restore(DAIF_PROCCTX);
>  	do_el0_brk64(esr, regs);
> +	mark_trap_exit(ARM64_TRAP_DEBUG, regs);
>  	arm64_exit_to_user_mode(regs);
>  }

Merged, thanks.

-- 
Philippe.
