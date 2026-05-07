Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7003ED5A2
	for <xenomai@lists.linux.dev>; Thu,  7 May 2026 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158552; cv=none; b=HvV+/WogAAiGRtdzYAhcCncT3VmbP+RgbwmRt1EXQnWn/osvNFC3UT825LmP5bQ8iqWmc3d7hPk7NdFXjfk4VOog3OFcSk5qvBMyNmGUKiSGGhZOkOlrRJHr1bpcjqaWM+MBK4beqbEEze2T8ncaBCtyqvtZE3XkY8kU8zxnYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158552; c=relaxed/simple;
	bh=6Yr84xM2byGvFddq0YybFQE4piQD5QJLjIUsp/kChnY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qv2x8HCSzxGhxxz2vBO1lfdy3cO1aGTL/x/h1LqgjgyX5oMJh0mgMuId6UH9xf2CqwJD0vDXONH/Mf0k5E3cqS1Jybx2v+/5yInLP1XeoFtg9Z6nJUyFbKVfI29XOxbYiFPwbyCnqt9WeD+f4oR9fjhRjtJC3bf3IAT33HGoYHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 27887298580;
	Thu,  7 May 2026 14:55:49 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 1vSC-qWXdyuh; Thu,  7 May 2026 14:55:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D8E12298599;
	Thu,  7 May 2026 14:55:48 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5DEK5m_KFTi8; Thu,  7 May 2026 14:55:48 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id BE555298580;
	Thu,  7 May 2026 14:55:48 +0200 (CEST)
Date: Thu, 7 May 2026 14:55:48 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
Message-ID: <955375516.2805.1778158548523.JavaMail.zimbra@nod.at>
In-Reply-To: <3997a44b-0ce4-46b1-a0a2-9ddbed951b5c@siemens.com>
References: <20260507122357.2463483-1-richard@nod.at> <945cb32c-88ea-41fa-8223-f3d1e639e9d9@siemens.com> <1863085876.2350.1778157171370.JavaMail.zimbra@nod.at> <3997a44b-0ce4-46b1-a0a2-9ddbed951b5c@siemens.com>
Subject: Re: [PATCH] Add build time guard to detect off_t mismatch
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF150 (Linux)/8.8.12_GA_3809)
Thread-Topic: Add build time guard to detect off_t mismatch
Thread-Index: Q+4GWauaRFqkLtaKPSWLp7SXwi/kpA==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> In my case it was just mmap(). But wouldn't it hurt at any function
>> or data structure exposed by Xenomai which uses off_t?
>>=20
>> So, I suggest applying my change as safeguard mechanism.
>>=20
>=20
> mmap is supposed to be fine by now. So we need to understand why it is
> not and resolve the issue - or my other patch would be pointless.

Ah, sorry for not being clear.
Your fix is in next and not part of a release, and the application in
question uses Xenomai 3.2.6...

Thanks,
//richard
