Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A07438399E
	for <xenomai@lists.linux.dev>; Mon,  1 Jun 2026 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302329; cv=none; b=GdhZ+GJvyrGnTBatneh5yTNwt0Ommlrj4A3JSCoMYt4Xa6PMo0aaO3OObJYzRxeBQda3FWovHv2HYNo1vzL1T2Dwm1eGhs72wz+9fpeNnxpNRyNQ1zbwzlwwuOOUElrKKpqFFs6s1nFm092SKn0TojPtf4fDEFh03573Zi+hlVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302329; c=relaxed/simple;
	bh=EXsRzm/AoYA3T3wDVtuuPJ8pj3Keb09gG3eQu5ksbHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=imvjjHv0/EgsqM0A+W4zxtpDe7yc48ri5mY5M0duSzpqXcB8v2GG4PKUg7GUAiXp6OpLfWtOSgdhZ7UsT+es1S8Kga+VtL2+73NAHEabxOk2uXPYTv+lF2SL1kuES1Ji1t6uZg8KJbgPbfG1cThPWRv2Gle/8XFkkLCMqw+KJq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=kzindX5l; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="kzindX5l"
Received: by mail.gandi.net (Postfix) with ESMTPSA id DDE5B3E970;
	Mon,  1 Jun 2026 08:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1780302317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bAQT1ESMly6JO1MQuhLZoUWNNBAlmLeAA4HM5s4G6go=;
	b=kzindX5l7nnHit5u4AOPg2aoJH+T4TRAOKCUGaAOHQZcGCk4oAfjoFUvusLypRUpqIVrI8
	ESQJJANaKL6l0XyhyOPW+rN3yXspZrG/iJmh7EtGYCGHzid7F7Pwc+zoACN+mICWNFtb7q
	Nxq3kkb9p+qR0AtASF7Soz7NeqDXzLpLCxJYqAB9QSJhMOF+mLF+6qUL3bTGfH0BBA0YDS
	x4vipvarPBHbHfcjhxnmEFiDnZw6tpXwUlndJRgRoSm0+gwtU5LyYg3sGqtOCQ3Y5vQtG7
	/FHMHYpIdx7Ppn41dKC7RNFFnpNSaSIs8Q/neSUgTm7or/UCD8dpRrfaLY4XeA==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] tidbits: net-udp: add server and client mode
