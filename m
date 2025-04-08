Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB571C3314
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117571; cv=none; b=YpZiwv9l0EgjTVhwhqEhtHf6+HicKT56/NhH6ZAC06ypzfsxFK16ZyhYG/PGRzAsTYhDTUEOgm1bwgmChgUgyvPk8wcLEVH3LIpZQvWb+r6jYgTOzPsUbe0+lZL6zB5ZOPQVMWZX23DF3PoXS4fFIWrziVekuGWrW4M16bLa9as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117571; c=relaxed/simple;
	bh=V2FrnjCWl+fDwUZ1s9bR9HCTKv1xtTtI4UCDPFgiUYg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dc0DG1d0WNZtjTQW8VzlMAXEPZKFEZ8zOfHnMvgcjkhHXXZEGNaUsLUfWRK9fPmLGpPLuTTYJPJRNg2PQEdMy4ruomDTx2Ts96jAxtxk2UxK03MxE0J0n46u6u+QzEyy9tDNIVXfNXs1IRAOa3JH5YPtCrfDcEw8gs6BiuYs5dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Cwl6/zYV; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Cwl6/zYV"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202504081306036dc8729e28ee2bc2e7
        for <xenomai@lists.linux.dev>;
        Tue, 08 Apr 2025 15:06:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ungXPWhafZedpJK1cKZE9fQh3JFc8IG4mUdYNTq7VW8=;
 b=Cwl6/zYVUMdHJFVGI/3shTBNYukBBewraS2pXWiS2wGfLw29OgDJx4JuJrFbsSCP5J+Rd9
 ESEKaH+h0Wo6ervQmG42nGqw+0y+D9xLWmmESXs9Drz9BrXuO8OhAEmddNb5DnIom8uzoHi3
 GJi1s8fGLpsmPDjAOexAREipr4RgU6VMRku5a7SOpO73WDwwWibqbtij/hrUD7wFRIRYYYhv
 RuFSaTM4xJWUcGFZvLoSqYpZO7bEAp5ZwyT/R3pWGgCICsXRUKe8YI4fyIjIrTax1CAV/tvH
 npPRo5DovimalBw4/8hk9Q0c2wEIcFz0YEMv+GLpxGStQc0lrnFIebHQ==;
Message-ID: <82af204c390c6e18089310abb3531556971754cf.camel@siemens.com>
Subject: Re: [PATCH 4/5] arm64: dovetail: Helper functions for signal frame
 setup and restore
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Nikolaus Funk <nikolaus.funk@sigmatek.at>, xenomai@lists.linux.dev
Cc: richard@sigma-star.at, Richard Weinberger <richard@nod.at>, Johannes
 Kirchmair <johannes.kirchmair@sigmatek.at>, Jan Kiszka
 <jan.kiszka@siemens.com>, Lorenz Kofler	 <lorenz@sigma-star.at>
Date: Tue, 08 Apr 2025 15:05:52 +0200
In-Reply-To: <20250408123423.627477-5-nikolaus.funk@sigmatek.at>
References: <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
	 <20250408123423.627477-5-nikolaus.funk@sigmatek.at>
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

On Tue, 2025-04-08 at 14:34 +0200, Nikolaus Funk wrote:
> From: Richard Weinberger <richard@nod.at>
>=20
> This introduces an interface for handling signal frame setup and restorat=
ion,
> enabling realtime aware signal support within Xenomai. The implementation=
 uses
