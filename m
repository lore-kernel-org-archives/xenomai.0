Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F50812D20D
	for <xenomai@lists.linux.dev>; Sun, 13 Oct 2024 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728809342; cv=none; b=Ara+btdqobT9wPFEy9aXU31SSylVLheV34SXhhjtV6VFB+swI+xegA6vW5/ubG4q+VlMKVbF16jinhPgc3CI8lmTIyCwx9uD77EtgdfsFmCMG9gXRFVbU4uFIr57HuXODE1rjqOVZ2wvWfY83xFXpY9JoSIZloyI35/AgLrDGYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728809342; c=relaxed/simple;
	bh=lr/vezi8qyghn2cSoZrUCGplXZKOSFC7ellLgOWUDCw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PpPnuVINfWHuFd6TDftsDvG+l3yY1TV3utt8BmzaPsVbYBPmECpT+daSYnQWhr1dKcA+7MzsU/BqXc6kkwzP3qZe9GDRm667EWCwEylgfByF5mcF7nxEwnrCG5e3v6JMVcXztjLMdzO8GZn3euQViUKIgX+KUANCZvbE98ZN+uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-430f6bc9ca6so25310785e9.2
        for <xenomai@lists.linux.dev>; Sun, 13 Oct 2024 01:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728809339; x=1729414139;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVbr3clga1NMTN6iUEVnqJ9hCJ39wf5X4I2j7lNKuTQ=;
        b=W3IaRw3OLUakExCr7avcEy3KK87pfWmmhVFszLEM9xNSfzuOVdcvOiIK6TYg1Jl6Nc
         MrUe5/TuWUxc7EQStSsTgsnzB8sGR0SmkWMKhCR/YJOw/q7d4E/SbDAT0Ce1azRxoA46
         rmENtf0G+5KxyGvDquP1kbBiA/gTOaWGe3omeO5/VJ/zlDD+WmVgS4+IeFlzFRFf2vY0
         zzPbODY9jnHGsHSgVkkeGj2/7gMAZYrDK7S2n83lHZshvJiDZuJTk+Q/jtvJoXoNJ4+W
         5zDV81WSjs15FG8IMtNlbrFkv0704dzdtJB6CBHkUiIJ7kxYcmrXL3dyaQpOlJ4F2JSF
         SY4Q==
X-Gm-Message-State: AOJu0YyWtqiugRyNySVMfy1y+n7gqAhgy/CV2QPty5g6073zho84OJva
	/epTdHiCPvSFFxiLIpRP1zGwDgYtivizV4hq9Ah5jMGqMD6CmQwKwYFCRA==
X-Google-Smtp-Source: AGHT+IEDIUgpccWIdDOgOPrK/aJNkrLOD6onMfQ+rY1MCvhN5zGuCtoV2IqBvhohtJZUkzjvTPMzeA==
X-Received: by 2002:a05:600c:3584:b0:42c:cd88:d0f7 with SMTP id 5b1f17b1804b1-431255dc85cmr40746955e9.10.1728809338479;
        Sun, 13 Oct 2024 01:48:58 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf5181fsm118129595e9.25.2024.10.13.01.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 01:48:57 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  jan.kiszka@siemens.com
Subject: Re: [PATCH v2 dovetail 6.6, 6.1] x86: dovetail: Fix inband IRQ
 state corruption on out-of-band compat syscall
In-Reply-To: <20241011220004.1141774-1-florian.bezdeka@siemens.com> (Florian
	Bezdeka's message of "Sat, 12 Oct 2024 00:00:04 +0200")
References: <20241011220004.1141774-1-florian.bezdeka@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Sun, 13 Oct 2024 10:48:52 +0200
Message-ID: <87zfn84ccr.fsf@xenomai.org>
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
>
> Once again, sorry for breaking the 6.1 and 6.6 builds. I had two local
> branches named v6.{1,6} which actually contained 6.10...
>
> I decided to move syscall_enter_from_user_enable_irqs() into the same
> location as it is for 6.10/6.11. This way we can keep the
> __always_inline flag and avoid an additional function call in the low
> level entry code.
>

Ok, works for me as well. Re-merged into all affected -rebase
branches. Thanks.

-- 
Philippe.
