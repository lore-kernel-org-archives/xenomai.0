Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082434;
	b=HXu0AVOsuPBBwTX6EoPNKYueM9D/Ntcqx9jZImJuSig0Lea26aczTknOK2tplv3UU0Eq
	 u2GyKz02Vzhl+1yomNYe/NcD73JW1rVugsyra4SqqxgEcKGQ7Ek1TZ4coLBo9zkmscnKm
	 7Ym8npDplg+1TxjN8u2f5F6W9ZEx//PsZf3kVVnV8WRrXkzLt6keEQwa8rlMyJ74zi49C
	 PfySkea1iPZx68EtzGyvQp6udWr3YZZv/ekkmtvT/l8R5rOZE8bG/P+EYDWVKzxQdOSIt
	 duoqHs9JVZ10KacxMlRtVKPVuwqww/jQB2lv2eI7e5e7UgeRVaS4SffBR76YS14pX4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082434;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-State:X-GND-Score:X-GND-Cause;
	bh=IeE++4VgIGFeuZSpDsJ7tz8to9rnvz+CZHWTAqf55s4=;
	b=ceAvtMwwSfPatmgV+uUGoZrzjls0itmpQJ67uRnNVuFN1YIY1mddSNKZhS05BKhxiZMe
	 r1scQ3AHcfQStk8PzPkJ6dRGv22DxfHIpq8kdDs/vNfqHFO9qLS3XiI6/plugsDNQxwve
	 ifRLetVKu0+pyVFwDO/ZlPyF97nW3HWzTGrw+b1ZKMYy8jSMPGqu+VsdyG/IXQWoJYjG5
	 VIFtcvf3qu8oBxkZ1vezb3IGttQL7bWr1iDDQHmye+2Pnxoq+D8VH7Whys+3OONaAc9fD
	 bkye1W7BpzcQv6hf05C7E5mirKgSWEonPNpX9nC+e8WpZIYRRVNA9ne00Qf+dyu+Y3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=aDxnwI5T;
	arc=none smtp.remote-ip=217.70.183.197
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE64606A33D
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 10:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAE64606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=aDxnwI5T
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CB563E80D;
	Thu, 19 Nov 2026 10:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1795082422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IeE++4VgIGFeuZSpDsJ7tz8to9rnvz+CZHWTAqf55s4=;
	b=aDxnwI5TTlQhAGvn1GaRykMZQGy84GR53S/EHvmsVw0MOQCUOe3rB58QRnFV6SgwV5Ll9i
	Wqt3q2kZLiaHtIBC2u6n4GHaFfEHV2q4BLVEq/Mm2H+EC/0s4bjJ86fdRRdGViAXT9xpnR
	qh1zFSQzAWFSWk/qPIa/6Kc6zJM+htdv7EVocfvdPRat4vlXF09JVjvw8821p+OJ/DuMqO
	h63V6OVMWkQNOebj12JR6lcAC0wSe3dXqeU5TItA3Yh6WJiCCYB/NQw7wRGVjTQWWBM4wP
	Fc93P7R6PWR1OD9Q966INcJ4plfIc1Gb7IYI1pJtO/dR9Mi9qBwvb6yaCP0mVA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [dovetail][PATCH] clocksource/exynos_mct: irq_pipeline: set
 clockevent IRQs
In-Reply-To: <adf07ac3-1539-4a65-9344-b5c66d4e8fa4@siemens.com> (Jan Kiszka's
	message of "Thu, 19 Nov 2026 07:40:27 +0100")
References: <5a8651c3-9f93-4ae2-b1b4-0fcbdc5a1501@siemens.com>
	<87mrr6ecc5.fsf@xenomai.org>
	<adf07ac3-1539-4a65-9344-b5c66d4e8fa4@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 19 Nov 2026 11:00:21 +0100
Message-ID: <8733sxp2dm.fsf@xenomai.org>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGolq67ZbJD5psV8Vm9UGsd3FRnGQcXkCnYJS0isYibisB2Scwj6pYrTqnh3y+idkzRyNaJSv0usmFudDJPKmXN4VFj+cqvfuD7rOAXYkO+YVQNCWrIaXeCuasepZetwXN/N1WQ7ObeYaGeCCA+Kp1G3SWvrL7aoqT+kU+tmbzUCy1KxnSdU+m1KugvUbOb1fK0JAfATH9WgIXpttCEVO9mahdvUXRsjYZ9Ti1yDQp+fftUhh40MH/eBh8YIxPyJQZn8ZczYvoki2EKSEX/Y7pcRfIn2ZOFec1fA9HNdFzRe+Vcksv8a1daHEXn8HwJgIOjdQnCV3a8+dMBa4DBzpAGh6DbvGWgDHwo48w+pE2FWLVhawLiXF/TQBOWb81ZOaReYI9IuSL0CCsYf8oE/LU6tEBmZr5+4I/TKvEn9+JKTLLLr9UaiaWJILD69Bd8SnsWKs+W50XlJN72GxalHRRwL1HrLpVWdSi7edrVzLcto6AydCfm/DzESRkafO1s18O8Q0w+7i1hnT1YFFbeDIk/p049NhhY2qtS3F1mW9GRQhCLeEYM31aiEBj7bCGKXm3QpST3ln+TTNQ+U7GtkFiV9LEEz7RNlMZoi24/zzHe2jVNgsardsY0+9xIp77qlyHoDQkliFWGIXfA9CSrSGi8DixwyWR1B6JNKmYRKqAXdg

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 18.11.26 10:08, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> The MCT driver only fills clock_event_device::irq for the local timers
>>> in SPI mode. In PPI mode (samsung,exynos4412-mct), the per-CPU tick
>>> devices were left with IRQ 0, so the proxy tick device never switched
>>> the local timer interrupt to out-of-band mode, and the in-band tick ran
>>> on registers which were never saved, making every tick look like a
>>> user mode tick on ARM. The global comparator device had the same
>>> omission.
>>>
>>> Assisted-by: opencode:Opus-5.5
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  drivers/clocksource/exynos_mct.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
>>> index 23d39bf9bdaf9..a548ac338f3bc 100644
>>> --- a/drivers/clocksource/exynos_mct.c
>>> +++ b/drivers/clocksource/exynos_mct.c
>>> @@ -350,6 +350,7 @@ static irqreturn_t exynos4_mct_comp_isr(int irq, void *dev_id)
>>>  static int exynos4_clockevent_init(void)
>>>  {
>>>  	mct_comp_device.cpumask = cpumask_of(0);
>>> +	mct_comp_device.irq = mct_irqs[MCT_G0_IRQ];
>>>  	clockevents_config_and_register(&mct_comp_device, clk_rate,
>>>  					0xf, 0xffffffff);
>>>  	if (request_irq(mct_irqs[MCT_G0_IRQ], exynos4_mct_comp_isr,
>>> @@ -487,6 +488,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
>>>  		irq_force_affinity(evt->irq, cpumask_of(cpu));
>>>  		enable_irq(evt->irq);
>>>  	} else {
>>> +		evt->irq = mct_irqs[MCT_L0_IRQ];
>>>  		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
>>>  	}
>>>  	clockevents_config_and_register(evt, clk_rate / (TICK_BASE_CNT + 1),
>> 
>> Merged, thanks.
>> 
>
> Thanks for merging the first bits. Do you plan to push soon, or are more
> merges or tests on the list first?
>

Still two patches to review first.

-- 
Philippe.
