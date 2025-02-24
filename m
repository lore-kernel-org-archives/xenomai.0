Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8778E25B674
	for <xenomai@lists.linux.dev>; Mon, 24 Feb 2025 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418775; cv=none; b=tj60w0u+ttdHuizHM6Zm54tcOKNfXzwNhh/VVWN+VYp8KzK13TKSjFMtVBCvptZ1RUMNhNM5+0S/V5eWOt5rzgE8lKr4GRGworondrWKY71iaFYH+r/MNCpmeWXof5KPletkiOIFeTobwxqNEvAMn7Brq9+PK14gZlZVMYH7vBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418775; c=relaxed/simple;
	bh=R0uX9uwrXD81VwzqoKW0r7gMvVbu46rCJGx1cRUrhbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LF4dhYwW9yobntbqrcJYnq5TsFh2a4GavW/6RDSxb4/apSpx+oycKEXv3O7CCfZMMwgZfWLM0gWfiBo7Jd0F46FqGB96l6ZlKKjP8Qdc/7VG8RM2h7t1eD81uCplLxzGS1K+5xjvwwTePEDDC+L4SFUy/qrnI9pS9QHpK7hbH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=WGp1RKaA; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="WGp1RKaA"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 3E6FE583D0A
	for <xenomai@lists.linux.dev>; Mon, 24 Feb 2025 17:15:52 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2CF54443F;
	Mon, 24 Feb 2025 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1740417345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8myhKHyMquHiWW6mOkVPTDGe341nQrZY1nZisQIAVg=;
	b=WGp1RKaAHH+mRcs01H0c2aL30jgQ4c4PuEuDw6JTcPDz0vb2hAKovVxv1BigvOzhROtD6N
	ZOpbnMZMNoa5kjPAOwl3A/uIbMeUKTi8U9JLSun+7P5808gNt+TFWqWpRMnAYEM9X/vh2j
	Hg7kKCJ02+T/OY9dhu9Y4lufeMDDSbiNgMXn6hq0kmvSSTiv/hwlvbzSnXMXqIXrFEwRHw
	RTS2dEmWCh4wR8XNT93aRhbb1KZVJCWcYo3SHL8YJ3x9WooL6r/kMRob+pSv714/nlpbTt
	+RIkPBO7dur7L2/NHQBO6T2pZHpVOBuBGI1P9o0gJ0YbnHmsSZrFysyiUptDlA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Florian Bezdeka
 <florian.bezdeka@siemens.com>
Subject: Re: [PATCH] x86: dovetail: Harden __send_ipi_mask for KVM guests
In-Reply-To: <eeca1faa-bf32-47c9-aba7-fa197034dcac@siemens.com> (Jan Kiszka's
	message of "Mon, 24 Feb 2025 17:44:45 +0100")
References: <eeca1faa-bf32-47c9-aba7-fa197034dcac@siemens.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 24 Feb 2025 18:15:40 +0100
Message-ID: <87plj72rib.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepueegtdfgudffudeljeetueejjeeileetleevheefkedtfedvudelueeggffghffgnecuffhomhgrihhnpehophgvnhhsuhhsvgdrohhrghenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This function is called in case paravirtual IPIs of a KVM host are used.
> Just like for hard submission handlers, we need to harden the path to
> avoid splashes like these:
>
>  IRQ pipeline: some code running in oob context 'Xenomai'
>                called an in-band only routine
>  CPU: 0 PID: 410 Comm: (udev-worker) Not tainted 5.10.229-cip54+ #265
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
>  IRQ stage: Xenomai
>  Call Trace:
>   dump_stack+0x84/0x9c
>   inband_irq_save+0xa/0x30
>   __send_ipi_mask+0x81/0x260
>   ? preempt_count_sub+0x96/0xe0
>   ? _raw_spin_unlock_irq+0x33/0x50
>   ? xnsched_pick_next+0xe0/0xe0
>   ? ___xnsched_run+0x491/0x5b0
>   ? ktime_get_mono_fast_ns+0x50/0xb0
>   ___xnsched_run+0x491/0x5b0
>   run_oob_call+0x97/0x170
>   xnthread_start+0x23f/0x330
>   ? rt_stack_deliver+0x340/0x340 [rtnet]
>   rtdm_task_init.part.14+0x7e/0xc0
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/x86/kernel/kvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 5df1061fc6ee1..b183caf41aa44 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -525,7 +525,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
>  	if (cpumask_empty(mask))
>  		return;
>  
> -	local_irq_save(flags);
> +	flags = hard_local_irq_save();
>  
>  	switch (vector) {
>  	default:
> @@ -563,7 +563,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
>  			  ret);
>  	}
>  
> -	local_irq_restore(flags);
> +	hard_local_irq_restore(flags);
>  }
>  
>  static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)

Ack.

-- 
Philippe.
