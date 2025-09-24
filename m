Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B141D269806
	for <xenomai@lists.linux.dev>; Wed, 24 Sep 2025 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700334; cv=none; b=Xh2PrCnRNS/a9KilS2oVHr1F+sSyHlEG0xDlhmYCZR0sOVRYUkCn14X84D5IA0+Fdtx0xwQtV100G4Q5upVZ0ADozcieWK/wl3oIZXkIrb4IFR/QR6KiCvcgFGgBs4LztlJADlR8T5a0xcxVI3OejG04lgRQeZtRruiEfq4F5bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700334; c=relaxed/simple;
	bh=8/SErnt3eiG+zC/7U/sJM3EIn4hqREe66a2u3I3MkxM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GTW/nFZIiRddmr4PJ461pyIiEumh8fLT4MSAdItAcNrVElGvZHEtF6WELC5WPkQkLipCLTpLUhX3ofe+ZwQ7w85O9JRrbVy9D1SgP8/XSqUtn6GW66CjABGF2i25nQrLxH5fdVOsEIyTF5tXl/crnWe3B5/OIgfwd48funfxs8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=pluLP8ov; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="pluLP8ov"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250924075159eab78ba3cb000207d0
        for <xenomai@lists.linux.dev>;
        Wed, 24 Sep 2025 09:51:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UlCY4Kbq+cL5iRqcEqjJIUgoYU0e3Dp9p9Lskgc4qU8=;
 b=pluLP8ovsvIoyXHmWoOwSr02/PP9gRj96gepKSbP6lNvLHGO+yX87P1Knd4TLOihu5Jn59
 w95ZVmrGj29g/iCyriKiLHcIdzJ35c4bEGeD83DOyvtz2bp80qQjFKyKx3/0WjhtCE7v+77H
 hx/Y1LsNFXK+31Oy8pL0kUUkn43FfCu362xrho6Yl6RoiltckKXw0Z9p/H0JKSa1I252Q1Dy
 b8ueWyeSzEeJVcniWRLcQZ4aosDdENWDzuOgbvkFsqm28aM3uZftzi93B19Ok9AxX/ikgVTC
 RpbPwGq3j9AQi98QHNqMkioQsJuWZramfar52GnFphgxf3HP1eoivHSA==;
Message-ID: <11dda4abd1986a4abcb0dca5af57f3fe8bb40bbe.camel@siemens.com>
Subject: Re: [PATCH 1/4] clocksource/hyper-v: irq_pipeline: Enable pipelined
 clock events
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Date: Wed, 24 Sep 2025 09:51:58 +0200
In-Reply-To: <87h5wtm2ot.fsf@xenomai.org>
References: 
	<20250602-flo-add-hyperv-support-for-6-15-v1-0-449e6c20debd@siemens.com>
		<20250602-flo-add-hyperv-support-for-6-15-v1-1-449e6c20debd@siemens.com>
	 <87h5wtm2ot.fsf@xenomai.org>
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

On Tue, 2025-09-23 at 20:41 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > Fixes a boot failure on hyper-v.
> >=20
>=20
> A bit of context would help here. Failure doing what, enabling the proxy
> tick on STIMER0?

ACK. That goes back to the early phase of enabling hyper-v where I
simply did not care about story telling yet.

Proposal:

Make the clock event around the STIMER0 pipeline safe. The
implementation is following the same pattern that we already have in
place for the x86 LAPIC interrupt / clock event.

To get the proxy tick working we need to link the hyperv clock event
device with the STIMER0 vector. This part is also following the pattern
of the x86 lapic interrupt. Both have a fixed arch specific vector
assigned.

