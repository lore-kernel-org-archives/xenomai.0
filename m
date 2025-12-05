Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57037283C83
	for <xenomai@lists.linux.dev>; Fri,  5 Dec 2025 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764936464; cv=none; b=aUipTNJmMPEsGee2o/PFY+XK/LNGlNFoK2+3borPhOD5ALAqjnvmVBpUk/j/cwVnkdtrP34Hp1g98Qe/1Y1NA+NI+DLFjrmXFCR4qIMaT05Yw+/5otFz8Orj5nZciwn63sjwJ55n4F3+d3fL2BOOxZ6GHhVj+WMgMyJfk2Sa8Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764936464; c=relaxed/simple;
	bh=4jvmcMSuenVf0cEYYx9Cx5vuA7SISZLzRhwAIpHlzpM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uu6NcRL+Ht5DaWyb2K1RNLQ3zV8yz5IsJtJh9un8yZviwKZZwt9tscKM4O/bcEDcx05w0v5Ad9gsiIcGwI26fnsQyRU3bgG6B2JA8vgfTqclxD51A/ks4Im4lDB5CAWUxFYoyyQXBjX9iz0tZZc/TXU69ttdAVu1FDFxvAIX21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=hsNjzKB2; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="hsNjzKB2"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251205120731295bec5227000207f3
        for <xenomai@lists.linux.dev>;
        Fri, 05 Dec 2025 13:07:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=GhCZ9EaS2I5/9nxWZACqWwJRUDI+1D/fUqWna0gqMe4=;
 b=hsNjzKB2A7RFGAT2jqgTfiDE/QVLyFiCFIIMTMLiOlF9PVF4WInMuU7X6cVM4x3/Ohtrpw
 htbMohpSRDJkNyfY5xw/kIiV9SMM9h12ER9nTQRI5hmK/HyEDgBSjCJiVvMHu++oDfEqv1rP
 QvZzKwxzFocJeAn2IFXppXoImO7WGCMz25ByvCYyAy+3r/0BHBFSmHP/GbfY5goOqW9N7sGZ
 fet+T0Wcpxl/Pr5fOfZXWJHBqVWN6K4w/aj4/O+trOI6iWrpulz/GgjXwi3T3m0+Y/dVuF1s
 +CZyq7Sjfa40ZRriCO+G2LhLhuaP/e/n2PW00YngGnm91m6PyTyRtbaA==;
Message-ID: <75bc6a2a955a995d58752e24c30b995656ab7f7c.camel@siemens.com>
Subject: Re: [PATCH 1/6] y2038: lib/cobalt: select: Normalize timeout value
 in the y2038 case
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Andreas Ziegler <ziegler.andreas@siemens.com>
Date: Fri, 05 Dec 2025 13:07:31 +0100
In-Reply-To: <f651ef6a-011e-4054-a847-86ec857188c1@siemens.com>
References: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
	 <20251204-flo-fix-select-syscall-v1-1-7f9c545a63ce@siemens.com>
	 <f651ef6a-011e-4054-a847-86ec857188c1@siemens.com>
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

On Fri, 2025-12-05 at 12:28 +0100, Jan Kiszka wrote:
> On 05.12.25 10:03, Florian Bezdeka wrote:
> > Andreas discovered a difference in the timeout value handling between
> > the native and compat + time64_t (=3D y2038 support) cases.
> >=20
> > The time64_t based select() service is internally routed to the
> > pselect() service. Linux does a normalization step for the timeout
> > values of select() and so does cobalt. Both, Linux and cobalt skip this
> > step for the pselect() syscall. That means that we were missing one
> > normalization step for select() in the y2038 case.
> >=20
> > Reported-by: Andreas Ziegler <ziegler.andreas@siemens.com>
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  lib/cobalt/select.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
> > index be8cf34b2..611994d17 100644
> > --- a/lib/cobalt/select.c
> > +++ b/lib/cobalt/select.c
> > @@ -22,6 +22,10 @@
> >  #include <asm/xenomai/syscall.h>
> > =20
> >  #if __USE_TIME_BITS64 && __TIMESIZE =3D=3D 32
> > +
> > +#define USEC_PER_SEC	1000000L
> > +#define NSEC_PER_USEC	1000L
> > +
> >  /*
> >   * The time64 wrapper for select() is a little different:
> >   * There is no y2038 safe syscall for select() itself, but we have pse=
lect()
> > @@ -36,8 +40,10 @@ static inline int do_select(int __nfds, fd_set *__re=
strict __readfds,
> >  	int err, oldtype;
> > =20
> >  	if (__timeout) {
> > -		to.tv_sec =3D __timeout->tv_sec;
> > -		to.tv_nsec =3D __timeout->tv_usec * 1000;
> > +		to.tv_sec =3D
> > +			__timeout->tv_sec + (__timeout->tv_usec / USEC_PER_SEC);
>=20
> Where would an overrun of tv_usec come from, only from userland? Does
> posix permit that and does not require us to reject it?
>=20

Yes, the application might provide that.
POSIX doesn't mention something like the normalization. Linux does it
since

4d36a9e65d49 ("select: deal with math overflow from borderline valid userla=
nd data")

which was part of 2.6.28-rc2. There is a "was already supported by older
kernels" reasoning behind, so I assume this was basically "since ever".

Florian

>=20
> > +		to.tv_nsec =3D
> > +			(__timeout->tv_usec % USEC_PER_SEC) * NSEC_PER_USEC;
> >  	}
> > =20
> >  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
> >=20
>=20
> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center
