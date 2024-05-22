Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F15A1CD13
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 06:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716360206; cv=none; b=QF5IsQ88Qlh8ZXVhJrF2iJxAPKvtT90tcD9r/7UWu3ML8PBzY+m9xO1l9B5jy7p1R6gJLuViB2Hfkf6qmBeuP+Fpbg51wTkvjjJ/AIiGLbZW8NVWO0uhqY7JIGkeWbWGpYU3m6O/ZrZ2XEHCEZmPvGqfdkjep1YFq4OQE3PKn40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716360206; c=relaxed/simple;
	bh=fpYdA7tad0tTgX3s1lR4HLre7Tyx4RvKmED+gMqYTi8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ucaI5HseuSFUvgVOVqLlhmyCukjD263RMD7JXyyYT0O9C/3xIoJUcVc338HPYluwCv5OgcZUgcM7nmlj3zj8X7p8gbGlzxH12L43giTfPLaPHrVyZWbeE/R5p6CKxcjxP8TOvAqT/pV1xZGUIqQo2xyNxl4xkQwcHhrpYOx8ACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 309286195FFE;
	Wed, 22 May 2024 08:43:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id klX29m61CBwM; Wed, 22 May 2024 08:43:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C03836093341;
	Wed, 22 May 2024 08:43:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CVjYRAg_qd9Q; Wed, 22 May 2024 08:43:14 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id A31916195FCA;
	Wed, 22 May 2024 08:43:14 +0200 (CEST)
Date: Wed, 22 May 2024 08:43:14 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
Message-ID: <1792993044.132105.1716360194595.JavaMail.zimbra@nod.at>
In-Reply-To: <ba5e0fc8-e2fa-4495-9cf2-69f0ed2d1621@siemens.com>
References: <20240518112703.30713-1-richard@nod.at> <ba5e0fc8-e2fa-4495-9cf2-69f0ed2d1621@siemens.com>
Subject: Re: [PATCH] [RFC] prepare-kernel.sh: Add reverse mode
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: prepare-kernel.sh: Add reverse mode
Thread-Index: Grmkx5+zAYeKbDR8nQrtlO8dPs6mhg==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> Indention is inconsistent - to the degree the existing one of
> tabs+spaces in the script is considered consistent.

Yeah, the whole script is a mess wrt. indention.
I have prepared a patch which converts the whole thing to tabs.
>> +if test x$reverse =3D x1; then
>> +    if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; =
then
>=20
> Won't linux_arch soon be a list of archs?

Yes.

In my WIP branch I have glued everything together.
https://gitlab.com/Xenomai/xenomai-hacker-space/-/commits/rw/prepare_rework=
/?ref_type=3Dheads

> I like this as it obsoletes my local script :). Just minor notes, and
> please make sure it goes will with the any-arch patching extension.

Sure. Beside of other fixes I've managed also to get rid of /bin/bash and
changed the script to POSIX shell.
shellcheck is now happy up to warning level.
Info level still gives tons of suggestions I have to review.

Beside of that, what's do you think about the --filterkvers, --filterarch, =
--default and --forcelink
switches?
IMHO we can drop them. I don't see much use in them except of adding comple=
xity.

Same for --dovetail, since no release patches are made anymore.

Also, do we really need interactivity?
Currently the script can ask the user for the paths to Linux and the doveta=
il patch.
IMHO everything should be controlled by command line switches, no script ch=
itchat needed.

Thanks,
//richard
