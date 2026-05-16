Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05E2390C9E
	for <xenomai@lists.linux.dev>; Sat, 16 May 2026 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778936016; cv=none; b=fsHu3EUIBYhptzySln6YwXx5vzK1RaaWnoqcC+Q89re2akk2OkdUFTdUxix74a4Bsqmdk1B5slsXM54UYvgF6hUADETVGxmJNFGHUwVAUtnEa7APGRCAn//YNFbuekBz6DmT6RJJsB4T36nYwfPikkTBaekdciZAs0KcpNLusUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778936016; c=relaxed/simple;
	bh=oh7oODXMufjH8D47CYpoa4S3bX5DhRaWLi2sdqR/oTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBpfhSIh/CNxk3HqZT3N2ccTJmF4BiuetStXAGxJrdisuWyo9rMaePVqFFRkBg/QAMtm5REcNdxC/tV32lVKVQ+zDk8Uwd8f6F2SdG4IMfwuNlGXPwB6/N8Xcz71HoWYt4nLxn+iysKFyRTWLOAYUYvFE+hGs2zdsLKA0XvcBLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhjBHg3y; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhjBHg3y"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48d102471a4so5151945e9.2
        for <xenomai@lists.linux.dev>; Sat, 16 May 2026 05:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778936013; x=1779540813; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vOMTnvRNgTTLNvDjjtizrPTWuo5syU0cd4/fiGK7F2U=;
        b=OhjBHg3y23i8WdvxofEyVRc2S7m5GoGx0mOw+EFCGhrR1QRDy7mLgQLxDgvV0KWFxW
         tBYgk/PJzU7TW5ylP7o+EjFtCzSIBtkjELLm4uEgITut8Dv+h+lydis9hFXnU7sgyFkO
         bPe4hORO/bP5cb6l8fMLDO/HrlxuLsAOmC8nCyo1KH7tYS+mtnbj2gIMXqc33bUg4wY7
         uPvFQT7r5GIjpZPDHiidjgis/3TT23Yz/9R5vNQZOfYAVHFz8ulKijFkx0IjlYyGdDfz
         CGKorW+P9XcFHd52T2hTWyrx5K1mv0h4C3q1sAakiM9okY7VzUXGBgejUoaGT+23J2oU
         aocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778936013; x=1779540813;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOMTnvRNgTTLNvDjjtizrPTWuo5syU0cd4/fiGK7F2U=;
        b=UW8brfq5yqasJvPbNten+pHs4ODgzN32k7hgRuUEPT+tglgjqcrd1nPpBbDaa90FAO
         jQT1W8XbQzX0ZwF2qg7qlbFggxV9+YF0OVm+Q+0jlOahqhFI0lT+bTowqVlNCET5vb+9
         vjD4wKGHijQBRm49Hhn5x0igqo6S3SL/vpWBhcycFEO7YpXiRr0AbkUr9uQEO+S+HDyf
         NStKgn7ZNPrzknl2JqLDeOApyLBII7b2g6qW8UHS4CvivT+R+s2r4gDXw5O9n4YCK7lx
         aeanLJJwEntnn4qKNyZafM5NgYwXo0gojiEgdNW26gzPoUxi2kHCgC2tLJUDRrScNa7c
         GSaA==
X-Gm-Message-State: AOJu0YyDpvT5YElbuCqZUakkfy/rV/rYqrWw0JBDTm2AwchqonzMeQ0d
	IsvuDssZnQ0Sm9f16WQTPMUl1fwOAzP1NTR52jPNuejRaWtXtV97ox18
