Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD5A4AEF5
	for <xenomai@lists.linux.dev>; Tue,  9 Jul 2024 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=217.70.178.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539921; cv=pass; b=KFQ49wlPeR1HRA6iHLNKmR+oSBVYQ6grCQXcdH0j5J/KK5bhWiGZX/MaEKRju6mXo1nL0Y4Wj5BVaMcj2h2Dv8d4NHyFIdQ0i74crjHcUrR4z/bNTimTAJB4cJDmuj/b88ajjnm8DKotcibuDkTVLTC4x5DWxHA3oyt6u5vnYeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539921; c=relaxed/simple;
	bh=6Rs11reMzpzbSSy49+0w+VHmcHc6lpwjLAF1ETD3wOQ=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=XQhMV1Snu6a3272RMSTsml6rwjUbgF3owHJ22sSDdqkK0xcfb4qBGTc+n/sGuSfiruVvq8ggOUAAj4rCdvfgJIa+L0NKNIGdYnJAfAqKKq6OJlq5lXX8I/blZw6K/FzZiXj9hg446Q6sWdm7MGlD4vpZ01NNnpdS87F9sh65j/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bela.io; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=ps2dIGYg; arc=pass smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="ps2dIGYg"
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id 2386D1A0002
	for <xenomai@lists.linux.dev>; Tue,  9 Jul 2024 15:45:11 +0000 (UTC)
Received: from crimson.ash.relay.mailchannels.net (crimson.ash.relay.mailchannels.net [23.83.222.44])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 6D016AC0F03
	for <xenomai@xenomai.org>; Tue,  9 Jul 2024 15:45:09 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 644DEC4822
	for <xenomai@xenomai.org>; Tue,  9 Jul 2024 15:45:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a308.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D9C3BC301C
	for <xenomai@xenomai.org>; Tue,  9 Jul 2024 15:45:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1720539906; a=rsa-sha256;
	cv=none;
	b=S9U2PmXg6wXwBBHTNC7LqUVhf2mF0ml07G9kqYF1HwQvcvRgN5a3znMoN99wPaZGwMzn4j
	nG5H9Z1EyfPLj5HG7cCtPvd89IMWnl9jM8gBYGJB2/10IjR2Dv54jfXB2/0QBLCy8akSAl
	Bdh7fVDDvHmc4GmpqVQvNrXEz4ZoYwCr4szNOCI2VFxkM0Cv5laQPL/K5gwe3WfKkanPZr
	kBtxr7NNF8hbBqHx5u1E+1t9SA30u7l4zju86E8J4QCXc4Eg/6HBA7npHosA0n7g9B7V0N
	plDxPjT7OD7aQvHdkOaMH28KQ+2GIrgyFxT3x2Hd/rDGk2ji1YOEe7Ohw0dv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1720539906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=IERsojKtgUsz2C5DqJz6O0xfl6Np46rU4uVrBAsfTXU=;
	b=uKkn/FalQiljzLjuwH65FGlvAq/3hZLaRWvHeoR+SR4GV6Xj8UZxzIE7/p8LKTvk8f+Ruy
	CvgoHCTua0NxKa8gheAptdI442zpcschsxGGQaK7vmINDpDOVrInV599wZ6isf88/aevvX
	o80p1Fp4LBoqpptW9lWxp9NMNCkJaiysik/qx7niDzg4cVq+Ca40UW/nwCfedOWsXcFVQa
	5tVvJRkL2q132WCujwEJtyhHwmP9An4Kc5Y40yaKBfYnxAObABBaUogAj7cJSUI67iZDyZ
	OCbmmfGsswvTa/PE3otOjPcE4ikskCDFOLxZLat1BkAjjjD/6g/TmxP1Iox4lA==
ARC-Authentication-Results: i=1;
	rspamd-7c4f8cbcf8-m2kv8;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Ruddy-Relation: 46cbedbb644eebc3_1720539907175_2666056395
X-MC-Loop-Signature: 1720539907175:2715755037
X-MC-Ingress-Time: 1720539907175
Received: from pdx1-sub0-mail-a308.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.88.224 (trex/6.9.2);
	Tue, 09 Jul 2024 15:45:07 +0000
Received: from giulios-MacBook-Pro.local (unknown [186.99.138.208])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a308.dreamhost.com (Postfix) with ESMTPSA id 4WJQKt2HXQz9f
	for <xenomai@xenomai.org>; Tue,  9 Jul 2024 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1720539906;
	bh=IERsojKtgUsz2C5DqJz6O0xfl6Np46rU4uVrBAsfTXU=;
	h=To:From:Subject:Date:Content-Type:Content-Transfer-Encoding;
	b=ps2dIGYgLBR/YWWVE60E4tlVCtIMo9wrsfXhIaYzPxwe0+YHtHVOyifz0/v6YhCvW
	 v6T/mxmXwXAd/4Hf+Es3X7o4mdum3Yo3GV5PjpiY17rTadYePkAlu5AtS5c9XuNTrx
	 UL4sg3P6JOo78M0w/8fDXzXNnRnNKK32AR6pJncMuJ24YN9hAYwmAwY12VNIsfsmHj
	 BaZ1J9Pw4UnGkXrC9C+LiDz5mFUTzFL/zFf5LAuOWe74A99pUbYO3lFkqsDYYnrsBR
	 fPRyS4cSOePSMP0oUyPNmZ52oiXz3KjIiPFjufXAFtC7xbk82Sp6vilh9bzP6pOUnW
	 m5kmccX+qJ6QQ==
