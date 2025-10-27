Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216E530C609
	for <xenomai@lists.linux.dev>; Mon, 27 Oct 2025 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581247; cv=none; b=hu4bj5EtPJAsYegmkOAIFBP8Gd03x9VbatnyJZRIFPUHKGey0AadlSyskPTR9pH8s/il+Q7rvjJ7+NAnrVszIP/7/r6mtpdYuImLhLLL4vRzPIMvYiQX0T0df5SDWom8Cza2Cw6hOtdKOaPisjHugjPaq9dTU6n2M21GUQn2+nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581247; c=relaxed/simple;
	bh=6CqcyJG0fgmz2vq7Zxhs2HES+oPjEYuz5ij0mwc/mLI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n6TdQY9aq7VtijAe6AsNWq6ToyX1S/dxcCd4Mm6BE2srv4ArGsfMBgxa3Bp2vTlyS/0MpeRxWe5EZUuDWaW7+BuBkr55b1cizRwTNeFytSgHFJrR5MZhoMxPvRPP7YA3RWSShCreCydLX57hbiP/hn3C7c46FAvHMID7vJdo1Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=GjLqErNX; arc=none smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="GjLqErNX"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 2018F43AEC
	for <xenomai@lists.linux.dev>; Mon, 27 Oct 2025 16:07:23 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 98889D801B1
	for <xenomai@xenomai.org>; Mon, 27 Oct 2025 16:07:22 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5290D443D2;
	Mon, 27 Oct 2025 16:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1761581242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOJ3Kbb+2tf600fWXNDljv+0XZ6kzM/15NZsiLK54bo=;
	b=GjLqErNXv/OvepackXQZumkHtmrl4hDyfaHaCcFFN1R7cOKzb2F3nVX0eeVAuoGd9k65tL
	WquWWEF1BSsIBUQHrjmYnB0jGaljDd6AEZ14NavN1ZvWqj/mQ4Wj5JrUijQkW5okubiAJi
	cSQ0UBpX1O6A+DmeSuMOKpJhjWjOCNsbI6Bl/7sgOnegHpnKkVcX2MWk7CjZlS/2xdRInN
	GWxQ5tyaS4bv6Vgx9X7mWmfpoEr90B467roK50wM9f6/KhDDqA46ZV3qbV7g5849WlJQUW
	vY5O76pQADHLx8BWo9A0d3rEaMIagkkrq1jhbvHB0IYrjHNali05KDRNTMauQQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org
Subject: Re: [dovetail 6.1.y-cip][PATCH 2/3] arm64: fpsimd: dovetail: drop
 redundant hard irqs disabling
In-Reply-To: <0f63813f-d16f-444e-8efd-7b1c4598cf7a@siemens.com> (Jan Kiszka's
	message of "Mon, 27 Oct 2025 17:01:19 +0100")
References: <cover.1758264904.git.jan.kiszka@siemens.com>
	<69e5ff8590d101d24ace2e6708196af7a2ead2f8.1758264904.git.jan.kiszka@siemens.com>
	<0f63813f-d16f-444e-8efd-7b1c4598cf7a@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 27 Oct 2025 17:07:21 +0100
Message-ID: <87qzuo5nwm.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekgeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghiseigvghnohhmrghirdhorhhgpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=GjLqErNX;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 2001:4b98:dc4:8::224 as permitted sender) smtp.mailfrom=rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekgeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvddujedrjedtrddujeekrddvudegpddvtddtudemgegsleekmegutgegmeekmeemvddvgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvddugedphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 19.09.25 08:55, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> 
>> fpsimd_save_and_flush_cpu_state() itself does take care of this.
>> 
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  arch/arm64/kernel/fpsimd.c | 4 ----
>>  1 file changed, 4 deletions(-)
>> 
>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> index ba804fcdfdb3f..f915706332191 100644
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -2148,13 +2148,9 @@ void __efi_fpsimd_end(void)
>>  static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
>>  				  unsigned long cmd, void *v)
>>  {
>> -	unsigned long flags;
>> -
>>  	switch (cmd) {
>>  	case CPU_PM_ENTER:
>> -		flags = hard_cond_local_irq_save();
>>  		fpsimd_save_and_flush_cpu_state();
>> -		hard_cond_local_irq_restore(flags);
>>  		break;
>>  	case CPU_PM_EXIT:
>>  		break;
>
> And this one for 6.1 should also be merged. The changes in patch 1 and 3
> found their way into v6.1.y-cip-dovetail-rebase in the meantime, as it
> looks like.
>
> BTW, a new release for 6.1 would be good as well then, to get all of
> this tagged.
>

There is a set of fixes for the oob network stack coming shortly, rebase
over stable is planned right after (Wednesday).

-- 
Philippe.
