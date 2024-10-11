Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70751209F29
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631495; cv=none; b=hASvb6D+Dl2hcjmyfyp4ODiMp8GpStNZMzxRIRnNwY3Els/YUV3t53TjWe34K64lKEVR+b8qQt/uDxFAiu00nsbXlRadik5bOufX6RhIz3vB2krZ7ov2yrkWMmtsjDMmGHXo4AGJephZxfo7B5m6bJ8JmOODWCYYNcyyNRbRNks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631495; c=relaxed/simple;
	bh=4XK0PieKZjVT7ivxcXLh6k/fkfMkIXlzi5HvhO0e8x4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=flymkvph156HrfyXivqerkgIOWGPXuMBuWhibNr/2EjfvfxIrM1YpwYZm1jIgYwWua5BvX4E5oD6brwn4kYGmnCozb6U+rSOSy6RTiuBHEZ0JSVjIfSicGNwqqfNPJQHCrnoD5K65xwwcBpM1noipRygLmmM+F0uW1SUJubgbg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Xg5UQ2YP; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Xg5UQ2YP"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202410110724431ac10a2a9f7b6f2cf1
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 09:24:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=K4QSZx3mDwLTooTgSd40A2fy57zNGwt2uW1w2RaorNA=;
 b=Xg5UQ2YPkwdM+0PC2UNYhqoLgGPQBWItLuHMk8Ef+8M2He7bHJ4Nkuovgbm9idgA/32FNU
 Jjtp4pw4zh+Gf+JzPzQwgxzzgvNqdQ+dGovdfZ1WTS6b+OgiPcKs1oOCWC9P9uq4mocqQtJ1
 IcSt3EIdz01c2+BMDYyrcABN15MABZo5UHrZMmCo+woz3CRqleuY94VPSuBg2jj6FifuwJpV
 2QL/M8RgcfLAAZP3pqS8wrb4ATD0GN5qJFoAeyP16bJFQv62JvBLbRxbCEYxTWBnP18RFs3Y
 fwqNOlrvLgR1RatzzVImhMTs5ndDfCrbOPZmZpKQFo/VnsW9pQBrJZ8g==;
Message-ID: <a59c3c6d97a76ea423dcdc283694f9c5baaac9be.camel@siemens.com>
Subject: Re: [PATCH 1/3] RISC-V: enable IRQ-PIPELINE
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, shannmu <shanmu1901@gmail.com>, 
	xenomai@lists.linux.dev
Cc: "Schaffner, Tobias (T CED SES-DE)" <tobias.schaffner@siemens.com>
Date: Fri, 11 Oct 2024 09:24:40 +0200
In-Reply-To: <bf826225-8056-47d8-8a9c-f71f368dc26c@siemens.com>
References: <20241011063730.310568-1-shanmu1901@gmail.com>
	 <20241011063730.310568-2-shanmu1901@gmail.com>
	 <bf826225-8056-47d8-8a9c-f71f368dc26c@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Fri, 2024-10-11 at 09:15 +0200, Jan Kiszka wrote:
> On 11.10.24 08:37, shannmu wrote:
> > This adds virtual interrupt functions `arch_xxx`,
> > irq-pipelined top-level interrupt handler `handle_riscv_irq`
> > and `handle_arch_irq_pipelined`,
> > real interrupt-flags functions `native_xxx`,
> > `mark_trap_entry` and `mark_trap_exit` in trap functions,
> > multiplexed ipi_message_type `IPI_RESCHEDULE` for in-band ipi.
> >=20
> > Signed-off-by: shannmu <shanmu1901@gmail.com>
> > ---
> >  arch/riscv/Kconfig                    |   5 +
> >  arch/riscv/include/asm/dovetail.h     |  58 +++++++
> >  arch/riscv/include/asm/irq_pipeline.h | 173 +++++++++++++++++++++
> >  arch/riscv/include/asm/irqflags.h     |  26 ++--
> >  arch/riscv/include/asm/mmu_context.h  |  21 ++-
> >  arch/riscv/include/asm/syscall.h      |   6 +
> >  arch/riscv/kernel/Makefile            |   1 +
> >  arch/riscv/kernel/irq.c               |  72 ++++++---
> >  arch/riscv/kernel/irq_pipeline.c      |  46 ++++++
> >  arch/riscv/kernel/smp.c               | 135 ++++++++++++----
> >  arch/riscv/kernel/smpboot.c           |   2 +-
> >  arch/riscv/kernel/traps.c             | 212 +++++++++++++++-----------
> >  arch/riscv/mm/fault.c                 |  46 +++---
> >  13 files changed, 633 insertions(+), 170 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/dovetail.h
> >  create mode 100644 arch/riscv/include/asm/irq_pipeline.h
> >  create mode 100644 arch/riscv/kernel/irq_pipeline.c
> >=20
>=20
> Thanks for sharing your work! Could you explain how these bits compare
> to what Tobias sent earlier [1]? Is it possible to combine your work
> with that to ensure nothing relevant is missed?

Thanks for sharing +1. One major difference is the base branch. Tobias
was working on 6.11 while this one is based on 6.6.

As we now have two different works streams it makes sense to
synchronize and ideally align on a roadmap / work sharing plan. That
would help to minimize review / testing efforts - at least on my side.

Florian

>=20
> Jan
>=20
> [1]
> https://lore.kernel.org/xenomai/20241004190633.1814057-1-tobias.schaffner=
@siemens.com/
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

