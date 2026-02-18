Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8974271A6D
	for <xenomai@lists.linux.dev>; Wed, 18 Feb 2026 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771404630; cv=none; b=l9k4Hk9NHVbTGl80H9lwrQb0lYnIDw7IXrh8AFQNM642nwZ1ae2D13NVDLSoraGSTe3uZBqhj74136yXDdlhOuSMty9LcyurB5/sFj37V5+wdTgudXT3mAD4zTZsAPw6cUijs6NwtyYiAFy7uQHznpufSMrRQPfZAKJv1W4WMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771404630; c=relaxed/simple;
	bh=srNcVlgAvU9nZsGtNxWqbxL5QubEppLgK1m3TQJI3oE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rNSr/474EvG7LcgEMKiKiVqCTr9f9VrdvbbxAdL32G+aCupdF5csB6CYWOhjvpZJNffGapJv4N+lRbbw/BrruoXzGx7qUxO+prN1QVTz9Lq1GQBQeSd/pwLyXApP/6O0huWAiXqRyQX7j9Ch5OBzEcVIGao9R4490avGTIib+ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=WJoTNG0z; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="WJoTNG0z"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A1E863EB36;
	Wed, 18 Feb 2026 08:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1771404620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kamaVW5tzmVtVe7zKDSJcgOLB4L9zDky1Zq/bW6Ms8Q=;
	b=WJoTNG0zo1Lb+Z0vuIBxfVQNxStxTA/updFmCvnwBRjHu6zud6Xt98RhZMCMoGRSXEBvGw
	h0FAdJRd3dOQePmm/QeIU/SgI8py7ZLkq3+04VvdbKov4W1PbW1fe/qe/mTAlFgVMSL92X
	5gwjqCboeoYZ/eSShEXhFaJCoswC9bmjTLK2dcY7ncIGpWcVYtWbs6duBVdN0pNQWF3hTC
	JVIZSg1Gwrq7wWDVdYY0WFjwBT9N9WDPrYUWGHf8PEzsbpEY8rOTlBEAMYUiYm4P5yknbf
	MwAnX8ExXGQhk3rvgl2hsO41llpQimFHOwrLXcDScIu7f6GcYBk8zKgapIl0jg==
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: evl. event and mutex
In-Reply-To: <facf1a8f-697a-453d-758c-acaa2c92c804@bela.io> (Giulio Moro's
	message of "Tue, 17 Feb 2026 15:28:21 -0500")
References: <facf1a8f-697a-453d-758c-acaa2c92c804@bela.io>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 18 Feb 2026 09:50:16 +0100
Message-ID: <87v7fuxwon.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddvvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeeulefggfehtdefgeekgfffudetkeekhfehudehfeeigffgjeekkeelfeekjeeuveenucffohhmrghinhepghhithhlrggsrdgtohhmnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhqihgupeetudfgkeeifefgueefiedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehgihhulhhiohessggvlhgrrdhioh
X-GND-State: clean

Giulio Moro <giulio@bela.io> writes:

> Hi everyone,
> I am trying to use evl_event and evl_mutex so that two threads can signal each other when either needs work from the other, so they each need to call evl_signal_event() and evl_wait_event(). The first thread to call evl_wait_event() seems to correctly drop the mutex, thus unlocking the second thread. When the second thread signals the condition variable (while holding the mutex) and then calls evl_wait_event(), thus implicitly dropping the mutex, the first thread is, unexpectedly, not restarted. I noticed that if a third thread acquires and then releases the lock (without touching the condition variable), then the first thread is restarted. This sounds like a bug?
>

It is, please pick this commit (on v6.18.y, backported to v6.1.y-cip and v6.12.y):

https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/c02e718dda07cfa1db079450d352f62b32702c55

-- 
Philippe.
