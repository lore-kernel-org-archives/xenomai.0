Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5B51D88D7
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771318901; cv=none; b=Nt1y4DimdagFnTAYXQDoHOyzH1libvtAOz5CSVl0ObZ1LYeGzWATSq9lRh9PvIAnADdkwmiV8dicpUMif16YBT3UEgQb7aXrSWONqCQC+E8YD1q8OcBuPGvGMr3DAzm7GqhWKgQDZmQmGFoNwStE7rwIM7blGzuhG73q0BmqNNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771318901; c=relaxed/simple;
	bh=Z0jdZKcFMBm8j4twiXARqhIOv5QAJJjrSVVh8t6YiIA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z5xjlna1hXuARDv+1Ver4awq/msg6hYmAt9x6HlrfzYyz0mqfUfTAvwkVRPQQSJmE9yEcCK5RBBLW8RmqwKZOY3F6g+StCvL0s0OxoukFERBKcLdScQmWKED5rF0V9MFoiVJV9qRiLUxyki6KOTzvd5IB/w2FAMv5E/TdZMMrvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=f8d6i6Kx; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="f8d6i6Kx"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026021709012888508e7b520002078d
        for <xenomai@lists.linux.dev>;
        Tue, 17 Feb 2026 10:01:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ME65JxFwELrpZXlIbj5FASzpmtUwTYyTdAvQrhCugqU=;
 b=f8d6i6Kx9Jt7wHK4OacjQ7r6yxuoCJ32ED8btE+NL6AgSJB1QTpGTygbTbsejkiXjD8sqX
 UKgfECMWJDdZ7tudB55veBQsxOX6PTO3pKGXJcGYUUHA8MfOwoGPEc58D19+t6xPTVdA7+59
 brqnNE0YCc5tH/CTWKXHhb/QHuLSo2fqWRAuQ8DVvW+6SCTVDrHm4aMVKgwOd4RjEYyjOznX
 /uSsWVJJdzZI53A3JLXHjRnie4jd0fF/BWYwpVWwr0tpdzGYaDBD3UOHWliilgy0weXtgDwQ
 tbvMkon0AM86QpWSIj3VMLeEbWhNM8XhhIJ1GMYmrcja24OuZ/CV/KNA==;
Message-ID: <e359067fde7c74006edf82aab64bac6785adfb14.camel@siemens.com>
Subject: Re: [PATCH Dovetail 2/2] arm64: irq_pipeline: Fix the demotion
 checks for el0 and el1 IRQs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>, Jan Kiszka <jan.kiszka@siemens.com>
Date: Tue, 17 Feb 2026 10:01:27 +0100
In-Reply-To: <878qcrah5d.fsf@xenomai.org>
References: 
	<20260216-wip-flo-v6-19-dovetail-rebase-v1-0-5c36863cba17@siemens.com>
		<20260216-wip-flo-v6-19-dovetail-rebase-v1-2-5c36863cba17@siemens.com>
		<87jywbajfy.fsf@xenomai.org>
		<505e35212b6655e0cb65e9fbc418c1171a9c916e.camel@siemens.com>
		<9e12c4a73df2d24dd1b39ab196b0112cb4e7e6ef.camel@siemens.com>
	 <878qcrah5d.fsf@xenomai.org>
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

