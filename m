Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DD44AA40D
	for <xenomai@lists.linux.dev>; Mon,  7 Sep 2026 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784896; cv=none; b=HgL2AKYJnfB3A7yHkApxUN8DXye2OI0hiK9ULWFsQN0tUDGeaWZ4gNxy7/tTbg8sWTrrAxGdb4BEqllttj/Zt2ZWPVHR2+7SMnU3ymqErkLc4cYu2el/UBbNgcoFFAeALLAQrE0VnIdq7iCa24ILYeqJGOfyVunNl59pUR3IkSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784896; c=relaxed/simple;
	bh=ZmSDzHXgOWCApFnJ1K2cDapLB6Wq2rxgEHAgD2vVvTw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rhR1Q+2Tr7In9G+7S9ODRrr4QddnpggVLs9lbMotkabPN60mc+EqAQtIrDaLn8dilruUuW+S+zQIFCfE5BjglE0G/XC6IdfbPy8LCJfsWLUJ6Muw31Gq+fXVf2Bv8kg4nuP5ExCadpeNLfLvlPpNd2IsziCdDolCJMQ2ORDSSUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=pdF20j9X; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="pdF20j9X"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66FAB3E970;
	Mon,  7 Sep 2026 12:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1788784891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPViZ8ypSiK5qXFoC/RzjXyz3n8HgyVRdwfCDZBdSbU=;
	b=pdF20j9XlhXiiRmBWy3GFQwf/x4BxcAIyIAzfa0T/QYWftS85KEWuCv1H/TSpw7GMk47FU
	T6lT6s6SVt0UU7U6AlfZMZldaMZnuBProtHYId2AcOeVsW2VoC9B6JU5399g6606x0ehVS
	agTPO4Z1DcbM0rybcTYbYi1k/B0/qDi/kFpnIgPEO1pa9PxfapVPDnbP8n9k5mqoQcF4Qa
	GCBkmFkkJPR7NJDNaBessHNEcDOYN3gKaaYdQ/ND8Xk4i7bnmOLWcaj+rzUQIxPI3qV5+8
	ac+8DLUFUOVPfh2u8pMHJ9oJWi4yIy8vY3PWDPyXkpzVs7ZtVz4djqoYaPqoWw==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Andrew MacPherson <andrew@elk.audio>,  xenomai@lists.linux.dev,  Gerte
 Hoogewerf <ghoogewerf@lmi3d.com>
