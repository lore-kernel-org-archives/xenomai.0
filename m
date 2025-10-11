Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8559917736
	for <xenomai@lists.linux.dev>; Sat, 11 Oct 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760199060; cv=none; b=lA161quF7biOpSsoodr5111F9yGf9FhcTekIBycu3nQGWb1aeQDbH71jq4uOEom4ugiDDtKF5dozCPXrc41TDZxvZNI6gFBA1xVm6YPlhOLp19k64TZzTWb4f9sj0Oweac5/GBaK+YUbYHpqMOYrlUTJJ6jZTHK2ZTJX67NHP2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760199060; c=relaxed/simple;
	bh=cGH8WTEXPXzKE+NkmEJjKVPqzW1753Im8Ap22MNkmyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lm0jz2qUX080U2LPA8DEGLUZZ85yVpaYVkh5tRbOXhNdmG5zA1k3OkemhWMyAnO+eDXUiRkDnLCJhsVyCle6UMVzh7Id8RUZTvqOXByWLlHLbsw4vdqLHzmuaFTa/FVfWQ+YvQF9vBTOsDFWYqN1EbTkUrpMsQGkBcYw39rjtNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=AFMVsLxa; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="AFMVsLxa"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51A9E432BD;
	Sat, 11 Oct 2025 16:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1760199055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m3rm3OrQ4FiDzuGvNYJaky+ARensvfAWIlWxtL7dJlY=;
	b=AFMVsLxabhhgTFcNOiDJEYrYki4Gd0xDzeJd1Y1ACM8YLt87nCan7BOpLbTsSxrJDCEHEH
	R8nh+yDDl66GL/F6zz9YFrgeq7jVz6CPIj3U9+TOCYMNr/tn8ymKx21PykiokOZVc0iJAW
	okgmlrvAJeeRUDtA8J1Zsx5P9479hnhvHz8e3PHLDVqpSPXfcoui00QYSZHC9DNDfGvIAM
	nDDhlIwcKN7gGL8NM3peyHBQ/o2k13KAysymezwuSBKILyrBcKmam1zSAjINIhDP+ffz8e
	XXF9WB7JyUGdN/U3vYTb490jLfDp7pe/6yeDIyfjZb7MHwdUI2WW4P0bBRJw6A==
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>,  Xenomai
 <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
In-Reply-To: <87qzv9sa9c.fsf@xenomai.org> (Philippe Gerum's message of "Sat,
	11 Oct 2025 17:55:59 +0200")
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<87qzv9sa9c.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 11 Oct 2025 18:10:54 +0200
Message-ID: <87ikgls9kh.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org

Philippe Gerum <rpm@xenomai.org> writes:

> Giulio Moro <giulio@bela.io> writes:
>
>>> It seems like latmus is trying at some point access some evicted from
>>> cache memory page...
>>
>>> In my case I do use two simple test programs to allocate C++ <vector> -
>>
>> Thanks, that put me on a path to reliably reproduce this.
>>
>> Swap is disabled. I, then set up the system so that the oom-killer has is easy: it kills the allocating process. This is much faster at executing than going through the list of programs and picking the one with the worst score.
>>
>> echo 2 | sudo tee /proc/sys/vm/overcommit_memory
>> echo 0 | sudo tee /proc/sys/vm/overcommit_ratio
>> echo 1 | sudo tee /proc/sys/vm/oom_kill_allocating_task
>>
>> I then have a C++ program allocating 50MiB, and I run 4 or more instances of it, one per core:
>>  while sleep 0.1; do ./alloc& ./alloc& ./alloc& ./alloc; done
>>
>> Furthermore, I have four instance of dd in the background:
>>
>> dd if=/dev/zero of=/dev/null
>>
>> With that, I can trigger latmus's inband switch pretty reliably within seconds (e.g.: latmus -m -K -p 360). If instead of latmus I run our application, it seems to be even faster and more reliable at triggering an in-band switch (once I set T_WOSS | T_WOLI | T_WOSX | T_HMSIG for the thread), and sigdebug_marked() confirms it is marked as sigdebug. While running it inside gdb I can inspect the backtrace upon receving the signal and it seems to be happening in seemingly harmless places. Most of the time it happens at some depth inside evl_usleep(), sometimes it happens inside libc's sinf(), sometimes somewhere else in our rt thread. I'd guess I just see it happen at random places, so the fact that it happens more often in evl_usleep() it's just because the thread spends 85% of the time in it. Note that our application never uses raw_copy_from_user(): the only call into the kernel from the real-time thread is via evl_usleep()
>>
>> It may be of interest that if I disabled (T_WOSS | T_WOLI | T_WOSX | T_HMSIG) in our application and thus it's free to keep running when receiving an ISW, I can see the number of ISW grows quickly in the first few seconds of execution to something like 20 but then remains constant . Similarly, latmus with -K seems to accumulate several (5 to 10) ISW at the beginning and then proceed without any further ISW for several minutes. They eventually occasionally occur again, but much more sparingly than in the first few seconds.
>>
>> For completeness, here's the C++ program I use for testing. I attempt to allocate memory in smaller chunks and get close as close as I can to filling up system memory across the four processes before the oom kills one of them.
>>
>> #include <vector>
>>
>> int main()
>> {
>> 	std::vector<std::vector<char>> all;
>> 	for(unsigned int n = 0; n < 5; ++n)
>> 	{
>> 		all.emplace_back();
>> 		all.back().resize(10 * 1024 * 1024);
>> 	}
>> 	return 0;
>> }
>
> Ok, so it looks like both of you observe the same issue, which seems to
> be arch-independent. Checking the code which takes care of preventing
> COW for oob-enabled processes (a behavior which may cause unwanted minor
> faults in a tricky way), I stumbled upon a really bad bug. Could you
> check whether the patch below helps?
>
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> index 73de18353e79..c6b1efcbd833 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -91,7 +91,7 @@ static inline int get_dumpable(struct mm_struct *mm)
>  
>  #define MMF_VM_MERGE_ANY	30
>  #define MMF_VM_MERGE_ANY_MASK	(1 << MMF_VM_MERGE_ANY)
> -#define MMF_DOVETAILED		31	/* mm belongs to a dovetailed process */
> +#define MMF_DOVETAILED		18	/* mm belongs to a dovetailed process */
>  
>  #define MMF_TOPDOWN		31	/* mm searches top down by default */
>  #define MMF_TOPDOWN_MASK	(1 << MMF_TOPDOWN)

Note: this issue only affects kernels from v6.10 and on

-- 
Philippe.