To: xenomai@xenomai.org
From: Giulio Moro <giulio@bela.io>
Subject: EVL documentations issues
Message-ID: <7e4de8bf-c42c-7592-ee44-022d0e75fb68@bela.io>
Date: Tue, 9 Jul 2024 10:45:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:91.0)
 Gecko/20100101 Firefox/91.0 SeaMonkey/2.53.18
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=bela.io header.s=dreamhost header.b=ps2dIGYg;
	arc=pass ("mailchannels.net:s=arc-2022:i=1");
	dmarc=pass (policy=quarantine) header.from=bela.io;
	spf=pass (spool.mail.gandi.net: domain of giulio@bela.io designates 23.83.222.44 as permitted sender) smtp.mailfrom=giulio@bela.io

Hi there,
going through the documentation for EVL I noticed the following:
- at https://evlproject.org/core/user-api/function_index/ the functions evl_udelay(), evl_new_clock(), evl_get_thread_mode() (at least) are not going anywhere and they are also not mentioned in the libevl source code.
- in practical use, evl_usleep() seems to have a limit of 1000000 as an argument. Is that expected? The limit is undocumented and the corresponding -EINVAL return value is also undocumented.
- evl_add_pollfd() and evl_mod_pollfd ()take an undocumented union evl_value pollval. The tests use evl_nil.
- there are several broken links. I found these with https://www.deadlinkchecker.com/ entering evlproject.org  as the starting page. I report the result  below for convenience, but the kast column "Source link text" is much more usable when viewed on the site as it is a clickable link to the page containing the broken link


      Status	URL	                                                                      Source link text
404 Not Found	https://xenomai.org/documentation/xenomai-3/html/man1/latency/	Xenomai 3
404 Not Found	https://docs.zephyrproject.org/latest/getting_started/installation_linux.html	Zephyr SDK
404 Not Found	https://source.denx.de/Xenomai/xenomai4/revl/-/tags/0.4.0	0.4.0 [302 from https://git.xenomai.org/xenomai4/revl/-/tags/0.4.0]
404 Not Found	https://xenomai.org/documentation/xenomai-3/html/man1/latency/index.html	latency
404 Not Found	https://xenomai.org/documentation/xenomai-3/html/man1/autotune/index.html	autotune
404 Not Found	https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt__core.html	Cobalt core
404 Not Found	https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__rtdm.html	RTDM
-1 Not found: The host name in the certificate is invalid or does not match	https://rtai.org/	RTAI [302 from http://rtai.org/]
404 Not Found	https://man7.org/linux/man-pages/man3/clock_nanosleep.3.html	clock_nanosleep(3) [301 from http://man7.org/linux/man-pages/man3/clock_nanosleep.3.html]
404 Not Found	https://man7.org/linux/man-pages/man2/fcntl.2.html)	http://man7.org/linux/man-pages/man2/fcntl.2.html) [301 from http://man7.org/linux/man-pages/man2/fcntl.2.html)]
404 Not Found	https://www.kernel.org/doc/html/latest/core-api/genericirq.html)	https://www.kernel.org/doc/html/latest/core-api/genericirq.html)
404 Not Found	https://source.denx.de/Xenomai/xenomai4/libevl/-/tags/r41	libevl r41 [302 from https://git.xenomai.org/xenomai4/libevl/-/tags/r41]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/7af18f8a38ad68f581cf770819ccb98c29f41586	20 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/7af18f8a38ad68f581cf770819ccb98c29f41586]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/41dc88ab524cd32878646d98b57d390e2bcc1198	26 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/41dc88ab524cd32878646d98b57d390e2bcc1198]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/libevl/-/tags/r40	r40 [302 from https://git.xenomai.org/xenomai4/libevl/-/tags/r40]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/87ee9586fa60	17 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/87ee9586fa60]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/231089ed6028	16 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/231089ed6028]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/6b8a2319c02d	15 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/6b8a2319c02d]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/3d4ff940c1d3	14 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/3d4ff940c1d3]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/a142e2e027dc	19 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/a142e2e027dc]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/b8351b703ffb	18 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/b8351b703ffb]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/9397204d7484	8 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/9397204d7484]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/c1a5ca6a70e7	7 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/c1a5ca6a70e7]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/bc92ac9d3b90	6 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/bc92ac9d3b90]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/d9b664b5ecdb	5 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/d9b664b5ecdb]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/57ce409e23e6	4 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/57ce409e23e6]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/b81555f4f48b	1 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/b81555f4f48b]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/cfab80b242c4	0 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/cfab80b242c4]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/f6f6e58cbaff	9 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/f6f6e58cbaff]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/c1417f3dbe4f	3 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/c1417f3dbe4f]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/3af3b43bdf20	2 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/3af3b43bdf20]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/a2ba90db409a	13 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/a2ba90db409a]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/0b5a64ead6f6	12 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/0b5a64ead6f6]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/b7c6e2276983	11 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/b7c6e2276983]
404 Not Found	https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/8245a892b9ec	10 [302 from https://git.xenomai.org/xenomai4/linux-evl/-/commit/8245a892b9ec]
404 Not Found	https://evlproject.org/core/benchmarks/(/core/runtime-settings/)	calibration settings
404 Not Found	https://evlproject.org/core/user-api/io/_index.html	oob_read()
404 Not Found	https://evlproject.org/core/user-api/flags/(/core/abi-revs/)	ABI 33
404 Not Found	http://nanopi.io/nanopi-neo.html/	AllWinner H3 (NanoPI NEO)
