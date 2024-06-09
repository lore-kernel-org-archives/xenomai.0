Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5438120B33
	for <xenomai@lists.linux.dev>; Sun,  9 Jun 2024 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717933514; cv=none; b=rrV5HMQTPuVARO9RPMxzpaacrYkgODgaPrkOjjsQZXefQNdZRFpeRP/5hwiD+Y3aySfJ6Ta2w9d1vun6iYmu3O3K0tGP063Ur9fZ/AZ1thr9IabBInvgQfuj8lETfndc8/twP4LN+nP3jngwQVlkIPb8TyJzQ2bCbs2vgRe83vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717933514; c=relaxed/simple;
	bh=2eTJiegbVWQTKnN8eQNwFMs9Nyq3q4FuPst1n5JX60o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UgWgysSvARRUszLDw+jMBB1MmYXBWeohDrj/PFooeFdK2MICe5YpwOZOi9MKmSfqbXvXR2CJiZ30zCPj5UBDKyHSr4yxhRbtsWLOta8AyL0L50grORrClp7R8ujkuxNMIOn42pgMZZMz2D5El6FwPxz9f2B0Y8YkER575PaQb98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=G1yocVCC; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="G1yocVCC"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240609114458fd1578b6bbb21c2bec
        for <xenomai@lists.linux.dev>;
        Sun, 09 Jun 2024 13:44:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=MhroDn/iMP6+Gd/u4QUx1/gSqBmuCH8kSr9+5OM34cU=;
 b=G1yocVCCX4YLC5O1awiv4pTcg/58OJMZmyp8La5mkHkBZmG3S36wY+xCjX1eoZIFem8lym
 vkeOsFtAIFIcTv6h3jS4+gxac9eY1Jyl/H1Ubh5wvMB5r/n+0kExm4WwkHzMl2LDr2vDiZJr
 vb/XjPTKIJNQyalp5Vf6ZlJX8GazA=;
Message-ID: <f57d19d9549525a94e1c22d0d9b520150afda04f.camel@siemens.com>
Subject: Re: [PATCH RFC dovetail 6.9 v2 2/2] KVM: x86: dovetail: Allow
 kvm_wait() to be called from any context
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Sun, 09 Jun 2024 13:44:56 +0200
In-Reply-To: <73b55cbb-0d7d-4552-9102-cc7c16e5834c@siemens.com>
References: 
	<20240531-flo-fix-kvm-guest-for-6-9-v2-0-5534fcae4eb5@siemens.com>
	 <20240531-flo-fix-kvm-guest-for-6-9-v2-2-5534fcae4eb5@siemens.com>
	 <73b55cbb-0d7d-4552-9102-cc7c16e5834c@siemens.com>
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

On Sat, 2024-06-08 at 07:31 +0200, Jan Kiszka wrote:
> On 08.06.24 01:04, Florian Bezdeka wrote:
> > kvm_wait() unconditionally enabled HW interrupts when called from
> > pipeline entry code. That broke the PV (paravirtualized) spinlock
> > implementation.
> >=20
> > When running with CONFIG_IRQ_PIPELINE enabled we always call
> > safe_halt() to allow HW IRQs to be handled.
> >=20
> > The !CONFIG_IRQ_PIPELINE part is now re-synced with the version of
> > Linux.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  arch/x86/kernel/kvm.c | 59 +++++++++++++++++++++++++++++++++++++++++++=
++------
> >  1 file changed, 53 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index 655b1cf8c9ab..3180a26cdfe1 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> > @@ -1059,22 +1059,69 @@ static void kvm_wait(u8 *ptr, u8 val)
> >  	 * for irq enabled case to avoid hang when lock info is overwritten
> >  	 * in irq spinlock slowpath and no spurious interrupt occur to save u=
s.
> >  	 */
> > +
> > +#ifdef CONFIG_IRQ_PIPELINE
> > +	unsigned long flags;
> > +
> > +	/*
> > +	 * We always use safe_halt() to be interruptable by HW IRQs.
>=20
> Nope, see below.
>=20
> > +	 *
> > +	 * HW IRQs off:
>=20
> Let's stick with the nomenclature "hard" instead of "hw".
>=20
> > +	 *
> > +	 * Wake up on next HW IRQ or by a vCPU kick triggered by the current
> > +	 * lock owner.
> > +	 */
> > +	if (hard_irqs_disabled()) {
> > +		if (READ_ONCE(*ptr) =3D=3D val) {
> > +			safe_halt(); // enables HW IRQs
> > +			hard_local_irq_disable();
>=20
> Just halt() - if we entered this with hard irqs off, we cannot assume
> that it is fine to take an IRQ before returning. The kernel doesn't do
> that either for Linux IRQs.

ACK.

>=20
> > +		}
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * HW IRQs on:
> > +	 *
> > +	 * If inband IRQs are disabled the LOCKDEP state is already correct.
> > +	 * We can disable/enable HW IRQs without further bookkeeping.
> > +	 * =3D Linux IRQ context
> > +	 *
> > +	 * If inband IRQs are enabled we have to inform tracing / LOCKDEP
> > +	 * infrastructure about the HW IRQ disable/enable event.
> > +	 * =3D Task context
> > +	 */
> >  	if (irqs_disabled()) {
> > -		hard_local_irq_disable();
> > +		flags =3D hard_local_irq_save();
>=20
> Why this? We have tested that state above and know it for sure. Just
> keep hard_local_irq_disable().

Paranoia and to clearly express that we try to restore the state to the
state that was observed on function entry. As hard IRQs are/were on the
result of irqs_disabled() might be outdated. (I think that would be a
Dovetail BUG(), but paranoia...)

No strong feelings here. I can change this if this is preferred on
other ends.

>=20
> > =20
> >  		if (READ_ONCE(*ptr) =3D=3D val)
> > -			halt();
> > +			safe_halt(); // enables HW IRQs
>=20
> Yep, this is needed to avoid delaying hard irqs while waiting for the
> Linux lock-holder.
>=20
> > =20
> > -		hard_local_irq_enable();
> > +		hard_local_irq_restore(flags);
> >  	} else {
> > -		local_irq_disable_full();
> > +		local_irq_save_full(flags);
>=20
> See above.
>=20
> > +
> > +		if (READ_ONCE(*ptr) =3D=3D val) {
> > +			safe_halt(); // enables HW IRQs
> > +			hard_local_irq_disable(); // fix HW state for LOCKDEP
> > +		}
> > +
> > +		local_irq_restore_full(flags);
>=20
> How about this instead?
>=20
> if (READ_ONCE(*ptr) =3D=3D val) {
> 	safe_halt(); /* enables hard irqs */
> 	local_irq_disable();

Confused. I think you mean local_irq_enable(), right? Otherwise we
would jump back with hard IRQs on (again), but inband IRQs disabled.

> } else {
> 	local_irq_enabled_full();
> }
>=20
>=20
> > +	}
> > +
> > +#else /* !CONFIG_IRQ_PIPELINE */
> > +	if (irqs_disabled()) {
> > +		if (READ_ONCE(*ptr) =3D=3D val)
> > +			halt();
> > +	} else {
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
>=20
> Yeah, we indeed need to preserve the original version for the
> !IRQ_PIPELINE case. This was also broken.
>=20
> Jan
>=20
> >  }
> > =20
> >  /*
> >=20
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

