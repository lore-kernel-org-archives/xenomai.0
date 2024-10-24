Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044CF1B2184
	for <xenomai@lists.linux.dev>; Thu, 24 Oct 2024 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757253; cv=none; b=V8sKCwwAnzMk0kcGkPqGy+cHIuO/0oerQdHprdIm+yBVhn3QCdNRIVJSeo9QH3DHRFgRgrYNv61esPWGXXqM4nUbfq4owDvrK+UfaVUY+LuEsv8Yp8IWcLvAUXZJvtYw37G+JhDWajwkMlXXcpMizq5oMBv6gS/3ABwBGQsSNaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757253; c=relaxed/simple;
	bh=WHfX4UG1Z5gCclIyX0IIcBM3ge9VK/5bD+7CoK3nBQE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IxnlwlHYMi6l9YxM9gTAkuMyRfE+J/u6fLGOLBUr++mFPgaksrCo2KEbqlZ7MSliwih76esNMgeARVcCxDa6cITdmBrb6MN82nqRO/wSe+3IFsVum98L0hZcMisQBgpfqAC3A16SAEUBgXeVLO1uA0Y3ivhu25CGiLGs+BFWej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=MelKGq9Y; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="MelKGq9Y"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20241024080718c1c0ef15be3ed148a3
        for <xenomai@lists.linux.dev>;
        Thu, 24 Oct 2024 10:07:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=fPVZ+Q4uirJvAVQ2smYRNwOo243cBpIAieKFho1MRMs=;
 b=MelKGq9YKhSKb/c741Jm/MPuD56GcTdO0MgObYd12miGI2/GplP+J0J3ssL1m3LnL9z2FX
 fJRKiIme1TMUyob0CnzZXyFukL+5xQ5Z0evKYe4ztzlM4bUHA+H8ZBYlkK/ZrvvGsVpHYxPr
 zGaY6yr21Y3jfWY/LD3nxBeERmWLpwdFWvShh9G24EP+2EI1QR9wh6mXqpPvSTBdIUApkWBl
 aOnSKGfTCaRa8VnQ0dGYAbKwAeoCVc+0MZRE1rsLqL+q2FuqvBX02VMOlDOQIvvRTmZ1eQl6
 IwSVgDP9NuCrCeToNtaLUqPXDxlEA9xnzLxbIpd7wVzKQ7/cjF8NI+cg==;
Message-ID: <2bca1fdbb9ff21c91cd13a583deaace3157baedc.camel@siemens.com>
Subject: Re: [PATCH] y2038: lib/cobalt: Fix __STD() macro usage for some
 services
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Thu, 24 Oct 2024 10:07:18 +0200
In-Reply-To: <7d1df6ce-21bf-4a1c-b8cc-ff2c449c6575@siemens.com>
References: <20241024072656.179803-1-florian.bezdeka@siemens.com>
	 <7d1df6ce-21bf-4a1c-b8cc-ff2c449c6575@siemens.com>
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

On Thu, 2024-10-24 at 09:59 +0200, Jan Kiszka wrote:
> On 24.10.24 09:26, Florian Bezdeka wrote:
> > The macro usage was broken for the following services:
> >   - recvmmsg
> >   - mq_timedsend
> >   - mq_timedreceive
> >=20
> > The message queue services were forwarded to wrong libc functions,
> > the recvmmsg was missing the correct routing.
> >=20
> > Detected while trying to remove the function wrapping at all.
> >=20
>=20
> Can you elaborate a bit on the visible impact for users? And it affects
> 3.3 only?

Yes, this is 3.3 only.

Something like __STD(recvmmsg()) had not the desired effect on compat
applications with y2038 support enabled - which is the default for
compat applications now.

Rare use case but still relevant I would say.

Florian

>=20
> Jan
>=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  include/cobalt/mqueue.h     | 4 ++--
> >  include/cobalt/sys/socket.h | 6 +++---
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/include/cobalt/mqueue.h b/include/cobalt/mqueue.h
> > index 89d4bff79..9fd502c04 100644
> > --- a/include/cobalt/mqueue.h
> > +++ b/include/cobalt/mqueue.h
> > @@ -42,14 +42,14 @@ COBALT_DECL(int, mq_setattr,
> >  COBALT_DECL(int, mq_send,
> >  	    (mqd_t qd, const char *buffer, size_t len, unsigned prio));
> > =20
> > -COBALT_DECL_TIME64(int, mq_timedsend, __mq_timedsend64,
> > +COBALT_DECL_TIME64(int, mq_timedsend, __mq_timedsend_time64,
> >  		   (mqd_t q, const char *buffer, size_t len, unsigned prio,
> >  		    const struct timespec *timeout));
> > =20
> >  COBALT_DECL(ssize_t, mq_receive,
> >  	    (mqd_t q, char *buffer, size_t len, unsigned *prio));
> > =20
> > -COBALT_DECL_TIME64(ssize_t, mq_timedreceive, __mq_timedsend_time64,
> > +COBALT_DECL_TIME64(ssize_t, mq_timedreceive, __mq_timedreceive_time64,
> >  	    (mqd_t q, char *__restrict__ buffer, size_t len,
> >  	     unsigned *__restrict__ prio,
> >  	     const struct timespec *__restrict__ timeout));
> > diff --git a/include/cobalt/sys/socket.h b/include/cobalt/sys/socket.h
> > index d5e81e5bd..9095594c6 100644
> > --- a/include/cobalt/sys/socket.h
> > +++ b/include/cobalt/sys/socket.h
> > @@ -31,9 +31,9 @@ COBALT_DECL(int, socket, (int protocol_family, int so=
cket_type, int protocol));
> > =20
> >  COBALT_DECL(ssize_t, recvmsg, (int fd, struct msghdr *msg, int flags))=
;
> > =20
> > -COBALT_DECL(int, recvmmsg,
> > -	    (int fd, struct mmsghdr *msgvec, unsigned int vlen,
> > -	     unsigned int flags, struct timespec *timeout));
> > +COBALT_DECL_TIME64(int, recvmmsg, __recvmmsg64,
> > +		   (int fd, struct mmsghdr *msgvec, unsigned int vlen,
> > +		    unsigned int flags, struct timespec *timeout));
> > =20
> >  COBALT_DECL(ssize_t, sendmsg, (int fd, const struct msghdr *msg, int f=
lags));
> > =20
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

