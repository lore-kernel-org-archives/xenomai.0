Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7010317143
	for <xenomai@lists.linux.dev>; Wed, 27 May 2026 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912190; cv=none; b=E0hSiAlRGmlXvIKNVdC2HOk89OnzSoeeYiSaBMDxcrC9KhWyEabPbn1Spt9yNEoNaQES2qhYM/TNNzD+eRroHKDmUteBTYTYdcXhmFwozScFvVFexZ+t7nBaXzbGM/FKX/tFAJjqjUirwRdgx+qOjQaof2MPOfwxPBBPplx5Cdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912190; c=relaxed/simple;
	bh=6OMxFKm0gPSUKbj1wE5SCV2c07cd+aRcnywe0GQRVHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZwu0EGXdlei+ZUPB+CGEY+4YoxDNnfXUGecHLLMSBUeJCOR1ChRtInVXMszH/t/9hsRgrjBpKadUVmy24IpXFgTqah9Qf2r4Y7vmmbfQ99KTwy/F/SHtT7+IkASO+qSGz/GJpK7871oVssZuGrH49eTNLyCHBOtp2S++Gg0r2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koHBIknQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koHBIknQ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4905e190c71so44407435e9.3
        for <xenomai@lists.linux.dev>; Wed, 27 May 2026 13:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779912187; x=1780516987; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PAMfO5KNtSlNdxdaAX+b60YzRaVjIQPA93E42VeDcqU=;
        b=koHBIknQtHcCnQf7hFr66jrKiDtjoRCyKA2h943iTG5FWTRJhUyGNXEOLtmdt7Tom9
         DUxamoaicoMmLY/BQiz0Fr4Rx0pNDO+GP4FjeWZRkYeiEQsNbksh93BiFl19xsVylQig
         +nRlHfQeez4bStQ/khZnPgc9UsbSXrvwHMfiNGZVR88UO54lCX9/TAK0hBUjs1NZY9eQ
         j/TCovBRuvgH4Qg7HBmB+awTKyqGWbOcqSb5JNRUFG88KUmThIDNaS6cH0c34f/pgaQX
         XuGsnmHZyylcdSCiGqPCMb9L1Vhx73POxxaKgjAGeSixDII6dIaVDdsFLOStdr67JD5G
         lJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779912187; x=1780516987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAMfO5KNtSlNdxdaAX+b60YzRaVjIQPA93E42VeDcqU=;
        b=bjKNZAjIdwZvPcKPI3RkiCLWTJPajMpwS8cu4CrtypcwAiOKCclVvp8BaOjU0eT3QO
         jqLF1VEcyFu25o+fshVxExTrKDWH1y76rBzzLb30i+M6LlKPh2dXZxtSZbRd2MCdjh1Z
         IqoQ19gFNgokm5sEXSJJltU1l0pHNTNf5JHSyy7rHe1s7vv8WfWNhSDVowBotGF+B4xR
         8R0oXkoMS1JCDmKsyR+mvBNiTi/UsXRWiNXzkHLeZTzae3KntQfXeQD/x5FYLPwc0pcB
         VpTOKC3lJQSbO+TLFXrhgGSgPoj705yNLJlQJh+lZjHHs2gRQFuUTqImL97Zu0qUfi+U
         MmTA==
X-Gm-Message-State: AOJu0Yyq+CY6vU6zHellaTMPuAEkwHRVKYmUjR+qGQMWHES4md15jgZe
	NVft7TuAY2lzgeDPdSSrZfM0p22CyRy/c528EPkoBqcbGoOc+DQwKQH5ohvtsg==