In-Reply-To: <198c2263-bc2a-4fad-bcf2-7a6d60b77a94@gmail.com> (Hannes
	Diethelm's message of "Fri, 29 May 2026 23:53:25 +0200")
References: <20260523201044.12938-1-hannes.diethelm@gmail.com>
	<87cxyjph49.fsf@xenomai.org>
	<05e115e3-6dcb-4eba-8cf9-3510f0891621@gmail.com>
	<34f6ff16-6e68-4529-9fa7-d9fbe99b46ad@gmail.com>
	<87bje0hdxg.fsf@xenomai.org> <8733zaikfa.fsf@xenomai.org>
	<198c2263-bc2a-4fad-bcf2-7a6d60b77a94@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 01 Jun 2026 10:25:12 +0200
Message-ID: <87fr36651z.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGPypBVcRvkjUAXqS2kyIE3lweVAqfw2S0B5CLxrWk2fNuLmz4e3/QKfSYztDjkjPl1mqn9oNXnRJsDRkwnFSKvEJ3Igh09V9Xg3aBm+vWGqqmOYuhi06JGSz0DY5hE22lrl5iDHPM7oIek2U94E8YzO/12r4cpp99+FDuHM2XVbOwKO8uQ96k5HapFdgfMO0j8FI6H8lYMAzmnjXUUrbGfl+z/vgarPAKJr8Mdt9ks0vmum19BKUSRRgzCiS5JEWWekKN3qFzbXq+ZkOyPeoGJ4+uNKEvcOb7Exa4UDhjbI2I8fsj2ioSD4TKSPOdC3PZt0obh7y3kQVXrZMRVfxqKsVMvCu2JQSaWJnebVBqRhJOFzu+EUQ7i/WuN2hJBwKqkZ6DxidGHOBY+8Pxo+iIChT+KAq6RhOVOtX52rcgEmlgjD+8kGsRqVPnHsFcck9r5x2zEbHUtX+x2GB18QGPK2EmI7nRl2WcHEpmR4nVLVakbV+fQr1WhB54uIfLmqI54hUlGNG+JxnikgHZQAFKkgFvEhf9RvRIqn0xhPeB3jgy2xJOdJStvn1prqEJD2pU9YfN8sSqNF2REsKEDN2LwDhQ7pqwtv+azp5lzHEwfarVtCcPtGQ94qcGficbfjp2AzFK/VqwAbOmpnHvEJtuvu4jAS7bTNOf/8f2gQw9HYA

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Am 29.05.26 um 12:23 schrieb Philippe Gerum:
>> Philippe Gerum <rpm@xenomai.org> writes:
>>=20
>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>
>>>> Am 25.05.26 um 23:02 schrieb Hannes Diethelm:
>>>>> Am 25.05.26 um 18:51 schrieb Philippe Gerum:
>>>>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>>>>
>>>>>>> Additionally, fix memory leaks
>>>>>>>
>>>>>>> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
>>>>>>> ---
>>>>>>>  =C2=A0 tidbits/oob-net-udp.c | 258 +++++++++++++++++++++++++++++++=
++++++++---
>>>>>>>  =C2=A0 1 file changed, 240 insertions(+), 18 deletions(-)
>>>>>>>
>>>>>>
>>>>>> Merged, thanks. Would you mind sending a patch to update the related=
 doc
>>>>>> on the website at [1], regarding the new -S mode? The pages can be
>>>>>> downloaded from [2].
>>>>>>
>>>>>> [1] https://v4.xenomai.org/core/net/udp-demo/index.html
>>>>>> [2] https://gitlab.com/Xenomai/xenomai4/website.git
>>>>>>
>>>>> Sure, done. Is there any way to preview the website? I just used a
>>>>> markdown
>>>>> preview, I hope it did the job and I did not introduce format issues.
>>>>> By the way:
>>>>> I had sometimes issues in my VM. It might just be that I am using two
>>>>> interfaces on the same subnet and disabled the non-oob one after
>>>>> enabling the oob mode on the other one or there might also be an issue
>>>>> somewhere in the evl code. I am not yet able to reproduce it clearly.
>>>>> Sometimes it is all fine, sometimes not. Until now, it did not happen=
 on
>>>>> the real PC or in loopback mode. But I also don't have a good setup
>>>>> with two
>>>>> PC's to really test this (yet). I will follow up when I have
>>>>> something reproducible.
>>>>> If it went wrong, the following happened. After a reboot, all was
>>>>> fine again:
>>>>> In client mode, the sender address was from the wrong interface:
>>>>> 192.168.255.245 instead of 192.168.122.155
>>>>> In server mode, the sender address was just 0.0.0.0.
>>>>> In both cases, there is no answer from the other side due to the
>>>>> response was sent
>>>>> to the wrong IP address.
>>>>> I think the issue is not in my code, due to when I use the standard
>>>>> libc functions
>>>>> in otherwise the same code, the issue disappeared. Attached the code
>>>>> I was using
>>>>> for tests and also on the host to test server/client.
>>>>> Regards
>>>>> Hannes
>>>>
>>>> So, I was able to create something reproducible. I was a bit confused =
first
>>>> due to sometimes it worked, sometimes not. But this was my fault, not
>>>> rebooting before the test and not exactly using the same commands in t=
he same order.
>>>>
>>>> All command blocks below where performed after a reboot.
>>>>
>>>> I have two network interfaces:
>>>> enp1s0: virtio
>>>> enp7s0: e1000e
>>>>
>>>> After boot:
>>>> enp1s0: 192.168.122.246 nm 255.255.255.0
>>>> enp7s0: No address
>>>>
>>>> First Scenario-------------------
>>>>
>>>> The client works fine:
>>>> dhclient enp7s0 # 192.168.122.155 nm 255.255.255.0
>>>> ifconfig enp1s0 down
>>>> evl net -ei enp7s0
>>>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -C -p 5201 -m "Client"
>>>>
>>>> The server sometimes fails:
>>>> dhclient enp7s0 # 192.168.122.155 nm 255.255.255.0
>>>> ifconfig enp1s0 down
>>>> evl net -ei enp7s0
>>>> ./oob-net-udp -d -i enp7s0 -a 0.0.0.0 -S -p 5201 -m "Server"
>>>>
>>>> There is sometimes the error:
>>>> oob-net-udp: oob_sendmsg() failed: Operation now in progress
>>>> This goes away after a few tries and then it works afterwards.
>>>>
>>>> If I bind to the interface address instead of INADDR_ANY, same issue:
>>>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.155 -S -p 5201 -m "Server"
>>>>
>>>> Second Scenario-------------------
>>>>
>>>> Here, I do not set an IP address for enp7s0. This was a mistake on my =
side. Disregard,
>>>> more careful testing showed the exact same behavior for posix / vanill=
a kernel. But it is
>>>> important for the third scenario.
>>>>
>>>> ifconfig enp1s0 down
>>>> ifconfig enp7s0 up
>>>> evl net -ei enp7s0
>>>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501
>>>>
>>>> Here, the sender address shown in wireshark is 192.168.122.246. This i=
s the address from enp1s0
>>>> that is disabled. Exactly the same for posix / debian kernel.
>>>>
>>>> ifconfig:
>>>> enp7s0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>>>>          inet6 fe80::5054:ff:fe5a:79c5  prefixlen 64  scopeid 0x20<lin=
k>
>>>>          ether 52:54:00:5a:79:c5  txqueuelen 1000  (Ethernet)
>>>>          RX packets 15  bytes 960 (960.0 B)
>>>>          RX errors 28  dropped 0  overruns 0  frame 28
>>>>          TX packets 30  bytes 3332 (3.2 KiB)
>>>>          TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>>>>          device interrupt 22  memory 0xfdc40000-fdc60000
>>>>
>>>> lo: flags=3D73<UP,LOOPBACK,RUNNING>  mtu 65536
>>>>          inet 127.0.0.1  netmask 255.0.0.0
>>>>          inet6 ::1  prefixlen 128  scopeid 0x10<host>
>>>>          loop  txqueuelen 1000  (Lokale Schleife)
>>>>          RX packets 28  bytes 2672 (2.6 KiB)
>>>>          RX errors 0  dropped 0  overruns 0  frame 0
>>>>          TX packets 28  bytes 2672 (2.6 KiB)
>>>>          TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>>>>
>>>> Third scenario------------------
>>>>
>>>> Setting an IP address after evl net -ei and the first package sent doe=
sn't work. It looks like
>>>> the info is copied once and not updated later, also not when disabled =
and enabled
>>>> again.
>>>>
>>>> The following does not work:
>>>> ifconfig enp1s0 down
>>>> ifconfig enp7s0 up 192.168.122.100
>>>> evl net -ei enp7s0
>>>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Fine, sender =
address is 192.168.122.100
>>>> evl net -di enp7s0
>>>> ifconfig enp7s0 192.168.122.110
>>>> evl net -ei enp7s0
>>>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Sender addres=
s is still 192.168.122.100, should be 192.168.122.110
>>>>
>>>> This works:
>>>> ifconfig enp1s0 down
>>>> ifconfig enp7s0 up
>>>> evl net -ei enp7s0
>>>> ifconfig enp7s0 192.168.122.155
>>>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Fine, the sen=
der address is 192.168.122.155
>>>>
>>>> This also doesn't work and created the confusion:
>>>> ifconfig enp1s0 down
>>>> ifconfig enp7s0 up
>>>> evl net -ei enp7s0
>>>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Same behavior=
 as in second scenario, sender address is 192.168.122.246
>>>> ifconfig enp7s0 192.168.122.155 #Note, setting the IP address is after=
 the first package sent
>>>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Same behavior=
 as in second scenario, sender address is 192.168.122.246
>>>> evl net -di enp7s0
>>>> evl net -ei enp7s0
>>>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Same behavior=
 as in second scenario, sender address is 192.168.122.246
>>>> evl net -di enp7s0
>>>> ifconfig enp7s0 192.168.122.155
>>>> evl net -ei enp7s0
>>>> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Same behavior=
 as in second scenario, sender address is 192.168.122.246
>>>>
>>>> Can you reproduce this? It is of now importance for what I am using EV=
L for. I just discovered this while testing the server / client mode.
>>>> So no urgency from my side.
>>>>
>>>
>>> I did not try to reproduce it yet, but reading this description, I would
>>> most certainly see the same outcome. I believe this is all related to
>>> the so-called "oob front caches" for ARP and IPv4 routing decisions EVL
>>> maintains [1].
>>>
>>> In light of that doc, what is most likely happening is:
>>>
>>> - the EINPROGRESS status is EVL telling the caller that it could not
>>>    resolve either the dest ip using its route cache or the MAC address =
of
>>>    the destination in its ARP cache, so it had to relay the packet to t=
he
>>>    in-band stage for transmit. IOW, the packet is outgoing, but the
>>>    end-to-end real-time guarantee you would have if the NIC driver was
>>>    oob-capable is lost for this particular transmit.
>>>
>>>    As the in-band stack does the proper resolution for that relayed
>>>    packet eventually, recording the results into its own neighbour and
>>>    routing tables, it also conveniently pass this information to some
>>>    dovetail hooks which EVL listens to, and therefore learns from,
>>>    feeding its front caches with it. This usually happens quickly after
>>>    the in-band transmit happens, but some delay may appear due to the
>>>    time required to receive an ARP reply message from a peer for
>>>    instance. This is what might make the behavior look slightly flaky at
>>>    times from a user perspective.
>>>
>>>    The way to make this deterministic (therefore without transient
>>>    EINPROGRESS error on first transmit) is by using explicit peer
>>>    solicitation as discussed in [2].
>>>
>>> - the bad sender address of the 3rd scenario may be a variant of this
>>>    bug, with the added trick that it should only happen with
>>>    unconnected/unbound sockets, in which case the source address is
>>>    retrieved from the routing record matching the destination address. =
In
>>>    this case, the routing record found in the EVL front cache is obsole=
te
>>>    since the transmitting device changed its (prefix) address. So it
>>>    looks like some flushing of those obsolete records is missing on
>>>    changing the address with an active oob port..
>>>
>>>    If I'm right, you should be able to work around this issue by flushi=
ng
>>>    the EVL route cache after the netdev update and before transmitting,
>>>    as follows:
>>>         # echo 1 > /sys/class/evl/net/ipv4_routes
>>>    Obviously, this is not that nice, and the netstack should behave and
>>>    do this automatically. Will fix.
>>>
>> Done. The netstack now automatically purges obsolete records with
>> stale
>> source addresses from its cache upon removal of an IP address from a
>> device. Scenario 3 should behave as expected now.
>>=20
>
> Nice, I quickely tested it, it works well. No flush needed any more.

Good, merged upstream. Thanks for the feedback.

--=20
Philippe.
