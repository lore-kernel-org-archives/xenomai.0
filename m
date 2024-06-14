Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA31487E9
	for <xenomai@lists.linux.dev>; Fri, 14 Jun 2024 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718356582; cv=none; b=XhraxXd46WVwwi3GZ8YqO7vhMzSugArvSes1RSWblwTi2DbOMxELVZ5crp+MFaZc1rRogEgHl+OlE73AegfhVFu1mXTK3TqdE3UEG6/ZWtn9jLE3NTrMtP1gQrg/TkU8YiIzLchTDASAsWeg+7a7tPSiz5lrvrLMm6gLrHjUmnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718356582; c=relaxed/simple;
	bh=25BviCGPt4r8Hsv1yUYebgwB+U42tkP9aXRVjdkDTCo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SI86COuRNGUgSKe5sM8vr/NMiyaITGCRfmbylhINJqlqS/SS55a3C07SB/pKuBf7MVywszvgK+aP1aDTxvzNCnuxcNMs088xqCVrYCO597jHShwnG75/dMrsrn7CLfawkWfK+eeDMoFw5/OkDomRn3X8oNfABzfcMYpT9XknweQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Hj24ugvJ; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Hj24ugvJ"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240614091608b37101d1e948e3c53a
        for <xenomai@lists.linux.dev>;
        Fri, 14 Jun 2024 11:16:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9/Qlrmxeguxiky1PAOyrvn9FlC53YNbF7kEHc7Bmk3s=;
 b=Hj24ugvJ4nja/lLGndJ3tTNQRUKWcn9qlnWVqI3IpueOFQMrBBGiWPcQykdatNmWDkIcpl
 eRHebLGzrPG5+WOdYHEbyUk82dBn+lYtctDJn3K+kjXPDHe1YEfVGCjflQqHQUXDIVqyLSkK
 4hF0LBWXhqCbpX78l8pB/J9QT8JHE=;
Message-ID: <7abb72db58b5398ddcc353e238d1694fceaba283.camel@siemens.com>
Subject: Re: [PATCH RFC dovetail 6.9 v2 2/2] KVM: x86: dovetail: Allow
 kvm_wait() to be called from any context
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Fri, 14 Jun 2024 11:16:03 +0200
In-Reply-To: <3b341ace-3af3-49b7-80a7-2343608674a1@siemens.com>
References: 
	<20240531-flo-fix-kvm-guest-for-6-9-v2-0-5534fcae4eb5@siemens.com>
	 <20240531-flo-fix-kvm-guest-for-6-9-v2-2-5534fcae4eb5@siemens.com>
	 <73b55cbb-0d7d-4552-9102-cc7c16e5834c@siemens.com>
	 <f57d19d9549525a94e1c22d0d9b520150afda04f.camel@siemens.com>
	 <dc350628-f444-41e4-93e8-b9724046b5a0@siemens.com>
	 <5c4192f8-067d-4a92-9ea2-ac5e77ff65bf@siemens.com>
	 <fe10e88839a636a104fa1fedbe75e424664763e1.camel@siemens.com>
	 <9c69a0a9-8307-4cf4-804b-1ba49353bb52@siemens.com>
	 <79f348d6442039a74eaa2f4129d1a5af5845ffdd.camel@siemens.com>
	 <3b341ace-3af3-49b7-80a7-2343608674a1@siemens.com>
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

