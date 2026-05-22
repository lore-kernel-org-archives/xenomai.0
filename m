Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A647AF67
	for <xenomai@lists.linux.dev>; Fri, 22 May 2026 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464457; cv=none; b=nyeVIknUwq2ZsC253XuZ5B1rraKtqYTF/g2jRm0OKiBjTa4hthD6hUZCpw5h9PocSmGtsYV9C0ZkR6s+GvASgGQWmqQHzaSUW82hsVPzg5FLmz1fVmJX9UGZ8mWm73z7yrVCoeYezsYLyCFJ7K0lv3kHM8BVPTz4VmVqfYEMgAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464457; c=relaxed/simple;
	bh=JXHDvi+BPeBjqBRhwtEhbsrl7cF23IluvHh9WXH1Hkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IuWteaer5Q+kMO0zmWqShjcX3lheIUw069BdJNuwvRg/2+Xu6pQZn1JDbb4hJO85ZeLlqmmFJwgz3JQb3wBmcLN6IPEo46LG8xSTJwWshyMDpVei1rPVKV3TeZngr1GdbE+iHnCjV+VCSrCpE/rSy3bz0HVyVwQgMZiMQx5SQuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Mi0R5rzS; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Mi0R5rzS"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F0A92064D;
	Fri, 22 May 2026 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1779464452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+lb/xoG94NbhEbdsOhSKWSGbJ1K6ThDA0LzJ31huaog=;
	b=Mi0R5rzStCNgeYIdesgOX27H79/udvwiOB/PZwBr2rNd8gCyHRnvjecWdxJkb7vS2rgsR/
	mHUgydLS6BE4QOgg0SUG8aUjzJwUotBHo+cgsQT0Ry6SCllkjYcZt2o1oiODBMZiQrKFTX
	uVnwV84SelJ/HCa3uLcPTcJFrIApV/aC2A8kG2t28gR1buh13SoI4I7DiFjh4sB6yA3CuP
	Vhx3WWbwt+xVuGFWMmRbEwxO4K09Y+o++mQejbKbOFA32HbpZ9wX+VP63DGye62/6Z6P/w
	u089K4w/TIx21CU/lAbaoN9ln9puapBaHkJcNyFOiQ6skLIozc1kxNQZQNciMA==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [EVL] Client UDP not receiving data