X-Gm-Gg: Acq92OFU82Zxjxm5zTohTtCdZ7Ki4CfdcqNQen0e9KGBu8Bf3OIKaU7bjAo4vGLvDgh
	18+eT29bKdsd9M1t5Fsr07TpMDV5tlR7ZYbXWnVWkwqw8AsLYsaPtWHEEQHvBrplXpsA925ntgQ
	LT/AmRd2rTnks5J2wqEEpbUvxJ0VpNQulxe7GuvwWl2eB8VCXm6K2lwoZjFd0VXiWjRT2uZqfyZ
	6kgY6HPr4UztSPzOFgBQ4fW06a0Odb0aHemdScvLfcMp4IUyfXSW0Dew0CphRdzS76ZP5Uh9laz
	/2Q1beECMSU94k+AORGZ59l9QVROcUzEUyuh/0X8sSJX/A4PdunA+K64z9aUX7AtjPFJn79RTUN
	VQFA/IrRpndjnnCDSJRornl1zL/HkFHWGg8GykfI8JYMwz2vsXbgXXMnGeQb1BrCpcv7OatgOx0
	YMKR/Ue+onOCHV4ZriLV1gcm9NmqxUhZMrq/I7T4vf/Q==
X-Received: by 2002:a05:600d:640f:10b0:490:3ff5:737f with SMTP id 5b1f17b1804b1-490426cefe0mr300262135e9.18.1779912186757;
        Wed, 27 May 2026 13:03:06 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908b7a70b9sm2102645e9.12.2026.05.27.13.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 13:03:06 -0700 (PDT)
Message-ID: <47be7249-b249-4b2d-aa29-868d14412d0e@gmail.com>
Date: Wed, 27 May 2026 22:03:05 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tidbits: net-udp: add server and client mode
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20260523201044.12938-1-hannes.diethelm@gmail.com>
 <87cxyjph49.fsf@xenomai.org> <05e115e3-6dcb-4eba-8cf9-3510f0891621@gmail.com>
 <34f6ff16-6e68-4529-9fa7-d9fbe99b46ad@gmail.com> <87bje0hdxg.fsf@xenomai.org>
