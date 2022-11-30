Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B78D63A8
	for <xenomai@lists.linux.dev>; Wed, 30 Nov 2022 14:23:33 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2022113014232402b01a0af673ffe3ce
        for <xenomai@lists.linux.dev>;
        Wed, 30 Nov 2022 15:23:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=U66tgbJNXsDA50+xvt14I1j0sZ3VIYd0V8Y+o4PZfKE=;
 b=NpyPqKWG5quXhonx/bXEvcBChzfELz660BM3mTwQYvMbo74CwPoh7lDxPR46LxLlzbP292
 /wot0Ixh+Nr5kS7B7u3KwX+oUtUWewqj4Y2ss0phh/yBj1dug0CRk2Hfyh/SLANyDaVCBtE7
 cTjj6EFnO01yHtejvPCLb1RAZS2ZY=;
Message-ID: <84e2bfb77888ee790873cecd1ba6bb9e49dfd3af.camel@siemens.com>
Subject: Re: [PATCH 1/5] switchtest: fix rtuo not respectiong _ufps
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "T. Schaffner" <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com
Date: Wed, 30 Nov 2022 15:23:23 +0100
In-Reply-To: <20221130141134.2503172-2-tobias.schaffner@siemens.com>
References: <20221130141134.2503172-1-tobias.schaffner@siemens.com>
	 <20221130141134.2503172-2-tobias.schaffner@siemens.com>
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

Hi Tobias,

nice to have one more active contributor. Welcome!

On Wed, 2022-11-30 at 15:11 +0100, T. Schaffner wrote:
> From: Tobias Schaffner <tobias.schaffner@siemens.com>
>=20
> The mode variable in the rtuo thread switches between 1 and 2.
>=20
> A wrong check on the mode variable leaded to never using the FPU in secon=
dary
> mode.
>=20
> Evaluate the mode variable correctly.
>=20
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  testsuite/switchtest/switchtest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/swi=
tchtest.c
> index f2a5c1601..e4339b0e2 100644
> --- a/testsuite/switchtest/switchtest.c
> +++ b/testsuite/switchtest/switchtest.c
> @@ -668,7 +668,7 @@ static void *rtuo(void *cookie)
>  		}
> =20
>  		expected =3D rtsw.from + i * 1000;
> -		if ((mode && param->fp & UFPP) || (!mode && param->fp & UFPS))
> +		if ((mode =3D=3D 2 && param->fp & UFPP) || (mode =3D=3D 1 && param->fp=
 & UFPS))

1 and 2 still look like magic values to me. Don't we have some #defines
for that? Looks like we have when scanning your following patches.
Can't we use them here already?

>  			fp_regs_set(fp_features, expected);
>  		err =3D ioctl(fd, RTTST_RTIOC_SWTEST_SWITCH_TO, &rtsw);
>  		while (err =3D=3D -1 && errno =3D=3D EINTR)
> @@ -682,7 +682,7 @@ static void *rtuo(void *cookie)
>  		case -1:
>  			clean_exit(EXIT_FAILURE);
>  		}
> -		if ((mode && param->fp & UFPP) || (!mode && param->fp & UFPS)) {
> +		if ((mode =3D=3D 2 && param->fp & UFPP) || (mode =3D=3D 1 && param->fp=
 & UFPS)) {
>  			fp_val =3D check_fp_result(expected);
>  			if (fp_val !=3D expected)
>  				handle_bad_fpreg(param->cpu, fp_val);

