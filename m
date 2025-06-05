Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AF127A442
	for <xenomai@lists.linux.dev>; Thu,  5 Jun 2025 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749146210; cv=none; b=l136UFkit5z2voIj4WamFdWtbBQHHMYqJ832uc/J+8ShdyhlL/cMW9gAnJtCBOKi6GpsverzCYmRhaQZP1CAZfL28bdh/l+cZCt0Up6AWgBEcuk1WvktsSwX8REVT755ihFdC+qX3N1oEf5AP0PBeM2+GZp+d8Htlq3y89JoO3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749146210; c=relaxed/simple;
	bh=IVtueZTJJePkxiBpeyXUvK/H3qZNNIirKaSl/hdkxjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tJJZqo+XzNrmuQNuw7LvhcllZ1FFjtS0oRoXdjliE4o97BTYmRafx+3y1GGqJ/i3tH9wRGIvJIvxyU9WrC0XtpvXaJTtHCax+u745DRsZViiRjF5itHUjoSVqFSvvqXYDwJ7cPkV104mja+qEaRyymnsocX32RbbYfEfXYqZiBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=NW8Cezg1; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="NW8Cezg1"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51A031FD31;
	Thu,  5 Jun 2025 17:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1749146200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=juwDyW9udm27vNvCzFmJwql2nbkgeyCOmEd2vsJpIW0=;
	b=NW8Cezg17VhgPs+jzHrlmk5YYveg0BYqea/I4gpknxd6mdBcJSCfvOQsnVIs9RvEmcJfO+
	eLjcd9CV2TnWXXzz4bCA0d3kA4zdiJZ/eu9v6OniKPQzQbHyjPJoL5i15qaWOsITUNca9v
	nYDa++/N9L5FAWPZ2b5zzACGelvcGpqcg9VvfjAqK9a+k3vXHvK3f5+cCcI5+uujAEtPjQ
	BgQzZPuYoMtFga+wUh6hIaazqrcJMaG9VY3iNUqVXabxbwPokTAVoTUCAmNTn7rMmI9WXI
	6eHmsTY3F4KiN4S9Kx/Aqo/zxJg8dOtxlPCq7AJMZ/0vhCklzzDxo3evHnEATA==
