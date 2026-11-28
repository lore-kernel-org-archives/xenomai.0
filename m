Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795868523;
	b=Bb+6p3qZ4itvQj1OKsYd4o2GhN2Aa5pw7FV/L6PUlYDYYqpBtCogEYeKcfxMlXu78PF9
	 7cP/QkY8Xq8jcOWTKsBys/3XN8jTGWndAw0YbNuYN+oKb0DzFJMrMY/MLwN/PluP4Sg0U
	 +sec0KewDNpXZvX7Y7B+dN7OqLrl9wrkpEX4cSoeJqS6OtWPHXJ8JjF7QzNsMZuk/+qbD
	 a4L1l1WERmQibrZwupg79FEP4Y7a6woK/1ToP3/kmKrZs7+9osJgObYRK2EN63GTKjYzE
	 7/Ovz1QFmIzKtxsguxuzt6pNelEvtW5drJ9HK+bkSI5+I9RhDoxpGFmv+xZsYwIsBrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795868523;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-State:X-GND-Score:X-GND-Cause;
	bh=DG4Gx1SVb7F8k7mzTc8uhZKMQ443z/fBLNN/44SNw7s=;
	b=Pmj5H5ATWphlrEqf5pw4BTy/06IyY+h76loweaGfcIkayXEWzK/YWSgdujlYLtd4Dq4W
	 PjPqRSn6twDF7CwX0kIJ/HP2oO20aC0KhzOOEB19VxmTGukoPRywfWPXShhsvQ5Gk9Q7y
	 ffyYmxsNCQ3p2JbmDNbQYI2M5Yk/oDbUTuus34181R9qu5HFaL0O0mWnVJioBFce78qzz
	 r9lkN3i26jLhjG6mjJJLmVjSIZUS45jnq7AYbohiecLvn8rb9NHhvY4UGu/3FG9/+ZGDY
	 i8116zGK5Py2zXLqu7E0RlUCNKynRg4eSlEFBM/fY1GQv7GKuAfVMEZPye0h/ZRHRpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=J4DZPL2i;
	arc=none smtp.remote-ip=217.70.183.197
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EBB606A31C
	for <xenomai@lists.linux.dev>; Sat, 28 Nov 2026 12:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98EBB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=J4DZPL2i
Received: by mail.gandi.net (Postfix) with ESMTPSA id 89FB33EC5E;
	Sat, 28 Nov 2026 12:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1795868515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DG4Gx1SVb7F8k7mzTc8uhZKMQ443z/fBLNN/44SNw7s=;
	b=J4DZPL2ievg1q1Mr5Eurgct26u0llJI+8iSFqnzil/0D8K4I+nfSifKDw6Ob+UzsdrnVZw
	AYouu0KeDd6+J5QVquGlwf0i0Eqdv8AXclX0PbCsg0Jp6uHZraahO0odeHEg4NvbTvSZtW
	FwzfgJwK0WxjS+AIPqeFuJuIwmygD5uBDCuFR5+vNS0Y4UdLGITDMEOCBCEk66vJKn9dHr
	E/O2Iux/Kxg9JAGzc2pSy5t4SXiDqItQpxLgDP1Mgc5SXReotHe21DAvHS+VO4yy5Baxcz
	P4IQAc5+ldqOs6w/rOZRFEMbPE22yBH5+DTqZ1OWYNAA+f//x2rMUekOD1ogDw==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  jan.kiszka@siemens.com
Subject: Re: [RFC PATCH dovetail v2 1/7] dovetail: factor out the mayday
 check on return to user mode
