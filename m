Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD6429D260
	for <xenomai@lists.linux.dev>; Sat, 25 Apr 2026 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777151105; cv=none; b=hhZxlwYnLveaTMzBdXa6R0PN6pLjTOhf/zGjYzMx962S0J1bp8YKOIAVk4mm7tVRyedGb1jY309ExlQOpLb4CBFIF0LThwisbVZu/PSA5OQRajLb9rVrKlYKF6pVHKfMjvz1JOxED+VdFIMfwWrd+JcVQyaHS8xVOjHw8C1lnBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777151105; c=relaxed/simple;
	bh=sFztZQNFpk8Nn+jT0KzeKO6GeSQyufDP2/1W4Ok40JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XL88J8/X6VCFzV61ZmEYzOe3yiTUvESlBAiCiHLZNNhgyBZ2a3tfHYNDHz68Df+3zN07ddwzjPKhxbTWoD1dxSYUF4B9chDfYM2jmIsXlLO96M1PDUnFgUmuKou1K8CQ3/j5Jul76arAW1BFD3ct0gLPiQPIP/GA+EMzk0xZcVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNAOV+6F; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNAOV+6F"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso92201455e9.1
        for <xenomai@lists.linux.dev>; Sat, 25 Apr 2026 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777151102; x=1777755902; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3/yM5OTRkjDrOA9xFTq6OWTQ21NFGszaYpSnh/Hh3Aw=;
        b=UNAOV+6FKohQE0tR+zk+tqc3OYfigYVpFioCmIqZ01tDCFC645lhnqgQxGgzAUj+Xd
         TnfyrIlx4jkY5L6TnTC+u2kKzwU6fovfbbFTpLEUabucJuuGvun9WOm/2oRyybaynSQC
         FfxpPEChoJM5nNbqjFvVc4ab2qFV2dXDq8Al+A8krOStoAlQYd7SNChdgachHSjrXtJ7
         kSWra6rqY2h5Ps94sk7hlNdvZDuIcwugvwaqQFLXtcWd6OV0Xat5SUAwomAYtdnQGlsg
         WYxhKlFgMe/EljehZo+WRaNSsIq6n1dqtPiyQUDDJyAkXhrlt8Z9poJNNmvC3SLGUImD
         4LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777151102; x=1777755902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/yM5OTRkjDrOA9xFTq6OWTQ21NFGszaYpSnh/Hh3Aw=;
        b=WYUW+SAmDQwZ5EjRZ3ljL7THcM6YQFz6h0EkGTGJtUCk9Gg8WIAwjrff730bI6GNPu
         N4x6C1wG2IoX4bRA9X+Mlp6duSphuu2VexZqZ88K4DLzfPqWBRw+1CUggntFM5U5b5mB
         MZi8+fygOIJP5M/GznnJGDYp95QWP5sFNdOcynLpPQ6T6f0XrNDnp1vkW79YWhjzui5z
         jM14Xx3fe9cYpAQXzHR3vBqz6+mCwuJzjOHI2mo+4Dt1LPvUf2QbtL1QDs35WPQtCqej
         x/3dlSjKd9vU1t6VwR0TIDgdZYgYFxZVaVVAD6GH6mbiZOzd9PjH+GU0OPZltHIx7fgV
         4Hlw==
X-Gm-Message-State: AOJu0YwaLTllfNjwTwDeG7dZfTzmwFYC11EMP2audo4F+CxB2hlBWELx
	QFVsNgT7A77gUv/y0Jaof5Z0K/9q32AlJc62iS8f35Dk8/x+vkrfCixUplG5+Q==
X-Gm-Gg: AeBDieuwHR44jP7Xh//RqXqefQVpK/27J7U8fk9B45v0uEwpAS7X9TdCf1DZy6JMUfe
	5b97iHD7o+h/axMLTn+/svw3cHAg+2c/P8TBR4XAY8RI4WhWjMgtImSawFdzaNyaRGWBNYJ9vvH
	B2o7v/3aQAtIELJeffMV21tEIHKT+eBwaCMibWl3uAX2Xvif3XusYvJOqqqSPv1ZzjglH9n2ZzZ
	UZG3KA8w9quPbLbsmroe6ChOjl3hiPDbcO09/1hEch99tYIPeiicjIvzvx1ILpUYG0QNDnWF7/0
	f+UB46lYMjlJXGjeeKTXBgA05p5iQEdOHz7S2z2V/EwLRCy3J5UftWljIKcsCsxZ4f/SOGNTlUW
	gsJLhbfP5r5ODW/ZnJs9OMTpwlD4kYvvT7CW39MaV2GNZ8caz9qGzTiWD2FvnO+56A0WF/yL7Nv
	3Sj4GRh2lBYpixyAD05Gujcd7Snrm1hCaF92Zc5afzyH2DuDbDVSHq
X-Received: by 2002:a05:600c:620c:b0:488:ae6c:42c6 with SMTP id 5b1f17b1804b1-488fb7786c2mr540127265e9.14.1777151102099;
        Sat, 25 Apr 2026 14:05:02 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5e52b2c0sm71533405e9.4.2026.04.25.14.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 14:05:01 -0700 (PDT)
Message-ID: <201a7d9c-e1dc-4686-8a5e-adc7c921ba14@gmail.com>
Date: Sat, 25 Apr 2026 23:05:00 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EVL] Kernel WARNING: notifier callback netevent_handler already
 registered
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <8e08bda6-1fed-4a5a-9bb3-74f019b05855@gmail.com>
 <87340ij2lx.fsf@xenomai.org>
Content-Language: de-CH, en-US
From: Hannes Diethelm <hannes.diethelm@gmail.com>
In-Reply-To: <87340ij2lx.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 25.04.26 um 20:50 schrieb Philippe Gerum:
> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
> 
>> Hello
>>
>> There is a Kernel WARNING: "notifier callback netevent_handler already registered right after boot". It is repeated 5 times.
>>
>> Config:
>> Debian Trixie with xfce4 Desktop
>> libevl: r56
>> linux-evl: v6.12.67-evl2-rebase
>>
>> I traced the issue already trough the following code:
>> net/core/net_namespace.c:355
>> kernel/evl/net/net.c:35
>> kernel/evl/net/ipv4/ipv4.c:41
>> kernel/evl/net/ipv4/arp.c:323
>>
>> However, I lack the knowledge to do a proper fix. One way would be to just check in evl_net_init_arp() if it is already
>> registered and don't do it more than once but that doesn't feel right.
> 
> It looks like the system is instantiating multiple network namespaces,
> for each of which we set up an ARP front cache by calling
> evl_net_init_arp(). Bad idea to hook a system-wide handler there as
> well. Could you confirm this fix [1] works for you?
> 
> Thanks for reporting this.
> 
> [1] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/569beef061321c2c00d775b13ad0aec1a1d2a416
> 

Thanks, that was fast. The WARNING is gone now.

But now after just updating to the kernel including your fix, I have a different behavior on
incoming packages. It seams that the default when no filter is set has changed from EVL_RX_SKIP to EVL_RX_ACCEPT.

linux-evl: v6.12.67-evl2-rebase
-After evl net -ei enp7s0, I can ping another host.
-oob-net-icmp does only receive packages when I use an eBPF filter with EVL_RX_ACCEPT
-After that, ping doesn't work any more

linux-evl: v6.12.y-cip-evl-rebase
-After evl net -ei enp7s0, I can NOT ping another host.
-oob-net-icmp does receive packages
-If I use an eBPF filter returning EVL_RX_SKIP, I can ping again

I am not using VLAN's.

Was that changed on purpose?
