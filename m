Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17170469231
	for <xenomai@lists.linux.dev>; Thu,  8 Jan 2026 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767871542; cv=none; b=GSZtZws6lPdxS/exGn72JYXo0qiKLvEEVbS0SXe9crN5dNQ9+3ijM0i8YS0y+tcFElGlVU9NXh2no7wwib4Skio0nSXzR+qYDDKU81Et505LufkCuBeQG9ZGaQNy1v7kTCKFXqf93usKoEOg9KhuJ6bzCPxjRs+ZS4GimQf/5WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767871542; c=relaxed/simple;
	bh=7OZURJn3JKf1tBHD3zE92kTLTB2pJDbhKupdeXh7xRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PuGyaTyDSmCd8oxGgqm7UBaJKrqnvDgud3zNHd+ijJv5HsFRApa4x9vWrDiWPbSrv8aMytyOeLGp06kwN9KskmOxzIGuNmmxwylzeWMNz4E/HTFutSnq3ZjlRFYcKQcwtw/FflFHhW9TOZZk89kVch0CNWljUdc9RNGae9eoVzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ecR4xnsp; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ecR4xnsp"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id DF6CE58110D
	for <xenomai@lists.linux.dev>; Thu,  8 Jan 2026 11:12:11 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E0FB642E7B;
	Thu,  8 Jan 2026 11:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1767870724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7XPyO31XE77FqGmLVLvesknnV90wgvmcJG0Vs+iXZr0=;
	b=ecR4xnspxgQYZI3WguC5VpdGHGNRbDPmkXBmXjyO5KnwUb+5Mwa0VuJSJBDO397rA1o4YJ
	RDMFT//KoBw+ywXKuzC5TiXt9sjzlW6e6v14i027UImL6sTCQn7NEolnwGVsKfPLDM9qNH
	vWOOw+SjHltRFTaoC7TAM6RWfTiSYKBFC9RGgD+VzMYo0E+nxzNSUrN0spNjA/8VheKGHx
	v4CjKV8Ym9wIwdWDbhzJY8P9DgIDYcNlWOXadoeXmb34+TQBEfqvXM2A0bI1qraclDXusj
	1vnYWaEtGX04OBdqW4Q34fZgbG0Qh5VN8ndexe17XBE5LFK9S1bHxLQIkdBvNQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: liuyang <liuyang@sinsegye.com.cn>,  xenomai@lists.linux.dev,
  songjianwei@sinsegye.com.cn
Subject: Re: [PATCH v1] x86: fix stale CONFIG_HAVE_KVM reference in
 irq_pipeline
In-Reply-To: <4fc9725250f6c4072853196c6747e51c8456fd0f.camel@siemens.com>
	(Florian Bezdeka's message of "Thu, 08 Jan 2026 09:22:20 +0100")
References: <20260104021211.548905-1-liuyang@sinsegye.com.cn>
	<4fc9725250f6c4072853196c6747e51c8456fd0f.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 08 Jan 2026 12:12:03 +0100
Message-ID: <87o6n4l5oc.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepgfdthfeuieegvdfgjeeupdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehsohhnghhjihgrnhifvghisehsihhnshgvghihvgdrtghomhdrtghnpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhuhigrnhhgsehsihhnshgvghihvgdrtghomhdrtghnpdhrtghpt
 hhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Sun, 2026-01-04 at 10:12 +0800, liuyang wrote:
>> The CONFIG_HAVE_KVM macro has been removed in kernel 6.12. 
>> Consequently, the code block for POSTED_INTR_VECTOR in 
>> do_sysvec_inband() is no longer being compiled even when KVM 
>> is enabled.
>> 
>> Replace the obsolete CONFIG_HAVE_KVM with IS_ENABLED(CONFIG_KVM) 
>> to restore the correct behavior for KVM posted interrupts in 
>> the interrupt pipeline.
>> 
>> Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
>
> Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>
> Cc: Philippe
>
> Philippe, this patch needs to be applied to 6.18 and 6.12.
> Thanks!
>

Merged, thanks.

-- 
Philippe.
