Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589AF3F788F
	for <xenomai@lists.linux.dev>; Wed, 15 Jul 2026 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107286; cv=none; b=QykOxi6bFi+SB0SFGqCsGb+iYPpnvt1uT9qQaa0SJ7kDutu/sA3/pXR8DPAheT7kY4ibC91MqUlHmxsaCnL2BEz922C14j6gXNGvxwQTBupem9AGU52NtpUZ259WE7rD94PSQEGKhYBIsmnQ8H6B7ma4gAi4RPmWQ3U9jKGNyns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107286; c=relaxed/simple;
	bh=kIyoF6lpvlWOJhpBVWO6hcFZ/8U+2uuCqy5YD33mPJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eeCM4SW/c5lJs9Qiiv0yBOHHoJxhLfN6IYN1llrM699qEv8r3sf4EDL5a0tvhZ85qVj6tEQ6J8h1NGGYww/4/Hj2xgvwW+qechpWAP51AE9Cm2HhoOnTBJxBzoxiPCYWYqXEEtKUtxr3hhR3PVrMIssaPrwsm2cCwDlXp4tNIJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Eka5U24I; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Eka5U24I"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D9FF3E9B9;
	Wed, 15 Jul 2026 09:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1784107275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dDOZvOxF6UO0BcHbCFt8jxkgxBVI1pDQtFf1O3GJWl4=;
	b=Eka5U24I02KiaqydvaoHpCBtkx030d6oftpPEHXv3TPankR/5XmAfddLawbvdj1Yj+h6yo
	8RnLHMqeZ4Y35cDqepWFQK38mZBnLzBq6KWBi85Zg250sTSBvssxlDKz4qpOXbCfSZC02L
	QLLvW41wAqWqtgaHr2J3o/kd2tdA9Ry2d5E2KuuBXaeFtaDEZiytHEWg726IHaQxxX9MEK
	bwVXOVajD2e06ZS/YkfzrvsoI6izVyiNj3r8+YA0iFmDDaP3vHtWfBeyCcZrUWXJQTp8wK
	0wPvOYxtSNue9587P925DkG95JbsJ4uRe7bi/6KnAgU/27JdBGt69+JLO/K9OQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Kevin Strell <kstrell@aerotech.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Xenomai 4 Allocator Fragmentation Questions
