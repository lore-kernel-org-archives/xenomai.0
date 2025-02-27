Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB3E22C35C
	for <xenomai@lists.linux.dev>; Thu, 27 Feb 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666365; cv=none; b=UrTzkL3lhwNWRhJ+a5z4sLgl/ppGT/qjZJ2aqq8JAltuj9Qmvqnf7P8LPbkzJkKvHmSo10J+XnaZO66Ia11VsC5UepP/090S+ArTpQX6dl/5L59XL41FgW8cf8B0KMOxu0ArgBnsIX7rQ7FkS+GGyx3dxFtI6GJ+EYjSgJZGaxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666365; c=relaxed/simple;
	bh=P+ktFaWOUxehdB14dhmDDtpmNG5e5ktzYJpnEYPS5SE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z/2kkgOlEXNmXFH5MTfQyrWM3lsmJLfGAOPvQ9CMh8EDbKl+qPQp1Z/RRpaO7ZKGsotOtw528ElZTEOnjlU2ONKDodOZPKk4P8pJ11l/uSqJDCnGwrVlvtxm/ozK5Yh0S6xwt3hq2R7OEqUFhtUN8WDcYs4PWVbKnB26JajoIOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=JM74yWA1; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="JM74yWA1"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202502271425580f0f32e9b3011f6686
        for <xenomai@lists.linux.dev>;
        Thu, 27 Feb 2025 15:25:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=zOox3kCqmJcKlbvETNJxk0pLo3hDom23PVjifDsJcOU=;
 b=JM74yWA1fvRxNfqQCSg83teqs18ziy/XEYEUYiSakf+FtTN/nex2pSnAQ3+yHUOcTUwycM
 qIWk0xEgxtDtObqG/LcjixgOtRaUEkBvxw6nkx70p7FJZu62lvMu+vP63XEeKs5gyt9eKCqQ
 u9hvE88TU34kmAA4zWxDYqK6YHy/QSpBcgOA5DmlFmsXYpdJ3NmgwJkA3CL20nyUFDWa15Mf
 k6OeU+ksSne+wxGdTkQoy1bCArJCiKhwNcjZz/xLroK27rLIlMdaZcq7MR1qk7GUV55BIK0A
 MweV2F6p9pAozmraj+DjIlC1a5ZJGq5hhk+6j29CTitkAZ7Rrv17lPLA==;
Message-ID: <7577efa5673691900d6b826024c30c6e74496f78.camel@siemens.com>
Subject: Re: [PATCH v2] x86: dovetail: Harden __send_ipi_mask[_ex] for KVM
 and Hyper-V guests
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Xenomai <xenomai@lists.linux.dev>
Date: Thu, 27 Feb 2025 15:25:58 +0100
In-Reply-To: <5235edf1-6689-4417-9754-52584ecdb6b8@siemens.com>
References: <5235edf1-6689-4417-9754-52584ecdb6b8@siemens.com>
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

On Mon, 2025-02-24 at 22:07 +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> These functions are called in case paravirtual IPIs are used.
> Just like for hard submission handlers, we need to harden the path to
> avoid splashes like these:
>=20
>  IRQ pipeline: some code running in oob context 'Xenomai'
>                called an in-band only routine
>  CPU: 0 PID: 410 Comm: (udev-worker) Not tainted 5.10.229-cip54+ #265
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd=
478f380-rebuilt.opensuse.org 04/01/2014
>  IRQ stage: Xenomai
>  Call Trace:
>   dump_stack+0x84/0x9c
>   inband_irq_save+0xa/0x30
>   __send_ipi_mask+0x81/0x260
>   ? preempt_count_sub+0x96/0xe0
>   ? _raw_spin_unlock_irq+0x33/0x50
>   ? xnsched_pick_next+0xe0/0xe0
>   ? ___xnsched_run+0x491/0x5b0
>   ? ktime_get_mono_fast_ns+0x50/0xb0
>   ___xnsched_run+0x491/0x5b0
>   run_oob_call+0x97/0x170
>   xnthread_start+0x23f/0x330
>   ? rt_stack_deliver+0x340/0x340 [rtnet]
>   rtdm_task_init.part.14+0x7e/0xc0
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/x86/hyperv/hv_apic.c | 4 ++--
>  arch/x86/kernel/kvm.c     | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index 0569f579338b5..e7b2a57c720ed 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -115,7 +115,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *=
mask, int vector,
>  	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
>  		return false;
> =20
> -	local_irq_save(flags);
> +	flags =3D hard_local_irq_save();
>  	ipi_arg =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> =20
>  	if (unlikely(!ipi_arg))
> @@ -150,7 +150,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *=
mask, int vector,
>  				     ipi_arg, NULL);
> =20
>  ipi_mask_ex_done:
> -	local_irq_restore(flags);
> +	hard_local_irq_restore(flags);
>  	return hv_result_success(status);
>  }
> =20
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 5df1061fc6ee1..b183caf41aa44 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -525,7 +525,7 @@ static void __send_ipi_mask(const struct cpumask *mas=
k, int vector)
>  	if (cpumask_empty(mask))
>  		return;
> =20
> -	local_irq_save(flags);
> +	flags =3D hard_local_irq_save();
> =20
>  	switch (vector) {
>  	default:
> @@ -563,7 +563,7 @@ static void __send_ipi_mask(const struct cpumask *mas=
k, int vector)
>  			  ret);
>  	}
> =20
> -	local_irq_restore(flags);
> +	hard_local_irq_restore(flags);
>  }
> =20
>  static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
> --=20
> 2.43.0

Applied to wip/v6.14-dovetail-rebase already.


--=20
Siemens AG, Foundational Technologies
Linux Expert Center



