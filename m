Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711793054D0
	for <xenomai@lists.linux.dev>; Thu,  5 Feb 2026 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770314372; cv=none; b=PXSQcBHhlVOHuAGisf0MjXgYCp1AbG+lkpVDVMK3hW2V670h6TRtKiHC9Ev+TnV4X5Yl+cwpuQzO8zWO9wX/KuKseNumqj0B4JEn1SG1Vatec+eqIm1ceOaPvR1j2SMFCvScpj8dTwZdqnGfCaTFjMMYQRO9YUhdg5MJ94DlHwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770314372; c=relaxed/simple;
	bh=oZftX4u8RH9IQGVvxmKNouvbly5RoqfWRGdUI+Y+slo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MPRmxjk86Muni0jKP9sdBISgffnP+3cFIeUwssWmESUf7wsMK/22xsGd+7s7w92v7vwJKQHxrFv3BjYm7PNH2xD+4oGQ8K9WFCJ9+wuYuVwYClCZk20hKrhy9NxfpZYLph1ueX1JKqZmTEg+m2QN5jjaJw9QnODJP8BXl0PeGnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Ep9iLbsU; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Ep9iLbsU"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A8FCE4444A;
	Thu,  5 Feb 2026 17:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1770314364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qDEdzlnBdQrfkiW/RF7LT7QxKaKUbK+I68QF4Rm3IjQ=;
	b=Ep9iLbsUvM4A/acbU9iuWuTxTKGp9N+SfqNNWU/7NXk+nlbwa5I9yExGefUP0iyDm5HwKe
	wvJyd/3u2prxh+WA9AZAEda52UzOfXh4gYoufhAGF9rpRC/BG5I8BC9TKGDhiLLPVrN6yF
	yHxff+48QynJOJ8DdxY19ouB1w+BJi7G9vWJLEcQJhZ210WL5w/ecekjgbHFmr9UGrDC6+
	+nEwIch3Le7hgwPCIalPHJObrJVyTpiygr6f/OlUZsY4ABf86aD+q7wXXeapNjWwllwXCa
	p7fISrHXLDw3N4gfWHKLrox1uwixC6PgyfrAvcI4uFkn07BAAGP5RF2ma3LgIg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.18 v2 1/4] arm64: irq_pipeline: Fix mapping
 of IPIs in LPI mode
In-Reply-To: <20260201-wip-flo-fixes-for-6-18-v2-1-28b30dbcfdf8@siemens.com>
	(Florian Bezdeka's message of "Thu, 05 Feb 2026 15:00:12 +0100")
References: <20260201-wip-flo-fixes-for-6-18-v2-0-28b30dbcfdf8@siemens.com>
	<20260201-wip-flo-fixes-for-6-18-v2-1-28b30dbcfdf8@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 05 Feb 2026 18:59:23 +0100
Message-ID: <87zf5n841w.fsf@xenomai.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepteekhfevgfeggeeggeetpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> In LPI mode everything was mapped to the IRQ descriptor of CPU 0,
> which is wrong. Each CPU has its own IRQ/LPI used for multiplexing
> inband IPIs.
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/arm64/kernel/smp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 3a12956580a35..52e9d29083fc1 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -1020,12 +1020,14 @@ static void do_handle_IPI(int ipinr)
>  
>  #ifdef CONFIG_IRQ_PIPELINE
>  
> -static inline void map_oob_ipis(int cpu)
> +static inline void map_oob_ipis(int cpu, int ipi_offset)
>  {
>  	int ipi;
>  
> +	ipi_offset = ipi_irq_base + (cpu * ipi_offset);
> +
>  	for (ipi = OOB_IPI_OFFSET; ipi < OOB_NR_IPI + OOB_IPI_OFFSET; ipi++)
> -		get_ipi_desc(cpu, ipi) = irq_to_desc(ipi_irq_base + ipi);
> +		get_ipi_desc(cpu, ipi) = irq_to_desc(ipi_offset + ipi);
>  }
>  
>  static void ipi_setup_oob_sgi(void)
> @@ -1033,7 +1035,7 @@ static void ipi_setup_oob_sgi(void)
>  	int cpu;
>  
>  	for_each_possible_cpu(cpu)
> -		map_oob_ipis(cpu);
> +		map_oob_ipis(cpu, 0);
>  }
>  
>  static void ipi_setup_oob_lpi(int ncpus)
> @@ -1041,7 +1043,7 @@ static void ipi_setup_oob_lpi(int ncpus)
>  	int cpu;
>  
>  	for (cpu = 0; cpu < ncpus; cpu++)
> -		map_oob_ipis(cpu);
> +		map_oob_ipis(cpu, nr_ipi);
>  }
>  
>  static void __smp_cross_call(const struct cpumask *target, unsigned int ipinr)

Ack.

-- 
Philippe.
