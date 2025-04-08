Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C7D38384
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117945; cv=none; b=iSQEMmxFh9NEt4du2bH+H719HWHOJ+/FRjbOcpfsqElkdgfhea6Nak/SqqQxgwXzlO7nlZTc0FC2KllsBIHPQmyMoVQMbPpNrdOfgiT/znayd5IsatSEiuMbGRdlkO1C4Ic15LlG23IYDA274nvUvtJemBTlwFRyemJOjO2L52E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117945; c=relaxed/simple;
	bh=/qLhp/OEj8l85eG5G+eeJ+AgvFf6F0qhx2JRXu938OY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rtm14tTyB9zSBOy6IgFpeNn1hdWJabPDrs6/EsQTND7nnRC4D6StSm6YfRsdPLyrdZ7pqzgi+o8AFRIU4ZJgCSfAH1maZ2G2T8/H68hde+BQT/V0KFOMCUC9wZM19uBCEYB1Avs7hr7hLOhqNL90BkG6JoOHFgbaWMwUnrICNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=gKKN6FD3; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="gKKN6FD3"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202504081312171b1a2a3f3182773b41
        for <xenomai@lists.linux.dev>;
        Tue, 08 Apr 2025 15:12:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EIgfKO+KszhNWwB/MNVjgCJoKbFGcO4Hc8UO7A3yc+A=;
 b=gKKN6FD3saMl/PdoDXzQkOe48cb0KGg0REZr7JKO2+vgBE0PcqA98W17m8775h0VEuLRz2
 7SPUKMYBwHM7zNyDYnMk94+OxooJNO6EibGxchuAUh0RRqVtpjpeU8N1AOmcwgUextbapuwv
 tO3p6B2pIsiAc6PiJEHlh4n0BVN0e8hGPXC7nHZ3hjRh8GUWDfvlygV590o5Ec6TxJQo9iAk
 EwhuXF+/O/ZIEF+HCIMvTuz+AALrqrc7XU7h4s4068vZRonezLpkUIp2M7MmKI544IMUHWOc
 EDSTWbrtXWK8FcAgjtHVNd/NUM1r+k2UeYTw8cE+dEht3APftzFeDMOQ==;
Message-ID: <609d917110db9ea8549a6cf37115554c712e44a8.camel@siemens.com>
Subject: Re: [PATCH 5/5] arm: dovetail: Helper functions for signal frame
 setup and restore
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Nikolaus Funk <nikolaus.funk@sigmatek.at>, xenomai@lists.linux.dev
Cc: richard@sigma-star.at, Richard Weinberger <richard@nod.at>
Date: Tue, 08 Apr 2025 15:12:11 +0200
In-Reply-To: <20250408123423.627477-6-nikolaus.funk@sigmatek.at>
References: <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
	 <20250408123423.627477-6-nikolaus.funk@sigmatek.at>
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
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/arm/kernel/signal.c | 50 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>=20
> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> index 2631632090c0..27fcbf22336c 100644
> --- a/arch/arm/kernel/signal.c
> +++ b/arch/arm/kernel/signal.c
> @@ -497,6 +497,56 @@ setup_rt_frame(struct ksignal *ksig, sigset_t *set, =
struct pt_regs *regs)
>  	return err;
>  }
> =20
> +#ifdef CONFIG_DOVETAIL
> +int dovetail_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs =
*regs)
> +{
> +	sigset_t *oldset =3D sigmask_to_save();
> +	int ret;
> +
> +	pagefault_disable();
> +
> +	ret =3D setup_rt_frame(ksig, oldset, regs);
> +	ret |=3D !valid_user_regs(regs);
> +
> +	pagefault_enable();
> +
> +	return ret;
> +}
> +
> +int dovetail_restore_rt_signal_frame(struct pt_regs *regs)
> +{
> +	struct rt_sigframe __user *frame;
> +	int ret =3D -EFAULT;
> +	int sig;
> +
> +	if (regs->ARM_sp & 7) {
> +		goto out;
> +	}

The different code style here (and below) is by intention?

> +
> +	frame =3D (struct rt_sigframe __user *)regs->ARM_sp;
> +
> +	pagefault_disable();
> +
> +	if (!access_ok(frame, sizeof (*frame))) {
> +		goto out_pfe;
> +	}
> +
> +	if (restore_sigframe(regs, &frame->sig)) {
> +		goto out_pfe;
> +	}
> +
> +	if (copy_from_user(&sig, &frame->info.si_signo, sizeof(sig)))
> +		goto out_pfe;

Hm... Switched the style again... I assume checkpatch would have
complained... No?

> +
> +	ret =3D sig;
> +
> +out_pfe:
> +	pagefault_enable();
> +out:
> +	return ret;
> +}
> +#endif
> +
>  /*
>   * OK, we're invoking a handler
>   */=09
> --=20
> 2.48.1
>=20

