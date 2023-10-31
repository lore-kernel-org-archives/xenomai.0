Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C324819BA5
	for <xenomai@lists.linux.dev>; Tue, 31 Oct 2023 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4083f613272so45466025e9.1
        for <xenomai@lists.linux.dev>; Tue, 31 Oct 2023 04:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698750732; x=1699355532;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGkOcwqPm5lVGDRbCajOZH+ub1jZFsyqSNidgQhDSAs=;
        b=drTdXgj0VD/a6VT5rup27zML0dpr5oT9Y6syEByt+r+ygpUoCdUCJ8MAl3Z7WQN7XB
         Mr8pXC1MyJME2VtL2uM2q+0NWIGMqxF7/U55h16rP8R7Ho/yf/JpFRY395L3EfXO3KtJ
         c0E/mtJR6eMOuHR594d/pHtqzlvssUCzG758VNCVYWSIKAIzCYt7l+YNSeyn7s4ORlBJ
         lgKsWiC3CeK59grduJR6kqwbHNR5wbAw3sQUjHJhNpoR/KK42i6NjPLMlNRKuqhOTTjO
         g4xYEZXJQfRFJ9+HPTxIpyiiuoQfKbO+OsuVNTEimSVCegA3jsL3/pu3tP6iH2GqbkfD
         dJJg==
X-Gm-Message-State: AOJu0Yw+tCsvxVsINC/2JKSplFU/KQmfHpn+8urZEbQPLBOu0hTYg5ye
	l4bmA49vcAs6AQ5dUILP0Wh1FIKPGiQwMg==
X-Google-Smtp-Source: AGHT+IF8RnO7a7+/MdLjBEuay+hasYVxCUX1Ooi33vY9Jf6U+MhQo1sGO+G7WGJ7hR8sAPguk0zFzQ==
X-Received: by 2002:a5d:53cb:0:b0:32d:8e6f:ecb3 with SMTP id a11-20020a5d53cb000000b0032d8e6fecb3mr7501752wrw.65.1698750731686;
        Tue, 31 Oct 2023 04:12:11 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id bs26-20020a056000071a00b0032f97839001sm934248wrb.101.2023.10.31.04.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 04:12:11 -0700 (PDT)
References: <20231024093242.1077831-1-clara.kowalsky@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Philippe Gerum <rpm@xenomai.org>
To: Clara Kowalsky <clara.kowalsky@siemens.com>
Cc: xenomai@lists.linux.dev, florian.bezdeka@siemens.com
Subject: Re: [PATCH v3][Dovetail 6.6] arm64: dovetail: Fix undefinstr/break
 trap handling
Date: Tue, 31 Oct 2023 11:46:11 +0100
In-reply-to: <20231024093242.1077831-1-clara.kowalsky@siemens.com>
Message-ID: <87lebjgi5x.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Clara Kowalsky <clara.kowalsky@siemens.com> writes:

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
> In addition the emulation of the deprecated armv8 SWP{B} instruction
> (try_emulate_armv8_deprecated()) cannot be done from the out-of-band
> stage.
>
> Therefore do_undefinstr()/do_el0_undef reports the trap entry to the
> companion core. If the companion core handles the undefined instruction,
> running_oob returns true and the bailout occurs. Otherwise, switching to
> the in-band stage takes place and the undefined instruction handler
> continues with the compat breakpoint detection and the SWP{B}
> instruction emulation.
>
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  arch/arm64/kernel/traps.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index b0db35eda8f5..0811aa219ea7 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -456,29 +456,32 @@ void do_el0_undef(struct pt_regs *regs, unsigned long esr)
>  {
>  	u32 insn;
>  
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
>  	if (user_insn_read(regs, &insn))
>  		goto out_err;
>  
>  	if (try_emulate_mrs(regs, insn))
> -		return;
> +		goto out_exit;
>  
>  	if (try_emulate_armv8_deprecated(regs, insn))
> -		return;
> +		goto out_exit;
>  
>  out_err:
> -	mark_trap_entry(ARM64_TRAP_UNDI, regs);
>  	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
> +
> +out_exit:
>  	mark_trap_exit(ARM64_TRAP_UNDI, regs);
>  }

Ack. I initially thought we could postpone the in-band switch until
after some of the emulation code paths have been considered (typically
the MRS stuff), but that would involve convoluted logic for no obvious
gain, so let's take the straightforward approach instead. The assumption
here is that issuing an (emulated) MRS read request from a userland
application should not happen from a time-critical context anyway, so
doing this in-band should be acceptable. We'll see from complains if its
not..

IOW, patch merged to v6.6, thanks.

PS: There are three Dovetail branches to maintain concurrently ATM,
twice that number when including the EVL trees. So please always mention
the kernel release any patch sent my way applies to, this may help
speeding up the process on my end (e.g. this patch conflicts, needs
manual backport to v5.10, v6.1.y).

-- 
Philippe.