In-Reply-To: <CADfsJ_GwXvHioDB_HvGWardrTj_wFJJO-q0QtER42duwZFoi9Q@mail.gmail.com>
	(Kevin Strell's message of "Tue, 14 Jul 2026 16:44:19 -0400")
References: <CADfsJ_GwXvHioDB_HvGWardrTj_wFJJO-q0QtER42duwZFoi9Q@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 15 Jul 2026 11:21:13 +0200
Message-ID: <87mrvsmwvq.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTGAkfZaBdHo5we3QL1DFFUcHlYpXe1G//td8gkvP+Pw7bOGi3qyVLjdjRxiAxD+nUUYeSmNaJ/GChe3XneHTRhEdkuGuuCItcTriQc6hkBrOEYPdM5QiloLlbNIqHriryIfW8XFPyUFJNSPH10JEvpZH7yBaWg9oRiH1mcLc7DfpTBGCC6q7BCz9Lom6LrcsUczKMcMD63nOl+qIAgL+ojQ0UrX7Rd5xHP9Z0djXGgaZqna9J5YzCkPcZd3W/Me80RRjWX8e8Ucw+vYE/sTRez5nVXOONexbL6G5jqGypSNbzqG6ASe7AYEDvc89GJ47jNr5ede3oFObKjUK+30Deu4SxFGdWhwmA6GNQr7lH2aZIfSmLpwiuJGK8DhSxz2tQz8uRvM+mVY2+NgtwZCy9SU4FnZQL/87zdeJcr+KSnwhZt8d+Y2T06Zglz98GB3eNmcldjyPL6Yi8TllWsHGhG8BquiNKG5nAw2ZcexHh7+WdQi6loI+Px8k1Slmi8RyQiGMHegrN+j+0dR/OPb+qSdgbSGEwTIQrMxu9ksQI8xIlAf+l5jDe0+aJ14/kRJ/y0NG5AeFhKyAl52t979pNSKHfQ0Fbm9607E8Jfc3HB9A1eC9oIDTaH2rtvDpdgRq4O5pEhTf+lpBBndKdAPDPRabkxM0it7d9cFMY78mRKMdw

Kevin Strell <kstrell@aerotech.com> writes:

> We are currently using Xenomai 4 on an AM69 on our new prototype and
> appear to be running into fragmentation issues with the default
> allocator while trying to use thread local heaps. After several
> seconds of operation our application starts experiencing allocation
> failures with evl_alloc_block_unlocked returning NULL. Our heaps are
> allocated on reset and we do not extended or otherwise change the size
> of the heaps during runtime. The allocated memory in question is
> allocated out-of-band and is typically under 100 bytes but
> occasionally there are larger allocations. Additionally, we have tried
> running the heap_torture test on our platform and the results do not
> seem good. Pretty much every test with the +shuffle option is showing
> more than 50% fragmentation and many show more than 90%.

I believe that you may be referring to this output of the heap-torture
test specifically:

sorted by: max fragmentation
  HEAPSZ  BLOCKSZ   NRBLKS  AVG-A  AVG-F  MAX-A  MAX-F   OVRH%  FRAG%  FLAGS
     16k       16     1024    1.8    1.9    7.3    4.7    0.0   99.8   +shuffle 
     16k       16     1024    1.8    1.8    5.3    4.3    0.0   99.8   +shuffle +hot
     16k       32      512    1.9    1.9    6.7    4.0    0.0   99.6   +shuffle 
     16k       32      512    1.9    1.9    4.0    4.0    0.0   99.6   +shuffle +hot
     16k       64      256    1.9    1.9    5.0    4.0    0.0   99.2   +shuffle +hot
     16k       64      256    1.9    2.0    7.7    3.7    0.0   99.2   +shuffle 
     16k      128      128    2.0    2.1    6.7    4.0    0.0   93.8   +shuffle 
     16k      128      128    2.0    1.9    4.0    4.0    0.0   93.8   +shuffle +hot

This is expected in the so-called "shuffle" mode, the results are
unfortunately slightly misleading in this case. In this mode, the test
allocates N blocks sequentially from an empty heap, then randomizes the
release of such blocks not to follow the allocation order, so that we
artificially create "holes" all over the map.

When enough blocks have been released (evl_free_block) to amount for
half of the heap size, the test then measures the difference between the
largest block size it is able to allocate next, and the amount of memory
which should be available, in theory. The ratio determines the
fragmentation value in the results above. Clearly, the
randomization/shuffle on free is ruining the coalescence between
released blocks, which shows in the figure.

IOW, heapmem may be subject to fragmentation when an adverse
allocation/deallocation pattern happens, but the one reported by the
test in shuffle mode is extremely unfavorable by design.

>
> We did try the compaction procedure documented on the Xenomai 4
> Caveats page but it did not seem to improve our situation. It is
> unclear to us when the compaction should be triggered. The
> documentation states it needs to happen before mlockall() is called
> but evl_init() makes a call to mlockall() and the latter seems like it
> needs to be called first.
>
> We have been able to avoid the fragmentation problems by switching to
> using the rpmalloc library (https://github.com/mjansson/rpmalloc)
> instead of libevl's memory heap services. All that being said, we have
> a couple questions about the default Xenomai allocator.

The documentation about (system-wide, kernel) memory compaction from the
Caveat section does not apply to heapmem in libevl which is
process-local, operating in fixed-size heaps as defined by the
user. heapmem has no compaction or garbage collection mechanism
whatsoever.

>
> 1. Other than the compaction procedure, is there anything we can do
> with the default Xenomai allocator to improve the performance in
> regards to fragmentation?

Use multiple heaps if possible, to confine the problematic allocation
patterns.

> 2. When is the correct time to run the compaction procedure in regards
> to when we should call evl_init()?

Those are unrelated issues.

> 3. If the fragmentation is a known issue of the default allocator, is
> there any other allocator that is recommended?
>

An allocator which meets real-time requirements while still limiting
external fragmentation to the minimum may be difficult to find because
both goals are somewhat conflicting (notably because garbage collection
may not fit well when it comes to time complexity). You may want to have
a look at respins of the TLSF allocator, some of them were designed to
address the fragmentation issue the original one had - which was the
reason for developing heapmem years ago.

I'm interested by any result in this area, feedback welcome.

-- 
Philippe.
