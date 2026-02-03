Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0589337B8F
	for <xenomai@lists.linux.dev>; Tue,  3 Feb 2026 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120008; cv=none; b=BodQ6nldzaGzXakpjTZw1W2V/uq8JdZtryn/xyS3t0uNa1r3Larp9O+4TFl7xQE27iO09+6zYmH76L3b87rt+eW9S9dwyks1LelV5dAdH1wRrICjOGFx5LaGsNURDPKE88Syq9cgbyYpTpJtQkdmV4wb5QVt0cJd1sEtgG9ZuXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120008; c=relaxed/simple;
	bh=jNDdoCbKf7QAWmscXLVI/E42q+5x1EcYyiJQQxYfAJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZwK6Lrz53e6J2Mwf5RGDI/aq3HEMfMbggFbC4MoSbxx/2qRBKDW5I7UHo/VXzPAmyIY7vEY4gJ3x6KfLhmZQbF+QOsmPvDeXdCj/jWadNaQC04MTXmBqjKsKosN+EW6zn8KDyBPIgWrTukfM4w/OE/KhU/y53lfXjCt5OgCIPnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=aOMaxTwR; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="aOMaxTwR"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C20D3E9BA;
	Tue,  3 Feb 2026 11:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1770119999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=avcBy+alUmk/+WhyzWeugMc9TZKze/xnWYGtlP3f0uQ=;
	b=aOMaxTwRf3nuT7mru71pauGLpXLHGme8euv6unNtLPQGmZdtOZ4U6nPPtx5872Mcb84bHL
	alKxkz6yWLrye7XHpObvF6AKuBGOukBt3XGk32v/mNY4fkRaTNGiI5lepGkjZZX6fQJoXb
	P0pwKSXQTSBeTrXSN0idDjxLPBJvull/bnv8xYzjwBSRehqyC7iCpfvpBtJS2zqkwQy9KP
	iXfJCQKLEmb+A5UpC18uw2OX+znPllo54rpqoab6luGfNuCLGbQILORwYz9aGVkQdyG3Dn
	KwI7PK9jXzrc084nKEamUEyuu10/WR8gVRaMadFz3FzHaV4etQYPibeNjJBhDg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.18 3/3] arm64: irq_pipeline: Fix
 IPI_KGDB_ROUNDUP and IPI_CPU_BACKTRACE IPIs
In-Reply-To: <20260201-wip-flo-fixes-for-6-18-v1-3-91ea07c7eb7e@siemens.com>
	(Florian Bezdeka's message of "Mon, 02 Feb 2026 08:55:22 +0100")
References: <20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com>
	<20260201-wip-flo-fixes-for-6-18-v1-3-91ea07c7eb7e@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 03 Feb 2026 12:59:58 +0100
Message-ID: <87pl6mxcjl.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedttddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepleevvddtffefgfelueetpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-State: clean

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Both IPIs (IPI_KGDB_ROUNDUP and IPI_CPU_BACKTRACE) are multiplexed in
> case the IRQ pipelining is enabled, so we have to set an IPI reason
> in both cases.
>
> Both cases were directly calling into the IRQ chip implementation and
> forgot to set the reason. IPIs were ignored on the receiving side at
> the end.
>
> As tracing should be bypassed for all IRQs behind NR_IPI we can not
> call smp_cross_call() - where setting the reason / ipi message took
> place.
>
> Setting the reason has been factored out into set_ipi_message() which
> can be called with and without IRQ pipelining.
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/arm64/kernel/smp.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 716ba0b0c274b..f85392de0e6a6 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -913,6 +913,24 @@ static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs
>  #endif
>  }
>  
> +#ifdef CONFIG_IRQ_PIPELINE
> +
> +DEFINE_PER_CPU(unsigned long, ipi_messages);
> +
> +static inline void set_ipi_message(const cpumask_t *target, unsigned int ipi)
> +{
> +	int cpu;
> +
> +	for_each_cpu(cpu, target)
> +		set_bit(ipi, &per_cpu(ipi_messages, cpu));
> +
> +	wmb();
> +}
> +#else
> +static inline void set_ipi_message(const cpumask_t *target, unsigned int ipi)
> +{ }
> +#endif
> +
>  static void arm64_send_ipi(const cpumask_t *mask, unsigned int nr)
>  {
>  	unsigned int cpu;
> @@ -926,6 +944,7 @@ static void arm64_send_ipi(const cpumask_t *mask, unsigned int nr)
>  
>  static void arm64_backtrace_ipi(cpumask_t *mask)
>  {
> +	set_ipi_message(mask, IPI_CPU_BACKTRACE);
>  	arm64_send_ipi(mask, IPI_CPU_BACKTRACE);
>  }
>  
> @@ -951,6 +970,7 @@ void kgdb_roundup_cpus(void)
>  		if (cpu == this_cpu)
>  			continue;
>  
> +		set_ipi_message(cpumask_of(cpu), IPI_KGDB_ROUNDUP);
>  		__ipi_send_single(get_ipi_desc(cpu, IPI_KGDB_ROUNDUP), cpu);
>  	}
>  }
> @@ -1047,8 +1067,6 @@ static void __smp_cross_call(const struct cpumask *target, unsigned int ipinr)
>  	arm64_send_ipi(target, ipinr);
>  }
>  
> -static DEFINE_PER_CPU(unsigned long, ipi_messages);
> -
>  static DEFINE_PER_CPU(unsigned int [MAX_IPI], ipi_counts);
>  
>  static irqreturn_t ipi_handler(int irq, void *data)
> @@ -1074,13 +1092,8 @@ static irqreturn_t ipi_handler(int irq, void *data)
>  
>  static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
>  {
> -	unsigned int cpu;
> -
>  	/* regular in-band IPI (multiplexed over SGI0). */
> -	for_each_cpu(cpu, target)
> -		set_bit(ipinr, &per_cpu(ipi_messages, cpu));
> -
> -	wmb();
> +	set_ipi_message(target, ipinr);
>  	__smp_cross_call(target, 0);
>  }

Ouch, yes. Ack.

-- 
Philippe.
