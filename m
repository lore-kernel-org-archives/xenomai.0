Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2541A14534D
	for <xenomai@lists.linux.dev>; Wed, 29 May 2024 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717014404; cv=none; b=S4C7WpzbxwtUAVkRnIbwVvRj861TQDlMauFCJ6bGtaINPJytJpYxYoYSIl449FVHwD1V58xSinDyTKbzsZNcXSz6j9bQc/vSJK/6s0LYRUMelFTc+90B8HMHB1f4AvM9ARPKJJB49kf4O2CvrhjiSIWTsHBsXxPKxTLmbQ+HENo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717014404; c=relaxed/simple;
	bh=+EvenR/Fp+OVlXi+049a17wgVMU4bg5bfR1KfOhRz6s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=eeKA6W8S9WikjG4j5tYuYlrTWmOk4UXJbuR+tzLUcVc2oqCDoHPE9aC2zBjTRY+WGfFq2KB8JZoLxYBKXAMHjLUg4TKfycsrm0NGC3HjxBJsAP+cLn5c6gOVkjg0H1RSSW2Na52N5FufDOxWwB5l+L8BuIG9ZWJP0fniEWi3f0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8BD996195FD0;
	Wed, 29 May 2024 22:26:33 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id BI3e6fM-Q-bS; Wed, 29 May 2024 22:26:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 28EC06195FE5;
	Wed, 29 May 2024 22:26:33 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gq_NMev9nXkh; Wed, 29 May 2024 22:26:33 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 092FB6195FD0;
	Wed, 29 May 2024 22:26:33 +0200 (CEST)
Date: Wed, 29 May 2024 22:26:32 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>, lorenz <lorenz@sigma-star.at>
Message-ID: <1731162214.162381.1717014392803.JavaMail.zimbra@nod.at>
In-Reply-To: <3331f257-aa7f-4f2d-be03-542cb0be58ac@siemens.com>
References: <20240524083642.19434-1-richard@nod.at> <ac6d6c40-aac4-4568-8bb0-244ee293c5ea@siemens.com> <3b4a7ed5-ac29-4897-9606-388106db0dd5@siemens.com> <1871297586.157252.1716906580685.JavaMail.zimbra@nod.at> <3331f257-aa7f-4f2d-be03-542cb0be58ac@siemens.com>
Subject: Re: [PATCH v2 0/2] Fix rt_task_unblock for RT_MUTEX
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix rt_task_unblock for RT_MUTEX
Thread-Index: laEIKXYun2gWAB08e/JrF1Jy/ycMLw==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>>>> Thanks, applied (just not yet pushed - our lab has some hick-up).
>>>>
>>>
>>> Now done - all red:
>>=20
>> *grrr* sorry for that.
>> =20
>>> 2024-05-28T11:51:59 FAILURE rt_thread_body:117: pthread_mutex_lock
>>> returned 4 instead of 0 - Interrupted system call
>>=20
>> I'm pretty sure the problem is:
>>=20
>> ... while (ret =3D=3D -EINTR);
>>=20
>> Should be ret =3D=3D EINTR because -ret is returned.
>>=20
>=20
> Seems that was it, fixed up now in next.

Thanks for the fixup, the resolution looks good!

--
Thanks,
//richard