On Fri, 2024-06-14 at 10:04 +0200, Jan Kiszka wrote:
> On 13.06.24 18:15, Florian Bezdeka wrote:
> > On Mon, 2024-06-10 at 23:16 +0200, Jan Kiszka wrote:
> > > On 10.06.24 09:58, Florian Bezdeka wrote:
> > > > On Mon, 2024-06-10 at 07:43 +0200, Jan Kiszka wrote:
> > > > > On 10.06.24 06:21, Jan Kiszka wrote:
> > > > > > On 09.06.24 13:44, Florian Bezdeka wrote:
> > > > > > > On Sat, 2024-06-08 at 07:31 +0200, Jan Kiszka wrote:
> > > > > > > > On 08.06.24 01:04, Florian Bezdeka wrote:
> > > > > > > > > kvm_wait() unconditionally enabled HW interrupts when cal=
led from
> > > > > > > > > pipeline entry code. That broke the PV (paravirtualized) =
spinlock
> > > > > > > > > implementation.
> > > > > > > > >=20
> > > > > > > > > When running with CONFIG_IRQ_PIPELINE enabled we always c=
all
> > > > > > > > > safe_halt() to allow HW IRQs to be handled.
> > > > > > > > >=20
> > > > > > > > > The !CONFIG_IRQ_PIPELINE part is now re-synced with the v=
ersion of
> > > > > > > > > Linux.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.c=
om>
> > > > > > > > > ---
> > > > > > > > >  arch/x86/kernel/kvm.c | 59 +++++++++++++++++++++++++++++=
++++++++++++++++------
> > > > > > > > >  1 file changed, 53 insertions(+), 6 deletions(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.=
c
> > > > > > > > > index 655b1cf8c9ab..3180a26cdfe1 100644
> > > > > > > > > --- a/arch/x86/kernel/kvm.c
> > > > > > > > > +++ b/arch/x86/kernel/kvm.c
> > > > > > > > > @@ -1059,22 +1059,69 @@ static void kvm_wait(u8 *ptr, u8 =
val)
> > > > > > > > >  	 * for irq enabled case to avoid hang when lock info is=
 overwritten
> > > > > > > > >  	 * in irq spinlock slowpath and no spurious interrupt o=
ccur to save us.
> > > > > > > > >  	 */
> > > > > > > > > +
> > > > > > > > > +#ifdef CONFIG_IRQ_PIPELINE
> > > > > > > > > +	unsigned long flags;
> > > > > > > > > +
> > > > > > > > > +	/*
> > > > > > > > > +	 * We always use safe_halt() to be interruptable by HW =
IRQs.
> > > > > > > >=20
> > > > > > > > Nope, see below.
> > > > > > > >=20
> > > > > > > > > +	 *
> > > > > > > > > +	 * HW IRQs off:
> > > > > > > >=20
> > > > > > > > Let's stick with the nomenclature "hard" instead of "hw".
> > > > > > > >=20
> > > > > > > > > +	 *
> > > > > > > > > +	 * Wake up on next HW IRQ or by a vCPU kick triggered b=
y the current
> > > > > > > > > +	 * lock owner.
> > > > > > > > > +	 */
> > > > > > > > > +	if (hard_irqs_disabled()) {
> > > > > > > > > +		if (READ_ONCE(*ptr) =3D=3D val) {
> > > > > > > > > +			safe_halt(); // enables HW IRQs
> > > > > > > > > +			hard_local_irq_disable();
> > > > > > > >=20
> > > > > > > > Just halt() - if we entered this with hard irqs off, we can=
not assume
> > > > > > > > that it is fine to take an IRQ before returning. The kernel=
 doesn't do
> > > > > > > > that either for Linux IRQs.
> > > > > > >=20
> > > > > > > ACK.
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > > +		}
> > > > > > > > > +		return;
> > > > > > > > > +	}
> > > > > > > > > +
> > > > > > > > > +	/*
> > > > > > > > > +	 * HW IRQs on:
> > > > > > > > > +	 *
> > > > > > > > > +	 * If inband IRQs are disabled the LOCKDEP state is alr=
eady correct.
> > > > > > > > > +	 * We can disable/enable HW IRQs without further bookke=
eping.
> > > > > > > > > +	 * =3D Linux IRQ context
> > > > > > > > > +	 *
> > > > > > > > > +	 * If inband IRQs are enabled we have to inform tracing=
 / LOCKDEP
> > > > > > > > > +	 * infrastructure about the HW IRQ disable/enable event=
.
> > > > > > > > > +	 * =3D Task context
> > > > > > > > > +	 */
> > > > > > > > >  	if (irqs_disabled()) {
> > > > > > > > > -		hard_local_irq_disable();
> > > > > > > > > +		flags =3D hard_local_irq_save();
> > > > > > > >=20
> > > > > > > > Why this? We have tested that state above and know it for s=
ure. Just
> > > > > > > > keep hard_local_irq_disable().
> > > > > > >=20
> > > > > > > Paranoia and to clearly express that we try to restore the st=
ate to the
> > > > > > > state that was observed on function entry. As hard IRQs are/w=
ere on the
> > > > > > > result of irqs_disabled() might be outdated. (I think that wo=
uld be a
> > > > > > > Dovetail BUG(), but paranoia...)
> > > > > > >=20
> > > > > > > No strong feelings here. I can change this if this is preferr=
ed on
> > > > > > > other ends.
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > > =20
> > > > > > > > >  		if (READ_ONCE(*ptr) =3D=3D val)
> > > > > > > > > -			halt();
> > > > > > > > > +			safe_halt(); // enables HW IRQs
> > > > > > > >=20
> > > > > > > > Yep, this is needed to avoid delaying hard irqs while waiti=
ng for the
> > > > > > > > Linux lock-holder.
> > > > > > > >=20
> > > > > > > > > =20
> > > > > > > > > -		hard_local_irq_enable();
> > > > > > > > > +		hard_local_irq_restore(flags);
> > > > > > > > >  	} else {
> > > > > > > > > -		local_irq_disable_full();
> > > > > > > > > +		local_irq_save_full(flags);
> > > > > > > >=20
> > > > > > > > See above.
> > > > > > > >=20
> > > > > > > > > +
> > > > > > > > > +		if (READ_ONCE(*ptr) =3D=3D val) {
> > > > > > > > > +			safe_halt(); // enables HW IRQs
> > > > > > > > > +			hard_local_irq_disable(); // fix HW state for LOCKDEP
> > > > > > > > > +		}
> > > > > > > > > +
> > > > > > > > > +		local_irq_restore_full(flags);
> > > > > > > >=20
> > > > > > > > How about this instead?
> > > > > > > >=20
> > > > > > > > if (READ_ONCE(*ptr) =3D=3D val) {
> > > > > > > > 	safe_halt(); /* enables hard irqs */
> > > > > > > > 	local_irq_disable();
> > > > > > >=20
> > > > > > > Confused. I think you mean local_irq_enable(), right? Otherwi=
se we
> > > > > > > would jump back with hard IRQs on (again), but inband IRQs di=
sabled.
> > > > > > >=20
> > > > > >=20
> > > > > > Yes, enable. The goal is to avoid that hard-irq back and forth.
> > > > > >=20
> > > > >=20
> > > > > Actually, there is no need for this dance at all. Just translate =
the
> > > > > Linux version of the "irqs on" branch to dovetail:
> > > > >=20
> > > > > 	hard_local_irq_disable();
> > > > >=20
> > > > > 	/* safe_halt() will enable IRQ */
> > > > > 	if (READ_ONCE(*ptr) =3D=3D val)
> > > > > 		native_safe_halt();
> > > > > 	else
> > > > > 		hard_local_irq_enable();
> > > > >=20
> > > > > There is no reason to touch the Linux IRQ mask. It's open on entr=
y, and
> > > > > we can take any type of IRQ while waiting.
> > > >=20
> > > > Correct, but we would miss this hard IRQ disable event in the traci=
ng
> > > > infrastructure. Is that OK?
> > >=20
> > > Not sure if hard irqs are actually traced. I thought they aren't with
> > > the given functions. If they are, you are right.
> >=20
> > hard_local_irq_disable() simply turns hard IRQs off. See
> > native_irq_disable().
> >=20
> > The replacement of local_irq_disable_full() is:
> >=20
> > do {
> > 	native_irq_disable();
> > 	do {
> > 		bool was_disabled =3D (arch_irqs_disabled());
> > 		arch_local_irq_disable();
> > 		if (!was_disabled)
> > 			trace_hardirqs_off();
> > 	} while (0);
> > } while (0)
> >=20
> >=20
> > It's basically hard_local_irq_disable() + tracing when the inband IRQs
> > were enabled. That would be the case here. Do you agree?
> >=20
>=20
> Yes, and as we have no need to fiddle with the latter, I wanted to
> reduce all this to the hard irqs.

That is understood. As we agree that tracing is not necessary we can
simplify further. Preparing v3.

>=20
> > I think it's worth to keep / get a trace event here. The underlying
> > hypervisor might be the source of some latency. Would be good to see
> > that in the trace.
>=20
> What business does the hypervisor have with the virtual IRQ mask for
> Linux that Dovetail maintains?

There are two ways to come back from safe_halt(). The first one is a
hard IRQ, the second one is a kick by the hypervisor triggered by the
current lock holder via hypercall.

>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

