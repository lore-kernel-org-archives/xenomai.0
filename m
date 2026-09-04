Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66644A1E03
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535088; cv=none; b=A9oeOdO3qahk8ii0Aj9hkpYOzcZW3/GlHlRwG068QX1aPfXeu0pI0xGc1dSm4ugm7NdOLnIDvRK2fLK4rRYGJJ7KOsmkoaotNBzHrqIDVreCeHvdVXiorcs5ipuyJl72Mudp9hsEiSs8ZA0E0CSkuFVlTzPbvwCKkqWXJCTBK6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535088; c=relaxed/simple;
	bh=fedG0FnGte784Y5gqDEsb0xzB0JJmx3fM2SvGTIXtr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tkkn4UUBDx5dLZHglqC+hWPoA59GkvRqnSZqwZzknPPJQYABh2/OR4E1gvsc18QfsXYU8wy6nnfTDSzM7rNyyDSMSnuCV28U+SlGF8c01rgQi2zMdxYROSyJHcgyoE79l/Ko5a7vyRFgBTyKTISPPN2mjLRE5PU1XaanOueXmew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=DDv3fKvn; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="DDv3fKvn"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E17083EC78;
	Fri,  4 Sep 2026 15:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1788535078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wNYc3uxOG5ahqYVppRtqEhXlO4v+HNygK5pk9jwgo50=;
	b=DDv3fKvnpmj5BABGRaZMxnMj0fcWB6B7C0oDVLnjopS3KbvTLSKzkcI/FySDrhhROLzpWB
	vjWaxx7hn43CmGbQ9GGw58wimvfOqBP5ERgpnNe0MxbvzSrChLPbrMss3z9wcSgB777nlk
	PyPTLmmQABGO8YOm1aOQqxNrFppZZ5BYpYCvOm5DObVR8PJEX/PT6AMXQQ0cP0u11zSkcN
	NKdGIvclLNNN5viHlkLZVE37CzoF1pdqJf9EeqZzauPb/gI9+c0QKTvNZzU5O3XxTBi+tE
	QfMxIDizkR4VMB4tZ6HVpYb4Bb7us2QjegTefhc6PLzfAlMs1vkLRMM98pP/uA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Andrew MacPherson <andrew@elk.audio>,  xenomai@lists.linux.dev
Subject: Re: perf getting all-zeroes IP on STM32MP1
In-Reply-To: <9e0b7d3e72a19bd900a14faa6c459f5a2e093982.camel@siemens.com>
	(Florian Bezdeka's message of "Fri, 04 Sep 2026 16:08:02 +0200")
References: <CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com>
	<9e0b7d3e72a19bd900a14faa6c459f5a2e093982.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 04 Sep 2026 17:17:57 +0200
Message-ID: <87wlt1cafu.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTGMAmK9nOqONyig77zUa9b5mpdmE5DP4xDLn+18H0wi7wkDqfEb8h0UE9hrAs104l0fUMiY2yxWRnKpqDEMVKF/ApSXblExh3Su69I/h9M8jltjOd8VDh/NOb/bD6t7dBJZDitdGzvmTFqj6lYgV12ApVNz7tJ1OFgKfk9nT58ogHLGQ/Wv7WHJGoxsfk+LG8FHMkdcG3wNYL1ch2GEJDKC52TAQq13QIEqO+zgMot1fvJKMqbH2muWglbO8YWgV6WHc/1FhjLUqSJhg4bH9xtF2o8uL2pAsefDnd7yk77AmCksWUbiEBJL40mRHAf4xRM9MdXWcYZPab7hNW55Rm7VKo7YaHS5Yfx7GB7asHF2GlMw8k0175nglLFqShZK2UztS7g69h5nzNywP6rIy8igEBcn7KK+ycQthxoeK3eKnyvaF8AAnesSnzE+pubAZJ4k4T0Mq8tb1VBOoMKB/SK2ZFxPCjxqR0ForNa4+5fvLS0avTCkHEc2EmNkdDQOtrzsVVf9XdPmGNfIYnxxP473Pd8TwMIl75UFb6XK9QU+XF3RUQv28l3QOP7zF5iKwhxRyJhyc/AX+6SdQuLJL4qMGON2D4r6y4gyd42h0c04p5ctAhRBaky+kigKmY6ofmiAfOxPMK91HgBHwnK/mAy6GgGgtdQSrvvjCK8nTi43DA
X-GND-State: clean
X-GND-Score: -100

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Andrew,
>
> [CC + Philippe]
>
> On Fri, 2026-09-04 at 15:26 +0200, Andrew MacPherson wrote:
>> Hello,
>> 
>> We're working on an STM32MP1-based system running Xenomai and found
>> that perf top shows every symbol as "unknown [00000000]", i.e.
>> profiling is collecting samples, but they all point at address zero.
>> 
>> I'm not a kernel developer but went through a few debug kernel builds
>> with an agent which eventually led to the attached patch. This change
>> does resolve the issue with perf, however I'm not sure if it's the
>> correct solution.
>> 
>> The reasoning is that arm_arch_timer.c's percpu IRQ registration never
>> sets IRQF_TIMER, so Dovetail's copy_timer_regs() never populates
>> tick_regs, leaving get_irq_regs() to always return an all-zero
>> pt_regs, which in turn breaks perf's sample IP.
>
> Yep, that is wrong. The patch you provided looks OK to me. I'm just
> wondering if that should be addressed in Linux as well / first.
>

In fact, Dovetail is somewhat abusing IRQF_TIMER in that the only bit in
that mask we should care about is __IRQF_TIMER, which is only used for
recovering from misrouted IRQs these days, specifically excluding some
descriptors from the polling loop which tries to find a proper
handler. Problem is that we also carry the no-suspend semantics attached
to this mask when using it, which is not what we mean.

I think that the mainline code simply acknowledges the fact that per-CPU
interrupt handlers should never be polled for solving a misrouted IRQ
issue by definition, so there is no point in tagging those lines with
__IRQ_TIMER in the first place, which applies to the architected timer
interrupt as well. IIRC, that was the point of the recent set of
upstream changes to request_percpu_irq(), dropping those flags. Such
change prompted us to put back a secondary interface accepting flags so
that we can keep on passing IRQF_TIMER.

> @Philippe: Any additional thoughts? Should we take it already?
>

I believe that we should not live much longer with this hack, we should
provide a dedicated IRQF_* flag introduced by Dovetail instead that
would specifically say "this line generates deferred tick events" or
something along these lines.

>
> @Andrew: Could you please provide a formal patch with proper signed-off
> and LLM notice (assuming agent means AI ;-)) targeting the dovetail 7.2.
> branch? That should help to speed things up. Thanks!
>
> Florian

-- 
Philippe.
