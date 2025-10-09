Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4C81E3775
	for <xenomai@lists.linux.dev>; Thu,  9 Oct 2025 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016246; cv=none; b=K46aoQisEjVl4ADISw51g7SL8KHMquTTMXbj3SY1NMW3sXEmO+HmMNM19idAGqQST2DCGTpvHAdUuuiw0U+hzniIw4O4qHJN8mNIsW5dwwGiMV6pxKaaHqyWUWuglf0sCTZE0agpo0koTCaRAVfV25QgrV9ayzvzujIjedbqT+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016246; c=relaxed/simple;
	bh=3jVZbJ/LR14NnbWL03vKzUoVx0kgvPnaziDy4mXD5eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCwWrFjOXQuQ6eb1cAqUO2KsLGe+N7GwN8EgBH3maE2Zsvxur+6HXz3MvIsOo6V7k6j0g1wxhBuNt9GatfOYdFQpa2SX5Ryvs2hkG18lg78BEzr5mNMjPf8AFR/tFBV5nHw8BwmVcmQ0fEYI+jtgJtzNdwti3Vis8LVq/k4g6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=X4V/Wa1V; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="X4V/Wa1V"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D8E51034B8;
	Thu,  9 Oct 2025 15:17:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1760015859;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=82KnCs7LgW9ClbV8QnAuydfvmVbXWTNDxhsHR0rLL8E=;
	b=X4V/Wa1VdmBGCN697Xc39S/3pMhJr7uO5rvHoAUm/fHK5aRqEmk2HAjYdNWJIBmw0ivO+j
	gbeUNK0At6C3IetZpBZiPPB382LUZzwztTXIznLnR9CBHC3Q8xMS1ENiNOPgU6yAiKYlmv
	rmrd2ZWrW09ABbz+bA1hCwtsRyXLpNLRqAgvmJzRYokSOOyQeg1j6nCBEKAhHGtf0RWjHz
	ibBAnBaPMI/4pPQqIHTXagRs1fqJ4EKa2WkRgRJSmBrRHFF0+MT2PUGXKuNIUK/f/hoN57
	F7YZqmX67iGgghuje4HYmvyT2/0kZ72n7ac6WVwgGn+Fz7F2gY9W0jg6nh6jQQ==
Date: Thu, 9 Oct 2025 15:17:37 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Giulio Moro <giulio@bela.io>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
Message-ID: <20251009151737.0d03b211@wsk>
In-Reply-To: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
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

> Again, PocketBeagle 2 (TI AM6254). I get errors such as the below:
> 
> debian@BeagleBone:~$ sudo latmus -m -H20 -T 500s
> warming up on CPU0 (not isolated)...
> RTT|  00:00:01  (user, 1000 us period, priority 98, CPU0-noisol)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat
> best|--lat worst RTD|      4.957|     10.135|     22.647|       0|
>  0|      4.957|     22.647 RTD|      4.977|     10.107|     23.112|
>     0|     0|      4.957|     23.112 RTD|      0.948|     14.831|
> 52.911|       0|     0|      0.948|     52.911 RTD|      4.084|
> 9.548|     24.404|       0|     0|      0.724|    122.540 RTD|
> 4.195|     10.080|     50.350|       0|     0|      0.724|    122.540
> ---|-----------|-----------|-----------|--------|------|-----------------------
> RTS|   -982.336|     11.935|  12357.665|      22|     2|
> 00:02:36/00:08:20
> 
> *** WARNING: unexpected switches to in-band mode detected,
>               latency figures displayed are NOT reliable.
>               Please submit a bug report upstream.
> -- aborting
> 
> Possibly unrelated, it also happens that when I run our program,
> which runs with a period of 360us using 15% of CPU, it normally works
> OK, but occasionally I get _large_ underruns (like 3 to 5 ms). I
> haven't started debugging that yet, and I am not entirely sure it's
> EVL's fault, but I thought it may be worth mentioning it here.
> 
> This is on a kernel I put together: I applied the EVL commits that
> are at the tip of v6.12.y-evl-rebase on top of the TI
> v6.12.43-ti-arm64-r53 kernel plus the beagleboard patches. Here's a
> link, FYI
> https://github.com/giuliomoro/linux/tree/v6.12.43-ti-arm64-r53-bb-evl
> 
> I appreciate this may be a bit too far from mainline to ask for
> specific help, but I am wondering what the general approach to
> problem solution is here: what would make a the latmus thread
> unexpectedly switch to in-band?

I can report the same issue on:
https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commits/v6.6.69-evl1-rebase?ref_type=tags

With guidance (and huge help) from Phillipe I'm now ftracing the
evl core with latmus to check what can cause the issue.

In my case I do use two simple test programs to allocate C++ <vector> -
10 GiB of memory each.

It seems like latmus is trying at some point access some evicted from
cache memory page...

The reported switch to in-band (the execution path) seems to be correct
and expected. The real problem seems to be that at some point in time,
the raw_copy_from_user() (at linux-evl/drivers/evl/latmus.c):1126
causes the X86_PF_USER (user mode access) + X86_PF_INSTR (fault was an
instruction fetch) exceptions.

> 
> Thanks,
> Giulio
> 


-- 
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
