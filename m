Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A837EFFD
	for <xenomai@lists.linux.dev>; Fri, 17 Jul 2026 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784315949; cv=none; b=BsApB+woBMhuUoCgCYhDVbIVlu6+m4jTHfMt8QXpUtTA5crOktUzFen/2Kv5Hi99VdCpjyxL7m3YQAex7V2HofqAJBWpLr8FuQ6FGMJqgUXkK6NmqlFAhIDzeVntdCxGmsmtP3wWFtcn/U5HVfeIJiQWEXonCliGyrHf7wBx1MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784315949; c=relaxed/simple;
	bh=9iC/hA+LzMGmZPfbwcL5geI/MgROmSsLV2cLKr8k51s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHCNIlCXpvI6TRzrnaHkjat8VV4rhUaX3UmFoUQMP1GqWPw9Vnhq6j9NHcRzAv4paK/fQPb5FKYH1aZKFZAfIXzX3ne2TVkl+ipPxW37ZfVPCGBjSxSQ7hwQF51qL7Fy7KZqYlzcDOLZAoqMDqCSKuuU5ybGvLlmZpY501Uig24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkUj6cbd; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkUj6cbd"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47d70879764so5963136f8f.2
        for <xenomai@lists.linux.dev>; Fri, 17 Jul 2026 12:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784315946; x=1784920746; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JemNvlwogF3ZtdbgXUXJzvioxOnW6wyG4thWFuT05wE=;
        b=kkUj6cbdjXxWKuDTgQK5VYOlbnwFXV0z5mZmec+50nQ5PaY8BbKGD3lGODOAkYFovR
         QEVoFnOWahEZzIthzzBbm61OGRrWOW9OWVx5TKUCKBpBT10sgUssg0BQ7qyym9CMF1Kf
         LSbEV9WHwEF3BBJlsKztFuMz1tYcIPsxWh/PDYsk9uH0jiOmfpJPOnFlGbRYZvKWUhcp
         8ZYX1VUQesSdE/jTXVPlGYjyHIEAXeUQgZVKmqEbj15OY0ZZeIWjPpMr25J2tn0UXqsn
         GUSK2WcAgOLOZsjArgDe/0csIxMfapQ+qKJWrlj7R4bUytsHSTt7RkGUEabBfQaYDJVr
         kbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784315946; x=1784920746;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JemNvlwogF3ZtdbgXUXJzvioxOnW6wyG4thWFuT05wE=;
        b=jXHs9/4eiwxX5afs6+JbQazneY7hFbJSA54Z295elsqwwtRaAtxe+UItOcqxHdkJmP
         rDlPY01gd6IcDGxoImU/oojk6nAvlTCSSf6ZZkiEeP08S+RV+NQ7HeIh0RQIHa52Oj/n
         mfofU1wFOjPr8EuAxP/xJPUaxzPewcxmlO0bQjSbmeKBbU00Ep1IUD2XP0wXBPLtb1LV
         8zeopo7NnW20A3Il76sUrs7RdTB9NTuQmmAiWohQb+15tmRg54rkBR9VpgTGNYAS4HRy
         8M+j+/EsU7Wgyn6pxCw4s5NNo3h7S50k5d1zwzHgkq65WeinG7tupqVScCHj75QCHsej
         DuHw==
X-Gm-Message-State: AOJu0Yw20Jx8SAg1ZPLZBkhddt18tSeKinw4l1RbC//jZnbVUN+XMnZu
	tVsr3NEfUaVmlQ85X54NlQf3BnmVmg+jqumq8Eb2xokFbCLumtR5HyPv9bvzPA6v
X-Gm-Gg: AfdE7cm9Hg31ZkmJQ1p5nhJzkwkDwK3Z7LkNU+lDHmrdEru7k30lcoeSypeteIqcxvq
	i1UIM+ymQFtQY9E4OdqDkBk6+iRJ5ePtQ+20538BCdq4YIzhiZKR2dv9Cnfo90Wiir+QJuY1K4v
	yOTuYKHM2FD0efvMzLZu/EZT7eHQmQEiizuP33Uf903oJIj0z32TqwLcBQmMdFzuN9S2LMv8bFR
	T90NAJUFKsWrWqZxV7gB4QCh2S0I1ltkEF2aPf5vEFBfvI6H94PTbIdaRacysondEi8x5jJDa0A
	R65H72rTPWDZiYqFEsYryNV/JRrTM/2K9GqkujPio6FgbVTXqg9nhGIH/o4FtCjIYNpVAl7hZ9J
	rssY1w4XoBy7RmIkhDUEkDVDJHqrsrrGmqiKTlR3U7GTUklGUd3X/y+7ucZ6lZmVqFuUmZum+DZ
	2w6K7XckuYsQ==
X-Received: by 2002:a05:6000:4381:b0:475:e3fe:8ac3 with SMTP id ffacd0b85a97d-47f622fed8amr4727344f8f.8.1784315945537;
        Fri, 17 Jul 2026 12:19:05 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e499c2sm5629776f8f.4.2026.07.17.12.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 12:19:04 -0700 (PDT)
Message-ID: <13bb8457-8148-4758-84d5-1ab324e978bd@gmail.com>
Date: Fri, 17 Jul 2026 21:19:03 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tidbits: net-udp: solicit new client for server mode
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20260528194459.6117-1-hannes.diethelm@gmail.com>
 <20260528194459.6117-2-hannes.diethelm@gmail.com>
 <87a4te64vn.fsf@xenomai.org> <874ijm62yu.fsf@xenomai.org>
 <3216fbd8-3ee4-46f7-851b-0f3b48c38572@gmail.com> <87ik7d86kn.fsf@xenomai.org>
 <6c0d9a13-732b-49c5-886b-3dda8b1f5cab@gmail.com> <87o6gmzlpn.fsf@xenomai.org>
