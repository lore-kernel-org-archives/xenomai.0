Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D33143748
	for <xenomai@lists.linux.dev>; Thu,  5 Jun 2025 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749110434; cv=none; b=iJGgviYuaSnuFMw82Y8qYJbCXOdbhMarHwJSEHFTrADf9Yd32Rjnq/xSDytobnr6zYJVYetP6tQ1d0dMLLMc8cA/CQXk9cbqOBC+lpRjPz+ly0Muxcwg9bJPaxHDNYr7Tmm2QaiSJhGtvn8O10uXex6dVKlasxs0ZQHb1HsPFso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749110434; c=relaxed/simple;
	bh=yW2U8IxbXXZNdA2jDaAbMnIq5AfI5E29+jg1eYmmjUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VUUirJl8JbxOJK0a9nH3xkeIi3xPtkEjSYUbKA1qBewCkS5MkdzIYctRxI9yFdZqBqoA1X5V11ATzNqhvvThVDs8637+LTA3XxI4sFU8UffF8AudiruAnpuxkd1IIfvOjCZFTp8w6af4pFaphMYT5Om5i7Cf6IAIQnNB80w8zA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=VbpT2q/1; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="VbpT2q/1"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0029C43935;
	Thu,  5 Jun 2025 08:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1749110430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jy9N3s921akKKIlzGT0A/j3Vlg2DRVYpgW+PTUocO4o=;
	b=VbpT2q/1PyhmvwgLdY5+U3DGa6G8FQtfnbMt8bEkpMhTxJePJcr98nNmNYo5N2HgXuJdst
	OLZkVo6/mWUKR6LMzd+iM1Xyv83iWK8CsTj/Uh0dPBduKUGznOCf9e1fHGA17qgWv+BfBR
	uqQ1qz/UveePINKn2UfAO1qzcjx4NrjzeMz55uugNIP+00LaVcSay++Oeq0rpv7gdJRqB2
	vPdq37SvC01oSYMH24qOSwP6cajAwPh1lQa1N1Wn8oVtmrJZC0QU7NS0v2HHUt9erTxMEd
	w3KB537WdBE/yyFm8O0j3JJcEU1aEQ6Lkyhax1JtShmRCXZv7axqSNlcRt/dnw==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Dovetail 6.15: x86: Invalid wait context
In-Reply-To: <ee6e634d9d87ef52670dbb9ce91d7080b8640a71.camel@siemens.com>
	(Florian Bezdeka's message of "Tue, 03 Jun 2025 15:55:30 +0200")
References: <ee6e634d9d87ef52670dbb9ce91d7080b8640a71.camel@siemens.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 05 Jun 2025 10:00:29 +0200
Message-ID: <87tt4ubote.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeffeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> the following is taken from our CI, testing Dovetail 6.15.
> On x86 we have an invalid wait context reported:
>
> [  151.574032] 
> [  151.574039] =============================
> [  151.574043] [ BUG: Invalid wait context ]
> [  151.574046] 6.15.0 #1 Not tainted
> [  151.574048] -----------------------------
> [  151.574048] swapper/0/0 is trying to lock:
> [  151.574050] ffffffff841174c0 (&state->readq){....}-{3:3}, at: __wake_up+0x21/0x60
> [  151.574063] other info that might help us debug this:
> [  151.574064] context-{2:2}
> [  151.574065] no locks held by swapper/0/0.
> [  151.574066] stack backtrace:
> [  151.574073] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.15.0 #1 PREEMPT(full) 
> [  151.574078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> [  151.574079] IRQ stage: Linux
> [  151.574083] Call Trace:
> [  151.574086]  <IRQ>
> [  151.574088]  dump_stack_lvl+0x79/0xe0
> [  151.574095]  __lock_acquire+0x942/0xbf0
> [  151.574104]  lock_acquire+0xe2/0x2f0
> [  151.574107]  ? __wake_up+0x21/0x60
> [  151.574111]  ? find_held_lock+0x2b/0x80
> [  151.574115]  _raw_spin_lock_irqsave+0x49/0x60
> [  151.574120]  ? __wake_up+0x21/0x60
> [  151.574122]  __wake_up+0x21/0x60
> [  151.574125]  xnpipe_wakeup_proc+0x152/0x590
> [  151.574132]  handle_synthetic_irq+0xc2/0x250
> [  151.574137]  arch_do_IRQ_pipelined+0xca/0x180
> [  151.574141]  </IRQ>
> [  151.574142]  <TASK>
> [  151.574144]  sync_current_irq_stage+0xaa/0x110
> [  151.574147]  inband_irq_enable+0x42/0x60
> [  151.574151]  cpuidle_idle_call+0x17d/0x200
> [  151.574155]  do_idle+0x89/0xd0
> [  151.574158]  cpu_startup_entry+0x29/0x30
> [  151.574160]  rest_init+0xf0/0x190
> [  151.574164]  start_kernel+0x632/0x700
> [  151.574179]  x86_64_start_reservations+0x18/0x30
> [  151.574185]  x86_64_start_kernel+0x78/0x80
> [  151.574188]  common_startup_64+0x13e/0x148
> [  151.574198]  </TASK>
>
> That seems to be triggered by the Xenomai 3 smokey testsuite.
>
> Any ideas?

Does this happen when full preemption is disabled on x86?

-- 
Philippe.
