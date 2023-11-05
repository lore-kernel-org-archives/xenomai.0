Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4EF10940
	for <xenomai@lists.linux.dev>; Sun,  5 Nov 2023 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-408382da7f0so27834115e9.0
        for <xenomai@lists.linux.dev>; Sun, 05 Nov 2023 07:52:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699199536; x=1699804336;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZJd9NCLIwzcNnyRjJaysp08enzh2CnM1MelxvBMdy0=;
        b=FkwvEEv89KdXjLyPY+bQku4TE6qzdZp5UEi+CGPI9LPXHjWDIyZKTWMz1A/zS1pL8S
         PzewglgZy0kfVZvMRMdm/bpHd4UdMHloefsFGqawC4ANUEikCjTsyq8kgTJ9MGXNPwWI
         rnunvRJThGc+pPHxYWuVzfrae/heUDRRZiJXPirPpIbjqyvV7DaeZfeWRi1PF25nnVBE
         PWh51Fdjv2GDr4N81XjANwxte1F45ZLyQKwDYDO2M4at2BJ4OEMQFyfXCBWYAv9QhzTj
         iw2ApTHCTW/V15V0lwwApTy6brQtIdxlnpnWmB3+gj1fdpM7UDGUJJFV1X49pfLMAjPm
         s4xA==
X-Gm-Message-State: AOJu0YwfvkGNeBpodNfVeg6eiQSHiJyCrCLq68MFZM5RA7mLGRd5ObCL
	1cSxZI/XBgIwkpW6vpYSKIQ=
X-Google-Smtp-Source: AGHT+IFG7Bz+CzF/zUjsiTyXqKhHKxeoFlErj2/u64Yag5z33qYGu8CeiNL+VHXOcS8vQJUI/rxqXQ==
X-Received: by 2002:a05:600c:1988:b0:402:ea96:c09a with SMTP id t8-20020a05600c198800b00402ea96c09amr22085711wmq.16.1699199535840;
        Sun, 05 Nov 2023 07:52:15 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id fb14-20020a05600c520e00b0040841e79715sm9074457wmb.27.2023.11.05.07.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 07:52:15 -0800 (PST)
References: <20231103081107.3400986-1-clara.kowalsky@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Philippe Gerum <rpm@xenomai.org>
To: Clara Kowalsky <clara.kowalsky@siemens.com>
Cc: xenomai@lists.linux.dev, florian.bezdeka@siemens.com
Subject: Re: [PATCH][Dovetail 6.1] arm64: dovetail: Fix undefinstr/break
 trap handling
Date: Sun, 05 Nov 2023 16:52:03 +0100
In-reply-to: <20231103081107.3400986-1-clara.kowalsky@siemens.com>
Message-ID: <871qd4kxjp.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Clara Kowalsky <clara.kowalsky@siemens.com> writes:

> [ This is a backport of ca33f993e7b677f20a29150b14fd120416bf548e ]
>
> When running an compat RT application on arm64 the break trap is
> handled via the undefined instruction trap.
>
> A possible call stack looks like this:
>
> Call trace:
>   handle_inband_event+0x2d0/0x320
>   inband_event_notify+0x28/0x50
>   signal_wake_up_state+0x7c/0xa4
>   complete_signal+0x104/0x2d0
>   __send_signal_locked+0x1d0/0x3e4
>   send_signal_locked+0xf0/0x140
>   force_sig_info_to_task+0xa0/0x164
>   force_sig_fault+0x64/0x94
>   arm64_force_sig_fault+0x48/0x80
>   send_user_sigtrap+0x50/0x8c
>   aarch32_break_handler+0xac/0x1d0
>   do_undefinstr+0x6c/0x360
>   el0_undef+0x4c/0xd0
>   el0t_32_sync_handler+0xd0/0x140
>   el0t_32_sync+0x190/0x194
>
> The trap is never reported to the companion core at that stage so
> running_oob() in do_undefinstr() will always return true. As the
> following bailout happens before calling the compat breakpoint
> detection (aarch32_break_handler()) debugging the compat
> application does not work.
>
> Therefore do_undefinstr() reports the trap entry to the
> companion core. If the companion core handles the undefined instruction,
> running_oob returns true and the bailout occurs. Otherwise, switching to
> the in-band stage takes place and the undefined instruction handler
> continues with the compat breakpoint detection.
>
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  arch/arm64/kernel/traps.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index cc68be400244..5ea4cf543113 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -489,25 +489,28 @@ void arm64_notify_segfault(unsigned long addr)
>  
>  void do_undefinstr(struct pt_regs *regs, unsigned long esr)
>  {
> +	mark_trap_entry(ARM64_TRAP_UNDI, regs);
> +
>  	/*
>  	 * If the companion core did not switched us to in-band
>  	 * context, we may assume that it has handled the trap.
>  	 */
>  	if (running_oob())
> -		return;
> +		goto out_exit;
>  
>  	/* check for AArch32 breakpoint instructions */
>  	if (!aarch32_break_handler(regs))
> -		return;
> +		goto out_exit;
>  
>  	if (call_undef_hook(regs) == 0)
> -		return;
> +		goto out_exit;
>  
>  	if (!user_mode(regs))
>  		die("Oops - Undefined instruction", regs, esr);
>  
> -	mark_trap_entry(ARM64_TRAP_UNDI, regs);
>  	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
> +
> +out_exit:
>  	mark_trap_exit(ARM64_TRAP_UNDI, regs);
>  }
>  NOKPROBE_SYMBOL(do_undefinstr);

Merged, thanks.

-- 
Philippe.
