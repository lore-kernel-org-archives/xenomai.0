Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2412BE7BE
	for <xenomai@lists.linux.dev>; Sun, 28 Sep 2025 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759062335; cv=none; b=AcSb620i/oN8r3E5cZ6rTwJ1D2BMplWM+W4hoUD/FJm3909CUNeonNS3a+0FFDPf4+Sv5VlIXMyZeGyIFY5PiI+1LMYrmRmUMTOJrzKWLQEsD9aAhGGvLjpVS6b5c67oKPwfRlLkYbkWpx1nVxP8NP5dFAQhXkX15Al+IIVzrPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759062335; c=relaxed/simple;
	bh=BfAO41AuYY0Wq9P121Mgbpl44wbiYXiQdGD39UUF+YE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uGaf4oB5WVGM6lgvBcTvxX5DoMBTrWo4izYh1EK+5QJSH45PX4eSOa/8iXpN56BGNBaSeN9kCu1Zsdz84jmP5XFcjTu9owdDig137/xSDfItKypM8M7WhpJ/Y+zayQiPoZB/JYtMoNq+Kw7t6gOEXUO6XI/pHIDlqcX7KqHNcWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=LvfO9w0F; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="LvfO9w0F"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A572943A30;
	Sun, 28 Sep 2025 12:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1759062329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uLsAzVRy7fllSgDiMoKgBtEJonUlC+oM7AuzdnppDZg=;
	b=LvfO9w0FhrCUeCPC8GXOnLhOQUiWOR5hUqJhUcCXWdENZFnmuOLAy/Zl7XYf8ZulT3mgQp
	OuZnAS8/FErHCpnc+z96/uPiDo3a0ID7QMk2jxCaq5nXesCyoBAhBIGH2Kd7i7qYl/drYD
	O4DQ/Lv6zacCPnjRjezjKEzVDIex+fwP8JwBr5K+XjCjYRYwvM6S2s/BejrHoIl51CyqWE
	BV7QLOIA696QNvimQB+lRTMhH+2pF/7dW0FQoziqkM2SlD4yFdumOR3mA36ZlDEWKFsHhK
	0i9USpZTKg9gSeMWT7a2g6kR5MR6RDvTcqJXX9BpUHJ5p+BHuOObiVQuZE+1EQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH RFC Dovetail 6.16 0/5] Dovetail: Minor cleanups found
 while debugging the pipeline entry code
In-Reply-To: <20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
	(Florian Bezdeka's message of "Thu, 25 Sep 2025 15:05:46 +0200")
References: <20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 28 Sep 2025 14:25:29 +0200
Message-ID: <87qzvqrcg6.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejheduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> this is now the end of my queue. Nothing more pending.
>
> All of that was found / noticed while debugging the pipeline entry code
> some weeks back. Maybe you can scan that and let me know which parts you
> like to have / take.
>
> Cc: Philippe Gerum <rpm@xenomai.org>
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (5):
>       kernel/entry: irq_pipeline: Do not leave .noinstr.text section
>       kernel/irq/chip: Change return value of get_flow_step() to int
>       kernel/irq/chip: Simplify may_start_flow()
>       kernel/irq/chip: Simplify should_feed_pipeline()
>       kernel/irq/chip: Do not call low level irq chip hooks directly
>
>  kernel/entry/common.c |  4 ++--
>  kernel/irq/chip.c     | 29 ++++++++++++-----------------
>  2 files changed, 14 insertions(+), 19 deletions(-)
> ---
> base-commit: 138f1183deed300fd1f03abb6511635a916b98d0
> change-id: 20250925-wip-flo-cleanups-based-on-6-16-89989cc95468
>
> Best regards,

All patches but 5/5 are fine with me.

-- 
Philippe.
