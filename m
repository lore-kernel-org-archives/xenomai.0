Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44EC3314AC
	for <xenomai@lists.linux.dev>; Sat, 23 May 2026 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779530448; cv=none; b=Ch917CxWSB6YSCfe6PtOC7ha/82DA9XaEGwQ4aAurE8aRuYAqGjgQ5dtu112SVjrf6iV5RkIwibVWDtuG+lKH4UbDQZlS/W+q91dQimLd/nzt3emkPfYRla7pA+bqz+VZJWyxNMXhFgrjQrlB/+KptTYaeoVEYohE7ndbLJ6+2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779530448; c=relaxed/simple;
	bh=Knx4hhw2r/FrCG0yC5TDgaBxaX5E43rYR3TcUUwy6U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMHsRp3Kl1nf7/jL3kZHJdj4taFoMd306hk48HDbwDM4EW0adX36kX7DYQZjI4rkGErz741IO2V4Kg3lJVylPeiTzx0IcR89+hcz4s7PpzVQkIxrCh6Zb7X+MEkV0agYiy5mg9tPN55DGG2W6QDqQVnWgWJgan524K6nUu4cADc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QH3lWgGV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH3lWgGV"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso70611845e9.2
        for <xenomai@lists.linux.dev>; Sat, 23 May 2026 03:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779530445; x=1780135245; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xxjht8o5lHBtZXinwsyLwVfPVqsT5iwZdFL6CQMq5sA=;
        b=QH3lWgGVY1YpCj56eWTEJE7MMQuDSQP9PJAz5GRgH4Pjk2c2UF16mXGoeWidyL3Nl3
         y0BVrRyBd6kmBrI4gNMsglqCu6UsJJ2+P8ZYz7IcoycthtYPEQtvG2uFA+aKVvEqNjHt
         4pOIeS2UQcoq/s449vvQIGYWh3qSlPRmdpY1vQmpMaEObWooTlrNiYD9bUwY+lPUkorm
         hLBzesMiiO/NoXIyDV+IvtQ4AsLkrB+4AV5RrNxPVDyOOYUMhcwEIgwtaRsaopaPHeo2
         LBjzVIxN4sWG7W67d1bAZQ1rvQ9jys+7ZPFSEWtnSxXxCllslhTfXl5H81w+7LkGnsw3
         Mnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779530445; x=1780135245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xxjht8o5lHBtZXinwsyLwVfPVqsT5iwZdFL6CQMq5sA=;
        b=ntltey7kS+Elg7G+Mw2+9bLUGGKeFoXMQysi1f9wtfBQcx4VhAVZ+VUAwqgYbiXic+
         UyrTRXM/pvbrmuhzEs7THHcLvSUWZZV/IqX7tFjNrU3nF3KftA7ONPRW//ZSULWXDv1s
         Lu/Fv6f+dtc5OqUMU+y4mYWADES1N16aQOQczS08xrld5+QL8FtfUzUM/g5uQx9t2S9L
         lal4YmeWa//RyRShRgubIf8GvqCZc82+sSbf4O9t45azBTa2i+qUnIJT3fYui0c+3Mdt
         R3dklnzW7RhCRUQ5hfAnxBZ7Rh9xwDmyjImLQb7vbrQCvHlQV+Uu6gqTQW0csK1itNYH
         +dDw==
X-Gm-Message-State: AOJu0Yx9yKnDJb7WKC+HmvNHHfTOqBGFrOMD5hOQoBmowhxi1w2rVafb
	HwLRv9Y/GamyGfU/7ubqbRS0jl098+JKvtRDgyyeY3+cb5CdfpqF6Ohl
X-Gm-Gg: Acq92OE4Dd0Z52FYimMlUobK6AOvKliBoNi24L88ApAJOZAcd3GH3lR9Xo5H0edhQ0o
	16f1SvCapsm9E7oygSWJK4dH+kmPNOURQktQgna8WlgoKdHuFtiVa13e/156Kt2uuE5RLUYcKQy
	9jj7xMgJ5cCBTVCkn7n+7Y2TAF3VYOVidP+C9oQhhQv2BVE1N3W4lBiE5Om6REylplTC9uIJoh+
	8B8fgEaBq/5x8IIqhJ/sOjO8Pd288aG5vbH2hkzaJCKQevUBZ4E8bFY+mSim8alUKAJ5wzqjwYS
	6nLq/3yeYlSto89ByTvx5MlaygUQiAv3MH/nT8jyCrCte85kBDLHb826fcqAtDS0yCRZDm07oom
	8j3q7lk89a/NzIsUczuKPsVrsUXMcf28pzoTNLJk/wVokxyDu3q0K9MqJFqPf9vle2pQ+gPUsFD
	khkRkgKcmT7Fk/Kdqtyv83Ygj5T6DnSSD9UK9iFlbCdQ==
