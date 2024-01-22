Received: from se6r-iad1.servconfig.com (se6r-iad1.servconfig.com [173.231.242.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997443DB86
	for <xenomai@lists.linux.dev>; Mon, 22 Jan 2024 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.231.242.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954178; cv=none; b=MtuCA+hvK0VpADXH90kIR7wpUu+Rn3Ddo0SvBd+wTqWDgfrgEClkuCqEhT/S+R7shiasWl0arV6Ru6IjmafC6r0c5cX0rdS4irhcb/2loxAc5l0T4kSd8EOjH85tw2zjpYwJSqges1e1xkJxVcC5JRCSIqSi+u+mDaQ5tyZctGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954178; c=relaxed/simple;
	bh=UWaYLvyuafDETO2c/xyqqs2qGQSczCCl8CzGpMY+iVY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FqEViczDPv1eRm4sEO8gzMkKef/LvfX0L7SOUE+HZZSBHZSV2Ucc+j+mgAElpd/gkZe/7QxDxrzJB7yomN7/jdC+VpOwmQD1OOy1nY35SfKgU/GtkO5B6+5MAUeECmePMrhL/LOs0xvxwS2ABg8+LAW+Cefb438yMb3wRDHfWxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rtxi.org; spf=none smtp.mailfrom=rtxi.org; dkim=fail (0-bit key) header.d=rtxi.org header.i=@rtxi.org header.b=wE4whJZQ reason="key not found in DNS"; arc=none smtp.client-ip=173.231.242.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rtxi.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtxi.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rtxi.org header.i=@rtxi.org header.b="wE4whJZQ"
Received: from ecbiz330.inmotionhosting.com ([69.174.52.25])
	by se6-iad1.servconfig.com with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.92)
	(envelope-from <ivan@rtxi.org>)
	id 1rS09K-0003zu-IT; Mon, 22 Jan 2024 14:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rtxi.org;
	s=default; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oQhwgUKAMG1fhUAFP8D3o3oWgQbCsuICPSg6T/vu82c=; b=wE4whJZQtK8SAyAaU00GpXvUnD
	T/mgzM19/bVUv8G6S9BUDXJDajVD8wsJcau8hXvMGePSqyr6h2Uto78jLjmmz99RYxib5VYzVcKKG
	Xm36Qdxeph2EFhNjRnV6GSlzSrcCCtrbv4NZkOLZunvwqMuuFB2CiuW7JxajuvNZX7j1O4n1NRyXJ
	NEppp5cUugaIx5l+1xoX90eGuF45Aulc1UnPNPaJ7CzxHyC5GcbSc3GM9SVSGS810zMeplGqHA389
	7bz56zzUCCBiMpNaRCx6AXoD8aCJsJwWwUEiARexZyHXOwX8bf0lJW11n7H6eutsM2P7mTgrJhicW
	EMrtMh7w==;
Received: from [::1] (port=43510 helo=ecbiz330.inmotionhosting.com)
	by ecbiz330.inmotionhosting.com with esmtpa (Exim 4.96.2)
	(envelope-from <ivan@rtxi.org>)
	id 1rS09J-00Bzm9-2Q;
	Mon, 22 Jan 2024 14:40:01 -0500
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 22 Jan 2024 14:40:01 -0500
From: ivan@rtxi.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Troubleshooting x86_64 evl bootup
In-Reply-To: <ce6d6d1504bb7d589daa14d03fd81d76@rtxi.org>
References: <37d6d286847eb0126c938a1c5826ed13@rtxi.org>
 <34ba04db1b45f6c546a2195f0a8e0ad3@rtxi.org>
 <e70b0272-8c4a-479e-b7f9-2dbfc6771389@siemens.com>
 <ce6d6d1504bb7d589daa14d03fd81d76@rtxi.org>
User-Agent: Roundcube Webmail/1.6.0
Message-ID: <4e81f900746c1d6580e4d2711782cd25@rtxi.org>
X-Sender: ivan@rtxi.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: ecbiz330.inmotionhosting.com: authenticated_id: ivan@rtxi.org
X-Authenticated-Sender: ecbiz330.inmotionhosting.com: ivan@rtxi.org
X-SpamExperts-Domain: ecbiz330.inmotionhosting.com
X-SpamExperts-Username: 69.174.52.25
Authentication-Results: servconfig.com; auth=pass smtp.auth=69.174.52.25@ecbiz330.inmotionhosting.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+YyR3f/5ovnaWPxE0PW2dsPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5yGuAIHwpS0pwuksWOJgBkPpvjAzUMRJuJGxpYzI+L098EE
 kWtgCcvT3Fq2T7XCTD9a+2csfimunmiO7i4UNslMGJZo1aJdrsShiJ6qV9Bq7uKVse1sVhWabI0/
 +PN3sIJwaamb6PEvxJYegyRXvOeQpxjKV3POXRb5eMsdRRLkJpmftL0+qYjsLGo9EPq5gW6T3KNG
 S0ZZ50JYP5r/w8kRDNU0eJLlHvqdzdIqkzT4lxj2kWcgFkzwV7Nl568bmN7vZHyqBTv40ki6e2Y7
 cGjPxbYr1vuuPH339pB+6sEkcYvn4HgJsT7yvXoNuXKfS60inGKJaynsyT4QiPcwiBOQhbOWWa8/
 XPPA/pAWzs1UnkQMF99VlWOZVo1sbhkkbsVP+H0EV+11ts+p/DVvA1qjkTd25KmXez70nNdIomkO
 8OWBOXp8nHKe0R+FkIqN7hnLhMaKyPE1PfN61KQds7uNlmlCFXqmMh6kmMEYWdPStovhSJcbnX/H
 QqL/X9rNCJCc6iESJvKm1NV8gkr+Wu8ScVDXinOVyuIpITQ9z3M3DIY1a87P4k6ADPCUEMJEy+RF
 9L4DN3cnPdov0sw5dm3aikbVU+/Kp06EVLRQ88Ao5Q67BKWhr/strns5cs6eI/Cam5IRI+75xRAz
 wEg4XkOtX0vbOV1GC4tWSdMEfX0qZn1ohERjPYghQyMtiLHQ6cI9K6EP+7YwByOd/yiiLkEIVgUV
 N12b1Ctfih74/Kdn2n1lF87HXtkB1vLi4H9iqNsDX7rEjhVw38HJDsy/cvf2uvMTuECvlzaQElsP
 PYKHctzWtUFCnLvvDdbkRLMwXw1OZiBbAGpOonGSqx7wd7UZIIVGLAOfyPfJYYe0zvB1Gp6sjDiy
 pqKZR2oaUi6Q2RpypunK/E2S92/c4jSYdz0j3jR5NeVaJQBh0uawl0Cg8mUyfXAAGznPPN0a5EYR
 qtmb3ONqbAlqzujrGeDMJ5U3GaK9Rmy0OiNG1Q6CyVQfZvG+iTAXJjEOm1NgW9/nMFuAcgxgocBx
 TAUn5qB7LGca
X-Report-Abuse-To: spam@se1-lax1.servconfig.com

Hello,

I used the config from xenomai-images suggested with EVL enabled and 
that reached the login screen! It is obvious from this that some 
configuration or module is the problem, but I don't know what it could 
be.

What should I do next? The only thing I can think of is slowly start 
enabling any drivers I need until I hit a problem, but that seems like a 
crude way to find the problem. Any suggestions?

-Ivan


On 2024-01-19 16:06, ivan@rtxi.org wrote:
> Hello,
> 
> On 2024-01-18 01:51, Jan Kiszka wrote:
>> Hi,
>> 
>> On 18.01.24 00:22, ivan@rtxi.org wrote:
>>> On 2024-01-04 13:34, ivan@rtxi.org wrote:
>>> 
>>> Hello everyone,
>>> 
>>> I tried building and installing with a newer kernel version
>>> (v6.6.y-evl-rebase) and i get the same error during bootup. This time
>>> however, there is an additional message:
>>> 
>>> clocksource: Switched to clocksource tsc
>>> 
>>> After which it hangs for a minute then the same output previously
>>> described is printed. Am I doing something wrong? What additional
>>> information do you need?
>>> 
>> 
>> Yes, kernel config, to begin with. A complete boot log would also be
>> nice (catch via UART, please).
> 
> Attached is the kernel config for the build. Unfortunately I don't have 
> a
> way to capture early printk logs through UART, but I will attempt other 
> ways.
> 
>> 
>> There is now a demo image, also for x86, generated via xenomai-images
>> (currently only in 'next'). That config ([1] + [2]) may be lacking 
>> some
>> bits you need driver-wise, but maybe it's worth to check and try if 
>> that
>> one makes any differences.
> 
> I will try this as well and let you know if anything changes.
> 
>> 
>> Do you see this boot issue only on the Phenom hardware or also on 
>> others?
>> 
> 
> There are a few our old machines that show similar issues:
>   1. Intel Xeon w3680 (Used to have XENOMAI+IPIPE)
>   2. Intel Core 2 Duo (No xenomai/testing laptop)
> 
>> Jan
>> 
>> [1]
>> https://source.denx.de/Xenomai/xenomai-images/-/blob/next/recipes-kernel/linux/files/amd64_defconfig?ref_type=heads
>> [2]
>> https://source.denx.de/Xenomai/xenomai-images/-/blob/next/recipes-kernel/linux/files/evl.cfg?ref_type=heads
>> 
>>> Thanks,
>>> Ivan F. Valerio
>>> 
>>>> Hello all!
>>>> 
>>>> I have been trying to upgrade a desktop that used to have Xenomai 3 
>>>> +
>>>> IPIPE to the new EVL system. Compilation is successful but the 
>>>> kernel
>>>> hangs during boot with an rcu error message followed by a stack 
>>>> dump:
>>>> 
>>>> rcu: unless rcu_preempt kthread gets sufficient CPU time, OOM is now
>>>> expected behavior.
>>>> ...
>>>> Call Trace:
>>>> <TASK>
>>>> __schedule+0xd76/0x1950
>>>> ? sched_clock+0x9/0x10
>>>> ? sched_clock_local+0x17/0x90
>>>> ? inband_irq_save+0xe/Ux30
>>>> schedule+0x69/0x110
>>>> schedule_timeout+0x19a/8x2f0
>>>> ? del_timer_sync+0x50/0x50
>>>> rcu_gp_fqs_loop+0xf9/0x470
>>>> rcu_gp_kthread+0x15a/0x210
>>>> ? rcu_gp_init+0x640/0x640
>>>> kthread+0x12a/0x150
>>>> ? set_kthread_struct+0x50/0×50
>>>> ret_fron_fork+0x22/0x30
>>>> </TASK>
>>>> 
>>>> After some digging, the evl page references possible issue as 
>>>> "loosing
>>>> the tick device" but don't know how to confirm whether that is the
>>>> case here. This computer uses an AMD Phenom II X6 1035T processor 
>>>> and
>>>> The kernel branch used from linux-evl repo is "v5.15.y-evl-rebase".
>>>> Any suggestions on how to track down the issue?
>>>> 
>>>> Regards,
>>>> -Ivan F. Valerio
>>> 
> 
> Thanks,
> Ivan F. Valerio

