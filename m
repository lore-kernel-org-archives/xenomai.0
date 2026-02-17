Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4C82DB7AA
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315948; cv=none; b=IeNsAzxpROgwKqWsrWYiy/FMZxGGItINgZD0H1aB8+ezsjNgwIPHKNLDlHaFH8n8BJJlpb7ELD/6JSQHMxLJTOppbgPhgqNeRQiCbhFoxIfthqDfzDr+6r4Cff/WSfsDjyfnaSOcNxTaUi4ckpPZBeHulVuhfbPZyAL5+HK1LwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315948; c=relaxed/simple;
	bh=FXUuGOiS4KtRH4/F0Sx5NFoz5hVPlOaXvbtLJrlyebA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UnNnqHPw1HEMMGPmpAD0XagVgidOlGGHsUzMtNNkPVQqqkbIcK5eNWpow+QVvBgIuuhHAie9HO+rYWW/GK8VYZxe1VjZaMxlKUsG46ZE/PolO5gjUd1CuyPBjaLe08XPj3r9CWDfTev+j77y1ihMCYKFXN4za04ty2Qhbshgy+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=FH1qkG86; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="FH1qkG86"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202602170812204008f43f4900020754
        for <xenomai@lists.linux.dev>;
        Tue, 17 Feb 2026 09:12:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2WN3q/nRnm38ORGZDAaRV8+BxWWaM8B5whZRhm8/e2s=;
 b=FH1qkG86mxRCYOIol/9K8kQ9ka4vh73PSCiYsHBjo5I0DPxBdqUsmPQmeJPTMpVzZq/InF
 egkPKGHkPPJpm/0KDQb8ZqlkfZ6Jxn+1wk/5tA1EcaGzJ80MbuRtVf5dGIj+oUtF3tm4D+xA
 oQFfz9axIzKKxqySV5bKnYQb3i9Udk6c/ABH7Aeyhc4p7OeOMWBJHg0CaLWTmMmpq/NCS9w/
 iaKjejPrjUfOYbFcW5nGIjcsy0haKzIMrrMMP6/KlQJ0m91ZQiFkXLKNFjhlg33/vxwEdOHv
 lQkSINNhpS+j73iYzGJBJxKAK32kY0KeMNs77eS7+GZFZ3d6BD014wmA==;
Message-ID: <505e35212b6655e0cb65e9fbc418c1171a9c916e.camel@siemens.com>
Subject: Re: [PATCH Dovetail 2/2] arm64: irq_pipeline: Fix the demotion
 checks for el0 and el1 IRQs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>, Jan Kiszka <jan.kiszka@siemens.com>
Date: Tue, 17 Feb 2026 09:12:20 +0100
In-Reply-To: <87jywbajfy.fsf@xenomai.org>
References: 
	<20260216-wip-flo-v6-19-dovetail-rebase-v1-0-5c36863cba17@siemens.com>
		<20260216-wip-flo-v6-19-dovetail-rebase-v1-2-5c36863cba17@siemens.com>
	 <87jywbajfy.fsf@xenomai.org>
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

On Tue, 2026-02-17 at 09:00 +0100, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > While reviewing some of the low level pipeline code I realized that
> > the checks for task demotion are wrong on arm64.
> >=20
> > el0: The demotion check was missing in the oob case. We have to check
> >      for running_inband() only as user_mode(regs) will always be true.
> >      We are serving an IRQ over el0, so application / user mode.
> >=20
> > el1: The demotion check was unnecessary and "inactive" as
> >      user_mode(regs) is never true on el1, we are serving an IRQ over
> >      kernel mode.
> >=20
>=20
> If the demotion happens from el1, you still want to check for a
> rescheduling opportunity (i.e. kernel preemption case).
>=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  arch/arm64/kernel/entry-common.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry=
-common.c
> > index 07fa70713ce04eaf3df9223354babcecde923280..9c99eb3d18c459a90e1f7ce=
4e4c307e235e457a2 100644
> > --- a/arch/arm64/kernel/entry-common.c
> > +++ b/arch/arm64/kernel/entry-common.c
> > @@ -73,6 +73,10 @@ static noinstr void arm64_pipeline_el0_irq(struct pt=
_regs *regs,
> >  	do_interrupt_handler(regs, handler);
> >  	/* Done, unwind now. */
> >  	handle_irq_pipelined_finish(prevd, regs);
> > +	if (running_inband()) {
> > +		stall_inband_nocheck();
> > +		irqentry_exit_to_user_mode(regs);
> > +	}
> >  	instrumentation_end();
> >  	arm64_exit_to_user_mode(regs);
> >  }
> > @@ -90,10 +94,6 @@ static noinstr void arm64_pipeline_el1_irq(struct pt=
_regs *regs,
> >  		prevd =3D handle_irq_pipelined_prepare(regs);
> >  		do_interrupt_handler(regs, handler);
> >  		handle_irq_pipelined_finish(prevd, regs);
> > -		if (running_inband() && user_mode(regs)) {
> > -			stall_inband_nocheck();
> > -			irqentry_exit_to_user_mode(regs);
> > -		}
> >  		instrumentation_end();
> >  		mte_check_tfsr_exit();
> >  		return;
>=20
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-c=
ommon.c
> index e0227d467cef4..770fc4059e083 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -90,10 +90,8 @@ static noinstr void arm64_pipeline_el1_irq(struct pt_r=
egs *regs,
>  		prevd =3D handle_irq_pipelined_prepare(regs);
>  		do_interrupt_handler(regs, handler);
>  		handle_irq_pipelined_finish(prevd, regs);
> -		if (running_inband() && user_mode(regs)) {
> -			stall_inband_nocheck();
> -			irqentry_exit_to_user_mode(regs);
> -		}
> +		if (running_inband())
> +			goto out_irqentry;
>  		instrumentation_end();
>  		mte_check_tfsr_exit();
>  		return;
> @@ -109,6 +107,7 @@ static noinstr void arm64_pipeline_el1_irq(struct pt_=
regs *regs,
>  	trace_hardirqs_on();
>  	unstall_inband_nocheck();
>  	handle_irq_pipelined_finish(prevd, regs);
> +out_irqentry:
>  	stall_inband_nocheck();
>  	trace_hardirqs_off();
>  	instrumentation_end();
>=20

That would look a bit imbalanced. We would have one additional
trace_hardirqs_off() and one irqentry_exit() call without counterparts.

Is that really OK? Testing...
