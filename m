Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AE72DCBFF
	for <xenomai@lists.linux.dev>; Sun, 25 May 2025 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748166706; cv=none; b=besWGsZqdoapMa0K0V+/+wbyDem+N+Zw4krM6j9RkDxihr0SZHzN0iqP/mvdfd/n8gS0cuDaA6PtwU4cEA83YQjWrIGNm5vsO4eqO3zBn/YOx/UrrfiSJ4AmujZTP+dxw5Ig0fZNX0mAKb/QccTgSGirlViNgYzSZ9mnucFykcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748166706; c=relaxed/simple;
	bh=J1BjXvVWAT5JU/nCDqDNux3rG7FHT7Esvv0fSgXJZL4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FYTncvFW2gxzOLLi7J6GvAgBbuhKs5yf+j2PeKvcP2qQrQB+TbyuCnihcVBUDvHvAdSOR6vEI7GIFh0aKheqix825iMD7GZp/N9/ezXmcYy0V9kR8F7pHbClFS3DhcCryNwbuINPPyKYuBhBUkr6PHm9WaX9cc9v0UTGfhW5JMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=D25I0a7W; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="D25I0a7W"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2025052509513224dae0030a112305a2
        for <xenomai@lists.linux.dev>;
        Sun, 25 May 2025 11:51:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zCQzPV7CDdqSzhAwCyGnU1fNJS8JeZZzhiidY8pphdU=;
 b=D25I0a7W0Q4OZsr4nODX5ZSkmW7NQKpOau7sRUDIWipBDLmHjWRNxgEgCwszPjjUpBsGh2
 Wf2uDmrk+k/BJgum5vsHNWZjX7o7m/sKGHEr9FjlrE1DBqJBv+LphvjEu7GSOV0SfdB3Gmxv
 /8N8ITUqSR9zyBR0+XgwBrlvyd2xbBVaf5Dlom20Q+7iqwOX7ndAW5VnwpqtK2r09oTC9e2n
 jkaBPnOEFa4AjEeN/EhHdZWldvLdV4dO0/Isw9LFhbve4YLjAsmjf4IIst3bSGdIsIcqk/EU
 sHIDeqEoWHTm573HE9l50aPtiHePqONosnprUzI9KfPYDsEnUrFz63lA==;
Message-ID: <12ce1549fe564a2225490b7e2f10f8151fb2f790.camel@siemens.com>
Subject: Re: [PATCH] scripts/wrap-link.sh: Add support for -h|-help option
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Haiyang He <aspirestro@163.com>, jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev
Date: Sun, 25 May 2025 11:51:32 +0200
In-Reply-To: <20250525080648.353288-1-aspirestro@163.com>
References: <20250525080648.353288-1-aspirestro@163.com>
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

On Sun, 2025-05-25 at 16:06 +0800, Haiyang He wrote:
> Following the porting-posix tip, add support for -h|-help option.

I think the long option should be --help (instead of -help).

>=20
> Tip: https://v3.xenomai.org/tips/porting-posix/
>=20
> Signed-off-by: Haiyang He <aspirestro@163.com>
> ---
>  scripts/wrap-link.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/scripts/wrap-link.sh b/scripts/wrap-link.sh
> index fa83bd5e2..21c6885a2 100755
> --- a/scripts/wrap-link.sh
> +++ b/scripts/wrap-link.sh
> @@ -17,6 +17,7 @@ Options:
>  -q be quiet
>  -v be verbose (print each command before running it)
>  -n dry run (print all commands but don't run any)
> +-h, -help show this help message and exit
> =20
>  Example:
>  $1 -v gcc -o foo foo.o -Wl,@/usr/xenomai/lib/cobalt.wrappers -L/usr/xeno=
mai/lib -lcobalt -lmodechk -lpthread -lrt
> @@ -85,6 +86,11 @@ while test $# -gt 0; do
>  	    dryrun=3D"echo # "
>  	    ;;
> =20
> +	-h|-help)
> +	    usage "$progname"
> +	    exit 0
> +	    ;;
> +
>  	-*)
>  	    cc=3D"$cc $arg"
>  	    ;;
> --=20
> 2.34.1

