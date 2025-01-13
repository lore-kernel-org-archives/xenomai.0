Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE5D2500D6
	for <xenomai@lists.linux.dev>; Mon, 13 Jan 2025 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760686; cv=none; b=Z10z39C5rYgdtoGI39wHratld9b0M+i/6lkITCjKnc4dlpV7+mOPI+LHjbzT1XnidJfqG9X0kRZJ4lEvCqG7T5OJvsfpULFk/Csl+pm0SKydO7uwHe3zaEtE9FRusi5e/PkyjNQfoN7mY1KBuukrNVxgNi3ZG9CUcwr0Uyotppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760686; c=relaxed/simple;
	bh=1dWxxPaEhWpxHLplILAxsXnmoA0C1q2Q3Xt/IHXwUac=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KYysvtZKR3acMxDtgcenEtM4Ku30jLKusSTUJYlziGsW49HKPesap3HszwRwiwZyZI3Kj1pq46JCMu0sDcnr25JF4BZ+iyLP713uj9w6BCXUanGEBX6cZrXOV+DuqBUYAKmHvg+UE6GFdQbtds655xMA/5NnKvrKVFky4VD07kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=XA6UQW/y; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="XA6UQW/y"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202501130931182b273a0f0cf4bb07a1
        for <xenomai@lists.linux.dev>;
        Mon, 13 Jan 2025 10:31:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=MB5hO39BTb7k3odYEWljomcEthKYZwEEKFLTapxA+/4=;
 b=XA6UQW/yhwZ0aXakzaStB7SFAN2TrjmMhTmveVxfqgyfG1N/m3cv8b+k1CxEoc4+gkylpP
 Y1QXtrWFG8DKkekI/jO9/vf4Kigzi8vjryz6N9ABa+hVA0DW1NKwxE88u5PnLE+UuKc3bGDe
 o3giqSGGmK8aLtuga/fgFSR+HPwGiVDxeAzfOz6rMKJWg5ej5+eD/HYOarhz0kVb1psDN0v5
 ZIAQa93177+TeIwPs3Iu5nxJ7Acmm4eN3N5mpOteE/XhXXefyIk7eXTO3TK7rDrv3wFpSoSo
 DLVwOEuogHK5IFI/Ig6C+q+BSBW5u4i4Kw8dVEwigtxP3F9XW7hUAf5g==;
Message-ID: <85736265dfcb90e4ad1d2c70d61408f48217e9a7.camel@siemens.com>
Subject: Re: [PATCH 2/3] cobalt: Add missing access_ok checks
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Mon, 13 Jan 2025 10:31:18 +0100
In-Reply-To: <6f9ca8871d3e9e594c0620a0f59f46f64228d6ac.camel@siemens.com>
References: <cover.1736678909.git.jan.kiszka@siemens.com>
	 <eaa1b565f740f337b62cb18ea2217e0b8c2cb69b.1736678909.git.jan.kiszka@siemens.com>
	 <6f9ca8871d3e9e594c0620a0f59f46f64228d6ac.camel@siemens.com>
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

On Mon, 2025-01-13 at 10:26 +0100, Florian Bezdeka wrote:
> On Sun, 2025-01-12 at 11:48 +0100, Jan Kiszka wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >=20
> > These ensure that we are not using an invalid address range, possibly
> > writing to kernel space.
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >  kernel/cobalt/posix/io.c        | 2 ++
> >  kernel/cobalt/posix/mqueue.c    | 3 ++-
> >  kernel/cobalt/posix/syscall32.c | 2 ++
> >  3 files changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
> > index e581ec6db8..722f1ce20c 100644
> > --- a/kernel/cobalt/posix/io.c
> > +++ b/kernel/cobalt/posix/io.c
> > @@ -146,6 +146,8 @@ static int put_mmsglen(void __user **u_mmsg_p, cons=
t struct mmsghdr *mmsg)
> >  	struct mmsghdr __user **p =3D (struct mmsghdr **)u_mmsg_p,
> >  		*q __user =3D (*p)++;
> > =20
> > +	if (!access_ok(&q->msg_len, sizeof(q->msg_len)))
> > +		return -EFAULT;
> >  	return __xn_put_user(mmsg->msg_len, &q->msg_len);
> >  }
> > =20
> > diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.=
c
> > index 853aa6cad8..34776fe6cd 100644
> > --- a/kernel/cobalt/posix/mqueue.c
> > +++ b/kernel/cobalt/posix/mqueue.c
> > @@ -1031,7 +1031,8 @@ int __cobalt_mq_timedreceive(mqd_t uqd, void __us=
er *u_buf,
> > =20
> >  	cobalt_mqd_put(mqd);
> > =20
> > -	if (u_prio && __xn_put_user(prio, u_prio))
> > +	if (u_prio && (!access_ok(u_prio, sizeof(*u_prio)) ||
> > +		       __xn_put_user(prio, u_prio)))
> >  		return -EFAULT;
> > =20
> >  	return 0;
> > diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/sysc=
all32.c
> > index 793bde1388..484f059844 100644
> > --- a/kernel/cobalt/posix/syscall32.c
> > +++ b/kernel/cobalt/posix/syscall32.c
> > @@ -605,6 +605,8 @@ static int put_mmsglen32(void __user **u_mmsg_p, co=
nst struct mmsghdr *mmsg)
> >  	struct compat_mmsghdr __user **p =3D (struct compat_mmsghdr **)u_mmsg=
_p,
> >  		*q __user =3D (*p)++;
> > =20
> > +	if (!access_ok(&q->msg_len, sizeof(q->msg_len)))
> > +		return -EFAULT;
> >  	return __xn_put_user(mmsg->msg_len, &q->msg_len);
> >  }
>=20
> That all looks OK, but I think we have two more missing access_ok()
> checks:
>=20
> posix/cond.c: __cobalt_cond_wait_prologue()
> posix/monitor.c: __cobalt_monitor_wait()

Just realized that you folded that into 3/3...

Fine but slightly mixed, but as it touches the same code...

>=20
> > =20
> > --=20
> > 2.43.0

