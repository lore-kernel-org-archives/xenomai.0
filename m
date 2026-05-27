Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B56361668
	for <xenomai@lists.linux.dev>; Wed, 27 May 2026 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779908678; cv=none; b=ST8neuFTPcDI2RDM1I8XyPhCSAkmy6eWHthJIcS8x3n9U1k9fd5GiqhM2uAeehBxTkWVx3z3APv5+TJMYzynHd8gm5vkYR8k0huInTgbYjlTNjSg5DSbR61Tf0wt2Ml1AJHB8btp0dFolrxe8MsDRWoGIPU1P2+3zAtsIMKnaBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779908678; c=relaxed/simple;
	bh=Y5/kbTmsLwyePG+W0LfvSDFXvJ58Pz5SL4rgVqeRDzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A9W/Pzy3m/ckwYIyxMXgV1NMuWsEAz3kDb+soc9ed3w84houALKWC7A65qv8oF/jNcVVrdq4r1w6u0fup0gQFpelNudVLzVi4sPW/1pnziI3ak6NFYDWv9kTm9bPL7LvyUdLpTqS+swyDqRCAA95lvtuAAlSe4TskKmi+r9SfkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=EWDrS3W2; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="EWDrS3W2"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 180B53ECA5;
	Wed, 27 May 2026 19:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1779908668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Z+Lxz+OW9gVcRQ5v/Cra1+J1EwcFD8d5aMcCPbbrPM=;
	b=EWDrS3W2dIGhsNaU8/I/CoRvinRUH+XdBZghB+StAs7l0SOAf8HAdfat096upLpdgJ8Xtz
	FLCsdJgQDyVZ5BoKD2hdr8eHlceMD5s+tcbjmqTW0TTMhXQvd3Wdj/AdE3n1kCC7M8EeoX
	b00vR6o17z+i1tXEP4jFyiDJrhG56nAo4eh3QgmgCf7RCSqEgAFyyDA8GslROEJZhb+6kv
	4puOTLUPFrLIAmMwhIVJpBdoGeezPi8M241uVW3MsGwQnA3mCg9H50rGSNOOhiBUG11XJt
	msOfcMUwyUKfYHZ8Ko8pXCb9K1HJSXnDyEDqx2Afvzug3UyUVLYqmvFjHYfZ5w==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] tidbits: net-udp: add server and client mode
