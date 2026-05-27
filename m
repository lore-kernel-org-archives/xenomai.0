Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77504314B9A
	for <xenomai@lists.linux.dev>; Wed, 27 May 2026 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894748; cv=none; b=LyM1bWCuXPDfPGalOY66yW9jlSS6wc4CTFE2kL6Q1haGR8TXUakToG7OB25qAVWRYyp4PBh05Kyagub05zYduzp6H/zrWs4Jh4ik8umZbrfhqjrODjuqJIZN6Btcssq9HHjN1t5r+kTaRL5S+WrPNFFsM1X1M/jq3ERoFHerbec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894748; c=relaxed/simple;
	bh=n8ZpNzGN9gDTHC8hzDB+0MbE669msf7r36fanfw5PR0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CY5BQlG5DCe9eyBcsiW6iOKe2Kb3uUrEcgt3FEY3HVQIGSvFLaS3+x0BSf17m29cJEB9KTdSVbWcUpiXv9N0MABsOw7g0W/ApO8d36vVS0nU0n70gIwOoW4KT8oRhFfnqbQdYIWGUVluKu4AMdp+u5fiSa1RsrmVdMMM0SQvVu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noromCEH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noromCEH"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so124761315e9.0
        for <xenomai@lists.linux.dev>; Wed, 27 May 2026 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779894745; x=1780499545; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=09/fweCa2qvA7X6L+BVK8pKzq9K+KPfO220+d11Ssb0=;
        b=noromCEHT+2k5OUNybJPUMkwD2vWemUnE5yniS//RqePy32cL8IpBUJiJBXM+zCKuV
         LR+JuC6gZN5GXC4LSczj+8Wb+tQRBj3FVhvsAOXG6OVp9b7Px04ijSu1WP5bOM5B3jiD
         t29Z++dejYtLaLMdRTMKGYyS7Ieg48n1uxz4Sn2InpbT/RvTzELsgYp/BCKFwGvQSARb
         QtRZRPQVjb9kA7aAK28YYjIYLK9/vdHNF1UmilGg96LG5xLLZ1Rd2zXx7KUZjucLSP3Q
         dXs7X0n5HJN/b4GFBmbDI/wD1Z/L37zZlNAI9Y/rnLojG7VeLYNLumoaKQV8j1ICV+Id
         COsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779894745; x=1780499545;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09/fweCa2qvA7X6L+BVK8pKzq9K+KPfO220+d11Ssb0=;
        b=s2GGLUULvEwEuw9LHuQlqr2wpktwJ4NJ0Dt8fytOX3XjxSYNjf54oX0OMvCZYTfT+S
         Bx17bi3DKFyAJYTKyhwmC7Lcw7IQ0jNxKPoexTdvt1U9rfp0ExBx5zo5Vo5olQMF8enc
         E2yw92u9mowCNJhqMyyX+Ay3kgX80+8lRL7C4OnhCupfKU3WbU+Ha1e855SfXBlwJ9Yt
         gmB71/UpeQsi9E5JcRLbU2eGxFMw7meQYZmTiXrdeA8xHk6q8sqUb7MP6ZUlHbQrqqcw
         iyNnCecag0+ocDNEeVe7tOlEGmqiQJmmNuBD0VtRlZZ0ox2JrOxt3BgSTWZEMeciOv4U
         9aaA==
X-Gm-Message-State: AOJu0YwCt4ZrnWSdi+UtooD3eHcTT96GO+HlO/YsFOJW5s9fcX4+ANsZ
	1/X8E8fL6QQXItwmHJ1a8ZuPx2a1U9X73dcjb4HCBgY1twyz6tfsqbzE
