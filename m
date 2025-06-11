Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069D91C8632
	for <xenomai@lists.linux.dev>; Wed, 11 Jun 2025 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659082; cv=none; b=WYBqxplJPF4oLBXhQD2yqZ7hxRHbgT6O9OI8VzC+Dom4Q/r5y3RV5cvIubm2X9KXnNNNyh8MiR/3sbSy5VqbZIg1/zo1NY2CKs9FY7V1QepHKDqw56zPSQrNhzBD7ZtbGhKzU+j54ngSMmfODyaDKwgari0oUL8dvhYx504Y+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659082; c=relaxed/simple;
	bh=DwUR2hvEP4Kzdls28/53Bydzz5x8AtaBLGmZnJmBDaI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bPxADQu+1wU9vIri3PxQSWZHOmr06usXlFzI+MFWC46UOH5RXc6pJHgx091v2GKOXCYR8EkQX952LOSU4YAPg3avHdSPIS+0YMtvTdbU9DS3UuGev6WzaRfluRT4kQsqDqSfUhiPhXE4aep6vWt22fJamCcP16G/A5m2aTXNIhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=JoxG+1B5; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="JoxG+1B5"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A1D544979;
	Wed, 11 Jun 2025 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1749659076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=THzbQYi/9fSMoOdFI8RWZuLizHHsc1yMM9jG4yuQEt8=;
	b=JoxG+1B5n1paRgZnwcYWDnw7e9Jw1c8a7XobuSXr+JTpeXgyDeT3U+rnDbpBGiDe3npirq
	TKTjlQDI73ob2DkInHTBfc7dViqbwsgZMb9+6o14f3FbcdszznjoKuCH/I2waB6G5aGUnX
	l9Yfby9NVjdeYaxnF65EbhRoBCwVoA8ETGJ4ocRw3PeAVpfTqn7vA7FqsChdFywkjfSeSZ
	fetH2y1KiYaRNtXKaI/y1RqXgZQNJhEHkP2xdFJ/pF5Mljl/8ZbkQnsXs66YpDXyRGe/oF
	YwBCJ1YBZF/0RObXx6ZovUsMsxoZkxRQvHyu3IlKf2knBo4uKGAI0evHj0CSMg==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH v6.1.y-dovetail] arm: dovetail: Reorder fault_entry hook
 and pr_alert
In-Reply-To: <f851bc4c-5e90-4b96-9fd2-6b749000b18a@siemens.com> (Jan Kiszka's
	message of "Wed, 28 May 2025 09:52:02 +0200")
References: <f851bc4c-5e90-4b96-9fd2-6b749000b18a@siemens.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Wed, 11 Jun 2025 18:24:32 +0200
Message-ID: <8734c6456n.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Merge fallout - align with newer kernels.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm/mm/fault.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index a8dd9254fcd5d..7775c5fda3aba 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -652,9 +652,8 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
>  	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
>  		return;
>  
> -	pr_alert("8<--- cut here ---\n");
> -
>  	irqflags = fault_entry(ARM_TRAP_PABT, regs);
> +	pr_alert("8<--- cut here ---\n");
>  	pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
>  		inf->name, ifsr, addr);

Merged, thanks.

-- 
Philippe.
