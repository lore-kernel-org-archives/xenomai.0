Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1C53D63
	for <xenomai@lists.linux.dev>; Wed, 20 Sep 2023 09:13:29 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 283CAFF804;
	Wed, 20 Sep 2023 09:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1695201202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oVyPWYCzPktYtiUP1LAvLrUExsGTZ8izEFt8ZlbqQ58=;
	b=bwuL8I2CESiVwec1uE2pzZY30x3Dc+TI+SelaV3LrWvepsEvilIxtLpcy7ewhGCBkBx/Ov
	OmyXB4erx8X9YeO6RwP6eGinvN2vbF74gQWnRxALEeCrQt/Mu2vhcnHeqjraiW53JL7Rxo
	KMKDnX5tATC8KD29XkMNMe6MMVdc7zArw7NJjdMqlyeXz++UYjarlURHAZ1uU3SgjnYyck
	QrkSp0gjN50wzLfWTT2jh4pRy2vNGNIeqoCsN5GLtc4+8kRWkq0q1CV3zYuOTVD5Ib4EyD
	B7FdukHODA/hqpGM8yErPV1YEiSVOrF/oA0JYsv6BrBK3FOicq8yV4bhKbk+Bg==
References: <20230918080609.96600-1-rpm@xenomai.org>
 <MN2PR11MB4285BA242B77C4256CBFC02DF2FAA@MN2PR11MB4285.namprd11.prod.outlook.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [PATCH v2] genirq: irq_pipeline: fix irq flow handling with
 stacked irqchips
Date: Wed, 20 Sep 2023 10:49:09 +0200
In-reply-to: <MN2PR11MB4285BA242B77C4256CBFC02DF2FAA@MN2PR11MB4285.namprd11.prod.outlook.com>
Message-ID: <87wmwl6wcz.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


"Chen, Hongzhan" <hongzhan.chen@intel.com> writes:

> I cannot reproduce the irq storm issue now after applying the patch. The patch works. 
> But I have one question.  For the cascaded irq like the one we found the issue, actually
> we already were in do_inband_irq to play the logged  fasteoi_irq.
> Why we still force to delay it via calling handle_oob_irq  in handle_edge_irq  but do not 
> play it on the spot in the stack of handle_edge_irq? Actually, it is in code
> path that can be preemted. Even playing it on the spot without forcing to delay it may not
> influence RT latency. What the benefit we can get from such implementation?
> Thanks for you sharing in advance.
>

Stack consumption, otherwise the amount of kernel stack space required
for handling an event would depend on the number of irqchips in the
chain, which would be a problem. Going through the interrupt log for
non-critical in-band irqs flattens the call stack.

-- 
Philippe.
