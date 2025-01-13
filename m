Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326A5239787
	for <xenomai@lists.linux.dev>; Mon, 13 Jan 2025 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760378; cv=none; b=Yk38tpGF4JldtkVjMCbyORTqQW2b/FIyxVcxfNSZzH44mBUwKpCYmuJDuBA9FfBCrPAMvj7IJY6ptJoXL5OHqZL1ReEOIuF3TRJuQZanK6KKU0tF2if/2uW5a+C5wTx71hem0flLwsV50nshWnuVkqGwoNKv70ex7tBhajNVBbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760378; c=relaxed/simple;
	bh=ErE5SfkzT7B5WRj4s7FGGmbuypJYfimFG/Zj6WRQdvs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WoAM1eGkxkkeARRI8SPdGSO66z1LPZwoMYfPPXZpt0VMaGkWetdaDN0GiOnHT6PjedgsQrPlp6zM7E2oP2zdcSKNOgQaQUc1z2nwh2oe2uAiecmM+Ghf9vffQ22BnwRMYK5PPGFpt02ABWQcE2fdosm5kbvvvIPd4345OztCAZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=WqrqvQR8; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="WqrqvQR8"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250113092607c002e2a2f30bc8893c
        for <xenomai@lists.linux.dev>;
        Mon, 13 Jan 2025 10:26:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=BXsncfMdibKXJsizvC4sva7Ndo1EcCqzKfOIQumTWcE=;
 b=WqrqvQR8N3O1PcnxTmMfPOVjBiVNOlp67d/sxLHq5zrbUi0rffpZP2ah/wOLJe49fIqcQj
 bcMz0d5USxoHY59AUze4eJ8Mo9QIE9aplVx1nkYKAy2o2nN0zdsyP++xNq/ApP7To3+WcE8h
 2IfmvOFQCf0uTrdupcQwtBTjtVW6WH7Yd+OEkSTJkS8rboUCbl/OBrQxntscy6Uq5xxbCry0
 Ao0vfSkPK+hnNcT8vqEjkBT4Mfy83S/GT3/HxyT9S1n5xqYKm0umKS0/By2TmgdTFLxITYrx
 jEt1ehJ2tXeMUR4u0Zn3HL+zTTgcjkZ0rT9rgQncHCIYn04luw2UzBUQ==;
Message-ID: <6f9ca8871d3e9e594c0620a0f59f46f64228d6ac.camel@siemens.com>
Subject: Re: [PATCH 2/3] cobalt: Add missing access_ok checks
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Mon, 13 Jan 2025 10:26:06 +0100
In-Reply-To: <eaa1b565f740f337b62cb18ea2217e0b8c2cb69b.1736678909.git.jan.kiszka@siemens.com>
References: <cover.1736678909.git.jan.kiszka@siemens.com>
	 <eaa1b565f740f337b62cb18ea2217e0b8c2cb69b.1736678909.git.jan.kiszka@siemens.com>
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

On Sun, 2025-01-12 at 11:48 +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> These ensure that we are not using an invalid address range, possibly
> writing to kernel space.
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  kernel/cobalt/posix/io.c        | 2 ++
>  kernel/cobalt/posix/mqueue.c    | 3 ++-
>  kernel/cobalt/posix/syscall32.c | 2 ++
>  3 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
> index e581ec6db8..722f1ce20c 100644
> --- a/kernel/cobalt/posix/io.c
> +++ b/kernel/cobalt/posix/io.c
> @@ -146,6 +146,8 @@ static int put_mmsglen(void __user **u_mmsg_p, const =
struct mmsghdr *mmsg)
>  	struct mmsghdr __user **p =3D (struct mmsghdr **)u_mmsg_p,
>  		*q __user =3D (*p)++;
> =20
> +	if (!access_ok(&q->msg_len, sizeof(q->msg_len)))
> +		return -EFAULT;
>  	return __xn_put_user(mmsg->msg_len, &q->msg_len);
>  }
> =20
> diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
> index 853aa6cad8..34776fe6cd 100644
> --- a/kernel/cobalt/posix/mqueue.c
> +++ b/kernel/cobalt/posix/mqueue.c
> @@ -1031,7 +1031,8 @@ int __cobalt_mq_timedreceive(mqd_t uqd, void __user=
 *u_buf,
> =20
>  	cobalt_mqd_put(mqd);
> =20
> -	if (u_prio && __xn_put_user(prio, u_prio))
> +	if (u_prio && (!access_ok(u_prio, sizeof(*u_prio)) ||
> +		       __xn_put_user(prio, u_prio)))
>  		return -EFAULT;
> =20
>  	return 0;
> diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscal=
l32.c
> index 793bde1388..484f059844 100644
> --- a/kernel/cobalt/posix/syscall32.c
> +++ b/kernel/cobalt/posix/syscall32.c
> @@ -605,6 +605,8 @@ static int put_mmsglen32(void __user **u_mmsg_p, cons=
t struct mmsghdr *mmsg)
>  	struct compat_mmsghdr __user **p =3D (struct compat_mmsghdr **)u_mmsg_p=
,
>  		*q __user =3D (*p)++;
> =20
> +	if (!access_ok(&q->msg_len, sizeof(q->msg_len)))
> +		return -EFAULT;
>  	return __xn_put_user(mmsg->msg_len, &q->msg_len);
>  }

That all looks OK, but I think we have two more missing access_ok()
checks:

posix/cond.c: __cobalt_cond_wait_prologue()
posix/monitor.c: __cobalt_monitor_wait()

> =20
> --=20
> 2.43.0