In-Reply-To: <327a363e-6b79-45b2-a5b0-6b9f8a82d756@gmail.com> (Hannes
	Diethelm's message of "Thu, 21 May 2026 22:43:47 +0200")
References: <6f9e6ff2-95a7-402c-90d6-19f0f89bbc80@gmail.com>
	<87v7chf5xm.fsf@xenomai.org>
	<327a363e-6b79-45b2-a5b0-6b9f8a82d756@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 22 May 2026 17:40:47 +0200
Message-ID: <87y0hbe9kw.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGkoImEPsvYGvai5sF/H2kYPm83kH06g+s3dUsNnWdbk5D9t58rfM/Uxi+KDZ2T3OeJl+Mvk2vCf6EqRy+IWXpwm3ofFgJ/3qEDq7eEEYZh7zaF5h2ZcAxIVo5RfRNQS8yQuasWlcIlAekJLjUHntw+mvUuVgAHutvvmAkIvw6c0/TR75ZHJ/phdKH2LfrMSHEr0UmCTGJu14fqgqKoIwF8sObcJidkO4jrWD1XkAaqMtdsljwBjFMuWvReDZjC9QTDXG2fZJJW7iXe4mhGpBIrUHLYYM65/GgPZ3zvWcRhucOUXrlPDBwlJmlhBfYCJOE4fh1IuxQH9/JQuKvVEj9hhBp9UDfyV6+5kWI/qjKW125NsclNVmNc2LtiQuuouAlBGqlddWH7J2LG6DcQRnQXbscyseX0ACSGz6UtZMwIJuP13w7+HSv/XNtC6FqnxwQxJAUmf8Yq2YBEYy+fx+JPuOHGv0zHYJwFFHwUpZJkdTFF+8tzJYGvyUGFycHUTCN/Wo9cUGrJE1BglYP/ueU+243G0U20x3XpaX2VUXXVpjz0N3HyaqV/TalYh2ThYfmXsRWyTpmahG8vJ1PGLoeIvrpPoJo7tp+OT+AaWwQUuLGZuVetx4w9cL/jRttuL1b0JkKDhLxvyBvhAXF5m43Zfx+FL6oAnm5uF2Lcx4GLxA

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

>
> Thanks for the detailed answer. I might have been not precise enough.
>
> The -S and the -R mode work as designed. To show the issue with connect() in evl, I changed
> the -S mode to:
> connect()
> while{
>   oob_sendmsg()
>   oob_recvmsg()
> }
>
> This is the classical UDP client pattern. It works with vanilla linux (net-udp.c)
> but not with evl (oob-net-udp.c), I do not receive any data.
>
> By just sending the modified code, it is easy to explain and hopefully for you to
> reproduce. This is also why I attached the files instead of sending a patch.
> Be aware that this is just to demonstrate what is not working, not intended as a patch.
>
> I run Xenomai4 in a VM and communicate with the host for debugging
> but I have also a real PC as the final target where I have the same issues.
>
> First start on the host:
> echo Hello | nc -u -l 5201
>
> Then in the VM:
> sudo evl net -ei enp7s0
> sudo oob-net-udp -d -i enp7s0 -a 192.168.122.1 -p 5201 -S
>
> On the host:
> Mellow sword!
>
> In the VM:
> == bound to enp7s0
> == sender mode (=> 192.168.122.1:5201)
> --------tx--------
> IP-Adresse: 192.168.122.1
> Port:       5201
> Family:     512
> --------rx--------
> IP-Adresse: 192.168.122.155
> Port:       58422
> Family:     512
>
> The package is visible in wireshark but oob_recvmsg does not return:
> No "= 6 bytes received: Hello" and no second transmit.

Ok, I totally misinterpreted your previous post, sorry for
that. Brain received -ENOCOFFEE.

>
> It looks like the auto assigned and bound port from connect() is not forwarded
> to the oob stage, so no data is received in oob_recvmsg().
>

This is exactly the point, indeed. Could you please try this branch [1]?
The two commits on top improve the situation with your test code here.

>
> But might be evl was never intended to work using connect() in classical UDP client style?
>

IMO, the evl netstack (and evl in general) should follow the POLA
principle as closely as possible, and any UDP user can reasonably expect
auto-binding to be handled. So this needs fixing.

>
> If you think this this example is useful, I can finalize it (for now with the bind() workaround) and also add a server mode.
> So there would be 4 modes in total. With a server mode, you can run the server on one host, the client on the other and continuously
> send data forward / backward and measure delays. I would use:
> -T send (previously it was -S but then I have nothing for server)
> -R receive
> -S server: Waits for data and sends a response for each received package.
> -C client: Sends data and measures how long it takes for the server to response.
>
> As an alternative, I could just create a second example oob-net-udp-server-client.c. This would result in a bit of duplicated code but not to much.
>
> What do you prefer?

It is definitely useful. I would go for option #1, i.e. integrated
send/recv/server/client example. First because all the boilerplate and
ancillary support for parsing options and setting up connections is
already there and the code running the client scenario to be added is
likely small enough.

Next because the I'd rather have a 'client' mode measuring round-trip
times explicitly in the context of some example code, rather than
letting people think that we would actually provide a 'ping' command
that way. Reason is about performance: the standard in-band ICMP server
is operated from kernel context; although the latency would bite
compared to any oob-based server under high load, on average the figures
obtained on an idle system would be somewhat misleading compared to the
oob server in application space, because reinstating a userland context
for handling ICMP requests may be more time-consuming than handling it
directly as close as possible from the packet delivery point in kernel
space, i.e. without entailing any context switching to userland (even to
an oob thread).

>
> I also created oob-net-ping in the same style as oob-net-icmp but this sends out a ping, receives the response
> and measures the delay, similar as the ping command:
> ./oob-net-ping -i enp7s0 -a 192.168.122.1
> [0] count=98, proto=0x800, ifindex=3, type=0, halen=6, mac=52:54:00:6b:05:f1 rtt=317.1us
> [1] count=98, proto=0x800, ifindex=3, type=0, halen=6, mac=52:54:00:6b:05:f1 rtt=218.5us
> [2] count=98, proto=0x800, ifindex=3, type=0, halen=6, mac=52:54:00:6b:05:f1 rtt=252.5us
> [3] count=98, proto=0x800, ifindex=3, type=0, halen=6, mac=52:54:00:6b:05:f1 rtt=320.1us
> It has to be cleaned it up a bit and integrated it into the libevl repo but then I will also send a patch.
>

I think we need a simple agent somewhere in the evl netstack in kernel
space answering ICMP_ECHO requests flowing in oob channels directly,
just like the in-band stack does for in-band traffic. I can look into
this.

PS: thanks for the test code you provided, it saved a lot of time on my
end.

[1] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/tree/next/v6.12.y-cip-evl-rebase?ref_type=heads

-- 
Philippe.
