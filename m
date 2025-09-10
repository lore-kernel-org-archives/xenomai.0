Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF302153E7
	for <xenomai@lists.linux.dev>; Wed, 10 Sep 2025 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535421; cv=none; b=C/gbRk7GgULA5OpGDeGIRE2rX9uPLd+r//fJ9DWNEZc+0bYYRPMl7d0//oEmJbY/uUdvcdr5L7MmHOUKhno0psUTfCab4KhLZDqz6PIgXgkeJrqsRhHdRVJ2/KNdyINzo1QWDOWCL1cU1Z/zaifkdAiSWJ4Z8dPtx85xhZbvVWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535421; c=relaxed/simple;
	bh=DZVfzEiKN+tNjePUr6R9LxsG4FxqQexa41EFsGbyA8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iifgeRQiHrXibdGX9ny5SjMdqlT2vQJbSANAM99HcMR2n94d+h9EjCb6GzoubDWwvzisx93AMox8dLcWK4dCEGPVpIb1FxVL8rX+ODQWwftfPYOMIiV9cSvCcaJ0ipd3YSX0yZPSJPae5Ca7AaTl74Eo9MCZm/UCINwMzchFB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=FU/QxwrB; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="FU/QxwrB"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4938B1F47E;
	Wed, 10 Sep 2025 20:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1757535410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L/5RR4nDLKjgxT8kWcLBI+HulbHDf3AzaIWFuk6WzeY=;
	b=FU/QxwrBAAyqkEPn6bvZqzhwiMKIXuMmVGa+X/GNc/17SyqwebyFk/kiOagYp5rUaxUiSb
	BTuwoXA5LBh8N6L2Zf67eYd0LH9Y7dQjQCo9O/s02MrxfzqphFlaKc78obBG5yG07s6FC3
	/P/2gQdzWkTSRpCOqBv7+XR1ZW9aW/lbmcQAtVvievaK1QfM5U/LInqTRxUEZxPzIoL9rD
	QAKDuQSM3LD7nrYrrLL/McGyovQYXX/eYNgin0J+CdpK/LGfUMeccAQoN+ursmOdViXB/H
	FPfdEvwx3wArS2qbRgCE+5Xkjh4gv8hCfknnkTmz/AOgKytBo1XmBbgA9zRVZw==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail v3] irq_pipeline: Fix system freeze triggered
 by edge IRQs
