Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1398460
	for <xenomai@lists.linux.dev>; Sat, 13 Sep 2025 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757775399; cv=none; b=crYJ9hjoVOVMqnHoYoMLc7DvBy4nKW7K7Lhijag5bDw+tPfp0tZskifi0Hy4A9WL+X4yG4ML2b9lyY7PlPK0TDQDg0QiURwyHjcExqmEmn1AFDsqxo7l3kcZon+/q2aP9vtCFU52HMHVZR3Ll+efMn1foHg+v77acbsZ2FPD2lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757775399; c=relaxed/simple;
	bh=Hm4zN27ziki6n+4vh0/2HoskJ6PY5RF8FqSSNDkqtf0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wq7MuKp4dFheiIq/JS57KaXZo4Kf1H2e2Aa/DKQ1IxhS7eGHVTnXabXITID06rTFX7JzDjnrwAAlvE6uwy7QaXAjl+qcPQZpGDYti0XwUDu9ok862kctt96lgZ1KAi8MHmGjIGr5IL3zTy8IwxW4b2z5HAlv3N3o1dAK2YuqQXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=pL2b1Iqw; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="pL2b1Iqw"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 985CB43B46;
	Sat, 13 Sep 2025 14:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1757775388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W8ffZDXRqF3us5qrNmG+9OVDIeK1BQ803Xg7EhND2ok=;
	b=pL2b1IqwwsPZbf5Mw8y/M1gDL1gVudN3qUm+jP0dZQrCu/8JIpDT3YPBw1IkCRRMU+bMlw
	NQea5eek/lPAnovFh4M9pOfMd9qBVF5bHrrIulSoXuUBirhOxrMi21815a5tiulg3hs0aD
	kRxc56WNEtaRv7Ji4OKaHhMbRc0QGycTu4+RLm8i/IROREV92crLaTyaon+3Y1C/jD2aOn
	E/7lPklbIz06v78b6a+eGufoa+5TOXkxuPITFmR9gTyXK1RWNSJXa2sJ5ElY2K/yBFN1e/
	L3Ymhu5t2tiVbWVoywRfu81xygQCcVGYS587eZqUNbFuYhFPdQoJhIxJni003Q==
From: Philippe Gerum <rpm@xenomai.org>
To: "Xie, Nick" <nick.xie@festo.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Error during libevl build and runtime settings failed
In-Reply-To: <AS8PR03MB100561B2E374D4680213E55DD8B09A@AS8PR03MB10056.eurprd03.prod.outlook.com>
	(Nick Xie's message of "Thu, 11 Sep 2025 17:14:51 +0000")
References: <AM5PR03MB2882F5ED2ADBA37FAA9562608B7DA@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<AM5PR03MB2882F38E95A99A0760C60D1F8B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<AM5PR03MB2882726DD078E29EB76589518B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<878qk3za1e.fsf@xenomai.org>
	<AS8PR03MB10056F9D6FBDE93A148E03F5A8B0EA@AS8PR03MB10056.eurprd03.prod.outlook.com>
	<878qimxczv.fsf@xenomai.org>
	<AS8PR03MB100561B2E374D4680213E55DD8B09A@AS8PR03MB10056.eurprd03.prod.outlook.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 13 Sep 2025 16:56:28 +0200
Message-ID: <87plbuz9ib.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefvddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehnihgtkhdrgihivgesfhgvshhtohdrtghomh
X-GND-Sasl: rpm@xenomai.org

"Xie, Nick" <nick.xie@festo.com> writes:

> Hi Philippe,
>
> Thank you for your response. I tried to enable the console output in grub setup, but nothing is showed and it stuck at the same place. 
>
> You mentioned booting over a ramdisk inherited from some
> distro-specific boot setup builder is discouraged. It reminded me that
> the first time I run " sudo make modules_install install ". It failed
> and reported as below. I have to enable "support initial ramdisk/ramfs
> compressed using gzip and zstd option under general setup" to get the
> install done. This is very different from my previous build. I have
> never need to do this. I would redo everything from the beginning and
> see any different. Is 6.12 the correct version I can use with new
> libevl? Do you have other through? Please advise.
>

6.12 is the latest LTS supported by evl, so yes, this may be a good
choice in your case. The grub installation issues you are seeing are not
related to evl which has no influence on the aspects you mentioned, you
would have the same with a plain stock linux kernel. You may want to
refer to other online resources explaining how to build and install a
mainline kernel in place of the one shipped by your linux
distro.

In the early stage of bringing up your target system, you may want to
disable CONFIG_EVL, CONFIG_DOVETAIL and CONFIG_IRQ_PIPELINE options in
your Kconfig, until you get a v6.12 kernel properly booting your box, in
order to rule out any issue with evl.

Once this kernel boots with a working console in order to get the
information you need to progress, then you could enable these options
back one by one in reverse order, discussing on this mailing list any
issue observed while doing so.

-- 
Philippe.
