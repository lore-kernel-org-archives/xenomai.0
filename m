Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96811ABEDC
	for <xenomai@lists.linux.dev>; Mon,  4 Nov 2024 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730714061; cv=none; b=KRmpbxmJcK6sxfrs8Vgs10wUBD2zXXlkiPPiBPDNboeBLvXX8XaEvIZ2724loQ1cCjMrOtuTAqmP8zR5NuTApAogjPZE3YDrmTdGn4wTsn1Gyc+mziur7+TtzTJxiiVv8eGzZtAkfSDOmG+fGkKoaBY+06hSyhL0zEaL6zczFaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730714061; c=relaxed/simple;
	bh=lXHkJLp0nt8X32Jl8lOvtk4XojM0Y8eFc2kFzaRTIkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u8a5aTcL0IL8wqYZtZj7zsP36giHDapGe+YVtDLYl5/e4yM0GwxlVTC6dqk1STbewcdCqSA7SmMH0qxDnditER+Oa1rbK2uLGZeAurR1/CFUaDr8MaWneeyBEnK7R38pZ/m7KGCg46vqlkllgAHlaN87Vo4TwIm77lDAL4RW7U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so3696437f8f.3
        for <xenomai@lists.linux.dev>; Mon, 04 Nov 2024 01:54:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730714058; x=1731318858;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XogQ2UIXjPn7lOYGh+/d06SYAY/1ZzL3ZNAY5yvdZ58=;
        b=lmJBTtFvc6D+9TdHGMWBq+d7v6bcu+FUQkJhmURC5ieFh1bbtx/Aw/HWKHvwr5nASC
         CS0y5NvchycC3B8pq8ISNyODPHqK00m20jcxrmhk8xkWTN2mCknA9r1a7l8noj51gyeK
         NNEALpKAjTvLpI+Lvme8ryi0uR/A1/AYYpyhKt/jp7r9ulof2E2dzinTJLHVhE65+HQI
         lKOcX9nLQvzjJTUdDR+G6VkaoqfrLvyRDxAy0l7YCVBTkGFNptxp+QlM5kjDXWTkW9V2
         2t3U9kNGQKKe/A64W1Adnilu6UL2CESSojws8W46MkpYccUVUnAsZK9vb7apgKoknh2S
         FiZg==
X-Gm-Message-State: AOJu0YyG+OqgiR9MoEqgKLIWk7smWEVvQYkuN2TzI0fBMTUDguE4PJou
	0vDvsUcmYPMBPY1Kd9dQpDcj3tWqNq0S4RHos3lqMM8C8bC0ibiX
X-Google-Smtp-Source: AGHT+IGhmYyKFj8bEtRV2eO4D3Ulx/LsWvPnT1xUfeFaoah05v++vpSyS2+nNOCe7AZys7b1ba2eFw==
X-Received: by 2002:a5d:6dab:0:b0:37e:d2b8:883a with SMTP id ffacd0b85a97d-381c7a464c6mr12642803f8f.12.1730714056429;
        Mon, 04 Nov 2024 01:54:16 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e74casm12687115f8f.65.2024.11.04.01.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 01:54:15 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev,  jan.kiszka@siemens.com, shanmu
 <shanmu1901@gmail.com>
Subject: Re: [PATCH dovetail 6.11 v2 0/3] RISC-V: IRQ pipelining core
In-Reply-To: <20241004190633.1814057-1-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Fri, 4 Oct 2024 21:06:30 +0200")
References: <20241004190633.1814057-1-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 04 Nov 2024 10:54:04 +0100
Message-ID: <87plnbwchv.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Hi,

I started a Dovetail branch [1] for the RISC-V port, forward porting
your series (since it's SMP-enabled already) to 6.12-rc6. The code was
split in few more patches, including a couple of fixes we need as
well. The latter may be folded into the core pipeline support later
on. From that point, we could then pick the upper layer of the Dovetail
code already ported by Shanmu in order to enable EVL on top.

I recommend enabling the following switches when working on this port,
so that we can detect any issue with the virtual interrupt state:

CONFIG_PROVE_LOCKING
CONFIG_PREEMPT_RT
CONFIG_DEBUG_PREEMPT
CONFIG_RISCV_ISA_V_PREEMPTIVE

Here we go, so far:

root@homelab-qemu-riscv64:~# uname -a
Linux homelab-qemu-riscv64 6.12.0-rc6-00145-gb4167b69ed0e #20 SMP PREEMPT_RT IRQ_PIPELINE Mon Nov  4 10:26:04 CET 2024 riscv64 GNU/Linux

PS: I switched from RISC-V: to riscv: in the shortlogs to follow the
(most) common scheme used so far, which is likely to reuse the name of
the architecture folder.

[1] https://source.denx.de/Xenomai/linux-dovetail/-/tree/wip/dovetail-riscv?ref_type=heads

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Hi all,
>
> This introduces IRQ pipelining for RISC-V into Dovetail. The patches
> are on top of v6.11-dovetail-rebase. Feel free to ask for other targets
> if needed.
>
> I thought about splitting the patch up into smaller parts, but decided
> to stick to the structure of the analogous patches of the other
> architectures. Maybe this will make the rebasing process easier.
>
> Testing was done in QEMU with IRQ pipeline torture tests, both with and
> without SMP enabled.
>
> Changes since v1:
> * Removed some dovetail specific changes. These will be readded in a
>   later dovetail patch series. Thanks for the kind review @rpm!
> * Added a patch that guards _TIF_RETUSER with an CONFIG_DOVETAIL ifdef
>   to allow building with IRQ pipelining but without dovetail being
>   implemented.
> * Fix unneeded reordering in riscv irqflags.h to make the diff nicer.
>
> Tobias Schaffner (3):
>   dovetail: Guard _TIF_RETUSER with CONFIG_DOVETAIL
>   clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
>   RISC-V: irq_pipeline: add IRQ pipelining core
>
>  arch/riscv/Kconfig                         |   1 +
>  arch/riscv/include/asm/irq_pipeline.h      | 143 +++++++++++++++++++++
>  arch/riscv/include/asm/irqflags.h          |  25 ++--
>  arch/riscv/include/asm/thread_info.h       |   8 ++
>  arch/riscv/kernel/Makefile                 |   1 +
>  arch/riscv/kernel/irq_pipeline.c           |  26 ++++
>  arch/riscv/kernel/smp.c                    |  93 +++++++++++++-
>  arch/riscv/kernel/smpboot.c                |   2 +-
>  arch/riscv/kernel/traps.c                  |  51 +++++++-
>  arch/riscv/mm/fault.c                      |  83 ++++++++++--
>  drivers/clocksource/timer-riscv.c          |  11 +-
>  drivers/irqchip/irq-riscv-aplic-direct.c   |   3 +-
>  drivers/irqchip/irq-riscv-aplic-msi.c      |   3 +-
>  drivers/irqchip/irq-riscv-imsic-platform.c |   3 +-
>  drivers/irqchip/irq-riscv-intc.c           |   2 +
>  drivers/irqchip/irq-sifive-plic.c          |   3 +-
>  include/linux/entry-common.h               |   4 +-
>  17 files changed, 420 insertions(+), 42 deletions(-)
>  create mode 100644 arch/riscv/include/asm/irq_pipeline.h
>  create mode 100644 arch/riscv/kernel/irq_pipeline.c

-- 
Philippe.
