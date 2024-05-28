Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66B016D9AF
	for <xenomai@lists.linux.dev>; Tue, 28 May 2024 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906587; cv=none; b=Rv7pWaoRuwE84zEBUyKJtMV8ZGSWBqbNiP58+dzGjIqMwidQi6j2y58c8xcSn9hERi8DqBNtN6Z8PsldEngLKMv+xCVvYvTVMjOzGkk7sEJWcnE+igL8NAjGnTx1FNv+zNEZyhSTKheqZGciiPWvpFntQ74YDFdMNXmsTXxJeQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906587; c=relaxed/simple;
	bh=uho92HS+Wb8gEQEH6vP7jdueSu3j9Kes2/nTKoKaJy8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=CJHzTClmRTxMyXfjtDMd5bHspsTfyQiYNODjKFTgQvQvmMPzwNdMg4240SLtuGnnZcVpeXgMbNex3YHDAIQaVG/SRzboD2puQ0+h5teqzDLcu/r7oCYviLkRTYz2Qgy36BUrFVzLPpbMg+TvrF42TH2yz9fWz1Ubcw2yQ59puRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5AD72606BA2D;
	Tue, 28 May 2024 16:29:41 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 1f_a6_0rM1mm; Tue, 28 May 2024 16:29:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E43F3606BA37;
	Tue, 28 May 2024 16:29:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uAitEizLAXwa; Tue, 28 May 2024 16:29:40 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id C8179606BA2D;
	Tue, 28 May 2024 16:29:40 +0200 (CEST)
Date: Tue, 28 May 2024 16:29:40 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>, lorenz@sigma-star.at
Message-ID: <1871297586.157252.1716906580685.JavaMail.zimbra@nod.at>
In-Reply-To: <3b4a7ed5-ac29-4897-9606-388106db0dd5@siemens.com>
References: <20240524083642.19434-1-richard@nod.at> <ac6d6c40-aac4-4568-8bb0-244ee293c5ea@siemens.com> <3b4a7ed5-ac29-4897-9606-388106db0dd5@siemens.com>
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
Thread-Index: f6mgx84ndws/MyfgPocAs804hO4M4A==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> An: "richard" <richard@nod.at>, "xenomai" <xenomai@lists.linux.dev>
> CC: lorenz@sigma-star.at
> Gesendet: Dienstag, 28. Mai 2024 15:36:14
> Betreff: Re: [PATCH v2 0/2] Fix rt_task_unblock for RT_MUTEX

> On 28.05.24 07:24, Jan Kiszka wrote:
>> On 24.05.24 10:36, Richard Weinberger wrote:
>>> Changes since v1 [0]:
>>> - Better names for EINTR capable functions
>>> - Remove want_eintr flag and loop around __pthread_mutex_lock()
>>> - Correctly integrate mutex-2 test into smokey test framework
>>>
>>> [0]:
>>> https://lore.kernel.org/xenomai/91a15d69-ea68-49a9-8daf-d52ae31f6d49@si=
emens.com/T/#mf76a46eaa5ec033bacdfc63ca219af3bb84356b3
>>>
>>> Richard Weinberger (2):
>>>   Alchemy: Fix rt_task_unblock() for RT_MUTEX
>>>   alchemytests: Add test case for RT_MUTEX and -EINTR
>>>
>>>  include/cobalt/pthread.h                     |   5 +
>>>  lib/alchemy/mutex.c                          |   8 ++
>>>  lib/cobalt/mutex.c                           |  44 ++++++--
>>>  testsuite/smokey/alchemytests/Makefile.am    |   5 +
>>>  testsuite/smokey/alchemytests/alchemytests.c |   1 +
>>>  testsuite/smokey/alchemytests/mutex-2.c      | 111 +++++++++++++++++++
>>>  6 files changed, 164 insertions(+), 10 deletions(-)
>>>  create mode 100644 testsuite/smokey/alchemytests/mutex-2.c
>>>
>>=20
>> Thanks, applied (just not yet pushed - our lab has some hick-up).
>>=20
>=20
> Now done - all red:

*grrr* sorry for that.
=20
> 2024-05-28T11:51:59 FAILURE rt_thread_body:117: pthread_mutex_lock
> returned 4 instead of 0 - Interrupted system call

I'm pretty sure the problem is:

... while (ret =3D=3D -EINTR);

Should be ret =3D=3D EINTR because -ret is returned.

Thanks,
//richard
