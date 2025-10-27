Received: from crocodile.elm.relay.mailchannels.net (crocodile.elm.relay.mailchannels.net [23.83.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E673223324
	for <xenomai@lists.linux.dev>; Mon, 27 Oct 2025 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761589011; cv=pass; b=Qra+1zIrbcy56nG4wWD0MnK+0Bdp0UIqLohIkwlmbVLmNAsiNfs5+Vvd+OSxV3/1USfxWTHf7rSX+D7IVmdEN3fLSAxi82W2vXWs7ovCrmDh3TNVujfj57mAwm48KUkwpFXh0UnQIMsYshEXc16I7aBmxOXeWzdoPfaDpVGPx0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761589011; c=relaxed/simple;
	bh=UnPogP87/NcvLB9lu52GzxhzwuRMY09xjkU5v7V9fVk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QNYO0mjvWV0x2PgHbgK7eFJm4kr6E3avYZO6hpvPXQ5pGFhtEnZQPkM4vHvDhUIVq51vYyvaPwjyL6R5dNZbHxpDWR8pPOESwKAvcydRdLdyDfkHJUTXDjEZlQPl6gC35+FwowTVr1mL/8h6FPUVh4HaE9yiAiiFBJ5POr61byM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=VEclk77t; arc=pass smtp.client-ip=23.83.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="VEclk77t"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 152EE7C277A;
	Mon, 27 Oct 2025 18:16:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a230.dreamhost.com (100-117-123-159.trex-nlb.outbound.svc.cluster.local [100.117.123.159])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 55CBA7C20FE;
	Mon, 27 Oct 2025 18:16:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1761589001; a=rsa-sha256;
	cv=none;
	b=VsO6wd1Pinm+W/zh1dj/v0I1/Kv8fXAs/HBfyObQxkdPMWHFa5125W36QkDwis7b6sQmYH
	a3694zwP+pW7UQ3nvn7hcKRng0BBJTZ0EoKr+36NQeFXfUr63hOEdO1Q0QLfcTiM75Weha
	p2253NRWxkAZ9NVuaGaNmYQKX1ftbUnL7gGaBnyg2LYvOIof09Il505eHgvnG6v032Pugu
	+yYmp6iLIqH9YD7yDRnpaBv8nGKT+M6NzufI85rFukzvlKvxdFrZvOpwj8OunsYXiRKrIk
	iVpsxBYTo3xclHns7lGQEk+i323egMfTWf4/n929MaCbr0+2tstvPsnv52BugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1761589001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=r1bSSCtVYypnb5zPoiHebR+R+YbEanOcE1yoyaCTWeY=;
	b=aF2kbCkUYn1vcR3VNENQ+uhKubENApWvL/uwpnUejwf7B172E+fexKxdM+BntJmwvhlpyc
	ai+Bi7J90G+roIIbOb97BUNf1iQ0nx7MoD5t/iDBFbrKPpFXfW6zBqQbn4TunL2O7tiuF3
	XbCJocZkDGWgTlzNlX31TkDUalhbl/d0A6k84EA4gMkNJ7qtY3+ib2sAH4oN7/65FF+WqN
	h/Zcx82w4RpNUnCw+oxRfQS7mkjEcLdE6hMyfTgryplltMGzTvmyIGCtAfC9gk26/qSV0K
	mUAC7qg6cUwXgEYhkVPu3ojHDvJMMsKts2hOe/RkvMXcVjCz3kn3T7JlbI9wgQ==
ARC-Authentication-Results: i=1;
	rspamd-9799b5d46-bs6rj;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Cooperative-Glossy: 4a4cc64f44c06c4f_1761589001654_1273390798
X-MC-Loop-Signature: 1761589001654:1336436136
X-MC-Ingress-Time: 1761589001653
Received: from pdx1-sub0-mail-a230.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.123.159 (trex/7.1.3);
	Mon, 27 Oct 2025 18:16:41 +0000
Received: from giulios-MacBook-Pro.local (unknown [186.170.47.63])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a230.dreamhost.com (Postfix) with ESMTPSA id 4cwMCX57N0z21;
	Mon, 27 Oct 2025 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1761589001;
	bh=r1bSSCtVYypnb5zPoiHebR+R+YbEanOcE1yoyaCTWeY=;
	h=Subject:To:Cc:From:Date:Content-Type:Content-Transfer-Encoding;
	b=VEclk77tY89wVecAgHn/8TwjMli4WwWNLTyAe9CUVMrXlzcEtufGQZKyuWZXm99+H
	 XDknrG0ZReNu75rT7Ip34BFcdZTh8bkTcAox4/igG7E7KW23H2g03NAjbXYB8CEh4w
	 EZqfNjwXCweP3Kp/6Aak9xICM6fQxbxSssFvLLs8aKTSDhJdbaCQN2VnOfpYfMZ12A
	 xh1gNHuQtmzEeaBtg/RBXTKcwINQBMaEJDBDsJLgrIPBduTXlSDINg4lcAtg6aLvzU
	 lSIZCnZIOQACRKQlu4TxV8KneHm/hZwcME61Aqa8X2ld6tkP1g97qZ2qbps6NUxNrM
	 WE+VhGr99sDvg==
Subject: Re: Unexpected switches to in-band
To: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@nabladev.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
 <20251009151737.0d03b211@wsk> <20676160-4572-d92d-4b33-ff4255946345@bela.io>
 <87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
 <f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io> <20251020094705.2ac256f2@wsk>
 <9d2bacac-8d70-f083-e926-21beee2207c2@bela.io> <87o6q1ad07.fsf@xenomai.org>
 <20251023155439.0170f987@wsk> <87a51djuor.fsf@xenomai.org>
 <20251027120535.7933c720@wsk> <20251027172505.29eecfb2@wsk>
From: Giulio Moro <giulio@bela.io>
Message-ID: <70047565-fb8c-e402-eb04-0aed403b3b12@bela.io>
Date: Mon, 27 Oct 2025 13:16:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251027172505.29eecfb2@wsk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Sorry for my late response, here are my logs:

files.bela.io/Xenomai4-ISW-trace-6.12-logs-2.txt

this is the kernel in use (with committed .config): https://github.com/giuliomoro/linux/tree/v6.12.y-evl-rebase

Best,
Giulio

Łukasz Majewski wrote on 27/10/2025 11:25:
> Hi Philippe,
> 
>>> so either some
>>> traces are missing,
>>
>> I will check if I can add more tracing.
> 
> On one console:
> ---------------
> evl trace -eirq -f; sleep 1; latmus -c 2 -p 1000 -P 99
> 
> 
> On the second one:
> ------------------
> test_prog/stress_prog_NO_IO &
> sleep 5
> test_prog/stress_prog_NO_IO &
> 
> echo 0 > /sys/kernel/tracing/tracing_on
> evl trace -p > Xenomai4-ISW-trace-6.6-logs.txt
> 
> First trace:
> ############
> 
> The relevant dmesg output:
> 
> [   75.214527] EVL: timer-responder:743 switching in-band [pid=745,
> excpt=14, user_pc=0x77d08492a5fe]
> 
> When I do look into logs - there is also a "hole" when the ISW is
> reported by dmesg.
> 
> 
> However, there are some hints when we look around evl_latmus:
> 
> timer-responder-745     [002] d.~2.    75.868139: evl_latspot: **
> latency peak: 18843.649 us **
> 
> On CPU 20:
> stress_prog_NO_-752     [020] ...2.    75.868139: folio_add_lru_vma
> <-__handle_mm_fault
> 
> Which ends with folio_add_lru()...
> And after that we do have the ~18ms latency peak.
> 
> And the "folio_*" is a relatively new feature added to Linux kernel [1].
> 
> The logs can be fetched from:
> https://nextcloud.swupdate.org/index.php/s/EjHo5EAwMTeY5ya
> 
> 
> Second trace [*]:
> #################
> 
> 
> [ 1610.086961] EVL: timer-responder:768 switching in-band [pid=770,
> excpt=14, user_pc=0x72e9d35af5fe]
> 
> <idle>-0 [008] *..1.  1610.076068: rcu_dyntick: Start 1 0 0x2ec
> <idle>-0 [003] *.~1.  1610.102242: rcu_dyntick: Endirq 0 1 0x404
> <idle>-0 [003] *.~2.  1610.102242: arch_handle_irq <-arch_pipeline_entry
> <idle>-0 [003] *.~2.  1610.102242: irq_to_desc <-arch_handle_irq
> <idle>-0 [003] *.~1.  1610.102242: ma_read: mtree_load
> 	Node: 00000000c4071949 (0 18446744073709551615) range: 4355-4355
> <idle>-0 [003] *.~2.  1610.102242: rcu_oob_prepare_lock <-mtree_load
> <idle>-0 [003] *.~2.  1610.102242: __rcu_read_lock <-mtree_load
> <idle>-0 [003] *.~2.  1610.102242: __rcu_read_unlock <-mtree_load
> 
> 
> Now some questions:
> 1. Why '~' (i.e. oob stage) is on CPU=3 as we pinpointed execution
>     of the 'latmus' to CPU=2 (and the command line has isolcpu=2) ?
> 
> 2. The mtree_load() is called in the OOB context... IMHO, this shall be
> done before we do start the latmus?
> 
> 3. In this case - there is also a "hole" between the ISW time
> (1610.086961) and the ones between rcu_dyntick: Start / Endirq
> 
> 
> Link to the full log:
> https://nextcloud.swupdate.org/index.php/s/nPRAnqCLFDibX6r
> 
> 
> Note:
> [*] - All ftrace options enabled in the kernel
> 
> 
> Links:
> [1] -
> https://github.com/torvalds/linux/commit/49f8275c7d92?spm=a2c65.11461447.0.0.68003853Pbec3R
> 
