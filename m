Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3972139C9
	for <xenomai@lists.linux.dev>; Mon,  8 Sep 2025 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335095; cv=none; b=Adwhe6eaMPHmoWHAw2+I4mW6IOKHXOMMiU9oRXRTjp3ATGIN7L9GIRfO0ivZdua6XcF4qNwif5X0ZHRcBfy6rLVYea9tWV7B73Nza9R1zhuqugLCfCs1bdkCVLvZqa0jaKeFtMO7CSn+7lVkKxurU2d9s7nmX7hzyapHPnFdyZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335095; c=relaxed/simple;
	bh=yeiK8kyVmN/pWNmQ6lIKaFG9xgh80mOs8/X4Hx9E6XQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L0VQ1LlqQvEI4JyxZq7EC8mnZgnV/d+7GzN1oawSGi2kaynC+sXVej3PAQ2BkfH4zzSjZl+zAXWzufcC2PrFa05MZVUmN+xnop+HzizySOzO924egIBe4g4VOFfFdE27aRuKrQ9FKj9X26YsduWU7hACXuk/hnv624N98+YBcRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=JfIvWpXX; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="JfIvWpXX"
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE4FE1FD9C;
	Mon,  8 Sep 2025 12:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1757335085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FG7ZxltJF/NgqsBweLJyAO5o2vBdkYWrZ0QCY0ebPEE=;
	b=JfIvWpXXwK+K4LfTJLwBgPzzty5imo2q9rFLty/0Rbljv+HAEaiuFUZSCUHbG4AYocDKgi
	Rqu/6kT0iFASzk+XKekJukHA+I91DT7HVGBcKUl84DVOEXk+f17e8hEsi1Wi4JCC/gB6QH
	pJ4at+MY5uKpzBRiYp/OxJ2M1PtofLhIQrOuBTf+1N1tNox5uZAIDqcpVkIO5C+xfD6+mf
	uVVkjanN9qCHPQzttn8TYhiRLof1WkFpfnJKWf/OVpHsB9+ERbYO3GI61muDMcUD3SK8Xn
	00jRwZChL6kvCfWcm64gxBXvsmHqJj6sIAqxDBo6O7hfrnn6/cM0QXujJ0/7CA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.16 v3 2/3] arm64: fpsimd: dovetail: Align
 with x86 implementation
In-Reply-To: <20250820-wip-flo-fixes-for-dovetail-6-15-v3-2-ae4a674d8e10@siemens.com>
	(Florian Bezdeka's message of "Fri, 05 Sep 2025 16:26:26 +0200")
References: <20250820-wip-flo-fixes-for-dovetail-6-15-v3-0-ae4a674d8e10@siemens.com>
	<20250820-wip-flo-fixes-for-dovetail-6-15-v3-2-ae4a674d8e10@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 08 Sep 2025 14:38:04 +0200
Message-ID: <87qzwh86hf.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> The FPU preemption marker is only accessed from the current task, so
> we can avoid atomic operations. Moving the marker from the low level
> flags to the local (synchronous) flags to make that clear.
>
> Gives us some performance and aligns the arm64 implementation with x86.
> ---
>  arch/arm64/include/asm/thread_info.h | 10 +++++-----
>  arch/arm64/kernel/fpsimd.c           |  7 +++++--
>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 3fb3725fb004..a4405b11189b 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -75,7 +75,6 @@ void arch_setup_new_exec(void);
>  #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
>  #define TIF_SECCOMP		11	/* syscall secure computing */
>  #define TIF_SYSCALL_EMU		12	/* syscall emulation active */
> -#define TIF_KERNEL_FP_PREEMPTED	15	/* Dovetail: kernel mode FPSIMD section preempted by OOB */
>  #define TIF_MAYDAY		16	/* Emergency trap pending */
>  #define TIF_RETUSER		17	/* INBAND_TASK_RETUSER is pending */
>  #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
> @@ -141,9 +140,10 @@ void arch_setup_new_exec(void);
>  /*
>   * Local (synchronous) thread flags.
>   */
> -#define _TLF_OOB		0x0001
> -#define _TLF_DOVETAIL		0x0002
> -#define _TLF_OFFSTAGE		0x0004
> -#define _TLF_OOBTRAP		0x0008
> +#define _TLF_OOB			0x0001
> +#define _TLF_DOVETAIL			0x0002
> +#define _TLF_OFFSTAGE			0x0004
> +#define _TLF_OOBTRAP			0x0008
> +#define _TLF_KERNEL_FPU_PREEMPTED	0x0010	/* Dovetail: kernel mode FPSIMD section preempted by OOB */
>  
>  #endif /* __ASM_THREAD_INFO_H */
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index aac0dbf6d84e..1f5fcac32b2d 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -2183,7 +2183,7 @@ void fpsimd_suspend_inband(void)
>  	 */
>  	if (test_thread_flag(TIF_KERNEL_FPSTATE)) {
>  		fpsimd_save_state(kfpu);
> -		set_thread_flag(TIF_KERNEL_FP_PREEMPTED);
> +		set_thread_local_flags(_TLF_KERNEL_FPU_PREEMPTED);
>  	}
>  }
>  
> @@ -2191,8 +2191,11 @@ void fpsimd_resume_inband(void)
>  {
>  	struct user_fpsimd_state *kfpu = this_cpu_ptr(&in_kernel_fpstate);
>  
> -	if (test_and_clear_thread_flag(TIF_KERNEL_FP_PREEMPTED))
> +	if (test_thread_local_flags(_TLF_KERNEL_FPU_PREEMPTED)) {
>  		fpsimd_load_state(kfpu);
> +		clear_thread_local_flags(_TLF_KERNEL_FPU_PREEMPTED);
> +	}
> +
>  }
>  
>  #endif

Ack.

-- 
Philippe.