X-Gm-Gg: Acq92OFRWtTP86aaLRfOD8jIjmS4Z6K5ufDk6hyQDH97i9ouJmaJzJpuN9EyPeXbKkq
	a3/jagcPNazEbfNslLoIa3CesM7nENt0xgqktEUIvPYOO7nTnNwdOdz1Yk278OvtveM07jco4ba
	UuQ9bDN1GtOUMvWoHjx0NkgpvA149I8T4xV3cLCf+H026afJCLiuXXXxazBNkkhIKGVSy1+F7v6
	9oNNlck/EYp7VQ6PI1Wvfthp+dNzSkoLT7Q8zH3wE0qu/ll45YMESGmgNBhdIf6tPj3dZMuUwhn
	TtjlWWEhL116c1CGYuDx5s8POhkFPmcIjyNQ7+yE1vvdPOHKRcpu+fQXc8vXrHhMUxQFEEQhbXE
	YBIkzas6HkSbXQbUcrPyXIhbh+ROsFtJ1nTQGzYTYaHuFRlKLSS4mrUYs2M8TbK8G+Qfwp/x5RU
	2iiuewyt8oHcp6hdHh/Z1SHvKFdzTzwJpSGJLvBX1o6w==
X-Received: by 2002:a05:600c:530c:b0:490:5527:3be2 with SMTP id 5b1f17b1804b1-49055273be6mr303069715e9.32.1779894744514;
        Wed, 27 May 2026 08:12:24 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908098f8c8sm18906105e9.15.2026.05.27.08.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 08:12:24 -0700 (PDT)
Message-ID: <34f6ff16-6e68-4529-9fa7-d9fbe99b46ad@gmail.com>
Date: Wed, 27 May 2026 17:12:22 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tidbits: net-udp: add server and client mode
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20260523201044.12938-1-hannes.diethelm@gmail.com>
 <87cxyjph49.fsf@xenomai.org> <05e115e3-6dcb-4eba-8cf9-3510f0891621@gmail.com>
Content-Language: de-CH, en-US
In-Reply-To: <05e115e3-6dcb-4eba-8cf9-3510f0891621@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.05.26 um 23:02 schrieb Hannes Diethelm:
> Am 25.05.26 um 18:51 schrieb Philippe Gerum:
>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>
>>> Additionally, fix memory leaks
>>>
>>> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
>>> ---
>>>   tidbits/oob-net-udp.c | 258 +++++++++++++++++++++++++++++++++++++++---
>>>   1 file changed, 240 insertions(+), 18 deletions(-)
>>>
>>
>> Merged, thanks. Would you mind sending a patch to update the related doc
>> on the website at [1], regarding the new -S mode? The pages can be
>> downloaded from [2].
>>
>> [1] https://v4.xenomai.org/core/net/udp-demo/index.html
>> [2] https://gitlab.com/Xenomai/xenomai4/website.git
>>
> 
> Sure, done. Is there any way to preview the website? I just used a markdown
> preview, I hope it did the job and I did not introduce format issues.
> 
> By the way:
> I had sometimes issues in my VM. It might just be that I am using two
> interfaces on the same subnet and disabled the non-oob one after
> enabling the oob mode on the other one or there might also be an issue
> somewhere in the evl code. I am not yet able to reproduce it clearly.
> Sometimes it is all fine, sometimes not. Until now, it did not happen on
> the real PC or in loopback mode. But I also don't have a good setup with 
> two
> PC's to really test this (yet). I will follow up when I have something 
> reproducible.
> 
> If it went wrong, the following happened. After a reboot, all was fine 
> again:
> In client mode, the sender address was from the wrong interface:
> 192.168.255.245 instead of 192.168.122.155
> 
> In server mode, the sender address was just 0.0.0.0.
> 
> In both cases, there is no answer from the other side due to the 
> response was sent
> to the wrong IP address.
> 
> I think the issue is not in my code, due to when I use the standard libc 
> functions
> in otherwise the same code, the issue disappeared. Attached the code I 
> was using
> for tests and also on the host to test server/client.
> 
> Regards
> Hannes

So, I was able to create something reproducible. I was a bit confused first
due to sometimes it worked, sometimes not. But this was my fault, not
rebooting before the test and not exactly using the same commands in the same order.

