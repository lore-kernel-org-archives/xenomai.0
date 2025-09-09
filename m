Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB1330AD04
	for <xenomai@lists.linux.dev>; Tue,  9 Sep 2025 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401420; cv=none; b=uAdMvI++I9cve0DWGzdwqncUppdZKvZXlQGQ/RK82r79d94dknQBGyZcKtaOWc7IWSJJfqik77BuFdcT2lHNARV8lRaBDBZ+z3AJaSLnu9IKYhiHfw2+6iYfsPAz/DvTAjFj7iwbT0Q6U8z+14uM88Ar76bpy7pMmSp1Dwa+gqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401420; c=relaxed/simple;
	bh=++S84VsvHnSGKa9sY8wiVxtZG3auZ3dRxINcao7FSgQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FfHKhqX8jmqR4q/Y+nxnZvQ3DTHjNO1TIbL/4FU5BVZA7gKQnxVbEg9afZy1a6o+zLCYv4BwnYEowBUSQfNHOEFxSuXj/jjv77efZ/1tQxWNFVpbEwUSTGzKFa7ZBbpjlt43WxKYcZmIO/yHkA7Eo8DqLnEpt5+kSmeklMMp8V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=oI4oFmFN; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="oI4oFmFN"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20250909070332733e1cc711000207a7
        for <xenomai@lists.linux.dev>;
        Tue, 09 Sep 2025 09:03:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/rFlZGhlf3QSDb63O7hEnABqDUhq4yzfm54tqS81RN4=;
 b=oI4oFmFNVdt+ec8XI9bVMPPz9aXvNmZ5oeSqQvdmVCY0P4kD5W4LbWuE/2DLbUZvkNWQHY
 xWsFVwbD4iRA7xeWFgntROSqZCi1D3Z6nvv2+sfqcFI1Bgm7bVID7I6guktD4zN3019MY0XH
 5BEbU+/qMRpCydCyw3Zz2ErfySchw/eU2tW2Oomqwpq+Gy/jJ7JHhPqiicohraZfVz2vilkC
 P+6jQ6ikQF+onqXz7Hjo3JCSVzof31dA1BsyXufPnmsWBvZlgU/46kJ0dn0oSOexASf1DJiD
 kUV3Yqw2CSoPjr6JbTgAD6HS5qr/pXhI/smT9np/dkiquxVBEG1qSl6Q==;
Message-ID: <e49df1ba70eb3ffdaa84fdb4bb7eac07d4ee870d.camel@siemens.com>
Subject: Re: [PATCH Dovetail v2] irq_pipeline: Fix system freeze triggered
 by periodic edge type IRQs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <philippe.gerum@gmail.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Tue, 09 Sep 2025 09:03:31 +0200
In-Reply-To: <87frcx830y.fsf@xenomai.org>
References: 
	<20250820-wip-flo-fix-edge-irq-handling-v2-1-1a958d17eace@siemens.com>
		<87ikhwk7y8.fsf@xenomai.org>
		<18e3f6b4f6f10574fafa5530be7bbeb1347fcfa1.camel@siemens.com>
		<312c039a18f033ee21137ec9af77b7d5a07ddf6a.camel@siemens.com>
	 <87frcx830y.fsf@xenomai.org>
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

On Mon, 2025-09-08 at 15:52 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> >=20
> > I'm currently testing the following, which is heavily enspired by the
> > upstream Fix for the IRQ migration issue:
> >=20
> > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> > index 45d0ab985068..acb6a580cc7f 100644
> > --- a/kernel/irq/chip.c
> > +++ b/kernel/irq/chip.c
> > @@ -638,6 +638,27 @@ static inline bool should_feed_pipeline(struct irq=
_desc *desc,
> >         }
> >  }
> > =20
> > +static bool irq_active_on_this_cpu(struct irq_desc *desc)
> > +{
> > +       struct irq_data *data =3D &desc->irq_data;
> > +       const struct cpumask *aff;
> > +
> > +       /* Check if active on any CPU */
> > +       if (!irqd_irq_inprogress(data))
> > +               return false;
> > +
> > +       /* The below works only for single target interrupts */
> > +       if (!IS_ENABLED(CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK) ||
>=20
> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK is turned off in uniprocessor
> builds which are still available with v6.16, in this case we can and
> want to rely on the pipeline for serializing the IRQs,
> i.e. irq_active_on_this_cpu() should yield true.

Right. I removed that part from the condition above.
irq_data_get_effective_affinity_mask() below will handle that case
correctly.

That survived the overnight stress test on qemu and hyper-v already. I
will start an additional CI run with our beagle bone black involved
now. That should cover that case again.

>=20
> > +           !irqd_is_single_target(data) || desc->handle_irq !=3D handl=
e_edge_irq)
> > +               return false;
> > +
> > +       aff =3D irq_data_get_effective_affinity_mask(data);
> > +       if (cpumask_first(aff) !=3D smp_processor_id())
> > +               return false;
> > +
> > +       return true;
> > +}
> > +
> >  static bool irq_can_handle_pm(struct irq_desc *desc)
> >  {
> >         unsigned int mask =3D IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED;
> > @@ -668,6 +689,8 @@ static bool irq_can_handle_pm(struct irq_desc *desc=
)
> >                 WARN_ON_ONCE(irq_pipeline_debug() && !in_pipeline());
> >                 if (irqd_is_wakeup_armed(&desc->irq_data))
> >                         return true;
> > +               if (irq_active_on_this_cpu(desc))
> > +                       return true;
>=20
> --=20
> Philippe.
