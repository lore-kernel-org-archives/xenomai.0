Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093635;
	b=ERCqr3N5yRfd2VxHE1prbUDVaRQ42oemEav+Wzl7AF3k+b4yXAk/VVbGSBUGM9pu+EwS
	 N2x3zchcoVtlKnfvisoLa1okvqxA26yDcrV19Me7dNThja4M2lg5wFMvxItx5PtkXS7+o
	 GLuHKKSvI9UtKFGf41SLGNNppjNo0fBY6CJ9ZJsHWufOU/WTv33OGHp8qWprbiu/vcAzq
	 ixaRAwh2fgX6mrNSIvNB8EyqirDsWnMVC9fxAQ/tyxb5HLWXt8wrXv1uWSt9bh0/q22ZI
	 R4DsTPDoeNX9ivEeRf7DSptzNk2ZEp72Io1Jf6HLYSl5VlQ8M5wzeJdlq8/BdJ17Jyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093635;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=o2IabQpz6/UBe8XzrQE+LtFX3GkH9yed4ThD+89MyvA=;
	b=LYiWzjHiAem0cR/x6gqcNesaR3UiD3RmOsb4Ge5SPJoIG4FreMcc+46rZrd656jrlEfw
	 VZe/UoShfqCIJi3YWtXXbQMpYMWKBfVZQA+E98r9eNVuB27FtxFCmAbAmkCbxh+ugZ+/8
	 ICYAD0ulmDrQkdxGfASo0eoEYcvtrBXXCcFby7mbKyZVmniX9cIBnFlBuiyr7pLkRDFhT
	 5QV2nL3PztXn6qfrZuy5JIhNQzTYcO4AC2ctHRYJk9GNcdRojtDv8GPCkwMT6y6QmALVl
	 mLwZdZAnlsc79jAp4G203asaJDIeT/sqr01E9FSZvOucv4tsaMAe1gO4r8pYH44s1EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=QCn7GHd6;
	arc=none smtp.remote-ip=217.70.183.201
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1BC606A320
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 13:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A1BC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=QCn7GHd6
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4CB23EC6B;
	Thu, 19 Nov 2026 13:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1795093626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o2IabQpz6/UBe8XzrQE+LtFX3GkH9yed4ThD+89MyvA=;
	b=QCn7GHd6J+o3daMT+ns6MG7lFW7f95b3H5/a3t15BerB6FKI4JQogRC84E3zDXyFrgNblW
	8qGlFeYfpwwS6OV0Jn+IUlmN8RaNqu+u/IwWMPu/tSw09qn2sdtEtEJmB9ahxOAJi938lq
	x1mCwIEefIKJv4NOEw2jWh6trrKhw18+dt15vg9ddtdmKKPzl3rFDKq3UPwKRWl7qBqqet
	UBiRecs7CzQDKGFOUHsIMAEYPzc0CxlEGSit4GWtD9GgloEbIwxJFYAldBFwLmWf+wiya8
	qU8U/kE0Ty9QVXmd+vrQwYI+Yfl3Ng0cQcmqgyjJmrmLiCNKTRhs11YUQJbQVg==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Florian Bezdeka
 <florian.bezdeka@siemens.com>
Subject: Re: [dovetail][PATCH] x86: dovetail: preserve in-band stall state
 across handle_bug()
In-Reply-To: <edda3386-02fc-4d36-9e87-ce3f2c4f1916@siemens.com> (Jan Kiszka's
	message of "Tue, 17 Nov 2026 18:10:25 +0100")