Content-Language: en-US
From: Hannes Diethelm <hannes.diethelm@gmail.com>
In-Reply-To: <87o6gmzlpn.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 04.07.26 um 19:52 schrieb Philippe Gerum:
> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
> 
>> Am 20.06.26 um 19:28 schrieb Philippe Gerum:
>>> - Honor MSG_PROBE for oob_sendmsg(), so that only the general call
>>>     sanity and route resolution to the destination host is performed when
>>>     set in the request flags, without actually sending any data. On
>>>     success of such call, we would know that the routing information is
>>>     readily available from the oob caches, no offload to in-band would
>>>     have happened if we had not given this flag. The absence of routing
>>>     information to the destination from some oob cache would yield a
>>>     specific error, so that the caller may decide what to do next.
>>
>> It seams the flag MSG_PROBE is kernel only? I did not find any occurrence
>> in /usr/include or in libevl.
>>
> 
> Yep, my bad. Using MSG_PROBE is not the right way, since that would
> conflict with MSG_PROXY in userland which has a totally different
> meaning. I have revisited the implementation, simplifying it actually:
> since the evl netstack already accepts zero-sized messages, sending such
> a datagram to the UDP layer now amounts to returning early with the
> address resolution status, short-circuiting the logic before the actual
> transmission happens.
> 
> IOW, passing a NULL or empty iov into the msghdr struct does what
> MSG_PROBE was intended to do.

I tested this variant. It works. But I wonder:
If I use:
ret = oob_sendmsg(s, &msghdr, NULL, 0); errno is set to EHOSTUNREACH
If I use:
ret = oob_sendmsg(s, &msghdr, NULL, MSG_DONTWAIT); errno is set to EWOULDBLOCK

Is this intended? EHOSTUNREACH is like halve correct. Yes, the host can not be reached
but only due to no ARP request is sent.

For oob-net-udp server mode, this variant is a bit wastefull due to oob_sendmsg() would
either always be called twice or I would have to keep the list of clients.

> 
>>> - Extend the effect of receiving MSG_DONTWAIT (and more generally
>>>     O_NONBLOCK on fildes) to what we would do upon missing routing
>>>     information: if present, return with a specific error code _without_
>>>     relaying the packet to the in-band stack. The caller may then decide
>>>     to handle the case locally. Otherwise, proceed as usual (i.e. relay to
>>>     the in-band stack, then notify the caller with -EINPROGRESS).
>>
>> So the oob-net-udp server code can be changed to use MSG_DONTWAIT and
>> if the return value is EWOULDBLOCK, call evl_net_solicit() and try again instead
>> of holding a list of IP's right?
>>
> 
> Yep.

This works nicely, I will send a patch changing oob-net-udp server mode to use this.

The only disadvantage is that if for what ever reason, the client is already in the ARP
cache but not permanent, it is cleared after a timeout, so evl_net_solicit() can happen
later than expected.

> 
>>> - Provide a way to synchronize with the route resolution process in
>>> evl,
>>>     i.e. a syscall that would block until a given destination is available
>>>     from the oob cache. This call already exists, evl_net_solicit() can be
>>>     used for that purpose (if a resolution request is already in flight,
>>>     subsequent ones to the same destination won't cause any harm).
>>> Points 1 and 2 are implemented in [1]. Feedback greatly appreciated
>>> and
>>> important when you have time. Usability for real-world applications is
>>> key.
>>
>> I am a bit busy right now, but I would like to test it. However, It can
>> take a week or two.
>>
> 
> Np. Your contribution has been valuable, so it's worth waiting for it.
> 
>>>
>>>> It would also be nice to have an "evl net" command to list the
>>>> entry's. I tried the normal arp command but it doesn't behave nicely
>>>> with evl.
>>> Could you please elaborate on this issue? Currently, updates to the
>>> in-band cache are propagated to the oob cache (by registering a hook
>>> into the relevant notifier chain in the kernel). So I would expect all
>>> destinations of interest to oob which are visible from the in-band arp
>>> cache to be available from the evl map as well.
>>>
>>
>> The issue was on my side, I need to run "arp -n" so it does not resolve host
>> names. Otherwise, it takes quite some time. But this makes sense, with OOB
>> active, it will never receive the answer on the request, so it times out.
>>
> 
> Ok, this is not user-friendly. I'll have a look.
> 
>> By the way: Since some time, all incoming network traffic goes to the OOB
>> stage when it is enabled. However, all outgoing traffic from the in-band stage
>> is still sent. Would it make sense to block all outgoing traffic after
>> "evl net -ei" except might be ARP requests if they are initialized by evl_net_solicit()?
>>
> 
> I believe this may break some use cases I'm aware of. Some people do
> currently use such asymmetry between ingress-oob and egress-inband on
> the same interface on purpose.

In this case, it is fine.

> 
>> At the moment, this is done using nftables for linuxcnc, this works fine
>> for preemt_rt and xenomai, so not really needed.
>>
> 
> Currently, it is assumed that any outgoing inband traffic has a purpose,
> even on an oob-enabled interface. What kind of egress inband traffic
> could/should be dropped safely when flowing through an oob interface?

Mostly unintended traffic by either user error or some running services
sending discovery messages to all interfaces. Using nftables works nicely
so there is no real need to do anything else.

> 
>>> This said, I agree that we need a way to inspect the oob cache
>>> specifically. Working on it.
>>> [1]
>>> https://gitlab.com/Xenomai/xenomai4/linux-evl/-/tree/wip/net-solicit?ref_type=heads
>>>
> 

I've seen this commits are already on v6.12.y-cip-evl-rebase? I did these tests on v6.12.y-cip-evl-rebase.

