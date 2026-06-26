Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E95D3CC300
	for <xenomai@lists.linux.dev>; Fri, 26 Jun 2026 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782453092; cv=none; b=pqiLpPPKwFkAN5BzViRjj6JPeC/gK6QzINHrPZlF1xmFsKeeAuJSEd3utOyLL57Rcx4sTjxYA+NYMYKXSbl+9guA6ZxcbXDABIzk/8oWtBiadLj5ABMEnmVUPFLtMbFUVWZbCVVAmybkNTqGWIQcgEzWM7CFUntUpCc4RJeSshA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782453092; c=relaxed/simple;
	bh=GdBpiCaDMyrp4dSwF+wucTXnYBytrL98BTEXli3HIfk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jQYl7iU6vwihEasXaPSxoFitl14LvcktB9/kF0Uf/0Nh0RG0GMhzPKwGl7rPV2K4ON2Ne8qprMFapiaq5eFrQ1izejQZnfpcBleLhAZqnuwi5EdEAXXunkD6X1Klc1NIqmbkVomJlclF2q0JH4pWz9vf4jMwLNylfy60OoqbUuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=X+Aj/tkz; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="X+Aj/tkz"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BD823F6BB;
	Fri, 26 Jun 2026 05:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1782453080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0zxHwmRvKKU8QZQwRjuwcHtflD62gE/zRqjiOTZWGk=;
	b=X+Aj/tkzY+pOxOW3vzrnYVuiGOuq60DHC0zmP6+S40PT/Tkiw2sEti4oFIyEmCRm60T0Hp
	aNJRKE9NK6VPUVyMfAx8GzMGsPqpm5ex2s/Xzaj5d6smKH5J9IOWZs/nBAnaLg77x/8ahQ
	4NKrhJH0a57tHmEne8f+hHgjWzl8uFNgVlgqRFwzdHpD6Y5HQCimpabPqRAbH7K2ihLmvi
	KSNhvPIhmK280aetqp8NhKZjZwVXFtgyB9H6PhNeH0cssk3eGUZR1gPVrj3bJsRLmv+2zC
	CkFPsHeyKYoX0V1/IP+fpPpUHYR9iquBHyFDh1Dhse7UIiDXrCg60KqqJOz9iw==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>,  Tobias
 Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH Dovetail v3 3/6] arm: irq_pipeline: Fix
 dovetail_fault_{entry,exit} bypass in hw_breakpoint_pending
In-Reply-To: <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-3-230f03227abb@siemens.com>
	(Florian Bezdeka's message of "Mon, 22 Jun 2026 10:05:27 +0200")
References: <20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-0-230f03227abb@siemens.com>
	<20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-3-230f03227abb@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 26 Jun 2026 07:51:11 +0200
Message-ID: <87cxxdrgs0.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTFmUw46q1hSK+Bza6bj7ATcCvusDPINDku7v55ODxDHUoEScXhdh/9ESkfVo6cKkhGqo6CxZSOc6i/rSZsSpIMAAeGJ5Tf+kFK1B1UuHJlUoNRHrPvsaMv7giUXW4zaDOA/Sj+vvnOHAHVg0zWtsOFFAeh7xlHU8NlHqDoLaPc+5jD2d4ZSoRnr1nDEmX2QOSac7ujLhgMTgbjbqp/jkMfwKCNl5PDgfldPQhpY7XILA/Ali2kHxZzElFGEuxX9gGhvvfZBweedZHdQldKB8JBTiUK3/Vrv1lj5IWhaLncn1wRst3c8lPaBGVFlq+8nnU4XmBkTNOUF6hnbt4xQ2H7tf4BcuuwpxweiShDf+hdU0Q0hC+V/qk+B1pvfrTrEDhwVr90bjGg74rE6+AufngwUSvSuX+kJgzAhERZ5TT7/F7l9okFJ52Og3eV2kZyOK7hWiFueKLBsifEmzJQbni069S8OINo3rsJwZzjRxZWWzivIhGcz93qTOtKI3qU0XqEd+sl9QgqeYWRPbDVa9JlA389uS6Nx5j8kh7Q8ulUTkx57zvhx7w5e543YsjhPNmLR8daEXLCMhM1soFYRNEzOnglKt4DnedaSHLFsB1NxwIIf+eZegxuwnDr7EXamzPdnkiQsBc9cQCpggTLmws9ZyS7kcKxdQ3esGqKhOw4LjQ


Hi Florian,

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> HW breakpoint / watchpoint handling was bypassing the
> dovetail_fault_{entry,exit} machinery. As a result it could happen that
> the inband IRQ mask was touched from the OOB stage.
>
> There is one more problem in the HW bp/wp handling related to
> interrupts_enabled(). This one will be fixed in a separate patch.
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/arm/include/asm/dovetail.h         | 1 +
>  arch/arm/include/asm/trace/exceptions.h | 3 ++-
>  arch/arm/kernel/hw_breakpoint.c         | 6 ++++++
>  3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/dovetail.h b/arch/arm/include/asm/dovetail.h
> index 795a1fb903ec29f4c2fb7b25e70980796804acc0..eeb5d16ad032044a2587822f6b35074d664a9bbc 100644
> --- a/arch/arm/include/asm/dovetail.h
> +++ b/arch/arm/include/asm/dovetail.h
> @@ -16,6 +16,7 @@
>  #define ARM_TRAP_VFP		6	/* VFP floating point exception */
>  #define ARM_TRAP_UNDEFINSTR	7	/* Undefined instruction */
>  #define ARM_TRAP_ALIGNMENT	8	/* Unaligned access exception */
> +#define ARM_TRAP_HW_BREAK	9	/* HW break or watchpoint exception */
>

ARM_TRAP_HW_BREAK would not be caught by xnarch_fault_bp_p() and friends
without fixing them up. What is the expected upside of differentiating
ARM_TRAP_BREAK from ARM_TRAP_HW_BREAK?

-- 
Philippe.
