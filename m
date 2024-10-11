Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE78207A30
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632470; cv=none; b=XRed/meol9fbTF4b9HSvTvhi7LxGwyCAiaqdxqCQMI25+VrqslCELUwHbb8PwjirXgFpCqXdDz8p46LaDPXpT3YpvRUwQdKUoDzPLGL1aA2D2aomdnnbc3J4ciTYlQedmez3zGHFTECHB/ETPJyNca9jW5C/Edck45b1KkKLj00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632470; c=relaxed/simple;
	bh=KjknefG1uxy3eUj1ue1GlFzVJf2XQJa+MRiYzYEVS8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Brlrl9gogc4L/zFrT3mfARxwP9OfXAnUL0ZSjyc+vr5W1cpxQIY5W7k/2J0tVvL6aSKllv1wuRLyOGDajLKdE+HhYS34dVYXmWJYfl9iJlWjAW0knO9rn3YX7zeOZDa4juqaLKfd2jUvvAoNchvl44YfoMkLFicdxtFefEMbrAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4305724c12eso12586665e9.1
        for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 00:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728632466; x=1729237266;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8Z080Dc/LWQfwc2vgCz4pHY20C6xua6LNn22+zGFkE=;
        b=nfLiDA+XHcEDkY0dn/4FKMew2Vk2Wba2lVTbgP3jf94BzBGF/7sb0N+l0oJlu+nMZs
         PYriC27fARzwvjJACNZu/5LWUYjtgh63MrReDe1ffmK7pgExbwS+9C08tp02avrFo2UC
         GqDB9Fwjbigur5QmvLq/uOSsuXNti1Tl5jFg6TpnctI9LaEE+6ux782HIGO8mqK8OU9I
         4Jgy5cs34jF+imH5rfglFql21AhkqgA7VdprBXSlKVYeegfVt0bK7HYD5N6rzM/+KzL/
         VSmB2K18hUXEgZOlGbsQzuJUC3W6W7GxkX+m/KQKJ2N0Upkv83VtANqylfgHTwt4W0ZN
         cU7A==
X-Forwarded-Encrypted: i=1; AJvYcCUwDxC1YPaLism4Ue9tX2mxhggTjmM4ljsNlJFrG/ZvqFdtmBOWPJuQBrpY35RQo/q7Sg2Phdn2@lists.linux.dev
X-Gm-Message-State: AOJu0YyqDrsJtxFAfOLjhqM3lPbyFw/3sZ2Vfptr3Bp0aRFlOBxl95bK
	ep5N9T9YPT7PaVzUI3l97W/e2RwyB6SPkSIN7jRjxA3vM32TsdKJ
X-Google-Smtp-Source: AGHT+IHktpwXMgBevNF1E9lJRm1FoQNPotb9WWsAGyYNvfz30C+K34qu3Qb8DN+2e1Pe9dVQvTz87w==
X-Received: by 2002:a05:600c:4fd4:b0:426:6326:4cec with SMTP id 5b1f17b1804b1-4311df8d5e9mr10415455e9.29.1728632466401;
        Fri, 11 Oct 2024 00:41:06 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf51834sm67807515e9.26.2024.10.11.00.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 00:41:05 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  shannmu <shanmu1901@gmail.com>,
  xenomai@lists.linux.dev,  "Schaffner, Tobias (T CED SES-DE)"
 <tobias.schaffner@siemens.com>
Subject: Re: [PATCH 1/3] RISC-V: enable IRQ-PIPELINE
In-Reply-To: <a59c3c6d97a76ea423dcdc283694f9c5baaac9be.camel@siemens.com>
	(Florian Bezdeka's message of "Fri, 11 Oct 2024 09:24:40 +0200")
References: <20241011063730.310568-1-shanmu1901@gmail.com>
	<20241011063730.310568-2-shanmu1901@gmail.com>
	<bf826225-8056-47d8-8a9c-f71f368dc26c@siemens.com>
	<a59c3c6d97a76ea423dcdc283694f9c5baaac9be.camel@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 11 Oct 2024 09:41:01 +0200
Message-ID: <87zfnb84tu.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Fri, 2024-10-11 at 09:15 +0200, Jan Kiszka wrote:
>> On 11.10.24 08:37, shannmu wrote:
>> > This adds virtual interrupt functions `arch_xxx`,
>> > irq-pipelined top-level interrupt handler `handle_riscv_irq`
>> > and `handle_arch_irq_pipelined`,
>> > real interrupt-flags functions `native_xxx`,
>> > `mark_trap_entry` and `mark_trap_exit` in trap functions,
>> > multiplexed ipi_message_type `IPI_RESCHEDULE` for in-band ipi.
>> > 
>> > Signed-off-by: shannmu <shanmu1901@gmail.com>
>> > ---
>> >  arch/riscv/Kconfig                    |   5 +
>> >  arch/riscv/include/asm/dovetail.h     |  58 +++++++
>> >  arch/riscv/include/asm/irq_pipeline.h | 173 +++++++++++++++++++++
>> >  arch/riscv/include/asm/irqflags.h     |  26 ++--
>> >  arch/riscv/include/asm/mmu_context.h  |  21 ++-
>> >  arch/riscv/include/asm/syscall.h      |   6 +
>> >  arch/riscv/kernel/Makefile            |   1 +
>> >  arch/riscv/kernel/irq.c               |  72 ++++++---
>> >  arch/riscv/kernel/irq_pipeline.c      |  46 ++++++
>> >  arch/riscv/kernel/smp.c               | 135 ++++++++++++----
>> >  arch/riscv/kernel/smpboot.c           |   2 +-
>> >  arch/riscv/kernel/traps.c             | 212 +++++++++++++++-----------
>> >  arch/riscv/mm/fault.c                 |  46 +++---
>> >  13 files changed, 633 insertions(+), 170 deletions(-)
>> >  create mode 100644 arch/riscv/include/asm/dovetail.h
>> >  create mode 100644 arch/riscv/include/asm/irq_pipeline.h
>> >  create mode 100644 arch/riscv/kernel/irq_pipeline.c
>> > 
>> 
>> Thanks for sharing your work! Could you explain how these bits compare
>> to what Tobias sent earlier [1]? Is it possible to combine your work
>> with that to ensure nothing relevant is missed?
>
> Thanks for sharing +1. One major difference is the base branch. Tobias
> was working on 6.11 while this one is based on 6.6.
>
> As we now have two different works streams it makes sense to
> synchronize and ideally align on a roadmap / work sharing plan. That
> would help to minimize review / testing efforts - at least on my side.
>

Agreed. For the record, I'm willing to merge the RISC-V architecture
support into Dovetail and the EVL core. We'd just need to merge both
ongoing efforts to get this done faster.

-- 
Philippe.
