Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7789C37FF5D
	for <xenomai@lists.linux.dev>; Wed,  3 Jun 2026 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511971; cv=none; b=A09WyAdmVRKu1cRnnk98g1zlMa3TiEiBwanEyzjrzJMFPoqZZ5B/L62j3Jow38pwtPrgAPUiw/wGJdgEmu+fp+KzpICcBCPwmKE9ys3kpE047vMI6PBrteu6wyssOLUt8WIkg6yuG1/YJjoS0DvYUWFWr/oa6thK2/7pMO9/qjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511971; c=relaxed/simple;
	bh=7L6Hp1zzjLmzuIGJ8Mpjmi2/RW064AsglnN2Dk/aFCk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O3MLI33dTU4HLtmKkx5w7POlE7O5iPGHd5F8HRQIjgf3Bv7vuYOutoEtovMlgj/5y9Rs5e/6NzgsUTBkoi9WfZCU6BI6Psd9DmHLg4zL1HwEjUsP8NnCPrvP7WUcb5wMJ8OpkHz2W2DqKn5y8lCb7tAadekRsDYF+pOqNlemaYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ZQ2G/g1K; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ZQ2G/g1K"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC1D43E96B;
	Wed,  3 Jun 2026 18:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1780511960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dCsaJYMuAd2EGn3fPVbrGQVHYz0iQfvle3hPVUgCMuc=;
	b=ZQ2G/g1K/QG0cka5YupccN8sp6OVcDOtY09G3QdhK0+tmcBMF457KLubX7mMJSZC/8KhLk
	En8+tJXtM8PkfhfslsmipNXNnV3t4aQFQVxuq4ecHjQ+59qvgkD3oJM6M79gpb7xqzjw/V
	Iy7gYB2D4SztTFhgsAO6BaWQMTlI5mNLbY4mquD6WkSuVXv1WcO5PPdyx2Wq7uDHqYoy/t
	rd7CmbAGIdKnzDGR3hyd9IO8KuF5EfhOddF7zT5NZshYZ3YoK1V70wlPDnzGwH59FDCaHf
	vt0S//tF/zfgScKMlLLUJe9EUGCsOsZlipJJZ8dGmjBe6sbkXNi+TDh8el9+QA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH 1/2] arm: irq_pipeline: Fix fault_{entry,exit} imbalance
In-Reply-To: <20260603-wip-flo-v7-1-arm-fixups-v1-1-c28b4ff180ed@siemens.com>
	(Florian Bezdeka's message of "Wed, 03 Jun 2026 17:07:15 +0200")
References: <20260603-wip-flo-v7-1-arm-fixups-v1-0-c28b4ff180ed@siemens.com>
	<20260603-wip-flo-v7-1-arm-fixups-v1-1-c28b4ff180ed@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 03 Jun 2026 20:39:19 +0200
Message-ID: <87bjdrlb8o.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTEE8waYKWJqeidPr58sEJD3X/F2cbYuOdtHAdF6PH/NiXxx8tPKFEnKwVgXnn3EL/gY2Qo5c5zHcyNaerlv45EXiBFoRk9JG857eJkTu2cJml5u4AwKjQUMZJJWP5CQG32r9TWVRd85EcbSQcPwaemQn1LFPKMxleV1viOsAVQKpB+q0uYqaCkkz9G99+fS7xS49LgGI/8QfeMhCDYqw+FKcocpCEVYuKMaCA+CPLvx9sfTsXRC/AIZXuVc7ZRTJfl+UKZNGYHaIYKWVD57mWgJYhJfrntfCL9jsEqPFm2sBRG+8uc2ytcBRyhDUGsDKmztZA69XXwCmyqrhe6R0VgWMpAxVRj4ITyWPtFIQGRRMniUSPFa3GJIokaaBqZRNBHBAIlc5dFyF/sYlWG3tCZd+VSgvkzs4oz7SfMylbPb7BDP+CLDSL227vALcQ+GoBZtUXlWsphoGxSIiAIzLuoxHEpm4h/7LdzrRO2lQg/tOZoN3ljdWeft39zKW3H6qIsS0Men8Z4sOJ6C6hrQSmEpAT7Bh2ZYcr1c6BqiV/45iSF83NFKTKbnCWpIwZIUvZL5X4C2+YlCURERfsUkr4vZcIJPQSp1IORFJf8LIdGfSizZCsnJHwi4NzjwhtFJ62VJGSFqPc2QOGsP/K5zLzPCJr3UX363mhcgjCtJGHF9lQ

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> upstream commit
> d92725256b4f ("mm: avoid unnecessary page fault retires on shared memory types")
> introduced a new exit path to do_page_fault(), so that an imbalance
> of fault_{entry,exit} can happen.
>
> The commit was introduced with Linux 6.0, so all newer Dovetail
> versions are affected.
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/arm/mm/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index b4bb33e1638cd67ce2b6c0b90a4a9693e784bb3e..4beae304c0269d11173cd3b360cec05e59f30d82 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -539,7 +539,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  
>  	/* The fault is fully completed (including releasing mmap lock) */
>  	if (fault & VM_FAULT_COMPLETED)
> -		return 0;
> +		goto out;
>  
>  	if (!(fault & VM_FAULT_ERROR)) {
>  		if (fault & VM_FAULT_RETRY) {

Merged, thanks.

-- 
Philippe.
