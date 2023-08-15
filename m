Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC42AD2E
	for <xenomai@lists.linux.dev>; Tue, 15 Aug 2023 09:18:49 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230815091841aaa861e16af6beeff1
        for <xenomai@lists.linux.dev>;
        Tue, 15 Aug 2023 11:18:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=bcU8j3Q4TV0GomtS9tKvuKbSnq5KfsZrwp4PloPT+Yk=;
 b=YYpJ3yqD8x7Td+M1uBLCOf7svfdoaVmVjtxaDhvnlZg9pMYK9tkFdgWWjC5UKblPKWGBnT
 v0DwYki9Cm5NLGr/a+deHvnEu3xwbjTwLBsPPh3JHn2wlWMnow2BU7kKcqo2fRWGyB5Hb8d8
 T+lwcBnFmYOo/NU0CXDsbexZXJgEw=;
Message-ID: <25c7a62ec45c0654857c5576dd4b23d440a403b1.camel@siemens.com>
Subject: Re: [PATCH 7/7] y2038: lib/cobalt/select: Fix __RT(select()) routing
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Tue, 15 Aug 2023 11:18:40 +0200
In-Reply-To: <39aa20a7-e1ff-4335-96c5-3df0a487cf85@siemens.com>
References: <20230809-florian-y2038-2-v1-0-d1cfe2f394a3@siemens.com>
	 <20230809-florian-y2038-2-v1-7-d1cfe2f394a3@siemens.com>
	 <39aa20a7-e1ff-4335-96c5-3df0a487cf85@siemens.com>
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

On Fri, 2023-08-11 at 17:07 +0200, Jan Kiszka wrote:
> On 11.08.23 09:37, Florian Bezdeka wrote:
> > Some parts of the testsuite use the __RT() macro to make clear that the
> > Xenomai implementation is called instead of the Linux service.
> >=20
> > Code:
> >   __RT(select(...)
> >=20
> > Result after preprocessor:
> >   __cobalt_select(...)
> >=20
> > In case y2038 support has been requested (default) by 32 bit
> > applications the Xenomai select() implementation will be called instead
> > of the __select64(). Catch that case and wire it up to our limited
> > pselect64() implementation.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  lib/cobalt/select.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >=20
> > diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
> > index 7727012c7..d2897066b 100644
> > --- a/lib/cobalt/select.c
> > +++ b/lib/cobalt/select.c
> > @@ -27,6 +27,20 @@ COBALT_IMPL(int, select, (int __nfds, fd_set *__rest=
rict __readfds,
> >  			  fd_set *__restrict __exceptfds,
> >  			  struct timeval *__restrict __timeout))
> >  {
> > +#if __USE_TIME_BITS64
> > +	/* Might be called by __RT(select()) only. select() - without __RT() =
-
> > +	 * will be redirected to __select64(). Catch that special case here a=
nd
> > +	 * forward it to our __select64() wrapper - which might be overwritte=
n
> > +	 * by application code.
> > +	 */
> > +	int __wrap___select64(int __nfds, fd_set *__restrict __readfds,
> > +			      fd_set *__restrict __writefds,
> > +			      fd_set *__restrict __exceptfds,
> > +			      struct timeval *__restrict __timeout);
> > +
> > +	return __wrap___select64(__nfds, __readfds, __writefds, __exceptfds,
> > +				 __timeout);
>=20
> Rather than taking a real call, can't we define a symbol alias?

I tried but gave up after some hours ;-)

It has been some time, but some details I can remember:

The header where we publish the necessary wrappers for select() is
included by some libc headers, sys/types.h for example. When we start
working with aliases (__attribute__((alias(cname)))) we have to make
sure that the target symbol can be found. Otherwise we will end up with
"aliased to undefined symbol" compiler errors.

Compile units that use this header but do not directly contain the
implementation coming from wrappers-time64.c will fail to build - even
if they never call select().

We have at least lib/boilerplate/bootstrap.c that can no longer be
build. The same could happen to user applications.

If you have any idea how to fix this: Let me know.

Florian

>=20
> > +#else
> >  	int err, oldtype;
> > =20
> >  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
> > @@ -45,4 +59,5 @@ COBALT_IMPL(int, select, (int __nfds, fd_set *__restr=
ict __readfds,
> > =20
> >  	errno =3D -err;
> >  	return -1;
> > +#endif
> >  }
> >=20
>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

