Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77726324B33
	for <xenomai@lists.linux.dev>; Fri,  9 Oct 2026 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584962; cv=none; b=BoycLHWExbBaEdq+4nwxY06rb9FwyAm5mgOudhcRGPpvEEM/SCNtR4wR34vsxVLCiCTiWka+7mL4bl4VcaPROxBvaSRU59ttRtxWSwCEmz9TOWrX8vBtQvU0MeloeEfgGSJp245OfTMVqomXUZ4QIZcerE2XiQnum9Y8+GI2eQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584962; c=relaxed/simple;
	bh=qqIxcLV5KqjTHRrw0UPwkuZK1/MiO/2QFQ/tAIrsPU0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iywMsPKLZcPZAnBp716nVefjTjX8kfZ+gUjaRZFgLmMLTBehibvh6dwrYDXvX5uV/e5gxfY92wrvRtC8XWnPrudf3NMdsOx1FYvmfYN+SC3J93V3kgZ0Kjf2VjK+AKuU9Fge345hap563ziR/kO2oUp96YTju0C0l+MMCa2UA3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=XGGvBufa; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="XGGvBufa"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20261009222908b5e1bef7c80002072e
        for <xenomai@lists.linux.dev>;
        Sat, 10 Oct 2026 00:29:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qePFf+gsPpl8pTkz21Y+q4rCucALBVKuS7nQWQYIyaM=;
 b=XGGvBufa7wTGlA583cIzgQQf8S2RYCRDfm5tkP0RbDwimcJwETRjwNteSiczz/PpTN28A+
 ShSpr21moAM/phRhHCI5lQJGmb8kVhsShPRZIWZ8N9HvUYfUkwDjZDkBFiNeZDnTRR9z1+8+
 2uPx8mb+m26wN7/cCZjev13D25b1bIQZtLcmyaoJYVBqqLivwdklmZ493hPsC4ZQuoMDBFtR
 ogSrBqHFjnWtY7XIczZwoSWzF7cdNaqOeWGlo4mj9rpCnQNENlwt6+WGHtAtkqUsP0jKW3RT
 vRCeyA5L1n6Jy8D+qjvVIV2F+76L0aBTPI/aaJScdaDcNTk3728aEmwg==;
Message-ID: <aebe55c45cd9bcdcb9d43371136047325bd5b89c.camel@siemens.com>
Subject: Re: [patch] fixed missing time64 wrappers
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?ISO-8859-1?Q?Fran=E7ois?= Legal <francois.legal@eventlab.fr>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Sat, 10 Oct 2026 00:29:07 +0200
In-Reply-To: <1207-6ac79a00-41-3e404bc0@80344945>
References: <1207-6ac79a00-41-3e404bc0@80344945>
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

On Thu, 2026-10-08 at 15:27 +0200, Fran=C3=A7ois Legal wrote:
> Le Jeudi, Octobre 08, 2026 15:14 CEST, Florian Bezdeka <florian.bezdeka@s=
iemens.com> a =C3=A9crit:=20
> =C2=A0
> > On Thu, 2026-10-08 at 14:33 +0200, Jan Kiszka wrote:
> > > On 08.10.26 11:48, Fran=C3=A7ois Legal wrote:
> > > > There are missing wrappers for 64 bits time in xenomai 3.3 :
> > > > - __recvmsg64
> > > > - __sendmsg64
> > > > - __sendmmsg64
> > > >=20
> > >=20
> > > Hmm, where do these functions carry a timeout? I thought they only do
> > > implicitly, set upfront via socket options? But maybe is still too ea=
rly
> > > for me today.
> >=20
> > Something like that is the problem:
> >=20
> > recvmsg(fd, &msghdr, flags)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 +-- msg_control ------> ancillary data
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-- SCM_TIMEST=
AMP
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-- SCM_TIMEST=
AMPNS
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-- SCM_TIMEST=
AMPING
> >=20
>=20
> I thought about that too (and I might be the one who contributed the patc=
h to bring timestamping events IIRC) but it happens that the values returne=
d in these ancillary data are in the form of a 64 bits integer which unity =
is a nanosecond, so we don't really care about time64 here.
>=20
> At least that's my understanding.

I agree, the only socket option that will write into msghdr.msg_control
is RTCAN_RTIOC_TAKE_TIMESTAMP, where we always copy RTCAN_TIMESTAMP_SIZE
(=3D 64) bits.

