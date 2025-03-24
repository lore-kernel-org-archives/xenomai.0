Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B942125DAF0
	for <xenomai@lists.linux.dev>; Mon, 24 Mar 2025 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825998; cv=none; b=Ru9a4Cfu0nSD1IsWn5F20nV0PRFOhSiyqZ0AUtLwqbykaEUr0UTbYK9RVSI1ixat/Cqjg6k8Ly53hhUVMLcKNC+7lLwrR0Drj13wal7BuMjG0vh1zVdeKQMzNy1I/2t3xxmmh877g3WkyBlWWqwYvLNF1AcOlMqXWbhX81Wvs3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825998; c=relaxed/simple;
	bh=E+09oIW6n8seixE/fVFmfIto9fX2393MepmJ9Q8uG8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tonJEd/wRMnoEcQc9NvyOJXkfBYWKoDdNm2jcELEhBm5bt+oBFoo0OQP8geIQrwyZyzpClM1lsBmPBlu9k0yi1jIp0Q9JNPFug9QTUVJ9tAkGq/9KhlIk5UT+3bVTmQHkSNonMvLrLD9O35HN/J/GfJY1naeoD3Z61IPjiZEIK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=jQ1gg1zZ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="jQ1gg1zZ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C97A144140;
	Mon, 24 Mar 2025 14:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1742825988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dmNpNQUQmjX9iLyjH7wuuwU2C5GerTjUqH0EptCg5jI=;
	b=jQ1gg1zZ375Z92D/zoo7yPgIpu9W3x5MSQroyXepa+PKgllKBqiSMoVcBXOCCC6XE7EpQK
	tvduQ4kXxxRr6giSuyVd9V9+z4lhnrsfbDqaXyb4dnc6/A0OIlYc6objqqAxzdOQg6wBMW
	oKdslAFkRvJIJLfjwKtu18omKGP0T8SuVSvXcW8Qu+hPPq7/5aXBBKambTMFhSijPGUwAo
	Totecu/1Df6Kruxm8Ffv7Wfn0sNsuKQ+U+ZHhupuMqmgzREIYMZYHH7bucNeLJGv0zT/Lm
	rggjgR00bGHpMR6hZBgoyavP5EAeVaxkAS3A7GPHWLAHNzgNZJyaa8Du0gEPnw==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH] dovetail: Fix interrupt re-enabling after hibernation
In-Reply-To: <6523189779e8b26ef3f8829de0835b1bbeab8b1c.camel@siemens.com>
	(Florian Bezdeka's message of "Mon, 24 Mar 2025 12:18:57 +0100")
References: <68cf84b9-57bc-4a6c-9546-101a13c7acc4@siemens.com>
	<6523189779e8b26ef3f8829de0835b1bbeab8b1c.camel@siemens.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 24 Mar 2025 15:19:43 +0100
Message-ID: <87ikny7bpc.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Thu, 2025-03-20 at 17:41 +0100, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> 
>> We had unbalanced hard_cond_local_irq_disable here so far.
>> 
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> 
>> Minus one hunk that is already in current 6.12.y, this needs to be 
>> applied to older stable versions as well.
>> 
>>  kernel/power/hibernate.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>> index 733b1a196f09e..e1c05f276a453 100644
>> --- a/kernel/power/hibernate.c
>> +++ b/kernel/power/hibernate.c
>> @@ -352,6 +352,7 @@ static int create_image(int platform_mode)
>>  	syscore_resume();
>>  
>>   Enable_irqs:
>> +	hard_cond_local_irq_enable();
>>  	system_state = SYSTEM_RUNNING;
>>  	local_irq_enable();
>
> General question about ordering here:
>
> The order hard_cond_local_irq_enable() followed by local_irq_enable()
> seems wrong to me. We enable hard irqs first, then we unstall the
> inband stage.
>
> That means that an hard irq might arrive and will end up in the IRQ
> log, which is not processed by local_irq_enable(), so we are delaying
> the IRQ processing to an unknown later time.
>

We are not delaying any IRQ, the implementation would just log any
incoming IRQ into the log, until __inband_irq_enable() eventually
disables them the hard way to check the log content, calling
sync_current_irq_stage() if any is to be played back.

> The other way around would make more sense to me. Is my understanding
> right?
>

Nope. The proper ordering is _always_ hard_local_irq_enable() _then_
local_irq_enable. There is also an historical reason for this (see
comment in inband_irq_enable()).

-- 
Philippe.
