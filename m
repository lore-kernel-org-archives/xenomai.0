Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CBD25D218
	for <xenomai@lists.linux.dev>; Wed, 10 Sep 2025 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489474; cv=none; b=oQN6mQ6YWKtGLJPy4yRQN+swMvxNbEl135XqApg9NUPASk35eX6KumT844qZ68LR+B6BLJz7aCVTrMhN2QCZbWWeUjY/IEOa8/QpRVDwZm9eOHVm2QcCmIQ+NqdANxwRbIl6NKN6V0brnn1CteRW0Wf5XqYqed55ZaVv7Kg5SjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489474; c=relaxed/simple;
	bh=6y4Aeb/n0iye+wuiVAM3YrOs2DJ3UatOKx7TIefUUPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fxGmV/dStzqNR9VKmGg95D+ptD/WWHiINQdSp/LNouqJaD4QywRWCB0XGwyh0HBdY7amXMSNJN2BfRoxr0RCQFf6oNmIrQPgmsHpXQzywpyKGfwBKq41I76tMp3Sdqk7HlmEBniVPoh9ERUowjU/Sfi2dXvNPNxl6Urynu0Mh6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=flGb/8JJ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="flGb/8JJ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3326F43EAE;
	Wed, 10 Sep 2025 07:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1757489464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ndOaW9d1v53D+7sDgVH/37oOuFUTXNMaiG0bo5+i02U=;
	b=flGb/8JJujpUAxl8i4bpY4b+5EQtu/Y58tnVnEk96zkLBj/QvqziAS5u3doHya0wowkWgW
	bCJnRWuvCL1DBIioiXBu7i7XMcAOlW5VGoReHU9hLyaiV5n1kt6vL7B9ozMmALvy8WQWtN
	/1L+Aq3XNuC8yNPyh6iMSV9PZAAxEEab+47npDdFMSgcJPGcu+es0Cbzcs8UI9pLozg0Ou
	IdTdJvb/5Mu/SmOkMVkXCVjPZnv5HCXA0t1sOd7CytaIzK3i1oy1NsJe1j0O4LFKSWzPKl
	RwjS01N8Xt5hNDd72dWfsEDbA04X9/JnnEVPfulkc9AcFG9dYKtOzSQbS39nPw==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail v3] irq_pipeline: Fix system freeze triggered
 by edge IRQs
