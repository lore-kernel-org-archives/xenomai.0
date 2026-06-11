Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B51223DEA
	for <xenomai@lists.linux.dev>; Thu, 11 Jun 2026 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185618; cv=none; b=NZujdWVqZGBrsstaksyzOGOz+4ElbINW47QJeIoJ6OR+7At0uvl26DrATpZP2SRLApEhKOlzYbVZi7OXe+7KFgpBtnOd5uxiSYn+O8Ff70RxpauLCLa0s1ln9cq3NkWsIghZIUMDrxxwVosPeC5F8wmaCDJHzWLbeKc1fn8TxHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185618; c=relaxed/simple;
	bh=qWpmBBFjeRhYavUdwxhNjdabfswG1a7ygIwUfm8+r8E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tVE2raSENF4cpYgua950CqtcFZSHgrSLFbe7ZP/5ZrC4iI1/sNxsD+SAsJ6d60l9HMYzRYi/FDWQDArYtdqHk9MEFGv/l4IC4uSHM5fFwn4dpTZQ+FbHTDbN/56Ivn9IUuIaYC0CUmzvMJ/1IXgbvMIjjpZSawAx3vTdjfAThLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=efgBHN61; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="efgBHN61"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260611134645baf09eedb000020733
        for <xenomai@lists.linux.dev>;
        Thu, 11 Jun 2026 15:46:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=om+FH8VDhv480ZMl2/fN5cuMppCArcGUmhzdeW+tTbE=;
 b=efgBHN61T3XVgoWC9LP+56UreuHUcK9XWruV/wHK6AajLz3I+8bqCKn0sD6S63QtrI7sB4
 xDIa7kYUycmJsfeG8H51P5zpSCIBEkPojnN+EzUd4MInIZFd0x1I66iynjhBxxqUjXPsl9lX
 PwMyx7tdHeSlmHfmL76reoK3shdJFVsO2UwS6asVgEjgJadREhsfc8P8zDOVy0qnln1uIH1Z
 4P1Ul7Px/BtPs2GnD9ishaeuhUdDCTtsWe9spLr+DxwNrbbonJzF2NIivdFsdmvwUNdo255q
 5XDYDpyZmSwGd1F9YQzI1QEIiOFN3bEgULYAUYttECYk8SP5O2L1gMaw==;
Message-ID: <0a76369a44e33ca1c8c27c5c2690770b4668be7c.camel@siemens.com>
Subject: Re: [PATCH RFC Dovetail 7.1] arm64: irq_pipeline: 7.1 specific
 adjustments
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Date: Thu, 11 Jun 2026 15:46:44 +0200
In-Reply-To: <20260611134057.2267177-1-florian.bezdeka@siemens.com>
References: <20260611134057.2267177-1-florian.bezdeka@siemens.com>
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