References: <edda3386-02fc-4d36-9e87-ce3f2c4f1916@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 19 Nov 2026 14:07:06 +0100
Message-ID: <87qzghnf5x.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTF5Lp1cGwWBltqCz3fp3UwIcazitWWTBTjWFMnPi1fok6cKaFeY4nmH1Rjm8mZYUtWiLw35tCpvHnS744Cowo9ED4g/rewJWW/BvtrMGZMu2pfuOv40VjngEnD871djX3szfc6SobPYCmQWGZynXTQLk/QZdqpR2qagmqmasSgBBMjMOYJA/137l+ULWfTVrGFEzxoZfhR9NTqIYnyT9TI8jpDTo/PLmc5YW2OAHa3pkC74d81vVxedITaYBJYQfzHJk+qWc57MKEX+pu9AIzt9W5z8kd/s9k5vGx9qwtpbU/cE7I26Oa+22whNuTP3wUPHIGQp1kEcnYTSYPjbZR4WkoJuF1xawNVBMqPIQpBbmglqKfWyxRllWXOFMzjMD3uxIARDd9L0eOdq4SA0XaAV2rGrfLzNJHC60asNIU5rhdAyzBhT9m2ZAekZ4aK1aGckeo08SQNiB5LVb5iEnJ99b4vtkijKsFfKcePmOKgg+3iuGKVAo2/KYmH588LKe6fXJ/zL6FOB9mVyn4P95DjzFXOS55pJ/1TpnXXqUvTWvfnrpZF9VY3iuyreNtaNvunrdH/SNeAF/WjP++cwvdBw4EXj8kQGpXarYQ8EUPLpkTomqve9siLvu9UU/gsBJIC5yGG0HzutHk+xjtvP+2OXKPqYIgsOxUiNPL6on7sAag
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> handle_bug() runs from the raw #UD entry, before irqentry_enter(), and
> returns straight to the exception site when a WARN() was handled. The
> trap only cleared the hardware interrupt flag, the in-band stall bit
> still reflects the state of the exception site.
>
> When the site ran with hard irqs on, handle_bug() used
> local_irq_enable_full() and local_irq_disable_full() for the in-band
> stage, which also unstall then stall the in-band stage. As a result:
>
> - a WARN() hit with in-band interrupts enabled returned with the
>   in-band stage stalled, leaking a virtually disabled interrupt state
>   into the interrupted code, until the next in-band irq enable.
> - a WARN() hit with in-band interrupts disabled (e.g. under
>   spin_lock_irqsave()) unstalled the in-band stage while reporting.
>
> Only restore the hard interrupt state, like upstream does with the
> (then non-virtualized) interrupt flag, on both stages.
>
> Assisted-by: opencode:Opus-5.5
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Taken from the root-cause analysis of
> https://gitlab.com/Xenomai/xenomai-images/-/jobs/18096537042, forward-
> ported to 7.3. I asked the LLM why inband stalling was added, but it 
> found "no reason". I asked if something in between the inband unstall 
> and restall could expect finding inband unstalled, and it found nothing. 
> Should be safe (TM).
>
>  arch/x86/kernel/traps.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 26a30aa31960d..afc73bcaa285b 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -476,12 +476,8 @@ noinstr bool handle_bug(struct pt_regs *regs)
>  	 * Since we're emulating a CALL with exceptions, restore the interrupt
>  	 * state to what it was at the exception site.
>  	 */
> -	if (regs->flags & X86_EFLAGS_IF) {
> -		if (running_oob())
> -			hard_local_irq_enable();
> -		else
> -			local_irq_enable_full();
> -	}
> +	if (regs->flags & X86_EFLAGS_IF)
> +		hard_local_irq_enable();
>  
>  	switch (ud_type) {
>  	case BUG_UD1_WARN:
> @@ -528,12 +524,8 @@ noinstr bool handle_bug(struct pt_regs *regs)
>  		regs->ip = addr;
>  	}
>  
> -	if (regs->flags & X86_EFLAGS_IF) {
> -		if (running_oob())
> -			hard_local_irq_disable();
> -		else
> -			local_irq_disable_full();
> -	}
> +	if (regs->flags & X86_EFLAGS_IF)
> +		hard_local_irq_disable();
>  	instrumentation_end();
>  
>  	return handled;

Merged, thanks.

-- 
Philippe.
