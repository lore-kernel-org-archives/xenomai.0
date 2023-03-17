Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7EA6AAD
	for <xenomai@lists.linux.dev>; Fri, 17 Mar 2023 13:15:37 +0000 (UTC)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 6460E8591C;
	Fri, 17 Mar 2023 14:15:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1679058935;
	bh=kWP6E1utASFcaFhNLJn7NPOOx2YsHZvCEzHj/IZZOqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xeOddS2u94dHTV+Phvn/Wk7ScaBdJkF/DkUjFC6eeSX+suetZSTtLwl57UwY38vkf
	 bHvDbaUYFW5X32RO3KPNqppFcZzZe1p0aUVeOUwo0zceMazSz/ssSM5JjnxPgC5ywZ
	 oR3qM7Lj8XRDZA6YJWb7IrQ9yq1l0+7x4RL0KLYw1kfPwVyQIGSC6oq8Q061teuwml
	 014Rbeptls+7ZjVqvEc4ShCIpm/NXC63tckRUratUO5+rDuEfaBRyr3BMmSdNrtKzM
	 8kf8MDB5jEx3NpTZKHZat2K+9yI+hDeOpCJKMqOVnT6rypbs862owR6aDk7+nFeblX
	 /yVFyQkHikddg==
Date: Fri, 17 Mar 2023 14:15:25 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [xenomai4] Sharing information regarding RPi4 demo
Message-ID: <20230317141515.77bf22cb@wsk>
In-Reply-To: <7d613388-9300-1265-60b0-2efe18167d0d@siemens.com>
References: <20230317133249.38756e92@wsk>
	<7d613388-9300-1265-60b0-2efe18167d0d@siemens.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9z27=u+w+D3NB7grp/lsOlH";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/9z27=u+w+D3NB7grp/lsOlH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jan,

> Hi Lukasz,
>=20
> On 17.03.23 13:32, Lukasz Majewski wrote:
> > Dear All,
> >=20
> > I would like to inform you about available Xenomai4 demo for
> > Raspberry Pi4 (model B) board.
> >=20
> > All you need is to build the SD card and connect oscilloscope.
> >=20
> > Please follow guidelines in:
> > https://source.denx.de/lukma/meta-xenomai-demo
> >=20
> > Full Yocto/OE setup is possible with single kas file:
> > https://source.denx.de/lukma/kas/-/blob/master/rpi4-xenomai4-demo.yml
> >=20
> > I hope that somebody will find it useful :-)
> >  =20
>=20
> Thanks for sharing - and for showing this to me live on Wednesday! :)
>=20

You are welcome :-)

> Jan
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/9z27=u+w+D3NB7grp/lsOlH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmQUZ+0ACgkQAR8vZIA0
zr1+Fgf/Uxe3NZW1vl8UUWHFKnWzGOzLapwACTJa1Is/jsjR2uNRhBg0n+mv8ro3
x2TvJdTL4Yw2OUjA0usRhuv23lMUPTnB4VVD9Xw8ip+BW4nVc4hkTyh01sNrO+LO
qcFFJDbKF6gH9GhXQKc+l82SiM3ajssC5x4vyPxuadVhff+QaLcHGjQY6nYjExNY
4GB9YBKHrlFwz6ZhjewCv2+qxF5T/g2g3c7IBzuRuTdGuMO3WV3ZzljxpY1k6CA0
ix9XKHt/6wB3pZTtw+PFp42EstA6dZK6DFBXLXg06MOWnm8bfWKx3beuCx6aKZGT
BYSOQexejhDyWV93DE40zME98KeiyA==
=Z414
-----END PGP SIGNATURE-----

--Sig_/9z27=u+w+D3NB7grp/lsOlH--
