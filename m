Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDC1329384
	for <xenomai@lists.linux.dev>; Mon, 15 Dec 2025 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765794304; cv=none; b=Z2lC4Pm6rzJnlW1Y415uOqFeflW6UBh0di0loQGzEQrhLUQ6bbaYgKjM8dvMn6GWRt8eLvkHHWPmSBeekq+Q+gZxJZ0hLlrMk0BmIXk6I1YiKTStvxRveu2NojJIEBHZtiAwPOMhqzHfbA8K0dWrR7SQQn+kfiEBtZXnJ3mpUz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765794304; c=relaxed/simple;
	bh=Y34ZjUvBAYoxmUq8O7hSmpSLQmCtwNgF7YvuaP3PsGc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fBd0/8C3nVv5q2nCpezrudILoraceqzdazfdRVFrmJ6mH8D7DZaGfxT75EVC2lCPRkvxivdZm5Ogj7w6FfLqeprL/9t0Cx2mi92SMtBRkAuja6Ia6KgtsUloSn1UkEmxOeMEOsp845k5fU65W/Xp02t1bx6fLE4iB3wRxHW9IKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=QVTF0pJ3; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="QVTF0pJ3"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251215102450b74ccaaf74000207fe
        for <xenomai@lists.linux.dev>;
        Mon, 15 Dec 2025 11:24:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=CAzyoHyibYj+CfK/Je9QR0beMmVqvewurZVTR952D4Q=;
 b=QVTF0pJ35od76vi4FdQgqiPpBx5nQk/I0THopEKM0I7glVi1kWJiZBlcFAo1PeFfy9xSpq
 +ZsMb63uQYABf+zPB8/GHtS/Z1G8LUGfEy9zvvHj2m/M4hINbcpLPErM5sf21pxKIMozers+
 NQwJamAkfxk9RfkWGFO4jo19nEeOi6X+9WbVaiyUrsE+cd6ctcNClT9hffAazATXHOxyn14I
 x0BpgvZP3wr/E7i3iI8nOHm2NOXZyUJ7F1HWYlUizOWLTS+i/x1Jdxtnkp3qMtnGzNyd5bbs
 rEWfOBm/EBwaE1I+zm0UZo7mSVhuKLYr7pay1bhoY8uwPUk5nmS4Zb5Q==;
Message-ID: <de9afb9abf9358ef89f961f95c4bd6e8c19695d7.camel@siemens.com>
Subject: Re: [PATCH 2/6] y2038: lib/cobalt: select: Fix timeout writeback of
 the compat time64_t case
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Andreas Ziegler <ziegler.andreas@siemens.com>
Date: Mon, 15 Dec 2025 11:24:49 +0100
In-Reply-To: <771a9041-5c1b-4ede-b44e-37a0712ad5a5@siemens.com>
References: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
	 <20251204-flo-fix-select-syscall-v1-2-7f9c545a63ce@siemens.com>
	 <771a9041-5c1b-4ede-b44e-37a0712ad5a5@siemens.com>
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

On Mon, 2025-12-15 at 08:02 +0100, Jan Kiszka wrote:
> On 05.12.25 10:03, Florian Bezdeka wrote:
> > The kernel might modify the timeout parameter. As we have to convert
> > from struct timeval (user) to struct timespec (kernel, pselect) the
> > updated value was hidden from the user.
> >=20
> > Fixes: c2b883446b80 ("y2038: lib/cobalt: Implement necessary wrappers f=
or y2038 support")
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  lib/cobalt/select.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
> > index 611994d17..4a44b4fc1 100644
> > --- a/lib/cobalt/select.c
> > +++ b/lib/cobalt/select.c
> > @@ -57,6 +57,11 @@ static inline int do_select(int __nfds, fd_set *__re=
strict __readfds,
> > =20
> >  	pthread_setcanceltype(oldtype, NULL);
> > =20
> > +	if (__timeout) {
> > +		__timeout->tv_sec =3D to.tv_sec;
> > +		__timeout->tv_usec =3D to.tv_nsec / 1000;
> > +	}
> > +
>=20
> I think we can skip the above if the branch below is taken - small
> optimization for the forwarded case.

Not sure. What should the fallback to std(select) actually see? The
original user provided timeout? As we have that fallback twice (this is
the one for the compat but y2038 support enabled case) we should do it
the same way.

I'm not expecting cobalt to update / write the timeout while returning
an error for the same call, so both ways should be OK but maybe
confusing when comparing the two do_select() implementations.

>=20
> >  	if (err =3D=3D -EADV || err =3D=3D -EPERM || err =3D=3D -ENOSYS)
> >  		err =3D __STD(__select64(__nfds, __readfds, __writefds,
> >  				       __exceptfds, __timeout));
> >=20
>=20
