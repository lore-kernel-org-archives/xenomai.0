Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580763ACEF7
	for <xenomai@lists.linux.dev>; Thu,  8 Jan 2026 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767860556; cv=none; b=HJcpSw4O9NewEmbhDqpTDz3/OtKpxybrnXL90nVg8zNVue7ztVZ8nWGvH+dKWTsdk3eGNveVbWuE7zUiX2w2whN1Qn5KKOYYlaWVxXglUhMv74NQ32w47for9mmGfwUD1WRGiiQAjgd+ezIHf5CqcioE9MECHLDDP3Dlzd1JVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767860556; c=relaxed/simple;
	bh=tOydIFyNJY/gD3Sd9rYkA2DvIIlPZQxdFQZy3j4bZi0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bHsSaVFfXNTpyEj8GA1NYboEuwAE5J64QkiOvulBVEW/D6nmrqPfrsPv87YXhmQEJlfGO878KJTXKI+2fUu5mz8SCgMcIbTeRYcXSbwxj6LKYXZrxFYUE9XHLwx1B9sm21yiNX/HTTUysjNB7laYE8ZE+9obumx6lvUuFsWjD+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=DyGKAxok; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="DyGKAxok"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260108082221ef88cd872b000207c8
        for <xenomai@lists.linux.dev>;
        Thu, 08 Jan 2026 09:22:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=BpBZinQ0Dik0qRh/6Kgc60UvhDT4qXKGpR91nZu71Zk=;
 b=DyGKAxok6/JKWOuJ1LvSt/A614ytXcKh5o1EV3oF5qPIguc3NYeJHXB78uFG5lF7DphIz3
 eMnbMjO5jZlTgllBGb2DxMIRR4NdGh0IpTuJDsqHGCi0CzLHQRDKTSOD2gQfCMQJy/ZoKy0E
 hat71K6M3gLg2g8Si+cBrzExus+ABWaeI+t+KzYs6owCALmWS6GerxIyLfgGEF9yN3rnY2m6
 JJjU2A+xGFX7EIXszt6+hi2bN6RRk0m7AdaOm6VDR8bDMaZYeE2UeArTVV+xExJwJQxx7xIZ
 F6ytr+B1tpvjm/HhZrz18y7oms2iEPt76p8SUvVF7s8wS1COr8TaPUVA==;
Message-ID: <4fc9725250f6c4072853196c6747e51c8456fd0f.camel@siemens.com>
Subject: Re: [PATCH v1] x86: fix stale CONFIG_HAVE_KVM reference in
 irq_pipeline
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: liuyang <liuyang@sinsegye.com.cn>, xenomai@lists.linux.dev, Philippe
 Gerum	 <rpm@xenomai.org>
Cc: songjianwei@sinsegye.com.cn
Date: Thu, 08 Jan 2026 09:22:20 +0100
In-Reply-To: <20260104021211.548905-1-liuyang@sinsegye.com.cn>
References: <20260104021211.548905-1-liuyang@sinsegye.com.cn>
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

On Sun, 2026-01-04 at 10:12 +0800, liuyang wrote:
> The CONFIG_HAVE_KVM macro has been removed in kernel 6.12.=20
> Consequently, the code block for POSTED_INTR_VECTOR in=20
> do_sysvec_inband() is no longer being compiled even when KVM=20
> is enabled.
>=20
> Replace the obsolete CONFIG_HAVE_KVM with IS_ENABLED(CONFIG_KVM)=20
> to restore the correct behavior for KVM posted interrupts in=20
> the interrupt pipeline.
>=20
> Signed-off-by: liuyang <liuyang@sinsegye.com.cn>

Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>

Cc: Philippe

Philippe, this patch needs to be applied to 6.18 and 6.12.
Thanks!

> ---
>  arch/x86/kernel/irq_pipeline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipelin=
e.c
> index 7a64af5dab73..8c9d587bf188 100644
> --- a/arch/x86/kernel/irq_pipeline.c
> +++ b/arch/x86/kernel/irq_pipeline.c
> @@ -143,7 +143,7 @@ static void do_sysvec_inband(struct irq_desc *desc, s=
truct pt_regs *regs)
>  	case IRQ_WORK_VECTOR:
>  		run_sysvec_on_irqstack_cond(__sysvec_irq_work, regs);
>  		break;
> -#ifdef CONFIG_HAVE_KVM
> +#if IS_ENABLED(CONFIG_KVM)
>  	case POSTED_INTR_VECTOR:
>  		run_sysvec_on_irqstack_cond(__sysvec_kvm_posted_intr_ipi,
>  					regs);
> --=20
> 2.43.0
