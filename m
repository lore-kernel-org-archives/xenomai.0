Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B64115C9
	for <xenomai@lists.linux.dev>; Tue,  9 Jul 2024 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=217.70.178.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720540294; cv=pass; b=CQ7U7mT70OfK1G8khTfrC5JzPVhLP2W/Q3ttf96wq18a1BU2o6p+XPK1CtqnyNk1ZQPLHK/q05tqvURvbvwTC3Sr0t4dWAdZ30al2Q42ORew9um3cZb0MQYLUZQfxvE/E6jSuR99vmreJPq+DXQjjsc5vLp77qwbb17EdfM3nZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720540294; c=relaxed/simple;
	bh=JhTiz6aHmDjLjjv/17AEY2k6Jd1iXJOXWFw1JWB5vW0=;
	h=Subject:From:To:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PNcT3peBdepaAIfReMpqmgSEa2DoG8WpVeDXWs6y874ig64mbO1g8u86jOIssr9x9JXZHej/X8ncN9OGL/hAM/kCOL2spQ0e/F9thyf2hDfnua6aavIcJtPfVfidEVp+wksD2uqoLZSoIZW54hedMdCCZ0OimHwSLd5BY7P+fuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bela.io; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=wOknB9O5; arc=pass smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="wOknB9O5"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id D9FB21A0008
	for <xenomai@lists.linux.dev>; Tue,  9 Jul 2024 15:51:28 +0000 (UTC)
Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	by spool.mail.gandi.net (Postfix) with ESMTPS id C889D94194A
	for <xenomai@xenomai.org>; Tue,  9 Jul 2024 15:51:22 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D8CD250331C
	for <xenomai@xenomai.org>; Tue,  9 Jul 2024 15:51:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a308.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 51C9150469A
	for <xenomai@xenomai.org>; Tue,  9 Jul 2024 15:51:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1720540280; a=rsa-sha256;
	cv=none;
	b=w4u3wZwh4MJFWd5pxZmOs2ed85apPmcdkDFoPahC11o3X8zukaDQCB2kI7imvtz8WXyOqH
	cNtUxOgau0o8RMaK7UjCSha2Kuwq6vKsA2+/4RGtDMb3nmRwopqLiiTY1TTw1srCsFNN6f
	4TIBP5+naCsnBh38MLR8ubXapnPI1iv447ds85/jCB7tpsTkd4Hh0RTDnQ/tsu1DjNcxuL
	zj2y6jm7rAYt0Qs8sfAQwJSZQ98VoQ/nNQQCzRXJ6fYlEZGBn8wV5kmlhslYLlbUdbVYvT
	Da6s2+Q4XGdhpM+fzp2Ck/YIyts4TMACnsB/AHV3y8dPJ1396yqSca3vRchbyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1720540280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sOxX13FMnf96S4hA3BA/JZRcO5XHs4cIT88cn8qsOmc=;
	b=13SM91O5XMwwJH5NmYgz9YanEt11xMKr+3kDeb+f7xjzKaEZK8IDvyNpmQoTXW5Tcvd0KV
	Gr7oKaUPV/xJhyZzDxW66n6F2hSA3YmIM8xOLQUuiBzkUlW2Ooz5b7QyaOU/i5b6WUTe/T
	QUd5a6jq0coRb7lcVIgY2L+PpePcrCxOA8j25Yn5I2JIbgX1OB+HCStnKW7H2ZruvtcO31
	pE9FeK3u0T1AcMTRG5mLpn590U3bUf24gNT1PhpZ/ZTr51szIXG9HFjr7AQHU/yNc30NCA
	k1PzK/T/c+w9SZ6PbKMmaWFS1uPyPsiwtK2vrXu5Wpiv51T7ypFJvUVltyp1kg==
ARC-Authentication-Results: i=1;
	rspamd-7c4f8cbcf8-bxxhs;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Madly-Tasty: 35b0f3ab2e4e2d74_1720540280586_1367620158
X-MC-Loop-Signature: 1720540280586:3105773712
X-MC-Ingress-Time: 1720540280585
Received: from pdx1-sub0-mail-a308.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.40.171 (trex/6.9.2);
	Tue, 09 Jul 2024 15:51:20 +0000
Received: from giulios-MacBook-Pro.local (unknown [186.99.138.208])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a308.dreamhost.com (Postfix) with ESMTPSA id 4WJQT36LZVz5x
	for <xenomai@xenomai.org>; Tue,  9 Jul 2024 08:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1720540280;
	bh=sOxX13FMnf96S4hA3BA/JZRcO5XHs4cIT88cn8qsOmc=;
	h=Subject:From:To:Date:Content-Type:Content-Transfer-Encoding;
	b=wOknB9O5OLdQEkJB82Hq/Ir94LL0DK7utYM5IxT/ptxFC6fUP/2cEUuOfHxuyswHO
	 qJxPT5rYEXJ5jEKuAPYW9EkrsUdNL78+Sn0JlWmXQpoxda//enI/KUXcP2x5yNovlg
	 7mFr+luIh59pRoz25kCHZiO8ExCRrXa1FF4DfVVd7VDKXI8iy2kck2jYGHXJWIG/SE
	 zaLTCX4dZVydftq07tK5Z6l7dKyLu8p3vE1rIfLB24nF/DBbhUKuUG7i56vpwYQe23
	 o1aMkc4zAnLBABwNv4RCLFGTHEy+cow4mRj2LT8GnKaBKvU+siT/2OcGxHUshEPx70
	 C/BrRup49hHfw==
