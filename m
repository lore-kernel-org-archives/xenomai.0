Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ED6261388
	for <xenomai@lists.linux.dev>; Wed, 20 Aug 2025 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698613; cv=none; b=RgJY27kZi5zG4ia4/N2NlB0GY0hF6qT7Lh6jChE4Z8R6PAk8moOGx73Q0glGtsGegxzjOb/Cuq0Mck2/ejvjvEJCbP8vmftWMVPOtHX2OvVaZbXWFY+rGGQ2SfKSQlN30gam/7dS6R9SlKw+QykWTyl2R2RgyiHnbPKxHaIqt3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698613; c=relaxed/simple;
	bh=muSLXZoOC+Zp7agEpaJE4RvXOMXbB1bWGxtS2CAYXH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r+BUCVa8/MehLAM2HaVUJOnasYjfq6BNSMsqEzsDHwwLZr0CfglbPc7TwSKYor8VuWftD4m+l3LZKED9nO5QkUneZoJ2Ckb0hbaJjuHrB39j2wY9n8O1iBLMnyOjpdlYWSDyNVw+rSwtJoHrBh6wYJdrmKa3m+VTz4YKO+ehFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=kxb7rYNp; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="kxb7rYNp"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A563A4430C;
	Wed, 20 Aug 2025 14:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1755698609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=56PRZC1cpF+56PhPFmDXEBcYaNMpPDs1oHQ5ByuLRgk=;
	b=kxb7rYNppNwek58F5SWSOcxBprcmj97XO0RYgB6SgQqwxDGhZQCYC3XjXvnEc8J9tUhct/
	rUBcALj9V/ouaufv8l6lPGckAKLLgHRxkhLWZd7OiHqduiI+rwZ/OV7U2bVmBtmsVGKZ+s
	JrcONBQjRg4BXaM3V5VvOyQvX3Q+cssraG8iziUufHmEhHIoRmuo24P/ZjqKR+sUBClWQD
	DAtvjhFxUQXg/30bkUKg1TNbFt18W24KoDc4fsDNFVPZSezBySgS12cyh4ipFfTtLgw+xy
	h2SNWkbzXQUQFDJWaSBDYXh7zhPQWU3uQXxDefZw8jeFaRVCilgI9GYYaNBLAQ==
