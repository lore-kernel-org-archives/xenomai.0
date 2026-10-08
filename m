Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D6849890E
	for <xenomai@lists.linux.dev>; Thu,  8 Oct 2026 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791465260; cv=none; b=MOcRRB3hPuASK4xcP0w0vDMC/xH1Nn9eXzp+VVxcGd7DBnwmL929Wd5NqtznX4qyfL85VJmJEPOGcb5iFrQsDTkujYXBQG2JCO2OkRuIkRpZzKzwrvoXqJmGj//nLcNju6I9S5F++L6Ky5HXfdmNUOuS5az3GCT7aJKdlf4HUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791465260; c=relaxed/simple;
	bh=kNDFr7r8V8u8udUQb59lj3bbqGd+ZSI+EjybfpS3ryE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LClaogDu5ZaGOyb4asCGzHZlVCBIn3O5OikeLBijdMrtDjcnf1xNdcGi0rootlV6rfEpjm95P7Tr0XcE7VeaeRLUYLWWApC/LqjfLnG7YU0qUfmWVeYW3vWDdmUgeZF6oetJZ46IpsXBZCNCqSh71rCpJDHQ7f05Us7oEjb3Hpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=e7bPAhKS; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="e7bPAhKS"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202610081314066f63a66363000207cd
        for <xenomai@lists.linux.dev>;
        Thu, 08 Oct 2026 15:14:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=TKH1GPEtiMAmvOYdt7LPSAvAmLQqBalGaV9TA0SFeqA=;
 b=e7bPAhKSPW/FA/qRz/xqNHgkRT3HQgKrztdYRmLgbFn2oAvaSnATgX5n96PK3vMYuLJaEr
 CPpcthI98MBHYc+Qqmb4H3lW0ZfpQoadUa3wuY4BHTSWIHMvCcJe/3f+k83RoCigtAa9ChzA
 yTB0Kr24unq478yOGumZ4qH47i47FzjRABvMWj/NGfdwYWkkO9s39XwJB9/lGe4ybT1Sw7la
 1vXotOh/OviRMMkwyzZA7bCERphvH55caBawzjtHe0r4tqgXnzcxHVX4Gn2y6m/uqKxCaEfC
 FTWzv2/h+fAlVJfdqhxaNvr/TRT1TnZgNHaYoxZAN+r0tDVwgdG9u9rQ==;
Message-ID: <33a2d74603987c026bbe1a6647b8d74b846fad38.camel@siemens.com>
Subject: Re: [patch] fixed missing time64 wrappers
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, =?ISO-8859-1?Q?Fran=E7ois?= Legal
	 <francois.legal@eventlab.fr>, xenomai@lists.linux.dev
Date: Thu, 08 Oct 2026 15:14:06 +0200
In-Reply-To: <c67f0cec-7fb4-4600-8652-b501b56891a8@siemens.com>
References: <1208-6ac76700-4b-2c92e940@166990483>
	 <c67f0cec-7fb4-4600-8652-b501b56891a8@siemens.com>
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

On Thu, 2026-10-08 at 14:33 +0200, Jan Kiszka wrote:
> On 08.10.26 11:48, Fran=C3=A7ois Legal wrote:
> > There are missing wrappers for 64 bits time in xenomai 3.3 :
> > - __recvmsg64
> > - __sendmsg64
> > - __sendmmsg64
> >=20
>=20
> Hmm, where do these functions carry a timeout? I thought they only do
> implicitly, set upfront via socket options? But maybe is still too early
> for me today.

Something like that is the problem:

recvmsg(fd, &msghdr, flags)
            |
            +-- msg_control ------> ancillary data
                                  |
                                  +-- SCM_TIMESTAMP
                                  +-- SCM_TIMESTAMPNS
                                  +-- SCM_TIMESTAMPING

That "nesting" is quite likely the problem why I initially missed it.

I have to look into the details again. Most likely a separate syscall or
a different routing of the syscall might be necessary. IOW this patch
might be incomplete.

>=20
> Jan
>=20
> > Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
> > ---
> > diff --git a/lib/cobalt/cobalt-glibc-time64.wrappers b/lib/cobalt/cobal=
t-glibc-time64.wrappers
> > index 0bf895ca9..483a8ce24 100644
> > --- a/lib/cobalt/cobalt-glibc-time64.wrappers
> > +++ b/lib/cobalt/cobalt-glibc-time64.wrappers
> > @@ -8,7 +8,10 @@
> > =C2=A0 --wrap __mq_timedsend_time64
> > =C2=A0 --wrap __mq_timedreceive_time64
> > =C2=A0 --wrap __sigtimedwait64
> > +--wrap __recvmsg64
> > =C2=A0 --wrap __recvmmsg64
> > +--wrap __sendmsg64
> > +--wrap __sendmmsg64
> > =C2=A0 --wrap __pthread_cond_timedwait64
> > =C2=A0 --wrap __timer_settime64
> > =C2=A0 --wrap __timer_gettime64
> > diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
> > index 00c1aaf4b..264de8ace 100644
> > --- a/lib/cobalt/rtdm.c
> > +++ b/lib/cobalt/rtdm.c
> > @@ -254,7 +254,7 @@ static ssize_t do_recvmsg(int fd, struct msghdr *ms=
g, int flags)
> > =C2=A0=C2=A0	return ret;
> > =C2=A0 }
> > =C2=A0=20
> > -COBALT_IMPL(ssize_t, recvmsg, (int fd, struct msghdr *msg, int flags))
> > +COBALT_IMPL_TIME64(ssize_t, recvmsg, __recvmsg64, (int fd, struct msgh=
dr *msg, int flags))
> > =C2=A0 {
> > =C2=A0=C2=A0	int ret;
> > =C2=A0=20
> > @@ -301,7 +301,7 @@ static ssize_t do_sendmsg(int fd, const struct msgh=
dr *msg, int flags)
> > =C2=A0=C2=A0	return ret;
> > =C2=A0 }
> > =C2=A0=20
> > -COBALT_IMPL(ssize_t, sendmsg, (int fd, const struct msghdr *msg, int f=
lags))
> > +COBALT_IMPL_TIME64(ssize_t, sendmsg, __sendmsg64, (int fd, const struc=
t msghdr *msg, int flags))
> > =C2=A0 {
> > =C2=A0=C2=A0	int ret;
> > =C2=A0=20
> > @@ -312,7 +312,7 @@ COBALT_IMPL(ssize_t, sendmsg, (int fd, const struct=
 msghdr *msg, int flags))
> > =C2=A0=C2=A0	return __STD(sendmsg(fd, msg, flags));
> > =C2=A0 }
> > =C2=A0=20
> > -COBALT_IMPL(int, sendmmsg, (int fd, struct mmsghdr *msgvec,
> > +COBALT_IMPL_TIME64(int, sendmmsg, sendmmsg64, (int fd, struct mmsghdr =
*msgvec,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0 unsigned int vlen, unsigned int flags=
))
> > =C2=A0 {
> > =C2=A0=C2=A0	int ret, oldtype;
> >=20
> >=20
>=20
>=20
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
