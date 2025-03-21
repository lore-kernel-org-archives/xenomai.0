Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E47726ACB
	for <xenomai@lists.linux.dev>; Fri, 21 Mar 2025 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742543497; cv=none; b=qcrSXKzcW1JxNPtFGOanHyn7FqSqHy8ztzU6PYwePldDhtRwRaA5F/C9jcGwU54mCssDVyO1Ry2FRtoTT/zl7lkGU8iAyshDMr3PEibl25lmNsA1wjFB7qtfp71PwXZqUwPJfJ+xouQl+nMzGfgWkUNGhhHhochknbgijz7W0RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742543497; c=relaxed/simple;
	bh=GrM0Jvf+v8TizDHsGNkc0+21fK7S++dP0UzB1MpT2jc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MGCAXf/oLilFJQQUg/0nRWzH6bWEkOErqf2JKoMIGCWGcImH8ifklk2Lxr/Rj+9tAc59LBIoGesrpkVqJPGbfKqEcKmjUHvjeIjuIG6FJoxwoM+m5hpewZTBNI9LkPeTTrm+wcl1SboQZbHs+DsWiAWdfmatLeLO6sZn/BTHsPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=b9pDd3i8; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="b9pDd3i8"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 04A8320487;
	Fri, 21 Mar 2025 07:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1742543492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KdysfDVa8L7kUBS+hcjejGL6xlAfO5qYVqHu98oJ6Bg=;
	b=b9pDd3i8Hwf2Kuu+6nbGchgnb8pn3KR6ntPfQCjgMBMVTuJI9hTm7+qJJsRwxbQ0gJ83Ug
	OfG8h+jybhDI+Q4EqjnECgV4z3s6D4lZ5C7y2WWOQhLAGBffIrM2Mf5cyzSaKsr4NLWXmU
	PHI14oefwVchxhBXKNLdwCTP+/W0Zg6tsp79m8m9alJlT0cO6X0IlcnCr2e5VRSg2nsEoI
	Q5weqqHYUGLxM9BuIo5X046kSTKzjSVQfRueVvk/FoXqqPhQzDyt3qnEGI/wUa21gzQdPU
	SQuoCoSGWf434clJNaCBczbpZGQW8bLcuQblTMuTAEQVVI+Dw0FBo/5E6ASlYA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  Xenomai
 <xenomai@lists.linux.dev>
Subject: Re: [PATCH] dovetail: Fix interrupt re-enabling after hibernation
In-Reply-To: <68cf84b9-57bc-4a6c-9546-101a13c7acc4@siemens.com> (Jan Kiszka's
	message of "Thu, 20 Mar 2025 17:41:28 +0100")
References: <68cf84b9-57bc-4a6c-9546-101a13c7acc4@siemens.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 21 Mar 2025 08:51:27 +0100
Message-ID: <87r02qlt34.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedtheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> We had unbalanced hard_cond_local_irq_disable here so far.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Minus one hunk that is already in current 6.12.y, this needs to be 
> applied to older stable versions as well.
>
>  kernel/power/hibernate.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 733b1a196f09e..e1c05f276a453 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -352,6 +352,7 @@ static int create_image(int platform_mode)
>  	syscore_resume();
>  
>   Enable_irqs:
> +	hard_cond_local_irq_enable();
>  	system_state = SYSTEM_RUNNING;
>  	local_irq_enable();
>  
> @@ -522,6 +523,7 @@ static int resume_target_kernel(bool platform_mode)
>  	syscore_resume();
>  
>   Enable_irqs:
> +	hard_cond_local_irq_enable();
>  	system_state = SYSTEM_RUNNING;
>  	local_irq_enable();
>  
> @@ -628,6 +630,7 @@ int hibernation_platform_enter(void)
>   Power_up:
>  	syscore_resume();
>   Enable_irqs:
> +	hard_cond_local_irq_enable();
>  	system_state = SYSTEM_RUNNING;
>  	local_irq_enable();

Merged into v6.12 and backported to v6.1.y-cip, thanks.

-- 
Philippe.
