Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329578;
	b=oY3UEmYwgx9FQm1ZIyZgFNichh8wnJwzw9WLN1/4tkbDWRXn198KFD8HebAIGNR6pjqd
	 A8preql3wS7xiABNsWG7ZhW4CZmxtOPFnj5BAMUZl+jTPdkXlTrO/1+x5b4KfE1ccPXl6
	 gvde/M1duvsapMA4EjHekmASVTKxKbr02ZjWwbZf3446YB88lZqqAXQzYOm+7v1D3gklL
	 gMAXnoH+exVbWhdVagQ1vhqzZ6tgmsN9KwD7OBrtyk38mnylmyScTr5zilTyqKCn057zd
	 u/4Geb6+dVwDXKH0rc9Yxz9x62joT9TNI6kLopRQFXt2DF96k8Dk/o2oKoG2IZVDHyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329578;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-State:X-GND-Score:X-GND-Cause;
	bh=BYNoie3YkrnErNjuUUce186fuZada0QcFoNc9aPXjGU=;
	b=Glel8FrMABYDJUxqvjM5VbKUQ/J0mq9rOiT8ZNTYi+/CFAiXT0hLP2cD8nKhubI5sJB4
	 E8TSTitYYbB3c0op4U2ix+9thRhv9SUal0ITJqlFnUE/ChBr0Bi3kkeoQT5bY0AQ8wX5v
	 JPdIXvpQ4IQkhc3rGQPluyTTQeM/xSJ6JEo23axB4AB76ABxia0VwlhFe6i9ANqyl2nXj
	 vh6VrBs8LniXj4234E3/fNpgiLDMlaijOOWrIoo80TdwbxJCpb3hrvKqTtn1t/ZzKaWxU
	 Icjwkns7BM4/6tuZc8xfb0ryXCbghIo4cHEgDkeJr3C4NsVUUbq8ofLYsRlbF6AhxNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=Glyosx53;
	arc=none smtp.remote-ip=217.70.183.197
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13160A381C
	for <xenomai@lists.linux.dev>; Tue, 10 Nov 2026 16:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D13160A381C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=Glyosx53
Received: by mail.gandi.net (Postfix) with ESMTPSA id 93C853F495;
	Tue, 10 Nov 2026 16:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794329569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BYNoie3YkrnErNjuUUce186fuZada0QcFoNc9aPXjGU=;
	b=Glyosx53X9GN85M7KkotFNUffwFvdi/4DspxGcWEhuRrmeQLD1CzXzege+R5PgoqjPnkV2
	0tHWz7cvQCiHKCxYpwIGnrj7gibHS8MaBk049BTSoWXfg0jrBCP/Gl+7ex75nHdCnE9jbf
	0cgvBc8Q4DoqzPiv5FLJ4hx5/MyKuQd5f4uHX+HKsg227XlUlq77hhipNmjAr+mKsfXlPO
	qeCyqEv0VFThtgz5fyWVnjvjnHDHfFy5zz6aoFxsPg93OXKcc0e+CM2X5SA2DRTkXZSFMc
	DsO8IJZju6dbI+bMmbNjAcpSDK0gVC47lfl9mA9eD5gtzqvQ/9Q0lQ4NP6TklQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Florian Bezdeka
 <florian.bezdeka@siemens.com>
Subject: Re: [dovetail][PATCH] arm64: dovetail: Notify the core about compat
 alignment fixups
In-Reply-To: <4d7b7926-4a09-40c0-b4e8-d5512f8107ef@siemens.com> (Jan Kiszka's
	message of "Tue, 10 Nov 2026 16:46:00 +0100")
