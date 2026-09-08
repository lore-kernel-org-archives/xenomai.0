Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3514D41A545
	for <xenomai@lists.linux.dev>; Tue,  8 Sep 2026 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857225; cv=none; b=gVpQmdT+W+cvwsNbyl5ic8Pw2CR8g7qj5QvDHt5DDN+vt7pu+aGeRBpwfV5ipo9Z7uzPpNCx+QtLeS2m+m6BsplwzlsxeiRqComFJuohpMJI1c3h5hEsGxhQ6Qlg24f7H0u/mJoJLegpybe61hNwJfa/wrE4WZZbIHBLGvhiD2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857225; c=relaxed/simple;
	bh=T06w7o+BgiwneLM8KCRek3aMpXqycX0ggzD9CzJme2o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NMgM0NcQq6SQoJC260j1iSwssrSUjD/Xd9dlWieC9sJJ6HLOSS9XoC4dhzGZHM1VJE4TU6uBU3sUyMyp/sG6fx5GSz+fn9r02FR5eX1mv58SO4ihydMfvxriS6SH7tjAxIKniNQA7Fdli9Ofu5xvgvRMAUcw9hWHgJQaNcnJAYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=CHvxlEMo; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="CHvxlEMo"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260908084653101af61fbc000207f1
        for <xenomai@lists.linux.dev>;
        Tue, 08 Sep 2026 10:46:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Z7N33oablt4ZC8ZkYqi98tYy2yoH1b+3SpkFS1FF2Cc=;
 b=CHvxlEMor5DVNj2fPZJQH2RePD6e/m6ZUvNnW6JOgX5LjQSSUHx2n60p4xKPWMO61yYv9d
 eSrxlPpzFDIob1rAPPIyCKiE8W0jhqINzfZvRs7nQYyRy4WhwYTAEsUYVq79T995+xVXAbVL
 fwyxIiwuoxO3jIYrFoBQCA5m+ntpgmNsp92pRw0fXLjSxlJCIHVzHjQ6VwqF2SBEBPF11oSJ
 aJjdLU2Ybb51+mLVL3QYQFX5N88OuuPE7ZF16T7H2cR6Pvtt1l6lGts7ZjooDsT8b5qwL81u
 90q7nX4wWExHvXPDBMub4ceGgqRVqjlJ0tw8vnzUurkkrFUmIZWc528Q==;
Message-ID: <f78cec8dff20c4c799ede0e8e749e97ccf96ac27.camel@siemens.com>
Subject: Re: perf getting all-zeroes IP on STM32MP1
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Andrew MacPherson <andrew@elk.audio>, xenomai@lists.linux.dev, Gerte
 Hoogewerf <ghoogewerf@lmi3d.com>
Date: Tue, 08 Sep 2026 10:46:52 +0200
In-Reply-To: <87pkyoduoj.fsf@xenomai.org>
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

On Tue, 2026-09-08 at 10:16 +0200, Philippe Gerum wrote:
>=20
> >=20
> > We could ask the clock_event_device (real device) for it's IRQ and mark
> > it  as __IRQF_TIMER during proxy registration.
> >=20
> > The following seems to work, but might need some more work.
> >=20
> > The on_each_cpu() part is likely a overkill due to percpu IRQs, but the
> > real_dev part of mark_timer_tick_irq() is local CPU specific as well.
> >=20
> > diff --git a/kernel/time/tick-proxy.c b/kernel/time/tick-proxy.c
> > index 6ef04fcf5dacd..55526cd99e849 100644
> > --- a/kernel/time/tick-proxy.c
> > +++ b/kernel/time/tick-proxy.c
> > @@ -296,6 +296,22 @@ static int enable_oob_timer(void *arg) /* hard_irq=
s_disabled() */
> >  	return 0;
> >  }
> > =20
> > +static void mark_timer_tick_irq(void *arg)
> > +{
> > +	struct clock_event_device *real_dev;
> > +	struct irq_desc *desc;
> > +	int irq;
> > +
> > +	real_dev =3D raw_cpu_ptr(&tick_cpu_device)->evtdev;
> > +	irq =3D real_dev->irq;
> > +	desc =3D irq_to_desc(irq);
> > +
> > +	if (!desc || !desc->action)
> > +		return;
> > +
> > +	desc->action->flags |=3D __IRQF_TIMER;
> > +}
> > +
> >  struct proxy_install_arg {
> >  	void (*setup_proxy)(struct clock_proxy_device *dev);
> >  	int result;
> > @@ -400,6 +416,8 @@ int tick_install_proxy(void (*setup_proxy)(struct c=
lock_proxy_device *dev),
> >  		return arg.result;
> >  	}
> > =20
> > +	on_each_cpu(mark_timer_tick_irq, NULL, true);
> > +
> >  	/*
> >  	 * Start ticking from the out-of-band interrupt stage upon
> >  	 * receipt of out-of-band timer events.
>=20
> Almost there, but we still need to provide the registers used in
> profiling when no proxy is registered, in which case we cannot depend on
> proxy registration for this, but on clock event device registration
> instead.

diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
index 85ec0cbf5fb1e..c4eda1243b915 100644
--- a/kernel/irq/pipeline.c
+++ b/kernel/irq/pipeline.c
@@ -1064,7 +1064,7 @@ void copy_timer_regs(struct irq_desc *desc, struct pt=
_regs *regs)
 {
 	struct irq_pipeline_data *p;
=20
-	if (desc->action =3D=3D NULL || !(desc->action->flags & __IRQF_TIMER))
+	if (desc->action =3D=3D NULL || !(desc->action->flags & IRQF_DEFERRED_TIM=
ER))
 		return;
 	/*
 	 * Given our deferred dispatching model for regular IRQs, we
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 90fae659e4ea6..9296164c1d198 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -326,6 +326,16 @@ bool tick_check_replacement(struct clock_event_device =
*curdev,
 	return tick_check_preferred(curdev, newdev);
 }
=20
+static void tick_mark_deferred_timer_irq(struct clock_event_device *dev)
+{
+	struct irq_desc *desc =3D irq_to_desc(dev->irq);
+
+	if (!desc || !desc->action)
+		return;
+
+	desc->action->flags |=3D IRQF_DEFERRED_TIMER;
+}
+
 /*
  * Check, if the new registered device should be used. Called with
  * clockevents_lock held and interrupts disabled.
@@ -367,6 +377,8 @@ void tick_check_new_device(struct clock_event_device *n=
ewdev)
 	tick_setup_device(td, newdev, cpu, cpumask_of(cpu));
 	if (newdev->features & CLOCK_EVT_FEAT_ONESHOT)
 		tick_oneshot_notify();
+	if (newdev->features & CLOCK_EVT_FEAT_PIPELINE)
+		tick_mark_deferred_timer_irq(newdev);
 	return;
=20
 out_bc:
