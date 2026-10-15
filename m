Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346A450B426
	for <xenomai@lists.linux.dev>; Thu, 15 Oct 2026 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059599; cv=none; b=RbJabWTLWXUuLgglfZxCc3LBZ9+XXe/3QgfpObSQ5W+mY1KyTNDpvzg+UDTVmaz7kZ0T+v4qiJvGpKp4DuMa5gHkhAhU7NOlr8jCsWgvSZ3S5NsrZvgpmI4vFU9j2Zn5IZpY/taVH7+WfnGO80hBIxDnhPwYdF4fI0Q+Q6lsBSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059599; c=relaxed/simple;
	bh=ul0nUPuQZROn9dXisj7IddhY0c/uG01RZSiYGaoeKzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QcZWYCCTt7S2fagbIMkfuQRQ1rKsDrdHYmBPp/MTLQhalWaR/9YNJO3u4Gtc8YNNGbkwe/VJiRc7QnVBMdUg5/BsUmA0fiL0smxSZBOz3kr0BCci+l401Psk/DZiDUFLs06Zz2TiCreu1TVxAG4svqRebghQiLgGDSRlr5uhxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=oVrgLAuv; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="oVrgLAuv"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 409C73E95C;
	Thu, 15 Oct 2026 10:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1792059588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgjPbUOAbadGIdvA/bhWgk66CydSGDLkIIO/ov8Kyrs=;
	b=oVrgLAuvJqFb1welCsdNc8h5hDGxY67HYXWsKZo8ywCUHu4Ty4mEGmzMojn2q93j97BqEn
	PeVP+GuE0Rw5C+GofcODDZvb+B9s2eGGr6DvkKkZyMoCp6Znp009htR/U63hMzp9jaWsN4
	ZoPVR597WACcGxuJVBaJ0+pN5eck5Bzt0se+/+KTado8iKI1WT/mNWBmfEHTkgkrzgk4sF
	4J6eLOOvMxHreu5fjmtSLypLunk/RIhKaEIOmqUxaRNxBTHFde47rvGl3hTibAMyKK33QL
	M+fg56EvSFirBsbEbk1FLD5eDhXBDXuMnxDT3Q2LzwNM+vcGfozGSjusktg/eA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail] arm: irq_pipeline: Fix IRQ state checking in
 do_page_fault()
In-Reply-To: <20260929-wip-flo-7-2-arm-pipeline-fix-v1-1-300c70cfae7f@siemens.com>
	(Florian Bezdeka's message of "Tue, 29 Sep 2026 22:55:09 +0200")
References: <20260929-wip-flo-7-2-arm-pipeline-fix-v1-1-300c70cfae7f@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 15 Oct 2026 12:19:46 +0200
Message-ID: <87tsmnl0zh.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTEdVqHTI5J2LoZb8AIddOvRyuYGWIOHF5YvWMp+gfXW7gemIOLokgcqayWYgHRHCyZ1h7wDeZ5BAOlWkrtPRcJkzDYOVbPqjsh49MdQ+U5j1PFzdd6RrdLQc0PHSLeWmb+qbxgKjFI97oPcnB67z/xyKGFagNAW3/jYX4svrtCJEAXdnizFsXoWVkLmD6bJbHD2iyU1WJ5dSz6q1BGXW0zB65JEPAearJGit6aLDQ7+cRm9UsQAqP/Ba3+2XWxAgwWWa3XWjLNZSeDQs8lPMBJ3q3EpBIHOT15nWglIf6NJiZWzNlQb9F4s3Rsw6B9aTpvZnAhkT+WLJkboFle/I1YFb/lIdCtFoi50mh8m7QRJZFv8dtgasmfenQ/5Q6DzVJinhkAa2TWNBrnouVU9VW+JayVN4hA+1xONO5SjSnofan/xUiBvUiV0BHyBf/L7K3cKy2JLD5KyKkNazl8p/5o/aUTKGRS84Qmz99f09N/EOCtX//V4lZPEOyMdKmEvNZ11atJmLDJNYEQ3uJRGLuyxdvkAG7MWpmHd8ktVNE389H6EqakU+p8teYeMJazoliLTBXFlZD9n6/Oes6lgGcGAFkh/BwQZM4QW1K9ypfridH5RXkzT72M0lry2a5G/X6eNt1MGFUE7NacfyMU8+9zI0VpjsVxk+MvCwp4jAtRsTQ
X-GND-State: clean

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> When correcting some fault handlers in the patch series referenced below
> one call site was missed. That is corrected now.
>
> do_page_fault() migrates to the inband stage and enabled the inband IRQs
> depending on the hardware state. Instead, we have to check if the inband
> stage was stalled on kernel entry.
>
> Link: https://lore.kernel.org/xenomai/20260610-wip-flo-v7-1-arm-pipelining-fixes-v2-6-62c9c477f8f2@siemens.com/
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Found while scanning the code for necessary 7.3-rc adjustments.
>
> To: xenomai@lists.linux.dev
> Cc: Philippe Gerum <rpm@xenomai.org>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm/mm/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 8f7feb1a228fc12c2d14389f865b13e23d11460d..91d0afe7985d55b424009cc29d8f3343cfca90fd 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -376,7 +376,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  	irqflags = dovetail_fault_entry(ARM_TRAP_ACCESS, regs);
>  
>  	/* Enable interrupts if they were enabled in the parent context. */
> -	if (interrupts_enabled(regs))
> +	if (!arch_kentry_test_stalled(regs))
>  		local_irq_enable();
>  
>  	/*
>
> ---
> base-commit: 58e8e0f74c2b20f6228b7d327ec2e955ffd5b491
> change-id: 20260929-wip-flo-7-2-arm-pipeline-fix-939fc6370fb2
>
> Best regards,

This patch [1] uncovered an issue with the series introducing
dovetail_fault_entry() and friends. Fixed by that patch [2] living in
next/evl-6.12.y-cip-evl for now, on top of a backport of the series
mentioned above. Tests look ok so far, I'll update all the affected
branches next.

[1] https://lore.kernel.org/xenomai/20260929-wip-flo-7-2-arm-pipeline-fix-v1-1-300c70cfae7f@siemens.com/T/#u
[2] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/020af735209333b180993f03534baf078fcddfb9

-- 
Philippe.
