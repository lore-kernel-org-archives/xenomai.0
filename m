Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7F54EE87D
	for <xenomai@lists.linux.dev>; Mon,  7 Sep 2026 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793259; cv=none; b=qj01Ct097TfWCIaQRnCs7a0Jzg+o2JZV2YkBCKece8AGRd7shOX7Y0wWJDlwYWWXxSyla3UcFd4lE7/iD/Szt4wY8Mo3/pYoZcIwmYdDAZI5hTMB9sWuO5f1ZCB4pCzKP3kU2zybh1IptHXdCsHJCwY5+fB0LualefjLTO8PEOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793259; c=relaxed/simple;
	bh=C7Sk0BE6Mnu2TXjRHA2fOylOVVNuiHD0Nw9KwCri0nI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WXzC9RFtLlzAeDSbByG0nyFmir9F8r1gxkALfVn5yizHZbCFqXwBTJzkWHr4vmzd/AmD5K+ur79PLOMppXRGa/9Fb4wAurmRK8bhfeMszQTp6+bu5AUigJi957uGWTWddQYz50tMa6hNphxd1UBh2o9ilrGlqTXThau1Vslhi7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=TH9fL/YA; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="TH9fL/YA"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 08A733EDD6;
	Mon,  7 Sep 2026 15:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1788793248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5xiObFYjIyDLJOQKaRRc6PbGwh5SkMZJOe5pv4U/Zw=;
	b=TH9fL/YAuS5lnAdvKY8kka/BlG67tndkiX8jch6QaKmmjWpM4BTRNbHcF3IvYBhCjQAXmK
	cXdB+5nn9EgXcdLhz7ah0ZsmeQMPWt6H4nPANGnt/QIn6YaJD5f3MeY8HfQ/01I0drklFk
	mQmEG+6JFuOyGbactMGY/+Ab7+XxvM6K4Mqh3PStdNeDUCwq1RVtCS+TYFZSZCU0uKp2NJ
	JG8y57sZd4F8noYD9PslOazlF3kOMVDkAvdAP2HFYD0bflVtDdawmRMBuEacH4fLtmmG5h
	OD+EuTeznPEKa0iQo+EFrssSg/0qLXz+5siQ8ab1osEcWX7Vtot4UNRuu+QUDA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Andrew MacPherson <andrew@elk.audio>,  xenomai@lists.linux.dev,  Gerte
 Hoogewerf <ghoogewerf@lmi3d.com>
