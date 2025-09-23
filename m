Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AC6302157
	for <xenomai@lists.linux.dev>; Tue, 23 Sep 2025 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758652913; cv=none; b=cLzowyg2rijAif1DHqFD9YgjlpR6BdOuQUJkbvQE3UPKTZLiqvriXqWiXTf9lVHKn920nGJj4nTDX/bnXaxCtd7hAVocgCWAv3jVDzqmT+V8xfj767PwAwlASn8ZKJPYjbW40wPdokuNcIT+mtPhMLHE6euWsiXKNMzIGHTfEAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758652913; c=relaxed/simple;
	bh=3LMfG4erGth2L1wjfdBNE1BgilqQoStyJ1TlZtEXpAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qkuLfKmyJqP2uz8Y8T9eTie8PfsLp2bqoPL0JK25NDTJfakd+zNyZixlDe3DGNqJphmQykiXwHLb2NQYrM957/QpVYXsv5nhswO1OZYmQ4LW+1ptTGPjooYDViM8GggHQq8TlvUWVJ6FSINF5EGm0pIpHeQiIbHs094Qyl6PAJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=oad9dtnp; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="oad9dtnp"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7DDE4445C;
	Tue, 23 Sep 2025 18:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1758652903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rEH97s7h/nj+DBo80CreTXm4VIzCbPyaVgoVUAObYE0=;
	b=oad9dtnppMF5mdjMhSpcZbuADs5cosq97ZAHUloaAGAqDL2Pmsg7VgiKD8wVrVtYm+JRmQ
	LLLeOCYDPfR5JH6PMwnW/HxLOCMB7aP6jiSOebRPoqcg+fZokuP3KHvWIwxr+oFZ0YzQgX
	FwjwIS7J2ve2THRo8gl67zAsyJI++rf0VZyDDstxLkzI6GtLa6y3kA2T0J1ATMLymRFJYa
	RZBajseNLmn9nMWBXVrRZ5SL4HNxd3lFCkLhVj0Dn2absgk8Mg7jfxcUiVvPDL/0K1wCoz
	gbfOh1JZfsUskdFq/on57eQBckYvpLDBZ74oG8Nlt3wICK4YIkLM172XZfKu5g==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 1/4] clocksource/hyper-v: irq_pipeline: Enable pipelined
 clock events
In-Reply-To: <20250602-flo-add-hyperv-support-for-6-15-v1-1-449e6c20debd@siemens.com>
	(Florian Bezdeka's message of "Thu, 18 Sep 2025 15:37:57 +0200")
References: <20250602-flo-add-hyperv-support-for-6-15-v1-0-449e6c20debd@siemens.com>
	<20250602-flo-add-hyperv-support-for-6-15-v1-1-449e6c20debd@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 23 Sep 2025 20:41:38 +0200
Message-ID: <87h5wtm2ot.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Fixes a boot failure on hyper-v.
>

A bit of context would help here. Failure doing what, enabling the proxy
tick on STIMER0?

> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  drivers/clocksource/hyperv_timer.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index 2edc13ca184e0..0850b0c385a8e 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -26,6 +26,7 @@
>  #include <clocksource/hyperv_timer.h>
>  #include <hyperv/hvhdk.h>
>  #include <asm/mshyperv.h>
> +#include <asm/trace/irq_vectors.h>
>  
>  static struct clock_event_device __percpu *hv_clock_event;
>  /* Note: offset can hold negative values after hibernation. */
> @@ -53,6 +54,30 @@ static int stimer0_irq = -1;
>  static int stimer0_message_sint;
>  static __maybe_unused DEFINE_PER_CPU(long, stimer0_evt);
>  
> +#ifdef CONFIG_IRQ_PIPELINE
> +
> +#define HV_STIMER_IRQ	apicm_vector_irq(HYPERV_STIMER0_VECTOR)
> +

Does this mean that we won't support Hyper-V on architectures with
per-CPU irqs (according to the comment heading hv_setup_stimer0_irq()),
or is this ok to always bypass the ACPI in order to get the STIMER0
interrupt in the pipeline case?

> +static irqreturn_t hv_stimer_oob_handler(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = this_cpu_ptr(hv_clock_event);
> +
> +	trace_local_timer_entry(HYPERV_STIMER0_VECTOR);
> +	clockevents_handle_event(evt);
> +	trace_local_timer_exit(HYPERV_STIMER0_VECTOR);
> +
> +	return IRQ_HANDLED;
> +}
> +

Could not we have hv_stimer0_isr() call clockevents_handle_event()
instead, so that hv_setup_stimer0_irq() -> hv_stimer0_percpu_isr() could
be reused, only fixed up for picking the IRQ number from the apic
mapping if interrupts are pipelined?

> +static struct irqaction hv_stimer_oob_action = {
> +	.handler = hv_stimer_oob_handler,
> +	.name = "Out-of-band STIMER0 timer interrupt",
> +	.flags = IRQF_TIMER | IRQF_PERCPU,
> +};
> +#else
> +#define HV_STIMER_IRQ	-1
> +#endif
> +
>  /*
>   * Common code for stimer0 interrupts coming via Direct Mode or
>   * as a VMbus message.
> @@ -137,8 +162,9 @@ static int hv_stimer_init(unsigned int cpu)
>  
>  	ce = per_cpu_ptr(hv_clock_event, cpu);
>  	ce->name = "Hyper-V clockevent";
> -	ce->features = CLOCK_EVT_FEAT_ONESHOT;
> +	ce->features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PIPELINE;
>  	ce->cpumask = cpumask_of(cpu);
> +	ce->irq = HV_STIMER_IRQ;
>  
>  	/*
>  	 * Lower the rating of the Hyper-V timer in a TDX VM without paravisor,
> @@ -305,6 +331,12 @@ int hv_stimer_alloc(bool have_percpu_irqs)
>  		hv_remove_stimer0_irq();
>  		goto free_clock_event;
>  	}
> +
> +#ifdef CONFIG_IRQ_PIPELINE
> +	ret = setup_percpu_irq(HV_STIMER_IRQ, &hv_stimer_oob_action);
> +	if (ret)
> +		goto free_clock_event;
> +#endif
>  	return ret;
>  
>  free_clock_event:

-- 
Philippe.
