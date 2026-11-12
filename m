Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490143;
	b=ZMJvzwWTgyC+HqbXyYUB/XSNBXOQLl6yENDfuTilqPwEn9xx74/88KAgG7S5cesqJE2V
	 fazcuQK6jfm1r9P7S/+WSPF1HIFQU0Odo+2SxMrNigre1rW1Cj0NRDbpYyxEyz4Q4kaEH
	 hyoxGWTh8kifFIpsRuuTiflRb/jOUowjcuMtSHwG+kb6v5cclY9M0+NQpbkUQ0wwK0tUr
	 B4m8uSomwU+5RWEL3yHTwN+pG1DNPdcPKHUWwMvkaUpnEt089Zube8swXdRvfc88OA7n9
	 u++IO0XhtweVweQLFm6E11/CsivQrqOE/1wOUNSfMMbXrRDNFqwdNpY9/65PVTvXM6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490143;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-GND-Sasl:X-GND-Score:X-GND-Cause:
	 X-GND-State;
	bh=ER55bOVXGzzER2iUHIaE6l33Dx8Ro0gTf6QysGWQjyg=;
	b=JgSlY72DoF4nlW76257xTlPRTdUIkiO987nID4KFDNiAqOPVHHYLY8woJ75b0Yu0RIQ2
	 mTPmrpS6VEzflK9fgg0uW6HfqlGfS7zM97xrX7dyCfBVfwIw1AK5x3eYw6kiroEL2s+oD
	 xX3AvQWO2MCRpdCRc8PRN/pncTNxqwUk6syQIqfA57B27RL8Hbx94KoT/cmGCFbnHw25R
	 s0ZYrZ/uoYMcj8abp1gjxDe9vZTRtazPN6V8KoXPBoB+e+bE4sy4UPwT26llHdjAYGvhh
	 w53ddkn/2VTIbkOGOT8oIeJutxlFsWEEqAcrlt2n/nPmS9Yq1WUoGfY8aUWO6BMy4Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=OCoFkY30;
	arc=none smtp.remote-ip=217.70.183.198
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECA9606A33B
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 13:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ECA9606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=OCoFkY30
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1AF153ED48;
	Thu, 12 Nov 2026 13:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794490135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ER55bOVXGzzER2iUHIaE6l33Dx8Ro0gTf6QysGWQjyg=;
	b=OCoFkY30ThPMVOyqYvfa5J7cY0G5aRqZq4S7ZrNVQp2Drp2n8NcrnZBVr5fASj4sTteAnE
	pvc4615lCueeXfHkp3JJkZsaQXj+4ZdfwoN1sjupwXDoCtfuVPA8KHN67lPK1MPqstMCJp
	OPVAhCz6EmCi0MZmYq0gScqW3JXcbtCPQGMtdHAjAINlLereX/3YGsbAbDV/eMYzvTetzN
	CNVrc0cXidkuiKSVgxkrNwxkJGARyrdeZ+xmQIf5d5F2s4xiAJG/9HcUpKbCRYxU/UbsU2
	6VUqNgUd11pfJ01TFVGxTTIzEoXAcFMxq9z+8aU7+U3LfWQQpbW7pXEPuClM5g==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  Xenomai
 <xenomai@lists.linux.dev>
Subject: Re: local_irq_disable_full() in x86's __bad_area_nosemaphore
In-Reply-To: <24d60a71-2f4f-4e6f-9099-79ee7906bcf1@siemens.com> (Jan Kiszka's
	message of "Thu, 12 Nov 2026 10:40:06 +0100")
References: <e5aee699-ea3e-4c02-861f-12f165f2d381@siemens.com>
	<968e9ff2fb76bc031622f3857a7e1a7373d8d695.camel@siemens.com>
	<21a5d7a6-876e-4dc1-a660-bae4f75d3217@siemens.com>
	<87tslm2zhf.fsf@xenomai.org>
	<24d60a71-2f4f-4e6f-9099-79ee7906bcf1@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 12 Nov 2026 14:28:54 +0100
Message-ID: <87mrre18mh.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTFlj1DA4vr/7mt6uJBR+UIAJTzwl6TUhXQe1JrHUDfUaeHopbTJB0cV5zyuKevrjiFXIyufo+2kahfOEbUdvu2WxKy4cfDD4okP4Xb0R3t2MO06CLD0d6V6//YoFQHrWbrfjDI2VfbjyII8nf8Zth1RZ4kRXzICVWrDgDou9Jx7Z7+sqAnB0bvM8ZVD2eFlfZ36A76t8q3sX0XBTGFuqcaRNl2aUYGOQSE3g8Dp0CgRAdUi6d0CUlifRnhZ/4M1cqW4FYpVgg+5iIROP+C9UnjYbC5SFyoDRGP1Lc1cLn6sAZETvdc+6U35EvVUNyWJytTgOwT1TRjVl769e8mIDOvmIwUzFBlQ5oCafWGseFgdl/TFAfyHcNMwI8TY/QMVoI/ZaIrskKqz+jdAAp6WAKMNzVOH3t/a7sl7mkD8mT9oaP47Pb2zDDWbssSmcYm9yFtiY6Dbcn7kOKuj+vdtcGs3lluydp5IGD/UYL+OEuURm4hfX2z9JIMvbOy38Uk/G5eTPqZWWPiS91tCD6+5pQdmQlWmLuR2+9+C7opvd/1+gXstJhrumNW+HSf4b7MSXKHBKff+ZmKKbOWldeOauRgewot59+8Yw6SK3rZUTZ4tb10BSO4bD7CAeWfFkPwlJelFntvx+JSjLwD51Sm6zktoow0GTbOkMiIu2b1RCPHmnQ
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 12.11.26 10:03, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>=20
>>> On 11.11.26 23:57, Florian Bezdeka wrote:
>>>> On Wed, 2026-11-11 at 13:58 +0100, Jan Kiszka wrote:
>>>>> Hi Philippe, hi Florian,
>>>>>
>>>>> I start to love pattern-matching machines:
>>>>>
>>>>> Since 6.19-dovetail, commit 6af591980d1750b29474f001902c7dc58c3f1ba2,=
 we have
