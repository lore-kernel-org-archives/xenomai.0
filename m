Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492091;
	b=vh7lcA0ugFAyGzKoVakr3bgWYS8Kt/QGxbTh0M9bk+8B6QUmyEBOR7TKUrTczn31QR8C
	 w47PLXue27rKpubCI09TRGU+VxPsb4BK4f0eOMjyzgalelI5K9ufBE9BXXutwpSGE+0zR
	 K97Wp8AUyRKAaxNU/dtZPrhRJklb+mwPLAP1On95ML3sO1XUyAdoFDy/GX6rTNTq1XwKr
	 AESmQl0o9vxyUAlUYbzS1ntzWmmlOh1pPl+7Y49pUhoCrmFGQcapyql0dVKPF+krhtS7G
	 pHCDjTyBmM+KNtvXP6nLdw+TEY90JB922sNprdRISFsJdW9JA3puTGFxPFmKFgmCVMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492091;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=zezkiVU52Pr57ApVDQBDQZClrRFIuB0dwCF6619giJ0=;
	b=TVlGF9rdJtKmDGRX3Dp1rkJvoDNa9TZ6jfYz1wPHFuHdBSNPfCMdIRdS88vlAAaMsyW/
	 FBU8e9WX6nByK0/NO+JZzsW+xnph2lwwNgOhKR0voJWjKq1JAdab1W0gnoSbC4gv8CLaP
	 j2IzUobHodiSJub2+vFHmrRyEBMNwYZDPrzjevAyePByls7oazjwYTZ5X9q31WU/avgnZ
	 c7ggv905DG9kJhdES/kVykt3Lm6RcBZNOYJwhUZLRlcviksGPeBJfT/GGJ6AhohNZ7qUe
	 vDwKUSdQn4zFGqpe0tH3IK18mSg8H/F4QRKWdMSs2cuxGsQJNSDcJuxEPhTlIC2mm5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=mW1kbTyN;
	arc=none smtp.remote-ip=217.70.183.193
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77601606A8AF
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 14:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77601606A8AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=mW1kbTyN
Received: by mail.gandi.net (Postfix) with ESMTPSA id 31F073EE24;
	Thu, 12 Nov 2026 14:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794492083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zezkiVU52Pr57ApVDQBDQZClrRFIuB0dwCF6619giJ0=;
	b=mW1kbTyN4C/19YPIk4ExL9D4sTnjX+2AMscHzt4c+eYiJIws8iq6E5bR6SICnjs4bZuW/h
	uZ0C0pdq5f6kTceveG1kBWqTY0KjUf2cMj5J6kAmns4HkBL2rXPmWa/U75FSZxfldfPYoH
	fC3YDic8qTAuazlK35B5VIHIRss1PUwRB3AGNm3g6lrsYCIAL0q54R3vRn9XIS3Y+x8sp+
	I4VUcxfPNiDKgOs59AibHhZPJ60yTiw52/nWUBhufnYl8MZ7+14c909td8HST92TRe2yJm
	DG+sWDR5mSWrVZ0my4jiRfI93aFOjPBWwfpqOCR5bL7VilkUFfqG1XWFrecQIA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Florian Bezdeka
 <florian.bezdeka@siemens.com>
Subject: Re: [dovetail][PATCH] x86: dovetail: Drop bogus
 local_irq_disable_full from __bad_area_nosemaphore
In-Reply-To: <174b3fcf-32ff-4b80-a33e-1c87d0585159@siemens.com> (Jan Kiszka's
	message of "Thu, 12 Nov 2026 14:38:11 +0100")
References: <e6cbf1cd-dbf7-44f9-8956-95d010fff9a0@siemens.com>
	<87v76219j8.fsf@xenomai.org>
	<174b3fcf-32ff-4b80-a33e-1c87d0585159@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 12 Nov 2026 15:01:22 +0100
Message-ID: <8733t6174d.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTFhxyDsqN9fMZ7M7bmSGJIzSLFNyiFb77TynBxw5fZm/eZzUa9V73OIvgb4XSlzGHFb/kOrqcaspbX13ifmWG1oggRe3Qst4oxU+bmCiTi0ExgskoXjmVZa2UOKaMOvlXBATu56upV/nk7/mnTvwIBird4pM/QFH70VBUoCulLD1Grq2umDHeW1XDag59Mlw7x6dviaB6CKU3pbiwvm8vr44rEcM0sshzJkIhYHOo7a1wUnj6IgPHsb5VNX7ijU3oCYDa/CAZxBktqHjTWbcDSP70CofzUGr11yPthnX4rZnRugkt9OVxF9njI5dHHKha8GQJe7Ll48Rw8SxBRSPxmkbAwJ00xysyUcvbYtFUGa54cwcSGWtAlLLV0ru3XqjIJPNibJj8+002n896ZWaR8Gg/kgh31swO0yTPuIvrRbHWa0dxM53gsB3n2Tj6jx0MQnwCFZk/C6ycgmjXl/qEpV8sGqsGBFPmNGGtZj2CgSPZdt/f1gTiHhDoR3f1aiEYTN9+j/3xO/TWPntdsA8G4wSYze2bHZo5VPOKl6SZNi/Wuuc7S3mEzF9DDdWcAAlVYuO/1GwJxH5PN+1T4iYHWu44OGnmLGoNIIJjLOazY/+950n9qTO9/Wavs+cBaQy9QoOPDLRUe0k6ho6ZOdMx+7D0IHWSZ9CliSyVjURuVDRA
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 12.11.26 14:09, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> There is no technical reason to disable IRQs here again, neither when
>>> the IRQ pipeline is enable nor when it is off, which this change also
>>> causes. We are never passing this point from OOB because of the
>>> !running_inband check and jump earlier in function. The inband case is
>>> identical to the !IRQ_PIPELINE case, and that one does not need any
>>> additional IRQ disabling as well (upstream code path).
>>>
>>> The addition was most likely a mismerged during the forward-port from
>>> 6.18 to 6.19. Remove it.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  arch/x86/mm/fault.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>>> index e41ed2092730c..e9a08a5d26e60 100644
>>> --- a/arch/x86/mm/fault.c
>>> +++ b/arch/x86/mm/fault.c
>>> @@ -886,8 +886,6 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
>>>  		force_sig_pkuerr((void __user *)address, pkey);
>>>  	else
>>>  		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
>>> -
>>> -	local_irq_disable_full();
>>>  out:
>>>  	oob_trap_unwind(X86_TRAP_PF, regs);
>>>  }
>> 
>> When removing such code, replacing it by an assertion like
>> WARN_ON_ONCE(irqs_pipelined() && !irqs_disabled()) would catch wrong
>> moves.
>> 
>
> IRQs are enabled at the point where local_irq_disable_full was located
> (-> cond_reenable_irqs_user / local_irq_enable), so this warning would
> always trigger.
>

See my previous answer.

-- 
Philippe.
