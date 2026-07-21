Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DE3367B63
	for <xenomai@lists.linux.dev>; Tue, 21 Jul 2026 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784673377; cv=none; b=Bra2wzFMSySndlkQp06NProv3rH+/ZsSilHhx5TdjJMFWE+Vvs8Yh+7tg2FH9s+KKSNVtTKxb4+fRDzEslnGz34dV4tsuCFADoc8Sp1FbHoycO21IyrlSk8WZ+5pYnIABeJgromYdXo5TXpG6ZbUK1IJ8jC4OpMO3jFi3iRQyiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784673377; c=relaxed/simple;
	bh=YeW8Oe/4ZVBnCvO+/b6GYrrjaOdT+nfQXcl4+4PSEes=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BvCpMHWxXxBs9t4fsWN7u4VFraDM1LivNiw7S47U3ZOqZXRzV934nH0diCheCW6qCcK+VdviAfT1obVSVPYJwKMaN5rVepdKgl2tv8fol6oiWUQ/fi86YC5jdklrpcTMT3WK3EG+/Gn+hBmiJHddA7WFRZkb+U0+UuCOUrCKz2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PllAC6oc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PllAC6oc"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso42806375e9.0
        for <xenomai@lists.linux.dev>; Tue, 21 Jul 2026 15:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784673374; x=1785278174; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q2tiBeFlUcpZYQEhlYymbQPMeZrtgG+M3RD0r4gY6P4=;
        b=PllAC6oc+dJKq/gt4WnKbo9l46bbW4VI42sH7YUwD8VeageDcfTsLClc1y0imxB3jF
         1lByUoWbv31UVvRFTtdNGkWwo1RSgkFNIgJwd4GUzTq0aAuQeLx3EUnddQKVfBOTTaHs
         XQ0Sn7Tce8wKWKPWAuZjxn9NN6hnu/tQbMzZICVHuZFeX5e8WVM0w+Z8VZLy58pXtK4r
         1EbnuORzJMxXuUnapwGU8cw+P3PNHzDctMVeywC9M6NvknPSpHLRp482Hh3v5bjZXAJm
         JaxbR7lbSailqC+HoE1s85deyKRVSksXGtnFayScczsJfrOABwlkBye9quZJRhCvcVWh
         uEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784673374; x=1785278174;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q2tiBeFlUcpZYQEhlYymbQPMeZrtgG+M3RD0r4gY6P4=;
        b=p5G2o6jFXvZcuwQIhP2WLSKhe4BTOk8FuOnsldWG3URV2XWeLtXihZVXBKYitI5dZk
         RO5sNsqyKyXnyYMDZ5L/b54NYDW8m7UgeCyFuctECaavJyf4cIor+h88Z4zF2jmsqRH7
         HM6Bc5XGYJg/2MHepSnbHOkoFsnV1j02rQmAUx/OnBM4Ekp5vlBj8o6SW7IJXfbhp3Pc
         y9LFY8akYN1/waLUFW1dKV7qEBBRrhoVScWpYx7Gt7qciw9ZOIo4UW5d2vgzgCnr91VQ
         ziRrYOEX6QZKPvxKRpDV/qw3AFBqBeBe5WlGZwy9nCXXfSVePD9mlxZBiWSYnlJIVKuj
         a3vQ==
X-Gm-Message-State: AOJu0YycMOLocBvJO0QyT7BoX7bhniwHX3y80zuY+NSnpxBYicj5Gi4j
	rNLUVCFojqjaHeBdPPOeKsbC1OYAJgotH/2zhoj2ryk+Arckf3qbRfwTxQ95S+nX
X-Gm-Gg: AfdE7cnM16VDgZEO9TjEwfk9hHyOPCZBHfdXEadD3jmwvfY9ykeemS6wxFrCsZPNKQP
	ygpUsmlaKJdmB32PQr4pAtznwy/rJiT2zxpoym8X3qwpaca+bnr78Qu6LTEgDITXL1K70tcukGf
	wGBQvrih0n4h61m2dol9N1gcBByGdY15OS6WjbHa+fvDUNjSwBCCdVEwato26SOrJxPfZuBu/M3
	mwL2WjasY533/aNnyGltrWWF6cav4CIeuQkPW9olcAbf9ehSFM4dioU8/8blc3UR6jNgaQLdOeL
	QymWce0j5Uiej+Q4K1xnRShIr4+knMkcZziv+dBrK0t+aoPemFjiR0Re9q6+l8rT1GS24ilofB8
	2FvafiekIRAyZGe09i1HBzkiBISm9TEWQRK196ofmohOX7w6kkX+u46j6ptgScWY2r59ZeSLBrI
	zPLI7bgTBtBQ==
X-Received: by 2002:a05:600c:138a:b0:493:f318:3bc6 with SMTP id 5b1f17b1804b1-4954a3dc7b1mr245234105e9.13.1784673374240;
        Tue, 21 Jul 2026 15:36:14 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956ab41aa2sm17623615e9.1.2026.07.21.15.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 15:36:13 -0700 (PDT)
