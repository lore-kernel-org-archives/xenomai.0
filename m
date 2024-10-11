Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C9020ADC2
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728634186; cv=none; b=c6ktpgr5oxG1nHHctv4DIYPk0zzH9xVpB6/ZyrvMp7ONLspfbr4SJBTlcqSbnFuCqAMU2nXFXSmmotXg1JW44D/6IuN/Q3N10s2QDOl3fHxW3Lf7AmTq7Ia085KTNGBmWND/I/Qoj5tw0Tb+BJ2LyQZxVdMQeLCO9QzvYTMzvEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728634186; c=relaxed/simple;
	bh=OZbA/BIFvyXEiau/pW0eHdWd2/74ruNFLqPsRFBPC2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K6FPR3WVN1rg/Xa0PUTr//KhRSefABVYT/OPR61D2HCJfwIDqsaXTAITWa8YHzCmmqaf1yDuzffXryx5swjqMtuZ7lDd11JttwHJznte7OjKbGPddGok7EEwWtanwuPCqrLvyYnr6hz4Kd1b6i+PtYyK3lMaVht6gf1cNaPEMN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43056d99a5aso18010715e9.0
        for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 01:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728634183; x=1729238983;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FokMDoHMTGVx0tOsD9FKagrOHWf0raLeYIBoJDK9Pd4=;
        b=SBsCVMWx6kVK/osowlfupy8B3eRKxtORQ1W3eMNlGGIS0JdQJuBcUVPve5pR1awlbj
         dPj1c0iW+IeoowM+mIyCgS6cp+PNDhfVHzfu8QkxGXLzhYjXS9oQTsuCZbK0Rw+ga5St
         13XybwfuZEYrfsIiUPj8YM4NJQRdcJ7++w66fIkNHbrHcUZdrltTblkyTzDK67+2cp/E
         9YGkdbPUAAaBrOrBR+rN/OO7c9CWwdOZJbOpYVZLAuCgARNBtbPrVsk3F3BluP8HMKMN
         ryEfr9jWxeh4E+TY2xI/GDjrpgXcqD2J3uLAj9oJF4PMZLvzwAArQp4ElrWq4X4Usv2u
         HSEA==
X-Gm-Message-State: AOJu0YxGmBbW2Kx0/9TsAvYQsYMd78sL/jONLOxUIDo9DdJVz9Ign6EM
	SgjHIRftlvB0d8sQIDCtvkrtlTr7rMukVyADZ+gYbaXdfTw7B4Ax
X-Google-Smtp-Source: AGHT+IEM4/Vwt7FNOANGsApLaQcEfuBsQ6leIIxpHQ2qdUf+VpRo0KeMV82Viu5JQBzHSAn+is1N/Q==
X-Received: by 2002:a05:600c:1c1d:b0:426:67f9:a7d8 with SMTP id 5b1f17b1804b1-4311d9037demr14956105e9.9.1728634182525;
        Fri, 11 Oct 2024 01:09:42 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d794asm35651875e9.1.2024.10.11.01.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 01:09:42 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: shannmu <shanmu1901@gmail.com>
Cc: xenomai@lists.linux.dev,  jan.kiszka@siemens.com
Subject: Re: [PATCH 2/3] clocksource: Add irq pipelined clock events
In-Reply-To: <20241011063730.310568-3-shanmu1901@gmail.com> (shannmu's message
	of "Fri, 11 Oct 2024 06:37:29 +0000")
References: <20241011063730.310568-1-shanmu1901@gmail.com>
	<20241011063730.310568-3-shanmu1901@gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 11 Oct 2024 10:09:41 +0200
Message-ID: <87o73r83i2.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Thanks for sharing this work. Quick review, more later.

shannmu <shanmu1901@gmail.com> writes:

