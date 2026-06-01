Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12243E3C46
	for <xenomai@lists.linux.dev>; Mon,  1 Jun 2026 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336847; cv=none; b=NE8c+vJNVU23S2xrX7DibgaDLnoqg4rspdYxfjMIfeD3Lnlf0zWXoaPvZy3lw5E8pdMwSMeDQMdC/QIpfPW5SyrmZu/bDZ6j53gX5EnZ8DzkVhrF2uyk7GxYrYAJ0s+ToMs5QJtgBI83XNBBtcE5rIhkc1BOfLGCJ+MJtRNBciI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336847; c=relaxed/simple;
	bh=x3M6s5f+qLU9CkRp5FHNJhFJsQs158hPj6kFh36lhM4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DOL5b0rfkboqDliGkkvlAacVgxsrcZOclkxL/2epYWtjuIcvKyxShztNpU2wUrmnHaCcu7xr6ovxQHbtV/YbpdwaxW1V4cqr+g5h50n0WrOKbmnM9qkrxhxYRX2UoxYbKhKkbYZJqHanPvz2P/ZtnucT/GwVtWG5hOigS+HGtng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=XbVtIhRe; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="XbVtIhRe"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202606011800355d389e96090002073e
        for <xenomai@lists.linux.dev>;
        Mon, 01 Jun 2026 20:00:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=av91mdE1qKuxLYvgferjD4e9Bm6HWQIW+nIQmKnVb2Y=;
 b=XbVtIhRe+SD3xtn22JsRI+8u/IjQ5KPMsplf80ltLGCALXHSXLcdjT3E7d1DJGgGvtcCYd
 CpfXQme0yrIoQrEAmCIh9k85Ck2t2/xtJqDUj3KDIceXFq2VJhHgWAOfOjKiSs83rf0mSYAe
 fVdQBj0E+DWi7G/eT0wPNVyRNmIpRSFhpCd20Tu/ti8fWGdZLVOjnh1bfxV7jovtp9A92rl+
 7O6n9jOnizNfmJ+aeAuWCDgGPGA3yBERW67yqS5iKcp6YU9iKXT6J9BmWBcoqBpgPc0bcz4J
 7boERiDzNXkbE4JKF8qmWOyXZ6tk44qXZsDFiTe3Nji+EGzkiDdQoOdw==;
Message-ID: <558767f3737914500bcfb1d0bb3f27c0089a98ee.camel@siemens.com>
Subject: Re: [RFC PATCH Dovetail 7.1] x86: irq_pipeline: Allow X86_FRED to
 be enabled
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev, Philippe Gerum <rpm@xenomai.org>
Date: Mon, 01 Jun 2026 20:00:33 +0200
In-Reply-To: <20260601175838.1115533-1-florian.bezdeka@siemens.com>
References: <20260601175838.1115533-1-florian.bezdeka@siemens.com>
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

On Mon, 2026-06-01 at 19:58 +0200, Florian Bezdeka wrote:
> Some low level entry functions, fred_##func were not defined when
> FRED has been enabled:
>=20
> ld: vmlinux.o:(.data..ro_after_init+0x6100): undefined reference to `fred=
_sysvec_apic_timer_interrupt'
> ld: vmlinux.o:(.data..ro_after_init+0x6120): undefined reference to `fred=
_sysvec_kvm_posted_intr_nested_ipi'
> ld: vmlinux.o:(.data..ro_after_init+0x6128): undefined reference to `fred=
_sysvec_kvm_posted_intr_wakeup_ipi'
> ld: vmlinux.o:(.data..ro_after_init+0x6130): undefined reference to `fred=
_sysvec_kvm_posted_intr_ipi'
> ld: vmlinux.o:(.data..ro_after_init+0x6150): undefined reference to `fred=
_sysvec_irq_work'
> ld: vmlinux.o:(.data..ro_after_init+0x6158): undefined reference to `fred=
_sysvec_x86_platform_ipi'
> ld: vmlinux.o:(.data..ro_after_init+0x6160): undefined reference to `fred=
_sysvec_reboot'
> ld: vmlinux.o:(.data..ro_after_init+0x6178): undefined reference to `fred=
_sysvec_call_function_single'
> ld: vmlinux.o:(.data..ro_after_init+0x6180): undefined reference to `fred=
_sysvec_call_function'
> ld: vmlinux.o:(.data..ro_after_init+0x6188): undefined reference to `fred=
_sysvec_reschedule_ipi'
> ld: vmlinux.o:(.data..ro_after_init+0x6198): undefined reference to `fred=
_sysvec_spurious_apic_interrupt'
>=20
> Updating the DEFINE_IDTENTRY_SYSVEC_PIPELINED() and
> DEFINE_IDTENTRY_SYSVEC_PIPELINED_NORETURN() macros to define those
> functions.
>=20
> FRED entry points for sysvecs will no go through the IRQ pipeline as
> we do it for the IDT.
>=20
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>=20
> Hi Philippe,
>=20
> input highly welcome. This allows to build x86 with FRED enabled, which
> fixes a compile time issue introduced with 7.1-rc5.
>=20
> On first glance that seems to do the right thing, but as always I might
> miss something.

Forgot to mention: The most important file to review is most likely
arch/x86/entry/entry_fred.c.

>=20
>  arch/x86/Kconfig                |  2 +-
>  arch/x86/include/asm/idtentry.h | 11 +++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4d40fbb58b1c..fc6500301ff9 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -554,7 +554,7 @@ config X86_CPU_RESCTRL_INTEL_AET
> =20
>  config X86_FRED
>  	bool "Flexible Return and Event Delivery"
> -	depends on X86_64 && !IRQ_PIPELINE
> +	depends on X86_64
>  	help
>  	  When enabled, use Flexible Return and Event Delivery
>  	  instead of the legacy SYSCALL/SYSENTER/IDT architecture for
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idten=
try.h
> index 0b517059ae9d..bb1df662dc56 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -222,6 +222,11 @@ static __always_inline void __##func(struct pt_regs =
*regs, u8 vector)
>   */
>  #define DEFINE_IDTENTRY_SYSVEC_PIPELINED(vector, func)			\
>  __visible noinstr void func(struct pt_regs *regs)			\
> +{									\
> +	arch_pipeline_entry(regs, vector);				\
> +}									\
> +									\
> +void fred_##func(struct pt_regs *regs)					\
>  {									\
>  	arch_pipeline_entry(regs, vector);				\
>  }									\
> @@ -233,6 +238,12 @@ __visible noinstr void func(struct pt_regs *regs)			=
\
>  {									\
>  	arch_pipeline_entry(regs, vector);				\
>  }									\
> +									\
> +void fred_##func(struct pt_regs *regs)					\
> +{									\
> +	arch_pipeline_entry(regs, vector);				\
> +}									\
> +									\
>  __visible __noreturn void __##func(struct pt_regs *regs)
> =20
>  #define DEFINE_IDTENTRY_SYSVEC_SIMPLE_PIPELINED(vector, func)		\
