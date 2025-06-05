Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D85D1FECAD
	for <xenomai@lists.linux.dev>; Thu,  5 Jun 2025 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749110330; cv=none; b=MbMsV3Jxmd09NM6fwTTA/TjR8X/9PO0BCbXaQeC0W88od1x0nSnXGQnRXnWJazaf7uho6tpQTR2g32FnVlTkm6f4EX9YRxLDz3nx9suhZteN1cCXqbndoCB+MN/zdKGngotrsZNz/kUr2+UtBJ0I7d5VbbrUcDvSoCJtom8afkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749110330; c=relaxed/simple;
	bh=DHIyk6RUYw30Vh7FNBFJZnbdIMGxB41S6TLIO6jHsX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZZCLBMrhjB4NaQ5Vvh0i5clnkF7D2PxaHMy9+HIFv/a/IEdJEg3lbWTuEe6vP+pY5BJdxehb5D/D71qjUHygBSg0ueILXT3v+2dkGhOm6YprerLDs1k4zq94x6QT5yhC4gKCLaOpmySZ5X3U15WXp171k7eSeMUz89l7JYAcJ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=k34hWPBe; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="k34hWPBe"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 600A41FD31;
	Thu,  5 Jun 2025 07:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1749110325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G9I1rHdR01mLAwGO2cuC/pPoegIGKlwTPML+LYF9O1A=;
	b=k34hWPBev10hBh2hubyyyUwaM7xsgJ7LppYQsaECj3hMKBHWJApf443BAm4FDHuBJjgl1H
	KnPvWfH8DCdmxYRy7aH68IWPSAxXRNRy4fakTNanCYIMokuGITN2e0vqSJN76ldfGOsel2
	h805dqKKcNjnriINj0OuNEAcxyCdAZSYoUm/cZS/zRiCzUt2jsthxkpnEIOSyUK4BOFTr0
	ebdk+dqEULSY2Hc2FQGhCNHYufaF48rh0uDSeHHiciFsdDCwdPy2z21fozp/kFqdOxvC6F
	jHTXVgZ/HaycIEcIEHrNVSeUyd/B1MwUnnTEJCnyyqWZ7NyMI2KkTld07Z957g==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: Dovetail: Adding support for Hyper-v as hypervisor
In-Reply-To: <954e1b69e7ccb2e1abf7f82d2bcb109e3cd1ac24.camel@siemens.com>
	(Florian Bezdeka's message of "Wed, 04 Jun 2025 13:15:23 +0200")
References: <954e1b69e7ccb2e1abf7f82d2bcb109e3cd1ac24.camel@siemens.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 05 Jun 2025 09:58:40 +0200
Message-ID: <87zfembowf.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeffeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org


Hi,

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> I'm currently experimenting with hyper-v as Hypervisor for dovetail. So
> far so good, I'm able to boot the system and the system survives a
> inband stress test. The necessary modifications can be found at [1].
>
> But: Running the Xenomai 3 testsuite - especially the gdb test -
> freezes the system immediately.
>
> When enabling pipeline and dovetail debug options I get the following
> splat report. Ideas welcome...

Since the splat happens because lockdep mistakenly thinks that we are
running in hard irq context although we are actually running a
workqueue, there must be an issue with the tracking of the
hardirq_context variable. Could there be some imbalance with
lockdep_hardirq_{enter, exit}() due to some specifics in routing the
STIMER0 vector?

>
>
> Have you - or someone else - ever tried running dovetail on top of
> hyper-v?
>

Nope.

-- 
Philippe.
