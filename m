Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AB51E0DD8
	for <xenomai@lists.linux.dev>; Tue, 30 Sep 2025 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218771; cv=none; b=rQdGElzbR1z1E+IcaxfTyz1yEY+eYL9HBwDONwuhZuTNd/sPJ2SMxUcgb47c/AaA0hSGteLyTEbdTZehDfBRSBrbrdEi2shDbDCa9BKlrO6ft8lRqt8lHngAwMG6bXFQZt9ZhDpOrjCa/7vzxpV09c1SxhmzxjskawFpbNFFblQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218771; c=relaxed/simple;
	bh=bTatXzhjH5K2PvBnSqUnFqFzD5EsySC5Nuhptr+dzkM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cF/UTtbK4+QZHsgnWq9WUKu6d96nV44h98htMx7K7i2fKuGbgBJX91U9wEy+8wdG2wRDJdKu47Z6JrutiTQYlJmjP8xuu/nT6G6x9wmC7vUJF28tbmJYgCzAmVUtyPLIScHHvRgieSJC6/ag5+8wdZtwA9oOrMRyiNZWzwvJd78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=WLaKhqgJ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="WLaKhqgJ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA4694445E;
	Tue, 30 Sep 2025 07:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1759218761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hAp5OTGdEykte/v3EfKcCv+b+jZmKWxv3LwUP5cugzg=;
	b=WLaKhqgJ2b/rWXRGtCDZnvhQbbVT5gk8DpDIRaYFMDrHTtt3NFdEntb/u+EL5Cu4FhVcqR
	zfNpuYIVfyOIProPfHptEqHNYYMUBmy0ChQ0SGBPfQ+iOBYb7bqluMl8tyidcjG4tCw1fv
	DpUSp8BX52rq/PcLF2UDGTr2Vi6oscldKV4HR0x0LPZxFOX/wG4rlgjh9+Y4OnrN4iu1r8
	ZpC/JrG8TYgjts+hyUztwFMZoZo839C3UHSOckjo6G3cMZE9aAB1EGQnEbwEampz+1LZYE
	6EPmdMBDxfIBqik6PpJpRwcS0CakvMQMzNcuHX7S7CffSOL0qR9HVb3jwl6tjw==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH RFC Dovetail 6.16 5/5] kernel/irq/chip: Do not call low
 level irq chip hooks directly
In-Reply-To: <689eb39d04f64799e522453da752d0c367217b62.camel@siemens.com>
	(Florian Bezdeka's message of "Mon, 29 Sep 2025 23:15:00 +0200")
References: <20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
	<20250925-wip-flo-cleanups-based-on-6-16-v1-5-8c4ac7b52cd8@siemens.com>
	<87bjmvro65.fsf@xenomai.org>
	<689eb39d04f64799e522453da752d0c367217b62.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 30 Sep 2025 09:52:36 +0200
Message-ID: <874iskxtq3.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdektdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Sun, 2025-09-28 at 10:12 +0200, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > irq_mask() and irq_unmask() are tracking a software IRQ state that
>> > might run out of sync when bypassing them.
>> > 
>> > No functional change.
>> > 
>> 
>> Actually, there is. Percpu IRQs are not serialized by the desc->lock, so
>> calling mask_irq/unmask_irq in these handlers is unsafe since we may end
>> up flipping bits from the irqd state concurrently on multiple CPUs for
>> the same descriptor. This is the reason why masking/unmasking was
>> open-coded there.  This patch typically breaks my kvm/arm64 fixture at
>> boot, not observed on kvm/x86 so far though.
>> 
>
> I clearly missed the serialization part. Wondering why this did not
> trigger on any board / kvm test...
>
> Anyway, it's clear that this patch should be dropped.
>
> Do you want me to resend the series with 5/5 dropped?
>

No need for this. I'll pick the rest of the series directly. Thanks.

-- 
Philippe.
