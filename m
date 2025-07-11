Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B3DA47
	for <xenomai@lists.linux.dev>; Fri, 11 Jul 2025 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752223219; cv=none; b=iHcDQYXYxDye9tIgaDsD071yshIlCshnkiEG3tgYp6qpZoHD4h1JfWemafsf5Y/aEveI/k4rg/8xfMQdnBlejvpvvcQS/2sLrDZHifGyevEG4jN3zX5kFzVGmTienD92QBvFIcyFXfPk/rbWZKyQ28OsV6JAk4o/Zh7qZcO3y88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752223219; c=relaxed/simple;
	bh=SQQctFjlq6jgBZ6g5pwjGEOeLcWLcKEJsMrlzWIZrWg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e/P6hHxe+9qsuEAG+ApbbyoxDG6vF2rC0et+Gub1ADvXKjxGlsXruahWYHzOP123iBhU/dWPlcm3K2pHBNAKnzvUL8SGfRBNfxKtmBD1pQ6r/nZ/hJiuT4AwjpmLEztvU7vCICJKM44NCRls8d2jMT88FTBeSNZhTh7eXLxbSR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Ff6N2/Fa; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Ff6N2/Fa"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 33B1441C7D;
	Fri, 11 Jul 2025 08:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1752223208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EiH6NO0pWMtxTGoSDfFmYDwK3G0+aZtoOEr0BJ7zXiw=;
	b=Ff6N2/FatbGlUZeody2WlxDN/6au4qBwETasiqfYowk8lqgt6WPZ2v4cEkNPPRemWhnBWN
	8zmvMPRE97qhvFMvTsgaznjyxEPKEQ2crmcG0Mts/81gDw/5yNrnwMCEPfmQAMeWsLEaf4
	OWxl0eEvnUMcleWiBFhWSZyku4y5CKmWLm+CYp+0/H116WMUKt1H+5uMlSIRaxIIKJ1qx6
	3DViTE3IkHPlAh4B3docBF75GJVbP+4rxIZtmHeGmynAcdDbmcxd/emps6bSTslaKUeXT7
	dwDQC2RQh5c/8GQHfdCLZN/ko7T6ww3207yeFtLBsRxuzLsK35P5rWumnPpTqQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Dovetail 6.15: x86: Invalid wait context
