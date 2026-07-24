Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0A4367F48
	for <xenomai@lists.linux.dev>; Fri, 24 Jul 2026 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930846; cv=none; b=CWNfyXzrCwmSpAuusNbQFOP6xMaMyh27HSL9WmschJM3BE0pobPwZ4hipm7s9YTnMYjCaIQvTI2J26OjP9WU4g/yMTADMcJE+y/VJDO5dD4sTKAXGaouMkOaZxZK1voMPd4U6zPzEox9MEENY62W8aVN7Y3hUnsXwAxHZTg+lyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930846; c=relaxed/simple;
	bh=6ERlvlB1HDvLN+rYFhW3GBnQ2MP0AdJBnqZf+JquodM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bllbp/k9c4EbF+p11Q6V/G9wvT3yBjbkAshZH15hv0jYt17KaiOiPlfoD7GgI0c1bgAA+e2IGoxJIs/2ThJ+M+jir31a0Y4jOunfbz1Ii9/X84U3DsxQQKXWdrbpw4rSoxYt9CbtCT2C7esFEKuyRy0mBYKRyzuXXZz6oVTOoNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5m+NKZ6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5m+NKZ6"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so7971135e9.2
        for <xenomai@lists.linux.dev>; Fri, 24 Jul 2026 15:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784930842; x=1785535642; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jje0yx5KrT+aq7QWbZSJpzipNHlloC/3vE5NUf6MVr0=;
        b=C5m+NKZ6KPxNVBIsXgyPwQkxXGm+eJrB5jXhw5KlWkRiDoJ14lpLFMXCHr4DXLdPOR
         AkRVepX3F0hmN96gFJUiLkIne+U+gIQNz9n2m9aBh7MBRJsfJ5A/gGU1Owk7mvb7bnvU
         bsAJAjt3CdNsFkb/wdxHOHUQrgh8TjVCIobjkYiO5WQa4coW59XVMraK5Nmo+VZDQVUT
         uoeUJJm7jsVuN4KeGWRTj4H0PXyi1sKgQmpwoiB1BwJTDgKSZ4Js4Z9VWaEkzUGSmaIH
         eUAtqyoHu6FIAkU3s2BLCTvg16djwoDdN7tg4CeQNNV3RsK8Urt9epsqBfdkjZZ3SiCm
         mwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784930842; x=1785535642;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jje0yx5KrT+aq7QWbZSJpzipNHlloC/3vE5NUf6MVr0=;
        b=qdyp4i1ncc/XmlZx4F8RZ+9tfMZWatRfSGCN9aJdBsKbk1Dc4pRxicX2w2kKj3ddTZ
         TzxzdYUNCjAF7TiqSHjM0Jey4TNX7IIJBQY0YGld21x9/lfohbvuo1xvRZ9JdQWrO8DC
         RfHiMzPhvpyn6WarDPVpQ2cDqcaLdXj8UdyegEf8Oq8i4ZMgTUjl7tbQ8EoIPdOEl1PK
         0mW2PneGHtxOkZzPzhNc4LR9yyDBPAwCwlYKCQm997mt1aadJkVwTNniGEImm4YPySB7
         wWjqDFXo97ScFwDpA3eEoYnXywqbmQPy7trybhSu3Q/ERxwDgRYZ2itIeY1mmPwvBXKJ
         PGVg==
X-Gm-Message-State: AOJu0Yx0TYgBMAgImO6sfiWvdYhcga80u8P/s96gMnYgfbJvF6LEi3SP
	SBuvb/G5WL2L3/ywUJW6+To2i1JKWe8wOz/8XNmMUpWsjJ3rYqqWhMjg6ClrBzVm
X-Gm-Gg: AR+sD13lP5VSj1KG0KbIIg8BfBZjvq5hCccZ2abblFqT+iHUArbNsJNwG0RdZN8g/T8
	OuUY8SGD5dn3ie74LMqjaRtxy0O+lOliHAfqc0r8KpbPw2rnZJyvYbZUFnuFEBzYXOOhbL+diYc
	ToiyoJPiMOhpaKFwlau9ufqG5WK9jVDEeX5ejRc2nyefK4lSPpYGixDulfzF/TJrM1plBIihKBS
	Cc+FL10rRm8fbbp2rIxixgct//JPCox+Fc58S3xVOhrSb/VoHlg6DeosTw9x3RXKEWzUCO9s4G/
	EMQ70GFJXI2irONAaCcpBssxZNK/GJ9/VjmEJS/H+acyQbmDGsEg536fJDRdiIddXNi5Jg6NEwm
	QzTATO2VYzHrkIud4Vy10AoXy5HxMkhzIBp+CPRWYPDHJnjiaaB8EPgZWzGImmXyxItkCJaaaqH
	PIqXCnMVLC4w==
X-Received: by 2002:a05:600c:8b23:b0:493:e404:3727 with SMTP id 5b1f17b1804b1-496b56f9b21mr1211555e9.23.1784930841470;
        Fri, 24 Jul 2026 15:07:21 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b499cc49sm22819175e9.9.2026.07.24.15.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 15:07:20 -0700 (PDT)
