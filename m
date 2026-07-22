Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A881D17A2F6
	for <xenomai@lists.linux.dev>; Wed, 22 Jul 2026 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753132; cv=none; b=Am1/aNGm4hwSLm6E/y+AelQPD6Tcmxiu6qPtHq1NPDbs890f915UfyurhfLubAMRD/cTc4Rtazah2rY1DAqHX1XMpFJdjdIiK/ncs6+C+mSEL/kdWnytAUSbaT0Q/F5mcsALme9fmUAV0W9bDKwxBsnB+/+dlNxCh8HpQYbyaUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753132; c=relaxed/simple;
	bh=qQWQUffmKCI0YklPnh9ePdHNO6E1WrBqxjwSTFlcFWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=D1VGPFPf6rpiujqkMu8MyjZGNrWJeVNcyzMr4SZ7sHCt49nvQvYiwic8ByBCSK4SBRrUtJQENQDJthelpawXcpPoUvEjZsgM6jmNBQPDjS/EDcJwDLczdZCEKeJz9LeQ4mOI6u/N4oypAgrJxQRKHSkVuyU8kKR+Dwy54VmhlEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dU2slmqN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU2slmqN"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4955158f26aso30119315e9.3
        for <xenomai@lists.linux.dev>; Wed, 22 Jul 2026 13:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784753129; x=1785357929; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:cc
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pxoZOve0/5QcU2bAI66xdx0HjJ45nxdLPGEhpmgoWNg=;
        b=dU2slmqNYLztvduClohpeyJIDZLsQyJW98nF/Bbg9gFoA9Tcb78xU4DNtUUC8arh0O
         wzocySphv2FOIhklgQBCu6pCUdEFciHXF0gFrwIe0oZ3MRt3rR17UPmP/OirDh56DQNw
         s8IONldj+vNRsI8puVc17wzmXnjB4nxHgxT8AHIYrgJ3TB0LUK0aMruPJX6cGyrh/h59
         810RKKoOXOcaE/h8Ld+NnnoTmUBEnlEOqUezprulIz2mdWn1dT5B3vxT2oGdo9ErMIla
         k+5Tbv+gqy3TMFU8Hrg7VhoaGe29kEwr94MDY+yqUTqIl2Hkz7UCQZ2vo97EHJHN5cIb
         zOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784753129; x=1785357929;
        h=content-transfer-encoding:content-type:in-reply-to:cc
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pxoZOve0/5QcU2bAI66xdx0HjJ45nxdLPGEhpmgoWNg=;
        b=pvQq1WNzAiQI9jriQizOvk/k4OERhAlHzTQvZysRpNZ4xto9Sce9VmNHCoSWlGGWsY
         9WqTOd4wirmJEODuiPWuM5ZCi1PKr8aFHairJV/rlph6Cva8SfFha+7KPC04qhkmVxrW
         +Yj10j+CuXqh1ekNaKmT9rdzH/o9Agea5q/wZEQhZ9elVxPwrApKvDLRNuc80WlgYjUo
         Tu3QtlFMMvSjnz26QEpcBr+tDXaAemoqGMsgyDbcCxDJX1ZliMeuEbcnbLntbc7TgCkM
         bNC5404QjORjmahlfbLGNCNpMv0GxY9FHU1V1zCPz29istNIt8pRntUEl++l8ozFgUAB
         r42A==
X-Gm-Message-State: AOJu0YzIqrPdnesS0/fu8NrLv4Ec2u8mrG+h+kseoD8a2HaKwnrjK6FN
	8EJArwGZwD2JsuJR/PtEZzSuL0do3rGQJ5neB5QfpxNx+Gtcc49uFo18
X-Gm-Gg: AR+sD12+Xc7w1fErUJ1jqtFYZ5wryqVh5JYA/WjOYVOhiiPihOYTjq3M+kV9wjomyG2
	lBbCQf52iT575tOIBoG8QAYN5dMaxND8df15iadBZ13sZQVwo72l+TjeSncxkry4IFDfKT+cgqk
	C/cKFdzIyK6c3kSa5/S5aH8cgUf20lISDwe2+AocJUVClWDrG2/o7Y+EUBI4Dp9XIDoeyK/QEQs
	v15rhgvgJHgsvrKIA1PcsMPJ5or5v7S/U97sKMiOk2n00s7XnwsF73GqNoWYToEdoJ1IpX0o0E9
	AXamuBt+yajb9GuRKBsbnP9Fr29Z7PVb3uoP59eB/AOmxvGljLYWQubdXvtN7fUePxeajO2qrEt
	B/zFlPJA9aE6CfXqMRbPOTlt8cOJzt++BssLZUTISwIYPesvEjaRGBlnW0slxdr+rofjBwbZvRu
	2qloZXwEV4LQ==
