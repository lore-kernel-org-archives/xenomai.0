Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0357198E6D
	for <xenomai@lists.linux.dev>; Fri,  9 Aug 2024 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723218126; cv=none; b=PQMIYg7bk/IugT9CuTD/pByugRSWh2dg2XSt9iMg6kAjGykyxxCJyXSzxld1rZeWcs575D0PPL7Fx+JgPSbUqzsrIoZ95EbWVQ3HAYx2+foUDaWhhz0Qzs3FbPbpIifkTntcXnvH9pW2rx7KrbFHdsqK814v+H0iWoOW7wycjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723218126; c=relaxed/simple;
	bh=sTET+q8X3vhTHSr4l2/ppjug3Ud3tkU2LH196P2Qtb4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YiDURKly8wEOmLP+jVs3mYjfERG8eYV8j8ClvA4u/yFKP8mr2T1h4RuDo9PQMmxqTcEAnbLgpzoOK7cQX13fW9aYKJklWQe/Y/W03JrTbfg5XBRZRqG7BfZVHAshVetv9FjT4zDn4E7z5uIU/mImXqAyVB4GwAPat8ERqs2fI00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=IO9BWBQi; arc=none smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="IO9BWBQi"
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id CD4F5240004
	for <xenomai@lists.linux.dev>; Fri,  9 Aug 2024 15:41:58 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 09EC6AC16A6
	for <xenomai@xenomai.org>; Fri,  9 Aug 2024 15:41:57 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2024080915415707cde81fab9a60f664
        for <xenomai@xenomai.org>;
        Fri, 09 Aug 2024 17:41:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=L86hH6/9ZbBhWp9PcUn+gYVm9grEEknKo/dSDDrmBpo=;
 b=IO9BWBQiHx+CNiPPk/lpzmhTWUPETO+DjYLKhmU3Gf7h8wtawyhlpUqRPi3cOPqDDL5eTL
 bxLpW4S94Rx+kbJmjj5sbC/e1uE3zm8nTL3qxm6C04jrITte4ssfnqMYJqC8q2KgMlWGl31S
 Ky2AcUgJokz87vNGEahmEZP0pcmgBcWtZotlw5SYPgavpbaB8XnoBGmbvBvJjokEqfQiOl/7
 jUV+ki58mkZHPpu9vkEyVvq3/RN6PtB1r6mrJGKQZOpq6S1T/zQW6VnZ5EQ9Sn+MVfE7pR76
 BUyP/YaSG6YnAE1jzrsriEw1mvGv80UFEuPk25ox5y9zc2bZYmYFZ9GQ==;
Message-ID: <3d1a1b320ed6b3f999551ecdc403367b99656c5d.camel@siemens.com>
Subject: Re: Dovetail kernel compilation error
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Pierre FICHEUX <pierre.ficheux@smile.fr>, xenomai <xenomai@xenomai.org>
Date: Fri, 09 Aug 2024 17:41:55 +0200
In-Reply-To: <CAFc1U0sm5nyd_P2oXH20nkCjfip-d=B66htnaC0bunx4quzzFg@mail.gmail.com>
References: 
	<CAFc1U0sm5nyd_P2oXH20nkCjfip-d=B66htnaC0bunx4quzzFg@mail.gmail.com>
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
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=IO9BWBQi;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-2024080915415707cde81fab9a60f664-nBY5b2@rts-flowmailer.siemens.com designates 185.136.65.225 as permitted sender) smtp.mailfrom=fm-68982-2024080915415707cde81fab9a60f664-nBY5b2@rts-flowmailer.siemens.com

On Fri, 2024-08-09 at 17:29 +0200, Pierre FICHEUX wrote:
> Hi,
>=20
> As compiling linux-6.1.y-dovetail or linux-6.6.y-dovetail I get the
> following error :
>=20
> kernel/xenomai/posix/timer.c:216:1: erreur: conflicting types for
> =C2=ABtimer_delete=C2=BB; have =C2=ABint(timer_t)=C2=BB {alias =C2=ABint(=
int)=C2=BB}
>   216 | timer_delete(timer_t timerid)
>       | ^~~~~~~~~~~~

This means that your xenomai version is not compatible with the kernel
version. 6.1 and 6.6 got some backports that required us to do some
changes to get compatible again.

The following branches / versions are compatible:
- master
- next
- stable/3.2.x since 3.2.5 (3.2.4 is too old)

Hope that helps,
Florian

> Dans le fichier inclus depuis ./include/linux/workqueue.h:9,
>                  depuis ./include/linux/mm_types.h:19,
>                  depuis ./include/linux/buildid.h:5,
>                  depuis ./include/linux/module.h:14,
>                  depuis kernel/xenomai/posix/timer.c:19:
> ./include/linux/timer.h:186:12: note: previous declaration of
> =C2=ABtimer_delete=C2=BB with type =C2=ABint(struct timer_list *)=C2=BB
>   186 | extern int timer_delete(struct timer_list *timer);
>=20
> The target is a Pi 3 used in 32 bits (Cortex A7). I use the 13-2-rel1
> toolchain with Buildroot.
>=20
> https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads/13-2-re=
l1
>=20
> Thanks by advance
>=20
> regards