In-Reply-To: <997e11d95184f34a23fad2607504ef567ec07758.camel@siemens.com>
	(Florian Bezdeka's message of "Thu, 05 Jun 2025 10:14:50 +0200")
References: <ee6e634d9d87ef52670dbb9ce91d7080b8640a71.camel@siemens.com>
	<87tt4ubote.fsf@xenomai.org>
	<997e11d95184f34a23fad2607504ef567ec07758.camel@siemens.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Fri, 11 Jul 2025 10:40:07 +0200
Message-ID: <87a55bw26w.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegvdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepffegvdefkedvhedvgeelgfdvkeejfeejleekhefgteduffffledvtdehffehgeetnecuffhomhgrihhnpeigvghnohhmrghirdhorhhgpdguvghngidruggvnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Thu, 2025-06-05 at 10:00 +0200, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > Hi Philippe,
>> > 
>> > the following is taken from our CI, testing Dovetail 6.15.
>> > On x86 we have an invalid wait context reported:
>> > 
>> > [  151.574032] 
>> > [  151.574039] =============================
>> > [  151.574043] [ BUG: Invalid wait context ]
>> > [  151.574046] 6.15.0 #1 Not tainted
>> > [  151.574048] -----------------------------
>> > [  151.574048] swapper/0/0 is trying to lock:
>> > [  151.574050] ffffffff841174c0 (&state->readq){....}-{3:3}, at: __wake_up+0x21/0x60
>> > [  151.574063] other info that might help us debug this:
>> > [  151.574064] context-{2:2}
>> > [  151.574065] no locks held by swapper/0/0.
>> > [  151.574066] stack backtrace:
>> > [  151.574073] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.15.0 #1 PREEMPT(full) 
>> > [  151.574078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>> > [  151.574079] IRQ stage: Linux
>> > [  151.574083] Call Trace:
>> > [  151.574086]  <IRQ>
>> > [  151.574088]  dump_stack_lvl+0x79/0xe0
>> > [  151.574095]  __lock_acquire+0x942/0xbf0
>> > [  151.574104]  lock_acquire+0xe2/0x2f0
>> > [  151.574107]  ? __wake_up+0x21/0x60
>> > [  151.574111]  ? find_held_lock+0x2b/0x80
>> > [  151.574115]  _raw_spin_lock_irqsave+0x49/0x60
>> > [  151.574120]  ? __wake_up+0x21/0x60
>> > [  151.574122]  __wake_up+0x21/0x60
>> > [  151.574125]  xnpipe_wakeup_proc+0x152/0x590
>> > [  151.574132]  handle_synthetic_irq+0xc2/0x250
>> > [  151.574137]  arch_do_IRQ_pipelined+0xca/0x180
>> > [  151.574141]  </IRQ>
>> > [  151.574142]  <TASK>
>> > [  151.574144]  sync_current_irq_stage+0xaa/0x110
>> > [  151.574147]  inband_irq_enable+0x42/0x60
>> > [  151.574151]  cpuidle_idle_call+0x17d/0x200
>> > [  151.574155]  do_idle+0x89/0xd0
>> > [  151.574158]  cpu_startup_entry+0x29/0x30
>> > [  151.574160]  rest_init+0xf0/0x190
>> > [  151.574164]  start_kernel+0x632/0x700
>> > [  151.574179]  x86_64_start_reservations+0x18/0x30
>> > [  151.574185]  x86_64_start_kernel+0x78/0x80
>> > [  151.574188]  common_startup_64+0x13e/0x148
>> > [  151.574198]  </TASK>
>> > 
>> > That seems to be triggered by the Xenomai 3 smokey testsuite.
>> > 
>> > Any ideas?
>> 
>> Does this happen when full preemption is disabled on x86?
>
> Test-Log: https://lava.xenomai.org/scheduler/job/21679
> Kernel-Config: https://source.denx.de/Xenomai/xenomai-images/-/blob/next/recipes-kernel/linux/files/amd64_defconfig?ref_type=heads

I can reproduce a similar issue with EVL right now, but this requires
full preemption to be enabled for the bug to show up, starting from
6.15. I can see the reason for lockdep to complain in this case, since
synthetic irqs are not relayed via softirqs yet. However, this can't
explain why an oldish 4.14 kernel would complain.

root@corei7-64-evl:~# evl test basic-xbuf
[   17.771991] 
[   17.771994] ================================
[   17.771995] WARNING: inconsistent lock state
[   17.771998] 6.15.0-00925-g63f9fd7a1279 #2 Tainted: G        W          
[   17.772000] --------------------------------
[   17.772002] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
[   17.772004] swapper/1/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
[   17.772007] ffff888103bf1960 (&xbuf->ibnd.i_event){?.+.}-{3:3}, at: __wake_up+0x1f/0x50
[   17.772017] {HARDIRQ-ON-W} state was registered at:
[   17.772019]   __lock_acquire+0x3af/0x12c0
[   17.772024]   lock_acquire+0xc9/0x2b0
[   17.772028]   rt_spin_lock+0x30/0x160
[   17.772031]   prepare_to_wait_event+0x24/0x1c0
[   17.772037]   inbound_wait_input+0xb7/0xe0
[   17.772041]   do_xbuf_read+0x98/0x240
[   17.772044]   xbuf_read+0x4b/0x60
[   17.772048]   vfs_read+0xcf/0x320
[   17.772053]   ksys_read+0xae/0xd0
[   17.772055]   do_syscall_64+0xbc/0x220
[   17.772060]   entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.772063] irq event stamp: 28592
[   17.772064] hardirqs last  enabled at (28591): [<ffffffff813f6ffc>] finish_task_switch+0xdc/0x300
[   17.772070] hardirqs last disabled at (28592): [<ffffffff8145f60b>] sync_current_irq_stage+0x12b/0x160
[   17.772076] softirqs last  enabled at (0): [<ffffffff813a7a86>] copy_process+0x836/0x19b0
[   17.772079] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   17.772082] 
[   17.772082] other info that might help us debug this:
[   17.772083]  Possible unsafe locking scenario:
[   17.772083] 
[   17.772084]        CPU0
[   17.772085]        ----
[   17.772085]   lock(&xbuf->ibnd.i_event);
[   17.772087]   <Interrupt>
[   17.772088]     lock(&xbuf->ibnd.i_event);
[   17.772090] 
[   17.772090]  *** DEADLOCK ***
[   17.772090] 
[   17.772090] no locks held by swapper/1/0.
[   17.772092] 
[   17.772092] stack backtrace:
[   17.772094] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G        W           6.15.0-00925-g63f9fd7a1279 #2 PREEMPT_{RT,(full)} 
[   17.772100] Tainted: [W]=WARN
[   17.772101] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc41 04/01/2014
[   17.772102] IRQ stage: Linux
[   17.772104] Call Trace:
[   17.772105]  <IRQ>
[   17.772108]  dump_stack_lvl+0x80/0xc0
[   17.772113]  print_usage_bug.part.0+0x22f/0x2c0
[   17.772119]  mark_lock_irq+0x563/0x8a0
[   17.772124]  ? stack_trace_save+0x3e/0x50
[   17.772130]  ? save_trace+0x53/0x240
[   17.772135]  mark_lock+0x1bd/0x600
[   17.772140]  mark_usage+0x109/0x120
[   17.772144]  __lock_acquire+0x3af/0x12c0
[   17.772149]  ? __resched_curr+0x64/0x260
[   17.772153]  lock_acquire+0xc9/0x2b0
[   17.772156]  ? __wake_up+0x1f/0x50
[   17.772162]  rt_spin_lock+0x30/0x160
[   17.772165]  ? __wake_up+0x1f/0x50
[   17.772167]  ? rcuwait_wake_up+0x83/0x170
[   17.772170]  ? __lock_release.isra.0+0x54/0x150
[   17.772175]  __wake_up+0x1f/0x50
[   17.772178]  irq_work_single+0x79/0xa0
[   17.772183]  irq_work_run+0x40/0x50
[   17.772187]  inband_work_interrupt+0xe/0x20
[   17.772192]  handle_synthetic_irq+0xc2/0x250
[   17.772197]  arch_do_IRQ_pipelined+0x15d/0x1b0
[   17.772201]  </IRQ>
[   17.772202]  <TASK>
[   17.772204]  sync_current_irq_stage+0xc1/0x160
[   17.772209]  __inband_irq_enable+0x48/0x60
[   17.772212]  finish_task_switch+0xe1/0x300
[   17.772216]  ? finish_task_switch+0xae/0x300
[   17.772221]  ? resume_oob_task+0x84/0x90
[   17.772226]  __schedule+0x342/0x920
[   17.772233]  schedule_idle+0x23/0x40
[   17.772237]  cpu_startup_entry+0x29/0x30
[   17.772240]  start_secondary+0xfc/0x100
[   17.772243]  common_startup_64+0x12c/0x138
[   17.772251]  </TASK>

-- 
Philippe.
