Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EAC1C5F27
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760101238; cv=pass; b=F8rx3V73Etd8M6VqREt71QOoqdX+R8BeiAYEh1ZtWuec2uf6N/zAPszP+7qwTZY4pacdUk7h8qLYtC+zyFqNXYwtINeZ5SvZJKRkq2SKAdc8bm/V1jRxxu/PLO5yTuiRc2SiEJaZbPRzqTY+4dlI9vjvMjZ4S2BpMNA480LMxtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760101238; c=relaxed/simple;
	bh=QFL1wZfgoaCKKG6YBvHGglQxnx6H2ai/53UP3EhLUHg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Jk4PYegqlEOkbzvPhLplqGP9wuBBaMGnZuEZdGrRc1wxaIEpMna4U5PjwQhzIn+6Lra8RhD0kvr9XhHKWPep3msQClzRLB/TBKOZzt5noABKaeK6wXifYJyMbUFIa4Eab/QtPZ51hvXqHy40cRKD2yg884mmqUdIt67tHiyNh3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=a7z7fBBu; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="a7z7fBBu"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C37407017FF;
	Fri, 10 Oct 2025 12:21:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a239.dreamhost.com (trex-green-5.trex.outbound.svc.cluster.local [100.116.100.136])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 635BB701445;
	Fri, 10 Oct 2025 12:21:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1760098887; a=rsa-sha256;
	cv=none;
	b=sz06KOLGejGSP0gpreF97dD88+2fjf0uzIZPXJ1Q153k6+WeF+DjOZNnleirxNS6LxtUWm
	Wihfsglc5Aajw/zxjdffBcHXXc2rmOHxJnnY4zGKPB9p9Us1H1dd+HwvecaTh9SooUisOe
	hS9ORtqcED7feY47ZUHA0Gb423g/EaktGVe7/4JL7Ux/Y5hQA7aEk8J5ho6FijRUYtG7ca
	MDhuyEYJC3Ej76kfmwum5bqwM8aSkO+LacAOOihmcnPwpydAoZwVJGDeFovMwfEopttJmc
	wpmk9HdEpgy2My249wsvCzapIk1VWTDwv45xCd5QgJaariIg7YCISRE8C8csyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1760098887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=QFL1wZfgoaCKKG6YBvHGglQxnx6H2ai/53UP3EhLUHg=;
	b=EryTbPBsBgPQLMEOytd/5xXKmgyeSPBZez1ojbTZe8sGPFeVOI3xjRurM357kDSnkY1l4e
	IedtCCjsBBqOocDc4g4XcIox2m6/MF8MTzxGoP0gIwOL0theDuIIIAWIJB+LZ0RHQR/Ogq
	q7Cp3Lv74lUj/x0sHC+EZ4LV7Zw8TFBkFSmgF0PsAuTQ3OUlITNqHdDdks+XhvpGFTHIqJ
	MvEB4FQMaIE8PLacjAW5pywt1H3I51NVucAXuC6LjXlH9b8Kr+/5bTHXyGoYyAmEwMQy7T
	wWrMI1IfMjvKsO09HrqoBYNNj/AFDwsBRhFIqMqAvznHUwiEnAT8Fyd8/ssS4g==
ARC-Authentication-Results: i=1;
	rspamd-777888ddf6-b6jkk;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Juvenile-Drop: 0971a8fe4f87f940_1760098891587_1520764214
X-MC-Loop-Signature: 1760098891587:2002728132
X-MC-Ingress-Time: 1760098891587
Received: from pdx1-sub0-mail-a239.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.116.100.136 (trex/7.1.3);
	Fri, 10 Oct 2025 12:21:31 +0000
Received: from giulios-MacBook-Pro.local (unknown [191.98.11.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a239.dreamhost.com (Postfix) with ESMTPSA id 4cjm7V5Wybz6G;
	Fri, 10 Oct 2025 05:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1760098887;
	bh=QFL1wZfgoaCKKG6YBvHGglQxnx6H2ai/53UP3EhLUHg=;
	h=Subject:To:Cc:From:Date:Content-Type:Content-Transfer-Encoding;
	b=a7z7fBBurUH7v4ho8vts3BOPT6x9rSsp/44yUVHgWmcJJFoiT3AnixTh74rrPa+bh
	 JHnYT1/aPGfzBFnDGFfo5osTi5jvd9XeLM27OMYgZG+JHIvw/fSi2A/GQsNxuCxtny
	 uHinD5GuyJUBNOx0tR1UCHsYOZMvHW/swGIo9JGs/gS8w+LyQL1uJOrZwbtE/fAAYt
	 nRuIN1CPTaffh2xJedsTH+XXyQOc2nUtI7lv8S4N7zDUsx3wispWRJ4CuaPQs2Dc8Z
	 PtV4m6wicUSq7mxSEAxKecoDiUK577iSes9k5+FOpRKRwJDMjw3q6oBYk2asgsMC3z
	 w4rcat8qc902Q==
Subject: Re: Unexpected switches to in-band
To: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@nabladev.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
 <20251009151737.0d03b211@wsk> <20676160-4572-d92d-4b33-ff4255946345@bela.io>
 <20251010122427.54ebb9ac@wsk>
From: Giulio Moro <giulio@bela.io>
Message-ID: <a3af644a-f056-2b99-7671-461681962a0e@bela.io>
Date: Fri, 10 Oct 2025 07:21:24 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251010122427.54ebb9ac@wsk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 2. After the "first" occurrence of the in-band switch in latmus, when
> it is started again, the issue cannot be reproduced any more. The
> conclusion here is that the issue is with "startup" or "fresh"
> configuration of memory subsystem with dovetail

Do you mean that only the first instance of latmus that is started after a reboot is affected by this issue, while successive instances are not?

> With guidance (and huge help) from Phillipe I'm now ftracing the
> evl core with latmus to check what can cause the issue.

Would you be able to explain your setup here to see if I can reproduce?

Thanks,
Giulio
