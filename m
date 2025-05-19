Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880EE19E96A
	for <xenomai@lists.linux.dev>; Mon, 19 May 2025 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642935; cv=none; b=Zg4enmjDYXtD9GUC/Lgv8s5MIo/Q4JY5o1SGgEKaXjLIlB7y8IORt5jMnCqsEPRfk1t5ixUp+R+AxElQ4H6jZgkvdMstmkskfwLzjt/cE5ADc+Aqgopv1Y97yj7FLjdzDL/29QhDS8CLSIWZrNcgj5BDXwHuxa7gGFx2D3N1cwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642935; c=relaxed/simple;
	bh=fe0YtQNx/QIV6K/ZS7RhP2FDdZpzBhti49NGLi2qCWQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ij0bfkEbKEH/Il3jv1arSO1/BHbJR8EoaeH2gaARZuVD+1JWM4d50yE5Mf1rmuXL/5n3pkjeaia2D3sddi9pA/K00/ZSi+jfGnZQn7vGCxtBwTq7FoUkqK1zwnXVutpSfNBBRLBCSLvLusWyObCGJZVIADNfxIfKtcS8H6EwGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=AJ2tb1eT; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="AJ2tb1eT"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2025051907414947b855d6457d65b81a
        for <xenomai@lists.linux.dev>;
        Mon, 19 May 2025 09:41:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wKRUyVdYldxp8jkgBORaMqGJjABQMVkkA4N+Yhb7xOI=;
 b=AJ2tb1eT2yO1zszdbuc5IfsqZwEeHb2GG4q2glqeCqTAKSCCEpn46LG/A+z/UIJuZ7pyJB
 qqnG2lW3GHZ/6UNfwoB+r29AiozMTwPk2OKbbxLJdYoJH2VlB44DKHu2Mh0XcAt7D2EiN0dH
 s1qoifU5U4tB+A+UmykcD/KgyaSgQYpGVw5eoMEXf81wwvRnzMhRfBKknbNgtNlB6i5/qIV2
 oCoES6PAqWcfZ1AtaWPUWzaJ7tA4sDe4d/m0Jq1jYQDbHAW2d9p3UryxYp4pJqZrzrPW67z9
 kN38jFKYaiWq7FA232x5YktMcmghO6a2NDW4BEs7EDeAyGGwlhO0E6EA==;
Message-ID: <11e61990decb9a05266fa955cfa62bf6773a4774.camel@siemens.com>
Subject: Re: [PATCH] lib/cobalt: Unbreak sigshadow installation for
 statically linked applications
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Cc: Haiyang He <aspirestro@163.com>
Date: Mon, 19 May 2025 09:41:48 +0200
In-Reply-To: <dcc04a18-af0b-4661-9a2b-f07674f2239c@siemens.com>
References: <dcc04a18-af0b-4661-9a2b-f07674f2239c@siemens.com>
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

On Mon, 2025-05-19 at 08:44 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> When statically linking, we do not have a .eh_frame_hdr section. If we
> then call backtrace before frame_dummy was invoked during late
> constructions, we abort. Address that by moving the backtrace warm-up
> call into a separate constructor that is armed earlier by
> install_sigshadow, or call it later directly if install_sigshadow is
> running after the construction phase.
>=20
> Reported-by: Haiyang He <aspirestro@163.com>

Was that a private conversation? Seems it didn't make it to the list...

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  lib/cobalt/sigshadow.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
>=20
> diff --git a/lib/cobalt/sigshadow.c b/lib/cobalt/sigshadow.c
> index 092cadb08a..abdb6b5491 100644
> --- a/lib/cobalt/sigshadow.c
> +++ b/lib/cobalt/sigshadow.c
> @@ -33,6 +33,9 @@ static inline int backtrace(void **buffer, int size)
> =20
>  static struct sigaction sigshadow_action_orig;
> =20
> +static bool request_backtrace_init;
> +static bool past_constructors;
> +
>  /*
>   * The following handler is part of the inner user-interface: should
>   * remain extern.
> @@ -96,19 +99,35 @@ static void sigshadow_handler(int sig, siginfo_t *si,=
 void *ctxt)
>  	pthread_sigmask(SIG_SETMASK, &saved_sigset, NULL);
>  }
> =20
> -static void install_sigshadow(void)
> +/*
> + * Kickstart backtrace() so that it may call malloc() from a safe contex=
t right
> + * now, not later on from the sigshadow handler.
> + *
> + * We can only trigger this after main() started or very late during
> + * construction because, when statically linked, frame_dummy in ctrstuff=
 must
> + * have run already.
> + */
> +static void __attribute__((constructor)) trigger_backtrace(void)
>  {
>  	void *dummy[SIGSHADOW_BACKTRACE_DEPTH];
> +
> +	if (request_backtrace_init)
> +		backtrace(dummy, SIGSHADOW_BACKTRACE_DEPTH);
> +
> +	past_constructors =3D true;
> +	/* ensure visibility of past_constructors after init phase */
> +	smp_mb();
> +}

Could we reuse on of the exiting "constructor priorities" like
__setup_ctor or hook into the setup_call() machinery? Benefit would be
some more control over the ordering of the init phase.

> +
> +static void install_sigshadow(void)
> +{
>  	struct sigaction new_sigshadow_action;
>  	sigset_t saved_sigset;
>  	sigset_t mask_sigset;
> =20
> -	/*
> -	 * Kickstart backtrace() so that it may call malloc() from a
> -	 * safe context right now, not later on from the sigshadow
> -	 * handler.
> -	 */
> -	backtrace(dummy, SIGSHADOW_BACKTRACE_DEPTH);
> +	request_backtrace_init =3D true;
> +	if (past_constructors)
> +		trigger_backtrace();
> =20
>  	sigemptyset(&mask_sigset);
>  	sigaddset(&mask_sigset, SIGSHADOW);
> --=20
> 2.43.0