Subject: Re: perf getting all-zeroes IP on STM32MP1
In-Reply-To: <dc1c6765187854e0758378af34098a64a8f7bf3b.camel@siemens.com>
	(Florian Bezdeka's message of "Mon, 07 Sep 2026 13:34:22 +0200")
References: <CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com>
	<9e0b7d3e72a19bd900a14faa6c459f5a2e093982.camel@siemens.com>
	<CACiVkwkc6nzD1qv7yzUR=a3GMPO+b9kp53sBVVKQpiW0NJX65w@mail.gmail.com>
	<dc1c6765187854e0758378af34098a64a8f7bf3b.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 07 Sep 2026 14:41:30 +0200
Message-ID: <87cxupgrnp.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTEgG6xB8i6cR8L3R4GCm3FtPdAQtfQ5LDLpTIR4eoZd6n2f0fO4MdNXGxS1DCMS4gb/iVaspg8H7nPrlXeLcYQap2rZzdxEzEkp3ofM9AUoPkYDyyar2Sx1NKMFjvp+fKYRJVhd+37QBuwx/yWV4Fs3U8sAoJIAJbQ2i6Z5AVHkstPk62bB+QM9hgnMhMTlDNd8O3Rm2S0Yh1wahNJiNsCRzldVSlbJGed3Aj5nibi0Vzeq9tTu5xuxiUrM+4GKNrCg6tWtQT7TuN8OpV/pDebD27m4Ct/xtFPPiWCP/r1Y6n+8yWR2XF7Jvd3loEvudIQ67b+nE6tu1hpDDVGK+r9vJRBPylPCjTCOQvip1P5sDp67EmLsHlsQ5Xi2WbBhIpT4T2+48CGD11rJqKvQBwO9t5Ivqz2Rs+CBaI0VuWoZG8DLMUCLXB1f/RT9SPsZbVgCpMpjyy1XTItdg9NLlk8XMeLry/sAOWsbp5tQEIIr4a/JTHyIYNRqBxYeRkc6Wu8QXTCIohU7sPGha7/wDkQOc3w0ZcoOmpd26EaxSwz5IfQ3CZJZOLq5pZr3tqikbuueHbxCNENdcfUkmPZEJ+O1J6teH+GwVajz5iOcv+0cb450E7snm1sNbFjUxu9iyyDs9jNU1k/hFmMEHRwZ6X9zT36o860tql4KvxOJRwRbTQ

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Mon, 2026-09-07 at 10:57 +0200, Andrew MacPherson wrote:
>> On Fri, 4 Sept 2026 at 16:08, Florian Bezdeka
>> <florian.bezdeka@siemens.com> wrote:
>> > 
>> > Hi Andrew,
>> > 
>> > [CC + Philippe]
>> > 
>> > On Fri, 2026-09-04 at 15:26 +0200, Andrew MacPherson wrote:
>> > > Hello,
>> > > 
>> > > We're working on an STM32MP1-based system running Xenomai and found
>> > > that perf top shows every symbol as "unknown [00000000]", i.e.
>> > > profiling is collecting samples, but they all point at address zero.
>> > > 
>> > > I'm not a kernel developer but went through a few debug kernel builds
>> > > with an agent which eventually led to the attached patch. This change
>> > > does resolve the issue with perf, however I'm not sure if it's the
>> > > correct solution.
>> > > 
>> > > The reasoning is that arm_arch_timer.c's percpu IRQ registration never
>> > > sets IRQF_TIMER, so Dovetail's copy_timer_regs() never populates
>> > > tick_regs, leaving get_irq_regs() to always return an all-zero
>> > > pt_regs, which in turn breaks perf's sample IP.
>> > 
>> > Yep, that is wrong. The patch you provided looks OK to me. I'm just
>> > wondering if that should be addressed in Linux as well / first.
>> > 
>> > @Philippe: Any additional thoughts? Should we take it already?
>> > 
>> > 
>> > @Andrew: Could you please provide a formal patch with proper signed-off
>> > and LLM notice (assuming agent means AI ;-)) targeting the dovetail 7.2.
>> > branch? That should help to speed things up. Thanks!
>> > 
>> > Florian
>> > 
>> > --
>> > Siemens AG, Foundational Technologies
>> > Linux Expert Center
>> > 
>> > 
>> 
>> Hi Florian,
>> 
>> I've submitted a patch now against dovetail 7.2, let me know if you
>> need anything else and thanks for the help!
>> 
>> 
>
> Thanks! We might consider merging that while working on a better
> solution - as suggested by Philippe.
>

Unfortunately, thinking a bit more/better, we'd still have an issue with
what I suggested. i.e. There are three contexts we need to care about in
this case:

1. when a timer tick can be immediately delivered to its handler
   (i.e. hw irqs on) from a line tagged with IRQF_OOB.

2. when a timer tick can be immediately delivered (i.e. in-band stage is
   installed) from a line set for in-band delivery (i.e. not tagged with
   IRQF_OOB). In this case, the interrupt log is synchronized before
   leaving handle_irq_pipelined_finish().

3. when a timer tick /should/ but cannot be delivered to the in-band stage
   because the latter is stalled, i.e. need for deferral via the
   interrupt log.

In the first two cases, postponing the copy logic to
clockevents_handle_event() would be ok, because the interrupt frame of
the timer event would still be active, therefore using get_irq_regs() to
find the regs to copy would be correct.

In case #3, we have a deferral, therefore the interrupt frame is
certainly gone when the in-band stage is unstalled. Since other
interrupts could happen in between, we are toast.

IOW, close, but no cigar. Back to the drawing board.

-- 
Philippe.
