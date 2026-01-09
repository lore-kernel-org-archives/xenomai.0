Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5FE35CB9F
	for <xenomai@lists.linux.dev>; Fri,  9 Jan 2026 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767974808; cv=none; b=BhnL15UwbmJoqUkYGkEcUAE6ZEkgsU7rwmhaPidpg/CPiD+0IXu4/KJSPLlv2IcxjqmETeDhh6+4MhN01b8tq24lrsitG9tZX7LxE8WqB2XPJlkUf/bkANAk8cTlFkVQCf88LAAEpYCV1LeOk1Bjdvcva0X0+I4qvR7bI0Jbe0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767974808; c=relaxed/simple;
	bh=0lW0XYkIq2ULX0KNraj3rIQnXK3MyGu4bLg4mF1PULk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OoKjVTzLLGgrEokWKnH1jUJTPqMiB35KptoUkPefgk0MGJy3T6r+GR6XNsF/+UPHTjLGGzFzWgBV/FymiJyTqQf7wosaZ7yav57RFVX3RZQPQPbNT52/uAaC4/oLeMI4CtK6Uo6kb3LrsXTPS8L8M4biIUTpXxt3OXr28FOEJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=lc4kWL5I; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="lc4kWL5I"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2399543A5C;
	Fri,  9 Jan 2026 16:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1767974799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AOvwn2GKTIIJXafk//JYqP1NJP9wx2H8SEo1SyfaH88=;
	b=lc4kWL5I56Qxm8A8h5r+G/bTKZdKo15LecQRJn1MnNDMqTHWTeWuJ9fojo2ea0LjpqK49n
	ACxt7GmcPvcjhpmPJuxWBwsO946y8LW3zcKSq6tIA1UO6WxzZHND8lJOMWIeHi+md7Z50F
	vPLNjjFpjj7FwSwfqahYLX6//qzx7JrJU8bABEDS36Dw/CYL06jsTgt5NBwB1wJJN/4pzI
	GYa3VjMAuCW45JEHZGyH1v+J1vxcuwckYOGd3YpBQFDIw6AWWHPFsu6AyGoei25kskDlix
	eR9NELqFOQQcFExRkMLEwNrN9qF5DuHwKbALU3IycYDmbdANWeoWeKsOSOSU0Q==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH Dovetail 6.17] arm64: irq_pipeline: fix IPI mapping
In-Reply-To: <20260109114034.1094081-1-florian.bezdeka@siemens.com> (Florian
	Bezdeka's message of "Fri, 9 Jan 2026 12:40:34 +0100")
References: <20260109114034.1094081-1-florian.bezdeka@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 09 Jan 2026 17:06:38 +0100
Message-ID: <87wm1qixdd.fsf@xenomai.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdelvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepvdefleelheegfeetheevpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> While the commit mentioned below touched ipi_setup_sgi(), ipi_setup_lgi()
> was forgotten.
>
> Fixes: 7e7b969ce82f ("arm64: irq_pipeline: fix IPI mapping")
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/arm64/kernel/smp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> With that one applied 6.17 seems to be in a stable state again.
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 8ceb41ff0253c..d89b659231614 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -1219,8 +1219,8 @@ static void ipi_setup_lpi(int ipi, int ncpus)
>  		 * be mapped, so that arm64_send_ipi() can read any IPI desc.
>  		 */
>  		if (irqs_pipelined())
> -			for (i = ipi + 1; i < nr_ipi; i++)
> -				get_ipi_desc(cpu, i) = irq_to_desc(irq);
> +			for (i = OOB_IPI_OFFSET; i < OOB_NR_IPI + OOB_IPI_OFFSET; i++)
> +				get_ipi_desc(cpu, i) = irq_to_desc(irq + i);
>  	}
>  }

Merged, thanks.

-- 
Philippe.
