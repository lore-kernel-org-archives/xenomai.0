Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E226FA4E
	for <xenomai@lists.linux.dev>; Fri, 26 Sep 2025 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758876605; cv=none; b=rkBsKtskArsMJLN68S711zmpAXFMf5u9bLNE8/mbBGLW4b5FaE/FVd5beKNx18s1nfeSg8NIx11goraChBHUIjNaAoPDPB+DNhqTkP5pPf1Xh2F7LE7LG//EbJwVA6NPNul3j1zIjSd5yb30qgxk4+//yZGogCyReTbd3TxjqHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758876605; c=relaxed/simple;
	bh=x5hCJmYOakoYFdclsYficKS/aM0koI8jyOYKTSovwUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oo3NecBUy4jB2w+oLDCj2RMiZMF61oJ6LSL4PApAbFeePeXc5J0oPAAWSCGsvek9GqS8NpaVhDAcWpSnataRXRTDZ6YaVKTP/lWErKCb2x4wXOSPlRGPTYGpGDjV3+gL9/kBBRPOy9jV4wCnoqnH5ZyYqvLgLjxhddVvp5fwh0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=daKragB2; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="daKragB2"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4CD524335C;
	Fri, 26 Sep 2025 08:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1758876595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w0LJ4YmTx9lJAfOm43JZUH0e18MIMYY5SFD9cA3k838=;
	b=daKragB2znBi2/vDZRug0KCVqh+/ium+pim7UfOuXRDsGnM+b1PAh0BJXXSJQayDyFbwbQ
	sSdZP/pavBZey/6IVDKcsjG7uB4wfBKO2tf6eJN75AaWHSwy8rLXce7YTz8ITeh5h76zZH
	ZIig0tK4S6mhUftJwbA/Mb9vNIe6re0fTuxEV0yfcFx71Fz9mdwOHPPgyoQjKmgPtCLowS
	SlwAN7f6EprlGrTELuZ0JN8DBKNapVLFt0ILveQota2RrNPgrbzeQTk/37pSm/iuelQGMP
	d3CGiDtDyblWtnpjgvL+lYtIMibSrpaPyl6GxgZj1u16r/AKiaA4431NtyZBAQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH RFC Dovetail 6.16 1/5] kernel/entry: irq_pipeline: Do
 not leave .noinstr.text section
In-Reply-To: <20250925-wip-flo-cleanups-based-on-6-16-v1-1-8c4ac7b52cd8@siemens.com>
	(Florian Bezdeka's message of "Thu, 25 Sep 2025 15:05:47 +0200")
References: <20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
	<20250925-wip-flo-cleanups-based-on-6-16-v1-1-8c4ac7b52cd8@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 26 Sep 2025 10:49:54 +0200
Message-ID: <87ikh5ha31.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeikeelfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Fixing the following warning by moving the call to irqentry_syncstage()
> into a instrumentation_begin() section.
>
> vmlinux.o: warning: objtool: irqentry_exit+0xab: call to synchronize_pipeline() leaves .noinstr.text section
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/entry/common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 583dcef13c7c0..284d41cb1c918 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -393,6 +393,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>  		return;
>  	}
>  
> +	instrumentation_begin();
>  	synchronized = irqentry_syncstage(state);
>

This means that we won't have ftracing or anything that depends on
instrumentation in any inband irq handler triggered during stage sync
from this code path.

-- 
Philippe.
