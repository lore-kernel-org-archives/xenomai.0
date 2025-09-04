Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30FF306D57
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992766; cv=none; b=YlIMk+K7m6MWwNZgsp0eHgJ+Bh1UbWGl9nfu8khnCVahEGaadkSzTBJujE8XJ0DNKCSTO1VZD3l1V7TAA95vzvTkvsv3mSoCpb/fxu1OVtMkbeMHyM3Zi523MtFIPJX8NL3Ehf+pTZ+Eh+9naRlm9XSA9XvaXseIoZ/MCjZa04s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992766; c=relaxed/simple;
	bh=UuIwBwlAdsz5Kgg+Jsy/1EBdpMspCr8uxMhn+RqZjJU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WyHL/s5+EVBiHmaM9erU8PTSDJNNXtxN04n2/W6ixh4ZfB7nsESGpfReesXd73LUKNXPpJi3a9ox5K2J3FCgCk94AuC6zOb+2kAfxIov8W07rGdZHp/ORU1xegZO/Jj2LHj2LE9WRLkd+YPxt8MCaWFdCMHxXRKrQrtSvmfSEU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=hqZvQx+f; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="hqZvQx+f"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202509041332307e675da20f000207f7
        for <xenomai@lists.linux.dev>;
        Thu, 04 Sep 2025 15:32:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=VB4ozBjoGHhwtgvx27nOPi9+JD9xIviwk3HY1RYXR7k=;
 b=hqZvQx+fp/zRVhTBpYsxp0cANHs7h8na22XFOBKwJSZSIEzdQF4MF0bjCXyR653gLVUXNn
 6iW5xGW60dtFnL+RlCYa6tYeIRMEmRnGpvaMXif2k72IOWooxD+v0QVkvOjBeLN1aqb9L8qV
 luYUa2NvlYKC01woPjiT3JnEe2g0Y3pEz4VpWd5HV6lBzIaCT9fS5Uf+A0NATCO8lm3NUDMH
 vJ8ULktOkK3C7Bt1wVsdWoepp89U4y2kHDS7NESQrUnVGEy3KK6/9eZFwPt+/exO23U/UTaI
 NeVf4vsHqAEAguFFrc34TgQxX8DY4iXOqMQCAO47fNMxb2z3ddiyDmQA==;
Message-ID: <bafd1c636d2f9a97408efa5532476c4c975e0bbe.camel@siemens.com>
Subject: Re: [PATCH Dovetail] irq_pipeline: Fix system freeze triggered by
 periodic edge type IRQs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <philippe.gerum@gmail.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu, 04 Sep 2025 15:32:28 +0200
In-Reply-To: <0570f53afbc37038742d519d77d40a669d185f1d.camel@siemens.com>
References: 
	<20250820-wip-flo-fix-edge-irq-handling-v1-1-1a2c7805b372@siemens.com>
				<2cb5e8c46cc8d841cf5f452a753d37e7079f3036.camel@siemens.com>
				<87h5xjlf56.fsf@xenomai.org>
				<e7d5cddf94d3d1479e987950a07ee7483820ff1a.camel@siemens.com>
			 <87wm6fjy9r.fsf@xenomai.org>
		 <965f33cf15a8834446e448a278f30c9684df7e89.camel@siemens.com>
	 <0570f53afbc37038742d519d77d40a669d185f1d.camel@siemens.com>
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

