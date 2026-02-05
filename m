Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A76C303A07
	for <xenomai@lists.linux.dev>; Thu,  5 Feb 2026 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770314983; cv=none; b=dkdEKjMqhFa6/+qkH5JvQ1lt+1oCifAnK5ifUgvq27J4lFjn371mQaLZv9cKJqlsEe+V623fdXN/7ykwRsi2deb5OvVDdkFpi3dM6ufCaDAXlWOk8ESfxwEtHr0CO6zRGiTfqdxZvPKjPF0Fu8B8o4X7f4inXed9NZHXHObYzDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770314983; c=relaxed/simple;
	bh=WR5tldka8MPGLC9WNfnTasX8WO997/vrlhDGdhmqHBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KX1dyKyEu6dMI83kqP4MCLVzI896ESrGZ9Y2i0n/A6oeZ1ONx5BjAzpv5PTGGsh2PXYnY6yUiRySPWJ7TxtKrblVkWu01Aq0GRuEauYLgXaQBJpMg9dixsq3JEFMDmnB2hWmECJtzv4cMjQ2Ex4ZvOc4+CcSqExiLn/IgaRo+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=i9Pew6WT; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="i9Pew6WT"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 915D558020F
	for <xenomai@lists.linux.dev>; Thu,  5 Feb 2026 17:59:52 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A0D4A442E0;
	Thu,  5 Feb 2026 17:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1770314384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=USxF78ga/5G9MBGSS3/DLlsK4fpiNd+tjh2C45vIclk=;
	b=i9Pew6WTvmQNnEKPT2LJKTO359wvQQP1d5WyDLWPKeMkpILOazgO54H3vOZwxA6GjhtAM1
	kRHNaC8mcKF6rpMBclngg+mCFNlK/YrvicySqFuhxnqIswNi7TqnichDr1ixslbZhHFMyG
	wVFVwRCrYm/jIBBu7mzwAldeN2lAQ3XyXPXgA2iDc2p8b0GXXrhhB4DF5rUAWTCn69ftOW
	KjvFXIi2pB0JcJv3xxM6FN7E1qajpqIPZVqTJj7ycsJYG7wROURAokJSnb+hD7J2wikInZ
	565I5U8b/6C5iaKFkIVdd9hlmN2y8qtEYqBaUUUq/eS+aSvruE+v6o97+pl2MA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.18 v2 2/4] arm64: irq_pipeline: Fix size of
 IPI statistics array
In-Reply-To: <20260201-wip-flo-fixes-for-6-18-v2-2-28b30dbcfdf8@siemens.com>
	(Florian Bezdeka's message of "Thu, 05 Feb 2026 15:00:13 +0100")
References: <20260201-wip-flo-fixes-for-6-18-v2-0-28b30dbcfdf8@siemens.com>
	<20260201-wip-flo-fixes-for-6-18-v2-2-28b30dbcfdf8@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 05 Feb 2026 18:59:44 +0100
Message-ID: <87tsvv841b.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugeptedtffegteeggedvgfdtpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-State: clean

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> NR_IPI is not the last possible IPI, it's the last traceable IPI.
> IPI_CPU_BACKTRACE and IPI_KGDB_ROUNDUP are located behind NR_IPI,
> so access to those counters were out of bounds.
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/arm64/kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 52e9d29083fc1..8d3791ed39e69 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -1054,7 +1054,7 @@ static void __smp_cross_call(const struct cpumask *target, unsigned int ipinr)
>  
>  static DEFINE_PER_CPU(unsigned long, ipi_messages);
>  
> -static DEFINE_PER_CPU(unsigned int [NR_IPI], ipi_counts);
> +static DEFINE_PER_CPU(unsigned int [MAX_IPI], ipi_counts);
>  
>  static irqreturn_t ipi_handler(int irq, void *data)
>  {

Ack.

-- 
Philippe.
