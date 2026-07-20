Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC29330D2A
	for <xenomai@lists.linux.dev>; Mon, 20 Jul 2026 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577838; cv=none; b=YJh5BZrL+06FOyaNtl3h9ST4IPLlffOaljHSgYVXeO54ohwA+7HcinamncxJwwF4qF6sx1KbOi474DFb2iEhjefo825N502IhZI2vOqwiXN5tc4lKaadbIztzWXJowUDAvfIBIqrtLHFj+ZTGHmxaS4aZl5JdPAi+4ohaOIiGXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577838; c=relaxed/simple;
	bh=0Wo8PFH4MjrAl/NUuxvJSzzyWJMAl67EDqfugWraTu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRaWSmt/8t/j3CGFoUzEj5qFe2+5tA4qHGWuzeCR1wXsb95bdg4Stjib0v605H59tq13ozsI1kopMu1qFE+PgpLyzWI/AYjNDCWUAE80UKnwhf7VfWRPHB7lGd1X0ldINJ0qB64EWeWIsy7RZfjbJ/SMoAuO/BoNCaG1iMRKrLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGYtTxaS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGYtTxaS"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso21722225e9.3
        for <xenomai@lists.linux.dev>; Mon, 20 Jul 2026 13:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784577834; x=1785182634; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k92Bnmf7CzxZh5C7gnUWBdUKfLJfpuLq9dEk5dCxDFE=;
        b=LGYtTxaSMUzZMxu0RuYiUUc8KsMglBx14pnsebXCm/85IpYa+GP5mhbHkEM9XLFtvd
         uUCM2LrrpdyQ7snPom7KQTc2Q+Wip1CDA4kYnebAWw7QYm1TGW/x4DH67osoQ+agNbnF
         fF0cLIL4cF3HjAmUG2sMgDT5/APqQd4BBq58gLrOrEkcC3tdQbqhw4h6So4JE8F7zvz2
         0fqj8lYSzAS08CBa1CQ/IQY2O78jbbt75utUNsmJ1wGL2tfyw2yY6tXAywDdgraX3Ymo
         Iurq92QQAJI7Q1imYb383BgMSbrJPqI/OsCHhm5Odj6D/Rm/1puBSUE0+J2pvHgpTxrG
         ILUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784577834; x=1785182634;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k92Bnmf7CzxZh5C7gnUWBdUKfLJfpuLq9dEk5dCxDFE=;
        b=mboXZ59CNY67pOKOe97siUFSAJdfWZuNXW1a7D4sUlGwZa7MT0SL/Av0kRWRQbxR6p
         gHQT0XvhWJnwax2rOkV8bgjoQPc1ssazeikHyO0EOOtuCbM1sQd9S6wp6fzoLDCCHY63
         f7uNOzwWRxNfxb4oSj8iO7o43J0sSUW2qKXR4XjdPNolxUdcyAtWKBNUwxoRRLentGs6
         iKYVJbOUqkZznbFE94yhHvMOXxchLaAc1yzEtuzyXtQ09sp9eInjd4Ea2r9IWSTj+v0S
         bQt5Xqc1usfyQObZlAG8wiRjWjI36VjBnS5yp6v906ZnPZfH5jBNDO9Pk76oQztlQchJ
         M5rQ==
X-Gm-Message-State: AOJu0Yz0Sw3RGfVvZpmoOSRA15jmGYKGBynTzCLA2HQFbu7xWVR/8p6C
	oMkGiSwp9O6c3BlCGU8BGKup/In0/LWEMrOmSSBHhNV/CRFtBtRuRcHIu9iQlJBn
