Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6A13A5E6C
	for <xenomai@lists.linux.dev>; Tue,  8 Sep 2026 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854539; cv=none; b=npTufBguNz3EBpSZLyS2hRQUrRUqmmQragyd/hYJtk58x5qEAZSOu3GD5INvQ/9T0tsedMGt18mcL4xWAKrHQ+hI2+4atpk5ioDtErzKCnCB7mcPrFdl8LV+JZjvgjO4lYMJQhVe5tKZu8uIT02Ve4iC8TvE9BB0s1F16EZa0h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854539; c=relaxed/simple;
	bh=1TjFN5XcR9vFXwFVQjUKWEFePL7BuHa2UZ7IOZunk/c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TzrNP9UppxJVvk23sDjIb00YPRaIDx8IJtILq1OsxvpET1GpLSc3PD3MAYlPrrnW5zN7V6JF1xOo8vZ3zTzVQ13VRwyN9gXRl6L1yWx+4yGp1c4npF/FU8lpWMn+/t5XqtVY7ZEVx2MqGsym4PCYcizlIDA3zqyR6EP/Sx4aCD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=dC2KEW+f; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="dC2KEW+f"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202609080802039b3e1e43c8000207c1
        for <xenomai@lists.linux.dev>;
        Tue, 08 Sep 2026 10:02:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=JFxHXjQwghVDO98/4U4dkLvFw/ICLfu6eQPppDgksMA=;
 b=dC2KEW+fwEQ3holn7zXMwHSVJqztcjFjefTcJBms9sFtWdGGz/2hV0Km//mRV7q6I2lhQq
 SK3HOhl1nH3oTMvJuCMtUgEtjRxWFVBwyHjqNvmflF/NkSghy9CIJjbW3Ri+5c3LewNRK5ln
 5RCw9ndTK13lLcVLZjVd+p0r/h7z2jL9Hy4HrO8zLQ6j6kLCKgd4iCNKOhGUrD3MAtamU8+P
 XujV95X8c2m+XnPHEJ3ogg/6VXxzIz88Dj5FXJxZVpxckyU2PMnfu0NsdEzsF6VKlMoLMMrQ
 kAQ2bbHzbeJ+mp0sbu9EaWY077Pq4woIdw+y0AQcEPvmdNn+A0eJ1xXA==;
Message-ID: <396c6e2bee432007d4878f092ed353f3034a2287.camel@siemens.com>
Subject: Re: perf getting all-zeroes IP on STM32MP1
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Andrew MacPherson <andrew@elk.audio>, xenomai@lists.linux.dev, Gerte
 Hoogewerf <ghoogewerf@lmi3d.com>
Date: Tue, 08 Sep 2026 10:02:02 +0200
In-Reply-To: <877bkxgl7k.fsf@xenomai.org>
References: 
	<CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com>
		<9e0b7d3e72a19bd900a14faa6c459f5a2e093982.camel@siemens.com>
		<CACiVkwkc6nzD1qv7yzUR=a3GMPO+b9kp53sBVVKQpiW0NJX65w@mail.gmail.com>
		<dc1c6765187854e0758378af34098a64a8f7bf3b.camel@siemens.com>
		<87cxupgrnp.fsf@xenomai.org>
		<a14e0d0f9ec97f6064a1b2fb221f3ee5015e2241.camel@siemens.com>
	 <877bkxgl7k.fsf@xenomai.org>
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

On Mon, 2026-09-07 at 17:00 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Mon, 2026-09-07 at 14:41 +0200, Philippe Gerum wrote:
> > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> > >=20
> > > > On Mon, 2026-09-07 at 10:57 +0200, Andrew MacPherson wrote:
> > > > > On Fri, 4 Sept 2026 at 16:08, Florian Bezdeka
> > > > > <florian.bezdeka@siemens.com> wrote:
> > > > > >=20
> > > > > > Hi Andrew,
> > > > > >=20
> > > > > > [CC + Philippe]
> > > > > >=20
> > > > > > On Fri, 2026-09-04 at 15:26 +0200, Andrew MacPherson wrote:
> > > > > > > Hello,
> > > > > > >=20
> > > > > > > We're working on an STM32MP1-based system running Xenomai and=
 found
