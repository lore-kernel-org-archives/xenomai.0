Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424FB3E7BBD
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501521; cv=none; b=JAuCkZHVjXSvf8OqCPZmPvJww0vPEUnwBWlxMVtKj3o0HWq6Mm4sppnKevXhWVNGkgE/MMU0jxy0GDxXhy9RmIpLYHFW7+bAjM+9JVKnW1U5nbMww1mNdj0p7OfT0VWvW18U85pQsPgDBtI8U/L6Bym2ePaFmNFYWkq8tixJdyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501521; c=relaxed/simple;
	bh=IVFoHv3bhEz6xKsvpLh/FL4AZIIESJETnb4VtuJCvBI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s6iG89yiDaoI1m9Rocv4gfi36VSlNyExs6qit9n+Svq+BwcQyTuVv7EHNp7XdR08priC0GBpGR/f8X6GfbWtE2OXDBENUkSZ38dvcnrdsVJf+uLiXpKAwfdaWMfwiV7rHLSKvMokJiGIyz6wZnpp5mMg0ge8/f/MsIOQbIKcAmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=m7pRq+rl; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="m7pRq+rl"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 70FA43EBF4;
	Wed,  8 Jul 2026 09:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783501517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mDyHs1vA4C059jepF4PzfZs7P1G60KBWxKh9/hCBXtk=;
	b=m7pRq+rlVKOYKphoBZHvDbmWQ0E98gjTOejeOIeiKHN4f9+bN+iH9++eW7SrbfWFx2+yKU
	iR5J+j/U8lYavM6oC5BpLbiG4AVVcmQM9SoqTfCTf0vhpcI+V3X59SZ1WPtghOz1HKRenG
	YhAdN5WQ5NAbZd7HfyUzs8DjaCEJLNnhfXs1z4uWllhfNSzMO9X1RWeuZtb8QeSkR2MA2x
	hjr98xoywXWsEWU4jUSIHp1e81bBU6U3120PnC5J38w2plRd0hxEKAnxW4VUWTR/RSCNwc
	sNfF1caOAKOrxOVRY0HXw3I/QfeRSTkp3TZw6QfwYBTjrxDr6tAvUYfyWjhEnw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [libevl][PATCH 2/2] tests: sched-quota-accuracy: Add preempting
 FIFO thread
In-Reply-To: <255484c0-7955-4bb3-b592-742d4fbd79ed@siemens.com> (Jan Kiszka's
	message of "Wed, 8 Jul 2026 10:03:15 +0200")
References: <83bfeeef-c3b2-473e-b94f-8d270b0a512c@siemens.com>
	<38c143a3-5021-4617-ab2f-ff3c9f3adc74@siemens.com>
	<87cxxlbik5.fsf@xenomai.org> <87jyrta2c2.fsf@xenomai.org>
	<ef230925-f258-4cf5-9fc1-6426167fc819@siemens.com>
	<255484c0-7955-4bb3-b592-742d4fbd79ed@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 08 Jul 2026 11:05:17 +0200
Message-ID: <87o6ghlulu.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTGMooqSGpyutT5cfsQqNKpXa03c+NPrZ1CIgB9+buuRaDOmD7gd+E0qd9JMCM0ALlJb5950QxzjjgTubbUrnwuvt4d76zxK33PkveCOSB8PltEJY2jsEpPahoXCwNSiU+3s8zbFrNChqUdthRwCFvLsjn+lYWzsZ/u3wKfNgqB2y21fALhFCcBoerY70ou8wxuOQpk13cbAgTxAZaUn4sJwyNYQPnu+HT2vaZ0nvUaCQD/5Iq+V9ckIKakQ8KZ9OhQwXWYzTQBLmajh7nGhPB3bva6Yygs0rmf/Rw6tWPRTR9UhaYzUW1SEAq/xRd74z3nXAaHiSBHAT4poyhQgcF3QaVVK90Dd9IDnu5wKiwdtF4PK7zHvf4lHboiL9zwTq7uwLNMVE1a4pNksW+7bhGGLS+OvKfJhJgpl41KNpYRqQNjn2TGhPNF5X52z+zuZMYmFlUEMGI0I73wWQDP9vASTaQw2j2gK6ONTuwkcYwoZfHiKd7mDccb5xFBiFGaX4L/mMPA9iWoI/U8PKqF9MYUm0LZLgrYst0xbdRx3c1X4MBih9dfbtGxyUrDOoFVm6GJtxTgtvt9QQN1LlArovY8UGARKJuDIvey+fs6aLk1sLt+dG31rvzXj1Hjn9pbgA4BfiOaf5W3f46G9sud/ZPcZtQou8/1V3U4n8bnkkpGO2w
X-GND-State: clean
X-GND-Score: -100

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 20.06.26 14:40, Jan Kiszka wrote:
>> On 20.06.26 13:17, Philippe Gerum wrote:
>>> Philippe Gerum <rpm@xenomai.org> writes:
>>>
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> Test that higher-prio SCHED_FIFO threads do not run on the bill of
>>>>> SCHED_QUOTA threads and that their accounting is not otherwise
>>>>> disturbed.
>>>>>
>>>>
>>>> This patch introduced a regression when determining the accuracy of the
>>>> policy with respect to allotting threads the expected runtime budget:
>>>>
>>>> root@phytec-mira-evl:~# evl test sched-quota-accuracy
>>>> sched-quota-accuracy: 494.0%
>>>>
>>>> The proper result would rather be close to the following:
>>>>
>>>> root@phytec-mira-evl:~# evl test sched-quota-accuracy
>>>> sched-quota-accuracy: 99.1%
>>>
>>> Ok, I guess the fact that the calibration process does not factor in the
>>> disruptor explains the full breakage we have with the accounting now:
>>>
>>> root@phytec-mira-evl:~# evl test sched-quota-accuracy -- -v
>>> picked CPU1 for execution
>>> CPU1: calibrating: 893547 loops/sec
>>> CPU1: new thread group #0, quota sum is 10%
>>> CPU1: done quota_thread[0], count=150399
>>> CPU1: done quota_thread[1], count=145636
>>> CPU1: done quota_thread[2], count=141552
>>> CPU1: 3 threads: cap=10%, effective=49.0%, disruption=49.6%
>>> sched-quota-accuracy: 489.7%
>>>
>>> Which does not make any sense since the effective value should be capped
>>> at 10% in the above case, compared to the nominal (full) report which
>>> should be:
>>>
>>> root@phytec-mira-evl:~# evl test sched-quota-accuracy -- -v
>>> picked CPU1 for execution
>>> CPU1: calibrating: 899203 loops/sec
>>> CPU1: new thread group #0, quota sum is 10%
>>> CPU1: done quota_thread[0], count=26818
>>> CPU1: done quota_thread[1], count=26709
>>> CPU1: done quota_thread[2], count=35612
>>> CPU1: 3 threads: cap=10%, effective=9.9%
>>> sched-quota-accuracy: 99.1%
>>>
>>> Dropping this patch from the -next branch for now.
>>>
>> 
>> I would rather recommend taking a trace and debugging the scheduler -
>> this could very likely be remaining issue in the quota fix.
>> 
>
> What is the state of this? How can I reproduce the issue you saw? What
> is specific to the target, what could also be seen over qemu[/kvm]?
>

The task of writing a proper test for evl is ongoing, the overall sched
issue is very much on my radar. I'll follow up when this test code is
available.

-- 
Philippe.
