Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2423FCB03
	for <xenomai@lists.linux.dev>; Thu,  7 May 2026 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163011; cv=none; b=DPxcSfdC/rlEhbVoR/C7K5QuOdvQGwdBqZi4w/lbh9mf2aQstNYDT2fd6LPBXWTUw7M+849ihXCl2xMCK3OH3tFM6P9g/MknSw+jJ5pRrGa0CCaOVnN6ISfpDato68Jesx2JtHVGJCS272Bq1aDtSQ5aTVKyvWlf7UtpPTWR96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163011; c=relaxed/simple;
	bh=hvnUhWMJ67uVDsIY9W8BWTVXkqJEUa5XNsTfPEtBwAs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=FjSCcooETu6Ma7ysNyL2voQe65tGzRq5QqawrZjn0KLcBpWrPKP3kB26UJpG8PBnVlcoPZSKV3i9TZ/d+C4KYTJDdT7rCl82h+vBGyN2SgCu3XtBClvJFDBzdIiIIrHxpgrGrH8tBInEANoYbRDu+FsRJOg6b26owqiMIUbdSZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0D689298580;
	Thu,  7 May 2026 16:10:06 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id q6Pclr54fqCB; Thu,  7 May 2026 16:10:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6A2B8298599;
	Thu,  7 May 2026 16:10:05 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IjSzR1JqPmCM; Thu,  7 May 2026 16:10:05 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 27260298580;
	Thu,  7 May 2026 16:10:05 +0200 (CEST)
Date: Thu, 7 May 2026 16:10:04 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
Message-ID: <472857942.3063.1778163004494.JavaMail.zimbra@nod.at>
In-Reply-To: <84f6c3a9-b764-4774-b048-eb8e0c7fdc99@siemens.com>
References: <20260507122357.2463483-1-richard@nod.at> <945cb32c-88ea-41fa-8223-f3d1e639e9d9@siemens.com> <1863085876.2350.1778157171370.JavaMail.zimbra@nod.at> <3997a44b-0ce4-46b1-a0a2-9ddbed951b5c@siemens.com> <955375516.2805.1778158548523.JavaMail.zimbra@nod.at> <84f6c3a9-b764-4774-b048-eb8e0c7fdc99@siemens.com>
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
Thread-Index: avJ34J52iw5fslp2JlrOuxtERM0yuw==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> Ah, sorry for not being clear.
>> Your fix is in next and not part of a release, and the application in
>> question uses Xenomai 3.2.6...
>=20
> But 3.2.x is not affected by the mmap off_t issue?! Still confused.

Well, the issue I'm talking about was a build issue.
Xenomai was configured without _FILE_OFFSET_BITS=3D64, but the application =
was with.
Not Xenomai's fault, of course.

But when the application started to use mmap() the off_t used in the applic=
ation
had 8 bytes, but Xenomai expected 4. So, the mmap() offset parameter was wr=
ong.

Thanks,
//richard
