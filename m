Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D9C35BDBF
	for <xenomai@lists.linux.dev>; Tue,  3 Feb 2026 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140692; cv=none; b=sJ3tVu33s3G8XKpSAxrOF+DwZAP9G9R9c6RfxmoIb/lRyhjvc0m1yu87h2OB9n6dcN/C2JK1RBuAPGGBjGNLczjp2h2A4lX34B75rDJvcWb2kRBM77HCGOyETxGVPUO+hPrJweTfDODMW3CHUi0p3HOhTL2ba2yFQ/O/M+duVlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140692; c=relaxed/simple;
	bh=6utukDi1hGs81Ji2oetuMzW4M+mvA1jr6N1q7KDFg0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Av2tuEW6VjyA4uUxgLnMviYSCgnNoFR2Teh7nr8ecSyCbr7cl4ZUHHw9CHnkeWnKU42T9L41KhfYOFXvGHpbJy1jWO/+C/fyyd4U/DPFhzH/sK/kp6hip4+ROqNlt5ZH+yXnZ/vvEtN6R9R/s17Yuh4SjMOlE83HBrOOWlcZYOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Y9e3nY/i; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Y9e3nY/i"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9775F44300;
	Tue,  3 Feb 2026 17:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1770140689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tOy57v8chHbMRzjmY5SxamgV3zVSQTMgOlZh3tUi7Jg=;
	b=Y9e3nY/i7a3ifcMISGxjwuHSUMxflRkrUpPjMSTooL4RjwLaWxNH9GV4cuwxQv2ELotWVS
	rz/2FVYw9OFXIBZR4kQJsX19WBKAuZt+Aosv+aPJY7woSifwRFFJKNWSlVUxOMxqpaCldy
	llF8Aw79LvhjSsmHWGpuP7sSSjsjfQpJuiB3yrliccmiUXmttiCzsuX42ebPflfT/qcfEn
	h6P8UefqQLu54xB51RIyJC1TS84FRt2pDruQnvqJeT3ktDAkVFAlvb5dSr84rTVH+AzAtw
	pE8AYQ6qNSqIwMrnr7WohxSdez3md4mULPNaqJ0v0NM6Li2oUOYOQDfhmB0/KA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.18 1/3] arm64: irq_pipeline: Fix mapping of
 SGI/LPI IPIs
In-Reply-To: <87qzr1ivxz.fsf@xenomai.org> (Philippe Gerum's message of "Tue,
	03 Feb 2026 18:22:16 +0100")
References: <20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com>
	<20260201-wip-flo-fixes-for-6-18-v1-1-91ea07c7eb7e@siemens.com>
	<87o6m6vutd.fsf@xenomai.org>
	<513ae7f9858f1bc553be3c6fcbbcabf1c89d6b25.camel@siemens.com>
	<87qzr1ivxz.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 03 Feb 2026 18:44:48 +0100
Message-ID: <87ldh9iuwf.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepleejjeehhfeggeeftddtpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh

Philippe Gerum <rpm@xenomai.org> writes:

> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>
>> On Tue, 2026-02-03 at 14:08 +0100, Philippe Gerum wrote:
>>> -static inline void map_oob_ipis(int cpu)
>>> +static inline void map_oob_ipis(int cpu, int offset)
>>>  {
>>>  	int ipi;
>>>  
>>>  	for (ipi = OOB_IPI_OFFSET; ipi < OOB_NR_IPI + OOB_IPI_OFFSET; ipi++)
>>> -		get_ipi_desc(cpu, ipi) = irq_to_desc(ipi_irq_base + ipi);
>>> +		get_ipi_desc(cpu, ipi) = irq_to_desc(ipi_irq_base + cpu * offset + ipi);
>>>  }
>>
>> I'm still quite sure that the loop is wrong and should be 
>>
>> +static inline void map_oob_ipis(int cpu, int offset)
>>  {
>>         int ipi;
>>  
>> -       for (ipi = OOB_IPI_OFFSET; ipi < OOB_NR_IPI + OOB_IPI_OFFSET; ipi++)
>> -               get_ipi_desc(cpu, ipi) = irq_to_desc(ipi_irq_base + ipi);
>> +       offset = ipi_irq_base + (cpu * offset);
>> +
>> +       for (ipi = OOB_IPI_OFFSET; ipi < nr_ipi; ipi++)
>> +               get_ipi_desc(cpu, ipi) = irq_to_desc(offset + ipi);
>>  }
>>
>
> For ipi=SGI-0-7, the upstream implementation of ipi_setup_lpi() does:
>
>                 irq = ipi_irq_base + (cpu * nr_ipi) + ipi;
> 		get_ipi_desc(cpu, ipi) = irq_to_desc(irq);
>
> In pipelined mode, we need to do that for ipi=SGI0 for in-band IPIs,
> then for ipi=SGI1-3 for oob ones (see below). All members of
> ipi_msg_type become _logical_ IPIs multiplexed over SGI0. That is the
> whole point of your fix regarding CPU_BACKTRACE and KGDB_ROUNDUP.
>
>
>> instead. (Note OOB_NR_IPI + OOB_IPI_OFFSET vs. nr_ipi)
>
> The code above would map the original IPI range from SGI0-7, which we
> don't have to in pipelined mode, we only use SGI0-3 here.
>
>>
>> Example:
>>
>> static void arm64_send_ipi(const cpumask_t *mask, unsigned int nr)
>> {
>> 	unsigned int cpu;
>>
>> 	if (!percpu_ipi_descs)
>> 		__ipi_send_mask(get_ipi_desc(0, nr), mask);
>>
>> How should that work for IPI_IRQ_WORK? IPI_IRQ_WORK is located behind
>> the IPIs used for OOB and get_ipi_desc(0, IPI_IRQ_WORK) would return
>> NULL as we skipped the mapping in map_oob_ipis().
>>
>
> Any IPI from IPI_RESCHEDULE to IPI_IRQ_WORK are multiplexed over SGI0 by
> smp_cross_call(). IPI_CPU_BACKTRACE and IPI_KGDB_ROUNDUP should be as
> well, but unfortunately bypassed that routine to call into
> arm64_send_ipi() directly, which is invalid. So, if all call sites which
> want to send an in-band IPI do this remapping so that arm64_send_ipi()
> is always called with ipi=SGI0 for them, we are ok.
>
> IOW, arm64_send_ipi() can only be called for SGI0-3, i.e. one in-band
> channel over which all upstream IPIs are multiplexed, three oob IPIs the
> real-time core may use as it sees fit.
>
> I should have an Hikey Lemaker somewhere in my drawers to be excavated
> that I can reconnect to my lab. Is it the hardware which shows the issue
> in lpi mode, or is it a 960?

s/960/970/

-- 
Philippe.
