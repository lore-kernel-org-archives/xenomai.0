Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55654101EB
	for <xenomai@lists.linux.dev>; Fri, 15 Sep 2023 13:08:21 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id ACD4FC8FFD
	for <xenomai@lists.linux.dev>; Fri, 15 Sep 2023 13:00:37 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E80601BF20E;
	Fri, 15 Sep 2023 13:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1694782830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T42AT/Oo0qnkLmynJzYSWRDRXmP9i2+4+l9vkq/CEHc=;
	b=VTJMqbqw7kE14NSlEUv92ak4i93DmbHJ8iiYsujF3ZRNWfWyLEln+zT3AEy8GFCoA0XrHH
	4pUpTNc73Da7tYIfwig9HreJ3l8gVT9phz75hLTJY2D8K4Xxiybh04vn6LJVYOowBvPLm/
	urVUGYTDcEvt9/GVVg9XloQiFOz//S9VrR1TgNQiyR8xXUM3S5lG3MS8Kee5vuZftpUwiN
	JE9yz3VSeayL5mJIRVdy5+qE3DsxPntplacKJyySOmAgBbGLBEF0gCkLtcvJ0k3xAq98Fc
	RPjc5icLstZ6FoPmtRTz6hVm4O0/qkUDXmntpryNVY1aJHVC/XSnfOKm/SEhRg==
References: <20230907125623.12266-1-hongzhan.chen@intel.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Hongzhan Chen <hongzhan.chen@intel.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] pipeline: irq: ack the irq when it is postponed inband
 irq from outside of the pipeline entry path.
Date: Fri, 15 Sep 2023 14:10:16 +0200
In-reply-to: <20230907125623.12266-1-hongzhan.chen@intel.com>
Message-ID: <87sf7foaky.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Hongzhan Chen <hongzhan.chen@intel.com> writes:

> 1. To avoid double ack for the interrupt that already acked in
>    pipeline entry path, we add new flag to note such status and
>    differentiate.
> 2. For postponed stacked edge irq that is handling outside of the
>    pipeline entry path, as discussed in [1], ack the irq directly
>    because it would never be acked in the pipeline entry path.
>
> [1]: https://lore.kernel.org/xenomai/BY5PR11MB4276FEFA2C6D88C4B6CFFEFCF2E9A@BY5PR11MB4276.namprd11.prod.outlook.com/T/#t
>
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
>
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 6aca6c036ada..b8d8aba38e17 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -862,15 +862,25 @@ void handle_edge_irq(struct irq_desc *desc)
>  	if (on_pipeline_entry()) {
>  		chip->irq_ack(&desc->irq_data);
>  		desc->istate |= IRQS_EDGE;
> -		handle_oob_irq(desc);
> +		if (!handle_oob_irq(desc)) {
> +
> +			/* For inband irq, we tag acked status
> +			 * to avoid double ack
> +			 */
> +			if (!oob_stage_present() || !irq_settings_is_oob(desc))
> +				desc->istate |= IRQS_ACK;

This code could move to handle_oob_irq(), provided that we account for
this generic behavior in the x86-specific APIC flow handler.

> +		}
> +
>  		goto out_unlock;
>  	}
>  
>  	kstat_incr_irqs_this_cpu(desc);
>  
>  	/* Start handling the irq */
> -	if (!irqs_pipelined())
> +	if (!(desc->istate & IRQS_ACK))

Disabling the IRQ pipeline should compile out any Dovetail-specific
code. In addition to ensuring zero overhead in this case, this is
important when chasing bugs as well, so that we can reliably compare
pipelined vs non-pipelined behavior with the very same kernel tree.

>  		chip->irq_ack(&desc->irq_data);
> +	else
> +		desc->istate &= ~IRQS_ACK;

Ok, this is going somewhere. I believe we need to generalize this
approach for all kinds of flow handlers, so that cascading any of them
would work, not only the edge one. There is also yet another tricky case
to care about when dealing with unmasked acked/eoi events, i.e.:

[IRQ-A] (acked, cascading, deferred handling to in-band stage)
  |
  +--> handler(A): demux IRQ-B (in-band)
       ...
       synchronize_pipeline_on_irq()
               hard irqs ON
               [IRQ-A]
                  |
                  +--> handler(A): demux IRQ-B
                       ...
                       synchronize_pipeline_on_irq()
                       hard irqs ON
                       flow_handler(B) (replay)
                       ...
                flow_handler(B) (replay)
                ...

and so on (a few intermediate steps were omitted). So we might have a
parent IRQ piling up prior to (re)playing the earlier one in-band with
hard irqs on, since we acked it early in the pipelining injection
path. IOW, the code which tracks the ack/eoi status for a cascaded event
from a stacked irqchip should be robust wrt this case too.

To achieve this, we could track the deferral status of irq events,
i.e. whether we expect them to be replayed in-band, instead of tracking
their acknowledge status on pipeline entry - this would disambiguate
some logic. We'd also need to track the state of the interrupt flow in a
more elaborate way than Dovetail currently implements. I'll follow up
with a patch illustrating this.

-- 
Philippe.
