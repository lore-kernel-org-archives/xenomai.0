Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768DB221F1F
	for <xenomai@lists.linux.dev>; Sat, 16 May 2026 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778921338; cv=none; b=d7ahtmQUpjCjuJoirh3K4Sb+BotTlz2OJ2OUE8U3SCE/IYsbnjR7pI+NhB06LPFvorpXUrMlNRjw4UZ5D/KyTEdyWvN5REgyGe5vu/6Mt+vYwyoy1SyKJrn3b6iSiaXHx/uRMDJ2f8+56ltxq/QOYNaNKshGBimPahQRlpVOCY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778921338; c=relaxed/simple;
	bh=4QjIq29z2/OZDe6MTgPJhBgW4dKDg3aIxziAU/0mKkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYh8KCrVumllQ5V6k+DqvqzvCj/YGaQTtWkF6MnwDe9ocCe6rbmFjPgMpcUid+GDcfKFin5gu/unI3uzclJzjDQYKbsSi3riWpNH7ntkzRD8iQcUbsxGQW2YbKsW2+IJMwGaROaOecaIpXwiPWwBpUvL3WMORVAEtTkgF9aWg9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E64akTsQ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E64akTsQ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d77f6092eso244591f8f.2
        for <xenomai@lists.linux.dev>; Sat, 16 May 2026 01:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778921335; x=1779526135; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=le0XTrYRGR6x9xYeY/0ITykwHTCZwj5XcFGDg1waqgA=;
        b=E64akTsQcRuLhOaj7cC6HWo08JtZ/rDudz3c/6f8FIKyiPiO0/NoRSkfU6xJGQ3AVd
         kmrf4B5mSyavG0N8X115vwf8V6HneXI8hzj2W9gXEJwNclPWY9AufEFI6Jtma/UNpv7i
         jTo+KpKjT5j9zqB/NIjXU0H+4pGbg337oF+y3gLm2CTFrikbSn0EyTi3RJ1Bnx/rxriH
         bGUMpg3PJIA0Ov1g2nvORsmfSl62CeQzixGhVgLvwcP6rbqSb11PxdF3x35J3ZKiX4pE
         j3CBIUKKjtBFIVo24MBWobcLNbn6gXErVQHjUtCvc9AvdXgj9EaOB2fuXTEAqCBIpuM8
         WRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778921335; x=1779526135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=le0XTrYRGR6x9xYeY/0ITykwHTCZwj5XcFGDg1waqgA=;
        b=CHG3h0D9hcrBFdGHC6BRB6EljXtR8QvZEd70kK7bVhAhgkiPh6m+LHa+hOMowC+YKH
         9ER33IoRka85yGbxSvz6i/3u2emZ22MNnuilOTKnWPlCEfRdsVJpVTKBHMVrLEPZplAG
         SwV2yyLGT8j5F8+VUn2Y3vx9m8WP+0HShDsabHUczqtSg1bfbUofkV3/KOtdWFLuWr1o
         5d7AOcKSKpCSs7OtUrUZW8Rn2SX3ZJGPGZGoKj1QxnLI9WWf1SCYjfpLXFEN7tSamhYj
         IATpUhDb6ajYWy9S2FX3gmy+o+UtrquQGLzWqsokaEi2mQtBm9vGiwT9PB3afxaDkkhn
         151g==
X-Gm-Message-State: AOJu0YxFELfKZHsTKVumVompTffcr0i8O0UTFFU+XYMFpcusejQUc+lm
	QxGEf2EM8mWlNIvH48qRj3zeG14CE9kahOcP7Zc/P0LLlQgUbnkivOtgXsp/oWZj
X-Gm-Gg: Acq92OG+fKUqM8TbIzpOuANtY1GMViEU9K8TsHy/REOmEFRN4zuH7SEP7/gycCBIA8J
	Mv7huuuWQaWkaUVvELDn51MVa2v105mnLm7OttyAHYgb2IuPBbAfSs30pyTCn3C7/5mqaAaUX1a
	+RuPNuWqDQlysaP3ZxPJNaykWvCjdjUDcceGIbroJOZTl+b3/kdsA8NsgzGA6RetGMBxOPPKwS3
	QWo86TUOZtxsliJkIkMWMmNTafMEL7F5x6lEFkGN1+tKRLfzdSOUtLnpbK89bVKMs65mAXEcE3X
	5k0PQ9UdG1mXxqZBzgFysMVHhktY3jZqasj4nEGIiPov0UAuzTCuZ598MpYFHvsdc3I1EZ+dgWw
	JiSdDo1AgV8WG5mH1Al+C9wvvMoNCugj11mvU3f2IcjWN/UgvSo7nW1K0bwl9rL9GNpYzftIsJ4
	WLWK6HsU5Ku+gr5/6CuT//We0z8d/X+Bo=
X-Received: by 2002:a5d:584c:0:b0:43f:dc54:9493 with SMTP id ffacd0b85a97d-45e5c5e3276mr9903521f8f.21.1778921334594;
        Sat, 16 May 2026 01:48:54 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a666fsm19176815f8f.36.2026.05.16.01.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 01:48:54 -0700 (PDT)
