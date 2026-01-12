Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A76D154425
	for <xenomai@lists.linux.dev>; Mon, 12 Jan 2026 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227150; cv=none; b=F51+W+YE8kErvetEiBmayL1AShiXGXhKxYYtPFJQSD1UxnuUA/S50dm9GeEHpX/53JzRTcb7E0C2bgf/4fOp5CtIIhhPnFKdicLWa5D3n+C0dDG8J3CJbhuhjD/C1UubMsY7IMSIveJnFbFNVengDL0GdaUHNqVuBPSOvsRhRbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227150; c=relaxed/simple;
	bh=R1EoD2dWowZFTUPyCSqQKx91UpiRaUcJixwniKYokbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SViPVz6B/OOBA2IQzXgHdbns1VB+FrSBjTVE3MR4RJv2sGGveeGHzGWcl4ZtJcys4ZhCOMs/pnMLAqG4lleYaYe4Io9Cn4Ophqh71Btj6X0SECTdoBMWjJCKKF4sVcBpdNE4LqiaWjPrWu6X15aJHUbh7QxjK1CccDrSrjUKkDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=lOJgZ7xB; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="lOJgZ7xB"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2560443C2;
	Mon, 12 Jan 2026 14:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1768227146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tb8z64JcoT8NFre1uxLWFxM+jeKc1ulo1zh1wHr7qN4=;
	b=lOJgZ7xBnYHm3CnihK0Fk0wPiv1Goi8xp2gKzis4EEN3R+PLV/IbeaHIh+w/6dIXUS/XKa
	1DcVDnpPqhhIsFGy+QT/rhwBQrZixkex5TrKmFVDI1wPA3Qx6aGjuyyxD1lJmmkrHgPUyz
	bZQQKpRTIm2R+tObxmeyl4w9cTU0RKpuDeZn5sOEZSe9aQBv3nZnEQ/mED5KH89N+1tLiN
	NDf9XRBb0yuXQNlNBbUFAlaYSfpJfrBKF8YNcKFaFCvFeJ5odZF2xvVKLcoZxnsC+RBKXa
	a6GLMw8sygxShsgiUKVP8cOep8W08iRHioGY7roto5oshuHyhMjtxmuNyAk2Uw==
From: Philippe Gerum <rpm@xenomai.org>
To: Junxiao Chang <junxiao.chang@intel.com>
Cc: xenomai@lists.linux.dev,  yuan1.wang@intel.com
Subject: Re: [PATCH evl 6.18 1/2] evl/genirq/test: fix irq test build issue
In-Reply-To: <20260113094852.2806192-1-junxiao.chang@intel.com> (Junxiao
	Chang's message of "Tue, 13 Jan 2026 17:48:51 +0800")
References: <20260113094852.2806192-1-junxiao.chang@intel.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 12 Jan 2026 15:12:25 +0100
Message-ID: <875x96q5rq.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepgfdvheeitdeggeefvedvpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopeihuhgrnhdurdifrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhhunhigihgrohdrtghhrghnghesihhnthgvlhdrtghomh
X-GND-State: clean

Junxiao Chang <junxiao.chang@intel.com> writes:

> raw lock in irq test case should be replaced with hybrid lock.
>
> Fixes: a4a5748406af ("genirq: irq_pipeline: add IRQ pipeline core")
> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
> Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
> ---
>  kernel/irq/irq_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
> index e2d31914b3c4..f13ea0f7cbdc 100644
> --- a/kernel/irq/irq_test.c
> +++ b/kernel/irq/irq_test.c
> @@ -145,7 +145,7 @@ static void irq_shutdown_depth_test(struct kunit *test)
>  	disable_irq(virq);
>  	KUNIT_EXPECT_EQ(test, desc->depth, 1);
>  
> -	scoped_guard(raw_spinlock_irqsave, &desc->lock)
> +	scoped_guard(hybrid_spinlock_irqsave, &desc->lock)
>  		irq_shutdown_and_deactivate(desc);
>  
>  	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));

Merged (slightly fixing up the short log to align with the existing
convention about prefixing), thanks.

-- 
Philippe.
