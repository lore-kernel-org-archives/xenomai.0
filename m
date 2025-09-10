Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2001308F34
	for <xenomai@lists.linux.dev>; Wed, 10 Sep 2025 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757488935; cv=none; b=jVOI8ImwOJoPpDC6FVwdppxnHGyww5jJd8oWAxRfGl0iAwW0jMVEHfEnlUxlcsPnK7YwrQyGTV3tJJoSd1P0P3XLBw8/XvCyUvfkvTFHmRsQVOUncQbuiyMGvpcev1Ds8KW4wu8cA0yswwML0jmj0fF2IZBq/vHWcSf8V7BKm/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757488935; c=relaxed/simple;
	bh=jGG3KhL1i0Hus5hq6UYsfPLHWQyo8F+ZfTW78M61XP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cyhtgcxcjh3dFgZ7AsFhoc2nbmtl6JD0xzND1aC4lhsfde4aysCEXZ3luQbvSfkS9ybKiQOiIhor1DSHckunMX0qQ7pWYItRHSGOi4ytz3AWgy7uTdqu925enKJoUoTz/SBmjUA7CJxeKIqP6WeBDoNJhW6Nh38kTen3bQcv0HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=GOIrAERk; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="GOIrAERk"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7537843A68;
	Wed, 10 Sep 2025 07:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1757488924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBWV7SsxwwsrvX6+bATb70RQz005K6pFe2DYx1FV+qI=;
	b=GOIrAERkGXqZ+wErq8omjHTzPZqusvK3RhnoPEbAlQp4CSvtNb0xo5N0sTPRQ2B7kI8r9P
	5nnF5ifxPE09uEu4gI76p5wUTtv3uwVTCYHsBmmJjrtz+x+kEe65X1+y3vHLJGbxoEHsU9
	WSWCvYmW1cR8ITPMIyFYQqF/acWFYwxx/sJ4d3rmy2OF2PDQOPgNr0FN3kbyeb3DxIMIeA
	RnAMa2lvDZ1GI7kWC8wfuwApTLMW7tJ/gvjyzI/pSdEiHJpsB1FIz2YUqTmG32yXCJ/ZxK
	+frUo1jDSo3zDTW270zA9KYnzta64PuX2xTb3vyLftPBycplHl17N3IzW5NRxA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [RFC Dovetail 6.16]: Lockdep warning, IRQ while holding
 pci_config_lock
In-Reply-To: <40bf171b01249a27dca7cf550df09d555235a65c.camel@siemens.com>
	(Florian Bezdeka's message of "Tue, 09 Sep 2025 16:04:20 +0200")
References: <2d7bbdc839cb0f78ddb979b35d491a8f4fb9d0c8.camel@siemens.com>
	<87a53582y0.fsf@xenomai.org> <871poh82tx.fsf@xenomai.org>
	<87v7lt6npv.fsf@xenomai.org>
	<40bf171b01249a27dca7cf550df09d555235a65c.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 10 Sep 2025 09:22:00 +0200
Message-ID: <871poezs9z.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeevgedujeehtdehiefhleefffelffeliedtlefglefhudehvddtleejkeetgeehhfenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Mon, 2025-09-08 at 16:08 +0200, Philippe Gerum wrote:
>> However, that one should be turned into an hybrid lock. Not nice because
>> then we are going to disable hard irqs while fiddling with CPU masks,
>> but this would happen at irq startup exclusively. This said, that hidden
>> global lock looks pretty weird.
>>=20
>> int irq_setup_affinity(struct irq_desc *desc)
>> {
>> 	struct cpumask *set =3D irq_default_affinity;
>> 	int node =3D irq_desc_get_node(desc);
>>=20
>> 	static DEFINE_RAW_SPINLOCK(mask_lock);
>
> Two questions:=C2=A0
>
> - How would I technically do that? There is no
>   DEFINE_HYBRID_SPINLOCK(). Right?
>   hybrid_spin_lock_init()?
>

This is called DEFINE_MUTABLE_SPINLOCK, needs a rename to
DEFINE_HYBRID_SPINLOCK.


> - Seems I'm missing something... Why would a migration to a hybrid
>   lock help in that case? irq_setup_affinity() should not be called
>   from pipeline entry code. With the migration done, we would disable
>   hard IRQs, but that does not protect us from a remote CPU entering
>   a code path where the reported locks are involved.
>

Sorry for being unclear, this change is not aimed at fixing the lockdep
report, it is an opportunistic fix aimed at disabling both irqs and
inband preemption altogether, which is related to the problematic
mask_lock. Actually, looking at the backtraces, I'm unsure this locking
issue is introduced by Dovetail.

> FYI: This is the last issue that I plan to address before finally
> posting the hyper-v stuff. After that I could look into the forward
> port to 6.17.

Ok.

--=20
Philippe.
