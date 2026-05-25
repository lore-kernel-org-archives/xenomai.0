Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C211E283FCF
	for <xenomai@lists.linux.dev>; Mon, 25 May 2026 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729244; cv=none; b=ZJslbDjG4CUVm0Bp+wH5XXVrFB6TSNOlP6WUVAa1OOAIKXJpxGXssAIVVq2wlnWT0XimhzZdqZRyiyZUsjx71mAFtSG2+kKGu5SmJ2WU/1BUIhnlQIW0boPSJEN64hwIuLorlw6iZ0XrERATkm6C+VOLrdF21NQIpJRkaTSjCIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729244; c=relaxed/simple;
	bh=zvRGC0qH4S5x32XeOukDh/s8iq5F2pwzSZc8bYgim3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FeSrZSHwobNqp+anphO+fFl9pKJE5mTicq62OaKEXja0P/WTvWVqR/XzfKVg0mV8YKsqliwWuqTrPeECB3xnTB9XDzCWDf4PunzQaQrdst14HF2ZOZifuelscjxaczYgWKvufHKjkrkVEAbRrOJYaRJSwdWPCdHO5EiWsyJCvbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=GyTAY6VK; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="GyTAY6VK"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75D7A2066E;
	Mon, 25 May 2026 17:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1779729234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sSDh/gPr/9Txt5wQS1ZNDgcq6SBLXUCRSh0epRfgOEQ=;
	b=GyTAY6VKjAoAXcUzmD/fXDavtO5GU6QqOLH5FXgmRKSAD+GUEkJ9FXmnZwCJAjfuL0G/Lf
	xONvWeeT8V2osvWaCszMEIyiAokgbuaF9qoaEzel2s9VMYjCRsNpq2UNuP8tfDjO315EaH
	CABslwzoshaLX/n0OikYmzlLj2PW5IgPRACgj4sIobg3Wd1XNALe0LK/9FrVe89Xl7jDWz
	+KZp+xn2o+Ly2d56TYXtBUH2DozKAZdm6QZBLqgXb55gC28LQKmsdHErBdcFtBPkOq/qq1
	r6Qs6w1WadAhKB4452RaGPA2mVI8RwL5t8sD1OQqlq6tahPCk0ta48Tc5h24pQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [EVL] Unstable with kernel command line nohz=on nohz_full=2-3
In-Reply-To: <2de2080d-4d32-40ab-8c6f-652260c04e5e@gmail.com> (Hannes
	Diethelm's message of "Sat, 23 May 2026 12:42:24 +0200")
References: <2de2080d-4d32-40ab-8c6f-652260c04e5e@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 25 May 2026 19:13:53 +0200
Message-ID: <877borpg32.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFshkZ6woAKwOFCxahR3D6RWJGLcpghdNFbBVUQQ2A7p4Nxf0ZCC9lG1nxibZ6OikJGgeY7JXa3EUU7sVX2yM39wGtrjA9MxN88mPnsspgR/8eWCyNPOTd3S4Sk92/Y7DBIZrS3GpXKh0sJqg8ZkXJiQC6xpVro831C2r1UJ6duWEAxBEHXUW6E/cQqQfkXlnhvTvgW92MdJ1kNho5dqGesviTDtaqeIMR0DeVc9b3bIYOR0VdOMJbtCOhXUBYDUWkmapNUY5EkRbGry0IXm/TsqTIxxj31YJSQqfe2XovMCO4nDO1Yah4uU7fktGC5jGHvXhdT1d122c8fUDjTM9dzX7a7j9H9YPAy4Fw2tO2cddsfjoNuh8U9Goo09suKztH1zrztEUcU0E8jg3Ut/GAYGpIYV2wTTFFFYLtB9rZVCKiIpZUEBw+kk9fp50Ay/x+bPip3WBMcHkvOw72evFInq4w0wTUPj3jKvYr1HpsBeNnacmaJ1/A6HEiaYLWCGDOHqOwJ4jC0x/0one1U5lHA0t88iffcGwDMOuXHj0EnKKyaQ3Tl2CL1rbvISFd638e4BiKQtaV5z7SvkUdMQ17xBBd4i+rfQjENXGOrxEvmqvjviv2bn+v0tXXQTJsW9sDpsatTtokyr5PK8HPRo9Hn1/vINsbZLgeWv9vhxiDKQA

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Hello
>
> Due to I am switching back and forwards between PREEMT_RT and Xenomai4, I just left
> the kernel command line with the best PREEMT_RT performance in for Xenomai4. This is:
>
> isolcpus=managed_irq,domain,2-3 irqaffinity=0-1 rcu_nocbs=2-3 rcu_nocb_poll nohz=on nohz_full=2-3 intel_idle.max_cstate=1 cpufreq.off=1 nosoftlockup nowatchdog mce=off
>
> I had strange behavior when running an EVL task on CPU 2 or 3. Without network, it was fine. But as soon as I run my application with network enabled,
> it just freeze the threads from time to time. It looks like evl_sleep_until() just never wakes up sometimes. The reason might be the active network but also
> somewhere else in the code. Without network, there are also no 10'000 ns sleeps.
>
> The code is:
> evl_read_clock(EVL_CLOCK_MONOTONIC, &ts); -> ts: 1682 s 249982420 ns
> rtapi_timespec_advance(ts, ts, ns); -> ts: 1682 s 249992420 ns
> evl_sleep_until(EVL_CLOCK_MONOTONIC, &ts); -> Never returns
>
> As soon as I remove "nohz=on nohz_full=2-3", everything works fine. Might be evl relies on scheduling-clock ticks?
>

No, it can't and doesn't, that would inject in-band generated latency
into the oob timeline.

> After that resolved, I changed the command line to:
> isolcpus=managed_irq,domain,2-3 irqaffinity=0-1 rcu_nocbs=2-3 rcu_nocb_poll intel_idle.max_cstate=1 cpufreq.off=1 nosoftlockup nowatchdog mce=off evl.oobcpus=3
> so the Ethernet and also the main task run all on CPU3.
>
> After setting also the IRQ affinity for the Ethernet card to CPU3, the max latency is now quite good, max jitter 4us for the task entry, 15us at the end.
>
> I just report this anyway just in case it is a bug or others have the same issue.
>

Thanks for the heads up. I'll have a look.

-- 
Philippe.
