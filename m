Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED5A350A05
	for <xenomai@lists.linux.dev>; Fri, 11 Sep 2026 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137106; cv=none; b=BhMrM3CtZ4RY8e0Reid5NyXRfrVl9nkMdSIniseqkrU7NeUFIU2pGoStklgFFNBqYnouGUE432OJRRWOE8T/fFt8c36OmyZI6pdbfZRperfjRLFovwR6qy/vr4/XF8002QomzXXq2Wfgrg7TSk08OmkqsUCuj3puPK6M8I1D9uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137106; c=relaxed/simple;
	bh=l4IrNC0Oxgpbp3kS6NL8KirlqSNhWPIkTt9EtH7pze0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hJ77ZaRTgP29c0JHOnGUPP14wGCSRKcw7pmeXWxGl74OWhytgC1kmKHQEO2KG9D6Uf+pjD/gUuWjZkL1TuA+gBEfwv0s1v3+pWE1/Pqw0M0abJIS9fAve31ohKHeZB+GQLHkiOzukiJOr7mNewI4GrQ7wxvjq5wKQwh0Budb+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=QUnTfiE8; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="QUnTfiE8"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23ED23EC21;
	Fri, 11 Sep 2026 14:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1789137094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oMUrAv4fcGoC8/QcMowRXUV/G+7vsF6LmKGH8Aqe5Fk=;
	b=QUnTfiE8k3IvZZqkh8uLklN5K8Kh5Uj3K9kgiaa8RWGu4i7upXE5/5xTOw9RroExTIkojw
	kixvlKGlI/9qAPiz3Q4FoxvgexDk3P6trZ8YaxJKKrQvGe0zUA6vIKXllwrvx9U8iYGJRD
	SelI39ba//8SEFnmpyUcwUKmu0eFf1AZEGQJhTXUiVZ4gE4Obmz/4YhE+Tdf0j82Ncf7Xk
	mQaEswOvZqXF4FHnrW8qsHOYxNc8V1Dqh1QfJWlVnFEGCl+ljN28Fm7s/2ACIl33eguJww
	jt0+6BHfHgeKGeDNYCV1AVV0uKTlL2CRUjasP8xjTo7hpnq1YMVBy4p7Di96rQ==
From: Philippe Gerum <rpm@xenomai.org>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "andrew@elk.audio" <andrew@elk.audio>,  "Kiszka, Jan"
 <jan.kiszka@siemens.com>,  "ghoogewerf@lmi3d.com" <ghoogewerf@lmi3d.com>,
  "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [PATCH Dovetail 0/2] Obsolete marking tick IRQs with IRQF_TIMER
