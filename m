Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CEA28134C
	for <xenomai@lists.linux.dev>; Tue,  3 Feb 2026 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139351; cv=none; b=J7bVJZ8pExPiI1oQle9Ui9GFPaFGF/qWZDFY0kBh8KRvjqQvJIFBsp6q4cdj6i8F9e1IsI0h9DOcUi83VwcB0BUpVxvzAohiH1BTRTuCqHXc3ITxnd3Tuji3fJQDDTgQtDDkHT5fy6dDYbtYWlyOTVGcPjaQo+kbdzRCJ5/+lQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139351; c=relaxed/simple;
	bh=ZAPX1A5uF07FWDJ71kgDAY+Py3xSgOeUtsvJHz/T2rQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B5n4i+8aBUMdex4m8J077rAqR6npjP0CRp9iaVKLlFnkKxthfo5KUHhXSbUJOx5US7rpFOGjP28biEb4hdKBZtOGxP/LUmHsE4QpVi97y+Tvz2PO5t0DTD0RNOzAkffZI4xw2Rq3nxYQdZEoyFlvZD5NEb3Dn4p4zaOaTpqroyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=fOFfQ5ob; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="fOFfQ5ob"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59E2B433E7;
	Tue,  3 Feb 2026 17:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1770139341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sI/ElATMqLLv5oUoPzudGjd5pSCEAke3bLFi2fvuW7A=;
	b=fOFfQ5obNfvHD63SQc6sOCVdA4nHUVfjFQSBbXkHr9GnAl+wpdunCP3x81uNZxjuNCeeGc
	6JVimNKsYrgud3issQzHzJKii72NIhkj3tvi/Ibcn9hJ/rWp0snUUXzgV+eSIJjAm1r1Jj
	pq05ugNOfbkVzwl9nIolOWwJbwCb8WZTtRGZjbUT7IcU5MPIRwRXpBRpCfxB0pa7DeGDoN
	UZhti0kx3vj+ru9WcDWzNCcUDUrj7D9MSYUnW9UtkNn/I5dQCaNRw9pmQ8nWiGK+wZdOA4
	qzedUFQXLrsO8OCMNjNeU0IpEIkoCkMoiAJS8loNl96r0Ew+DMHxezZzRZY90w==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.18 1/3] arm64: irq_pipeline: Fix mapping of
 SGI/LPI IPIs
In-Reply-To: <513ae7f9858f1bc553be3c6fcbbcabf1c89d6b25.camel@siemens.com>
	(Florian Bezdeka's message of "Tue, 03 Feb 2026 16:25:12 +0100")
References: <20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com>
	<20260201-wip-flo-fixes-for-6-18-v1-1-91ea07c7eb7e@siemens.com>
	<87o6m6vutd.fsf@xenomai.org>
	<513ae7f9858f1bc553be3c6fcbbcabf1c89d6b25.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 03 Feb 2026 18:22:16 +0100
Message-ID: <87qzr1ivxz.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepheelgfdvueegfeefgfejpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-State: clean
X-GND-Score: -100

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Tue, 2026-02-03 at 14:08 +0100, Philippe Gerum wrote:
>> -static inline void map_oob_ipis(int cpu)
>> +static inline void map_oob_ipis(int cpu, int offset)
>>  {
>>  	int ipi;
>>  
>>  	for (ipi = OOB_IPI_OFFSET; ipi < OOB_NR_IPI + OOB_IPI_OFFSET; ipi++)
>> -		get_ipi_desc(cpu, ipi) = irq_to_desc(ipi_irq_base + ipi);
>> +		get_ipi_desc(cpu, ipi) = irq_to_desc(ipi_irq_base + cpu * offset + ipi);
>>  }
>
> I'm still quite sure that the loop is wrong and should be 
>
> +static inline void map_oob_ipis(int cpu, int offset)
>  {
>         int ipi;
>  
> -       for (ipi = OOB_IPI_OFFSET; ipi < OOB_NR_IPI + OOB_IPI_OFFSET; ipi++)
> -               get_ipi_desc(cpu, ipi) = irq_to_desc(ipi_irq_base + ipi);
> +       offset = ipi_irq_base + (cpu * offset);
> +
> +       for (ipi = OOB_IPI_OFFSET; ipi < nr_ipi; ipi++)
> +               get_ipi_desc(cpu, ipi) = irq_to_desc(offset + ipi);
>  }
>

For ipi=SGI-0-7, the upstream implementation of ipi_setup_lpi() does:

                irq = ipi_irq_base + (cpu * nr_ipi) + ipi;
		get_ipi_desc(cpu, ipi) = irq_to_desc(irq);

In pipelined mode, we need to do that for ipi=SGI0 for in-band IPIs,
then for ipi=SGI1-3 for oob ones (see below). All members of
ipi_msg_type become _logical_ IPIs multiplexed over SGI0. That is the
whole point of your fix regarding CPU_BACKTRACE and KGDB_ROUNDUP.


> instead. (Note OOB_NR_IPI + OOB_IPI_OFFSET vs. nr_ipi)

The code above would map the original IPI range from SGI0-7, which we
don't have to in pipelined mode, we only use SGI0-3 here.

>
> Example:
>
> static void arm64_send_ipi(const cpumask_t *mask, unsigned int nr)
> {
> 	unsigned int cpu;
>
> 	if (!percpu_ipi_descs)
> 		__ipi_send_mask(get_ipi_desc(0, nr), mask);
>
> How should that work for IPI_IRQ_WORK? IPI_IRQ_WORK is located behind
> the IPIs used for OOB and get_ipi_desc(0, IPI_IRQ_WORK) would return
> NULL as we skipped the mapping in map_oob_ipis().
>

Any IPI from IPI_RESCHEDULE to IPI_IRQ_WORK are multiplexed over SGI0 by
smp_cross_call(). IPI_CPU_BACKTRACE and IPI_KGDB_ROUNDUP should be as
well, but unfortunately bypassed that routine to call into
arm64_send_ipi() directly, which is invalid. So, if all call sites which
want to send an in-band IPI do this remapping so that arm64_send_ipi()
is always called with ipi=SGI0 for them, we are ok.

IOW, arm64_send_ipi() can only be called for SGI0-3, i.e. one in-band
channel over which all upstream IPIs are multiplexed, three oob IPIs the
real-time core may use as it sees fit.

I should have an Hikey Lemaker somewhere in my drawers to be excavated
that I can reconnect to my lab. Is it the hardware which shows the issue
in lpi mode, or is it a 960?

-- 
Philippe.