From: Philippe Gerum <rpm@xenomai.org>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>,  "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Subject: Re: Dovetail 6.15: x86: Invalid wait context
In-Reply-To: <a6c0bc4c19cf73a94ae409b1cd7cd5993da5e162.camel@siemens.com>
	(Florian Bezdeka's message of "Thu, 5 Jun 2025 16:21:52 +0000")
References: <ee6e634d9d87ef52670dbb9ce91d7080b8640a71.camel@siemens.com>
	<87tt4ubote.fsf@xenomai.org>
	<997e11d95184f34a23fad2607504ef567ec07758.camel@siemens.com>
	<a6c0bc4c19cf73a94ae409b1cd7cd5993da5e162.camel@siemens.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 05 Jun 2025 19:56:39 +0200
Message-ID: <87ldq6ax7s.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeffgedvfeekvdehvdeglefgvdekjeefjeelkeehgfetudffffelvddtheffheegteenucffohhmrghinhepgigvnhhomhgrihdrohhrghdpuggvnhigrdguvgenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

"Bezdeka, Florian" <florian.bezdeka@siemens.com> writes:

> On Thu, 2025-06-05 at 10:14 +0200, Florian Bezdeka wrote:
>> On Thu, 2025-06-05 at 10:00 +0200, Philippe Gerum wrote:
>> > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> > 
>> > > Hi Philippe,
>> > > 
>> > > the following is taken from our CI, testing Dovetail 6.15.
>> > > On x86 we have an invalid wait context reported:
>> > > 
>> > > [  151.574032] 
>> > > [  151.574039] =============================
>> > > [  151.574043] [ BUG: Invalid wait context ]
>> > > [  151.574046] 6.15.0 #1 Not tainted
>> > > [  151.574048] -----------------------------
>> > > [  151.574048] swapper/0/0 is trying to lock:
>> > > [  151.574050] ffffffff841174c0 (&state->readq){....}-{3:3}, at: __wake_up+0x21/0x60
>> > > [  151.574063] other info that might help us debug this:
>> > > [  151.574064] context-{2:2}
>> > > [  151.574065] no locks held by swapper/0/0.
>> > > [  151.574066] stack backtrace:
>> > > [  151.574073] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.15.0 #1 PREEMPT(full) 
>> > > [  151.574078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>> > > [  151.574079] IRQ stage: Linux
>> > > [  151.574083] Call Trace:
>> > > [  151.574086]  <IRQ>
>> > > [  151.574088]  dump_stack_lvl+0x79/0xe0
>> > > [  151.574095]  __lock_acquire+0x942/0xbf0
>> > > [  151.574104]  lock_acquire+0xe2/0x2f0
>> > > [  151.574107]  ? __wake_up+0x21/0x60
>> > > [  151.574111]  ? find_held_lock+0x2b/0x80
>> > > [  151.574115]  _raw_spin_lock_irqsave+0x49/0x60
>> > > [  151.574120]  ? __wake_up+0x21/0x60
>> > > [  151.574122]  __wake_up+0x21/0x60
>> > > [  151.574125]  xnpipe_wakeup_proc+0x152/0x590
>> > > [  151.574132]  handle_synthetic_irq+0xc2/0x250
>> > > [  151.574137]  arch_do_IRQ_pipelined+0xca/0x180
>> > > [  151.574141]  </IRQ>
>> > > [  151.574142]  <TASK>
>> > > [  151.574144]  sync_current_irq_stage+0xaa/0x110
>> > > [  151.574147]  inband_irq_enable+0x42/0x60
>> > > [  151.574151]  cpuidle_idle_call+0x17d/0x200
>> > > [  151.574155]  do_idle+0x89/0xd0
>> > > [  151.574158]  cpu_startup_entry+0x29/0x30
>> > > [  151.574160]  rest_init+0xf0/0x190
>> > > [  151.574164]  start_kernel+0x632/0x700
>> > > [  151.574179]  x86_64_start_reservations+0x18/0x30
>> > > [  151.574185]  x86_64_start_kernel+0x78/0x80
>> > > [  151.574188]  common_startup_64+0x13e/0x148
>> > > [  151.574198]  </TASK>
>> > > 
>> > > That seems to be triggered by the Xenomai 3 smokey testsuite.
>> > > 
>> > > Any ideas?
>> > 
>> > Does this happen when full preemption is disabled on x86?
>> 
>> Test-Log: https://lava.xenomai.org/scheduler/job/21679
>> Kernel-Config: https://source.denx.de/Xenomai/xenomai-images/-/blob/next/recipes-kernel/linux/files/amd64_defconfig?ref_type=heads
>> 
>
> Btw: Enabling CONFIG_DEBUG_ENTRY on 6.15 delivers:
>
> vmlinux.o: warning: objtool: do_int80_emulation+0x204: return with instrumentation enabled
> vmlinux.o: warning: objtool: irqentry_exit+0xdc: call to synchronize_pipeline() leaves .noinstr.text section
> vmlinux.o: warning: objtool: ct_idle_exit+0x1: call to inband_irq_save() leaves .noinstr.text section
> vmlinux.o: warning: objtool: cpuidle_enter_state+0x1a4: return with instrumentation enabled
> vmlinux.o: warning: objtool: default_idle+0x7: call to inband_irq_disable() leaves .noinstr.text section
> vmlinux.o: warning: objtool: mwait_idle+0x44: call to inband_irq_disable() leaves .noinstr.text section
> vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x9a: call to inband_irq_disable() leaves .noinstr.text section
> vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x60: call to inband_irq_enable() leaves .noinstr.text section
> vmlinux.o: warning: objtool: intel_idle_irq+0x54: call to inband_irq_disable() leaves .noinstr.text section
> vmlinux.o: warning: objtool: acpi_safe_halt+0x1a: call to inband_irq_disable() leaves .noinstr.text section
> vmlinux.o: warning: objtool: poll_idle+0x1d: call to inband_irq_enable() leaves .noinstr.text section
>
> Is that something we should look into?

Yes, we need to keep those calls within the instrumentation_begin/end
blocks, or annotate them. There are imbalanced calls to fix as well,
e.g.

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 54749f4736633..cb1b4ad38568c 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -173,6 +173,7 @@ __visible noinstr void do_int80_emulation(struct pt_regs *regs)
 	if (dovetailing()) {
 		if (nr == EXIT_SYSCALL_OOB) {
 			hard_local_irq_disable();
+			instrumentation_end();
 			return;
 		}
 		if (nr == EXIT_SYSCALL_TAIL)

-- 
Philippe.
