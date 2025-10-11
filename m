Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3333246793
	for <xenomai@lists.linux.dev>; Sat, 11 Oct 2025 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760197076; cv=none; b=iK5tXwEfi/95e87YH1TtpfEY1TM5978SvGMhXpH3nd2/wRBeZmkb2+l2mXqtp3x618u7ht8F/DheM56r3FTQMwXG8nh4tA/oIrFPoRr9ZLuZpAcoAWpqrOxt0pnOFHE30LBOKdywlQ9QFXomjjvn5J7i9Bs1RlqVIaZ8TJF703k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760197076; c=relaxed/simple;
	bh=R4GODwW4yv6Be9wTL5Xjb36idhPXdb//xf3+nMYCtl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=namahw0BSkrwkj1q98d1jBAjzHJ0MW1rkTR/kXQD5tn+J1xm9jhmDPliP7jhjgLF0x/5zyfsomwy9MN8OyZ1eJbPz473LRBOUqim7UdEToap41QjYOFdTfVSAZR2idbEEfRgv44VkdVM1kpaeMQmVrB9y5iWdmv2GNm4B0r4ea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=b9AJeOhB; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="b9AJeOhB"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 562F044357;
	Sat, 11 Oct 2025 15:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1760197071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+9ws+Z5LCC+z7beAk7E1jhO5RR8jAeS0o3Oqm62pUEM=;
	b=b9AJeOhBZDTr1TmC0iTxpk2lN9w7sPQyO8ZJGvjZbGAMWHIDX1Pz/s17k3DB0yxaddzuyR
	E3Ino/bO/a/gFFhsNfcfAlC8aMNHoNLP82wqv6OTmoXhgjb/gxyQFDDwEjPcg9s2tlCDnZ
	1X+6E9zLhiXscYPiaBp80Lm1QFHIF+JxyIJuwvAUz5KyyesvWnqhNv2ryl7T2U3YN6cT/n
	t24Td0yJWsj+dcwEb1NuT/5WTYX6j1CyUk5PIWgjUbJNqjea3YRt8vEDvZq1TSvrnATN3n
	IOihD5bIw8cNDtM0AURAawnrSNLpD36oK5zS9dWe4fZl9AbzTvjUPY9r/uM+qw==
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
In-Reply-To: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io> (Giulio Moro's
	message of "Wed, 8 Oct 2025 23:33:03 -0500")
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 11 Oct 2025 17:37:50 +0200
Message-ID: <87wm51sb3l.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Hi Giulio,

Giulio Moro <giulio@bela.io> writes:

> Again, PocketBeagle 2 (TI AM6254). I get errors such as the below:
>
> debian@BeagleBone:~$ sudo latmus -m -H20 -T 500s
> warming up on CPU0 (not isolated)...
> RTT|  00:00:01  (user, 1000 us period, priority 98, CPU0-noisol)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
> RTD|      4.957|     10.135|     22.647|       0|     0|      4.957|     22.647
> RTD|      4.977|     10.107|     23.112|       0|     0|      4.957|     23.112
> RTD|      0.948|     14.831|     52.911|       0|     0|      0.948|     52.911
> RTD|      4.084|      9.548|     24.404|       0|     0|      0.724|    122.540
> RTD|      4.195|     10.080|     50.350|       0|     0|      0.724|    122.540
> ---|-----------|-----------|-----------|--------|------|-----------------------
> RTS|   -982.336|     11.935|  12357.665|      22|     2|      00:02:36/00:08:20
>
> *** WARNING: unexpected switches to in-band mode detected,
>              latency figures displayed are NOT reliable.
>              Please submit a bug report upstream.
> -- aborting

Could you please checkout out the documentation regarding the 'latspot'
(f)tracepoint which the evl core implements [1]? This tracepoint is
specifically designed to help in finding the reason for delays in the
latmus program (you could use it in your own app as well).

>
> Possibly unrelated, it also happens that when I run our program, which runs with a period of 360us using 15% of CPU, it normally works OK, but occasionally I get _large_ underruns (like 3 to 5 ms). I haven't started debugging that yet, and I am not entirely sure it's EVL's fault, but I thought it may be worth mentioning it here.
>
> This is on a kernel I put together: I applied the EVL commits that are at the tip of v6.12.y-evl-rebase on top of the TI v6.12.43-ti-arm64-r53 kernel plus the beagleboard patches. Here's a link, FYI https://github.com/giuliomoro/linux/tree/v6.12.43-ti-arm64-r53-bb-evl
>
> I appreciate this may be a bit too far from mainline to ask for specific help, but I am wondering what the general approach to problem solution is here: what would make a the latmus thread unexpectedly switch to in-band?
>

Something happening in kernel space and/or at machine level (CPUfreq
event, NMI and so on), so the best way is to enable ftrace to track this
issue down.

> Thanks,
> Giulio

[1] https://v4.xenomai.org/core/commands/index.html

-- 
Philippe.
