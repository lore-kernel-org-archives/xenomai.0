Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E269838B7D9
	for <xenomai@lists.linux.dev>; Thu,  7 May 2026 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157175; cv=none; b=NahM8jIJwt3rRLlM9c4dKdyzKG4yw5YDSNJeo30jOU/COM27x4WtxW9cwDKRxeCOZeBxoUIzsTDMWKwRTN0L7uddV06qzkYgxSuwGZxkvGsk8qT4hP+QXPQi4OJWy97LSFHfzrSyxhkZLcqy9fAuZgv0IqTUIN0d5OM+0a9Se5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157175; c=relaxed/simple;
	bh=/NskADcCTMlH6sYxwsFKQPN6UWmEi/Q7EmfrSAslQGA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=UsC8JoMAdbuomCkjRoy/+AVtGb8RZzXDZmke0LDY88NDUAGSSMgSyNC1DDSRj18opcewwEPobtolf2fg3oeOoH/zcLcSWZ1iXclneWqDAfVsQj8Jd/0WKMXpZBX1V/Vm9LrPXNPFMt323/45zu27r4dh/ldjpERjv/RNV8pn20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 40D28298580;
	Thu,  7 May 2026 14:32:52 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id raGIspHa6ujL; Thu,  7 May 2026 14:32:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B9B5C298599;
	Thu,  7 May 2026 14:32:51 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ChOh2fOzSsXA; Thu,  7 May 2026 14:32:51 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9104F298580;
	Thu,  7 May 2026 14:32:51 +0200 (CEST)
Date: Thu, 7 May 2026 14:32:51 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>
Message-ID: <1863085876.2350.1778157171370.JavaMail.zimbra@nod.at>
In-Reply-To: <945cb32c-88ea-41fa-8223-f3d1e639e9d9@siemens.com>
References: <20260507122357.2463483-1-richard@nod.at> <945cb32c-88ea-41fa-8223-f3d1e639e9d9@siemens.com>
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
Thread-Index: lAkZcxnN9ez55HTOXs55ihYCtEQM3w==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> An: "richard" <richard@nod.at>, "xenomai" <xenomai@lists.linux.dev>
> Gesendet: Donnerstag, 7. Mai 2026 14:26:37
> Betreff: Re: [PATCH] Add build time guard to detect off_t mismatch

> On 07.05.26 14:23, Richard Weinberger wrote:
>> When Xenomai is built without _FILE_OFFSET_BITS=3D64 on a 32 bit system,
>> which is the default, but the Xenomai application itself is built later
>> with _FILE_OFFSET_BITS=3D64, we get a nasty ABI mismatch. Since only ver=
y
>> few cobalt syscalls use off_t, the mismatch goes undiscovered for a
>> surprisingly long time. In my case it surfaced only after a realtime
>> application which uses mmap() failed sometimes at mmap() depending on
>> what functions it called before mmap(). In the good cases it used to
>> work by chance since the extra bytes used for off_t on the stack were
>> zero.
>>=20
>> To save the next person in the same situation a lot of time, compute
>> the size of off_t at configure time and compare it against the
>> application's sizeof(off_t) via a static assertion in a new generated
>> header, which is included when building Xenomai applications.
>>=20
>=20
> This should have been resolved (but apparently we missed most of it) by
> 0bb6608b6fa7129de1ff4213ddf31298616cbf23. Can you name some of the
> remaining mismatches?

In my case it was just mmap(). But wouldn't it hurt at any function
or data structure exposed by Xenomai which uses off_t?

So, I suggest applying my change as safeguard mechanism.

Thanks,
//richard
