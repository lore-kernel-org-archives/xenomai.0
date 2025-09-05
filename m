Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FE42EA477
	for <xenomai@lists.linux.dev>; Fri,  5 Sep 2025 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757109270; cv=none; b=LX8HmjKAwifm29Ju01pJ1OG2nq3h85yddGpiLgXbaj3wWe81CmwQKWv8aRmjc3hcmDQENpoNlUKtQNHR6MdwUqQX8Y5jQ87X11o/sGYnS4tDTOAO78rzhbfoHKiHdtEOfgXzDuauSZ9JzwHznfqa+kqTsWOEpWHWbJx8EWf1+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757109270; c=relaxed/simple;
	bh=kSKO6cFiY2w7D5/zWSmE110sR2J1EPZ8YOr/pvJyXb4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YOyiJHoDR/bNahHNBTqLpO/T886Sy1JShkznXytFW2183Frua1yUlgW3vQM7moaOFz+4wuT/o4qrNQzcCznRY6iw3OFch6cPQKjYtJ2/tL9Ies7NwpB0PNkmpJxrUjjgXOsB2OkQzuNp1pyO2X05+vFaMHtlvoMqd9X6hx8nb3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=aBPIgxKN; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="aBPIgxKN"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202509052154215b73bc9efe00020736
        for <xenomai@lists.linux.dev>;
        Fri, 05 Sep 2025 23:54:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Vo2rsT/aywPgxDcxFZDqzfdY5PtAT/MBCaOQ+TZn5Kw=;
 b=aBPIgxKNsB2rYb2+elwdmXxftuN32ptRxvQC/dvCiiSWOUIGf/wVa8Bo4VlBt2gBrOpDfR
 wRsLGwGnR+lMqL456NMwGSoHgX5y20sMMWSR10WLkLU/a2omySkJPSuGqb5ca2EBFatZKtQe
 RMLFjBWNIkwllQmIlpdDxa6oFMSgfm8naAAkscc2QiIHBCVAJZfbNZ0aBRMiK3jBqbAvOezY
 /Brtq9UufoaMg05i1Mu8O+N/cBkFnYul2aUgg4e5Oq1fN/KiFrVMUIfw8ubmjFNcG0AmO1h6
 wnZZbIu96+i68b1n9YKmVS6lbmBy6uffx0ZLWh8URxs0DIV3sI16Wfkg==;
Message-ID: <18e3f6b4f6f10574fafa5530be7bbeb1347fcfa1.camel@siemens.com>
Subject: Re: [PATCH Dovetail v2] irq_pipeline: Fix system freeze triggered
 by periodic edge type IRQs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <philippe.gerum@gmail.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Fri, 05 Sep 2025 23:54:18 +0200
In-Reply-To: <87ikhwk7y8.fsf@xenomai.org>
References: 
	<20250820-wip-flo-fix-edge-irq-handling-v2-1-1a958d17eace@siemens.com>
	 <87ikhwk7y8.fsf@xenomai.org>
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

On Fri, 2025-09-05 at 21:36 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > When IRQ pipelining is enabled, it could happen that handle_edge_irq()
> > is interrupted while syncing the IRQ log - for the very same IRQ.
> >=20
> > The pipeline entry code will set the IRQS_PENDING flag and bail out
> > forcing the sync code (lower part in handle_edge_irq()) to loop to
> > infinity as the (periodic) IRQ might fire again after calling
> > unmask_irq() and reaching the hard IRQ enablement in handle_irq_event()=
.
> >=20
> > There is a "race window" involved. To trigger looping to infinity the
> > IRQ(s) must arrive while processing the IRQ log for the same IRQ in
> > handle_irq_event().
> >=20
>=20
> [snip]
>=20
> >  kernel/irq/chip.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> > index 8a0831193d74..0fa3dce5b9fd 100644
> > --- a/kernel/irq/chip.c
> > +++ b/kernel/irq/chip.c
> > @@ -669,6 +669,8 @@ static bool irq_can_handle_pm(struct irq_desc *desc=
)
> >  		WARN_ON_ONCE(irq_pipeline_debug() && !in_pipeline());
> >  		if (irqd_is_wakeup_armed(&desc->irq_data))
> >  			return true;
> > +		if (irqd_irq_inprogress(&desc->irq_data))
> > +			return true;
> >  	} else if (irq_pm_check_wakeup(desc))
> >  		return false;
> > =20
> >=20
> > ---
> > base-commit: eec111a874f5899e1078ef785ccf29dff986e5a0
> > change-id: 20250820-wip-flo-fix-edge-irq-handling-16e48193aeac
> >=20
>=20
> Good catch, this bug was obviously no fun to track down.
>=20
> The change above raises an issue though: what guarantees us that no hard
> interrupt context for a given IRQ can run on multiple CPUs in parallel,
> since the interrupt is not going to be masked anymore? The logic above
> works if all occurrences hit the same CPU because the pipeline
> introduces the needed serialization by design via the log, but if an
> interrupt distributor decides to spray multiple occurrences of that
> interrupt on multiple CPUs, we could be toast.

I thought about that as well, but as far as I understood the code at
least x86 and arm64 enforce a single CPU inside the effective affinity
mask. So for those archs we would be fine - as long as no IRQ migration
is in flight. Still unsure about others archs...

The live lock situation during IRQ migration can happen on Linux as
well. There is a fix in flight [1] that will handle that for Linux >=3D
6.17.=20

Ideas welcome.

[1] https://github.com/torvalds/linux/commit/8d39d6ec4db5da9899993092227584=
a97c203fd3