On Tue, 2026-02-17 at 09:49 +0100, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Tue, 2026-02-17 at 09:12 +0100, Florian Bezdeka wrote:
> > > On Tue, 2026-02-17 at 09:00 +0100, Philippe Gerum wrote:
> > > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> > > >=20
> > > > > While reviewing some of the low level pipeline code I realized th=
at
> > > > > the checks for task demotion are wrong on arm64.
> > > > >=20
> > > > > el0: The demotion check was missing in the oob case. We have to c=
heck
> > > > >      for running_inband() only as user_mode(regs) will always be =
true.
> > > > >      We are serving an IRQ over el0, so application / user mode.
> > > > >=20
> > > > > el1: The demotion check was unnecessary and "inactive" as
> > > > >      user_mode(regs) is never true on el1, we are serving an IRQ =
over
> > > > >      kernel mode.
> > > > >=20
> > > >=20
> > > > If the demotion happens from el1, you still want to check for a
> > > > rescheduling opportunity (i.e. kernel preemption case).
> > > >=20
> > > > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > > > ---
> > > > >  arch/arm64/kernel/entry-common.c | 8 ++++----
> > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel=
/entry-common.c
> > > > > index 07fa70713ce04eaf3df9223354babcecde923280..9c99eb3d18c459a90=
e1f7ce4e4c307e235e457a2 100644
> > > > > --- a/arch/arm64/kernel/entry-common.c
> > > > > +++ b/arch/arm64/kernel/entry-common.c
> > > > > @@ -73,6 +73,10 @@ static noinstr void arm64_pipeline_el0_irq(str=
uct pt_regs *regs,
> > > > >  	do_interrupt_handler(regs, handler);
> > > > >  	/* Done, unwind now. */
> > > > >  	handle_irq_pipelined_finish(prevd, regs);
> > > > > +	if (running_inband()) {
> > > > > +		stall_inband_nocheck();
> > > > > +		irqentry_exit_to_user_mode(regs);
> > > > > +	}
> > > > >  	instrumentation_end();
> > > > >  	arm64_exit_to_user_mode(regs);
> > > > >  }
> > > > > @@ -90,10 +94,6 @@ static noinstr void arm64_pipeline_el1_irq(str=
uct pt_regs *regs,
> > > > >  		prevd =3D handle_irq_pipelined_prepare(regs);
> > > > >  		do_interrupt_handler(regs, handler);
> > > > >  		handle_irq_pipelined_finish(prevd, regs);
> > > > > -		if (running_inband() && user_mode(regs)) {
> > > > > -			stall_inband_nocheck();
> > > > > -			irqentry_exit_to_user_mode(regs);
> > > > > -		}
> > > > >  		instrumentation_end();
> > > > >  		mte_check_tfsr_exit();
> > > > >  		return;
> > > >=20
> > > > diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/e=
ntry-common.c
> > > > index e0227d467cef4..770fc4059e083 100644
> > > > --- a/arch/arm64/kernel/entry-common.c
> > > > +++ b/arch/arm64/kernel/entry-common.c
> > > > @@ -90,10 +90,8 @@ static noinstr void arm64_pipeline_el1_irq(struc=
t pt_regs *regs,
> > > >  		prevd =3D handle_irq_pipelined_prepare(regs);
> > > >  		do_interrupt_handler(regs, handler);
> > > >  		handle_irq_pipelined_finish(prevd, regs);
> > > > -		if (running_inband() && user_mode(regs)) {
> > > > -			stall_inband_nocheck();
> > > > -			irqentry_exit_to_user_mode(regs);
> > > > -		}
> > > > +		if (running_inband())
> > > > +			goto out_irqentry;
> > > >  		instrumentation_end();
> > > >  		mte_check_tfsr_exit();
> > > >  		return;
> > > > @@ -109,6 +107,7 @@ static noinstr void arm64_pipeline_el1_irq(stru=
ct pt_regs *regs,
> > > >  	trace_hardirqs_on();
> > > >  	unstall_inband_nocheck();
> > > >  	handle_irq_pipelined_finish(prevd, regs);
> > > > +out_irqentry:
> > > >  	stall_inband_nocheck();
> > > >  	trace_hardirqs_off();
> > > >  	instrumentation_end();
> > > >=20
> > >=20
> > > That would look a bit imbalanced. We would have one additional
> > > trace_hardirqs_off() and one irqentry_exit() call without counterpart=
s.
> > >=20
> > > Is that really OK? Testing...
> >=20
> > Nope, doesn't boot up on my arm64 qemu.
> >=20
>=20
> This patch runs fine on my end, survives the full evl test suite,
> including the hectic test. Which kernel preemption model are you using?
> mine is this one:
>=20
> Linux qemu-arm64-evl 6.18.7-00979-gb2cf536d0898-dirty #286 SMP PREEMPT_RT=
 EVL Tue Feb 17 09:45:50 CET 2026 aarch64 GNU/Linux

Linux demo 6.19.0-00150-gcb2e9689c529-dirty #232 SMP PREEMPT DOVETAIL Tue F=
eb 17 09:55:00 CET 2026 aarch64 GNU/Linux

Let me schedule a CI run to see what real devices do.
