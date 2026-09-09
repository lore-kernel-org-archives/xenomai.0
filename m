Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6204582F9
	for <xenomai@lists.linux.dev>; Wed,  9 Sep 2026 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788942569; cv=none; b=QOXaEI6A4yr7xpM9Fo9pTWROPlof8TvAHsueXlCwr/nt5tEnvJ42/X9w0hC34GgjO35elnOJ0+RZEjzK099vIktXqLRkJ1LvdqbHRvG0OQ1aU+hG1VVcC9KW9e57Yx8frkAKmyfNl0RgLPiX8euoUmFZ6DfqXXqLU9cyEq2oqnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788942569; c=relaxed/simple;
	bh=EqCT4idx8Ss188H1yBs5aJ3qejAttGBaylt1y22JcXE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BqghL4lpE1DvGYP5INvCiAYl6KfiLRDKBjujaFBM8pycxQzRV25mbXABUEwEice50I/wIqDGnlzh4SRae5V3J6dFv3WlV3lii3VeZbwMdbUi1SNkkzMUyfPIIaSwNl4Q4Xn/WjxhOtJ/NWMg5kF7e0RDSlUpDci91niXclsRI1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=NgCa1Nyd; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="NgCa1Nyd"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202609090829142b74ed6f66000207a9
        for <xenomai@lists.linux.dev>;
        Wed, 09 Sep 2026 10:29:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zNNttuYXwlkJN4R1/ZvjkYpina8CWdXz2jCrvPbdjLc=;
 b=NgCa1Nyd3o3cGACFcXV5HTp9PoOU6qIqwRrBicx96wgkLjP/n0afmPVoUor4l4uiLCSy3R
 KJuMo1Vn1aYE6EfIWFAFuKlng9euSlqOgvVBErGxdbGzn8L9hHQ3BLcyU/rVZN3yTY6tMysW
 pfdzuSRbaAUjFKNqTboFutj8UbNUj56arfWMgpQoPqNRCcgOJV/lEVS0szX2MbSfW8DiOuxN
 2GWp4cpTe0iAZmr0GOO/mdRTRWnkClRwFfCK4Wt3bAWQaNl1cVoEV5pQxtRuIjmRjXzIGuxU
 RQcDuTMOwm5lcvkm4DSl525TQj+ylFaYLTxjK4w48MEA5StmJntP7hMw==;
Message-ID: <52ff6db30e81ab4e9e6e8345d4305a99baead752.camel@siemens.com>
Subject: Re: perf getting all-zeroes IP on STM32MP1
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Andrew MacPherson <andrew@elk.audio>, xenomai@lists.linux.dev, Gerte
 Hoogewerf <ghoogewerf@lmi3d.com>
Date: Wed, 09 Sep 2026 10:29:13 +0200
In-Reply-To: <87mrtq25tf.fsf@xenomai.org>
References: 
	<CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com>
		<9e0b7d3e72a19bd900a14faa6c459f5a2e093982.camel@siemens.com>
		<CACiVkwkc6nzD1qv7yzUR=a3GMPO+b9kp53sBVVKQpiW0NJX65w@mail.gmail.com>
		<dc1c6765187854e0758378af34098a64a8f7bf3b.camel@siemens.com>
		<87cxupgrnp.fsf@xenomai.org>
		<a14e0d0f9ec97f6064a1b2fb221f3ee5015e2241.camel@siemens.com>
		<877bkxgl7k.fsf@xenomai.org>
		<396c6e2bee432007d4878f092ed353f3034a2287.camel@siemens.com>
		<87pkyoduoj.fsf@xenomai.org>
		<f78cec8dff20c4c799ede0e8e749e97ccf96ac27.camel@siemens.com>
	 <87mrtq25tf.fsf@xenomai.org>
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

On Wed, 2026-09-09 at 10:21 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Tue, 2026-09-08 at 10:16 +0200, Philippe Gerum wrote:
> > >=20
> > > >=20
> > > > We could ask the clock_event_device (real device) for it's IRQ and =
mark
> > > > it=C2=A0 as __IRQF_TIMER during proxy registration.
> > > >=20
> > > > The following seems to work, but might need some more work.
> > > >=20
> > > > The on_each_cpu() part is likely a overkill due to percpu IRQs, but=
 the
