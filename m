Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333D3211C
	for <xenomai@lists.linux.dev>; Thu, 28 Nov 2024 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732814122; cv=none; b=SxLa1R5AorAWpBfTvt4ffKjRxaBEfWNBu2o79syudj5c4qDGOq3+FzQlpIolby7fw1i/D210Ar/K19jkGwkx4zyOTq+WSbxoPBCAPdAgYnD8v0FJRyHvJTJuYFpG3z0hZgZ2yTv5gbAWq6SeQV2otPq64yeQ9CHzN0EJsIDFzBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732814122; c=relaxed/simple;
	bh=vzI4dOKV/QXNhXO9P86HEac9zGV1NYC8Q9Kxbc9Q1Yc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bhKOGE0vhifBBBFejUTnA/M/oG/9KAaqudrG2YV0mpfVy75+tZ8Sev2aZCM/acqAg475f6TupvHw7SYSOWGxyGSVQMpcA4m6rlnBvpbBpUlbTaIHcKFIQCftlb8i5v57lldS+RYVV9JylDNbpRd4qeGvSXqUKdio7LzFMelL1kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so9752485e9.3
        for <xenomai@lists.linux.dev>; Thu, 28 Nov 2024 09:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732814118; x=1733418918;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TB85CFATutznPYULukW69r4LFEquOjFWZfCMcepXbrM=;
        b=FyEVT/h4HsGMrUwHycFE46kNucaDH2GtmEgSh8AyghUYCgt+/pO0c54jcDrCeZr+7x
         U/i+DEnlxC+bEPQBok960Yhh/pw9QHyywNqNq+ySsWVStHanqNipOA4ATbA7jn28pUb1
         IhQgdCNuPwSy4P8xifceLo1KZAN+efkXRGi6XVx9kCahWfB6cgTnbVVCzqok0/1gWo1x
         2At/zwQMKQGGyiEFcMT24dsOfngFpD7TWdsrNue+d8XkkHvO35YaFRSLq96JVhEhcxLz
         fko2tNWHt2/rbg79KaXAWZmE1hZpf0X7MnQIWeEOlCQoOIFXKingkt9K99+z0lqk2e1v
         aBpA==
X-Gm-Message-State: AOJu0YwYaIMiQsHwQ5MV7G4iGVTnGhT9KELq5++cZGG9SzfsgOUdRkx9
	NjTCMGMs0Hc+wPAp/UxjQLnAkXWjs6VQuXSPpYSaoagIZGrhq7WH
X-Gm-Gg: ASbGncuOTIm3awV4/nj11t/45fMnSqvh91q6/fQvE1s9dapjWk2kyYOxolVqE27qgF0
	AibjDphNDMgqOdMqZAeMWH5ChUxxF2B4YmJ71rBHHj3VR21LWij/vegh2yg88PcSNyKZU4oZdZr
	3tAI9t1jKkwS7RzwhKc8d4umEs64/nqzozftU8HOyqhd9Gn9W48qrJ/vdsn+R2dWE9Hx2nI+WbR
	sEt2q4qC67iORn4EyCpGBBnBgvdt4jBjeE=
X-Google-Smtp-Source: AGHT+IE+zGEhi16+uIBMqcQqWB0udlr0qImenNODfrKSBvy/N1LEkwocsx1lo3cV1PManEZ3IcVM0w==
X-Received: by 2002:a05:600c:8718:b0:434:a9bd:e67d with SMTP id 5b1f17b1804b1-434a9dbfd6amr72839685e9.13.1732814118157;
        Thu, 28 Nov 2024 09:15:18 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74edb1sm60787765e9.3.2024.11.28.09.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 09:15:17 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.1, 5.15, 5.10] x86: irq_pipeline: Raise oob
 IPIs only for the requested cpumask