In-Reply-To: <20250820-wip-flo-fix-edge-irq-handling-v3-1-8cc08939e6ca@siemens.com>
	(Florian Bezdeka's message of "Tue, 09 Sep 2025 15:30:09 +0200")
References: <20250820-wip-flo-fix-edge-irq-handling-v3-1-8cc08939e6ca@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 10 Sep 2025 09:31:03 +0200
Message-ID: <87v7lqydag.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepffffkeelffdvhfffjeduteehudeftdehudffffdvuddujedvhedvheejjeelhefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> When IRQ pipelining is enabled, it could happen that handle_edge_irq()
> is interrupted while syncing the IRQ log - for the very same IRQ.
>
> The pipeline entry code will set the IRQS_PENDING flag and bail out
> forcing the sync code (lower part in handle_edge_irq()) to loop to
> infinity as the (periodic) IRQ might fire again after calling
> unmask_irq() and reaching the hard IRQ enablement in handle_irq_event().
>
> There is a "race window" involved. To trigger looping to infinity the
> IRQ(s) must arrive while processing the IRQ log for the same IRQ in
> handle_irq_event().
>
> Call graph, delivered by a modified NMI handler and NMI injected by
> hyper-v:
> [    5.929380] Call Trace:
> [    5.929381]  <NMI>
> [    5.929383]  default_do_nmi+0xd9/0x110
> [    5.929387]  exc_nmi+0xde/0x110
> [    5.929388]  end_repeat_nmi+0xf/0x53
> [    5.929390] RIP: 0010:mask_ioapic_irq+0x86/0xf0
> [    5.929392] Code:
> [    5.929392] RSP: 0000:ffffa1c680003e48 EFLAGS: 00010086
> [    5.929393] RAX: ffffffffff5fc000 RBX: 0000000000000086 RCX: ffff8e4f01049340
> [    5.929393] RDX: 0000000000203000 RSI: 0000000000010030 RDI: 0000000000000014
> [    5.929394] RBP: ffff8e4f01049320 R08: 0000000000000012 R09: 0000000000000001
> [    5.929394] R10: 0000000000000000 R11: 770e017136e49082 R12: ffffffffac506000
> [    5.929395] R13: ffff8e4f3ec49840 R14: 0000000000000000 R15: 0000000000000000
> [    5.929402]  </NMI>
> [    5.929402]  <IRQ>
> [    5.929402]  handle_edge_irq+0x300/0x320
> [    5.929405]  generic_pipeline_irq_desc+0xc2/0x220
> [    5.929408]  arch_handle_irq+0x5d/0x180
> [    5.929410]  arch_pipeline_entry+0x38/0xf0
> [    5.929413]  asm_common_interrupt+0x22/0x40
> [    5.929421]  handle_irq_event+0xbe/0xe0
> [    5.929424]  handle_edge_irq+0x1ec/0x320
> [    5.929425]  arch_do_IRQ_pipelined+0xa5/0x560
> [    5.929427]  </IRQ>
> [    5.929427]  <TASK>
> [    5.929428]  sync_current_irq_stage+0x191/0x240
> [    5.929430]  __inband_irq_enable+0x48/0x60
> [    5.929431]  setup_IO_APIC+0x36b/0x860
> [    5.929434]  ? ioapic_read_entry+0x1a/0x80
> [    5.929436]  ? clear_IO_APIC_pin+0x1d/0x240
> [    5.929437]  ? clear_IO_APIC_pin+0x190/0x240
> [    5.929440]  apic_intr_mode_init+0x6f/0xf0
> [    5.929441]  x86_late_time_init+0x20/0x40
> [    5.929442]  start_kernel+0x743/0x890
> [    5.929445]  x86_64_start_reservations+0x14/0x30
> [    5.929446]  x86_64_start_kernel+0xc1/0xd0
> [    5.929447]  common_startup_64+0x13e/0x148
> [    5.929452]  </TASK>
>
> Enabling some debug options like CONFIG_PROVE_LOCKING widens this
> window as execution time increases.
>
> If we detect that the very same IRQ line is currently processed while we
> receive another hard irq, the current event is logged into the IRQ log.
> The event gets replayed within the same sync run in
> sync_current_irq_stage().
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Hi all,
>
> the problem could be observed and debuged quite well on hyper-v with
> lockdep enabled and a slightly modified NMI handler to print out the
> current call stack.
>
> This seems to be a long standing issue for Dovetail. We had several
> reports in the past that debug options (like lockdep) on hypervisors
> (like VirtualBox) ended up in a boot failure.
>
> Once we agree that the patch is correct I can send backports, if
> necessary, haven't checked that yet.
>
> Best regards,
> Florian
>
> CC: Philippe Gerum <rpm@xenomai.org>
> CC: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> Changes in v3:
> - Introduce irq_active_on_this_cpu() 
> - Link to v2: https://lore.kernel.org/r/20250820-wip-flo-fix-edge-irq-handling-v2-1-1a958d17eace@siemens.com
>
> Changes in v2:
> - v1 crashed qemu, similar to 
>   https://lore.kernel.org/all/20250701163558.2588435-1-liangyan.peng@bytedance.com/
>   so v1 was analyzed further and reworked completely 
> - Link to v1: https://lore.kernel.org/r/20250820-wip-flo-fix-edge-irq-handling-v1-1-1a2c7805b372@siemens.com
> ---
>  kernel/irq/chip.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index f5dfc378ccf2..12b820c99bb9 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -639,6 +639,26 @@ static inline bool should_feed_pipeline(struct irq_desc *desc, int state)
>  	return false;
>  }
>  
> +static bool irq_active_on_this_cpu(struct irq_desc *desc)
> +{
> +	struct irq_data *data = &desc->irq_data;
> +	const struct cpumask *aff;
> +

        if (!IS_ENABLED(CONFIG_SMP))
                return true;
               
> +	/* Check if active on any CPU */
> +	if (!irqd_irq_inprogress(data))
> +		return false;
> +
> +	/* The below works only for single target interrupts */
> +	if (!irqd_is_single_target(data) || desc->handle_irq != handle_edge_irq)
> +		return false;
> +
> +	aff = irq_data_get_effective_affinity_mask(data);
> +	if (cpumask_first(aff) != smp_processor_id())
> +		return false;
> +
> +	return true;
> +}
> +
>  static bool irq_can_handle_pm(struct irq_desc *desc)
>  {
>  	unsigned int mask = IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED;
> @@ -669,6 +689,8 @@ static bool irq_can_handle_pm(struct irq_desc *desc)
>  		WARN_ON_ONCE(irq_pipeline_debug() && !in_pipeline());
>  		if (irqd_is_wakeup_armed(&desc->irq_data))
>  			return true;
> +		if (irq_active_on_this_cpu(desc))
> +			return true;
>  	} else if (irq_pm_check_wakeup(desc))
>  		return false;
>  
>
> ---
> base-commit: fd7ae0eaafd268a5d1cbc2876d6cbe2a284b0d8c
> change-id: 20250820-wip-flo-fix-edge-irq-handling-16e48193aeac
>
> Best regards,

LGTM. Checking the arm* implementation, system peripheral interrupts
which are the ones we need to care about in this case are all set as
single targeted by the interrupt controller driver, so we would properly
check the effective affinity mask as expected.

-- 
Philippe.
