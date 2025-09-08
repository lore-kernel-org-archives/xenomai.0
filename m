Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78B30C367
	for <xenomai@lists.linux.dev>; Mon,  8 Sep 2025 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339681; cv=none; b=IJJH/alYiWuEtsxNtBNrFwRHcDRlx1JHOfT7M1V9rxAq27I76C+2r3VY4xMnIv0nPPJbdHCiwsKCy/rF5dYNWA0lVmopgqON14wbG4c6p1yUTsWDDE4lwHKJvxVV/MpIk/MkEhGTmxmwfXPd2YrAtHekO9y/lR7y17qMZx+9STM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339681; c=relaxed/simple;
	bh=nEt7GKoqACz2cBtSRBTG0H198xlGRn6WsRryaI8vBXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hdoNz4354LME/QQ9xAReIwOoqbAwyTwzJW/SmNllACBkFHU0uHwpxdFwtCitbqTM4n7KxAd8KIcGKeNoweKMUjRAo/FXIMmYIDlt51JdbjEOT7QDC909IEo5WAl0THg3UlcElEKgUyePZF39ciqKgpxUqzL/5SbsB3oYH/11x5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=MBHGBdJg; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="MBHGBdJg"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7236A4399D;
	Mon,  8 Sep 2025 13:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1757339671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DKAg87erqx4ShAfGovktvNVACyR0DasUviRUNxByMjk=;
	b=MBHGBdJgxDqc5jmc0Q/1NOXAKIEMFEC4/ZEWeIRgRRa9yn/0rJj+yNnPvZOBJKKFBDFf7y
	Bl/Du3bREYOVqbNeUJ4DvD6JBXscNpKn2RLRoxAcoJoetZo722EFc6zgcCbB6B92cZXFBL
	QACFn0j4Keg8nObP1Z/tG5KGv5bVpzCBKvdnVfCX1EUBI5btRa1IoWmWJpgWIGTFLHdxR4
	sAFLuteod9J9bklgOhESZOHOGySYyMKtcUlF66HvPMzC/REqF58ZWqMrw4KyjOt88Pz02+
	Szk435OU8xiQwVou6K9ejZEpqiaGmdG7C37qmxjgCerZWWwuiP7+/g9EfMT4Og==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [RFC Dovetail 6.16]: Lockdep warning, IRQ while holding
 pci_config_lock
In-Reply-To: <2d7bbdc839cb0f78ddb979b35d491a8f4fb9d0c8.camel@siemens.com>
	(Florian Bezdeka's message of "Mon, 08 Sep 2025 15:35:43 +0200")
References: <2d7bbdc839cb0f78ddb979b35d491a8f4fb9d0c8.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 08 Sep 2025 15:54:31 +0200
Message-ID: <87a53582y0.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> from time to time I can see the following lockdep warning when testing
> on qemu.
>
> I'm not sure if my interpretation is correct. Should we convert
> pci_config_lock into a hard_spin_lock_t?
>

No, we can't convert this lock. This would be a massive trauma, both
with respect to the PCI locking model and latency figures.

-- 
Philippe.