> > > > > > > that perf top shows every symbol as "unknown [00000000]", i.e=
.
> > > > > > > profiling is collecting samples, but they all point at addres=
s zero.
> > > > > > >=20
> > > > > > > I'm not a kernel developer but went through a few debug kerne=
l builds
> > > > > > > with an agent which eventually led to the attached patch. Thi=
s change
> > > > > > > does resolve the issue with perf, however I'm not sure if it'=
s the
> > > > > > > correct solution.
> > > > > > >=20
> > > > > > > The reasoning is that arm_arch_timer.c's percpu IRQ registrat=
ion never
> > > > > > > sets IRQF_TIMER, so Dovetail's copy_timer_regs() never popula=
tes
> > > > > > > tick_regs, leaving get_irq_regs() to always return an all-zer=
o
> > > > > > > pt_regs, which in turn breaks perf's sample IP.
> > > > > >=20
> > > > > > Yep, that is wrong. The patch you provided looks OK to me. I'm =
just
> > > > > > wondering if that should be addressed in Linux as well / first.
> > > > > >=20
> > > > > > @Philippe: Any additional thoughts? Should we take it already?
> > > > > >=20
> > > > > >=20
> > > > > > @Andrew: Could you please provide a formal patch with proper si=
gned-off
> > > > > > and LLM notice (assuming agent means AI ;-)) targeting the dove=
tail 7.2.
> > > > > > branch? That should help to speed things up. Thanks!
> > > > > >=20
> > > > > > Florian
> > > > > >=20
> > > > > > --
> > > > > > Siemens AG, Foundational Technologies
> > > > > > Linux Expert Center
> > > > > >=20
> > > > > >=20
> > > > >=20
> > > > > Hi Florian,
> > > > >=20
> > > > > I've submitted a patch now against dovetail 7.2, let me know if y=
ou
> > > > > need anything else and thanks for the help!
> > > > >=20
> > > > >=20
> > > >=20
> > > > Thanks! We might consider merging that while working on a better
> > > > solution - as suggested by Philippe.
> > > >=20
> > >=20
> > > Unfortunately, thinking a bit more/better, we'd still have an issue w=
ith
> > > what I suggested. i.e. There are three contexts we need to care about=
 in
> > > this case:
> > >=20
> > > 1. when a timer tick can be immediately delivered to its handler
> > >    (i.e. hw irqs on) from a line tagged with IRQF_OOB.
> > >=20
> > > 2. when a timer tick can be immediately delivered (i.e. in-band stage=
 is
> > >    installed) from a line set for in-band delivery (i.e. not tagged w=
ith
> > >    IRQF_OOB). In this case, the interrupt log is synchronized before
> > >    leaving handle_irq_pipelined_finish().
> > >=20
> > > 3. when a timer tick /should/ but cannot be delivered to the in-band =
stage
> > >    because the latter is stalled, i.e. need for deferral via the
> > >    interrupt log.
> > >=20
> > > In the first two cases, postponing the copy logic to
> > > clockevents_handle_event() would be ok, because the interrupt frame o=
f
> > > the timer event would still be active, therefore using get_irq_regs()=
 to
> > > find the regs to copy would be correct.
> >=20
> > Agree.
> >=20
> > >=20
> > > In case #3, we have a deferral, therefore the interrupt frame is
> > > certainly gone when the in-band stage is unstalled. Since other
> > > interrupts could happen in between, we are toast.
> > >=20
> >=20
> > Hm, when setting up the proxy device, we mark the affected IRQs as OOB
> > IRQs. Doesn't that mean that we end up in clockevents_handle_event() fo=
r
> > those IRQs as well? That seems to be the case, if my debugging here is
> > right.
> >=20
> > We want to copy the registers of the last OOB timer tick, no? That look=
s
> > doable, but I might miss something or just did not run into the "inband
> > stalled" case.
>=20
> We want to copy those registers every time the profiling code may
> consume them, including when the tick is delivered to the in-band stage
> only. The proxy tick infrastructure allows for enabling only a subset of
> the CPU range for oob traffic, other CPUs would keep on receiving timer
> events from the in-band stage.
>=20
> In order to extend the test case, I would tweak oob_cpus and look at the
> perf results for a task affine to a non-oob processor.

We could ask the clock_event_device (real device) for it's IRQ and mark
it  as __IRQF_TIMER during proxy registration.

The following seems to work, but might need some more work.

The on_each_cpu() part is likely a overkill due to percpu IRQs, but the
real_dev part of mark_timer_tick_irq() is local CPU specific as well.

diff --git a/kernel/time/tick-proxy.c b/kernel/time/tick-proxy.c
index 6ef04fcf5dacd..55526cd99e849 100644
--- a/kernel/time/tick-proxy.c
+++ b/kernel/time/tick-proxy.c
@@ -296,6 +296,22 @@ static int enable_oob_timer(void *arg) /* hard_irqs_di=
sabled() */
 	return 0;
 }
=20
+static void mark_timer_tick_irq(void *arg)
+{
+	struct clock_event_device *real_dev;
+	struct irq_desc *desc;
+	int irq;
+
+	real_dev =3D raw_cpu_ptr(&tick_cpu_device)->evtdev;
+	irq =3D real_dev->irq;
+	desc =3D irq_to_desc(irq);
+
+	if (!desc || !desc->action)
+		return;
+
+	desc->action->flags |=3D __IRQF_TIMER;
+}
+
 struct proxy_install_arg {
 	void (*setup_proxy)(struct clock_proxy_device *dev);
 	int result;
@@ -400,6 +416,8 @@ int tick_install_proxy(void (*setup_proxy)(struct clock=
_proxy_device *dev),
 		return arg.result;
 	}
=20
+	on_each_cpu(mark_timer_tick_irq, NULL, true);
+
 	/*
 	 * Start ticking from the out-of-band interrupt stage upon
 	 * receipt of out-of-band timer events.