In-Reply-To: <34f6ff16-6e68-4529-9fa7-d9fbe99b46ad@gmail.com> (Hannes
	Diethelm's message of "Wed, 27 May 2026 17:12:22 +0200")
References: <20260523201044.12938-1-hannes.diethelm@gmail.com>
	<87cxyjph49.fsf@xenomai.org>
	<05e115e3-6dcb-4eba-8cf9-3510f0891621@gmail.com>
	<34f6ff16-6e68-4529-9fa7-d9fbe99b46ad@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 27 May 2026 21:04:27 +0200
Message-ID: <87bje0hdxg.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFIr3mH2JEEQ5QP0Sxbkzpe/5y5Kej7S5RVYoCqVdfEBYfLpEgpJxMntli45NtmEsj3Hl29Eg0vpxfZl6cCrrrV9XzTgcMVp1N775k/xQr+MQny05on0WiA7szrGAuHksnSX67RIGpwEx6asuoxihkCgZ7ZWVlBTt0YPz0mVJrSR22ASvrlzXrtJpgm/y1FkaYkAcdTQdM0Y8jEuYXLbLP/vR9Eo2tUV0OmeC9J9eDcBW/V7jbqRXsm+BWVo+7ItgakTRDJpuY5N44E3AmWeOU3/nbgrWWn7JABR/0SG0dpiTfyu29WYpiXj0yeVlf8j6vXYhRqB50QqTlb43HevfQcsEP9zfPZwJkMlcvzX0rxzzGJ85q3/IygJkioErEKHzwbvnwrH/jy2thQ4FPFHEKrsB0tyOycN3KufJzu4ADuF4GaMjxZU7NBdW1iERaWtGzyPxJa9PYIs/kHZiCcYBazSSrz64ItVEaBxIGLoNgNwR0LnuJzfqAPtqgeFB8K2iuyiFsJpJzO47a+94epredSRuzXEB7giaSk+cHLdTr52UtZXf+jm983K6sfAXdVz4wSJy3XTO8mISKW/bHBVxv6iK4YMtGBMSBGpVR+huc0jWuhjnnhGx9tOfY3qyZDafe6nB/1YuMf7vBu+WXxnvs25RmzgfFfZ4SocLelhg+C8Q

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Am 25.05.26 um 23:02 schrieb Hannes Diethelm:
>> Am 25.05.26 um 18:51 schrieb Philippe Gerum:
>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>
>>>> Additionally, fix memory leaks
>>>>
>>>> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
>>>> ---
>>>> =C2=A0 tidbits/oob-net-udp.c | 258 +++++++++++++++++++++++++++++++++++=
++++---
>>>> =C2=A0 1 file changed, 240 insertions(+), 18 deletions(-)
>>>>
>>>
>>> Merged, thanks. Would you mind sending a patch to update the related doc
>>> on the website at [1], regarding the new -S mode? The pages can be
>>> downloaded from [2].
>>>
>>> [1] https://v4.xenomai.org/core/net/udp-demo/index.html
>>> [2] https://gitlab.com/Xenomai/xenomai4/website.git
>>>
>> Sure, done. Is there any way to preview the website? I just used a
>> markdown
>> preview, I hope it did the job and I did not introduce format issues.
>> By the way:
>> I had sometimes issues in my VM. It might just be that I am using two
>> interfaces on the same subnet and disabled the non-oob one after
>> enabling the oob mode on the other one or there might also be an issue
>> somewhere in the evl code. I am not yet able to reproduce it clearly.
>> Sometimes it is all fine, sometimes not. Until now, it did not happen on
>> the real PC or in loopback mode. But I also don't have a good setup
>> with two
>> PC's to really test this (yet). I will follow up when I have
>> something reproducible.
>> If it went wrong, the following happened. After a reboot, all was
>> fine again:
>> In client mode, the sender address was from the wrong interface:
>> 192.168.255.245 instead of 192.168.122.155
>> In server mode, the sender address was just 0.0.0.0.
>> In both cases, there is no answer from the other side due to the
>> response was sent
>> to the wrong IP address.
>> I think the issue is not in my code, due to when I use the standard
>> libc functions
>> in otherwise the same code, the issue disappeared. Attached the code
>> I was using
>> for tests and also on the host to test server/client.
>> Regards
>> Hannes
>
> So, I was able to create something reproducible. I was a bit confused fir=
st
> due to sometimes it worked, sometimes not. But this was my fault, not
> rebooting before the test and not exactly using the same commands in the =
same order.
>
> All command blocks below where performed after a reboot.
>
> I have two network interfaces:
> enp1s0: virtio
> enp7s0: e1000e
>
> After boot:
> enp1s0: 192.168.122.246 nm 255.255.255.0
> enp7s0: No address
>
> First Scenario-------------------
>
> The client works fine:
> dhclient enp7s0 # 192.168.122.155 nm 255.255.255.0
> ifconfig enp1s0 down
> evl net -ei enp7s0
> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -C -p 5201 -m "Client"
>
> The server sometimes fails:
> dhclient enp7s0 # 192.168.122.155 nm 255.255.255.0
> ifconfig enp1s0 down
> evl net -ei enp7s0
> ./oob-net-udp -d -i enp7s0 -a 0.0.0.0 -S -p 5201 -m "Server"
>
> There is sometimes the error:
> oob-net-udp: oob_sendmsg() failed: Operation now in progress
> This goes away after a few tries and then it works afterwards.
>
> If I bind to the interface address instead of INADDR_ANY, same issue:
> ./oob-net-udp -d -i enp7s0 -a 192.168.122.155 -S -p 5201 -m "Server"
>
> Second Scenario-------------------
>
> Here, I do not set an IP address for enp7s0. This was a mistake on my sid=
e. Disregard,
> more careful testing showed the exact same behavior for posix / vanilla k=
ernel. But it is
> important for the third scenario.
>
> ifconfig enp1s0 down
> ifconfig enp7s0 up
> evl net -ei enp7s0
> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501
>
> Here, the sender address shown in wireshark is 192.168.122.246. This is t=
he address from enp1s0
> that is disabled. Exactly the same for posix / debian kernel.
>
> ifconfig:
> enp7s0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>         inet6 fe80::5054:ff:fe5a:79c5  prefixlen 64  scopeid 0x20<link>
>         ether 52:54:00:5a:79:c5  txqueuelen 1000  (Ethernet)
>         RX packets 15  bytes 960 (960.0 B)
>         RX errors 28  dropped 0  overruns 0  frame 28
>         TX packets 30  bytes 3332 (3.2 KiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>         device interrupt 22  memory 0xfdc40000-fdc60000
>
> lo: flags=3D73<UP,LOOPBACK,RUNNING>  mtu 65536
>         inet 127.0.0.1  netmask 255.0.0.0
>         inet6 ::1  prefixlen 128  scopeid 0x10<host>
>         loop  txqueuelen 1000  (Lokale Schleife)
>         RX packets 28  bytes 2672 (2.6 KiB)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 28  bytes 2672 (2.6 KiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>
> Third scenario------------------
>
> Setting an IP address after evl net -ei and the first package sent doesn'=
t work. It looks like
> the info is copied once and not updated later, also not when disabled and=
 enabled
> again.
>
> The following does not work:
> ifconfig enp1s0 down
> ifconfig enp7s0 up 192.168.122.100
> evl net -ei enp7s0
> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Fine, sender add=
ress is 192.168.122.100
> evl net -di enp7s0
> ifconfig enp7s0 192.168.122.110
> evl net -ei enp7s0
> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Sender address i=
s still 192.168.122.100, should be 192.168.122.110
>
> This works:
> ifconfig enp1s0 down
> ifconfig enp7s0 up
> evl net -ei enp7s0
> ifconfig enp7s0 192.168.122.155
> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Fine, the sender=
 address is 192.168.122.155
>
> This also doesn't work and created the confusion:
> ifconfig enp1s0 down
> ifconfig enp7s0 up
> evl net -ei enp7s0
> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Same behavior as=
 in second scenario, sender address is 192.168.122.246
> ifconfig enp7s0 192.168.122.155 #Note, setting the IP address is after th=
e first package sent
> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Same behavior as=
 in second scenario, sender address is 192.168.122.246
> evl net -di enp7s0
> evl net -ei enp7s0
> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Same behavior as=
 in second scenario, sender address is 192.168.122.246
> evl net -di enp7s0
> ifconfig enp7s0 192.168.122.155
> evl net -ei enp7s0
> ./oob-net-udp -d -i enp7s0 -a 192.168.122.1 -T -p 2501 # Same behavior as=
 in second scenario, sender address is 192.168.122.246
>
> Can you reproduce this? It is of now importance for what I am using EVL f=
or. I just discovered this while testing the server / client mode.
> So no urgency from my side.
>

I did not try to reproduce it yet, but reading this description, I would
most certainly see the same outcome. I believe this is all related to
the so-called "oob front caches" for ARP and IPv4 routing decisions EVL
maintains [1].

In light of that doc, what is most likely happening is:

- the EINPROGRESS status is EVL telling the caller that it could not
  resolve either the dest ip using its route cache or the MAC address of
  the destination in its ARP cache, so it had to relay the packet to the
  in-band stage for transmit. IOW, the packet is outgoing, but the
  end-to-end real-time guarantee you would have if the NIC driver was
  oob-capable is lost for this particular transmit.

  As the in-band stack does the proper resolution for that relayed
  packet eventually, recording the results into its own neighbour and
  routing tables, it also conveniently pass this information to some
  dovetail hooks which EVL listens to, and therefore learns from,
  feeding its front caches with it. This usually happens quickly after
  the in-band transmit happens, but some delay may appear due to the
  time required to receive an ARP reply message from a peer for
  instance. This is what might make the behavior look slightly flaky at
  times from a user perspective.

  The way to make this deterministic (therefore without transient
  EINPROGRESS error on first transmit) is by using explicit peer
  solicitation as discussed in [2].

- the bad sender address of the 3rd scenario may be a variant of this
  bug, with the added trick that it should only happen with
  unconnected/unbound sockets, in which case the source address is
  retrieved from the routing record matching the destination address. In
  this case, the routing record found in the EVL front cache is obsolete
  since the transmitting device changed its (prefix) address. So it
  looks like some flushing of those obsolete records is missing on
  changing the address with an active oob port..

  If I'm right, you should be able to work around this issue by flushing
  the EVL route cache after the netdev update and before transmitting,
  as follows:
       # echo 1 > /sys/class/evl/net/ipv4_routes
  Obviously, this is not that nice, and the netstack should behave and
  do this automatically. Will fix.
=20
[1] https://v4.xenomai.org/core/net/index.html#evl-output-routing
[2] https://v4.xenomai.org/core/net/index.html#evl-peer-solicitation

--=20
Philippe.
