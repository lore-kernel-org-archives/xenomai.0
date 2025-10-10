Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A0222587
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091874; cv=none; b=U5qqwHacjyMgKFl1mYEYSvNcLm86bbncW8uNNUYVCSZdla+LEsVubMOSOI2IRKlh/9M9ZNcLYzxD6zuSwaR8B82uv2cws4dp7+JUcewQMC8ItPUtuQXatt7NkdGU9XigJwJ2lkeQYejueFJsZ4FWukDT5hTqcpfbFHZDSC2+I2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091874; c=relaxed/simple;
	bh=Swpw3dI6RkHkmvPIzYBzY3nLoGGn1oqQqaG1DVycCsM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwTIRiNFelQtTjVDfIgdIYUhDHE5oNwoEtQKl3+/6WZSl4y+L4HnYT6Ek0QqnDxetd986wGy/ebK6fDZ205RM8L9ZUEc6vkwR0BADgqNcEXMpy4OmxLz9o0h6GynwTQl22lCni6VTccXH6zQD6L0Z6GEUFUD8UXV7muvrARfZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=YlDqhqPY; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="YlDqhqPY"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C857410517F;
	Fri, 10 Oct 2025 12:24:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1760091869;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uw/kXurjkAFMHtoUZEjwt8nIT4dGzBOGsik0uzwHMW0=;
	b=YlDqhqPYdZySP4yQEcNbu4jtlYhmELfHWwjjYAPqMg8zP1sVFY16R8qAHXT51Agt5bdMb0
	rgwk5mBsGt6hdKozKhYQmDSCJZuOaGVFuk2Y0OMGlRz75h3eKWcT7AeJtjEYFzrDTUXi+2
	MxCnvqIj5OnjN51y3Qs4qbYx/W9pCLE6kig+QbUMPhkGon8q8nsb5iOel95uOwWtpOSDxn
	lZJFWaosRJh8mh8j58AFxMAahKUSD+lcV+/YYEZu706lRI+HUZ82OV2A/ATXjbyHCF2zjF
	fAyb/fL0pkg75zuW2Lb0W7t+WoriD4Chi15CFhBOFPwNOFhCTBcbNuuhKKYZpQ==
Date: Fri, 10 Oct 2025 12:24:27 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Giulio Moro <giulio@bela.io>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
Message-ID: <20251010122427.54ebb9ac@wsk>
In-Reply-To: <20676160-4572-d92d-4b33-ff4255946345@bela.io>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Giulio,

> > It seems like latmus is trying at some point access some evicted
> > from cache memory page...  
> 
> > In my case I do use two simple test programs to allocate C++
> > <vector> -  
> 
> Thanks, that put me on a path to reliably reproduce this.
> 
> Swap is disabled. I, then set up the system so that the oom-killer
> has is easy: it kills the allocating process. This is much faster at
> executing than going through the list of programs and picking the one
> with the worst score.
> 
> echo 2 | sudo tee /proc/sys/vm/overcommit_memory
> echo 0 | sudo tee /proc/sys/vm/overcommit_ratio
> echo 1 | sudo tee /proc/sys/vm/oom_kill_allocating_task
> 
> I then have a C++ program allocating 50MiB, and I run 4 or more
> instances of it, one per core: 
> while sleep 0.1; do ./alloc& ./alloc& ./alloc& ./alloc; done
> 
> Furthermore, I have four instance of dd in the background:
> 
> dd if=/dev/zero of=/dev/null
> 
> With that, I can trigger latmus's inband switch pretty reliably
> within seconds (e.g.: latmus -m -K -p 360). If instead of latmus I
> run our application, it seems to be even faster and more reliable at
> triggering an in-band switch (once I set T_WOSS | T_WOLI | T_WOSX |
> T_HMSIG for the thread), and sigdebug_marked() confirms it is marked
> as sigdebug. While running it inside gdb I can inspect the backtrace
> upon receving the signal and it seems to be happening in seemingly
> harmless places. Most of the time it happens at some depth inside
> evl_usleep(), sometimes it happens inside libc's sinf(), sometimes
> somewhere else in our rt thread. I'd guess I just see it happen at
> random places, so the fact that it happens more often in evl_usleep()
> it's just because the thread spends 85% of the time in it. Note that
> our application never uses raw_copy_from_user(): the only call into
> the kernel from the real-time thread is via evl_usleep()
> 

I can also confirm that the issue appears at random places. Apparently
this is determined by the affected pages content.

Another viable observation is that:

1. This issue was not observed with Xenomai 3

2. After the "first" occurrence of the in-band switch in latmus, when
it is started again, the issue cannot be reproduced any more. The
conclusion here is that the issue is with "startup" or "fresh"
configuration of memory subsystem with dovetail.

> It may be of interest that if I disabled (T_WOSS | T_WOLI | T_WOSX |
> T_HMSIG) in our application and thus it's free to keep running when
> receiving an ISW, I can see the number of ISW grows quickly in the
> first few seconds of execution to something like 20 but then remains
> constant . Similarly, latmus with -K seems to accumulate several (5
> to 10) ISW at the beginning and then proceed without any further ISW
> for several minutes. They eventually occasionally occur again, but
> much more sparingly than in the first few seconds.
> 
> For completeness, here's the C++ program I use for testing. I attempt
> to allocate memory in smaller chunks and get close as close as I can
> to filling up system memory across the four processes before the oom
> kills one of them.
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



-- 
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
