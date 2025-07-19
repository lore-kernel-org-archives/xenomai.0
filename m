Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D9C4438B
	for <xenomai@lists.linux.dev>; Sat, 19 Jul 2025 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752938739; cv=none; b=KziX6gz1l05KRFyyUl36ZqU5VNjGmig2eOy5LK1eon0oVBa/UGd50lrVI3QnjGy1iVIAbNZTYLeyejhQ2Fatr0hk8W+pZr9kPEcS3eXfCjMHKLriRrGLW0kQm5BI2v44wtWonQAg/p7G6a6JjAbxxXiXqdA7aQQwx8DS0YcQxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752938739; c=relaxed/simple;
	bh=259SYu46f3lZ2Sqb1UMz6f1+hZQO1sV2bNPPoIwvhR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EqbO3E77Qjnc7ZnRawt3h4tkGbpU2nd7d4fbGWjWZJUZEjmym3tvtU5dByBQiklbY2A7WyGWzVGeg2+2VzKLhwfnPZbs+PsQsydw6s0JeifOvhFzhzHLwv6i76X8PVU57UOoRDVKmRM0Phv9q2EZvRhpNyweVMDOEDmm6kMwyro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=CB8UGbiX; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="CB8UGbiX"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4164241C7B;
	Sat, 19 Jul 2025 15:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1752938728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OIwoBNEIy8N+GhR7/6oLDoocBFw6ZyOFcaqEM83FrYk=;
	b=CB8UGbiXTWNIkZcWOOwcgaWUcdUX0RZQnMdwOuGVjh0k+I2cxZGr1m4LBWyeXuHgtrrrCT
	EvOor0pFnMM/y0orne5heL4KL/F1LhBrPxSukV5nMzj/ldDIKwmMy5h52P/QzqRWINWyt6
	PvDKryEYtusHczoXKdGCBhHJpPIX2u9yZtcRHuS+WhuNmuaTenOVFg4aGv5evlpOXQjB/q
	Fpss/+qb+e38bLdUvce19i3ZPqE4DTSmhOWPXwpXoHkwzTS0SFKvMV8mg3Sgs4LUjahnh7
	DOSKXGZXXDVASuob62TSD6w/Uecu8tCRF7zP59MXFg+MlwVst33VINxVfuvjRA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Dovetail 6.15: x86: Invalid wait context
