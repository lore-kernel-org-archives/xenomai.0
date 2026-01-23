Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E110EA59
	for <xenomai@lists.linux.dev>; Fri, 23 Jan 2026 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769174575; cv=none; b=UCYyK7/C2KpYd2hlrKudFPbm9JlOlHwt5+xAe19vG1Pw50auq2usC7gEFgoEwoxlNQB7IqxpTK98F/TC+BDngie1vEL+z76kSTjHPjAqipiQcKHcfRlDEc1InjuLeLXlSDoW2brU+uui89k9fkK8UE07veNb5cXRktK76TtgnOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769174575; c=relaxed/simple;
	bh=gXhPPvZTnqU2iKq/Kj1LtS/2SZs3DAaZPIY3RzY0a8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aBQYMCGQVX91RqibygjHB8lLZcY5XHvjKF7VjShVL8kksJNAJraRsZkeA0nBkMsaf5DneWJcxKKaNhyNoVMzCtGiF4/8o+y16Faxca6oRQLqka7K6BUSJ73Qk25lk/3jX4W53oecLotNpFm7lHzTqOBQ389DGMhI0laSKkqGXcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Rn5q5p04; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Rn5q5p04"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D07BD41CFA;
	Fri, 23 Jan 2026 13:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1769174571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhBQFqooW7kHN753/hHhrRtW3Pq9BJLWOsSNV+4Hw0I=;
	b=Rn5q5p04PwkHk1dQiRjbvTon6FOsPk/nCLDt1w5nPhs690AnBGA9VVWWsucA4/p929fGeu
	2B4ni13bxFT/MNlzfi0vlzRwAfQzAuhL6OIEgd9Ua73TpyV1lWphUDd98GfEWpGI3hfKjb
	TnTZq+O6yGyC7R4n3xTut91v0Q+Q/z/aMF4sE81RCT+9Js+ECHplTMyG1MfyR5KcBR5Ynv
	yNCRpG6Ymp7MFluF6HeGuwqogkvGYhM6DhLB8rmbMYj6cEEvyvqkiiXGrtBHcqiB4rgijU
	/yswvejrUAQ4stPxqzHdchU0syzuU7thxDGed01Q7phg7L2DYQgpIT8zvEkQkg==
From: Philippe Gerum <rpm@xenomai.org>
To: Junxiao Chang <junxiao.chang@intel.com>
Cc: xenomai@lists.linux.dev,  yuan1.wang@intel.com
Subject: Re: [PATCH libevl 1/2] tests: ptrace-sync: skip SOH and STX in pipe
 message
In-Reply-To: <20260124114232.1186577-1-junxiao.chang@intel.com> (Junxiao
	Chang's message of "Sat, 24 Jan 2026 19:42:31 +0800")
References: <20260124114232.1186577-1-junxiao.chang@intel.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 23 Jan 2026 14:22:50 +0100
Message-ID: <87jyx81n11.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeludehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeeulefggfehtdefgeekgfffudetkeekhfehudehfeeigffgjeekkeelfeekjeeuveenucffohhmrghinhepghhithhlrggsrdgtohhmnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhqihgupefftdejueffgeduvefhtedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeefpdhrtghpthhtohephihurghnuddrfigrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjuhhngihirghordgthhgrnhhgsehin
 hhtvghlrdgtohhm
X-GND-State: clean

Junxiao Chang <junxiao.chang@intel.com> writes:

> Sometimes there might be SOH(Start of Heading) or STX(Start of
> Text) in be beginning of message. It needs to be skipped, or else
> regex function might return wrong result.

Thanks. A fix [1] addressing the same issue was merged into the -next
branch a couple of hours ago.

https://gitlab.com/Xenomai/xenomai4/libevl/-/commit/a8f7ef7fcfda7edcc1ca4cae9661e0395eeb4674

-- 
Philippe.
