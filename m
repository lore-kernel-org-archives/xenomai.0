Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCCE171066
	for <xenomai@lists.linux.dev>; Mon,  9 Sep 2024 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911912; cv=none; b=MsPVe/9rZ2P6045496m0tO8CLMrGqQ2B77FhcE4+HSwhSvTmeicDBRvhD9zRvaEJVqyMR7cXlUqIzLjwC71SVgsCnNeOFi8IKgl5q6omaqu/O3n6qrk9Q6Qj2PRl/fIUDsT49WpQyEa/yb3jy3JG9t3Aj0IZN/4d0Rq39vFJ7x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911912; c=relaxed/simple;
	bh=40Oh8+qLja1nvywZcGFDyfS4Swu2/tCHaLC45vYNVeo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A+AiJUzkpw6YHKISZz1V9N+Rr6H1UsNmcVbOkwDRnaSKed1alZW6Z4NA7+CvxRGQ+SozX1lhxaoy653srE7v6hlS+R2V8MU0HL8JBdpxdvANQU9jOE2zekIPElTDWkrAxaObfF10ukPOaVQYhko7LrHFoD5d69e7bszKcnZmK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=EE/IIR4V; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="EE/IIR4V"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024090919581518152782a26f3b19c3
        for <xenomai@lists.linux.dev>;
        Mon, 09 Sep 2024 21:58:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=40Oh8+qLja1nvywZcGFDyfS4Swu2/tCHaLC45vYNVeo=;
 b=EE/IIR4VirQUMlLsnnWszz6O7irLc8F+nqoGqAKY30Kg6xAI0GyHgxpz8WladfCs28p3Bw
 iDujsi9+N/QExbO8xdHA2NQ7DZ/wwbx9SlRTgGCgd3n+Bs4rsmAKYXlkI2nMzUq9pzud7Rc/
 M7xKc5wE65isoKpIG0CHQ2hiJYmRl0fRiKxT5Htnw5Y+PEN3Ot6w93w6RLkjWgHokM7ZNue1
 KN441XBPBZ1ieb3Sa0/rEm2230QW8QwWKuXsjJaQ7MTOXPgiwlxRg9426xg2/2FDUoxCv4aO
 EQYx1Ba8cK+8r/q2FTPOBDYJ57ucnE/noiaryOZfVUhBHkExk17QplXQ==;
Message-ID: <38a3380515e799036d22ab152a33962fa5bf2302.camel@siemens.com>
Subject: Re: Compilation error kernel Xenomai3 for x86 32 bits
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: LE-DOUARAIN Marc <m.ledouarain@fareco.fayat.com>, 
 "xenomai@lists.linux.dev"
	 <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 09 Sep 2024 21:58:11 +0200
In-Reply-To: <AM6PR05MB60248E3F1360E8FDFFFADCD4AD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
References: 
	<AM6PR05MB6024420AB2F1754C19B5612EAD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
	 <fc38f3af6fa7b993fdbc81deecd7134ad6a39af4.camel@siemens.com>
	 <AM6PR05MB60248E3F1360E8FDFFFADCD4AD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
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

On Mon, 2024-09-09 at 15:00 +0000, LE-DOUARAIN Marc wrote:
> Hello Florian,
>=20
> > > I=E2=80=99ve tried to compile linux-dovetail-v5.10.214-dovetail1 gith=
ub=20
> > > repository for Xenomai 3.2.5 (from a Debian12.6=C2=A0i386), and it fa=
iled on theses errors=C2=A0:
> > > (the same with Xenomai 3.2.4)
> > >=20
> > > =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel/xenomai/pipeline/init.=
o
> > > kernel/xenomai/pipeline/init.c: In function =E2=80=98pipeline_init=E2=
=80=99:
> > > kernel/xenomai/pipeline/init.c:23:9: error: implicit declaration of=
=20
> > > function =E2=80=98enable_oob_stage=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declaration]
> > > =C2=A0=C2=A0 23 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ena=
ble_oob_stage("Xenomai");
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~
> > > kernel/xenomai/pipeline/init.c: In function =E2=80=98pipeline_cleanup=
=E2=80=99:
> > > kernel/xenomai/pipeline/init.c:49:9: error: implicit declaration of=
=20
> > > function =E2=80=98disable_oob_stage=E2=80=99 [-Werror=3Dimplicit-func=
tion-declaration]
> > > =C2=A0=C2=A0 49 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dis=
able_oob_stage();
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~
> > > cc1: some warnings being treated as errors
> > > make[3]: *** [scripts/Makefile.build:286 :=20
> > > kernel/xenomai/pipeline/init.o] Erreur 1
> > > make[2]: *** [scripts/Makefile.build:503 : kernel/xenomai/pipeline]=
=20
> > > Erreur 2
> > > make[1]: *** [scripts/Makefile.build:503 : kernel/xenomai] Erreur 2
> > > make: *** [Makefile:1832 : kernel] Erreur 2
>=20
> > I think the main point here is that we do no longer support 32 bit kern=
els. We still support the compat case, so 32 bit applications running on a =
64 bit kernel. Might that be an option for you?
> > Should work as long as your board supports is 64 bit.
>=20
> We are working step by step to update OS with an old base hardware (ISA b=
us) as transitional for now, and will use a 32 bits CPU "Vortex86DX3".
> =20
> > > =C2=A0
> > > I=E2=80=99ve used the command =C2=AB=C2=A0/prepare-kernel.sh --linux=
=3D########/linux-dovetail-v5.10.214-dovetail1 --arch=3Di386=C2=A0=C2=BB be=
fore configuring kernel.
> > > Not better with linux-dovetail-v6.6.23-dovetail2.
>=20
> > Haven't touched the prepare-kernel script for a while. Seems we should =
bail out and complain loudly when trying to use --arch=3Di386.
>=20
> If I can understand that for the =E2=80=9Cnew=E2=80=9D Xenomai 4, 32 bits=
 is excluded,
> it's perhaps a pity that Xenomai 3 can't continue to be used, especially =
if there's not much to be done to fix it and make it work on 32 bits.
> Is the error, on Xenomai side, or moreover kernel patched ?
> Which kernel / Xenomai latest versions were running on 32 bits for sure, =
or at what time ?

I can't really speak for Xenomai 4, but yes, to some degree it's a
"reboot", not caring too much about legacy. The API is also different -
basically no skins (posix, alchemy, ...) - so you would have to migrate
anyhow.

32 bit kernels pre-date my Xenomai 3 involvement, so maybe Jan (now in
CC) can comment on that.

The announcement that 32 bit kernels are out of scope must have
happened at least 4 years ago... Not sure if someone can say how much
effort it would be to re-add support for those.=C2=A0Have you tried it
already?

The main driver behind the discontinuity was most likely the
maintenance effort. At least Philippe would need more efforts to
maintain the Dovetail API for that architecture. My assumption is that
without additional help it's unlikely that this will happen.

Feel free to bring that topic into one of our next community calls. We
might discuss your problem and let's see, maybe we can help somehow.

>=20
> Thanks again,
> Marc.
>=20
>=20

