Received: from dormouse.ash.relay.mailchannels.net (dormouse.ash.relay.mailchannels.net [23.83.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC3A3EBF2F
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771289170; cv=pass; b=pMmC8TItsY9LGtd3QRXdjqcOsEAcxoFrzUhXI7a1VGKeMF5lZDKbjc57rTPW1CUSn9CVZsVG3hNhEdQgzpFnHzMOBFDoTk04bmvEv/2OKUFkobwbn5JNGanrKpJOmGrGTWjTrkcW5mnAPJGvuwNjTIVvvnofYPsddlHk81Y3r1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771289170; c=relaxed/simple;
	bh=hgDeq2PcuI9Dxm2jjIs9I00EofJEC9GaJE5WRZYCaXc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=i4V9SYRD9MqBCpr9Ol9VmNp3bHpUj8pInrK30I0lb0k2fzNNtB8Y23ikdSbae9ogxpmeQRdHVKcv9oJfZHMKH6dVhsk6WCSpZgQQmIsTApN2U4GG2cLNK3pYYBwyFsB2D+Zg4TLNr3WGgMN1Q3UL2aNX7P78UmbLv0iNokrsMzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=LtH8qTAc; arc=pass smtp.client-ip=23.83.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="LtH8qTAc"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 218C746198B;
	Tue, 17 Feb 2026 00:27:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a255.dreamhost.com (100-103-37-48.trex-nlb.outbound.svc.cluster.local [100.103.37.48])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A527A4615D3;
	Tue, 17 Feb 2026 00:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771288061;
	b=XX4zln98J6PAY6jH43qM7mKcuJhFTLB2vi+boiHb57VtobLxBI1E5GB5kaGZIICnBGY9cr
	/YVEuJpZP6JncK0BPKIrnFPnwllx4YxCCe/oFvNEG+0y2TMoDTW2r2TWWcdTmFWj/YXlLM
	jF5UmPgsOjszN89MtqZe1S2ivPi6k0J1Wpc7rA4Q7SJikakBQPgNLy5U5peD66XNohCFU6
	eAMdVLKNkeNFBZ68t2zU8DNtr5xtNZCvg9E4Sl6d9gcWckoG9t0zMHLjkWABYn/lmxzuHN
	CSeaHlhNsncsqeF/kx3IHx02v5ORzDZq2Wtgkd7pPLiaPcEakgyVcyYU52/pCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771288061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JSdhHBLFwIlqkciDuXEkUaG4XH7IyOrZrMXOv7Gs+js=;
	b=XnPi6O54bN4BRL5Eu/NqZacF0IbRwdtihojbivJOBbap2QOCYzze6b4joSBsCx8yulbNeb
	N1CcPiA9hNl0oa52e+fGHGUhxi9tm2fLGNfHLud3x11fDYZWs666A4j1EIqPMef/9peF9K
	ggdDW35UKo2JcrKH4o8iXhuiz6SlCKcnxeMrLt6m+SUB0P3n/V4Ym/fDCZwlJeN8HlSeaT
	iMneCThGLdryP1KDvxe/EIX2XxFiKJwJ19WMyPJ0uAemo8F0WpTRQHYKbrXiUPLjDWaY63
	2REbKwrG76KcQHeoCWmpGIjKlbFA/JcvP+OQvw1KSibFLXVPClQhbFeH6O5ulw==
ARC-Authentication-Results: i=1;
	rspamd-845545c4df-rbxj8;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Hook-Shrill: 32b120a363970927_1771288061996_2919425043
X-MC-Loop-Signature: 1771288061996:3048489731
X-MC-Ingress-Time: 1771288061996
Received: from pdx1-sub0-mail-a255.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.37.48 (trex/7.1.3);
	Tue, 17 Feb 2026 00:27:41 +0000
Received: from giulios-MacBook-Pro.local (unknown [186.112.184.216])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a255.dreamhost.com (Postfix) with ESMTPSA id 4fFL7w6j07z1054;
	Mon, 16 Feb 2026 16:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1771288061;
	bh=JSdhHBLFwIlqkciDuXEkUaG4XH7IyOrZrMXOv7Gs+js=;
	h=Subject:To:Cc:From:Date:Content-Type:Content-Transfer-Encoding;
	b=LtH8qTAcIkVn9JG6KsXMolM4YIPYrbBhRrme5V9F3J223BzoRTOPlY1uWPJUOdz7d
	 g2YolPssgkPlP2XjSenjYOJjAyRz0HkegOHvPU41XMMhoGrTk2nVd9qNj74AIVduQQ
	 DOwRKecMs14OHjX2FcKqRYv8X+1HvzdyZ9lyguy1iSwygPxwbepFiXyGJCDT6VvGZE
	 /qsjKYjwNYxeyaBoJLwh2xxULSQGKsEx8JH3X9l/ihBWhF33a0jP+0biyHSe41P/Vh
	 MDCTHw+ZD4SJveEnbN5pefKUqnEA7FF4RfhpjGx40zq9wyi6QhFNaOprU1gar37QYL
	 P1PN6H0SfZNqA==
Subject: Re: cobalt-like pthread wrappers for evl
To: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <8c539987-12ba-912d-f50a-cdaccc2cb7e6@bela.io>
 <7a955d849a7ec9245543c399ec9673d98ee4d5a3.camel@siemens.com>
 <873434k9vp.fsf@xenomai.org>
From: Giulio Moro <giulio@bela.io>
Message-ID: <9463458e-f214-5793-38cd-f6775de0f52b@bela.io>
Date: Mon, 16 Feb 2026 19:27:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.8; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <873434k9vp.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks all,
today I implemented the functions I needed immediately (not many at all: mostly pthread_mutex and pthread_cond stuff, then pthread_create and) as a shared library and it seems to work so far. I reused pieces of xenomai-3 (macros and the wrappers.c file) and I have some very inelegant statically allocated maps to map user-supplied "pthread" pointers to evl objects. Note that nothing pthread is actually called for mutex and conds: the user-provided pointers are simply used as keys in the maps. Also, this assumes that evl_init() is called somewhere else before the application starts calling into these functions.

Here it is for those interested: https://github.com/giuliomoro/wrappers

It seems to be mostly working for me, but it's half day's work with half hour testing, so it comes without any warranties. Looking forward to the proper upstream solution.

Best,
Giulio

Philippe Gerum wrote on 13/02/2026 09:15:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> 
>> Hi Giulio,
>>
>> [ Cc + Philippe ]
>>
>> On Thu, 2026-02-12 at 22:33 -0500, Giulio Moro wrote:
>>> Hi there,
>>> I have to port a large-ish C application to EVL. The application uses pthread_mutex, pthread_cond etc. Porting it to Xenomai-3 was straightforward, thanks to libcobalt and linker wrapping.
>>>
>>> Is there anything similar to that currently available for EVL? Maybe someone's half-tested branch stashed somewhere? Much appreciate any pointers that will save me from starting from scratch.
>>
>> That topic is most likely stuck in the design phase. Maybe Philippe can
>> comment on the current state. The topic was discussed a few times in the
>> past but never got traction.
>>
>> Maybe it's time to revive this topic.
>>
> 
> POSIX support for evl is indeed brewing in the design phase, which -
> good news - is about to be complete. This is not going to be a wrapper
> over libevl services, but a full-fledged interface - involving a
> dedicated kernel driver calling into the evl core - because we want the
> resulting API to comply with the standard.
> 
> e.g. the standard states that timeout specs passed to some POSIX
> services may not be accessed until such service actually wants to block
> the caller. libevl is at odds with this behavior, since it
> unconditionally accesses the timespec struct on entry to the call. The
> same way, the evl core immediately accesses the uniform timespec
> prepared by libevl. Also, libevl shares objects between processes by
> opening /dev/evl/* devices, while POSIX relies on shared memory for the
> most part. Those kind of things.
> 
> So, yes there is going to be a POSIX interface for evl, and this is on
> top of my (xenomai) todo list to work on it. However, this won't be
> done overnight as you can imagine.
> 
> PS: there used to be the opposite wrapper at some point in libevl
> called the evl-shim, implementing the evl API over POSIX.
> 
