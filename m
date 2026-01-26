Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42624348895
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446735; cv=none; b=WHOe0016H0CaJQaV3tk4jgrqfUrFMPnDtA4daEDu1eUpKm/FXja/jgOBnbAyfG36+JoifziEr2LOk9HxwsMddCn4i/7uPDB4R1grOo6VKxyLQxw+UejH5XK+/5wdIibH+VwWhk/c05ciIy8zt5vo9nsjnA3aPf0vCC/aZ313tmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446735; c=relaxed/simple;
	bh=q5rlbWjAko/txGAEIyz6dvDFoZQo1xB5LOHEVWbrNoc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GadQ4BU5s7E9jjZV0na67RhSqVxPvtz1qZikMxFikINCjOPJWmD9J2hQvdpgTo6VpCmHafz3UU3x4Hg/kQNojIQfrPhJfN1Ow4thclkPViBKOz2p9H/xRwK1nz3tRGu448jugSpG6u++z57tFFn30EOc9CpioQpa4rglqfqOgTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E6C2E2A87F7;
	Mon, 26 Jan 2026 17:58:50 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id AZ0d4fEaHq4J; Mon, 26 Jan 2026 17:58:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9B46C2A8813;
	Mon, 26 Jan 2026 17:58:49 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4rGnb8iICvyS; Mon, 26 Jan 2026 17:58:49 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 652CE2A87F7;
	Mon, 26 Jan 2026 17:58:49 +0100 (CET)
Date: Mon, 26 Jan 2026 17:58:49 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
Message-ID: <1353891765.13527.1769446729193.JavaMail.zimbra@nod.at>
In-Reply-To: <5a4b5aff-fa90-42e1-bdf7-3a42786830bf@siemens.com>
References: <1209867549.13389.1769444884253.JavaMail.zimbra@nod.at> <5a4b5aff-fa90-42e1-bdf7-3a42786830bf@siemens.com>
Subject: Re: CPU Hotplug Splat
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF146 (Linux)/8.8.12_GA_3809)
Thread-Topic: CPU Hotplug Splat
Thread-Index: 9FFPRfWGQ7WHpFj+MRliRxpakBXhEw==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> 6.17.0-g970519241701-dirty #38 PREEMPT(voluntary)
>=20
> I thinks 6.17 (which is retired BTW) never received this:

Hm, xenomai.org still lists v6.17-dovetail2 as latest.
I'll try a more recent branch.
=20
> https://gitlab.com/Xenomai/linux-dovetail/-/commit/65f59eefa1043e9414b373=
12826de2a0fa07624e

Thanks,
//richard