>=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  drivers/clocksource/hyperv_timer.c | 34 ++++++++++++++++++++++++++++++=
+++-
> >  1 file changed, 33 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/h=
yperv_timer.c
> > index 2edc13ca184e0..0850b0c385a8e 100644
> > --- a/drivers/clocksource/hyperv_timer.c
> > +++ b/drivers/clocksource/hyperv_timer.c
> > @@ -26,6 +26,7 @@
> >  #include <clocksource/hyperv_timer.h>
> >  #include <hyperv/hvhdk.h>
> >  #include <asm/mshyperv.h>
> > +#include <asm/trace/irq_vectors.h>
> > =20
> >  static struct clock_event_device __percpu *hv_clock_event;
> >  /* Note: offset can hold negative values after hibernation. */
> > @@ -53,6 +54,30 @@ static int stimer0_irq =3D -1;
> >  static int stimer0_message_sint;
> >  static __maybe_unused DEFINE_PER_CPU(long, stimer0_evt);
> > =20
> > +#ifdef CONFIG_IRQ_PIPELINE
> > +
> > +#define HV_STIMER_IRQ	apicm_vector_irq(HYPERV_STIMER0_VECTOR)
> > +
>=20
> Does this mean that we won't support Hyper-V on architectures with
> per-CPU irqs (according to the comment heading hv_setup_stimer0_irq()),
> or is this ok to always bypass the ACPI in order to get the STIMER0
> interrupt in the pipeline case?

I came along the same question during implementation. The most
confusing part is, that this per-cpu IRQ implementation has no in-tree
user - or I could not find it.

It all starts in hv_stimer_setup_percpu_clockev() (x86 specific) where
we have the only user of hv_stimer_alloc() with have_percpu_irqs set to
false.

With that I decided to follow the same pattern as we have in place for
the APIC timer IRQ on x86.

>=20
> > +static irqreturn_t hv_stimer_oob_handler(int irq, void *dev_id)
> > +{
> > +	struct clock_event_device *evt =3D this_cpu_ptr(hv_clock_event);
> > +
> > +	trace_local_timer_entry(HYPERV_STIMER0_VECTOR);
> > +	clockevents_handle_event(evt);
> > +	trace_local_timer_exit(HYPERV_STIMER0_VECTOR);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
>=20
> Could not we have hv_stimer0_isr() call clockevents_handle_event()
> instead, so that hv_setup_stimer0_irq() -> hv_stimer0_percpu_isr() could
> be reused, only fixed up for picking the IRQ number from the apic
> mapping if interrupts are pipelined?

I definitely tried updating hv_stimer0_isr() to call
clockevents_handle_event(). It has been a while so I'm not sure if
memories are still correct: It might happen that the STIMER0 IRQ fires
before the proxy tick infrastructure is in place, so it ended up in
"ignoring a timer tick".

In any case there was/is a reason why the LAPIC is using
local_apic_timer_interrupt() for a short period in time and later moves
on to the oob action. The same reason applied to STIMER0.

>=20
> > +static struct irqaction hv_stimer_oob_action =3D {
> > +	.handler =3D hv_stimer_oob_handler,
> > +	.name =3D "Out-of-band STIMER0 timer interrupt",
> > +	.flags =3D IRQF_TIMER | IRQF_PERCPU,
> > +};
> > +#else
> > +#define HV_STIMER_IRQ	-1
> > +#endif
> > +
> >  /*
> >   * Common code for stimer0 interrupts coming via Direct Mode or
> >   * as a VMbus message.
> > @@ -137,8 +162,9 @@ static int hv_stimer_init(unsigned int cpu)
> > =20
> >  	ce =3D per_cpu_ptr(hv_clock_event, cpu);
> >  	ce->name =3D "Hyper-V clockevent";
> > -	ce->features =3D CLOCK_EVT_FEAT_ONESHOT;
> > +	ce->features =3D CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PIPELINE;
> >  	ce->cpumask =3D cpumask_of(cpu);
> > +	ce->irq =3D HV_STIMER_IRQ;
> > =20
> >  	/*
> >  	 * Lower the rating of the Hyper-V timer in a TDX VM without paraviso=
r,
> > @@ -305,6 +331,12 @@ int hv_stimer_alloc(bool have_percpu_irqs)
> >  		hv_remove_stimer0_irq();
> >  		goto free_clock_event;
> >  	}
> > +
> > +#ifdef CONFIG_IRQ_PIPELINE
> > +	ret =3D setup_percpu_irq(HV_STIMER_IRQ, &hv_stimer_oob_action);
> > +	if (ret)
> > +		goto free_clock_event;
> > +#endif
> >  	return ret;
> > =20
> >  free_clock_event:
>=20
> --=20
> Philippe.
