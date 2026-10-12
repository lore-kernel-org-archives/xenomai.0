Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D544F85B1
	for <xenomai@lists.linux.dev>; Mon, 12 Oct 2026 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840887; cv=none; b=cY9TnXjHH7JskBWsu+rEgxVcZW9ucLWkOtrmLIbfbWQuU2kvYc2gPPQirceSYRrDDa17DGnatE0iCgz6ZlSItV82+fNpN+IWUiJ6QFeNABze5Ld1FYx3vtzBaH4ySqp+p4xV4yPhjCPHq523Psm41rPwmiUDf3BqqAK3TyL5ARo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840887; c=relaxed/simple;
	bh=L3R8UcISIAO+2AS9NcJsuNklNcGxscHFdy3qHzaE8lw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MAJoX65r+IdBrkWCjxRaKFTYI47zhkj6eAGp95gYwPUikiLuF8z7+zDKVLjy2BBbhh8l6lOWf9I+OcF04NqNouQnKfsOKWLwFqmlQIA8XNypECN1TQtyd80Fc4YUs6+9tQx6rVc7XqF2PENYUVxtR71w4T3RGBdKDnd1c9TQJks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=c+nS3iAn; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="c+nS3iAn"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202610121954033bd2f38310000207d3
        for <xenomai@lists.linux.dev>;
        Mon, 12 Oct 2026 21:54:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rmQHZmoDe1SLkNtnguNE6dpAxUYhEojRa2a6pIpWKUM=;
 b=c+nS3iAn3HBIfLFaNThFFm1xL0vZnQgYtRiTcmGmy/5eKVGL9pYZyo5wtNx7x+aUbSKAlb
 oP5fdbXUaSD3gAxDq2ac6T/yPjFuARDaBYkkCd6OlcmKMVXrv18lzHx3zg0JnSZ2ePv91uY2
 PQ/JBpkO9Fi1Mm9f9yDG1vzOjPb5Of8MK/esRBWw5VztAoEnxMXqrGuHD2jU1750qGHik+Og
 KuS2XvmZfTW0S/tQa9nJVS3/kn3rqKB7kIVeZ2sUsH8ba9uhPpsGYJ5jqbPNPX7xWAJ7sjIS
 ORA2bO9Jlh3MhW02B8iddSHdMhlrduT64jr6GQOpr/GlAFD7+0hL5X4Q==;
Message-ID: <5875120ff1595793c7034a279d1a3c36571381f0.camel@siemens.com>
Subject: Re: [PATCH v2] Fix missing time64 wrappers
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?ISO-8859-1?Q?Fran=E7ois?= Legal <francois.legal@eventlab.fr>, 
	xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 12 Oct 2026 21:54:03 +0200
In-Reply-To: <1209-6acd0f80-73-5a2d1100@131663125>
References: <1209-6acd0f80-73-5a2d1100@131663125>
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

Hi Fran=C3=A7ois,

thanks a lot for v2. Some minor stuff below, Jan might even fix that up
on merge.

On Mon, 2026-10-12 at 18:49 +0200, Fran=C3=A7ois Legal wrote:
> There are missing wrappers for 64 bits time in xenomai 3.3 :
> - __recvmsg64
> - __sendmsg64
> - __sendmmsg64
>=20
> For __recvmsg64, the only options which shall write to msghdr.msg_control=
 are :
> -RTCAN_RTIOC_TAKE_TIMESTAMP which always writes RTCAN_TIMESTAMP_SIZE (64)=
 bits
> so it is correct to route the time64 service to ne native "time_t" syscal=
l.
                                                  ^^^
Typo.
s/ne/the

Should we add an additional note that we do not implement anything
regarding TX? Seems we do not support something like SO_TIMESTAMP,
SO_TIMESTAMPNS or SCM_TIMESTAMPING. Thats the reason why the send{m}msg
services are fine.

>=20
> Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
> ---
> diff --git a/lib/cobalt/cobalt-glibc-time64.wrappers b/lib/cobalt/cobalt-=
glibc-time64.wrappers
> index 0bf895ca9..483a8ce24 100644
> --- a/lib/cobalt/cobalt-glibc-time64.wrappers
> +++ b/lib/cobalt/cobalt-glibc-time64.wrappers
> @@ -8,7 +8,10 @@
>  --wrap __mq_timedsend_time64
>  --wrap __mq_timedreceive_time64
>  --wrap __sigtimedwait64
> +--wrap __recvmsg64
>  --wrap __recvmmsg64
> +--wrap __sendmsg64
> +--wrap __sendmmsg64
>  --wrap __pthread_cond_timedwait64
>  --wrap __timer_settime64
>  --wrap __timer_gettime64
> diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
> index 00c1aaf4b..264de8ace 100644
> --- a/lib/cobalt/rtdm.c
> +++ b/lib/cobalt/rtdm.c
> @@ -254,7 +256,7 @@ static ssize_t do_recvmsg(int fd, struct msghdr *msg,=
 int flags)
>  	return ret;
>  }
> =20
> -COBALT_IMPL(ssize_t, recvmsg, (int fd, struct msghdr *msg, int flags))
> +COBALT_IMPL_TIME64(ssize_t, recvmsg, __recvmsg64,
> +		(int fd,struct msghdr *msg, int flags))
                       ^^
Missing space.

>  {
>  	int ret;
> =20
> @@ -301,7 +301,7 @@ static ssize_t do_sendmsg(int fd, const struct msghdr=
 *msg, int flags)
>  	return ret;
>  }
> =20
> -COBALT_IMPL(ssize_t, sendmsg, (int fd, const struct msghdr *msg, int fla=
gs))
> +COBALT_IMPL_TIME64(ssize_t, sendmsg, __sendmsg64,
> +		(int fd, const struct msghdr *msg, int flags))
>  {
>  	int ret;
> =20
> @@ -312,7 +312,7 @@ COBALT_IMPL(ssize_t, sendmsg, (int fd, const struct m=
sghdr *msg, int flags))
>  	return __STD(sendmsg(fd, msg, flags));
>  }
> =20
> -COBALT_IMPL(int, sendmmsg, (int fd, struct mmsghdr *msgvec,
> +COBALT_IMPL_TIME64(int, sendmmsg, sendmmsg64, (int fd, struct mmsghdr *m=
sgvec,
>  			    unsigned int vlen, unsigned int flags))
>  {
>  	int ret, oldtype;
