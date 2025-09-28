Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26443225D6
	for <xenomai@lists.linux.dev>; Sun, 28 Sep 2025 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759047151; cv=none; b=mvxdEIoUQPhxzoCazk/BxUmvBksPbM2RPufcnHgbzeWp0J3h8qIaZM2U7jJvyrYZZzVb66nG4wOV895dQWJrx1zIRVl8iQVbOAPg4syvUA99pML2O1WmYw5O34VJiz679f5yFZBWaL4ILgKW66wY7Wi0fdufObrrLD5LDxXJsvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759047151; c=relaxed/simple;
	bh=FKrrN/k2iujU0j6HpcetUMSLIImRbF8R7PlpWkdfha0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oUDyzfq9SFUZWu6TyEalY65OIfUxkzsRYjKdDRCSQ3naHSIB1f6cj9bcKhpfYzKIdor7zSO+EBC+xQYNRQKSbdeKVnnOIsHErd8YoPkPUv6oaz+lQZ1BteSr8QEGKylmGEKZNrLL3kiEqkbPwEww6bVxvYSo+xlQq3jce9+sNcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=WAid0dkd; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="WAid0dkd"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9522742E76;
	Sun, 28 Sep 2025 08:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1759047138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UhNDy3zPvPIB9RTOEVh3krqwRMreaM0g5zih27m0W6Y=;
	b=WAid0dkdqBtiPNPc9hWQFzRBhKURGHAwd9G1dV9SyyPo823Fzo73af1jXDoB2cU4k8bgSt
	klQurbcRxQ1leDYpAvWxU3Hv7zubgURH5x+ws+5KgIo378YqrfMv95fZH6TkiszdRHtADW
	lRuB0RQm9akY0V5vprumhILQtbNhmWmmV/jpWvHsjm8u4L5mYUmCL/qISAWEBF9EuMDP+0
	i9SE6MuL2zTHXZtrXVmy5Ao2dLmhBNIode95nNyWozTs03sbm0fLmgOZvUuM1rXrXVjNj+
	mdLoNU42bJ0DJUpaGofYri9ftyYtN5DS//Fw4HI4qygr/5qK1oQKppU5Fpialw==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH RFC Dovetail 6.16 5/5] kernel/irq/chip: Do not call low
 level irq chip hooks directly
In-Reply-To: <20250925-wip-flo-cleanups-based-on-6-16-v1-5-8c4ac7b52cd8@siemens.com>
	(Florian Bezdeka's message of "Thu, 25 Sep 2025 15:05:51 +0200")
References: <20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
	<20250925-wip-flo-cleanups-based-on-6-16-v1-5-8c4ac7b52cd8@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 28 Sep 2025 10:12:18 +0200
Message-ID: <87bjmvro65.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejgeeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> irq_mask() and irq_unmask() are tracking a software IRQ state that
> might run out of sync when bypassing them.
>
> No functional change.
>

Actually, there is. Percpu IRQs are not serialized by the desc->lock, so
calling mask_irq/unmask_irq in these handlers is unsafe since we may end
up flipping bits from the irqd state concurrently on multiple CPUs for
the same descriptor. This is the reason why masking/unmasking was
open-coded there.  This patch typically breaks my kvm/arm64 fixture at
boot, not observed on kvm/x86 so far though.

-- 
Philippe.
