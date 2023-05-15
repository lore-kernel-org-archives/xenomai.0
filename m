Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11799A92A
	for <xenomai@lists.linux.dev>; Mon, 15 May 2023 09:31:41 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202305150931313c936820ed63294416
        for <xenomai@lists.linux.dev>;
        Mon, 15 May 2023 11:31:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=dlXdEIqU8ZnLDz3M7DAspFllmnWIiATdfolW0FEHaTM=;
 b=oO7KiZO6K+u6bKGODIG5rP6ykwp0mPf4URuWcoVJDfN5a+Uo4lHnTIz9u7qKPpwx7hQryv
 tr/TKGCp2ZDlbZdvGIWv4zB0nmtiKyuDZF8LXPzBQSDE1CMZu2IXnWF0DJ2E++YLeK1wCN8c
 Rh88x3cQHgyOHxIHYUC5Avtafou6c=;
Message-ID: <f70f996b4840b61fb3b6d2829b4a400ae8f9db40.camel@siemens.com>
Subject: Re: [PATCH 01/13] y2038: cobalt: Introduce some itimerspec64
 related helpers
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Mon, 15 May 2023 11:31:31 +0200
In-Reply-To: <9693dc1a-1606-652b-29a8-8f1a23b9cdbd@siemens.com>
References: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
	 <20230508-florian-y2038-part-two-v1-1-a417812fba85@siemens.com>
	 <9693dc1a-1606-652b-29a8-8f1a23b9cdbd@siemens.com>
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

On Fri, 2023-05-12 at 17:59 +0200, Jan Kiszka wrote:
> On 08.05.23 10:13, Florian Bezdeka wrote:
> > The introduced helpers will be used by the timer and timerfd y2038
> > related services for reading/writing itimerspec from/to userspace.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  include/cobalt/kernel/time.h | 21 +++++++++++++++++++++
> >  kernel/cobalt/time.c         | 38 ++++++++++++++++++++++++++++++++++++=
++
> >  2 files changed, 59 insertions(+)
> >=20
> > diff --git a/include/cobalt/kernel/time.h b/include/cobalt/kernel/time.=
h
> > index a55398068..e348cf9b8 100644
> > --- a/include/cobalt/kernel/time.h
> > +++ b/include/cobalt/kernel/time.h
> > @@ -28,4 +28,25 @@ int cobalt_get_timespec64(struct timespec64 *ts,
> >  int cobalt_put_timespec64(const struct timespec64 *ts,
> >  			  struct __kernel_timespec __user *uts);
> > =20
> > +/**
> > + * Read struct __kernel_itimerspec from userspace and convert to
> > + * struct itimerspec64
> > + *
> > + * @param dst The destination, will be filled
> > + * @param src The source, provided by an application
> > + * @return 0 on success, -EFAULT otherwise
> > + */
> > +int cobalt_get_itimerspec64(struct itimerspec64 *dst,
> > +			    const struct __kernel_itimerspec __user *src);
> > +
> > +/**
> > + * Convert struct itimerspec64 to struct __kernel_itimerspec and copy =
to user
> > + * space
> > + * @param dst The destination, will be filled, provided by an applicat=
ion
> > + * @param src The source, provided by the kernel
> > + * @return 0 un success, -EFAULT otherwise
> > + */
> > +int cobalt_put_itimerspec64(struct __kernel_itimerspec __user *dst,
> > +			    const struct itimerspec64 *src);
> > +
> >  #endif //_COBALT_KERNEL_TIME_H
> > diff --git a/kernel/cobalt/time.c b/kernel/cobalt/time.c
> > index 27dbf8290..716223dc5 100644
> > --- a/kernel/cobalt/time.c
> > +++ b/kernel/cobalt/time.c
> > @@ -36,3 +36,41 @@ int cobalt_put_timespec64(const struct timespec64 *t=
s,
> > =20
> >  	return cobalt_copy_to_user(uts, &kts, sizeof(kts)) ? -EFAULT : 0;
> >  }
> > +
> > +int cobalt_get_itimerspec64(struct itimerspec64 *dst,
> > +			    const struct __kernel_itimerspec __user *src)
> > +{
> > +	struct timespec64 interval, value;
> > +	int ret;
> > +
> > +	if (!src)
>=20
> Can that be enough to validate the pointer? Or is it even needed? We
> must validate it via cobalt_get_timespec64 anyway, no?

I think we could remove this check but it improves the readability (and
code flow) a lot.=20

Without this check cobalt_get_timespec64 (called below) would trigger a
fault while reading from this address when src is NULL. (&src->it_* is
a low offset). The result is basically the same but we would migrate to
seconary domain first, handle the fault there and then exit to
userspace. No?

Florian

>=20
> > +		return -EFAULT;
> > +
> > +	ret =3D cobalt_get_timespec64(&interval, &src->it_interval);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D cobalt_get_timespec64(&value, &src->it_value);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dst->it_interval.tv_sec =3D interval.tv_sec;
> > +	dst->it_interval.tv_nsec =3D interval.tv_nsec;
> > +	dst->it_value.tv_sec =3D value.tv_sec;
> > +	dst->it_value.tv_nsec =3D value.tv_nsec;
> > +
> > +	return 0;
> > +}
> > +
> > +int cobalt_put_itimerspec64(struct __kernel_itimerspec __user *dst,
> > +			    const struct itimerspec64 *src)
> > +{
> > +	struct __kernel_itimerspec kits =3D {
> > +		.it_interval.tv_sec =3D src->it_interval.tv_sec,
> > +		.it_interval.tv_nsec =3D src->it_interval.tv_nsec,
> > +		.it_value.tv_sec =3D src->it_value.tv_sec,
> > +		.it_value.tv_nsec =3D src->it_value.tv_nsec
> > +	};
> > +
> > +	return cobalt_copy_to_user(dst, &kits, sizeof(kits));
> > +}
> >=20
>=20
> Jan
>=20

