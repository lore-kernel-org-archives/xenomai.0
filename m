Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EF33B38AF
	for <xenomai@lists.linux.dev>; Wed,  9 Sep 2026 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943812; cv=none; b=gWFqajazFqw0NCXkVh8n6sFpNOUGhti0Gero7zAtjeKQ32QTcBB46GnzafLup8gTnWrVDBKTqGhKEoew4CYoQtnGYtqDrftSbZFX086vwOckJlYTnorhQatYaAy11PXGbFek9bzYkJAY8pguykFqBHI4FMqw0FWi1FdgPGuAJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943812; c=relaxed/simple;
	bh=lxpBBInzGC5FBgt4FhEP0iwRmZwoKWkxlSLN2ASFOVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jT61QQg6+hU+vPED0C7O1As8uqGxOzDzyPh4f8awTjwXz6qqacGupCMKy5jneBVZgGwFUGihdV3H+ibHEoneHHwzIZHWzo6tz/XUfIc+BEBfUxh9+TUqNmCEYdKaEIIx2DvXNTpZXh7uvU1BSD6v8tBxGowU1mPRco+pIZmARJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=TgQmpoy/; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="TgQmpoy/"
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF7853E97D;
	Wed,  9 Sep 2026 08:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1788943797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mhv0ANCSBjdUc580KY1cH7ilM/6x+BKMr4QyMBTgHw=;
	b=TgQmpoy/J/BnwgqyvfXIo5p0CXmnx/oDZ1/G0iJgESUqk6LODKz60LtOGFdfpBBD7q2kXf
	oV0HW11RbdhVLzA6hnrbvUCldOCZg2Ws86So7CD2DDRdpHP2xGT3n+3jamNE2ypbsJnIge
	4za9LMJTNvRXgOgNEFxyvb3+7quqCaiyViihcny5cVTtcwPPa5BpBZ6LVzumYpMBhbc3fm
	hl/RSxFlumziN4t1DIpmw3o/fE0M0h8xlEdfOP57dYaFgij964jJ6xxHODRcg27dkiDQny
	56Z4neJv6LB0vdy/zPrZ/aTyyElAV5cKfKFn7H0Nm2aHQX4zYvFmUaSmTwdEyg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Andrew MacPherson <andrew@elk.audio>,  xenomai@lists.linux.dev,  Gerte
 Hoogewerf <ghoogewerf@lmi3d.com>