X-Gm-Gg: Acq92OGMhCjlMTW5sizT5qPOjS/WVozjJOliDMkNhoKYDRCpOVt3DZEZjX8FO08o1th
	wKcq52ZqHUv4O5fKhGXlLhN+az6v/J8WRTHi7MOyfj51rWbHoUGZ4eTtA6os6Wav1DPPfdZwJ3f
	tM0TIl6uBHJ0qDpmElgaskCEo0ZQdbUzdSrGxi2vH27l3E26tz2qLavFyyGHJdzZqXpRPzl+5ch
	WkCk5walO+PHksKI1Bzqz6tnYVNtEx9Qx1uze0V4AJt7B6AW2GqTnr7L3PVKvkRRXKJpyiTSbDo
	3xCRPSjT6JSVjZVnYUR+QFB370948mbYaD1U1Hle/gg/z0TB0DwRcaocj26NiPQzpE1WWv1PG8/
	AJQAGgPZmwE4gIu9MSd5p4VZKymD1ctPXGiOGivkRkA9E1nJiu74WmxjqUPNEcRDU3mDEwmk8TZ
	cTYoxjV/SwLP9a5oLjeTCNZ9f6zn69DRwYqslEWFYo3g==
X-Received: by 2002:a05:600c:1e24:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-48fe63182a2mr118007235e9.26.1778936012896;
        Sat, 16 May 2026 05:53:32 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57943b2sm129814605e9.8.2026.05.16.05.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 05:53:32 -0700 (PDT)
Message-ID: <72d7190a-2332-4033-8a1d-f04eea74fcc5@gmail.com>
Date: Sat, 16 May 2026 14:53:31 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EVL] Kernel WARNING: notifier callback netevent_handler already
 registered
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>,
 Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
References: <8e08bda6-1fed-4a5a-9bb3-74f019b05855@gmail.com>
 <87340ij2lx.fsf@xenomai.org> <201a7d9c-e1dc-4686-8a5e-adc7c921ba14@gmail.com>
 <87jytt34q7.fsf@2a01cb0804738000b42250ae26cae50b.ipv6.abo.wanadoo.fr>
 <2686ae4a-c63e-418e-8b4a-be49a22db83f@gmail.com>
 <ee787e06594ea3a32125c2db0c2112e7f6a9a81d.camel@siemens.com>
 <358e950b-4019-4d47-81a4-0a06dc32be1d@gmail.com>
 <f8527d17-78bc-4852-9ffa-2c3b5110570d@siemens.com>
