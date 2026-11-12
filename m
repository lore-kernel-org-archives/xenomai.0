Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474215;
	b=aMoD/eZpQrRdzpt/xN1K6fyhyJCC3WApW/6L+w1EgE770a4no+vJo/EeUwyFfy2qLDkg
	 Ge2oYgeMvgvNIk6vhNCNULKVxJKOOBHNS/kj9RDqrVQks0PixmPKm1HNGV9tM0KvC1i/a
	 fmN+xTAtJach/VfQiznBylMNPgW/kZWAWCNMorjSgbhXfzDNaEjrlWDijebrOtMx6l92w
	 dLx2okJWLq9U4D6JI7J+fT9mXNOgdjvMwAR7cpmYxaOzdPngBJATrDVaL1FD6OsBQlP+W
	 mK9XTJK2kezjuXr9fnwyNEoGEQf9RzmM+M+lB+WQNsbb//oG6ovHA7ywi0NmpiX84sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474215;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-GND-Sasl:X-GND-State:X-GND-Score:
	 X-GND-Cause;
	bh=J1/kCh123hm6bq7orf5ksifVUVXRYwDVYwhvXeyuu7o=;
	b=wJn4CAEkRiKybeT5Bf1xo67T5r98wwg8P4ruvBsxiWrqC7wt0W59uPKNDJK9HLf6y9ym
	 hPI4RONpy70YRYk1VbYYgcKPfdD5HneUeBN4APA9ANhrcB2oldg+HbMU4tEdJUiqle/G+
	 DvcLFhcWv0WaBhw5w+v+W3Y5fJm/bpxxs1WgBivFmz9zpvplZ4pvJ3liTXSAzASwkAHtm
	 FEWTDlj1GfyaHYnNIht0xKUiXY3lDP/yoCkOZaI/FMbY1vd91QsRMROd53E9beu9dmPrF
	 7dPJegSBLuDviu8SEPtkOTYzDU/3+NkghuLxtI+l2ygF1hsUK7yHrrUnMjWLyRzNX/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=KJhgztqV;
	arc=none smtp.remote-ip=217.70.183.197
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6D7606A8A4
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 09:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA6D7606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=KJhgztqV
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4734F3F4AF;
	Thu, 12 Nov 2026 09:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794474205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J1/kCh123hm6bq7orf5ksifVUVXRYwDVYwhvXeyuu7o=;
	b=KJhgztqVAHWpmOVDLg/HP2zlKVZdtxt5cENBzFKxgV86ex1oqBTZUu2VooCDeokjoZr6D0
	7pWdLK6tO84Wim/ZeQg2kTAA3QOK0pZZMt1nhFs3tkFjgpu2WlN0oF3cljB3eiKcL2N2dx
	8b28d06llGc3DhgHBCp4Sb1ZBn4yz7tFJmy/FkG+1c/dIOR1036gGrrbi1sNksItu+IJ50
	rxMauUadgYHZT9UCBBgJUA+3EUBDtwo3z7ezFvUA/JE6HqVee8KHxGrNkaVI5UimuCHvU0
	YoUmqXtCU5RaXb08G5X3LfiagmivhvMR3jTJonnZdju8qC8g0pqbknlNOHloOQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  Xenomai
 <xenomai@lists.linux.dev>
Subject: Re: local_irq_disable_full() in x86's __bad_area_nosemaphore
In-Reply-To: <21a5d7a6-876e-4dc1-a660-bae4f75d3217@siemens.com> (Jan Kiszka's
	message of "Thu, 12 Nov 2026 07:58:05 +0100")
References: <e5aee699-ea3e-4c02-861f-12f165f2d381@siemens.com>
	<968e9ff2fb76bc031622f3857a7e1a7373d8d695.camel@siemens.com>
	<21a5d7a6-876e-4dc1-a660-bae4f75d3217@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 12 Nov 2026 10:03:24 +0100