Subject: Re: perf getting all-zeroes IP on STM32MP1
In-Reply-To: <52ff6db30e81ab4e9e6e8345d4305a99baead752.camel@siemens.com>
	(Florian Bezdeka's message of "Wed, 09 Sep 2026 10:29:13 +0200")
References: <CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com>
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
	<52ff6db30e81ab4e9e6e8345d4305a99baead752.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 09 Sep 2026 10:49:56 +0200
Message-ID: <87h5jy24i3.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTECDMOnZJYf+OqsLGnuGuPx0M1G8ES7DtRHSrgA6PTCTaMvjU0BuhQV23Gm75yDXYc3/cKKlhhvF5k+Pkl+k8xES+qyFtm+MkuSO8mnkCpVhysAlyvaqYCZ8cq4ffttpTdUCXXAYd5v0ppqmrfsjvezZ64JGYSYjLC9jaKHy+Am5FRYvhtodGOPDdysBBJxp6OhBMvJ5gQTBwQ9AHN3DNdQYr3FfixceNSMcFpluP4Oxxj8W1Il4PRJGR8b5AVVtjsnIrbxqDE89zzQdmtkj3MEEQY0WdCayCSfnz+1b7Fh8UPXT0Y/OPVtkNvxwHYkau83kXuiPTZnFg4Nr4sRE5/6MNCefLb0tc5wRvdUt5iwAKBfyghBggdVl6aNkZosGCLrG73CI2qp1NpG4WNl6GZF20oEhQQPDG0PWugpQHhaMiaCzXYiga+wI0XI1yiLKvX6Z7YFEPH8thsWmv7XnMR87EwHG1Zx0CWmb+tRofGdvcEC+NR1hgvkpQW344L/13tDzW8r/IzD9gjHNugUlT5TYtJpJSaYYd5JYKRd+gP95n5yHob92Wf4mGhBtv7F/J2eo3kBvA15sNtABNC+y9FGTjcOKXstuOIXmz3ph+yiVVx/skqa6WCSDXPbeuzI6m4HOliUEWQ/cBpQq/syvPZnIh8hITuWzuqf/N1NROY47A
X-GND-State: clean

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Wed, 2026-09-09 at 10:21 +0200, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>=20
>> > On Tue, 2026-09-08 at 10:16 +0200, Philippe Gerum wrote:
>> > >=20
>> > > >=20
>> > > > We could ask the clock_event_device (real device) for it's IRQ and=
 mark
>> > > > it=C2=A0 as __IRQF_TIMER during proxy registration.
>> > > >=20
>> > > > The following seems to work, but might need some more work.
>> > > >=20
>> > > > The on_each_cpu() part is likely a overkill due to percpu IRQs, bu=
t the
>> > > > real_dev part of mark_timer_tick_irq() is local CPU specific as we=
ll.
>> > > >=20
>> > > > diff --git a/kernel/time/tick-proxy.c b/kernel/time/tick-proxy.c
>> > > > index 6ef04fcf5dacd..55526cd99e849 100644
>> > > > --- a/kernel/time/tick-proxy.c
>> > > > +++ b/kernel/time/tick-proxy.c
>> > > > @@ -296,6 +296,22 @@ static int enable_oob_timer(void *arg) /* har=
d_irqs_disabled() */
>> > > > =C2=A0=C2=A0	return 0;
>> > > > =C2=A0 }
>> > > > =C2=A0=20
>> > > > +static void mark_timer_tick_irq(void *arg)
>> > > > +{
>> > > > +	struct clock_event_device *real_dev;
>> > > > +	struct irq_desc *desc;
>> > > > +	int irq;
>> > > > +
>> > > > +	real_dev =3D raw_cpu_ptr(&tick_cpu_device)->evtdev;
>> > > > +	irq =3D real_dev->irq;
>> > > > +	desc =3D irq_to_desc(irq);
>> > > > +
>> > > > +	if (!desc || !desc->action)
>> > > > +		return;
>> > > > +
>> > > > +	desc->action->flags |=3D __IRQF_TIMER;
>> > > > +}
>> > > > +
>> > > > =C2=A0 struct proxy_install_arg {
>> > > > =C2=A0=C2=A0	void (*setup_proxy)(struct clock_proxy_device *dev);
>> > > > =C2=A0=C2=A0	int result;
>> > > > @@ -400,6 +416,8 @@ int tick_install_proxy(void (*setup_proxy)(str=
uct clock_proxy_device *dev),
>> > > > =C2=A0=C2=A0		return arg.result;
>> > > > =C2=A0=C2=A0	}
>> > > > =C2=A0=20
>> > > > +	on_each_cpu(mark_timer_tick_irq, NULL, true);
>> > > > +
>> > > > =C2=A0=C2=A0	/*
>> > > > =C2=A0=C2=A0	 * Start ticking from the out-of-band interrupt stage=
 upon
>> > > > =C2=A0=C2=A0	 * receipt of out-of-band timer events.
>> > >=20
>> > > Almost there, but we still need to provide the registers used in
>> > > profiling when no proxy is registered, in which case we cannot depen=
d on
>> > > proxy registration for this, but on clock event device registration
>> > > instead.
>> >=20
>> > diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
>> > index 85ec0cbf5fb1e..c4eda1243b915 100644
>> > --- a/kernel/irq/pipeline.c
>> > +++ b/kernel/irq/pipeline.c
>> > @@ -1064,7 +1064,7 @@ void copy_timer_regs(struct irq_desc *desc, stru=
ct pt_regs *regs)
>> > =C2=A0 {
>> > =C2=A0=C2=A0	struct irq_pipeline_data *p;
>> > =C2=A0=20
>> > -	if (desc->action =3D=3D NULL || !(desc->action->flags & __IRQF_TIMER=
))
>> > +	if (desc->action =3D=3D NULL || !(desc->action->flags & IRQF_DEFERRE=
D_TIMER))
>> > =C2=A0=C2=A0		return;
>> > =C2=A0=C2=A0	/*
>> > =C2=A0=C2=A0	 * Given our deferred dispatching model for regular IRQs,=
 we
>> > diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
>> > index 90fae659e4ea6..9296164c1d198 100644
>> > --- a/kernel/time/tick-common.c
>> > +++ b/kernel/time/tick-common.c
>> > @@ -326,6 +326,16 @@ bool tick_check_replacement(struct clock_event_de=
vice *curdev,
>> > =C2=A0=C2=A0	return tick_check_preferred(curdev, newdev);
>> > =C2=A0 }
>> > =C2=A0=20
>> > +static void tick_mark_deferred_timer_irq(struct clock_event_device *d=
ev)
>> > +{
>> > +	struct irq_desc *desc =3D irq_to_desc(dev->irq);
>> > +
>> > +	if (!desc || !desc->action)
>> > +		return;
>> > +
>> > +	desc->action->flags |=3D IRQF_DEFERRED_TIMER;
>> > +}
>> > +
>> > =C2=A0 /*
>> > =C2=A0=C2=A0 * Check, if the new registered device should be used. Cal=
led with
>> > =C2=A0=C2=A0 * clockevents_lock held and interrupts disabled.
>> > @@ -367,6 +377,8 @@ void tick_check_new_device(struct clock_event_devi=
ce *newdev)
>> > =C2=A0=C2=A0	tick_setup_device(td, newdev, cpu, cpumask_of(cpu));
>> > =C2=A0=C2=A0	if (newdev->features & CLOCK_EVT_FEAT_ONESHOT)
>> > =C2=A0=C2=A0		tick_oneshot_notify();
>> > +	if (newdev->features & CLOCK_EVT_FEAT_PIPELINE)
>> > +		tick_mark_deferred_timer_irq(newdev);
>> > =C2=A0=C2=A0	return;
>> > =C2=A0=20
>> > =C2=A0 out_bc:
>>=20
>> I would attach this flag to the interrupt descriptor instead because
>> this is actually a property of the interrupt line, not of its
>> handler(s). Also, we need to consider device shutdown: as the current
>> tick source may be replaced dynamically, turning off this bit for proper
>> accounting when a clock device goes down would be safer.
>>=20
>> e.g.:
>>=20
>> diff --git a/include/linux/irq.h b/include/linux/irq.h
>> index b13e4e90ab18f..5f7a2c78b3ca7 100644
>> --- a/include/linux/irq.h
>> +++ b/include/linux/irq.h
>> @@ -81,6 +81,7 @@ enum irqchip_irq_state;
>> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 when pipelining is enabled=
 (CONFIG_IRQ_PIPELINE),
>> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regardless of the (virtual=
ized) interrupt state
>> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maintained by local_irq_sa=
ve/disable().
>> + * IRQ_TICK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Interrupt is=
 a timer tick source.
>> =C2=A0 */
>> =C2=A0enum {
>> =C2=A0	IRQ_TYPE_NONE		=3D 0x00000000,
>> @@ -109,14 +110,15 @@ enum {
>> =C2=A0	IRQ_HIDDEN		=3D (1 << 20),
>> =C2=A0	IRQ_NO_DEBUG		=3D (1 << 21),
>> =C2=A0	IRQ_OOB			=3D (1 << 22),
>> -	IRQ_RESERVED		=3D (1 << 23),
>> +	IRQ_TICK		=3D (1 << 23),
>> +	IRQ_RESERVED		=3D (1 << 24),
>> =C2=A0};
>> =C2=A0
>> =C2=A0#define IRQF_MODIFY_MASK	\
>> =C2=A0	(IRQ_TYPE_SENSE_MASK | IRQ_NOPROBE | IRQ_NOREQUEST | \
>> =C2=A0	 IRQ_NOAUTOEN | IRQ_LEVEL | IRQ_NO_BALANCING | \
>> =C2=A0	 IRQ_PER_CPU | IRQ_NESTED_THREAD | IRQ_NOTHREAD | IRQ_PER_CPU_DEV=
ID | \
>> -	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN | IRQ_OOB)
>> +	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN | IRQ_OOB | IRQ_TICK)
>> =C2=A0
>> =C2=A0#define IRQ_NO_BALANCING_MASK	(IRQ_PER_CPU | IRQ_NO_BALANCING)
>> =C2=A0
>> @@ -1258,6 +1260,7 @@ static inline struct irq_chip_type *irq_data_get_c=
hip_type(struct irq_data *d)
>> =C2=A0
>> =C2=A0#ifdef CONFIG_IRQ_PIPELINE
>> =C2=A0int irq_switch_oob(unsigned int irq, bool on);
>> +void irq_switch_tick(unsigned int irq, bool on);
>> =C2=A0void irq_clear_deferral(struct irq_desc *desc);
>> =C2=A0void irq_clear_forward(struct irq_desc *desc);
>> =C2=A0#else
>> @@ -1266,6 +1269,10 @@ static inline int irq_switch_oob(unsigned int irq=
, bool on)
>> =C2=A0	return 0;
>> =C2=A0}
>> =C2=A0
>> +static inline void irq_switch_tick(unsigned int irq, bool on)
>> +{
>> +}
>> +
>> =C2=A0static inline void irq_clear_deferral(struct irq_desc *desc) { }
>> =C2=A0static inline void irq_clear_forward(struct irq_desc *desc) { }
>> =C2=A0#endif	/* !CONFIG_IRQ_PIPELINE */
>> diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
>> index 260ffd288bd81..c4e2d6a5d20d5 100644
>> --- a/include/linux/irqdesc.h
>> +++ b/include/linux/irqdesc.h
>> @@ -274,6 +274,11 @@ static inline int irq_is_oob(unsigned int irq)
>> =C2=A0	return irq_check_status_bit(irq, IRQ_OOB);
>> =C2=A0}
>> =C2=A0
>> +static inline int irq_is_tick(unsigned int irq)
>> +{
>> +	return irq_check_status_bit(irq, IRQ_TICK);
>> +}
>> +
>
> I have a patch pending that would remove irq_is_oob(), as there is no
> user. The same for irq_is_tick(), no? Is that used somewhere?
>

No, I added it only for symmetry with _oob, but actually those flags are
tested using the descriptor-based helper instead. So, we could drop the
irq_is_{oob, tick}() helpers indeed.

>
> The rest makes sense, I will give it a try.

--=20
Philippe.