Subject: Re: perf getting all-zeroes IP on STM32MP1
In-Reply-To: <a14e0d0f9ec97f6064a1b2fb221f3ee5015e2241.camel@siemens.com>
	(Florian Bezdeka's message of "Mon, 07 Sep 2026 16:39:21 +0200")
References: <CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com>
	<9e0b7d3e72a19bd900a14faa6c459f5a2e093982.camel@siemens.com>
	<CACiVkwkc6nzD1qv7yzUR=a3GMPO+b9kp53sBVVKQpiW0NJX65w@mail.gmail.com>
	<dc1c6765187854e0758378af34098a64a8f7bf3b.camel@siemens.com>
	<87cxupgrnp.fsf@xenomai.org>
	<a14e0d0f9ec97f6064a1b2fb221f3ee5015e2241.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 07 Sep 2026 17:00:47 +0200
Message-ID: <877bkxgl7k.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGaa9HM7v3jY8NcDuXgZ/rqUNbSBzgZ2n3apKusOOP5h8cx3Xt5ns1FvmAiyhjy2wKultLXFeP2VD0YHnKG5x5HVLTwfPx+3knFXYHqJwVBFPXXllQDVl0mP/lIAp4gXof4YQMSZh/tlD/suMpHpxz+y0BiaiUfyiXyMMFOd3CFlMromfK5wShq1Wg5oMAGZP8g4UvmtYYwfzOtgxJJxxKmAKx6kz05rmrz0vkhukE0QXZPUkH7JTC10fzWj7FFNkjeSy3Eymeac9Aqqv02Y2FJ3A1ObXyoXApR7hew6rt9q0G3yzqdfyJ3pYaGjzxkLKlIzS+PwoVZH/10g72BNfXEEZ10Jgmvs4cbIaSOB/cgia0cCe9iveauhpCuDLtzj33wh/YxkusTOyofyJ8QP/ctKsvb4lzK4+68gNrCoC7xkjDvuKtQyUm9JPWlkAeHzvn+JJt9m+MmSu6bzxDaMKR65HbGuq72FeQT3biLbTNJTI6f8hJt0Np2Odc1nG1Ng98hZk5IPRAVjHVfd3CVlwjd2QpvsVOwASXrL4B7KDchta8NBRr/EUbKNzsRcWQnmOTRkUtY39vlxZBUcA0EyTEEXVmkjy+wC1at3hfBzgWgch7wVsqxUAePKGAedmrWUBlYEJX16DT5+7RJwbBzsuGVjYuN3xRafowYgFQJEYh+SQ

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Mon, 2026-09-07 at 14:41 +0200, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > On Mon, 2026-09-07 at 10:57 +0200, Andrew MacPherson wrote:
>> > > On Fri, 4 Sept 2026 at 16:08, Florian Bezdeka
>> > > <florian.bezdeka@siemens.com> wrote:
>> > > > 
>> > > > Hi Andrew,
>> > > > 
>> > > > [CC + Philippe]
>> > > > 
>> > > > On Fri, 2026-09-04 at 15:26 +0200, Andrew MacPherson wrote:
>> > > > > Hello,
>> > > > > 
>> > > > > We're working on an STM32MP1-based system running Xenomai and found
>> > > > > that perf top shows every symbol as "unknown [00000000]", i.e.
>> > > > > profiling is collecting samples, but they all point at address zero.
>> > > > > 
>> > > > > I'm not a kernel developer but went through a few debug kernel builds
>> > > > > with an agent which eventually led to the attached patch. This change
>> > > > > does resolve the issue with perf, however I'm not sure if it's the
>> > > > > correct solution.
>> > > > > 
>> > > > > The reasoning is that arm_arch_timer.c's percpu IRQ registration never
>> > > > > sets IRQF_TIMER, so Dovetail's copy_timer_regs() never populates
>> > > > > tick_regs, leaving get_irq_regs() to always return an all-zero
>> > > > > pt_regs, which in turn breaks perf's sample IP.
>> > > > 
>> > > > Yep, that is wrong. The patch you provided looks OK to me. I'm just
>> > > > wondering if that should be addressed in Linux as well / first.
>> > > > 
>> > > > @Philippe: Any additional thoughts? Should we take it already?
>> > > > 
>> > > > 
>> > > > @Andrew: Could you please provide a formal patch with proper signed-off
>> > > > and LLM notice (assuming agent means AI ;-)) targeting the dovetail 7.2.
>> > > > branch? That should help to speed things up. Thanks!
>> > > > 
>> > > > Florian
>> > > > 
>> > > > --
>> > > > Siemens AG, Foundational Technologies
>> > > > Linux Expert Center
>> > > > 
>> > > > 
>> > > 
>> > > Hi Florian,
>> > > 
>> > > I've submitted a patch now against dovetail 7.2, let me know if you
>> > > need anything else and thanks for the help!
>> > > 
>> > > 
>> > 
>> > Thanks! We might consider merging that while working on a better
>> > solution - as suggested by Philippe.
>> > 
>> 
>> Unfortunately, thinking a bit more/better, we'd still have an issue with
>> what I suggested. i.e. There are three contexts we need to care about in
>> this case:
>> 
>> 1. when a timer tick can be immediately delivered to its handler
>>    (i.e. hw irqs on) from a line tagged with IRQF_OOB.
>> 
>> 2. when a timer tick can be immediately delivered (i.e. in-band stage is
>>    installed) from a line set for in-band delivery (i.e. not tagged with
>>    IRQF_OOB). In this case, the interrupt log is synchronized before
>>    leaving handle_irq_pipelined_finish().
>> 
>> 3. when a timer tick /should/ but cannot be delivered to the in-band stage
>>    because the latter is stalled, i.e. need for deferral via the
>>    interrupt log.
>> 
>> In the first two cases, postponing the copy logic to
>> clockevents_handle_event() would be ok, because the interrupt frame of
>> the timer event would still be active, therefore using get_irq_regs() to
>> find the regs to copy would be correct.
>
> Agree.
>
>> 
>> In case #3, we have a deferral, therefore the interrupt frame is
>> certainly gone when the in-band stage is unstalled. Since other
>> interrupts could happen in between, we are toast.
>> 
>
> Hm, when setting up the proxy device, we mark the affected IRQs as OOB
> IRQs. Doesn't that mean that we end up in clockevents_handle_event() for
> those IRQs as well? That seems to be the case, if my debugging here is
> right.
>
> We want to copy the registers of the last OOB timer tick, no? That looks
> doable, but I might miss something or just did not run into the "inband
> stalled" case.

We want to copy those registers every time the profiling code may
consume them, including when the tick is delivered to the in-band stage
only. The proxy tick infrastructure allows for enabling only a subset of
the CPU range for oob traffic, other CPUs would keep on receiving timer
events from the in-band stage.

In order to extend the test case, I would tweak oob_cpus and look at the
perf results for a task affine to a non-oob processor.

-- 
Philippe.