X-Gm-Gg: AfdE7cm4NoT+Rm6aCMgAE/teNrH9+Z87za+BLIxkNX2NFkTtL2L7GQVZu8m/FfxLjQ8
	LUAjHDHd3ZQ9f45T5uUNV13HwMm+HrjLJmjzcu9xzTzRu+rrZpvpUzpfrDtkmUc/lh93MCM9I0P
	n//GQ/VHnc8og8WCp3nslwzfkDBD5J3Km5N1CZ1etuI7eV5MhxdTxpLDaTGDAmWb/7OfylisKEF
	GhYXp7cdIhvfx/hGsqQxaJfG40QteBr/1VeAK5FYwrBmCfR9+nMTOgLKHLbQzvdkz0wdjmaQLzy
	5YddFc0NqpNApIOTS3WLTqf0s8NH+QvzwYSQycZnjqEwFagqcH85Rg8TIbNHacxoGFn97cqMoMy
	4dReUfGv7TvvrLGdK6P6Apv/4f71woev5QVnpiquzM2LpOo3NGcsNBOBV2U+1qKRIu+TNo7Utjb
	yPhUvO2W8S7g==
X-Received: by 2002:a05:600c:b8d:b0:493:f0f5:f2d7 with SMTP id 5b1f17b1804b1-4954a3e6e97mr177280305e9.7.1784577833773;
        Mon, 20 Jul 2026 13:03:53 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e499c2sm30571397f8f.4.2026.07.20.13.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 13:03:53 -0700 (PDT)
Message-ID: <11409ae1-be7b-4003-8d40-f5e1cb34d2ec@gmail.com>
Date: Mon, 20 Jul 2026 22:03:52 +0200
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
 <13bb8457-8148-4758-84d5-1ab324e978bd@gmail.com> <8733xd20u3.fsf@xenomai.org>
