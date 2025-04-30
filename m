Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574B1199FA2
	for <xenomai@lists.linux.dev>; Wed, 30 Apr 2025 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024959; cv=none; b=qJq/nYbDfv4UEyfFquchIWmPDrcdcOBVOI43NuJ2lelX00PlTto0ranmodUcg4Se36/dtAUdwqqCZgZp/IuvcEVLN2bB7RRwhAPZlmJqrtOA7Oyis6rYKiXcpDEm6NG4jz8166799DfCpPLjk9X0CU4eg4YeQXGbcNkmk3LzFpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024959; c=relaxed/simple;
	bh=09oHfzQme1XVFYoFrIgRQ0W3IkPSq10xFqoRfPMp7dU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rIQEqCHEzp3qDH+sfI/jhJbab0E923rnYFZEMTYVn22a/laDrKFHZrbnw5H0RHYds9BjbS5qs7pjNOkcnKhiQB+amEQudOXaFJu4JwGKLKi/2PDVyCGH5z8pZ/QYLC5earu2sfRpYiqNbi2GSVYdHldQsMDEws+rkvQlRhGVtYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=pKXoQKKP; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="pKXoQKKP"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52EE71FCE8;
	Wed, 30 Apr 2025 14:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1746024954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+VuO3QD/FBX5IEsYBwkwH6Q5yQIoQs1dzJxmFVikaQ=;
	b=pKXoQKKP6Ke2vgKhP1N08InRS5cqc+r5BSNBX7LaxhMnFdD/unhvetRz9AgU2Ic7UG184+
	DSuh4Kd7qXDnIwNS2sN+gLzLtK4v4mz2ZGTJGDIBx1fT/l4ajYLQnbR/xPVeH2WZnKkGvH
	NdF/ss0p79b+6r/6LnNubnrQ2Ta8wX3WUHUf+2kZQEREpiZYSS287zs3ZCLtb4Xewg9wh0
	pcOh/Rg1gqSxQ4SuQGBbeePa8EhFdAttKCcndpVyNy/vBeJpuU3TV5WYcdaBPBxD23EeSy
	e9N5gK4hAH6829OybTvAed0qXgdz5iI4gahIBE/7FFPsFcHAdylOmft52daXbg==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev,  Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: Re: [PATCH][Dovetail] fix IRQ forwarding to the in-band stage
In-Reply-To: <645bc7bc-9c4d-475c-9596-2f5813e23689@siemens.com> (Jan Kiszka's
	message of "Wed, 30 Apr 2025 16:14:48 +0200")
References: <87plgtg3r9.fsf@xenomai.org>
	<645bc7bc-9c4d-475c-9596-2f5813e23689@siemens.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 30 Apr 2025 16:55:53 +0200
Message-ID: <87jz71g0li.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeileelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 30.04.25 15:47, Philippe Gerum wrote:
>> 
>> Could some (preferably several) people check the patch below for
>> non-regression specifically on x86 with stacked irqchips? I ran into
>> an issue with interrupt forwarding while working on the xenomai4
>> netstack which that patch addresses. So far, so good here, but we need
>> more eyeballs and tests for this patch on a tricky and critical piece of
>> code.
>> 
>> This patch is against the Dovetail tree for 6.1.y-cip, also available
>> from [1].
>
> Does it apply to more trees than 6.1? We could push that through
> smoke-testing CI, but I suppose we also need "real" workload.
>

This should apply to any version, this is generic pipeline code in
essence. Typically, edge-triggered IRQs are involved in this, so yes,
some workload with MSI-X events over multiple CPUs would do for
instance. Sustained ethernet I/O comes to mind (I stumbled over the
issue when working on enabling the IGB driver for out-of-band I/O).

-- 
Philippe.