>>>>>
>>>>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>>>>> index b83a06739b511..024a67bd2de6a 100644
>>>>> --- a/arch/x86/mm/fault.c
>>>>> +++ b/arch/x86/mm/fault.c
>>>>> @@ -821,6 +821,8 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsi=
gned long error_code,
>>>>> =C2=A0		force_sig_pkuerr((void __user *)address, pkey);
>>>>> =C2=A0	else
>>>>> =C2=A0		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
>>>>> +
>>>>> +	local_irq_disable_full();
>>>>> =C2=A0}
>>>>> =C2=A0
>>>>> =C2=A0static noinline void
>>>>>
>>>>> The final code is
>>>>>
>>>>> ...
>>>>> 	oob_trap_notify(X86_TRAP_PF, regs);
>>>>> 	if (!running_inband())
>>>>> 		goto out;
>>>>>
>>>>> 	if (likely(show_unhandled_signals))
>>>>> 		show_signal_msg(regs, error_code, address, tsk);
>>>>>
>>>>> 	set_signal_archinfo(address, error_code);
>>>>>
>>>>> 	if (si_code =3D=3D SEGV_PKUERR)
>>>>> 		force_sig_pkuerr((void __user *)address, pkey);
>>>>> 	else
>>>>> 		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
>>>>>
>>>>> 	local_irq_disable_full();
>>>>> out:
>>>>> 	oob_trap_unwind(X86_TRAP_PF, regs);
>>>>> }
>>>>>
>>>>> Do you remember why? As this was folded into the forward port, this=20
>>>>> delta never made it into anything older. If it is valid, we would nee=
d=20
>>>>> some reasoning. But this rather looks like a mismerge to me.
>>>>
>>>> This one needs some more cycles here. It might already start with the
>>>> call to cond_reenable_irqs_user() earlier in this function which is
>>>> unconditionally enabling hard IRQs, even if the oob stage might be
>>>> stalled. The possible in-band migration happens later.
>>>>
>>>> If we leave with hard IRQs enabled, we would corrupt the oob IRQ state.
>>>> I need to check the calling context in more detail. Maybe this cannot
>>>> happen, maybe it can...
>>>>
>>>
>>> The oracle says:
>>>
>>> "No. With a working companion core, the oob stage can't be stalled when
>>> this code runs, and the handler never returns with hard IRQs still enab=
led."
>>>
>>> The point is that the cond_reenable_irqs_user is only run for faults
>>> triggered over userspace, and there we should never have OOB stalled /
>>> hard IRQs off. Kernel faults are filtered early in the function
>>> ("if (!user_mode(regs))").
>>>
>>>> Touching the inband IRQ mask (one part of disable_full()) seems strange
>>>> to me - at this stage - especially as Linux does not do any kind of
>>>> "restore" here.
>>>
>>> This is why I suspect a mismerge during forward porting.
>>>
>>=20
>> Although this might be the case due to the significant code churn in
>> this area which is even worse on arm, on x86 and arm64 for that matter,
>> the whole logic is driven by the generic irqentry/irqexit scheme
>> (irq-entry-common.h). In short, the exit path expects the in-band stage
>> to be stalled if running in-band, hard irqs off. There are lockdep
>> assertions to enforce this, and specific provisions to unstall the
>> in-band stage as appropriate right before unwinding to the asm entry
>> point, e.g.  exit_to_user_mode().
>>=20
>
> This does not explain what makes things different here, both with and
> also without IRQ_PIPELINE.
>

Affecting !IRQ_PIPELINE is obviously a bug.

> The more I look at it, the more that local_irq_disable_full() looks
> stray, at best.
>

So, I asked git-blame which told me that 6af591980d1750 introduced
it. As far as I can tell, this is neither a merge fallout nor stray
stuff, but rather a misinterpretation of the local_irq_enable()
statement which existed prior the introduction of
cond_reenable_irqs_user() at that time. This re-enabling upstream wants
was deemed to be persistent, and I made it temporary for the duration of
the call, which is wrong.

Although this change is going to be properly undone in the irqexit path
I mentioned earlier, it is useless. It should not break the logic
either, since anything we must do with the in-band stage unstalled is
already done passed that point. So I'm ok for dropping that line.

Meanwhile, the assertion I mentioned in my comment of the fixup becomes:

WARN_ON_ONCE(irqs_pipelined() && irqs_disabled())

--=20
Philippe.
