Received: from dog.birch.relay.mailchannels.net (dog.birch.relay.mailchannels.net [23.83.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDF533A9C1
	for <xenomai@lists.linux.dev>; Thu, 19 Feb 2026 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771507691; cv=pass; b=YIZdov9zwuui6ktF+iecFnaTlDQpJcyxJNpEESeluUUPN492fclpkvXpn7deBpL+j/CM7XV3AMbwU53QBUHaK/UIdG3is8MNJhInajuPCfVsvoSzEMd+UIFYM5L3Yj7jM06r1IGJVSOfnu6eKuDoqxC8vm90QYYKweSVDYa7B/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771507691; c=relaxed/simple;
	bh=flaEekcffPLwkrztpN/ZJerfCWbctNkgH/ox+ia1oZ0=;
	h=From:Subject:To:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jdgRu1X3hc8CSdS0N7PrRD6yzckvQeuS7NU1HcokGqre2lYkiq3/S3Cdm975wtYCdaBu+xToW56iURdmU0kPOdUc0WwwgQoahF81O/BWjW8GsHj7YNJVvmLqQHPoAEWKoZkb0L5drEFfuDWjC8ezm8vYkTihVDfcgWfAhkhedSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=NjMVjtVh; arc=pass smtp.client-ip=23.83.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="NjMVjtVh"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B78D78023E6
	for <xenomai@lists.linux.dev>; Thu, 19 Feb 2026 13:28:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (trex-green-9.trex.outbound.svc.cluster.local [100.103.37.48])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 93C3C802586
	for <xenomai@lists.linux.dev>; Thu, 19 Feb 2026 13:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771507683;
	b=7e8kqeX0xazs7ndaiSWgp0/52QGWqwIPB24a83gDxlPPj9qI7YsRB1Un7bOvIODgvBDlye
	XB2wFDjREKyMk2Zka0YZbLQ/RCZ695wVw+X3cTnfq3xYY/1yeIbTYuzRHQHQ6bPsqo02q2
	EreYV4ACD8YNZLZ9NViH2qrZ/3Va/RlaBdfzA4sLhyyxsnUmPojrDjvjZrlLajquLRfHSI
	EYwToQmCBLZdp864j7QkfzW2rqhTbmV4OFiiBZVLOoHUQJWe04j4JBx1ja76SISYUkTzFB
	76f2UFbTJ1gD7XFopBtyVXd/xVOzGIti//GsjNAKh23JcVN6VZvuro+QxPhILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771507683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=I95sr3VqEr9dYrDSly//XIymSP2+l43hdjlGsPKoySU=;
	b=aQYsgaU3fh3KMDeTS2C6kER3bHB9MfK/E59shtB0Rxo3i5VDE5BgiXTQADZ/banI1+dCYC
	0XN1+2f9Gd1T2oZAbEyBLGevOTDCPOg/esYrisF6+4Q9MIKeZeZPhDWQLddB8IdhRQiIs/
	KaxQmDeibTFVc/b3CI5U1Bbk2pXsoF5OUxoWHxPLO7/FFq+zoaBddLHCIT7913z9vaaRGU
	HGWafaHw9KDiagncJI4a3Iw5dLcyqICs7ISWqKTYecGzuBj18L5GSwfE2ZX6T8zHoR6/SZ
	xJl9ZMCTvOqtbZJUoQ/ky40ALQ/1bJkadZ3qjM3dunAXF3J3lh0dhLBeQ5UJzQ==
ARC-Authentication-Results: i=1;
	rspamd-84c84ff4fc-5bqfb;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Wide-Eyed-Bottle: 7e0570ab55fe267a_1771507684548_2154774465
X-MC-Loop-Signature: 1771507684548:1984646195
X-MC-Ingress-Time: 1771507684547
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.37.48 (trex/7.1.3);
	Thu, 19 Feb 2026 13:28:04 +0000
Received: from giulios-MacBook-Pro.local (unknown [186.170.59.35])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4fGvMR1CWnz3L
	for <xenomai@lists.linux.dev>; Thu, 19 Feb 2026 05:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1771507683;
	bh=I95sr3VqEr9dYrDSly//XIymSP2+l43hdjlGsPKoySU=;
	h=From:Subject:To:Date:Content-Type:Content-Transfer-Encoding;
	b=NjMVjtVhze4bfMHt7fY0OlgSYCiZVjRwt9PShKEgVitlScz3XIEwYC2ZgG8hCDbli
	 5PdCcDi+/PxbWfhnjl8K6YUdz0KaN/5X16Y6F6B5BDrFz4vxwj65/THew2frnyS6q0
	 w52OT6r5LYh0mdGu8ZJqUPVctVdnJu+wPanKpYJdWIgnKe3uvRIrn4cTM7HhKguTiV
	 mYczCrBKqkT+t6dTb0oV3/absMd3hcc0nQZSZWg+G9gLrXu7xhnKVUimV27H/dnjar
	 Q/6UCRZwg+KNs8SdAmYVCtpTYbEwh39N18SfzoTW1fe+EdAFyzvSyPzk/xJ3SAFkKA
	 n6S9CyoEeVGnA==
From: Giulio Moro <giulio@bela.io>
Subject: Re: evl. event and mutex
To: Xenomai <xenomai@lists.linux.dev>
References: <facf1a8f-697a-453d-758c-acaa2c92c804@bela.io>
 <87v7fuxwon.fsf@xenomai.org>
Message-ID: <59cb3a66-550e-1970-9b26-c21910c7c208@bela.io>
Date: Thu, 19 Feb 2026 08:28:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.8; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <87v7fuxwon.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote on 18/02/2026 03:50:
> It is, please pick this commit (on v6.18.y, backported to v6.1.y-cip and v6.12.y):
> 
> https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/c02e718dda07cfa1db079450d352f62b32702c55
> 

Thanks,
that fixes it.
Best,
Giulio
