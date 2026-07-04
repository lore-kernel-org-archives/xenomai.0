Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182B931F9B7
	for <xenomai@lists.linux.dev>; Sat,  4 Jul 2026 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194276; cv=none; b=kZeNgYXVbpRxOtY0KLsKVEeaEQFv3sz6jiENbjulssfQzbA9Q1zwpZcPFLBpljI7685XRhuHqRWw4IbwGwSmiu4TAeOTlzL7NSoVTcV8RDGsCdvi5YCiITGebmsmCIguDi/qjN4WAKW7CJgjJhAqz9WvAbqWbUF/u03CDNAXEnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194276; c=relaxed/simple;
	bh=9x4Yi2oDr+0b/PfoneSok6FwI3ePCseKmbjnewZ3vKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iU4egXkqCzwv/Egvn6WGuDrng/rqMgh1ggQ1jQB6d4sqzdb92st0icrLw90pAw5FStk681sngircciX75FJYmLxTgNmkRUPBjd/XgPg+FvVw53awHH0ZoMJr9T4h4UI7pEAa5jTOdzqCKmMlRkUfgW/8zp/Ltf3o8gcTMBz3tOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=A5MpT7CL; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="A5MpT7CL"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 9E6E75800B9
	for <xenomai@lists.linux.dev>; Sat,  4 Jul 2026 17:52:32 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC6EF3F6E1;
	Sat,  4 Jul 2026 17:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783187545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0wPA2JKU0xK6PUt1XjleyPcGlMO+kLe3Q9m8I6dW6FA=;
	b=A5MpT7CL/h7TQDzD00RWF0A8Govd2hDnX24GTnP+BAvVb+YX6HfVk6V8JQhqYqsgaJCZLk
	HTAc5xDKVVs1JgblrgxaPcjqWILJ/iZYT0vWTjjlTxsoB3tprdM3P8bW4OnABry9Tt5JNd
	z2GwVAlm9A2tT0+rIdcSgcpO8pDDWe0MYY6X4NKMPbdO0ZzwXmjtXFscFtrzUXP9+3sx4+
	ejSVrfc91Ve7uaL9+9ODm2mKk+da43ZsNLoMWN6Cxp8ytUO2L4vRRQRCyU0L3DV8Jo+pQO
	eXrRScILkXFcWJHLCPv8cySsDO6ieiakKQ8KuBEkT9YrKjc11KA/2d92UQrt5Q==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 1/1] tidbits: net-udp: solicit new client for server mode
