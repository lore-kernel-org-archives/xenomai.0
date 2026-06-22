Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668363ACA75
	for <xenomai@lists.linux.dev>; Mon, 22 Jun 2026 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782135915; cv=none; b=MROew7KCkumV4vT8s82jW4LOQ1VNjLm1Zve+iKIvp0xlgrp6B7RFgTO1aZBr3UnUwRF451tNgdF/u2j2Sh4wYsZxdTcF3FFbd+UHL2iGC0d4UH4GMsj0tTPB9GQlQGXy8Kl/EF0wGnosX0pAKl4HASz9x9WMxgKpD9ojce0Hevs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782135915; c=relaxed/simple;
	bh=Ttpy79+oLoa+CpaFrf368R3v0HHEnDcqnjIaqw1QL8I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ll/NVmk/pIA606b4SOpmZRQ2V1mEhk/itU0a3/SrjGwlQNXxOQKySEaz9nhHKZAfHzJZzz0Yk15KGm7T/pwSQJELs0nIZiaU1VjhbpXH+XycBEtb53XyCGsBJOKQs9MRHbwL7KnurGO59FbjNzPVf4zXHKbrgfMtAWYwzkNhs1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=X55EseYk; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="X55EseYk"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260622134459ad1559f2650002074e
        for <xenomai@lists.linux.dev>;
        Mon, 22 Jun 2026 15:44:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qiTBQbF+I4temngIXAlsxozqahbLa+Kmol3mtkl/c34=;
 b=X55EseYkRrQG4AeRDLjCFGYqkDjzGmk7sz15BdOtlSrxpp8MiMyMzW/hYvzlh/zxDmGy4t
 zA2vPSSwqyVH/vT6dy7ugqd/Tf8AyKd7pCNF2yHY7jCmUpshpFc/911at46/uGBWSO+/ye9H
 YPqrIYccdg5anUcyQtxrCx1+8QKvhGJg72iCLSPlrmLqpsFe8ZxEt+lrXmEVzem3XhWBkVfu
 UBQxmsV7AtwbNfhRBqQX1caSxWi1oJN43L7r9hgYDRyzebbwMvIRTIiFdm0Q5Y5P9mCwSV5/
 jej//Kw5/pbCNudE8qjo0XIksIQl1ITGHtV82Kowbi2ybYoH5mbsNqLg==;
Message-ID: <14287accb71c52ee73c768e6a9b4421670cc39ec.camel@siemens.com>
Subject: Re: [PATCH Dovetail v3 3/6] arm: irq_pipeline: Fix
 dovetail_fault_{entry,exit} bypass in hw_breakpoint_pending
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>
Date: Mon, 22 Jun 2026 15:44:58 +0200
In-Reply-To: <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-3-230f03227abb@siemens.com>
References: 
	<20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-0-230f03227abb@siemens.com>
	 <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-3-230f03227abb@siemens.com>
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

On Mon, 2026-06-22 at 10:05 +0200, Florian Bezdeka wrote:
> HW breakpoint / watchpoint handling was bypassing the
> dovetail_fault_{entry,exit} machinery. As a result it could happen that
> the inband IRQ mask was touched from the OOB stage.
>=20
> There is one more problem in the HW bp/wp handling related to
> interrupts_enabled(). This one will be fixed in a separate patch.
>=20
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/arm/include/asm/dovetail.h         | 1 +
>  arch/arm/include/asm/trace/exceptions.h | 3 ++-
>  arch/arm/kernel/hw_breakpoint.c         | 6 ++++++
>  3 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/include/asm/dovetail.h b/arch/arm/include/asm/dovet=
ail.h
> index 795a1fb903ec29f4c2fb7b25e70980796804acc0..eeb5d16ad032044a2587822f6=
b35074d664a9bbc 100644
> --- a/arch/arm/include/asm/dovetail.h
> +++ b/arch/arm/include/asm/dovetail.h
> @@ -16,6 +16,7 @@
>  #define ARM_TRAP_VFP		6	/* VFP floating point exception */
>  #define ARM_TRAP_UNDEFINSTR	7	/* Undefined instruction */
>  #define ARM_TRAP_ALIGNMENT	8	/* Unaligned access exception */
> +#define ARM_TRAP_HW_BREAK	9	/* HW break or watchpoint exception */
> =20
>  #if !defined(__ASSEMBLY__)
> =20
> diff --git a/arch/arm/include/asm/trace/exceptions.h b/arch/arm/include/a=
sm/trace/exceptions.h
> index bdb666b3da4e364e0d7e33337be3e8ad8aeedb88..f0164e55efc31a4f363764d2c=
5c84761f3ea34d4 100644
> --- a/arch/arm/include/asm/trace/exceptions.h
> +++ b/arch/arm/include/asm/trace/exceptions.h
> @@ -21,7 +21,8 @@
>  			__trace_trap(ARM_TRAP_FPU),		\
>  			__trace_trap(ARM_TRAP_VFP),		\
>  			__trace_trap(ARM_TRAP_UNDEFINSTR),	\
> -			__trace_trap(ARM_TRAP_ALIGNMENT))
> +			__trace_trap(ARM_TRAP_ALIGNMENT),	\
> +			__trace_trap(ARM_TRAP_HW_BREAK))
> =20
>  DECLARE_EVENT_CLASS(ARM_trap_event,
>  	TP_PROTO(int trapnr, struct pt_regs *regs),
> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpo=
int.c
> index cd4b34c96e35e9e63e9a1ade1aeb415c22d32b00..6266380737dd88dca7fe8fde1=
4b786a52ec42635 100644
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -26,6 +26,7 @@
>  #include <asm/current.h>
>  #include <asm/hw_breakpoint.h>
>  #include <asm/traps.h>
> +#include <asm/trap_entry.h>
> =20
>  /* Breakpoint currently in use for each BRP. */
>  static DEFINE_PER_CPU(struct perf_event *, bp_on_reg[ARM_MAX_BRP]);
> @@ -942,9 +943,12 @@ static void hw_breakpoint_cfi_handler(struct pt_regs=
 *regs)
>  static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
>  				 struct pt_regs *regs)
>  {
> +	unsigned long irqflags;
>  	int ret =3D 0;
>  	u32 dscr;
> =20
> +	irqflags =3D dovetail_fault_entry(ARM_TRAP_HW_BREAK, regs);
> +
>  	preempt_disable();

Philippe, is that the right ordering or should I move the
dovetail_fault_entry() code below the preempt_disable() call?

Normally we want preemption enabled as long as possible and I couldn't
find a reason why the oob notify mechanism needs it already disabled,
but as always I might have missed something.

> =20
>  	if (interrupts_enabled(regs))
> @@ -973,6 +977,8 @@ static int hw_breakpoint_pending(unsigned long addr, =
unsigned int fsr,
> =20
>  	preempt_enable();
> =20
> +	dovetail_fault_exit(ARM_TRAP_HW_BREAK, regs, irqflags);
> +
>  	return ret;
>  }
> =20
>=20
> --=20
> 2.54.0
