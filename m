Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38D53A9605
	for <xenomai@lists.linux.dev>; Tue,  8 Sep 2026 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855126; cv=none; b=WfZk3ks0Q+Be1nGeHwGp5VvenfWmZsV2He6LkELO5iShfEpegWJh07wyAGgoVu3DevhSLyXFcWmS5I+bgUzZpR2iblEDWH7vgOLDuG9orA0eT8SZGuadKBQwkNZLBGs96mTqKWO6MKNg+RGFhcrzM3m1QodsczmbRg0hxyvy9FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855126; c=relaxed/simple;
	bh=LFKb3dGrUVukQwgVGkVXbQO3vzGtGOtMYq4oKrJ1xS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MKAXGvzzC/F3pRlr0FpqA84V7prJo4I5MxtUUsWFUfo3SPsX1c7N3CuKPxvi8ALtJ0QsZy4/jSdox7o5k3/PKCkp5jhZJU/jOXfkUEIKO3B8v0fWN5OjCYtIbyujOWGfEdQ/6heImQMI+Czoofd8wAFGs+xyO947w6JCGztmYR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=afGq2jK4; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="afGq2jK4"
Received: by mail.gandi.net (Postfix) with ESMTPSA id AD1763EB8E;
	Tue,  8 Sep 2026 08:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1788855121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eqytDOzdD1leNlqxy/F94YqalZikkNDD8YG3Qb4KhLk=;
	b=afGq2jK4tMKaZMDpcfle4reaU35LGT8UJ56F7fud9z/smfrTHAgMLgPhEgQDFOzyvR9ilw
	NgqtUqPC642H3FFhhhBBp3Se+4AGq1FXf4QWh4o++B1njgOC0/nVDqFG2Qs4OlopZX7lTg
	LCtkxlVRMkhBishD0AZpRjbOLF/tk1cYD3uX5XKtRdGtP6JZpMgjRBACmXQSFSTHeZLqcW
	oU+Kwo2Ry1TeIh/Xig6YuKnTCFiJgQoElVI1ZkJxPlHtUPcr3/BUQyHnQ3R/41JctkZZtM
	pZr0dCKByRtLtxS0RE0BlUUVgvV3KbNK+d28dt2fR9tA69kzXGfwrmfIpSWOpg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Andrew MacPherson <andrew@elk.audio>,  xenomai@lists.linux.dev,  Gerte
 Hoogewerf <ghoogewerf@lmi3d.com>
