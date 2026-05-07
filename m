Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B564A3FBEDD
	for <xenomai@lists.linux.dev>; Thu,  7 May 2026 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164016; cv=none; b=ls6gUIS0kTMCkZszvyQCwNw+uHFZsc/zfgEUEdQ8/yQT8dgcZohvtFiX/SnrP3H0tSUS5JtfTD7imk48Dk8JEU/URi1N98QdWvMOv0KvZksJlzlJQYDlyjy3mG3swKHb+KaU5v3Ktwu1hSqLvVhJGmFXdBjrrR8vihGg/M3e75s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164016; c=relaxed/simple;
	bh=6QYyq9FqWoMN2bjY63mgpaUvy9mXyTiSITJZrporCl4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ImFRt/+IaEQ3iA/LKrB1dXRClqO14au0No9FH6RJEiAKSerw5Lpt2ypF20c6tEYHsOfYkt14E14+KQC4HJrO57nsnNP7Xm+p91+f++pQ/m6hJStQvgmM19xgMdZ4Mr9EcFmtid+bdlFSsBDrUDwleOY982kSHn+oSVus34t6Bs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 33CB2298580;
	Thu,  7 May 2026 16:26:51 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id iJuJDcU5Jdtc; Thu,  7 May 2026 16:26:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D8833298599;
	Thu,  7 May 2026 16:26:50 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id knM0KC7oPTf3; Thu,  7 May 2026 16:26:50 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id B4E42298580;
	Thu,  7 May 2026 16:26:50 +0200 (CEST)
Date: Thu, 7 May 2026 16:26:50 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
Message-ID: <1236713527.3136.1778164010569.JavaMail.zimbra@nod.at>
In-Reply-To: <2961c9be-b80f-438e-95b6-a2339f14d738@siemens.com>
References: <20260507122357.2463483-1-richard@nod.at> <945cb32c-88ea-41fa-8223-f3d1e639e9d9@siemens.com> <1863085876.2350.1778157171370.JavaMail.zimbra@nod.at> <3997a44b-0ce4-46b1-a0a2-9ddbed951b5c@siemens.com> <955375516.2805.1778158548523.JavaMail.zimbra@nod.at> <84f6c3a9-b764-4774-b048-eb8e0c7fdc99@siemens.com> <472857942.3063.1778163004494.JavaMail.zimbra@nod.at> <2961c9be-b80f-438e-95b6-a2339f14d738@siemens.com>
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
Thread-Index: z7W4DlFMdQ7kPP70uleGtWtXy7DnoA==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> Can you confirm that this issue is truly gone in next, whatever mode you
> choose on both sides?

Hmm. Let me build/run a test first.

Thanks,
//richard
