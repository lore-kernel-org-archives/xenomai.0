Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E29B313E34
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254454; cv=none; b=PEkJCbVU5zXpiQDsh0rFBGxr6/WspbFvjSQg5u979nZx+T2t2ZPR/IH4+3F4GxSsMatfjRhtDDjNh1EM4BWa03nd6XTf5/Whlu10MOQouXcq7vUq4sPQBxdH0CVOSPST/SD59x69eulbqFsCEd4jtPjIm9tCbCjaNcAUGXI+cVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254454; c=relaxed/simple;
	bh=lmk4W3u8RpUhYvlIV9/jTOkxPvic9C2eMYU2UYz+8zw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SYMQO023AVv0xNiM+xrAAGNTGcCfFP05Oe1llP0AK9ESJQb0/mU8dBxzU5UrGoijdprkDW0+sGuzL4BiUZL0TuUC0cRpKV/3wSquuU4SUBxJnGGNu/DBEj/GGKBVizNDghliaCeYTxQw7xEGVc8K2C5+I5t8Kkx9NGt/x6i/Sc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=QjVT7Fc0; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="QjVT7Fc0"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202602161507265e7cd3e91d00020776
        for <xenomai@lists.linux.dev>;
        Mon, 16 Feb 2026 16:07:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=e0bCsbyXwlf4440WJ1ocOnDM9zfsAef4McBz5YcTN+s=;
 b=QjVT7Fc0hmUy/ddu8zLuPw6fPDzcx+I/5fk/20MgMs8A1JBSepmOu/PvcD3H9+Xj9pn6ZN
 /gyEvem6QcNWpt10LVaKlYyEoqpMGtWf5aMdRv98moZkLJZwg7GaeQIu0UYuLElqCk/SydG+
 wEV01lSOllniLeXrxhjdPhTYSnZLks88GJn9zN2IVJoxImjZeWa94mNS4T1PYWcSEYdI9vdM
 2C3RwY+66tEEdTCt0zsdhymTb3l3disgx7fkCGkalWnjMXfQdWLbTSF3wu/cBHsxOrsFihvK
 Vbn47I+0syhn3T8NcZWNF8b2ouXXg7mvPRRCmV2FkbZB7tNIM0mHr2Rw==;
Message-ID: <50e794ea2e16554b811fcb2711ebdeb3d201b7f9.camel@siemens.com>
Subject: Re: [PATCH dovetail] irq_pipeline: synchronize inband IRQ log in
 exit_to_user_mode_prepare()
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Date: Mon, 16 Feb 2026 16:07:26 +0100
In-Reply-To: <87jywc4v84.fsf@xenomai.org>
References: <20260214113941.91453-1-tobias.schaffner@siemens.com>
		<5b5db336-84f6-4add-a485-6414f7a2f190@siemens.com>
	 <87jywc4v84.fsf@xenomai.org>
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

On Mon, 2026-02-16 at 15:30 +0100, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On 2/14/26 12:39, Tobias Schaffner wrote:
> > > Architectures using the generic handle_irq_pipelined() path do not
> >=20
> > arm64 and x86 are not using that, so the only arch left is arm.
> > See below...
> >=20
> > > synchronize the inband IRQ log in handle_irq_pipelined_finish()
> > > because inband is still stalled from irqentry_enter() when it gets
> > > called.
> >=20
> > I think the real issue / correct wording is:
> >=20
> > _TIF_WORK is left pending on IRQ exit.
> >=20
>=20
> More precisely, some IRQs might be logged for the in-band stage (taken
> during stage demotion but virtually masked, as your pointed out), and we
> must play them before returning to userland.
>=20
> [snip]
>=20
> > Taken from arm64/x86:
> > if (unlikely(running_oob() || irqs_disabled())) {
> > 	...
> > 	handle_irq_pipelined_finish(prevd, regs);
> > 	if (running_inband() && user_mode(regs)) {
> > 		stall_inband_nocheck();
> > 		irqentry_exit_to_user_mode(regs);
> > 	}
> > 	...
> > }
> >=20
> > >  again:
> > >  	ti_work =3D read_thread_flags();
> > >  	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
>=20
> Incidentally, I just noticed that arm64 looks wrong
> here. arm64_pipeline_el0_irq() lacks the demotion check in the
> running_oob() case, and arm64_pipeline_el1_irq() unfortunately checks
> for user_mode(regs) in arm64_pipeline_el1_irq(). I'll leave the
> conclusion to the careful reader.

I noticed that as well while reviewing the patch proposal from Tobias.
Patch is already under CI testing...


>=20
> >=20
> > That said, we should double check that this corner case is handled righ=
t
> > on arm. If arm suffers from the same problem, this corner case is
> > missing in handle_irq_pipelined().
> >=20
> > I hope all of this makes sense at the end. It's late...
> >=20
> > Best regards,
> > Florian
> >=20
> > [2. text/vcard; florian_bezdeka.vcf]...
>=20
> --=20
> Philippe.
