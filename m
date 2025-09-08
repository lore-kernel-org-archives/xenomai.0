Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636CC301498
	for <xenomai@lists.linux.dev>; Mon,  8 Sep 2025 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335059; cv=none; b=lBXQjVcClB74PTd+Q2r84plpps6kjubqxvkVlOl9n/EFYR98kpOuM7mdsKf1Hkp1Jv7TqsxaT6Vh+qhElsh7q9hD6v17yRW4OoaG1Ti6VWVuCgi/i98ID7JT94l3eM4m4guJiBcBORh/L9kl3QILX6Bpfs4t7Sc4BggeiObt1uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335059; c=relaxed/simple;
	bh=Wc5GZYTKYI6qSvErTh7xqoylJxsNuZPgdlP/hwgZ4pM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IzzE2q2ihBau1p+1DnkT11yOIHxwHlNAt/4GycbBuzNlGhKEgT7s0pl5/wuCi6Y7dTwLxCIbnPeGjJ2tDx3V1KAV1sAnkUdTqC73HxQvnz1zVLNYVyzb9v0eVvO/WykwYYlPdiKvFIVhek+q71vgbOXgpXgwJ5f7HFbt6AyyEHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=lDaVYNWL; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="lDaVYNWL"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 533C543B29;
	Mon,  8 Sep 2025 12:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1757335054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S89xxVHP18a0DSQ3kh47jspVYE14brFjja0LfxoJoT8=;
	b=lDaVYNWLXiFavsYSG8HKzRxnd1ALzaVeoy+n1v91R1myyT6mzwNM5JWXFJtktQfZnkdeRz
	wjwmHySh2brmtuD5dVuo8LgNL4XZoVgh9B69P34opC03RsfiyZ/WDUXwu0vh1Pnl1euQtw
	Qhs+JleV8hE6vKzN0W0nWXQryKsAFDGYPrHMH3BDaInJXjkkwvUCYI6DTwin/fVojiVOdh
	wlR70cN7mX5sCyI7tg/B1wpQDleIc6KytGsoDHoinCF548/3xIPnGYnF1MrKy5Aq5W/kOy
	iyEdl/aD+8PTMfRef7aXtX6K+8qMLUw4ZJs3wPdwQoCqGZY52JUu9/pR1oBRAA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.16 v3 1/3] x86/fpu: dovetail: Fix FPU corruption
In-Reply-To: <20250820-wip-flo-fixes-for-dovetail-6-15-v3-1-ae4a674d8e10@siemens.com>
	(Florian Bezdeka's message of "Fri, 05 Sep 2025 16:26:25 +0200")
References: <20250820-wip-flo-fixes-for-dovetail-6-15-v3-0-ae4a674d8e10@siemens.com>
	<20250820-wip-flo-fixes-for-dovetail-6-15-v3-1-ae4a674d8e10@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 08 Sep 2025 14:37:26 +0200
Message-ID: <87wm6986ih.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 77c4c632cef2..2fc72d622229 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -237,10 +237,11 @@ static inline int arch_within_stack_frames(const void * const stack,
>  #define TS_OFFSTAGE		0x0040	/* Thread is in-flight to OOB context */
>  #define TS_OOBTRAP		0x0080	/* Handling a trap from OOB context */
>  
> -#define _TLF_OOB		TS_OOB
> -#define _TLF_DOVETAIL		TS_DOVETAIL
> -#define _TLF_OFFSTAGE		TS_OFFSTAGE
> -#define _TLF_OOBTRAP		TS_OOBTRAP
> +#define _TLF_OOB			TS_OOB
> +#define _TLF_DOVETAIL			TS_DOVETAIL
> +#define _TLF_OFFSTAGE			TS_OFFSTAGE
> +#define _TLF_OOBTRAP			TS_OOBTRAP
> +#define _TLF_KERNEL_FPU_PREEMPTED	0x0100	/* Dovetail: kernel mode FPU section preempted by OOB */
>

The TS_* enumeration originates from the upstream implementation, so we
added our thread-synchronous flags there. The _TLF_* aliasing comes from
the Dovetail implementation, in order to get a common naming scheme
because not all archs would define TS_* flags. So we should keep it the
current way which is intended to prevent conflicting upstream addition
to go unnoticed, i.e. define TS_KERNEL_FPU_PREEMPTED then alias it to
_TLF_KERNEL_FPU_PREEMPTED.

The rest looks good to me.


-- 
Philippe.