Message-ID: <358e950b-4019-4d47-81a4-0a06dc32be1d@gmail.com>
Date: Sat, 16 May 2026 10:48:53 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EVL] Kernel WARNING: notifier callback netevent_handler already
 registered
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>,
 Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
References: <8e08bda6-1fed-4a5a-9bb3-74f019b05855@gmail.com>
 <87340ij2lx.fsf@xenomai.org> <201a7d9c-e1dc-4686-8a5e-adc7c921ba14@gmail.com>
 <87jytt34q7.fsf@2a01cb0804738000b42250ae26cae50b.ipv6.abo.wanadoo.fr>
 <2686ae4a-c63e-418e-8b4a-be49a22db83f@gmail.com>
 <ee787e06594ea3a32125c2db0c2112e7f6a9a81d.camel@siemens.com>
Content-Language: de-CH, en-US
From: Hannes Diethelm <hannes.diethelm@gmail.com>
In-Reply-To: <ee787e06594ea3a32125c2db0c2112e7f6a9a81d.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 27.04.26 um 11:18 schrieb Florian Bezdeka:
> On Sun, 2026-04-26 at 23:32 +0200, Hannes Diethelm wrote:
>> Am 26.04.26 um 21:24 schrieb Philippe Gerum:
>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>
>>>> Am 25.04.26 um 20:50 schrieb Philippe Gerum:
>>>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>>>
>>>>>> Hello
>>>>>>
>>>>>> There is a Kernel WARNING: "notifier callback netevent_handler already registered right after boot". It is repeated 5 times.
>>>>>>
>>>>>> Config:
>>>>>> Debian Trixie with xfce4 Desktop
>>>>>> libevl: r56
>>>>>> linux-evl: v6.12.67-evl2-rebase
>>>>>>
>>>>>> I traced the issue already trough the following code:
>>>>>> net/core/net_namespace.c:355
>>>>>> kernel/evl/net/net.c:35
>>>>>> kernel/evl/net/ipv4/ipv4.c:41
>>>>>> kernel/evl/net/ipv4/arp.c:323
>>>>>>
>>>>>> However, I lack the knowledge to do a proper fix. One way would be to just check in evl_net_init_arp() if it is already
>>>>>> registered and don't do it more than once but that doesn't feel right.
>>>>> It looks like the system is instantiating multiple network
>>>>> namespaces,
>>>>> for each of which we set up an ARP front cache by calling
>>>>> evl_net_init_arp(). Bad idea to hook a system-wide handler there as
>>>>> well. Could you confirm this fix [1] works for you?
>>>>> Thanks for reporting this.
>>>>> [1]
>>>>> https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/569beef061321c2c00d775b13ad0aec1a1d2a416
>>>>>
>>>>
>>>> Thanks, that was fast. The WARNING is gone now.
>>>>
>>>> But now after just updating to the kernel including your fix, I have a different behavior on
>>>> incoming packages. It seams that the default when no filter is set has changed from EVL_RX_SKIP to EVL_RX_ACCEPT.
>>>>
>>>> linux-evl: v6.12.67-evl2-rebase
>>>> -After evl net -ei enp7s0, I can ping another host.
>>>> -oob-net-icmp does only receive packages when I use an eBPF filter with EVL_RX_ACCEPT
>>>> -After that, ping doesn't work any more
>>>>
>>>> linux-evl: v6.12.y-cip-evl-rebase
>>>> -After evl net -ei enp7s0, I can NOT ping another host.
>>>> -oob-net-icmp does receive packages
>>>> -If I use an eBPF filter returning EVL_RX_SKIP, I can ping again
>>>>
>>>> I am not using VLAN's.
>>>>
>>>> Was that changed on purpose?
>>>
>>> Yes, this is implemented by this commit [1]. The rationale here is that
>>> if you turn on the oob port directly on a base device, then the evl net
>>> stack may assume that the device is entirely dedicated to oob traffic,
>>> as opposed to enabling such port on some upper device based on the
>>> former (e.g. a VLAN interface). As a result, all ingress traffic
>>> received by such base device is diverted (RX_ACCEPT) to the evl net
>>> stack.
>>>
>>> [1] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/3026e69cee2a1de047818fa06ad8c44623461a0d
>>>
>>
>> This makes sense. It took me some time to get evl reading packages by
>> activating an eBPF filter and it's mostly save to assume that you don't
>> have mixed traffic on an real time network interface. With this change,
>> a filter is not needed any more.
>>
>> A bit off topic:
>>
>> Is there anything like rtping for evl? I have seen oob-net-icmp.c but
>> this is answering requests.
>>
>> In Xenomai3, there is a debian package configuration. Any interest in
>> one for libevl? I have one working but it's still very basic. If it's
>> presentable, I can send a patch.
> 
> There is a debianization for x4 in xenomai-images already. See [1].
> Can't tell why it hasn't been upstreamed yet. Maybe Tobias or Philippe
> can comment on that.
> 
> [1] https://gitlab.com/Xenomai/xenomai-images/-/tree/master/recipes-xenomai/libevl/files/debian

Thanks for the hint. This debianization is also basic, looks like it is only built for
CI purpose. But it helps to improve my version.

There are a few things missing:
- Build dependency's
- Optional: evl group + udev rules to allow non-root usage
- Probably much more for being a install & use debian package