On Thu, 2025-09-04 at 14:10 +0200, Florian Bezdeka wrote:
> On Thu, 2025-09-04 at 09:45 +0200, Florian Bezdeka wrote:
> > On Wed, 2025-09-03 at 18:28 +0200, Philippe Gerum wrote:
> > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> > >=20
> > > > On Wed, 2025-09-03 at 17:39 +0200, Philippe Gerum wrote:
> > > > > Hard irqs have always been off while running the IRQ flow handler=
s
> > > > > grabbing the IRQ descriptor lock, this is a fundamental requireme=
nt, no
> > > > > change there. handle_irq_event() drops the lock before calling th=
e
> > > > > (user) IRQ handler, then reacquires it before returning to the fl=
ow
> > > > > handler.
> > > >=20
> > > > Thanks. So
> > > >=20
> > > > 	hard_local_irq_enable();
> > > > 	do_inband_irq(desc);
> > > > 	hard_local_irq_disable();
> > > >=20
> > > > in sync_current_irq_stage() allows pipeline entries for other IRQ l=
ines
> > > > but the desc->lock prevents this for the same line. Correct?
> > > >=20
> > >=20
> > > What prevents subsequent triggers of that IRQ from happening while it
> > > flows down the pipeline really depends on its flow handling and the
> > > requirement for delivery to in-band.
> > >=20
> > > - a level-triggered interrupt stays masked until the in-band stage
> > > handles it.
> > >=20
> > > - mere oob-handled interrupts are unmasked as soon as the oob
> > > handler returns.
> > >=20
> > > - non-masked (device) interrupts are serialized by the desc->lock acr=
oss
> > > multiple CPUs that could receive them.
> > >=20
> > > - the in-band stage is stalled (pipeline-wise) while synchronizing th=
e
> > > interrupt log, so we cannot pile up handlers, although we might recei=
ve
> > > and mark a subsequent occurrence of some IRQ which is being propagate=
d
> > > through the pipeline. That is the reason why sync_current_irq_stage()=
 is
> > > a loop: we might have received more (in-band) interrupts while we wer=
e
> > > busy handling the current one.
> > >=20
> > > - lastly, oob handlers cannot be preempted by the same IRQ since they
> > >   always run with hard IRQs off.
> > >=20
> >=20
> > Just found
> > https://lore.kernel.org/all/20250701163558.2588435-1-liangyan.peng@byte=
dance.com/
> >=20
> > which was basically trying to fix the same issue for Linux. Seems I
> > have to understand that first. Thomas added some detailed explanation.
> > Let's see if that helps.
> >=20
>=20
> Ok, now things get clearer.
>=20
> The main difference between Dovetail and Linux is in
> handle_irq_event():
>=20
> 	raw_spin_unlock(&desc->lock);
> 	ret =3D handle_irq_event_percpu(desc);
> 	raw_spin_lock(&desc->lock);
>=20
> The raw_spin_unlock() is redirected to hybrid_spin_unlock() on
> Dovetail, which enables hard irqs.
>=20
> That allows a pipeline entry for the very same IRQ line, which can not
> happen on Linux. I end up with the same live lock explained above -
> just on a single CPU (no second CPUs involved, no IRQ migration in
> flight).
>=20
> I verified this with the following temporary hack. The affected system
> is now booting up.
>=20
> diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
> index a6c90482d568..7bad55bbed2f 100644
> --- a/kernel/irq/handle.c
> +++ b/kernel/irq/handle.c
> @@ -212,11 +212,11 @@ irqreturn_t handle_irq_event(struct irq_desc
> *desc)
> =20
>         desc->istate &=3D ~IRQS_PENDING;
>         irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
> -       raw_spin_unlock(&desc->lock);
> +       raw_spin_unlock(&desc->lock.rlock);
> =20
>         ret =3D handle_irq_event_percpu(desc);
> =20
> -       raw_spin_lock(&desc->lock);
> +       raw_spin_lock(&desc->lock.rlock);
>         irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
>         return ret;
>  }
>=20
>=20
> Seems the root cause is understood now. Open: How to fix that
> properly...
>=20
> In handle_edge_irq() we have:
>=20
> 	if (may_start_flow(flow) && !irq_can_handle(desc)) {
> 		desc->istate |=3D IRQS_PENDING;
> 		mask_ack_irq(desc);
> 		return;
> 	}
>=20
> Removing this entire block seems to work as well, at the cost that the
> high-frequency-irq is not masked at all and as a follow up enters the
> IRQ log (where it will be replayed right after the currently running
> sync for the same IRQ line is done).
>=20
> But: The (probably) "high-frequency" irq is not masked, so it might be
> logged multiple times while syncing the same IRQ line. Assuming this is
> not ideal performance wise...
>=20
> Further ideas/advice?

@@ -669,6 +673,8 @@ static bool irq_can_handle_pm(struct irq_desc
*desc)
                WARN_ON_ONCE(irq_pipeline_debug() && !in_pipeline());
                if (irqd_is_wakeup_armed(&desc->irq_data))
                        return true;
+               if (irqd_irq_inprogress(&desc->irq_data))
+                       return true;
        } else if (irq_pm_check_wakeup(desc))
                return false;

That is the least invasive fix that I found so far. Qualifies as v2 in
my eyes.

>=20
> > > --=20
> > > Philippe.
