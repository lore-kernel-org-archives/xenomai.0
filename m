Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B352B15EFD7
	for <xenomai@lists.linux.dev>; Fri,  7 Jun 2024 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766159; cv=none; b=ZMWDWxaDVHsGNX2fACVPHRhVPp/ugjkGh6cYtorZWzANcxTZGSmdwuw6JenrimqFMNLfztOUpeI3oF0D2LHFJPdeVg8iNcY5yapUiHdcO/dP8OrFKbZjWkofUFYeRPeLi6+r57jsIw9uHa7EiVBjoXQxboLMQs6lvIsXgclOtyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766159; c=relaxed/simple;
	bh=V83OhjPL0p2D6KdjqPp4/0YCGpguW29pJqUAQlCD0+I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pVBdEDRUj7TCM1IOLDP1GkEvcKH2ckTZ4PPOnWRCiNtMnkkynDr4Qtjxwlm6u3dlpnjTPLo+oCunLYpJJhVLcToEB2VKinb1ewiTeSDuUbE76rKSUxRQS5Sjt2p0aPxXRBywk5j1XORB6z9tb7i0xWBV8d1b5CUeD/FpN6JlCmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=T0KwlgYX; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="T0KwlgYX"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240607131555dc4af6b861e5c20382
        for <xenomai@lists.linux.dev>;
        Fri, 07 Jun 2024 15:15:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xBrIq2rUx1G1P78/H+r8kYZoUjisiuN+CcLP3vMoz4E=;
 b=T0KwlgYXlJssp1RtiQSI/cc0jfPl3ePEaklpm1AJKWnrtbqmxjaJhSzogFsmiVIGhJNPa0
 5wQt0ums7Zi7FlU6J9NzMeYDd/0tt69GLpL9ol52gd/030LLJNvk9d3vkCmAmj9OZPVPpWHw
 Sskd//bjmZLzLSNMYI3mDiOcqxihQ=;
Message-ID: <5a300492f5b7f5611ccebb1cd1ddbd06b0552da4.camel@siemens.com>
Subject: Re: Dovetail/Xenomai 3: Timer tick locking problem
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Date: Fri, 07 Jun 2024 15:15:52 +0200
In-Reply-To: <fcc72d7e-6391-4315-8dbe-5079d22b339e@siemens.com>
References: <1a4aa9f3bfb30fe5b5955fea1486a5fb8b040ff2.camel@siemens.com>
	 <87wmn2eawl.fsf@xenomai.org>
	 <7a14422b15d534a2a66b6128938e24f8ed08fe99.camel@siemens.com>
	 <87o78edytl.fsf@xenomai.org>
	 <de1d8749762542e17035afeb7b1fdb5be61107d5.camel@siemens.com>
	 <fcc72d7e-6391-4315-8dbe-5079d22b339e@siemens.com>
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

On Fri, 2024-06-07 at 11:17 +0200, Jan Kiszka wrote:
> On 07.06.24 09:37, Florian Bezdeka wrote:
> > On Thu, 2024-06-06 at 14:42 +0200, Philippe Gerum wrote:
> > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> > >=20
> > > > On Thu, 2024-06-06 at 10:18 +0200, Philippe Gerum wrote:
> > > > > > When running over an OOB task that is currently owning nklock, =
we will
> > > > > > release the lock unconditionally, leaving the task "unprotected=
" /
> > > > > > unsynchronized. Right?
> > > > >=20
> > > > > No, the only way for a task to hold the ugly lock safely is to di=
sable
> > > > > IRQs if it has to compete with an IRQ handler. So this scenario i=
s by
> > > > > definition a usage bug on the application/driver side, not on the
> > > > > infrastructure's. Meanwhile, the _irqsave() variant prevents spur=
ious
> > > > > lock release in recursion using a special marker in the saved int=
errupt
> > > > > flags.
> > > >=20
> > > > I just checked all nklock usages. Most of them are indeed using the=
 IRQ
> > > > safe variants. But:
> > > >=20
> > > > In xnthread_relax() we have:
> > > >=20
> > > >     splmax();
> > > >     xnlock_get(&nklock);
> > > >     xnthread_suspend(...);
> > > >         xnlock_get_irqsave(&nklock, s);
> > > >         xnlock_put_irqrestore(&nklock, s);
> > > >     splnone();
> > > >=20
> > > > As xnthread_suspend() is using the _irqsave() variants, it's basica=
lly
> > > > a noop, the recursion will be detected / handled correctly.
> > > >=20
> > > > What happens, if right after splnone() the Xenomai timer tick is
> > > > handled?
> > >=20
> > > At this point, the current task is relaxed and does not hold the nklo=
ck
> > > anymore. It's been released by ___xnsched_run() <- xnthread_suspend()=
,
> > > on the exit path.
> > >=20
> >=20
> > Exactly. Thanks Philippe.
> >=20
> > I think I narrowed it down to kvm_wait(). Propably it's not a good idea
> > to enable the hw IRQs unconditionally after coming back from a vCPU
> > kick. Testing ongoing, maybe you can have a look as well.=20
> >=20
>=20
> If we ever enter kvm_wait with hard-IRQs off, they must not be turned on
> before, while or after waiting. Maybe this condition is simply missing
> from the implementation because it assumed to only be enter with
> hard-IRQs on?

Hm... I think HW IRQ enablement is still allowed, or even necessary to
allow the processing of those events. Otherwise non-RT spinlocks would
stall RT tasks. In my opinion the handling of PV spinlocks should be
the same as of "normal" ones, basically running the slow path
(spinning) in HW IRQ enabled state.

I'm currently playing around with=20

+#if CONFIG_IRQ_PIPELINE
+       if (hard_irqs_disabled() && READ_ONCE(*ptr) =3D=3D val) {
+               safe_halt(); // enables HW IRQs
+               hard_local_irq_disable();
+               return;
+       }
+#endif
+

in kvm_wait(). That makes LOCKDEP happy and seems to survive my stress
test (so far).

Btw: I'm not sure if the current kvm_wait() implementation is correct
for the !CONFIG_IRQ_PIPELINE case. Will have to check...

A different approach would be the disablement of PV spinlocks if IRQ
pipelining is active. WDYT?

Florian

>=20
> Jan
>=20

