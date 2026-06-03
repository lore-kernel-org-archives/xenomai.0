Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A7F3E717A
	for <xenomai@lists.linux.dev>; Wed,  3 Jun 2026 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511977; cv=none; b=src5arG7g3Rj4M3TcLYnGPSXje2CKma1Xq0XfkqxPMnR18AGvTa7SCXM5HJlsJO6v9on3cZyVuL9J7tpOhdrQ1IuHZ3LruHY5Moial5hHDWeqL2iPXUUVu9codcnzV1DPkvPyrE76Jcbl+1J1LQmBROI41C69xfchawChoEAmls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511977; c=relaxed/simple;
	bh=t3gCgHvF42xHX14L/c+EAqKFh1skeI/OEEzey/fXiZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cru4zyQfw0jgKkGdD9lnm4PiZw9JTfKbIFDcXgnSmPCNuAA71qVldcmd47rCGuD35GisnkdCEFvF+fHlHXcJtTLmfJ5mg6FJaYt3fAQ/XylaXbspSjQlRWiuU95J+VQpmEFjqHNzqxVQjBuCpa5XpZmcsSYtlBuKYLAa8bThw6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=PWZdjfDm; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="PWZdjfDm"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 952073EC8F;
	Wed,  3 Jun 2026 18:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1780511968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W5Ijp9+ptc5kIN1WkTPPpfC4kWaMsOwMY8PO7/4glcc=;
	b=PWZdjfDm1K+6UXNxLWoHblUKz++2yuligGbIos165FGUROG3uclGIpsN5KpFGWUBdstkkV
	hGttrtliQMS0+lPFIkM9SXw0fddLuGohhg/+xeKqPGz01ll+tZXLHqcbZXJ+BWGJSOhzN9
	KxLjEWQ1aiFxLeYy3Ctp86Np6zWfhPEyFM3detcb/f3CZh2YbL4gHowStlesDP2d1pN+Eb
	H+SBCAOMnW5UNUUo1q5VjNSfu9XzDsglmqv4bwH6AL36x3odd0HBRpDCtY0YO/VfwoOBOo
	Ok7rceTSpkoZfhBKKEAUMJIf0/t5hpa77VT8utndZ3rmuDhbcvv620XMMxcT2A==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH 2/2] arm: irq_pipeline: Fix fault_{entry,exit} imbalance
In-Reply-To: <20260603-wip-flo-v7-1-arm-fixups-v1-2-c28b4ff180ed@siemens.com>
	(Florian Bezdeka's message of "Wed, 03 Jun 2026 17:07:16 +0200")
References: <20260603-wip-flo-v7-1-arm-fixups-v1-0-c28b4ff180ed@siemens.com>
	<20260603-wip-flo-v7-1-arm-fixups-v1-2-c28b4ff180ed@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 03 Jun 2026 20:39:27 +0200
Message-ID: <875x3zlb8g.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTF7phc7uGOGsa0A5eBy5XFnbFX7wQl6BuOK+vyYnTRxwWBdTUtfSz+okMLaKyEY0ECaHjTddnm3sNK+jG72/QSTIvJTLJC6l+nYLvcDB6rrWYbIrQdPJAn2dJPuwSoI3JT8N97CuAKkoidBuv0oqjEknKneamOfE5lkprxyCb4nGI1/N9ZoelJGOpt6LMJkVUPeQckl1Jpy/2A1MT6XFZdrn/GuJqKXsjYLWBcTdfEkmtVVG9I6olFG18sSOzfHWTrZ6c9CCeZgZUABmmF4FpWENa+D5T0IPjUebjmQtyQ6EcHuqCwMPpscNYry+wQV+t1pGlktZjuxogjl44wfaRn5EHAcnl5Ke7Bn6xHKipNUvFrIcYWmvFWMAPBo9BsLVksRqSoCGloeKRg1A3MmeFdBClugk5jv+uAadV2d6IeisLRS1Gnkad4+8y5K4iC2NGKBE10h9kjPOpHSGGaDqAfsrEYQwDM3O8PSeKYWuj5Ttigb3wkgzYf7ctJu2/6l6myPo9yuyXHFWwBSzWTlzYSYP3wmgHsYdSwk5ettj6dbxewSuzK2VYYpgi7INuEEuQecL6fMzSITUVWvlIhjDFDem6M1wC05emFBcLwGZn6jXF6wZeiIUV1egXK1R3MGE4uPZ2LHW6HWqBrAOWxpfX+zUvOawPOWDDogYJzSDbC5QA

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> upstream commit
> c16af1212479 ("ARM: 9328/1: mm: try VMA lock-based page fault handling first")
> introduced a new exit path to do_page_fault(), so that an imbalance
> of fault_{entry,exit} can happen.
>
> The commit was introduced with Linux 6.8, so all newer Dovetail
> versions are affected.
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/arm/mm/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 4beae304c0269d11173cd3b360cec05e59f30d82..49f5d628c4c9a91a3e879af0d541fd76665d78fe 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -502,7 +502,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  	if (fault_signal_pending(fault, regs)) {
>  		if (!user_mode(regs))
>  			goto no_context;
> -		return 0;
> +		goto out;
>  	}
>  lock_mmap:

Merged, thanks.

-- 
Philippe.
