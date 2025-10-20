Received: from dog.birch.relay.mailchannels.net (dog.birch.relay.mailchannels.net [23.83.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B665D257422
	for <xenomai@lists.linux.dev>; Mon, 20 Oct 2025 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964379; cv=pass; b=ja9QRsNFYJxjl4p+fQSxFlqOU7j9rJqzfCeiq3r+AVFP+mRLteZDvjkfdCbdqhxaO+/My37BwY61KWO4upKDVd7+QxyEaCqYT5sx19qr/7kTdJ9IAhuwfa7NX4kHQaRODzPxvQZOFkbrpiX6xGgE99XdVnC/xhfjV//Q6AkvO5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964379; c=relaxed/simple;
	bh=H6Dgcs/aH0XY6CobBojTX0sBb8HZxuT9vWT77vkw7Bo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JE9INBeN2/uBFTTODRFvIfZn7Vp5agQ7lzRbvSbAU8OVXkWpEh8qZ4z8PpAaCfGYv6OFMY3KSuf+pbCPrIQjLiSftPPDVUgWgjjVMifV4UA4QjU6ThJvDflChgyf0Bp/fo4/UhZ/y5QEXtgHH0GGG/HjcjO9Z5Vj1qDEnK7ohyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=BxDXSERK; arc=pass smtp.client-ip=23.83.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="BxDXSERK"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6E2258E04CB;
	Mon, 20 Oct 2025 12:46:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.119.74.21])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 023228E1B93;
	Mon, 20 Oct 2025 12:46:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1760964375; a=rsa-sha256;
	cv=none;
	b=M7Jz8hkPGco8V3Gf5uuY75N8lXTaIGv6nw10UFk+Je3bXr/cYUb2mMpZNi08ZtLBFu3Cwc
	qsXvw9VBT44y2x4B+6CzpOnX4GuXrK9P3aw051NawaFj2GpiQ1xKftSY9QSABclqtX3NmA
	fbD54GiFKQB/qJm21+WJ8EUf0dP0YxMhBamS/6Sfo3DuHaYj/uh09QeaLy/hPEaljcEa9b
	qVq2NJNSuOCDHrUpV149lyBWHyjZl0sNfNnnnOMTYq9zJVbAtPnHQuQzfK09J53xwgaxVV
	y1lU1iH5lgiwcmdobiL4k1GLvJSO4O0I4QIs3iecF1YYhhnFubZSxUwU1z0EGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1760964375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=H6Dgcs/aH0XY6CobBojTX0sBb8HZxuT9vWT77vkw7Bo=;
	b=YqJpKb7qwuMa/rk43gc8gpKZtJUFZqT4h3ytpo4euivwHQlVUPrGpBVYr3jml0W8Fh2+vw
	S3+ZBBxgzEdtv9IhZac3sucxLjbt5Tnf8J7DlNmIhM2jD+OsXr5kRIui2H9kvI3GVFACV2
	5P2+wkyuTdY4styRdInJWTP3XDFiavYNXqNnV3zCYkg39vzt9hxVYPskddul3clCqUaFVc
	S6FRtIL62qaBimVRG+uPMMc+NIAltWUoie1vBw71kdUhWGSAtyy58cy1za6CoBTmQfywxf
	NyqJ2Gb+9uvah79LdtmcrgotMShfw/gXOeKBWzLXZb5DtIRiYnoHzgr11zcWWg==
ARC-Authentication-Results: i=1;
	rspamd-6c854d7645-dmgkf;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Supply-Coil: 24b6ea23285cc67d_1760964375324_1735253024
X-MC-Loop-Signature: 1760964375324:1489576096
X-MC-Ingress-Time: 1760964375324
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.119.74.21 (trex/7.1.3);
	Mon, 20 Oct 2025 12:46:15 +0000
Received: from giulios-MacBook-Pro.local (unknown [186.99.132.214])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4cqwCS1dvQzFY;
	Mon, 20 Oct 2025 05:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1760964372;
	bh=H6Dgcs/aH0XY6CobBojTX0sBb8HZxuT9vWT77vkw7Bo=;
	h=Subject:To:Cc:From:Date:Content-Type:Content-Transfer-Encoding;
	b=BxDXSERKAKB+I4lluOVp0lUQhbO9YfoAygzRGDUMBAtT/KEv0G3djweYOPeR+9dVJ
	 pdfJ5ZZCd2Ezlr+DdTK5umudJgs9VQrQLgJNbsVRsDXnKLHy7Q5dxkpx0dpf5F40vh
	 OSVjkOrP1lqGeUkLhDUd3GYwIhVDtlTH+5vDLyuRI+9ijPn+sL0VjgXqyEr1CXQe6h
	 KUrzrMSK2hC1C+Yqqox6NGyzeh31KoLnaA7GOZ4vE7ZJP3onaB6/cDPu8sC6mrbVeD
	 H+Va6va0LF0tat3WMdt7VW5b6TbH+wTiWnfRHeLRMewkr3xg2JMm/a661WOaLxu8XB
	 19MSimEqn35jw==
Subject: Re: Unexpected switches to in-band
To: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@nabladev.com>
Cc: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
 <20251009151737.0d03b211@wsk> <20676160-4572-d92d-4b33-ff4255946345@bela.io>
 <87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
 <f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io> <20251020094705.2ac256f2@wsk>
From: Giulio Moro <giulio@bela.io>
Message-ID: <9d2bacac-8d70-f083-e926-21beee2207c2@bela.io>
Date: Mon, 20 Oct 2025 07:46:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251020094705.2ac256f2@wsk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Łukasz Majewski wrote on 20/10/2025 02:47:

> Could you share which version of libevl do you use?

I was using the latest release of libevl that was compatible with the kernel UAPI.
Sorry I haven't provided more details on the issue; I am focusing on building an image around 6.1 for a deadline coming up next month so I haven't been able to get into tracing yet.

The only additional finding I have so far is that there seems to be something on the Linux side that "breaks real-time" which affects both linux and evl. In the below list, "evl bad" means that the above mentioned ISW are observed. "Linux bad" means that I see a disproportionate number of underruns under stress on a Linux program running with SCHED_FIFO and priority 95 with a period of 360us. I understand "disproportionate" is a very subjective term but, to give an idea, over a 10 minutes test I get a couple of underruns with "linux good" and I get hundreds of underruns with "linux good"

v6.12.y-evl-rebase: evl bad, linux bad
v6.11.y-evl-rebase: evl bad, linux untested
v6.10.y-evl-rebase: evl bad, linux untested
v6.9.y-evl-rebase: evl bad, linux bad
v6.6.y-evl-rebase: evl bad, linux bad
v6.3.y-evl-rebase: evl bad, linux bad on startup only
v6.2.y-evl-rebase: libevl r42, evl good, linux good
v6.1.y-cip-evl-rebase: libevl master, evl good, linux good

Not sure if this is of any help; I hope to be able to get back on this soon.
Best,
Giulio
