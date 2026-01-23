Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB032695C
	for <xenomai@lists.linux.dev>; Fri, 23 Jan 2026 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180659; cv=none; b=cqUsWd0j1zTM/4XkxQFDs1i9OJosTTw0IfaDu8KDksFRQdh9e9HiBIDx5/AwoiViprMFPz7Xa/JjytpYUJQeu5UWte2wFFSmOi374GAfB72Mqvu+4sAJJJraYlGbjcNPWAD+avmqRpTGhbYuwOQar8aMN03m8865pTyVKMnKUGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180659; c=relaxed/simple;
	bh=QkuE+MO7Iq9tX8m9rx45Lrqy9x9lcCSwuGZRhuxrJGA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ryHBqBDyeYTSL1lFagnTKqw0S30u8zL/10e+xI4jg3tkwN99FHvQMl1ktL8+Yb0YKxVpoC0t7p1qRIpRZCD4UftNxNy3iO6/ioWmqiuUZz8z3wCWwTLe3QefuqMb6NDs4sdRAleq+kawxYDfR8R8xayeXlsK+RpjdkGgBqH/Sqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=XtovZkVH; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="XtovZkVH"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260123150357a551cc08130002077c
        for <xenomai@lists.linux.dev>;
        Fri, 23 Jan 2026 16:03:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=dTx2wFBAZE3NsjxjoJaiaQYO0O0n9lfuvEqAzDSv11o=;
 b=XtovZkVHzWbVfHtBe5828gj/UEodaE3HWkmh2aDYXa9Y4Kc+jOMzRqIezIBkz7GHTgJ1rs
 TqKcM9GxNjvqZyuApnbpuprLPc3+H9nCX7hOvM+QQjAb42kcT78llE5DK6KBbyvKOG1x8O2f
 x+Z27VjbNII69ZOGOcyHdJVgCjKcfJPItyycrlwtJmLzoJ00aTCdA3vt5hFMyK+sbizE1BGQ
 1ATf+459c/AHUgltk1cdj04xANCPJxLNprlr8NwNIcia4AcFbiRPELYsHIXj7kAFfNfnbJ5F
 unVyUxlCZQbhgVdR4q/NiBIZ6iaeiGKxy+mxfxNddxu3P2sdRu6qpv3Q==;
Message-ID: <4d307470aab470bb4f753ff6b8526282a334d818.camel@siemens.com>
Subject: Re: [v6.18.y-dovetail][PATCH] arm64: dovetail: restore lost debug
 trap hooks
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Xenomai <xenomai@lists.linux.dev>
Date: Fri, 23 Jan 2026 16:03:56 +0100
In-Reply-To: <59c22e2a-2946-4114-93c9-5c7736d15c7d@siemens.com>
References: <59c22e2a-2946-4114-93c9-5c7736d15c7d@siemens.com>
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

On Fri, 2026-01-23 at 16:00 +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Apparently lost in the forward porting from 6.17.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>=20
> Fixes the gdb smokey test of Xenomai 3.

Thanks Jan for looking into that issue. That is exactly what I expected.
Testing looks good, so:=20

ACK.

>=20
>  arch/arm64/kernel/entry-common.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-c=
ommon.c
> index 2ae2f6898bd2c..e0227d467cef4 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -842,6 +842,7 @@ static void noinstr el0_softstp(struct pt_regs *regs,=
 unsigned long esr)
>  		arm64_apply_bp_hardening();
> =20
>  	arm64_enter_from_user_mode(regs);
> +	mark_trap_entry(ARM64_TRAP_DEBUG, regs);
>  	/*
>  	 * After handling a breakpoint, we suspend the breakpoint
>  	 * and use single-step to move to the next instruction.
> @@ -852,6 +853,7 @@ static void noinstr el0_softstp(struct pt_regs *regs,=
 unsigned long esr)
>  	local_daif_restore(DAIF_PROCCTX);
>  	if (!step_done)
>  		do_el0_softstep(esr, regs);
> +	mark_trap_exit(ARM64_TRAP_DEBUG, regs);
>  	arm64_exit_to_user_mode(regs);
>  }
> =20
> @@ -871,8 +873,10 @@ static void noinstr el0_watchpt(struct pt_regs *regs=
, unsigned long esr)
>  static void noinstr el0_brk64(struct pt_regs *regs, unsigned long esr)
>  {
>  	arm64_enter_from_user_mode(regs);
> +	mark_trap_entry(ARM64_TRAP_DEBUG, regs);
>  	local_daif_restore(DAIF_PROCCTX);
>  	do_el0_brk64(esr, regs);
> +	mark_trap_exit(ARM64_TRAP_DEBUG, regs);
>  	arm64_exit_to_user_mode(regs);
>  }
> =20
> --=20
> 2.51.0
