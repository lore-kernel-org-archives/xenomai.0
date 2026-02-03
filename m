Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF44331ED64
	for <xenomai@lists.linux.dev>; Tue,  3 Feb 2026 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119987; cv=none; b=PoVc5spPZCikGqWqTB+GT+Sdr+W9H2EN9QxSs/3S8s62zTKXmy4XxnauA1I7iI92dv3tmcDGb5LWvjP5+/U1xdo4ZNTb0kU4lZn22fHCPoD2JPe2s3mYfQu+W0TETW+CZxFCNI9/2zldMNcb7IkL+TedH+iMDoh4rRCXXhGs858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119987; c=relaxed/simple;
	bh=P9goAEvtaFsaE6/bx3j7zLLIHYVrMQVWtaKpTHNpDWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oIf1xWdzVmnVrr2WyqWjYKXDqQr1hS8SN9keGdUM9htH8KTmSmGe9ycRviUGSOH/LrdUtugvU1adpiJvnEE7oAxRNfAut0ISYlrc5SNtH1iW0Q/b5UKqBRoSGIWPZGFwOsqO+pxlAiLJV8Gea25ioXaYjGoGQpe0j8A/1jlQSTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Qqdb6Wcq; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Qqdb6Wcq"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 73DE643213;
	Tue,  3 Feb 2026 11:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1770119976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DU2Xk0mjETZyfTvh6i1tf914F6uCZk9UC+qbw4H7IXo=;
	b=Qqdb6WcqhM9nwSq+Q6/38sJh7qa9g3opFWha1zS70mvumRgytbSW9RO3PgVC+ztqaeUMuU
	vzwxgQW4Kmn1ayc1pF1vjB4bftX2LAcnwltVcyIE/AUoqE/Vw5RqZQIcg4rSh4YGYqUxx7
	ZENbIxUiq0mcHu1FJXzIdlj5OF9/bP7ZMHsNP4zx8UD40I+uYC+5tHTQdpi6GKk3X+pK4o
	sGCed+8UqursFmOo5egUQyHZWLGgzGCrgvS8H41/EXQdEJHZnpzYSb3JK/O+smA6Li5tan
	FvpK12SK/bUvy2KG4/mJHCg5xGm7O865IO2QQXXmnuEtXvDv6coCqchtfihsAw==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 6.18 2/3] arm64: irq_pipeline: Fix size of IPI
 statistics array
In-Reply-To: <20260201-wip-flo-fixes-for-6-18-v1-2-91ea07c7eb7e@siemens.com>
	(Florian Bezdeka's message of "Mon, 02 Feb 2026 08:55:21 +0100")
References: <20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com>
	<20260201-wip-flo-fixes-for-6-18-v1-2-91ea07c7eb7e@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 03 Feb 2026 12:59:31 +0100
Message-ID: <87v7gexckc.fsf@xenomai.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedttddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepjeeffffgieegfedvudefpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh

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
> index e8cee27dc1132..716ba0b0c274b 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -1049,7 +1049,7 @@ static void __smp_cross_call(const struct cpumask *target, unsigned int ipinr)
>  
>  static DEFINE_PER_CPU(unsigned long, ipi_messages);
>  
> -static DEFINE_PER_CPU(unsigned int [NR_IPI], ipi_counts);
> +static DEFINE_PER_CPU(unsigned int [MAX_IPI], ipi_counts);
>  
>  static irqreturn_t ipi_handler(int irq, void *data)
>  {

Good catch, ack.

-- 
Philippe.
