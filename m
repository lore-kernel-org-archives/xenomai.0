Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795385547;
	b=IAX747+ARA+mPWRGu7SlTCea27+JbHKfmZ2m5xu6ZcRrNHWbT9+qMXM/eyJgctParxzt
	 BrJon2kme5qJLe+wV7eSAPpWg5t+oWMdPTl/YzYeD7q/yRQNRRffB1O6OFg+yxGn7uxos
	 /pXRk3uzKNKAyuRMcyvSEZATGxMLUcsT/mWwlKDkX6J9CXVVf1llYrMjkGcvSz/kQ/Iib
	 0FO8jm9nTwKIb59eT+Fk88OdtfHnpubGNsCIK4zQly+hXU2tWZs9Q1uUuJqtQkuX5Vgde
	 cxZYj6NXIY4p/FOsOBd3gGYqa13vUB67C946C4FRuFTUMp1dNz+TPANN59CaswksjLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795385547;
	h=DMARC-Filter:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:References:In-Reply-To:X-Flowmailer-Platform:Feedback-ID;
	bh=GYLbK8308aBAcS0E0Sk8g4fIYSw57gf/x7cWtQSB614=;
	b=b/hAG03uMK3/PXu1WXBjfUx7jSzGZD/iXPXWrk8yl8o2GvusyzKdXcm5WYuESPynGIBH
	 isdUMIZiIxzAf69DPCFyxwk7mlIfrt+48v9O9771gCX7ElvZOlI1h42+dyq3BptyR0DAA
	 6wuoXHIfHUnAT1uiRTXHyusYU8SGGQ+mItAj5UjENIfILulqRw1aUyN8AyKiJdQ8a8YuQ
	 ChEKBOR2ekbCJx59beSNVk6N3bL1TW6VpU0tWeSQ28lOAdukKfOj6dA9XE1IFSWSjZC7A
	 SES6u6FwT2EIFuNBSbakLKbt+dqbPv4565yhouCmhTEKtZhuaBTuMVVD8+zjVT5TdZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=SvO3cpxq;
	arc=none smtp.remote-ip=185.136.65.226
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6196A606A31A
	for <xenomai@lists.linux.dev>; Sun, 22 Nov 2026 22:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6196A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=SvO3cpxq
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20261122221221618a3226dc000207e4
        for <xenomai@lists.linux.dev>;
        Sun, 22 Nov 2026 23:12:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=GYLbK8308aBAcS0E0Sk8g4fIYSw57gf/x7cWtQSB614=;
 b=SvO3cpxqZs5bO7hxxt3u2kzP/WKPbbPAD6rECqeHlw72adq3A16bc/5y9pBs58wVGtkjm2
 7bS7atC/exZqYnM9X3dfEn7E7GzYDPzpD0qAsbp5TQEjOkgHoL4nSw6VprTNOSvLskqCHjzb
 9vpU7On2sr1bxOu0pMVrkuLaA60vRqPqYVs5i43y0Mzd6aXxRB7e8C0dZKzigBGMMowRl4UD
 DmD5ZgL7fzKWRfecQJs1KsTmNqEc/jcVe5BwOxylHx1aX+9+c5339o9P/Y1Na8aiaIiDA70W
 YlXm6a7cAhfJRHqXpoDeUB4oRwnoq3x7s25iageObVDkDStHHcDcX4AA==;
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Nov 2026 23:12:21 +0100
Message-Id: <DN2323C4FVPZ.13C4TOTZPDADX@siemens.com>
Cc: <rpm@xenomai.org>, <jan.kiszka@siemens.com>
Subject: Re: [PATCH dovetail v2 3/4] riscv: dovetail: inherit the hard irq
 state on kernel page faults
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Tobias Schaffner" <tobias.schaffner@siemens.com>,
 <xenomai@lists.linux.dev>
References: <20261121165933.57310-1-tobias.schaffner@siemens.com>
 <20261121165933.57310-4-tobias.schaffner@siemens.com>
In-Reply-To: <20261121165933.57310-4-tobias.schaffner@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Sat Nov 21, 2026 at 5:59 PM CET, Tobias Schaffner wrote:
> A page fault may hit kernel code which runs with hard irqs off, e.g. a
> kprobe whose fetch argument faults within the breakpoint trap. The fault
> handler still enables hard irqs for every kernel mode fault, so an
> interrupt may break into that code. If the fault is handled out-of-band,
> the handler also unstalls the in-band stage over the out-of-band stage.
>
> Enable hard irqs in handle_page_fault() only if the faulting code had
> them on and we run in-band, and stall the in-band stage on exit only if
> we run in-band.
>
> Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  arch/riscv/kernel/traps.c | 11 ++++-------
>  arch/riscv/mm/fault.c     |  7 +++++--
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index a8e37ec27cc2..47799f18fa7d 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -488,17 +488,14 @@ asmlinkage __visible __trap_section void do_trap_so=
ftware_check(struct pt_regs *
>  asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
>  {
>  	irqentry_state_t state =3D irqentry_enter(regs);
> +	bool inband =3D mark_trap_entry(regs);
> =20
> -	mark_trap_entry(regs);
> -
> -	BUG_ON(dovetail_debug() && !running_inband());
> -
> -	if (!user_mode(regs))
> -		hard_cond_local_irq_enable();
> +	BUG_ON(dovetail_debug() && !inband && user_mode(regs));
> =20
>  	handle_page_fault(regs, state);
> =20
> -	local_irq_disable();
> +	if (inband)
> +		local_irq_disable();
> =20
>  	mark_trap_exit(regs);
> =20
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index c5709112c346..f72b49d8f15a 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -317,8 +317,11 @@ void handle_page_fault(struct pt_regs *regs, irqentr=
y_state_t state)
> =20
>  	/* Enable interrupts if they were enabled in the parent context. */
>  #ifdef CONFIG_IRQ_PIPELINE
> -	if (state.stage_info !=3D IRQENTRY_INBAND_STALLED)
> -		local_irq_enable_full();
> +	if (running_inband() && !regs_irqs_disabled(regs)) {
> +		hard_local_irq_enable();
> +		if (state.stage_info !=3D IRQENTRY_INBAND_STALLED)
> +			local_irq_enable();
> +	}

Is that aligned with any of the other architectures?

I'm asking because the pattern used here seems to have an ordering
problem.

Once hard_local_irq_enable() enabled the hard IRQs, hardware events
might come in, hitting a stalled inband stage. Means we log the events=20
into the IRQ log.

Afterwards, we unstall the inband stage with local_irq_enable() call,
which will bring us full IRQ log synchronization.

local_irq_enable_full() would do it the other way around.
Unstall first, than IRQ enable at the hardware layer. That looks like
the proper ordering.

>  #else
>  	if (!regs_irqs_disabled(regs))
>  		local_irq_enable();