References: <4d7b7926-4a09-40c0-b4e8-d5512f8107ef@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 10 Nov 2026 17:52:49 +0100
Message-ID: <87wlqk6332.fsf@xenomai.org>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGmAOELd05FZN8wuAKDxooQktUlJn88C0R318HO06RO5rSZkzj2uX1qAKQ1v34h68EGvjXYiaSRmYLUgEFMY/wbAAFqnaKkhtJ8a0CsRNaNKsGVWx1+3JYambBNEHO0xpEGduzA2FJmz95uNrRbBcSuo/9KpsbYcKfg0ZZ3NMxBvJz928vG98ohxKdvoIShjZMPPI/xsmQk9VBjza2HoU/YgdWZd6f9CWXx09VMVp10DWNttkXKOUc+KK1tpAar6KUWNCOMsVuFlcn+gROL/PjoWs+MKVVMZh+TdeBJjNxDynUgVJBqHjrwmTx1gpVmWlUWJt1aQPKcCQnvvEPIJy/BA+4T9zwnxXAVTSVEA8a4r8iNxyXMjExlZoa+3JFGMUOlIwlmCDqGGq35KFLSQMB9KeigfP25XzTzpsyAJtkhhAB/zfHBbOO8q7f/+XtASF9N8wXBApEXVa7pWnAJ6du0u/yTH2qt6FzakYflpJvojv8qXYUwMH3mDE+DHoq7M12JufYYu2GRbg90WOPlrShHBQEU4H2J8vAr+iM856d2c9wUSC5MFeM+GrT3SjHpXeBWyOWPL7vgVZxTdd/VoqYvQQzywFokyQr74YeqZaSJ92PTC1Krq8NlMsPBD+spb2LMsgVxGBwxcCuE+X6RB1FVnHGY8u8CJoY01q/qMa350g

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> With CONFIG_COMPAT_ALIGNMENT_FIXUPS, misaligned multi-word loads and
> stores of 32-bit tasks are emulated by do_compat_alignment_fixup(),
> called from do_alignment_fault() via do_mem_abort(). The companion
> core is only told about the trap when the fixup fails and
> do_mem_abort() falls back to signal injection. If the fixup succeeds,
> an oob thread runs the whole emulation from the oob stage: it fetches
> the faulting instruction, emulates it by accessing user memory, which
> may fault in pages, and accounts a perf event, none of which is
> oob-safe. On arm, the equivalent path in do_alignment() is annotated.
>
> Notify the core before attempting the fixup, reporting the trap as
> ARM64_TRAP_ACCESS like do_bad_area() does for the same fault when the
> fixups are disabled. If the fixup fails, the notification is unwound
> before do_mem_abort() goes on, so its own annotation pairs as usual.
>
> Assisted-by: opencode:Opus-5.5
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> This was a found by pure code analysis as most setups have
> CONFIG_COMPAT_ALIGNMENT_FIXUPS off. It was not tested yet, working on a 
> setup.
>
>  arch/arm64/mm/fault.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 2726eb3fa2d46..c3532ff0440ad 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -867,9 +867,15 @@ static int __kprobes do_translation_fault(unsigned long far,
>  static int do_alignment_fault(unsigned long far, unsigned long esr,
>  			      struct pt_regs *regs)
>  {
> +	int ret;
> +
>  	if (IS_ENABLED(CONFIG_COMPAT_ALIGNMENT_FIXUPS) &&
> -	    compat_user_mode(regs))
> -		return do_compat_alignment_fixup(far, regs);
> +	    compat_user_mode(regs)) {
> +		mark_trap_entry(ARM64_TRAP_ACCESS, regs);
> +		ret = do_compat_alignment_fixup(far, regs);
> +		mark_trap_exit(ARM64_TRAP_ACCESS, regs);
> +		return ret;
> +	}
>  	do_bad_area(far, esr, regs);
>  	return 0;
>  }

If oob, we can expect MMF_DOVETAIL to be set for the current address
space, so .text pages of the caller should have been committed. In the
(unexpected) event some are not, get_user() and friends would still
recursively bump us to do_page_fault()/do_translation_fault() on a
subsequent synchronous exception path, which would mark the trap entry
eventually, causing the core to downgrade the task before damage is
done. This should work now that pipelined faults can pile up
safely. Anyway, I'll wait for some testing, things might be more
complicated.

-- 
Philippe.