On Thu, 2026-06-11 at 15:40 +0200, Florian Bezdeka wrote:
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>=20
> Hi Philippe,
>=20
> final tests are still running but the local tests are looking good.
> The EVL testsuite triggered a WARN_ONCE() - see process.c below - which
> caused the systems to hang.
>=20
> Turned out the arm64 entry code got some refactorings that needed some
> adjustments - pipline wise.
>=20
> I would fold the following into 7.1, so could you please double check?
> Thanks!
>=20
>  arch/arm64/kernel/entry-common.c | 35 ++++++++++++++++++++++++++++----
>  arch/arm64/kernel/process.c      |  6 +++---
>  include/linux/irq-entry-common.h |  3 +++
>  3 files changed, 37 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-c=
ommon.c
> index b0e141266349..97f6d6904a5d 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -166,7 +166,16 @@ static noinstr irqentry_state_t arm64_enter_from_ker=
nel_mode(struct pt_regs *reg
>  static void noinstr arm64_exit_to_kernel_mode(struct pt_regs *regs,
>  					      irqentry_state_t state)
>  {
> -	local_irq_disable();
> +	if (irqs_pipelined()) {
> +		hard_local_irq_disable();
> +		if (running_inband()) {
> +			stall_inband_nocheck();
> +			trace_hardirqs_off();
> +		}
> +	} else {
> +		local_irq_disable();
> +	}
> +
>  	irqentry_exit_to_kernel_mode_preempt(regs, state);
>  	local_daif_mask();
>  	mte_check_tfsr_exit();
> @@ -175,7 +184,14 @@ static void noinstr arm64_exit_to_kernel_mode(struct=
 pt_regs *regs,
> =20
>  static __always_inline void arm64_syscall_enter_from_user_mode(struct pt=
_regs *regs)
>  {
> -	enter_from_user_mode(regs);
> +	if (running_inband()) {
> +		WARN_ON_ONCE(irq_pipeline_debug() && irqs_disabled());
> +		stall_inband_nocheck();
> +		enter_from_user_mode(regs);
> +		trace_hardirqs_on();
> +		unstall_inband_nocheck();
> +	}

Should enter_from_user_mode() be called while the inband stage is
stalled, or after unstalling? The exit part is called while being
stalled, so I kept that in sync, but I'm not 100% sure.

> +
>  	mte_disable_tco_entry(current);
>  	sme_enter_from_user_mode();
>  }
> @@ -191,6 +207,7 @@ static __always_inline void arm64_enter_from_user_mod=
e(struct pt_regs *regs)
>  		WARN_ON_ONCE(irq_pipeline_debug() && irqs_disabled());
>  		stall_inband_nocheck();
>  		enter_from_user_mode(regs);
> +		rseq_note_user_irq_entry();
>  		trace_hardirqs_on();
>  		unstall_inband_nocheck();
>  	}
> @@ -226,8 +243,18 @@ static __always_inline void arm64_syscall_exit_to_us=
er_mode(struct pt_regs *regs
>   */
>  static __always_inline void arm64_exit_to_user_mode(struct pt_regs *regs=
)
>  {
> -	local_irq_disable();
> -	irqentry_exit_to_user_mode_prepare(regs);
> +	if (irqs_pipelined()) {
> +		hard_local_irq_disable();
> +		if (running_inband()) {
> +			stall_inband_nocheck();
> +			trace_hardirqs_off();
> +			irqentry_exit_to_user_mode_prepare(regs);
> +		}
> +	} else {
> +		local_irq_disable();
> +		irqentry_exit_to_user_mode_prepare(regs);
> +	}
> +
>  	local_daif_mask();
>  	sme_exit_to_user_mode();
>  	mte_check_tfsr_exit();
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index b1eac5fd75c1..0047d0bdedd9 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -748,8 +748,8 @@ static inline void debug_switch_state(void)
>  		unsigned long pmr_expected =3D GIC_PRIO_IRQOFF;
>  		unsigned long pmr_actual =3D read_sysreg_s(SYS_ICC_PMR_EL1);
> =20
> -		WARN_ONCE(daif_actual !=3D daif_expected ||
> -			  pmr_actual !=3D pmr_expected,
> +		WARN_ONCE(running_inband() && (daif_actual !=3D daif_expected ||
> +			  pmr_actual !=3D pmr_expected),
>  			  "Unexpected DAIF + PMR: 0x%lx + 0x%lx (expected 0x%lx + 0x%lx)\n",
>  			  daif_actual, pmr_actual,
>  			  daif_expected, pmr_expected);
> @@ -757,7 +757,7 @@ static inline void debug_switch_state(void)
>  		unsigned long daif_expected =3D DAIF_PROCCTX_NOIRQ;
>  		unsigned long daif_actual =3D read_sysreg(daif);
> =20
> -		WARN_ONCE(daif_actual !=3D daif_expected,
> +		WARN_ONCE(running_inband() && daif_actual !=3D daif_expected,
>  			  "Unexpected DAIF value: 0x%lx (expected 0x%lx)\n",
>  			  daif_actual, daif_expected);

That was the warning triggered by CI, that stalled the system. Is that
expected? I'm quite sure that in the oob case the DAIF flags are
different, but is WARN_ONCE() expected to completely halt the system?


>  	}
> diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-c=
ommon.h
> index 58c28b2a8f2b..61a8e129e71f 100644
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -600,6 +600,9 @@ irqentry_exit_to_kernel_mode_after_preempt(struct pt_=
regs *regs, irqentry_state_
>  {
>  	bool synchronized;
> =20
> +	if (running_oob())
> +		return;
> +

The enter/exit code moved one layer down, from irqentry_enter() to
irqentry_enter_from_kernel_mode(), so this code needs the oob check as
well.

>  	instrumentation_begin();
>  	synchronized =3D irqentry_syncstage(state);
> =20
> --=20
> 2.54.0
