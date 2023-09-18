Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5194310F9
	for <xenomai@lists.linux.dev>; Mon, 18 Sep 2023 07:50:56 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 6A013CBE76
	for <xenomai@lists.linux.dev>; Mon, 18 Sep 2023 07:42:13 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE247240011;
	Mon, 18 Sep 2023 07:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1695022924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mUhH5A6KFhxTJYstjAfIqubG7jGZAC8m9S8SK/CN0m4=;
	b=dwFoTBryx/Zr0/dMmtLex1KxUSiGVQGpAsVnMRs65S4To+h87OCs+YkXnt8bGLLEeLad6B
	/A1N/Kkt2JA/73M0Lsb1bAmDzMW2+sLq7rhmoOdrgng6FeST/RTyad8I3PYvHnarLpZGIx
	5B/vNSNxtp1nJuNYP/AzEEcBHLBuAGI5JtxYz4LuPe+YLgRAX0k721MyEY2CRPNSpHZPCq
	ZjFBFp57TcVUBiFSgoYGVt4JgZrNbzkjrU332aWqm/3g2uDKSQdKDxHHMPBvsuzCunaCKL
	3kk+CDvpnBi5AoC5CGQsNyMYGRnrVAXaRACBPfXr3jSbVMVYftcIitlQTHIi9A==
References: <87o7i3o7cd.fsf@xenomai.org>
 <MN2PR11MB4285939337A3D811141514B7F2F4A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <MN2PR11MB4285BACD1E28C473D9D681A8F2F4A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <878r95rw2f.fsf@xenomai.org>
 <MN2PR11MB428550B2680336839C7A64EDF2F4A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <MN2PR11MB4285C7F8B3C27EBA9ECEC339F2FBA@MN2PR11MB4285.namprd11.prod.outlook.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [PATCH] genirq: irq_pipeline: fix irq flow handling with
 stacked irqchips
Date: Mon, 18 Sep 2023 09:41:17 +0200
In-reply-to: <MN2PR11MB4285C7F8B3C27EBA9ECEC339F2FBA@MN2PR11MB4285.namprd11.prod.outlook.com>
Message-ID: <87h6ns6i7u.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


"Chen, Hongzhan" <hongzhan.chen@intel.com> writes:

>>-----Original Message-----
>>From: Chen, Hongzhan <hongzhan.chen@intel.com>
>>Sent: Sunday, September 17, 2023 9:43 PM
>>To: Philippe Gerum <rpm@xenomai.org>
>>Cc: xenomai@lists.linux.dev
>>Subject: RE: [PATCH] genirq: irq_pipeline: fix irq flow handling with stacked
>>irqchips
>>
>>
>>
>>>-----Original Message-----
>>>From: Philippe Gerum <rpm@xenomai.org>
>>>Sent: Sunday, September 17, 2023 4:54 PM
>>>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>Cc: xenomai@lists.linux.dev
>>>Subject: Re: [PATCH] genirq: irq_pipeline: fix irq flow handling with stacked
>>>irqchips
>>>
>>>
>>>"Chen, Hongzhan" <hongzhan.chen@intel.com> writes:
>>>
>>>[snip]
>>>
>>>>>>@@ -858,10 +946,12 @@ EXPORT_SYMBOL_GPL(handle_fasteoi_nmi);
>>>>>> void handle_edge_irq(struct irq_desc *desc)
>>>>>> {
>>>>>> 	struct irq_chip *chip = irq_desc_get_chip(desc);
>>>>>>+	int flow;
>>>>>>
>>>>>> 	raw_spin_lock(&desc->lock);
>>>>>>
>>>>>>-	if (start_irq_flow()) {
>>>>>>+	flow = irq_starting_flow(desc);
>>>>>>+	if (flow != IRQ_FLOW_REPLAY) {
>>>>>> 		desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
>>>>>>
>>>>>> 		if (!irq_may_run(desc)) {
>>>>>>@@ -881,7 +971,7 @@ void handle_edge_irq(struct irq_desc *desc)
>>>>>> 		}
>>>>>> 	}
>>>>>>
>>>>>>-	if (on_pipeline_entry()) {
>>>>>>+	if (irq_feeding_pipeline(desc, flow)) {
>>>>>> 		chip->irq_ack(&desc->irq_data);
>>>>>> 		desc->istate |= IRQS_EDGE;
>>>>>> 		handle_oob_irq(desc);
>>>>>
>>>>>
>>>>>When the irq is PILEUP, actually the previous IRQS_DEFERRED bit has not
>>>been
>>>>>cleared and the logged in-band irq has not been serviced yet. Do we need
>>>to
>>>>>call handle_oob_irq to set IRQS_DEFERRED and log the inband irq again
>>>when
>>>>
>>>> It is meaningful to log the inband irq via calling irq_post_stage from
>>>handle_oob_irq
>>>> in case current irq actually preempted in do_inband_irq where tried to
>>>service previous same irq number and already cleared the log before calling
>>>do_inband_irq.
>>>>
>>>
>>>That's correct, preemption might only happen after the initial irq event
>>>was cleared in the log, but also after IRQS_DEFERRED was cleared in the
>>>flow handler while replaying this event, so we need to set the deferral
>>>flag again for the subsequent event. IOW, the code path from the call to
>>>irq_feeding_pipeline() back to disabling hard irqs on return to
>>>do_inband_irq() is not atomic. Fortunately, sync_current_irq_stage()
>>>loops as long as events are pending in the log, so we won't miss the
>>>piling ones.
>>>
>>>Is this patch fixing the original issue you detected on your fixture?
>>
>>Logically, it fix the the issue but I have not tested it yet. I will validate it
>>tomorrow
>>when I am on duty and then give you feedback.
>
> The issue still exists after apply the patch because irq_feeding_pipeline never return true for the cascaded
> edge_irq so that it would never call chip->irq_ack(&desc->irq_data) and handle_oob_irq(desc) in handle_edge_irq
>
>    handle_irq_pipelined_prepare()
>     [on_pipeline_entry: true]
>     arch_handle_irq()
>             handle_fasteoi_irq()
>                     handle_oob_irq()
>                             mask_cond_eoi_irq()
>     handle_irq_pipelined_finish()
>     [on_pipeline_entry: false]
>             synchronize_pipeline_on_irq()
>                     handle_fasteoi_irq() [!on_pipeline_entry]
>                           intel_gpio_irq()
>                                handle_edge_irq() 
>                                         irq_starting_flow  <<< return IRQ_FLOW_REPLAY
>                                         irq_feeding_pipeline  <<<  return false  
>

Which makes sense, the logic irq_starting_flow() is half-baked. Working
on this.

-- 
Philippe.
