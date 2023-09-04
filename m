Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6F9ECA
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 07:13:39 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230904071336100518ac1b5abdbb7e
        for <xenomai@lists.linux.dev>;
        Mon, 04 Sep 2023 09:13:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=3MuaEPemba9dxZsVSCZ8H6PXsA8w/wS/3yvM7NmuQ1A=;
 b=kZDaJjpEsWuLjtJLpaPeZ1grZp8pn3OSTx7kGhbwB0Vfe+g1iS88d0H0PXzeBM2xce5EqL
 EW+8ZWTfKxzqpniwgrq9BbOJ29eincIkiQIBYIIAgvXR7+0mGmLu2nUQgD6YIy07ciCdV9Ox
 4QEjEj5IlYKTqqMooS7WKrM6YZLXk=;
Message-ID: <8afc5d76d9a514432026f560cf2c9f8015da07a0.camel@siemens.com>
Subject: Re: [PATCH 17/20] scripts/Kconfig.frag: Switch to I-pipe only
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Mon, 04 Sep 2023 09:13:36 +0200
In-Reply-To: <da4bec53d14a791516e7ef5104bb5e2dbaef7391.1693753497.git.jan.kiszka@siemens.com>
References: <cover.1693753497.git.jan.kiszka@siemens.com>
	 <da4bec53d14a791516e7ef5104bb5e2dbaef7391.1693753497.git.jan.kiszka@siemens.com>
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

On Sun, 2023-09-03 at 17:04 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>

I think the subject is wrong. It's dovetail only.

>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  scripts/Kconfig.frag | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/scripts/Kconfig.frag b/scripts/Kconfig.frag
> index 7921286638..b76d25e535 100644
> --- a/scripts/Kconfig.frag
> +++ b/scripts/Kconfig.frag
> @@ -1,10 +1,8 @@
>  menuconfig XENOMAI
>  	depends on X86_TSC || !X86
>  	bool "Xenomai/cobalt"
> -	select IPIPE if HAVE_IPIPE_SUPPORT
> -	select IPIPE_WANT_APIREV_2 if IPIPE
> -	select DOVETAIL if HAVE_DOVETAIL
> -	select DOVETAIL_LEGACY_SYSCALL_RANGE if HAVE_DOVETAIL
> +	select DOVETAIL
> +	select DOVETAIL_LEGACY_SYSCALL_RANGE
>  	default y
>  	help
>  	  Xenomai's Cobalt core is a real-time extension to the Linux
> --=20
> 2.35.3
>=20

