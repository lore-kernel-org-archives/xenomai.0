Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E914272801
	for <xenomai@lists.linux.dev>; Mon, 23 Mar 2026 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281221; cv=none; b=PG4CzSrYiWfvuL+8JLpQ8eyxVFmBXQ0yrxpsoVfNocf+SJi1Hdfu4n+SZ+osYgfLFfeahYsW6T7JFGSO9YGN0WXlo9frc+d1ufyIOyq0JrzpdKMILDx2bnN49Q1eMlBArLVdngoe+yU8dDVFCoLe2qRFJl5VJHWQR/gFVbR26TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281221; c=relaxed/simple;
	bh=p5y/0braQvazmOWFRsj3mIOIQ4mYOdWcdobZOXAEv80=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=McBpmusfy1fnjNHR0lCG9X8VBT+ZAKnt/Dup5nS3TCFm75FH3TVZzb65CshStb4j6r5Y9/auQzfjI3YK5XP91OIiNMXP/JPDRa+hZP5nlK3/diebZ4ueP9+r0k72S9fPlLQ92Uf/SdHTYLBoPFX8swM0FottEcpl2lUKuTqwBMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHymCOA9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHymCOA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D02C4CEF7;
	Mon, 23 Mar 2026 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774281221;
	bh=p5y/0braQvazmOWFRsj3mIOIQ4mYOdWcdobZOXAEv80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RHymCOA9yQQhWlzyVWc4hTNoAxqx+Ham7ABNIN8QO/Of3xEvc0zVqL84C0s/ZF2gb
	 3JiMCVlM8FyadldYImHWvYeUbrAHnFhAjmoV6MQaA97A6/rGPBEbNORZ5+MFzHaAXi
	 EMbTlEosiB/p5NaNvCY3o/UcyCm4q1mpASqIE+3wtjYlybQXwEC4t+hZ0NmXOLKIVY
	 aQXhR7fgu2rsRcCGsQIhSHuDMuHf+2ByGnNQ1u0/McIkCeGrLpdPpRd4PTWWbMo36X
	 VsfSQ8FhhKOErov/TGCIFb16kmHZcUiZ/Xay3gK0cVpvdp+sbUD7ChEwFV/q/9Rb07
	 tfg2ShODSs2nQ==
Date: Mon, 23 Mar 2026 10:53:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev, rpm@xenomai.org, florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH dovetail v5 00/12] riscv: Add dovetail support
Message-ID: <20260323155338.GA823051@bhelgaas>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320213657.2210419-1-tobias.schaffner@siemens.com>

[+cc Thomas, irqchip driver maintainer, series at
https://lore.kernel.org/all/20260320213657.2210419-1-tobias.schaffner@siemens.com]

On Fri, Mar 20, 2026 at 10:36:45PM +0100, Tobias Schaffner wrote:
> Hi all,
> 
> this series introduces initial support for Dovetail on RISC-V.

02/12 mentions "the Dovetail/IRQ pipeline model used on other
architectures," but my quick grep for dovetail and IRQ pipelining
didn't find anything.

> Feedback, suggestions, and especially reviews are very welcome.
> 
> Changes since v1:
>  * Disable independent irq/softirq stack usage when pipelining
>  * Drop KVM changes as long as they can not be properly tested
> 
> Changes since v2:
>  * Rework trap handling
> 
> Changes since v3:
>  * Included the IRQ pipelining patches to have all riscv specific
>    patches included
>  * Rebased to dovetail/v6.18.y-dovetail-rebase
>  * Merged most of the fixes
>  * Fixed IRQ Stack handling and enabled IRQ_STACKS again
> 
> Changes since v4:
>  * Rebased to dovetail/v7.0.y-dovetail-rebase
>  * Applied suggestions from the last patch set
>  * Added starfive-visionfive2 board support
>  * Introduced raw console device based on sbi debug console
>  * Reworked pipelined irq handling
> 
> Best,
> Tobias
> 
> Tobias Schaffner (12):
>   riscv: introduce raw console device
>   riscv: irq_pipeline: add IRQ pipelining core
>   riscv: irq_pipeline: enable hard IRQs during in-band trap handling
>   irqchip/riscv-aplic-direct: enable pipelined interrupt control
>   irqchip/irq-riscv-aplic-msi: enable pipelined interrupt control
>   irqchip/irq-riscv-imsic-platform: enable pipelined interrupt control
>   irqchip/irq-riscv-intc: enable pipelined interrupt control
>   irqchip/irq-sifive-plic: enable pipelined interrupt control
>   clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
>   pinctrl: starfive: irq_pipeline: enable pipelined interrupt control
>   pci: plda: irq_pipeline: enable pipelined interrupt control
>   riscv: dovetail: add core support
> 
>  arch/riscv/Kconfig                            |   3 +
>  arch/riscv/include/asm/dovetail.h             |  23 ++
>  arch/riscv/include/asm/irq_pipeline.h         | 145 +++++++++++++
>  arch/riscv/include/asm/irqflags.h             |  32 ++-
>  arch/riscv/include/asm/mmu_context.h          |   2 +
>  arch/riscv/include/asm/smp.h                  |   7 +
>  arch/riscv/include/asm/syscall.h              |   6 +
>  arch/riscv/include/asm/thread_info.h          |  17 ++
>  arch/riscv/kernel/Makefile                    |   2 +
>  arch/riscv/kernel/irq_pipeline.c              |  26 +++
>  arch/riscv/kernel/kernel_mode_vector.c        |   2 +-
>  arch/riscv/kernel/raw_printk.c                |  33 +++
>  arch/riscv/kernel/sbi-ipi.c                   |  12 +-
>  arch/riscv/kernel/smp.c                       |  55 ++++-
>  arch/riscv/kernel/smpboot.c                   |   2 +-
>  arch/riscv/kernel/traps.c                     | 202 ++++++++++++++++--
>  arch/riscv/mm/cacheflush.c                    |   5 +-
>  arch/riscv/mm/context.c                       |  20 +-
>  arch/riscv/mm/fault.c                         |  29 ++-
>  drivers/clocksource/timer-riscv.c             |  11 +-
>  drivers/irqchip/irq-riscv-aplic-direct.c      |   3 +-
>  drivers/irqchip/irq-riscv-aplic-msi.c         |   3 +-
>  drivers/irqchip/irq-riscv-imsic-platform.c    |   4 +-
>  drivers/irqchip/irq-riscv-intc.c              |   2 +
>  drivers/irqchip/irq-sifive-plic.c             |  10 +-
>  drivers/pci/controller/plda/pcie-plda-host.c  |   2 +
>  .../starfive/pinctrl-starfive-jh7110.c        |   2 +-
>  .../starfive/pinctrl-starfive-jh7110.h        |   2 +-
>  28 files changed, 593 insertions(+), 69 deletions(-)
>  create mode 100644 arch/riscv/include/asm/dovetail.h
>  create mode 100644 arch/riscv/include/asm/irq_pipeline.h
>  create mode 100644 arch/riscv/kernel/irq_pipeline.c
>  create mode 100644 arch/riscv/kernel/raw_printk.c
> 
> -- 
> 2.43.0
> 