Message-ID: <87tslm2zhf.fsf@xenomai.org>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFR+J/4BG9h4TPD+Gr11PAIEcUqGdepnRZeo+fsY9JfiM2v5Fe21NUKIS81LFcKauXIgU2nXFvLx/ZEtv2PIJKIWoH8v+OCkh+3JgFjKe8zA/aCYhZmGTXA4J7nzofyHQyS2ZfbnsugaH3qYI2oVc+fg1tczUDIO3ZevsBXE69MIQ3TQMcP1xuORdW+YQfHiFoXRsEfz5v/xfACnrWdVwikT66K9/+ag9Fkq3DHUUmaPCwka106W/sKM0oKx6i0Sh9glP/K6EdZVxBWytFWjtTUXWzQwgpVA8pVf1B9+Pz0v1uglQSc43J62MIz1aMj2nVdn+j4dSVylA49dE9YCXxmNv8EDLo3UjjFvaRcnHvHrUN2lqKczU+C/z7qXTeTqn2W0vzqOjakaaFtunXSvFYCb2Pbn3amyiBYak1G0Kuybw/aeKYvutJpo8Pb9/prItjFL7z+wVDrC0SDdiwefvKifCa6ThqgrQYKbkrSVhnJt4fTwpZrHq+oyJChAz78rkwmH9Z7Tscw8KRZ4BZF4dWFCFNgoa4iZLWW7bvOvR/cEBPVqxA8mtnacx9D2MrICq8kdLuDwwxUydIxcOCLr3vuhJjthHKaLegqQPSkKS25oh3YAa9GppWv0NgxpeF4+/32wCN5d1KBPcytkNKuu5MBRrkdbapssoYxXpZ2+ZIbWw

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 11.11.26 23:57, Florian Bezdeka wrote:
>> On Wed, 2026-11-11 at 13:58 +0100, Jan Kiszka wrote:
>>> Hi Philippe, hi Florian,
>>>
>>> I start to love pattern-matching machines:
>>>
>>> Since 6.19-dovetail, commit 6af591980d1750b29474f001902c7dc58c3f1ba2, w=
e have
>>>
>>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>>> index b83a06739b511..024a67bd2de6a 100644
>>> --- a/arch/x86/mm/fault.c
>>> +++ b/arch/x86/mm/fault.c
>>> @@ -821,6 +821,8 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsign=
ed long error_code,
>>> =C2=A0		force_sig_pkuerr((void __user *)address, pkey);
>>> =C2=A0	else
>>> =C2=A0		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
>>> +
>>> +	local_irq_disable_full();
>>> =C2=A0}
>>> =C2=A0
>>> =C2=A0static noinline void
>>>
>>> The final code is
>>>
>>> ...
>>> 	oob_trap_notify(X86_TRAP_PF, regs);
>>> 	if (!running_inband())
>>> 		goto out;
>>>
>>> 	if (likely(show_unhandled_signals))
>>> 		show_signal_msg(regs, error_code, address, tsk);
>>>
>>> 	set_signal_archinfo(address, error_code);
>>>
>>> 	if (si_code =3D=3D SEGV_PKUERR)
>>> 		force_sig_pkuerr((void __user *)address, pkey);
>>> 	else
>>> 		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
>>>
>>> 	local_irq_disable_full();
>>> out:
>>> 	oob_trap_unwind(X86_TRAP_PF, regs);
>>> }
>>>
>>> Do you remember why? As this was folded into the forward port, this=20
>>> delta never made it into anything older. If it is valid, we would need=
=20
>>> some reasoning. But this rather looks like a mismerge to me.
>>=20
>> This one needs some more cycles here. It might already start with the
>> call to cond_reenable_irqs_user() earlier in this function which is
>> unconditionally enabling hard IRQs, even if the oob stage might be
>> stalled. The possible in-band migration happens later.
>>=20
>> If we leave with hard IRQs enabled, we would corrupt the oob IRQ state.
>> I need to check the calling context in more detail. Maybe this cannot
>> happen, maybe it can...
>>=20
>
> The oracle says:
>
> "No. With a working companion core, the oob stage can't be stalled when
> this code runs, and the handler never returns with hard IRQs still enable=
d."
>
> The point is that the cond_reenable_irqs_user is only run for faults
> triggered over userspace, and there we should never have OOB stalled /
> hard IRQs off. Kernel faults are filtered early in the function
> ("if (!user_mode(regs))").
>
>> Touching the inband IRQ mask (one part of disable_full()) seems strange
>> to me - at this stage - especially as Linux does not do any kind of
>> "restore" here.
>
> This is why I suspect a mismerge during forward porting.
>

Although this might be the case due to the significant code churn in
this area which is even worse on arm, on x86 and arm64 for that matter,
the whole logic is driven by the generic irqentry/irqexit scheme
(irq-entry-common.h). In short, the exit path expects the in-band stage
to be stalled if running in-band, hard irqs off. There are lockdep
assertions to enforce this, and specific provisions to unstall the
in-band stage as appropriate right before unwinding to the asm entry
point, e.g.  exit_to_user_mode().

--=20
Philippe.