In-Reply-To: <20241128130408.3512152-2-florian.bezdeka@siemens.com> (Florian
	Bezdeka's message of "Thu, 28 Nov 2024 14:04:08 +0100")
References: <20241128130408.3512152-1-florian.bezdeka@siemens.com>
	<20241128130408.3512152-2-florian.bezdeka@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Thu, 28 Nov 2024 18:15:16 +0100
Message-ID: <874j3rs2jf.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> irq_send_oob_ipi() silently migrates from the supplied cpumask to
> allbutself, which is a overkill - especially for the OOB resched
> vector.
>
> Seen in a real world trace - cpumask=6 requested but each CPU got one:
>
>        SCTSeqRun-17771 [000]  5888.449485: ipi_send_cpumask:     cpumask=6 callsite=run_oob_call+0x91 callback=0x0
>        SCTSeqRun-17771 [000]  5888.449487: write_msr:            830, value c00ea
>    OMP-TT-P19511-22125 [021]  5888.449489: irq_pipeline_entry:   irq=524545
>  PARC92.rawobjpr-19511 [019]  5888.449489: irq_pipeline_entry:   irq=524545
>        SCTSeqRun-17771 [000]  5888.449489: cobalt_head_sysexit:  result=0
>               ps-23075 [018]  5888.449489: irq_pipeline_entry:   irq=524545
>    OMP-TT-P19511-22138 [004]  5888.449489: irq_pipeline_entry:   irq=524545
>    OMP-TT-P19511-22129 [024]  5888.449489: irq_pipeline_entry:   irq=524545
>    OMP-TT-P19511-22131 [013]  5888.449489: irq_pipeline_entry:   irq=524545
>    OMP-TT-P19511-22147 [011]  5888.449489: irq_pipeline_entry:   irq=524545
>    OMP-TT-P19511-22128 [010]  5888.449489: irq_pipeline_entry:   irq=524545
>    OMP-TT-P19511-22137 [003]  5888.449489: irq_pipeline_entry:   irq=524545
>    OMP-TT-P19511-22144 [001]  5888.449489: irq_pipeline_entry:   irq=524545
>    OMP-TT-P19511-22145 [005]  5888.449489: irq_pipeline_entry:   irq=524545
>    OMP-TT-P19511-22140 [015]  5888.449489: irq_pipeline_entry:   irq=524545
>    OMP-TT-P19511-22136 [014]  5888.449489: irq_pipeline_entry:   irq=524545
>    OMP-TT-P19511-22134 [007]  5888.449489: irq_pipeline_entry:   irq=524545
>    OMP-TT-P19511-22121 [012]  5888.449489: irq_pipeline_entry:   irq=524545
>    OMP-TT-P19511-22127 [009]  5888.449489: irq_pipeline_entry:   irq=524545
>    OMP-TT-P19511-22130 [025]  5888.449489: irq_pipeline_entry:   irq=524545
>    OMP-TT-P19511-22149 [008]  5888.449489: irq_pipeline_entry:   irq=524545
>    OMP-TT-P19511-22148 [002]  5888.449489: irq_pipeline_entry:   irq=524545
>    OMP-TT-P19511-22122 [028]  5888.449489: irq_pipeline_entry:   irq=524545
>    OMP-TT-P19511-22126 [027]  5888.449489: irq_pipeline_entry:   irq=524545
>    ...
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/x86/kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
> index d8d7e37d03a8..5903a7c99c20 100644
> --- a/arch/x86/kernel/smp.c
> +++ b/arch/x86/kernel/smp.c
> @@ -276,7 +276,7 @@ DEFINE_IDTENTRY_SYSVEC_PIPELINED(CALL_FUNCTION_SINGLE_VECTOR,
>  void irq_send_oob_ipi(unsigned int ipi,
>  		const struct cpumask *cpumask)
>  {
> -	apic_send_IPI_allbutself(apicm_irq_vector(ipi));
> +	apic->send_IPI_mask(cpumask, apicm_irq_vector(ipi));
>  }
>  EXPORT_SYMBOL_GPL(irq_send_oob_ipi);

Merged into 6.1.y, thanks.

-- 
Philippe.
