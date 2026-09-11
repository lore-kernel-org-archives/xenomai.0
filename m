Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D32E8B67
	for <xenomai@lists.linux.dev>; Fri, 11 Sep 2026 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135321; cv=none; b=LYYUWYAkHOY/rD5hqXvxYlj4098KVKEFHNjqh8wquuJjvNySSeO+59fgERU2ljvflkoqHrUrxd+tZjsqj16z+roZKgxhMMzYtUvGkZl7J0M0eyVfdIa43YqKMFdmbzlGWUMxc1OaOmtIqidtVAKiLxAaq7ub8FMEe6jVAEyXbl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135321; c=relaxed/simple;
	bh=h3makaXiydMov8A/M3JQ3DPjzdG1WuE2sY9ynunMoVY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kx/ZWC8trRvFyZR19SJx9c1u1AK1vNlOx8NKBUMqttn1SNGYGo+QY1H5fKfVfqK/gbGWKlAUq7Mc0ja+6eB5Hjq4Rj1I96OJQEP+4SIu2nwusdOZtaSTe+6Bcnv3upUF2WRxgkDPdBolzNVIUFeHBr1QAICg2N/n/wBnK0bXKgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=bGB0Y6E7; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="bGB0Y6E7"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260911140153ce10ce58e6000207a0
        for <xenomai@lists.linux.dev>;
        Fri, 11 Sep 2026 16:01:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7lZm5DcpmFhInwWoGyMX4L6rQsyqimRuc9y7hf4qZHE=;
 b=bGB0Y6E7/8XYrkWFuRAD5TjLp9885IK9pwZIlb9fWZVj4j/MzdKIWfktqriJJaZQjHK/0b
 wjtFur295Yd04GMDC3nP61jb8Klgx4mPjAEOA7QVoh07nb8sZWI0eXeuClNmFc4mMfS6Yf8i
 J3mZS1MJHRhosTALB8VbeBfiEvlJIqzJnNEW6ztSLGWrB9pO1ZRggVs35SFFNSR6rOsACybS
 ftFqFNkUas9xJ3FJ2faGZbByZnoPbjwLM/SnnMUWhkylqiBGuCJ9fKsu+rbtXZq0vBdk+/7w
 1H6iYMsqabhLolgdFAjknqJiPC7aVlqn/rviEH9qo0xewpIXDKvPK9gA==;
Message-ID: <39118cc382b8b1e74720c84a660d18330ea7b93a.camel@siemens.com>
Subject: Re: [PATCH Dovetail 0/2] Obsolete marking tick IRQs with IRQF_TIMER
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Andrew MacPherson <andrew@elk.audio>, Philippe Gerum <rpm@xenomai.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>, Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Date: Fri, 11 Sep 2026 16:01:52 +0200
In-Reply-To: <CACiVkwkY2-q2twEkuu+6oOerimz=0BLLEM43fctEG=FYAuxuuw@mail.gmail.com>
References: 
	<20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com>
	 <CACiVkwnKDck51TD6jC1K9CJoF05X9hd8xRKiskzdAd4dcj7FQg@mail.gmail.com>
	 <e10b288c461075397c67dad4ea3870cab0154239.camel@siemens.com>
	 <CACiVkwmeN=8k=oRyusakE78uVYcz2zKws8ytRecFnL2ah8ySZA@mail.gmail.com>
	 <6b918b0e226a2763352632f78edc4036c1a42de9.camel@siemens.com>
	 <CACiVkwkY2-q2twEkuu+6oOerimz=0BLLEM43fctEG=FYAuxuuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Fri, 2026-09-11 at 14:53 +0200, Andrew MacPherson wrote:
