Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BDAC8EA
	for <xenomai@lists.linux.dev>; Thu, 27 Jul 2023 16:06:35 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230727155618461e7728826d34922f
        for <xenomai@lists.linux.dev>;
        Thu, 27 Jul 2023 17:56:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=xVdFFOROwvktiOHXWFflmtkPIpCjRHKh98pBV4FboYU=;
 b=VOKTLb7cd0CGe+l6OuReywA7gspv3XPfRR2goKhDhm/t5RGvpKqQHyOJ1/vHF1SA7Hpqkd
 faAjBN1xcUm08V3XOruH+Sh/qcopB4+K56quph3JBzzdP1O7AdIqhBydBp+SSh8/9OWKd4R6
 LSG28TYL+3GQ1Mxr9rChGktlkoY9A=;
Message-ID: <0a144aa18a10aa1fc9198db540232988a447100f.camel@siemens.com>
Subject: Re: [PATCH v2 1/4] cobalt/posix/syscall32: Remove unused
 mq_fetch_timeout
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Thu, 27 Jul 2023 17:56:17 +0200
In-Reply-To: <cc04e011-056c-08ef-57d9-57c14c6a6758@siemens.com>
References: 
	<20230630-florian-y2038-part-four-upstreaming-v2-0-b4e888eca2d9@siemens.com>
	 <20230630-florian-y2038-part-four-upstreaming-v2-1-b4e888eca2d9@siemens.com>
	 <cc04e011-056c-08ef-57d9-57c14c6a6758@siemens.com>
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

On Thu, 2023-07-20 at 18:37 +0200, Jan Kiszka wrote:
> On 17.07.23 11:10, Florian Bezdeka wrote:
> > Removal of unused (and broken) code. Using cobalt_get_u_timespec would
> > have been wrong and sys32_fetch_timespec would have been correct.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  kernel/cobalt/posix/syscall32.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >=20
> > diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/sysc=
all32.c
> > index 780d276b1..c82cc60a2 100644
> > --- a/kernel/cobalt/posix/syscall32.c
> > +++ b/kernel/cobalt/posix/syscall32.c
> > @@ -318,12 +318,6 @@ COBALT_SYSCALL32emu(mq_timedreceive64, primary,
> >  	return ret ?: cobalt_copy_to_user(u_len, &clen, sizeof(*u_len));
> >  }
> > =20
> > -static inline int mq_fetch_timeout(struct timespec64 *ts,
> > -				   const void __user *u_ts)
> > -{
> > -	return u_ts =3D=3D NULL ? -EFAULT : cobalt_get_u_timespec(ts, u_ts);
> > -}
> > -
> >  COBALT_SYSCALL32emu(mq_notify, primary,
> >  		    (mqd_t fd, const struct compat_sigevent *__user u_cev))
> >  {
> >=20
>=20
> Applying this cleanup already.

That's not yet visible on source.denx.de. Missing git push?

Regards,
Florian

>=20
> Thanks,
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