Content-Language: de-CH, en-US
From: Hannes Diethelm <hannes.diethelm@gmail.com>
In-Reply-To: <87bje0hdxg.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.05.26 um 21:04 schrieb Philippe Gerum:
> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
> 
>> Am 25.05.26 um 23:02 schrieb Hannes Diethelm:
>>> Am 25.05.26 um 18:51 schrieb Philippe Gerum:
>>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>>
>>>>> Additionally, fix memory leaks
>>>>>
>>>>> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
>>>>> ---
>>>>>    tidbits/oob-net-udp.c | 258 +++++++++++++++++++++++++++++++++++++++---
>>>>>    1 file changed, 240 insertions(+), 18 deletions(-)
>>>>>
>>>>
>>>> Merged, thanks. Would you mind sending a patch to update the related doc
>>>> on the website at [1], regarding the new -S mode? The pages can be
>>>> downloaded from [2].
>>>>
>>>> [1] https://v4.xenomai.org/core/net/udp-demo/index.html
>>>> [2] https://gitlab.com/Xenomai/xenomai4/website.git
>>>>
>>> Sure, done. Is there any way to preview the website? I just used a
>>> markdown
>>> preview, I hope it did the job and I did not introduce format issues.
>>> By the way:
>>> I had sometimes issues in my VM. It might just be that I am using two
>>> interfaces on the same subnet and disabled the non-oob one after
>>> enabling the oob mode on the other one or there might also be an issue
>>> somewhere in the evl code. I am not yet able to reproduce it clearly.
>>> Sometimes it is all fine, sometimes not. Until now, it did not happen on
>>> the real PC or in loopback mode. But I also don't have a good setup
>>> with two
>>> PC's to really test this (yet). I will follow up when I have
>>> something reproducible.
>>> If it went wrong, the following happened. After a reboot, all was
>>> fine again:
>>> In client mode, the sender address was from the wrong interface:
>>> 192.168.255.245 instead of 192.168.122.155
>>> In server mode, the sender address was just 0.0.0.0.
>>> In both cases, there is no answer from the other side due to the
>>> response was sent
>>> to the wrong IP address.
>>> I think the issue is not in my code, due to when I use the standard
>>> libc functions
>>> in otherwise the same code, the issue disappeared. Attached the code
>>> I was using
>>> for tests and also on the host to test server/client.
>>> Regards
>>> Hannes
>>
>> So, I was able to create something reproducible. I was a bit confused first
>> due to sometimes it worked, sometimes not. But this was my fault, not
>> rebooting before the test and not exactly using the same commands in the same order.
>>
>> All command blocks below where performed after a reboot.
>>
>> I have two network interfaces:
>> enp1s0: virtio
>> enp7s0: e1000e
>>
>> After boot:
>> enp1s0: 192.168.122.246 nm 255.255.255.0
>> enp7s0: No address
>>
>> First Scenario-------------------
>>
>> The client works fine:
>> dhclient enp7s0 # 192.168.122.155 nm 255.255.255.0
>> ifconfig enp1s0 down
>> evl net -ei enp7s0
>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -C -p 5201 -m "Client"
>>
>> The server sometimes fails:
>> dhclient enp7s0 # 192.168.122.155 nm 255.255.255.0
>> ifconfig enp1s0 down
>> evl net -ei enp7s0
>> ./oob-net-udp -d -i enp7s0 -a 0.0.0.0 -S -p 5201 -m "Server"
>>
>> There is sometimes the error:
>> oob-net-udp: oob_sendmsg() failed: Operation now in progress
>> This goes away after a few tries and then it works afterwards.
>>
>> If I bind to the interface address instead of INADDR_ANY, same issue:
>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.155 -S -p 5201 -m "Server"
>>
>> Second Scenario-------------------
>>
>> Here, I do not set an IP address for enp7s0. This was a mistake on my side. Disregard,
>> more careful testing showed the exact same behavior for posix / vanilla kernel. But it is
>> important for the third scenario.
>>
>> ifconfig enp1s0 down
>> ifconfig enp7s0 up
>> evl net -ei enp7s0
>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501
>>
>> Here, the sender address shown in wireshark is 192.168.122.246. This is the address from enp1s0
>> that is disabled. Exactly the same for posix / debian kernel.
>>
>> ifconfig:
>> enp7s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>>          inet6 fe80::5054:ff:fe5a:79c5  prefixlen 64  scopeid 0x20<link>
>>          ether 52:54:00:5a:79:c5  txqueuelen 1000  (Ethernet)
>>          RX packets 15  bytes 960 (960.0 B)
>>          RX errors 28  dropped 0  overruns 0  frame 28
>>          TX packets 30  bytes 3332 (3.2 KiB)
>>          TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>>          device interrupt 22  memory 0xfdc40000-fdc60000
>>
>> lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
>>          inet 127.0.0.1  netmask 255.0.0.0
>>          inet6 ::1  prefixlen 128  scopeid 0x10<host>
>>          loop  txqueuelen 1000  (Lokale Schleife)
>>          RX packets 28  bytes 2672 (2.6 KiB)
>>          RX errors 0  dropped 0  overruns 0  frame 0
>>          TX packets 28  bytes 2672 (2.6 KiB)
>>          TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>>
>> Third scenario------------------
>>
>> Setting an IP address after evl net -ei and the first package sent doesn't work. It looks like
>> the info is copied once and not updated later, also not when disabled and enabled
>> again.
>>
>> The following does not work:
>> ifconfig enp1s0 down
>> ifconfig enp7s0 up 192.168.122.100
>> evl net -ei enp7s0
>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Fine, sender address is 192.168.122.100
>> evl net -di enp7s0
>> ifconfig enp7s0 192.168.122.110
>> evl net -ei enp7s0
>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Sender address is still 192.168.122.100, should be 192.168.122.110
>>
>> This works:
>> ifconfig enp1s0 down
>> ifconfig enp7s0 up
>> evl net -ei enp7s0
>> ifconfig enp7s0 192.168.122.155
>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Fine, the sender address is 192.168.122.155
>>
>> This also doesn't work and created the confusion:
>> ifconfig enp1s0 down
>> ifconfig enp7s0 up
>> evl net -ei enp7s0
>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Same behavior as in second scenario, sender address is 192.168.122.246
>> ifconfig enp7s0 192.168.122.155 #Note, setting the IP address is after the first package sent
>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Same behavior as in second scenario, sender address is 192.168.122.246
>> evl net -di enp7s0
>> evl net -ei enp7s0
>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Same behavior as in second scenario, sender address is 192.168.122.246
>> evl net -di enp7s0
>> ifconfig enp7s0 192.168.122.155
>> evl net -ei enp7s0
>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Same behavior as in second scenario, sender address is 192.168.122.246
>>
>> Can you reproduce this? It is of now importance for what I am using EVL for. I just discovered this while testing the server / client mode.
>> So no urgency from my side.
>>
> 
> I did not try to reproduce it yet, but reading this description, I would
> most certainly see the same outcome. I believe this is all related to
> the so-called "oob front caches" for ARP and IPv4 routing decisions EVL
> maintains [1].
> 
> In light of that doc, what is most likely happening is:
> 
> - the EINPROGRESS status is EVL telling the caller that it could not
>    resolve either the dest ip using its route cache or the MAC address of
>    the destination in its ARP cache, so it had to relay the packet to the
>    in-band stage for transmit. IOW, the packet is outgoing, but the
>    end-to-end real-time guarantee you would have if the NIC driver was
>    oob-capable is lost for this particular transmit.
> 
>    As the in-band stack does the proper resolution for that relayed
>    packet eventually, recording the results into its own neighbour and
>    routing tables, it also conveniently pass this information to some
>    dovetail hooks which EVL listens to, and therefore learns from,
>    feeding its front caches with it. This usually happens quickly after
>    the in-band transmit happens, but some delay may appear due to the
>    time required to receive an ARP reply message from a peer for
>    instance. This is what might make the behavior look slightly flaky at
>    times from a user perspective.
> 
>    The way to make this deterministic (therefore without transient
>    EINPROGRESS error on first transmit) is by using explicit peer
>    solicitation as discussed in [2].
> 

