Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A3A2E8B83
	for <xenomai@lists.linux.dev>; Mon,  8 Sep 2025 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335267; cv=none; b=IY/0YBHBaY+7TpGCGsG3R7Fe/UKht30BH9MwFU117Xb69+HRuOEUI/jjtWZBmaoBvSay3wGGHbfN9WOnChmrsRofY+VEkens2H8OiBC8dgJowIj0R/3Uak07q9VoKIx5rhrkylm6dY1KP+AA+IRRS3Y40HHkVbkeCEanDS2g1vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335267; c=relaxed/simple;
	bh=FhTDKqiIs0BzaUvaUzhStRIqekC1dBJcpijLtznlSlg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MECX8Sn6fO+Wz1Gxr6nnUgq2pDc5E2h2ba9raHPpfKQefnhW0IxxuTjpLLhSDRo6lrSXI/duiX1UtEXFD6SaOG2cXdiXrMjoZ+lLsD6drG88kh9Il+k+EcHqr7vYf52VjutkteqYsXyNtKYMW9nU6AGaw8dOvoKfUqlMxyFGMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Vs+0xOrU; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Vs+0xOrU"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 04CBC440EF;
	Mon,  8 Sep 2025 12:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1757335256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsXEhhdTGbjyFk0CA/wv8FfHm364n2jQwD6+SOHyId0=;
	b=Vs+0xOrUNZcnmL8NibDcH2Skk9DaG0PJKD/8TAURv0HlFn+lBuRIXQQsPGOfKDDMeD7f7o
	VFizVDyb6bb+jwiSynd1d6t5GzvmSxT+EO7Hq+eFlOaJtQxaeVqDzR4v//o0DLwsgxGbOu
	3EolenKPsEby+PriEdC2MGZuj+Wxea8WLLzpODMOVvvkDSMOUv5DesX/ENyVdMe6PwstVx
	mAR5tpG5JDX/NMkEOWeya6Cv17vfYOjkGMEpHFDJqJvrGpyfQVqcKv41bEqh2UmyjG2thE
	1tweW8jcqg+9I3HqPskcnaVXm3RnHhvIj2ly3wPQSyFWhZIqcN1AckCfdTFgqg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.16 v3 3/3] irq_pipeline: Fix pipelining code
 for level triggered IRQs
In-Reply-To: <20250820-wip-flo-fixes-for-dovetail-6-15-v3-3-ae4a674d8e10@siemens.com>
	(Florian Bezdeka's message of "Fri, 05 Sep 2025 16:26:27 +0200")
References: <20250820-wip-flo-fixes-for-dovetail-6-15-v3-0-ae4a674d8e10@siemens.com>
	<20250820-wip-flo-fixes-for-dovetail-6-15-v3-3-ae4a674d8e10@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 08 Sep 2025 14:40:55 +0200
Message-ID: <87ldmp86co.fsf@xenomai.org>
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

> During the last forward port to 6.16 the pipelining code was
> accidentally removed from handle_level_irq().
>
> Forward porting the (old) code from 6.15 again to fix this problem.
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/irq/chip.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 8a0831193d74..f5dfc378ccf2 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -846,15 +846,33 @@ static void cond_unmask_irq(struct irq_desc *desc)
>   */
>  void handle_level_irq(struct irq_desc *desc)
>  {
> +	int flow;
> +
>  	guard(hybrid_spinlock)(&desc->lock);
> -	mask_ack_irq(desc);
>  
> -	if (!irq_can_handle(desc))
> +	flow = get_flow_step(desc);
> +	if (may_start_flow(flow)) {
> +		mask_ack_irq(desc);
> +
> +		if (!irq_can_handle(desc))
> +			return;
> +	}
> +
> +	if (should_feed_pipeline(desc, flow)) {
> +		if (handle_oob_irq(desc))
> +			goto out_unmask;
> +		return;
> +	}
> +
> +	if (flow == IRQ_FLOW_FORWARD) {
> +		forward_irq_event(desc);
>  		return;
> +	}
>  
>  	kstat_incr_irqs_this_cpu(desc);
>  	handle_irq_event(desc);
>  
> +out_unmask:
>  	cond_unmask_irq(desc);
>  }
>  EXPORT_SYMBOL_GPL(handle_level_irq);

Ack.

-- 
Philippe.
