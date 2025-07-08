Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB19188006
	for <xenomai@lists.linux.dev>; Tue,  8 Jul 2025 07:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958252; cv=none; b=KMNVM0f6KWPPTwKu6aESnJN53DPk3rvr9TJoBkYN3MmIM8axCh59PRdOjulIloBVp/tqpQAQ3NC0iHqiE97BhW3G+jkf2uP/odQa2f8oskevy/+G4Mri9ZlF7PaPhPAk2fYWnnZBFdAFxTTN1oYzL+isbU0gk3cEKJfb1v4av/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958252; c=relaxed/simple;
	bh=aQVlKA8DmJO1cw5XQyfNalsfLkwn2B2jzwoV9vO7AJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SxUnB10TlXnJP5PORm3mqmS4nKILy0rcGZfd2zroikbyO7r2360Ke176x2Y4pSqSX5dpInOtwMZkEQbSwXVo0iVFZLAMz2v4lP6U4KEY4BJuzJNgK11lPms+EVMJ2lDpAYVaKYsJ5esffarOab7p+FS4yWcIJ26qGS6rGy3SP2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ERS+t5hs; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ERS+t5hs"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 680B7442FF;
	Tue,  8 Jul 2025 07:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1751958247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hlr0XP9RRNJXSgnFDpAn4PuweEy+S/+/JgEdoXQu0pE=;
	b=ERS+t5hsddfB5Vx1zqpH4vjnuLo74Gt1gsDsSpqPSIfB4eujKt+LZ9YHKNRpOIv9BsdIXg
	l8XA9IiHiO17YcLlwPRQXpPosVPBIPZx916IIn9HGDTq0/GYalT4XC0ulWTIdNwPUKFG3f
	r6y/Rw83NJ26ARa+t8/z9O+x4MQQM1Th8PR+k1nzdLU97O47k6TbZR405V+u4E7XPhKv+9
	Y+fgrmW7gpCppd+u9gMqz0tcZD1VW/8Dx5708X+35Qctbfjvh2MoMwU3vj/HX31A9SthZx
	5uCI886qlIsjvtXkQT+rmjyDLggKM2WEmybHE5xysfI6j6R4qw1X1sNRtjT7Ig==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH] x86: dovetail: Use appropriate EOI on error interrupts
In-Reply-To: <3cf01441-93e6-4004-a9e5-5183eb6740de@siemens.com> (Jan Kiszka's
	message of "Wed, 25 Jun 2025 10:16:13 +0200")
References: <3cf01441-93e6-4004-a9e5-5183eb6740de@siemens.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Tue, 08 Jul 2025 09:04:03 +0200
Message-ID: <87h5zn5fks.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgedtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Just like for the non-pipelined spurious interrupt, we need to invoke
> the non-pipelined __apic_eoi while handling error interrupts. Otherwise,
> the local APIC will stop receiving further interrupts, and the system
> will stall.
>
> Given that it takes very special conditions to actually trigger an error
> interrupt, this issue was very likely not relevant for most deployments.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/x86/kernel/apic/apic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 1cd5f59f7962f..278e28c5290d3 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -2217,7 +2217,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_error_interrupt)
>  	if (lapic_get_maxlvt() > 3)	/* Due to the Pentium erratum 3AP. */
>  		apic_write(APIC_ESR, 0);
>  	v = apic_read(APIC_ESR);
> -	apic_eoi();
> +	__apic_eoi();
>  	atomic_inc(&irq_err_count);
>  
>  	apic_pr_debug("APIC error on CPU%d: %02x", smp_processor_id(), v);

Merged (v6.1.y [__ack_APIC_irq], v6.12.y, v6.15 and upcoming v6.16), thanks.

(short log fixed up slightly to ease commit identification on my end)

-- 
Philippe.
