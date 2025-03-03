Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904AE78F39
	for <xenomai@lists.linux.dev>; Mon,  3 Mar 2025 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011928; cv=none; b=LgtMLSUfxyNHbB1hc0tdrDh6xAggt7zoxr6z4EkKEIL6dVZjtIDfv2K8GW04cH19Xa8lXpXNlBMA0fGzarW5vmqEyg8Pjqx5QGnWQUW14V3MH7aGi8d7BlMdCSll3qVIG0miCW4Rr4umooCdAIqdhtPyVLAHmN3LgPUrDAbp8AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011928; c=relaxed/simple;
	bh=0Wt4bm52JXJ4xsCPup8W7nM+DCBbWsXRduFM+cQ7UmE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=StdFEfMFDidkVzE5saFgwdEYMelQusE9F152xrJHScsjLS9hNNVHG1SesGSGTRf/+fYA7Qx6h1+Q9VceDKPvUxFcPTGe3duucS2bNZlWBc5YKYoLyHziVNufrw+jfMDCsYcVoeBFvR4C7kqRdoTAcu4BmtUKu5+ZLlsQ6DXbisc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=mH7juk25; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="mH7juk25"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 46445442E2;
	Mon,  3 Mar 2025 14:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1741011923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qdz6jIYHO5fmJf3AZoNr6ayb+2t4f535S2ONa+csxKE=;
	b=mH7juk25jqr4QUlT/fmL+h3eE9LHlawTjlaVtXaCDijj7IDrVuMs/u3pngsn86VqAKWq2T
	s5w9mJLMFanblo1TXt6+bOY/XF5xIaBivV1w6cERomgaGO3q/5zwyWm7iRvb9NGXjV5WDn
	crBiYrHTbJiZ1z+sUnqdMYz3nutFMwmBWQLfXqdjgFEuUgGwCdg2Xku6WaSXmrkcQ3WZqE
	nxxXoi+lnDKBzOpQBMUeae2D/AFVCzVyjx+/xA5s0H4c/1XnP/sAzWmmw/yaZpKpt7/mql
	UQ7xFc/M4grUE6IjG54lEwosPCvuMHmKqmQJd65RmQKGATErn+9a2OL1DrK3Zw==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [Dovetail] v6.14: fix up to oob page pool
In-Reply-To: <3f7587adac06cf5384e763c364baa55733d3ced4.camel@siemens.com>
	(Florian Bezdeka's message of "Mon, 03 Mar 2025 15:19:58 +0100")
References: <87ldtm2ogz.fsf@xenomai.org>
	<3f7587adac06cf5384e763c364baa55733d3ced4.camel@siemens.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Mar 2025 15:25:22 +0100
Message-ID: <87frju2nu5.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Mon, 2025-03-03 at 15:11 +0100, Philippe Gerum wrote:
>> Hi Florian,
>> 
>> For some reason, the hunk below disappeared from the Dovetail v6.13 code
>> when rebasing on v6.14-rc, this causes a crash at boot when
>> CONFIG_PAGE_POOL_OOB is turned on. This fix up should be merged to:
>> 
>> e4ecbcc40e7e6 net: dovetail: add infrastructure for oob device I/O
>> 
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index 7860c3a88c5d2..07ad13dd5ed2e 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -563,7 +563,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
>>  		return pool->alloc.cache[--pool->alloc.count];
>>  
>>  	/* Mark empty alloc.cache slots "empty" for alloc_pages_bulk */
>> -	memset(&pool->alloc.cache, 0, sizeof(void *) * bulk);
>> +	memset(pool->alloc.cache, 0, sizeof(void *) * bulk);
>>  
>>  	nr_pages = alloc_pages_bulk_node(gfp, pool->p.nid, bulk,
>>  					 (struct page **)pool->alloc.cache);
>> 
>
> I will take care of that. I'm currently rebasing on top of 6.14-rc5.

Ok. Meanwhile, I'm preparing a patch to fix the hard irq context
detection (inverted test of IRQS_DEFERRED). We need to have that one as
a separate patch for backporting.

-- 
Philippe.
