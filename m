Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D526C2185B8
	for <xenomai@lists.linux.dev>; Wed, 26 Feb 2025 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594506; cv=none; b=ZIMRE1BMaI51YdD5WzUrQyNSefRgLP7YQ97HK+9bSyplFoSy9LD+o5E73PjiMKa+ByWY3pbmLkxEsAccFR7QRpeoysc9Cnsoyb72RD1c7Rj6ElXI6lSPbqXMlRrKE1jXFnIwx7ywOsSPlmtadbsYQs1jMHHQfVkyIGp3SeYwb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594506; c=relaxed/simple;
	bh=znvXxwuDtNUUc2Vo/p8RXoVCJ46M8NlL1MDSFCsCf1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M6cmX9hwXeM3BGGRQTU7VYW3RQcc4/K/Lu4YEBm/IAfcPfVWXaps48gAZpyWef1rOfcXh4K98OSnsx9b6OJ9Fu+BJpr4FP9d2//A0fDuvgN4We8HGGzOZuThpAxX3Ry3SW4ADOAuh7yUpfzwEFyvBcQk/Wc53aHsj7+Cprw/1Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=j5UScrim; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="j5UScrim"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83C6744400;
	Wed, 26 Feb 2025 18:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1740594502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ALDc5sae8B/OA//5JVR6Hf0lnEukcHNTMEDB1cAJPo=;
	b=j5UScrimUC6E/+2y1oPQEsFTrf3+U+tdijhb1f52TGXSKlhid0rQkraLOiPaoyyhavCZ+D
	5ASBkE2vUJGyzB0WvJHJlrrV7LdpB1JYogF1XopMnCe4hteg20HCxoRlX8vz8m0dTTeuXx
	obd4rbxgRmYIljDSJ9+2E4/coOJ7Sz7vlSRDmy7FhRFyR3UUJ5AD1iG0mVW7D5ujdctEuw
	n6R7EPOqySTRHtKqPceyh4vywG6byZgEaU7CBIOvv6BGdCArzbmeCqo3KNbexgxICQc22/
	4p58afpkCf6wnGjRLWivGnPIY3FJp67nxoC4dZkyCGlEFG63XpgP5t1n4lcNSA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Dovetail boot hang on x86, kvm
In-Reply-To: <8ca54aaf8095e2a7df7197610642d778e8c8602c.camel@siemens.com>
	(Florian Bezdeka's message of "Wed, 26 Feb 2025 15:08:52 +0100")
References: <8ca54aaf8095e2a7df7197610642d778e8c8602c.camel@siemens.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 26 Feb 2025 19:28:16 +0100
Message-ID: <874j0gv9vj.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepueegtdfgudffudeljeetueejjeeileetleevheefkedtfedvudelueeggffghffgnecuffhomhgrihhnpehophgvnhhsuhhsvgdrohhrghenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi all,
>
> Jan recently reported the following boot hang on his KVM system when
> the host was running at high load:
>
> [    0.005000] x2apic enabled
> [    0.008000] APIC: Switched APIC routing to: cluster x2apic
> [    0.009000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.012000] Kernel panic - not syncing: timer doesn't work through Interrupt-remapped IO-APIC
> [    0.012000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.8+ #136
> [    0.012000] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
> [    0.012000] IRQ stage: Linux
> [    0.012000] Call Trace:
> [    0.012000]  <TASK>
> [    0.012000]  dump_stack_lvl+0x8b/0xd0
> [    0.012000]  panic+0x112/0x2e0
> [    0.012000]  panic_if_irq_remap+0x19/0x20
> [    0.012000]  check_timer+0x1fd/0x620
> [    0.012000]  ? lock_release+0x214/0x2a0
> [    0.012000]  setup_IO_APIC+0x17a/0x1d0
> [    0.012000]  apic_intr_mode_init+0xd0/0xe0
> [    0.012000]  x86_late_time_init+0x20/0x40
> [    0.012000]  start_kernel+0x8d7/0x970
> [    0.012000]  x86_64_start_reservations+0x20/0x20
> [    0.012000]  x86_64_start_kernel+0x87/0x90
> [    0.012000]  common_startup_64+0x13e/0x148
> [    0.012000]  </TASK>
>
> I revisited timer_irq_works() and friends, where the necessary Dovetail
> specific changes are in place.
>
> If my interpretation is correct the Dovetail enabled guest does not
> receive a timer IRQ while making progress (reading TSC).
>

So no tick was received after 4 jiffies? What if this delay is
significantly extended, is it the host actually too slowed down to send
it on time, or the interrupt request not making its way on the guest
side? Typically, could a tick be lingering in the interrupt log of the
CPU running timer_irq_works()?

To check the latter, we could poll for the log state along the following
lines, inside the readtsc() loop, e.g.

	struct irq_stage_data *p;
	unsigned long flags;

        flags = hard_local_irq_save();
	p = this_inband_staged();
	if (stage_irqs_pending(p)) {
                /* Houston, we have a problem. */
        }
	hard_local_irq_restore(flags);

Since we are running with hard irqs on, inband stage unstalled, except
while polling the log, no IRQ should be lingering in the latter.

-- 
Philippe.
