Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3582CA5
	for <xenomai@lists.linux.dev>; Tue,  1 Aug 2023 17:42:24 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 16C64D6D08
	for <xenomai@lists.linux.dev>; Tue,  1 Aug 2023 17:31:23 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F8661C0006;
	Tue,  1 Aug 2023 17:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1690911074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gy60djYcw2v5M6h1BY1mSo+VeWN0yhFGiNRdYM2i/4o=;
	b=fAPaa3BlGQu+SZ+G6h5bq39oMhxXA+I7rWnvS9QNYBK8Tz7vFRH6UZCq7INgEdvG3AYAmn
	8amadeyidPQ0GdogTD+sgisx7i18S3dmJc4ppnrWoPaI7RL0vdVuloal4VtZMk/sQDV0MO
	Ydaw4puw8oRKQv0HKdozqjJuXahkw+90evhShPa3+uAcvYHdaMYJVshwTndZeBVmsLwBFn
	HckNdR/R8PMZvxRIM8aq2fCLGnO9f6eSGVSeDqK3twjC7L/aStdmkz2gHWTb2dZ7mpjlUM
	tljlpmQiTH5k6BnVLQPWofyhceEn7Q1mBim4zV3r1jPeBrEqKqZTCchnwthvIg==
References: <DM6PR14MB3871876E6E078D3BE974ADCBA30AA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <DM6PR14MB387142813E6733B5C9DEFEE7A30AA@DM6PR14MB3871.namprd14.prod.outlook.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: yo sang <stlfatboy@hotmail.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: data modified by second NRT write with same memory location
Date: Tue, 01 Aug 2023 19:29:27 +0200
In-reply-to: <DM6PR14MB387142813E6733B5C9DEFEE7A30AA@DM6PR14MB3871.namprd14.prod.outlook.com>
Message-ID: <87pm46sm8y.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org


yo sang <stlfatboy@hotmail.com> writes:

> Hi,
>
> 	I was playing with xddp recently, and found a strange situation.
> 	I modified official example xddp-echo to test my case:
>
> 	Main()
> 		*   =3D>  get socket=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>  		*   =3D>  bind socket to port 0=20=20=20=20
> 		*   =3D>  open /dev/rtp0=20=20=20=20
>
> 		*	=3D>  create data buf with =E2=80=9Cfirst=E2=80=9D=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
>  		*   =3D>  write buf to RT domain via write()=20=20=20=20
> 		* 	=3D>  modify data buf to =E2=80=9Csecond=E2=80=9D
> =E3=80=80=E3=80=80	*   =3D>  write buf to RT domain via write()=20=20=20
> =E3=80=80=E3=80=80
> 	* Start realtime_thread-------------------------------------->----------=
+=20=20=20=20=20=20=20=20
> =E3=80=80=E3=80=80	*   =3D>  read from NRT domain via recvfrom()=20=20=20=
=20=20
> =E3=80=80=E3=80=80	*	=3D>  print output: =E2=80=9Csecond"
>  		*   =3D>  read from NRT domain via recvfrom()=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
> =E3=80=80		*	=3D>  print output: =E2=80=9Csecond=E2=80=9D=20=20=20=20=20=
=20=20
> =E3=80=80
> =E3=80=80If I write twice with same data location, the RT-end will receiv=
e =E2=80=9Csecond=E2=80=9D twice.
> =E3=80=80
> =E3=80=80Any comments?
> =E3=80=80Thanks
>
>=20=20=20=20=20=20=20=20=20=20=20=20=20=20

Please send the shortest possible piece of code illustrating the issue.

--=20
Philippe.
