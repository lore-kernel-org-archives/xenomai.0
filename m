Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C4E4315F
	for <xenomai@lists.linux.dev>; Sun, 26 Apr 2026 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777239132; cv=none; b=PHHV7sKLWDjVDTAqfTlnw7j+b+pc0lRlz6iPSVnjcWSgDP0VV9/z81QS4LdhHUTfItiHDbXPx9VRsjxT46edo5akvrJ7Hzc44KSaoCA/oa7BvwXNu9z7c33bSHg1ymnpvJprUWb1wj2KtBxDsGqqdWZYpQDfglMNim1J5UWKzxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777239132; c=relaxed/simple;
	bh=/MY1v+Z5jxQ6Ocr2qwnHuNuPdo4kSJPac1FTCcUfwXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ft0Ssi3wUWV0MpgOGa7vr70YqhLAsr6l4xu9PccIAnEJ0zqYzBKDQeYnw6Z2ZTnDMMki6/5u06NhiViP59RHDQ3DW0PpZPkU2EjpFxoHp3a6+5EX/CyIwVa8FL6AuKwj94w20CrZOmXyySV4pgbA8dtzolra4lj04YZuuyML6PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvDVOHRE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvDVOHRE"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ba840146so86240625e9.1
        for <xenomai@lists.linux.dev>; Sun, 26 Apr 2026 14:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777239129; x=1777843929; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGiJRSg4+y82PV0OvAemTx2RAdzVpubGVA6BPZe8qs4=;
        b=JvDVOHRE2f2+DORc5VTbdVQHmpv9X9Eq/x414AYnrgeGQNRoawKqo/lrYpKPYGtjZO
         xzHsFukBfGvuai1OJEB2bRINg1w6B4wP6t4HaXNUdLvJuMTH6iCg3KNMeqXgDSmnqnQY
         0C6NuuGVMq15p3jJEnX0WSlM1vGYzNV2V5XTQdXdgLcXIkHjKH0XnnApp+dr/4k49bld
         XSC0M+u5281i/866ql6UYeW0dOSG8Qq2CmUo2mzfd3d11FiFDBEZ1IsY5Tsm/GiGIjuK
         gh1WeaSp7BLroV8IwdTjciNYqETLGwRSDJmt3YoQYG8izyigejvrI7uJ+cG08aK/9hz1
         jiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777239129; x=1777843929;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGiJRSg4+y82PV0OvAemTx2RAdzVpubGVA6BPZe8qs4=;
        b=jAaOxL6AbkUag7A8zTGR2tr69T2rGdZM0TNJwV+8mM5gHJcceIK926rTXcbypZ34T5
         T8HdijVOrx1TYeh9lxiuiHkjNdBG6l9BwF5M+zN8ndtW37NYHDXfqKJQt2dO7RXUOxfE
         rtgPutYHS3bRcwEu9o2FdeD623VTVSMXltS4JuL6yaEkYhkuS4dyWpdc8fuOoNKodzLG
         NlxxpCLG3PI5+3HGEAwmZxGwE0zPTW28+JTL5OrRKTuTgrkCfFqjdp/csN5uwnTSiLgp
         dmuV2LKP7Nna9+3wrlJdCyVc11dgozgMHe2W3NQsmH+4QmuMZ/bapmGfYkXNOi+ZXWK9
         iudg==
X-Gm-Message-State: AOJu0YzWPyRE2xYDWxoh/8ePItdEpDEYEhxGR2IijS6YL/Iu2BrcVBQ4
	7JZ8jucXhP6MR8chRBUnLqGbfvgZu3/uLXrvAzoN004zMolhHzPv9b6a
X-Gm-Gg: AeBDieuwtoxhAckagc+pJOHP9l9/2elNXTPRVcm/QU5eTN0HyDpCyyx0C/5eJ3fQm1e
	bZUyuEx0gQlWb/GaqM8H/IRzbtMXrhOiPdOKZY7YsVky+8MG7Byd6SooEvxQEr7Yfno3ArbH5yR
	N4zA+MMGwv1bpzJKhrQc7koy93J7BvVqFnsmeJfJM/Ha56WuU7+i2e+7BY80LqNtSiB1mzveh/q
	RmqjDF/y/TL2okihTpkY+64VJkL500lRV21JnyBZ4cChne7Ec108+4t/Yk0wKQSSALtkK9VTPUw
	3S+c4rATN7A+asJlREr+bBRGPT9O9r7rVaqhLyG8xPWo5ven4//Ea1Z1zPFtqGXWTe4n08TW8ht
	+12CuCdC8DAXMzR1vddFTZi0h0oxaUSHtZzrn1JsOdvhTd87eTJW1c/upd4jlRb8SEicl/4MLyY
	qGhEJUYF1M8Lm++7wjOm12P1vqniKo+bTQZz3nucQraA==
