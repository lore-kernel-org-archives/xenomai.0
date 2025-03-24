Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C3194AC7
	for <xenomai@lists.linux.dev>; Mon, 24 Mar 2025 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742846759; cv=none; b=qjpdTSSFqK3vGC0l+SORma3ovPzIi3jHHr0gboGpz7b76BNxuHbLub+EWbJ/pPn7YHAVlSVxwK+OX1pveC3lTQSiNaI0wjrDYHpeiWptHKIVd49IcbMPbP612lPI1P8BoTdVsUptqtBa2Y67/pnTU5nD2byR1g7lztTw0DgZT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742846759; c=relaxed/simple;
	bh=ALjxeGNlAiDHyoM0ZnR8bDM6k3qaM7tsGlggSzRgXK4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q1K2Gj3DL2KCCBfwDhu8xNWkRt+0AQzVj4sTx08b3slwLAhIaNolOoisEkmcnufYQmXTcNKxEZahjKkP6QY9CYLiXndv4DEPl/c+/lJWNqRMbH4xFgNG7EVerTdWYx62IW4ycg27muLl+MVAiumLvYVvlh9eEHnuWwK6uwVKwMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=HiW2A9GX; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="HiW2A9GX"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202503242005509dbbba95d0365ffebd
        for <xenomai@lists.linux.dev>;
        Mon, 24 Mar 2025 21:05:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=jQDdNv3Jx2TtjOOBXWf5akqfF3WcD3xJapV0YjBld+g=;
 b=HiW2A9GXR4N4vJ8nCS2tlkcikXWjwjeVsxfq7OaMvS/zPXgbC7dQdcE9V5GYmLJA8hCRGa
 aFHfyfdpalInBsDAvVvRAK9/w03B3Xu7Q30Uyf7oOtLkukTtYRrJMcsdqq+so53QTQ20OLNx
 sf4uOYNRJ8KP+Zlv4kyah+TJinBwVHkfrSNIeWZWgXi6t66srbepd3U2cycEMMwv+QIhZB/N
 jxtYpkKypjLzYA2KuVrxd5CuWuyOgV5lpNvM7oPpdVKB/Ydv5jV5T/j5acinxCmAFJHRpG0D
 wz7d3f+adecV8Oh7/CGlsATCszPFfI9xg9Z9s1yzjws4tDsFCwgHAm5Q==;
Message-ID: <8f8bd888eb5bda50d43c9c31c9ad2ce5d1279c44.camel@siemens.com>
Subject: Re: [PATCH] dovetail: Fix interrupt re-enabling after hibernation
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Mon, 24 Mar 2025 21:05:50 +0100
In-Reply-To: <87ikny7bpc.fsf@xenomai.org>
References: <68cf84b9-57bc-4a6c-9546-101a13c7acc4@siemens.com>
		<6523189779e8b26ef3f8829de0835b1bbeab8b1c.camel@siemens.com>
	 <87ikny7bpc.fsf@xenomai.org>
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

On Mon, 2025-03-24 at 15:19 +0100, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Thu, 2025-03-20 at 17:41 +0100, Jan Kiszka wrote:
> > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > >=20
> > > We had unbalanced hard_cond_local_irq_disable here so far.
> > >=20
> > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > ---
> > >=20
> > > Minus one hunk that is already in current 6.12.y, this needs to be=
=20
> > > applied to older stable versions as well.
> > >=20
> > >  kernel/power/hibernate.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > > index 733b1a196f09e..e1c05f276a453 100644
> > > --- a/kernel/power/hibernate.c
> > > +++ b/kernel/power/hibernate.c
> > > @@ -352,6 +352,7 @@ static int create_image(int platform_mode)
> > >  	syscore_resume();
> > > =20
> > >   Enable_irqs:
> > > +	hard_cond_local_irq_enable();
> > >  	system_state =3D SYSTEM_RUNNING;
> > >  	local_irq_enable();
> >=20
> > General question about ordering here:
> >=20
> > The order hard_cond_local_irq_enable() followed by local_irq_enable()
> > seems wrong to me. We enable hard irqs first, then we unstall the
> > inband stage.
> >=20
> > That means that an hard irq might arrive and will end up in the IRQ
> > log, which is not processed by local_irq_enable(), so we are delaying
> > the IRQ processing to an unknown later time.
> >=20
>=20
> We are not delaying any IRQ, the implementation would just log any
> incoming IRQ into the log, until __inband_irq_enable() eventually
> disables them the hard way to check the log content, calling
> sync_current_irq_stage() if any is to be played back.
>=20
> > The other way around would make more sense to me. Is my understanding
> > right?
> >=20
>=20
> Nope. The proper ordering is _always_ hard_local_irq_enable() _then_
> local_irq_enable. There is also an historical reason for this (see
> comment in inband_irq_enable()).

Thanks, my bad. Seems I overlooked that __inband_irq_enable() is
processing the IRQ log if there is a need to do so.

>=20
> --=20
> Philippe.