From: Philippe Gerum <rpm@xenomai.org>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>,  "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Subject: Re: Dovetail 6.15: x86: Invalid wait context
In-Reply-To: <91de355fc99fa61d37c648d2aafc9fb9c2b68d6d.camel@siemens.com>
	(Florian Bezdeka's message of "Wed, 20 Aug 2025 11:15:16 +0000")
References: <ee6e634d9d87ef52670dbb9ce91d7080b8640a71.camel@siemens.com>
	<87tt4ubote.fsf@xenomai.org>
	<997e11d95184f34a23fad2607504ef567ec07758.camel@siemens.com>
	<87a55bw26w.fsf@xenomai.org>
	<f9245ae15561f12335177c73df9d9b53de4d7ac9.camel@siemens.com>
	<87ldok48lm.fsf@xenomai.org> <87fres42zc.fsf@xenomai.org>
	<6fcb3f9830056d99161ea8f50a016b99d98a7c71.camel@siemens.com>
	<91de355fc99fa61d37c648d2aafc9fb9c2b68d6d.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 20 Aug 2025 16:03:28 +0200
Message-ID: <87349may4v.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeffgedvfeekvdehvdeglefgvdekjeefjeelkeehgfetudffffelvddtheffheegteenucffohhmrghinhepgigvnhhomhgrihdrohhrghdpuggvnhigrdguvgenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

"Bezdeka, Florian" <florian.bezdeka@siemens.com> writes:

> On Mon, 2025-07-28 at 16:37 +0200, Florian Bezdeka wrote:
>> On Sat, 2025-07-19 at 17:25 +0200, Philippe Gerum wrote:
>> > Philippe Gerum <rpm@xenomai.org> writes:
>> > 
>> > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> > > 
>> > > > On Fri, 2025-07-11 at 10:40 +0200, Philippe Gerum wrote:
>> > > > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> > > > > 
>> > > > > > On Thu, 2025-06-05 at 10:00 +0200, Philippe Gerum wrote:
>> > > > > > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> > > > > > > 
>> > > > > > > > Hi Philippe,
>> > > > > > > > 
>> > > > > > > > the following is taken from our CI, testing Dovetail 6.15.
>> > > > > > > > On x86 we have an invalid wait context reported:
>> > > > > > > > 
>> > > > > > > > [  151.574032] 
>> > > > > > > > [  151.574039] =============================
>> > > > > > > > [  151.574043] [ BUG: Invalid wait context ]
>> > > > > > > > [  151.574046] 6.15.0 #1 Not tainted
>> > > > > > > > [  151.574048] -----------------------------
>> > > > > > > > [  151.574048] swapper/0/0 is trying to lock:
>> > > > > > > > [  151.574050] ffffffff841174c0 (&state->readq){....}-{3:3}, at: __wake_up+0x21/0x60
>> > > > > > > > [  151.574063] other info that might help us debug this:
>> > > > > > > > [  151.574064] context-{2:2}
>> > > > > > > > [  151.574065] no locks held by swapper/0/0.
>> > > > > > > > [  151.574066] stack backtrace:
>> > > > > > > > [  151.574073] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.15.0 #1 PREEMPT(full) 
>> > > > > > > > [  151.574078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>> > > > > > > > [  151.574079] IRQ stage: Linux
>> > > > > > > > [  151.574083] Call Trace:
>> > > > > > > > [  151.574086]  <IRQ>
>> > > > > > > > [  151.574088]  dump_stack_lvl+0x79/0xe0
>> > > > > > > > [  151.574095]  __lock_acquire+0x942/0xbf0
>> > > > > > > > [  151.574104]  lock_acquire+0xe2/0x2f0
>> > > > > > > > [  151.574107]  ? __wake_up+0x21/0x60
>> > > > > > > > [  151.574111]  ? find_held_lock+0x2b/0x80
>> > > > > > > > [  151.574115]  _raw_spin_lock_irqsave+0x49/0x60
>> > > > > > > > [  151.574120]  ? __wake_up+0x21/0x60
>> > > > > > > > [  151.574122]  __wake_up+0x21/0x60
>> > > > > > > > [  151.574125]  xnpipe_wakeup_proc+0x152/0x590
>> > > > > > > > [  151.574132]  handle_synthetic_irq+0xc2/0x250
>> > > > > > > > [  151.574137]  arch_do_IRQ_pipelined+0xca/0x180
>> > > > > > > > [  151.574141]  </IRQ>
>> > > > > > > > [  151.574142]  <TASK>
>> > > > > > > > [  151.574144]  sync_current_irq_stage+0xaa/0x110
>> > > > > > > > [  151.574147]  inband_irq_enable+0x42/0x60
>> > > > > > > > [  151.574151]  cpuidle_idle_call+0x17d/0x200
>> > > > > > > > [  151.574155]  do_idle+0x89/0xd0
>> > > > > > > > [  151.574158]  cpu_startup_entry+0x29/0x30
>> > > > > > > > [  151.574160]  rest_init+0xf0/0x190
>> > > > > > > > [  151.574164]  start_kernel+0x632/0x700
>> > > > > > > > [  151.574179]  x86_64_start_reservations+0x18/0x30
>> > > > > > > > [  151.574185]  x86_64_start_kernel+0x78/0x80
>> > > > > > > > [  151.574188]  common_startup_64+0x13e/0x148
>> > > > > > > > [  151.574198]  </TASK>
>> > > > > > > > 
>> > > > > > > > That seems to be triggered by the Xenomai 3 smokey testsuite.
>> > > > > > > > 
>> > > > > > > > Any ideas?
>> > > > > > > 
>> > > > > > > Does this happen when full preemption is disabled on x86?
>> > > > > > 
>> > > > > > Test-Log: https://lava.xenomai.org/scheduler/job/21679
>> > > > > > Kernel-Config: https://source.denx.de/Xenomai/xenomai-images/-/blob/next/recipes-kernel/linux/files/amd64_defconfig?ref_type=heads
>> > > > > 
>> > > > > I can reproduce a similar issue with EVL right now, but this requires
>> > > > > full preemption to be enabled for the bug to show up, starting from
>> > > > > 6.15. I can see the reason for lockdep to complain in this case, since
>> > > > > synthetic irqs are not relayed via softirqs yet. However, this can't
>> > > > > explain why an oldish 4.14 kernel would complain.
>> > > > 
>> > > > Thanks for letting us know. But: Where is 4.14 coming into the game?
>> > > 
>> > > Because the link you sent me referred to a kernel config for 4.14.71. I
>> > > assumed the yocto recipe which contains it did produce the qemu image
>> > > showing the issue.
>> > > 
>> > > > Our reports (from CI testing) were 6.15 related, nothing older.
>> > > > 
>> > > > Is there a specific change in 6.15 that broke the synthetic IRQ
>> > > > handling?
>> > > 
>> > > 814b824b4466b irq_work: dovetail: never defer local work posted from oob
>> > > 
>> > > > Are you already working an a fix?
>> > > 
>> > > Yep.
>> > 
>> > The broken commit was reverted from v6.1.y-cip-rebase, v6.12.y-rebase
>> > and v6.15, things are back to normal for x4 now. I believe this should
>> > fix x3 as well.
>> 
>> At least our virtual x86 target is still reporting the same problem
>> when running the x3 testsuite. Other archs are still running, let's
>> see.
>> 
>> We do not have full preemption enabled.
>> 
>> Test run: https://lava.xenomai.org/scheduler/job/22325
>> Report  : https://lava.xenomai.org/scheduler/job/22325#L864
>> 
>
> I'm now able to reproduce the same issue with 6.16. The condensed
> defconfig is attached.
>
> xnpipe_wakeup_proc() tries to wake up a wait queue from inband IRQ
> context ending up in __wake_up_common_lock() where we have	
>
> 	spin_lock_irqsave(&wq_head->lock, flags);
> 	remaining = __wake_up_common(...);
> 	spin_unlock_irqrestore(&wq_head->lock, flags);
>
> Is the interrupt state now mixed up, so that lockdep complains? On the
> other hand having a sleeping mutex in case of PREEMPT_RT enabled in the
> inband IRQ context is also a problem, especially as this synthetic IRQ
> would not be threaded. See pipeline_create_inband_sirq() using the
> IRQF_NO_THREAD flag.
>
> That looks like a Xenomai 3 bug to me. I can't tell why 6.15 onward is
> now complaining. Any other/additional thoughts?
>

Correct, this is an issue fixed recently while working on the network stack
for x4. As a rule of thumb, sirqs in x3 should be replaced by irq_work
whenever possible, with IRQ_WORK_HARD_IRQ set for the work struct when
the handler is really expected to run in interrupt context. Otherwise,
PREEMPT_RT mode would offload the call to a kernel worker thread.

-- 
Philippe.