X-Received: by 2002:a05:600c:4ecc:b0:48f:e249:4094 with SMTP id 5b1f17b1804b1-490426d4bf0mr107351975e9.18.1779530444922;
        Sat, 23 May 2026 03:00:44 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904526c926sm173882015e9.1.2026.05.23.03.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 03:00:44 -0700 (PDT)
Message-ID: <c8a23c39-b13b-4f89-9967-35d8195d4e2d@gmail.com>
Date: Sat, 23 May 2026 12:00:43 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EVL] Client UDP not receiving data
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <6f9e6ff2-95a7-402c-90d6-19f0f89bbc80@gmail.com>
 <87v7chf5xm.fsf@xenomai.org> <327a363e-6b79-45b2-a5b0-6b9f8a82d756@gmail.com>
 <87y0hbe9kw.fsf@xenomai.org> <19e440ba-bb7a-47ba-a1a9-bb72eb83badd@gmail.com>
 <87tsryo6sv.fsf@xenomai.org>
Content-Language: de-CH
From: Hannes Diethelm <hannes.diethelm@gmail.com>
In-Reply-To: <87tsryo6sv.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 23.05.26 um 10:42 schrieb Philippe Gerum:
> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
> 
>> Am 22.05.26 um 17:40 schrieb Philippe Gerum:
>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>
>>>>
>>>> Thanks for the detailed answer. I might have been not precise enough.
>>>>
>>>> The -S and the -R mode work as designed. To show the issue with connect() in evl, I changed
>>>> the -S mode to:
>>>> connect()
>>>> while{
>>>>     oob_sendmsg()
>>>>     oob_recvmsg()
>>>> }
>>>>
>>>> This is the classical UDP client pattern. It works with vanilla linux (net-udp.c)
>>>> but not with evl (oob-net-udp.c), I do not receive any data.
>>>>
>>>> By just sending the modified code, it is easy to explain and hopefully for you to
>>>> reproduce. This is also why I attached the files instead of sending a patch.
>>>> Be aware that this is just to demonstrate what is not working, not intended as a patch.
>>>>
>>>> I run Xenomai4 in a VM and communicate with the host for debugging
>>>> but I have also a real PC as the final target where I have the same issues.
>>>>
>>>> First start on the host:
>>>> echo Hello | nc -u -l 5201
>>>>
>>>> Then in the VM:
>>>> sudo evl net -ei enp7s0
>>>> sudo oob-net-udp -d -i enp7s0 -a 192.168.122.1 -p 5201 -S
>>>>
>>>> On the host:
>>>> Mellow sword!
>>>>
>>>> In the VM:
>>>> == bound to enp7s0
>>>> == sender mode (=> 192.168.122.1:5201)
>>>> --------tx--------
>>>> IP-Adresse: 192.168.122.1
>>>> Port:       5201
>>>> Family:     512
>>>> --------rx--------
>>>> IP-Adresse: 192.168.122.155
>>>> Port:       58422
>>>> Family:     512
>>>>
>>>> The package is visible in wireshark but oob_recvmsg does not return:
>>>> No "= 6 bytes received: Hello" and no second transmit.
>>> Ok, I totally misinterpreted your previous post, sorry for
>>> that. Brain received -ENOCOFFEE.
>>>
>>>>
>>>> It looks like the auto assigned and bound port from connect() is not forwarded
>>>> to the oob stage, so no data is received in oob_recvmsg().
>>>>
>>> This is exactly the point, indeed. Could you please try this branch
>>> [1]?
>>> The two commits on top improve the situation with your test code here.
>> Thanks for the very fast fix. Connect works now as expected. And I was able to remove the workaround.
>>
>> I switched to libevl r58, r57 did not work any more. Is there any visible link libevl->kernel? I just
>> got an operation not permitted in oob_sleep_until.
>>
> 
> Recent evl ABI updates are likely causing this, r58 is required to run
> any kernel with ABI #44. Every single change affecting the ABI also used
> to cause its revision number to be incremented, hence the seemingly high
> value (implementing the evl core started back in 2018). The model has
> recently switched to bulk updates instead, i.e. a series of ABI updates
> under a single revision.
> 
> On the kernel side, the file include/uapi/evl/control-abi.h tracks the
> base/earliest and current ABI revisions the evl core supports, such
> decoupling helps in providing backward compatibility from the latter to
> the former, e.g. if EVL_ABI_BASE is 30 and EVL_ABI_LEVEL is 45, then an
> application which was compiled against any ABI level >= 30 can use this
> core. Looking at include/evl/version.h in libevl, you should see the
> symbol EVL_ABI_PREREQ set to the earliest ABI revision that particular
> version of libevl can work with, i.e. matched to EVL_ABI_BASE.
> 
> A recent string of ABI changes went in to support the upcoming POSIX
> interface, they have been grouped in a single update which triggered ABI
> #44. That one was going to break backward compat as I hinted at a couple
> of months ago, aligning EVL_ABI_BASE on EVL_ABI_LEVEL to #44.
> 
> The development tip for each kernel is now hosted in some next/* branch
> in the repo, e.g. next/v6.12.y-cip-evl-rebase, which contains staging
> code until it moves to the rebase/ branch,
> e.g. v6.12.y-cip-evl-rebase. The next/* kernel branches match the libevl
> -next branch ABI-wise.
> 
> IOW, in order to work with the bleeding-edge code implementing any
> recently discussed changes, you may want to switch to libevl/next and
> any next/* branch on the kernel side (v6.12.y-cip-evl, v6.18.y-evl, or
> v7.0-evl ATM).
> 

Thanks for the details. For now, libevl r58 works well with next kernel but I will go to next on both
repos if I see any issues and test it there also before reporting them.
The inegrated check works if I go back to r57 with a small test program:
evl: ABI mismatch, see -ENOEXEC at https://v4.xenomai.org/core/user-api/init/#evl_init
./oob-net-udp: cannot attach to the EVL core: Exec format error

I think I just had so many error messages that I did not see ^ in the real application.

>> But there are two new issues:
>>
>> -oob_sendmsg returns "Invalid argument" errno 22 exactly every second. The last number is the
>> system time in ns.
>> ERROR: oob_sendmsg Invalid argument 22 806999652287
>> ERROR: oob_sendmsg Invalid argument 22 807999655503
>> ERROR: oob_sendmsg Invalid argument 22 808999650416
>>
>> I have this with the exact same code as before using bind() and also with the now working connect().
>> There are 3000 tx / 1000 rx packages/s.
>>
>> I tried do{oob_sendmsg}while(errno == 22) but that resulted in a full freeze of the PC.
>>
> 
> Sounds like an ABI issue, I cannot reproduce this. Switching to the
> 'next' branches on both sides may help.

This was an -ENOCOFFEE on my side. I was using:
evl_read_clock(EVL_CLOCK_MONOTONIC, &ts_timeout);
ts_timeout.tv_nsec += 1000*1000;
...
oob_sendmsg(board->sockfd, &msghdr, &ts_timeout, flags);

Of course this overflows tv_nsec exactly every second. It seams you or some else verifyes this now
and return "Invalid argument".

With this, everything works now:
evl_read_clock(EVL_CLOCK_MONOTONIC, &ts_timeout);
ts_timeout.tv_nsec += 1000*1000;
while(ts_timeout.tv_nsec >= 1000000000){
     ts_timeout.tv_nsec -= 1000000000;
     ts_timeout.tv_sec ++;
}
...
oob_sendmsg(board->sockfd, &msghdr, &ts_timeout, flags);

> 
>> -The last commit a4cc7967 on the next branch doesn't compile. Just FYI, I took one commit before, so I was able to test it.
>>
> 
> My bad, fixed in the kernel next/* branch.
> 
>>>>
>>> I think we need a simple agent somewhere in the evl netstack in
>>> kernel
>>> space answering ICMP_ECHO requests flowing in oob channels directly,
>>> just like the in-band stack does for in-band traffic. I can look into
>>> this.
>> The oob-net-ping sends out pings, so basically the inverse of the existing oob-net-icmp. Now you can run
>> oob-net-ping on one machine and oob-net-icmp on the other to ping between. For my application, I use it to ping an FPGA
>> board to see if the connection basically works.
>>
> 
> Ok, makes sense too. I'm ok with both approaches actually, it's your call.
> 
>> ICMP_ECHO would help in some cases, but ^ works also.
>>
> 
> Agreed, we need a built-in ICMP_ECHO responder in the core, which we
> could disable programmatically as well, so that a ping service
> implemented in userland which would use the raw packet interface may
> switch it off for receiving ICMP requests.
> 
Ok, I will send a patch as soon as it is ready. Can take some time, depending on what is going on otherwhise.