Message-ID: <eda638e0-cabb-4b3c-9dc3-bd5ee4d167f4@gmail.com>
Date: Sat, 25 Jul 2026 00:07:19 +0200
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
 <11409ae1-be7b-4003-8d40-f5e1cb34d2ec@gmail.com> <87jyqodrq0.fsf@xenomai.org>
 <3105aa6e-ba08-4e5a-b228-233473aa5675@gmail.com>
 <dc6c2532-08e4-417d-85dd-8d2e89b34ae7@gmail.com> <87h5lrh503.fsf@xenomai.org>
 <87tspqg9bu.fsf@xenomai.org> <fc1b080c-54ed-4449-8958-fd8be91e1d8f@gmail.com>
 <87cxwe170w.fsf@xenomai.org>
From: Hannes Diethelm <hannes.diethelm@gmail.com>
Content-Language: en-US
In-Reply-To: <87cxwe170w.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 23.07.26 um 09:47 schrieb Philippe Gerum:
> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
> 
>> Am 22.07.26 um 20:36 schrieb Philippe Gerum:
>>> Philippe Gerum <rpm@xenomai.org> writes:
>>>
>>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>>
>>>>> Am 22.07.26 um 00:36 schrieb Hannes Diethelm:
>>>>>> Am 21.07.26 um 22:15 schrieb Philippe Gerum:
>>>>>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>>>>>
>>>>>>>> Am 20.07.26 um 16:27 schrieb Philippe Gerum:
>>>>>>>>
>>>>>>>> An option would be either to support of oob_ioctl() for
>>>>>>>> SIOCGARP. Or create something like
>>>>>>>> evl_net_routeinfo(s, addr) returning flags would make probing obsolete.
>>>>>>>>
>>>>>>>
>>>>>>> Not entirely. The issue with solely having SIOCGARP or any probe-only
>>>>>>> explicit request is that you would have to pair two syscalls at each
>>>>>>> transmit at least, one to probe for the sender address before possibly
>>>>>>> soliciting that peer if absent from the oob cache, another one for
>>>>>>> sending the message eventually. i.e., for every packet:
>>>>>>>
>>>>>>>        ioctl(SIOCGARP)
>>>>>>>             !ATF_COM? -> evl_net_solicit()
>>>>>>>        oob_sendmsg(..., 0)
>>>>>> You are right, that is an unneeded syscall as long as you don't keep
>>>>>> a
>>>>>> list of clients as before. This can remove the need from calling
>>>>>> evl_net_solicit() in the case the client is already in ARP and
>>>>>> permanent but
>>>>>> this will be the only change and won't help that much.
>>>>>>
>>>>>>>
>>>>>>> OTOH, with the latest attempt to address this issue, we can send a
>>>>>>> probe-only request by passing MSG_PROBE (EHOSTUNREACH), or a request
>>>>>>> that does not attempt to defer transmit to the inband stage on probe
>>>>>>> failure by passing MSG_DONTWAIT (EWOULDBLOCK). i.e., for every packet
>>>>>>>
>>>>>>> redo:
>>>>>>>        oob_sendmsg(..., MSG_DONTWAIT)
>>>>>>>             EWOULDBLOCK?
>>>>>>>                   oob_sendmsg(..., MSG_PROBE)
>>>>>>>                      EHOSTUNREACH?
>>>>>>>                          evl_net_solicit()
>>>>>>>                          goto redo
>>>>>>>                      otherwise assume ENOMEM
>>>>>>>             otherwise all done
>>>>>>>
>>>>>>> IOW, using a proper combination of MSG_DONTWAIT and MSG_PROBE in the
>>>>>>> right sequence would either succeed to send the packet immediately on
>>>>>>> the first oob_sendmsg() call, otherwise fail on memory shortage or
>>>>>>> missing route from the oob cache. In the latter case, which could only
>>>>>>> happen once for each new peer under normal circumstances, we could
>>>>>>> disambiguate the EWOULDBLOCK status using an explicit probe.
>>>>>>>
>>>>>>> A better way to do this in a single step unambiguously would require the
>>>>>>> addition of another operation flag, like MSG_DONTDEFER, preventing the
>>>>>>> deferral to inband on failed probe and causing oob_sendmsg() to return
>>>>>>> with a specific error code. e.g. something as simple as the following
>>>>>>> would cover all requirements:
>>>>>>>
>>>>>>>         oob_sendmsg(..., MSG_DONTDEFER) -> EADDRNOTAVAIL on failed probe.
>>>>>>>
>>>>>>> Now, we might also piggyback off of MSG_OOB instead of defining yet
>>>>>>> another operation flag, as a way to say "oob only, don't relay to
>>>>>>> inband", but I'm still pondering whether this would be nicely witty or
>>>>>>> utterly confusing..
>>>>>>>
>>>>>> Yes, this is a variant. I was not aware that MSG_DONTWAIT ->
>>>>>> EWOULDBLOCK
>>>>>> can also mean ENOMEM.
>>>>>> Now after considering all options, i start to prefer the variant
>>>>>> before
>>>>>> this patch, keeping a list of already solicit'ed clients. It is straight
>>>>>> forward, simple and fast. And you know exactly when to expect an in band
>>>>>> call. Might be we should just drop this patch instead of adding unnecessary
>>>>>> complexity for example code?
>>>>>
>>>>> BTW: With drop this patch I don't mean the one already in but this one:
>>>>> [PATCH] tidbits: net-udp: use MSG_DONTWAIT for server mode
>>>>> https://lore.kernel.org/xenomai/20260717192541.15829-1-hannes.diethelm@gmail.com/T/#u
>>>>>
>>>>
>>>> Got it, it may be worth waiting for the dust to settle in the core
>>>> regarding the probing issue before adapting this tidbit anyway. I'm
>>>> going to consolidate the points we have discussed so far, in order to
>>>> come up with an implementation that satisfies all the requirements.
>>> Here is a new proposal that should cover all the cases we discussed
>>> so
>>> far (next/v6.12.y-cip-evl-rebase branch). A new flag is introduced,
>>> namely MSG_STEADY, which tells the core to only accept cache lookups
>>> that deliver permanent ARP records. This flag can be combined with
>>> MSG_PROBE and MSG_DONTWAIT for extended semantics. Meanwhile, a
>>> zero-sized message is still accepted in order to request a mere address
>>> probe without having to pass any meaningful data. This goes like this:
>>> Function: probe-only
>>> 	      oob_sendmsg(s, &msghdr, NULL, MSG_PROBE)
>>> 	          -> EADDRNOTAVAIL if no peer address found
>>> Function: probe-only, permanent peer address required
>>>     	      oob_sendmsg(s, &msghdr, NULL, MSG_PROBE|MSG_STEADY)
>>> 	          -> EADDRNOTAVAIL if no permanent peer address found
>>>                        (also upon match of aging ARP record)
>>> Function: send, no deferral (to inband) allowed
>>> 	      oob_sendmsg(s, &msghdr, NULL, MSG_DONTWAIT)
>>> 	          -> EADDRNOTAVAIL if no peer address found
>>> 	          -> EWOULDBLOCK on memory shortage
>>> Function: send, no deferral (to inband) allowed, permanent peer
>>> address required
>>> 	      oob_sendmsg(s, &msghdr, NULL, MSG_DONTWAIT|MSG_STEADY)
>>> 	          -> EADDRNOTAVAIL if no permanent peer address found
>>>                        (also upon match of aging ARP record)
>>> 	          -> EWOULDBLOCK on memory shortage
>>> Function: send, permanent peer address required
>>> 	      oob_sendmsg(s, &msghdr, NULL, MSG_STEADY)
>>> 	          -> EADDRNOTAVAIL if no permanent peer address found
>>>                        (also upon match of aging ARP record)
>>>
>>
>> Looks promising. This also means after
>> oob_sendmsg(..., MSG_DONTWAIT|MSG_STEADY)
>> no second call oob_sendmsg(..., MSG_PROBE) is needed to handle
>> -ENOMEM right?
> 
> Correct.
> 
>>
>> oob_sendmsg(s, &msghdr, NULL, 0) is the only case with deferral to inband
>> as it looks in udp.c:421...423?
>> if (ret != -EADDRNOTAVAIL ||
>> 	msg_flags & (MSG_PROBE|MSG_DONTWAIT|MSG_STEADY))
>> 		return ret;
>>
>>
> 
> Open question: does it still make sense to have MSG_DONTWAIT prevent the
> deferral to the inband stage, now that MSG_STEADY can be used for this?
> i.e.:
> 
>>> Function: send, no deferral (to inband) allowed
>>> 	      oob_sendmsg(s, &msghdr, NULL, MSG_DONTWAIT)
>>> 	          -> EADDRNOTAVAIL if no peer address found
>>> 	          -> EWOULDBLOCK on memory shortage
> 
> Not considering MSG_DONTWAIT (alone) anymore as a way to prevent
> deferral would make MSG_STEADY the only option for this, tightening the
> requirement from "any cached destination address" to "permanent
> destination address". This being said:
> 
> - If $user wants a sure shot wrt to oob transmission, then a permanent
>    address is most likely desired, in which case MSG_STEADY should be
>    given. Otherwise, what would be the point of sending to a peer using
>    an aging ARP record _and_ being concerned about timeliness and
>    deterministic behavior in general (therefore denying deferral)?
> 
> - As it is, the implementation somewhat abuses the dont-wait
>    semantics. As a matter of fact, inband deferral won't make the caller
>    wait at all, only the packet will be delayed until the regular
>    netstack picks it. Meanwhile, EWOULDBLOCK is conventionally paired
>    with MSG_DONTWAIT, not EADDRNOTAVAIL.
> 

MSG_DONTWAIT denying inband was only introduced in 644d55e78e8e, right?

In this case I agree. Either you'd like to stay out of band now and in
the future -> MSG_STEADY or you don't care -> 0.

Otherwise, it might break already existing applications.

>> I have to test it and will send an update to the oob_net_udp patch
>> soon.
> 
> Thanks.
> 
>>
>> BTW: CC xenomai@lists.linux.dev got lost in my last email. I added it again.
> 

