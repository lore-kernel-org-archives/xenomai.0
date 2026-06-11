Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2125366048
	for <xenomai@lists.linux.dev>; Thu, 11 Jun 2026 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781165411; cv=none; b=D80r/64OdXihXiTlQK1RizNFYXDmmX4VxZUcpTPnhCwdiZP/PJoXm13KZPlBhTkXYUwLmoKGUowyfxj/74QpLlMfe+kqImO0xfjKgnnFeUeB62EfkVH+Oj72pCOgLEPReaQQA3wlGs/hT/svKTQTw7SZCGzua3vZrIYPx08fAjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781165411; c=relaxed/simple;
	bh=LFUrw1MDNzwp2W3uq2+xaHa5CjQ4nw4bnM3upuddXzY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=orE1yXvIRQgpCdwbUz2ML2fi1G4a2gZSJZeU95wySDEQh4ed/8pkHyRD/ml8VHZgo02023gJAM76bVDpT/ucu0Qm1iOLvVeHanon2RMSl1y3hHSXpWeJnPjK9bfRrkuZp2hL6V+Aj3O769w0UyuNe2G5k+KQOpz3Fe/dM6+VVy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=l0s1KoYJ; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="l0s1KoYJ"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 873A9583E34
	for <xenomai@lists.linux.dev>; Thu, 11 Jun 2026 07:33:23 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 562B61F68F;
	Thu, 11 Jun 2026 07:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781163196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=usv6EwnWcXE6MVXJwaJA790RLy0ZZDgHbWPJrS20HD8=;
	b=l0s1KoYJhNaKVliaJR2i7ZFeUEz3R7z9ESHLjzOlaLhQH/K+VQp7aYwR6RGycy7DRquMzS
	6WPvWCZ5HpCv7nTW0A9fpns20x0V3Y6zSGRewxFrZv/iDvbEy//ffCctKQodBPxP63v9II
	bElhlTfuo9+kWWM++e7WsS9x3aTa4lwxuTxGTJ1hZX+QQDl4fiQH+sQy9x6VycjnWUHO3s
	6ytBypE+d3345g3DWQetYtze83aaiYaBvEdZA6aG66703HbUF7RbkYX2r7sovyTKVXozA/
	so6ZOJDUNM+n2uoRfDYbX9ibMdB5pxJ+RF5LZCnwM3lhNpPePFEFS8Ua7UvcJQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: SCHED_SPORADIC in Xenomai 3
In-Reply-To: <19c8bc29-9eb5-4265-931a-1cc5c34ba1ac@siemens.com> (Jan Kiszka's
	message of "Wed, 10 Jun 2026 08:24:31 +0200")
References: <19c8bc29-9eb5-4265-931a-1cc5c34ba1ac@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 11 Jun 2026 09:33:12 +0200
Message-ID: <87cxxxcz0n.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGxg5U9/dtka28ZUo9OxmQmUPIiZSVi5FOCXf4jsU92oH+tEIpAhTOlYWbUhDSLUZL/2ugn9gTOV/191KdnmBoHggaFPLRA4V5fFTG4OcYiM83Z7pPM3RSbvTq+BBs1gdnGJ0xdaqCiNIn1g+cBFQSg9F8Gjq9wqtU4QVQEeNafja3ttuW2/rGUdM/lg5b1sLUQ1mtmDjdAZlSsitMFPtXLf2C2kFclduAL1gYOc3gb+L+irG96fX8Tp6APKi9TWFbGqHvib9FrHPHIh3mgbUeNs7h9KqIya1ewsSDpUZAhNvg8rzXjpDwVf2IY0i+zlcsjA37cC8do/s7Jd6TNDtjzo+LUozpLCX6moDuxZhQ7p80fHaWRD6S4OLxtuw4+I5REzEsmU0Y+AVRpBET/cUHK9n70b07PGEIt4BYKTtg/i7JlZ/ptO8KBjEPkSw9+pUVgHxM+56maekEPXa5abbR9K0i7a6TFw5iu/fIa2lEQGh5H2MWbnGqntPw987YRjpFqfO+ZFgzv078DNti6UjO5ZzXTvXvy9DQHmgBwGXvjXmteNZJ9NqLuaNerlXi6MyIxqWi6yI3qEPfDeZ+Pk7pSAW/G6ymAOrJCpE7FgJaa7NyWcCUV4yviAl4vKTKel7ZAc0HFeoZCJOqc9ZKfCkbG3JqI7774tia9pneDZkmTKQ


Hi Jan,

Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> while trying to port the signal-while-suspended fix to Xenomai 3, I ran
> into XNHELD, a state only existing there. I suppose that was once
> forward-ported as EVL_T_HALT. The only user of XNHELD in Xenomai 3 is
> SCHED_SPORADIC - so let's dive into that scheduling class.
>
> Turned out it was never documented, not even linked to the POSIX
> standard. But it also slightly differs from it (low_prio = -1 -> suspend
> on depletion). There is also no test case, so I asked an AI for one.
> That worked fairly well as it seems to have revealed an issue:
>
> Could it be that we are not properly suspending the budget tracking when
> a higher-prio task from a different scheduling class is preempting a
> sporadic thread? It looks like that xnsched_sporadic_pick is not invoked
> if a thread is selected from a higher-prio class first, namely sched-rt
> with its weight 4 vs. 3 if sched-sporadic. Or is that an (undocumented)
> limitation/misconfiguration? Is that issue even affecting other
> time-slicing classes as well??

Yes, this is a systemic bug. We need to tell classes that some thread of
theirs is scheduling out.

>
> That furthermore makes me wonder if we actually have users of
> sched-sporadic. Likely a hard to answer question, as usual. But such a
> limitation should have been observed earlier under real workload...
>

I only know of one user, back in 2009. Never received any feedback since
then.

-- 
Philippe.
