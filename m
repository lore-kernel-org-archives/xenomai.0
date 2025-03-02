Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5424CEEC8
	for <xenomai@lists.linux.dev>; Sun,  2 Mar 2025 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740928038; cv=none; b=kfTzD4dc2DSz2m7Uk1CR1Vt9LhTujn0zl/RAYkWx6P3FjoQwe+wj5xRw7NuO58P5W14HQPlvq8q3xm6db5Q7hVwygD1W5cyp5/og1rboBZFAmecd8nXd8rZyggvpfjavfSPRPVqYz3RlY5zXb4paJMJ17pA8ZYY2U1Qo6oS87Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740928038; c=relaxed/simple;
	bh=ZNPSBv2ytoNCD2wKjIzu27nRoE1g/u8QlupU8R3Kf4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HMUADo2W7zE8TxDFHugPZCGpXGPb/7vmsB9wbN/wGdYKWCEJLrffOyQ3I1RiGl9pBUDm3db471Rx3ZQ74mmNOYtiLksgWDAwPad6By9heB3eI81HICF725GmpZkin+twOg4XNpStd6CMbzHTvMI5hOKoPP/rDglscUPX6g6TI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ZTns7sGB; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ZTns7sGB"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E1DE5442DA;
	Sun,  2 Mar 2025 15:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1740928027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FS/7ssa2/jBYhOlkMovjdNepCxnC/0QI4ScFnI4SicI=;
	b=ZTns7sGBF1BdCkYUdcuY8JdpBm0LlYdGxwq69AsaQkenx/Sq9PfBP7oCrA5nGcpP5YChgu
	BirMaUzwCfnUzCcktBKYaxjZpGshOSHAJ4UHg8SPjb3By8PYmOTXgX8+vzomZMGaHP/tc+
	rs0qIEKLKUjj4c09I9/9NBsawKuc2+Vb4czb6rf6xIvMYfwbGEudbIUKqriD874dJ9ZB8/
	du278h/WByrkUcUc82qLZmkkozEnNAkFLOwEj4CnjQGkrTcXjjE8qfEDx0+rSolTThCzBh
	cwU90vtF7DVAkvRAAOonBz4/Xq0ymtLFi02PfbBRWMr3AQ1lm0hYHOxRDATVkw==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  powertree <powertree@163.com>,  Jan Kiszka
 <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail] arm64: fpsimd: dovetail: Allow preemption of
 in-band fpsimd kernel sections
In-Reply-To: <20250219141759.2455053-1-florian.bezdeka@siemens.com> (Florian
	Bezdeka's message of "Wed, 19 Feb 2025 15:17:59 +0100")
References: <20250219141759.2455053-1-florian.bezdeka@siemens.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Sun, 02 Mar 2025 16:07:06 +0100
Message-ID: <87cyezh3ol.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelieehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepphhofigvrhhtrhgvvgesudeifedrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Preemption of in-band in-kernel fpsimd sections was not allowed /
> properly implemented in Dovetail up to now.
>
> That piled up again as some crypto code was optimized for arm64 in
> Linux 6.14. A possible call stack that makes clear that the FPU was
> corrupted follows. The inband stage was using crypto/FPU code inside
> the kernel and got interrupted by OOB.
>
> 	[  331.703695]  task_fpsimd_load+0xd0/0x214 (P)
> 	[  331.703713]  fpsimd_restore_current_state+0x9c/0xb8
> 	[  331.703732]  fpsimd_restore_current_oob+0x1c/0x2c
> 	[  331.703751]  dovetail_context_switch+0x90/0x180
> 	[  331.703769]  pipeline_switch_to+0x10/0x1c
> 	[  331.703792]  ___xnsched_run+0x1bc/0x29c
> 	[  331.703811]  run_oob_call+0x98/0x17c
> 	[  331.703830]  handle_irq_pipelined_finish+0x1e0/0x1ec
> 	[  331.703848]  handle_irq_pipelined+0x58/0x6c
> 	[  331.703865]  call_on_irq_stack+0x24/0x4c
> 	[  331.703884]  do_interrupt_handler+0x150/0x178
> 	[  331.703902]  el1_interrupt+0x44/0x11c
> 	[  331.703921]  el1h_64_irq_handler+0x18/0x24
> 	[  331.703941]  el1h_64_irq+0x6c/0x70                <- oob
> 	[  331.703957]  crc32c_le_arm64_4way+0x4c/0xc0 (P)   <- inband
> 	[  331.703978]  ext4_block_bitmap_csum_set+0x38/0x60
> 	[  331.704002]  ext4_mb_mark_context+0x1b0/0x398
> 	[  331.704025]  ext4_mb_mark_diskspace_used+0xd8/0x1f8
>
> To fix that we have to hook into the task switch as we do on x86 and
> invoke the FPU (re)store logic.
>
> Cc: powertree <powertree@163.com>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Philippe Gerum <rpm@xenomai.org>
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/arm64/include/asm/dovetail.h    | 10 +++++++--
>  arch/arm64/include/asm/fpsimd.h      |  7 +++++-
>  arch/arm64/include/asm/thread_info.h |  1 +
>  arch/arm64/kernel/fpsimd.c           | 33 ++++++++++++++++++++++++++++
>  4 files changed, 48 insertions(+), 3 deletions(-)

LGTM, stable under significant stress load on imx8mp.

    Acked-by: Philippe Gerum <rpm@xenomai.org>

-- 
Philippe.
