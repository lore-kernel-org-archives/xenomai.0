Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBCF16E898
	for <xenomai@lists.linux.dev>; Fri, 21 Jun 2024 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962777; cv=none; b=A0LIhlLh+BHHcRYCqyZ+Dc5DaL8K15C0VYcDJqMEsHxlSCEobT91c3atwLFK6b9bAlx+SdAY48fmMwMgNHQvIBkWaIjy+StwJCjebWvhB3AVoMYoaoGHVI5vI4FLY3iIzuPydqyd4RvhtQmNDH8HFkt3JP6VGZLGAdIwDcwHZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962777; c=relaxed/simple;
	bh=HZ1oaC8bxbPxaQPM06ONVT/dG4eU8QflXzQDBzL+VcU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iuoP11N7PSXX/a2+Es6Zq3o2KD/iS1jjFmmyxxfj9qDu7Rtcbx+J7gYJj7EIh+va69JpQE9JyFB5ntk/YPv1YBR6Dr3n/Z+FTVI62fNlfraiUyZT7L4NW1Vu809rs0/kWRAFuUH4njsNx20MaEP5nPRFy/sqVQyM+P+FToXyBFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=oXBEYViH; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="oXBEYViH"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202406210939230f24ba78a8adf92363
        for <xenomai@lists.linux.dev>;
        Fri, 21 Jun 2024 11:39:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2wTxIyFD5rFjwzpxEWnVcG4zAn7kpq2m3EHkcFT2dk0=;
 b=oXBEYViH/5cPb356D1qV5B503+HsFS/vs0E9v2xJuKY+AZxh+2gcHYHsNLEE8ve9srSihv
 FluojnYvcDHVeTb7rj/R//YvPwk3pWtubUK7NdqoDNhx4ArGuDdvDSL9RAELnyWnUhIdtbz1
 5G+fPiSaFqbaRaaJG6Oev1Ztaf+Jo=;
Message-ID: <2f5d7cd1ab757b5d752075ce72e3e61b769e23f1.camel@siemens.com>
Subject: Re: [PATCH dovetail v4 2/2] KVM: x86: dovetail: Allow kvm_wait() to
 be called from any context
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Fri, 21 Jun 2024 11:39:22 +0200
In-Reply-To: <d9cabca0-2d0d-45e1-8c50-18c4a0c02ecf@siemens.com>
References: 
	<20240531-flo-fix-kvm-guest-for-6-9-v4-0-77471c9473d8@siemens.com>
	 <20240531-flo-fix-kvm-guest-for-6-9-v4-2-77471c9473d8@siemens.com>
	 <d9cabca0-2d0d-45e1-8c50-18c4a0c02ecf@siemens.com>
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

On Fri, 2024-06-21 at 08:11 +0200, Jan Kiszka wrote:
> On 20.06.24 12:36, Florian Bezdeka wrote:
> > kvm_wait() unconditionally enabled HW interrupts when called from
> > pipeline entry code. That broke the PV (paravirtualized) spinlock
> > implementation.
> >=20
> > The following calling contexts are supported now:
> >   - pipeline entry, hard IRQs off:
> >     Wakeup on vCPU kicks only, triggered by the current lock owner via
> >     hypercall. Using halt().
> >=20
> >   - Linux IRQ context, hard IRQs on, in-band IRQs off:
> >     Wakeup on the next hard IRQ, or by a vCPU kick.
> >     Using safe_halt().
> >=20
> >   - Task context, hard IRQs on, in-band IRQs on:
> >     Same as Linux IRQ context.
> >=20
> > The !CONFIG_IRQ_PIPELINE part is now re-synced with the version of
> > Linux to keep trace events.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  arch/x86/kernel/kvm.c | 26 ++++++++++++++++++++------
> >  1 file changed, 20 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index 655b1cf8c9ab..90387564d06c 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> > @@ -1059,22 +1059,36 @@ static void kvm_wait(u8 *ptr, u8 val)
> >  	 * for irq enabled case to avoid hang when lock info is overwritten
> >  	 * in irq spinlock slowpath and no spurious interrupt occur to save u=
s.
> >  	 */
> > -	if (irqs_disabled()) {
> > -		hard_local_irq_disable();
> > =20
> > +#ifdef CONFIG_IRQ_PIPELINE
> > +
> > +	if (hard_irqs_disabled()) {
> >  		if (READ_ONCE(*ptr) =3D=3D val)
> >  			halt();
> > +	} else {
> > +		hard_local_irq_disable();
> > +
> > +		if (READ_ONCE(*ptr) =3D=3D val)
> > +			safe_halt(); /* enables hard IRQs */
>=20
> native_safe_halt(), or you get trace_hardirqs_on() and confuse lockdep.

In general: ACK.

It actually didn't trigger any lockdep warnings within the last week of
intensive testing. Each branch taken a multiple of 2^32 times on each
core of a 64 core VM - stressed with in- and out-of-band workloads in
parallel.

Whatever, will send v5 after some testing.

>=20
> Jan
>=20
> > +		else
> > +			hard_local_irq_enable();
> > +	}
> > =20
> > -		hard_local_irq_enable();
> > +#else /* !CONFIG_IRQ_PIPELINE */
> > +
> > +	if (irqs_disabled()) {
> > +		if (READ_ONCE(*ptr) =3D=3D val)
> > +			halt();
> >  	} else {
> > -		local_irq_disable_full();
> > +		local_irq_disable();
> > =20
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

