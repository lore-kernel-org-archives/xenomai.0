Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A632AAC5
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 19:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771615938; cv=pass; b=TagGh2VfGERTVMCcMTIjLOdKE/5D67TOyPTMF3/BuN5+HJbQyvXNjWMqf8cezwzfzfHzT+ajbyQpomm58bWCbZeg4+pPK383QcDAcnKihiDjjubmay8rsUY/3G/+UqU8BqLyIuA8mR7NLZ9Y81h408+NADGxRxbDpolD2DXxVR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771615938; c=relaxed/simple;
	bh=0WfFmJXheI+kmKSDxCT3pBCx5It1U2dj8hqw63SlwFg=;
	h=To:References:Subject:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Jc5gxtrmeowheJ5xZ90D5ypOCN7g8jnTVEjQOfT0czBbd/z4Mn3uKW/1lQaEMyy+JPxKJVvF7nwguzOjJxXh423yKUAyd2JqbO50faJrO6Vv1Bt2REfGxXb015U3+qLVWWTi3UXEPNn3vqeHCxfB0KeSKs7rnT1vZKlV94WU7HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=LHubGT9H; arc=pass smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="LHubGT9H"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C6CFB921850
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 19:22:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a240.dreamhost.com (trex-green-0.trex.outbound.svc.cluster.local [100.97.23.78])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5D088920F6B
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 19:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771615368;
	b=ZDlV6gUwBWLXeEZ1iBTr+bKLYU4ISnGhvPZoWVuZ93ungD9Wo3XHl94OuK/UI3cP00bHK2
	3aMCjZ3tEPovWsS85d0156uWcCZNS88thS1JBBMSCu0wtdae2EOnWtVGfPM4cPhcyst4vp
	BkZcV5AVHCVo96UjdZDOl/wh3CdThdfgXSlZU4v1Pz8LOfL3jnSdNheNYbFU+NZBwoJAui
	fUwu0DaaERJAAlK0/nL+pUwpckbXGMiBdFL1jT+iHQrXqFuDaSQgTMHlG35FZdjuZoUZnd
	ZrQqvtqSlZnHQBy3P39oa3KSUnYha7wRbxDXABt6nqruCWcOE0pK9yju4Qq8jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771615368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=bbXO6YOkMHFXFAPSSBkXDryiP25dPsfn+AnqreuvcHM=;
	b=8N+Pdj3nW7qTjM2y4+1CREhWxZ729xUztPAK9HEbmwTEUxOoRGoA9xoQG4HbMxVOFll+8r
	Q8L3wOh3oEopx86dE/wwaZ0XwCO4cSdUGltoMcCIbdY6FZX73G4BBvlKl+3AB28AI6WVsU
	ad2heLZuOnHykVux8XhWjzOOVnuRvEzeONR6oOLRa8yHKMyfaohguQTw7LglcyRAtQKK9H
	BjwVlISr+jVDWQWKtPkp9PinsZMGyirHbgS5dqsVslD90DqPcW1FRZ/+fAKva7vNsH3z5c
	068NJvw+heJXM8Z9eGTvFeAfrZAzyHDP/h+RDzaAtrsvQImiGxl0IzPUoLJHwg==
ARC-Authentication-Results: i=1;
	rspamd-659f7bc6cc-w8j6h;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Shoe-Exultant: 0d79b0cc2b8b808d_1771615369636_358326194
X-MC-Loop-Signature: 1771615369636:1003038181
X-MC-Ingress-Time: 1771615369636
Received: from pdx1-sub0-mail-a240.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.23.78 (trex/7.1.3);
	Fri, 20 Feb 2026 19:22:49 +0000
Received: from giulios-MacBook-Pro.local (unknown [186.170.59.35])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a240.dreamhost.com (Postfix) with ESMTPSA id 4fHgBH5MgYz1040
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 11:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1771615368;
	bh=bbXO6YOkMHFXFAPSSBkXDryiP25dPsfn+AnqreuvcHM=;
	h=To:Subject:From:Date:Content-Type:Content-Transfer-Encoding;
	b=LHubGT9HeEBmnqp264HZ+D7Pif978iJaIdYTdZNwiWnvff9g3qlE6ha9pek5ewabB
	 0KHJqNtPzlOm+IV1aH7ZKlB3nwW3kaeU0kCYs5CyH1cX7+MdXFeakEitC9a056MNKO
	 +KN6LI8vRGmqw4i57DVFll46fjAscwkUBW6YREADVc9XshNwxn3QhqK3gyOc+mgAmL
	 gXitwp5EKMH8wUV6WIE6X2pm9g1v+1Ar33zpE1mW8EaGhRBrR52YKlOmTreG4eHHAU
	 bjDI3KoBGYpPmOYsnt57pHwQok8CQ7O0LV8MIdq/mIbNOyd/48Dq7I6iAWj3a3NI/t
	 k0QCfJpZo3yQg==
To: xenomai@lists.linux.dev
References: <21b140ef-69b2-6dbe-f12c-c4c46a28a67e@bela.io>
Subject: Re: evl ps cpu time reporting issue
From: Giulio Moro <giulio@bela.io>
Message-ID: <ae5e9ded-d9c9-92f2-7652-22d63340c988@bela.io>
Date: Fri, 20 Feb 2026 14:22:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.8; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <21b140ef-69b2-6dbe-f12c-c4c46a28a67e@bela.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> The most crucial one is that sometimes it reports excessive CPU usage, e.g. (running watch -n1 evl  ps -st):
> 
> 
>  CPU   PID   ISW     CTXSW     SYS       RWA       STAT     TIMEOUT      %CPU      CPUTIME       NAME
> ...
>    0   1011  6640    31157     37608     23656      W          -         1193652.1      0:642.101    thread:947:0xffffb3c0fe30:2214587712
> ...


I forgot to mention that most of the time this thread reports 0% usage as expected. To confirm this is not an issue with libevl's visualisation, but the issue is somewhere deeper, one further log:

# while sleep 0.1; do cat /sys/devices/virtual/thread/thread\:8011\:0xffff97cdfe30\:2491661632/stats; done

8926 41873 50471 29419 609329129 0
8927 41875 50474 29420 609388012 11133
8927 41876 50475 29420 609410796 0
8927 41878 50477 29420 609451945 0
8928 41880 50480 29420 609481429 0
8928 41881 50481 29420 609498449 0
8928 41883 50483 29420 609535063 0
8929 41886 50486 29420 609574946 0
8929 41887 50487 29420 609592925 0
8929 41889 50489 29420 609632058 1
8930 41891 50492 29420 609663628 0
8930 41892 50493 29420 609680457 0
8930 41894 50495 29420 609717002 0
8931 41896 50498 29420 609746761 0
8931 41897 50499 29420 609766180 0
8931 41898 50500 29420 609783920 0
8932 41901 50504 29420 609836897 0
8932 41902 50505 29420 609858481 0
8932 41903 50506 29420 609887230 0
8933 41906 50510 29420 609946013 20581947
8933 41907 50511 29421 609971602 0
8933 41908 50512 29422 609998161 0
8933 41909 50513 29423 610025640 0
8934 41912 50517 29424 610095202 5239
8934 41913 50518 29424 610113607 0
8934 41914 50519 29424 610137617 0


Best,
Giulio