From: Hannes Diethelm <hannes.diethelm@gmail.com>
Content-Language: de-CH, en-US
In-Reply-To: <f8527d17-78bc-4852-9ffa-2c3b5110570d@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 16.05.26 um 11:50 schrieb Jan Kiszka:
> On 16.05.26 10:48, Hannes Diethelm wrote:
>> Am 27.04.26 um 11:18 schrieb Florian Bezdeka:
>>> On Sun, 2026-04-26 at 23:32 +0200, Hannes Diethelm wrote:
>>>> Am 26.04.26 um 21:24 schrieb Philippe Gerum:
>>>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>>>
>>>>>> Am 25.04.26 um 20:50 schrieb Philippe Gerum:
>>>>>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>>>>>
>>>>>>>> Hello
>>>>>>>>
>>>>>>>> There is a Kernel WARNING: "notifier callback netevent_handler
>>>>>>>> already registered right after boot". It is repeated 5 times.
>>>>>>>>
>>>>>>>> Config:
>>>>>>>> Debian Trixie with xfce4 Desktop
>>>>>>>> libevl: r56
>>>>>>>> linux-evl: v6.12.67-evl2-rebase
>>>>>>>>
>>>>>>>> I traced the issue already trough the following code:
>>>>>>>> net/core/net_namespace.c:355
>>>>>>>> kernel/evl/net/net.c:35
>>>>>>>> kernel/evl/net/ipv4/ipv4.c:41
>>>>>>>> kernel/evl/net/ipv4/arp.c:323
>>>>>>>>
>>>>>>>> However, I lack the knowledge to do a proper fix. One way would
>>>>>>>> be to just check in evl_net_init_arp() if it is already
>>>>>>>> registered and don't do it more than once but that doesn't feel
>>>>>>>> right.
>>>>>>> It looks like the system is instantiating multiple network
>>>>>>> namespaces,
>>>>>>> for each of which we set up an ARP front cache by calling
>>>>>>> evl_net_init_arp(). Bad idea to hook a system-wide handler there as
>>>>>>> well. Could you confirm this fix [1] works for you?
>>>>>>> Thanks for reporting this.
>>>>>>> [1]
>>>>>>> https://gitlab.com/Xenomai/xenomai4/linux-evl/-/
>>>>>>> commit/569beef061321c2c00d775b13ad0aec1a1d2a416
>>>>>>>
>>>>>>
>>>>>> Thanks, that was fast. The WARNING is gone now.
>>>>>>
>>>>>> But now after just updating to the kernel including your fix, I
>>>>>> have a different behavior on
>>>>>> incoming packages. It seams that the default when no filter is set
>>>>>> has changed from EVL_RX_SKIP to EVL_RX_ACCEPT.
>>>>>>
>>>>>> linux-evl: v6.12.67-evl2-rebase
>>>>>> -After evl net -ei enp7s0, I can ping another host.
>>>>>> -oob-net-icmp does only receive packages when I use an eBPF filter
>>>>>> with EVL_RX_ACCEPT
>>>>>> -After that, ping doesn't work any more
>>>>>>
>>>>>> linux-evl: v6.12.y-cip-evl-rebase
>>>>>> -After evl net -ei enp7s0, I can NOT ping another host.
>>>>>> -oob-net-icmp does receive packages
>>>>>> -If I use an eBPF filter returning EVL_RX_SKIP, I can ping again
>>>>>>
>>>>>> I am not using VLAN's.
>>>>>>
>>>>>> Was that changed on purpose?
>>>>>
>>>>> Yes, this is implemented by this commit [1]. The rationale here is that
>>>>> if you turn on the oob port directly on a base device, then the evl net
>>>>> stack may assume that the device is entirely dedicated to oob traffic,
>>>>> as opposed to enabling such port on some upper device based on the
>>>>> former (e.g. a VLAN interface). As a result, all ingress traffic
>>>>> received by such base device is diverted (RX_ACCEPT) to the evl net
>>>>> stack.
>>>>>
>>>>> [1] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/
>>>>> commit/3026e69cee2a1de047818fa06ad8c44623461a0d
>>>>>
>>>>
>>>> This makes sense. It took me some time to get evl reading packages by
>>>> activating an eBPF filter and it's mostly save to assume that you don't
>>>> have mixed traffic on an real time network interface. With this change,
>>>> a filter is not needed any more.
>>>>
>>>> A bit off topic:
>>>>
>>>> Is there anything like rtping for evl? I have seen oob-net-icmp.c but
>>>> this is answering requests.
>>>>
>>>> In Xenomai3, there is a debian package configuration. Any interest in
>>>> one for libevl? I have one working but it's still very basic. If it's
>>>> presentable, I can send a patch.
>>>
>>> There is a debianization for x4 in xenomai-images already. See [1].
>>> Can't tell why it hasn't been upstreamed yet. Maybe Tobias or Philippe
>>> can comment on that.
>>>
>>> [1] https://gitlab.com/Xenomai/xenomai-images/-/tree/master/recipes-
>>> xenomai/libevl/files/debian
>>
>> Thanks for the hint. This debianization is also basic, looks like it is
>> only built for
>> CI purpose. But it helps to improve my version.
>>
>> There are a few things missing:
>> - Build dependency's
> 
> Which one? We are building the package in a clean sbuild env, so missing
> build dependencies should have been revealed.
> 
> Note that Build-Depends is templated so that we could adjust it to
> different libevl versions (not needed right now, though).
> 
Now I see it the templates. It makes it more flexible but makes it neccessary
to read into sbuild.
>> - Optional: evl group + udev rules to allow non-root usage
>> - Probably much more for being a install & use debian package
>>
> 
> Always open for patches to improve things. We might also move
> debianization to libevl (like done for Xenomai 3) if that brings more
> value to users.
> 
> Jan
> 
At least for me, having the debianization for xenomai3 helped a lot getting
all up and running.
I will create a patch when I have something presentable.

Regards
Hannes
