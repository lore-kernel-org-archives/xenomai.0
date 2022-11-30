Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4834163A8
	for <xenomai@lists.linux.dev>; Wed, 30 Nov 2022 14:25:12 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20221130142503212c9920b201215bb0
        for <xenomai@lists.linux.dev>;
        Wed, 30 Nov 2022 15:25:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=AOcnm+1Ak8jaxWo9rTeX2aIRjjPd0OV3fAUv7Ej2tMk=;
 b=gkhoALcxQGxrKIlGqFwHcjQwACrnAxMHdVwjUwYeUIliapE+sXuq0uUl9ab1I5zGALcmaR
 sA6WiB3OfvoFd5/pmRruVIGGxXF3pUtENIfHQbOf39nM8p/JurLPP0bq74dxrJ9+AUJAb8dY
 6gfN3sUwrwoyAMwyHBxqpNJTne/pA=;
Message-ID: <cf5ccba4b7469a83bce99dcf58d22532ebe6e552.camel@siemens.com>
Subject: Re: [PATCH 2/5] switchtest: split the set_mode method
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "T. Schaffner" <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com
Date: Wed, 30 Nov 2022 15:25:02 +0100
In-Reply-To: <20221130141134.2503172-3-tobias.schaffner@siemens.com>
References: <20221130141134.2503172-1-tobias.schaffner@siemens.com>
	 <20221130141134.2503172-3-tobias.schaffner@siemens.com>
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

On Wed, 2022-11-30 at 15:11 +0100, T. Schaffner wrote:
> From: Tobias Schaffner <tobias.schaffner@siemens.com>
>=20
> Split the set_mode method in separate methods for switching to primary an=
d
> secondary mode for improved readability.
>=20
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  testsuite/switchtest/switchtest.c | 48 ++++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 16 deletions(-)
>=20
> diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/swi=
tchtest.c
> index e4339b0e2..3a6126a81 100644
> --- a/testsuite/switchtest/switchtest.c
> +++ b/testsuite/switchtest/switchtest.c
> @@ -440,15 +440,21 @@ static void *fpu_stress(void *cookie)
>  	return NULL;
>  }
> =20
> -static void set_mode(const char *prefix, int fd, unsigned mode)
> +static void switch_to_primary_mode(void)
>  {
> -	switch (mode) {
> -	case 1:
> -		cobalt_thread_harden();
> -		return;
> +	cobalt_thread_harden();
> +	if (cobalt_thread_mode() & (XNRELAX|XNWEAK)) {
> +		perror("Switch to primary mode failed.");
> +		clean_exit(EXIT_FAILURE);
> +	}
> +}
> =20
> -	case 2:
> -		cobalt_thread_relax();
> +static void switch_to_secondary_mode(void)
> +{
> +	cobalt_thread_relax();
> +	if (!(cobalt_thread_mode() & (XNRELAX))) {
> +		perror("Switch to secondary mode failed.");
> +		clean_exit(EXIT_FAILURE);
>  	}
>  }
> =20
> @@ -475,7 +481,7 @@ static void *rtup(void *cookie)
>  	   allowed when suspended in ioctl. */
>  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
> =20
> -	set_mode("rtup", fd, 1);
> +	switch_to_primary_mode();
> =20
>  	do {
>  		err =3D ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
> @@ -556,7 +562,7 @@ static void *rtus(void *cookie)
>  	   allowed when suspended in ioctl. */
>  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
> =20
> -	set_mode("rtus", fd, 2);
> +	switch_to_secondary_mode();
> =20
>  	do {
>  		err =3D ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
> @@ -637,8 +643,9 @@ static void *rtuo(void *cookie)
>  	   allowed when suspended in ioctl. */
>  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
> =20
> -	mode =3D 1;
> -	set_mode("rtuo", fd, mode);
> +	switch_to_primary_mode();
> +	mode =3D COBALT_PRIMARY;
> +
>  	do {
>  		err =3D ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
>  	} while (err =3D=3D -1 && errno =3D=3D EINTR);
> @@ -668,8 +675,10 @@ static void *rtuo(void *cookie)
>  		}
> =20
>  		expected =3D rtsw.from + i * 1000;
> -		if ((mode =3D=3D 2 && param->fp & UFPP) || (mode =3D=3D 1 && param->fp=
 & UFPS))
> +		if ((mode =3D=3D COBALT_PRIMARY && param->fp & UFPP) ||
> +		    (mode =3D=3D COBALT_SECONDARY && param->fp & UFPS)) {
>  			fp_regs_set(fp_features, expected);
> +		}

I guess that answers my previous questions.

You should avoid touching the same code multiple times within one
series.

>  		err =3D ioctl(fd, RTTST_RTIOC_SWTEST_SWITCH_TO, &rtsw);
>  		while (err =3D=3D -1 && errno =3D=3D EINTR)
>  			err =3D ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
> @@ -682,7 +691,9 @@ static void *rtuo(void *cookie)
>  		case -1:
>  			clean_exit(EXIT_FAILURE);
>  		}
> -		if ((mode =3D=3D 2 && param->fp & UFPP) || (mode =3D=3D 1 && param->fp=
 & UFPS)) {
> +
> +		if ((mode =3D=3D COBALT_PRIMARY && param->fp & UFPP) ||
> +		    (mode =3D=3D COBALT_SECONDARY && param->fp & UFPS)) {
>  			fp_val =3D check_fp_result(expected);
>  			if (fp_val !=3D expected)
>  				handle_bad_fpreg(param->cpu, fp_val);
> @@ -690,11 +701,16 @@ static void *rtuo(void *cookie)
> =20
>  		/* Switch mode. */
>  		if (i % 3 =3D=3D 2) {
> -			mode =3D 3 - mode;
> -			set_mode("rtuo", fd, mode);
> +			if (mode =3D=3D COBALT_PRIMARY) {
> +				switch_to_secondary_mode();
> +				mode =3D COBALT_SECONDARY;
> +			} else {
> +				switch_to_primary_mode();
> +				mode =3D COBALT_PRIMARY;
> +			}
>  		}
> =20
> -		if(++i =3D=3D 4000000)
> +		if (++i =3D=3D 4000000)
>  			i =3D 0;
>  	}
> =20