In-Reply-To: <6c0d9a13-732b-49c5-886b-3dda8b1f5cab@gmail.com> (Hannes
	Diethelm's message of "Sat, 27 Jun 2026 22:21:10 +0200")
References: <20260528194459.6117-1-hannes.diethelm@gmail.com>
	<20260528194459.6117-2-hannes.diethelm@gmail.com>
	<87a4te64vn.fsf@xenomai.org> <874ijm62yu.fsf@xenomai.org>
	<3216fbd8-3ee4-46f7-851b-0f3b48c38572@gmail.com>
	<87ik7d86kn.fsf@xenomai.org>
	<6c0d9a13-732b-49c5-886b-3dda8b1f5cab@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 04 Jul 2026 19:52:20 +0200
Message-ID: <87o6gmzlpn.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTEyMrhDpg+bAGt9D/pDThJ6Yf3F7hnVXR1wLMPyGJzchzwtJMX16qTjhp6bM/ywJmaSsR6ZK4qjYIVYDbHY4Puz8GK7u2tMFKOYLqUKYvLBjNymFy0vtgT3QbNpzpbIav2xd0ujJXw0b02we3A/1D/wVJqP2hc4H2lOdQ4ZAFDmpRL7ejGMpN1LkpRqTkl9DeBl9hDg7JXAyXOijGYEHtcxFhRr8Fyp9OgDsX3jhy49cULC4D5uxFZg7qDnRjgKZL3q211fKH1KAESUt2zj/VdflrxYUhOGJPjnSl9hzrjxFVmPSpPqcBUuLogWY+qTSpr2Sa9DTeT77LZ0/EUbpRNQqjAYi7G0y5451Ezp+AXycqEI4LYNo0Dq1XytSoO8ma1/I3As2jl89n/DSTLipkZoJY0lr6e+gEVEb2r05lY1hkh34VXucT0RKhb4Urmb4QF3eQ1Rk9cA0dKW27J/VAodQtWBNZ5m/4TxSboYaMJdO4VNUFTOmKbjFKdu7iv/EMkQXjZXfZNqRpyaWwQdynS/thIM0TR/wyddABALhrYrtOUjlBAYpkWWG52sBpUinJD/CJH/gSi0H/5ltYzVAsWtDOG8q+2PueRKmro2GD69pcQU6KTp8dwVtC1YDRsAvdlgAROuy6h4zeYEdBh9S/TCbL6EpQtvEXl8bccH9C6w8w

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Am 20.06.26 um 19:28 schrieb Philippe Gerum:
>> - Honor MSG_PROBE for oob_sendmsg(), so that only the general call
>>    sanity and route resolution to the destination host is performed when
>>    set in the request flags, without actually sending any data. On
>>    success of such call, we would know that the routing information is
>>    readily available from the oob caches, no offload to in-band would
>>    have happened if we had not given this flag. The absence of routing
>>    information to the destination from some oob cache would yield a
>>    specific error, so that the caller may decide what to do next.
>
> It seams the flag MSG_PROBE is kernel only? I did not find any occurrence
> in /usr/include or in libevl.
>

Yep, my bad. Using MSG_PROBE is not the right way, since that would
conflict with MSG_PROXY in userland which has a totally different
meaning. I have revisited the implementation, simplifying it actually:
since the evl netstack already accepts zero-sized messages, sending such
a datagram to the UDP layer now amounts to returning early with the
address resolution status, short-circuiting the logic before the actual
transmission happens.

IOW, passing a NULL or empty iov into the msghdr struct does what
MSG_PROBE was intended to do.

>> - Extend the effect of receiving MSG_DONTWAIT (and more generally
>>    O_NONBLOCK on fildes) to what we would do upon missing routing
>>    information: if present, return with a specific error code _without_
>>    relaying the packet to the in-band stack. The caller may then decide
>>    to handle the case locally. Otherwise, proceed as usual (i.e. relay to
>>    the in-band stack, then notify the caller with -EINPROGRESS).
>
> So the oob-net-udp server code can be changed to use MSG_DONTWAIT and
> if the return value is EWOULDBLOCK, call evl_net_solicit() and try again instead
> of holding a list of IP's right?
>

Yep.

>> - Provide a way to synchronize with the route resolution process in
>> evl,
>>    i.e. a syscall that would block until a given destination is available
>>    from the oob cache. This call already exists, evl_net_solicit() can be
>>    used for that purpose (if a resolution request is already in flight,
>>    subsequent ones to the same destination won't cause any harm).
>> Points 1 and 2 are implemented in [1]. Feedback greatly appreciated
>> and
>> important when you have time. Usability for real-world applications is
>> key.
>
> I am a bit busy right now, but I would like to test it. However, It can
> take a week or two.
>

Np. Your contribution has been valuable, so it's worth waiting for it.

>> 
>>> It would also be nice to have an "evl net" command to list the
>>> entry's. I tried the normal arp command but it doesn't behave nicely
>>> with evl.
>> Could you please elaborate on this issue? Currently, updates to the
>> in-band cache are propagated to the oob cache (by registering a hook
>> into the relevant notifier chain in the kernel). So I would expect all
>> destinations of interest to oob which are visible from the in-band arp
>> cache to be available from the evl map as well.
>> 
>
> The issue was on my side, I need to run "arp -n" so it does not resolve host
> names. Otherwise, it takes quite some time. But this makes sense, with OOB
> active, it will never receive the answer on the request, so it times out.
>

Ok, this is not user-friendly. I'll have a look.

> By the way: Since some time, all incoming network traffic goes to the OOB
> stage when it is enabled. However, all outgoing traffic from the in-band stage
> is still sent. Would it make sense to block all outgoing traffic after
> "evl net -ei" except might be ARP requests if they are initialized by evl_net_solicit()?
>

I believe this may break some use cases I'm aware of. Some people do
currently use such asymmetry between ingress-oob and egress-inband on
the same interface on purpose.

> At the moment, this is done using nftables for linuxcnc, this works fine
> for preemt_rt and xenomai, so not really needed.
>

Currently, it is assumed that any outgoing inband traffic has a purpose,
even on an oob-enabled interface. What kind of egress inband traffic
could/should be dropped safely when flowing through an oob interface?

>> This said, I agree that we need a way to inspect the oob cache
>> specifically. Working on it.
>> [1]
>> https://gitlab.com/Xenomai/xenomai4/linux-evl/-/tree/wip/net-solicit?ref_type=heads
>> 

-- 
Philippe.
