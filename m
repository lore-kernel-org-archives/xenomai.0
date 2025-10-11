Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3D2BAF9
	for <xenomai@lists.linux.dev>; Sat, 11 Oct 2025 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760205634; cv=none; b=tgGPEb2SztzAm9A9kVyEyi8Jt2I7XFzJO9B+Byato6K7BqWrwQfIPe/iPSh852CD/P+qmdOiPn+NcKWpd1x24ab+DaCW8XbEq+IcH+CeTGryy7kW0KhUEFzaCUunTHuN/H9yAET5IRh94K64wlqH6kSFsB6bVOB6PNIbl02alyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760205634; c=relaxed/simple;
	bh=PBKGIEHp7XaDB1y1Dpem/rufoLXw7iRVUTo1u7wvFTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oyV0p+TklGyE2SDPxB9UTe/O8PJZJ84QuEAUrxBWqJ+PX+X//8oKLMqYW1LKaBMj11zCxJfd8OVIj4Wf7RP6BsVWtrmutnolijKD1Lcn4jj+U5Yl4adsu7/Gsn0Q+cJ9z/z6NuSASjy8G1ld5hDPsNe0M8VzlQrfNWplynsoSjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=LfTe6W1m; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="LfTe6W1m"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 5BD915806ED
	for <xenomai@lists.linux.dev>; Sat, 11 Oct 2025 17:44:04 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A3B644319;
	Sat, 11 Oct 2025 17:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1760204636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hpwEzfstdSNfkuREwkVWrpIASqxjGBsL0YPBn9V9mCM=;
	b=LfTe6W1mvaQXbI9LYMxMYe7GS8NRoNwbeUPuBbUB0YA3c3oxVwe1lZXXS4RRZIuA9R5wkf
	vSc2JC7CU3K+s4+VVzqxsRhR67tlLN33AHvqGjIvygqR8pABO1cPjvDgqBCZaS+SZUc8y7
	hUNaBU1dPosW/l/YCDGorcy8UvTeHDo6CFYjvMoVff+TUkA9M4mfLnFDy6pHiBtufq0N/J
	AOfULu+LqHcUIkZxiwimoA2Y1ytDExXpyiUZ4gM2nLaSVolPk4ZBuPDMiNILIC7UDpm6xl
	RaRtRo59tefqylKSJdgrp1yjYHNHfy2rDkHVQyw7BxBffZcglVPqWc32iuAQ4g==
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>,  Xenomai
 <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
In-Reply-To: <87ikgls9kh.fsf@xenomai.org> (Philippe Gerum's message of "Sat,
	11 Oct 2025 18:10:54 +0200")
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 11 Oct 2025 19:43:55 +0200
Message-ID: <87y0phqqp0.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org

Philippe Gerum <rpm@xenomai.org> writes:

> Philippe Gerum <rpm@xenomai.org> writes:
>
>> Giulio Moro <giulio@bela.io> writes:
>>
>>>> It seems like latmus is trying at some point access some evicted from
>>>> cache memory page...
>>>
>>>> In my case I do use two simple test programs to allocate C++ <vector> -
>>>
>>> Thanks, that put me on a path to reliably reproduce this.
>>>
>>> Swap is disabled. I, then set up the system so that the oom-killer has is easy: it kills the allocating process. This is much faster at executing than going through the list of programs and picking the one with the worst score.
>>>
>>> echo 2 | sudo tee /proc/sys/vm/overcommit_memory
>>> echo 0 | sudo tee /proc/sys/vm/overcommit_ratio
>>> echo 1 | sudo tee /proc/sys/vm/oom_kill_allocating_task
>>>
>>> I then have a C++ program allocating 50MiB, and I run 4 or more instances of it, one per core:
>>>  while sleep 0.1; do ./alloc& ./alloc& ./alloc& ./alloc; done
>>>
>>> Furthermore, I have four instance of dd in the background:
>>>
>>> dd if=/dev/zero of=/dev/null
>>>
>>> With that, I can trigger latmus's inband switch pretty reliably within seconds (e.g.: latmus -m -K -p 360). If instead of latmus I run our application, it seems to be even faster and more reliable at triggering an in-band switch (once I set T_WOSS | T_WOLI | T_WOSX | T_HMSIG for the thread), and sigdebug_marked() confirms it is marked as sigdebug. While running it inside gdb I can inspect the backtrace upon receving the signal and it seems to be happening in seemingly harmless places. Most of the time it happens at some depth inside evl_usleep(), sometimes it happens inside libc's sinf(), sometimes somewhere else in our rt thread. I'd guess I just see it happen at random places, so the fact that it happens more often in evl_usleep() it's just because the thread spends 85% of the time in it. Note that our application never uses raw_copy_from_user(): the only call into the kernel from the real-time thread is via evl_usleep()
>>>
>>> It may be of interest that if I disabled (T_WOSS | T_WOLI | T_WOSX | T_HMSIG) in our application and thus it's free to keep running when receiving an ISW, I can see the number of ISW grows quickly in the first few seconds of execution to something like 20 but then remains constant . Similarly, latmus with -K seems to accumulate several (5 to 10) ISW at the beginning and then proceed without any further ISW for several minutes. They eventually occasionally occur again, but much more sparingly than in the first few seconds.
>>>
>>> For completeness, here's the C++ program I use for testing. I attempt to allocate memory in smaller chunks and get close as close as I can to filling up system memory across the four processes before the oom kills one of them.
>>>
>>> #include <vector>
>>>
>>> int main()
>>> {
>>> 	std::vector<std::vector<char>> all;
>>> 	for(unsigned int n = 0; n < 5; ++n)
>>> 	{
>>> 		all.emplace_back();
>>> 		all.back().resize(10 * 1024 * 1024);
>>> 	}
>>> 	return 0;
>>> }
>>
>> Ok, so it looks like both of you observe the same issue, which seems to
>> be arch-independent. Checking the code which takes care of preventing
>> COW for oob-enabled processes (a behavior which may cause unwanted minor
>> faults in a tricky way), I stumbled upon a really bad bug. Could you
>> check whether the patch below helps?
>>
>> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
>> index 73de18353e79..c6b1efcbd833 100644
>> --- a/include/linux/sched/coredump.h
>> +++ b/include/linux/sched/coredump.h
>> @@ -91,7 +91,7 @@ static inline int get_dumpable(struct mm_struct *mm)
>>  
>>  #define MMF_VM_MERGE_ANY	30
>>  #define MMF_VM_MERGE_ANY_MASK	(1 << MMF_VM_MERGE_ANY)
>> -#define MMF_DOVETAILED		31	/* mm belongs to a dovetailed process */
>> +#define MMF_DOVETAILED		18	/* mm belongs to a dovetailed process */
>>  
>>  #define MMF_TOPDOWN		31	/* mm searches top down by default */
>>  #define MMF_TOPDOWN_MASK	(1 << MMF_TOPDOWN)
>
> Note: this issue only affects kernels from v6.10 and on

Actually, this issue only affects v6.12 among the kernel releases we
currently maintain, v6.16 is fine.

-- 
Philippe.