In-Reply-To: <8e286fce008f976aa924cd346c9c297bcf086505.1795786695.git.tobias.schaffner@siemens.com>
	(Tobias Schaffner's message of "Fri, 27 Nov 2026 14:47:19 +0100")
References: <cover.1795786695.git.tobias.schaffner@siemens.com>
	<8e286fce008f976aa924cd346c9c297bcf086505.1795786695.git.tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 28 Nov 2026 13:21:53 +0100
Message-ID: <87o6b9gn8e.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGpMevPq2SQEQ16oGalq2jCMe0edh17k7drSTXxPGE24EJAqCoSz2wcOTsVqpajpaUjPNDxLTX/Ahf46UyJeXw4Y9sHg+UErRuzi1avq66yPxydUwe41EaU/s3W72qHO8H27jhpF6kj1fulyqssws8CUKUw8FOHlVesAG9UOgq9gSmYk9dieNLopKIX17PxmtYChZIP79UsqK1xD5DtrO4NrAhV/zg7w6VRt6q9uEGOhSB+Lqv+gvvpbfDuB6KlMri8tRT/9J8SzvPi2DN353xB1knWxPVAaMt0rLKsBXiVh00l9jWbFUXzpIelEx4DwrNzG22djYn8CnuopA6mJXlWI0ym+jM/wFBJxOFUi09E9y4e4Ly7ZowBP0tKb0mEEiE9lEJBweNYAYQ4g+TUwi4OSMS3aZSi8TeC77Hrn1gVlKnOjD/1ED3MZD8LcvhQrnE3ozfqhsR6zXGIctVafDJ8c3CLUXLVLFhSlcajUNqGAtD1NfId+YIhIMn5jOFYLZ12eWTq3gw94Pbeq8ap7esUwarZYA7BuWTxpt7DLUyyv/F54USlia2SX6pcO24LrnrKXkfYIpfAHr2XOcfCzHBOGDsF/sDztEiz8x50dGPj7ZjPrInv6sR4sj7EnG9cFC0EHHE+i7OqS5jR0zNK/Au06h587g2FDfQIaVqHxIGxeg

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Dovetail checks for a pending mayday at three places before returning to
> user mode out-of-band. Move the check into dovetail_oob_exit_to_user().
> On the IRQ path it now runs only when returning out-of-band, as an
> in-band task has no mayday pending.
>
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  include/linux/dovetail.h |  2 ++
>  kernel/dovetail.c        | 14 +++++++++-----
>  kernel/irq/pipeline.c    |  4 ++--
>  3 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/dovetail.h b/include/linux/dovetail.h
> index 1140c5b7c99f..b41ea0f8fc4e 100644
> --- a/include/linux/dovetail.h
> +++ b/include/linux/dovetail.h
> @@ -198,6 +198,8 @@ struct oob_mm_state *dovetail_mm_state(void)
>  
>  void dovetail_call_mayday(struct pt_regs *regs);
>  
> +void dovetail_oob_exit_to_user(struct pt_regs *regs);
> +
>  static inline void dovetail_send_mayday(struct task_struct *castaway)
>  {
>  	struct thread_info *ti = task_thread_info(castaway);
> diff --git a/kernel/dovetail.c b/kernel/dovetail.c
> index d2ea78913fb6..da4016697b67 100644
> --- a/kernel/dovetail.c
> +++ b/kernel/dovetail.c
> @@ -99,6 +99,13 @@ void dovetail_call_mayday(struct pt_regs *regs)
>  	hard_local_irq_restore(flags);
>  }
>  
> +/* Returning to user mode on the out-of-band stage. */
> +void dovetail_oob_exit_to_user(struct pt_regs *regs)
> +{
> +	if (test_thread_flag(TIF_MAYDAY))
> +		dovetail_call_mayday(regs);
> +}
> +

[snip]

> diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
> index 88911489aeb6..f9c9c13d7137 100644
> --- a/kernel/irq/pipeline.c
> +++ b/kernel/irq/pipeline.c
> @@ -1244,8 +1244,8 @@ int handle_irq_pipelined_finish(struct irq_stage_data *prevd,
>  	 * Sending MAYDAY is in essence a rare case, so prefer test
>  	 * then maybe clear over test_and_clear.
>  	 */
> -	if (user_mode(regs) && test_thread_flag(TIF_MAYDAY))
> -		dovetail_call_mayday(regs);
> +	if (user_mode(regs) && running_oob())
> +		dovetail_oob_exit_to_user(regs);
>  #endif
>  
>  	return running_inband() && !irqs_disabled();

The code dovetail_oob_exit_to_user() runs is now in a different
compilation unit, so I would inline this helper because we can't count
on LTO to fold it into the interrupt hot path.

-- 
Philippe.
