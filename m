Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8ED198E92
	for <xenomai@lists.linux.dev>; Tue, 27 Aug 2024 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724749853; cv=none; b=eWW63R8XnILnlXRjTIm3xGD4aAAR1MaIBQaVsNTOosBKfbaskQF0zPJwxzlaD56/SY8CpsINQDUptAXitf9GQZXeox2F3u48xmrAakvjGRzHyp04GTPjKh39DRzBVCDbpj2erTPqGLc22l/5bk9dqnj5PrTnfpwaz131nwh00x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724749853; c=relaxed/simple;
	bh=XtoiaXiwAxoq9WpRZxK25CmjEIQqAqVhfJDs2UVcYdk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VIzAvJeRXftf7SSL0NgnNyk6f9Eg0VxvjT8ZeUocwvSkYcVR5vfSft5vxStBAV38AARmdHhMwWdqKUH71gOBODUfdJAQfNtsTIvbgJQBHob/0MvQ2U1bKSZj1uYUueW6xuZwyOzIK5TJB2WM6oL8D8jighw8mS+IWxiYpfUBabA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=PYPGpDqD; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="PYPGpDqD"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2024082709104209d7bf72bcfe93621d
        for <xenomai@lists.linux.dev>;
        Tue, 27 Aug 2024 11:10:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=OvR37TX+uLURBxBUPjkKjN+/UA2Xt6yCE4bjdk8wxro=;
 b=PYPGpDqDpsXY9tACOAga07yV2qznlnq19b7wPDFt+S2kiv2L9qlhrdwmYB8+eOehWfgPfQ
 usANLfuYF5Pg4gK9Z0l8Lq3jeQP7T6FdVYgftxSNbuT4XAYeaWgumzcSRlmLf/VnYLgWp0Zz
 BzbFZfc6VRKUPVeCXkB287jul314KQTh7h5RQXlimpAnoTEQEm/K8f3I6dZeR3jqZ4JoNrfZ
 Rpqm6hne1y/GL27xnhhkvmKxAuZv7JeuMOtqHiOIHOI3A7+p82xGOn+vhZAuyqIkBqJtyayU
 T+IqEIfKMcZ4nNH1fjXtPpnhunGxUq9Mmc+ImTtBYcH8jIU+rMgAqVLA==;
Message-ID: <2de6209339b990f2c3a7bd16415d3e38b4a3eb65.camel@siemens.com>
Subject: Re: [PATCH v2 2/4] lib/boilerplate: Get cpu-affinity from env var
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Simon Graber <simon.graber@sigma-star.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
Date: Tue, 27 Aug 2024 11:10:40 +0200
In-Reply-To: <20240827084521.13547-3-simon.graber@sigma-star.at>
References: <20240827084521.13547-1-simon.graber@sigma-star.at>
	 <20240827084521.13547-3-simon.graber@sigma-star.at>
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

On Tue, 2024-08-27 at 10:45 +0200, Simon Graber wrote:
> It might be helpful to specify the cpu-affinity via an env var,
> XENO_CPU_AFFINITY.
> This commit adds a helper function, called in __xenomai_init.
> The --cpu-affinity=3D parameter overrules the environment variable.
>=20
> Signed-off-by: Simon Graber <simon.graber@sigma-star.at>
> ---
>  lib/boilerplate/setup.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
> index 26c8c4cf5..4249cd230 100644
> --- a/lib/boilerplate/setup.c
> +++ b/lib/boilerplate/setup.c
> @@ -383,6 +383,19 @@ void xenomai_usage(void)
>          fprintf(stderr, "--help				display help\n");
>  }
> =20
> +static int get_affinity_env(void)
> +{
> +	char *affinity_env;
> +
> +	int ret =3D 0;
> +
> +	affinity_env =3D getenv("XENO_CPU_AFFINITY");
> +	if (affinity_env) {
> +		ret =3D collect_cpu_affinity(affinity_env);
> +	}
> +	return ret;
> +}
> +

I'm confused here.=20

First: Naming. get_affinity_env(), I would expect that I get back the
value of XENO_CPU_AFFINITY, but that's not the case. I get some error
code from collect_cpu_affinity().

It seems the function does something very different. It sets the
affinity, based on the env variable content.

Btw: Code style. No newline inside the variable declarations at the
beginning. No Brackets around single line if blocks. Newline before
return.

>  static int parse_base_options(int *argcp, char **uargv,
>  			      const struct option *options,
>  			      int base_opt_start)
> @@ -560,6 +573,9 @@ static void __xenomai_init(int *argcp, char *const **=
argvp, const char *me)
>  	/* Retrieve the default CPU affinity. */
>  	retrieve_default_cpu_affinity();
> =20
> +	/* Environment variables can be overruled by arguments */
> +	get_affinity_env();
> +

Second: Error handling.
Single usage of get_affinity_env(), if we ignore errors why is
get_affinity_env() returning something?

>  	/*
>  	 * Parse the base options first, to bootstrap the core with
>  	 * the right config values.
> --=20
> 2.46.0
>=20

