Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A70C4A33
	for <xenomai@lists.linux.dev>; Mon,  8 Sep 2025 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339822; cv=none; b=tpNJ+pdg/a7MJIcPx0bdkLhvKdQc8MXh/NhAxWqTqrmRJHN3xRhiFmbl4Qqeb82w1FOvIljuVLlxD4jkqDJmHsSO4Xh2cn5B0AEc9n2r90SXiYA9Y8wQwlCqZuOpN44CqiOQBXVGIYyAbGQA1jNxoXE6lqk+GUqhtbsGj+C4Kv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339822; c=relaxed/simple;
	bh=kCV30dBfGGj+qizPbAVyMrrqYG8WkMODhk9dwkcURxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VwRcytS9pxjN4yzct1k16FE2wNbpaH9BMGQXLGHSAOG+3jCBlVRsGg8fVYwzMLWAetEt60FHe0RcmuayMczis1hPAU9J5dhd5aLjNchUtZna7UfS/eFAAwxEiFdnDgSRiX5vu0PGyOwjF95CgWwCkyEgN/jL3n+HdaCqmiGbTM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=l9Q4Agqf; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="l9Q4Agqf"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C26CA432D6;
	Mon,  8 Sep 2025 13:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1757339818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=auLAxrT2TSSfFM4CsXv9w6nKv5CEnlRZZfJ51K0pois=;
	b=l9Q4Agqfph4KgiWgdznI9jnMkscqoeFMK/cfa+sBEHvn3FL1YJuP1TNpaj+CxHkF3Udbnr
	tFDdCtTs/I5kxIobOBxecjaKszPvLe4x+MNQE1Xx9z8wDK2LRw3Zv+Ye7UtsLWe/pR0Brl
	1p450KZG3KLFSfZ9KNl1CChgQKqFuhY4L7CuSkMw3XbX8uKw+l6Z8vryRuVC4zXbGBM8gG
	NHiqFOm/cl/5OAsbbRVnbvRehuCa8TjVjI36sCoyVdeDSphh7dBuKIhaqYNPHTN6pUiO89
	W1WPbloUuPMomVVpgafAFRFS2JdbUMxqgO/SMWClwKMmqZOADxWYfBwOrI/i3w==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [RFC Dovetail 6.16]: Lockdep warning, IRQ while holding
 pci_config_lock
In-Reply-To: <87a53582y0.fsf@xenomai.org> (Philippe Gerum's message of "Mon,
	08 Sep 2025 15:54:31 +0200")
References: <2d7bbdc839cb0f78ddb979b35d491a8f4fb9d0c8.camel@siemens.com>
	<87a53582y0.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 08 Sep 2025 15:56:58 +0200
Message-ID: <871poh82tx.fsf@xenomai.org>
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

Philippe Gerum <rpm@xenomai.org> writes:

> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>
>> Hi Philippe,
>>
>> from time to time I can see the following lockdep warning when testing
>> on qemu.
>>
>> I'm not sure if my interpretation is correct. Should we convert
>> pci_config_lock into a hard_spin_lock_t?
>>
>
> No, we can't convert this lock. This would be a massive trauma, both
> with respect to the PCI locking model and latency figures.

Besides, that would not fix the core issue since the deadlock would
still be there, and lockdep would still notice anyway (Dovetail locks
are lockdep-tracked too).

-- 
Philippe.
