Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750A1F37CE
	for <xenomai@lists.linux.dev>; Tue,  4 Mar 2025 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082078; cv=none; b=BcWtHgawzAR214ejISb0KSdLAa3ZvpbIyXaxpCsnuJEQInO7I6agqjLMQLXB7Nk2sIEntw3M95hni62lrSaket+9AKMxjpSaSG3FExhjPXwsulkdjKYORL5icDRYEI7HSssNgRgwYeleQNNTAEkhJwb6vJBNOVx+PB85fsZwlZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082078; c=relaxed/simple;
	bh=CAJP+eduj2WI4ZrR3jWVEkBTB/IK5yZfWQnJLXmIcGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UXcbASI8//vk/L7bfCzffNSa8a+L99kBzqef2tHYBjvdYoWQf5FjM0xgMihbHWdawsfyVgHs7G8D306Yc30ePBDb8TUkN3eXpTzD3ooCInYZUZR2zdr9yFmcyIX231b/3EbJLGFebjqCKIePaclCexOX8T/IJBcUa2pDv8qttDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=GkDfeVc9; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="GkDfeVc9"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 92A8620574;
	Tue,  4 Mar 2025 09:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1741082073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W8lP6xNneXECjsLoBg+GpK3jK0c/yVEiNpXxPXEQHfk=;
	b=GkDfeVc9Prtjq3LIeI7pcFB1iLuAlIAZYoUh8e2sfwdeClYzk0hxTlkuicWRISIj5uxLW7
	b9gAditLnU3vjr53BAToX8OXuP5VeeV7EpFPHRATYIre2ipY/dTjBIyO7qS3m5K2b8bhLg
	uxt7RC74rQmgUIPRleeLlX7eAQ/QK89+6loqT6ZXaKvuw5ABb0AyFPJcrG50UCsADBTar9
	v7wLH0d7DrZzK4KFhqxz23SpcsZcgE5kUvx5UXauCT5ggXsens06Ple1RDO56JPDn0rU3e
	HxeSEYcJ5KoaX4iBLAjw2RAzWX6yjOMeF0M0YDp0zNXCGYS5viAV+zB91BT3EQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [Dovetail] v6.14: fix up to oob page pool
In-Reply-To: <e748f601bc89d5040995809850c8a8f00c82defa.camel@siemens.com>
	(Florian Bezdeka's message of "Mon, 03 Mar 2025 15:44:03 +0100")
References: <87ldtm2ogz.fsf@xenomai.org>
	<3f7587adac06cf5384e763c364baa55733d3ced4.camel@siemens.com>
	<87frju2nu5.fsf@xenomai.org>
	<e748f601bc89d5040995809850c8a8f00c82defa.camel@siemens.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 04 Mar 2025 10:54:13 +0100
Message-ID: <87mse1unne.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddujedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Mon, 2025-03-03 at 15:25 +0100, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > On Mon, 2025-03-03 at 15:11 +0100, Philippe Gerum wrote:
>> > > Hi Florian,
>> > > 
>> > > For some reason, the hunk below disappeared from the Dovetail v6.13 code
>> > > when rebasing on v6.14-rc, this causes a crash at boot when
>> > > CONFIG_PAGE_POOL_OOB is turned on. This fix up should be merged to:
>> > > 
>> > > e4ecbcc40e7e6 net: dovetail: add infrastructure for oob device I/O
>> > > 
>> > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> > > index 7860c3a88c5d2..07ad13dd5ed2e 100644
>> > > --- a/net/core/page_pool.c
>> > > +++ b/net/core/page_pool.c
>> > > @@ -563,7 +563,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
>> > >  		return pool->alloc.cache[--pool->alloc.count];
>> > >  
>> > >  	/* Mark empty alloc.cache slots "empty" for alloc_pages_bulk */
>> > > -	memset(&pool->alloc.cache, 0, sizeof(void *) * bulk);
>> > > +	memset(pool->alloc.cache, 0, sizeof(void *) * bulk);
>> > >  
>> > >  	nr_pages = alloc_pages_bulk_node(gfp, pool->p.nid, bulk,
>> > >  					 (struct page **)pool->alloc.cache);
>> > > 
>> > 
>> > I will take care of that. I'm currently rebasing on top of 6.14-rc5.
>> 
>> Ok. Meanwhile, I'm preparing a patch to fix the hard irq context
>> detection (inverted test of IRQS_DEFERRED). We need to have that one as
>> a separate patch for backporting.
>> 
>
> wip/v6.14-dovetail-rebase is now up to date. Tests have been triggered.
>
> Short changelog:
> - rebased on top of 6.14-rc5
> - Fixed a missing Signed-off for the arm64 fpsimd patch
> - Fixed the issue above (net/core/page_pool.c)
> - Squashed the IRQS_DEFERRED fix into the introducing commit
>

An overnight stress test went ok here with x4/evl on top of
v6.14-rc5-dovetail for imx8mp, kvm/arm64, imx6qp, odroid c4 and xu4q. I
can confirm that the oob support for the fpsimd unit is stable under
stress on all arm64 platforms tested so far. Nice work, thanks.

-- 
Philippe.
