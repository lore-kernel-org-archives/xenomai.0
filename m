Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A676330664
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327432; cv=none; b=ZzrUfKEPsRFsoH1c88dObc1q++EvgHQKdh0eueGvSeScZX7HXAOtVOYrw+LciNUOxwA7RJd30gqMAX07XhJnkKieHR6QgmWLQa7tWj4gIqK3+J8GIWAHMLEnUGAlMzKtRz8yf37Sz0mFbf+IJe7FcZ890k4BYpVdyZ4Zmq9zZWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327432; c=relaxed/simple;
	bh=iJujOhZP9J07hG+Bdx1eRDwWflsADxckpuo2hM386Ew=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pm4fkxbfHBnvRI96Z2CnJieEBYtxaNDVAkgA61ek3A9uD6zE8QpqDIsZ52FoF6XHNlnXFfMjY4eNvyF0sGbrSBL9FREnFoqUVYG/bJ2hMeCQh5jjybMadXrgATiiKslhxi9Me2s8PABlPo2fKtbPSuvA0+uoTig/vAiAkpo//p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=YhbBPgLf; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="YhbBPgLf"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202602171123432acb86a90400020746
        for <xenomai@lists.linux.dev>;
        Tue, 17 Feb 2026 12:23:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qaV4ojiI3Os6jIMW1ODHO4PS17RjzN27Glr9s7ZnNUg=;
 b=YhbBPgLfDsdnxRprBkkSx7s2nQq2w7GyHxsb7+w+eiuyIdDFu5hU1LcwZK4uOevcnFlqgE
 76hh0wXCs3stavg8rOy8L92YvHETYEHH/VEdwtRVWVec557Bu6cQGP4lpyCYiPFB/J/vXuub
 ITLiycINbkxbGsV1r6lvQ130zMWPITbPF235Dvns7FQGAKuXayOnEGSgp8+df2rAD6X57elX
 IdZTffDrxTT8JU8ymhKKqM+BqAZ/NnbYrzXhqjWNHNj07PX2c1iweg0kl6Bh6PJbrfcSF+rc
 7vdtqnP39KaPQy3CPY4AW9BXsBZFlRioJ4LJsu2SUAxsOmaG390HiLtw==;
Message-ID: <36ce9316dacdc92bfc02ea2888e05d424bf5c9b7.camel@siemens.com>
Subject: Re: [PATCH Dovetail 2/2] arm64: irq_pipeline: Fix the demotion
 checks for el0 and el1 IRQs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>, Jan Kiszka <jan.kiszka@siemens.com>
Date: Tue, 17 Feb 2026 12:23:42 +0100
In-Reply-To: <87o6ln8yt1.fsf@xenomai.org>
References: 
	<20260216-wip-flo-v6-19-dovetail-rebase-v1-0-5c36863cba17@siemens.com>
		<20260216-wip-flo-v6-19-dovetail-rebase-v1-2-5c36863cba17@siemens.com>
		<87jywbajfy.fsf@xenomai.org>
		<505e35212b6655e0cb65e9fbc418c1171a9c916e.camel@siemens.com>
		<9e12c4a73df2d24dd1b39ab196b0112cb4e7e6ef.camel@siemens.com>
		<87ecmjahk3.fsf@xenomai.org>
		<430245ce2bc8da023235e9cf1312f729d7c57494.camel@siemens.com>
		<87tsvf9081.fsf@xenomai.org> <87o6ln8yt1.fsf@xenomai.org>
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

On Tue, 2026-02-17 at 11:11 +0100, Philippe Gerum wrote:
> Philippe Gerum <rpm@xenomai.org> writes:
>=20
> > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> >=20
> > > On Tue, 2026-02-17 at 09:41 +0100, Philippe Gerum wrote:
> > > > > Comparing with x86 again, I think that my proposal is "correct" i=
n terms
> > > > > of identical to what x86 does. Do all architectures have a gap he=
re?
> > > >=20
> > > > x86 has a single implementation for both user and kernel preemption
> > > > paths, arm64 has two since the privilege level is explicitly stated=
 by
> > > > the irq handler being called, but this still must translate identic=
ally
> > > > logically speaking. Your implementation is missing the kernel preem=
ption
> > > > path after demotion.
> > > >=20
> > > > i.e. when checking for running_oob() || irqs_disabled(), the cases
> > > > covered are:
> > > >=20
> > > > (1) in-band user path on entry (implies !irqs_disabled())
> > > > (2) oob user path on entry (might be demoted)
> > > > (3) (virtually) stalled in-band kernel path on entry (implies no re=
schedule,
> > > >   filtered out by irqentry_exit())
> > > > (4) oob kernel path on entry (might be demoted)
> > > >=20
> > > > Therefore, with your patch in, el1 is now missing (4).
> > >=20
> > > Right, but I'm wondering if x86 ignores this case as well.
> > >=20
> > > After demotion of a oob kernel path entry, user_mode() should still b=
e
> > > false - bypassing the call to irqentry_exit_to_user_mode() - No?
> >=20
> > Yes, x86 assumes that a kernel path demoted to in-band is going to cros=
s
> > an IRQ synchronization point shortly after on return to the preempted
> > context. Now, with hindsight, the question is: are we 100% certain of
> > that? Any real (hw) IRQ over the in-band stage would trigger the
> > synchronization as expected, but a synthetic one posted from the oob
> > stage might linger if this assumption ends up being wrong. I need to
> > have a second look at this code.
>=20
> Which means that your latest patch series is ok and complete. The change
> if any would most likely happen in the generic pipeline bits.

I think (2) is still wrong on arm64 now, so:

@@ -65,15 +65,17 @@ static noinstr void arm64_pipeline_el0_irq(struct
pt_regs *regs,
                                void (*handler)(struct pt_regs *))
 {
        struct irq_stage_data *prevd;
+       bool oob_on_enter;
=20
        arm64_enter_from_user_mode(regs);
        instrumentation_begin();
        /* Prep for handling, switching oob if needed. */
+       oob_on_enter =3D running_oob();
        prevd =3D handle_irq_pipelined_prepare(regs);
        do_interrupt_handler(regs, handler);
        /* Done, unwind now. */
        handle_irq_pipelined_finish(prevd, regs);
-       if (running_inband()) {
+       if (oob_on_enter && running_inband()) {
                stall_inband_nocheck();
                irqentry_exit_to_user_mode(regs);
        }

Do you agree?

I will prepare a v2 after some more CI testing.

Florian