> > > > real_dev part of mark_timer_tick_irq() is local CPU specific as wel=
l.
> > > >=20
> > > > diff --git a/kernel/time/tick-proxy.c b/kernel/time/tick-proxy.c
> > > > index 6ef04fcf5dacd..55526cd99e849 100644
> > > > --- a/kernel/time/tick-proxy.c
> > > > +++ b/kernel/time/tick-proxy.c
> > > > @@ -296,6 +296,22 @@ static int enable_oob_timer(void *arg) /* hard=
_irqs_disabled() */
> > > > =C2=A0=C2=A0	return 0;
> > > > =C2=A0 }
> > > > =C2=A0=20
> > > > +static void mark_timer_tick_irq(void *arg)
> > > > +{
> > > > +	struct clock_event_device *real_dev;
> > > > +	struct irq_desc *desc;
> > > > +	int irq;
> > > > +
> > > > +	real_dev =3D raw_cpu_ptr(&tick_cpu_device)->evtdev;
> > > > +	irq =3D real_dev->irq;
> > > > +	desc =3D irq_to_desc(irq);
> > > > +
> > > > +	if (!desc || !desc->action)
> > > > +		return;
> > > > +
> > > > +	desc->action->flags |=3D __IRQF_TIMER;
> > > > +}
> > > > +
> > > > =C2=A0 struct proxy_install_arg {
> > > > =C2=A0=C2=A0	void (*setup_proxy)(struct clock_proxy_device *dev);
> > > > =C2=A0=C2=A0	int result;
> > > > @@ -400,6 +416,8 @@ int tick_install_proxy(void (*setup_proxy)(stru=
ct clock_proxy_device *dev),
> > > > =C2=A0=C2=A0		return arg.result;
> > > > =C2=A0=C2=A0	}
> > > > =C2=A0=20
> > > > +	on_each_cpu(mark_timer_tick_irq, NULL, true);
> > > > +
> > > > =C2=A0=C2=A0	/*
> > > > =C2=A0=C2=A0	 * Start ticking from the out-of-band interrupt stage =
upon
> > > > =C2=A0=C2=A0	 * receipt of out-of-band timer events.
> > >=20
> > > Almost there, but we still need to provide the registers used in
> > > profiling when no proxy is registered, in which case we cannot depend=
 on
> > > proxy registration for this, but on clock event device registration
> > > instead.
> >=20
> > diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
> > index 85ec0cbf5fb1e..c4eda1243b915 100644
> > --- a/kernel/irq/pipeline.c
> > +++ b/kernel/irq/pipeline.c
> > @@ -1064,7 +1064,7 @@ void copy_timer_regs(struct irq_desc *desc, struc=
t pt_regs *regs)
> > =C2=A0 {
> > =C2=A0=C2=A0	struct irq_pipeline_data *p;
> > =C2=A0=20
> > -	if (desc->action =3D=3D NULL || !(desc->action->flags & __IRQF_TIMER)=
)
> > +	if (desc->action =3D=3D NULL || !(desc->action->flags & IRQF_DEFERRED=
_TIMER))
> > =C2=A0=C2=A0		return;
> > =C2=A0=C2=A0	/*
> > =C2=A0=C2=A0	 * Given our deferred dispatching model for regular IRQs, =
we
> > diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> > index 90fae659e4ea6..9296164c1d198 100644
> > --- a/kernel/time/tick-common.c
> > +++ b/kernel/time/tick-common.c
> > @@ -326,6 +326,16 @@ bool tick_check_replacement(struct clock_event_dev=
ice *curdev,
> > =C2=A0=C2=A0	return tick_check_preferred(curdev, newdev);
> > =C2=A0 }
> > =C2=A0=20
> > +static void tick_mark_deferred_timer_irq(struct clock_event_device *de=
v)
> > +{
> > +	struct irq_desc *desc =3D irq_to_desc(dev->irq);
> > +
> > +	if (!desc || !desc->action)
> > +		return;
> > +
> > +	desc->action->flags |=3D IRQF_DEFERRED_TIMER;
> > +}
> > +
> > =C2=A0 /*
> > =C2=A0=C2=A0 * Check, if the new registered device should be used. Call=
ed with
> > =C2=A0=C2=A0 * clockevents_lock held and interrupts disabled.
> > @@ -367,6 +377,8 @@ void tick_check_new_device(struct clock_event_devic=
e *newdev)
> > =C2=A0=C2=A0	tick_setup_device(td, newdev, cpu, cpumask_of(cpu));
> > =C2=A0=C2=A0	if (newdev->features & CLOCK_EVT_FEAT_ONESHOT)
> > =C2=A0=C2=A0		tick_oneshot_notify();
> > +	if (newdev->features & CLOCK_EVT_FEAT_PIPELINE)
> > +		tick_mark_deferred_timer_irq(newdev);
> > =C2=A0=C2=A0	return;
> > =C2=A0=20
> > =C2=A0 out_bc:
>=20
> I would attach this flag to the interrupt descriptor instead because
> this is actually a property of the interrupt line, not of its
> handler(s). Also, we need to consider device shutdown: as the current
> tick source may be replaced dynamically, turning off this bit for proper
> accounting when a clock device goes down would be safer.
>=20
> e.g.:
>=20
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index b13e4e90ab18f..5f7a2c78b3ca7 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -81,6 +81,7 @@ enum irqchip_irq_state;
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 when pipelining is enabled=
 (CONFIG_IRQ_PIPELINE),
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regardless of the (virtual=
ized) interrupt state
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maintained by local_irq_sa=
ve/disable().
> + * IRQ_TICK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Interrupt is=
 a timer tick source.
> =C2=A0 */
> =C2=A0enum {
> =C2=A0	IRQ_TYPE_NONE		=3D 0x00000000,
> @@ -109,14 +110,15 @@ enum {
> =C2=A0	IRQ_HIDDEN		=3D (1 << 20),
> =C2=A0	IRQ_NO_DEBUG		=3D (1 << 21),
> =C2=A0	IRQ_OOB			=3D (1 << 22),
> -	IRQ_RESERVED		=3D (1 << 23),
> +	IRQ_TICK		=3D (1 << 23),
> +	IRQ_RESERVED		=3D (1 << 24),
> =C2=A0};
> =C2=A0
> =C2=A0#define IRQF_MODIFY_MASK	\
> =C2=A0	(IRQ_TYPE_SENSE_MASK | IRQ_NOPROBE | IRQ_NOREQUEST | \
> =C2=A0	 IRQ_NOAUTOEN | IRQ_LEVEL | IRQ_NO_BALANCING | \
> =C2=A0	 IRQ_PER_CPU | IRQ_NESTED_THREAD | IRQ_NOTHREAD | IRQ_PER_CPU_DEVI=
D | \
> -	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN | IRQ_OOB)
> +	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN | IRQ_OOB | IRQ_TICK)
> =C2=A0
> =C2=A0#define IRQ_NO_BALANCING_MASK	(IRQ_PER_CPU | IRQ_NO_BALANCING)
> =C2=A0
> @@ -1258,6 +1260,7 @@ static inline struct irq_chip_type *irq_data_get_ch=
ip_type(struct irq_data *d)
> =C2=A0
> =C2=A0#ifdef CONFIG_IRQ_PIPELINE
> =C2=A0int irq_switch_oob(unsigned int irq, bool on);
> +void irq_switch_tick(unsigned int irq, bool on);
> =C2=A0void irq_clear_deferral(struct irq_desc *desc);
> =C2=A0void irq_clear_forward(struct irq_desc *desc);
> =C2=A0#else
> @@ -1266,6 +1269,10 @@ static inline int irq_switch_oob(unsigned int irq,=
 bool on)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static inline void irq_switch_tick(unsigned int irq, bool on)
> +{
> +}
> +
> =C2=A0static inline void irq_clear_deferral(struct irq_desc *desc) { }
> =C2=A0static inline void irq_clear_forward(struct irq_desc *desc) { }
> =C2=A0#endif	/* !CONFIG_IRQ_PIPELINE */
> diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
> index 260ffd288bd81..c4e2d6a5d20d5 100644
> --- a/include/linux/irqdesc.h
> +++ b/include/linux/irqdesc.h
> @@ -274,6 +274,11 @@ static inline int irq_is_oob(unsigned int irq)
> =C2=A0	return irq_check_status_bit(irq, IRQ_OOB);
> =C2=A0}
> =C2=A0
> +static inline int irq_is_tick(unsigned int irq)
> +{
> +	return irq_check_status_bit(irq, IRQ_TICK);
> +}
> +

I have a patch pending that would remove irq_is_oob(), as there is no
user. The same for irq_is_tick(), no? Is that used somewhere?


The rest makes sense, I will give it a try.
