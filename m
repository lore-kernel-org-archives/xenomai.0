Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C35D42070
	for <xenomai@lists.linux.dev>; Tue, 18 Mar 2025 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306202; cv=none; b=JZXrZ/LOSi5qaX1Kf7k3ccPpcKyiXNJe8+lR5RLkNnoFbTnrvHsxkgjid/3jbqP+xCllA+NZtGVHXHdVGYSWUF5oh2zp4zhCDJDCpZKdr9piOJFZR/DulvilXlFHLV9uk5lGSb1zZOoNj0ZXYwgsj3hGSj1KSCn3lk6Eq3nOEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306202; c=relaxed/simple;
	bh=RHbmaP8OuoObDAVe8Lbl2mmZEvuRsOyhvJi+w/INV1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GX3OxAuKtjur6bY6bY6bgCqj9pOm+RmNj2yXo7kyhSyxE/VkEo65XqseRkM/au0dqDcQlmxajagVCUT2mIdeHb16NdeBEij30sumPZmOj9Y1gpL+KI366LDLeZ/e3LqDheLFHQqxVoE2dX6h/6Ub0TupoRhwtpaoJtw7LlUJpJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ZUQ1IOw3; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ZUQ1IOw3"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76D9E443EF;
	Tue, 18 Mar 2025 13:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1742306196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0eoDYTh28DYb2cQrEXAVEn27lZ+DhP6UVip2rexDiOc=;
	b=ZUQ1IOw3ghkVvr2JQwNCwhl5lmogC+nCPRv8Rg/G3qvjXVAWP+Lo1Lvj//eIHc10+PtWGb
	m0sRLRlFLz5CUpWpCxK9cKRyy/i812amdu4ldKYsPPFRMoq73FANlfzkP0aU9tdJZA167o
	HxY+GNVOngCKsVtdiw3s1628AUSFme5qqRBSciFbBpSCWedScBL8/eaEX7SDzYROBDB4Hx
	dR8eCBY8knBLHSYrHLRcHTJ0twLJj3ZF7lV/AN6hHDqXaqoxAjru4BZXmkom1CdpSBKeY+
	VJoi/cjU6BRb71keQ33dpZJZgF0rcBhUhqYB94ztAj1O0a/TDHXrRs1v/nAwhw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  Xenomai
 <xenomai@lists.linux.dev>
Subject: Re: [PATCH v2] x86: dovetail: Harden __send_ipi_mask[_ex] for KVM
 and Hyper-V guests
In-Reply-To: <cb853716-802f-483b-a586-dad91e7f37ac@siemens.com> (Jan Kiszka's
	message of "Tue, 18 Mar 2025 14:47:10 +0100")
References: <5235edf1-6689-4417-9754-52584ecdb6b8@siemens.com>
	<7577efa5673691900d6b826024c30c6e74496f78.camel@siemens.com>
	<cb853716-802f-483b-a586-dad91e7f37ac@siemens.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 18 Mar 2025 14:56:30 +0100
Message-ID: <87r02uo31t.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedviedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeeugedtgfduffduleejteeujeejieelteelveehfeektdefvdduleeugefggffhgfenucffohhmrghinhepohhpvghnshhushgvrdhorhhgnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 27.02.25 15:25, Florian Bezdeka wrote:
>> On Mon, 2025-02-24 at 22:07 +0100, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> These functions are called in case paravirtual IPIs are used.
>>> Just like for hard submission handlers, we need to harden the path to
>>> avoid splashes like these:
>>>
>>>  IRQ pipeline: some code running in oob context 'Xenomai'
>>>                called an in-band only routine
>>>  CPU: 0 PID: 410 Comm: (udev-worker) Not tainted 5.10.229-cip54+ #265
>>>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
>>>  IRQ stage: Xenomai
>>>  Call Trace:
>>>   dump_stack+0x84/0x9c
>>>   inband_irq_save+0xa/0x30
>>>   __send_ipi_mask+0x81/0x260
>>>   ? preempt_count_sub+0x96/0xe0
>>>   ? _raw_spin_unlock_irq+0x33/0x50
>>>   ? xnsched_pick_next+0xe0/0xe0
>>>   ? ___xnsched_run+0x491/0x5b0
>>>   ? ktime_get_mono_fast_ns+0x50/0xb0
>>>   ___xnsched_run+0x491/0x5b0
>>>   run_oob_call+0x97/0x170
>>>   xnthread_start+0x23f/0x330
>>>   ? rt_stack_deliver+0x340/0x340 [rtnet]
>>>   rtdm_task_init.part.14+0x7e/0xc0
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  arch/x86/hyperv/hv_apic.c | 4 ++--
>>>  arch/x86/kernel/kvm.c     | 4 ++--
>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
>>> index 0569f579338b5..e7b2a57c720ed 100644
>>> --- a/arch/x86/hyperv/hv_apic.c
>>> +++ b/arch/x86/hyperv/hv_apic.c
>>> @@ -115,7 +115,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
>>>  	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
>>>  		return false;
>>>  
>>> -	local_irq_save(flags);
>>> +	flags = hard_local_irq_save();
>>>  	ipi_arg = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>>  
>>>  	if (unlikely(!ipi_arg))
>>> @@ -150,7 +150,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
>>>  				     ipi_arg, NULL);
>>>  
>>>  ipi_mask_ex_done:
>>> -	local_irq_restore(flags);
>>> +	hard_local_irq_restore(flags);
>>>  	return hv_result_success(status);
>>>  }
>>>  
>>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>>> index 5df1061fc6ee1..b183caf41aa44 100644
>>> --- a/arch/x86/kernel/kvm.c
>>> +++ b/arch/x86/kernel/kvm.c
>>> @@ -525,7 +525,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
>>>  	if (cpumask_empty(mask))
>>>  		return;
>>>  
>>> -	local_irq_save(flags);
>>> +	flags = hard_local_irq_save();
>>>  
>>>  	switch (vector) {
>>>  	default:
>>> @@ -563,7 +563,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
>>>  			  ret);
>>>  	}
>>>  
>>> -	local_irq_restore(flags);
>>> +	hard_local_irq_restore(flags);
>>>  }
>>>  
>>>  static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
>>> -- 
>>> 2.43.0
>> 
>> Applied to wip/v6.14-dovetail-rebase already.
>> 
>> 
>
> Seems we are still missing this in stable (6.12, 6.1 - and therefore
> also my 5.15, 5.10 right now).

This patch is present in 6.12 AFAICS, missing from 6.1 because of a
merge conflict. I'll pick it after proper fix up asap.

-- 
Philippe.
