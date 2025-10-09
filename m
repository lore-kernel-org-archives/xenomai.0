Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4D1397
	for <xenomai@lists.linux.dev>; Thu,  9 Oct 2025 05:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759986612; cv=pass; b=GwRG8RR2FMmXWZSL7vriA8j0xH7/d7ji3MgtCJqSG/YbFxjeb1XhK/QbDyV7BPkFa0N5G8f1byXtU1EfHaMz+G5FMKNAVs3Q0n5CV+PUHgCgO8sjaJ9rWZgx+I4A8yc9vbEsd1vIh4f1GLKMq4Q2DQn3NaIDNi7kgC4JTD0+wEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759986612; c=relaxed/simple;
	bh=yppj4PazuuygD8R2Q3/FWgGQJPRTBkuWy9k7fVrGK/A=;
	h=From:Subject:To:Message-ID:Date:MIME-Version:Content-Type; b=juMDxKQZHk2GFPU/pj8q5rql/r/OQ4JfswfpSoGJQjqhhGXgAIcLns+DRUhQ0pKUZY6OlEN07zVRwbPcvlQvR6zyRN3GTNqF9Mp1quYevvGa+APs//mpB5CP0Xd440xV5BzdN/xc4Bv5Vqxnj3KkEatPBuEWTzM4LGadcGL7sZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=BoV9+a5y; arc=pass smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="BoV9+a5y"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D5E408E1236
	for <xenomai@lists.linux.dev>; Thu, 09 Oct 2025 04:33:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a264.dreamhost.com (100-117-6-49.trex-nlb.outbound.svc.cluster.local [100.117.6.49])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8A2A08E1652
	for <xenomai@lists.linux.dev>; Thu, 09 Oct 2025 04:33:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1759984400; a=rsa-sha256;
	cv=none;
	b=em0mTtAmO0tGahAVAsBClm0XTRNIqNFX+2wR8x/AYGU81zjYh0o4AhQOxoD1xeWvsPpfRa
	JKrQuLl/G5sYfPWvFyrqyiIIZwQahkTWRqFEzkcKxwfj5/O1Cw5rbQNcpe5p+WEJ2pKxot
	qxRNJaCGl0qfSPOrWS1elAcLMI94ezrQeBd+LwLKC/vLW3K/pqeBOj0KenSJqQKLpsZ504
	ccgtkSMSANyQAkSRllvIpo+hBGPm2T1jskGO3EgJey6hAIcv/yQxc3WV4S7z39Fm8EZKXU
	5xhoWa9av+2UBhEDZOTSEZtDxQeC714VysxBRp+PjMFlDan3XHQZh6cM8sUdJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1759984400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=cInAe582ZCBqRfxUgoNSBGWORpwfCZQ0to7R7r7ARis=;
	b=imkDgznSrAKY/7fBylcenDARK69O6cO7R6hSls6KBV6O9JqwI2N6Ych9qGeDrtH2GucLJQ
	hvc33iWoFMdJWcpQXEZgD9bTPJ+1BXeF4l55Xesb73rG/r5rZ4y2FBz2mQl92jjVB/rLlJ
	fbqpNVe/EVDhiq/M6MGd5NjiC2DJmU2D3g7oKcGhAAeO2tDjMu7jXaXpreu7fNxdSpUeMl
	Yz+Wwp6SkcB1A+CSTfYEZgWkvBI6IP20m50ouKwqswDDhISY3Os9RhF3SkFUNCyZS2JdQB
	8b1jv8MOstVHZGWVvhaCbkDEF3UvBWw+8TO2V0wOcDv9ZXR5XJx/EB1ZCRgeWA==
ARC-Authentication-Results: i=1;
	rspamd-668c7f7ff9-j8lwd;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Relation-Chemical: 437f7d376b9d1edc_1759984404696_773607639
X-MC-Loop-Signature: 1759984404696:1115139032
X-MC-Ingress-Time: 1759984404695
Received: from pdx1-sub0-mail-a264.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.6.49 (trex/7.1.3);
	Thu, 09 Oct 2025 04:33:24 +0000
Received: from giulios-MacBook-Pro.local (unknown [191.98.11.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a264.dreamhost.com (Postfix) with ESMTPSA id 4chxnr1CrXzHw
	for <xenomai@lists.linux.dev>; Wed,  8 Oct 2025 21:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1759984400;
	bh=cInAe582ZCBqRfxUgoNSBGWORpwfCZQ0to7R7r7ARis=;
	h=From:Subject:To:Date:Content-Type:Content-Transfer-Encoding;
	b=BoV9+a5ylzEy7cOES0qwQco604hq01jHWfHsE5DDGRmYbVTY8s2Z1+X1bjz7ZxbW9
	 pmm4YEqvbOt/UaNK0KOHvRgs92+im2mEqI0nMW3UaYvx80Tq9U0ovCCdtakdI+q8O1
	 RjNQxo364iGIPcTwZ+qgzEOMfrAPvkbVuJbvOjxsxWbjPZElYYtUN4G1ORj/OoYw3v
	 TLpBsx9vH1YTpfTNcFy3nkhAP8sPVGXEW8yN5vDDIc+W7CMGOdo47Z6w123f7cq3o4
	 10dNn0mXuMqthuij4scSPJ7+C9qpqr3zG/8yiFaDIaSjaLBzWF2ixz2vnmGookQS6R
	 KgMtNa5P8E5Fw==
From: Giulio Moro <giulio@bela.io>
Subject: Unexpected switches to in-band
To: Xenomai <xenomai@lists.linux.dev>
Message-ID: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
Date: Wed, 8 Oct 2025 23:33:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Again, PocketBeagle 2 (TI AM6254). I get errors such as the below:

debian@BeagleBone:~$ sudo latmus -m -H20 -T 500s
warming up on CPU0 (not isolated)...
RTT|  00:00:01  (user, 1000 us period, priority 98, CPU0-noisol)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|      4.957|     10.135|     22.647|       0|     0|      4.957|     22.647
RTD|      4.977|     10.107|     23.112|       0|     0|      4.957|     23.112
RTD|      0.948|     14.831|     52.911|       0|     0|      0.948|     52.911
RTD|      4.084|      9.548|     24.404|       0|     0|      0.724|    122.540
RTD|      4.195|     10.080|     50.350|       0|     0|      0.724|    122.540
---|-----------|-----------|-----------|--------|------|-----------------------
RTS|   -982.336|     11.935|  12357.665|      22|     2|      00:02:36/00:08:20

*** WARNING: unexpected switches to in-band mode detected,
              latency figures displayed are NOT reliable.
              Please submit a bug report upstream.
-- aborting

Possibly unrelated, it also happens that when I run our program, which runs with a period of 360us using 15% of CPU, it normally works OK, but occasionally I get _large_ underruns (like 3 to 5 ms). I haven't started debugging that yet, and I am not entirely sure it's EVL's fault, but I thought it may be worth mentioning it here.

This is on a kernel I put together: I applied the EVL commits that are at the tip of v6.12.y-evl-rebase on top of the TI v6.12.43-ti-arm64-r53 kernel plus the beagleboard patches. Here's a link, FYI https://github.com/giuliomoro/linux/tree/v6.12.43-ti-arm64-r53-bb-evl

I appreciate this may be a bit too far from mainline to ask for specific help, but I am wondering what the general approach to problem solution is here: what would make a the latmus thread unexpectedly switch to in-band?

Thanks,
Giulio