Subject: Re: EVL documentations issues
From: Giulio Moro <giulio@bela.io>
To: xenomai@xenomai.org
References: <7e4de8bf-c42c-7592-ee44-022d0e75fb68@bela.io>
Message-ID: <15bb47c2-cc47-f576-5d5e-652c43b9d2da@bela.io>
Date: Tue, 9 Jul 2024 10:51:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:91.0)
 Gecko/20100101 Firefox/91.0 SeaMonkey/2.53.18
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7e4de8bf-c42c-7592-ee44-022d0e75fb68@bela.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=bela.io header.s=dreamhost header.b=wOknB9O5;
	dmarc=pass (policy=quarantine) header.from=bela.io;
	spf=pass (spool.mail.gandi.net: domain of giulio@bela.io designates 23.83.223.167 as permitted sender) smtp.mailfrom=giulio@bela.io

Giulio Moro wrote on 09/07/2024 10:45:>
> - there are several broken links. I found these with https://www.deadlinkchecker.com/ entering evlproject.org  as the starting page. I report the result  below for convenience, but the kast column "Source link text" is much more usable when viewed on the site as it is a clickable link to the page containing the broken link

Here's a better plain-text version of the broken link report from the same source.  Last column "Linked From"  is the page that contains the broken link

Error          	URL                                              	         Anchor Text	Linked From
404 Not Found	https://xenomai.org/documentation/xenomai-3/html/man1/latency/	Xenomai 3	https://evlproject.org/core/benchmarks/
404 Not Found	https://evlproject.org/core/benchmarks/(/core/runtime-settings/)	calibration settings	https://evlproject.org/core/benchmarks/
404 Not Found	https://docs.zephyrproject.org/latest/getting_started/installation_linux.html	Zephyr SDK	https://evlproject.org/core/benchmarks/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/revl/-/tags/0.4.0	0.4.0 [302 from https://git.xenomai.org/xenomai4/revl/-/tags/0.4.0]	https://evlproject.org/
404 Not Found	https://xenomai.org/documentation/xenomai-3/html/man1/latency/index.html	latency	https://evlproject.org/core/testing/
404 Not Found	https://xenomai.org/documentation/xenomai-3/html/man1/autotune/index.html	autotune	https://evlproject.org/core/testing/
404 Not Found	https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt__core.html	Cobalt core	https://evlproject.org/overview/
404 Not Found	https://evlproject.org/core/user-api/io/_index.html	oob_read()	https://evlproject.org/core/user-api/function_index/
404 Not Found	https://evlproject.org/core/user-api/flags/(/core/abi-revs/)	ABI 33	https://evlproject.org/core/user-api/flags/
404 Not Found	https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__rtdm.html	RTDM	https://evlproject.org/core/oob-drivers/
-1 Not found: The host name in the certificate is invalid or does not match	https://rtai.org/	RTAI [302 from http://rtai.org/]	https://evlproject.org/core/
404 Not Found	https://man7.org/linux/man-pages/man3/clock_nanosleep.3.html	clock_nanosleep(3) [301 from http://man7.org/linux/man-pages/man3/clock_nanosleep.3.html]	https://evlproject.org/core/user-api/clock/
404 Not Found	https://man7.org/linux/man-pages/man2/fcntl.2.html)	http://man7.org/linux/man-pages/man2/fcntl.2.html) [301 from http://man7.org/linux/man-pages/man2/fcntl.2.html)]	https://evlproject.org/core/user-api/poll/
404 Not Found	https://www.kernel.org/doc/html/latest/core-api/genericirq.html)	https://www.kernel.org/doc/html/latest/core-api/genericirq.html)	https://evlproject.org/core/kernel-api/interrupts/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/libevl/-/tags/r41	libevl r41 [302 from https://git.xenomai.org/xenomai4/libevl/-/tags/r41]	https://evlproject.org/core/user-api/api-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/7af18f8a38ad68f581cf770819ccb98c29f41586	20 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/7af18f8a38ad68f581cf770819ccb98c29f41586]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/41dc88ab524cd32878646d98b57d390e2bcc1198	26 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/41dc88ab524cd32878646d98b57d390e2bcc1198]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/libevl/-/tags/r40	r40 [302 from https://git.xenomai.org/xenomai4/libevl/-/tags/r40]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/87ee9586fa60	17 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/87ee9586fa60]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/231089ed6028	16 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/231089ed6028]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/6b8a2319c02d	15 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/6b8a2319c02d]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/3d4ff940c1d3	14 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/3d4ff940c1d3]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/a142e2e027dc	19 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/a142e2e027dc]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/b8351b703ffb	18 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/b8351b703ffb]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/b81555f4f48b	1 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/b81555f4f48b]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/cfab80b242c4	0 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/cfab80b242c4]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/f6f6e58cbaff	9 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/f6f6e58cbaff]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/9397204d7484	8 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/9397204d7484]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/c1a5ca6a70e7	7 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/c1a5ca6a70e7]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/bc92ac9d3b90	6 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/bc92ac9d3b90]	https://evlproject.org/core/abi-revs/
404 Not Found	http://nanopi.io/nanopi-neo.html/	AllWinner H3 (NanoPI NEO)	https://evlproject.org/ports/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/d9b664b5ecdb	5 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/d9b664b5ecdb]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/57ce409e23e6	4 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/57ce409e23e6]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/c1417f3dbe4f	3 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/c1417f3dbe4f]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/3af3b43bdf20	2 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/3af3b43bdf20]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/a2ba90db409a	13 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/a2ba90db409a]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/0b5a64ead6f6	12 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/0b5a64ead6f6]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/b7c6e2276983	11 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/b7c6e2276983]	https://evlproject.org/core/abi-revs/
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/8245a892b9ec	10 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/8245a892b9ec]	https://evlproject.org/core/abi-revs/
