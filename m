Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0930461DBF
	for <xenomai@lists.linux.dev>; Thu,  8 Jan 2026 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767870556; cv=none; b=Tu+lJfT0NdU4Lsy6LbEbB23QRU5hDggF6Wv9Ry++7QRVQ2w5BL9Cw/TabEWiKa6u4XbWLwNk5CgDDWa1Jj3vjJfUIHJR7MLLcQxhURLc/atOr81MgDofBJScHOXTF7fCAB9IR5XW6sSS83V/WiEei4RSLgMzZnrBfbh8ts3uHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767870556; c=relaxed/simple;
	bh=w9l1bY5uX43cigk8z/bK59Xp6ZRubIBIIAoOYpgc39Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YCbbH4l8Nlh7Jxdb6wGTz6njnbi29j8WrrKMPTELbebyaDnjHZphxdrmv+0oQW4vtha0GSfb+7ph7ObbjdqiF30hKE8/w31jsFndrdPV7TAmdI9RpUCZyUN8y+xquOCqMbG94AUeMYzTBq6NPUSnzZSjhqu8rgvg7+Jw/mLATI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=I9jDGzzJ; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="I9jDGzzJ"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2026010811085605e27bf6aa00020782
        for <xenomai@lists.linux.dev>;
        Thu, 08 Jan 2026 12:08:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=CM/dHtWcma/112P17NmCDd/N63nqAH1f8098mEf1r0w=;
 b=I9jDGzzJ0k8tzfsW0cOUEBJ0prgZAN2i1bisgNhYZ4Trytka2d5iyuLdTtjIM87DPTpm2L
 MoL44tVpHEAU84cCys09gGMPi455IC/wPrnb4w/5Fw97GyygmzB4JfBUwmQkDCyrzzQ9s88d
 4z3YKJds+ZMkoIy4+VhEcHVn7PBH/QZ9LmXi5aVnfo0w7GQvRWYwXliqW/iCa/3Acvm8WLnS
 FKRkj2mxEqH5i2DfQvYhody/kWu02VYNlJeCApGARrdSIhjvwfS517udCMgVQ/BkbmScrDhF
 ANZAYoNSfVmKE3D1XGqPL8q/1QsCqi6iOCn06s1qta8UCoi9ih9LK7ag==;
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Jan 2026 12:08:56 +0100
Message-Id: <DFJ5SWPCJUZ8.1DRILTETK05GX@siemens.com>
Cc: <rpm@xenomai.org>
Subject: Re: [PATCH wip/dovetail-riscv] riscv: irq_pipeline: synchronize
 IRQs on exit to user mode
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Tobias Schaffner" <tobias.schaffner@siemens.com>,
 <xenomai@lists.linux.dev>
References: <20260108094551.92100-1-tobias.schaffner@siemens.com>
In-Reply-To: <20260108094551.92100-1-tobias.schaffner@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Thu Jan 8, 2026 at 10:45 AM CET, Tobias Schaffner wrote:
> Ensure that any pending in-band IRQs are processed before returning
> to user mode.
>

Two drive-by questions:

- Why is risc-v different here? All other architectures seem able to
  use the generic entry code.

- Which Linux version is the current baseline for wip/risc-v? It must be
  something < 6.17, as the generic entry code has been refactored in
  6.17. So please note that once you update the baseline you will have
  to do a lot of entry code alignments.

Florian

> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  arch/riscv/include/asm/entry-common.h | 36 +++++++++++++++++++++++++++
>  include/linux/entry-common.h          |  2 ++
>  2 files changed, 38 insertions(+)
>
> diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/a=
sm/entry-common.h
> index 2293e535f865..1f6189413a19 100644
> --- a/arch/riscv/include/asm/entry-common.h
> +++ b/arch/riscv/include/asm/entry-common.h
> @@ -7,6 +7,12 @@
>  #include <asm/thread_info.h>
>  #include <asm/vector.h>
> =20
> +#ifdef CONFIG_IRQ_PIPELINE
> +#include <linux/context_tracking.h>
> +#include <linux/irqstage.h>
> +#include <linux/irq_pipeline.h>
> +#endif
> +
>  static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>  						  unsigned long ti_work)
>  {
> @@ -22,6 +28,36 @@ static inline void arch_exit_to_user_mode_prepare(stru=
ct pt_regs *regs,
> =20
>  #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
> =20
> +#ifdef CONFIG_IRQ_PIPELINE
> +
> +#define arch_exit_to_user_mode_defined
> +static __always_inline void exit_to_user_mode(void)
> +{
> +	instrumentation_begin();
> +	trace_hardirqs_on_prepare();
> +	lockdep_hardirqs_on_prepare();
> +	instrumentation_end();
> +
> +	user_enter_irqoff();
> +	lockdep_hardirqs_on(CALLER_ADDR0);
> +
> +	if (running_inband()) {
> +		struct irq_stage_data *p;
> +		unsigned long flags;
> +
> +		unstall_inband();
> +
> +		/* Check for pending IRQs after unstalling and sync them if needed. */
> +		p =3D this_inband_staged();
> +		if (unlikely(stage_irqs_pending(p) && !in_pipeline())) {
> +			flags =3D hard_local_irq_save();
> +			sync_current_irq_stage();
> +			hard_local_irq_restore(flags);
> +		}
> +	}
> +}
> +#endif /* CONFIG_IRQ_PIPELINE */
> +

>  void handle_page_fault(struct pt_regs *regs);
>  void handle_break(struct pt_regs *regs);
> =20
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 1d15bc4ebeee..2cf32471f784 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -419,6 +419,7 @@ static __always_inline void exit_to_user_mode_prepare=
(struct pt_regs *regs)
>   * non-instrumentable.
>   * The caller has to invoke syscall_exit_to_user_mode_work() before this=
.
>   */
> +#ifndef arch_exit_to_user_mode_defined
>  static __always_inline void exit_to_user_mode(void)
>  {
>  	instrumentation_begin();
> @@ -432,6 +433,7 @@ static __always_inline void exit_to_user_mode(void)
>  	if (running_inband())
>  		unstall_inband();
>  }
> +#endif

Especially this hunk will look different in "modern" Linux versions.

> =20
>  /**
>   * syscall_exit_to_user_mode_work - Handle work before returning to user=
 mode

