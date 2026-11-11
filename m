Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419285;
	b=EaAgrXi1J8fvfCH8cLYGigukDNm3VkEmt+uh4WL/VO6GXFf2WhxWGtRWZzQ20DU5JWnW
	 ymKerSE5hmipaDN3UpQJPkwBC5263FB3lEs6GvmUmbowjvKw/Vk6DxY9uQzrA8CUE9wdz
	 ho/aq6nmi3oKy+nDdXHJ8yrn+/Oarsr6Puv5z+K3AG1H7ie0woJH7aySpYo3izcUA082j
	 ao8FBbxqXeWArkwWdvpRWm9DAZxe26kIrLxxTuyrV+Ke+ktpUaYPur3O/rPbkN7i3bpHA
	 UJ63bYGliuywJ8Zw2GTS0pa2cjJT5hBog8X0VCfiYjFDnvRuv7z4+bvvr2dRUziCD2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419285;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=gXiLqVeRPutSf8e79toukAt3M6KCnuxvZ7UuZIY96ak=;
	b=MSaVUiNCAEjBgrNqc0LnI5+p39syosfkzw1QymvsNy0rdm1sWmbwRC8WHT3Cy6D/lOyi
	 vSoDPhzf/KYdAn6ZuWI4jZhCVha4KkZuIdnCXW6+lThUNezeiWS9Kv5y+/1cJPaD+KcXz
	 hQb7Juh84Y/orLCO5w5KK9d/cn/rESvyHXZxsUoyfcPPLqx4bn0IS28PhjHvZIBp3eq51
	 vEES07gKEQSqqtMwCoBl7UKJl6Ap+PxOeOWUxNqavO3aC3HWASP3a3dioafmacv2SuEwQ
	 iZHIH7CclFA6JM6XGlPzYwVdgfgsj0v9hHv8kH+HfVpB5jyrbuXvnhYXZGfy4zXkPDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=HSMCSv34;
	arc=none smtp.remote-ip=217.70.183.201
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC09B606A893
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 17:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC09B606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=HSMCSv34
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03BB13F520;
	Wed, 11 Nov 2026 17:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794419277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gXiLqVeRPutSf8e79toukAt3M6KCnuxvZ7UuZIY96ak=;
	b=HSMCSv340bcdfDdzcpQMSoZYSq/84vywvSpCb7rRjG/MMgzWvXMf89Y5+vXe1/wZw0rSAS
	4OhgZ+mqK0Ehh3O66bbowKx/bsCWQJY6machzNaUFOFvfV+wWPwkF+by1uYV/W3jRkxnlM
	TBqKr14g8sxlB6N6IyoUCw7XCzrxJlKO77b1Cjo2Rbl9xlO1KQ4OWPivhiZOsUJVGFvX6T
	asmrJX+mgblHFbh/qbpK4v0rx2svunNpLKc/EvB2WPDljB1gpZB6T2/vO84G00pH9bRvs1
	UC3COGW0IP6G54YKEFlAoGj12PDLnCXyUUl1Q56gQf3OHPz0lyFw19oJUnywVw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: pinctrl-sunxi dovetail changes
In-Reply-To: <c5adedb6-0aa8-4a8b-b6b6-5047240bf58f@siemens.com> (Jan Kiszka's
	message of "Wed, 11 Nov 2026 13:29:12 +0100")
References: <c5adedb6-0aa8-4a8b-b6b6-5047240bf58f@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 11 Nov 2026 18:47:56 +0100
Message-ID: <87pkwb45v7.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTGlzVEXIK1CMkpm6BT5jplP+wO9ZyzUfvht7sClyaYk/Hvuogg4SHXDyfnFmBmyklBynTHICI9M5OPdmII5JZ9jhbtxUmi5FTqV7KkSTf29SX4RxW6iW2iMx8u4caQAZn7B2Q5RCGszgl5Q+DOcmM+WvhO/QkUKc18uV1lL4UhRyY3b2P+EdmsGN1NeU8EVpa1tbfoFoYmI2NDf85OAxq1ePmthcUdDPfyP3jvhpM6o74WC7y1sMlOU4Y9tZE2UlT2bsprJrvWWv9jkOTINBRki6ysXA0/tIvQFKaJ6ygx3XxNjxffKrEwBrb2JE0POO/UMC3OCPdam8uON71a/Lc6wPdN06VC2yGP78Oq4LhY8aB+neRXKGE+ta5W9cP+kSNmHPTe9N/Nbyf7uaU2jG4uLpuvP3fNfuyEMcZKGw4MSUNM6VboN8J6Rt4X3hl74fLcB+4sM7v/fUJiFDxumm6hQC9kQmdgKKOYNSYhdBZwvcwOmG8AQQkVNysK8chMdzyOBd6+27MD2wDsxHz47+gJ+IhFDSd9LENJ+s9ASTouK75kGqRAYXwIv8yiNY4iMdIt8YC64j+Prj0vYJTbtEEutcvBTO5EYb/3Lv1oMV7eOofR3G3OBBIuFHWDuE3JfC+vDWYaMJMvFi4jJlX4Vs2VM7QEJGiSYT3fwUmTScoa9Xw
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> the LLM considers this pattern unusual:
>
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index 31cd142ce0f79..fb73cdaa30ca4 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -1280,7 +1280,7 @@ static struct irq_chip sunxi_pinctrl_edge_irq_chip = {
>         .irq_release_resources = sunxi_pinctrl_irq_release_resources,
>         .irq_set_type   = sunxi_pinctrl_irq_set_type,
>         .irq_set_wake   = sunxi_pinctrl_irq_set_wake,
> -       .flags          = IRQCHIP_MASK_ON_SUSPEND,
> +       .flags          = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_PIPELINE_SAFE,
>  };
>  
>  static struct irq_chip sunxi_pinctrl_level_irq_chip = {
>
> Since day #1 of the patch, we are dropping IRQCHIP_MASK_ON_SUSPEND and 
> setting IRQCHIP_SKIP_SET_WAKE instead. Do we need the latter? And do we 
> have to drop the former?
>

This looks suspicious, indeed. I don't see the reasoning here.

-- 
Philippe.