Right, the server mode does not call evl_net_solicit(). I somehow expected duet to the remote packages is
received before, this information could be used directly, so no evl_net_solicit() is needed.

But by using the posix network implementation, I now see also an ARP request going out. So an evl_net_solicit()
is needed for each IP where a package is sent to for the first time. I will add this to the demo and send a patch.

Options:
1. Just be lazy and always call evl_net_solicit() -> If evl_net_solicit() does not takes to long if the ARP is already there, why not.
2. Internally manage a list of IP's where evl_net_solicit() was already performed, should be easy.
3. Is there a way to ask EVL if the ARP already done?

What do you think?

> - the bad sender address of the 3rd scenario may be a variant of this
>    bug, with the added trick that it should only happen with
>    unconnected/unbound sockets, in which case the source address is
>    retrieved from the routing record matching the destination address. In
>    this case, the routing record found in the EVL front cache is obsolete
>    since the transmitting device changed its (prefix) address. So it
>    looks like some flushing of those obsolete records is missing on
>    changing the address with an active oob port..
> 
>    If I'm right, you should be able to work around this issue by flushing
>    the EVL route cache after the netdev update and before transmitting,
>    as follows:
>         # echo 1 > /sys/class/evl/net/ipv4_routes
>    Obviously, this is not that nice, and the netstack should behave and
>    do this automatically. Will fix.

Thanks, this works. I looked trough [1] but it was not clear to me that this applies also to the sender IP.
ifconfig enp1s0 down
ifconfig enp7s0 up 192.168.122.100
evl net -ei enp7s0
./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Fine, sender address is 192.168.122.100
ifconfig enp7s0 192.168.122.110
echo 1 > /sys/class/evl/net/ipv4_flush_routes
./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Fine, sender address is 192.168.122.110

Notes:
[3] /sys/class/evl/net/arp is now probably /sys/class/evl/net/ipv4_flush_arp
[4] /sys/class/evl/net/ipv4_routes is now probably /sys/class/evl/net/ipv4_flush_routes

[3] https://v4.xenomai.org/core/net/index.html#evl-arp-cache
[4] https://v4.xenomai.org/core/net/index.html#evl-route-cache

>   
> [1] https://v4.xenomai.org/core/net/index.html#evl-output-routing
> [2] https://v4.xenomai.org/core/net/index.html#evl-peer-solicitation
> 