> This adds pipelined clock events for irqchip.
>
> Signed-off-by: shannmu <shanmu1901@gmail.com>
> ---
>  drivers/clocksource/timer-clint.c |  9 +++---
>  drivers/clocksource/timer-riscv.c | 46 ++++++++++++++++---------------
>  drivers/irqchip/irq-riscv-intc.c  |  1 +
>  drivers/irqchip/irq-sifive-plic.c |  7 +++--
>  4 files changed, 33 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
> index 9a55e733ae99..de3eb6937d6e 100644
> --- a/drivers/clocksource/timer-clint.c
> +++ b/drivers/clocksource/timer-clint.c
> @@ -111,17 +111,16 @@ static struct clocksource clint_clocksource = {
>  static int clint_clock_next_event(unsigned long delta,
>  				   struct clock_event_device *ce)
>  {
> -	void __iomem *r = clint_timer_cmp +
> -			  cpuid_to_hartid_map(smp_processor_id());
> +	void __iomem *r = clint_timer_cmp + cpuid_to_hartid_map(smp_processor_id());
>

Noisy whitespace change.

> -	csr_set(CSR_IE, IE_TIE);
>  	writeq_relaxed(clint_get_cycles64() + delta, r);
> +	csr_set(CSR_IE, IE_TIE);

I understand that you needed that change to get the timer event delivery
working in pipelined mode, however could you explain the rationale
behind this difference with the upstream implementation, assuming that
hard irqs should be disabled on entry to the clock event handler when
running on the oob stage?

>  
>  static int riscv_clock_next_event(unsigned long delta,
> -		struct clock_event_device *ce)
> +				  struct clock_event_device *ce)
>  {
>  	u64 next_tval = get_cycles64() + delta;
>  
> -	csr_set(CSR_IE, IE_TIE);
>  	if (static_branch_likely(&riscv_sstc_available)) {
>  #if defined(CONFIG_32BIT)
>  		csr_write(CSR_STIMECMP, next_tval & 0xFFFFFFFF);
> @@ -47,15 +46,17 @@ static int riscv_clock_next_event(unsigned long delta,
>  	} else
>  		sbi_set_timer(next_tval);
>  
> +	csr_set(CSR_IE, IE_TIE);
> +

Ditto.

>  	return 0;
>  }
>  
>  static unsigned int riscv_clock_event_irq;
>  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
> -	.name			= "riscv_timer_clockevent",
> -	.features		= CLOCK_EVT_FEAT_ONESHOT,
> -	.rating			= 100,
> -	.set_next_event		= riscv_clock_next_event,
> +	.name = "riscv_timer_clockevent",
> +	.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PIPELINE,
> +	.rating = 100,
> +	.set_next_event = riscv_clock_next_event,
>  };

Some noisy whitespace changes here as well (might cause useless merge
conflicts when rebasing).

>  
>  /*
> @@ -74,11 +75,11 @@ static u64 notrace riscv_sched_clock(void)
>  }
>  
>  static struct clocksource riscv_clocksource = {
> -	.name		= "riscv_clocksource",
> -	.rating		= 400,
> -	.mask		= CLOCKSOURCE_MASK(64),
> -	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> -	.read		= riscv_clocksource_rdtime,
> +	.name = "riscv_clocksource",
> +	.rating = 400,
> +	.mask = CLOCKSOURCE_MASK(64),
> +	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
> +	.read = riscv_clocksource_rdtime,

Ditto.

>  
>  	riscv_clock_event_irq = irq_create_mapping(domain, RV_IRQ_TIMER);
>  	if (!riscv_clock_event_irq) {
> -		pr_err("Failed to map timer interrupt for node [%pfwP]\n", intc_fwnode);
> +		pr_err("Failed to map timer interrupt for node [%pfwP]\n",
> +		       intc_fwnode);
>  		return -ENODEV;
>  	}
>

Again.

> @@ -152,9 +154,8 @@ static int __init riscv_timer_init_common(void)
>  
>  	sched_clock_register(riscv_sched_clock, 64, riscv_timebase);
>  
> -	error = request_percpu_irq(riscv_clock_event_irq,
> -				    riscv_timer_interrupt,
> -				    "riscv-timer", &riscv_clock_event);
> +	error = request_percpu_irq(riscv_clock_event_irq, riscv_timer_interrupt,
> +				   "riscv-timer", &riscv_clock_event);

Same.

>  	if (error) {
>  		pr_err("registering percpu irq failed [%d]\n", error);
>  		return error;
> @@ -166,8 +167,9 @@ static int __init riscv_timer_init_common(void)
>  	}
>  
>  	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
> -			 "clockevents/riscv/timer:starting",
> -			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
> +				  "clockevents/riscv/timer:starting",
> +				  riscv_timer_starting_cpu,
> +				  riscv_timer_dying_cpu);

>  	if (error)
>  		pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
>  		       error);
> @@ -183,8 +185,8 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>  
>  	error = riscv_of_processor_hartid(n, &hartid);
>  	if (error < 0) {
> -		pr_warn("Invalid hartid for node [%pOF] error = [%lu]\n",
> -			n, hartid);
> +		pr_warn("Invalid hartid for node [%pOF] error = [%lu]\n", n,
> +			hartid);
>  		return error;
>  	}
>  
> @@ -199,8 +201,8 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>  
>  	child = of_find_compatible_node(NULL, NULL, "riscv,timer");
>  	if (child) {
> -		riscv_timer_cannot_wake_cpu = of_property_read_bool(child,
> -					"riscv,timer-cannot-wake-cpu");
> +		riscv_timer_cannot_wake_cpu = of_property_read_bool(
> +			child, "riscv,timer-cannot-wake-cpu");
>  		of_node_put(child);
>  	}
>

etc.

>  static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index bf0b40b0fad4..9c03993ddbba 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -197,8 +197,8 @@ static struct irq_chip plic_edge_chip = {
>  	.irq_set_affinity = plic_set_affinity,
>  #endif
>  	.irq_set_type	= plic_irq_set_type,
> -	.flags		= IRQCHIP_SKIP_SET_WAKE |
> -			  IRQCHIP_AFFINITY_PRE_STARTUP,
> +	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_AFFINITY_PRE_STARTUP |
> +		IRQCHIP_PIPELINE_SAFE,
>  };
>  
>  static struct irq_chip plic_chip = {
> @@ -213,7 +213,8 @@ static struct irq_chip plic_chip = {
>  #endif
>  	.irq_set_type	= plic_irq_set_type,
>  	.flags		= IRQCHIP_SKIP_SET_WAKE |
> -			  IRQCHIP_AFFINITY_PRE_STARTUP,
> +			  IRQCHIP_AFFINITY_PRE_STARTUP |
> +			  IRQCHIP_PIPELINE_SAFE,
>  };
>  
>  static int plic_irq_set_type(struct irq_data *d, unsigned int type)

This enable_lock is shared between the in-band and oob stages (via
plic_toggle() on EOI and plic_set_affinity() at the very least. We need
a hard spinlock to replace the original raw spinlock (API to use it is
unchanged).

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index bf0b40b0fad4b..a3fa11a96645d 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -79,7 +79,7 @@ struct plic_handler {
 	 * Protect mask operations on the registers given that we can't
 	 * assume atomic memory operations work on them.
 	 */
-	raw_spinlock_t		enable_lock;
+	hard_spinlock_t		enable_lock;
 	void __iomem		*enable_base;
 	u32			*enable_save;
 	struct plic_priv	*priv;

-- 
Philippe.