In-Reply-To: <87ldok48lm.fsf@xenomai.org> (Philippe Gerum's message of "Sat,
	19 Jul 2025 15:24:05 +0200")
References: <ee6e634d9d87ef52670dbb9ce91d7080b8640a71.camel@siemens.com>
	<87tt4ubote.fsf@xenomai.org>
	<997e11d95184f34a23fad2607504ef567ec07758.camel@siemens.com>
	<87a55bw26w.fsf@xenomai.org>
	<f9245ae15561f12335177c73df9d9b53de4d7ac9.camel@siemens.com>
	<87ldok48lm.fsf@xenomai.org>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Sat, 19 Jul 2025 17:25:27 +0200
Message-ID: <87fres42zc.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiieeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepffegvdefkedvhedvgeelgfdvkeejfeejleekhefgteduffffledvtdehffehgeetnecuffhomhgrihhnpeigvghnohhmrghirdhorhhgpdguvghngidruggvnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Philippe Gerum <rpm@xenomai.org> writes:

> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>
>> On Fri, 2025-07-11 at 10:40 +0200, Philippe Gerum wrote:
>>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>> 
>>> > On Thu, 2025-06-05 at 10:00 +0200, Philippe Gerum wrote:
>>> > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>> > > 
>>> > > > Hi Philippe,
>>> > > > 
>>> > > > the following is taken from our CI, testing Dovetail 6.15.
>>> > > > On x86 we have an invalid wait context reported:
>>> > > > 
>>> > > > [  151.574032] 
>>> > > > [  151.574039] =============================
>>> > > > [  151.574043] [ BUG: Invalid wait context ]
>>> > > > [  151.574046] 6.15.0 #1 Not tainted
>>> > > > [  151.574048] -----------------------------
>>> > > > [  151.574048] swapper/0/0 is trying to lock:
>>> > > > [  151.574050] ffffffff841174c0 (&state->readq){....}-{3:3}, at: __wake_up+0x21/0x60
>>> > > > [  151.574063] other info that might help us debug this:
>>> > > > [  151.574064] context-{2:2}
>>> > > > [  151.574065] no locks held by swapper/0/0.
>>> > > > [  151.574066] stack backtrace:
>>> > > > [  151.574073] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.15.0 #1 PREEMPT(full) 
>>> > > > [  151.574078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>>> > > > [  151.574079] IRQ stage: Linux
>>> > > > [  151.574083] Call Trace:
>>> > > > [  151.574086]  <IRQ>
>>> > > > [  151.574088]  dump_stack_lvl+0x79/0xe0
>>> > > > [  151.574095]  __lock_acquire+0x942/0xbf0
>>> > > > [  151.574104]  lock_acquire+0xe2/0x2f0
>>> > > > [  151.574107]  ? __wake_up+0x21/0x60
>>> > > > [  151.574111]  ? find_held_lock+0x2b/0x80
>>> > > > [  151.574115]  _raw_spin_lock_irqsave+0x49/0x60
>>> > > > [  151.574120]  ? __wake_up+0x21/0x60
>>> > > > [  151.574122]  __wake_up+0x21/0x60
>>> > > > [  151.574125]  xnpipe_wakeup_proc+0x152/0x590
>>> > > > [  151.574132]  handle_synthetic_irq+0xc2/0x250
>>> > > > [  151.574137]  arch_do_IRQ_pipelined+0xca/0x180
>>> > > > [  151.574141]  </IRQ>
>>> > > > [  151.574142]  <TASK>
>>> > > > [  151.574144]  sync_current_irq_stage+0xaa/0x110
>>> > > > [  151.574147]  inband_irq_enable+0x42/0x60
>>> > > > [  151.574151]  cpuidle_idle_call+0x17d/0x200
>>> > > > [  151.574155]  do_idle+0x89/0xd0
>>> > > > [  151.574158]  cpu_startup_entry+0x29/0x30
>>> > > > [  151.574160]  rest_init+0xf0/0x190
>>> > > > [  151.574164]  start_kernel+0x632/0x700
>>> > > > [  151.574179]  x86_64_start_reservations+0x18/0x30
>>> > > > [  151.574185]  x86_64_start_kernel+0x78/0x80
>>> > > > [  151.574188]  common_startup_64+0x13e/0x148
>>> > > > [  151.574198]  </TASK>
>>> > > > 
>>> > > > That seems to be triggered by the Xenomai 3 smokey testsuite.
>>> > > > 
>>> > > > Any ideas?
>>> > > 
>>> > > Does this happen when full preemption is disabled on x86?
>>> > 
>>> > Test-Log: https://lava.xenomai.org/scheduler/job/21679
>>> > Kernel-Config: https://source.denx.de/Xenomai/xenomai-images/-/blob/next/recipes-kernel/linux/files/amd64_defconfig?ref_type=heads
>>> 
>>> I can reproduce a similar issue with EVL right now, but this requires
>>> full preemption to be enabled for the bug to show up, starting from
>>> 6.15. I can see the reason for lockdep to complain in this case, since
>>> synthetic irqs are not relayed via softirqs yet. However, this can't
>>> explain why an oldish 4.14 kernel would complain.
>>
>> Thanks for letting us know. But: Where is 4.14 coming into the game?
>
> Because the link you sent me referred to a kernel config for 4.14.71. I
> assumed the yocto recipe which contains it did produce the qemu image
> showing the issue.
>
>> Our reports (from CI testing) were 6.15 related, nothing older.
>>
>> Is there a specific change in 6.15 that broke the synthetic IRQ
>> handling?
>
> 814b824b4466b irq_work: dovetail: never defer local work posted from oob
>
>> Are you already working an a fix?
>
> Yep.

The broken commit was reverted from v6.1.y-cip-rebase, v6.12.y-rebase
and v6.15, things are back to normal for x4 now. I believe this should
fix x3 as well.

-- 
Philippe.
