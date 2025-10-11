Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B1F18A921
	for <xenomai@lists.linux.dev>; Sat, 11 Oct 2025 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760199308; cv=none; b=CKIWz6yGol/EvY8JikMBwZhKOAGWDPHeKoh0IzI/PKevySaIxs4b8fVVP8c4jpA7HZAh7SbQFcF1F9afz0SzzVyBrcz88sdPaX5Uw8wdYpmak2GHy7QHKVaVqBb2uJQLpxpzkKu9gI/lPtYbXmqZoazuFp3s2h5+ykRp8fSuuXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760199308; c=relaxed/simple;
	bh=l9vQ5MIi7Ob7fL90cTgROmYV/Qz3PTARkzzCXAiYDzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hm1zcAVvRDIOXLaSSfXu2RTw2vaNm9rCWppoiGoLUWX6Un0SHfoeRfYB7GHPpUS+zLyUplC5ZfB3x0EInFxYC/eMVAg2vk9u41qutBLZHnYIi3Va3SPU1hqs4H9vb/xduEXaHaAeq2SwroJjyiSgtqUDqDQk3faBTWjNWrsX+Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=KRkJ1NTH; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="KRkJ1NTH"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 23CC8580614
	for <xenomai@lists.linux.dev>; Sat, 11 Oct 2025 15:56:08 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E82544427;
	Sat, 11 Oct 2025 15:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1760198160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jo/9W88wvFHpbbStxhP6veTdjGCdrE73gZMJTSB/PGM=;
	b=KRkJ1NTHFFm/9mAg2Y2xHy1j1IhWi04bqDd+UxAqSR/6Pp/Ck3NZJAFZucCtzewf4D4+y9
	IkOBiLy1GCHV+9UCH73BgSSi7GeXTk2/3sEOkCvZySOWpA6jS7eRr36RwSQ+1eeqjeKKUI
	hli8u7p2Pzaj7k5EWnoebvwtpma88hen/QBSDW9HXCd247AqoEKpRVeMDm2+SFenTD/ekS
	W7v2mhztW21y7bTrBlITwyqTnyLQw+5SXap6NBtbsmI5x7++oguoOG7Zs8r7s3XPuQCYy1
	re/2TPzDy/2FyW1g0sVk8718vdFOp6bxXUgURGroTwkUrIt1Yld+dSR6rvNHWg==
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>,  Xenomai
 <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
In-Reply-To: <20676160-4572-d92d-4b33-ff4255946345@bela.io> (Giulio Moro's
	message of "Thu, 9 Oct 2025 14:05:27 -0500")
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 11 Oct 2025 17:55:59 +0200
Message-ID: <87qzv9sa9c.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org

Giulio Moro <giulio@bela.io> writes:

>> It seems like latmus is trying at some point access some evicted from
>> cache memory page...
>
>> In my case I do use two simple test programs to allocate C++ <vector> -
>
> Thanks, that put me on a path to reliably reproduce this.
>
> Swap is disabled. I, then set up the system so that the oom-killer has is easy: it kills the allocating process. This is much faster at executing than going through the list of programs and picking the one with the worst score.
>
> echo 2 | sudo tee /proc/sys/vm/overcommit_memory
> echo 0 | sudo tee /proc/sys/vm/overcommit_ratio
> echo 1 | sudo tee /proc/sys/vm/oom_kill_allocating_task
>
> I then have a C++ program allocating 50MiB, and I run 4 or more instances of it, one per core:
>  while sleep 0.1; do ./alloc& ./alloc& ./alloc& ./alloc; done
>
> Furthermore, I have four instance of dd in the background:
>
> dd if=/dev/zero of=/dev/null
>
> With that, I can trigger latmus's inband switch pretty reliably within seconds (e.g.: latmus -m -K -p 360). If instead of latmus I run our application, it seems to be even faster and more reliable at triggering an in-band switch (once I set T_WOSS | T_WOLI | T_WOSX | T_HMSIG for the thread), and sigdebug_marked() confirms it is marked as sigdebug. While running it inside gdb I can inspect the backtrace upon receving the signal and it seems to be happening in seemingly harmless places. Most of the time it happens at some depth inside evl_usleep(), sometimes it happens inside libc's sinf(), sometimes somewhere else in our rt thread. I'd guess I just see it happen at random places, so the fact that it happens more often in evl_usleep() it's just because the thread spends 85% of the time in it. Note that our application never uses raw_copy_from_user(): the only call into the kernel from the real-time thread is via evl_usleep()
>
> It may be of interest that if I disabled (T_WOSS | T_WOLI | T_WOSX | T_HMSIG) in our application and thus it's free to keep running when receiving an ISW, I can see the number of ISW grows quickly in the first few seconds of execution to something like 20 but then remains constant . Similarly, latmus with -K seems to accumulate several (5 to 10) ISW at the beginning and then proceed without any further ISW for several minutes. They eventually occasionally occur again, but much more sparingly than in the first few seconds.
>
> For completeness, here's the C++ program I use for testing. I attempt to allocate memory in smaller chunks and get close as close as I can to filling up system memory across the four processes before the oom kills one of them.
>
> #include <vector>
>
> int main()
> {
> 	std::vector<std::vector<char>> all;
> 	for(unsigned int n = 0; n < 5; ++n)
> 	{
> 		all.emplace_back();
> 		all.back().resize(10 * 1024 * 1024);
> 	}
> 	return 0;
> }

Ok, so it looks like both of you observe the same issue, which seems to
be arch-independent. Checking the code which takes care of preventing
COW for oob-enabled processes (a behavior which may cause unwanted minor
faults in a tricky way), I stumbled upon a really bad bug. Could you
check whether the patch below helps?

diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 73de18353e79..c6b1efcbd833 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -91,7 +91,7 @@ static inline int get_dumpable(struct mm_struct *mm)
 
 #define MMF_VM_MERGE_ANY	30
 #define MMF_VM_MERGE_ANY_MASK	(1 << MMF_VM_MERGE_ANY)
-#define MMF_DOVETAILED		31	/* mm belongs to a dovetailed process */
+#define MMF_DOVETAILED		18	/* mm belongs to a dovetailed process */
 
 #define MMF_TOPDOWN		31	/* mm searches top down by default */
 #define MMF_TOPDOWN_MASK	(1 << MMF_TOPDOWN)

-- 
Philippe.