All command blocks below where performed after a reboot.

I have two network interfaces:
enp1s0: virtio
enp7s0: e1000e

After boot:
enp1s0: 192.168.122.246 nm 255.255.255.0
enp7s0: No address

First Scenario-------------------

The client works fine:
dhclient enp7s0 # 192.168.122.155 nm 255.255.255.0
ifconfig enp1s0 down
evl net -ei enp7s0
./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -C -p 5201 -m "Client"

The server sometimes fails:
dhclient enp7s0 # 192.168.122.155 nm 255.255.255.0
ifconfig enp1s0 down
evl net -ei enp7s0
./oob-net-udp -d -i enp7s0 -a 0.0.0.0 -S -p 5201 -m "Server"

There is sometimes the error:
oob-net-udp: oob_sendmsg() failed: Operation now in progress
This goes away after a few tries and then it works afterwards.

If I bind to the interface address instead of INADDR_ANY, same issue:
./oob-net-udp -d -i enp7s0 -a 192.168.122.155 -S -p 5201 -m "Server"

Second Scenario-------------------

Here, I do not set an IP address for enp7s0. This was a mistake on my side. Disregard,
more careful testing showed the exact same behavior for posix / vanilla kernel. But it is
important for the third scenario.

ifconfig enp1s0 down
ifconfig enp7s0 up
evl net -ei enp7s0
./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501

Here, the sender address shown in wireshark is 192.168.122.246. This is the address from enp1s0
that is disabled. Exactly the same for posix / debian kernel.

ifconfig:
enp7s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
         inet6 fe80::5054:ff:fe5a:79c5  prefixlen 64  scopeid 0x20<link>
         ether 52:54:00:5a:79:c5  txqueuelen 1000  (Ethernet)
         RX packets 15  bytes 960 (960.0 B)
         RX errors 28  dropped 0  overruns 0  frame 28
         TX packets 30  bytes 3332 (3.2 KiB)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
         device interrupt 22  memory 0xfdc40000-fdc60000

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
         inet 127.0.0.1  netmask 255.0.0.0
         inet6 ::1  prefixlen 128  scopeid 0x10<host>
         loop  txqueuelen 1000  (Lokale Schleife)
         RX packets 28  bytes 2672 (2.6 KiB)
         RX errors 0  dropped 0  overruns 0  frame 0
         TX packets 28  bytes 2672 (2.6 KiB)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

Third scenario------------------

Setting an IP address after evl net -ei and the first package sent doesn't work. It looks like
the info is copied once and not updated later, also not when disabled and enabled
again.

The following does not work:
ifconfig enp1s0 down
ifconfig enp7s0 up 192.168.122.100
evl net -ei enp7s0
./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Fine, sender address is 192.168.122.100
evl net -di enp7s0
ifconfig enp7s0 192.168.122.110
evl net -ei enp7s0
./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Sender address is still 192.168.122.100, should be 192.168.122.110

This works:
ifconfig enp1s0 down
ifconfig enp7s0 up
evl net -ei enp7s0
ifconfig enp7s0 192.168.122.155
./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Fine, the sender address is 192.168.122.155

This also doesn't work and created the confusion:
ifconfig enp1s0 down
ifconfig enp7s0 up
evl net -ei enp7s0
./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Same behavior as in second scenario, sender address is 192.168.122.246
ifconfig enp7s0 192.168.122.155 #Note, setting the IP address is after the first package sent
./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Same behavior as in second scenario, sender address is 192.168.122.246
evl net -di enp7s0
evl net -ei enp7s0
./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Same behavior as in second scenario, sender address is 192.168.122.246
evl net -di enp7s0
ifconfig enp7s0 192.168.122.155
evl net -ei enp7s0
./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Same behavior as in second scenario, sender address is 192.168.122.246

Can you reproduce this? It is of now importance for what I am using EVL for. I just discovered this while testing the server / client mode.
So no urgency from my side.

Regards
Hannes