In-Reply-To: <a2d138b2ec34b403ee83f8e0e1f21dffb0f8233c.camel@siemens.com>
	(Florian Bezdeka's message of "Fri, 11 Sep 2026 14:11:34 +0000")
References: <20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com>
	<CACiVkwnKDck51TD6jC1K9CJoF05X9hd8xRKiskzdAd4dcj7FQg@mail.gmail.com>
	<e10b288c461075397c67dad4ea3870cab0154239.camel@siemens.com>
	<CACiVkwmeN=8k=oRyusakE78uVYcz2zKws8ytRecFnL2ah8ySZA@mail.gmail.com>
	<6b918b0e226a2763352632f78edc4036c1a42de9.camel@siemens.com>
	<CACiVkwkY2-q2twEkuu+6oOerimz=0BLLEM43fctEG=FYAuxuuw@mail.gmail.com>
	<39118cc382b8b1e74720c84a660d18330ea7b93a.camel@siemens.com>
	<a2d138b2ec34b403ee83f8e0e1f21dffb0f8233c.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 11 Sep 2026 16:31:32 +0200
Message-ID: <87mrtndfln.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTEb1C2Sp2kEdP4230BAdQAXlKMUOtxjI5hSuFWNFBCt90bUq2cDvV2CIL3oN4WBrt86b89kAdvpeRekAuGzC1s0DNot7n/9/sqLswlQbgVsgylWHpSP3ZhPAV6j9HS+BiaGrvAKUF8YC3Ekj3qOkKDQPy6j7CC/Rpy8bYsqP0oZNWyBj23HL2NlNgUHnYXQYdozhJuUBivxJKaont8QUsH/8PiaMBVexatRWV/3c0keUPh13pYIr5e17nBxGeIbAemH8Oo1332vNC0gopPJF2vtTlfYYG7P3zOQh/I3Sn4YpkAIxDoVehO+83/WR43Qa1OWh964XLLqc6Ej+t0EfvzNU/LdTCDjNQ084BTPWKqYM300Qzn8VeAcpDLEQv/1NdV5AC79z78nSSmO3SmbTtxhNHvoLDenINNWYqEQQYISj+QWnSPiWHlHcSx2uAp2BP7kBE6AQvLnmzW/KZWpXup8tEOjuB+dPHNtCE28npUtsKX3P+fodHke1h77Cg5cgD5hny97I1ufKnbiqGI7Pe3rCdLjw4OZgvdFNSyQRbH95htQa3NzT07bcDkov3PvKLglQCcZEMI67aOAAyT81OzmqMBZQNs+g+qU3f6S7aN/xdBkwkOy/aSvcOf2yaCa6HJOnebvt29TF29ETGJPQAeoB2Eq8BZsH3NsR537kV/pyA
X-GND-State: clean

"Bezdeka, Florian" <florian.bezdeka@siemens.com> writes:

> On Fri, 2026-09-11 at 16:01 +0200, Florian Bezdeka wrote:
>> On Fri, 2026-09-11 at 14:53 +0200, Andrew MacPherson wrote:
>> > On Fri, 11 Sept 2026 at 10:48, Florian Bezdeka
>> > <florian.bezdeka@siemens.com> wrote:
>> > > 
>> > > On Thu, 2026-09-10 at 16:38 +0200, Andrew MacPherson wrote:
>> > > > 
>> > > > > kernel BUG at kernel/irq_work.c:245!
>> > > > > Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
>> > > > > CPU: 0 PID: 520 Comm: XXXXXX Tainted: G           O       6.6.48 #4
>> > > > > PC is at irq_work_run_list+0x14/0x64
>> > > > > LR is at irq_work_run_list+0xc/0x64
>> > > > > > 
>> > > > > >  irq_work_run_list from irq_work_run+0x28/0x3c
>> > > > > >  irq_work_run from armv7pmu_handle_irq+0x148/0x150
>> > > > > >  armv7pmu_handle_irq from armpmu_dispatch_irq+0x28/0x80
>> > > > > >  armpmu_dispatch_irq from __handle_irq_event_percpu+0x68/0x224
>> > > > > >  __handle_irq_event_percpu from handle_irq_event+0x58/0xf8
>> > > > > >  handle_irq_event from handle_fasteoi_irq+0x154/0x2f4
>> > > > > >  handle_fasteoi_irq from handle_irq_desc+0x20/0x30
>> > > > > >  handle_irq_desc from arch_do_IRQ_pipelined+0x58/0x90
>> > > > > >  arch_do_IRQ_pipelined from sync_current_irq_stage+0xac/0xe0
>> > > > > >  sync_current_irq_stage from handle_irq_pipelined_finish+0xa0/0x198
>> > > > > >  handle_irq_pipelined_finish from __irq_usr+0x60/0x80
>> > > > > > 
>> > > > > > Kernel panic - not syncing: Fatal exception in interrupt
>> > > > > > 
>> > > > > > 
>> > > 
>> > > I can't reproduce that one here. Not on 7.2 nor on 6.6.49.
>> > > Might be that this is depending on
>> > >   - your workload (irq work)
>> > >   - kernel configuration
>> > >   - xenomai version (which one do you use?)
>> > >   - qemu vs. real hw
>> > > 
>> > > I'm quite sure that this is a different issue as we hit a BUG() in
>> > > irq_work_run_list():
>> > > 
>> > >         BUG_ON(!irqs_disabled() && !IS_ENABLED(CONFIG_PREEMPT_RT));
>> > > 
>> > > On first glance that looks like a corruption of the virtual interrupt
>> > > state. An irq_work event was waiting in the IRQ log and got applied with
>> > > a wrong inband IRQ state.
>> > > 
>> > > Last time we found issues on arm was probably [1]. Seems that this
>> > > series was not backported (yet). [1] got merged into 7.1. Maybe you can
>> > > give it a try. I don't have futher ideas at the moment.
>> > > 
>> > > Best regards,
>> > > Florian
>> > > 
>> > > [1] https://lore.kernel.org/xenomai/87ik6qvqck.fsf@xenomai.org/T/#m31701ab94206574c96cc2d2b24d77d9793359892
>> > 
>> > I tried backporting the patches from [1] and they do in fact resolve
>> > the crash! Narrowing it down somewhat it seems that specifically
>> > patches 5+6 together are enough to do it, if I only apply those and
>> > skip the rest the crash is still resolved. With these patches plus the
>> > earlier one I now get clean results from a perf callgraph run.
>> > 
>> > An LLM's static analysis of the issue is: do_page_fault() checked the
>> > raw hardware IRQ flag instead of the correct in-band-stall state
>> > before re-enabling interrupts - and page faults are frequent enough
>> > (routine memory access) that this wrong check fired constantly. Since
>> > real hardware IRQs are deliberately left on during Dovetail's in-band
>> > IRQ replay, and the stall bit that guards against reentrancy is a
>> > single un-counted flag, that wrong early local_irq_enable() call
>> > opened a window for a genuinely nested interrupt to corrupt the
>> > stall/hardirq bookkeeping that irq_work_run_list()'s assertion depends
>> > on.
>> > 
>> > Thanks again for the help tracking this down!
>> 
>> Thanks for testing and reporting back. Highly appreciated!
>> 
>> So let me inform "stable" maintainers that [1] fixes a real problem. I
>> was just reviewing parts of the arm pipeline implementation back then
>> and realized that there are potential problems. Now they got real ;-)
>> 
>> @Jan, Philippe:
>> Could you please take care of [1] being applied into older, but still
>> maintained branches. Thanks! 
>> 
>> This series would also be needed to fix some perf problems on arm/arm64.
>> But let's wait for some more feedback first.
>
> Forgot one end: Additionally we need
>
> 58e8e0f74c2b ("ARM: irq_pipeline: save registers used for walking tick frames")
>
> to fix the perf issues. Couldn't find it on the list. Seems it sneaked
> in silently ;-)
>

https://lore.kernel.org/xenomai/CAKndYJHo--bOwSh4Sg7wyuPuWnFcHkPrg_bBRLNYWBm3VQ-VnQ@mail.gmail.com/T/#mf36158864c1a3225ef5305f1557052c955260ae2

-- 
Philippe.
