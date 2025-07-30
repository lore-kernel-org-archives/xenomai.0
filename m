Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A6323741
	for <xenomai@lists.linux.dev>; Wed, 30 Jul 2025 20:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753907520; cv=none; b=R+zcAB93AsgL4BPl7M4u9gkRTC8PswugWlJsIiCrSxy5U7NMXbPcHIFXf/Ox5FTEOmFWtFrzhr5SuDxKtTOa3Mj2IXP4HgcQeZW61Hz9T0cVD2s6+IkuCn94DGKP1R72RIj90HImkm6q5R6OJdycpa7hnIozloCHxQ4e7X/uF3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753907520; c=relaxed/simple;
	bh=JW4QrUv25gJxXyyhjNAiKJbhm98pN+KGAA+Bd5VMdg4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gpjTaGvofeY3L708R1AtOz3+6RDEzxo3s1R+FB43QTpbzi7v29wzI0X7yoDHzV1WI7fjXThK7WJ5Tj7ZmWUMd4MQ8AYu13y9WE7ks2NH/fXrC/XLwrx/itR9JvbFGxAOHDLwUbfMBu8u4XOMRszz0w6ohH7rhr6gtX+aN9fDN78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=QQ3n20r0; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="QQ3n20r0"
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA72F1F68F;
	Wed, 30 Jul 2025 20:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1753907508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTPEmEQgsHx10NoX7b+8+3s410xxsVtEirOkpYENZck=;
	b=QQ3n20r0P6sA3kHF1RL6QRRc0obZmXXyvUXX/ujjHojSjuMTeY9+HQHUEfPO1CKRrzWfq+
	B8+MDqzntgwXuiguH0SahDijEZ1jLLdPvbh1Yyi3g9XmmgB8CLfbKmv3HXeUX96o773A5Z
	Egg1aTsY5q/fsWBkZplpCjgAj4Ur2itR1pS3x7AtS9xa0KduqVUnPsiZIHLPThvQn25f/v
	TEvxG6gHFo1bRsbXFzPkeKS6OQWoNbk5ZuTRECVupB06nzf4dOKGMxd4MFjKDiu3j/JBRc
	y3+nzFEfuMwtYtAZ8OS7RJD8qPBkU09BXHstDhiytAiR178Q8lUwVJvgSq7TUA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH dovetail-6.16] generic: irq_pipeline: Fix fallouts of
 lock guard conversion
In-Reply-To: <cc22b13d-7324-475c-b060-641a9ec617d0@siemens.com> (Jan Kiszka's
	message of "Wed, 30 Jul 2025 21:39:44 +0200")
References: <cc22b13d-7324-475c-b060-641a9ec617d0@siemens.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Wed, 30 Jul 2025 22:31:44 +0200
Message-ID: <87frede7yn.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> The irq_chip_generic struct uses a hard_spinlock to support the irq
> pipeline.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Should unbreak the Xenomai CI pipeline.
>
>  drivers/irqchip/irq-bcm7120-l2.c | 2 +-
>  drivers/soc/dove/pmu.c           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
> index 28cebe480eb1d..a2f8433d9a564 100644
> --- a/drivers/irqchip/irq-bcm7120-l2.c
> +++ b/drivers/irqchip/irq-bcm7120-l2.c
> @@ -68,7 +68,7 @@ static void bcm7120_l2_intc_irq_handle(struct irq_desc *desc)
>  		int hwirq;
>  
>  		gc = irq_get_domain_generic_chip(b->domain, base);
> -		scoped_guard (raw_spinlock, &gc->lock) {
> +		scoped_guard (hard_spinlock, &gc->lock) {
>  			pending = irq_reg_readl(gc, b->stat_offset[idx]) & gc->mask_cache &
>  				data->irq_map_mask[idx];
>  		}
> diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
> index 7bbd3f940e4d9..142ccda535176 100644
> --- a/drivers/soc/dove/pmu.c
> +++ b/drivers/soc/dove/pmu.c
> @@ -257,7 +257,7 @@ static void pmu_irq_handler(struct irq_desc *desc)
>  	 * So, let's structure the code so that the window is as small as
>  	 * possible.
>  	 */
> -	guard(raw_spinlock)(&gc->lock);
> +	guard(hard_spinlock)(&gc->lock);
>  	done &= readl_relaxed(base + PMC_IRQ_CAUSE);
>  	writel_relaxed(done, base + PMC_IRQ_CAUSE);
>  }

Merged, thanks.

-- 
Philippe.