Message-ID: <3105aa6e-ba08-4e5a-b228-233473aa5675@gmail.com>
Date: Wed, 22 Jul 2026 00:36:12 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hannes Diethelm <hannes.diethelm@gmail.com>
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
Content-Language: de-CH, en-US
In-Reply-To: <87jyqodrq0.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 21.07.26 um 22:15 schrieb Philippe Gerum:
> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
> 
>> Am 20.07.26 um 16:27 schrieb Philippe Gerum:
>>
>> An option would be either to support of oob_ioctl() for SIOCGARP. Or create something like
>> evl_net_routeinfo(s, addr) returning flags would make probing obsolete.
>>
> 
> Not entirely. The issue with solely having SIOCGARP or any probe-only
> explicit request is that you would have to pair two syscalls at each
> transmit at least, one to probe for the sender address before possibly
> soliciting that peer if absent from the oob cache, another one for
> sending the message eventually. i.e., for every packet:
> 
>      ioctl(SIOCGARP)
>           !ATF_COM? -> evl_net_solicit()
>      oob_sendmsg(..., 0)

You are right, that is an unneeded syscall as long as you don't keep a
list of clients as before. This can remove the need from calling
evl_net_solicit() in the case the client is already in ARP and permanent but
this will be the only change and won't help that much.

> 
> OTOH, with the latest attempt to address this issue, we can send a
> probe-only request by passing MSG_PROBE (EHOSTUNREACH), or a request
> that does not attempt to defer transmit to the inband stage on probe
> failure by passing MSG_DONTWAIT (EWOULDBLOCK). i.e., for every packet
> 
> redo:
>      oob_sendmsg(..., MSG_DONTWAIT)
>           EWOULDBLOCK?
>                 oob_sendmsg(..., MSG_PROBE)
>                    EHOSTUNREACH?
>                        evl_net_solicit()
>                        goto redo
>                    otherwise assume ENOMEM
>           otherwise all done
> 
> IOW, using a proper combination of MSG_DONTWAIT and MSG_PROBE in the
> right sequence would either succeed to send the packet immediately on
> the first oob_sendmsg() call, otherwise fail on memory shortage or
> missing route from the oob cache. In the latter case, which could only
> happen once for each new peer under normal circumstances, we could
> disambiguate the EWOULDBLOCK status using an explicit probe.
> 
> A better way to do this in a single step unambiguously would require the
> addition of another operation flag, like MSG_DONTDEFER, preventing the
> deferral to inband on failed probe and causing oob_sendmsg() to return
> with a specific error code. e.g. something as simple as the following
> would cover all requirements:
> 
>       oob_sendmsg(..., MSG_DONTDEFER) -> EADDRNOTAVAIL on failed probe.
> 
> Now, we might also piggyback off of MSG_OOB instead of defining yet
> another operation flag, as a way to say "oob only, don't relay to
> inband", but I'm still pondering whether this would be nicely witty or
> utterly confusing..
> 

Yes, this is a variant. I was not aware that MSG_DONTWAIT -> EWOULDBLOCK
can also mean ENOMEM.

Now after considering all options, i start to prefer the variant before
this patch, keeping a list of already solicit'ed clients. It is straight
forward, simple and fast. And you know exactly when to expect an in band
call. Might be we should just drop this patch instead of adding unnecessary
complexity for example code?

With MSG_DONTWAIT/MSG_PROBE you are not sure if the ARP entry is permanent.
That means if you are unlucky, a few packages are sent to the client before
EHOSTUNREACH is returned which could be bad for real time.
If you have a real time server and clients, I imagine clients would expect
the first response to be delayed due to initialization / ARP but every following
response to be in time.

With ioctl(SIOCGARP) or evl_net_routeinfo(), a list of checked client's would
also be needed due to it would be wasteful to call the kernel each time before
sending a package.

MSG_DONTWAIT / MSG_PROBE could still be useful in certain applications, for example
when you have a separate thread that handles evl_net_solicit(), so you can
just call oob_sendmsg() until it succeeds without needing to signal back.

This would be something like this:

server_thread:
     if(!is_in_list(addr))
         write_solicit_queue(addr)
         add_to_list(addr)
     oob_sendmsg(..., MSG_DONTWAIT)
          EWOULDBLOCK?
                oob_sendmsg(..., MSG_PROBE)
                   EHOSTUNREACH?
                       skip or mark for retry depending on the application
                   otherwise assume ENOMEM -> generate error
          otherwise all done

solicit_thread:
     while(true)
	addr=read_solicit_queue()
	evl_net_solicit(addr)

I also prefer using an explicit MSG_PROBE instead of an implicit zero size
message.

For ioctl(SIOCGARP) or evl_net_routeinfo(), I don't see a good use-case after
all. You can just use evl_net_solicit(), it probably won't hurt if you do it once to
much and you have to implement the case when evl_net_solicit() is needed anyway
and take the timing for this into account.

