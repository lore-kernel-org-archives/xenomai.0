Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323E33A9D8B
	for <xenomai@lists.linux.dev>; Mon,  7 Sep 2026 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791983; cv=none; b=g0vzZrPexeKxhZSM6rY/Xzt1HZif+WdmVR2lNrQacxTh64n1e9mmnk3vzPgv7qUmkaCjdxGIDNR69CGNXehBRbw6A037NW/xVVaYxTWaq+7jE4PL/YDFJN05mCwH0YtKkEabTvE3SMifBTLPHOE1x1v68jKyjJSDvdgb4qCYULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791983; c=relaxed/simple;
	bh=KsRMxelKir79pAHTvCVqwlqZRCGpERm9Va0KvDQTtwQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i2PJ80djscW09LLTgnFO60zGfXa+HIcHZOLo5q48Rkg5/VgN905mpgnvISV/dFsdtu/Rp8wL9MISibFGSnkE+CWbWSVve7Mu8CNHODTG5FbyrCXIZNGIxOarzs5bXkLM0Mf8oonp51sNs9oEVSp8RvyOESeX/P6lzOcO2GkpGvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=F3tiBHB0; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="F3tiBHB0"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2026090714392220b006fd84000207af
        for <xenomai@lists.linux.dev>;
        Mon, 07 Sep 2026 16:39:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=BfoXELjM2ob2RIvMdwt6Xp7W5qhXIi+ynCM5Q+shSvY=;
 b=F3tiBHB0noqDJjQPF9GZQ1Ux9QmMJbouZNEr5DDbd0MmiHY5w2IoXovgL+zsO5tUL2jW+7
 t3G6kL2YXYswlYmCCBJY0htF07ZmkI3bZTxU0iSAgdJiS8xShJWjdnBi9NNR3oY31jUrKHGH
 wYoYf8WvOWvLGPJEVtCDk2OCfFpm6kcWcfFBSKZWp+GM6JzgLiYyZUFb40jB9H8KLGcmozeT
 Z5JHahMdvsNhdYOf4sD2ZOmNXDh8/lAfbxbKwMka2mC0cAZlZ8PQoX0rQcE/YTdz65+42DVT
 zrwNnlH3x5U7G8KvrCy+owj1YCdH4IzPeX+gopbXiWHvxDDZ7XMroDrQ==;
Message-ID: <a14e0d0f9ec97f6064a1b2fb221f3ee5015e2241.camel@siemens.com>
Subject: Re: perf getting all-zeroes IP on STM32MP1
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Andrew MacPherson <andrew@elk.audio>, xenomai@lists.linux.dev, Gerte
 Hoogewerf <ghoogewerf@lmi3d.com>
Date: Mon, 07 Sep 2026 16:39:21 +0200
In-Reply-To: <87cxupgrnp.fsf@xenomai.org>
References: 
	<CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com>
		<9e0b7d3e72a19bd900a14faa6c459f5a2e093982.camel@siemens.com>
		<CACiVkwkc6nzD1qv7yzUR=a3GMPO+b9kp53sBVVKQpiW0NJX65w@mail.gmail.com>
		<dc1c6765187854e0758378af34098a64a8f7bf3b.camel@siemens.com>
	 <87cxupgrnp.fsf@xenomai.org>
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

On Mon, 2026-09-07 at 14:41 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Mon, 2026-09-07 at 10:57 +0200, Andrew MacPherson wrote:
> > > On Fri, 4 Sept 2026 at 16:08, Florian Bezdeka
> > > <florian.bezdeka@siemens.com> wrote:
> > > >=20
> > > > Hi Andrew,
> > > >=20
> > > > [CC + Philippe]
> > > >=20
> > > > On Fri, 2026-09-04 at 15:26 +0200, Andrew MacPherson wrote:
> > > > > Hello,
> > > > >=20
> > > > > We're working on an STM32MP1-based system running Xenomai and fou=
nd
> > > > > that perf top shows every symbol as "unknown [00000000]", i.e.
> > > > > profiling is collecting samples, but they all point at address ze=
ro.
> > > > >=20
> > > > > I'm not a kernel developer but went through a few debug kernel bu=
ilds
> > > > > with an agent which eventually led to the attached patch. This ch=
ange
> > > > > does resolve the issue with perf, however I'm not sure if it's th=
e
> > > > > correct solution.
> > > > >=20
> > > > > The reasoning is that arm_arch_timer.c's percpu IRQ registration =
never
> > > > > sets IRQF_TIMER, so Dovetail's copy_timer_regs() never populates
> > > > > tick_regs, leaving get_irq_regs() to always return an all-zero
> > > > > pt_regs, which in turn breaks perf's sample IP.
> > > >=20
> > > > Yep, that is wrong. The patch you provided looks OK to me. I'm just
> > > > wondering if that should be addressed in Linux as well / first.
> > > >=20
> > > > @Philippe: Any additional thoughts? Should we take it already?
> > > >=20
> > > >=20
> > > > @Andrew: Could you please provide a formal patch with proper signed=
-off
> > > > and LLM notice (assuming agent means AI ;-)) targeting the dovetail=
 7.2.
> > > > branch? That should help to speed things up. Thanks!
> > > >=20
> > > > Florian
> > > >=20
> > > > --
> > > > Siemens AG, Foundational Technologies
> > > > Linux Expert Center
> > > >=20
> > > >=20
> > >=20
> > > Hi Florian,
> > >=20
> > > I've submitted a patch now against dovetail 7.2, let me know if you
> > > need anything else and thanks for the help!
> > >=20
> > >=20
> >=20
> > Thanks! We might consider merging that while working on a better
> > solution - as suggested by Philippe.
> >=20
>=20
> Unfortunately, thinking a bit more/better, we'd still have an issue with
> what I suggested. i.e. There are three contexts we need to care about in
> this case:
>=20
> 1. when a timer tick can be immediately delivered to its handler
>    (i.e. hw irqs on) from a line tagged with IRQF_OOB.
>=20
> 2. when a timer tick can be immediately delivered (i.e. in-band stage is
>    installed) from a line set for in-band delivery (i.e. not tagged with
>    IRQF_OOB). In this case, the interrupt log is synchronized before
>    leaving handle_irq_pipelined_finish().
>=20
> 3. when a timer tick /should/ but cannot be delivered to the in-band stag=
e
>    because the latter is stalled, i.e. need for deferral via the
>    interrupt log.
>=20
> In the first two cases, postponing the copy logic to
> clockevents_handle_event() would be ok, because the interrupt frame of
> the timer event would still be active, therefore using get_irq_regs() to
> find the regs to copy would be correct.

Agree.

>=20
> In case #3, we have a deferral, therefore the interrupt frame is
> certainly gone when the in-band stage is unstalled. Since other
> interrupts could happen in between, we are toast.
>=20

Hm, when setting up the proxy device, we mark the affected IRQs as OOB
IRQs. Doesn't that mean that we end up in clockevents_handle_event() for
those IRQs as well? That seems to be the case, if my debugging here is
right.

We want to copy the registers of the last OOB timer tick, no? That looks
doable, but I might miss something or just did not run into the "inband
stalled" case.

Florian