> On Fri, 11 Sept 2026 at 10:48, Florian Bezdeka
> <florian.bezdeka@siemens.com> wrote:
> >=20
> > On Thu, 2026-09-10 at 16:38 +0200, Andrew MacPherson wrote:
> > >=20
> > > > kernel BUG at kernel/irq_work.c:245!
> > > > Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> > > > CPU: 0 PID: 520 Comm: XXXXXX Tainted: G           O       6.6.48 #4
> > > > PC is at irq_work_run_list+0x14/0x64
> > > > LR is at irq_work_run_list+0xc/0x64
> > > > >=20
> > > > >  irq_work_run_list from irq_work_run+0x28/0x3c
> > > > >  irq_work_run from armv7pmu_handle_irq+0x148/0x150
> > > > >  armv7pmu_handle_irq from armpmu_dispatch_irq+0x28/0x80
> > > > >  armpmu_dispatch_irq from __handle_irq_event_percpu+0x68/0x224
> > > > >  __handle_irq_event_percpu from handle_irq_event+0x58/0xf8
> > > > >  handle_irq_event from handle_fasteoi_irq+0x154/0x2f4
> > > > >  handle_fasteoi_irq from handle_irq_desc+0x20/0x30
> > > > >  handle_irq_desc from arch_do_IRQ_pipelined+0x58/0x90
> > > > >  arch_do_IRQ_pipelined from sync_current_irq_stage+0xac/0xe0
> > > > >  sync_current_irq_stage from handle_irq_pipelined_finish+0xa0/0x1=
98
> > > > >  handle_irq_pipelined_finish from __irq_usr+0x60/0x80
> > > > >=20
> > > > > Kernel panic - not syncing: Fatal exception in interrupt
> > > > >=20
> > > > >=20
> >=20
> > I can't reproduce that one here. Not on 7.2 nor on 6.6.49.
> > Might be that this is depending on
> >   - your workload (irq work)
> >   - kernel configuration
> >   - xenomai version (which one do you use?)
> >   - qemu vs. real hw
> >=20
> > I'm quite sure that this is a different issue as we hit a BUG() in
> > irq_work_run_list():
> >=20
> >         BUG_ON(!irqs_disabled() && !IS_ENABLED(CONFIG_PREEMPT_RT));
> >=20
> > On first glance that looks like a corruption of the virtual interrupt
> > state. An irq_work event was waiting in the IRQ log and got applied wit=
h
> > a wrong inband IRQ state.
> >=20
> > Last time we found issues on arm was probably [1]. Seems that this
> > series was not backported (yet). [1] got merged into 7.1. Maybe you can
> > give it a try. I don't have futher ideas at the moment.
> >=20
> > Best regards,
> > Florian
> >=20
> > [1] https://lore.kernel.org/xenomai/87ik6qvqck.fsf@xenomai.org/T/#m3170=
1ab94206574c96cc2d2b24d77d9793359892
>=20
> I tried backporting the patches from [1] and they do in fact resolve
> the crash! Narrowing it down somewhat it seems that specifically
> patches 5+6 together are enough to do it, if I only apply those and
> skip the rest the crash is still resolved. With these patches plus the
> earlier one I now get clean results from a perf callgraph run.
>=20
> An LLM's static analysis of the issue is: do_page_fault() checked the
> raw hardware IRQ flag instead of the correct in-band-stall state
> before re-enabling interrupts - and page faults are frequent enough
> (routine memory access) that this wrong check fired constantly. Since
> real hardware IRQs are deliberately left on during Dovetail's in-band
> IRQ replay, and the stall bit that guards against reentrancy is a
> single un-counted flag, that wrong early local_irq_enable() call
> opened a window for a genuinely nested interrupt to corrupt the
> stall/hardirq bookkeeping that irq_work_run_list()'s assertion depends
> on.
>=20
> Thanks again for the help tracking this down!

Thanks for testing and reporting back. Highly appreciated!

So let me inform "stable" maintainers that [1] fixes a real problem. I
was just reviewing parts of the arm pipeline implementation back then
and realized that there are potential problems. Now they got real ;-)

@Jan, Philippe:
Could you please take care of [1] being applied into older, but still
maintained branches. Thanks!

This series would also be needed to fix some perf problems on arm/arm64.
But let's wait for some more feedback first.

Thanks all,
Florian

[1] https://lore.kernel.org/xenomai/87ik6qvqck.fsf@xenomai.org/T/#m31701ab9=
4206574c96cc2d2b24d77d9793359892
