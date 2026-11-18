Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992902;
	b=3hah/msgBklh/lr5X1LUJyo+3aYkqwf3fHt/Kbe+2v2iA/ip7agiSjdt1z7MNNANlSzw
	 af06Vw7Lt3bhmy0bFYJcCk+za8Htw9SzfqYfxFSfaH8eVrd0IgwpogCqYK8ojfEqFMCS1
	 /eFfi+mzdNy/oftJEIrpZjnZAyCoexUs9hf4j0ZrGE2Jj/udXJcJtJJZmBGneoCGikAPX
	 NrBLFQYfKE5/DoQPCdJwO73Cj4IWQRvBurkCljLmOadJ3X3+uNX9aMbLzGCTow4QnW2TG
	 VirJilRGHO215KeQuP6zjqFQ+nZFPkWJ/W2txM8UvJFp3EcEXyMSdWfGA5JVx1Vkl8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992902;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=0GJtUXpGsNZaK4WCG6eKj9WoeHJOVhUSbhlLUcbWPZU=;
	b=f0EIhzVADcssKfcP4uKNxo3NjOtF3VxWnMaeQG7bJC3qEydr2AU6JPU0KuMf2oYKrEKq
	 +OnfUXcBzcGvN+LNPeBeYzq2y5qZkrn5RFm2ESD05MT9W5UuwOufJwChLV2Exmjo24o0J
	 gHGqob1rHUE/QWh63XBq2ix5zzxAKeP7dSq0/fSsU4DDknbVe19mHH+5So9HtFws9uEMF
	 n4H/hANUaeDO6Xb+V1Wf3YkNnsg8WwYQ4DLVZl42bNHF8stO/vfyf8dsJZ5su4aa/0QcO
	 Zh5+PYtRd4uo45/0Yg68hzSiVHh38Ky2ZHlOEaamszocf+OZhZnyUxofCc4IBXrrr3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=TgGONskP;
	arc=none smtp.remote-ip=217.70.183.195
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DF6606A320
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 09:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13DF6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=TgGONskP
Received: by mail.gandi.net (Postfix) with ESMTPSA id E6A381FCF4;
	Wed, 18 Nov 2026 09:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794992893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0GJtUXpGsNZaK4WCG6eKj9WoeHJOVhUSbhlLUcbWPZU=;
	b=TgGONskP+uudZcX75PmAAOZ5L6Ao2zkT34WQEP+WMxdAgqVc05JH6ImF7qxU/XFfG7Ynv2
	3K5Xxa8N52E5/iQkIE15IP/xPjVxqInJq8dAvhMp+Cwg8uuibhCJnyIzfBo3w6EgJCFFp4
	MxbdebspKE6dJooYDbRqvWHLUgpS77EIgF1i0zKaK+2d2Tkwx9VlSuS2LyhrpeFafgyiYe
	FymFIMS/ZqMA9YztIIjqy8Y7cHg/aMBCXdVw2Zt7lDHDTpGr7doaMYm2q0MhgNcp7u7l1r
	/rlFsyk2LSQURXK7zwR0en3OdY5w1z86oshXJn3fnmhzpaSfRNiAlMxNgkgEYw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [dovetail][PATCH] clocksource/bcm2835: irq_pipeline: set
 clockevent IRQ
In-Reply-To: <5e3b4c9f-6f1b-4642-a923-6c33188e9cb1@siemens.com> (Jan Kiszka's
	message of "Tue, 17 Nov 2026 06:06:39 +0100")
References: <5e3b4c9f-6f1b-4642-a923-6c33188e9cb1@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 18 Nov 2026 10:08:12 +0100
Message-ID: <87se0yeccj.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFsHVTTHJicWckjnETr474oKXdEpNbpSO3FFzhI5p48mrkivAUBhC9FitF2yVZylEESOG9qMauLkuoGe6Lk+ZjoIoqqlsPi2R4UvJL0/9cKGUi0qhoQABWXqHJDn0v15RZNV7LVY/dVbU513xauMFo2wGKdEL4t3VUEKrmu+bCALtzLmuDShMhZ/SoSN1l7piyWwZw3XW0xWWmQ+sN7KGnU3gL/cUUCCf9d8IJ1Qxw+kIv5Mn/8uxdo6ZdJ8L8amt7AaUtdPxLbzaYvVStJF9Ix/6ANlZAQEoX9XZQtmhsCB+htBUn6Pmap0o40JxE5AEKUBBz4DoGJFDfniPX6lPpGqY9VX+QfDFgVbjltXxp1eY5PihZKT639l8RiQob/5hbxHFP/lfQliyxyVwR57NKBL2ClQwlWzGCsTqr+6zFlTiU6Asz6E3jwaSjfG/FDvr1DffA5w4Q387/SjeoKnlItcja1IBoBWFxuVskh/6aXArQulNHC27OEY/z7IsjjBMP7Y3coqYt56I5Bz/7+wk/XrfKbj4hljvQu4NpayRclQrRry6rO8kXfnsO+DP/LRL3K81HncdsZPZOaFL83JKVUXLM0WJtz56byxoxwp9xmfqM2zTGdVpFCT8CAGGj8cAfvsMvCvKWQK801jlxwVITdOAUMkcQQRixromOuHOUKkg
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> The bcm2835 system timer never filled clock_event_device::irq, so
> switching it oob and marking it as IRQ_TICK targeted IRQ 0 instead.
>
> Assisted-by: opencode:Opus-5.5
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> The AI comes with these piecewise, this time while actually reviewing a
> 6.12 branch for the 3rd or 4th time.
>
>  drivers/clocksource/bcm2835_timer.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
> index c3d5739da5ec4..73ae9b678decf 100644
> --- a/drivers/clocksource/bcm2835_timer.c
> +++ b/drivers/clocksource/bcm2835_timer.c
> @@ -125,6 +125,7 @@ static int __init bcm2835_timer_init(struct device_node *node)
>  	timer->evt.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PIPELINE;
>  	timer->evt.set_next_event = bcm2835_time_set_next_event;
>  	timer->evt.cpumask = cpumask_of(0);
> +	timer->evt.irq = irq;
>  
>  	ret = request_irq(irq, bcm2835_time_interrupt, IRQF_TIMER | IRQF_SHARED,
>  			  node->name, timer);

Merged, thanks.

-- 
Philippe.