> existing Linux signal setup functions to avoid code duplication.
>=20
> Co-developed-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
> Co-developed-by: Lorenz Kofler <lorenz@sigma-star.at>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/arm64/include/asm/signal32.h |  3 ++
>  arch/arm64/kernel/signal.c        | 85 +++++++++++++++++++++++++++++++
>  arch/arm64/kernel/signal32.c      |  2 +-
>  3 files changed, 89 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/s=
ignal32.h
> index 7e9f163d02ec..cfdd691aeecc 100644
> --- a/arch/arm64/include/asm/signal32.h
> +++ b/arch/arm64/include/asm/signal32.h
> @@ -60,6 +60,9 @@ int compat_setup_rt_frame(int usig, struct ksignal *ksi=
g, sigset_t *set,
>  			  struct pt_regs *regs);
> =20
>  void compat_setup_restart_syscall(struct pt_regs *regs);
> +
> +int compat_restore_sigframe(struct pt_regs *regs,
> +		struct compat_sigframe __user *sf);
>  #else
> =20
>  static inline int compat_setup_frame(int usid, struct ksignal *ksig,
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index ad388cb248b2..1c3682abc897 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -1688,6 +1688,91 @@ void do_signal(struct pt_regs *regs)
>  	restore_saved_sigmask();
>  }
> =20
> +#ifdef CONFIG_DOVETAIL
> +int dovetail_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs =
*regs)
> +{
> +	sigset_t *oldset =3D sigmask_to_save();
> +	int usig =3D ksig->sig;
> +	int ret;
> +
> +	pagefault_disable();
> +
> +	if (!is_compat_task())
> +		ret =3D setup_rt_frame(usig, ksig, oldset, regs);
> +	else
> +		ret =3D compat_setup_rt_frame(usig, ksig, oldset, regs);

I would vote for changing the condition to is_compat_task() and
switching if/else branches.

> +
> +	ret |=3D !valid_user_regs(&regs->user_regs, current);
> +
> +	pagefault_enable();
> +
> +	return ret;
> +}
> +
> +static int dovetail_restore_64_rt_signal_frame(struct pt_regs *regs)
> +{
> +	struct user_access_state ua_state;
> +	struct rt_sigframe __user *frame;
> +	int ret =3D -EFAULT;
> +
> +	if (regs->sp & 15)
> +		goto out;

- Where is this magic 15 coming from?
- return -EFAULT; would also work and save us one label.

> +
> +	frame =3D (struct rt_sigframe __user *)regs->sp;
> +
> +	pagefault_disable();
> +
> +	if (!access_ok(frame, sizeof (*frame)))
> +		goto out_pfe;
> +
> +	if (restore_sigframe(regs, frame, &ua_state))
> +		goto out_pfe;
> +
> +	restore_user_access_state(&ua_state);
> +
> +	ret =3D 0;
> +
> +out_pfe:
> +	pagefault_enable();
> +out:
> +	return ret;
> +}
> +
> +static int dovetail_restore_32_rt_signal_frame(struct pt_regs *regs)
> +{
> +	struct compat_rt_sigframe __user *frame;
> +	int ret =3D 0;
> +
> +	if (regs->sp & 7)
> +		goto out;

Same as above.=C2=A0
- Magic 7
- Is the error reporting really correct here? We would return 0.

> +
> +	frame =3D (struct compat_rt_sigframe __user *)regs->compat_sp;
> +
> +	pagefault_disable();
> +
> +	if (!access_ok(frame, sizeof (*frame)))
> +		goto out_pfe;
> +
> +	if (compat_restore_sigframe(regs, &frame->sig))
> +		goto out_pfe;
> +
> +	ret =3D 0;
> +
> +out_pfe:
> +	pagefault_enable();
> +out:
> +	return ret;
> +}
> +
> +int dovetail_restore_rt_signal_frame(struct pt_regs *regs)
> +{
> +	if (is_compat_task())
> +		return dovetail_restore_32_rt_signal_frame(regs);
> +	else
> +		return dovetail_restore_64_rt_signal_frame(regs);
> +}
> +#endif
> +
>  unsigned long __ro_after_init signal_minsigstksz;
> =20
>  /*
> diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
> index 81e798b6dada..4b4088eb49d1 100644
> --- a/arch/arm64/kernel/signal32.c
> +++ b/arch/arm64/kernel/signal32.c
> @@ -179,7 +179,7 @@ static int compat_restore_vfp_context(struct compat_v=
fp_sigframe __user *frame)
>  	return err ? -EFAULT : 0;
>  }
> =20
> -static int compat_restore_sigframe(struct pt_regs *regs,
> +int compat_restore_sigframe(struct pt_regs *regs,
>  				   struct compat_sigframe __user *sf)
>  {
>  	int err;
> --=20
> 2.48.1
>=20

