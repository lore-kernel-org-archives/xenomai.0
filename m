Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B55137932
	for <xenomai@lists.linux.dev>; Sun, 28 Sep 2025 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759047693; cv=none; b=dK4ZbZH7v3a7Jda4Jlbp3LKiBnghK2007fRYPt+BZnTI+hnW59BCvrDe4saDg0VISHn5Qcd/TaHzIUCN6TGqlLGDHIbnZ6k43RxjyxbsVuox/aZNqDWpHGBkbIUzATm/A+QekD8X7VNDEovPdBX0akEvCB3bd86C4voonasGELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759047693; c=relaxed/simple;
	bh=zlUlCNjPPun8t7qsA2KY4mmrSjLUmMeLFkJLcb7ZmPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bV0zZGAXg8I2OWcDbpmLlRSc3cMVsoS9t/O5xcfYWaUWCpnsqmitE/3gLa4D8yt51Icmeal+nyrXULJpPQM81hFVVw61UQZ54rrjyckx3gQaiXkCCywbe8O5OQDGg7xejE4fycWGOEdNx3g/8FtDtQ40TKe3eJzifvQz4Deb4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=LtFVQgWn; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="LtFVQgWn"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 45D6C431F0;
	Sun, 28 Sep 2025 08:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1759047689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/e5rvx73d0K/Z/JVt8VkbDrxX6f0jOz5/1wc+bOpJjw=;
	b=LtFVQgWnv4Lu2lDAz6QNSYAkKXHMrVaF8KV9iHaPpRCN6NbtR0ipgQ9+6L3CLMevvpSaWn
	CjVWLpDlB/Ef0IGpwBmp/s98Ygb2m3G04uMruxBPwx+gbWu6rq2PrtbBbtbGhTlL45fv+k
	6xPnTKqAzntgsFZdEKFxhBcEfiTqWfjQ8QN/H1aMr9AtI8jKAjiW1eMh4pzTSQ4W72peRo
	wmC6l3PiDGuHFG1AF4slebtxZ3opreqMwcdCozgNOZuCH7XlrfDvzVFKieHaCbsCSfeCQh
	jYnmnDdaE05mE5PBKD/sDaAI118bGTQgs3omjXUNiLen/dooENDBYPRWjp8YoQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH RFC Dovetail 6.16 5/5] kernel/irq/chip: Do not call low
 level irq chip hooks directly
In-Reply-To: <87bjmvro65.fsf@xenomai.org> (Philippe Gerum's message of "Sun,
	28 Sep 2025 10:12:18 +0200")
References: <20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
	<20250925-wip-flo-cleanups-based-on-6-16-v1-5-8c4ac7b52cd8@siemens.com>
	<87bjmvro65.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 28 Sep 2025 10:21:27 +0200
Message-ID: <875xd3rnqw.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejgeeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Philippe Gerum <rpm@xenomai.org> writes:

> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>
>> irq_mask() and irq_unmask() are tracking a software IRQ state that
>> might run out of sync when bypassing them.
>>
>> No functional change.
>>
>
> Actually, there is. Percpu IRQs are not serialized by the desc->lock, so
> calling mask_irq/unmask_irq in these handlers is unsafe since we may end
> up flipping bits from the irqd state concurrently on multiple CPUs for
> the same descriptor. This is the reason why masking/unmasking was
> open-coded there.  This patch typically breaks my kvm/arm64 fixture at
> boot, not observed on kvm/x86 so far though.

With respect to the IRQ state consistency, the logic assumes that the
percpu IRQ is unmasked in the descriptor while its handler runs, so not
mirroring the hardware state into the irqd state word is correct.

-- 
Philippe.
