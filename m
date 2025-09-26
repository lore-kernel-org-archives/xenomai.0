Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C401EDA02
	for <xenomai@lists.linux.dev>; Fri, 26 Sep 2025 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758872061; cv=none; b=e77ua3c6t7OwEH+RhloUqOi13yhsXCdB7i8ZbimWbCAK9y4yMqZVvY2jBYTI655ldoEohcrTb6UeGpAF/VUjZHWMhx1sG+IoUmVQEH0oAwUfcjEq52npLEBKEgQiJcxYTDOUq2wMh4eUpFlfmp1M6pZGjQ/uQpK6yvWcAyLm11o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758872061; c=relaxed/simple;
	bh=pVOGXgws5Xtenx09au1uqq27dCaziIaOJkWvBuTopls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JejE0GtFcJ7weeg3zjN9ul9Uz9FO71NkdZQQZh65IzCq98OXE1quxA+r6XrAijrcw6eInwYaTbNUXyMR53wZ6IWzuLwOmNWay6m9ezf3DqlSEnjwrBaLXRpqT9fGVeD2bwrL5ZZxzuRqUMXJfR7MYNqxkIPYo2OtFz65mmwRh4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=BrZ8gCzr; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="BrZ8gCzr"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id B198D58238E
	for <xenomai@lists.linux.dev>; Fri, 26 Sep 2025 07:24:02 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BB3CA44386;
	Fri, 26 Sep 2025 07:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1758871435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+jwoZb7NK7qRYq1yRbUiLToBbRr1IRofrMQAGBzfmR8=;
	b=BrZ8gCzrA68LsQC54FuQsMl66XThYpUqyPlnuApg76AvhugRDTGdkLfFtiL3RRzYzUQ/iX
	hqwEhoJ3VRVWlGa5p2lvdqvSs7tz6mIkzBKKPu5I/O/HUc5byVkEjJqJy32WSASMysXN0z
	aIQWKJz9uTgeTfyg4qbESmyJrCNa/x/7dEV3S3MXRDGt9l3X0FJhoJ59PPq66wIghc0gY8
	duJbT4EOia19R/cRWUukAPqDZ8uTuG0UHY6Jg4GE73NgftDMIvWR3pSBz/Eoi+3jWg3Xaw
	u0iGknLoOuuJt7T5hWPRTfFhizUoCkXIJHsYAQgPC8nS+8fLl/VtzKFvBmwdyA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH RFC Dovetail 6.16 2/2] genirq: irq_pipeline: Migrate
 mask_lock to a hybrid spinlock
In-Reply-To: <20250924-wip-flo-fix-lockdep-warning-for-6-16-v1-2-8a8475e2cdc0@siemens.com>
	(Florian Bezdeka's message of "Wed, 24 Sep 2025 23:23:15 +0200")
References: <20250924-wip-flo-fix-lockdep-warning-for-6-16-v1-0-8a8475e2cdc0@siemens.com>
	<20250924-wip-flo-fix-lockdep-warning-for-6-16-v1-2-8a8475e2cdc0@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 26 Sep 2025 09:23:49 +0200
Message-ID: <875xd5ismy.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeikeejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> The reason for the migration is the lockdep report below.
>
> The irq_desc_lock_class is the dovetail specific hybrid spinlock.
> pci_config_lock and mask_lock are both raw spinlocks.
>
> The behaviour of the pci_config_lock is different on kernels with
> IRQ pipelining enabled. While on plain Linux the critical section
> is entered with hard IRQs disabled, the inband stage is stalled with
> hard IRQs enabled on CONFIG_IRQ_PIPELINE. This is the reason why the
> pipeline entry code may still run on the same CPU and grab a
> (hybrid) IRQ descriptor lock.
>
> The critical section protected by the mask_lock was always entered
> with hard IRQs on.
>
> To break the cycle we migrate the mask_lock to a hybrid spinlock.
> This lock is only grabbed for IRQ setup. It's expected to have the
> lowest RT impact.
>
> irq_setup_affinity() is expected to be called from the inband stage
> only, so we will now enter the critical section with hard IRQs
> disabled. With that the pipeline entry code is locked out, breaking
> the cyclic lock dependency.
>

LGTM.

-- 
Philippe.
