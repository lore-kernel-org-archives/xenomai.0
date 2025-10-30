Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DEF2F8BFA
	for <xenomai@lists.linux.dev>; Thu, 30 Oct 2025 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825967; cv=none; b=hreQ62woX62z1TTNv7ZJZn/ZFcJkp85RXK9CLDuMOvdVGlUHQb7nudFbSHi0u36mLI3jYdxkTyUJl+hie160bHyA4DGExqWFcTemXvJn+KcJrSTODQD2p1TDXBDzTJDe+uUheGVj1ff7F03NkQxbyrsSOYXYWoKv5IyWuB9vJnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825967; c=relaxed/simple;
	bh=hmgLtjyZESXI97Zk2iP8+qg1oWdfnudfnBKl+MOEzkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pmWI8BiBgVL5zhzRZbNtJpUk7+lfTvkySeH2jJ+xQbwCRsC8fanPlq4ZSYxr20rH16YM1Yl+gXEDOaRD8OQtu74XUEqMtbHp714lc+Xk7xXJ1HpOrfH5x0RjWCXLi4AKYeNHkQvg06AVZgoNUjsNhTBGzblh+9vwCc8QrzCbGf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Xgqh+yZJ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Xgqh+yZJ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5F0543B87;
	Thu, 30 Oct 2025 12:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1761825957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vE1bpAhutDxskCk63VTXNdRDjq4+/hRn/IqVZP0i1M8=;
	b=Xgqh+yZJgHu/vwQ0cnHnJqwWAeGY6blCdxNc7RnUflEzgfzMqTamJgnotZ1uXhLmLE4AMk
	8JeIjj3xyynnhOSz+805FX/kG+PQHf57BSwX9aKwJ88Z4juqkvucoGbOYMCk6rdQirk0mZ
	zH6H2RVjuin+MPc6uQZp6h27RdQP/qhVp51e7jYuqoiGeadnvq3G3oGDWU8c+s9cXOJUxa
	52YA+PPbVknHIWdNkr5lAwETDbHUlZ4RCfwPaSYPwXJ/0e7Et3ELV//y4UZ49o+E5K7Z7U
	suyKiDhQG9sSego8uOe9iraDn+VifbKGe8M06y8Ouz1ZKyoU6D01FM2uiSgTeQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [dovetail 6.1.y-cip][PATCH] arm64: fpsimd: dovetail: Use
 __fpsimd_save in irqs-off section
In-Reply-To: <87b4abde-7131-4590-a4ce-39358a853752@siemens.com> (Jan Kiszka's
	message of "Thu, 30 Oct 2025 12:22:24 +0100")
References: <87b4abde-7131-4590-a4ce-39358a853752@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 30 Oct 2025 13:05:52 +0100
Message-ID: <875xbwwq5b.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeiheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> get_cpu_fpsimd_context already disables hard-interrupts for us.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm64/kernel/fpsimd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 06e981edf3fec..0b5c2af07d82a 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1954,7 +1954,7 @@ void fpsimd_save_and_flush_cpu_state(void)
>  		return;
>  	WARN_ON(preemptible());
>  	get_cpu_fpsimd_context(flags);
> -	fpsimd_save();
> +	__fpsimd_save();
>  	fpsimd_flush_cpu_state();
>  	put_cpu_fpsimd_context(flags);
>  }

Merged, thanks.

-- 
Philippe.