X-Received: by 2002:a05:600c:3593:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-49573cc9661mr2817015e9.15.1784753128758;
        Wed, 22 Jul 2026 13:45:28 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956b72fac1sm73158405e9.1.2026.07.22.13.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 13:45:28 -0700 (PDT)
Message-ID: <fc1b080c-54ed-4449-8958-fd8be91e1d8f@gmail.com>
Date: Wed, 22 Jul 2026 22:45:27 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tidbits: net-udp: solicit new client for server mode
To: Philippe Gerum <rpm@xenomai.org>
References: <20260528194459.6117-1-hannes.diethelm@gmail.com>
 <20260528194459.6117-2-hannes.diethelm@gmail.com>
 <87a4te64vn.fsf@xenomai.org> <874ijm62yu.fsf@xenomai.org>
 <3216fbd8-3ee4-46f7-851b-0f3b48c38572@gmail.com> <87ik7d86kn.fsf@xenomai.org>
 <6c0d9a13-732b-49c5-886b-3dda8b1f5cab@gmail.com> <87o6gmzlpn.fsf@xenomai.org>
 <13bb8457-8148-4758-84d5-1ab324e978bd@gmail.com> <8733xd20u3.fsf@xenomai.org>
 <11409ae1-be7b-4003-8d40-f5e1cb34d2ec@gmail.com> <87jyqodrq0.fsf@xenomai.org>
 <3105aa6e-ba08-4e5a-b228-233473aa5675@gmail.com>
 <dc6c2532-08e4-417d-85dd-8d2e89b34ae7@gmail.com> <87h5lrh503.fsf@xenomai.org>
 <87tspqg9bu.fsf@xenomai.org>
