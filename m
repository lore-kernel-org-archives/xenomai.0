Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D4830CFC
	for <xenomai@lists.linux.dev>; Tue, 26 Sep 2023 15:47:26 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52298C0009;
	Tue, 26 Sep 2023 15:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1695743244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lNF/FLm4HckZoiu9QR3yYmmj+0von2lfcetXaHsu9iw=;
	b=AlFwqnkaZ2KlTOI5syWAQyFUfXOAUlHQ8SIBTCLzM4Vma9kSCIiRwD1JKah1w5rRZW43kL
	sxmq55YfaA1EA9Y51sx+HMb45kilnXcqRxgzXVMxrZmUmizifGbCrMopkzqeuwf8iYVeFm
	4jI6asnGpnwKqBu+M5EuJIH4xGkTZTi3DOzMul4o2467jsraASYUC3LfMFfLzZIjrc5MRu
	ufi5x3QqVtLdZafH8SkfMMP/7iz1xP/nouMRgvkmcEjAklgMJ/q8xgr+CatN0fZ3YEuzuR
	pBVJYdEHs+ZbwEcnqxqKN2HMGfalh1qaqC0tjOrH/rWp2u+nnmxwRHAgst8wlA==
References: <DB8PR10MB370698CF0BAFEAE2198D24A3F9C3A@DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM>
 <87sf71nf1h.fsf@xenomai.org>
 <DB8PR10MB3706B544A1AD8812E2ACA78BF9C3A@DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jesus Villena <j.villena@ecler.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [EVL] Problems writing to physical memory with mmap on oob context
Date: Tue, 26 Sep 2023 17:46:26 +0200
In-reply-to: <DB8PR10MB3706B544A1AD8812E2ACA78BF9C3A@DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <87o7hpndh0.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Jesus Villena <j.villena@ecler.com> writes:

> Thanks Philippe,
>
> I have already tried the custom driver solution you mention, mapping the shared memory in kernel with ioremap, and adding read and write handlers instead of mapping the memory to userland, and it works, but I would prefer to do a proper mmap to access to the memory in a transparent way.
>

I meant writing a driver exporting a mmap interface restricted to your
SRAM area, instead of using the generic /dev/mem device for this.

-- 
Philippe.
