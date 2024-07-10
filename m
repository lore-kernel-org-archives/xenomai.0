Received: from dormouse.elm.relay.mailchannels.net (dormouse.elm.relay.mailchannels.net [23.83.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E11DDC5
	for <xenomai@lists.linux.dev>; Wed, 10 Jul 2024 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617455; cv=pass; b=ZvMWSsy+LqyeIo32SAb+4XVAPR6z7Sd5ocLBB4cEXQdVqE3SJGZTocS8I1zbMKoi1eXYyG/bmrXdbsYZWXAlxIxjXnvG0IoCmChlk4cKQhW8UAYdu/g+lrbI/7t7kbbbpJMdHqz3539lOvRqVx0Qa3uz40o2PtpYnDEDFKpFnBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617455; c=relaxed/simple;
	bh=bm9h65i87kENzBW5QqFR67g6qQmO1nfhNcjpfMEhpW0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NuoarH/raLDk2e5frNxCz/pXZLFSZDbAji5xoShBAagDkS33/hT0zmoqT2doYrUmmV+wSedck9iRgR3UJDqB42+7DTJsc/u6BzyY1msIHkWdbI8HpZaqBJ6AP9rTVkCOmba1TYC/23vttcNCbHoV+/J/xJY/Mu13pk/qJ3+KYKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=wTs9jmh2; arc=pass smtp.client-ip=23.83.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="wTs9jmh2"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9E2DAC54DC;
	Wed, 10 Jul 2024 12:40:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a278.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4C67BC3257;
	Wed, 10 Jul 2024 12:40:30 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1720615230; a=rsa-sha256;
	cv=none;
	b=hJMN0KNUIPIsHvI01a3bouiOk62IcsvosbI2xwiWToTtz4Af/GopchkaYdjJacXl3PCVQ9
	o/Zz/fvtUXfoTJ5/saL3Ew6HsnPWS4wQMcmyYEzKsG4pHH9soGy8zUDSp5puyqBrT4N1tV
	XUcuVBja1p1Hq197hcA2ylKeuDZqkVNntyN4IEa3MYmYUtqNAUgGl6vatdC9eZ4xm+LVvK
	VBsQkU2cE5/7uOolSCusmlszB2ENsUdkzri7J7hSfpBPH5y8rxW4ldy9Fbo4s5qPKza7Rh
	yWCbsYUO12G2NHXf9uds+d6w1P80Fs1Te21k8W2SmoonQGCcM6osr7K+iZKBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1720615230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=bm9h65i87kENzBW5QqFR67g6qQmO1nfhNcjpfMEhpW0=;
	b=VN03GTDew2BaJEI7nJgM0gCnaaSR2f+NDlnOejQrG+RhrIx/GinHipFgIbOEoHUvdwLofc
	rCW9r7Eec4Uqi4aZp0hbKD/Xk5ihWwO8E0MilbYlQvXtfyhdGf5PxvBDpywDEdWQTlzWDK
	zseI/dOtx1OPEGE71IkMh5eMJBpIfLwPsIaeCTC6x6sCjtwOjXtCiWUs7qs+k5FJd1Qyxr
	cfUIhd9OGKHBvM9W+jKCT9Mawz5wHozcJxFxCb6D08m4CPXduk2hJRoFGpIYLaoqKGmxyZ
	b4oSHyqOumus0ogISufBqqE/VMVoJ+uDH1ha/NRmkLKyLUqQQDdTLdT2MeGzsA==
ARC-Authentication-Results: i=1;
	rspamd-6db77b4858-c47pr;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-White-Lyrical: 1f287d063881affd_1720615230536_688749891
X-MC-Loop-Signature: 1720615230536:2109503738
X-MC-Ingress-Time: 1720615230536
Received: from pdx1-sub0-mail-a278.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.125.5.136 (trex/6.9.2);
	Wed, 10 Jul 2024 12:40:30 +0000
Received: from giulios-MacBook-Pro.local (unknown [186.99.138.208])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a278.dreamhost.com (Postfix) with ESMTPSA id 4WJyBP5Wc9zRR;
	Wed, 10 Jul 2024 05:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1720615230;
	bh=bm9h65i87kENzBW5QqFR67g6qQmO1nfhNcjpfMEhpW0=;
	h=Subject:To:Cc:From:Date:Content-Type:Content-Transfer-Encoding;
	b=wTs9jmh2X49KMA+OOmrp0FyR/V7krplS0/TqFINHn2tXCbTAZBHmko3yyQVRwmFph
	 hJ3vuTpSZ0F8wDGvO+DHlUShyul/mx6rXd5DbjhhXrPZAp69NlnzAStlVh0vZs6mSP
	 zN+fmHXdn0MdEBa9xXDcrkM0Be0gf4UDlC9+0FMe+Bol8NV0iwLLECESwhBwfD+R0i
	 vQNGYJW2jHbHNKbflw34UeZP3iIWpebrYV9MISV+DJgEl/sBZF0+DuJSE2M80yAQ3R
	 jE7JSj5x8Jb5izIL3/zmdshNvl5mUQ9AZ9fObjnjZOCze2VYmkb0hoP27emtAd/1FJ
	 /meqIGlvpWPRA==
Subject: Re: EVL documentations issues
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <7e4de8bf-c42c-7592-ee44-022d0e75fb68@bela.io>
 <87wmluff5e.fsf@xenomai.org> <06cf758c-5d93-2304-203b-c4e0a242351d@bela.io>
 <87y169wrxh.fsf@xenomai.org>
From: Giulio Moro <giulio@bela.io>
Message-ID: <8c8c0787-5c3b-b513-4d3b-1703737b04f3@bela.io>
Date: Wed, 10 Jul 2024 07:40:28 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:91.0)
 Gecko/20100101 Firefox/91.0 SeaMonkey/2.53.18
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <87y169wrxh.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> I'm unsure usleep(0) should amount to a manual round-robin, at the very
> least the POSIX standard does not states that [1]. I cannot find any
> explicit reference to such behavior in the manpages either. However,
> evl_usleep() seems wrong nevertheless regarding this if we want to stay
> close to the POSIX behavior when this makes sense.

You are right. The Linux man page on my systems doesn't mention that the call has no effect is the argument is 0, rather it says "suspends execution of the calling thread for (at least) usec microseconds" which hints that a suspension of the calling thread happens even if the argument is 0. The POSIX.1-2001 page instead states explicitly that if the argument is 0 the call has no effect. Either way, it seems that usleep() should return 0 and not EINVAL when the argument is 0. It's up to you to decide how evl_usleep() should behave in that respect.

Best,
Giulio