X-Received: by 2002:a05:600c:33a6:b0:489:1c1f:35f9 with SMTP id 5b1f17b1804b1-4891c1f38b6mr258657055e9.9.1777239129070;
        Sun, 26 Apr 2026 14:32:09 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a52583fe7sm422966555e9.13.2026.04.26.14.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2026 14:32:07 -0700 (PDT)
Message-ID: <2686ae4a-c63e-418e-8b4a-be49a22db83f@gmail.com>
Date: Sun, 26 Apr 2026 23:32:06 +0200
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
 <87340ij2lx.fsf@xenomai.org> <201a7d9c-e1dc-4686-8a5e-adc7c921ba14@gmail.com>
 <87jytt34q7.fsf@2a01cb0804738000b42250ae26cae50b.ipv6.abo.wanadoo.fr>
From: Hannes Diethelm <hannes.diethelm@gmail.com>
Content-Language: de-CH
In-Reply-To: <87jytt34q7.fsf@2a01cb0804738000b42250ae26cae50b.ipv6.abo.wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 26.04.26 um 21:24 schrieb Philippe Gerum:
> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
> 
>> Am 25.04.26 um 20:50 schrieb Philippe Gerum:
>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>
>>>> Hello
>>>>
>>>> There is a Kernel WARNING: "notifier callback netevent_handler already registered right after boot". It is repeated 5 times.
>>>>
>>>> Config:
>>>> Debian Trixie with xfce4 Desktop
>>>> libevl: r56
>>>> linux-evl: v6.12.67-evl2-rebase
>>>>
>>>> I traced the issue already trough the following code:
>>>> net/core/net_namespace.c:355
>>>> kernel/evl/net/net.c:35
>>>> kernel/evl/net/ipv4/ipv4.c:41
>>>> kernel/evl/net/ipv4/arp.c:323
>>>>
>>>> However, I lack the knowledge to do a proper fix. One way would be to just check in evl_net_init_arp() if it is already
>>>> registered and don't do it more than once but that doesn't feel right.
>>> It looks like the system is instantiating multiple network
>>> namespaces,
>>> for each of which we set up an ARP front cache by calling
>>> evl_net_init_arp(). Bad idea to hook a system-wide handler there as
>>> well. Could you confirm this fix [1] works for you?
>>> Thanks for reporting this.
>>> [1]
>>> https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/569beef061321c2c00d775b13ad0aec1a1d2a416
>>>
>>
>> Thanks, that was fast. The WARNING is gone now.
>>
>> But now after just updating to the kernel including your fix, I have a different behavior on
>> incoming packages. It seams that the default when no filter is set has changed from EVL_RX_SKIP to EVL_RX_ACCEPT.
>>
>> linux-evl: v6.12.67-evl2-rebase
>> -After evl net -ei enp7s0, I can ping another host.
>> -oob-net-icmp does only receive packages when I use an eBPF filter with EVL_RX_ACCEPT
>> -After that, ping doesn't work any more
>>
>> linux-evl: v6.12.y-cip-evl-rebase
>> -After evl net -ei enp7s0, I can NOT ping another host.
>> -oob-net-icmp does receive packages
>> -If I use an eBPF filter returning EVL_RX_SKIP, I can ping again
>>
>> I am not using VLAN's.
>>
>> Was that changed on purpose?
> 
> Yes, this is implemented by this commit [1]. The rationale here is that
> if you turn on the oob port directly on a base device, then the evl net
> stack may assume that the device is entirely dedicated to oob traffic,
> as opposed to enabling such port on some upper device based on the
> former (e.g. a VLAN interface). As a result, all ingress traffic
> received by such base device is diverted (RX_ACCEPT) to the evl net
> stack.
> 
> [1] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/3026e69cee2a1de047818fa06ad8c44623461a0d
> 

This makes sense. It took me some time to get evl reading packages by 
activating an eBPF filter and it's mostly save to assume that you don't 
have mixed traffic on an real time network interface. With this change, 
a filter is not needed any more.

A bit off topic:

Is there anything like rtping for evl? I have seen oob-net-icmp.c but 
this is answering requests.

In Xenomai3, there is a debian package configuration. Any interest in 
one for libevl? I have one working but it's still very basic. If it's 
presentable, I can send a patch.
