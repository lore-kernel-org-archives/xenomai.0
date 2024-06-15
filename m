Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D491F5F5
	for <xenomai@lists.linux.dev>; Sat, 15 Jun 2024 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718489284; cv=none; b=HvuIy7hxBC4DOI9uDPaz4hVumgcq/ki9nFzKZi6dxEufi/+VRIcjYeB6i6TrlSa54DLzPOKWxPlo68kOYldV2DjWv4h202mbA+is1+Y+G9hEx78DWPr05qJUAULN9Pbm1P8jojqr0aeCbuIz4mo5rdGBoB6DQDegENIbDWkWfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718489284; c=relaxed/simple;
	bh=+NW2vwPos8M5h3aH88tr+bQgHRg3wmbY5BtDAWIqfpQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l8pFMXyDwXN6G8A6XrNKLAIMKn+fCLfzbm8ksW32FBXpShh/bbVGgjxjfQzgo0v1dsBVqlV61VcDlZMj4ylNu/xIrhKKcFz+RHp7+lFXmULKL8MdQyITuQpNoRrZG64V03iinHi7k/rxUKW7XpLsIJOzcdvAnC31OHBrM0/oHjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=RZgho9eH; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="RZgho9eH"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240615215741a8f51a603989458854
        for <xenomai@lists.linux.dev>;
        Sat, 15 Jun 2024 23:57:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Z+cXY2uTURRE9ovrd0j8lk4b9x1MWC7W6/JENVh7ubE=;
 b=RZgho9eHEEvh4GMvBsLBG6Zqy+OVMMcRhl+Lm+tKgSG1EQnWNSnkesitpbktlI0zS933ST
 6w1NSJTKoqDJh94BKDqy9ctnxOMa0fDvyyTVlgZFIjb7LD262xMNc+iR48YHUDmQsbVlMCc/
 nEGFVvwOaLRtS2VBpy165Pbmv7LK0=;
Message-ID: <fa9a62f546be4093c43e28dd4a759b26a6795f8f.camel@siemens.com>
Subject: Re: [PATCH dovetail v3 2/2] KVM: x86: dovetail: Allow kvm_wait() to
 be called from any context
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Sat, 15 Jun 2024 23:57:40 +0200
In-Reply-To: <3213cc86-82ae-40ef-8793-811b9bb4e3e1@siemens.com>
References: 
	<20240531-flo-fix-kvm-guest-for-6-9-v3-0-ebcf517500a3@siemens.com>
	 <20240531-flo-fix-kvm-guest-for-6-9-v3-2-ebcf517500a3@siemens.com>
	 <3213cc86-82ae-40ef-8793-811b9bb4e3e1@siemens.com>
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

On Sat, 2024-06-15 at 09:35 +0200, Jan Kiszka wrote:
> On 14.06.24 13:53, Florian Bezdeka wrote:
> > kvm_wait() unconditionally enabled HW interrupts when called from
> > pipeline entry code. That broke the PV (paravirtualized) spinlock
> > implementation.
> >=20
> > The following calling contexts are supported now:
> >   - pipeline entry, hard IRQs off:
> >     Wakeup on vCPU kicks only, triggered by the current lock owner via
> >     hypercall. Using halt().
> >=20
> >   - Linux IRQ context, hard IRQs on, inband IRQs off:
> >     Wakeup on the next hard IRQ, or by a vCPU kick.
> >     Using safe_halt().
> >=20
> >   - Task context, hard IRQs on, inband IRQs on:
> >     Same as Linux IRQ context. We stall the inband stage before calling
> >     safe_halt().
> >=20
> > The !CONFIG_IRQ_PIPELINE part is now re-synced with the version of
> > Linux.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  arch/x86/kernel/kvm.c | 47 ++++++++++++++++++++++++++++++++++++++++++-=
----
> >  1 file changed, 42 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index 655b1cf8c9ab..76bd881e1137 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> > @@ -1059,22 +1059,59 @@ static void kvm_wait(u8 *ptr, u8 val)
> >  	 * for irq enabled case to avoid hang when lock info is overwritten
> >  	 * in irq spinlock slowpath and no spurious interrupt occur to save u=
s.
> >  	 */
> > -	if (irqs_disabled()) {
> > -		hard_local_irq_disable();
> > =20
> > +#ifdef CONFIG_IRQ_PIPELINE
> > +
> > +	/*
> > +	 * Hard IRQs off:
> > +	 * Only wake up on a vCPU kick triggered by the current lock owner.
> > +	 */
> > +	if (hard_irqs_disabled()) {
> >  		if (READ_ONCE(*ptr) =3D=3D val)
> >  			halt();
> > +		return;
> > +	}
> > =20
> > -		hard_local_irq_enable();
> > +	/*
> > +	 * Hard IRQs on:
> > +	 *
> > +	 * We always use safe_halt() to be interruptable by hard IRQs.
> > +	 *
> > +	 * Inband IRQs disabled: Linux IRQ context
> > +	 * Inband IRQs enabled: Task context
> > +	 */
> > +	if (irqs_disabled()) {
> > +		hard_local_irq_disable();
> > +
> > +		if (READ_ONCE(*ptr) =3D=3D val)
> > +			safe_halt(); /* enables hard IRQs */
> > +		else
> > +			hard_local_irq_enable();
> >  	} else {
> >  		local_irq_disable_full();
> > =20
> > +		if (READ_ONCE(*ptr) =3D=3D val) {
> > +			safe_halt(); /* enables hard irqs */
> > +			local_irq_enable();
> > +		} else {
> > +			local_irq_enable_full();
> > +		}
> > +	}
> > +
>=20
> 	if (hard_irqs_disabled()) {
>  		if (READ_ONCE(*ptr) =3D=3D val)
>  			halt();
> 	} else {
> 		hard_local_irq_disable();
>=20
> 		if (READ_ONCE(*ptr) =3D=3D val)
> 			native_safe_halt(); /* enables hard IRQs */
> 		else
> 			hard_local_irq_enable();
> 	}

I played around with that exactly the same idea last week.

There is one major difference between your proposal and v3: The inband
stage does not get stalled. Means we would really process the (inband)
IRQ instead of writing it into the IRQ log.

That made me worry about some nesting scenarios, but maybe there is
none. Have to re-think again next week...

>=20
> I don't think it takes more than that for CONFIG_IRQ_PIPELINE. And the=
=20
> only reason to have the ifdef here is that it preserves trace_hardirqs=
=20
> for !CONFIG_IRQ_PIPELINE. The actual functionality would work as-is=20
> there, too.
>=20
> Jan
>=20
> > +#else /* !CONFIG_IRQ_PIPELINE */
> > +	if (irqs_disabled()) {
> > +		if (READ_ONCE(*ptr) =3D=3D val)
> > +			halt();
> > +	} else {
> > +		local_irq_disable();
> > +
> >  		/* safe_halt() will enable IRQ */
> >  		if (READ_ONCE(*ptr) =3D=3D val)
> >  			safe_halt();
> > -
> > -		local_irq_enable_full();
> > +		else
> > +			local_irq_enable();
> >  	}
> > +#endif
> >  }
> > =20
> >  /*
> >=20
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

