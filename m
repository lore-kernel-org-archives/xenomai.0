Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176041FBF
	for <xenomai@lists.linux.dev>; Sun, 17 Sep 2023 09:25:09 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7DDDAE0003;
	Sun, 17 Sep 2023 09:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1694942702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uoFZhA3PaG5QQHwunrD+slm+gRPqMqdD33OS/uzdLhU=;
	b=GGPUJ2N57Lb/knGjJPju+X0RCP41eSXJPj+qg5mOqRuCAHw62HD+C0ek4J7JJd35GzJldp
	zsWR9RHwxDoZXFRHidyraM0Lhdj+Av/PTxoDjqD8CShG3IXiyw5m5oJkgG2bWdhl5YKx3u
	Do+Ip0T2IB7r5bSgr9jqeow/ffzLaCfwhZCvwipgbDWt2EUIi0MIF0//rdKHx99O6KD35e
	JqkIbrArWqRGfDPpcIWxIgOdnSvTZOhUpaRoqEIGm07pLZ2bMoqutwEY1stxOpuwU4+GL/
	4K4PfzemzGi2UAEqg2FW6GXn2hCNpFR73+LXr/wmqrLtUgdztQtu8Z8sgPPcGg==
References: <87o7i3o7cd.fsf@xenomai.org>
 <MN2PR11MB4285939337A3D811141514B7F2F4A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <MN2PR11MB4285BACD1E28C473D9D681A8F2F4A@MN2PR11MB4285.namprd11.prod.outlook.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [PATCH] genirq: irq_pipeline: fix irq flow handling with
 stacked irqchips
Date: Sun, 17 Sep 2023 10:53:43 +0200
In-reply-to: <MN2PR11MB4285BACD1E28C473D9D681A8F2F4A@MN2PR11MB4285.namprd11.prod.outlook.com>
Message-ID: <878r95rw2f.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


"Chen, Hongzhan" <hongzhan.chen@intel.com> writes:

[snip]

>>>@@ -858,10 +946,12 @@ EXPORT_SYMBOL_GPL(handle_fasteoi_nmi);
>>> void handle_edge_irq(struct irq_desc *desc)
>>> {
>>> 	struct irq_chip *chip = irq_desc_get_chip(desc);
>>>+	int flow;
>>>
>>> 	raw_spin_lock(&desc->lock);
>>>
>>>-	if (start_irq_flow()) {
>>>+	flow = irq_starting_flow(desc);
>>>+	if (flow != IRQ_FLOW_REPLAY) {
>>> 		desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
>>>
>>> 		if (!irq_may_run(desc)) {
>>>@@ -881,7 +971,7 @@ void handle_edge_irq(struct irq_desc *desc)
>>> 		}
>>> 	}
>>>
>>>-	if (on_pipeline_entry()) {
>>>+	if (irq_feeding_pipeline(desc, flow)) {
>>> 		chip->irq_ack(&desc->irq_data);
>>> 		desc->istate |= IRQS_EDGE;
>>> 		handle_oob_irq(desc);
>>
>>
>>When the irq is PILEUP, actually the previous IRQS_DEFERRED bit has not been
>>cleared and the logged in-band irq has not been serviced yet. Do we need to
>>call handle_oob_irq to set IRQS_DEFERRED and log the inband irq again when
>
> It is meaningful to log the inband irq via calling irq_post_stage from handle_oob_irq
> in case current irq actually preempted in do_inband_irq where tried to service previous same irq number and already cleared the log before calling do_inband_irq.
>

That's correct, preemption might only happen after the initial irq event
was cleared in the log, but also after IRQS_DEFERRED was cleared in the
flow handler while replaying this event, so we need to set the deferral
flag again for the subsequent event. IOW, the code path from the call to
irq_feeding_pipeline() back to disabling hard irqs on return to
do_inband_irq() is not atomic. Fortunately, sync_current_irq_stage()
loops as long as events are pending in the log, so we won't miss the
piling ones.

Is this patch fixing the original issue you detected on your fixture?

-- 
Philippe.