Content-Language: de-CH
From: Hannes Diethelm <hannes.diethelm@gmail.com>
In-Reply-To: <8733xd20u3.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 20.07.26 um 16:27 schrieb Philippe Gerum:
> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
> 
>> Am 04.07.26 um 19:52 schrieb Philippe Gerum:
>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>
>>>> Am 20.06.26 um 19:28 schrieb Philippe Gerum:
>>>>> - Honor MSG_PROBE for oob_sendmsg(), so that only the general call
>>>>>      sanity and route resolution to the destination host is performed when
>>>>>      set in the request flags, without actually sending any data. On
>>>>>      success of such call, we would know that the routing information is
>>>>>      readily available from the oob caches, no offload to in-band would
>>>>>      have happened if we had not given this flag. The absence of routing
>>>>>      information to the destination from some oob cache would yield a
>>>>>      specific error, so that the caller may decide what to do next.
>>>>
>>>> It seams the flag MSG_PROBE is kernel only? I did not find any occurrence
>>>> in /usr/include or in libevl.
>>>>
>>> Yep, my bad. Using MSG_PROBE is not the right way, since that would
>>> conflict with MSG_PROXY in userland which has a totally different
>>> meaning. I have revisited the implementation, simplifying it actually:
>>> since the evl netstack already accepts zero-sized messages, sending such
>>> a datagram to the UDP layer now amounts to returning early with the
>>> address resolution status, short-circuiting the logic before the actual
>>> transmission happens.
>>> IOW, passing a NULL or empty iov into the msghdr struct does what
>>> MSG_PROBE was intended to do.
>>
>> I tested this variant. It works. But I wonder:
>> If I use:
>> ret = oob_sendmsg(s, &msghdr, NULL, 0); errno is set to EHOSTUNREACH
>> If I use:
>> ret = oob_sendmsg(s, &msghdr, NULL, MSG_DONTWAIT); errno is set to EWOULDBLOCK
>>
>> Is this intended? EHOSTUNREACH is like halve correct. Yes, the host can not be reached
>> but only due to no ARP request is sent.
>>
> 
> EHOSTUNREACH was intended as a way to distinguish from EWOULDBLOCK wrt
> lack of buffer space for the outgoing message, this code was the only
> option close enough to the idea to be conveyed available from the errno
> list that would not conflict with other situations. Now, since such
> probing mode needs no message space in the first place, this is guarding
> against the impossible, which does not make sense. Returning
> -EWOULDBLOCK in both cases above would still be
> practical. e.g. something along these lines:
> 
> diff --git a/kernel/evl/net/ipv4/udp.c b/kernel/evl/net/ipv4/udp.c
> index d819616c3b5b..5912a1fbcfb5 100644
> --- a/kernel/evl/net/ipv4/udp.c
> +++ b/kernel/evl/net/ipv4/udp.c
> @@ -417,22 +417,22 @@ static ssize_t send_udp(struct evl_socket *esk,
>   	 * address.
>   	 */
>   	ret = find_egress_path(esk, daddr, &ert, &earp, &pseudo_earp, msg_flags);
> -	if (ret == -EMULTIHOP)
> -		return ret;	/* MSG_DONTROUTE cannot be honored. */
> -
>   	if (ret) {
> +		if (ret != -EHOSTUNREACH)
> +			return ret;
> +
> +		if (datalen == 0)
> +			return -EWOULDBLOCK; /* Address probe failed. */
> +
>   		/*
> -		 * No route known from the front cache - bummer. We
> -		 * may have to offload the transmit operation to the
> -		 * in-band stack, unless only probing or MSG_DONTWAIT
> -		 * is set.
> +		 * We have a message to send but no route was found in
> +		 * the front cache - bummer. We may have to offload
> +		 * the transmit operation to the in-band stack, unless
> +		 * only probing or MSG_DONTWAIT is set.
>   		 */
>   		if (msg_flags & MSG_DONTWAIT)
>   			return -EWOULDBLOCK;
>   
> -		if (datalen == 0)
> -			return ret;
> -
>   		/*
>   		 * We always charge the socket even when offloading to
>   		 * the in-band stack although we won't consume any
> 

I think in this case, it is fine as it is. You also won't expect EWOULDBLOCK or EAGAIN as long as you
don't set MSG_DONTWAIT.

But now there are two ways of probing. Either with or withouth MSG_DONTWAIT that behave slightly different.
Might be just support MSG_DONTWAIT -> EWOULDBLOCK and drop the other variant? Or is there a reason
for the variant withouth MSG_DONTWAIT?

>> For oob-net-udp server mode, this variant is a bit wastefull due to oob_sendmsg() would
>> either always be called twice or I would have to keep the list of clients.
>>
> 
> Which brings back the option of some MSG_xxx operation flag so that we
> could pass a valid buffer _and_ a probing flag, but then we'd need
> Dovetail to add one to the standard list (in userland) because I don't
> see any standard one to piggyback off of.
> 

Is there a reason to pass a valid buffer to only probe? Either you probe
with a NULL buffer / size 0 or you pass a buffer and set MSG_DONTWAIT so
the message is sent if possible. If not, evl_net_solicit() and retry.

BTW: NULL buffer / size 1 fails. But it also makes no sense.

>>>
>>>>> - Extend the effect of receiving MSG_DONTWAIT (and more generally
>>>>>      O_NONBLOCK on fildes) to what we would do upon missing routing
>>>>>      information: if present, return with a specific error code _without_
>>>>>      relaying the packet to the in-band stack. The caller may then decide
>>>>>      to handle the case locally. Otherwise, proceed as usual (i.e. relay to
>>>>>      the in-band stack, then notify the caller with -EINPROGRESS).
>>>>
>>>> So the oob-net-udp server code can be changed to use MSG_DONTWAIT and
>>>> if the return value is EWOULDBLOCK, call evl_net_solicit() and try again instead
>>>> of holding a list of IP's right?
>>>>
>>> Yep.
>>
>> This works nicely, I will send a patch changing oob-net-udp server mode to use this.
>>
>> The only disadvantage is that if for what ever reason, the client is already in the ARP
>> cache but not permanent, it is cleared after a timeout, so evl_net_solicit() can happen
>> later than expected.
>>
> 
> Yep, because at the moment, the core mirrors to the front cache all
> insertions and deletions happening into the inband cache
> unconditionally. We could force a permanent state for any entry we are
> about to insert into the front cache in order to prevent what you
> described, but I'm wary about unwanted side-effects.

Right now you can use evl_net_solicit(..., EVL_NEIGH_PERMANENT) to make shure it is
permanent but this is an in band call according to the doc. So if you want to stay
out of band, you need to probe.

Now the probing doesn't show if the arp entry is permanent or going to disapear soon. So it
can pass at the first try and fail later. Right now, you are better off doing evl_net_solicit()
for every client if you want to be shure.

With ioctl(s, SIOCGARP, &arp_request), you can check if the entry is permanent
(arp_request.arp_flags & ATF_PERM) and then use evl_net_solicit(..., EVL_NEIGH_PERMANENT) if not.
But the ioctl is also in band.

An option would be either to support of oob_ioctl() for SIOCGARP. Or create something like
evl_net_routeinfo(s, addr) returning flags would make probing obsolete.

Flags could be:
EVL_ARP_COM        Lookup complete (If this is not set, no ARP entry)
EVL_ARP_PERM       Permanent entry
EVL_ROUTE_MULTIHOP More than one hop away (Will fail with MSG_DONTROUTE)

> 
>>>
>>>>> - Provide a way to synchronize with the route resolution process in
>>>>> evl,
>>>>>      i.e. a syscall that would block until a given destination is available
>>>>>      from the oob cache. This call already exists, evl_net_solicit() can be
>>>>>      used for that purpose (if a resolution request is already in flight,
>>>>>      subsequent ones to the same destination won't cause any harm).
>>>>> Points 1 and 2 are implemented in [1]. Feedback greatly appreciated
>>>>> and
>>>>> important when you have time. Usability for real-world applications is
>>>>> key.
>>>>
>>>> I am a bit busy right now, but I would like to test it. However, It can
>>>> take a week or two.
>>>>
>>> Np. Your contribution has been valuable, so it's worth waiting for
>>> it.
>>>
>>>>>
>>>>>> It would also be nice to have an "evl net" command to list the
>>>>>> entry's. I tried the normal arp command but it doesn't behave nicely
>>>>>> with evl.
>>>>> Could you please elaborate on this issue? Currently, updates to the
>>>>> in-band cache are propagated to the oob cache (by registering a hook
>>>>> into the relevant notifier chain in the kernel). So I would expect all
>>>>> destinations of interest to oob which are visible from the in-band arp
>>>>> cache to be available from the evl map as well.
>>>>>
>>>>
>>>> The issue was on my side, I need to run "arp -n" so it does not resolve host
>>>> names. Otherwise, it takes quite some time. But this makes sense, with OOB
>>>> active, it will never receive the answer on the request, so it times out.
>>>>
>>> Ok, this is not user-friendly. I'll have a look.
>>>
>>>> By the way: Since some time, all incoming network traffic goes to the OOB
>>>> stage when it is enabled. However, all outgoing traffic from the in-band stage
>>>> is still sent. Would it make sense to block all outgoing traffic after
>>>> "evl net -ei" except might be ARP requests if they are initialized by evl_net_solicit()?
>>>>
>>> I believe this may break some use cases I'm aware of. Some people do
>>> currently use such asymmetry between ingress-oob and egress-inband on
>>> the same interface on purpose.
>>
>> In this case, it is fine.
>>
>>>
>>>> At the moment, this is done using nftables for linuxcnc, this works fine
>>>> for preemt_rt and xenomai, so not really needed.
>>>>
>>> Currently, it is assumed that any outgoing inband traffic has a
>>> purpose,
>>> even on an oob-enabled interface. What kind of egress inband traffic
>>> could/should be dropped safely when flowing through an oob interface?
>>
>> Mostly unintended traffic by either user error or some running services
>> sending discovery messages to all interfaces. Using nftables works nicely
>> so there is no real need to do anything else.
>>
> 
> Ok.
> 
>>>
>>>>> This said, I agree that we need a way to inspect the oob cache
>>>>> specifically. Working on it.
>>>>> [1]
>>>>> https://gitlab.com/Xenomai/xenomai4/linux-evl/-/tree/wip/net-solicit?ref_type=heads
>>>>>
>>>
>>
>> I've seen this commits are already on v6.12.y-cip-evl-rebase? I did these tests on v6.12.y-cip-evl-rebase.
> 
> Yep, because this probing mode is here to stay, although I'm considering
> another way to provide this using a dedicated MSG_xx flag. Problem ATM
> is that I'd like not to pollute the namespace uselessly by creating
> non-std flags. This said, it may be legitimate to extend the existing
> set in this case.
> 

Fine for me, so I did not have to compile yet another kernel.