In-Reply-To: <70fc78203891494dc3aac1b8b4869a050485fc1c.camel@siemens.com>
	(Florian Bezdeka's message of "Wed, 10 Sep 2025 10:15:38 +0200")
References: <20250820-wip-flo-fix-edge-irq-handling-v3-1-8cc08939e6ca@siemens.com>
	<87v7lqydag.fsf@xenomai.org>
	<70fc78203891494dc3aac1b8b4869a050485fc1c.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 10 Sep 2025 22:16:49 +0200
Message-ID: <87ecsexdu6.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepffffkeelffdvhfffjeduteehudeftdehudffffdvuddujedvhedvheejjeelhefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Wed, 2025-09-10 at 09:31 +0200, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > When IRQ pipelining is enabled, it could happen that handle_edge_irq()
>> > is interrupted while syncing the IRQ log - for the very same IRQ.
>> > 
>> > The pipeline entry code will set the IRQS_PENDING flag and bail out
>> > forcing the sync code (lower part in handle_edge_irq()) to loop to
>> > infinity as the (periodic) IRQ might fire again after calling
>> > unmask_irq() and reaching the hard IRQ enablement in handle_irq_event().
>> > 
>> > There is a "race window" involved. To trigger looping to infinity the
>> > IRQ(s) must arrive while processing the IRQ log for the same IRQ in
>> > handle_irq_event().
>> > 
>> > Call graph, delivered by a modified NMI handler and NMI injected by
>> > hyper-v:
>> > [    5.929380] Call Trace:
>> > [    5.929381]  <NMI>
>> > [    5.929383]  default_do_nmi+0xd9/0x110
>> > [    5.929387]  exc_nmi+0xde/0x110
>> > [    5.929388]  end_repeat_nmi+0xf/0x53
>> > [    5.929390] RIP: 0010:mask_ioapic_irq+0x86/0xf0
>> > [    5.929392] Code:
>> > [    5.929392] RSP: 0000:ffffa1c680003e48 EFLAGS: 00010086
>> > [    5.929393] RAX: ffffffffff5fc000 RBX: 0000000000000086 RCX: ffff8e4f01049340
>> > [    5.929393] RDX: 0000000000203000 RSI: 0000000000010030 RDI: 0000000000000014
>> > [    5.929394] RBP: ffff8e4f01049320 R08: 0000000000000012 R09: 0000000000000001
>> > [    5.929394] R10: 0000000000000000 R11: 770e017136e49082 R12: ffffffffac506000
>> > [    5.929395] R13: ffff8e4f3ec49840 R14: 0000000000000000 R15: 0000000000000000
>> > [    5.929402]  </NMI>
>> > [    5.929402]  <IRQ>
>> > [    5.929402]  handle_edge_irq+0x300/0x320
>> > [    5.929405]  generic_pipeline_irq_desc+0xc2/0x220
>> > [    5.929408]  arch_handle_irq+0x5d/0x180
>> > [    5.929410]  arch_pipeline_entry+0x38/0xf0
>> > [    5.929413]  asm_common_interrupt+0x22/0x40
>> > [    5.929421]  handle_irq_event+0xbe/0xe0
>> > [    5.929424]  handle_edge_irq+0x1ec/0x320
>> > [    5.929425]  arch_do_IRQ_pipelined+0xa5/0x560
>> > [    5.929427]  </IRQ>
>> > [    5.929427]  <TASK>
>> > [    5.929428]  sync_current_irq_stage+0x191/0x240
>> > [    5.929430]  __inband_irq_enable+0x48/0x60
>> > [    5.929431]  setup_IO_APIC+0x36b/0x860
>> > [    5.929434]  ? ioapic_read_entry+0x1a/0x80
>> > [    5.929436]  ? clear_IO_APIC_pin+0x1d/0x240
>> > [    5.929437]  ? clear_IO_APIC_pin+0x190/0x240
>> > [    5.929440]  apic_intr_mode_init+0x6f/0xf0
>> > [    5.929441]  x86_late_time_init+0x20/0x40
>> > [    5.929442]  start_kernel+0x743/0x890
>> > [    5.929445]  x86_64_start_reservations+0x14/0x30
>> > [    5.929446]  x86_64_start_kernel+0xc1/0xd0
>> > [    5.929447]  common_startup_64+0x13e/0x148
>> > [    5.929452]  </TASK>
>> > 
>> > Enabling some debug options like CONFIG_PROVE_LOCKING widens this
>> > window as execution time increases.
>> > 
>> > If we detect that the very same IRQ line is currently processed while we
>> > receive another hard irq, the current event is logged into the IRQ log.
>> > The event gets replayed within the same sync run in
>> > sync_current_irq_stage().
>> > 
>> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> > ---
>> > ---
>> > Changes in v3:
>> > - Introduce irq_active_on_this_cpu() 
>> > - Link to v2: https://lore.kernel.org/r/20250820-wip-flo-fix-edge-irq-handling-v2-1-1a958d17eace@siemens.com
>> > 
>> > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>> > index f5dfc378ccf2..12b820c99bb9 100644
>> > --- a/kernel/irq/chip.c
>> > +++ b/kernel/irq/chip.c
>> > @@ -639,6 +639,26 @@ static inline bool should_feed_pipeline(struct irq_desc *desc, int state)
>> >  	return false;
>> >  }
>> >  
>> > +static bool irq_active_on_this_cpu(struct irq_desc *desc)
>> > +{
>> > +	struct irq_data *data = &desc->irq_data;
>> > +	const struct cpumask *aff;
>> > +
>> 
>>         if (!IS_ENABLED(CONFIG_SMP))
>>                 return true;
>
> - That would make the function name somehow "incorrect".
>
> - irq_active_on_this_cpu() was designed to return true only for one
>   very specific case: pipeline entry for an edge triggered IRQ while
>   synchronizing the very same IRQ line on the same CPU.
>

irq_active_on_this_cpu() is expected to be called only after
IRQD_IRQ_INPROGRESS was found in the descriptor, therefore if
!CONFIG_SMP in addition, we do have an interrupt in progress on the only
CPU available on the system, i.e. the current one. If we don't yield
true in this case, I can't see how this would fix the issue at stake for
uniprocessor hardware.

>   The caller (irq_can_handle_pm()) is also involved in non-edge IRQ 
>   handling which makes me nervous. Was that on your radar?
>

I think those are ok since only the flow handler for edge irqs polls
IRQS_PENDING, which is the root of the issue.

> - I think that !CONFIG_SMP is handled correctly - at least for edge
>   IRQS - as the effective CPU mask should be 0 and equal to 
>   smp_processor_id()

-- 
Philippe.