That information should make it into the patch description as it
explains why we can route the time64 service to the "native" time_t
syscall.

In addition, please note the formatting comment below at the code.

I'm wondering why RTDM introduces a separate socket option here. It
could have used SO_TIMESTAMP like we use SO_RCVTIMEO and SO_SNDTIMEO to
keep it driver independent. No? I assume we won't change that because of
backward compatibility anymore?


>=20
> Fran=C3=A7ois
>=20
> > That "nesting" is quite likely the problem why I initially missed it.
> >=20
> > I have to look into the details again. Most likely a separate syscall o=
r
> > a different routing of the syscall might be necessary. IOW this patch
> > might be incomplete.
> >=20
> > >=20
> > > Jan
> > >=20
> > > > Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
> > > > ---
> > > > diff --git a/lib/cobalt/cobalt-glibc-time64.wrappers b/lib/cobalt/c=
obalt-glibc-time64.wrappers
> > > > index 0bf895ca9..483a8ce24 100644
> > > > --- a/lib/cobalt/cobalt-glibc-time64.wrappers
> > > > +++ b/lib/cobalt/cobalt-glibc-time64.wrappers
> > > > @@ -8,7 +8,10 @@
> > > > =C2=A0 --wrap __mq_timedsend_time64
> > > > =C2=A0 --wrap __mq_timedreceive_time64
> > > > =C2=A0 --wrap __sigtimedwait64
> > > > +--wrap __recvmsg64
> > > > =C2=A0 --wrap __recvmmsg64
> > > > +--wrap __sendmsg64
> > > > +--wrap __sendmmsg64
> > > > =C2=A0 --wrap __pthread_cond_timedwait64
> > > > =C2=A0 --wrap __timer_settime64
> > > > =C2=A0 --wrap __timer_gettime64
> > > > diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
> > > > index 00c1aaf4b..264de8ace 100644
> > > > --- a/lib/cobalt/rtdm.c
> > > > +++ b/lib/cobalt/rtdm.c
> > > > @@ -254,7 +254,7 @@ static ssize_t do_recvmsg(int fd, struct msghdr=
 *msg, int flags)
> > > > =C2=A0=C2=A0	return ret;
> > > > =C2=A0 }
> > > > =C2=A0=20
> > > > -COBALT_IMPL(ssize_t, recvmsg, (int fd, struct msghdr *msg, int fla=
gs))
> > > > +COBALT_IMPL_TIME64(ssize_t, recvmsg, __recvmsg64, (int fd, struct =
msghdr *msg, int flags))

Those lines are too long now. clang-format will re-format to

COBALT_IMPL_TIME64(ssize_t, recvmsg, __recvmsg64,
		   (int fd, struct msghdr *msg, int flags))

and similar.

> > > > =C2=A0 {
> > > > =C2=A0=C2=A0	int ret;
> > > > =C2=A0=20
> > > > @@ -301,7 +301,7 @@ static ssize_t do_sendmsg(int fd, const struct =
msghdr *msg, int flags)
> > > > =C2=A0=C2=A0	return ret;
> > > > =C2=A0 }
> > > > =C2=A0=20
> > > > -COBALT_IMPL(ssize_t, sendmsg, (int fd, const struct msghdr *msg, i=
nt flags))
> > > > +COBALT_IMPL_TIME64(ssize_t, sendmsg, __sendmsg64, (int fd, const s=
truct msghdr *msg, int flags))
> > > > =C2=A0 {
> > > > =C2=A0=C2=A0	int ret;
> > > > =C2=A0=20
> > > > @@ -312,7 +312,7 @@ COBALT_IMPL(ssize_t, sendmsg, (int fd, const st=
ruct msghdr *msg, int flags))
> > > > =C2=A0=C2=A0	return __STD(sendmsg(fd, msg, flags));
> > > > =C2=A0 }
> > > > =C2=A0=20
> > > > -COBALT_IMPL(int, sendmmsg, (int fd, struct mmsghdr *msgvec,
> > > > +COBALT_IMPL_TIME64(int, sendmmsg, sendmmsg64, (int fd, struct mmsg=
hdr *msgvec,
> > > > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0 unsigned int vlen, unsigned int f=
lags))
> > > > =C2=A0 {
> > > > =C2=A0=C2=A0	int ret, oldtype;
> > > >=20
> > > >=20
> > >=20
> > >=20
> > > --
> > > Siemens AG, Foundational Technologies
> > > Linux Expert Center
