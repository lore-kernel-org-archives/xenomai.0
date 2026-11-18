Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992915;
	b=SVksa3o43vbXj6USO9lFfMKefzDuCQrZM2T0mOavYAp/+XWyAqJ3zEuvVT+HdvklvsMv
	 mOzM6NqmK/R0OMikw118Gx5JsgQwaZ8xvya2gMduFDc5+DS6UwXjnc0BFeF2nNzSeNZs+
	 tjyXxXzx/frXlN35HK7yQ4MK5rrt4KbXG3e8fRqjIQppGYmpvXIRQbnpKgDYitW3pk0oH
	 IoZSEZiIoUoqTdgHnyywpqSZdOnWkz3xyxzl8jtuyieq+N0sNAqv0IxCuKpn/YEH4bti4
	 dKiN8OjtRjCgI/U85YzawtLcKMZwsTy1Y/vytz6s3W5/9JA0op2AHrAGT79DHk9e6VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992915;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=srfDmseU9aACmJjDGm+TYqnFCqIqdzETRA6w41lrc7E=;
	b=zNpnxiqzHfB0zrVkmpk8MZZRTlnGx8yQRzgNDuKyPDKvnpQ2i+sBnbo6lqkTUpreY9nP
	 HMig85gkUw+Zr3ooWmW7gvNmYkYADJGG9Q4O/s4NRYIlfanCpRTR2Y5wVUizzSlcwuCjY
	 UFfYOnDhycINk+xrbQMyuyg8zkDM0UrnDXx8sDn/D/Jm/9h0Q1OpqcDATYvPYrlmjgJuc
	 Eb/bekVP+z9FPHsnXIPrfwTQ75OX6cWa+2fX23dNwn5IQPltZnhv33m5UVEwyXGtz+RbY
	 ykqYQn0Ak7lnoRUVfqG1mtxvpmRW90BVB5dgc83TAWN71sTeKz3wJ+vfhHwiB5/LZDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=Yk8a4jlI;
	arc=none smtp.remote-ip=217.70.183.201
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6AA606A31C
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 09:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB6AA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=Yk8a4jlI
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB5A03E811;
	Wed, 18 Nov 2026 09:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794992907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=srfDmseU9aACmJjDGm+TYqnFCqIqdzETRA6w41lrc7E=;
	b=Yk8a4jlIoHO4amn3ZA6VWzefi3IR8BMWsWZSATymGHYSSPvJEP9sVnmSOvi7UlyvT+0c7T
	ZuWTwn7qUflqAmfhwQo4Va/F8HjjtCjSI28fK9SD3g51UNfWtRXe5OwYkzMqYEDvjK6B8l
	s/NJO3izHTIst4K9l4TcXusSl9PraBODL9RnGT7AOFDxlrQxEQ+bNBavCiDguMJSTlMabW
	ThSJt+eLKzGMn3UpD7RqInPg27fZHEFrZaA7GLUYaE0W/YYMlPB0V3/xvPqj0E5BCVLeVz
	PYWL8l1bSxI7gwoaOEoz0FZ6xtzvL/HKEcyDpE943e1NVOKDYt02g7FZngfVgQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [dovetail][PATCH] clocksource/exynos_mct: irq_pipeline: set
 clockevent IRQs
In-Reply-To: <5a8651c3-9f93-4ae2-b1b4-0fcbdc5a1501@siemens.com> (Jan Kiszka's
	message of "Tue, 17 Nov 2026 06:06:46 +0100")
References: <5a8651c3-9f93-4ae2-b1b4-0fcbdc5a1501@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 18 Nov 2026 10:08:26 +0100
Message-ID: <87mrr6ecc5.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFsHVTTHJicWckjnETr474oKXdEpNbpSO3FFzhI5p48mrkivAUBhC9FitF2yVZylEESOG9qMauLkuoGe6Lk+ZjoIoqqlsPi2R4UvJL0/9cKGUi0qhoQABWXqHJDn0v15RZNV7LVY/dVbU513xauMFo2wGKdEL4t3VUEKrmu+bCALtzLmuDShMhZ/SoSN1l7piyWwZw3XW0xWWmQ+sN7KGnU3gL/cUUCCf9d8IJ1Qxw+kIv5Mn/8uxdo6ZdJ8L8amt7AaUtdPxLbzaYvVStJF9Ix/6ANlZAQEoX9XZQtmhsCB+htBUn6Pmap0o40JxE5AEKUBBz4DoGJFDfniPX6lPpGMHOBBiBm4VjMvS/nXj3ibZn/OMpj0G1q27Whaa381bFZrItxGC+3PDiFgRxDVwINzP9X1koacgXDleQUXRbbfUn/8CtAEIjnqS5tRvtE5079bN+ygmPoYKrKnqh6kJHpC+SQuAdpQshB8vJkLL3ATG2wQ6eqg+uwo+L30a9GF3aDOKIo/zP3X8Wz9HZh2bn4pWOXWG68xf1hN1vXqRY+TC9IgMKzFXXitN64HwEoyXBBdG2WqJkzZy3f7nX6opwYurmzsIDZ5mxZr0mWUuDCPn8tfztMkklzEU6EOtq/8VvgKstwlFC2zOhfjm3FO6fl3VNQgXvAtN3ElXfp1pSwdw
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> The MCT driver only fills clock_event_device::irq for the local timers
> in SPI mode. In PPI mode (samsung,exynos4412-mct), the per-CPU tick
> devices were left with IRQ 0, so the proxy tick device never switched
> the local timer interrupt to out-of-band mode, and the in-band tick ran
> on registers which were never saved, making every tick look like a
> user mode tick on ARM. The global comparator device had the same
> omission.
>
> Assisted-by: opencode:Opus-5.5
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/clocksource/exynos_mct.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 23d39bf9bdaf9..a548ac338f3bc 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -350,6 +350,7 @@ static irqreturn_t exynos4_mct_comp_isr(int irq, void *dev_id)
>  static int exynos4_clockevent_init(void)
>  {
>  	mct_comp_device.cpumask = cpumask_of(0);
> +	mct_comp_device.irq = mct_irqs[MCT_G0_IRQ];
>  	clockevents_config_and_register(&mct_comp_device, clk_rate,
>  					0xf, 0xffffffff);
>  	if (request_irq(mct_irqs[MCT_G0_IRQ], exynos4_mct_comp_isr,
> @@ -487,6 +488,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
>  		irq_force_affinity(evt->irq, cpumask_of(cpu));
>  		enable_irq(evt->irq);
>  	} else {
> +		evt->irq = mct_irqs[MCT_L0_IRQ];
>  		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
>  	}
>  	clockevents_config_and_register(evt, clk_rate / (TICK_BASE_CNT + 1),

Merged, thanks.

-- 
Philippe.