From: Hannes Diethelm <hannes.diethelm@gmail.com>
Content-Language: de-CH
Cc: xenomai@lists.linux.dev
In-Reply-To: <87tspqg9bu.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.07.26 um 20:36 schrieb Philippe Gerum:
> Philippe Gerum <rpm@xenomai.org> writes:
> 
>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>
>>> Am 22.07.26 um 00:36 schrieb Hannes Diethelm:
>>>> Am 21.07.26 um 22:15 schrieb Philippe Gerum:
>>>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>>>
>>>>>> Am 20.07.26 um 16:27 schrieb Philippe Gerum:
>>>>>>
>>>>>> An option would be either to support of oob_ioctl() for
>>>>>> SIOCGARP. Or create something like
>>>>>> evl_net_routeinfo(s, addr) returning flags would make probing obsolete.
>>>>>>
>>>>>
>>>>> Not entirely. The issue with solely having SIOCGARP or any probe-only
>>>>> explicit request is that you would have to pair two syscalls at each
>>>>> transmit at least, one to probe for the sender address before possibly
>>>>> soliciting that peer if absent from the oob cache, another one for
>>>>> sending the message eventually. i.e., for every packet:
>>>>>
>>>>>       ioctl(SIOCGARP)
>>>>>            !ATF_COM? -> evl_net_solicit()
>>>>>       oob_sendmsg(..., 0)
>>>> You are right, that is an unneeded syscall as long as you don't keep
>>>> a
>>>> list of clients as before. This can remove the need from calling
>>>> evl_net_solicit() in the case the client is already in ARP and
>>>> permanent but
>>>> this will be the only change and won't help that much.
>>>>
>>>>>
>>>>> OTOH, with the latest attempt to address this issue, we can send a
>>>>> probe-only request by passing MSG_PROBE (EHOSTUNREACH), or a request
>>>>> that does not attempt to defer transmit to the inband stage on probe
>>>>> failure by passing MSG_DONTWAIT (EWOULDBLOCK). i.e., for every packet
>>>>>
>>>>> redo:
>>>>>       oob_sendmsg(..., MSG_DONTWAIT)
>>>>>            EWOULDBLOCK?
>>>>>                  oob_sendmsg(..., MSG_PROBE)
>>>>>                     EHOSTUNREACH?
>>>>>                         evl_net_solicit()
>>>>>                         goto redo
>>>>>                     otherwise assume ENOMEM
>>>>>            otherwise all done
>>>>>
>>>>> IOW, using a proper combination of MSG_DONTWAIT and MSG_PROBE in the
>>>>> right sequence would either succeed to send the packet immediately on
>>>>> the first oob_sendmsg() call, otherwise fail on memory shortage or
>>>>> missing route from the oob cache. In the latter case, which could only
>>>>> happen once for each new peer under normal circumstances, we could
>>>>> disambiguate the EWOULDBLOCK status using an explicit probe.
>>>>>
>>>>> A better way to do this in a single step unambiguously would require the
>>>>> addition of another operation flag, like MSG_DONTDEFER, preventing the
>>>>> deferral to inband on failed probe and causing oob_sendmsg() to return
>>>>> with a specific error code. e.g. something as simple as the following
>>>>> would cover all requirements:
>>>>>
>>>>>        oob_sendmsg(..., MSG_DONTDEFER) -> EADDRNOTAVAIL on failed probe.
>>>>>
>>>>> Now, we might also piggyback off of MSG_OOB instead of defining yet
>>>>> another operation flag, as a way to say "oob only, don't relay to
>>>>> inband", but I'm still pondering whether this would be nicely witty or
>>>>> utterly confusing..
>>>>>
>>>> Yes, this is a variant. I was not aware that MSG_DONTWAIT ->
>>>> EWOULDBLOCK
>>>> can also mean ENOMEM.
>>>> Now after considering all options, i start to prefer the variant
>>>> before
>>>> this patch, keeping a list of already solicit'ed clients. It is straight
>>>> forward, simple and fast. And you know exactly when to expect an in band
>>>> call. Might be we should just drop this patch instead of adding unnecessary
>>>> complexity for example code?
>>>
>>> BTW: With drop this patch I don't mean the one already in but this one:
>>> [PATCH] tidbits: net-udp: use MSG_DONTWAIT for server mode
>>> https://lore.kernel.org/xenomai/20260717192541.15829-1-hannes.diethelm@gmail.com/T/#u
>>>
>>
>> Got it, it may be worth waiting for the dust to settle in the core
>> regarding the probing issue before adapting this tidbit anyway. I'm
>> going to consolidate the points we have discussed so far, in order to
>> come up with an implementation that satisfies all the requirements.
> 
> Here is a new proposal that should cover all the cases we discussed so
> far (next/v6.12.y-cip-evl-rebase branch). A new flag is introduced,
> namely MSG_STEADY, which tells the core to only accept cache lookups
> that deliver permanent ARP records. This flag can be combined with
> MSG_PROBE and MSG_DONTWAIT for extended semantics. Meanwhile, a
> zero-sized message is still accepted in order to request a mere address
> probe without having to pass any meaningful data. This goes like this:
> 
> Function: probe-only
> 
> 	      oob_sendmsg(s, &msghdr, NULL, MSG_PROBE)
> 	          -> EADDRNOTAVAIL if no peer address found
> 
> Function: probe-only, permanent peer address required
> 
>    	      oob_sendmsg(s, &msghdr, NULL, MSG_PROBE|MSG_STEADY)
> 	          -> EADDRNOTAVAIL if no permanent peer address found
>                       (also upon match of aging ARP record)
> 
> Function: send, no deferral (to inband) allowed
> 
> 	      oob_sendmsg(s, &msghdr, NULL, MSG_DONTWAIT)
> 	          -> EADDRNOTAVAIL if no peer address found
> 	          -> EWOULDBLOCK on memory shortage
> 
> Function: send, no deferral (to inband) allowed, permanent peer address required
> 
> 	      oob_sendmsg(s, &msghdr, NULL, MSG_DONTWAIT|MSG_STEADY)
> 	          -> EADDRNOTAVAIL if no permanent peer address found
>                       (also upon match of aging ARP record)
> 	          -> EWOULDBLOCK on memory shortage
> 
> Function: send, permanent peer address required
> 
> 	      oob_sendmsg(s, &msghdr, NULL, MSG_STEADY)
> 	          -> EADDRNOTAVAIL if no permanent peer address found
>                       (also upon match of aging ARP record)
> 

Looks promising. This also means after
oob_sendmsg(..., MSG_DONTWAIT|MSG_STEADY)
no second call oob_sendmsg(..., MSG_PROBE) is needed to handle
-ENOMEM right?

oob_sendmsg(s, &msghdr, NULL, 0) is the only case with deferral to inband
as it looks in udp.c:421...423?
if (ret != -EADDRNOTAVAIL ||
	msg_flags & (MSG_PROBE|MSG_DONTWAIT|MSG_STEADY))
		return ret;


I have to test it and will send an update to the oob_net_udp patch soon.

BTW: CC xenomai@lists.linux.dev got lost in my last email. I added it again.
