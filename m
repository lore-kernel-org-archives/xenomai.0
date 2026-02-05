Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987BE30C630
	for <xenomai@lists.linux.dev>; Thu,  5 Feb 2026 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318202; cv=none; b=sf9NRBzVSIkB+dwdVobGjAkx4qYguQLT1PcSpyffPmNyM8G4BGHZ5Z4I1kViniK2U9k+OaoA6jnlbovP+U91L65X5+EjbQ+uuQFnEvj+23xqSTiqtiMAj+zHyF7SYKOCgaVKvplKk6oPGymZoSj3AFIFLv2TZlhJ60LGoTQ2UIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318202; c=relaxed/simple;
	bh=TONuIhonD/gvbTtZtVglHozkJWAWcpi/UEbZqMeh7HU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rAu+Zj7ImVmsU6PM0cROndt/1eYj5v5xWw1cokRgN5cN55fAW8KQ/g1w9LP3aH46FExkA9M4I+UTEaY6MVhJ3yTCshTLy5IniwuZN3Zdoz9aP+D1hfAYZGNa/nCkBVP1GivJcClAdv+Q0WrwT/Uuxh8Kpe8oZ7Uz8pKQWM2Kpx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=MFiogOLh; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="MFiogOLh"
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF7BF43B7E;
	Thu,  5 Feb 2026 19:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1770318194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fr2x9QTGgFnlS7NU6mcjvjWVilqJN/8SGBq0c2lfbpQ=;
	b=MFiogOLhx9SwwtzbQbHj/hOxAVdhSkxcV5BLwD5qUfQCTeVo7I7oTFXfXpCp3wCe2RoBaw
	wHg1GEsqgjvkSmNDgxaaWzS3klMS1Tn289W9AeYe5rxVAurqNWvvgEs2PDfHZeAHYim7R2
	mbqrncfMvPE3Py4ekJbvxuR09aBjhLN9nglFtKWMJZXHaD3mce3aV8a8rNZfB+JW2AYRQH
	Mifhls3wAfm+nxdphOuYbBOfcjxEqZX3SR8H+SAo34K0VV2S60P3D/uLu4F27DLhmyaqqI
	+TUCrc/Rws1WTfsOqSV8BRbScNhr17g5qfQev6cmTRe2bD+Zyp/hIVhWVuzpNA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.18 v2 4/4] arm64: irq_pipeline: Fix
 tracepoint for multiplexed IPIs
In-Reply-To: <20260201-wip-flo-fixes-for-6-18-v2-4-28b30dbcfdf8@siemens.com>
	(Florian Bezdeka's message of "Thu, 05 Feb 2026 15:00:15 +0100")
References: <20260201-wip-flo-fixes-for-6-18-v2-0-28b30dbcfdf8@siemens.com>
	<20260201-wip-flo-fixes-for-6-18-v2-4-28b30dbcfdf8@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 05 Feb 2026 20:03:13 +0100
Message-ID: <87ikcb813i.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeitdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugeptefhjeeuhfegfeeujefgpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-State: clean
X-GND-Score: -100

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> When IRQ pipelining is enabled the reason for an IPI was always set
> to IPI_RESCHEDULE as this is the IPI used for multiplexing all the
> inband IPIs via a single SGI/LPI.
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/arm64/kernel/smp.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 53ec370235f93..39499b9797923 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -1069,9 +1069,10 @@ static void ipi_setup_oob_lpi(int ncpus)
>  		map_oob_ipis(cpu, nr_ipi);
>  }
>  
> -static void __smp_cross_call(const struct cpumask *target, unsigned int ipinr)
> +static void __smp_cross_call(const struct cpumask *target, unsigned int ipinr,
> +			     unsigned int msg)
>  {
> -	trace_ipi_raise(target, ipi_types[ipinr]);
> +	trace_ipi_raise(target, ipi_types[msg]);
>  	arm64_send_ipi(target, ipinr);
>  }
>  
> @@ -1102,7 +1103,7 @@ static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
>  {
>  	/* regular in-band IPI (multiplexed over SGI0). */
>  	set_ipi_message(target, ipinr);
> -	__smp_cross_call(target, 0);
> +	__smp_cross_call(target, 0, ipinr);
>  }
>  
>  static unsigned int get_ipi_count(int ipi, unsigned int cpu)
> @@ -1120,7 +1121,7 @@ void irq_send_oob_ipi(unsigned int irq, const struct cpumask *cpumask)
>  		return;
>  
>  	/* Out-of-band IPI (SGI1-3). */
> -	__smp_cross_call(cpumask, sgi);
> +	__smp_cross_call(cpumask, sgi, sgi);
>  }
>  EXPORT_SYMBOL_GPL(irq_send_oob_ipi);

Given the added complexity, I would rather not factor __smp_cross_call()
out anymore, open coding it in smp_cross_call() and irq_send_oob_ipi()
instead.

-- 
Philippe.
