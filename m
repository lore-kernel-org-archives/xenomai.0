Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF3C3939C2
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537337; cv=none; b=pLk7CpSdNTxOYFTcCVHsagzcKBiZDrNiTCjDy62bAEJXgfxXO+0yh/zZW0wNpq9TBXDWRUG9SeK2GwVpeLiOLj4MXnBS87wXlYGhfKj4EvBON2qd60SH9rRFFc5KqpbvlCC/x61imFf/2UULmHhkhHbUL23WmJDgW6igAjVG7vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537337; c=relaxed/simple;
	bh=CV5NsPWAl1XPxFizQN8JjLWXA/ker3ZjhUDbWGvC6Iw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UxJmr2XilgvwdeOtEHpBEeSHJBy0r7RDEpLwi0cBIs27zX2T94p6nCew/7gE3RJpI/Ku2rxytGPj7t2vHc2JPUV3OJ3aejCmaNm5Y6g5jSFIJsMHBWyqOZsYpcRJax8HlaeQYX3IIRy0B1S2L8wraxf6fUgEt76+/FyNBC6w1L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=XNIUsQ/J; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="XNIUsQ/J"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260904155529337caafd920002074b
        for <xenomai@lists.linux.dev>;
        Fri, 04 Sep 2026 17:55:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=X/YufYB4EbFvReittqBeJQS1h6l+LWKgNzTUCRc1MSo=;
 b=XNIUsQ/JzPd2dlG38qqkZbe+yPTZGZZB42nP3yJUbbZPZDWYDEWZgtIgDuyqTD8jLWUmnN
 yZvo11g54zMQyY33Nm8I28BcCeg/Q1LQypav7YdVsOmqCuL2eOJornVHofkDlkIlfE0oUNnF
 NJXBW3RmuGomzRwyhNE6RhvLhT6bEcHaLItOvUj7Nk18AObqI7qXNEparjewtEOroOwBLf73
 6qwDt0l1PAk7/I9KJIe7zzMhxczWedkZLMvxOtn7K8TAEIeIslFv54Y0jTtgabFr/7x5y0Dl
 5qMMO3+dY6KFkhwyervpjyyoxFeVzw4/JUFFePUk7VJXeeWCGFX5L/ig==;
Message-ID: <e729ab55695799eac6eadd30078b72169d932219.camel@siemens.com>
Subject: Re: perf getting all-zeroes IP on STM32MP1
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Andrew MacPherson <andrew@elk.audio>, xenomai@lists.linux.dev
Date: Fri, 04 Sep 2026 17:55:29 +0200
In-Reply-To: <87wlt1cafu.fsf@xenomai.org>
References: 
	<CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com>
		<9e0b7d3e72a19bd900a14faa6c459f5a2e093982.camel@siemens.com>
	 <87wlt1cafu.fsf@xenomai.org>
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

On Fri, 2026-09-04 at 17:17 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > Hi Andrew,
> >=20
> > [CC + Philippe]
> >=20
> > On Fri, 2026-09-04 at 15:26 +0200, Andrew MacPherson wrote:
> > > Hello,
> > >=20
> > > We're working on an STM32MP1-based system running Xenomai and found
> > > that perf top shows every symbol as "unknown [00000000]", i.e.
> > > profiling is collecting samples, but they all point at address zero.
> > >=20
> > > I'm not a kernel developer but went through a few debug kernel builds
> > > with an agent which eventually led to the attached patch. This change
> > > does resolve the issue with perf, however I'm not sure if it's the
> > > correct solution.
> > >=20
> > > The reasoning is that arm_arch_timer.c's percpu IRQ registration neve=
r
> > > sets IRQF_TIMER, so Dovetail's copy_timer_regs() never populates
> > > tick_regs, leaving get_irq_regs() to always return an all-zero
> > > pt_regs, which in turn breaks perf's sample IP.
> >=20
> > Yep, that is wrong. The patch you provided looks OK to me. I'm just
> > wondering if that should be addressed in Linux as well / first.
> >=20
>=20
> In fact, Dovetail is somewhat abusing IRQF_TIMER in that the only bit in
> that mask we should care about is __IRQF_TIMER, which is only used for
> recovering from misrouted IRQs these days, specifically excluding some
> descriptors from the polling loop which tries to find a proper
> handler. Problem is that we also carry the no-suspend semantics attached
> to this mask when using it, which is not what we mean.
>=20
> I think that the mainline code simply acknowledges the fact that per-CPU
> interrupt handlers should never be polled for solving a misrouted IRQ
> issue by definition, so there is no point in tagging those lines with
> __IRQ_TIMER in the first place, which applies to the architected timer
> interrupt as well. IIRC, that was the point of the recent set of
> upstream changes to request_percpu_irq(), dropping those flags. Such
> change prompted us to put back a secondary interface accepting flags so
> that we can keep on passing IRQF_TIMER.
>=20
> > @Philippe: Any additional thoughts? Should we take it already?
> >=20
>=20
> I believe that we should not live much longer with this hack, we should
> provide a dedicated IRQF_* flag introduced by Dovetail instead that
> would specifically say "this line generates deferred tick events" or
> something along these lines.
>=20
>=20

Would the qualify as starting point? We would have to identify all the
dovetail specific IRQF_TIMER usages, but that should be doable:

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 61a1e33cb2ca3..8258fbaf54a2d 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -76,6 +76,8 @@
  *            handler any time interrupts are enabled in the CPU,
  *            regardless of the (virtualized) interrupt state
  *            maintained by local_irq_save/disable().
+ * IRQF_TIMER_DEFERRED - Dovetail: The interrupt line generates deferred
+ *                       tick events
  */
 #define IRQF_SHARED		0x00000080
 #define IRQF_PROBE_SHARED	0x00000100
@@ -93,6 +95,7 @@
 #define IRQF_NO_DEBUG		0x00100000
 #define IRQF_COND_ONESHOT	0x00200000
 #define IRQF_OOB		0x00400000
+#define IRQF_TIMER_DEFERRED	0x00800000
=20
 #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
=20
diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
index de401973c6230..31fd2fc70f74d 100644
--- a/kernel/irq/pipeline.c
+++ b/kernel/irq/pipeline.c
@@ -1065,7 +1065,8 @@ void copy_timer_regs(struct irq_desc *desc, struct pt=
_regs *regs)
 {
 	struct irq_pipeline_data *p;
=20
-	if (desc->action =3D=3D NULL || !(desc->action->flags & __IRQF_TIMER))
+	if (desc->action =3D=3D NULL ||
+	    !(desc->action->flags & IRQF_TIMER_DEFERRED))
 		return;
 	/*
 	 * Given our deferred dispatching model for regular IRQs, we
