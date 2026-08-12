Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BE93FDC05
	for <xenomai@lists.linux.dev>; Wed, 12 Aug 2026 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526007; cv=none; b=gpGopKbjLCQLgdIqpHWicDM1mH/2+8Ea8RSwZL1fZvBOV/O62mMc2kPpPU+LcZoFcTTJ24V6iJEkE+EUgl/s4O49YjsW1CRruFD+dlDzpjowjVb8fGic7iUazhdeP/3roySOxplBXMiBECnI0CNDf6XTd6FuL9cvhcb7tslRGmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526007; c=relaxed/simple;
	bh=2cwdA2nfOXF6rKdE7QNLef8FZBZ/083+VfT73dULWcU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CvI94bJVtzUGucEiq42/D/IaLh6qoOWusPcZg6TdfOeBIOvjcFhbJZLL+fFdA5vvJaMqEPiWmaKqb35fC/SHUYsx/x4JAUUA+Duxz1oauD+lPUTvy80x3PBxGWMjqC6rWXWdvc268gH5deAj3X3Kc+Ef5QishMcQTnzghrb4Azo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=JlohpHIz; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="JlohpHIz"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260812091311d9b6a9e520000207f3
        for <xenomai@lists.linux.dev>;
        Wed, 12 Aug 2026 11:13:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=iJV5g9/+CC26WN2yI2atUI8aSO2qkC/Sb+Ui6/rXMIQ=;
 b=JlohpHIzTxB6NYz/acLMozfrSkpnjIfCuLMzK0ktyZNcKJUrogWq+Z4GBV/sVWn0y7ZA/G
 H2/rEsla2V76A11wfexqScRNArmUHlrwIDixG8WyLbh9zEqoQqIy7MRcAkWT0xmwDoT2o9lg
 BGWp40CYcxQ5qx3ATngpgh1ffB9Mj92rKR5FVSjsQFQqcqlNKDrJTUr/N6/c3BV5JvIhGU5V
 DJ02pRjPzaFgaFCNQVZTZXUEsEDfDFCs+NVz5jInST9DOT5XqoYcXkVhjlLOMbuGVCwgNcMI
 AlxxKpcyIBdM3seHrzgnQYcsS8UWhIK1REtKbgUUiXk4l0JJVm87fLyg==;
Message-ID: <f19d66738d42006057609ef352a7d225bca79795.camel@siemens.com>
Subject: Re: [PATCH v1] x86/dovetail: pipeline the thermal APIC sysvec
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: liuyang <liuyang@sinsegye.com.cn>, xenomai@lists.linux.dev, Philippe
 Gerum	 <rpm@xenomai.org>
Cc: songjianwei@sinsegye.com.cn, lixiaoning@sinsegye.com.cn, 
	majun@sinsegye.com.cn
Date: Wed, 12 Aug 2026 11:13:11 +0200
In-Reply-To: <20260811120521.1677006-1-liuyang@sinsegye.com.cn>
References: <20260811120521.1677006-1-liuyang@sinsegye.com.cn>
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

On Tue, 2026-08-11 at 20:05 +0800, liuyang wrote:
> sysvec_thermal was a non-pipelined DEFINE_IDTENTRY_SYSVEC (with a real
> __apic_eoi()). Under thermal load we still hit stalls while that
> handler ran against in-band timer paths (therm_throt_process ->
> add_timer_on).
>=20
> Handle THERMAL_APIC_VECTOR as a pipelined sysvec and dispatch it from
> do_sysvec_inband(), so thermal runs on the in-band stage like other
> pipelined system vectors.

[ To +Philippe as the "Dovetail" prefix is missing in the subject line ]

Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>

>=20
> Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
> ---
>  arch/x86/include/asm/idtentry.h | 2 +-
>  arch/x86/kernel/irq.c           | 5 +++--
>  arch/x86/kernel/irq_pipeline.c  | 5 +++++
>  3 files changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idten=
try.h
> index bb1df662d..b8d4995f9 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -816,7 +816,7 @@ DECLARE_IDTENTRY_SYSVEC(DEFERRED_ERROR_VECTOR,		sysve=
c_deferred_error);
>  # endif
>=20
>  # ifdef CONFIG_X86_THERMAL_VECTOR
> -DECLARE_IDTENTRY_SYSVEC(THERMAL_APIC_VECTOR,		sysvec_thermal);
> +DECLARE_IDTENTRY_SYSVEC_PIPELINED(THERMAL_APIC_VECTOR,		sysvec_thermal);
>  # else
>  # define fred_sysvec_thermal				NULL
>  # endif
> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> index f745f1752..976828a63 100644
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
> @@ -582,12 +582,13 @@ static void smp_thermal_vector(void)
>  		       smp_processor_id());
>  }
>=20
> -DEFINE_IDTENTRY_SYSVEC(sysvec_thermal)
> +DEFINE_IDTENTRY_SYSVEC_PIPELINED(THERMAL_APIC_VECTOR,
> +				sysvec_thermal)
>  {
>  	trace_thermal_apic_entry(THERMAL_APIC_VECTOR);
>  	inc_irq_stat(irq_thermal_count);
>  	smp_thermal_vector();
>  	trace_thermal_apic_exit(THERMAL_APIC_VECTOR);
> -	__apic_eoi();
> +	apic_eoi();
>  }
>  #endif
> diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipelin=
e.c
> index 00cb779a2..cb267c2e0 100644
> --- a/arch/x86/kernel/irq_pipeline.c
> +++ b/arch/x86/kernel/irq_pipeline.c
> @@ -176,6 +176,11 @@ static void do_sysvec_inband(struct irq_desc *desc, =
struct pt_regs *regs)
>  	case LOCAL_TIMER_VECTOR:
>  		run_sysvec_on_irqstack_cond(__sysvec_apic_timer_interrupt, regs);
>  		break;
> +#ifdef CONFIG_X86_THERMAL_VECTOR
> +	case THERMAL_APIC_VECTOR:
> +		run_sysvec_on_irqstack_cond(__sysvec_thermal, regs);
> +		break;
> +#endif
>  	default:
>  		printk_once(KERN_ERR "irq_pipeline: unexpected event"
>  			" on vector #%.2x (irq=3D%u)", vector, irq);
> --
> 2.34.1
