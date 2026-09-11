Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD31F3CA487
	for <xenomai@lists.linux.dev>; Fri, 11 Sep 2026 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118945; cv=none; b=JoNfiNWxwjWuBkrgkQTsk+MdcdwE/FL9mAV+A4ODoWNNcYKFDgjnBW7dgYqctT9H7Jpvji7QJUmUGcA50dYd/1k3R8Tf/e3i6YZuB7RzU58wogVemuNPvmUIaZSgzaOVObcfi+BWSR1ayIG8O3eVPUP6HpD96qDaY1aqpq15qYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118945; c=relaxed/simple;
	bh=/IngBt8aZXOr/NJX4DtLXs0VtNjzpzJjakzjyCHrYGg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qXz4s6mkn5A/PECeDM6+cuQ85nZZb0cpYAK5EYi+wltEn0q0Mv049wfCYwjSTTUNyYKQhmVNvU0N4W/8XeUZzjPLUMP5IZhBvxGq+y/SxsSFupZzGIMoALqiCNjRMIhSkewv7Q6926YX8ZMGDlD8IOU174IPUWW3V8D1dxIdd5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=MgJhqWxq; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="MgJhqWxq"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260911084841b2131c70ce000207ec
        for <xenomai@lists.linux.dev>;
        Fri, 11 Sep 2026 10:48:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yYbT7NvWthuCNG0jgOL4+djWWIF9h0LpyVEVn56eQCk=;
 b=MgJhqWxq3NgvBVmeqrZUra3YJIxaCEIyU2LjtvRGm9LG3i4lr5TJcktBXRzmT3FdFe24bA
 Oe59Pqz1iON1ldtLpJGoiYN+7qNhX8B/2zX+JCzxGAmBgxhXL8b+YDjhcZPgh+9tnbpcTnEp
 fpawkQeDdaHGyIdPHvbGLboqJ+EED6gdUexRVIpcJM5DT6J12px6Yc0HU50x0rqb9yazpOcW
 pbIhTsBAaJX9Qn/Hfj7CK7Vy6cuL9skupTZ1EzJ4toL8Jem91VAYIja8tOL65Ig1L/UTcKYO
 Ez5hENrwrXaBkrBMLUXnoeeEabfaZ1b72qCQvCwnkyLoeOwabA4juHfA==;
Message-ID: <6b918b0e226a2763352632f78edc4036c1a42de9.camel@siemens.com>
Subject: Re: [PATCH Dovetail 0/2] Obsolete marking tick IRQs with IRQF_TIMER
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Andrew MacPherson <andrew@elk.audio>
Cc: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>, 
 Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Date: Fri, 11 Sep 2026 10:48:40 +0200
In-Reply-To: <CACiVkwmeN=8k=oRyusakE78uVYcz2zKws8ytRecFnL2ah8ySZA@mail.gmail.com>
References: 
	<20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com>
	 <CACiVkwnKDck51TD6jC1K9CJoF05X9hd8xRKiskzdAd4dcj7FQg@mail.gmail.com>
	 <e10b288c461075397c67dad4ea3870cab0154239.camel@siemens.com>
	 <CACiVkwmeN=8k=oRyusakE78uVYcz2zKws8ytRecFnL2ah8ySZA@mail.gmail.com>
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

On Thu, 2026-09-10 at 16:38 +0200, Andrew MacPherson wrote:
>=20
> > kernel BUG at kernel/irq_work.c:245!
> > Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> > CPU: 0 PID: 520 Comm: XXXXXX Tainted: G           O       6.6.48 #4
> > PC is at irq_work_run_list+0x14/0x64
> > LR is at irq_work_run_list+0xc/0x64
> > >=20
> > >  irq_work_run_list from irq_work_run+0x28/0x3c
> > >  irq_work_run from armv7pmu_handle_irq+0x148/0x150
> > >  armv7pmu_handle_irq from armpmu_dispatch_irq+0x28/0x80
> > >  armpmu_dispatch_irq from __handle_irq_event_percpu+0x68/0x224
> > >  __handle_irq_event_percpu from handle_irq_event+0x58/0xf8
> > >  handle_irq_event from handle_fasteoi_irq+0x154/0x2f4
> > >  handle_fasteoi_irq from handle_irq_desc+0x20/0x30
> > >  handle_irq_desc from arch_do_IRQ_pipelined+0x58/0x90
> > >  arch_do_IRQ_pipelined from sync_current_irq_stage+0xac/0xe0
> > >  sync_current_irq_stage from handle_irq_pipelined_finish+0xa0/0x198
> > >  handle_irq_pipelined_finish from __irq_usr+0x60/0x80
> > >=20
> > > Kernel panic - not syncing: Fatal exception in interrupt
> > >=20
> > >=20

I can't reproduce that one here. Not on 7.2 nor on 6.6.49.
Might be that this is depending on=20
  - your workload (irq work)
  - kernel configuration
  - xenomai version (which one do you use?)
  - qemu vs. real hw

I'm quite sure that this is a different issue as we hit a BUG() in
irq_work_run_list():=20

	BUG_ON(!irqs_disabled() && !IS_ENABLED(CONFIG_PREEMPT_RT));

On first glance that looks like a corruption of the virtual interrupt
state. An irq_work event was waiting in the IRQ log and got applied with
a wrong inband IRQ state.

Last time we found issues on arm was probably [1]. Seems that this
series was not backported (yet). [1] got merged into 7.1. Maybe you can
give it a try. I don't have futher ideas at the moment.

Best regards,
Florian

[1] https://lore.kernel.org/xenomai/87ik6qvqck.fsf@xenomai.org/T/#m31701ab9=
4206574c96cc2d2b24d77d9793359892
