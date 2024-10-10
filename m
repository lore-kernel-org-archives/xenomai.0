Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E771CDA2E
	for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576430; cv=none; b=h/vr8pqgSc61lSBNO8zkSyL//istQcsMyygxrjoZyHmwA0fwXgSx0jFosXsN+nZpLziPZvvnRQMHSRob7zUoLab0rkFipkddaa8vs1foQkkC0nN09mv6Kuv3nmYX1Nt/9gdtD+P0NaSlu6F/jw2EiWoMO/265Nk6oDrFd/T/VlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576430; c=relaxed/simple;
	bh=bcQkS3D2UH17P34XyIlJs1ly38ljnANfDLu7j/YkYVY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QtjSnXjIkNqN1P6OGuPGfR4Ji92u7XOgEhYSPQdZ9vE3g61hXLAxlw7rFmnWTHD+3eEIi2idlJUL3vaDPIL0ujNDN9uaXimd4owOUdsVvYG/lo+S0SOOyeSa5SNIpAyzj8UKT+hpSA+MfdJ0HNdRKDDo2/HyZp6Xd3J02mFcvAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37ccebd7f0dso681256f8f.1
        for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 09:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728576426; x=1729181226;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG9+jWhZqbfNsYCRWPmAPghcZIq/KE9gWuZJ804xtko=;
        b=mbU0QABJ/03d6z1DEXlQ4d5SkcuF/Ua+OJ5iq1q6i/V94c3ulvKfIuykIVYrFhVFJa
         3Uu5BA+K/Axt3HoQPB0GVUSYJsAuHGlRYTlA59PKJkhXYMYW5sppN3RaZpQ7zNtitMwq
         pUuZRl4gpz8Yihxzp5eVthVdZH4BdXjEm5vG5zUu68DNgyn3TkTzYkmjITWTGTn/LpCt
         e5472MwjN/M+f+HaxMNufxpgtehzHO1ZWUxtLSbARVCug1akamfZYYsx3zW2kcKw4tSN
         dtVtnJnUf1beBBEvd/fIjrEBT9o22dFBUlKnav0SX7nTdt4v4kuJY4EREqWE53+nyWMk
         4IBg==
X-Gm-Message-State: AOJu0YxcK+/nH4VxVTnXyVZji47JemNTzAu/CwfN2SHjigqzu/FqBAUh
	pihX9XCyw9zme0lJ4q84CNaPfgu/uyH4QnzLk73790vV3Aw2hsV5
X-Google-Smtp-Source: AGHT+IGwNmVT6hxyQyX8KhjSPW2G6m1RRi9Ewb6Yx+b7fPPOaazjI9F+SvqoqfkD6k3IBvk1wmPiUQ==
X-Received: by 2002:a5d:6441:0:b0:37c:d227:d193 with SMTP id ffacd0b85a97d-37d3a9b73b7mr4527310f8f.10.1728576426202;
        Thu, 10 Oct 2024 09:07:06 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd057sm1884586f8f.35.2024.10.10.09.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 09:07:05 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  jan.kiszka@siemens.com
Subject: Re: [PATCH dovetail 6.x] x86: dovetail: Fix inband IRQ state
 corruption on out-of-band compat syscall
In-Reply-To: <20241010154421.23303-1-florian.bezdeka@siemens.com> (Florian
	Bezdeka's message of "Thu, 10 Oct 2024 17:44:21 +0200")
References: <20241010154421.23303-1-florian.bezdeka@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Thu, 10 Oct 2024 18:07:05 +0200
Message-ID: <87frp4aqmu.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> The following kernel splat was found when running the Xenomai 3
> testsuite in compat on dovetail enabled kernels:
>
> [  513.620975] IRQ pipeline: some code running in oob context 'Xenomai'
>                              called an in-band only routine
> [  513.620998] CPU: 0 PID: 510 Comm: smokey Not tainted 6.10.0+ #76
> [  513.621003] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  513.621005] IRQ stage: Xenomai
> [  513.621007] Call Trace:
> [  513.621011]  <TASK>
> [  513.621015]  dump_stack_lvl+0x6f/0xd0
> [  513.621202]  __inband_irq_enable+0xb/0x60
> [  513.621249]  do_int80_emulation+0x68/0x160
> [  513.621265]  asm_int80_emulation+0x1a/0x20
> [  513.621285] RIP: 0023:0xf7f692ba
> [  513.621288] Code: Unable to access opcode bytes at 0xf7f69290.
> [  513.621303] RSP: 002b:00000000ffeedf40 EFLAGS: 00000282 ORIG_RAX: 0000000000000127
> [  513.621307] RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00000000ffeedfa0
> [  513.621309] RDX: 0000000000088000 RSI: 0000000000000000 RDI: 00000000f7f7aff4
> [  513.621311] RBP: 00000000ffeedf88 R08: 0000000000000000 R09: 0000000000000000
> [  513.621313] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> [  513.621315] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  513.621319]  </TASK>
>
> When entering the low level entry code from the out-of-band stage
> the in-band IRQ state was changed. That is now avoided by calling
> syscall_enter_from_user_enable_irqs() as all other entry points do.
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/x86/entry/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 467e2511df2e..13589f1ca89b 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -259,7 +259,7 @@ __visible noinstr void do_int80_emulation(struct pt_regs *regs)
>  
>  	nr = syscall_32_enter(regs);
>  
> -	local_irq_enable_full();
> +	syscall_enter_from_user_enable_irqs();
>  	nr = syscall_enter_from_user_mode_work(regs, nr);
>  
>  	if (dovetailing()) {

Ack. Merged into 6.1.y, 6.6.y and 6.11, dovetail and evl trees.

-- 
Philippe.
