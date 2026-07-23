Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A42A433E82
	for <xenomai@lists.linux.dev>; Thu, 23 Jul 2026 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816925; cv=none; b=ETpk6Ln5laaNaY3ZXnImVrVOx9czCYuSkpaFlPOOjTtrLoTDEjTci/SLlRD2JOWq/XhZHMUOidMWv66SDhgdWL7CGLEPYuhSHDW9VDi+tCTykl8zYLlDH3XrfUugKQra4pmucUcLpnnEXplQtDRTW615Z1XfZF64cRLVfnlY1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816925; c=relaxed/simple;
	bh=nPv2XcP/3EYHEn/pCrKsU9Ah4l3mAhHiaJ+DAxjZ6pA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IiXRBNbv7molItpIfH95Uz8hjLbVfDoQ3mgFKnHNGqkivb4RmerqvgQKVyiTOA7UjWapdZb5QVyCd1miyCVr/5++usKI5Dw37nXwA5Nf6V8wh4mRlvHWnmjhw+Ewv2EwhvyQsh1xnLj9JuqQwulBbxIf1AQ38203XFhLVHZpkf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=WDYpFtyi; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="WDYpFtyi"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8A1453ECD2;
	Thu, 23 Jul 2026 14:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1784816920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sf5GGJFwOLzfrOKsVOO6ZZuYTWoyollYIvgO/+8NDnc=;
	b=WDYpFtyi2x1dKbalmNXlwzMgF4CdJi7YKdkqw7/0F5ciIeWcR+yZgOrJXUlnURVmSU4hvP
	aQW9lRZ0VhuFYHyGhfaXIcCJk0AjcosZhh168p3uRU3MYbaVpH7IwZaenKohGmjWeCK+ti
	+r4lUyFPOkQ5ceeU3j4eh/DHg3yJMbPl7/ugIrfse6QZKOv7qYoVRQx5r08qK5rpHk+y16
	TKq0/wkiVlBXp7qIFNlHGX2ZphC7UWGZJivoBbt4LRMPpWCz/tB3MQrsLs+pnXY5j8/nBT
	nwdS9JHeCbrfIcTJGvfvOcfbf2EMagw5k4yHSCdblC10es90yXJaLTznNRUF1g==
From: Philippe Gerum <rpm@xenomai.org>
To: Richard Weinberger <richard@nod.at>
Cc: xenomai@lists.linux.dev,  upstream+xenomai@sigma-star.at
Subject: Re: [PATCH 2/2] mailbox: qcom-ipcc: Mark it as irq pipeline safe
In-Reply-To: <20260721081537.809383-2-richard@nod.at> (Richard Weinberger's
	message of "Tue, 21 Jul 2026 10:15:37 +0200")
References: <20260721081537.809383-1-richard@nod.at>
	<20260721081537.809383-2-richard@nod.at>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 23 Jul 2026 16:28:38 +0200
Message-ID: <871pct231l.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTE36IXj9a0DnTdVMyXy6KoRtDcLUyXbnj9dCU5cKLCLY50OdcXMfniXwxeh9HvJlICf3hm3M9X7L2pF8lbKLvo1QaGI6vccHe6YP75EAlAzJrTl19wYCvRMBxLQHoJXiGLinjDcGA1szsRqpeIX13RtSerzW9IFLqx75OaUjUhOdoQQzeMxeCuMqQi6+Ic3ABbt2lwRhyuA5kim+3ojIzI5PIOqV1jl3qMmoNFiqkK3Hzcs0HlG1jUGegKG5PPVE1BTPYPeMOF+8W1KCI1G9z0kZZlur8sBjEUUsA+dTAB6RIDUD/SNWSk5Zp3a8URdTfZRYrZVxvsHJJ2yBDynMfN9eXmIIrOIOe9UQqoZwlXjSQqInAaEBjj5kGKcQHsEkGBsLm0YsIf+C6RPFyLQYp9gDQEKQVZCxqSvKenC/xIUtPHczbbcPzqsshXPuU+u1sMIR+do1WS4oEWR4MZHMcEkuiyQRHtC9vPu5keXDgG/BELbNz/mBTX//KFzys5ujXA32gKcEwqrJdqSW30qmwAyUwTH3EpDX5z5UhaNe9kW0XAOr68G4FRm1ilaNvUpBjJrIGyHxhKSR1YPqJjzCmghMvALwb5HKk8W5cugQGU3//bGqczvSMEpWinKgZxV23+9B2j3ZLPM8OZVsU42sbR1ES9v6Oaota75B8LGxLnTqQ
X-GND-State: clean

Richard Weinberger <richard@nod.at> writes:

> With the summary IRQ OOB capable, child IRQs can also
> run OOB and the driver is irq  pipeline safe.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  drivers/mailbox/qcom-ipcc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
> index d957d989c0cee..c316d8b4c03c4 100644
> --- a/drivers/mailbox/qcom-ipcc.c
> +++ b/drivers/mailbox/qcom-ipcc.c
> @@ -110,7 +110,7 @@ static struct irq_chip qcom_ipcc_irq_chip = {
>  	.name = "ipcc",
>  	.irq_mask = qcom_ipcc_mask_irq,
>  	.irq_unmask = qcom_ipcc_unmask_irq,
> -	.flags = IRQCHIP_SKIP_SET_WAKE,
> +	.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_PIPELINE_SAFE,
>  };
>  
>  static int qcom_ipcc_domain_map(struct irq_domain *d, unsigned int irq,
> @@ -322,7 +322,7 @@ static int qcom_ipcc_probe(struct platform_device *pdev)
>  
>  	ret = devm_request_irq(&pdev->dev, ipcc->irq, qcom_ipcc_irq_fn,
>  			       IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND |
> -			       IRQF_NO_THREAD, name, ipcc);
> +			       IRQF_NO_THREAD | IRQF_OOB, name, ipcc);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Failed to register the irq: %d\n", ret);
>  		goto err_req_irq;

Merged, thanks.

-- 
Philippe.
