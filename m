Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3201719D8A8
	for <xenomai@lists.linux.dev>; Mon,  8 Sep 2025 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340528; cv=none; b=pKdvwNcUdNnx7iXtHE3meofiBQyyh2y5bt7JxElJ4BbFqDwwcHF6H+OpRkJH3y3t67UlA7yGOMy7suqrqtEwMZmFkh3k1YP0/qUdaAHp53RJ30HDulFix8QKTALSH0U7kbutpJ7LmQ/yqVO6kamya0Hj9Dfqozel7BWwP/cKw/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340528; c=relaxed/simple;
	bh=DZ0VTLNyCJKQHQuN6apnUmgWZEj8MOmhZbpLA43BRrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oasXdWkUmODzR2xu2egbZohSCtpJZ6xOABKZr8MwvfKDfXrvDGsOYy0g+h8xY1NT+6Zf2VGZg+CKQmKHx7nBaf3ZCKu0uvVIQQLqVgclQ0oO8VJiabpW/vWyuSmNscBM3/slmvSZeMhs0poRjrM7+HiTA8jbk4v0dg+0jjjH7cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=eLBVZv6y; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="eLBVZv6y"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 65AE443426;
	Mon,  8 Sep 2025 14:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1757340524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ySj5iitqcxxLii0aQhUwkxiN363BbyGFTEIaXw2s8xI=;
	b=eLBVZv6ylzIQl6USWT3UNM0y8rIhKbWHpFxMF46gJy+zVZJqtVNlC9Jb/Bt53bwZWwWGiI
	rgXv9sbAkL+8NsQ+sbnRWCubjJf/Sirm95Rmznz9d0pz41Fffdu80iXCfDEgtiodUkbeQi
	S8OmYfezo6rRtWrAcNvUvF2zUaismIPBqKAJCn/RpE1g/Z5vo29uqGe/Gh7DN7Nnzbuyjb
	Rn8hdoHLJboQadrG8F2YMbdrJWVyfXdDNygPcZ0lceWZMv/GqLDLngNeiUJsMzpEdCK8X3
	OkYHC74TUGXkgnRJcvAz4TV7FBVVF4QayF+GTyJVa8aWSsHQWKHIdGGHOr0WkQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [RFC Dovetail 6.16]: Lockdep warning, IRQ while holding
 pci_config_lock
In-Reply-To: <871poh82tx.fsf@xenomai.org> (Philippe Gerum's message of "Mon,
	08 Sep 2025 15:56:58 +0200")
References: <2d7bbdc839cb0f78ddb979b35d491a8f4fb9d0c8.camel@siemens.com>
	<87a53582y0.fsf@xenomai.org> <871poh82tx.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 08 Sep 2025 16:08:44 +0200
Message-ID: <87v7lt6npv.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Philippe Gerum <rpm@xenomai.org> writes:

> Philippe Gerum <rpm@xenomai.org> writes:
>
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>
>>> Hi Philippe,
>>>
>>> from time to time I can see the following lockdep warning when testing
>>> on qemu.
>>>
>>> I'm not sure if my interpretation is correct. Should we convert
>>> pci_config_lock into a hard_spin_lock_t?
>>>
>>
>> No, we can't convert this lock. This would be a massive trauma, both
>> with respect to the PCI locking model and latency figures.
>
> Besides, that would not fix the core issue since the deadlock would
> still be there, and lockdep would still notice anyway (Dovetail locks
> are lockdep-tracked too).

However, that one should be turned into an hybrid lock. Not nice because
then we are going to disable hard irqs while fiddling with CPU masks,
but this would happen at irq startup exclusively. This said, that hidden
global lock looks pretty weird.

int irq_setup_affinity(struct irq_desc *desc)
{
	struct cpumask *set = irq_default_affinity;
	int node = irq_desc_get_node(desc);

	static DEFINE_RAW_SPINLOCK(mask_lock);

-- 
Philippe.