Subject: Re: perf getting all-zeroes IP on STM32MP1
In-Reply-To: <87cxupgrnp.fsf@xenomai.org> (Philippe Gerum's message of "Mon,
	07 Sep 2026 14:41:30 +0200")
References: <CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com>
	<9e0b7d3e72a19bd900a14faa6c459f5a2e093982.camel@siemens.com>
	<CACiVkwkc6nzD1qv7yzUR=a3GMPO+b9kp53sBVVKQpiW0NJX65w@mail.gmail.com>
	<dc1c6765187854e0758378af34098a64a8f7bf3b.camel@siemens.com>
	<87cxupgrnp.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 08 Sep 2026 10:11:59 +0200
Message-ID: <87v78gduwg.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTEYBE/iPzVuNVGfDEML/zAowlB+pVuLSyMZkov7CeLmibPR1L6TfFRR4FibS21F9k3cP3K+xmESFDivGvZaJQrOEuHnrkTeo8jQn2rdpuPVqCmt+ogW63iaTqSeT4vyFl2Gx/WDz8kk/LE7EAp0fgmRDEkJy+1/Oxxv/qm1YNleYX/gWSgufay10ay3hQsTuuVn1WDoAK1xJMSl/gnmy8f6/l2Cv/YVwZxiBbcwx1eq463gqLRUz8BZpqkov14o6hpVKZwKGbNYxK6XDFOY4tW2BKKPFGkLGn+jb4WQCl2aiA29Bzl+xuK79x8wOFMfmqCfvE+JwfCTAtZ2jhazqp5vRfVEAKiwbhr6Nvq/QLAE9edPec0sLfYwnMf+i9ugJ5zBjWFsh2aT7Hw/uMN5AsTQ3Kvxi76uwJ1Nj+aHMALYmPdXBKkO2+K7ckdwZ5ZFFq+9vRXoctmpwQ1d7xpBRRelqNOnLLwX0RgU5VmyImLdg+Tu8MIuj2uq80hyQMckFt14rhNhSUAGSpzZ1OxNrKAUzIxzj98dQSJsYFXfOOxQJFqdKsvTAT8ZcnoZNyhNo983Wo/Y+eS8NELohaLNG1psfrpm/qqsKTD1oeDHTdzV25amg0+RUi2Sxdx5tAJ2Q1kl83ZhazhOPolCy22+GtZwYrj/10vym83Ekwp9mJ3m0w

Philippe Gerum <rpm@xenomai.org> writes:

> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>
>> On Mon, 2026-09-07 at 10:57 +0200, Andrew MacPherson wrote:
>>> On Fri, 4 Sept 2026 at 16:08, Florian Bezdeka
>>> <florian.bezdeka@siemens.com> wrote:
>>> > 
>>> > Hi Andrew,
>>> > 
>>> > [CC + Philippe]
>>> > 
>>> > On Fri, 2026-09-04 at 15:26 +0200, Andrew MacPherson wrote:
>>> > > Hello,
>>> > > 
>>> > > We're working on an STM32MP1-based system running Xenomai and found
>>> > > that perf top shows every symbol as "unknown [00000000]", i.e.
>>> > > profiling is collecting samples, but they all point at address zero.
>>> > > 
>>> > > I'm not a kernel developer but went through a few debug kernel builds
>>> > > with an agent which eventually led to the attached patch. This change
>>> > > does resolve the issue with perf, however I'm not sure if it's the
>>> > > correct solution.
>>> > > 
>>> > > The reasoning is that arm_arch_timer.c's percpu IRQ registration never
>>> > > sets IRQF_TIMER, so Dovetail's copy_timer_regs() never populates
>>> > > tick_regs, leaving get_irq_regs() to always return an all-zero
>>> > > pt_regs, which in turn breaks perf's sample IP.
>>> > 
>>> > Yep, that is wrong. The patch you provided looks OK to me. I'm just
>>> > wondering if that should be addressed in Linux as well / first.
>>> > 
>>> > @Philippe: Any additional thoughts? Should we take it already?
>>> > 
>>> > 
>>> > @Andrew: Could you please provide a formal patch with proper signed-off
>>> > and LLM notice (assuming agent means AI ;-)) targeting the dovetail 7.2.
>>> > branch? That should help to speed things up. Thanks!
>>> > 
>>> > Florian
>>> > 
>>> > --
>>> > Siemens AG, Foundational Technologies
>>> > Linux Expert Center
>>> > 
>>> > 
>>> 
>>> Hi Florian,
>>> 
>>> I've submitted a patch now against dovetail 7.2, let me know if you
>>> need anything else and thanks for the help!
>>> 
>>> 
>>
>> Thanks! We might consider merging that while working on a better
>> solution - as suggested by Philippe.
>>
>
> Unfortunately, thinking a bit more/better, we'd still have an issue with
> what I suggested. i.e. There are three contexts we need to care about in
> this case:
>
> 1. when a timer tick can be immediately delivered to its handler
>    (i.e. hw irqs on) from a line tagged with IRQF_OOB.
>
> 2. when a timer tick can be immediately delivered (i.e. in-band stage is
>    installed) from a line set for in-band delivery (i.e. not tagged with
>    IRQF_OOB). In this case, the interrupt log is synchronized before
>    leaving handle_irq_pipelined_finish().
>
> 3. when a timer tick /should/ but cannot be delivered to the in-band stage
>    because the latter is stalled, i.e. need for deferral via the
>    interrupt log.
>
> In the first two cases, postponing the copy logic to
> clockevents_handle_event() would be ok, because the interrupt frame of
> the timer event would still be active, therefore using get_irq_regs() to
> find the regs to copy would be correct.
>
> In case #3, we have a deferral, therefore the interrupt frame is
> certainly gone when the in-band stage is unstalled. Since other
> interrupts could happen in between, we are toast.
>
> IOW, close, but no cigar. Back to the drawing board.

Ok, here is another proposal, which would also reuse the tick-proxy
infrastructure.  We know that any clockevent device driver which
supports pipelining must declare the irq feeding it. No ifs or buts, the
infrastructure already requires it:

/*
 * ...
 * @name:		ptr to clock event name
 * @rating:		variable to rate clock event devices
 * @irq:		IRQ number (only for non CPU local devices, or pipelined timers)
 * @bound_on:		Bound on CPU
 * @cpumask:		cpumask to indicate for which CPUs this device works
 * ...
 */
struct clock_event_device {
...
	int			irq;
...
};

With that in mind, and assuming that any profiling event source has to
be controlled by a clockchip abstraction, we could turn on some internal
__IRQF_* flag of our own into that irq's descriptor when registering a
clock event device which advertises CLOCK_EVT_FEAT_PIPELINE
(clockevents_config_and_register() and friends). We would then check
such flag from generic_pipeline_irq_desc() to figure out whether we
should save the CPU registers for profiling.

That way, we would not have to mention it in the flags argument passed
to request_percpu_irq_affinity_flags(), so no sweeping change
ahead. Moreover, this would automagically cover all the cases where
IRQF_TIMER is missing from the irq registration call, while keeping the
flag we've just added strictly internal to the irq pipeline innards.

-- 
Philippe.
