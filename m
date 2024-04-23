Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F7F225DD
	for <xenomai@lists.linux.dev>; Tue, 23 Apr 2024 06:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713853632; cv=none; b=Z4sqenZV9ZRg9n87V4VJYfpaTVnhQ3M0qUvVsEkRFRLORV8DT7u1378dGUWbMtjtBGt6BFHx6vlutPK0OwM0owMzR3VgbEe8yWTsTiH3FOrOKM2O7nbN8egYojqDAvseywTGZIsIWQ9HJKBfKGEa/TLaWypStVq8Zzdo3IbTiJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713853632; c=relaxed/simple;
	bh=TU1U7ZKFL9c/4FVRrfyQ0n3mor/9Ph20EZV8Yqzq1nY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Nt6LHThc65ceSDGtbKD+sFGawnrXGo1o/N36b/pRllCRAA2moARsNDPo7g3mvnDq8RY6O50i1Y4lZ756ltmLI/KFUaCD4kstSV+6imx4KNVtjWobwwzlMUpbV2HoI0Hw0DqC3FBAtR+kweuJIPuIPq6n9S5i+7FCOtPooyz1EvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34af8b880e8so1151405f8f.0
        for <xenomai@lists.linux.dev>; Mon, 22 Apr 2024 23:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713853629; x=1714458429;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VTmBrAgVAxNhKEKubxaja4wQHBTD9QHPY6cDwKc0oA=;
        b=Hwufzlm5BuUCtQew371OL8aD5o3Viq4YIRqr+IfDIvUnm5EriyZTp5akXtRSxhyppa
         K0xDEO4OpMJ5RNK438W76GOpBlyVy9yd4Nn98ZA5Ys+sm91gcnnSZ6qYPnOxNQQ+hPPy
         DUvw8i+xjLSbK2S7/I08PduNVF+S60HSHru74XQmjBU978F5xhRQvTOiMLWmJWfI1R+Q
         3Vc2Xa3Zq1HWSq/nc4DUyOL9+5ZcgtYo3m6WrHYtGAn8nybxsTb+ji8krA1ZvaZFsA4i
         Diyp2OwDl2DT/ktCRISFJD9NMQu7+pJJ7gIxUB3AuQ4HHxzyd0P+DpqOpMjCeZ7ikD9D
         e6dQ==
X-Gm-Message-State: AOJu0YynfnBfJICNOf9XcDeHhGliS4y4Xp0jijC+9vdIrIHtbt6pPATq
	PsHpN+2McpQwLGPXBAFPIsVxUq4BX61WBoEGhQi/+pXzbC0T0Fuh
X-Google-Smtp-Source: AGHT+IHHyPbwc7USz7HKYBLtYIRMxUrf0Zz7o560HFTIc7fmxkg14TE8QHEZWJsGUlHB9ZsNirMvHA==
X-Received: by 2002:a5d:4687:0:b0:34a:56e7:a7f3 with SMTP id u7-20020a5d4687000000b0034a56e7a7f3mr1065448wrq.21.1713853628461;
        Mon, 22 Apr 2024 23:27:08 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d5542000000b0034720354152sm13650019wrw.117.2024.04.22.23.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 23:27:07 -0700 (PDT)
References: <20240416102436.550147-1-florian.bezdeka@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Subject: Re: [PATCH dovetail 6.8, 6.6, 6.1] x86: dovetail: Fix compat
 syscall handling, account for new IDT entry
Date: Tue, 23 Apr 2024 08:26:55 +0200
In-reply-to: <20240416102436.550147-1-florian.bezdeka@siemens.com>
Message-ID: <87wmoozj9l.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> The following upstream commit introduces a new IDTENTRY for handling
> compat syscall. As that commit is now backported into stable trees it
> broke compat syscall handling for dovetail.
>
> be5341eb0d43 ("x86/entry: Convert INT 0x80 emulation to IDTENTRY")
>
> We no longer end up in do_int80_syscall_32() which has the dovetail
> specific bits. We need the same handling in asm_int80_emulation().
>
> The problematic part in asm_int80_emulation() is the call to
> do_syscall_32_irqs_on() which basically overwrites regs->ax
> unconditionally. Linux does not know about the co-kernel syscalls, so
> we get -ENOSYS for each syscall result.
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/x86/entry/common.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 0220ca163a32..42e8cb036fff 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -212,9 +212,21 @@ DEFINE_IDTENTRY_RAW(int80_emulation)
>  
>  	local_irq_enable();
>  	nr = syscall_enter_from_user_mode_work(regs, nr);
> +
> +	if (dovetailing()) {
> +		if (nr == EXIT_SYSCALL_OOB) {
> +			hard_local_irq_disable();
> +			return;
> +		}
> +		if (nr == EXIT_SYSCALL_TAIL)
> +			goto done;
> +	}
> +
>  	do_syscall_32_irqs_on(regs, nr);
>  
>  	instrumentation_end();
> +
> +done:
>  	syscall_exit_to_user_mode(regs);
>  }
>  #else /* CONFIG_IA32_EMULATION */

Merged, thanks.

-- 
Philippe.
