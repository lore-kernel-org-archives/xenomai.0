Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265BC9463
	for <xenomai@lists.linux.dev>; Thu, 28 Nov 2024 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732814099; cv=none; b=h8Yym04tahUpinwkGkdnmKW7KpeCDWp2/c39kgxl2eOh2WdCxa0kAVKK/eMAfBhJuSqRi+5W7y8n8qj3zUl0sZRQHAbWYKMb7WWZ71j7Ouhn4RDQZlrBx3rCXq1difaOnNEy9Jx84Zlxdcv49i5qIYgbKfAGKtakW216P2h1YdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732814099; c=relaxed/simple;
	bh=eXkZXbVXnL7m1HgsCQ/wUfJFxHIW4vqYb1Sucz5rVN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u0Gzu/boy6oWbA/LlQVt+5/B+9wJfiFmFLLcdunQY103Dsee8gKAqW2Uf7crzm30zXpvMbVny5qL9SxcYF9yZEy3qUCwE8lP/Az5sMLu5EgYEQ/FhA0tFLrb9xrSMMiwBKAAKUckzUrFRxnuKCiScBv1/VOXoj9JP7WR8fbkLIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a10588f3so6726505e9.1
        for <xenomai@lists.linux.dev>; Thu, 28 Nov 2024 09:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732814096; x=1733418896;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDmb8a1zqG558dnZMDty9UlozGVIqYJGGfGrwRvgoRg=;
        b=dmR1HSa+Ttwl0jHlUnA35iegMO2Xq/2i8yEEjKOJ67GUoULYkOrGK1SlGadWQ9jwFj
         B0ikhZvvPK9EMFin6VtHu2qQ1ci8y8ehSW83akikKYKyhS4k2sfFGjmLaot0WJa2gqCt
         9Mzcqjs/iL3+oqIrXXd47/ZnwuHEdpMCUr+D5Cfeq/ETBB3ZPv61784Nib01HRq2BvnT
         t/aUhUZfVJ3oaucUC3lXMTujXh/l9b66jDfZZE6PfZ41bUDm+j1K0A0FUv+NXEmRUErv
         N9gQ4Ot/GRhHLLxaWmlSt4kbquRbnCU3AJsAlhHCGG10gcAbnK6bbvIOkG5Unvrj9mR1
         3RDg==
X-Gm-Message-State: AOJu0YwF+5ZQkI6gbivhV8/iY2qLh3yK6WsEa1Jjf933J6bzMKShO42+
	58l4yA5Rn2fCpy231OTuuwAdjQoTMlilF7pdeg7MeVxZ6nUO5iU5keiKHg==
X-Gm-Gg: ASbGncvhKUmK6yYF+PwttSB8K0luYzXYN0mBuoz3sqFQ0IsAaoN7CBSlptPurxC71me
	IKZ0glaFejqguwYUc56qtoNbBWzSgyyKuYro8FqKrhW6dqZPiarGKedtQ2SipfNeXARErKCTL+G
	hnqb6UJPYsy4yil4grlniq+7ZnFKKbowjCTDraHxV7yhwoYdRyK90GNYlzvhPVxe7bO+Fm1J2SD
	Yh7fvuq4LFTX5X1uIoxre2JFwZ4XwWVMak=
X-Google-Smtp-Source: AGHT+IHKAGgIfC7kEaF/AJZ4PBdKmmPPBmxZqti999pqo/SLlFb2qkv84pLu1H54HiPqRdoV7PmnZQ==
X-Received: by 2002:a05:600c:b8b:b0:434:9e17:18e5 with SMTP id 5b1f17b1804b1-434a9d4f7famr84569195e9.0.1732814096339;
        Thu, 28 Nov 2024 09:14:56 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa763aaesm59032855e9.14.2024.11.28.09.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 09:14:55 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.12, 6.6] x86: irq_pipeline: Raise oob IPIs
 only for the requested cpumask
In-Reply-To: <20241128130408.3512152-1-florian.bezdeka@siemens.com> (Florian
	Bezdeka's message of "Thu, 28 Nov 2024 14:04:07 +0100")
References: <20241128130408.3512152-1-florian.bezdeka@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Thu, 28 Nov 2024 18:14:55 +0100
Message-ID: <87a5djs2k0.fsf@xenomai.org>
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
> index 6c4fb847b4d4..1eb0b67479a2 100644
> --- a/arch/x86/kernel/smp.c
> +++ b/arch/x86/kernel/smp.c
> @@ -280,7 +280,7 @@ DEFINE_IDTENTRY_SYSVEC_PIPELINED(CALL_FUNCTION_SINGLE_VECTOR,
>  void irq_send_oob_ipi(unsigned int ipi,
>  		const struct cpumask *cpumask)
>  {
> -	apic_send_IPI_allbutself(apicm_irq_vector(ipi));
> +	__apic_send_IPI_mask(cpumask, apicm_irq_vector(ipi));
>  }
>  EXPORT_SYMBOL_GPL(irq_send_oob_ipi);

Merged, thanks.

-- 
Philippe.
