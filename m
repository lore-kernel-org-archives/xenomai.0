Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4CE136E37
	for <xenomai@lists.linux.dev>; Wed, 15 Jan 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956972; cv=none; b=M6I0rTB2SzqUxUzMf/I0P/U/0a3aU0jKa9o5MX6dsS5AJeuoLTL43h8sf3xwVzIHtTSQWJrJp1zizbZD7zjNzHju7vDyaSloYXVzE7S2Z7vO238+kLF/DlNWs70b/ybnwatSaiOQRUvT5LT6vmg0M6dvIQWLdhDNHljk6J+r4dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956972; c=relaxed/simple;
	bh=NE3AdVkR+n+YTf1ehud6KV74euMDZeHvlpqHaLeCo2I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TNZWgUv+TTM/7FTAJZtSu7qlb/09te8YIgUg8IAJRMAfsIyrG8CwDxOCqVJjdLx3jOqlNIjptSh4/EazqzHtRHt5SQ1AlDT59LFh5i40y3ZOgRSK8C2pMj2vDwv3o/vRD6UurqZUYyV+mYdbufWCc4FIU9Jnl2DLl9sIqZ8210c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=DtrqfYx0; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="DtrqfYx0"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2025011516023744e03efcf200f6eadd
        for <xenomai@lists.linux.dev>;
        Wed, 15 Jan 2025 17:02:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zY0Qq33rHO1JBd0qKjwjoIuyDe5sJdazJgk3oO5Mb/o=;
 b=DtrqfYx0RTRFnepC/rPiC+r9XISjGYqmruQJpJGGOhuzvc3gd1b5qsYoZh+sW1Cp3HeJbB
 /TY14cjLXGsr9C15Wjwn17HUDe6qR8md7TAvuZXIyHsaq3BmLnpvmv0kOsqGV2YVBo8NXKH/
 naC52iauvx7AhrJASsXG4U3t+oTnHDPd9gqd1v5UmUFBybOiwCEKrZDfdKp2/5PWVUMYxI7h
 tIq9LoNrUJrhqJaUOUyYvMqjLcgjnVHAHR5Dxp9UoG52g15PVTW6RCdb6UXoKhvcEJF/eXc4
 I84SbJVeYTdIn0sef2JgA1+g6q0dpqYKV+Iyqm3NYuf3hJDCCrG5WXcw==;
Message-ID: <7a2fe3f2e06237a32b6ec050d34b57a1a5511609.camel@siemens.com>
Subject: Re: [PATCH] cobalt: select: Move nfds range check to caller of
 xnselect
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Cc: Florian Ullmann <ullmann.florian@siemens.com>
Date: Wed, 15 Jan 2025 17:02:35 +0100
In-Reply-To: <8a0efc9c-2949-48f4-8408-264e5322c0cf@siemens.com>
References: <8a0efc9c-2949-48f4-8408-264e5322c0cf@siemens.com>
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

On Wed, 2025-01-15 at 15:13 +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> __cobalt_select can stumble over too large nfds values as it copies file
> descriptor sets from userspace into a statically sized kernel buffers.
> This can lead to kernel crashes or worse things when userspace provided
> garbage.
>=20
> Rather than duplicating the check, move it from xnselect to its only
> caller __cobalt_select.
>=20
> Reported by: Florian Ullmann <ullmann.florian@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>

Nit: Would be nice to have a (smokey) test for that...

> ---
>  kernel/cobalt/posix/io.c | 3 +++
>  kernel/cobalt/select.c   | 4 ----
>  2 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
> index 722f1ce20c..4e20ca19d6 100644
> --- a/kernel/cobalt/posix/io.c
> +++ b/kernel/cobalt/posix/io.c
> @@ -266,6 +266,9 @@ int __cobalt_select(int nfds, void __user *u_rfds, vo=
id __user *u_wfds,
>  		mode =3D XN_ABSOLUTE;
>  	}
> =20
> +	if ((unsigned)nfds > __FD_SETSIZE)
> +		return -EINVAL;
> +
>  	fds_size =3D __FDELT__(nfds + __NFDBITS__ - 1) * sizeof(long);
> =20
>  	for (i =3D 0; i < XNSELECT_MAX_TYPES; i++)
> diff --git a/kernel/cobalt/select.c b/kernel/cobalt/select.c
> index bd790affe4..70ae9a07d5 100644
> --- a/kernel/cobalt/select.c
> +++ b/kernel/cobalt/select.c
> @@ -309,7 +309,6 @@ EXPORT_SYMBOL_GPL(xnselector_init);
>   * than expected if the sleep is interrupted.
>   * @param timeout_mode the mode of @a timeout.
>   *
> - * @retval -EINVAL if @a nfds is negative;
>   * @retval -ECHRNG if some of the descriptors passed in @a in_fds have n=
ot yet
>   * been registered with xnselect_bind(), @a out_fds contains the set of =
such
>   * descriptors;
> @@ -329,9 +328,6 @@ int xnselect(struct xnselector *selector,
>  	int info =3D 0;
>  	spl_t s;
> =20
> -	if ((unsigned) nfds > __FD_SETSIZE)
> -		return -EINVAL;
> -
>  	for (i =3D 0; i < XNSELECT_MAX_TYPES; i++)
>  		if (out_fds[i])
>  			fd_set_zeropad(out_fds[i], nfds);
> --=20
> 2.43.0

